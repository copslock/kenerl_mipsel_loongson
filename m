Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Sep 2006 16:41:27 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:15320 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038478AbWIAPlY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 Sep 2006 16:41:24 +0100
Received: from localhost (p2154-ipad201funabasi.chiba.ocn.ne.jp [222.146.65.154])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 231ABBBAB; Sat,  2 Sep 2006 00:41:15 +0900 (JST)
Date:	Sat, 02 Sep 2006 00:43:07 +0900 (JST)
Message-Id: <20060902.004307.41010946.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] remove __flush_icache_page
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12498
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Now nobody use __flash_icache_page.  We can remove them completely.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/mm/c-r3k.c b/arch/mips/mm/c-r3k.c
index e1f35ef..d1af42c 100644
--- a/arch/mips/mm/c-r3k.c
+++ b/arch/mips/mm/c-r3k.c
@@ -268,26 +268,6 @@ static void r3k_flush_data_cache_page(un
 {
 }
 
-static void r3k_flush_icache_page(struct vm_area_struct *vma, struct page *page)
-{
-	struct mm_struct *mm = vma->vm_mm;
-	unsigned long physpage;
-
-	if (cpu_context(smp_processor_id(), mm) == 0)
-		return;
-
-	if (!(vma->vm_flags & VM_EXEC))
-		return;
-
-#ifdef DEBUG_CACHE
-	printk("cpage[%d,%08lx]", cpu_context(smp_processor_id(), mm), page);
-#endif
-
-	physpage = (unsigned long) page_address(page);
-	if (physpage)
-		r3k_flush_icache_range(physpage, physpage + PAGE_SIZE);
-}
-
 static void r3k_flush_cache_sigtramp(unsigned long addr)
 {
 	unsigned long flags;
@@ -335,7 +315,6 @@ void __init r3k_cache_init(void)
 	flush_cache_mm = r3k_flush_cache_mm;
 	flush_cache_range = r3k_flush_cache_range;
 	flush_cache_page = r3k_flush_cache_page;
-	__flush_icache_page = r3k_flush_icache_page;
 	flush_icache_range = r3k_flush_icache_range;
 
 	flush_cache_sigtramp = r3k_flush_cache_sigtramp;
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 2d729f6..6477e4a 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -551,82 +551,6 @@ static void r4k_flush_icache_range(unsig
 	instruction_hazard();
 }
 
-/*
- * Ok, this seriously sucks.  We use them to flush a user page but don't
- * know the virtual address, so we have to blast away the whole icache
- * which is significantly more expensive than the real thing.  Otoh we at
- * least know the kernel address of the page so we can flush it
- * selectivly.
- */
-
-struct flush_icache_page_args {
-	struct vm_area_struct *vma;
-	struct page *page;
-};
-
-static inline void local_r4k_flush_icache_page(void *args)
-{
-	struct flush_icache_page_args *fip_args = args;
-	struct vm_area_struct *vma = fip_args->vma;
-	struct page *page = fip_args->page;
-
-	/*
-	 * Tricky ...  Because we don't know the virtual address we've got the
-	 * choice of either invalidating the entire primary and secondary
-	 * caches or invalidating the secondary caches also.  With the subset
-	 * enforcment on R4000SC, R4400SC, R10000 and R12000 invalidating the
-	 * secondary cache will result in any entries in the primary caches
-	 * also getting invalidated which hopefully is a bit more economical.
-	 */
-	if (cpu_has_inclusive_pcaches) {
-		unsigned long addr = (unsigned long) page_address(page);
-
-		r4k_blast_scache_page(addr);
-		ClearPageDcacheDirty(page);
-
-		return;
-	}
-
-	if (!cpu_has_ic_fills_f_dc) {
-		unsigned long addr = (unsigned long) page_address(page);
-		r4k_blast_dcache_page(addr);
-		if (!cpu_icache_snoops_remote_store)
-			r4k_blast_scache_page(addr);
-		ClearPageDcacheDirty(page);
-	}
-
-	/*
-	 * We're not sure of the virtual address(es) involved here, so
-	 * we have to flush the entire I-cache.
-	 */
-	if (cpu_has_vtag_icache && vma->vm_mm == current->active_mm) {
-		int cpu = smp_processor_id();
-
-		if (cpu_context(cpu, vma->vm_mm) != 0)
-			drop_mmu_context(vma->vm_mm, cpu);
-	} else
-		r4k_blast_icache();
-}
-
-static void r4k_flush_icache_page(struct vm_area_struct *vma,
-	struct page *page)
-{
-	struct flush_icache_page_args args;
-
-	/*
-	 * If there's no context yet, or the page isn't executable, no I-cache
-	 * flush is needed.
-	 */
-	if (!(vma->vm_flags & VM_EXEC))
-		return;
-
-	args.vma = vma;
-	args.page = page;
-
-	r4k_on_each_cpu(local_r4k_flush_icache_page, &args, 1, 1);
-}
-
-
 #ifdef CONFIG_DMA_NONCOHERENT
 
 static void r4k_dma_cache_wback_inv(unsigned long addr, unsigned long size)
@@ -1291,7 +1215,6 @@ void __init r4k_cache_init(void)
 	__flush_cache_all	= r4k___flush_cache_all;
 	flush_cache_mm		= r4k_flush_cache_mm;
 	flush_cache_page	= r4k_flush_cache_page;
-	__flush_icache_page	= r4k_flush_icache_page;
 	flush_cache_range	= r4k_flush_cache_range;
 
 	flush_cache_sigtramp	= r4k_flush_cache_sigtramp;
diff --git a/arch/mips/mm/c-sb1.c b/arch/mips/mm/c-sb1.c
index 16bad7c..5537558 100644
--- a/arch/mips/mm/c-sb1.c
+++ b/arch/mips/mm/c-sb1.c
@@ -307,66 +307,6 @@ void sb1_flush_icache_range(unsigned lon
 #endif
 
 /*
- * Flush the icache for a given physical page.  Need to writeback the
- * dcache first, then invalidate the icache.  If the page isn't
- * executable, nothing is required.
- */
-static void local_sb1_flush_icache_page(struct vm_area_struct *vma,
-	struct page *page)
-{
-	unsigned long start;
-	int cpu = smp_processor_id();
-
-#ifndef CONFIG_SMP
-	if (!(vma->vm_flags & VM_EXEC))
-		return;
-#endif
-
-	/* Need to writeback any dirty data for that page, we have the PA */
-	start = (unsigned long)(page-mem_map) << PAGE_SHIFT;
-	__sb1_writeback_inv_dcache_phys_range(start, start + PAGE_SIZE);
-	/*
-	 * If there's a context, bump the ASID (cheaper than a flush,
-	 * since we don't know VAs!)
-	 */
-	if (vma->vm_mm == current->active_mm) {
-		if (cpu_context(cpu, vma->vm_mm) != 0)
-			drop_mmu_context(vma->vm_mm, cpu);
-	} else
-		__sb1_flush_icache_range(start, start + PAGE_SIZE);
-
-}
-
-#ifdef CONFIG_SMP
-struct flush_icache_page_args {
-	struct vm_area_struct *vma;
-	struct page *page;
-};
-
-static void sb1_flush_icache_page_ipi(void *info)
-{
-	struct flush_icache_page_args *args = info;
-	local_sb1_flush_icache_page(args->vma, args->page);
-}
-
-/* Dirty dcache could be on another CPU, so do the IPIs */
-static void sb1_flush_icache_page(struct vm_area_struct *vma,
-	struct page *page)
-{
-	struct flush_icache_page_args args;
-
-	if (!(vma->vm_flags & VM_EXEC))
-		return;
-	args.vma = vma;
-	args.page = page;
-	on_each_cpu(sb1_flush_icache_page_ipi, (void *) &args, 1, 1);
-}
-#else
-void sb1_flush_icache_page(struct vm_area_struct *vma, struct page *page)
-	__attribute__((alias("local_sb1_flush_icache_page")));
-#endif
-
-/*
  * A signal trampoline must fit into a single cacheline.
  */
 static void local_sb1_flush_cache_sigtramp(unsigned long addr)
@@ -526,7 +466,6 @@ #endif
 
 	/* These routines are for Icache coherence with the Dcache */
 	flush_icache_range = sb1_flush_icache_range;
-	__flush_icache_page = sb1_flush_icache_page;
 	flush_icache_all = __sb1_flush_icache_all; /* local only */
 
 	/* This implies an Icache flush too, so can't be nop'ed */
diff --git a/arch/mips/mm/c-tx39.c b/arch/mips/mm/c-tx39.c
index 932a09d..f32ebde 100644
--- a/arch/mips/mm/c-tx39.c
+++ b/arch/mips/mm/c-tx39.c
@@ -248,33 +248,6 @@ static void tx39_flush_icache_range(unsi
 	}
 }
 
-/*
- * Ok, this seriously sucks.  We use them to flush a user page but don't
- * know the virtual address, so we have to blast away the whole icache
- * which is significantly more expensive than the real thing.  Otoh we at
- * least know the kernel address of the page so we can flush it
- * selectivly.
- */
-static void tx39_flush_icache_page(struct vm_area_struct *vma, struct page *page)
-{
-	unsigned long addr;
-	/*
-	 * If there's no context yet, or the page isn't executable, no icache
-	 * flush is needed.
-	 */
-	if (!(vma->vm_flags & VM_EXEC))
-		return;
-
-	addr = (unsigned long) page_address(page);
-	tx39_blast_dcache_page(addr);
-
-	/*
-	 * We're not sure of the virtual address(es) involved here, so
-	 * we have to flush the entire I-cache.
-	 */
-	tx39_blast_icache();
-}
-
 static void tx39_dma_cache_wback_inv(unsigned long addr, unsigned long size)
 {
 	unsigned long end;
@@ -382,7 +355,6 @@ void __init tx39_cache_init(void)
 		flush_cache_mm		= (void *) tx39h_flush_icache_all;
 		flush_cache_range	= (void *) tx39h_flush_icache_all;
 		flush_cache_page	= (void *) tx39h_flush_icache_all;
-		__flush_icache_page	= (void *) tx39h_flush_icache_all;
 		flush_icache_range	= (void *) tx39h_flush_icache_all;
 
 		flush_cache_sigtramp	= (void *) tx39h_flush_icache_all;
@@ -408,7 +380,6 @@ void __init tx39_cache_init(void)
 		flush_cache_mm = tx39_flush_cache_mm;
 		flush_cache_range = tx39_flush_cache_range;
 		flush_cache_page = tx39_flush_cache_page;
-		__flush_icache_page = tx39_flush_icache_page;
 		flush_icache_range = tx39_flush_icache_range;
 
 		flush_cache_sigtramp = tx39_flush_cache_sigtramp;
diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 40c8b02..caf807d 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -25,7 +25,6 @@ void (*flush_cache_range)(struct vm_area
 void (*flush_cache_page)(struct vm_area_struct *vma, unsigned long page,
 	unsigned long pfn);
 void (*flush_icache_range)(unsigned long start, unsigned long end);
-void (*__flush_icache_page)(struct vm_area_struct *vma, struct page *page);
 
 /* MIPS specific cache operations */
 void (*flush_cache_sigtramp)(unsigned long addr);
diff --git a/include/asm-mips/cacheflush.h b/include/asm-mips/cacheflush.h
index d10517c..e3c9925 100644
--- a/include/asm-mips/cacheflush.h
+++ b/include/asm-mips/cacheflush.h
@@ -46,8 +46,6 @@ static inline void flush_dcache_page(str
 #define flush_dcache_mmap_lock(mapping)		do { } while (0)
 #define flush_dcache_mmap_unlock(mapping)	do { } while (0)
 
-extern void (*__flush_icache_page)(struct vm_area_struct *vma,
-	struct page *page);
 static inline void flush_icache_page(struct vm_area_struct *vma,
 	struct page *page)
 {
