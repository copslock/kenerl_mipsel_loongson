Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6EL9XRw014995
	for <linux-mips-outgoing@oss.sgi.com>; Sun, 14 Jul 2002 14:09:33 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6EL9X7h014994
	for linux-mips-outgoing; Sun, 14 Jul 2002 14:09:33 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from laposte.enst-bretagne.fr (laposte.enst-bretagne.fr [192.108.115.3])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6EL87Rw014971;
	Sun, 14 Jul 2002 14:08:07 -0700
Received: from resel.enst-bretagne.fr (UNKNOWN@maisel-gw.enst-bretagne.fr [192.44.76.8])
	by laposte.enst-bretagne.fr (8.11.6/8.11.6) with ESMTP id g6ELCdC12626;
	Sun, 14 Jul 2002 23:12:39 +0200
Received: from melkor (mail@melkor.maisel.enst-bretagne.fr [172.16.20.65])
	by resel.enst-bretagne.fr (8.12.3/8.12.3/Debian -4) with ESMTP id g6ELCZTF021330;
	Sun, 14 Jul 2002 23:12:35 +0200
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.35 #1 (Debian))
	id 17TqfS-0002gu-00; Sun, 14 Jul 2002 23:12:34 +0200
Date: Sun, 14 Jul 2002 23:12:34 +0200 (CEST)
From: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
X-Sender: glaurung@melkor
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Brian Murphy <brian@murphy.dk>, linux-mips@oss.sgi.com
Subject: [2.5 patch] R5K SC support
Message-ID: <Pine.LNX.4.21.0207142301110.8659-100000@melkor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-milter (http://amavis.org/) at enst-bretagne.fr
X-Spam-Status: No, hits=-5.0 required=5.0 tests=UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

	This patch adds support for the secondary cache controller in the
R5000 processors. It's quite similar to Brian Murphy's patch
(thanks BTW) except it's based on the current R4K code.
	There is code for variants with 16 bytes cache lines if they
exist.. if they don't just remove :)

Comments welcome,
Vivien.

diff -Naur linux/arch/mips64/mm/r4xx0.c linux.patch/arch/mips64/mm/r4xx0.c
--- linux/arch/mips64/mm/r4xx0.c	Mon Jul  8 22:26:10 2002
+++ linux.patch/arch/mips64/mm/r4xx0.c	Mon Jul  8 23:05:51 2002
@@ -736,6 +736,16 @@
 	blast_dcache32(); blast_icache32();
 }
 
+static inline void r5k_flush_cache_all_sXXd16i16(void)
+{
+	blast_dcache16(); blast_icache16(); r5k_blast_scache();
+}
+ 
+static inline void r5k_flush_cache_all_sXXd32i32(void)
+{
+ 	blast_dcache32(); blast_icache32(); r5k_blast_scache();
+}
+
 static void r4k_flush_cache_range_s16d16i16(struct vm_area_struct *vma,
 	unsigned long start, unsigned long end)
 {
@@ -1000,6 +1010,80 @@
 	}
 }
 
