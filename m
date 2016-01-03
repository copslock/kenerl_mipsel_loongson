Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Jan 2016 16:29:09 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:45092 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009460AbcACP1Nmq7F7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 3 Jan 2016 16:27:13 +0100
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 42A0728C188;
        Sun,  3 Jan 2016 16:26:34 +0100 (CET)
Received: from localhost.localdomain (p548C9B8E.dip0.t-ipconnect.de [84.140.155.142])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Sun,  3 Jan 2016 16:26:34 +0100 (CET)
From:   John Crispin <blogic@openwrt.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mediatek@lists.infradead.org,
        John Crispin <blogic@openwrt.org>,
        Felix Fietkau <nbd@nbd.name>, Michael Lee <igvtee@gmail.com>,
        =?UTF-8?q?Steven=20Liu=20=28=E5=8A=89=E4=BA=BA=E8=B1=AA=29?= 
        <steven.liu@mediatek.com>,
        =?UTF-8?q?Fred=20Chang=20=28=E5=BC=B5=E5=98=89=E5=AE=8F=29?= 
        <Fred.Chang@mediatek.com>
Subject: [PATCH 09/12] net-next: mediatek: add support for mt7620
Date:   Sun,  3 Jan 2016 16:26:12 +0100
Message-Id: <1451834775-15789-9-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1451834775-15789-1-git-send-email-blogic@openwrt.org>
References: <1451834775-15789-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50828
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Add support for SoCs from the mt7620 family. These all have one dedicated
external gbit port and a builtin 5 port 100mbit switch. Additionally one
of the 5 switch ports can be changed to become an additional gbit port
that we can attach a phy to.

Signed-off-by: John Crispin <blogic@openwrt.org>
Signed-off-by: Felix Fietkau <nbd@openwrt.org>
Signed-off-by: Michael Lee <igvtee@gmail.com>
---
 drivers/net/ethernet/mediatek/mdio_mt7620.c |  156 ++++++++++++++
 drivers/net/ethernet/mediatek/soc_mt7620.c  |  293 +++++++++++++++++++++++++++
 2 files changed, 449 insertions(+)
 create mode 100644 drivers/net/ethernet/mediatek/mdio_mt7620.c
 create mode 100644 drivers/net/ethernet/mediatek/soc_mt7620.c

