Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Aug 2008 19:57:22 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:60339 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20037484AbYHDS5O (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 4 Aug 2008 19:57:14 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KQ5F3-0000hZ-00; Mon, 04 Aug 2008 20:57:13 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id E0CD4C315B; Mon,  4 Aug 2008 20:53:57 +0200 (CEST)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] Fix WARNING: at kernel/smp.c:290 
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20080804185357.E0CD4C315B@solo.franken.de>
Date:	Mon,  4 Aug 2008 20:53:57 +0200 (CEST)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20089
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

trap_init issues flush_icache_range(), which uses ipi functions to
get icache flushing done on all cpus. But this is done before interrupts
are enabled and caused WARN_ON messages. This changeset introduces
a new local_flush_icache_range() and uses it before interrupts (and
additional CPUs) are enabled to avoid this problem.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 arch/mips/kernel/traps.c      |   12 +++++++-----
 arch/mips/mm/c-r3k.c          |    1 +
 arch/mips/mm/c-r4k.c          |   18 ++++++++++++------
 arch/mips/mm/c-tx39.c         |    1 +
 arch/mips/mm/cache.c          |    1 +
 arch/mips/mm/tlbex.c          |    6 +++---
 include/asm-mips/cacheflush.h |    1 +
 7 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 1f579a8..6bee290 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1200,7 +1200,7 @@ void *set_except_vector(int n, void *addr)
 	if (n == 0 && cpu_has_divec) {
 		*(u32 *)(ebase + 0x200) = 0x08000000 |
 					  (0x03ffffff & (handler >> 2));
-		flush_icache_range(ebase + 0x200, ebase + 0x204);
+		local_flush_icache_range(ebase + 0x200, ebase + 0x204);
 	}
 	return (void *)old_handler;
 }
@@ -1283,7 +1283,8 @@ static void *set_vi_srs_handler(int n, vi_handler_t addr, int srs)
 		*w = (*w & 0xffff0000) | (((u32)handler >> 16) & 0xffff);
 		w = (u32 *)(b + ori_offset);
 		*w = (*w & 0xffff0000) | ((u32)handler & 0xffff);
-		flush_icache_range((unsigned long)b, (unsigned long)(b+handler_len));
+		local_flush_icache_range((unsigned long)b,
+					 (unsigned long)(b+handler_len));
 	}
 	else {
 		/*
@@ -1295,7 +1296,8 @@ static void *set_vi_srs_handler(int n, vi_handler_t addr, int srs)
 		w = (u32 *)b;
 		*w++ = 0x08000000 | (((u32)handler >> 2) & 0x03fffff); /* j handler */
 		*w = 0;
-		flush_icache_range((unsigned long)b, (unsigned long)(b+8));
+		local_flush_icache_range((unsigned long)b,
+					 (unsigned long)(b+8));
 	}
 
 	return (void *)old_handler;
@@ -1515,7 +1517,7 @@ void __cpuinit per_cpu_trap_init(void)
 void __init set_handler(unsigned long offset, void *addr, unsigned long size)
 {
 	memcpy((void *)(ebase + offset), addr, size);
-	flush_icache_range(ebase + offset, ebase + offset + size);
+	local_flush_icache_range(ebase + offset, ebase + offset + size);
 }
 
 static char panic_null_cerr[] __cpuinitdata =
@@ -1680,7 +1682,7 @@ void __init trap_init(void)
 	signal32_init();
 #endif
 
-	flush_icache_range(ebase, ebase + 0x400);
+	local_flush_icache_range(ebase, ebase + 0x400);
 	flush_tlb_handlers();
 
 	sort_extable(__start___dbe_table, __stop___dbe_table);
diff --git a/arch/mips/mm/c-r3k.c b/arch/mips/mm/c-r3k.c
index 27a5b46..5500c20 100644
--- a/arch/mips/mm/c-r3k.c
+++ b/arch/mips/mm/c-r3k.c
@@ -320,6 +320,7 @@ void __cpuinit r3k_cache_init(void)
 	flush_cache_range = r3k_flush_cache_range;
 	flush_cache_page = r3k_flush_cache_page;
 	flush_icache_range = r3k_flush_icache_range;
+	local_flush_icache_range = r3k_flush_icache_range;
 
 	flush_cache_sigtramp = r3k_flush_cache_sigtramp;
 	local_flush_data_cache_page = local_r3k_flush_data_cache_page;
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 71df339..6e99665 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -543,12 +543,8 @@ struct flush_icache_range_args {
 	unsigned long end;
 };
 