+static void r5k_flush_cache_range_sXXd16i16(struct vm_area_struct *vma,
+	unsigned long start, unsigned long end)
+{
+	struct mm_struct *mm = vma->vm_mm;
+
+	if (CPU_CONTEXT(smp_processor_id(), mm) == 0)
+		return;
+
+	blast_dcache16(); blast_icache16();
+
+	start &= PAGE_MASK;
+#ifdef DEBUG_CACHE
+	printk("crange[%d,%08lx,%08lx]", (int)mm->context, start, end);
+#endif
+	vma = find_vma(mm, start);
+	if(vma) {
+		if (CPU_CONTEXT(smp_processor_id(), mm) !=
+				CPU_CONTEXT(smp_processor_id(), current->mm)) {
+			r5k_flush_cache_all_sXXd16i16();
+		} else {
+			pgd_t *pgd;
+			pmd_t *pmd;
+			pte_t *pte;
+
+			while(start < end) {
+				pgd = pgd_offset(mm, start);
+				pmd = pmd_offset(pgd, start);
+				pte = pte_offset(pmd, start);
+
+				if(pte_val(*pte) & _PAGE_VALID)
+					r5k_blast_scache_page(start);
+				start += PAGE_SIZE;
+			}
+		}
+	}
+}
+
+static void r5k_flush_cache_range_sXXd32i32(struct vm_area_struct *vma,
+	unsigned long start, unsigned long end)
+{
+	struct mm_struct *mm = vma->vm_mm;
+
+	if (CPU_CONTEXT(smp_processor_id(), mm) == 0)
+		return;
+
+	blast_dcache32(); blast_icache32();
+
+	start &= PAGE_MASK;
+#ifdef DEBUG_CACHE
+	printk("crange[%d,%08lx,%08lx]", (int)mm->context, start, end);
+#endif
+	vma = find_vma(mm, start);
+	if(vma) {
+		if (CPU_CONTEXT(smp_processor_id(), mm) !=
+				CPU_CONTEXT(smp_processor_id(), current->mm)) {
+			r5k_flush_cache_all_sXXd32i32();
+		} else {
+			pgd_t *pgd;
+			pmd_t *pmd;
+			pte_t *pte;
+
+			while(start < end) {
+				pgd = pgd_offset(mm, start);
+				pmd = pmd_offset(pgd, start);
+				pte = pte_offset(pmd, start);
+
+				if(pte_val(*pte) & _PAGE_VALID)
+					r5k_blast_scache_page(start);
+				start += PAGE_SIZE;
+			}
+		}
+	}
+}
+
 /*
  * On architectures like the Sparc, we could get rid of lines in
  * the cache created only by a certain context, but on the MIPS
@@ -1095,6 +1179,26 @@
 	}
 }
 
+static void r5k_flush_cache_mm_sXXd16i16(struct mm_struct *mm)
+{
+	if (CPU_CONTEXT(smp_processor_id(), mm) != 0) {
+#ifdef DEBUG_CACHE
+		printk("cmm[%d]", (int)mm->context);
+#endif
+		r5k_flush_cache_all_sXXd16i16();
+	}
+}
+
+static void r5k_flush_cache_mm_sXXd32i32(struct mm_struct *mm)
+{
+	if (CPU_CONTEXT(smp_processor_id(), mm) != 0) {
+#ifdef DEBUG_CACHE
+		printk("cmm[%d]", (int)mm->context);
+#endif
+		r5k_flush_cache_all_sXXd32i32();
+	}
+}
+
 static void r4k_flush_cache_page_s16d16i16(struct vm_area_struct *vma,
 					   unsigned long page)
 {
@@ -1580,6 +1684,112 @@
 out:
 }
 
+static void r5k_flush_cache_page_sXXd16i16(struct vm_area_struct *vma,
+					   unsigned long page)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	pgd_t *pgdp;
+	pmd_t *pmdp;
+	pte_t *ptep;
+
+	/*
+	 * If ownes no valid ASID yet, cannot possibly have gotten
+	 * this page into the cache.
+	 */
+	if (CPU_CONTEXT(smp_processor_id(), mm) == 0)
+		return;
+
+#ifdef DEBUG_CACHE
+	printk("cpage[%d,%08lx]", (int)mm->context, page);
+#endif
+	page &= PAGE_MASK;
+	pgdp = pgd_offset(mm, page);
+	pmdp = pmd_offset(pgdp, page);
+	ptep = pte_offset(pmdp, page);
+
+	/* If the page isn't marked valid, the page cannot possibly be
+	 * in the cache.
+	 */
+	if(!(pte_val(*ptep) & _PAGE_VALID))
+		goto out;
+
+	/*
+	 * Doing flushes for another ASID than the current one is
+	 * too difficult since stupid R4k caches do a TLB translation
+	 * for every cache flush operation.  So we do indexed flushes
+	 * in that case, which doesn't overly flush the cache too much.
+	 */
+	if(mm == current->mm) {
+		blast_dcache16_page(page);
+		r5k_blast_scache_page(page);
+	} else {
+		/* Do indexed flush, too much work to get the (possible)
+		 * tlb refills to work correctly.
+		 */
+		unsigned long index;
+		index = KSEG0 + (page & (dcache_size - 1));
+		blast_dcache16_page_indexed(index);
+		blast_dcache16_page_indexed(index ^ dcache_waybit);
+		index = KSEG0 + (page & (scache_size - 1));
+		r5k_blast_scache_page(index);
+	}
+out:
+}
+
+static void r5k_flush_cache_page_sXXd32i32(struct vm_area_struct *vma,
+					   unsigned long page)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	pgd_t *pgdp;
+	pmd_t *pmdp;
+	pte_t *ptep;
+
+	/*
+	 * If ownes no valid ASID yet, cannot possibly have gotten
+	 * this page into the cache.
+	 */
+	if (CPU_CONTEXT(smp_processor_id(), mm) == 0)
+		return;
+
+#ifdef DEBUG_CACHE
+	printk("cpage[%d,%08lx]", (int)mm->context, page);
+#endif
+	page &= PAGE_MASK;
+	pgdp = pgd_offset(mm, page);
+	pmdp = pmd_offset(pgdp, page);
+	ptep = pte_offset(pmdp, page);
+
+	/*
+	 * If the page isn't marked valid, the page cannot possibly be
+	 * in the cache.
+	 */
+	if(!(pte_val(*ptep) & _PAGE_PRESENT))
+		goto out;
+
+	/*
+	 * Doing flushes for another ASID than the current one is
+	 * too difficult since stupid R4k caches do a TLB translation
+	 * for every cache flush operation.  So we do indexed flushes
+	 * in that case, which doesn't overly flush the cache too much.
+	 */
+	if((mm == current->mm) && (pte_val(*ptep) & _PAGE_VALID)) {
+		blast_dcache32_page(page);
+		r5k_blast_scache_page(page);
+	} else {
+		/*
+		 * Do indexed flush, too much work to get the (possible)
+		 * tlb refills to work correctly.
+		 */
+		unsigned long index;
+		index = KSEG0 + (page & (dcache_size - 1));
+		blast_dcache32_page_indexed(index);
+		blast_dcache32_page_indexed(index ^ dcache_waybit);
+		index = KSEG0 + (page & (scache_size - 1));
+		r5k_blast_scache_page(index);
+	}
+out:
+}
+
 static void r4k_flush_page_to_ram_s16(struct page *page)
 {
 	blast_scache16_page((unsigned long)page_address(page));
@@ -1610,6 +1820,19 @@
 	blast_dcache32_page((unsigned long)page_address(page));
 }
 
