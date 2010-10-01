Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Oct 2010 22:30:21 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:8592 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492026Ab0JAU1x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Oct 2010 22:27:53 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4ca644670001>; Fri, 01 Oct 2010 13:28:23 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 1 Oct 2010 13:27:52 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 1 Oct 2010 13:27:52 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o91KRikV028724;
        Fri, 1 Oct 2010 13:27:44 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o91KRihb028723;
        Fri, 1 Oct 2010 13:27:44 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 6/8] MIPS: Convert DMA to use dma-mapping-common.h
Date:   Fri,  1 Oct 2010 13:27:32 -0700
Message-Id: <1285964854-28659-7-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.2
In-Reply-To: <1285964854-28659-1-git-send-email-ddaney@caviumnetworks.com>
References: <1285964854-28659-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 01 Oct 2010 20:27:52.0658 (UTC) FILETIME=[1F873B20:01CB61A7]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27920
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Use asm-generic/dma-mapping-common.h to handle all DMA mapping
operations and establish a default get_dma_ops() that forwards all
operations to the existing code.

Augment dev_archdata to carry a pointer to the struct dma_map_ops,
allowing DMA operations to be overridden on a per device basis.
Currently this is never filled in, so the default dma_map_ops are
used.  A follow-on patch sets this for Octeon PCI devices.

Also initialize the dma_debug system as it is now used if it is
configured.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/Kconfig                                  |    2 +
 arch/mips/include/asm/device.h                     |   15 ++-
 arch/mips/include/asm/dma-mapping.h                |   96 +++++++-----
 .../include/asm/mach-cavium-octeon/dma-coherence.h |    6 -
 arch/mips/include/asm/mach-generic/dma-coherence.h |    6 -
 arch/mips/include/asm/mach-ip27/dma-coherence.h    |    7 -
 arch/mips/include/asm/mach-ip32/dma-coherence.h    |   12 --
 arch/mips/include/asm/mach-jazz/dma-coherence.h    |    5 -
 .../mips/include/asm/mach-loongson/dma-coherence.h |    6 -
 arch/mips/include/asm/mach-powertv/dma-coherence.h |    6 -
 arch/mips/mm/dma-default.c                         |  165 +++++++-------------
 11 files changed, 129 insertions(+), 197 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 6c33709..e68b89f 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -14,6 +14,8 @@ config MIPS
 	select HAVE_KRETPROBES
 	select RTC_LIB if !MACH_LOONGSON
 	select GENERIC_ATOMIC64 if !64BIT
+	select HAVE_DMA_ATTRS
+	select HAVE_DMA_API_DEBUG
 
 mainmenu "Linux/MIPS Kernel Configuration"
 
diff --git a/arch/mips/include/asm/device.h b/arch/mips/include/asm/device.h
index 06746c5..c94fafb 100644
--- a/arch/mips/include/asm/device.h
+++ b/arch/mips/include/asm/device.h
@@ -3,4 +3,17 @@
  *
  * This file is released under the GPLv2
  */
-#include <asm-generic/device.h>
+#ifndef _ASM_MIPS_DEVICE_H
+#define _ASM_MIPS_DEVICE_H
+
+struct dma_map_ops;
+
+struct dev_archdata {
+	/* DMA operations on that device */
+	struct dma_map_ops *dma_ops;
+};
+
+struct pdev_archdata {
+};
+
+#endif /* _ASM_MIPS_DEVICE_H*/
diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
index 18fbf7a..655f849 100644
--- a/arch/mips/include/asm/dma-mapping.h
+++ b/arch/mips/include/asm/dma-mapping.h
@@ -5,51 +5,41 @@
 #include <asm/cache.h>
 #include <asm-generic/dma-coherent.h>
 
-void *dma_alloc_noncoherent(struct device *dev, size_t size,
-			   dma_addr_t *dma_handle, gfp_t flag);
+#include <dma-coherence.h>
 
