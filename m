Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Nov 2018 23:38:46 +0100 (CET)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:58424 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994077AbeKUWiDVmFP- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Nov 2018 23:38:03 +0100
Received: from localhost.localdomain (85-76-84-147-nat.elisa-mobile.fi [85.76.84.147])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 2871B20099;
        Thu, 22 Nov 2018 00:38:03 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 14/24] MIPS: OCTEON: make cvmx_bootmem_alloc_range static
Date:   Thu, 22 Nov 2018 00:37:35 +0200
Message-Id: <20181121223745.22792-15-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181121223745.22792-1-aaro.koskinen@iki.fi>
References: <20181121223745.22792-1-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67446
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

Make cvmx_bootmem_alloc_range() static, it's not used outside the file.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 .../mips/cavium-octeon/executive/cvmx-bootmem.c | 17 +++++++++++++++--
 arch/mips/include/asm/octeon/cvmx-bootmem.h     | 16 ----------------
 2 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-bootmem.c b/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
index 94d97ebfa036..c2dbf0b8b909 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
@@ -122,8 +122,21 @@ static uint64_t cvmx_bootmem_phy_get_next(uint64_t addr)
 	return cvmx_read64_uint64((addr + NEXT_OFFSET) | (1ull << 63));
 }
 
-void *cvmx_bootmem_alloc_range(uint64_t size, uint64_t alignment,
-			       uint64_t min_addr, uint64_t max_addr)
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
+static void *cvmx_bootmem_alloc_range(uint64_t size, uint64_t alignment,
+				      uint64_t min_addr, uint64_t max_addr)
 {
 	int64_t address;
 	address =
diff --git a/arch/mips/include/asm/octeon/cvmx-bootmem.h b/arch/mips/include/asm/octeon/cvmx-bootmem.h
index 72d2e403a6e4..b762040159a1 100644
--- a/arch/mips/include/asm/octeon/cvmx-bootmem.h
+++ b/arch/mips/include/asm/octeon/cvmx-bootmem.h
@@ -173,22 +173,6 @@ extern void *cvmx_bootmem_alloc(uint64_t size, uint64_t alignment);
 extern void *cvmx_bootmem_alloc_address(uint64_t size, uint64_t address,
 					uint64_t alignment);
 
-/**
- * Allocate a block of memory from the free list that was
- * passed to the application by the bootloader within a specified
- * address range. This is an allocate-only algorithm, so
- * freeing memory is not possible. Allocation will fail if
- * memory cannot be allocated in the requested range.
- *
- * @size:      Size in bytes of block to allocate
- * @min_addr:  defines the minimum address of the range
- * @max_addr:  defines the maximum address of the range
- * @alignment: Alignment required - must be power of 2
- * Returns pointer to block of memory, NULL on error
- */
-extern void *cvmx_bootmem_alloc_range(uint64_t size, uint64_t alignment,
-				      uint64_t min_addr, uint64_t max_addr);
-
 /**
  * Frees a previously allocated named bootmem block.
  *
-- 
2.17.0
