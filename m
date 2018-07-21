Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Jul 2018 01:31:15 +0200 (CEST)
Received: from mx1.mailbox.org ([80.241.60.212]:29160 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993354AbeGUXbLqkeja (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 22 Jul 2018 01:31:11 +0200
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 5A93F48184;
        Sun, 22 Jul 2018 01:31:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id S2EWDEP7C3C7; Sun, 22 Jul 2018 01:31:05 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org
Cc:     john@phrozen.org, linux-mips@linux-mips.org, dev@kresin.me,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] MIPS: lantiq: Use dma_zalloc_coherent() in dma code
Date:   Sun, 22 Jul 2018 01:30:57 +0200
Message-Id: <20180721233057.10713-1-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65028
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

Instead of using dma_alloc_coherent() and memset() directly use
dma_zalloc_coherent().

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/lantiq/xway/dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/lantiq/xway/dma.c b/arch/mips/lantiq/xway/dma.c
index 805b3a6ab2d6..4b9fbb6744ad 100644
--- a/arch/mips/lantiq/xway/dma.c
+++ b/arch/mips/lantiq/xway/dma.c
@@ -130,10 +130,9 @@ ltq_dma_alloc(struct ltq_dma_channel *ch)
 	unsigned long flags;
 
 	ch->desc = 0;
-	ch->desc_base = dma_alloc_coherent(NULL,
+	ch->desc_base = dma_zalloc_coherent(NULL,
 				LTQ_DESC_NUM * LTQ_DESC_SIZE,
 				&ch->phys, GFP_ATOMIC);
-	memset(ch->desc_base, 0, LTQ_DESC_NUM * LTQ_DESC_SIZE);
 
 	spin_lock_irqsave(&ltq_dma_lock, flags);
 	ltq_dma_w32(ch->nr, LTQ_DMA_CS);
-- 
2.11.0
