Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Feb 2015 14:16:29 +0100 (CET)
Received: from bastet.se.axis.com ([195.60.68.11]:39662 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007407AbbBZNQMOSXe1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Feb 2015 14:16:12 +0100
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 5ADB41812A;
        Thu, 26 Feb 2015 14:16:07 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id PDRvCJHWM5qO; Thu, 26 Feb 2015 14:16:05 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
        by bastet.se.axis.com (Postfix) with ESMTP id D74FA18128;
        Thu, 26 Feb 2015 14:16:05 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
        by postfix.imss71 (Postfix) with ESMTP id C02FCF29;
        Thu, 26 Feb 2015 14:16:05 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
        by boulder.se.axis.com (Postfix) with ESMTP id B4D69FBA;
        Thu, 26 Feb 2015 14:16:05 +0100 (CET)
Received: from lnxlarper.se.axis.com (lnxlarper.se.axis.com [10.88.41.1])
        by thoth.se.axis.com (Postfix) with ESMTP id B223F3432B;
        Thu, 26 Feb 2015 14:16:05 +0100 (CET)
Received: by lnxlarper.se.axis.com (Postfix, from userid 20456)
        id AEC2E801D2; Thu, 26 Feb 2015 14:16:05 +0100 (CET)
From:   Lars Persson <lars.persson@axis.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        paul.burton@imgtec.com
Cc:     linux-kernel@vger.kernel.org, Lars Persson <larper@axis.com>
Subject: [PATCH 1/2] Revert "MIPS: Remove race window in page fault handling"
Date:   Thu, 26 Feb 2015 14:16:02 +0100
Message-Id: <1424956563-29535-2-git-send-email-larper@axis.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1424956563-29535-1-git-send-email-larper@axis.com>
References: <1424956563-29535-1-git-send-email-larper@axis.com>
Return-Path: <lars.persson@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46001
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

Revert commit 2a4a8b1e5d9d ("MIPS: Remove race window in page fault
handling") because it increased the number of flushed dcache pages and
became a performance problem for some workloads.

Signed-off-by: Lars Persson <larper@axis.com>
---
 arch/mips/include/asm/pgtable.h |   10 ++++++----
 arch/mips/mm/cache.c            |   27 ++++++++-------------------
 2 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index bef782c..bd6d1cf 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -127,12 +127,9 @@ do {									\
 	}								\
 } while(0)
 
-
-extern void set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
-	pte_t pteval);
-
 #if defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32)
 
+
 #define pte_none(pte)		(!(((pte).pte_low | (pte).pte_high) & ~_PAGE_GLOBAL))
 #define pte_present(pte)	((pte).pte_low & _PAGE_PRESENT)
 
@@ -154,6 +151,7 @@ static inline void set_pte(pte_t *ptep, pte_t pte)
 		}
 	}
 }
+#define set_pte_at(mm, addr, ptep, pteval) set_pte(ptep, pteval)
 
 static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
@@ -192,6 +190,7 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
 	}
 #endif
 }
+#define set_pte_at(mm, addr, ptep, pteval) set_pte(ptep, pteval)
 
 static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
@@ -407,12 +406,15 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 
 extern void __update_tlb(struct vm_area_struct *vma, unsigned long address,
 	pte_t pte);
+extern void __update_cache(struct vm_area_struct *vma, unsigned long address,
+	pte_t pte);
 
 static inline void update_mmu_cache(struct vm_area_struct *vma,
 	unsigned long address, pte_t *ptep)
 {
 	pte_t pte = *ptep;
 	__update_tlb(vma, address, pte);
+	__update_cache(vma, address, pte);
 }
 
 static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 7e3ea77..f7b91d3 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -119,36 +119,25 @@ void __flush_anon_page(struct page *page, unsigned long vmaddr)
 
 EXPORT_SYMBOL(__flush_anon_page);
 
-static void mips_flush_dcache_from_pte(pte_t pteval, unsigned long address)
+void __update_cache(struct vm_area_struct *vma, unsigned long address,
+	pte_t pte)
 {
 	struct page *page;
-	unsigned long pfn = pte_pfn(pteval);
+	unsigned long pfn, addr;
+	int exec = (vma->vm_flags & VM_EXEC) && !cpu_has_ic_fills_f_dc;
 
+	pfn = pte_pfn(pte);
 	if (unlikely(!pfn_valid(pfn)))
 		return;
-
 	page = pfn_to_page(pfn);
 	if (page_mapping(page) && Page_dcache_dirty(page)) {
-		unsigned long page_addr = (unsigned long) page_address(page);
-
-		if (!cpu_has_ic_fills_f_dc ||
-		    pages_do_alias(page_addr, address & PAGE_MASK))
-			flush_data_cache_page(page_addr);
+		addr = (unsigned long) page_address(page);
+		if (exec || pages_do_alias(addr, address & PAGE_MASK))
+			flush_data_cache_page(addr);
 		ClearPageDcacheDirty(page);
 	}
 }
 
-void set_pte_at(struct mm_struct *mm, unsigned long addr,
-        pte_t *ptep, pte_t pteval)
-{
-        if (cpu_has_dc_aliases || !cpu_has_ic_fills_f_dc) {
-                if (pte_present(pteval))
-                        mips_flush_dcache_from_pte(pteval, addr);
-        }
-
-        set_pte(ptep, pteval);
-}
-
 unsigned long _page_cachable_default;
 EXPORT_SYMBOL(_page_cachable_default);
 
-- 
1.7.10.4
