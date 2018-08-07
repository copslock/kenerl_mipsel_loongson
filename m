Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Aug 2018 13:44:28 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:38780 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994680AbeHGLmhHfIYB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Aug 2018 13:42:37 +0200
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
Subject: [PATCH v4 09/18] dmaengine: dma-jz4780: Add support for the JZ4725B SoC
Date:   Tue,  7 Aug 2018 13:42:09 +0200
Message-Id: <20180807114218.20091-10-paul@crapouillou.net>
In-Reply-To: <20180807114218.20091-1-paul@crapouillou.net>
References: <20180807114218.20091-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1533642156; bh=pE4B1RYJ+UcIsBTZIecfuKr/fVkEc46S1/ClGqsbGeY=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=MdX7T8h3khLYY9S8k6IUupSjqnE21aP4ppF812rpDbgH7kTJVim5VBnRPtBBpHmP74dVS+atIuy3nnAJhwW9houAnplngFkoLIhD0RRn92RZFF91QwGvzTkVNdp1zh5+bDEC33kPzJGqr6V6Bk+6WLrxmIZMHVlsbI18S+o/x0E=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65456
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
 drivers/dma/dma-jz4780.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

 v2: - Add comments about channel enabling/disabling
     - The documentation update is now in patch 01/17

 v3: No change

 v4: Drop the SoC version ID and use the 'flags' field of the
     jz4780_dma_soc_data structure

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
