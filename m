Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9ODZkd09973
	for linux-mips-outgoing; Wed, 24 Oct 2001 06:35:46 -0700
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9ODXnD09916;
	Wed, 24 Oct 2001 06:33:49 -0700
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 24 Oct 2001 13:33:49 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id D2D4BB46B; Wed, 24 Oct 2001 22:33:47 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id WAA18573; Wed, 24 Oct 2001 22:33:47 +0900 (JST)
Date: Wed, 24 Oct 2001 22:38:37 +0900 (JST)
Message-Id: <20011024.223837.59648049.nemoto@toshiba-tops.co.jp>
To: linux-mips@oss.sgi.com
Cc: ralf@oss.sgi.com
Subject: TX39/TX49 CPU support
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
X-Mailer: Mew version 2.0 on Emacs 20.7 / Mule 4.1 (AOI)
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Wed_Oct_24_22:38:37_2001_909)--"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

----Next_Part(Wed_Oct_24_22:38:37_2001_909)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I cleaned up TOSHIBA TX39/TX49 CPU support code and create a patch
against current CVS.  Recent changes in CVS makes this patch smaller
then ever.

This patch supports TX4955, TX4927, TX3927.  TX49XX CPUs have 4 way
set associative cache with 32 byte cacheline.  TX3927 have 2 way set
associative cache with 16 byte cacheline.  This patch also contains
some fix for TX4300 (Vr4300).

There are already some TX39 codes in arch/mips/mm/, it seems just for
TX39H CPUs.  This patch includes codes for TX39H2 CPUs.

I newly defined CONFIG_CPU_TX39XX (and CONFIG_CPU_TX49XX) but did not
removed TX39 codes from CONFIG_CPU_R3000 section.  If nobody wants to
link TX39 codes and R3000 codes into a single kernel image, TX39
codes in CONFIG_CPU_R3000 section can be removed.

I think this patch does not break anything in existing code.  Please
apply to CVS.  Thank you.

---
Atsushi Nemoto

----Next_Part(Wed_Oct_24_22:38:37_2001_909)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="tx.patch"

diff -urP -x CVS -x .cvsignore linux-sgi-cvs/arch/mips/Makefile linux.new/arch/mips/Makefile
--- linux-sgi-cvs/arch/mips/Makefile	Mon Oct 22 10:29:55 2001
+++ linux.new/arch/mips/Makefile	Wed Oct 24 21:26:39 2001
@@ -50,6 +50,9 @@
 ifdef CONFIG_CPU_R3000
 GCCFLAGS	+= -mcpu=r3000 -mips1
 endif
+ifdef CONFIG_CPU_TX39XX
+GCCFLAGS	+= -mcpu=r3000 -mips1
+endif
 ifdef CONFIG_CPU_R6000
 GCCFLAGS	+= -mcpu=r6000 -mips2 -Wa,--trap
 endif
@@ -60,6 +63,9 @@
 GCCFLAGS	+= -mcpu=r4600 -mips2 -Wa,--trap
 endif
 ifdef CONFIG_CPU_R4X00
+GCCFLAGS	+= -mcpu=r4600 -mips2 -Wa,--trap
+endif
+ifdef CONFIG_CPU_TX49XX
 GCCFLAGS	+= -mcpu=r4600 -mips2 -Wa,--trap
 endif
 ifdef CONFIG_CPU_MIPS32
diff -urP -x CVS -x .cvsignore linux-sgi-cvs/arch/mips/config.in linux.new/arch/mips/config.in
--- linux-sgi-cvs/arch/mips/config.in	Mon Oct 22 10:29:55 2001
+++ linux.new/arch/mips/config.in	Wed Oct 24 21:31:15 2001
@@ -246,10 +246,12 @@
 
 choice 'CPU type' \
 	"R3000 CONFIG_CPU_R3000	\
+	 R39XX CONFIG_CPU_TX39XX	\
 	 R6000 CONFIG_CPU_R6000	\
 	 R41xx CONFIG_CPU_VR41XX \
 	 R4300 CONFIG_CPU_R4300	\
 	 R4x00 CONFIG_CPU_R4X00	\
+	 R49XX CONFIG_CPU_TX49XX	\
 	 R5000 CONFIG_CPU_R5000	\
 	 R5432 CONFIG_CPU_R5432 \
 	 RM7000 CONFIG_CPU_RM7000 \
diff -urP -x CVS -x .cvsignore linux-sgi-cvs/arch/mips/kernel/gdb-low.S linux.new/arch/mips/kernel/gdb-low.S
--- linux-sgi-cvs/arch/mips/kernel/gdb-low.S	Mon Sep 10 02:43:01 2001
+++ linux.new/arch/mips/kernel/gdb-low.S	Wed Oct 24 21:33:11 2001
@@ -304,7 +304,7 @@
 		lw	v1,GDB_FR_REG3(sp)
 		lw	v0,GDB_FR_REG2(sp)
 		lw	$1,GDB_FR_REG1(sp)
-#ifdef CONFIG_CPU_R3000
+#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
 		lw	k0, GDB_FR_EPC(sp)
 		lw	sp, GDB_FR_REG29(sp)		/* Deallocate stack */
 		jr	k0
diff -urP -x CVS -x .cvsignore linux-sgi-cvs/arch/mips/kernel/setup.c linux.new/arch/mips/kernel/setup.c
--- linux-sgi-cvs/arch/mips/kernel/setup.c	Mon Oct 22 10:29:56 2001
+++ linux.new/arch/mips/kernel/setup.c	Wed Oct 24 21:42:22 2001
@@ -199,6 +199,12 @@
                         mips_cpu.options = R4K_OPTS;
                         mips_cpu.tlbsize = 32;
                         break;
+		case PRID_IMP_R4300:
+			mips_cpu.cputype = CPU_R4300;
+			mips_cpu.isa_level = MIPS_CPU_ISA_III;
+			mips_cpu.options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_32FPR;
+			mips_cpu.tlbsize = 32;
+			break;
 		case PRID_IMP_R4600:
 			mips_cpu.cputype = CPU_R4600;
 			mips_cpu.isa_level = MIPS_CPU_ISA_III;
@@ -233,8 +239,22 @@
 				mips_cpu.tlbsize = 64;
 				break;
 			case PRID_REV_TX3927:
-				mips_cpu.cputype = CPU_TX3927;
+			case PRID_REV_TX3927B:
+				/* check core-mode */
+				if ((*(volatile u32 *)0xfffee004 >> 16) == 0x3927)
+					mips_cpu.cputype = CPU_TX3927;
+				else
+					mips_cpu.cputype = CPU_TX39XX;
 				mips_cpu.tlbsize = 64;
