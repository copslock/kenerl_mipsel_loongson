Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Jul 2018 13:08:39 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:56250 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993098AbeGULHkQ4Nri (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Jul 2018 13:07:40 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH v3 03/18] dmaengine: dma-jz4780: Avoid hardcoding number of channels
Date:   Sat, 21 Jul 2018 13:06:28 +0200
Message-Id: <20180721110643.19624-4-paul@crapouillou.net>
In-Reply-To: <20180721110643.19624-1-paul@crapouillou.net>
References: <20180721110643.19624-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1532171259; bh=hciIk9gID7aV0NKrxOVE+5rhlcyIEKEEoUFxhmnxPeE=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=xYh5DBAciLnkPTh6BaumB2w+kO+cSeF798nZsTWU5SlqHEg3X3jYKMfMDVe2i2IJOM8vQI26VZSOSFyldgPGH26ENJIlluPtJzmWx9WkFYQmqd2kqsNpxyl/CWbItRV3HUyY7tEHdw0CujlqF8Q/E5Fx57N/vMhjMAGcDXSWP9s=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65006
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

As part of the work to support various other Ingenic JZ47xx SoC versions,
which don't feature the same number of DMA channels per core, we now
deduce the number of DMA channels available from the devicetree
compatible string.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/dma/dma-jz4780.c | 53 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 14 deletions(-)

 v2: - don't hardcode jz_version to ID_JZ4780 when not probed from DT,
       because it cannot happen
     - Put SoC-specific data into a jz4780_dma_soc_data structure

 v3: No change

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 987899610b46..a26107c85ee7 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -16,6 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/of_dma.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -23,8 +24,6 @@
 #include "dmaengine.h"
 #include "virt-dma.h"
 
-#define JZ_DMA_NR_CHANNELS	32
-
 /* Global registers. */
 #define JZ_DMA_REG_DMAC		0x1000
 #define JZ_DMA_REG_DIRQP	0x1004
@@ -135,14 +134,24 @@ struct jz4780_dma_chan {
 	unsigned int curr_hwdesc;
 };
 
+enum jz_version {
+	ID_JZ4780,
+};
+
+struct jz4780_dma_soc_data {
+	unsigned int nb_channels;
+};
+
 struct jz4780_dma_dev {
 	struct dma_device dma_device;
 	void __iomem *base;
 	struct clk *clk;
 	unsigned int irq;
+	enum jz_version version;
+	const struct jz4780_dma_soc_data *soc_data;
 
 	uint32_t chan_reserved;
-	struct jz4780_dma_chan chan[JZ_DMA_NR_CHANNELS];
+	struct jz4780_dma_chan chan[];
 };
 
 struct jz4780_dma_filter_data {
@@ -648,7 +657,7 @@ static irqreturn_t jz4780_dma_irq_handler(int irq, void *data)
 
 	pending = jz4780_dma_readl(jzdma, JZ_DMA_REG_DIRQP);
 
-	for (i = 0; i < JZ_DMA_NR_CHANNELS; i++) {
+	for (i = 0; i < jzdma->soc_data->nb_channels; i++) {
 		if (!(pending & (1<<i)))
 			continue;
 
@@ -728,7 +737,7 @@ static struct dma_chan *jz4780_of_dma_xlate(struct of_phandle_args *dma_spec,
 	data.channel = dma_spec->args[1];
 
 	if (data.channel > -1) {
-		if (data.channel >= JZ_DMA_NR_CHANNELS) {
+		if (data.channel >= jzdma->soc_data->nb_channels) {
 			dev_err(jzdma->dma_device.dev,
 				"device requested non-existent channel %u\n",
 				data.channel);
@@ -752,13 +761,27 @@ static struct dma_chan *jz4780_of_dma_xlate(struct of_phandle_args *dma_spec,
 	}
 }
 
+static const struct jz4780_dma_soc_data jz4780_dma_soc_data[] = {
+	[ID_JZ4780] = { .nb_channels = 32, },
+};
+
+static const struct of_device_id jz4780_dma_dt_match[] = {
+	{ .compatible = "ingenic,jz4780-dma", .data = (void *)ID_JZ4780 },
+	{},
+};
+MODULE_DEVICE_TABLE(of, jz4780_dma_dt_match);
+
 static int jz4780_dma_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	const struct of_device_id *of_id = of_match_device(
+			jz4780_dma_dt_match, dev);
+	const struct jz4780_dma_soc_data *soc_data;
 	struct jz4780_dma_dev *jzdma;
 	struct jz4780_dma_chan *jzchan;
 	struct dma_device *dd;
 	struct resource *res;
+	enum jz_version version;
 	int i, ret;
 
 	if (!dev->of_node) {
@@ -766,10 +789,18 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	jzdma = devm_kzalloc(dev, sizeof(*jzdma), GFP_KERNEL);
+	version = (enum jz_version)of_id->data;
+	soc_data = &jz4780_dma_soc_data[version];
+
+	jzdma = devm_kzalloc(dev, sizeof(*jzdma)
+				+ sizeof(*jzdma->chan) * soc_data->nb_channels,
+				GFP_KERNEL);
 	if (!jzdma)
 		return -ENOMEM;
 
+	jzdma->soc_data = soc_data;
+	jzdma->version = version;
+
 	platform_set_drvdata(pdev, jzdma);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -844,7 +875,7 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 
 	INIT_LIST_HEAD(&dd->channels);
 
-	for (i = 0; i < JZ_DMA_NR_CHANNELS; i++) {
+	for (i = 0; i < soc_data->nb_channels; i++) {
 		jzchan = &jzdma->chan[i];
 		jzchan->id = i;
 
@@ -889,19 +920,13 @@ static int jz4780_dma_remove(struct platform_device *pdev)
 
 	free_irq(jzdma->irq, jzdma);
 
-	for (i = 0; i < JZ_DMA_NR_CHANNELS; i++)
+	for (i = 0; i < jzdma->soc_data->nb_channels; i++)
 		tasklet_kill(&jzdma->chan[i].vchan.task);
 
 	dma_async_device_unregister(&jzdma->dma_device);
 	return 0;
 }
 
-static const struct of_device_id jz4780_dma_dt_match[] = {
-	{ .compatible = "ingenic,jz4780-dma", .data = NULL },
-	{},
-};
-MODULE_DEVICE_TABLE(of, jz4780_dma_dt_match);
-
 static struct platform_driver jz4780_dma_driver = {
 	.probe		= jz4780_dma_probe,
 	.remove		= jz4780_dma_remove,
-- 
2.11.0
