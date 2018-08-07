Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Aug 2018 13:44:18 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:38482 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994692AbeHGLmfjj2CB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Aug 2018 13:42:35 +0200
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
Subject: [PATCH v4 08/18] dmaengine: dma-jz4780: Add support for the JZ4740 SoC
Date:   Tue,  7 Aug 2018 13:42:08 +0200
Message-Id: <20180807114218.20091-9-paul@crapouillou.net>
In-Reply-To: <20180807114218.20091-1-paul@crapouillou.net>
References: <20180807114218.20091-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1533642154; bh=9H68ZZ4fRTZruAHiFDNAA2AJFPxM3WIHrHUFqMh8U0I=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=rveqq8G4w8VLTsRP3AcbPHCOyOs7dSA/eOTpPhZzqnh8HbSgUyhwaapupaNG1fkPwb+PmM86vmkqRi6V6CueojTxdlPQTXgTjaFwi94GAjCcZDGw5PcAWABd89OYrzmm8d/XZjVK0lPzra0Z4fJksunCSZwhtpd7HvAY2FR62rc=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65455
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
 drivers/dma/dma-jz4780.c | 6 ++++++
 1 file changed, 6 insertions(+)

 v2: The documentation update is now in patch 01/17

 v3: The Kconfig update was dropped thanks to patch 06/18

 v4: No change

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
