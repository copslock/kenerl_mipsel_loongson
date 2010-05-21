Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 May 2010 20:25:52 +0200 (CEST)
Received: from sj-iport-5.cisco.com ([171.68.10.87]:45658 "EHLO
        sj-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491813Ab0EUSZr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 May 2010 20:25:47 +0200
Authentication-Results: sj-iport-5.cisco.com; dkim=neutral (message not signed) header.i=none
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAF1t9kurR7H+/2dsb2JhbACeDXGjd5liglAFgj0Eg0E
X-IronPort-AV: E=Sophos;i="4.53,279,1272844800"; 
   d="scan'208";a="200916832"
Received: from sj-core-2.cisco.com ([171.71.177.254])
  by sj-iport-5.cisco.com with ESMTP; 21 May 2010 18:25:36 +0000
Received: from dvomlehn-lnx2.corp.sa.net ([64.101.20.155])
        by sj-core-2.cisco.com (8.13.8/8.14.3) with ESMTP id o4LIPWMe008046;
        Fri, 21 May 2010 18:25:32 GMT
Date:   Fri, 21 May 2010 11:25:36 -0700
From:   David VomLehn <dvomlehn@cisco.com>
To:     to@dvomlehn-lnx2.corp.sa.net,
        "linux-mips@linux-mips.org"@cisco.com, linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH] MIPS:POWERTV: use O(1) algorthm for phys_to_dma/dma_to_phys
Message-ID: <20100521182536.GA3331@dvomlehn-lnx2.corp.sa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26785
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

Replace phys_to_dma()/dma_to_phys() looping algorithm with an O(1) algorithm
The approach taken is inspired by the sparse memory implementation: take a
certain number of high-order bits off the address them, use this as an
index into a table containing an offset to the desired address and add
it to the original value. There is a table for mapping physical addresses
to DMA addresses and another one for the reverse mapping. The table sizes
depend on how fine-grained the mappings need to be; Coarser granularity
less to smaller tables.  On a processor with 32-bit physical and DMA
addresses, with 4 MIB granularity, memory usage is two 2048-byte arrays.
Each 32-byte cache line thus covers 64 MiB of address space.

Also, renames phys_to_bus() to phys_to_dma() and bus_to_phys() to
dma_to_phys() to align with kernel usage.

Signed-off-by: David VomLehn <dvomlehn@cisco.com>
---
 arch/mips/include/asm/mach-powertv/dma-coherence.h |    8 +-
 arch/mips/include/asm/mach-powertv/ioremap.h       |  165 +++++++---
 arch/mips/powertv/Makefile                         |    3 +-
 arch/mips/powertv/asic/asic_devices.c              |   18 +-
 arch/mips/powertv/ioremap.c                        |  136 ++++++++
 arch/mips/powertv/memory.c                         |  342 +++++++++++++++-----
 6 files changed, 529 insertions(+), 143 deletions(-)

diff --git a/arch/mips/include/asm/mach-powertv/dma-coherence.h b/arch/mips/include/asm/mach-powertv/dma-coherence.h
index 5b8d5eb..f76029c 100644
--- a/arch/mips/include/asm/mach-powertv/dma-coherence.h
+++ b/arch/mips/include/asm/mach-powertv/dma-coherence.h
@@ -65,21 +65,21 @@ static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
 	size_t size)
 {
 	if (is_kseg2(addr))
-		return phys_to_bus(virt_to_phys_from_pte(addr));
+		return phys_to_dma(virt_to_phys_from_pte(addr));
 	else
-		return phys_to_bus(virt_to_phys(addr));
+		return phys_to_dma(virt_to_phys(addr));
 }
 
 static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
 	struct page *page)
 {
-	return phys_to_bus(page_to_phys(page));
+	return phys_to_dma(page_to_phys(page));
 }
 
 static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
 	dma_addr_t dma_addr)
 {
-	return bus_to_phys(dma_addr);
+	return dma_to_phys(dma_addr);
 }
 
 static inline void plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr,
diff --git a/arch/mips/include/asm/mach-powertv/ioremap.h b/arch/mips/include/asm/mach-powertv/ioremap.h
index e6276d5..076f2ee 100644
--- a/arch/mips/include/asm/mach-powertv/ioremap.h
+++ b/arch/mips/include/asm/mach-powertv/ioremap.h
@@ -10,64 +10,101 @@
 #define __ASM_MACH_POWERTV_IOREMAP_H
 
 #include <linux/types.h>
+#include <linux/log2.h>
+#include <linux/compiler.h>
 
