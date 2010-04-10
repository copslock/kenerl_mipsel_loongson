From: Wu Zhangjin <wuzhangjin@gmail.com>
Date: Sun, 11 Apr 2010 03:58:13 +0800
Subject: [PATCH] MIPS: Implement dma_mmap_coherent() for ALSA audio output
Message-ID: <20100410195813.WQ5r42MJt2rSVm7Mmw7eilDuzxQwDAq34yypCybSd5Y@z>

A lazy version of dma_mmap_coherent() implementation for MIPS.

Without this patch, the ALSA sound output of MIPS is broken:

$ mplayer -ao alsa file.mp3

(This patch was sent out by Takashi Iwai at '18 Aug 2008' but not have
 been applied yet for it is not suitable for all MIPS variants. If you
 need more info, please access:
 http://www.linux-mips.org/archives/linux-mips/2008-08/msg00178.html)

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 arch/mips/include/asm/dma-mapping.h |    4 ++++
 arch/mips/mm/dma-default.c          |   13 +++++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
index 664ba53..c39bfdf 100644
--- a/arch/mips/include/asm/dma-mapping.h
+++ b/arch/mips/include/asm/dma-mapping.h
@@ -74,4 +74,8 @@ extern int dma_is_consistent(struct device *dev, dma_addr_t dma_addr);
 extern void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 	       enum dma_data_direction direction);
 
+#define ARCH_HAS_DMA_MMAP_COHERENT
+extern int dma_mmap_coherent(struct device *dev, struct vm_area_struct *vma,
+		void *cpu_addr, dma_addr_t handle, size_t size);
+
 #endif /* _ASM_DMA_MAPPING_H */
diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index 9547bc0..8388428 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -375,3 +375,16 @@ void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 }
 
 EXPORT_SYMBOL(dma_cache_sync);
+
+int __weak dma_mmap_coherent(struct device *dev, struct vm_area_struct *vma,
+		void *cpu_addr, dma_addr_t handle, size_t size)
+{
+	struct page *pg;
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	cpu_addr = (void *)dma_addr_to_virt(dev, handle);
+	pg = virt_to_page(cpu_addr);
+	return remap_pfn_range(vma, vma->vm_start,
+		       page_to_pfn(pg) + vma->vm_pgoff,
+		       size, vma->vm_page_prot);
+}
+EXPORT_SYMBOL(dma_mmap_coherent);
-- 
1.7.0


--=-MOmtyQD51rQcYat/yaYI--