-void dma_free_noncoherent(struct device *dev, size_t size,
-			 void *vaddr, dma_addr_t dma_handle);
+extern struct dma_map_ops *mips_dma_map_ops;
 
-void *dma_alloc_coherent(struct device *dev, size_t size,
-			   dma_addr_t *dma_handle, gfp_t flag);
+static inline struct dma_map_ops *get_dma_ops(struct device *dev)
+{
+	if (dev && dev->archdata.dma_ops)
+		return dev->archdata.dma_ops;
+	else
+		return mips_dma_map_ops;
+}
 
-void dma_free_coherent(struct device *dev, size_t size,
-			 void *vaddr, dma_addr_t dma_handle);
+static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
+{
+	if (!dev->dma_mask)
+		return 0;
 
-extern dma_addr_t dma_map_single(struct device *dev, void *ptr, size_t size,
-	enum dma_data_direction direction);
-extern void dma_unmap_single(struct device *dev, dma_addr_t dma_addr,
-	size_t size, enum dma_data_direction direction);
-extern int dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-	enum dma_data_direction direction);
-extern dma_addr_t dma_map_page(struct device *dev, struct page *page,
-	unsigned long offset, size_t size, enum dma_data_direction direction);
-
-static inline void dma_unmap_page(struct device *dev, dma_addr_t dma_address,
-	size_t size, enum dma_data_direction direction)
+	return addr + size <= *dev->dma_mask;
+}
+
+static inline void dma_mark_clean(void *addr, size_t size) {}
+
+#include <asm-generic/dma-mapping-common.h>
+
+static inline int dma_supported(struct device *dev, u64 mask)
 {
-	dma_unmap_single(dev, dma_address, size, direction);
+	struct dma_map_ops *ops = get_dma_ops(dev);
+	return ops->dma_supported(dev, mask);
 }
 
-extern void dma_unmap_sg(struct device *dev, struct scatterlist *sg,
-	int nhwentries, enum dma_data_direction direction);
-extern void dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle,
-	size_t size, enum dma_data_direction direction);
-extern void dma_sync_single_for_device(struct device *dev,
-	dma_addr_t dma_handle, size_t size, enum dma_data_direction direction);
-extern void dma_sync_single_range_for_cpu(struct device *dev,
-	dma_addr_t dma_handle, unsigned long offset, size_t size,
-	enum dma_data_direction direction);
-extern void dma_sync_single_range_for_device(struct device *dev,
-	dma_addr_t dma_handle, unsigned long offset, size_t size,
-	enum dma_data_direction direction);
-extern void dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
-	int nelems, enum dma_data_direction direction);
-extern void dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
-	int nelems, enum dma_data_direction direction);
-extern int dma_mapping_error(struct device *dev, dma_addr_t dma_addr);
-extern int dma_supported(struct device *dev, u64 mask);
+static inline int dma_mapping_error(struct device *dev, u64 mask)
+{
+	struct dma_map_ops *ops = get_dma_ops(dev);
+	return ops->mapping_error(dev, mask);
+}
 
 static inline int
 dma_set_mask(struct device *dev, u64 mask)
@@ -65,4 +55,34 @@ dma_set_mask(struct device *dev, u64 mask)
 extern void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 	       enum dma_data_direction direction);
 
+static inline void *dma_alloc_coherent(struct device *dev, size_t size,
+				       dma_addr_t *dma_handle, gfp_t gfp)
+{
+	void *ret;
+	struct dma_map_ops *ops = get_dma_ops(dev);
+
+	ret = ops->alloc_coherent(dev, size, dma_handle, gfp);
+
+	debug_dma_alloc_coherent(dev, size, *dma_handle, ret);
+
+	return ret;
+}
+
+static inline void dma_free_coherent(struct device *dev, size_t size,
+				     void *vaddr, dma_addr_t dma_handle)
+{
+	struct dma_map_ops *ops = get_dma_ops(dev);
+
+	ops->free_coherent(dev, size, vaddr, dma_handle);
+
+	debug_dma_free_coherent(dev, size, vaddr, dma_handle);
+}
+
+
+void *dma_alloc_noncoherent(struct device *dev, size_t size,
+			   dma_addr_t *dma_handle, gfp_t flag);
+
+void dma_free_noncoherent(struct device *dev, size_t size,
+			 void *vaddr, dma_addr_t dma_handle);
+
 #endif /* _ASM_DMA_MAPPING_H */
