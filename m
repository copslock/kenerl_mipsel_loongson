Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2018 13:18:09 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:51414 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994675AbeFOLKLmjHUT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jun 2018 13:10:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Kqv/qoZ0o3MyprXSov3Gx8a/hjln6Zr1F47XB/0SLfA=; b=PIt76imYZyFWaIu4JBDUie4FO
        CiBXLuGiLDg62MvbqgLoLhnk4tsbwarhus6r2NG+BEZZx6cCEnTEygbEQpd/jO5zacTRsBcBHfQBN
        Qr6vteqLEYPPjlOXqXRgbf9deKOywIdfExqFK/sa7j/Cgl6aRo64OxPl6RA9Xfv4gQejVed/NDAZl
        oCAKlFZEPHWj8a5aE4fIo/IBXOx8aAIs3WPYMHMlA6TqtqY0eK0qHydeyJQ5WY2VzI77D6XrHPdLx
        9ejbwcpQY3F3++U57keZVuaiYemvRbp+wc2JI8aput3OMqbQ+x+HEJr7exxHImKLkWCr3hqBrzfNg
        vGHFaGBhw==;
Received: from 80-109-164-210.cable.dynamic.surfer.at ([80.109.164.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTmcL-0005T9-0r; Fri, 15 Jun 2018 11:10:09 +0000
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
Subject: [PATCH 21/25] MIPS: jazz: split dma mapping operations from dma-default
Date:   Fri, 15 Jun 2018 13:08:50 +0200
Message-Id: <20180615110854.19253-22-hch@lst.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180615110854.19253-1-hch@lst.de>
References: <20180615110854.19253-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+0eb41a859d58214bb3da+5409+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64302
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

Jazz actually has a very basic IOMMU, so split the ops into a separate
implementation from the generic default support (which is about to go
away anyway).

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/include/asm/dma-mapping.h           |   5 +-
 .../include/asm/mach-jazz/dma-coherence.h     |  60 --------
 arch/mips/jazz/Kconfig                        |   3 -
 arch/mips/jazz/jazzdma.c                      | 141 +++++++++++++++++-
 4 files changed, 144 insertions(+), 65 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-jazz/dma-coherence.h

diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
index e32a7b439816..caf97f739897 100644
--- a/arch/mips/include/asm/dma-mapping.h
+++ b/arch/mips/include/asm/dma-mapping.h
@@ -10,12 +10,15 @@
 #include <dma-coherence.h>
 #endif
 
+extern const struct dma_map_ops jazz_dma_ops;
 extern const struct dma_map_ops mips_default_dma_map_ops;
 extern const struct dma_map_ops mips_swiotlb_ops;
 
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
-#ifdef CONFIG_SWIOTLB
+#if defined(CONFIG_MACH_JAZZ)
+	return &jazz_dma_ops;
+#elif defined(CONFIG_SWIOTLB)
 	return &mips_swiotlb_ops;
 #elif defined(CONFIG_MIPS_DMA_DEFAULT)
 	return &mips_default_dma_map_ops;
diff --git a/arch/mips/include/asm/mach-jazz/dma-coherence.h b/arch/mips/include/asm/mach-jazz/dma-coherence.h
deleted file mode 100644
index dc347c25c343..000000000000
--- a/arch/mips/include/asm/mach-jazz/dma-coherence.h
+++ /dev/null
@@ -1,60 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2006  Ralf Baechle <ralf@linux-mips.org>
- */
-#ifndef __ASM_MACH_JAZZ_DMA_COHERENCE_H
-#define __ASM_MACH_JAZZ_DMA_COHERENCE_H
-
-#include <asm/jazzdma.h>
-
-struct device;
-
-static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr, size_t size)
-{
-	return vdma_alloc(virt_to_phys(addr), size);
-}
-
-static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
-	struct page *page)
-{
-	return vdma_alloc(page_to_phys(page), PAGE_SIZE);
-}
-
-static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
-	dma_addr_t dma_addr)
-{
-	return vdma_log2phys(dma_addr);
-}
-
-static inline void plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr,
-	size_t size, enum dma_data_direction direction)
-{
-	vdma_free(dma_addr);
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
-static inline void plat_post_dma_flush(struct device *dev)
-{
-}
-
-static inline int plat_device_is_coherent(struct device *dev)
-{
-	return 0;
-}
-
-#endif /* __ASM_MACH_JAZZ_DMA_COHERENCE_H */
diff --git a/arch/mips/jazz/Kconfig b/arch/mips/jazz/Kconfig
index d3ae3e0356f6..06838f80a5d7 100644
--- a/arch/mips/jazz/Kconfig
+++ b/arch/mips/jazz/Kconfig
@@ -3,7 +3,6 @@ config ACER_PICA_61
 	bool "Support for Acer PICA 1 chipset"
 	depends on MACH_JAZZ
 	select DMA_NONCOHERENT
-	select MIPS_DMA_DEFAULT
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	help
 	  This is a machine with a R4400 133/150 MHz CPU. To compile a Linux
@@ -15,7 +14,6 @@ config MIPS_MAGNUM_4000
 	bool "Support for MIPS Magnum 4000"
 	depends on MACH_JAZZ
 	select DMA_NONCOHERENT
-	select MIPS_DMA_DEFAULT
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	help
@@ -28,7 +26,6 @@ config OLIVETTI_M700
 	bool "Support for Olivetti M700-10"
 	depends on MACH_JAZZ
 	select DMA_NONCOHERENT
-	select MIPS_DMA_DEFAULT
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	help
 	  This is a machine with a R4000 100 MHz CPU. To compile a Linux
diff --git a/arch/mips/jazz/jazzdma.c b/arch/mips/jazz/jazzdma.c
index d626a9a391cc..446fc8c92e1e 100644
--- a/arch/mips/jazz/jazzdma.c
+++ b/arch/mips/jazz/jazzdma.c
@@ -16,6 +16,8 @@
 #include <linux/bootmem.h>
 #include <linux/spinlock.h>
 #include <linux/gfp.h>
+#include <linux/dma-direct.h>
+#include <linux/dma-noncoherent.h>
 #include <asm/mipsregs.h>
 #include <asm/jazz.h>
 #include <asm/io.h>
@@ -86,6 +88,7 @@ static int __init vdma_init(void)
 	printk(KERN_INFO "VDMA: R4030 DMA pagetables initialized.\n");
 	return 0;
 }
