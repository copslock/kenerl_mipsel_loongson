Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Nov 2008 20:56:40 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:16282 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S23298038AbYKFUzO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Nov 2008 20:55:14 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4913599b0001>; Thu, 06 Nov 2008 15:54:51 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 6 Nov 2008 12:54:51 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 6 Nov 2008 12:54:50 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mA6KsjsU027696;
	Thu, 6 Nov 2008 12:54:45 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mA6KsjDJ027695;
	Thu, 6 Nov 2008 12:54:45 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: [PATCH 05/29] MIPS: Add Cavium OCTEON processor support files to arch/mips/cavium-octeon/executive and asm/octeon.
Date:	Thu,  6 Nov 2008 12:54:18 -0800
Message-Id: <1226004875-27654-5-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <491358F5.7040002@caviumnetworks.com>
References: <491358F5.7040002@caviumnetworks.com>
X-OriginalArrivalTime: 06 Nov 2008 20:54:50.0933 (UTC) FILETIME=[E969E650:01C94051]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21199
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/executive/Makefile       |   24 +
 arch/mips/cavium-octeon/executive/cvmx-bootmem.c |  929 ++++++++++++++++++++++
 arch/mips/cavium-octeon/executive/cvmx-l2c.c     |  736 +++++++++++++++++
 arch/mips/cavium-octeon/executive/cvmx-sysinfo.c |  117 +++
 arch/mips/cavium-octeon/executive/octeon-model.c |  346 ++++++++
 arch/mips/include/asm/octeon/cvmx-asm.h          |  446 +++++++++++
 arch/mips/include/asm/octeon/cvmx-bootinfo.h     |  238 ++++++
 arch/mips/include/asm/octeon/cvmx-bootmem.h      |  403 ++++++++++
 arch/mips/include/asm/octeon/cvmx-l2c.h          |  328 ++++++++
 arch/mips/include/asm/octeon/cvmx-packet.h       |   64 ++
 arch/mips/include/asm/octeon/cvmx-platform.h     |   56 ++
 arch/mips/include/asm/octeon/cvmx-spinlock.h     |  376 +++++++++
 arch/mips/include/asm/octeon/cvmx-sysinfo.h      |  144 ++++
 arch/mips/include/asm/octeon/cvmx-warn.h         |   40 +
 arch/mips/include/asm/octeon/cvmx.h              |  776 ++++++++++++++++++
 arch/mips/include/asm/octeon/octeon-feature.h    |  120 +++
 arch/mips/include/asm/octeon/octeon-model.h      |  225 ++++++
 17 files changed, 5368 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/cavium-octeon/executive/Makefile
 create mode 100644 arch/mips/cavium-octeon/executive/cvmx-bootmem.c
 create mode 100644 arch/mips/cavium-octeon/executive/cvmx-l2c.c
 create mode 100644 arch/mips/cavium-octeon/executive/cvmx-sysinfo.c
 create mode 100644 arch/mips/cavium-octeon/executive/octeon-model.c
 create mode 100644 arch/mips/include/asm/octeon/cvmx-asm.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-bootinfo.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-bootmem.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-l2c.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-packet.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-platform.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-spinlock.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-sysinfo.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-warn.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx.h
 create mode 100644 arch/mips/include/asm/octeon/octeon-feature.h
 create mode 100644 arch/mips/include/asm/octeon/octeon-model.h

