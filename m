Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Mar 2003 13:01:51 +0100 (BST)
Received: from p508B6D12.dip.t-dialin.net ([IPv6:::ffff:80.139.109.18]:15534
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225307AbTCaMBt>; Mon, 31 Mar 2003 13:01:49 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h2VC1g221267
	for linux-mips@linux-mips.org; Mon, 31 Mar 2003 14:01:42 +0200
Date: Mon, 31 Mar 2003 14:01:42 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-mips@linux-mips.org
Subject: Re: Cache code changes
Message-ID: <20030331140142.A20843@linux-mips.org>
References: <20030320111625.A13219@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030320111625.A13219@linux-mips.org>; from ralf@linux-mips.org on Thu, Mar 20, 2003 at 11:16:25AM +0100
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1868
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

So below a fix for the 32-bit 2.4 kernel to resolve the remaining cache
problems.  I tried another much more complex fix but it turned out to be
not implementable with the memory managment infrastructure provided by
Linux 2.4.

This patch also begins to exploit some of the optimizations enabled by the
new flush_dcache_page interface.  As the result this is the fastest 2.4
kernel so far.  The benefits are entirely for virtually indexed data
caches; the smaller the caches, the higher the gain.

  Ralf

diff -u -r1.22.2.5 syscall.c
--- arch/mips/kernel/syscall.c 13 Mar 2003 14:29:14 -0000
+++ arch/mips/kernel/syscall.c 31 Mar 2003 11:36:02 -0000
@@ -55,10 +55,11 @@
 	return res;
 }
 
-#define MMAP_SHARED_ALIGN 0x8000
-#define COLOUR_ALIGN(addr, pgoff)					\
-	((((addr)+ MMAP_SHARED_ALIGN - 1)&~(MMAP_SHARED_ALIGN - 1)) +	\
-	 (((pgoff) << PAGE_SHIFT) & (MMAP_SHARED_ALIGN - 1)))
+unsigned long shm_align_mask = PAGE_SIZE - 1;	/* Sane caches */
+
+#define COLOUR_ALIGN(addr,pgoff)				\
+	((((addr) + shm_align_mask) & ~shm_align_mask) +	\
+	 (((pgoff) << PAGE_SHIFT) & shm_align_mask))
 
 unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	unsigned long len, unsigned long pgoff, unsigned long flags)
@@ -71,7 +72,7 @@
 		 * We do not accept a shared mapping if it would violate
 		 * cache aliasing constraints.
 		 */
-		if ((flags & MAP_SHARED) && (addr & (MMAP_SHARED_ALIGN - 1)))
+		if ((flags & MAP_SHARED) && (addr & shm_align_mask))
 			return -EINVAL;
 		return addr;
 	}
diff -u -r1.27.2.11 Makefile
--- arch/mips/mm/Makefile 29 Mar 2003 04:02:49 -0000
+++ arch/mips/mm/Makefile 31 Mar 2003 11:36:02 -0000
@@ -11,7 +11,8 @@
 O_TARGET := mm.o
 
 export-objs			+= ioremap.o loadmmu.o remap.o
-obj-y				+= extable.o init.o ioremap.o fault.o loadmmu.o
+obj-y				+= cache.o extable.o init.o ioremap.o fault.o \
+				   loadmmu.o
 
 obj-$(CONFIG_CPU_R3000)		+= pg-r3k.o c-r3k.o tlb-r3k.o tlbex-r3k.o
 obj-$(CONFIG_CPU_TX39XX)	+= pg-r3k.o c-tx39.o tlb-r3k.o tlbex-r3k.o
diff -u -r1.3.2.16 c-mips32.c
--- arch/mips/mm/c-mips32.c 25 Mar 2003 14:30:19 -0000
+++ arch/mips/mm/c-mips32.c 31 Mar 2003 11:36:04 -0000
@@ -251,33 +251,14 @@
 	}
 }
 
-static void mips32_flush_dcache_page_impl(struct page *page)
+static void mips32_flush_data_cache_page(unsigned long addr)
 {
-	unsigned long addr = (unsigned long)page_address(page);
-
 	if (sc_lsize)
 		blast_scache_page(addr);
 	else
 		blast_dcache_page(addr);
 }
 
-static void mips32_flush_dcache_page(struct page *page)
-{
-	if (page->mapping && page->mapping->i_mmap == NULL &&
-	    page->mapping->i_mmap_shared == NULL) {
-		SetPageDcacheDirty(page);
-
-		return;
-	}
-
-	/*
-	 * We could delay the flush for the !page->mapping case too.  But that
-	 * case is for exec env/arg pages and those are %99 certainly going to
-	 * get faulted into the tlb (and thus flushed) anyways.
-	 */
-	mips32_flush_dcache_page_impl(page);
-}
-
 static void
 mips32_flush_icache_page_s(struct vm_area_struct *vma, struct page *page)
 {
@@ -419,21 +400,6 @@
 	}
 }
 