+				mips_cpu.icache.ways = 2;
+				mips_cpu.dcache.ways = 2;
+				break;
+			case PRID_REV_TX39H3TEG:
+				/* support core-mode only */
+				mips_cpu.cputype = CPU_TX39XX;
+				mips_cpu.tlbsize = 32;
+				mips_cpu.icache.ways = 2;
+				mips_cpu.dcache.ways = 2;
 				break;
 			default:
 				mips_cpu.cputype = CPU_UNKNOWN;
@@ -248,6 +268,15 @@
 			                   MIPS_CPU_32FPR;
 			mips_cpu.tlbsize = 48;
 			break;
+		case PRID_IMP_TX49:
+			mips_cpu.cputype = CPU_TX49XX;
+			mips_cpu.isa_level = MIPS_CPU_ISA_III;
+			mips_cpu.options = R4K_OPTS | MIPS_CPU_FPU |
+			                   MIPS_CPU_32FPR;
+			mips_cpu.tlbsize = 48;
+			mips_cpu.icache.ways = 4;
+			mips_cpu.dcache.ways = 4;
+			break;
 		case PRID_IMP_R5000:
 			mips_cpu.cputype = CPU_R5000;
 			mips_cpu.isa_level = MIPS_CPU_ISA_IV; 
@@ -835,6 +864,12 @@
 {
 	unsigned long cfg = read_32bit_cp0_register(CP0_CONF);
 	write_32bit_cp0_register(CP0_CONF, cfg|CONF_HALT);
+}
+
+void r39xx_wait(void)
+{
+	unsigned long cfg = read_32bit_cp0_register(CP0_CONF);
+	write_32bit_cp0_register(CP0_CONF, cfg|TX39_CONF_HALT);
 }
 
 void r4k_wait(void)
diff -urP -x CVS -x .cvsignore linux-sgi-cvs/arch/mips/kernel/traps.c linux.new/arch/mips/kernel/traps.c
--- linux-sgi-cvs/arch/mips/kernel/traps.c	Wed Oct 24 13:27:29 2001
+++ linux.new/arch/mips/kernel/traps.c	Wed Oct 24 21:50:07 2001
@@ -695,6 +695,14 @@
 	return;
 
 bad_cid:
+#ifndef CONFIG_CPU_HAS_LLSC
+	switch (mips_cpu.cputype) {
+	case CPU_TX3927:
+	case CPU_TX39XX:
+		do_ri(regs);
+		return;
+	}
+#endif
 	compute_return_epc(regs);
 	force_sig(SIGILL, current);
 }
@@ -956,6 +964,7 @@
 	case CPU_TX3912:
 	case CPU_TX3922:
 	case CPU_TX3927:
+	case CPU_TX39XX:
 	        save_fp_context = _save_fp_context;
 		restore_fp_context = _restore_fp_context;
 		memcpy((void *)(KSEG0 + 0x80), &except_vec3_generic, 0x80);
@@ -964,6 +973,10 @@
 	case CPU_UNKNOWN:
 	default:
 		panic("Unknown CPU type");
+	}
+	if (!(mips_cpu.options & MIPS_CPU_FPU)) {
+		save_fp_context = fpu_emulator_save_context;
+		restore_fp_context = fpu_emulator_restore_context;
 	}
 	flush_icache_range(KSEG0, KSEG0 + 0x200);
 
diff -urP -x CVS -x .cvsignore linux-sgi-cvs/arch/mips/mm/c-tx39.c linux.new/arch/mips/mm/c-tx39.c
--- linux-sgi-cvs/arch/mips/mm/c-tx39.c	Wed Oct 24 13:27:29 2001
+++ linux.new/arch/mips/mm/c-tx39.c	Wed Oct 24 21:20:52 2001
@@ -28,31 +28,27 @@
 static unsigned long icache_size, dcache_size;		/* Size in bytes */
 extern long scache_size;
 
-#define icache_lsize 16			/* for all current cpu variants  */
-#define dcache_lsize 4			/* for all current cpu variants  */
+#define icache_lsize	mips_cpu.icache.linesz
+#define dcache_lsize	mips_cpu.dcache.linesz
 
 #include <asm/r4kcache.h>
 
-static void tx39_flush_page_to_ram(struct page * page)
+extern int r3k_have_wired_reg;	/* in r3k-tlb.c */
+
+static void tx39h_flush_page_to_ram(struct page * page)
 {
 }
 
