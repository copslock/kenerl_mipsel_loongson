Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Aug 2013 13:24:58 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:35382 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822344Ab3HLLWwgKAKA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 12 Aug 2013 13:22:52 +0200
Received: by nf.local (Postfix, from userid 501)
        id 6CC254E01B7B; Mon, 12 Aug 2013 13:22:49 +0200 (CEST)
From:   Felix Fietkau <nbd@openwrt.org>
To:     linux-mips@linux-mips.org
Subject: [PATCH 2/2] MIPS: partially inline dma ops
Date:   Mon, 12 Aug 2013 13:22:49 +0200
Message-Id: <1376306569-83278-2-git-send-email-nbd@openwrt.org>
X-Mailer: git-send-email 1.8.0.2
In-Reply-To: <1376306569-83278-1-git-send-email-nbd@openwrt.org>
References: <1376306569-83278-1-git-send-email-nbd@openwrt.org>
Return-Path: <nbd@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37528
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nbd@openwrt.org
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

Several DMA ops are no-op on many platforms, and the indirection through
the mips_dma_map_ops function table is causing the compiler to emit
unnecessary code.

Inlining visibly improves network performance in my tests (on a 24Kc
based system), and also slightly reduces code size of a few drivers.

Signed-off-by: Felix Fietkau <nbd@openwrt.org>
---
 arch/mips/Kconfig                   |   4 +
 arch/mips/include/asm/dma-mapping.h | 360 +++++++++++++++++++++++++++++++++++-
 arch/mips/mm/dma-default.c          | 161 ++--------------
 3 files changed, 372 insertions(+), 153 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e12764c..c28e51c 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1393,6 +1393,7 @@ config CPU_CAVIUM_OCTEON
 	select LIBFDT
 	select USE_OF
 	select USB_EHCI_BIG_ENDIAN_MMIO
+	select SYS_HAS_DMA_OPS
 	help
 	  The Cavium Octeon processor is a highly integrated chip containing
 	  many ethernet hardware widgets for networking tasks. The processor
@@ -1613,6 +1614,9 @@ config SYS_HAS_CPU_XLR
 config SYS_HAS_CPU_XLP
 	bool
 
+config SYS_HAS_DMA_OPS
+	bool
+
 #
 # CPU may reorder R->R, R->W, W->R, W->W
 # Reordering beyond LL and SC is handled in WEAK_REORDERING_BEYOND_LLSC
diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
index 84238c5..1780a06 100644
--- a/arch/mips/include/asm/dma-mapping.h
+++ b/arch/mips/include/asm/dma-mapping.h
@@ -1,6 +1,12 @@
 #ifndef _ASM_DMA_MAPPING_H
 #define _ASM_DMA_MAPPING_H
 
+#include <linux/kmemcheck.h>
+#include <linux/bug.h>
+#include <linux/scatterlist.h>
+#include <linux/dma-debug.h>
+#include <linux/dma-attrs.h>
+
 #include <asm/scatterlist.h>
 #include <asm/dma-coherence.h>
 #include <asm/cache.h>
@@ -12,12 +18,47 @@
 
 extern struct dma_map_ops *mips_dma_map_ops;
 
+void __dma_sync(struct page *page, unsigned long offset, size_t size,
+		enum dma_data_direction direction);
+void *mips_dma_alloc_coherent(struct device *dev, size_t size,
+			      dma_addr_t *dma_handle, gfp_t gfp,
+			      struct dma_attrs *attrs);
+void mips_dma_free_coherent(struct device *dev, size_t size, void *vaddr,
+			    dma_addr_t dma_handle, struct dma_attrs *attrs);
+
 static inline struct dma_map_ops *get_dma_ops(struct device *dev)
 {
+#ifdef CONFIG_SYS_HAS_DMA_OPS
 	if (dev && dev->archdata.dma_ops)
 		return dev->archdata.dma_ops;
 	else
 		return mips_dma_map_ops;
+#else
+	return NULL;
+#endif
+}
+
+/*
+ * Warning on the terminology - Linux calls an uncached area coherent;
+ * MIPS terminology calls memory areas with hardware maintained coherency
+ * coherent.
+ */
+
+static inline int cpu_is_noncoherent_r10000(struct device *dev)
+{
+#ifndef CONFIG_SYS_HAS_CPU_R10000
+	return 0;
+#endif
+	return !plat_device_is_coherent(dev) &&
+	       (current_cpu_type() == CPU_R10000 ||
+	       current_cpu_type() == CPU_R12000);
+}
+
+static inline struct page *dma_addr_to_page(struct device *dev,
+	dma_addr_t dma_addr)
+{
+	return pfn_to_page(
+		plat_dma_addr_to_phys(dev, dma_addr) >> PAGE_SHIFT);
 }
 
 static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
