Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Aug 2018 23:37:00 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:41414 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994615AbeH2VdVKJmcp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Aug 2018 23:33:21 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
Cc:     od@zcrc.me, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Daniel Silsby <dansilsby@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v5 15/18] dmaengine: dma-jz4780: Use dma_set_residue()
Date:   Wed, 29 Aug 2018 23:32:57 +0200
Message-Id: <20180829213300.22829-16-paul@crapouillou.net>
In-Reply-To: <20180829213300.22829-1-paul@crapouillou.net>
References: <20180829213300.22829-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1535578400; bh=F1tcdqpoPSsW/DsB3jM/0tloGacwvl2SREq78SCgIfo=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=VAQRCB9TIK8T8JzVhqiJPg6CtcX/yooLxCObfKxgJf9mGNa7Btwr5sHKnZQ6NtvzJOcxxKfB97x1dedJedJMOnUyMuCi4MHMepXwf7NelyPy0NVK2+jh/PVAFC5XvHEC2AIt4zb+QPftr2SOdqXI/bV1x97dfrXMPnQNieJL9OQ=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65794
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
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
---

Notes:
     v2: No change
    
     v3: No change
    
     v4: Add my Signed-off-by
    
     v5: No change

 drivers/dma/dma-jz4780.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index b73d96166637..e1bb93dd32ba 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -639,6 +639,7 @@ static enum dma_status jz4780_dma_tx_status(struct dma_chan *chan,
 	struct virt_dma_desc *vdesc;
 	enum dma_status status;
 	unsigned long flags;
+	unsigned long residue = 0;
 
 	status = dma_cookie_status(chan, cookie, txstate);
 	if ((status == DMA_COMPLETE) || (txstate == NULL))
@@ -649,13 +650,13 @@ static enum dma_status jz4780_dma_tx_status(struct dma_chan *chan,
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
2.11.0
