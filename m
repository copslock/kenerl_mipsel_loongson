Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Dec 2004 21:55:51 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:31822
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225235AbULVVzi>; Wed, 22 Dec 2004 21:55:38 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1ChES5-0000L8-00
	for <linux-mips@linux-mips.org>; Wed, 22 Dec 2004 22:55:25 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1ChES4-0004of-00
	for <linux-mips@linux-mips.org>; Wed, 22 Dec 2004 22:55:24 +0100
Date: Wed, 22 Dec 2004 22:55:24 +0100
To: linux-mips@linux-mips.org
Subject: [PATCH] Further TLB handler optimizations
Message-ID: <20041222215524.GB3539@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6745
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Hallo All,

this patch adds some optimizations to the TLB load/store/modify
exception handlers. Most notably, the TLB_OPTIMIZE stuff from the
32bit kernel works now as well for 64bit kernels. This improved the
lmbench number for fork+exit by ~15%.

The fastpath for these handlers is now also synthesized at runtime,
this allows a single implementation with some more optimizations.

The TLB_OPTIMIZE case for 32bit SMP was not safe for mutithreading,
this is also fixed.

The patch was tested on an O200 SMP system with 2 x R12000. Other
machines are untested. Please test if it still works for you,
especially if your system has r3000 style TLBs, or if it is a
MIPS32 CPU which uses CONFIG_64BIT_PHYS_ADDR.


Thiemo


Index: arch/mips/kernel/traps.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/traps.c,v
retrieving revision 1.205
diff -u -p -r1.205 traps.c
--- arch/mips/kernel/traps.c	16 Dec 2004 19:52:54 -0000	1.205
+++ arch/mips/kernel/traps.c	22 Dec 2004 21:23:45 -0000
@@ -38,12 +38,9 @@
 #include <asm/watch.h>
 #include <asm/types.h>
 
-extern asmlinkage void handle_mod(void);
+extern asmlinkage void handle_tlbm(void);
 extern asmlinkage void handle_tlbl(void);
 extern asmlinkage void handle_tlbs(void);
-extern asmlinkage void __xtlb_mod(void);
-extern asmlinkage void __xtlb_tlbl(void);
-extern asmlinkage void __xtlb_tlbs(void);
 extern asmlinkage void handle_adel(void);
 extern asmlinkage void handle_ades(void);
 extern asmlinkage void handle_ibe(void);
@@ -1010,16 +1007,10 @@ void __init trap_init(void)
 	if (board_be_init)
 		board_be_init();
 
-#ifdef CONFIG_MIPS32
-	set_except_vector(1, handle_mod);
+	set_except_vector(1, handle_tlbm);
 	set_except_vector(2, handle_tlbl);
 	set_except_vector(3, handle_tlbs);
-#endif
-#ifdef CONFIG_MIPS64
-	set_except_vector(1, __xtlb_mod);
-	set_except_vector(2, __xtlb_tlbl);
-	set_except_vector(3, __xtlb_tlbs);
-#endif
+
 	set_except_vector(4, handle_adel);
 	set_except_vector(5, handle_ades);
 
Index: arch/mips/mm/Makefile
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/Makefile,v
retrieving revision 1.73
diff -u -p -r1.73 Makefile
--- arch/mips/mm/Makefile	16 Dec 2004 16:48:28 -0000	1.73
+++ arch/mips/mm/Makefile	22 Dec 2004 21:23:45 -0000
@@ -3,7 +3,7 @@
 #
 
 obj-y				+= cache.o extable.o fault.o init.o pgtable.o \
-				   tlbex.o
+				   tlbex.o tlbex-fault.o
 
 obj-$(CONFIG_MIPS32)		+= ioremap.o pgtable-32.o
 obj-$(CONFIG_MIPS64)		+= pgtable-64.o
@@ -27,41 +27,6 @@ obj-$(CONFIG_CPU_TX39XX)	+= c-tx39.o pg-
 obj-$(CONFIG_CPU_TX49XX)	+= c-r4k.o cex-gen.o pg-r4k.o tlb-r4k.o
 obj-$(CONFIG_CPU_VR41XX)	+= c-r4k.o cex-gen.o pg-r4k.o tlb-r4k.o
 
-#
-# TLB exception handling code differs between 32-bit and 64-bit kernels.
-#
-ifdef CONFIG_MIPS32
-obj-$(CONFIG_CPU_R3000)		+= tlbex32-r3k.o
-obj-$(CONFIG_CPU_TX49XX)	+= tlbex32-r4k.o
-obj-$(CONFIG_CPU_R4300)		+= tlbex32-r4k.o
-obj-$(CONFIG_CPU_R4X00)		+= tlbex32-r4k.o
-obj-$(CONFIG_CPU_VR41XX)	+= tlbex32-r4k.o
-obj-$(CONFIG_CPU_R5000)		+= tlbex32-r4k.o
-obj-$(CONFIG_CPU_NEVADA)	+= tlbex32-r4k.o
-obj-$(CONFIG_CPU_R5432)		+= tlbex32-r4k.o
-obj-$(CONFIG_CPU_RM7000)	+= tlbex32-r4k.o
-obj-$(CONFIG_CPU_RM9000)	+= tlbex32-r4k.o
-obj-$(CONFIG_CPU_R10000)	+= tlbex32-r4k.o
-obj-$(CONFIG_CPU_MIPS32)	+= tlbex32-mips32.o
-obj-$(CONFIG_CPU_MIPS64)	+= tlbex32-r4k.o
-obj-$(CONFIG_CPU_SB1)		+= tlbex32-r4k.o
-obj-$(CONFIG_CPU_TX39XX)	+= tlbex32-r3k.o
-endif
-ifdef CONFIG_MIPS64
-obj-$(CONFIG_CPU_R4300)		+= tlbex64.o
-obj-$(CONFIG_CPU_TX49XX)	+= tlbex64.o
-obj-$(CONFIG_CPU_R4X00)		+= tlbex64.o
-obj-$(CONFIG_CPU_R5000)		+= tlbex64.o
-obj-$(CONFIG_CPU_NEVADA)	+= tlbex64.o
-obj-$(CONFIG_CPU_R5432)		+= tlbex64.o
-obj-$(CONFIG_CPU_RM7000)	+= tlbex64.o
-obj-$(CONFIG_CPU_RM9000)	+= tlbex64.o
-obj-$(CONFIG_CPU_R10000)	+= tlbex64.o
-obj-$(CONFIG_CPU_SB1)		+= tlbex64.o
-obj-$(CONFIG_CPU_MIPS64)	+= tlbex64.o
-endif
-
-
 obj-$(CONFIG_IP22_CPU_SCACHE)	+= sc-ip22.o
 obj-$(CONFIG_R5000_CPU_SCACHE)  += sc-r5k.o
 obj-$(CONFIG_RM7000_CPU_SCACHE)	+= sc-rm7k.o
