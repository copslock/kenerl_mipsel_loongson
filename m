Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Feb 2012 13:42:36 +0100 (CET)
Received: from mailout4.w1.samsung.com ([210.118.77.14]:28895 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901163Ab2BMMma (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Feb 2012 13:42:30 +0100
MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-type: TEXT/PLAIN
Received: from euspt1 ([210.118.77.14]) by mailout4.w1.samsung.com
 (Sun Java(tm) System Messaging Server 6.3-8.04 (built Jul 29 2009; 32bit))
 with ESMTP id <0LZC00IW40MNCY50@mailout4.w1.samsung.com> for
 linux-mips@linux-mips.org; Mon, 13 Feb 2012 12:42:23 +0000 (GMT)
Received: from linux.samsung.com ([106.116.38.10])
 by spt1.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
 2004)) with ESMTPA id <0LZC00DUY0MMLE@spt1.w1.samsung.com> for
 linux-mips@linux-mips.org; Mon, 13 Feb 2012 12:42:23 +0000 (GMT)
Received: from mcdsrvbld02.digital.local (unknown [106.116.37.23])
        by linux.samsung.com (Postfix) with ESMTP id 60FDC270054; Mon,
 13 Feb 2012 13:59:58 +0100 (CET)
Date:   Mon, 13 Feb 2012 13:41:55 +0100
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 03/14 v3] MIPS: adapt for dma_map_ops changes
In-reply-to: <4F38E8E1.3070004@mvista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
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
Message-id: <1329136915-24824-1-git-send-email-m.szyprowski@samsung.com>
X-Mailer: git-send-email 1.7.8.3
References: <4F38E8E1.3070004@mvista.com>
X-archive-position: 32422
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: m.szyprowski@samsung.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Andrzej Pietrasiewicz <andrzej.p@samsung.com>

Adapt core MIPS architecture code for dma_map_ops changes: replace
alloc/free_coherent with generic alloc/free methods.

Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
[added missing changes to arch/mips/cavium-octeon/dma-octeon.c,
 fixed attrs argument in dma-mapping.h]
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/mips/cavium-octeon/dma-octeon.c |   16 ++++++++--------
 arch/mips/include/asm/dma-mapping.h  |   18 ++++++++++++------
 arch/mips/mm/dma-default.c           |    8 ++++----
 3 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/arch/mips/cavium-octeon/dma-octeon.c b/arch/mips/cavium-octeon/dma-octeon.c
