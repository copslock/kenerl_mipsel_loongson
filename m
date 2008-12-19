Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Dec 2008 23:20:52 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:45266 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S24208309AbYLSXUo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 19 Dec 2008 23:20:44 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B494c2c400001>; Fri, 19 Dec 2008 18:20:32 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 19 Dec 2008 15:20:32 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 19 Dec 2008 15:20:31 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mBJNKTBa011737;
	Fri, 19 Dec 2008 15:20:29 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mBJNKTht011736;
	Fri, 19 Dec 2008 15:20:29 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 2/2] MIPS: Add Cavium OCTEON PCI support.
Date:	Fri, 19 Dec 2008 15:20:28 -0800
Message-Id: <1229728828-11708-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <494C2BC1.2080903@caviumnetworks.com>
References: <494C2BC1.2080903@caviumnetworks.com>
X-OriginalArrivalTime: 19 Dec 2008 23:20:31.0989 (UTC) FILETIME=[63407250:01C96230]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21628
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

This patch adds support for PCI and PCIe to the base Cavium OCTEON
processor support.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/Kconfig                                  |    2 +
 arch/mips/cavium-octeon/Makefile                   |    4 +
 arch/mips/cavium-octeon/dma-octeon.c               |  310 ++++++-
 arch/mips/cavium-octeon/executive/Makefile         |    2 +
 .../cavium-octeon/executive/cvmx-helper-errata.c   |  379 +++++++
 .../cavium-octeon/executive/cvmx-helper-util.c     |  502 ++++++++++
 arch/mips/cavium-octeon/executive/cvmx-pcie.c      | 1053 ++++++++++++++++++++
 arch/mips/cavium-octeon/msi.c                      |  288 ++++++
 arch/mips/cavium-octeon/octeon-irq.c               |    2 +
 arch/mips/cavium-octeon/pci-common.c               |  137 +++
 arch/mips/cavium-octeon/pci-common.h               |   39 +
 arch/mips/cavium-octeon/pci.c                      |  568 +++++++++++
 arch/mips/cavium-octeon/pcie.c                     |  441 ++++++++
 arch/mips/include/asm/octeon/cvmx-asm.h            |    3 +-
 arch/mips/include/asm/octeon/cvmx-helper-errata.h  |   92 ++
 arch/mips/include/asm/octeon/cvmx-helper-util.h    |  266 +++++
 arch/mips/include/asm/octeon/cvmx-packet.h         |   16 +-
 arch/mips/include/asm/octeon/cvmx-pcie.h           |  284 ++++++
 arch/mips/include/asm/octeon/cvmx-wqe.h            |  422 ++++++++
 arch/mips/include/asm/octeon/cvmx.h                |   12 +
 arch/mips/include/asm/octeon/octeon.h              |    2 +
 21 files changed, 4816 insertions(+), 8 deletions(-)
 create mode 100644 arch/mips/cavium-octeon/executive/cvmx-helper-errata.c
 create mode 100644 arch/mips/cavium-octeon/executive/cvmx-helper-util.c
 create mode 100644 arch/mips/cavium-octeon/executive/cvmx-pcie.c
 create mode 100644 arch/mips/cavium-octeon/msi.c
 create mode 100644 arch/mips/cavium-octeon/pci-common.c
 create mode 100644 arch/mips/cavium-octeon/pci-common.h
 create mode 100644 arch/mips/cavium-octeon/pci.c
 create mode 100644 arch/mips/cavium-octeon/pcie.c
 create mode 100644 arch/mips/include/asm/octeon/cvmx-helper-errata.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-helper-util.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-pcie.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-wqe.h

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ea2b262..f009496 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -620,6 +620,8 @@ config CAVIUM_OCTEON_REFERENCE_BOARD
 	select SYS_HAS_EARLY_PRINTK
 	select CPU_CAVIUM_OCTEON
 	select SWAP_IO_SPACE
+	select HW_HAS_PCI
+	select ARCH_SUPPORTS_MSI
 	help
 	  This option supports all of the Octeon reference boards from Cavium
 	  Networks. It builds a kernel that dynamically determines the Octeon
diff --git a/arch/mips/cavium-octeon/Makefile b/arch/mips/cavium-octeon/Makefile
index 1c2a7fa..2b5f08f 100644
--- a/arch/mips/cavium-octeon/Makefile
+++ b/arch/mips/cavium-octeon/Makefile
@@ -14,3 +14,7 @@ obj-y += dma-octeon.o flash_setup.o
 obj-y += octeon-memcpy.o
 
 obj-$(CONFIG_SMP)                     += smp.o
+obj-$(CONFIG_PCI)                     += pci-common.o
+obj-$(CONFIG_PCI)                     += pci.o
+obj-$(CONFIG_PCI)                     += pcie.o
+obj-$(CONFIG_PCI_MSI)                 += msi.o
diff --git a/arch/mips/cavium-octeon/dma-octeon.c b/arch/mips/cavium-octeon/dma-octeon.c
index 01b1ef9..af3c26f 100644
--- a/arch/mips/cavium-octeon/dma-octeon.c
+++ b/arch/mips/cavium-octeon/dma-octeon.c
@@ -13,20 +13,326 @@
  */
 #include <linux/types.h>
 #include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/dma-mapping.h>
+#include <linux/platform_device.h>
+#include <linux/scatterlist.h>
+
+#include <linux/cache.h>
+#include <linux/io.h>
+
+#include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-npi-defs.h>
+#include <asm/octeon/cvmx-pci-defs.h>
 
 #include <dma-coherence.h>
 
+#ifdef CONFIG_PCI
+#include "pci-common.h"
+#endif
+
+#define BAR2_PCI_ADDRESS 0x8000000000ul
+
+struct bar1_index_state {
+	int16_t ref_count;	/* Number of PCI mappings using this index */
+	uint16_t address_bits;	/* Upper bits of physical address. This is
+				   shifted 22 bits */
+};
+
+#ifdef CONFIG_PCI
+static DEFINE_SPINLOCK(bar1_lock);
+static struct bar1_index_state bar1_state[32];
+#endif
+
 dma_addr_t octeon_map_dma_mem(struct device *dev, void *ptr, size_t size)
 {
+#ifndef CONFIG_PCI
 	/* Without PCI/PCIe this function can be called for Octeon internal
 	   devices such as USB. These devices all support 64bit addressing */
 	mb();
 	return virt_to_phys(ptr);
+#else
+	unsigned long flags;
+	uint64_t dma_mask;
+	int64_t start_index;
+	dma_addr_t result = -1;
+	uint64_t physical = virt_to_phys(ptr);
+	int64_t index;
+
+	mb();
+	/*
+	 * Use the DMA masks to determine the allowed memory
+	 * region. For us it doesn't limit the actual memory, just the
+	 * address visible over PCI.  Devices with limits need to use
+	 * lower indexed Bar1 entries.
+	 */
+	if (dev) {
+		dma_mask = dev->coherent_dma_mask;
+		if (dev->dma_mask)
+			dma_mask = *dev->dma_mask;
+	} else
+		dma_mask = 0xfffffffful;
+
+	/*
+	 * Platform devices, such as the internal USB, skip all
+	 * translation and use Octeon physical addresses directly.
+	 */
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
+			union cvmx_pci_bar1_indexx bar1_index;
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
+done_unlock:
+	spin_unlock_irqrestore(&bar1_lock, flags);
+done:
+	pr_debug("dma_map_single 0x%lx->0x%lx\n", physical, result);
+	return result;
+#endif
 }
 
 void octeon_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr)
 {
-	/* Without PCI/PCIe this function can be called for Octeon internal
-	 * devices such as USB. These devices all support 64bit addressing */
+#ifndef CONFIG_PCI
+	/*
+	 * Without PCI/PCIe this function can be called for Octeon internal
+	 * devices such as USB. These devices all support 64bit addressing.
+	 */
+	return;
+#else
+	unsigned long flags;
+	uint64_t index;
+
+	/*
+	 * Platform devices, such as the internal USB, skip all
+	 * translation and use Octeon physical addresses directly.
+	 */
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
+done:
+	pr_debug("dma_unmap_single 0x%lx\n", dma_addr);
 	return;
+#endif
 }
diff --git a/arch/mips/cavium-octeon/executive/Makefile b/arch/mips/cavium-octeon/executive/Makefile
index 80d6cb2..9b470dd 100644
--- a/arch/mips/cavium-octeon/executive/Makefile
+++ b/arch/mips/cavium-octeon/executive/Makefile
@@ -11,3 +11,5 @@
 
 obj-y += cvmx-bootmem.o cvmx-l2c.o cvmx-sysinfo.o octeon-model.o
 