-static inline void local_r4k_flush_icache_range(void *args)
+static inline void local_r4k_flush_icache_range(unsigned long start, unsigned long end)
 {
-	struct flush_icache_range_args *fir_args = args;
-	unsigned long start = fir_args->start;
-	unsigned long end = fir_args->end;
-
 	if (!cpu_has_ic_fills_f_dc) {
 		if (end - start >= dcache_size) {
 			r4k_blast_dcache();
@@ -564,6 +560,15 @@ static inline void local_r4k_flush_icache_range(void *args)
 		protected_blast_icache_range(start, end);
 }
 
+static inline void local_r4k_flush_icache_range_ipi(void *args)
+{
+	struct flush_icache_range_args *fir_args = args;
+	unsigned long start = fir_args->start;
+	unsigned long end = fir_args->end;
+
+	local_r4k_flush_icache_range(start, end);
+}
+
 static void r4k_flush_icache_range(unsigned long start, unsigned long end)
 {
 	struct flush_icache_range_args args;
@@ -571,7 +576,7 @@ static void r4k_flush_icache_range(unsigned long start, unsigned long end)
 	args.start = start;
 	args.end = end;
 
-	r4k_on_each_cpu(local_r4k_flush_icache_range, &args, 1);
+	r4k_on_each_cpu(local_r4k_flush_icache_range_ipi, &args, 1);
 	instruction_hazard();
 }
 
@@ -1375,6 +1380,7 @@ void __cpuinit r4k_cache_init(void)
 	local_flush_data_cache_page	= local_r4k_flush_data_cache_page;
 	flush_data_cache_page	= r4k_flush_data_cache_page;
 	flush_icache_range	= r4k_flush_icache_range;
+	local_flush_icache_range	= local_r4k_flush_icache_range;
 
 #if defined(CONFIG_DMA_NONCOHERENT)
 	if (coherentio) {
diff --git a/arch/mips/mm/c-tx39.c b/arch/mips/mm/c-tx39.c
index a9f7f1f..39c8182 100644
--- a/arch/mips/mm/c-tx39.c
+++ b/arch/mips/mm/c-tx39.c
@@ -362,6 +362,7 @@ void __cpuinit tx39_cache_init(void)
 		flush_cache_range	= (void *) tx39h_flush_icache_all;
 		flush_cache_page	= (void *) tx39h_flush_icache_all;
 		flush_icache_range	= (void *) tx39h_flush_icache_all;
+		local_flush_icache_range = (void *) tx39h_flush_icache_all;
 
 		flush_cache_sigtramp	= (void *) tx39h_flush_icache_all;
 		local_flush_data_cache_page	= (void *) tx39h_flush_icache_all;
diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 034e850..1eb7c71 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -29,6 +29,7 @@ void (*flush_cache_range)(struct vm_area_struct *vma, unsigned long start,
 void (*flush_cache_page)(struct vm_area_struct *vma, unsigned long page,
 	unsigned long pfn);
 void (*flush_icache_range)(unsigned long start, unsigned long end);
+void (*local_flush_icache_range)(unsigned long start, unsigned long end);
 
 void (*__flush_cache_vmap)(void);
 void (*__flush_cache_vunmap)(void);
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 76da73a..979cf91 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -1273,10 +1273,10 @@ void __cpuinit build_tlb_refill_handler(void)
 
 void __cpuinit flush_tlb_handlers(void)
 {
-	flush_icache_range((unsigned long)handle_tlbl,
+	local_flush_icache_range((unsigned long)handle_tlbl,
 			   (unsigned long)handle_tlbl + sizeof(handle_tlbl));
-	flush_icache_range((unsigned long)handle_tlbs,
+	local_flush_icache_range((unsigned long)handle_tlbs,
 			   (unsigned long)handle_tlbs + sizeof(handle_tlbs));
-	flush_icache_range((unsigned long)handle_tlbm,
+	local_flush_icache_range((unsigned long)handle_tlbm,
 			   (unsigned long)handle_tlbm + sizeof(handle_tlbm));
 }
diff --git a/include/asm-mips/cacheflush.h b/include/asm-mips/cacheflush.h
index d5c0f2f..03b1d69 100644
--- a/include/asm-mips/cacheflush.h
+++ b/include/asm-mips/cacheflush.h
@@ -63,6 +63,7 @@ static inline void flush_icache_page(struct vm_area_struct *vma,
 }
 
 extern void (*flush_icache_range)(unsigned long start, unsigned long end);
+extern void (*local_flush_icache_range)(unsigned long start, unsigned long end);
 
 extern void (*__flush_cache_vmap)(void);
 
