Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Nov 2004 20:38:12 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:17169
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225322AbUKUUh7>; Sun, 21 Nov 2004 20:37:59 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CVyT8-0004Kt-00; Sun, 21 Nov 2004 21:37:58 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CVyT7-0007SJ-00; Sun, 21 Nov 2004 21:37:57 +0100
Date: Sun, 21 Nov 2004 21:37:57 +0100
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/MIPS Development <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] Synthesize TLB refill handler at runtime
Message-ID: <20041121203757.GS20986@rembrandt.csv.ica.uni-stuttgart.de>
References: <20041121170242.GR20986@rembrandt.csv.ica.uni-stuttgart.de> <Pine.GSO.4.61.0411212048520.26374@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.61.0411212048520.26374@waterleaf.sonytel.be>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6390
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Geert Uytterhoeven wrote:
> On Sun, 21 Nov 2004, Thiemo Seufer wrote:
> > currently we have a large number of TLB refill handlers written in
> > hand-optimized assembly which are mostly indentical. The appended
> > patch removes them all, and adds a micro-assembler instead which
> > synthesizes the proper variant for the CPU at runtime.
> 
> Woow.....
> 
> I found a few typos (in the comments, didn't verify the code ;-)
> 
>     s/Systhesize/Synthesize/
>     s/systhesizer/synthesizer/

Aww, fatal error in the spelling module. :-)
Updated.


Thiemo


Index: arch/mips/mm/Makefile
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/Makefile,v
retrieving revision 1.68
diff -u -p -r1.68 Makefile
--- arch/mips/mm/Makefile	20 Jun 2004 23:52:17 -0000	1.68
+++ arch/mips/mm/Makefile	20 Nov 2004 16:46:40 -0000
@@ -2,7 +2,8 @@
 # Makefile for the Linux/MIPS-specific parts of the memory manager.
 #
 
-obj-y				+= cache.o extable.o fault.o init.o pgtable.o
+obj-y				+= cache.o extable.o fault.o init.o pgtable.o \
+				   tlbex.o
 
 obj-$(CONFIG_MIPS32)		+= ioremap.o pgtable-32.o
 obj-$(CONFIG_MIPS64)		+= pgtable-64.o
@@ -47,16 +48,16 @@ obj-$(CONFIG_CPU_SB1)		+= tlbex32-r4k.o
 obj-$(CONFIG_CPU_TX39XX)	+= tlbex32-r3k.o
 endif
 ifdef CONFIG_MIPS64
-obj-$(CONFIG_CPU_R4300)		+= tlb64-glue-r4k.o tlbex64-r4k.o
-obj-$(CONFIG_CPU_R4X00)		+= tlb64-glue-r4k.o tlbex64-r4k.o
-obj-$(CONFIG_CPU_R5000)		+= tlb64-glue-r4k.o tlbex64-r4k.o
-obj-$(CONFIG_CPU_NEVADA)	+= tlb64-glue-r4k.o tlbex64-r4k.o
-obj-$(CONFIG_CPU_R5432)		+= tlb64-glue-r4k.o tlbex64-r4k.o
-obj-$(CONFIG_CPU_RM7000)	+= tlb64-glue-r4k.o tlbex64-r4k.o
-obj-$(CONFIG_CPU_RM9000)	+= tlb64-glue-r4k.o tlbex64-r4k.o
-obj-$(CONFIG_CPU_R10000)	+= tlb64-glue-r4k.o tlbex64-r4k.o
-obj-$(CONFIG_CPU_SB1)		+= tlb64-glue-sb1.o tlbex64-r4k.o
-obj-$(CONFIG_CPU_MIPS64)	+= tlb64-glue-r4k.o tlbex64-r4k.o
+obj-$(CONFIG_CPU_R4300)		+= tlb64-glue-r4k.o
+obj-$(CONFIG_CPU_R4X00)		+= tlb64-glue-r4k.o
+obj-$(CONFIG_CPU_R5000)		+= tlb64-glue-r4k.o
+obj-$(CONFIG_CPU_NEVADA)	+= tlb64-glue-r4k.o
+obj-$(CONFIG_CPU_R5432)		+= tlb64-glue-r4k.o
+obj-$(CONFIG_CPU_RM7000)	+= tlb64-glue-r4k.o
+obj-$(CONFIG_CPU_RM9000)	+= tlb64-glue-r4k.o
+obj-$(CONFIG_CPU_R10000)	+= tlb64-glue-r4k.o
+obj-$(CONFIG_CPU_SB1)		+= tlb64-glue-sb1.o
+obj-$(CONFIG_CPU_MIPS64)	+= tlb64-glue-r4k.o
 endif
 
 
Index: arch/mips/mm/tlb-andes.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/tlb-andes.c,v
retrieving revision 1.8
diff -u -p -r1.8 tlb-andes.c
--- arch/mips/mm/tlb-andes.c	19 Oct 2004 02:21:16 -0000	1.8
+++ arch/mips/mm/tlb-andes.c	20 Nov 2004 16:46:46 -0000
@@ -17,10 +17,7 @@
 #include <asm/system.h>
 #include <asm/mmu_context.h>
 
-extern void except_vec0_generic(void);
-extern void except_vec0_r4000(void);
-extern void except_vec1_generic(void);
-extern void except_vec1_r4k(void);
+extern void build_tlb_refill_handler(void);
 
 #define NTLB_ENTRIES       64
 #define NTLB_ENTRIES_HALF  32
@@ -257,14 +254,5 @@ void __init tlb_init(void)
 
 	/* Did I tell you that ARC SUCKS?  */
 
-#ifdef CONFIG_MIPS32
-	memcpy((void *)KSEG0, &except_vec0_r4000, 0x80);
-	memcpy((void *)(KSEG0 + 0x080), &except_vec1_generic, 0x80);
-	flush_icache_range(KSEG0, KSEG0 + 0x100);
-#endif
-#ifdef CONFIG_MIPS64
-	memcpy((void *)(CKSEG0 + 0x000), &except_vec0_generic, 0x80);
-	memcpy((void *)(CKSEG0 + 0x080), except_vec1_r4k, 0x80);
-	flush_icache_range(CKSEG0 + 0x80, CKSEG0 + 0x100);
-#endif
+	build_tlb_refill_handler();
 }
Index: arch/mips/mm/tlb-r3k.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/tlb-r3k.c,v
retrieving revision 1.26
diff -u -p -r1.26 tlb-r3k.c
--- arch/mips/mm/tlb-r3k.c	11 Dec 2003 16:27:01 -0000	1.26
+++ arch/mips/mm/tlb-r3k.c	20 Nov 2004 16:46:46 -0000
@@ -26,7 +26,7 @@
 
 #undef DEBUG_TLB
 
-extern char except_vec0_r2300;
+extern void build_tlb_refill_handler(void);
 
 /* CP0 hazard avoidance. */
 #define BARRIER				\
@@ -284,6 +284,6 @@ void __init add_wired_entry(unsigned lon
 void __init tlb_init(void)
 {
 	local_flush_tlb_all();
-	memcpy((void *)KSEG0, &except_vec0_r2300, 0x80);
-	flush_icache_range(KSEG0, KSEG0 + 0x80);
+
+	build_tlb_refill_handler();
 }
Index: arch/mips/mm/tlb-r4k.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/tlb-r4k.c,v
retrieving revision 1.38
diff -u -p -r1.38 tlb-r4k.c
--- arch/mips/mm/tlb-r4k.c	19 Mar 2004 04:07:59 -0000	1.38
+++ arch/mips/mm/tlb-r4k.c	20 Nov 2004 16:46:46 -0000
@@ -19,12 +19,7 @@
 #include <asm/pgtable.h>
 #include <asm/system.h>
 
-extern void except_vec0_generic(void);
-extern void except_vec0_nevada(void);
-extern void except_vec0_r4000(void);
-extern void except_vec0_r4600(void);
-extern void except_vec1_generic(void);
-extern void except_vec1_r4k(void);
+extern void build_tlb_refill_handler(void);
 
 /* CP0 hazard avoidance. */
 #define BARRIER __asm__ __volatile__(".set noreorder\n\t" \
@@ -414,19 +409,5 @@ void __init tlb_init(void)
 	temp_tlb_entry = current_cpu_data.tlbsize - 1;
 	local_flush_tlb_all();
 
-#ifdef CONFIG_MIPS32
-	if (current_cpu_data.cputype == CPU_NEVADA)
-		memcpy((void *)KSEG0, &except_vec0_nevada, 0x80);
-	else if (current_cpu_data.cputype == CPU_R4600)
-		memcpy((void *)KSEG0, &except_vec0_r4600, 0x80);
-	else
-		memcpy((void *)KSEG0, &except_vec0_r4000, 0x80);
-	memcpy((void *)(KSEG0 + 0x080), &except_vec1_generic, 0x80);
-	flush_icache_range(KSEG0, KSEG0 + 0x100);
-#endif
-#ifdef CONFIG_MIPS64
-	memcpy((void *)(CKSEG0 + 0x00), &except_vec0_generic, 0x80);
-	memcpy((void *)(CKSEG0 + 0x80), except_vec1_r4k, 0x80);
-	flush_icache_range(CKSEG0 + 0x80, CKSEG0 + 0x100);
-#endif
+	build_tlb_refill_handler();
 }
