Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g62JRFRw014347
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 2 Jul 2002 12:27:15 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g62JRFAN014346
	for linux-mips-outgoing; Tue, 2 Jul 2002 12:27:15 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from ubik.localnet (port48.ds1-vbr.adsl.cybercity.dk [212.242.58.113])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g62JPeRw014153
	for <linux-mips@oss.sgi.com>; Tue, 2 Jul 2002 12:25:41 -0700
Received: from murphy.dk (brian.localnet [10.0.0.2])
	by ubik.localnet (8.12.3/8.12.2/Debian -5) with ESMTP id g62JTUXK005259
	for <linux-mips@oss.sgi.com>; Tue, 2 Jul 2002 21:29:30 +0200
Message-ID: <3D21FF19.5020606@murphy.dk>
Date: Tue, 02 Jul 2002 21:29:29 +0200
From: Brian Murphy <brian@murphy.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020412 Debian/0.9.9-6
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: Patch for NEC VR5000 support (part 1 of several for lasat board support)
Content-Type: multipart/mixed;
 boundary="------------070509040506040600040500"
X-Spam-Status: No, hits=-5.0 required=5.0 tests=REAL_THING,PORN_10,UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------070509040506040600040500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


I have attached a patch which applies to the 2.4 branch and adds
support for the NEC VR5000. This would be a first step in
adding support for the Lasat architectures.

A comment from someone with cvs commit access would be nice
this time.

/Brian

--------------070509040506040600040500
Content-Type: text/plain;
 name="vr5000.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vr5000.diff"

? arch/mips/mm/c-r5000.c
--- arch/mips/Makefile	2002/06/25 15:46:52	1.78.2.3
+++ arch/mips/Makefile	2002/07/02 18:46:38
@@ -78,6 +78,9 @@
 ifdef CONFIG_CPU_R5000
 GCCFLAGS	+= -mcpu=r5000 -mips2 -Wa,--trap
 endif
+ifdef CONFIG_CPU_VR5000
+GCCFLAGS	+= -mcpu=vr5000 -mips2 -Wa,--trap
+endif
 ifdef CONFIG_CPU_R5432
 GCCFLAGS	+= -mcpu=r5000 -mips2 -Wa,--trap
 endif
--- arch/mips/config.in	2002/06/26 22:35:17	1.154.2.20
+++ arch/mips/config.in	2002/07/02 18:46:39
@@ -324,6 +339,7 @@
 	 R4x00	CONFIG_CPU_R4X00 \
 	 R49XX	CONFIG_CPU_TX49XX \
 	 R5000	CONFIG_CPU_R5000 \
+	 VR5000	CONFIG_CPU_VR5000 \
 	 R5432	CONFIG_CPU_R5432 \
 	 RM7000	CONFIG_CPU_RM7000 \
 	 R52xx	CONFIG_CPU_NEVADA \
@@ -355,6 +371,7 @@
 
 if [ "$CONFIG_CPU_R4X00"  = "y" -o \
      "$CONFIG_CPU_R5000" = "y" -o \
+     "$CONFIG_CPU_VR5000" = "y" -o \
      "$CONFIG_CPU_RM7000" = "y" -o \
      "$CONFIG_CPU_R10000" = "y" -o \
      "$CONFIG_CPU_SB1" = "y" -o \
--- arch/mips/kernel/Makefile	2002/06/25 15:47:00	1.51.2.2
+++ arch/mips/kernel/Makefile	2002/07/02 18:46:39
@@ -29,6 +29,7 @@
 obj-$(CONFIG_CPU_R4300)		+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_R4X00)		+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_R5000)		+= r4k_fpu.o r4k_switch.o