+static void r5k_flush_page_to_ram_sXXd16(struct page *page)
+{
+	blast_dcache16_page((unsigned long)page_address(page));
+	r5k_blast_scache_page((unsigned long)page_address(page));
+}
+
+static void r5k_flush_page_to_ram_sXXd32(struct page *page)
+{
+	blast_dcache32_page((unsigned long)page_address(page));
+	r5k_blast_scache_page((unsigned long)page_address(page));
+}
+
+
 static void
 r4k_flush_icache_range(unsigned long start, unsigned long end)
 {
@@ -1691,6 +1914,36 @@
 	}
 }
 
+static void r5k_dma_cache_wback_inv_sc(unsigned long addr, unsigned long size)
+{
+	unsigned long end, a;
+
+	if (size >= (unsigned long)dcache_size) {
+		flush_cache_l1();
+	} else {
+		a = addr & ~((unsigned long)dc_lsize - 1);
+		end = (addr + size) & ~((unsigned long)dc_lsize - 1);
+		while (1) {
+			flush_dcache_line(a); /* Hit_Writeback_Inv_D */
+			if (a == end) break;
+			a += dc_lsize;
+		}
+	}
+
+	if (size >= (unsigned long)scache_size) {
+		flush_cache_all();
+	} else {
+		unsigned long sc_psize = sc_lsize << 7;
+		a = addr & ~((unsigned long) sc_psize - 1);
+		end = (addr + size) & ~((unsigned long) sc_psize - 1);
+		while (1) {
+			flush_scache_page(a);	/* Page_Writeback_Inv_S */
+			if (a == end) break;
+			a += sc_psize;
+		}
+	}
+}
+
 static void r4k_dma_cache_inv_pc(unsigned long addr, unsigned long size)
 {
 	unsigned long end, a;
@@ -1734,6 +1987,37 @@
 	}
 }
 
