Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Oct 2017 12:45:33 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:40918 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993156AbdJCKnfPdsx1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Oct 2017 12:43:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qnv5FzJ1rIVuiBCsKoTXVoMorWSret+UT/q6QLeQp/8=; b=mpZW0j3PfHWiOZfMwVPX9HjEj
        BifNLC66ghqZrE9HIgMM5RbZgvOeMp/NAUGmaVRQaHMFwwT3GOsD83dLnWXSUAnz+64c6GoBb9PGK
        hABHcslo6XLiB/G4X2nvjBYUaIsuDZrZ6Yos5A+IOnfzqLdFhf3aPuvpZ1/c9Sk7QrimfFIx6LIQz
        S4l02iDAgnBqrZ1Qf7q17Mf2pToRTnrU4oHw5TjhLfnt36/tpVDuGAdKY7NC5343n5mBnGh9CVwHU
        6z5R+exuyID6tt6RDunBa0fgwy+PjOnLNO4SxYSP6JLRXbzOa+QVLts7YLH2tvdoP1HSu8DEyraWI
        SoD+DK8NA==;
Received: from 80-109-164-210.cable.dynamic.surfer.at ([80.109.164.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dzKfh-0000Q2-5s; Tue, 03 Oct 2017 10:43:29 +0000
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
Subject: [PATCH 05/11] microblaze: make dma_cache_sync a no-op
Date:   Tue,  3 Oct 2017 12:43:05 +0200
Message-Id: <20171003104311.10058-6-hch@lst.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20171003104311.10058-1-hch@lst.de>
References: <20171003104311.10058-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+69bb01a06caa5cf26dd3+5154+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60226
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

microblaze does not implement DMA_ATTR_NON_CONSISTENT allocations, so it
doesn't make any sense to do any work in dma_cache_sync given that it
must be a no-op when dma_alloc_attrs returns coherent memory.

This also allows moving __dma_sync out of the microblaze asm/dma-mapping.h
and thus greatly reduce the amount of includes there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/microblaze/include/asm/dma-mapping.h | 34 -------------------------------
 arch/microblaze/kernel/dma.c              | 17 ++++++++++++++++
 2 files changed, 17 insertions(+), 34 deletions(-)

diff --git a/arch/microblaze/include/asm/dma-mapping.h b/arch/microblaze/include/asm/dma-mapping.h
index e15cd2f76e23..ad448e4aedb6 100644
--- a/arch/microblaze/include/asm/dma-mapping.h
+++ b/arch/microblaze/include/asm/dma-mapping.h
@@ -15,22 +15,6 @@
 #ifndef _ASM_MICROBLAZE_DMA_MAPPING_H
 #define _ASM_MICROBLAZE_DMA_MAPPING_H
 
-/*
- * See Documentation/DMA-API-HOWTO.txt and
- * Documentation/DMA-API.txt for documentation.
- */
-
-#include <linux/types.h>
-#include <linux/cache.h>
-#include <linux/mm.h>
-#include <linux/scatterlist.h>
-#include <linux/dma-debug.h>
-#include <asm/io.h>
-#include <asm/cacheflush.h>
-
-#define __dma_alloc_coherent(dev, gfp, size, handle)	NULL
-#define __dma_free_coherent(size, addr)		((void)0)
-
 /*
  * Available generic sets of operations
  */
@@ -41,27 +25,9 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return &dma_direct_ops;
 }
 
-static inline void __dma_sync(unsigned long paddr,
-			      size_t size, enum dma_data_direction direction)
-{
-	switch (direction) {
-	case DMA_TO_DEVICE:
-	case DMA_BIDIRECTIONAL:
-		flush_dcache_range(paddr, paddr + size);
-		break;
-	case DMA_FROM_DEVICE:
-		invalidate_dcache_range(paddr, paddr + size);
-		break;
-	default:
-		BUG();
-	}
-}
-
 static inline void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 		enum dma_data_direction direction)
 {
-	BUG_ON(direction == DMA_NONE);
-	__dma_sync(virt_to_phys(vaddr), size, (int)direction);
 }
 
 #endif	/* _ASM_MICROBLAZE_DMA_MAPPING_H */
diff --git a/arch/microblaze/kernel/dma.c b/arch/microblaze/kernel/dma.c
index 94700c5270a9..e52b684f8ea2 100644
--- a/arch/microblaze/kernel/dma.c
+++ b/arch/microblaze/kernel/dma.c
@@ -12,6 +12,7 @@
 #include <linux/dma-debug.h>
 #include <linux/export.h>
 #include <linux/bug.h>
+#include <asm/cacheflush.h>
 
 #define NOT_COHERENT_CACHE
 
@@ -51,6 +52,22 @@ static void dma_direct_free_coherent(struct device *dev, size_t size,
 #endif
 }
 
+static inline void __dma_sync(unsigned long paddr,
+			      size_t size, enum dma_data_direction direction)
+{
+	switch (direction) {
+	case DMA_TO_DEVICE:
+	case DMA_BIDIRECTIONAL:
+		flush_dcache_range(paddr, paddr + size);
+		break;
+	case DMA_FROM_DEVICE:
+		invalidate_dcache_range(paddr, paddr + size);
+		break;
+	default:
+		BUG();
+	}
+}
+
 static int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl,
 			     int nents, enum dma_data_direction direction,
 			     unsigned long attrs)
-- 
2.14.1
