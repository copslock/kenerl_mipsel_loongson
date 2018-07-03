Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jul 2018 14:34:43 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:34096 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994606AbeGCMciPHpkz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Jul 2018 14:32:38 +0200
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
Subject: [PATCH 08/14] dmaengine: dma-jz4780: Add missing residue DTC mask
Date:   Tue,  3 Jul 2018 14:32:08 +0200
Message-Id: <20180703123214.23090-9-paul@crapouillou.net>
In-Reply-To: <20180703123214.23090-1-paul@crapouillou.net>
References: <20180703123214.23090-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1530621157; bh=sYDEgeKKxOk+5BGS6A3CGGrzNNG31XNMEMeBXx46htw=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=qVEhTXo54W+B8lq2xgmac43Ad3HXkEiHtAethyMctUTZNNBujzy7or9Wy42i9lFbPtEQ4yLgRpHEh/IU6xC+oE0bTQnXvut8MbwCXNNG8hxq+FFGkN57sogd+v7Wl18pX4MZmW8JwvUpTW83HvM6SVtJMJYCBKbRnrlORO0goGw=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64572
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
---
 drivers/dma/dma-jz4780.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 7ee2c121948f..7b2e305e28fb 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -610,7 +610,8 @@ static size_t jz4780_dma_desc_residue(struct jz4780_dma_chan *jzchan,
 	residue = 0;
 
 	for (i = next_sg; i < desc->count; i++)
-		residue += desc->desc[i].dtc << jzchan->transfer_shift;
+		residue += (desc->desc[i].dtc & 0xffffff) <<
+			jzchan->transfer_shift;
 
 	if (next_sg != 0) {
 		count = jz4780_dma_chn_readl(jzdma, jzchan->id,
-- 
2.18.0
