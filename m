Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jul 2018 20:22:19 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:55464 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993101AbeGRSUyIM8BK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Jul 2018 20:20:54 +0200
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
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH v2 08/17] dmaengine: dma-jz4780: Add support for the JZ4725B SoC
Date:   Wed, 18 Jul 2018 20:20:14 +0200
Message-Id: <20180718182023.8182-9-paul@crapouillou.net>
In-Reply-To: <20180718182023.8182-1-paul@crapouillou.net>
References: <20180718182023.8182-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1531938053; bh=rx0Rp8o3lKHmlOAaWolX5YnxdeatZUSndvlO+bADjyA=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=iN1bxBqBw43geI198c85ztmlyhllYNoYeFm0k9zMs7hEZpD2DFfAGGksnkQLLzO5zNr7Zmxcvb2hdDnB7sXdFu/OSV8IzF+6tc8GLcnN58Xqz94v/Piv0deAT2vku4f/sR7ecBSUvEaExGk6kTl1uZ0XgXYb8rikr9RwEkPIILc=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64930
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

The JZ4725B has one DMA core starring six DMA channels.
As for the JZ4770, each DMA channel's clock can be enabled with
a register write, the difference here being that once started, it
is not possible to turn it off.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
Reviewed-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
---
 drivers/dma/dma-jz4780.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

 v2: - Add comments about channel enabling/disabling
     - The documentation update is now in patch 01/17

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 084d4023637e..88ce3f0157f6 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -136,6 +136,7 @@ struct jz4780_dma_chan {
 
 enum jz_version {
 	ID_JZ4740,
+	ID_JZ4725B,
 	ID_JZ4770,
 	ID_JZ4780,
 };
@@ -209,8 +210,12 @@ static inline void jz4780_dma_ctrl_writel(struct jz4780_dma_dev *jzdma,
 static inline void jz4780_dma_chan_enable(struct jz4780_dma_dev *jzdma,
 	unsigned int chn)
 {
-	if (jzdma->version == ID_JZ4770)
+	if (jzdma->version == ID_JZ4770) {
 		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DCKES, BIT(chn));
+	} else if (jzdma->version == ID_JZ4725B) {
+		/* JZ4725B has no DCKES, it uses DCKE to enable channels */
+		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DCKE, BIT(chn));
+	}
 }
 
 static inline void jz4780_dma_chan_disable(struct jz4780_dma_dev *jzdma,
@@ -218,6 +223,8 @@ static inline void jz4780_dma_chan_disable(struct jz4780_dma_dev *jzdma,
 {
 	if (jzdma->version == ID_JZ4770)
 		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DCKEC, BIT(chn));
+
+	/* On JZ4725B it is not possible to stop a DMA channel once enabled */
 }
 
 static struct jz4780_dma_desc *jz4780_dma_desc_alloc(
@@ -805,12 +812,14 @@ static struct dma_chan *jz4780_of_dma_xlate(struct of_phandle_args *dma_spec,
 
 static const struct jz4780_dma_soc_data jz4780_dma_soc_data[] = {
 	[ID_JZ4740] = { .nb_channels = 6, .transfer_ord_max = 5, },
+	[ID_JZ4725B] = { .nb_channels = 6, .transfer_ord_max = 5, },
 	[ID_JZ4770] = { .nb_channels = 6, .transfer_ord_max = 6, },
 	[ID_JZ4780] = { .nb_channels = 32, .transfer_ord_max = 7, },
 };
 
 static const struct of_device_id jz4780_dma_dt_match[] = {
 	{ .compatible = "ingenic,jz4740-dma", .data = (void *)ID_JZ4740 },
+	{ .compatible = "ingenic,jz4725b-dma", .data = (void *)ID_JZ4725B },
 	{ .compatible = "ingenic,jz4770-dma", .data = (void *)ID_JZ4770 },
 	{ .compatible = "ingenic,jz4780-dma", .data = (void *)ID_JZ4780 },
 	{},
-- 
2.11.0
