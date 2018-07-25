Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jul 2018 18:12:49 +0200 (CEST)
Received: from vps0.lunn.ch ([185.16.172.187]:51558 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991947AbeGYQMoqOpFl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Jul 2018 18:12:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=d2bP5Zlk7i8G96LvMVh1Xi0UVlAGt17Wq74+dzkvGQI=;
        b=DTG6meN8+1n53h+xjdzUzoALiM4TQ3vK1/aywQi/sW7vQHv5E/fcdEfqWDAjA1Z5Bkf2rpbPYEdWDu8ImnaXy00R6QM2MPdZuNzs/4LgyNSNoqRJoBtySidxqI12PH068O3TgvoGEUK8q0SQmEDQ7VI67lGMQNOpD3fd9eqFSoQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fiMOh-0004me-Pi; Wed, 25 Jul 2018 18:12:19 +0200
Date:   Wed, 25 Jul 2018 18:12:19 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org, dev@kresin.me,
        hauke.mehrtens@intel.com
Subject: Re: [PATCH 4/4] net: dsa: Add Lantiq / Intel DSA driver for vrx200
Message-ID: <20180725161219.GC16819@lunn.ch>
References: <20180721191358.13952-1-hauke@hauke-m.de>
 <20180721191358.13952-5-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180721191358.13952-5-hauke@hauke-m.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65143
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrew@lunn.ch
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

>  LANTIQ MIPS ARCHITECTURE
>  M:	John Crispin <john@phrozen.org>
> diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
> index 2b81b97e994f..f1280aa3f9bd 100644
> --- a/drivers/net/dsa/Kconfig
> +++ b/drivers/net/dsa/Kconfig
> @@ -23,6 +23,14 @@ config NET_DSA_LOOP
>  	  This enables support for a fake mock-up switch chip which
>  	  exercises the DSA APIs.
>  
> +config NET_DSA_GSWIP
> +	tristate "Intel / Lantiq GSWIP"

Minor nit pick. Could you make this NET_DSA_LANTIQ_GSWIP. We generally
have some manufacture ID in the name. And change the text to Lantiq /
Intel GSWIP.

> +static const struct gswip_rmon_cnt_desc gswip_rmon_cnt[] = {
> +	/** Receive Packet Count (only packets that are accepted and not discarded). */
> +	MIB_DESC(1, 0x1F, "RxGoodPkts"),
> +	/** Receive Unicast Packet Count. */
> +	MIB_DESC(1, 0x23, "RxUnicastPkts"),
> +	/** Receive Multicast Packet Count. */
> +	MIB_DESC(1, 0x22, "RxMulticastPkts"),
> +	/** Receive FCS Error Packet Count. */
> +	MIB_DESC(1, 0x21, "RxFCSErrorPkts"),
> +	/** Receive Undersize Good Packet Count. */
> +	MIB_DESC(1, 0x1D, "RxUnderSizeGoodPkts"),
> +	/** Receive Undersize Error Packet Count. */
> +	MIB_DESC(1, 0x1E, "RxUnderSizeErrorPkts"),
> +	/** Receive Oversize Good Packet Count. */
> +	MIB_DESC(1, 0x1B, "RxOversizeGoodPkts"),
> +	/** Receive Oversize Error Packet Count. */
> +	MIB_DESC(1, 0x1C, "RxOversizeErrorPkts"),
> +	/** Receive Good Pause Packet Count. */
> +	MIB_DESC(1, 0x20, "RxGoodPausePkts"),
> +	/** Receive Align Error Packet Count. */
> +	MIB_DESC(1, 0x1A, "RxAlignErrorPkts"),
> +	/** Receive Size 64 Packet Count. */
> +	MIB_DESC(1, 0x12, "Rx64BytePkts"),
> +	/** Receive Size 65-127 Packet Count. */
> +	MIB_DESC(1, 0x13, "Rx127BytePkts"),
> +	/** Receive Size 128-255 Packet Count. */
> +	MIB_DESC(1, 0x14, "Rx255BytePkts"),
> +	/** Receive Size 256-511 Packet Count. */
> +	MIB_DESC(1, 0x15, "Rx511BytePkts"),
> +	/** Receive Size 512-1023 Packet Count. */
> +	MIB_DESC(1, 0x16, "Rx1023BytePkts"),
> +	/** Receive Size 1024-1522 (or more, if configured) Packet Count. */
> +	MIB_DESC(1, 0x17, "RxMaxBytePkts"),
> +	/** Receive Dropped Packet Count. */
> +	MIB_DESC(1, 0x18, "RxDroppedPkts"),
> +	/** Filtered Packet Count. */
> +	MIB_DESC(1, 0x19, "RxFilteredPkts"),
> +	/** Receive Good Byte Count (64 bit). */
> +	MIB_DESC(2, 0x24, "RxGoodBytes"),
> +	/** Receive Bad Byte Count (64 bit). */
> +	MIB_DESC(2, 0x26, "RxBadBytes"),
> +	/** Transmit Dropped Packet Count, based on Congestion Management. */
> +	MIB_DESC(1, 0x11, "TxAcmDroppedPkts"),
> +	/** Transmit Packet Count. */
> +	MIB_DESC(1, 0x0C, "TxGoodPkts"),
> +	/** Transmit Unicast Packet Count. */
> +	MIB_DESC(1, 0x06, "TxUnicastPkts"),
> +	/** Transmit Multicast Packet Count. */
> +	MIB_DESC(1, 0x07, "TxMulticastPkts"),
> +	/** Transmit Size 64 Packet Count. */
> +	MIB_DESC(1, 0x00, "Tx64BytePkts"),
> +	/** Transmit Size 65-127 Packet Count. */
> +	MIB_DESC(1, 0x01, "Tx127BytePkts"),
> +	/** Transmit Size 128-255 Packet Count. */
> +	MIB_DESC(1, 0x02, "Tx255BytePkts"),
> +	/** Transmit Size 256-511 Packet Count. */
> +	MIB_DESC(1, 0x03, "Tx511BytePkts"),
> +	/** Transmit Size 512-1023 Packet Count. */
> +	MIB_DESC(1, 0x04, "Tx1023BytePkts"),
> +	/** Transmit Size 1024-1522 (or more, if configured) Packet Count. */
> +	MIB_DESC(1, 0x05, "TxMaxBytePkts"),
> +	/** Transmit Single Collision Count. */
> +	MIB_DESC(1, 0x08, "TxSingleCollCount"),
> +	/** Transmit Multiple Collision Count. */
> +	MIB_DESC(1, 0x09, "TxMultCollCount"),
> +	/** Transmit Late Collision Count. */
> +	MIB_DESC(1, 0x0A, "TxLateCollCount"),
> +	/** Transmit Excessive Collision Count. */
> +	MIB_DESC(1, 0x0B, "TxExcessCollCount"),
> +	/** Transmit Pause Packet Count. */
> +	MIB_DESC(1, 0x0D, "TxPauseCount"),
> +	/** Transmit Drop Packet Count. */
> +	MIB_DESC(1, 0x10, "TxDroppedPkts"),
> +	/** Transmit Good Byte Count (64 bit). */
> +	MIB_DESC(2, 0x0E, "TxGoodBytes"),

Most of the comments here don't add anything useful. Maybe remove
them?

> +};
> +
> +static u32 gswip_switch_r(struct gswip_priv *priv, u32 offset)
> +{
> +	return __raw_readl(priv->gswip + (offset * 4));
> +}
> +
> +static void gswip_switch_w(struct gswip_priv *priv, u32 val, u32 offset)
> +{
> +	return __raw_writel(val, priv->gswip + (offset * 4));
> +}

Since this is MIPS, i assume re-ordering cannot happen, there are
barriers, etc?

> +static int xrx200_mdio_poll(struct gswip_priv *priv)
> +{
> +	int cnt = 10000;
> +
> +	while (likely(cnt--)) {
> +		u32 ctrl = gswip_mdio_r(priv, GSWIP_MDIO_CTRL);
> +
> +		if ((ctrl & GSWIP_MDIO_CTRL_BUSY) == 0)
> +			return 0;
> +		cpu_relax();
> +	}
> +
> +	return 1;
> +}

Please return ETIMEOUT when needed. Maybe use one of the variants of
readx_poll_timeout().

> +
> +static int xrx200_mdio_wr(struct mii_bus *bus, int addr, int reg, u16 val)
> +{
> +	struct gswip_priv *priv = bus->priv;
> +
> +	if (xrx200_mdio_poll(priv))
> +		return -EIO;

EIO is wrong, it should be a timeout. Solved above...

> +
> +	gswip_mdio_w(priv, val, GSWIP_MDIO_WRITE);
> +	gswip_mdio_w(priv, GSWIP_MDIO_CTRL_BUSY | GSWIP_MDIO_CTRL_WR |
> +		((addr & GSWIP_MDIO_CTRL_PHYAD_MASK) << GSWIP_MDIO_CTRL_PHYAD_SHIFT) |
> +		(reg & GSWIP_MDIO_CTRL_REGAD_MASK),
> +		GSWIP_MDIO_CTRL);
> +
> +	return 0;
> +}
> +

> +static int gswip_mdio(struct gswip_priv *priv, struct device_node *mdio_np)
> +{
> +	struct dsa_switch *ds = priv->ds;
> +
> +	ds->slave_mii_bus = devm_mdiobus_alloc(priv->dev);
> +	if (!ds->slave_mii_bus)
> +		return -ENOMEM;
> +
> +	ds->slave_mii_bus->priv = priv;
> +	ds->slave_mii_bus->read = xrx200_mdio_rd;
> +	ds->slave_mii_bus->write = xrx200_mdio_wr;
> +	ds->slave_mii_bus->name = "lantiq,xrx200-mdio";
> +	snprintf(ds->slave_mii_bus->id, MII_BUS_ID_SIZE, "%x", 0);

You should be able to do better than that.

> +	ds->slave_mii_bus->parent = priv->dev;
> +	ds->slave_mii_bus->phy_mask = ~ds->phys_mii_mask;
> +
> +	return of_mdiobus_register(ds->slave_mii_bus, mdio_np);
> +}
> +
> +static void gswip_wait_pce_tbl_ready(struct gswip_priv *priv)
> +{
> +	while (gswip_switch_r(priv, GSWIP_PCE_TBL_CTRL) & GSWIP_PCE_TBL_CTRL_BAS)
> +		cond_resched();

Please add some form of timeout.

> +}
> +
> +static int gswip_port_enable(struct dsa_switch *ds, int port,
> +			     struct phy_device *phy)
> +{
> +	struct gswip_priv *priv = (struct gswip_priv *)ds->priv;

Casts like this are not needed.

> +	/* RMON Counter Enable for port */
> +	gswip_switch_w(priv, GSWIP_BM_PCFG_CNTEN, GSWIP_BM_PCFGp(port));
> +
> +	/* enable port fetch/store dma & VLAN Modification */
> +	gswip_switch_mask(priv, 0, GSWIP_FDMA_PCTRL_EN |
> +				   GSWIP_FDMA_PCTRL_VLANMOD_BOTH,
> +			 GSWIP_FDMA_PCTRLp(port));
> +	gswip_switch_mask(priv, 0, GSWIP_SDMA_PCTRL_EN,
> +			  GSWIP_SDMA_PCTRLp(port));
> +	gswip_switch_mask(priv, 0, GSWIP_PCE_PCTRL_0_INGRESS,
> +			  GSWIP_PCE_PCTRL_0p(port));
> +
> +	return 0;
> +}
> +

> +static int gswip_setup(struct dsa_switch *ds)
> +{
> +	struct gswip_priv *priv = ds->priv;
> +	int i;
> +
> +	gswip_switch_w(priv, GSWIP_ETHSW_SWRES_R0, GSWIP_ETHSW_SWRES);
> +	usleep_range(5000, 10000);
> +	gswip_switch_w(priv, 0, GSWIP_ETHSW_SWRES);
> +
> +	/* disable port fetch/store dma, assume CPU port is last port */

Since this comes from device tree, you should really verify that and
return EINVAL if not, in the probe() function.

> +	for (i = 0; i <= priv->cpu_port; i++)
> +		gswip_port_disable(ds, i, NULL);
> +
> +	/* enable Switch */
> +	gswip_mdio_mask(priv, 0, GSWIP_MDIO_GLOB_ENABLE, GSWIP_MDIO_GLOB);
> +
> +	xrx200_pci_microcode(priv);
> +
> +	/* Default unknown Broadcast/Multicast/Unicast port maps */
> +	gswip_switch_w(priv, BIT(priv->cpu_port), GSWIP_PCE_PMAP1);
> +	gswip_switch_w(priv, BIT(priv->cpu_port), GSWIP_PCE_PMAP2);
> +	gswip_switch_w(priv, BIT(priv->cpu_port), GSWIP_PCE_PMAP3);
> +
> +	/* disable auto polling */
> +	gswip_mdio_w(priv, 0x0, GSWIP_MDIO_MDC_CFG0);
> +
> +	/* enable special tag insertion on cpu port */
> +	gswip_switch_mask(priv, 0, GSWIP_FDMA_PCTRL_STEN,
> +			  GSWIP_FDMA_PCTRLp(priv->cpu_port));
> +
> +	gswip_switch_mask(priv, 0, GSWIP_MAC_CTRL_2_MLEN,
> +			  GSWIP_MAC_CTRL_2p(priv->cpu_port));
> +	gswip_switch_w(priv, VLAN_ETH_FRAME_LEN + 8, GSWIP_MAC_FLEN);
> +	gswip_switch_mask(priv, 0, GSWIP_BM_QUEUE_GCTRL_GL_MOD,
> +			  GSWIP_BM_QUEUE_GCTRL);
> +
> +	/* VLAN aware Switching */
> +	gswip_switch_mask(priv, 0, GSWIP_PCE_GCTRL_0_VLAN, GSWIP_PCE_GCTRL_0);
> +
> +	/* Mac Address Table Lock */
> +	gswip_switch_mask(priv, 0, GSWIP_PCE_GCTRL_1_MAC_GLOCK |
> +				   GSWIP_PCE_GCTRL_1_MAC_GLOCK_MOD,
> +			  GSWIP_PCE_GCTRL_1);
> +
> +	gswip_port_enable(ds, priv->cpu_port, NULL);
> +	return 0;
> +}
> +
> +static void gswip_adjust_link(struct dsa_switch *ds, int port,
> +			      struct phy_device *phydev)
> +{
> +	struct gswip_priv *priv = (struct gswip_priv *)ds->priv;
> +	u16 phyaddr = phydev->mdio.addr & GSWIP_MDIO_PHY_ADDR_MASK;
> +	u16 miirate = 0;
> +	u16 miimode;
> +	u16 lcl_adv = 0, rmt_adv = 0;
> +	u8 flowctrl;
> +
> +	/* do not run this for the CPU port 6 */
> +	if (port >= priv->cpu_port)

Please use  dsa_is_cpu_port(ds, port)

> +		return;
> +
> +	miimode = gswip_mdio_r(priv, GSWIP_MII_CFGp(port));
> +	miimode &= GSWIP_MII_CFG_MODE_MASK;
> +
> +	switch (phydev->speed) {
> +	case SPEED_1000:
> +		phyaddr |= GSWIP_MDIO_PHY_SPEED_G1;
> +		miirate = GSWIP_MII_CFG_RATE_M125;
> +		break;
> +
> +	case SPEED_100:
> +		phyaddr |= GSWIP_MDIO_PHY_SPEED_M100;
> +		switch (miimode) {
> +		case GSWIP_MII_CFG_MODE_RMIIM:
> +		case GSWIP_MII_CFG_MODE_RMIIP:
> +			miirate = GSWIP_MII_CFG_RATE_M50;
> +			break;
> +		default:
> +			miirate = GSWIP_MII_CFG_RATE_M25;
> +			break;
> +		}
> +		break;
> +
> +	default:
> +		phyaddr |= GSWIP_MDIO_PHY_SPEED_M10;
> +		miirate = GSWIP_MII_CFG_RATE_M2P5;
> +		break;
> +	}
> +
> +	if (phydev->link)
> +		phyaddr |= GSWIP_MDIO_PHY_LINK_UP;
> +	else
> +		phyaddr |= GSWIP_MDIO_PHY_LINK_DOWN;
> +
> +	if (phydev->duplex == DUPLEX_FULL)
> +		phyaddr |= GSWIP_MDIO_PHY_FDUP_EN;
> +	else
> +		phyaddr |= GSWIP_MDIO_PHY_FDUP_DIS;
> +
> +	if (phydev->pause)
> +		rmt_adv = LPA_PAUSE_CAP;
> +	if (phydev->asym_pause)
> +		rmt_adv |= LPA_PAUSE_ASYM;
> +
> +	if (phydev->advertising & ADVERTISED_Pause)
> +		lcl_adv |= ADVERTISE_PAUSE_CAP;
> +	if (phydev->advertising & ADVERTISED_Asym_Pause)
> +		lcl_adv |= ADVERTISE_PAUSE_ASYM;
> +
> +	flowctrl = mii_resolve_flowctrl_fdx(lcl_adv, rmt_adv);
> +
> +	if (flowctrl & FLOW_CTRL_TX)
> +		phyaddr |= GSWIP_MDIO_PHY_FCONTX_EN;
> +	else
> +		phyaddr |= GSWIP_MDIO_PHY_FCONTX_DIS;
> +	if (flowctrl & FLOW_CTRL_RX)
> +		phyaddr |= GSWIP_MDIO_PHY_FCONRX_EN;
> +	else
> +		phyaddr |= GSWIP_MDIO_PHY_FCONRX_DIS;
> +
> +	gswip_mdio_mask(priv, GSWIP_MDIO_PHY_MASK, phyaddr,
> +			GSWIP_MDIO_PHYp(port));

The names make this unclear. The callback is used to configure the MAC
layer when something happens at the PHY layer. phyaddr does not appear
to be an address, not should it be doing anything to a PHY.

> +	gswip_mii_mask(priv, GSWIP_MII_CFG_RATE_MASK, miirate,
> +		       GSWIP_MII_CFGp(port));
> +}
> +
> +static u32 gswip_bcm_ram_entry_read(struct gswip_priv *priv, u32 table,
> +				    u32 index)
> +{
> +	u32 result;
> +
> +	gswip_switch_w(priv, index, GSWIP_BM_RAM_ADDR);
> +	gswip_switch_mask(priv, GSWIP_BM_RAM_CTRL_ADDR_MASK |
> +				GSWIP_BM_RAM_CTRL_OPMOD,
> +			      table | GSWIP_BM_RAM_CTRL_BAS,
> +			      GSWIP_BM_RAM_CTRL);
> +
> +	while (gswip_switch_r(priv, GSWIP_BM_RAM_CTRL) & GSWIP_BM_RAM_CTRL_BAS)
> +		cond_resched();

Please add a timeout.

> +
> +	result = gswip_switch_r(priv, GSWIP_BM_RAM_VAL(0));
> +	result |= gswip_switch_r(priv, GSWIP_BM_RAM_VAL(1)) << 16;
> +
> +	return result;
> +}
> +

> +static int gswip_probe(struct platform_device *pdev)
> +{
> +	struct gswip_priv *priv;
> +	struct resource *gswip_res, *mdio_res, *mii_res;
> +	struct device_node *mdio_np;
> +	struct device *dev = &pdev->dev;
> +	int err;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	gswip_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	priv->gswip = devm_ioremap_resource(dev, gswip_res);
> +	if (!priv->gswip)
> +		return -ENOMEM;
> +
> +	mdio_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	priv->mdio = devm_ioremap_resource(dev, mdio_res);
> +	if (!priv->mdio)
> +		return -ENOMEM;
> +
> +	mii_res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> +	priv->mii = devm_ioremap_resource(dev, mii_res);
> +	if (!priv->mii)
> +		return -ENOMEM;
> +
> +	priv->ds = dsa_switch_alloc(dev, DSA_MAX_PORTS);

If you know how many ports there are, it is better to pass it.

> +	if (!priv->ds)
> +		return -ENOMEM;
> +
> +	priv->ds->priv = priv;
> +	priv->ds->ops = &gswip_switch_ops;
> +	priv->dev = dev;
> +	priv->cpu_port = 6;
> +
> +	/* bring up the mdio bus */
> +	mdio_np = of_find_compatible_node(pdev->dev.of_node, NULL,
> +					  "lantiq,xrx200-mdio");
> +	if (mdio_np) {
> +		err = gswip_mdio(priv, mdio_np);
> +		if (err) {
> +			dev_err(dev, "mdio probe failed\n");
> +			return err;
> +		}
> +	}
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	err = dsa_register_switch(priv->ds);
> +	if (err) {
> +		dev_err(dev, "dsa switch register failed: %i\n", err);
> +		if (mdio_np)
> +			mdiobus_unregister(priv->ds->slave_mii_bus);
> +	}
> +
> +	return err;
> +}

> +static const struct of_device_id gswip_of_match[] = {
> +	{ .compatible = "lantiq,xrx200-gswip" },
> +	{},
> +};

Please add device tree documentation.

> +MODULE_DEVICE_TABLE(of, xrx200_match);
> +
> +static struct platform_driver gswip_driver = {
> +	.probe = gswip_probe,
> +	.remove = gswip_remove,
> +	.driver = {
> +		.name = "gswip",
> +		.of_match_table = gswip_of_match,
> +	},
> +};
> +#define MC_ENTRY(val, msk, ns, out, len, type, flags, ipv4_len) \
> +	{ val, msk, (ns << 10 | out << 4 | len >> 1),\
> +		(len & 1) << 15 | type << 13 | flags << 9 | ipv4_len << 8 }
> +static const struct gswip_pce_microcode gswip_pce_microcode[] = {

How big is this table? I'm wondering if it should be loaded from
/lib/firmware. Or can it be marked __initdata?

Thanks
       Andrew
