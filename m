Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Aug 2018 23:35:59 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:40260 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994608AbeH2VdRGZVlp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Aug 2018 23:33:17 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
Cc:     od@zcrc.me, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Daniel Silsby <dansilsby@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v5 11/18] dmaengine: dma-jz4780: Add missing residue DTC mask
Date:   Wed, 29 Aug 2018 23:32:53 +0200
Message-Id: <20180829213300.22829-12-paul@crapouillou.net>
In-Reply-To: <20180829213300.22829-1-paul@crapouillou.net>
References: <20180829213300.22829-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1535578396; bh=4SorUfGw5ULg7eEdZSV9f55fjo4XlGbzh8mo49ABBsw=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=tqtcHoZ60fDHc5YItWTn6fx0y3FA41NFbaNEidbmSXMcBAVCddf0dfdrCIqkuVA9cp9NnIMkHljx464AKDYt3C5Ov0UXEVzxVYJZ5ICOU8Q1y5nuXerO1rhi6Xsd0Y/gNpweacDmCpqXRmiERMk2GdgZiTnPvsHKitU1h0aQmCw=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65790
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
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
---

Notes:
     v2: No change
    
     v3: No change
    
     v4: Add my Signed-off-by
    
     v5: Use GENMASK macro

 drivers/dma/dma-jz4780.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 3a4d0a4b550d..bd3cecb800c5 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -616,7 +616,8 @@ static size_t jz4780_dma_desc_residue(struct jz4780_dma_chan *jzchan,
 	residue = 0;
 
 	for (i = next_sg; i < desc->count; i++)
-		residue += desc->desc[i].dtc << jzchan->transfer_shift;
+		residue += (desc->desc[i].dtc & GENMASK(23, 0)) <<
+			jzchan->transfer_shift;
 
 	if (next_sg != 0) {
 		count = jz4780_dma_chn_readl(jzdma, jzchan->id,
-- 
2.11.0
