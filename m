Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 20:14:44 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:60454 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994830AbdFPSLnj0BzW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2017 20:11:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lR97CyW8NWSugSIGv1XUwMTencLRtpiTCysPQJU4+Es=; b=iAnUca8aasf4rSFWni9GKcXFY
        cW4BZQLOzpql+9fhP5XL/u2WYNX1KNjTgFwcjQRRFByGQta4XsvM74EHX+Zq1kOTVrZYlCYAoqliu
        3X5JRJPwFTQgZLB0q+1afUqK7hC5giCvJmKADSYgkt8u+U+h5AyuR7Ew/zUeQ5VA9Tg+FzFuXEl7s
        Iin2PxkKvFhbhgoCEzIHykimrGcjrK/WHQcWTNIzuDH+vQqd91EVXoWKAMs6ekj+i8jxDwUx50Jby
        ihvTv4swYIQ34PAb9dLHCyoUtpY2XvHPy6gXNM8F8aMnl2xrI3BfCrG9+Oblpe7iJpnpyh+Sa+lcG
        SfBX0pISg==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dLviV-0004ai-KX; Fri, 16 Jun 2017 18:11:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 07/44] xen-swiotlb: consolidate xen_swiotlb_dma_ops
Date:   Fri, 16 Jun 2017 20:10:22 +0200
Message-Id: <20170616181059.19206-8-hch@lst.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170616181059.19206-1-hch@lst.de>
References: <20170616181059.19206-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+48ca1ab4adaecdf09dc3+5045+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58538
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

ARM and x86 had duplicated versions of the dma_ops structure, the
only difference is that x86 hasn't wired up the set_dma_mask,
mmap, and get_sgtable ops yet.  On x86 all of them are identical
to the generic version, so they aren't needed but harmless.

All the symbols used only for xen_swiotlb_dma_ops can now be marked
static as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 arch/arm/xen/mm.c              | 17 --------
 arch/x86/xen/pci-swiotlb-xen.c | 14 -------
 drivers/xen/swiotlb-xen.c      | 93 ++++++++++++++++++++++--------------------
 include/xen/swiotlb-xen.h      | 62 +---------------------------
 4 files changed, 49 insertions(+), 137 deletions(-)

diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
index f0325d96b97a..785d2a562a23 100644
--- a/arch/arm/xen/mm.c
+++ b/arch/arm/xen/mm.c
@@ -185,23 +185,6 @@ EXPORT_SYMBOL_GPL(xen_destroy_contiguous_region);
 const struct dma_map_ops *xen_dma_ops;
 EXPORT_SYMBOL(xen_dma_ops);
 
