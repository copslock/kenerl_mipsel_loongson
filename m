Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Aug 2018 13:43:57 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:38154 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994691AbeHGLmefUt6B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Aug 2018 13:42:34 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     Paul Cercueil <paul@crapouillou.net>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH v4 07/18] dmaengine: dma-jz4780: Add support for the JZ4770 SoC
Date:   Tue,  7 Aug 2018 13:42:07 +0200
Message-Id: <20180807114218.20091-8-paul@crapouillou.net>
In-Reply-To: <20180807114218.20091-1-paul@crapouillou.net>
References: <20180807114218.20091-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1533642153; bh=5pdeUGnp6Gi99hB2M32bntDyURWuy6AHodFNizu8n50=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=gOub0+gYNvCiQ7RUaqVxCJiUY6JuUVSZ4+csRT9esvbzqdidXAxwUDp8cvnO0gK+JVgA6Pof1vUhYjwUeLP8RaqK7bI3yn4dVZ8VTXd49VqB8q9zYi6vLG5NIIcE7AmMz/xE0+Y/1ulv+L/ow2qP0qiceO5HounFX9djmURgQ64=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65454
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
Tested-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/dma/dma-jz4780.c | 61 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 54 insertions(+), 7 deletions(-)

 v2: - Move transfer_ord_max variable to the new jz4780_dma_soc_data
       structure
     - The documentation update is now in patch 01/17

 v3: The Kconfig update was dropped thanks to patch 06/18

 v4: Pass jz4780_dma_soc_data structure pointer directly as devicetree
     match data; Add a 'flags' field in that structure and macros for
     it, to replace checking vs. the SoC version.

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 7683de9fb9ee..184d1a2bf9ba 100644
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
@@ -87,6 +90,11 @@
 
 #define JZ4780_DMA_CTRL_OFFSET	0x1000
 
+/* macros for use with jz4780_dma_soc_data.flags */
+#define JZ_SOC_DATA_ALLOW_LEGACY_DT	BIT(0)
+#define JZ_SOC_DATA_PROGRAMMABLE_DMA	BIT(1)
+#define JZ_SOC_DATA_PER_CHAN_PM		BIT(2)
+
 /**
  * struct jz4780_dma_hwdesc - descriptor structure read by the DMA controller.
  * @dcm: value for the DCM (channel command) register
@@ -133,6 +141,8 @@ struct jz4780_dma_chan {
 
 struct jz4780_dma_soc_data {
 	unsigned int nb_channels;
+	unsigned int transfer_ord_max;
+	unsigned long flags;
 };
 
 struct jz4780_dma_dev {
@@ -195,6 +205,20 @@ static inline void jz4780_dma_ctrl_writel(struct jz4780_dma_dev *jzdma,
 	writel(val, jzdma->ctrl_base + reg);
 }
 
+static inline void jz4780_dma_chan_enable(struct jz4780_dma_dev *jzdma,
+	unsigned int chn)
+{
+	if (jzdma->soc_data->flags & JZ_SOC_DATA_PER_CHAN_PM)
+		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DCKES, BIT(chn));
+}
+
+static inline void jz4780_dma_chan_disable(struct jz4780_dma_dev *jzdma,
+	unsigned int chn)
+{
+	if (jzdma->soc_data->flags & JZ_SOC_DATA_PER_CHAN_PM)
+		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DCKEC, BIT(chn));
+}
+
 static struct jz4780_dma_desc *jz4780_dma_desc_alloc(
 	struct jz4780_dma_chan *jzchan, unsigned int count,
 	enum dma_transaction_type type)
@@ -229,8 +253,10 @@ static void jz4780_dma_desc_free(struct virt_dma_desc *vdesc)
 	kfree(desc);
 }
 
-static uint32_t jz4780_dma_transfer_size(unsigned long val, uint32_t *shift)
+static uint32_t jz4780_dma_transfer_size(struct jz4780_dma_chan *jzchan,
+	unsigned long val, uint32_t *shift)
 {
+	struct jz4780_dma_dev *jzdma = jz4780_dma_chan_parent(jzchan);
 	int ord = ffs(val) - 1;
 
 	/*
@@ -242,8 +268,8 @@ static uint32_t jz4780_dma_transfer_size(unsigned long val, uint32_t *shift)
 	 */
 	if (ord == 3)
 		ord = 2;
-	else if (ord > 7)
-		ord = 7;
+	else if (ord > jzdma->soc_data->transfer_ord_max)
+		ord = jzdma->soc_data->transfer_ord_max;
 
 	*shift = ord;
 
