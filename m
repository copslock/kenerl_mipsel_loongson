Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Aug 2014 15:48:23 +0200 (CEST)
Received: from bastet.se.axis.com ([195.60.68.11]:60351 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6875437AbaHHNsUcLci0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Aug 2014 15:48:20 +0200
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 38F5A180F6;
        Fri,  8 Aug 2014 15:48:13 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id NphNSLmGBt53; Fri,  8 Aug 2014 15:48:07 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
        by bastet.se.axis.com (Postfix) with ESMTP id E5E3118082;
        Fri,  8 Aug 2014 15:48:07 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
        by postfix.imss71 (Postfix) with ESMTP id C1EDFD40;
        Fri,  8 Aug 2014 15:48:07 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
        by boulder.se.axis.com (Postfix) with ESMTP id B3880D3F;
        Fri,  8 Aug 2014 15:48:07 +0200 (CEST)
Received: from lnxlarper.se.axis.com (lnxlarper.se.axis.com [10.88.41.1])
        by thoth.se.axis.com (Postfix) with ESMTP id B19AC34005;
        Fri,  8 Aug 2014 15:48:07 +0200 (CEST)
Received: by lnxlarper.se.axis.com (Postfix, from userid 20456)
        id C78EC800B9; Fri,  8 Aug 2014 15:48:07 +0200 (CEST)
From:   Lars Persson <lars.persson@axis.com>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Lars Persson <larper@axis.com>
Subject: [PATCH v2] MIPS: Remove race window in page fault handling
Date:   Fri,  8 Aug 2014 15:47:48 +0200
Message-Id: <1407505668-18547-1-git-send-email-larper@axis.com>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <lars.persson@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41909
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
condition in the page fault handler. The page table entry was
published before any pending lazy D-cache flush was committed, hence
it allowed execution of stale page cache data by other VPEs in the
system.

To make the cache handling safe we need to perform flushing already in
the set_pte_at function. MIPSes without coherent I-caches can get a
small increase in flushes due to the unavailability of the execute
flag in set_pte_at.

Signed-off-by: Lars Persson <larper@axis.com>
---
 arch/mips/include/asm/pgtable.h |   22 +++++++++++++++++-----
 arch/mips/mm/cache.c            |   16 ++++++++--------
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 027c74d..1834298 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -122,6 +122,9 @@ do {									\
 	}								\
 } while(0)
 
+static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
+	pte_t *ptep, pte_t pteval);
+
 #if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
 
 #define pte_none(pte)		(!(((pte).pte_low | (pte).pte_high) & ~_PAGE_GLOBAL))
@@ -145,7 +148,6 @@ static inline void set_pte(pte_t *ptep, pte_t pte)
 		}
 	}
 }
-#define set_pte_at(mm, addr, ptep, pteval) set_pte(ptep, pteval)
 
 static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
@@ -183,7 +185,6 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
 	}
 #endif
 }
-#define set_pte_at(mm, addr, ptep, pteval) set_pte(ptep, pteval)
 
 static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
@@ -198,6 +199,20 @@ static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *pt
 }
 #endif
 
+extern void mips_flush_dcache_from_pte(pte_t pteval, unsigned long address);
+
+static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
+	pte_t *ptep, pte_t pteval)
+{
+	if (cpu_has_dc_aliases || !cpu_has_ic_fills_f_dc) {
+		if (pte_present(pteval))
+			mips_flush_dcache_from_pte(pteval, addr);
+	}
+
+	set_pte(ptep, pteval);
+}
+
+
 /*
  * (pmds are folded into puds so this doesn't get actually called,
  * but the define is needed for a generic inline function.)
@@ -390,15 +405,12 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 
 extern void __update_tlb(struct vm_area_struct *vma, unsigned long address,
 	pte_t pte);
-extern void __update_cache(struct vm_area_struct *vma, unsigned long address,
-	pte_t pte);
 
 static inline void update_mmu_cache(struct vm_area_struct *vma,
 	unsigned long address, pte_t *ptep)
 {
 	pte_t pte = *ptep;
 	__update_tlb(vma, address, pte);
-	__update_cache(vma, address, pte);
 }
 
 static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index f7b91d3..0d0eb04 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -119,21 +119,21 @@ void __flush_anon_page(struct page *page, unsigned long vmaddr)
 
 EXPORT_SYMBOL(__flush_anon_page);
 
-void __update_cache(struct vm_area_struct *vma, unsigned long address,
-	pte_t pte)
+void mips_flush_dcache_from_pte(pte_t pteval, unsigned long address)
 {
 	struct page *page;
-	unsigned long pfn, addr;
-	int exec = (vma->vm_flags & VM_EXEC) && !cpu_has_ic_fills_f_dc;
+	unsigned long pfn = pte_pfn(pteval);
 
-	pfn = pte_pfn(pte);
 	if (unlikely(!pfn_valid(pfn)))
 		return;
+
 	page = pfn_to_page(pfn);
 	if (page_mapping(page) && Page_dcache_dirty(page)) {
-		addr = (unsigned long) page_address(page);
-		if (exec || pages_do_alias(addr, address & PAGE_MASK))
-			flush_data_cache_page(addr);
+		unsigned long page_addr = (unsigned long) page_address(page);
+
+		if (!cpu_has_ic_fills_f_dc ||
+		    pages_do_alias(page_addr, address & PAGE_MASK))
+			flush_data_cache_page(page_addr);
 		ClearPageDcacheDirty(page);
 	}
 }
-- 
1.7.10.4