diff --git a/drivers/net/ethernet/mediatek/mdio_mt7620.c b/drivers/net/ethernet/mediatek/mdio_mt7620.c
new file mode 100644
index 0000000..c3ef147a
--- /dev/null
+++ b/drivers/net/ethernet/mediatek/mdio_mt7620.c
@@ -0,0 +1,156 @@
+/*   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; version 2 of the License
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   Copyright (C) 2009-2015 John Crispin <blogic@openwrt.org>
+ *   Copyright (C) 2009-2015 Felix Fietkau <nbd@openwrt.org>
+ *   Copyright (C) 2013-2015 Michael Lee <igvtee@gmail.com>
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+
+#include "mtk_eth_soc.h"
+#include "gsw_mt7620.h"
+#include "mdio.h"
+
+static int mt7620_mii_busy_wait(struct mt7620_gsw *gsw)
+{
+	unsigned long t_start = jiffies;
+
+	while (1) {
+		if (!(mtk_switch_r32(gsw, MT7620A_GSW_REG_PIAC) &
+				     GSW_MDIO_ACCESS))
+			return 0;
+		if (time_after(jiffies, t_start + GSW_REG_PHY_TIMEOUT))
+			break;
+	}
+
+	dev_err(gsw->dev, "mdio: MDIO timeout\n");
+	return -1;
+}
+
+u32 _mt7620_mii_write(struct mt7620_gsw *gsw, u32 phy_addr,
+		      u32 phy_register, u32 write_data)
+{
+	if (mt7620_mii_busy_wait(gsw))
+		return -1;
+
+	write_data &= 0xffff;
+
+	mtk_switch_w32(gsw, GSW_MDIO_ACCESS | GSW_MDIO_START | GSW_MDIO_WRITE |
+		(phy_register << GSW_MDIO_REG_SHIFT) |
+		(phy_addr << GSW_MDIO_ADDR_SHIFT) | write_data,
+		MT7620A_GSW_REG_PIAC);
+
+	if (mt7620_mii_busy_wait(gsw))
+		return -1;
+
+	return 0;
+}
+
+u32 _mt7620_mii_read(struct mt7620_gsw *gsw, int phy_addr, int phy_reg)
+{
+	u32 d;
+
+	if (mt7620_mii_busy_wait(gsw))
+		return 0xffff;
+
+	mtk_switch_w32(gsw, GSW_MDIO_ACCESS | GSW_MDIO_START | GSW_MDIO_READ |
+		(phy_reg << GSW_MDIO_REG_SHIFT) |
+		(phy_addr << GSW_MDIO_ADDR_SHIFT),
+		MT7620A_GSW_REG_PIAC);
+
+	if (mt7620_mii_busy_wait(gsw))
+		return 0xffff;
+
+	d = mtk_switch_r32(gsw, MT7620A_GSW_REG_PIAC) & 0xffff;
+
+	return d;
+}
+
+int mt7620_mdio_write(struct mii_bus *bus, int phy_addr, int phy_reg, u16 val)
+{
+	struct fe_priv *priv = bus->priv;
+	struct mt7620_gsw *gsw = (struct mt7620_gsw *)priv->soc->swpriv;
+
+	return _mt7620_mii_write(gsw, phy_addr, phy_reg, val);
+}
+
+int mt7620_mdio_read(struct mii_bus *bus, int phy_addr, int phy_reg)
+{
+	struct fe_priv *priv = bus->priv;
+	struct mt7620_gsw *gsw = (struct mt7620_gsw *)priv->soc->swpriv;
+
+	return _mt7620_mii_read(gsw, phy_addr, phy_reg);
+}
+
+void mt7530_mdio_w32(struct mt7620_gsw *gsw, u32 reg, u32 val)
+{
+	_mt7620_mii_write(gsw, 0x1f, 0x1f, (reg >> 6) & 0x3ff);
+	_mt7620_mii_write(gsw, 0x1f, (reg >> 2) & 0xf,  val & 0xffff);
+	_mt7620_mii_write(gsw, 0x1f, 0x10, val >> 16);
+}
+
+u32 mt7530_mdio_r32(struct mt7620_gsw *gsw, u32 reg)
+{
+	u16 high, low;
+
+	_mt7620_mii_write(gsw, 0x1f, 0x1f, (reg >> 6) & 0x3ff);
+	low = _mt7620_mii_read(gsw, 0x1f, (reg >> 2) & 0xf);
+	high = _mt7620_mii_read(gsw, 0x1f, 0x10);
+
+	return (high << 16) | (low & 0xffff);
+}
+
+static unsigned char *fe_speed_str(int speed)
+{
+	switch (speed) {
+	case 2:
+	case SPEED_1000:
+		return "1000";
+	case 1:
+	case SPEED_100:
+		return "100";
+	case 0:
+	case SPEED_10:
+		return "10";
+	}
+
+	return "? ";
+}
+
+int mt7620_has_carrier(struct fe_priv *priv)
+{
+	struct mt7620_gsw *gsw = (struct mt7620_gsw *)priv->soc->swpriv;
+	int i;
+
+	for (i = 0; i < GSW_PORT6; i++)
+		if (mtk_switch_r32(gsw, GSW_REG_PORT_STATUS(i)) & 0x1)
+			return 1;
+	return 0;
+}
+
+void mt7620_print_link_state(struct fe_priv *priv, int port, int link,
+			     int speed, int duplex)
+{
+	if (link)
+		netdev_info(priv->netdev, "port %d link up (%sMbps/%s duplex)\n",
+			    port, fe_speed_str(speed),
+			    (duplex) ? "Full" : "Half");
+	else
+		netdev_info(priv->netdev, "port %d link down\n", port);
+}
+
+void mt7620_mdio_link_adjust(struct fe_priv *priv, int port)
+{
+	mt7620_print_link_state(priv, port, priv->link[port],
+				priv->phy->speed[port],
+				(priv->phy->duplex[port] == DUPLEX_FULL));
+}
diff --git a/drivers/net/ethernet/mediatek/soc_mt7620.c b/drivers/net/ethernet/mediatek/soc_mt7620.c
new file mode 100644
index 0000000..2dcc9c5
--- /dev/null
+++ b/drivers/net/ethernet/mediatek/soc_mt7620.c
@@ -0,0 +1,293 @@
+/*   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; version 2 of the License
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   Copyright (C) 2009-2015 John Crispin <blogic@openwrt.org>
+ *   Copyright (C) 2009-2015 Felix Fietkau <nbd@openwrt.org>
+ *   Copyright (C) 2013-2015 Michael Lee <igvtee@gmail.com>
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/if_vlan.h>
+#include <linux/of_net.h>
+
+#include <asm/mach-ralink/ralink_regs.h>
+
+#include <mt7620.h>
+#include "mtk_eth_soc.h"
+#include "gsw_mt7620.h"
+#include "mdio.h"
+
+#define MT7620A_CDMA_CSG_CFG	0x400
+#define MT7620_DMA_VID		(MT7620A_CDMA_CSG_CFG + 0x30)
+#define MT7620A_RESET_FE	BIT(21)
+#define MT7620A_RESET_ESW	BIT(23)
+#define MT7620_L4_VALID		BIT(23)
+
+#define MT7620_TX_DMA_UDF	BIT(15)
+#define TX_DMA_FP_BMAP		((0xff) << 19)
+
+#define CDMA_ICS_EN		BIT(2)
+#define CDMA_UCS_EN		BIT(1)
+#define CDMA_TCS_EN		BIT(0)
+
+#define GDMA_ICS_EN		BIT(22)
+#define GDMA_TCS_EN		BIT(21)
+#define GDMA_UCS_EN		BIT(20)
+#define	GDMA_FRC_P_MASK		0x07
+
+/* frame engine counters */
+#define MT7620_REG_MIB_OFFSET	0x1000
+#define MT7620_PPE_AC_BCNT0	(MT7620_REG_MIB_OFFSET + 0x00)
+#define MT7620_GDM1_TX_GBCNT	(MT7620_REG_MIB_OFFSET + 0x300)
+#define MT7620_GDM2_TX_GBCNT	(MT7620_GDM1_TX_GBCNT + 0x40)
+
+#define GSW_REG_GDMA1_MAC_ADRL	0x508
+#define GSW_REG_GDMA1_MAC_ADRH	0x50C
+
+#define MT7620_FE_RST_GL	(FE_FE_OFFSET + 0x04)
+#define MT7620_FE_INT_STATUS2	(FE_FE_OFFSET + 0x08)
+
+/* FE_INT_STATUS reg on mt7620 define CNT_GDM1_AF at BIT(29)
+ * but after test it should be BIT(13).
+ */
+#define MT7620_FE_GDM1_AF	BIT(13)
+
+static const u16 mt7620_reg_table[FE_REG_COUNT] = {
+	[FE_REG_PDMA_GLO_CFG] = RT5350_PDMA_GLO_CFG,
+	[FE_REG_PDMA_RST_CFG] = RT5350_PDMA_RST_CFG,
+	[FE_REG_DLY_INT_CFG] = RT5350_DLY_INT_CFG,
+	[FE_REG_TX_BASE_PTR0] = RT5350_TX_BASE_PTR0,
+	[FE_REG_TX_MAX_CNT0] = RT5350_TX_MAX_CNT0,
+	[FE_REG_TX_CTX_IDX0] = RT5350_TX_CTX_IDX0,
+	[FE_REG_TX_DTX_IDX0] = RT5350_TX_DTX_IDX0,
+	[FE_REG_RX_BASE_PTR0] = RT5350_RX_BASE_PTR0,
+	[FE_REG_RX_MAX_CNT0] = RT5350_RX_MAX_CNT0,
+	[FE_REG_RX_CALC_IDX0] = RT5350_RX_CALC_IDX0,
+	[FE_REG_RX_DRX_IDX0] = RT5350_RX_DRX_IDX0,
+	[FE_REG_FE_INT_ENABLE] = RT5350_FE_INT_ENABLE,
+	[FE_REG_FE_INT_STATUS] = RT5350_FE_INT_STATUS,
+	[FE_REG_FE_DMA_VID_BASE] = MT7620_DMA_VID,
+	[FE_REG_FE_COUNTER_BASE] = MT7620_GDM1_TX_GBCNT,
+	[FE_REG_FE_RST_GL] = MT7620_FE_RST_GL,
+	[FE_REG_FE_INT_STATUS2] = MT7620_FE_INT_STATUS2,
+};
+
+static void mt7620_set_mac(struct fe_priv *priv, unsigned char *mac)
+{
+	struct mt7620_gsw *gsw = (struct mt7620_gsw *)priv->soc->swpriv;
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->page_lock, flags);
+	mtk_switch_w32(gsw, (mac[0] << 8) | mac[1], GSW_REG_SMACCR1);
+	mtk_switch_w32(gsw, (mac[2] << 24) | (mac[3] << 16) |
+			    (mac[4] << 8) | mac[5],
+		       GSW_REG_SMACCR0);
+	spin_unlock_irqrestore(&priv->page_lock, flags);
+}
+
+/* figure out which is the lowest and highest phy connected and enable
+ * autopolling for those phys
+ */
+static void mt7620_auto_poll(struct mt7620_gsw *gsw)
+{
+	int phy;
+	int lsb = -1, msb = 0;
+
+	for_each_set_bit(phy, &gsw->autopoll, 32) {
+		if (lsb < 0)
+			lsb = phy;
+		msb = phy;
+	}
+
+	if (lsb == msb)
+		lsb--;
+
+	mtk_switch_w32(gsw, PHY_AN_EN | PHY_PRE_EN | PMY_MDC_CONF(5) |
+		(msb << 8) | lsb, ESW_PHY_POLLING);
+}
+
+static void mt7620_port_init(struct fe_priv *priv, struct device_node *np)
+{
+	struct mt7620_gsw *gsw = (struct mt7620_gsw *)priv->soc->swpriv;
+	const __be32 *_id = of_get_property(np, "reg", NULL);
+	int phy_mode, size, id;
+	int shift = 12;
+	u32 val, mask = 0;
+	int min = (gsw->port4 == PORT4_EPHY) ? (5) : (4);
+
+	if (!_id || (be32_to_cpu(*_id) < min) || (be32_to_cpu(*_id) > 5)) {
+		if (_id)
+			pr_err("%s: invalid port id %d\n", np->name,
+			       be32_to_cpu(*_id));
+		else
+			pr_err("%s: invalid port id\n", np->name);
+		return;
+	}
+
+	id = be32_to_cpu(*_id);
+
+	if (id == 4)
+		shift = 14;
+
+	priv->phy->phy_fixed[id] = of_get_property(np, "mediatek,fixed-link",
+						   &size);
+	if (priv->phy->phy_fixed[id] &&
+	    (size != (4 * sizeof(*priv->phy->phy_fixed[id])))) {
+		pr_err("%s: invalid fixed link property\n", np->name);
+		priv->phy->phy_fixed[id] = NULL;
+		return;
+	}
+
+	phy_mode = of_get_phy_mode(np);
+	switch (phy_mode) {
+	case PHY_INTERFACE_MODE_RGMII:
+		mask = 0;
+		break;
+	case PHY_INTERFACE_MODE_MII:
+		mask = 1;
+		break;
+	case PHY_INTERFACE_MODE_RMII:
+		mask = 2;
+		break;
+	default:
+		dev_err(priv->device, "port %d - invalid phy mode\n", id);
+		return;
+	}
+
+	priv->phy->phy_node[id] = of_parse_phandle(np, "phy-handle", 0);
+	if (!priv->phy->phy_node[id] && !priv->phy->phy_fixed[id])
+		return;
+
+	val = rt_sysc_r32(SYSC_REG_CFG1);
+	val &= ~(3 << shift);
+	val |= mask << shift;
+	rt_sysc_w32(val, SYSC_REG_CFG1);
+
+	if (priv->phy->phy_fixed[id]) {
+		const __be32 *link = priv->phy->phy_fixed[id];
+		int tx_fc, rx_fc;
+		u32 val = 0;
+
+		priv->phy->speed[id] = be32_to_cpup(link++);
+		tx_fc = be32_to_cpup(link++);
+		rx_fc = be32_to_cpup(link++);
+		priv->phy->duplex[id] = be32_to_cpup(link++);
+		priv->link[id] = 1;
+
+		switch (priv->phy->speed[id]) {
+		case SPEED_10:
+			val = 0;
+			break;
+		case SPEED_100:
+			val = 1;
+			break;
+		case SPEED_1000:
+			val = 2;
+			break;
+		default:
+			dev_err(priv->device, "invalid link speed: %d\n",
+				priv->phy->speed[id]);
+			priv->phy->phy_fixed[id] = 0;
+			return;
+		}
+		val = PMCR_SPEED(val);
+		val |= PMCR_LINK | PMCR_BACKPRES | PMCR_BACKOFF | PMCR_RX_EN |
+			PMCR_TX_EN | PMCR_FORCE | PMCR_MAC_MODE | PMCR_IPG;
+		if (tx_fc)
+			val |= PMCR_TX_FC;
+		if (rx_fc)
+			val |= PMCR_RX_FC;
+		if (priv->phy->duplex[id])
+			val |= PMCR_DUPLEX;
+		mtk_switch_w32(gsw, val, GSW_REG_PORT_PMCR(id));
+		dev_info(priv->device, "using fixed link parameters\n");
+		return;
+	}
+
+	if (priv->phy->phy_node[id] && priv->mii_bus->phy_map[id]) {
+		u32 val = PMCR_BACKPRES | PMCR_BACKOFF | PMCR_RX_EN |
+			PMCR_TX_EN |  PMCR_MAC_MODE | PMCR_IPG;
+
+		mtk_switch_w32(gsw, val, GSW_REG_PORT_PMCR(id));
+		fe_connect_phy_node(priv, priv->phy->phy_node[id]);
+		gsw->autopoll |= BIT(id);
+		mt7620_auto_poll(gsw);
+		return;
+	}
+}
+
+static void mt7620_fe_reset(void)
+{
+	fe_reset(MT7620A_RESET_FE | MT7620A_RESET_ESW);
+}
+
+static int mt7620_fwd_config(struct fe_priv *priv)
+{
+	/* Make sure that the CPU port is used as the mac destination port */
+	fe_w32(fe_r32(MT7620A_GDMA1_FWD_CFG) & ~GDMA_FRC_P_MASK,
+	       MT7620A_GDMA1_FWD_CFG);
+
+	/* Enable TX Checksum Offloading */
+	fe_w32(fe_r32(MT7620A_GDMA1_FWD_CFG) | (GDMA_ICS_EN |
+						GDMA_TCS_EN | GDMA_UCS_EN),
+	       MT7620A_GDMA1_FWD_CFG);
+	/* Enable RX Checksum Offloading */
+	fe_w32(fe_r32(MT7620A_CDMA_CSG_CFG) | (CDMA_ICS_EN |
+					       CDMA_UCS_EN | CDMA_TCS_EN),
+	       MT7620A_CDMA_CSG_CFG);
+
+	return 0;
+}
+
+static void mt7620_init_data(struct fe_soc_data *data,
+			     struct net_device *netdev)
+{
+	struct fe_priv *priv = netdev_priv(netdev);
+
+	priv->flags = FE_FLAG_PADDING_64B | FE_FLAG_RX_2B_OFFSET |
+		FE_FLAG_RX_SG_DMA | FE_FLAG_HAS_SWITCH;
+
+	netdev->hw_features = NETIF_F_IP_CSUM | NETIF_F_RXCSUM |
+		NETIF_F_HW_VLAN_CTAG_TX;
+
+	/* Early chip revisions had a few bugs. Enable those features only for
+	 * revision 5 and above
+	 */
+	if (mt7620_get_eco() >= 5)
+		netdev->hw_features |= NETIF_F_SG | NETIF_F_TSO | NETIF_F_TSO6 |
+			NETIF_F_IPV6_CSUM;
+}
+
+static struct fe_soc_data mt7620_data = {
+	.dma_type = FE_PDMA,
+	.init_data = mt7620_init_data,
+	.reset_fe = mt7620_fe_reset,
+	.set_mac = mt7620_set_mac,
+	.fwd_config = mt7620_fwd_config,
+	.switch_init = mtk_gsw_init,
+	.port_init = mt7620_port_init,
+	.reg_table = mt7620_reg_table,
+	.pdma_glo_cfg = FE_PDMA_SIZE_16DWORDS,
+	.rx_int = RT5350_RX_DONE_INT,
+	.tx_int = RT5350_TX_DONE_INT,
+	.status_int = MT7620_FE_GDM1_AF,
+	.checksum_bit = MT7620_L4_VALID,
+	.has_carrier = mt7620_has_carrier,
+	.mdio_read = mt7620_mdio_read,
+	.mdio_write = mt7620_mdio_write,
+	.mdio_adjust_link = mt7620_mdio_link_adjust,
+};
+
+const struct of_device_id of_fe_match[] = {
+	{ .compatible = "mediatek,mt7620-eth", .data = &mt7620_data },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, of_fe_match);
-- 
1.7.10.4
