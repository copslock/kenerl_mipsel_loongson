Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jun 2012 05:06:13 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:58657 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903664Ab2FVDEn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Jun 2012 05:04:43 +0200
Received: by mail-pb0-f49.google.com with SMTP id rq13so3158172pbb.36
        for <multiple recipients>; Thu, 21 Jun 2012 20:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=KFY5k/DkbKXBMn0V/Hr3HLC7S2aeKEjVgOOjHvJk2po=;
        b=sDlh1iDi9HLYw56/mZi+ihkmnFqYFy8QhFinWPbVD1sbXOuJOm52tETbwmaensGoYk
         HjBoAfxV4FZ7DCnj1Oqu24DV816zKYIQVWm1HRU+nTvewoo+dINN8kZmaP/kUxFD1p3e
         ndaywytgT01ly6XV/vA2GgQ2q+psZTCx7958vasOmwL8P9MyGN6DMQGgreMd0Jyru34t
         8Isg+YWCpkoMrCm3U4AelMgt8x8N7cQxYFW1jw7iC1TTniRyx82cmHz7jozqSmv6uCOp
         gPImUwkLap9ZpnvS4bvw0tP+mglu9ZZiBzynyFp4JmwfFfhPRDRPdLzb3Y2GZ8Dl/D7S
         g7vg==
Received: by 10.68.218.103 with SMTP id pf7mr5419034pbc.67.1340334282461;
        Thu, 21 Jun 2012 20:04:42 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id wk3sm37516519pbc.21.2012.06.21.20.04.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 21 Jun 2012 20:04:41 -0700 (PDT)
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH V3 09/16] MIPS: Loongson: Add swiotlb to support big memory (>4GB).
Date:   Fri, 22 Jun 2012 11:01:06 +0800
Message-Id: <1340334073-17804-10-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1340334073-17804-1-git-send-email-chenhc@lemote.com>
References: <1340334073-17804-1-git-send-email-chenhc@lemote.com>
X-archive-position: 33766
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhuacai@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

This is probably a workaround because Loongson doesn't support DMA
address above 4GB. If memory is more than 4GB, CONFIG_SWIOTLB and
ZONE_DMA32 should be selected. In this way, DMA pages are allocated
below 4GB preferably.

However, CONFIG_SWIOTLB+ZONE_DMA32 is not enough, so, we provide a
platform-specific dma_map_ops::set_dma_mask() to make sure each
driver's dma_mask and coherent_dma_mask is below 32-bit.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
Signed-off-by: Hua Yan <yanh@lemote.com>
---
 arch/mips/include/asm/dma-mapping.h                |    5 +
 .../mips/include/asm/mach-loongson/dma-coherence.h |   25 +++-
 arch/mips/loongson/common/Makefile                 |    5 +
 arch/mips/loongson/common/dma-swiotlb.c            |  159 ++++++++++++++++++++
 arch/mips/mm/dma-default.c                         |   13 ++-
 5 files changed, 202 insertions(+), 5 deletions(-)
 create mode 100644 arch/mips/loongson/common/dma-swiotlb.c

diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
index be39a12..35f91bc 100644
--- a/arch/mips/include/asm/dma-mapping.h
+++ b/arch/mips/include/asm/dma-mapping.h
@@ -46,9 +46,14 @@ static inline int dma_mapping_error(struct device *dev, u64 mask)
 static inline int
 dma_set_mask(struct device *dev, u64 mask)
 {
+	struct dma_map_ops *ops = get_dma_ops(dev);
+
 	if(!dev->dma_mask || !dma_supported(dev, mask))
 		return -EIO;
 
+	if (ops->set_dma_mask)
+		return ops->set_dma_mask(dev, mask);
+
 	*dev->dma_mask = mask;
 
 	return 0;
diff --git a/arch/mips/include/asm/mach-loongson/dma-coherence.h b/arch/mips/include/asm/mach-loongson/dma-coherence.h
index e143305..b1dc286 100644
--- a/arch/mips/include/asm/mach-loongson/dma-coherence.h
+++ b/arch/mips/include/asm/mach-loongson/dma-coherence.h
@@ -13,26 +13,43 @@
 
 struct device;
 
+extern dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr);
+extern phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr);
 static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
 					  size_t size)
 {
+#ifdef CONFIG_CPU_LOONGSON3
+	return virt_to_phys(addr) < 0x10000000 ?
+			(virt_to_phys(addr) | 0x0000000080000000) : virt_to_phys(addr);
+#else
 	return virt_to_phys(addr) | 0x80000000;
+#endif
 }
 
 static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
 					       struct page *page)
 {
+#ifdef CONFIG_CPU_LOONGSON3
+	return page_to_phys(page) < 0x10000000 ?
+			(page_to_phys(page) | 0x0000000080000000) : page_to_phys(page);
+#else
 	return page_to_phys(page) | 0x80000000;
+#endif
 }
 
 static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
 	dma_addr_t dma_addr)
 {
-#if defined(CONFIG_CPU_LOONGSON2F) && defined(CONFIG_64BIT)
+#if defined(CONFIG_64BIT)
+#if defined(CONFIG_CPU_LOONGSON3)
+	return (dma_addr < 0x90000000 && dma_addr >= 0x80000000) ?
+			(dma_addr & 0x0fffffff) : dma_addr;
+#elif defined(CONFIG_CPU_LOONGSON2F)
 	return (dma_addr > 0x8fffffff) ? dma_addr : (dma_addr & 0x0fffffff);
+#endif /* CONFIG_CPU_LOONGSON3 */
 #else
 	return dma_addr & 0x7fffffff;
-#endif
+#endif /* CONFIG_64BIT */
 }
 
 static inline void plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr,
