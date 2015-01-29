Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jan 2015 17:47:34 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:49680 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012227AbbA2QqmQrjOB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Jan 2015 17:46:42 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1YGsBB-00011X-9U; Thu, 29 Jan 2015 10:42:53 -0600
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH 1/3] MIPS: Fix cache flushing for swap pages with non-DMA I/O.
Date:   Thu, 29 Jan 2015 10:46:14 -0600
Message-Id: <1422549976-10648-2-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1422549976-10648-1-git-send-email-Steven.Hill@imgtec.com>
References: <1422549976-10648-1-git-send-email-Steven.Hill@imgtec.com>
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45542
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

Flush the D-cache before the page is given to a process
as an executable (I-cache) page when the backing store
is non-DMA I/O.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/include/asm/cacheflush.h   |    3 ++-
 arch/mips/include/asm/cpu-features.h |    3 +++
 arch/mips/include/asm/page.h         |    5 +++-
 arch/mips/include/asm/pgtable.h      |    5 ++++
 arch/mips/mm/c-r4k.c                 |   19 +++++++++++++-
 arch/mips/mm/cache.c                 |   46 +++++++++++++++++-----------------
 arch/mips/mm/init.c                  |   23 +++++++++++------
 arch/mips/mm/sc-mips.c               |    1 +
 8 files changed, 72 insertions(+), 33 deletions(-)

diff --git a/arch/mips/include/asm/cacheflush.h b/arch/mips/include/asm/cacheflush.h
index e08381a..3a4582a 100644
--- a/arch/mips/include/asm/cacheflush.h
+++ b/arch/mips/include/asm/cacheflush.h
@@ -123,7 +123,8 @@ static inline void kunmap_noncoherent(void)
 #define ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
 static inline void flush_kernel_dcache_page(struct page *page)
 {
-	BUG_ON(cpu_has_dc_aliases && PageHighMem(page));
+	if (cpu_has_dc_aliases || !cpu_has_ic_fills_f_dc)
+		__flush_dcache_page(page);
 }
 
 /*
diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 2897cfa..23db770 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -139,6 +139,9 @@
 #ifndef cpu_has_vtag_icache
 #define cpu_has_vtag_icache	(cpu_data[0].icache.flags & MIPS_CACHE_VTAG)
 #endif
+#ifndef cpu_has_vtag_dcache
+#define cpu_has_vtag_dcache     (cpu_data[0].dcache.flags & MIPS_CACHE_VTAG)
+#endif
 #ifndef cpu_has_dc_aliases
 #define cpu_has_dc_aliases	(cpu_data[0].dcache.flags & MIPS_CACHE_ALIASES)
 #endif
diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index 154b70a..fc7ab98 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -95,13 +95,16 @@ static inline unsigned long pages_do_alias(unsigned long addr1,
 
 struct page;
 
+#include <asm/cpu-features.h>
+
 static inline void clear_user_page(void *addr, unsigned long vaddr,
 	struct page *page)
 {
 	extern void (*flush_data_cache_page)(unsigned long addr);
 
 	clear_page(addr);
-	if (pages_do_alias((unsigned long) addr, vaddr & PAGE_MASK))
+	if (cpu_has_vtag_dcache || (cpu_has_dc_aliases &&
+	     pages_do_alias((unsigned long) addr, vaddr & PAGE_MASK)))
 		flush_data_cache_page((unsigned long)addr);
 }
 
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 62a6ba3..0a6a944 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -148,6 +148,7 @@ static inline void set_pte(pte_t *ptep, pte_t pte)
 		}
 	}
 }
+#define set_pte_at(mm, addr, ptep, pteval) set_pte(ptep, pteval)
 
 static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
@@ -185,6 +186,7 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
 	}
 #endif
 }
+#define set_pte_at(mm, addr, ptep, pteval) set_pte(ptep, pteval)
 
 static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
@@ -401,12 +403,15 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 
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
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index dd261df..e045116 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -484,8 +484,11 @@ static inline void local_r4k_flush_cache_range(void * args)
 		return;
 
 	r4k_blast_dcache();
-	if (exec)
+	if (exec) {
+		if (!cpu_has_ic_fills_f_dc)
+			wmb();
 		r4k_blast_icache();
+	}
 }
 
 static void r4k_flush_cache_range(struct vm_area_struct *vma,
@@ -570,6 +573,14 @@ static inline void local_r4k_flush_cache_page(void *args)
 	if (!(pte_present(*ptep)))
 		return;
 
+	/*
+	 * If this page is not destined to be executable and the
+	 * data cache does not have aliases, all of the mapping
+	 * below can be skipped.
+	 */
+	if (!exec && !cpu_has_dc_aliases)
+		return;
+
 	if ((mm == current->active_mm) && (pte_val(*ptep) & _PAGE_VALID))
 		vaddr = NULL;
 	else {
@@ -589,6 +600,8 @@ static inline void local_r4k_flush_cache_page(void *args)
 	if (cpu_has_dc_aliases || (exec && !cpu_has_ic_fills_f_dc)) {
 		vaddr ? r4k_blast_dcache_page(addr) :
 			r4k_blast_dcache_user_page(addr);
+		if (exec && !cpu_has_ic_fills_f_dc)
+			wmb();
 		if (exec && !cpu_icache_snoops_remote_store)
 			r4k_blast_scache_page(addr);
 	}
@@ -621,6 +634,8 @@ static void r4k_flush_cache_page(struct vm_area_struct *vma,
 	args.pfn = pfn;
 
 	r4k_on_each_cpu(local_r4k_flush_cache_page, &args);
+	if (cpu_has_dc_aliases)
+		ClearPageDcacheDirty(pfn_to_page(pfn));
 }
 
 static inline void local_r4k_flush_data_cache_page(void * addr)
@@ -652,6 +667,8 @@ static inline void local_r4k_flush_icache_range(unsigned long start, unsigned lo
 		}
 	}
 