+static void r5k_dma_cache_inv_sc(unsigned long addr, unsigned long size)
+{
+	unsigned long end, a;
+
+
+	if (size >= (unsigned long)dcache_size) {
+		flush_cache_l1();
+	} else {
+		a = addr & ~((unsigned long)dc_lsize - 1);
+		end = (addr + size) & ~((unsigned long)dc_lsize - 1);
+		while (1) {
+			flush_dcache_line(a); /* Hit_Writeback_Inv_D */
+			if (a == end) break;
+			a += dc_lsize;
+		}
+	}
+
+	if (size >= (unsigned long)scache_size) {
+		flush_cache_all();
+	} else {
+		unsigned long sc_psize = sc_lsize << 7;
+		a = addr & ~((unsigned long) sc_psize - 1);
+		end = (addr + size) & ~((unsigned long) sc_psize - 1);
+		while (1) {
+			flush_scache_page(a);	/* Page_Writeback_Inv_S */
+			if (a == end) break;
+			a += sc_psize;
+		}
+	}
+}
+
 static void r4k_dma_cache_wback(unsigned long addr, unsigned long size)
 {
 	panic("r4k_dma_cache called - should not happen.");
@@ -2016,23 +2300,21 @@
 	       dcache_size >> 10, dc_lsize);
 }
 
-
 /* If you even _breathe_ on this function, look at the gcc output
  * and make sure it does not pop things on and off the stack for
  * the cache sizing loop that executes in KSEG1 space or else
  * you will crash and burn badly.  You have been warned.
  */
+
 static int __init probe_scache(unsigned long config)
 {
 	extern unsigned long stext;
 	unsigned long flags, addr, begin, end, pow2;
 	int tmp;
 
-	tmp = ((config >> 17) & 1);
-	if(tmp)
+	if(config & CONF_SC)
 		return 0;
-	tmp = ((config >> 22) & 3);
-	switch(tmp) {
+	switch((config >> 22) & 3) {
 	case 0:
 		sc_lsize = 16;
 		break;
@@ -2047,41 +2329,55 @@
 		break;
 	}
 
-	begin = (unsigned long) &stext;
-	begin &= ~((4 * 1024 * 1024) - 1);
-	end = begin + (4 * 1024 * 1024);
-
-	/* This is such a bitch, you'd think they would make it
-	 * easy to do this.  Away you daemons of stupidity!
-	 */
-	__save_and_cli(flags);
-
-	/* Fill each size-multiple cache line with a valid tag. */
-	pow2 = (64 * 1024);
-	for(addr = begin; addr < end; addr = (begin + pow2)) {
-		unsigned long *p = (unsigned long *) addr;
-		__asm__ __volatile__("nop" : : "r" (*p)); /* whee... */
-		pow2 <<= 1;
-	}
-
-	/* Load first line with zero (therefore invalid) tag. */
-	set_taglo(0);
-	set_taghi(0);
-	__asm__ __volatile__("nop; nop; nop; nop;"); /* avoid the hazard */
-	__asm__ __volatile__("\n\t.set noreorder\n\t"
-			     "cache 8, (%0)\n\t"
-			     ".set reorder\n\t" : : "r" (begin));
-	__asm__ __volatile__("\n\t.set noreorder\n\t"
-			     "cache 9, (%0)\n\t"
-			     ".set reorder\n\t" : : "r" (begin));
-	__asm__ __volatile__("\n\t.set noreorder\n\t"
-			     "cache 11, (%0)\n\t"
-			     ".set reorder\n\t" : : "r" (begin));
-
-	/* Now search for the wrap around point. */
-	pow2 = (128 * 1024);
-	tmp = 0;
-	for(addr = (begin + (128 * 1024)); addr < (end); addr = (begin + pow2)) {
+	switch(mips_cpu.cputype) {
+	case CPU_R5000:
+	case CPU_NEVADA:
+	  /* R5000 are nice, they report the secondary cache size */
+	  scache_size = (512*1024) << ((config >> 20) & 3);
+	  if(!(config & CONF_SE)) {
+	      /* Turn the secondary cache on */
+	      __save_and_cli(flags);
+	      change_cp0_config(CONF_SE, CONF_SE);
+	      r5k_blast_scache();
+	      __restore_flags(flags);
+	  }
+	  break;
+	default:
+	  begin = (unsigned long) &stext;
+	  begin &= ~((4 * 1024 * 1024) - 1);
+	  end = begin + (4 * 1024 * 1024);
+
+	  /* This is such a bitch, you'd think they would make it
+	   * easy to do this.  Away you daemons of stupidity!
+	   */
+	  __save_and_cli(flags);
+
+	  /* Fill each size-multiple cache line with a valid tag. */
+	  pow2 = (64 * 1024);
+	  for(addr = begin; addr < end; addr = (begin + pow2)) {
+	    unsigned long *p = (unsigned long *) addr;
+	    __asm__ __volatile__("nop" : : "r" (*p)); /* whee... */
+	    pow2 <<= 1;
+	  }
+
+	  /* Load first line with zero (therefore invalid) tag. */
+	  set_taglo(0);
+	  set_taghi(0);
+	  __asm__ __volatile__("nop; nop; nop; nop;"); /* avoid the hazard */
+	  __asm__ __volatile__("\n\t.set noreorder\n\t"
+			       "cache 8, (%0)\n\t"
+			       ".set reorder\n\t" : : "r" (begin));
+	  __asm__ __volatile__("\n\t.set noreorder\n\t"
+			       "cache 9, (%0)\n\t"
+			       ".set reorder\n\t" : : "r" (begin));
+	  __asm__ __volatile__("\n\t.set noreorder\n\t"
+			       "cache 11, (%0)\n\t"
+			       ".set reorder\n\t" : : "r" (begin));
+
+	  /* Now search for the wrap around point. */
+	  pow2 = (128 * 1024);
+	  tmp = 0;
+	  for(addr = (begin + (128 * 1024)); addr < (end); addr = (begin + pow2)) {
 		__asm__ __volatile__("\n\t.set noreorder\n\t"
 				     "cache 7, (%0)\n\t"
 				     ".set reorder\n\t" : : "r" (addr));
@@ -2089,12 +2385,16 @@
 		if(!get_taglo())
 			break;
 		pow2 <<= 1;
+	  }
+	  __restore_flags(flags);
+	  addr -= begin;
+	  scache_size = addr;
+	  break;
 	}
-	__restore_flags(flags);
-	addr -= begin;
+
 	printk("Secondary cache sized at %dK linesize %d\n",
-	       (int) (addr >> 10), sc_lsize);
-	scache_size = addr;
+	       (int) (scache_size >> 10), sc_lsize);
+	
 	return 1;
 }
 
@@ -2146,7 +2446,7 @@
 	_dma_cache_inv = r4k_dma_cache_inv_pc;
 }
 
