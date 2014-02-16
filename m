Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Feb 2014 09:06:16 +0100 (CET)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:34924 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6869248AbaBPIEVXqHu6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 16 Feb 2014 09:04:21 +0100
Received: by mail-pb0-f49.google.com with SMTP id up15so13938774pbc.8
        for <multiple recipients>; Sun, 16 Feb 2014 00:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+xtiGw+VPjCShqDfexWsQZFyIaFq/+kYxUkZSpEUOyE=;
        b=j2A0bVAJ6HqaazpaJ4Bo797SIuYW/91f7JCqoNyZhgl/08s8Bih4UdPDY0WR/lSsCX
         qCrC9/z8KNdyjOLSMU/YD8f176ELNgfbZ8UkkMkG75LnTyCu62W+VgudEX94H/8m6dnA
         Ooukb0dONXDC2Tkun7CIgiIxw1X7GeXBDImS8DDZRYK3kHF3SDIuzaMovnm3de1c85aG
         WjPzn6QcQN7m/4xad27P1bda4e/k3M/O5AG3Fk2JIWR4h6tNCqG2RoOZWO1jqV+fFjZ7
         p6xDlEANy3epovVTK6LluGMgWy7n0gBmz4Qv9LQGI8wBlrfuY6mI3lmkcSsDiXXNvmyk
         9Jxw==
X-Received: by 10.66.50.105 with SMTP id b9mr19463356pao.9.1392537853306;
        Sun, 16 Feb 2014 00:04:13 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id ei4sm33661111pbb.42.2014.02.16.00.04.02
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 16 Feb 2014 00:04:12 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH V19 09/13] MIPS: Loongson: Add swiotlb to support All-Memory DMA
Date:   Sun, 16 Feb 2014 16:01:26 +0800
Message-Id: <1392537690-5961-10-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1392537690-5961-1-git-send-email-chenhc@lemote.com>
References: <1392537690-5961-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39320
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

Loongson doesn't support DMA address above 4GB traditionally. If memory
is more than 4GB, CONFIG_SWIOTLB and ZONE_DMA32 should be selected. In
this way, DMA pages are allocated below 4GB preferably. However, if low
memory is not enough, high pages are allocated and swiotlb is used for
bouncing.

Moreover, we provide a platform-specific dma_map_ops::set_dma_mask() to
set a device's dma_mask and coherent_dma_mask. We use these masks to
distinguishes an allocated page can be used for DMA directly, or need
swiotlb to bounce.

Recently, we found that 32-bit DMA isn't a hardware bug, but a hardware
configuration issue. So, latest firmware has enable the DMA support as
high as 40-bit. To support all-memory DMA for all devices (besides the
Loongson platform limit, there are still some devices have their own
DMA32 limit), and also to be compatible with old firmware, we keep use
swiotlb.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
Signed-off-by: Hua Yan <yanh@lemote.com>
Tested-by: Alex Smith <alex.smith@imgtec.com>
Reviewed-by: Alex Smith <alex.smith@imgtec.com>
---
 arch/mips/include/asm/dma-mapping.h                |    5 +
 .../mips/include/asm/mach-loongson/dma-coherence.h |   22 +++-
 arch/mips/loongson/common/Makefile                 |    5 +
 arch/mips/loongson/common/dma-swiotlb.c            |  136 ++++++++++++++++++++
 4 files changed, 167 insertions(+), 1 deletions(-)
 create mode 100644 arch/mips/loongson/common/dma-swiotlb.c

diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
index 84238c5..06412aa 100644
--- a/arch/mips/include/asm/dma-mapping.h
+++ b/arch/mips/include/asm/dma-mapping.h
@@ -49,9 +49,14 @@ static inline int dma_mapping_error(struct device *dev, u64 mask)
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
index aeb2c05..6a90275 100644
--- a/arch/mips/include/asm/mach-loongson/dma-coherence.h
+++ b/arch/mips/include/asm/mach-loongson/dma-coherence.h
@@ -11,24 +11,40 @@
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
+	return virt_to_phys(addr);
+#else
 	return virt_to_phys(addr) | 0x80000000;