-#define LOW_MEM_BOUNDARY_PHYS	0x20000000
-#define LOW_MEM_BOUNDARY_MASK	(~(LOW_MEM_BOUNDARY_PHYS - 1))
+#include <asm/pgtable-bits.h>
+#include <asm/addrspace.h>
+
+/* We're going to mess with bits, so get sizes */
+#define IOR_BPC			8			/* Bits per char */
+#define IOR_PHYS_BITS		(IOR_BPC * sizeof(phys_addr_t))
+#define IOR_DMA_BITS		(IOR_BPC * sizeof(dma_addr_t))
 
 /*
- * The bus addresses are different than the physical addresses that
- * the processor sees by an offset. This offset varies by ASIC
- * version. Define a variable to hold the offset and some macros to
- * make the conversion simpler. */
-extern unsigned long phys_to_bus_offset;
-
-#ifdef CONFIG_HIGHMEM
-#define MEM_GAP_PHYS		0x60000000
+ * Define the granularity of physical/DMA mapping in terms of the number
+ * of bits that defines the offset within a grain. These will be the
+ * least significant bits of the address. The rest of a physical or DMA
+ * address will be used to index into an appropriate table to find the
+ * offset to add to the address to yield the corresponding DMA or physical
+ * address, respectively.
+ */
+#define IOR_LSBITS		22			/* Bits in a grain */
+
 /*
- * TODO: We will use the hard code for conversion between physical and
- * bus until the bootloader releases their device tree to us.
+ * Compute the number of most significant address bits after removing those
+ * used for the offset within a grain and then compute the number of table
+ * entries for the conversion.
  */
-#define phys_to_bus(x) (((x) < LOW_MEM_BOUNDARY_PHYS) ? \
-	((x) + phys_to_bus_offset) : (x))
-#define bus_to_phys(x) (((x) < MEM_GAP_PHYS_ADDR) ? \
-	((x) - phys_to_bus_offset) : (x))
-#else
-#define phys_to_bus(x) ((x) + phys_to_bus_offset)
-#define bus_to_phys(x) ((x) - phys_to_bus_offset)
-#endif
+#define IOR_PHYS_MSBITS		(IOR_PHYS_BITS - IOR_LSBITS)
+#define IOR_NUM_PHYS_TO_DMA	((phys_addr_t) 1 << IOR_PHYS_MSBITS)
+
+#define IOR_DMA_MSBITS		(IOR_DMA_BITS - IOR_LSBITS)
+#define IOR_NUM_DMA_TO_PHYS	((dma_addr_t) 1 << IOR_DMA_MSBITS)
 
 /*
- * Determine whether the address we are given is for an ASIC device
- * Params:  addr    Address to check
- * Returns: Zero if the address is not for ASIC devices, non-zero
- *      if it is.
+ * Define data structures used as elements in the arrays for the conversion
+ * between physical and DMA addresses. We do some slightly fancy math to
+ * compute the width of the offset element of the conversion tables so
+ * that we can have the smallest conversion tables. Next, round up the
+ * sizes to the next higher power of two, i.e. the offset element will have
+ * 8, 16, 32, 64, etc. bits. This eliminates the need to mask off any
+ * bits.  Finally, we compute a shift value that puts the most significant
+ * bits of the offset into the most significant bits of the offset element.
+ * This makes it more efficient on processors without barrel shifters and
+ * easier to see the values if the conversion table is dumped in binary.
  */
-static inline int asic_is_device_addr(phys_t addr)
+#define _IOR_OFFSET_WIDTH(n)	(1 << order_base_2(n))
+#define IOR_OFFSET_WIDTH(n) \
+	(_IOR_OFFSET_WIDTH(n) < 8 ? 8 : _IOR_OFFSET_WIDTH(n))
+
+#define IOR_PHYS_OFFSET_BITS	IOR_OFFSET_WIDTH(IOR_PHYS_MSBITS)
+#define IOR_PHYS_SHIFT		(IOR_PHYS_BITS - IOR_PHYS_OFFSET_BITS)
+
+#define IOR_DMA_OFFSET_BITS	IOR_OFFSET_WIDTH(IOR_DMA_MSBITS)
+#define IOR_DMA_SHIFT		(IOR_DMA_BITS - IOR_DMA_OFFSET_BITS)
+
+struct ior_phys_to_dma {
+	dma_addr_t offset:IOR_DMA_OFFSET_BITS __packed
+		__aligned((IOR_DMA_OFFSET_BITS / IOR_BPC));
+};
+
+struct ior_dma_to_phys {
+	dma_addr_t offset:IOR_PHYS_OFFSET_BITS __packed
+		__aligned((IOR_PHYS_OFFSET_BITS / IOR_BPC));
+};
+
+extern struct ior_phys_to_dma _ior_phys_to_dma[IOR_NUM_PHYS_TO_DMA];
+extern struct ior_dma_to_phys _ior_dma_to_phys[IOR_NUM_DMA_TO_PHYS];
+
+static inline dma_addr_t _phys_to_dma_offset_raw(phys_addr_t phys)
 {
-	return !((phys_t)addr & (phys_t) LOW_MEM_BOUNDARY_MASK);
+	return (dma_addr_t)_ior_phys_to_dma[phys >> IOR_LSBITS].offset;
 }
 
