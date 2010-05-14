Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 May 2010 01:15:13 +0200 (CEST)
Received: from sj-iport-4.cisco.com ([171.68.10.86]:54358 "EHLO
        sj-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492057Ab0ENXPH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 15 May 2010 01:15:07 +0200
Authentication-Results: sj-iport-4.cisco.com; dkim=neutral (message not signed) header.i=none
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAMt27UurR7Ht/2dsb2JhbACeBXGkWYFmCwGXK4UQBA
X-IronPort-AV: E=Sophos;i="4.53,234,1272844800"; 
   d="scan'208";a="129946031"
Received: from sj-core-1.cisco.com ([171.71.177.237])
  by sj-iport-4.cisco.com with ESMTP; 14 May 2010 23:14:58 +0000
Received: from localhost (pruscup-112-bw.cisco.com [64.101.21.236])
        by sj-core-1.cisco.com (8.13.8/8.14.3) with ESMTP id o4ENEwUM014020;
        Fri, 14 May 2010 23:14:58 GMT
Date:   Fri, 14 May 2010 19:14:58 -0400
From:   Dezhong Diao <dediao@cisco.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH resend] Apply kmap_high_get on MIPS
Message-ID: <20100514231458.GA4948@dediao-lnx2.corp.sa.net>
Reply-To: Dezhong Diao <dediao@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <dediao@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26725
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dediao@cisco.com
Precedence: bulk
X-list: linux-mips

Hi all,

The changes mentioned in the link below are intended to apply
on MIPS dma functions.

http://lkml.org/lkml/2009/3/7/137

Signed-off-by: Dezhong Diao <dediao@cisco.com>
---
 arch/mips/include/asm/highmem.h |    3 +
 arch/mips/mm/dma-default.c      |  156 ++++++++++++++++++++------------------
 arch/mips/mm/highmem.c          |   17 ++++-
 3 files changed, 101 insertions(+), 75 deletions(-)

diff --git a/arch/mips/include/asm/highmem.h b/arch/mips/include/asm/highmem.h
index 25adfb0..2d7f0f2 100644
--- a/arch/mips/include/asm/highmem.h
+++ b/arch/mips/include/asm/highmem.h
@@ -42,7 +42,10 @@ extern pte_t *pkmap_page_table;
 #define PKMAP_NR(virt)  ((virt-PKMAP_BASE) >> PAGE_SHIFT)
 #define PKMAP_ADDR(nr)  (PKMAP_BASE + ((nr) << PAGE_SHIFT))
 
+#define ARCH_NEEDS_KMAP_HIGH_GET
+
 extern void * kmap_high(struct page *page);
+extern void *kmap_high_get(struct page *page);
 extern void kunmap_high(struct page *page);
 
 extern void *__kmap(struct page *page);
diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index 9547bc0..c2d012e 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -15,18 +15,18 @@
 #include <linux/scatterlist.h>
 #include <linux/string.h>
 #include <linux/gfp.h>
+#include <linux/highmem.h>
 
 #include <asm/cache.h>
 #include <asm/io.h>
 
 #include <dma-coherence.h>
 
-static inline unsigned long dma_addr_to_virt(struct device *dev,
+static inline struct page *dma_addr_to_page(struct device *dev,
 	dma_addr_t dma_addr)
 {
-	unsigned long addr = plat_dma_addr_to_phys(dev, dma_addr);
-
-	return (unsigned long)phys_to_virt(addr);
+	return pfn_to_page(
+		plat_dma_addr_to_phys(dev, dma_addr) >> PAGE_SHIFT);
 }
 
 /*
@@ -141,7 +141,7 @@ void dma_free_coherent(struct device *dev, size_t size, void *vaddr,
 
 EXPORT_SYMBOL(dma_free_coherent);
 
-static inline void __dma_sync(unsigned long addr, size_t size,
+static inline void __dma_sync_virtual(unsigned long addr, size_t size,
 	enum dma_data_direction direction)
 {
 	switch (direction) {
@@ -162,13 +162,60 @@ static inline void __dma_sync(unsigned long addr, size_t size,
 	}
 }
 
+static inline void __dma_sync_contiguous(struct page *page,
+	unsigned long offset, size_t size, enum dma_data_direction direction)
+{
+	unsigned long addr;
+
+	if (!PageHighMem(page)) {
+		addr = (unsigned long)page_address(page) + offset;
+		__dma_sync_virtual(addr, size, direction);
+	} else {
+		addr = (unsigned long)kmap_high_get(page);
+		if (addr) {
+			addr += offset;
+			__dma_sync_virtual(addr, size, direction);
+			kunmap_high(page);
+		}
+	}
+}
+
+/*
+ * A single sg entry may refer to multiple physically contiguous
+ * pages. But we still need to process highmem pages individually.
+ * If highmem is not configured then the bulk of this loop gets
+ * optimized out.
+ */
+static inline void __dma_sync(struct page *page,
+	unsigned long offset, size_t size, enum dma_data_direction direction)
+{
+	size_t left = size;
+
+	BUG_ON(direction == DMA_NONE);
+
+	do {
+		size_t len = left;
+		if (PageHighMem(page) && (offset + len > PAGE_SIZE)) {
+			if (offset >= PAGE_SIZE) {
+				page += offset >> PAGE_SHIFT;
+				offset &= ~PAGE_MASK;
+			}
+			len = PAGE_SIZE - offset;
+		}
+		__dma_sync_contiguous(page, offset, len, direction);
+		offset = 0;
+		page++;
+		left -= len;
+	} while (left);
+}
+
 dma_addr_t dma_map_single(struct device *dev, void *ptr, size_t size,
 	enum dma_data_direction direction)
 {
 	unsigned long addr = (unsigned long) ptr;
 
 	if (!plat_device_is_coherent(dev))
-		__dma_sync(addr, size, direction);
+		__dma_sync_virtual(addr, size, direction);
 
 	return plat_map_dma_mem(dev, ptr, size);
 }
@@ -179,8 +226,8 @@ void dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
 	enum dma_data_direction direction)
 {
 	if (cpu_is_noncoherent_r10000(dev))
-		__dma_sync(dma_addr_to_virt(dev, dma_addr), size,
-		           direction);
+		__dma_sync(dma_addr_to_page(dev, dma_addr),
+			   (dma_addr & ~PAGE_MASK), size, direction);
 
 	plat_unmap_dma_mem(dev, dma_addr, size, direction);
 }
