Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Oct 2017 12:48:06 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:34664 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993195AbdJCKn6HTV11 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Oct 2017 12:43:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZxiSfZhyW4Y/kNCMpxBgrB07MKcZu+QDmer1UM3mYo0=; b=iTYa4fAu6xIFOn99Nz9SvSojo
        VmQI7/nykrV++CKuv8E4iHpFayTPfqrG13CyUGG1ajiY8PgaMlKxLCuTg7h+33gzOR88CWVch16nY
        TMwzUT8PsRFnujgTXE9CIH9LU+oJ9qeDcbBF/3KvU6JI3BJniFS3K/IDNhIPgvNeYqCq46drd4DPE
        Ny9VH3xGLOY8tQgudfwNAIQkUbV9iByphpl3cWhwb/UwtToLPuPgj80+fTP8729HoAaHq3Be/0aLr
        oHPGtbr8B9FWuthzvUhAT6m3JryRTLXbN/4QDC4ym0lVBXfPm70sR5xjakJHeebsGPdPXM4GyzRoF
        9TRX0esKQ==;
Received: from 80-109-164-210.cable.dynamic.surfer.at ([80.109.164.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dzKg2-0000V9-Nd; Tue, 03 Oct 2017 10:43:51 +0000
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
Subject: [PATCH 11/11] dma-mapping: turn dma_cache_sync into a dma_map_ops method
Date:   Tue,  3 Oct 2017 12:43:11 +0200
Message-Id: <20171003104311.10058-12-hch@lst.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20171003104311.10058-1-hch@lst.de>
References: <20171003104311.10058-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+69bb01a06caa5cf26dd3+5154+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60232
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

After we removed all the dead wood it turns out only two architectures
actually implement dma_cache_sync as a real op: mips and parisc.  Add
a cache_sync method to struct dma_map_ops and implement it for the
mips defualt DMA ops, and the parisc pa11 ops.

Note that arm, arc and openrisc support DMA_ATTR_NON_CONSISTENT, but
never provided a functional dma_cache_sync implementations, which
seems somewhat odd.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/alpha/include/asm/dma-mapping.h      |  2 --
 arch/cris/include/asm/dma-mapping.h       |  6 ------
 arch/frv/include/asm/dma-mapping.h        |  6 ------
 arch/hexagon/include/asm/dma-mapping.h    |  3 ---
 arch/ia64/include/asm/dma-mapping.h       |  6 ------
 arch/m32r/include/asm/dma-mapping.h       |  5 -----
 arch/m68k/include/asm/dma-mapping.h       |  6 ------
 arch/metag/include/asm/dma-mapping.h      | 10 ----------
 arch/microblaze/include/asm/dma-mapping.h |  5 -----
 arch/mips/include/asm/dma-mapping.h       |  3 ---
 arch/mips/mm/dma-default.c                |  7 +++----
 arch/mn10300/include/asm/dma-mapping.h    |  6 ------
 arch/nios2/include/asm/dma-mapping.h      |  9 ---------
 arch/parisc/include/asm/dma-mapping.h     |  8 --------
 arch/parisc/kernel/pci-dma.c              |  8 ++++++++
 arch/powerpc/include/asm/dma-mapping.h    |  5 -----
 arch/s390/include/asm/dma-mapping.h       |  5 -----
 arch/sh/include/asm/dma-mapping.h         |  6 ------
 arch/sparc/include/asm/dma-mapping.h      |  8 --------
 arch/tile/include/asm/dma-mapping.h       |  9 ---------
 arch/unicore32/include/asm/dma-mapping.h  |  5 -----
 arch/x86/include/asm/dma-mapping.h        |  6 ------
 arch/xtensa/include/asm/dma-mapping.h     |  5 -----
 include/linux/dma-mapping.h               | 13 +++++++++++++
 24 files changed, 24 insertions(+), 128 deletions(-)

diff --git a/arch/alpha/include/asm/dma-mapping.h b/arch/alpha/include/asm/dma-mapping.h
index 5d53666935e6..399a4f49355e 100644
--- a/arch/alpha/include/asm/dma-mapping.h
+++ b/arch/alpha/include/asm/dma-mapping.h
@@ -8,6 +8,4 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return dma_ops;
 }
 
-#define dma_cache_sync(dev, va, size, dir)		  ((void)0)
-
 #endif	/* _ALPHA_DMA_MAPPING_H */
diff --git a/arch/cris/include/asm/dma-mapping.h b/arch/cris/include/asm/dma-mapping.h
index 256169de3743..e30adde42beb 100644
--- a/arch/cris/include/asm/dma-mapping.h
+++ b/arch/cris/include/asm/dma-mapping.h
@@ -16,10 +16,4 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 }
 #endif
 