-static void __init setup_scache_funcs(void)
+static void __init r4k_setup_scache_funcs(void)
 {
 	switch(sc_lsize) {
 	case 16:
@@ -2235,6 +2535,43 @@
 	_dma_cache_inv = r4k_dma_cache_inv_sc;
 }
 
+static void __init r5k_setup_scache_funcs(void)
+{
+	switch(dc_lsize) {
+	case 16:
+		_clear_page = r4k_clear_page_d16;
+		_copy_page = r4k_copy_page_d16;
+		_flush_cache_all = r5k_flush_cache_all_sXXd16i16;
+		_flush_cache_l1 = r5k_flush_cache_all_sXXd16i16;
+		_flush_cache_mm = r5k_flush_cache_mm_sXXd16i16;
+		_flush_cache_range = r5k_flush_cache_range_sXXd16i16;
+		_flush_cache_page = r5k_flush_cache_page_sXXd16i16;
+		break;
+	case 32:
+		_clear_page = r4k_clear_page_d32;
+		_copy_page = r4k_copy_page_d32;
+		_flush_cache_all = r5k_flush_cache_all_sXXd32i32;
+		_flush_cache_l1 = r5k_flush_cache_all_sXXd32i32;
+		_flush_cache_mm = r5k_flush_cache_mm_sXXd32i32;
+		_flush_cache_range = r5k_flush_cache_range_sXXd32i32;
+		_flush_cache_page = r5k_flush_cache_page_sXXd32i32;
+		break;
+	}
+
+	switch(ic_lsize) {
+	case 16:
+		_flush_page_to_ram = r5k_flush_page_to_ram_sXXd16;
+		break;
+	case 32:
+		_flush_page_to_ram = r5k_flush_page_to_ram_sXXd32;
+		break;
+	}
+	_flush_icache_page = r4k_flush_icache_page_p;
+	_dma_cache_wback_inv = r5k_dma_cache_wback_inv_sc;
+	_dma_cache_wback = r4k_dma_cache_wback;
+	_dma_cache_inv = r5k_dma_cache_inv_sc;
+}
+
 typedef int (*probe_func_t)(unsigned long);
 
 static inline void __init setup_scache(unsigned int config)
@@ -2247,8 +2584,15 @@
 	sc_present = probe_scache_kseg1(config);
 
 	if (sc_present) {
-		setup_scache_funcs();
+	  switch(mips_cpu.cputype) {
+	  case CPU_R5000:
+	  case CPU_NEVADA:
+		r5k_setup_scache_funcs();
+		return;
+	  default:
+		r4k_setup_scache_funcs();
 		return;
+	  }
 	}
 
 	setup_noscache_funcs();
diff -Naur linux/include/asm-mips64/r4kcache.h linux.patch/include/asm-mips64/r4kcache.h
--- linux/include/asm-mips64/r4kcache.h	Sun Dec  9 15:52:27 2001
+++ linux.patch/include/asm-mips64/r4kcache.h	Sat Jul  6 23:05:09 2002
@@ -85,6 +85,7 @@
 		: "r" (addr), "i" (Hit_Invalidate_SD));
 }
 