index b6bb92c..df70600 100644
--- a/arch/mips/cavium-octeon/dma-octeon.c
+++ b/arch/mips/cavium-octeon/dma-octeon.c
@@ -157,7 +157,7 @@ static void octeon_dma_sync_sg_for_device(struct device *dev,
 }
 
 static void *octeon_dma_alloc_coherent(struct device *dev, size_t size,
-	dma_addr_t *dma_handle, gfp_t gfp)
+	dma_addr_t *dma_handle, gfp_t gfp, struct dma_attrs *attrs)
 {
 	void *ret;
 
@@ -184,7 +184,7 @@ static void *octeon_dma_alloc_coherent(struct device *dev, size_t size,
 	/* Don't invoke OOM killer */
 	gfp |= __GFP_NORETRY;
 
-	ret = swiotlb_alloc_coherent(dev, size, dma_handle, gfp);
+	ret = swiotlb_alloc_coherent(dev, size, dma_handle, gfp, attrs);
 
 	mb();
 
@@ -192,14 +192,14 @@ static void *octeon_dma_alloc_coherent(struct device *dev, size_t size,
 }
 
 static void octeon_dma_free_coherent(struct device *dev, size_t size,
-	void *vaddr, dma_addr_t dma_handle)
+	void *vaddr, dma_addr_t dma_handle, struct dma_attrs *attrs)
 {
 	int order = get_order(size);
 
 	if (dma_release_from_coherent(dev, order, vaddr))
 		return;
 
-	swiotlb_free_coherent(dev, size, vaddr, dma_handle);
+	swiotlb_free_coherent(dev, size, vaddr, dma_handle, attrs);
 }
 
 static dma_addr_t octeon_unity_phys_to_dma(struct device *dev, phys_addr_t paddr)
@@ -240,8 +240,8 @@ EXPORT_SYMBOL(dma_to_phys);
 
 static struct octeon_dma_map_ops octeon_linear_dma_map_ops = {
 	.dma_map_ops = {
-		.alloc_coherent = octeon_dma_alloc_coherent,
-		.free_coherent = octeon_dma_free_coherent,
+		.alloc = octeon_dma_alloc_coherent,
+		.free = octeon_dma_free_coherent,
 		.map_page = octeon_dma_map_page,
 		.unmap_page = swiotlb_unmap_page,
 		.map_sg = octeon_dma_map_sg,
@@ -325,8 +325,8 @@ void __init plat_swiotlb_setup(void)
 #ifdef CONFIG_PCI
 static struct octeon_dma_map_ops _octeon_pci_dma_map_ops = {
 	.dma_map_ops = {
-		.alloc_coherent = octeon_dma_alloc_coherent,
-		.free_coherent = octeon_dma_free_coherent,
+		.alloc = octeon_dma_alloc_coherent,
+		.free = octeon_dma_free_coherent,
 		.map_page = octeon_dma_map_page,
 		.unmap_page = swiotlb_unmap_page,
 		.map_sg = octeon_dma_map_sg,
diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
index 7aa37dd..be39a12 100644
--- a/arch/mips/include/asm/dma-mapping.h
+++ b/arch/mips/include/asm/dma-mapping.h
@@ -57,25 +57,31 @@ dma_set_mask(struct device *dev, u64 mask)
 extern void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 	       enum dma_data_direction direction);
 
-static inline void *dma_alloc_coherent(struct device *dev, size_t size,
-				       dma_addr_t *dma_handle, gfp_t gfp)
+#define dma_alloc_coherent(d,s,h,f)	dma_alloc_attrs(d,s,h,f,NULL)
+
+static inline void *dma_alloc_attrs(struct device *dev, size_t size,
+				    dma_addr_t *dma_handle, gfp_t gfp,
+				    struct dma_attrs *attrs)
 {
 	void *ret;
 	struct dma_map_ops *ops = get_dma_ops(dev);
 
-	ret = ops->alloc_coherent(dev, size, dma_handle, gfp);
+	ret = ops->alloc(dev, size, dma_handle, gfp, attrs);
 
 	debug_dma_alloc_coherent(dev, size, *dma_handle, ret);
 
 	return ret;
 }
 
-static inline void dma_free_coherent(struct device *dev, size_t size,
-				     void *vaddr, dma_addr_t dma_handle)
+#define dma_free_coherent(d,s,c,h) dma_free_attrs(d,s,c,h,NULL)
+
+static inline void dma_free_attrs(struct device *dev, size_t size,
+				  void *vaddr, dma_addr_t dma_handle,
+				  struct dma_attrs *attrs)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
 
-	ops->free_coherent(dev, size, vaddr, dma_handle);
+	ops->free(dev, size, vaddr, dma_handle, attrs);
 
 	debug_dma_free_coherent(dev, size, vaddr, dma_handle);
 }
diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index 4608491..3fab204 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -98,7 +98,7 @@ void *dma_alloc_noncoherent(struct device *dev, size_t size,
 EXPORT_SYMBOL(dma_alloc_noncoherent);
 
 static void *mips_dma_alloc_coherent(struct device *dev, size_t size,
-	dma_addr_t * dma_handle, gfp_t gfp)
+	dma_addr_t * dma_handle, gfp_t gfp, struct dma_attrs *attrs)
 {
 	void *ret;
 
@@ -132,7 +132,7 @@ void dma_free_noncoherent(struct device *dev, size_t size, void *vaddr,
 EXPORT_SYMBOL(dma_free_noncoherent);
 
 static void mips_dma_free_coherent(struct device *dev, size_t size, void *vaddr,
-	dma_addr_t dma_handle)
+	dma_addr_t dma_handle, struct dma_attrs *attrs)
 {
 	unsigned long addr = (unsigned long) vaddr;
 	int order = get_order(size);
@@ -323,8 +323,8 @@ void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 EXPORT_SYMBOL(dma_cache_sync);
 
 static struct dma_map_ops mips_default_dma_map_ops = {
-	.alloc_coherent = mips_dma_alloc_coherent,
-	.free_coherent = mips_dma_free_coherent,
+	.alloc = mips_dma_alloc_coherent,
+	.free = mips_dma_free_coherent,
 	.map_page = mips_dma_map_page,
 	.unmap_page = mips_dma_unmap_page,
 	.map_sg = mips_dma_map_sg,
-- 
1.7.1.569.g6f426
