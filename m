Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Dec 2014 04:25:54 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:3149 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006653AbaLCDZwbQB7O (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Dec 2014 04:25:52 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 36283A4ADA148;
        Wed,  3 Dec 2014 03:25:44 +0000 (GMT)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 3 Dec
 2014 03:25:45 +0000
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 3 Dec
 2014 03:25:45 +0000
Received: from [127.0.1.1] (192.168.65.146) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Tue, 2 Dec 2014
 19:25:42 -0800
Subject: [PATCH] Revert "MIPS: Remove race window in page fault handling"
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
To:     <linux-mips@linux-mips.org>, <james.hogan@imgtec.com>,
        <keescook@chromium.org>, <paul.burton@imgtec.com>,
        <linux-kernel@vger.kernel.org>, <ralf@linux-mips.org>,
        <lars.persson@axis.com>, <manuel.lauss@gmail.com>,
        <pbonzini@redhat.com>, <akpm@linux-foundation.org>,
        <blogic@openwrt.org>, <markos.chandras@imgtec.com>
Date:   Tue, 2 Dec 2014 19:25:42 -0800
Message-ID: <20141203032542.15388.17340.stgit@linux-yegoshin>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.65.146]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44552
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

This reverts commit 64f23ab30b1fec86b91a48bf1f088840e5299971
(commit 2a4a8b1e5d9d343e13ff22e19af7b353f7b52d6f in Linux 'master')

Unfortunately the original commit effectively kills Imagination MIPS CPUs
performance because it enforces page cache flush each time then PTE is changed
for our CPUs. Basically - each CoW, each process start, each library attachment
or detachment. And it happens even in "fully-coherent" systems (in MIPS sense -
we have non coherent I-cache). Last tendency for increasing page size to 16K-64K
even exaggerate the performance loss.

Original commit discussion says:

    Kernel call stacks showed one thread handling an illegal instruction
    exception while another thread was somewhere around the
    set_pte_at/update_mmu_cache calls for the same page.

If this is taken correct then it points to a major problem unrelated to MIPS -
if by chance a first thread hits the page just before set_pte_at then it should
get a non-present PTE: set_pte_at with _PAGE_PRESENT/_PAGE_VALID flags can be
used only on "disactivated" PTE, after pte_clear* functions, effectively -
non-present, non-valid. And application can get SIGSEGV. It is a major race
condition and kernel should not offer it to applications. And in my
understanding set_pte_at is used in cases then page is available after kernel
finishes page handling, at least in theory.

Test note: I ran MIPS 1004K with 8 VPEs on 4 cores around 1.5 month on SOAK test
and never seen that problem on 3.10 kernel.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
---
 arch/mips/include/asm/pgtable.h |    8 +++++---
 arch/mips/mm/cache.c            |   27 ++++++++-------------------
 2 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index d6d1928539b1..cd5fbf42b864 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -122,9 +122,6 @@ do {									\
 	}								\
 } while(0)
 
-extern void set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
-	pte_t pteval);
-
 #if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
 
 #define pte_none(pte)		(!(((pte).pte_low | (pte).pte_high) & ~_PAGE_GLOBAL))
@@ -148,6 +145,7 @@ static inline void set_pte(pte_t *ptep, pte_t pte)
 		}
 	}
 }
+#define set_pte_at(mm, addr, ptep, pteval) set_pte(ptep, pteval)
 
 static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
@@ -185,6 +183,7 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
 	}
 #endif
 }
+#define set_pte_at(mm, addr, ptep, pteval) set_pte(ptep, pteval)
 
 static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
@@ -401,12 +400,15 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 
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
index 7e3ea7766822..f7b91d3a371d 100644
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
 
