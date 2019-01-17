Return-Path: <SRS0=9u5Z=PZ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAD0C43444
	for <linux-mips@archiver.kernel.org>; Thu, 17 Jan 2019 10:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F54520855
	for <linux-mips@archiver.kernel.org>; Thu, 17 Jan 2019 10:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfAQKFS (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:05:18 -0500
Received: from mail.bootlin.com ([62.4.15.54]:60562 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727882AbfAQKFJ (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Thu, 17 Jan 2019 05:05:09 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 40E4A20A7D; Thu, 17 Jan 2019 11:05:04 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id 01CD1206DC;
        Thu, 17 Jan 2019 11:05:03 +0100 (CET)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, alexandre.belloni@bootlin.com,
        UNGLinuxDriver@microchip.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-mips@vger.kernel.org,
        thomas.petazzoni@bootlin.com, quentin.schulz@bootlin.com,
        allan.nielsen@microchip.com
Subject: [PATCH net-next 8/8] net: mscc: PTP offloading support
Date:   Thu, 17 Jan 2019 11:02:12 +0100
Message-Id: <20190117100212.2336-9-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190117100212.2336-1-antoine.tenart@bootlin.com>
References: <20190117100212.2336-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

This patch adds support for offloading PTP timestamping to the Ocelot
switch for both 1-step and 2-step modes.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/mscc/ocelot.c       | 509 ++++++++++++++++++++++-
 drivers/net/ethernet/mscc/ocelot.h       |  36 ++
 drivers/net/ethernet/mscc/ocelot_board.c | 106 ++++-
 3 files changed, 643 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index 215a45374d7b..ed84c18adcfe 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/phy.h>
+#include <linux/ptp_clock_kernel.h>
 #include <linux/skbuff.h>
 #include <linux/iopoll.h>
 #include <net/arp.h>
@@ -530,7 +531,7 @@ static int ocelot_port_stop(struct net_device *dev)
  */
 static int ocelot_gen_ifh(u32 *ifh, struct frame_info *info)
 {
-	ifh[0] = IFH_INJ_BYPASS;
+	ifh[0] = IFH_INJ_BYPASS | ((0x1ff & info->rew_op) << 21);
 	ifh[1] = (0xf00 & info->port) >> 8;
 	ifh[2] = (0xff & info->port) << 24;
 	ifh[3] = (info->tag_type << 16) | info->vid;
@@ -542,6 +543,7 @@ static int ocelot_port_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct ocelot_port *port = netdev_priv(dev);
 	struct ocelot *ocelot = port->ocelot;
+	struct skb_shared_info *shinfo = skb_shinfo(skb);
 	u32 val, ifh[IFH_LEN];
 	struct frame_info info = {};
 	u8 grp = 0; /* Send everything on CPU group 0 */
@@ -558,6 +560,14 @@ static int ocelot_port_xmit(struct sk_buff *skb, struct net_device *dev)
 	info.port = BIT(port->chip_port);
 	info.tag_type = IFH_TAG_TYPE_C;
 	info.vid = skb_vlan_tag_get(skb);
+
+	/* Check if timestamping is needed */
+	if (ocelot->ptp && shinfo->tx_flags & SKBTX_HW_TSTAMP) {
+		info.rew_op = port->ptp_cmd;
+		if (port->ptp_cmd == IFH_REW_OP_TWO_STEP_PTP)
+			info.rew_op |= (port->ts_id  % 4) << 3;
+	}
+
 	ocelot_gen_ifh(ifh, &info);
 
 	for (i = 0; i < IFH_LEN; i++)
@@ -588,11 +598,44 @@ static int ocelot_port_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	dev->stats.tx_packets++;
 	dev->stats.tx_bytes += skb->len;
-	dev_kfree_skb_any(skb);
+
+	if (ocelot->ptp && shinfo->tx_flags & SKBTX_HW_TSTAMP &&
+	    port->ptp_cmd == IFH_REW_OP_TWO_STEP_PTP) {
+		struct ocelot_skb *oskb =
+			devm_kzalloc(ocelot->dev, sizeof(struct ocelot_skb),
+				     GFP_KERNEL);
+
+		oskb->skb = skb;
+		oskb->id = port->ts_id % 4;
+		port->ts_id++;
+
+		list_add_tail(&oskb->head, &port->skbs);
+	} else {
+		dev_kfree_skb_any(skb);
+	}
 
 	return NETDEV_TX_OK;
 }
 
+void ocelot_get_hwtimestamp(struct ocelot *ocelot, struct timespec64 *ts)
+{
+	/* Read current PTP time to get seconds */
+	u32 val = ocelot_read_rix(ocelot, PTP_PIN_CFG, TOD_ACC_PIN);
+
+	val &= ~(PTP_PIN_CFG_SYNC | PTP_PIN_CFG_ACTION_MASK | PTP_PIN_CFG_DOM);
+	val |= PTP_PIN_CFG_ACTION(PTP_PIN_ACTION_SAVE);
+	ocelot_write_rix(ocelot, val, PTP_PIN_CFG, TOD_ACC_PIN);
+	ts->tv_sec = ocelot_read_rix(ocelot, PTP_PIN_TOD_SEC_LSB, TOD_ACC_PIN);
+
+	/* Read packet HW timestamp from FIFO */
+	val = ocelot_read(ocelot, SYS_PTP_TXSTAMP);
+	ts->tv_nsec = SYS_PTP_TXSTAMP_PTP_TXSTAMP(val);
+
+	/* Sec has incremented since the ts was registered */
+	if ((ts->tv_sec & 0x1) != !!(val & SYS_PTP_TXSTAMP_PTP_TXSTAMP_SEC))
+		ts->tv_sec--;
+}
+
 static void ocelot_mact_mc_reset(struct ocelot_port *port)
 {
 	struct ocelot *ocelot = port->ocelot;
@@ -915,6 +958,262 @@ static int ocelot_set_features(struct net_device *dev,
 	return 0;
 }
 
+static void ocelot_vcap_is2_cmd(struct ocelot *ocelot, u8 addr,
+				enum vcap_cmds cmd, enum vcap_selector sel)
+{
+	u32 val = VCAP_UPDATE_CTRL_UPDATE_CMD(cmd) |
+		  VCAP_UPDATE_CTRL_UPDATE_ADDR(addr) |
+		  VCAP_UPDATE_CTRL_UPDATE_SHOT;
+
+	/* Select the destination/origin */
+	if (!(sel & VCAP_SEL_COUNTER))
+		val |= VCAP_UPDATE_CTRL_UPDATE_COUNTER_DIS;
+	if (!(sel & VCAP_SEL_ACTION))
+		val |= VCAP_UPDATE_CTRL_UPDATE_ACTION_DIS;
+	if (!(sel & VCAP_SEL_ENTRY))
+		val |= VCAP_UPDATE_CTRL_UPDATE_ENTRY_DIS;
+
+	ocelot_write(ocelot, val, VCAP_UPDATE_CTRL);
+
+	/* wait for the command to complete */
+	do {
+		val = ocelot_read(ocelot, VCAP_UPDATE_CTRL);
+	} while (val & VCAP_UPDATE_CTRL_UPDATE_SHOT);
+}
+
+static void ocelot_vcap_entry_to_cache(struct ocelot *ocelot,
+				       struct vcap_data *data)
+{
+	int i;
+
+	for (i = 0; i < 12; i++) {
+		ocelot_write(ocelot, data->entry[i],
+			     VCAP_UPDATE_CTRL_ENTRY_DATA + i * sizeof(u32));
+		ocelot_write(ocelot, ~data->mask[i],
+			     VCAP_UPDATE_CTRL_MASK_DATA + i * sizeof(u32));
+	}
+
+	ocelot_write(ocelot, data->type_group, VCAP_CACHE_DATA_TYPE);
+}
+
+static void ocelot_vcap_action_to_cache(struct ocelot *ocelot,
+					struct vcap_data *data)
+{
+	int i;
+
+	/* Encode the type */
+	data->action[0] &= ~BIT(0);
+
+	for (i = 0; i < 4; i++)
+		ocelot_write(ocelot, data->action[i],
+			     VCAP_UPDATE_CTRL_ACTION_DATA + i * sizeof(u32));
+
+	ocelot_write(ocelot, data->counter, VCAP_UPDATE_CTRL_COUNTER_DATA);
+}
+
+static void ocelot_vcap_is2_init(struct ocelot *ocelot)
+{
+	struct vcap_data data;
+	int port;
+
+	mutex_init(&ocelot->ptp_lock);
+
+	memset(&data, 0, sizeof(data));
+
+	/* Initialize entries */
+	ocelot_vcap_entry_to_cache(ocelot, &data);
+	ocelot_write(ocelot, 64 /* entry count */, VCAP_UPDATE_CTRL_MV_CFG);
+	ocelot_vcap_is2_cmd(ocelot, 0, VCAP_CMD_INIT, VCAP_SEL_ENTRY);
+
+	/* Initialize actions */
+	ocelot_vcap_action_to_cache(ocelot, &data);
+	ocelot_write(ocelot, 64 + ocelot->num_phys_ports + 2 /* action count */,
+		     VCAP_UPDATE_CTRL_MV_CFG);
+	ocelot_vcap_is2_cmd(ocelot, 0, VCAP_CMD_INIT,
+			    VCAP_SEL_ACTION | VCAP_SEL_COUNTER);
+
+	/* Enable the IS2 engine */
+	for (port = 0; port < ocelot->num_phys_ports; port++) {
+		ocelot_write_gix(ocelot, ANA_PORT_VCAP_S2_CFG_S2_ENA |
+					 ANA_PORT_VCAP_S2_CFG_S2_IP6_CFG(0xa),
+				 ANA_PORT_VCAP_S2_CFG, port);
+		ocelot_write_gix(ocelot, 0, ANA_PORT_PTP_CFG, port);
+	}
+}
+
+static void ocelot_vcap_is2_set(struct ocelot *ocelot, u8 addr,
+				struct vcap_data *data)
+{
+	ocelot_vcap_entry_to_cache(ocelot, data);
+	ocelot_vcap_action_to_cache(ocelot, data);
+	ocelot_vcap_is2_cmd(ocelot, addr, VCAP_CMD_WRITE,
+			    VCAP_SEL_ENTRY | VCAP_SEL_ACTION | VCAP_SEL_COUNTER);
+}
+
+static inline void ocelot_set_bits(u32 *data, u32 offset, u32 mask, u32 val)
+{
+	u32 word_off = offset / 32, bit_off = offset % 32;
+
+	data[word_off] &= ~(mask << bit_off);
+	data[word_off] |= val << bit_off;
+	if (get_bitmask_order(mask) > (32 - bit_off)) {
+		data[word_off + 1] &= ~(mask >> (32 - bit_off));
+		data[word_off + 1] |= val >> (32 - bit_off);
+	}
+}
+
+static void ocelot_vcap_is2_set_lookup(struct vcap_data *data, u32 offset,
+				       u32 mask, u32 val)
+{
+	ocelot_set_bits(data->entry, offset, mask, val);
+	ocelot_set_bits(data->mask, offset, mask, mask);
+}
+
+static void ocelot_vcap_is2_set_action(struct vcap_data *data, u32 offset,
+				       u32 mask, u32 val)
+{
+	ocelot_set_bits(data->action, offset, mask, val);
+}
+
+static int ocelot_hwstamp_get(struct ocelot_port *port, struct ifreq *ifr)
+{
+	struct ocelot *ocelot = port->ocelot;
+
+	return copy_to_user(ifr->ifr_data, &ocelot->hwtstamp_config,
+			    sizeof(ocelot->hwtstamp_config)) ? -EFAULT : 0;
+}
+
+static int ocelot_hwstamp_set(struct ocelot_port *port, struct ifreq *ifr)
+{
+	struct ocelot *ocelot = port->ocelot;
+	struct hwtstamp_config cfg;
+	struct vcap_data data;
+	int base = port->chip_port * VCAP_IS2_N_PTP_ENTRIES;
+	u32 ptp_op = VCAP_IS2_ACT_REW_OP_PTP_ONE;
+
+	if (copy_from_user(&cfg, ifr->ifr_data, sizeof(cfg)))
+		return -EFAULT;
+
+	/* reserved for future extensions */
+	if (cfg.flags)
+		return -EINVAL;
+
+	/* Tx type sanity check */
+	switch (cfg.tx_type) {
+	case HWTSTAMP_TX_ON:
+		port->ptp_cmd = IFH_REW_OP_TWO_STEP_PTP;
+		break;
+	case HWTSTAMP_TX_ONESTEP_SYNC:
+		/* IFH_REW_OP_ONE_STEP_PTP updates the correctional field, we
+		 * need to update the origin time.
+		 */
+		port->ptp_cmd = IFH_REW_OP_ORIGIN_PTP;
+		break;
+	case HWTSTAMP_TX_OFF:
+		port->ptp_cmd = 0;
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	mutex_lock(&ocelot->ptp_lock);
+
+	/* Prepare the VCAP PTP entry */
+	memset(&data, 0, sizeof(data));
+
+	switch (cfg.rx_filter) {
+	case HWTSTAMP_FILTER_NONE:
+		ptp_op = VCAP_IS2_ACT_REW_OP_NOOP;
+		break;
+	case HWTSTAMP_FILTER_ALL:
+	case HWTSTAMP_FILTER_SOME:
+	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
+	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
+	case HWTSTAMP_FILTER_NTP_ALL:
+	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
+		cfg.rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
+		break;
+	default:
+		mutex_unlock(&ocelot->ptp_lock);
+		return -ERANGE;
+	}
+
+	/* Set the PTP action */
+	ocelot_vcap_is2_set_action(&data, VCAP_IS2_ACT_REW_OP,
+				   VCAP_IS2_ACT_REW_OP_M, ptp_op);
+
+	data.type_group = 2;
+
+	/* Port mask */
+	ocelot_vcap_is2_set_lookup(&data, VCAP_IS2_LKP_INGRESS_PORT_MASK,
+				   VCAP_IS2_LKP_INGRESS_PORT_MASK_M, 0x7ff);
+
+	/* Commit the PTP VCAP entries:
+	 *
+	 * - One entry for PTP over Ethernet (etype 0x88f7).
+	 * - One entry for PTP over IPv4/v6 UDP dst port 319.
+	 * - One entry for PTP over IPv4/v6 UDP dst port 320.
+	 */
+
+	/* PTP over Ethernet */
+	ocelot_vcap_is2_set_lookup(&data, VCAP_IS2_LKP_TYPE,
+				   VCAP_IS2_LKP_TYPE_M,
+				   VCAP_IS2_LKP_TYPE_MAC_ETYPE);
+	ocelot_vcap_is2_set_lookup(&data, VCAP_IS2_LKP_ETYPE,
+				   VCAP_IS2_LKP_ETYPE_M, 0x88f7);
+	ocelot_vcap_is2_set(ocelot, base++, &data);
+
+	/* PTP over IPv4/v6 UDP dst port 319 */
+	ocelot_vcap_is2_set_lookup(&data, VCAP_IS2_LKP_TYPE,
+				   VCAP_IS2_LKP_TYPE_M,
+				   VCAP_IS2_LKP_TYPE_TCP_UDP);
+	ocelot_vcap_is2_set_lookup(&data, VCAP_IS2_LKP_DPORT,
+				   VCAP_IS2_LKP_DPORT_M, 319);
+	ocelot_vcap_is2_set(ocelot, base++, &data);
+
+	/* PTP over IPv4/v6 UDP dst port 320 */
+	ocelot_vcap_is2_set_lookup(&data, VCAP_IS2_LKP_TYPE,
+				   VCAP_IS2_LKP_TYPE_M,
+				   VCAP_IS2_LKP_TYPE_TCP_UDP);
+	ocelot_vcap_is2_set_lookup(&data, VCAP_IS2_LKP_DPORT,
+				   VCAP_IS2_LKP_DPORT_M, 320);
+	ocelot_vcap_is2_set(ocelot, base++, &data);
+
+	/* Commit back the result & save it */
+	memcpy(&ocelot->hwtstamp_config, &cfg, sizeof(cfg));
+	mutex_unlock(&ocelot->ptp_lock);
+
+	return copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
+}
+
+static int ocelot_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
+{
+	struct ocelot_port *port = netdev_priv(dev);
+	struct ocelot *ocelot = port->ocelot;
+
+	/* The function is only used for PTP operations for now */
+	if (!ocelot->ptp)
+		return -EOPNOTSUPP;
+
+	switch (cmd) {
+	case SIOCSHWTSTAMP:
+		return ocelot_hwstamp_set(port, ifr);
+	case SIOCGHWTSTAMP:
+		return ocelot_hwstamp_get(port, ifr);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static const struct net_device_ops ocelot_port_netdev_ops = {
 	.ndo_open			= ocelot_port_open,
 	.ndo_stop			= ocelot_port_stop,
@@ -929,6 +1228,7 @@ static const struct net_device_ops ocelot_port_netdev_ops = {
 	.ndo_vlan_rx_add_vid		= ocelot_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid		= ocelot_vlan_rx_kill_vid,
 	.ndo_set_features		= ocelot_set_features,
+	.ndo_do_ioctl			= ocelot_ioctl,
 };
 
 static void ocelot_get_strings(struct net_device *netdev, u32 sset, u8 *data)
@@ -1004,12 +1304,42 @@ static int ocelot_get_sset_count(struct net_device *dev, int sset)
 	return ocelot->num_stats;
 }
 
+static int ocelot_get_ts_info(struct net_device *dev,
+			      struct ethtool_ts_info *info)
+{
+	struct ocelot_port *ocelot_port = netdev_priv(dev);
+	struct ocelot *ocelot = ocelot_port->ocelot;
+	int ret;
+
+	if (!ocelot->ptp)
+		return -EOPNOTSUPP;
+
+	ret = ethtool_op_get_ts_info(dev, info);
+	if (ret)
+		return ret;
+
+	info->phc_index = ocelot->ptp_clock ?
+			  ptp_clock_index(ocelot->ptp_clock) : -1;
+	info->so_timestamping |= SOF_TIMESTAMPING_TX_SOFTWARE |
+				 SOF_TIMESTAMPING_RX_SOFTWARE |
+				 SOF_TIMESTAMPING_SOFTWARE |
+				 SOF_TIMESTAMPING_TX_HARDWARE |
+				 SOF_TIMESTAMPING_RX_HARDWARE |
+				 SOF_TIMESTAMPING_RAW_HARDWARE;
+	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON) |
+			 BIT(HWTSTAMP_TX_ONESTEP_SYNC);
+	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) | BIT(HWTSTAMP_FILTER_ALL);
+
+	return 0;
+}
+
 static const struct ethtool_ops ocelot_ethtool_ops = {
 	.get_strings		= ocelot_get_strings,
 	.get_ethtool_stats	= ocelot_get_ethtool_stats,
 	.get_sset_count		= ocelot_get_sset_count,
 	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
 	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
+	.get_ts_info		= ocelot_get_ts_info,
 };
 
 static int ocelot_port_attr_get(struct net_device *dev,
@@ -1616,6 +1946,165 @@ struct notifier_block ocelot_switchdev_blocking_nb __read_mostly = {
 };
 EXPORT_SYMBOL(ocelot_switchdev_blocking_nb);
 
+int ocelot_ptp_gettime64(struct ptp_clock_info *ptp, struct timespec64 *ts)
+{
+	struct ocelot *ocelot = container_of(ptp, struct ocelot, ptp_info);
+	u32 val;
+	time64_t s;
+	s64 ns;
+
+	val = ocelot_read_rix(ocelot, PTP_PIN_CFG, TOD_ACC_PIN);
+	val &= ~(PTP_PIN_CFG_SYNC | PTP_PIN_CFG_ACTION_MASK | PTP_PIN_CFG_DOM);
+	val |= PTP_PIN_CFG_ACTION(PTP_PIN_ACTION_SAVE);
+	ocelot_write_rix(ocelot, val, PTP_PIN_CFG, TOD_ACC_PIN);
+
+	s = ocelot_read_rix(ocelot, PTP_PIN_TOD_SEC_MSB, TOD_ACC_PIN);
+	s += ocelot_read_rix(ocelot, PTP_PIN_TOD_SEC_LSB, TOD_ACC_PIN);
+	ns = ocelot_read_rix(ocelot, PTP_PIN_TOD_NSEC, TOD_ACC_PIN);
+
+	/* Deal with negative values */
+	if (ns >= 0x3ffffff0 && ns <= 0x3fffffff) {
+		s--;
+		ns &= 0xf;
+		ns += 999999984;
+	}
+
+	set_normalized_timespec64(ts, s, ns);
+	return 0;
+}
+
+static int ocelot_ptp_settime64(struct ptp_clock_info *ptp,
+				const struct timespec64 *ts)
+{
+	struct ocelot *ocelot = container_of(ptp, struct ocelot, ptp_info);
+	u32 val;
+
+	val = ocelot_read_rix(ocelot, PTP_PIN_CFG, TOD_ACC_PIN);
+	val &= ~(PTP_PIN_CFG_SYNC | PTP_PIN_CFG_ACTION_MASK | PTP_PIN_CFG_DOM);
+	val |= PTP_PIN_CFG_ACTION(PTP_PIN_ACTION_IDLE);
+
+	ocelot_write_rix(ocelot, val, PTP_PIN_CFG, TOD_ACC_PIN);
+
+	ocelot_write_rix(ocelot, lower_32_bits(ts->tv_sec), PTP_PIN_TOD_SEC_LSB,
+			 TOD_ACC_PIN);
+	ocelot_write_rix(ocelot, upper_32_bits(ts->tv_sec), PTP_PIN_TOD_SEC_MSB,
+			 TOD_ACC_PIN);
+	ocelot_write_rix(ocelot, ts->tv_nsec, PTP_PIN_TOD_NSEC, TOD_ACC_PIN);
+
+	val = ocelot_read_rix(ocelot, PTP_PIN_CFG, TOD_ACC_PIN);
+	val &= ~(PTP_PIN_CFG_SYNC | PTP_PIN_CFG_ACTION_MASK | PTP_PIN_CFG_DOM);
+	val |= PTP_PIN_CFG_ACTION(PTP_PIN_ACTION_LOAD);
+
+	ocelot_write_rix(ocelot, val, PTP_PIN_CFG, TOD_ACC_PIN);
+
+	return 0;
+}
+
+static int ocelot_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
+{
+	if (delta > -(NSEC_PER_SEC / 2) && delta < (NSEC_PER_SEC / 2)) {
+		struct ocelot *ocelot = container_of(ptp, struct ocelot, ptp_info);
+		u32 val;
+
+		val = ocelot_read_rix(ocelot, PTP_PIN_CFG, TOD_ACC_PIN);
+		val &= ~(PTP_PIN_CFG_SYNC | PTP_PIN_CFG_ACTION_MASK | PTP_PIN_CFG_DOM);
+		val |= PTP_PIN_CFG_ACTION(PTP_PIN_ACTION_IDLE);
+
+		ocelot_write_rix(ocelot, val, PTP_PIN_CFG, TOD_ACC_PIN);
+
+		ocelot_write_rix(ocelot, 0, PTP_PIN_TOD_SEC_LSB, TOD_ACC_PIN);
+		ocelot_write_rix(ocelot, 0, PTP_PIN_TOD_SEC_MSB, TOD_ACC_PIN);
+		ocelot_write_rix(ocelot, delta, PTP_PIN_TOD_NSEC, TOD_ACC_PIN);
+
+		val = ocelot_read_rix(ocelot, PTP_PIN_CFG, TOD_ACC_PIN);
+		val &= ~(PTP_PIN_CFG_SYNC | PTP_PIN_CFG_ACTION_MASK | PTP_PIN_CFG_DOM);
+		val |= PTP_PIN_CFG_ACTION(PTP_PIN_ACTION_DELTA);
+
+		ocelot_write_rix(ocelot, val, PTP_PIN_CFG, TOD_ACC_PIN);
+	} else {
+		/* Fall back using ocelot_ptp_settime64 which is not exact. */
+		struct timespec64 ts;
+		u64 now;
+
+		ocelot_ptp_gettime64(ptp, &ts);
+
+		now = ktime_to_ns(timespec64_to_ktime(ts));
+		ts = ns_to_timespec64(now + delta);
+
+		ocelot_ptp_settime64(ptp, &ts);
+	}
+	return 0;
+}
+
+static int ocelot_ptp_adjfreq(struct ptp_clock_info *ptp, s32 ppb)
+{
+	struct ocelot *ocelot = container_of(ptp, struct ocelot, ptp_info);
+	u64 adj = 0;
+	u32 unit = 0, direction = 0;
+
+	if (!ppb)
+		goto disable_adj;
+
+	if (ppb < 0) {
+		direction = PTP_CFG_CLK_ADJ_CFG_DIR;
+		ppb = -ppb;
+	}
+
+	adj = PSEC_PER_SEC;
+	do_div(adj, ppb);
+
+	/* If the adjustment value is too large, use ns instead */
+	if (adj >= (1L << 30)) {
+		unit = PTP_CFG_CLK_ADJ_FREQ_NS;
+		do_div(adj, 1000);
+	}
+
+	/* Still too big */
+	if (adj >= (1L << 30))
+		goto disable_adj;
+
+	ocelot_write(ocelot, unit | adj, PTP_CLK_CFG_ADJ_FREQ);
+	ocelot_write(ocelot, PTP_CFG_CLK_ADJ_CFG_ENA | direction,
+		     PTP_CLK_CFG_ADJ_CFG);
+	return 0;
+
+disable_adj:
+	ocelot_write(ocelot, 0, PTP_CLK_CFG_ADJ_CFG);
+	return 0;
+}
+
+static struct ptp_clock_info ocelot_ptp_clock_info = {
+	.owner		= THIS_MODULE,
+	.name		= "ocelot ptp",
+	.max_adj	= 0x7fffffff,
+	.n_alarm	= 0,
+	.n_ext_ts	= 0,
+	.n_per_out	= 0,
+	.n_pins		= 0,
+	.pps		= 0,
+	.gettime64	= ocelot_ptp_gettime64,
+	.settime64	= ocelot_ptp_settime64,
+	.adjtime	= ocelot_ptp_adjtime,
+	.adjfreq	= ocelot_ptp_adjfreq,
+};
+
+static int ocelot_init_timestamp(struct ocelot *ocelot)
+{
+	ocelot->ptp_info = ocelot_ptp_clock_info;
+
+	ocelot->ptp_clock = ptp_clock_register(&ocelot->ptp_info, ocelot->dev);
+	if (IS_ERR(ocelot->ptp_clock))
+		return PTR_ERR(ocelot->ptp_clock);
+
+	ocelot_write(ocelot, SYS_PTP_CFG_PTP_STAMP_WID(30), SYS_PTP_CFG);
+	ocelot_write(ocelot, 0xffffffff, ANA_TABLES_PTP_ID_LOW);
+	ocelot_write(ocelot, 0xffffffff, ANA_TABLES_PTP_ID_HIGH);
+
+	ocelot_write(ocelot, PTP_CFG_MISC_PTP_EN, PTP_CFG_MISC);
+
+	return 0;
+}
+
 int ocelot_probe_port(struct ocelot *ocelot, u8 port,
 		      void __iomem *regs,
 		      struct phy_device *phy)
@@ -1649,6 +2138,8 @@ int ocelot_probe_port(struct ocelot *ocelot, u8 port,
 	ocelot_mact_learn(ocelot, PGID_CPU, dev->dev_addr, ocelot_port->pvid,
 			  ENTRYTYPE_LOCKED);
 
+	INIT_LIST_HEAD(&ocelot_port->skbs);
+
 	err = register_netdev(dev);
 	if (err) {
 		dev_err(ocelot->dev, "register_netdev failed\n");
@@ -1669,7 +2160,7 @@ EXPORT_SYMBOL(ocelot_probe_port);
 int ocelot_init(struct ocelot *ocelot)
 {
 	u32 port;
-	int i, cpu = ocelot->num_phys_ports;
+	int i, ret, cpu = ocelot->num_phys_ports;
 	char queue_name[32];
 
 	ocelot->lags = devm_kcalloc(ocelot->dev, ocelot->num_phys_ports,
@@ -1796,6 +2287,18 @@ int ocelot_init(struct ocelot *ocelot)
 	INIT_DELAYED_WORK(&ocelot->stats_work, ocelot_check_stats);
 	queue_delayed_work(ocelot->stats_queue, &ocelot->stats_work,
 			   OCELOT_STATS_CHECK_DELAY);
+
+	if (ocelot->ptp) {
+		ret = ocelot_init_timestamp(ocelot);
+		if (ret) {
+			dev_err(ocelot->dev,
+				"Timestamp initialization failed\n");
+			return ret;
+		}
+
+		ocelot_vcap_is2_init(ocelot);
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL(ocelot_init);
diff --git a/drivers/net/ethernet/mscc/ocelot.h b/drivers/net/ethernet/mscc/ocelot.h
index 994ba953d60e..ed1583037dc2 100644
--- a/drivers/net/ethernet/mscc/ocelot.h
+++ b/drivers/net/ethernet/mscc/ocelot.h
@@ -11,9 +11,11 @@
 #include <linux/bitops.h>
 #include <linux/etherdevice.h>
 #include <linux/if_vlan.h>
+#include <linux/net_tstamp.h>
 #include <linux/phy.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/ptp_clock_kernel.h>
 #include <linux/regmap.h>
 
 #include "ocelot_ana.h"
@@ -46,6 +48,8 @@ struct frame_info {
 	u16 port;
 	u16 vid;
 	u8 tag_type;
+	u16 rew_op;
+	u32 timestamp;	/* rew_val */
 };
 
 #define IFH_INJ_BYPASS	BIT(31)
@@ -54,6 +58,12 @@ struct frame_info {
 #define IFH_TAG_TYPE_C 0
 #define IFH_TAG_TYPE_S 1
 
+#define IFH_REW_OP_NOOP			0x0
+#define IFH_REW_OP_DSCP			0x1
+#define IFH_REW_OP_ONE_STEP_PTP		0x2
+#define IFH_REW_OP_TWO_STEP_PTP		0x3
+#define IFH_REW_OP_ORIGIN_PTP		0x5
+
 #define OCELOT_SPEED_2500 0
 #define OCELOT_SPEED_1000 1
 #define OCELOT_SPEED_100  2
@@ -401,6 +411,13 @@ enum ocelot_regfield {
 	REGFIELD_MAX
 };
 
+enum ocelot_clk_pins {
+	ALT_PPS_PIN	= 1,
+	EXT_CLK_PIN,
+	ALT_LDST_PIN,
+	TOD_ACC_PIN
+};
+
 struct ocelot_multicast {
 	struct list_head list;
 	unsigned char addr[ETH_ALEN];
@@ -450,6 +467,12 @@ struct ocelot {
 	u64 *stats;
 	struct delayed_work stats_work;
 	struct workqueue_struct *stats_queue;
+
+	u8 ptp:1;
+	struct ptp_clock *ptp_clock;
+	struct ptp_clock_info ptp_info;
+	struct hwtstamp_config hwtstamp_config;
+	struct mutex ptp_lock;
 };
 
 struct ocelot_port {
@@ -475,6 +498,16 @@ struct ocelot_port {
 
 	phy_interface_t phy_mode;
 	struct phy *serdes;
+
+	u8 ptp_cmd;
+	struct list_head skbs;
+	u8 ts_id;
+};
+
+struct ocelot_skb {
+	struct list_head head;
+	struct sk_buff *skb;
+	u8 id;
 };
 
 u32 __ocelot_read_ix(struct ocelot *ocelot, u32 reg, u32 offset);
@@ -518,4 +551,7 @@ int ocelot_probe_port(struct ocelot *ocelot, u8 port,
 extern struct notifier_block ocelot_netdevice_nb;
 extern struct notifier_block ocelot_switchdev_blocking_nb;
 
+int ocelot_ptp_gettime64(struct ptp_clock_info *ptp, struct timespec64 *ts);
+void ocelot_get_hwtimestamp(struct ocelot *ocelot, struct timespec64 *ts);
+
 #endif
diff --git a/drivers/net/ethernet/mscc/ocelot_board.c b/drivers/net/ethernet/mscc/ocelot_board.c
index e0a3b6f70e8f..d85920c05269 100644
--- a/drivers/net/ethernet/mscc/ocelot_board.c
+++ b/drivers/net/ethernet/mscc/ocelot_board.c
@@ -31,6 +31,8 @@ static int ocelot_parse_ifh(u32 *_ifh, struct frame_info *info)
 
 	info->len = OCELOT_BUFFER_CELL_SZ * wlen + llen - 80;
 
+	info->timestamp = IFH_EXTRACT_BITFIELD64(ifh[0], 21, 32);
+
 	info->port = IFH_EXTRACT_BITFIELD64(ifh[1], 43, 4);
 
 	info->tag_type = IFH_EXTRACT_BITFIELD64(ifh[1], 16,  1);
@@ -98,7 +100,11 @@ static irqreturn_t ocelot_xtr_irq_handler(int irq, void *arg)
 		int sz, len, buf_len;
 		u32 ifh[4];
 		u32 val;
-		struct frame_info info;
+		struct frame_info info = {};
+		struct timespec64 ts;
+		struct skb_shared_hwtstamps *shhwtstamps;
+		u64 tod_in_ns;
+		u64 full_ts_in_ns;
 
 		for (i = 0; i < IFH_LEN; i++) {
 			err = ocelot_rx_frame_word(ocelot, grp, true, &ifh[i]);
@@ -145,6 +151,22 @@ static irqreturn_t ocelot_xtr_irq_handler(int irq, void *arg)
 			break;
 		}
 
+		if (ocelot->ptp) {
+			ocelot_ptp_gettime64(&ocelot->ptp_info, &ts);
+
+			tod_in_ns = ktime_set(ts.tv_sec, ts.tv_nsec);
+			if ((tod_in_ns & 0xffffffff) < info.timestamp)
+				full_ts_in_ns = (((tod_in_ns >> 32) - 1) << 32) |
+						info.timestamp;
+			else
+				full_ts_in_ns = (tod_in_ns & GENMASK_ULL(63, 32)) |
+						info.timestamp;
+
+			shhwtstamps = skb_hwtstamps(skb);
+			memset(shhwtstamps, 0, sizeof(struct skb_shared_hwtstamps));
+			shhwtstamps->hwtstamp = full_ts_in_ns;
+		}
+
 		/* Everything we see on an interface that is in the HW bridge
 		 * has already been forwarded.
 		 */
@@ -164,6 +186,65 @@ static irqreturn_t ocelot_xtr_irq_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t ocelot_ptp_rdy_irq_handler(int irq, void *arg)
+{
+	struct ocelot *ocelot = arg;
+
+	do {
+		struct skb_shared_hwtstamps shhwtstamps;
+		struct list_head *pos, *tmp;
+		struct ocelot_skb *entry;
+		struct ocelot_port *port;
+		struct timespec64 ts;
+		struct sk_buff *skb = NULL;
+		u32 val, id, txport;
+
+		val = ocelot_read(ocelot, SYS_PTP_STATUS);
+
+		/* Check if a timestamp can be retrieved */
+		if (!(val & SYS_PTP_STATUS_PTP_MESS_VLD))
+			break;
+
+		WARN_ON(val & SYS_PTP_STATUS_PTP_OVFL);
+
+		/* Retrieve the ts ID and Tx port */
+		id = SYS_PTP_STATUS_PTP_MESS_ID_X(val);
+		txport = SYS_PTP_STATUS_PTP_MESS_TXPORT_X(val);
+
+		/* Retrieve its associated skb */
+		port = ocelot->ports[txport];
+
+		list_for_each_safe(pos, tmp, &port->skbs) {
+			entry = list_entry(pos, struct ocelot_skb, head);
+			if (entry->id != id)
+				continue;
+
+			skb = entry->skb;
+
+			list_del(pos);
+			devm_kfree(ocelot->dev, entry);
+		}
+
+		/* Next ts */
+		ocelot_write(ocelot, SYS_PTP_NXT_PTP_NXT, SYS_PTP_NXT);
+
+		if (unlikely(!skb))
+			continue;
+
+		/* Get the h/w timestamp */
+		ocelot_get_hwtimestamp(ocelot, &ts);
+
+		/* Set the timestamp into the skb */
+		memset(&shhwtstamps, 0, sizeof(shhwtstamps));
+		shhwtstamps.hwtstamp = ktime_set(ts.tv_sec, ts.tv_nsec);
+		skb_tstamp_tx(skb, &shhwtstamps);
+
+		dev_kfree_skb_any(skb);
+	} while (true);
+
+	return IRQ_HANDLED;
+}
+
 static const struct of_device_id mscc_ocelot_match[] = {
 	{ .compatible = "mscc,vsc7514-switch" },
 	{ }
@@ -172,8 +253,8 @@ MODULE_DEVICE_TABLE(of, mscc_ocelot_match);
 
 static int mscc_ocelot_probe(struct platform_device *pdev)
 {
-	int err, irq;
 	unsigned int i;
+	int err, irq_xtr, irq_ptp_rdy;
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *ports, *portnp;
 	struct ocelot *ocelot;
@@ -232,16 +313,31 @@ static int mscc_ocelot_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	irq = platform_get_irq_byname(pdev, "xtr");
-	if (irq < 0)
+	irq_xtr = platform_get_irq_byname(pdev, "xtr");
+	if (irq_xtr < 0)
 		return -ENODEV;
 
-	err = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+	err = devm_request_threaded_irq(&pdev->dev, irq_xtr, NULL,
 					ocelot_xtr_irq_handler, IRQF_ONESHOT,
 					"frame extraction", ocelot);
 	if (err)
 		return err;
 
+
+	irq_ptp_rdy = platform_get_irq_byname(pdev, "ptp_rdy");
+	if (irq_ptp_rdy > 0) {
+		err = devm_request_threaded_irq(&pdev->dev, irq_ptp_rdy, NULL,
+						ocelot_ptp_rdy_irq_handler,
+						IRQF_ONESHOT, "ptp ready",
+						ocelot);
+		if (err)
+			return err;
+	}
+
+	/* Check if we can support PTP */
+	if (irq_ptp_rdy > 0 && ocelot->targets[PTP] && ocelot->targets[VCAP])
+		ocelot->ptp = 1;
+
 	regmap_field_write(ocelot->regfields[SYS_RESET_CFG_MEM_INIT], 1);
 	regmap_field_write(ocelot->regfields[SYS_RESET_CFG_MEM_ENA], 1);
 
-- 
2.20.1

