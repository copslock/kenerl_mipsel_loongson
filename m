Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2014 16:54:25 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:38127 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013510AbaKMPwUD-o0T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Nov 2014 16:52:20 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1Xowgu-0007pf-AE; Thu, 13 Nov 2014 09:52:12 -0600
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH 1/8] MIPS: HIGHMEM fixes for cache aliasing and non-DMA I/O.
Date:   Thu, 13 Nov 2014 09:51:57 -0600
Message-Id: <1415893924-36351-2-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1415893924-36351-1-git-send-email-Steven.Hill@imgtec.com>
References: <1415893924-36351-1-git-send-email-Steven.Hill@imgtec.com>
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44138
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

This patch fixes HIGHMEM for cache aliasing and non-DMA device
I/O. It does the following:

1.  Uses only colored page addresses while allocating by kmap*().
    The page address in the HIGHMEM zone matches a kernel address
    by color and allows easy re-allocation before flushing cache.
    It does this for kmap() and kmap_atomic().

2.  Fixes I-cache flush by right color address via kmap_coherent()
    in case of I-cache aliasing.

3.  Flushes D-cache before page is provided for processing as an
    I-page, required for swapped-in pages in case of non-DMA I/O.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/Kconfig                    |    1 +
 arch/mips/include/asm/cacheflush.h   |    3 +-
 arch/mips/include/asm/cpu-features.h |    6 +++
 arch/mips/include/asm/fixmap.h       |   14 +++++-
 arch/mips/include/asm/highmem.h      |   44 +++++++++++++++++-
 arch/mips/include/asm/page.h         |    5 +-
 arch/mips/mm/c-r4k.c                 |   40 ++++++++++++++--
 arch/mips/mm/cache.c                 |   83 +++++++++++++++++++++++++---------
 arch/mips/mm/highmem.c               |   46 ++++++++-----------
 arch/mips/mm/init.c                  |   35 +++++++-------
 arch/mips/mm/sc-mips.c               |    1 +
 11 files changed, 204 insertions(+), 74 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 3afb795..f7e93c4 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -374,6 +374,7 @@ config MIPS_MALTA
 	select SYS_SUPPORTS_MULTITHREADING
 	select SYS_SUPPORTS_SMARTMIPS
 	select SYS_SUPPORTS_ZBOOT
+	select SYS_SUPPORTS_HIGHMEM
 	help
 	  This enables support for the MIPS Technologies Malta evaluation
 	  board.
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
index 2897cfa..92aa321 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -139,6 +139,12 @@
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
index 6842ffa..4497f06 100644
--- a/arch/mips/include/asm/fixmap.h
+++ b/arch/mips/include/asm/fixmap.h
@@ -46,13 +46,25 @@
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
 	FIX_CMAP_END = FIX_CMAP_BEGIN + (FIX_N_COLOURS * 2),
 #ifdef CONFIG_HIGHMEM
 	/* reserved pte's for temporary kernel mappings */
 	FIX_KMAP_BEGIN = FIX_CMAP_END + 1,
-	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
+	FIX_KMAP_END = FIX_KMAP_BEGIN+(8*NR_CPUS*FIX_N_COLOURS)-1,
 #endif
 	__end_of_fixed_addresses
 };
diff --git a/arch/mips/include/asm/highmem.h b/arch/mips/include/asm/highmem.h
index 572e63e..23401a8 100644
--- a/arch/mips/include/asm/highmem.h
+++ b/arch/mips/include/asm/highmem.h
@@ -36,11 +36,53 @@ extern pte_t *pkmap_page_table;
  * easily, subsequent pte tables have to be allocated in one physical
  * chunk of RAM.
  */
-#define LAST_PKMAP 1024
+
+#ifdef CONFIG_PAGE_SIZE_4KB
+#define LAST_PKMAP	4096
+#elif defined(CONFIG_PAGE_SIZE_8KB)
+#define LAST_PKMAP	2048
+#else
+#define LAST_PKMAP	1024
+#endif
+
 #define LAST_PKMAP_MASK (LAST_PKMAP-1)
 #define PKMAP_NR(virt)	((virt-PKMAP_BASE) >> PAGE_SHIFT)
 #define PKMAP_ADDR(nr)	(PKMAP_BASE + ((nr) << PAGE_SHIFT))
 
