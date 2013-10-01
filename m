Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Oct 2013 06:14:01 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:42543 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6865325Ab3JAEN5xF0Td (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Oct 2013 06:13:57 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1VQrLK-0005Nt-68; Mon, 30 Sep 2013 23:13:50 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>, linux-mm@kvack.org,
        ralf@linux-mips.org, "Steven J. Hill" <Steven.Hill@imgtec.com>
Subject: [RESEND PATCH] MIPS HIGHMEM fixes for cache aliasing and non-DMA I/O.
Date:   Mon, 30 Sep 2013 23:13:45 -0500
Message-Id: <1380600825-28319-1-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.9.5
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38081
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

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
(cherry picked from commit bf252e2d224256b3f34683bff141d6951b3cae6a)
---
 arch/mips/Kconfig                    |    2 +
 arch/mips/include/asm/cpu-features.h |    6 +++
 arch/mips/include/asm/fixmap.h       |   14 +++++-
 arch/mips/include/asm/highmem.h      |   27 +++++++++++
 arch/mips/include/asm/mipsregs.h     |    3 +-
 arch/mips/include/asm/page.h         |    3 +-
 arch/mips/mm/c-r4k.c                 |   49 ++++++++++++++++---
 arch/mips/mm/cache.c                 |   87 +++++++++++++++++++++++++---------
 arch/mips/mm/highmem.c               |   43 +++++++----------
 arch/mips/mm/init.c                  |   35 +++++++-------
 arch/mips/mm/sc-mips.c               |    1 +
 mm/highmem.c                         |   19 ++++++--
 12 files changed, 210 insertions(+), 79 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 17cc7ff..ed835b2 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -330,6 +330,7 @@ config MIPS_MALTA
 	select SYS_SUPPORTS_MULTITHREADING
 	select SYS_SUPPORTS_SMARTMIPS
 	select SYS_SUPPORTS_ZBOOT
+	select SYS_SUPPORTS_HIGHMEM
 	help
 	  This enables support for the MIPS Technologies Malta evaluation
 	  board.
@@ -2064,6 +2065,7 @@ config CPU_R4400_WORKAROUNDS
 config HIGHMEM
 	bool "High Memory Support"
 	depends on 32BIT && CPU_SUPPORTS_HIGHMEM && SYS_SUPPORTS_HIGHMEM
+	depends on ( !SMP || NR_CPUS = 1 || NR_CPUS = 2 || NR_CPUS = 3 || NR_CPUS = 4 || NR_CPUS = 5 || NR_CPUS = 6 || NR_CPUS = 7 || NR_CPUS = 8 )
 
 config CPU_SUPPORTS_HIGHMEM
 	bool
diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index d445d06..81f5b84 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -114,6 +114,12 @@
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
index dfaaf49..a690f05 100644
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
index b0dd0c8..d0310dc0 100644
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
 #define PKMAP_NR(virt)	((virt-PKMAP_BASE) >> PAGE_SHIFT)
 #define PKMAP_ADDR(nr)	(PKMAP_BASE + ((nr) << PAGE_SHIFT))
 
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
 
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index e033141..f676494 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -613,7 +613,8 @@
 #define MIPS_CONF6_SYND		(_ULCAST_(1) << 13)
 
 #define MIPS_CONF7_WII		(_ULCAST_(1) << 31)
-
+#define MIPS_CONF7_AR		(_ULCAST_(1) << 16)
+#define MIPS_CONF7_IAR		(_ULCAST_(1) << 10)
 #define MIPS_CONF7_RPS		(_ULCAST_(1) << 2)
 
 
diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index f6be474..5090bb2 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -76,7 +76,8 @@ static inline void clear_user_page(void *addr, unsigned long vaddr,
 	extern void (*flush_data_cache_page)(unsigned long addr);
 
 	clear_page(addr);
-	if (pages_do_alias((unsigned long) addr, vaddr & PAGE_MASK))
+	if (cpu_has_vtag_dcache || (cpu_has_dc_aliases &&
+	     pages_do_alias((unsigned long) addr, vaddr & PAGE_MASK)))
 		flush_data_cache_page((unsigned long)addr);
 }
 
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 341609c..d7acabb 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -409,8 +409,11 @@ static inline void local_r4k_flush_cache_range(void * args)
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
@@ -474,6 +477,7 @@ static inline void local_r4k_flush_cache_page(void *args)
 	pmd_t *pmdp;
 	pte_t *ptep;
 	void *vaddr;
+	int dontflash = 0;
 
 	/*
 	 * If ownes no valid ASID yet, cannot possibly have gotten
@@ -495,6 +499,10 @@ static inline void local_r4k_flush_cache_page(void *args)
 	if (!(pte_present(*ptep)))
 		return;
 
+	/*  accelerate it! See below, just skipping kmap_*()/kunmap_*() */
+	if ((!exec) && !cpu_has_dc_aliases)
+		return;
+
 	if ((mm == current->active_mm) && (pte_val(*ptep) & _PAGE_VALID))
 		vaddr = NULL;
 	else {
@@ -513,6 +521,8 @@ static inline void local_r4k_flush_cache_page(void *args)
 
 	if (cpu_has_dc_aliases || (exec && !cpu_has_ic_fills_f_dc)) {
 		r4k_blast_dcache_page(addr);
+		if (exec && !cpu_has_ic_fills_f_dc)
+			wmb();
 		if (exec && !cpu_icache_snoops_remote_store)
 			r4k_blast_scache_page(addr);
 	}
@@ -522,8 +532,10 @@ static inline void local_r4k_flush_cache_page(void *args)
 
 			if (cpu_context(cpu, mm) != 0)
 				drop_mmu_context(mm, cpu);
+			dontflash = 1;
 		} else
-			r4k_blast_icache_page(addr);
+			if (map_coherent || !cpu_has_ic_aliases)
+				r4k_blast_icache_page(addr);
 	}
 
 	if (vaddr) {
@@ -532,6 +544,13 @@ static inline void local_r4k_flush_cache_page(void *args)
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
@@ -544,6 +563,8 @@ static void r4k_flush_cache_page(struct vm_area_struct *vma,
 	args.pfn = pfn;
 
 	r4k_on_each_cpu(local_r4k_flush_cache_page, &args);
+	if (cpu_has_dc_aliases)
+		ClearPageDcacheDirty(pfn_to_page(pfn));
 }
 
 static inline void local_r4k_flush_data_cache_page(void * addr)
@@ -575,6 +596,8 @@ static inline void local_r4k_flush_icache_range(unsigned long start, unsigned lo
 		}
 	}
 