diff --git a/arch/mips/cavium-octeon/executive/Makefile b/arch/mips/cavium-octeon/executive/Makefile
new file mode 100644
index 0000000..8b4aad7
--- /dev/null
+++ b/arch/mips/cavium-octeon/executive/Makefile
@@ -0,0 +1,24 @@
+#
+# Makefile for the Cavium Octeon specific kernel interface routines
+# under Linux.
+#
+# This file is subject to the terms and conditions of the GNU General Public
+# License.  See the file "COPYING" in the main directory of this archive
+# for more details.
+#
+# Copyright (C) 2005-2008 Cavium Networks
+#
+
+
+source:=$(srctree)/arch/mips/include/asm/octeon
+EXTRA_CFLAGS	+= -I$(source) -I$(source)/config
+
+executive-files := cvmx-bootmem.o
+executive-files += cvmx-l2c.o
+executive-files += cvmx-sysinfo.o
+executive-files += octeon-model.o
+obj-y := $(executive-files)
+
+executive-obj-files := $(executive-files:%=$(obj)/%)
+executive-src-files := $(executive-obj-files:%.o=%.c)
+
diff --git a/arch/mips/cavium-octeon/executive/cvmx-bootmem.c b/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
new file mode 100644
index 0000000..c152813
--- /dev/null
+++ b/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
@@ -0,0 +1,929 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as published by
+ * the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful,
+ * but AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or NONINFRINGEMENT.
+ * See the GNU General Public License for more details.
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
+ * Simple allocate only memory allocator.  Used to allocate memory at application
+ * start time.
+ *
+ */
+
+#include "cvmx.h"
+#include "cvmx-spinlock.h"
+#include "cvmx-bootmem.h"
+
+/*#define DEBUG */
+
+#undef	MAX
+#define MAX(a, b)  (((a) > (b)) ? (a) : (b))
+
+#undef	MIN
+#define MIN(a, b)  (((a) < (b)) ? (a) : (b))
+
+#define ALIGN_ADDR_UP(addr, align)     (((addr) + (~(align))) & (align))
+
+static cvmx_bootmem_desc_t *cvmx_bootmem_desc;
+
+/* See header file for descriptions of functions */
+
+/*
+ * Wrapper functions are provided for reading/writing the size and
+ * next block values as these may not be directly addressible (in 32
+ * bit applications, for instance.)  Offsets of data elements in
+ * bootmem list, must match cvmx_bootmem_block_header_t.
+ */
+#define NEXT_OFFSET 0
+#define SIZE_OFFSET 8
+static void cvmx_bootmem_phy_set_size(uint64_t addr, uint64_t size)
+{
+	cvmx_write64_uint64((addr + SIZE_OFFSET) | (1ull << 63), size);
+}
+
+static void cvmx_bootmem_phy_set_next(uint64_t addr, uint64_t next)
+{
+	cvmx_write64_uint64((addr + NEXT_OFFSET) | (1ull << 63), next);
+}
+
+static uint64_t cvmx_bootmem_phy_get_size(uint64_t addr)
+{
+	return cvmx_read64_uint64((addr + SIZE_OFFSET) | (1ull << 63));
+}
+
+static uint64_t cvmx_bootmem_phy_get_next(uint64_t addr)
+{
+	return cvmx_read64_uint64((addr + NEXT_OFFSET) | (1ull << 63));
+}
+
+void *cvmx_bootmem_alloc_range(uint64_t size, uint64_t alignment,
+			       uint64_t min_addr, uint64_t max_addr)
+{
+	int64_t address;
+	address =
+	    cvmx_bootmem_phy_alloc(size, min_addr, max_addr, alignment, 0);
+
+	if (address > 0)
+		return cvmx_phys_to_ptr(address);
+	else
+		return NULL;
+}
+
+void *cvmx_bootmem_alloc_address(uint64_t size, uint64_t address,
+				 uint64_t alignment)
+{
+	return cvmx_bootmem_alloc_range(size, alignment, address,
+					address + size);
+}
+
+void *cvmx_bootmem_alloc(uint64_t size, uint64_t alignment)
+{
+	return cvmx_bootmem_alloc_range(size, alignment, 0, 0);
+}
+
+void *cvmx_bootmem_alloc_named_range(uint64_t size, uint64_t min_addr,
+				     uint64_t max_addr, uint64_t align,
+				     char *name)
+{
+	int64_t addr;
+
+	addr =
+	    cvmx_bootmem_phy_named_block_alloc(size, min_addr, max_addr, align,
+					       name, 0);
+	if (addr >= 0)
+		return cvmx_phys_to_ptr(addr);
+	else
+		return NULL;
+
+}
+
+void *cvmx_bootmem_alloc_named_address(uint64_t size, uint64_t address,
+				       char *name)
+{
+	return cvmx_bootmem_alloc_named_range (size, address,
+					       address + size, 0, name);
+}
+
+void *cvmx_bootmem_alloc_named(uint64_t size, uint64_t alignment, char *name)
+{
+	return cvmx_bootmem_alloc_named_range(size, 0, 0, alignment, name);
+}
+
+int cvmx_bootmem_free_named(char *name)
+{
+	return cvmx_bootmem_phy_named_block_free(name, 0);
+}
+
+cvmx_bootmem_named_block_desc_t *cvmx_bootmem_find_named_block(char *name)
+{
+	return cvmx_bootmem_phy_named_block_find(name, 0);
+}
+
+void cvmx_bootmem_print_named(void)
+{
+	cvmx_bootmem_phy_named_block_print();
+}
+
+
+int cvmx_bootmem_init(void *mem_desc_ptr)
+{
+	/* Verify that the size of cvmx_spinlock_t meets our assumptions */
+	if (sizeof(cvmx_spinlock_t) != 4) {
+		cvmx_dprintf("ERROR: Unexpected size of cvmx_spinlock_t\n");
+		return -1;
+	}
+
+	/* Here we set the global pointer to the bootmem descriptor
+	 * block.  This pointer will be used directly, so we will set
+	 * it up to be directly usable by the application.  It is set
+	 * up as follows for the various runtime/ABI combinations:
+	 *
+	 * Linux 64 bit: Set XKPHYS bit
+	 * Linux 32 bit: use mmap to create mapping, use virtual address
+	 * CVMX 64 bit:  use physical address directly
+	 * CVMX 32 bit:  use physical address directly
+	 *
+	 * Note that the CVMX environment assumes the use of 1-1 TLB
+	 * mappings so that the physical addresses can be used
+	 * directly
+	 */
+	if (!cvmx_bootmem_desc) {
+#if   defined(CVMX_ABI_64)
+		/* Set XKPHYS bit */
+		cvmx_bootmem_desc = cvmx_phys_to_ptr(CAST64(mem_desc_ptr));
+#else
+		cvmx_bootmem_desc = (cvmx_bootmem_desc_t *) mem_desc_ptr;
+#endif
+	}
+
+	return 0;
+}
+
+uint64_t cvmx_bootmem_available_mem(uint64_t min_block_size)
+{
+	return cvmx_bootmem_phy_available_mem(min_block_size);
+}
+
+/*
+ * The cvmx_bootmem_phy* functions below return 64 bit physical
+ * addresses, and expose more features that the cvmx_bootmem_functions
+ * above.  These are required for full memory space access in 32 bit
+ * applications, as well as for using some advance features.  Most
+ * applications should not need to use these.
+ */
+
+int64_t cvmx_bootmem_phy_alloc(uint64_t req_size, uint64_t address_min,
+			       uint64_t address_max, uint64_t alignment,
+			       uint32_t flags)
+{
+
+	uint64_t head_addr;
+	uint64_t ent_addr;
+	/* points to previous list entry, NULL current entry is head of list */
+	uint64_t prev_addr = 0;
+	uint64_t new_ent_addr = 0;
+	uint64_t desired_min_addr;
+	uint64_t alignment_mask = ~(alignment - 1);
+
+#ifdef DEBUG
+	cvmx_dprintf("cvmx_bootmem_phy_alloc: req_size: 0x%llx, "
+		     "min_addr: 0x%llx, max_addr: 0x%llx, align: 0x%llx\n",
+		     (unsigned long long)req_size,
+		     (unsigned long long)address_min,
+		     (unsigned long long)address_max,
+		     (unsigned long long)alignment);
+#endif
+
+	if (cvmx_bootmem_desc->major_version > 3) {
+		cvmx_dprintf("ERROR: Incompatible bootmem descriptor "
+			     "version: %d.%d at addr: %p\n",
+			     (int)cvmx_bootmem_desc->major_version,
+			     (int)cvmx_bootmem_desc->minor_version,
+			     cvmx_bootmem_desc);
+		goto error_out;
+	}
+
+	/*
+	 * Do a variety of checks to validate the arguments.  The
+	 * allocator code will later assume that these checks have
+	 * been made.  We validate that the requested constraints are
+	 * not self-contradictory before we look through the list of
+	 * available memory.
+	 */
+
+	/* 0 is not a valid req_size for this allocator */
+	if (!req_size)
+		goto error_out;
+
+	/* Round req_size up to mult of minimum alignment bytes */
+	req_size =
+	    (req_size +
+	     (CVMX_BOOTMEM_ALIGNMENT_SIZE -
+	      1)) & ~(CVMX_BOOTMEM_ALIGNMENT_SIZE - 1);
+
+	/*
+	 * Convert !0 address_min and 0 address_max to special case of
+	 * range that specifies an exact memory block to allocate.  Do
+	 * this before other checks and adjustments so that this
+	 * tranformation will be validated.
+	 */
+	if (address_min && !address_max)
+		address_max = address_min + req_size;
+	else if (!address_min && !address_max)
+		address_max = ~0ull;  /* If no limits given, use max limits */
+
+
+	/*
+	 * Enforce minimum alignment (this also keeps the minimum free block
+	 * req_size the same as the alignment req_size.
+	 */
+	if (alignment < CVMX_BOOTMEM_ALIGNMENT_SIZE) {
+		alignment = CVMX_BOOTMEM_ALIGNMENT_SIZE;
+	}
+	alignment_mask = ~(alignment - 1);
+
+	/*
+	 * Adjust address minimum based on requested alignment (round
+	 * up to meet alignment).  Do this here so we can reject
+	 * impossible requests up front. (NOP for address_min == 0)
+	 */
+	if (alignment)
+		address_min =
+		    (address_min + (alignment - 1)) & ~(alignment - 1);
+
+	/*
+	 * Reject inconsistent args.  We have adjusted these, so this
+	 * may fail due to our internal changes even if this check
+	 * would pass for the values the user supplied.
+	 */
+	if (req_size > address_max - address_min)
+		goto error_out;
+
+	/* Walk through the list entries - first fit found is returned */
+
+	if (!(flags & CVMX_BOOTMEM_FLAG_NO_LOCKING))
+		cvmx_spinlock_lock((cvmx_spinlock_t *) &
+				   (cvmx_bootmem_desc->lock));
+	head_addr = cvmx_bootmem_desc->head_addr;
+	ent_addr = head_addr;
+	while (ent_addr) {
+		uint64_t usable_base, usable_max;
+		uint64_t ent_size = cvmx_bootmem_phy_get_size(ent_addr);
+
+		if (cvmx_bootmem_phy_get_next(ent_addr)
+		    && ent_addr > cvmx_bootmem_phy_get_next(ent_addr)) {
+			cvmx_dprintf("Internal bootmem_alloc() error: ent: "
+				     "0x%llx, next: 0x%llx\n",
+				     (unsigned long long)ent_addr,
+				     (unsigned long long)cvmx_bootmem_phy_get_next(ent_addr));
+			goto error_out;
+		}
+
+		/*
+		 * Determine if this is an entry that can satisify the
+		 * request Check to make sure entry is large enough to
+		 * satisfy request.
+		 */
+		usable_base =
+		    ALIGN_ADDR_UP(MAX(address_min, ent_addr), alignment_mask);
+		usable_max = MIN(address_max, ent_addr + ent_size);
+		/* We should be able to allocate block at address usable_base */
+
+		desired_min_addr = usable_base;
+		/*
+		 * Determine if request can be satisfied from the
+		 * current entry.
+		 */
+		if ((((ent_addr + ent_size) > usable_base
+		      && ent_addr < address_max))
+		    && req_size <= usable_max - usable_base) {
+			/*
+			 * We have found an entry that has room to
+			 * satisfy the request, so allocate it from
+			 * this entry.  If end
+			 * CVMX_BOOTMEM_FLAG_END_ALLOC set, then
+			 * allocate from the end of this block rather
+			 * than the beginning.
+			 */
+			if (flags & CVMX_BOOTMEM_FLAG_END_ALLOC) {
+				desired_min_addr = usable_max - req_size;
+				/* Align desired address down to required alignment */
+				desired_min_addr &= alignment_mask;
+			}
+
+			/* Match at start of entry */
+			if (desired_min_addr == ent_addr) {
+				if (req_size < ent_size) {
+					/* big enough to create a new block from top portion of block */
+					new_ent_addr = ent_addr + req_size;
+					cvmx_bootmem_phy_set_next(new_ent_addr,
+								  cvmx_bootmem_phy_get_next
+								  (ent_addr));
+					cvmx_bootmem_phy_set_size(new_ent_addr,
+								  ent_size -
+								  req_size);
+
+					/* Adjust next pointer as following code uses this */
+					cvmx_bootmem_phy_set_next(ent_addr,
+								  new_ent_addr);
+				}
+
+				/* adjust prev ptr or head to remove this entry from list */
+				if (prev_addr) {
+					cvmx_bootmem_phy_set_next(prev_addr,
+								  cvmx_bootmem_phy_get_next
+								  (ent_addr));
+				} else {
+					/* head of list being returned, so update head ptr */
+					cvmx_bootmem_desc->head_addr =
+					    cvmx_bootmem_phy_get_next(ent_addr);
+				}
+				if (!(flags & CVMX_BOOTMEM_FLAG_NO_LOCKING))
+					cvmx_spinlock_unlock((cvmx_spinlock_t *)
+							     &
+							     (cvmx_bootmem_desc->lock));
+				return desired_min_addr;
+			}
+
+			/*
+			 * block returned doesn't start at beginning
+			 * of entry, so we know that we will be
+			 * splitting a block off the front of this
+			 * one.  Create a new block from the
+			 * beginning, add to list, and go to top of
+			 * loop again.
+			 *
+			 * create new block from high portion of
+			 * block, so that top block starts at desired
+			 * addr.
+			 */
+			new_ent_addr = desired_min_addr;
+			cvmx_bootmem_phy_set_next(new_ent_addr,
+						  cvmx_bootmem_phy_get_next
+						  (ent_addr));
+			cvmx_bootmem_phy_set_size(new_ent_addr,
+						  cvmx_bootmem_phy_get_size
+						  (ent_addr) -
+						  (desired_min_addr -
+						   ent_addr));
+			cvmx_bootmem_phy_set_size(ent_addr,
+						  desired_min_addr - ent_addr);
+			cvmx_bootmem_phy_set_next(ent_addr, new_ent_addr);
+			/* Loop again to handle actual alloc from new block */
+		}
+
+		prev_addr = ent_addr;
+		ent_addr = cvmx_bootmem_phy_get_next(ent_addr);
+	}
+error_out:
+	/* We didn't find anything, so return error */
+	if (!(flags & CVMX_BOOTMEM_FLAG_NO_LOCKING))
+		cvmx_spinlock_unlock((cvmx_spinlock_t *) &
+				     (cvmx_bootmem_desc->lock));
+	return -1;
+}
+
+int __cvmx_bootmem_phy_free(uint64_t phy_addr, uint64_t size, uint32_t flags)
+{
+	uint64_t cur_addr;
+	uint64_t prev_addr = 0;	/* zero is invalid */
+	int retval = 0;
+
+#ifdef DEBUG
+	cvmx_dprintf("__cvmx_bootmem_phy_free addr: 0x%llx, size: 0x%llx\n",
+		     (unsigned long long)phy_addr, (unsigned long long)size);
+#endif
+	if (cvmx_bootmem_desc->major_version > 3) {
+		cvmx_dprintf("ERROR: Incompatible bootmem descriptor "
+			     "version: %d.%d at addr: %p\n",
+			     (int)cvmx_bootmem_desc->major_version,
+			     (int)cvmx_bootmem_desc->minor_version,
+			     cvmx_bootmem_desc);
+		return 0;
+	}
+
+	/* 0 is not a valid size for this allocator */
+	if (!size)
+		return 0;
+
+	if (!(flags & CVMX_BOOTMEM_FLAG_NO_LOCKING))
+		cvmx_spinlock_lock((cvmx_spinlock_t *) &
+				   (cvmx_bootmem_desc->lock));
+	cur_addr = cvmx_bootmem_desc->head_addr;
+	if (cur_addr == 0 || phy_addr < cur_addr) {
+		/* add at front of list - special case with changing head ptr */
+		if (cur_addr && phy_addr + size > cur_addr)
+			goto bootmem_free_done;	/* error, overlapping section */
+		else if (phy_addr + size == cur_addr) {
+			/* Add to front of existing first block */
+			cvmx_bootmem_phy_set_next(phy_addr,
+						  cvmx_bootmem_phy_get_next
+						  (cur_addr));
+			cvmx_bootmem_phy_set_size(phy_addr,
+						  cvmx_bootmem_phy_get_size
+						  (cur_addr) + size);
+			cvmx_bootmem_desc->head_addr = phy_addr;
+
+		} else {
+			/* New block before first block.  OK if cur_addr is 0 */
+			cvmx_bootmem_phy_set_next(phy_addr, cur_addr);
+			cvmx_bootmem_phy_set_size(phy_addr, size);
+			cvmx_bootmem_desc->head_addr = phy_addr;
+		}
+		retval = 1;
+		goto bootmem_free_done;
+	}
+
+	/* Find place in list to add block */
+	while (cur_addr && phy_addr > cur_addr) {
+		prev_addr = cur_addr;
+		cur_addr = cvmx_bootmem_phy_get_next(cur_addr);
+	}
+
+	if (!cur_addr) {
+		/*
+		 * We have reached the end of the list, add on to end,
+		 * checking to see if we need to combine with last
+		 * block
+		 */
+		if (prev_addr + cvmx_bootmem_phy_get_size(prev_addr) ==
+		    phy_addr) {
+			cvmx_bootmem_phy_set_size(prev_addr,
+						  cvmx_bootmem_phy_get_size
+						  (prev_addr) + size);
+		} else {
+			cvmx_bootmem_phy_set_next(prev_addr, phy_addr);
+			cvmx_bootmem_phy_set_size(phy_addr, size);
+			cvmx_bootmem_phy_set_next(phy_addr, 0);
+		}
+		retval = 1;
+		goto bootmem_free_done;
+	} else {
+		/*
+		 * insert between prev and cur nodes, checking for
+		 * merge with either/both.
+		 */
+		if (prev_addr + cvmx_bootmem_phy_get_size(prev_addr) ==
+		    phy_addr) {
+			/* Merge with previous */
+			cvmx_bootmem_phy_set_size(prev_addr,
+						  cvmx_bootmem_phy_get_size
+						  (prev_addr) + size);
+			if (phy_addr + size == cur_addr) {
+				/* Also merge with current */
+				cvmx_bootmem_phy_set_size(prev_addr,
+							  cvmx_bootmem_phy_get_size
+							  (cur_addr) +
+							  cvmx_bootmem_phy_get_size
+							  (prev_addr));
+				cvmx_bootmem_phy_set_next(prev_addr,
+							  cvmx_bootmem_phy_get_next
+							  (cur_addr));
+			}
+			retval = 1;
+			goto bootmem_free_done;
+		} else if (phy_addr + size == cur_addr) {
+			/* Merge with current */
+			cvmx_bootmem_phy_set_size(phy_addr,
+						  cvmx_bootmem_phy_get_size
+						  (cur_addr) + size);
+			cvmx_bootmem_phy_set_next(phy_addr,
+						  cvmx_bootmem_phy_get_next
+						  (cur_addr));
+			cvmx_bootmem_phy_set_next(prev_addr, phy_addr);
+			retval = 1;
+			goto bootmem_free_done;
+		}
+
+		/* It is a standalone block, add in between prev and cur */
+		cvmx_bootmem_phy_set_size(phy_addr, size);
+		cvmx_bootmem_phy_set_next(phy_addr, cur_addr);
+		cvmx_bootmem_phy_set_next(prev_addr, phy_addr);
+
+	}
+	retval = 1;
+
+bootmem_free_done:
+	if (!(flags & CVMX_BOOTMEM_FLAG_NO_LOCKING))
+		cvmx_spinlock_unlock((cvmx_spinlock_t *) &
+				     (cvmx_bootmem_desc->lock));
+	return retval;
+
+}
+
+void cvmx_bootmem_phy_list_print(void)
+{
+	uint64_t addr;
+
+	addr = cvmx_bootmem_desc->head_addr;
+	cvmx_dprintf("\n\n\nPrinting bootmem block list, descriptor: %p,  "
+		     "head is 0x%llx\n",
+		     cvmx_bootmem_desc, (unsigned long long)addr);
+	cvmx_dprintf("Descriptor version: %d.%d\n",
+		     (int)cvmx_bootmem_desc->major_version,
+		     (int)cvmx_bootmem_desc->minor_version);
+	if (cvmx_bootmem_desc->major_version > 3) {
+		cvmx_dprintf("Warning: Bootmem descriptor version is newer "
+			     "than expected\n");
+	}
+	if (!addr) {
+		cvmx_dprintf("mem list is empty!\n");
+	}
+	while (addr) {
+		cvmx_dprintf("Block address: 0x%08qx, size: 0x%08qx, "
+			     "next: 0x%08qx\n",
+			     (unsigned long long)addr,
+			     (unsigned long long)cvmx_bootmem_phy_get_size(addr),
+			     (unsigned long long)cvmx_bootmem_phy_get_next(addr));
+		addr = cvmx_bootmem_phy_get_next(addr);
+	}
+	cvmx_dprintf("\n\n");
+
+}
+
+uint64_t cvmx_bootmem_phy_available_mem(uint64_t min_block_size)
+{
+	uint64_t addr;
+
+	uint64_t available_mem = 0;
+
+	cvmx_spinlock_lock((cvmx_spinlock_t *) &(cvmx_bootmem_desc->lock));
+	addr = cvmx_bootmem_desc->head_addr;
+	while (addr) {
+		if (cvmx_bootmem_phy_get_size(addr) >= min_block_size)
+			available_mem += cvmx_bootmem_phy_get_size(addr);
+		addr = cvmx_bootmem_phy_get_next(addr);
+	}
+	cvmx_spinlock_unlock((cvmx_spinlock_t *) &(cvmx_bootmem_desc->lock));
+	return available_mem;
+
+}
+
+cvmx_bootmem_named_block_desc_t *cvmx_bootmem_phy_named_block_find(char *name,
+								   uint32_t
+								   flags)
+{
+	unsigned int i;
+	cvmx_bootmem_named_block_desc_t *named_block_array_ptr;
+
+#ifdef DEBUG
+	cvmx_dprintf("cvmx_bootmem_phy_named_block_find: %s\n", name);
+#endif
+	/*
+	 * Lock the structure to make sure that it is not being
+	 * changed while we are examining it.
+	 */
+	if (!(flags & CVMX_BOOTMEM_FLAG_NO_LOCKING))
+		cvmx_spinlock_lock((cvmx_spinlock_t *) &
+				   (cvmx_bootmem_desc->lock));
+
+	/* Use XKPHYS for 64 bit linux */
+	named_block_array_ptr = (cvmx_bootmem_named_block_desc_t *)
+	    cvmx_phys_to_ptr(cvmx_bootmem_desc->named_block_array_addr);
+
+#ifdef DEBUG
+	cvmx_dprintf
+	    ("cvmx_bootmem_phy_named_block_find: named_block_array_ptr: %p\n",
+	     named_block_array_ptr);
+#endif
+	if (cvmx_bootmem_desc->major_version == 3) {
+		for (i = 0; i < cvmx_bootmem_desc->named_block_num_blocks; i++) {
+			if ((name && named_block_array_ptr[i].size
+			     && !strncmp(name, named_block_array_ptr[i].name,
+					 cvmx_bootmem_desc->named_block_name_len
+					 - 1))
+			    || (!name && !named_block_array_ptr[i].size)) {
+				if (!(flags & CVMX_BOOTMEM_FLAG_NO_LOCKING))
+					cvmx_spinlock_unlock(
+						(cvmx_spinlock_t *)&(cvmx_bootmem_desc->lock));
+
+				return &(named_block_array_ptr[i]);
+			}
+		}
+	} else {
+		cvmx_dprintf("ERROR: Incompatible bootmem descriptor "
+			     "version: %d.%d at addr: %p\n",
+			     (int)cvmx_bootmem_desc->major_version,
+			     (int)cvmx_bootmem_desc->minor_version,
+			     cvmx_bootmem_desc);
+	}
+	if (!(flags & CVMX_BOOTMEM_FLAG_NO_LOCKING))
+		cvmx_spinlock_unlock((cvmx_spinlock_t *) &
+				     (cvmx_bootmem_desc->lock));
+
+	return NULL;
+}
+
+int cvmx_bootmem_phy_named_block_free(char *name, uint32_t flags)
+{
+	cvmx_bootmem_named_block_desc_t *named_block_ptr;
+
+	if (cvmx_bootmem_desc->major_version != 3) {
+		cvmx_dprintf("ERROR: Incompatible bootmem descriptor version: "
+			     "%d.%d at addr: %p\n",
+			     (int)cvmx_bootmem_desc->major_version,
+			     (int)cvmx_bootmem_desc->minor_version,
+			     cvmx_bootmem_desc);
+		return 0;
+	}
+#ifdef DEBUG
+	cvmx_dprintf("cvmx_bootmem_phy_named_block_free: %s\n", name);
+#endif
+
+	/*
+	 * Take lock here, as name lookup/block free/name free need to
+	 * be atomic.
+	 */
+	cvmx_spinlock_lock((cvmx_spinlock_t *) &(cvmx_bootmem_desc->lock));
+
+	named_block_ptr =
+	    cvmx_bootmem_phy_named_block_find(name,
+					      CVMX_BOOTMEM_FLAG_NO_LOCKING);
+	if (named_block_ptr) {
+#ifdef DEBUG
+		cvmx_dprintf("cvmx_bootmem_phy_named_block_free: "
+			     "%s, base: 0x%llx, size: 0x%llx\n",
+			     name,
+			     (unsigned long long)named_block_ptr->base_addr,
+			     (unsigned long long)named_block_ptr->size);
+#endif
+		__cvmx_bootmem_phy_free(named_block_ptr->base_addr,
+					named_block_ptr->size,
+					CVMX_BOOTMEM_FLAG_NO_LOCKING);
+		named_block_ptr->size = 0;
+		/* Set size to zero to indicate block not used. */
+	}
+
+	cvmx_spinlock_unlock((cvmx_spinlock_t *) &(cvmx_bootmem_desc->lock));
+
+	return named_block_ptr != NULL;	/* 0 on failure, 1 on success */
+}
+
+int64_t cvmx_bootmem_phy_named_block_alloc(uint64_t size, uint64_t min_addr,
+					   uint64_t max_addr,
+					   uint64_t alignment, char *name,
+					   uint32_t flags)
+{
+	int64_t addr_allocated;
+	cvmx_bootmem_named_block_desc_t *named_block_desc_ptr;
+
+#ifdef DEBUG
+	cvmx_dprintf("cvmx_bootmem_phy_named_block_alloc: size: 0x%llx, "
+		     "min: 0x%llx, max: 0x%llx, align: 0x%llx, name: %s\n",
+		     (unsigned long long)size,
+		     (unsigned long long)min_addr,
+		     (unsigned long long)max_addr,
+		     (unsigned long long)alignment, name);
+#endif
+	if (cvmx_bootmem_desc->major_version != 3) {
+		cvmx_dprintf("ERROR: Incompatible bootmem descriptor "
+			     "version: %d.%d at addr: %p\n",
+			     (int)cvmx_bootmem_desc->major_version,
+			     (int)cvmx_bootmem_desc->minor_version,
+			     cvmx_bootmem_desc);
+		return -1;
+	}
+
+	/*
+	 * Take lock here, as name lookup/block alloc/name add need to
+	 * be atomic.
+	 */
+	if (!(flags & CVMX_BOOTMEM_FLAG_NO_LOCKING))
+		cvmx_spinlock_lock((cvmx_spinlock_t *) &
+				   (cvmx_bootmem_desc->lock));
+
+	/* Get pointer to first available named block descriptor */
+	named_block_desc_ptr =
+	    cvmx_bootmem_phy_named_block_find(NULL,
+					      flags |
+					      CVMX_BOOTMEM_FLAG_NO_LOCKING);
+
+	/* Check to see if name already in use, return error if name
+	 ** not available or no more room for blocks.
+	 */
+	if (cvmx_bootmem_phy_named_block_find
+	    (name, flags | CVMX_BOOTMEM_FLAG_NO_LOCKING)
+	    || !named_block_desc_ptr) {
+		if (!(flags & CVMX_BOOTMEM_FLAG_NO_LOCKING))
+			cvmx_spinlock_unlock((cvmx_spinlock_t *) &
+					     (cvmx_bootmem_desc->lock));
+		return -1;
+	}
+
+	/*
+	 * Round size up to mult of minimum alignment bytes We need
+	 * the actual size allocated to allow for blocks to be
+	 * coallesced when they are freed.  The alloc routine does the
+	 * same rounding up on all allocations.
+	 */
+	size =
+	    (size +
+	     (CVMX_BOOTMEM_ALIGNMENT_SIZE -
+	      1)) & ~(CVMX_BOOTMEM_ALIGNMENT_SIZE - 1);
+
+	addr_allocated =
+	    cvmx_bootmem_phy_alloc(size, min_addr, max_addr, alignment,
+				   flags | CVMX_BOOTMEM_FLAG_NO_LOCKING);
+	if (addr_allocated >= 0) {
+		named_block_desc_ptr->base_addr = addr_allocated;
+		named_block_desc_ptr->size = size;
+		strncpy(named_block_desc_ptr->name, name,
+			cvmx_bootmem_desc->named_block_name_len);
+		named_block_desc_ptr->
+		    name[cvmx_bootmem_desc->named_block_name_len - 1] = 0;
+	}
+
+	if (!(flags & CVMX_BOOTMEM_FLAG_NO_LOCKING))
+		cvmx_spinlock_unlock((cvmx_spinlock_t *) &
+				     (cvmx_bootmem_desc->lock));
+
+	return addr_allocated;
+}
+
+void cvmx_bootmem_phy_named_block_print(void)
+{
+	unsigned int i;
+	int printed = 0;
+
+	/* Use XKPHYS for 64 bit linux */
+	cvmx_bootmem_named_block_desc_t *named_block_array_ptr =
+		(cvmx_bootmem_named_block_desc_t *)
+		cvmx_phys_to_ptr(cvmx_bootmem_desc->named_block_array_addr);
+#ifdef DEBUG
+	cvmx_dprintf("cvmx_bootmem_phy_named_block_print, desc addr: %p\n",
+		     cvmx_bootmem_desc);
+#endif
+	if (cvmx_bootmem_desc->major_version != 3) {
+		cvmx_dprintf("ERROR: Incompatible bootmem descriptor "
+			     "version: %d.%d at addr: %p\n",
+			     (int)cvmx_bootmem_desc->major_version,
+			     (int)cvmx_bootmem_desc->minor_version,
+			     cvmx_bootmem_desc);
+		return;
+	}
+	cvmx_dprintf("List of currently allocated named bootmem blocks:\n");
+	for (i = 0; i < cvmx_bootmem_desc->named_block_num_blocks; i++) {
+		if (named_block_array_ptr[i].size) {
+			printed++;
+			cvmx_dprintf("Name: %s, address: 0x%08qx, size: "
+				     "0x%08qx, index: %d\n",
+				named_block_array_ptr[i].name,
+				(unsigned long long)
+				named_block_array_ptr[i].base_addr,
+				(unsigned long long)named_block_array_ptr[i].size,
+				i);
+
+		}
+	}
+	if (!printed) {
+		cvmx_dprintf("No named bootmem blocks exist.\n");
+	}
+
+}
+
+/* Real physical addresses of memory regions */
+#define OCTEON_DDR0_BASE    (0x0ULL)
+#define OCTEON_DDR0_SIZE    (0x010000000ULL)
+#define OCTEON_DDR1_BASE    (0x410000000ULL)
+#define OCTEON_DDR1_SIZE    (0x010000000ULL)
+#define OCTEON_DDR2_BASE    (0x020000000ULL)
+#define OCTEON_DDR2_SIZE    (0x3e0000000ULL)
+#define OCTEON_MAX_PHY_MEM_SIZE (16*1024*1024*1024ULL)
+int64_t cvmx_bootmem_phy_mem_list_init(uint64_t mem_size,
+				       uint32_t low_reserved_bytes,
+				       cvmx_bootmem_desc_t *desc_buffer)
+{
+	uint64_t cur_block_addr;
+	int64_t addr;
+
+#ifdef DEBUG
+	cvmx_dprintf("cvmx_bootmem_phy_mem_list_init (arg desc ptr: %p, "
+		     "cvmx_bootmem_desc: %p)\n",
+		     desc_buffer, cvmx_bootmem_desc);
+#endif
+
+	/*
+	 * Descriptor buffer needs to be in 32 bit addressable space
+	 * to be compatible with 32 bit applications.
+	 */
+	if (!desc_buffer) {
+		cvmx_dprintf("ERROR: no memory for cvmx_bootmem descriptor "
+			     "provided\n");
+		return 0;
+	}
+
+	if (mem_size > OCTEON_MAX_PHY_MEM_SIZE) {
+		mem_size = OCTEON_MAX_PHY_MEM_SIZE;
+		cvmx_dprintf("ERROR: requested memory size too large, "
+			     "truncating to maximum size\n");
+	}
+
+	if (cvmx_bootmem_desc)
+		return 1;
+
+	/* Initialize cvmx pointer to descriptor */
+	cvmx_bootmem_init(desc_buffer);
+
+	/*
+	 * Set up global pointer to start of list, exclude low 64k for
+	 * exception vectors, space for global descriptor.
+	 */
+	memset(cvmx_bootmem_desc, 0x0, sizeof(cvmx_bootmem_desc_t));
+	/* Set version of bootmem descriptor */
+	cvmx_bootmem_desc->major_version = CVMX_BOOTMEM_DESC_MAJ_VER;
+	cvmx_bootmem_desc->minor_version = CVMX_BOOTMEM_DESC_MIN_VER;
+
+	cur_block_addr = cvmx_bootmem_desc->head_addr =
+	    (OCTEON_DDR0_BASE + low_reserved_bytes);
+
+	cvmx_bootmem_desc->head_addr = 0;
+
+	if (mem_size <= OCTEON_DDR0_SIZE) {
+		__cvmx_bootmem_phy_free(cur_block_addr,
+					mem_size - low_reserved_bytes, 0);
+		goto frees_done;
+	}
+
+	__cvmx_bootmem_phy_free(cur_block_addr,
+				OCTEON_DDR0_SIZE - low_reserved_bytes, 0);
+
+	mem_size -= OCTEON_DDR0_SIZE;
+
+	/* Add DDR2 block next if present */
+	if (mem_size > OCTEON_DDR1_SIZE) {
+		__cvmx_bootmem_phy_free(OCTEON_DDR1_BASE, OCTEON_DDR1_SIZE, 0);
+		__cvmx_bootmem_phy_free(OCTEON_DDR2_BASE,
+					mem_size - OCTEON_DDR1_SIZE, 0);
+	} else {
+		__cvmx_bootmem_phy_free(OCTEON_DDR1_BASE, mem_size, 0);
+
+	}
+frees_done:
+
+	/* Initialize the named block structure */
+	cvmx_bootmem_desc->named_block_name_len = CVMX_BOOTMEM_NAME_LEN;
+	cvmx_bootmem_desc->named_block_num_blocks =
+	    CVMX_BOOTMEM_NUM_NAMED_BLOCKS;
+	cvmx_bootmem_desc->named_block_array_addr = 0;
+
+	/* Allocate this near the top of the low 256 MBytes of memory */
+	addr =
+	    cvmx_bootmem_phy_alloc(CVMX_BOOTMEM_NUM_NAMED_BLOCKS *
+				   sizeof(cvmx_bootmem_named_block_desc_t), 0,
+				   0x10000000, 0, CVMX_BOOTMEM_FLAG_END_ALLOC);
+	if (addr >= 0)
+		cvmx_bootmem_desc->named_block_array_addr = addr;
+
+#ifdef DEBUG
+	cvmx_dprintf("cvmx_bootmem_phy_mem_list_init: "
+		     "named_block_array_addr: 0x%llx)\n",
+		(unsigned long long)cvmx_bootmem_desc->named_block_array_addr);
+#endif
+	if (!cvmx_bootmem_desc->named_block_array_addr) {
+		cvmx_dprintf("FATAL ERROR: unable to allocate memory for "
+			     "bootmem descriptor!\n");
+		return 0;
+	}
+	memset((void *)(unsigned long)cvmx_bootmem_desc->named_block_array_addr,
+	       0x0,
+	       CVMX_BOOTMEM_NUM_NAMED_BLOCKS *
+	       sizeof(cvmx_bootmem_named_block_desc_t));
+
+	return 1;
+}
+
+void cvmx_bootmem_lock(void)
+{
+	cvmx_spinlock_lock((cvmx_spinlock_t *) &(cvmx_bootmem_desc->lock));
+}
+
+void cvmx_bootmem_unlock(void)
+{
+	cvmx_spinlock_unlock((cvmx_spinlock_t *) &(cvmx_bootmem_desc->lock));
+}
+
+void *__cvmx_bootmem_internal_get_desc_ptr(void)
+{
+	return cvmx_bootmem_desc;
+}
diff --git a/arch/mips/cavium-octeon/executive/cvmx-l2c.c b/arch/mips/cavium-octeon/executive/cvmx-l2c.c
new file mode 100644
index 0000000..05d3c77
--- /dev/null
+++ b/arch/mips/cavium-octeon/executive/cvmx-l2c.c
@@ -0,0 +1,736 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as published by
+ * the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful,
+ * but AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or NONINFRINGEMENT.
+ * See the GNU General Public License for more details.
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
+ * Implementation of the Level 2 Cache (L2C) control,
+ * measurement, and debugging facilities.
+ *
+ *
+ */
+#include "cvmx.h"
+#include "cvmx-l2c.h"
+#include "cvmx-spinlock.h"
+
+/*
+ * This spinlock is used internally to ensure that only one core is
+ * performing certain L2 operations at a time.
+ *
+ * NOTE: This only protects calls from within a single application -
+ * if multiple applications or operating systems are running, then it
+ * is up to the user program to coordinate between them.
+ */
+CVMX_SHARED cvmx_spinlock_t cvmx_l2c_spinlock;
+
+static inline int l2_size_half(void)
+{
+	uint64_t val = cvmx_read_csr(CVMX_L2D_FUS3);
+	return !!(val & (1ull << 34));
+}
+
+int cvmx_l2c_get_core_way_partition(uint32_t core)
+{
+	uint32_t field;
+
+	/* Validate the core number */
+	if (core >= cvmx_octeon_num_cores())
+		return -1;
+
+	/*
+	 * Use the lower two bits of the coreNumber to determine the
+	 * bit offset of the UMSK[] field in the L2C_SPAR register.
+	 */
+	field = (core & 0x3) * 8;
+
+	/*
+	 * Return the UMSK[] field from the appropriate L2C_SPAR
+	 * register based on the coreNumber.
+	 */
+
+	switch (core & 0xC) {
+	case 0x0:
+		return (cvmx_read_csr(CVMX_L2C_SPAR0) & (0xFF << field)) >>
+			field;
+	case 0x4:
+		return (cvmx_read_csr(CVMX_L2C_SPAR1) & (0xFF << field)) >>
+			field;
+	case 0x8:
+		return (cvmx_read_csr(CVMX_L2C_SPAR2) & (0xFF << field)) >>
+			field;
+	case 0xC:
+		return (cvmx_read_csr(CVMX_L2C_SPAR3) & (0xFF << field)) >>
+			field;
+	}
+	return 0;
+}
+
+int cvmx_l2c_set_core_way_partition(uint32_t core, uint32_t mask)
+{
+	uint32_t field;
+	uint32_t valid_mask;
+
+	valid_mask = (0x1 << cvmx_l2c_get_num_assoc()) - 1;
+
+	mask &= valid_mask;
+
+	/* A UMSK setting which blocks all L2C Ways is an error. */
+	if (mask == valid_mask)
+		return -1;
+
+	/* Validate the core number */
+	if (core >= cvmx_octeon_num_cores())
+		return -1;
+
+	/* Check to make sure current mask & new mask don't block all ways */
+	if (((mask | cvmx_l2c_get_core_way_partition(core)) & valid_mask) ==
+	    valid_mask)
+		return -1;
+
+	/* Use the lower two bits of core to determine the bit offset of the
+	 * UMSK[] field in the L2C_SPAR register.
+	 */
+	field = (core & 0x3) * 8;
+
+	/* Assign the new mask setting to the UMSK[] field in the appropriate
+	 * L2C_SPAR register based on the core_num.
+	 *
+	 */
+	switch (core & 0xC) {
+	case 0x0:
+		cvmx_write_csr(CVMX_L2C_SPAR0,
+			       (cvmx_read_csr(CVMX_L2C_SPAR0) &
+				~(0xFF << field)) | mask << field);
+		break;
+	case 0x4:
+		cvmx_write_csr(CVMX_L2C_SPAR1,
+			       (cvmx_read_csr(CVMX_L2C_SPAR1) &
+				~(0xFF << field)) | mask << field);
+		break;
+	case 0x8:
+		cvmx_write_csr(CVMX_L2C_SPAR2,
+			       (cvmx_read_csr(CVMX_L2C_SPAR2) &
+				~(0xFF << field)) | mask << field);
+		break;
+	case 0xC:
+		cvmx_write_csr(CVMX_L2C_SPAR3,
+			       (cvmx_read_csr(CVMX_L2C_SPAR3) &
+				~(0xFF << field)) | mask << field);
+		break;
+	}
+	return 0;
+}
+
+int cvmx_l2c_set_hw_way_partition(uint32_t mask)
+{
+	uint32_t valid_mask;
+
+	valid_mask = 0xff;
+
+	if (OCTEON_IS_MODEL(OCTEON_CN58XX) || OCTEON_IS_MODEL(OCTEON_CN38XX)) {
+		if (l2_size_half())
+			valid_mask = 0xf;
+	} else if (l2_size_half())
+		valid_mask = 0x3;
+
+	mask &= valid_mask;
+
+	/* A UMSK setting which blocks all L2C Ways is an error. */
+	if (mask == valid_mask)
+		return -1;
+	/* Check to make sure current mask & new mask don't block all ways */
+	if (((mask | cvmx_l2c_get_hw_way_partition()) & valid_mask) ==
+	    valid_mask)
+		return -1;
+
+	cvmx_write_csr(CVMX_L2C_SPAR4,
+		       (cvmx_read_csr(CVMX_L2C_SPAR4) & ~0xFF) | mask);
+	return 0;
+}
+
+int cvmx_l2c_get_hw_way_partition(void)
+{
+	return cvmx_read_csr(CVMX_L2C_SPAR4) & (0xFF);
+}
+
+void cvmx_l2c_config_perf(uint32_t counter, cvmx_l2c_event_t event,
+			  uint32_t clear_on_read)
+{
+	cvmx_l2c_pfctl_t pfctl;
+
+	pfctl.u64 = cvmx_read_csr(CVMX_L2C_PFCTL);
+
+	switch (counter) {
+	case 0:
+		pfctl.s.cnt0sel = event;
+		pfctl.s.cnt0ena = 1;
+		if (!cvmx_octeon_is_pass1())
+			pfctl.s.cnt0rdclr = clear_on_read;
+		break;
+	case 1:
+		pfctl.s.cnt1sel = event;
+		pfctl.s.cnt1ena = 1;
+		if (!cvmx_octeon_is_pass1())
+			pfctl.s.cnt1rdclr = clear_on_read;
+		break;
+	case 2:
+		pfctl.s.cnt2sel = event;
+		pfctl.s.cnt2ena = 1;
+		if (!cvmx_octeon_is_pass1())
+			pfctl.s.cnt2rdclr = clear_on_read;
+		break;
+	case 3:
+	default:
+		pfctl.s.cnt3sel = event;
+		pfctl.s.cnt3ena = 1;
+		if (!cvmx_octeon_is_pass1())
+			pfctl.s.cnt3rdclr = clear_on_read;
+		break;
+	}
+
+	cvmx_write_csr(CVMX_L2C_PFCTL, pfctl.u64);
+}
+
+uint64_t cvmx_l2c_read_perf(uint32_t counter)
+{
+	switch (counter) {
+	case 0:
+		return cvmx_read_csr(CVMX_L2C_PFC0);
+	case 1:
+		return cvmx_read_csr(CVMX_L2C_PFC1);
+	case 2:
+		return cvmx_read_csr(CVMX_L2C_PFC2);
+	case 3:
+	default:
+		return cvmx_read_csr(CVMX_L2C_PFC3);
+	}
+}
+
+/**
+ * @INTERNAL
+ * Helper function use to fault in cache lines for L2 cache locking
+ *
+ * @addr:   Address of base of memory region to read into L2 cache
+ * @len:    Length (in bytes) of region to fault in
+ */
+static void fault_in(uint64_t addr, int len)
+{
+	volatile char *ptr;
+	volatile char dummy;
+	/*
+	 * Adjust addr and length so we get all cache lines even for
+	 * small ranges spanning two cache lines
+	 */
+	len += addr & CVMX_CACHE_LINE_MASK;
+	addr &= ~CVMX_CACHE_LINE_MASK;
+	ptr = (volatile char *)cvmx_phys_to_ptr(addr);
+	/*
+	 * Invalidate L1 cache to make sure all loads result in data
+	 * being in L2.
+	 */
+	CVMX_DCACHE_INVALIDATE;
+	while (len > 0) {
+		dummy += *ptr;
+		len -= CVMX_CACHE_LINE_SIZE;
+		ptr += CVMX_CACHE_LINE_SIZE;
+	}
+}
+
+int cvmx_l2c_lock_line(uint64_t addr)
+{
+	int retval = 0;
+	cvmx_l2c_dbg_t l2cdbg;
+	cvmx_l2c_lckbase_t lckbase;
+	cvmx_l2c_lckoff_t lckoff;
+	cvmx_l2t_err_t l2t_err;
+	l2cdbg.u64 = 0;
+	lckbase.u64 = 0;
+	lckoff.u64 = 0;
+
+	cvmx_spinlock_lock(&cvmx_l2c_spinlock);
+
+	/* Clear l2t error bits if set */
+	l2t_err.u64 = cvmx_read_csr(CVMX_L2T_ERR);
+	l2t_err.s.lckerr = 1;
+	l2t_err.s.lckerr2 = 1;
+	cvmx_write_csr(CVMX_L2T_ERR, l2t_err.u64);
+
+	addr &= ~CVMX_CACHE_LINE_MASK;
+
+	/* Set this core as debug core */
+	l2cdbg.s.ppnum = cvmx_get_core_num();
+	CVMX_SYNC;
+	cvmx_write_csr(CVMX_L2C_DBG, l2cdbg.u64);
+	cvmx_read_csr(CVMX_L2C_DBG);
+
+	lckoff.s.lck_offset = 0;	/* Only lock 1 line at a time */
+	cvmx_write_csr(CVMX_L2C_LCKOFF, lckoff.u64);
+	cvmx_read_csr(CVMX_L2C_LCKOFF);
+
+	if (((cvmx_l2c_cfg_t) (cvmx_read_csr(CVMX_L2C_CFG))).s.idxalias) {
+		int alias_shift =
+		    CVMX_L2C_IDX_ADDR_SHIFT + 2 * CVMX_L2_SET_BITS - 1;
+		uint64_t addr_tmp =
+		    addr ^ (addr & ((1 << alias_shift) - 1)) >>
+		    CVMX_L2_SET_BITS;
+		lckbase.s.lck_base = addr_tmp >> 7;
+	} else {
+		lckbase.s.lck_base = addr >> 7;
+	}
+
+	lckbase.s.lck_ena = 1;
+	cvmx_write_csr(CVMX_L2C_LCKBASE, lckbase.u64);
+	cvmx_read_csr(CVMX_L2C_LCKBASE);	/* Make sure it gets there */
+
+	fault_in(addr, CVMX_CACHE_LINE_SIZE);
+
+	lckbase.s.lck_ena = 0;
+	cvmx_write_csr(CVMX_L2C_LCKBASE, lckbase.u64);
+	cvmx_read_csr(CVMX_L2C_LCKBASE);	/* Make sure it gets there */
+
+	/* Stop being debug core */
+	cvmx_write_csr(CVMX_L2C_DBG, 0);
+	cvmx_read_csr(CVMX_L2C_DBG);
+
+	l2t_err.u64 = cvmx_read_csr(CVMX_L2T_ERR);
+	if (l2t_err.s.lckerr || l2t_err.s.lckerr2)
+		retval = 1;	/* We were unable to lock the line */
+
+	cvmx_spinlock_unlock(&cvmx_l2c_spinlock);
+
+	return retval;
+}
+
+int cvmx_l2c_lock_mem_region(uint64_t start, uint64_t len)
+{
+	int retval = 0;
+
+	/* Round start/end to cache line boundaries */
+	len += start & CVMX_CACHE_LINE_MASK;
+	start &= ~CVMX_CACHE_LINE_MASK;
+	len = (len + CVMX_CACHE_LINE_MASK) & ~CVMX_CACHE_LINE_MASK;
+
+	while (len) {
+		retval += cvmx_l2c_lock_line(start);
+		start += CVMX_CACHE_LINE_SIZE;
+		len -= CVMX_CACHE_LINE_SIZE;
+	}
+
+	return retval;
+}
+
+void cvmx_l2c_flush(void)
+{
+	uint64_t assoc, set;
+	uint64_t n_assoc, n_set;
+	cvmx_l2c_dbg_t l2cdbg;
+
+	cvmx_spinlock_lock(&cvmx_l2c_spinlock);
+
+	l2cdbg.u64 = 0;
+	if (!OCTEON_IS_MODEL(OCTEON_CN30XX))
+		l2cdbg.s.ppnum = cvmx_get_core_num();
+	l2cdbg.s.finv = 1;
+	n_set = CVMX_L2_SETS;
+	n_assoc = l2_size_half() ? (CVMX_L2_ASSOC / 2) : CVMX_L2_ASSOC;
+	for (set = 0; set < n_set; set++) {
+		for (assoc = 0; assoc < n_assoc; assoc++) {
+			l2cdbg.s.set = assoc;
+			/* Enter debug mode, and make sure all other
+			 ** writes complete before we enter debug
+			 ** mode */
+			CVMX_SYNCW;
+			cvmx_write_csr(CVMX_L2C_DBG, l2cdbg.u64);
+			cvmx_read_csr(CVMX_L2C_DBG);
+
+			CVMX_PREPARE_FOR_STORE(CVMX_ADD_SEG
+					       (CVMX_MIPS_SPACE_XKPHYS,
+						set * CVMX_CACHE_LINE_SIZE), 0);
+			CVMX_SYNCW;	/* Push STF out to L2 */
+			/* Exit debug mode */
+			CVMX_SYNC;
+			cvmx_write_csr(CVMX_L2C_DBG, 0);
+			cvmx_read_csr(CVMX_L2C_DBG);
+		}
+	}
+
+	cvmx_spinlock_unlock(&cvmx_l2c_spinlock);
+}
+
+int cvmx_l2c_unlock_line(uint64_t address)
+{
+	int assoc;
+	cvmx_l2c_tag_t tag;
+	cvmx_l2c_dbg_t l2cdbg;
+	uint32_t tag_addr;
+
+	uint32_t index = cvmx_l2c_address_to_index(address);
+
+	cvmx_spinlock_lock(&cvmx_l2c_spinlock);
+	/* Compute portion of address that is stored in tag */
+	tag_addr =
+	    ((address >> CVMX_L2C_TAG_ADDR_ALIAS_SHIFT) &
+	     ((1 << CVMX_L2C_TAG_ADDR_ALIAS_SHIFT) - 1));
+	for (assoc = 0; assoc < CVMX_L2_ASSOC; assoc++) {
+		tag = cvmx_get_l2c_tag(assoc, index);
+
+		if (tag.s.V && (tag.s.addr == tag_addr)) {
+			l2cdbg.u64 = 0;
+			l2cdbg.s.ppnum = cvmx_get_core_num();
+			l2cdbg.s.set = assoc;
+			l2cdbg.s.finv = 1;
+
+			CVMX_SYNC;
+			/* Enter debug mode */
+			cvmx_write_csr(CVMX_L2C_DBG, l2cdbg.u64);
+			cvmx_read_csr(CVMX_L2C_DBG);
+
+			CVMX_PREPARE_FOR_STORE(CVMX_ADD_SEG
+					       (CVMX_MIPS_SPACE_XKPHYS,
+						address), 0);
+			CVMX_SYNC;
+			/* Exit debug mode */
+			cvmx_write_csr(CVMX_L2C_DBG, 0);
+			cvmx_read_csr(CVMX_L2C_DBG);
+			cvmx_spinlock_unlock(&cvmx_l2c_spinlock);
+			return tag.s.L;
+		}
+	}
+	cvmx_spinlock_unlock(&cvmx_l2c_spinlock);
+	return 0;
+}
+
+int cvmx_l2c_unlock_mem_region(uint64_t start, uint64_t len)
+{
+	int num_unlocked = 0;
+	/* Round start/end to cache line boundaries */
+	len += start & CVMX_CACHE_LINE_MASK;
+	start &= ~CVMX_CACHE_LINE_MASK;
+	len = (len + CVMX_CACHE_LINE_MASK) & ~CVMX_CACHE_LINE_MASK;
+	while (len > 0) {
+		num_unlocked += cvmx_l2c_unlock_line(start);
+		start += CVMX_CACHE_LINE_SIZE;
+		len -= CVMX_CACHE_LINE_SIZE;
+	}
+
+	return num_unlocked;
+}
+
+/*
+ * Internal l2c tag types.  These are converted to a generic structure
+ * that can be used on all chips.
+ */
+typedef union {
+	uint64_t u64;
+	struct cvmx_l2c_tag_cn50xx {
+		uint64_t reserved:40;
+		uint64_t V:1;	/* Line valid */
+		uint64_t D:1;	/* Line dirty */
+		uint64_t L:1;	/* Line locked */
+		uint64_t U:1;	/* Use, LRU eviction */
+		uint64_t addr:20;	/* Phys mem addr (33..14) */
+	} cn50xx;
+	struct cvmx_l2c_tag_cn30xx {
+		uint64_t reserved:41;
+		uint64_t V:1;	/* Line valid */
+		uint64_t D:1;	/* Line dirty */
+		uint64_t L:1;	/* Line locked */
+		uint64_t U:1;	/* Use, LRU eviction */
+		uint64_t addr:19;	/* Phys mem addr (33..15) */
+	} cn30xx;
+	struct cvmx_l2c_tag_cn31xx {
+		uint64_t reserved:42;
+		uint64_t V:1;	/* Line valid */
+		uint64_t D:1;	/* Line dirty */
+		uint64_t L:1;	/* Line locked */
+		uint64_t U:1;	/* Use, LRU eviction */
+		uint64_t addr:18;	/* Phys mem addr (33..16) */
+	} cn31xx;
+	struct cvmx_l2c_tag_cn38xx {
+		uint64_t reserved:43;
+		uint64_t V:1;	/* Line valid */
+		uint64_t D:1;	/* Line dirty */
+		uint64_t L:1;	/* Line locked */
+		uint64_t U:1;	/* Use, LRU eviction */
+		uint64_t addr:17;	/* Phys mem addr (33..17) */
+	} cn38xx;
+	struct cvmx_l2c_tag_cn58xx {
+		uint64_t reserved:44;
+		uint64_t V:1;	/* Line valid */
+		uint64_t D:1;	/* Line dirty */
+		uint64_t L:1;	/* Line locked */
+		uint64_t U:1;	/* Use, LRU eviction */
+		uint64_t addr:16;	/* Phys mem addr (33..18) */
+	} cn58xx;
+	struct cvmx_l2c_tag_cn58xx cn56xx;	/* 2048 sets */
+	struct cvmx_l2c_tag_cn31xx cn52xx;	/* 512 sets */
+} __cvmx_l2c_tag_t;
+
+/**
+ * @INTERNAL
+ * Function to read a L2C tag.  This code make the current core
+ * the 'debug core' for the L2.  This code must only be executed by
+ * 1 core at a time.
+ *
+ * @assoc:  Association (way) of the tag to dump
+ * @index:  Index of the cacheline
+ *
+ * Returns The Octeon model specific tag structure.  This is
+ *         translated by a wrapper function to a generic form that is
+ *         easier for applications to use.
+ */
+static __cvmx_l2c_tag_t __read_l2_tag(uint64_t assoc, uint64_t index)
+{
+
+	uint64_t debug_tag_addr = (((1ULL << 63) | (index << 7)) + 96);
+	uint64_t core = cvmx_get_core_num();
+	__cvmx_l2c_tag_t tag_val;
+	uint64_t dbg_addr = CVMX_L2C_DBG;
+	unsigned long flags;
+
+	cvmx_l2c_dbg_t debug_val;
+	debug_val.u64 = 0;
+	/*
+	 * For low core count parts, the core number is always small enough
+	 * to stay in the correct field and not set any reserved bits.
+	 */
+	debug_val.s.ppnum = core;
+	debug_val.s.l2t = 1;
+	debug_val.s.set = assoc;
+	/*
+	 * Make sure core is quiet (no prefetches, etc.) before
+	 * entering debug mode.
+	 */
+	CVMX_SYNC;
+	/* Flush L1 to make sure debug load misses L1 */
+	CVMX_DCACHE_INVALIDATE;
+
+	local_irq_save(flags);
+
+	/*
+	 * The following must be done in assembly as when in debug
+	 * mode all data loads from L2 return special debug data, not
+	 * normal memory contents.  Also, interrupts must be
+	 * disabled, since if an interrupt occurs while in debug mode
+	 * the ISR will get debug data from all its memory reads
+	 * instead of the contents of memory
+	 */
+
+	asm volatile (".set push              \n"
+		"        .set mips64              \n"
+		"        .set noreorder           \n"
+		/* Enter debug mode, wait for store */
+		"        sd    %[dbg_val], 0(%[dbg_addr])  \n"
+		"        ld    $0, 0(%[dbg_addr]) \n"
+		/* Read L2C tag data */
+		"        ld    %[tag_val], 0(%[tag_addr]) \n"
+		/* Exit debug mode, wait for store */
+		"        sd    $0, 0(%[dbg_addr])  \n"
+		"        ld    $0, 0(%[dbg_addr]) \n"
+		/* Invalidate dcache to discard debug data */
+		"        cache 9, 0($0) \n"
+		"        .set pop" :
+		[tag_val] "=r"(tag_val) : [dbg_addr] "r"(dbg_addr),
+		[dbg_val] "r"(debug_val),
+		[tag_addr] "r"(debug_tag_addr) : "memory");
+
+	local_irq_restore(flags);
+	return tag_val;
+
+}
+
+cvmx_l2c_tag_t cvmx_l2c_get_tag(uint32_t association, uint32_t index)
+{
+	__cvmx_l2c_tag_t tmp_tag;
+	cvmx_l2c_tag_t tag;
+	tag.u64 = 0;
+
+	if ((int)association >= cvmx_l2c_get_num_assoc()) {
+		cvmx_dprintf
+		    ("ERROR: cvmx_get_l2c_tag association out of range\n");
+		return tag;
+	}
+	if ((int)index >= cvmx_l2c_get_num_sets()) {
+		cvmx_dprintf ("ERROR: cvmx_get_l2c_tag "
+			      "index out of range (arg: %d, max: %d\n",
+		     index, cvmx_l2c_get_num_sets());
+		return tag;
+	}
+	/* __read_l2_tag is intended for internal use only */
+	tmp_tag = __read_l2_tag(association, index);
+
+	/*
+	 * Convert all tag structure types to generic version, as it
+	 * can represent all models.
+	 */
+	if (OCTEON_IS_MODEL(OCTEON_CN58XX) || OCTEON_IS_MODEL(OCTEON_CN56XX)) {
+		tag.s.V = tmp_tag.cn58xx.V;
+		tag.s.D = tmp_tag.cn58xx.D;
+		tag.s.L = tmp_tag.cn58xx.L;
+		tag.s.U = tmp_tag.cn58xx.U;
+		tag.s.addr = tmp_tag.cn58xx.addr;
+	} else if (OCTEON_IS_MODEL(OCTEON_CN38XX)) {
+		tag.s.V = tmp_tag.cn38xx.V;
+		tag.s.D = tmp_tag.cn38xx.D;
+		tag.s.L = tmp_tag.cn38xx.L;
+		tag.s.U = tmp_tag.cn38xx.U;
+		tag.s.addr = tmp_tag.cn38xx.addr;
+	} else if (OCTEON_IS_MODEL(OCTEON_CN31XX)
+		   || OCTEON_IS_MODEL(OCTEON_CN52XX)) {
+		tag.s.V = tmp_tag.cn31xx.V;
+		tag.s.D = tmp_tag.cn31xx.D;
+		tag.s.L = tmp_tag.cn31xx.L;
+		tag.s.U = tmp_tag.cn31xx.U;
+		tag.s.addr = tmp_tag.cn31xx.addr;
+	} else if (OCTEON_IS_MODEL(OCTEON_CN30XX)) {
+		tag.s.V = tmp_tag.cn30xx.V;
+		tag.s.D = tmp_tag.cn30xx.D;
+		tag.s.L = tmp_tag.cn30xx.L;
+		tag.s.U = tmp_tag.cn30xx.U;
+		tag.s.addr = tmp_tag.cn30xx.addr;
+	} else if (OCTEON_IS_MODEL(OCTEON_CN50XX)) {
+		tag.s.V = tmp_tag.cn50xx.V;
+		tag.s.D = tmp_tag.cn50xx.D;
+		tag.s.L = tmp_tag.cn50xx.L;
+		tag.s.U = tmp_tag.cn50xx.U;
+		tag.s.addr = tmp_tag.cn50xx.addr;
+	} else {
+		cvmx_dprintf("Unsupported OCTEON Model in %s\n", __FUNCTION__);
+	}
+
+	return tag;
+}
+
+uint32_t cvmx_l2c_address_to_index(uint64_t addr)
+{
+	uint64_t idx = addr >> CVMX_L2C_IDX_ADDR_SHIFT;
+	cvmx_l2c_cfg_t l2c_cfg;
+	l2c_cfg.u64 = cvmx_read_csr(CVMX_L2C_CFG);
+
+	if (l2c_cfg.s.idxalias) {
+		idx ^=
+		    ((addr & CVMX_L2C_ALIAS_MASK) >>
+		     CVMX_L2C_TAG_ADDR_ALIAS_SHIFT);
+	}
+	idx &= CVMX_L2C_IDX_MASK;
+	return idx;
+}
+
+int cvmx_l2c_get_cache_size_bytes(void)
+{
+	return cvmx_l2c_get_num_sets() * cvmx_l2c_get_num_assoc() *
+		CVMX_CACHE_LINE_SIZE;
+}
+
+/**
+ * Return log base 2 of the number of sets in the L2 cache
+ * Returns
+ */
+int cvmx_l2c_get_set_bits(void)
+{
+	int l2_set_bits;
+	if (OCTEON_IS_MODEL(OCTEON_CN56XX) || OCTEON_IS_MODEL(OCTEON_CN58XX))
+		l2_set_bits = 11;	/* 2048 sets */
+	else if (OCTEON_IS_MODEL(OCTEON_CN38XX))
+		l2_set_bits = 10;	/* 1024 sets */
+	else if (OCTEON_IS_MODEL(OCTEON_CN31XX)
+		 || OCTEON_IS_MODEL(OCTEON_CN52XX))
+		l2_set_bits = 9;	/* 512 sets */
+	else if (OCTEON_IS_MODEL(OCTEON_CN30XX))
+		l2_set_bits = 8;	/* 256 sets */
+	else if (OCTEON_IS_MODEL(OCTEON_CN50XX))
+		l2_set_bits = 7;	/* 128 sets */
+	else {
+		cvmx_dprintf("Unsupported OCTEON Model in %s\n", __FUNCTION__);
+		l2_set_bits = 11;	/* 2048 sets */
+	}
+	return l2_set_bits;
+
+}
+
+/* Return the number of sets in the L2 Cache */
+int cvmx_l2c_get_num_sets(void)
+{
+	return 1 << cvmx_l2c_get_set_bits();
+}
+
+/* Return the number of associations in the L2 Cache */
+int cvmx_l2c_get_num_assoc(void)
+{
+	int l2_assoc;
+	if (OCTEON_IS_MODEL(OCTEON_CN56XX) ||
+	    OCTEON_IS_MODEL(OCTEON_CN52XX) ||
+	    OCTEON_IS_MODEL(OCTEON_CN58XX) ||
+	    OCTEON_IS_MODEL(OCTEON_CN50XX) || OCTEON_IS_MODEL(OCTEON_CN38XX))
+		l2_assoc = 8;
+	else if (OCTEON_IS_MODEL(OCTEON_CN31XX) ||
+		 OCTEON_IS_MODEL(OCTEON_CN30XX))
+		l2_assoc = 4;
+	else {
+		cvmx_dprintf("Unsupported OCTEON Model in %s\n", __FUNCTION__);
+		l2_assoc = 8;
+	}
+
+	/* Check to see if part of the cache is disabled */
+	if (cvmx_fuse_read(265))
+		l2_assoc = l2_assoc >> 2;
+	else if (cvmx_fuse_read(264))
+		l2_assoc = l2_assoc >> 1;
+
+	return l2_assoc;
+}
+
+/**
+ * Flush a line from the L2 cache
+ * This should only be called from one core at a time, as this routine
+ * sets the core to the 'debug' core in order to flush the line.
+ *
+ * @assoc:  Association (or way) to flush
+ * @index:  Index to flush
+ */
+void cvmx_l2c_flush_line(uint32_t assoc, uint32_t index)
+{
+	cvmx_l2c_dbg_t l2cdbg;
+
+	l2cdbg.u64 = 0;
+	l2cdbg.s.ppnum = cvmx_get_core_num();
+	l2cdbg.s.finv = 1;
+
+	l2cdbg.s.set = assoc;
+	/*
+	 * Enter debug mode, and make sure all other writes complete
+	 * before we enter debug mode.
+	 */
+	asm volatile ("sync":::"memory");
+	cvmx_write_csr(CVMX_L2C_DBG, l2cdbg.u64);
+	cvmx_read_csr(CVMX_L2C_DBG);
+
+	CVMX_PREPARE_FOR_STORE(((1ULL << 63) + (index) * 128), 0);
+	/* Exit debug mode */
+	asm volatile ("sync":::"memory");
+	cvmx_write_csr(CVMX_L2C_DBG, 0);
+	cvmx_read_csr(CVMX_L2C_DBG);
+}
diff --git a/arch/mips/cavium-octeon/executive/cvmx-sysinfo.c b/arch/mips/cavium-octeon/executive/cvmx-sysinfo.c
new file mode 100644
index 0000000..da0e48e
--- /dev/null
+++ b/arch/mips/cavium-octeon/executive/cvmx-sysinfo.c
@@ -0,0 +1,117 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as published by
+ * the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful,
+ * but AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or NONINFRINGEMENT.
+ * See the GNU General Public License for more details.
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
+ * This module provides system/board/application information obtained
+ * by the bootloader.
+ */
+
+#include "cvmx.h"
+#include "cvmx-spinlock.h"
+#include "cvmx-sysinfo.h"
+
+/**
+ * This structure defines the private state maintained by sysinfo module.
+ *
+ */
+CVMX_SHARED static struct {
+	cvmx_sysinfo_t sysinfo;	   /* system information */
+	cvmx_spinlock_t lock;	   /* mutex spinlock */
+
+} state = {
+	.lock = CVMX_SPINLOCK_UNLOCKED_INITIALIZER
+};
+
+
+/*
+ * Global variables that define the min/max of the memory region set
+ * up for 32 bit userspace access.
+ */
+uint64_t linux_mem32_min;
+uint64_t linux_mem32_max;
+uint64_t linux_mem32_wired;
+uint64_t linux_mem32_offset;
+
+/**
+ * This function returns the application information as obtained
+ * by the bootloader.  This provides the core mask of the cores
+ * running the same application image, as well as the physical
+ * memory regions available to the core.
+ *
+ * Returns  Pointer to the boot information structure
+ *
+ */
+cvmx_sysinfo_t *cvmx_sysinfo_get(void)
+{
+	return &(state.sysinfo);
+}
+
+/**
+ * This function is used in non-simple executive environments (such as
+ * Linux kernel, u-boot, etc.)  to configure the minimal fields that
+ * are required to use simple executive files directly.
+ *
+ * Locking (if required) must be handled outside of this
+ * function
+ *
+ * @phy_mem_desc_ptr:
+ *                   Pointer to global physical memory descriptor
+ *                   (bootmem descriptor) @board_type: Octeon board
+ *                   type enumeration
+ *
+ * @board_rev_major:
+ *                   Board major revision
+ * @board_rev_minor:
+ *                   Board minor revision
+ * @cpu_clock_hz:
+ *                   CPU clock freqency in hertz
+ *
+ * Returns 0: Failure
+ *         1: success
+ */
+int cvmx_sysinfo_minimal_initialize(void *phy_mem_desc_ptr,
+				    uint16_t board_type,
+				    uint8_t board_rev_major,
+				    uint8_t board_rev_minor,
+				    uint32_t cpu_clock_hz)
+{
+
+	/* The sysinfo structure was already initialized */
+	if (state.sysinfo.board_type)
+		return 0;
+
+	memset(&(state.sysinfo), 0x0, sizeof(state.sysinfo));
+	state.sysinfo.phy_mem_desc_ptr = phy_mem_desc_ptr;
+	state.sysinfo.board_type = board_type;
+	state.sysinfo.board_rev_major = board_rev_major;
+	state.sysinfo.board_rev_minor = board_rev_minor;
+	state.sysinfo.cpu_clock_hz = cpu_clock_hz;
+
+	return 1;
+}
+
diff --git a/arch/mips/cavium-octeon/executive/octeon-model.c b/arch/mips/cavium-octeon/executive/octeon-model.c
new file mode 100644
index 0000000..d6210f8
--- /dev/null
+++ b/arch/mips/cavium-octeon/executive/octeon-model.c
@@ -0,0 +1,346 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as published by
+ * the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful,
+ * but AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or NONINFRINGEMENT.
+ * See the GNU General Public License for more details.
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
+ * File defining functions for working with different Octeon
+ * models.
+ *
+ */
+#include "cvmx.h"
+
+#include "cvmx-warn.h"
+
+/**
+ * Given the chip processor ID from COP0, this function returns a
+ * string representing the chip model number. The string is of the
+ * form CNXXXXpX.X-FREQ-SUFFIX.
+ * - XXXX = The chip model number
+ * - X.X = Chip pass number
+ * - FREQ = Current frequency in Mhz
+ * - SUFFIX = NSP, EXP, SCP, SSP, or CP
+ *
+ * @chip_id: Chip ID
+ *
+ * Returns Model string
+ */
+const char *octeon_model_get_string(uint32_t chip_id)
+{
+	static char buffer[32];
+	return octeon_model_get_string_buffer(chip_id, buffer);
+}
+
+/*
+ * Version of octeon_model_get_string() that takes buffer as argument,
+ * as running early in u-boot static/global variables don't work when
+ * running from flash.
+ */
+const char *octeon_model_get_string_buffer(uint32_t chip_id, char *buffer)
+{
+	extern uint64_t octeon_get_clock_rate(void);
+	const char *family;
+	const char *core_model;
+	char pass[4];
+	int clock_mhz;
+	const char *suffix;
+	cvmx_l2d_fus3_t fus3;
+	int num_cores;
+	cvmx_mio_fus_dat2_t fus_dat2;
+	cvmx_mio_fus_dat3_t fus_dat3;
+	char fuse_model[10];
+	uint32_t fuse_data = 0;
+
+	fus3.u64 = cvmx_read_csr(CVMX_L2D_FUS3);
+	fus_dat2.u64 = cvmx_read_csr(CVMX_MIO_FUS_DAT2);
+	fus_dat3.u64 = cvmx_read_csr(CVMX_MIO_FUS_DAT3);
+
+	num_cores = cvmx_octeon_num_cores();
+
+	/* Make sure the non existant devices look disabled */
+	switch ((chip_id >> 8) & 0xff) {
+	case 6:		/* CN50XX */
+	case 2:		/* CN30XX */
+		fus_dat3.s.nodfa_dte = 1;
+		fus_dat3.s.nozip = 1;
+		break;
+	case 4:		/* CN57XX or CN56XX */
+		fus_dat3.s.nodfa_dte = 1;
+		break;
+	default:
+		break;
+	}
+
+	/* Make a guess at the suffix */
+	/* NSP = everything */
+	/* EXP = No crypto */
+	/* SCP = No DFA, No zip */
+	/* CP = No DFA, No crypto, No zip */
+	if (fus_dat3.s.nodfa_dte) {
+		if (fus_dat2.s.nocrypto)
+			suffix = "CP";
+		else
+			suffix = "SCP";
+	} else if (fus_dat2.s.nocrypto)
+		suffix = "EXP";
+	else
+		suffix = "NSP";
+
+	/*
+	 * Assume pass number is encoded using <5:3><2:0>. Exceptions
+	 * will be fixed later.
+	 */
+	sprintf(pass, "%d.%d",
+	       	(int)((chip_id >> 3) & 7) + 1, (int)chip_id & 7);
+
+	/*
+	 * Use the number of cores to determine the last 2 digits of
+	 * the model number. There are some exceptions that are fixed
+	 * later.
+	 */
+	switch (num_cores) {
+	case 16:
+		core_model = "60";
+		break;
+	case 15:
+	case 14:
+		core_model = "55";
+		break;
+	case 13:
+	case 12:
+		core_model = "50";
+		break;
+	case 11:
+	case 10:
+		core_model = "45";
+		break;
+	case 9:
+		core_model = "42";
+		break;
+	case 8:
+		core_model = "40";
+		break;
+	case 7:
+	case 6:
+		core_model = "34";
+		break;
+	case 5:
+		core_model = "32";
+		break;
+	case 4:
+		core_model = "30";
+		break;
+	case 3:
+		core_model = "25";
+		break;
+	case 2:
+		core_model = "20";
+		break;
+	case 1:
+		core_model = "10";
+		break;
+	default:
+		core_model = "XX";
+		break;
+	}
+
+	/* Now figure out the family, the first two digits */
+	switch ((chip_id >> 8) & 0xff) {
+	case 0:		/* CN38XX, CN37XX or CN36XX */
+		if (fus3.cn38xx.crip_512k) {
+			/*
+			 * For some unknown reason, the 16 core one is
+			 * called 37 instead of 36.
+			 */
+			if (num_cores >= 16)
+				family = "37";
+			else
+				family = "36";
+		} else
+			family = "38";
+		/*
+		 * This series of chips didn't follow the standard
+		 * pass numbering.
+		 */
+		switch (chip_id & 0xf) {
+		case 0:
+			strcpy(pass, "1.X");
+			break;
+		case 1:
+			strcpy(pass, "2.X");
+			break;
+		case 3:
+			strcpy(pass, "3.X");
+			break;
+		default:
+			strcpy(pass, "X.X");
+			break;
+		}
+		break;
+	case 1:		/* CN31XX or CN3020 */
+		if ((chip_id & 0x10) || fus3.cn31xx.crip_128k)
+			family = "30";
+		else
+			family = "31";
+		/*
+		 * This series of chips didn't follow the standard
+		 * pass numbering.
+		 */
+		switch (chip_id & 0xf) {
+		case 0:
+			strcpy(pass, "1.0");
+			break;
+		case 2:
+			strcpy(pass, "1.1");
+			break;
+		default:
+			strcpy(pass, "X.X");
+			break;
+		}
+		break;
+	case 2:		/* CN3010 or CN3005 */
+		family = "30";
+		/* A chip with half cache is an 05 */
+		if (fus3.cn30xx.crip_64k)
+			core_model = "05";
+		/*
+		 * This series of chips didn't follow the standard
+		 * pass numbering.
+		 */
+		switch (chip_id & 0xf) {
+		case 0:
+			strcpy(pass, "1.0");
+			break;
+		case 2:
+			strcpy(pass, "1.1");
+			break;
+		default:
+			strcpy(pass, "X.X");
+			break;
+		}
+		break;
+	case 3:		/* CN58XX */
+		family = "58";
+		/* Special case. 4 core, no crypto */
+		if ((num_cores == 4) && fus_dat2.cn38xx.nocrypto)
+			core_model = "29";
+
+		/* Pass 1 uses different encodings for pass numbers */
+		if ((chip_id & 0xFF) < 0x8) {
+			switch (chip_id & 0x3) {
+			case 0:
+				strcpy(pass, "1.0");
+				break;
+			case 1:
+				strcpy(pass, "1.1");
+				break;
+			case 3:
+				strcpy(pass, "1.2");
+				break;
+			default:
+				strcpy(pass, "1.X");
+				break;
+			}
+		}
+		break;
+	case 4:		/* CN57XX, CN56XX, CN55XX, CN54XX */
+		if (fus_dat2.cn56xx.raid_en) {
+			if (fus3.cn56xx.crip_1024k)
+				family = "55";
+			else
+				family = "57";
+			if (fus_dat2.cn56xx.nocrypto)
+				suffix = "SP";
+			else
+				suffix = "SSP";
+		} else {
+			if (fus_dat2.cn56xx.nocrypto)
+				suffix = "CP";
+			else {
+				suffix = "NSP";
+				if (fus_dat3.s.nozip)
+					suffix = "SCP";
+			}
+			if (fus3.cn56xx.crip_1024k)
+				family = "54";
+			else
+				family = "56";
+		}
+		break;
+	case 6:		/* CN50XX */
+		family = "50";
+		break;
+	case 7:		/* CN52XX */
+		family = "52";
+		break;
+	case 8:		/* CN51XX */
+		family = "51";
+		break;
+	default:
+		family = "XX";
+		core_model = "XX";
+		strcpy(pass, "X.X");
+		suffix = "XXX";
+		break;
+	}
+
+	clock_mhz = octeon_get_clock_rate() / 1000000;
+
+	/* Check for model in fuses, overrides normal decode */
+	fuse_data |= cvmx_fuse_read_byte(51);
+	fuse_data = fuse_data << 8;
+	fuse_data |= cvmx_fuse_read_byte(50);
+	fuse_data = fuse_data << 8;
+	fuse_data |= cvmx_fuse_read_byte(49);
+	fuse_data = fuse_data << 8;
+	fuse_data |= cvmx_fuse_read_byte(48);
+	if (fuse_data & 0x7ffff) {
+		int model = fuse_data & 0x3fff;
+		int suffix = (fuse_data >> 14) & 0x1f;
+		if (suffix && model) {
+			/* Have both number and suffix in fuses, so both */
+			sprintf(fuse_model, "%d%c", model, 'A' + suffix - 1);
+			core_model = "";
+			family = fuse_model;
+		} else if (suffix && !model) {
+			/*
+			 * Only have suffix, so add suffix to 'normal'
+			 * model number.
+			 */
+			sprintf(fuse_model, "%s%c", core_model,
+				'A' + suffix - 1);
+			core_model = fuse_model;
+		} else {
+			/* Don't have suffix, so just use model from fuses */
+			sprintf(fuse_model, "%d", model);
+			core_model = "";
+			family = fuse_model;
+		}
+	}
+	sprintf(buffer, "CN%s%sp%s-%d-%s",
+		family, core_model, pass, clock_mhz, suffix);
+	return buffer;
+}
diff --git a/arch/mips/include/asm/octeon/cvmx-asm.h b/arch/mips/include/asm/octeon/cvmx-asm.h
new file mode 100644
index 0000000..606f363
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-asm.h
@@ -0,0 +1,446 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as published by
+ * the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful,
+ * but AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or NONINFRINGEMENT.
+ * See the GNU General Public License for more details.
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
+ * This is file defines ASM primitives for the executive.
+
+ *
+ *
+ */
+#ifndef __CVMX_ASM_H__
+#define __CVMX_ASM_H__
+
+#include "octeon-model.h"
+
+/* other useful stuff */
+#define CVMX_BREAK asm volatile ("break")
+#define CVMX_SYNC asm volatile ("sync" : : :"memory")
+/* String version of SYNCW macro for using in inline asm constructs */
+#define CVMX_SYNCW_STR "syncw\nsyncw\n"
+#ifdef __OCTEON__
+
+/* Deprecated, will be removed in future release */
+#define CVMX_SYNCIO asm volatile ("nop")
+
+#define CVMX_SYNCIOBDMA asm volatile ("synciobdma" : : :"memory")
+
+/* Deprecated, will be removed in future release */
+#define CVMX_SYNCIOALL asm volatile ("nop")
+
+/*
+ * We actually use two syncw instructions in a row when we need a write
+ * memory barrier. This is because the CN3XXX series of Octeons have
+ * errata Core-401. This can cause a single syncw to not enforce
+ * ordering under very rare conditions. Even if it is rare, better safe
+ * than sorry.
+ */
+#define CVMX_SYNCW asm volatile ("syncw\n\tsyncw" : : :"memory")
+
+/*
+ * Define new sync instructions to be normal SYNC instructions for
+ * operating systems that use threads.
+ */
+#define CVMX_SYNCWS CVMX_SYNCW
+#define CVMX_SYNCS  CVMX_SYNC
+#define CVMX_SYNCWS_STR CVMX_SYNCW_STR
+#else
+/*
+ * Not using a Cavium compiler, always use the slower sync so the
+ * assembler stays happy.
+ */
+/* Deprecated, will be removed in future release */
+#define CVMX_SYNCIO asm volatile ("nop")
+
+#define CVMX_SYNCIOBDMA asm volatile ("sync" : : :"memory")
+
+/* Deprecated, will be removed in future release */
+#define CVMX_SYNCIOALL asm volatile ("nop")
+
+#define CVMX_SYNCW asm volatile ("sync" : : :"memory")
+#define CVMX_SYNCWS CVMX_SYNCW
+#define CVMX_SYNCS  CVMX_SYNC
+#define CVMX_SYNCWS_STR CVMX_SYNCW_STR
+#endif
+#define CVMX_SYNCI(address, offset) asm volatile ("synci " CVMX_TMP_STR(offset) "(%[rbase])" : : [rbase] "d" (address))
+#define CVMX_PREFETCH0(address) CVMX_PREFETCH(address, 0)
+#define CVMX_PREFETCH128(address) CVMX_PREFETCH(address, 128)
+/* a normal prefetch */
+#define CVMX_PREFETCH(address, offset) CVMX_PREFETCH_PREF0(address, offset)
+/* normal prefetches that use the pref instruction */
+#define CVMX_PREFETCH_PREF0(address, offset) asm volatile ("pref 0, " CVMX_TMP_STR(offset) "(%[rbase])" : : [rbase] "d" (address))
+#define CVMX_PREFETCH_PREF1(address, offset) asm volatile ("pref 1, " CVMX_TMP_STR(offset) "(%[rbase])" : : [rbase] "d" (address))
+#define CVMX_PREFETCH_PREF6(address, offset) asm volatile ("pref 6, " CVMX_TMP_STR(offset) "(%[rbase])" : : [rbase] "d" (address))
+#define CVMX_PREFETCH_PREF7(address, offset) asm volatile ("pref 7, " CVMX_TMP_STR(offset) "(%[rbase])" : : [rbase] "d" (address))
+/* prefetch into L1, do not put the block in the L2 */
+#define CVMX_PREFETCH_NOTL2(address, offset) asm volatile ("pref 4, " CVMX_TMP_STR(offset) "(%[rbase])" : : [rbase] "d" (address))
+#define CVMX_PREFETCH_NOTL22(address, offset) asm volatile ("pref 5, " CVMX_TMP_STR(offset) "(%[rbase])" : : [rbase] "d" (address))
+/* prefetch into L2, do not put the block in the L1 */
+#define CVMX_PREFETCH_L2(address, offset) asm volatile ("pref 28, " CVMX_TMP_STR(offset) "(%[rbase])" : : [rbase] "d" (address))
+/*
+ * CVMX_PREPARE_FOR_STORE makes each byte of the block unpredictable
+ * (actually old value or zero) until that byte is stored to (by this or
+ * another processor. Note that the value of each byte is not only
+ * unpredictable, but may also change again - up until the point when one
+ * of the cores stores to the */
+/* byte. */
+#define CVMX_PREPARE_FOR_STORE(address, offset) asm volatile ("pref 30, " CVMX_TMP_STR(offset) "(%[rbase])" : : [rbase] "d" (address))
+/*
+ * This is a command headed to the L2 controller to tell it to clear
+ * its dirty bit for a block. Basically, SW is telling HW that the
+ * current version of the block will not be
+ */
+/* used. */
+#define CVMX_DONT_WRITE_BACK(address, offset) asm volatile ("pref 29, " CVMX_TMP_STR(offset) "(%[rbase])" : : [rbase] "d" (address))
+
+/* flush stores, invalidate entire icache */
+#define CVMX_ICACHE_INVALIDATE  { CVMX_SYNC; asm volatile ("synci 0($0)" : : ); }
+
+/* flush stores, invalidate entire icache */
+#define CVMX_ICACHE_INVALIDATE2 { CVMX_SYNC; asm volatile ("cache 0, 0($0)" : : ); }
+
+/* complete prefetches, invalidate entire dcache */
+#define CVMX_DCACHE_INVALIDATE  { CVMX_SYNC; asm volatile ("cache 9, 0($0)" : : ); }
+
+/* new instruction to make RC4 run faster */
+#define CVMX_BADDU(result, input1, input2) asm ("baddu %[rd],%[rs],%[rt]" : [rd] "=d" (result) : [rs] "d" (input1) , [rt] "d" (input2))
+
+/* misc v2 stuff */
+#define CVMX_ROTR(result, input1, shiftconst) asm ("rotr %[rd],%[rs]," CVMX_TMP_STR(shiftconst) : [rd] "=d" (result) : [rs] "d" (input1))
+#define CVMX_ROTRV(result, input1, input2) asm ("rotrv %[rd],%[rt],%[rs]" : [rd] "=d" (result) : [rt] "d" (input1) , [rs] "d" (input2))
+#define CVMX_DROTR(result, input1, shiftconst) asm ("drotr %[rd],%[rs]," CVMX_TMP_STR(shiftconst) : [rd] "=d" (result) : [rs] "d" (input1))
+#define CVMX_DROTRV(result, input1, input2) asm ("drotrv %[rd],%[rt],%[rs]" : [rd] "=d" (result) : [rt] "d" (input1) , [rs] "d" (input2))
+#define CVMX_SEB(result, input1) asm ("seb %[rd],%[rt]" : [rd] "=d" (result) : [rt] "d" (input1))
+#define CVMX_SEH(result, input1) asm ("seh %[rd],%[rt]" : [rd] "=d" (result) : [rt] "d" (input1))
+#define CVMX_DSBH(result, input1) asm ("dsbh %[rd],%[rt]" : [rd] "=d" (result) : [rt] "d" (input1))
+#define CVMX_DSHD(result, input1) asm ("dshd %[rd],%[rt]" : [rd] "=d" (result) : [rt] "d" (input1))
+#define CVMX_WSBH(result, input1) asm ("wsbh %[rd],%[rt]" : [rd] "=d" (result) : [rt] "d" (input1))
+
+/* Endian swap */
+#define CVMX_ES64(result, input) \
+        do {\
+        CVMX_DSBH(result, input); \
+        CVMX_DSHD(result, result); \
+        } while (0)
+#define CVMX_ES32(result, input) \
+        do {\
+        CVMX_WSBH(result, input); \
+        CVMX_ROTR(result, result, 16); \
+        } while (0)
+
+/*
+ * extract and insert - NOTE that pos and len variables must be
+ * constants! the P variants take len rather than lenm1 the M1
+ * variants take lenm1 rather than len.
+ */
+#define CVMX_EXTS(result,input,pos,lenm1) asm ("exts %[rt],%[rs]," CVMX_TMP_STR(pos) "," CVMX_TMP_STR(lenm1) : [rt] "=d" (result) : [rs] "d" (input))
+#define CVMX_EXTSP(result,input,pos,len) CVMX_EXTS(result,input,pos,(len)-1)
+
+#define CVMX_DEXT(result,input,pos,len) asm ("dext %[rt],%[rs]," CVMX_TMP_STR(pos) "," CVMX_TMP_STR(len) : [rt] "=d" (result) : [rs] "d" (input))
+#define CVMX_DEXTM1(result,input,pos,lenm1) CVMX_DEXT(result,input,pos,(lenm1)+1)
+
+#define CVMX_EXT(result,input,pos,len) asm ("ext %[rt],%[rs]," CVMX_TMP_STR(pos) "," CVMX_TMP_STR(len) : [rt] "=d" (result) : [rs] "d" (input))
+#define CVMX_EXTM1(result,input,pos,lenm1) CVMX_EXT(result,input,pos,(lenm1)+1)
+
+#define CVMX_CINS(result,input,pos,lenm1) asm ("cins %[rt],%[rs]," CVMX_TMP_STR(pos) "," CVMX_TMP_STR(lenm1) : [rt] "=d" (result) : [rs] "d" (input))
+#define CVMX_CINSP(result,input,pos,len) CVMX_CINS(result,input,pos,(len)-1)
+
+#define CVMX_DINS(result,input,pos,len) asm ("dins %[rt],%[rs]," CVMX_TMP_STR(pos) "," CVMX_TMP_STR(len): [rt] "=d" (result): [rs] "d" (input), "[rt]" (result))
+#define CVMX_DINSM1(result,input,pos,lenm1) CVMX_DINS(result,input,pos,(lenm1)+1)
+#define CVMX_DINSC(result,pos,len) asm ("dins %[rt],$0," CVMX_TMP_STR(pos) "," CVMX_TMP_STR(len): [rt] "=d" (result): "[rt]" (result))
+#define CVMX_DINSCM1(result,pos,lenm1) CVMX_DINSC(result,pos,(lenm1)+1)
+
+#define CVMX_INS(result,input,pos,len) asm ("ins %[rt],%[rs]," CVMX_TMP_STR(pos) "," CVMX_TMP_STR(len): [rt] "=d" (result): [rs] "d" (input), "[rt]" (result))
+#define CVMX_INSM1(result,input,pos,lenm1) CVMX_INS(result,input,pos,(lenm1)+1)
+#define CVMX_INSC(result,pos,len) asm ("ins %[rt],$0," CVMX_TMP_STR(pos) "," CVMX_TMP_STR(len): [rt] "=d" (result): "[rt]" (result))
+#define CVMX_INSCM1(result,pos,lenm1) CVMX_INSC(result,pos,(lenm1)+1)
+
+#define CVMX_CLZ(result, input) asm ("clz %[rd],%[rs]" : [rd] "=d" (result) : [rs] "d" (input))
+#define CVMX_DCLZ(result, input) asm ("dclz %[rd],%[rs]" : [rd] "=d" (result) : [rs] "d" (input))
+#define CVMX_CLO(result, input) asm ("clo %[rd],%[rs]" : [rd] "=d" (result) : [rs] "d" (input))
+#define CVMX_DCLO(result, input) asm ("dclo %[rd],%[rs]" : [rd] "=d" (result) : [rs] "d" (input))
+#define CVMX_POP(result, input) asm ("pop %[rd],%[rs]" : [rd] "=d" (result) : [rs] "d" (input))
+#define CVMX_DPOP(result, input) asm ("dpop %[rd],%[rs]" : [rd] "=d" (result) : [rs] "d" (input))
+
+/* some new cop0-like stuff */
+#define CVMX_RDHWR(result, regstr) asm volatile ("rdhwr %[rt],$" CVMX_TMP_STR(regstr) : [rt] "=d" (result))
+#define CVMX_RDHWRNV(result, regstr) asm ("rdhwr %[rt],$" CVMX_TMP_STR(regstr) : [rt] "=d" (result))
+#define CVMX_DI(result) asm volatile ("di %[rt]" : [rt] "=d" (result))
+#define CVMX_DI_NULL asm volatile ("di")
+#define CVMX_EI(result) asm volatile ("ei %[rt]" : [rt] "=d" (result))
+#define CVMX_EI_NULL asm volatile ("ei")
+#define CVMX_EHB asm volatile ("ehb")
+
+/* mul stuff */
+#define CVMX_MTM0(m) asm volatile ("mtm0 %[rs]" : : [rs] "d" (m))
+#define CVMX_MTM1(m) asm volatile ("mtm1 %[rs]" : : [rs] "d" (m))
+#define CVMX_MTM2(m) asm volatile ("mtm2 %[rs]" : : [rs] "d" (m))
+#define CVMX_MTP0(p) asm volatile ("mtp0 %[rs]" : : [rs] "d" (p))
+#define CVMX_MTP1(p) asm volatile ("mtp1 %[rs]" : : [rs] "d" (p))
+#define CVMX_MTP2(p) asm volatile ("mtp2 %[rs]" : : [rs] "d" (p))
+#define CVMX_VMULU(dest,mpcand,accum) asm volatile ("vmulu %[rd],%[rs],%[rt]" : [rd] "=d" (dest) : [rs] "d" (mpcand), [rt] "d" (accum))
+#define CVMX_VMM0(dest,mpcand,accum) asm volatile ("vmm0 %[rd],%[rs],%[rt]" : [rd] "=d" (dest) : [rs] "d" (mpcand), [rt] "d" (accum))
+#define CVMX_V3MULU(dest,mpcand,accum) asm volatile ("v3mulu %[rd],%[rs],%[rt]" : [rd] "=d" (dest) : [rs] "d" (mpcand), [rt] "d" (accum))
+
+/*
+ * branch stuff, these are hard to make work because the compiler does
+ * not realize that the instruction is a branch so may optimize away
+ * the label the labels to these next two macros must not include a
+ * ":" at the end.
+ */
+#define CVMX_BBIT1(var, pos, label) asm volatile ("bbit1 %[rs]," CVMX_TMP_STR(pos) "," CVMX_TMP_STR(label) : : [rs] "d" (var))
+#define CVMX_BBIT0(var, pos, label) asm volatile ("bbit0 %[rs]," CVMX_TMP_STR(pos) "," CVMX_TMP_STR(label) : : [rs] "d" (var))
+/* the label to this macro must include a ":" at the end */
+#define CVMX_ASM_LABEL(label) label \
+                             asm volatile (CVMX_TMP_STR(label) : : )
+
+/* Low-latency memory stuff */
+
+/* set can be 0-1 */
+#define CVMX_MT_LLM_READ_ADDR(set,val)    asm volatile ("dmtc2 %[rt],0x0400+(8*(" CVMX_TMP_STR(set) "))" : : [rt] "d" (val))
+#define CVMX_MT_LLM_WRITE_ADDR_INTERNAL(set,val)   asm volatile ("dmtc2 %[rt],0x0401+(8*(" CVMX_TMP_STR(set) "))" : : [rt] "d" (val))
+#define CVMX_MT_LLM_READ64_ADDR(set,val)  asm volatile ("dmtc2 %[rt],0x0404+(8*(" CVMX_TMP_STR(set) "))" : : [rt] "d" (val))
+#define CVMX_MT_LLM_WRITE64_ADDR_INTERNAL(set,val) asm volatile ("dmtc2 %[rt],0x0405+(8*(" CVMX_TMP_STR(set) "))" : : [rt] "d" (val))
+#define CVMX_MT_LLM_DATA(set,val)         asm volatile ("dmtc2 %[rt],0x0402+(8*(" CVMX_TMP_STR(set) "))" : : [rt] "d" (val))
+#define CVMX_MF_LLM_DATA(set,val)         asm volatile ("dmfc2 %[rt],0x0402+(8*(" CVMX_TMP_STR(set) "))" : [rt] "=d" (val) : )
+
+/* load linked, store conditional */
+#define CVMX_LL(dest, address, offset) asm volatile ("ll %[rt], " CVMX_TMP_STR(offset) "(%[rbase])" : [rt] "=d" (dest) : [rbase] "d" (address))
+#define CVMX_LLD(dest, address, offset) asm volatile ("lld %[rt], " CVMX_TMP_STR(offset) "(%[rbase])" : [rt] "=d" (dest) : [rbase] "d" (address))
+#define CVMX_SC(srcdest, address, offset) asm volatile ("sc %[rt], " CVMX_TMP_STR(offset) "(%[rbase])" : [rt] "=d" (srcdest) : [rbase] "d" (address), "[rt]" (srcdest))
+#define CVMX_SCD(srcdest, address, offset) asm volatile ("scd %[rt], " CVMX_TMP_STR(offset) "(%[rbase])" : [rt] "=d" (srcdest) : [rbase] "d" (address), "[rt]" (srcdest))
+
+/* load/store word left/right */
+#define CVMX_LWR(srcdest, address, offset) asm volatile ("lwr %[rt], " CVMX_TMP_STR(offset) "(%[rbase])" : [rt] "=d" (srcdest) : [rbase] "d" (address), "[rt]" (srcdest))
+#define CVMX_LWL(srcdest, address, offset) asm volatile ("lwl %[rt], " CVMX_TMP_STR(offset) "(%[rbase])" : [rt] "=d" (srcdest) : [rbase] "d" (address), "[rt]" (srcdest))
+#define CVMX_LDR(srcdest, address, offset) asm volatile ("ldr %[rt], " CVMX_TMP_STR(offset) "(%[rbase])" : [rt] "=d" (srcdest) : [rbase] "d" (address), "[rt]" (srcdest))
+#define CVMX_LDL(srcdest, address, offset) asm volatile ("ldl %[rt], " CVMX_TMP_STR(offset) "(%[rbase])" : [rt] "=d" (srcdest) : [rbase] "d" (address), "[rt]" (srcdest))
+
+#define CVMX_SWR(src, address, offset) asm volatile ("swr %[rt], " CVMX_TMP_STR(offset) "(%[rbase])" : : [rbase] "d" (address), [rt] "d" (src))
+#define CVMX_SWL(src, address, offset) asm volatile ("swl %[rt], " CVMX_TMP_STR(offset) "(%[rbase])" : : [rbase] "d" (address), [rt] "d" (src))
+#define CVMX_SDR(src, address, offset) asm volatile ("sdr %[rt], " CVMX_TMP_STR(offset) "(%[rbase])" : : [rbase] "d" (address), [rt] "d" (src))
+#define CVMX_SDL(src, address, offset) asm volatile ("sdl %[rt], " CVMX_TMP_STR(offset) "(%[rbase])" : : [rbase] "d" (address), [rt] "d" (src))
+
+/* */
+/* Useful crypto ASM's */
+/* */
+
+/* CRC */
+
+#define CVMX_MT_CRC_POLYNOMIAL(val)         asm volatile ("dmtc2 %[rt],0x4200" : : [rt] "d" (val))
+#define CVMX_MT_CRC_IV(val)                 asm volatile ("dmtc2 %[rt],0x0201" : : [rt] "d" (val))
+#define CVMX_MT_CRC_LEN(val)                asm volatile ("dmtc2 %[rt],0x1202" : : [rt] "d" (val))
+#define CVMX_MT_CRC_BYTE(val)               asm volatile ("dmtc2 %[rt],0x0204" : : [rt] "d" (val))
+#define CVMX_MT_CRC_HALF(val)               asm volatile ("dmtc2 %[rt],0x0205" : : [rt] "d" (val))
+#define CVMX_MT_CRC_WORD(val)               asm volatile ("dmtc2 %[rt],0x0206" : : [rt] "d" (val))
+#define CVMX_MT_CRC_DWORD(val)              asm volatile ("dmtc2 %[rt],0x1207" : : [rt] "d" (val))
+#define CVMX_MT_CRC_VAR(val)                asm volatile ("dmtc2 %[rt],0x1208" : : [rt] "d" (val))
+#define CVMX_MT_CRC_POLYNOMIAL_REFLECT(val) asm volatile ("dmtc2 %[rt],0x4210" : : [rt] "d" (val))
+#define CVMX_MT_CRC_IV_REFLECT(val)         asm volatile ("dmtc2 %[rt],0x0211" : : [rt] "d" (val))
+#define CVMX_MT_CRC_BYTE_REFLECT(val)       asm volatile ("dmtc2 %[rt],0x0214" : : [rt] "d" (val))
+#define CVMX_MT_CRC_HALF_REFLECT(val)       asm volatile ("dmtc2 %[rt],0x0215" : : [rt] "d" (val))
+#define CVMX_MT_CRC_WORD_REFLECT(val)       asm volatile ("dmtc2 %[rt],0x0216" : : [rt] "d" (val))
+#define CVMX_MT_CRC_DWORD_REFLECT(val)      asm volatile ("dmtc2 %[rt],0x1217" : : [rt] "d" (val))
+#define CVMX_MT_CRC_VAR_REFLECT(val)        asm volatile ("dmtc2 %[rt],0x1218" : : [rt] "d" (val))
+
+#define CVMX_MF_CRC_POLYNOMIAL(val)         asm volatile ("dmfc2 %[rt],0x0200" : [rt] "=d" (val) : )
+#define CVMX_MF_CRC_IV(val)                 asm volatile ("dmfc2 %[rt],0x0201" : [rt] "=d" (val) : )
+#define CVMX_MF_CRC_IV_REFLECT(val)         asm volatile ("dmfc2 %[rt],0x0203" : [rt] "=d" (val) : )
+#define CVMX_MF_CRC_LEN(val)                asm volatile ("dmfc2 %[rt],0x0202" : [rt] "=d" (val) : )
+
+/* MD5 and SHA-1 */
+
+/* pos can be 0-6 */
+#define CVMX_MT_HSH_DAT(val, pos)    asm volatile ("dmtc2 %[rt],0x0040+" CVMX_TMP_STR(pos) :                 : [rt] "d" (val))
+#define CVMX_MT_HSH_DATZ(pos)       asm volatile ("dmtc2    $0,0x0040+" CVMX_TMP_STR(pos) :                 :               )
+/* pos can be 0-14 */
+#define CVMX_MT_HSH_DATW(val, pos)   asm volatile ("dmtc2 %[rt],0x0240+" CVMX_TMP_STR(pos) :                 : [rt] "d" (val))
+#define CVMX_MT_HSH_DATWZ(pos)      asm volatile ("dmtc2    $0,0x0240+" CVMX_TMP_STR(pos) :                 :               )
+#define CVMX_MT_HSH_STARTMD5(val)   asm volatile ("dmtc2 %[rt],0x4047"                   :                 : [rt] "d" (val))
+#define CVMX_MT_HSH_STARTSHA(val)   asm volatile ("dmtc2 %[rt],0x4057"                   :                 : [rt] "d" (val))
+#define CVMX_MT_HSH_STARTSHA256(val)   asm volatile ("dmtc2 %[rt],0x404f"                   :                 : [rt] "d" (val))
+#define CVMX_MT_HSH_STARTSHA512(val)   asm volatile ("dmtc2 %[rt],0x424f"                   :                 : [rt] "d" (val))
+/* pos can be 0-3 */
+#define CVMX_MT_HSH_IV(val, pos)     asm volatile ("dmtc2 %[rt],0x0048+" CVMX_TMP_STR(pos) :                 : [rt] "d" (val))
+/* pos can be 0-7 */
+#define CVMX_MT_HSH_IVW(val, pos)     asm volatile ("dmtc2 %[rt],0x0250+" CVMX_TMP_STR(pos) :                 : [rt] "d" (val))
+
+/* pos can be 0-6 */
+#define CVMX_MF_HSH_DAT(val, pos)    asm volatile ("dmfc2 %[rt],0x0040+" CVMX_TMP_STR(pos) : [rt] "=d" (val) :)
+/* pos can be 0-14 */
+#define CVMX_MF_HSH_DATW(val, pos)   asm volatile ("dmfc2 %[rt],0x0240+" CVMX_TMP_STR(pos) : [rt] "=d" (val) :)
+/* pos can be 0-3 */
+#define CVMX_MF_HSH_IV(val, pos)     asm volatile ("dmfc2 %[rt],0x0048+" CVMX_TMP_STR(pos) : [rt] "=d" (val) :)
+/* pos can be 0-7 */
+#define CVMX_MF_HSH_IVW(val, pos)     asm volatile ("dmfc2 %[rt],0x0250+" CVMX_TMP_STR(pos) : [rt] "=d" (val) :)
+
+/* 3DES */
+
+/* pos can be 0-2 */
+#define CVMX_MT_3DES_KEY(val, pos)   asm volatile ("dmtc2 %[rt],0x0080+" CVMX_TMP_STR(pos) :                 : [rt] "d" (val))
+#define CVMX_MT_3DES_IV(val)        asm volatile ("dmtc2 %[rt],0x0084"                   :                 : [rt] "d" (val))
+#define CVMX_MT_3DES_ENC_CBC(val)   asm volatile ("dmtc2 %[rt],0x4088"                   :                 : [rt] "d" (val))
+#define CVMX_MT_3DES_ENC(val)       asm volatile ("dmtc2 %[rt],0x408a"                   :                 : [rt] "d" (val))
+#define CVMX_MT_3DES_DEC_CBC(val)   asm volatile ("dmtc2 %[rt],0x408c"                   :                 : [rt] "d" (val))
+#define CVMX_MT_3DES_DEC(val)       asm volatile ("dmtc2 %[rt],0x408e"                   :                 : [rt] "d" (val))
+#define CVMX_MT_3DES_RESULT(val)    asm volatile ("dmtc2 %[rt],0x0098"                   :                 : [rt] "d" (val))
+
+/* pos can be 0-2 */
+#define CVMX_MF_3DES_KEY(val, pos)   asm volatile ("dmfc2 %[rt],0x0080+" CVMX_TMP_STR(pos) : [rt] "=d" (val) :               )
+#define CVMX_MF_3DES_IV(val)        asm volatile ("dmfc2 %[rt],0x0084"                   : [rt] "=d" (val) :               )
+#define CVMX_MF_3DES_RESULT(val)    asm volatile ("dmfc2 %[rt],0x0088"                   : [rt] "=d" (val) :               )
+
+/* KASUMI */
+
+/* pos can be 0-1 */
+#define CVMX_MT_KAS_KEY(val, pos)    CVMX_MT_3DES_KEY(val, pos)
+#define CVMX_MT_KAS_ENC_CBC(val)    asm volatile ("dmtc2 %[rt],0x4089"                   :                 : [rt] "d" (val))
+#define CVMX_MT_KAS_ENC(val)        asm volatile ("dmtc2 %[rt],0x408b"                   :                 : [rt] "d" (val))
+#define CVMX_MT_KAS_RESULT(val)     CVMX_MT_3DES_RESULT(val)
+
+/* pos can be 0-1 */
+#define CVMX_MF_KAS_KEY(val, pos)    CVMX_MF_3DES_KEY(val, pos)
+#define CVMX_MF_KAS_RESULT(val)     CVMX_MF_3DES_RESULT(val)
+
+/* AES */
+
+#define CVMX_MT_AES_ENC_CBC0(val)   asm volatile ("dmtc2 %[rt],0x0108"                   :                 : [rt] "d" (val))
+#define CVMX_MT_AES_ENC_CBC1(val)   asm volatile ("dmtc2 %[rt],0x3109"                   :                 : [rt] "d" (val))
+#define CVMX_MT_AES_ENC0(val)       asm volatile ("dmtc2 %[rt],0x010a"                   :                 : [rt] "d" (val))
+#define CVMX_MT_AES_ENC1(val)       asm volatile ("dmtc2 %[rt],0x310b"                   :                 : [rt] "d" (val))
+#define CVMX_MT_AES_DEC_CBC0(val)   asm volatile ("dmtc2 %[rt],0x010c"                   :                 : [rt] "d" (val))
+#define CVMX_MT_AES_DEC_CBC1(val)   asm volatile ("dmtc2 %[rt],0x310d"                   :                 : [rt] "d" (val))
+#define CVMX_MT_AES_DEC0(val)       asm volatile ("dmtc2 %[rt],0x010e"                   :                 : [rt] "d" (val))
+#define CVMX_MT_AES_DEC1(val)       asm volatile ("dmtc2 %[rt],0x310f"                   :                 : [rt] "d" (val))
+/* pos can be 0-3 */
+#define CVMX_MT_AES_KEY(val, pos)    asm volatile ("dmtc2 %[rt],0x0104+" CVMX_TMP_STR(pos) :                 : [rt] "d" (val))
+/* pos can be 0-1 */
+#define CVMX_MT_AES_IV(val, pos)     asm volatile ("dmtc2 %[rt],0x0102+" CVMX_TMP_STR(pos) :                 : [rt] "d" (val))
+/* write the keylen */
+#define CVMX_MT_AES_KEYLENGTH(val)  asm volatile ("dmtc2 %[rt],0x0110"                   :                 : [rt] "d" (val))
+/* pos can be 0-1 */
+#define CVMX_MT_AES_RESULT(val, pos) asm volatile ("dmtc2 %[rt],0x0100+" CVMX_TMP_STR(pos) :                 : [rt] "d" (val))
+
+/* pos can be 0-1 */
+#define CVMX_MF_AES_RESULT(val, pos) asm volatile ("dmfc2 %[rt],0x0100+" CVMX_TMP_STR(pos) : [rt] "=d" (val) :               )
+/* pos can be 0-1 */
+#define CVMX_MF_AES_IV(val, pos)     asm volatile ("dmfc2 %[rt],0x0102+" CVMX_TMP_STR(pos) : [rt] "=d" (val) :               )
+/* pos can be 0-3 */
+#define CVMX_MF_AES_KEY(val, pos)    asm volatile ("dmfc2 %[rt],0x0104+" CVMX_TMP_STR(pos) : [rt] "=d" (val) :               )
+/* read the keylen */
+#define CVMX_MF_AES_KEYLENGTH(val)  asm volatile ("dmfc2 %[rt],0x0110"                   : [rt] "=d" (val) :               )
+/* first piece of input data */
+#define CVMX_MF_AES_DAT0(val)       asm volatile ("dmfc2 %[rt],0x0111"                   : [rt] "=d" (val) :               )
+/* GFM COP2 macros */
+/* index can be 0 or 1 */
+#define CVMX_MF_GFM_MUL(val, index)     asm volatile ("dmfc2 %[rt],0x0258+" CVMX_TMP_STR(index) : [rt] "=d" (val) :               )
+#define CVMX_MF_GFM_POLY(val)           asm volatile ("dmfc2 %[rt],0x025e"                      : [rt] "=d" (val) :               )
+#define CVMX_MF_GFM_RESINP(val, index)  asm volatile ("dmfc2 %[rt],0x025a+" CVMX_TMP_STR(index) : [rt] "=d" (val) :               )
+
+#define CVMX_MT_GFM_MUL(val, index)     asm volatile ("dmtc2 %[rt],0x0258+" CVMX_TMP_STR(index) :                 : [rt] "d" (val))
+#define CVMX_MT_GFM_POLY(val)           asm volatile ("dmtc2 %[rt],0x025e"                      :                 : [rt] "d" (val))
+#define CVMX_MT_GFM_RESINP(val, index)  asm volatile ("dmtc2 %[rt],0x025a+" CVMX_TMP_STR(index) :                 : [rt] "d" (val))
+#define CVMX_MT_GFM_XOR0(val)           asm volatile ("dmtc2 %[rt],0x025c"                      :                 : [rt] "d" (val))
+#define CVMX_MT_GFM_XORMUL1(val)        asm volatile ("dmtc2 %[rt],0x425d"                      :                 : [rt] "d" (val))
+
+/* check_ordering stuff */
+#define CVMX_MF_CHORD(dest)         CVMX_RDHWR(dest, 30)
+
+/* reads the current (64-bit) CvmCount value */
+#define CVMX_MF_CYCLE(dest)         CVMX_RDHWR(dest, 31)
+
+#define CVMX_MT_CYCLE(src)         asm volatile ("dmtc0 %[rt],$9,6" :: [rt] "d" (src))
+
+#define CVMX_MF_CACHE_ERR(val)            asm volatile ("dmfc0 %[rt],$27,0" :  [rt] "=d" (val):)
+#define CVMX_MF_DCACHE_ERR(val)           asm volatile ("dmfc0 %[rt],$27,1" :  [rt] "=d" (val):)
+#define CVMX_MF_CVM_MEM_CTL(val)          asm volatile ("dmfc0 %[rt],$11,7" :  [rt] "=d" (val):)
+#define CVMX_MF_CVM_CTL(val)              asm volatile ("dmfc0 %[rt],$9,7"  :  [rt] "=d" (val):)
+#define CVMX_MT_CACHE_ERR(val)            asm volatile ("dmtc0 %[rt],$27,0" : : [rt] "d" (val))
+#define CVMX_MT_DCACHE_ERR(val)           asm volatile ("dmtc0 %[rt],$27,1" : : [rt] "d" (val))
+#define CVMX_MT_CVM_MEM_CTL(val)          asm volatile ("dmtc0 %[rt],$11,7" : : [rt] "d" (val))
+#define CVMX_MT_CVM_CTL(val)              asm volatile ("dmtc0 %[rt],$9,7"  : : [rt] "d" (val))
+
+/* Macros for TLB */
+#define CVMX_TLBWI                       asm volatile ("tlbwi" : : )
+#define CVMX_TLBWR                       asm volatile ("tlbwr" : : )
+#define CVMX_TLBR                        asm volatile ("tlbr" : : )
+#define CVMX_MT_ENTRY_HIGH(val)          asm volatile ("dmtc0 %[rt],$10,0" : : [rt] "d" (val))
+#define CVMX_MT_ENTRY_LO_0(val)          asm volatile ("dmtc0 %[rt],$2,0" : : [rt] "d" (val))
+#define CVMX_MT_ENTRY_LO_1(val)          asm volatile ("dmtc0 %[rt],$3,0" : : [rt] "d" (val))
+#define CVMX_MT_PAGEMASK(val)            asm volatile ("mtc0 %[rt],$5,0" : : [rt] "d" (val))
+#define CVMX_MT_PAGEGRAIN(val)           asm volatile ("mtc0 %[rt],$5,1" : : [rt] "d" (val))
+#define CVMX_MT_TLB_INDEX(val)           asm volatile ("mtc0 %[rt],$0,0" : : [rt] "d" (val))
+#define CVMX_MT_TLB_CONTEXT(val)         asm volatile ("dmtc0 %[rt],$4,0" : : [rt] "d" (val))
+#define CVMX_MT_TLB_WIRED(val)           asm volatile ("mtc0 %[rt],$6,0" : : [rt] "d" (val))
+#define CVMX_MT_TLB_RANDOM(val)          asm volatile ("mtc0 %[rt],$1,0" : : [rt] "d" (val))
+#define CVMX_MF_ENTRY_LO_0(val)          asm volatile ("dmfc0 %[rt],$2,0" :  [rt] "=d" (val):)
+#define CVMX_MF_ENTRY_LO_1(val)          asm volatile ("dmfc0 %[rt],$3,0" :  [rt] "=d" (val):)
+#define CVMX_MF_ENTRY_HIGH(val)          asm volatile ("dmfc0 %[rt],$10,0" :  [rt] "=d" (val):)
+#define CVMX_MF_PAGEMASK(val)            asm volatile ("mfc0 %[rt],$5,0" :  [rt] "=d" (val):)
+#define CVMX_MF_PAGEGRAIN(val)           asm volatile ("mfc0 %[rt],$5,1" :  [rt] "=d" (val):)
+#define CVMX_MF_TLB_WIRED(val)           asm volatile ("mfc0 %[rt],$6,0" :  [rt] "=d" (val):)
+#define CVMX_MF_TLB_RANDOM(val)          asm volatile ("mfc0 %[rt],$1,0" :  [rt] "=d" (val):)
+#define TLB_DIRTY   (0x1ULL<<2)
+#define TLB_VALID   (0x1ULL<<1)
+#define TLB_GLOBAL  (0x1ULL<<0)
+
+/* assembler macros to guarantee byte loads/stores are used */
+/* for an unaligned 16-bit access (these use AT register) */
+/* we need the hidden argument (__a) so that GCC gets the dependencies right */
+#define CVMX_LOADUNA_INT16(result, address, offset) \
+	{ char *__a = (char *)(address); \
+	  asm ("ulh %[rdest], " CVMX_TMP_STR(offset) "(%[rbase])" : [rdest] "=d" (result) : [rbase] "d" (__a), "m"(__a[offset]), "m"(__a[offset + 1])); }
+#define CVMX_LOADUNA_UINT16(result, address, offset) \
+	{ char *__a = (char *)(address); \
+	  asm ("ulhu %[rdest], " CVMX_TMP_STR(offset) "(%[rbase])" : [rdest] "=d" (result) : [rbase] "d" (__a), "m"(__a[offset + 0]), "m"(__a[offset + 1])); }
+#define CVMX_STOREUNA_INT16(data, address, offset) \
+	{ char *__a = (char *)(address); \
+	  asm ("ush %[rsrc], " CVMX_TMP_STR(offset) "(%[rbase])" : "=m"(__a[offset + 0]), "=m"(__a[offset + 1]): [rsrc] "d" (data), [rbase] "d" (__a)); }
+
+#define CVMX_LOADUNA_INT32(result, address, offset) \
+	{ char *__a = (char *)(address); \
+	  asm ("ulw %[rdest], " CVMX_TMP_STR(offset) "(%[rbase])" : [rdest] "=d" (result) : \
+	       [rbase] "d" (__a), "m"(__a[offset + 0]), "m"(__a[offset + 1]), "m"(__a[offset + 2]), "m"(__a[offset + 3])); }
+#define CVMX_STOREUNA_INT32(data, address, offset) \
+	{ char *__a = (char *)(address); \
+	  asm ("usw %[rsrc], " CVMX_TMP_STR(offset) "(%[rbase])" : \
+	       "=m"(__a[offset + 0]), "=m"(__a[offset + 1]), "=m"(__a[offset + 2]), "=m"(__a[offset + 3]) : \
+	       [rsrc] "d" (data), [rbase] "d" (__a)); }
+
+#define CVMX_LOADUNA_INT64(result, address, offset) \
+	{ char *__a = (char *)(address); \
+	  asm ("uld %[rdest], " CVMX_TMP_STR(offset) "(%[rbase])" : [rdest] "=d" (result) : \
+	       [rbase] "d" (__a), "m"(__a[offset + 0]), "m"(__a[offset + 1]), "m"(__a[offset + 2]), "m"(__a[offset + 3]), \
+	       "m"(__a[offset + 4]), "m"(__a[offset + 5]), "m"(__a[offset + 6]), "m"(__a[offset + 7])); }
+#define CVMX_STOREUNA_INT64(data, address, offset) \
+	{ char *__a = (char *)(address); \
+	  asm ("usd %[rsrc], " CVMX_TMP_STR(offset) "(%[rbase])" : \
+	       "=m"(__a[offset + 0]), "=m"(__a[offset + 1]), "=m"(__a[offset + 2]), "=m"(__a[offset + 3]), \
+	       "=m"(__a[offset + 4]), "=m"(__a[offset + 5]), "=m"(__a[offset + 6]), "=m"(__a[offset + 7]) : \
+	       [rsrc] "d" (data), [rbase] "d" (__a)); }
+
+#endif /* __CVMX_ASM_H__ */
diff --git a/arch/mips/include/asm/octeon/cvmx-bootinfo.h b/arch/mips/include/asm/octeon/cvmx-bootinfo.h
new file mode 100644
index 0000000..acd1c57
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-bootinfo.h
@@ -0,0 +1,238 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as published by
+ * the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful,
+ * but AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or NONINFRINGEMENT.
+ * See the GNU General Public License for more details.
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
+ * Header file containing the ABI with the bootloader.
+ *
+ */
+
+#ifndef __CVMX_BOOTINFO_H__
+#define __CVMX_BOOTINFO_H__
+
+/* Current major and minor versions of the CVMX bootinfo block that is
+** passed from the bootloader to the application.  This is versioned
+** so that applications can properly handle multiple bootloader
+** versions. */
+#define CVMX_BOOTINFO_MAJ_VER 1
+#define CVMX_BOOTINFO_MIN_VER 2
+
+#if (CVMX_BOOTINFO_MAJ_VER == 1)
+#define CVMX_BOOTINFO_OCTEON_SERIAL_LEN 20
+/* This structure is populated by the bootloader.  For binary
+** compatibility the only changes that should be made are
+** adding members to the end of the structure, and the minor
+** version should be incremented at that time.
+** If an incompatible change is made, the major version
+** must be incremented, and the minor version should be reset
+** to 0.
+*/
+typedef struct {
+	uint32_t major_version;
+	uint32_t minor_version;
+
+	uint64_t stack_top;
+	uint64_t heap_base;
+	uint64_t heap_end;
+	uint64_t desc_vaddr;
+
+	uint32_t exception_base_addr;
+	uint32_t stack_size;
+	uint32_t flags;
+	uint32_t core_mask;
+	uint32_t dram_size;
+			 /**< DRAM size in megabytes */
+	uint32_t phy_mem_desc_addr;
+				 /**< physical address of free memory descriptor block*/
+	uint32_t debugger_flags_base_addr;
+					/**< used to pass flags from app to debugger */
+	uint32_t eclock_hz;
+			 /**< CPU clock speed, in hz */
+	uint32_t dclock_hz;
+			 /**< DRAM clock speed, in hz */
+	uint32_t reserved0;
+	uint16_t board_type;
+	uint8_t board_rev_major;
+	uint8_t board_rev_minor;
+	uint16_t reserved1;
+	uint8_t reserved2;
+	uint8_t reserved3;
+	char board_serial_number[CVMX_BOOTINFO_OCTEON_SERIAL_LEN];
+	uint8_t mac_addr_base[6];
+	uint8_t mac_addr_count;
+#if (CVMX_BOOTINFO_MIN_VER >= 1)
+	/* Several boards support compact flash on the Octeon boot bus.  The CF
+	 ** memory spaces may be mapped to different addresses on different boards.
+	 ** These are the physical addresses, so care must be taken to use the correct
+	 ** XKPHYS/KSEG0 addressing depending on the application's ABI.
+	 ** These values will be 0 if CF is not present */
+	uint64_t compact_flash_common_base_addr;
+	uint64_t compact_flash_attribute_base_addr;
+	/* Base address of the LED display (as on EBT3000 board)
+	 ** This will be 0 if LED display not present. */
+	uint64_t led_display_base_addr;
+#endif
+#if (CVMX_BOOTINFO_MIN_VER >= 2)
+	uint32_t dfa_ref_clock_hz;
+	/**< DFA reference clock in hz (if applicable)*/
+	uint32_t config_flags;
+	/**< flags indicating various configuration options.  These
+	 ** flags supercede the 'flags' variable and should be used
+	 ** instead if available */
+#endif
+
+} cvmx_bootinfo_t;
+
+#define CVMX_BOOTINFO_CFG_FLAG_PCI_HOST			(1ull << 0)
+#define CVMX_BOOTINFO_CFG_FLAG_PCI_TARGET		(1ull << 1)
+#define CVMX_BOOTINFO_CFG_FLAG_DEBUG			(1ull << 2)
+#define CVMX_BOOTINFO_CFG_FLAG_NO_MAGIC			(1ull << 3)
+/* This flag is set if the TLB mappings are not contained in the
+** 0x10000000 - 0x20000000 boot bus region. */
+#define CVMX_BOOTINFO_CFG_FLAG_OVERSIZE_TLB_MAPPING     (1ull << 4)
+#define CVMX_BOOTINFO_CFG_FLAG_BREAK			(1ull << 5)
+
+#endif /*   (CVMX_BOOTINFO_MAJ_VER == 1) */
+
+/* Type defines for board and chip types */
+enum cvmx_board_types_enum {
+	CVMX_BOARD_TYPE_NULL = 0,
+	CVMX_BOARD_TYPE_SIM = 1,
+	CVMX_BOARD_TYPE_EBT3000 = 2,
+	CVMX_BOARD_TYPE_KODAMA = 3,
+	CVMX_BOARD_TYPE_NIAGARA = 4,
+	CVMX_BOARD_TYPE_NAC38 = 5,	/* formerly NAO38 */
+	CVMX_BOARD_TYPE_THUNDER = 6,
+	CVMX_BOARD_TYPE_TRANTOR = 7,
+	CVMX_BOARD_TYPE_EBH3000 = 8,
+	CVMX_BOARD_TYPE_EBH3100 = 9,
+	CVMX_BOARD_TYPE_HIKARI = 10,
+	CVMX_BOARD_TYPE_CN3010_EVB_HS5 = 11,
+	CVMX_BOARD_TYPE_CN3005_EVB_HS5 = 12,
+	CVMX_BOARD_TYPE_KBP = 13,
+	CVMX_BOARD_TYPE_CN3020_EVB_HS5 = 14,	/* Deprecated, CVMX_BOARD_TYPE_CN3010_EVB_HS5 supports the CN3020 */
+	CVMX_BOARD_TYPE_EBT5800 = 15,
+	CVMX_BOARD_TYPE_NICPRO2 = 16,
+	CVMX_BOARD_TYPE_EBH5600 = 17,
+	CVMX_BOARD_TYPE_EBH5601 = 18,
+	CVMX_BOARD_TYPE_EBH5200 = 19,
+	CVMX_BOARD_TYPE_BBGW_REF = 20,
+	CVMX_BOARD_TYPE_NIC_XLE_4G = 21,
+	CVMX_BOARD_TYPE_EBT5600 = 22,
+	CVMX_BOARD_TYPE_EBH5201 = 23,
+	CVMX_BOARD_TYPE_MAX,
+
+	/* The range from CVMX_BOARD_TYPE_MAX to CVMX_BOARD_TYPE_CUST_DEFINED_MIN is reserved
+	 ** for future SDK use. */
+
+	/* Set aside a range for customer boards.  These numbers are managed
+	 ** by Cavium.
+	 */
+	CVMX_BOARD_TYPE_CUST_DEFINED_MIN = 10000,
+	CVMX_BOARD_TYPE_CUST_WSX16 = 10001,
+	CVMX_BOARD_TYPE_CUST_NS0216 = 10002,
+	CVMX_BOARD_TYPE_CUST_NB5 = 10003,
+	CVMX_BOARD_TYPE_CUST_WMR500 = 10004,
+	CVMX_BOARD_TYPE_CUST_DEFINED_MAX = 20000,
+
+	/* Set aside a range for customer private use.  The SDK won't
+	 ** use any numbers in this range. */
+	CVMX_BOARD_TYPE_CUST_PRIVATE_MIN = 20001,
+	CVMX_BOARD_TYPE_CUST_PRIVATE_MAX = 30000,
+
+	/* The remaining range is reserved for future use. */
+};
+enum cvmx_chip_types_enum {
+	CVMX_CHIP_TYPE_NULL = 0,
+	CVMX_CHIP_SIM_TYPE_DEPRECATED = 1,
+	CVMX_CHIP_TYPE_OCTEON_SAMPLE = 2,
+	CVMX_CHIP_TYPE_MAX,
+};
+
+/* Compatability alias for NAC38 name change, planned to be removed from SDK 1.7 */
+#define CVMX_BOARD_TYPE_NAO38	CVMX_BOARD_TYPE_NAC38
+
+/* Functions to return string based on type */
+#define ENUM_BRD_TYPE_CASE(x)   case x: return(#x + 16);	/* Skip CVMX_BOARD_TYPE_ */
+static inline const char *cvmx_board_type_to_string(enum
+						    cvmx_board_types_enum type)
+{
+	switch (type) {
+		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_NULL)
+		    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_SIM)
+		    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_EBT3000)
+		    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_KODAMA)
+		    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_NIAGARA)
+		    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_NAC38)
+		    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_THUNDER)
+		    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_TRANTOR)
+		    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_EBH3000)
+		    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_EBH3100)
+		    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_HIKARI)
+		    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_CN3010_EVB_HS5)
+		    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_CN3005_EVB_HS5)
+		    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_KBP)
+		    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_CN3020_EVB_HS5)
+		    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_EBT5800)
+		    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_NICPRO2)
+		    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_EBH5600)
+		    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_EBH5601)
+		    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_EBH5200)
+		    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_BBGW_REF)
+		    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_NIC_XLE_4G)
+		    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_EBT5600)
+		    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_EBH5201)
+		    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_MAX)
+
+		    /* Customer boards listed here */
+		    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_CUST_DEFINED_MIN)
+		    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_CUST_WSX16)
+		    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_CUST_NS0216)
+		    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_CUST_NB5)
+		    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_CUST_WMR500)
+		    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_CUST_DEFINED_MAX)
+
+		    /* Customer private range */
+		    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_CUST_PRIVATE_MIN)
+		    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_CUST_PRIVATE_MAX)
+	}
+	return "Unsupported Board";
+}
+
+#define ENUM_CHIP_TYPE_CASE(x)   case x: return(#x + 15);	/* Skip CVMX_CHIP_TYPE */
+static inline const char *cvmx_chip_type_to_string(enum
+						   cvmx_chip_types_enum type)
+{
+	switch (type) {
+		ENUM_CHIP_TYPE_CASE(CVMX_CHIP_TYPE_NULL)
+		    ENUM_CHIP_TYPE_CASE(CVMX_CHIP_SIM_TYPE_DEPRECATED)
+		    ENUM_CHIP_TYPE_CASE(CVMX_CHIP_TYPE_OCTEON_SAMPLE)
+		    ENUM_CHIP_TYPE_CASE(CVMX_CHIP_TYPE_MAX)
+	}
+	return "Unsupported Chip";
+}
+
+#endif /* __CVMX_BOOTINFO_H__ */
diff --git a/arch/mips/include/asm/octeon/cvmx-bootmem.h b/arch/mips/include/asm/octeon/cvmx-bootmem.h
new file mode 100644
index 0000000..639a983
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-bootmem.h
@@ -0,0 +1,403 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as published by
+ * the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful,
+ * but AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or NONINFRINGEMENT.
+ * See the GNU General Public License for more details.
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
+ * Simple allocate only memory allocator.  Used to allocate memory at application
+ * start time.
+ *
+ *
+ */
+
+#ifndef __CVMX_BOOTMEM_H__
+#define __CVMX_BOOTMEM_H__
+
+#define CVMX_BOOTMEM_NAME_LEN 128	/* Must be multiple of 8, changing breaks ABI */
+#define CVMX_BOOTMEM_NUM_NAMED_BLOCKS 64	/* Can change without breaking ABI */
+#define CVMX_BOOTMEM_ALIGNMENT_SIZE     (16ull)	/* minimum alignment of bootmem alloced blocks */
+
+/* Flags for cvmx_bootmem_phy_mem* functions */
+#define CVMX_BOOTMEM_FLAG_END_ALLOC    (1 << 0)	/* Allocate from end of block instead of beginning */
+#define CVMX_BOOTMEM_FLAG_NO_LOCKING   (1 << 1)	/* Don't do any locking. */
+
+/* First bytes of each free physical block of memory contain this structure,
+ * which is used to maintain the free memory list.  Since the bootloader is
+ * only 32 bits, there is a union providing 64 and 32 bit versions.  The
+ * application init code converts addresses to 64 bit addresses before the
+ * application starts.
+ */
+typedef struct {
+	/* Note: these are referenced from assembly routines in the bootloader, so this structure
+	 ** should not be changed without changing those routines as well. */
+	uint64_t next_block_addr;
+	uint64_t size;
+
+} cvmx_bootmem_block_header_t;
+
+/* Structure for named memory blocks
+** Number of descriptors
+** available can be changed without affecting compatiblity,
+** but name length changes require a bump in the bootmem
+** descriptor version
+** Note: This structure must be naturally 64 bit aligned, as a single
+** memory image will be used by both 32 and 64 bit programs.
+*/
+typedef struct {
+	uint64_t base_addr;
+			    /**< Base address of named block */
+	uint64_t size;
+			    /**< Size actually allocated for named block (may differ from requested) */
+	char name[CVMX_BOOTMEM_NAME_LEN];
+					/**< name of named block */
+} cvmx_bootmem_named_block_desc_t;
+
+/* Current descriptor versions */
+#define CVMX_BOOTMEM_DESC_MAJ_VER   3	/* CVMX bootmem descriptor major version */
+#define CVMX_BOOTMEM_DESC_MIN_VER   0	/* CVMX bootmem descriptor minor version */
+
+/* First three members of cvmx_bootmem_desc_t are left in original
+** positions for backwards compatibility.
+*/
+typedef struct {
+	uint32_t lock;
+			    /**< spinlock to control access to list */
+	uint32_t flags;
+			    /**< flags for indicating various conditions */
+	uint64_t head_addr;
+
+	uint32_t major_version;
+				/**< incremented changed when incompatible changes made */
+	uint32_t minor_version;
+				/**< incremented changed when compatible changes made, reset to zero when major incremented */
+	uint64_t app_data_addr;
+	uint64_t app_data_size;
+
+	uint32_t named_block_num_blocks;
+					 /**< number of elements in named blocks array */
+	uint32_t named_block_name_len;
+					 /**< length of name array in bootmem blocks */
+	uint64_t named_block_array_addr;
+					 /**< address of named memory block descriptors */
+
+} cvmx_bootmem_desc_t;
+
+/**
+ * Initialize the boot alloc memory structures. This is
+ * normally called inside of cvmx_user_app_init()
+ *
+ * @mem_desc_ptr:	Address of the free memory list
+ * Returns
+ */
+extern int cvmx_bootmem_init(void *mem_desc_ptr);
+
+/**
+ * Allocate a block of memory from the free list that was passed
+ * to the application by the bootloader.
+ * This is an allocate-only algorithm, so freeing memory is not possible.
+ *
+ * @size:      Size in bytes of block to allocate
+ * @alignment: Alignment required - must be power of 2
+ *
+ * Returns pointer to block of memory, NULL on error
+ */
+extern void *cvmx_bootmem_alloc(uint64_t size, uint64_t alignment);
+
+/**
+ * Allocate a block of memory from the free list that was
+ * passed to the application by the bootloader at a specific
+ * address. This is an allocate-only algorithm, so
+ * freeing memory is not possible. Allocation will fail if
+ * memory cannot be allocated at the specified address.
+ *
+ * @size:      Size in bytes of block to allocate
+ * @address:   Physical address to allocate memory at.  If this memory is not
+ *                  available, the allocation fails.
+ * @alignment: Alignment required - must be power of 2
+ * Returns pointer to block of memory, NULL on error
+ */
+extern void *cvmx_bootmem_alloc_address(uint64_t size, uint64_t address,
+					uint64_t alignment);
+
+/**
+ * Allocate a block of memory from the free list that was
+ * passed to the application by the bootloader within a specified
+ * address range. This is an allocate-only algorithm, so
+ * freeing memory is not possible. Allocation will fail if
+ * memory cannot be allocated in the requested range.
+ *
+ * @size:      Size in bytes of block to allocate
+ * @min_addr:  defines the minimum address of the range
+ * @max_addr:  defines the maximum address of the range
+ * @alignment: Alignment required - must be power of 2
+ * Returns pointer to block of memory, NULL on error
+ */
+extern void *cvmx_bootmem_alloc_range(uint64_t size, uint64_t alignment,
+				      uint64_t min_addr, uint64_t max_addr);
+
+/**
+ * Allocate a block of memory from the free list that was passed
+ * to the application by the bootloader, and assign it a name in the
+ * global named block table.  (part of the cvmx_bootmem_descriptor_t structure)
+ * Named blocks can later be freed.
+ *
+ * @size:      Size in bytes of block to allocate
+ * @alignment: Alignment required - must be power of 2
+ * @name:      name of block - must be less than CVMX_BOOTMEM_NAME_LEN bytes
+ *
+ * Returns pointer to block of memory, NULL on error
+ */
+extern void *cvmx_bootmem_alloc_named(uint64_t size, uint64_t alignment,
+				      char *name);
+
+/**
+ * Allocate a block of memory from the free list that was passed
+ * to the application by the bootloader, and assign it a name in the
+ * global named block table.  (part of the cvmx_bootmem_descriptor_t structure)
+ * Named blocks can later be freed.
+ *
+ * @size:      Size in bytes of block to allocate
+ * @address:   Physical address to allocate memory at.  If this memory is not
+ *                  available, the allocation fails.
+ * @name:      name of block - must be less than CVMX_BOOTMEM_NAME_LEN bytes
+ *
+ * Returns pointer to block of memory, NULL on error
+ */
+extern void *cvmx_bootmem_alloc_named_address(uint64_t size,
+					      uint64_t address, char *name);
+
+/**
+ * Allocate a block of memory from a specific range of the free list that was passed
+ * to the application by the bootloader, and assign it a name in the
+ * global named block table.  (part of the cvmx_bootmem_descriptor_t structure)
+ * Named blocks can later be freed.
+ * If request cannot be satisfied within the address range specified, NULL is returned
+ *
+ * @size:      Size in bytes of block to allocate
+ * @min_addr:  minimum address of range
+ * @max_addr:  maximum address of range
+ * @align:  Alignment of memory to be allocated. (must be a power of 2)
+ * @name:      name of block - must be less than CVMX_BOOTMEM_NAME_LEN bytes
+ *
+ * Returns pointer to block of memory, NULL on error
+ */
+extern void *cvmx_bootmem_alloc_named_range(uint64_t size,
+					    uint64_t min_addr,
+					    uint64_t max_addr,
+					    uint64_t align, char *name);
+
+/**
+ * Frees a previously allocated named bootmem block.
+ *
+ * @name:   name of block to free
+ *
+ * Returns 0 on failure,
+ *         !0 on success
+ */
+extern int cvmx_bootmem_free_named(char *name);
+
+/**
+ * Finds a named bootmem block by name.
+ *
+ * @name:   name of block to free
+ *
+ * Returns pointer to named block descriptor on success
+ *         0 on failure
+ */
+cvmx_bootmem_named_block_desc_t *cvmx_bootmem_find_named_block(char
+							       *name);
+
+/**
+ * Returns the size of available memory in bytes, only
+ * counting blocks that are at least as big as the minimum block
+ * size.
+ *
+ * @min_block_size:
+ *               Minimum block size to count in total.
+ *
+ * Returns Number of bytes available for allocation that meet the block size requirement
+ */
+uint64_t cvmx_bootmem_available_mem(uint64_t min_block_size);
+
+/**
+ * Prints out the list of named blocks that have been allocated
+ * along with their addresses and sizes.
+ * This is primarily used for debugging purposes
+ */
+void cvmx_bootmem_print_named(void);
+
+/**
+ * Allocates a block of physical memory from the free list, at (optional) requested address and alignment.
+ *
+ * @req_size:  size of region to allocate.  All requests are rounded up to be a multiple CVMX_BOOTMEM_ALIGNMENT_SIZE bytes size
+ * @address_min:
+ *                  Minimum address that block can occupy.
+ * @address_max:
+ *                  Specifies the maximum address_min (inclusive) that the allocation can use.
+ * @alignment: Requested alignment of the block.  If this alignment cannot be met, the allocation fails.
+ *                  This must be a power of 2.
+ *                  (Note: Alignment of CVMX_BOOTMEM_ALIGNMENT_SIZE bytes is required, and internally enforced.  Requested alignments of
+ *                  less than CVMX_BOOTMEM_ALIGNMENT_SIZE are set to CVMX_BOOTMEM_ALIGNMENT_SIZE.)
+ * @flags:     Flags to control options for the allocation.
+ *
+ * Returns physical address of block allocated, or -1 on failure
+ */
+int64_t cvmx_bootmem_phy_alloc(uint64_t req_size, uint64_t address_min,
+			       uint64_t address_max, uint64_t alignment,
+			       uint32_t flags);
+
+/**
+ * Allocates a named block of physical memory from the free list, at (optional) requested address and alignment.
+ *
+ * @size:      size of region to allocate.  All requests are rounded up to be a multiple CVMX_BOOTMEM_ALIGNMENT_SIZE bytes size
+ * @min_addr:
+ *                  Minimum address that block can occupy.
+ * @max_addr:
+ *                  Specifies the maximum address_min (inclusive) that the allocation can use.
+ * @alignment: Requested alignment of the block.  If this alignment cannot be met, the allocation fails.
+ *                  This must be a power of 2.
+ *                  (Note: Alignment of CVMX_BOOTMEM_ALIGNMENT_SIZE bytes is required, and internally enforced.  Requested alignments of
+ *                  less than CVMX_BOOTMEM_ALIGNMENT_SIZE are set to CVMX_BOOTMEM_ALIGNMENT_SIZE.)
+ * @name:      name to assign to named block
+ * @flags:     Flags to control options for the allocation.
+ *
+ * Returns physical address of block allocated, or -1 on failure
+ */
+int64_t cvmx_bootmem_phy_named_block_alloc(uint64_t size,
+					   uint64_t min_addr,
+					   uint64_t max_addr,
+					   uint64_t alignment,
+					   char *name, uint32_t flags);
+
+/**
+ * Finds a named memory block by name.
+ * Also used for finding an unused entry in the named block table.
+ *
+ * @name:   Name of memory block to find.
+ *               If NULL pointer given, then finds unused descriptor, if available.
+ * @flags:     Flags to control options for the allocation.
+ *
+ * Returns Pointer to memory block descriptor, NULL if not found.
+ *         If NULL returned when name parameter is NULL, then no memory
+ *         block descriptors are available.
+ */
+cvmx_bootmem_named_block_desc_t *cvmx_bootmem_phy_named_block_find(char
+								   *name,
+								   uint32_t
+								   flags);
+
+/**
+ * Returns the size of available memory in bytes, only
+ * counting blocks that are at least as big as the minimum block
+ * size.
+ *
+ * @min_block_size:
+ *               Minimum block size to count in total.
+ *
+ * Returns Number of bytes available for allocation that meet the block size requirement
+ */
+uint64_t cvmx_bootmem_phy_available_mem(uint64_t min_block_size);
+
+/**
+ * Frees a named block.
+ *
+ * @name:   name of block to free
+ * @flags:  flags for passing options
+ *
+ * Returns 0 on failure
+ *         1 on success
+ */
+int cvmx_bootmem_phy_named_block_free(char *name, uint32_t flags);
+
+/**
+ * Frees a block to the bootmem allocator list.  This must
+ * be used with care, as the size provided must match the size
+ * of the block that was allocated, or the list will become
+ * corrupted.
+ *
+ * IMPORTANT:  This is only intended to be used as part of named block
+ * frees and initial population of the free memory list.
+ *                                                      *
+ *
+ * @phy_addr: physical address of block
+ * @size:     size of block in bytes.
+ * @flags:    flags for passing options
+ *
+ * Returns 1 on success,
+ *         0 on failure
+ */
+int __cvmx_bootmem_phy_free(uint64_t phy_addr, uint64_t size, uint32_t flags);
+
+/**
+ * Prints the list of currently allocated named blocks
+ *
+ */
+void cvmx_bootmem_phy_named_block_print(void);
+
+/**
+ * Prints the list of available memory.
+ *
+ */
+void cvmx_bootmem_phy_list_print(void);
+
+/**
+ * This function initializes the free memory list used by cvmx_bootmem.
+ * This must be called before any allocations can be done.
+ *
+ * @mem_size: Total memory available, in bytes
+ * @low_reserved_bytes:
+ *                 Number of bytes to reserve (leave out of free list) at address 0x0.
+ * @desc_buffer:
+ *                 Buffer for the bootmem descriptor.  This must be a 32 bit addressable
+ *                 address.
+ *
+ * Returns 1 on success
+ *         0 on failure
+ */
+int64_t cvmx_bootmem_phy_mem_list_init(uint64_t mem_size,
+				       uint32_t low_reserved_bytes,
+				       cvmx_bootmem_desc_t *desc_buffer);
+
+/**
+ * Locks the bootmem allocator.  This is useful in certain situations
+ * where multiple allocations must be made without being interrupted.
+ * This should be used with the CVMX_BOOTMEM_FLAG_NO_LOCKING flag.
+ *
+ */
+void cvmx_bootmem_lock(void);
+
+/**
+ * Unlocks the bootmem allocator.  This is useful in certain situations
+ * where multiple allocations must be made without being interrupted.
+ * This should be used with the CVMX_BOOTMEM_FLAG_NO_LOCKING flag.
+ *
+ */
+void cvmx_bootmem_unlock(void);
+
+/**
+ * Internal use function to get the current descriptor pointer */
+void *__cvmx_bootmem_internal_get_desc_ptr(void);
+
+#endif /*   __CVMX_BOOTMEM_H__ */
diff --git a/arch/mips/include/asm/octeon/cvmx-l2c.h b/arch/mips/include/asm/octeon/cvmx-l2c.h
new file mode 100644
index 0000000..46084e0
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-l2c.h
@@ -0,0 +1,328 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as published by
+ * the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful,
+ * but AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or NONINFRINGEMENT.
+ * See the GNU General Public License for more details.
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
+ * Interface to the Level 2 Cache (L2C) control, measurement, and debugging
+ * facilities.
+ *
+ */
+
+#ifndef __CVMX_L2C_H__
+#define __CVMX_L2C_H__
+
+#define CVMX_L2_ASSOC     cvmx_l2c_get_num_assoc()	/* Deprecated macro, use function */
+#define CVMX_L2_SET_BITS  cvmx_l2c_get_set_bits()	/* Deprecated macro, use function */
+#define CVMX_L2_SETS      cvmx_l2c_get_num_sets()	/* Deprecated macro, use function */
+
+#define CVMX_L2C_IDX_ADDR_SHIFT 7	/* based on 128 byte cache line size */
+#define CVMX_L2C_IDX_MASK       (cvmx_l2c_get_num_sets() - 1)
+
+/* Defines for index aliasing computations */
+#define CVMX_L2C_TAG_ADDR_ALIAS_SHIFT (CVMX_L2C_IDX_ADDR_SHIFT + cvmx_l2c_get_set_bits())
+#define CVMX_L2C_ALIAS_MASK (CVMX_L2C_IDX_MASK << CVMX_L2C_TAG_ADDR_ALIAS_SHIFT)
+
+  /*------------*/
+  /*  TYPEDEFS  */
+  /*------------*/
+typedef union {			/* L2C Tag/Data Store Debug Register */
+	uint64_t u64;
+	struct {
+		uint64_t reserved:32;
+		uint64_t lfb_enum:4;
+		uint64_t lfb_dmp:1;
+		uint64_t ppnum:4;
+		uint64_t set:3;
+		uint64_t finv:1;
+		uint64_t l2d:1;
+		uint64_t l2t:1;
+	};
+} cvmx_l2c_dbg;
+
+typedef union {
+	uint64_t u64;
+	struct {
+		uint64_t reserved:28;
+		uint64_t V:1;	/* Line valid */
+		uint64_t D:1;	/* Line dirty */
+		uint64_t L:1;	/* Line locked */
+		uint64_t U:1;	/* Use, LRU eviction */
+		uint64_t addr:32;	/* Phys mem (not all bits valid) */
+	} s;
+} cvmx_l2c_tag_t;
+
+  /* L2C Performance Counter events. */
+typedef enum {
+	CVMX_L2C_EVENT_CYCLES = 0,
+	CVMX_L2C_EVENT_INSTRUCTION_MISS = 1,
+	CVMX_L2C_EVENT_INSTRUCTION_HIT = 2,
+	CVMX_L2C_EVENT_DATA_MISS = 3,
+	CVMX_L2C_EVENT_DATA_HIT = 4,
+	CVMX_L2C_EVENT_MISS = 5,
+	CVMX_L2C_EVENT_HIT = 6,
+	CVMX_L2C_EVENT_VICTIM_HIT = 7,
+	CVMX_L2C_EVENT_INDEX_CONFLICT = 8,
+	CVMX_L2C_EVENT_TAG_PROBE = 9,
+	CVMX_L2C_EVENT_TAG_UPDATE = 10,
+	CVMX_L2C_EVENT_TAG_COMPLETE = 11,
+	CVMX_L2C_EVENT_TAG_DIRTY = 12,
+	CVMX_L2C_EVENT_DATA_STORE_NOP = 13,
+	CVMX_L2C_EVENT_DATA_STORE_READ = 14,
+	CVMX_L2C_EVENT_DATA_STORE_WRITE = 15,
+	CVMX_L2C_EVENT_FILL_DATA_VALID = 16,
+	CVMX_L2C_EVENT_WRITE_REQUEST = 17,
+	CVMX_L2C_EVENT_READ_REQUEST = 18,
+	CVMX_L2C_EVENT_WRITE_DATA_VALID = 19,
+	CVMX_L2C_EVENT_XMC_NOP = 20,
+	CVMX_L2C_EVENT_XMC_LDT = 21,
+	CVMX_L2C_EVENT_XMC_LDI = 22,
+	CVMX_L2C_EVENT_XMC_LDD = 23,
+	CVMX_L2C_EVENT_XMC_STF = 24,
+	CVMX_L2C_EVENT_XMC_STT = 25,
+	CVMX_L2C_EVENT_XMC_STP = 26,
+	CVMX_L2C_EVENT_XMC_STC = 27,
+	CVMX_L2C_EVENT_XMC_DWB = 28,
+	CVMX_L2C_EVENT_XMC_PL2 = 29,
+	CVMX_L2C_EVENT_XMC_PSL1 = 30,
+	CVMX_L2C_EVENT_XMC_IOBLD = 31,
+	CVMX_L2C_EVENT_XMC_IOBST = 32,
+	CVMX_L2C_EVENT_XMC_IOBDMA = 33,
+	CVMX_L2C_EVENT_XMC_IOBRSP = 34,
+	CVMX_L2C_EVENT_XMC_BUS_VALID = 35,
+	CVMX_L2C_EVENT_XMC_MEM_DATA = 36,
+	CVMX_L2C_EVENT_XMC_REFL_DATA = 37,
+	CVMX_L2C_EVENT_XMC_IOBRSP_DATA = 38,
+	CVMX_L2C_EVENT_RSC_NOP = 39,
+	CVMX_L2C_EVENT_RSC_STDN = 40,
+	CVMX_L2C_EVENT_RSC_FILL = 41,
+	CVMX_L2C_EVENT_RSC_REFL = 42,
+	CVMX_L2C_EVENT_RSC_STIN = 43,
+	CVMX_L2C_EVENT_RSC_SCIN = 44,
+	CVMX_L2C_EVENT_RSC_SCFL = 45,
+	CVMX_L2C_EVENT_RSC_SCDN = 46,
+	CVMX_L2C_EVENT_RSC_DATA_VALID = 47,
+	CVMX_L2C_EVENT_RSC_VALID_FILL = 48,
+	CVMX_L2C_EVENT_RSC_VALID_STRSP = 49,
+	CVMX_L2C_EVENT_RSC_VALID_REFL = 50,
+	CVMX_L2C_EVENT_LRF_REQ = 51,
+	CVMX_L2C_EVENT_DT_RD_ALLOC = 52,
+	CVMX_L2C_EVENT_DT_WR_INVAL = 53
+} cvmx_l2c_event_t;
+
+/**
+ * Configure one of the four L2 Cache performance counters to capture event
+ * occurences.
+ *
+ * @counter:        The counter to configure. Range 0..3.
+ * @event:          The type of L2 Cache event occurrence to count.
+ * @clear_on_read:  When asserted, any read of the performance counter
+ *                       clears the counter.
+ *
+ * @note The routine does not clear the counter.
+ */
+void cvmx_l2c_config_perf(uint32_t counter,
+			  cvmx_l2c_event_t event, uint32_t clear_on_read);
+/**
+ * Read the given L2 Cache performance counter. The counter must be configured
+ * before reading, but this routine does not enforce this requirement.
+ *
+ * @counter:  The counter to configure. Range 0..3.
+ *
+ * Returns The current counter value.
+ */
+uint64_t cvmx_l2c_read_perf(uint32_t counter);
+
+/**
+ * Return the L2 Cache way partitioning for a given core.
+ *
+ * @core:  The core processor of interest.
+ *
+ * Returns    The mask specifying the partitioning. 0 bits in mask indicates
+ *              the cache 'ways' that a core can evict from.
+ *            -1 on error
+ */
+int cvmx_l2c_get_core_way_partition(uint32_t core);
+
+/**
+ * Partitions the L2 cache for a core
+ *
+ * @core:   The core that the partitioning applies to.
+ * @mask: The partitioning of the ways expressed as a binary mask. A 0 bit allows the core
+ *             to evict cache lines from a way, while a 1 bit blocks the core from evicting any lines
+ *             from that way. There must be at least one allowed way (0 bit) in the mask.
+ *
+ * @note  If any ways are blocked for all cores and the HW blocks, then those ways will never have
+ *        any cache lines evicted from them.  All cores and the hardware blocks are free to read from
+ *        all ways regardless of the partitioning.
+ */
+int cvmx_l2c_set_core_way_partition(uint32_t core, uint32_t mask);
+
+/**
+ * Return the L2 Cache way partitioning for the hw blocks.
+ *
+ * Returns    The mask specifying the reserved way. 0 bits in mask indicates
+ *              the cache 'ways' that a core can evict from.
+ *            -1 on error
+ */
+int cvmx_l2c_get_hw_way_partition(void);
+
+/**
+ * Partitions the L2 cache for the hardware blocks.
+ *
+ * @mask: The partitioning of the ways expressed as a binary mask. A 0 bit allows the core
+ *             to evict cache lines from a way, while a 1 bit blocks the core from evicting any lines
+ *             from that way. There must be at least one allowed way (0 bit) in the mask.
+ *
+ * @note  If any ways are blocked for all cores and the HW blocks, then those ways will never have
+ *        any cache lines evicted from them.  All cores and the hardware blocks are free to read from
+ *        all ways regardless of the partitioning.
+ */
+int cvmx_l2c_set_hw_way_partition(uint32_t mask);
+
+/**
+ * Locks a line in the L2 cache at the specified physical address
+ *
+ * @addr:   physical address of line to lock
+ *
+ * Returns 0 on success,
+ *         1 if line not locked.
+ */
+int cvmx_l2c_lock_line(uint64_t addr);
+
+/**
+ * Locks a specified memory region in the L2 cache.
+ *
+ * Note that if not all lines can be locked, that means that all
+ * but one of the ways (associations) available to the locking
+ * core are locked.  Having only 1 association available for
+ * normal caching may have a significant adverse affect on performance.
+ * Care should be taken to ensure that enough of the L2 cache is left
+ * unlocked to allow for normal caching of DRAM.
+ *
+ * @start:  Physical address of the start of the region to lock
+ * @len:    Length (in bytes) of region to lock
+ *
+ * Returns Number of requested lines that where not locked.
+ *         0 on success (all locked)
+ */
+int cvmx_l2c_lock_mem_region(uint64_t start, uint64_t len);
+
+/**
+ * Unlock and flush a cache line from the L2 cache.
+ * IMPORTANT: Must only be run by one core at a time due to use
+ * of L2C debug features.
+ * Note that this function will flush a matching but unlocked cache line.
+ * (If address is not in L2, no lines are flushed.)
+ *
+ * @address: Physical address to unlock
+ *
+ * Returns 0: line not unlocked
+ *         1: line unlocked
+ */
+int cvmx_l2c_unlock_line(uint64_t address);
+
+/**
+ * Unlocks a region of memory that is locked in the L2 cache
+ *
+ * @start:  start physical address
+ * @len:    length (in bytes) to unlock
+ *
+ * Returns Number of locked lines that the call unlocked
+ */
+int cvmx_l2c_unlock_mem_region(uint64_t start, uint64_t len);
+
+/**
+ * Read the L2 controller tag for a given location in L2
+ *
+ * @association:
+ *               Which association to read line from
+ * @index:  Which way to read from.
+ *
+ * Returns l2c tag structure for line requested.
+ */
+cvmx_l2c_tag_t cvmx_l2c_get_tag(uint32_t association, uint32_t index);
+
+/* Wrapper around deprecated old function name */
+static inline cvmx_l2c_tag_t cvmx_get_l2c_tag(uint32_t association,
+					      uint32_t index)
+{
+	return cvmx_l2c_get_tag(association, index);
+}
+
+/**
+ * Returns the cache index for a given physical address
+ *
+ * @addr:   physical address
+ *
+ * Returns L2 cache index
+ */
+uint32_t cvmx_l2c_address_to_index(uint64_t addr);
+
+/**
+ * Flushes (and unlocks) the entire L2 cache.
+ * IMPORTANT: Must only be run by one core at a time due to use
+ * of L2C debug features.
+ */
+void cvmx_l2c_flush(void);
+
+/**
+ *
+ * Returns Returns the size of the L2 cache in bytes,
+ * -1 on error (unrecognized model)
+ */
+int cvmx_l2c_get_cache_size_bytes(void);
+
+/**
+ * Return the number of sets in the L2 Cache
+ *
+ * Returns
+ */
+int cvmx_l2c_get_num_sets(void);
+
+/**
+ * Return log base 2 of the number of sets in the L2 cache
+ * Returns
+ */
+int cvmx_l2c_get_set_bits(void);
+/**
+ * Return the number of associations in the L2 Cache
+ *
+ * Returns
+ */
+int cvmx_l2c_get_num_assoc(void);
+
+/**
+ * Flush a line from the L2 cache
+ * This should only be called from one core at a time, as this routine
+ * sets the core to the 'debug' core in order to flush the line.
+ *
+ * @assoc:  Association (or way) to flush
+ * @index:  Index to flush
+ */
+void cvmx_l2c_flush_line(uint32_t assoc, uint32_t index);
+
+#endif /* __CVMX_L2C_H__ */
diff --git a/arch/mips/include/asm/octeon/cvmx-packet.h b/arch/mips/include/asm/octeon/cvmx-packet.h
new file mode 100644
index 0000000..1f5d5a2
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-packet.h
@@ -0,0 +1,64 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as published by
+ * the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful,
+ * but AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or NONINFRINGEMENT.
+ * See the GNU General Public License for more details.
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
+ * Packet buffer defines.
+ *
+ *
+ */
+
+#ifndef __CVMX_PACKET_H__
+#define __CVMX_PACKET_H__
+
+/**
+ * This structure defines a buffer pointer on Octeon
+ */
+typedef union {
+	void *ptr;
+	uint64_t u64;
+	struct {
+		/* if set, invert the "free" pick of the overall
+		 * packet. HW always sets this bit to 0 on inbound
+		 * packet */
+		uint64_t i:1;
+
+		/* Indicates the amount to back up to get to the
+		 * buffer start in cache lines. In most cases this is
+		 * less than one complete cache line, so the value is
+		 * zero */
+		uint64_t back:4;
+		/* The pool that the buffer came from / goes to */
+		uint64_t pool:3;
+		/* The size of the segment pointed to by addr (in bytes) */
+		uint64_t size:16;
+		/* Pointer to the first byte of the data, NOT buffer */
+		uint64_t addr:40;
+	} s;
+} cvmx_buf_ptr_t;
+
+#endif /*  __CVMX_PACKET_H__ */
diff --git a/arch/mips/include/asm/octeon/cvmx-platform.h b/arch/mips/include/asm/octeon/cvmx-platform.h
new file mode 100644
index 0000000..696e88f
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-platform.h
@@ -0,0 +1,56 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as published by
+ * the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful,
+ * but AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or NONINFRINGEMENT.
+ * See the GNU General Public License for more details.
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
+ * This file is resposible for including all system dependent
+ * headers for the cvmx-* files.
+ *
+*/
+
+#ifndef __CVMX_PLATFORM_H__
+#define __CVMX_PLATFORM_H__
+
+
+/* This file defines macros for use in determining the current
+    building environment. It defines a single CVMX_BUILD_FOR_*
+    macro representing the target of the build. The current
+    possibilities are:
+	CVMX_BUILD_FOR_UBOOT
+	CVMX_BUILD_FOR_LINUX_KERNEL
+	CVMX_BUILD_FOR_LINUX_USER
+	CVMX_BUILD_FOR_LINUX_HOST
+	CVMX_BUILD_FOR_VXWORKS
+	CVMX_BUILD_FOR_STANDALONE */
+/* We are in the Linux kernel on Octeon */
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <stdarg.h>
+
+#endif /* __CVMX_PLATFORM_H__ */
diff --git a/arch/mips/include/asm/octeon/cvmx-spinlock.h b/arch/mips/include/asm/octeon/cvmx-spinlock.h
new file mode 100644
index 0000000..5cd752d
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-spinlock.h
@@ -0,0 +1,376 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as published by
+ * the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful,
+ * but AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or NONINFRINGEMENT.
+ * See the GNU General Public License for more details.
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
+ * Implementation of spinlocks.
+ *
+ */
+
+#ifndef __CVMX_SPINLOCK_H__
+#define __CVMX_SPINLOCK_H__
+
+#include "cvmx-asm.h"
+
+/* Spinlocks for Octeon */
+
+/* define these to enable recursive spinlock debugging */
+/*#define CVMX_SPINLOCK_DEBUG */
+
+/**
+ * Spinlocks for Octeon
+ */
+typedef struct {
+	volatile uint32_t value;
+} cvmx_spinlock_t;
+
+/* note - macros not expanded in inline ASM, so values hardcoded */
+#define  CVMX_SPINLOCK_UNLOCKED_VAL  0
+#define  CVMX_SPINLOCK_LOCKED_VAL    1
+
+#define CVMX_SPINLOCK_UNLOCKED_INITIALIZER  {CVMX_SPINLOCK_UNLOCKED_VAL}
+
+/**
+ * Initialize a spinlock
+ *
+ * @lock:   Lock to initialize
+ */
+static inline void cvmx_spinlock_init(cvmx_spinlock_t *lock)
+{
+	lock->value = CVMX_SPINLOCK_UNLOCKED_VAL;
+}
+
+/**
+ * Return non-zero if the spinlock is currently locked
+ *
+ * @lock:   Lock to check
+ * Returns Non-zero if locked
+ */
+static inline int cvmx_spinlock_locked(cvmx_spinlock_t *lock)
+{
+	return lock->value != CVMX_SPINLOCK_UNLOCKED_VAL;
+}
+
+/**
+ * Releases lock
+ *
+ * @lock:   pointer to lock structure
+ */
+static inline void cvmx_spinlock_unlock(cvmx_spinlock_t *lock)
+{
+	CVMX_SYNCWS;
+	lock->value = 0;
+	CVMX_SYNCWS;
+}
+
+/**
+ * Attempts to take the lock, but does not spin if lock is not available.
+ * May take some time to acquire the lock even if it is available
+ * due to the ll/sc not succeeding.
+ *
+ * @lock:   pointer to lock structure
+ *
+ * Returns 0: lock successfully taken
+ *         1: lock not taken, held by someone else
+ * These return values match the Linux semantics.
+ */
+
+static inline unsigned int cvmx_spinlock_trylock(cvmx_spinlock_t *lock)
+{
+	unsigned int tmp;
+
+	__asm__ __volatile__(".set noreorder         \n" "1: ll   %[tmp], %[val] \n" "   bnez %[tmp], 2f     \n"	/* if lock held, fail immediately */
+			     "   li   %[tmp], 1      \n"
+			     "   sc   %[tmp], %[val] \n"
+			     "   beqz %[tmp], 1b     \n"
+			     "   li   %[tmp], 0      \n"
+			     "2:                     \n"
+			     ".set reorder           \n" :
+			[val] "+m"(lock->value), [tmp] "=&r"(tmp)
+			     : : "memory");
+
+	return tmp != 0;		/* normalize to 0 or 1 */
+}
+
+/**
+ * Gets lock, spins until lock is taken
+ *
+ * @lock:   pointer to lock structure
+ */
+static inline void cvmx_spinlock_lock(cvmx_spinlock_t *lock)
+{
+	unsigned int tmp;
+
+	__asm__ __volatile__(".set noreorder         \n"
+			     "1: ll   %[tmp], %[val]  \n"
+			     "   bnez %[tmp], 1b     \n"
+			     "   li   %[tmp], 1      \n"
+			     "   sc   %[tmp], %[val] \n"
+			     "   beqz %[tmp], 1b     \n"
+			     "   nop                \n"
+			     ".set reorder           \n" :
+			[val] "+m"(lock->value), [tmp] "=&r"(tmp)
+			: : "memory");
+
+}
+
+/** ********************************************************************
+ * Bit spinlocks
+ * These spinlocks use a single bit (bit 31) of a 32 bit word for locking.
+ * The rest of the bits in the word are left undisturbed.  This enables more
+ * compact data structures as only 1 bit is consumed for the lock.
+ *
+ */
+
+/**
+ * Gets lock, spins until lock is taken
+ * Preserves the low 31 bits of the 32 bit
+ * word used for the lock.
+ *
+ *
+ * @word:  word to lock bit 31 of
+ */
+static inline void cvmx_spinlock_bit_lock(uint32_t * word)
+{
+	unsigned int tmp;
+	unsigned int sav;
+
+	__asm__ __volatile__(".set noreorder         \n"
+			     ".set noat              \n"
+			     "1: ll    %[tmp], %[val]  \n"
+			     "   bbit1 %[tmp], 31, 1b    \n"
+			     "   li    $at, 1      \n"
+			     "   ins   %[tmp], $at, 31, 1  \n"
+			     "   sc    %[tmp], %[val] \n"
+			     "   beqz  %[tmp], 1b     \n"
+			     "   nop                \n"
+			     ".set at              \n"
+			     ".set reorder           \n" :
+			[val] "+m"(*word), [tmp] "=&r"(tmp), [sav] "=&r"(sav)
+			     : : "memory");
+
+}
+
+/**
+ * Attempts to get lock, returns immediately with success/failure
+ * Preserves the low 31 bits of the 32 bit
+ * word used for the lock.
+ *
+ *
+ * @word:  word to lock bit 31 of
+ * Returns 0: lock successfully taken
+ *         1: lock not taken, held by someone else
+ * These return values match the Linux semantics.
+ */
+static inline unsigned int cvmx_spinlock_bit_trylock(uint32_t *word)
+{
+	unsigned int tmp;
+
+	__asm__ __volatile__(".set noreorder         \n" ".set noat              \n" "1: ll    %[tmp], %[val] \n" "   bbit1 %[tmp], 31, 2f     \n"	/* if lock held, fail immediately */
+			     "   li    $at, 1      \n"
+			     "   ins   %[tmp], $at, 31, 1  \n"
+			     "   sc    %[tmp], %[val] \n"
+			     "   beqz  %[tmp], 1b     \n"
+			     "   li    %[tmp], 0      \n"
+			     "2:                     \n"
+			     ".set at              \n"
+			     ".set reorder           \n" :
+			[val] "+m"(*word), [tmp] "=&r"(tmp)
+			: : "memory");
+
+	return tmp != 0;		/* normalize to 0 or 1 */
+}
+
+/**
+ * Releases bit lock
+ *
+ * Unconditionally clears bit 31 of the lock word.  Note that this is
+ * done non-atomically, as this implementation assumes that the rest
+ * of the bits in the word are protected by the lock.
+ *
+ * @word:  word to unlock bit 31 in
+ */
+static inline void cvmx_spinlock_bit_unlock(uint32_t *word)
+{
+	CVMX_SYNCWS;
+	*word &= ~(1UL << 31);
+	CVMX_SYNCWS;
+}
+
+/** ********************************************************************
+ * Recursive spinlocks
+ */
+typedef struct {
+	volatile unsigned int value;
+	volatile unsigned int core_num;
+} cvmx_spinlock_rec_t;
+
+/**
+ * Initialize a recursive spinlock
+ *
+ * @lock:   Lock to initialize
+ */
+static inline void cvmx_spinlock_rec_init(cvmx_spinlock_rec_t *lock)
+{
+	lock->value = CVMX_SPINLOCK_UNLOCKED_VAL;
+}
+
+/**
+ * Return non-zero if the recursive spinlock is currently locked
+ *
+ * @lock:   Lock to check
+ * Returns Non-zero if locked
+ */
+static inline int cvmx_spinlock_rec_locked(cvmx_spinlock_rec_t *lock)
+{
+	return lock->value != CVMX_SPINLOCK_UNLOCKED_VAL;
+}
+
+/**
+* Unlocks one level of recursive spinlock.  Lock is not unlocked
+* unless this is the final unlock call for that spinlock
+*
+* @lock:   ptr to recursive spinlock structure
+*/
+static inline void cvmx_spinlock_rec_unlock(cvmx_spinlock_rec_t *lock);
+
+#ifdef CVMX_SPINLOCK_DEBUG
+#define cvmx_spinlock_rec_unlock(x)  _int_cvmx_spinlock_rec_unlock((x), __FILE__, __LINE__)
+static inline void _int_cvmx_spinlock_rec_unlock(cvmx_spinlock_rec_t *lock,
+						 char *filename, int linenum)
+#else
+static inline void cvmx_spinlock_rec_unlock(cvmx_spinlock_rec_t *lock)
+#endif
+{
+
+	unsigned int temp, result;
+	int core_num;
+	core_num = cvmx_get_core_num();
+
+#ifdef CVMX_SPINLOCK_DEBUG
+	{
+		if (lock->core_num != core_num) {
+			cvmx_dprintf
+			    ("ERROR: Recursive spinlock release attemped by non-owner! file: %s, line: %d\n",
+			     filename, linenum);
+			return;
+		}
+	}
+#endif
+
+	__asm__ __volatile__(".set  noreorder                 \n"
+			     "     addi  %[tmp], %[pid], 0x80 \n"
+			     "     sw    %[tmp], %[lid]       # set lid to invalid value\n"
+			     CVMX_SYNCWS_STR
+			     "1:   ll    %[tmp], %[val]       \n"
+			     "     addu  %[res], %[tmp], -1   # decrement lock count\n"
+			     "     sc    %[res], %[val]       \n"
+			     "     beqz  %[res], 1b           \n"
+			     "     nop                        \n"
+			     "     beq   %[tmp], %[res], 2f   # res is 1 on successful sc       \n"
+			     "     nop                        \n"
+			     "     sw   %[pid], %[lid]        # set lid to pid, only if lock still held\n"
+			     "2:                         \n"
+			     CVMX_SYNCWS_STR
+			     ".set  reorder                   \n":[res]
+			     "=&r"(result),[tmp] "=&r"(temp),
+			     [val] "+m"(lock->value),[lid] "+m"(lock->core_num)
+			     :[pid] "r"(core_num)
+			     :"memory");
+
+#ifdef CVMX_SPINLOCK_DEBUG
+	{
+		if (lock->value == ~0UL) {
+			cvmx_dprintf
+			    ("ERROR: Recursive spinlock released too many times! file: %s, line: %d\n",
+			     filename, linenum);
+		}
+	}
+#endif
+
+}
+
+/**
+ * Takes recursive spinlock for a given core.  A core can take the lock multiple
+ * times, and the lock is released only when the corresponding number of
+ * unlocks have taken place.
+ *
+ * NOTE: This assumes only one thread per core, and that the core ID is used as
+ * the lock 'key'.  (This implementation cannot be generalized to allow
+ * multiple threads to use the same key (core id) .)
+ *
+ * @lock:   address of recursive spinlock structure.  Note that this is
+ *               distinct from the standard spinlock
+ */
+static inline void cvmx_spinlock_rec_lock(cvmx_spinlock_rec_t *lock);
+
+#ifdef CVMX_SPINLOCK_DEBUG
+#define cvmx_spinlock_rec_lock(x)  _int_cvmx_spinlock_rec_lock((x), __FILE__, __LINE__)
+static inline void _int_cvmx_spinlock_rec_lock(cvmx_spinlock_rec_t *lock,
+					       char *filename, int linenum)
+#else
+static inline void cvmx_spinlock_rec_lock(cvmx_spinlock_rec_t *lock)
+#endif
+{
+
+	volatile unsigned int tmp;
+	volatile int core_num;
+
+	core_num = cvmx_get_core_num();
+
+	__asm__ __volatile__(".set  noreorder              \n"
+			     "1: ll   %[tmp], %[val]       # load the count\n"
+			     "   bnez %[tmp], 2f           # if count!=zero branch to 2\n"
+			     "   addu %[tmp], %[tmp], 1    \n"
+			     "   sc   %[tmp], %[val]       \n"
+			     "   beqz %[tmp], 1b           # go back if not success\n"
+			     "   nop                       \n"
+			     "   j    3f                   # go to write core_num \n"
+			     "2: lw   %[tmp], %[lid]       # load the core_num \n"
+			     "   bne  %[tmp], %[pid], 1b   # core_num no match, restart\n"
+			     "   nop                       \n"
+			     "   lw   %[tmp], %[val]       \n"
+			     "   addu %[tmp], %[tmp], 1    \n"
+			     "   sw   %[tmp], %[val]       # update the count\n"
+			     "3: sw   %[pid], %[lid]       # store the core_num\n"
+			     CVMX_SYNCWS_STR
+			     ".set  reorder                \n":[tmp] "=&r"(tmp),
+			     [val] "+m"(lock->value),[lid] "+m"(lock->core_num)
+			     :[pid] "r"(core_num)
+			     :"memory");
+
+#ifdef CVMX_SPINLOCK_DEBUG
+	if (lock->core_num != core_num) {
+		cvmx_dprintf
+		    ("cvmx_spinlock_rec_lock: lock taken, but core_num is incorrect. file: %s, line: %d\n",
+		     filename, linenum);
+	}
+#endif
+
+}
+
+#endif /* __CVMX_SPINLOCK_H__ */
diff --git a/arch/mips/include/asm/octeon/cvmx-sysinfo.h b/arch/mips/include/asm/octeon/cvmx-sysinfo.h
new file mode 100644
index 0000000..ee1571b
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-sysinfo.h
@@ -0,0 +1,144 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as published by
+ * the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful,
+ * but AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or NONINFRINGEMENT.
+ * See the GNU General Public License for more details.
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
+ * This module provides system/board information obtained by the bootloader.
+ *
+ *
+ */
+
+#ifndef __CVMX_SYSINFO_H__
+#define __CVMX_SYSINFO_H__
+
+#define OCTEON_SERIAL_LEN 20
+/**
+ * Structure describing application specific information.
+ * __cvmx_app_init() populates this from the cvmx boot descriptor.
+ * This structure is private to simple executive applications, so
+ * no versioning is required.
+ *
+ * This structure must be provided with some fields set in order to use
+ * simple executive functions in other applications (Linux kernel, u-boot, etc.)
+ * The cvmx_sysinfo_minimal_initialize() function is provided to set the required values
+ * in these cases.
+ *
+ *
+ */
+typedef struct {
+	/* System wide variables */
+	uint64_t system_dram_size;
+				/**< installed DRAM in system, in bytes */
+	void *phy_mem_desc_ptr;
+			     /**< ptr to memory descriptor block */
+
+	/* Application image specific variables */
+	uint64_t stack_top;
+			 /**< stack top address (virtual) */
+	uint64_t heap_base;
+			 /**< heap base address (virtual) */
+	uint32_t stack_size;
+			 /**< stack size in bytes */
+	uint32_t heap_size;
+			 /**< heap size in bytes */
+	uint32_t core_mask;
+			 /**< coremask defining cores running application */
+	uint32_t init_core;
+			 /**< Deprecated, use cvmx_coremask_first_core() to select init core */
+	uint64_t exception_base_addr;
+				   /**< exception base address, as set by bootloader */
+	uint32_t cpu_clock_hz;
+			       /**< cpu clock speed in hz */
+	uint32_t dram_data_rate_hz;
+				 /**< dram data rate in hz (data rate = 2 * clock rate */
+
+	uint16_t board_type;
+	uint8_t board_rev_major;
+	uint8_t board_rev_minor;
+	uint8_t mac_addr_base[6];
+	uint8_t mac_addr_count;
+	char board_serial_number[OCTEON_SERIAL_LEN];
+	/* Several boards support compact flash on the Octeon boot bus.  The CF
+	 ** memory spaces may be mapped to different addresses on different boards.
+	 ** These values will be 0 if CF is not present.
+	 ** Note that these addresses are physical addresses, and it is up to the application
+	 ** to use the proper addressing mode (XKPHYS, KSEG0, etc.)*/
+	uint64_t compact_flash_common_base_addr;
+	uint64_t compact_flash_attribute_base_addr;
+	/* Base address of the LED display (as on EBT3000 board)
+	 ** This will be 0 if LED display not present.
+	 ** Note that this address is a physical address, and it is up to the application
+	 ** to use the proper addressing mode (XKPHYS, KSEG0, etc.)*/
+	uint64_t led_display_base_addr;
+	uint32_t dfa_ref_clock_hz;
+				/**< DFA reference clock in hz (if applicable)*/
+	uint32_t bootloader_config_flags;
+				       /**< configuration flags from bootloader */
+	uint8_t console_uart_num;
+				       /** < Uart number used for console */
+} cvmx_sysinfo_t;
+
+/**
+ * This function returns the system/board information as obtained
+ * by the bootloader.
+ *
+ *
+ * Returns  Pointer to the boot information structure
+ *
+ */
+
+extern cvmx_sysinfo_t *cvmx_sysinfo_get(void);
+
+/**
+ * This function is used in non-simple executive environments (such as Linux kernel, u-boot, etc.)
+ * to configure the minimal fields that are required to use
+ * simple executive files directly.
+ *
+ * Locking (if required) must be handled outside of this
+ * function
+ *
+ * @phy_mem_desc_ptr:
+ *                   Pointer to global physical memory descriptor (bootmem descriptor)
+ * @board_type: Octeon board type enumeration
+ *
+ * @board_rev_major:
+ *                   Board major revision
+ * @board_rev_minor:
+ *                   Board minor revision
+ * @cpu_clock_hz:
+ *                   CPU clock freqency in hertz
+ *
+ * Returns 0: Failure
+ *         1: success
+ */
+extern int cvmx_sysinfo_minimal_initialize(void *phy_mem_desc_ptr,
+					   uint16_t board_type,
+					   uint8_t board_rev_major,
+					   uint8_t board_rev_minor,
+					   uint32_t cpu_clock_hz);
+
+#endif /* __CVMX_SYSINFO_H__ */
diff --git a/arch/mips/include/asm/octeon/cvmx-warn.h b/arch/mips/include/asm/octeon/cvmx-warn.h
new file mode 100644
index 0000000..b3538e7
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-warn.h
@@ -0,0 +1,40 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as published by
+ * the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful,
+ * but AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or NONINFRINGEMENT.
+ * See the GNU General Public License for more details.
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
+ * Functions for warning users about errors and such.
+ *
+ *
+ */
+#ifndef __CVMX_WARN_H__
+#define __CVMX_WARN_H__
+
+#define cvmx_warn(format, ...) pr_warning(format, ##__VA_ARGS__)
+#define cvmx_warn_if(expression, format, ...) if (expression) cvmx_warn(format, ##__VA_ARGS__)
+
+#endif /* __CVMX_WARN_H__ */
diff --git a/arch/mips/include/asm/octeon/cvmx.h b/arch/mips/include/asm/octeon/cvmx.h
new file mode 100644
index 0000000..e4152e4
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx.h
@@ -0,0 +1,776 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as published by
+ * the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful,
+ * but AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or NONINFRINGEMENT.
+ * See the GNU General Public License for more details.
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
+ * Main Octeon executive header file (This should be the second header
+ * file included by an application).
+ *
+ */
+#ifndef __CVMX_H__
+#define __CVMX_H__
+
+/* Control whether simple executive applications use 1-1 TLB mappings
+** to access physical memory addresses.  This must be disabled to
+** allow large programs that use more than the 0x10000000 - 0x20000000
+** virtual address range.
+*/
+#ifndef CVMX_USE_1_TO_1_TLB_MAPPINGS
+#define CVMX_USE_1_TO_1_TLB_MAPPINGS 1
+#endif
+
+#include "cvmx-platform.h"
+#include "cvmx-asm.h"
+#include "cvmx-packet.h"
+#include "cvmx-warn.h"
+#include "cvmx-sysinfo.h"
+
+#include "cvmx-ciu-defs.h"
+#include "cvmx-gpio-defs.h"
+#include "cvmx-iob-defs.h"
+#include "cvmx-ipd-defs.h"
+#include "cvmx-l2c-defs.h"
+#include "cvmx-l2d-defs.h"
+#include "cvmx-l2t-defs.h"
+#include "cvmx-led-defs.h"
+#include "cvmx-mio-defs.h"
+#include "cvmx-pow-defs.h"
+
+#include "cvmx-bootinfo.h"
+#include "cvmx-bootmem.h"
+#include "cvmx-l2c.h"
+
+#define EXTERN_ASM extern
+#define CVMX_SHARED
+
+#ifndef CVMX_ENABLE_PARAMETER_CHECKING
+#define CVMX_ENABLE_PARAMETER_CHECKING 1
+#endif
+
+#ifndef CVMX_ENABLE_DEBUG_PRINTS
+#define CVMX_ENABLE_DEBUG_PRINTS 1
+#endif
+
+#if CVMX_ENABLE_DEBUG_PRINTS
+#define cvmx_dprintf        printk
+#else
+#define cvmx_dprintf(...)   {}
+#endif
+
+#define CVMX_MAX_CORES          (16)
+#define CVMX_CACHE_LINE_SIZE    (128)	/* In bytes */
+#define CVMX_CACHE_LINE_MASK    (CVMX_CACHE_LINE_SIZE - 1)	/* In bytes */
+#define CVMX_CACHE_LINE_ALIGNED __attribute__ ((aligned(CVMX_CACHE_LINE_SIZE)))
+#define CAST64(v) ((long long)(long)(v))
+#define CASTPTR(type, v) ((type *)(long)(v))
+
+/* simprintf uses simulator tricks to speed up printouts.  The format
+** and args are passed to the simulator and processed natively on the host.
+** Simprintf is limited to 7 arguments, and they all must use %ll (long long)
+** format specifiers to be displayed correctly.
+*/
+EXTERN_ASM void simprintf(const char *format, ...);
+
+/**
+ * This function performs some default initialization of the Octeon
+ * executive.  It initializes the cvmx_bootmem memory allocator with
+ * the list of physical memory provided by the bootloader, and creates
+ * 1-1 TLB mappings for this memory.  This function should be called
+ * on all cores that will use either the bootmem allocator or the 1-1
+ * TLB mappings.  Applications which require a different configuration
+ * can replace this function with a suitable application specific one.
+ *
+ * Returns 0 on success
+ *         -1 on failure
+ */
+int cvmx_user_app_init(void);
+
+/* Returns processor ID, different Linux and simple exec versions
+** provided in the cvmx-app-init*.c files */
+static inline uint32_t cvmx_get_proc_id(void) __attribute__ ((pure));
+static inline uint32_t cvmx_get_proc_id(void)
+{
+	uint32_t id;
+	asm("mfc0 %0, $15,0" : "=r"(id));
+	return id;
+}
+
+/* turn the variable name into a string */
+#define CVMX_TMP_STR(x) CVMX_TMP_STR2(x)
+#define CVMX_TMP_STR2(x) #x
+/*
+ * The macros cvmx_likely and cvmx_unlikely use the
+ * __builtin_expect GCC operation to control branch
+ * probabilities for a conditional. For example, an "if"
+ * statement in the code that will almost always be
+ * executed should be written as "if (cvmx_likely(...))".
+ * If the "else" section of an if statement is more
+ * probable, use "if (cvmx_unlikey(...))".
+ */
+#define cvmx_likely(x)      __builtin_expect(!!(x), 1)
+#define cvmx_unlikely(x)    __builtin_expect(!!(x), 0)
+/**
+ * Builds a bit mask given the required size in bits.
+ *
+ * @bits:   Number of bits in the mask
+ * Returns The mask
+ */ static inline uint64_t cvmx_build_mask(uint64_t bits)
+{
+	return ~((~0x0ull) << bits);
+}
+
+/**
+ * Builds a memory address for I/O based on the Major and Sub DID.
+ *
+ * @major_did: 5 bit major did
+ * @sub_did:   3 bit sub did
+ * Returns I/O base address
+ */
+static inline uint64_t cvmx_build_io_address(uint64_t major_did,
+					     uint64_t sub_did)
+{
+	return (0x1ull << 48) | (major_did << 43) | (sub_did << 40);
+}
+
+/**
+ * Perform mask and shift to place the supplied value into
+ * the supplied bit rage.
+ *
+ * Example: cvmx_build_bits(39,24,value)
+ * <pre>
+ * 6       5       4       3       3       2       1
+ * 3       5       7       9       1       3       5       7      0
+ * +-------+-------+-------+-------+-------+-------+-------+------+
+ * 000000000000000000000000___________value000000000000000000000000
+ * </pre>
+ *
+ * @high_bit: Highest bit value can occupy (inclusive) 0-63
+ * @low_bit:  Lowest bit value can occupy inclusive 0-high_bit
+ * @value:    Value to use
+ * Returns Value masked and shifted
+ */
+static inline uint64_t cvmx_build_bits(uint64_t high_bit,
+				       uint64_t low_bit, uint64_t value)
+{
+	return (value & cvmx_build_mask(high_bit - low_bit + 1)) << low_bit;
+}
+
+#ifndef TRUE
+#define FALSE   0
+#define TRUE    (!(FALSE))
+#endif
+
+typedef enum {
+	CVMX_MIPS_SPACE_XKSEG = 3LL,
+	CVMX_MIPS_SPACE_XKPHYS = 2LL,
+	CVMX_MIPS_SPACE_XSSEG = 1LL,
+	CVMX_MIPS_SPACE_XUSEG = 0LL
+} cvmx_mips_space_t;
+
+typedef enum {
+	CVMX_MIPS_XKSEG_SPACE_KSEG0 = 0LL,
+	CVMX_MIPS_XKSEG_SPACE_KSEG1 = 1LL,
+	CVMX_MIPS_XKSEG_SPACE_SSEG = 2LL,
+	CVMX_MIPS_XKSEG_SPACE_KSEG3 = 3LL
+} cvmx_mips_xkseg_space_t;
+
+/* decodes <14:13> of a kseg3 window address */
+typedef enum {
+	CVMX_ADD_WIN_SCR = 0L,
+	/* see cvmx_add_win_dma_dec_t for further decode */
+	CVMX_ADD_WIN_DMA = 1L,
+	CVMX_ADD_WIN_UNUSED = 2L,
+	CVMX_ADD_WIN_UNUSED2 = 3L
+} cvmx_add_win_dec_t;
+
+/* decode within DMA space */
+typedef enum {
+	/* add store data to the write buffer entry, allocating it if
+	 * necessary */
+	CVMX_ADD_WIN_DMA_ADD = 0L,
+	/* send out the write buffer entry to DRAM */
+	CVMX_ADD_WIN_DMA_SENDMEM = 1L,
+	/* store data must be normal DRAM memory space address in this
+	 * case send out the write buffer entry as an IOBDMA
+	 * command */
+	CVMX_ADD_WIN_DMA_SENDDMA = 2L,
+	/* see CVMX_ADD_WIN_DMA_SEND_DEC for data contents */
+	/* send out the write buffer entry as an IO write */
+	CVMX_ADD_WIN_DMA_SENDIO = 3L,
+	/* store data must be normal IO space address in this case */
+	/* send out a single-tick command on the NCB bus */
+	CVMX_ADD_WIN_DMA_SENDSINGLE = 4L,
+	/* no write buffer data needed/used */
+} cvmx_add_win_dma_dec_t;
+
+/**
+ *   Physical Address Decode
+ *
+ * Octeon-I HW never interprets this X (<39:36> reserved
+ * for future expansion), software should set to 0.
+ *
+ *  - 0x0 XXX0 0000 0000 to      DRAM         Cached
+ *  - 0x0 XXX0 0FFF FFFF
+ *
+ *  - 0x0 XXX0 1000 0000 to      Boot Bus     Uncached  (Converted to 0x1 00X0 1000 0000
+ *  - 0x0 XXX0 1FFF FFFF         + EJTAG                           to 0x1 00X0 1FFF FFFF)
+ *
+ *  - 0x0 XXX0 2000 0000 to      DRAM         Cached
+ *  - 0x0 XXXF FFFF FFFF
+ *
+ *  - 0x1 00X0 0000 0000 to      Boot Bus     Uncached
+ *  - 0x1 00XF FFFF FFFF
+ *
+ *  - 0x1 01X0 0000 0000 to      Other NCB    Uncached
+ *  - 0x1 FFXF FFFF FFFF         devices
+ *
+ * Decode of all Octeon addresses
+ */
+typedef union {
+
+	uint64_t u64;
+
+	struct {
+		cvmx_mips_space_t R:2;
+		uint64_t offset:62;
+	} sva;	/* mapped or unmapped virtual address */
+
+	struct {
+		uint64_t zeroes:33;
+		uint64_t offset:31;
+	} suseg;	/* mapped USEG virtual addresses (typically) */
+
+	struct {
+		uint64_t ones:33;
+		cvmx_mips_xkseg_space_t sp:2;
+		uint64_t offset:29;
+	} sxkseg;	/* mapped or unmapped virtual address */
+
+	struct {
+		cvmx_mips_space_t R:2;	/* CVMX_MIPS_SPACE_XKPHYS in this case */
+		uint64_t cca:3;	/* ignored by octeon */
+		uint64_t mbz:10;
+		uint64_t pa:49;	/* physical address */
+	} sxkphys;	/* physical address accessed through xkphys unmapped virtual address */
+
+	struct {
+		uint64_t mbz:15;
+		uint64_t is_io:1;	/* if set, the address is uncached and resides on MCB bus */
+		uint64_t did:8;	/* the hardware ignores this field when is_io==0, else device ID */
+		uint64_t unaddr:4;	/* the hardware ignores <39:36> in Octeon I */
+		uint64_t offset:36;
+	} sphys;		/* physical address */
+
+	struct {
+		uint64_t zeroes:24;	/* techically, <47:40> are dont-cares */
+		uint64_t unaddr:4;	/* the hardware ignores <39:36> in Octeon I */
+		uint64_t offset:36;
+	} smem;			/* physical mem address */
+
+	struct {
+		uint64_t mem_region:2;
+		uint64_t mbz:13;
+		uint64_t is_io:1;	/* 1 in this case */
+		uint64_t did:8;	/* the hardware ignores this field when is_io==0, else device ID */
+		uint64_t unaddr:4;	/* the hardware ignores <39:36> in Octeon I */
+		uint64_t offset:36;
+	} sio;			/* physical IO address */
+
+	struct {
+		uint64_t ones:49;
+		cvmx_add_win_dec_t csrdec:2;	/* CVMX_ADD_WIN_SCR (0) in this case */
+		uint64_t addr:13;
+	} sscr;			/* scratchpad virtual address - accessed through a window at the end of kseg3 */
+
+	/* there should only be stores to IOBDMA space, no loads */
+	struct {
+		uint64_t ones:49;
+		cvmx_add_win_dec_t csrdec:2;	/* CVMX_ADD_WIN_DMA (1) in this case */
+		uint64_t unused2:3;
+		cvmx_add_win_dma_dec_t type:3;
+		uint64_t addr:7;
+	} sdma;			/* IOBDMA virtual address - accessed through a window at the end of kseg3 */
+
+	struct {
+		uint64_t didspace:24;
+		uint64_t unused:40;
+	} sfilldidspace;
+
+} cvmx_addr_t;
+
+/* These macros for used by 32 bit applications */
+
+#define CVMX_MIPS32_SPACE_KSEG0 1l
+#define CVMX_ADD_SEG32(segment, add)          (((int32_t)segment << 31) | (int32_t)(add))
+
+/* Currently all IOs are performed using XKPHYS addressing. Linux uses the
+    CvmMemCtl register to enable XKPHYS addressing to IO space from user mode.
+    Future OSes may need to change the upper bits of IO addresses. The
+    following define controls the upper two bits for all IO addresses generated
+    by the simple executive library */
+#define CVMX_IO_SEG CVMX_MIPS_SPACE_XKPHYS
+
+/* These macros simplify the process of creating common IO addresses */
+#define CVMX_ADD_SEG(segment, add)          ((((uint64_t)segment) << 62) | (add))
+#ifndef CVMX_ADD_IO_SEG
+#define CVMX_ADD_IO_SEG(add)                CVMX_ADD_SEG(CVMX_IO_SEG, (add))
+#endif
+#define CVMX_ADDR_DIDSPACE(did)             (((CVMX_IO_SEG) << 22) | ((1ULL) << 8) | (did))
+#define CVMX_ADDR_DID(did)                  (CVMX_ADDR_DIDSPACE(did) << 40)
+#define CVMX_FULL_DID(did, subdid)           (((did) << 3) | (subdid))
+
+/* from include/ncb_rsl_id.v */
+#define CVMX_OCT_DID_MIS 0ULL	/* misc stuff */
+#define CVMX_OCT_DID_GMX0 1ULL
+#define CVMX_OCT_DID_GMX1 2ULL
+#define CVMX_OCT_DID_PCI 3ULL
+#define CVMX_OCT_DID_KEY 4ULL
+#define CVMX_OCT_DID_FPA 5ULL
+#define CVMX_OCT_DID_DFA 6ULL
+#define CVMX_OCT_DID_ZIP 7ULL
+#define CVMX_OCT_DID_RNG 8ULL
+#define CVMX_OCT_DID_IPD 9ULL
+#define CVMX_OCT_DID_PKT 10ULL
+#define CVMX_OCT_DID_TIM 11ULL
+#define CVMX_OCT_DID_TAG 12ULL
+/* the rest are not on the IO bus */
+#define CVMX_OCT_DID_L2C 16ULL
+#define CVMX_OCT_DID_LMC 17ULL
+#define CVMX_OCT_DID_SPX0 18ULL
+#define CVMX_OCT_DID_SPX1 19ULL
+#define CVMX_OCT_DID_PIP 20ULL
+#define CVMX_OCT_DID_ASX0 22ULL
+#define CVMX_OCT_DID_ASX1 23ULL
+#define CVMX_OCT_DID_IOB 30ULL
+
+#define CVMX_OCT_DID_PKT_SEND       CVMX_FULL_DID(CVMX_OCT_DID_PKT, 2ULL)
+#define CVMX_OCT_DID_TAG_SWTAG      CVMX_FULL_DID(CVMX_OCT_DID_TAG, 0ULL)
+#define CVMX_OCT_DID_TAG_TAG1       CVMX_FULL_DID(CVMX_OCT_DID_TAG, 1ULL)
+#define CVMX_OCT_DID_TAG_TAG2       CVMX_FULL_DID(CVMX_OCT_DID_TAG, 2ULL)
+#define CVMX_OCT_DID_TAG_TAG3       CVMX_FULL_DID(CVMX_OCT_DID_TAG, 3ULL)
+#define CVMX_OCT_DID_TAG_NULL_RD    CVMX_FULL_DID(CVMX_OCT_DID_TAG, 4ULL)
+#define CVMX_OCT_DID_TAG_CSR        CVMX_FULL_DID(CVMX_OCT_DID_TAG, 7ULL)
+#define CVMX_OCT_DID_FAU_FAI        CVMX_FULL_DID(CVMX_OCT_DID_IOB, 0ULL)
+#define CVMX_OCT_DID_TIM_CSR        CVMX_FULL_DID(CVMX_OCT_DID_TIM, 0ULL)
+#define CVMX_OCT_DID_KEY_RW         CVMX_FULL_DID(CVMX_OCT_DID_KEY, 0ULL)
+#define CVMX_OCT_DID_PCI_6          CVMX_FULL_DID(CVMX_OCT_DID_PCI, 6ULL)
+#define CVMX_OCT_DID_MIS_BOO        CVMX_FULL_DID(CVMX_OCT_DID_MIS, 0ULL)
+#define CVMX_OCT_DID_PCI_RML        CVMX_FULL_DID(CVMX_OCT_DID_PCI, 0ULL)
+#define CVMX_OCT_DID_IPD_CSR        CVMX_FULL_DID(CVMX_OCT_DID_IPD, 7ULL)
+#define CVMX_OCT_DID_DFA_CSR        CVMX_FULL_DID(CVMX_OCT_DID_DFA, 7ULL)
+#define CVMX_OCT_DID_MIS_CSR        CVMX_FULL_DID(CVMX_OCT_DID_MIS, 7ULL)
+#define CVMX_OCT_DID_ZIP_CSR        CVMX_FULL_DID(CVMX_OCT_DID_ZIP, 0ULL)
+
+/**
+ * Convert a memory pointer (void*) into a hardware compatable
+ * memory address (uint64_t). Octeon hardware widgets don't
+ * understand logical addresses.
+ *
+ * @ptr:    C style memory pointer
+ * Returns Hardware physical address
+ */
+static inline uint64_t cvmx_ptr_to_phys(void *ptr)
+{
+	if (CVMX_ENABLE_PARAMETER_CHECKING)
+		cvmx_warn_if(ptr == NULL,
+			     "cvmx_ptr_to_phys() passed a NULL pointer\n");
+	if (sizeof(void *) == 8) {
+		/* We're running in 64 bit mode. Normally this means that we can use
+		   40 bits of address space (the hardware limit). Unfortunately there
+		   is one case were we need to limit this to 30 bits, sign extended
+		   32 bit. Although these are 64 bits wide, only 30 bits can be used */
+		if ((CAST64(ptr) >> 62) == 3)
+			return CAST64(ptr) & cvmx_build_mask(30);
+		else
+			return CAST64(ptr) & cvmx_build_mask(40);
+	} else {
+		return (long)(ptr) & 0x1fffffff;
+	}
+}
+
+/**
+ * Convert a hardware physical address (uint64_t) into a
+ * memory pointer (void *).
+ *
+ * @physical_address:
+ *               Hardware physical address to memory
+ * Returns Pointer to memory
+ */
+static inline void *cvmx_phys_to_ptr(uint64_t physical_address)
+{
+	if (CVMX_ENABLE_PARAMETER_CHECKING)
+		cvmx_warn_if(physical_address == 0,
+			     "cvmx_phys_to_ptr() passed a zero address\n");
+	if (sizeof(void *) == 8) {
+		/* Just set the top bit, avoiding any TLB uglyness */
+		return CASTPTR(void,
+			       CVMX_ADD_SEG(CVMX_MIPS_SPACE_XKPHYS,
+					    physical_address));
+	} else {
+		return CASTPTR(void,
+			       CVMX_ADD_SEG32(CVMX_MIPS32_SPACE_KSEG0,
+					      physical_address));
+	}
+}
+
+/* The following #if controls the definition of the macro
+    CVMX_BUILD_WRITE64. This macro is used to build a store operation to
+    a full 64bit address. With a 64bit ABI, this can be done with a simple
+    pointer access. 32bit ABIs require more complicated assembly */
+
+/* We have a full 64bit ABI. Writing to a 64bit address can be done with
+    a simple volatile pointer */
+#define CVMX_BUILD_WRITE64(TYPE, ST)                                    \
+static inline void cvmx_write64_##TYPE(uint64_t addr, TYPE##_t val)     \
+{                                                                       \
+    *CASTPTR(volatile TYPE##_t, addr) = val;                            \
+}
+
+
+/* The following #if controls the definition of the macro
+    CVMX_BUILD_READ64. This macro is used to build a load operation from
+    a full 64bit address. With a 64bit ABI, this can be done with a simple
+    pointer access. 32bit ABIs require more complicated assembly */
+
+/* We have a full 64bit ABI. Writing to a 64bit address can be done with
+    a simple volatile pointer */
+#define CVMX_BUILD_READ64(TYPE, LT)                                     \
+static inline TYPE##_t cvmx_read64_##TYPE(uint64_t addr)                \
+{                                                                       \
+	return *CASTPTR(volatile TYPE##_t, addr);			\
+}
+
+
+/* The following defines 8 functions for writing to a 64bit address. Each
+    takes two arguments, the address and the value to write.
+    cvmx_write64_int64      cvmx_write64_uint64
+    cvmx_write64_int32      cvmx_write64_uint32
+    cvmx_write64_int16      cvmx_write64_uint16
+    cvmx_write64_int8       cvmx_write64_uint8 */
+CVMX_BUILD_WRITE64(int64, "sd");
+CVMX_BUILD_WRITE64(int32, "sw");
+CVMX_BUILD_WRITE64(int16, "sh");
+CVMX_BUILD_WRITE64(int8, "sb");
+CVMX_BUILD_WRITE64(uint64, "sd");
+CVMX_BUILD_WRITE64(uint32, "sw");
+CVMX_BUILD_WRITE64(uint16, "sh");
+CVMX_BUILD_WRITE64(uint8, "sb");
+#define cvmx_write64 cvmx_write64_uint64
+
+/* The following defines 8 functions for reading from a 64bit address. Each
+    takes the address as the only argument
+    cvmx_read64_int64       cvmx_read64_uint64
+    cvmx_read64_int32       cvmx_read64_uint32
+    cvmx_read64_int16       cvmx_read64_uint16
+    cvmx_read64_int8        cvmx_read64_uint8 */
+CVMX_BUILD_READ64(int64, "ld");
+CVMX_BUILD_READ64(int32, "lw");
+CVMX_BUILD_READ64(int16, "lh");
+CVMX_BUILD_READ64(int8, "lb");
+CVMX_BUILD_READ64(uint64, "ld");
+CVMX_BUILD_READ64(uint32, "lw");
+CVMX_BUILD_READ64(uint16, "lhu");
+CVMX_BUILD_READ64(uint8, "lbu");
+#define cvmx_read64 cvmx_read64_uint64
+
+
+static inline void cvmx_write_csr(uint64_t csr_addr, uint64_t val)
+{
+	cvmx_write64(csr_addr, val);
+
+	/* Perform an immediate read after every write to an RSL register to force
+	   the write to complete. It doesn't matter what RSL read we do, so we
+	   choose CVMX_MIO_BOOT_BIST_STAT because it is fast and harmless */
+	if ((csr_addr >> 40) == (0x800118))
+		cvmx_read64(CVMX_MIO_BOOT_BIST_STAT);
+}
+
+static inline void cvmx_write_io(uint64_t io_addr, uint64_t val)
+{
+	cvmx_write64(io_addr, val);
+
+}
+
+static inline uint64_t cvmx_read_csr(uint64_t csr_addr)
+{
+	uint64_t val = cvmx_read64(csr_addr);
+	return val;
+}
+
+
+static inline void cvmx_send_single(uint64_t data)
+{
+	const uint64_t CVMX_IOBDMA_SENDSINGLE = 0xffffffffffffa200ull;
+	cvmx_write64(CVMX_IOBDMA_SENDSINGLE, data);
+}
+
+static inline void cvmx_read_csr_async(uint64_t scraddr, uint64_t csr_addr)
+{
+	union {
+		uint64_t u64;
+		struct {
+			uint64_t scraddr:8;
+			uint64_t len:8;
+			uint64_t addr:48;
+		} s;
+	} addr;
+	addr.u64 = csr_addr;
+	addr.s.scraddr = scraddr >> 3;
+	addr.s.len = 1;
+	cvmx_send_single(addr.u64);
+}
+
+/* Return true if Octeon is CN38XX pass 1 */
+static inline int cvmx_octeon_is_pass1(void)
+{
+#if OCTEON_IS_COMMON_BINARY()
+	return 0;	/* Pass 1 isn't supported for common binaries */
+#else
+/* Now that we know we're built for a specific model, only check CN38XX */
+#if OCTEON_IS_MODEL(OCTEON_CN38XX)
+	return cvmx_get_proc_id() == OCTEON_CN38XX_PASS1;
+#else
+	return 0;	/* Built for non CN38XX chip, we're not CN38XX pass1 */
+#endif
+#endif
+}
+
+static inline unsigned int cvmx_get_core_num(void)
+{
+	unsigned int core_num;
+	CVMX_RDHWRNV(core_num, 0);
+	return core_num;
+}
+
+/**
+ * Returns the number of bits set in the provided value.
+ * Simple wrapper for POP instruction.
+ *
+ * @val:    32 bit value to count set bits in
+ *
+ * Returns Number of bits set
+ */
+static inline uint32_t cvmx_pop(uint32_t val)
+{
+	uint32_t pop;
+	CVMX_POP(pop, val);
+	return pop;
+}
+
+/**
+ * Returns the number of bits set in the provided value.
+ * Simple wrapper for DPOP instruction.
+ *
+ * @val:    64 bit value to count set bits in
+ *
+ * Returns Number of bits set
+ */
+static inline int cvmx_dpop(uint64_t val)
+{
+	int pop;
+	CVMX_DPOP(pop, val);
+	return pop;
+}
+
+/**
+ * Provide current cycle counter as a return value
+ *
+ * Returns current cycle counter
+ */
+
+static inline uint64_t cvmx_get_cycle(void)
+{
+	uint64_t cycle;
+	CVMX_RDHWR(cycle, 31);
+	return cycle;
+}
+
+/**
+ * Reads a chip global cycle counter.  This counts CPU cycles since
+ * chip reset.  The counter is 64 bit.
+ * This register does not exist on CN38XX pass 1 silicion
+ *
+ * Returns Global chip cycle count since chip reset.
+ */
+static inline uint64_t cvmx_get_cycle_global(void)
+{
+	if (cvmx_octeon_is_pass1())
+		return 0;
+	else
+		return cvmx_read64(CVMX_IPD_CLK_COUNT);
+}
+
+/**
+ * Wait for the specified number of cycle
+ *
+ * @cycles:
+ */
+static inline void cvmx_wait(uint64_t cycles)
+{
+	uint64_t done = cvmx_get_cycle() + cycles;
+
+	while (cvmx_get_cycle() < done) {
+		/* Spin */
+	}
+}
+
+/**
+ * Wait for the specified number of micro seconds
+ *
+ * @usec:   micro seconds to wait
+ */
+static inline void cvmx_wait_usec(uint64_t usec)
+{
+	uint64_t done =
+	    cvmx_get_cycle() +
+	    usec * cvmx_sysinfo_get()->cpu_clock_hz / 1000000;
+	while (cvmx_get_cycle() < done) {
+		/* Spin */
+	}
+}
+
+/**
+ * This macro spins on a field waiting for it to reach a value. It
+ * is common in code to need to wait for a specific field in a CSR
+ * to match a specific value. Conceptually this macro expands to:
+ *
+ * 1) read csr at "address" with a csr typedef of "type"
+ * 2) Check if ("type".s."field" "op" "value")
+ * 3) If #2 isn't true loop to #1 unless too much time has passed.
+ */
+#define CVMX_WAIT_FOR_FIELD64(address, type, field, op, value, timeout_usec)\
+    (									\
+{									\
+	int result;							\
+	do {								\
+		uint64_t done = cvmx_get_cycle() + (uint64_t)timeout_usec * \
+			cvmx_sysinfo_get()->cpu_clock_hz / 1000000;	\
+		type c;							\
+		while (1) {						\
+			c.u64 = cvmx_read_csr(address);			\
+			if ((c.s.field) op(value)) {			\
+				result = 0;				\
+				break;					\
+			} else if (cvmx_get_cycle() > done) {		\
+				result = -1;				\
+				break;					\
+			} else						\
+				cvmx_wait(100);				\
+		}							\
+	} while (0);							\
+	result;								\
+})
+
+/***************************************************************************/
+
+/* Watchdog defines, to be moved.... */
+typedef enum {
+	CVMX_CIU_WDOG_MODE_OFF = 0,
+	CVMX_CIU_WDOG_MODE_INT = 1,
+	CVMX_CIU_WDOG_MODE_INT_NMI = 2,
+	CVMX_CIU_WDOG_MODE_INT_NMI_SR = 3
+} cvmx_ciu_wdog_mode_t;
+
+static inline void cvmx_reset_octeon(void)
+{
+	cvmx_ciu_soft_rst_t ciu_soft_rst;
+	ciu_soft_rst.u64 = 0;
+	ciu_soft_rst.s.soft_rst = 1;
+	cvmx_write_csr(CVMX_CIU_SOFT_RST, ciu_soft_rst.u64);
+}
+
+/* Return the number of cores available in the chip */
+static inline uint32_t cvmx_octeon_num_cores(void)
+{
+	uint32_t ciu_fuse = (uint32_t) cvmx_read_csr(CVMX_CIU_FUSE) & 0xffff;
+	return cvmx_pop(ciu_fuse);
+}
+
+/**
+ * Read a byte of fuse data
+ * @byte_addr:   address to read
+ *
+ * Returns fuse value: 0 or 1
+ */
+static uint8_t cvmx_fuse_read_byte(int byte_addr)
+{
+	cvmx_mio_fus_rcmd_t read_cmd;
+
+	read_cmd.u64 = 0;
+	read_cmd.s.addr = byte_addr;
+	read_cmd.s.pend = 1;
+	cvmx_write_csr(CVMX_MIO_FUS_RCMD, read_cmd.u64);
+	while ((read_cmd.u64 = cvmx_read_csr(CVMX_MIO_FUS_RCMD))
+	       && read_cmd.s.pend)
+		;
+	return read_cmd.s.dat;
+}
+
+/**
+ * Read a single fuse bit
+ *
+ * @fuse:   Fuse number (0-1024)
+ *
+ * Returns fuse value: 0 or 1
+ */
+static inline int cvmx_fuse_read(int fuse)
+{
+	return (cvmx_fuse_read_byte(fuse >> 3) >> (fuse & 0x7)) & 1;
+}
+
+static inline int cvmx_octeon_model_CN36XX(void)
+{
+	return OCTEON_IS_MODEL(OCTEON_CN38XX)
+		&& !cvmx_octeon_is_pass1()
+		&& cvmx_fuse_read(264);
+}
+
+static inline int cvmx_octeon_zip_present(void)
+{
+	return octeon_has_feature(OCTEON_FEATURE_ZIP);
+}
+
+static inline int cvmx_octeon_dfa_present(void)
+{
+	if (!OCTEON_IS_MODEL(OCTEON_CN38XX)
+	    && !OCTEON_IS_MODEL(OCTEON_CN31XX)
+	    && !OCTEON_IS_MODEL(OCTEON_CN58XX))
+		return 0;
+	else if (OCTEON_IS_MODEL(OCTEON_CN3020))
+		return 0;
+	else if (cvmx_octeon_is_pass1())
+		return 1;
+	else
+		return !cvmx_fuse_read(120);
+}
+
+static inline int cvmx_octeon_crypto_present(void)
+{
+	return octeon_has_feature(OCTEON_FEATURE_CRYPTO);
+}
+
+#endif /*  __CVMX_H__  */
diff --git a/arch/mips/include/asm/octeon/octeon-feature.h b/arch/mips/include/asm/octeon/octeon-feature.h
new file mode 100644
index 0000000..d40f34b
--- /dev/null
+++ b/arch/mips/include/asm/octeon/octeon-feature.h
@@ -0,0 +1,120 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as published by
+ * the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful,
+ * but AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or NONINFRINGEMENT.
+ * See the GNU General Public License for more details.
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
+ * File defining checks for different Octeon features.
+ *
+ */
+
+#ifndef __OCTEON_FEATURE_H__
+#define __OCTEON_FEATURE_H__
+
+typedef enum {
+	/* Octeon models in the CN5XXX family and higher support
+	 * atomic add instructions to memory (saa/saad) */
+	OCTEON_FEATURE_SAAD,
+	/* Does this Octeon support the ZIP offload engine? */
+	OCTEON_FEATURE_ZIP,
+	/* Does this Octeon support crypto acceleration using COP2? */
+	OCTEON_FEATURE_CRYPTO,
+	/* Does this Octeon support PCI express? */
+	OCTEON_FEATURE_PCIE,
+	/* Some Octeon models support internal memory for storing
+	 * cryptographic keys */
+	OCTEON_FEATURE_KEY_MEMORY,
+	/* Octeon has a LED controller for banks of external LEDs */
+	OCTEON_FEATURE_LED_CONTROLLER,
+	/* Octeon has a trace buffer */
+	OCTEON_FEATURE_TRA,
+	/* Octeon has a management port */
+	OCTEON_FEATURE_MGMT_PORT,
+	/* Octeon has a raid unit */
+	OCTEON_FEATURE_RAID,
+	/* Octeon has a builtin USB */
+	OCTEON_FEATURE_USB,
+} octeon_feature_t;
+
+static inline int cvmx_fuse_read(int fuse);
+
+/**
+ * Determine if the current Octeon supports a specific feature. These
+ * checks have been optimized to be fairly quick, but they should still
+ * be kept out of fast path code.
+ *
+ * @feature: Feature to check for. This should always be a constant so the
+ *                compiler can remove the switch statement through optimization.
+ *
+ * Returns Non zero if the feature exists. Zero if the feature does not
+ *         exist.
+ */
+static inline int octeon_has_feature(octeon_feature_t feature)
+{
+	switch (feature) {
+	case OCTEON_FEATURE_SAAD:
+		return !OCTEON_IS_MODEL(OCTEON_CN3XXX);
+
+	case OCTEON_FEATURE_ZIP:
+		if (OCTEON_IS_MODEL(OCTEON_CN30XX)
+		    || OCTEON_IS_MODEL(OCTEON_CN50XX)
+		    || OCTEON_IS_MODEL(OCTEON_CN52XX))
+			return 0;
+		else if (OCTEON_IS_MODEL(OCTEON_CN38XX_PASS1))
+			return 1;
+		else
+			return !cvmx_fuse_read(121);
+
+	case OCTEON_FEATURE_CRYPTO:
+		return !cvmx_fuse_read(90);
+
+	case OCTEON_FEATURE_PCIE:
+		return OCTEON_IS_MODEL(OCTEON_CN56XX)
+			|| OCTEON_IS_MODEL(OCTEON_CN52XX);
+
+	case OCTEON_FEATURE_KEY_MEMORY:
+		case
+	OCTEON_FEATURE_LED_CONTROLLER:
+		return OCTEON_IS_MODEL(OCTEON_CN38XX)
+			|| OCTEON_IS_MODEL(OCTEON_CN58XX)
+			|| OCTEON_IS_MODEL(OCTEON_CN56XX);
+	case OCTEON_FEATURE_TRA:
+		return !(OCTEON_IS_MODEL(OCTEON_CN30XX)
+			 || OCTEON_IS_MODEL(OCTEON_CN50XX));
+	case OCTEON_FEATURE_MGMT_PORT:
+		return OCTEON_IS_MODEL(OCTEON_CN56XX)
+			|| OCTEON_IS_MODEL(OCTEON_CN52XX);
+	case OCTEON_FEATURE_RAID:
+		return OCTEON_IS_MODEL(OCTEON_CN56XX)
+			|| OCTEON_IS_MODEL(OCTEON_CN52XX);
+	case OCTEON_FEATURE_USB:
+		return !(OCTEON_IS_MODEL(OCTEON_CN38XX)
+			 || OCTEON_IS_MODEL(OCTEON_CN58XX));
+	}
+	return 0;
+}
+
+#endif /* __OCTEON_FEATURE_H__ */
diff --git a/arch/mips/include/asm/octeon/octeon-model.h b/arch/mips/include/asm/octeon/octeon-model.h
new file mode 100644
index 0000000..3d4b74e
--- /dev/null
+++ b/arch/mips/include/asm/octeon/octeon-model.h
@@ -0,0 +1,225 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as published by
+ * the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful,
+ * but AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or NONINFRINGEMENT.
+ * See the GNU General Public License for more details.
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
+ * File defining different Octeon model IDs and macros to
+ * compare them.
+ *
+ */
+
+#ifndef __OCTEON_MODEL_H__
+#define __OCTEON_MODEL_H__
+
+/* NOTE: These must match what is checked in common-config.mk */
+/* Defines to represent the different versions of Octeon.  */
+
+/* IMPORTANT: When the default pass is updated for an Octeon Model,
+** the corresponding change must also be made in the oct-sim script. */
+
+/* The defines below should be used with the OCTEON_IS_MODEL() macro to
+** determine what model of chip the software is running on.  Models ending
+** in 'XX' match multiple models (families), while specific models match only
+** that model.  If a pass (revision) is specified, then only that revision
+** will be matched.  Care should be taken when checking for both specific
+** models and families that the specific models are checked for first.
+** While these defines are similar to the processor ID, they are not intended
+** to be used by anything other that the OCTEON_IS_MODEL framework, and
+** the values are subject to change at anytime without notice.
+**
+** NOTE: only the OCTEON_IS_MODEL() macro/function and the OCTEON_CN* macros
+** should be used outside of this file.  All other macros are for internal
+** use only, and may change without notice.
+*/
+
+/* Flag bits in top byte */
+/* Ignores revision in model checks */
+#define OM_IGNORE_REVISION        0x01000000
+/* Ignores submodels  */
+#define OM_IGNORE_SUBMODEL        0x02000000
+/* Match all models previous than the one specified */
+#define OM_MATCH_PREVIOUS_MODELS  0x04000000
+
+#define OCTEON_CN56XX_PASS1     0x000d0400
+#define OCTEON_CN56XX_PASS1_1   0x000d0401
+#define OCTEON_CN56XX_PASS2     0x000d0408
+#define OCTEON_CN56XX           (OCTEON_CN56XX_PASS1 \
+				 | OM_IGNORE_REVISION | OM_IGNORE_SUBMODEL)
+
+/* NOTE: Octeon CN57XX, CN55XX, and CN54XX models are not identifiable
+    using the OCTEON_IS_MODEL() functions, but are treated as
+    CN56XX */
+
+#define OCTEON_CN58XX_PASS1     0x000d0300
+#define OCTEON_CN58XX_PASS1_1   0x000d0301
+#define OCTEON_CN58XX_PASS1_2   0x000d0303
+#define OCTEON_CN58XX_PASS2     0x000d0308
+#define OCTEON_CN58XX           (OCTEON_CN58XX_PASS1 | OM_IGNORE_REVISION \
+				 | OM_IGNORE_SUBMODEL)
+
+#define OCTEON_CN50XX_PASS1     0x000d0600
+#define OCTEON_CN50XX           (OCTEON_CN50XX_PASS1 | OM_IGNORE_REVISION \
+				 | OM_IGNORE_SUBMODEL)
+
+/* NOTE: Octeon CN5000F model is not identifiable using the OCTEON_IS_MODEL()
+    functions, but are treated as CN50XX */
+
+#define OCTEON_CN52XX_PASS1     0x000d0700
+#define OCTEON_CN52XX           (OCTEON_CN52XX_PASS1 | OM_IGNORE_REVISION \
+				 | OM_IGNORE_SUBMODEL)
+
+#define OCTEON_CN38XX_PASS1     0x000d0000
+#define OCTEON_CN38XX_PASS2     0x000d0001
+#define OCTEON_CN38XX_PASS3     0x000d0003
+#define OCTEON_CN38XX       	(OCTEON_CN38XX_PASS2 | OM_IGNORE_REVISION \
+				 | OM_IGNORE_SUBMODEL)
+
+/* NOTE: OCTEON CN36XX models are not identifiable using the
+** OCTEON_IS_MODEL() functions, but are treated as 38XX with a smaller
+** L2 cache.  Setting OCTEON_MODEL to OCTEON_CN36XX will not affect
+** how the program is built (it will be built for OCTEON_CN38XX) but
+** does cause the simulator to properly simulate the smaller L2
+** cache. */
+
+/* The OCTEON_CN31XX matches CN31XX models and the CN3020 */
+#define OCTEON_CN31XX_PASS1    	0x000d0100
+#define OCTEON_CN31XX_PASS1_1  	0x000d0102
+#define OCTEON_CN31XX       	(OCTEON_CN31XX_PASS1 | OM_IGNORE_REVISION \
+				 | OM_IGNORE_SUBMODEL)
+
+#define OCTEON_CN3005_PASS1    	0x000d0210
+#define OCTEON_CN3005_PASS1_1  	0x000d0212
+#define OCTEON_CN3005       	(OCTEON_CN3005_PASS1 | OM_IGNORE_REVISION)
+
+#define OCTEON_CN3010_PASS1    	0x000d0200
+#define OCTEON_CN3010_PASS1_1  	0x000d0202
+#define OCTEON_CN3010       	(OCTEON_CN3010_PASS1 | OM_IGNORE_REVISION)
+
+#define OCTEON_CN3020_PASS1    	0x000d0110
+#define OCTEON_CN3020_PASS1_1  	0x000d0112
+#define OCTEON_CN3020       	(OCTEON_CN3020_PASS1 | OM_IGNORE_REVISION)
+
+/* This model is only used for internal checks, it
+** is not valid model for the OCTEON_MODEL environment variable.
+** This matches the CN3010 and CN3005 but NOT the CN3020*/
+#define OCTEON_CN30XX       	(OCTEON_CN3010_PASS1   | OM_IGNORE_REVISION \
+				 | OM_IGNORE_SUBMODEL)
+#define OCTEON_CN30XX_PASS1   	(OCTEON_CN3010_PASS1   | OM_IGNORE_SUBMODEL)
+#define OCTEON_CN30XX_PASS1_1  	(OCTEON_CN3010_PASS1_1 | OM_IGNORE_SUBMODEL)
+
+/* This matches the complete family of CN3xxx CPUs, and not subsequent models */
+#define OCTEON_CN3XXX           (OCTEON_CN58XX_PASS1 \
+				 | OM_MATCH_PREVIOUS_MODELS \
+				 | OM_IGNORE_REVISION | OM_IGNORE_SUBMODEL)
+
+/* The revision byte (low byte) has two different encodings.
+** CN3XXX:
+**
+**     bits
+**     <7:5>: reserved (0)
+**     <4>:   alternate package
+**     <3:0>: revision
+**
+** CN5XXX:
+**
+**     bits
+**     <7>:   reserved (0)
+**     <6>:   alternate package
+**     <5:3>: major revision
+**     <2:0>: minor revision
+**
+*/
+
+/* Masks used for the various types of model/family/revision matching */
+#define OCTEON_38XX_FAMILY_MASK      0x00ffff00
+#define OCTEON_38XX_FAMILY_REV_MASK  0x00ffff0f
+#define OCTEON_38XX_MODEL_MASK       0x00ffff10
+#define OCTEON_38XX_MODEL_REV_MASK   (OCTEON_38XX_FAMILY_REV_MASK \
+				      | OCTEON_38XX_MODEL_MASK)
+
+/* CN5XXX and use different layout of bits in the revision ID field */
+#define OCTEON_58XX_FAMILY_MASK      OCTEON_38XX_FAMILY_MASK
+#define OCTEON_58XX_FAMILY_REV_MASK  0x00ffff3f
+#define OCTEON_58XX_MODEL_MASK       0x00ffffc0
+#define OCTEON_58XX_MODEL_REV_MASK   (OCTEON_58XX_FAMILY_REV_MASK \
+				      | OCTEON_58XX_MODEL_MASK)
+
+#define __OCTEON_MATCH_MASK__(x, y, z) (((x) & (z)) == ((y) & (z)))
+
+/* NOTE: This for internal use only!!!!! */
+#define __OCTEON_IS_MODEL_COMPILE__(arg_model, chip_model) \
+    ((((arg_model & OCTEON_38XX_FAMILY_MASK) <= OCTEON_CN3010_PASS1)  && (\
+     ((((arg_model) & (OM_MATCH_PREVIOUS_MODELS | OM_IGNORE_REVISION | OM_IGNORE_SUBMODEL)) == OM_IGNORE_REVISION) && __OCTEON_MATCH_MASK__((chip_model), (arg_model), OCTEON_38XX_MODEL_MASK)) || \
+     ((((arg_model) & (OM_MATCH_PREVIOUS_MODELS | OM_IGNORE_REVISION | OM_IGNORE_SUBMODEL)) == OM_IGNORE_SUBMODEL) && __OCTEON_MATCH_MASK__((chip_model), (arg_model), OCTEON_38XX_FAMILY_REV_MASK)) || \
+     ((((arg_model) & (OM_MATCH_PREVIOUS_MODELS | OM_IGNORE_REVISION | OM_IGNORE_SUBMODEL)) == (OM_IGNORE_REVISION | OM_IGNORE_SUBMODEL)) && __OCTEON_MATCH_MASK__((chip_model), (arg_model), OCTEON_38XX_FAMILY_MASK)) || \
+     ((((arg_model) & (OM_MATCH_PREVIOUS_MODELS | OM_IGNORE_REVISION | OM_IGNORE_SUBMODEL)) == 0) && __OCTEON_MATCH_MASK__((chip_model), (arg_model), OCTEON_38XX_MODEL_REV_MASK)) || \
+     ((((arg_model) & (OM_MATCH_PREVIOUS_MODELS)) == OM_MATCH_PREVIOUS_MODELS) && (((chip_model) & OCTEON_38XX_MODEL_MASK) < ((arg_model) & OCTEON_38XX_MODEL_MASK))) \
+    )) || \
+    (((arg_model & OCTEON_38XX_FAMILY_MASK) > OCTEON_CN3010_PASS1)  && (\
+     ((((arg_model) & (OM_MATCH_PREVIOUS_MODELS | OM_IGNORE_REVISION | OM_IGNORE_SUBMODEL)) == OM_IGNORE_REVISION) && __OCTEON_MATCH_MASK__((chip_model), (arg_model), OCTEON_58XX_MODEL_MASK)) || \
+     ((((arg_model) & (OM_MATCH_PREVIOUS_MODELS | OM_IGNORE_REVISION | OM_IGNORE_SUBMODEL)) == OM_IGNORE_SUBMODEL) && __OCTEON_MATCH_MASK__((chip_model), (arg_model), OCTEON_58XX_FAMILY_REV_MASK)) || \
+     ((((arg_model) & (OM_MATCH_PREVIOUS_MODELS | OM_IGNORE_REVISION | OM_IGNORE_SUBMODEL)) == (OM_IGNORE_REVISION | OM_IGNORE_SUBMODEL)) && __OCTEON_MATCH_MASK__((chip_model), (arg_model), OCTEON_58XX_FAMILY_MASK)) || \
+     ((((arg_model) & (OM_MATCH_PREVIOUS_MODELS | OM_IGNORE_REVISION | OM_IGNORE_SUBMODEL)) == 0) && __OCTEON_MATCH_MASK__((chip_model), (arg_model), OCTEON_58XX_MODEL_REV_MASK)) || \
+     ((((arg_model) & (OM_MATCH_PREVIOUS_MODELS)) == OM_MATCH_PREVIOUS_MODELS) && (((chip_model) & OCTEON_58XX_MODEL_MASK) < ((arg_model) & OCTEON_58XX_MODEL_MASK))) \
+    )))
+
+/* forward declarations */
+static inline uint32_t cvmx_get_proc_id(void) __attribute__ ((pure));
+static inline uint64_t cvmx_read_csr(uint64_t csr_addr);
+
+/* NOTE: This for internal use only!!!!! */
+static inline int __octeon_is_model_runtime__(uint32_t model)
+{
+	uint32_t cpuid = cvmx_get_proc_id();
+
+	/* Check for special case of mismarked 3005 samples. We only
+	   need to check if the sub model isn't being ignored */
+	if ((model & OM_IGNORE_SUBMODEL) == 0) {
+		if (cpuid == OCTEON_CN3010_PASS1
+		    && (cvmx_read_csr(0x80011800800007B8ull) & (1ull << 34)))
+			cpuid |= 0x10;
+	}
+	return __OCTEON_IS_MODEL_COMPILE__(model, cpuid);
+}
+
+/* The OCTEON_IS_MODEL macro should be used for all Octeon model
+** checking done in a program.  This should be kept runtime if at all
+** possible.  Any compile time (#if OCTEON_IS_MODEL) usage must be
+** condtionalized with OCTEON_IS_COMMON_BINARY() if runtime checking
+** support is required.
+**
+*/
+#define OCTEON_IS_MODEL(x) __octeon_is_model_runtime__(x)
+#define OCTEON_IS_COMMON_BINARY() 1
+#undef OCTEON_MODEL
+
+const char *octeon_model_get_string(uint32_t chip_id);
+const char *octeon_model_get_string_buffer(uint32_t chip_id, char *buffer);
+
+#include "octeon-feature.h"
+
+#endif /* __OCTEON_MODEL_H__ */
-- 
1.5.6.5