-void __update_cache(struct vm_area_struct *vma, unsigned long address,
-	pte_t pte)
-{
-	struct page *page = pte_page(pte);
-	unsigned long pg_flags;
-
-	if (VALID_PAGE(page) && page->mapping &&
-	    ((pg_flags = page->flags) & (1UL << PG_dcache_dirty))) {
-		mips32_flush_dcache_page_impl(page);
-
-		ClearPageDcacheDirty(page);
-	}
-}
-
-
 /* Detect and size the various caches. */
 static void __init probe_icache(unsigned long config)
 {
@@ -695,9 +661,17 @@
 	probe_dcache(config);
 	setup_scache(config);
 
+	/*
+	 * XXX Some MIPS32 processors have physically indexed caches.  This
+	 * code supports virtually indexed processors and will be unnecessarily
+	 * unefficient on physically indexed processors.
+	 */
+	shm_align_mask = max_t(unsigned long, mips_cpu.dcache.sets * dc_lsize,
+	                       PAGE_SIZE) - 1;
+
 	_flush_cache_sigtramp = mips32_flush_cache_sigtramp;
-	_flush_dcache_page = mips32_flush_dcache_page;
 	_flush_icache_range = mips32_flush_icache_range;	/* Ouch */
+	_flush_data_cache_page = mips32_flush_data_cache_page;
 	_flush_icache_all = mips32_flush_icache_all;
 
 	__flush_cache_all();
diff -u -r1.4.2.6 c-r3k.c
--- arch/mips/mm/c-r3k.c 25 Mar 2003 03:26:20 -0000
+++ arch/mips/mm/c-r3k.c 31 Mar 2003 11:36:04 -0000
@@ -258,7 +258,7 @@
 {
 }
 
-static void r3k_flush_dcache_page(struct page * page)
+static void r3k_flush_data_cache_page(unsigned long addr)
 {
 }
 
@@ -314,11 +314,6 @@
 	r3k_flush_dcache_range(start, start + size);
 }
 
-void __update_cache(struct vm_area_struct *vma, unsigned long address,
-	pte_t pte)
-{
-}
-
 void __init ld_mmu_r23000(void)
 {
 	unsigned long config;
@@ -333,16 +328,16 @@
 	_flush_cache_mm = r3k_flush_cache_mm;
 	_flush_cache_range = r3k_flush_cache_range;
 	_flush_cache_page = r3k_flush_cache_page;
-	_flush_cache_sigtramp = r3k_flush_cache_sigtramp;
-	_flush_dcache_page = r3k_flush_dcache_page;
 	_flush_icache_page = r3k_flush_icache_page;
 	_flush_icache_range = r3k_flush_icache_range;
 
+	_flush_cache_sigtramp = r3k_flush_cache_sigtramp;
+	_flush_data_cache_page = r3k_flush_data_cache_page;
+
 	_dma_cache_wback_inv = r3k_dma_cache_wback_inv;
 
 	printk("Primary instruction cache %dkb, linesize %d bytes\n",
 		(int) (icache_size >> 10), (int) icache_lsize);
 	printk("Primary data cache %dkb, linesize %d bytes\n",
 		(int) (dcache_size >> 10), (int) dcache_lsize);
-
 }
diff -u -r1.3.2.23 c-r4k.c
--- arch/mips/mm/c-r4k.c 29 Mar 2003 00:48:52 -0000
+++ arch/mips/mm/c-r4k.c 31 Mar 2003 11:36:04 -0000
@@ -390,30 +390,11 @@
 	}
 }
 
-static void r4k_flush_dcache_page_impl(struct page *page)
+static void r4k_flush_data_cache_page(unsigned long addr)
 {
-	unsigned long addr = (unsigned long) page_address(page);
-
 	r4k_blast_dcache_page(addr);
 }
 
-static void r4k_flush_dcache_page(struct page *page)
-{
-	if (page->mapping && page->mapping->i_mmap == NULL &&
-	    page->mapping->i_mmap_shared == NULL) {
-		SetPageDcacheDirty(page);
-
-		return;
-	}
-
-	/*
-	 * We could delay the flush for the !page->mapping case too.  But that
-	 * case is for exec env/arg pages and those are %99 certainly going to
-	 * get faulted into the tlb (and thus flushed) anyways.
-	 */
-	r4k_flush_dcache_page_impl(page);
-}
-
 static void r4k_flush_icache_range(unsigned long start, unsigned long end)
 {
 	r4k_flush_pcache_all();
@@ -578,20 +559,6 @@
 #endif
 }
 
