Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Nov 2018 23:38:38 +0100 (CET)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:58432 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994204AbeKUWiDcj-H- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Nov 2018 23:38:03 +0100
Received: from localhost.localdomain (85-76-84-147-nat.elisa-mobile.fi [85.76.84.147])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 4C2912009A;
        Thu, 22 Nov 2018 00:38:03 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 15/24] MIPS: OCTEON: cvmx-bootmem: delete unused functions
Date:   Thu, 22 Nov 2018 00:37:36 +0200
Message-Id: <20181121223745.22792-16-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181121223745.22792-1-aaro.koskinen@iki.fi>
References: <20181121223745.22792-1-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67442
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

Delete unused functions.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 .../cavium-octeon/executive/cvmx-bootmem.c    | 12 -------
 arch/mips/include/asm/octeon/cvmx-bootmem.h   | 33 -------------------
 2 files changed, 45 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-bootmem.c b/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
index c2dbf0b8b909..dc5d1c6203a7 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
@@ -155,11 +155,6 @@ void *cvmx_bootmem_alloc_address(uint64_t size, uint64_t address,
 					address + size);
 }
 
-void *cvmx_bootmem_alloc(uint64_t size, uint64_t alignment)
-{
-	return cvmx_bootmem_alloc_range(size, alignment, 0, 0);
-}
-
 void *cvmx_bootmem_alloc_named_range_once(uint64_t size, uint64_t min_addr,
 					  uint64_t max_addr, uint64_t align,
 					  char *name,
@@ -210,13 +205,6 @@ void *cvmx_bootmem_alloc_named_range(uint64_t size, uint64_t min_addr,
 		return NULL;
 }
 
-void *cvmx_bootmem_alloc_named_address(uint64_t size, uint64_t address,
-				       char *name)
-{
-    return cvmx_bootmem_alloc_named_range(size, address, address + size,
-					  0, name);
-}
-
 void *cvmx_bootmem_alloc_named(uint64_t size, uint64_t alignment, char *name)
 {
     return cvmx_bootmem_alloc_named_range(size, 0, 0, alignment, name);
diff --git a/arch/mips/include/asm/octeon/cvmx-bootmem.h b/arch/mips/include/asm/octeon/cvmx-bootmem.h
index b762040159a1..d3ea3170714b 100644
--- a/arch/mips/include/asm/octeon/cvmx-bootmem.h
+++ b/arch/mips/include/asm/octeon/cvmx-bootmem.h
@@ -145,18 +145,6 @@ struct cvmx_bootmem_desc {
  */
 extern int cvmx_bootmem_init(void *mem_desc_ptr);
 
-/**
- * Allocate a block of memory from the free list that was passed
- * to the application by the bootloader.
- * This is an allocate-only algorithm, so freeing memory is not possible.
- *
- * @size:      Size in bytes of block to allocate
- * @alignment: Alignment required - must be power of 2
- *
- * Returns pointer to block of memory, NULL on error
- */
-extern void *cvmx_bootmem_alloc(uint64_t size, uint64_t alignment);
-
 /**
  * Allocate a block of memory from the free list that was
  * passed to the application by the bootloader at a specific
@@ -198,27 +186,6 @@ extern void *cvmx_bootmem_alloc_address(uint64_t size, uint64_t address,
 extern void *cvmx_bootmem_alloc_named(uint64_t size, uint64_t alignment,
 				      char *name);
 
-
-
-/**
- * Allocate a block of memory from the free list that was passed
- * to the application by the bootloader, and assign it a name in the
- * global named block table.  (part of the cvmx_bootmem_descriptor_t structure)
- * Named blocks can later be freed.
- *
- * @size:     Size in bytes of block to allocate
- * @address:  Physical address to allocate memory at.  If this
- *	      memory is not available, the allocation fails.
- * @name:     name of block - must be less than CVMX_BOOTMEM_NAME_LEN
- *	      bytes
- *
- * Returns a pointer to block of memory, NULL on error
- */
-extern void *cvmx_bootmem_alloc_named_address(uint64_t size, uint64_t address,
-					      char *name);
-
-
-
 /**
  * Allocate a block of memory from a specific range of the free list
  * that was passed to the application by the bootloader, and assign it
-- 
2.17.0
