Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Mar 2003 00:55:55 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:8069 "EHLO
	neno.mitica") by linux-mips.org with ESMTP id <S8225209AbTC1AyI>;
	Fri, 28 Mar 2003 00:54:08 +0000
Received: by neno.mitica (Postfix, from userid 501)
	id 18EDD46BA6; Fri, 28 Mar 2003 01:52:39 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: c-r4k.c 6/7 simplify flush_cache_page
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: Fri, 28 Mar 2003 01:52:39 +0100
Message-ID: <m2of3w9uso.fsf@neno.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1847
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
	create r4k_blast_page{indexed} functions.  That allows to remove the
	r4600 variant of the r4k_flush_page_cache.  Once there, fix the bug
	we were testing _PAGE_VALID, instead of _PAGE_PRESENT.

	Once there, also define a nice inline to test for _PAGE_VALID.

Later, Juan.


 build/arch/mips/mm/c-r4k.c       |  122 +++++++++++++++------------------------
 build/include/asm-mips/pgtable.h |    1 
 2 files changed, 48 insertions(+), 75 deletions(-)

diff -puN build/include/asm-mips/pgtable.h~c-r4k_flush_cache_page build/include/asm-mips/pgtable.h
--- 24/build/include/asm-mips/pgtable.h~c-r4k_flush_cache_page	2003-03-28 01:18:02.000000000 +0100
+++ 24-quintela/build/include/asm-mips/pgtable.h	2003-03-28 01:19:33.000000000 +0100
@@ -220,6 +220,7 @@ static inline void pmd_set(pmd_t * pmdp,
 
 static inline int pte_none(pte_t pte)    { return !(pte_val(pte) & ~_PAGE_GLOBAL); }
 static inline int pte_present(pte_t pte) { return pte_val(pte) & _PAGE_PRESENT; }
+static inline int pte_valid(pte_t pte) { return pte_val(pte) & _PAGE_VALID; }
 
 /* Certain architectures need to do special things when pte's
  * within a page table are directly modified.  Thus, the following
diff -puN build/arch/mips/mm/c-r4k.c~c-r4k_flush_cache_page build/arch/mips/mm/c-r4k.c
--- 24/build/arch/mips/mm/c-r4k.c~c-r4k_flush_cache_page	2003-03-28 01:18:16.000000000 +0100
+++ 24-quintela/build/arch/mips/mm/c-r4k.c	2003-03-28 01:37:01.000000000 +0100
@@ -228,6 +228,49 @@ init:
 	goto *l;
 }
 
+static void r4k_blast_cache_page(unsigned long page, int exec)
+{
+	r4k_blast_dcache_page(page);
+	if (exec)
+		r4k_blast_icache_page(page);
+}
+
+static void r4k_blast_cache_page_indexed(unsigned long page, int exec)
+{
+	unsigned long addr = (KSEG0 + (page & (dcache_size - 1)));
+	static void *l = &&init;
+
+	goto *l;
+
+normal:
+	r4k_blast_dcache_page_indexed(addr);
+	if (exec)
+		r4k_blast_icache_page_indexed(addr);
+	return;
+
+r4600:
+	r4k_blast_dcache_page_indexed(addr);
+	r4k_blast_dcache_page_indexed(addr & dcache_waybit);
+	if (exec) {
+		r4k_blast_icache_page_indexed(addr);
+		r4k_blast_icache_page_indexed(addr ^ icache_waybit);
+	}
+	return;
+
+init:
+	switch(mips_cpu.cputype) {
+	case CPU_R4600:			/* QED style two way caches? */
+	case CPU_R4700:
+	case CPU_R5000:
+	case CPU_NEVADA:
+		l = && r4600;
+		break;
+	default:
+		l = &&normal;
+	}
+	goto *l;
+}
+
 static inline void r4k_flush_scache_all(void)
 {
 	r4k_blast_dcache();
@@ -286,7 +329,7 @@ static void r4k_flush_cache_page(struct 
 	 * If the page isn't marked valid, the page cannot possibly be
 	 * in the cache.
 	 */
-	if (!(pte_val(*ptep) & _PAGE_VALID))
+	if (!pte_present(*ptep))
 		return;
 
 	/*
@@ -295,11 +338,8 @@ static void r4k_flush_cache_page(struct 
 	 * for every cache flush operation.  So we do indexed flushes
 	 * in that case, which doesn't overly flush the cache too much.
 	 */
-	if (mm == current->active_mm) {
-		r4k_blast_dcache_page(page);
-		if (exec)
-			r4k_blast_icache_page(page);
-
+	if ((mm == current->active_mm) && pte_valid(*ptep)) {
+		r4k_blast_cache_page(page, exec);
 		return;
 	}
 
@@ -307,66 +347,7 @@ static void r4k_flush_cache_page(struct 
 	 * Do indexed flush, too much work to get the (possible) TLB refills
 	 * to work correctly.
 	 */
-	page = (KSEG0 + (page & (dcache_size - 1)));
-	r4k_blast_dcache_page_indexed(page);
-	if (exec)
-		r4k_blast_icache_page_indexed(page);
-}
-
-static void r4k_flush_cache_page_r4600(struct vm_area_struct *vma,
-	unsigned long page)
-{
-	int exec = vma->vm_flags & VM_EXEC;
-	struct mm_struct *mm = vma->vm_mm;
-	pgd_t *pgdp;
-	pmd_t *pmdp;
-	pte_t *ptep;
-
-	/*
-	 * If ownes no valid ASID yet, cannot possibly have gotten
-	 * this page into the cache.
-	 */
-	if (cpu_context(smp_processor_id(), mm) == 0)
-		return;
-
-	page &= PAGE_MASK;
-	pgdp = pgd_offset(mm, page);
-	pmdp = pmd_offset(pgdp, page);
-	ptep = pte_offset(pmdp, page);
-
-	/*
-	 * If the page isn't marked valid, the page cannot possibly be
-	 * in the cache.
-	 */
-	if (!(pte_val(*ptep) & _PAGE_PRESENT))
-		return;
-
-	/*
-	 * Doing flushes for another ASID than the current one is
-	 * too difficult since stupid R4k caches do a TLB translation
-	 * for every cache flush operation.  So we do indexed flushes
-	 * in that case, which doesn't overly flush the cache too much.
-	 */
-	if ((mm == current->active_mm) && (pte_val(*ptep) & _PAGE_VALID)) {
-		r4k_blast_dcache_page(page);
-		if (exec)
-			r4k_blast_icache_page(page);
-
-		return;
-	}
-
-	/*
-	 * Do indexed flush, too much work to get the (possible)
-	 * tlb refills to work correctly.
-	 */
-	page = KSEG0 + (page & (dcache_size - 1));
-	r4k_blast_dcache_page_indexed(page);
-	r4k_blast_dcache_page_indexed(page ^ dcache_waybit);
-
-	if (exec) {
-		r4k_blast_icache_page_indexed(page);
-		r4k_blast_icache_page_indexed(page ^ icache_waybit);
-	}
+	r4k_blast_cache_page_indexed(page, exec);
 }
 
 static void r4k_flush_dcache_page_impl(struct page *page)
@@ -791,15 +772,6 @@ void __init ld_mmu_r4xx0(void)
 	_flush_dcache_page = r4k_flush_dcache_page;
 	_flush_icache_page = r4k_flush_icache_page;
 
-	switch(mips_cpu.cputype) {
-	case CPU_R4600:			/* QED style two way caches? */
-	case CPU_R4700:
-	case CPU_R5000:
-	case CPU_NEVADA:
-		_flush_cache_page = r4k_flush_cache_page_r4600;
-	}
-
-
 	switch(read_c0_prid() & 0xfff0) {
 	case 0x2010:
 		_flush_cache_sigtramp = r4600v17_flush_cache_sigtramp;

_


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