@@ -192,16 +239,12 @@ int dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 {
 	int i;
 
-	BUG_ON(direction == DMA_NONE);
-
 	for (i = 0; i < nents; i++, sg++) {
-		unsigned long addr;
-
-		addr = (unsigned long) sg_virt(sg);
-		if (!plat_device_is_coherent(dev) && addr)
-			__dma_sync(addr, sg->length, direction);
-		sg->dma_address = plat_map_dma_mem(dev,
-				                   (void *)addr, sg->length);
+		if (!plat_device_is_coherent(dev))
+			__dma_sync(sg_page(sg), sg->offset, sg->length,
+				   direction);
+		sg->dma_address = plat_map_dma_mem_page(dev, sg_page(sg)) +
+				  sg->offset;
 	}
 
 	return nents;
@@ -212,14 +255,8 @@ EXPORT_SYMBOL(dma_map_sg);
 dma_addr_t dma_map_page(struct device *dev, struct page *page,
 	unsigned long offset, size_t size, enum dma_data_direction direction)
 {
-	BUG_ON(direction == DMA_NONE);
-
-	if (!plat_device_is_coherent(dev)) {
-		unsigned long addr;
-
-		addr = (unsigned long) page_address(page) + offset;
-		__dma_sync(addr, size, direction);
-	}
+	if (!plat_device_is_coherent(dev))
+		__dma_sync(page, offset, size, direction);
 
 	return plat_map_dma_mem_page(dev, page) + offset;
 }
@@ -229,18 +266,13 @@ EXPORT_SYMBOL(dma_map_page);
 void dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
 	enum dma_data_direction direction)
 {
-	unsigned long addr;
 	int i;
 
-	BUG_ON(direction == DMA_NONE);
-
 	for (i = 0; i < nhwentries; i++, sg++) {
 		if (!plat_device_is_coherent(dev) &&
-		    direction != DMA_TO_DEVICE) {
-			addr = (unsigned long) sg_virt(sg);
-			if (addr)
-				__dma_sync(addr, sg->length, direction);
-		}
+		    direction != DMA_TO_DEVICE)
+			__dma_sync(sg_page(sg), sg->offset, sg->length,
+				   direction);
 		plat_unmap_dma_mem(dev, sg->dma_address, sg->length, direction);
 	}
 }
@@ -250,14 +282,9 @@ EXPORT_SYMBOL(dma_unmap_sg);
 void dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle,
 	size_t size, enum dma_data_direction direction)
 {
-	BUG_ON(direction == DMA_NONE);
-
-	if (cpu_is_noncoherent_r10000(dev)) {
-		unsigned long addr;
-
-		addr = dma_addr_to_virt(dev, dma_handle);
-		__dma_sync(addr, size, direction);
-	}
+	if (cpu_is_noncoherent_r10000(dev))
+		__dma_sync(dma_addr_to_page(dev, dma_handle),
+			   (dma_handle & ~PAGE_MASK), size, direction);
 }
 
 EXPORT_SYMBOL(dma_sync_single_for_cpu);
@@ -265,15 +292,10 @@ EXPORT_SYMBOL(dma_sync_single_for_cpu);
 void dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle,
 	size_t size, enum dma_data_direction direction)
 {
-	BUG_ON(direction == DMA_NONE);
-
 	plat_extra_sync_for_device(dev);
-	if (!plat_device_is_coherent(dev)) {
-		unsigned long addr;
-
-		addr = dma_addr_to_virt(dev, dma_handle);
-		__dma_sync(addr, size, direction);
-	}
+	if (!plat_device_is_coherent(dev))
+		__dma_sync(dma_addr_to_page(dev, dma_handle),
+			   (dma_handle & ~PAGE_MASK), size, direction);
 }
 
 EXPORT_SYMBOL(dma_sync_single_for_device);