+obj-$(CONFIG_CPU_VR5000)	+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_R5432)		+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_RM7000)	+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_NEVADA)	+= r4k_fpu.o r4k_switch.o
--- arch/mips/mm/Makefile	2002/06/25 15:47:00	1.27.2.1
+++ arch/mips/mm/Makefile	2002/07/02 18:46:41
@@ -21,6 +21,7 @@
 obj-$(CONFIG_CPU_R4X00)		+= pg-r4k.o c-r4k.o tlb-r4k.o tlbex-r4k.o
 obj-$(CONFIG_CPU_VR41XX)	+= pg-r4k.o c-r4k.o tlb-r4k.o tlbex-r4k.o
 obj-$(CONFIG_CPU_R5000)		+= pg-r4k.o c-r4k.o tlb-r4k.o tlbex-r4k.o
+obj-$(CONFIG_CPU_VR5000)	+= pg-r4k.o c-r5000.o tlb-r4k.o tlbex-r4k.o
 obj-$(CONFIG_CPU_NEVADA)	+= pg-r4k.o c-r4k.o tlb-r4k.o tlbex-r4k.o
 obj-$(CONFIG_CPU_R5432)		+= pg-r5432.o c-r5432.o tlb-r4k.o tlbex-r4k.o
 obj-$(CONFIG_CPU_RM7000)	+= pg-rm7k.o c-rm7k.o tlb-r4k.o tlbex-r4k.o
--- arch/mips/mm/loadmmu.c	2001/11/29 04:47:24	1.45
+++ arch/mips/mm/loadmmu.c	2002/07/02 18:46:41
@@ -52,6 +52,7 @@
 
 extern void ld_mmu_r23000(void);
 extern void ld_mmu_r4xx0(void);
+extern void ld_mmu_r5000(void);
 extern void ld_mmu_tx39(void);
 extern void ld_mmu_tx49(void);
 extern void ld_mmu_r5432(void);
@@ -72,6 +73,10 @@
     defined(CONFIG_CPU_R4300) || defined(CONFIG_CPU_R5000) || \
     defined(CONFIG_CPU_NEVADA)
 		ld_mmu_r4xx0();
+		r4k_tlb_init();
+#endif
+#if defined(CONFIG_CPU_VR5000)
+		ld_mmu_r5000();
 		r4k_tlb_init();
 #endif
 #if defined(CONFIG_CPU_RM7000)
Index: include/asm-mips/cacheops.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/cacheops.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 cacheops.h
--- include/asm-mips/cacheops.h	1997/06/01 03:17:12	1.1.1.1
+++ include/asm-mips/cacheops.h	2002/07/02 18:46:56
@@ -35,6 +35,7 @@
 #define Hit_Writeback_Inv_D	0x15
 					/* 0x16 is unused */
 #define Hit_Writeback_Inv_SD	0x17
+#define Page_Invalidate		0x17
 #define Hit_Writeback_I		0x18
 #define Hit_Writeback_D		0x19
 					/* 0x1a is unused */
Index: include/asm-mips/cpu.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/cpu.h,v
retrieving revision 1.24.2.8
diff -u -r1.24.2.8 cpu.h
--- include/asm-mips/cpu.h	2002/06/27 14:21:23	1.24.2.8
+++ include/asm-mips/cpu.h	2002/07/02 18:46:56
@@ -53,6 +53,7 @@
 #define PRID_IMP_R4640		0x2200
 #define PRID_IMP_R4650		0x2200		/* Same as R4640 */
 #define PRID_IMP_R5000		0x2300
+#define PRID_IMP_VR5000		0x2300
 #define PRID_IMP_TX49		0x2d00
 #define PRID_IMP_SONIC		0x2400
 #define PRID_IMP_MAGIC		0x2500
@@ -128,7 +129,7 @@
 	CPU_RM7000, CPU_R5432, CPU_4KC, CPU_5KC, CPU_R4310, CPU_SB1,
 	CPU_TX3912, CPU_TX3922, CPU_TX3927, CPU_AU1000, CPU_4KEC, CPU_4KSC,
 	CPU_VR41XX, CPU_R5500, CPU_TX49XX, CPU_TX39XX, CPU_AU1500, CPU_20KC,
-	CPU_LAST
+	CPU_VR5000, CPU_LAST
 };
 
 #endif /* !__ASSEMBLY__ */