@@ -30,12 +71,312 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 
 static inline void dma_mark_clean(void *addr, size_t size) {}
 
-#include <asm-generic/dma-mapping-common.h>
+static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
+					      size_t size,
+					      enum dma_data_direction dir,
+					      struct dma_attrs *attrs)
+{
+	struct dma_map_ops *ops = get_dma_ops(dev);
+	unsigned long offset = (unsigned long)ptr & ~PAGE_MASK;
+	struct page *page = virt_to_page(ptr);
+	dma_addr_t addr;
+
+	kmemcheck_mark_initialized(ptr, size);
+	BUG_ON(!valid_dma_direction(dir));
+	if (ops) {
+		addr = ops->map_page(dev, page, offset, size, dir, attrs);
+	} else {
+		if (!plat_device_is_coherent(dev))
+			__dma_sync(page, offset, size, dir);
+
+		addr = plat_map_dma_mem_page(dev, page) + offset;
+	}
+	debug_dma_map_page(dev, page, offset, size, dir, addr, true);
+	return addr;
+}
+
+static inline void dma_unmap_single_attrs(struct device *dev, dma_addr_t addr,
+					  size_t size,
+					  enum dma_data_direction dir,
+					  struct dma_attrs *attrs)
+{
+	struct dma_map_ops *ops = get_dma_ops(dev);
+
+	BUG_ON(!valid_dma_direction(dir));
+	if (ops) {
+		ops->unmap_page(dev, addr, size, dir, attrs);
+	} else {
+		if (cpu_is_noncoherent_r10000(dev))
+			__dma_sync(dma_addr_to_page(dev, addr),
+				   addr & ~PAGE_MASK, size, dir);
+
+		plat_unmap_dma_mem(dev, addr, size, dir);
+	}
+	debug_dma_unmap_page(dev, addr, size, dir, true);
+}
+
+static inline int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
+				   int nents, enum dma_data_direction dir,
+				   struct dma_attrs *attrs)
+{
+	struct dma_map_ops *ops = get_dma_ops(dev);
+	int i, ents;
+	struct scatterlist *s;
+
+	for_each_sg(sg, s, nents, i)
+		kmemcheck_mark_initialized(sg_virt(s), s->length);
+	BUG_ON(!valid_dma_direction(dir));
+	if (ops) {
+		ents = ops->map_sg(dev, sg, nents, dir, attrs);
+	} else {
+		for_each_sg(sg, s, nents, i) {
+			struct page *page = sg_page(s);
+
+			if (!plat_device_is_coherent(dev))
+				__dma_sync(page, s->offset, s->length, dir);
+#ifdef CONFIG_NEED_SG_DMA_LENGTH
+			s->dma_length = s->length;
+#endif
+			s->dma_address =
+				plat_map_dma_mem_page(dev, page) + s->offset;
+		}
+		ents = nents;
+	}
+	debug_dma_map_sg(dev, sg, nents, ents, dir);
+
+	return ents;
+}
+
+static inline void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
+				      int nents, enum dma_data_direction dir,
+				      struct dma_attrs *attrs)
+{
+	struct dma_map_ops *ops = get_dma_ops(dev);
+	struct scatterlist *s;
+	int i;
+
+	BUG_ON(!valid_dma_direction(dir));
+	debug_dma_unmap_sg(dev, sg, nents, dir);
+	if (ops) {
+		ops->unmap_sg(dev, sg, nents, dir, attrs);
+		return;
+	}
+
+	for_each_sg(sg, s, nents, i) {
+		if (!plat_device_is_coherent(dev) && dir != DMA_TO_DEVICE)
+			__dma_sync(sg_page(s), s->offset, s->length, dir);
+		plat_unmap_dma_mem(dev, s->dma_address, s->length, dir);
+	}
+}
+
+static inline dma_addr_t dma_map_page(struct device *dev, struct page *page,
+				      size_t offset, size_t size,
+				      enum dma_data_direction dir)
+{
+	struct dma_map_ops *ops = get_dma_ops(dev);
+	dma_addr_t addr;
+
+	kmemcheck_mark_initialized(page_address(page) + offset, size);
+	BUG_ON(!valid_dma_direction(dir));
+	if (ops) {
+		addr = ops->map_page(dev, page, offset, size, dir, NULL);
+	} else {
+		if (!plat_device_is_coherent(dev))
+			__dma_sync(page, offset, size, dir);
+
+		addr = plat_map_dma_mem_page(dev, page) + offset;
+	}
+	debug_dma_map_page(dev, page, offset, size, dir, addr, false);
+
+	return addr;
+}
+
+static inline void dma_unmap_page(struct device *dev, dma_addr_t addr,
+				  size_t size, enum dma_data_direction dir)
+{
+	struct dma_map_ops *ops = get_dma_ops(dev);
+
+	BUG_ON(!valid_dma_direction(dir));
+	if (ops) {
+		ops->unmap_page(dev, addr, size, dir, NULL);
+	} else {
+		if (cpu_is_noncoherent_r10000(dev))
+			__dma_sync(dma_addr_to_page(dev, addr),
+				   addr & ~PAGE_MASK, size, dir);
+
+		plat_unmap_dma_mem(dev, addr, size, dir);
+	}
+	debug_dma_unmap_page(dev, addr, size, dir, false);
+}
+
+static inline void dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr,
+					   size_t size,
+					   enum dma_data_direction dir)
+{
+	struct dma_map_ops *ops = get_dma_ops(dev);
+
+	BUG_ON(!valid_dma_direction(dir));
+	if (ops)
+		ops->sync_single_for_cpu(dev, addr, size, dir);
+	else if (cpu_is_noncoherent_r10000(dev))
+		__dma_sync(dma_addr_to_page(dev, addr),
+			   addr & ~PAGE_MASK, size, dir);
+	debug_dma_sync_single_for_cpu(dev, addr, size, dir);
+}
+
+static inline void dma_sync_single_for_device(struct device *dev,
+					      dma_addr_t addr, size_t size,
+					      enum dma_data_direction dir)
+{
+	struct dma_map_ops *ops = get_dma_ops(dev);
+
+	BUG_ON(!valid_dma_direction(dir));
+	if (ops)
+		ops->sync_single_for_device(dev, addr, size, dir);
+	else if (!plat_device_is_coherent(dev))
+		__dma_sync(dma_addr_to_page(dev, addr),
+			   addr & ~PAGE_MASK, size, dir);
+	debug_dma_sync_single_for_device(dev, addr, size, dir);
+}
+
+static inline void dma_sync_single_range_for_cpu(struct device *dev,
+						 dma_addr_t addr,
+						 unsigned long offset,
+						 size_t size,
+						 enum dma_data_direction dir)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	BUG_ON(!valid_dma_direction(dir));
+	if (ops)
+		ops->sync_single_for_cpu(dev, addr + offset, size, dir);
+	else if (cpu_is_noncoherent_r10000(dev))
+		__dma_sync(dma_addr_to_page(dev, addr + offset),
+			   (addr + offset) & ~PAGE_MASK, size, dir);
+	debug_dma_sync_single_range_for_cpu(dev, addr, offset, size, dir);
+}
+
+static inline void dma_sync_single_range_for_device(struct device *dev,
+						    dma_addr_t addr,
+						    unsigned long offset,
+						    size_t size,
+						    enum dma_data_direction dir)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	BUG_ON(!valid_dma_direction(dir));
+	if (ops)
+		ops->sync_single_for_device(dev, addr + offset, size, dir);
+	else if (!plat_device_is_coherent(dev))
+		__dma_sync(dma_addr_to_page(dev, addr + offset),
+			   (addr + offset) & ~PAGE_MASK, size, dir);
+	debug_dma_sync_single_range_for_device(dev, addr, offset, size, dir);
+}
+
+static inline void
+dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
+		    int nelems, enum dma_data_direction dir)
+{
+	struct dma_map_ops *ops = get_dma_ops(dev);
+	struct scatterlist *s;
+	int i;
+
+	BUG_ON(!valid_dma_direction(dir));
+	if (ops)
+		ops->sync_sg_for_cpu(dev, sg, nelems, dir);
+	else if (cpu_is_noncoherent_r10000(dev)) {
+		for_each_sg(sg, s, nelems, i)
+			__dma_sync(sg_page(s), s->offset, s->length, dir);
+	}
+	debug_dma_sync_sg_for_cpu(dev, sg, nelems, dir);
+}
+
+static inline void
+dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
+		       int nelems, enum dma_data_direction dir)
+{
+	struct dma_map_ops *ops = get_dma_ops(dev);
+	struct scatterlist *s;
+	int i;
+
+	BUG_ON(!valid_dma_direction(dir));
+	if (ops)
+		ops->sync_sg_for_device(dev, sg, nelems, dir);
+	else if (!plat_device_is_coherent(dev)) {
+		for_each_sg(sg, s, nelems, i)
+			__dma_sync(sg_page(s), s->offset, s->length, dir);
+	}
+	debug_dma_sync_sg_for_device(dev, sg, nelems, dir);
+
+}
+
+#define dma_map_single(d, a, s, r) dma_map_single_attrs(d, a, s, r, NULL)
+#define dma_unmap_single(d, a, s, r) dma_unmap_single_attrs(d, a, s, r, NULL)
+#define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, NULL)
+#define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, NULL)
+
+extern int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
+			   void *cpu_addr, dma_addr_t dma_addr, size_t size);
+
+/**
+ * dma_mmap_attrs - map a coherent DMA allocation into user space
+ * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
+ * @vma: vm_area_struct describing requested user mapping
+ * @cpu_addr: kernel CPU-view address returned from dma_alloc_attrs
+ * @handle: device-view address returned from dma_alloc_attrs
+ * @size: size of memory originally requested in dma_alloc_attrs
+ * @attrs: attributes of mapping properties requested in dma_alloc_attrs
+ *
+ * Map a coherent DMA buffer previously allocated by dma_alloc_attrs
+ * into user space.  The coherent DMA buffer must not be freed by the
+ * driver until the user space mapping has been released.
+ */
+static inline int
+dma_mmap_attrs(struct device *dev, struct vm_area_struct *vma, void *cpu_addr,
+	       dma_addr_t dma_addr, size_t size, struct dma_attrs *attrs)
+{
+	struct dma_map_ops *ops = get_dma_ops(dev);
+	BUG_ON(!ops);
+	if (ops && ops->mmap)
+		return ops->mmap(dev, vma, cpu_addr, dma_addr, size, attrs);
+	return dma_common_mmap(dev, vma, cpu_addr, dma_addr, size);
+}
+
+#define dma_mmap_coherent(d, v, c, h, s) dma_mmap_attrs(d, v, c, h, s, NULL)
+
+static inline int dma_mmap_writecombine(struct device *dev, struct vm_area_struct *vma,
+		      void *cpu_addr, dma_addr_t dma_addr, size_t size)
+{
+	DEFINE_DMA_ATTRS(attrs);
+	dma_set_attr(DMA_ATTR_WRITE_COMBINE, &attrs);
+	return dma_mmap_attrs(dev, vma, cpu_addr, dma_addr, size, &attrs);
+}
+
+int
+dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
+		       void *cpu_addr, dma_addr_t dma_addr, size_t size);
+
+static inline int
+dma_get_sgtable_attrs(struct device *dev, struct sg_table *sgt, void *cpu_addr,
+		      dma_addr_t dma_addr, size_t size, struct dma_attrs *attrs)
+{
+	struct dma_map_ops *ops = get_dma_ops(dev);
+	BUG_ON(!ops);
+	if (ops && ops->get_sgtable)
+		return ops->get_sgtable(dev, sgt, cpu_addr, dma_addr, size,
+					attrs);
+	return dma_common_get_sgtable(dev, sgt, cpu_addr, dma_addr, size);
+}
+
+#define dma_get_sgtable(d, t, v, h, s) dma_get_sgtable_attrs(d, t, v, h, s, NULL)
+
 
 static inline int dma_supported(struct device *dev, u64 mask)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
