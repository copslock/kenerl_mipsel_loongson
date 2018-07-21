Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Jul 2018 13:08:18 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:57022 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993852AbeGULHnI8zCi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Jul 2018 13:07:43 +0200
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
Subject: [PATCH v3 05/18] dmaengine: dma-jz4780: Use 4-word descriptors
Date:   Sat, 21 Jul 2018 13:06:30 +0200
Message-Id: <20180721110643.19624-6-paul@crapouillou.net>
In-Reply-To: <20180721110643.19624-1-paul@crapouillou.net>
References: <20180721110643.19624-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1532171262; bh=eFcn3o/g4I6Hkf5cEci6UQoR5QL1uJ6/x5bhau03rqQ=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=sNFAPqNQW7WxA4pcrdsq1VKAAiCSDgiErP+pwq/eUfpnAnzxC940gEckB+MlHclwv9q2nEGNCU7Cbah+tJA4x+OS35p3wnJvTlTAWK2Er6qLXhzc51AUMQmZiNdZsZm5GGW5MDo1XkXsg7pZVcRV2SD6+wxFiqwZliHM3WUIjOA=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65004
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
 drivers/dma/dma-jz4780.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

 v2: No change

 v3: No change

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 2f17a0fb1e5c..23e92d153919 100644
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
@@ -286,7 +281,6 @@ static int jz4780_dma_setup_hwdesc(struct jz4780_dma_chan *jzchan,
 		desc->dcm = JZ_DMA_DCM_SAI;
 		desc->dsa = addr;
 		desc->dta = config->dst_addr;
-		desc->drt = jzchan->transfer_type;
 
 		width = config->dst_addr_width;
 		maxburst = config->dst_maxburst;
@@ -294,7 +288,6 @@ static int jz4780_dma_setup_hwdesc(struct jz4780_dma_chan *jzchan,
 		desc->dcm = JZ_DMA_DCM_DAI;
 		desc->dsa = config->src_addr;
 		desc->dta = addr;
-		desc->drt = jzchan->transfer_type;
 
 		width = config->src_addr_width;
 		maxburst = config->src_maxburst;
@@ -439,9 +432,10 @@ static struct dma_async_tx_descriptor *jz4780_dma_prep_dma_memcpy(
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
@@ -496,9 +490,12 @@ static void jz4780_dma_begin(struct jz4780_dma_chan *jzchan)
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
@@ -508,7 +505,7 @@ static void jz4780_dma_begin(struct jz4780_dma_chan *jzchan)
 
 	/* Enable the channel. */
 	jz4780_dma_chn_writel(jzdma, jzchan->id, JZ_DMA_REG_DCS,
-			      JZ_DMA_DCS_DES8 | JZ_DMA_DCS_CTE);
+			      JZ_DMA_DCS_CTE);
 }
 
 static void jz4780_dma_issue_pending(struct dma_chan *chan)
-- 
2.11.0