+#define get_pkmap_color get_pkmap_color
+static inline int get_pkmap_color(struct page *page)
+{
+	return (int)(((unsigned long)lowmem_page_address(page) >> PAGE_SHIFT)
+			& (FIX_N_COLOURS - 1));
+}
+
+extern unsigned int last_pkmap_nr_arr[];
+
+static inline unsigned int get_next_pkmap_nr(unsigned int color)
+{
+	last_pkmap_nr_arr[color] =
+		(last_pkmap_nr_arr[color] + FIX_N_COLOURS) & LAST_PKMAP_MASK;
+	return last_pkmap_nr_arr[color] + color;
+}
+
+static inline int no_more_pkmaps(unsigned int pkmap_nr, unsigned int color)
+{
+	return pkmap_nr < FIX_N_COLOURS;
+}
+
+static inline int get_pkmap_entries_count(unsigned int color)
+{
+	return LAST_PKMAP / FIX_N_COLOURS;
+}
+
+extern wait_queue_head_t pkmap_map_wait_arr[];
+
+static inline wait_queue_head_t *get_pkmap_wait_queue_head(unsigned int color)
+{
+	return pkmap_map_wait_arr + color;
+}
+
+
 extern void * kmap_high(struct page *page);
 extern void kunmap_high(struct page *page);
 
diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index 3be8180..ec7b54d 100644
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
 
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index dd261df..1559360 100644
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
@@ -549,6 +552,7 @@ static inline void local_r4k_flush_cache_page(void *args)
 	pmd_t *pmdp;
 	pte_t *ptep;
 	void *vaddr;
+	int dontflash = 0;
 
 	/*
 	 * If ownes no valid ASID yet, cannot possibly have gotten
@@ -570,6 +574,10 @@ static inline void local_r4k_flush_cache_page(void *args)
 	if (!(pte_present(*ptep)))
 		return;
 
+	/*  accelerate it! See below, just skipping kmap_*()/kunmap_*() */
+	if ((!exec) && !cpu_has_dc_aliases)
+		return;
+
 	if ((mm == current->active_mm) && (pte_val(*ptep) & _PAGE_VALID))
 		vaddr = NULL;
 	else {
@@ -589,6 +597,8 @@ static inline void local_r4k_flush_cache_page(void *args)
 	if (cpu_has_dc_aliases || (exec && !cpu_has_ic_fills_f_dc)) {
 		vaddr ? r4k_blast_dcache_page(addr) :
 			r4k_blast_dcache_user_page(addr);
+		if (exec && !cpu_has_ic_fills_f_dc)
+			wmb();
 		if (exec && !cpu_icache_snoops_remote_store)
 			r4k_blast_scache_page(addr);
 	}
@@ -598,6 +608,7 @@ static inline void local_r4k_flush_cache_page(void *args)
 
 			if (cpu_context(cpu, mm) != 0)
 				drop_mmu_context(mm, cpu);
+			dontflash = 1;
 		} else
 			vaddr ? r4k_blast_icache_page(addr) :
 				r4k_blast_icache_user_page(addr);
@@ -609,6 +620,13 @@ static inline void local_r4k_flush_cache_page(void *args)
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
@@ -621,6 +639,8 @@ static void r4k_flush_cache_page(struct vm_area_struct *vma,
 	args.pfn = pfn;
 
 	r4k_on_each_cpu(local_r4k_flush_cache_page, &args);
+	if (cpu_has_dc_aliases)
+		ClearPageDcacheDirty(pfn_to_page(pfn));
 }
 
 static inline void local_r4k_flush_data_cache_page(void * addr)
@@ -652,6 +672,8 @@ static inline void local_r4k_flush_icache_range(unsigned long start, unsigned lo
 		}
 	}
 
+	wmb();
+
 	if (end - start > icache_size)
 		r4k_blast_icache();
 	else {
@@ -1271,6 +1293,14 @@ static void probe_pcache(void)
 			c->dcache.flags |= MIPS_CACHE_ALIASES;
 	}
 
+#ifdef  CONFIG_HIGHMEM
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
@@ -1292,10 +1322,12 @@ static void probe_pcache(void)
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
index 7e3ea77..dd797bf 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -19,6 +19,7 @@
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
 
