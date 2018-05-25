Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 May 2018 11:23:17 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:50926 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992994AbeEYJVigOAtA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 May 2018 11:21:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5pgOjul19Jr0WZnPUT+CbdqCaJ3akPW80paS80hydrM=; b=HB8aL3Bijie7LF38Rl8iUP4d5
        CNZSLZOWVYg8lT8H0cr8+ChwZO7rxgP6ITa6WDcByiroN/vAtXsC9C3JkSr8OHRZuW9sP4P3Vir8w
        yC8v+WMHCJN7vSNXd+M68VkW96nAiWXdpI/QnJJ62n7U7uVLUTK3BG8JUhFuCPhwSZf9rAbvvMEEI
        sP3BKaLxcQaovR7kzJzRjs/nhDFDhyu/I1ul29RMjfwUal53JVFX7SWzk5hbLfYTrychh+5iHuSts
        FwxHg6qu3EZZCVyRAAipzjPFIaDHoilerOan3P6fgc42Ty6SVIvkL3v/VpbcYJMNNFi03NnDlForO
        kLNMhBRHw==;
Received: from 80-109-164-210.cable.dynamic.surfer.at ([80.109.164.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fM8um-0001iV-Uh; Fri, 25 May 2018 09:21:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        David Daney <david.daney@cavium.com>,
        Tom Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org, iommu@lists.linux-foundation.org
Subject: [PATCH 07/25] MIPS: consolidate the swiotlb implementations
Date:   Fri, 25 May 2018 11:20:53 +0200
Message-Id: <20180525092111.18516-8-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180525092111.18516-1-hch@lst.de>
References: <20180525092111.18516-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+5cb9c4fab7748cb05a15+5388+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64020
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

Octeon and Loongson share exactly the same code, move it into a common
implementation, and use that implementation directly from get_arch_dma_ops.

Also provide the expected dma-direct.h helpers directly instead of
delegating to platform dma-coherence.h headers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/cavium-octeon/dma-octeon.c          | 61 ----------------
 arch/mips/include/asm/dma-direct.h            | 17 ++++-
 arch/mips/include/asm/dma-mapping.h           |  5 ++
 .../asm/mach-cavium-octeon/dma-coherence.h    | 11 ---
 .../asm/mach-loongson64/dma-coherence.h       | 10 ---
 arch/mips/loongson64/common/dma-swiotlb.c     | 71 +------------------
 arch/mips/mm/Makefile                         |  1 +
 arch/mips/mm/dma-swiotlb.c                    | 61 ++++++++++++++++
 8 files changed, 84 insertions(+), 153 deletions(-)
 create mode 100644 arch/mips/mm/dma-swiotlb.c

diff --git a/arch/mips/cavium-octeon/dma-octeon.c b/arch/mips/cavium-octeon/dma-octeon.c
index 1e68636c9137..939620b90164 100644
--- a/arch/mips/cavium-octeon/dma-octeon.c
+++ b/arch/mips/cavium-octeon/dma-octeon.c
@@ -11,7 +11,6 @@
  * Copyright (C) 2010 Cavium Networks, Inc.
  */
 #include <linux/dma-direct.h>
-#include <linux/scatterlist.h>
 #include <linux/bootmem.h>
 #include <linux/swiotlb.h>
 #include <linux/types.h>
@@ -159,49 +158,6 @@ void __init octeon_pci_dma_init(void)
 }
 #endif /* CONFIG_PCI */
 
-static dma_addr_t octeon_dma_map_page(struct device *dev, struct page *page,
-	unsigned long offset, size_t size, enum dma_data_direction direction,
-	unsigned long attrs)
-{
-	dma_addr_t daddr = swiotlb_map_page(dev, page, offset, size,
-					    direction, attrs);
-	mb();
-
-	return daddr;
-}
-
-static int octeon_dma_map_sg(struct device *dev, struct scatterlist *sg,
-	int nents, enum dma_data_direction direction, unsigned long attrs)
-{
-	int r = swiotlb_map_sg_attrs(dev, sg, nents, direction, attrs);
-	mb();
-	return r;
-}
-
-static void octeon_dma_sync_single_for_device(struct device *dev,
-	dma_addr_t dma_handle, size_t size, enum dma_data_direction direction)
-{
-	swiotlb_sync_single_for_device(dev, dma_handle, size, direction);
-	mb();
-}
-
-static void octeon_dma_sync_sg_for_device(struct device *dev,
-	struct scatterlist *sg, int nelems, enum dma_data_direction direction)
-{
-	swiotlb_sync_sg_for_device(dev, sg, nelems, direction);
-	mb();
-}
-
-static void *octeon_dma_alloc_coherent(struct device *dev, size_t size,
-	dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
-{
-	void *ret = swiotlb_alloc(dev, size, dma_handle, gfp, attrs);
-
-	mb();
-
-	return ret;
-}
-
 dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
 #ifdef CONFIG_PCI
@@ -220,21 +176,6 @@ phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t daddr)
 	return daddr;
 }
 