Index: arch/mips/mm/tlb-r8k.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/tlb-r8k.c,v
retrieving revision 1.1
diff -u -p -r1.1 tlb-r8k.c
--- arch/mips/mm/tlb-r8k.c	20 Jun 2004 23:01:07 -0000	1.1
+++ arch/mips/mm/tlb-r8k.c	20 Nov 2004 16:46:46 -0000
@@ -19,8 +19,7 @@
 #include <asm/pgtable.h>
 #include <asm/system.h>
 
-extern void except_vec0_generic(void);
-extern void except_vec1_r8k(void);
+extern void build_tlb_refill_handler(void);
 
 #define TFP_TLB_SIZE		384
 #define TFP_TLB_SET_SHIFT	7
@@ -247,7 +246,5 @@ void __init tlb_init(void)
 
 	local_flush_tlb_all();
 
-	memcpy((void *)(CKSEG0 + 0x00), &except_vec0_generic, 0x80);
-	memcpy((void *)(CKSEG0 + 0x80), except_vec1_r8k, 0x80);
-	flush_icache_range(CKSEG0 + 0x80, CKSEG0 + 0x100);
+	build_tlb_refill_handler();
 }
Index: arch/mips/mm/tlb-sb1.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/tlb-sb1.c,v
retrieving revision 1.45
diff -u -p -r1.45 tlb-sb1.c
--- arch/mips/mm/tlb-sb1.c	23 Oct 2004 01:18:17 -0000	1.45
+++ arch/mips/mm/tlb-sb1.c	20 Nov 2004 16:46:46 -0000
@@ -23,14 +23,7 @@
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
 
-#ifdef CONFIG_MIPS32
-extern void except_vec0_sb1(void);
-extern void except_vec1_generic(void);
-#endif
-#ifdef CONFIG_MIPS64
-extern void except_vec0_generic(void);
-extern void except_vec1_sb1(void);
-#endif
+extern void build_tlb_refill_handler(void);
 
 #define UNIQUE_ENTRYHI(idx) (KSEG0 + ((idx) << (PAGE_SHIFT + 1)))
 
@@ -380,14 +373,5 @@ void tlb_init(void)
 	 */
 	sb1_sanitize_tlb();
 
-#ifdef CONFIG_MIPS32
-	memcpy((void *)KSEG0, &except_vec0_sb1, 0x80);
-	memcpy((void *)(KSEG0 + 0x080), &except_vec1_generic, 0x80);
-	flush_icache_range(KSEG0, KSEG0 + 0x100);
-#endif
-#ifdef CONFIG_MIPS64
-	memcpy((void *)CKSEG0, &except_vec0_generic, 0x80);
-	memcpy((void *)(CKSEG0 + 0x80), &except_vec1_sb1, 0x80);
-	flush_icache_range(CKSEG0, CKSEG0 + 0x100);
-#endif
+	build_tlb_refill_handler();
 }
Index: arch/mips/mm/tlbex32-r3k.S
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/tlbex32-r3k.S,v
retrieving revision 1.1
diff -u -p -r1.1 tlbex32-r3k.S
--- arch/mips/mm/tlbex32-r3k.S	20 Jun 2004 23:52:17 -0000	1.1
+++ arch/mips/mm/tlbex32-r3k.S	20 Nov 2004 16:46:46 -0000
@@ -24,36 +24,6 @@
 
 #define TLB_OPTIMIZE /* If you are paranoid, disable this. */
 