-static const struct dma_map_ops xen_swiotlb_dma_ops = {
-	.alloc = xen_swiotlb_alloc_coherent,
-	.free = xen_swiotlb_free_coherent,
-	.sync_single_for_cpu = xen_swiotlb_sync_single_for_cpu,
-	.sync_single_for_device = xen_swiotlb_sync_single_for_device,
-	.sync_sg_for_cpu = xen_swiotlb_sync_sg_for_cpu,
-	.sync_sg_for_device = xen_swiotlb_sync_sg_for_device,
-	.map_sg = xen_swiotlb_map_sg_attrs,
-	.unmap_sg = xen_swiotlb_unmap_sg_attrs,
-	.map_page = xen_swiotlb_map_page,
-	.unmap_page = xen_swiotlb_unmap_page,
-	.dma_supported = xen_swiotlb_dma_supported,
-	.set_dma_mask = xen_swiotlb_set_dma_mask,
-	.mmap = xen_swiotlb_dma_mmap,
-	.get_sgtable = xen_swiotlb_get_sgtable,
-};
-
 int __init xen_mm_init(void)
 {
 	struct gnttab_cache_flush cflush;
diff --git a/arch/x86/xen/pci-swiotlb-xen.c b/arch/x86/xen/pci-swiotlb-xen.c
index 42b08f8fc2ca..37c6056a7bba 100644
--- a/arch/x86/xen/pci-swiotlb-xen.c
+++ b/arch/x86/xen/pci-swiotlb-xen.c
@@ -18,20 +18,6 @@
 
 int xen_swiotlb __read_mostly;
 
-static const struct dma_map_ops xen_swiotlb_dma_ops = {
-	.alloc = xen_swiotlb_alloc_coherent,
-	.free = xen_swiotlb_free_coherent,
-	.sync_single_for_cpu = xen_swiotlb_sync_single_for_cpu,
-	.sync_single_for_device = xen_swiotlb_sync_single_for_device,
-	.sync_sg_for_cpu = xen_swiotlb_sync_sg_for_cpu,
-	.sync_sg_for_device = xen_swiotlb_sync_sg_for_device,
-	.map_sg = xen_swiotlb_map_sg_attrs,
-	.unmap_sg = xen_swiotlb_unmap_sg_attrs,
-	.map_page = xen_swiotlb_map_page,
-	.unmap_page = xen_swiotlb_unmap_page,
-	.dma_supported = xen_swiotlb_dma_supported,
-};
-
 /*
  * pci_xen_swiotlb_detect - set xen_swiotlb to 1 if necessary
  *
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 8dab0d3dc172..a0f006daab48 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -295,7 +295,8 @@ int __ref xen_swiotlb_init(int verbose, bool early)
 		free_pages((unsigned long)xen_io_tlb_start, order);
 	return rc;
 }
-void *
+
+static void *
 xen_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 			   dma_addr_t *dma_handle, gfp_t flags,
 			   unsigned long attrs)
@@ -346,9 +347,8 @@ xen_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 	memset(ret, 0, size);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(xen_swiotlb_alloc_coherent);
 
-void
+static void
 xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
 			  dma_addr_t dev_addr, unsigned long attrs)
 {
@@ -369,8 +369,6 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
 
 	xen_free_coherent_pages(hwdev, size, vaddr, (dma_addr_t)phys, attrs);
 }
-EXPORT_SYMBOL_GPL(xen_swiotlb_free_coherent);
-
 
 /*
  * Map a single buffer of the indicated size for DMA in streaming mode.  The
@@ -379,7 +377,7 @@ EXPORT_SYMBOL_GPL(xen_swiotlb_free_coherent);
  * Once the device is given the dma address, the device owns this memory until
  * either xen_swiotlb_unmap_page or xen_swiotlb_dma_sync_single is performed.
  */
-dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
+static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 				unsigned long offset, size_t size,
 				enum dma_data_direction dir,
 				unsigned long attrs)
@@ -429,7 +427,6 @@ dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 
 	return DMA_ERROR_CODE;
 }
-EXPORT_SYMBOL_GPL(xen_swiotlb_map_page);
 
 /*
  * Unmap a single streaming mode DMA translation.  The dma_addr and size must
@@ -467,13 +464,12 @@ static void xen_unmap_single(struct device *hwdev, dma_addr_t dev_addr,
 	dma_mark_clean(phys_to_virt(paddr), size);
 }
 
-void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
+static void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
 			    size_t size, enum dma_data_direction dir,
 			    unsigned long attrs)
 {
 	xen_unmap_single(hwdev, dev_addr, size, dir, attrs);
 }
-EXPORT_SYMBOL_GPL(xen_swiotlb_unmap_page);
 
 /*
  * Make physical memory consistent for a single streaming mode DMA translation
@@ -516,7 +512,6 @@ xen_swiotlb_sync_single_for_cpu(struct device *hwdev, dma_addr_t dev_addr,
 {
 	xen_swiotlb_sync_single(hwdev, dev_addr, size, dir, SYNC_FOR_CPU);
 }
-EXPORT_SYMBOL_GPL(xen_swiotlb_sync_single_for_cpu);
 
 void
 xen_swiotlb_sync_single_for_device(struct device *hwdev, dma_addr_t dev_addr,
@@ -524,7 +519,25 @@ xen_swiotlb_sync_single_for_device(struct device *hwdev, dma_addr_t dev_addr,
 {
 	xen_swiotlb_sync_single(hwdev, dev_addr, size, dir, SYNC_FOR_DEVICE);
 }
-EXPORT_SYMBOL_GPL(xen_swiotlb_sync_single_for_device);
+
+/*
+ * Unmap a set of streaming mode DMA translations.  Again, cpu read rules
+ * concerning calls here are the same as for swiotlb_unmap_page() above.
+ */
+static void
+xen_swiotlb_unmap_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
+			   int nelems, enum dma_data_direction dir,
+			   unsigned long attrs)
+{
+	struct scatterlist *sg;
+	int i;
+
+	BUG_ON(dir == DMA_NONE);
+
+	for_each_sg(sgl, sg, nelems, i)
+		xen_unmap_single(hwdev, sg->dma_address, sg_dma_len(sg), dir, attrs);
+
+}
 
 /*
  * Map a set of buffers described by scatterlist in streaming mode for DMA.
@@ -542,7 +555,7 @@ EXPORT_SYMBOL_GPL(xen_swiotlb_sync_single_for_device);
  * Device ownership issues as mentioned above for xen_swiotlb_map_page are the
  * same here.
  */