-static const struct dma_map_ops octeon_swiotlb_ops = {
-	.alloc			= octeon_dma_alloc_coherent,
-	.free			= swiotlb_free,
-	.map_page		= octeon_dma_map_page,
-	.unmap_page		= swiotlb_unmap_page,
-	.map_sg			= octeon_dma_map_sg,
-	.unmap_sg		= swiotlb_unmap_sg_attrs,
-	.sync_single_for_cpu	= swiotlb_sync_single_for_cpu,
-	.sync_single_for_device	= octeon_dma_sync_single_for_device,
-	.sync_sg_for_cpu	= swiotlb_sync_sg_for_cpu,
-	.sync_sg_for_device	= octeon_dma_sync_sg_for_device,
-	.mapping_error		= swiotlb_dma_mapping_error,
-	.dma_supported		= swiotlb_dma_supported
-};
-
 char *octeon_swiotlb;
 
 void __init plat_swiotlb_setup(void)
@@ -297,6 +238,4 @@ void __init plat_swiotlb_setup(void)
 
 	if (swiotlb_init_with_tbl(octeon_swiotlb, swiotlb_nslabs, 1) == -ENOMEM)
 		panic("Cannot allocate SWIOTLB buffer");
-
-	mips_dma_map_ops = &octeon_swiotlb_ops;
 }
diff --git a/arch/mips/include/asm/dma-direct.h b/arch/mips/include/asm/dma-direct.h
index f32f15530aba..b5c240806e1b 100644
--- a/arch/mips/include/asm/dma-direct.h
+++ b/arch/mips/include/asm/dma-direct.h
@@ -1 +1,16 @@
-#include <asm/dma-coherence.h>
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _MIPS_DMA_DIRECT_H
+#define _MIPS_DMA_DIRECT_H 1
+
+static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
+{
+	if (!dev->dma_mask)
+		return false;
+
+	return addr + size - 1 <= *dev->dma_mask;
+}
+
+dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr);
+phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t daddr);
+
+#endif /* _MIPS_DMA_DIRECT_H */
diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
index 886e75a383f2..ebcce3e22297 100644
--- a/arch/mips/include/asm/dma-mapping.h
+++ b/arch/mips/include/asm/dma-mapping.h
@@ -11,10 +11,15 @@
 #endif
 
 extern const struct dma_map_ops *mips_dma_map_ops;
+extern const struct dma_map_ops mips_swiotlb_ops;
 
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
+#ifdef CONFIG_SWIOTLB
+	return &mips_swiotlb_ops;
+#else
 	return mips_dma_map_ops;
+#endif
 }
 
 #define arch_setup_dma_ops arch_setup_dma_ops
