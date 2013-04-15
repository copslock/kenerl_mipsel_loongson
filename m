Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Apr 2013 14:50:20 +0200 (CEST)
Received: from mail-pd0-f181.google.com ([209.85.192.181]:55996 "EHLO
        mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835136Ab3DOMsHNQXZ2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Apr 2013 14:48:07 +0200
Received: by mail-pd0-f181.google.com with SMTP id y10so2471385pdj.40
        for <multiple recipients>; Mon, 15 Apr 2013 05:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=qfLJb6BJjCPeMoGHp6bA2AdLdqCt/9ZlP178SDXqDBI=;
        b=dznMQ5oEkCV7SJbV22zHfUKd071O5gvs3PcyyeAkDZUMiekGLTjv27pwIrZYgVnpm3
         I01cM/dJ3ILyO4c+7IBAKFSFr/lm9A5UQBirXezUjCr4Hj+KkZWLL688geOu1n/KSWxs
         tQXK+NKs9woPjQ/FNaoehJGqY6M6Of3wm/qqSlQLbMHqJfbtaZP0QAQa6FL649gUPMP4
         0pfLF9Zrp//ot1Y4q+oBoETzxFt+oxIv6wIcV8HGgS3zg/ycOTr/UUAVOcgWND6TgQep
         c1hhf0cNZaAqYm2DrKqoN6v2DbC1PdfTzeYC4TaTjpatfDp6UP7fy+zNjQApeFbT9xQo
         ODxA==
X-Received: by 10.67.2.68 with SMTP id bm4mr29743078pad.9.1366030080404;
        Mon, 15 Apr 2013 05:48:00 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id xz4sm20242580pbb.18.2013.04.15.05.47.56
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 15 Apr 2013 05:47:59 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH V10 09/13] MIPS: Loongson: Add swiotlb to support big memory (>4GB)
Date:   Mon, 15 Apr 2013 20:47:04 +0800
Message-Id: <1366030028-5084-10-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1366030028-5084-1-git-send-email-chenhc@lemote.com>
References: <1366030028-5084-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36190
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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
 .../mips/include/asm/mach-loongson/dma-coherence.h |   23 +++
 arch/mips/loongson/common/Makefile                 |    5 +
 arch/mips/loongson/common/dma-swiotlb.c            |  163 ++++++++++++++++++++
 4 files changed, 196 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/loongson/common/dma-swiotlb.c

diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
index f8fc74b..bf6eb83 100644
--- a/arch/mips/include/asm/dma-mapping.h
+++ b/arch/mips/include/asm/dma-mapping.h
@@ -48,9 +48,14 @@ static inline int dma_mapping_error(struct device *dev, u64 mask)
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
index e143305..3d752e8 100644
--- a/arch/mips/include/asm/mach-loongson/dma-coherence.h
+++ b/arch/mips/include/asm/mach-loongson/dma-coherence.h
@@ -11,18 +11,34 @@
 #ifndef __ASM_MACH_LOONGSON_DMA_COHERENCE_H
 #define __ASM_MACH_LOONGSON_DMA_COHERENCE_H
 
+#ifdef CONFIG_SWIOTLB
+#include <linux/swiotlb.h>
+#endif
+
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
@@ -30,6 +46,9 @@ static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
 {
 #if defined(CONFIG_CPU_LOONGSON2F) && defined(CONFIG_64BIT)
 	return (dma_addr > 0x8fffffff) ? dma_addr : (dma_addr & 0x0fffffff);
+#elif defined(CONFIG_CPU_LOONGSON3) && defined(CONFIG_64BIT)
+	return (dma_addr < 0x90000000 && dma_addr >= 0x80000000) ?
+			(dma_addr & 0x0fffffff) : dma_addr;
 #else
 	return dma_addr & 0x7fffffff;
 #endif
@@ -65,7 +84,11 @@ static inline int plat_dma_mapping_error(struct device *dev,
 
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
index 0000000..6741f1b
--- /dev/null
+++ b/arch/mips/loongson/common/dma-swiotlb.c
@@ -0,0 +1,163 @@
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
+	if (dev == NULL)
+		gfp |= __GFP_DMA32;
+	else if (dev->coherent_dma_mask <= DMA_BIT_MASK(32))
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
+	if (mask > DMA_BIT_MASK(32)) {
+		*dev->dma_mask = DMA_BIT_MASK(32);
+		return -EIO;
+	}
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
-- 
1.7.7.3
