Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jul 2018 14:35:43 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:35710 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994629AbeGCMcn41TFz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Jul 2018 14:32:43 +0200
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
Subject: [PATCH 12/14] dmaengine: dma-jz4780: Use dma_set_residue()
Date:   Tue,  3 Jul 2018 14:32:12 +0200
Message-Id: <20180703123214.23090-13-paul@crapouillou.net>
In-Reply-To: <20180703123214.23090-1-paul@crapouillou.net>
References: <20180703123214.23090-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1530621162; bh=9/6JpqsNrbpcWfS0o27b2rGFCQEIjnQIZBWkgANlJ6A=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=X5EPHHlDS03UOL7PNQLZa/fzx+Lq5pFnjWdyT4rJHsiQRgKvjZTbZSsM3sJSpnySC0M5Fo2mPCZz9P+bv9zeQIrde7ODS48IJ9V/3f2n6woeGMLLOYW68v2XXvZoeLvYOR0JBsBqKa9AR1IiF+EmF5HN/xKK4twxFgT9rcyOSxg=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64576
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

This is the standard method provided by dmaengine header.

Signed-off-by: Daniel Silsby <dansilsby@gmail.com>
---
 drivers/dma/dma-jz4780.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 690b853977b2..084b7a46a68d 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -633,6 +633,7 @@ static enum dma_status jz4780_dma_tx_status(struct dma_chan *chan,
 	struct virt_dma_desc *vdesc;
 	enum dma_status status;
 	unsigned long flags;
+	unsigned long residue = 0;
 
 	status = dma_cookie_status(chan, cookie, txstate);
 	if ((status == DMA_COMPLETE) || (txstate == NULL))
@@ -643,13 +644,13 @@ static enum dma_status jz4780_dma_tx_status(struct dma_chan *chan,
 	vdesc = vchan_find_desc(&jzchan->vchan, cookie);
 	if (vdesc) {
 		/* On the issued list, so hasn't been processed yet */
-		txstate->residue = jz4780_dma_desc_residue(jzchan,
+		residue = jz4780_dma_desc_residue(jzchan,
 					to_jz4780_dma_desc(vdesc), 0);
 	} else if (cookie == jzchan->desc->vdesc.tx.cookie) {
-		txstate->residue = jz4780_dma_desc_residue(jzchan, jzchan->desc,
+		residue = jz4780_dma_desc_residue(jzchan, jzchan->desc,
 					jzchan->curr_hwdesc + 1);
-	} else
-		txstate->residue = 0;
+	}
+	dma_set_residue(txstate, residue);
 
 	if (vdesc && jzchan->desc && vdesc == &jzchan->desc->vdesc
 	    && jzchan->desc->status & (JZ_DMA_DCS_AR | JZ_DMA_DCS_HLT))
-- 
2.18.0