-static void tx39_flush_icache_all(void)
+/* TX39H-style cache flush routines. */
+static void tx39h_flush_icache_all(void)
 {
 	unsigned long start = KSEG0;
 	unsigned long end = (start + icache_size);
-	unsigned long dummy = 0;
+	unsigned long flags, config;
 
-	/* disable icache and stop streaming */
-	__asm__ __volatile__(
-	".set\tnoreorder\n\t"
-	"mfc0\t%0, $3\n\t"
-	"xori\t%0, 32\n\t"
-	"mtc0\t%0, $3\n\t"
-	"j\t1f\n\t"
-	"nop\n\t"
-	"1:\t.set\treorder\n\t"
-	: "+r"(dummy));
+	/* disable icache (set ICE#) */
+	__save_and_cli(flags);
+	config = read_32bit_cp0_register(CP0_CONF);
 
 	/* invalidate icache */
 	while (start < end) {
@@ -60,14 +56,194 @@
 		start += 0x200;
 	}
 
-	/* enable icache */
-	__asm__ __volatile__(
-	".set\tnoreorder\n\t"
-	"mfc0\t%0, $3\n\t"
-	"xori\t%0, 32\n\t"
-	"mtc0\t%0, $3\n\t"
-	".set\treorder\n\t"
-	: "+r"(dummy));
+	write_32bit_cp0_register(CP0_CONF, config);
+	__restore_flags(flags);
+}
+
+static void tx39h_dma_cache_wback_inv(unsigned long addr, unsigned long size)
+{
+	unsigned long end, a;
+	wbflush();
+
+	a = addr & ~(dcache_lsize - 1);
+	end = (addr + size) & ~(dcache_lsize - 1);
+	while (1) {
+		invalidate_dcache_line(a); /* Hit_Invalidate_D */
+		if (a == end) break;
+		a += dcache_lsize;
+	}
+}
+
+
+/* TX39H2,TX39H3 */
+static inline void tx39_flush_cache_all(void)
+{
+	unsigned long flags, config;
+
+	__save_and_cli(flags);
+	blast_dcache16_wayLSB();
+	/* disable icache (set ICE#) */
+	config = read_32bit_cp0_register(CP0_CONF);
+	write_32bit_cp0_register(CP0_CONF, config&~TX39_CONF_ICE);
+	blast_icache16_wayLSB();
+	write_32bit_cp0_register(CP0_CONF, config);
+	__restore_flags(flags);
+}
+ 
+static void tx39_flush_cache_mm(struct mm_struct *mm)
+{
+	if(mm->context != 0) {
+#ifdef DEBUG_CACHE
+		printk("cmm[%d]", (int)mm->context);
+#endif
+		tx39_flush_cache_all();
+	}
+}
+
+static void tx39_flush_cache_range(struct mm_struct *mm,
+				    unsigned long start,
+				    unsigned long end)
+{
+	if(mm->context != 0) {
+		unsigned long flags, config;
+
+#ifdef DEBUG_CACHE
+		printk("crange[%d,%08lx,%08lx]", (int)mm->context, start, end);
+#endif
+		__save_and_cli(flags);
+		blast_dcache16_wayLSB();
+		/* disable icache (set ICE#) */
+		config = read_32bit_cp0_register(CP0_CONF);
+		write_32bit_cp0_register(CP0_CONF, config&~TX39_CONF_ICE);
+		blast_icache16_wayLSB();
+		write_32bit_cp0_register(CP0_CONF, config);
+		__restore_flags(flags);
+	}
+}
+
+static void tx39_flush_cache_page(struct vm_area_struct *vma,
+				   unsigned long page)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	unsigned long flags;
+	pgd_t *pgdp;
+	pmd_t *pmdp;
+	pte_t *ptep;
+
+	/*
+	 * If ownes no valid ASID yet, cannot possibly have gotten
+	 * this page into the cache.
+	 */
+	if(mm->context == 0)
+		return;
+
+#ifdef DEBUG_CACHE
+	printk("cpage[%d,%08lx]", (int)mm->context, page);
+#endif
+	__save_and_cli(flags);
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
+	if((mm == current->active_mm) && (pte_val(*ptep) & _PAGE_VALID)) {
+		blast_dcache16_page(page);
+	} else {
+		/*
+		 * Do indexed flush, too much work to get the (possible)
+		 * tlb refills to work correctly.
+		 */
+		page = (KSEG0 + (page & (dcache_size - 1)));
+		blast_dcache16_page_indexed_wayLSB(page);
+	}
+out:
+	__restore_flags(flags);
+}
+
+static void tx39_flush_page_to_ram(struct page * page)
+{
+	blast_dcache16_page((unsigned long)page_address(page));
+}
+
+static void tx39_flush_icache_range(unsigned long start, unsigned long end)
+{
+	flush_cache_all();
+}
+
+static void tx39_flush_icache_page(struct vm_area_struct *vma, struct page *page)
+{
+	if (!(vma->vm_flags & VM_EXEC))
+		return;
+
+	flush_cache_all();
+}
+
+static void tx39_dma_cache_wback_inv(unsigned long addr, unsigned long size)
+{
+	unsigned long end, a;
+
+	if (size >= dcache_size) {
+		flush_cache_all();
+	} else {
+		a = addr & ~(dcache_lsize - 1);
+		end = (addr + size) & ~(dcache_lsize - 1);
+		while (1) {
+			flush_dcache_line(a); /* Hit_Writeback_Inv_D */
+			if (a == end) break;
+			a += dcache_lsize;
+		}
+	}
+}
+
+static void tx39_dma_cache_inv(unsigned long addr, unsigned long size)
+{
+	unsigned long end, a;
+
+	if (size >= dcache_size) {
+		flush_cache_all();
+	} else {
+		a = addr & ~(dcache_lsize - 1);
+		end = (addr + size) & ~(dcache_lsize - 1);
+		while (1) {
+			invalidate_dcache_line(a); /* Hit_Invalidate_D */
+			if (a == end) break;
+			a += dcache_lsize;
+		}
+	}
+}
+
+static void tx39_dma_cache_wback(unsigned long addr, unsigned long size)
+{
+	panic("tx39_dma_cache called - should not happen.\n");
+}
+
+static void tx39_flush_cache_sigtramp(unsigned long addr)
+{
+	unsigned long config;
+	unsigned int flags;
+
+	__save_and_cli(flags);
+	protected_writeback_dcache_line(addr & ~(dcache_lsize - 1));
+
+	/* disable icache (set ICE#) */
+	config = read_32bit_cp0_register(CP0_CONF);
+	write_32bit_cp0_register(CP0_CONF, config&~TX39_CONF_ICE);
+	protected_flush_icache_line(addr & ~(icache_lsize - 1));
+	write_32bit_cp0_register(CP0_CONF, config);
+	__restore_flags(flags);
 }
 
 static __init void tx39_probe_cache(void)
@@ -78,6 +254,19 @@
 
 	icache_size = 1 << (10 + ((config >> 19) & 3));
 	dcache_size = 1 << (10 + ((config >> 16) & 3));
+
+	icache_lsize = 16;
+	switch (mips_cpu.cputype) {
+	case CPU_TX3912:
+		dcache_lsize = 4;
+		break;
+	case CPU_TX3922:
+	case CPU_TX3927:
+	case CPU_TX39XX:
+	default:
+		dcache_lsize = 16;
+		break;
+	}
 }
 
 void __init ld_mmu_tx39(void)
@@ -95,18 +284,55 @@
 
 	tx39_probe_cache();
 
-	_flush_cache_all	= tx39_flush_icache_all;
-	___flush_cache_all	= tx39_flush_icache_all;
-	_flush_cache_mm		= (void *) tx39_flush_icache_all;
-	_flush_cache_range	= (void *) tx39_flush_icache_all;
-	_flush_cache_page	= (void *) tx39_flush_icache_all;
-	_flush_cache_sigtramp	= (void *) tx39_flush_icache_all;
-	_flush_page_to_ram	= tx39_flush_page_to_ram;
-	_flush_icache_page	= (void *) tx39_flush_icache_all;
-	_flush_icache_range	= (void *) tx39_flush_icache_all;
+	switch (mips_cpu.cputype) {
+	case CPU_TX3912:
+		/* TX39/H core (writethru direct-map cache) */
+		_flush_cache_all	= tx39h_flush_icache_all;
+		___flush_cache_all	= tx39h_flush_icache_all;
+		_flush_cache_mm		= (void *) tx39h_flush_icache_all;
+		_flush_cache_range	= (void *) tx39h_flush_icache_all;
+		_flush_cache_page	= (void *) tx39h_flush_icache_all;
+		_flush_cache_sigtramp	= (void *) tx39h_flush_icache_all;
+		_flush_page_to_ram	= tx39h_flush_page_to_ram;
+		_flush_icache_page	= (void *) tx39h_flush_icache_all;
+		_flush_icache_range	= (void *) tx39h_flush_icache_all;
+
+		_dma_cache_wback_inv = tx39h_dma_cache_wback_inv;
+		break;
+
+	case CPU_TX3922:
+	case CPU_TX3927:
+	default:
+		/* TX39/H2,H3 core (writeback 2way-set-associative cache) */
+		r3k_have_wired_reg = 1;
+		set_wired (0);	/* set 8 on reset... */
+		/* board-dependent init code may set WBON */
+
+		_flush_cache_all = tx39_flush_cache_all;
+		___flush_cache_all = tx39_flush_cache_all;
+		_flush_cache_mm = tx39_flush_cache_mm;
+		_flush_cache_range = tx39_flush_cache_range;
+		_flush_cache_page = tx39_flush_cache_page;
+		_flush_cache_sigtramp = tx39_flush_cache_sigtramp;
+		_flush_page_to_ram = tx39_flush_page_to_ram;
+		_flush_icache_page = tx39_flush_icache_page;
+		_flush_icache_range = tx39_flush_icache_range;
+
+		_dma_cache_wback_inv = tx39_dma_cache_wback_inv;
+		_dma_cache_wback = tx39_dma_cache_wback;
+		_dma_cache_inv = tx39_dma_cache_inv;
+
+		break;
+	}
 