-static inline void
-dma_cache_sync(struct device *dev, void *vaddr, size_t size,
-	       enum dma_data_direction direction)
-{
-}
-
 #endif
diff --git a/arch/frv/include/asm/dma-mapping.h b/arch/frv/include/asm/dma-mapping.h
index da0e5c9744c4..da24ae943f02 100644
--- a/arch/frv/include/asm/dma-mapping.h
+++ b/arch/frv/include/asm/dma-mapping.h
@@ -14,10 +14,4 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return &frv_dma_ops;
 }
 
-static inline
-void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
-		    enum dma_data_direction direction)
-{
-}
-
 #endif  /* _ASM_DMA_MAPPING_H */
diff --git a/arch/hexagon/include/asm/dma-mapping.h b/arch/hexagon/include/asm/dma-mapping.h
index 463dbc18f853..5208de242e79 100644
--- a/arch/hexagon/include/asm/dma-mapping.h
+++ b/arch/hexagon/include/asm/dma-mapping.h
@@ -37,9 +37,6 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return dma_ops;
 }
 
-extern void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
-			   enum dma_data_direction direction);
-
 static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 {
 	if (!dev->dma_mask)
diff --git a/arch/ia64/include/asm/dma-mapping.h b/arch/ia64/include/asm/dma-mapping.h
index 99dfc1aa9d3c..9e5b5df76ff8 100644
--- a/arch/ia64/include/asm/dma-mapping.h
+++ b/arch/ia64/include/asm/dma-mapping.h
@@ -44,10 +44,4 @@ static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
 	return daddr;
 }
 
-static inline void
-dma_cache_sync (struct device *dev, void *vaddr, size_t size,
-	enum dma_data_direction dir)
-{
-}
-
 #endif /* _ASM_IA64_DMA_MAPPING_H */
diff --git a/arch/m32r/include/asm/dma-mapping.h b/arch/m32r/include/asm/dma-mapping.h
index aff3ae8b62f7..9e993daed7a0 100644
--- a/arch/m32r/include/asm/dma-mapping.h
+++ b/arch/m32r/include/asm/dma-mapping.h
@@ -13,11 +13,6 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return &dma_noop_ops;
 }
 
-static inline void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
-				  enum dma_data_direction direction)
-{
-}
-
 static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 {
 	if (!dev->dma_mask)
diff --git a/arch/m68k/include/asm/dma-mapping.h b/arch/m68k/include/asm/dma-mapping.h
index 9210e470771b..9a0d559fcc13 100644
--- a/arch/m68k/include/asm/dma-mapping.h
+++ b/arch/m68k/include/asm/dma-mapping.h
@@ -8,10 +8,4 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
         return &m68k_dma_ops;
 }
 
-static inline void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
-				  enum dma_data_direction dir)
-{
-	/* we use coherent allocation, so not much to do here. */
-}
-
 #endif  /* _M68K_DMA_MAPPING_H */
diff --git a/arch/metag/include/asm/dma-mapping.h b/arch/metag/include/asm/dma-mapping.h
index ea573be2b6d0..340265dcf839 100644
--- a/arch/metag/include/asm/dma-mapping.h
+++ b/arch/metag/include/asm/dma-mapping.h
@@ -8,14 +8,4 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return &metag_dma_ops;
 }
 
-/*
- * dma_alloc_attrs() always returns non-cacheable memory, so there's no need to
- * do any flushing here.
- */
-static inline void
-dma_cache_sync(struct device *dev, void *vaddr, size_t size,
-	       enum dma_data_direction direction)
-{
-}
-
 #endif
