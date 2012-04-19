Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Apr 2012 22:38:59 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:50870 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903709Ab2DSUip (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Apr 2012 22:38:45 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SKy7i-0005jK-MI; Thu, 19 Apr 2012 15:38:38 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>,
        Leonid Yegoshin <yegoshin@mips.com>
Subject: [PATCH v2] MIPS HIGHMEM fixes for cache aliasing and non-DMA I/O.
Date:   Thu, 19 Apr 2012 15:38:29 -0500
Message-Id: <1334867909-12911-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.6
X-archive-position: 32979
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

This patch fixes MIPS HIGHMEM for cache aliasing and non-DMA device
I/O. It does the following:

1.  Uses only colored page addresses while allocating by kmap*(),
    page address in HIGHMEM zone matches a kernel address by color.
    It allows easy re-allocation before flushing cache.
    It does it for kmap() and kmap_atomic().

2.  Fixes instruction cache flush by right color address via
    kmap_coherent() in case of I-cache aliasing.

3.  Flushes D-cache before page is provided for process as I-page.
    It is required for swapped-in pages in case of non-DMA I/O.

4.  Some optimization is done... more comes.

Signed-off-by: Leonid Yegoshin <yegoshin@mips.com>
Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/Kconfig                    |    2 +
 arch/mips/include/asm/cpu-features.h |    6 +++
 arch/mips/include/asm/fixmap.h       |   14 +++++-
 arch/mips/include/asm/highmem.h      |   27 +++++++++++
 arch/mips/include/asm/page.h         |    3 +-
 arch/mips/mm/c-r4k.c                 |   49 ++++++++++++++++---
 arch/mips/mm/cache.c                 |   87 +++++++++++++++++++++++++---------
 arch/mips/mm/highmem.c               |   44 +++++++----------
 arch/mips/mm/init.c                  |   35 +++++++-------
 arch/mips/mm/sc-mips.c               |    1 +
 mm/highmem.c                         |   19 ++++++--
 11 files changed, 208 insertions(+), 79 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 3a8d277..34042a7 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -293,6 +293,7 @@ config MIPS_MALTA
 	select SYS_SUPPORTS_MULTITHREADING
 	select SYS_SUPPORTS_SMARTMIPS
 	select SYS_SUPPORTS_ZBOOT
+	select SYS_SUPPORTS_HIGHMEM
 	help
 	  This enables support for the MIPS Technologies Malta evaluation
 	  board.
@@ -2146,6 +2147,7 @@ config CPU_R4400_WORKAROUNDS
 config HIGHMEM
 	bool "High Memory Support"
 	depends on 32BIT && CPU_SUPPORTS_HIGHMEM && SYS_SUPPORTS_HIGHMEM
+	depends on ( !SMP || NR_CPUS = 1 || NR_CPUS = 2 || NR_CPUS = 3 || NR_CPUS = 4 || NR_CPUS = 5 || NR_CPUS = 6 || NR_CPUS = 7 || NR_CPUS = 8 )
 
 config CPU_SUPPORTS_HIGHMEM
 	bool
diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 3b50744..98bee29 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -104,6 +104,12 @@
 #ifndef cpu_has_vtag_icache
 #define cpu_has_vtag_icache	(cpu_data[0].icache.flags & MIPS_CACHE_VTAG)
 #endif
+#ifndef cpu_has_vtag_dcache
+#define cpu_has_vtag_dcache     (cpu_data[0].dcache.flags & MIPS_CACHE_VTAG)
+#endif
+#ifndef cpu_has_ic_aliases
+#define cpu_has_ic_aliases      (cpu_data[0].icache.flags & MIPS_CACHE_ALIASES)
+#endif
 #ifndef cpu_has_dc_aliases
 #define cpu_has_dc_aliases	(cpu_data[0].dcache.flags & MIPS_CACHE_ALIASES)
 #endif
diff --git a/arch/mips/include/asm/fixmap.h b/arch/mips/include/asm/fixmap.h
index 98bcc98..41d5787 100644
--- a/arch/mips/include/asm/fixmap.h
+++ b/arch/mips/include/asm/fixmap.h
@@ -46,7 +46,19 @@
  * fix-mapped?
  */
 enum fixed_addresses {
+
+/* must be <= 8, last_pkmap_nr_arr[] is initialized to 8 elements,
+   keep the total L1 size <= 512KB with 4 ways */
+#ifdef  CONFIG_PAGE_SIZE_64KB
+#define FIX_N_COLOURS 2
+#endif
+#ifdef  CONFIG_PAGE_SIZE_32KB
+#define FIX_N_COLOURS 4
+#endif
+#ifndef FIX_N_COLOURS
 #define FIX_N_COLOURS 8
+#endif
+
 	FIX_CMAP_BEGIN,
 #ifdef CONFIG_MIPS_MT_SMTC
 	FIX_CMAP_END = FIX_CMAP_BEGIN + (FIX_N_COLOURS * NR_CPUS * 2),
@@ -56,7 +68,7 @@ enum fixed_addresses {
 #ifdef CONFIG_HIGHMEM
 	/* reserved pte's for temporary kernel mappings */
 	FIX_KMAP_BEGIN = FIX_CMAP_END + 1,
-	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
+	FIX_KMAP_END = FIX_KMAP_BEGIN+(8*NR_CPUS*FIX_N_COLOURS)-1,
 #endif
 	__end_of_fixed_addresses
 };
diff --git a/arch/mips/include/asm/highmem.h b/arch/mips/include/asm/highmem.h
index 2d91888..c7bf3e4 100644
--- a/arch/mips/include/asm/highmem.h
+++ b/arch/mips/include/asm/highmem.h
@@ -37,11 +37,38 @@ extern pte_t *pkmap_page_table;
  * easily, subsequent pte tables have to be allocated in one physical
  * chunk of RAM.
  */
+
+/*  8 colors pages are here */
+#ifdef  CONFIG_PAGE_SIZE_4KB
+#define LAST_PKMAP 4096
+#endif
+#ifdef  CONFIG_PAGE_SIZE_8KB
+#define LAST_PKMAP 2048
+#endif
+#ifdef  CONFIG_PAGE_SIZE_16KB
+#define LAST_PKMAP 1024
+#endif
+
+/* 32KB and 64KB pages should have 4 and 2 colors to keep space under control */
+#ifndef LAST_PKMAP
 #define LAST_PKMAP 1024
+#endif
+
 #define LAST_PKMAP_MASK (LAST_PKMAP-1)
 #define PKMAP_NR(virt)  ((virt-PKMAP_BASE) >> PAGE_SHIFT)
 #define PKMAP_ADDR(nr)  (PKMAP_BASE + ((nr) << PAGE_SHIFT))
 
+#define ARCH_PKMAP_COLORING             1
+#define     set_pkmap_color(pg,cl)      { cl = ((unsigned long)lowmem_page_address(pg) \
+					   >> PAGE_SHIFT) & (FIX_N_COLOURS-1); }
+#define     get_last_pkmap_nr(p,cl)     (last_pkmap_nr_arr[cl])
+#define     get_next_pkmap_nr(p,cl)     (last_pkmap_nr_arr[cl] = \
+					    ((p + FIX_N_COLOURS) & LAST_PKMAP_MASK))
+#define     is_no_more_pkmaps(p,cl)     (p < FIX_N_COLOURS)
+#define     get_next_pkmap_counter(c,cl)    (c - FIX_N_COLOURS)
+extern unsigned int     last_pkmap_nr_arr[];
+
+
 extern void * kmap_high(struct page *page);
 extern void kunmap_high(struct page *page);
 
diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index 5767678..68dba89 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -85,7 +85,8 @@ static inline void clear_user_page(void *addr, unsigned long vaddr,
 	extern void (*flush_data_cache_page)(unsigned long addr);
 
 	clear_page(addr);
-	if (pages_do_alias((unsigned long) addr, vaddr & PAGE_MASK))
+	if (cpu_has_vtag_dcache || (cpu_has_dc_aliases &&
+	     pages_do_alias((unsigned long) addr, vaddr & PAGE_MASK)))
 		flush_data_cache_page((unsigned long)addr);
 }
 
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index d3adcb6..a300dee 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -399,8 +399,11 @@ static inline void local_r4k_flush_cache_range(void * args)
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
@@ -464,6 +467,7 @@ static inline void local_r4k_flush_cache_page(void *args)
 	pmd_t *pmdp;
 	pte_t *ptep;
 	void *vaddr;
+	int dontflash = 0;
 
 	/*
 	 * If ownes no valid ASID yet, cannot possibly have gotten
@@ -485,6 +489,10 @@ static inline void local_r4k_flush_cache_page(void *args)
 	if (!(pte_present(*ptep)))
 		return;
 
+	/*  accelerate it! See below, just skipping kmap_*()/kunmap_*() */
+	if ((!exec) && !cpu_has_dc_aliases)
+		return;
+
 	if ((mm == current->active_mm) && (pte_val(*ptep) & _PAGE_VALID))
 		vaddr = NULL;
 	else {
@@ -503,6 +511,8 @@ static inline void local_r4k_flush_cache_page(void *args)
 
 	if (cpu_has_dc_aliases || (exec && !cpu_has_ic_fills_f_dc)) {
 		r4k_blast_dcache_page(addr);
+		if (exec && !cpu_has_ic_fills_f_dc)
+			wmb();
 		if (exec && !cpu_icache_snoops_remote_store)
 			r4k_blast_scache_page(addr);
 	}
@@ -512,8 +522,10 @@ static inline void local_r4k_flush_cache_page(void *args)
 
 			if (cpu_context(cpu, mm) != 0)
 				drop_mmu_context(mm, cpu);
+			dontflash = 1;
 		} else