-	/* This seems to be wrong for a R4k-style caches -- Ralf  */
-	// _dma_cache_wback_inv	= r3k_dma_cache_wback_inv;
+	if (mips_cpu.icache.ways == 0)
+		mips_cpu.icache.ways = 1;
+	if (mips_cpu.dcache.ways == 0)
+		mips_cpu.dcache.ways = 1;
+	mips_cpu.icache.sets =
+		icache_size / mips_cpu.icache.ways / mips_cpu.icache.linesz;
+	mips_cpu.dcache.sets =
+		dcache_size / mips_cpu.dcache.ways / mips_cpu.dcache.linesz;
 
 	printk("Primary instruction cache %dkb, linesize %d bytes\n",
 		(int) (icache_size >> 10), (int) icache_lsize);
diff -urP -x CVS -x .cvsignore linux-sgi-cvs/arch/mips/mm/c-tx49.c linux.new/arch/mips/mm/c-tx49.c
--- linux-sgi-cvs/arch/mips/mm/c-tx49.c	Thu Jan  1 09:00:00 1970
+++ linux.new/arch/mips/mm/c-tx49.c	Wed Oct 24 21:20:52 2001
@@ -0,0 +1,440 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * r49xx.c: TX49 processor variant specific MMU/Cache routines.
+ *
+ * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
+ * Copyright (C) 1997, 1998, 1999, 2000 Ralf Baechle ralf@gnu.org
+ *
+ * Modified for R4300/TX49xx (Jun/2001)
+ * Copyright (C) 1999-2001 Toshiba Corporation
+ *
+ * To do:
+ *
+ *  - this code is a overbloated pig
+ *  - many of the bug workarounds are not efficient at all, but at
+ *    least they are functional ...
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+
+#include <asm/bootinfo.h>
+#include <asm/cpu.h>
+#include <asm/io.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/system.h>
+#include <asm/mmu_context.h>
+
+/* Primary cache parameters. */
+static int icache_size, dcache_size; /* Size in bytes */
+#define ic_lsize	mips_cpu.icache.linesz
+#define dc_lsize	mips_cpu.dcache.linesz
+static unsigned long scache_size;
+
+#include <asm/cacheops.h>
+#include <asm/r4kcache.h>
+
+#undef DEBUG_CACHE
+
+/* TX49 does can not flush the line contains the CACHE insn itself... */
+/* r4k_xxx routines are completely same as those in r4xx0.c */
+
+/*
+ * If you think for one second that this stuff coming up is a lot
+ * of bulky code eating too many kernel cache lines.  Think _again_.
+ *
+ * Consider:
+ * 1) Taken branches have a 3 cycle penalty on R4k
+ * 2) The branch itself is a real dead cycle on even R4600/R5000.
+ * 3) Only one of the following variants of each type is even used by
+ *    the kernel based upon the cache parameters we detect at boot time.
+ *
+ * QED.
+ */
+
+static inline void r49_flush_cache_all_d16i32(void)
+{
+	unsigned long flags, config;
+
+	__save_and_cli(flags);
+	blast_dcache16_wayLSB();
+	/* disable icache (set ICE#) */
+	config = read_32bit_cp0_register(CP0_CONFIG);
+	write_32bit_cp0_register(CP0_CONFIG, config|TX49_CONF_IC);
+	blast_icache32_wayLSB();
+	write_32bit_cp0_register(CP0_CONFIG, config);
+	__restore_flags(flags);
+}
+
+static inline void r49_flush_cache_all_d32i32(void)
+{
+	unsigned long flags, config;
+
+	__save_and_cli(flags);
+	blast_dcache32_wayLSB();
+	/* disable icache (set ICE#) */
+	config = read_32bit_cp0_register(CP0_CONFIG);
+	write_32bit_cp0_register(CP0_CONFIG, config|TX49_CONF_IC);
+	blast_icache32_wayLSB();
+	write_32bit_cp0_register(CP0_CONFIG, config);
+	__restore_flags(flags);
+}
+
+static void r49_flush_cache_range_d16i32(struct mm_struct *mm,
+					 unsigned long start,
+					 unsigned long end)
+{
+	if (mm->context != 0) {
+		unsigned long flags, config;
+
+#ifdef DEBUG_CACHE
+		printk("crange[%d,%08lx,%08lx]", (int)mm->context, start, end);
+#endif
+		__save_and_cli(flags);
+		blast_dcache16_wayLSB();
+		/* disable icache (set ICE#) */
+		config = read_32bit_cp0_register(CP0_CONFIG);
+		write_32bit_cp0_register(CP0_CONFIG, config|TX49_CONF_IC);
+		blast_icache32_wayLSB();
+		write_32bit_cp0_register(CP0_CONFIG, config);
+		__restore_flags(flags);
+	}
+}
+
+static void r49_flush_cache_range_d32i32(struct mm_struct *mm,
+					       unsigned long start,
+					       unsigned long end)
+{
+	if (mm->context != 0) {
+		unsigned long flags, config;
+
+#ifdef DEBUG_CACHE
+		printk("crange[%d,%08lx,%08lx]", (int)mm->context, start, end);
+#endif
+		__save_and_cli(flags);
+		blast_dcache32_wayLSB();
+		/* disable icache (set ICE#) */
+		config = read_32bit_cp0_register(CP0_CONFIG);
+		write_32bit_cp0_register(CP0_CONFIG, config|TX49_CONF_IC);
+		blast_icache32_wayLSB();
+		write_32bit_cp0_register(CP0_CONFIG, config);
+		__restore_flags(flags);
+	}
+}
+
+/*
+ * On architectures like the Sparc, we could get rid of lines in
+ * the cache created only by a certain context, but on the MIPS
+ * (and actually certain Sparc's) we cannot.
+ */
+static void r49_flush_cache_mm_d16i32(struct mm_struct *mm)
+{
+	if (mm->context != 0) {
+#ifdef DEBUG_CACHE
+		printk("cmm[%d]", (int)mm->context);
+#endif
+		r49_flush_cache_all_d16i32();
+	}
+}
+
+static void r49_flush_cache_mm_d32i32(struct mm_struct *mm)
+{
+	if (mm->context != 0) {
+#ifdef DEBUG_CACHE
+		printk("cmm[%d]", (int)mm->context);
+#endif
+		r49_flush_cache_all_d32i32();
+	}
+}
+
+static void r49_flush_cache_page_d16i32(struct vm_area_struct *vma,
+					unsigned long page)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	unsigned long flags;
+	pgd_t *pgdp;
+	pmd_t *pmdp;
+	pte_t *ptep;
+
+	/*
+	 * If ownes no valid ASID yet, cannot possibly have gotten
+	 * this page into the cache.
+	 */
+	if (mm->context == 0)
+		return;
+
+#ifdef DEBUG_CACHE
+	printk("cpage[%d,%08lx]", (int)mm->context, page);
+#endif
+	__save_and_cli(flags);
+	page &= PAGE_MASK;
+	pgdp = pgd_offset(mm, page);
+	pmdp = pmd_offset(pgdp, page);
+	ptep = pte_offset(pmdp, page);
+
+	/*
+	 * If the page isn't marked valid, the page cannot possibly be
+	 * in the cache.
+	 */
+	if (!(pte_val(*ptep) & _PAGE_PRESENT))
+		goto out;
+
+	/*
+	 * Doing flushes for another ASID than the current one is
+	 * too difficult since stupid R4k caches do a TLB translation
+	 * for every cache flush operation.  So we do indexed flushes
+	 * in that case, which doesn't overly flush the cache too much.
+	 */
+	if ((mm == current->active_mm) && (pte_val(*ptep) & _PAGE_VALID)) {
+		blast_dcache16_page(page);
+	} else {
+		/*
+		 * Do indexed flush, too much work to get the (possible)
+		 * tlb refills to work correctly.
+		 */
+		page = (KSEG0 + (page & (dcache_size - 1)));
+		blast_dcache16_page_indexed_wayLSB(page);
+	}
+out:
+	__restore_flags(flags);
+}
+
+static void r49_flush_cache_page_d32i32(struct vm_area_struct *vma,
+					      unsigned long page)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	unsigned long flags;
+	pgd_t *pgdp;
+	pmd_t *pmdp;
+	pte_t *ptep;
+
+	/*
+	 * If ownes no valid ASID yet, cannot possibly have gotten
+	 * this page into the cache.
+	 */
+	if (mm->context == 0)
+		return;
+
+#ifdef DEBUG_CACHE
+	printk("cpage[%d,%08lx]", (int)mm->context, page);
+#endif
+	__save_and_cli(flags);
+	page &= PAGE_MASK;
+	pgdp = pgd_offset(mm, page);
+	pmdp = pmd_offset(pgdp, page);
+	ptep = pte_offset(pmdp, page);
+
+	/*
+	 * If the page isn't marked valid, the page cannot possibly be
+	 * in the cache.
+	 */
+	if (!(pte_val(*ptep) & _PAGE_PRESENT))
+		goto out;
+
+	/*
+	 * Doing flushes for another ASID than the current one is
+	 * too difficult since stupid R4k caches do a TLB translation
+	 * for every cache flush operation.  So we do indexed flushes
+	 * in that case, which doesn't overly flush the cache too much.
+	 */
+	if ((mm == current->active_mm) && (pte_val(*ptep) & _PAGE_VALID)) {
+		blast_dcache32_page(page);
+	} else {
+		/*
+		 * Do indexed flush, too much work to get the (possible)
+		 * tlb refills to work correctly.
+		 */
+		page = (KSEG0 + (page & (dcache_size - 1)));
+		blast_dcache32_page_indexed_wayLSB(page);
+	}
+out:
+	__restore_flags(flags);
+}
+
+/* If the addresses passed to these routines are valid, they are
+ * either:
+ *
+ * 1) In KSEG0, so we can do a direct flush of the page.
+ * 2) In KSEG2, and since every process can translate those
+ *    addresses all the time in kernel mode we can do a direct
+ *    flush.
+ * 3) In KSEG1, no flush necessary.
+ */
+static void r4k_flush_page_to_ram_d16(struct page *page)
+{
+	blast_dcache16_page((unsigned long)page_address(page));
+}
+
+static void r4k_flush_page_to_ram_d32(struct page *page)
+{
+	blast_dcache32_page((unsigned long)page_address(page));
+}
+
+static void
+r4k_flush_icache_range(unsigned long start, unsigned long end)
+{
+	flush_cache_all();
+}
+
+/*
+ * Ok, this seriously sucks.  We use them to flush a user page but don't
+ * know the virtual address, so we have to blast away the whole icache
+ * which is significantly more expensive than the real thing.
+ */
+static void
+r4k_flush_icache_page(struct vm_area_struct *vma, struct page *page)
+{
+	if (!(vma->vm_flags & VM_EXEC))
+		return;
+
+	flush_cache_all();
+}
+
+/*
+ * Writeback and invalidate the primary cache dcache before DMA.
+ */
+static void
+r4k_dma_cache_wback_inv(unsigned long addr, unsigned long size)
+{
+	unsigned long end, a;
+	unsigned int flags;
+
+	if (size >= dcache_size) {
+		flush_cache_all();
+	} else {
+		__save_and_cli(flags);
+
+		a = addr & ~(dc_lsize - 1);
+		end = (addr + size) & ~(dc_lsize - 1);
+		while (1) {
+			flush_dcache_line(a); /* Hit_Writeback_Inv_D */
+			if (a == end) break;
+			a += dc_lsize;
+		}
+		__restore_flags(flags);
+	}
+}
+
+static void
+r4k_dma_cache_inv(unsigned long addr, unsigned long size)
+{
+	unsigned long end, a;
+	unsigned int flags;
+
+	if (size >= dcache_size) {
+		flush_cache_all();
+	} else {
+		__save_and_cli(flags);
+
+		a = addr & ~(dc_lsize - 1);
+		end = (addr + size) & ~(dc_lsize - 1);
+		while (1) {
+			flush_dcache_line(a); /* Hit_Writeback_Inv_D */
+			if (a == end) break;
+			a += dc_lsize;
+		}
+		__restore_flags(flags);
+	}
+}
+
+static void
+r4k_dma_cache_wback(unsigned long addr, unsigned long size)
+{
+	panic("r4k_dma_cache called - should not happen.\n");
+}
+
+/*
+ * While we're protected against bad userland addresses we don't care
+ * very much about what happens in that case.  Usually a segmentation
+ * fault will dump the process later on anyway ...
+ */
+static void r4k_flush_cache_sigtramp(unsigned long addr)
+{
+	protected_writeback_dcache_line(addr & ~(dc_lsize - 1));
+	protected_flush_icache_line(addr & ~(ic_lsize - 1));
+}
+
+/* Detect and size the various r4k caches. */
+static void __init probe_icache(unsigned long config)
+{
+	icache_size = 1 << (12 + ((config >> 9) & 7));
+	ic_lsize = 16 << ((config >> 5) & 1);
+
+	printk("Primary instruction cache %dkb, linesize %d bytes.\n",
+	       icache_size >> 10, ic_lsize);
+}
+
+static void __init probe_dcache(unsigned long config)
+{
+	dcache_size = 1 << (12 + ((config >> 6) & 7));
+	dc_lsize = 16 << ((config >> 4) & 1);
+
+	printk("Primary data cache %dkb, linesize %d bytes.\n",
+	       dcache_size >> 10, dc_lsize);
+}
+
+int mips_configk0 = -1;	/* board-specific setup routine can override this */
+void __init ld_mmu_tx49(void)
+{
+	unsigned long config = read_32bit_cp0_register(CP0_CONFIG);
+
+	printk("CPU revision is: %08x\n", read_32bit_cp0_register(CP0_PRID));
+
+	if (mips_configk0 != -1)
+		change_cp0_config(CONF_CM_CMASK, mips_configk0);
+	else
+#ifdef CONFIG_MIPS_UNCACHED
+		change_cp0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);
+#else
+		change_cp0_config(CONF_CM_CMASK, CONF_CM_CACHABLE_NONCOHERENT);
+#endif
+
+	probe_icache(config);
+	probe_dcache(config);
+	if (mips_cpu.icache.ways == 0)
+		mips_cpu.icache.ways = 1;
+	if (mips_cpu.dcache.ways == 0)
+		mips_cpu.dcache.ways = 1;
+	mips_cpu.icache.sets =
+		icache_size / mips_cpu.icache.ways / mips_cpu.icache.linesz;
+	mips_cpu.dcache.sets =
+		dcache_size / mips_cpu.dcache.ways / mips_cpu.dcache.linesz;
+
+	switch(dc_lsize) {
+	case 16:
+		_clear_page = r4k_clear_page_d16;
+		_copy_page = r4k_copy_page_d16;
+		_flush_page_to_ram = r4k_flush_page_to_ram_d16;
+		_flush_cache_all = r49_flush_cache_all_d16i32;
+		_flush_cache_mm = r49_flush_cache_mm_d16i32;
+		_flush_cache_range = r49_flush_cache_range_d16i32;
+		_flush_cache_page = r49_flush_cache_page_d16i32;
+		break;
+	case 32:
+		_clear_page = r4k_clear_page_d32;
+		_copy_page = r4k_copy_page_d32;
+		_flush_page_to_ram = r4k_flush_page_to_ram_d32;
+		_flush_cache_all = r49_flush_cache_all_d32i32;
+		_flush_cache_mm = r49_flush_cache_mm_d32i32;
+		_flush_cache_range = r49_flush_cache_range_d32i32;
+		_flush_cache_page = r49_flush_cache_page_d32i32;
+		break;
+	}
+	___flush_cache_all = _flush_cache_all;
+
+	_flush_icache_page = r4k_flush_icache_page;
+
+	_dma_cache_wback_inv = r4k_dma_cache_wback_inv;
+	_dma_cache_wback = r4k_dma_cache_wback;
+	_dma_cache_inv = r4k_dma_cache_inv;
+
+	_flush_cache_sigtramp = r4k_flush_cache_sigtramp;
+	_flush_icache_range = r4k_flush_icache_range;	/* Ouch */
+
+	__flush_cache_all();
+}
diff -urP -x CVS -x .cvsignore linux-sgi-cvs/arch/mips/mm/loadmmu.c linux.new/arch/mips/mm/loadmmu.c
--- linux-sgi-cvs/arch/mips/mm/loadmmu.c	Wed Oct 24 13:27:29 2001
+++ linux.new/arch/mips/mm/loadmmu.c	Wed Oct 24 21:20:52 2001
@@ -40,6 +40,8 @@
 
 extern void ld_mmu_r23000(void);
 extern void ld_mmu_r4xx0(void);