-int
+static int
 xen_swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
 			 int nelems, enum dma_data_direction dir,
 			 unsigned long attrs)
@@ -599,27 +612,6 @@ xen_swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
 	}
 	return nelems;
 }
-EXPORT_SYMBOL_GPL(xen_swiotlb_map_sg_attrs);
-
-/*
- * Unmap a set of streaming mode DMA translations.  Again, cpu read rules
- * concerning calls here are the same as for swiotlb_unmap_page() above.
- */
-void
-xen_swiotlb_unmap_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
-			   int nelems, enum dma_data_direction dir,
-			   unsigned long attrs)
-{
-	struct scatterlist *sg;
-	int i;
-
-	BUG_ON(dir == DMA_NONE);
-
-	for_each_sg(sgl, sg, nelems, i)
-		xen_unmap_single(hwdev, sg->dma_address, sg_dma_len(sg), dir, attrs);
-
-}
-EXPORT_SYMBOL_GPL(xen_swiotlb_unmap_sg_attrs);
 
 /*
  * Make physical memory consistent for a set of streaming mode DMA translations
@@ -641,21 +633,19 @@ xen_swiotlb_sync_sg(struct device *hwdev, struct scatterlist *sgl,
 					sg_dma_len(sg), dir, target);
 }
 
-void
+static void
 xen_swiotlb_sync_sg_for_cpu(struct device *hwdev, struct scatterlist *sg,
 			    int nelems, enum dma_data_direction dir)
 {
 	xen_swiotlb_sync_sg(hwdev, sg, nelems, dir, SYNC_FOR_CPU);
 }
-EXPORT_SYMBOL_GPL(xen_swiotlb_sync_sg_for_cpu);
 
-void
+static void
 xen_swiotlb_sync_sg_for_device(struct device *hwdev, struct scatterlist *sg,
 			       int nelems, enum dma_data_direction dir)
 {
 	xen_swiotlb_sync_sg(hwdev, sg, nelems, dir, SYNC_FOR_DEVICE);
 }
-EXPORT_SYMBOL_GPL(xen_swiotlb_sync_sg_for_device);
 
 /*
  * Return whether the given device DMA address mask can be supported
@@ -663,14 +653,13 @@ EXPORT_SYMBOL_GPL(xen_swiotlb_sync_sg_for_device);
  * during bus mastering, then you would pass 0x00ffffff as the mask to
  * this function.
  */
-int
+static int
 xen_swiotlb_dma_supported(struct device *hwdev, u64 mask)
 {
 	return xen_virt_to_bus(xen_io_tlb_end - 1) <= mask;
 }
-EXPORT_SYMBOL_GPL(xen_swiotlb_dma_supported);
 
-int
+static int
 xen_swiotlb_set_dma_mask(struct device *dev, u64 dma_mask)
 {
 	if (!dev->dma_mask || !xen_swiotlb_dma_supported(dev, dma_mask))
@@ -680,14 +669,13 @@ xen_swiotlb_set_dma_mask(struct device *dev, u64 dma_mask)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(xen_swiotlb_set_dma_mask);
 
 /*
  * Create userspace mapping for the DMA-coherent memory.
  * This function should be called with the pages from the current domain only,
  * passing pages mapped from other domains would lead to memory corruption.
  */
-int
+static int
 xen_swiotlb_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 		     void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		     unsigned long attrs)
@@ -699,13 +687,12 @@ xen_swiotlb_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 #endif
 	return dma_common_mmap(dev, vma, cpu_addr, dma_addr, size);
 }
-EXPORT_SYMBOL_GPL(xen_swiotlb_dma_mmap);
 
 /*
  * This function should be called with the pages from the current domain only,
  * passing pages mapped from other domains would lead to memory corruption.
  */
-int
+static int
 xen_swiotlb_get_sgtable(struct device *dev, struct sg_table *sgt,
 			void *cpu_addr, dma_addr_t handle, size_t size,
 			unsigned long attrs)
