Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jan 2009 15:42:21 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:15080 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S21103349AbZAVPmR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 22 Jan 2009 15:42:17 +0000
Received: from localhost.localdomain (p7001-ipad208funabasi.chiba.ocn.ne.jp [60.43.108.1])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id F20DDA857; Fri, 23 Jan 2009 00:42:10 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Synchronize dma_map_page and dma_map_single
Date:	Fri, 23 Jan 2009 00:42:11 +0900
Message-Id: <1232638931-6203-1-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.3
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21796
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Synchronize dma_map_page/dma_unmap_page and dma_map_single/dma_unmap_single.
This will reduce unnecessary writeback/invalidate.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
This patch depends on a patch titled "fix oops in dma_unmap_page on not
coherent mips platforms". by Jan Nikitenko.

http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=20081128075258.GA10200%40nikitenko.systek.local

 arch/mips/mm/dma-default.c |   13 ++-----------
 1 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index bed56f1..96b0061 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -209,7 +209,7 @@ dma_addr_t dma_map_page(struct device *dev, struct page *page,
 		unsigned long addr;
 
 		addr = (unsigned long) page_address(page) + offset;
-		dma_cache_wback_inv(addr, size);
+		__dma_sync(addr, size, direction);
 	}
 
 	return plat_map_dma_mem_page(dev, page) + offset;
@@ -220,16 +220,7 @@ EXPORT_SYMBOL(dma_map_page);
 void dma_unmap_page(struct device *dev, dma_addr_t dma_address, size_t size,
 	enum dma_data_direction direction)
 {
-	BUG_ON(direction == DMA_NONE);
-
-	if (!plat_device_is_coherent(dev) && direction != DMA_TO_DEVICE) {
-		unsigned long addr;
-
-		addr = dma_addr_to_virt(dma_address);
-		dma_cache_wback_inv(addr, size);
-	}
-
-	plat_unmap_dma_mem(dev, dma_address);
+	dma_unmap_single(dev, dma_address, size, direction);
 }
 
 EXPORT_SYMBOL(dma_unmap_page);
-- 
1.5.6.3