+extern void ld_mmu_tx39(void);
+extern void ld_mmu_tx49(void);
 extern void ld_mmu_r5432(void);
 extern void ld_mmu_r6000(void);
 extern void ld_mmu_rm7k(void);
@@ -67,6 +69,10 @@
 		ld_mmu_r5432();
 		r4k_tlb_init();
 #endif
+#if defined(CONFIG_CPU_TX49XX)
+		ld_mmu_tx49();
+		r4k_tlb_init();
+#endif
 
 #if defined(CONFIG_CPU_MIPS32) || defined(CONFIG_CPU_MIPS64)
 		ld_mmu_mips32();
@@ -80,10 +86,20 @@
 	case CPU_R3081E:
 		ld_mmu_r23000();
 		r3k_tlb_init();
-
+		break;
+	case CPU_TX3912:
+	case CPU_TX3922:
+	case CPU_TX3927:
+	case CPU_TX39XX:
+		ld_mmu_tx39();
+		r3k_tlb_init();
+		break;
+#endif
+#ifdef CONFIG_CPU_TX39XX
 	case CPU_TX3912:
 	case CPU_TX3922:
 	case CPU_TX3927:
+	case CPU_TX39XX:
 		ld_mmu_tx39();
 		r3k_tlb_init();
 		break;
