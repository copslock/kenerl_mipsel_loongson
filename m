Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jul 2018 14:33:40 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:60884 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994563AbeGCMcdWJyOz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Jul 2018 14:32:33 +0200
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
Subject: [PATCH 04/14] dmaengine: dma-jz4780: Add support for the JZ4770 SoC
Date:   Tue,  3 Jul 2018 14:32:04 +0200
Message-Id: <20180703123214.23090-5-paul@crapouillou.net>
In-Reply-To: <20180703123214.23090-1-paul@crapouillou.net>
References: <20180703123214.23090-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1530621152; bh=IgIAFNqofyYJGHH+PBOKAsb1a4k1f7wiOWaKKTAwTHY=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=JUg87bbIMPTpDbwiFBPASBWMfUnt9/fGYfPbKy2vGjgftUQ32ck121p8Kze6kGsDaReuHW7JEfh40MgD2pcgB0OwpjnptClbT3MFUp/71+JCFBN45+zm8TZkR5Bx76xxlxn2vJfYlzc8oycWvd990HYt+4Aoh+L+BkR7vZzF4dU=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64568
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

The JZ4770 SoC has two DMA cores, each one featuring six DMA channels.
The major change is that each channel's clock can be enabled or disabled
through register writes.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 .../devicetree/bindings/dma/jz4780-dma.txt    |  4 +-
 drivers/dma/Kconfig                           |  2 +-
 drivers/dma/dma-jz4780.c                      | 48 ++++++++++++++++---
 3 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/jz4780-dma.txt b/Documentation/devicetree/bindings/dma/jz4780-dma.txt
index f9b1864f5b77..0fd0759053be 100644
--- a/Documentation/devicetree/bindings/dma/jz4780-dma.txt
+++ b/Documentation/devicetree/bindings/dma/jz4780-dma.txt
@@ -2,7 +2,9 @@
 
 Required properties:
 
-- compatible: Should be "ingenic,jz4780-dma"
+- compatible: Should be one of:
+  * ingenic,jz4780-dma
+  * ingenic,jz4770-dma
 - reg: Should contain the DMA channel registers location and length, followed
   by the DMA controller registers location and length.
 - interrupts: Should contain the interrupt specifier of the DMA controller.
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index ca1680afa20a..48d25dccedb7 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -143,7 +143,7 @@ config DMA_JZ4740
 
 config DMA_JZ4780
 	tristate "JZ4780 DMA support"
-	depends on MACH_JZ4780 || COMPILE_TEST
+	depends on MACH_JZ4780 || MACH_JZ4770 || COMPILE_TEST
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index cd2cd70fd843..7b8b2dcd119e 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -29,6 +29,9 @@
 #define JZ_DMA_REG_DIRQP	0x04
 #define JZ_DMA_REG_DDR		0x08
 #define JZ_DMA_REG_DDRS		0x0c
+#define JZ_DMA_REG_DCKE		0x10
+#define JZ_DMA_REG_DCKES	0x14
+#define JZ_DMA_REG_DCKEC	0x18
 #define JZ_DMA_REG_DMACP	0x1c
 #define JZ_DMA_REG_DSIRQP	0x20
 #define JZ_DMA_REG_DSIRQM	0x24
@@ -130,6 +133,7 @@ struct jz4780_dma_chan {
 };
 
 enum jz_version {
+	ID_JZ4770,
 	ID_JZ4780,
 };
 
@@ -194,6 +198,20 @@ static inline void jz4780_dma_ctrl_writel(struct jz4780_dma_dev *jzdma,
 	writel(val, jzdma->ctrl_base + reg);
 }
 
+static inline void jz4780_dma_chan_enable(struct jz4780_dma_dev *jzdma,
+	unsigned int chn)
+{
+	if (jzdma->version == ID_JZ4770)
+		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DCKES, BIT(chn));
+}
+
+static inline void jz4780_dma_chan_disable(struct jz4780_dma_dev *jzdma,
+	unsigned int chn)
+{
+	if (jzdma->version == ID_JZ4770)
+		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DCKEC, BIT(chn));
+}
+
 static struct jz4780_dma_desc *jz4780_dma_desc_alloc(
 	struct jz4780_dma_chan *jzchan, unsigned int count,
 	enum dma_transaction_type type)
@@ -228,8 +246,15 @@ static void jz4780_dma_desc_free(struct virt_dma_desc *vdesc)
 	kfree(desc);
 }
 
