Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g76JbBRw008716
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 6 Aug 2002 12:37:11 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g76JbBco008715
	for linux-mips-outgoing; Tue, 6 Aug 2002 12:37:11 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from ubik.localnet (port48.ds1-vbr.adsl.cybercity.dk [212.242.58.113])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g76JaTRw008676
	for <linux-mips@oss.sgi.com>; Tue, 6 Aug 2002 12:36:30 -0700
Received: from murphy.dk (brm@brian.localnet [10.0.0.2])
	by ubik.localnet (8.12.3/8.12.3/Debian -4) with ESMTP id g76JcKui001857
	for <linux-mips@oss.sgi.com>; Tue, 6 Aug 2002 21:38:21 +0200
Message-ID: <3D5025AC.9020203@murphy.dk>
Date: Tue, 06 Aug 2002 21:38:20 +0200
From: Brian Murphy <brian@murphy.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-mips@oss.sgi.com
Subject: Re: [2.5 patch] R5K SC support
References: <Pine.LNX.4.21.0207142301110.8659-100000@melkor> <20020715144315.A4837@dea.linux-mips.net>
Content-Type: multipart/mixed;
 boundary="------------030806050001020409090604"
X-Spam-Status: No, hits=-4.0 required=5.0 tests=PORN_10,UNIFIED_PATCH,MISSING_HEADERS version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------030806050001020409090604
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Ralf Baechle wrote:

>>+static void r5k_dma_cache_wback_inv_sc(unsigned long addr, unsigned long size)
>>+static void r5k_dma_cache_inv_sc(unsigned long addr, unsigned long size)
>>
>
>You can hook the second level cache support into the bcache hook.  That's
>working because unlike the R4000SC the R5000's second level cache does not
>have the additional constraint of the primary caches always being a subset
>of the second level caches.
>
>Arch/mips/sgi-ip22/ip22-sc.c is an example how this can be done.
>
>
>
This is all very fine in theory but the R5000 cache routines are 
automatically
selected by the R4000 secondary setup routines which pick out the incorrect
flush_range function and wback_inv and inv functions. These do not call
board cache routines at all.

It must be that the secondary cache for the ip22 architecture with an R5000
is not flagged as having a secondary cache in a way that the R4000 
secondary
cache routines can detect.

On the other hand with the application of this (attached) patch the 
cache is
detected correctly and appropriate routines are selected.

/Brian

--------------030806050001020409090604
Content-Type: text/plain;
 name="r5k-sc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="r5k-sc.patch"

Index: arch/mips/mm/c-r4k.c
===================================================================
RCS file: /cvs/linux-mips/arch/mips/mm/c-r4k.c,v
retrieving revision 1.1
retrieving revision 1.2
diff -u -r1.1 -r1.2
--- arch/mips/mm/c-r4k.c	18 Jul 2002 17:35:18 -0000	1.1
+++ arch/mips/mm/c-r4k.c	18 Jul 2002 17:41:34 -0000	1.2
@@ -36,6 +36,7 @@
 
 /* Secondary cache (if present) parameters. */
 static unsigned int scache_size, sc_lsize;	/* Again, in bytes */
+static int sc_present = 0;
 
 #include <asm/cacheops.h>
 #include <asm/r4kcache.h>
@@ -1195,6 +1196,126 @@
 #endif
 }
 
+static void r5k_flush_cache_range(struct mm_struct *mm,
+				  unsigned long start,
+				  unsigned long end)
+{
+	struct vm_area_struct *vma;
+	unsigned long flags;
+
+	if (mm->context == 0)
+		return;
+
+	start &= PAGE_MASK;
+#ifdef DEBUG_CACHE
+	printk("crange[%d,%08lx,%08lx]", (int)mm->context, start, end);
+#endif
+	vma = find_vma(mm, start);
+	if (vma) {
+		if (mm->context != current->active_mm->context) {
+			_flush_cache_all();
+		} else {
+			pgd_t *pgd;
+			pmd_t *pmd;
+			pte_t *pte;
+			int text;
+
+			__save_and_cli(flags);
+			text = vma->vm_flags & VM_EXEC;
+			while (start < end) {
+				pgd = pgd_offset(mm, start);
+				pmd = pmd_offset(pgd, start);
+				pte = pte_offset(pmd, start);
+
+				if (pte_val(*pte) & _PAGE_VALID) {
+					blast_dcache32_page(start);
+					if (text)
+						blast_icache32_page(start);
+				}
+				start += PAGE_SIZE;
+			}
+			__restore_flags(flags);
+		}
+	}
+}
+
+static void
+r5k_dma_cache_inv_sc(unsigned long addr, unsigned long size)
+{
+	unsigned long end, a;
+
+	if (size >= scache_size) {
+		blast_r5000_scache();
+		return;
+	}
+
+	/* We assume the address is in KSEG0. On the R5000 we
+	 * cannot invalidate less than a page at a time, and
+	 * there is no Hit_xxx cache operations.
+	 */
+	a = addr & ~(PAGE_SIZE - 1);
+	end = (addr + size - 1) & ~(PAGE_SIZE - 1);
+	while (a <= end) {
+		blast_r5000_scache_page_indexed(a);	/* Page_Invalidate */
+		a += PAGE_SIZE;
+	}
+}
+
+static void
+r5k_dma_cache_wback_inv(unsigned long addr, unsigned long size)
+{
+	unsigned long end, a;
+
+	if (size >= dcache_size) {
+		blast_dcache32();
+	} else {
+		a = addr & ~(dc_lsize - 1);
+		end = (addr + size - 1) & ~(dc_lsize - 1);
+		while (a <= end) {
+			flush_dcache_line(a); /* Hit_Writeback_Inv_D */
+			a += dc_lsize;
+		}
+	}
+	if (sc_present)
+		r5k_dma_cache_inv_sc(addr, size);
+}
+
+static void
+r5k_dma_cache_inv(unsigned long addr, unsigned long size)
+{
+	unsigned long end, a;
+
+	if (size >= dcache_size) {
+		blast_dcache32();
+	} else {
+		a = addr & ~(dc_lsize - 1);
+		end = (addr + size - 1) & ~(dc_lsize - 1);
+		while (a <= end) {
+			invalidate_dcache_line(a); /* Hit_Invalidate_D */
+			a += dc_lsize;
+		}
+	}
+	if (sc_present)
+		r5k_dma_cache_inv_sc(addr, size);
+}
+
+static void
+r5k_dma_cache_wback(unsigned long addr, unsigned long size)
+{
+	unsigned long end, a;
+
+	if (size >= dcache_size) {
+		blast_dcache32();
+	} else {
+		a = addr & ~(dc_lsize - 1);
+		end = (addr + size - 1) & ~(dc_lsize - 1);
+		while (a <= end) {
+			flush_dcache_line_wb(a); /* Hit_Writeback_D */
+			a += dc_lsize;
+		}
+	}
+}
+
 /* Detect and size the various r4k caches. */
 static void __init probe_icache(unsigned long config)
 {
@@ -1374,7 +1495,7 @@
 	_dma_cache_inv = r4k_dma_cache_inv_pc;
 }
 
