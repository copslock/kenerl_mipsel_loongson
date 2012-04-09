Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2012 18:13:31 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:39896 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903692Ab2DIQNX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Apr 2012 18:13:23 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SHHDR-000609-Bj; Mon, 09 Apr 2012 11:13:17 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>,
        Leonid Yegoshin <yegoshin@mips.com>
Subject: [PATCH] Revert "MIPS: cache: Provide cache flush operations for XFS"
Date:   Mon,  9 Apr 2012 11:13:09 -0500
Message-Id: <1333987989-1178-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.6
X-archive-position: 32907
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

This reverts commit d759e6bf49a41edd66de7c6480b34cceb88ee29a. The
flush_kernel_vmap_range() and invalidate_kernel_vmap_range() are DMA
cache flushing operations and should be done via _dma_cache_wback_inv()
and _dma_cache_inv().

Signed-off-by: Leonid Yegoshin <yegoshin@mips.com>
Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/cacheflush.h |   43 ++++++++++++++++--------------------
 arch/mips/mm/c-octeon.c            |    6 -----
 arch/mips/mm/c-r3k.c               |    7 ------
 arch/mips/mm/c-r4k.c               |   35 -----------------------------
 arch/mips/mm/c-tx39.c              |    7 ------
 arch/mips/mm/cache.c               |    5 -----
 6 files changed, 19 insertions(+), 84 deletions(-)

diff --git a/arch/mips/include/asm/cacheflush.h b/arch/mips/include/asm/cacheflush.h
index 69468de..106b61a 100644
--- a/arch/mips/include/asm/cacheflush.h
+++ b/arch/mips/include/asm/cacheflush.h
@@ -58,9 +58,28 @@ static inline void flush_anon_page(struct vm_area_struct *vma,
 		__flush_anon_page(page, vmaddr);
 }
 
+#define ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
+static inline void flush_kernel_dcache_page(struct page *page)
+{
+	if (cpu_has_dc_aliases || !cpu_has_ic_fills_f_dc)
+		__flush_dcache_page(page);
+}
+
+static inline void flush_kernel_vmap_range(void *addr, unsigned long size)
+{
+	_dma_cache_wback_inv((unsigned long)addr, size);
+}
+
+static inline void invalidate_kernel_vmap_range(void *addr, unsigned long size)
+{
+	_dma_cache_inv((unsigned long)addr, size);
+}
+
 static inline void flush_icache_page(struct vm_area_struct *vma,
 	struct page *page)
 {
+	if (cpu_has_dc_aliases || ((vma->vm_flags & VM_EXEC) && !cpu_has_ic_fills_f_dc))
+		__flush_dcache_page(page);
 }
 
 extern void (*flush_icache_range)(unsigned long start, unsigned long end);
@@ -114,28 +133,4 @@ unsigned long run_uncached(void *func);
 extern void *kmap_coherent(struct page *page, unsigned long addr);
 extern void kunmap_coherent(void);
 
-#define ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
-static inline void flush_kernel_dcache_page(struct page *page)
-{
-	BUG_ON(cpu_has_dc_aliases && PageHighMem(page));
-}
-
-/*
- * For now flush_kernel_vmap_range and invalidate_kernel_vmap_range both do a
- * cache writeback and invalidate operation.
- */
-extern void (*__flush_kernel_vmap_range)(unsigned long vaddr, int size);
-
-static inline void flush_kernel_vmap_range(void *vaddr, int size)
-{
-	if (cpu_has_dc_aliases)
-		__flush_kernel_vmap_range((unsigned long) vaddr, size);
-}
-
-static inline void invalidate_kernel_vmap_range(void *vaddr, int size)
-{
-	if (cpu_has_dc_aliases)
-		__flush_kernel_vmap_range((unsigned long) vaddr, size);
-}
-
 #endif /* _ASM_CACHEFLUSH_H */
diff --git a/arch/mips/mm/c-octeon.c b/arch/mips/mm/c-octeon.c
index 1f9ca07..109d707 100644
--- a/arch/mips/mm/c-octeon.c
+++ b/arch/mips/mm/c-octeon.c
@@ -168,10 +168,6 @@ static void octeon_flush_cache_page(struct vm_area_struct *vma,
 		octeon_flush_icache_all_cores(vma);
 }
 
