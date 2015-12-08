Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2015 11:19:12 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:34206 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006954AbbLHKTKonq02 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Dec 2015 11:19:10 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 28AB2228E10B1;
        Tue,  8 Dec 2015 10:19:03 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Tue, 8 Dec 2015 10:19:04 +0000
Received: from qyousef-linux.le.imgtec.org (192.168.154.94) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 8 Dec 2015 10:19:04 +0000
From:   Qais Yousef <qais.yousef@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <ralf@linux-mips.org>, <akpm@linux-foundation.org>,
        <mgorman@techsingularity.net>, Qais Yousef <qais.yousef@imgtec.com>
Subject: [PATCH] MIPS: Fix DMA contiguous allocation
Date:   Tue, 8 Dec 2015 10:18:50 +0000
Message-ID: <1449569930-2118-1-git-send-email-qais.yousef@imgtec.com>
X-Mailer: git-send-email 2.1.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50416
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: qais.yousef@imgtec.com
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

Recent changes to how GFP_ATOMIC is defined seems to have broken the condition
to use mips_alloc_from_contiguous() in mips_dma_alloc_coherent().

I couldn't bottom out the exact change but I think it's this one

d0164adc89f6 (mm, page_alloc: distinguish between being unable to sleep,
unwilling to sleep and avoiding waking kswapd)

From what I see GFP_ATOMIC has multiple bits set and the check for !(gfp
& GFP_ATOMIC) isn't enough. To verify if the flag is atomic we need to make
sure that (gfp & GFP_ATOMIC) == GFP_ATOMIC to verify that all bits rquired to
satisfy GFP_ATOMIC condition are set.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
---
 arch/mips/mm/dma-default.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index d8117be729a2..d6b8a1445a3a 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -145,7 +145,7 @@ static void *mips_dma_alloc_coherent(struct device *dev, size_t size,
 
 	gfp = massage_gfp_flags(dev, gfp);
 
-	if (IS_ENABLED(CONFIG_DMA_CMA) && !(gfp & GFP_ATOMIC))
+	if (IS_ENABLED(CONFIG_DMA_CMA) && ((gfp & GFP_ATOMIC) != GFP_ATOMIC))
 		page = dma_alloc_from_contiguous(dev,
 					count, get_order(size));
 	if (!page)
-- 
2.1.0
