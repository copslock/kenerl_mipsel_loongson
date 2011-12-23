Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Dec 2011 13:30:09 +0100 (CET)
Received: from mailout4.w1.samsung.com ([210.118.77.14]:65463 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903628Ab1LWM2H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Dec 2011 13:28:07 +0100
MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-type: TEXT/PLAIN
Received: from euspt2 ([210.118.77.14]) by mailout4.w1.samsung.com
 (Sun Java(tm) System Messaging Server 6.3-8.04 (built Jul 29 2009; 32bit))
 with ESMTP id <0LWN005JWPAMO240@mailout4.w1.samsung.com> for
 linux-mips@linux-mips.org; Fri, 23 Dec 2011 12:27:58 +0000 (GMT)
Received: from linux.samsung.com ([106.116.38.10])
 by spt2.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
 2004)) with ESMTPA id <0LWN003H0PALM1@spt2.w1.samsung.com> for
 linux-mips@linux-mips.org; Fri, 23 Dec 2011 12:27:58 +0000 (GMT)
Received: from mcdsrvbld02.digital.local (unknown [106.116.37.23])
        by linux.samsung.com (Postfix) with ESMTP id 7BDB9270053; Fri,
 23 Dec 2011 13:39:23 +0100 (CET)
Date:   Fri, 23 Dec 2011 13:27:21 +0100
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 02/14] X86: adapt for dma_map_ops changes
In-reply-to: <1324643253-3024-1-git-send-email-m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        microblaze-uclinux@itee.uq.edu.au, linux-arch@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mips@linux-mips.org, discuss@x86-64.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linaro-mm-sig@lists.linaro.org, Jonathan Corbet <corbet@lwn.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>
Message-id: <1324643253-3024-3-git-send-email-m.szyprowski@samsung.com>
X-Mailer: git-send-email 1.7.7.3
References: <1324643253-3024-1-git-send-email-m.szyprowski@samsung.com>
X-archive-position: 32162
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: m.szyprowski@samsung.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 18811

From: Andrzej Pietrasiewicz <andrzej.p@samsung.com>

Adapt core X86 architecture code for dma_map_ops changes: replace
alloc/free_coherent with generic alloc/free methods.

Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/x86/include/asm/dma-mapping.h |   26 ++++++++++++++++----------
 arch/x86/kernel/amd_gart_64.c      |   11 ++++++-----
 arch/x86/kernel/pci-calgary_64.c   |    9 +++++----
 arch/x86/kernel/pci-dma.c          |    3 ++-
 arch/x86/kernel/pci-nommu.c        |    6 +++---
 arch/x86/kernel/pci-swiotlb.c      |   12 +++++++-----
 arch/x86/xen/pci-swiotlb-xen.c     |    4 ++--
 drivers/iommu/amd_iommu.c          |   10 ++++++----
 drivers/iommu/intel-iommu.c        |    9 +++++----
 drivers/xen/swiotlb-xen.c          |    5 +++--
 include/linux/swiotlb.h            |    6 ++++--
 include/xen/swiotlb-xen.h          |    6 ++++--
 lib/swiotlb.c                      |    5 +++--
 13 files changed, 66 insertions(+), 46 deletions(-)

diff --git a/arch/x86/include/asm/dma-mapping.h b/arch/x86/include/asm/dma-mapping.h
index ed3065f..4b4331d 100644
--- a/arch/x86/include/asm/dma-mapping.h
+++ b/arch/x86/include/asm/dma-mapping.h
@@ -59,7 +59,8 @@ extern int dma_supported(struct device *hwdev, u64 mask);
 extern int dma_set_mask(struct device *dev, u64 mask);
 
 extern void *dma_generic_alloc_coherent(struct device *dev, size_t size,
-					dma_addr_t *dma_addr, gfp_t flag);
+					dma_addr_t *dma_addr, gfp_t flag,
+					struct dma_attrs *attrs);
 
 static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 {
@@ -111,9 +112,11 @@ static inline gfp_t dma_alloc_coherent_gfp_flags(struct device *dev, gfp_t gfp)
        return gfp;
 }
 
+#define dma_alloc_coherent(d,s,h,f)	dma_alloc_attrs(d,s,h,f,NULL)
+
 static inline void *
-dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_handle,
-		gfp_t gfp)
+dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
+		gfp_t gfp, struct dma_attrs *attrs)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
 	void *memory;
@@ -129,18 +132,21 @@ dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	if (!is_device_dma_capable(dev))
 		return NULL;
 
-	if (!ops->alloc_coherent)
+	if (!ops->alloc)
 		return NULL;
 
-	memory = ops->alloc_coherent(dev, size, dma_handle,
-				     dma_alloc_coherent_gfp_flags(dev, gfp));
+	memory = ops->alloc(dev, size, dma_handle,
+			    dma_alloc_coherent_gfp_flags(dev, gfp), attrs);
 	debug_dma_alloc_coherent(dev, size, *dma_handle, memory);
 
 	return memory;
 }
 
