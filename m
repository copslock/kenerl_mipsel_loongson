Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 May 2009 01:36:33 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:16892 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20021296AbZEFAg1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 May 2009 01:36:27 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a00db800004>; Tue, 05 May 2009 20:36:16 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 5 May 2009 17:35:29 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 5 May 2009 17:35:28 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n460ZO9q022755;
	Tue, 5 May 2009 17:35:24 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n460ZMKe022753;
	Tue, 5 May 2009 17:35:22 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org, gregkh@suse.de
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/7] MIPS: Add named alloc functions to OCTEON boot monitor memory allocator.
Date:	Tue,  5 May 2009 17:35:16 -0700
Message-Id: <1241570122-22728-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <4A00DA84.5040101@caviumnetworks.com>
References: <4A00DA84.5040101@caviumnetworks.com>
X-OriginalArrivalTime: 06 May 2009 00:35:28.0909 (UTC) FILETIME=[8E37BBD0:01C9CDE2]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22629
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The various Octeon ethernet drivers use these new functions.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/executive/cvmx-bootmem.c |  104 ++++++++++++++++++++++
 arch/mips/include/asm/octeon/cvmx-bootmem.h      |   85 ++++++++++++++++++
 2 files changed, 189 insertions(+), 0 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-bootmem.c b/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
index 4f5a08b..25666da 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
@@ -31,6 +31,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/module.h>
 
 #include <asm/octeon/cvmx.h>
 #include <asm/octeon/cvmx-spinlock.h>
@@ -97,6 +98,33 @@ void *cvmx_bootmem_alloc(uint64_t size, uint64_t alignment)
 	return cvmx_bootmem_alloc_range(size, alignment, 0, 0);
 }
 