diff --git a/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h b/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
index 17d5794..89d7631 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
@@ -24,12 +24,6 @@ static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
 	return octeon_map_dma_mem(dev, addr, size);
 }
 
-static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
-	struct page *page)
-{
-	return octeon_map_dma_mem(dev, page_address(page), PAGE_SIZE);
-}
-
 static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
 	dma_addr_t dma_addr)
 {
diff --git a/arch/mips/include/asm/mach-generic/dma-coherence.h b/arch/mips/include/asm/mach-generic/dma-coherence.h
index 8da9807..8259966 100644
--- a/arch/mips/include/asm/mach-generic/dma-coherence.h
+++ b/arch/mips/include/asm/mach-generic/dma-coherence.h
@@ -17,12 +17,6 @@ static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
 	return virt_to_phys(addr);
 }
 
-static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
-	struct page *page)
-{
-	return page_to_phys(page);
-}
-
 static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
 	dma_addr_t dma_addr)
 {
diff --git a/arch/mips/include/asm/mach-ip27/dma-coherence.h b/arch/mips/include/asm/mach-ip27/dma-coherence.h
index 7aa5ef9..2a55c55 100644
--- a/arch/mips/include/asm/mach-ip27/dma-coherence.h
+++ b/arch/mips/include/asm/mach-ip27/dma-coherence.h
@@ -26,13 +26,6 @@ static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
 	return pa;
 }
 
-static inline dma_addr_t plat_map_dma_mem_page(struct device *dev, struct page *page)
-{
-	dma_addr_t pa = dev_to_baddr(dev, page_to_phys(page));
-
-	return pa;
-}
-
 static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
 	dma_addr_t dma_addr)
 {
diff --git a/arch/mips/include/asm/mach-ip32/dma-coherence.h b/arch/mips/include/asm/mach-ip32/dma-coherence.h
index 55123fc..f204a1f 100644
--- a/arch/mips/include/asm/mach-ip32/dma-coherence.h
+++ b/arch/mips/include/asm/mach-ip32/dma-coherence.h
@@ -37,18 +37,6 @@ static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
 	return pa;
 }
 
-static inline dma_addr_t plat_map_dma_mem_page(struct device *dev, struct page *page)
-{
-	dma_addr_t pa;
-
-	pa = page_to_phys(page) & RAM_OFFSET_MASK;
-
-	if (dev == NULL)
-		pa += CRIME_HI_MEM_BASE;
-
-	return pa;
-}
-
 /* This is almost certainly wrong but it's what dma-ip32.c used to use  */
 static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
 	dma_addr_t dma_addr)
diff --git a/arch/mips/include/asm/mach-jazz/dma-coherence.h b/arch/mips/include/asm/mach-jazz/dma-coherence.h
index 2a10920..f2bc39a 100644
--- a/arch/mips/include/asm/mach-jazz/dma-coherence.h
+++ b/arch/mips/include/asm/mach-jazz/dma-coherence.h
@@ -17,11 +17,6 @@ static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr, size_t
 	return vdma_alloc(virt_to_phys(addr), size);
 }
 
-static inline dma_addr_t plat_map_dma_mem_page(struct device *dev, struct page *page)
-{
-	return vdma_alloc(page_to_phys(page), PAGE_SIZE);
-}
-
 static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
 	dma_addr_t dma_addr)
 {
diff --git a/arch/mips/include/asm/mach-loongson/dma-coherence.h b/arch/mips/include/asm/mach-loongson/dma-coherence.h
index 981c75f..8daeaee 100644
--- a/arch/mips/include/asm/mach-loongson/dma-coherence.h
+++ b/arch/mips/include/asm/mach-loongson/dma-coherence.h
@@ -19,12 +19,6 @@ static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
 	return virt_to_phys(addr) | 0x80000000;
 }
 