+	wmb();
+
 	if (end - start > icache_size)
 		r4k_blast_icache();
 	else {
@@ -1098,7 +1121,11 @@ static void probe_pcache(void)
 	case CPU_1004K:
 		if (current_cpu_type() == CPU_74K)
 			alias_74k_erratum(c);
-		if ((read_c0_config7() & (1 << 16))) {
+		if (!(read_c0_config7() & MIPS_CONF7_IAR)) {
+			if (c->icache.waysize > PAGE_SIZE)
+				c->icache.flags |= MIPS_CACHE_ALIASES;
+		}
+		if (read_c0_config7() & MIPS_CONF7_AR) {
 			/* effectively physically indexed dcache,
 			   thus no virtual aliases. */
 			c->dcache.flags |= MIPS_CACHE_PINDEX;
@@ -1109,6 +1136,14 @@ static void probe_pcache(void)
 			c->dcache.flags |= MIPS_CACHE_ALIASES;
 	}
 
+#ifdef CONFIG_HIGHMEM
+	if (((c->dcache.flags & MIPS_CACHE_ALIASES) &&
+	     ((c->dcache.waysize / PAGE_SIZE) > FIX_N_COLOURS)) ||
+	     ((c->icache.flags & MIPS_CACHE_ALIASES) &&
+	     ((c->icache.waysize / PAGE_SIZE) > FIX_N_COLOURS)))
+		panic("PAGE_SIZE*WAYS too small for L1 size, too many colors");
+#endif
+
 	switch (current_cpu_type()) {
 	case CPU_20KC:
 		/*
@@ -1130,10 +1165,12 @@ static void probe_pcache(void)
 		c->icache.ways = 1;
 	}
 
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
index 15f813c..92598de 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -20,6 +20,7 @@
 #include <asm/processor.h>
 #include <asm/cpu.h>
 #include <asm/cpu-features.h>
+#include <linux/highmem.h>
 
 /* Cache operations. */
 void (*flush_cache_all)(void);
@@ -80,12 +81,9 @@ SYSCALL_DEFINE3(cacheflush, unsigned long, addr, unsigned long, bytes,
 
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
@@ -95,25 +93,55 @@ void __flush_dcache_page(struct page *page)
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
 
@@ -127,15 +155,28 @@ void __update_cache(struct vm_area_struct *vma, unsigned long address,
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
index da815d2..10fc041 100644
--- a/arch/mips/mm/highmem.c
+++ b/arch/mips/mm/highmem.c
@@ -9,6 +9,7 @@
 static pte_t *kmap_pte;
 
 unsigned long highstart_pfn, highend_pfn;
+unsigned int  last_pkmap_nr_arr[FIX_N_COLOURS] = { 0, 1, 2, 3, 4, 5, 6, 7 };
 
 void *kmap(struct page *page)
 {
@@ -53,8 +54,12 @@ void *kmap_atomic(struct page *page)
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
@@ -75,12 +80,16 @@ void __kunmap_atomic(void *kvaddr)
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
@@ -95,26 +104,6 @@ void __kunmap_atomic(void *kvaddr)
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
@@ -124,7 +113,7 @@ struct page *kmap_atomic_to_page(void *ptr)
 		return virt_to_page(ptr);
 
 	idx = virt_to_fix(vaddr);
-	pte = kmap_pte - (idx - FIX_KMAP_BEGIN);
+	pte = kmap_pte - (idx - FIX_KMAP_BEGIN + 1);
 	return pte_page(*pte);
 }
 
@@ -133,6 +122,6 @@ void __init kmap_init(void)
 	unsigned long kmap_vstart;
 
 	/* cache the first kmap pte */
-	kmap_vstart = __fix_to_virt(FIX_KMAP_BEGIN);
+	kmap_vstart = __fix_to_virt(FIX_KMAP_BEGIN - 1); /* actually - FIX_CMAP_END */
 	kmap_pte = kmap_get_fixmap_pte(kmap_vstart);
 }
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index e205ef5..352367b 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -122,7 +122,7 @@ void *kmap_coherent(struct page *page, unsigned long addr)
 	pte_t pte;
 	int tlbidx;
 
-	BUG_ON(Page_dcache_dirty(page));
+	/* BUG_ON(Page_dcache_dirty(page)); - removed for I-cache flush */
 
 	inc_preempt_count();
 	idx = (addr >> PAGE_SHIFT) & (FIX_N_COLOURS - 1);
@@ -213,9 +213,15 @@ void copy_user_highpage(struct page *to, struct page *from,
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
@@ -235,8 +241,14 @@ void copy_to_user_page(struct vm_area_struct *vma,
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
@@ -248,11 +260,8 @@ void copy_from_user_page(struct vm_area_struct *vma,
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
 
@@ -323,7 +332,7 @@ int page_is_ram(unsigned long pagenr)
 void __init paging_init(void)
 {
 	unsigned long max_zone_pfns[MAX_NR_ZONES];
-	unsigned long lastpfn __maybe_unused;
+	unsigned long lastpfn;
 
 	pagetable_init();
 
@@ -343,14 +352,6 @@ void __init paging_init(void)
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
index 08d05ae..a801f6b 100644
--- a/arch/mips/mm/sc-mips.c
+++ b/arch/mips/mm/sc-mips.c
@@ -24,6 +24,7 @@
  */
 static void mips_sc_wback_inv(unsigned long addr, unsigned long size)
 {
+	__sync();
 	blast_scache_range(addr, addr + size);
 }
 
diff --git a/mm/highmem.c b/mm/highmem.c
index b32b70c..68a2acf 100644
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
 
@@ -161,19 +169,24 @@ static inline unsigned long map_new_virtual(struct page *page)
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
1.7.9.5