-void __update_cache(struct vm_area_struct *vma, unsigned long address,
-	pte_t pte)
-{
-	struct page *page = pte_page(pte);
-	unsigned long pg_flags;
-
-	if (VALID_PAGE(page) && page->mapping &&
-	    ((pg_flags = page->flags) & (1UL << PG_dcache_dirty))) {
-		r4k_flush_dcache_page_impl(page);
-
-		ClearPageDcacheDirty(page);
-	}
-}
-
 static void __init probe_icache(unsigned long config)
 {
 	switch (mips_cpu.cputype) {
@@ -804,6 +771,7 @@
 {
 	unsigned long config = read_c0_config();
 	extern char except_vec2_generic;
+	unsigned int sets;
 
 	/* Default cache error handler for R4000 family */
 
@@ -822,13 +790,22 @@
 	case CPU_R5000:
 	case CPU_NEVADA:
 		_flush_cache_page = r4k_flush_cache_page_r4600;
+		sets = 1;
+		break;
+
+	default:
+		sets = 0;
+		break;
 	}
 
-	_flush_dcache_page = r4k_flush_dcache_page;
+	shm_align_mask = max_t(unsigned long,
+	                       (dcache_size >> sets) - 1, PAGE_SIZE - 1);
+
 	_flush_cache_sigtramp = r4k_flush_cache_sigtramp;
 	if ((read_c0_prid() & 0xfff0) == 0x2020) {
 		_flush_cache_sigtramp = r4600v20k_flush_cache_sigtramp;
 	}
+	_flush_data_cache_page = r4k_flush_data_cache_page;
 	_flush_icache_range = r4k_flush_icache_range;	/* Ouch */
 
 	__flush_cache_all();
diff -u -r1.4.2.8 c-r5432.c
--- arch/mips/mm/c-r5432.c 25 Mar 2003 01:11:34 -0000
+++ arch/mips/mm/c-r5432.c 31 Mar 2003 11:36:05 -0000
@@ -332,28 +332,11 @@
 	}
 }
 
-static void r5432_flush_dcache_page_impl(struct page *page)
+static void r5432_flush_data_cache_page(unsigned long addr)
 {
 	blast_dcache32_page((unsigned long)page_address(page));
 }
 
-static void r5432_flush_dcache_page(struct page *page)
-{
-	if (page->mapping && page->mapping->i_mmap == NULL &&
-	    page->mapping->i_mmap_shared == NULL) {
-		SetPageDcacheDirty(page);
-
-		return;
-	}
-
-	/*
-	 * We could delay the flush for the !page->mapping case too.  But that
-	 * case is for exec env/arg pages and those are %99 certainly going to
-	 * get faulted into the tlb (and thus flushed) anyways.
-	 */
-	r5432_flush_dcache_page_impl(page);
-}
-
 static void
 r5432_flush_icache_range(unsigned long start, unsigned long end)
 {
@@ -433,20 +416,6 @@
 	protected_flush_icache_line(addr & ~(ic_lsize - 1));
 }
 
-void __update_cache(struct vm_area_struct *vma, unsigned long address,
-	pte_t pte)
-{
-	struct page *page = pte_page(pte);
-	unsigned long pg_flags;
-
-	if (VALID_PAGE(page) && page->mapping &&
-	    ((pg_flags = page->flags) & (1UL << PG_dcache_dirty))) {
-		r5432_flush_dcache_page_impl(page);
-
-		ClearPageDcacheDirty(page);
-	}
-}
-
 /* Detect and size the various r4k caches. */
 static void __init probe_icache(unsigned long config)
 {
@@ -480,21 +449,27 @@
 	probe_icache(config);
 	probe_dcache(config);
 
+	shm_align_mask = max_t(unsigned long,
+	                       (dcache_size >> 1) - 1, PAGE_SIZE - 1);
+
 	_clear_page = r5432_clear_page_d32;
 	_copy_page = r5432_copy_page_d32;
+
 	_flush_cache_all = r5432_flush_cache_all_d32i32;
 	___flush_cache_all = r5432_flush_cache_all_d32i32;
 	_flush_cache_mm = r5432_flush_cache_mm_d32i32;
 	_flush_cache_range = r5432_flush_cache_range_d32i32;
 	_flush_cache_page = r5432_flush_cache_page_d32i32;
-	_flush_dcache_page = r5432_flush_dcache_page;
+	_flush_icache_range = r5432_flush_icache_range;	/* Ouch */
 	_flush_icache_page = r5432_flush_icache_page_i32;
+
+
+	_flush_cache_sigtramp = r5432_flush_cache_sigtramp;
+	_flush_data_cache_page = r5432_flush_data_cache_page;
+
 	_dma_cache_wback_inv = r5432_dma_cache_wback_inv_pc;
 	_dma_cache_wback = r5432_dma_cache_wback;
 	_dma_cache_inv = r5432_dma_cache_inv_pc;
-
-	_flush_cache_sigtramp = r5432_flush_cache_sigtramp;
-	_flush_icache_range = r5432_flush_icache_range;	/* Ouch */
 
 	__flush_cache_all();
 }
