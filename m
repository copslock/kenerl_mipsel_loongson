Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jul 2018 14:34:30 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:33758 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994587AbeGCMchGPUnz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Jul 2018 14:32:37 +0200
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
Subject: [PATCH 07/14] dmaengine: dma-jz4780: Enable Fast DMA to the AIC
Date:   Tue,  3 Jul 2018 14:32:07 +0200
Message-Id: <20180703123214.23090-8-paul@crapouillou.net>
In-Reply-To: <20180703123214.23090-1-paul@crapouillou.net>
References: <20180703123214.23090-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1530621156; bh=IqjpwS2nEXZxovuEFSDRJK3MSn/uWmXaM9cI/ycZOC0=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=DoryTjR2pNoekwiM9kz/7vpVFa+2fEpr4A6vg4bPDSOYA7HLaDJxRIGQAGHWWlDsyje2qzvKRyfiipxg9CTvEmRQlVGx+1UyP6OB98krp0jOutun2mfNa5Uozp4FYPC4Z8DnEKn/ppeOjsuyo4N2RUqR7yCasrSmriHce1i2gVY=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64571
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

With the fast DMA bit set, the DMA will transfer twice as much data
per clock period to the AIC, so there is little point not to set it.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/dma/dma-jz4780.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 922e4031e70e..7ee2c121948f 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -52,6 +52,7 @@
 #define JZ_DMA_DMAC_DMAE	BIT(0)
 #define JZ_DMA_DMAC_AR		BIT(2)
 #define JZ_DMA_DMAC_HLT		BIT(3)
+#define JZ_DMA_DMAC_FAIC	BIT(27)
 #define JZ_DMA_DMAC_FMSC	BIT(31)
 
 #define JZ_DMA_DRT_AUTO		0x8
@@ -929,8 +930,8 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 	 * Also set the FMSC bit - it increases MSC performance, so it makes
 	 * little sense not to enable it.
 	 */
-	jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DMAC,
-			  JZ_DMA_DMAC_DMAE | JZ_DMA_DMAC_FMSC);
+	jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DMAC, JZ_DMA_DMAC_DMAE |
+			       JZ_DMA_DMAC_FAIC | JZ_DMA_DMAC_FMSC);
 
 	if (jzdma->version == ID_JZ4780)
 		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DMACP, 0);
-- 
2.18.0
