Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jan 2012 21:49:34 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:47693 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904065Ab2AKUtH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 Jan 2012 21:49:07 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH RESEND 13/17] NET: MIPS: lantiq: make etop ethernet work on ase/ar9
Date:   Wed, 11 Jan 2012 21:44:30 +0100
Message-Id: <1326314674-9899-13-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1326314674-9899-1-git-send-email-blogic@openwrt.org>
References: <1326314674-9899-1-git-send-email-blogic@openwrt.org>
X-archive-position: 32226
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Extend the driver to handle the different DMA channel layout for AR9 and
Amazon-SE SoCs. The patch also adds support for the integrated PHY found
on Amazon-SE and the gigabit switch found inside the AR9.

Signed-off-by: John Crispin <blogic@openwrt.org>
Acked-by: David S. Miller <davem@davemloft.net>
---
 .../mips/include/asm/mach-lantiq/xway/lantiq_irq.h |   22 +---
 .../mips/include/asm/mach-lantiq/xway/lantiq_soc.h |   10 ++
 arch/mips/lantiq/xway/devices.c                    |   11 +-
 arch/mips/lantiq/xway/mach-easy50601.c             |    5 +
 drivers/net/ethernet/lantiq_etop.c                 |  171 ++++++++++++++++++--
 5 files changed, 179 insertions(+), 40 deletions(-)

diff --git a/arch/mips/include/asm/mach-lantiq/xway/lantiq_irq.h b/arch/mips/include/asm/mach-lantiq/xway/lantiq_irq.h
index b4465a8..2a8d5ad 100644
--- a/arch/mips/include/asm/mach-lantiq/xway/lantiq_irq.h
+++ b/arch/mips/include/asm/mach-lantiq/xway/lantiq_irq.h
@@ -38,26 +38,8 @@
 
 #define MIPS_CPU_TIMER_IRQ		7
 
-#define LTQ_DMA_CH0_INT		(INT_NUM_IM2_IRL0)
-#define LTQ_DMA_CH1_INT		(INT_NUM_IM2_IRL0 + 1)
-#define LTQ_DMA_CH2_INT		(INT_NUM_IM2_IRL0 + 2)
-#define LTQ_DMA_CH3_INT		(INT_NUM_IM2_IRL0 + 3)
-#define LTQ_DMA_CH4_INT		(INT_NUM_IM2_IRL0 + 4)
-#define LTQ_DMA_CH5_INT		(INT_NUM_IM2_IRL0 + 5)
-#define LTQ_DMA_CH6_INT		(INT_NUM_IM2_IRL0 + 6)
-#define LTQ_DMA_CH7_INT		(INT_NUM_IM2_IRL0 + 7)
-#define LTQ_DMA_CH8_INT		(INT_NUM_IM2_IRL0 + 8)
-#define LTQ_DMA_CH9_INT		(INT_NUM_IM2_IRL0 + 9)
-#define LTQ_DMA_CH10_INT	(INT_NUM_IM2_IRL0 + 10)
-#define LTQ_DMA_CH11_INT	(INT_NUM_IM2_IRL0 + 11)
-#define LTQ_DMA_CH12_INT	(INT_NUM_IM2_IRL0 + 25)
-#define LTQ_DMA_CH13_INT	(INT_NUM_IM2_IRL0 + 26)
-#define LTQ_DMA_CH14_INT	(INT_NUM_IM2_IRL0 + 27)
-#define LTQ_DMA_CH15_INT	(INT_NUM_IM2_IRL0 + 28)
-#define LTQ_DMA_CH16_INT	(INT_NUM_IM2_IRL0 + 29)
-#define LTQ_DMA_CH17_INT	(INT_NUM_IM2_IRL0 + 30)
-#define LTQ_DMA_CH18_INT	(INT_NUM_IM2_IRL0 + 16)
-#define LTQ_DMA_CH19_INT	(INT_NUM_IM2_IRL0 + 21)
+#define LTQ_DMA_ETOP		((ltq_is_ase()) ? \
+				(INT_NUM_IM3_IRL0) : (INT_NUM_IM2_IRL0))
 
 #define LTQ_PPE_MBOX_INT	(INT_NUM_IM2_IRL0 + 24)
 
