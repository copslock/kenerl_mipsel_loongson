Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Feb 2015 17:18:32 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:3401 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013215AbbBSQSET0Ugz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Feb 2015 17:18:04 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id CF2B03FD1DFBB
        for <linux-mips@linux-mips.org>; Thu, 19 Feb 2015 16:17:54 +0000 (GMT)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 19 Feb
 2015 16:17:57 +0000
Received: from solomon.ba.imgtec.org (10.20.78.13) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 19 Feb
 2015 08:17:54 -0800
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     <IMG-MIPSLinuxKerneldevelopers@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH V2 2/3] MIPS: Highmem: Fixes for cache aliasing and color.
Date:   Thu, 19 Feb 2015 10:17:43 -0600
Message-ID: <1424362664-30303-3-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1424362664-30303-1-git-send-email-Steven.Hill@imgtec.com>
References: <1424362664-30303-1-git-send-email-Steven.Hill@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.78.13]
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45859
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

Make HIGHMEM kmap cache coloring aware and fix some corner
cases for cache aliasing.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/Kconfig               |    1 +
 arch/mips/include/asm/fixmap.h  |   18 ++++++++-
 arch/mips/include/asm/highmem.h |   33 +++++++++++++++
 arch/mips/mm/c-r4k.c            |    8 ++++
 arch/mips/mm/cache.c            |   84 ++++++++++++++++++++++++++-------------
 arch/mips/mm/highmem.c          |   43 ++++++++------------
 arch/mips/mm/init.c             |   10 +----
 7 files changed, 132 insertions(+), 65 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 8523db5..da6c43f 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -394,6 +394,7 @@ config MIPS_MALTA
 	select SYS_SUPPORTS_MULTITHREADING
 	select SYS_SUPPORTS_SMARTMIPS
 	select SYS_SUPPORTS_ZBOOT
+	select SYS_SUPPORTS_HIGHMEM
 	help
 	  This enables support for the MIPS Technologies Malta evaluation
 	  board.
diff --git a/arch/mips/include/asm/fixmap.h b/arch/mips/include/asm/fixmap.h
index 6842ffa..f7733a0 100644
--- a/arch/mips/include/asm/fixmap.h
+++ b/arch/mips/include/asm/fixmap.h
@@ -46,13 +46,27 @@
  * fix-mapped?
  */
 enum fixed_addresses {
+
+/*
+ * Must be <=8 but, last_pkmap_nr_arr[] is still initialized to
+ * 8 elements. Keep the total L1 size <= 512KB with 4-ways.
+ */
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
-	FIX_CMAP_END = FIX_CMAP_BEGIN + (FIX_N_COLOURS * 2),
+	FIX_CMAP_END = FIX_CMAP_BEGIN + (FIX_N_COLOURS * NR_CPUS * 2),
 #ifdef CONFIG_HIGHMEM
 	/* reserved pte's for temporary kernel mappings */
 	FIX_KMAP_BEGIN = FIX_CMAP_END + 1,
-	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
+	FIX_KMAP_END = FIX_KMAP_BEGIN+(8*NR_CPUS*FIX_N_COLOURS)-1,
 #endif
 	__end_of_fixed_addresses
 };
diff --git a/arch/mips/include/asm/highmem.h b/arch/mips/include/asm/highmem.h
index 572e63e..af6180f 100644
--- a/arch/mips/include/asm/highmem.h
+++ b/arch/mips/include/asm/highmem.h
@@ -36,11 +36,44 @@ extern pte_t *pkmap_page_table;
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
 
+#define     get_pkmap_color(pg) (((unsigned long)lowmem_page_address(pg) >> PAGE_SHIFT) & (FIX_N_COLOURS-1))
+#define     get_last_pkmap_nr(cl)     (last_pkmap_nr_arr[cl])
+#define     get_next_pkmap_nr(cl)     (last_pkmap_nr_arr[cl] = \
+					    ((get_last_pkmap_nr(cl) + FIX_N_COLOURS) & LAST_PKMAP_MASK))
+#define     no_more_pkmaps(p,cl)     (p < FIX_N_COLOURS)
+#define     get_pkmap_entries_count(c)    (c - FIX_N_COLOURS)
+
+static inline wait_queue_head_t *get_pkmap_wait_queue_head(unsigned int color)
+{
+	static DECLARE_WAIT_QUEUE_HEAD(pkmap_map_wait);
+
+	return &pkmap_map_wait;
+}
+
+extern unsigned int     last_pkmap_nr_arr[];
+
+
 extern void * kmap_high(struct page *page);
 extern void kunmap_high(struct page *page);
 
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 3bb0d06..779dcfa 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1289,6 +1289,14 @@ static void probe_pcache(void)
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
diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 99db9e8..49496a4 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -81,12 +81,9 @@ SYSCALL_DEFINE3(cacheflush, unsigned long, addr, unsigned long, bytes,
 
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
@@ -96,30 +93,54 @@ void __flush_dcache_page(struct page *page)
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
-	if (pages_do_alias(addr, vmaddr & PAGE_MASK)) {
-		if (page_mapped(page) && !Page_dcache_dirty(page)) {
-			void *kaddr;
-
-			kaddr = kmap_coherent(page, vmaddr);
-			flush_data_cache_page((unsigned long)kaddr);
-			kunmap_coherent();
-		} else {
-			void *kaddr;
-
-			kaddr = kmap_atomic(page);
-			flush_data_cache_page((unsigned long)kaddr);
-			kunmap_atomic(kaddr);
-			ClearPageDcacheDirty(page);
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
 		}
 	}
 }
@@ -130,21 +151,30 @@ void __update_cache(struct vm_area_struct *vma, unsigned long address,
 	pte_t pte)
 {
 	struct page *page;
-	unsigned long pfn = pte_pfn(pte);
+	unsigned long pfn, addr;
 	int exec = (vma->vm_flags & VM_EXEC) && !cpu_has_ic_fills_f_dc;
 
+	pfn = pte_pfn(pte);
 	if (unlikely(!pfn_valid(pfn))) {
 		wmb();
 		return;
 	}
 	page = pfn_to_page(pfn);
 	if (page_mapped(page) && Page_dcache_dirty(page)) {
-		unsigned long page_addr = (unsigned long) page_address(page);
+		void *kaddr = NULL;
+		if (PageHighMem(page)) {
+			addr = (unsigned long)kmap_atomic(page);
+			kaddr = (void *)addr;
+		} else
+			addr = (unsigned long) page_address(page);
 		if (exec || (cpu_has_dc_aliases &&
-		    pages_do_alias(page_addr, address & PAGE_MASK))) {
-			flush_data_cache_page(page_addr);
+		    pages_do_alias(addr, address & PAGE_MASK))) {
+			flush_data_cache_page(addr);
 			ClearPageDcacheDirty(page);
 		}
+
+		if (kaddr)
+			kunmap_atomic((void *)kaddr);
 	}
 	wmb();  /* finish any outstanding arch cache flushes before ret to user */
 }
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
index 597bf7f..0dc604a 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -284,7 +284,7 @@ int page_is_ram(unsigned long pagenr)
 void __init paging_init(void)
 {
 	unsigned long max_zone_pfns[MAX_NR_ZONES];
-	unsigned long lastpfn __maybe_unused;
+	unsigned long lastpfn;
 
 	pagetable_init();
 
@@ -302,14 +302,6 @@ void __init paging_init(void)
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
-- 
1.7.10.4