+#endif
 }
 
 static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
 					       struct page *page)
 {
+#ifdef CONFIG_CPU_LOONGSON3
+	return page_to_phys(page);
+#else
 	return page_to_phys(page) | 0x80000000;
+#endif
 }
 
 static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
 	dma_addr_t dma_addr)
 {
-#if defined(CONFIG_CPU_LOONGSON2F) && defined(CONFIG_64BIT)
+#if defined(CONFIG_CPU_LOONGSON3) && defined(CONFIG_64BIT)
+	return dma_addr;
+#elif defined(CONFIG_CPU_LOONGSON2F) && defined(CONFIG_64BIT)
 	return (dma_addr > 0x8fffffff) ? dma_addr : (dma_addr & 0x0fffffff);
 #else
 	return dma_addr & 0x7fffffff;
@@ -55,7 +71,11 @@ static inline int plat_dma_supported(struct device *dev, u64 mask)
 
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
index 9e4484c..0bb9cc9 100644
--- a/arch/mips/loongson/common/Makefile
+++ b/arch/mips/loongson/common/Makefile
@@ -26,3 +26,8 @@ obj-$(CONFIG_CS5536) += cs5536/
 #
 
 obj-$(CONFIG_LOONGSON_SUSPEND) += pm.o
+
+#
+# Big Memory (SWIOTLB) Support
+#
+obj-$(CONFIG_SWIOTLB) += dma-swiotlb.o
diff --git a/arch/mips/loongson/common/dma-swiotlb.c b/arch/mips/loongson/common/dma-swiotlb.c
new file mode 100644
index 0000000..c2be01f
--- /dev/null
+++ b/arch/mips/loongson/common/dma-swiotlb.c
@@ -0,0 +1,136 @@
+#include <linux/mm.h>
+#include <linux/init.h>
+#include <linux/dma-mapping.h>
+#include <linux/scatterlist.h>
+#include <linux/swiotlb.h>
+#include <linux/bootmem.h>
+
+#include <asm/bootinfo.h>
+#include <boot_param.h>
+#include <dma-coherence.h>
+
+static void *loongson_dma_alloc_coherent(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t gfp, struct dma_attrs *attrs)
+{
+	void *ret;
+
+	if (dma_alloc_from_coherent(dev, size, dma_handle, &ret))
+		return ret;
+
+	/* ignore region specifiers */
+	gfp &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
+
+#ifdef CONFIG_ISA
+	if (dev == NULL)
+		gfp |= __GFP_DMA;
+	else
+#endif
+#ifdef CONFIG_ZONE_DMA
+	if (dev->coherent_dma_mask < DMA_BIT_MASK(32))
+		gfp |= __GFP_DMA;
+	else
+#endif
+#ifdef CONFIG_ZONE_DMA32
+	if (dev->coherent_dma_mask < DMA_BIT_MASK(40))
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
+		void *vaddr, dma_addr_t dma_handle, struct dma_attrs *attrs)
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
+static int loongson_dma_set_mask(struct device *dev, u64 mask)
+{
+	if (mask > DMA_BIT_MASK(loongson_sysconf.dma_mask_bits)) {
+		*dev->dma_mask = DMA_BIT_MASK(loongson_sysconf.dma_mask_bits);
+		return -EIO;
+	}
+
+	*dev->dma_mask = mask;
+
+	return 0;
+}
+
+dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
+{
+	return paddr;
+}
+
+phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
+{
+	return daddr;
+}
+
+static struct dma_map_ops loongson_dma_map_ops = {
+	.alloc = loongson_dma_alloc_coherent,
+	.free = loongson_dma_free_coherent,
+	.map_page = loongson_dma_map_page,
+	.unmap_page = swiotlb_unmap_page,
+	.map_sg = loongson_dma_map_sg,
+	.unmap_sg = swiotlb_unmap_sg_attrs,
+	.sync_single_for_cpu = swiotlb_sync_single_for_cpu,
+	.sync_single_for_device = loongson_dma_sync_single_for_device,
+	.sync_sg_for_cpu = swiotlb_sync_sg_for_cpu,
+	.sync_sg_for_device = loongson_dma_sync_sg_for_device,
+	.mapping_error = swiotlb_dma_mapping_error,
+	.dma_supported = swiotlb_dma_supported,
+	.set_dma_mask = loongson_dma_set_mask
+};
+
+void __init plat_swiotlb_setup(void)
+{
+	swiotlb_init(1);
+	mips_dma_map_ops = &loongson_dma_map_ops;
+}
-- 
1.7.7.3
