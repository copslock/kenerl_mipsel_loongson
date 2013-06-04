Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Jun 2013 23:54:58 +0200 (CEST)
Received: from mail-wi0-f182.google.com ([209.85.212.182]:53974 "EHLO
        mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835141Ab3FDVxxmFWMs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Jun 2013 23:53:53 +0200
Received: by mail-wi0-f182.google.com with SMTP id c10so680736wiw.9
        for <multiple recipients>; Tue, 04 Jun 2013 14:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=/QnZlM71+2jMLIF5IESbxS1nOPif4F473etBL7AkCiw=;
        b=kQRApF5nY7OOZd5MpIj/NH0sp0RFq29ypXT1q/bp9c6jL7uFBOCP2ICE/W6sLUwyLk
         xbHfcAcwFDEfUV6X2OJUcH9kvYnjRS9CSjpRHlWEKUtZmK0wsqhfRi5J1c4oOohzgm+r
         m3FmjX2GTIvDcwgy8VxvxJ4nM0zFcLoab0z/Rd3mxFMxa4RmSxZjMA8V/FCkLeK5lhhs
         WGp8/uwDTGgez4P0SRzjCL8rmgkQHgxK0Zamfn/xnVqgYGYRG6srd/rvY2HHSSxqjP/Z
         ATmZmxt2wqd0cA6QNzS5uU6NaH44j11chW0Ql/MUkV4uTZ8wC2ICZwrmhJDxCyLBqARZ
         /fNA==
X-Received: by 10.181.12.1 with SMTP id em1mr3594119wid.4.1370382828267;
        Tue, 04 Jun 2013 14:53:48 -0700 (PDT)
Received: from localhost.localdomain (cpc24-aztw25-2-0-cust938.aztw.cable.virginmedia.com. [92.233.35.171])
        by mx.google.com with ESMTPSA id eq15sm5699480wic.4.2013.06.04.14.53.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 04 Jun 2013 14:53:47 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     davem@davemloft.net
Cc:     ralf@linux-mips.org, blogic@openwrt.org, linux-mips@linux-mips.org,
        cernekee@gmail.com, mbizon@freebox.fr, jogo@openwrt.org,
        netdev@vger.kernel.org
Subject: [PATCH 3/3 net-next] bcm63xx_enet: add support for Broadcom BCM63xx integrated gigabit switch
Date:   Tue,  4 Jun 2013 22:53:35 +0100
Message-Id: <1370382815-17904-4-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1370382815-17904-1-git-send-email-florian@openwrt.org>
References: <1370382815-17904-1-git-send-email-florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36691
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

From: Maxime Bizon <mbizon@freebox.fr>

Newer Broadcom BCM63xx SoCs: 6328, 6362 and 6368 have an integrated switch
which needs to be driven slightly differently from the traditional
external switches. This patch introduces changes in arch/mips/bcm63xx in order
to:

- register a bcm63xx_enetsw driver instead of bcm63xx_enet driver
- update DMA channels configuration & state RAM base addresses
- add a new platform data configuration knob to define the number of
  ports per switch/device and force link on some ports
- define the required switch registers

On the driver side, the following changes are required:

- the switch ports need to be polled to ensure the link is up and
  running and RX/TX can properly work
- basic switch configuration needs to be performed for the switch to
  forward packets to the CPU
- update the MIB counters since the integrated

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/bcm63xx/boards/board_bcm963xx.c          |    4 +
 arch/mips/bcm63xx/dev-enet.c                       |  113 ++-
 .../include/asm/mach-bcm63xx/bcm63xx_dev_enet.h    |   28 +
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h  |   50 +
 .../mips/include/asm/mach-bcm63xx/board_bcm963xx.h |    2 +
 drivers/net/ethernet/broadcom/bcm63xx_enet.c       |  995 +++++++++++++++++++-
 drivers/net/ethernet/broadcom/bcm63xx_enet.h       |   71 ++
 7 files changed, 1205 insertions(+), 58 deletions(-)

diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index a9505c4..9c0ddaf 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -845,6 +845,10 @@ int __init board_register_devices(void)
 	    !bcm63xx_nvram_get_mac_address(board.enet1.mac_addr))
 		bcm63xx_enet_register(1, &board.enet1);
 
+	if (board.has_enetsw &&
+	    !bcm63xx_nvram_get_mac_address(board.enetsw.mac_addr))
+		bcm63xx_enetsw_register(&board.enetsw);
+
 	if (board.has_usbd)
 		bcm63xx_usbd_register(&board.usbd);
 
diff --git a/arch/mips/bcm63xx/dev-enet.c b/arch/mips/bcm63xx/dev-enet.c
index df5bf66..6cbaee0 100644
--- a/arch/mips/bcm63xx/dev-enet.c
+++ b/arch/mips/bcm63xx/dev-enet.c
@@ -104,6 +104,64 @@ static struct platform_device bcm63xx_enet1_device = {
 	},
 };
 