diff -urP -x CVS -x .cvsignore linux-sgi-cvs/arch/mips/mm/tlb-r3k.c linux.new/arch/mips/mm/tlb-r3k.c
--- linux-sgi-cvs/arch/mips/mm/tlb-r3k.c	Wed Oct 24 13:27:29 2001
+++ linux.new/arch/mips/mm/tlb-r3k.c	Wed Oct 24 21:20:53 2001
@@ -27,6 +27,10 @@
 
 #undef DEBUG_TLB
 
+#ifdef CONFIG_CPU_TX39XX
+int r3k_have_wired_reg = 0;	/* should be in mips_cpu? */
+#endif
+
 /* TLB operations. */
 void local_flush_tlb_all(void)
 {
@@ -41,7 +45,12 @@
 	save_and_cli(flags);
 	old_ctx = (get_entryhi() & 0xfc0);
 	write_32bit_cp0_register(CP0_ENTRYLO0, 0);
-	for (entry = 8; entry < mips_cpu.tlbsize; entry++) {
+#ifdef CONFIG_CPU_TX39XX
+	entry = r3k_have_wired_reg ? get_wired() : 8;
+#else
+	entry = 8;
+#endif
+	for (; entry < mips_cpu.tlbsize; entry++) {
 		write_32bit_cp0_register(CP0_INDEX, entry << 8);
 		write_32bit_cp0_register(CP0_ENTRYHI, ((entry | 0x80000) << 12));
 		__asm__ __volatile__("tlbwi");
@@ -193,6 +202,40 @@
 	unsigned long old_ctx;
 	static unsigned long wired = 0;
 	
+#ifdef CONFIG_CPU_TX39XX
+	if (r3k_have_wired_reg) {
+		unsigned long old_pagemask;
+		unsigned long w;
+	
+#ifdef DEBUG_TLB
+		printk("[tlbwired]");
+		printk("ently lo0 %8x, hi %8x\n, pagemask %8x\n",
+		       entrylo0, entryhi, pagemask);
+#endif
+		save_and_cli(flags);
+		/* Save old context and create impossible VPN2 value */
+		old_ctx = (get_entryhi() & 0xff);
+		old_pagemask = get_pagemask();
+		w = get_wired();
+		set_wired (w + 1);
+		if (get_wired() != w + 1) {
+			printk("[tlbwired] No WIRED reg?\n");
+			return;
+		}
+		set_index (w << 8);
+		set_pagemask (pagemask);
+		set_entryhi(entryhi);
+		set_entrylo0(entrylo0);
+		tlb_write_indexed();
+    
+		set_entryhi(old_ctx);
+		set_pagemask (old_pagemask);
+		local_flush_tlb_all();
+		restore_flags(flags);
+		return;
+	}
+#endif
+
 	if (wired < 8) {
 		__save_and_cli(flags);
 		old_ctx = get_entryhi() & 0xfc0;
diff -urP -x CVS -x .cvsignore linux-sgi-cvs/include/asm-mips/bootinfo.h linux.new/include/asm-mips/bootinfo.h
--- linux-sgi-cvs/include/asm-mips/bootinfo.h	Mon Oct 22 10:30:09 2001
+++ linux.new/include/asm-mips/bootinfo.h	Wed Oct 24 21:47:40 2001
@@ -249,7 +249,9 @@
 #define CPU_4KSC		39
 #define CPU_VR41XX		40
 #define CPU_R5500		41
-#define CPU_LAST		41
+#define CPU_TX49XX		42
+#define CPU_TX39XX		43
+#define CPU_LAST		43
 
 
 #define CPU_NAMES { "unknown", "R2000", "R3000", "R3000A", "R3041", "R3051", \
@@ -258,7 +260,7 @@
         "R6000A", "R8000", "R10000", "R4300", "R4650", "R4700", "R5000",     \
         "R5000A", "R4640", "Nevada", "RM7000", "R5432", "MIPS 4Kc",          \
         "MIPS 5Kc", "R4310", "SiByte SB1", "TX3912", "TX3922", "TX3927",     \
-	"Au1000", "MIPS 4KEc", "MIPS 4KSc", "NEC Vr41xx", "R5500" }
+	"Au1000", "MIPS 4KEc", "MIPS 4KSc", "NEC Vr41xx", "R5500", "TX49xx", "TX39xx" }
 
 #define COMMAND_LINE_SIZE	256
 
diff -urP -x CVS -x .cvsignore linux-sgi-cvs/include/asm-mips/bugs.h linux.new/include/asm-mips/bugs.h
--- linux-sgi-cvs/include/asm-mips/bugs.h	Tue Jul  3 05:56:40 2001
+++ linux.new/include/asm-mips/bugs.h	Wed Oct 24 21:47:49 2001
@@ -22,8 +22,13 @@
 		cpu_wait = r3081_wait;
 		printk(" available.\n");
 		break;
+	case CPU_TX3927:
+	case CPU_TX39XX:
+		cpu_wait = r39xx_wait;
+		printk(" available.\n");
+		break;
 	case CPU_R4200: 
-	case CPU_R4300: 
+/*	case CPU_R4300: */
 	case CPU_R4600: 
 	case CPU_R4640: 
 	case CPU_R4650: 
@@ -31,6 +36,7 @@
 	case CPU_R5000: 
 	case CPU_NEVADA:
 	case CPU_RM7000:
+	case CPU_TX49XX:
 		cpu_wait = r4k_wait;
 		printk(" available.\n");
 		break;
diff -urP -x CVS -x .cvsignore linux-sgi-cvs/include/asm-mips/cache.h linux.new/include/asm-mips/cache.h
--- linux-sgi-cvs/include/asm-mips/cache.h	Tue Jul  3 05:56:40 2001
+++ linux.new/include/asm-mips/cache.h	Wed Oct 24 21:01:29 2001
@@ -28,7 +28,7 @@
  */
 #define MIPS_CACHE_NOT_PRESENT 0x00000001
 
-#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_R6000)
+#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_R6000) || defined(CONFIG_CPU_TX39XX)
 #define L1_CACHE_BYTES		16
 #else
 #define L1_CACHE_BYTES 		32	/* A guess */
diff -urP -x CVS -x .cvsignore linux-sgi-cvs/include/asm-mips/isadep.h linux.new/include/asm-mips/isadep.h
--- linux-sgi-cvs/include/asm-mips/isadep.h	Mon Sep 10 02:43:01 2001
+++ linux.new/include/asm-mips/isadep.h	Wed Oct 24 21:01:36 2001
@@ -10,7 +10,7 @@
 #ifndef __ASM_ISADEP_H
 #define __ASM_ISADEP_H
 
-#if defined(CONFIG_CPU_R3000)
+#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
 /*
  * R2000 or R3000
  */
diff -urP -x CVS -x .cvsignore linux-sgi-cvs/include/asm-mips/mipsregs.h linux.new/include/asm-mips/mipsregs.h
--- linux-sgi-cvs/include/asm-mips/mipsregs.h	Mon Sep 10 02:43:01 2001
+++ linux.new/include/asm-mips/mipsregs.h	Wed Oct 24 21:48:28 2001
@@ -79,6 +79,12 @@
 #define CP0_S1_DERRADDR0  $26
 #define CP0_S1_DERRADDR1  $27
 #define CP0_S1_INTCONTROL $20
+
+/*
+ *  TX39 Series
+ */
+#define CP0_TX39_CACHE	$7
+
 /*
  * Coprocessor 1 (FPU) register names
  */
@@ -478,6 +484,14 @@
 #define CONF_SC				(1 << 17)
 #define CONF_AC                         (1 << 23)
 #define CONF_HALT                       (1 << 25)
+
+/*
+ * Bits in the TX49 coprozessor 0 config register.
+ */
+#define TX49_CONF_DC			(1 << 16)
+#define TX49_CONF_IC			(1 << 17)  /* conflict with CONF_SC */
+#define TX49_CONF_HALT			(1 << 18)
+#define TX49_CONF_CWFON			(1 << 27)
 
 /*
  * R10000 performance counter definitions.
diff -urP -x CVS -x .cvsignore linux-sgi-cvs/include/asm-mips/mmu_context.h linux.new/include/asm-mips/mmu_context.h
--- linux-sgi-cvs/include/asm-mips/mmu_context.h	Mon Oct 22 10:30:10 2001
+++ linux.new/include/asm-mips/mmu_context.h	Wed Oct 24 21:01:48 2001
@@ -37,7 +37,7 @@
 #endif
 #define ASID_CACHE(cpu)		cpu_data[cpu].asid_cache
 
-#if defined(CONFIG_CPU_R3000)
+#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
 
 #define ASID_INC	0x40
 #define ASID_MASK	0xfc0
diff -urP -x CVS -x .cvsignore linux-sgi-cvs/include/asm-mips/pgtable.h linux.new/include/asm-mips/pgtable.h
--- linux-sgi-cvs/include/asm-mips/pgtable.h	Mon Sep 10 02:43:01 2001
+++ linux.new/include/asm-mips/pgtable.h	Wed Oct 24 21:48:39 2001
@@ -128,7 +128,7 @@
 #define _PAGE_ACCESSED              (1<<3)  /* implemented in software */
 #define _PAGE_MODIFIED              (1<<4)  /* implemented in software */
 
-#if defined(CONFIG_CPU_R3000)
+#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
 
 #define _PAGE_GLOBAL                (1<<8)
 #define _PAGE_VALID                 (1<<9)
diff -urP -x CVS -x .cvsignore linux-sgi-cvs/include/asm-mips/r4kcache.h linux.new/include/asm-mips/r4kcache.h
--- linux-sgi-cvs/include/asm-mips/r4kcache.h	Mon Oct 22 10:30:10 2001
+++ linux.new/include/asm-mips/r4kcache.h	Wed Oct 24 21:48:49 2001
@@ -187,6 +187,20 @@
 	}
 }
 