Index: include/asm-mips/r4kcache.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/r4kcache.h,v
retrieving revision 1.8
diff -u -r1.8 r4kcache.h
--- include/asm-mips/r4kcache.h	2001/10/31 02:31:23	1.8
+++ include/asm-mips/r4kcache.h	2002/07/02 18:46:59
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
--- /dev/null	Sun Apr 14 10:11:55 2002
+++ arch/mips/mm/c-r5000.c	Wed May 29 13:20:24 2002
@@ -0,0 +1,528 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * r5000.c: R5000 processor variant specific MMU/Cache routines.
+ *
+ * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
+ * Copyright (C) 1997, 1998, 1999, 2000 Ralf Baechle ralf@gnu.org
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
+#include <asm/bcache.h>
+#include <asm/io.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/system.h>
+#include <asm/mmu_context.h>
+
+/* Primary cache parameters. */
+static int icache_size, dcache_size; /* Size in bytes */
+static int ic_lsize, dc_lsize;       /* LineSize in bytes */
+
+/* Secondary cache (if present) parameters. */
+static unsigned int scache_size, sc_lsize;	/* Again, in bytes */
+static int sc_present = 0;
+
+#include <asm/cacheops.h>
+#include <asm/r4kcache.h>
+
+#undef DEBUG_CACHE
+
+/*
+ * On processors with QED R4600 style two set assosicative cache
+ * this is the bit which selects the way in the cache for the
+ * indexed cachops.
+ */
+#define icache_waybit (icache_size >> 1)
+#define dcache_waybit (dcache_size >> 1)
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
+static inline void r4k_flush_cache_all_d32i32(void)
+{
+	unsigned long flags;
+
+	__save_and_cli(flags);
+	blast_dcache32(); blast_icache32();
+	__restore_flags(flags);
+}
+
+
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
+
+/*
+ * On architectures like the Sparc, we could get rid of lines in
+ * the cache created only by a certain context, but on the MIPS
+ * (and actually certain Sparc's) we cannot.
+ */
+
+static void r4k_flush_cache_mm_d32i32(struct mm_struct *mm)
+{
+	if (mm->context != 0) {
+#ifdef DEBUG_CACHE
+		printk("cmm[%d]", (int)mm->context);
+#endif
+		r4k_flush_cache_all_d32i32();
+	}
+}
+
+
+static void r4k_flush_cache_page_d32i32_r4600(struct vm_area_struct *vma,
+					      unsigned long page)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	unsigned long flags;
+	pgd_t *pgdp;
+	pmd_t *pmdp;
+	pte_t *ptep;
+	int text;
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
+	text = vma->vm_flags & VM_EXEC;
+	/*
+	 * Doing flushes for another ASID than the current one is
+	 * too difficult since stupid R4k caches do a TLB translation
+	 * for every cache flush operation.  So we do indexed flushes
+	 * in that case, which doesn't overly flush the cache too much.
+	 */
+	if ((mm == current->active_mm) && (pte_val(*ptep) & _PAGE_VALID)) {
+		blast_dcache32_page(page);
+		if (text)
+			blast_icache32_page(page);
+	} else {
+		/* Do indexed flush, too much work to get the (possible)
+		 * tlb refills to work correctly.
+		 */
+		page = (KSEG0 + (page & (dcache_size - 1)));
+		blast_dcache32_page_indexed(page);
+		blast_dcache32_page_indexed(page ^ dcache_waybit);
+		if (text) {
+			blast_icache32_page_indexed(page);
+			blast_icache32_page_indexed(page ^ icache_waybit);
+		}
+	}
+out:
+	__restore_flags(flags);
+}
+
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
+
+static void r4k_flush_page_to_ram_d32(struct page *page)
+{
+	blast_dcache32_page((unsigned long)page_address(page));
+}
+
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
+r4k_flush_icache_page_p(struct vm_area_struct *vma, struct page *page)
+{
+	if (!(vma->vm_flags & VM_EXEC))
+		return;
+
+	flush_cache_all();
+}
+
+
+/*
+ * Writeback and invalidate the primary cache dcache before DMA.
+ */
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
+
+/*
+ * While we're protected against bad userland addresses we don't care
+ * very much about what happens in that case.  Usually a segmentation
+ * fault will dump the process later on anyway ...
+ */
+static void r4k_flush_cache_sigtramp(unsigned long addr)
+{
+	unsigned long daddr, iaddr;
+
+	daddr = addr & ~(dc_lsize - 1);
+	__asm__ __volatile__("nop;nop;nop;nop");	/* R4600 V1.7 */
+	protected_writeback_dcache_line(daddr);
+	protected_writeback_dcache_line(daddr + dc_lsize);
+	iaddr = addr & ~(ic_lsize - 1);
+	protected_flush_icache_line(iaddr);
+	protected_flush_icache_line(iaddr + ic_lsize);
+}
+
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
+
+/* If you even _breathe_ on this function, look at the gcc output
+ * and make sure it does not pop things on and off the stack for
+ * the cache sizing loop that executes in KSEG1 space or else
+ * you will crash and burn badly.  You have been warned.
+ */
+static int __init probe_scache(unsigned long config)
+{
+	extern unsigned long stext;
+	unsigned long flags, addr, begin, end, pow2;
+	int tmp;
+
+	tmp = ((config >> 17) & 1);
+	if(tmp)
+		return 0;
+	tmp = ((config >> 22) & 3);
+	switch(tmp) {
+	case 0:
+		sc_lsize = 16;
+		break;
+	case 1:
+		sc_lsize = 32;
+		break;
+	case 2:
+		sc_lsize = 64;
+		break;
+	case 3:
+		sc_lsize = 128;
+		break;
+	}
+
+	begin = (unsigned long) &stext;
+	begin &= ~((4 * 1024 * 1024) - 1);
+	end = begin + (4 * 1024 * 1024);
+
+	/* This is such a bitch, you'd think they would make it
+	 * easy to do this.  Away you daemons of stupidity!
+	 */
+	__save_and_cli(flags);
+
+	/* Fill each size-multiple cache line with a valid tag. */
+	pow2 = (64 * 1024);
+	for(addr = begin; addr < end; addr = (begin + pow2)) {
+		unsigned long *p = (unsigned long *) addr;
+		__asm__ __volatile__("nop" : : "r" (*p)); /* whee... */
+		pow2 <<= 1;
+	}
+
+	/* Load first line with zero (therefore invalid) tag. */
+	set_taglo(0);
+	set_taghi(0);
+	__asm__ __volatile__("nop; nop; nop; nop;"); /* avoid the hazard */
+	__asm__ __volatile__("\n\t.set noreorder\n\t"
+			     ".set mips3\n\t"
+			     "cache 8, (%0)\n\t"
+			     ".set mips0\n\t"
+			     ".set reorder\n\t" : : "r" (begin));
+	__asm__ __volatile__("\n\t.set noreorder\n\t"
+			     ".set mips3\n\t"
+			     "cache 9, (%0)\n\t"
+			     ".set mips0\n\t"
+			     ".set reorder\n\t" : : "r" (begin));
+	__asm__ __volatile__("\n\t.set noreorder\n\t"
+			     ".set mips3\n\t"
+			     "cache 11, (%0)\n\t"
+			     ".set mips0\n\t"
+			     ".set reorder\n\t" : : "r" (begin));
+
+	/* Now search for the wrap around point. */
+	pow2 = (128 * 1024);
+	tmp = 0;
+	for(addr = (begin + (128 * 1024)); addr < (end); addr = (begin + pow2)) {
+		__asm__ __volatile__("\n\t.set noreorder\n\t"
+				     ".set mips3\n\t"
+				     "cache 7, (%0)\n\t"
+				     ".set mips0\n\t"
+				     ".set reorder\n\t" : : "r" (addr));
+		__asm__ __volatile__("nop; nop; nop; nop;"); /* hazard... */
+		if(!get_taglo())
+			break;
+		pow2 <<= 1;
+	}
+	__restore_flags(flags);
+	addr -= begin;
+	printk("Secondary cache sized at %dK linesize %d bytes.\n",
+	       (int) (addr >> 10), sc_lsize);
+	scache_size = addr;
+	return 1;
+}
+
+static void __init setup_noscache_funcs(void)
+{
+	/* For the NEC Vr5000 cachelines are always 32 bytes, so
+	 * we don't test for this explicitly. */
+
+	_clear_page = r4k_clear_page_d32;
+	_copy_page = r4k_copy_page_d32;
+	_flush_cache_all = r4k_flush_cache_all_d32i32;
+	_flush_cache_range = r5k_flush_cache_range;
+	_flush_cache_mm = r4k_flush_cache_mm_d32i32;
+	_flush_cache_page = r4k_flush_cache_page_d32i32_r4600;
+	_flush_page_to_ram = r4k_flush_page_to_ram_d32;
+
+	___flush_cache_all = _flush_cache_all;
+	_flush_icache_page = r4k_flush_icache_page_p;
+	_dma_cache_wback_inv = r5k_dma_cache_wback_inv;
+	_dma_cache_wback = r5k_dma_cache_wback;
+	_dma_cache_inv = r5k_dma_cache_inv;
+}
+
+static void __init setup_scache_funcs(void)
+{
+	/* The level 2 cache on R5000 is not quite like the one on
+	 * good old R4000. E.g. it cannot have dirty lines, so it has
+	 * no Create_Dirty_Exclusive or xxx_Writeback_Invalidate.
+	 * We assume here that it is sufficient for the flush_cache
+	 * routines to sync the caches to RAM and invalidate the
+	 * primary caches. The secondary cache may still contain
+	 * valid data though.
+	 */
+	/* For the NEC Vr5000 cachelines are always 32 bytes, so
+	 * we don't test for this explicitly. */
+
+	_clear_page = r4k_clear_page_d32;
+	_copy_page = r4k_copy_page_d32;
+	_flush_cache_all = r4k_flush_cache_all_d32i32;
+	_flush_cache_range = r5k_flush_cache_range;
+	_flush_cache_mm = r4k_flush_cache_mm_d32i32;
+	_flush_cache_page = r4k_flush_cache_page_d32i32_r4600;
+	_flush_page_to_ram = r4k_flush_page_to_ram_d32;
+
+	___flush_cache_all = _flush_cache_all;
+	_flush_icache_page = r4k_flush_icache_page_p;
+	_dma_cache_wback_inv = r5k_dma_cache_wback_inv;
+	_dma_cache_wback = r5k_dma_cache_wback;
+	_dma_cache_inv = r5k_dma_cache_inv;
+}
+
+typedef int (*probe_func_t)(unsigned long);
+
+static inline void __init setup_scache(unsigned int config)
+{
+	probe_func_t probe_scache_kseg1;
+
+	/* Maybe the cpu knows about a l2 cache? */
+	probe_scache_kseg1 = (probe_func_t) (KSEG1ADDR(&probe_scache));
+	sc_present = probe_scache_kseg1(config);
+
+	if (sc_present) {
+		setup_scache_funcs();
+		return;
+	}
+
+	setup_noscache_funcs();
+}
+
+void __init ld_mmu_r5000(void)
+{
+	unsigned long config = read_32bit_cp0_register(CP0_CONFIG);
+
+#ifdef CONFIG_MIPS_UNCACHED
+	change_cp0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);
+#else
+	change_cp0_config(CONF_CM_CMASK, CONF_CM_CACHABLE_NONCOHERENT);
+#endif
+
+	probe_icache(config);
+	probe_dcache(config);
+	setup_scache(config);
+
+	_flush_cache_sigtramp = r4k_flush_cache_sigtramp;
+	_flush_icache_range = r4k_flush_icache_range;	/* Ouch */
+
+	__flush_cache_all();
+}

--------------070509040506040600040500--