@@ -124,18 +152,31 @@ static void mips_flush_dcache_from_pte(pte_t pteval, unsigned long address)
 	struct page *page;
 	unsigned long pfn = pte_pfn(pteval);
 
-	if (unlikely(!pfn_valid(pfn)))
+	if (unlikely(!pfn_valid(pfn))) {
+		wmb();
 		return;
+	}
 
 	page = pfn_to_page(pfn);
 	if (page_mapping(page) && Page_dcache_dirty(page)) {
 		unsigned long page_addr = (unsigned long) page_address(page);
+		void *kaddr = NULL;
+
+		if (PageHighMem(page)) {
+			page_addr = (unsigned long)kmap_atomic(page);
+			kaddr = (void *)page_addr;
+		}
 
 		if (!cpu_has_ic_fills_f_dc ||
-		    pages_do_alias(page_addr, address & PAGE_MASK))
+		    pages_do_alias(page_addr, address & PAGE_MASK)) {
 			flush_data_cache_page(page_addr);
-		ClearPageDcacheDirty(page);
+			ClearPageDcacheDirty(page);
+		}
+
+		if (kaddr)
+			kunmap_atomic((void *)kaddr);
 	}
+	wmb();
 }
 
 void set_pte_at(struct mm_struct *mm, unsigned long addr,
diff --git a/arch/mips/mm/highmem.c b/arch/mips/mm/highmem.c
index da815d2..68cf6b5 100644
--- a/arch/mips/mm/highmem.c
+++ b/arch/mips/mm/highmem.c
@@ -8,7 +8,11 @@
 
 static pte_t *kmap_pte;
 
+unsigned int last_pkmap_nr_arr[FIX_N_COLOURS];
+wait_queue_head_t pkmap_map_wait_arr[FIX_N_COLOURS];
+
 unsigned long highstart_pfn, highend_pfn;
+unsigned int  last_pkmap_nr_arr[FIX_N_COLOURS] = { 0, 1, 2, 3, 4, 5, 6, 7 };
 
 void *kmap(struct page *page)
 {
@@ -53,8 +57,12 @@ void *kmap_atomic(struct page *page)
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
@@ -75,12 +83,16 @@ void __kunmap_atomic(void *kvaddr)
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
@@ -95,26 +107,6 @@ void __kunmap_atomic(void *kvaddr)
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
@@ -124,7 +116,7 @@ struct page *kmap_atomic_to_page(void *ptr)
 		return virt_to_page(ptr);
 
 	idx = virt_to_fix(vaddr);
-	pte = kmap_pte - (idx - FIX_KMAP_BEGIN);
+	pte = kmap_pte - (idx - FIX_KMAP_BEGIN + 1);
 	return pte_page(*pte);
 }
 
@@ -133,6 +125,6 @@ void __init kmap_init(void)
 	unsigned long kmap_vstart;
 
 	/* cache the first kmap pte */
-	kmap_vstart = __fix_to_virt(FIX_KMAP_BEGIN);
+	kmap_vstart = __fix_to_virt(FIX_KMAP_BEGIN - 1); /* actually - FIX_CMAP_END */
 	kmap_pte = kmap_get_fixmap_pte(kmap_vstart);
 }
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index f42e35e..5efe70f 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -88,8 +88,6 @@ static void *__kmap_pgprot(struct page *page, unsigned long addr, pgprot_t prot)
 	pte_t pte;
 	int tlbidx;
 
-	BUG_ON(Page_dcache_dirty(page));
-
 	pagefault_disable();
 	idx = (addr >> PAGE_SHIFT) & (FIX_N_COLOURS - 1);
 	idx += in_interrupt() ? FIX_N_COLOURS : 0;
@@ -165,9 +163,15 @@ void copy_user_highpage(struct page *to, struct page *from,
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
@@ -187,8 +191,14 @@ void copy_to_user_page(struct vm_area_struct *vma,
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
@@ -200,11 +210,8 @@ void copy_from_user_page(struct vm_area_struct *vma,
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
 
@@ -275,7 +282,7 @@ int page_is_ram(unsigned long pagenr)
 void __init paging_init(void)
 {
 	unsigned long max_zone_pfns[MAX_NR_ZONES];
-	unsigned long lastpfn __maybe_unused;
+	unsigned long lastpfn;
 
 	pagetable_init();
 
@@ -293,14 +300,6 @@ void __init paging_init(void)
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
