Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Aug 2018 23:34:32 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:38824 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994572AbeH2VdLXJRKp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Aug 2018 23:33:11 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
Cc:     od@zcrc.me, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v5 05/18] dmaengine: dma-jz4780: Use 4-word descriptors
Date:   Wed, 29 Aug 2018 23:32:47 +0200
Message-Id: <20180829213300.22829-6-paul@crapouillou.net>
In-Reply-To: <20180829213300.22829-1-paul@crapouillou.net>
References: <20180829213300.22829-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1535578390; bh=m5hvUX0ZsROwsODCNS9h1ziPLLTBGgiDkbgfAhgKwM4=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=tisaK66E4/lGcxd5Brups4weiHuke6WabWk1ToYIz4dL+xkmurWBmZgYmSrbdspeH4Cwthhp8uMBWRiGr0MypjfuFofyJtzs6Fcl7A5xHMf0WTUr+wWTOJilbnh8/HL+oJgVsBoo8F05kFg/SNSVNodgablFvH19W2gO0TLkdks=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65784
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

The only information we use in the 8-word version of the hardware DMA
descriptor that is not present in the 4-word version is the transfer
type, aka. the ID of the source or recipient device.

Since the transfer type will never change for a DMA channel in use,
we can just set it once for all in the corresponding DMA register
before starting any transfer.

This has several benefits:

* the driver will handle twice as many hardware DMA descriptors;

* the driver is closer to support the JZ4740, which only supports 4-word
  hardware DMA descriptors;

* the JZ4770 SoC needs the transfer type to be set in the corresponding
  DMA register anyway, even if 8-word descriptors are in use.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
Reviewed-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
---

Notes:
     v2: No change
    
     v3: No change
    
     v4: No change
    
     v5: No change

 drivers/dma/dma-jz4780.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index adf4d5efced6..7683de9fb9ee 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -95,17 +95,12 @@
  * @dtc: transfer count (number of blocks of the transfer size specified in DCM
  * to transfer) in the low 24 bits, offset of the next descriptor from the
  * descriptor base address in the upper 8 bits.
- * @sd: target/source stride difference (in stride transfer mode).
- * @drt: request type
  */
 struct jz4780_dma_hwdesc {
 	uint32_t dcm;
 	uint32_t dsa;
 	uint32_t dta;
 	uint32_t dtc;
-	uint32_t sd;
-	uint32_t drt;
-	uint32_t reserved[2];
 };
 
 /* Size of allocations for hardware descriptor blocks. */
@@ -281,7 +276,6 @@ static int jz4780_dma_setup_hwdesc(struct jz4780_dma_chan *jzchan,
 		desc->dcm = JZ_DMA_DCM_SAI;
 		desc->dsa = addr;
 		desc->dta = config->dst_addr;
-		desc->drt = jzchan->transfer_type;
 
 		width = config->dst_addr_width;
 		maxburst = config->dst_maxburst;
@@ -289,7 +283,6 @@ static int jz4780_dma_setup_hwdesc(struct jz4780_dma_chan *jzchan,
 		desc->dcm = JZ_DMA_DCM_DAI;
 		desc->dsa = config->src_addr;
 		desc->dta = addr;
-		desc->drt = jzchan->transfer_type;
 
 		width = config->src_addr_width;
 		maxburst = config->src_maxburst;
@@ -434,9 +427,10 @@ static struct dma_async_tx_descriptor *jz4780_dma_prep_dma_memcpy(
 	tsz = jz4780_dma_transfer_size(dest | src | len,
 				       &jzchan->transfer_shift);
 
+	jzchan->transfer_type = JZ_DMA_DRT_AUTO;
+
 	desc->desc[0].dsa = src;
 	desc->desc[0].dta = dest;
-	desc->desc[0].drt = JZ_DMA_DRT_AUTO;
 	desc->desc[0].dcm = JZ_DMA_DCM_TIE | JZ_DMA_DCM_SAI | JZ_DMA_DCM_DAI |
 			    tsz << JZ_DMA_DCM_TSZ_SHIFT |
 			    JZ_DMA_WIDTH_32_BIT << JZ_DMA_DCM_SP_SHIFT |
@@ -491,9 +485,12 @@ static void jz4780_dma_begin(struct jz4780_dma_chan *jzchan)
 			(jzchan->curr_hwdesc + 1) % jzchan->desc->count;
 	}
 
-	/* Use 8-word descriptors. */
-	jz4780_dma_chn_writel(jzdma, jzchan->id,
-			      JZ_DMA_REG_DCS, JZ_DMA_DCS_DES8);
+	/* Use 4-word descriptors. */
+	jz4780_dma_chn_writel(jzdma, jzchan->id, JZ_DMA_REG_DCS, 0);
+
+	/* Set transfer type. */
+	jz4780_dma_chn_writel(jzdma, jzchan->id, JZ_DMA_REG_DRT,
+			      jzchan->transfer_type);
 
 	/* Write descriptor address and initiate descriptor fetch. */
 	desc_phys = jzchan->desc->desc_phys +
@@ -503,7 +500,7 @@ static void jz4780_dma_begin(struct jz4780_dma_chan *jzchan)
 
 	/* Enable the channel. */
 	jz4780_dma_chn_writel(jzdma, jzchan->id, JZ_DMA_REG_DCS,
-			      JZ_DMA_DCS_DES8 | JZ_DMA_DCS_CTE);
+			      JZ_DMA_DCS_CTE);
 }
 
 static void jz4780_dma_issue_pending(struct dma_chan *chan)
-- 
2.11.0