-static void octeon_flush_kernel_vmap_range(unsigned long vaddr, int size)
-{
-	BUG();
-}
 
 /**
  * Probe Octeon's caches
@@ -276,8 +272,6 @@ void __cpuinit octeon_cache_init(void)
 	flush_icache_range		= octeon_flush_icache_range;
 	local_flush_icache_range	= local_octeon_flush_icache_range;
 
-	__flush_kernel_vmap_range	= octeon_flush_kernel_vmap_range;
-
 	build_clear_page();
 	build_copy_page();
 }
diff --git a/arch/mips/mm/c-r3k.c b/arch/mips/mm/c-r3k.c
index 031c4c2..89f1ca2 100644
--- a/arch/mips/mm/c-r3k.c
+++ b/arch/mips/mm/c-r3k.c
@@ -298,11 +298,6 @@ static void r3k_flush_cache_sigtramp(unsigned long addr)
 	write_c0_status(flags);
 }
 
-static void r3k_flush_kernel_vmap_range(unsigned long vaddr, int size)
-{
-	BUG();
-}
-
 static void r3k_dma_cache_wback_inv(unsigned long start, unsigned long size)
 {
 	/* Catch bad driver code */
@@ -327,8 +322,6 @@ void __cpuinit r3k_cache_init(void)
 	flush_icache_range = r3k_flush_icache_range;
 	local_flush_icache_range = r3k_flush_icache_range;
 
-	__flush_kernel_vmap_range = r3k_flush_kernel_vmap_range;
-
 	flush_cache_sigtramp = r3k_flush_cache_sigtramp;
 	local_flush_data_cache_page = local_r3k_flush_data_cache_page;
 	flush_data_cache_page = r3k_flush_data_cache_page;
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 821a8bd..d3adcb6 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -721,39 +721,6 @@ static void r4k_flush_icache_all(void)
 		r4k_blast_icache();
 }
 
-struct flush_kernel_vmap_range_args {
-	unsigned long	vaddr;
-	int		size;
-};
-
-static inline void local_r4k_flush_kernel_vmap_range(void *args)
-{
-	struct flush_kernel_vmap_range_args *vmra = args;
-	unsigned long vaddr = vmra->vaddr;
-	int size = vmra->size;
-
-	/*
-	 * Aliases only affect the primary caches so don't bother with
-	 * S-caches or T-caches.
-	 */
-	if (cpu_has_safe_index_cacheops && size >= dcache_size)
-		r4k_blast_dcache();
-	else {
-		R4600_HIT_CACHEOP_WAR_IMPL;
-		blast_dcache_range(vaddr, vaddr + size);
-	}
-}
-
-static void r4k_flush_kernel_vmap_range(unsigned long vaddr, int size)
-{
-	struct flush_kernel_vmap_range_args args;
-
-	args.vaddr = (unsigned long) vaddr;
-	args.size = size;
-
-	r4k_on_each_cpu(local_r4k_flush_kernel_vmap_range, &args);
-}
-
 static inline void rm7k_erratum31(void)
 {
 	const unsigned long ic_lsize = 32;
@@ -1449,8 +1416,6 @@ void __cpuinit r4k_cache_init(void)
 	flush_cache_page	= r4k_flush_cache_page;
 	flush_cache_range	= r4k_flush_cache_range;
 
-	__flush_kernel_vmap_range = r4k_flush_kernel_vmap_range;
-
 	flush_cache_sigtramp	= r4k_flush_cache_sigtramp;
 	flush_icache_all	= r4k_flush_icache_all;
 	local_flush_data_cache_page	= local_r4k_flush_data_cache_page;
diff --git a/arch/mips/mm/c-tx39.c b/arch/mips/mm/c-tx39.c
index 87d23ca..b305187 100644
--- a/arch/mips/mm/c-tx39.c
+++ b/arch/mips/mm/c-tx39.c
@@ -252,11 +252,6 @@ static void tx39_flush_icache_range(unsigned long start, unsigned long end)
 	}
 }
 
-static void tx39_flush_kernel_vmap_range(unsigned long vaddr, int size)
-{
-	BUG();
-}
-
 static void tx39_dma_cache_wback_inv(unsigned long addr, unsigned long size)
 {
 	unsigned long end;
@@ -398,8 +393,6 @@ void __cpuinit tx39_cache_init(void)
 		flush_icache_range = tx39_flush_icache_range;
 		local_flush_icache_range = tx39_flush_icache_range;
 
-		__flush_kernel_vmap_range = tx39_flush_kernel_vmap_range;
-
 		flush_cache_sigtramp = tx39_flush_cache_sigtramp;
 		local_flush_data_cache_page = local_tx39_flush_data_cache_page;
 		flush_data_cache_page = tx39_flush_data_cache_page;
diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 829320c..12af739 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -35,11 +35,6 @@ void (*local_flush_icache_range)(unsigned long start, unsigned long end);
 void (*__flush_cache_vmap)(void);
 void (*__flush_cache_vunmap)(void);
 
-void (*__flush_kernel_vmap_range)(unsigned long vaddr, int size);
-void (*__invalidate_kernel_vmap_range)(unsigned long vaddr, int size);
-
-EXPORT_SYMBOL_GPL(__flush_kernel_vmap_range);
-
 /* MIPS specific cache operations */
 void (*flush_cache_sigtramp)(unsigned long addr);
 void (*local_flush_data_cache_page)(void * addr);
-- 
1.7.9.6