diff --git a/arch/microblaze/include/asm/dma-mapping.h b/arch/microblaze/include/asm/dma-mapping.h
index ad448e4aedb6..6b9ea39405b8 100644
--- a/arch/microblaze/include/asm/dma-mapping.h
+++ b/arch/microblaze/include/asm/dma-mapping.h
@@ -25,9 +25,4 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return &dma_direct_ops;
 }
 
-static inline void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
-		enum dma_data_direction direction)
-{
-}
-
 #endif	/* _ASM_MICROBLAZE_DMA_MAPPING_H */
diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
index aba71385f9d1..6ea1439430a2 100644
--- a/arch/mips/include/asm/dma-mapping.h
+++ b/arch/mips/include/asm/dma-mapping.h
@@ -26,9 +26,6 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 
 static inline void dma_mark_clean(void *addr, size_t size) {}
 
-extern void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
-	       enum dma_data_direction direction);
-
 #define arch_setup_dma_ops arch_setup_dma_ops
 static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base,
 				      u64 size, const struct iommu_ops *iommu,
diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index c01bd20d0208..2e2514e00720 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -383,7 +383,7 @@ static int mips_dma_supported(struct device *dev, u64 mask)
 	return plat_dma_supported(dev, mask);
 }
 
-void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
+static void mips_dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 			 enum dma_data_direction direction)
 {
 	BUG_ON(direction == DMA_NONE);
@@ -392,8 +392,6 @@ void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 		__dma_sync_virtual(vaddr, size, direction);
 }
 
-EXPORT_SYMBOL(dma_cache_sync);
-
 static const struct dma_map_ops mips_default_dma_map_ops = {
 	.alloc = mips_dma_alloc_coherent,
 	.free = mips_dma_free_coherent,
@@ -407,7 +405,8 @@ static const struct dma_map_ops mips_default_dma_map_ops = {
 	.sync_sg_for_cpu = mips_dma_sync_sg_for_cpu,
 	.sync_sg_for_device = mips_dma_sync_sg_for_device,
 	.mapping_error = mips_dma_mapping_error,
-	.dma_supported = mips_dma_supported
+	.dma_supported = mips_dma_supported,
+	.cache_sync = mips_dma_cache_sync,
 };
 
 const struct dma_map_ops *mips_dma_map_ops = &mips_default_dma_map_ops;
diff --git a/arch/mn10300/include/asm/dma-mapping.h b/arch/mn10300/include/asm/dma-mapping.h
index dc24163b190f..439e474ed6d7 100644
--- a/arch/mn10300/include/asm/dma-mapping.h
+++ b/arch/mn10300/include/asm/dma-mapping.h
@@ -18,10 +18,4 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return &mn10300_dma_ops;
 }
 
-static inline
-void dma_cache_sync(void *vaddr, size_t size,
-		    enum dma_data_direction direction)
-{
-}
-
 #endif
diff --git a/arch/nios2/include/asm/dma-mapping.h b/arch/nios2/include/asm/dma-mapping.h
index f8dc62222741..6ceb92251da0 100644
--- a/arch/nios2/include/asm/dma-mapping.h
+++ b/arch/nios2/include/asm/dma-mapping.h
@@ -17,13 +17,4 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return &nios2_dma_ops;
 }
 
-/*
- * dma_alloc_attrs() always returns non-cacheable memory, so there's no need to
- * do any flushing here.
- */
-static inline void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
-				  enum dma_data_direction direction)
-{
-}
-
 #endif /* _ASM_NIOS2_DMA_MAPPING_H */
diff --git a/arch/parisc/include/asm/dma-mapping.h b/arch/parisc/include/asm/dma-mapping.h
index 2b16282add69..cb26bbd71d8a 100644
--- a/arch/parisc/include/asm/dma-mapping.h
+++ b/arch/parisc/include/asm/dma-mapping.h
@@ -32,14 +32,6 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return hppa_dma_ops;
 }
 
