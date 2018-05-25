Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 May 2018 11:25:55 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:51184 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993087AbeEYJWLhhsAA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 May 2018 11:22:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SDLBK0xwANvco90WEUv/vFOZ7yqpFepMDtj54NAQjkk=; b=YX1IwNFnhUB86F7foY2iBqk/s
        2UYz/0Ef4wCx8o/Vl8vgui1+vaEHSiYe/rKgHAPuI+RdHQGyHWe0DGMrnDtTvdjEsmtg/v0Svze47
        og7pqzXlryTL3X8jRo1pJYsLagvYBB+cAzMxd1+gvhEh31FQ37jxTmpHx7qto/j5ilNHzNj3/I1HS
        FWJRZ+2VIuTPpzf+evm19QASXfgkaCuxLSVibNpwbt616Ycq8A3HDHSVc9g7fXjD6v8l/drKRshg0
        DpNUixv9h1RSwIoQwejph68RpIxkniYfvuoMVsCs60UILdIuO+pVajVPzKVHyuzTkIyGuXFkvXY21
        cnokeibLw==;
Received: from 80-109-164-210.cable.dynamic.surfer.at ([80.109.164.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fM8vJ-0001xC-Nf; Fri, 25 May 2018 09:22:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        David Daney <david.daney@cavium.com>,
        Tom Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org, iommu@lists.linux-foundation.org
Subject: [PATCH 17/25] MIPS: use generic dma noncoherent ops for simple noncoherent platforms
Date:   Fri, 25 May 2018 11:21:03 +0200
Message-Id: <20180525092111.18516-18-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180525092111.18516-1-hch@lst.de>
References: <20180525092111.18516-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+5cb9c4fab7748cb05a15+5388+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64030
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

Convert everything not overriding dma-coherence.h to the generic
noncoherent ops.  The new dma-noncoherent.c file duplicates a lot of
the code in dma-default.c, but that file will be gone by the end of
this series.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/Kconfig                   |  24 +---
 arch/mips/include/asm/dma-mapping.h |   2 +
 arch/mips/loongson32/Kconfig        |   2 -
 arch/mips/mm/Makefile               |   1 +
 arch/mips/mm/dma-noncoherent.c      | 208 ++++++++++++++++++++++++++++
 arch/mips/pic32/Kconfig             |   1 -
 arch/mips/txx9/Kconfig              |   1 -
 arch/mips/vr41xx/Kconfig            |   5 -
 8 files changed, 216 insertions(+), 28 deletions(-)
 create mode 100644 arch/mips/mm/dma-noncoherent.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 934696595ad6..b39b430c92a3 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -96,7 +96,6 @@ config MIPS_GENERIC
 	select IRQ_MIPS_CPU
 	select LIBFDT
 	select MIPS_CPU_SCACHE
-	select MIPS_DMA_DEFAULT
 	select MIPS_GIC
 	select MIPS_L1_CACHE_SHIFT_7
 	select NO_EXCEPT_FILL
@@ -140,7 +139,6 @@ config MIPS_ALCHEMY
 	select CEVT_R4K
 	select CSRC_R4K
 	select IRQ_MIPS_CPU
-	select MIPS_DMA_DEFAULT
 	select DMA_MAYBE_COHERENT	# Au1000,1500,1100 aren't, rest is
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_SUPPORTS_32BIT_KERNEL
@@ -156,7 +154,6 @@ config AR7
 	select CEVT_R4K
 	select CSRC_R4K
 	select IRQ_MIPS_CPU
-	select MIPS_DMA_DEFAULT
 	select NO_EXCEPT_FILL
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_MIPS32_R1
@@ -199,7 +196,6 @@ config ATH79
 	select COMMON_CLK
 	select CLKDEV_LOOKUP
 	select IRQ_MIPS_CPU
-	select MIPS_DMA_DEFAULT
 	select MIPS_MACHINE
 	select SYS_HAS_CPU_MIPS32_R2
 	select SYS_HAS_EARLY_PRINTK
@@ -257,7 +253,6 @@ config BCM47XX
 	select HW_HAS_PCI
 	select IRQ_MIPS_CPU
 	select SYS_HAS_CPU_MIPS32_R1
-	select MIPS_DMA_DEFAULT
 	select NO_EXCEPT_FILL
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
@@ -281,7 +276,6 @@ config BCM63XX
 	select SYNC_R4K
 	select DMA_NONCOHERENT
 	select IRQ_MIPS_CPU
-	select MIPS_DMA_DEFAULT
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_HAS_EARLY_PRINTK
@@ -304,7 +298,6 @@ config MIPS_COBALT
 	select I8259
 	select IRQ_MIPS_CPU
 	select IRQ_GT641XX
-	select MIPS_DMA_DEFAULT
 	select PCI_GT64XXX_PCI0
 	select PCI
 	select SYS_HAS_CPU_NEVADA
@@ -325,7 +318,6 @@ config MACH_DECSTATION
 	select CPU_R4000_WORKAROUNDS if 64BIT
 	select CPU_R4400_WORKAROUNDS if 64BIT
 	select DMA_NONCOHERENT
-	select MIPS_DMA_DEFAULT
 	select NO_IOPORT_MAP
 	select IRQ_MIPS_CPU
 	select SYS_HAS_CPU_R3000
@@ -385,7 +377,6 @@ config MACH_INGENIC
 	select SYS_SUPPORTS_ZBOOT_UART16550
 	select DMA_NONCOHERENT
 	select IRQ_MIPS_CPU
-	select MIPS_DMA_DEFAULT
 	select PINCTRL
 	select GPIOLIB
 	select COMMON_CLK
@@ -400,7 +391,6 @@ config LANTIQ
 	select IRQ_MIPS_CPU
 	select CEVT_R4K
 	select CSRC_R4K
-	select MIPS_DMA_DEFAULT
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_HAS_CPU_MIPS32_R2
 	select SYS_SUPPORTS_BIG_ENDIAN
@@ -428,7 +418,6 @@ config LASAT
 	select SYS_HAS_EARLY_PRINTK
 	select HW_HAS_PCI
 	select IRQ_MIPS_CPU
-	select MIPS_DMA_DEFAULT
 	select PCI_GT64XXX_PCI0
 	select MIPS_NILE4
 	select R5000_CPU_SCACHE
@@ -474,7 +463,6 @@ config MACH_PISTACHIO
 	select LIBFDT
 	select MFD_SYSCON
 	select MIPS_CPU_SCACHE
-	select MIPS_DMA_DEFAULT
 	select MIPS_GIC
 	select PINCTRL
 	select REGULATOR
@@ -507,7 +495,6 @@ config MIPS_MALTA
 	select GENERIC_ISA_DMA
 	select HAVE_PCSPKR_PLATFORM
 	select IRQ_MIPS_CPU
-	select MIPS_DMA_DEFAULT
 	select MIPS_GIC
 	select HW_HAS_PCI
 	select I8253
@@ -602,7 +589,6 @@ config PMC_MSP
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_MIPS16
 	select IRQ_MIPS_CPU
-	select MIPS_DMA_DEFAULT
 	select SERIAL_8250
 	select SERIAL_8250_CONSOLE
 	select USB_EHCI_BIG_ENDIAN_MMIO
@@ -620,7 +606,6 @@ config RALINK
 	select BOOT_RAW
 	select DMA_NONCOHERENT
 	select IRQ_MIPS_CPU
-	select MIPS_DMA_DEFAULT
 	select USE_OF
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_HAS_CPU_MIPS32_R2
@@ -647,7 +632,6 @@ config SGI_IP22
 	select I8259
 	select IP22_CPU_SCACHE
 	select IRQ_MIPS_CPU
-	select MIPS_DMA_DEFAULT
 	select GENERIC_ISA_DMA_SUPPORT_BROKEN
 	select SGI_HAS_I8042
 	select SGI_HAS_INDYDOG
@@ -708,7 +692,6 @@ config SGI_IP28
 	select DMA_NONCOHERENT
 	select GENERIC_ISA_DMA_SUPPORT_BROKEN
 	select IRQ_MIPS_CPU
-	select MIPS_DMA_DEFAULT
 	select HW_HAS_EISA
 	select I8253
 	select I8259
@@ -859,7 +842,6 @@ config SNI_RM
 	select I8253
 	select I8259
 	select ISA
-	select MIPS_DMA_DEFAULT
 	select SWAP_IO_SPACE if CPU_BIG_ENDIAN
 	select SYS_HAS_CPU_R4X00
 	select SYS_HAS_CPU_R5000
@@ -890,7 +872,6 @@ config MIKROTIK_RB532
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select IRQ_MIPS_CPU
-	select MIPS_DMA_DEFAULT
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
@@ -1127,7 +1108,12 @@ config DMA_PERDEV_COHERENT
 
 config DMA_NONCOHERENT
 	bool
+	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select NEED_DMA_MAP_STATE
+	select DMA_NONCOHERENT_MMAP
+	select DMA_NONCOHERENT_CACHE_SYNC
+	select DMA_NONCOHERENT_OPS if !MIPS_DMA_DEFAULT
 
 config SYS_HAS_EARLY_PRINTK
 	bool
diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
index 7c0d4f0ccaa0..e32a7b439816 100644
--- a/arch/mips/include/asm/dma-mapping.h
+++ b/arch/mips/include/asm/dma-mapping.h
@@ -19,6 +19,8 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return &mips_swiotlb_ops;
 #elif defined(CONFIG_MIPS_DMA_DEFAULT)
 	return &mips_default_dma_map_ops;
+#elif defined(CONFIG_DMA_NONCOHERENT_OPS)
+	return &dma_noncoherent_ops;
 #else
 	return &dma_direct_ops;
 #endif
diff --git a/arch/mips/loongson32/Kconfig b/arch/mips/loongson32/Kconfig
index 7a69a6c0ce22..462b126f45aa 100644
--- a/arch/mips/loongson32/Kconfig
+++ b/arch/mips/loongson32/Kconfig
@@ -10,7 +10,6 @@ config LOONGSON1_LS1B
 	select CSRC_R4K if !MIPS_EXTERNAL_TIMER
 	select SYS_HAS_CPU_LOONGSON1B
 	select DMA_NONCOHERENT
-	select MIPS_DMA_DEFAULT
 	select BOOT_ELF32
 	select IRQ_MIPS_CPU
 	select SYS_SUPPORTS_32BIT_KERNEL
@@ -27,7 +26,6 @@ config LOONGSON1_LS1C
 	select CSRC_R4K if !MIPS_EXTERNAL_TIMER
 	select SYS_HAS_CPU_LOONGSON1C
 	select DMA_NONCOHERENT
-	select MIPS_DMA_DEFAULT
 	select BOOT_ELF32
 	select IRQ_MIPS_CPU
 	select SYS_SUPPORTS_32BIT_KERNEL
diff --git a/arch/mips/mm/Makefile b/arch/mips/mm/Makefile
index 038bfed34946..c6146c3805dc 100644
--- a/arch/mips/mm/Makefile
+++ b/arch/mips/mm/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_64BIT)		+= pgtable-64.o
 obj-$(CONFIG_HIGHMEM)		+= highmem.o
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
 obj-$(CONFIG_MIPS_DMA_DEFAULT)	+= dma-default.o
+obj-$(CONFIG_DMA_NONCOHERENT)	+= dma-noncoherent.o
 obj-$(CONFIG_SWIOTLB)		+= dma-swiotlb.o
 
 obj-$(CONFIG_CPU_R4K_CACHE_TLB) += c-r4k.o cex-gen.o tlb-r4k.o
diff --git a/arch/mips/mm/dma-noncoherent.c b/arch/mips/mm/dma-noncoherent.c
new file mode 100644
index 000000000000..25edf6d6b686
--- /dev/null
+++ b/arch/mips/mm/dma-noncoherent.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2000  Ani Joshi <ajoshi@unixbox.com>
+ * Copyright (C) 2000, 2001, 06	 Ralf Baechle <ralf@linux-mips.org>
+ * swiped from i386, and cloned for MIPS by Geert, polished by Ralf.
+ */
+#include <linux/dma-direct.h>
+#include <linux/dma-noncoherent.h>
+#include <linux/dma-contiguous.h>
+#include <linux/highmem.h>
+
+#include <asm/cache.h>
+#include <asm/cpu-type.h>
+#include <asm/dma-coherence.h>
+#include <asm/io.h>
+
+#ifdef CONFIG_DMA_PERDEV_COHERENT
+static inline int dev_is_coherent(struct device *dev)
+{
+	return dev->archdata.dma_coherent;
+}
+#else
+static inline int dev_is_coherent(struct device *dev)
+{
+	switch (coherentio) {
+	default:
+	case IO_COHERENCE_DEFAULT:
+		return hw_coherentio;
+	case IO_COHERENCE_ENABLED:
+		return 1;
+	case IO_COHERENCE_DISABLED:
+		return 0;
+	}
+}
+#endif /* CONFIG_DMA_PERDEV_COHERENT */
+
+/*
+ * The affected CPUs below in 'cpu_needs_post_dma_flush()' can speculatively
+ * fill random cachelines with stale data at any time, requiring an extra
+ * flush post-DMA.
+ *
+ * Warning on the terminology - Linux calls an uncached area coherent;  MIPS
+ * terminology calls memory areas with hardware maintained coherency coherent.
+ *
+ * Note that the R14000 and R16000 should also be checked for in this condition.
+ * However this function is only called on non-I/O-coherent systems and only the
+ * R10000 and R12000 are used in such systems, the SGI IP28 Indigo² rsp.
+ * SGI IP32 aka O2.
+ */
+static inline bool cpu_needs_post_dma_flush(struct device *dev)
+{
+	if (dev_is_coherent(dev))
+		return false;
+
+	switch (boot_cpu_type()) {
+	case CPU_R10000:
+	case CPU_R12000:
+	case CPU_BMIPS5000:
+		return true;
+	default:
+		/*
+		 * Presence of MAARs suggests that the CPU supports
+		 * speculatively prefetching data, and therefore requires
+		 * the post-DMA flush/invalidate.
+		 */
+		return cpu_has_maar;
+	}
+}
+
+void *arch_dma_alloc(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
+{
+	void *ret;
+
+	ret = dma_direct_alloc(dev, size, dma_handle, gfp, attrs);
+	if (!ret)
+		return NULL;
+
+	if (!dev_is_coherent(dev) && !(attrs & DMA_ATTR_NON_CONSISTENT)) {
+		dma_cache_wback_inv((unsigned long) ret, size);
+		ret = UNCAC_ADDR(ret);
+	}
+
+	return ret;
+}
+
+void arch_dma_free(struct device *dev, size_t size, void *cpu_addr,
+		dma_addr_t dma_addr, unsigned long attrs)
+{
+	if (!(attrs & DMA_ATTR_NON_CONSISTENT) && !dev_is_coherent(dev))
+		cpu_addr = (void *)CAC_ADDR((unsigned long)cpu_addr);
+	dma_direct_free(dev, size, cpu_addr, dma_addr, attrs);
+}
+
+int arch_dma_mmap(struct device *dev, struct vm_area_struct *vma,
+		void *cpu_addr, dma_addr_t dma_addr, size_t size,
+		unsigned long attrs)
+{
+	unsigned long user_count = vma_pages(vma);
+	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	unsigned long addr = (unsigned long)cpu_addr;
+	unsigned long off = vma->vm_pgoff;
+	unsigned long pfn;
+	int ret = -ENXIO;
+
+	if (!dev_is_coherent(dev))
+		addr = CAC_ADDR(addr);
+
+	pfn = page_to_pfn(virt_to_page((void *)addr));
+
+	if (attrs & DMA_ATTR_WRITE_COMBINE)
+		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
+	else
+		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+
+	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
+		return ret;
+
+	if (off < count && user_count <= (count - off)) {
+		ret = remap_pfn_range(vma, vma->vm_start,
+				      pfn + off,
+				      user_count << PAGE_SHIFT,
+				      vma->vm_page_prot);
+	}
+
+	return ret;
+}
+
+static inline void dma_sync_virt(void *addr, size_t size,
+		enum dma_data_direction dir)
+{
+	switch (dir) {
+	case DMA_TO_DEVICE:
+		dma_cache_wback((unsigned long)addr, size);
+		break;
+
+	case DMA_FROM_DEVICE:
+		dma_cache_inv((unsigned long)addr, size);
+		break;
+
+	case DMA_BIDIRECTIONAL:
+		dma_cache_wback_inv((unsigned long)addr, size);
+		break;
+
+	default:
+		BUG();
+	}
+}
+
+/*
+ * A single sg entry may refer to multiple physically contiguous pages.  But
+ * we still need to process highmem pages individually.  If highmem is not
+ * configured then the bulk of this loop gets optimized out.
+ */
+static inline void dma_sync_phys(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
+{
+	struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
+	unsigned long offset = paddr & ~PAGE_MASK;
+	size_t left = size;
+
+	do {
+		size_t len = left;
+
+		if (PageHighMem(page)) {
+			void *addr;
+
+			if (offset + len > PAGE_SIZE) {
+				if (offset >= PAGE_SIZE) {
+					page += offset >> PAGE_SHIFT;
+					offset &= ~PAGE_MASK;
+				}
+				len = PAGE_SIZE - offset;
+			}
+
+			addr = kmap_atomic(page);
+			dma_sync_virt(addr + offset, len, dir);
+			kunmap_atomic(addr);
+		} else
+			dma_sync_virt(page_address(page) + offset, size, dir);
+		offset = 0;
+		page++;
+		left -= len;
+	} while (left);
+}
+
+void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir)
+{
+	if (!dev_is_coherent(dev))
+		dma_sync_phys(paddr, size, dir);
+}
+
+void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir)
+{
+	if (cpu_needs_post_dma_flush(dev))
+		dma_sync_phys(paddr, size, dir);
+}
+
+void arch_dma_cache_sync(struct device *dev, void *vaddr, size_t size,
+		enum dma_data_direction direction)
+{
+	BUG_ON(direction == DMA_NONE);
+
+	if (!dev_is_coherent(dev))
+		dma_sync_virt(vaddr, size, direction);
+}
diff --git a/arch/mips/pic32/Kconfig b/arch/mips/pic32/Kconfig
index 7feb7359b05b..e284e89183cc 100644
--- a/arch/mips/pic32/Kconfig
+++ b/arch/mips/pic32/Kconfig
@@ -11,7 +11,6 @@ config PIC32MZDA
 	select CEVT_R4K
 	select CSRC_R4K
 	select DMA_NONCOHERENT
-	select MIPS_DMA_DEFAULT
 	select SYS_HAS_CPU_MIPS32_R2
 	select SYS_HAS_EARLY_PRINTK
 	select SYS_SUPPORTS_32BIT_KERNEL
diff --git a/arch/mips/txx9/Kconfig b/arch/mips/txx9/Kconfig
index 9dfda3e90348..d2509c93f0ee 100644
--- a/arch/mips/txx9/Kconfig
+++ b/arch/mips/txx9/Kconfig
@@ -16,7 +16,6 @@ config MACH_TX49XX
 config MACH_TXX9
 	bool
 	select DMA_NONCOHERENT
-	select MIPS_DMA_DEFAULT
 	select SWAP_IO_SPACE
 	select SYS_HAS_EARLY_PRINTK
 	select SYS_SUPPORTS_32BIT_KERNEL
diff --git a/arch/mips/vr41xx/Kconfig b/arch/mips/vr41xx/Kconfig
index cc69b2f663fa..992c988b83b0 100644
--- a/arch/mips/vr41xx/Kconfig
+++ b/arch/mips/vr41xx/Kconfig
@@ -9,7 +9,6 @@ config CASIO_E55
 	select CEVT_R4K
 	select CSRC_R4K
 	select DMA_NONCOHERENT
-	select MIPS_DMA_DEFAULT
 	select IRQ_MIPS_CPU
 	select ISA
 	select SYS_SUPPORTS_32BIT_KERNEL
@@ -20,7 +19,6 @@ config IBM_WORKPAD
 	select CEVT_R4K
 	select CSRC_R4K
 	select DMA_NONCOHERENT
-	select MIPS_DMA_DEFAULT
 	select IRQ_MIPS_CPU
 	select ISA
 	select SYS_SUPPORTS_32BIT_KERNEL
@@ -31,7 +29,6 @@ config TANBAC_TB022X
 	select CEVT_R4K
 	select CSRC_R4K
 	select DMA_NONCOHERENT
-	select MIPS_DMA_DEFAULT
 	select IRQ_MIPS_CPU
 	select HW_HAS_PCI
 	select SYS_SUPPORTS_32BIT_KERNEL
@@ -48,7 +45,6 @@ config VICTOR_MPC30X
 	select CEVT_R4K
 	select CSRC_R4K
 	select DMA_NONCOHERENT
-	select MIPS_DMA_DEFAULT
 	select IRQ_MIPS_CPU
 	select HW_HAS_PCI
 	select PCI_VR41XX
@@ -60,7 +56,6 @@ config ZAO_CAPCELLA
 	select CEVT_R4K
 	select CSRC_R4K
 	select DMA_NONCOHERENT
-	select MIPS_DMA_DEFAULT
 	select IRQ_MIPS_CPU
 	select HW_HAS_PCI
 	select PCI_VR41XX
-- 
2.17.0
