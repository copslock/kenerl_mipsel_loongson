Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Jul 2018 13:09:33 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:58908 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993881AbeGULHvgyIyi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Jul 2018 13:07:51 +0200
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
Subject: [PATCH v3 10/18] dmaengine: dma-jz4780: Enable Fast DMA to the AIC
Date:   Sat, 21 Jul 2018 13:06:35 +0200
Message-Id: <20180721110643.19624-11-paul@crapouillou.net>
In-Reply-To: <20180721110643.19624-1-paul@crapouillou.net>
References: <20180721110643.19624-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1532171270; bh=7Zor4s3i7rKhDiDB7DPDYYxD+li64FRa/bj5CAFsKZM=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=rlmDgqW8xn+kDIlRNFwltcdCABjTXH7qMXbfusMrmCp5SBCMU7J5fgwN61eIe+GaI1wLR2xKWGHuWlwdF+/2KW+nEZ87OfCe/u1qgkcwGDQLrLy9oBtm1ZxNYUZedBELIIU/CUnmeUr+CE3Yo2N21D8HH3JLA9DkBTAJ6qythro=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65011
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
Tested-by: Mathieu Malaterre <malat@debian.org>
Reviewed-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
---
 drivers/dma/dma-jz4780.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

 v2: No change

 v3: No change

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 88ce3f0157f6..3c9d3952e23a 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -52,6 +52,7 @@
 #define JZ_DMA_DMAC_DMAE	BIT(0)
 #define JZ_DMA_DMAC_AR		BIT(2)
 #define JZ_DMA_DMAC_HLT		BIT(3)
+#define JZ_DMA_DMAC_FAIC	BIT(27)
 #define JZ_DMA_DMAC_FMSC	BIT(31)
 
 #define JZ_DMA_DRT_AUTO		0x8
@@ -941,8 +942,8 @@ static int jz4780_dma_probe(struct platform_device *pdev)
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
2.11.0