+/* R4XX0 only */
 static inline void flush_scache_line(unsigned long addr)
 {
 	__asm__ __volatile__(
@@ -95,6 +96,19 @@
 		: "r" (addr), "i" (Hit_Writeback_Inv_SD));
 }
 
+/* R5000 only : flushes a 'cache page' of 128 lines */
+static inline void flush_scache_page(unsigned long page)
+{
+	__asm__ __volatile__(
+		".set noreorder\n\t"
+		"cache %1, (%0)\n\t"
+		".set reorder"
+		:
+		: "r" (page), "i" (Hit_Writeback_Inv_SD));
+}
+
+
+
 /*
  * The next two are for badland addresses like signal trampolines.
  */
@@ -488,6 +502,32 @@
 static inline void blast_scache128_page_indexed(unsigned long page)
 {
 	cache128_unroll32(page,Index_Writeback_Inv_SD);
+}
+
+
+static inline void r5k_blast_scache(void)
+{
+        unsigned long start = KSEG0;
+	unsigned long end = (start + scache_size);
+
+	set_taglo(0);
+	while(start < end) {
+	        flush_scache_page(start);
+		start += PAGE_SIZE;
+	}
+}
+
+static inline void r5k_blast_scache_page(page)
+{
+        unsigned long align = (sc_lsize << 7) - 1;
+        unsigned long start = page & (~align);
+        unsigned long end = (page + PAGE_SIZE + align) & (~align);
+
+	set_taglo(0);
+	while(start < end) {
+	        flush_scache_page(page);
+		start += sc_lsize << 7;
+	}
 }
 
 #endif /* __ASM_R4KCACHE_H */
diff -Naur linux/include/asm-mips64/r4kcacheops.h linux.patch/include/asm-mips64/r4kcacheops.h
--- linux/include/asm-mips64/r4kcacheops.h	Sun Dec  9 15:52:27 2001
+++ linux.patch/include/asm-mips64/r4kcacheops.h	Sat Jul  6 17:49:34 2002
@@ -17,6 +17,7 @@
 #define Index_Writeback_Inv_D   0x01
 #define Index_Invalidate_SI     0x02
 #define Index_Writeback_Inv_SD  0x03
+#define All_Writeback_Inv_S	0x03    /* R5000 only */
 #define Index_Load_Tag_I	0x04
 #define Index_Load_Tag_D	0x05
 #define Index_Load_Tag_SI	0x06
@@ -35,6 +36,7 @@
 #define Hit_Writeback_Inv_D	0x15
 					/* 0x16 is unused */
 #define Hit_Writeback_Inv_SD	0x17
+#define Page_Writeback_Inv_S	0x17    /* R5000 only */
 #define Hit_Writeback_I		0x18
 #define Hit_Writeback_D		0x19
 					/* 0x1a is unused */
diff -Naur linux/include/asm-mips64/mipsregs.h linux.patch/include/asm-mips64/mipsregs.h
--- linux/include/asm-mips64/mipsregs.h	Sun Dec  9 15:52:27 2001
+++ linux.patch/include/asm-mips64/mipsregs.h	Fri Dec 21 11:28:06 2001
@@ -367,6 +367,7 @@
 #define CONF_CM_CMASK			7
 #define CONF_DB				(1 <<  4)
 #define CONF_IB				(1 <<  5)
+#define CONF_SE				(1 << 12)
 #define CONF_SC				(1 << 17)
 #define CONF_AC                         (1 << 23)
 #define CONF_HALT                       (1 << 25)
