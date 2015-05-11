Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 May 2015 19:56:03 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:35680 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27027460AbbEKRzodUWRe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 May 2015 19:55:44 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DEF8FBB0;
        Mon, 11 May 2015 17:55:39 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lars Persson <larper@axis.com>, linux-mips@linux-mips.org,
        paul.burton@imgtec.com, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.0 10/72] Revert "MIPS: Remove race window in page fault handling"
Date:   Mon, 11 May 2015 10:54:16 -0700
Message-Id: <20150511175437.413750700@linuxfoundation.org>
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
X-archive-position: 47312
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

Commit 5b9593f3bccb9904f260f9ad7f184e1d2921bd1e upstream.

Revert commit 2a4a8b1e5d9d ("MIPS: Remove race window in page fault
handling") because it increased the number of flushed dcache pages and
became a performance problem for some workloads.

Signed-off-by: Lars Persson <larper@axis.com>
Cc: linux-mips@linux-mips.org
Cc: paul.burton@imgtec.com
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/9345/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/include/asm/pgtable.h |    9 +++++----
 arch/mips/mm/cache.c            |   27 ++++++++-------------------
 2 files changed, 13 insertions(+), 23 deletions(-)

--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -127,10 +127,6 @@ do {									\
 	}								\
 } while(0)
 
-
-extern void set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
-	pte_t pteval);
-
 #if defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32)
 
 #define pte_none(pte)		(!(((pte).pte_low | (pte).pte_high) & ~_PAGE_GLOBAL))
@@ -154,6 +150,7 @@ static inline void set_pte(pte_t *ptep,
 		}
 	}
 }
+#define set_pte_at(mm, addr, ptep, pteval) set_pte(ptep, pteval)
 
 static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
@@ -192,6 +189,7 @@ static inline void set_pte(pte_t *ptep,
 	}
 #endif
 }
+#define set_pte_at(mm, addr, ptep, pteval) set_pte(ptep, pteval)
 
 static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
@@ -407,12 +405,15 @@ static inline pte_t pte_modify(pte_t pte
 
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
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -119,36 +119,25 @@ void __flush_anon_page(struct page *page
 
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
 
