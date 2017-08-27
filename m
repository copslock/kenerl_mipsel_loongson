Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Aug 2017 18:15:17 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:40626 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994943AbdH0QLFLFUbp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 27 Aug 2017 18:11:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=67pmcfxVXf3g/ODMX9llFiIpAKKk+AsCb851QO7nXeY=; b=o09masYQh5QDE/tZWl79Vfazr
        lXPTqoXDAkmM6P9dPoOWvMrAn6WYLOnYNO/A9zQlC4ThcO82ciJV8D7UMX2QHoiJEuIiEPYGUv8Nq
        6eq0+gtbKfjTl+ZWsHlhDzREGS+FMfsyI7c4yrmu1tq+qF8tLMEnjWA/1TScOmYfs78Tj09zO2XO1
        DV/PPZ7K7KQjqiTc8TqU2+uU3qoiYMQLbe8envMAqRKTQTiNwOzPWOlVLD9sfj/PdF2IvBCK4UOz3
        rmCvpZ3RHzWXeYgJbndMdZg7mmQxJGzP93KkQ3JdBZYHIYwME/5dRKsFXuo5gFlWkJoNY+oi5VU+L
        6u5TpGICQ==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dm09L-0006te-EW; Sun, 27 Aug 2017 16:10:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Michal Simek <monstr@monstr.eu>,
        David Howells <dhowells@redhat.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org,
        linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/12] unicore32: make dma_cache_sync a no-op
Date:   Sun, 27 Aug 2017 18:10:29 +0200
Message-Id: <20170827161032.22772-10-hch@lst.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170827161032.22772-1-hch@lst.de>
References: <20170827161032.22772-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+0d43c28c1e7909f7e68d+5117+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59824
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
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

unicore32 does not implement DMA_ATTR_NON_CONSISTENT allocations, so it
doesn't make any sense to do any work in dma_cache_sync given that it
must be a no-op when dma_alloc_attrs returns coherent memory.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/unicore32/include/asm/cacheflush.h  |  9 ---------
 arch/unicore32/include/asm/dma-mapping.h | 17 -----------------
 arch/unicore32/mm/proc-syms.c            |  3 ---
 3 files changed, 29 deletions(-)

diff --git a/arch/unicore32/include/asm/cacheflush.h b/arch/unicore32/include/asm/cacheflush.h
index c0301e6c8b81..a5e08e2d5d6d 100644
--- a/arch/unicore32/include/asm/cacheflush.h
+++ b/arch/unicore32/include/asm/cacheflush.h
@@ -102,15 +102,6 @@ extern void __cpuc_flush_dcache_area(void *, size_t);
 extern void __cpuc_flush_kern_dcache_area(void *addr, size_t size);
 
 /*
- * These are private to the dma-mapping API.  Do not use directly.
- * Their sole purpose is to ensure that data held in the cache
- * is visible to DMA, or data written by DMA to system memory is
- * visible to the CPU.
- */
-extern void __cpuc_dma_clean_range(unsigned long, unsigned long);
-extern void __cpuc_dma_flush_range(unsigned long, unsigned long);
-
-/*
  * Copy user data from/to a page which is mapped into a different
  * processes address space.  Really, we want to allow our "user
  * space" model to handle this.
diff --git a/arch/unicore32/include/asm/dma-mapping.h b/arch/unicore32/include/asm/dma-mapping.h
index 518ba5848dd6..e949855bb794 100644
--- a/arch/unicore32/include/asm/dma-mapping.h
+++ b/arch/unicore32/include/asm/dma-mapping.h
@@ -18,9 +18,6 @@
 #include <linux/scatterlist.h>
 #include <linux/swiotlb.h>
 
-#include <asm/memory.h>
-#include <asm/cacheflush.h>
-
 extern const struct dma_map_ops swiotlb_dma_map_ops;
 
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
@@ -51,20 +48,6 @@ static inline void dma_mark_clean(void *addr, size_t size) {}
 static inline void dma_cache_sync(struct device *dev, void *vaddr,
 		size_t size, enum dma_data_direction direction)
 {
-	unsigned long start = (unsigned long)vaddr;
-	unsigned long end   = start + size;
-
-	switch (direction) {
-	case DMA_NONE:
-		BUG();
-	case DMA_FROM_DEVICE:
-	case DMA_BIDIRECTIONAL:	/* writeback and invalidate */
-		__cpuc_dma_flush_range(start, end);
-		break;
-	case DMA_TO_DEVICE:		/* writeback only */
-		__cpuc_dma_clean_range(start, end);
-		break;
-	}
 }
 
 #endif /* __KERNEL__ */
diff --git a/arch/unicore32/mm/proc-syms.c b/arch/unicore32/mm/proc-syms.c
index 21c00fc85c99..df215fd6d639 100644
--- a/arch/unicore32/mm/proc-syms.c
+++ b/arch/unicore32/mm/proc-syms.c
@@ -20,6 +20,3 @@ EXPORT_SYMBOL(cpu_dcache_clean_area);
 EXPORT_SYMBOL(cpu_set_pte);
 
 EXPORT_SYMBOL(__cpuc_coherent_kern_range);
-
-EXPORT_SYMBOL(__cpuc_dma_flush_range);
-EXPORT_SYMBOL(__cpuc_dma_clean_range);
-- 
2.11.0