diff -u -r1.4.2.9 c-rm7k.c
--- arch/mips/mm/c-rm7k.c 24 Mar 2003 23:49:27 -0000
+++ arch/mips/mm/c-rm7k.c 31 Mar 2003 11:36:05 -0000
@@ -90,7 +90,7 @@
 {
 }
 
-static void rm7k_flush_dcache_page(struct page * page)
+static void rm7k_flush_data_cache_page(unsigned long addr)
 {
 }
 
@@ -187,11 +187,6 @@
 	protected_flush_icache_line(addr & ~(ic_lsize - 1));
 }
 
-void __update_cache(struct vm_area_struct *vma, unsigned long address,
-	pte_t pte)
-{
-}
-
 /* Detect and size the caches. */
 static inline void probe_icache(unsigned long config)
 {
@@ -336,10 +331,13 @@
 	_flush_cache_mm = rm7k_flush_cache_mm_d32i32;
 	_flush_cache_range = rm7k_flush_cache_range_d32i32;
 	_flush_cache_page = rm7k_flush_cache_page_d32i32;
-	_flush_dcache_page = rm7k_flush_dcache_page;
-	_flush_cache_sigtramp = rm7k_flush_cache_sigtramp;
 	_flush_icache_range = rm7k_flush_icache_range;
 	_flush_icache_page = rm7k_flush_icache_page;
+
+	_flush_cache_sigtramp = rm7k_flush_cache_sigtramp;
+	_flush_data_cache_page = rm7k_flush_data_cache_page;
+
+	shm_align_mask = PAGE_SIZE - 1;
 
 	_dma_cache_wback_inv = rm7k_dma_cache_wback_inv;
 	_dma_cache_wback = rm7k_dma_cache_wback;
diff -u -r1.11.2.22 c-sb1.c
--- arch/mips/mm/c-sb1.c 12 Mar 2003 16:39:54 -0000
+++ arch/mips/mm/c-sb1.c 31 Mar 2003 11:36:07 -0000
@@ -420,11 +420,6 @@
 {
 }
 
-void __update_cache(struct vm_area_struct *vma, unsigned long address,
-	pte_t pte)
-{
-}
-
 /*
  *  Cache set values (from the mips64 spec)
  * 0 - 64
@@ -534,13 +529,14 @@
 	_flush_cache_page = (void (*)(struct vm_area_struct *, unsigned long))sb1_nop;
 	_flush_cache_mm = (void (*)(struct mm_struct *))sb1_nop;
 	_flush_cache_all = sb1_nop;
-	_flush_dcache_page = (void *) sb1_nop;
 
 	/* These routines are for Icache coherence with the Dcache */
 	_flush_icache_range = sb1_flush_icache_range;
 	_flush_icache_page = sb1_flush_icache_page;
 	_flush_icache_all = __sb1_flush_icache_all; /* local only */
+
 	_flush_cache_sigtramp = sb1_flush_cache_sigtramp;
+	_flush_data_cache_page = (void *) sb1_nop;
 
 	/* Full flush */
 	___flush_cache_all = sb1___flush_cache_all;
diff -u -r1.4.2.9 c-tx39.c
--- arch/mips/mm/c-tx39.c 25 Mar 2003 14:30:19 -0000
+++ arch/mips/mm/c-tx39.c 31 Mar 2003 11:36:07 -0000
@@ -34,7 +34,7 @@
 
 extern int r3k_have_wired_reg;	/* in r3k-tlb.c */
 
-static void tx39h_flush_dcache_page(struct page * page)
+static void tx39h_flush_data_cache_page(unsigned long addr)
 {
 }
 
@@ -204,30 +204,11 @@
 		tx39_blast_icache_page_indexed(page);
 }
 
-static void tx39_flush_dcache_page_impl(struct page *page)
+static void tx39_flush_data_cache_page(unsigned long addr)
 {
-	unsigned long addr = (unsigned long) page_address(page);
-
 	tx39_blast_dcache_page(addr);
 }
 
-static void tx39_flush_dcache_page(struct page *page)
-{
-	if (page->mapping && page->mapping->i_mmap == NULL &&
-	    page->mapping->i_mmap_shared == NULL) {
-	        SetPageDcacheDirty(page);
-
-		return;
-	}
-
-	/*
-	 * We could delay the flush for the !page->mapping case too.  But that
-	 * case is for exec env/arg pages and those are %99 certainly going to
-	 * get faulted into the tlb (and thus flushed) anyways.
-	 */
-	tx39_flush_dcache_page_impl(page);
-}
-
 static void tx39_flush_icache_range(unsigned long start, unsigned long end)
 {
 	flush_cache_all();
@@ -319,20 +300,6 @@
 	local_irq_restore(flags);
 }
 
