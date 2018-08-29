Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Aug 2018 23:35:16 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:39516 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994585AbeH2VdOAUPTp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Aug 2018 23:33:14 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
Cc:     od@zcrc.me, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v5 08/18] dmaengine: dma-jz4780: Add support for the JZ4740 SoC
Date:   Wed, 29 Aug 2018 23:32:50 +0200
Message-Id: <20180829213300.22829-9-paul@crapouillou.net>
In-Reply-To: <20180829213300.22829-1-paul@crapouillou.net>
References: <20180829213300.22829-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1535578393; bh=VV64+Ti/sCwVPaEQNm6N0YTdIPIx4iVk/4KbCXtj0XE=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=RClLxy4jc8jRo2krV4/4aRRe4Z5Vp89aG/j5djNdrk02vxzqwiwMQYd4lHVBseWxl57C1QNwvpBLW8pgm0H70iQsmwJtpglhR+GLKrDVjh+s2/67xqjV2AfKj4SM0F2MQfwtT/GfLElahB5FFgOOcYdbrGRw9uSbkx/DjETywlM=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65787
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

The JZ4740 SoC has a single DMA core starring six DMA channels.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
Reviewed-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
---

Notes:
     v2: The documentation update is now in patch 01/17
    
     v3: The Kconfig update was dropped thanks to patch 06/18
    
     v4: No change
    
     v5: No change

 drivers/dma/dma-jz4780.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 184d1a2bf9ba..2d194dfa697e 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -973,6 +973,11 @@ static int jz4780_dma_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct jz4780_dma_soc_data jz4740_dma_soc_data = {
+	.nb_channels = 6,
+	.transfer_ord_max = 5,
+};
+
 static const struct jz4780_dma_soc_data jz4770_dma_soc_data = {
 	.nb_channels = 6,
 	.transfer_ord_max = 6,
@@ -986,6 +991,7 @@ static const struct jz4780_dma_soc_data jz4780_dma_soc_data = {
 };
 
 static const struct of_device_id jz4780_dma_dt_match[] = {
+	{ .compatible = "ingenic,jz4740-dma", .data = &jz4740_dma_soc_data },
 	{ .compatible = "ingenic,jz4770-dma", .data = &jz4770_dma_soc_data },
 	{ .compatible = "ingenic,jz4780-dma", .data = &jz4780_dma_soc_data },
 	{},
-- 
2.11.0