Index: arch/mips/mm/tlbex-fault.S
===================================================================
RCS file: arch/mips/mm/tlbex-fault.S
diff -N arch/mips/mm/tlbex-fault.S
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ arch/mips/mm/tlbex-fault.S	22 Dec 2004 21:23:47 -0000
@@ -0,0 +1,28 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1999 Ralf Baechle
+ * Copyright (C) 1999 Silicon Graphics, Inc.
+ */
+#include <asm/mipsregs.h>
+#include <asm/page.h>
+#include <asm/regdef.h>
+#include <asm/stackframe.h>
+
+	.macro tlb_do_fault_nopage, write
+	NESTED(tlb_do_fault_nopage_\write, PT_SIZE, sp)
+	SAVE_ALL
+	MFC0	a2, CP0_BADVADDR
+	KMODE
+	move	a0, sp
+	REG_S	a2, PT_BVADDR(sp)
+	li	a1, \write
+	jal	do_page_fault
+	j	ret_from_exception
+	END(tlb_do_fault_nopage_\write)
+	.endm
+
+	tlb_do_fault_nopage 0
+	tlb_do_fault_nopage 1
Index: arch/mips/mm/tlbex.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/tlbex.c,v
retrieving revision 1.12
diff -u -p -r1.12 tlbex.c
--- arch/mips/mm/tlbex.c	21 Dec 2004 01:16:35 -0000	1.12
+++ arch/mips/mm/tlbex.c	22 Dec 2004 21:23:47 -0000
@@ -85,12 +85,13 @@ enum opcode {
 	insn_invalid,
 	insn_addu, insn_addiu, insn_and, insn_andi, insn_beq,
 	insn_bgez, insn_bgezl, insn_bltz, insn_bltzl, insn_bne,
-	insn_daddu, insn_daddiu, insn_dmfc0, insn_dmtc0,
-	insn_dsll, insn_dsll32, insn_dsra, insn_dsrl, insn_dsrl32,
-	insn_dsubu, insn_eret, insn_j, insn_jal, insn_jr, insn_ld,
-	insn_lui, insn_lw, insn_mfc0, insn_mtc0, insn_ori, insn_rfe,
-	insn_sd, insn_sll, insn_sra, insn_srl, insn_subu, insn_sw,
-	insn_tlbp, insn_tlbwi, insn_tlbwr, insn_xor, insn_xori
+	insn_daddu, insn_daddiu, insn_dmfc0, insn_dmtc0, insn_dsll,
+	insn_dsll32, insn_dsra, insn_dsrl, insn_dsrl32, insn_dsubu,
+	insn_eret, insn_j, insn_jal, insn_jr, insn_ld, insn_ll,
+	insn_lld, insn_lui, insn_lw, insn_mfc0, insn_mtc0, insn_ori,
+	insn_rfe, insn_sc, insn_scd, insn_sd, insn_sll,	insn_sra,
+	insn_srl, insn_subu, insn_sw, insn_tlbp, insn_tlbwi,
+	insn_tlbwr, insn_xor, insn_xori
 };
 
 struct insn {
@@ -134,12 +135,16 @@ static __initdata struct insn insn_table
 	{ insn_jal, M(jal_op,0,0,0,0,0), JIMM },
 	{ insn_jr, M(spec_op,0,0,0,0,jr_op), RS },
 	{ insn_ld, M(ld_op,0,0,0,0,0), RS | RT | SIMM },
+	{ insn_ll, M(ll_op,0,0,0,0,0), RS | RT | SIMM },
+	{ insn_lld, M(lld_op,0,0,0,0,0), RS | RT | SIMM },
 	{ insn_lui, M(lui_op,0,0,0,0,0), RT | SIMM },
 	{ insn_lw, M(lw_op,0,0,0,0,0), RS | RT | SIMM },
 	{ insn_mfc0, M(cop0_op,mfc_op,0,0,0,0), RT | RD },
 	{ insn_mtc0, M(cop0_op,mtc_op,0,0,0,0), RT | RD },
 	{ insn_ori, M(ori_op,0,0,0,0,0), RS | RT | UIMM },
 	{ insn_rfe, M(cop0_op,cop_op,0,0,0,rfe_op), 0 },
+	{ insn_sc, M(sc_op,0,0,0,0,0), RS | RT | SIMM },
+	{ insn_scd, M(scd_op,0,0,0,0,0), RS | RT | SIMM },
 	{ insn_sd, M(sd_op,0,0,0,0,0), RS | RT | SIMM },
 	{ insn_sll, M(spec_op,0,0,0,0,sll_op), RT | RD | RE },
 	{ insn_sra, M(spec_op,0,0,0,0,sra_op), RT | RD | RE },
@@ -361,12 +366,16 @@ I_u1(_j);
 I_u1(_jal);
 I_u1(_jr);
 I_u2s3u1(_ld);
+I_u2s3u1(_ll);
+I_u2s3u1(_lld);
 I_u1s2(_lui);
 I_u2s3u1(_lw);
 I_u1u2(_mfc0);
 I_u1u2(_mtc0);
 I_u2u1u3(_ori);
 I_0(_rfe);
+I_u2s3u1(_sc);
+I_u2s3u1(_scd);
 I_u2s3u1(_sd);
 I_u2u1u3(_sll);
 I_u2u1u3(_sra);
@@ -389,8 +398,14 @@ enum label_id {
 	label_leave,
 	label_vmalloc,
 	label_vmalloc_done,
-	label_tlbwr_hazard,
-	label_split
+	label_tlbw_hazard,
+	label_split,
+	label_nopage_tlbl,
+	label_nopage_tlbs,
+	label_nopage_tlbm,
+	label_smp_pgtable_change,
+	label_r3000_write_probe_fail,
+	label_r3000_write_probe_ok
 };
 
 struct label {
@@ -416,8 +431,14 @@ L_LA(_second_part)
 L_LA(_leave)
 L_LA(_vmalloc)
 L_LA(_vmalloc_done)
-L_LA(_tlbwr_hazard)
+L_LA(_tlbw_hazard)
 L_LA(_split)
+L_LA(_nopage_tlbl)
+L_LA(_nopage_tlbs)
+L_LA(_nopage_tlbm)
+L_LA(_smp_pgtable_change)
+L_LA(_r3000_write_probe_fail)
+L_LA(_r3000_write_probe_ok)
 
 /* convenience macros for instructions */
 #ifdef CONFIG_MIPS64
@@ -431,6 +452,8 @@ L_LA(_split)
 # define i_ADDIU(buf, rs, rt, val) i_daddiu(buf, rs, rt, val)
 # define i_ADDU(buf, rs, rt, rd) i_daddu(buf, rs, rt, rd)
 # define i_SUBU(buf, rs, rt, rd) i_dsubu(buf, rs, rt, rd)
+# define i_LL(buf, rs, rt, off) i_lld(buf, rs, rt, off)
+# define i_SC(buf, rs, rt, off) i_scd(buf, rs, rt, off)
 #else
 # define i_LW(buf, rs, rt, off) i_lw(buf, rs, rt, off)
 # define i_SW(buf, rs, rt, off) i_sw(buf, rs, rt, off)
@@ -442,9 +465,12 @@ L_LA(_split)
 # define i_ADDIU(buf, rs, rt, val) i_addiu(buf, rs, rt, val)
 # define i_ADDU(buf, rs, rt, rd) i_addu(buf, rs, rt, rd)
 # define i_SUBU(buf, rs, rt, rd) i_subu(buf, rs, rt, rd)
+# define i_LL(buf, rs, rt, off) i_ll(buf, rs, rt, off)
+# define i_SC(buf, rs, rt, off) i_sc(buf, rs, rt, off)
 #endif
 
 #define i_b(buf, off) i_beq(buf, 0, 0, off)
+#define i_beqz(buf, rs, off) i_beq(buf, rs, 0, off)
 #define i_bnez(buf, rs, off) i_bne(buf, rs, 0, off)
 #define i_move(buf, a, b) i_ADDU(buf, a, 0, b)
 #define i_nop(buf) i_sll(buf, 0, 0, 0)
@@ -605,6 +631,13 @@ static void __attribute__((unused)) il_b
 	i_b(p, 0);
 }
 
+static void il_beqz(u32 **p, struct reloc **r, unsigned int reg,
+		    enum label_id l)
+{
+	r_mips_pc16(r, *p, l);
+	i_beqz(p, reg, 0);
+}
+
 static void il_bnez(u32 **p, struct reloc **r, unsigned int reg,
 		    enum label_id l)
 {
@@ -619,7 +652,7 @@ static void il_bgezl(u32 **p, struct rel
 	i_bgezl(p, reg, 0);
 }
 
-/* The only registers allowed in TLB handlers. */
+/* The only general purpose registers allowed in TLB handlers. */
 #define K0		26
 #define K1		27
 
@@ -653,7 +686,6 @@ static __initdata u32 tlb_handler[128];
 static __initdata struct label labels[128];
 static __initdata struct reloc relocs[128];
 
-#ifdef CONFIG_MIPS32
 /*
  * The R3000 TLB handler is simple.
  */
@@ -687,10 +719,11 @@ static void __init build_r3000_tlb_refil
 		panic("TLB refill handler space exceeded");
 
 	printk("Synthesized TLB handler (%u instructions).\n",
-	       p - tlb_handler);
+	       (unsigned int)(p - tlb_handler));
 #ifdef DEBUG_TLB
 	{
 		int i;
+
 		for (i = 0; i < (p - tlb_handler); i++)
 			printk("%08x\n", tlb_handler[i]);
 	}
@@ -699,7 +732,6 @@ static void __init build_r3000_tlb_refil
 	memcpy((void *)CAC_BASE, tlb_handler, 0x80);
 	flush_icache_range(CAC_BASE, CAC_BASE + 0x80);
 }
-#endif /* CONFIG_MIPS32 */
 
 /*
  * The R4000 TLB handler is much more complicated. We have two
@@ -749,12 +781,22 @@ static __init void __attribute__((unused
 }
 
 /*
- * Write random TLB entry, and care about the hazards from the
- * preceeding mtc0 and for the following eret.
+ * Write random or indexed TLB entry, and care about the hazards from
+ * the preceeding mtc0 and for the following eret.
  */