-static void __init setup_scache_funcs(void)
+static void __init setup_scache_funcs_r4k(void)
 {
 	switch(sc_lsize) {
 	case 16:
@@ -1457,19 +1578,36 @@
 	_dma_cache_inv = r4k_dma_cache_inv_sc;
 }
 
+static void __init setup_scache_funcs_r5k(void) {
+	_clear_page = r4k_clear_page_d32;
+	_copy_page = r4k_copy_page_d32;
+	_flush_cache_all = r4k_flush_cache_all_d32i32;
+	_flush_cache_range = r5k_flush_cache_range;
+	_flush_cache_mm = r4k_flush_cache_mm_d32i32;
+	_flush_page_to_ram = r4k_flush_page_to_ram_d32;
+
+	___flush_cache_all = _flush_cache_all;
+	_flush_icache_page = r4k_flush_icache_page_p;
+	_dma_cache_wback_inv = r5k_dma_cache_wback_inv;
+	_dma_cache_wback = r5k_dma_cache_wback;
+	_dma_cache_inv = r5k_dma_cache_inv;
+}
+
 typedef int (*probe_func_t)(unsigned long);
 
 static inline void __init setup_scache(unsigned int config)
 {
 	probe_func_t probe_scache_kseg1;
-	int sc_present = 0;
 
 	/* Maybe the cpu knows about a l2 cache? */
 	probe_scache_kseg1 = (probe_func_t) (KSEG1ADDR(&probe_scache));
 	sc_present = probe_scache_kseg1(config);
 
 	if (sc_present) {
-		setup_scache_funcs();
+		if (mips_cpu.cputype == CPU_R5000)
+			setup_scache_funcs_r5k();
+		else
+			setup_scache_funcs_r4k();
 		return;
 	}
 
Index: include/asm-mips/r4kcache.h
===================================================================
RCS file: /cvs/linux-mips/include/asm-mips/r4kcache.h,v
retrieving revision 1.1
retrieving revision 1.2
diff -u -r1.1 -r1.2
--- include/asm-mips/r4kcache.h	18 Jul 2002 17:34:01 -0000	1.1
+++ include/asm-mips/r4kcache.h	18 Jul 2002 17:41:35 -0000	1.2
@@ -76,6 +76,19 @@
 		  "i" (Hit_Writeback_Inv_D));
 }
 
+extern inline void flush_dcache_line_wb(unsigned long addr)
+{
+	__asm__ __volatile__(
+		".set noreorder\n\t"
+		".set mips3\n\t"
+		"cache %1, (%0)\n\t"
+		".set mips0\n\t"
+		".set reorder"
+		:
+		: "r" (addr),
+		  "i" (Hit_Writeback_D));
+}
+
 static inline void invalidate_dcache_line(unsigned long addr)
 {
 	__asm__ __volatile__(
@@ -606,6 +619,40 @@
 static inline void blast_scache128_page_indexed(unsigned long page)
 {
 	cache128_unroll32(page,Index_Writeback_Inv_SD);
+}
+
+
+#define cache_unroll(base,op)	        	\
+	__asm__ __volatile__("	         	\
+		.set noreorder;		        \
+		.set mips3;		        \
+                cache %1, (%0);	                \
+		.set mips0;			\
+		.set reorder"			\
+		:				\
+		: "r" (base),			\
+		  "i" (op));
+
+extern inline void blast_r5000_scache(void)
+{
+	unsigned long start = KSEG0;
+	unsigned long end = KSEG0 + scache_size;
+
+	while(start < end) {
+		cache_unroll(start,Page_Invalidate);
+		start += 128*sc_lsize;
+	}
+}
+
+extern inline void blast_r5000_scache_page_indexed(unsigned long page)
+{
+	unsigned long start = page;
+	unsigned long end = page + PAGE_SIZE;
+
+	while(start < end) {
+		cache_unroll(start,Page_Invalidate);
+		start += 128*sc_lsize;
+	}
 }
 
 #endif /* !(_MIPS_R4KCACHE_H) */

--------------030806050001020409090604--