+extern inline void blast_dcache16_wayLSB(void)
+{
+	unsigned long start = KSEG0;
+	unsigned long end = (start + mips_cpu.dcache.sets * mips_cpu.dcache.linesz);
+	int way;
+
+	while(start < end) {
+		/* LSB of VA select the way */
+		for (way = 0; way < mips_cpu.dcache.ways; way++)
+			cache16_unroll32(start|way,Index_Writeback_Inv_D);
+		start += 0x200;
+	}
+}
+
 extern inline void blast_dcache16_page(unsigned long page)
 {
 	unsigned long start = page;
@@ -209,6 +223,20 @@
 	}
 }
 
+extern inline void blast_dcache16_page_indexed_wayLSB(unsigned long page)
+{
+	unsigned long start = page;
+	unsigned long end = (start + PAGE_SIZE);
+	int way;
+
+	while(start < end) {
+		/* LSB of VA select the way */
+		for (way = 0; way < mips_cpu.dcache.ways; way++)
+			cache16_unroll32(start|way,Index_Writeback_Inv_D);
+		start += 0x200;
+	}
+}
+
 extern inline void blast_icache16(void)
 {
 	unsigned long start = KSEG0;
@@ -220,6 +248,20 @@
 	}
 }
 
+extern inline void blast_icache16_wayLSB(void)
+{
+	unsigned long start = KSEG0;
+	unsigned long end = (start + mips_cpu.icache.sets * mips_cpu.icache.linesz);
+	int way;
+
+	while(start < end) {
+		/* LSB of VA select the way */
+		for (way = 0; way < mips_cpu.icache.ways; way++)
+			cache16_unroll32(start|way,Index_Invalidate_I);
+		start += 0x200;
+	}
+}
+
 extern inline void blast_icache16_page(unsigned long page)
 {
 	unsigned long start = page;
@@ -312,6 +354,20 @@
 	}
 }
 