+static struct resource enetsw_res[] = {
+	{
+		/* start & end filled at runtime */
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		/* start filled at runtime */
+		.flags		= IORESOURCE_IRQ,
+	},
+	{
+		/* start filled at runtime */
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct bcm63xx_enetsw_platform_data enetsw_pd;
+
+static struct platform_device bcm63xx_enetsw_device = {
+	.name		= "bcm63xx_enetsw",
+	.num_resources	= ARRAY_SIZE(enetsw_res),
+	.resource	= enetsw_res,
+	.dev		= {
+		.platform_data = &enetsw_pd,
+	},
+};
+
+static int __init register_shared(void)
+{
+	int ret, chan_count;
+
+	if (shared_device_registered)
+		return 0;
+
+	shared_res[0].start = bcm63xx_regset_address(RSET_ENETDMA);
+	shared_res[0].end = shared_res[0].start;
+	shared_res[0].end += (RSET_ENETDMA_SIZE)  - 1;
+
+	if (BCMCPU_IS_6328() || BCMCPU_IS_6362() || BCMCPU_IS_6368())
+		chan_count = 32;
+	else
+		chan_count = 16;
+
+	shared_res[1].start = bcm63xx_regset_address(RSET_ENETDMAC);
+	shared_res[1].end = shared_res[1].start;
+	shared_res[1].end += RSET_ENETDMAC_SIZE(chan_count)  - 1;
+
+	shared_res[2].start = bcm63xx_regset_address(RSET_ENETDMAS);
+	shared_res[2].end = shared_res[2].start;
+	shared_res[2].end += RSET_ENETDMAS_SIZE(chan_count)  - 1;
+
+	ret = platform_device_register(&bcm63xx_enet_shared_device);
+	if (ret)
+		return ret;
+	shared_device_registered = 1;
+
+	return 0;
+}
+
 int __init bcm63xx_enet_register(int unit,
 				 const struct bcm63xx_enet_platform_data *pd)
 {
@@ -117,24 +175,9 @@ int __init bcm63xx_enet_register(int unit,
 	if (unit == 1 && BCMCPU_IS_6338())
 		return -ENODEV;
 
-	if (!shared_device_registered) {
-		shared_res[0].start = bcm63xx_regset_address(RSET_ENETDMA);
-		shared_res[0].end = shared_res[0].start;
-		shared_res[0].end += (RSET_ENETDMA_SIZE)  - 1;
-
-		shared_res[1].start = bcm63xx_regset_address(RSET_ENETDMAC);
-		shared_res[1].end = shared_res[1].start;
-		shared_res[1].end += RSET_ENETDMAC_SIZE(16)  - 1;
-
-		shared_res[2].start = bcm63xx_regset_address(RSET_ENETDMAS);
-		shared_res[2].end = shared_res[2].start;
-		shared_res[2].end += RSET_ENETDMAS_SIZE(16)  - 1;
-
-		ret = platform_device_register(&bcm63xx_enet_shared_device);
-		if (ret)
-			return ret;
-		shared_device_registered = 1;
-	}
+	ret = register_shared();
+	if (ret)
+		return ret;
 
 	if (unit == 0) {
 		enet0_res[0].start = bcm63xx_regset_address(RSET_ENET0);
@@ -175,3 +218,37 @@ int __init bcm63xx_enet_register(int unit,
 		return ret;
 	return 0;
 }
+
+int __init
+bcm63xx_enetsw_register(const struct bcm63xx_enetsw_platform_data *pd)
+{
+	int ret;
+
+	if (!BCMCPU_IS_6328() && !BCMCPU_IS_6362() && !BCMCPU_IS_6368())
+		return -ENODEV;
+
+	ret = register_shared();
+	if (ret)
+		return ret;
+
+	enetsw_res[0].start = bcm63xx_regset_address(RSET_ENETSW);
+	enetsw_res[0].end = enetsw_res[0].start;
+	enetsw_res[0].end += RSET_ENETSW_SIZE - 1;
+	enetsw_res[1].start = bcm63xx_get_irq_number(IRQ_ENETSW_RXDMA0);
+	enetsw_res[2].start = bcm63xx_get_irq_number(IRQ_ENETSW_TXDMA0);
+	if (!enetsw_res[2].start)
+		enetsw_res[2].start = -1;
+
+	memcpy(bcm63xx_enetsw_device.dev.platform_data, pd, sizeof(*pd));
+
+	if (BCMCPU_IS_6328())
+		enetsw_pd.num_ports = ENETSW_PORTS_6328;
+	else if (BCMCPU_IS_6362() || BCMCPU_IS_6368())
+		enetsw_pd.num_ports = ENETSW_PORTS_6368;
+
+	ret = platform_device_register(&bcm63xx_enetsw_device);
+	if (ret)
+		return ret;
+
+	return 0;
+}
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_enet.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_enet.h
index d53f611..118e3c9 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_enet.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_enet.h
@@ -39,7 +39,35 @@ struct bcm63xx_enet_platform_data {
 					    int phy_id, int reg, int val));
 };
 
+/*
+ * on board ethernet switch platform data
+ */
+#define ENETSW_MAX_PORT	8
+#define ENETSW_PORTS_6328 5 /* 4 FE PHY + 1 RGMII */
+#define ENETSW_PORTS_6368 6 /* 4 FE PHY + 2 RGMII */
+
+#define ENETSW_RGMII_PORT0	4
+
+struct bcm63xx_enetsw_port {
+	int		used;
+	int		phy_id;
+
+	int		bypass_link;
+	int		force_speed;
+	int		force_duplex_full;
+
+	const char	*name;
+};
+
+struct bcm63xx_enetsw_platform_data {
+	char mac_addr[ETH_ALEN];
+	int num_ports;
+	struct bcm63xx_enetsw_port used_ports[ENETSW_MAX_PORT];
+};
+
 int __init bcm63xx_enet_register(int unit,
 				 const struct bcm63xx_enet_platform_data *pd);
 
+int bcm63xx_enetsw_register(const struct bcm63xx_enetsw_platform_data *pd);
+
 #endif /* ! BCM63XX_DEV_ENET_H_ */
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
index 3203fe4..0a2121a 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
@@ -830,10 +830,60 @@
  * _REG relative to RSET_ENETSW
  *************************************************************************/
 
+/* Port traffic control */
+#define ENETSW_PTCTRL_REG(x)		(0x0 + (x))
+#define ENETSW_PTCTRL_RXDIS_MASK	(1 << 0)
+#define ENETSW_PTCTRL_TXDIS_MASK	(1 << 1)
+
+/* Switch mode register */
+#define ENETSW_SWMODE_REG		(0xb)
+#define ENETSW_SWMODE_FWD_EN_MASK	(1 << 1)
+
+/* IMP override Register */
+#define ENETSW_IMPOV_REG		(0xe)
+#define ENETSW_IMPOV_FORCE_MASK		(1 << 7)
+#define ENETSW_IMPOV_TXFLOW_MASK	(1 << 5)
+#define ENETSW_IMPOV_RXFLOW_MASK	(1 << 4)
+#define ENETSW_IMPOV_1000_MASK		(1 << 3)
+#define ENETSW_IMPOV_100_MASK		(1 << 2)
+#define ENETSW_IMPOV_FDX_MASK		(1 << 1)
+#define ENETSW_IMPOV_LINKUP_MASK	(1 << 0)
+
+/* Port override Register */
+#define ENETSW_PORTOV_REG(x)		(0x58 + (x))
+#define ENETSW_PORTOV_ENABLE_MASK	(1 << 6)
+#define ENETSW_PORTOV_TXFLOW_MASK	(1 << 5)
+#define ENETSW_PORTOV_RXFLOW_MASK	(1 << 4)
+#define ENETSW_PORTOV_1000_MASK		(1 << 3)
+#define ENETSW_PORTOV_100_MASK		(1 << 2)
+#define ENETSW_PORTOV_FDX_MASK		(1 << 1)
+#define ENETSW_PORTOV_LINKUP_MASK	(1 << 0)
+
+/* MDIO control register */
+#define ENETSW_MDIOC_REG		(0xb0)
+#define ENETSW_MDIOC_EXT_MASK		(1 << 16)
+#define ENETSW_MDIOC_REG_SHIFT		20
+#define ENETSW_MDIOC_PHYID_SHIFT	25
+#define ENETSW_MDIOC_RD_MASK		(1 << 30)
+#define ENETSW_MDIOC_WR_MASK		(1 << 31)
+
+/* MDIO data register */
+#define ENETSW_MDIOD_REG		(0xb4)
+
+/* Global Management Configuration Register */
+#define ENETSW_GMCR_REG			(0x200)
+#define ENETSW_GMCR_RST_MIB_MASK	(1 << 0)
+
 /* MIB register */
 #define ENETSW_MIB_REG(x)		(0x2800 + (x) * 4)
 #define ENETSW_MIB_REG_COUNT		47
 
+/* Jumbo control register port mask register */
+#define ENETSW_JMBCTL_PORT_REG		(0x4004)
+
+/* Jumbo control mib good frame register */
+#define ENETSW_JMBCTL_MAXSIZE_REG	(0x4008)
+
 
 /*************************************************************************
  * _REG relative to RSET_OHCI_PRIV
diff --git a/arch/mips/include/asm/mach-bcm63xx/board_bcm963xx.h b/arch/mips/include/asm/mach-bcm63xx/board_bcm963xx.h
index 682bcf3..d9aee1a 100644
--- a/arch/mips/include/asm/mach-bcm63xx/board_bcm963xx.h
+++ b/arch/mips/include/asm/mach-bcm63xx/board_bcm963xx.h
@@ -24,6 +24,7 @@ struct board_info {
 	/* enabled feature/device */
 	unsigned int	has_enet0:1;
 	unsigned int	has_enet1:1;
+	unsigned int	has_enetsw:1;
 	unsigned int	has_pci:1;
 	unsigned int	has_pccard:1;
 	unsigned int	has_ohci0:1;
@@ -36,6 +37,7 @@ struct board_info {
 	/* ethernet config */
 	struct bcm63xx_enet_platform_data enet0;
 	struct bcm63xx_enet_platform_data enet1;
+	struct bcm63xx_enetsw_platform_data enetsw;
 
 	/* USB config */
 	struct bcm63xx_usbd_platform_data usbd;
diff --git a/drivers/net/ethernet/broadcom/bcm63xx_enet.c b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
index edaf76d..fbbfc4a 100644
--- a/drivers/net/ethernet/broadcom/bcm63xx_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
@@ -59,8 +59,43 @@ static inline void enet_writel(struct bcm_enet_priv *priv,
 }
 
 /*
- * io helpers to access shared registers
+ * io helpers to access switch registers
  */
+static inline u32 enetsw_readl(struct bcm_enet_priv *priv, u32 off)
+{
+	return bcm_readl(priv->base + off);
+}
+
+static inline void enetsw_writel(struct bcm_enet_priv *priv,
+				 u32 val, u32 off)
+{
+	bcm_writel(val, priv->base + off);
+}
+
+static inline u16 enetsw_readw(struct bcm_enet_priv *priv, u32 off)
+{
+	return bcm_readw(priv->base + off);
+}
+
+static inline void enetsw_writew(struct bcm_enet_priv *priv,
+				 u16 val, u32 off)
+{
+	bcm_writew(val, priv->base + off);
+}
+
+static inline u8 enetsw_readb(struct bcm_enet_priv *priv, u32 off)
+{
+	return bcm_readb(priv->base + off);
+}
+
+static inline void enetsw_writeb(struct bcm_enet_priv *priv,
+				 u8 val, u32 off)
+{
+	bcm_writeb(val, priv->base + off);
+}
+
+
+/* io helpers to access shared registers */
 static inline u32 enet_dma_readl(struct bcm_enet_priv *priv, u32 off)
 {
 	return bcm_readl(bcm_enet_shared_base[0] + off);
@@ -218,7 +253,6 @@ static int bcm_enet_refill_rx(struct net_device *dev)
 			if (!skb)
 				break;
 			priv->rx_skb[desc_idx] = skb;
-
 			p = dma_map_single(&priv->pdev->dev, skb->data,
 					   priv->rx_skb_size,
 					   DMA_FROM_DEVICE);
@@ -321,7 +355,8 @@ static int bcm_enet_receive_queue(struct net_device *dev, int budget)
 		}
 
 		/* recycle packet if it's marked as bad */
-		if (unlikely(len_stat & DMADESC_ERR_MASK)) {
+		if (!priv->enet_is_sw &&
+		    unlikely(len_stat & DMADESC_ERR_MASK)) {
 			dev->stats.rx_errors++;
 
 			if (len_stat & DMADESC_OVSIZE_MASK)
@@ -552,6 +587,26 @@ static int bcm_enet_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		goto out_unlock;
 	}
 
+	/* pad small packets sent on a switch device */
+	if (priv->enet_is_sw && skb->len < 64) {
+		int needed = 64 - skb->len;
+		char *data;
+
+		if (unlikely(skb_tailroom(skb) < needed)) {
+			struct sk_buff *nskb;
+
+			nskb = skb_copy_expand(skb, 0, needed, GFP_ATOMIC);
+			if (!nskb) {
+				ret = NETDEV_TX_BUSY;
+				goto out_unlock;
+			}
+			dev_kfree_skb(skb);
+			skb = nskb;
+		}
+		data = skb_put(skb, needed);
+		memset(data, 0, needed);
+	}
+
 	/* point to the next available desc */
 	desc = &priv->tx_desc_cpu[priv->tx_curr_desc];
 	priv->tx_skb[priv->tx_curr_desc] = skb;
@@ -959,9 +1014,9 @@ static int bcm_enet_open(struct net_device *dev)
 	enet_writel(priv, priv->hw_mtu, ENET_TXMAXLEN_REG);
 
 	/* set dma maximum burst len */
-	enet_dmac_writel(priv, BCMENET_DMA_MAXBURST,
+	enet_dmac_writel(priv, priv->dma_maxburst,
 			 ENETDMAC_MAXBURST_REG(priv->rx_chan));
-	enet_dmac_writel(priv, BCMENET_DMA_MAXBURST,
+	enet_dmac_writel(priv, priv->dma_maxburst,
 			 ENETDMAC_MAXBURST_REG(priv->tx_chan));
 
 	/* set correct transmit fifo watermark */
@@ -1567,7 +1622,7 @@ static int compute_hw_mtu(struct bcm_enet_priv *priv, int mtu)
 	 * it's appended
 	 */
 	priv->rx_skb_size = ALIGN(actual_mtu + ETH_FCS_LEN,
-				  BCMENET_DMA_MAXBURST * 4);
+				  priv->dma_maxburst * 4);
 	return 0;
 }
 
@@ -1674,6 +1729,9 @@ static int bcm_enet_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	priv = netdev_priv(dev);
 
+	priv->enet_is_sw = false;
+	priv->dma_maxburst = BCMENET_DMA_MAXBURST;
+
 	ret = compute_hw_mtu(priv, dev->mtu);
 	if (ret)
 		goto out;
@@ -1898,60 +1956,916 @@ struct platform_driver bcm63xx_enet_driver = {
 };
 
 /*
- * reserve & remap memory space shared between all macs
+ * switch mii access callbacks
  */
-static int bcm_enet_shared_probe(struct platform_device *pdev)
+static int bcmenet_sw_mdio_read(struct bcm_enet_priv *priv,
+				int ext, int phy_id, int location)
 {
-	struct resource *res;
-	void __iomem *p[3];
-	unsigned int i;
+	u32 reg;
+	int ret;
 
-	memset(bcm_enet_shared_base, 0, sizeof(bcm_enet_shared_base));
+	spin_lock_bh(&priv->enetsw_mdio_lock);
+	enetsw_writel(priv, 0, ENETSW_MDIOC_REG);
 
-	for (i = 0; i < 3; i++) {
-		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
-		p[i] = devm_ioremap_resource(&pdev->dev, res);
-		if (!p[i])
-			return -ENOMEM;
-	}
+	reg = ENETSW_MDIOC_RD_MASK |
+		(phy_id << ENETSW_MDIOC_PHYID_SHIFT) |
+		(location << ENETSW_MDIOC_REG_SHIFT);
 
-	memcpy(bcm_enet_shared_base, p, sizeof(bcm_enet_shared_base));
+	if (ext)
+		reg |= ENETSW_MDIOC_EXT_MASK;
 
-	return 0;
+	enetsw_writel(priv, reg, ENETSW_MDIOC_REG);
+	udelay(50);
+	ret = enetsw_readw(priv, ENETSW_MDIOD_REG);
+	spin_unlock_bh(&priv->enetsw_mdio_lock);
+	return ret;
 }
 
-static int bcm_enet_shared_remove(struct platform_device *pdev)
+static void bcmenet_sw_mdio_write(struct bcm_enet_priv *priv,
+				 int ext, int phy_id, int location,
+				 uint16_t data)
 {
-	return 0;
+	u32 reg;
+
+	spin_lock_bh(&priv->enetsw_mdio_lock);
+	enetsw_writel(priv, 0, ENETSW_MDIOC_REG);
+
+	reg = ENETSW_MDIOC_WR_MASK |
+		(phy_id << ENETSW_MDIOC_PHYID_SHIFT) |
+		(location << ENETSW_MDIOC_REG_SHIFT);
+
+	if (ext)
+		reg |= ENETSW_MDIOC_EXT_MASK;
+
+	reg |= data;
+
+	enetsw_writel(priv, reg, ENETSW_MDIOC_REG);
+	udelay(50);
+	spin_unlock_bh(&priv->enetsw_mdio_lock);
+}
+
+static inline int bcm_enet_port_is_rgmii(int portid)
+{
+	return portid >= ENETSW_RGMII_PORT0;
 }
 
 /*
- * this "shared" driver is needed because both macs share a single
- * address space
+ * enet sw PHY polling
  */
-struct platform_driver bcm63xx_enet_shared_driver = {
-	.probe	= bcm_enet_shared_probe,
-	.remove	= bcm_enet_shared_remove,
-	.driver	= {
-		.name	= "bcm63xx_enet_shared",
-		.owner  = THIS_MODULE,
-	},
-};
+static void swphy_poll_timer(unsigned long data)
+{
+	struct bcm_enet_priv *priv = (struct bcm_enet_priv *)data;
+	unsigned int i;
+
+	for (i = 0; i < priv->num_ports; i++) {
+		struct bcm63xx_enetsw_port *port;
+		int val, j, up, advertise, lpa, lpa2, speed, duplex, media;
+		int external_phy = bcm_enet_port_is_rgmii(i);
+		u8 override;
+
+		port = &priv->used_ports[i];
+		if (!port->used)
+			continue;
+
+		if (port->bypass_link)
+			continue;
+
+		/* dummy read to clear */
+		for (j = 0; j < 2; j++)
+			val = bcmenet_sw_mdio_read(priv, external_phy,
+						   port->phy_id, MII_BMSR);
+
+		if (val == 0xffff)
+			continue;
+
+		up = (val & BMSR_LSTATUS) ? 1 : 0;
+		if (!(up ^ priv->sw_port_link[i]))
+			continue;
+
+		priv->sw_port_link[i] = up;
+
+		/* link changed */
+		if (!up) {
+			dev_info(&priv->pdev->dev, "link DOWN on %s\n",
+				 port->name);
+			enetsw_writeb(priv, ENETSW_PORTOV_ENABLE_MASK,
+				      ENETSW_PORTOV_REG(i));
+			enetsw_writeb(priv, ENETSW_PTCTRL_RXDIS_MASK |
+				      ENETSW_PTCTRL_TXDIS_MASK,
+				      ENETSW_PTCTRL_REG(i));
+			continue;
+		}
+
+		advertise = bcmenet_sw_mdio_read(priv, external_phy,
+						 port->phy_id, MII_ADVERTISE);
+
+		lpa = bcmenet_sw_mdio_read(priv, external_phy, port->phy_id,
+					   MII_LPA);
+
+		lpa2 = bcmenet_sw_mdio_read(priv, external_phy, port->phy_id,
+					    MII_STAT1000);
+
+		/* figure out media and duplex from advertise and LPA values */
+		media = mii_nway_result(lpa & advertise);
+		duplex = (media & ADVERTISE_FULL) ? 1 : 0;
+		if (lpa2 & LPA_1000FULL)
+			duplex = 1;
+
+		if (lpa2 & (LPA_1000FULL | LPA_1000HALF))
+			speed = 1000;
+		else {
+			if (media & (ADVERTISE_100FULL | ADVERTISE_100HALF))
+				speed = 100;
+			else
+				speed = 10;
+		}
+
+		dev_info(&priv->pdev->dev,
+			 "link UP on %s, %dMbps, %s-duplex\n",
+			 port->name, speed, duplex ? "full" : "half");
+
+		override = ENETSW_PORTOV_ENABLE_MASK |
+			ENETSW_PORTOV_LINKUP_MASK;
+
+		if (speed == 1000)
+			override |= ENETSW_IMPOV_1000_MASK;
+		else if (speed == 100)
+			override |= ENETSW_IMPOV_100_MASK;
+		if (duplex)
+			override |= ENETSW_IMPOV_FDX_MASK;
+
+		enetsw_writeb(priv, override, ENETSW_PORTOV_REG(i));
+		enetsw_writeb(priv, 0, ENETSW_PTCTRL_REG(i));
+	}
+
+	priv->swphy_poll.expires = jiffies + HZ;
+	add_timer(&priv->swphy_poll);
+}
 
 /*
- * entry point
+ * open callback, allocate dma rings & buffers and start rx operation
  */
-static int __init bcm_enet_init(void)
+static int bcm_enetsw_open(struct net_device *dev)
 {
-	int ret;
+	struct bcm_enet_priv *priv;
+	struct device *kdev;
+	int i, ret;
+	unsigned int size;
+	void *p;
+	u32 val;
 
-	ret = platform_driver_register(&bcm63xx_enet_shared_driver);
-	if (ret)
-		return ret;
+	priv = netdev_priv(dev);
+	kdev = &priv->pdev->dev;
 
-	ret = platform_driver_register(&bcm63xx_enet_driver);
+	/* mask all interrupts and request them */
+	enet_dmac_writel(priv, 0, ENETDMAC_IRMASK_REG(priv->rx_chan));
+	enet_dmac_writel(priv, 0, ENETDMAC_IRMASK_REG(priv->tx_chan));
+
+	ret = request_irq(priv->irq_rx, bcm_enet_isr_dma,
+			  IRQF_DISABLED, dev->name, dev);
 	if (ret)
-		platform_driver_unregister(&bcm63xx_enet_shared_driver);
+		goto out_freeirq;
+
+	if (priv->irq_tx != -1) {
+		ret = request_irq(priv->irq_tx, bcm_enet_isr_dma,
+				  IRQF_DISABLED, dev->name, dev);
+		if (ret)
+			goto out_freeirq_rx;
+	}
+
+	/* allocate rx dma ring */
+	size = priv->rx_ring_size * sizeof(struct bcm_enet_desc);
+	p = dma_alloc_coherent(kdev, size, &priv->rx_desc_dma, GFP_KERNEL);
+	if (!p) {
+		dev_err(kdev, "cannot allocate rx ring %u\n", size);
+		ret = -ENOMEM;
+		goto out_freeirq_tx;
+	}
+
+	memset(p, 0, size);
+	priv->rx_desc_alloc_size = size;
+	priv->rx_desc_cpu = p;
+
+	/* allocate tx dma ring */
+	size = priv->tx_ring_size * sizeof(struct bcm_enet_desc);
+	p = dma_alloc_coherent(kdev, size, &priv->tx_desc_dma, GFP_KERNEL);
+	if (!p) {
+		dev_err(kdev, "cannot allocate tx ring\n");
+		ret = -ENOMEM;
+		goto out_free_rx_ring;
+	}
+
+	memset(p, 0, size);
+	priv->tx_desc_alloc_size = size;
+	priv->tx_desc_cpu = p;
+
+	priv->tx_skb = kzalloc(sizeof(struct sk_buff *) * priv->tx_ring_size,
+			       GFP_KERNEL);
+	if (!priv->tx_skb) {
+		dev_err(kdev, "cannot allocate rx skb queue\n");
+		ret = -ENOMEM;
+		goto out_free_tx_ring;
+	}
+
+	priv->tx_desc_count = priv->tx_ring_size;
+	priv->tx_dirty_desc = 0;
+	priv->tx_curr_desc = 0;
+	spin_lock_init(&priv->tx_lock);
+
+	/* init & fill rx ring with skbs */
+	priv->rx_skb = kzalloc(sizeof(struct sk_buff *) * priv->rx_ring_size,
+			       GFP_KERNEL);
+	if (!priv->rx_skb) {
+		dev_err(kdev, "cannot allocate rx skb queue\n");
+		ret = -ENOMEM;
+		goto out_free_tx_skb;
+	}
+
+	priv->rx_desc_count = 0;
+	priv->rx_dirty_desc = 0;
+	priv->rx_curr_desc = 0;
+
+	/* disable all ports */
+	for (i = 0; i < priv->num_ports; i++) {
+		enetsw_writeb(priv, ENETSW_PORTOV_ENABLE_MASK,
+			      ENETSW_PORTOV_REG(i));
+		enetsw_writeb(priv, ENETSW_PTCTRL_RXDIS_MASK |
+			      ENETSW_PTCTRL_TXDIS_MASK,
+			      ENETSW_PTCTRL_REG(i));
+
+		priv->sw_port_link[i] = 0;
+	}
+
+	/* reset mib */
+	val = enetsw_readb(priv, ENETSW_GMCR_REG);
+	val |= ENETSW_GMCR_RST_MIB_MASK;
+	enetsw_writeb(priv, val, ENETSW_GMCR_REG);
+	mdelay(1);
+	val &= ~ENETSW_GMCR_RST_MIB_MASK;
+	enetsw_writeb(priv, val, ENETSW_GMCR_REG);
+	mdelay(1);
+
+	/* force CPU port state */
+	val = enetsw_readb(priv, ENETSW_IMPOV_REG);
+	val |= ENETSW_IMPOV_FORCE_MASK | ENETSW_IMPOV_LINKUP_MASK;
+	enetsw_writeb(priv, val, ENETSW_IMPOV_REG);
+
+	/* enable switch forward engine */
+	val = enetsw_readb(priv, ENETSW_SWMODE_REG);
+	val |= ENETSW_SWMODE_FWD_EN_MASK;
+	enetsw_writeb(priv, val, ENETSW_SWMODE_REG);
+
+	/* enable jumbo on all ports */
+	enetsw_writel(priv, 0x1ff, ENETSW_JMBCTL_PORT_REG);
+	enetsw_writew(priv, 9728, ENETSW_JMBCTL_MAXSIZE_REG);
+
+	/* initialize flow control buffer allocation */
+	enet_dma_writel(priv, ENETDMA_BUFALLOC_FORCE_MASK | 0,
+			ENETDMA_BUFALLOC_REG(priv->rx_chan));
+
+	if (bcm_enet_refill_rx(dev)) {
+		dev_err(kdev, "cannot allocate rx skb queue\n");
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/* write rx & tx ring addresses */
+	enet_dmas_writel(priv, priv->rx_desc_dma,
+			 ENETDMAS_RSTART_REG(priv->rx_chan));
+	enet_dmas_writel(priv, priv->tx_desc_dma,
+			 ENETDMAS_RSTART_REG(priv->tx_chan));
+
+	/* clear remaining state ram for rx & tx channel */
+	enet_dmas_writel(priv, 0, ENETDMAS_SRAM2_REG(priv->rx_chan));
+	enet_dmas_writel(priv, 0, ENETDMAS_SRAM2_REG(priv->tx_chan));
+	enet_dmas_writel(priv, 0, ENETDMAS_SRAM3_REG(priv->rx_chan));
+	enet_dmas_writel(priv, 0, ENETDMAS_SRAM3_REG(priv->tx_chan));
+	enet_dmas_writel(priv, 0, ENETDMAS_SRAM4_REG(priv->rx_chan));
+	enet_dmas_writel(priv, 0, ENETDMAS_SRAM4_REG(priv->tx_chan));
+
+	/* set dma maximum burst len */
+	enet_dmac_writel(priv, priv->dma_maxburst,
+			 ENETDMAC_MAXBURST_REG(priv->rx_chan));
+	enet_dmac_writel(priv, priv->dma_maxburst,
+			 ENETDMAC_MAXBURST_REG(priv->tx_chan));
+
+	/* set flow control low/high threshold to 1/3 / 2/3 */
+	val = priv->rx_ring_size / 3;
+	enet_dma_writel(priv, val, ENETDMA_FLOWCL_REG(priv->rx_chan));
+	val = (priv->rx_ring_size * 2) / 3;
+	enet_dma_writel(priv, val, ENETDMA_FLOWCH_REG(priv->rx_chan));
+
+	/* all set, enable mac and interrupts, start dma engine and
+	 * kick rx dma channel
+	 */
+	wmb();
+	enet_dma_writel(priv, ENETDMA_CFG_EN_MASK, ENETDMA_CFG_REG);
+	enet_dmac_writel(priv, ENETDMAC_CHANCFG_EN_MASK,
+			 ENETDMAC_CHANCFG_REG(priv->rx_chan));
+
+	/* watch "packet transferred" interrupt in rx and tx */
+	enet_dmac_writel(priv, ENETDMAC_IR_PKTDONE_MASK,
+			 ENETDMAC_IR_REG(priv->rx_chan));
+	enet_dmac_writel(priv, ENETDMAC_IR_PKTDONE_MASK,
+			 ENETDMAC_IR_REG(priv->tx_chan));
+
+	/* make sure we enable napi before rx interrupt  */
+	napi_enable(&priv->napi);
+
+	enet_dmac_writel(priv, ENETDMAC_IR_PKTDONE_MASK,
+			 ENETDMAC_IRMASK_REG(priv->rx_chan));
+	enet_dmac_writel(priv, ENETDMAC_IR_PKTDONE_MASK,
+			 ENETDMAC_IRMASK_REG(priv->tx_chan));
+
+	netif_carrier_on(dev);
+	netif_start_queue(dev);
+
+	/* apply override config for bypass_link ports here. */
+	for (i = 0; i < priv->num_ports; i++) {
+		struct bcm63xx_enetsw_port *port;
+		u8 override;
+		port = &priv->used_ports[i];
+		if (!port->used)
+			continue;
+
+		if (!port->bypass_link)
+			continue;
+
+		override = ENETSW_PORTOV_ENABLE_MASK |
+			ENETSW_PORTOV_LINKUP_MASK;
+
+		switch (port->force_speed) {
+		case 1000:
+			override |= ENETSW_IMPOV_1000_MASK;
+			break;
+		case 100:
+			override |= ENETSW_IMPOV_100_MASK;
+			break;
+		case 10:
+			break;
+		default:
+			pr_warn("invalid forced speed on port %s: assume 10\n",
+			       port->name);
+			break;
+		}
+
+		if (port->force_duplex_full)
+			override |= ENETSW_IMPOV_FDX_MASK;
+
+
+		enetsw_writeb(priv, override, ENETSW_PORTOV_REG(i));
+		enetsw_writeb(priv, 0, ENETSW_PTCTRL_REG(i));
+	}
+
+	/* start phy polling timer */
+	init_timer(&priv->swphy_poll);
+	priv->swphy_poll.function = swphy_poll_timer;
+	priv->swphy_poll.data = (unsigned long)priv;
+	priv->swphy_poll.expires = jiffies;
+	add_timer(&priv->swphy_poll);
+	return 0;
+
+out:
+	for (i = 0; i < priv->rx_ring_size; i++) {
+		struct bcm_enet_desc *desc;
+
+		if (!priv->rx_skb[i])
+			continue;
+
+		desc = &priv->rx_desc_cpu[i];
+		dma_unmap_single(kdev, desc->address, priv->rx_skb_size,
+				 DMA_FROM_DEVICE);
+		kfree_skb(priv->rx_skb[i]);
+	}
+	kfree(priv->rx_skb);
+
+out_free_tx_skb:
+	kfree(priv->tx_skb);
+
+out_free_tx_ring:
+	dma_free_coherent(kdev, priv->tx_desc_alloc_size,
+			  priv->tx_desc_cpu, priv->tx_desc_dma);
+
+out_free_rx_ring:
+	dma_free_coherent(kdev, priv->rx_desc_alloc_size,
+			  priv->rx_desc_cpu, priv->rx_desc_dma);
+
+out_freeirq_tx:
+	if (priv->irq_tx != -1)
+		free_irq(priv->irq_tx, dev);
+
+out_freeirq_rx:
+	free_irq(priv->irq_rx, dev);
+
+out_freeirq:
+	return ret;
+}
+
+/* stop callback */
+static int bcm_enetsw_stop(struct net_device *dev)
+{
+	struct bcm_enet_priv *priv;
+	struct device *kdev;
+	int i;
+
+	priv = netdev_priv(dev);
+	kdev = &priv->pdev->dev;
+
+	del_timer_sync(&priv->swphy_poll);
+	netif_stop_queue(dev);
+	napi_disable(&priv->napi);
+	del_timer_sync(&priv->rx_timeout);
+
+	/* mask all interrupts */
+	enet_dmac_writel(priv, 0, ENETDMAC_IRMASK_REG(priv->rx_chan));
+	enet_dmac_writel(priv, 0, ENETDMAC_IRMASK_REG(priv->tx_chan));
+
+	/* disable dma & mac */
+	bcm_enet_disable_dma(priv, priv->tx_chan);
+	bcm_enet_disable_dma(priv, priv->rx_chan);
+
+	/* force reclaim of all tx buffers */
+	bcm_enet_tx_reclaim(dev, 1);
+
+	/* free the rx skb ring */
+	for (i = 0; i < priv->rx_ring_size; i++) {
+		struct bcm_enet_desc *desc;
+
+		if (!priv->rx_skb[i])
+			continue;
+
+		desc = &priv->rx_desc_cpu[i];
+		dma_unmap_single(kdev, desc->address, priv->rx_skb_size,
+				 DMA_FROM_DEVICE);
+		kfree_skb(priv->rx_skb[i]);
+	}
+
+	/* free remaining allocated memory */
+	kfree(priv->rx_skb);
+	kfree(priv->tx_skb);
+	dma_free_coherent(kdev, priv->rx_desc_alloc_size,
+			  priv->rx_desc_cpu, priv->rx_desc_dma);
+	dma_free_coherent(kdev, priv->tx_desc_alloc_size,
+			  priv->tx_desc_cpu, priv->tx_desc_dma);
+	if (priv->irq_tx != -1)
+		free_irq(priv->irq_tx, dev);
+	free_irq(priv->irq_rx, dev);
+
+	return 0;
+}
+
+/* try to sort out phy external status by walking the used_port field
+ * in the bcm_enet_priv structure. in case the phy address is not
+ * assigned to any physical port on the switch, assume it is external
+ * (and yell at the user).
+ */
+static int bcm_enetsw_phy_is_external(struct bcm_enet_priv *priv, int phy_id)
+{
+	int i;
+
+	for (i = 0; i < priv->num_ports; ++i) {
+		if (!priv->used_ports[i].used)
+			continue;
+		if (priv->used_ports[i].phy_id == phy_id)
+			return bcm_enet_port_is_rgmii(i);
+	}
+
+	printk_once(KERN_WARNING  "bcm63xx_enet: could not find a used port with phy_id %i, assuming phy is external\n",
+		    phy_id);
+	return 1;
+}
+
+/* can't use bcmenet_sw_mdio_read directly as we need to sort out
+ * external/internal status of the given phy_id first.
+ */
+static int bcm_enetsw_mii_mdio_read(struct net_device *dev, int phy_id,
+				    int location)
+{
+	struct bcm_enet_priv *priv;
+
+	priv = netdev_priv(dev);
+	return bcmenet_sw_mdio_read(priv,
+				    bcm_enetsw_phy_is_external(priv, phy_id),
+				    phy_id, location);
+}
+
+/* can't use bcmenet_sw_mdio_write directly as we need to sort out
+ * external/internal status of the given phy_id first.
+ */
+static void bcm_enetsw_mii_mdio_write(struct net_device *dev, int phy_id,
+				      int location,
+				      int val)
+{
+	struct bcm_enet_priv *priv;
+
+	priv = netdev_priv(dev);
+	bcmenet_sw_mdio_write(priv, bcm_enetsw_phy_is_external(priv, phy_id),
+			      phy_id, location, val);
+}
+
+static int bcm_enetsw_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
+{
+	struct mii_if_info mii;
+
+	mii.dev = dev;
+	mii.mdio_read = bcm_enetsw_mii_mdio_read;
+	mii.mdio_write = bcm_enetsw_mii_mdio_write;
+	mii.phy_id = 0;
+	mii.phy_id_mask = 0x3f;
+	mii.reg_num_mask = 0x1f;
+	return generic_mii_ioctl(&mii, if_mii(rq), cmd, NULL);
+
+}
+
+static const struct net_device_ops bcm_enetsw_ops = {
+	.ndo_open		= bcm_enetsw_open,
+	.ndo_stop		= bcm_enetsw_stop,
+	.ndo_start_xmit		= bcm_enet_start_xmit,
+	.ndo_change_mtu		= bcm_enet_change_mtu,
+	.ndo_do_ioctl		= bcm_enetsw_ioctl,
+};
+
+
+static const struct bcm_enet_stats bcm_enetsw_gstrings_stats[] = {
+	{ "rx_packets", DEV_STAT(rx_packets), -1 },
+	{ "tx_packets",	DEV_STAT(tx_packets), -1 },
+	{ "rx_bytes", DEV_STAT(rx_bytes), -1 },
+	{ "tx_bytes", DEV_STAT(tx_bytes), -1 },
+	{ "rx_errors", DEV_STAT(rx_errors), -1 },
+	{ "tx_errors", DEV_STAT(tx_errors), -1 },
+	{ "rx_dropped",	DEV_STAT(rx_dropped), -1 },
+	{ "tx_dropped",	DEV_STAT(tx_dropped), -1 },
+
+	{ "tx_good_octets", GEN_STAT(mib.tx_gd_octets), ETHSW_MIB_RX_GD_OCT },
+	{ "tx_unicast", GEN_STAT(mib.tx_unicast), ETHSW_MIB_RX_BRDCAST },
+	{ "tx_broadcast", GEN_STAT(mib.tx_brdcast), ETHSW_MIB_RX_BRDCAST },
+	{ "tx_multicast", GEN_STAT(mib.tx_mult), ETHSW_MIB_RX_MULT },
+	{ "tx_64_octets", GEN_STAT(mib.tx_64), ETHSW_MIB_RX_64 },
+	{ "tx_65_127_oct", GEN_STAT(mib.tx_65_127), ETHSW_MIB_RX_65_127 },
+	{ "tx_128_255_oct", GEN_STAT(mib.tx_128_255), ETHSW_MIB_RX_128_255 },
+	{ "tx_256_511_oct", GEN_STAT(mib.tx_256_511), ETHSW_MIB_RX_256_511 },
+	{ "tx_512_1023_oct", GEN_STAT(mib.tx_512_1023), ETHSW_MIB_RX_512_1023},
+	{ "tx_1024_1522_oct", GEN_STAT(mib.tx_1024_max),
+	  ETHSW_MIB_RX_1024_1522 },
+	{ "tx_1523_2047_oct", GEN_STAT(mib.tx_1523_2047),
+	  ETHSW_MIB_RX_1523_2047 },
+	{ "tx_2048_4095_oct", GEN_STAT(mib.tx_2048_4095),
+	  ETHSW_MIB_RX_2048_4095 },
+	{ "tx_4096_8191_oct", GEN_STAT(mib.tx_4096_8191),
+	  ETHSW_MIB_RX_4096_8191 },
+	{ "tx_8192_9728_oct", GEN_STAT(mib.tx_8192_9728),
+	  ETHSW_MIB_RX_8192_9728 },
+	{ "tx_oversize", GEN_STAT(mib.tx_ovr), ETHSW_MIB_RX_OVR },
+	{ "tx_oversize_drop", GEN_STAT(mib.tx_ovr), ETHSW_MIB_RX_OVR_DISC },
+	{ "tx_dropped",	GEN_STAT(mib.tx_drop), ETHSW_MIB_RX_DROP },
+	{ "tx_undersize", GEN_STAT(mib.tx_underrun), ETHSW_MIB_RX_UND },
+	{ "tx_pause", GEN_STAT(mib.tx_pause), ETHSW_MIB_RX_PAUSE },
+
+	{ "rx_good_octets", GEN_STAT(mib.rx_gd_octets), ETHSW_MIB_TX_ALL_OCT },
+	{ "rx_broadcast", GEN_STAT(mib.rx_brdcast), ETHSW_MIB_TX_BRDCAST },
+	{ "rx_multicast", GEN_STAT(mib.rx_mult), ETHSW_MIB_TX_MULT },
+	{ "rx_unicast", GEN_STAT(mib.rx_unicast), ETHSW_MIB_TX_MULT },
+	{ "rx_pause", GEN_STAT(mib.rx_pause), ETHSW_MIB_TX_PAUSE },
+	{ "rx_dropped", GEN_STAT(mib.rx_drop), ETHSW_MIB_TX_DROP_PKTS },
+
+};
+
+#define BCM_ENETSW_STATS_LEN	\
+	(sizeof(bcm_enetsw_gstrings_stats) / sizeof(struct bcm_enet_stats))
+
+static void bcm_enetsw_get_strings(struct net_device *netdev,
+				   u32 stringset, u8 *data)
+{
+	int i;
+
+	switch (stringset) {
+	case ETH_SS_STATS:
+		for (i = 0; i < BCM_ENETSW_STATS_LEN; i++) {
+			memcpy(data + i * ETH_GSTRING_LEN,
+			       bcm_enetsw_gstrings_stats[i].stat_string,
+			       ETH_GSTRING_LEN);
+		}
+		break;
+	}
+}
+
+static int bcm_enetsw_get_sset_count(struct net_device *netdev,
+				     int string_set)
+{
+	switch (string_set) {
+	case ETH_SS_STATS:
+		return BCM_ENETSW_STATS_LEN;
+	default:
+		return -EINVAL;
+	}
+}
+
+static void bcm_enetsw_get_drvinfo(struct net_device *netdev,
+				   struct ethtool_drvinfo *drvinfo)
+{
+	strncpy(drvinfo->driver, bcm_enet_driver_name, 32);
+	strncpy(drvinfo->version, bcm_enet_driver_version, 32);
+	strncpy(drvinfo->fw_version, "N/A", 32);
+	strncpy(drvinfo->bus_info, "bcm63xx", 32);
+	drvinfo->n_stats = BCM_ENETSW_STATS_LEN;
+}
+
+static void bcm_enetsw_get_ethtool_stats(struct net_device *netdev,
+					 struct ethtool_stats *stats,
+					 u64 *data)
+{
+	struct bcm_enet_priv *priv;
+	int i;
+
+	priv = netdev_priv(netdev);
+
+	for (i = 0; i < BCM_ENETSW_STATS_LEN; i++) {
+		const struct bcm_enet_stats *s;
+		u32 lo, hi;
+		char *p;
+		int reg;
+
+		s = &bcm_enetsw_gstrings_stats[i];
+
+		reg = s->mib_reg;
+		if (reg == -1)
+			continue;
+
+		lo = enetsw_readl(priv, ENETSW_MIB_REG(reg));
+		p = (char *)priv + s->stat_offset;
+
+		if (s->sizeof_stat == sizeof(u64)) {
+			hi = enetsw_readl(priv, ENETSW_MIB_REG(reg + 1));
+			*(u64 *)p = ((u64)hi << 32 | lo);
+		} else {
+			*(u32 *)p = lo;
+		}
+	}
+
+	for (i = 0; i < BCM_ENETSW_STATS_LEN; i++) {
+		const struct bcm_enet_stats *s;
+		char *p;
+
+		s = &bcm_enetsw_gstrings_stats[i];
+
+		if (s->mib_reg == -1)
+			p = (char *)&netdev->stats + s->stat_offset;
+		else
+			p = (char *)priv + s->stat_offset;
+
+		data[i] = (s->sizeof_stat == sizeof(u64)) ?
+			*(u64 *)p : *(u32 *)p;
+	}
+}
+
+static void bcm_enetsw_get_ringparam(struct net_device *dev,
+				     struct ethtool_ringparam *ering)
+{
+	struct bcm_enet_priv *priv;
+
+	priv = netdev_priv(dev);
+
+	/* rx/tx ring is actually only limited by memory */
+	ering->rx_max_pending = 8192;
+	ering->tx_max_pending = 8192;
+	ering->rx_mini_max_pending = 0;
+	ering->rx_jumbo_max_pending = 0;
+	ering->rx_pending = priv->rx_ring_size;
+	ering->tx_pending = priv->tx_ring_size;
+}
+
+static int bcm_enetsw_set_ringparam(struct net_device *dev,
+				    struct ethtool_ringparam *ering)
+{
+	struct bcm_enet_priv *priv;
+	int was_running;
+
+	priv = netdev_priv(dev);
+
+	was_running = 0;
+	if (netif_running(dev)) {
+		bcm_enetsw_stop(dev);
+		was_running = 1;
+	}
+
+	priv->rx_ring_size = ering->rx_pending;
+	priv->tx_ring_size = ering->tx_pending;
+
+	if (was_running) {
+		int err;
+
+		err = bcm_enetsw_open(dev);
+		if (err)
+			dev_close(dev);
+	}
+	return 0;
+}
+
+static struct ethtool_ops bcm_enetsw_ethtool_ops = {
+	.get_strings		= bcm_enetsw_get_strings,
+	.get_sset_count		= bcm_enetsw_get_sset_count,
+	.get_ethtool_stats      = bcm_enetsw_get_ethtool_stats,
+	.get_drvinfo		= bcm_enetsw_get_drvinfo,
+	.get_ringparam		= bcm_enetsw_get_ringparam,
+	.set_ringparam		= bcm_enetsw_set_ringparam,
+};
+
+/* allocate netdevice, request register memory and register device. */
+static int bcm_enetsw_probe(struct platform_device *pdev)
+{
+	struct bcm_enet_priv *priv;
+	struct net_device *dev;
+	struct bcm63xx_enetsw_platform_data *pd;
+	struct resource *res_mem;
+	int ret, irq_rx, irq_tx;
+
+	/* stop if shared driver failed, assume driver->probe will be
+	 * called in the same order we register devices (correct ?)
+	 */
+	if (!bcm_enet_shared_base[0])
+		return -ENODEV;
+
+	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	irq_rx = platform_get_irq(pdev, 0);
+	irq_tx = platform_get_irq(pdev, 1);
+	if (!res_mem || irq_rx < 0)
+		return -ENODEV;
+
+	ret = 0;
+	dev = alloc_etherdev(sizeof(*priv));
+	if (!dev)
+		return -ENOMEM;
+	priv = netdev_priv(dev);
+	memset(priv, 0, sizeof(*priv));
+
+	/* initialize default and fetch platform data */
+	priv->enet_is_sw = true;
+	priv->irq_rx = irq_rx;
+	priv->irq_tx = irq_tx;
+	priv->rx_ring_size = BCMENET_DEF_RX_DESC;
+	priv->tx_ring_size = BCMENET_DEF_TX_DESC;
+	priv->dma_maxburst = BCMENETSW_DMA_MAXBURST;
+
+	pd = pdev->dev.platform_data;
+	if (pd) {
+		memcpy(dev->dev_addr, pd->mac_addr, ETH_ALEN);
+		memcpy(priv->used_ports, pd->used_ports,
+		       sizeof(pd->used_ports));
+		priv->num_ports = pd->num_ports;
+	}
+
+	ret = compute_hw_mtu(priv, dev->mtu);
+	if (ret)
+		goto out;
+
+	if (!request_mem_region(res_mem->start, resource_size(res_mem),
+				"bcm63xx_enetsw")) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	priv->base = ioremap(res_mem->start, resource_size(res_mem));
+	if (priv->base == NULL) {
+		ret = -ENOMEM;
+		goto out_release_mem;
+	}
+
+	priv->mac_clk = clk_get(&pdev->dev, "enetsw");
+	if (IS_ERR(priv->mac_clk)) {
+		ret = PTR_ERR(priv->mac_clk);
+		goto out_unmap;
+	}
+	clk_enable(priv->mac_clk);
+
+	priv->rx_chan = 0;
+	priv->tx_chan = 1;
+	spin_lock_init(&priv->rx_lock);
+
+	/* init rx timeout (used for oom) */
+	init_timer(&priv->rx_timeout);
+	priv->rx_timeout.function = bcm_enet_refill_rx_timer;
+	priv->rx_timeout.data = (unsigned long)dev;
+
+	/* register netdevice */
+	dev->netdev_ops = &bcm_enetsw_ops;
+	netif_napi_add(dev, &priv->napi, bcm_enet_poll, 16);
+	SET_ETHTOOL_OPS(dev, &bcm_enetsw_ethtool_ops);
+	SET_NETDEV_DEV(dev, &pdev->dev);
+
+	spin_lock_init(&priv->enetsw_mdio_lock);
+
+	ret = register_netdev(dev);
+	if (ret)
+		goto out_put_clk;
+
+	netif_carrier_off(dev);
+	platform_set_drvdata(pdev, dev);
+	priv->pdev = pdev;
+	priv->net_dev = dev;
+
+	return 0;
+
+out_put_clk:
+	clk_put(priv->mac_clk);
+
+out_unmap:
+	iounmap(priv->base);
+
+out_release_mem:
+	release_mem_region(res_mem->start, resource_size(res_mem));
+out:
+	free_netdev(dev);
+	return ret;
+}
+
+
+/* exit func, stops hardware and unregisters netdevice */
+static int bcm_enetsw_remove(struct platform_device *pdev)
+{
+	struct bcm_enet_priv *priv;
+	struct net_device *dev;
+	struct resource *res;
+
+	/* stop netdevice */
+	dev = platform_get_drvdata(pdev);
+	priv = netdev_priv(dev);
+	unregister_netdev(dev);
+
+	/* release device resources */
+	iounmap(priv->base);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	release_mem_region(res->start, resource_size(res));
+
+	platform_set_drvdata(pdev, NULL);
+	free_netdev(dev);
+	return 0;
+}
+
+struct platform_driver bcm63xx_enetsw_driver = {
+	.probe	= bcm_enetsw_probe,
+	.remove	= bcm_enetsw_remove,
+	.driver	= {
+		.name	= "bcm63xx_enetsw",
+		.owner  = THIS_MODULE,
+	},
+};
+
+/* reserve & remap memory space shared between all macs */
+static int bcm_enet_shared_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	void __iomem *p[3];
+	unsigned int i;
+
+	memset(bcm_enet_shared_base, 0, sizeof(bcm_enet_shared_base));
+
+	for (i = 0; i < 3; i++) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
+		p[i] = devm_ioremap_resource(&pdev->dev, res);
+		if (!p[i])
+			return -ENOMEM;
+	}
+
+	memcpy(bcm_enet_shared_base, p, sizeof(bcm_enet_shared_base));
+
+	return 0;
+}
+
+static int bcm_enet_shared_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+/* this "shared" driver is needed because both macs share a single
+ * address space
+ */
+struct platform_driver bcm63xx_enet_shared_driver = {
+	.probe	= bcm_enet_shared_probe,
+	.remove	= bcm_enet_shared_remove,
+	.driver	= {
+		.name	= "bcm63xx_enet_shared",
+		.owner  = THIS_MODULE,
+	},
+};
+
+/* entry point */
+static int __init bcm_enet_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&bcm63xx_enet_shared_driver);
+	if (ret)
+		return ret;
+
+	ret = platform_driver_register(&bcm63xx_enet_driver);
+	if (ret)
+		platform_driver_unregister(&bcm63xx_enet_shared_driver);
+
+	ret = platform_driver_register(&bcm63xx_enetsw_driver);
+	if (ret) {
+		platform_driver_unregister(&bcm63xx_enet_driver);
+		platform_driver_unregister(&bcm63xx_enet_shared_driver);
+	}
 
 	return ret;
 }
@@ -1959,6 +2873,7 @@ static int __init bcm_enet_init(void)
 static void __exit bcm_enet_exit(void)
 {
 	platform_driver_unregister(&bcm63xx_enet_driver);
+	platform_driver_unregister(&bcm63xx_enetsw_driver);
 	platform_driver_unregister(&bcm63xx_enet_shared_driver);
 }
 
diff --git a/drivers/net/ethernet/broadcom/bcm63xx_enet.h b/drivers/net/ethernet/broadcom/bcm63xx_enet.h
index 133d585..721ffba 100644
--- a/drivers/net/ethernet/broadcom/bcm63xx_enet.h
+++ b/drivers/net/ethernet/broadcom/bcm63xx_enet.h
@@ -18,6 +18,7 @@
 
 /* maximum burst len for dma (4 bytes unit) */
 #define BCMENET_DMA_MAXBURST	16
+#define BCMENETSW_DMA_MAXBURST	8
 
 /* tx transmit threshold (4 bytes unit), fifo is 256 bytes, the value
  * must be low enough so that a DMA transfer of above burst length can
@@ -84,11 +85,60 @@
 #define ETH_MIB_RX_CNTRL			54
 
 
+/*
+ * SW MIB Counters register definitions
+*/
+#define ETHSW_MIB_TX_ALL_OCT			0
+#define ETHSW_MIB_TX_DROP_PKTS			2
+#define ETHSW_MIB_TX_QOS_PKTS			3
+#define ETHSW_MIB_TX_BRDCAST			4
+#define ETHSW_MIB_TX_MULT			5
+#define ETHSW_MIB_TX_UNI			6
+#define ETHSW_MIB_TX_COL			7
+#define ETHSW_MIB_TX_1_COL			8
+#define ETHSW_MIB_TX_M_COL			9
+#define ETHSW_MIB_TX_DEF			10
+#define ETHSW_MIB_TX_LATE			11
+#define ETHSW_MIB_TX_EX_COL			12
+#define ETHSW_MIB_TX_PAUSE			14
+#define ETHSW_MIB_TX_QOS_OCT			15
+
+#define ETHSW_MIB_RX_ALL_OCT			17
+#define ETHSW_MIB_RX_UND			19
+#define ETHSW_MIB_RX_PAUSE			20
+#define ETHSW_MIB_RX_64				21
+#define ETHSW_MIB_RX_65_127			22
+#define ETHSW_MIB_RX_128_255			23
+#define ETHSW_MIB_RX_256_511			24
+#define ETHSW_MIB_RX_512_1023			25
+#define ETHSW_MIB_RX_1024_1522			26
+#define ETHSW_MIB_RX_OVR			27
+#define ETHSW_MIB_RX_JAB			28
+#define ETHSW_MIB_RX_ALIGN			29
+#define ETHSW_MIB_RX_CRC			30
+#define ETHSW_MIB_RX_GD_OCT			31
+#define ETHSW_MIB_RX_DROP			33
+#define ETHSW_MIB_RX_UNI			34
+#define ETHSW_MIB_RX_MULT			35
+#define ETHSW_MIB_RX_BRDCAST			36
+#define ETHSW_MIB_RX_SA_CHANGE			37
+#define ETHSW_MIB_RX_FRAG			38
+#define ETHSW_MIB_RX_OVR_DISC			39
+#define ETHSW_MIB_RX_SYM			40
+#define ETHSW_MIB_RX_QOS_PKTS			41
+#define ETHSW_MIB_RX_QOS_OCT			42
+#define ETHSW_MIB_RX_1523_2047			44
+#define ETHSW_MIB_RX_2048_4095			45
+#define ETHSW_MIB_RX_4096_8191			46
+#define ETHSW_MIB_RX_8192_9728			47
+
+
 struct bcm_enet_mib_counters {
 	u64 tx_gd_octets;
 	u32 tx_gd_pkts;
 	u32 tx_all_octets;
 	u32 tx_all_pkts;
+	u32 tx_unicast;
 	u32 tx_brdcast;
 	u32 tx_mult;
 	u32 tx_64;
@@ -97,7 +147,12 @@ struct bcm_enet_mib_counters {
 	u32 tx_256_511;
 	u32 tx_512_1023;
 	u32 tx_1024_max;
+	u32 tx_1523_2047;
+	u32 tx_2048_4095;
+	u32 tx_4096_8191;
+	u32 tx_8192_9728;
 	u32 tx_jab;
+	u32 tx_drop;
 	u32 tx_ovr;
 	u32 tx_frag;
 	u32 tx_underrun;
@@ -114,6 +169,7 @@ struct bcm_enet_mib_counters {
 	u32 rx_all_octets;
 	u32 rx_all_pkts;
 	u32 rx_brdcast;
+	u32 rx_unicast;
 	u32 rx_mult;
 	u32 rx_64;
 	u32 rx_65_127;
@@ -197,6 +253,9 @@ struct bcm_enet_priv {
 	/* number of dma desc in tx ring */
 	int tx_ring_size;
 
+	/* maximum dma burst size */
+	int dma_maxburst;
+
 	/* cpu view of rx dma ring */
 	struct bcm_enet_desc *tx_desc_cpu;
 
@@ -269,6 +328,18 @@ struct bcm_enet_priv {
 
 	/* maximum hardware transmit/receive size */
 	unsigned int hw_mtu;
+
+	bool enet_is_sw;
+
+	/* port mapping for switch devices */
+	int num_ports;
+	struct bcm63xx_enetsw_port used_ports[ENETSW_MAX_PORT];
+	int sw_port_link[ENETSW_MAX_PORT];
+
+	/* used to poll switch port state */
+	struct timer_list swphy_poll;
+	spinlock_t enetsw_mdio_lock;
 };
 
+
 #endif /* ! BCM63XX_ENET_H_ */
-- 
1.7.10.4
