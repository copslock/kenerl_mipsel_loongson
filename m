Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jul 2018 14:33:07 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:60130 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994061AbeGCMcariqRz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Jul 2018 14:32:30 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 02/14] dmaengine: dma-jz4780: Separate chan/ctrl registers
Date:   Tue,  3 Jul 2018 14:32:02 +0200
Message-Id: <20180703123214.23090-3-paul@crapouillou.net>
In-Reply-To: <20180703123214.23090-1-paul@crapouillou.net>
References: <20180703123214.23090-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1530621150; bh=0kST25I1bONUVXruVOnP5S/hyq5Ig3xo2KOScqNCHv8=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=MLanUC7auWTvJEHqyDVkMFxM3weGR6DppbD3elgZeeh7a5zAWuBaGyoZdKg5pQlkJmL7ltNBqHmFqtM7mVM/pjvSrADQJL1rGJ3Gy2pwt17KsUm6bsHnYXFi1PgN0ePO2peO+EHKqkeKXC29zvPh47yT2eYrFYZGTpMYhkDMFMw=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64566
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

The register area of the JZ4780 DMA core can be split into different
sections for different purposes:

* one set of registers is used to perform actions at the DMA core level,
that will generally affect all channels;

* one set of registers per DMA channel, to perform actions at the DMA
channel level, that will only affect the channel in question.

The problem rises when trying to support new versions of the JZ47xx
Ingenic SoC. For instance, the JZ4770 has two DMA cores, each one
with six DMA channels, and the register sets are interleaved:
<DMA0 chan regs> <DMA1 chan regs> <DMA0 ctrl regs> <DMA1 ctrl regs>

By using one memory resource for the channel-specific registers and
one memory resource for the core-specific registers, we can support
the JZ4770, by initializing the driver once per DMA core with different
addresses.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 .../devicetree/bindings/dma/jz4780-dma.txt    |   6 +-
 drivers/dma/dma-jz4780.c                      | 106 +++++++++++-------
 2 files changed, 69 insertions(+), 43 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/jz4780-dma.txt b/Documentation/devicetree/bindings/dma/jz4780-dma.txt
index f25feee62b15..f9b1864f5b77 100644
--- a/Documentation/devicetree/bindings/dma/jz4780-dma.txt
+++ b/Documentation/devicetree/bindings/dma/jz4780-dma.txt
@@ -3,7 +3,8 @@
 Required properties:
 
 - compatible: Should be "ingenic,jz4780-dma"
-- reg: Should contain the DMA controller registers location and length.
+- reg: Should contain the DMA channel registers location and length, followed
+  by the DMA controller registers location and length.
 - interrupts: Should contain the interrupt specifier of the DMA controller.
 - interrupt-parent: Should be the phandle of the interrupt controller that
 - clocks: Should contain a clock specifier for the JZ4780 PDMA clock.