-static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
-					       struct page *page)
-{
-	return page_to_phys(page) | 0x80000000;
-}
-
 static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
 	dma_addr_t dma_addr)
 {
diff --git a/arch/mips/include/asm/mach-powertv/dma-coherence.h b/arch/mips/include/asm/mach-powertv/dma-coherence.h
index f76029c..647de8c 100644
--- a/arch/mips/include/asm/mach-powertv/dma-coherence.h
+++ b/arch/mips/include/asm/mach-powertv/dma-coherence.h
@@ -70,12 +70,6 @@ static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
 		return phys_to_dma(virt_to_phys(addr));
 }
 
-static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
-	struct page *page)
-{
-	return phys_to_dma(page_to_phys(page));
-}
-
 static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
 	dma_addr_t dma_addr)
 {
diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index 469d401..4fc1a0f 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -95,10 +95,9 @@ void *dma_alloc_noncoherent(struct device *dev, size_t size,
 
 	return ret;
 }
-
 EXPORT_SYMBOL(dma_alloc_noncoherent);
 
-void *dma_alloc_coherent(struct device *dev, size_t size,
+static void *mips_dma_alloc_coherent(struct device *dev, size_t size,
 	dma_addr_t * dma_handle, gfp_t gfp)
 {
 	void *ret;
@@ -123,7 +122,6 @@ void *dma_alloc_coherent(struct device *dev, size_t size,
 	return ret;
 }
 
-EXPORT_SYMBOL(dma_alloc_coherent);
 
 void dma_free_noncoherent(struct device *dev, size_t size, void *vaddr,
 	dma_addr_t dma_handle)
@@ -131,10 +129,9 @@ void dma_free_noncoherent(struct device *dev, size_t size, void *vaddr,
 	plat_unmap_dma_mem(dev, dma_handle, size, DMA_BIDIRECTIONAL);
 	free_pages((unsigned long) vaddr, get_order(size));
 }
-
 EXPORT_SYMBOL(dma_free_noncoherent);
 
-void dma_free_coherent(struct device *dev, size_t size, void *vaddr,
+static void mips_dma_free_coherent(struct device *dev, size_t size, void *vaddr,
 	dma_addr_t dma_handle)
 {
 	unsigned long addr = (unsigned long) vaddr;
@@ -151,8 +148,6 @@ void dma_free_coherent(struct device *dev, size_t size, void *vaddr,
 	free_pages(addr, get_order(size));
 }
 
-EXPORT_SYMBOL(dma_free_coherent);
-
 static inline void __dma_sync(unsigned long addr, size_t size,
 	enum dma_data_direction direction)
 {
@@ -174,21 +169,8 @@ static inline void __dma_sync(unsigned long addr, size_t size,
 	}
 }
 
-dma_addr_t dma_map_single(struct device *dev, void *ptr, size_t size,
-	enum dma_data_direction direction)
-{
-	unsigned long addr = (unsigned long) ptr;
-
-	if (!plat_device_is_coherent(dev))
-		__dma_sync(addr, size, direction);
-
-	return plat_map_dma_mem(dev, ptr, size);
-}
-
-EXPORT_SYMBOL(dma_map_single);
-
-void dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
-	enum dma_data_direction direction)
+static void mips_dma_unmap_page(struct device *dev, dma_addr_t dma_addr,
+	size_t size, enum dma_data_direction direction, struct dma_attrs *attrs)
 {
 	if (cpu_is_noncoherent_r10000(dev))
 		__dma_sync(dma_addr_to_virt(dev, dma_addr), size,
@@ -197,15 +179,11 @@ void dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
 	plat_unmap_dma_mem(dev, dma_addr, size, direction);
 }
 
-EXPORT_SYMBOL(dma_unmap_single);
-
-int dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-	enum dma_data_direction direction)
+static int mips_dma_map_sg(struct device *dev, struct scatterlist *sg,
+	int nents, enum dma_data_direction direction, struct dma_attrs *attrs)
 {
 	int i;
 
-	BUG_ON(direction == DMA_NONE);
-
 	for (i = 0; i < nents; i++, sg++) {
 		unsigned long addr;
 
@@ -219,33 +197,27 @@ int dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 	return nents;
 }
 
-EXPORT_SYMBOL(dma_map_sg);
-
-dma_addr_t dma_map_page(struct device *dev, struct page *page,
-	unsigned long offset, size_t size, enum dma_data_direction direction)
+static dma_addr_t mips_dma_map_page(struct device *dev, struct page *page,
+	unsigned long offset, size_t size, enum dma_data_direction direction,
+	struct dma_attrs *attrs)
 {
-	BUG_ON(direction == DMA_NONE);
+	unsigned long addr;
 
-	if (!plat_device_is_coherent(dev)) {
-		unsigned long addr;
+	addr = (unsigned long) page_address(page) + offset;
 
-		addr = (unsigned long) page_address(page) + offset;
+	if (!plat_device_is_coherent(dev))
 		__dma_sync(addr, size, direction);
-	}
 
-	return plat_map_dma_mem_page(dev, page) + offset;
+	return plat_map_dma_mem(dev, (void *)addr, size);
 }
 
-EXPORT_SYMBOL(dma_map_page);
-
-void dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
-	enum dma_data_direction direction)
+static void mips_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
+	int nhwentries, enum dma_data_direction direction,
+	struct dma_attrs *attrs)
 {
 	unsigned long addr;
 	int i;
 
-	BUG_ON(direction == DMA_NONE);
-
 	for (i = 0; i < nhwentries; i++, sg++) {
 		if (!plat_device_is_coherent(dev) &&
 		    direction != DMA_TO_DEVICE) {
@@ -257,13 +229,9 @@ void dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
 	}
 }
 
-EXPORT_SYMBOL(dma_unmap_sg);
-
-void dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle,
-	size_t size, enum dma_data_direction direction)
+static void mips_dma_sync_single_for_cpu(struct device *dev,
+	dma_addr_t dma_handle, size_t size, enum dma_data_direction direction)
 {
-	BUG_ON(direction == DMA_NONE);
-
 	if (cpu_is_noncoherent_r10000(dev)) {
 		unsigned long addr;
 
@@ -272,13 +240,9 @@ void dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle,
 	}
 }
 
-EXPORT_SYMBOL(dma_sync_single_for_cpu);
-
-void dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle,
-	size_t size, enum dma_data_direction direction)
+static void mips_dma_sync_single_for_device(struct device *dev,
+	dma_addr_t dma_handle, size_t size, enum dma_data_direction direction)
 {
-	BUG_ON(direction == DMA_NONE);
-
 	plat_extra_sync_for_device(dev);
 	if (!plat_device_is_coherent(dev)) {
 		unsigned long addr;
@@ -288,46 +252,11 @@ void dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle,
 	}
 }
 
-EXPORT_SYMBOL(dma_sync_single_for_device);
-
-void dma_sync_single_range_for_cpu(struct device *dev, dma_addr_t dma_handle,
-	unsigned long offset, size_t size, enum dma_data_direction direction)
-{
-	BUG_ON(direction == DMA_NONE);
-
-	if (cpu_is_noncoherent_r10000(dev)) {
-		unsigned long addr;
-
-		addr = dma_addr_to_virt(dev, dma_handle);
-		__dma_sync(addr + offset, size, direction);
-	}
-}
-
-EXPORT_SYMBOL(dma_sync_single_range_for_cpu);
-
-void dma_sync_single_range_for_device(struct device *dev, dma_addr_t dma_handle,
-	unsigned long offset, size_t size, enum dma_data_direction direction)
-{
-	BUG_ON(direction == DMA_NONE);
-
-	plat_extra_sync_for_device(dev);
-	if (!plat_device_is_coherent(dev)) {
-		unsigned long addr;
-
-		addr = dma_addr_to_virt(dev, dma_handle);
-		__dma_sync(addr + offset, size, direction);
-	}
-}
-
-EXPORT_SYMBOL(dma_sync_single_range_for_device);
-
-void dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg, int nelems,
-	enum dma_data_direction direction)
+static void mips_dma_sync_sg_for_cpu(struct device *dev,
+	struct scatterlist *sg, int nelems, enum dma_data_direction direction)
 {
 	int i;
 
-	BUG_ON(direction == DMA_NONE);
-
 	/* Make sure that gcc doesn't leave the empty loop body.  */
 	for (i = 0; i < nelems; i++, sg++) {
 		if (cpu_is_noncoherent_r10000(dev))
@@ -336,15 +265,11 @@ void dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg, int nelems,
 	}
 }
 
-EXPORT_SYMBOL(dma_sync_sg_for_cpu);
-
-void dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg, int nelems,
-	enum dma_data_direction direction)
+static void mips_dma_sync_sg_for_device(struct device *dev,
+	struct scatterlist *sg, int nelems, enum dma_data_direction direction)
 {
 	int i;
 
-	BUG_ON(direction == DMA_NONE);
-
 	/* Make sure that gcc doesn't leave the empty loop body.  */
 	for (i = 0; i < nelems; i++, sg++) {
 		if (!plat_device_is_coherent(dev))
@@ -353,24 +278,18 @@ void dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg, int nele
 	}
 }
 