+void *cvmx_bootmem_alloc_named_range(uint64_t size, uint64_t min_addr,
+				     uint64_t max_addr, uint64_t align,
+				     char *name)
+{
+	int64_t addr;
+
+	addr = cvmx_bootmem_phy_named_block_alloc(size, min_addr, max_addr,
+						  align, name, 0);
+	if (addr >= 0)
+		return cvmx_phys_to_ptr(addr);
+	else
+		return NULL;
+}
+
+void *cvmx_bootmem_alloc_named_address(uint64_t size, uint64_t address,
+				       char *name)
+{
+    return cvmx_bootmem_alloc_named_range(size, address, address + size,
+					  0, name);
+}
+
+void *cvmx_bootmem_alloc_named(uint64_t size, uint64_t alignment, char *name)
+{
+    return cvmx_bootmem_alloc_named_range(size, 0, 0, alignment, name);
+}
+EXPORT_SYMBOL(cvmx_bootmem_alloc_named);
+
 int cvmx_bootmem_free_named(char *name)
 {
 	return cvmx_bootmem_phy_named_block_free(name, 0);
@@ -106,6 +134,7 @@ struct cvmx_bootmem_named_block_desc *cvmx_bootmem_find_named_block(char *name)
 {
 	return cvmx_bootmem_phy_named_block_find(name, 0);
 }
+EXPORT_SYMBOL(cvmx_bootmem_find_named_block);
 
 void cvmx_bootmem_lock(void)
 {
@@ -584,3 +613,78 @@ int cvmx_bootmem_phy_named_block_free(char *name, uint32_t flags)
 	cvmx_bootmem_unlock();
 	return named_block_ptr != NULL;	/* 0 on failure, 1 on success */
 }
+
+int64_t cvmx_bootmem_phy_named_block_alloc(uint64_t size, uint64_t min_addr,
+					   uint64_t max_addr,
+					   uint64_t alignment,
+					   char *name,
+					   uint32_t flags)
+{
+	int64_t addr_allocated;
+	struct cvmx_bootmem_named_block_desc *named_block_desc_ptr;
+
+#ifdef DEBUG
+	cvmx_dprintf("cvmx_bootmem_phy_named_block_alloc: size: 0x%llx, min: "
+		     "0x%llx, max: 0x%llx, align: 0x%llx, name: %s\n",
+		     (unsigned long long)size,
+		     (unsigned long long)min_addr,
+		     (unsigned long long)max_addr,
+		     (unsigned long long)alignment,
+		     name);
+#endif
+	if (cvmx_bootmem_desc->major_version != 3) {
+		cvmx_dprintf("ERROR: Incompatible bootmem descriptor version: "
+			     "%d.%d at addr: %p\n",
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
+		cvmx_spinlock_lock((cvmx_spinlock_t *)&(cvmx_bootmem_desc->lock));
+
+	/* Get pointer to first available named block descriptor */
+	named_block_desc_ptr =
+		cvmx_bootmem_phy_named_block_find(NULL,
+						  flags | CVMX_BOOTMEM_FLAG_NO_LOCKING);
+
+	/*
+	 * Check to see if name already in use, return error if name
+	 * not available or no more room for blocks.
+	 */
+	if (cvmx_bootmem_phy_named_block_find(name,
+					      flags | CVMX_BOOTMEM_FLAG_NO_LOCKING) || !named_block_desc_ptr) {
+		if (!(flags & CVMX_BOOTMEM_FLAG_NO_LOCKING))
+			cvmx_spinlock_unlock((cvmx_spinlock_t *)&(cvmx_bootmem_desc->lock));
+		return -1;
+	}
+
+
+	/*
+	 * Round size up to mult of minimum alignment bytes We need
+	 * the actual size allocated to allow for blocks to be
+	 * coallesced when they are freed.  The alloc routine does the
+	 * same rounding up on all allocations.
+	 */
+	size = __ALIGN_MASK(size, (CVMX_BOOTMEM_ALIGNMENT_SIZE - 1));
+
+	addr_allocated = cvmx_bootmem_phy_alloc(size, min_addr, max_addr,
+						alignment,
+						flags | CVMX_BOOTMEM_FLAG_NO_LOCKING);
+	if (addr_allocated >= 0) {
+		named_block_desc_ptr->base_addr = addr_allocated;
+		named_block_desc_ptr->size = size;
+		strncpy(named_block_desc_ptr->name, name,
+			cvmx_bootmem_desc->named_block_name_len);
+		named_block_desc_ptr->name[cvmx_bootmem_desc->named_block_name_len - 1] = 0;
+	}
+
+	if (!(flags & CVMX_BOOTMEM_FLAG_NO_LOCKING))
+		cvmx_spinlock_unlock((cvmx_spinlock_t *)&(cvmx_bootmem_desc->lock));
+	return addr_allocated;
+}
diff --git a/arch/mips/include/asm/octeon/cvmx-bootmem.h b/arch/mips/include/asm/octeon/cvmx-bootmem.h
index 1cbe4b5..8e708bd 100644
--- a/arch/mips/include/asm/octeon/cvmx-bootmem.h
+++ b/arch/mips/include/asm/octeon/cvmx-bootmem.h
@@ -183,6 +183,64 @@ extern void *cvmx_bootmem_alloc_range(uint64_t size, uint64_t alignment,
  * Returns 0 on failure,
  *         !0 on success
  */
+
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
+ * Returns a pointer to block of memory, NULL on error
+ */
+extern void *cvmx_bootmem_alloc_named(uint64_t size, uint64_t alignment,
+				      char *name);
+
+
+
+/**
+ * Allocate a block of memory from the free list that was passed
+ * to the application by the bootloader, and assign it a name in the
+ * global named block table.  (part of the cvmx_bootmem_descriptor_t structure)
+ * Named blocks can later be freed.
+ *
+ * @size:     Size in bytes of block to allocate
+ * @address:  Physical address to allocate memory at.  If this
+ *            memory is not available, the allocation fails.
+ * @name:     name of block - must be less than CVMX_BOOTMEM_NAME_LEN
+ *            bytes
+ *
+ * Returns a pointer to block of memory, NULL on error
+ */
+extern void *cvmx_bootmem_alloc_named_address(uint64_t size, uint64_t address,
+					      char *name);
+
+
+
+/**
+ * Allocate a block of memory from a specific range of the free list
+ * that was passed to the application by the bootloader, and assign it
+ * a name in the global named block table.  (part of the
+ * cvmx_bootmem_descriptor_t structure) Named blocks can later be
+ * freed.  If request cannot be satisfied within the address range
+ * specified, NULL is returned
+ *
+ * @size:      Size in bytes of block to allocate
+ * @min_addr:  minimum address of range
+ * @max_addr:  maximum address of range
+ * @align:     Alignment of memory to be allocated. (must be a power of 2)
+ * @name:      name of block - must be less than CVMX_BOOTMEM_NAME_LEN bytes
+ *
+ * Returns a pointer to block of memory, NULL on error
+ */
+extern void *cvmx_bootmem_alloc_named_range(uint64_t size, uint64_t min_addr,
+					    uint64_t max_addr, uint64_t align,
+					    char *name);
+
 extern int cvmx_bootmem_free_named(char *name);
 
 /**
@@ -224,6 +282,33 @@ int64_t cvmx_bootmem_phy_alloc(uint64_t req_size, uint64_t address_min,
 			       uint32_t flags);
 
 /**
+ * Allocates a named block of physical memory from the free list, at
+ * (optional) requested address and alignment.
+ *
+ * @param size      size of region to allocate.  All requests are rounded
+ *                  up to be a multiple CVMX_BOOTMEM_ALIGNMENT_SIZE
+ *                  bytes size
+ * @param min_addr Minimum address that block can occupy.
+ * @param max_addr  Specifies the maximum address_min (inclusive) that
+ *                  the allocation can use.
+ * @param alignment Requested alignment of the block.  If this
+ *                  alignment cannot be met, the allocation fails.
+ *                  This must be a power of 2.  (Note: Alignment of
+ *                  CVMX_BOOTMEM_ALIGNMENT_SIZE bytes is required, and
+ *                  internally enforced.  Requested alignments of less
+ *                  than CVMX_BOOTMEM_ALIGNMENT_SIZE are set to
+ *                  CVMX_BOOTMEM_ALIGNMENT_SIZE.)
+ * @param name      name to assign to named block
+ * @param flags     Flags to control options for the allocation.
+ *
+ * @return physical address of block allocated, or -1 on failure
+ */
+int64_t cvmx_bootmem_phy_named_block_alloc(uint64_t size, uint64_t min_addr,
+					   uint64_t max_addr,
+					   uint64_t alignment,
+					   char *name, uint32_t flags);
+
+/**
  * Finds a named memory block by name.
  * Also used for finding an unused entry in the named block table.
  *
-- 
1.6.0.6