diff --git a/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h b/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
index c5cdeea495f8..c0254c72d97b 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
@@ -61,17 +61,6 @@ static inline void plat_post_dma_flush(struct device *dev)
 {
 }
 
-static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
-{
-	if (!dev->dma_mask)
-		return false;
-
-	return addr + size - 1 <= *dev->dma_mask;
-}
-
-dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr);
-phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t daddr);
-
 extern char *octeon_swiotlb;
 
 #endif /* __ASM_MACH_CAVIUM_OCTEON_DMA_COHERENCE_H */
diff --git a/arch/mips/include/asm/mach-loongson64/dma-coherence.h b/arch/mips/include/asm/mach-loongson64/dma-coherence.h
index 64fc44dec0a8..b8825a7d1279 100644
--- a/arch/mips/include/asm/mach-loongson64/dma-coherence.h
+++ b/arch/mips/include/asm/mach-loongson64/dma-coherence.h
@@ -17,16 +17,6 @@
 
 struct device;
 
-static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
-{
-	if (!dev->dma_mask)
-		return false;
-
-	return addr + size - 1 <= *dev->dma_mask;
-}
-
-extern dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr);
-extern phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t daddr);
 static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
 					  size_t size)
 {
diff --git a/arch/mips/loongson64/common/dma-swiotlb.c b/arch/mips/loongson64/common/dma-swiotlb.c
index a5e50f2ec301..a4f554bf1232 100644
--- a/arch/mips/loongson64/common/dma-swiotlb.c
+++ b/arch/mips/loongson64/common/dma-swiotlb.c
@@ -1,60 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/mm.h>
+#include <linux/dma-direct.h>
 #include <linux/init.h>
-#include <linux/dma-mapping.h>
-#include <linux/scatterlist.h>
 #include <linux/swiotlb.h>
-#include <linux/bootmem.h>
-
-#include <asm/bootinfo.h>
-#include <boot_param.h>
-#include <dma-coherence.h>
-
-static void *loongson_dma_alloc_coherent(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
-{
-	void *ret = swiotlb_alloc(dev, size, dma_handle, gfp, attrs);
-
-	mb();
-	return ret;
-}
-
-static dma_addr_t loongson_dma_map_page(struct device *dev, struct page *page,
-				unsigned long offset, size_t size,
-				enum dma_data_direction dir,
-				unsigned long attrs)
-{
-	dma_addr_t daddr = swiotlb_map_page(dev, page, offset, size,
-					dir, attrs);
-	mb();
-	return daddr;
-}
-
-static int loongson_dma_map_sg(struct device *dev, struct scatterlist *sg,
-				int nents, enum dma_data_direction dir,
-				unsigned long attrs)
-{
-	int r = swiotlb_map_sg_attrs(dev, sg, nents, dir, attrs);
-	mb();
-
-	return r;
-}
-
-static void loongson_dma_sync_single_for_device(struct device *dev,
-				dma_addr_t dma_handle, size_t size,
-				enum dma_data_direction dir)
-{
-	swiotlb_sync_single_for_device(dev, dma_handle, size, dir);
-	mb();
-}
-
-static void loongson_dma_sync_sg_for_device(struct device *dev,
-				struct scatterlist *sg, int nents,
-				enum dma_data_direction dir)
-{
-	swiotlb_sync_sg_for_device(dev, sg, nents, dir);
-	mb();
-}
 
 dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
@@ -80,23 +27,7 @@ phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t daddr)
 	return daddr;
 }
 
-static const struct dma_map_ops loongson_dma_map_ops = {
-	.alloc = loongson_dma_alloc_coherent,
-	.free = swiotlb_free,
-	.map_page = loongson_dma_map_page,
-	.unmap_page = swiotlb_unmap_page,
-	.map_sg = loongson_dma_map_sg,
-	.unmap_sg = swiotlb_unmap_sg_attrs,
-	.sync_single_for_cpu = swiotlb_sync_single_for_cpu,
-	.sync_single_for_device = loongson_dma_sync_single_for_device,
-	.sync_sg_for_cpu = swiotlb_sync_sg_for_cpu,
-	.sync_sg_for_device = loongson_dma_sync_sg_for_device,
-	.mapping_error = swiotlb_dma_mapping_error,
-	.dma_supported = swiotlb_dma_supported,
-};
-
 void __init plat_swiotlb_setup(void)
 {
 	swiotlb_init(1);
-	mips_dma_map_ops = &loongson_dma_map_ops;
 }
