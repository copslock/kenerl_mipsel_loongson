Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jul 2018 20:23:20 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:57212 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993488AbeGRSVAsq7lK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Jul 2018 20:21:00 +0200
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
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH v2 13/17] dmaengine: dma-jz4780: Further residue status fix
Date:   Wed, 18 Jul 2018 20:20:19 +0200
Message-Id: <20180718182023.8182-14-paul@crapouillou.net>
In-Reply-To: <20180718182023.8182-1-paul@crapouillou.net>
References: <20180718182023.8182-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1531938060; bh=wLtygciA8kesCct7e/GjoIaL5q5d2hxkrc9IVMEKpJU=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=bMy1duDPsmfp1EUXgdduwxtBlliTDpQqHKeT9aQ+Im40am95G8XWegjaBP+DPZ4ByoeKG2AGvoLW8yNmwL0AmQwKBd+lU+JcSX869majNDMUq8+5JBZKOlqKFVzi2X/sRL0ozFRkf56ICQDrZ9uLXVWea6ulLOyXa3v0bcCmKxc=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64935
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

Func jz4780_dma_desc_residue() expects the index to the next hw
descriptor as its last parameter. Caller func jz4780_dma_tx_status(),
however, applied modulus before passing it. When the current hw
descriptor was last in the list, the index passed became zero.

The resulting excess of reported residue especially caused problems
with cyclic DMA transfer clients, i.e. ALSA AIC audio output, which
rely on this for determining current DMA location within buffer.

Combined with the recent and related residue-reporting fixes, spurious
ALSA audio underruns on jz4770 hardware are now fixed.

Signed-off-by: Daniel Silsby <dansilsby@gmail.com>
Tested-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/dma/dma-jz4780.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

 v2: No change

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 78849131c81d..b9db539a5b34 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -651,7 +651,7 @@ static enum dma_status jz4780_dma_tx_status(struct dma_chan *chan,
 					to_jz4780_dma_desc(vdesc), 0);
 	} else if (cookie == jzchan->desc->vdesc.tx.cookie) {
 		txstate->residue = jz4780_dma_desc_residue(jzchan, jzchan->desc,
-			  (jzchan->curr_hwdesc + 1) % jzchan->desc->count);
+					jzchan->curr_hwdesc + 1);
 	} else
 		txstate->residue = 0;
 
-- 
2.11.0
