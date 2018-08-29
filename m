Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Aug 2018 23:35:31 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:39754 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994589AbeH2VdO6jAxp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Aug 2018 23:33:14 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
Cc:     od@zcrc.me, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v5 09/18] dmaengine: dma-jz4780: Add support for the JZ4725B SoC
Date:   Wed, 29 Aug 2018 23:32:51 +0200
Message-Id: <20180829213300.22829-10-paul@crapouillou.net>
In-Reply-To: <20180829213300.22829-1-paul@crapouillou.net>
References: <20180829213300.22829-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1535578394; bh=IvhXseR+rjjnSwuCq5YWS2DJ57/S3B88keuBOYZnRPU=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Z0PNlAPFsqgt10BHU/dMW8DuuRLJVctiyFJtfKWN/tLyVBLHvaR+k2pHBxoDODXSsXtP+RIR8ceqMQB8PnTdAK+GWJx6RnHo7ZAtu3Dscw439tS66SAANV/xwRoOTPb95MwsqbEINu+ySTf9QESfR9aiKnp0lg5CwgXD4s8bcYk=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65788
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

Notes:
     v2: - Add comments about channel enabling/disabling
         - The documentation update is now in patch 01/17
    
     v3: No change
    
     v4: Drop the SoC version ID and use the 'flags' field of the
         jz4780_dma_soc_data structure
    
     v5: No change

 drivers/dma/dma-jz4780.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 2d194dfa697e..565971c2a33c 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -94,6 +94,7 @@
 #define JZ_SOC_DATA_ALLOW_LEGACY_DT	BIT(0)
 #define JZ_SOC_DATA_PROGRAMMABLE_DMA	BIT(1)
 #define JZ_SOC_DATA_PER_CHAN_PM		BIT(2)
+#define JZ_SOC_DATA_NO_DCKES_DCKEC	BIT(3)
 
 /**
  * struct jz4780_dma_hwdesc - descriptor structure read by the DMA controller.
@@ -208,14 +209,23 @@ static inline void jz4780_dma_ctrl_writel(struct jz4780_dma_dev *jzdma,
 static inline void jz4780_dma_chan_enable(struct jz4780_dma_dev *jzdma,
 	unsigned int chn)
 {
-	if (jzdma->soc_data->flags & JZ_SOC_DATA_PER_CHAN_PM)
-		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DCKES, BIT(chn));
+	if (jzdma->soc_data->flags & JZ_SOC_DATA_PER_CHAN_PM) {
+		unsigned int reg;
+
+		if (jzdma->soc_data->flags & JZ_SOC_DATA_NO_DCKES_DCKEC)
+			reg = JZ_DMA_REG_DCKE;
+		else
+			reg = JZ_DMA_REG_DCKES;
+
+		jz4780_dma_ctrl_writel(jzdma, reg, BIT(chn));
+	}
 }
 
 static inline void jz4780_dma_chan_disable(struct jz4780_dma_dev *jzdma,
 	unsigned int chn)
 {
-	if (jzdma->soc_data->flags & JZ_SOC_DATA_PER_CHAN_PM)
+	if ((jzdma->soc_data->flags & JZ_SOC_DATA_PER_CHAN_PM) &&
+			!(jzdma->soc_data->flags & JZ_SOC_DATA_NO_DCKES_DCKEC))
 		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DCKEC, BIT(chn));
 }
 
@@ -978,6 +988,12 @@ static const struct jz4780_dma_soc_data jz4740_dma_soc_data = {
 	.transfer_ord_max = 5,
 };
 
+static const struct jz4780_dma_soc_data jz4725b_dma_soc_data = {
+	.nb_channels = 6,
+	.transfer_ord_max = 5,
+	.flags = JZ_SOC_DATA_PER_CHAN_PM | JZ_SOC_DATA_NO_DCKES_DCKEC,
+};
+
 static const struct jz4780_dma_soc_data jz4770_dma_soc_data = {
 	.nb_channels = 6,
 	.transfer_ord_max = 6,
@@ -992,6 +1008,7 @@ static const struct jz4780_dma_soc_data jz4780_dma_soc_data = {
 
 static const struct of_device_id jz4780_dma_dt_match[] = {
 	{ .compatible = "ingenic,jz4740-dma", .data = &jz4740_dma_soc_data },
+	{ .compatible = "ingenic,jz4725b-dma", .data = &jz4725b_dma_soc_data },
 	{ .compatible = "ingenic,jz4770-dma", .data = &jz4770_dma_soc_data },
 	{ .compatible = "ingenic,jz4780-dma", .data = &jz4780_dma_soc_data },
 	{},
-- 
2.11.0