-static __init void build_tlb_write_random_entry(u32 **p, struct label **l,
-						struct reloc **r)
+enum tlb_write_entry { tlb_random, tlb_indexed };
+
+static __init void build_tlb_write_entry(u32 **p, struct label **l,
+					 struct reloc **r,
+					 enum tlb_write_entry wmode)
 {
+	void(*tlbw)(u32 **) = NULL;
+
+	switch (wmode) {
+	case tlb_random: tlbw = i_tlbwr; break;
+	case tlb_indexed: tlbw = i_tlbwi; break;
+	}
+
 	switch (current_cpu_data.cputype) {
 	case CPU_R4000PC:
 	case CPU_R4000SC:
@@ -764,11 +806,11 @@ static __init void build_tlb_write_rando
 	case CPU_R4400MC:
 		/*
 		 * This branch uses up a mtc0 hazard nop slot and saves
-		 * two nops after the tlbwr.
+		 * two nops after the tlbw instruction.
 		 */
-		il_bgezl(p, r, 0, label_tlbwr_hazard);
-		i_tlbwr(p);
-		l_tlbwr_hazard(l, *p);
+		il_bgezl(p, r, 0, label_tlbw_hazard);
+		tlbw(p);
+		l_tlbw_hazard(l, *p);
 		i_nop(p);
 		break;
 
@@ -783,7 +825,7 @@ static __init void build_tlb_write_rando
 	case CPU_AU1500:
 	case CPU_AU1550:
 		i_nop(p);
-		i_tlbwr(p);
+		tlbw(p);
 		break;
 
 	case CPU_R10000:
@@ -793,18 +835,18 @@ static __init void build_tlb_write_rando
 	case CPU_4KSC:
 	case CPU_20KC:
 	case CPU_25KF:
-		i_tlbwr(p);
+		tlbw(p);
 		break;
 
 	case CPU_NEVADA:
 		i_nop(p); /* QED specifies 2 nops hazard */
 		/*
 		 * This branch uses up a mtc0 hazard nop slot and saves
-		 * a nop after the tlbwr.
+		 * a nop after the tlbw instruction.
 		 */
-		il_bgezl(p, r, 0, label_tlbwr_hazard);
-		i_tlbwr(p);
-		l_tlbwr_hazard(l, *p);
+		il_bgezl(p, r, 0, label_tlbw_hazard);
+		tlbw(p);
+		l_tlbw_hazard(l, *p);
 		break;
 
 	case CPU_RM7000:
@@ -812,13 +854,13 @@ static __init void build_tlb_write_rando
 		i_nop(p);
 		i_nop(p);
 		i_nop(p);
-		i_tlbwr(p);
+		tlbw(p);
 		break;
 
 	case CPU_4KEC:
 	case CPU_24K:
 		i_ehb(p);
-		i_tlbwr(p);
+		tlbw(p);
 		break;
 
 	case CPU_RM9000:
@@ -832,7 +874,7 @@ static __init void build_tlb_write_rando
 		i_ssnop(p);
 		i_ssnop(p);
 		i_ssnop(p);
-		i_tlbwr(p);
+		tlbw(p);
 		i_ssnop(p);
 		i_ssnop(p);
 		i_ssnop(p);
@@ -846,7 +888,7 @@ static __init void build_tlb_write_rando
 	case CPU_VR4181A:
 		i_nop(p);
 		i_nop(p);
-		i_tlbwr(p);
+		tlbw(p);
 		i_nop(p);
 		i_nop(p);
 		break;
@@ -855,7 +897,7 @@ static __init void build_tlb_write_rando
 	case CPU_VR4133:
 		i_nop(p);
 		i_nop(p);
-		i_tlbwr(p);
+		tlbw(p);
 		break;
 
 	default:
@@ -883,7 +925,7 @@ build_get_pmde64(u32 **p, struct label *
 	il_bltz(p, r, tmp, label_vmalloc);
 	/* No i_nop needed here, since the next insn doesn't touch TMP. */
 
-# ifdef CONFIG_SMP
+#ifdef CONFIG_SMP
 	/*
 	 * 64 bit SMP has the lower part of &pgd_current[smp_processor_id()]
 	 * stored in CONTEXT.
@@ -901,10 +943,10 @@ build_get_pmde64(u32 **p, struct label *
 		i_dmfc0(p, tmp, C0_BADVADDR);
 	}
 	i_ld(p, ptr, 0, ptr);
-# else
+#else
 	i_LA_mostly(p, ptr, pgdc);
 	i_ld(p, ptr, rel_lo(pgdc), ptr);
-# endif
+#endif
 
 	l_vmalloc_done(l, *p);
 	i_dsrl(p, tmp, tmp, PGDIR_SHIFT-3); /* get pgd offset in bytes */
@@ -1094,14 +1136,14 @@ static void __init build_r4000_tlb_refil
 	}
 
 #ifdef CONFIG_MIPS64
-	build_get_pmde64(&p, &l, &r, K0, K1); /* get pmd ptr in K1 */
+	build_get_pmde64(&p, &l, &r, K0, K1); /* get pmd in K1 */
 #else
-	build_get_pgde32(&p, K0, K1); /* get pgd ptr in K1 */
+	build_get_pgde32(&p, K0, K1); /* get pgd in K1 */
 #endif
 
 	build_get_ptep(&p, K0, K1);
 	build_update_entries(&p, K0, K1);
-	build_tlb_write_random_entry(&p, &l, &r);
+	build_tlb_write_entry(&p, &l, &r, tlb_random);
 	l_leave(&l, p);
 	i_eret(&p); /* return from trap */
 
@@ -1172,7 +1214,8 @@ static void __init build_r4000_tlb_refil
 #endif /* CONFIG_MIPS64 */
 
 	resolve_relocs(relocs, labels);
-	printk("Synthesized TLB handler (%u instructions).\n", final_len);
+	printk("Synthesized TLB refill handler (%u instructions).\n",
+	       final_len);
 
 #ifdef DEBUG_TLB
 	{
@@ -1187,10 +1230,522 @@ static void __init build_r4000_tlb_refil
 	flush_icache_range(CAC_BASE, CAC_BASE + 0x100);
 }
 
+/*
+ * TLB load/store/modify handlers.
+ * 
+ * Only the fastpath gets synthesized at runtime, the slowpath for
+ * do_page_fault remains normal asm.
+ */
+extern void tlb_do_fault_nopage_0(void);
+extern void tlb_do_fault_nopage_1(void);
+
+#define __tlb_handler_align \
+	__attribute__((__aligned__(1 << CONFIG_MIPS_L1_CACHE_SHIFT)))
+
+/*
+ * 128 instructions for the fastpath handler is generous and should
+ * never be exceeded.
+ */
+#define FASTPATH_SIZE 128
+
+u32 __tlb_handler_align handle_tlbl[FASTPATH_SIZE];
+u32 __tlb_handler_align handle_tlbs[FASTPATH_SIZE];
+u32 __tlb_handler_align handle_tlbm[FASTPATH_SIZE];
+
+static void __init
+iPTE_LW(u32 **p, struct label **l, unsigned int pte, int offset,
+	unsigned int ptr)
+{
+#ifdef CONFIG_SMP
+	l_smp_pgtable_change(l, *p);
+# ifdef CONFIG_64BIT_PHYS_ADDR
+	if (cpu_has_64bit_gp_regs)
+		i_lld(p, pte, offset, ptr);
+	else
+# endif
+		i_LL(p, pte, offset, ptr);
+#else
+# ifdef CONFIG_64BIT_PHYS_ADDR
+	if (cpu_has_64bit_gp_regs)
+		i_ld(p, pte, offset, ptr);
+	else
+# endif
+		i_LW(p, pte, offset, ptr);
+#endif
+}
+
+static void __init
+iPTE_SW(u32 **p, struct reloc **r, unsigned int pte, int offset,
+	unsigned int ptr)
+{
+#ifdef CONFIG_SMP
+# ifdef CONFIG_64BIT_PHYS_ADDR
+	if (cpu_has_64bit_gp_regs)
+		i_scd(p, pte, offset, ptr);
+	else
+# endif
+		i_SC(p, pte, offset, ptr);
+
+	il_beqz(p, r, pte, label_smp_pgtable_change);
+	/* no i_nop needed */
+
+# ifdef CONFIG_64BIT_PHYS_ADDR
+	if (!cpu_has_64bit_gp_regs) {
+		i_ll(p, pte, sizeof(pte_t) / 2, ptr);
+		i_ori(p, pte, pte, _PAGE_VALID);
+		i_sc(p, pte, sizeof(pte_t) / 2, ptr);
+		il_beqz(p, r, pte, label_smp_pgtable_change);
+		/* no i_nop needed */
+		i_lw(p, pte, 0, ptr);
+	}
+# endif
+#else
+# ifdef CONFIG_64BIT_PHYS_ADDR
+	if (cpu_has_64bit_gp_regs)
+		i_sd(p, pte, offset, ptr);
+	else
+# endif
+		i_SW(p, pte, offset, ptr);
+
+# ifdef CONFIG_64BIT_PHYS_ADDR
+	if (!cpu_has_64bit_gp_regs) {
+		i_lw(p, pte, sizeof(pte_t) / 2, ptr);
+		i_ori(p, pte, pte, _PAGE_VALID);
+		i_sw(p, pte, sizeof(pte_t) / 2, ptr);
+		i_lw(p, pte, 0, ptr);
+	}
+# endif
+#endif
+}
+
+/*
+ * Check if PTE is present, if not then jump to LABEL. PTR points to
+ * the page table where this PTE is located, PTE will be re-loaded
+ * with it's original value.
+ */
+static void __init
+build_pte_present(u32 **p, struct label **l, struct reloc **r,
+		  unsigned int pte, unsigned int ptr, enum label_id lid)
+{
+	i_andi(p, pte, pte, _PAGE_PRESENT | _PAGE_READ);
+	i_xori(p, pte, pte, _PAGE_PRESENT | _PAGE_READ);
+	il_bnez(p, r, pte, lid);
+	iPTE_LW(p, l, pte, 0, ptr);
+}
+
+/* Make PTE valid, store result in PTR. */
+static void __init
+build_make_valid(u32 **p, struct reloc **r, unsigned int pte,
+		 unsigned int ptr)
+{
+	i_ori(p, pte, pte, _PAGE_VALID | _PAGE_ACCESSED);
+	iPTE_SW(p, r, pte, 0, ptr);
+}
+
+/*
+ * Check if PTE can be written to, if not branch to LABEL. Regardless
+ * restore PTE with value from PTR when done.
+ */
+static void __init
+build_pte_writable(u32 **p, struct label **l, struct reloc **r,
+		   unsigned int pte, unsigned int ptr, enum label_id lid)
+{
+	i_andi(p, pte, pte, _PAGE_PRESENT | _PAGE_WRITE);
+	i_xori(p, pte, pte, _PAGE_PRESENT | _PAGE_WRITE);
+	il_bnez(p, r, pte, lid);
+	iPTE_LW(p, l, pte, 0, ptr);
+}
+
+/* Make PTE writable, update software status bits as well, then store
+ * at PTR.
+ */
+static void __init
+build_make_write(u32 **p, struct reloc **r, unsigned int pte,
+		 unsigned int ptr)
+{
+	i_ori(p, pte, pte,
+	      _PAGE_ACCESSED | _PAGE_MODIFIED | _PAGE_VALID | _PAGE_DIRTY);
+	iPTE_SW(p, r, pte, 0, ptr);
+}
+
+/*
+ * Check if PTE can be modified, if not branch to LABEL. Regardless
+ * restore PTE with value from PTR when done.
+ */
+static void __init
+build_pte_modifiable(u32 **p, struct label **l, struct reloc **r,
+		     unsigned int pte, unsigned int ptr, enum label_id lid)
+{
+	i_andi(p, pte, pte, _PAGE_WRITE);
+	il_beqz(p, r, pte, lid);
+	iPTE_LW(p, l, pte, 0, ptr);
+}
+
+/*
+ * R3000 style TLB load/store/modify handlers.
+ */
+
+/* This places the pte in the page table at PTR into ENTRYLO0. */
+static void __init
+build_r3000_pte_reload(u32 **p, unsigned int ptr)
+{
+	i_lw(p, ptr, 0, ptr);
+	i_nop(p); /* load delay */
+	i_mtc0(p, ptr, C0_ENTRYLO0);
+	i_nop(p); /* cp0 delay */
+}
+
+/*
+ * The index register may have the probe fail bit set,
+ * because we would trap on access kseg2, i.e. without refill.
+ */
+static void __init
+build_r3000_tlb_write(u32 **p, struct label **l, struct reloc **r,
+		      unsigned int tmp)
+{
+	i_mfc0(p, tmp, C0_INDEX);
+	i_nop(p); /* cp0 delay */
+	il_bltz(p, r, tmp, label_r3000_write_probe_fail);
+	i_nop(p); /* branch delay */
+	i_tlbwi(p);
+	il_b(p, r, label_r3000_write_probe_ok);
+	i_nop(p); /* branch delay */
+	l_r3000_write_probe_fail(l, *p);
+	i_tlbwr(p);
+	l_r3000_write_probe_ok(l, *p);
+}
+
+static void __init
+build_r3000_tlbchange_handler_head(u32 **p, unsigned int pte,
+				   unsigned int ptr)
+{
+	long pgdc = (long)pgd_current;
+
+	i_mfc0(p, pte, C0_BADVADDR);
+	i_lui(p, ptr, rel_hi(pgdc)); /* cp0 delay */
+	i_lw(p, ptr, rel_lo(pgdc), ptr);
+	i_srl(p, pte, pte, 22); /* load delay */
+	i_sll(p, pte, pte, 2);
+	i_addu(p, ptr, ptr, pte);
+	i_mfc0(p, pte, C0_CONTEXT);
+	i_lw(p, ptr, 0, ptr); /* cp0 delay */
+	i_andi(p, pte, pte, 0xffc); /* load delay */
+	i_addu(p, ptr, ptr, pte);
+	i_lw(p, pte, 0, ptr);
+	i_nop(p); /* load delay */
+	i_tlbp(p);
+}
+
+static void __init
+build_r3000_tlbchange_handler_tail(u32 **p, unsigned int tmp)
+{
+	i_mfc0(p, tmp, C0_EPC);
+	i_nop(p); /* cp0 delay */
+	i_jr(p, tmp);
+	i_rfe(p); /* branch delay */
+}
+
+static void __init build_r3000_tlb_load_handler(void)
+{
+	u32 *p = handle_tlbl;
+	struct label *l = labels;
+	struct reloc *r = relocs;
+
+	memset(handle_tlbl, 0, sizeof(handle_tlbl));
+	memset(labels, 0, sizeof(labels));
+	memset(relocs, 0, sizeof(relocs));
+
+	build_r3000_tlbchange_handler_head(&p, K0, K1);
+	build_pte_present(&p, &l, &r, K0, K1, label_nopage_tlbl);
+	build_make_valid(&p, &r, K0, K1);
+	build_r3000_pte_reload(&p, K1);
+	build_r3000_tlb_write(&p, &l, &r, K0);
+	build_r3000_tlbchange_handler_tail(&p, K0);
+
+	l_nopage_tlbl(&l, p);
+	i_j(&p, (unsigned long)tlb_do_fault_nopage_0 & 0x0fffffff);
+	i_nop(&p);
+
+	if ((p - handle_tlbl) > FASTPATH_SIZE)
+		panic("TLB load handler fastpath space exceeded");
+
+	resolve_relocs(relocs, labels);
+	printk("Synthesized TLB load handler fastpath (%u instructions).\n",
+	       (unsigned int)(p - handle_tlbl));
+
+#ifdef DEBUG_TLB
+	{
+		int i;
+
+		for (i = 0; i < FASTPATH_SIZE; i++)
+			printk("%08x\n", handle_tlbl[i]);
+	}
+#endif
+
+	flush_icache_range((unsigned long)handle_tlbl,
+			   (unsigned long)handle_tlbl + FASTPATH_SIZE * sizeof(u32));
+}
+
+static void __init build_r3000_tlb_store_handler(void)
+{
+	u32 *p = handle_tlbs;
+	struct label *l = labels;
+	struct reloc *r = relocs;
+
+	memset(handle_tlbs, 0, sizeof(handle_tlbs));
+	memset(labels, 0, sizeof(labels));
+	memset(relocs, 0, sizeof(relocs));
+
+	build_r3000_tlbchange_handler_head(&p, K0, K1);
+	build_pte_writable(&p, &l, &r, K0, K1, label_nopage_tlbs);
+	build_make_write(&p, &r, K0, K1);
+	build_r3000_pte_reload(&p, K1);
+	build_r3000_tlb_write(&p, &l, &r, K0);
+	build_r3000_tlbchange_handler_tail(&p, K0);
+
+	l_nopage_tlbs(&l, p);
+	i_j(&p, (unsigned long)tlb_do_fault_nopage_1 & 0x0fffffff);
+	i_nop(&p);
+
+	if ((p - handle_tlbs) > FASTPATH_SIZE)
+		panic("TLB store handler fastpath space exceeded");
+
+	resolve_relocs(relocs, labels);
+	printk("Synthesized TLB store handler fastpath (%u instructions).\n",
+	       (unsigned int)(p - handle_tlbs));
+
+#ifdef DEBUG_TLB
+	{
+		int i;
+
+		for (i = 0; i < FASTPATH_SIZE; i++)
+			printk("%08x\n", handle_tlbs[i]);
+	}
+#endif
+
+	flush_icache_range((unsigned long)handle_tlbs,
+			   (unsigned long)handle_tlbs + FASTPATH_SIZE * sizeof(u32));
+}
+
+static void __init build_r3000_tlb_modify_handler(void)
+{
+	u32 *p = handle_tlbm;
+	struct label *l = labels;
+	struct reloc *r = relocs;
+
+	memset(handle_tlbm, 0, sizeof(handle_tlbm));
+	memset(labels, 0, sizeof(labels));
+	memset(relocs, 0, sizeof(relocs));
+
+	build_r3000_tlbchange_handler_head(&p, K0, K1);
+	build_pte_modifiable(&p, &l, &r, K0, K1, label_nopage_tlbm);
+	build_make_write(&p, &r, K0, K1);
+	build_r3000_pte_reload(&p, K1);
+	i_tlbwi(&p);
+	build_r3000_tlbchange_handler_tail(&p, K0);
+
+	l_nopage_tlbm(&l, p);
+	i_j(&p, (unsigned long)tlb_do_fault_nopage_1 & 0x0fffffff);
+	i_nop(&p);
+
+	if ((p - handle_tlbm) > FASTPATH_SIZE)
+		panic("TLB modify handler fastpath space exceeded");
+
+	resolve_relocs(relocs, labels);
+	printk("Synthesized TLB modify handler fastpath (%u instructions).\n",
+	       (unsigned int)(p - handle_tlbm));
+
+#ifdef DEBUG_TLB
+	{
+		int i;
+
+		for (i = 0; i < FASTPATH_SIZE; i++)
+			printk("%08x\n", handle_tlbm[i]);
+	}
+#endif
+
+	flush_icache_range((unsigned long)handle_tlbm,
+			   (unsigned long)handle_tlbm + FASTPATH_SIZE * sizeof(u32));
+}
+
+/*
+ * R4000 style TLB load/store/modify handlers.
+ */
+static void __init
+build_r4000_tlbchange_handler_head(u32 **p, struct label **l,
+				   struct reloc **r, unsigned int tmp,
+				   unsigned int ptr)
+{
+#ifdef CONFIG_MIPS64
+	build_get_pmde64(p, l, r, tmp, ptr); /* get pmd in ptr */
+#else
+	build_get_pgde32(p, tmp, ptr); /* get pgd in ptr */
+#endif
+
+	i_MFC0(p, tmp, C0_BADVADDR);
+	i_LW(p, ptr, 0, ptr);
+	i_SRL(p, tmp, tmp, PAGE_SHIFT - PTE_T_LOG2);
+	i_andi(p, tmp, tmp, (PTRS_PER_PTE - 1) << PTE_T_LOG2);
+	i_ADDU(p, ptr, ptr, tmp);
+
+	iPTE_LW(p, l, tmp, 0, ptr); /* get even pte */
+	build_tlb_probe_entry(p);
+}
+
+static void __init
+build_r4000_tlbchange_handler_tail(u32 **p, struct label **l,
+				   struct reloc **r, unsigned int tmp,
+				   unsigned int ptr)
+{
+	i_ori(p, ptr, ptr, sizeof(pte_t));
+	i_xori(p, ptr, ptr, sizeof(pte_t));
+	build_update_entries(p, tmp, ptr);
+	build_tlb_write_entry(p, l, r, tlb_indexed);
+	l_leave(l, *p);
+	i_eret(p); /* return from trap */
+
+#ifdef CONFIG_MIPS64
+	build_get_pgd_vmalloc64(p, l, r, tmp, ptr);
+#endif
+}
+
+static void __init build_r4000_tlb_load_handler(void)
+{
+	u32 *p = handle_tlbl;
+	struct label *l = labels;
+	struct reloc *r = relocs;
+
+	memset(handle_tlbl, 0, sizeof(handle_tlbl));
+	memset(labels, 0, sizeof(labels));
+	memset(relocs, 0, sizeof(relocs));
+
+	if (bcm1250_m3_war()) {
+		i_MFC0(&p, K0, C0_BADVADDR);
+		i_MFC0(&p, K1, C0_ENTRYHI);
+		i_xor(&p, K0, K0, K1);
+		i_SRL(&p, K0, K0, PAGE_SHIFT+1);
+		il_bnez(&p, &r, K0, label_leave);
+		/* No need for i_nop */
+	}
+
+	build_r4000_tlbchange_handler_head(&p, &l, &r, K0, K1);
+	build_pte_present(&p, &l, &r, K0, K1, label_nopage_tlbl);
+	build_make_valid(&p, &r, K0, K1);
+	build_r4000_tlbchange_handler_tail(&p, &l, &r, K0, K1);
+
+	l_nopage_tlbl(&l, p);
+	i_j(&p, (unsigned long)tlb_do_fault_nopage_0 & 0x0fffffff);
+	i_nop(&p);
+
+	if ((p - handle_tlbl) > FASTPATH_SIZE)
+		panic("TLB load handler fastpath space exceeded");
+
+	resolve_relocs(relocs, labels);
+	printk("Synthesized TLB load handler fastpath (%u instructions).\n",
+	       (unsigned int)(p - handle_tlbl));
+
+#ifdef DEBUG_TLB
+	{
+		int i;
+
+		for (i = 0; i < FASTPATH_SIZE; i++)
+			printk("%08x\n", handle_tlbl[i]);
+	}
+#endif
+
+	flush_icache_range((unsigned long)handle_tlbl,
+			   (unsigned long)handle_tlbl + FASTPATH_SIZE * sizeof(u32));
+}
+
+static void __init build_r4000_tlb_store_handler(void)
+{
+	u32 *p = handle_tlbs;
+	struct label *l = labels;
+	struct reloc *r = relocs;
+
+	memset(handle_tlbs, 0, sizeof(handle_tlbs));
+	memset(labels, 0, sizeof(labels));
+	memset(relocs, 0, sizeof(relocs));
+
+	build_r4000_tlbchange_handler_head(&p, &l, &r, K0, K1);
+	build_pte_writable(&p, &l, &r, K0, K1, label_nopage_tlbs);
+	build_make_write(&p, &r, K0, K1);
+	build_r4000_tlbchange_handler_tail(&p, &l, &r, K0, K1);
+
+	l_nopage_tlbs(&l, p);
+	i_j(&p, (unsigned long)tlb_do_fault_nopage_1 & 0x0fffffff);
+	i_nop(&p);
+
+	if ((p - handle_tlbs) > FASTPATH_SIZE)
+		panic("TLB store handler fastpath space exceeded");
+
+	resolve_relocs(relocs, labels);
+	printk("Synthesized TLB store handler fastpath (%u instructions).\n",
+	       (unsigned int)(p - handle_tlbs));
+
+#ifdef DEBUG_TLB
+	{
+		int i;
+
+		for (i = 0; i < FASTPATH_SIZE; i++)
+			printk("%08x\n", handle_tlbs[i]);
+	}
+#endif
+
+	flush_icache_range((unsigned long)handle_tlbs,
+			   (unsigned long)handle_tlbs + FASTPATH_SIZE * sizeof(u32));
+}
+
+static void __init build_r4000_tlb_modify_handler(void)
+{
+	u32 *p = handle_tlbm;
+	struct label *l = labels;
+	struct reloc *r = relocs;
+
+	memset(handle_tlbm, 0, sizeof(handle_tlbm));
+	memset(labels, 0, sizeof(labels));
+	memset(relocs, 0, sizeof(relocs));
+
+	build_r4000_tlbchange_handler_head(&p, &l, &r, K0, K1);
+	build_pte_modifiable(&p, &l, &r, K0, K1, label_nopage_tlbm);
+	/* Present and writable bits set, set accessed and dirty bits. */
+	build_make_write(&p, &r, K0, K1);
+	build_r4000_tlbchange_handler_tail(&p, &l, &r, K0, K1);
+
+	l_nopage_tlbm(&l, p);
+	i_j(&p, (unsigned long)tlb_do_fault_nopage_1 & 0x0fffffff);
+	i_nop(&p);
+
+	if ((p - handle_tlbm) > FASTPATH_SIZE)
+		panic("TLB modify handler fastpath space exceeded");
+
+	resolve_relocs(relocs, labels);
+	printk("Synthesized TLB modify handler fastpath (%u instructions).\n",
+	       (unsigned int)(p - handle_tlbm));
+
+#ifdef DEBUG_TLB
+	{
+		int i;
+
+		for (i = 0; i < FASTPATH_SIZE; i++)
+			printk("%08x\n", handle_tlbm[i]);
+	}
+#endif
+
+	flush_icache_range((unsigned long)handle_tlbm,
+			   (unsigned long)handle_tlbm + FASTPATH_SIZE * sizeof(u32));
+}
+
 void __init build_tlb_refill_handler(void)
 {
+	/*
+	 * The refill handler is generated per-CPU, multi-node systems
+	 * may have local storage for it. The other handlers are only
+	 * needed once.
+	 */
+	static int run_once = 0;
+
 	switch (current_cpu_data.cputype) {
-#ifdef CONFIG_MIPS32
 	case CPU_R2000:
 	case CPU_R3000:
 	case CPU_R3000A:
@@ -1199,13 +1754,18 @@ void __init build_tlb_refill_handler(voi
 	case CPU_TX3922:
 	case CPU_TX3927:
 		build_r3000_tlb_refill_handler();
+		if (!run_once) {
+			build_r3000_tlb_load_handler();
+			build_r3000_tlb_store_handler();
+			build_r3000_tlb_modify_handler();
+			run_once++;
+		}
 		break;
 
 	case CPU_R6000:
 	case CPU_R6000A:
 		panic("No R6000 TLB refill handler yet");
 		break;
-#endif
 
 	case CPU_R8000:
 		panic("No R8000 TLB refill handler yet");
@@ -1213,5 +1773,11 @@ void __init build_tlb_refill_handler(voi
 
 	default:
 		build_r4000_tlb_refill_handler();
+		if (!run_once) {
+			build_r4000_tlb_load_handler();
+			build_r4000_tlb_store_handler();
+			build_r4000_tlb_modify_handler();
+			run_once++;
+		}
 	}
 }
Index: arch/mips/mm/tlbex32-mips32.S
===================================================================
RCS file: arch/mips/mm/tlbex32-mips32.S
diff -N arch/mips/mm/tlbex32-mips32.S
--- arch/mips/mm/tlbex32-mips32.S	9 Dec 2004 15:16:52 -0000	1.4
+++ /dev/null	1 Jan 1970 00:00:00 -0000
@@ -1,250 +0,0 @@
-/*
- * TLB exception handling code for MIPS32 CPUs.
- *
- * Copyright (C) 1994, 1995, 1996 by Ralf Baechle and Andreas Busse
- *
- * Multi-cpu abstraction and reworking:
- * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
- *
- * Carsten Langgaard, carstenl@mips.com
- * Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
- *
- * Pete Popov, ppopov@pacbell.net
- * Added 36 bit phys address support.
- * Copyright (C) 2002 MontaVista Software, Inc.
- */
-#include <linux/init.h>
-#include <asm/asm.h>
-#include <asm/cachectl.h>
-#include <asm/fpregdef.h>
-#include <asm/mipsregs.h>
-#include <asm/page.h>
-#include <asm/pgtable-bits.h>
-#include <asm/regdef.h>
-#include <asm/stackframe.h>
-
-#define TLB_OPTIMIZE /* If you are paranoid, disable this. */
-
-#ifdef CONFIG_64BIT_PHYS_ADDR
-
-/* We really only support 36 bit physical addresses on MIPS32 */
-#define PTE_L		lw
-#define PTE_S		sw
-#define PTE_SRL		srl
-#define P_MTC0		mtc0
-#define PTE_HALF        4 /* pte_high contains pre-shifted, ready to go entry */
-#define PTE_SIZE        8
-#define PTEP_INDX_MSK	0xff0
-#define PTE_INDX_MSK	0xff8
-#define PTE_INDX_SHIFT 9
-#define CONVERT_PTE(pte)
-#define PTE_MAKEWRITE_HIGH(pte, ptr) \
-	lw	pte, PTE_HALF(ptr); \
-	ori	pte, (_PAGE_VALID | _PAGE_DIRTY); \
-	sw	pte, PTE_HALF(ptr); \
-	lw	pte, 0(ptr);
-
-#define PTE_MAKEVALID_HIGH(pte, ptr) \
-	lw	pte, PTE_HALF(ptr); \
-	ori	pte, pte, _PAGE_VALID; \
-	sw	pte, PTE_HALF(ptr); \
-	lw	pte, 0(ptr);
-
-#else
-
-#define PTE_L		lw
-#define PTE_S		sw
-#define PTE_SRL		srl
-#define P_MTC0		mtc0
-#define PTE_HALF        0
-#define PTE_SIZE	4
-#define PTEP_INDX_MSK	0xff8
-#define PTE_INDX_MSK	0xffc
-#define PTE_INDX_SHIFT	10
-#define CONVERT_PTE(pte) srl pte, pte, 6
-#define PTE_MAKEWRITE_HIGH(pte, ptr)
-#define PTE_MAKEVALID_HIGH(pte, ptr)
-
-#endif  /* CONFIG_64BIT_PHYS_ADDR */
-
-#ifdef CONFIG_64BIT_PHYS_ADDR
-#define GET_PTE_OFF(reg)
-#else
-#define GET_PTE_OFF(reg)	srl	reg, reg, 1
-#endif
-
-/*
- * ABUSE of CPP macros 101.
- *
- * After this macro runs, the pte faulted on is
- * in register PTE, a ptr into the table in which
- * the pte belongs is in PTR.
- */
-
-#ifdef CONFIG_SMP
-#define GET_PGD(scratch, ptr)        \
-	mfc0    ptr, CP0_CONTEXT;    \
-	la      scratch, pgd_current;\
-	srl     ptr, 23;             \
-	sll     ptr, 2;              \
-	addu    ptr, scratch, ptr;   \
-	lw      ptr, (ptr);
-#else
-#define GET_PGD(scratch, ptr)    \
-	lw	ptr, pgd_current;
-#endif
-
-#define LOAD_PTE(pte, ptr) \
-	GET_PGD(pte, ptr)          \
-	mfc0	pte, CP0_BADVADDR; \
-	srl	pte, pte, _PGDIR_SHIFT; \
-	sll	pte, pte, 2; \
-	addu	ptr, ptr, pte; \
-	mfc0	pte, CP0_BADVADDR; \
-	lw	ptr, (ptr); \
-	srl	pte, pte, PTE_INDX_SHIFT; \
-	and	pte, pte, PTE_INDX_MSK; \
-	addu	ptr, ptr, pte; \
-	PTE_L	pte, (ptr);
-
-	/* This places the even/odd pte pair in the page
-	 * table at PTR into ENTRYLO0 and ENTRYLO1 using
-	 * TMP as a scratch register.
-	 */
-#define PTE_RELOAD(ptr, tmp) \
-	ori	ptr, ptr, PTE_SIZE; \
-	xori	ptr, ptr, PTE_SIZE; \
-	PTE_L	tmp, (PTE_HALF+PTE_SIZE)(ptr); \
-	CONVERT_PTE(tmp); \
-	P_MTC0	tmp, CP0_ENTRYLO1; \
-	PTE_L	ptr, PTE_HALF(ptr); \
-	CONVERT_PTE(ptr); \
-	P_MTC0	ptr, CP0_ENTRYLO0;
-
-#define DO_FAULT(write) \
-	SAVE_ALL; \
-	mfc0	a2, CP0_BADVADDR; \
-	KMODE; \
-	move	a0, sp; \
-	sw	a2, PT_BVADDR(sp); \
-	jal	do_page_fault; \
-	 li	a1, write; \
-	j	ret_from_exception; \
-	 nop;
-
-	/* Check is PTE is present, if not then jump to LABEL.
-	 * PTR points to the page table where this PTE is located,
-	 * when the macro is done executing PTE will be restored
-	 * with it's original value.
-	 */
-#define PTE_PRESENT(pte, ptr, label) \
-	andi	pte, pte, (_PAGE_PRESENT | _PAGE_READ); \
-	xori	pte, pte, (_PAGE_PRESENT | _PAGE_READ); \
-	bnez	pte, label; \
-	PTE_L	pte, (ptr);
-
-	/* Make PTE valid, store result in PTR. */
-#define PTE_MAKEVALID(pte, ptr) \
-	ori	pte, pte, (_PAGE_VALID | _PAGE_ACCESSED); \
-	PTE_S	pte, (ptr);
-
-	/* Check if PTE can be written to, if not branch to LABEL.
-	 * Regardless restore PTE with value from PTR when done.
-	 */
-#define PTE_WRITABLE(pte, ptr, label) \
-	andi	pte, pte, (_PAGE_PRESENT | _PAGE_WRITE); \
-	xori	pte, pte, (_PAGE_PRESENT | _PAGE_WRITE); \
-	bnez	pte, label; \
-	PTE_L	pte, (ptr);
-
-	/* Make PTE writable, update software status bits as well,
-	 * then store at PTR.
-	 */
-#define PTE_MAKEWRITE(pte, ptr) \
-	ori	pte, pte, (_PAGE_ACCESSED | _PAGE_MODIFIED | \
-			   _PAGE_VALID | _PAGE_DIRTY); \
-	PTE_S	pte, (ptr);
-
-	.set	noreorder
-	.set	noat
-
-	.align	5
-	NESTED(handle_tlbl, PT_SIZE, sp)
-
-#ifdef TLB_OPTIMIZE
-	/* Test present bit in entry. */
-	LOAD_PTE(k0, k1)
-	tlbp
-	PTE_PRESENT(k0, k1, nopage_tlbl)
-	PTE_MAKEVALID_HIGH(k0, k1)
-	PTE_MAKEVALID(k0, k1)
-	PTE_RELOAD(k1, k0)
-	nop
-	b	1f
-	 tlbwi
-1:
-	nop
-	.set	mips3
-	eret
-	.set	mips0
-nopage_tlbl:
-#endif
-
-	DO_FAULT(0)
-	END(handle_tlbl)
-
-	.align	5
-	NESTED(handle_tlbs, PT_SIZE, sp)
-
-#ifdef TLB_OPTIMIZE
-	.set	mips3
-	LOAD_PTE(k0, k1)
-	tlbp				# find faulting entry
-	PTE_WRITABLE(k0, k1, nopage_tlbs)
-	PTE_MAKEWRITE(k0, k1)
-	PTE_MAKEWRITE_HIGH(k0, k1)
-	PTE_RELOAD(k1, k0)
-	nop
-	b	1f
-	 tlbwi
-1:
-	nop
-	.set	mips3
-	eret
-	.set	mips0
-nopage_tlbs:
-#endif
-
-	DO_FAULT(1)
-	END(handle_tlbs)
-
-	.align	5
-	NESTED(handle_mod, PT_SIZE, sp)
-
-#ifdef TLB_OPTIMIZE
-	.set	mips3
-	LOAD_PTE(k0, k1)
-	tlbp					# find faulting entry
-	andi	k0, k0, _PAGE_WRITE
-	beqz	k0, nowrite_mod
-	PTE_L	k0, (k1)
-
-	/* Present and writable bits set, set accessed and dirty bits. */
-	PTE_MAKEWRITE(k0, k1)
-	PTE_MAKEWRITE_HIGH(k0, k1)
-	/* Now reload the entry into the tlb. */
-	PTE_RELOAD(k1, k0)
-	nop
-	b	1f
-	 tlbwi
-1:
-	nop
-	.set	mips3
-	eret
-	.set	mips0
-nowrite_mod:
-#endif
-
-	DO_FAULT(1)
-	END(handle_mod)
-
Index: arch/mips/mm/tlbex32-r3k.S
===================================================================
RCS file: arch/mips/mm/tlbex32-r3k.S
diff -N arch/mips/mm/tlbex32-r3k.S
--- arch/mips/mm/tlbex32-r3k.S	9 Dec 2004 15:16:52 -0000	1.5
+++ /dev/null	1 Jan 1970 00:00:00 -0000
@@ -1,187 +0,0 @@
-/*
- * TLB exception handling code for R2000/R3000.
- *
- * Copyright (C) 1994, 1995, 1996 by Ralf Baechle and Andreas Busse
- *
- * Multi-CPU abstraction reworking:
- * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
- *
- * Further modifications to make this work:
- * Copyright (c) 1998 Harald Koerfgen
- * Copyright (c) 1998, 1999 Gleb Raiko & Vladimir Roganov
- * Copyright (c) 2001 Ralf Baechle
- * Copyright (c) 2001 MIPS Technologies, Inc.
- */
-#include <linux/init.h>
-#include <asm/asm.h>
-#include <asm/cachectl.h>
-#include <asm/fpregdef.h>
-#include <asm/mipsregs.h>
-#include <asm/page.h>
-#include <asm/pgtable-bits.h>
-#include <asm/regdef.h>
-#include <asm/stackframe.h>
-
-#define TLB_OPTIMIZE /* If you are paranoid, disable this. */
-
-	/* ABUSE of CPP macros 101. */
-
-	/* After this macro runs, the pte faulted on is
-	 * in register PTE, a ptr into the table in which
-	 * the pte belongs is in PTR.
-	 */
-#define LOAD_PTE(pte, ptr) \
-	mfc0	pte, CP0_BADVADDR; \
-	lw	ptr, pgd_current; \
-	srl	pte, pte, 22; \
-	sll	pte, pte, 2; \
-	addu	ptr, ptr, pte; \
-	mfc0	pte, CP0_CONTEXT; \
-	lw	ptr, (ptr); \
-	andi	pte, pte, 0xffc; \
-	addu	ptr, ptr, pte; \
-	lw	pte, (ptr); \
-	nop;
-
-	/* This places the pte in the page table at PTR into ENTRYLO0. */
-#define PTE_RELOAD(ptr) \
-	lw	ptr, (ptr)	; \
-	nop			; \
-	mtc0	ptr, CP0_ENTRYLO0; \
-	nop;
-
-#define DO_FAULT(write) \
-	SAVE_ALL; \
-	mfc0	a2, CP0_BADVADDR; \
-	KMODE; \
-	move	a0, sp; \
-	sw	a2, PT_BVADDR(sp); \
-	jal	do_page_fault; \
-	 li	a1, write; \
-	j	ret_from_exception; \
-	 nop;
-
-	/* Check is PTE is present, if not then jump to LABEL.
-	 * PTR points to the page table where this PTE is located,
-	 * when the macro is done executing PTE will be restored
-	 * with it's original value.
-	 */
-#define PTE_PRESENT(pte, ptr, label) \
-	andi	pte, pte, (_PAGE_PRESENT | _PAGE_READ); \
-	xori	pte, pte, (_PAGE_PRESENT | _PAGE_READ); \
-	bnez	pte, label; \
-	.set	push;       \
-	.set	reorder;    \
-	 lw	pte, (ptr); \
-	.set	pop;
-
-	/* Make PTE valid, store result in PTR. */
-#define PTE_MAKEVALID(pte, ptr) \
-	ori	pte, pte, (_PAGE_VALID | _PAGE_ACCESSED); \
-	sw	pte, (ptr);
-
-	/* Check if PTE can be written to, if not branch to LABEL.
-	 * Regardless restore PTE with value from PTR when done.
-	 */
-#define PTE_WRITABLE(pte, ptr, label) \
-	andi	pte, pte, (_PAGE_PRESENT | _PAGE_WRITE); \
-	xori	pte, pte, (_PAGE_PRESENT | _PAGE_WRITE); \
-	bnez	pte, label; \
-	.set    push;       \
-	.set    reorder;    \
-	lw      pte, (ptr); \
-	.set    pop;
-
-
-	/* Make PTE writable, update software status bits as well,
-	 * then store at PTR.
-	 */
-#define PTE_MAKEWRITE(pte, ptr) \
-	ori	pte, pte, (_PAGE_ACCESSED | _PAGE_MODIFIED | \
-			   _PAGE_VALID | _PAGE_DIRTY); \
-	sw	pte, (ptr);
-
-/*
- * The index register may have the probe fail bit set,
- * because we would trap on access kseg2, i.e. without refill.
- */
-#define TLB_WRITE(reg) \
-	mfc0	reg, CP0_INDEX; \
-	nop; \
-	bltz    reg, 1f; \
-	 nop; \
-	tlbwi; \
-	j	2f; \
-	 nop; \
-1:	tlbwr; \
-2:
-
-#define RET(reg) \
-	mfc0	reg, CP0_EPC; \
-	nop; \
-	jr	reg; \
-	 rfe
-
-	.set	noreorder
-	.set	noat
-
-	.align	5
-NESTED(handle_tlbl, PT_SIZE, sp)
-
-#ifdef TLB_OPTIMIZE
-	/* Test present bit in entry. */
-	LOAD_PTE(k0, k1)
-        tlbp
-        PTE_PRESENT(k0, k1, nopage_tlbl)
-        PTE_MAKEVALID(k0, k1)
-        PTE_RELOAD(k1)
-	TLB_WRITE(k0)
-	RET(k0)
-nopage_tlbl:
-#endif
-
-	DO_FAULT(0)
-END(handle_tlbl)
-
-	.align	5
-NESTED(handle_tlbs, PT_SIZE, sp)
-
-#ifdef TLB_OPTIMIZE
-	LOAD_PTE(k0, k1)
-	tlbp                            # find faulting entry
-	PTE_WRITABLE(k0, k1, nopage_tlbs)
-	PTE_MAKEWRITE(k0, k1)
-	PTE_RELOAD(k1)
-	TLB_WRITE(k0)
-	RET(k0)
-nopage_tlbs:
-#endif
-
-	DO_FAULT(1)
-END(handle_tlbs)
-
-	.align	5
-NESTED(handle_mod, PT_SIZE, sp)
-
-#ifdef TLB_OPTIMIZE
-	LOAD_PTE(k0, k1)
-	tlbp					# find faulting entry
-	andi	k0, k0, _PAGE_WRITE
-	beqz	k0, nowrite_mod
-	.set	push
-	.set    reorder
-	lw	k0, (k1)
-	.set    pop
-
-	/* Present and writable bits set, set accessed and dirty bits. */
-	PTE_MAKEWRITE(k0, k1)
-
-	/* Now reload the entry into the tlb. */
-	PTE_RELOAD(k1)
-	tlbwi
-	RET(k0)
-nowrite_mod:
-#endif
-
-	DO_FAULT(1)
-END(handle_mod)
Index: arch/mips/mm/tlbex32-r4k.S
===================================================================
RCS file: arch/mips/mm/tlbex32-r4k.S
diff -N arch/mips/mm/tlbex32-r4k.S
--- arch/mips/mm/tlbex32-r4k.S	9 Dec 2004 15:16:52 -0000	1.5
+++ /dev/null	1 Jan 1970 00:00:00 -0000
@@ -1,256 +0,0 @@
-/*
- * TLB exception handling code for r4k.
- *
- * Copyright (C) 1994, 1995, 1996 by Ralf Baechle and Andreas Busse
- *
- * Multi-cpu abstraction and reworking:
- * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
- *
- * Carsten Langgaard, carstenl@mips.com
- * Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
- */
-#include <linux/init.h>
-#include <linux/config.h>
-
-#include <asm/asm.h>
-#include <asm/offset.h>
-#include <asm/cachectl.h>
-#include <asm/fpregdef.h>
-#include <asm/mipsregs.h>
-#include <asm/page.h>
-#include <asm/pgtable-bits.h>
-#include <asm/regdef.h>
-#include <asm/stackframe.h>
-#include <asm/war.h>
-
-#define TLB_OPTIMIZE /* If you are paranoid, disable this. */
-
-#ifdef CONFIG_64BIT_PHYS_ADDR
-#define PTE_L		ld
-#define PTE_S		sd
-#define PTE_SRL		dsrl
-#define P_MTC0		dmtc0
-#define PTE_SIZE	8
-#define PTEP_INDX_MSK	0xff0
-#define PTE_INDX_MSK	0xff8
-#define PTE_INDX_SHIFT	9
-#else
-#define PTE_L		lw
-#define PTE_S		sw
-#define PTE_SRL		srl
-#define P_MTC0		mtc0
-#define PTE_SIZE	4
-#define PTEP_INDX_MSK	0xff8
-#define PTE_INDX_MSK	0xffc
-#define PTE_INDX_SHIFT	10
-#endif
-
-/*
- * ABUSE of CPP macros 101.
- *
- * After this macro runs, the pte faulted on is
- * in register PTE, a ptr into the table in which
- * the pte belongs is in PTR.
- */
-
-#ifdef CONFIG_SMP
-#define GET_PGD(scratch, ptr)        \
-	mfc0    ptr, CP0_CONTEXT;    \
-	la      scratch, pgd_current;\
-	srl     ptr, 23;             \
-	sll     ptr, 2;              \
-	addu    ptr, scratch, ptr;   \
-	lw      ptr, (ptr);
-#else
-#define GET_PGD(scratch, ptr)    \
-	lw	ptr, pgd_current;
-#endif
-
-#define LOAD_PTE(pte, ptr) \
-	GET_PGD(pte, ptr)          \
-	mfc0	pte, CP0_BADVADDR; \
-	srl	pte, pte, _PGDIR_SHIFT; \
-	sll	pte, pte, 2; \
-	addu	ptr, ptr, pte; \
-	mfc0	pte, CP0_BADVADDR; \
-	lw	ptr, (ptr); \
-	srl	pte, pte, PTE_INDX_SHIFT; \
-	and	pte, pte, PTE_INDX_MSK; \
-	addu	ptr, ptr, pte; \
-	PTE_L	pte, (ptr);
-
-	/* This places the even/odd pte pair in the page
-	 * table at PTR into ENTRYLO0 and ENTRYLO1 using
-	 * TMP as a scratch register.
-	 */
-#define PTE_RELOAD(ptr, tmp) \
-	ori	ptr, ptr, PTE_SIZE; \
-	xori	ptr, ptr, PTE_SIZE; \
-	PTE_L	tmp, PTE_SIZE(ptr); \
-	PTE_L	ptr, 0(ptr); \
-	PTE_SRL	tmp, tmp, 6; \
-	P_MTC0	tmp, CP0_ENTRYLO1; \
-	PTE_SRL	ptr, ptr, 6; \
-	P_MTC0	ptr, CP0_ENTRYLO0;
-
-#define DO_FAULT(write) \
-	SAVE_ALL; \
-	mfc0	a2, CP0_BADVADDR; \
-	KMODE; \
-	move	a0, sp; \
-	sw	a2, PT_BVADDR(sp); \
-	jal	do_page_fault; \
-	 li	a1, write; \
-	j	ret_from_exception; \
-	 nop;
-
-	/* Check if PTE is present, if not then jump to LABEL.
-	 * PTR points to the page table where this PTE is located,
-	 * when the macro is done executing PTE will be restored
-	 * with it's original value.
-	 */
-#define PTE_PRESENT(pte, ptr, label) \
-	andi	pte, pte, (_PAGE_PRESENT | _PAGE_READ); \
-	xori	pte, pte, (_PAGE_PRESENT | _PAGE_READ); \
-	bnez	pte, label; \
-	 PTE_L	pte, (ptr);
-
-	/* Make PTE valid, store result in PTR. */
-#define PTE_MAKEVALID(pte, ptr) \
-	ori	pte, pte, (_PAGE_VALID | _PAGE_ACCESSED); \
-	PTE_S	pte, (ptr);
-
-	/* Check if PTE can be written to, if not branch to LABEL.
-	 * Regardless restore PTE with value from PTR when done.
-	 */
-#define PTE_WRITABLE(pte, ptr, label) \
-	andi	pte, pte, (_PAGE_PRESENT | _PAGE_WRITE); \
-	xori	pte, pte, (_PAGE_PRESENT | _PAGE_WRITE); \
-	bnez	pte, label; \
-	 PTE_L	pte, (ptr);
-
-	/* Make PTE writable, update software status bits as well,
-	 * then store at PTR.
-	 */
-#define PTE_MAKEWRITE(pte, ptr) \
-	ori	pte, pte, (_PAGE_ACCESSED | _PAGE_MODIFIED | \
-			   _PAGE_VALID | _PAGE_DIRTY); \
-	PTE_S	pte, (ptr);
-
-
-	.set	noreorder
-	.set	noat
-
-/*
- * From the IDT errata for the QED RM5230 (Nevada), processor revision 1.0:
- * 2. A timing hazard exists for the TLBP instruction.
- *
- *      stalling_instruction
- *      TLBP
- *
- * The JTLB is being read for the TLBP throughout the stall generated by the
- * previous instruction. This is not really correct as the stalling instruction
- * can modify the address used to access the JTLB.  The failure symptom is that
- * the TLBP instruction will use an address created for the stalling instruction
- * and not the address held in C0_ENHI and thus report the wrong results.
- *
- * The software work-around is to not allow the instruction preceding the TLBP
- * to stall - make it an NOP or some other instruction guaranteed not to stall.
- *
- * Errata 2 will not be fixed.  This errata is also on the R5000.
- *
- * As if we MIPS hackers wouldn't know how to nop pipelines happy ...
- */
-#define R5K_HAZARD nop
-
-	/*
-	 * Note for many R4k variants tlb probes cannot be executed out
-	 * of the instruction cache else you get bogus results.
-	 */
-	.align	5
-	NESTED(handle_tlbl, PT_SIZE, sp)
-#if BCM1250_M3_WAR
-	mfc0	k0, CP0_BADVADDR
-	mfc0	k1, CP0_ENTRYHI
-	xor	k0, k1
-	srl	k0, k0, PAGE_SHIFT+1
-	beqz	k0, 1f
-	 nop
-	.set	mips3
-	eret
-	.set	mips0
-1:
-#endif
-#ifdef TLB_OPTIMIZE
-	.set	mips3
-	/* Test present bit in entry. */
-	LOAD_PTE(k0, k1)
-	R5K_HAZARD
-	tlbp
-	PTE_PRESENT(k0, k1, nopage_tlbl)
-	PTE_MAKEVALID(k0, k1)
-	PTE_RELOAD(k1, k0)
-	mtc0_tlbw_hazard
-	tlbwi
-	nop
-	tlbw_eret_hazard
-	.set	mips3
-	eret
-	.set	mips0
-#endif
-
-nopage_tlbl:
-	DO_FAULT(0)
-	END(handle_tlbl)
-
-	.align	5
-	NESTED(handle_tlbs, PT_SIZE, sp)
-#ifdef TLB_OPTIMIZE
-	.set	mips3
-	LOAD_PTE(k0, k1)
-	R5K_HAZARD
-	tlbp				# find faulting entry
-	PTE_WRITABLE(k0, k1, nopage_tlbs)
-	PTE_MAKEWRITE(k0, k1)
-	PTE_RELOAD(k1, k0)
-	mtc0_tlbw_hazard
-	tlbwi
-	nop
-	tlbw_eret_hazard
-	.set	mips3
-	eret
-	.set	mips0
-#endif
-
-nopage_tlbs:
-	DO_FAULT(1)
-	END(handle_tlbs)
-
-	.align	5
-	NESTED(handle_mod, PT_SIZE, sp)
-#ifdef TLB_OPTIMIZE
-	.set	mips3
-	LOAD_PTE(k0, k1)
-	R5K_HAZARD
-	tlbp					# find faulting entry
-	andi	k0, k0, _PAGE_WRITE
-	beqz	k0, nowrite_mod
-	 PTE_L	k0, (k1)
-
-	/* Present and writable bits set, set accessed and dirty bits. */
-	PTE_MAKEWRITE(k0, k1)
-
-	/* Now reload the entry into the tlb. */
-	PTE_RELOAD(k1, k0)
-	mtc0_tlbw_hazard
-	tlbwi
-	nop
-	tlbw_eret_hazard
-	.set	mips3
-	eret
-	.set	mips0
-#endif
-
-nowrite_mod:
-	DO_FAULT(1)
-	END(handle_mod)
Index: arch/mips/mm/tlbex64.S
===================================================================
RCS file: arch/mips/mm/tlbex64.S
diff -N arch/mips/mm/tlbex64.S
--- arch/mips/mm/tlbex64.S	9 Dec 2004 15:13:45 -0000	1.1
+++ /dev/null	1 Jan 1970 00:00:00 -0000
@@ -1,41 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 1999 Ralf Baechle
- * Copyright (C) 1999 Silicon Graphics, Inc.
- */
-#include <linux/init.h>
-#include <asm/mipsregs.h>
-#include <asm/page.h>
-#include <asm/regdef.h>
-#include <asm/stackframe.h>
-#include <asm/war.h>
-
-	.macro	tlb_handler name writebit
-	NESTED(__\name, PT_SIZE, sp)
-#if BCM1250_M3_WAR
-	dmfc0	k0, CP0_BADVADDR
-	dmfc0	k1, CP0_ENTRYHI
-	xor	k0, k1
-	dsrl	k0, k0, PAGE_SHIFT + 1
-	bnez	k0, 1f
-#endif
-	SAVE_ALL
-	dmfc0	a2, CP0_BADVADDR
-	KMODE
-	li	a1, \writebit
-	sd	a2, PT_BVADDR(sp)
-	move	a0, sp
-	jal	do_page_fault
-#if BCM1250_M3_WAR
-1:
-#endif
-	j	ret_from_exception
-	END(__\name)
-	.endm
-
-	tlb_handler	xtlb_mod 1
-	tlb_handler	xtlb_tlbl 0
-	tlb_handler	xtlb_tlbs 1