-static inline void
-dma_cache_sync(struct device *dev, void *vaddr, size_t size,
-	       enum dma_data_direction direction)
-{
-	if (hppa_dma_ops->sync_single_for_cpu)
-		flush_kernel_dcache_range((unsigned long)vaddr, size);
-}
-
 static inline void *
 parisc_walk_tree(struct device *dev)
 {
diff --git a/arch/parisc/kernel/pci-dma.c b/arch/parisc/kernel/pci-dma.c
index bd4c0a7471d3..f87c34cb3b43 100644
--- a/arch/parisc/kernel/pci-dma.c
+++ b/arch/parisc/kernel/pci-dma.c
@@ -571,6 +571,12 @@ static void pa11_dma_sync_sg_for_device(struct device *dev, struct scatterlist *
 		flush_kernel_vmap_range(sg_virt(sg), sg->length);
 }
 
+static void pa11_dma_cache_sync(struct device *dev, void *vaddr, size_t size,
+	       enum dma_data_direction direction)
+{
+	flush_kernel_dcache_range((unsigned long)vaddr, size);
+}
+
 const struct dma_map_ops pcxl_dma_ops = {
 	.dma_supported =	pa11_dma_supported,
 	.alloc =		pa11_dma_alloc,
@@ -583,6 +589,7 @@ const struct dma_map_ops pcxl_dma_ops = {
 	.sync_single_for_device = pa11_dma_sync_single_for_device,
 	.sync_sg_for_cpu =	pa11_dma_sync_sg_for_cpu,
 	.sync_sg_for_device =	pa11_dma_sync_sg_for_device,
+	.cache_sync =		pa11_dma_cache_sync,
 };
 
 static void *pcx_dma_alloc(struct device *dev, size_t size,
@@ -619,4 +626,5 @@ const struct dma_map_ops pcx_dma_ops = {
 	.sync_single_for_device = pa11_dma_sync_single_for_device,
 	.sync_sg_for_cpu =	pa11_dma_sync_sg_for_cpu,
 	.sync_sg_for_device =	pa11_dma_sync_sg_for_device,
+	.cache_sync =		pa11_dma_cache_sync,
 };
diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index 320846442bfb..2e43c2ef7632 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -141,10 +141,5 @@ static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
 
 #define ARCH_HAS_DMA_MMAP_COHERENT
 
-static inline void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
-		enum dma_data_direction direction)
-{
-}
-
 #endif /* __KERNEL__ */
 #endif	/* _ASM_DMA_MAPPING_H */
diff --git a/arch/s390/include/asm/dma-mapping.h b/arch/s390/include/asm/dma-mapping.h
index 512ad0eaa11a..b17304b13de5 100644
--- a/arch/s390/include/asm/dma-mapping.h
+++ b/arch/s390/include/asm/dma-mapping.h
@@ -15,11 +15,6 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return &dma_noop_ops;
 }
 
-static inline void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
-				  enum dma_data_direction direction)
-{
-}
-
 static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 {
 	if (!dev->dma_mask)
diff --git a/arch/sh/include/asm/dma-mapping.h b/arch/sh/include/asm/dma-mapping.h
index b46194ecef17..e89df111c017 100644
--- a/arch/sh/include/asm/dma-mapping.h
+++ b/arch/sh/include/asm/dma-mapping.h
@@ -9,12 +9,6 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return dma_ops;
 }
 
-static inline void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
-		    enum dma_data_direction dir)
-{
-}
-
-/* arch/sh/mm/consistent.c */
 extern void *dma_generic_alloc_coherent(struct device *dev, size_t size,
 					dma_addr_t *dma_addr, gfp_t flag,
 					unsigned long attrs);
diff --git a/arch/sparc/include/asm/dma-mapping.h b/arch/sparc/include/asm/dma-mapping.h
index 60bf1633d554..b298ed45cb23 100644
--- a/arch/sparc/include/asm/dma-mapping.h
+++ b/arch/sparc/include/asm/dma-mapping.h
@@ -5,14 +5,6 @@
 #include <linux/mm.h>
 #include <linux/dma-debug.h>
 
