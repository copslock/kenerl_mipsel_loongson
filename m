Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Nov 2018 23:38:33 +0100 (CET)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:58432 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994248AbeKUWiDty1s- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Nov 2018 23:38:03 +0100
Received: from localhost.localdomain (85-76-84-147-nat.elisa-mobile.fi [85.76.84.147])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 9611C200A3;
        Thu, 22 Nov 2018 00:38:03 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 17/24] MIPS: OCTEON: cvmx-bootmem: make more functions static
Date:   Thu, 22 Nov 2018 00:37:38 +0200
Message-Id: <20181121223745.22792-18-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181121223745.22792-1-aaro.koskinen@iki.fi>
References: <20181121223745.22792-1-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67441
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Make cvmx_bootmem_phy_named_block_find/free() static.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 .../cavium-octeon/executive/cvmx-bootmem.c    | 26 ++++++++++++++++--
 arch/mips/include/asm/octeon/cvmx-bootmem.h   | 27 -------------------
 2 files changed, 24 insertions(+), 29 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-bootmem.c b/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
index 51fb34edffbf..ba8f82a29a81 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
@@ -557,7 +557,20 @@ int __cvmx_bootmem_phy_free(uint64_t phy_addr, uint64_t size, uint32_t flags)
 
 }
 
-struct cvmx_bootmem_named_block_desc *
+/**
+ * Finds a named memory block by name.
+ * Also used for finding an unused entry in the named block table.
+ *
+ * @name: Name of memory block to find.	 If NULL pointer given, then
+ *	  finds unused descriptor, if available.
+ *
+ * @flags: Flags to control options for the allocation.
+ *
+ * Returns Pointer to memory block descriptor, NULL if not found.
+ *	   If NULL returned when name parameter is NULL, then no memory
+ *	   block descriptors are available.
+ */
+static struct cvmx_bootmem_named_block_desc *
 	cvmx_bootmem_phy_named_block_find(char *name, uint32_t flags)
 {
 	unsigned int i;
@@ -651,7 +664,16 @@ struct cvmx_bootmem_named_block_desc *cvmx_bootmem_find_named_block(char *name)
 }
 EXPORT_SYMBOL(cvmx_bootmem_find_named_block);
 
-int cvmx_bootmem_phy_named_block_free(char *name, uint32_t flags)
+/**
+ * Frees a named block.
+ *
+ * @name:   name of block to free
+ * @flags:  flags for passing options
+ *
+ * Returns 0 on failure
+ *	   1 on success
+ */
+static int cvmx_bootmem_phy_named_block_free(char *name, uint32_t flags)
 {
 	struct cvmx_bootmem_named_block_desc *named_block_ptr;
 
diff --git a/arch/mips/include/asm/octeon/cvmx-bootmem.h b/arch/mips/include/asm/octeon/cvmx-bootmem.h
index d3ea3170714b..689a82cac740 100644
--- a/arch/mips/include/asm/octeon/cvmx-bootmem.h
+++ b/arch/mips/include/asm/octeon/cvmx-bootmem.h
@@ -301,33 +301,6 @@ int64_t cvmx_bootmem_phy_named_block_alloc(uint64_t size, uint64_t min_addr,
 					   uint64_t alignment,
 					   char *name, uint32_t flags);
 
-/**
- * Finds a named memory block by name.
- * Also used for finding an unused entry in the named block table.
- *
- * @name: Name of memory block to find.	 If NULL pointer given, then
- *	  finds unused descriptor, if available.
- *
- * @flags: Flags to control options for the allocation.
- *
- * Returns Pointer to memory block descriptor, NULL if not found.
- *	   If NULL returned when name parameter is NULL, then no memory
- *	   block descriptors are available.
- */
-struct cvmx_bootmem_named_block_desc *
-cvmx_bootmem_phy_named_block_find(char *name, uint32_t flags);
-
-/**
- * Frees a named block.
- *
- * @name:   name of block to free
- * @flags:  flags for passing options
- *
- * Returns 0 on failure
- *	   1 on success
- */
-int cvmx_bootmem_phy_named_block_free(char *name, uint32_t flags);
-
 /**
  * Frees a block to the bootmem allocator list.	 This must
  * be used with care, as the size provided must match the size
-- 
2.17.0