@@ -22,7 +23,8 @@ Example:
 
 dma: dma@13420000 {
 	compatible = "ingenic,jz4780-dma";
-	reg = <0x13420000 0x10000>;
+	reg = <0x13420000 0x400
+	       0x13421000 0x40>;
 
 	interrupt-parent = <&intc>;
 	interrupts = <10>;
diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index b40f491f0367..4d234caf5d62 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -25,26 +25,26 @@
 #include "virt-dma.h"
 
 /* Global registers. */
-#define JZ_DMA_REG_DMAC		0x1000
-#define JZ_DMA_REG_DIRQP	0x1004
-#define JZ_DMA_REG_DDR		0x1008
-#define JZ_DMA_REG_DDRS		0x100c
-#define JZ_DMA_REG_DMACP	0x101c
-#define JZ_DMA_REG_DSIRQP	0x1020
-#define JZ_DMA_REG_DSIRQM	0x1024
-#define JZ_DMA_REG_DCIRQP	0x1028
-#define JZ_DMA_REG_DCIRQM	0x102c
+#define JZ_DMA_REG_DMAC		0x00
+#define JZ_DMA_REG_DIRQP	0x04
+#define JZ_DMA_REG_DDR		0x08
+#define JZ_DMA_REG_DDRS		0x0c
+#define JZ_DMA_REG_DMACP	0x1c
+#define JZ_DMA_REG_DSIRQP	0x20
+#define JZ_DMA_REG_DSIRQM	0x24
+#define JZ_DMA_REG_DCIRQP	0x28
+#define JZ_DMA_REG_DCIRQM	0x2c
 
 /* Per-channel registers. */
 #define JZ_DMA_REG_CHAN(n)	(n * 0x20)
-#define JZ_DMA_REG_DSA(n)	(0x00 + JZ_DMA_REG_CHAN(n))
-#define JZ_DMA_REG_DTA(n)	(0x04 + JZ_DMA_REG_CHAN(n))
-#define JZ_DMA_REG_DTC(n)	(0x08 + JZ_DMA_REG_CHAN(n))
-#define JZ_DMA_REG_DRT(n)	(0x0c + JZ_DMA_REG_CHAN(n))
-#define JZ_DMA_REG_DCS(n)	(0x10 + JZ_DMA_REG_CHAN(n))
-#define JZ_DMA_REG_DCM(n)	(0x14 + JZ_DMA_REG_CHAN(n))
-#define JZ_DMA_REG_DDA(n)	(0x18 + JZ_DMA_REG_CHAN(n))
-#define JZ_DMA_REG_DSD(n)	(0x1c + JZ_DMA_REG_CHAN(n))
+#define JZ_DMA_REG_DSA		0x00
+#define JZ_DMA_REG_DTA		0x04
+#define JZ_DMA_REG_DTC		0x08
+#define JZ_DMA_REG_DRT		0x0c
+#define JZ_DMA_REG_DCS		0x10
+#define JZ_DMA_REG_DCM		0x14
+#define JZ_DMA_REG_DDA		0x18
+#define JZ_DMA_REG_DSD		0x1c
 
 #define JZ_DMA_DMAC_DMAE	BIT(0)
 #define JZ_DMA_DMAC_AR		BIT(2)
@@ -140,7 +140,8 @@ enum jz_version {
 
 struct jz4780_dma_dev {
 	struct dma_device dma_device;
-	void __iomem *base;
+	void __iomem *chn_base;
+	void __iomem *ctrl_base;
 	struct clk *clk;
 	unsigned int irq;
 	unsigned int nb_channels;
@@ -174,16 +175,28 @@ static inline struct jz4780_dma_dev *jz4780_dma_chan_parent(
 			    dma_device);
 }
 
-static inline uint32_t jz4780_dma_readl(struct jz4780_dma_dev *jzdma,
+static inline uint32_t jz4780_dma_chn_readl(struct jz4780_dma_dev *jzdma,
+	unsigned int chn, unsigned int reg)
+{
+	return readl(jzdma->chn_base + reg + JZ_DMA_REG_CHAN(chn));
+}
+
+static inline void jz4780_dma_chn_writel(struct jz4780_dma_dev *jzdma,
+	unsigned int chn, unsigned int reg, uint32_t val)
+{
+	writel(val, jzdma->chn_base + reg + JZ_DMA_REG_CHAN(chn));
+}
+
+static inline uint32_t jz4780_dma_ctrl_readl(struct jz4780_dma_dev *jzdma,
 	unsigned int reg)
 {
-	return readl(jzdma->base + reg);
+	return readl(jzdma->ctrl_base + reg);
 }
 
-static inline void jz4780_dma_writel(struct jz4780_dma_dev *jzdma,
+static inline void jz4780_dma_ctrl_writel(struct jz4780_dma_dev *jzdma,
 	unsigned int reg, uint32_t val)
 {
-	writel(val, jzdma->base + reg);
+	writel(val, jzdma->ctrl_base + reg);
 }
 
 static struct jz4780_dma_desc *jz4780_dma_desc_alloc(
@@ -478,17 +491,18 @@ static void jz4780_dma_begin(struct jz4780_dma_chan *jzchan)
 	}
 
 	/* Use 8-word descriptors. */
-	jz4780_dma_writel(jzdma, JZ_DMA_REG_DCS(jzchan->id), JZ_DMA_DCS_DES8);
+	jz4780_dma_chn_writel(jzdma, jzchan->id,
+			      JZ_DMA_REG_DCS, JZ_DMA_DCS_DES8);
 
 	/* Write descriptor address and initiate descriptor fetch. */
 	desc_phys = jzchan->desc->desc_phys +
 		    (jzchan->curr_hwdesc * sizeof(*jzchan->desc->desc));
-	jz4780_dma_writel(jzdma, JZ_DMA_REG_DDA(jzchan->id), desc_phys);
-	jz4780_dma_writel(jzdma, JZ_DMA_REG_DDRS, BIT(jzchan->id));
+	jz4780_dma_chn_writel(jzdma, jzchan->id, JZ_DMA_REG_DDA, desc_phys);
+	jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DDRS, BIT(jzchan->id));
 
 	/* Enable the channel. */
-	jz4780_dma_writel(jzdma, JZ_DMA_REG_DCS(jzchan->id),
-			  JZ_DMA_DCS_DES8 | JZ_DMA_DCS_CTE);
+	jz4780_dma_chn_writel(jzdma, jzchan->id, JZ_DMA_REG_DCS,
+			      JZ_DMA_DCS_DES8 | JZ_DMA_DCS_CTE);
 }
 
 static void jz4780_dma_issue_pending(struct dma_chan *chan)
@@ -514,7 +528,7 @@ static int jz4780_dma_terminate_all(struct dma_chan *chan)
 	spin_lock_irqsave(&jzchan->vchan.lock, flags);
 
 	/* Clear the DMA status and stop the transfer. */
-	jz4780_dma_writel(jzdma, JZ_DMA_REG_DCS(jzchan->id), 0);
+	jz4780_dma_chn_writel(jzdma, jzchan->id, JZ_DMA_REG_DCS, 0);
 	if (jzchan->desc) {
 		vchan_terminate_vdesc(&jzchan->desc->vdesc);
 		jzchan->desc = NULL;
@@ -563,8 +577,8 @@ static size_t jz4780_dma_desc_residue(struct jz4780_dma_chan *jzchan,
 		residue += desc->desc[i].dtc << jzchan->transfer_shift;
 
 	if (next_sg != 0) {
-		count = jz4780_dma_readl(jzdma,
-					 JZ_DMA_REG_DTC(jzchan->id));
+		count = jz4780_dma_chn_readl(jzdma, jzchan->id,
+					 JZ_DMA_REG_DTC);
 		residue += count << jzchan->transfer_shift;
 	}
 
@@ -611,8 +625,8 @@ static void jz4780_dma_chan_irq(struct jz4780_dma_dev *jzdma,
 
 	spin_lock(&jzchan->vchan.lock);
 
-	dcs = jz4780_dma_readl(jzdma, JZ_DMA_REG_DCS(jzchan->id));
-	jz4780_dma_writel(jzdma, JZ_DMA_REG_DCS(jzchan->id), 0);
+	dcs = jz4780_dma_chn_readl(jzdma, jzchan->id, JZ_DMA_REG_DCS);
+	jz4780_dma_chn_writel(jzdma, jzchan->id, JZ_DMA_REG_DCS, 0);
 
 	if (dcs & JZ_DMA_DCS_AR) {
 		dev_warn(&jzchan->vchan.chan.dev->device,
@@ -651,7 +665,7 @@ static irqreturn_t jz4780_dma_irq_handler(int irq, void *data)
 	uint32_t pending, dmac;
 	int i;
 
-	pending = jz4780_dma_readl(jzdma, JZ_DMA_REG_DIRQP);
+	pending = jz4780_dma_ctrl_readl(jzdma, JZ_DMA_REG_DIRQP);
 
 	for (i = 0; i < jzdma->nb_channels; i++) {
 		if (!(pending & (1<<i)))
@@ -661,12 +675,12 @@ static irqreturn_t jz4780_dma_irq_handler(int irq, void *data)
 	}
 
 	/* Clear halt and address error status of all channels. */
-	dmac = jz4780_dma_readl(jzdma, JZ_DMA_REG_DMAC);
+	dmac = jz4780_dma_ctrl_readl(jzdma, JZ_DMA_REG_DMAC);
 	dmac &= ~(JZ_DMA_DMAC_HLT | JZ_DMA_DMAC_AR);
-	jz4780_dma_writel(jzdma, JZ_DMA_REG_DMAC, dmac);
+	jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DMAC, dmac);
 
 	/* Clear interrupt pending status. */
-	jz4780_dma_writel(jzdma, JZ_DMA_REG_DIRQP, 0);
+	jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DIRQP, 0);
 
 	return IRQ_HANDLED;
 }
@@ -804,9 +818,19 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	jzdma->base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(jzdma->base))
-		return PTR_ERR(jzdma->base);
+	jzdma->chn_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(jzdma->chn_base))
+		return PTR_ERR(jzdma->chn_base);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!res) {
+		dev_err(dev, "failed to get I/O memory\n");
+		return -EINVAL;
+	}
+
+	jzdma->ctrl_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(jzdma->ctrl_base))
+		return PTR_ERR(jzdma->ctrl_base);
 
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0) {
@@ -864,9 +888,9 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 	 * Also set the FMSC bit - it increases MSC performance, so it makes
 	 * little sense not to enable it.
 	 */
-	jz4780_dma_writel(jzdma, JZ_DMA_REG_DMAC,
+	jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DMAC,
 			  JZ_DMA_DMAC_DMAE | JZ_DMA_DMAC_FMSC);
-	jz4780_dma_writel(jzdma, JZ_DMA_REG_DMACP, 0);
+	jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DMACP, 0);
 
 	INIT_LIST_HEAD(&dd->channels);
 
-- 
2.18.0
