Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Jun 2013 23:54:31 +0200 (CEST)
Received: from mail-wg0-f53.google.com ([74.125.82.53]:45679 "EHLO
        mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835140Ab3FDVxxTUHyk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Jun 2013 23:53:53 +0200
Received: by mail-wg0-f53.google.com with SMTP id c11so698264wgh.8
        for <multiple recipients>; Tue, 04 Jun 2013 14:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=YjaKxN+HKtGD9GtMM+RJPnCoiQ3/NgAFeCYeHuu3JQ4=;
        b=NrFVky+PUln2t5pym3QdVSb51Lhl+d7MIVP1Q17rQl4k9w5lLiQDjS9x6Dj/gebI1z
         rSeITZQ6CuHP3P6Be0IthFUBVHr+SLxoFWcSOIBZmtqSv882povUNDbbSMnkoX3d5lvX
         R9hWibrbCJ7iIP41UBV8qOovb1suq+uUuwNi3+RcjsEK4flMGET+zicTVUlrN0H9WnBY
         QyR34Qh0Od7yupEOeadf8aK91MIQbg7stEyEkmL+k+Y+wfYXF8eK6hDOhV6oN8wZqdLf
         Kz3LzWzO+0ucI+8QdiBhaYzZ9IKf/njdb+bIIS3YTFlH+IB5Di0P//4qnj86gTC7lNd+
         7luw==
X-Received: by 10.180.37.229 with SMTP id b5mr3477224wik.29.1370382825585;
        Tue, 04 Jun 2013 14:53:45 -0700 (PDT)
Received: from localhost.localdomain (cpc24-aztw25-2-0-cust938.aztw.cable.virginmedia.com. [92.233.35.171])
        by mx.google.com with ESMTPSA id eq15sm5699480wic.4.2013.06.04.14.53.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 04 Jun 2013 14:53:44 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     davem@davemloft.net
Cc:     ralf@linux-mips.org, blogic@openwrt.org, linux-mips@linux-mips.org,
        cernekee@gmail.com, mbizon@freebox.fr, jogo@openwrt.org,
        netdev@vger.kernel.org
Subject: [PATCH 2/3 net-next] bcm63xx_enet: split DMA channel register accesses
Date:   Tue,  4 Jun 2013 22:53:34 +0100
Message-Id: <1370382815-17904-3-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1370382815-17904-1-git-send-email-florian@openwrt.org>
References: <1370382815-17904-1-git-send-email-florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36690
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

The current bcm63xx_enet driver always uses bcmenet_shared_base whenever
it needs to access DMA channel configuration space or access the DMA
channel state RAM. Split these register in 3 parts to be more accurate:

- global DMA configuration
- per DMA channel configuration space
- per DMA channel state RAM space

This is preliminary to support new chips where the global DMA
configuration remains the same, but there is a varying number of DMA
channels located at a different memory offset.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/bcm63xx/dev-enet.c                     |   23 +++-
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h |    4 +-
 drivers/net/ethernet/broadcom/bcm63xx_enet.c     |  139 +++++++++++++---------
 3 files changed, 105 insertions(+), 61 deletions(-)

diff --git a/arch/mips/bcm63xx/dev-enet.c b/arch/mips/bcm63xx/dev-enet.c
index 39c2336..df5bf66 100644
--- a/arch/mips/bcm63xx/dev-enet.c
+++ b/arch/mips/bcm63xx/dev-enet.c
@@ -19,6 +19,16 @@ static struct resource shared_res[] = {
 		.end		= -1, /* filled at runtime */
 		.flags		= IORESOURCE_MEM,
 	},
+	{
+		.start		= -1, /* filled at runtime */
+		.end		= -1, /* filled at runtime */
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= -1, /* filled at runtime */
+		.end		= -1, /* filled at runtime */
+		.flags		= IORESOURCE_MEM,
+	},
 };
 
 static struct platform_device bcm63xx_enet_shared_device = {
@@ -110,10 +120,15 @@ int __init bcm63xx_enet_register(int unit,
 	if (!shared_device_registered) {
 		shared_res[0].start = bcm63xx_regset_address(RSET_ENETDMA);
 		shared_res[0].end = shared_res[0].start;
-		if (BCMCPU_IS_6338())
-			shared_res[0].end += (RSET_ENETDMA_SIZE / 2)  - 1;
-		else
-			shared_res[0].end += (RSET_ENETDMA_SIZE)  - 1;
+		shared_res[0].end += (RSET_ENETDMA_SIZE)  - 1;
+
+		shared_res[1].start = bcm63xx_regset_address(RSET_ENETDMAC);
+		shared_res[1].end = shared_res[1].start;
+		shared_res[1].end += RSET_ENETDMAC_SIZE(16)  - 1;
+
+		shared_res[2].start = bcm63xx_regset_address(RSET_ENETDMAS);
+		shared_res[2].end = shared_res[2].start;
+		shared_res[2].end += RSET_ENETDMAS_SIZE(16)  - 1;
 
 		ret = platform_device_register(&bcm63xx_enet_shared_device);
 		if (ret)
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
index 3362289..9981f4f 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
@@ -173,7 +173,9 @@ enum bcm63xx_regs_set {
 #define BCM_6358_RSET_SPI_SIZE		1804
 #define BCM_6368_RSET_SPI_SIZE		1804
 #define RSET_ENET_SIZE			2048
-#define RSET_ENETDMA_SIZE		2048
+#define RSET_ENETDMA_SIZE		256
+#define RSET_ENETDMAC_SIZE(chans)	(16 * (chans))
+#define RSET_ENETDMAS_SIZE(chans)	(16 * (chans))
 #define RSET_ENETSW_SIZE		65536
 #define RSET_UART_SIZE			24
 #define RSET_UDC_SIZE			256
diff --git a/drivers/net/ethernet/broadcom/bcm63xx_enet.c b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
index bc1a994..edaf76d 100644
--- a/drivers/net/ethernet/broadcom/bcm63xx_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
@@ -41,8 +41,8 @@ static int copybreak __read_mostly = 128;
 module_param(copybreak, int, 0);
 MODULE_PARM_DESC(copybreak, "Receive copy threshold");
 
-/* io memory shared between all devices */
-static void __iomem *bcm_enet_shared_base;
+/* io registers memory shared between all devices */
+static void __iomem *bcm_enet_shared_base[3];
 
 /*
  * io helpers to access mac registers
@@ -63,13 +63,35 @@ static inline void enet_writel(struct bcm_enet_priv *priv,
  */
 static inline u32 enet_dma_readl(struct bcm_enet_priv *priv, u32 off)
 {
-	return bcm_readl(bcm_enet_shared_base + off);
+	return bcm_readl(bcm_enet_shared_base[0] + off);
 }
 
 static inline void enet_dma_writel(struct bcm_enet_priv *priv,
 				       u32 val, u32 off)
 {
-	bcm_writel(val, bcm_enet_shared_base + off);
+	bcm_writel(val, bcm_enet_shared_base[0] + off);
+}
+
+static inline u32 enet_dmac_readl(struct bcm_enet_priv *priv, u32 off)
+{
+	return bcm_readl(bcm_enet_shared_base[1] + off);
+}
+
+static inline void enet_dmac_writel(struct bcm_enet_priv *priv,
+				       u32 val, u32 off)
+{
+	bcm_writel(val, bcm_enet_shared_base[1] + off);
+}
+
+static inline u32 enet_dmas_readl(struct bcm_enet_priv *priv, u32 off)
+{
+	return bcm_readl(bcm_enet_shared_base[2] + off);
+}
+
+static inline void enet_dmas_writel(struct bcm_enet_priv *priv,
+				       u32 val, u32 off)
+{
+	bcm_writel(val, bcm_enet_shared_base[2] + off);
 }
 
 /*
@@ -353,8 +375,8 @@ static int bcm_enet_receive_queue(struct net_device *dev, int budget)
 		bcm_enet_refill_rx(dev);
 
 		/* kick rx dma */
-		enet_dma_writel(priv, ENETDMA_CHANCFG_EN_MASK,
-				ENETDMA_CHANCFG_REG(priv->rx_chan));
+		enet_dmac_writel(priv, ENETDMAC_CHANCFG_EN_MASK,
+				 ENETDMAC_CHANCFG_REG(priv->rx_chan));
 	}
 
 	return processed;
@@ -429,10 +451,10 @@ static int bcm_enet_poll(struct napi_struct *napi, int budget)
 	dev = priv->net_dev;
 
 	/* ack interrupts */
-	enet_dma_writel(priv, ENETDMA_IR_PKTDONE_MASK,
-			ENETDMA_IR_REG(priv->rx_chan));
-	enet_dma_writel(priv, ENETDMA_IR_PKTDONE_MASK,
-			ENETDMA_IR_REG(priv->tx_chan));
+	enet_dmac_writel(priv, ENETDMAC_IR_PKTDONE_MASK,
+			 ENETDMAC_IR_REG(priv->rx_chan));
+	enet_dmac_writel(priv, ENETDMAC_IR_PKTDONE_MASK,
+			 ENETDMAC_IR_REG(priv->tx_chan));
 
 	/* reclaim sent skb */
 	tx_work_done = bcm_enet_tx_reclaim(dev, 0);
@@ -451,10 +473,10 @@ static int bcm_enet_poll(struct napi_struct *napi, int budget)
 	napi_complete(napi);
 
 	/* restore rx/tx interrupt */
-	enet_dma_writel(priv, ENETDMA_IR_PKTDONE_MASK,
-			ENETDMA_IRMASK_REG(priv->rx_chan));
-	enet_dma_writel(priv, ENETDMA_IR_PKTDONE_MASK,
-			ENETDMA_IRMASK_REG(priv->tx_chan));
+	enet_dmac_writel(priv, ENETDMAC_IR_PKTDONE_MASK,
+			 ENETDMAC_IRMASK_REG(priv->rx_chan));
+	enet_dmac_writel(priv, ENETDMAC_IR_PKTDONE_MASK,
+			 ENETDMAC_IRMASK_REG(priv->tx_chan));
 
 	return rx_work_done;
 }
@@ -497,8 +519,8 @@ static irqreturn_t bcm_enet_isr_dma(int irq, void *dev_id)
 	priv = netdev_priv(dev);
 
 	/* mask rx/tx interrupts */
-	enet_dma_writel(priv, 0, ENETDMA_IRMASK_REG(priv->rx_chan));
-	enet_dma_writel(priv, 0, ENETDMA_IRMASK_REG(priv->tx_chan));
+	enet_dmac_writel(priv, 0, ENETDMAC_IRMASK_REG(priv->rx_chan));
+	enet_dmac_writel(priv, 0, ENETDMAC_IRMASK_REG(priv->tx_chan));
 
 	napi_schedule(&priv->napi);
 
@@ -557,8 +579,8 @@ static int bcm_enet_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	wmb();
 
 	/* kick tx dma */
-	enet_dma_writel(priv, ENETDMA_CHANCFG_EN_MASK,
-			ENETDMA_CHANCFG_REG(priv->tx_chan));
+	enet_dmac_writel(priv, ENETDMAC_CHANCFG_EN_MASK,
+			 ENETDMAC_CHANCFG_REG(priv->tx_chan));
 
 	/* stop queue if no more desc available */
 	if (!priv->tx_desc_count)
@@ -833,8 +855,8 @@ static int bcm_enet_open(struct net_device *dev)
 
 	/* mask all interrupts and request them */
 	enet_writel(priv, 0, ENET_IRMASK_REG);
-	enet_dma_writel(priv, 0, ENETDMA_IRMASK_REG(priv->rx_chan));
-	enet_dma_writel(priv, 0, ENETDMA_IRMASK_REG(priv->tx_chan));
+	enet_dmac_writel(priv, 0, ENETDMAC_IRMASK_REG(priv->rx_chan));
+	enet_dmac_writel(priv, 0, ENETDMAC_IRMASK_REG(priv->tx_chan));
 
 	ret = request_irq(dev->irq, bcm_enet_isr_mac, 0, dev->name, dev);
 	if (ret)
@@ -919,28 +941,28 @@ static int bcm_enet_open(struct net_device *dev)
 	}
 
 	/* write rx & tx ring addresses */
-	enet_dma_writel(priv, priv->rx_desc_dma,
-			ENETDMA_RSTART_REG(priv->rx_chan));
-	enet_dma_writel(priv, priv->tx_desc_dma,
-			ENETDMA_RSTART_REG(priv->tx_chan));
+	enet_dmas_writel(priv, priv->rx_desc_dma,
+			 ENETDMAS_RSTART_REG(priv->rx_chan));
+	enet_dmas_writel(priv, priv->tx_desc_dma,
+			 ENETDMAS_RSTART_REG(priv->tx_chan));
 
 	/* clear remaining state ram for rx & tx channel */
-	enet_dma_writel(priv, 0, ENETDMA_SRAM2_REG(priv->rx_chan));
-	enet_dma_writel(priv, 0, ENETDMA_SRAM2_REG(priv->tx_chan));
-	enet_dma_writel(priv, 0, ENETDMA_SRAM3_REG(priv->rx_chan));
-	enet_dma_writel(priv, 0, ENETDMA_SRAM3_REG(priv->tx_chan));
-	enet_dma_writel(priv, 0, ENETDMA_SRAM4_REG(priv->rx_chan));
-	enet_dma_writel(priv, 0, ENETDMA_SRAM4_REG(priv->tx_chan));
+	enet_dmas_writel(priv, 0, ENETDMAS_SRAM2_REG(priv->rx_chan));
+	enet_dmas_writel(priv, 0, ENETDMAS_SRAM2_REG(priv->tx_chan));
+	enet_dmas_writel(priv, 0, ENETDMAS_SRAM3_REG(priv->rx_chan));
+	enet_dmas_writel(priv, 0, ENETDMAS_SRAM3_REG(priv->tx_chan));
+	enet_dmas_writel(priv, 0, ENETDMAS_SRAM4_REG(priv->rx_chan));
+	enet_dmas_writel(priv, 0, ENETDMAS_SRAM4_REG(priv->tx_chan));
 
 	/* set max rx/tx length */
 	enet_writel(priv, priv->hw_mtu, ENET_RXMAXLEN_REG);
 	enet_writel(priv, priv->hw_mtu, ENET_TXMAXLEN_REG);
 
 	/* set dma maximum burst len */
-	enet_dma_writel(priv, BCMENET_DMA_MAXBURST,
-			ENETDMA_MAXBURST_REG(priv->rx_chan));
-	enet_dma_writel(priv, BCMENET_DMA_MAXBURST,
-			ENETDMA_MAXBURST_REG(priv->tx_chan));
+	enet_dmac_writel(priv, BCMENET_DMA_MAXBURST,
+			 ENETDMAC_MAXBURST_REG(priv->rx_chan));
+	enet_dmac_writel(priv, BCMENET_DMA_MAXBURST,
+			 ENETDMAC_MAXBURST_REG(priv->tx_chan));
 
 	/* set correct transmit fifo watermark */
 	enet_writel(priv, BCMENET_TX_FIFO_TRESH, ENET_TXWMARK_REG);
@@ -958,26 +980,26 @@ static int bcm_enet_open(struct net_device *dev)
 	val |= ENET_CTL_ENABLE_MASK;
 	enet_writel(priv, val, ENET_CTL_REG);
 	enet_dma_writel(priv, ENETDMA_CFG_EN_MASK, ENETDMA_CFG_REG);
-	enet_dma_writel(priv, ENETDMA_CHANCFG_EN_MASK,
-			ENETDMA_CHANCFG_REG(priv->rx_chan));
+	enet_dmac_writel(priv, ENETDMAC_CHANCFG_EN_MASK,
+			 ENETDMAC_CHANCFG_REG(priv->rx_chan));
 
 	/* watch "mib counters about to overflow" interrupt */
 	enet_writel(priv, ENET_IR_MIB, ENET_IR_REG);
 	enet_writel(priv, ENET_IR_MIB, ENET_IRMASK_REG);
 
 	/* watch "packet transferred" interrupt in rx and tx */
-	enet_dma_writel(priv, ENETDMA_IR_PKTDONE_MASK,
-			ENETDMA_IR_REG(priv->rx_chan));
-	enet_dma_writel(priv, ENETDMA_IR_PKTDONE_MASK,
-			ENETDMA_IR_REG(priv->tx_chan));
+	enet_dmac_writel(priv, ENETDMAC_IR_PKTDONE_MASK,
+			 ENETDMAC_IR_REG(priv->rx_chan));
+	enet_dmac_writel(priv, ENETDMAC_IR_PKTDONE_MASK,
+			 ENETDMAC_IR_REG(priv->tx_chan));
 
 	/* make sure we enable napi before rx interrupt  */
 	napi_enable(&priv->napi);
 
-	enet_dma_writel(priv, ENETDMA_IR_PKTDONE_MASK,
-			ENETDMA_IRMASK_REG(priv->rx_chan));
-	enet_dma_writel(priv, ENETDMA_IR_PKTDONE_MASK,
-			ENETDMA_IRMASK_REG(priv->tx_chan));
+	enet_dmac_writel(priv, ENETDMAC_IR_PKTDONE_MASK,
+			 ENETDMAC_IRMASK_REG(priv->rx_chan));
+	enet_dmac_writel(priv, ENETDMAC_IR_PKTDONE_MASK,
+			 ENETDMAC_IRMASK_REG(priv->tx_chan));
 
 	if (priv->has_phy)
 		phy_start(priv->phydev);
@@ -1057,14 +1079,14 @@ static void bcm_enet_disable_dma(struct bcm_enet_priv *priv, int chan)
 {
 	int limit;
 
-	enet_dma_writel(priv, 0, ENETDMA_CHANCFG_REG(chan));
+	enet_dmac_writel(priv, 0, ENETDMAC_CHANCFG_REG(chan));
 
 	limit = 1000;
 	do {
 		u32 val;
 
-		val = enet_dma_readl(priv, ENETDMA_CHANCFG_REG(chan));
-		if (!(val & ENETDMA_CHANCFG_EN_MASK))
+		val = enet_dmac_readl(priv, ENETDMAC_CHANCFG_REG(chan));
+		if (!(val & ENETDMAC_CHANCFG_EN_MASK))
 			break;
 		udelay(1);
 	} while (limit--);
@@ -1090,8 +1112,8 @@ static int bcm_enet_stop(struct net_device *dev)
 
 	/* mask all interrupts */
 	enet_writel(priv, 0, ENET_IRMASK_REG);
-	enet_dma_writel(priv, 0, ENETDMA_IRMASK_REG(priv->rx_chan));
-	enet_dma_writel(priv, 0, ENETDMA_IRMASK_REG(priv->tx_chan));
+	enet_dmac_writel(priv, 0, ENETDMAC_IRMASK_REG(priv->rx_chan));
+	enet_dmac_writel(priv, 0, ENETDMAC_IRMASK_REG(priv->tx_chan));
 
 	/* make sure no mib update is scheduled */
 	cancel_work_sync(&priv->mib_update_task);
@@ -1636,7 +1658,7 @@ static int bcm_enet_probe(struct platform_device *pdev)
 
 	/* stop if shared driver failed, assume driver->probe will be
 	 * called in the same order we register devices (correct ?) */
-	if (!bcm_enet_shared_base)
+	if (!bcm_enet_shared_base[0])
 		return -ENODEV;
 
 	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1881,14 +1903,19 @@ struct platform_driver bcm63xx_enet_driver = {
 static int bcm_enet_shared_probe(struct platform_device *pdev)
 {
 	struct resource *res;
+	void __iomem *p[3];
+	unsigned int i;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
+	memset(bcm_enet_shared_base, 0, sizeof(bcm_enet_shared_base));
 
-	bcm_enet_shared_base = devm_request_and_ioremap(&pdev->dev, res);
-	if (!bcm_enet_shared_base)
-		return -ENOMEM;
+	for (i = 0; i < 3; i++) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
+		p[i] = devm_ioremap_resource(&pdev->dev, res);
+		if (!p[i])
+			return -ENOMEM;
+	}
+
+	memcpy(bcm_enet_shared_base, p, sizeof(bcm_enet_shared_base));
 
 	return 0;
 }
-- 
1.7.10.4