+arch_initcall(vdma_init);
 
 /*
  * Allocate DMA pagetables using a simple first-fit algorithm
@@ -556,4 +559,140 @@ int vdma_get_enable(int channel)
 	return enable;
 }
 
-arch_initcall(vdma_init);
+static void *jazz_dma_alloc(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
+{
+	void *ret;
+
+	ret = dma_direct_alloc(dev, size, dma_handle, gfp, attrs);
+	if (!ret)
+		return NULL;
+
+	*dma_handle = vdma_alloc(virt_to_phys(ret), size);
+	if (*dma_handle == VDMA_ERROR) {
+		dma_direct_free(dev, size, ret, *dma_handle, attrs);
+		return NULL;
+	}
+
+	if (!(attrs & DMA_ATTR_NON_CONSISTENT)) {
+		dma_cache_wback_inv((unsigned long)ret, size);
+		ret = UNCAC_ADDR(ret);
+	}
+	return ret;
+}
+
+static void jazz_dma_free(struct device *dev, size_t size, void *vaddr,
+		dma_addr_t dma_handle, unsigned long attrs)
+{
+	vdma_free(dma_handle);
+	if (!(attrs & DMA_ATTR_NON_CONSISTENT))
+		vaddr = (void *)CAC_ADDR((unsigned long)vaddr);
+	return dma_direct_free(dev, size, vaddr, dma_handle, attrs);
+}
+
+static dma_addr_t jazz_dma_map_page(struct device *dev, struct page *page,
+		unsigned long offset, size_t size, enum dma_data_direction dir,
+		unsigned long attrs)
+{
+	phys_addr_t phys = page_to_phys(page) + offset;
+
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		arch_sync_dma_for_device(dev, phys, size, dir);
+	return vdma_alloc(phys, size);
+}
+
+static void jazz_dma_unmap_page(struct device *dev, dma_addr_t dma_addr,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
+{
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		arch_sync_dma_for_cpu(dev, vdma_log2phys(dma_addr), size, dir);
+	vdma_free(dma_addr);
+}
+
+static int jazz_dma_map_sg(struct device *dev, struct scatterlist *sglist,
+		int nents, enum dma_data_direction dir, unsigned long attrs)
+{
+	int i;
+	struct scatterlist *sg;
+
+	for_each_sg(sglist, sg, nents, i) {
+		if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+			arch_sync_dma_for_device(dev, sg_phys(sg), sg->length,
+				dir);
+		sg->dma_address = vdma_alloc(sg_phys(sg), sg->length);
+		if (sg->dma_address == VDMA_ERROR)
+			return 0;
+		sg_dma_len(sg) = sg->length;
+	}
+
+	return nents;
+}
+
+static void jazz_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
+		int nents, enum dma_data_direction dir, unsigned long attrs)
+{
+	int i;
+	struct scatterlist *sg;
+
+	for_each_sg(sglist, sg, nents, i) {
+		if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+			arch_sync_dma_for_cpu(dev, sg_phys(sg), sg->length,
+				dir);
+		vdma_free(sg->dma_address);
+	}
+}
+
+static void jazz_dma_sync_single_for_device(struct device *dev,
+		dma_addr_t addr, size_t size, enum dma_data_direction dir)
+{
+	arch_sync_dma_for_device(dev, vdma_log2phys(addr), size, dir);
+}
+
+static void jazz_dma_sync_single_for_cpu(struct device *dev,
+		dma_addr_t addr, size_t size, enum dma_data_direction dir)
+{
+	arch_sync_dma_for_cpu(dev, vdma_log2phys(addr), size, dir);
+}
+
+static void jazz_dma_sync_sg_for_device(struct device *dev,
+		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
+{
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(sgl, sg, nents, i)
+		arch_sync_dma_for_device(dev, sg_phys(sg), sg->length, dir);
+}
+
+static void jazz_dma_sync_sg_for_cpu(struct device *dev,
+		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
+{
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(sgl, sg, nents, i)
+		arch_sync_dma_for_cpu(dev, sg_phys(sg), sg->length, dir);
+}
+
+static int jazz_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
+{
+	return dma_addr == VDMA_ERROR;
+}
+
+const struct dma_map_ops jazz_dma_ops = {
+	.alloc			= jazz_dma_alloc,
+	.free			= jazz_dma_free,
+	.mmap			= arch_dma_mmap,
+	.map_page		= jazz_dma_map_page,
+	.unmap_page		= jazz_dma_unmap_page,
+	.map_sg			= jazz_dma_map_sg,
+	.unmap_sg		= jazz_dma_unmap_sg,
+	.sync_single_for_cpu	= jazz_dma_sync_single_for_cpu,
+	.sync_single_for_device	= jazz_dma_sync_single_for_device,
+	.sync_sg_for_cpu	= jazz_dma_sync_sg_for_cpu,
+	.sync_sg_for_device	= jazz_dma_sync_sg_for_device,
+	.dma_supported		= dma_direct_supported,
+	.cache_sync		= arch_dma_cache_sync,
+	.mapping_error		= jazz_dma_mapping_error,
+};
+EXPORT_SYMBOL(jazz_dma_ops);
-- 
2.17.1
