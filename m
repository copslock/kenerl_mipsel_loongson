Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Nov 2018 23:38:42 +0100 (CET)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:58424 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994220AbeKUWiDl05M- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Nov 2018 23:38:03 +0100
Received: from localhost.localdomain (85-76-84-147-nat.elisa-mobile.fi [85.76.84.147])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 710032009D;
        Thu, 22 Nov 2018 00:38:03 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 16/24] MIPS: OCTEON: cvmx-bootmem: move code to avoid forward declarations
Date:   Thu, 22 Nov 2018 00:37:37 +0200
Message-Id: <20181121223745.22792-17-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181121223745.22792-1-aaro.koskinen@iki.fi>
References: <20181121223745.22792-1-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67444
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

Move code to avoid forward declarations.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 .../cavium-octeon/executive/cvmx-bootmem.c    | 94 +++++++++----------
 1 file changed, 47 insertions(+), 47 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-bootmem.c b/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
index dc5d1c6203a7..51fb34edffbf 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
@@ -155,42 +155,6 @@ void *cvmx_bootmem_alloc_address(uint64_t size, uint64_t address,
 					address + size);
 }
 
-void *cvmx_bootmem_alloc_named_range_once(uint64_t size, uint64_t min_addr,
-					  uint64_t max_addr, uint64_t align,
-					  char *name,
-					  void (*init) (void *))
-{
-	int64_t addr;
-	void *ptr;
-	uint64_t named_block_desc_addr;
-
-	named_block_desc_addr = (uint64_t)
-		cvmx_bootmem_phy_named_block_find(name,
-						  (uint32_t)CVMX_BOOTMEM_FLAG_NO_LOCKING);
-
-	if (named_block_desc_addr) {
-		addr = CVMX_BOOTMEM_NAMED_GET_FIELD(named_block_desc_addr,
-						    base_addr);
-		return cvmx_phys_to_ptr(addr);
-	}
-
-	addr = cvmx_bootmem_phy_named_block_alloc(size, min_addr, max_addr,
-						  align, name,
-						  (uint32_t)CVMX_BOOTMEM_FLAG_NO_LOCKING);
-
-	if (addr < 0)
-		return NULL;
-	ptr = cvmx_phys_to_ptr(addr);
-
-	if (init)
-		init(ptr);
-	else
-		memset(ptr, 0, size);
-
-	return ptr;
-}
-EXPORT_SYMBOL(cvmx_bootmem_alloc_named_range_once);
-
 void *cvmx_bootmem_alloc_named_range(uint64_t size, uint64_t min_addr,
 				     uint64_t max_addr, uint64_t align,
 				     char *name)
@@ -211,17 +175,6 @@ void *cvmx_bootmem_alloc_named(uint64_t size, uint64_t alignment, char *name)
 }
 EXPORT_SYMBOL(cvmx_bootmem_alloc_named);
 
-int cvmx_bootmem_free_named(char *name)
-{
-	return cvmx_bootmem_phy_named_block_free(name, 0);
-}
-
-struct cvmx_bootmem_named_block_desc *cvmx_bootmem_find_named_block(char *name)
-{
-	return cvmx_bootmem_phy_named_block_find(name, 0);
-}
-EXPORT_SYMBOL(cvmx_bootmem_find_named_block);
-
 void cvmx_bootmem_lock(void)
 {
 	cvmx_spinlock_lock((cvmx_spinlock_t *) &(cvmx_bootmem_desc->lock));
@@ -656,6 +609,48 @@ struct cvmx_bootmem_named_block_desc *
 	return NULL;
 }
 
+void *cvmx_bootmem_alloc_named_range_once(uint64_t size, uint64_t min_addr,
+					  uint64_t max_addr, uint64_t align,
+					  char *name,
+					  void (*init) (void *))
+{
+	int64_t addr;
+	void *ptr;
+	uint64_t named_block_desc_addr;
+
+	named_block_desc_addr = (uint64_t)
+		cvmx_bootmem_phy_named_block_find(name,
+						  (uint32_t)CVMX_BOOTMEM_FLAG_NO_LOCKING);
+
+	if (named_block_desc_addr) {
+		addr = CVMX_BOOTMEM_NAMED_GET_FIELD(named_block_desc_addr,
+						    base_addr);
+		return cvmx_phys_to_ptr(addr);
+	}
+
+	addr = cvmx_bootmem_phy_named_block_alloc(size, min_addr, max_addr,
+						  align, name,
+						  (uint32_t)CVMX_BOOTMEM_FLAG_NO_LOCKING);
+
+	if (addr < 0)
+		return NULL;
+	ptr = cvmx_phys_to_ptr(addr);
+
+	if (init)
+		init(ptr);
+	else
+		memset(ptr, 0, size);
+
+	return ptr;
+}
+EXPORT_SYMBOL(cvmx_bootmem_alloc_named_range_once);
+
+struct cvmx_bootmem_named_block_desc *cvmx_bootmem_find_named_block(char *name)
+{
+	return cvmx_bootmem_phy_named_block_find(name, 0);
+}
+EXPORT_SYMBOL(cvmx_bootmem_find_named_block);
+
 int cvmx_bootmem_phy_named_block_free(char *name, uint32_t flags)
 {
 	struct cvmx_bootmem_named_block_desc *named_block_ptr;
@@ -700,6 +695,11 @@ int cvmx_bootmem_phy_named_block_free(char *name, uint32_t flags)
 	return named_block_ptr != NULL; /* 0 on failure, 1 on success */
 }
 
+int cvmx_bootmem_free_named(char *name)
+{
+	return cvmx_bootmem_phy_named_block_free(name, 0);
+}
+
 int64_t cvmx_bootmem_phy_named_block_alloc(uint64_t size, uint64_t min_addr,
 					   uint64_t max_addr,
 					   uint64_t alignment,
-- 
2.17.0
