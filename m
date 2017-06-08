Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2017 15:37:54 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:56124 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993969AbdFHN1pC0DnT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Jun 2017 15:27:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Q9IhTyIgD+R8nTGio5sKTXkWi2KGmzc3tuI113YnP/M=; b=j9sIXMoxivfu8UJkS9HYpuncP
        doht+9BAVHsLw9qBFDAmMidw4gseBuIaGFo4wqRGtRg79m0APqFXA2o+z5xBAhxCSjLKCEU65ZtFv
        c+dIhHOHstN+07A4T2OkGXUOo5yV33B8RjL9FmgfG1TBbZm8eYYyWdhDNCOIB23E1jC9esffJE213
        bWIqD7hiGuhnTscZVPbxAl37TbNynp596jPolcGLfIySO3Cbwc0Uu7vHqvnnNFHajDbqJJOoaIeNu
        mez1FwjvRHwemeYKFqrndWXMgXnn5A7+snSlN20n4QLlmkBSEkVNGmWRql/ztqJg3FAS8NFGb3Qwx
        JqRk824Ow==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dIxTP-0006cD-8V; Thu, 08 Jun 2017 13:27:39 +0000
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
Subject: [PATCH 21/44] powerpc: implement ->mapping_error
Date:   Thu,  8 Jun 2017 15:25:46 +0200
Message-Id: <20170608132609.32662-22-hch@lst.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170608132609.32662-1-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+eb06f239ea6f59aeb59b+5037+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58331
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

DMA_ERROR_CODE is going to go away, so don't rely on it.  Instead
define a ->mapping_error method for all IOMMU based dma operation
instances.  The direct ops don't ever return an error and don't
need a ->mapping_error method.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/include/asm/dma-mapping.h |  4 ----
 arch/powerpc/include/asm/iommu.h       |  4 ++++
 arch/powerpc/kernel/dma-iommu.c        |  6 ++++++
 arch/powerpc/kernel/iommu.c            | 28 ++++++++++++++--------------
 arch/powerpc/platforms/cell/iommu.c    |  1 +
 arch/powerpc/platforms/pseries/vio.c   |  3 ++-
 6 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index 181a095468e4..73aedbe6c977 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -17,10 +17,6 @@
 #include <asm/io.h>
 #include <asm/swiotlb.h>
 
-#ifdef CONFIG_PPC64
-#define DMA_ERROR_CODE		(~(dma_addr_t)0x0)
-#endif
-
 /* Some dma direct funcs must be visible for use in other dma_ops */
 extern void *__dma_direct_alloc_coherent(struct device *dev, size_t size,
 					 dma_addr_t *dma_handle, gfp_t flag,
diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 8a8ce220d7d0..20febe0b7f32 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -139,6 +139,8 @@ struct scatterlist;
 
 #ifdef CONFIG_PPC64
 
+#define IOMMU_MAPPING_ERROR		(~(dma_addr_t)0x0)
+
 static inline void set_iommu_table_base(struct device *dev,
 					struct iommu_table *base)
 {
@@ -238,6 +240,8 @@ static inline int __init tce_iommu_bus_notifier_init(void)
 }
 #endif /* !CONFIG_IOMMU_API */
 
+int dma_iommu_mapping_error(struct device *dev, dma_addr_t dma_addr);
+
 #else
 
 static inline void *get_iommu_table_base(struct device *dev)
diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index fb7cbaa37658..8f7abf9baa63 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -105,6 +105,11 @@ static u64 dma_iommu_get_required_mask(struct device *dev)
 	return mask;
 }
 
+int dma_iommu_mapping_error(struct device *dev, dma_addr_t dma_addr)
+{
+	return dma_addr == IOMMU_MAPPING_ERROR;
+}
+
 struct dma_map_ops dma_iommu_ops = {
 	.alloc			= dma_iommu_alloc_coherent,
 	.free			= dma_iommu_free_coherent,
@@ -115,5 +120,6 @@ struct dma_map_ops dma_iommu_ops = {
 	.map_page		= dma_iommu_map_page,
 	.unmap_page		= dma_iommu_unmap_page,
 	.get_required_mask	= dma_iommu_get_required_mask,
+	.mapping_error		= dma_iommu_mapping_error,
 };
 EXPORT_SYMBOL(dma_iommu_ops);
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index f2b724cd9e64..233ca3fe4754 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -198,11 +198,11 @@ static unsigned long iommu_range_alloc(struct device *dev,
 	if (unlikely(npages == 0)) {
 		if (printk_ratelimit())
 			WARN_ON(1);
-		return DMA_ERROR_CODE;
+		return IOMMU_MAPPING_ERROR;
 	}
 
 	if (should_fail_iommu(dev))
-		return DMA_ERROR_CODE;
+		return IOMMU_MAPPING_ERROR;
 
 	/*
 	 * We don't need to disable preemption here because any CPU can
@@ -278,7 +278,7 @@ static unsigned long iommu_range_alloc(struct device *dev,
 		} else {
 			/* Give up */
 			spin_unlock_irqrestore(&(pool->lock), flags);
-			return DMA_ERROR_CODE;
+			return IOMMU_MAPPING_ERROR;
 		}
 	}
 