-EXPORT_SYMBOL(dma_sync_sg_for_device);
-
-int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
+int mips_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 {
 	return plat_dma_mapping_error(dev, dma_addr);
 }
 
-EXPORT_SYMBOL(dma_mapping_error);
-
-int dma_supported(struct device *dev, u64 mask)
+int mips_dma_supported(struct device *dev, u64 mask)
 {
 	return plat_dma_supported(dev, mask);
 }
 
-EXPORT_SYMBOL(dma_supported);
-
-void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
-	       enum dma_data_direction direction)
+void mips_dma_cache_sync(struct device *dev, void *vaddr, size_t size,
+			 enum dma_data_direction direction)
 {
 	BUG_ON(direction == DMA_NONE);
 
@@ -379,4 +298,30 @@ void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 		__dma_sync((unsigned long)vaddr, size, direction);
 }
 
-EXPORT_SYMBOL(dma_cache_sync);
+static struct dma_map_ops mips_default_dma_map_ops = {
+	.alloc_coherent = mips_dma_alloc_coherent,
+	.free_coherent = mips_dma_free_coherent,
+	.map_page = mips_dma_map_page,
+	.unmap_page = mips_dma_unmap_page,
+	.map_sg = mips_dma_map_sg,
+	.unmap_sg = mips_dma_unmap_sg,
+	.sync_single_for_cpu = mips_dma_sync_single_for_cpu,
+	.sync_single_for_device = mips_dma_sync_single_for_device,
+	.sync_sg_for_cpu = mips_dma_sync_sg_for_cpu,
+	.sync_sg_for_device = mips_dma_sync_sg_for_device,
+	.mapping_error = mips_dma_mapping_error,
+	.dma_supported = mips_dma_supported
+};
+
+struct dma_map_ops *mips_dma_map_ops = &mips_default_dma_map_ops;
+EXPORT_SYMBOL(mips_dma_map_ops);
+
+#define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
+
+static int __init mips_dma_init(void)
+{
+	dma_debug_init(PREALLOC_DMA_DEBUG_ENTRIES);
+
+	return 0;
+}
+fs_initcall(mips_dma_init);
-- 
1.7.2.2