-	.text
-	.set	mips1
-	.set	noreorder
-
-	__INIT
-
-	/* TLB refill, R[23]00 version */
-	LEAF(except_vec0_r2300)
-	.set	noat
-	.set	mips1
-	mfc0	k0, CP0_BADVADDR
-	lw	k1, pgd_current			# get pgd pointer
-	srl	k0, k0, 22
-	sll	k0, k0, 2
-	addu	k1, k1, k0
-	mfc0	k0, CP0_CONTEXT
-	lw	k1, (k1)
-	and	k0, k0, 0xffc
-	addu	k1, k1, k0
-	lw	k0, (k1)
-	nop
-	mtc0	k0, CP0_ENTRYLO0
-	mfc0	k1, CP0_EPC
-	tlbwr
-	jr	k1
-	rfe
-	END(except_vec0_r2300)
-
-	__FINIT
-
 	/* ABUSE of CPP macros 101. */
 
 	/* After this macro runs, the pte faulted on is
Index: arch/mips/mm/tlbex32-r4k.S
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/tlbex32-r4k.S,v
retrieving revision 1.2
diff -u -p -r1.2 tlbex32-r4k.S
--- arch/mips/mm/tlbex32-r4k.S	3 Oct 2004 01:16:24 -0000	1.2
+++ arch/mips/mm/tlbex32-r4k.S	20 Nov 2004 16:46:46 -0000
@@ -139,272 +139,6 @@
 			   _PAGE_VALID | _PAGE_DIRTY); \
 	PTE_S	pte, (ptr);
 
-	__INIT
-
-#ifdef CONFIG_64BIT_PHYS_ADDR
-#define GET_PTE_OFF(reg)
-#elif CONFIG_CPU_VR41XX
-#define GET_PTE_OFF(reg)	srl	reg, reg, 3
-#else
-#define GET_PTE_OFF(reg)	srl	reg, reg, 1
-#endif
-
-/*
- * These handlers much be written in a relocatable manner
- * because based upon the cpu type an arbitrary one of the
- * following pieces of code will be copied to the KSEG0
- * vector location.
- */
-	/* TLB refill, EXL == 0, R4xx0, non-R4600 version */
-	.set	noreorder
-	.set	noat
-	LEAF(except_vec0_r4000)
-	.set	mips3
-	GET_PGD(k0, k1)				# get pgd pointer
-	mfc0	k0, CP0_BADVADDR		# Get faulting address
-	srl	k0, k0, _PGDIR_SHIFT		# get pgd only bits
-
-	sll	k0, k0, 2
-	addu	k1, k1, k0			# add in pgd offset
-	mfc0	k0, CP0_CONTEXT			# get context reg
-	lw	k1, (k1)
-	GET_PTE_OFF(k0)				# get pte offset
-	and	k0, k0, PTEP_INDX_MSK
-	addu	k1, k1, k0			# add in offset
-	PTE_L	k0, 0(k1)			# get even pte
-	PTE_L	k1, PTE_SIZE(k1)		# get odd pte
-	PTE_SRL	k0, k0, 6			# convert to entrylo0
-	P_MTC0	k0, CP0_ENTRYLO0		# load it
-	PTE_SRL	k1, k1, 6			# convert to entrylo1
-	P_MTC0	k1, CP0_ENTRYLO1		# load it
-	mtc0_tlbw_hazard
-	tlbwr					# write random tlb entry
-	nop
-	tlbw_eret_hazard
-	eret					# return from trap
-	END(except_vec0_r4000)
-
-	/* TLB refill, EXL == 0, R4600 version */
-	LEAF(except_vec0_r4600)
-	.set	mips3
-	GET_PGD(k0, k1)				# get pgd pointer
-	mfc0	k0, CP0_BADVADDR
-	srl	k0, k0, _PGDIR_SHIFT
-	sll	k0, k0, 2			# log2(sizeof(pgd_t)
-	addu	k1, k1, k0
-	mfc0	k0, CP0_CONTEXT
-	lw	k1, (k1)
-	GET_PTE_OFF(k0)				# get pte offset
-	and	k0, k0, PTEP_INDX_MSK
-	addu	k1, k1, k0
-	PTE_L	k0, 0(k1)
-	PTE_L	k1, PTE_SIZE(k1)
-	PTE_SRL	k0, k0, 6
-	P_MTC0	k0, CP0_ENTRYLO0
-	PTE_SRL	k1, k1, 6
-	P_MTC0	k1, CP0_ENTRYLO1
-	nop
-	tlbwr
-	nop
-	eret
-	END(except_vec0_r4600)
-
-	/* TLB refill, EXL == 0, R52x0 "Nevada" version */
-        /*
-         * This version has a bug workaround for the Nevada.  It seems
-         * as if under certain circumstances the move from cp0_context
-         * might produce a bogus result when the mfc0 instruction and
-         * it's consumer are in a different cacheline or a load instruction,
-         * probably any memory reference, is between them.  This is
-         * potencially slower than the R4000 version, so we use this
-         * special version.
-         */
-	.set	noreorder
-	.set	noat
-	LEAF(except_vec0_nevada)
-	.set	mips3
-	mfc0	k0, CP0_BADVADDR		# Get faulting address
-	srl	k0, k0, _PGDIR_SHIFT		# get pgd only bits
-	lw	k1, pgd_current			# get pgd pointer
-	sll	k0, k0, 2			# log2(sizeof(pgd_t)
-	addu	k1, k1, k0			# add in pgd offset
-	lw	k1, (k1)
-	mfc0	k0, CP0_CONTEXT			# get context reg
-	GET_PTE_OFF(k0)				# get pte offset
-	and	k0, k0, PTEP_INDX_MSK
-	addu	k1, k1, k0			# add in offset
-	PTE_L	k0, 0(k1)			# get even pte
-	PTE_L	k1, PTE_SIZE(k1)		# get odd pte
-	PTE_SRL	k0, k0, 6			# convert to entrylo0
-	P_MTC0	k0, CP0_ENTRYLO0		# load it
-	PTE_SRL	k1, k1, 6			# convert to entrylo1
-	P_MTC0	k1, CP0_ENTRYLO1		# load it
-	nop					# QED specified nops
-	nop
-	tlbwr					# write random tlb entry
-	nop					# traditional nop
-	eret					# return from trap
-	END(except_vec0_nevada)
-
-	/* TLB refill, EXL == 0, SB1 with M3 errata handling version */
-	LEAF(except_vec0_sb1)
-#if BCM1250_M3_WAR
-	mfc0	k0, CP0_BADVADDR
-	mfc0	k1, CP0_ENTRYHI
-	xor	k0, k1
-	srl	k0, k0, PAGE_SHIFT+1
-	bnez	k0, 1f
-#endif
-	GET_PGD(k0, k1)				# get pgd pointer
-	mfc0	k0, CP0_BADVADDR		# Get faulting address
-	srl	k0, k0, _PGDIR_SHIFT		# get pgd only bits
-	sll	k0, k0, 2
-	addu	k1, k1, k0			# add in pgd offset
-	mfc0	k0, CP0_CONTEXT			# get context reg
-	lw	k1, (k1)
-	GET_PTE_OFF(k0)				# get pte offset
-	and	k0, k0, PTEP_INDX_MSK
-	addu	k1, k1, k0			# add in offset
-	PTE_L	k0, 0(k1)			# get even pte
-	PTE_L	k1, PTE_SIZE(k1)		# get odd pte
-	PTE_SRL	k0, k0, 6			# convert to entrylo0
-	P_MTC0	k0, CP0_ENTRYLO0		# load it
-	PTE_SRL	k1, k1, 6			# convert to entrylo1
-	P_MTC0	k1, CP0_ENTRYLO1		# load it
-	tlbwr					# write random tlb entry
-1:	eret					# return from trap
-	END(except_vec0_sb1)
-
-	/* TLB refill, EXL == 0, R4[40]00/R5000 badvaddr hwbug version */
-	LEAF(except_vec0_r45k_bvahwbug)
-	.set	mips3
-	GET_PGD(k0, k1)				# get pgd pointer
-	mfc0	k0, CP0_BADVADDR
-	srl	k0, k0, _PGDIR_SHIFT
-	sll	k0, k0, 2			# log2(sizeof(pgd_t)
-	addu	k1, k1, k0
-	mfc0	k0, CP0_CONTEXT
-	lw	k1, (k1)
-#ifndef CONFIG_64BIT_PHYS_ADDR
-	srl	k0, k0, 1
-#endif
-	and	k0, k0, PTEP_INDX_MSK
-	addu	k1, k1, k0
-	PTE_L	k0, 0(k1)
-	PTE_L	k1, PTE_SIZE(k1)
-	nop				/* XXX */
-	tlbp
-	PTE_SRL	k0, k0, 6
-	P_MTC0	k0, CP0_ENTRYLO0
-	PTE_SRL	k1, k1, 6
-	mfc0	k0, CP0_INDEX
-	P_MTC0	k1, CP0_ENTRYLO1
-	bltzl	k0, 1f
-	tlbwr
-1:
-	nop
-	eret
-	END(except_vec0_r45k_bvahwbug)
-
-#ifdef CONFIG_SMP
-	/* TLB refill, EXL == 0, R4000 MP badvaddr hwbug version */
-	LEAF(except_vec0_r4k_mphwbug)
-	.set	mips3
-	GET_PGD(k0, k1)				# get pgd pointer
-	mfc0	k0, CP0_BADVADDR
-	srl	k0, k0, _PGDIR_SHIFT
-	sll	k0, k0, 2			# log2(sizeof(pgd_t)
-	addu	k1, k1, k0
-	mfc0	k0, CP0_CONTEXT
-	lw	k1, (k1)
-#ifndef CONFIG_64BIT_PHYS_ADDR
-	srl	k0, k0, 1
-#endif
-	and	k0, k0, PTEP_INDX_MSK
-	addu	k1, k1, k0
-	PTE_L	k0, 0(k1)
-	PTE_L	k1, PTE_SIZE(k1)
-	nop				/* XXX */
-	tlbp
-	PTE_SRL	k0, k0, 6
-	P_MTC0	k0, CP0_ENTRYLO0
-	PTE_SRL	k1, k1, 6
-	mfc0	k0, CP0_INDEX
-	P_MTC0	k1, CP0_ENTRYLO1
-	bltzl	k0, 1f
-	tlbwr
-1:
-	nop
-	eret
-	END(except_vec0_r4k_mphwbug)
-#endif
-
-	/* TLB refill, EXL == 0, R4000 UP 250MHZ entrylo[01] hwbug version */
-	LEAF(except_vec0_r4k_250MHZhwbug)
-	.set	mips3
-	GET_PGD(k0, k1)				# get pgd pointer
-	mfc0	k0, CP0_BADVADDR
-	srl	k0, k0, _PGDIR_SHIFT
-	sll	k0, k0, 2			# log2(sizeof(pgd_t)
-	addu	k1, k1, k0
-	mfc0	k0, CP0_CONTEXT
-	lw	k1, (k1)
-#ifndef CONFIG_64BIT_PHYS_ADDR
-	srl	k0, k0, 1
-#endif
-	and	k0, k0, PTEP_INDX_MSK
-	addu	k1, k1, k0
-	PTE_L	k0, 0(k1)
-	PTE_L	k1, PTE_SIZE(k1)
-	PTE_SRL	k0, k0, 6
-	P_MTC0	zero, CP0_ENTRYLO0
-	P_MTC0	k0, CP0_ENTRYLO0
-	PTE_SRL	k1, k1, 6
-	P_MTC0	zero, CP0_ENTRYLO1
-	P_MTC0	k1, CP0_ENTRYLO1
-	b	1f
-	tlbwr
-1:
-	nop
-	eret
-	END(except_vec0_r4k_250MHZhwbug)
-
-#ifdef CONFIG_SMP
-	/* TLB refill, EXL == 0, R4000 MP 250MHZ entrylo[01]+badvaddr bug version */
-	LEAF(except_vec0_r4k_MP250MHZhwbug)
-	.set	mips3
-	GET_PGD(k0, k1)				# get pgd pointer
-	mfc0	k0, CP0_BADVADDR
-	srl	k0, k0, _PGDIR_SHIFT
-	sll	k0, k0, 2			# log2(sizeof(pgd_t)
-	addu	k1, k1, k0
-	mfc0	k0, CP0_CONTEXT
-	lw	k1, (k1)
-#ifndef CONFIG_64BIT_PHYS_ADDR
-	srl	k0, k0, 1
-#endif
-	and	k0, k0, PTEP_INDX_MSK
-	addu	k1, k1, k0
-	PTE_L	k0, 0(k1)
-	PTE_L	k1, PTE_SIZE(k1)
-	nop				/* XXX */
-	tlbp
-	PTE_SRL	k0, k0, 6
-	P_MTC0  zero, CP0_ENTRYLO0
-	P_MTC0  k0, CP0_ENTRYLO0
-	mfc0    k0, CP0_INDEX
-	PTE_SRL	k1, k1, 6
-	P_MTC0	zero, CP0_ENTRYLO1
-	P_MTC0	k1, CP0_ENTRYLO1
-	bltzl	k0, 1f
-	tlbwr
-1:
-	nop
-	eret
-	END(except_vec0_r4k_MP250MHZhwbug)
-#endif
-
-	__FINIT
 
 	.set	noreorder
 