-void __update_cache(struct vm_area_struct *vma, unsigned long address,
-	pte_t pte)
-{
-	struct page *page = pte_page(pte);
-	unsigned long pg_flags;
-
-	if (VALID_PAGE(page) && page->mapping &&
-	    ((pg_flags = page->flags) & (1UL << PG_dcache_dirty))) {
-		tx39_flush_dcache_page_impl(page);
-
-		ClearPageDcacheDirty(page);
-	}
-}
-
 /* currently clear_user_page/copy_user_page needs this... */
 void __flush_dcache_all(void)
 {
@@ -384,12 +351,16 @@
 		_flush_cache_mm		= (void *) tx39h_flush_icache_all;
 		_flush_cache_range	= (void *) tx39h_flush_icache_all;
 		_flush_cache_page	= (void *) tx39h_flush_icache_all;
-		_flush_cache_sigtramp	= (void *) tx39h_flush_icache_all;
-		_flush_dcache_page	= tx39h_flush_dcache_page;
 		_flush_icache_page	= (void *) tx39h_flush_icache_all;
 		_flush_icache_range	= (void *) tx39h_flush_icache_all;
 
-		_dma_cache_wback_inv = tx39h_dma_cache_wback_inv;
+		_flush_cache_sigtramp	= (void *) tx39h_flush_icache_all;
+		_flush_data_cache_page	= (void *) tx39h_flush_icache_all;
+
+		_dma_cache_wback_inv	= tx39h_dma_cache_wback_inv;
+
+		shm_align_mask		= PAGE_SIZE - 1;
+
 		break;
 
 	case CPU_TX3922:
@@ -405,14 +376,19 @@
 		_flush_cache_mm = tx39_flush_cache_mm;
 		_flush_cache_range = tx39_flush_cache_range;
 		_flush_cache_page = tx39_flush_cache_page;
-		_flush_cache_sigtramp = tx39_flush_cache_sigtramp;
-		_flush_dcache_page = tx39_flush_dcache_page;
 		_flush_icache_page = tx39_flush_icache_page;
 		_flush_icache_range = tx39_flush_icache_range;
 
+		_flush_cache_sigtramp = tx39_flush_cache_sigtramp;
+		_flush_data_cache_page = tx39_flush_data_cache_page;
+
 		_dma_cache_wback_inv = tx39_dma_cache_wback_inv;
 		_dma_cache_wback = tx39_dma_cache_wback;
 		_dma_cache_inv = tx39_dma_cache_inv;
+
+		shm_align_mask = max_t(unsigned long,
+		                       (dcache_size / mips_cpu.dcache.ways) - 1,
+		                       PAGE_SIZE - 1);
 
 		break;
 	}
diff -u -r1.3.2.11 c-tx49.c
--- arch/mips/mm/c-tx49.c 25 Mar 2003 01:11:34 -0000
+++ arch/mips/mm/c-tx49.c 31 Mar 2003 11:36:07 -0000
@@ -174,30 +174,11 @@
 		tx49_blast_icache_page_indexed(page);
 }
 
-static void tx49_flush_dcache_page_impl(struct page *page)
+static void tx49_flush_data_cache_page(unsigned long addr)
 {
-	unsigned long addr = (unsigned long) page_address(page);
-
 	tx49_blast_dcache_page(addr);
 }
 
-static void tx49_flush_dcache_page(struct page *page)
-{
-	if (page->mapping && page->mapping->i_mmap == NULL &&
-	    page->mapping->i_mmap_shared == NULL) {
-		SetPageDcacheDirty(page);
-
-		return;
-	}
-
-	/*
-	 * We could delay the flush for the !page->mapping case too.  But that
-	 * case is for exec env/arg pages and those are %99 certainly going to
-	 * get faulted into the tlb (and thus flushed) anyways.
-	 */
-	tx49_flush_dcache_page_impl(page);
-}
-
 static void
 tx49_flush_icache_range(unsigned long start, unsigned long end)
 {
@@ -280,20 +261,6 @@
 	protected_flush_icache_line(addr & ~(ic_lsize - 1));
 }
 