@@ -295,7 +321,7 @@ static int jz4780_dma_setup_hwdesc(struct jz4780_dma_chan *jzchan,
 	 * divisible by the transfer size, and we must not use more than the
 	 * maximum burst specified by the user.
 	 */
-	tsz = jz4780_dma_transfer_size(addr | len | (width * maxburst),
+	tsz = jz4780_dma_transfer_size(jzchan, addr | len | (width * maxburst),
 				       &jzchan->transfer_shift);
 
 	switch (width) {
@@ -424,7 +450,7 @@ static struct dma_async_tx_descriptor *jz4780_dma_prep_dma_memcpy(
 	if (!desc)
 		return NULL;
 
-	tsz = jz4780_dma_transfer_size(dest | src | len,
+	tsz = jz4780_dma_transfer_size(jzchan, dest | src | len,
 				       &jzchan->transfer_shift);
 
 	jzchan->transfer_type = JZ_DMA_DRT_AUTO;
@@ -485,6 +511,9 @@ static void jz4780_dma_begin(struct jz4780_dma_chan *jzchan)
 			(jzchan->curr_hwdesc + 1) % jzchan->desc->count;
 	}
 
+	/* Enable the channel's clock. */
+	jz4780_dma_chan_enable(jzdma, jzchan->id);
+
 	/* Use 4-word descriptors. */
 	jz4780_dma_chn_writel(jzdma, jzchan->id, JZ_DMA_REG_DCS, 0);
 
@@ -532,6 +561,8 @@ static int jz4780_dma_terminate_all(struct dma_chan *chan)
 		jzchan->desc = NULL;
 	}
 
+	jz4780_dma_chan_disable(jzdma, jzchan->id);
+
 	vchan_get_all_descriptors(&jzchan->vchan, &head);
 
 	spin_unlock_irqrestore(&jzchan->vchan.lock, flags);
@@ -543,8 +574,10 @@ static int jz4780_dma_terminate_all(struct dma_chan *chan)
 static void jz4780_dma_synchronize(struct dma_chan *chan)
 {
 	struct jz4780_dma_chan *jzchan = to_jz4780_dma_chan(chan);
+	struct jz4780_dma_dev *jzdma = jz4780_dma_chan_parent(jzchan);
 
 	vchan_synchronize(&jzchan->vchan);
+	jz4780_dma_chan_disable(jzdma, jzchan->id);
 }
 
 static int jz4780_dma_config(struct dma_chan *chan,
@@ -812,13 +845,16 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 		jzdma->ctrl_base = devm_ioremap_resource(dev, res);
 		if (IS_ERR(jzdma->ctrl_base))
 			return PTR_ERR(jzdma->ctrl_base);
-	} else {
+	} else if (soc_data->flags & JZ_SOC_DATA_ALLOW_LEGACY_DT) {
 		/*
 		 * On JZ4780, if the second memory resource was not supplied,
 		 * assume we're using an old devicetree, and calculate the
 		 * offset to the control registers.
 		 */
 		jzdma->ctrl_base = jzdma->chn_base + JZ4780_DMA_CTRL_OFFSET;
+	} else {
+		dev_err(dev, "failed to get I/O memory\n");
+		return -EINVAL;
 	}
 
 	ret = platform_get_irq(pdev, 0);
@@ -879,7 +915,9 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 	 */
 	jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DMAC,
 			  JZ_DMA_DMAC_DMAE | JZ_DMA_DMAC_FMSC);
-	jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DMACP, 0);
+
+	if (soc_data->flags & JZ_SOC_DATA_PROGRAMMABLE_DMA)
+		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DMACP, 0);
 
 	INIT_LIST_HEAD(&dd->channels);
 
@@ -935,11 +973,20 @@ static int jz4780_dma_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct jz4780_dma_soc_data jz4770_dma_soc_data = {
+	.nb_channels = 6,
+	.transfer_ord_max = 6,
+	.flags = JZ_SOC_DATA_PER_CHAN_PM,
+};
+
 static const struct jz4780_dma_soc_data jz4780_dma_soc_data = {
 	.nb_channels = 32,
+	.transfer_ord_max = 7,
+	.flags = JZ_SOC_DATA_ALLOW_LEGACY_DT | JZ_SOC_DATA_PROGRAMMABLE_DMA,
 };
 
 static const struct of_device_id jz4780_dma_dt_match[] = {
+	{ .compatible = "ingenic,jz4770-dma", .data = &jz4770_dma_soc_data },
 	{ .compatible = "ingenic,jz4780-dma", .data = &jz4780_dma_soc_data },
 	{},
 };
-- 
2.11.0