@@ -65,7 +82,11 @@ static inline int plat_dma_mapping_error(struct device *dev,
 
 static inline int plat_device_is_coherent(struct device *dev)
 {
+#ifdef CONFIG_DMA_NONCOHERENT
 	return 0;
+#else
+	return 1;
+#endif /* CONFIG_DMA_NONCOHERENT */
 }
 
 #endif /* __ASM_MACH_LOONGSON_DMA_COHERENCE_H */
diff --git a/arch/mips/loongson/common/Makefile b/arch/mips/loongson/common/Makefile
index e526488..3a26109 100644
--- a/arch/mips/loongson/common/Makefile
+++ b/arch/mips/loongson/common/Makefile
@@ -25,3 +25,8 @@ obj-$(CONFIG_CS5536) += cs5536/
 #
 
 obj-$(CONFIG_LOONGSON_SUSPEND) += pm.o
+
+#
+# Big Memory Support
+#
+obj-$(CONFIG_LOONGSON_BIGMEM) += dma-swiotlb.o
diff --git a/arch/mips/loongson/common/dma-swiotlb.c b/arch/mips/loongson/common/dma-swiotlb.c
new file mode 100644
index 0000000..b87a21e
--- /dev/null
+++ b/arch/mips/loongson/common/dma-swiotlb.c
@@ -0,0 +1,159 @@
+#include <linux/mm.h>
+#include <linux/init.h>
+#include <linux/dma-mapping.h>
+#include <linux/scatterlist.h>
+#include <linux/swiotlb.h>
+#include <linux/bootmem.h>
+
+#include <asm/bootinfo.h>
+#include <dma-coherence.h>
+
+static void *loongson_dma_alloc_coherent(struct device *dev, size_t size,
+				dma_addr_t *dma_handle, gfp_t gfp, struct dma_attrs *attrs)
+{
+	void *ret;
+
+	if (dma_alloc_from_coherent(dev, size, dma_handle, &ret))
+		return ret;
+
+	/* ignore region specifiers */
+	gfp &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
+
+#ifdef CONFIG_ZONE_DMA
+	if (dev == NULL)
+		gfp |= __GFP_DMA;
+	else if (dev->coherent_dma_mask <= DMA_BIT_MASK(24))
+		gfp |= __GFP_DMA;
+	else
+#endif
+#ifdef CONFIG_ZONE_DMA32
+	if (dev->coherent_dma_mask <= DMA_BIT_MASK(32))
+		gfp |= __GFP_DMA32;
+	else
+#endif
+	;
+	gfp |= __GFP_NORETRY;
+
+	ret = swiotlb_alloc_coherent(dev, size, dma_handle, gfp);
+	mb();
+	return ret;
+}
+
+static void loongson_dma_free_coherent(struct device *dev, size_t size,
+				void *vaddr, dma_addr_t dma_handle, struct dma_attrs *attrs)
+{
+	int order = get_order(size);
+
+	if (dma_release_from_coherent(dev, order, vaddr))
+		return;
+
+	swiotlb_free_coherent(dev, size, vaddr, dma_handle);
+}
+
+static dma_addr_t loongson_dma_map_page(struct device *dev, struct page *page,
+				unsigned long offset, size_t size,
+				enum dma_data_direction dir,
+				struct dma_attrs *attrs)
+{
+	dma_addr_t daddr = swiotlb_map_page(dev, page, offset, size,
+					dir, attrs);
+	mb();
+	return daddr;
+}
+
+static int loongson_dma_map_sg(struct device *dev, struct scatterlist *sg,
+				int nents, enum dma_data_direction dir,
+				struct dma_attrs *attrs)
+{
+	int r = swiotlb_map_sg_attrs(dev, sg, nents, dir, NULL);
+	mb();
+
+	return r;
+}
+
+static void loongson_dma_sync_single_for_device(struct device *dev,
+				dma_addr_t dma_handle, size_t size,
+				enum dma_data_direction dir)
+{
+	swiotlb_sync_single_for_device(dev, dma_handle, size, dir);
+	mb();
+}
+
+static void loongson_dma_sync_sg_for_device(struct device *dev,
+				struct scatterlist *sg, int nents,
+				enum dma_data_direction dir)
+{
+	swiotlb_sync_sg_for_device(dev, sg, nents, dir);
+	mb();
+}
+
+static dma_addr_t loongson_unity_phys_to_dma(struct device *dev, phys_addr_t paddr)
+{
+	return (paddr < 0x10000000) ?
+			(paddr | 0x0000000080000000) : paddr;
+}
+
+static phys_addr_t loongson_unity_dma_to_phys(struct device *dev, dma_addr_t daddr)
+{
+	return (daddr < 0x90000000 && daddr >= 0x80000000) ?
+			(daddr & 0x0fffffff) : daddr;
+}
+
+struct loongson_dma_map_ops {
+	struct dma_map_ops dma_map_ops;
+	dma_addr_t (*phys_to_dma)(struct device *dev, phys_addr_t paddr);
+	phys_addr_t (*dma_to_phys)(struct device *dev, dma_addr_t daddr);
+};
+
+dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
+{
+	struct loongson_dma_map_ops *ops = container_of(get_dma_ops(dev),
+					struct loongson_dma_map_ops, dma_map_ops);
+
+	return ops->phys_to_dma(dev, paddr);
+}
+
+phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
+{
+	struct loongson_dma_map_ops *ops = container_of(get_dma_ops(dev),
+					struct loongson_dma_map_ops, dma_map_ops);
+
+	return ops->dma_to_phys(dev, daddr);
+}
+
+static int loongson_dma_set_mask(struct device *dev, u64 mask)
+{
+	/* Loongson doesn't support DMA above 32-bit */
+	if (mask > DMA_BIT_MASK(32))
+		return -EIO;
+
+	*dev->dma_mask = mask;
+
+	return 0;
+}
+
+static struct loongson_dma_map_ops loongson_linear_dma_map_ops = {
+	.dma_map_ops = {
+		.alloc = loongson_dma_alloc_coherent,
+		.free = loongson_dma_free_coherent,
+		.map_page = loongson_dma_map_page,
+		.unmap_page = swiotlb_unmap_page,
+		.map_sg = loongson_dma_map_sg,
+		.unmap_sg = swiotlb_unmap_sg_attrs,
+		.sync_single_for_cpu = swiotlb_sync_single_for_cpu,
+		.sync_single_for_device = loongson_dma_sync_single_for_device,
+		.sync_sg_for_cpu = swiotlb_sync_sg_for_cpu,
+		.sync_sg_for_device = loongson_dma_sync_sg_for_device,
+		.mapping_error = swiotlb_dma_mapping_error,
+		.dma_supported = swiotlb_dma_supported,
+		.set_dma_mask = loongson_dma_set_mask
+	},
+	.phys_to_dma = loongson_unity_phys_to_dma,
+	.dma_to_phys = loongson_unity_dma_to_phys
+};
+
+void __init plat_swiotlb_setup(void)
+{
+	swiotlb_init(1);
+	mips_dma_map_ops = &loongson_linear_dma_map_ops.dma_map_ops;
+}
diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index 3fab204..122f4f8 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -42,6 +42,13 @@ static inline int cpu_is_noncoherent_r10000(struct device *dev)
 	       current_cpu_type() == CPU_R12000);
 }
 