-static inline void dma_free_coherent(struct device *dev, size_t size,
-				     void *vaddr, dma_addr_t bus)
+#define dma_free_coherent(d,s,c,h) dma_free_attrs(d,s,c,h,NULL)
+
+static inline void dma_free_attrs(struct device *dev, size_t size,
+				  void *vaddr, dma_addr_t bus,
+				  struct dma_attrs *attrs)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
 
@@ -150,8 +156,8 @@ static inline void dma_free_coherent(struct device *dev, size_t size,
 		return;
 
 	debug_dma_free_coherent(dev, size, vaddr, bus);
-	if (ops->free_coherent)
-		ops->free_coherent(dev, size, vaddr, bus);
+	if (ops->free)
+		ops->free(dev, size, vaddr, bus, attrs);
 }
 
 #endif
diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index b1e7c7f..e663112 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -477,7 +477,7 @@ error:
 /* allocate and map a coherent mapping */
 static void *
 gart_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_addr,
-		    gfp_t flag)
+		    gfp_t flag, struct dma_attrs *attrs)
 {
 	dma_addr_t paddr;
 	unsigned long align_mask;
@@ -500,7 +500,8 @@ gart_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_addr,
 		}
 		__free_pages(page, get_order(size));
 	} else
-		return dma_generic_alloc_coherent(dev, size, dma_addr, flag);
+		return dma_generic_alloc_coherent(dev, size, dma_addr, flag,
+						  attrs);
 
 	return NULL;
 }
@@ -508,7 +509,7 @@ gart_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_addr,
 /* free a coherent mapping */
 static void
 gart_free_coherent(struct device *dev, size_t size, void *vaddr,
-		   dma_addr_t dma_addr)
+		   dma_addr_t dma_addr, struct dma_attrs *attrs)
 {
 	gart_unmap_page(dev, dma_addr, size, DMA_BIDIRECTIONAL, NULL);
 	free_pages((unsigned long)vaddr, get_order(size));
@@ -700,8 +701,8 @@ static struct dma_map_ops gart_dma_ops = {
 	.unmap_sg			= gart_unmap_sg,
 	.map_page			= gart_map_page,
 	.unmap_page			= gart_unmap_page,
-	.alloc_coherent			= gart_alloc_coherent,
-	.free_coherent			= gart_free_coherent,
+	.alloc				= gart_alloc_coherent,
+	.free				= gart_free_coherent,
 	.mapping_error			= gart_mapping_error,
 };
 
diff --git a/arch/x86/kernel/pci-calgary_64.c b/arch/x86/kernel/pci-calgary_64.c
index 726494b..07b587c 100644
--- a/arch/x86/kernel/pci-calgary_64.c
+++ b/arch/x86/kernel/pci-calgary_64.c
@@ -431,7 +431,7 @@ static void calgary_unmap_page(struct device *dev, dma_addr_t dma_addr,
 }
 
 static void* calgary_alloc_coherent(struct device *dev, size_t size,
-	dma_addr_t *dma_handle, gfp_t flag)
+	dma_addr_t *dma_handle, gfp_t flag, struct dma_attrs *attrs)
 {
 	void *ret = NULL;
 	dma_addr_t mapping;
@@ -464,7 +464,8 @@ error:
 }
 
 static void calgary_free_coherent(struct device *dev, size_t size,
-				  void *vaddr, dma_addr_t dma_handle)
+				  void *vaddr, dma_addr_t dma_handle,
+				  struct dma_attrs *attrs)
 {
 	unsigned int npages;
 	struct iommu_table *tbl = find_iommu_table(dev);
@@ -477,8 +478,8 @@ static void calgary_free_coherent(struct device *dev, size_t size,
 }
 
 static struct dma_map_ops calgary_dma_ops = {
-	.alloc_coherent = calgary_alloc_coherent,
-	.free_coherent = calgary_free_coherent,
+	.alloc = calgary_alloc_coherent,
+	.free = calgary_free_coherent,
 	.map_sg = calgary_map_sg,
 	.unmap_sg = calgary_unmap_sg,
 	.map_page = calgary_map_page,
diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index 80dc793..b8b9e47 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -87,7 +87,8 @@ void __init pci_iommu_alloc(void)
 	}
 }
 void *dma_generic_alloc_coherent(struct device *dev, size_t size,
-				 dma_addr_t *dma_addr, gfp_t flag)
+				 dma_addr_t *dma_addr, gfp_t flag,
+				 struct dma_attrs *attrs)
 {
 	unsigned long dma_mask;
 	struct page *page;
diff --git a/arch/x86/kernel/pci-nommu.c b/arch/x86/kernel/pci-nommu.c
index 3af4af8..f960506 100644
--- a/arch/x86/kernel/pci-nommu.c
+++ b/arch/x86/kernel/pci-nommu.c
@@ -75,7 +75,7 @@ static int nommu_map_sg(struct device *hwdev, struct scatterlist *sg,
 }
 
 static void nommu_free_coherent(struct device *dev, size_t size, void *vaddr,
-				dma_addr_t dma_addr)
+				dma_addr_t dma_addr, struct dma_attrs *attrs)
 {
 	free_pages((unsigned long)vaddr, get_order(size));
 }