-/*
- * Determine whether the address we are given is external RAM mappable
- * into KSEG1.
- * Params:  addr    Address to check
- * Returns: Zero if the address is not for external RAM and
- */
-static inline int asic_is_lowmem_ram_addr(phys_t addr)
+static inline dma_addr_t _dma_to_phys_offset_raw(dma_addr_t dma)
 {
-	/*
-	 * The RAM always starts at the following address in the processor's
-	 * physical address space
-	 */
-	static const phys_t phys_ram_base = 0x10000000;
-	phys_t bus_ram_base;
+	return (dma_addr_t)_ior_dma_to_phys[dma >> IOR_LSBITS].offset;
+}
 
-	bus_ram_base = phys_to_bus_offset + phys_ram_base;
+/* These are not portable and should not be used in drivers. Drivers should
+ * be using ioremap() and friends to map physical addreses to virtual
+ * addresses and dma_map*() and friends to map virtual addresses into DMA
+ * addresses and back.
+ */
+static inline dma_addr_t phys_to_dma(phys_addr_t phys)
+{
+	return phys + (_phys_to_dma_offset_raw(phys) << IOR_PHYS_SHIFT);
+}
 
-	return addr >= bus_ram_base &&
-		addr < (bus_ram_base + (LOW_MEM_BOUNDARY_PHYS - phys_ram_base));
+static inline phys_addr_t dma_to_phys(dma_addr_t dma)
+{
+	return dma + (_dma_to_phys_offset_raw(dma) << IOR_DMA_SHIFT);
 }
 
+extern void ioremap_add_map(dma_addr_t phys, phys_addr_t alias,
+	dma_addr_t size);
+
 /*
  * Allow physical addresses to be fixed up to help peripherals located
  * outside the low 32-bit range -- generic pass-through version.
@@ -77,10 +114,50 @@ static inline phys_t fixup_bigphys_addr(phys_t phys_addr, phys_t size)
 	return phys_addr;
 }
 
-static inline void __iomem *plat_ioremap(phys_t offset, unsigned long size,
+/*
+ * Handle the special case of addresses the area aliased into the first
+ * 512 MiB of the processor's physical address space. These turn into either
+ * kseg0 or kseg1 addresses, depending on flags.
+ */
+static inline void __iomem *plat_ioremap(phys_t start, unsigned long size,
 	unsigned long flags)
 {
-	return NULL;
+	phys_addr_t start_offset;
+	void __iomem *result = NULL;
+
+	/* Start by checking to see whether this is an aliased address */
+	start_offset = _dma_to_phys_offset_raw(start);
+
+	/*
+	 * If:
+	 * o	the memory is aliased into the first 512 MiB, and
+	 * o	the start and end are in the same RAM bank, and
+	 * o	we don't have a zero size or wrap around, and
+	 * o	we are supposed to create an uncached mapping,
+	 *	handle this is a kseg0 or kseg1 address
+	 */
+	if (start_offset != 0) {
+		phys_addr_t last;
+		dma_addr_t dma_to_phys_offset;
+
+		last = start + size - 1;
+		dma_to_phys_offset =
+			_dma_to_phys_offset_raw(last) << IOR_DMA_SHIFT;
+
+		if (dma_to_phys_offset == start_offset &&
+			size != 0 && start <= last) {
+			phys_t adjusted_start;
+			adjusted_start = start + start_offset;
+			if (flags == _CACHE_UNCACHED)
+				result = (void __iomem *) (unsigned long)
+					CKSEG1ADDR(adjusted_start);
+			else
+				result = (void __iomem *) (unsigned long)
+					CKSEG0ADDR(adjusted_start);
+		}
+	}
+
+	return result;
 }
 
 static inline int plat_iounmap(const volatile void __iomem *addr)
diff --git a/arch/mips/powertv/Makefile b/arch/mips/powertv/Makefile
index 0a0d73c..e9fe1c6 100644
--- a/arch/mips/powertv/Makefile
+++ b/arch/mips/powertv/Makefile
@@ -23,6 +23,7 @@
 # under Linux.
 #
 
-obj-y += init.o memory.o reset.o time.o powertv_setup.o asic/ pci/
+obj-y += init.o ioremap.o memory.o powertv_setup.o reset.o time.o \
+	asic/ pci/
 
 EXTRA_CFLAGS += -Wall -Werror