@@ -310,13 +310,13 @@ static dma_addr_t iommu_alloc(struct device *dev, struct iommu_table *tbl,
 			      unsigned long attrs)
 {
 	unsigned long entry;
-	dma_addr_t ret = DMA_ERROR_CODE;
+	dma_addr_t ret = IOMMU_MAPPING_ERROR;
 	int build_fail;
 
 	entry = iommu_range_alloc(dev, tbl, npages, NULL, mask, align_order);
 
-	if (unlikely(entry == DMA_ERROR_CODE))
-		return DMA_ERROR_CODE;
+	if (unlikely(entry == IOMMU_MAPPING_ERROR))
+		return IOMMU_MAPPING_ERROR;
 
 	entry += tbl->it_offset;	/* Offset into real TCE table */
 	ret = entry << tbl->it_page_shift;	/* Set the return dma address */
@@ -328,12 +328,12 @@ static dma_addr_t iommu_alloc(struct device *dev, struct iommu_table *tbl,
 
 	/* tbl->it_ops->set() only returns non-zero for transient errors.
 	 * Clean up the table bitmap in this case and return
-	 * DMA_ERROR_CODE. For all other errors the functionality is
+	 * IOMMU_MAPPING_ERROR. For all other errors the functionality is
 	 * not altered.
 	 */
 	if (unlikely(build_fail)) {
 		__iommu_free(tbl, ret, npages);
-		return DMA_ERROR_CODE;
+		return IOMMU_MAPPING_ERROR;
 	}
 
 	/* Flush/invalidate TLB caches if necessary */
@@ -478,7 +478,7 @@ int ppc_iommu_map_sg(struct device *dev, struct iommu_table *tbl,
 		DBG("  - vaddr: %lx, size: %lx\n", vaddr, slen);
 
 		/* Handle failure */
-		if (unlikely(entry == DMA_ERROR_CODE)) {
+		if (unlikely(entry == IOMMU_MAPPING_ERROR)) {
 			if (!(attrs & DMA_ATTR_NO_WARN) &&
 			    printk_ratelimit())
 				dev_info(dev, "iommu_alloc failed, tbl %p "
@@ -545,7 +545,7 @@ int ppc_iommu_map_sg(struct device *dev, struct iommu_table *tbl,
 	 */
 	if (outcount < incount) {
 		outs = sg_next(outs);
-		outs->dma_address = DMA_ERROR_CODE;
+		outs->dma_address = IOMMU_MAPPING_ERROR;
 		outs->dma_length = 0;
 	}
 
@@ -563,7 +563,7 @@ int ppc_iommu_map_sg(struct device *dev, struct iommu_table *tbl,
 			npages = iommu_num_pages(s->dma_address, s->dma_length,
 						 IOMMU_PAGE_SIZE(tbl));
 			__iommu_free(tbl, vaddr, npages);
-			s->dma_address = DMA_ERROR_CODE;
+			s->dma_address = IOMMU_MAPPING_ERROR;
 			s->dma_length = 0;
 		}
 		if (s == outs)
@@ -777,7 +777,7 @@ dma_addr_t iommu_map_page(struct device *dev, struct iommu_table *tbl,
 			  unsigned long mask, enum dma_data_direction direction,
 			  unsigned long attrs)
 {
-	dma_addr_t dma_handle = DMA_ERROR_CODE;
+	dma_addr_t dma_handle = IOMMU_MAPPING_ERROR;
 	void *vaddr;
 	unsigned long uaddr;
 	unsigned int npages, align;
@@ -797,7 +797,7 @@ dma_addr_t iommu_map_page(struct device *dev, struct iommu_table *tbl,
 		dma_handle = iommu_alloc(dev, tbl, vaddr, npages, direction,
 					 mask >> tbl->it_page_shift, align,
 					 attrs);
-		if (dma_handle == DMA_ERROR_CODE) {
+		if (dma_handle == IOMMU_MAPPING_ERROR) {
 			if (!(attrs & DMA_ATTR_NO_WARN) &&
 			    printk_ratelimit())  {
 				dev_info(dev, "iommu_alloc failed, tbl %p "
@@ -869,7 +869,7 @@ void *iommu_alloc_coherent(struct device *dev, struct iommu_table *tbl,
 	io_order = get_iommu_order(size, tbl);
 	mapping = iommu_alloc(dev, tbl, ret, nio_pages, DMA_BIDIRECTIONAL,
 			      mask >> tbl->it_page_shift, io_order, 0);
-	if (mapping == DMA_ERROR_CODE) {
+	if (mapping == IOMMU_MAPPING_ERROR) {
 		free_pages((unsigned long)ret, order);
 		return NULL;
 	}
diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 71b995bbcae0..948086e33a0c 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -660,6 +660,7 @@ static const struct dma_map_ops dma_iommu_fixed_ops = {
 	.set_dma_mask   = dma_set_mask_and_switch,
 	.map_page       = dma_fixed_map_page,
 	.unmap_page     = dma_fixed_unmap_page,
+	.mapping_error	= dma_iommu_mapping_error,
 };
 
 static void cell_dma_dev_setup_fixed(struct device *dev);
diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
index 28b09fd797ec..e6f43d546827 100644
--- a/arch/powerpc/platforms/pseries/vio.c
+++ b/arch/powerpc/platforms/pseries/vio.c
@@ -519,7 +519,7 @@ static dma_addr_t vio_dma_iommu_map_page(struct device *dev, struct page *page,
 {
 	struct vio_dev *viodev = to_vio_dev(dev);
 	struct iommu_table *tbl;
-	dma_addr_t ret = DMA_ERROR_CODE;
+	dma_addr_t ret = IOMMU_MAPPING_ERROR;
 
 	tbl = get_iommu_table_base(dev);
 	if (vio_cmo_alloc(viodev, roundup(size, IOMMU_PAGE_SIZE(tbl)))) {
@@ -625,6 +625,7 @@ static const struct dma_map_ops vio_dma_mapping_ops = {
 	.unmap_page        = vio_dma_iommu_unmap_page,
 	.dma_supported     = vio_dma_iommu_dma_supported,
 	.get_required_mask = vio_dma_get_required_mask,
+	.mapping_error	   = dma_iommu_mapping_error,
 };
 
 /**
-- 
2.11.0