+obj-$(CONFIG_PCI) += cvmx-pcie.o
+obj-$(CONFIG_PCI) += cvmx-helper-errata.o cvmx-helper-util.o
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-errata.c b/arch/mips/cavium-octeon/executive/cvmx-helper-errata.c
new file mode 100644
index 0000000..98822c1
--- /dev/null
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-errata.c
@@ -0,0 +1,379 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/**
+ *
+ * Fixes and workaround for Octeon chip errata. This file
+ * contains functions called by cvmx-helper to workaround known
+ * chip errata. For the most part, code doesn't need to call
+ * these functions directly.
+ *
+ */
+#include <asm/octeon/octeon.h>
+
+#include <asm/octeon/cvmx-helper-util.h>
+
+#ifdef CVMX_ENABLE_PKO_FUNCTIONS
+
+/**
+ * @INTERNAL
+ * Function to adjust internal IPD pointer alignments
+ *
+ * Returns 0 on success
+ *         !0 on failure
+ */
+int __cvmx_helper_errata_fix_ipd_ptr_alignment(void)
+{
+#define FIX_IPD_FIRST_BUFF_PAYLOAD_BYTES \
+	(CVMX_FPA_PACKET_POOL_SIZE - 8 - CVMX_HELPER_FIRST_MBUFF_SKIP)
+#define FIX_IPD_NON_FIRST_BUFF_PAYLOAD_BYTES \
+	(CVMX_FPA_PACKET_POOL_SIZE - 8 - CVMX_HELPER_NOT_FIRST_MBUFF_SKIP)
+#define FIX_IPD_OUTPORT 0
+	/* Ports 0-15 are interface 0, 16-31 are interface 1 */
+#define INTERFACE(port) (port >> 4)
+#define INDEX(port) (port & 0xf)
+	uint64_t *p64;
+	cvmx_pko_command_word0_t pko_command;
+	cvmx_buf_ptr_t g_buffer, pkt_buffer;
+	cvmx_wqe_t *work;
+	int size, num_segs = 0, wqe_pcnt, pkt_pcnt;
+	cvmx_gmxx_prtx_cfg_t gmx_cfg;
+	int retry_cnt;
+	int retry_loop_cnt;
+	int mtu;
+	int i;
+	cvmx_helper_link_info_t link_info;
+
+	/* Save values for restore at end */
+	uint64_t prtx_cfg =
+	    cvmx_read_csr(CVMX_GMXX_PRTX_CFG(INDEX(FIX_IPD_OUTPORT),
+					     INTERFACE(FIX_IPD_OUTPORT)));
+	uint64_t tx_ptr_en =
+	    cvmx_read_csr(CVMX_ASXX_TX_PRT_EN(INTERFACE(FIX_IPD_OUTPORT)));
+	uint64_t rx_ptr_en =
+	    cvmx_read_csr(CVMX_ASXX_RX_PRT_EN(INTERFACE(FIX_IPD_OUTPORT)));
+	uint64_t rxx_jabber =
+	    cvmx_read_csr(CVMX_GMXX_RXX_JABBER(INDEX(FIX_IPD_OUTPORT),
+					       INTERFACE(FIX_IPD_OUTPORT)));
+	uint64_t frame_max =
+	    cvmx_read_csr(CVMX_GMXX_RXX_FRM_MAX(INDEX(FIX_IPD_OUTPORT),
+						INTERFACE(FIX_IPD_OUTPORT)));
+
+	/* Configure port to gig FDX as required for loopback mode */
+	cvmx_helper_rgmii_internal_loopback(FIX_IPD_OUTPORT);
+
+	/*
+	 * Disable reception on all ports so if traffic is present it
+	 * will not interfere.
+	 */
+	cvmx_write_csr(CVMX_ASXX_RX_PRT_EN(INTERFACE(FIX_IPD_OUTPORT)), 0);
+
+	cvmx_wait(100000000ull);
+
+	for (retry_loop_cnt = 0; retry_loop_cnt < 10; retry_loop_cnt++) {
+		retry_cnt = 100000;
+		wqe_pcnt = cvmx_read_csr(CVMX_IPD_PTR_COUNT);
+		pkt_pcnt = (wqe_pcnt >> 7) & 0x7f;
+		wqe_pcnt &= 0x7f;
+
+		num_segs = (2 + pkt_pcnt - wqe_pcnt) & 3;
+
+		if (num_segs == 0)
+			goto fix_ipd_exit;
+
+		num_segs += 1;
+
+		size =
+		    FIX_IPD_FIRST_BUFF_PAYLOAD_BYTES +
+		    ((num_segs - 1) * FIX_IPD_NON_FIRST_BUFF_PAYLOAD_BYTES) -
+		    (FIX_IPD_NON_FIRST_BUFF_PAYLOAD_BYTES / 2);
+
+		cvmx_write_csr(CVMX_ASXX_PRT_LOOP(INTERFACE(FIX_IPD_OUTPORT)),
+			       1 << INDEX(FIX_IPD_OUTPORT));
+		CVMX_SYNC;
+
+		g_buffer.u64 = 0;
+		g_buffer.s.addr =
+		    cvmx_ptr_to_phys(cvmx_fpa_alloc(CVMX_FPA_WQE_POOL));
+		if (g_buffer.s.addr == 0) {
+			cvmx_dprintf("WARNING: FIX_IPD_PTR_ALIGNMENT buffer "
+				     "allocation failure.\n");
+			goto fix_ipd_exit;
+		}
+
+		g_buffer.s.pool = CVMX_FPA_WQE_POOL;
+		g_buffer.s.size = num_segs;
+
+		pkt_buffer.u64 = 0;
+		pkt_buffer.s.addr =
+		    cvmx_ptr_to_phys(cvmx_fpa_alloc(CVMX_FPA_PACKET_POOL));
+		if (pkt_buffer.s.addr == 0) {
+			cvmx_dprintf("WARNING: FIX_IPD_PTR_ALIGNMENT buffer "
+				     "allocation failure.\n");
+			goto fix_ipd_exit;
+		}
+		pkt_buffer.s.i = 1;
+		pkt_buffer.s.pool = CVMX_FPA_PACKET_POOL;
+		pkt_buffer.s.size = FIX_IPD_FIRST_BUFF_PAYLOAD_BYTES;
+
+		p64 = (uint64_t *) cvmx_phys_to_ptr(pkt_buffer.s.addr);
+		p64[0] = 0xffffffffffff0000ull;
+		p64[1] = 0x08004510ull;
+		p64[2] = ((uint64_t) (size - 14) << 48) | 0x5ae740004000ull;
+		p64[3] = 0x3a5fc0a81073c0a8ull;
+
+		for (i = 0; i < num_segs; i++) {
+			if (i > 0)
+				pkt_buffer.s.size =
+				    FIX_IPD_NON_FIRST_BUFF_PAYLOAD_BYTES;
+
+			if (i == (num_segs - 1))
+				pkt_buffer.s.i = 0;
+
+			*(uint64_t *) cvmx_phys_to_ptr(g_buffer.s.addr +
+						       8 * i) = pkt_buffer.u64;
+		}
+
+		/* Build the PKO command */
+		pko_command.u64 = 0;
+		pko_command.s.segs = num_segs;
+		pko_command.s.total_bytes = size;
+		pko_command.s.dontfree = 0;
+		pko_command.s.gather = 1;
+
+		gmx_cfg.u64 =
+		    cvmx_read_csr(CVMX_GMXX_PRTX_CFG
+				  (INDEX(FIX_IPD_OUTPORT),
+				   INTERFACE(FIX_IPD_OUTPORT)));
+		gmx_cfg.s.en = 1;
+		cvmx_write_csr(CVMX_GMXX_PRTX_CFG
+			       (INDEX(FIX_IPD_OUTPORT),
+				INTERFACE(FIX_IPD_OUTPORT)), gmx_cfg.u64);
+		cvmx_write_csr(CVMX_ASXX_TX_PRT_EN(INTERFACE(FIX_IPD_OUTPORT)),
+			       1 << INDEX(FIX_IPD_OUTPORT));
+		cvmx_write_csr(CVMX_ASXX_RX_PRT_EN(INTERFACE(FIX_IPD_OUTPORT)),
+			       1 << INDEX(FIX_IPD_OUTPORT));
+
+		mtu =
+		    cvmx_read_csr(CVMX_GMXX_RXX_JABBER
+				  (INDEX(FIX_IPD_OUTPORT),
+				   INTERFACE(FIX_IPD_OUTPORT)));
+		cvmx_write_csr(CVMX_GMXX_RXX_JABBER
+			       (INDEX(FIX_IPD_OUTPORT),
+				INTERFACE(FIX_IPD_OUTPORT)), 65392 - 14 - 4);
+		cvmx_write_csr(CVMX_GMXX_RXX_FRM_MAX
+			       (INDEX(FIX_IPD_OUTPORT),
+				INTERFACE(FIX_IPD_OUTPORT)), 65392 - 14 - 4);
+
+#if CVMX_PKO_USE_FAU_FOR_OUTPUT_QUEUES
+		cvmx_pko_send_packet_prepare(FIX_IPD_OUTPORT,
+					     cvmx_pko_get_base_queue
+					     (FIX_IPD_OUTPORT),
+					     CVMX_PKO_LOCK_NONE);
+		cvmx_pko_send_packet_finish(FIX_IPD_OUTPORT,
+					    cvmx_pko_get_base_queue
+					    (FIX_IPD_OUTPORT), pko_command,
+					    g_buffer, CVMX_PKO_LOCK_NONE);
+#else
+		cvmx_pko_send_packet_prepare(FIX_IPD_OUTPORT,
+					     cvmx_pko_get_base_queue
+					     (FIX_IPD_OUTPORT),
+					     CVMX_PKO_LOCK_CMD_QUEUE);
+		cvmx_pko_send_packet_finish(FIX_IPD_OUTPORT,
+					    cvmx_pko_get_base_queue
+					    (FIX_IPD_OUTPORT), pko_command,
+					    g_buffer, CVMX_PKO_LOCK_CMD_QUEUE);
+#endif
+		CVMX_SYNC;
+
+		do {
+			work = cvmx_pow_work_request_sync(CVMX_POW_WAIT);
+			retry_cnt--;
+		} while ((work == NULL) && (retry_cnt > 0));
+
+		if (!retry_cnt)
+			cvmx_dprintf("WARNING: FIX_IPD_PTR_ALIGNMENT "
+				     "get_work() timeout occured.\n");
+
+		/* Free packet */
+		if (work)
+			cvmx_helper_free_packet_data(work);
+	}
+
+fix_ipd_exit:
+
+	/* Return CSR configs to saved values */
+	cvmx_write_csr(CVMX_GMXX_PRTX_CFG
+		       (INDEX(FIX_IPD_OUTPORT), INTERFACE(FIX_IPD_OUTPORT)),
+		       prtx_cfg);
+	cvmx_write_csr(CVMX_ASXX_TX_PRT_EN(INTERFACE(FIX_IPD_OUTPORT)),
+		       tx_ptr_en);
+	cvmx_write_csr(CVMX_ASXX_RX_PRT_EN(INTERFACE(FIX_IPD_OUTPORT)),
+		       rx_ptr_en);
+	cvmx_write_csr(CVMX_GMXX_RXX_JABBER
+		       (INDEX(FIX_IPD_OUTPORT), INTERFACE(FIX_IPD_OUTPORT)),
+		       rxx_jabber);
+	cvmx_write_csr(CVMX_GMXX_RXX_FRM_MAX
+		       (INDEX(FIX_IPD_OUTPORT), INTERFACE(FIX_IPD_OUTPORT)),
+		       frame_max);
+	cvmx_write_csr(CVMX_ASXX_PRT_LOOP(INTERFACE(FIX_IPD_OUTPORT)), 0);
+	/* Set link to down so autonegotiation will set it up again */
+	link_info.u64 = 0;
+	cvmx_helper_link_set(FIX_IPD_OUTPORT, link_info);
+
+	/*
+	 * Bring the link back up as autonegotiation is not done in
+	 * user applications.
+	 */
+	cvmx_helper_link_autoconf(FIX_IPD_OUTPORT);
+
+	CVMX_SYNC;
+	if (num_segs)
+		cvmx_dprintf("WARNING: FIX_IPD_PTR_ALIGNMENT failed.\n");
+
+	return !!num_segs;
+
+}
+
+/**
+ * @INTERNAL
+ * Workaround ASX setup errata with CN38XX pass1
+ *
+ * @interface: Interface to setup
+ * @port:      Port to setup (0..3)
+ * @cpu_clock_hz:
+ *                  Chip frequency in Hertz
+ *
+ * Returns Zero on success, negative on failure
+ */
+int __cvmx_helper_errata_asx_pass1(int interface, int port, int cpu_clock_hz)
+{
+	/* Set hi water mark as per errata GMX-4 */
+	if (cpu_clock_hz >= 325000000 && cpu_clock_hz < 375000000)
+		cvmx_write_csr(CVMX_ASXX_TX_HI_WATERX(port, interface), 12);
+	else if (cpu_clock_hz >= 375000000 && cpu_clock_hz < 437000000)
+		cvmx_write_csr(CVMX_ASXX_TX_HI_WATERX(port, interface), 11);
+	else if (cpu_clock_hz >= 437000000 && cpu_clock_hz < 550000000)
+		cvmx_write_csr(CVMX_ASXX_TX_HI_WATERX(port, interface), 10);
+	else if (cpu_clock_hz >= 550000000 && cpu_clock_hz < 687000000)
+		cvmx_write_csr(CVMX_ASXX_TX_HI_WATERX(port, interface), 9);
+	else
+		cvmx_dprintf("Illegal clock frequency (%d). "
+			     "CVMX_ASXX_TX_HI_WATERX not set\n",
+			     cpu_clock_hz);
+	return 0;
+}
+
+/**
+ * This function needs to be called on all Octeon chips with
+ * errata PKI-100.
+ *
+ * The Size field is 8 too large in WQE and next pointers
+ *
+ *  The Size field generated by IPD is 8 larger than it should
+ *  be. The Size field is <55:40> of both:
+ *      - WORD3 in the work queue entry, and
+ *      - the next buffer pointer (which precedes the packet data
+ *        in each buffer).
+ *
+ * @work:   Work queue entry to fix
+ * Returns Zero on success. Negative on failure
+ */
+int cvmx_helper_fix_ipd_packet_chain(cvmx_wqe_t *work)
+{
+	uint64_t number_buffers = work->word2.s.bufs;
+
+	/* We only need to do this if the work has buffers */
+	if (number_buffers) {
+		cvmx_buf_ptr_t buffer_ptr = work->packet_ptr;
+		/* Check for errata PKI-100 */
+		if ((buffer_ptr.s.pool == 0) &&
+		    (((uint64_t) buffer_ptr.s.size +
+			    ((uint64_t) buffer_ptr.s.back << 7) +
+			    ((uint64_t) buffer_ptr.s.addr & 0x7F)) !=
+			    (CVMX_FPA_PACKET_POOL_SIZE + 8))) {
+			/* fix is not needed */
+			return 0;
+		}
+		/* Decrement the work packet pointer */
+		buffer_ptr.s.size -= 8;
+		work->packet_ptr = buffer_ptr;
+
+		/*
+		 * Now loop through decrementing the size for each
+		 * additional buffer.
+		 */
+		while (--number_buffers) {
+			/* Chain pointers are 8 bytes before the data */
+			cvmx_buf_ptr_t *ptr =
+			    (cvmx_buf_ptr_t *) cvmx_phys_to_ptr(buffer_ptr.s.addr - 8);
+			buffer_ptr = *ptr;
+			buffer_ptr.s.size -= 8;
+			*ptr = buffer_ptr;
+		}
+	}
+	/*
+	 * Make sure that these write go out before other operations
+	 * such as FPA frees.
+	 */
+	CVMX_SYNCWS;
+	return 0;
+}
+
+#endif /* CVMX_ENABLE_PKO_FUNCTIONS */
+
+/**
+ * Due to errata G-720, the 2nd order CDR circuit on CN52XX pass
+ * 1 doesn't work properly. The following code disables 2nd order
+ * CDR for the specified QLM.
+ *
+ * @qlm:    QLM to disable 2nd order CDR for.
+ */
+void __cvmx_helper_errata_qlm_disable_2nd_order_cdr(int qlm)
+{
+	int lane;
+	cvmx_helper_qlm_jtag_init();
+	/* We need to load all four lanes of the QLM, a total of 1072 bits */
+	for (lane = 0; lane < 4; lane++) {
+		/*
+		 * Each lane has 268 bits. We need to set
+		 * cfg_cdr_incx<67:64> = 3 and cfg_cdr_secord<77> =
+		 * 1. All other bits are zero. Bits go in LSB first,
+		 * so start off with the zeros for bits <63:0>.
+		 */
+		cvmx_helper_qlm_jtag_shift_zeros(qlm, 63 - 0 + 1);
+		/* cfg_cdr_incx<67:64>=3 */
+		cvmx_helper_qlm_jtag_shift(qlm, 67 - 64 + 1, 3);
+		/* Zeros for bits <76:68> */
+		cvmx_helper_qlm_jtag_shift_zeros(qlm, 76 - 68 + 1);
+		/* cfg_cdr_secord<77>=1 */
+		cvmx_helper_qlm_jtag_shift(qlm, 77 - 77 + 1, 1);
+		/* Zeros for bits <267:78> */
+		cvmx_helper_qlm_jtag_shift_zeros(qlm, 267 - 78 + 1);
+	}
+	cvmx_helper_qlm_jtag_update(qlm);
+}
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-util.c b/arch/mips/cavium-octeon/executive/cvmx-helper-util.c
new file mode 100644
index 0000000..dc0087c
--- /dev/null
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-util.c
@@ -0,0 +1,502 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/**
+ *
+ * Small helper utilities.
+ *
+ */
+
+#include <asm/octeon/octeon.h>
+
+#include <asm/octeon/cvmx-helper-util.h>
+
+#ifdef CVMX_ENABLE_HELPER_FUNCTIONS
+
+/**
+ * Get the version of the CVMX libraries.
+ *
+ * Returns Version string. Note this buffer is allocated statically
+ *         and will be shared by all callers.
+ */
+const char *cvmx_helper_get_version(void)
+{
+	return OCTEON_SDK_VERSION_STRING;
+}
+
+/**
+ * Convert a interface mode into a human readable string
+ *
+ * @mode:   Mode to convert
+ *
+ * Returns String
+ */
+const char *cvmx_helper_interface_mode_to_string(cvmx_helper_interface_mode_t
+						 mode)
+{
+	switch (mode) {
+	case CVMX_HELPER_INTERFACE_MODE_DISABLED:
+		return "DISABLED";
+	case CVMX_HELPER_INTERFACE_MODE_RGMII:
+		return "RGMII";
+	case CVMX_HELPER_INTERFACE_MODE_GMII:
+		return "GMII";
+	case CVMX_HELPER_INTERFACE_MODE_SPI:
+		return "SPI";
+	case CVMX_HELPER_INTERFACE_MODE_PCIE:
+		return "PCIE";
+	case CVMX_HELPER_INTERFACE_MODE_XAUI:
+		return "XAUI";
+	case CVMX_HELPER_INTERFACE_MODE_SGMII:
+		return "SGMII";
+	case CVMX_HELPER_INTERFACE_MODE_PICMG:
+		return "PICMG";
+	case CVMX_HELPER_INTERFACE_MODE_NPI:
+		return "NPI";
+	case CVMX_HELPER_INTERFACE_MODE_LOOP:
+		return "LOOP";
+	}
+	return "UNKNOWN";
+}
+
+/**
+ * Debug routine to dump the packet structure to the console
+ *
+ * @work:   Work queue entry containing the packet to dump
+ */
+int cvmx_helper_dump_packet(cvmx_wqe_t *work)
+{
+	uint64_t count;
+	uint64_t remaining_bytes;
+	cvmx_buf_ptr_t buffer_ptr;
+	uint64_t start_of_buffer;
+	uint8_t *data_address;
+	uint8_t *end_of_data;
+
+	cvmx_dprintf("Packet Length:   %u\n", work->len);
+	cvmx_dprintf("    Input Port:  %u\n", work->ipprt);
+	cvmx_dprintf("    QoS:         %u\n", work->qos);
+	cvmx_dprintf("    Buffers:     %u\n", work->word2.s.bufs);
+
+	if (work->word2.s.bufs == 0) {
+		cvmx_ipd_wqe_fpa_queue_t wqe_pool;
+		wqe_pool.u64 = cvmx_read_csr(CVMX_IPD_WQE_FPA_QUEUE);
+		buffer_ptr.u64 = 0;
+		buffer_ptr.s.pool = wqe_pool.s.wqe_pool;
+		buffer_ptr.s.size = 128;
+		buffer_ptr.s.addr = cvmx_ptr_to_phys(work->packet_data);
+		if (cvmx_likely(!work->word2.s.not_IP)) {
+			if (work->word2.s.is_v6)
+				buffer_ptr.s.addr += 2;
+			else
+				buffer_ptr.s.addr += 6;
+		}
+	} else
+		buffer_ptr = work->packet_ptr;
+	remaining_bytes = work->len;
+
+	while (remaining_bytes) {
+		start_of_buffer =
+		    ((buffer_ptr.s.addr >> 7) - buffer_ptr.s.back) << 7;
+		cvmx_dprintf("    Buffer Start:%llx\n",
+			     (unsigned long long)start_of_buffer);
+		cvmx_dprintf("    Buffer I   : %u\n", buffer_ptr.s.i);
+		cvmx_dprintf("    Buffer Back: %u\n", buffer_ptr.s.back);
+		cvmx_dprintf("    Buffer Pool: %u\n", buffer_ptr.s.pool);
+		cvmx_dprintf("    Buffer Data: %llx\n",
+			     (unsigned long long)buffer_ptr.s.addr);
+		cvmx_dprintf("    Buffer Size: %u\n", buffer_ptr.s.size);
+
+		cvmx_dprintf("\t\t");
+		data_address = (uint8_t *) cvmx_phys_to_ptr(buffer_ptr.s.addr);
+		end_of_data = data_address + buffer_ptr.s.size;
+		count = 0;
+		while (data_address < end_of_data) {
+			if (remaining_bytes == 0)
+				break;
+			else
+				remaining_bytes--;
+			cvmx_dprintf("%02x", (unsigned int)*data_address);
+			data_address++;
+			if (remaining_bytes && (count == 7)) {
+				cvmx_dprintf("\n\t\t");
+				count = 0;
+			} else
+				count++;
+		}
+		cvmx_dprintf("\n");
+
+		if (remaining_bytes)
+			buffer_ptr =
+			    *(cvmx_buf_ptr_t *) cvmx_phys_to_ptr(buffer_ptr.s.
+								 addr - 8);
+	}
+	return 0;
+}
+
+/**
+ * Setup Random Early Drop on a specific input queue
+ *
+ * @queue:  Input queue to setup RED on (0-7)
+ * @pass_thresh:
+ *               Packets will begin slowly dropping when there are less than
+ *               this many packet buffers free in FPA 0.
+ * @drop_thresh:
+ *               All incomming packets will be dropped when there are less
+ *               than this many free packet buffers in FPA 0.
+ * Returns Zero on success. Negative on failure
+ */
+int cvmx_helper_setup_red_queue(int queue, int pass_thresh, int drop_thresh)
+{
+	cvmx_ipd_qos_red_marks_t red_marks;
+	cvmx_ipd_red_quex_param_t red_param;
+
+	/*
+	 * Set RED to begin dropping packets when there are
+	 * pass_thresh buffers left. It will linearly drop more
+	 * packets until reaching drop_thresh buffers.
+	 */
+	red_marks.u64 = 0;
+	red_marks.s.drop = drop_thresh;
+	red_marks.s.pass = pass_thresh;
+	cvmx_write_csr(CVMX_IPD_QOSX_RED_MARKS(queue), red_marks.u64);
+
+	/* Use the actual queue 0 counter, not the average */
+	red_param.u64 = 0;
+	red_param.s.prb_con =
+	    (255ul << 24) / (red_marks.s.pass - red_marks.s.drop);
+	red_param.s.avg_con = 1;
+	red_param.s.new_con = 255;
+	red_param.s.use_pcnt = 1;
+	cvmx_write_csr(CVMX_IPD_RED_QUEX_PARAM(queue), red_param.u64);
+	return 0;
+}
+
+/**
+ * Setup Random Early Drop to automatically begin dropping packets.
+ *
+ * @pass_thresh:
+ *               Packets will begin slowly dropping when there are less than
+ *               this many packet buffers free in FPA 0.
+ * @drop_thresh:
+ *               All incomming packets will be dropped when there are less
+ *               than this many free packet buffers in FPA 0.
+ * Returns Zero on success. Negative on failure
+ */
+int cvmx_helper_setup_red(int pass_thresh, int drop_thresh)
+{
+	cvmx_ipd_portx_bp_page_cnt_t page_cnt;
+	cvmx_ipd_bp_prt_red_end_t ipd_bp_prt_red_end;
+	cvmx_ipd_red_port_enable_t red_port_enable;
+	int queue;
+	int interface;
+	int port;
+
+	/* Disable backpressure based on queued buffers. It needs SW support */
+	page_cnt.u64 = 0;
+	page_cnt.s.bp_enb = 0;
+	page_cnt.s.page_cnt = 100;
+	for (interface = 0; interface < 2; interface++) {
+		for (port = cvmx_helper_get_first_ipd_port(interface);
+		     port < cvmx_helper_get_last_ipd_port(interface); port++)
+			cvmx_write_csr(CVMX_IPD_PORTX_BP_PAGE_CNT(port),
+				       page_cnt.u64);
+	}
+
+	for (queue = 0; queue < 8; queue++)
+		cvmx_helper_setup_red_queue(queue, pass_thresh, drop_thresh);
+
+	/* Shutoff the dropping based on the per port page count. SW isn't
+	   decrementing it right now */
+	ipd_bp_prt_red_end.u64 = 0;
+	ipd_bp_prt_red_end.s.prt_enb = 0;
+	cvmx_write_csr(CVMX_IPD_BP_PRT_RED_END, ipd_bp_prt_red_end.u64);
+
+	red_port_enable.u64 = 0;
+	red_port_enable.s.prt_enb = 0xfffffffffull;
+	red_port_enable.s.avg_dly = 10000;
+	red_port_enable.s.prb_dly = 10000;
+	cvmx_write_csr(CVMX_IPD_RED_PORT_ENABLE, red_port_enable.u64);
+
+	return 0;
+}
+
+/**
+ * Setup the common GMX settings that determine the number of
+ * ports. These setting apply to almost all configurations of all
+ * chips.
+ *
+ * @interface: Interface to configure
+ * @num_ports: Number of ports on the interface
+ *
+ * Returns Zero on success, negative on failure
+ */
+int __cvmx_helper_setup_gmx(int interface, int num_ports)
+{
+	cvmx_gmxx_tx_prts_t gmx_tx_prts;
+	cvmx_gmxx_rx_prts_t gmx_rx_prts;
+	cvmx_pko_reg_gmx_port_mode_t pko_mode;
+
+	/* Tell GMX the number of TX ports on this interface */
+	gmx_tx_prts.u64 = cvmx_read_csr(CVMX_GMXX_TX_PRTS(interface));
+	gmx_tx_prts.s.prts = num_ports;
+	cvmx_write_csr(CVMX_GMXX_TX_PRTS(interface), gmx_tx_prts.u64);
+
+	/*
+	 * Tell GMX the number of RX ports on this interface.  This only
+	 * applies to *GMII and XAUI ports.
+	 */
+	if (cvmx_helper_interface_get_mode(interface) ==
+	    CVMX_HELPER_INTERFACE_MODE_RGMII
+	    || cvmx_helper_interface_get_mode(interface) ==
+	    CVMX_HELPER_INTERFACE_MODE_SGMII
+	    || cvmx_helper_interface_get_mode(interface) ==
+	    CVMX_HELPER_INTERFACE_MODE_GMII
+	    || cvmx_helper_interface_get_mode(interface) ==
+	    CVMX_HELPER_INTERFACE_MODE_XAUI) {
+		if (num_ports > 4) {
+			cvmx_dprintf("__cvmx_helper_setup_gmx: "
+				     "Illegal num_ports\n");
+			return -1;
+		}
+
+		gmx_rx_prts.u64 = cvmx_read_csr(CVMX_GMXX_RX_PRTS(interface));
+		gmx_rx_prts.s.prts = num_ports;
+		cvmx_write_csr(CVMX_GMXX_RX_PRTS(interface), gmx_rx_prts.u64);
+	}
+
+	/* Skip setting CVMX_PKO_REG_GMX_PORT_MODE on 30XX and 31XX */
+	if (OCTEON_IS_MODEL(OCTEON_CN30XX) || OCTEON_IS_MODEL(OCTEON_CN31XX)
+	    || OCTEON_IS_MODEL(OCTEON_CN50XX))
+		return 0;
+
+	/* Tell PKO the number of ports on this interface */
+	pko_mode.u64 = cvmx_read_csr(CVMX_PKO_REG_GMX_PORT_MODE);
+	if (interface == 0) {
+		if (num_ports == 1)
+			pko_mode.s.mode0 = 4;
+		else if (num_ports == 2)
+			pko_mode.s.mode0 = 3;
+		else if (num_ports <= 4)
+			pko_mode.s.mode0 = 2;
+		else if (num_ports <= 8)
+			pko_mode.s.mode0 = 1;
+		else
+			pko_mode.s.mode0 = 0;
+	} else {
+		if (num_ports == 1)
+			pko_mode.s.mode1 = 4;
+		else if (num_ports == 2)
+			pko_mode.s.mode1 = 3;
+		else if (num_ports <= 4)
+			pko_mode.s.mode1 = 2;
+		else if (num_ports <= 8)
+			pko_mode.s.mode1 = 1;
+		else
+			pko_mode.s.mode1 = 0;
+	}
+	cvmx_write_csr(CVMX_PKO_REG_GMX_PORT_MODE, pko_mode.u64);
+	return 0;
+}
+
+/**
+ * Returns the IPD/PKO port number for a port on the given
+ * interface.
+ *
+ * @interface: Interface to use
+ * @port:      Port on the interface
+ *
+ * Returns IPD/PKO port number
+ */
+int cvmx_helper_get_ipd_port(int interface, int port)
+{
+	switch (interface) {
+	case 0:
+		return port;
+	case 1:
+		return port + 16;
+	case 2:
+		return port + 32;
+	case 3:
+		return port + 36;
+	}
+	return -1;
+}
+
+#endif /* CVMX_ENABLE_HELPER_FUNCTIONS */
+
+/**
+ * Returns the interface number for an IPD/PKO port number.
+ *
+ * @ipd_port: IPD/PKO port number
+ *
+ * Returns Interface number
+ */
+int cvmx_helper_get_interface_num(int ipd_port)
+{
+	if (ipd_port < 16)
+		return 0;
+	else if (ipd_port < 32)
+		return 1;
+	else if (ipd_port < 36)
+		return 2;
+	else if (ipd_port < 40)
+		return 3;
+	else
+		cvmx_dprintf("cvmx_helper_get_interface_num: "
+			     "Illegal IPD port number\n");
+
+	return -1;
+}
+
+/**
+ * Returns the interface index number for an IPD/PKO port
+ * number.
+ *
+ * @ipd_port: IPD/PKO port number
+ *
+ * Returns Interface index number
+ */
+int cvmx_helper_get_interface_index_num(int ipd_port)
+{
+	if (ipd_port < 32)
+		return ipd_port & 15;
+	else if (ipd_port < 36)
+		return ipd_port & 3;
+	else if (ipd_port < 40)
+		return ipd_port & 3;
+	else
+		cvmx_dprintf("cvmx_helper_get_interface_index_num: "
+			     "Illegal IPD port number\n");
+
+	return -1;
+}
+
+/**
+ * Initialize the internal QLM JTAG logic to allow programming
+ * of the JTAG chain by the cvmx_helper_qlm_jtag_*() functions.
+ * These functions should only be used at the direction of Cavium
+ * Networks. Programming incorrect values into the JTAG chain
+ * can cause chip damage.
+ */
+void cvmx_helper_qlm_jtag_init(void)
+{
+	union cvmx_ciu_qlm_jtgc jtgc;
+	int clock_div = 0;
+	int divisor = cvmx_sysinfo_get()->cpu_clock_hz / (25 * 1000000);
+	divisor = (divisor - 1) >> 2;
+	/* Convert the divisor into a power of 2 shift */
+	CVMX_CLZ(clock_div, divisor);
+	clock_div = 32 - clock_div;
+
+	/*
+	 * Clock divider for QLM JTAG operations.  eclk is divided by
+	 * 2^(CLK_DIV + 2).
+	 */
+	jtgc.u64 = 0;
+	jtgc.s.clk_div = clock_div;
+	jtgc.s.mux_sel = 0;
+	if (OCTEON_IS_MODEL(OCTEON_CN52XX))
+		jtgc.s.bypass = 0x3;
+	else
+		jtgc.s.bypass = 0xf;
+	cvmx_write_csr(CVMX_CIU_QLM_JTGC, jtgc.u64);
+	cvmx_read_csr(CVMX_CIU_QLM_JTGC);
+}
+
+/**
+ * Write up to 32bits into the QLM jtag chain. Bits are shifted
+ * into the MSB and out the LSB, so you should shift in the low
+ * order bits followed by the high order bits. The JTAG chain is
+ * 4 * 268 bits long, or 1072.
+ *
+ * @qlm:    QLM to shift value into
+ * @bits:   Number of bits to shift in (1-32).
+ * @data:   Data to shift in. Bit 0 enters the chain first, followed by
+ *               bit 1, etc.
+ *
+ * Returns The low order bits of the JTAG chain that shifted out of the
+ *         circle.
+ */
+uint32_t cvmx_helper_qlm_jtag_shift(int qlm, int bits, uint32_t data)
+{
+	union cvmx_ciu_qlm_jtgd jtgd;
+	jtgd.u64 = 0;
+	jtgd.s.shift = 1;
+	jtgd.s.shft_cnt = bits - 1;
+	jtgd.s.shft_reg = data;
+	if (!OCTEON_IS_MODEL(OCTEON_CN56XX_PASS1_X))
+		jtgd.s.select = 1 << qlm;
+	cvmx_write_csr(CVMX_CIU_QLM_JTGD, jtgd.u64);
+	do {
+		jtgd.u64 = cvmx_read_csr(CVMX_CIU_QLM_JTGD);
+	} while (jtgd.s.shift);
+	return jtgd.s.shft_reg >> (32 - bits);
+}
+
+/**
+ * Shift long sequences of zeros into the QLM JTAG chain. It is
+ * common to need to shift more than 32 bits of zeros into the
+ * chain. This function is a convience wrapper around
+ * cvmx_helper_qlm_jtag_shift() to shift more than 32 bits of
+ * zeros at a time.
+ *
+ * @qlm:    QLM to shift zeros into
+ * @bits:
+ */
+void cvmx_helper_qlm_jtag_shift_zeros(int qlm, int bits)
+{
+	while (bits > 0) {
+		int n = bits;
+		if (n > 32)
+			n = 32;
+		cvmx_helper_qlm_jtag_shift(qlm, n, 0);
+		bits -= n;
+	}
+}
+
+/**
+ * Program the QLM JTAG chain into all lanes of the QLM. You must
+ * have already shifted in 268*4, or 1072 bits into the JTAG
+ * chain. Updating invalid values can possibly cause chip damage.
+ *
+ * @qlm:    QLM to program
+ */
+void cvmx_helper_qlm_jtag_update(int qlm)
+{
+	union cvmx_ciu_qlm_jtgd jtgd;
+
+	/* Update the new data */
+	jtgd.u64 = 0;
+	jtgd.s.update = 1;
+	if (!OCTEON_IS_MODEL(OCTEON_CN56XX_PASS1_X))
+		jtgd.s.select = 1 << qlm;
+	cvmx_write_csr(CVMX_CIU_QLM_JTGD, jtgd.u64);
+	do {
+		jtgd.u64 = cvmx_read_csr(CVMX_CIU_QLM_JTGD);
+	} while (jtgd.s.update);
+}
diff --git a/arch/mips/cavium-octeon/executive/cvmx-pcie.c b/arch/mips/cavium-octeon/executive/cvmx-pcie.c
new file mode 100644
index 0000000..710f21f
--- /dev/null
+++ b/arch/mips/cavium-octeon/executive/cvmx-pcie.c
@@ -0,0 +1,1053 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/**
+ *
+ * Interface to PCIe as a host(RC) or target(EP)
+ *
+ */
+#include <linux/delay.h>
+#include <linux/byteorder.h>
+
+#include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-npei-defs.h>
+#include <asm/octeon/cvmx-pciercx-defs.h>
+#include <asm/octeon/cvmx-pescx-defs.h>
+#include <asm/octeon/cvmx-pexp-defs.h>
+#include <asm/octeon/cvmx-pcieep-defs.h>
+#include <asm/octeon/cvmx-helper-errata.h>
+#include <asm/octeon/cvmx-pcie.h>
+
+/**
+ * Return the Core virtual base address for PCIe IO access. IOs are
+ * read/written as an offset from this address.
+ *
+ * @pcie_port: PCIe port the IO is for
+ *
+ * Returns 64bit Octeon IO base address for read/write
+ */
+uint64_t cvmx_pcie_get_io_base_address(int pcie_port)
+{
+	union cvmx_pcie_address pcie_addr;
+	pcie_addr.u64 = 0;
+	pcie_addr.io.upper = 0;
+	pcie_addr.io.io = 1;
+	pcie_addr.io.did = 3;
+	pcie_addr.io.subdid = 2;
+	pcie_addr.io.es = 1;
+	pcie_addr.io.port = pcie_port;
+	return pcie_addr.u64;
+}
+
+/**
+ * Size of the IO address region returned at address
+ * cvmx_pcie_get_io_base_address()
+ *
+ * @pcie_port: PCIe port the IO is for
+ *
+ * Returns Size of the IO window
+ */
+uint64_t cvmx_pcie_get_io_size(int pcie_port)
+{
+	return 1ull << 32;
+}
+
+/**
+ * Return the Core virtual base address for PCIe MEM access. Memory is
+ * read/written as an offset from this address.
+ *
+ * @pcie_port: PCIe port the IO is for
+ *
+ * Returns 64bit Octeon IO base address for read/write
+ */
+uint64_t cvmx_pcie_get_mem_base_address(int pcie_port)
+{
+	union cvmx_pcie_address pcie_addr;
+	pcie_addr.u64 = 0;
+	pcie_addr.mem.upper = 0;
+	pcie_addr.mem.io = 1;
+	pcie_addr.mem.did = 3;
+	pcie_addr.mem.subdid = 3 + pcie_port;
+	return pcie_addr.u64;
+}
+
+/**
+ * Size of the Mem address region returned at address
+ * cvmx_pcie_get_mem_base_address()
+ *
+ * @pcie_port: PCIe port the IO is for
+ *
+ * Returns Size of the Mem window
+ */
+uint64_t cvmx_pcie_get_mem_size(int pcie_port)
+{
+	return 1ull << 36;
+}
+
+/**
+ * Initialize the RC config space CSRs
+ *
+ * @pcie_port: PCIe port to initialize
+ */
+static void __cvmx_pcie_rc_initialize_config_space(int pcie_port)
+{
+	union cvmx_pciercx_cfg030 pciercx_cfg030;
+	union cvmx_npei_ctl_status2 npei_ctl_status2;
+	union cvmx_pciercx_cfg070 pciercx_cfg070;
+	union cvmx_pciercx_cfg001 pciercx_cfg001;
+	union cvmx_pciercx_cfg032 pciercx_cfg032;
+	union cvmx_pciercx_cfg006 pciercx_cfg006;
+	union cvmx_pciercx_cfg008 pciercx_cfg008;
+	union cvmx_pciercx_cfg009 pciercx_cfg009;
+	union cvmx_pciercx_cfg010 pciercx_cfg010;
+	union cvmx_pciercx_cfg011 pciercx_cfg011;
+	union cvmx_pciercx_cfg035 pciercx_cfg035;
+	union cvmx_pciercx_cfg075 pciercx_cfg075;
+	union cvmx_pciercx_cfg034 pciercx_cfg034;
+
+	/* Max Payload Size (PCIE*_CFG030[MPS]) */
+	/* Max Read Request Size (PCIE*_CFG030[MRRS]) */
+	/* Relaxed-order, no-snoop enables (PCIE*_CFG030[RO_EN,NS_EN] */
+	/* Error Message Enables (PCIE*_CFG030[CE_EN,NFE_EN,FE_EN,UR_EN]) */
+	pciercx_cfg030.u32 =
+		cvmx_pcie_cfgx_read(pcie_port, CVMX_PCIERCX_CFG030(pcie_port));
+	/*
+	 * Max payload size = 128 bytes for best Octeon DMA
+	 * performance.
+	 */
+	pciercx_cfg030.s.mps = 0;
+	/*
+	 * Max read request size = 128 bytes for best Octeon DMA
+	 * performance.
+	 */
+	pciercx_cfg030.s.mrrs = 0;
+	/* Enable relaxed ordering. */
+	pciercx_cfg030.s.ro_en = 1;
+	/* Enable no snoop. */
+	pciercx_cfg030.s.ns_en = 1;
+	/* Correctable error reporting enable. */
+	pciercx_cfg030.s.ce_en = 1;
+	/* Non-fatal error reporting enable. */
+	pciercx_cfg030.s.nfe_en = 1;
+	/* Fatal error reporting enable. */
+	pciercx_cfg030.s.fe_en = 1;
+	/* Unsupported request reporting enable. */
+	pciercx_cfg030.s.ur_en = 1;
+	cvmx_pcie_cfgx_write(pcie_port, CVMX_PCIERCX_CFG030(pcie_port),
+			     pciercx_cfg030.u32);
+
+	/*
+	 * Max Payload Size (NPEI_CTL_STATUS2[MPS]) must match
+	 * PCIE*_CFG030[MPS]
+	 *
+	 * Max Read Request Size (NPEI_CTL_STATUS2[MRRS]) must not
+	 * exceed PCIE*_CFG030[MRRS].
+	 */
+	npei_ctl_status2.u64 = cvmx_read_csr(CVMX_PEXP_NPEI_CTL_STATUS2);
+	/* Max payload size = 128 bytes for best Octeon DMA performance */
+	npei_ctl_status2.s.mps = 0;
+	/* Max read request size = 128 bytes for best Octeon DMA performance */
+	npei_ctl_status2.s.mrrs = 0;
+	cvmx_write_csr(CVMX_PEXP_NPEI_CTL_STATUS2, npei_ctl_status2.u64);
+
+	/* ECRC Generation (PCIE*_CFG070[GE,CE]) */
+	pciercx_cfg070.u32 =
+		cvmx_pcie_cfgx_read(pcie_port, CVMX_PCIERCX_CFG070(pcie_port));
+	pciercx_cfg070.s.ge = 1;	/* ECRC generation enable. */
+	pciercx_cfg070.s.ce = 1;	/* ECRC check enable. */
+	cvmx_pcie_cfgx_write(pcie_port, CVMX_PCIERCX_CFG070(pcie_port),
+			     pciercx_cfg070.u32);
+
+	/*
+	 * Access Enables (PCIE*_CFG001[MSAE,ME]) ME and MSAE should
+	 * always be set.
+	 *
+	 * Interrupt Disable (PCIE*_CFG001[I_DIS]) System Error
+	 * Message Enable (PCIE*_CFG001[SEE])
+	 */
+	pciercx_cfg001.u32 =
+		cvmx_pcie_cfgx_read(pcie_port, CVMX_PCIERCX_CFG001(pcie_port));
+	pciercx_cfg001.s.msae = 1;	/* Memory space enable. */
+	pciercx_cfg001.s.me = 1;	/* Bus master enable. */
+	pciercx_cfg001.s.i_dis = 1;	/* INTx assertion disable. */
+	pciercx_cfg001.s.see = 1;	/* SERR# enable */
+	cvmx_pcie_cfgx_write(pcie_port, CVMX_PCIERCX_CFG001(pcie_port),
+			pciercx_cfg001.u32);
+
+	/* Advanced Error Recovery Message Enables */
+	/* (PCIE*_CFG066,PCIE*_CFG067,PCIE*_CFG069) */
+	cvmx_pcie_cfgx_write(pcie_port, CVMX_PCIERCX_CFG066(pcie_port), 0);
+	/* Use CVMX_PCIERCX_CFG067 hardware default */
+	cvmx_pcie_cfgx_write(pcie_port, CVMX_PCIERCX_CFG069(pcie_port), 0);
+
+	/* Active State Power Management (PCIE*_CFG032[ASLPC]) */
+	pciercx_cfg032.u32 =
+		cvmx_pcie_cfgx_read(pcie_port, CVMX_PCIERCX_CFG032(pcie_port));
+	pciercx_cfg032.s.aslpc = 0;	/* Active state Link PM control. */
+	cvmx_pcie_cfgx_write(pcie_port, CVMX_PCIERCX_CFG032(pcie_port),
+			     pciercx_cfg032.u32);
+
+	/* Entrance Latencies (PCIE*_CFG451[L0EL,L1EL]) */
+
+	/*
+	 * Link Width Mode (PCIERCn_CFG452[LME]) - Set during
+	 * cvmx_pcie_rc_initialize_link()
+	 *
+	 * Primary Bus Number (PCIERCn_CFG006[PBNUM])
+	 *
+	 * We set the primary bus number to 1 so IDT bridges are
+	 * happy. They don't like zero.
+	 */
+	pciercx_cfg006.u32 = 0;
+	pciercx_cfg006.s.pbnum = 1;
+	pciercx_cfg006.s.sbnum = 1;
+	pciercx_cfg006.s.subbnum = 1;
+	cvmx_pcie_cfgx_write(pcie_port, CVMX_PCIERCX_CFG006(pcie_port),
+			     pciercx_cfg006.u32);
+
+	/*
+	 * Memory-mapped I/O BAR (PCIERCn_CFG008)
+	 * Most applications should disable the memory-mapped I/O BAR by
+	 * setting PCIERCn_CFG008[ML_ADDR] < PCIERCn_CFG008[MB_ADDR]
+	 */
+	pciercx_cfg008.u32 = 0;
+	pciercx_cfg008.s.mb_addr = 0x100;
+	pciercx_cfg008.s.ml_addr = 0;
+	cvmx_pcie_cfgx_write(pcie_port, CVMX_PCIERCX_CFG008(pcie_port),
+			     pciercx_cfg008.u32);
+
+	/*
+	 * Prefetchable BAR (PCIERCn_CFG009,PCIERCn_CFG010,PCIERCn_CFG011)
+	 * Most applications should disable the prefetchable BAR by setting
+	 * PCIERCn_CFG011[UMEM_LIMIT],PCIERCn_CFG009[LMEM_LIMIT] <
+	 * PCIERCn_CFG010[UMEM_BASE],PCIERCn_CFG009[LMEM_BASE]
+	 */
+	pciercx_cfg009.u32 =
+		cvmx_pcie_cfgx_read(pcie_port, CVMX_PCIERCX_CFG009(pcie_port));
+	pciercx_cfg010.u32 =
+		cvmx_pcie_cfgx_read(pcie_port, CVMX_PCIERCX_CFG010(pcie_port));
+	pciercx_cfg011.u32 =
+		cvmx_pcie_cfgx_read(pcie_port, CVMX_PCIERCX_CFG011(pcie_port));
+	pciercx_cfg009.s.lmem_base = 0x100;
+	pciercx_cfg009.s.lmem_limit = 0;
+	pciercx_cfg010.s.umem_base = 0x100;
+	pciercx_cfg011.s.umem_limit = 0;
+	cvmx_pcie_cfgx_write(pcie_port, CVMX_PCIERCX_CFG009(pcie_port),
+			     pciercx_cfg009.u32);
+	cvmx_pcie_cfgx_write(pcie_port, CVMX_PCIERCX_CFG010(pcie_port),
+			     pciercx_cfg010.u32);
+	cvmx_pcie_cfgx_write(pcie_port, CVMX_PCIERCX_CFG011(pcie_port),
+			     pciercx_cfg011.u32);
+
+	/*
+	 * System Error Interrupt Enables (PCIERCn_CFG035[SECEE,SEFEE,SENFEE])
+	 * PME Interrupt Enables (PCIERCn_CFG035[PMEIE])
+	 */
+	pciercx_cfg035.u32 =
+		cvmx_pcie_cfgx_read(pcie_port, CVMX_PCIERCX_CFG035(pcie_port));
+	/* System error on correctable error enable. */
+	pciercx_cfg035.s.secee = 1;
+	/* System error on fatal error enable. */
+	pciercx_cfg035.s.sefee = 1;
+	/* System error on non-fatal error enable. */
+	pciercx_cfg035.s.senfee = 1;
+	/* PME interrupt enable. */
+	pciercx_cfg035.s.pmeie = 1;
+	cvmx_pcie_cfgx_write(pcie_port, CVMX_PCIERCX_CFG035(pcie_port),
+			     pciercx_cfg035.u32);
+
+	/*
+	 * Advanced Error Recovery Interrupt Enables
+	 * (PCIERCn_CFG075[CERE,NFERE,FERE])
+	 */
+	pciercx_cfg075.u32 =
+		cvmx_pcie_cfgx_read(pcie_port, CVMX_PCIERCX_CFG075(pcie_port));
+	/* Correctable error reporting enable. */
+	pciercx_cfg075.s.cere = 1;
+	/* Non-fatal error reporting enable. */
+	pciercx_cfg075.s.nfere = 1;
+	/* Fatal error reporting enable. */
+	pciercx_cfg075.s.fere = 1;
+	cvmx_pcie_cfgx_write(pcie_port, CVMX_PCIERCX_CFG075(pcie_port),
+			     pciercx_cfg075.u32);
+
+	/* HP Interrupt Enables (PCIERCn_CFG034[HPINT_EN],
+	 * PCIERCn_CFG034[DLLS_EN,CCINT_EN])
+	 */
+	pciercx_cfg034.u32 =
+		cvmx_pcie_cfgx_read(pcie_port, CVMX_PCIERCX_CFG034(pcie_port));
+	/* Hot-plug interrupt enable. */
+	pciercx_cfg034.s.hpint_en = 1;
+	/* Data Link Layer state changed enable */
+	pciercx_cfg034.s.dlls_en = 1;
+	/* Command completed interrupt enable. */
+	pciercx_cfg034.s.ccint_en = 1;
+	cvmx_pcie_cfgx_write(pcie_port, CVMX_PCIERCX_CFG034(pcie_port),
+			     pciercx_cfg034.u32);
+}
+
+/**
+ * Initialize a host mode PCIe link. This function takes a PCIe
+ * port from reset to a link up state. Software can then begin
+ * configuring the rest of the link.
+ *
+ * @pcie_port: PCIe port to initialize
+ *
+ * Returns Zero on success
+ */
+static int __cvmx_pcie_rc_initialize_link(int pcie_port)
+{
+	uint64_t start_cycle;
+	union cvmx_pescx_ctl_status pescx_ctl_status;
+	union cvmx_pciercx_cfg452 pciercx_cfg452;
+	union cvmx_pciercx_cfg032 pciercx_cfg032;
+	union cvmx_pciercx_cfg448 pciercx_cfg448;
+
+	/* Set the lane width */
+	pciercx_cfg452.u32 =
+	    cvmx_pcie_cfgx_read(pcie_port, CVMX_PCIERCX_CFG452(pcie_port));
+	pescx_ctl_status.u64 = cvmx_read_csr(CVMX_PESCX_CTL_STATUS(pcie_port));
+	if (pescx_ctl_status.s.qlm_cfg == 0) {
+		/* We're in 8 lane (56XX) or 4 lane (54XX) mode */
+		pciercx_cfg452.s.lme = 0xf;
+	} else {
+		/* We're in 4 lane (56XX) or 2 lane (52XX) mode */
+		pciercx_cfg452.s.lme = 0x7;
+	}
+	cvmx_pcie_cfgx_write(pcie_port, CVMX_PCIERCX_CFG452(pcie_port),
+			     pciercx_cfg452.u32);
+
+	/*
+	 * CN52XX pass 1.x has an errata where length mismatches on UR
+	 * responses can cause bus errors on 64bit memory
+	 * reads. Turning off length error checking fixes this.
+	 */
+	if (OCTEON_IS_MODEL(OCTEON_CN52XX_PASS1_X)) {
+		union cvmx_pciercx_cfg455 pciercx_cfg455;
+		pciercx_cfg455.u32 =
+		    cvmx_pcie_cfgx_read(pcie_port,
+					CVMX_PCIERCX_CFG455(pcie_port));
+		pciercx_cfg455.s.m_cpl_len_err = 1;
+		cvmx_pcie_cfgx_write(pcie_port, CVMX_PCIERCX_CFG455(pcie_port),
+				     pciercx_cfg455.u32);
+	}
+
+	/* Lane swap needs to be manually enabled for CN52XX */
+	if (OCTEON_IS_MODEL(OCTEON_CN52XX) && (pcie_port == 1)) {
+		pescx_ctl_status.s.lane_swp = 1;
+		cvmx_write_csr(CVMX_PESCX_CTL_STATUS(pcie_port),
+			       pescx_ctl_status.u64);
+	}
+
+	/* Bring up the link */
+	pescx_ctl_status.u64 = cvmx_read_csr(CVMX_PESCX_CTL_STATUS(pcie_port));
+	pescx_ctl_status.s.lnk_enb = 1;
+	cvmx_write_csr(CVMX_PESCX_CTL_STATUS(pcie_port), pescx_ctl_status.u64);
+
+	/*
+	 * CN52XX pass 1.0: Due to a bug in 2nd order CDR, it needs to
+	 * be disabled.
+	 */
+	if (OCTEON_IS_MODEL(OCTEON_CN52XX_PASS1_0))
+		__cvmx_helper_errata_qlm_disable_2nd_order_cdr(0);
+
+	/* Wait for the link to come up */
+	cvmx_dprintf("PCIe: Waiting for port %d link\n", pcie_port);
+	start_cycle = cvmx_get_cycle();
+	do {
+		if (cvmx_get_cycle() - start_cycle >
+		    2 * cvmx_sysinfo_get()->cpu_clock_hz) {
+			cvmx_dprintf("PCIe: Port %d link timeout\n",
+				     pcie_port);
+			return -1;
+		}
+		cvmx_wait(10000);
+		pciercx_cfg032.u32 =
+		    cvmx_pcie_cfgx_read(pcie_port,
+					CVMX_PCIERCX_CFG032(pcie_port));
+	} while (pciercx_cfg032.s.dlla == 0);
+
+	/* Display the link status */
+	cvmx_dprintf("PCIe: Port %d link active, %d lanes\n", pcie_port,
+		     pciercx_cfg032.s.nlw);
+
+	/*
+	 * Update the Replay Time Limit. Empirically, some PCIe
+	 * devices take a little longer to respond than expected under
+	 * load. As a workaround for this we configure the Replay Time
+	 * Limit to the value expected for a 512 byte MPS instead of
+	 * our actual 256 byte MPS. The numbers below are directly
+	 * from the PCIe spec table 3-4.
+	 */
+	pciercx_cfg448.u32 =
+	    cvmx_pcie_cfgx_read(pcie_port, CVMX_PCIERCX_CFG448(pcie_port));
+	switch (pciercx_cfg032.s.nlw) {
+	case 1:		/* 1 lane */
+		pciercx_cfg448.s.rtl = 1677;
+		break;
+	case 2:		/* 2 lanes */
+		pciercx_cfg448.s.rtl = 867;
+		break;
+	case 4:		/* 4 lanes */
+		pciercx_cfg448.s.rtl = 462;
+		break;
+	case 8:		/* 8 lanes */
+		pciercx_cfg448.s.rtl = 258;
+		break;
+	}
+	cvmx_pcie_cfgx_write(pcie_port, CVMX_PCIERCX_CFG448(pcie_port),
+			     pciercx_cfg448.u32);
+
+	return 0;
+}
+
+/**
+ * Initialize a PCIe port for use in host(RC) mode. It doesn't
+ * enumerate the bus.
+ *
+ * @pcie_port: PCIe port to initialize
+ *
+ * Returns Zero on success
+ */
+int cvmx_pcie_rc_initialize(int pcie_port)
+{
+	int i;
+	union cvmx_ciu_soft_prst ciu_soft_prst;
+	union cvmx_pescx_bist_status pescx_bist_status;
+	union cvmx_pescx_bist_status2 pescx_bist_status2;
+	union cvmx_npei_ctl_status npei_ctl_status;
+	union cvmx_npei_mem_access_ctl npei_mem_access_ctl;
+	union cvmx_npei_mem_access_subidx mem_access_subid;
+	union cvmx_npei_dbg_data npei_dbg_data;
+	union cvmx_pescx_ctl_status2 pescx_ctl_status2;
+
+	/*
+	 * Make sure we aren't trying to setup a target mode interface
+	 * in host mode.
+	 */
+	npei_ctl_status.u64 = cvmx_read_csr(CVMX_PEXP_NPEI_CTL_STATUS);
+	if ((pcie_port == 0) && !npei_ctl_status.s.host_mode) {
+		cvmx_dprintf("PCIe: ERROR: cvmx_pcie_rc_initialize() called "
+			     "on port0, but port0 is not in host mode\n");
+		return -1;
+	}
+
+	/*
+	 * Make sure a CN52XX isn't trying to bring up port 1 when it
+	 * is disabled.
+	 */
+	if (OCTEON_IS_MODEL(OCTEON_CN52XX)) {
+		npei_dbg_data.u64 = cvmx_read_csr(CVMX_PEXP_NPEI_DBG_DATA);
+		if ((pcie_port == 1) && npei_dbg_data.cn52xx.qlm0_link_width) {
+			cvmx_dprintf("PCIe: ERROR: cvmx_pcie_rc_initialize() "
+				     "called on port1, but port1 is disabled\n");
+			return -1;
+		}
+	}
+
+	/*
+	 * PCIe switch arbitration mode. '0' == fixed priority NPEI,
+	 * PCIe0, then PCIe1. '1' == round robin.
+	 */
+	npei_ctl_status.s.arb = 1;
+	/* Allow up to 0x20 config retries */
+	npei_ctl_status.s.cfg_rtry = 0x20;
+	/*
+	 * CN52XX pass1.x has an errata where P0_NTAGS and P1_NTAGS
+	 * don't reset.
+	 */
+	if (OCTEON_IS_MODEL(OCTEON_CN52XX_PASS1_X)) {
+		npei_ctl_status.s.p0_ntags = 0x20;
+		npei_ctl_status.s.p1_ntags = 0x20;
+	}
+	cvmx_write_csr(CVMX_PEXP_NPEI_CTL_STATUS, npei_ctl_status.u64);
+
+	/* Bring the PCIe out of reset */
+	if (cvmx_sysinfo_get()->board_type == CVMX_BOARD_TYPE_EBH5200) {
+		/*
+		 * The EBH5200 board swapped the PCIe reset lines on
+		 * the board. As a workaround for this bug, we bring
+		 * both PCIe ports out of reset at the same time
+		 * instead of on separate calls. So for port 0, we
+		 * bring both out of reset and do nothing on port 1.
+		 */
+		if (pcie_port == 0) {
+			ciu_soft_prst.u64 = cvmx_read_csr(CVMX_CIU_SOFT_PRST);
+			/*
+			 * After a chip reset the PCIe will also be in
+			 * reset. If it isn't, most likely someone is
+			 * trying to init it again without a proper
+			 * PCIe reset.
+			 */
+			if (ciu_soft_prst.s.soft_prst == 0) {
+				/* Reset the ports */
+				ciu_soft_prst.s.soft_prst = 1;
+				cvmx_write_csr(CVMX_CIU_SOFT_PRST,
+					       ciu_soft_prst.u64);
+				ciu_soft_prst.u64 =
+				    cvmx_read_csr(CVMX_CIU_SOFT_PRST1);
+				ciu_soft_prst.s.soft_prst = 1;
+				cvmx_write_csr(CVMX_CIU_SOFT_PRST1,
+					       ciu_soft_prst.u64);
+				/* Wait until pcie resets the ports. */
+				udelay(2000);
+			}
+			ciu_soft_prst.u64 = cvmx_read_csr(CVMX_CIU_SOFT_PRST1);
+			ciu_soft_prst.s.soft_prst = 0;
+			cvmx_write_csr(CVMX_CIU_SOFT_PRST1, ciu_soft_prst.u64);
+			ciu_soft_prst.u64 = cvmx_read_csr(CVMX_CIU_SOFT_PRST);
+			ciu_soft_prst.s.soft_prst = 0;
+			cvmx_write_csr(CVMX_CIU_SOFT_PRST, ciu_soft_prst.u64);
+		}
+	} else {
+		/*
+		 * The normal case: The PCIe ports are completely
+		 * separate and can be brought out of reset
+		 * independently.
+		 */
+		if (pcie_port)
+			ciu_soft_prst.u64 = cvmx_read_csr(CVMX_CIU_SOFT_PRST1);
+		else
+			ciu_soft_prst.u64 = cvmx_read_csr(CVMX_CIU_SOFT_PRST);
+		/*
+		 * After a chip reset the PCIe will also be in
+		 * reset. If it isn't, most likely someone is trying
+		 * to init it again without a proper PCIe reset.
+		 */
+		if (ciu_soft_prst.s.soft_prst == 0) {
+			/* Reset the port */
+			ciu_soft_prst.s.soft_prst = 1;
+			if (pcie_port)
+				cvmx_write_csr(CVMX_CIU_SOFT_PRST1,
+					       ciu_soft_prst.u64);
+			else
+				cvmx_write_csr(CVMX_CIU_SOFT_PRST,
+					       ciu_soft_prst.u64);
+			/* Wait until pcie resets the ports. */
+			udelay(2000);
+		}
+		if (pcie_port) {
+			ciu_soft_prst.u64 = cvmx_read_csr(CVMX_CIU_SOFT_PRST1);
+			ciu_soft_prst.s.soft_prst = 0;
+			cvmx_write_csr(CVMX_CIU_SOFT_PRST1, ciu_soft_prst.u64);
+		} else {
+			ciu_soft_prst.u64 = cvmx_read_csr(CVMX_CIU_SOFT_PRST);
+			ciu_soft_prst.s.soft_prst = 0;
+			cvmx_write_csr(CVMX_CIU_SOFT_PRST, ciu_soft_prst.u64);
+		}
+	}
+
+	/*
+	 * Wait for PCIe reset to complete. Due to errata PCIE-700, we
+	 * don't poll PESCX_CTL_STATUS2[PCIERST], but simply wait a
+	 * fixed number of cycles.
+	 */
+	cvmx_wait(400000);
+
+	/* PESCX_BIST_STATUS2[PCLK_RUN] was missing on pass 1 of CN56XX and
+	   CN52XX, so we only probe it on newer chips */
+	if (!OCTEON_IS_MODEL(OCTEON_CN56XX_PASS1_X)
+	    && !OCTEON_IS_MODEL(OCTEON_CN52XX_PASS1_X)) {
+		/* Clear PCLK_RUN so we can check if the clock is running */
+		pescx_ctl_status2.u64 =
+		    cvmx_read_csr(CVMX_PESCX_CTL_STATUS2(pcie_port));
+		pescx_ctl_status2.s.pclk_run = 1;
+		cvmx_write_csr(CVMX_PESCX_CTL_STATUS2(pcie_port),
+			       pescx_ctl_status2.u64);
+		/*
+		 * Now that we cleared PCLK_RUN, wait for it to be set
+		 * again telling us the clock is running.
+		 */
+		if (CVMX_WAIT_FOR_FIELD64(CVMX_PESCX_CTL_STATUS2(pcie_port),
+					  union cvmx_pescx_ctl_status2,
+					  pclk_run, ==, 1, 10000)) {
+			cvmx_dprintf("PCIe: Port %d isn't clocked, skipping.\n",
+				     pcie_port);
+			return -1;
+		}
+	}
+
+	/*
+	 * Check and make sure PCIe came out of reset. If it doesn't
+	 * the board probably hasn't wired the clocks up and the
+	 * interface should be skipped.
+	 */
+	pescx_ctl_status2.u64 =
+	    cvmx_read_csr(CVMX_PESCX_CTL_STATUS2(pcie_port));
+	if (pescx_ctl_status2.s.pcierst) {
+		cvmx_dprintf("PCIe: Port %d stuck in reset, skipping.\n",
+			     pcie_port);
+		return -1;
+	}
+
+	/*
+	 * Check BIST2 status. If any bits are set skip this interface. This
+	 * is an attempt to catch PCIE-813 on pass 1 parts.
+	 */
+	pescx_bist_status2.u64 =
+	    cvmx_read_csr(CVMX_PESCX_BIST_STATUS2(pcie_port));
+	if (pescx_bist_status2.u64) {
+		cvmx_dprintf("PCIe: Port %d BIST2 failed. Most likely this "
+			     "port isn't hooked up, skipping.\n",
+			     pcie_port);
+		return -1;
+	}
+
+	/* Check BIST status */
+	pescx_bist_status.u64 =
+	    cvmx_read_csr(CVMX_PESCX_BIST_STATUS(pcie_port));
+	if (pescx_bist_status.u64)
+		cvmx_dprintf("PCIe: BIST FAILED for port %d (0x%016llx)\n",
+			     pcie_port, CAST64(pescx_bist_status.u64));
+
+	/* Initialize the config space CSRs */
+	__cvmx_pcie_rc_initialize_config_space(pcie_port);
+
+	/* Bring the link up */
+	if (__cvmx_pcie_rc_initialize_link(pcie_port)) {
+		cvmx_dprintf
+		    ("PCIe: ERROR: cvmx_pcie_rc_initialize_link() failed\n");
+		return -1;
+	}
+
+	/* Store merge control (NPEI_MEM_ACCESS_CTL[TIMER,MAX_WORD]) */
+	npei_mem_access_ctl.u64 = cvmx_read_csr(CVMX_PEXP_NPEI_MEM_ACCESS_CTL);
+	/* Allow 16 words to combine */
+	npei_mem_access_ctl.s.max_word = 0;
+	/* Wait up to 127 cycles for more data */
+	npei_mem_access_ctl.s.timer = 127;
+	cvmx_write_csr(CVMX_PEXP_NPEI_MEM_ACCESS_CTL, npei_mem_access_ctl.u64);
+
+	/* Setup Mem access SubDIDs */
+	mem_access_subid.u64 = 0;
+	/* Port the request is sent to. */
+	mem_access_subid.s.port = pcie_port;
+	/* Due to an errata on pass 1 chips, no merging is allowed. */
+	mem_access_subid.s.nmerge = 1;
+	/* Endian-swap for Reads. */
+	mem_access_subid.s.esr = 1;
+	/* Endian-swap for Writes. */
+	mem_access_subid.s.esw = 1;
+	/* No Snoop for Reads. */
+	mem_access_subid.s.nsr = 1;
+	/* No Snoop for Writes. */
+	mem_access_subid.s.nsw = 1;
+	/* Disable Relaxed Ordering for Reads. */
+	mem_access_subid.s.ror = 0;
+	/* Disable Relaxed Ordering for Writes. */
+	mem_access_subid.s.row = 0;
+	/* PCIe Adddress Bits <63:34>. */
+	mem_access_subid.s.ba = 0;
+
+	/*
+	 * Setup mem access 12-15 for port 0, 16-19 for port 1,
+	 * supplying 36 bits of address space.
+	 */
+	for (i = 12 + pcie_port * 4; i < 16 + pcie_port * 4; i++) {
+		cvmx_write_csr(CVMX_PEXP_NPEI_MEM_ACCESS_SUBIDX(i),
+			       mem_access_subid.u64);
+		/* Set each SUBID to extend the addressable range */
+		mem_access_subid.s.ba += 1;
+	}
+
+	/*
+	 * Disable the peer to peer forwarding register. This must be
+	 * setup by the OS after it enumerates the bus and assigns
+	 * addresses to the PCIe busses.
+	 */
+	for (i = 0; i < 4; i++) {
+		cvmx_write_csr(CVMX_PESCX_P2P_BARX_START(i, pcie_port), -1);
+		cvmx_write_csr(CVMX_PESCX_P2P_BARX_END(i, pcie_port), -1);
+	}
+
+	/* Set Octeon's BAR0 to decode 0-16KB. It overlaps with Bar2 */
+	cvmx_write_csr(CVMX_PESCX_P2N_BAR0_START(pcie_port), 0);
+
+	/*
+	 * Disable Octeon's BAR1. It isn't needed in RC mode since
+	 * BAR2 maps all of memory. BAR2 also maps 256MB-512MB into
+	 * the 2nd 256MB of memory.
+	 */
+	cvmx_write_csr(CVMX_PESCX_P2N_BAR1_START(pcie_port), -1);
+
+	/*
+	 * Set Octeon's BAR2 to decode 0-2^39. Bar0 and Bar1 take
+	 * precedence where they overlap. It also overlaps with the
+	 * device addresses, so make sure the peer to peer forwarding
+	 * is set right.
+	 */
+	cvmx_write_csr(CVMX_PESCX_P2N_BAR2_START(pcie_port), 0);
+
+	/*
+	 * Setup BAR2 attributes
+	 *
+	 * Relaxed Ordering (NPEI_CTL_PORTn[PTLP_RO,CTLP_RO, WAIT_COM])
+	 * - PTLP_RO,CTLP_RO should normally be set (except for debug).
+	 * - WAIT_COM=0 will likely work for all applications.
+	 *
+	 * Load completion relaxed ordering (NPEI_CTL_PORTn[WAITL_COM]).
+	 */
+	if (pcie_port) {
+		union cvmx_npei_ctl_port1 npei_ctl_port;
+		npei_ctl_port.u64 = cvmx_read_csr(CVMX_PEXP_NPEI_CTL_PORT1);
+		npei_ctl_port.s.bar2_enb = 1;
+		npei_ctl_port.s.bar2_esx = 1;
+		npei_ctl_port.s.bar2_cax = 0;
+		npei_ctl_port.s.ptlp_ro = 1;
+		npei_ctl_port.s.ctlp_ro = 1;
+		npei_ctl_port.s.wait_com = 0;
+		npei_ctl_port.s.waitl_com = 0;
+		cvmx_write_csr(CVMX_PEXP_NPEI_CTL_PORT1, npei_ctl_port.u64);
+	} else {
+		union cvmx_npei_ctl_port0 npei_ctl_port;
+		npei_ctl_port.u64 = cvmx_read_csr(CVMX_PEXP_NPEI_CTL_PORT0);
+		npei_ctl_port.s.bar2_enb = 1;
+		npei_ctl_port.s.bar2_esx = 1;
+		npei_ctl_port.s.bar2_cax = 0;
+		npei_ctl_port.s.ptlp_ro = 1;
+		npei_ctl_port.s.ctlp_ro = 1;
+		npei_ctl_port.s.wait_com = 0;
+		npei_ctl_port.s.waitl_com = 0;
+		cvmx_write_csr(CVMX_PEXP_NPEI_CTL_PORT0, npei_ctl_port.u64);
+	}
+	return 0;
+}
+
+/**
+ * Shutdown a PCIe port and put it in reset
+ *
+ * @pcie_port: PCIe port to shutdown
+ *
+ * Returns Zero on success
+ */
+int cvmx_pcie_rc_shutdown(int pcie_port)
+{
+	/* Wait for all pending operations to complete */
+	if (CVMX_WAIT_FOR_FIELD64(CVMX_PESCX_CPL_LUT_VALID(pcie_port),
+				  union cvmx_pescx_cpl_lut_valid,
+				  tag, ==, 0, 2000))
+		cvmx_dprintf("PCIe: Port %d shutdown timeout\n", pcie_port);
+
+	/* Force reset */
+	if (pcie_port) {
+		union cvmx_ciu_soft_prst ciu_soft_prst;
+		ciu_soft_prst.u64 = cvmx_read_csr(CVMX_CIU_SOFT_PRST1);
+		ciu_soft_prst.s.soft_prst = 1;
+		cvmx_write_csr(CVMX_CIU_SOFT_PRST1, ciu_soft_prst.u64);
+	} else {
+		union cvmx_ciu_soft_prst ciu_soft_prst;
+		ciu_soft_prst.u64 = cvmx_read_csr(CVMX_CIU_SOFT_PRST);
+		ciu_soft_prst.s.soft_prst = 1;
+		cvmx_write_csr(CVMX_CIU_SOFT_PRST, ciu_soft_prst.u64);
+	}
+	return 0;
+}
+
+/**
+ * Build a PCIe config space request address for a device
+ *
+ * @pcie_port: PCIe port to access
+ * @bus:       Sub bus
+ * @dev:       Device ID
+ * @fn:        Device sub function
+ * @reg:       Register to access
+ *
+ * Returns 64bit Octeon IO address
+ */
+static inline uint64_t __cvmx_pcie_build_config_addr(int pcie_port, int bus,
+						     int dev, int fn, int reg)
+{
+	union cvmx_pcie_address pcie_addr;
+	union cvmx_pciercx_cfg006 pciercx_cfg006;
+
+	pciercx_cfg006.u32 =
+	    cvmx_pcie_cfgx_read(pcie_port, CVMX_PCIERCX_CFG006(pcie_port));
+	if ((bus <= pciercx_cfg006.s.pbnum) && (dev != 0))
+		return 0;
+
+	pcie_addr.u64 = 0;
+	pcie_addr.config.upper = 2;
+	pcie_addr.config.io = 1;
+	pcie_addr.config.did = 3;
+	pcie_addr.config.subdid = 1;
+	pcie_addr.config.es = 1;
+	pcie_addr.config.port = pcie_port;
+	pcie_addr.config.ty = (bus > pciercx_cfg006.s.pbnum);
+	pcie_addr.config.bus = bus;
+	pcie_addr.config.dev = dev;
+	pcie_addr.config.func = fn;
+	pcie_addr.config.reg = reg;
+	return pcie_addr.u64;
+}
+
+/**
+ * Read 8bits from a Device's config space
+ *
+ * @pcie_port: PCIe port the device is on
+ * @bus:       Sub bus
+ * @dev:       Device ID
+ * @fn:        Device sub function
+ * @reg:       Register to access
+ *
+ * Returns Result of the read
+ */
+uint8_t cvmx_pcie_config_read8(int pcie_port, int bus, int dev,
+			       int fn, int reg)
+{
+	uint64_t address =
+	    __cvmx_pcie_build_config_addr(pcie_port, bus, dev, fn, reg);
+	if (address)
+		return cvmx_read64_uint8(address);
+	else
+		return 0xff;
+}
+
+/**
+ * Read 16bits from a Device's config space
+ *
+ * @pcie_port: PCIe port the device is on
+ * @bus:       Sub bus
+ * @dev:       Device ID
+ * @fn:        Device sub function
+ * @reg:       Register to access
+ *
+ * Returns Result of the read
+ */
+uint16_t cvmx_pcie_config_read16(int pcie_port, int bus, int dev, int fn,
+				 int reg)
+{
+	uint64_t address =
+	    __cvmx_pcie_build_config_addr(pcie_port, bus, dev, fn, reg);
+	if (address)
+		return le16_to_cpu(cvmx_read64_uint16(address));
+	else
+		return 0xffff;
+}
+
+/**
+ * Read 32bits from a Device's config space
+ *
+ * @pcie_port: PCIe port the device is on
+ * @bus:       Sub bus
+ * @dev:       Device ID
+ * @fn:        Device sub function
+ * @reg:       Register to access
+ *
+ * Returns Result of the read
+ */
+uint32_t cvmx_pcie_config_read32(int pcie_port, int bus, int dev, int fn,
+				 int reg)
+{
+	uint64_t address =
+	    __cvmx_pcie_build_config_addr(pcie_port, bus, dev, fn, reg);
+	if (address)
+		return le32_to_cpu(cvmx_read64_uint32(address));
+	else
+		return 0xffffffff;
+}
+
+/**
+ * Write 8bits to a Device's config space
+ *
+ * @pcie_port: PCIe port the device is on
+ * @bus:       Sub bus
+ * @dev:       Device ID
+ * @fn:        Device sub function
+ * @reg:       Register to access
+ * @val:       Value to write
+ */
+void cvmx_pcie_config_write8(int pcie_port, int bus, int dev, int fn,
+			     int reg, uint8_t val)
+{
+	uint64_t address =
+	    __cvmx_pcie_build_config_addr(pcie_port, bus, dev, fn, reg);
+	if (address)
+		cvmx_write64_uint8(address, val);
+}
+
+/**
+ * Write 16bits to a Device's config space
+ *
+ * @pcie_port: PCIe port the device is on
+ * @bus:       Sub bus
+ * @dev:       Device ID
+ * @fn:        Device sub function
+ * @reg:       Register to access
+ * @val:       Value to write
+ */
+void cvmx_pcie_config_write16(int pcie_port, int bus, int dev, int fn,
+			      int reg, uint16_t val)
+{
+	uint64_t address =
+	    __cvmx_pcie_build_config_addr(pcie_port, bus, dev, fn, reg);
+	if (address)
+		cvmx_write64_uint16(address, cpu_to_le16(val));
+}
+
+/**
+ * Write 32bits to a Device's config space
+ *
+ * @pcie_port: PCIe port the device is on
+ * @bus:       Sub bus
+ * @dev:       Device ID
+ * @fn:        Device sub function
+ * @reg:       Register to access
+ * @val:       Value to write
+ */
+void cvmx_pcie_config_write32(int pcie_port, int bus, int dev, int fn,
+			      int reg, uint32_t val)
+{
+	uint64_t address =
+	    __cvmx_pcie_build_config_addr(pcie_port, bus, dev, fn, reg);
+	if (address)
+		cvmx_write64_uint32(address, cpu_to_le32(val));
+}
+
+/**
+ * Read a PCIe config space register indirectly. This is used for
+ * registers of the form PCIEEP_CFG??? and PCIERC?_CFG???.
+ *
+ * @pcie_port:  PCIe port to read from
+ * @cfg_offset: Address to read
+ *
+ * Returns Value read
+ */
+uint32_t cvmx_pcie_cfgx_read(int pcie_port, uint32_t cfg_offset)
+{
+	union cvmx_pescx_cfg_rd pescx_cfg_rd;
+	pescx_cfg_rd.u64 = 0;
+	pescx_cfg_rd.s.addr = cfg_offset;
+	cvmx_write_csr(CVMX_PESCX_CFG_RD(pcie_port), pescx_cfg_rd.u64);
+	pescx_cfg_rd.u64 = cvmx_read_csr(CVMX_PESCX_CFG_RD(pcie_port));
+	return pescx_cfg_rd.s.data;
+}
+
+/**
+ * Write a PCIe config space register indirectly. This is used for
+ * registers of the form PCIEEP_CFG??? and PCIERC?_CFG???.
+ *
+ * @pcie_port:  PCIe port to write to
+ * @cfg_offset: Address to write
+ * @val:        Value to write
+ */
+void cvmx_pcie_cfgx_write(int pcie_port, uint32_t cfg_offset, uint32_t val)
+{
+	union cvmx_pescx_cfg_wr pescx_cfg_wr;
+	pescx_cfg_wr.u64 = 0;
+	pescx_cfg_wr.s.addr = cfg_offset;
+	pescx_cfg_wr.s.data = val;
+	cvmx_write_csr(CVMX_PESCX_CFG_WR(pcie_port), pescx_cfg_wr.u64);
+}
+
+/**
+ * Initialize a PCIe port for use in target(EP) mode.
+ *
+ * Returns Zero on success
+ */
+int cvmx_pcie_ep_initialize(void)
+{
+	int pcie_port = 0;
+	union cvmx_npei_ctl_status npei_ctl_status;
+	union cvmx_pciercx_cfg030 pciercx_cfg030;
+	union cvmx_npei_ctl_status2 npei_ctl_status2;
+	union cvmx_npei_mem_access_subidx mem_access_subid;
+
+	npei_ctl_status.u64 = cvmx_read_csr(CVMX_PEXP_NPEI_CTL_STATUS);
+	if (npei_ctl_status.s.host_mode)
+		return -1;
+
+	/* Enable bus master and memory */
+	cvmx_pcie_cfgx_write(pcie_port, CVMX_PCIEEP_CFG001, 0x6);
+
+	/*
+	 * Max Payload Size (PCIE*_CFG030[MPS])
+	 * Max Read Request Size (PCIE*_CFG030[MRRS])
+	 * Relaxed-order, no-snoop enables (PCIE*_CFG030[RO_EN,NS_EN]
+	 * Error Message Enables (PCIE*_CFG030[CE_EN,NFE_EN,FE_EN,UR_EN])
+	 */
+	pciercx_cfg030.u32 =
+		cvmx_pcie_cfgx_read(pcie_port, CVMX_PCIERCX_CFG030(pcie_port));
+	/* Max payload size = 128 bytes (Limit of most PCs) */
+	pciercx_cfg030.s.mps = 0;
+	/*
+	 * Max read request size = 128 bytes for best Octeon DMA
+	 * performance.
+	 */
+	pciercx_cfg030.s.mrrs = 0;
+	/* Enable relaxed ordering. */
+	pciercx_cfg030.s.ro_en = 1;
+	/* Enable no snoop. */
+	pciercx_cfg030.s.ns_en = 1;
+	/* Correctable error reporting enable. */
+	pciercx_cfg030.s.ce_en = 1;
+	/* Non-fatal error reporting enable. */
+	pciercx_cfg030.s.nfe_en = 1;
+	/* Fatal error reporting enable. */
+	pciercx_cfg030.s.fe_en = 1;
+	/* Unsupported request reporting enable. */
+	pciercx_cfg030.s.ur_en = 1;
+	cvmx_pcie_cfgx_write(pcie_port, CVMX_PCIERCX_CFG030(pcie_port),
+			     pciercx_cfg030.u32);
+
+	/*
+	 * Max Payload Size (NPEI_CTL_STATUS2[MPS]) must match
+	 * PCIE*_CFG030[MPS]
+	 *
+	 * Max Read Request Size (NPEI_CTL_STATUS2[MRRS]) must not
+	 * exceed PCIE*_CFG030[MRRS]
+	 */
+	npei_ctl_status2.u64 = cvmx_read_csr(CVMX_PEXP_NPEI_CTL_STATUS2);
+	/* Max payload size = 128 bytes (Limit of most PCs) */
+	npei_ctl_status2.s.mps = 0;
+	/* Max read request size = 128 bytes for best Octeon DMA performance */
+	npei_ctl_status2.s.mrrs = 0;
+	cvmx_write_csr(CVMX_PEXP_NPEI_CTL_STATUS2, npei_ctl_status2.u64);
+
+	/* Setup Mem access SubDID 12 to access Host memory */
+	mem_access_subid.u64 = 0;
+	/* Port the request is sent to. */
+	mem_access_subid.s.port = pcie_port;
+	/* Merging is allowed in this window. */
+	mem_access_subid.s.nmerge = 1;
+	/* Endian-swap for Reads. */
+	mem_access_subid.s.esr = 0;
+	/* Endian-swap for Writes. */
+	mem_access_subid.s.esw = 0;
+	/* No Snoop for Reads. */
+	mem_access_subid.s.nsr = 1;
+	/* No Snoop for Writes. */
+	mem_access_subid.s.nsw = 1;
+	/* Disable Relaxed Ordering for Reads. */
+	mem_access_subid.s.ror = 0;
+	/* Disable Relaxed Ordering for Writes. */
+	mem_access_subid.s.row = 0;
+	/* PCIe Adddress Bits <63:34>. */
+	mem_access_subid.s.ba = 0;
+	cvmx_write_csr(CVMX_PEXP_NPEI_MEM_ACCESS_SUBIDX(12),
+		       mem_access_subid.u64);
+	return 0;
+}
diff --git a/arch/mips/cavium-octeon/msi.c b/arch/mips/cavium-octeon/msi.c
new file mode 100644
index 0000000..964b03b
--- /dev/null
+++ b/arch/mips/cavium-octeon/msi.c
@@ -0,0 +1,288 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2005-2007 Cavium Networks
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/msi.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+
+#include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-npi-defs.h>
+#include <asm/octeon/cvmx-pci-defs.h>
+#include <asm/octeon/cvmx-npei-defs.h>
+#include <asm/octeon/cvmx-pexp-defs.h>
+
+#include "pci-common.h"
+
+/*
+ * Each bit in msi_free_irq_bitmask represents a MSI interrupt that is
+ * in use.
+ */
+static uint64_t msi_free_irq_bitmask;
+
+/*
+ * Each bit in msi_multiple_irq_bitmask tells that the device using
+ * this bit in msi_free_irq_bitmask is also using the next bit. This
+ * is used so we can disable all of the MSI interrupts when a device
+ * uses multiple.
+ */
+static uint64_t msi_multiple_irq_bitmask;
+
+/*
+ * This lock controls updates to msi_free_irq_bitmask and
+ * msi_multiple_irq_bitmask.
+ */
+static DEFINE_SPINLOCK(msi_free_irq_bitmask_lock);
+
+
+/**
+ * Called when a driver request MSI interrupts instead of the
+ * legacy INT A-D. This routine will allocate multiple interrupts
+ * for MSI devices that support them. A device can override this by
+ * programming the MSI control bits [6:4] before calling
+ * pci_enable_msi().
+ *
+ * @param dev    Device requesting MSI interrupts
+ * @param desc   MSI descriptor
+ *
+ * Returns 0 on success.
+ */
+int arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
+{
+	struct msi_msg msg;
+	uint16_t control;
+	int configured_private_bits;
+	int request_private_bits;
+	int irq;
+	int irq_step;
+	uint64_t search_mask;
+
+	/*
+	 * Read the MSI config to figure out how many IRQs this device
+	 * wants.  Most devices only want 1, which will give
+	 * configured_private_bits and request_private_bits equal 0.
+	 */
+	pci_read_config_word(dev, desc->msi_attrib.pos + PCI_MSI_FLAGS,
+			     &control);
+
+	/*
+	 * If the number of private bits has been configured then use
+	 * that value instead of the requested number. This gives the
+	 * driver the chance to override the number of interrupts
+	 * before calling pci_enable_msi().
+	 */
+	configured_private_bits = (control & PCI_MSI_FLAGS_QSIZE) >> 4;
+	if (configured_private_bits == 0) {
+		/* Nothing is configured, so use the hardware requested size */
+		request_private_bits = (control & PCI_MSI_FLAGS_QMASK) >> 1;
+	} else {
+		/*
+		 * Use the number of configured bits, assuming the
+		 * driver wanted to override the hardware request
+		 * value.
+		 */
+		request_private_bits = configured_private_bits;
+	}
+
+	/*
+	 * The PCI 2.3 spec mandates that there are at most 32
+	 * interrupts. If this device asks for more, only give it one.
+	 */
+	if (request_private_bits > 5)
+		request_private_bits = 0;
+
+try_only_one:
+	/*
+	 * The IRQs have to be aligned on a power of two based on the
+	 * number being requested.
+	 */
+	irq_step = 1 << request_private_bits;
+
+	/* Mask with one bit for each IRQ */
+	search_mask = (1 << irq_step) - 1;
+
+	/*
+	 * We're going to search msi_free_irq_bitmask_lock for zero
+	 * bits. This represents an MSI interrupt number that isn't in
+	 * use.
+	 */
+	spin_lock(&msi_free_irq_bitmask_lock);
+	for (irq = 0; irq < 64; irq += irq_step) {
+		if ((msi_free_irq_bitmask & (search_mask << irq)) == 0) {
+			msi_free_irq_bitmask |= search_mask << irq;
+			msi_multiple_irq_bitmask |= (search_mask >> 1) << irq;
+			break;
+		}
+	}
+	spin_unlock(&msi_free_irq_bitmask_lock);
+
+	/* Make sure the search for available interrupts didn't fail */
+	if (irq >= 64) {
+		if (request_private_bits) {
+			pr_err("arch_setup_msi_irq: Unable to find %d free "
+			       "interrupts, trying just one",
+			       1 << request_private_bits);
+			request_private_bits = 0;
+			goto try_only_one;
+		} else
+			panic("arch_setup_msi_irq: Unable to find a free MSI "
+			      "interrupt");
+	}
+
+	/* MSI interrupts start at logical IRQ OCTEON_IRQ_MSI_BIT0 */
+	irq += OCTEON_IRQ_MSI_BIT0;
+
+	switch (octeon_dma_bar_type) {
+	case OCTEON_DMA_BAR_TYPE_SMALL:
+		/* When not using big bar, Bar 0 is based at 128MB */
+		msg.address_lo =
+			((128ul << 20) + CVMX_PCI_MSI_RCV) & 0xffffffff;
+		msg.address_hi = ((128ul << 20) + CVMX_PCI_MSI_RCV) >> 32;
+	case OCTEON_DMA_BAR_TYPE_BIG:
+		/* When using big bar, Bar 0 is based at 0 */
+		msg.address_lo = (0 + CVMX_PCI_MSI_RCV) & 0xffffffff;
+		msg.address_hi = (0 + CVMX_PCI_MSI_RCV) >> 32;
+		break;
+	case OCTEON_DMA_BAR_TYPE_PCIE:
+		/* When using PCIe, Bar 0 is based at 0 */
+		/* FIXME CVMX_NPEI_MSI_RCV* other than 0? */
+		msg.address_lo = (0 + CVMX_NPEI_PCIE_MSI_RCV) & 0xffffffff;
+		msg.address_hi = (0 + CVMX_NPEI_PCIE_MSI_RCV) >> 32;
+		break;
+	default:
+		panic("arch_setup_msi_irq: Invalid octeon_dma_bar_type\n");
+	}
+	msg.data = irq - OCTEON_IRQ_MSI_BIT0;
+
+	/* Update the number of IRQs the device has available to it */
+	control &= ~PCI_MSI_FLAGS_QSIZE;
+	control |= request_private_bits << 4;
+	pci_write_config_word(dev, desc->msi_attrib.pos + PCI_MSI_FLAGS,
+			      control);
+
+	set_irq_msi(irq, desc);
+	write_msi_msg(irq, &msg);
+	return 0;
+}
+
+
+/**
+ * Called when a device no longer needs its MSI interrupts. All
+ * MSI interrupts for the device are freed.
+ *
+ * @irq:    The devices first irq number. There may be multple in sequence.
+ */
+void arch_teardown_msi_irq(unsigned int irq)
+{
+	int number_irqs;
+	uint64_t bitmask;
+
+	if ((irq < OCTEON_IRQ_MSI_BIT0) || (irq > OCTEON_IRQ_MSI_BIT63))
+		panic("arch_teardown_msi_irq: Attempted to teardown illegal "
+		      "MSI interrupt (%d)", irq);
+	irq -= OCTEON_IRQ_MSI_BIT0;
+
+	/*
+	 * Count the number of IRQs we need to free by looking at the
+	 * msi_multiple_irq_bitmask. Each bit set means that the next
+	 * IRQ is also owned by this device.
+	 */
+	number_irqs = 0;
+	while ((irq+number_irqs < 64) &&
+	       (msi_multiple_irq_bitmask & (1ull << (irq + number_irqs))))
+		number_irqs++;
+	number_irqs++;
+	/* Mask with one bit for each IRQ */
+	bitmask = (1 << number_irqs) - 1;
+	/* Shift the mask to the correct bit location */
+	bitmask <<= irq;
+	if ((msi_free_irq_bitmask & bitmask) != bitmask)
+		panic("arch_teardown_msi_irq: Attempted to teardown MSI "
+		      "interrupt (%d) not in use", irq);
+
+	/* Checks are done, update the in use bitmask */
+	spin_lock(&msi_free_irq_bitmask_lock);
+	msi_free_irq_bitmask &= ~bitmask;
+	msi_multiple_irq_bitmask &= ~bitmask;
+	spin_unlock(&msi_free_irq_bitmask_lock);
+}
+
+
+/**
+ * Called by the interrupt handling code when an MSI interrupt
+ * occurs.
+ *
+ * @param cpl
+ * @param dev_id
+ *
+ * @return
+ */
+static irqreturn_t octeon_msi_interrupt(int cpl, void *dev_id)
+{
+	uint64_t msi_bits;
+	int irq;
+
+	if (octeon_dma_bar_type == OCTEON_DMA_BAR_TYPE_PCIE)
+		msi_bits = cvmx_read_csr(CVMX_PEXP_NPEI_MSI_RCV0);
+	else
+		msi_bits = cvmx_read_csr(CVMX_NPI_NPI_MSI_RCV);
+	irq = fls64(msi_bits);
+	if (irq) {
+		irq += OCTEON_IRQ_MSI_BIT0 - 1;
+		if (irq_desc[irq].action) {
+			do_IRQ(irq);
+			return IRQ_HANDLED;
+		} else {
+			pr_err("Spurious MSI interrupt %d\n", irq);
+			if (octeon_has_feature(OCTEON_FEATURE_PCIE)) {
+				/* These chips have PCIe */
+				cvmx_write_csr(CVMX_PEXP_NPEI_MSI_RCV0,
+					       1ull << (irq -
+							OCTEON_IRQ_MSI_BIT0));
+			} else {
+				/* These chips have PCI */
+				cvmx_write_csr(CVMX_NPI_NPI_MSI_RCV,
+					       1ull << (irq -
+							OCTEON_IRQ_MSI_BIT0));
+			}
+		}
+	}
+	return IRQ_NONE;
+}
+
+
+/**
+ * Initializes the MSI interrupt handling code
+ *
+ * @return
+ */
+int octeon_msi_initialize(void)
+{
+	int r;
+	if (octeon_has_feature(OCTEON_FEATURE_PCIE)) {
+		r = request_irq(OCTEON_IRQ_PCI_MSI0, octeon_msi_interrupt,
+				IRQF_SHARED,
+				"MSI[0:63]", octeon_msi_interrupt);
+	} else if (octeon_is_pci_host()) {
+		r = request_irq(OCTEON_IRQ_PCI_MSI0, octeon_msi_interrupt,
+				IRQF_SHARED,
+				"MSI[0:15]", octeon_msi_interrupt);
+		r += request_irq(OCTEON_IRQ_PCI_MSI1, octeon_msi_interrupt,
+				 IRQF_SHARED,
+				 "MSI[16:31]", octeon_msi_interrupt);
+		r += request_irq(OCTEON_IRQ_PCI_MSI2, octeon_msi_interrupt,
+				 IRQF_SHARED,
+				 "MSI[32:47]", octeon_msi_interrupt);
+		r += request_irq(OCTEON_IRQ_PCI_MSI3, octeon_msi_interrupt,
+				 IRQF_SHARED,
+				 "MSI[48:63]", octeon_msi_interrupt);
+	}
+	return 0;
+}
+
+subsys_initcall(octeon_msi_initialize);
diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index 788d588..3d7be84 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -10,6 +10,8 @@
 #include <linux/hardirq.h>
 
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-pexp-defs.h>
+#include <asm/octeon/cvmx-npi-defs.h>
 
 DEFINE_RWLOCK(octeon_irq_ciu0_rwlock);
 DEFINE_RWLOCK(octeon_irq_ciu1_rwlock);
