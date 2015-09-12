Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Sep 2015 01:12:41 +0200 (CEST)
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:9296 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008253AbbILXMjZf6TO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 13 Sep 2015 01:12:39 +0200
Message-Id: <20150912225608.028958489@1wt.eu>
User-Agent: quilt/0.63-1
Date:   Sun, 13 Sep 2015 00:56:40 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lars Persson <larper@axis.com>, linux-mips@linux-mips.org,
        paul.burton@imgtec.com, Ralf Baechle <ralf@linux-mips.org>,
        Ben Hutchings <ben@decadent.org.uk>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 2.6.32 34/62] MIPS: Fix race condition in lazy cache flushing.
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
In-Reply-To: <08d3b586eb2e764308c3de9ee398a17c@local>
Return-Path: <w@1wt.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49178
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: w@1wt.eu
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

2.6.32-longterm review patch.  If anyone has any objections, please let me know.

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
(cherry picked from commit 6bde6a3df0b4c8680d51c987d446b0ff2d6df0a6)

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 arch/mips/include/asm/cacheflush.h | 38 +++++++++++++++++++++++---------------
 arch/mips/mm/cache.c               | 12 ++++++++++++
 2 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/arch/mips/include/asm/cacheflush.h b/arch/mips/include/asm/cacheflush.h
index 03b1d69..2211f24 100644
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
@@ -37,12 +51,14 @@ extern void (*flush_cache_range)(struct vm_area_struct *vma,
 	unsigned long start, unsigned long end);
 extern void (*flush_cache_page)(struct vm_area_struct *vma, unsigned long page, unsigned long pfn);
 extern void __flush_dcache_page(struct page *page);
+extern void __flush_icache_page(struct vm_area_struct *vma, struct page *page);
 
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
@@ -60,6 +76,11 @@ static inline void flush_anon_page(struct vm_area_struct *vma,
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
@@ -94,19 +115,6 @@ extern void (*flush_icache_all)(void);
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
 
diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 694d51f..37603a4 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -113,6 +113,18 @@ void __flush_anon_page(struct page *page, unsigned long vmaddr)
 
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
-- 
1.7.12.2.21.g234cd45.dirty