@@ -96,8 +96,8 @@ static void nommu_sync_sg_for_device(struct device *dev,
 }
 
 struct dma_map_ops nommu_dma_ops = {
-	.alloc_coherent		= dma_generic_alloc_coherent,
-	.free_coherent		= nommu_free_coherent,
+	.alloc			= dma_generic_alloc_coherent,
+	.free			= nommu_free_coherent,
 	.map_sg			= nommu_map_sg,
 	.map_page		= nommu_map_page,
 	.sync_single_for_device = nommu_sync_single_for_device,
diff --git a/arch/x86/kernel/pci-swiotlb.c b/arch/x86/kernel/pci-swiotlb.c
index 8f972cb..fa462a3 100644
--- a/arch/x86/kernel/pci-swiotlb.c
+++ b/arch/x86/kernel/pci-swiotlb.c
@@ -15,21 +15,23 @@
 int swiotlb __read_mostly;
 
 static void *x86_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
-					dma_addr_t *dma_handle, gfp_t flags)
+					dma_addr_t *dma_handle, gfp_t flags,
+					struct dma_attrs *attrs)
 {
 	void *vaddr;
 
-	vaddr = dma_generic_alloc_coherent(hwdev, size, dma_handle, flags);
+	vaddr = dma_generic_alloc_coherent(hwdev, size, dma_handle, flags,
+					   attrs);
 	if (vaddr)
 		return vaddr;
 
-	return swiotlb_alloc_coherent(hwdev, size, dma_handle, flags);
+	return swiotlb_alloc_coherent(hwdev, size, dma_handle, flags, attrs);
 }
 
 static struct dma_map_ops swiotlb_dma_ops = {
 	.mapping_error = swiotlb_dma_mapping_error,
-	.alloc_coherent = x86_swiotlb_alloc_coherent,
-	.free_coherent = swiotlb_free_coherent,
+	.alloc = x86_swiotlb_alloc_coherent,
+	.free = swiotlb_free_coherent,
 	.sync_single_for_cpu = swiotlb_sync_single_for_cpu,
 	.sync_single_for_device = swiotlb_sync_single_for_device,
 	.sync_sg_for_cpu = swiotlb_sync_sg_for_cpu,
diff --git a/arch/x86/xen/pci-swiotlb-xen.c b/arch/x86/xen/pci-swiotlb-xen.c
index b480d42..967633a 100644
--- a/arch/x86/xen/pci-swiotlb-xen.c
+++ b/arch/x86/xen/pci-swiotlb-xen.c
@@ -12,8 +12,8 @@ int xen_swiotlb __read_mostly;
 
 static struct dma_map_ops xen_swiotlb_dma_ops = {
 	.mapping_error = xen_swiotlb_dma_mapping_error,
-	.alloc_coherent = xen_swiotlb_alloc_coherent,
-	.free_coherent = xen_swiotlb_free_coherent,
+	.alloc = xen_swiotlb_alloc_coherent,
+	.free = xen_swiotlb_free_coherent,
 	.sync_single_for_cpu = xen_swiotlb_sync_single_for_cpu,
 	.sync_single_for_device = xen_swiotlb_sync_single_for_device,
 	.sync_sg_for_cpu = xen_swiotlb_sync_sg_for_cpu,
diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 4ee277a..fc36f1e 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2335,7 +2335,8 @@ static void unmap_sg(struct device *dev, struct scatterlist *sglist,
  * The exported alloc_coherent function for dma_ops.
  */
 static void *alloc_coherent(struct device *dev, size_t size,
-			    dma_addr_t *dma_addr, gfp_t flag)
+			    dma_addr_t *dma_addr, gfp_t flag,
+			    struct dma_attrs *attrs)
 {
 	unsigned long flags;
 	void *virt_addr;
@@ -2393,7 +2394,8 @@ out_free:
  * The exported free_coherent function for dma_ops.
  */
 static void free_coherent(struct device *dev, size_t size,
-			  void *virt_addr, dma_addr_t dma_addr)
+			  void *virt_addr, dma_addr_t dma_addr,
+			  struct dma_attrs *attrs)
 {
 	unsigned long flags;
 	struct protection_domain *domain;
@@ -2463,8 +2465,8 @@ static void prealloc_protection_domains(void)
 }
 
 static struct dma_map_ops amd_iommu_dma_ops = {
-	.alloc_coherent = alloc_coherent,
-	.free_coherent = free_coherent,
+	.alloc = alloc_coherent,
+	.free = free_coherent,
 	.map_page = map_page,
 	.unmap_page = unmap_page,
 	.map_sg = map_sg,
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index bdc447f..22982184 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2925,7 +2925,8 @@ static void intel_unmap_page(struct device *dev, dma_addr_t dev_addr,
 }
 
 static void *intel_alloc_coherent(struct device *hwdev, size_t size,
-				  dma_addr_t *dma_handle, gfp_t flags)
+				  dma_addr_t *dma_handle, gfp_t flags,
+				  struct dma_attrs *attrs)
 {
 	void *vaddr;
 	int order;
@@ -2957,7 +2958,7 @@ static void *intel_alloc_coherent(struct device *hwdev, size_t size,
 }
 
 static void intel_free_coherent(struct device *hwdev, size_t size, void *vaddr,
-				dma_addr_t dma_handle)
+				dma_addr_t dma_handle, struct dma_attrs *attrs)
 {
 	int order;
 
@@ -3102,8 +3103,8 @@ static int intel_mapping_error(struct device *dev, dma_addr_t dma_addr)
 }
 
 struct dma_map_ops intel_dma_ops = {
-	.alloc_coherent = intel_alloc_coherent,
-	.free_coherent = intel_free_coherent,
+	.alloc = intel_alloc_coherent,
+	.free = intel_free_coherent,
 	.map_sg = intel_map_sg,
 	.unmap_sg = intel_unmap_sg,
 	.map_page = intel_map_page,
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 284798a..6c67ed4 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -204,7 +204,8 @@ error:
 
 void *
 xen_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
-			   dma_addr_t *dma_handle, gfp_t flags)
+			   dma_addr_t *dma_handle, gfp_t flags,
+			   struct dma_attrs *attrs)
 {
 	void *ret;
 	int order = get_order(size);
@@ -253,7 +254,7 @@ EXPORT_SYMBOL_GPL(xen_swiotlb_alloc_coherent);
 
 void
 xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
-			  dma_addr_t dev_addr)
+			  dma_addr_t dev_addr, struct dma_attrs *attrs)
 {
 	int order = get_order(size);
 	phys_addr_t phys;
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 445702c..769f8bc 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -50,11 +50,13 @@ extern void swiotlb_bounce(phys_addr_t phys, char *dma_addr, size_t size,
 
 extern void
 *swiotlb_alloc_coherent(struct device *hwdev, size_t size,
-			dma_addr_t *dma_handle, gfp_t flags);
+			dma_addr_t *dma_handle, gfp_t flags,
+			struct dma_attrs *attrs);
 
 extern void
 swiotlb_free_coherent(struct device *hwdev, size_t size,
-		      void *vaddr, dma_addr_t dma_handle);
+		      void *vaddr, dma_addr_t dma_handle,
+		      struct dma_attrs *attrs);
 
 extern dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
 				   unsigned long offset, size_t size,
