Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2003 03:50:32 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:17717 "EHLO
	trasno.mitica") by linux-mips.org with ESMTP id <S8225219AbTCMDuM>;
	Thu, 13 Mar 2003 03:50:12 +0000
Received: by trasno.mitica (Postfix, from userid 1001)
	id 3A2FE6EE; Thu, 13 Mar 2003 04:50:11 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: 2/2 remove flush_cache_l1/l2
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: Thu, 13 Mar 2003 04:50:11 +0100
Message-ID: <861y1c6i30.fsf@trasno.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1716
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi

__flush_cache_all is enough for the uses that flush_cache_l1/l2 had.

Later, Juan.

 build/arch/mips/sgi-ip27/ip27-init.c    |    6 +----
 build/arch/mips64/kernel/mips64_ksyms.c |    5 ----
 build/arch/mips64/kernel/syscall.c      |    2 -
 build/arch/mips64/mm/c-andes.c          |   38 ++++++++++++++------------------
 build/arch/mips64/mm/c-mips64.c         |    3 --
 build/arch/mips64/mm/c-r4k.c            |   15 ------------
 build/arch/mips64/mm/c-sb1.c            |    1 
 build/arch/mips64/mm/init.c             |    2 -
 build/arch/mips64/mm/loadmmu.c          |    5 ----
 build/include/asm-mips64/pgtable.h      |   10 --------
 10 files changed, 23 insertions(+), 64 deletions(-)

diff -puN build/include/asm-mips64/pgtable.h~remove_flush_cache_l12 build/include/asm-mips64/pgtable.h
--- 24/build/include/asm-mips64/pgtable.h~remove_flush_cache_l12	2003-03-13 04:35:38.000000000 +0100
+++ 24-quintela/build/include/asm-mips64/pgtable.h	2003-03-13 04:35:38.000000000 +0100
@@ -41,11 +41,6 @@ extern void (*_flush_icache_page)(struct
 extern void (*_flush_cache_sigtramp)(unsigned long addr);
 extern void (*_flush_icache_all)(void);
 
-/* These suck ...  */
-extern void (*_flush_cache_l2)(void);
-extern void (*_flush_cache_l1)(void);
-
-
 #define flush_page_to_ram(page)		do { } while(0)
 
 #define flush_cache_all()		_flush_cache_all()
@@ -65,7 +60,7 @@ extern void (*_flush_cache_l1)(void);
 #define flush_cache_range(mm,start,end)	do { } while(0)
 #define flush_cache_page(vma,page)	do { } while(0)
 #define flush_dcache_page(page)		do { } while(0)
-#define flush_icache_range(start, end)	_flush_cache_l1()
+#define flush_icache_range(start, end)	_flush_icache_range(start, end)
 #define flush_icache_user_range(vma, page, addr, len) \
 	flush_icache_page((vma), (page))
 #define flush_icache_page(vma, page)	_flush_icache_page(vma, page)
@@ -90,9 +85,6 @@ extern void (*_flush_cache_l1)(void);
 #define flush_icache_all()		do { } while(0)
 #endif
 
-#define flush_cache_l2()		_flush_cache_l2()
-#define flush_cache_l1()		_flush_cache_l1()
-
 /*
  * This flag is used to indicate that the page pointed to by a pte
  * is dirty and requires cleaning before returning it to the user.
diff -puN build/arch/mips64/mm/c-andes.c~remove_flush_cache_l12 build/arch/mips64/mm/c-andes.c
--- 24/build/arch/mips64/mm/c-andes.c~remove_flush_cache_l12	2003-03-13 04:35:38.000000000 +0100
+++ 24-quintela/build/arch/mips64/mm/c-andes.c	2003-03-13 04:45:26.000000000 +0100
@@ -29,28 +29,20 @@ static void andes_flush_cache_l1(void)
 	blast_dcache32(); blast_icache64();
 }
 
-/*
- * This is only used during initialization time. vmalloc() also calls
- * this, but that will be changed pretty soon.
- */
-static void andes_flush_cache_l2_64(void)
-{
-	blast_scache64();
-}
-
-static void andes_flush_cache_l2_128(void)
+static void andes_flush_cache_all(void)
 {
-	blast_scache128();
 }
 
-static void andes_flush_cache_all(void)
+static void andes___flush_cache_all64(void)
 {
+	blast_dcache32(); blast_icache64();
+	blast_scache64();
 }
 
-static void andes___flush_cache_all(void)
+static void andes___flush_cache_all128(void)
 {
-	andes_flush_cache_l1();
-	flush_cache_l2();
+	blast_dcache32(); blast_icache64();
+	blast_scache128();
 }
 
 /*
@@ -81,7 +73,13 @@ static void andes_flush_icache_page128(s
 
 	pfn = (unsigned long)phys_to_virt(page_to_phys(page));
 	blast_scache128_page(pfn);
- }
+}
+
+static void andes_flush_icache_range(unsigned long start,
+	unsigned long end)
+{
+	blast_icache64();
+}
 
 static void andes_flush_cache_sigtramp(unsigned long addr)
 {
@@ -108,17 +106,15 @@ void __init ld_mmu_andes(void)
 	_copy_page = andes_copy_page;
 
 	_flush_cache_all = andes_flush_cache_all;
-	___flush_cache_all = andes___flush_cache_all;
-	_flush_cache_l1 = andes_flush_cache_l1;
 	_flush_cache_sigtramp = andes_flush_cache_sigtramp;
 
 	if (sc_lsize() == 64) {
-		_flush_cache_l2 = andes_flush_cache_l2_64;
+		___flush_cache_all = andes___flush_cache_all64;
 		_flush_icache_page = andes_flush_icache_page64;
 	} else {
-		_flush_cache_l2 = andes_flush_cache_l2_128;
+		___flush_cache_all = andes___flush_cache_all128;
 		_flush_icache_page = andes_flush_icache_page128;
 	}
 
-	flush_cache_l1();
+	__flush_cache_all();
 }
diff -puN build/arch/mips64/mm/c-mips64.c~remove_flush_cache_l12 build/arch/mips64/mm/c-mips64.c
--- 24/build/arch/mips64/mm/c-mips64.c~remove_flush_cache_l12	2003-03-13 04:35:38.000000000 +0100
+++ 24-quintela/build/arch/mips64/mm/c-mips64.c	2003-03-13 04:35:38.000000000 +0100
@@ -713,8 +713,7 @@ void __init ld_mmu_mips64(void)
 	_flush_cache_sigtramp = mips64_flush_cache_sigtramp;
 	_flush_icache_range = mips64_flush_icache_range;	/* Ouch */
 	_flush_icache_all = mips64_flush_icache_all;
-	_flush_cache_l1 = _flush_cache_all;
-	_flush_cache_l2 = _flush_cache_all;
+	_flush_cache_all = _flush_cache_all;
 
 	__flush_cache_all();
 }