--- /dev/null	2004-08-24 19:23:08.000000000 +0200
+++ arch/mips/mm/tlbex.c	2004-11-20 17:41:35.000000000 +0100
@@ -0,0 +1,1162 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Synthesize TLB refill handlers at runtime.
+ * 
+ * Copyright (C) 2004 by Thiemo Seufer
+ */
+
+#include <stdarg.h>
+
+#include <linux/config.h>
+#include <linux/mm.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/init.h>
+
+#include <asm/pgtable.h>
+#include <asm/cacheflush.h>
+#include <asm/cacheflush.h>
+#include <asm/mmu_context.h>
+#include <asm/inst.h>
+#include <asm/elf.h>
+#include <asm/smp.h>
+
+/* #define DEBUG_TLB */
+
+static __init int r45k_bvahwbug(void)
+{
+	/* XXX: We should probe for the presence of this bug, but we don't. */
+	return 0;
+}
+
+static __init int r4k_250MHZhwbug(void)
+{
+	/* XXX: We should probe for the presence of this bug, but we don't. */
+	return 0;
+}
+
+static __init int bcm1250_m3_war(void)
+{
+	return BCM1250_M3_WAR;
+}
+
+/*
+ * A little micro-assembler, intended for TLB refill handler
+ * synthesizing. It is intentionally kept simple, does only support
+ * a subset of instructions, and does not try to hide pipeline effects
+ * like branch delay slots.
+ */
+
+enum fields
+{
+	RS = 0x001,
+	RT = 0x002,
+	RD = 0x004,
+	RE = 0x008,
+	SIMM = 0x010,
+	UIMM = 0x020,
+	BIMM = 0x040,
+	JIMM = 0x080,
+	FUNC = 0x100,
+};
+
+#define OP_MASK		0x2f
+#define OP_SH		26
+#define RS_MASK		0x1f
+#define RS_SH		21
+#define RT_MASK		0x1f
+#define RT_SH		16
+#define RD_MASK		0x1f
+#define RD_SH		11
+#define RE_MASK		0x1f
+#define RE_SH		6
+#define IMM_MASK	0xffff
+#define IMM_SH		0
+#define JIMM_MASK	0x3ffffff
+#define JIMM_SH		0
+#define FUNC_MASK	0x2f
+#define FUNC_SH		0
+
+enum opcode {
+	insn_invalid,
+	insn_addu, insn_addiu, insn_and, insn_andi, insn_beq,
+	insn_bgez, insn_bgezl, insn_bltz, insn_bltzl, insn_bne,
+	insn_daddu, insn_daddiu, insn_dmfc0, insn_dmtc0,
+	insn_dsll, insn_dsll32, insn_dsra, insn_dsrl, insn_dsrl32,
+	insn_dsubu, insn_eret, insn_j, insn_jal, insn_jr, insn_ld,
+	insn_lui, insn_lw, insn_mfc0, insn_mtc0, insn_ori, insn_rfe,
+	insn_sd, insn_sll, insn_sra, insn_srl, insn_subu, insn_sw,
+	insn_tlbp, insn_tlbwi, insn_tlbwr, insn_xor, insn_xori
+};
+
+struct insn {
+	enum opcode opcode;
+	u32 match;
+	enum fields fields;
+};
+
+/* This macro sets the non-variable bits of an instruction. */
+#define M(a, b, c, d, e, f)					\
+	((a) << OP_SH						\
+	 | (b) << RS_SH						\
+	 | (c) << RT_SH						\
+	 | (d) << RD_SH						\
+	 | (e) << RE_SH						\
+	 | (f) << FUNC_SH)
+
+static __initdata struct insn insn_table[] = {
+	{ insn_addiu, M(addiu_op,0,0,0,0,0), RS | RT | SIMM },
+	{ insn_addu, M(spec_op,0,0,0,0,addu_op), RS | RT | RD },
+	{ insn_and, M(spec_op,0,0,0,0,and_op), RS | RT | RD },
+	{ insn_andi, M(andi_op,0,0,0,0,0), RS | RT | UIMM },
+	{ insn_beq, M(beq_op,0,0,0,0,0), RS | RT | BIMM },
+	{ insn_bgez, M(bcond_op,0,bgez_op,0,0,0), RS | BIMM },
+	{ insn_bgezl, M(bcond_op,0,bgezl_op,0,0,0), RS | BIMM },
+	{ insn_bltz, M(bcond_op,0,bltz_op,0,0,0), RS | BIMM },
+	{ insn_bltzl, M(bcond_op,0,bltzl_op,0,0,0), RS | BIMM },
+	{ insn_bne, M(bne_op,0,0,0,0,0), RS | RT | BIMM },
+	{ insn_daddiu, M(daddiu_op,0,0,0,0,0), RS | RT | SIMM },
+	{ insn_daddu, M(spec_op,0,0,0,0,daddu_op), RS | RT | RD },
+	{ insn_dmfc0, M(cop0_op,dmfc_op,0,0,0,0), RT | RD },
+	{ insn_dmtc0, M(cop0_op,dmtc_op,0,0,0,0), RT | RD },
+	{ insn_dsll, M(spec_op,0,0,0,0,dsll_op), RT | RD | RE },
+	{ insn_dsll32, M(spec_op,0,0,0,0,dsll32_op), RT | RD | RE },
+	{ insn_dsra, M(spec_op,0,0,0,0,dsra_op), RT | RD | RE },
+	{ insn_dsrl, M(spec_op,0,0,0,0,dsrl_op), RT | RD | RE },
+	{ insn_dsrl32, M(spec_op,0,0,0,0,dsrl32_op), RT | RD | RE },
+	{ insn_dsubu, M(spec_op,0,0,0,0,dsubu_op), RS | RT | RD },
+	{ insn_eret, M(cop0_op,cop_op,0,0,0,eret_op), 0 },
+	{ insn_j, M(j_op,0,0,0,0,0), JIMM },
+	{ insn_jal, M(jal_op,0,0,0,0,0), JIMM },
+	{ insn_jr, M(spec_op,0,0,0,0,jr_op), RS },
+	{ insn_ld, M(ld_op,0,0,0,0,0), RS | RT | SIMM },
+	{ insn_lui, M(lui_op,0,0,0,0,0), RT | SIMM },
+	{ insn_lw, M(lw_op,0,0,0,0,0), RS | RT | SIMM },
+	{ insn_mfc0, M(cop0_op,mfc_op,0,0,0,0), RT | RD },
+	{ insn_mtc0, M(cop0_op,mtc_op,0,0,0,0), RT | RD },
+	{ insn_ori, M(ori_op,0,0,0,0,0), RS | RT | UIMM },
+	{ insn_rfe, M(cop0_op,cop_op,0,0,0,rfe_op), 0 },
+	{ insn_sd, M(sd_op,0,0,0,0,0), RS | RT | SIMM },
+	{ insn_sll, M(spec_op,0,0,0,0,sll_op), RT | RD | RE },
+	{ insn_sra, M(spec_op,0,0,0,0,sra_op), RT | RD | RE },
+	{ insn_srl, M(spec_op,0,0,0,0,srl_op), RT | RD | RE },
+	{ insn_subu, M(spec_op,0,0,0,0,subu_op), RS | RT | RD },
+	{ insn_sw, M(sw_op,0,0,0,0,0), RS | RT | SIMM },
+	{ insn_tlbp, M(cop0_op,cop_op,0,0,0,tlbp_op), 0 },
+	{ insn_tlbwi, M(cop0_op,cop_op,0,0,0,tlbwi_op), 0 },
+	{ insn_tlbwr, M(cop0_op,cop_op,0,0,0,tlbwr_op), 0 },
+	{ insn_xor, M(spec_op,0,0,0,0,xor_op), RS | RT | RD },
+	{ insn_xori, M(xori_op,0,0,0,0,0), RS | RT | UIMM },
+	{ insn_invalid, 0, 0 }
+};
+
+#undef M
+
+static __init u32 build_rs(u32 arg)
+{
+	if (arg & ~RS_MASK)
+		printk(KERN_WARNING "TLB synthesizer field overflow\n");
+
+	return (arg & RS_MASK) << RS_SH;
+}
+
+static __init u32 build_rt(u32 arg)
+{
+	if (arg & ~RT_MASK)
+		printk(KERN_WARNING "TLB synthesizer field overflow\n");
+
+	return (arg & RT_MASK) << RT_SH;
+}
+
+static __init u32 build_rd(u32 arg)
+{
+	if (arg & ~RD_MASK)
+		printk(KERN_WARNING "TLB synthesizer field overflow\n");
+
+	return (arg & RD_MASK) << RD_SH;
+}
+
+static __init u32 build_re(u32 arg)
+{
+	if (arg & ~RE_MASK)
+		printk(KERN_WARNING "TLB synthesizer field overflow\n");
+
+	return (arg & RE_MASK) << RE_SH;
+}
+
+static __init u32 build_simm(s32 arg)
+{
+	if (arg > 0x7fff || arg < -0x8000)
+		printk(KERN_WARNING "TLB synthesizer field overflow\n");
+
+	return arg & 0xffff;
+}
+
+static __init u32 build_uimm(u32 arg)
+{
+	if (arg & ~IMM_MASK)
+		printk(KERN_WARNING "TLB synthesizer field overflow\n");
+
+	return arg & IMM_MASK;
+}
+
+static __init u32 build_bimm(s32 arg)
+{
+	if (arg > 0x1ffff || arg < -0x20000)
+		printk(KERN_WARNING "TLB synthesizer field overflow\n");
+
+	if (arg & 0x3)
+		printk(KERN_WARNING "Invalid TLB synthesizer branch target\n");
+
+	return ((arg < 0) ? (1 << 15) : 0) | ((arg >> 2) & 0x7fff);
+}
+
+static __init u32 build_jimm(u32 arg)
+{
+	if (arg & ~((JIMM_MASK) << 2))
+		printk(KERN_WARNING "TLB synthesizer field overflow\n");
+
+	return (arg >> 2) & JIMM_MASK;
+}
+
+static __init u32 build_func(u32 arg)
+{
+	if (arg & ~FUNC_MASK)
+		printk(KERN_WARNING "TLB synthesizer field overflow\n");
+
+	return arg & FUNC_MASK;
+}
+
+/*
+ * The order of opcode arguments is implicitly left to right,
+ * starting with RS and ending with FUNC or IMM.
+ */
+static void __init build_insn(u32 **buf, enum opcode opc, ...)
+{
+	struct insn *ip = NULL;
+	unsigned int i;
+	va_list ap;
+	u32 op;
+
+	for (i = 0; insn_table[i].opcode != insn_invalid; i++)
+		if (insn_table[i].opcode == opc) {
+			ip = &insn_table[i];
+			break;
+		}
+
+	if (!ip)
+		panic("Unsupported TLB synthesizer instruction %d", opc);
+
+	op = ip->match;
+	va_start(ap, opc);
+	if (ip->fields & RS) op |= build_rs(va_arg(ap, u32));
+	if (ip->fields & RT) op |= build_rt(va_arg(ap, u32));
+	if (ip->fields & RD) op |= build_rd(va_arg(ap, u32));
+	if (ip->fields & RE) op |= build_re(va_arg(ap, u32));
+	if (ip->fields & SIMM) op |= build_simm(va_arg(ap, s32));
+	if (ip->fields & UIMM) op |= build_uimm(va_arg(ap, u32));
+	if (ip->fields & BIMM) op |= build_bimm(va_arg(ap, s32));
+	if (ip->fields & JIMM) op |= build_jimm(va_arg(ap, u32));
+	if (ip->fields & FUNC) op |= build_func(va_arg(ap, u32));
+	va_end(ap);
+
+	**buf = op;
+	(*buf)++;
+}
+
+#define I_u1u2u3(op)						\
+	static inline void i##op(u32 **buf, unsigned int a,	\
+	 	unsigned int b, unsigned int c)			\
+	{							\
+		build_insn(buf, insn##op, a, b, c);		\
+	}
+
+#define I_u2u1u3(op)						\
+	static inline void i##op(u32 **buf, unsigned int a,	\
+	 	unsigned int b, unsigned int c)			\
+	{							\
+		build_insn(buf, insn##op, b, a, c);		\
+	}
+
+#define I_u3u1u2(op)						\
+	static inline void i##op(u32 **buf, unsigned int a,	\
+	 	unsigned int b, unsigned int c)			\
+	{							\
+		build_insn(buf, insn##op, b, c, a);		\
+	}
+
+#define I_u1u2s3(op)						\
+	static inline void i##op(u32 **buf, unsigned int a,	\
+	 	unsigned int b, signed int c)			\
+	{							\
+		build_insn(buf, insn##op, a, b, c);		\
+	}
+
+#define I_u2s3u1(op)						\
+	static inline void i##op(u32 **buf, unsigned int a,	\
+	 	signed int b, unsigned int c)			\
+	{							\
+		build_insn(buf, insn##op, c, a, b);		\
+	}
+
+#define I_u2u1s3(op)						\
+	static inline void i##op(u32 **buf, unsigned int a,	\
+	 	unsigned int b, signed int c)			\
+	{							\
+		build_insn(buf, insn##op, b, a, c);		\
+	}
+
+#define I_u1u2(op)						\
+	static inline void i##op(u32 **buf, unsigned int a,	\
+	 	unsigned int b)					\
+	{							\
+		build_insn(buf, insn##op, a, b);		\
+	}
+
+#define I_u1s2(op)						\
+	static inline void i##op(u32 **buf, unsigned int a,	\
+	 	signed int b)					\
+	{							\
+		build_insn(buf, insn##op, a, b);		\
+	}
+
+#define I_u1(op)						\
+	static inline void i##op(u32 **buf, unsigned int a)	\
+	{							\
+		build_insn(buf, insn##op, a);			\
+	}
+
+#define I_0(op)							\
+	static inline void i##op(u32 **buf)			\
+	{							\
+		build_insn(buf, insn##op);			\
+	}
+
+I_u2u1s3(_addiu);
+I_u3u1u2(_addu);
+I_u2u1u3(_andi);
+I_u3u1u2(_and);
+I_u1u2s3(_beq);
+I_u1s2(_bgez);
+I_u1s2(_bgezl);
+I_u1s2(_bltz);
+I_u1s2(_bltzl);
+I_u1u2s3(_bne);
+I_u1u2(_dmfc0);
+I_u1u2(_dmtc0);
+I_u2u1s3(_daddiu);
+I_u3u1u2(_daddu);
+I_u2u1u3(_dsll);
+I_u2u1u3(_dsll32);
+I_u2u1u3(_dsra);
+I_u2u1u3(_dsrl);
+I_u2u1u3(_dsrl32);
+I_u3u1u2(_dsubu);
+I_0(_eret);
+I_u1(_j);
+I_u1(_jal);
+I_u1(_jr);
+I_u2s3u1(_ld);
+I_u1s2(_lui);
+I_u2s3u1(_lw);
+I_u1u2(_mfc0);
+I_u1u2(_mtc0);
+I_u2u1u3(_ori);
+I_0(_rfe);
+I_u2s3u1(_sd);
+I_u2u1u3(_sll);
+I_u2u1u3(_sra);
+I_u2u1u3(_srl);
+I_u3u1u2(_subu);
+I_u2s3u1(_sw);
+I_0(_tlbp);
+I_0(_tlbwi);
+I_0(_tlbwr);
+I_u3u1u2(_xor)
+I_u2u1u3(_xori);
+
+/*
+ * handling labels
+ */
+
+enum label_id {
+	label_invalid,
+	label_second_part,
+	label_leave,
+	label_vmalloc,
+	label_vmalloc_done,
+	label_tlbwr_hazard,
+	label_split
+};
+
+struct label {
+	u32 *addr;
+	enum label_id lab;
+};
+
+static __init void build_label(struct label **lab, u32 *addr,
+			       enum label_id l)
+{
+	(*lab)->addr = addr;
+	(*lab)->lab = l;
+	(*lab)++;
+}
+
+#define L_LA(lb)						\
+	static inline void l##lb(struct label **lab, u32 *addr) \
+	{							\
+		build_label(lab, addr, label##lb);		\
+	}
+
+L_LA(_second_part)
+L_LA(_leave)
+L_LA(_vmalloc)
+L_LA(_vmalloc_done)
+L_LA(_tlbwr_hazard)
+L_LA(_split)
+
+/* convenience macros for instructions */
+#ifdef CONFIG_MIPS64
+# define i_LW(buf, rs, rt, off) i_ld(buf, rs, rt, off)
+# define i_SW(buf, rs, rt, off) i_sd(buf, rs, rt, off)
+# define i_SLL(buf, rs, rt, sh) i_dsll(buf, rs, rt, sh)
+# define i_SRA(buf, rs, rt, sh) i_dsra(buf, rs, rt, sh)
+# define i_SRL(buf, rs, rt, sh) i_dsrl(buf, rs, rt, sh)
+# define i_MFC0(buf, rt, rd) i_dmfc0(buf, rt, rd)
+# define i_MTC0(buf, rt, rd) i_dmtc0(buf, rt, rd)
+# define i_ADDIU(buf, rs, rt, val) i_daddiu(buf, rs, rt, val)
+# define i_ADDU(buf, rs, rt, rd) i_daddu(buf, rs, rt, rd)
+# define i_SUBU(buf, rs, rt, rd) i_dsubu(buf, rs, rt, rd)
+#else
+# define i_LW(buf, rs, rt, off) i_lw(buf, rs, rt, off)
+# define i_SW(buf, rs, rt, off) i_sw(buf, rs, rt, off)
+# define i_SLL(buf, rs, rt, sh) i_sll(buf, rs, rt, sh)
+# define i_SRA(buf, rs, rt, sh) i_sra(buf, rs, rt, sh)
+# define i_SRL(buf, rs, rt, sh) i_srl(buf, rs, rt, sh)
+# define i_MFC0(buf, rt, rd) i_mfc0(buf, rt, rd)
+# define i_MTC0(buf, rt, rd) i_mtc0(buf, rt, rd)
+# define i_ADDIU(buf, rs, rt, val) i_addiu(buf, rs, rt, val)
+# define i_ADDU(buf, rs, rt, rd) i_addu(buf, rs, rt, rd)
+# define i_SUBU(buf, rs, rt, rd) i_subu(buf, rs, rt, rd)
+#endif
+
+#define i_b(buf, off) i_beq(buf, 0, 0, off)
+#define i_bnez(buf, rs, off) i_bne(buf, rs, 0, off)
+#define i_move(buf, a, b) i_ADDU(buf, a, 0, b)
+#define i_nop(buf) i_sll(buf, 0, 0, 0)
+#define i_ssnop(buf) i_sll(buf, 0, 2, 1)
+
+#if CONFIG_MIPS64
+static __init int in_compat_space_p(long addr)
+{
+	/* Is this address in 32bit compat space? */
+	return (((addr) & 0xffffffff00000000) == 0xffffffff00000000);
+}
+
+static __init int rel_highest(long val)
+{
+	return ((((val + 0x800080008000L) >> 48) & 0xffff) ^ 0x8000) - 0x8000;
+}
+
+static __init int rel_higher(long val)
+{
+	return ((((val + 0x80008000L) >> 32) & 0xffff) ^ 0x8000) - 0x8000;
+}
+#endif
+
+static __init int rel_hi(long val)
+{
+	return ((((val + 0x8000L) >> 16) & 0xffff) ^ 0x8000) - 0x8000;
+}
+
+static __init int rel_lo(long val)
+{
+	return ((val & 0xffff) ^ 0x8000) - 0x8000;
+}
+
+static __init void i_LA_mostly(u32 **buf, unsigned int rs, long addr)
+{
+#if CONFIG_MIPS64
+	if (!in_compat_space_p(addr)) {
+		i_lui(buf, rs, rel_highest(addr));
+		if (rel_higher(addr))
+			i_daddiu(buf, rs, rs, rel_higher(addr));
+		if (rel_hi(addr)) {
+			i_dsll(buf, rs, rs, 16);
+			i_daddiu(buf, rs, rs, rel_hi(addr));
+			i_dsll(buf, rs, rs, 16);
+		} else
+			i_dsll32(buf, rs, rs, 0);
+	} else
+#endif
+		i_lui(buf, rs, rel_hi(addr));
+}
+
+static __init void i_LA(u32 **buf, unsigned int rs, long addr)
+{
+	i_LA_mostly(buf, rs, addr);
+	if (rel_lo(addr))
+		i_ADDIU(buf, rs, rs, rel_lo(addr));
+}
+
+/*
+ * handle relocations
+ */
+
+struct reloc {
+	u32 *addr;
+	unsigned int type;
+	enum label_id lab;
+};
+
+static __init void r_mips_pc16(struct reloc **rel, u32 *addr,
+			       enum label_id l)
+{
+	(*rel)->addr = addr;
+	(*rel)->type = R_MIPS_PC16;
+	(*rel)->lab = l;
+	(*rel)++;
+}
+
+static inline void __resolve_relocs(struct reloc *rel, struct label *lab)
+{
+	long laddr = (long)lab->addr;
+	long raddr = (long)rel->addr;
+
+	switch (rel->type) {
+	case R_MIPS_PC16:
+		*rel->addr |= build_bimm(laddr - (raddr + 4));
+		break;
+
+	default:
+		panic("Unsupported TLB synthesizer relocation %d",
+		      rel->type);
+	}
+}
+
+static __init void resolve_relocs(struct reloc *rel, struct label *lab)
+{
+	struct label *l;
+
+	for (; rel->lab != label_invalid; rel++)
+		for (l = lab; l->lab != label_invalid; l++)
+			if (rel->lab == l->lab)
+				__resolve_relocs(rel, l);
+}
+
+static __init void copy_handler(struct reloc *rel, struct label *lab,
+				u32 *first, u32 *end, u32* target)
+{
+	long off = (long)(target - first);
+
+	memcpy(target, first, (end - first) * sizeof(u32));
+
+	for (; rel->lab != label_invalid; rel++)
+		if (rel->addr >= first && rel->addr < end)
+			rel->addr += off;
+
+	for (; lab->lab != label_invalid; lab++)
+		if (lab->addr >= first && lab->addr < end)
+			lab->addr += off;
+}
+
+static __init int insn_has_bdelay(struct reloc *rel, u32 *addr)
+{
+	for (; rel->lab != label_invalid; rel++) {
+		if (rel->addr == addr
+		    && (rel->type == R_MIPS_PC16
+			|| rel->type == R_MIPS_26))
+			return 1;
+	}
+
+	return 0;
+}
+
+/* convenience functions for labeled branches */
+static void il_bltz(u32 **p, struct reloc **r, unsigned int reg,
+		    enum label_id l)
+{
+	r_mips_pc16(r, *p, l);
+	i_bltz(p, reg, 0);
+}
+
+static void il_b(u32 **p, struct reloc **r, enum label_id l)
+{
+	r_mips_pc16(r, *p, l);
+	i_b(p, 0);
+}
+
+static void il_bnez(u32 **p, struct reloc **r, unsigned int reg,
+		    enum label_id l)
+{
+	r_mips_pc16(r, *p, l);
+	i_bnez(p, reg, 0);
+}
+
+static void il_bgezl(u32 **p, struct reloc **r, unsigned int reg,
+		     enum label_id l)
+{
+	r_mips_pc16(r, *p, l);
+	i_bgezl(p, reg, 0);
+}
+
+/* The only registers allowed in TLB handlers. */
+#define K0		26
+#define K1		27
+
+/* Some CP0 registers */
+#define C0_INDEX	0
+#define C0_ENTRYLO0	2
+#define C0_ENTRYLO1	3
+#define C0_CONTEXT	4
+#define C0_BADVADDR	8
+#define C0_ENTRYHI	10
+#define C0_EPC		14
+#define C0_XCONTEXT	20
+
+#ifdef CONFIG_MIPS64
+# define GET_CONTEXT(buf, reg) i_MFC0(buf, reg, C0_XCONTEXT)
+#else
+# define GET_CONTEXT(buf, reg) i_MFC0(buf, reg, C0_CONTEXT)
+#endif
+
+/* The worst case length of the handler is around 18 instructions for
+ * R3000-style TLBs and up to 63 instructions for R4000-style TLBs.
+ * Maximum space available is 32 instructions for R3000 and 64
+ * instructions for R4000.
+ *
+ * We deliberately chose a buffer size of 128, so we won't scribble
+ * over anything important on overflow before we panic.
+ */
+static __initdata u32 tlb_handler[128];
+
+/* simply assume worst case size for labels and relocs */
+static __initdata struct label labels[128];
+static __initdata struct reloc relocs[128];
+
+#ifdef CONFIG_MIPS32
+/*
+ * The R3000 TLB handler is simple.
+ */
+static void __init build_r3000_tlb_refill_handler(void)
+{
+	long pgdc = (long)pgd_current;
+	u32 *p;
+
+	memset(tlb_handler, 0, sizeof(tlb_handler));
+	p = tlb_handler;
+
+	i_mfc0(&p, K0, C0_BADVADDR);
+	i_lui(&p, K1, rel_hi(pgdc)); /* cp0 delay */
+	i_lw(&p, K1, rel_lo(pgdc), K1);
+	i_srl(&p, K0, K0, 22); /* load delay */
+	i_sll(&p, K0, K0, 2);
+	i_addu(&p, K1, K1, K0);
+	i_mfc0(&p, K0, C0_CONTEXT);
+	i_lw(&p, K1, 0, K1);
+	i_andi(&p, K0, K0, 0xffc); /* load delay */
+	i_addu(&p, K1, K1, K0);
+	i_lw(&p, K0, 0, K1);
+	i_nop(&p); /* load delay */
+	i_mtc0(&p, K0, C0_ENTRYLO0);
+	i_mfc0(&p, K1, C0_EPC); /* cp0 delay */
+	i_tlbwr(&p); /* cp0 delay */
+	i_jr(&p, K1); /* cp0 delay */
+	i_rfe(&p); /* branch delay */
+
+	if (p > tlb_handler + 32)
+		panic("TLB refill handler space exceeded");
+
+	printk("Synthesized TLB handler (%u instructions).\n",
+	       p - tlb_handler);
+#ifdef DEBUG_TLB
+	{
+		int i;
+		for (i = 0; i < (p - tlb_handler); i++)
+			printk("%08x\n", tlb_handler[i]);
+	}
+#endif
+
+	memcpy((void *)CAC_BASE, tlb_handler, 0x80);
+	flush_icache_range(CAC_BASE, CAC_BASE + 0x80);
+}
+#endif /* CONFIG_MIPS32 */
+
+/*
+ * The R4000 TLB handler is much more complicated. We have two
+ * consecutive handler areas with 32 instructions space each.
+ * Since they aren't used at the same time, we can overflow in the
+ * other one.To keep things simple, we first assume linear space,
+ * then we relocate it to the final handler layout as needed.
+ */
+static __initdata u32 final_handler[64];
+
+/*
+ * Hazards
+ *
+ * From the IDT errata for the QED RM5230 (Nevada), processor revision 1.0:
+ * 2. A timing hazard exists for the TLBP instruction.
+ *
+ *      stalling_instruction
+ *      TLBP
+ *
+ * The JTLB is being read for the TLBP throughout the stall generated by the
+ * previous instruction. This is not really correct as the stalling instruction
+ * can modify the address used to access the JTLB.  The failure symptom is that
+ * the TLBP instruction will use an address created for the stalling instruction
+ * and not the address held in C0_ENHI and thus report the wrong results.
+ *
+ * The software work-around is to not allow the instruction preceding the TLBP
+ * to stall - make it an NOP or some other instruction guaranteed not to stall.
+ *
+ * Errata 2 will not be fixed.  This errata is also on the R5000.
+ *
+ * As if we MIPS hackers wouldn't know how to nop pipelines happy ...
+ */
+static __init void build_tlbp_hazard(u32 **p)
+{
+	switch (current_cpu_data.cputype) {
+	case CPU_R5000:
+	case CPU_R5000A:
+	case CPU_NEVADA:
+		i_nop(p);
+		break;
+
+	default:
+		break;
+	}
+}
+
+/*
+ * Write random TLB entry, and care about the hazards from the
+ * preceeding mtc0 and for the following eret.
+ */
+static __init void build_tlb_write_random_entry(u32 **p, struct label **l,
+						struct reloc **r)
+{
+	switch (current_cpu_data.cputype) {
+	case CPU_R4000PC:
+	case CPU_R4000SC:
+	case CPU_R4000MC:
+	case CPU_R4400PC:
+	case CPU_R4400SC:
+	case CPU_R4400MC:
+		/*
+		 * This branch uses up a mtc0 hazard nop slot and saves
+		 * two nops after the tlbwr.
+		 */
+		il_bgezl(p, r, 0, label_tlbwr_hazard);
+		i_tlbwr(p);
+		l_tlbwr_hazard(l, *p);
+		i_nop(p);
+		break;
+
+	case CPU_R4600:
+	case CPU_R4700:
+		i_nop(p);
+		i_tlbwr(p);
+		break;
+
+	case CPU_NEVADA:
+		i_nop(p); /* QED specifies 2 nops hazard */
+		/*
+		 * This branch uses up a mtc0 hazard nop slot and saves
+		 * a nop after the tlbwr.
+		 */
+		il_bgezl(p, r, 0, label_tlbwr_hazard);
+		i_tlbwr(p);
+		l_tlbwr_hazard(l, *p);
+		break;
+
+	case CPU_RM9000:
+		/*
+		 * When the JTLB is updated by tlbwi or tlbwr, a subsequent
+		 * use of the JTLB for instructions should not occur for 4
+		 * cpu cycles and use for data translations should not occur
+		 * for 3 cpu cycles.
+		 */
+		i_ssnop(p);
+		i_ssnop(p);
+		i_ssnop(p);
+		i_ssnop(p);
+		i_tlbwr(p);
+		i_ssnop(p);
+		i_ssnop(p);
+		i_ssnop(p);
+		i_ssnop(p);
+		break;
+
+	case CPU_R10000:
+	case CPU_R12000:
+	case CPU_SB1:
+		i_tlbwr(p);
+		break;
+
+	default:
+		/*
+		 * Others are assumed to have one cycle mtc0 hazard,
+		 * and one cycle tlbwr hazard.
+		 * XXX: This might be overly general.
+		 */
+		i_nop(p);
+		i_tlbwr(p);
+		i_nop(p);
+		break;
+	}
+}
+
+#if CONFIG_MIPS64
+/*
+ * TMP and PTR are scratch.
+ * TMP will be clobbered, PTR will hold the pmd entry.
+ */
+static __init void
+build_get_pmde64(u32 **p, struct label **l, struct reloc **r,
+		 unsigned int tmp, unsigned int ptr)
+{
+	long pgdc = (long)pgd_current;
+
+	/*
+	 * The vmalloc handling is not in the hotpath.
+	 */
+	i_dmfc0(p, tmp, C0_BADVADDR);
+	il_bltz(p, r, tmp, label_vmalloc);
+	/* No i_nop needed here, since the next insn doesn't touch TMP. */
+
+# ifdef CONFIG_SMP
+	/*
+	 * 64 bit SMP has the lower part of &pgd_current[smp_processor_id()]
+	 * stored in CONTEXT.
+	 */
+	if (in_compat_space_p(pgdc)) {
+		i_dmfc0(p, ptr, C0_CONTEXT);
+		i_dsra(p, ptr, ptr, 23);
+	} else {
+		i_dmfc0(p, ptr, C0_CONTEXT);
+		i_lui(p, tmp, rel_highest(pgdc));
+		i_dsll(p, ptr, ptr, 9);
+		i_daddiu(p, tmp, tmp, rel_higher(pgdc));
+		i_dsrl32(p, ptr, ptr, 0);
+		i_and(p, ptr, ptr, tmp);
+		i_dmfc0(p, tmp, C0_BADVADDR);
+	}
+	i_ld(p, ptr, 0, ptr);
+# else
+	i_LA_mostly(p, ptr, pgdc);
+	i_ld(p, ptr, rel_lo(pgdc), ptr);
+# endif
+
+	l_vmalloc_done(l, *p);
+	i_dsrl(p, tmp, tmp, PGDIR_SHIFT-3); /* get pgd offset in bytes */
+	i_andi(p, tmp, tmp, (PTRS_PER_PGD - 1)<<3);
+	i_daddu(p, ptr, ptr, tmp); /* add in pgd offset */
+	i_dmfc0(p, tmp, C0_BADVADDR); /* get faulting address */
+	i_ld(p, ptr, 0, ptr); /* get pmd pointer */
+	i_dsrl(p, tmp, tmp, PMD_SHIFT-3); /* get pmd offset in bytes */
+	i_andi(p, tmp, tmp, (PTRS_PER_PMD - 1)<<3);
+	i_daddu(p, ptr, ptr, tmp); /* add in pmd offset */
+}
+
+/*
+ * BVADDR is the faulting address, PTR is scratch.
+ * PTR will hold the pgd for vmalloc.
+ */
+static __init void
+build_get_pgd_vmalloc64(u32 **p, struct label **l, struct reloc **r,
+			unsigned int bvaddr, unsigned int ptr)
+{
+	long swpd = (long)swapper_pg_dir;
+
+	l_vmalloc(l, *p);
+	i_LA(p, ptr, VMALLOC_START);
+	i_dsubu(p, bvaddr, bvaddr, ptr);
+
+	if (in_compat_space_p(swpd) && !rel_lo(swpd)) {
+		il_b(p, r, label_vmalloc_done);
+		i_lui(p, ptr, rel_hi(swpd));
+	} else {
+		i_LA_mostly(p, ptr, swpd);
+		il_b(p, r, label_vmalloc_done);
+		i_daddiu(p, ptr, ptr, rel_lo(swpd));
+	}
+}
+
+#else /* CONFIG_MIPS32 */
+
+/*
+ * TMP and PTR are scratch.
+ * TMP will be clobbered, PTR will hold the pgd entry.
+ */
+static __init void build_get_pgde32(u32 **p, unsigned int tmp, unsigned int ptr)
+{
+	long pgdc = (long)pgd_current;
+
+	/* 32 bit SMP has smp_processor_id() stored in CONTEXT. */
+#ifdef CONFIG_SMP
+	i_mfc0(p, ptr, C0_CONTEXT);
+	i_LA_mostly(p, tmp, pgdc);
+	i_srl(p, ptr, ptr, 23);
+	i_sll(p, ptr, ptr, 2);
+	i_addu(p, ptr, tmp, ptr);
+#else
+	i_LA_mostly(p, ptr, pgdc);
+#endif
+	i_mfc0(p, tmp, C0_BADVADDR); /* get faulting address */
+	i_lw(p, ptr, rel_lo(pgdc), ptr);
+	i_srl(p, tmp, tmp, PGDIR_SHIFT); /* get pgd only bits */
+	i_sll(p, tmp, tmp, PGD_T_LOG2);
+	i_addu(p, ptr, ptr, tmp); /* add in pgd offset */
+}
+#endif /* CONFIG_MIPS32 */
+
+static __init void build_adjust_context(u32 **p, unsigned int ctx)
+{
+	unsigned int shift = 0;
+	unsigned int mask = 0xff0;
+
+#if !defined(CONFIG_MIPS64) && !defined(CONFIG_64BIT_PHYS_ADDR)
+	shift++;
+	mask |= 0x008;
+#endif
+
+	switch (current_cpu_data.cputype) {
+	case CPU_VR41XX:
+	case CPU_VR4111:
+	case CPU_VR4121:
+	case CPU_VR4122:
+	case CPU_VR4131:
+	case CPU_VR4181:
+	case CPU_VR4181A:
+	case CPU_VR4133:
+		shift += 2;
+		break;
+
+	default:
+		break;
+	}
+
+	if (shift)
+		i_SRL(p, ctx, ctx, shift);
+	i_andi(p, ctx, ctx, mask);
+}
+
+static __init void build_get_ptep(u32 **p, unsigned int tmp, unsigned int ptr)
+{
+	/*
+	 * Bug workaround for the Nevada. It seems as if under certain
+	 * circumstances the move from cp0_context might produce a
+	 * bogus result when the mfc0 instruction and its consumer are
+	 * in a different cacheline or a load instruction, probably any
+	 * memory reference, is between them.
+	 */
+	switch (current_cpu_data.cputype) {
+	case CPU_NEVADA:
+		i_LW(p, ptr, 0, ptr);
+		GET_CONTEXT(p, tmp); /* get context reg */
+		break;
+
+	default:
+		GET_CONTEXT(p, tmp); /* get context reg */
+		i_LW(p, ptr, 0, ptr);
+		break;
+	}
+
+	build_adjust_context(p, tmp);
+	i_ADDU(p, ptr, ptr, tmp); /* add in offset */
+}
+
+static __init void build_update_entries(u32 **p, unsigned int tmp,
+					unsigned int ptep)
+{
+	/*
+	 * 64bit address support (36bit on a 32bit CPU) in a 32bit
+	 * Kernel is a special case. Only a few CPUs use it.
+	 */
+#ifdef CONFIG_64BIT_PHYS_ADDR
+	if (cpu_has_64bit_registers) {
+		i_ld(p, tmp, 0, ptep); /* get even pte */
+		i_ld(p, ptep, sizeof(pte_t), ptep); /* get odd pte */
+		i_dsrl(p, tmp, tmp, 6); /* convert to entrylo0 */
+		i_mtc0(p, tmp, C0_ENTRYLO0); /* load it */
+		i_dsrl(p, ptep, ptep, 6); /* convert to entrylo1 */
+		i_mtc0(p, ptep, C0_ENTRYLO1); /* load it */
+	} else {
+		int pte_off_even = sizeof(pte_t) / 2;
+		int pte_off_odd = pte_off_even + sizeof(pte_t);
+
+		/* The pte entries are pre-shifted */
+		i_lw(p, tmp, pte_off_even, ptep); /* get even pte */
+		i_mtc0(p, tmp, C0_ENTRYLO0); /* load it */
+		i_lw(p, ptep, pte_off_odd, ptep); /* get odd pte */
+		i_mtc0(p, ptep, C0_ENTRYLO1); /* load it */
+	}
+#else
+	i_LW(p, tmp, 0, ptep); /* get even pte */
+	i_LW(p, ptep, sizeof(pte_t), ptep); /* get odd pte */
+	if (r45k_bvahwbug()) {
+		build_tlbp_hazard(p);
+		i_tlbp(p);
+	}
+	i_SRL(p, tmp, tmp, 6); /* convert to entrylo0 */
+	if (r4k_250MHZhwbug())
+		i_mtc0(p, 0, C0_ENTRYLO0);
+	i_mtc0(p, tmp, C0_ENTRYLO0); /* load it */
+	i_SRL(p, ptep, ptep, 6); /* convert to entrylo1 */
+	if (r45k_bvahwbug())
+		i_mfc0(p, tmp, C0_INDEX);
+	if (r4k_250MHZhwbug())
+		i_mtc0(p, 0, C0_ENTRYLO1);
+	i_mtc0(p, ptep, C0_ENTRYLO1); /* load it */
+#endif
+}
+
+static void __init build_r4000_tlb_refill_handler(void)
+{
+	u32 *p = tlb_handler;
+	struct label *l = labels;
+	struct reloc *r = relocs;
+	u32 *f;
+	unsigned int final_len;
+
+	memset(tlb_handler, 0, sizeof(tlb_handler));
+	memset(labels, 0, sizeof(labels));
+	memset(relocs, 0, sizeof(relocs));
+	memset(final_handler, 0, sizeof(final_handler));
+
+	/*
+	 * create the plain linear handler
+	 */
+	if (bcm1250_m3_war) {
+		i_MFC0(&p, K0, C0_BADVADDR);
+		i_MFC0(&p, K1, C0_ENTRYHI);
+		i_xor(&p, K0, K0, K1);
+		i_SRL(&p, K0, K0, PAGE_SHIFT+1);
+		il_bnez(&p, &r, K0, label_leave);
+		/* No need for i_nop */
+	}
+
+#ifdef CONFIG_MIPS64
+	build_get_pmde64(&p, &l, &r, K0, K1); /* get pmd ptr in K1 */
+#else
+	build_get_pgde32(&p, K0, K1); /* get pgd ptr in K1 */
+#endif
+
+	build_get_ptep(&p, K0, K1);
+	build_update_entries(&p, K0, K1);
+	build_tlb_write_random_entry(&p, &l, &r);
+	l_leave(&l, p);
+	i_eret(&p); /* return from trap */
+
+#ifdef CONFIG_MIPS64
+	build_get_pgd_vmalloc64(&p, &l, &r, K0, K1);
+#endif
+
+	/*
+	 * Overflow check: For the 64bit handler, we need at least one
+	 * free instruction slot for the wrap-around branch. In worst
+	 * case, if the intended insertion point is a delay slot, we
+	 * need three, with the the second nop'ed and the third being
+	 * unused.
+	 */
+#ifdef CONFIG_MIPS32
+	if ((p - tlb_handler) > 64)
+		panic("TLB refill handler space exceeded");
+#else
+	if (((p - tlb_handler) > 63)
+	    || (((p - tlb_handler) > 61)
+		&& insn_has_bdelay(relocs, tlb_handler + 29)))
+		panic("TLB refill handler space exceeded");
+#endif
+
+	/*
+	 * Now fold the handler in the TLB refill handler space.
+	 */
+#ifdef CONFIG_MIPS32
+	f = final_handler;
+	/* Simplest case, just copy the handler. */
+	copy_handler(relocs, labels, tlb_handler, p, f);
+	final_len = p - tlb_handler;
+#else /* CONFIG_MIPS64 */
+	f = final_handler + 32;
+	if ((p - tlb_handler) <= 32) {
+		/* Just copy the handler. */
+		copy_handler(relocs, labels, tlb_handler, p, f);
+		final_len = p - tlb_handler;
+	} else {
+		u32 *split = tlb_handler + 30;
+
+		/*
+		 * Find the split point.
+		 */
+		if (insn_has_bdelay(relocs, split - 1))
+			split--;
+
+		/* Copy first part of the handler. */
+		copy_handler(relocs, labels, tlb_handler, split, f);
+		f += split - tlb_handler;
+
+		/* Insert branch. */
+		l_split(&l, final_handler);
+		il_b(&f, &r, label_split);
+		if (insn_has_bdelay(relocs, split))
+			i_nop(&f);
+		else {
+			copy_handler(relocs, labels, split, split + 1, f);
+			f++;
+			split++;
+		}
+
+		/* Copy the rest of the handler. */
+		copy_handler(relocs, labels, split, p, final_handler);
+		final_len = (f - (final_handler + 32)) + (p - split);
+	}
+#endif /* CONFIG_MIPS64 */
+
+	resolve_relocs(relocs, labels);
+	printk("Synthesized TLB handler (%u instructions).\n", final_len);
+
+#ifdef DEBUG_TLB
+	{
+		int i;
+
+		for (i = 0; i < 64; i++)
+			printk("%08x\n", final_handler[i]);
+	}
+#endif
+
+	memcpy((void *)CAC_BASE, final_handler, 0x100);
+	flush_icache_range(CAC_BASE, CAC_BASE + 0x100);
+}
+
+void __init build_tlb_refill_handler(void)
+{
+	switch (current_cpu_data.cputype) {
+#ifdef CONFIG_MIPS32
+	case CPU_R2000:
+	case CPU_R3000:
+	case CPU_R3000A:
+	case CPU_R3081E:
+	case CPU_TX3912:
+	case CPU_TX3922:
+	case CPU_TX3927:
+		build_r3000_tlb_refill_handler();
+		break;
+
+	case CPU_R6000:
+	case CPU_R6000A:
+		panic("No R6000 TLB refill handler yet");
+		break;
+#endif
+
+	case CPU_R8000:
+		panic("No R8000 TLB refill handler yet");
+		break;
+
+	default:
+		build_r4000_tlb_refill_handler();
+	}
+}
--- arch/mips/mm/tlbex64-r4k.S	2004-11-21 03:05:35.000000000 +0100
+++ /dev/null	2004-08-24 19:23:08.000000000 +0200
@@ -1,136 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2000 Silicon Graphics, Inc.
- * Written by Ulf Carlsson (ulfc@engr.sgi.com)
- * Copyright (C) 2002  Maciej W. Rozycki
- */
-#include <linux/config.h>
-#include <linux/init.h>
-#include <linux/threads.h>
-
-#include <asm/asm.h>
-#include <asm/hazards.h>
-#include <asm/regdef.h>
-#include <asm/mipsregs.h>
-#include <asm/stackframe.h>
-#include <asm/war.h>
-
-#define _VMALLOC_START	0xc000000000000000
-
-	.macro	GET_PGD, ptr
-#ifdef CONFIG_SMP
-	/*
-	 * Fixme - this is b0rked for pgd_current outside of CKSEG0
-	 */
-	dmfc0	\ptr, CP0_CONTEXT
-	dsra	\ptr, 23			# get pgd_current[cpu]
-	ld	\ptr, (\ptr)
-#else
-	ld	\ptr, pgd_current
-#endif
-	.endm
-
-	/*
-	 * After this macro runs we have a pointer to the pte of the address
-	 * that caused the fault in PTR.  Expects register containing the
-	 * the pagetable root pointer as the ptr argument and c0_badvaddr
-	 * passed as tmp argument.
-	 */
-	.macro	LOAD_PTE2, ptr, tmp
-	dsrl	\tmp, (_PGDIR_SHIFT-3)		# get pgd offset in bytes
-	andi	\tmp, ((_PTRS_PER_PGD - 1)<<3)
-	daddu	\ptr, \tmp			# add in pgd offset
-	dmfc0	\tmp, CP0_BADVADDR
-	ld	\ptr, (\ptr)			# get pmd pointer
-	dsrl	\tmp, (_PMD_SHIFT-3)		# get pmd offset in bytes
-	andi	\tmp, ((_PTRS_PER_PMD - 1)<<3)
-	daddu	\ptr, \tmp			# add in pmd offset
-	dmfc0	\tmp, CP0_XCONTEXT
-	ld	\ptr, (\ptr)			# get pte pointer
-	andi	\tmp, 0xff0			# get pte offset
-	daddu	\ptr, \tmp
-	.endm
-
-	/*
-	 * This places the even/odd pte pair in the page table at the pte
-	 * entry pointed to by PTE into ENTRYLO0 and ENTRYLO1.
-	 */
-	.macro	PTE_RELOAD, pte0, pte1
-	dsrl	\pte0, 6			# convert to entrylo0
-	dmtc0	\pte0, CP0_ENTRYLO0		# load it
-	dsrl	\pte1, 6			# convert to entrylo1
-	dmtc0	\pte1, CP0_ENTRYLO1		# load it
-	.endm
-
-
-	.text
-	.set	noreorder
-	.set	mips3
-
-	__INIT
-
-	/*
-	 * TLB refill handlers for the R4000 and SB1.
-	 * Attention:  We may only use 32 instructions / 128 bytes.
-	 */
-	.align  5
-LEAF(except_vec1_r4k)
-	.set    noat
-	dla     k0, handle_vec1_r4k
-	jr      k0
-	 nop
-END(except_vec1_r4k)
-
-LEAF(except_vec1_sb1)
-#if BCM1250_M3_WAR
-	dmfc0	k0, CP0_BADVADDR
-	dmfc0	k1, CP0_ENTRYHI
-	xor	k0, k1
-	dsrl	k0, k0, _PAGE_SHIFT+1
-	bnez	k0, 1f
-#endif
-	.set    noat
-	dla     k0, handle_vec1_r4k
-	jr      k0
-	 nop
-
-1:	eret
-	nop
-END(except_vec1_sb1)
-
-	__FINIT
-
-	.align  5
-LEAF(handle_vec1_r4k)
-	.set    noat
-	dmfc0	k0, CP0_BADVADDR
-	bltz	k0, 9f
-
-	 GET_PGD k1				# pointer to root of pgd
-	LOAD_PTE2 k1 k0
-	ld	k0, 0(k1)			# get even pte
-	ld	k1, 8(k1)			# get odd pte
-	PTE_RELOAD k0 k1
-	mtc0_tlbw_hazard
-	tlbwr
-	nop
-	tlbw_eret_hazard
-	eret
-
-9:						# handle the vmalloc range
-	dli	k1, _VMALLOC_START
-	dsubu	k0, k1
-	dla	k1, swapper_pg_dir		# pointer to root of pgd
-	LOAD_PTE2 k1 k0
-	ld	k0, 0(k1)			# get even pte
-	ld	k1, 8(k1)			# get odd pte
-	PTE_RELOAD k0 k1
-	mtc0_tlbw_hazard
-	tlbwr
-	nop
-	tlbw_eret_hazard
-	eret
-END(handle_vec1_r4k)
