Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Aug 2015 02:09:50 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:56508 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011997AbbHBAJsgM6Fy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Aug 2015 02:09:48 +0200
Received: from deadeye.wl.decadent.org.uk ([192.168.4.249] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84)
        (envelope-from <ben@decadent.org.uk>)
        id 1ZLgqW-0002cp-Jz; Sun, 02 Aug 2015 01:09:44 +0100
Received: from ben by deadeye with local (Exim 4.86_RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1ZLgqT-0004ln-O0; Sun, 02 Aug 2015 01:09:41 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, linux-mips@linux-mips.org,
        "Ralf Baechle" <ralf@linux-mips.org>, paul.burton@imgtec.com,
        "Lars Persson" <lars.persson@axis.com>,
        "Lars Persson" <larper@axis.com>
Date:   Sun, 02 Aug 2015 01:02:38 +0100
Message-ID: <lsq.1438473758.381140961@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 153/164] MIPS: Fix race condition in lazy cache flushing.
In-Reply-To: <lsq.1438473757.687525882@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.249
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48526
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.2.70-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Lars Persson <lars.persson@axis.com>

commit 4d46a67a3eb827ccf1125959936fd51ba318dabc upstream.

The lazy cache flushing implemented in the MIPS kernel suffers from a
race condition that is exposed by do_set_pte() in mm/memory.c.

A pre-condition is a file-system that writes to the page from the CPU
in its readpage method and then calls flush_dcache_page(). One example
is ubifs. Another pre-condition is that the dcache flush is postponed
in __flush_dcache_page().

Upon a page fault for an executable mapping not existing in the
page-cache, the following will happen:
1. Write to the page
2. flush_dcache_page
3. flush_icache_page
4. set_pte_at
5. update_mmu_cache (commits the flush of a dcache-dirty page)

Between steps 4 and 5 another thread can hit the same page and it will
encounter a valid pte. Because the data still is in the L1 dcache the CPU
will fetch stale data from L2 into the icache and execute garbage.

This fix moves the commit of the cache flush to step 3 to close the
race window. It also reduces the amount of flushes on non-executable
mappings because we never enter __flush_dcache_page() for non-aliasing
CPUs.

Regressions can occur in drivers that mistakenly relies on the
flush_dcache_page() in get_user_pages() for DMA operations.

[ralf@linux-mips.org: Folded in patch 9346 to fix highmem issue.]

Signed-off-by: Lars Persson <larper@axis.com>
Cc: linux-mips@linux-mips.org
Cc: paul.burton@imgtec.com
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/9346/
Patchwork: https://patchwork.linux-mips.org/patch/9738/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/include/asm/cacheflush.h | 38 +++++++++++++++++++++++---------------
 arch/mips/mm/cache.c               | 12 ++++++++++++
 2 files changed, 35 insertions(+), 15 deletions(-)

--- a/arch/mips/include/asm/cacheflush.h
+++ b/arch/mips/include/asm/cacheflush.h
@@ -29,6 +29,20 @@
  *  - flush_icache_all() flush the entire instruction cache
  *  - flush_data_cache_page() flushes a page from the data cache
  */
+
+ /*
+ * This flag is used to indicate that the page pointed to by a pte
+ * is dirty and requires cleaning before returning it to the user.
+ */
+#define PG_dcache_dirty			PG_arch_1
+
+#define Page_dcache_dirty(page)		\
+	test_bit(PG_dcache_dirty, &(page)->flags)
+#define SetPageDcacheDirty(page)	\
+	set_bit(PG_dcache_dirty, &(page)->flags)
+#define ClearPageDcacheDirty(page)	\
+	clear_bit(PG_dcache_dirty, &(page)->flags)
+
 extern void (*flush_cache_all)(void);
 extern void (*__flush_cache_all)(void);
 extern void (*flush_cache_mm)(struct mm_struct *mm);
@@ -37,13 +51,15 @@ extern void (*flush_cache_range)(struct
 	unsigned long start, unsigned long end);
 extern void (*flush_cache_page)(struct vm_area_struct *vma, unsigned long page, unsigned long pfn);
 extern void __flush_dcache_page(struct page *page);
+extern void __flush_icache_page(struct vm_area_struct *vma, struct page *page);
 
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 static inline void flush_dcache_page(struct page *page)
 {
-	if (cpu_has_dc_aliases || !cpu_has_ic_fills_f_dc)
+	if (cpu_has_dc_aliases)
 		__flush_dcache_page(page);
-
+	else if (!cpu_has_ic_fills_f_dc)
+		SetPageDcacheDirty(page);
 }
 
 #define flush_dcache_mmap_lock(mapping)		do { } while (0)
@@ -61,6 +77,11 @@ static inline void flush_anon_page(struc
 static inline void flush_icache_page(struct vm_area_struct *vma,
 	struct page *page)
 {
+	if (!cpu_has_ic_fills_f_dc && (vma->vm_flags & VM_EXEC) &&
+	    Page_dcache_dirty(page)) {
+		__flush_icache_page(vma, page);
+		ClearPageDcacheDirty(page);
+	}
 }
 
 extern void (*flush_icache_range)(unsigned long start, unsigned long end);
@@ -95,19 +116,6 @@ extern void (*flush_icache_all)(void);
 extern void (*local_flush_data_cache_page)(void * addr);
 extern void (*flush_data_cache_page)(unsigned long addr);
 
-/*
- * This flag is used to indicate that the page pointed to by a pte
- * is dirty and requires cleaning before returning it to the user.
- */
-#define PG_dcache_dirty			PG_arch_1
-
-#define Page_dcache_dirty(page)		\
-	test_bit(PG_dcache_dirty, &(page)->flags)
-#define SetPageDcacheDirty(page)	\
-	set_bit(PG_dcache_dirty, &(page)->flags)
-#define ClearPageDcacheDirty(page)	\
-	clear_bit(PG_dcache_dirty, &(page)->flags)
-
 /* Run kernel code uncached, useful for cache probing functions. */
 unsigned long run_uncached(void *func);
 
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -118,6 +118,18 @@ void __flush_anon_page(struct page *page
 
 EXPORT_SYMBOL(__flush_anon_page);
 
+void __flush_icache_page(struct vm_area_struct *vma, struct page *page)
+{
+	unsigned long addr;
+
+	if (PageHighMem(page))
+		return;
+
+	addr = (unsigned long) page_address(page);
+	flush_data_cache_page(addr);
+}
+EXPORT_SYMBOL_GPL(__flush_icache_page);
+
 void __update_cache(struct vm_area_struct *vma, unsigned long address,
 	pte_t pte)
 {