diff --git a/include/xen/swiotlb-xen.h b/include/xen/swiotlb-xen.h
index 2ea2fdc..4f4d449 100644
--- a/include/xen/swiotlb-xen.h
+++ b/include/xen/swiotlb-xen.h
@@ -7,11 +7,13 @@ extern void xen_swiotlb_init(int verbose);
 
 extern void
 *xen_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
-			    dma_addr_t *dma_handle, gfp_t flags);
+			    dma_addr_t *dma_handle, gfp_t flags,
+			    struct dma_attrs *attrs);
 
 extern void
 xen_swiotlb_free_coherent(struct device *hwdev, size_t size,
-			  void *vaddr, dma_addr_t dma_handle);
+			  void *vaddr, dma_addr_t dma_handle,
+			  struct dma_attrs *attrs);
 
 extern dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 				       unsigned long offset, size_t size,
diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index 99093b3..10a4f68 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -565,7 +565,8 @@ EXPORT_SYMBOL_GPL(swiotlb_tbl_sync_single);
 
 void *
 swiotlb_alloc_coherent(struct device *hwdev, size_t size,
-		       dma_addr_t *dma_handle, gfp_t flags)
+		       dma_addr_t *dma_handle, gfp_t flags,
+		       struct dma_attrs *attrs)
 {
 	dma_addr_t dev_addr;
 	void *ret;
@@ -614,7 +615,7 @@ EXPORT_SYMBOL(swiotlb_alloc_coherent);
 
 void
 swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
-		      dma_addr_t dev_addr)
+		      dma_addr_t dev_addr, struct dma_attrs *attrs)
 {
 	phys_addr_t paddr = dma_to_phys(hwdev, dev_addr);
 
-- 
1.7.1.569.g6f426
