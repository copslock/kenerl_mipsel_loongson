Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jul 2018 14:34:17 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:33392 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994584AbeGCMcfvLipz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Jul 2018 14:32:35 +0200
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
Subject: [PATCH 06/14] dmaengine: dma-jz4780: Add support for the JZ4725B SoC
Date:   Tue,  3 Jul 2018 14:32:06 +0200
Message-Id: <20180703123214.23090-7-paul@crapouillou.net>
In-Reply-To: <20180703123214.23090-1-paul@crapouillou.net>
References: <20180703123214.23090-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1530621155; bh=JZYF8f7nUzfetLcg8Rk2QXtCZlzg0IklxLdEOqwCOSs=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Kg1L2pJSnv/bfsPP4kcqlleEYItgeyZ1e24NPkECAwDqFoeBzTypFi4y+EJ4FI/u3fvwOeGgtCpbd89t4w5a32lV/+Bz66AkYHE/tdl80Kg8rJpufAgxUDou2sBO+C+27jsdgngKTVhD/fSWd+/9Xe1lKwxRYp3AsSutmVfpVvU=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64570
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
---
 Documentation/devicetree/bindings/dma/jz4780-dma.txt | 1 +
 drivers/dma/dma-jz4780.c                             | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/jz4780-dma.txt b/Documentation/devicetree/bindings/dma/jz4780-dma.txt
index d7ca3f925fdf..5d302b488e88 100644
--- a/Documentation/devicetree/bindings/dma/jz4780-dma.txt
+++ b/Documentation/devicetree/bindings/dma/jz4780-dma.txt
@@ -5,6 +5,7 @@ Required properties:
 - compatible: Should be one of:
   * ingenic,jz4780-dma
   * ingenic,jz4770-dma
+  * ingenic,jz4725b-dma
   * ingenic,jz4740-dma
 - reg: Should contain the DMA channel registers location and length, followed
   by the DMA controller registers location and length.
diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index ccadbe61dde7..922e4031e70e 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -134,6 +134,7 @@ struct jz4780_dma_chan {
 
 enum jz_version {
 	ID_JZ4740,
+	ID_JZ4725B,
 	ID_JZ4770,
 	ID_JZ4780,
 };
@@ -204,6 +205,8 @@ static inline void jz4780_dma_chan_enable(struct jz4780_dma_dev *jzdma,
 {
 	if (jzdma->version == ID_JZ4770)
 		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DCKES, BIT(chn));
+	else if (jzdma->version == ID_JZ4725B)
+		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DCKE, BIT(chn));
 }
 
 static inline void jz4780_dma_chan_disable(struct jz4780_dma_dev *jzdma,
@@ -249,6 +252,7 @@ static void jz4780_dma_desc_free(struct virt_dma_desc *vdesc)
 
 static const unsigned int jz4780_dma_ord_max[] = {
 	[ID_JZ4740] = 5,
+	[ID_JZ4725B] = 5,
 	[ID_JZ4770] = 6,
 	[ID_JZ4780] = 7,
 };
@@ -804,12 +808,14 @@ static struct dma_chan *jz4780_of_dma_xlate(struct of_phandle_args *dma_spec,
 
 static const unsigned int jz4780_dma_nb_channels[] = {
 	[ID_JZ4740] = 6,
+	[ID_JZ4725B] = 6,
 	[ID_JZ4770] = 6,
 	[ID_JZ4780] = 32,
 };
 
 static const struct of_device_id jz4780_dma_dt_match[] = {
 	{ .compatible = "ingenic,jz4740-dma", .data = (void *)ID_JZ4740 },
+	{ .compatible = "ingenic,jz4725b-dma", .data = (void *)ID_JZ4725B },
 	{ .compatible = "ingenic,jz4770-dma", .data = (void *)ID_JZ4770 },
 	{ .compatible = "ingenic,jz4780-dma", .data = (void *)ID_JZ4780 },
 	{},
-- 
2.18.0