@@ -281,14 +303,9 @@ EXPORT_SYMBOL(dma_sync_single_for_device);
 void dma_sync_single_range_for_cpu(struct device *dev, dma_addr_t dma_handle,
 	unsigned long offset, size_t size, enum dma_data_direction direction)
 {
-	BUG_ON(direction == DMA_NONE);
-
-	if (cpu_is_noncoherent_r10000(dev)) {
-		unsigned long addr;
-
-		addr = dma_addr_to_virt(dev, dma_handle);
-		__dma_sync(addr + offset, size, direction);
-	}
+	if (cpu_is_noncoherent_r10000(dev))
+		__dma_sync(dma_addr_to_page(dev, dma_handle), offset, size,
+			   direction);
 }
 
 EXPORT_SYMBOL(dma_sync_single_range_for_cpu);
@@ -296,15 +313,10 @@ EXPORT_SYMBOL(dma_sync_single_range_for_cpu);
 void dma_sync_single_range_for_device(struct device *dev, dma_addr_t dma_handle,
 	unsigned long offset, size_t size, enum dma_data_direction direction)
 {
-	BUG_ON(direction == DMA_NONE);
-
 	plat_extra_sync_for_device(dev);
-	if (!plat_device_is_coherent(dev)) {
-		unsigned long addr;
-
-		addr = dma_addr_to_virt(dev, dma_handle);
-		__dma_sync(addr + offset, size, direction);
-	}
+	if (!plat_device_is_coherent(dev))
+		__dma_sync(dma_addr_to_page(dev, dma_handle), offset, size,
+			   direction);
 }
 
 EXPORT_SYMBOL(dma_sync_single_range_for_device);
@@ -314,13 +326,11 @@ void dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg, int nelems,
 {
 	int i;
 
-	BUG_ON(direction == DMA_NONE);
-
 	/* Make sure that gcc doesn't leave the empty loop body.  */
 	for (i = 0; i < nelems; i++, sg++) {
 		if (cpu_is_noncoherent_r10000(dev))
-			__dma_sync((unsigned long)page_address(sg_page(sg)),
-			           sg->length, direction);
+			__dma_sync(sg_page(sg), sg->offset, sg->length,
+				   direction);
 	}
 }
 
@@ -331,13 +341,11 @@ void dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg, int nele
 {
 	int i;
 
-	BUG_ON(direction == DMA_NONE);
-
 	/* Make sure that gcc doesn't leave the empty loop body.  */
 	for (i = 0; i < nelems; i++, sg++) {
 		if (!plat_device_is_coherent(dev))
-			__dma_sync((unsigned long)page_address(sg_page(sg)),
-			           sg->length, direction);
+			__dma_sync(sg_page(sg), sg->offset, sg->length,
+				   direction);
 	}
 }
 
@@ -371,7 +379,7 @@ void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 
 	plat_extra_sync_for_device(dev);
 	if (!plat_device_is_coherent(dev))
-		__dma_sync((unsigned long)vaddr, size, direction);
+		__dma_sync_virtual((unsigned long)vaddr, size, direction);
 }
 
 EXPORT_SYMBOL(dma_cache_sync);
diff --git a/arch/mips/mm/highmem.c b/arch/mips/mm/highmem.c
index 127d732..ed27217 100644
--- a/arch/mips/mm/highmem.c
+++ b/arch/mips/mm/highmem.c
@@ -45,6 +45,7 @@ void *__kmap_atomic(struct page *page, enum km_type type)
 {
 	enum fixed_addresses idx;
 	unsigned long vaddr;
+	void *kmap;
 
 	/* even !CONFIG_PREEMPT needs this, for in_atomic in do_page_fault */
 	pagefault_disable();
@@ -52,6 +53,11 @@ void *__kmap_atomic(struct page *page, enum km_type type)
 		return page_address(page);
 
 	debug_kmap_atomic(type);
+
+	kmap = kmap_high_get(page);
+	if (kmap)
+		return kmap;
+
 	idx = type + KM_TYPE_NR*smp_processor_id();
 	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
 #ifdef CONFIG_DEBUG_HIGHMEM
@@ -66,10 +72,19 @@ EXPORT_SYMBOL(__kmap_atomic);
 
 void __kunmap_atomic(void *kvaddr, enum km_type type)
 {
-#ifdef CONFIG_DEBUG_HIGHMEM
 	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
+#ifdef CONFIG_DEBUG_HIGHMEM
 	enum fixed_addresses idx = type + KM_TYPE_NR*smp_processor_id();
+#endif
 
+	if (vaddr >= PKMAP_ADDR(0) && vaddr < PKMAP_ADDR(LAST_PKMAP)) {
+		/* this address was obtained through kmap_high_get() */
+		kunmap_high(pte_page(pkmap_page_table[PKMAP_NR(vaddr)]));
+		pagefault_enable();
+		return;
+	}
+
+#ifdef CONFIG_DEBUG_HIGHMEM
 	if (vaddr < FIXADDR_START) { // FIXME
 		pagefault_enable();
 		return;
-- 
1.6.0.6
