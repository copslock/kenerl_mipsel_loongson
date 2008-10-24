Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 01:58:23 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:4710 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22251718AbYJXA5c (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Oct 2008 01:57:32 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49011d630001>; Thu, 23 Oct 2008 20:57:07 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 23 Oct 2008 17:57:06 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 23 Oct 2008 17:57:06 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id m9O0v2RQ005565;
	Thu, 23 Oct 2008 17:57:02 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id m9O0v1g5005564;
	Thu, 23 Oct 2008 17:57:01 -0700
From:	ddaney@caviumnetworks.com
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: [PATCH 01/37] Add Cavium OCTEON processor support files to arch/mips/cavium-octeon.
Date:	Thu, 23 Oct 2008 17:56:25 -0700
Message-Id: <1224809821-5532-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1224809821-5532-1-git-send-email-ddaney@caviumnetworks.com>
References: <1224809821-5532-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 24 Oct 2008 00:57:06.0704 (UTC) FILETIME=[6FA00900:01C93573]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20882
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

From: David Daney <ddaney@caviumnetworks.com>

Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Signed-off-by: Paul Gortmaker <Paul.Gortmaker@windriver.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/Kconfig         |   85 +++++
 arch/mips/cavium-octeon/Makefile        |   21 ++
 arch/mips/cavium-octeon/console.c       |   34 ++
 arch/mips/cavium-octeon/dma-octeon.c    |  324 +++++++++++++++++++
 arch/mips/cavium-octeon/flash_setup.c   |   76 +++++
 arch/mips/cavium-octeon/hal.c           |  496 +++++++++++++++++++++++++++++
 arch/mips/cavium-octeon/hal.h           |  197 ++++++++++++
 arch/mips/cavium-octeon/i8259.c         |  180 +++++++++++
 arch/mips/cavium-octeon/irq.c           |   61 ++++
 arch/mips/cavium-octeon/octeon-memcpy.S |  521 +++++++++++++++++++++++++++++++
 arch/mips/cavium-octeon/serial.c        |  187 +++++++++++
 arch/mips/cavium-octeon/setup.c         |  387 +++++++++++++++++++++++
 arch/mips/cavium-octeon/smp.c           |  231 ++++++++++++++
 arch/mips/cavium-octeon/userio.c        |  156 +++++++++
 14 files changed, 2956 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/cavium-octeon/Kconfig
 create mode 100644 arch/mips/cavium-octeon/Makefile
 create mode 100644 arch/mips/cavium-octeon/console.c
 create mode 100644 arch/mips/cavium-octeon/dma-octeon.c
 create mode 100644 arch/mips/cavium-octeon/flash_setup.c
 create mode 100644 arch/mips/cavium-octeon/hal.c
 create mode 100644 arch/mips/cavium-octeon/hal.h
 create mode 100644 arch/mips/cavium-octeon/i8259.c
 create mode 100644 arch/mips/cavium-octeon/irq.c
 create mode 100644 arch/mips/cavium-octeon/octeon-memcpy.S
 create mode 100644 arch/mips/cavium-octeon/serial.c
 create mode 100644 arch/mips/cavium-octeon/setup.c
 create mode 100644 arch/mips/cavium-octeon/smp.c
 create mode 100644 arch/mips/cavium-octeon/userio.c

diff --git a/arch/mips/cavium-octeon/Kconfig b/arch/mips/cavium-octeon/Kconfig
new file mode 100644
index 0000000..094c17e
--- /dev/null
+++ b/arch/mips/cavium-octeon/Kconfig
@@ -0,0 +1,85 @@
+config CAVIUM_OCTEON_SPECIFIC_OPTIONS
+	bool "Enable Octeon specific options"
+	depends on CPU_CAVIUM_OCTEON
+	default "y"
+
+config CAVIUM_OCTEON_2ND_KERNEL
+	bool "Build the kernel to be used as a 2nd kernel on the same chip"
+	depends on CAVIUM_OCTEON_SPECIFIC_OPTIONS
+	default "n"
+	help
+	  This option configures this kernel to be linked at a different
+	  address and use the 2nd uart for output. This allows a kernel built
+	  with this option to be run at the same time as one built without this
+	  option.
+
+config CAVIUM_OCTEON_HW_FIX_UNALIGNED
+	bool "Enable hardware fixups of unaligned loads and stores"
+	depends on CAVIUM_OCTEON_SPECIFIC_OPTIONS
+	default "y"
+	help
+	  Configure the Octeon hardware to automatically fix unaligned loads
+	  and stores. Normally unaligned accesses are fixed using a kernel
+	  exception handler. This option enables the hardware automatic fixups,
+	  which requires only an extra 3 cycles. Disable this option if you
+	  are running code that relies on address exceptions on unaligned
+	  accesses.
+
+config CAVIUM_OCTEON_CVMSEG_SIZE
+	int "Number of L1 cache lines reserved for CVMSEG memory"
+	depends on CAVIUM_OCTEON_SPECIFIC_OPTIONS
+	range 0 54
+	default 1
+	help
+	  CVMSEG LM is a segment that accesses portions of the dcache as a
+	  local memory; the larger CVMSEG is, the smaller the cache is.
+	  This selects the size of CVMSEG LM, which is in cache blocks. The
+	  legally range is from zero to 54 cache blocks (i.e. CVMSEG LM is
+	  between zero and 6192 bytes).
+
+config CAVIUM_OCTEON_LOCK_L2
+	bool "Lock often used kernel code in the L2"
+	depends on CAVIUM_OCTEON_SPECIFIC_OPTIONS
+	default "y"
+	help
+	  Enable locking parts of the kernel into the L2 cache.
+
+config CAVIUM_OCTEON_LOCK_L2_TLB
+	bool "Lock the TLB handler in L2"
+	depends on CAVIUM_OCTEON_LOCK_L2
+	default "y"
+	help
+	  Lock the low level TLB fast path into L2.
+
+config CAVIUM_OCTEON_LOCK_L2_EXCEPTION
+	bool "Lock the exception handler in L2"
+	depends on CAVIUM_OCTEON_LOCK_L2
+	default "y"
+	help
+	  Lock the low level exception handler into L2.
+
+config CAVIUM_OCTEON_LOCK_L2_LOW_LEVEL_INTERRUPT
+	bool "Lock the interrupt handler in L2"
+	depends on CAVIUM_OCTEON_LOCK_L2
+	default "y"
+	help
+	  Lock the low level interrupt handler into L2.
+
+config CAVIUM_OCTEON_LOCK_L2_INTERRUPT
+	bool "Lock the 2nd level interrupt handler in L2"
+	depends on CAVIUM_OCTEON_LOCK_L2
+	default "y"
+	help
+	  Lock the 2nd level interrupt handler in L2.
+
+config CAVIUM_OCTEON_LOCK_L2_MEMCPY
+	bool "Lock memcpy() in L2"
+	depends on CAVIUM_OCTEON_LOCK_L2
+	default "y"
+	help
+	  Lock the kernel's implementation of memcpy() into L2.
+
+config ARCH_SPARSEMEM_ENABLE
+	def_bool y
+	select SPARSEMEM_STATIC
+	depends on CPU_CAVIUM_OCTEON
diff --git a/arch/mips/cavium-octeon/Makefile b/arch/mips/cavium-octeon/Makefile
new file mode 100644
index 0000000..43d5a98
--- /dev/null
+++ b/arch/mips/cavium-octeon/Makefile
@@ -0,0 +1,21 @@
+#
+# Makefile for the Cavium Octeon specific kernel interface routines
+# under Linux.
+#
+# This file is subject to the terms and conditions of the GNU General Public
+# License.  See the file "COPYING" in the main directory of this archive
+# for more details.
+#
+# Copyright (C) 2005-2007 Cavium Networks
+#
+
+OCTEON_ROOT = $(srctree)/arch/mips/cavium-octeon
+EXTRA_CFLAGS +=	-I$(OCTEON_ROOT)/executive/config \
+		-I$(OCTEON_ROOT)/executive
+
+obj-y := setup.o serial.o irq.o hal.o
+obj-y += dma-octeon.o userio.o flash_setup.o
+obj-y += octeon-memcpy.o
+obj-y += console.o
+
+obj-$(CONFIG_SMP)                     += smp.o
diff --git a/arch/mips/cavium-octeon/console.c b/arch/mips/cavium-octeon/console.c
new file mode 100644
index 0000000..492a190
--- /dev/null
+++ b/arch/mips/cavium-octeon/console.c
@@ -0,0 +1,34 @@
+/*
+ * Carsten Langgaard, carstenl@mips.com
+ * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * Putting things on the screen/serial line using YAMONs facilities.
+ */
+#include "hal.h"
+
+int prom_putchar(char c)
+{
+	uint64_t lsrval;
+
+	/* Spin until there is room */
+	do {
+		lsrval = cvmx_read_csr(CVMX_MIO_UARTX_LSR(0));
+	} while ((lsrval & 0x20) == 0);
+
+	/* Write the byte */
+	cvmx_write_csr(CVMX_MIO_UARTX_THR(0), c);
+	return 1;
+}
diff --git a/arch/mips/cavium-octeon/dma-octeon.c b/arch/mips/cavium-octeon/dma-octeon.c
new file mode 100644
index 0000000..e74f59c
--- /dev/null
+++ b/arch/mips/cavium-octeon/dma-octeon.c
@@ -0,0 +1,324 @@
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
+ * Cavium Networks: Create new dma setup for Cavium Networks Octeon based on
+ * the kernels original.
+ */
+#include <linux/types.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/dma-mapping.h>
+#include <linux/platform_device.h>
+#include <linux/scatterlist.h>
+
+#include <linux/cache.h>
+#include <linux/io.h>
+
+#include <dma-coherence.h>
+
+#include "hal.h"
+#ifdef CONFIG_PCI
+#include "pci-common.h"
+#endif
+
+#define BAR2_PCI_ADDRESS 0x8000000000ul
+
+struct bar1_index_state {
+	int16_t ref_count;	/* Number of PCI mappings using this index */
+	int16_t address_bits;	/* Upper bits of physical address. This is
+				   shifted 22 bits */
+};
+
+#ifdef CONFIG_PCI
+static DEFINE_SPINLOCK(bar1_lock);
+static struct bar1_index_state bar1_state[32] = { {0, 0}, };
+#endif
+
+dma_addr_t octeon_map_dma_mem(struct device *dev, void *ptr, size_t size)
+{
+#ifndef CONFIG_PCI
+	/* Without PCI/PCIe this function can be called for Octeon internal
+	   devices such as USB. These devices all support 64bit addressing */
+	return virt_to_phys(ptr);
+#else
+	unsigned long flags;
+	uint64_t dma_mask;
+	int64_t start_index;
+	dma_addr_t result = -1;
+	uint64_t physical = virt_to_phys(ptr);
+	int64_t index;
+
+	/* Use the DMA masks to determine the allowed memory region. For us it
+	   doesn't limit the actual memory, just the address visible over PCI.
+	   Devices with limits need to use lower indexed Bar1 entries. */
+	if (dev) {
+		dma_mask = dev->coherent_dma_mask;
+		if (dev->dma_mask)
+			dma_mask = *dev->dma_mask;
+	} else
+		dma_mask = 0xfffffffful;
+
+	/* Platform devices, such as the internal USB, skip all translation and
+	   use Octeon physical addresses directly */
+	if (dev->bus == &platform_bus_type)
+		return physical;
+
+	switch (octeon_dma_bar_type) {
+	case OCTEON_DMA_BAR_TYPE_PCIE:
+		if (unlikely(physical < (16ul << 10)))
+			panic("dma_map_single: Not allowed to map first 16KB."
+			      " It interferes with BAR0 special area\n");
+		else if ((physical + size >= (256ul << 20)) &&
+			 (physical < (512ul << 20)))
+			panic("dma_map_single: Not allowed to map bootbus\n");
+		else if ((physical + size >= 0x400000000ull) &&
+			 physical < 0x410000000ull)
+			panic("dma_map_single: "
+			      "Attempt to map illegal memory address 0x%lx\n",
+			      physical);
+		else if (physical >= 0x420000000ull)
+			panic("dma_map_single: "
+			      "Attempt to map illegal memory address 0x%lx\n",
+			      physical);
+		else if ((physical + size >=
+			  (4ull<<30) - (OCTEON_PCI_BAR1_HOLE_SIZE<<20))
+			 && physical < (4ull<<30))
+			pr_warning("dma_map_single: Warning: "
+				   "Mapping memory address that might "
+				   "conflict with devices 0x%lx-0x%lx\n",
+				   physical, physical+size-1);
+		/* The 2nd 256MB is mapped at 256<<20 instead of 0x410000000 */
+		if ((physical >= 0x410000000ull) && physical < 0x420000000ull)
+			result = physical - 0x400000000ull;
+		else
+			result = physical;
+		if (((result+size-1) & dma_mask) != result+size-1)
+			panic("dma_map_single: Attempt to map address "
+			      "0x%lx-0x%lx, which can't be accessed according "
+			      "to the dma mask 0x%lx\n",
+			      physical, physical+size-1, dma_mask);
+		goto done;
+
+	case OCTEON_DMA_BAR_TYPE_BIG:
+#ifdef CONFIG_64BIT
+		/* If the device supports 64bit addressing, then use BAR2 */
+		if (dma_mask > BAR2_PCI_ADDRESS) {
+			result = physical + BAR2_PCI_ADDRESS;
+			goto done;
+		}
+#endif
+		if (unlikely(physical < (4ul << 10))) {
+			panic("dma_map_single: Not allowed to map first 4KB. "
+			      "It interferes with BAR0 special area\n");
+		} else if (physical < (256ul << 20)) {
+			if (unlikely(physical + size > (256ul << 20)))
+				panic("dma_map_single: Requested memory spans "
+				      "Bar0 0:256MB and bootbus\n");
+			result = physical;
+			goto done;
+		} else if (unlikely(physical < (512ul << 20))) {
+			panic("dma_map_single: Not allowed to map bootbus\n");
+		} else if (physical < (2ul << 30)) {
+			if (unlikely(physical + size > (2ul << 30)))
+				panic("dma_map_single: Requested memory spans "
+				      "Bar0 512MB:2GB and BAR1\n");
+			result = physical;
+			goto done;
+		} else if (physical < (2ul << 30) + (128 << 20)) {
+			/* Fall through */
+		} else if (physical <
+			   (4ul << 30) - (OCTEON_PCI_BAR1_HOLE_SIZE << 20)) {
+			if (unlikely
+			    (physical + size >
+			     (4ul << 30) - (OCTEON_PCI_BAR1_HOLE_SIZE << 20)))
+				panic("dma_map_single: Requested memory "
+				      "extends past Bar1 (4GB-%luMB)\n",
+				      OCTEON_PCI_BAR1_HOLE_SIZE);
+			result = physical;
+			goto done;
+		} else if ((physical >= 0x410000000ull) &&
+			   (physical < 0x420000000ull)) {
+			if (unlikely(physical + size > 0x420000000ull))
+				panic("dma_map_single: Requested memory spans "
+				      "non existant memory\n");
+			/* BAR0 fixed mapping 256MB:512MB ->
+			 * 16GB+256MB:16GB+512MB */
+			result = physical - 0x400000000ull;
+			goto done;
+		} else {
+			/* Continued below switch statement */
+		}
+		break;
+
+	case OCTEON_DMA_BAR_TYPE_SMALL:
+#ifdef CONFIG_64BIT
+		/* If the device supports 64bit addressing, then use BAR2 */
+		if (dma_mask > BAR2_PCI_ADDRESS) {
+			result = physical + BAR2_PCI_ADDRESS;
+			goto done;
+		}
+#endif
+		/* Continued below switch statement */
+		break;
+
+	default:
+		panic("dma_map_single: Invalid octeon_dma_bar_type\n");
+	}
+
+	/* Don't allow mapping to span multiple Bar entries. The hardware guys
+	   won't guarantee that DMA across boards work */
+	if (unlikely((physical >> 22) != ((physical + size - 1) >> 22)))
+		panic("dma_map_single: "
+		      "Requested memory spans more than one Bar1 entry\n");
+
+	if (octeon_dma_bar_type == OCTEON_DMA_BAR_TYPE_BIG)
+		start_index = 31;
+	else if (unlikely(dma_mask < (1ul << 27)))
+		start_index = (dma_mask >> 22);
+	else
+		start_index = 31;
+
+	/* Only one processor can access the Bar register at once */
+	spin_lock_irqsave(&bar1_lock, flags);
+
+	/* Look through Bar1 for existing mapping that will work */
+	for (index = start_index; index >= 0; index--) {
+		if ((bar1_state[index].address_bits == physical >> 22) &&
+		    (bar1_state[index].ref_count)) {
+			/* An existing mapping will work, use it */
+			bar1_state[index].ref_count++;
+			if (unlikely(bar1_state[index].ref_count < 0))
+				panic("dma_map_single: "
+				      "Bar1[%d] reference count overflowed\n",
+				      (int) index);
+			result = (index << 22) | (physical & ((1 << 22) - 1));
+			/* Large BAR1 is offset at 2GB */
+			if (octeon_dma_bar_type == OCTEON_DMA_BAR_TYPE_BIG)
+				result += 2ul << 30;
+			goto done_unlock;
+		}
+	}
+
+	/* No existing mappings, look for a free entry */
+	for (index = start_index; index >= 0; index--) {
+		if (unlikely(bar1_state[index].ref_count == 0)) {
+			cvmx_pci_bar1_indexx_t bar1_index;
+			/* We have a free entry, use it */
+			bar1_state[index].ref_count = 1;
+			bar1_state[index].address_bits = physical >> 22;
+			bar1_index.u32 = 0;
+			/* Address bits[35:22] sent to L2C */
+			bar1_index.s.addr_idx = physical >> 22;
+			/* Don't put PCI accesses in L2. */
+			bar1_index.s.ca = 1;
+			/* Endian Swap Mode */
+			bar1_index.s.end_swp = 1;
+			/* Set '1' when the selected address range is valid. */
+			bar1_index.s.addr_v = 1;
+			octeon_npi_write32(CVMX_NPI_PCI_BAR1_INDEXX(index),
+					   bar1_index.u32);
+			/* An existing mapping will work, use it */
+			result = (index << 22) | (physical & ((1 << 22) - 1));
+			/* Large BAR1 is offset at 2GB */
+			if (octeon_dma_bar_type == OCTEON_DMA_BAR_TYPE_BIG)
+				result += 2ul << 30;
+			goto done_unlock;
+		}
+	}
+
+	pr_err("dma_map_single: "
+	       "Can't find empty BAR1 index for physical mapping 0x%llx\n",
+	       (unsigned long long) physical);
+
+      done_unlock:
+	spin_unlock_irqrestore(&bar1_lock, flags);
+      done:
+	pr_debug("dma_map_single 0x%lx->0x%lx\n", physical, result);
+	return result;
+#endif
+}
+
+void octeon_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr)
+{
+#ifndef CONFIG_PCI
+	/* Without PCI/PCIe this function can be called for Octeon internal
+	 * devices such as USB. These devices all support 64bit addressing */
+	return;
+#else
+	unsigned long flags;
+	uint64_t index;
+
+	/* Platform devices, such as the internal USB, skip all translation and
+	   use Octeon physical addresses directly */
+	if (dev->bus == &platform_bus_type)
+		return;
+
+	switch (octeon_dma_bar_type) {
+	case OCTEON_DMA_BAR_TYPE_PCIE:
+		/* Nothing to do, all mappings are static */
+		goto done;
+
+	case OCTEON_DMA_BAR_TYPE_BIG:
+#ifdef CONFIG_64BIT
+		/* Nothing to do for addresses using BAR2 */
+		if (dma_addr >= BAR2_PCI_ADDRESS)
+			goto done;
+#endif
+		if (unlikely(dma_addr < (4ul << 10)))
+			panic("dma_unmap_single: Unexpect DMA address 0x%lx\n",
+			      dma_addr);
+		else if (dma_addr < (2ul << 30))
+			/* Nothing to do for addresses using BAR0 */
+			goto done;
+		else if (dma_addr < (2ul << 30) + (128ul << 20))
+			/* Need to unmap, fall through */
+			index = (dma_addr - (2ul << 30)) >> 22;
+		else if (dma_addr <
+			 (4ul << 30) - (OCTEON_PCI_BAR1_HOLE_SIZE << 20))
+			goto done;	/* Nothing to do for the rest of BAR1 */
+		else
+			panic("dma_unmap_single: Unexpect DMA address 0x%lx\n",
+			      dma_addr);
+		/* Continued below switch statement */
+		break;
+
+	case OCTEON_DMA_BAR_TYPE_SMALL:
+#ifdef CONFIG_64BIT
+		/* Nothing to do for addresses using BAR2 */
+		if (dma_addr >= BAR2_PCI_ADDRESS)
+			goto done;
+#endif
+		index = dma_addr >> 22;
+		/* Continued below switch statement */
+		break;
+
+	default:
+		panic("dma_unmap_single: Invalid octeon_dma_bar_type\n");
+	}
+
+	if (unlikely(index > 31))
+		panic("dma_unmap_single: "
+		      "Attempt to unmap an invalid address (0x%llx)\n",
+		      (unsigned long long) dma_addr);
+
+	spin_lock_irqsave(&bar1_lock, flags);
+	bar1_state[index].ref_count--;
+	if (bar1_state[index].ref_count == 0)
+		octeon_npi_write32(CVMX_NPI_PCI_BAR1_INDEXX(index), 0);
+	else if (unlikely(bar1_state[index].ref_count < 0))
+		panic("dma_unmap_single: Bar1[%u] reference count < 0\n",
+		      (int) index);
+	spin_unlock_irqrestore(&bar1_lock, flags);
+      done:
+	pr_debug("dma_unmap_single 0x%lx\n", dma_addr);
+	return;
+#endif
+}
diff --git a/arch/mips/cavium-octeon/flash_setup.c b/arch/mips/cavium-octeon/flash_setup.c
new file mode 100644
index 0000000..f66edb2
--- /dev/null
+++ b/arch/mips/cavium-octeon/flash_setup.c
@@ -0,0 +1,76 @@
+/*
+ *   Octeon Bootbus flash setup
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2007 Cavium Networks
+ */
+#include <linux/kernel.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/map.h>
+#include <linux/mtd/partitions.h>
+#include "hal.h"
+
+static struct map_info flash_map;
+static struct mtd_info *mymtd;
+#ifdef CONFIG_MTD_PARTITIONS
+static int nr_parts;
+static struct mtd_partition *parts;
+static const char *part_probe_types[] = {
+	"cmdlinepart",
+#ifdef CONFIG_MTD_REDBOOT_PARTS
+	"RedBoot",
+#endif
+	NULL
+};
+#endif
+
+/**
+ * Module/ driver initialization.
+ *
+ * @return Zero on success
+ */
+static int __init flash_init(void)
+{
+	/* Read the bootbus region 0 setup to determine where the base of flash
+	   is set for */
+	cvmx_mio_boot_reg_cfgx_t region_cfg;
+	region_cfg.u64 = cvmx_read_csr(CVMX_MIO_BOOT_REG_CFG0);
+	if (region_cfg.s.en) {
+		/* The bootloader always takes the flash and sets its address
+		   so the entire flash fits below 0x1fc00000. This way the
+		   flash aliases to 0x1fc00000 for booting. Software can access
+		   the full flash at the true address, while core boot can
+		   access 4MB */
+		flash_map.name = "phys_mapped_flash";	/* Use this name so old
+							   part lines work */
+		flash_map.phys = region_cfg.s.base << 16;
+		flash_map.size = 0x1fc00000 - flash_map.phys;
+		flash_map.bankwidth = 1;
+		flash_map.virt = ioremap(flash_map.phys, flash_map.size);
+		pr_notice("Bootbus flash: Setting flash for %luMB flash at 0x%08lx\n", flash_map.size >> 20, flash_map.phys);
+		simple_map_init(&flash_map);
+		mymtd = do_map_probe("cfi_probe", &flash_map);
+		if (mymtd) {
+			mymtd->owner = THIS_MODULE;
+
+#ifdef CONFIG_MTD_PARTITIONS
+			nr_parts =
+				parse_mtd_partitions(mymtd, part_probe_types,
+						     &parts, 0);
+			if (nr_parts > 0)
+				add_mtd_partitions(mymtd, parts, nr_parts);
+			else
+				add_mtd_device(mymtd);
+#else
+			add_mtd_device(mymtd);
+#endif
+		} else
+			pr_err("Failed to register MTD device for flash\n");
+	}
+	return 0;
+}
+
+late_initcall(flash_init);
diff --git a/arch/mips/cavium-octeon/hal.c b/arch/mips/cavium-octeon/hal.c
new file mode 100644
index 0000000..baff76f
--- /dev/null
+++ b/arch/mips/cavium-octeon/hal.c
@@ -0,0 +1,496 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2004 - 2007 Cavium Networks
+ */
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/module.h>
+
+#include <asm/time.h>
+
+#include <octeon-app-init.h>
+
+#ifndef CONFIG_CAVIUM_RESERVE32
+#define CONFIG_CAVIUM_RESERVE32 0
+#endif
+
+#include "hal.h"
+
+#include "cvmx-bootmem.h"
+#include "cvmx-bootinfo.h"
+#include "cvmx-sysinfo.h"
+#include "cvmx-l2c.h"
+
+extern void add_wired_entry(unsigned long entrylo0,
+			    unsigned long entrylo1,
+			    unsigned long entryhi,
+			    unsigned long pagemask);
+extern asmlinkage void handle_int(void);
+extern asmlinkage void plat_irq_dispatch(void);
+
+/* Set to non-zero, so it is not in .bss section and is not zeroed */
+volatile octeon_boot_descriptor_t *octeon_boot_desc_ptr = (void *) 0xEADBEEFULL;
+cvmx_bootinfo_t *octeon_bootinfo;
+
+/* This must not be static since inline functions access it */
+spinlock_t octeon_led_lock;
+
+#if CONFIG_CAVIUM_RESERVE32
+uint64_t octeon_reserve32_memory;
+#endif
+
+
+/**
+ * Write to the LCD display connected to the bootbus. This display
+ * exists on most Cavium evaluation boards. If it doesn't exist, then
+ * this function doesn't do anything.
+ *
+ * @param s      String to write
+ */
+void octeon_write_lcd(const char *s)
+{
+	if (octeon_bootinfo->led_display_base_addr) {
+		volatile char *lcd_address =
+			cvmx_phys_to_ptr(octeon_bootinfo->
+					 led_display_base_addr);
+		int i;
+		for (i = 0; i < 8; i++) {
+			if (*s)
+				lcd_address[i] = *s++;
+			else
+				lcd_address[i] = ' ';
+		}
+	}
+}
+
+
+/**
+ * Check the hardware BIST results for a CPU
+ */
+void octeon_check_cpu_bist(void)
+{
+	const int coreid = cvmx_get_core_num();
+	unsigned long long mask;
+	unsigned long long bist_val;
+
+	/* Check BIST results for COP0 registers */
+	mask = 0x1f00000000ull;
+	bist_val = __read_64bit_c0_register($27, 0);
+	if (bist_val & mask)
+		pr_err("Core%d BIST Failure: CacheErr(icache) = 0x%llx\n",
+		       coreid, bist_val);
+
+	bist_val = __read_64bit_c0_register($27, 1);
+	if (bist_val & 1)
+		pr_err("Core%d L1 Dcache parity error: "
+		       "CacheErr(dcache) = 0x%llx\n",
+		       coreid, bist_val);
+
+	mask = 0xfc00000000000000ull;
+	bist_val = __read_64bit_c0_register($11, 7);
+	if (bist_val & mask)
+		pr_err("Core%d BIST Failure: COP0_CVM_MEM_CTL = 0x%llx\n",
+		       coreid, bist_val);
+
+	__write_64bit_c0_register($27, 1, 0);
+}
+
+
+/**
+ * Return non zero if we are currently running in the Octeon simulator
+ *
+ * @return
+ */
+int octeon_is_simulation(void)
+{
+	return octeon_bootinfo->board_type == CVMX_BOARD_TYPE_SIM;
+}
+
+
+/**
+ * Return true if Octeon is in PCI Host mode. This means
+ * Linux can control the PCI bus.
+ *
+ * @return Non zero if Octeon in host mode
+ */
+int octeon_is_pci_host(void)
+{
+#ifdef CONFIG_PCI
+	return octeon_bootinfo->config_flags & CVMX_BOOTINFO_CFG_FLAG_PCI_HOST;
+#else
+	return 0;
+#endif
+}
+
+
+/**
+ * This function returns if the USB clock uses 12/24/48MHz 3.3V
+ * reference clock at the USB_REF_CLK pin. Result is non zero
+ * if it does, If it uses 12MHz crystal as clock source at USB_XO
+ * and USB_XI, then the return value is zero. This function will
+ * need update for new boards.
+ *
+ * @return True is USB is using a reference clock
+ */
+int octeon_usb_is_ref_clk(void)
+{
+	switch (octeon_bootinfo->board_type) {
+	case CVMX_BOARD_TYPE_BBGW_REF:
+		return 0;
+	}
+	return 1;
+}
+
+
+/**
+ * Get the clock rate of Octeon
+ *
+ * @return Clock rate in HZ
+ */
+uint64_t octeon_get_clock_rate(void)
+{
+	if (octeon_is_simulation())
+		octeon_bootinfo->eclock_hz = 6000000;
+	return octeon_bootinfo->eclock_hz;
+}
+
+
+/**
+ * Return the board name as a constant string
+ *
+ * @return board name
+ */
+const char *octeon_board_type_string(void)
+{
+	static char name[80];
+	sprintf(name, "%s (%s)",
+		cvmx_board_type_to_string(octeon_bootinfo->board_type),
+		octeon_model_get_string(read_c0_prid()));
+	return name;
+}
+
+
+/**
+ * Return the interrupt line for the i8259 in the southbridge
+ *
+ * @return
+ */
+int octeon_get_southbridge_interrupt(void)
+{
+	switch (octeon_bootinfo->board_type) {
+	case CVMX_BOARD_TYPE_EBH3000:
+		return 47;	/* PCI INDD */
+	case CVMX_BOARD_TYPE_NAC38:
+		return 39;	/* GPIO 15 */
+	default:
+		return 0;	/* No southbridge */
+	}
+}
+
+
+/**
+ * Get the coremask Linux was booted on.
+ *
+ * @return Core mask
+ */
+int octeon_get_boot_coremask(void)
+{
+	return octeon_boot_desc_ptr->core_mask;
+}
+
+
+/**
+ * Return the number of arguments we got from the bootloader
+ *
+ * @return argc
+ */
+int octeon_get_boot_num_arguments(void)
+{
+	return octeon_boot_desc_ptr->argc;
+}
+
+
+/**
+ * Return the console uart passed by the bootloader
+ *
+ * @return uart   (0 or 1)
+ */
+int octeon_get_boot_uart(void)
+{
+#if OCTEON_APP_INIT_H_VERSION >= 1	/* The UART1 flag is new */
+	return !!(octeon_boot_desc_ptr->flags & OCTEON_BL_FLAG_CONSOLE_UART1);
+#else
+	return 0;
+#endif
+}
+
+/**
+ * Return the debug flag passed by the bootloader
+ *
+ * @return debug flag (0 or 1)
+ */
+int octeon_get_boot_debug_flag(void)
+{
+	return !!(octeon_boot_desc_ptr->flags & OCTEON_BL_FLAG_DEBUG);
+}
+
+/**
+ * Get an argument from the bootloader
+ *
+ * @param arg    argument to get
+ * @return argument
+ */
+const char *octeon_get_boot_argument(int arg)
+{
+	return cvmx_phys_to_ptr(octeon_boot_desc_ptr->argv[arg]);
+}
+
+
+/**
+ * Called very early in the initial C code to initialize the Octeon
+ * HAL layer.
+ */
+void octeon_hal_init(void)
+{
+	cvmx_sysinfo_t *sysinfo;
+
+	/* Make sure we got the boot descriptor block */
+	if ((octeon_boot_desc_ptr == (void *) 0xEADBEEFULL))
+		panic("Boot descriptor block wasn't passed properly\n");
+
+	octeon_bootinfo =
+		cvmx_phys_to_ptr(octeon_boot_desc_ptr->cvmx_desc_vaddr);
+	cvmx_bootmem_init(cvmx_phys_to_ptr(octeon_bootinfo->phy_mem_desc_addr));
+
+	spin_lock_init(&octeon_led_lock);
+	/* Only enable the LED controller if we're running on a CN38XX, CN58XX,
+	   or CN56XX. The CN30XX and CN31XX don't have an LED controller */
+	if (!octeon_is_simulation() &&
+	    octeon_has_feature(OCTEON_FEATURE_LED_CONTROLLER)) {
+		cvmx_write_csr(CVMX_LED_EN, 0);
+		cvmx_write_csr(CVMX_LED_PRT, 0);
+		cvmx_write_csr(CVMX_LED_DBG, 0);
+		cvmx_write_csr(CVMX_LED_PRT_FMT, 0);
+		cvmx_write_csr(CVMX_LED_UDD_CNTX(0), 32);
+		cvmx_write_csr(CVMX_LED_UDD_CNTX(1), 32);
+		cvmx_write_csr(CVMX_LED_UDD_DATX(0), 0);
+		cvmx_write_csr(CVMX_LED_UDD_DATX(1), 0);
+		cvmx_write_csr(CVMX_LED_EN, 1);
+	}
+#if CONFIG_CAVIUM_RESERVE32
+	{
+		int64_t addr = -1;
+		/* We need to temporarily allocate all memory in the reserve32
+		   region. This makes sure the kernel doesn't allocate this
+		   memory when it is getting memory from the bootloader. Later,
+		   after the memory allocations are complete, the reserve32
+		   will be freed */
+#ifdef CONFIG_CAVIUM_RESERVE32_USE_WIRED_TLB
+		if (CONFIG_CAVIUM_RESERVE32 & 0x1ff)
+			pr_err("CAVIUM_RESERVE32 isn't a multiple of 512MB. This is required if CAVIUM_RESERVE32_USE_WIRED_TLB is set\n");
+		else
+			addr = cvmx_bootmem_phy_named_block_alloc
+				(CONFIG_CAVIUM_RESERVE32 << 20, 0, 0, 512 << 20,
+				 "CAVIUM_RESERVE32", 0);
+#else
+		/* Allocate memory for RESERVED32 aligned on 2MB boundary. This
+		   is in case we later use hugetlb entries with it */
+		addr = cvmx_bootmem_phy_named_block_alloc
+			(CONFIG_CAVIUM_RESERVE32 << 20, 0, 0, 2 << 20,
+			 "CAVIUM_RESERVE32", 0);
+#endif
+		if (addr < 0)
+			pr_err("Failed to allocate CAVIUM_RESERVE32 memory area\n");
+		else
+			octeon_reserve32_memory = addr;
+
+	}
+#endif
+
+#ifdef CONFIG_CAVIUM_OCTEON_LOCK_L2
+	if (cvmx_read_csr(CVMX_L2D_FUS3) & (3ull << 34)) {
+		pr_info("Skipping L2 locking due to reduced L2 cache size\n");
+	} else {
+		uint32_t ebase = read_c0_ebase() & 0x3ffff000;
+#ifdef CONFIG_CAVIUM_OCTEON_LOCK_L2_TLB
+		cvmx_l2c_lock_mem_region(ebase, 0x100);	/* TLB refill */
+#endif
+#ifdef CONFIG_CAVIUM_OCTEON_LOCK_L2_EXCEPTION
+		cvmx_l2c_lock_mem_region(ebase + 0x180, 0x80);	/* General
+								   exception */
+#endif
+#ifdef CONFIG_CAVIUM_OCTEON_LOCK_L2_LOW_LEVEL_INTERRUPT
+		cvmx_l2c_lock_mem_region(ebase + 0x200, 0x80);	/* Interrupt
+								   handler */
+#endif
+#ifdef CONFIG_CAVIUM_OCTEON_LOCK_L2_INTERRUPT
+		cvmx_l2c_lock_mem_region(__pa_symbol(handle_int), 0x100);
+		cvmx_l2c_lock_mem_region(__pa_symbol(plat_irq_dispatch), 0x80);
+#endif
+#ifdef CONFIG_CAVIUM_OCTEON_LOCK_L2_MEMCPY
+		cvmx_l2c_lock_mem_region(__pa_symbol(memcpy), 0x480);
+#endif
+	}
+#endif
+
+	sysinfo = cvmx_sysinfo_get();
+	memset(sysinfo, 0, sizeof(*sysinfo));
+	sysinfo->system_dram_size = octeon_bootinfo->dram_size << 20;
+	sysinfo->phy_mem_desc_ptr =
+		cvmx_phys_to_ptr(octeon_bootinfo->phy_mem_desc_addr);
+	sysinfo->core_mask = octeon_bootinfo->core_mask;
+	sysinfo->exception_base_addr = octeon_bootinfo->exception_base_addr;
+	sysinfo->cpu_clock_hz = octeon_bootinfo->eclock_hz;
+	sysinfo->dram_data_rate_hz = octeon_bootinfo->dclock_hz * 2;
+	sysinfo->board_type = octeon_bootinfo->board_type;
+	sysinfo->board_rev_major = octeon_bootinfo->board_rev_major;
+	sysinfo->board_rev_minor = octeon_bootinfo->board_rev_minor;
+	memcpy(sysinfo->mac_addr_base, octeon_bootinfo->mac_addr_base,
+	       sizeof(sysinfo->mac_addr_base));
+	sysinfo->mac_addr_count = octeon_bootinfo->mac_addr_count;
+	memcpy(sysinfo->board_serial_number,
+	       octeon_bootinfo->board_serial_number,
+	       sizeof(sysinfo->board_serial_number));
+	sysinfo->compact_flash_common_base_addr =
+		octeon_bootinfo->compact_flash_common_base_addr;
+	sysinfo->compact_flash_attribute_base_addr =
+		octeon_bootinfo->compact_flash_attribute_base_addr;
+	sysinfo->led_display_base_addr = octeon_bootinfo->led_display_base_addr;
+	sysinfo->dfa_ref_clock_hz = octeon_bootinfo->dfa_ref_clock_hz;
+	sysinfo->bootloader_config_flags = octeon_bootinfo->config_flags;
+}
+
+
+#ifdef CONFIG_CAVIUM_RESERVE32_USE_WIRED_TLB
+/**
+ * Called on every core to setup the wired tlb entry needed
+ * if CONFIG_CAVIUM_RESERVE32_USE_WIRED_TLB is set.
+ *
+ * @param unused
+ */
+static void octeon_hal_setup_per_cpu_reserved32(void *unused)
+{
+	/* The config has selected to wire the reserve32 memory for all
+	   userspace applications. We need to put a wired TLB entry in for each
+	   512MB of reserve32 memory. We only handle double 256MB pages here,
+	   so reserve32 must be multiple of 512MB */
+	uint32_t size = CONFIG_CAVIUM_RESERVE32;
+	uint32_t entrylo0 =
+		0x7 | ((octeon_reserve32_memory & ((1ul << 40) - 1)) >> 6);
+	uint32_t entrylo1 = entrylo0 + (256 << 14);
+	uint32_t entryhi = (0x80000000UL - (CONFIG_CAVIUM_RESERVE32 << 20));
+	while (size >= 512) {
+		/*
+		pr_info("CPU%d: Adding double wired TLB entry for 0x%lx\n",
+		       smp_processor_id(), entryhi);
+		*/
+		add_wired_entry(entrylo0, entrylo1, entryhi, PM_256M);
+		entrylo0 += 512 << 14;
+		entrylo1 += 512 << 14;
+		entryhi += 512 << 20;
+		size -= 512;
+	}
+}
+#endif				/* CONFIG_CAVIUM_RESERVE32_USE_WIRED_TLB */
+
+/**
+ * Called to release the named block which was used to made sure
+ * that nobody used the memory for something else during
+ * init. Now we'll free it so userspace apps can use this
+ * memory region with bootmem_alloc.
+ *
+ * This function is called only once from prom_free_prom_memory().
+ */
+void octeon_hal_setup_reserved32(void)
+{
+#ifdef CONFIG_CAVIUM_RESERVE32_USE_WIRED_TLB
+	on_each_cpu(octeon_hal_setup_per_cpu_reserved32, NULL, 0, 1);
+#endif
+}
+
+
+/**
+ * Poweroff the Octeon board if possible.
+ */
+void octeon_poweroff(void)
+{
+	switch (octeon_bootinfo->board_type) {
+	case CVMX_BOARD_TYPE_NAO38:
+		/* Driving a 1 to GPIO 12 shuts off this board */
+		cvmx_write_csr(CVMX_GPIO_BIT_CFGX(12), 1);
+		cvmx_write_csr(CVMX_GPIO_TX_SET, 0x1000);
+		break;
+	default:
+		octeon_write_lcd("PowerOff");
+		break;
+	}
+}
+
+
+/**
+ * Enable access to Octeon's COP2 crypto hardware for kernel use.
+ * Wrap any crypto operations in calls to
+ * octeon_crypto_enable/disable in order to make sure the state of
+ * COP2 isn't corrupted if userspace is also performing hardware
+ * crypto operations. Allocate the state parameter on the stack.
+ *
+ * @param state  State structure to store current COP2 state in
+ *
+ * @return Flags to be passed to octeon_crypto_disable()
+ */
+unsigned long octeon_crypto_enable(struct octeon_cop2_state *state)
+{
+	extern void octeon_cop2_save(struct octeon_cop2_state *);
+	int status;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	status = read_c0_status();
+	write_c0_status(status | ST0_CU2);
+	if (KSTK_STATUS(current) & ST0_CU2) {
+		octeon_cop2_save(&(current->thread.cp2));
+		KSTK_STATUS(current) &= ~ST0_CU2;
+		status &= ~ST0_CU2;
+	} else if (status & ST0_CU2)
+		octeon_cop2_save(state);
+	local_irq_restore(flags);
+	return status & ST0_CU2;
+}
+EXPORT_SYMBOL(octeon_crypto_enable);
+
+
+/**
+ * Disable access to Octeon's COP2 crypto hardware in the kernel.
+ * This must be called after an octeon_crypto_enable() before any
+ * context switch or return to userspace.
+ *
+ * @param state  COP2 state to restore
+ * @param flags  Return value from octeon_crypto_enable()
+ */
+void octeon_crypto_disable(struct octeon_cop2_state *state, unsigned long crypto_flags)
+{
+	extern void octeon_cop2_restore(struct octeon_cop2_state *);
+	unsigned long flags;
+
+	local_irq_save(flags);
+	if (crypto_flags & ST0_CU2)
+		octeon_cop2_restore(state);
+	else
+		write_c0_status(read_c0_status() & ~ST0_CU2);
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL(octeon_crypto_disable);
+
+
+
+/* Misc exports */
+EXPORT_SYMBOL(octeon_is_simulation);
+EXPORT_SYMBOL(octeon_bootinfo);
+#if CONFIG_CAVIUM_RESERVE32
+EXPORT_SYMBOL(octeon_reserve32_memory);
+#endif
+
+EXPORT_SYMBOL(octeon_get_clock_rate);
diff --git a/arch/mips/cavium-octeon/hal.h b/arch/mips/cavium-octeon/hal.h
new file mode 100644
index 0000000..afa0759
--- /dev/null
+++ b/arch/mips/cavium-octeon/hal.h
@@ -0,0 +1,197 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2004-2007 Cavium Networks
+ */
+#ifndef __CAVIUM_OCTEON_HAL_H
+#define __CAVIUM_OCTEON_HAL_H
+
+#include "octeon-hal-read-write.h"
+
+#ifndef __BYTE_ORDER
+#  error "__BYTE_ORDER not set"
+#endif
+#ifndef __BIG_ENDIAN
+#  error "__BIG_ENDIAN not set"
+#endif
+
+extern uint64_t octeon_bootmem_alloc_range_phys(uint64_t size,
+						uint64_t alignment,
+						uint64_t min_addr,
+						uint64_t max_addr,
+						int do_locking);
+extern void *octeon_bootmem_alloc(uint64_t size, uint64_t alignment,
+				  int do_locking);
+extern void *octeon_bootmem_alloc_range(uint64_t size, uint64_t alignment,
+					uint64_t min_addr, uint64_t max_addr,
+					int do_locking);
+extern void *octeon_bootmem_alloc_named(uint64_t size, uint64_t alignment,
+					char *name);
+extern void *octeon_bootmem_alloc_named_range(uint64_t size, uint64_t min_addr,
+					      uint64_t max_addr, uint64_t align,
+					      char *name);
+extern void *octeon_bootmem_alloc_named_address(uint64_t size, uint64_t address,
+						char *name);
+extern int octeon_bootmem_free_named(char *name);
+extern void octeon_bootmem_lock(void);
+extern void octeon_bootmem_unlock(void);
+
+extern int octeon_is_simulation(void);
+extern int octeon_is_pci_host(void);
+extern int octeon_usb_is_ref_clk(void);
+extern uint64_t octeon_get_clock_rate(void);
+extern const char *octeon_board_type_string(void);
+extern const char *octeon_get_pci_interrupts(void);
+extern int octeon_get_southbridge_interrupt(void);
+extern int octeon_get_boot_coremask(void);
+extern int octeon_get_boot_num_arguments(void);
+extern const char *octeon_get_boot_argument(int arg);
+extern void octeon_hal_setup_reserved32(void);
+struct octeon_cop2_state;
+extern unsigned long octeon_crypto_enable(struct octeon_cop2_state *state);
+extern void octeon_crypto_disable(struct octeon_cop2_state *state,
+				  unsigned long flags);
+
+typedef union {
+	uint64_t u64;
+	struct {
+		/* RO 1 = BIST fail, 0 = BIST pass */
+		uint64_t tlbbist:1;
+		/* RO 1 = BIST fail, 0 = BIST pass */
+		uint64_t l1cbist:1;
+		/* RO 1 = BIST fail, 0 = BIST pass */
+		uint64_t l1dbist:1;
+		/* RO 1 = BIST fail, 0 = BIST pass */
+		uint64_t dcmbist:1;
+		/* RO 1 = BIST fail, 0 = BIST pass */
+		uint64_t ptgbist:1;
+		/* RO 1 = BIST fail, 0 = BIST pass */
+		uint64_t wbfbist:1;
+		/* Reserved */
+		uint64_t reserved:22;
+		/* R/W If set, marked write-buffer entries time out
+		 * the same as as other entries; if clear, marked
+		 * write-buffer entries use the maximum timeout. */
+		uint64_t dismarkwblongto:1;
+		/* R/W If set, a merged store does not clear the
+		 * write-buffer entry timeout state. */
+		uint64_t dismrgclrwbto:1;
+		/* R/W Two bits that are the MSBs of the resultant
+		 * CVMSEG LM word location for an IOBDMA. The other 8
+		 * bits come from the SCRADDR field of the IOBDMA. */
+		uint64_t iobdmascrmsb:2;
+		/* R/W If set, SYNCWS and SYNCS only order marked
+		 * stores; if clear, SYNCWS and SYNCS only order
+		 * unmarked stores. SYNCWSMARKED has no effect when
+		 * DISSYNCWS is set. */
+		uint64_t syncwsmarked:1;
+		/* R/W If set, SYNCWS acts as SYNCW and SYNCS acts as
+		 * SYNC. */
+		uint64_t dissyncws:1;
+		/* R/W If set, no stall happens on write buffer
+		 * full. */
+		uint64_t diswbfst:1;
+		/* R/W If set (and SX set), supervisor-level
+		 * loads/stores can use XKPHYS addresses with
+		 * VA<48>==0 */
+		uint64_t xkmemenas:1;
+		/* R/W If set (and UX set), user-level loads/stores
+		 * can use XKPHYS addresses with VA<48>==0 */
+		uint64_t xkmemenau:1;
+		/* R/W If set (and SX set), supervisor-level
+		 * loads/stores can use XKPHYS addresses with
+		 * VA<48>==1 */
+		uint64_t xkioenas:1;
+		/* R/W If set (and UX set), user-level loads/stores
+		 * can use XKPHYS addresses with VA<48>==1 */
+		uint64_t xkioenau:1;
+		/* R/W If set, all stores act as SYNCW (NOMERGE must
+		 * be set when this is set) RW, reset to 0. */
+		uint64_t allsyncw:1;
+		/* R/W If set, no stores merge, and all stores reach
+		 * the coherent bus in order. */
+		uint64_t nomerge:1;
+		/* R/W Selects the bit in the counter used for DID
+		 * time-outs 0 = 231, 1 = 230, 2 = 229, 3 =
+		 * 214. Actual time-out is between 1� and 2� this
+		 * interval. For example, with DIDTTO=3, expiration
+		 * interval is between 16K and 32K. */
+		uint64_t didtto:2;
+		/* R/W If set, the (mem) CSR clock never turns off. */
+		uint64_t csrckalwys:1;
+		/* R/W If set, mclk never turns off. */
+		uint64_t mclkalwys:1;
+		/* R/W Selects the bit in the counter used for write
+		 * buffer flush time-outs (WBFLT+11) is the bit
+		 * position in an internal counter used to determine
+		 * expiration. The write buffer expires between 1� and
+		 * 2� this interval. For example, with WBFLT = 0, a
+		 * write buffer expires between 2K and 4K cycles after
+		 * the write buffer entry is allocated. */
+		uint64_t wbfltime:3;
+		/* R/W If set, do not put Istream in the L2 cache. */
+		uint64_t istrnol2:1;
+		/* R/W The write buffer threshold. */
+		uint64_t wbthresh:4;
+		/* Reserved */
+		uint64_t reserved2:2;
+		/* R/W If set, CVMSEG is available for loads/stores in
+		 * kernel/debug mode. */
+		uint64_t cvmsegenak:1;
+		/* R/W If set, CVMSEG is available for loads/stores in
+		 * supervisor mode. */
+		uint64_t cvmsegenas:1;
+		/* R/W If set, CVMSEG is available for loads/stores in
+		 * user mode. */
+		uint64_t cvmsegenau:1;
+		/* R/W Size of local memory in cache blocks, 54 (6912
+		 * bytes) is max legal value. */
+		uint64_t lmemsz:6;
+	} s;
+} octeon_cvmemctl_t;
+
+static inline void octeon_led_write(int bank, uint32_t data)
+{
+	cvmx_write_csr(CVMX_LED_UDD_DATX(bank), data);
+}
+
+static inline uint32_t octeon_led_read(int bank)
+{
+	return cvmx_read_csr(CVMX_LED_UDD_DATX(bank));
+}
+
+static inline void octeon_led_set(int bank, int bit)
+{
+	cvmx_write_csr(CVMX_LED_UDD_DAT_SETX(bank), 1 << bit);
+}
+
+static inline void octeon_led_clear(int bank, int bit)
+{
+	cvmx_write_csr(CVMX_LED_UDD_DAT_CLRX(bank), 1 << bit);
+}
+
+static inline unsigned long octeon_get_cycles(void)
+{
+	unsigned long result;
+	asm volatile ("rdhwr %0,$31\n\t"
+#ifndef CONFIG_64BIT
+		"sll %0,0"
+#endif
+		: "=r" (result));
+	return result;
+}
+
+extern void octeon_write_lcd(const char *s);
+extern void octeon_check_cpu_bist(void);
+extern void octeon_hal_init(void);
+extern int octeon_get_boot_uart(void);
+extern int octeon_get_boot_debug_flag(void);
+extern void octeon_poweroff(void);
+
+struct uart_port;
+extern unsigned int octeon_serial_in(struct uart_port *, int);
+extern void octeon_serial_out(struct uart_port *, int, int);
+
+#endif
diff --git a/arch/mips/cavium-octeon/i8259.c b/arch/mips/cavium-octeon/i8259.c
new file mode 100644
index 0000000..bfa8ade
--- /dev/null
+++ b/arch/mips/cavium-octeon/i8259.c
@@ -0,0 +1,180 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2006-2007 Cavium Networks
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/interrupt.h>
+#include "hal.h"
+
+#define SLAVE           (0xa0 - 0x20)
+
+/* Initialization Command Word 1 (ICW1 address 0x20 or 0xa0) */
+/* 7:5 Interrupt Vector Addresses for MCS-80/85 Mode. */
+#define ICW1_ADDRESS    0x20
+#define ICW1            0x10	/* 4 Must be set to 1 for ICW1 */
+#define ICW1_LEVEL_TRIG (1<<3)	/* 3 1 Level Triggered Interrupts, 0 Edge
+				   Triggered Interrupts */
+#define ICW1_INTERVAL4  (1<<2)	/* 2 1 Call Address Interval of 4, 0 Call
+				   Address Interval of 8 */
+#define ICW1_SINGLE_PIC (1<<1)	/* 1 1 Single PIC, 0 Cascaded PICs */
+#define ICW1_NEED_ICW4  (1<<0)	/* 0 1 Will be Sending ICW4,
+				   0 Don't need ICW4 */
+
+/* Initialization Command Word 2 (ICW2 address 0x21 or 0xa1) */
+#define ICW2_ADDRESS    0x21
+/* Bit 8086/8080 Mode MCS 80/85 Mode 7 I7 A15 6 I6 A14 5 I5 A13 4 I4 A12 3 I3
+   A11 2 - A10 1 - A9 0 - A8 */
+
+/* Initialization Command Word 3 (ICW3 address 0x21 or 0xa1) For the master,
+   this is a bitfield saying which line is hooked to a slave. For a slave, this
+   is the slave's ID, the line it is hooked to */
+#define ICW3_ADDRESS    0x21
+
+/* Initialization Command Word 4 (ICW4 address 0x21 or 0xa1) */
+/* Bits 7-5 are reserved */
+#define ICW4_ADDRESS        0x21
+#define ICW4_FULLY_NESTED   (1<<4)	/* 4 1 Special Fully Nested Mode, 0 Not
+					   Special Fully Nested Mode */
+#define ICW4_BUFFERED       (3<<2)	/* 3 1 Buffered Mode, 0 Unbuffered */
+#define ICW4_MASTER         (2<<2)	/* 2 1 Master, 0 Slave */
+#define ICW4_AUTO_EOI       (1<<1)	/* 1 1 Auto EOI, 0 Normal EOI */
+#define ICW4_8086           (1<<0)	/* 0 1 8086/8080 Mode, 0 MCS-80/85 */
+
+/* Operation Control Word 1 (OCW1 address 0x21 or 0xa1) This is a bitmask for
+   each interrupt */
+#define OCW1_ADDRESS    0x21
+
+/* Operation Control Word 2 (OCW2 address 0x20 or 0xa0) */
+#define OCW2_ADDRESS    0x20
+#define OCW2            0x00	/* Bits 4:3 must be zero */
+#define OCW2_ROTATE_AUTO_EOI_CLEAR  (0<<5)	/* 7:5 000 Rotate in Auto EOI
+						   Mode (Clear) */
+#define OCW2_NON_SPECIFIC_EOI       (1<<5)	/* 001 Non Specific EOI */
+#define OCW2_NOP                    (2<<5)	/* 010 NOP */
+#define OCW2_SPECIFIC_EOI           (3<<5)	/* 011 Specific EOI */
+#define OCW2_ROTATE_AUTO_EOI_SET    (4<<5)	/* 100 Rotate in Auto EOI Mode
+						   (Set) */
+#define OCW2_ROTATE_NON_SPECIFIC_EOI (5<<5)	/* 101 Rotate on Non-Specific
+						   EOI */
+#define OCW2_SET_PRIORITY           (6<<5)	/* 110 Set Priority Command
+						   (Use Bits 2:0) */
+#define OCW2_ROTATE_SPECIFIC_EOI    (7<<5)	/* 111 Rotate on Specific EOI
+						   (Use Bits 2:0) */
+
+/* Operation Control Word 3 (OCW3 address 0x20 or 0xa0) */
+/* Bit 7 Must be set to 0 */
+#define OCW3_ADDRESS    0x20
+#define OCW3            0x08	/* 4:3 Must be set to 01 */
+#define OCW3_RESET_SPECIAL_MASK (2<<5)	/* 6:5 00 Reserved, 01 Reserved, 10
+					   Reset Special Mask */
+#define OCW3_SET_SPECIAL_MASK   (3<<5)	/* 11 Set Special Mask */
+#define OCW3_POLL               (1<<2)	/* 2 1 Poll Command,
+					   0 No Poll Command */
+#define OCW3_READ_IRR           (2<<0)	/* 1:0 00 Reserved, 01 Reserved, 10
+					   Next Read Returns Interrupt Request
+					   Register */
+#define OCW3_READ_ISR           (3<<0)	/* 11 Next Read Returns In-Service
+					   Register */
+
+
+static irqreturn_t octeon_i8259_interrupt(int cpl, void *dev_id)
+{
+	u8 master_isr;
+	u8 slave_isr;
+
+	outb(OCW3 | OCW3_POLL, OCW3_ADDRESS);
+	master_isr = inb(OCW3_ADDRESS);
+	if (master_isr & 0x80) {	/* Top bit is set if the master
+					   requested the interrupt */
+		if ((master_isr & 0x7) == 2) {
+			outb(OCW3 | OCW3_POLL, OCW3_ADDRESS + SLAVE);
+			slave_isr = inb(OCW3_ADDRESS + SLAVE);
+			if (slave_isr & 0x80) {	/* Top bit is set if the slave
+						   requested the interrupt */
+				int irq = (slave_isr & 7) + OCTEON_IRQ_I8259S0;
+				pr_debug("8259: Interrupt %d from slave\n",
+					 irq);
+				if (irq_desc[irq].action)
+					do_IRQ(irq);
+
+				/* Ack the slave */
+				outb(OCW2 | OCW2_SPECIFIC_EOI | (slave_isr & 7),
+				     OCW2_ADDRESS + SLAVE);
+			} else
+				pr_err("8259: Spurious interrupt from "
+				       "master for slave\n");
+		} else {
+			int irq = (master_isr & 7) + OCTEON_IRQ_I8259M0;
+			/*
+			pr_debug("8259: Interrupt %d from master\n", irq);
+			*/
+			if (irq_desc[irq].action)
+				do_IRQ(irq);
+		}
+
+		/* Ack the master */
+		outb(OCW2 | OCW2_SPECIFIC_EOI | (master_isr & 7), OCW2_ADDRESS);
+
+		return IRQ_HANDLED;
+	} else {
+		pr_err("8259: Spurious interrupt from master\n");
+		return IRQ_NONE;
+	}
+}
+
+void octeon_i8259_setup(int irq_line)
+{
+	/* Setup the Master 8259 */
+	/* Begin the init sequence */
+	outb(ICW1 | ICW1_NEED_ICW4, ICW1_ADDRESS);
+	/* Master base address is zero, interrupts 0-7 */
+	outb(0, ICW2_ADDRESS);
+	/* Slave is connected to line 2 */
+	outb(1 << 2, ICW3_ADDRESS);
+	/* Set the mode to buffered with edge triggering */
+	outb(ICW4_FULLY_NESTED | ICW4_MASTER | ICW4_BUFFERED | ICW4_8086,
+	     ICW4_ADDRESS);
+	/* Read ISR */
+	outb(OCW3 | OCW3_READ_ISR, OCW3_ADDRESS);
+
+	/* Setup the Slave 8259 */
+	/* Begin the init sequence */
+	outb(ICW1 | ICW1_NEED_ICW4, ICW1_ADDRESS + SLAVE);
+	/* Slave base address is 8, interrupts 8-15 */
+	outb(8, ICW2_ADDRESS + SLAVE);
+	/* Slave is connected to line 2 */
+	outb(2, ICW3_ADDRESS + SLAVE);
+	/* Set the mode to buffered with edge triggering */
+	outb(ICW4_BUFFERED | ICW4_8086, ICW4_ADDRESS + SLAVE);
+	/* Read ISR */
+	outb(OCW3 | OCW3_READ_ISR, OCW3_ADDRESS + SLAVE);
+
+	/* Set interrupt mask to disable all interrupts */
+	outb(0xfb, OCW1_ADDRESS);
+	outb(0xff, OCW1_ADDRESS + SLAVE);
+
+	/* Setup the GPIO pin if the interrupt is hooked to it */
+	if ((irq_line >= 24) && (irq_line <= 39)) {
+		pr_notice("8259: Setting GPIO %d for the interrupt\n",
+			  irq_line - 24);
+		cvmx_write_csr(CVMX_GPIO_BIT_CFGX(irq_line - 24), 0x114);
+		if (request_irq(irq_line, octeon_i8259_interrupt, IRQF_SHARED,
+				"8259", octeon_i8259_interrupt)) {
+			panic("8259: Could not request_irq(%d)\n", irq_line);
+		}
+	} else if ((irq_line >= 44) && (irq_line <= 47)) {
+		pr_notice("8259: Using PCI INT-%c\n", irq_line - 44 + 'A');
+		if (request_irq(irq_line, octeon_i8259_interrupt, IRQF_SHARED,
+				"8259", octeon_i8259_interrupt)) {
+			panic("8259: Could not request_irq(%d)\n", irq_line);
+		}
+	} else {
+		panic("8259: Don't know how to setup the interrupt IRQ %d\n",
+		      irq_line);
+	}
+}
diff --git a/arch/mips/cavium-octeon/irq.c b/arch/mips/cavium-octeon/irq.c
new file mode 100644
index 0000000..0e1f5e1
--- /dev/null
+++ b/arch/mips/cavium-octeon/irq.c
@@ -0,0 +1,61 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2004-2008 Cavium Networks
+ */
+#include "linux/irq.h"
+#include "linux/hardirq.h"
+#include "linux/kernel_stat.h"
+#include "hal.h"
+
+asmlinkage void plat_irq_dispatch(void)
+{
+	const unsigned long core_id = cvmx_get_core_num();
+	const uint64_t ciu_sum0_address = CVMX_CIU_INTX_SUM0(core_id * 2);
+	const uint64_t ciu_en0_address = CVMX_CIU_INTX_EN0(core_id * 2);
+	const uint64_t ciu_sum1_address = CVMX_CIU_INT_SUM1;
+	const uint64_t ciu_en1_address = CVMX_CIU_INTX_EN1(core_id * 2 + 1);
+	unsigned long cop0_cause;
+	unsigned long cop0_status;
+	uint64_t ciu_en;
+	uint64_t ciu_sum;
+
+	while (1) {
+		cop0_cause = read_c0_cause();
+		cop0_status = read_c0_status();
+		cop0_cause &= cop0_status;
+		cop0_cause &= ST0_IM;
+
+		if (unlikely(cop0_cause & STATUSF_IP2)) {
+			asm volatile ("ld	%[sum], 0(%[sum_address])\n"
+				      "ld	%[en], 0(%[en_address])\n" :
+				      [sum] "=r"(ciu_sum),
+				      [en] "=r"(ciu_en) :
+				      [sum_address] "r"(ciu_sum0_address),
+				      [en_address] "r"(ciu_en0_address));
+			ciu_sum &= ciu_en;
+			if (likely(ciu_sum))
+				do_IRQ(fls64(ciu_sum) + OCTEON_IRQ_WORKQ0 - 1);
+			else
+				spurious_interrupt();
+		} else if (unlikely(cop0_cause & STATUSF_IP3)) {
+			asm volatile ("ld	%[sum], 0(%[sum_address])\n"
+				      "ld	%[en], 0(%[en_address])\n" :
+				      [sum] "=r"(ciu_sum),
+				      [en] "=r"(ciu_en) :
+				      [sum_address] "r"(ciu_sum1_address),
+				      [en_address] "r"(ciu_en1_address));
+			ciu_sum &= ciu_en;
+			if (likely(ciu_sum))
+				do_IRQ(fls64(ciu_sum) + OCTEON_IRQ_WDOG0 - 1);
+			else
+				spurious_interrupt();
+		} else if (likely(cop0_cause)) {
+			do_IRQ(fls(cop0_cause) - 9);
+		} else {
+			break;
+		}
+	}
+}
diff --git a/arch/mips/cavium-octeon/octeon-memcpy.S b/arch/mips/cavium-octeon/octeon-memcpy.S
new file mode 100644
index 0000000..88e0cdd
--- /dev/null
+++ b/arch/mips/cavium-octeon/octeon-memcpy.S
@@ -0,0 +1,521 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Unified implementation of memcpy, memmove and the __copy_user backend.
+ *
+ * Copyright (C) 1998, 99, 2000, 01, 2002 Ralf Baechle (ralf@gnu.org)
+ * Copyright (C) 1999, 2000, 01, 2002 Silicon Graphics, Inc.
+ * Copyright (C) 2002 Broadcom, Inc.
+ *   memcpy/copy_user author: Mark Vandevoorde
+ *
+ * Mnemonic names for arguments to memcpy/__copy_user
+ */
+
+#include <asm/asm.h>
+#include <asm/asm-offsets.h>
+#include <asm/regdef.h>
+
+#define dst a0
+#define src a1
+#define len a2
+
+/*
+ * Spec
+ *
+ * memcpy copies len bytes from src to dst and sets v0 to dst.
+ * It assumes that
+ *   - src and dst don't overlap
+ *   - src is readable
+ *   - dst is writable
+ * memcpy uses the standard calling convention
+ *
+ * __copy_user copies up to len bytes from src to dst and sets a2 (len) to
+ * the number of uncopied bytes due to an exception caused by a read or write.
+ * __copy_user assumes that src and dst don't overlap, and that the call is
+ * implementing one of the following:
+ *   copy_to_user
+ *     - src is readable  (no exceptions when reading src)
+ *   copy_from_user
+ *     - dst is writable  (no exceptions when writing dst)
+ * __copy_user uses a non-standard calling convention; see
+ * arch/mips/include/asm/uaccess.h
+ *
+ * When an exception happens on a load, the handler must
+ # ensure that all of the destination buffer is overwritten to prevent
+ * leaking information to user mode programs.
+ */
+
+/*
+ * Implementation
+ */
+
+/*
+ * The exception handler for loads requires that:
+ *  1- AT contain the address of the byte just past the end of the source
+ *     of the copy,
+ *  2- src_entry <= src < AT, and
+ *  3- (dst - src) == (dst_entry - src_entry),
+ * The _entry suffix denotes values when __copy_user was called.
+ *
+ * (1) is set up up by uaccess.h and maintained by not writing AT in copy_user
+ * (2) is met by incrementing src by the number of bytes copied
+ * (3) is met by not doing loads between a pair of increments of dst and src
+ *
+ * The exception handlers for stores adjust len (if necessary) and return.
+ * These handlers do not need to overwrite any data.
+ *
+ * For __rmemcpy and memmove an exception is always a kernel bug, therefore
+ * they're not protected.
+ */
+
+#define EXC(inst_reg,addr,handler)		\
+9:	inst_reg, addr;				\
+	.section __ex_table,"a";		\
+	PTR	9b, handler;			\
+	.previous
+
+/*
+ * Only on the 64-bit kernel we can made use of 64-bit registers.
+ */
+#ifdef CONFIG_64BIT
+#define USE_DOUBLE
+#endif
+
+#ifdef USE_DOUBLE
+
+#define LOAD   ld
+#define LOADL  ldl
+#define LOADR  ldr
+#define STOREL sdl
+#define STORER sdr
+#define STORE  sd
+#define ADD    daddu
+#define SUB    dsubu
+#define SRL    dsrl
+#define SRA    dsra
+#define SLL    dsll
+#define SLLV   dsllv
+#define SRLV   dsrlv
+#define NBYTES 8
+#define LOG_NBYTES 3
+
+/*
+ * As we are sharing code base with the mips32 tree (which use the o32 ABI
+ * register definitions). We need to redefine the register definitions from
+ * the n64 ABI register naming to the o32 ABI register naming.
+ */
+#undef t0
+#undef t1
+#undef t2
+#undef t3
+#define t0	$8
+#define t1	$9
+#define t2	$10
+#define t3	$11
+#define t4	$12
+#define t5	$13
+#define t6	$14
+#define t7	$15
+
+#else
+
+#define LOAD   lw
+#define LOADL  lwl
+#define LOADR  lwr
+#define STOREL swl
+#define STORER swr
+#define STORE  sw
+#define ADD    addu
+#define SUB    subu
+#define SRL    srl
+#define SLL    sll
+#define SRA    sra
+#define SLLV   sllv
+#define SRLV   srlv
+#define NBYTES 4
+#define LOG_NBYTES 2
+
+#endif /* USE_DOUBLE */
+
+#ifdef CONFIG_CPU_LITTLE_ENDIAN
+#define LDFIRST LOADR
+#define LDREST  LOADL
+#define STFIRST STORER
+#define STREST  STOREL
+#define SHIFT_DISCARD SLLV
+#else
+#define LDFIRST LOADL
+#define LDREST  LOADR
+#define STFIRST STOREL
+#define STREST  STORER
+#define SHIFT_DISCARD SRLV
+#endif
+
+#define FIRST(unit) ((unit)*NBYTES)
+#define REST(unit)  (FIRST(unit)+NBYTES-1)
+#define UNIT(unit)  FIRST(unit)
+
+#define ADDRMASK (NBYTES-1)
+
+	.text
+	.set	noreorder
+	.set	noat
+
+/*
+ * A combined memcpy/__copy_user
+ * __copy_user sets len to 0 for success; else to an upper bound of
+ * the number of uncopied bytes.
+ * memcpy sets v0 to dst.
+ */
+	.align	5
+LEAF(memcpy)					/* a0=dst a1=src a2=len */
+	move	v0, dst				/* return value */
+__memcpy:
+FEXPORT(__copy_user)
+	/*
+	 * Note: dst & src may be unaligned, len may be 0
+	 * Temps
+	 */
+	#
+	# Octeon doesn't care if the destination is unaligned. The hardware
+	# can fix it faster than we can special case the assembly.
+	#
+	pref	0, 0(src)
+	sltu	t0, len, NBYTES		# Check if < 1 word
+	bnez	t0, copy_bytes_checklen
+	 and	t0, src, ADDRMASK	# Check if src unaligned
+	bnez	t0, src_unaligned
+	 sltu	t0, len, 4*NBYTES	# Check if < 4 words
+	bnez	t0, less_than_4units
+	 sltu	t0, len, 8*NBYTES	# Check if < 8 words
+	bnez	t0, less_than_8units
+	 sltu	t0, len, 16*NBYTES	# Check if < 16 words
+	bnez	t0, cleanup_both_aligned
+	 sltu	t0, len, 128+1		# Check if len < 129
+	bnez	t0, 1f			# Skip prefetch if len is too short
+	 sltu	t0, len, 256+1		# Check if len < 257
+	bnez	t0, 1f			# Skip prefetch if len is too short
+	 pref	0, 128(src)		# We must not prefetch invalid addresses
+	#
+	# This is where we loop if there is more than 128 bytes left
+2:	pref	0, 256(src)		# We must not prefetch invalid addresses
+	#
+	# This is where we loop if we can't prefetch anymore
+1:
+EXC(	LOAD	t0, UNIT(0)(src),	l_exc)
+EXC(	LOAD	t1, UNIT(1)(src),	l_exc_copy)
+EXC(	LOAD	t2, UNIT(2)(src),	l_exc_copy)
+EXC(	LOAD	t3, UNIT(3)(src),	l_exc_copy)
+	SUB	len, len, 16*NBYTES
+EXC(	STORE	t0, UNIT(0)(dst),	s_exc_p16u)
+EXC(	STORE	t1, UNIT(1)(dst),	s_exc_p15u)
+EXC(	STORE	t2, UNIT(2)(dst),	s_exc_p14u)
+EXC(	STORE	t3, UNIT(3)(dst),	s_exc_p13u)
+EXC(	LOAD	t0, UNIT(4)(src),	l_exc_copy)
+EXC(	LOAD	t1, UNIT(5)(src),	l_exc_copy)
+EXC(	LOAD	t2, UNIT(6)(src),	l_exc_copy)
+EXC(	LOAD	t3, UNIT(7)(src),	l_exc_copy)
+EXC(	STORE	t0, UNIT(4)(dst),	s_exc_p12u)
+EXC(	STORE	t1, UNIT(5)(dst),	s_exc_p11u)
+EXC(	STORE	t2, UNIT(6)(dst),	s_exc_p10u)
+	ADD	src, src, 16*NBYTES
+EXC(	STORE	t3, UNIT(7)(dst),	s_exc_p9u)
+	ADD	dst, dst, 16*NBYTES
+EXC(	LOAD	t0, UNIT(-8)(src),	l_exc_copy)
+EXC(	LOAD	t1, UNIT(-7)(src),	l_exc_copy)
+EXC(	LOAD	t2, UNIT(-6)(src),	l_exc_copy)
+EXC(	LOAD	t3, UNIT(-5)(src),	l_exc_copy)
+EXC(	STORE	t0, UNIT(-8)(dst),	s_exc_p8u)
+EXC(	STORE	t1, UNIT(-7)(dst),	s_exc_p7u)
+EXC(	STORE	t2, UNIT(-6)(dst),	s_exc_p6u)
+EXC(	STORE	t3, UNIT(-5)(dst),	s_exc_p5u)
+EXC(	LOAD	t0, UNIT(-4)(src),	l_exc_copy)
+EXC(	LOAD	t1, UNIT(-3)(src),	l_exc_copy)
+EXC(	LOAD	t2, UNIT(-2)(src),	l_exc_copy)
+EXC(	LOAD	t3, UNIT(-1)(src),	l_exc_copy)
+EXC(	STORE	t0, UNIT(-4)(dst),	s_exc_p4u)
+EXC(	STORE	t1, UNIT(-3)(dst),	s_exc_p3u)
+EXC(	STORE	t2, UNIT(-2)(dst),	s_exc_p2u)
+EXC(	STORE	t3, UNIT(-1)(dst),	s_exc_p1u)
+	sltu	t0, len, 256+1		# See if we can prefetch more
+	beqz	t0, 2b
+	 sltu	t0, len, 128		# See if we can loop more time
+	beqz	t0, 1b
+	 nop
+	#
+	# Jump here if there are less than 16*NBYTES left.
+	#
+cleanup_both_aligned:
+	beqz	len, done
+	 sltu	t0, len, 8*NBYTES
+	bnez	t0, less_than_8units
+	 nop
+EXC(	LOAD	t0, UNIT(0)(src),	l_exc)
+EXC(	LOAD	t1, UNIT(1)(src),	l_exc_copy)
+EXC(	LOAD	t2, UNIT(2)(src),	l_exc_copy)
+EXC(	LOAD	t3, UNIT(3)(src),	l_exc_copy)
+	SUB	len, len, 8*NBYTES
+EXC(	STORE	t0, UNIT(0)(dst),	s_exc_p8u)
+EXC(	STORE	t1, UNIT(1)(dst),	s_exc_p7u)
+EXC(	STORE	t2, UNIT(2)(dst),	s_exc_p6u)
+EXC(	STORE	t3, UNIT(3)(dst),	s_exc_p5u)
+EXC(	LOAD	t0, UNIT(4)(src),	l_exc_copy)
+EXC(	LOAD	t1, UNIT(5)(src),	l_exc_copy)
+EXC(	LOAD	t2, UNIT(6)(src),	l_exc_copy)
+EXC(	LOAD	t3, UNIT(7)(src),	l_exc_copy)
+EXC(	STORE	t0, UNIT(4)(dst),	s_exc_p4u)
+EXC(	STORE	t1, UNIT(5)(dst),	s_exc_p3u)
+EXC(	STORE	t2, UNIT(6)(dst),	s_exc_p2u)
+EXC(	STORE	t3, UNIT(7)(dst),	s_exc_p1u)
+	ADD	src, src, 8*NBYTES
+	beqz	len, done
+	 ADD	dst, dst, 8*NBYTES
+	#
+	# Jump here if there are less than 8*NBYTES left.
+	#
+less_than_8units:
+	sltu	t0, len, 4*NBYTES
+	bnez	t0, less_than_4units
+	 nop
+EXC(	LOAD	t0, UNIT(0)(src),	l_exc)
+EXC(	LOAD	t1, UNIT(1)(src),	l_exc_copy)
+EXC(	LOAD	t2, UNIT(2)(src),	l_exc_copy)
+EXC(	LOAD	t3, UNIT(3)(src),	l_exc_copy)
+	SUB	len, len, 4*NBYTES
+EXC(	STORE	t0, UNIT(0)(dst),	s_exc_p4u)
+EXC(	STORE	t1, UNIT(1)(dst),	s_exc_p3u)
+EXC(	STORE	t2, UNIT(2)(dst),	s_exc_p2u)
+EXC(	STORE	t3, UNIT(3)(dst),	s_exc_p1u)
+	ADD	src, src, 4*NBYTES
+	beqz	len, done
+	 ADD	dst, dst, 4*NBYTES
+	#
+	# Jump here if there are less than 4*NBYTES left. This means
+	# we may need to copy up to 3 NBYTES words.
+	#
+less_than_4units:
+	sltu	t0, len, 1*NBYTES
+	bnez	t0, copy_bytes_checklen
+	 nop
+	#
+	# 1) Copy NBYTES, then check length again
+	#
+EXC(	LOAD	t0, 0(src),		l_exc)
+	SUB	len, len, NBYTES
+	sltu	t1, len, 8
+EXC(	STORE	t0, 0(dst),		s_exc_p1u)
+	ADD	src, src, NBYTES
+	bnez	t1, copy_bytes_checklen
+	 ADD	dst, dst, NBYTES
+	#
+	# 2) Copy NBYTES, then check length again
+	#
+EXC(	LOAD	t0, 0(src),		l_exc)
+	SUB	len, len, NBYTES
+	sltu	t1, len, 8
+EXC(	STORE	t0, 0(dst),		s_exc_p1u)
+	ADD	src, src, NBYTES
+	bnez	t1, copy_bytes_checklen
+	 ADD	dst, dst, NBYTES
+	#
+	# 3) Copy NBYTES, then check length again
+	#
+EXC(	LOAD	t0, 0(src),		l_exc)
+	SUB	len, len, NBYTES
+	ADD	src, src, NBYTES
+	ADD	dst, dst, NBYTES
+	b copy_bytes_checklen
+EXC(	 STORE	t0, -8(dst),		s_exc_p1u)
+
+src_unaligned:
+#define rem t8
+	SRL	t0, len, LOG_NBYTES+2    # +2 for 4 units/iter
+	beqz	t0, cleanup_src_unaligned
+	 and	rem, len, (4*NBYTES-1)   # rem = len % 4*NBYTES
+1:
+/*
+ * Avoid consecutive LD*'s to the same register since some mips
+ * implementations can't issue them in the same cycle.
+ * It's OK to load FIRST(N+1) before REST(N) because the two addresses
+ * are to the same unit (unless src is aligned, but it's not).
+ */
+EXC(	LDFIRST	t0, FIRST(0)(src),	l_exc)
+EXC(	LDFIRST	t1, FIRST(1)(src),	l_exc_copy)
+	SUB     len, len, 4*NBYTES
+EXC(	LDREST	t0, REST(0)(src),	l_exc_copy)
+EXC(	LDREST	t1, REST(1)(src),	l_exc_copy)
+EXC(	LDFIRST	t2, FIRST(2)(src),	l_exc_copy)
+EXC(	LDFIRST	t3, FIRST(3)(src),	l_exc_copy)
+EXC(	LDREST	t2, REST(2)(src),	l_exc_copy)
+EXC(	LDREST	t3, REST(3)(src),	l_exc_copy)
+	ADD	src, src, 4*NBYTES
+EXC(	STORE	t0, UNIT(0)(dst),	s_exc_p4u)
+EXC(	STORE	t1, UNIT(1)(dst),	s_exc_p3u)
+EXC(	STORE	t2, UNIT(2)(dst),	s_exc_p2u)
+EXC(	STORE	t3, UNIT(3)(dst),	s_exc_p1u)
+	bne	len, rem, 1b
+	 ADD	dst, dst, 4*NBYTES
+
+cleanup_src_unaligned:
+	beqz	len, done
+	 and	rem, len, NBYTES-1  # rem = len % NBYTES
+	beq	rem, len, copy_bytes
+	 nop
+1:
+EXC(	LDFIRST t0, FIRST(0)(src),	l_exc)
+EXC(	LDREST	t0, REST(0)(src),	l_exc_copy)
+	SUB	len, len, NBYTES
+EXC(	STORE	t0, 0(dst),		s_exc_p1u)
+	ADD	src, src, NBYTES
+	bne	len, rem, 1b
+	 ADD	dst, dst, NBYTES
+
+copy_bytes_checklen:
+	beqz	len, done
+	 nop
+copy_bytes:
+	/* 0 < len < NBYTES  */
+#define COPY_BYTE(N)			\
+EXC(	lb	t0, N(src), l_exc);	\
+	SUB	len, len, 1;		\
+	beqz	len, done;		\
+EXC(	 sb	t0, N(dst), s_exc_p1)
+
+	COPY_BYTE(0)
+	COPY_BYTE(1)
+#ifdef USE_DOUBLE
+	COPY_BYTE(2)
+	COPY_BYTE(3)
+	COPY_BYTE(4)
+	COPY_BYTE(5)
+#endif
+EXC(	lb	t0, NBYTES-2(src), l_exc)
+	SUB	len, len, 1
+	jr	ra
+EXC(	 sb	t0, NBYTES-2(dst), s_exc_p1)
+done:
+	jr	ra
+	 nop
+	END(memcpy)
+
+l_exc_copy:
+	/*
+	 * Copy bytes from src until faulting load address (or until a
+	 * lb faults)
+	 *
+	 * When reached by a faulting LDFIRST/LDREST, THREAD_BUADDR($28)
+	 * may be more than a byte beyond the last address.
+	 * Hence, the lb below may get an exception.
+	 *
+	 * Assumes src < THREAD_BUADDR($28)
+	 */
+	LOAD	t0, TI_TASK($28)
+	 nop
+	LOAD	t0, THREAD_BUADDR(t0)
+1:
+EXC(	lb	t1, 0(src),	l_exc)
+	ADD	src, src, 1
+	sb	t1, 0(dst)	# can't fault -- we're copy_from_user
+	bne	src, t0, 1b
+	 ADD	dst, dst, 1
+l_exc:
+	LOAD	t0, TI_TASK($28)
+	 nop
+	LOAD	t0, THREAD_BUADDR(t0)	# t0 is just past last good address
+	 nop
+	SUB	len, AT, t0		# len number of uncopied bytes
+	/*
+	 * Here's where we rely on src and dst being incremented in tandem,
+	 *   See (3) above.
+	 * dst += (fault addr - src) to put dst at first byte to clear
+	 */
+	ADD	dst, t0			# compute start address in a1
+	SUB	dst, src
+	/*
+	 * Clear len bytes starting at dst.  Can't call __bzero because it
+	 * might modify len.  An inefficient loop for these rare times...
+	 */
+	beqz	len, done
+	 SUB	src, len, 1
+1:	sb	zero, 0(dst)
+	ADD	dst, dst, 1
+	bnez	src, 1b
+	 SUB	src, src, 1
+	jr	ra
+	 nop
+
+
+#define SEXC(n)				\
+s_exc_p ## n ## u:			\
+	jr	ra;			\
+	 ADD	len, len, n*NBYTES
+
+SEXC(16)
+SEXC(15)
+SEXC(14)
+SEXC(13)
+SEXC(12)
+SEXC(11)
+SEXC(10)
+SEXC(9)
+SEXC(8)
+SEXC(7)
+SEXC(6)
+SEXC(5)
+SEXC(4)
+SEXC(3)
+SEXC(2)
+SEXC(1)
+
+s_exc_p1:
+	jr	ra
+	 ADD	len, len, 1
+s_exc:
+	jr	ra
+	 nop
+
+	.align	5
+LEAF(memmove)
+	ADD	t0, a0, a2
+	ADD	t1, a1, a2
+	sltu	t0, a1, t0			# dst + len <= src -> memcpy
+	sltu	t1, a0, t1			# dst >= src + len -> memcpy
+	and	t0, t1
+	beqz	t0, __memcpy
+	 move	v0, a0				/* return value */
+	beqz	a2, r_out
+	END(memmove)
+
+	/* fall through to __rmemcpy */
+LEAF(__rmemcpy)					/* a0=dst a1=src a2=len */
+	 sltu	t0, a1, a0
+	beqz	t0, r_end_bytes_up		# src >= dst
+	 nop
+	ADD	a0, a2				# dst = dst + len
+	ADD	a1, a2				# src = src + len
+
+r_end_bytes:
+	lb	t0, -1(a1)
+	SUB	a2, a2, 0x1
+	sb	t0, -1(a0)
+	SUB	a1, a1, 0x1
+	bnez	a2, r_end_bytes
+	 SUB	a0, a0, 0x1
+
+r_out:
+	jr	ra
+	 move	a2, zero
+
+r_end_bytes_up:
+	lb	t0, (a1)
+	SUB	a2, a2, 0x1
+	sb	t0, (a0)
+	ADD	a1, a1, 0x1
+	bnez	a2, r_end_bytes_up
+	 ADD	a0, a0, 0x1
+
+	jr	ra
+	 move	a2, zero
+	END(__rmemcpy)
diff --git a/arch/mips/cavium-octeon/serial.c b/arch/mips/cavium-octeon/serial.c
new file mode 100644
index 0000000..077b66c
--- /dev/null
+++ b/arch/mips/cavium-octeon/serial.c
@@ -0,0 +1,187 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2004-2007 Cavium Networks
+ */
+#include <linux/console.h>
+#include <linux/serial.h>
+#include <linux/serial_8250.h>
+#include <linux/serial_reg.h>
+#include <linux/tty.h>
+
+#include <asm/time.h>
+
+#include "hal.h"
+
+#ifdef CONFIG_GDB_CONSOLE
+#define DEBUG_UART 0
+#else
+#define DEBUG_UART 1
+#endif
+
+#ifdef CONFIG_KGDB
+
+char getDebugChar(void)
+{
+	unsigned long lsrval;
+
+	octeon_write_lcd("kgdb");
+
+	/* Spin until data is available */
+	do {
+		lsrval = cvmx_read_csr(CVMX_MIO_UARTX_LSR(DEBUG_UART));
+	} while ((lsrval & 0x1) == 0);
+
+	octeon_write_lcd("");
+
+	/* Read and return the data */
+	return cvmx_read_csr(CVMX_MIO_UARTX_RBR(DEBUG_UART));
+}
+
+void putDebugChar(char ch)
+{
+	unsigned long lsrval;
+
+	/* Spin until there is room */
+	do {
+		lsrval = cvmx_read_csr(CVMX_MIO_UARTX_LSR(DEBUG_UART));
+	} while ((lsrval & 0x20) == 0);
+
+	/* Write the byte */
+	cvmx_write_csr(CVMX_MIO_UARTX_THR(DEBUG_UART), ch);
+}
+
+#endif
+
+#if defined(CONFIG_KGDB) || defined(CONFIG_CAVIUM_GDB)
+
+static irqreturn_t interruptDebugChar(int cpl, void *dev_id)
+{
+	unsigned long lsrval;
+	lsrval = cvmx_read_csr(CVMX_MIO_UARTX_LSR(1));
+	if (lsrval & 1) {
+#ifdef CONFIG_KGDB
+		struct pt_regs *regs = get_irq_regs();
+
+		putDebugChar(getDebugChar());
+		set_async_breakpoint(&regs->cp0_epc);
+#else
+		unsigned long tmp;
+		/* Pulse MCD0 signal on Ctrl-C to stop all the cores. Also set
+		   the MCD0 to be not masked by this core so we know the signal
+		   is received by someone */
+		octeon_write_lcd("brk");
+		asm volatile ("dmfc0 %0, $22\n"
+			      "ori   %0, %0, 0x10\n"
+			      "dmtc0 %0, $22\n" : "=r" (tmp));
+		octeon_write_lcd("");
+#endif
+		return IRQ_HANDLED;
+	}
+	return IRQ_NONE;
+}
+
+#endif
+
+unsigned int octeon_serial_in(struct uart_port *up, int offset)
+{
+	return cvmx_read_csr((uint64_t)(up->membase + (offset << 3)));
+}
+
+void octeon_serial_out(struct uart_port *up, int offset, int value)
+{
+	/*
+	 * If bits 6 or 7 of the OCTEON UART's LCR are set, it quits
+	 * working.
+	 */
+	if (offset == UART_LCR)
+		value &= 0x9f;
+	cvmx_write_csr((uint64_t)(up->membase + (offset << 3)), (u8)value);
+}
+
+static int octeon_serial_init(void)
+{
+	struct uart_port octeon_port;
+	int enable_uart0;
+	int enable_uart1;
+	int enable_uart2;
+
+#ifdef CONFIG_CAVIUM_OCTEON_2ND_KERNEL
+	/* If we are configured to run as the second of two kernels, disable
+	   uart0 and enable uart1. Uart0 is owned by the first kernel */
+	enable_uart0 = 0;
+	enable_uart1 = 1;
+#else
+	/* We are configured for the first kernel. We'll enable uart0 if the
+	   bootloader told us to use 0, otherwise will enable uart 1 */
+	enable_uart0 = (octeon_get_boot_uart() == 0);
+	enable_uart1 = (octeon_get_boot_uart() == 1);
+	/* Uncomment the following line if you'd like uart1 to be enable as
+	   well as uart 0 when the bootloader tells us to use uart0 */
+	/*
+	enable_uart1 = 1;
+	*/
+#endif
+
+#if defined(CONFIG_KGDB) || defined(CONFIG_CAVIUM_GDB)
+	/* As a special case disable uart1 if KGDB is in use */
+	enable_uart1 = 0;
+#endif
+
+	/* Right now CN52XX is the only chip with a third uart */
+	enable_uart2 = OCTEON_IS_MODEL(OCTEON_CN52XX);
+
+	/* These fields are common to all Octeon UARTs */
+	memset(&octeon_port, 0, sizeof(octeon_port));
+	octeon_port.flags = ASYNC_SKIP_TEST | UPF_SHARE_IRQ | UPF_FIXED_TYPE;
+	octeon_port.type = PORT_OCTEON;
+	octeon_port.iotype = UPIO_MEM;
+	octeon_port.regshift = 3;	/* I/O addresses are every 8 bytes */
+	octeon_port.uartclk = mips_hpt_frequency;
+	octeon_port.fifosize = 64;
+	octeon_port.serial_in_fn = octeon_serial_in;
+	octeon_port.serial_out_fn = octeon_serial_out;
+
+	/* Add a ttyS device for hardware uart 0 */
+	if (enable_uart0) {
+		octeon_port.membase = (void *) CVMX_MIO_UARTX_RBR(0);
+		octeon_port.mapbase =
+			CVMX_MIO_UARTX_RBR(0) & ((1ull << 49) - 1);
+		/* Only CN38XXp{1,2} has errata with uart interrupt */
+		if (!OCTEON_IS_MODEL(OCTEON_CN38XX_PASS2))
+			octeon_port.irq = OCTEON_IRQ_UART0;
+		serial8250_register_port(&octeon_port);
+	}
+
+	/* Add a ttyS device for hardware uart 1 */
+	if (enable_uart1) {
+		octeon_port.membase = (void *) CVMX_MIO_UARTX_RBR(1);
+		octeon_port.mapbase =
+			CVMX_MIO_UARTX_RBR(1) & ((1ull << 49) - 1);
+		/* Only CN38XXp{1,2} has errata with uart interrupt */
+		if (!OCTEON_IS_MODEL(OCTEON_CN38XX_PASS2))
+			octeon_port.irq = OCTEON_IRQ_UART1;
+		serial8250_register_port(&octeon_port);
+	}
+
+	/* Add a ttyS device for hardware uart 2 */
+	if (enable_uart2) {
+		octeon_port.membase = (void *) CVMX_MIO_UART2_RBR;
+		octeon_port.mapbase = CVMX_MIO_UART2_RBR & ((1ull << 49) - 1);
+		octeon_port.irq = OCTEON_IRQ_UART2;
+		serial8250_register_port(&octeon_port);
+	}
+#if defined(CONFIG_KGDB) || defined(CONFIG_CAVIUM_GDB)
+	request_irq(OCTEON_IRQ_UART0 + DEBUG_UART, interruptDebugChar,
+		    IRQF_SHARED, "KGDB", interruptDebugChar);
+
+	/* Enable uart1 interrupts for debugger Control-C processing */
+	cvmx_write_csr(CVMX_MIO_UARTX_IER(DEBUG_UART),
+		       cvmx_read_csr(CVMX_MIO_UARTX_IER(DEBUG_UART)) | 1);
+#endif
+	return 0;
+}
+
+late_initcall(octeon_serial_init);
diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
new file mode 100644
index 0000000..342f672
--- /dev/null
+++ b/arch/mips/cavium-octeon/setup.c
@@ -0,0 +1,387 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2004-2007 Cavium Networks
+ * Copyright (C) 2008 Wind River Systems
+ */
+#include <linux/init.h>
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/serial.h>
+#include <linux/types.h>
+#include <linux/string.h>	/* for memset */
+#include <linux/serial.h>
+#include <linux/tty.h>
+#include <linux/time.h>
+#include <linux/serial_core.h>
+#include <linux/serial_8250.h>
+#include <linux/string.h>
+
+#include <asm/processor.h>
+#include <asm/reboot.h>
+#include <asm/smp-ops.h>
+#include <asm/system.h>
+#include <asm/irq_cpu.h>
+#include <asm/mipsregs.h>
+#include <asm/bootinfo.h>
+#include <asm/sections.h>
+#include <asm/time.h>
+#include "hal.h"
+#include "cvmx-l2c.h"
+#include "cvmx-bootmem.h"
+
+#ifdef CONFIG_CAVIUM_DECODE_RSL
+extern void cvmx_interrupt_rsl_decode(void);
+extern int __cvmx_interrupt_ecc_report_single_bit_errors;
+extern void cvmx_interrupt_rsl_enable(void);
+#endif
+
+extern struct plat_smp_ops octeon_smp_ops;
+extern void octeon_user_io_init(void);
+#ifdef CONFIG_PCI
+extern void pci_console_init(const char *arg);
+#endif
+extern void putDebugChar(char ch);
+
+#ifdef CONFIG_CAVIUM_OCTEON_BOOTBUS_COMPACT_FLASH
+extern void ebt3000_cf_enable_dma(void);
+#endif
+
+#ifdef CONFIG_CAVIUM_RESERVE32
+extern uint64_t octeon_reserve32_memory;
+#endif
+static unsigned long long MAX_MEMORY = 512ull << 20;
+
+/**
+ * Reboot Octeon
+ *
+ * @param command Command to pass to the bootloader. Currently ignored.
+ */
+static void octeon_restart(char *command)
+{
+	/* Disable all watchdogs before soft reset. They don't get cleared */
+#ifdef CONFIG_SMP
+	int cpu;
+	for (cpu = 0; cpu < NR_CPUS; cpu++)
+		if (cpu_online(cpu))
+			cvmx_write_csr(CVMX_CIU_WDOGX(cpu_logical_map(cpu)), 0);
+#else
+	cvmx_write_csr(CVMX_CIU_WDOGX(cvmx_get_core_num()), 0);
+#endif
+
+	mb();
+	while (1)
+		cvmx_write_csr(CVMX_CIU_SOFT_RST, 1);
+}
+
+
+/**
+ * Permanently stop a core.
+ *
+ * @param arg
+ */
+static void octeon_kill_core(void *arg)
+{
+	mb();
+	if (octeon_is_simulation()) {
+		/* The simulator needs the watchdog to stop for dead cores */
+		cvmx_write_csr(CVMX_CIU_WDOGX(cvmx_get_core_num()), 0);
+		/* A break instruction causes the simulator stop a core */
+		asm volatile ("sync\nbreak");
+	}
+}
+
+
+/**
+ * Halt the system
+ */
+static void octeon_halt(void)
+{
+	smp_call_function(octeon_kill_core, NULL, 0);
+	octeon_poweroff();
+	octeon_kill_core(NULL);
+}
+
+
+/**
+ * Platform time init specifics.
+ * @return
+ */
+void __init plat_time_init(void)
+{
+	/* Nothing special here, but we are required to have one */
+}
+
+
+/**
+ * Handle all the error condition interrupts that might occur.
+ *
+ * @param cpl
+ * @param dev_id
+ * @return
+ */
+#ifdef CONFIG_CAVIUM_DECODE_RSL
+static irqreturn_t octeon_rlm_interrupt(int cpl, void *dev_id)
+{
+	cvmx_interrupt_rsl_decode();
+	return IRQ_HANDLED;
+}
+#endif
+
+/**
+ * Return a string representing the system type
+ *
+ * @return
+ */
+const char *get_system_type(void)
+{
+	return octeon_board_type_string();
+}
+
+
+/**
+ * Early entry point for arch setup
+ */
+void __init prom_init(void)
+{
+	const int coreid = cvmx_get_core_num();
+	int i;
+	int argc;
+	struct uart_port octeon_port;
+	int octeon_uart;
+
+	octeon_hal_init();
+	octeon_check_cpu_bist();
+#ifdef CONFIG_CAVIUM_OCTEON_2ND_KERNEL
+	octeon_uart = 1;
+#else
+	octeon_uart = octeon_get_boot_uart();
+#endif
+
+	/* Disable All CIU Interrupts. The ones we need will be
+	 * enabled later.  Read the SUM register so we know the write
+	 * completed. */
+	cvmx_write_csr(CVMX_CIU_INTX_EN0((coreid * 2)), 0);
+	cvmx_write_csr(CVMX_CIU_INTX_EN0((coreid * 2 + 1)), 0);
+	cvmx_write_csr(CVMX_CIU_INTX_EN1((coreid * 2)), 0);
+	cvmx_write_csr(CVMX_CIU_INTX_EN1((coreid * 2 + 1)), 0);
+	cvmx_read_csr(CVMX_CIU_INTX_SUM0((coreid * 2)));
+
+#ifdef CONFIG_SMP
+	octeon_write_lcd("LinuxSMP");
+#else
+	octeon_write_lcd("Linux");
+#endif
+
+#ifdef CONFIG_CAVIUM_GDB
+	/* When debugging the linux kernel, force the cores to enter
+	 * the debug exception handler to break in.  */
+	if (octeon_get_boot_debug_flag()) {
+		cvmx_write_csr(CVMX_CIU_DINT, 1 << cvmx_get_core_num());
+		cvmx_read_csr(CVMX_CIU_DINT);
+	}
+#endif
+
+	/* BIST should always be enabled when doing a soft reset. L2
+	 * Cache locking for instance is not cleared unless BIST is
+	 * enabled.  Unfortunately due to a chip errata G-200 for
+	 * Cn38XX and CN31XX, BIST msut be disabled on these parts */
+	if (OCTEON_IS_MODEL(OCTEON_CN38XX_PASS2) ||
+	    OCTEON_IS_MODEL(OCTEON_CN31XX))
+		cvmx_write_csr(CVMX_CIU_SOFT_BIST, 0);
+	else
+		cvmx_write_csr(CVMX_CIU_SOFT_BIST, 1);
+
+	/* Default to 64MB in the simulator to speed things up */
+	if (octeon_is_simulation())
+		MAX_MEMORY = 64ull << 20;
+
+	arcs_cmdline[0] = 0;
+	argc = octeon_get_boot_num_arguments();
+	for (i = 0; i < argc; i++) {
+		const char *arg = octeon_get_boot_argument(i);
+		if ((strncmp(arg, "MEM=", 4) == 0) ||
+		    (strncmp(arg, "mem=", 4) == 0)) {
+			sscanf(arg + 4, "%llu", &MAX_MEMORY);
+			MAX_MEMORY <<= 20;
+			if (MAX_MEMORY == 0)
+				MAX_MEMORY = 32ull << 30;
+		} else if (strcmp(arg, "ecc_verbose") == 0) {
+#ifdef CONFIG_CAVIUM_REPORT_SINGLE_BIT_ECC
+			__cvmx_interrupt_ecc_report_single_bit_errors = 1;
+			pr_notice("Reporting of single bit ECC errors is "
+				  "turned on\n");
+#endif
+		} else if (strlen(arcs_cmdline) + strlen(arg) + 1 <
+			   sizeof(arcs_cmdline) - 1) {
+			strcat(arcs_cmdline, " ");
+			strcat(arcs_cmdline, arg);
+		}
+	}
+#ifdef CONFIG_CAVIUM_OCTEON_BOOTBUS_COMPACT_FLASH
+	if (strstr(arcs_cmdline, "use_cf_dma"))
+		ebt3000_cf_enable_dma();
+#endif
+
+#ifdef CONFIG_PCI
+	if (strstr(arcs_cmdline, "console=pci"))
+		pci_console_init(strstr(arcs_cmdline, "console=pci") + 8);
+#endif
+
+	if (strstr(arcs_cmdline, "console=") == NULL) {
+#ifdef CONFIG_GDB_CONSOLE
+		strcat(arcs_cmdline, " console=gdb");
+#else
+#ifdef CONFIG_CAVIUM_OCTEON_2ND_KERNEL
+		strcat(arcs_cmdline, " console=ttyS0,115200");
+#else
+		if (octeon_uart == 1)
+			strcat(arcs_cmdline, " console=ttyS1,115200");
+		else
+			strcat(arcs_cmdline, " console=ttyS0,115200");
+#endif
+#endif
+	}
+
+	if (octeon_is_simulation()) {
+		/* The simulator uses a mtdram device pre filled with the
+		   filesystem. Also specify the calibration delay to avoid
+		   calculating it every time */
+		strcat(arcs_cmdline, " rw root=1f00"
+		       " lpj=60176 slram=root,0x40000000,+1073741824");
+	}
+
+	mips_hpt_frequency = octeon_get_clock_rate();
+
+	_machine_restart = octeon_restart;
+	_machine_halt = octeon_halt;
+
+	memset(&octeon_port, 0, sizeof(octeon_port));
+	/* For early_serial_setup we don't set the port type or
+	 * UPF_FIXED_TYPE.  */
+	octeon_port.flags = ASYNC_SKIP_TEST | UPF_SHARE_IRQ;
+	octeon_port.iotype = UPIO_MEM;
+	/* I/O addresses are every 8 bytes */
+	octeon_port.regshift = 3;
+	/* Clock rate of the chip */
+	octeon_port.uartclk = mips_hpt_frequency;
+	octeon_port.fifosize = 64;
+	octeon_port.mapbase = 0x0001180000000800ull + (1024 * octeon_uart);
+	octeon_port.membase = cvmx_phys_to_ptr(octeon_port.mapbase);
+	octeon_port.serial_in_fn = octeon_serial_in;
+	octeon_port.serial_out_fn = octeon_serial_out;
+#ifdef CONFIG_CAVIUM_OCTEON_2ND_KERNEL
+	octeon_port.line = 0;
+#else
+	octeon_port.line = octeon_uart;
+#endif
+	/* Only CN38XXp{1,2} has errata with uart interrupt */
+	if (!OCTEON_IS_MODEL(OCTEON_CN38XX_PASS2))
+		octeon_port.irq = 42 + octeon_uart;
+	early_serial_setup(&octeon_port);
+
+	octeon_user_io_init();
+	register_smp_ops(&octeon_smp_ops);
+
+#ifdef CONFIG_KGDB
+	{
+		const char *s = "\r\nConnect GDB to this port\r\n";
+		while (*s)
+			putDebugChar(*s++);
+	}
+#endif
+}
+
+
+
+void __init plat_mem_setup(void)
+{
+	uint64_t mem_alloc_size;
+	uint64_t total;
+	int64_t memory;
+
+	total = 0;
+
+	/* First add the init memory we will be returning.  */
+	memory = __pa_symbol(&__init_begin) & PAGE_MASK;
+	mem_alloc_size = (__pa_symbol(&__init_end) & PAGE_MASK) - memory;
+	if (mem_alloc_size > 0) {
+		add_memory_region(memory, mem_alloc_size, BOOT_MEM_RAM);
+		total += mem_alloc_size;
+	}
+
+	/* The Mips memory init uses the first memory location for some memory
+	   vectors. When SPARSEMEM is in use, it doesn't verify that the size
+	   is big enough for the final vectors. Making the smallest chuck 4MB
+	   seems to be enough to consistantly work. This needs to be debugged
+	   more */
+	mem_alloc_size = 4 << 20;
+	if (mem_alloc_size > MAX_MEMORY)
+		mem_alloc_size = MAX_MEMORY;
+
+	/* When allocating memory, we want incrementing addresses from
+	   bootmem_alloc so the code in add_memory_region can merge regions
+	   next to each other */
+	cvmx_bootmem_lock();
+	while ((boot_mem_map.nr_map < BOOT_MEM_MAP_MAX)
+		&& (total < MAX_MEMORY)) {
+#if defined(CONFIG_64BIT) || defined(CONFIG_64BIT_PHYS_ADDR)
+		memory = cvmx_bootmem_phy_alloc(mem_alloc_size,
+						__pa_symbol(&__init_end), -1,
+						0x100000,
+						CVMX_BOOTMEM_FLAG_NO_LOCKING);
+#elif defined(CONFIG_HIGHMEM)
+		memory = cvmx_bootmem_phy_alloc(mem_alloc_size, 0, 1ull << 31,
+						0x100000,
+						CVMX_BOOTMEM_FLAG_NO_LOCKING);
+#else
+		memory = cvmx_bootmem_phy_alloc(mem_alloc_size, 0, 512 << 20,
+						0x100000,
+						CVMX_BOOTMEM_FLAG_NO_LOCKING);
+#endif
+		if (memory >= 0) {
+			/* This function automatically merges address regions
+			   next to each other if they are received in
+			   incrementing order */
+			add_memory_region(memory, mem_alloc_size, BOOT_MEM_RAM);
+			total += mem_alloc_size;
+		} else
+			break;
+	}
+	cvmx_bootmem_unlock();
+
+#ifdef CONFIG_CAVIUM_RESERVE32
+	/* Now that we've allocated the kernel memory it is safe to free the
+		reserved region. We free it here so that builtin drivers can
+		use the memory */
+	if (octeon_reserve32_memory)
+		cvmx_bootmem_free_named("CAVIUM_RESERVE32");
+#endif /* CONFIG_CAVIUM_RESERVE32 */
+
+	if (total == 0)
+		panic("Unable to allocate memory from cvmx_bootmem_phy_alloc\n");
+}
+
+
+void prom_free_prom_memory(void)
+{
+#ifdef CONFIG_CAVIUM_DECODE_RSL
+	cvmx_interrupt_rsl_enable();
+
+	/* Add an interrupt handler for general failures. */
+	if (request_irq(OCTEON_IRQ_RML, octeon_rlm_interrupt, IRQF_SHARED,
+			"RML/RSL", octeon_rlm_interrupt)) {
+		panic("Unable to request_irq(OCTEON_IRQ_RML)\n");
+	}
+#endif
+
+	/* This call is here so that it is performed after any TLB
+	   initializations. It needs to be after these in case the
+	   CONFIG_CAVIUM_RESERVE32_USE_WIRED_TLB option is set */
+	octeon_hal_setup_reserved32();
+}
diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
new file mode 100644
index 0000000..37820f2
--- /dev/null
+++ b/arch/mips/cavium-octeon/smp.c
@@ -0,0 +1,231 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2004-2008 Cavium Networks
+ */
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/smp.h>
+#include <linux/interrupt.h>
+#include <linux/kernel_stat.h>
+#include <linux/sched.h>
+#include <linux/module.h>
+
+#include <asm/mmu_context.h>
+#include <asm/system.h>
+#include <asm/time.h>
+
+#include "hal.h"
+
+extern void octeon_user_io_init(void);
+
+volatile unsigned long octeon_processor_boot = 0xff;
+volatile unsigned long octeon_processor_cycle;
+volatile unsigned long octeon_processor_sp;
+volatile unsigned long octeon_processor_gp;
+
+
+static irqreturn_t mailbox_interrupt(int irq, void *dev_id)
+{
+	const int coreid = cvmx_get_core_num();
+	uint64_t action;
+
+	/* Load the mailbox register to figure out what we're supposed to do */
+	action = cvmx_read_csr(CVMX_CIU_MBOX_CLRX(coreid));
+
+	/* Clear the mailbox to clear the interrupt */
+	cvmx_write_csr(CVMX_CIU_MBOX_CLRX(coreid), action);
+
+	if (action & SMP_CALL_FUNCTION)
+		smp_call_function_interrupt();
+
+	/* Check if we've been told to flush the icache */
+	if (action & SMP_ICACHE_FLUSH)
+		asm volatile ("synci 0($0)\n");
+	return IRQ_HANDLED;
+}
+
+
+/**
+ * Cause the function described by call_data to be executed on the passed
+ * cpu.  When the function has finished, increment the finished field of
+ * call_data.
+ *
+ * @param cpu
+ * @param action
+ */
+static void octeon_send_ipi_single(int cpu, unsigned int action)
+{
+	int coreid = cpu_logical_map(cpu);
+	/*
+	pr_info("SMP: Mailbox send cpu=%d, coreid=%d, action=%u\n", cpu,
+	       coreid, action);
+	*/
+	cvmx_write_csr(CVMX_CIU_MBOX_SETX(coreid), action);
+}
+
+static inline void octeon_send_ipi_mask(cpumask_t mask, unsigned int action)
+{
+	unsigned int i;
+
+	for_each_cpu_mask(i, mask)
+		octeon_send_ipi_single(i, action);
+}
+
+/**
+ * Detect available CPUs, populate phys_cpu_present_map
+ */
+static void octeon_smp_setup(void)
+{
+	const int coreid = cvmx_get_core_num();
+	int cpus;
+	int id;
+
+	int core_mask = octeon_get_boot_coremask();
+
+	cpus_clear(phys_cpu_present_map);
+	__cpu_number_map[coreid] = 0;
+	__cpu_logical_map[0] = coreid;
+	cpu_set(0, phys_cpu_present_map);
+
+	cpus = 1;
+	for (id = 0; id < 16; id++) {
+		if ((id != coreid) && (core_mask & (1 << id))) {
+			cpu_set(cpus, phys_cpu_present_map);
+			__cpu_number_map[id] = cpus;
+			__cpu_logical_map[cpus] = id;
+			cpus++;
+		}
+	}
+}
+
+
+/**
+ * Firmware CPU startup hook
+ *
+ * @param cpu
+ * @param idle
+ */
+static void octeon_boot_secondary(int cpu, struct task_struct *idle)
+{
+	int count;
+
+	pr_info("SMP: Booting CPU%02d (CoreId %2d)...", cpu,
+		cpu_logical_map(cpu));
+
+	octeon_processor_sp = __KSTK_TOS(idle);
+	octeon_processor_gp = (unsigned long)(task_thread_info(idle));
+	/* Use sync so all ops are done. This makes the cycle counter
+	 * propagate in a more bounded amount of time */
+	__sync();
+	octeon_processor_cycle = octeon_get_cycles();
+	octeon_processor_boot = cpu_logical_map(cpu);
+	mb();
+
+	count = 10000;
+	while (octeon_processor_sp && count) {
+		/* Waiting for processor to get the SP and GP */
+		udelay(1);
+		count--;
+	}
+	if (count == 0)
+		pr_err("Secondary boot timeout\n");
+}
+
+
+/**
+ * After we've done initial boot, this function is called to allow the
+ * board code to clean up state, if needed
+ */
+static void octeon_init_secondary(void)
+{
+	const int coreid = cvmx_get_core_num();
+	cvmx_ciu_intx0_t interrupt_enable;
+
+	octeon_check_cpu_bist();
+
+	/*
+	pr_info("SMP: CPU%d (CoreId %lu) started\n", cpu, coreid);
+	*/
+	/* Enable Mailbox interrupts to this core. These are the only
+	   interrupts allowed on line 3 */
+	cvmx_write_csr(CVMX_CIU_MBOX_CLRX(coreid), 0xffffffff);
+	interrupt_enable.u64 = 0;
+	interrupt_enable.s.mbox = 0x3;
+	cvmx_write_csr(CVMX_CIU_INTX_EN0((coreid * 2)), interrupt_enable.u64);
+	cvmx_write_csr(CVMX_CIU_INTX_EN0((coreid * 2 + 1)), 0);
+	cvmx_write_csr(CVMX_CIU_INTX_EN1((coreid * 2)), 0);
+	cvmx_write_csr(CVMX_CIU_INTX_EN1((coreid * 2 + 1)), 0);
+	/* Enable core interrupt processing for 2,3 and 7 */
+	set_c0_status(0x8c01);
+}
+
+
+/**
+ * Callout to firmware before smp_init
+ *
+ * @param max_cpus
+ */
+void octeon_prepare_cpus(unsigned int max_cpus)
+{
+	cvmx_write_csr(CVMX_CIU_MBOX_CLRX(cvmx_get_core_num()), 0xffffffff);
+	if (request_irq(OCTEON_IRQ_MBOX0, mailbox_interrupt, IRQF_SHARED,
+			"mailbox0", mailbox_interrupt)) {
+		panic("Cannot request_irq(OCTEON_IRQ_MBOX0)\n");
+	}
+	if (request_irq(OCTEON_IRQ_MBOX1, mailbox_interrupt, IRQF_SHARED,
+			"mailbox1", mailbox_interrupt)) {
+		panic("Cannot request_irq(OCTEON_IRQ_MBOX1)\n");
+	}
+}
+
+
+/**
+ * Last chance for the board code to finish SMP initialization before
+ * the CPU is "online".
+ */
+static void octeon_smp_finish(void)
+{
+#ifdef CONFIG_CAVIUM_GDB
+	unsigned long tmp;
+	/* Pulse MCD0 signal on Ctrl-C to stop all the cores. Also set the MCD0
+	   to be not masked by this core so we know the signal is received by
+	   someone */
+	asm volatile ("dmfc0 %0, $22\n"
+		      "ori   %0, %0, 0x9100\n" "dmtc0 %0, $22\n" : "=r" (tmp));
+#endif
+
+	octeon_user_io_init();
+
+	/* to generate the first CPU timer interrupt */
+	write_c0_compare(read_c0_count() + mips_hpt_frequency / HZ);
+}
+
+
+/**
+ * Hook for after all CPUs are online
+ */
+static void octeon_cpus_done(void)
+{
+#ifdef CONFIG_CAVIUM_GDB
+	unsigned long tmp;
+	/* Pulse MCD0 signal on Ctrl-C to stop all the cores. Also set the MCD0
+	   to be not masked by this core so we know the signal is received by
+	   someone */
+	asm volatile ("dmfc0 %0, $22\n"
+		      "ori   %0, %0, 0x9100\n" "dmtc0 %0, $22\n" : "=r" (tmp));
+#endif
+}
+
+struct plat_smp_ops octeon_smp_ops = {
+	.send_ipi_single	= octeon_send_ipi_single,
+	.send_ipi_mask		= octeon_send_ipi_mask,
+	.init_secondary		= octeon_init_secondary,
+	.smp_finish		= octeon_smp_finish,
+	.cpus_done		= octeon_cpus_done,
+	.boot_secondary		= octeon_boot_secondary,
+	.smp_setup		= octeon_smp_setup,
+	.prepare_cpus		= octeon_prepare_cpus,
+};
diff --git a/arch/mips/cavium-octeon/userio.c b/arch/mips/cavium-octeon/userio.c
new file mode 100644
index 0000000..9577464
--- /dev/null
+++ b/arch/mips/cavium-octeon/userio.c
@@ -0,0 +1,156 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2004-2007 Cavium Networks
+ */
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/serial.h>
+#include <linux/types.h>
+#include <linux/string.h>	/* for memset */
+#include <linux/console.h>
+#include <linux/serial.h>
+#include <linux/tty.h>
+#include <linux/time.h>
+#include <linux/serial_core.h>
+#include <linux/reboot.h>
+#include <linux/io.h>
+
+#include <asm/processor.h>
+#include <asm/system.h>
+#include <asm/irq_cpu.h>
+#include <asm/mipsregs.h>
+#include <asm/bootinfo.h>
+
+#include "hal.h"
+
+
+/**
+ *
+ * @return
+ */
+void octeon_user_io_init(void)
+{
+	octeon_cvmemctl_t cvmmemctl;
+	cvmx_iob_fau_timeout_t fau_timeout;
+	cvmx_pow_nw_tim_t nm_tim;
+	uint64_t cvmctl;
+
+	/* Get the current settings for CP0_CVMMEMCTL_REG */
+	cvmmemctl.u64 = __read_64bit_c0_register($11, 7);
+	/* R/W If set, marked write-buffer entries time out the same
+	 * as as other entries; if clear, marked write-buffer entries
+	 * use the maximum timeout. */
+	cvmmemctl.s.dismarkwblongto = 1;
+	/* R/W If set, a merged store does not clear the write-buffer
+	 * entry timeout state. */
+	cvmmemctl.s.dismrgclrwbto = 0;
+	/* R/W Two bits that are the MSBs of the resultant CVMSEG LM
+	 * word location for an IOBDMA. The other 8 bits come from the
+	 * SCRADDR field of the IOBDMA. */
+	cvmmemctl.s.iobdmascrmsb = 0;
+	/* R/W If set, SYNCWS and SYNCS only order marked stores; if
+	 * clear, SYNCWS and SYNCS only order unmarked
+	 * stores. SYNCWSMARKED has no effect when DISSYNCWS is
+	 * set. */
+	cvmmemctl.s.syncwsmarked = 0;
+	/* R/W If set, SYNCWS acts as SYNCW and SYNCS acts as SYNC. */
+	cvmmemctl.s.dissyncws = 0;
+	/* R/W If set, no stall happens on write buffer full. */
+	if (OCTEON_IS_MODEL(OCTEON_CN38XX_PASS2))
+		cvmmemctl.s.diswbfst = 1;
+	else
+		cvmmemctl.s.diswbfst = 0;
+	/* R/W If set (and SX set), supervisor-level loads/stores can
+	 * use XKPHYS addresses with <48>==0 */
+	cvmmemctl.s.xkmemenas = 0;
+
+	/* R/W If set (and UX set), user-level loads/stores can use
+	 * XKPHYS addresses with VA<48>==0 */
+	cvmmemctl.s.xkmemenau = 0;
+
+	/* R/W If set (and SX set), supervisor-level loads/stores can
+	 * use XKPHYS addresses with VA<48>==1 */
+	cvmmemctl.s.xkioenas = 0;
+
+	/* R/W If set (and UX set), user-level loads/stores can use
+	 * XKPHYS addresses with VA<48>==1 */
+	cvmmemctl.s.xkioenau = 0;
+
+	/* R/W If set, all stores act as SYNCW (NOMERGE must be set
+	 * when this is set) RW, reset to 0. */
+	cvmmemctl.s.allsyncw = 0;
+
+	/* R/W If set, no stores merge, and all stores reach the
+	 * coherent bus in order. */
+	cvmmemctl.s.nomerge = 0;
+	/* R/W Selects the bit in the counter used for DID time-outs 0
+	 * = 231, 1 = 230, 2 = 229, 3 = 214. Actual time-out is
+	 * between 1� and 2� this interval. For example, with
+	 * DIDTTO=3, expiration interval is between 16K and 32K. */
+	cvmmemctl.s.didtto = 0;
+	/* R/W If set, the (mem) CSR clock never turns off. */
+	cvmmemctl.s.csrckalwys = 0;
+	/* R/W If set, mclk never turns off. */
+	cvmmemctl.s.mclkalwys = 0;
+	/* R/W Selects the bit in the counter used for write buffer
+	 * flush time-outs (WBFLT+11) is the bit position in an
+	 * internal counter used to determine expiration. The write
+	 * buffer expires between 1� and 2� this interval. For
+	 * example, with WBFLT = 0, a write buffer expires between 2K
+	 * and 4K cycles after the write buffer entry is allocated. */
+	cvmmemctl.s.wbfltime = 0;
+	/* R/W If set, do not put Istream in the L2 cache. */
+	cvmmemctl.s.istrnol2 = 0;
+	/* R/W The write buffer threshold. */
+	cvmmemctl.s.wbthresh = 10;
+	/* R/W If set, CVMSEG is available for loads/stores in
+	 * kernel/debug mode. */
+#if CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE > 0
+	cvmmemctl.s.cvmsegenak = 1;
+#else
+	cvmmemctl.s.cvmsegenak = 0;
+#endif
+	/* R/W If set, CVMSEG is available for loads/stores in
+	 * supervisor mode. */
+	cvmmemctl.s.cvmsegenas = 0;
+	/* R/W If set, CVMSEG is available for loads/stores in user
+	 * mode. */
+	cvmmemctl.s.cvmsegenau = 0;
+	/* R/W Size of local memory in cache blocks, 54 (6912 bytes)
+	 * is max legal value. */
+	cvmmemctl.s.lmemsz = CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE;
+
+
+	if (smp_processor_id() == 0)
+		pr_notice("CVMSEG size: %d cache lines (%d bytes)\n",
+			  CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE,
+			  CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE * 128);
+
+	__write_64bit_c0_register($11, 7, cvmmemctl.u64);
+
+	/* Move the performance counter interrupts to IRQ 6 */
+	cvmctl = __read_64bit_c0_register($9, 7);
+	cvmctl &= ~(7 << 7);
+	cvmctl |= 6 << 7;
+	__write_64bit_c0_register($9, 7, cvmctl);
+
+	/* Set a default for the hardware timeouts */
+	fau_timeout.u64 = 0;
+	fau_timeout.s.tout_val = 0xfff;
+	/* Disable tagwait FAU timeout */
+	fau_timeout.s.tout_enb = 0;
+	cvmx_write_csr(CVMX_IOB_FAU_TIMEOUT, fau_timeout.u64);
+
+	nm_tim.u64 = 0;
+	/* 4096 cycles */
+	nm_tim.s.nw_tim = 3;
+	cvmx_write_csr(CVMX_POW_NW_TIM, nm_tim.u64);
+
+	write_c0_cacheerr(0);
+	write_c0_derraddr1(0);
+}
-- 
1.5.5.1