@@ -727,4 +714,20 @@ xen_swiotlb_get_sgtable(struct device *dev, struct sg_table *sgt,
 #endif
 	return dma_common_get_sgtable(dev, sgt, cpu_addr, handle, size);
 }
-EXPORT_SYMBOL_GPL(xen_swiotlb_get_sgtable);
+
+const struct dma_map_ops xen_swiotlb_dma_ops = {
+	.alloc = xen_swiotlb_alloc_coherent,
+	.free = xen_swiotlb_free_coherent,
+	.sync_single_for_cpu = xen_swiotlb_sync_single_for_cpu,
+	.sync_single_for_device = xen_swiotlb_sync_single_for_device,
+	.sync_sg_for_cpu = xen_swiotlb_sync_sg_for_cpu,
+	.sync_sg_for_device = xen_swiotlb_sync_sg_for_device,
+	.map_sg = xen_swiotlb_map_sg_attrs,
+	.unmap_sg = xen_swiotlb_unmap_sg_attrs,
+	.map_page = xen_swiotlb_map_page,
+	.unmap_page = xen_swiotlb_unmap_page,
+	.dma_supported = xen_swiotlb_dma_supported,
+	.set_dma_mask = xen_swiotlb_set_dma_mask,
+	.mmap = xen_swiotlb_dma_mmap,
+	.get_sgtable = xen_swiotlb_get_sgtable,
+};
diff --git a/include/xen/swiotlb-xen.h b/include/xen/swiotlb-xen.h
index 1f6d78f044b6..ed2de363da33 100644
--- a/include/xen/swiotlb-xen.h
+++ b/include/xen/swiotlb-xen.h
@@ -1,69 +1,9 @@
 #ifndef __LINUX_SWIOTLB_XEN_H
 #define __LINUX_SWIOTLB_XEN_H
 
-#include <linux/dma-direction.h>
-#include <linux/scatterlist.h>
 #include <linux/swiotlb.h>
 
 extern int xen_swiotlb_init(int verbose, bool early);
+extern const struct dma_map_ops xen_swiotlb_dma_ops;
 
-extern void
-*xen_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
-			    dma_addr_t *dma_handle, gfp_t flags,
-			    unsigned long attrs);
-
-extern void
-xen_swiotlb_free_coherent(struct device *hwdev, size_t size,
-			  void *vaddr, dma_addr_t dma_handle,
-			  unsigned long attrs);
-
-extern dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
-				       unsigned long offset, size_t size,
-				       enum dma_data_direction dir,
-				       unsigned long attrs);
-
-extern void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
-				   size_t size, enum dma_data_direction dir,
-				   unsigned long attrs);
-extern int
-xen_swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
-			 int nelems, enum dma_data_direction dir,
-			 unsigned long attrs);
-
-extern void
-xen_swiotlb_unmap_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
-			   int nelems, enum dma_data_direction dir,
-			   unsigned long attrs);
-
-extern void
-xen_swiotlb_sync_single_for_cpu(struct device *hwdev, dma_addr_t dev_addr,
-				size_t size, enum dma_data_direction dir);
-
-extern void
-xen_swiotlb_sync_sg_for_cpu(struct device *hwdev, struct scatterlist *sg,
-			    int nelems, enum dma_data_direction dir);
-
-extern void
-xen_swiotlb_sync_single_for_device(struct device *hwdev, dma_addr_t dev_addr,
-				   size_t size, enum dma_data_direction dir);
-
-extern void
-xen_swiotlb_sync_sg_for_device(struct device *hwdev, struct scatterlist *sg,
-			       int nelems, enum dma_data_direction dir);
-
-extern int
-xen_swiotlb_dma_supported(struct device *hwdev, u64 mask);
-
-extern int
-xen_swiotlb_set_dma_mask(struct device *dev, u64 dma_mask);
-
-extern int
-xen_swiotlb_dma_mmap(struct device *dev, struct vm_area_struct *vma,
-		     void *cpu_addr, dma_addr_t dma_addr, size_t size,
-		     unsigned long attrs);
-
-extern int
-xen_swiotlb_get_sgtable(struct device *dev, struct sg_table *sgt,
-			void *cpu_addr, dma_addr_t handle, size_t size,
-			unsigned long attrs);
 #endif /* __LINUX_SWIOTLB_XEN_H */
-- 
2.11.0