+	wmb();
+
 	if (end - start > icache_size)
 		r4k_blast_icache();
 	else {
diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 7e3ea77..99db9e8 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -19,6 +19,7 @@
 #include <asm/processor.h>
 #include <asm/cpu.h>
 #include <asm/cpu-features.h>
+#include <linux/highmem.h>
 
 /* Cache operations. */
 void (*flush_cache_all)(void);
@@ -105,48 +106,47 @@ void __flush_anon_page(struct page *page, unsigned long vmaddr)
 {
 	unsigned long addr = (unsigned long) page_address(page);
 
-	if (pages_do_alias(addr, vmaddr)) {
+	if (pages_do_alias(addr, vmaddr & PAGE_MASK)) {
 		if (page_mapped(page) && !Page_dcache_dirty(page)) {
 			void *kaddr;
 
 			kaddr = kmap_coherent(page, vmaddr);
 			flush_data_cache_page((unsigned long)kaddr);
 			kunmap_coherent();
-		} else
-			flush_data_cache_page(addr);
+		} else {
+			void *kaddr;
+
+			kaddr = kmap_atomic(page);
+			flush_data_cache_page((unsigned long)kaddr);
+			kunmap_atomic(kaddr);
+			ClearPageDcacheDirty(page);
+		}
 	}
 }
 
 EXPORT_SYMBOL(__flush_anon_page);
 
-static void mips_flush_dcache_from_pte(pte_t pteval, unsigned long address)
+void __update_cache(struct vm_area_struct *vma, unsigned long address,
+	pte_t pte)
 {
 	struct page *page;
-	unsigned long pfn = pte_pfn(pteval);
+	unsigned long pfn = pte_pfn(pte);
+	int exec = (vma->vm_flags & VM_EXEC) && !cpu_has_ic_fills_f_dc;
 
-	if (unlikely(!pfn_valid(pfn)))
+	if (unlikely(!pfn_valid(pfn))) {
+		wmb();
 		return;
-
+	}
 	page = pfn_to_page(pfn);
-	if (page_mapping(page) && Page_dcache_dirty(page)) {
+	if (page_mapped(page) && Page_dcache_dirty(page)) {
 		unsigned long page_addr = (unsigned long) page_address(page);
-
-		if (!cpu_has_ic_fills_f_dc ||
-		    pages_do_alias(page_addr, address & PAGE_MASK))
+		if (exec || (cpu_has_dc_aliases &&
+		    pages_do_alias(page_addr, address & PAGE_MASK))) {
 			flush_data_cache_page(page_addr);
-		ClearPageDcacheDirty(page);
+			ClearPageDcacheDirty(page);
+		}
 	}
-}
-
-void set_pte_at(struct mm_struct *mm, unsigned long addr,
-        pte_t *ptep, pte_t pteval)
-{
-        if (cpu_has_dc_aliases || !cpu_has_ic_fills_f_dc) {
-                if (pte_present(pteval))
-                        mips_flush_dcache_from_pte(pteval, addr);
-        }
-
-        set_pte(ptep, pteval);
+	wmb();  /* finish any outstanding arch cache flushes before ret to user */
 }
 
 unsigned long _page_cachable_default;
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 448cde3..597bf7f 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -165,9 +165,15 @@ void copy_user_highpage(struct page *to, struct page *from,
 		copy_page(vto, vfrom);
 		kunmap_atomic(vfrom);
 	}
-	if ((!cpu_has_ic_fills_f_dc) ||
-	    pages_do_alias((unsigned long)vto, vaddr & PAGE_MASK))
+	if (cpu_has_dc_aliases)
+		SetPageDcacheDirty(to);
+	if (((vma->vm_flags & VM_EXEC) && !cpu_has_ic_fills_f_dc) ||
+	    cpu_has_vtag_dcache || (cpu_has_dc_aliases &&
+	     pages_do_alias((unsigned long)vto, vaddr & PAGE_MASK))) {
 		flush_data_cache_page((unsigned long)vto);
+		if (cpu_has_dc_aliases)
+			ClearPageDcacheDirty(to);
+	}
 	kunmap_atomic(vto);
 	/* Make sure this page is cleared on other CPU's too before using it */
 	smp_wmb();
@@ -187,8 +193,14 @@ void copy_to_user_page(struct vm_area_struct *vma,
 		if (cpu_has_dc_aliases)
 			SetPageDcacheDirty(page);
 	}
-	if ((vma->vm_flags & VM_EXEC) && !cpu_has_ic_fills_f_dc)
+	if (((vma->vm_flags & VM_EXEC) && !cpu_has_ic_fills_f_dc) ||
+	    (Page_dcache_dirty(page) &&
+	     pages_do_alias((unsigned long)dst & PAGE_MASK,
+			    vaddr & PAGE_MASK))) {
 		flush_cache_page(vma, vaddr, page_to_pfn(page));
+		if (cpu_has_dc_aliases)
+			ClearPageDcacheDirty(page);
+	}
 }
 
 void copy_from_user_page(struct vm_area_struct *vma,
@@ -200,11 +212,8 @@ void copy_from_user_page(struct vm_area_struct *vma,
 		void *vfrom = kmap_coherent(page, vaddr) + (vaddr & ~PAGE_MASK);
 		memcpy(dst, vfrom, len);
 		kunmap_coherent();
-	} else {
+	} else
 		memcpy(dst, src, len);
-		if (cpu_has_dc_aliases)
-			SetPageDcacheDirty(page);
-	}
 }
 EXPORT_SYMBOL_GPL(copy_from_user_page);
 
diff --git a/arch/mips/mm/sc-mips.c b/arch/mips/mm/sc-mips.c
index 99eb8fa..e1db410 100644
--- a/arch/mips/mm/sc-mips.c
+++ b/arch/mips/mm/sc-mips.c
@@ -24,6 +24,7 @@
  */
 static void mips_sc_wback_inv(unsigned long addr, unsigned long size)
 {
+	__sync();
 	blast_scache_range(addr, addr + size);
 }
 
-- 
1.7.10.4