diff --git a/arch/mips/powertv/asic/asic_devices.c b/arch/mips/powertv/asic/asic_devices.c
index 8ee7788..37c71cc 100644
--- a/arch/mips/powertv/asic/asic_devices.c
+++ b/arch/mips/powertv/asic/asic_devices.c
@@ -80,8 +80,8 @@ static bool usb_configured;
  * Don't recommend to use it directly, it is usually used by kernel internally.
  * Portable code should be using interfaces such as ioremp, dma_map_single, etc.
  */
-unsigned long phys_to_bus_offset;
-EXPORT_SYMBOL(phys_to_bus_offset);
+unsigned long phys_to_dma_offset;
+EXPORT_SYMBOL(phys_to_dma_offset);
 
 /*
  *
@@ -532,10 +532,10 @@ void __init configure_platform(void)
 
 	switch (asic) {
 	case ASIC_ZEUS:
-		phys_to_bus_offset = 0x30000000;
+		phys_to_dma_offset = 0x30000000;
 		break;
 	case ASIC_CALLIOPE:
-		phys_to_bus_offset = 0x10000000;
+		phys_to_dma_offset = 0x10000000;
 		break;
 	case ASIC_CRONUSLITE:
 		/* Fall through */
@@ -545,10 +545,10 @@ void __init configure_platform(void)
 		 * 0x2XXXXXXX. If 0x10000000 aliases into 0x60000000-
 		 * 0x6XXXXXXX, the offset should be 0x50000000, not 0x10000000.
 		 */
-		phys_to_bus_offset = 0x10000000;
+		phys_to_dma_offset = 0x10000000;
 		break;
 	default:
-		phys_to_bus_offset = 0x00000000;
+		phys_to_dma_offset = 0x00000000;
 		break;
 	}
 }