diff --git a/arch/mips/mm/Makefile b/arch/mips/mm/Makefile
index c463bdad45c7..b87e4258fd78 100644
--- a/arch/mips/mm/Makefile
+++ b/arch/mips/mm/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_32BIT)		+= ioremap.o pgtable-32.o
 obj-$(CONFIG_64BIT)		+= pgtable-64.o
 obj-$(CONFIG_HIGHMEM)		+= highmem.o
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
+obj-$(CONFIG_SWIOTLB)		+= dma-swiotlb.o
 
 obj-$(CONFIG_CPU_R4K_CACHE_TLB) += c-r4k.o cex-gen.o tlb-r4k.o
 obj-$(CONFIG_CPU_R3000)		+= c-r3k.o tlb-r3k.o
diff --git a/arch/mips/mm/dma-swiotlb.c b/arch/mips/mm/dma-swiotlb.c
new file mode 100644
index 000000000000..6014ed3479fd
--- /dev/null
+++ b/arch/mips/mm/dma-swiotlb.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/dma-mapping.h>
+#include <linux/swiotlb.h>
+
+static void *mips_swiotlb_alloc(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
+{
+	void *ret = swiotlb_alloc(dev, size, dma_handle, gfp, attrs);
+
+	mb();
+	return ret;
+}
+
+static dma_addr_t mips_swiotlb_map_page(struct device *dev,
+		struct page *page, unsigned long offset, size_t size,
+		enum dma_data_direction dir, unsigned long attrs)
+{
+	dma_addr_t daddr = swiotlb_map_page(dev, page, offset, size,
+					dir, attrs);
+	mb();
+	return daddr;
+}
+
+static int mips_swiotlb_map_sg(struct device *dev, struct scatterlist *sg,
+		int nents, enum dma_data_direction dir, unsigned long attrs)
+{
+	int r = swiotlb_map_sg_attrs(dev, sg, nents, dir, attrs);
+	mb();
+
+	return r;
+}
+
+static void mips_swiotlb_sync_single_for_device(struct device *dev,
+		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
+{
+	swiotlb_sync_single_for_device(dev, dma_handle, size, dir);
+	mb();
+}
+
+static void mips_swiotlb_sync_sg_for_device(struct device *dev,
+		struct scatterlist *sg, int nents, enum dma_data_direction dir)
+{
+	swiotlb_sync_sg_for_device(dev, sg, nents, dir);
+	mb();
+}
+
+const struct dma_map_ops mips_swiotlb_ops = {
+	.alloc			= mips_swiotlb_alloc,
+	.free			= swiotlb_free,
+	.map_page		= mips_swiotlb_map_page,
+	.unmap_page		= swiotlb_unmap_page,
+	.map_sg			= mips_swiotlb_map_sg,
+	.unmap_sg		= swiotlb_unmap_sg_attrs,
+	.sync_single_for_cpu	= swiotlb_sync_single_for_cpu,
+	.sync_single_for_device	= mips_swiotlb_sync_single_for_device,
+	.sync_sg_for_cpu	= swiotlb_sync_sg_for_cpu,
+	.sync_sg_for_device	= mips_swiotlb_sync_sg_for_device,
+	.mapping_error		= swiotlb_dma_mapping_error,
+	.dma_supported		= swiotlb_dma_supported,
+};
+EXPORT_SYMBOL(mips_swiotlb_ops);
-- 
2.17.0
