Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 31 May 2014 12:36:51 +0200 (CEST)
Received: from [195.60.68.10] ([195.60.68.10]:48905 "EHLO bes.se.axis.com"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822106AbaEaKgtwvL3v (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 31 May 2014 12:36:49 +0200
Received: from localhost (localhost [127.0.0.1])
        by bes.se.axis.com (Postfix) with ESMTP id 8DCFD2E48C
        for <linux-mips@linux-mips.org>; Sat, 31 May 2014 12:36:33 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 2S7IGo3GCRBv for <linux-mips@linux-mips.org>;
        Sat, 31 May 2014 12:36:28 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
        by bes.se.axis.com (Postfix) with ESMTP id 67F2D2E490
        for <linux-mips@linux-mips.org>; Sat, 31 May 2014 12:36:28 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
        by postfix.imss71 (Postfix) with ESMTP id 471F1D14
        for <linux-mips@linux-mips.org>; Sat, 31 May 2014 12:36:28 +0200 (CEST)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
        by boulder.se.axis.com (Postfix) with ESMTP id 3BE56540
        for <linux-mips@linux-mips.org>; Sat, 31 May 2014 12:36:28 +0200 (CEST)
Received: from lnxlarper.se.axis.com (lnxlarper.se.axis.com [10.88.41.1])
        by seth.se.axis.com (Postfix) with ESMTP id 382063E048;
        Sat, 31 May 2014 12:36:28 +0200 (CEST)
Received: by lnxlarper.se.axis.com (Postfix, from userid 20456)
        id 0B95442078; Sat, 31 May 2014 12:36:27 +0200 (CEST)
From:   Lars Persson <lars.persson@axis.com>
To:     linux-mips@linux-mips.org
Cc:     Lars Persson <larper@axis.com>
Subject: [PATCH] MIPS: Remove race window in page fault handling
Date:   Sat, 31 May 2014 12:36:06 +0200
Message-Id: <1401532566-22929-1-git-send-email-larper@axis.com>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <lars.persson@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40398
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

Multicore MIPSes without I/D hardware coherency suffered from a race
condition in the page fault handler. The page table entry was published
before any pending lazy D-cache flush was committed, hence it allowed
execution of stale page cache data by other VPEs in the system.

Signed-off-by: Lars Persson <larper@axis.com>
---
 arch/mips/include/asm/pgtable.h |   17 +++++++++++++++--
 arch/mips/mm/cache.c            |   10 ++++++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 008324d..7b175e5 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -95,6 +95,9 @@ extern void paging_init(void);
 
 #define pmd_page_vaddr(pmd)	pmd_val(pmd)
 
+static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
+	pte_t *ptep, pte_t pteval);
+
 #if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
 
 #define pte_none(pte)		(!(((pte).pte_low | (pte).pte_high) & ~_PAGE_GLOBAL))
@@ -118,7 +121,6 @@ static inline void set_pte(pte_t *ptep, pte_t pte)
 		}
 	}
 }
-#define set_pte_at(mm, addr, ptep, pteval) set_pte(ptep, pteval)
 
 static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
@@ -155,7 +157,6 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
 	}
 #endif
 }
-#define set_pte_at(mm, addr, ptep, pteval) set_pte(ptep, pteval)
 
 static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
@@ -169,6 +170,18 @@ static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *pt
 }
 #endif
 
+extern void mips_flush_dcache_from_pte(pte_t pteval);
+
+static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
+	pte_t *ptep, pte_t pteval)
+{
+	/* Make code globally visible before publishing the page
+	   table entry. */
+	if (addr < TASK_SIZE && pte_present(pteval))
+		mips_flush_dcache_from_pte(pteval);
+	set_pte(ptep, pteval);
+}
+
 /*
  * (pmds are folded into puds so this doesn't get actually called,
  * but the define is needed for a generic inline function.)
diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 9e67cde..1320afc 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -137,6 +137,16 @@ void __update_cache(struct vm_area_struct *vma, unsigned long address,
 	}
 }
 
+void mips_flush_dcache_from_pte(pte_t pteval)
+{
+	unsigned long pfn = pte_pfn(pteval);
+	if (likely(pfn_valid(pfn))) {
+		struct page *page = pfn_to_page(pfn);
+		if (Page_dcache_dirty(page))
+			flush_dcache_page(page);
+	}
+}
+
 unsigned long _page_cachable_default;
 EXPORT_SYMBOL(_page_cachable_default);
 
-- 
1.7.10.4