-void __update_cache(struct vm_area_struct *vma, unsigned long address,
-	pte_t pte)
-{
-	struct page *page = pte_page(pte);
-	unsigned long pg_flags;
-
-	if (VALID_PAGE(page) && page->mapping &&
-	    ((pg_flags = page->flags) & (1UL << PG_dcache_dirty))) {
-		tx49_flush_dcache_page_impl(page);
-
-		ClearPageDcacheDirty(page);
-	}
-}
-
 /* currently clear_user_page/copy_user_page needs this... */
 void __flush_dcache_all(void)
 {
@@ -305,6 +272,8 @@
 {
 	icache_size = 1 << (12 + ((config >> 9) & 7));
 	ic_lsize = 16 << ((config >> 5) & 1);
+	mips_cpu.icache.ways = 1;
+	mips_cpu.icache.sets = icache_size / mips_cpu.icache.linesz;
 
 	printk("Primary instruction cache %dkb, linesize %d bytes.\n",
 	       icache_size >> 10, ic_lsize);
@@ -314,6 +283,8 @@
 {
 	dcache_size = 1 << (12 + ((config >> 6) & 7));
 	dc_lsize = 16 << ((config >> 4) & 1);
+	mips_cpu.dcache.ways = 1;
+	mips_cpu.dcache.sets = dcache_size / mips_cpu.dcache.linesz;
 
 	printk("Primary data cache %dkb, linesize %d bytes.\n",
 	       dcache_size >> 10, dc_lsize);
@@ -337,14 +308,6 @@
 
 	probe_icache(config);
 	probe_dcache(config);
-	if (mips_cpu.icache.ways == 0)
-		mips_cpu.icache.ways = 1;
-	if (mips_cpu.dcache.ways == 0)
-		mips_cpu.dcache.ways = 1;
-	mips_cpu.icache.sets =
-		icache_size / mips_cpu.icache.ways / mips_cpu.icache.linesz;
-	mips_cpu.dcache.sets =
-		dcache_size / mips_cpu.dcache.ways / mips_cpu.dcache.linesz;
 
 	switch (dc_lsize) {
 	case 16:
@@ -361,15 +324,15 @@
 	_flush_cache_mm = tx49_flush_cache_mm;
 	_flush_cache_range = tx49_flush_cache_range;
 	_flush_cache_page = tx49_flush_cache_page;
+	_flush_icache_range = tx49_flush_icache_range;	/* Ouch */
 	_flush_icache_page = tx49_flush_icache_page;
-	_flush_dcache_page = tx49_flush_dcache_page;
+
+	_flush_cache_sigtramp = tx49_flush_cache_sigtramp;
+	_flush_data_cache_page = tx49_flush_data_cache_page;
 
 	_dma_cache_wback_inv = tx49_dma_cache_wback_inv;
 	_dma_cache_wback = tx49_dma_cache_wback;
 	_dma_cache_inv = tx49_dma_cache_inv;
-
-	_flush_cache_sigtramp = tx49_flush_cache_sigtramp;
-	_flush_icache_range = tx49_flush_icache_range;	/* Ouch */
 
 	__flush_cache_all();
 }
diff -N arch/mips/mm/cache.c
--- arch/mips/mm/cache.c 1 Jan 1970 00:00:00 -0000
+++ arch/mips/mm/cache.c 31 Mar 2003 11:36:07 -0000
@@ -0,0 +1,57 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1994 - 2003 by Ralf Baechle
+ */
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+
+#include <asm/cacheflush.h>
+
+asmlinkage int sys_cacheflush(void *addr, int bytes, int cache)
+{
+	/* This should flush more selectivly ...  */
+	__flush_cache_all();
+
+	return 0;
+}
+
+void flush_dcache_page(struct page *page)
+{
+	unsigned long addr;
+
+	if (page->mapping && page->mapping->i_mmap == NULL &&
+	    page->mapping->i_mmap_shared == NULL) {
+		SetPageDcacheDirty(page);
+
+		return;
+	}
+
+	/*
+	 * We could delay the flush for the !page->mapping case too.  But that
+	 * case is for exec env/arg pages and those are %99 certainly going to
+	 * get faulted into the tlb (and thus flushed) anyways.
+	 */
+	addr = (unsigned long) page_address(page);
+	flush_data_cache_page(addr);
+}
+
+void __update_cache(struct vm_area_struct *vma, unsigned long address,
+        pte_t pte)
+{
+	struct page *page = pte_page(pte);
+	unsigned long addr;
+
+	if (VALID_PAGE(page) && page->mapping &&
+	    (page->flags & (1UL << PG_dcache_dirty))) {
+		if (pages_do_alias(page_address(page), address & PAGE_MASK)) {
+			addr = (unsigned long) page_address(page);
+			flush_data_cache_page(addr);
+		}
+
+		ClearPageDcacheDirty(page);
+	}
+}
diff -u -r1.38.2.7 init.c
--- arch/mips/mm/init.c 5 Aug 2002 23:53:35 -0000
+++ arch/mips/mm/init.c 31 Mar 2003 11:36:10 -0000
@@ -45,15 +45,6 @@
 
 extern void prom_free_prom_memory(void);
 
-
-asmlinkage int sys_cacheflush(void *addr, int bytes, int cache)
-{
-	/* This should flush more selectivly ...  */
-	__flush_cache_all();
-
-	return 0;
-}
-
 /*
  * We have upto 8 empty zeroed pages so we can map one of the right colour
  * when needed.  This is necessary only on R4000 / R4400 SC and MC versions
@@ -67,7 +58,8 @@
 {
 	unsigned long order, size;
 	struct page *page;
-	if(mips_cpu.options & MIPS_CPU_VCE)
+
+	if (mips_cpu.options & MIPS_CPU_VCE)
 		order = 3;
 	else
 		order = 0;
diff -u -r1.45.2.2 loadmmu.c
--- arch/mips/mm/loadmmu.c 12 Mar 2003 15:06:35 -0000
+++ arch/mips/mm/loadmmu.c 31 Mar 2003 11:36:10 -0000
@@ -29,11 +29,11 @@
 void (*_flush_cache_range)(struct mm_struct *mm, unsigned long start,
 			  unsigned long end);
 void (*_flush_cache_page)(struct vm_area_struct *vma, unsigned long page);
-void (*_flush_cache_sigtramp)(unsigned long addr);
 void (*_flush_icache_range)(unsigned long start, unsigned long end);
 void (*_flush_icache_page)(struct vm_area_struct *vma, struct page *page);
 
-void (*_flush_dcache_page)(struct page * page);
+void (*_flush_cache_sigtramp)(unsigned long addr);
+void (*_flush_data_cache_page)(unsigned long addr);
 void (*_flush_icache_all)(void);
 
 #ifdef CONFIG_NONCOHERENT_IO
diff -N include/asm-mips/cacheflush.h
--- include/asm-mips/cacheflush.h 1 Jan 1970 00:00:00 -0000
+++ include/asm-mips/cacheflush.h 31 Mar 2003 11:36:30 -0000
@@ -0,0 +1,69 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1994, 95, 96, 97, 98, 99, 2000 by Ralf Baechle at alii
+ * Copyright (C) 1999 Silicon Graphics, Inc.
+ */
+#ifndef __ASM_CACHEFLUSH_H
+#define __ASM_CACHEFLUSH_H
+
+#include <linux/config.h>
+
+struct mm_struct;
+struct vm_area_struct;
+struct page;
+
+/* Cache flushing:
+ *
+ *  - flush_cache_all() flushes entire cache
+ *  - flush_cache_mm(mm) flushes the specified mm context's cache lines
+ *  - flush_cache_page(mm, vmaddr) flushes a single page
+ *  - flush_cache_range(mm, start, end) flushes a range of pages
+ *  - flush_page_to_ram(page) write back kernel page to ram
+ *  - flush_icache_range(start, end) flush a range of instructions
+ *
+ * MIPS specific flush operations:
+ *
+ *  - flush_cache_sigtramp() flush signal trampoline
+ *  - flush_icache_all() flush the entire instruction cache
+ *  - flush_data_cache_page() flushes a page from the data cache
+ */
+extern void (*_flush_cache_all)(void);
+extern void (*___flush_cache_all)(void);
+extern void (*_flush_cache_mm)(struct mm_struct *mm);
+extern void (*_flush_cache_range)(struct mm_struct *mm, unsigned long start,
+	unsigned long end);
+extern void (*_flush_cache_page)(struct vm_area_struct *vma,
+	unsigned long page);
+extern void flush_dcache_page(struct page * page);
+extern void (*_flush_icache_range)(unsigned long start, unsigned long end);
+extern void (*_flush_icache_page)(struct vm_area_struct *vma,
+	struct page *page);
+
+extern void (*_flush_cache_sigtramp)(unsigned long addr);
+extern void (*_flush_icache_all)(void);
+extern void (*_flush_data_cache_page)(unsigned long addr);
+
+#define flush_cache_all()		_flush_cache_all()
+#define __flush_cache_all()		___flush_cache_all()
+#define flush_cache_mm(mm)		_flush_cache_mm(mm)
+#define flush_cache_range(mm,start,end)	_flush_cache_range(mm,start,end)
+#define flush_cache_page(vma,page)	_flush_cache_page(vma, page)
+#define flush_page_to_ram(page)		do { } while (0)
+
+#define flush_icache_range(start, end)	_flush_icache_range(start,end)
+#define flush_icache_user_range(vma, page, addr, len) \
+					_flush_icache_page((vma), (page))
+#define flush_icache_page(vma, page) 	_flush_icache_page(vma, page)
+
+#define flush_cache_sigtramp(addr)	_flush_cache_sigtramp(addr)
+#define flush_data_cache_page(addr)	_flush_data_cache_page(addr)
+#ifdef CONFIG_VTAG_ICACHE
+#define flush_icache_all()		_flush_icache_all()
+#else
+#define flush_icache_all()		do { } while(0)
+#endif
+
+#endif /* __ASM_CACHEFLUSH_H */
diff -u -r1.14.2.12 page.h
--- include/asm-mips/page.h 28 Mar 2003 19:29:53 -0000
+++ include/asm-mips/page.h 31 Mar 2003 11:36:30 -0000
@@ -10,8 +10,6 @@
 #ifndef __ASM_PAGE_H
 #define __ASM_PAGE_H
 
-#include <linux/config.h>
-
 /* PAGE_SHIFT determines the page size */
 #define PAGE_SHIFT	12
 #define PAGE_SIZE	(1L << PAGE_SHIFT)
@@ -21,6 +19,10 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/config.h>
+
+#include <asm/cacheflush.h>
+
 #define BUG() do { printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); *(int *)0=0; } while (0)
 #define PAGE_BUG(page) do {  BUG(); } while (0)
 
@@ -64,8 +66,32 @@
 
 #define clear_page(page)	_clear_page(page)
 #define copy_page(to, from)	_copy_page(to, from)
-#define clear_user_page(page, vaddr)	clear_page(page)
-#define copy_user_page(to, from, vaddr)	copy_page(to, from)
+
+extern unsigned long shm_align_mask;
+
+static inline unsigned long pages_do_alias(unsigned long addr1,
+	unsigned long addr2)
+{
+	return (addr1 ^ addr2) & shm_align_mask;
+}
+
+static inline void clear_user_page(void *page, unsigned long vaddr)
+{
+	unsigned long kaddr = (unsigned long) page;
+
+	clear_page(page);
+	if (pages_do_alias(kaddr, vaddr))
+		flush_data_cache_page(kaddr);
+}
+
+static inline void copy_user_page(void * to, void * from, unsigned long vaddr)
+{
+	unsigned long kto = (unsigned long) to;
+
+	copy_page(to, from);
+	if (pages_do_alias(kto, vaddr))
+		flush_data_cache_page(kto);
+}
 
 /*
  * These are used to make use of C type-checking..
diff -u -r1.63.2.17 pgtable.h
--- include/asm-mips/pgtable.h 28 Mar 2003 19:29:53 -0000
+++ include/asm-mips/pgtable.h 31 Mar 2003 11:36:31 -0000
@@ -17,55 +17,9 @@
 
 #include <linux/linkage.h>
 #include <asm/cachectl.h>
+#include <asm/cacheflush.h>
 #include <asm/fixmap.h>
 #include <asm/types.h>
-
-/* Cache flushing:
- *
- *  - flush_cache_all() flushes entire cache
- *  - flush_cache_mm(mm) flushes the specified mm context's cache lines
- *  - flush_cache_page(mm, vmaddr) flushes a single page
- *  - flush_cache_range(mm, start, end) flushes a range of pages
- *  - flush_page_to_ram(page) write back kernel page to ram
- *  - flush_icache_range(start, end) flush a range of instructions
- *
- *  - flush_cache_sigtramp() flush signal trampoline
- *  - flush_icache_all() flush the entire instruction cache
- */
-extern void (*_flush_cache_all)(void);
-extern void (*___flush_cache_all)(void);
-extern void (*_flush_cache_mm)(struct mm_struct *mm);
-extern void (*_flush_cache_range)(struct mm_struct *mm, unsigned long start,
-	unsigned long end);
-extern void (*_flush_cache_page)(struct vm_area_struct *vma,
-	unsigned long page);
-extern void (*_flush_dcache_page)(struct page * page);
-extern void (*_flush_icache_range)(unsigned long start, unsigned long end);
-extern void (*_flush_icache_page)(struct vm_area_struct *vma,
-	struct page *page);
-extern void (*_flush_cache_sigtramp)(unsigned long addr);
-extern void (*_flush_icache_all)(void);
-
-#define flush_dcache_page(page)		_flush_dcache_page(page)
-
-#define flush_cache_all()		_flush_cache_all()
-#define __flush_cache_all()		___flush_cache_all()
-#define flush_cache_mm(mm)		_flush_cache_mm(mm)
-#define flush_cache_range(mm,start,end)	_flush_cache_range(mm,start,end)
-#define flush_cache_page(vma,page)	_flush_cache_page(vma, page)
-#define flush_page_to_ram(page)		do { } while (0)
-
-#define flush_icache_range(start, end)	_flush_icache_range(start,end)
-#define flush_icache_user_range(vma, page, addr, len) \
-					_flush_icache_page((vma), (page))
-#define flush_icache_page(vma, page) 	_flush_icache_page(vma, page)
-
-#define flush_cache_sigtramp(addr)	_flush_cache_sigtramp(addr)
-#ifdef CONFIG_VTAG_ICACHE
-#define flush_icache_all()		_flush_icache_all()
-#else
-#define flush_icache_all()		do { } while(0)
-#endif
 
 /*
  * This flag is used to indicate that the page pointed to by a pte
