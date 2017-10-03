Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Oct 2017 12:46:47 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:33071 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993155AbdJCKnpE6rv1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Oct 2017 12:43:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pMQKPp02siJ66DUwDk0oeLsvYp9OXOEBClWbRCWK8gM=; b=SLXZ7iLjhVzI2aytUHAb5/OmM
        xZDc6N//vglZTasjXuIiryWeuqTrjqsrdEum+euqAm1gP1Yux8ge38vDDthLBaJ3+BgI5s3pY0hJr
        RAT1ec2Sv1yzQwZ5vtt1LPeeoWoK9ur3LS+kZCEcc9Lx2z1+p2UK0MZmGsU5OFIYpA70d9zaCs5v9
        7RehazLKPbcVH/j9RFI5mp1Pp9GXQXp/SWxBHc2i7AmT1HzU4TyHWgXMYFDx3VVZWs5Fxo6tBLvSU
        W/kow0wlw/wsSiI+zmDqJvmkxL4abOotADNzI8JXBL/0n5atzBoCeyYRfWw65Q+XOqmvOjsDH2hFx
        nB8diT6pg==;
Received: from 80-109-164-210.cable.dynamic.surfer.at ([80.109.164.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dzKfq-0000Se-Ju; Tue, 03 Oct 2017 10:43:39 +0000
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
Subject: [PATCH 08/11] unicore32: make dma_cache_sync a no-op
Date:   Tue,  3 Oct 2017 12:43:08 +0200
Message-Id: <20171003104311.10058-9-hch@lst.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20171003104311.10058-1-hch@lst.de>
References: <20171003104311.10058-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+69bb01a06caa5cf26dd3+5154+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60229
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
@@ -101,15 +101,6 @@ extern void __cpuc_coherent_user_range(unsigned long, unsigned long);
 extern void __cpuc_flush_dcache_area(void *, size_t);
 extern void __cpuc_flush_kern_dcache_area(void *addr, size_t size);
 
-/*
- * These are private to the dma-mapping API.  Do not use directly.
- * Their sole purpose is to ensure that data held in the cache
- * is visible to DMA, or data written by DMA to system memory is
- * visible to the CPU.
- */
-extern void __cpuc_dma_clean_range(unsigned long, unsigned long);
-extern void __cpuc_dma_flush_range(unsigned long, unsigned long);
-
 /*
  * Copy user data from/to a page which is mapped into a different
  * processes address space.  Really, we want to allow our "user
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
2.14.1