-static inline void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
-				  enum dma_data_direction dir)
-{
-	/* Since dma_{alloc,free}_noncoherent() allocated coherent memory, this
-	 * routine can be a nop.
-	 */
-}
-
 extern const struct dma_map_ops *dma_ops;
 extern const struct dma_map_ops pci32_dma_ops;
 
diff --git a/arch/tile/include/asm/dma-mapping.h b/arch/tile/include/asm/dma-mapping.h
index 7061dc8af43a..97ad62878290 100644
--- a/arch/tile/include/asm/dma-mapping.h
+++ b/arch/tile/include/asm/dma-mapping.h
@@ -67,13 +67,4 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 #define HAVE_ARCH_DMA_SET_MASK 1
 int dma_set_mask(struct device *dev, u64 mask);
 
-/*
- * dma_alloc_attrs() always returns non-cacheable memory, so there's no need to
- * do any flushing here.
- */
-static inline void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
-				  enum dma_data_direction direction)
-{
-}
-
 #endif /* _ASM_TILE_DMA_MAPPING_H */
diff --git a/arch/unicore32/include/asm/dma-mapping.h b/arch/unicore32/include/asm/dma-mapping.h
index e949855bb794..ac608c2f6af6 100644
--- a/arch/unicore32/include/asm/dma-mapping.h
+++ b/arch/unicore32/include/asm/dma-mapping.h
@@ -45,10 +45,5 @@ static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
 
 static inline void dma_mark_clean(void *addr, size_t size) {}
 
-static inline void dma_cache_sync(struct device *dev, void *vaddr,
-		size_t size, enum dma_data_direction direction)
-{
-}
-
 #endif /* __KERNEL__ */
 #endif
diff --git a/arch/x86/include/asm/dma-mapping.h b/arch/x86/include/asm/dma-mapping.h
index c6d3367be916..c26747340ba5 100644
--- a/arch/x86/include/asm/dma-mapping.h
+++ b/arch/x86/include/asm/dma-mapping.h
@@ -67,12 +67,6 @@ static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
 }
 #endif /* CONFIG_X86_DMA_REMAP */
 
-static inline void
-dma_cache_sync(struct device *dev, void *vaddr, size_t size,
-	enum dma_data_direction dir)
-{
-}
-
 static inline unsigned long dma_alloc_coherent_mask(struct device *dev,
 						    gfp_t gfp)
 {
diff --git a/arch/xtensa/include/asm/dma-mapping.h b/arch/xtensa/include/asm/dma-mapping.h
index 353e0314d6ba..153bf2370988 100644
--- a/arch/xtensa/include/asm/dma-mapping.h
+++ b/arch/xtensa/include/asm/dma-mapping.h
@@ -23,11 +23,6 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return &xtensa_dma_map_ops;
 }
 
-static inline void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
-		    enum dma_data_direction direction)
-{
-}
-
 static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
 	return (dma_addr_t)paddr;
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 29ce9815da87..028a375d240d 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -126,6 +126,8 @@ struct dma_map_ops {
 	void (*sync_sg_for_device)(struct device *dev,
 				   struct scatterlist *sg, int nents,
 				   enum dma_data_direction dir);
+	void (*cache_sync)(struct device *dev, void *vaddr, size_t size,
+			enum dma_data_direction direction);
 	int (*mapping_error)(struct device *dev, dma_addr_t dma_addr);
 	int (*dma_supported)(struct device *dev, u64 mask);
 #ifdef ARCH_HAS_DMA_GET_REQUIRED_MASK
@@ -436,6 +438,17 @@ dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 #define dma_map_page(d, p, o, s, r) dma_map_page_attrs(d, p, o, s, r, 0)
 #define dma_unmap_page(d, a, s, r) dma_unmap_page_attrs(d, a, s, r, 0)
 
+static inline void
+dma_cache_sync(struct device *dev, void *vaddr, size_t size,
+		enum dma_data_direction dir)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	BUG_ON(!valid_dma_direction(dir));
+	if (ops->cache_sync)
+		ops->cache_sync(dev, vaddr, size, dir);
+}
+
 extern int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 			   void *cpu_addr, dma_addr_t dma_addr, size_t size);
 
-- 
2.14.1