diff -puN build/arch/mips64/mm/loadmmu.c~remove_flush_cache_l12 build/arch/mips64/mm/loadmmu.c
--- 24/build/arch/mips64/mm/loadmmu.c~remove_flush_cache_l12	2003-03-13 04:35:38.000000000 +0100
+++ 24-quintela/build/arch/mips64/mm/loadmmu.c	2003-03-13 04:35:38.000000000 +0100
@@ -36,11 +36,6 @@ void (*_flush_icache_range)(unsigned lon
 void (*_flush_icache_page)(struct vm_area_struct *vma, struct page *page);
 void (*_flush_icache_all)(void);
 
-/* MIPS specific cache operations */
-void (*_flush_cache_l2)(void);
-void (*_flush_cache_l1)(void);
-
-
 /* DMA cache operations. */
 void (*_dma_cache_wback_inv)(unsigned long start, unsigned long size);
 void (*_dma_cache_wback)(unsigned long start, unsigned long size);
diff -puN build/arch/mips64/mm/init.c~remove_flush_cache_l12 build/arch/mips64/mm/init.c
--- 24/build/arch/mips64/mm/init.c~remove_flush_cache_l12	2003-03-13 04:35:38.000000000 +0100
+++ 24-quintela/build/arch/mips64/mm/init.c	2003-03-13 04:41:44.000000000 +0100
@@ -114,7 +114,7 @@ int do_check_pgt_cache(int low, int high
 asmlinkage int sys_cacheflush(void *addr, int bytes, int cache)
 {
 	/* XXX Just get it working for now... */
-	flush_cache_l1();
+	__flush_cache_all();
 	return 0;
 }
 
diff -puN build/arch/mips64/kernel/mips64_ksyms.c~remove_flush_cache_l12 build/arch/mips64/kernel/mips64_ksyms.c
--- 24/build/arch/mips64/kernel/mips64_ksyms.c~remove_flush_cache_l12	2003-03-13 04:35:38.000000000 +0100
+++ 24-quintela/build/arch/mips64/kernel/mips64_ksyms.c	2003-03-13 04:35:38.000000000 +0100
@@ -79,11 +79,6 @@ EXPORT_SYMBOL_NOVERS(__strnlen_user_asm)
 /* Networking helper routines. */
 EXPORT_SYMBOL(csum_partial_copy);
 
-/*
- * Functions to control caches.
- */
-EXPORT_SYMBOL(_flush_cache_l1);
-
 #ifdef CONFIG_NONCOHERENT_IO
 EXPORT_SYMBOL(_dma_cache_wback_inv);
 EXPORT_SYMBOL(_dma_cache_inv);
diff -puN build/arch/mips64/kernel/syscall.c~remove_flush_cache_l12 build/arch/mips64/kernel/syscall.c
--- 24/build/arch/mips64/kernel/syscall.c~remove_flush_cache_l12	2003-03-13 04:35:38.000000000 +0100
+++ 24-quintela/build/arch/mips64/kernel/syscall.c	2003-03-13 04:42:29.000000000 +0100
@@ -221,7 +221,7 @@ asmlinkage int sys_sysmips(int cmd, long
 		return 0;
 
 	case FLUSH_CACHE:
-		flush_cache_l2();
+		__flush_cache_all();
 		return 0;
 
 	case MIPS_RDNVRAM:
diff -puN build/arch/mips64/mm/c-r4k.c~remove_flush_cache_l12 build/arch/mips64/mm/c-r4k.c
--- 24/build/arch/mips64/mm/c-r4k.c~remove_flush_cache_l12	2003-03-13 04:35:38.000000000 +0100
+++ 24-quintela/build/arch/mips64/mm/c-r4k.c	2003-03-13 04:35:38.000000000 +0100
@@ -1079,10 +1079,6 @@ static void r4600v20k_flush_cache_sigtra
 #endif
 }
 
-static void r4k_flush_cache_l2(void)
-{
-}
-
 void __update_cache(struct vm_area_struct *vma, unsigned long address,
 	pte_t pte)
 {
@@ -1225,7 +1221,6 @@ static void __init setup_noscache_funcs(
 		_clear_page = r4k_clear_page_d16;
 		_copy_page = r4k_copy_page_d16;
 		_flush_cache_all = r4k_flush_cache_all_d16i16;
-		_flush_cache_l1 = r4k_flush_cache_all_d16i16;
 		_flush_cache_mm = r4k_flush_cache_mm_d16i16;
 		_flush_cache_range = r4k_flush_cache_range_d16i16;
 		_flush_cache_page = r4k_flush_cache_page_d16i16;
@@ -1243,7 +1238,6 @@ static void __init setup_noscache_funcs(
 			_copy_page = r4k_copy_page_d32;
 		}
 		_flush_cache_all = r4k_flush_cache_all_d32i32;
-		_flush_cache_l1 = r4k_flush_cache_all_d32i32;
 		_flush_cache_mm = r4k_flush_cache_mm_d32i32;
 		_flush_cache_range = r4k_flush_cache_range_d32i32;
 		_flush_cache_page = r4k_flush_cache_page_d32i32;
@@ -1265,7 +1259,6 @@ static void __init setup_scache_funcs(vo
 		switch (dc_lsize) {
 		case 16:
 			_flush_cache_all = r4k_flush_cache_all_s16d16i16;
-			_flush_cache_l1 = r4k_flush_cache_all_s16d16i16;
 			_flush_cache_mm = r4k_flush_cache_mm_s16d16i16;
 			_flush_cache_range = r4k_flush_cache_range_s16d16i16;
 			_flush_cache_page = r4k_flush_cache_page_s16d16i16;
@@ -1280,14 +1273,12 @@ static void __init setup_scache_funcs(vo
 		switch (dc_lsize) {
 		case 16:
 			_flush_cache_all = r4k_flush_cache_all_s32d16i16;
-			_flush_cache_l1 = r4k_flush_cache_all_s32d16i16;
 			_flush_cache_mm = r4k_flush_cache_mm_s32d16i16;
 			_flush_cache_range = r4k_flush_cache_range_s32d16i16;
 			_flush_cache_page = r4k_flush_cache_page_s32d16i16;
 			break;
 		case 32:
 			_flush_cache_all = r4k_flush_cache_all_s32d32i32;
-			_flush_cache_l1 = r4k_flush_cache_all_s32d32i32;
 			_flush_cache_mm = r4k_flush_cache_mm_s32d32i32;
 			_flush_cache_range = r4k_flush_cache_range_s32d32i32;
 			_flush_cache_page = r4k_flush_cache_page_s32d32i32;
@@ -1300,14 +1291,12 @@ static void __init setup_scache_funcs(vo
 		switch (dc_lsize) {
 		case 16:
 			_flush_cache_all = r4k_flush_cache_all_s64d16i16;
-			_flush_cache_l1 = r4k_flush_cache_all_s64d16i16;
 			_flush_cache_mm = r4k_flush_cache_mm_s64d16i16;
 			_flush_cache_range = r4k_flush_cache_range_s64d16i16;
 			_flush_cache_page = r4k_flush_cache_page_s64d16i16;
 			break;
 		case 32:
 			_flush_cache_all = r4k_flush_cache_all_s64d32i32;
-			_flush_cache_l1 = r4k_flush_cache_all_s64d32i32;
 			_flush_cache_mm = r4k_flush_cache_mm_s64d32i32;
 			_flush_cache_range = r4k_flush_cache_range_s64d32i32;
 			_flush_cache_page = r4k_flush_cache_page_s64d32i32;
@@ -1320,14 +1309,12 @@ static void __init setup_scache_funcs(vo
 		switch (dc_lsize) {
 		case 16:
 			_flush_cache_all = r4k_flush_cache_all_s128d16i16;
-			_flush_cache_l1 = r4k_flush_cache_all_s128d16i16;
 			_flush_cache_mm = r4k_flush_cache_mm_s128d16i16;
 			_flush_cache_range = r4k_flush_cache_range_s128d16i16;
 			_flush_cache_page = r4k_flush_cache_page_s128d16i16;
 			break;
 		case 32:
 			_flush_cache_all = r4k_flush_cache_all_s128d32i32;
-			_flush_cache_l1 = r4k_flush_cache_all_s128d32i32;
 			_flush_cache_mm = r4k_flush_cache_mm_s128d32i32;
 			_flush_cache_range = r4k_flush_cache_range_s128d32i32;
 			_flush_cache_page = r4k_flush_cache_page_s128d32i32;
@@ -1408,7 +1395,5 @@ void __init ld_mmu_r4xx0(void)
 	_flush_dcache_page = r4k_flush_dcache_page;
 	_flush_icache_range = r4k_flush_icache_range;	/* Ouch */
 
-	_flush_cache_l2 = r4k_flush_cache_l2;
-
 	__flush_cache_all();
 }
diff -puN build/arch/mips/sgi-ip27/ip27-init.c~remove_flush_cache_l12 build/arch/mips/sgi-ip27/ip27-init.c
--- 24/build/arch/mips/sgi-ip27/ip27-init.c~remove_flush_cache_l12	2003-03-13 04:35:38.000000000 +0100
+++ 24-quintela/build/arch/mips/sgi-ip27/ip27-init.c	2003-03-13 04:43:47.000000000 +0100
@@ -332,8 +332,7 @@ void per_hub_init(cnodeid_t cnode)
 			memcpy((void *)(KSEG0 + 0x100), (void *) KSEG0, 0x80);
 			memcpy((void *)(KSEG0 + 0x180), &except_vec3_generic,
 								0x100);
-			flush_cache_l1();
-			flush_cache_l2();
+			__flush_cache_all();
 		}
 #endif
 	}
@@ -432,8 +431,7 @@ void __init start_secondary(void)
 	init_mfhi_war();
 #endif
 	local_flush_tlb_all();
-	flush_cache_l1();
-	flush_cache_l2();
+	__flush_cache_all();
 
 	local_irq_enable();
 #if 0
diff -puN build/arch/mips64/mm/c-sb1.c~remove_flush_cache_l12 build/arch/mips64/mm/c-sb1.c
--- 24/build/arch/mips64/mm/c-sb1.c~remove_flush_cache_l12	2003-03-13 04:35:38.000000000 +0100
+++ 24-quintela/build/arch/mips64/mm/c-sb1.c	2003-03-13 04:35:38.000000000 +0100
@@ -522,7 +522,6 @@ void ld_mmu_sb1(void)
 
 	/* Full flushes */
 	___flush_cache_all = sb1___flush_cache_all;
-	_flush_cache_l1 = sb1___flush_cache_all;
 
 	change_c0_config(CONF_CM_CMASK, CONF_CM_DEFAULT);
 	/*

_


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