diff --git a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
index c8024e3..763e163 100644
--- a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
+++ b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
@@ -82,6 +82,7 @@
 #define LTQ_PMU_SIZE		0x1000
 
 #define PMU_DMA			0x0020
+#define PMU_EPHY		0x0080
 #define PMU_USB			0x8041
 #define PMU_LED			0x0800
 #define PMU_GPT			0x1000
@@ -93,6 +94,10 @@
 #define LTQ_ETOP_BASE_ADDR	0x1E180000
 #define LTQ_ETOP_SIZE		0x40000
 
+/* GBIT - gigabit switch */
+#define LTQ_GBIT_BASE_ADDR	0x1E108000
+#define LTQ_GBIT_SIZE		0x200
+
 /* DMA */
 #define LTQ_DMA_BASE_ADDR	0x1E104100
 #define LTQ_DMA_SIZE		0x800
@@ -163,6 +168,11 @@ extern void ltq_pmu_enable(unsigned int module);
 extern void ltq_pmu_disable(unsigned int module);
 extern void ltq_cgu_enable(unsigned int clk);
 
+static inline int ltq_is_ase(void)
+{
+	return (ltq_get_soc_type() == SOC_TYPE_AMAZON_SE);
+}
+
 static inline int ltq_is_ar9(void)
 {
 	return (ltq_get_soc_type() == SOC_TYPE_AR9);
diff --git a/arch/mips/lantiq/xway/devices.c b/arch/mips/lantiq/xway/devices.c
index f97e565..eab4644d 100644
--- a/arch/mips/lantiq/xway/devices.c
+++ b/arch/mips/lantiq/xway/devices.c
@@ -74,18 +74,23 @@ void __init ltq_register_ase_asc(void)
 }
 
 /* ethernet */
