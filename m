Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2018 13:20:09 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:51532 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994679AbeFOLKUquJKT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jun 2018 13:10:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=T8pvmlmTfueIm0fYeEe3l4knClSvYLKYYe5rlvCCT0s=; b=W1TBBVkIoagV3LnESEKCRUQpr
        H9WBNsivUP93E0HiXqVSeYxeKKWKUaIzdYlhwwypFo5LITr3NarCpYN3PHfZeJigf/InSYcqnahDZ
        veLFMaxuT0fBWjT49YuA2XTMNAYjMvnzRziZbdzP++N3WIFVfbIsAAAsFBZVPdJIh1L2/T00rNksO
        CS5+KPKfgfy5c9yjR0ZOnVQhvStt0HJyQEAtYC9RYhkuQ/PKqUxQsHoilFDV9qFWAtH26zc339org
        7lolJkSsAgkOkWRIQDBXrmVAqtoW+U/NMDKW0ynu7WKRGxrudLSW7sSTzJ+Od9HQVIw44WVJiTh6H
        b5GBSqzrg==;
Received: from 80-109-164-210.cable.dynamic.surfer.at ([80.109.164.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTmcU-0005sN-Kt; Fri, 15 Jun 2018 11:10:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        David Daney <david.daney@cavium.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Tom Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paul.burton@mips.com>,
        iommu@lists.linux-foundation.org, linux-mips@linux-mips.org
Subject: [PATCH 24/25] MIPS: remove the old dma-default implementation
Date:   Fri, 15 Jun 2018 13:08:53 +0200
Message-Id: <20180615110854.19253-25-hch@lst.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180615110854.19253-1-hch@lst.de>
References: <20180615110854.19253-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+0eb41a859d58214bb3da+5409+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64305
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

Now unused.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/Kconfig                             |   5 +-
 arch/mips/include/asm/dma-mapping.h           |   3 -
 .../include/asm/mach-generic/dma-coherence.h  |  73 ----
 arch/mips/mm/Makefile                         |   1 -
 arch/mips/mm/dma-default.c                    | 379 ------------------
 5 files changed, 1 insertion(+), 460 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-generic/dma-coherence.h
 delete mode 100644 arch/mips/mm/dma-default.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 7f7edb2b4fcd..3e2a2b49287f 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -77,9 +77,6 @@ config MIPS
 	select SYSCTL_EXCEPTION_TRACE
 	select VIRT_TO_BUS
 
-config MIPS_DMA_DEFAULT
-	bool
-
 menu "Machine selection"
 
 choice
@@ -1118,7 +1115,7 @@ config DMA_NONCOHERENT
 	select NEED_DMA_MAP_STATE
 	select DMA_NONCOHERENT_MMAP
 	select DMA_NONCOHERENT_CACHE_SYNC
-	select DMA_NONCOHERENT_OPS if !MIPS_DMA_DEFAULT
+	select DMA_NONCOHERENT_OPS
 
 config SYS_HAS_EARLY_PRINTK
 	bool
diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
index caf97f739897..143250986e17 100644
--- a/arch/mips/include/asm/dma-mapping.h
+++ b/arch/mips/include/asm/dma-mapping.h
@@ -11,7 +11,6 @@
 #endif
 
 extern const struct dma_map_ops jazz_dma_ops;
-extern const struct dma_map_ops mips_default_dma_map_ops;
 extern const struct dma_map_ops mips_swiotlb_ops;
 
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
@@ -20,8 +19,6 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return &jazz_dma_ops;
 #elif defined(CONFIG_SWIOTLB)
 	return &mips_swiotlb_ops;
-#elif defined(CONFIG_MIPS_DMA_DEFAULT)
-	return &mips_default_dma_map_ops;
 #elif defined(CONFIG_DMA_NONCOHERENT_OPS)
 	return &dma_noncoherent_ops;
 #else
diff --git a/arch/mips/include/asm/mach-generic/dma-coherence.h b/arch/mips/include/asm/mach-generic/dma-coherence.h
deleted file mode 100644
index 8ad7a40ca786..000000000000
--- a/arch/mips/include/asm/mach-generic/dma-coherence.h
+++ /dev/null
@@ -1,73 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2006  Ralf Baechle <ralf@linux-mips.org>
- *
- */
-#ifndef __ASM_MACH_GENERIC_DMA_COHERENCE_H
-#define __ASM_MACH_GENERIC_DMA_COHERENCE_H
-
-struct device;
-
-static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
-	size_t size)
-{
-	return virt_to_phys(addr);
-}
-
-static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
-	struct page *page)
-{
-	return page_to_phys(page);
-}
-
-static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
-	dma_addr_t dma_addr)
-{
-	return dma_addr;
-}
-
-static inline void plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr,
-	size_t size, enum dma_data_direction direction)
-{
-}
-
-static inline int plat_dma_supported(struct device *dev, u64 mask)
-{
-	/*
-	 * we fall back to GFP_DMA when the mask isn't all 1s,
-	 * so we can't guarantee allocations that must be
-	 * within a tighter range than GFP_DMA..
-	 */
-	if (mask < DMA_BIT_MASK(24))
-		return 0;
-
-	return 1;
-}
-
-static inline int plat_device_is_coherent(struct device *dev)
-{
-#ifdef CONFIG_DMA_PERDEV_COHERENT
-	return dev->archdata.dma_coherent;
-#else
-	switch (coherentio) {
-	default:
-	case IO_COHERENCE_DEFAULT:
-		return hw_coherentio;
-	case IO_COHERENCE_ENABLED:
-		return 1;
-	case IO_COHERENCE_DISABLED:
-		return 0;
-	}
-#endif
-}
-
-#ifndef plat_post_dma_flush
-static inline void plat_post_dma_flush(struct device *dev)
-{
-}
-#endif
-
-#endif /* __ASM_MACH_GENERIC_DMA_COHERENCE_H */
diff --git a/arch/mips/mm/Makefile b/arch/mips/mm/Makefile
index c6146c3805dc..6922f393af19 100644
--- a/arch/mips/mm/Makefile
+++ b/arch/mips/mm/Makefile
@@ -17,7 +17,6 @@ obj-$(CONFIG_32BIT)		+= ioremap.o pgtable-32.o
 obj-$(CONFIG_64BIT)		+= pgtable-64.o
 obj-$(CONFIG_HIGHMEM)		+= highmem.o
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
-obj-$(CONFIG_MIPS_DMA_DEFAULT)	+= dma-default.o
 obj-$(CONFIG_DMA_NONCOHERENT)	+= dma-noncoherent.o
 obj-$(CONFIG_SWIOTLB)		+= dma-swiotlb.o
 
diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
deleted file mode 100644
index 10b56e8a2076..000000000000
--- a/arch/mips/mm/dma-default.c
+++ /dev/null
@@ -1,379 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2000  Ani Joshi <ajoshi@unixbox.com>
- * Copyright (C) 2000, 2001, 06	 Ralf Baechle <ralf@linux-mips.org>
- * swiped from i386, and cloned for MIPS by Geert, polished by Ralf.
- */
-
-#include <linux/types.h>
-#include <linux/dma-mapping.h>
-#include <linux/mm.h>
-#include <linux/export.h>
-#include <linux/scatterlist.h>
-#include <linux/string.h>
-#include <linux/gfp.h>
-#include <linux/highmem.h>
-#include <linux/dma-contiguous.h>
-
-#include <asm/cache.h>
-#include <asm/cpu-type.h>
-#include <asm/io.h>
-
-#include <dma-coherence.h>
-
-static inline struct page *dma_addr_to_page(struct device *dev,
-	dma_addr_t dma_addr)
-{
-	return pfn_to_page(
-		plat_dma_addr_to_phys(dev, dma_addr) >> PAGE_SHIFT);
-}
-
-/*
- * The affected CPUs below in 'cpu_needs_post_dma_flush()' can
- * speculatively fill random cachelines with stale data at any time,
- * requiring an extra flush post-DMA.
- *
- * Warning on the terminology - Linux calls an uncached area coherent;
- * MIPS terminology calls memory areas with hardware maintained coherency
- * coherent.
- *
- * Note that the R14000 and R16000 should also be checked for in this
- * condition.  However this function is only called on non-I/O-coherent
- * systems and only the R10000 and R12000 are used in such systems, the
- * SGI IP28 Indigo² rsp. SGI IP32 aka O2.
- */
-static inline bool cpu_needs_post_dma_flush(struct device *dev)
-{
-	if (plat_device_is_coherent(dev))
-		return false;
-
-	switch (boot_cpu_type()) {
-	case CPU_R10000:
-	case CPU_R12000:
-	case CPU_BMIPS5000:
-		return true;
-
-	default:
-		/*
-		 * Presence of MAARs suggests that the CPU supports
-		 * speculatively prefetching data, and therefore requires
-		 * the post-DMA flush/invalidate.
-		 */
-		return cpu_has_maar;
-	}
-}
-
-static gfp_t massage_gfp_flags(const struct device *dev, gfp_t gfp)
-{
-	gfp_t dma_flag;
-
-#ifdef CONFIG_ISA
-	if (dev == NULL)
-		dma_flag = __GFP_DMA;
-	else
-#endif
-#if defined(CONFIG_ZONE_DMA32) && defined(CONFIG_ZONE_DMA)
-	     if (dev == NULL || dev->coherent_dma_mask < DMA_BIT_MASK(32))
-			dma_flag = __GFP_DMA;
-	else if (dev->coherent_dma_mask < DMA_BIT_MASK(64))
-			dma_flag = __GFP_DMA32;
-	else
-#endif
-#if defined(CONFIG_ZONE_DMA32) && !defined(CONFIG_ZONE_DMA)
-	     if (dev == NULL || dev->coherent_dma_mask < DMA_BIT_MASK(64))
-		dma_flag = __GFP_DMA32;
-	else
-#endif
-#if defined(CONFIG_ZONE_DMA) && !defined(CONFIG_ZONE_DMA32)
-	     if (dev == NULL ||
-		 dev->coherent_dma_mask < DMA_BIT_MASK(sizeof(phys_addr_t) * 8))
-		dma_flag = __GFP_DMA;
-	else
-#endif
-		dma_flag = 0;
-
-	/* Don't invoke OOM killer */
-	gfp |= __GFP_NORETRY;
-
-	return gfp | dma_flag;
-}
-
-static void *mips_dma_alloc_coherent(struct device *dev, size_t size,
-	dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
-{
-	void *ret;
-	struct page *page = NULL;
-	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-
-	gfp = massage_gfp_flags(dev, gfp);
-
-	if (IS_ENABLED(CONFIG_DMA_CMA) && gfpflags_allow_blocking(gfp))
-		page = dma_alloc_from_contiguous(dev, count, get_order(size),
-						 gfp);
-	if (!page)
-		page = alloc_pages(gfp, get_order(size));
-
-	if (!page)
-		return NULL;
-
-	ret = page_address(page);
-	memset(ret, 0, size);
-	*dma_handle = plat_map_dma_mem(dev, ret, size);
-	if (!(attrs & DMA_ATTR_NON_CONSISTENT) &&
-	    !plat_device_is_coherent(dev)) {
-		dma_cache_wback_inv((unsigned long) ret, size);
-		ret = UNCAC_ADDR(ret);
-	}
-
-	return ret;
-}
-
-static void mips_dma_free_coherent(struct device *dev, size_t size, void *vaddr,
-	dma_addr_t dma_handle, unsigned long attrs)
-{
-	unsigned long addr = (unsigned long) vaddr;
-	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	struct page *page = NULL;
-
-	plat_unmap_dma_mem(dev, dma_handle, size, DMA_BIDIRECTIONAL);
-
-	if (!(attrs & DMA_ATTR_NON_CONSISTENT) && !plat_device_is_coherent(dev))
-		addr = CAC_ADDR(addr);
-
-	page = virt_to_page((void *) addr);
-
-	if (!dma_release_from_contiguous(dev, page, count))
-		__free_pages(page, get_order(size));
-}
-
-static int mips_dma_mmap(struct device *dev, struct vm_area_struct *vma,
-	void *cpu_addr, dma_addr_t dma_addr, size_t size,
-	unsigned long attrs)
-{
-	unsigned long user_count = vma_pages(vma);
-	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	unsigned long addr = (unsigned long)cpu_addr;
-	unsigned long off = vma->vm_pgoff;
-	unsigned long pfn;
-	int ret = -ENXIO;
-
-	if (!plat_device_is_coherent(dev))
-		addr = CAC_ADDR(addr);
-
-	pfn = page_to_pfn(virt_to_page((void *)addr));
-
-	if (attrs & DMA_ATTR_WRITE_COMBINE)
-		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
-	else
-		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-
-	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
-		return ret;
-
-	if (off < count && user_count <= (count - off)) {
-		ret = remap_pfn_range(vma, vma->vm_start,
-				      pfn + off,
-				      user_count << PAGE_SHIFT,
-				      vma->vm_page_prot);
-	}
-
-	return ret;
-}
-
-static inline void __dma_sync_virtual(void *addr, size_t size,
-	enum dma_data_direction direction)
-{
-	switch (direction) {
-	case DMA_TO_DEVICE:
-		dma_cache_wback((unsigned long)addr, size);
-		break;
-
-	case DMA_FROM_DEVICE:
-		dma_cache_inv((unsigned long)addr, size);
-		break;
-
-	case DMA_BIDIRECTIONAL:
-		dma_cache_wback_inv((unsigned long)addr, size);
-		break;
-
-	default:
-		BUG();
-	}
-}
-
-/*
- * A single sg entry may refer to multiple physically contiguous
- * pages. But we still need to process highmem pages individually.
- * If highmem is not configured then the bulk of this loop gets
- * optimized out.
- */
-static inline void __dma_sync(struct page *page,
-	unsigned long offset, size_t size, enum dma_data_direction direction)
-{
-	size_t left = size;
-
-	do {
-		size_t len = left;
-
-		if (PageHighMem(page)) {
-			void *addr;
-
-			if (offset + len > PAGE_SIZE) {
-				if (offset >= PAGE_SIZE) {
-					page += offset >> PAGE_SHIFT;
-					offset &= ~PAGE_MASK;
-				}
-				len = PAGE_SIZE - offset;
-			}
-
-			addr = kmap_atomic(page);
-			__dma_sync_virtual(addr + offset, len, direction);
-			kunmap_atomic(addr);
-		} else
-			__dma_sync_virtual(page_address(page) + offset,
-					   size, direction);
-		offset = 0;
-		page++;
-		left -= len;
-	} while (left);
-}
-
-static void mips_dma_unmap_page(struct device *dev, dma_addr_t dma_addr,
-	size_t size, enum dma_data_direction direction, unsigned long attrs)
-{
-	if (cpu_needs_post_dma_flush(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		__dma_sync(dma_addr_to_page(dev, dma_addr),
-			   dma_addr & ~PAGE_MASK, size, direction);
-	plat_post_dma_flush(dev);
-	plat_unmap_dma_mem(dev, dma_addr, size, direction);
-}
-
-static int mips_dma_map_sg(struct device *dev, struct scatterlist *sglist,
-	int nents, enum dma_data_direction direction, unsigned long attrs)
-{
-	int i;
-	struct scatterlist *sg;
-
-	for_each_sg(sglist, sg, nents, i) {
-		if (!plat_device_is_coherent(dev) &&
-		    !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-			__dma_sync(sg_page(sg), sg->offset, sg->length,
-				   direction);
-#ifdef CONFIG_NEED_SG_DMA_LENGTH
-		sg->dma_length = sg->length;
-#endif
-		sg->dma_address = plat_map_dma_mem_page(dev, sg_page(sg)) +
-				  sg->offset;
-	}
-
-	return nents;
-}
-
-static dma_addr_t mips_dma_map_page(struct device *dev, struct page *page,
-	unsigned long offset, size_t size, enum dma_data_direction direction,
-	unsigned long attrs)
-{
-	if (!plat_device_is_coherent(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		__dma_sync(page, offset, size, direction);
-
-	return plat_map_dma_mem_page(dev, page) + offset;
-}
-
-static void mips_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
-	int nhwentries, enum dma_data_direction direction,
-	unsigned long attrs)
-{
-	int i;
-	struct scatterlist *sg;
-
-	for_each_sg(sglist, sg, nhwentries, i) {
-		if (!plat_device_is_coherent(dev) &&
-		    !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
-		    direction != DMA_TO_DEVICE)
-			__dma_sync(sg_page(sg), sg->offset, sg->length,
-				   direction);
-		plat_unmap_dma_mem(dev, sg->dma_address, sg->length, direction);
-	}
-}
-
-static void mips_dma_sync_single_for_cpu(struct device *dev,
-	dma_addr_t dma_handle, size_t size, enum dma_data_direction direction)
-{
-	if (cpu_needs_post_dma_flush(dev))
-		__dma_sync(dma_addr_to_page(dev, dma_handle),
-			   dma_handle & ~PAGE_MASK, size, direction);
-	plat_post_dma_flush(dev);
-}
-
-static void mips_dma_sync_single_for_device(struct device *dev,
-	dma_addr_t dma_handle, size_t size, enum dma_data_direction direction)
-{
-	if (!plat_device_is_coherent(dev))
-		__dma_sync(dma_addr_to_page(dev, dma_handle),
-			   dma_handle & ~PAGE_MASK, size, direction);
-}
-
-static void mips_dma_sync_sg_for_cpu(struct device *dev,
-	struct scatterlist *sglist, int nelems,
-	enum dma_data_direction direction)
-{
-	int i;
-	struct scatterlist *sg;
-
-	if (cpu_needs_post_dma_flush(dev)) {
-		for_each_sg(sglist, sg, nelems, i) {
-			__dma_sync(sg_page(sg), sg->offset, sg->length,
-				   direction);
-		}
-	}
-	plat_post_dma_flush(dev);
-}
-
-static void mips_dma_sync_sg_for_device(struct device *dev,
-	struct scatterlist *sglist, int nelems,
-	enum dma_data_direction direction)
-{
-	int i;
-	struct scatterlist *sg;
-
-	if (!plat_device_is_coherent(dev)) {
-		for_each_sg(sglist, sg, nelems, i) {
-			__dma_sync(sg_page(sg), sg->offset, sg->length,
-				   direction);
-		}
-	}
-}
-
-static int mips_dma_supported(struct device *dev, u64 mask)
-{
-	return plat_dma_supported(dev, mask);
-}
-
-static void mips_dma_cache_sync(struct device *dev, void *vaddr, size_t size,
-			 enum dma_data_direction direction)
-{
-	BUG_ON(direction == DMA_NONE);
-
-	if (!plat_device_is_coherent(dev))
-		__dma_sync_virtual(vaddr, size, direction);
-}
-
-const struct dma_map_ops mips_default_dma_map_ops = {
-	.alloc = mips_dma_alloc_coherent,
-	.free = mips_dma_free_coherent,
-	.mmap = mips_dma_mmap,
-	.map_page = mips_dma_map_page,
-	.unmap_page = mips_dma_unmap_page,
-	.map_sg = mips_dma_map_sg,
-	.unmap_sg = mips_dma_unmap_sg,
-	.sync_single_for_cpu = mips_dma_sync_single_for_cpu,
-	.sync_single_for_device = mips_dma_sync_single_for_device,
-	.sync_sg_for_cpu = mips_dma_sync_sg_for_cpu,
-	.sync_sg_for_device = mips_dma_sync_sg_for_device,
-	.dma_supported = mips_dma_supported,
-	.cache_sync = mips_dma_cache_sync,
-};
-EXPORT_SYMBOL(mips_default_dma_map_ops);
-- 
2.17.1