-	return ops->dma_supported(dev, mask);
+	if (ops)
+		return ops->dma_supported(dev, mask);
+	return plat_dma_supported(dev, mask);
 }
 
 static inline int dma_mapping_error(struct device *dev, u64 mask)
@@ -43,7 +384,9 @@ static inline int dma_mapping_error(struct device *dev, u64 mask)
 	struct dma_map_ops *ops = get_dma_ops(dev);
 
 	debug_dma_mapping_error(dev, mask);
-	return ops->mapping_error(dev, mask);
+	if (ops)
+		return ops->mapping_error(dev, mask);
+	return 0;
 }
 
 static inline int
@@ -69,7 +412,11 @@ static inline void *dma_alloc_attrs(struct device *dev, size_t size,
 	void *ret;
 	struct dma_map_ops *ops = get_dma_ops(dev);
 
-	ret = ops->alloc(dev, size, dma_handle, gfp, attrs);
+	if (ops)
+		ret = ops->alloc(dev, size, dma_handle, gfp, attrs);
+	else
+		ret = mips_dma_alloc_coherent(dev, size, dma_handle, gfp,
+					      attrs);
 
 	debug_dma_alloc_coherent(dev, size, *dma_handle, ret);
 
@@ -84,7 +431,10 @@ static inline void dma_free_attrs(struct device *dev, size_t size,
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
 
-	ops->free(dev, size, vaddr, dma_handle, attrs);
+	if (ops)
+		ops->free(dev, size, vaddr, dma_handle, attrs);
+	else
+		mips_dma_free_coherent(dev, size, vaddr, dma_handle, attrs);
 
 	debug_dma_free_coherent(dev, size, vaddr, dma_handle);
 }
diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index 63e45d6..860f918 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -42,26 +42,6 @@ static int __init setnocoherentio(char *str)
 }
 early_param("nocoherentio", setnocoherentio);
 