-static uint32_t jz4780_dma_transfer_size(unsigned long val, uint32_t *shift)
+static const unsigned int jz4780_dma_ord_max[] = {
+	[ID_JZ4770] = 6,
+	[ID_JZ4780] = 7,
+};
+
+static uint32_t jz4780_dma_transfer_size(struct jz4780_dma_chan *jzchan,
+	unsigned long val, uint32_t *shift)
 {
+	struct jz4780_dma_dev *jzdma = jz4780_dma_chan_parent(jzchan);
 	int ord = ffs(val) - 1;
 
 	/*
@@ -241,8 +266,8 @@ static uint32_t jz4780_dma_transfer_size(unsigned long val, uint32_t *shift)
 	 */
 	if (ord == 3)
 		ord = 2;
-	else if (ord > 7)
-		ord = 7;
+	else if (ord > jz4780_dma_ord_max[jzdma->version])
+		ord = jz4780_dma_ord_max[jzdma->version];
 
 	*shift = ord;
 
@@ -294,7 +319,7 @@ static int jz4780_dma_setup_hwdesc(struct jz4780_dma_chan *jzchan,
 	 * divisible by the transfer size, and we must not use more than the
 	 * maximum burst specified by the user.
 	 */
-	tsz = jz4780_dma_transfer_size(addr | len | (width * maxburst),
+	tsz = jz4780_dma_transfer_size(jzchan, addr | len | (width * maxburst),
 				       &jzchan->transfer_shift);
 
 	switch (width) {
@@ -423,7 +448,7 @@ static struct dma_async_tx_descriptor *jz4780_dma_prep_dma_memcpy(
 	if (!desc)
 		return NULL;
 
-	tsz = jz4780_dma_transfer_size(dest | src | len,
+	tsz = jz4780_dma_transfer_size(jzchan, dest | src | len,
 				       &jzchan->transfer_shift);
 
 	jzchan->transfer_type = JZ_DMA_DRT_AUTO;
@@ -484,6 +509,9 @@ static void jz4780_dma_begin(struct jz4780_dma_chan *jzchan)
 			(jzchan->curr_hwdesc + 1) % jzchan->desc->count;
 	}
 
+	/* Enable the channel's clock. */
+	jz4780_dma_chan_enable(jzdma, jzchan->id);
+
 	/* Use 4-word descriptors. */
 	jz4780_dma_chn_writel(jzdma, jzchan->id, JZ_DMA_REG_DCS, 0);
 
@@ -531,6 +559,8 @@ static int jz4780_dma_terminate_all(struct dma_chan *chan)
 		jzchan->desc = NULL;
 	}
 
+	jz4780_dma_chan_disable(jzdma, jzchan->id);
+
 	vchan_get_all_descriptors(&jzchan->vchan, &head);
 
 	spin_unlock_irqrestore(&jzchan->vchan.lock, flags);
@@ -542,8 +572,10 @@ static int jz4780_dma_terminate_all(struct dma_chan *chan)
 static void jz4780_dma_synchronize(struct dma_chan *chan)
 {
 	struct jz4780_dma_chan *jzchan = to_jz4780_dma_chan(chan);
+	struct jz4780_dma_dev *jzdma = jz4780_dma_chan_parent(jzchan);
 
 	vchan_synchronize(&jzchan->vchan);
+	jz4780_dma_chan_disable(jzdma, jzchan->id);
 }
 
 static int jz4780_dma_config(struct dma_chan *chan,
@@ -769,10 +801,12 @@ static struct dma_chan *jz4780_of_dma_xlate(struct of_phandle_args *dma_spec,
 }
 
 static const unsigned int jz4780_dma_nb_channels[] = {
+	[ID_JZ4770] = 6,
 	[ID_JZ4780] = 32,
 };
 
 static const struct of_device_id jz4780_dma_dt_match[] = {
+	{ .compatible = "ingenic,jz4770-dma", .data = (void *)ID_JZ4770 },
 	{ .compatible = "ingenic,jz4780-dma", .data = (void *)ID_JZ4780 },
 	{},
 };
@@ -887,7 +921,9 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 	 */
 	jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DMAC,
 			  JZ_DMA_DMAC_DMAE | JZ_DMA_DMAC_FMSC);
-	jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DMACP, 0);
+
+	if (jzdma->version == ID_JZ4780)
+		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DMACP, 0);
 
 	INIT_LIST_HEAD(&dd->channels);
 
-- 
2.18.0