@@ -602,7 +602,7 @@ void __init platform_alloc_bootmem(void)
 		int size = gp_resources[i].end - gp_resources[i].start + 1;
 		if ((gp_resources[i].start != 0) &&
 			((gp_resources[i].flags & IORESOURCE_MEM) != 0)) {
-			reserve_bootmem(bus_to_phys(gp_resources[i].start),
+			reserve_bootmem(dma_to_phys(gp_resources[i].start),
 				size, 0);
 			total += gp_resources[i].end -
 				gp_resources[i].start + 1;
@@ -626,7 +626,7 @@ void __init platform_alloc_bootmem(void)
 
 			else {
 				gp_resources[i].start =
-					phys_to_bus(virt_to_phys(mem));
+					phys_to_dma(virt_to_phys(mem));
 				gp_resources[i].end =
 					gp_resources[i].start + size - 1;
 				total += size;
@@ -690,7 +690,7 @@ static void __init pmem_setup_resource(void)
 	if (resource && pmemaddr && pmemlen) {
 		/* The address provided by bootloader is in kseg0. Convert to
 		 * a bus address. */
-		resource->start = phys_to_bus(pmemaddr - 0x80000000);
+		resource->start = phys_to_dma(pmemaddr - 0x80000000);
 		resource->end = resource->start + pmemlen - 1;
 
 		pr_info("persistent memory: start=0x%x  end=0x%x\n",
diff --git a/arch/mips/powertv/ioremap.c b/arch/mips/powertv/ioremap.c
new file mode 100644
index 0000000..a77c6f6
--- /dev/null
+++ b/arch/mips/powertv/ioremap.c
@@ -0,0 +1,136 @@
+/*
+ *			ioremap.c
+ *
+ * Support for mapping between dma_addr_t values a phys_addr_t values.
+ *
+ * Copyright (C) 2005-2009 Scientific-Atlanta, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ *
+ * Author:       David VomLehn <dvomlehn@cisco.com>
+ *
+ * Description:  Defines the platform resources for the SA settop.
+ *
+ * NOTE: The bootloader allocates persistent memory at an address which is
+ * 16 MiB below the end of the highest address in KSEG0. All fixed
+ * address memory reservations must avoid this region.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#include <asm/mach-powertv/ioremap.h>
+
+/*
+ * Define the sizes of and masks for grains in physical and DMA space. The
+ * values are the same but the types are not.
+ */
+#define IOR_PHYS_GRAIN		((phys_addr_t) 1 << IOR_LSBITS)
+#define IOR_PHYS_GRAIN_MASK	(IOR_PHYS_GRAIN - 1)
+
+#define IOR_DMA_GRAIN		((dma_addr_t) 1 << IOR_LSBITS)
+#define IOR_DMA_GRAIN_MASK	(IOR_DMA_GRAIN - 1)
+
+/*
+ * Values that, when accessed by an index derived from a phys_addr_t and
+ * added to phys_addr_t value, yield a DMA address
+ */
+struct ior_phys_to_dma _ior_phys_to_dma[IOR_NUM_PHYS_TO_DMA];
+EXPORT_SYMBOL(_ior_phys_to_dma);
+
+/*
+ * Values that, when accessed by an index derived from a dma_addr_t and
+ * added to that dma_addr_t value, yield a physical address
+ */
+struct ior_dma_to_phys _ior_dma_to_phys[IOR_NUM_DMA_TO_PHYS];
+EXPORT_SYMBOL(_ior_dma_to_phys);
+
+/**
+ * setup_dma_to_phys - set up conversion from DMA to physical addresses
+ * @dma_idx:	Top IOR_LSBITS bits of the DMA address, i.e. an index
+ *		into the array _dma_to_phys.
+ * @delta:	Value that, when added to the DMA address, will yield the
+ *		physical address
+ * @s:		Number of bytes in the section of memory with the given delta
+ *		between DMA and physical addresses.
+ */
+static void setup_dma_to_phys(dma_addr_t dma, phys_addr_t delta, dma_addr_t s)
+{
+	int dma_idx, first_idx, last_idx;
+	phys_addr_t first, last;
+
+	/*
+	 * Calculate the first and last indices, rounding the first up and
+	 * the second down.
+	 */
+	first = dma & ~IOR_DMA_GRAIN_MASK;
+	last = (dma + s - 1) & ~IOR_DMA_GRAIN_MASK;
+	first_idx = first >> IOR_LSBITS;		/* Convert to indices */
+	last_idx = last >> IOR_LSBITS;
+
+	for (dma_idx = first_idx; dma_idx <= last_idx; dma_idx++)
+		_ior_dma_to_phys[dma_idx].offset = delta >> IOR_DMA_SHIFT;
+}
+
+/**
+ * setup_phys_to_dma - set up conversion from DMA to physical addresses
+ * @phys_idx:	Top IOR_LSBITS bits of the DMA address, i.e. an index
+ *		into the array _phys_to_dma.
+ * @delta:	Value that, when added to the DMA address, will yield the
+ *		physical address
+ * @s:		Number of bytes in the section of memory with the given delta
+ *		between DMA and physical addresses.
+ */
+static void setup_phys_to_dma(phys_addr_t phys, dma_addr_t delta, phys_addr_t s)
+{
+	int phys_idx, first_idx, last_idx;
+	phys_addr_t first, last;
+
+	/*
+	 * Calculate the first and last indices, rounding the first up and
+	 * the second down.
+	 */
+	first = phys & ~IOR_PHYS_GRAIN_MASK;
+	last = (phys + s - 1) & ~IOR_PHYS_GRAIN_MASK;
+	first_idx = first >> IOR_LSBITS;		/* Convert to indices */
+	last_idx = last >> IOR_LSBITS;
+
+	for (phys_idx = first_idx; phys_idx <= last_idx; phys_idx++)
+		_ior_phys_to_dma[phys_idx].offset = delta >> IOR_PHYS_SHIFT;
+}
+
+/**
+ * ioremap_add_map - add to the physical and DMA address conversion arrays
+ * @phys:	Process's view of the address of the start of the memory chunk
+ * @dma:	DMA address of the start of the memory chunk
+ * @size:	Size, in bytes, of the chunk of memory
+ *
+ * NOTE: It might be obvious, but the assumption is that all @size bytes have
+ * the same offset between the physical address and the DMA address.
+ */
+void ioremap_add_map(phys_addr_t phys, phys_addr_t dma, phys_addr_t size)
+{
+	if (size == 0)
+		return;
+
+	if ((dma & IOR_DMA_GRAIN_MASK) != 0 ||
+		(phys & IOR_PHYS_GRAIN_MASK) != 0 ||
+		(size & IOR_PHYS_GRAIN_MASK) != 0)
+		pr_crit("Memory allocation must be in chunks of 0x%x bytes\n",
+			IOR_PHYS_GRAIN);
+
+	setup_dma_to_phys(dma, phys - dma, size);
+	setup_phys_to_dma(phys, dma - phys, size);
+}
diff --git a/arch/mips/powertv/memory.c b/arch/mips/powertv/memory.c
index f49eb3d..c463cd3 100644
--- a/arch/mips/powertv/memory.c
+++ b/arch/mips/powertv/memory.c
@@ -30,28 +30,140 @@
 #include <asm/sections.h>
 
 #include <asm/mips-boards/prom.h>
+#include <asm/mach-powertv/asic.h>
+#include <asm/mach-powertv/ioremap.h>
 
 #include "init.h"
 
 /* Memory constants */
 #define KIBIBYTE(n)		((n) * 1024)	/* Number of kibibytes */
 #define MEBIBYTE(n)		((n) * KIBIBYTE(1024)) /* Number of mebibytes */
-#define DEFAULT_MEMSIZE		MEBIBYTE(256)	/* If no memsize provided */
-#define LOW_MEM_MAX		MEBIBYTE(252)	/* Max usable low mem */
-#define RES_BOOTLDR_MEMSIZE	MEBIBYTE(1)	/* Memory reserved for bldr */
-#define BOOT_MEM_SIZE		KIBIBYTE(256)	/* Memory reserved for bldr */
-#define PHYS_MEM_START		0x10000000	/* Start of physical memory */
+#define DEFAULT_MEMSIZE		MEBIBYTE(128)	/* If no memsize provided */
 
-char __initdata cmdline[COMMAND_LINE_SIZE];
+#define BLDR_SIZE	KIBIBYTE(256)		/* Memory reserved for bldr */
+#define RV_SIZE		MEBIBYTE(4)		/* Size of reset vector */
 
-void __init prom_meminit(void)
+#define LOW_MEM_END	0x20000000		/* Highest low memory address */
+#define BLDR_ALIAS	0x10000000		/* Bootloader address */
+#define RV_PHYS		0x1fc00000		/* Reset vector address */
+#define LOW_RAM_END	RV_PHYS			/* End of real RAM in low mem */
+
+/*
+ * Very low-level conversion from processor physical address to device
+ * DMA address for the first bank of memory.
+ */
+#define PHYS_TO_DMA(paddr)	((paddr) + (CONFIG_LOW_RAM_DMA - LOW_RAM_ALIAS))
+
+unsigned long ptv_memsize;
+
+/*
+ * struct low_mem_reserved - Items in low memmory that are reserved
+ * @start:	Physical address of item
+ * @size:	Size, in bytes, of this item
+ * @is_aliased:	True if this is RAM aliased from another location. If false,
+ *		it is something other than aliased RAM and the RAM in the
+ *		unaliased address is still visible outside of low memory.
+ */
+struct low_mem_reserved {
+	phys_addr_t	start;
+	phys_addr_t	size;
+	bool		is_aliased;
+};
+
+/*
+ * Must be in ascending address order
+ */
+struct low_mem_reserved low_mem_reserved[] = {
+	{BLDR_ALIAS, BLDR_SIZE, true},	/* Bootloader RAM */
+	{RV_PHYS, RV_SIZE, false},	/* Reset vector */
+};
+
+/*
+ * struct mem_layout - layout of a piece of the system RAM
+ * @phys:	Physical address of the start of this piece of RAM. This is the
+ *		address at which both the processor and I/O devices see the
+ *		RAM.
+ * @alias:	Alias of this piece of memory in order to make it appear in
+ *		the low memory part of the processor's address space. I/O
+ *		devices don't see anything here.
+ * @size:	Size, in bytes, of this piece of RAM
+ */
+struct mem_layout {
+	phys_addr_t	phys;
+	phys_addr_t	alias;
+	phys_addr_t	size;
+};
+
+/*
+ * struct mem_layout_list - list descriptor for layouts of system RAM pieces
+ * @family:	Specifies the family being described
+ * @n:		Number of &struct mem_layout elements
+ * @layout:	Pointer to the list of &mem_layout structures
+ */
+struct mem_layout_list {
+	enum family_type	family;
+	size_t			n;
+	struct mem_layout	*layout;
+};
+
+static struct mem_layout f1500_layout[] = {
+	{0x20000000, 0x10000000, MEBIBYTE(256)},
+};
+
+static struct mem_layout f4500_layout[] = {
+	{0x40000000, 0x10000000, MEBIBYTE(256)},
+	{0x20000000, 0x20000000, MEBIBYTE(32)},
+};
+
+static struct mem_layout f8500_layout[] = {
+	{0x40000000, 0x10000000, MEBIBYTE(256)},
+	{0x20000000, 0x20000000, MEBIBYTE(32)},
+	{0x30000000, 0x30000000, MEBIBYTE(32)},
+};
+
+static struct mem_layout fx600_layout[] = {
+	{0x20000000, 0x10000000, MEBIBYTE(256)},
+	{0x60000000, 0x60000000, MEBIBYTE(128)},
+};
+
+static struct mem_layout_list layout_list[] = {
+	{FAMILY_1500, ARRAY_SIZE(f1500_layout), f1500_layout},
+	{FAMILY_1500VZE, ARRAY_SIZE(f1500_layout), f1500_layout},
+	{FAMILY_1500VZF, ARRAY_SIZE(f1500_layout), f1500_layout},
+	{FAMILY_4500, ARRAY_SIZE(f4500_layout), f4500_layout},
+	{FAMILY_8500, ARRAY_SIZE(f8500_layout), f8500_layout},
+	{FAMILY_8500RNG, ARRAY_SIZE(f8500_layout), f8500_layout},
+	{FAMILY_4600, ARRAY_SIZE(fx600_layout), fx600_layout},
+	{FAMILY_4600VZA, ARRAY_SIZE(fx600_layout), fx600_layout},
+	{FAMILY_8600, ARRAY_SIZE(fx600_layout), fx600_layout},
+	{FAMILY_8600VZB, ARRAY_SIZE(fx600_layout), fx600_layout},
+};
+
+/* If we can't determine the layout, use this */
+static struct mem_layout default_layout[] = {
+	{0x20000000, 0x10000000, MEBIBYTE(128)},
+};
+
+/**
+ * register_non_ram - register low memory not available for RAM usage
+ */
+static __init void register_non_ram(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(low_mem_reserved); i++)
+		add_memory_region(low_mem_reserved[i].start,
+			low_mem_reserved[i].size, BOOT_MEM_RESERVED);
+}
+
+/**
+ * get_memsize - get the size of memory as a single bank
+ */
+static phys_addr_t get_memsize(void)
 {
+	phys_addr_t memsize = 0;
 	char *memsize_str;
-	unsigned long memsize = 0;
-	unsigned int physend;
-	char *ptr;
-	int low_mem;
-	int high_mem;
+	char cmdline[COMMAND_LINE_SIZE], *ptr;
 
 	/* Check the command line first for a memsize directive */
 	strcpy(cmdline, arcs_cmdline);
@@ -73,96 +185,156 @@ void __init prom_meminit(void)
 		if (memsize == 0) {
 			if (_prom_memsize != 0) {
 				memsize = _prom_memsize;
-				pr_info("_prom_memsize = 0x%lx\n", memsize);
+				pr_info("_prom_memsize = 0x%x\n", memsize);
 				/* add in memory that the bootloader doesn't
 				 * report */
-				memsize += BOOT_MEM_SIZE;
+				memsize += BLDR_SIZE;
 			} else {
 				memsize = DEFAULT_MEMSIZE;
 				pr_info("Memsize not passed by bootloader, "
-					"defaulting to 0x%lx\n", memsize);
+					"defaulting to 0x%x\n", memsize);
 			}
 		}
 	}
 
-	physend = PFN_ALIGN(&_end) - 0x80000000;
-	if (memsize > LOW_MEM_MAX) {
-		low_mem = LOW_MEM_MAX;
-		high_mem = memsize - low_mem;
-	} else {
-		low_mem = memsize;
-		high_mem = 0;
+	return memsize;
+}
+
+/**
+ * register_low_ram - register an aliased section of RAM
+ * @p:		Alias address of memory
+ * @n:		Number of bytes in this section of memory
+ *
+ * Returns the number of bytes registered
+ *
+ */
+static __init phys_addr_t register_low_ram(phys_addr_t p, phys_addr_t n)
+{
+	phys_addr_t s;
+	int i;
+	phys_addr_t orig_n;
+
+	orig_n = n;
+
+	BUG_ON(p + n > RV_PHYS);
+
+	for (i = 0; n != 0 && i < ARRAY_SIZE(low_mem_reserved); i++) {
+		phys_addr_t start;
+		phys_addr_t size;
+
+		start = low_mem_reserved[i].start;
+		size = low_mem_reserved[i].size;
+
+		/* Handle memory before this low memory section */
+		if (p < start) {
+			phys_addr_t s;
+			s = min(n, start - p);
+			add_memory_region(p, s, BOOT_MEM_RAM);
+			p += s;
+			n -= s;
+		}
+
+		/* Handle the low memory section itself. If it's aliased,
+		 * we reduce the number of byes left, but if not, the RAM
+		 * is available elsewhere and we don't reduce the number of
+		 * bytes remaining. */
+		if (p == start) {
+			if (low_mem_reserved[i].is_aliased) {
+				s = min(n, size);
+				n -= s;
+				p += s;
+			} else
+				p += n;
+		}
 	}
 
+	return orig_n - n;
+}
+
 /*
- * TODO: We will use the hard code for memory configuration until
- * the bootloader releases their device tree to us.
+ * register_ram - register real RAM
+ * @p:	Address of memory as seen by devices
+ * @alias:	If the memory is seen at an additional address by the processor,
+ *		this will be the address, otherwise it is the same as @p.
+ * @n:		Number of bytes in this section of memory
  */
+static __init void register_ram(phys_addr_t p, phys_addr_t alias,
+	phys_addr_t n)
+{
 	/*
-	 * Add the memory reserved for use by the bootloader to the
-	 * memory map.
-	 */
-	add_memory_region(PHYS_MEM_START, RES_BOOTLDR_MEMSIZE,
-		BOOT_MEM_RESERVED);
-#ifdef CONFIG_HIGHMEM_256_128
-	/*
-	 * Add memory in low for general use by the kernel and its friends
-	 * (like drivers, applications, etc).
-	 */
-	add_memory_region(PHYS_MEM_START + RES_BOOTLDR_MEMSIZE,
-		LOW_MEM_MAX - RES_BOOTLDR_MEMSIZE, BOOT_MEM_RAM);
-	/*
-	 * Add the memory reserved for reset vector.
-	 */
-	add_memory_region(0x1fc00000, MEBIBYTE(4), BOOT_MEM_RESERVED);
-	/*
-	 * Add the memory reserved.
-	 */
-	add_memory_region(0x20000000, MEBIBYTE(1024 + 75), BOOT_MEM_RESERVED);
-	/*
-	 * Add memory in high for general use by the kernel and its friends
-	 * (like drivers, applications, etc).
-	 *
-	 * 75MB is reserved for devices which are using the memory in high.
-	 */
-	add_memory_region(0x60000000 + MEBIBYTE(75), MEBIBYTE(128 - 75),
-		BOOT_MEM_RAM);
-#elif defined CONFIG_HIGHMEM_128_128
-	/*
-	 * Add memory in low for general use by the kernel and its friends
-	 * (like drivers, applications, etc).
-	 */
-	add_memory_region(PHYS_MEM_START + RES_BOOTLDR_MEMSIZE,
-		MEBIBYTE(128) - RES_BOOTLDR_MEMSIZE, BOOT_MEM_RAM);
-	/*
-	 * Add the memory reserved.
-	 */
-	add_memory_region(PHYS_MEM_START + MEBIBYTE(128),
-		MEBIBYTE(128 + 1024 + 75), BOOT_MEM_RESERVED);
-	/*
-	 * Add memory in high for general use by the kernel and its friends
-	 * (like drivers, applications, etc).
-	 *
-	 * 75MB is reserved for devices which are using the memory in high.
-	 */
-	add_memory_region(0x60000000 + MEBIBYTE(75), MEBIBYTE(128 - 75),
-		BOOT_MEM_RAM);
-#else
-	/* Add low memory regions for either:
-	 *   - no-highmemory configuration case -OR-
-	 *   - highmemory "HIGHMEM_LOWBANK_ONLY" case
-	 */
-	/*
-	 * Add memory for general use by the kernel and its friends
-	 * (like drivers, applications, etc).
+	 * If some or all of this memory has an alias, break it into the
+	 * aliased and non-aliased portion.
 	 */
-	add_memory_region(PHYS_MEM_START + RES_BOOTLDR_MEMSIZE,
-		low_mem - RES_BOOTLDR_MEMSIZE, BOOT_MEM_RAM);
+	if (p != alias) {
+		phys_addr_t alias_size;
+		phys_addr_t registered;
+
+		alias_size = min(n, LOW_RAM_END - alias);
+		registered = register_low_ram(alias, alias_size);
+		ioremap_add_map(alias, p, n);
+		n -= registered;
+		p += registered;
+	}
+
+#ifdef CONFIG_HIGHMEM
+	if (n != 0) {
+		add_memory_region(p, n, BOOT_MEM_RAM);
+		ioremap_add_map(p, p, n);
+	}
+#endif
+}
+
+/**
+ * register_address_space - register things in the address space
+ * @memsize:	Number of bytes of RAM installed
+ *
+ * Takes the given number of bytes of RAM and registers as many of the regions,
+ * or partial regions, as it can. So, the default configuration might have
+ * two regions with 256 MiB each. If the memsize passed in on the command line
+ * is 384 MiB, it will register the first region with 256 MiB and the second
+ * with 128 MiB.
+ */
+static __init void register_address_space(phys_addr_t memsize)
+{
+	int i;
+	phys_addr_t size;
+	size_t n;
+	struct mem_layout *layout;
+	enum family_type family;
+
 	/*
-	 * Add the memory reserved for reset vector.
+	 * Register all of the things that aren't available to the kernel as
+	 * memory.
 	 */
-	add_memory_region(0x1fc00000, MEBIBYTE(4), BOOT_MEM_RESERVED);
-#endif
+	register_non_ram();
+
+	/* Find the appropriate memory description */
+	family = platform_get_family();
+
+	for (i = 0; i < ARRAY_SIZE(layout_list); i++) {
+		if (layout_list[i].family == family)
+			break;
+	}
+
+	if (i == ARRAY_SIZE(layout_list)) {
+		n = ARRAY_SIZE(default_layout);
+		layout = default_layout;
+	} else {
+		n = layout_list[i].n;
+		layout = layout_list[i].layout;
+	}
+
+	for (i = 0; memsize != 0 && i < n; i++) {
+		size = min(memsize, layout[i].size);
+		register_ram(layout[i].phys, layout[i].alias, size);
+		memsize -= size;
+	}
+}
+
+void __init prom_meminit(void)
+{
+	ptv_memsize = get_memsize();
+	register_address_space(ptv_memsize);
 }
 
 void __init prom_free_prom_memory(void)