-static inline struct page *dma_addr_to_page(struct device *dev,
-	dma_addr_t dma_addr)
-{
-	return pfn_to_page(
-		plat_dma_addr_to_phys(dev, dma_addr) >> PAGE_SHIFT);
-}
-
-/*
- * Warning on the terminology - Linux calls an uncached area coherent;
- * MIPS terminology calls memory areas with hardware maintained coherency
- * coherent.
- */
-
-static inline int cpu_is_noncoherent_r10000(struct device *dev)
-{
-	return !plat_device_is_coherent(dev) &&
-	       (current_cpu_type() == CPU_R10000 ||
-	       current_cpu_type() == CPU_R12000);
-}
-
 static gfp_t massage_gfp_flags(const struct device *dev, gfp_t gfp)
 {
 	gfp_t dma_flag;
@@ -117,8 +97,9 @@ void *dma_alloc_noncoherent(struct device *dev, size_t size,
 }
 EXPORT_SYMBOL(dma_alloc_noncoherent);
 
-static void *mips_dma_alloc_coherent(struct device *dev, size_t size,
-	dma_addr_t * dma_handle, gfp_t gfp, struct dma_attrs *attrs)
+void *mips_dma_alloc_coherent(struct device *dev, size_t size,
+			      dma_addr_t *dma_handle, gfp_t gfp,
+			      struct dma_attrs *attrs)
 {
 	void *ret;
 
@@ -142,6 +123,7 @@ static void *mips_dma_alloc_coherent(struct device *dev, size_t size,
 
 	return ret;
 }
+EXPORT_SYMBOL(mips_dma_alloc_coherent);
 
 
 void dma_free_noncoherent(struct device *dev, size_t size, void *vaddr,
@@ -152,8 +134,8 @@ void dma_free_noncoherent(struct device *dev, size_t size, void *vaddr,
 }
 EXPORT_SYMBOL(dma_free_noncoherent);
 
-static void mips_dma_free_coherent(struct device *dev, size_t size, void *vaddr,
-	dma_addr_t dma_handle, struct dma_attrs *attrs)
+void mips_dma_free_coherent(struct device *dev, size_t size, void *vaddr,
+			    dma_addr_t dma_handle, struct dma_attrs *attrs)
 {
 	unsigned long addr = (unsigned long) vaddr;
 	int order = get_order(size);
@@ -168,6 +150,7 @@ static void mips_dma_free_coherent(struct device *dev, size_t size, void *vaddr,
 
 	free_pages(addr, get_order(size));
 }
+EXPORT_SYMBOL(mips_dma_free_coherent);
 
 static inline void __dma_sync_virtual(void *addr, size_t size,
 	enum dma_data_direction direction)
@@ -196,8 +179,8 @@ static inline void __dma_sync_virtual(void *addr, size_t size,
  * If highmem is not configured then the bulk of this loop gets
  * optimized out.
  */
-static inline void __dma_sync(struct page *page,
-	unsigned long offset, size_t size, enum dma_data_direction direction)
+void __dma_sync(struct page *page, unsigned long offset, size_t size,
+		enum dma_data_direction direction)
 {
 	size_t left = size;
 
@@ -226,112 +209,7 @@ static inline void __dma_sync(struct page *page,
 		left -= len;
 	} while (left);
 }
-
-static void mips_dma_unmap_page(struct device *dev, dma_addr_t dma_addr,
-	size_t size, enum dma_data_direction direction, struct dma_attrs *attrs)
-{
-	if (cpu_is_noncoherent_r10000(dev))
-		__dma_sync(dma_addr_to_page(dev, dma_addr),
-			   dma_addr & ~PAGE_MASK, size, direction);
-
-	plat_unmap_dma_mem(dev, dma_addr, size, direction);
-}
-
-static int mips_dma_map_sg(struct device *dev, struct scatterlist *sg,
-	int nents, enum dma_data_direction direction, struct dma_attrs *attrs)
-{
-	int i;
-
-	for (i = 0; i < nents; i++, sg++) {
-		if (!plat_device_is_coherent(dev))
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
-	struct dma_attrs *attrs)
-{
-	if (!plat_device_is_coherent(dev))
-		__dma_sync(page, offset, size, direction);
-
-	return plat_map_dma_mem_page(dev, page) + offset;
-}
-
-static void mips_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
-	int nhwentries, enum dma_data_direction direction,
-	struct dma_attrs *attrs)
-{
-	int i;
-
-	for (i = 0; i < nhwentries; i++, sg++) {
-		if (!plat_device_is_coherent(dev) &&
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
-	if (cpu_is_noncoherent_r10000(dev))
-		__dma_sync(dma_addr_to_page(dev, dma_handle),
-			   dma_handle & ~PAGE_MASK, size, direction);
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
-	struct scatterlist *sg, int nelems, enum dma_data_direction direction)
-{
-	int i;
-
-	/* Make sure that gcc doesn't leave the empty loop body.  */
-	for (i = 0; i < nelems; i++, sg++) {
-		if (cpu_is_noncoherent_r10000(dev))
-			__dma_sync(sg_page(sg), sg->offset, sg->length,
-				   direction);
-	}
-}
-
-static void mips_dma_sync_sg_for_device(struct device *dev,
-	struct scatterlist *sg, int nelems, enum dma_data_direction direction)
-{
-	int i;
-
-	/* Make sure that gcc doesn't leave the empty loop body.  */
-	for (i = 0; i < nelems; i++, sg++) {
-		if (!plat_device_is_coherent(dev))
-			__dma_sync(sg_page(sg), sg->offset, sg->length,
-				   direction);
-	}
-}
-
-int mips_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return 0;
-}
-
-int mips_dma_supported(struct device *dev, u64 mask)
-{
-	return plat_dma_supported(dev, mask);
-}
+EXPORT_SYMBOL(__dma_sync);
 
 void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 			 enum dma_data_direction direction)
@@ -344,23 +222,10 @@ void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 
 EXPORT_SYMBOL(dma_cache_sync);
 
-static struct dma_map_ops mips_default_dma_map_ops = {
-	.alloc = mips_dma_alloc_coherent,
-	.free = mips_dma_free_coherent,
-	.map_page = mips_dma_map_page,
-	.unmap_page = mips_dma_unmap_page,
-	.map_sg = mips_dma_map_sg,
-	.unmap_sg = mips_dma_unmap_sg,
-	.sync_single_for_cpu = mips_dma_sync_single_for_cpu,
-	.sync_single_for_device = mips_dma_sync_single_for_device,
-	.sync_sg_for_cpu = mips_dma_sync_sg_for_cpu,
-	.sync_sg_for_device = mips_dma_sync_sg_for_device,
-	.mapping_error = mips_dma_mapping_error,
-	.dma_supported = mips_dma_supported
-};
-
-struct dma_map_ops *mips_dma_map_ops = &mips_default_dma_map_ops;
+#ifdef CONFIG_SYS_HAS_DMA_OPS
+struct dma_map_ops *mips_dma_map_ops = NULL;
 EXPORT_SYMBOL(mips_dma_map_ops);
+#endif
 
 #define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
 
-- 
1.8.0.2