-static struct resource ltq_etop_resources =
-	MEM_RES("etop", LTQ_ETOP_BASE_ADDR, LTQ_ETOP_SIZE);
+static struct resource ltq_etop_resources[] = {
+	MEM_RES("etop", LTQ_ETOP_BASE_ADDR, LTQ_ETOP_SIZE),
+	MEM_RES("gbit", LTQ_GBIT_BASE_ADDR, LTQ_GBIT_SIZE),
+};
 
 static struct platform_device ltq_etop = {
 	.name		= "ltq_etop",
-	.resource	= &ltq_etop_resources,
+	.resource	= ltq_etop_resources,
 	.num_resources	= 1,
 };
 
 void __init
 ltq_register_etop(struct ltq_eth_data *eth)
 {
+	/* only register the gphy on socs that have one */
+	if (ltq_is_ar9() | ltq_is_vr9())
+		ltq_etop.num_resources = 2;
 	if (eth) {
 		ltq_etop.dev.platform_data = eth;
 		platform_device_register(&ltq_etop);
diff --git a/arch/mips/lantiq/xway/mach-easy50601.c b/arch/mips/lantiq/xway/mach-easy50601.c
index d5aaf63..16d65e0 100644
--- a/arch/mips/lantiq/xway/mach-easy50601.c
+++ b/arch/mips/lantiq/xway/mach-easy50601.c
@@ -46,9 +46,14 @@ static struct physmap_flash_data easy50601_flash_data = {
 	.parts		= easy50601_partitions,
 };
 
+static struct ltq_eth_data ltq_eth_data = {
+	.mii_mode = -1, /* use EPHY */
+};
+
 static void __init easy50601_init(void)
 {
 	ltq_register_nor(&easy50601_flash_data);
+	ltq_register_etop(&ltq_eth_data);
 }
 
 MIPS_MACHINE(LTQ_MACH_EASY50601,
diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index 0b3567a..d3d4931 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -71,10 +71,43 @@
 #define ETOP_MII_REVERSE	0xe
 #define ETOP_PLEN_UNDER		0x40
 #define ETOP_CGEN		0x800
-
-/* use 2 static channels for TX/RX */
+#define ETOP_CFG_MII0		0x01
+
+#define LTQ_GBIT_MDIO_CTL	0xCC
+#define LTQ_GBIT_MDIO_DATA	0xd0
+#define LTQ_GBIT_GCTL0		0x68
+#define LTQ_GBIT_PMAC_HD_CTL	0x8c
+#define LTQ_GBIT_P0_CTL		0x4
+#define LTQ_GBIT_PMAC_RX_IPG	0xa8
+
+#define PMAC_HD_CTL_AS		(1 << 19)
+#define PMAC_HD_CTL_RXSH	(1 << 22)
+
+/* Switch Enable (0=disable, 1=enable) */
+#define GCTL0_SE		0x80000000
+/* Disable MDIO auto polling (0=disable, 1=enable) */
+#define PX_CTL_DMDIO		0x00400000
+
+/* register information for the gbit's MDIO bus */
+#define MDIO_XR9_REQUEST	0x00008000
+#define MDIO_XR9_READ		0x00000800
+#define MDIO_XR9_WRITE		0x00000400
+#define MDIO_XR9_REG_MASK	0x1f
+#define MDIO_XR9_ADDR_MASK	0x1f
+#define MDIO_XR9_RD_MASK	0xffff
+#define MDIO_XR9_REG_OFFSET	0
+#define MDIO_XR9_ADDR_OFFSET	5
+#define MDIO_XR9_WR_OFFSET	16
+
+/* the newer xway socks have a embedded 3/7 port gbit multiplexer */
+#define ltq_has_gbit()		(ltq_is_ar9() || ltq_is_vr9())
+
+/* use 2 static channels for TX/RX
+   depending on the SoC we need to use different DMA channels for ethernet */
 #define LTQ_ETOP_TX_CHANNEL	1
-#define LTQ_ETOP_RX_CHANNEL	6
+#define LTQ_ETOP_RX_CHANNEL	((ltq_is_ase()) ? (5) : \
+				((ltq_has_gbit()) ? (0) : (6)))
+
 #define IS_TX(x)		(x == LTQ_ETOP_TX_CHANNEL)
 #define IS_RX(x)		(x == LTQ_ETOP_RX_CHANNEL)
 
@@ -83,9 +116,15 @@
 #define ltq_etop_w32_mask(x, y, z)	\
 		ltq_w32_mask(x, y, ltq_etop_membase + (z))
 
+#define ltq_gbit_r32(x)		ltq_r32(ltq_gbit_membase + (x))
+#define ltq_gbit_w32(x, y)	ltq_w32(x, ltq_gbit_membase + (y))
+#define ltq_gbit_w32_mask(x, y, z)	\
+		ltq_w32_mask(x, y, ltq_gbit_membase + (z))
+
 #define DRV_VERSION	"1.0"
 
 static void __iomem *ltq_etop_membase;
+static void __iomem *ltq_gbit_membase;
 
 struct ltq_etop_chan {
 	int idx;
@@ -110,6 +149,9 @@ struct ltq_etop_priv {
 	spinlock_t lock;
 };
 
+static int ltq_etop_mdio_wr(struct mii_bus *bus, int phy_addr,
+				int phy_reg, u16 phy_data);
+
 static int
 ltq_etop_alloc_skb(struct ltq_etop_chan *ch)
 {
@@ -211,7 +253,7 @@ static irqreturn_t
 ltq_etop_dma_irq(int irq, void *_priv)
 {
 	struct ltq_etop_priv *priv = _priv;
-	int ch = irq - LTQ_DMA_CH0_INT;
+	int ch = irq - LTQ_DMA_ETOP;
 
 	napi_schedule(&priv->ch[ch].napi);
 	return IRQ_HANDLED;
@@ -244,15 +286,43 @@ ltq_etop_hw_exit(struct net_device *dev)
 			ltq_etop_free_channel(dev, &priv->ch[i]);
 }
 
+static void
+ltq_etop_gbit_init(void)
+{
+	ltq_pmu_enable(PMU_SWITCH);
+
+	ltq_gpio_request(42, 2, 1, "MDIO");
+	ltq_gpio_request(43, 2, 1, "MDC");
+
+	ltq_gbit_w32_mask(0, GCTL0_SE, LTQ_GBIT_GCTL0);
+	/** Disable MDIO auto polling mode */
+	ltq_gbit_w32_mask(0, PX_CTL_DMDIO, LTQ_GBIT_P0_CTL);
+	/* set 1522 packet size */
+	ltq_gbit_w32_mask(0x300, 0, LTQ_GBIT_GCTL0);
+	/* disable pmac & dmac headers */
+	ltq_gbit_w32_mask(PMAC_HD_CTL_AS | PMAC_HD_CTL_RXSH, 0,
+		LTQ_GBIT_PMAC_HD_CTL);
+	/* Due to traffic halt when burst length 8,
+		replace default IPG value with 0x3B */
+	ltq_gbit_w32(0x3B, LTQ_GBIT_PMAC_RX_IPG);
+}
+
 static int
 ltq_etop_hw_init(struct net_device *dev)
 {
 	struct ltq_etop_priv *priv = netdev_priv(dev);
+	unsigned int mii_mode = priv->pldata->mii_mode;
 	int i;
 
 	ltq_pmu_enable(PMU_PPE);
 
-	switch (priv->pldata->mii_mode) {
+	if (ltq_has_gbit()) {
+		ltq_etop_gbit_init();
+		/* force the etops link to the gbit to MII */
+		mii_mode = PHY_INTERFACE_MODE_MII;
+	}
+
+	switch (mii_mode) {
 	case PHY_INTERFACE_MODE_RMII:
 		ltq_etop_w32_mask(ETOP_MII_MASK,
 			ETOP_MII_REVERSE, LTQ_ETOP_CFG);
@@ -264,6 +334,18 @@ ltq_etop_hw_init(struct net_device *dev)
 		break;
 
 	default:
+		if (ltq_is_ase()) {
+			ltq_pmu_enable(PMU_EPHY);
+			/* disable external MII */
+			ltq_etop_w32_mask(0, ETOP_CFG_MII0, LTQ_ETOP_CFG);
+			/* enable clock for internal PHY */
+			ltq_cgu_enable(CGU_EPHY);
+			/* we need to write this magic to the internal phy to
+			   make it work */
+			ltq_etop_mdio_wr(NULL, 0x8, 0x12, 0xC020);
+			pr_info("Selected EPHY mode\n");
+			break;
+		}
 		netdev_err(dev, "unknown mii mode %d\n",
 			priv->pldata->mii_mode);
 		return -ENOTSUPP;
@@ -275,7 +357,7 @@ ltq_etop_hw_init(struct net_device *dev)
 	ltq_dma_init_port(DMA_PORT_ETOP);
 
 	for (i = 0; i < MAX_DMA_CHAN; i++) {
-		int irq = LTQ_DMA_CH0_INT + i;
+		int irq = LTQ_DMA_ETOP + i;
 		struct ltq_etop_chan *ch = &priv->ch[i];
 
 		ch->idx = ch->dma.nr = i;
@@ -339,6 +421,39 @@ static const struct ethtool_ops ltq_etop_ethtool_ops = {
 };
 
 static int
+ltq_etop_mdio_wr_xr9(struct mii_bus *bus, int phy_addr,
+		int phy_reg, u16 phy_data)
+{
+	u32 val = MDIO_XR9_REQUEST | MDIO_XR9_WRITE |
+		(phy_data << MDIO_XR9_WR_OFFSET) |
+		((phy_addr & MDIO_XR9_ADDR_MASK) << MDIO_XR9_ADDR_OFFSET) |
+		((phy_reg & MDIO_XR9_REG_MASK) << MDIO_XR9_REG_OFFSET);
+
+	while (ltq_gbit_r32(LTQ_GBIT_MDIO_CTL) & MDIO_XR9_REQUEST)
+		;
+	ltq_gbit_w32(val, LTQ_GBIT_MDIO_CTL);
+	while (ltq_gbit_r32(LTQ_GBIT_MDIO_CTL) & MDIO_XR9_REQUEST)
+		;
+	return 0;
+}
+
+static int
+ltq_etop_mdio_rd_xr9(struct mii_bus *bus, int phy_addr, int phy_reg)
+{
+	u32 val = MDIO_XR9_REQUEST | MDIO_XR9_READ |
+		((phy_addr & MDIO_XR9_ADDR_MASK) << MDIO_XR9_ADDR_OFFSET) |
+		((phy_reg & MDIO_XR9_REG_MASK) << MDIO_XR9_REG_OFFSET);
+
+	while (ltq_gbit_r32(LTQ_GBIT_MDIO_CTL) & MDIO_XR9_REQUEST)
+		;
+	ltq_gbit_w32(val, LTQ_GBIT_MDIO_CTL);
+	while (ltq_gbit_r32(LTQ_GBIT_MDIO_CTL) & MDIO_XR9_REQUEST)
+		;
+	val = ltq_gbit_r32(LTQ_GBIT_MDIO_DATA) & MDIO_XR9_RD_MASK;
+	return val;
+}
+
+static int
 ltq_etop_mdio_wr(struct mii_bus *bus, int phy_addr, int phy_reg, u16 phy_data)
 {
 	u32 val = MDIO_REQUEST |
@@ -379,14 +494,11 @@ ltq_etop_mdio_probe(struct net_device *dev)
 {
 	struct ltq_etop_priv *priv = netdev_priv(dev);
 	struct phy_device *phydev = NULL;
-	int phy_addr;
 
-	for (phy_addr = 0; phy_addr < PHY_MAX_ADDR; phy_addr++) {
-		if (priv->mii_bus->phy_map[phy_addr]) {
-			phydev = priv->mii_bus->phy_map[phy_addr];
-			break;
-		}
-	}
+	if (ltq_is_ase())
+		phydev = priv->mii_bus->phy_map[8];
+	else
+		phydev = priv->mii_bus->phy_map[0];
 
 	if (!phydev) {
 		netdev_err(dev, "no PHY found\n");
@@ -408,6 +520,9 @@ ltq_etop_mdio_probe(struct net_device *dev)
 			      | SUPPORTED_Autoneg
 			      | SUPPORTED_MII
 			      | SUPPORTED_TP);
+	if (ltq_has_gbit())
+		phydev->supported &= SUPPORTED_1000baseT_Half
+					| SUPPORTED_1000baseT_Full;
 
 	phydev->advertising = phydev->supported;
 	priv->phydev = phydev;
@@ -433,8 +548,13 @@ ltq_etop_mdio_init(struct net_device *dev)
 	}
 
 	priv->mii_bus->priv = dev;
-	priv->mii_bus->read = ltq_etop_mdio_rd;
-	priv->mii_bus->write = ltq_etop_mdio_wr;
+	if (ltq_has_gbit()) {
+		priv->mii_bus->read = ltq_etop_mdio_rd_xr9;
+		priv->mii_bus->write = ltq_etop_mdio_wr_xr9;
+	} else {
+		priv->mii_bus->read = ltq_etop_mdio_rd;
+		priv->mii_bus->write = ltq_etop_mdio_wr;
+	}
 	priv->mii_bus->name = "ltq_mii";
 	snprintf(priv->mii_bus->id, MII_BUS_ID_SIZE, "%x", 0);
 	priv->mii_bus->irq = kmalloc(sizeof(int) * PHY_MAX_ADDR, GFP_KERNEL);
@@ -524,9 +644,9 @@ ltq_etop_tx(struct sk_buff *skb, struct net_device *dev)
 	struct ltq_etop_priv *priv = netdev_priv(dev);
 	struct ltq_etop_chan *ch = &priv->ch[(queue << 1) | 1];
 	struct ltq_dma_desc *desc = &ch->dma.desc_base[ch->dma.desc];
-	int len;
 	unsigned long flags;
 	u32 byte_offset;
+	int len;
 
 	len = skb->len < ETH_ZLEN ? ETH_ZLEN : skb->len;
 
@@ -700,7 +820,7 @@ ltq_etop_probe(struct platform_device *pdev)
 {
 	struct net_device *dev;
 	struct ltq_etop_priv *priv;
-	struct resource *res;
+	struct resource *res, *gbit_res;
 	int err;
 	int i;
 
@@ -728,6 +848,23 @@ ltq_etop_probe(struct platform_device *pdev)
 		goto err_out;
 	}
 
+	if (ltq_has_gbit()) {
+		gbit_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		if (!gbit_res) {
+			dev_err(&pdev->dev, "failed to get gbit resource\n");
+			err = -ENOENT;
+			goto err_out;
+		}
+		ltq_gbit_membase = devm_ioremap_nocache(&pdev->dev,
+			gbit_res->start, resource_size(gbit_res));
+		if (!ltq_gbit_membase) {
+			dev_err(&pdev->dev, "failed to remap gigabit switch %d\n",
+				pdev->id);
+			err = -ENOMEM;
+			goto err_out;
+		}
+	}
+
 	dev = alloc_etherdev_mq(sizeof(struct ltq_etop_priv), 4);
 	strcpy(dev->name, "eth%d");
 	dev->netdev_ops = &ltq_eth_netdev_ops;
-- 
1.7.7.1