+static inline int cpu_is_noncoherent_loongson(struct device *dev)
+{
+	return !plat_device_is_coherent(dev) &&
+			(current_cpu_type() == CPU_LOONGSON2 ||
+			 current_cpu_type() == CPU_LOONGSON3);
+}
+
 static gfp_t massage_gfp_flags(const struct device *dev, gfp_t gfp)
 {
 	gfp_t dma_flag;
@@ -209,7 +216,7 @@ static inline void __dma_sync(struct page *page,
 static void mips_dma_unmap_page(struct device *dev, dma_addr_t dma_addr,
 	size_t size, enum dma_data_direction direction, struct dma_attrs *attrs)
 {
-	if (cpu_is_noncoherent_r10000(dev))
+	if (cpu_is_noncoherent_r10000(dev) || cpu_is_noncoherent_loongson(dev))
 		__dma_sync(dma_addr_to_page(dev, dma_addr),
 			   dma_addr & ~PAGE_MASK, size, direction);
 
@@ -260,7 +267,7 @@ static void mips_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 static void mips_dma_sync_single_for_cpu(struct device *dev,
 	dma_addr_t dma_handle, size_t size, enum dma_data_direction direction)
 {
-	if (cpu_is_noncoherent_r10000(dev))
+	if (cpu_is_noncoherent_r10000(dev) || cpu_is_noncoherent_loongson(dev))
 		__dma_sync(dma_addr_to_page(dev, dma_handle),
 			   dma_handle & ~PAGE_MASK, size, direction);
 }
@@ -281,7 +288,7 @@ static void mips_dma_sync_sg_for_cpu(struct device *dev,
 
 	/* Make sure that gcc doesn't leave the empty loop body.  */
 	for (i = 0; i < nelems; i++, sg++) {
-		if (cpu_is_noncoherent_r10000(dev))
+		if (cpu_is_noncoherent_r10000(dev) || cpu_is_noncoherent_loongson(dev))
 			__dma_sync(sg_page(sg), sg->offset, sg->length,
 				   direction);
 	}
-- 
1.7.7.3
