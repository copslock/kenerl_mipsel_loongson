Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 May 2015 19:56:20 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:35681 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27027461AbbEKRzof3nKo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 May 2015 19:55:44 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 452DDBB1;
        Mon, 11 May 2015 17:55:40 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lars Persson <larper@axis.com>, linux-mips@linux-mips.org,
        paul.burton@imgtec.com, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.0 11/72] MIPS: Fix race condition in lazy cache flushing.
Date:   Mon, 11 May 2015 10:54:17 -0700
Message-Id: <20150511175437.449164531@linuxfoundation.org>
X-Mailer: git-send-email 2.4.0
In-Reply-To: <20150511175437.112151861@linuxfoundation.org>
References: <20150511175437.112151861@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47313
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.0-stable review patch.  If anyone has any objections, please let me know.

------------------


From: Lars Persson <lars.persson@axis.com>

Commit 4d46a67a3eb827ccf1125959936fd51ba318dabc upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/include/asm/cacheflush.h |   38 ++++++++++++++++++++++---------------
 arch/mips/mm/cache.c               |   12 +++++++++++
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
@@ -119,6 +119,18 @@ void __flush_anon_page(struct page *page
 
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