diff --git a/arch/mips/cavium-octeon/pci-common.c b/arch/mips/cavium-octeon/pci-common.c
new file mode 100644
index 0000000..cd029f8
--- /dev/null
+++ b/arch/mips/cavium-octeon/pci-common.c
@@ -0,0 +1,137 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2005-2007 Cavium Networks
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/interrupt.h>
+#include <linux/time.h>
+#include <linux/delay.h>
+#include "pci-common.h"
+
+typeof(pcibios_map_irq) *octeon_pcibios_map_irq;
+enum octeon_dma_bar_type octeon_dma_bar_type = OCTEON_DMA_BAR_TYPE_INVALID;
+
+/**
+ * Map a PCI device to the appropriate interrupt line
+ *
+ * @param dev    The Linux PCI device structure for the device to map
+ * @param slot   The slot number for this device on __BUS 0__. Linux
+ *               enumerates through all the bridges and figures out the
+ *               slot on Bus 0 where this device eventually hooks to.
+ * @param pin    The PCI interrupt pin read from the device, then swizzled
+ *               as it goes through each bridge.
+ * @return Interrupt number for the device
+ */
+int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	if (octeon_pcibios_map_irq)
+		return octeon_pcibios_map_irq(dev, slot, pin);
+	else
+		panic("octeon_pcibios_map_irq doesn't point to a "
+		      "pcibios_map_irq() function");
+}
+
+
+/**
+ * Called to perform platform specific PCI setup
+ *
+ * @param dev
+ * @return
+ */
+int pcibios_plat_dev_init(struct pci_dev *dev)
+{
+	uint16_t config;
+	uint32_t dconfig;
+	int pos;
+	/*
+	 * Force the Cache line setting to 64 bytes. The standard
+	 * Linux bus scan doesn't seem to set it. Octeon really has
+	 * 128 byte lines, but Intel bridges get really upset if you
+	 * try and set values above 64 bytes. Value is specified in
+	 * 32bit words.
+	 */
+	pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, 64 / 4);
+	/* Set latency timers for all devices */
+	pci_write_config_byte(dev, PCI_LATENCY_TIMER, 48);
+
+	/* Enable reporting System errors and parity errors on all devices */
+	/* Enable parity checking and error reporting */
+	pci_read_config_word(dev, PCI_COMMAND, &config);
+	config |= PCI_COMMAND_PARITY | PCI_COMMAND_SERR;
+	pci_write_config_word(dev, PCI_COMMAND, config);
+
+	if (dev->subordinate) {
+		/* Set latency timers on sub bridges */
+		pci_write_config_byte(dev, PCI_SEC_LATENCY_TIMER, 48);
+		/* More bridge error detection */
+		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &config);
+		config |= PCI_BRIDGE_CTL_PARITY | PCI_BRIDGE_CTL_SERR;
+		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, config);
+	}
+
+	/* Enable the PCIe normal error reporting */
+	pos = pci_find_capability(dev, PCI_CAP_ID_EXP);
+	if (pos) {
+		/* Update Device Control */
+		pci_read_config_word(dev, pos + PCI_EXP_DEVCTL, &config);
+		/* Correctable Error Reporting */
+		config |= PCI_EXP_DEVCTL_CERE;
+		/* Non-Fatal Error Reporting */
+		config |= PCI_EXP_DEVCTL_NFERE;
+		/* Fatal Error Reporting */
+		config |= PCI_EXP_DEVCTL_FERE;
+		/* Unsupported Request */
+		config |= PCI_EXP_DEVCTL_URRE;
+		pci_write_config_word(dev, pos + PCI_EXP_DEVCTL, config);
+	}
+
+	/* Find the Advanced Error Reporting capability */
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
+	if (pos) {
+		/* Clear Uncorrectable Error Status */
+		pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS,
+				      &dconfig);
+		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS,
+				       dconfig);
+		/* Enable reporting of all uncorrectable errors */
+		/* Uncorrectable Error Mask - turned on bits disable errors */
+		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, 0);
+		/*
+		 * Leave severity at HW default. This only controls if
+		 * errors are reported as uncorrectable or
+		 * correctable, not if the error is reported.
+		 */
+		/* PCI_ERR_UNCOR_SEVER - Uncorrectable Error Severity */
+		/* Clear Correctable Error Status */
+		pci_read_config_dword(dev, pos + PCI_ERR_COR_STATUS, &dconfig);
+		pci_write_config_dword(dev, pos + PCI_ERR_COR_STATUS, dconfig);
+		/* Enable reporting of all correctable errors */
+		/* Correctable Error Mask - turned on bits disable errors */
+		pci_write_config_dword(dev, pos + PCI_ERR_COR_MASK, 0);
+		/* Advanced Error Capabilities */
+		pci_read_config_dword(dev, pos + PCI_ERR_CAP, &dconfig);
+		/* ECRC Generation Enable */
+		if (config & PCI_ERR_CAP_ECRC_GENC)
+			config |= PCI_ERR_CAP_ECRC_GENE;
+		/* ECRC Check Enable */
+		if (config & PCI_ERR_CAP_ECRC_CHKC)
+			config |= PCI_ERR_CAP_ECRC_CHKE;
+		pci_write_config_dword(dev, pos + PCI_ERR_CAP, dconfig);
+		/* PCI_ERR_HEADER_LOG - Header Log Register (16 bytes) */
+		/* Report all errors to the root complex */
+		pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND,
+				       PCI_ERR_ROOT_CMD_COR_EN |
+				       PCI_ERR_ROOT_CMD_NONFATAL_EN |
+				       PCI_ERR_ROOT_CMD_FATAL_EN);
+		/* Clear the Root status register */
+		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &dconfig);
+		pci_write_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, dconfig);
+	}
+
+	return 0;
+}
diff --git a/arch/mips/cavium-octeon/pci-common.h b/arch/mips/cavium-octeon/pci-common.h
new file mode 100644
index 0000000..74ae799
--- /dev/null
+++ b/arch/mips/cavium-octeon/pci-common.h
@@ -0,0 +1,39 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2005-2007 Cavium Networks
+ */
+#ifndef __OCTEON_PCI_COMMON_H__
+#define __OCTEON_PCI_COMMON_H__
+
+#include <linux/pci.h>
+
+/* Some PCI cards require delays when accessing config space. */
+#define PCI_CONFIG_SPACE_DELAY 10000
+
+/* pcibios_map_irq() is defined inside pci-common.c. All it does is call the
+   Octeon specific version pointed to by this variable. This function needs to
+   change for PCI or PCIe based hosts */
+extern typeof(pcibios_map_irq) *octeon_pcibios_map_irq;
+
+/* The following defines are only used when octeon_dma_bar_type =
+   OCTEON_DMA_BAR_TYPE_BIG */
+#define OCTEON_PCI_BAR1_HOLE_BITS 5
+#define OCTEON_PCI_BAR1_HOLE_SIZE (1ul<<(OCTEON_PCI_BAR1_HOLE_BITS+3))
+
+enum octeon_dma_bar_type {
+	OCTEON_DMA_BAR_TYPE_INVALID,
+	OCTEON_DMA_BAR_TYPE_SMALL,
+	OCTEON_DMA_BAR_TYPE_BIG,
+	OCTEON_DMA_BAR_TYPE_PCIE
+};
+
+/**
+ * This is a variable to tell the DMA mapping system in dma-octeon.c
+ * how to map PCI DMA addresses.
+ */
+extern enum octeon_dma_bar_type octeon_dma_bar_type;
+
+#endif
diff --git a/arch/mips/cavium-octeon/pci.c b/arch/mips/cavium-octeon/pci.c
new file mode 100644
index 0000000..67c0ff5
--- /dev/null
+++ b/arch/mips/cavium-octeon/pci.c
@@ -0,0 +1,568 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2005-2007 Cavium Networks
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/interrupt.h>
+#include <linux/time.h>
+#include <linux/delay.h>
+
+#include <asm/time.h>
+
+#include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-npi-defs.h>
+#include <asm/octeon/cvmx-pci-defs.h>
+
+#include "pci-common.h"
+
+#define USE_OCTEON_INTERNAL_ARBITER
+
+/*
+ * Octeon's PCI controller uses did=3, subdid=2 for PCI IO
+ * addresses. Use PCI endian swapping 1 so no address swapping is
+ * necessary. The Linux io routines will endian swap the data.
+ */
+#define OCTEON_PCI_IOSPACE_BASE     0x80011a0400000000ull
+#define OCTEON_PCI_IOSPACE_SIZE     (1ull<<32)
+
+/* Octeon't PCI controller uses did=3, subdid=3 for PCI memory. */
+#define OCTEON_PCI_MEMSPACE_OFFSET  (0x00011b0000000000ull)
+
+/**
+ * This is the bit decoding used for the Octeon PCI controller addresses
+ */
+union octeon_pci_address {
+	uint64_t u64;
+	struct {
+		uint64_t upper:2;
+		uint64_t reserved:13;
+		uint64_t io:1;
+		uint64_t did:5;
+		uint64_t subdid:3;
+		uint64_t reserved2:4;
+		uint64_t endian_swap:2;
+		uint64_t reserved3:10;
+		uint64_t bus:8;
+		uint64_t dev:5;
+		uint64_t func:3;
+		uint64_t reg:8;
+	} s;
+};
+
+/**
+ * Return the mapping of PCI device number to IRQ line. Each
+ * character in the return string represents the interrupt
+ * line for the device at that position. Device 1 maps to the
+ * first character, etc. The characters A-D are used for PCI
+ * interrupts.
+ *
+ * Returns PCI interrupt mapping
+ */
+const char *octeon_get_pci_interrupts(void)
+{
+	/*
+	 * Returning an empty string causes the interrupts to be
+	 * routed based on the PCI specification. From the PCI spec:
+	 *
+	 * INTA# of Device Number 0 is connected to IRQW on the system
+	 * board.  (Device Number has no significance regarding being
+	 * located on the system board or in a connector.) INTA# of
+	 * Device Number 1 is connected to IRQX on the system
+	 * board. INTA# of Device Number 2 is connected to IRQY on the
+	 * system board. INTA# of Device Number 3 is connected to IRQZ
+	 * on the system board. The table below describes how each
+	 * agent's INTx# lines are connected to the system board
+	 * interrupt lines. The following equation can be used to
+	 * determine to which INTx# signal on the system board a given
+	 * device's INTx# line(s) is connected.
+	 *
+	 * MB = (D + I) MOD 4 MB = System board Interrupt (IRQW = 0,
+	 * IRQX = 1, IRQY = 2, and IRQZ = 3) D = Device Number I =
+	 * Interrupt Number (INTA# = 0, INTB# = 1, INTC# = 2, and
+	 * INTD# = 3)
+	 */
+	switch (octeon_bootinfo->board_type) {
+	case CVMX_BOARD_TYPE_NAO38:
+		/* This is really the NAC38 */
+		return "AAAAADABAAAAAAAAAAAAAAAAAAAAAAAA";
+	case CVMX_BOARD_TYPE_THUNDER:
+		return "";
+	case CVMX_BOARD_TYPE_EBH3000:
+		return "";
+	case CVMX_BOARD_TYPE_EBH3100:
+	case CVMX_BOARD_TYPE_CN3010_EVB_HS5:
+	case CVMX_BOARD_TYPE_CN3005_EVB_HS5:
+		return "AAABAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
+	case CVMX_BOARD_TYPE_BBGW_REF:
+		return "AABCD";
+	default:
+		return "";
+	}
+}
+
+/**
+ * Map a PCI device to the appropriate interrupt line
+ *
+ * @dev:    The Linux PCI device structure for the device to map
+ * @slot:   The slot number for this device on __BUS 0__. Linux
+ *               enumerates through all the bridges and figures out the
+ *               slot on Bus 0 where this device eventually hooks to.
+ * @pin:    The PCI interrupt pin read from the device, then swizzled
+ *               as it goes through each bridge.
+ * Returns Interrupt number for the device
+ */
+int __init octeon_pci_pcibios_map_irq(const struct pci_dev *dev,
+				      u8 slot, u8 pin)
+{
+	int irq_num;
+	const char *interrupts;
+	int dev_num;
+
+	/* Get the board specific interrupt mapping */
+	interrupts = octeon_get_pci_interrupts();
+
+	dev_num = dev->devfn >> 3;
+	if (dev_num < strlen(interrupts))
+		irq_num = ((interrupts[dev_num] - 'A' + pin - 1) & 3) +
+			OCTEON_IRQ_PCI_INT0;
+	else
+		irq_num = ((slot + pin - 3) & 3) + OCTEON_IRQ_PCI_INT0;
+	return irq_num;
+}
+
+
+/**
+ * Read a value from configuration space
+ *
+ */
+static int octeon_read_config(struct pci_bus *bus, unsigned int devfn,
+			      int reg, int size, u32 *val)
+{
+	union octeon_pci_address pci_addr;
+
+	pci_addr.u64 = 0;
+	pci_addr.s.upper = 2;
+	pci_addr.s.io = 1;
+	pci_addr.s.did = 3;
+	pci_addr.s.subdid = 1;
+	pci_addr.s.endian_swap = 1;
+	pci_addr.s.bus = bus->number;
+	pci_addr.s.dev = devfn >> 3;
+	pci_addr.s.func = devfn & 0x7;
+	pci_addr.s.reg = reg;
+
+#if PCI_CONFIG_SPACE_DELAY
+	udelay(PCI_CONFIG_SPACE_DELAY);
+#endif
+	switch (size) {
+	case 4:
+		*val = le32_to_cpu(cvmx_read64_uint32(pci_addr.u64));
+		return PCIBIOS_SUCCESSFUL;
+	case 2:
+		*val = le16_to_cpu(cvmx_read64_uint16(pci_addr.u64));
+		return PCIBIOS_SUCCESSFUL;
+	case 1:
+		*val = cvmx_read64_uint8(pci_addr.u64);
+		return PCIBIOS_SUCCESSFUL;
+	}
+	return PCIBIOS_FUNC_NOT_SUPPORTED;
+}
+
+
+/**
+ * Write a value to PCI configuration space
+ *
+ * @bus:
+ * @devfn:
+ * @reg:
+ * @size:
+ * @val:
+ * Returns
+ */
+static int octeon_write_config(struct pci_bus *bus, unsigned int devfn,
+			       int reg, int size, u32 val)
+{
+	union octeon_pci_address pci_addr;
+
+	pci_addr.u64 = 0;
+	pci_addr.s.upper = 2;
+	pci_addr.s.io = 1;
+	pci_addr.s.did = 3;
+	pci_addr.s.subdid = 1;
+	pci_addr.s.endian_swap = 1;
+	pci_addr.s.bus = bus->number;
+	pci_addr.s.dev = devfn >> 3;
+	pci_addr.s.func = devfn & 0x7;
+	pci_addr.s.reg = reg;
+
+#if PCI_CONFIG_SPACE_DELAY
+	udelay(PCI_CONFIG_SPACE_DELAY);
+#endif
+	switch (size) {
+	case 4:
+		cvmx_write64_uint32(pci_addr.u64, cpu_to_le32(val));
+		return PCIBIOS_SUCCESSFUL;
+	case 2:
+		cvmx_write64_uint16(pci_addr.u64, cpu_to_le16(val));
+		return PCIBIOS_SUCCESSFUL;
+	case 1:
+		cvmx_write64_uint8(pci_addr.u64, val);
+		return PCIBIOS_SUCCESSFUL;
+	}
+	return PCIBIOS_FUNC_NOT_SUPPORTED;
+}
+
+
+static struct pci_ops octeon_pci_ops = {
+	octeon_read_config,
+	octeon_write_config,
+};
+
+static struct resource octeon_pci_mem_resource = {
+	.start = 0,
+	.end = 0,
+	.name = "Octeon PCI MEM",
+	.flags = IORESOURCE_MEM,
+};
+
+/*
+ * PCI ports must be above 16KB so the ISA bus filtering in the PCI-X to PCI
+ * bridge
+ */
+static struct resource octeon_pci_io_resource = {
+	.start = 0x4000,
+	.end = OCTEON_PCI_IOSPACE_SIZE - 1,
+	.name = "Octeon PCI IO",
+	.flags = IORESOURCE_IO,
+};
+
+static struct pci_controller octeon_pci_controller = {
+	.pci_ops = &octeon_pci_ops,
+	.mem_resource = &octeon_pci_mem_resource,
+	.mem_offset = OCTEON_PCI_MEMSPACE_OFFSET,
+	.io_resource = &octeon_pci_io_resource,
+	.io_offset = 0,
+	.io_map_base = OCTEON_PCI_IOSPACE_BASE,
+};
+
+
+/**
+ * Low level initialize the Octeon PCI controller
+ *
+ * Returns
+ */
+static void octeon_pci_initialize(void)
+{
+	union cvmx_pci_cfg01 cfg01;
+	union cvmx_npi_ctl_status ctl_status;
+	union cvmx_pci_ctl_status_2 ctl_status_2;
+	union cvmx_pci_cfg19 cfg19;
+	union cvmx_pci_cfg16 cfg16;
+	union cvmx_pci_cfg22 cfg22;
+	union cvmx_pci_cfg56 cfg56;
+
+	/* Reset the PCI Bus */
+	cvmx_write_csr(CVMX_CIU_SOFT_PRST, 0x1);
+	cvmx_read_csr(CVMX_CIU_SOFT_PRST);
+
+	udelay(2000);		/* Hold PCI reset for 2 ms */
+
+	ctl_status.u64 = 0;	/* cvmx_read_csr(CVMX_NPI_CTL_STATUS); */
+	ctl_status.s.max_word = 1;
+	ctl_status.s.timer = 1;
+	cvmx_write_csr(CVMX_NPI_CTL_STATUS, ctl_status.u64);
+
+	/* Deassert PCI reset and advertize PCX Host Mode Device Capability
+	   (64b) */
+	cvmx_write_csr(CVMX_CIU_SOFT_PRST, 0x4);
+	cvmx_read_csr(CVMX_CIU_SOFT_PRST);
+
+	udelay(2000);		/* Wait 2 ms after deasserting PCI reset */
+
+	ctl_status_2.u32 = 0;
+	ctl_status_2.s.tsr_hwm = 1;	/* Initializes to 0.  Must be set
+					   before any PCI reads. */
+	ctl_status_2.s.bar2pres = 1;	/* Enable BAR2 */
+	ctl_status_2.s.bar2_enb = 1;
+	ctl_status_2.s.bar2_cax = 1;	/* Don't use L2 */
+	ctl_status_2.s.bar2_esx = 1;
+	ctl_status_2.s.pmo_amod = 1;	/* Round robin priority */
+	if (octeon_dma_bar_type == OCTEON_DMA_BAR_TYPE_BIG) {
+		/* BAR1 hole */
+		ctl_status_2.s.bb1_hole = OCTEON_PCI_BAR1_HOLE_BITS;
+		ctl_status_2.s.bb1_siz = 1;  /* BAR1 is 2GB */
+		ctl_status_2.s.bb_ca = 1;    /* Don't use L2 with big bars */
+		ctl_status_2.s.bb_es = 1;    /* Big bar in byte swap mode */
+		ctl_status_2.s.bb1 = 1;      /* BAR1 is big */
+		ctl_status_2.s.bb0 = 1;      /* BAR0 is big */
+	}
+
+	octeon_npi_write32(CVMX_NPI_PCI_CTL_STATUS_2, ctl_status_2.u32);
+	udelay(2000);		/* Wait 2 ms before doing PCI reads */
+
+	ctl_status_2.u32 = octeon_npi_read32(CVMX_NPI_PCI_CTL_STATUS_2);
+	pr_notice("PCI Status: %s %s-bit\n",
+		  ctl_status_2.s.ap_pcix ? "PCI-X" : "PCI",
+		  ctl_status_2.s.ap_64ad ? "64" : "32");
+
+	if (OCTEON_IS_MODEL(OCTEON_CN58XX) || OCTEON_IS_MODEL(OCTEON_CN50XX)) {
+		union cvmx_pci_cnt_reg cnt_reg_start;
+		union cvmx_pci_cnt_reg cnt_reg_end;
+		unsigned long cycles, pci_clock;
+
+		cnt_reg_start.u64 = cvmx_read_csr(CVMX_NPI_PCI_CNT_REG);
+		cycles = read_c0_cvmcount();
+		udelay(1000);
+		cnt_reg_end.u64 = cvmx_read_csr(CVMX_NPI_PCI_CNT_REG);
+		cycles = read_c0_cvmcount() - cycles;
+		pci_clock = (cnt_reg_end.s.pcicnt - cnt_reg_start.s.pcicnt) /
+			    (cycles / (mips_hpt_frequency / 1000000));
+		pr_notice("PCI Clock: %lu MHz\n", pci_clock);
+	}
+
+	/*
+	 * TDOMC must be set to one in PCI mode. TDOMC should be set to 4
+	 * in PCI-X mode to allow four oustanding splits. Otherwise,
+	 * should not change from its reset value. Don't write PCI_CFG19
+	 * in PCI mode (0x82000001 reset value), write it to 0x82000004
+	 * after PCI-X mode is known. MRBCI,MDWE,MDRE -> must be zero.
+	 * MRBCM -> must be one.
+	 */
+	if (ctl_status_2.s.ap_pcix) {
+		cfg19.u32 = 0;
+		/*
+		 * Target Delayed/Split request outstanding maximum
+		 * count. [1..31] and 0=32.  NOTE: If the user
+		 * programs these bits beyond the Designed Maximum
+		 * outstanding count, then the designed maximum table
+		 * depth will be used instead.  No additional
+		 * Deferred/Split transactions will be accepted if
+		 * this outstanding maximum count is
+		 * reached. Furthermore, no additional deferred/split
+		 * transactions will be accepted if the I/O delay/ I/O
+		 * Split Request outstanding maximum is reached.
+		 */
+		cfg19.s.tdomc = 4;
+		/*
+		 * Master Deferred Read Request Outstanding Max Count
+		 * (PCI only).  CR4C[26:24] Max SAC cycles MAX DAC
+		 * cycles 000 8 4 001 1 0 010 2 1 011 3 1 100 4 2 101
+		 * 5 2 110 6 3 111 7 3 For example, if these bits are
+		 * programmed to 100, the core can support 2 DAC
+		 * cycles, 4 SAC cycles or a combination of 1 DAC and
+		 * 2 SAC cycles. NOTE: For the PCI-X maximum
+		 * outstanding split transactions, refer to
+		 * CRE0[22:20].
+		 */
+		cfg19.s.mdrrmc = 2;
+		/*
+		 * Master Request (Memory Read) Byte Count/Byte Enable
+		 * select. 0 = Byte Enables valid. In PCI mode, a
+		 * burst transaction cannot be performed using Memory
+		 * Read command=4?h6. 1 = DWORD Byte Count valid
+		 * (default). In PCI Mode, the memory read byte
+		 * enables are automatically generated by the
+		 * core. Note: N3 Master Request transaction sizes are
+		 * always determined through the
+		 * am_attr[<35:32>|<7:0>] field.
+		 */
+		cfg19.s.mrbcm = 1;
+		octeon_npi_write32(CVMX_NPI_PCI_CFG19, cfg19.u32);
+	}
+
+
+	cfg01.u32 = 0;
+	cfg01.s.msae = 1;	/* Memory Space Access Enable */
+	cfg01.s.me = 1;		/* Master Enable */
+	cfg01.s.pee = 1;	/* PERR# Enable */
+	cfg01.s.see = 1;	/* System Error Enable */
+	cfg01.s.fbbe = 1;	/* Fast Back to Back Transaction Enable */
+
+	octeon_npi_write32(CVMX_NPI_PCI_CFG01, cfg01.u32);
+
+#ifdef USE_OCTEON_INTERNAL_ARBITER
+	/*
+	 * When OCTEON is a PCI host, most systems will use OCTEON's
+	 * internal arbiter, so must enable it before any PCI/PCI-X
+	 * traffic can occur.
+	 */
+	{
+		union cvmx_npi_pci_int_arb_cfg pci_int_arb_cfg;
+
+		pci_int_arb_cfg.u64 = 0;
+		pci_int_arb_cfg.s.en = 1;	/* Internal arbiter enable */
+		cvmx_write_csr(CVMX_NPI_PCI_INT_ARB_CFG, pci_int_arb_cfg.u64);
+	}
+#endif				/* USE_OCTEON_INTERNAL_ARBITER */
+
+	/*
+	 * Preferrably written to 1 to set MLTD. [RDSATI,TRTAE,
+	 * TWTAE,TMAE,DPPMR -> must be zero. TILT -> must not be set to
+	 * 1..7.
+	 */
+	cfg16.u32 = 0;
+	cfg16.s.mltd = 1;	/* Master Latency Timer Disable */
+	octeon_npi_write32(CVMX_NPI_PCI_CFG16, cfg16.u32);
+
+	/*
+	 * Should be written to 0x4ff00. MTTV -> must be zero.
+	 * FLUSH -> must be 1. MRV -> should be 0xFF.
+	 */
+	cfg22.u32 = 0;
+	/* Master Retry Value [1..255] and 0=infinite */
+	cfg22.s.mrv = 0xff;
+	/*
+	 * AM_DO_FLUSH_I control NOTE: This bit MUST BE ONE for proper
+	 * N3K operation.
+	 */
+	cfg22.s.flush = 1;
+	octeon_npi_write32(CVMX_NPI_PCI_CFG22, cfg22.u32);
+
+	/*
+	 * MOST Indicates the maximum number of outstanding splits (in -1
+	 * notation) when OCTEON is in PCI-X mode.  PCI-X performance is
+	 * affected by the MOST selection.  Should generally be written
+	 * with one of 0x3be807, 0x2be807, 0x1be807, or 0x0be807,
+	 * depending on the desired MOST of 3, 2, 1, or 0, respectively.
+	 */
+	cfg56.u32 = 0;
+	cfg56.s.pxcid = 7;	/* RO - PCI-X Capability ID */
+	cfg56.s.ncp = 0xe8;	/* RO - Next Capability Pointer */
+	cfg56.s.dpere = 1;	/* Data Parity Error Recovery Enable */
+	cfg56.s.roe = 1;	/* Relaxed Ordering Enable */
+	cfg56.s.mmbc = 1;	/* Maximum Memory Byte Count
+				   [0=512B,1=1024B,2=2048B,3=4096B] */
+	cfg56.s.most = 3;	/* Maximum outstanding Split transactions [0=1
+				   .. 7=32] */
+
+	octeon_npi_write32(CVMX_NPI_PCI_CFG56, cfg56.u32);
+
+	/*
+	 * Affects PCI performance when OCTEON services reads to its
+	 * BAR1/BAR2. Refer to Section 10.6.1.  The recommended values are
+	 * 0x22, 0x33, and 0x33 for PCI_READ_CMD_6, PCI_READ_CMD_C, and
+	 * PCI_READ_CMD_E, respectively. Unfortunately due to errata DDR-700,
+	 * these values need to be changed so they won't possibly prefetch off
+	 * of the end of memory if PCI is DMAing a buffer at the end of
+	 * memory. Note that these values differ from their reset values.
+	 */
+	octeon_npi_write32(CVMX_NPI_PCI_READ_CMD_6, 0x21);
+	octeon_npi_write32(CVMX_NPI_PCI_READ_CMD_C, 0x31);
+	octeon_npi_write32(CVMX_NPI_PCI_READ_CMD_E, 0x31);
+}
+
+
+/**
+ * Initialize the Octeon PCI controller
+ *
+ * Returns
+ */
+static int __init octeon_pci_setup(void)
+{
+	union cvmx_npi_mem_access_subidx mem_access;
+	int index;
+
+	/* Only these chips have PCI */
+	if (octeon_has_feature(OCTEON_FEATURE_PCIE))
+		return 0;
+
+	/* Point pcibios_map_irq() to the PCI version of it */
+	octeon_pcibios_map_irq = octeon_pci_pcibios_map_irq;
+
+	/* Only use the big bars on chips that support it */
+	if (OCTEON_IS_MODEL(OCTEON_CN31XX) ||
+	    OCTEON_IS_MODEL(OCTEON_CN38XX_PASS2) ||
+	    OCTEON_IS_MODEL(OCTEON_CN38XX_PASS1))
+		octeon_dma_bar_type = OCTEON_DMA_BAR_TYPE_SMALL;
+	else
+		octeon_dma_bar_type = OCTEON_DMA_BAR_TYPE_BIG;
+
+	/* PCI I/O and PCI MEM values */
+	set_io_port_base(OCTEON_PCI_IOSPACE_BASE);
+	ioport_resource.start = 0;
+	ioport_resource.end = OCTEON_PCI_IOSPACE_SIZE - 1;
+	if (!octeon_is_pci_host()) {
+		pr_notice("Not in host mode, PCI Controller not initialized\n");
+		return 0;
+	}
+
+	pr_notice("%s Octeon big bar support\n",
+		  (octeon_dma_bar_type ==
+		  OCTEON_DMA_BAR_TYPE_BIG) ? "Enabling" : "Disabling");
+
+	octeon_pci_initialize();
+
+	mem_access.u64 = 0;
+	mem_access.s.esr = 1;	/* Endian-Swap on read. */
+	mem_access.s.esw = 1;	/* Endian-Swap on write. */
+	mem_access.s.nsr = 0;	/* No-Snoop on read. */
+	mem_access.s.nsw = 0;	/* No-Snoop on write. */
+	mem_access.s.ror = 0;	/* Relax Read on read. */
+	mem_access.s.row = 0;	/* Relax Order on write. */
+	mem_access.s.ba = 0;	/* PCI Address bits [63:36]. */
+	cvmx_write_csr(CVMX_NPI_MEM_ACCESS_SUBID3, mem_access.u64);
+
+	/*
+	 * Remap the Octeon BAR 2 above all 32 bit devices
+	 * (0x8000000000ul).  This is done here so it is remapped
+	 * before the readl()'s below. We don't want BAR2 overlapping
+	 * with BAR0/BAR1 during these reads.
+	 */
+	octeon_npi_write32(CVMX_NPI_PCI_CFG08, 0);
+	octeon_npi_write32(CVMX_NPI_PCI_CFG09, 0x80);
+
+	/* Disable the BAR1 movable mappings */
+	for (index = 0; index < 32; index++)
+		octeon_npi_write32(CVMX_NPI_PCI_BAR1_INDEXX(index), 0);
+
+	if (octeon_dma_bar_type == OCTEON_DMA_BAR_TYPE_BIG) {
+		/* Remap the Octeon BAR 0 to 0-2GB */
+		octeon_npi_write32(CVMX_NPI_PCI_CFG04, 0);
+		octeon_npi_write32(CVMX_NPI_PCI_CFG05, 0);
+
+		/*
+		 * Remap the Octeon BAR 1 to map 2GB-4GB (minus the
+		 * BAR 1 hole).
+		 */
+		octeon_npi_write32(CVMX_NPI_PCI_CFG06, 2ul << 30);
+		octeon_npi_write32(CVMX_NPI_PCI_CFG07, 0);
+
+		/* Devices go after BAR1 */
+		octeon_pci_mem_resource.start =
+			OCTEON_PCI_MEMSPACE_OFFSET + (4ul << 30) -
+			(OCTEON_PCI_BAR1_HOLE_SIZE << 20);
+		octeon_pci_mem_resource.end =
+			octeon_pci_mem_resource.start + (1ul << 30);
+	} else {
+		/* Remap the Octeon BAR 0 to map 128MB-(128MB+4KB) */
+		octeon_npi_write32(CVMX_NPI_PCI_CFG04, 128ul << 20);
+		octeon_npi_write32(CVMX_NPI_PCI_CFG05, 0);
+
+		/* Remap the Octeon BAR 1 to map 0-128MB */
+		octeon_npi_write32(CVMX_NPI_PCI_CFG06, 0);
+		octeon_npi_write32(CVMX_NPI_PCI_CFG07, 0);
+
+		/* Devices go after BAR0 */
+		octeon_pci_mem_resource.start =
+			OCTEON_PCI_MEMSPACE_OFFSET + (128ul << 20) +
+			(4ul << 10);
+		octeon_pci_mem_resource.end =
+			octeon_pci_mem_resource.start + (1ul << 30);
+	}
+
+	register_pci_controller(&octeon_pci_controller);
+
+	/*
+	 * Clear any errors that might be pending from before the bus
+	 * was setup properly.
+	 */
+	cvmx_write_csr(CVMX_NPI_PCI_INT_SUM2, -1);
+	return 0;
+}
+
+arch_initcall(octeon_pci_setup);
diff --git a/arch/mips/cavium-octeon/pcie.c b/arch/mips/cavium-octeon/pcie.c
new file mode 100644
index 0000000..cb6662c
--- /dev/null
+++ b/arch/mips/cavium-octeon/pcie.c
@@ -0,0 +1,441 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2007, 2008 Cavium Networks
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/interrupt.h>
+#include <linux/time.h>
+#include <linux/delay.h>
+
+#include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-pcie.h>
+#include <asm/octeon/cvmx-npei-defs.h>
+#include <asm/octeon/cvmx-pexp-defs.h>
+
+#include "pci-common.h"
+
+/**
+ * Map a PCI device to the appropriate interrupt line
+ *
+ * @param dev    The Linux PCI device structure for the device to map
+ * @param slot   The slot number for this device on __BUS 0__. Linux
+ *               enumerates through all the bridges and figures out the
+ *               slot on Bus 0 where this device eventually hooks to.
+ * @param pin    The PCI interrupt pin read from the device, then swizzled
+ *               as it goes through each bridge.
+ * @return Interrupt number for the device
+ */
+int __init octeon_pcie_pcibios_map_irq(const struct pci_dev *dev,
+				       u8 slot, u8 pin)
+{
+	/*
+	 * The EBH5600 board with the PCI to PCIe bridge mistakenly
+	 * wires the first slot for both device id 2 and interrupt
+	 * A. According to the PCI spec, device id 2 should be C. The
+	 * following kludge attempts to fix this.
+	 */
+	if (strstr(octeon_board_type_string(), "EBH5600") &&
+	    dev->bus && dev->bus->parent) {
+		/*
+		 * Iterate all the way up the device chain and find
+		 * the root bus.
+		 */
+		while (dev->bus && dev->bus->parent)
+			dev = to_pci_dev(dev->bus->bridge);
+		/* If the root bus is number 0 and the PEX 8114 is the
+		 * root, assume we are behind the miswired bus. We
+		 * need to correct the swizzle level by two. Yuck.
+		 */
+		if ((dev->bus->number == 0) &&
+		    (dev->vendor == 0x10b5) && (dev->device == 0x8114)) {
+			/*
+			 * The pin field is one based, not zero. We
+			 * need to swizzle it by minus two.
+			 */
+			pin = ((pin - 3) & 3) + 1;
+		}
+	}
+	/*
+	 * The -1 is because pin starts with one, not zero. It might
+	 * be that this equation needs to include the slot number, but
+	 * I don't have hardware to check that against.
+	 */
+	return pin - 1 + OCTEON_IRQ_PCI_INT0;
+}
+
+/**
+ * Read a value from configuration space
+ *
+ * @param bus
+ * @param devfn
+ * @param reg
+ * @param size
+ * @param val
+ * @return
+ */
+static inline int octeon_pcie_read_config(int pcie_port, struct pci_bus *bus,
+					  unsigned int devfn, int reg, int size,
+					  u32 *val)
+{
+	union octeon_cvmemctl cvmmemctl;
+	union octeon_cvmemctl cvmmemctl_save;
+	int bus_number = bus->number;
+
+	/*
+	 * We need to force the bus number to be zero on the root
+	 * bus. Linux numbers the 2nd root bus to start after all
+	 * buses on root 0.
+	 */
+	if (bus->parent == NULL)
+		bus_number = 0;
+
+	/*
+	 * PCIe only has a single device connected to Octeon. It is
+	 * always device ID 0. Don't bother doing reads for other
+	 * device IDs on the first segment.
+	 */
+	if ((bus_number == 0) && (devfn >> 3 != 0))
+		return PCIBIOS_FUNC_NOT_SUPPORTED;
+
+	/*
+	 * The following is a workaround for the CN57XX, CN56XX,
+	 * CN55XX, and CN54XX errata with PCIe config reads from non
+	 * existent devices.  These chips will hang the PCIe link if a
+	 * config read is performed that causes a UR response.
+	 */
+	if (OCTEON_IS_MODEL(OCTEON_CN56XX_PASS1) ||
+	    OCTEON_IS_MODEL(OCTEON_CN56XX_PASS1_1)) {
+		/*
+		 * For our EBH5600 board, port 0 has a bridge with two
+		 * PCI-X slots. We need a new special checks to make
+		 * sure we only probe valid stuff.  The PCIe->PCI-X
+		 * bridge only respondes to device ID 0, function
+		 * 0-1
+		 */
+		if ((bus_number == 0) && (devfn >= 2))
+			return PCIBIOS_FUNC_NOT_SUPPORTED;
+		/*
+		 * The PCI-X slots are device ID 2,3. Choose one of
+		 * the below "if" blocks based on what is plugged into
+		 * the board.
+		 */
+#if 1
+		/* Use this option if you aren't using either slot */
+		if (bus_number == 1)
+			return PCIBIOS_FUNC_NOT_SUPPORTED;
+#elif 0
+		/*
+		 * Use this option if you are using the first slot but
+		 * not the second.
+		 */
+		if ((bus_number == 1) && (devfn >> 3 != 2))
+			return PCIBIOS_FUNC_NOT_SUPPORTED;
+#elif 0
+		/*
+		 * Use this option if you are using the second slot
+		 * but not the first.
+		 */
+		if ((bus_number == 1) && (devfn >> 3 != 3))
+			return PCIBIOS_FUNC_NOT_SUPPORTED;
+#elif 0
+		/* Use this opion if you are using both slots */
+		if ((bus_number == 1) &&
+		    !((devfn == (2 << 3)) || (devfn == (3 << 3))))
+			return PCIBIOS_FUNC_NOT_SUPPORTED;
+#endif
+
+		/*
+		 * The following #if gives a more complicated
+		 * example. This is the required checks for running a
+		 * Nitrox CN16XX-NHBX in the slot of the EBH5600. This
+		 * card has a PLX PCIe bridge with four Nitrox PLX
+		 * parts behind it.
+		 */
+#if 0
+		/* PLX bridge with 4 ports */
+		if ((bus_number == 3) &&
+		    !((devfn >> 3 >= 1) && (devfn >> 3 <= 4)))
+			return PCIBIOS_FUNC_NOT_SUPPORTED;
+		/* Nitrox behind PLX 1 */
+		if ((bus_number == 4) && (devfn >> 3 != 0))
+			return PCIBIOS_FUNC_NOT_SUPPORTED;
+		/* Nitrox behind PLX 2 */
+		if ((bus_number == 5) && (devfn >> 3 != 0))
+			return PCIBIOS_FUNC_NOT_SUPPORTED;
+		/* Nitrox behind PLX 3 */
+		if ((bus_number == 6) && (devfn >> 3 != 0))
+			return PCIBIOS_FUNC_NOT_SUPPORTED;
+		/* Nitrox behind PLX 4 */
+		if ((bus_number == 7) && (devfn >> 3 != 0))
+			return PCIBIOS_FUNC_NOT_SUPPORTED;
+#endif
+		/*
+		 * Shorten the DID timeout so bus errors for PCIe
+		 * config reads from non existent devices happen
+		 * faster. This allows us to continue booting even if
+		 * the above "if" checks are wrong.  Once one of these
+		 * errors happens, the PCIe port is dead.
+		 */
+		cvmmemctl_save.u64 = __read_64bit_c0_register($11, 7);
+		cvmmemctl.u64 = cvmmemctl_save.u64;
+		cvmmemctl.s.didtto = 2;
+		__write_64bit_c0_register($11, 7, cvmmemctl.u64);
+	}
+
+	switch (size) {
+	case 4:
+		*val = cvmx_pcie_config_read32(pcie_port, bus_number,
+					       devfn >> 3, devfn & 0x7, reg);
+		break;
+	case 2:
+		*val = cvmx_pcie_config_read16(pcie_port, bus_number,
+					       devfn >> 3, devfn & 0x7, reg);
+		break;
+	case 1:
+		*val = cvmx_pcie_config_read8(pcie_port, bus_number, devfn >> 3,
+					      devfn & 0x7, reg);
+		break;
+	default:
+		return PCIBIOS_FUNC_NOT_SUPPORTED;
+	}
+
+	if (OCTEON_IS_MODEL(OCTEON_CN56XX_PASS1) ||
+	    OCTEON_IS_MODEL(OCTEON_CN56XX_PASS1_1))
+		__write_64bit_c0_register($11, 7, cvmmemctl_save.u64);
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int octeon_pcie0_read_config(struct pci_bus *bus, unsigned int devfn,
+				    int reg, int size, u32 *val)
+{
+	return octeon_pcie_read_config(0, bus, devfn, reg, size, val);
+}
+
+static int octeon_pcie1_read_config(struct pci_bus *bus, unsigned int devfn,
+				    int reg, int size, u32 *val)
+{
+	return octeon_pcie_read_config(1, bus, devfn, reg, size, val);
+}
+
+
+
+/**
+ * Write a value to PCI configuration space
+ *
+ * @param bus
+ * @param devfn
+ * @param reg
+ * @param size
+ * @param val
+ * @return
+ */
+static inline int octeon_pcie_write_config(int pcie_port, struct pci_bus *bus,
+					   unsigned int devfn, int reg,
+					   int size, u32 val)
+{
+	int bus_number = bus->number;
+	/*
+	 * We need to force the bus number to be zero on the root
+	 * bus. Linux numbers the 2nd root bus to start after all
+	 * busses on root 0.
+	 */
+	if (bus->parent == NULL)
+		bus_number = 0;
+
+	switch (size) {
+	case 4:
+		cvmx_pcie_config_write32(pcie_port, bus_number, devfn >> 3,
+					 devfn & 0x7, reg, val);
+		return PCIBIOS_SUCCESSFUL;
+	case 2:
+		cvmx_pcie_config_write16(pcie_port, bus_number, devfn >> 3,
+					 devfn & 0x7, reg, val);
+		return PCIBIOS_SUCCESSFUL;
+	case 1:
+		cvmx_pcie_config_write8(pcie_port, bus_number, devfn >> 3,
+					devfn & 0x7, reg, val);
+		return PCIBIOS_SUCCESSFUL;
+	}
+#if PCI_CONFIG_SPACE_DELAY
+	udelay(PCI_CONFIG_SPACE_DELAY);
+#endif
+	return PCIBIOS_FUNC_NOT_SUPPORTED;
+}
+
+static int octeon_pcie0_write_config(struct pci_bus *bus, unsigned int devfn,
+				     int reg, int size, u32 val)
+{
+	return octeon_pcie_write_config(0, bus, devfn, reg, size, val);
+}
+
+static int octeon_pcie1_write_config(struct pci_bus *bus, unsigned int devfn,
+				     int reg, int size, u32 val)
+{
+	return octeon_pcie_write_config(1, bus, devfn, reg, size, val);
+}
+
+static struct pci_ops octeon_pcie0_ops = {
+	octeon_pcie0_read_config,
+	octeon_pcie0_write_config,
+};
+
+static struct resource octeon_pcie0_mem_resource = {
+	.name = "Octeon PCIe0 MEM",
+	.flags = IORESOURCE_MEM,
+};
+
+static struct resource octeon_pcie0_io_resource = {
+	.name = "Octeon PCIe0 IO",
+	.flags = IORESOURCE_IO,
+};
+
+static struct pci_controller octeon_pcie0_controller = {
+	.pci_ops = &octeon_pcie0_ops,
+	.mem_resource = &octeon_pcie0_mem_resource,
+	.io_resource = &octeon_pcie0_io_resource,
+};
+
+static struct pci_ops octeon_pcie1_ops = {
+	octeon_pcie1_read_config,
+	octeon_pcie1_write_config,
+};
+
+static struct resource octeon_pcie1_mem_resource = {
+	.name = "Octeon PCIe1 MEM",
+	.flags = IORESOURCE_MEM,
+};
+
+static struct resource octeon_pcie1_io_resource = {
+	.name = "Octeon PCIe1 IO",
+	.flags = IORESOURCE_IO,
+};
+
+static struct pci_controller octeon_pcie1_controller = {
+	.pci_ops = &octeon_pcie1_ops,
+	.mem_resource = &octeon_pcie1_mem_resource,
+	.io_resource = &octeon_pcie1_io_resource,
+};
+
+
+/**
+ * Initialize the Octeon PCIe controllers
+ *
+ * @return
+ */
+static int __init octeon_pcie_setup(void)
+{
+	union cvmx_npei_ctl_status npei_ctl_status;
+	int result;
+
+	/* These chips don't have PCIe */
+	if (!octeon_has_feature(OCTEON_FEATURE_PCIE))
+		return 0;
+
+	/* Point pcibios_map_irq() to the PCIe version of it */
+	octeon_pcibios_map_irq = octeon_pcie_pcibios_map_irq;
+
+	/* Use the PCIe based DMA mappings */
+	octeon_dma_bar_type = OCTEON_DMA_BAR_TYPE_PCIE;
+
+	/*
+	 * PCIe I/O range. It is based on port 0 but includes up until
+	 * port 1's end.
+	 */
+	set_io_port_base(CVMX_ADD_IO_SEG(cvmx_pcie_get_io_base_address(0)));
+	ioport_resource.start = 0;
+	ioport_resource.end =
+		cvmx_pcie_get_io_base_address(1) -
+		cvmx_pcie_get_io_base_address(0) + cvmx_pcie_get_io_size(1) - 1;
+
+	npei_ctl_status.u64 = cvmx_read_csr(CVMX_PEXP_NPEI_CTL_STATUS);
+	if (npei_ctl_status.s.host_mode) {
+		pr_notice("PCIe: Initializing port 0\n");
+		result = cvmx_pcie_rc_initialize(0);
+		if (result == 0) {
+			/* Memory offsets are physical addresses */
+			octeon_pcie0_controller.mem_offset =
+				cvmx_pcie_get_mem_base_address(0);
+			/* IO offsets are Mips virtual addresses */
+			octeon_pcie0_controller.io_map_base =
+				CVMX_ADD_IO_SEG(cvmx_pcie_get_io_base_address
+						(0));
+			octeon_pcie0_controller.io_offset = 0;
+			/*
+			 * To keep things similar to PCI, we start
+			 * device addresses at the same place as PCI
+			 * uisng big bar support. This normally
+			 * translates to 4GB-256MB, which is the same
+			 * as most x86 PCs.
+			 */
+			octeon_pcie0_controller.mem_resource->start =
+				cvmx_pcie_get_mem_base_address(0) +
+				(4ul << 30) - (OCTEON_PCI_BAR1_HOLE_SIZE << 20);
+			octeon_pcie0_controller.mem_resource->end =
+				cvmx_pcie_get_mem_base_address(0) +
+				cvmx_pcie_get_mem_size(0) - 1;
+			/*
+			 * Ports must be above 16KB for the ISA bus
+			 * filtering in the PCI-X to PCI bridge.
+			 */
+			octeon_pcie0_controller.io_resource->start = 4 << 10;
+			octeon_pcie0_controller.io_resource->end =
+				cvmx_pcie_get_io_size(0) - 1;
+			register_pci_controller(&octeon_pcie0_controller);
+		}
+	} else {
+		pr_notice("PCIe: Port 0 in endpoint mode, skipping.\n");
+	}
+
+	/* Skip the 2nd port on CN52XX if port 0 is in 4 lane mode */
+	if (OCTEON_IS_MODEL(OCTEON_CN52XX)) {
+		union cvmx_npei_dbg_data npei_dbg_data;
+		npei_dbg_data.u64 = cvmx_read_csr(CVMX_PEXP_NPEI_DBG_DATA);
+		if (npei_dbg_data.cn52xx.qlm0_link_width)
+			return 0;
+	}
+
+	pr_notice("PCIe: Initializing port 1\n");
+	result = cvmx_pcie_rc_initialize(1);
+	if (result == 0) {
+		/* Memory offsets are physical addresses */
+		octeon_pcie1_controller.mem_offset =
+			cvmx_pcie_get_mem_base_address(1);
+		/* IO offsets are Mips virtual addresses */
+		octeon_pcie1_controller.io_map_base =
+			CVMX_ADD_IO_SEG(cvmx_pcie_get_io_base_address(1));
+		octeon_pcie1_controller.io_offset =
+			cvmx_pcie_get_io_base_address(1) -
+			cvmx_pcie_get_io_base_address(0);
+		/*
+		 * To keep things similar to PCI, we start device
+		 * addresses at the same place as PCI uisng big bar
+		 * support. This normally translates to 4GB-256MB,
+		 * which is the same as most x86 PCs.
+		 */
+		octeon_pcie1_controller.mem_resource->start =
+			cvmx_pcie_get_mem_base_address(1) + (4ul << 30) -
+			(OCTEON_PCI_BAR1_HOLE_SIZE << 20);
+		octeon_pcie1_controller.mem_resource->end =
+			cvmx_pcie_get_mem_base_address(1) +
+			cvmx_pcie_get_mem_size(1) - 1;
+		/*
+		 * Ports must be above 16KB for the ISA bus filtering
+		 * in the PCI-X to PCI bridge.
+		 */
+		octeon_pcie1_controller.io_resource->start =
+			cvmx_pcie_get_io_base_address(1) -
+			cvmx_pcie_get_io_base_address(0);
+		octeon_pcie1_controller.io_resource->end =
+			octeon_pcie1_controller.io_resource->start +
+			cvmx_pcie_get_io_size(1) - 1;
+		register_pci_controller(&octeon_pcie1_controller);
+	}
+	return 0;
+}
+
+arch_initcall(octeon_pcie_setup);
diff --git a/arch/mips/include/asm/octeon/cvmx-asm.h b/arch/mips/include/asm/octeon/cvmx-asm.h
index b21d3fc..093bcaf 100644
--- a/arch/mips/include/asm/octeon/cvmx-asm.h
+++ b/arch/mips/include/asm/octeon/cvmx-asm.h
@@ -119,7 +119,8 @@
 	asm ("pop %[rd],%[rs]" : [rd] "=d" (result) : [rs] "d" (input))
 #define CVMX_DPOP(result, input) \
 	asm ("dpop %[rd],%[rs]" : [rd] "=d" (result) : [rs] "d" (input))
-
+#define CVMX_CLZ(result, input) \
+	asm ("clz %[rd],%[rs]" : [rd] "=d" (result) : [rs] "d" (input))
 /* some new cop0-like stuff */
 #define CVMX_RDHWR(result, regstr) \
 	asm volatile ("rdhwr %[rt],$" CVMX_TMP_STR(regstr) : [rt] "=d" (result))
diff --git a/arch/mips/include/asm/octeon/cvmx-helper-errata.h b/arch/mips/include/asm/octeon/cvmx-helper-errata.h
new file mode 100644
index 0000000..ce5deea
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-helper-errata.h
@@ -0,0 +1,92 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/**
+ * @file
+ *
+ * Fixes and workaround for Octeon chip errata. This file
+ * contains functions called by cvmx-helper to workaround known
+ * chip errata. For the most part, code doesn't need to call
+ * these functions directly.
+ *
+ */
+#ifndef __CVMX_HELPER_ERRATA_H__
+#define __CVMX_HELPER_ERRATA_H__
+
+
+#include "cvmx-wqe.h"
+
+/**
+ * @INTERNAL
+ * Function to adjust internal IPD pointer alignments
+ *
+ * Returns 0 on success
+ *         !0 on failure
+ */
+extern int __cvmx_helper_errata_fix_ipd_ptr_alignment(void);
+
+/**
+ * @INTERNAL
+ * Workaround ASX setup errata with CN38XX pass1
+ *
+ * @interface: Interface to setup
+ * @port:      Port to setup (0..3)
+ * @cpu_clock_hz:
+ *                  Chip frequency in Hertz
+ *
+ * Returns Zero on success, negative on failure
+ */
+extern int __cvmx_helper_errata_asx_pass1(int interface, int port,
+					  int cpu_clock_hz);
+
+/**
+ * This function needs to be called on all Octeon chips with
+ * errata PKI-100.
+ *
+ * The Size field is 8 too large in WQE and next pointers
+ *
+ *  The Size field generated by IPD is 8 larger than it should
+ *  be. The Size field is <55:40> of both:
+ *      - WORD3 in the work queue entry, and
+ *      - the next buffer pointer (which precedes the packet data
+ *        in each buffer).
+ *
+ * @work:   Work queue entry to fix
+ * Returns Zero on success. Negative on failure
+ */
+extern int cvmx_helper_fix_ipd_packet_chain(struct cvmx_wqe *work);
+
+/**
+ * Due to errata G-720, the 2nd order CDR circuit on CN52XX pass
+ * 1 doesn't work properly. The following code disables 2nd order
+ * CDR for the specified QLM.
+ *
+ * @qlm:    QLM to disable 2nd order CDR for.
+ */
+extern void __cvmx_helper_errata_qlm_disable_2nd_order_cdr(int qlm);
+
+#endif
diff --git a/arch/mips/include/asm/octeon/cvmx-helper-util.h b/arch/mips/include/asm/octeon/cvmx-helper-util.h
new file mode 100644
index 0000000..d720217
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-helper-util.h
@@ -0,0 +1,266 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/**
+ *
+ * Small helper utilities.
+ *
+ */
+
+#ifndef __CVMX_HELPER_UTIL_H__
+#define __CVMX_HELPER_UTIL_H__
+
+#ifdef CVMX_ENABLE_HELPER_FUNCTIONS
+
+/**
+ * Convert a interface mode into a human readable string
+ *
+ * @mode:   Mode to convert
+ *
+ * Returns String
+ */
+extern const char
+    *cvmx_helper_interface_mode_to_string(cvmx_helper_interface_mode_t mode);
+
+/**
+ * Debug routine to dump the packet structure to the console
+ *
+ * @work:   Work queue entry containing the packet to dump
+ * Returns
+ */
+extern int cvmx_helper_dump_packet(cvmx_wqe_t *work);
+
+/**
+ * Setup Random Early Drop on a specific input queue
+ *
+ * @queue:  Input queue to setup RED on (0-7)
+ * @pass_thresh:
+ *               Packets will begin slowly dropping when there are less than
+ *               this many packet buffers free in FPA 0.
+ * @drop_thresh:
+ *               All incomming packets will be dropped when there are less
+ *               than this many free packet buffers in FPA 0.
+ * Returns Zero on success. Negative on failure
+ */
+extern int cvmx_helper_setup_red_queue(int queue, int pass_thresh,
+				       int drop_thresh);
+
+/**
+ * Setup Random Early Drop to automatically begin dropping packets.
+ *
+ * @pass_thresh:
+ *               Packets will begin slowly dropping when there are less than
+ *               this many packet buffers free in FPA 0.
+ * @drop_thresh:
+ *               All incomming packets will be dropped when there are less
+ *               than this many free packet buffers in FPA 0.
+ * Returns Zero on success. Negative on failure
+ */
+extern int cvmx_helper_setup_red(int pass_thresh, int drop_thresh);
+
+/**
+ * Get the version of the CVMX libraries.
+ *
+ * Returns Version string. Note this buffer is allocated statically
+ *         and will be shared by all callers.
+ */
+extern const char *cvmx_helper_get_version(void);
+
+/**
+ * @INTERNAL
+ * Setup the common GMX settings that determine the number of
+ * ports. These setting apply to almost all configurations of all
+ * chips.
+ *
+ * @interface: Interface to configure
+ * @num_ports: Number of ports on the interface
+ *
+ * Returns Zero on success, negative on failure
+ */
+extern int __cvmx_helper_setup_gmx(int interface, int num_ports);
+
+/**
+ * Returns the IPD/PKO port number for a port on the given
+ * interface.
+ *
+ * @interface: Interface to use
+ * @port:      Port on the interface
+ *
+ * Returns IPD/PKO port number
+ */
+extern int cvmx_helper_get_ipd_port(int interface, int port);
+
+/**
+ * Returns the IPD/PKO port number for the first port on the given
+ * interface.
+ *
+ * @interface: Interface to use
+ *
+ * Returns IPD/PKO port number
+ */
+static inline int cvmx_helper_get_first_ipd_port(int interface)
+{
+	return cvmx_helper_get_ipd_port(interface, 0);
+}
+
+/**
+ * Returns the IPD/PKO port number for the last port on the given
+ * interface.
+ *
+ * @interface: Interface to use
+ *
+ * Returns IPD/PKO port number
+ */
+static inline int cvmx_helper_get_last_ipd_port(int interface)
+{
+	extern int cvmx_helper_ports_on_interface(int interface);
+
+	return cvmx_helper_get_first_ipd_port(interface) +
+		cvmx_helper_ports_on_interface(interface) - 1;
+}
+
+/**
+ * Free the packet buffers contained in a work queue entry.
+ * The work queue entry is not freed.
+ *
+ * @work:   Work queue entry with packet to free
+ */
+static inline void cvmx_helper_free_packet_data(cvmx_wqe_t *work)
+{
+	uint64_t number_buffers;
+	cvmx_buf_ptr_t buffer_ptr;
+	cvmx_buf_ptr_t next_buffer_ptr;
+	uint64_t start_of_buffer;
+
+	number_buffers = work->word2.s.bufs;
+	if (number_buffers == 0)
+		return;
+	buffer_ptr = work->packet_ptr;
+
+	/*
+	 * Since the number of buffers is not zero, we know this is
+	 * not a dynamic short packet. We need to check if it is a
+	 * packet received with IPD_CTL_STATUS[NO_WPTR]. If this is
+	 * true, we need to free all buffers except for the first
+	 * one. The caller doesn't expect their WQE pointer to be
+	 * freed.
+	 */
+	start_of_buffer = ((buffer_ptr.s.addr >> 7) - buffer_ptr.s.back) << 7;
+	if (cvmx_ptr_to_phys(work) == start_of_buffer) {
+		next_buffer_ptr =
+		    *(cvmx_buf_ptr_t *) cvmx_phys_to_ptr(buffer_ptr.s.addr - 8);
+		buffer_ptr = next_buffer_ptr;
+		number_buffers--;
+	}
+
+	while (number_buffers--) {
+		/*
+		 * Remember the back pointer is in cache lines, not
+		 * 64bit words.
+		 */
+		start_of_buffer =
+		    ((buffer_ptr.s.addr >> 7) - buffer_ptr.s.back) << 7;
+		/*
+		 * Read pointer to next buffer before we free the
+		 * current buffer.
+		 */
+		next_buffer_ptr =
+		    *(cvmx_buf_ptr_t *) cvmx_phys_to_ptr(buffer_ptr.s.addr - 8);
+		cvmx_fpa_free(cvmx_phys_to_ptr(start_of_buffer),
+			      buffer_ptr.s.pool, 0);
+		buffer_ptr = next_buffer_ptr;
+	}
+}
+
+#endif /* CVMX_ENABLE_HELPER_FUNCTIONS */
+
+/**
+ * Returns the interface number for an IPD/PKO port number.
+ *
+ * @ipd_port: IPD/PKO port number
+ *
+ * Returns Interface number
+ */
+extern int cvmx_helper_get_interface_num(int ipd_port);
+
+/**
+ * Returns the interface index number for an IPD/PKO port
+ * number.
+ *
+ * @ipd_port: IPD/PKO port number
+ *
+ * Returns Interface index number
+ */
+extern int cvmx_helper_get_interface_index_num(int ipd_port);
+
+/**
+ * Initialize the internal QLM JTAG logic to allow programming
+ * of the JTAG chain by the cvmx_helper_qlm_jtag_*() functions.
+ * These functions should only be used at the direction of Cavium
+ * Networks. Programming incorrect values into the JTAG chain
+ * can cause chip damage.
+ */
+extern void cvmx_helper_qlm_jtag_init(void);
+
+/**
+ * Write up to 32bits into the QLM jtag chain. Bits are shifted
+ * into the MSB and out the LSB, so you should shift in the low
+ * order bits followed by the high order bits. The JTAG chain is
+ * 4 * 268 bits long, or 1072.
+ *
+ * @qlm:    QLM to shift value into
+ * @bits:   Number of bits to shift in (1-32).
+ * @data:   Data to shift in. Bit 0 enters the chain first, followed by
+ *               bit 1, etc.
+ *
+ * Returns The low order bits of the JTAG chain that shifted out of the
+ *         circle.
+ */
+extern uint32_t cvmx_helper_qlm_jtag_shift(int qlm, int bits, uint32_t data);
+
+/**
+ * Shift long sequences of zeros into the QLM JTAG chain. It is
+ * common to need to shift more than 32 bits of zeros into the
+ * chain. This function is a convience wrapper around
+ * cvmx_helper_qlm_jtag_shift() to shift more than 32 bits of
+ * zeros at a time.
+ *
+ * @qlm:    QLM to shift zeros into
+ * @bits:
+ */
+extern void cvmx_helper_qlm_jtag_shift_zeros(int qlm, int bits);
+
+/**
+ * Program the QLM JTAG chain into all lanes of the QLM. You must
+ * have already shifted in 268*4, or 1072 bits into the JTAG
+ * chain. Updating invalid values can possibly cause chip damage.
+ *
+ * @qlm:    QLM to program
+ */
+extern void cvmx_helper_qlm_jtag_update(int qlm);
+
+#endif /* __CVMX_HELPER_H__ */
diff --git a/arch/mips/include/asm/octeon/cvmx-packet.h b/arch/mips/include/asm/octeon/cvmx-packet.h
index 38aefa1..1cb3419 100644
--- a/arch/mips/include/asm/octeon/cvmx-packet.h
+++ b/arch/mips/include/asm/octeon/cvmx-packet.h
@@ -25,7 +25,8 @@
  * Contact Cavium Networks for more information
  ***********************license end**************************************/
 
-/*
+/**
+ *
  * Packet buffer defines.
  */
 
@@ -39,18 +40,23 @@ union cvmx_buf_ptr {
 	void *ptr;
 	uint64_t u64;
 	struct {
-		/* if set, invert the "free" pick of the overall
+		/*
+		 * If set, invert the "free" pick of the overall
 		 * packet. HW always sets this bit to 0 on inbound
-		 * packet */
+		 * packet.
+		 */
 		uint64_t i:1;
 
-		/* Indicates the amount to back up to get to the
+		/*
+		 * Indicates the amount to back up to get to the
 		 * buffer start in cache lines. In most cases this is
 		 * less than one complete cache line, so the value is
-		 * zero */
+		 * zero.
+		 */
 		uint64_t back:4;
 		/* The pool that the buffer came from / goes to */
 		uint64_t pool:3;
+
 		/* The size of the segment pointed to by addr (in bytes) */
 		uint64_t size:16;
 		/* Pointer to the first byte of the data, NOT buffer */
diff --git a/arch/mips/include/asm/octeon/cvmx-pcie.h b/arch/mips/include/asm/octeon/cvmx-pcie.h
new file mode 100644
index 0000000..55a5ac1
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-pcie.h
@@ -0,0 +1,284 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/**
+ * @file
+ *
+ * Interface to PCIe as a host(RC) or target(EP)
+ *
+ */
+
+#ifndef __CVMX_PCIE_H__
+#define __CVMX_PCIE_H__
+
+union cvmx_pcie_address {
+	uint64_t u64;
+	struct {
+		uint64_t upper:2;	/* Normally 2 for XKPHYS */
+		uint64_t reserved_49_61:13;	/* Must be zero */
+		uint64_t io:1;	/* 1 for IO space access */
+		uint64_t did:5;	/* PCIe DID = 3 */
+		uint64_t subdid:3;	/* PCIe SubDID = 1 */
+		uint64_t reserved_36_39:4;	/* Must be zero */
+		uint64_t es:2;	/* Endian swap = 1 */
+		uint64_t port:2;	/* PCIe port 0,1 */
+		uint64_t reserved_29_31:3;	/* Must be zero */
+		/*
+		 * Selects the type of the configuration request (0 = type 0,
+		 * 1 = type 1).
+		 */
+		uint64_t ty:1;
+		/* Target bus number sent in the ID in the request. */
+		uint64_t bus:8;
+		/*
+		 * Target device number sent in the ID in the
+		 * request. Note that Dev must be zero for type 0
+		 * configuration requests.
+		 */
+		uint64_t dev:5;
+		/* Target function number sent in the ID in the request. */
+		uint64_t func:3;
+		/*
+		 * Selects a register in the configuration space of
+		 * the target.
+		 */
+		uint64_t reg:12;
+	} config;
+	struct {
+		uint64_t upper:2;	/* Normally 2 for XKPHYS */
+		uint64_t reserved_49_61:13;	/* Must be zero */
+		uint64_t io:1;	/* 1 for IO space access */
+		uint64_t did:5;	/* PCIe DID = 3 */
+		uint64_t subdid:3;	/* PCIe SubDID = 2 */
+		uint64_t reserved_36_39:4;	/* Must be zero */
+		uint64_t es:2;	/* Endian swap = 1 */
+		uint64_t port:2;	/* PCIe port 0,1 */
+		uint64_t address:32;	/* PCIe IO address */
+	} io;
+	struct {
+		uint64_t upper:2;	/* Normally 2 for XKPHYS */
+		uint64_t reserved_49_61:13;	/* Must be zero */
+		uint64_t io:1;	/* 1 for IO space access */
+		uint64_t did:5;	/* PCIe DID = 3 */
+		uint64_t subdid:3;	/* PCIe SubDID = 3-6 */
+		uint64_t reserved_36_39:4;	/* Must be zero */
+		uint64_t address:36;	/* PCIe Mem address */
+	} mem;
+};
+
+/**
+ * Return the Core virtual base address for PCIe IO access. IOs are
+ * read/written as an offset from this address.
+ *
+ * @pcie_port: PCIe port the IO is for
+ *
+ * Returns 64bit Octeon IO base address for read/write
+ */
+uint64_t cvmx_pcie_get_io_base_address(int pcie_port);
+
+/**
+ * Size of the IO address region returned at address
+ * cvmx_pcie_get_io_base_address()
+ *
+ * @pcie_port: PCIe port the IO is for
+ *
+ * Returns Size of the IO window
+ */
+uint64_t cvmx_pcie_get_io_size(int pcie_port);
+
+/**
+ * Return the Core virtual base address for PCIe MEM access. Memory is
+ * read/written as an offset from this address.
+ *
+ * @pcie_port: PCIe port the IO is for
+ *
+ * Returns 64bit Octeon IO base address for read/write
+ */
+uint64_t cvmx_pcie_get_mem_base_address(int pcie_port);
+
+/**
+ * Size of the Mem address region returned at address
+ * cvmx_pcie_get_mem_base_address()
+ *
+ * @pcie_port: PCIe port the IO is for
+ *
+ * Returns Size of the Mem window
+ */
+uint64_t cvmx_pcie_get_mem_size(int pcie_port);
+
+/**
+ * Initialize a PCIe port for use in host(RC) mode. It doesn't
+ * enumerate the bus.
+ *
+ * @pcie_port: PCIe port to initialize
+ *
+ * Returns Zero on success
+ */
+int cvmx_pcie_rc_initialize(int pcie_port);
+
+/**
+ * Shutdown a PCIe port and put it in reset
+ *
+ * @pcie_port: PCIe port to shutdown
+ *
+ * Returns Zero on success
+ */
+int cvmx_pcie_rc_shutdown(int pcie_port);
+
+/**
+ * Read 8bits from a Device's config space
+ *
+ * @pcie_port: PCIe port the device is on
+ * @bus:       Sub bus
+ * @dev:       Device ID
+ * @fn:        Device sub function
+ * @reg:       Register to access
+ *
+ * Returns Result of the read
+ */
+uint8_t cvmx_pcie_config_read8(int pcie_port, int bus, int dev, int fn,
+			       int reg);
+
+/**
+ * Read 16bits from a Device's config space
+ *
+ * @pcie_port: PCIe port the device is on
+ * @bus:       Sub bus
+ * @dev:       Device ID
+ * @fn:        Device sub function
+ * @reg:       Register to access
+ *
+ * Returns Result of the read
+ */
+uint16_t cvmx_pcie_config_read16(int pcie_port, int bus, int dev, int fn,
+				 int reg);
+
+/**
+ * Read 32bits from a Device's config space
+ *
+ * @pcie_port: PCIe port the device is on
+ * @bus:       Sub bus
+ * @dev:       Device ID
+ * @fn:        Device sub function
+ * @reg:       Register to access
+ *
+ * Returns Result of the read
+ */
+uint32_t cvmx_pcie_config_read32(int pcie_port, int bus, int dev, int fn,
+				 int reg);
+
+/**
+ * Write 8bits to a Device's config space
+ *
+ * @pcie_port: PCIe port the device is on
+ * @bus:       Sub bus
+ * @dev:       Device ID
+ * @fn:        Device sub function
+ * @reg:       Register to access
+ * @val:       Value to write
+ */
+void cvmx_pcie_config_write8(int pcie_port, int bus, int dev, int fn, int reg,
+			     uint8_t val);
+
+/**
+ * Write 16bits to a Device's config space
+ *
+ * @pcie_port: PCIe port the device is on
+ * @bus:       Sub bus
+ * @dev:       Device ID
+ * @fn:        Device sub function
+ * @reg:       Register to access
+ * @val:       Value to write
+ */
+void cvmx_pcie_config_write16(int pcie_port, int bus, int dev, int fn, int reg,
+			      uint16_t val);
+
+/**
+ * Write 32bits to a Device's config space
+ *
+ * @pcie_port: PCIe port the device is on
+ * @bus:       Sub bus
+ * @dev:       Device ID
+ * @fn:        Device sub function
+ * @reg:       Register to access
+ * @val:       Value to write
+ */
+void cvmx_pcie_config_write32(int pcie_port, int bus, int dev, int fn, int reg,
+			      uint32_t val);
+
+/**
+ * Read a PCIe config space register indirectly. This is used for
+ * registers of the form PCIEEP_CFG??? and PCIERC?_CFG???.
+ *
+ * @pcie_port:  PCIe port to read from
+ * @cfg_offset: Address to read
+ *
+ * Returns Value read
+ */
+uint32_t cvmx_pcie_cfgx_read(int pcie_port, uint32_t cfg_offset);
+
+/**
+ * Write a PCIe config space register indirectly. This is used for
+ * registers of the form PCIEEP_CFG??? and PCIERC?_CFG???.
+ *
+ * @pcie_port:  PCIe port to write to
+ * @cfg_offset: Address to write
+ * @val:        Value to write
+ */
+void cvmx_pcie_cfgx_write(int pcie_port, uint32_t cfg_offset, uint32_t val);
+
+/**
+ * Write a 32bit value to the Octeon NPEI register space
+ *
+ * @address: Address to write to
+ * @val:     Value to write
+ */
+static inline void cvmx_pcie_npei_write32(uint64_t address, uint32_t val)
+{
+	cvmx_write64_uint32(address ^ 4, val);
+	cvmx_read64_uint32(address ^ 4);
+}
+
+/**
+ * Read a 32bit value from the Octeon NPEI register space
+ *
+ * @address: Address to read
+ * Returns The result
+ */
+static inline uint32_t cvmx_pcie_npei_read32(uint64_t address)
+{
+	return cvmx_read64_uint32(address ^ 4);
+}
+
+/**
+ * Initialize a PCIe port for use in target(EP) mode.
+ *
+ * Returns Zero on success
+ */
+int cvmx_pcie_ep_initialize(void);
+
+#endif
diff --git a/arch/mips/include/asm/octeon/cvmx-wqe.h b/arch/mips/include/asm/octeon/cvmx-wqe.h
new file mode 100644
index 0000000..fadc700
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-wqe.h
@@ -0,0 +1,422 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+/**
+ *
+ * This header file defines the work queue entry (wqe) data structure.
+ * Since this is a commonly used structure that depends on structures
+ * from several hardware blocks, those definitions have been placed
+ * in this file to create a single point of definition of the wqe
+ * format.
+ *
+ * Data structures are still named according to the block that they
+ * relate to.
+ *
+ */
+
+#ifndef __CVMX_WQE_H__
+#define __CVMX_WQE_H__
+
+#include "cvmx-packet.h"
+
+#define OCT_TAG_TYPE_STRING(x) (					\
+	{								\
+		const char *r;						\
+		switch (x) {						\
+		case CVMX_POW_TAG_TYPE_ORDERED:				\
+			r = "ORDERED";					\
+			break;						\
+		case CVMX_POW_TAG_TYPE_ATOMIC:				\
+			r = "ATOMIC";					\
+			break;						\
+		case CVMX_POW_TAG_TYPE_NULL:				\
+			r = "NULL";					\
+			break;						\
+		default:						\
+			r = "NULL_NULL";				\
+			break;						\
+		}							\
+		r;							\
+	})
+
+/**
+ * HW decode / err_code in work queue entry
+ */
+union cvmx_pip_wqe_word2{
+	uint64_t u64;
+
+	/* Use this struct if the hardware determines that the packet is IP */
+	struct {
+		/* HW sets this to the number of buffers used by this packet */
+		uint64_t bufs:8;
+		/* HW sets to the number of L2 bytes prior to the IP */
+		uint64_t ip_offset:8;
+		/* Set to 1 if we found VLAN in the L2 */
+		uint64_t vlan_valid:1;
+		uint64_t unassigned:2;
+		/* HW sets to the VLAN CFI flag (valid when vlan_valid) */
+		uint64_t vlan_cfi:1;
+		/* HW sets to the VLAN_ID field (valid when vlan_valid) */
+		uint64_t vlan_id:12;
+
+		uint64_t unassigned2:12;
+		/* The packet needs to be decompressed */
+		uint64_t dec_ipcomp:1;
+		/* The packet is either TCP or UDP */
+		uint64_t tcp_or_udp:1;
+		/* The packet needs to be decrypted (ESP or AH) */
+		uint64_t dec_ipsec:1;
+		/* The packet is IPv6 */
+		uint64_t is_v6:1;
+
+		/*
+		 * rcv_error, not_IP, IP_exc, is_frag, L4_error,
+		 * software, etc.
+		 */
+
+		/*
+		 * Reserved for software use, hardware will clear on
+		 * packet creation.
+		 */
+		uint64_t software:1;
+		/* exceptional conditions below.  */
+
+		/*
+		 * The receive interface hardware detected an L4 error
+		 * (only applies if !is_frag) (only applies if
+		 * !rcv_error && !not_IP && !IP_exc && !is_frag)
+		 * failure indicated in err_code below, decode:
+		 *
+		 * - 1 = Malformed L4
+		 *
+		 * - 2 = L4 Checksum Error: the L4 checksum value is
+		 *
+		 * - 3 = UDP Length Error: The UDP length field would
+		 *       make the UDP data longer than what remains in
+		 *       the IP packet (as defined by the IP header
+		 *       length field).
+		 *
+		 * - 4 = Bad L4 Port: either the source or destination
+		 *       TCP/UDP port is 0.
+		 *
+		 * - 8 = TCP FIN Only: the packet is TCP and only the
+		 *       FIN flag set.
+		 *
+		 * - 9 = TCP No Flags: the packet is TCP and no flags
+		 *       are set.
+		 *
+		 * - 10 = TCP FIN RST: the packet is TCP and both FIN
+		 *        and RST are set.
+		 *
+		 * - 11 = TCP SYN URG: the packet is TCP and both SYN
+		 *        and URG are set.
+		 *
+		 * - 12 = TCP SYN RST: the packet is TCP and both SYN
+		 *        and RST are set.
+		 *
+		 * - 13 = TCP SYN FIN: the packet is TCP and both SYN
+		 *        and FIN are set.
+		 *
+		 */
+		uint64_t L4_error:1;
+		/* Set if the packet is a fragment */
+		uint64_t is_frag:1;
+
+		/*
+		 * The receive interface hardware detected an IP error
+		 * / exception (only applies if !rcv_error && !not_IP)
+		 * failure indicated in err_code below, decode:
+		 *
+		 * - 1 = Not IP: the IP version field is neither 4 nor
+		 *       6.
+		 *
+		 * - 2 = IPv4 Header Checksum Error: the IPv4 header
+		 *       has a checksum violation.
+		 *
+		 * - 3 = IP Malformed Header: the packet is not long
+		 *       enough to contain the IP header.
+		 *
+		 * - 4 = IP Malformed: the packet is not long enough
+		 *       to contain the bytes indicated by the IP
+		 *       header. Pad is allowed.
+		 *
+		 * - 5 = IP TTL Hop: the IPv4 TTL field or the IPv6
+		 *       Hop Count field are zero.
+		 *
+		 * - 6 = IP Options.
+		 */
+		uint64_t IP_exc:1;
+		/*
+		 * Set if the hardware determined that the packet is a
+		 * broadcast.
+		 */
+		uint64_t is_bcast:1;
+		/*
+		 * Set if the hardware determined that the packet is a
+		 * multi-cast.
+		 */
+		uint64_t is_mcast:1;
+		/*
+		 * Set if the packet may not be IP (must be zero in
+		 * this case).
+		 */
+		uint64_t not_IP:1;
+		/*
+		 * The receive interface hardware detected a receive
+		 * error (must be zero in this case)
+		 *
+		 * lower err_code = first-level descriptor of the work
+		 *
+		 * zero for packet submitted by hardware that isn't on
+		 * the slow path.
+		 */
+		uint64_t rcv_error:1;
+
+		/* Type is cvmx_pip_err_t */
+		uint64_t err_code:8;
+	} s;
+
+	/* Use this to get at the 16 vlan bits */
+	struct {
+		uint64_t unused1:16;
+		uint64_t vlan:16;
+		uint64_t unused2:32;
+	} svlan;
+
+	/*
+	 * Use this struct if the hardware could not determine that
+	 * the packet is ip.
+	 */
+	struct {
+		/* HW sets this to the number of buffers used by this packet. */
+		uint64_t bufs:8;
+		uint64_t unused:8;
+		/* Set to 1 if we found VLAN in the L2. */
+		uint64_t vlan_valid:1;
+		uint64_t unassigned:2;
+		/* HW sets to the VLAN CFI flag (valid when vlan_valid). */
+		uint64_t vlan_cfi:1;
+		/* HW sets to the VLAN_ID field (valid when vlan_valid). */
+		uint64_t vlan_id:12;
+
+		uint64_t unassigned2:16;
+		/*
+		 * Reserved for software use, hardware will clear on
+		 * packet creation.
+		 */
+		uint64_t software:1;
+		uint64_t unassigned3:1;
+		/* Set if the hardware determined that the packet is rarp. */
+		uint64_t is_rarp:1;
+		/* Set if the hardware determined that the packet is arp. */
+		uint64_t is_arp:1;
+		/*
+		 * Set if the hardware determined that the packet is a
+		 * broadcast.
+		 */
+		uint64_t is_bcast:1;
+		/*
+		 * Set if the hardware determined that the packet is a
+		 * multi-cast.
+		 */
+		uint64_t is_mcast:1;
+		/*
+		 * Set if the packet may not be IP (must be one in
+		 * this case).
+		 */
+		uint64_t not_IP:1;
+		/*
+		 * The receive interface hardware detected a receive
+		 * error. Failure indicated in err_code below, decode:
+		 *
+		 * - 1 = partial error: a packet was partially
+		 *       received, but internal buffering / bandwidth
+		 *       was not adequate to receive the entire
+		 *       packet.
+		 *
+		 * - 2 = jabber error: the RGMII packet was too large
+		 *       and is truncated.
+		 *
+		 * - 3 = overrun error: the RGMII packet is longer
+		 *       than allowed and had an FCS error.
+		 *
+		 * - 4 = oversize error: the RGMII packet is longer
+		 *       than allowed.
+		 *
+		 * - 5 = alignment error: the RGMII packet is not an
+		 *       integer number of bytes and had an FCS error
+		 *       (100M and 10M only).
+		 *
+		 * - 6 = fragment error: the RGMII packet is shorter
+		 *       than allowed and had an FCS error.
+		 *
+		 * - 7 = GMX FCS error: the RGMII packet had an FCS
+		 *       error.
+		 *
+		 * - 8 = undersize error: the RGMII packet is shorter
+		 *       than allowed.
+		 *
+		 * - 9 = extend error: the RGMII packet had an extend
+		 *       error.
+		 *
+		 * - 10 = length mismatch error: the RGMII packet had
+		 *        a length that did not match the length field
+		 *        in the L2 HDR.
+		 *
+		 * - 11 = RGMII RX error/SPI4 DIP4 Error: the RGMII
+		 *        packet had one or more data reception errors
+		 *        (RXERR) or the SPI4 packet had one or more
+		 *        DIP4 errors.
+		 *
+		 * - 12 = RGMII skip error/SPI4 Abort Error: the RGMII
+		 *        packet was not large enough to cover the
+		 *        skipped bytes or the SPI4 packet was
+		 *        terminated with an About EOPS.
+		 *
+		 * - 13 = RGMII nibble error/SPI4 Port NXA Error: the
+		 *        RGMII packet had a studder error (data not
+		 *        repeated - 10/100M only) or the SPI4 packet
+		 *        was sent to an NXA.
+		 *
+		 * - 16 = FCS error: a SPI4.2 packet had an FCS error.
+		 *
+		 * - 17 = Skip error: a packet was not large enough to
+		 *        cover the skipped bytes.
+		 *
+		 * - 18 = L2 header malformed: the packet is not long
+		 *        enough to contain the L2
+		 */
+
+		/*
+		 * lower err_code = first-level descriptor of the
+		 * work.
+		 *
+		 * zero for packet submitted by hardware that isn't on
+		 * the slow path.
+		 */
+		uint64_t rcv_error:1;
+
+		/* Type is cvmx_pip_err_t (union, so can't use directly. */
+		uint64_t err_code:8;
+	} snoip;
+
+};
+
+/**
+ * Work queue entry format
+ *
+ * must be 8-byte aligned
+ */
+struct cvmx_wqe {
+
+    /*****************************************************************
+     * WORD 0
+     *  HW WRITE: the following 64 bits are filled by HW when a packet arrives
+     */
+
+    /**
+     * raw chksum result generated by the HW
+     */
+	uint16_t hw_chksum;
+    /**
+     * Field unused by hardware - available for software
+     */
+	uint8_t unused;
+    /**
+     * Next pointer used by hardware for list maintenance.
+     * May be written/read by HW before the work queue
+     *           entry is scheduled to a PP
+     * (Only 36 bits used in Octeon 1)
+     */
+	uint64_t next_ptr:40;
+
+    /*****************************************************************
+     * WORD 1
+     *  HW WRITE: the following 64 bits are filled by HW when a packet arrives
+     */
+
+    /**
+     * HW sets to the total number of bytes in the packet
+     */
+	uint64_t len:16;
+    /**
+     * HW sets this to input physical port
+     */
+	uint64_t ipprt:6;
+
+    /**
+     * HW sets this to what it thought the priority of the input packet was
+     */
+	uint64_t qos:3;
+
+    /**
+     * the group that the work queue entry will be scheduled to
+     */
+	uint64_t grp:4;
+    /**
+     * the type of the tag (ORDERED, ATOMIC, NULL)
+     */
+	uint64_t tag_type:3;
+    /**
+     * the synchronization/ordering tag
+     */
+	uint64_t tag:32;
+
+    /**
+     * WORD 2 HW WRITE: the following 64-bits are filled in by
+     *   hardware when a packet arrives This indicates a variety of
+     *   status and error conditions.
+     */
+	union cvmx_pip_wqe_word2 word2;
+
+    /**
+     * Pointer to the first segment of the packet.
+     */
+	union cvmx_buf_ptr packet_ptr;
+
+    /**
+     *   HW WRITE: octeon will fill in a programmable amount from the
+     *             packet, up to (at most, but perhaps less) the amount
+     *             needed to fill the work queue entry to 128 bytes
+     *   If the packet is recognized to be IP, the hardware starts (except that
+     *   the IPv4 header is padded for appropriate alignment) writing here where
+     *   the IP header starts.
+     *   If the packet is not recognized to be IP, the hardware starts writing
+     *   the beginning of the packet here.
+     */
+	uint8_t packet_data[96];
+
+    /**
+     * If desired, SW can make the work Q entry any length. For the
+     * purposes of discussion here, Assume 128B always, as this is all that
+     * the hardware deals with.
+     *
+     */
+
+} CVMX_CACHE_LINE_ALIGNED;
+
+#endif /* __CVMX_WQE_H__ */
diff --git a/arch/mips/include/asm/octeon/cvmx.h b/arch/mips/include/asm/octeon/cvmx.h
index 03fddfa..e31e3fe 100644
--- a/arch/mips/include/asm/octeon/cvmx.h
+++ b/arch/mips/include/asm/octeon/cvmx.h
@@ -376,6 +376,18 @@ static inline uint64_t cvmx_get_cycle(void)
 }
 
 /**
+ * Wait for the specified number of cycle
+ *
+ */
+static inline void cvmx_wait(uint64_t cycles)
+{
+	uint64_t done = cvmx_get_cycle() + cycles;
+
+	while (cvmx_get_cycle() < done)
+		; /* Spin */
+}
+
+/**
  * Reads a chip global cycle counter.  This counts CPU cycles since
  * chip reset.  The counter is 64 bit.
  * This register does not exist on CN38XX pass 1 silicion
diff --git a/arch/mips/include/asm/octeon/octeon.h b/arch/mips/include/asm/octeon/octeon.h
index edc6760..cac9b1a 100644
--- a/arch/mips/include/asm/octeon/octeon.h
+++ b/arch/mips/include/asm/octeon/octeon.h
@@ -245,4 +245,6 @@ static inline uint32_t octeon_npi_read32(uint64_t address)
 	return cvmx_read64_uint32(address ^ 4);
 }
 
+extern struct cvmx_bootinfo *octeon_bootinfo;
+
 #endif /* __ASM_OCTEON_OCTEON_H */
-- 
1.5.6.5