+extern inline void blast_dcache32_wayLSB(void)
+{
+	unsigned long start = KSEG0;
+	unsigned long end = (start + mips_cpu.dcache.sets * mips_cpu.dcache.linesz);
+	int way;
+
+	while(start < end) {
+		/* LSB of VA select the way */
+		for (way = 0; way < mips_cpu.dcache.ways; way++)
+			cache32_unroll32(start|way,Index_Writeback_Inv_D);
+		start += 0x400;
+	}
+}
+
 /*
  * Call this function only with interrupts disabled or R4600 V2.0 may blow
  * up on you.
@@ -352,6 +408,20 @@
 	}
 }
 
+extern inline void blast_dcache32_page_indexed_wayLSB(unsigned long page)
+{
+	unsigned long start = page;
+	unsigned long end = (start + PAGE_SIZE);
+	int way;
+
+	while(start < end) {
+		/* LSB of VA select the way */
+		for (way = 0; way < mips_cpu.dcache.ways; way++)
+			cache32_unroll32(start|way,Index_Writeback_Inv_D);
+		start += 0x400;
+	}
+}
+
 extern inline void blast_icache32(void)
 {
 	unsigned long start = KSEG0;
@@ -359,6 +429,20 @@
 
 	while(start < end) {
 		cache32_unroll32(start,Index_Invalidate_I);
+		start += 0x400;
+	}
+}
+
+extern inline void blast_icache32_wayLSB(void)
+{
+	unsigned long start = KSEG0;
+	unsigned long end = (start + mips_cpu.icache.sets * mips_cpu.icache.linesz);
+	int way;
+
+	while(start < end) {
+		/* LSB of VA select the way */
+		for (way = 0; way < mips_cpu.icache.ways; way++)
+			cache32_unroll32(start|way,Index_Invalidate_I);
 		start += 0x400;
 	}
 }
diff -urP -x CVS -x .cvsignore linux-sgi-cvs/include/asm-mips/stackframe.h linux.new/include/asm-mips/stackframe.h
--- linux-sgi-cvs/include/asm-mips/stackframe.h	Tue Jul  3 05:56:40 2001
+++ linux.new/include/asm-mips/stackframe.h	Wed Oct 24 21:02:06 2001
@@ -163,7 +163,7 @@
 		lw	$23, PT_R23(sp);                 \
 		lw	$30, PT_R30(sp)
 
-#if defined(CONFIG_CPU_R3000)
+#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
 
 #define RESTORE_SOME                                     \
 		.set	push;                            \

----Next_Part(Wed_Oct_24_22:38:37_2001_909)----
