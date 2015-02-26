Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Feb 2015 14:16:48 +0100 (CET)
Received: from bes.se.axis.com ([195.60.68.10]:55072 "EHLO bes.se.axis.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007432AbbBZNQMP5XNS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Feb 2015 14:16:12 +0100
Received: from localhost (localhost [127.0.0.1])
        by bes.se.axis.com (Postfix) with ESMTP id 593F52E3DC;
        Thu, 26 Feb 2015 14:16:07 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id hzjjAWtiWADM; Thu, 26 Feb 2015 14:16:06 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
        by bes.se.axis.com (Postfix) with ESMTP id 641942E3DB;
        Thu, 26 Feb 2015 14:16:06 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
        by postfix.imss71 (Postfix) with ESMTP id 4D6571190;
        Thu, 26 Feb 2015 14:16:06 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
        by boulder.se.axis.com (Postfix) with ESMTP id 415BA1187;
        Thu, 26 Feb 2015 14:16:06 +0100 (CET)
Received: from lnxlarper.se.axis.com (lnxlarper.se.axis.com [10.88.41.1])
        by seth.se.axis.com (Postfix) with ESMTP id 3EFC43E2A6;
        Thu, 26 Feb 2015 14:16:06 +0100 (CET)
Received: by lnxlarper.se.axis.com (Postfix, from userid 20456)
        id 3B9FF801D2; Thu, 26 Feb 2015 14:16:06 +0100 (CET)
From:   Lars Persson <lars.persson@axis.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        paul.burton@imgtec.com
Cc:     linux-kernel@vger.kernel.org, Lars Persson <larper@axis.com>
Subject: [PATCH 2/2] MIPS: Fix race condition in lazy cache flushing.
Date:   Thu, 26 Feb 2015 14:16:03 +0100
Message-Id: <1424956563-29535-3-git-send-email-larper@axis.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1424956563-29535-1-git-send-email-larper@axis.com>
References: <1424956563-29535-1-git-send-email-larper@axis.com>
Return-Path: <lars.persson@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46002
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars.persson@axis.com
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

Signed-off-by: Lars Persson <larper@axis.com>
---
 arch/mips/include/asm/cacheflush.h |   35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/arch/mips/include/asm/cacheflush.h b/arch/mips/include/asm/cacheflush.h
index e08381a..37d5cf9 100644
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
@@ -41,9 +55,10 @@ extern void __flush_dcache_page(struct page *page);
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
@@ -61,6 +76,9 @@ static inline void flush_anon_page(struct vm_area_struct *vma,
 static inline void flush_icache_page(struct vm_area_struct *vma,
 	struct page *page)
 {
+	if (!cpu_has_ic_fills_f_dc && (vma->vm_flags & VM_EXEC) &&
+	    Page_dcache_dirty(page))
+		__flush_dcache_page(page);
 }
 
 extern void (*flush_icache_range)(unsigned long start, unsigned long end);
@@ -95,19 +113,6 @@ extern void (*flush_icache_all)(void);
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
 
-- 
1.7.10.4
