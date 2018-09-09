Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Sep 2018 21:27:15 +0200 (CEST)
Received: from mx1.mailbox.org ([80.241.60.212]:43738 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990642AbeIIT1M0KMF1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 9 Sep 2018 21:27:12 +0200
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 9DE4D49621;
        Sun,  9 Sep 2018 21:27:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id nPzuJ2OKOs4O; Sun,  9 Sep 2018 21:27:04 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org,
        hauke.mehrtens@intel.com, paul.burton@mips.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 net] MIPS: lantiq: dma: add dev pointer
Date:   Sun,  9 Sep 2018 21:26:23 +0200
Message-Id: <20180909192623.14998-1-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66157
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

dma_zalloc_coherent() now crashes if no dev pointer is given.
Add a dev pointer to the ltq_dma_channel structure and fill it in the
driver using it.

This fixes a bug introduced in kernel 4.19.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---

no changes since v1.

This should go into kernel 4.19 and I have some other patches adding new 
features for kernel 4.20 which are depending on this, so I would prefer 
if this goes through the net tree. 

 arch/mips/include/asm/mach-lantiq/xway/xway_dma.h | 1 +
 arch/mips/lantiq/xway/dma.c                       | 4 ++--
 drivers/net/ethernet/lantiq_etop.c                | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mach-lantiq/xway/xway_dma.h b/arch/mips/include/asm/mach-lantiq/xway/xway_dma.h
index 4901833498f7..8441b2698e64 100644
--- a/arch/mips/include/asm/mach-lantiq/xway/xway_dma.h
+++ b/arch/mips/include/asm/mach-lantiq/xway/xway_dma.h
@@ -40,6 +40,7 @@ struct ltq_dma_channel {
 	int desc;			/* the current descriptor */
 	struct ltq_dma_desc *desc_base; /* the descriptor base */
 	int phys;			/* physical addr */
+	struct device *dev;
 };
 
 enum {
diff --git a/arch/mips/lantiq/xway/dma.c b/arch/mips/lantiq/xway/dma.c
index 4b9fbb6744ad..664f2f7f55c1 100644
--- a/arch/mips/lantiq/xway/dma.c
+++ b/arch/mips/lantiq/xway/dma.c
@@ -130,7 +130,7 @@ ltq_dma_alloc(struct ltq_dma_channel *ch)
 	unsigned long flags;
 
 	ch->desc = 0;
-	ch->desc_base = dma_zalloc_coherent(NULL,
+	ch->desc_base = dma_zalloc_coherent(ch->dev,
 				LTQ_DESC_NUM * LTQ_DESC_SIZE,
 				&ch->phys, GFP_ATOMIC);
 
@@ -182,7 +182,7 @@ ltq_dma_free(struct ltq_dma_channel *ch)
 	if (!ch->desc_base)
 		return;
 	ltq_dma_close(ch);
-	dma_free_coherent(NULL, LTQ_DESC_NUM * LTQ_DESC_SIZE,
+	dma_free_coherent(ch->dev, LTQ_DESC_NUM * LTQ_DESC_SIZE,
 		ch->desc_base, ch->phys);
 }
 EXPORT_SYMBOL_GPL(ltq_dma_free);
diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index 7a637b51c7d2..e08301d833e2 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -274,6 +274,7 @@ ltq_etop_hw_init(struct net_device *dev)
 		struct ltq_etop_chan *ch = &priv->ch[i];
 
 		ch->idx = ch->dma.nr = i;
+		ch->dma.dev = &priv->pdev->dev;
 
 		if (IS_TX(i)) {
 			ltq_dma_alloc_tx(&ch->dma);
-- 
2.11.0