-			r4k_blast_icache_page(addr);
+			if (map_coherent || !cpu_has_ic_aliases)
+				r4k_blast_icache_page(addr);
 	}
 
 	if (vaddr) {
@@ -522,6 +534,13 @@ static inline void local_r4k_flush_cache_page(void *args)
 		else
 			kunmap_atomic(vaddr);
 	}
+
+	/*  in case of I-cache aliasing - blast it via coherent page */
+	if (exec && cpu_has_ic_aliases && (!dontflash) && !map_coherent) {
+		vaddr = kmap_coherent(page, addr);
+		r4k_blast_icache_page((unsigned long)vaddr);
+		kunmap_coherent();
+	}
 }
 
 static void r4k_flush_cache_page(struct vm_area_struct *vma,
@@ -534,6 +553,8 @@ static void r4k_flush_cache_page(struct vm_area_struct *vma,
 	args.pfn = pfn;
 
 	r4k_on_each_cpu(local_r4k_flush_cache_page, &args);
+	if (cpu_has_dc_aliases)
+		ClearPageDcacheDirty(pfn_to_page(pfn));
 }
 
 static inline void local_r4k_flush_data_cache_page(void * addr)
@@ -565,6 +586,8 @@ static inline void local_r4k_flush_icache_range(unsigned long start, unsigned lo
 		}
 	}
 
+	wmb();
+
 	if (end - start > icache_size)
 		r4k_blast_icache();
 	else
@@ -1045,7 +1068,11 @@ bypass1074:
 	case CPU_24K:
 	case CPU_34K:
 	case CPU_1004K:
-		if ((read_c0_config7() & (1 << 16))) {
+		if (!(read_c0_config7() & MIPS_CONF7_IAR)) {
+			if (c->icache.waysize > PAGE_SIZE)
+				c->icache.flags |= MIPS_CACHE_ALIASES;
+		}
+		if (read_c0_config7() & MIPS_CONF7_AR) {
 			/* effectively physically indexed dcache,
 			   thus no virtual aliases. */
 			c->dcache.flags |= MIPS_CACHE_PINDEX;
@@ -1057,6 +1084,14 @@ bypass1074:
 			c->dcache.flags |= MIPS_CACHE_ALIASES;
 	}
 
+#ifdef  CONFIG_HIGHMEM
+	if (((c->dcache.flags & MIPS_CACHE_ALIASES) &&
+	     ((c->dcache.waysize / PAGE_SIZE) > FIX_N_COLOURS)) ||
+	     ((c->icache.flags & MIPS_CACHE_ALIASES) &&
+	     ((c->icache.waysize / PAGE_SIZE) > FIX_N_COLOURS)))
+	        panic("PAGE_SIZE*WAYS too small for L1 size, too many colors");
+#endif
+
 	switch (c->cputype) {
 	case CPU_20KC:
 		/*
@@ -1079,10 +1114,12 @@ bypass1074:
 	c->icache.ways = 1;
 #endif
 
-	printk("Primary instruction cache %ldkB, %s, %s, linesize %d bytes.\n",
-	       icache_size >> 10,
+	printk("Primary instruction cache %ldkB, %s, %s, %slinesize %d bytes.\n",
+	       icache_size >> 10, way_string[c->icache.ways],
 	       c->icache.flags & MIPS_CACHE_VTAG ? "VIVT" : "VIPT",
-	       way_string[c->icache.ways], c->icache.linesz);
+	       (c->icache.flags & MIPS_CACHE_ALIASES) ?
+			"I-cache aliases, " : "",
+	       c->icache.linesz);
 
 	printk("Primary data cache %ldkB, %s, %s, %s, linesize %d bytes\n",
 	       dcache_size >> 10, way_string[c->dcache.ways],
diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 12af739..3988355 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -20,6 +20,7 @@
 #include <asm/processor.h>
 #include <asm/cpu.h>
 #include <asm/cpu-features.h>
+#include <linux/highmem.h>
 
 /* Cache operations. */
 void (*flush_cache_all)(void);
@@ -74,12 +75,9 @@ SYSCALL_DEFINE3(cacheflush, unsigned long, addr, unsigned long, bytes,
 
 void __flush_dcache_page(struct page *page)
 {
-	struct address_space *mapping = page_mapping(page);
-	unsigned long addr;
+	void *addr;
 
-	if (PageHighMem(page))
-		return;
-	if (mapping && !mapping_mapped(mapping)) {
+	if (page_mapping(page) && !page_mapped(page)) {
 		SetPageDcacheDirty(page);
 		return;
 	}
@@ -89,25 +87,55 @@ void __flush_dcache_page(struct page *page)
 	 * case is for exec env/arg pages and those are %99 certainly going to
 	 * get faulted into the tlb (and thus flushed) anyways.
 	 */
-	addr = (unsigned long) page_address(page);
-	flush_data_cache_page(addr);
+	if (PageHighMem(page)) {
+		addr = kmap_atomic(page);
+		flush_data_cache_page((unsigned long)addr);
+		kunmap_atomic(addr);
+	} else {
+		addr = (void *) page_address(page);
+		flush_data_cache_page((unsigned long)addr);
+	}
+	ClearPageDcacheDirty(page);
 }
 
 EXPORT_SYMBOL(__flush_dcache_page);
 
 void __flush_anon_page(struct page *page, unsigned long vmaddr)
 {
-	unsigned long addr = (unsigned long) page_address(page);
-
-	if (pages_do_alias(addr, vmaddr)) {
-		if (page_mapped(page) && !Page_dcache_dirty(page)) {
-			void *kaddr;
-
-			kaddr = kmap_coherent(page, vmaddr);
-			flush_data_cache_page((unsigned long)kaddr);
-			kunmap_coherent();
-		} else
-			flush_data_cache_page(addr);
+	if (!PageHighMem(page)) {
+		unsigned long addr = (unsigned long) page_address(page);
+
+		if (pages_do_alias(addr, vmaddr & PAGE_MASK)) {
+			if (page_mapped(page) && !Page_dcache_dirty(page)) {
+				void *kaddr;
+
+				kaddr = kmap_coherent(page, vmaddr);
+				flush_data_cache_page((unsigned long)kaddr);
+				kunmap_coherent();
+			} else {
+				flush_data_cache_page(addr);
+				ClearPageDcacheDirty(page);
+			}
+		}
+	} else {
+		void *laddr = lowmem_page_address(page);
+
+		if (pages_do_alias((unsigned long)laddr, vmaddr & PAGE_MASK)) {
+			if (page_mapped(page) && !Page_dcache_dirty(page)) {
+				void *kaddr;
+
+				kaddr = kmap_coherent(page, vmaddr);
+				flush_data_cache_page((unsigned long)kaddr);
+				kunmap_coherent();
+			} else {
+				void *kaddr;
+
+				kaddr = kmap_atomic(page);
+				flush_data_cache_page((unsigned long)kaddr);
+				kunmap_atomic(kaddr);
+				ClearPageDcacheDirty(page);
+			}
+		}
 	}
 }
 
@@ -121,15 +149,28 @@ void __update_cache(struct vm_area_struct *vma, unsigned long address,
 	int exec = (vma->vm_flags & VM_EXEC) && !cpu_has_ic_fills_f_dc;
 
 	pfn = pte_pfn(pte);
-	if (unlikely(!pfn_valid(pfn)))
+	if (unlikely(!pfn_valid(pfn))) {
+		wmb();
 		return;
+	}
 	page = pfn_to_page(pfn);
-	if (page_mapping(page) && Page_dcache_dirty(page)) {
-		addr = (unsigned long) page_address(page);
-		if (exec || pages_do_alias(addr, address & PAGE_MASK))
+	if (page_mapped(page) && Page_dcache_dirty(page)) {
+		void *kaddr = NULL;
+		if (PageHighMem(page)) {
+			addr = (unsigned long)kmap_atomic(page);
+			kaddr = (void *)addr;
+		} else
+			addr = (unsigned long) page_address(page);
+		if (exec || (cpu_has_dc_aliases &&
+		    pages_do_alias(addr, address & PAGE_MASK))) {
 			flush_data_cache_page(addr);
-		ClearPageDcacheDirty(page);
+			ClearPageDcacheDirty(page);
+		}
+
+		if (kaddr)
+			kunmap_atomic((void *)kaddr);
 	}
+	wmb();  /* finish any outstanding arch cache flushes before ret to user */
 }
 
 unsigned long _page_cachable_default;
diff --git a/arch/mips/mm/highmem.c b/arch/mips/mm/highmem.c
index aff5705..f5afbe5 100644
--- a/arch/mips/mm/highmem.c
+++ b/arch/mips/mm/highmem.c
@@ -8,6 +8,7 @@
 static pte_t *kmap_pte;
 
 unsigned long highstart_pfn, highend_pfn;
+unsigned int  last_pkmap_nr_arr[FIX_N_COLOURS] = { 0, 1, 2, 3, 4, 5, 6, 7 };
 
 void *kmap(struct page *page)
 {
@@ -52,8 +53,12 @@ void *kmap_atomic(struct page *page)
 		return page_address(page);
 
 	type = kmap_atomic_idx_push();
-	idx = type + KM_TYPE_NR*smp_processor_id();
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
+
+	idx = (((unsigned long)lowmem_page_address(page)) >> PAGE_SHIFT) & (FIX_N_COLOURS - 1);
+	idx = (FIX_N_COLOURS - idx);
+	idx = idx + FIX_N_COLOURS * (smp_processor_id() + NR_CPUS * type);
+	vaddr = __fix_to_virt(FIX_KMAP_BEGIN - 1 + idx);    /* actually - FIX_CMAP_END */
+
 #ifdef CONFIG_DEBUG_HIGHMEM
 	BUG_ON(!pte_none(*(kmap_pte - idx)));
 #endif
@@ -67,19 +72,22 @@ EXPORT_SYMBOL(kmap_atomic);
 void __kunmap_atomic(void *kvaddr)
 {
 	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
-	int type;
 
 	if (vaddr < FIXADDR_START) { // FIXME
 		pagefault_enable();
 		return;
 	}
 
-	type = kmap_atomic_idx();
 #ifdef CONFIG_DEBUG_HIGHMEM
 	{
-		int idx = type + KM_TYPE_NR * smp_processor_id();
+		int idx;
+		type = kmap_atomic_idx();
 
-		BUG_ON(vaddr != __fix_to_virt(FIX_KMAP_BEGIN + idx));
+		idx = ((unsigned long)kvaddr >> PAGE_SHIFT) & (FIX_N_COLOURS - 1);
+		idx = (FIX_N_COLOURS - idx);
+		idx = idx + FIX_N_COLOURS * (smp_processor_id() + NR_CPUS * type);
+
+		BUG_ON(vaddr != __fix_to_virt(FIX_KMAP_BEGIN -1 + idx));
 
 		/*
 		 * force other mappings to Oops if they'll try to access
@@ -94,26 +102,6 @@ void __kunmap_atomic(void *kvaddr)
 }
 EXPORT_SYMBOL(__kunmap_atomic);
 
-/*
- * This is the same as kmap_atomic() but can map memory that doesn't
- * have a struct page associated with it.
- */
-void *kmap_atomic_pfn(unsigned long pfn)
-{
-	unsigned long vaddr;
-	int idx, type;
-
-	pagefault_disable();
-
-	type = kmap_atomic_idx_push();
-	idx = type + KM_TYPE_NR*smp_processor_id();
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-	set_pte(kmap_pte-idx, pfn_pte(pfn, PAGE_KERNEL));
-	flush_tlb_one(vaddr);
-
-	return (void*) vaddr;
-}
-
 struct page *kmap_atomic_to_page(void *ptr)
 {
 	unsigned long idx, vaddr = (unsigned long)ptr;
@@ -123,7 +111,7 @@ struct page *kmap_atomic_to_page(void *ptr)
 		return virt_to_page(ptr);
 
 	idx = virt_to_fix(vaddr);
-	pte = kmap_pte - (idx - FIX_KMAP_BEGIN);
+	pte = kmap_pte - (idx - FIX_KMAP_BEGIN + 1);
 	return pte_page(*pte);
 }
 
@@ -132,6 +120,6 @@ void __init kmap_init(void)
 	unsigned long kmap_vstart;
 
 	/* cache the first kmap pte */
-	kmap_vstart = __fix_to_virt(FIX_KMAP_BEGIN);
+	kmap_vstart = __fix_to_virt(FIX_KMAP_BEGIN - 1); /* actually - FIX_CMAP_END */
 	kmap_pte = kmap_get_fixmap_pte(kmap_vstart);
 }
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 75f2724..39b61cb 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -127,7 +127,7 @@ void *kmap_coherent(struct page *page, unsigned long addr)
 	pte_t pte;
 	int tlbidx;
 
-	BUG_ON(Page_dcache_dirty(page));
+	/* BUG_ON(Page_dcache_dirty(page)); - removed for I-cache flush */
 
 	inc_preempt_count();
 	idx = (addr >> PAGE_SHIFT) & (FIX_N_COLOURS - 1);
@@ -218,9 +218,15 @@ void copy_user_highpage(struct page *to, struct page *from,
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
@@ -240,8 +246,14 @@ void copy_to_user_page(struct vm_area_struct *vma,
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
@@ -253,11 +265,8 @@ void copy_from_user_page(struct vm_area_struct *vma,
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
 
 void __init fixrange_init(unsigned long start, unsigned long end,
@@ -327,7 +336,7 @@ int page_is_ram(unsigned long pagenr)
 void __init paging_init(void)
 {
 	unsigned long max_zone_pfns[MAX_NR_ZONES];
-	unsigned long lastpfn __maybe_unused;
+	unsigned long lastpfn;
 
 	pagetable_init();
 
@@ -347,14 +356,6 @@ void __init paging_init(void)
 #ifdef CONFIG_HIGHMEM
 	max_zone_pfns[ZONE_HIGHMEM] = highend_pfn;
 	lastpfn = highend_pfn;
-
-	if (cpu_has_dc_aliases && max_low_pfn != highend_pfn) {
-		printk(KERN_WARNING "This processor doesn't support highmem."
-		       " %ldk highmem ignored\n",
-		       (highend_pfn - max_low_pfn) << (PAGE_SHIFT - 10));
-		max_zone_pfns[ZONE_HIGHMEM] = max_low_pfn;
-		lastpfn = max_low_pfn;
-	}
 #endif
 
 	free_area_init_nodes(max_zone_pfns);
diff --git a/arch/mips/mm/sc-mips.c b/arch/mips/mm/sc-mips.c
index 93d937b..c1347fe 100644
--- a/arch/mips/mm/sc-mips.c
+++ b/arch/mips/mm/sc-mips.c
@@ -23,6 +23,7 @@
  */
 static void mips_sc_wback_inv(unsigned long addr, unsigned long size)
 {
+	__sync();
 	blast_scache_range(addr, addr + size);
 }
 
diff --git a/mm/highmem.c b/mm/highmem.c
index 57d82c6..f83ac30 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -44,6 +44,14 @@ DEFINE_PER_CPU(int, __kmap_atomic_idx);
  */
 #ifdef CONFIG_HIGHMEM
 
+#ifndef ARCH_PKMAP_COLORING
+#define     set_pkmap_color(pg,cl)          /* */
+#define     get_last_pkmap_nr(p,cl)         (p)
+#define     get_next_pkmap_nr(p,cl)         ((p + 1) & LAST_PKMAP_MASK)
+#define     is_no_more_pkmaps(p,cl)         (!p)
+#define     get_next_pkmap_counter(c,cl)    (c - 1)
+#endif
+
 unsigned long totalhigh_pages __read_mostly;
 EXPORT_SYMBOL(totalhigh_pages);
 
@@ -149,19 +157,24 @@ static inline unsigned long map_new_virtual(struct page *page)
 {
 	unsigned long vaddr;
 	int count;
+	int color;
+
+	set_pkmap_color(page,color);
+	last_pkmap_nr = get_last_pkmap_nr(last_pkmap_nr,color);
 
 start:
 	count = LAST_PKMAP;
 	/* Find an empty entry */
 	for (;;) {
-		last_pkmap_nr = (last_pkmap_nr + 1) & LAST_PKMAP_MASK;
-		if (!last_pkmap_nr) {
+		last_pkmap_nr = get_next_pkmap_nr(last_pkmap_nr,color);
+		if (is_no_more_pkmaps(last_pkmap_nr,color)) {
 			flush_all_zero_pkmaps();
 			count = LAST_PKMAP;
 		}
 		if (!pkmap_count[last_pkmap_nr])
 			break;	/* Found a usable entry */
-		if (--count)
+		count = get_next_pkmap_counter(count,color);
+		if (count > 0)
 			continue;
 
 		/*
-- 
1.7.9.6
