Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2018 22:41:56 +0100 (CET)
Received: from mail-qk0-x243.google.com ([IPv6:2607:f8b0:400d:c09::243]:41609
        "EHLO mail-qk0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990498AbeCWVlt4wlpS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Mar 2018 22:41:49 +0100
Received: by mail-qk0-x243.google.com with SMTP id s78so14445413qkl.8
        for <linux-mips@linux-mips.org>; Fri, 23 Mar 2018 14:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s88ZnEMTTwUWN/XU0Ac+1Fxbs6E3CvTfIS2sFzkw10U=;
        b=Qm7bB60bFIjftvpRenk8jG9ZnJio+C4zMyS+SrrZXYeyonxwXoDrpnYmW/Lzaceo+P
         L+mgJEVKJ5aAytw6q9ZCjwCmzFUuYDuW7J1O4t/s+vZ7G0yFB3jpUpD2zCyU00z8ku3Q
         nH0eejS70geUO09UrY2XzEvgHHXDJy+qSVdKsWysMLRIhTNHyDdZ/R7K185I372yZdp9
         ziBOKm52Ga+l/F7PWFSzZYW8U0M0ToL9OHi9+hiDSfMydHnwTcmXwPp0zBoXPlXNyA+x
         n6sH9P5udmwvULlvFs2pmPvx/G6LhXeA0CkcNkOi1APgGh1THigVNtXEUP8meDy5Myrc
         EbBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s88ZnEMTTwUWN/XU0Ac+1Fxbs6E3CvTfIS2sFzkw10U=;
        b=iqnOV72R+oOrqf5mKc28iKF4ssUalLsvLc2OmUY8ZgHHpp4U9o7edZ64fhjqlc0pb1
         /9stl3gMkqpJv4L0zrekGZcx/QGbyuY30OCco6im5EnPFpd0vsht8+xdFNXtZvB5pWcg
         zmersv+J4NgHB+TOnagmnEHNkJgU35csETf74rATLDEXYRBbLQGf2cA+IqASHxqt6tjA
         uWrotwVW8DKlMBhKVXim1d3nlmMucV41SVITvFcDNoc5QoMD3pmxrYft50os2WvHTp4Y
         vbh1OflcMBJKNgMiNvYXIuRb9sa8DV66UQcrvsYhRbE4hNX1DJJwiGbeqyvp/vSxbY+t
         ltrg==
X-Gm-Message-State: AElRT7HgS3WbAhvH5BxKMvf7gWkgfkYJ3mQkEKEQufZc1Y5W0UH5NDSe
        jlHwwa4F1zJaDHWnxauoctT2LmBW
X-Google-Smtp-Source: AG47ELup+/dCg21+2PqPJNRohDaOphtYmSS0vnGT//q4HzSL0z+ru/nbzh6+1msHNmotXZcOC9f8Ww==
X-Received: by 10.55.8.147 with SMTP id 141mr42931768qki.228.1521841303106;
        Fri, 23 Mar 2018 14:41:43 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id l126sm1338615qkb.85.2018.03.23.14.41.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 14:41:42 -0700 (PDT)
Subject: Re: [PATCH net-next 5/8] net: mscc: Add initial Ocelot switch support
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Allan Nielsen <Allan.Nielsen@microsemi.com>,
        razvan.stefanescu@nxp.com, po.liu@nxp.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-6-alexandre.belloni@bootlin.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <1df0a932-f7c1-f1b5-9a35-3c16d0c551e5@gmail.com>
Date:   Fri, 23 Mar 2018 14:41:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323201117.8416-6-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63201
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 03/23/2018 01:11 PM, Alexandre Belloni wrote:
> Add a driver for Microsemi Ocelot Ethernet switch support.
> 
> This makes two modules:
> mscc_ocelot_common handles all the common features that doesn't depend on
> how the switch is integrated in the SoC. Currently, it handles offloading
> bridging to the hardware. ocelot_io.c handles register accesses. This is
> unfortunately needed because the register layout is packed and then depends
> on the number of ports available on the switch. The register definition
> files are automatically generated.
> 
> ocelot_board handles the switch integration on the SoC and on the board.
> 
> Frame injection and extraction to/from the CPU port is currently done using
> register accesses which is quite slow. DMA is possible but the port is not
> able to absorb the whole switch bandwidth.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Random drive by comments because this is quite a number of lines to review!

Overall, looks quite good for a first version. Out of curiosity, is
there a particular switch test you ran this driver against? LNST?

> +static int ocelot_mact_learn(struct ocelot *ocelot, int port,
> +			     const unsigned char mac[ETH_ALEN],
> +			     unsigned int vid,
> +			     enum macaccess_entry_type type)
> +{
> +	u32 macl = 0, mach = 0;
> +
> +	/* Set the MAC address to learn and the vlan associated in a format
> +	 * understood by the hardware.
> +	 */
> +	mach |= vid    << 16;
> +	mach |= mac[0] << 8;
> +	mach |= mac[1] << 0;
> +	macl |= mac[2] << 24;
> +	macl |= mac[3] << 16;
> +	macl |= mac[4] << 8;
> +	macl |= mac[5] << 0;
> +
> +	ocelot_write(ocelot, macl, ANA_TABLES_MACLDATA);
> +	ocelot_write(ocelot, mach, ANA_TABLES_MACHDATA);

You are repeating this in the function right below, can you factor it
somehow into a common function that this one, and the one right below
could call?

[snip]

> +static void ocelot_port_adjust_link(struct net_device *dev)
> +{

This is fine for now, but I would suggest implementing PHYLINK to be
future proof.

[snip]

> +static int ocelot_port_stop(struct net_device *dev)
> +{
> +	struct ocelot_port *port = netdev_priv(dev);
> +
> +	phy_disconnect(port->phy);
> +
> +	dev->phydev = NULL;

You don't have anything else to do, like disabling the port so it
possibly saves power or anything, aside from the PHY which will be
suspended here.

[snip]

> +static int ocelot_port_xmit(struct sk_buff *skb, struct net_device *dev)
> +{
> +	struct ocelot_port *port = netdev_priv(dev);
> +	struct ocelot *ocelot = port->ocelot;
> +	u32 val, ifh[IFH_LEN];
> +	struct frame_info info = {};
> +	u8 grp = 0; /* Send everything on CPU group 0 */
> +	int i, count, last;

unsigned int for these types.

> +
> +	val = ocelot_read(ocelot, QS_INJ_STATUS);
> +	if (!(val & QS_INJ_STATUS_FIFO_RDY(BIT(grp))) ||
> +	    (val & QS_INJ_STATUS_WMARK_REACHED(BIT(grp))))
> +		return NETDEV_TX_BUSY;
> +
> +	ocelot_write_rix(ocelot, QS_INJ_CTRL_GAP_SIZE(1) |
> +			 QS_INJ_CTRL_SOF, QS_INJ_CTRL, grp);
> +
> +	info.port = BIT(port->chip_port);
> +	info.cpuq = 0xff;
> +	ocelot_gen_ifh(ifh, &info);
> +
> +	for (i = 0; i < IFH_LEN; i++)
> +		ocelot_write_rix(ocelot, ifh[i], QS_INJ_WR, grp);
> +
> +	count = (skb->len + 3) / 4;
> +	last = skb->len % 4;
> +	for (i = 0; i < count; i++) {
> +		ocelot_write_rix(ocelot, cpu_to_le32(((u32 *)skb->data)[i]),
> +				 QS_INJ_WR, grp);
> +	}
> +
> +	/* Add padding */
> +	while (i < (OCELOT_BUFFER_CELL_SZ / 4)) {
> +		ocelot_write_rix(ocelot, 0, QS_INJ_WR, grp);
> +		i++;
> +	}
> +
> +	/* Indicate EOF and valid bytes in last word */
> +	ocelot_write_rix(ocelot, QS_INJ_CTRL_GAP_SIZE(1) |
> +			 QS_INJ_CTRL_VLD_BYTES(skb->len < OCELOT_BUFFER_CELL_SZ ? 0 : last) |
> +			 QS_INJ_CTRL_EOF,
> +			 QS_INJ_CTRL, grp);
> +
> +	/* Add dummy CRC */
> +	ocelot_write_rix(ocelot, 0, QS_INJ_WR, grp);
> +	skb_tx_timestamp(skb);
> +
> +	dev->stats.tx_packets++;
> +	dev->stats.tx_bytes += skb->len;
> +	dev_kfree_skb_any(skb);

No interrupt to indicate transmit completion?


> +static int ocelot_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
> +			  struct net_device *dev, const unsigned char *addr,
> +			  u16 vid, u16 flags)
> +{
> +	struct ocelot_port *port = netdev_priv(dev);
> +	struct ocelot *ocelot = port->ocelot;
> +
> +	if (!vid) {
> +		if (!port->vlan_aware)
> +			/* If the bridge is not VLAN aware and no VID was
> +			 * provided, set it to 1 as bridges have a default VID
> +			 * of 1. Otherwise the MAC entry wouldn't match incoming
> +			 * packets as the VID would differ (0 != 1).
> +			 */
> +			vid = 1;
> +		else
> +			/* If the bridge is VLAN aware a VID must be provided as
> +			 * otherwise the learnt entry wouldn't match any frame.
> +			 */
> +			return -EINVAL;
> +	}

So if we are targeting vid = 0 we end-up with vid = 1 possibly?

[snip]

> +static int ocelot_port_attr_stp_state_set(struct ocelot_port *ocelot_port,
> +					  struct switchdev_trans *trans,
> +					  u8 state)
> +{
> +	struct ocelot *ocelot = ocelot_port->ocelot;
> +	u32 port_cfg;
> +	int port, i;
> +
> +	if (switchdev_trans_ph_prepare(trans))
> +		return 0;
> +
> +	if (!(BIT(ocelot_port->chip_port) & ocelot->bridge_mask))
> +		return 0;
> +
> +	port_cfg = ocelot_read_gix(ocelot, ANA_PORT_PORT_CFG,
> +				   ocelot_port->chip_port);
> +
> +	switch (state) {
> +	case BR_STATE_FORWARDING:
> +		ocelot->bridge_fwd_mask |= BIT(ocelot_port->chip_port);
> +		/* Fallthrough */
> +	case BR_STATE_LEARNING:
> +		port_cfg |= ANA_PORT_PORT_CFG_LEARN_ENA;
> +		break;
> +
> +	default:
> +		port_cfg &= ~ANA_PORT_PORT_CFG_LEARN_ENA;
> +		ocelot->bridge_fwd_mask &= ~BIT(ocelot_port->chip_port);

Missing break, even if this is the default case.

> +	}
> +
> +	ocelot_write_gix(ocelot, port_cfg, ANA_PORT_PORT_CFG,
> +			 ocelot_port->chip_port);
> +
> +	/* Apply FWD mask. The loop is needed to add/remove the current port as
> +	 * a source for the other ports.
> +	 */
> +	for (port = 0; port < ocelot->num_phys_ports; port++) {
> +		if (ocelot->bridge_fwd_mask & BIT(port)) {
> +			unsigned long mask = ocelot->bridge_fwd_mask & ~BIT(port);
> +
> +			for (i = 0; i < ocelot->num_phys_ports; i++) {
> +				unsigned long bond_mask = ocelot->lags[i];
> +
> +				if (!bond_mask)
> +					continue;
> +
> +				if (bond_mask & BIT(port)) {
> +					mask &= ~bond_mask;
> +					break;
> +				}
> +			}
> +
> +			ocelot_write_rix(ocelot,
> +					 BIT(ocelot->num_phys_ports) | mask,
> +					 ANA_PGID_PGID, PGID_SRC + port);
> +		} else {
> +			/* Only the CPU port, this is compatible with link
> +			 * aggregation.
> +			 */
> +			ocelot_write_rix(ocelot,
> +					 BIT(ocelot->num_phys_ports),
> +					 ANA_PGID_PGID, PGID_SRC + port);
> +		}

All of this sounds like it should be moved into the br_join/leave, this
does not appear to be the right place to do that.

[snip]

> +static int ocelot_port_attr_set(struct net_device *dev,
> +				const struct switchdev_attr *attr,
> +				struct switchdev_trans *trans)
> +{
> +	struct ocelot_port *ocelot_port = netdev_priv(dev);
> +	int err = 0;

Should not this be EOPNOTSUPP by default so your cases below are
properly handled, like BRIDGE_FLAGS, MROUTER etc.

> +
> +	switch (attr->id) {
> +	case SWITCHDEV_ATTR_ID_PORT_STP_STATE:
> +		ocelot_port_attr_stp_state_set(ocelot_port, trans,
> +					       attr->u.stp_state);
> +		break;
> +	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
> +		break;
> +	case SWITCHDEV_ATTR_ID_BRIDGE_AGEING_TIME:
> +		ocelot_port_attr_ageing_set(ocelot_port, attr->u.ageing_time);
> +		break;
> +	case SWITCHDEV_ATTR_ID_PORT_MROUTER:
> +		break;
> +	case SWITCHDEV_ATTR_ID_BRIDGE_MC_DISABLED:
> +		ocelot_port_attr_mc_set(ocelot_port, !attr->u.mc_disabled);
> +		break;
> +	default:
> +		err = -EOPNOTSUPP;
> +		break;
> +	}
> +
> +	return err;
> +}
> +
> +static struct ocelot_multicast *ocelot_multicast_get(struct ocelot *ocelot,
> +						     const unsigned char *addr,
> +						     u16 vid)
> +{
> +	struct ocelot_multicast *mc;
> +
> +	list_for_each_entry(mc, &ocelot->multicast, list) {
> +		if (ether_addr_equal(mc->addr, addr) && mc->vid == vid)
> +			return mc;
> +	}
> +
> +	return NULL;
> +}


> +static irqreturn_t ocelot_xtr_irq_handler(int irq, void *arg)
> +{
> +	struct ocelot *ocelot = arg;
> +	int i = 0, grp = 0;
> +	int err = 0;
> +
> +	if (!(ocelot_read(ocelot, QS_XTR_DATA_PRESENT) & BIT(grp)))
> +		return IRQ_NONE;
> +
> +	do {
> +		struct sk_buff *skb;
> +		struct net_device *dev;
> +		u32 *buf;
> +		int sz, len;
> +		u32 ifh[4];
> +		u32 val;
> +		struct frame_info info;
> +
> +		for (i = 0; i < IFH_LEN; i++) {
> +			err = ocelot_rx_frame_word(ocelot, grp, true, &ifh[i]);
> +			if (err != 4)
> +				break;
> +		}

NAPI maybe?

[snip]


> +	ocelot->targets[SYS] = ocelot_io_platform_init(ocelot, pdev, "sys");
> +	if (IS_ERR(ocelot->targets[SYS]))
> +		return PTR_ERR(ocelot->targets[SYS]);

You can clearly make this in a loop instead of repeating this section,
you just need an array of register names to be looking for.

[snip]

> +	if (np) {

Please rework the indentation here, check for !np

> +		for_each_child_of_node(np, portnp) {

for_each_available_child_of_node() you should be able to mark specific
ports as being disabled and skip over these accordingly.


[snip]
> +int ocelot_regfields_init(struct ocelot *ocelot,
> +			  const struct reg_field *const regfields)
> +{
> +	int i;

unsigned int i
-- 
Florian
