Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jul 2018 14:34:58 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:34560 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994608AbeGCMcj1ojTz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Jul 2018 14:32:39 +0200
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
        linux-mips@linux-mips.org
Subject: [PATCH 09/14] dmaengine: dma-jz4780: Simplify jz4780_dma_desc_residue()
Date:   Tue,  3 Jul 2018 14:32:09 +0200
Message-Id: <20180703123214.23090-10-paul@crapouillou.net>
In-Reply-To: <20180703123214.23090-1-paul@crapouillou.net>
References: <20180703123214.23090-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1530621158; bh=etNvu++QjGMWLSYkyKc75Q73fElUynmKAMsXw0ay0Is=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=OkwR0CB9cT0+gfYUB8sMtFmrDXVPWxPBzimqmqhmoxSZ5xxuupMw8jN1QKXx0q6GRWm4cnWpLBj/nU+t69N4ITEzT2my/2jXOoIogG5+Xz/lY0GZFGJJUc7ZvT1I5POlFapn5Yp07NResKdQATkk2aZn7Oyeam0tJcMBeEkQJ6Q=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64573
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

Simple cleanup, no changes to actual logic here.

Signed-off-by: Daniel Silsby <dansilsby@gmail.com>
---
 drivers/dma/dma-jz4780.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 7b2e305e28fb..adada2a3a067 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -604,22 +604,17 @@ static size_t jz4780_dma_desc_residue(struct jz4780_dma_chan *jzchan,
 	struct jz4780_dma_desc *desc, unsigned int next_sg)
 {
 	struct jz4780_dma_dev *jzdma = jz4780_dma_chan_parent(jzchan);
-	unsigned int residue, count;
+	unsigned int count = 0;
 	unsigned int i;
 
-	residue = 0;
-
 	for (i = next_sg; i < desc->count; i++)
-		residue += (desc->desc[i].dtc & 0xffffff) <<
-			jzchan->transfer_shift;
+		count += desc->desc[i].dtc & 0xffffff;
 
-	if (next_sg != 0) {
-		count = jz4780_dma_chn_readl(jzdma, jzchan->id,
+	if (next_sg != 0)
+		count += jz4780_dma_chn_readl(jzdma, jzchan->id,
 					 JZ_DMA_REG_DTC);
-		residue += count << jzchan->transfer_shift;
-	}
 
-	return residue;
+	return count << jzchan->transfer_shift;
 }
 
 static enum dma_status jz4780_dma_tx_status(struct dma_chan *chan,
-- 
2.18.0
