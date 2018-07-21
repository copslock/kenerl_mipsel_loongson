Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Jul 2018 13:09:43 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:59272 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993885AbeGULHw47oPi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Jul 2018 13:07:52 +0200
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
Subject: [PATCH v3 11/18] dmaengine: dma-jz4780: Add missing residue DTC mask
Date:   Sat, 21 Jul 2018 13:06:36 +0200
Message-Id: <20180721110643.19624-12-paul@crapouillou.net>
In-Reply-To: <20180721110643.19624-1-paul@crapouillou.net>
References: <20180721110643.19624-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1532171272; bh=cCn7nWOCI3UnnJ0C9He+kWXSgQ3As3oI7G37pKJTZF4=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=KA+FBUfYn4uQEfj4GBiLVCFt4Ee3NdN1NtJGGmELvYHPegjH3ipMCsNrMTmnHQl3lPasD07uhmjKSmjHCk1rJE8muCFRATHy70uUZQcsK/T/VMdElRJb783UD59U9y2UgEL2RTo5NGDaATY9vTYdgGdcDOT83VAJx4FwaCOVoD8=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65012
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

From: Daniel Silsby <dansilsby@gmail.com>

The 'dtc' word in jz DMA descriptors contains two fields: The
lowest 24 bits are the transfer count, and upper 8 bits are the DOA
offset to next descriptor. The upper 8 bits are now correctly masked
off when computing residue in jz4780_dma_desc_residue(). Note that
reads of the DTCn hardware reg are automatically masked this way.

Signed-off-by: Daniel Silsby <dansilsby@gmail.com>
Tested-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/dma/dma-jz4780.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

 v2: No change

 v3: No change

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 3c9d3952e23a..fa926de082ba 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -614,7 +614,8 @@ static size_t jz4780_dma_desc_residue(struct jz4780_dma_chan *jzchan,
 	residue = 0;
 
 	for (i = next_sg; i < desc->count; i++)
-		residue += desc->desc[i].dtc << jzchan->transfer_shift;
+		residue += (desc->desc[i].dtc & 0xffffff) <<
+			jzchan->transfer_shift;
 
 	if (next_sg != 0) {
 		count = jz4780_dma_chn_readl(jzdma, jzchan->id,
-- 
2.11.0
