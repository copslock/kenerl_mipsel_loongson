Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Jan 2005 08:45:51 +0000 (GMT)
Received: from alpha.total-knowledge.com ([IPv6:::ffff:209.157.135.102]:7334
	"EHLO alpha.total-knowledge.com") by linux-mips.org with ESMTP
	id <S8225221AbVAKIpo>; Tue, 11 Jan 2005 08:45:44 +0000
Received: (qmail 16761 invoked from network); 10 Jan 2005 15:26:58 -0800
Received: from c-24-6-216-150.client.comcast.net (HELO ?192.168.0.238?) (24.6.216.150)
  by alpha.total-knowledge.com with SMTP; 10 Jan 2005 15:26:58 -0800
Message-ID: <41E39234.2060502@total-knowledge.com>
Date: Tue, 11 Jan 2005 00:45:40 -0800
From: "Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>
Organization: Total Knowledge
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041221
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: IP32 full-mem patch, take 3
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------000902040306090206070704"
Return-Path: <ilya@total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6879
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@total-knowledge.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------000902040306090206070704
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

OK, here is updated patch.
Now it takes into consideration the fact that  built-in devices and PCI 
devices see memory map
differently.
This raises question why did the built-in devices work in the first 
place. i.e. meth was using
dma_* functions for allocation, and even though dma describtors they 
return are invalid, was
working.
Only explanation I have is that (even though it's undocumented) first 
256M of RAM are visible
at offset 0 for all devices. This makes sense in a way.

Anyways, without further ado, attached is the v3 of the patch.

--
Ilya A. Volynets-Evenbakh
Total Knowledge, CTO
http://www.total-knowledge.com



--------------000902040306090206070704
Content-Type: text/x-patch;
 name="full-mem3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="full-mem3.diff"

Index: arch/mips/Kconfig
===================================================================
RCS file: /home/cvs/linux/arch/mips/Kconfig,v
retrieving revision 1.126
diff -u -r1.126 Kconfig
--- arch/mips/Kconfig	27 Dec 2004 18:23:53 -0000	1.126
+++ arch/mips/Kconfig	10 Jan 2005 00:02:10 -0000
@@ -541,6 +541,8 @@
 	select ARC
 	select ARC32
 	select BOOT_ELF32
+	select OWN_DMA
+	select DMA_IP32
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select R5000_CPU_SCACHE
@@ -926,6 +928,12 @@
 config	DMA_IP27
 	bool
 
+config	DMA_IP32
+	bool
+
+config	OWN_DMA
+	bool
+
 config	DMA_NONCOHERENT
 	bool
 
Index: arch/mips/mm/Makefile
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/Makefile,v
retrieving revision 1.74
diff -u -r1.74 Makefile
--- arch/mips/mm/Makefile	7 Jan 2005 18:58:34 -0000	1.74
+++ arch/mips/mm/Makefile	9 Jan 2005 23:53:54 -0000
@@ -34,8 +34,11 @@
 #
 # Choose one DMA coherency model
 #
+ifndef CONFIG_OWN_DMA
 obj-$(CONFIG_DMA_COHERENT)	+= dma-coherent.o
 obj-$(CONFIG_DMA_NONCOHERENT)	+= dma-noncoherent.o
+endif
 obj-$(CONFIG_DMA_IP27)		+= dma-ip27.o
+obj-$(CONFIG_DMA_IP32)		+= dma-ip32.o
 
 EXTRA_AFLAGS := $(CFLAGS)
 
Index: arch/mips/sgi-ip32/Makefile
===================================================================
RCS file: /home/cvs/linux/arch/mips/sgi-ip32/Makefile,v
retrieving revision 1.9
diff -u -r1.9 Makefile
--- arch/mips/sgi-ip32/Makefile	26 Feb 2004 09:09:09 -0000	1.9
+++ arch/mips/sgi-ip32/Makefile	9 Jan 2005 23:53:55 -0000
@@ -4,6 +4,6 @@
 #
 
 obj-y	+= ip32-berr.o ip32-irq.o ip32-irq-glue.o ip32-setup.o ip32-reset.o \
-	   crime.o
+	   crime.o ip32-memory.o
 
 EXTRA_AFLAGS := $(CFLAGS)
Index: include/asm-mips/ip32/crime.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/ip32/crime.h,v
retrieving revision 1.6
diff -u -r1.6 crime.h
--- include/asm-mips/ip32/crime.h	4 Dec 2004 18:16:09 -0000	1.6
+++ include/asm-mips/ip32/crime.h	9 Jan 2005 23:54:26 -0000
@@ -156,4 +156,6 @@
 
 extern struct sgi_crime *crime;
 
+#define CRIME_HI_MEM_BASE	0x40000000	/* this is where whole 1G of RAM is mapped */
+
 #endif /* __ASM_CRIME_H__ */
Index: include/asm-mips/mach-ip32/spaces.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/mach-ip32/spaces.h,v
retrieving revision 1.1
diff -u -r1.1 spaces.h
--- include/asm-mips/mach-ip32/spaces.h	15 Oct 2004 02:09:12 -0000	1.1
+++ include/asm-mips/mach-ip32/spaces.h	9 Jan 2005 23:54:26 -0000
@@ -12,10 +12,6 @@
 
 #include <linux/config.h>
 
-/*
- * This handles the memory map.
- */
-#define PAGE_OFFSET		0xffffffff80000000
 
 /*
  * Memory above this physical address will be considered highmem.
@@ -26,11 +22,7 @@
 #define HIGHMEM_START		(1UL << 59UL)
 #endif
 
-#ifdef CONFIG_DMA_NONCOHERENT
 #define CAC_BASE		0x9800000000000000
-#else
-#define CAC_BASE		0xa800000000000000
-#endif
 #define IO_BASE			0x9000000000000000
 #define UNCAC_BASE		0x9000000000000000
 #define MAP_BASE		0xc000000000000000
@@ -39,4 +31,9 @@
 #define TO_CAC(x)		(CAC_BASE   | ((x) & TO_PHYS_MASK))
 #define TO_UNCAC(x)		(UNCAC_BASE | ((x) & TO_PHYS_MASK))
 
+/*
+ * This handles the memory map.
+ */
+#define PAGE_OFFSET		CAC_BASE
+
 #endif /* __ASM_MACH_IP32_SPACES_H */
Index: arch/mips/sgi-ip32/ip32-setup.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/sgi-ip32/ip32-setup.c,v
retrieving revision 1.22
diff -u -r1.22 ip32-setup.c
--- arch/mips/sgi-ip32/ip32-setup.c	31 Aug 2004 16:49:32 -0000	1.22
+++ arch/mips/sgi-ip32/ip32-setup.c	10 Jan 2005 00:18:02 -0000
@@ -94,10 +94,6 @@
 
 static int __init ip32_setup(void)
 {
-	set_io_port_base((unsigned long) ioremap(MACEPCI_LOW_IO, 0x2000000));
-
-	crime_init();
-
 	board_be_init = ip32_be_init;
 
 	rtc_get_time = mc146818_get_cmos_time;
--- /dev/null	1969-12-31 16:00:00 -0800
+++ arch/mips/sgi-ip32/ip32-memory.c	2005-01-09 16:25:59 -0800
@@ -0,0 +1,53 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2003 Keith M Wesolowski
+ * Copyright (C) 2005 Ilya A. Volynets (Total Knowledge)
+ */
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+
+#include <asm/ip32/crime.h>
+#include <asm/bootinfo.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/pgalloc.h>
+
+extern void crime_init(void);
+
+void __init prom_meminit (void)
+{
+	u64 base, size;
+	int bank;
+
+	crime_init();
+
+	for (bank=0; bank < CRIME_MAXBANKS; bank++) {
+		u64 bankctl = crime->bank_ctrl[bank];
+		base = (bankctl & CRIME_MEM_BANK_CONTROL_ADDR) << 25;
+		if (bank != 0 && base == 0)
+			continue;
+		size = (bankctl & CRIME_MEM_BANK_CONTROL_SDRAM_SIZE) ? 128 : 32;
+		size <<= 20;
+		if (base + size > (256 << 20)) {
+#if !defined(CONFIG_HIGHMEM) && PAGE_OFFSET!=CAC_BASE
+		    continue;
+#else
+		    base+=CRIME_HI_MEM_BASE;
+#endif
+		}
+		printk("CRIME MC: bank %u base 0x%016lx size %luMB\n",
+			bank, base, size);
+		add_memory_region (base, size, BOOT_MEM_RAM);
+	}
+}
+
+
+unsigned long __init prom_free_prom_memory (void)
+{
+	return 0;
+}
--- /dev/null	1969-12-31 16:00:00 -0800
+++ include/asm-mips/mach-ip32/cpu-feature-overrides.h	2005-01-08 21:59:51 -0800
@@ -0,0 +1,22 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2005 Ilya A. Volynets-Evenbakh
+ */
+#ifndef __ASM_MACH_IP32_CPU_FEATURE_OVERRIDES_H
+#define __ASM_MACH_IP32_CPU_FEATURE_OVERRIDES_H
+
+/*
+ * R5000 has an interesting "restriction":  ll(d)/sc(d)
+ * instructions to XKPHYS region simply do uncached bus
+ * requests. This breaks all the atomic bitops functions.
+ * so, for 64bit IP32 kernel we just don't use ll/sc.
+ * This does not affect luserland.
+ */
+#if defined(CONFIG_CPU_R5000) && defined(CONFIG_MIPS64)
+#define cpu_has_llsc	0
+#endif
+
+#endif /* __ASM_MACH_IP32_CPU_FEATURE_OVERRIDES_H */
--- /dev/null	1969-12-31 16:00:00 -0800
+++ arch/mips/mm/dma-ip32.c	2005-01-10 20:44:22 -0800
@@ -0,0 +1,383 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2000  Ani Joshi <ajoshi@unixbox.com>
+ * Copyright (C) 2000, 2001  Ralf Baechle <ralf@gnu.org>
+ * Copyright (C) 2005 Ilya A. Volynets-Evenbakh <ilya@total-knowledge.com>
+ * swiped from i386, and cloned for MIPS by Geert, polished by Ralf.
+ * IP32 changes by Ilya.
+ */
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/dma-mapping.h>
+
+#include <asm/cache.h>
+#include <asm/io.h>
+#include <asm/ip32/crime.h>
+
+/*
+ * Warning on the terminology - Linux calls an uncached area coherent;
+ * MIPS terminology calls memory areas with hardware maintained coherency
+ * coherent.
+ */
+
+/*
+ * Few notes.
+ * 1. CPU sees memory as two chunks: 0-256M@0x0, and the rest @0x40000000+256M
+ * 2. PCI sees memory as one big chunk @0x0 (or we couls use 0x40000000 for native-endian)
+ * 3. All other devices see memory as one big chunk at 0x40000000
+ * 4. Non-PCI devices will pass NULL as struct device*
+ * Thus we translate differently, depending on device.
+ */
+
+#define RAM_OFFSET_MASK	0x3fffffff
+
+void *dma_alloc_noncoherent(struct device *dev, size_t size,
+	dma_addr_t * dma_handle, int gfp)
+{
+	void *ret;
+	/* ignore region specifiers */
+	gfp &= ~(__GFP_DMA | __GFP_HIGHMEM);
+
+	if (dev == NULL || (dev->coherent_dma_mask < 0xffffffff))
+		gfp |= GFP_DMA;
+	ret = (void *) __get_free_pages(gfp, get_order(size));
+
+	if (ret != NULL) {
+		unsigned long addr = virt_to_phys(ret)&RAM_OFFSET_MASK;
+		memset(ret, 0, size);
+		if(dev==NULL)
+		    addr+= CRIME_HI_MEM_BASE;
+		*dma_handle = addr;
+	}
+
+	return ret;
+}
+
+EXPORT_SYMBOL(dma_alloc_noncoherent);
+
+void *dma_alloc_coherent(struct device *dev, size_t size,
+	dma_addr_t * dma_handle, int gfp)
+{
+	void *ret;
+
+	ret = dma_alloc_noncoherent(dev, size, dma_handle, gfp);
+	if (ret) {
+		dma_cache_wback_inv((unsigned long) ret, size);
+		ret = UNCAC_ADDR(ret);
+	}
+
+	return ret;
+}
+
+EXPORT_SYMBOL(dma_alloc_coherent);
+
+void dma_free_noncoherent(struct device *dev, size_t size, void *vaddr,
+	dma_addr_t dma_handle)
+{
+	free_pages((unsigned long) vaddr, get_order(size));
+}
+
+EXPORT_SYMBOL(dma_free_noncoherent);
+
+void dma_free_coherent(struct device *dev, size_t size, void *vaddr,
+	dma_addr_t dma_handle)
+{
+	unsigned long addr = (unsigned long) vaddr;
+
+	addr = CAC_ADDR(addr);
+	free_pages(addr, get_order(size));
+}
+
+EXPORT_SYMBOL(dma_free_coherent);
+
+static inline void __dma_sync(unsigned long addr, size_t size,
+	enum dma_data_direction direction)
+{
+	switch (direction) {
+	case DMA_TO_DEVICE:
+		dma_cache_wback(addr, size);
+		break;
+
+	case DMA_FROM_DEVICE:
+		dma_cache_inv(addr, size);
+		break;
+
+	case DMA_BIDIRECTIONAL:
+		dma_cache_wback_inv(addr, size);
+		break;
+
+	default:
+		BUG();
+	}
+}
+
+dma_addr_t dma_map_single(struct device *dev, void *ptr, size_t size,
+	enum dma_data_direction direction)
+{
+	unsigned long addr = (unsigned long) ptr;
+
+	switch (direction) {
+	case DMA_TO_DEVICE:
+		dma_cache_wback(addr, size);
+		break;
+
+	case DMA_FROM_DEVICE:
+		dma_cache_inv(addr, size);
+		break;
+
+	case DMA_BIDIRECTIONAL:
+		dma_cache_wback_inv(addr, size);
+		break;
+
+	default:
+		BUG();
+	}
+
+	addr = virt_to_phys(ptr)&RAM_OFFSET_MASK;;
+	if(dev == NULL)
+	    addr+=CRIME_HI_MEM_BASE;
+	return (dma_addr_t)addr;
+}
+
+EXPORT_SYMBOL(dma_map_single);
+
+void dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
+	enum dma_data_direction direction)
+{
+	switch (direction) {
+	case DMA_TO_DEVICE:
+		break;
+
+	case DMA_FROM_DEVICE:
+		break;
+
+	case DMA_BIDIRECTIONAL:
+		break;
+
+	default:
+		BUG();
+	}
+}
+
+EXPORT_SYMBOL(dma_unmap_single);
+
+int dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
+	enum dma_data_direction direction)
+{
+	int i;
+
+	BUG_ON(direction == DMA_NONE);
+
+	for (i = 0; i < nents; i++, sg++) {
+		unsigned long addr;
+ 
+		addr = (unsigned long) page_address(sg->page)+sg->offset;
+		if (addr)
+			__dma_sync(addr, sg->length, direction);
+		addr = __pa(addr)&RAM_OFFSET_MASK;;
+		if(dev == NULL)
+			addr +=  CRIME_HI_MEM_BASE;
+		sg->dma_address = (dma_addr_t)addr;
+	}
+
+	return nents;
+}
+
+EXPORT_SYMBOL(dma_map_sg);
+
+dma_addr_t dma_map_page(struct device *dev, struct page *page,
+	unsigned long offset, size_t size, enum dma_data_direction direction)
+{
+	unsigned long addr;
+
+	BUG_ON(direction == DMA_NONE);
+
+	addr = (unsigned long) page_address(page) + offset;
+	dma_cache_wback_inv(addr, size);
+	addr = __pa(addr)&RAM_OFFSET_MASK;;
+	if(dev == NULL)
+		addr +=  CRIME_HI_MEM_BASE;
+
+	return (dma_addr_t)addr;
+}
+
+EXPORT_SYMBOL(dma_map_page);
+
+void dma_unmap_page(struct device *dev, dma_addr_t dma_address, size_t size,
+	enum dma_data_direction direction)
+{
+	BUG_ON(direction == DMA_NONE);
+
+	if (direction != DMA_TO_DEVICE) {
+		unsigned long addr;
+
+		dma_address&=RAM_OFFSET_MASK;
+		addr = dma_address + PAGE_OFFSET;
+		if(dma_address>=256*1024*1024)
+			addr+=CRIME_HI_MEM_BASE;
+		dma_cache_wback_inv(addr, size);
+	}
+}
+
+EXPORT_SYMBOL(dma_unmap_page);
+
+void dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
+	enum dma_data_direction direction)
+{
+	unsigned long addr;
+	int i;
+
+	BUG_ON(direction == DMA_NONE);
+
+	if (direction == DMA_TO_DEVICE)
+		return;
+
+	for (i = 0; i < nhwentries; i++, sg++) {
+		addr = (unsigned long) page_address(sg->page);
+		if (!addr)
+			continue;
+		dma_cache_wback_inv(addr + sg->offset, sg->length);
+	}
+}
+
+EXPORT_SYMBOL(dma_unmap_sg);
+
+void dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle,
+	size_t size, enum dma_data_direction direction)
+{
+	unsigned long addr;
+ 
+	BUG_ON(direction == DMA_NONE);
+ 
+	dma_handle&=RAM_OFFSET_MASK;
+	addr = dma_handle + PAGE_OFFSET;
+	if(dma_handle>=256*1024*1024)
+	    addr+=CRIME_HI_MEM_BASE;
+	__dma_sync(addr, size, direction);
+}
+
+EXPORT_SYMBOL(dma_sync_single_for_cpu);
+
+void dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle,
+	size_t size, enum dma_data_direction direction)
+{
+	unsigned long addr;
+
+	BUG_ON(direction == DMA_NONE);
+
+	dma_handle&=RAM_OFFSET_MASK;
+	addr = dma_handle + PAGE_OFFSET;
+	if(dma_handle>=256*1024*1024)
+	    addr+=CRIME_HI_MEM_BASE;
+	__dma_sync(addr, size, direction);
+}
+
+EXPORT_SYMBOL(dma_sync_single_for_device);
+
+void dma_sync_single_range_for_cpu(struct device *dev, dma_addr_t dma_handle,
+	unsigned long offset, size_t size, enum dma_data_direction direction)
+{
+	unsigned long addr;
+
+	BUG_ON(direction == DMA_NONE);
+
+	dma_handle&=RAM_OFFSET_MASK;
+	addr = dma_handle + offset + PAGE_OFFSET;
+	if(dma_handle>=256*1024*1024)
+	    addr+=CRIME_HI_MEM_BASE;
+	__dma_sync(addr, size, direction);
+}
+
+EXPORT_SYMBOL(dma_sync_single_range_for_cpu);
+
+void dma_sync_single_range_for_device(struct device *dev, dma_addr_t dma_handle,
+	unsigned long offset, size_t size, enum dma_data_direction direction)
+{
+	unsigned long addr;
+
+	BUG_ON(direction == DMA_NONE);
+
+	dma_handle&=RAM_OFFSET_MASK;
+	addr = dma_handle + offset + PAGE_OFFSET;
+	if(dma_handle>=256*1024*1024)
+	    addr+=CRIME_HI_MEM_BASE;
+	__dma_sync(addr, size, direction);
+}
+
+EXPORT_SYMBOL(dma_sync_single_range_for_device);
+
+void dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg, int nelems,
+	enum dma_data_direction direction)
+{
+	int i;
+ 
+	BUG_ON(direction == DMA_NONE);
+ 
+	/* Make sure that gcc doesn't leave the empty loop body.  */
+	for (i = 0; i < nelems; i++, sg++)
+		__dma_sync((unsigned long)page_address(sg->page),
+		           sg->length, direction);
+}
+
+EXPORT_SYMBOL(dma_sync_sg_for_cpu);
+
+void dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg, int nelems,
+	enum dma_data_direction direction)
+{
+	int i;
+
+	BUG_ON(direction == DMA_NONE);
+
+	/* Make sure that gcc doesn't leave the empty loop body.  */
+	for (i = 0; i < nelems; i++, sg++)
+		__dma_sync((unsigned long)page_address(sg->page),
+		           sg->length, direction);
+}
+
+EXPORT_SYMBOL(dma_sync_sg_for_device);
+
+int dma_mapping_error(dma_addr_t dma_addr)
+{
+	return 0;
+}
+
+EXPORT_SYMBOL(dma_mapping_error);
+
+int dma_supported(struct device *dev, u64 mask)
+{
+	/*
+	 * we fall back to GFP_DMA when the mask isn't all 1s,
+	 * so we can't guarantee allocations that must be
+	 * within a tighter range than GFP_DMA..
+	 */
+	if (mask < 0x00ffffff)
+		return 0;
+
+	return 1;
+}
+
+EXPORT_SYMBOL(dma_supported);
+
+int dma_is_consistent(dma_addr_t dma_addr)
+{
+	return 1;
+}
+
+EXPORT_SYMBOL(dma_is_consistent);
+
+void dma_cache_sync(void *vaddr, size_t size, enum dma_data_direction direction)
+{
+	if (direction == DMA_NONE)
+		return;
+
+	dma_cache_wback_inv((unsigned long)vaddr, size);
+}
+
+EXPORT_SYMBOL(dma_cache_sync);
+
Index: arch/mips/sgi-ip32/crime.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/sgi-ip32/crime.c,v
retrieving revision 1.6
diff -u -r1.6 crime.c
--- arch/mips/sgi-ip32/crime.c	31 Aug 2004 16:49:32 -0000	1.6
+++ arch/mips/sgi-ip32/crime.c	11 Jan 2005 08:42:35 -0000
@@ -4,6 +4,7 @@
  * for more details.
  *
  * Copyright (C) 2001, 2003 Keith M Wesolowski
+ * Copyright (C) 2005 Ilya A. Volynets <ilya@total-knowledge.com>
  */
 #include <linux/types.h>
 #include <linux/init.h>
@@ -24,7 +25,8 @@
 {
 	unsigned int id, rev;
 	const int field = 2 * sizeof(unsigned long);
-	
+
+	set_io_port_base((unsigned long) ioremap(MACEPCI_LOW_IO, 0x2000000));	
 	crime = ioremap(CRIME_BASE, sizeof(struct sgi_crime));
 	mace = ioremap(MACE_BASE, sizeof(struct sgi_mace));
 

--------------000902040306090206070704--
