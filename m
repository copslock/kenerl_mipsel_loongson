Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Feb 2008 19:32:59 +0000 (GMT)
Received: from relay01.mx.bawue.net ([193.7.176.67]:18875 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S28574267AbYBRTcz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 18 Feb 2008 19:32:55 +0000
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id 6DEE64892F;
	Mon, 18 Feb 2008 20:32:49 +0100 (CET)
Received: from ths by lagash with local (Exim 4.69)
	(envelope-from <ths@networkno.de>)
	id 1JRBjN-0005El-78; Mon, 18 Feb 2008 19:32:49 +0000
Date:	Mon, 18 Feb 2008 19:32:49 +0000
From:	Thiemo Seufer <ths@networkno.de>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Reimplement clear_page/copy_page
Message-ID: <20080218193249.GD4747@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18257
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Fold the SB-1 specific implementation of clear_page/copy_page in the
generic version, and rewrite that one in tlbex style. The immediate
benefits:
  - It converts the compile-time workaround for SB-1 pass 1 prefetches
    to a more efficient run-time check.
  - It allows adjustment of loop unfolling, which helps to reduce the
    number of redundant cdex cache ops.
  - It fixes some esoteric cornercases (the cache line length calculations
    can go wrong, and support for 64k pages without prefetch instructions
    will overflow the addiu immediate).
  - Somewhat better guesses of "good" prefetch values.


Signed-off-by: Thiemo Seufer <ths@networkno.de>
---

Lmbench3 running on a BCM1480 system shows improvements for some
benchmarks (three runs with the original kernel, then three runs
with the patched kernel), most markedly (~5%) for open/close and
exec:

Processor, Processes - times in microseconds - smaller is better
------------------------------------------------------------------------------
Host                 OS  Mhz null null      open slct sig  sig  fork exec sh
                             call  I/O stat clos TCP  inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- -------- ---- ---- ---- ---- ----
larsa     Linux 2.6.25-  897 0.23 0.52 3.73 6.26 12.3 0.65 5.08 330. 1406 8997
larsa     Linux 2.6.25-  897 0.23 0.52 3.72 6.26 12.3 0.65 4.94 330. 1401 8959
larsa     Linux 2.6.25-  897 0.23 0.52 3.74 6.27 12.3 0.66 5.01 330. 1409 8983

larsa     Linux 2.6.25-  897 0.23 0.52 3.65 5.82 12.3 0.66 4.88 329. 1335 8355
larsa     Linux 2.6.25-  897 0.23 0.52 3.67 5.83 12.3 0.65 4.98 329. 1327 8376
larsa     Linux 2.6.25-  897 0.23 0.52 3.66 5.85 12.3 0.65 4.81 330. 1334 8405


Index: linux.git/arch/mips/mm/pg-r4k.c
===================================================================
--- linux.git.orig/arch/mips/mm/pg-r4k.c	2008-02-14 17:03:48.000000000 +0000
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,534 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2003, 04, 05 Ralf Baechle (ralf@linux-mips.org)
- * Copyright (C) 2007  Maciej W. Rozycki
- */
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/mm.h>
-#include <linux/module.h>
-#include <linux/proc_fs.h>
-
-#include <asm/bugs.h>
-#include <asm/cacheops.h>
-#include <asm/inst.h>
-#include <asm/io.h>
-#include <asm/page.h>
-#include <asm/pgtable.h>
-#include <asm/prefetch.h>
-#include <asm/system.h>
-#include <asm/bootinfo.h>
-#include <asm/mipsregs.h>
-#include <asm/mmu_context.h>
-#include <asm/cpu.h>
-#include <asm/war.h>
-
-#define half_scache_line_size()	(cpu_scache_line_size() >> 1)
-#define cpu_is_r4600_v1_x()	((read_c0_prid() & 0xfffffff0) == 0x00002010)
-#define cpu_is_r4600_v2_x()	((read_c0_prid() & 0xfffffff0) == 0x00002020)
-
-
-/*
- * Maximum sizes:
- *
- * R4000 128 bytes S-cache:		0x58 bytes
- * R4600 v1.7:				0x5c bytes
- * R4600 v2.0:				0x60 bytes
- * With prefetching, 16 byte strides	0xa0 bytes
- */
-
-static unsigned int clear_page_array[0x130 / 4];
-
-void clear_page(void * page) __attribute__((alias("clear_page_array")));
-
-EXPORT_SYMBOL(clear_page);
-
-/*
- * Maximum sizes:
- *
- * R4000 128 bytes S-cache:		0x11c bytes
- * R4600 v1.7:				0x080 bytes
- * R4600 v2.0:				0x07c bytes
- * With prefetching, 16 byte strides	0x0b8 bytes
- */
-static unsigned int copy_page_array[0x148 / 4];
-
-void copy_page(void *to, void *from) __attribute__((alias("copy_page_array")));
-
-EXPORT_SYMBOL(copy_page);
-
-/*
- * This is suboptimal for 32-bit kernels; we assume that R10000 is only used
- * with 64-bit kernels.  The prefetch offsets have been experimentally tuned
- * an Origin 200.
- */
-static int pref_offset_clear __initdata = 512;
-static int pref_offset_copy  __initdata = 256;
-
-static unsigned int pref_src_mode __initdata;
-static unsigned int pref_dst_mode __initdata;
-
-static int load_offset __initdata;
-static int store_offset __initdata;
-
-static unsigned int __initdata *dest, *epc;
-
-static unsigned int instruction_pending;
-static union mips_instruction delayed_mi;
-
-static void __init emit_instruction(union mips_instruction mi)
-{
-	if (instruction_pending)
-		*epc++ = delayed_mi.word;
-
-	instruction_pending = 1;
-	delayed_mi = mi;
-}
-
-static inline void flush_delay_slot_or_nop(void)
-{
-	if (instruction_pending) {
-		*epc++ = delayed_mi.word;
-		instruction_pending = 0;
-		return;
-	}
-
-	*epc++ = 0;
-}
-
-static inline unsigned int *label(void)
-{
-	if (instruction_pending) {
-		*epc++ = delayed_mi.word;
-		instruction_pending = 0;
-	}
-
-	return epc;
-}
-
-static inline void build_insn_word(unsigned int word)
-{
-	union mips_instruction mi;
-
-	mi.word		 = word;
-
-	emit_instruction(mi);
-}
-
-static inline void build_nop(void)
-{
-	build_insn_word(0);			/* nop */
-}
-
-static inline void build_src_pref(int advance)
-{
-	if (!(load_offset & (cpu_dcache_line_size() - 1)) && advance) {
-		union mips_instruction mi;
-
-		mi.i_format.opcode     = pref_op;
-		mi.i_format.rs         = 5;		/* $a1 */
-		mi.i_format.rt         = pref_src_mode;
-		mi.i_format.simmediate = load_offset + advance;
-
-		emit_instruction(mi);
-	}
-}
-
-static inline void __build_load_reg(int reg)
-{
-	union mips_instruction mi;
-	unsigned int width;
-
-	if (cpu_has_64bit_gp_regs) {
-		mi.i_format.opcode     = ld_op;
-		width = 8;
-	} else {
-		mi.i_format.opcode     = lw_op;
-		width = 4;
-	}
-	mi.i_format.rs         = 5;		/* $a1 */
-	mi.i_format.rt         = reg;		/* $reg */
-	mi.i_format.simmediate = load_offset;
-
-	load_offset += width;
-	emit_instruction(mi);
-}
-
-static inline void build_load_reg(int reg)
-{
-	if (cpu_has_prefetch)
-		build_src_pref(pref_offset_copy);
-
-	__build_load_reg(reg);
-}
-
-static inline void build_dst_pref(int advance)
-{
-	if (!(store_offset & (cpu_dcache_line_size() - 1)) && advance) {
-		union mips_instruction mi;
-
-		mi.i_format.opcode     = pref_op;
-		mi.i_format.rs         = 4;		/* $a0 */
-		mi.i_format.rt         = pref_dst_mode;
-		mi.i_format.simmediate = store_offset + advance;
-
-		emit_instruction(mi);
-	}
-}
-
-static inline void build_cdex_s(void)
-{
-	union mips_instruction mi;
-
-	if ((store_offset & (cpu_scache_line_size() - 1)))
-		return;
-
-	mi.c_format.opcode     = cache_op;
-	mi.c_format.rs         = 4;		/* $a0 */
-	mi.c_format.c_op       = 3;		/* Create Dirty Exclusive */
-	mi.c_format.cache      = 3;		/* Secondary Data Cache */
-	mi.c_format.simmediate = store_offset;
-
-	emit_instruction(mi);
-}
-
-static inline void build_cdex_p(void)
-{
-	union mips_instruction mi;
-
-	if (store_offset & (cpu_dcache_line_size() - 1))
-		return;
-
-	if (R4600_V1_HIT_CACHEOP_WAR && cpu_is_r4600_v1_x()) {
-		build_nop();
-		build_nop();
-		build_nop();
-		build_nop();
-	}
-
-	if (R4600_V2_HIT_CACHEOP_WAR && cpu_is_r4600_v2_x())
-		build_insn_word(0x8c200000);	/* lw      $zero, ($at) */
-
-	mi.c_format.opcode     = cache_op;
-	mi.c_format.rs         = 4;		/* $a0 */
-	mi.c_format.c_op       = 3;		/* Create Dirty Exclusive */
-	mi.c_format.cache      = 1;		/* Data Cache */
-	mi.c_format.simmediate = store_offset;
-
-	emit_instruction(mi);
-}
-
-static void __init __build_store_reg(int reg)
-{
-	union mips_instruction mi;
-	unsigned int width;
-
-	if (cpu_has_64bit_gp_regs ||
-	    (cpu_has_64bit_zero_reg && reg == 0)) {
-		mi.i_format.opcode     = sd_op;
-		width = 8;
-	} else {
-		mi.i_format.opcode     = sw_op;
-		width = 4;
-	}
-	mi.i_format.rs         = 4;		/* $a0 */
-	mi.i_format.rt         = reg;		/* $reg */
-	mi.i_format.simmediate = store_offset;
-
-	store_offset += width;
-	emit_instruction(mi);
-}
-
-static inline void build_store_reg(int reg)
-{
-	int pref_off = cpu_has_prefetch ?
-		(reg ? pref_offset_copy : pref_offset_clear) : 0;
-	if (pref_off)
-		build_dst_pref(pref_off);
-	else if (cpu_has_cache_cdex_s)
-		build_cdex_s();
-	else if (cpu_has_cache_cdex_p)
-		build_cdex_p();
-
-	__build_store_reg(reg);
-}
-
-static inline void build_addiu_rt_rs(unsigned int rt, unsigned int rs,
-				     unsigned long offset)
-{
-	union mips_instruction mi;
-
-	BUG_ON(offset > 0x7fff);
-
-	if (cpu_has_64bit_gp_regs && DADDI_WAR && r4k_daddiu_bug()) {
-		mi.i_format.opcode     = addiu_op;
-		mi.i_format.rs         = 0;	/* $zero */
-		mi.i_format.rt         = 25;	/* $t9 */
-		mi.i_format.simmediate = offset;
-		emit_instruction(mi);
-
-		mi.r_format.opcode     = spec_op;
-		mi.r_format.rs         = rs;
-		mi.r_format.rt         = 25;	/* $t9 */
-		mi.r_format.rd         = rt;
-		mi.r_format.re         = 0;
-		mi.r_format.func       = daddu_op;
-	} else {
-		mi.i_format.opcode     = cpu_has_64bit_gp_regs ?
-					 daddiu_op : addiu_op;
-		mi.i_format.rs         = rs;
-		mi.i_format.rt         = rt;
-		mi.i_format.simmediate = offset;
-	}
-	emit_instruction(mi);
-}
-
-static inline void build_addiu_a2_a0(unsigned long offset)
-{
-	build_addiu_rt_rs(6, 4, offset);	/* $a2, $a0, offset */
-}
-
-static inline void build_addiu_a2(unsigned long offset)
-{
-	build_addiu_rt_rs(6, 6, offset);	/* $a2, $a2, offset */
-}
-
-static inline void build_addiu_a1(unsigned long offset)
-{
-	build_addiu_rt_rs(5, 5, offset);	/* $a1, $a1, offset */
-
-	load_offset -= offset;
-}
-
-static inline void build_addiu_a0(unsigned long offset)
-{
-	build_addiu_rt_rs(4, 4, offset);	/* $a0, $a0, offset */
-
-	store_offset -= offset;
-}
-
-static inline void build_bne(unsigned int *dest)
-{
-	union mips_instruction mi;
-
-	mi.i_format.opcode = bne_op;
-	mi.i_format.rs     = 6;			/* $a2 */
-	mi.i_format.rt     = 4;			/* $a0 */
-	mi.i_format.simmediate = dest - epc - 1;
-
-	*epc++ = mi.word;
-	flush_delay_slot_or_nop();
-}
-
-static inline void build_jr_ra(void)
-{
-	union mips_instruction mi;
-
-	mi.r_format.opcode = spec_op;
-	mi.r_format.rs     = 31;
-	mi.r_format.rt     = 0;
-	mi.r_format.rd     = 0;
-	mi.r_format.re     = 0;
-	mi.r_format.func   = jr_op;
-
-	*epc++ = mi.word;
-	flush_delay_slot_or_nop();
-}
-
-void __init build_clear_page(void)
-{
-	unsigned int loop_start;
-	unsigned long off;
-	int i;
-
-	epc = (unsigned int *) &clear_page_array;
-	instruction_pending = 0;
-	store_offset = 0;
-
-	if (cpu_has_prefetch) {
-		switch (current_cpu_type()) {
-		case CPU_TX49XX:
-			/* TX49 supports only Pref_Load */
-			pref_offset_clear = 0;
-			pref_offset_copy = 0;
-			break;
-
-		case CPU_RM9000:
-			/*
-			 * As a workaround for erratum G105 which make the
-			 * PrepareForStore hint unusable we fall back to
-			 * StoreRetained on the RM9000.  Once it is known which
-			 * versions of the RM9000 we'll be able to condition-
-			 * alize this.
-			 */
-
-		case CPU_R10000:
-		case CPU_R12000:
-		case CPU_R14000:
-			pref_src_mode = Pref_LoadStreamed;
-			pref_dst_mode = Pref_StoreStreamed;
-			break;
-
-		default:
-			pref_src_mode = Pref_LoadStreamed;
-			pref_dst_mode = Pref_PrepareForStore;
-			break;
-		}
-	}
-
-        off = PAGE_SIZE - (cpu_has_prefetch ? pref_offset_clear : 0);
-	if (off > 0x7fff) {
-		build_addiu_a2_a0(off >> 1);
-		build_addiu_a2(off >> 1);
-	} else
-		build_addiu_a2_a0(off);
-
-	if (R4600_V2_HIT_CACHEOP_WAR && cpu_is_r4600_v2_x())
-		build_insn_word(0x3c01a000);	/* lui     $at, 0xa000  */
-
-dest = label();
-	do {
-		build_store_reg(0);
-		build_store_reg(0);
-		build_store_reg(0);
-		build_store_reg(0);
-	} while (store_offset < half_scache_line_size());
-	build_addiu_a0(2 * store_offset);
-	loop_start = store_offset;
-	do {
-		build_store_reg(0);
-		build_store_reg(0);
-		build_store_reg(0);
-		build_store_reg(0);
-	} while ((store_offset - loop_start) < half_scache_line_size());
-	build_bne(dest);
-
-	if (cpu_has_prefetch && pref_offset_clear) {
-		build_addiu_a2_a0(pref_offset_clear);
-	dest = label();
-		loop_start = store_offset;
-		do {
-			__build_store_reg(0);
-			__build_store_reg(0);
-			__build_store_reg(0);
-			__build_store_reg(0);
-		} while ((store_offset - loop_start) < half_scache_line_size());
-		build_addiu_a0(2 * store_offset);
-		loop_start = store_offset;
-		do {
-			__build_store_reg(0);
-			__build_store_reg(0);
-			__build_store_reg(0);
-			__build_store_reg(0);
-		} while ((store_offset - loop_start) < half_scache_line_size());
-		build_bne(dest);
-	}
-
-	build_jr_ra();
-
-	BUG_ON(epc > clear_page_array + ARRAY_SIZE(clear_page_array));
-
-	pr_info("Synthesized clear page handler (%u instructions).\n",
-		(unsigned int)(epc - clear_page_array));
-
-	pr_debug("\t.set push\n");
-	pr_debug("\t.set noreorder\n");
-	for (i = 0; i < (epc - clear_page_array); i++)
-		pr_debug("\t.word 0x%08x\n", clear_page_array[i]);
-	pr_debug("\t.set pop\n");
-}
-
-void __init build_copy_page(void)
-{
-	unsigned int loop_start;
-	unsigned long off;
-	int i;
-
-	epc = (unsigned int *) &copy_page_array;
-	store_offset = load_offset = 0;
-	instruction_pending = 0;
-
-	off = PAGE_SIZE - (cpu_has_prefetch ? pref_offset_copy : 0);
-	if (off > 0x7fff) {
-		build_addiu_a2_a0(off >> 1);
-		build_addiu_a2(off >> 1);
-	} else
-		build_addiu_a2_a0(off);
-
-	if (R4600_V2_HIT_CACHEOP_WAR && cpu_is_r4600_v2_x())
-		build_insn_word(0x3c01a000);	/* lui     $at, 0xa000  */
-
-dest = label();
-	loop_start = store_offset;
-	do {
-		build_load_reg( 8);
-		build_load_reg( 9);
-		build_load_reg(10);
-		build_load_reg(11);
-		build_store_reg( 8);
-		build_store_reg( 9);
-		build_store_reg(10);
-		build_store_reg(11);
-	} while ((store_offset - loop_start) < half_scache_line_size());
-	build_addiu_a0(2 * store_offset);
-	build_addiu_a1(2 * load_offset);
-	loop_start = store_offset;
-	do {
-		build_load_reg( 8);
-		build_load_reg( 9);
-		build_load_reg(10);
-		build_load_reg(11);
-		build_store_reg( 8);
-		build_store_reg( 9);
-		build_store_reg(10);
-		build_store_reg(11);
-	} while ((store_offset - loop_start) < half_scache_line_size());
-	build_bne(dest);
-
-	if (cpu_has_prefetch && pref_offset_copy) {
-		build_addiu_a2_a0(pref_offset_copy);
-	dest = label();
-		loop_start = store_offset;
-		do {
-			__build_load_reg( 8);
-			__build_load_reg( 9);
-			__build_load_reg(10);
-			__build_load_reg(11);
-			__build_store_reg( 8);
-			__build_store_reg( 9);
-			__build_store_reg(10);
-			__build_store_reg(11);
-		} while ((store_offset - loop_start) < half_scache_line_size());
-		build_addiu_a0(2 * store_offset);
-		build_addiu_a1(2 * load_offset);
-		loop_start = store_offset;
-		do {
-			__build_load_reg( 8);
-			__build_load_reg( 9);
-			__build_load_reg(10);
-			__build_load_reg(11);
-			__build_store_reg( 8);
-			__build_store_reg( 9);
-			__build_store_reg(10);
-			__build_store_reg(11);
-		} while ((store_offset - loop_start) < half_scache_line_size());
-		build_bne(dest);
-	}
-
-	build_jr_ra();
-
-	BUG_ON(epc > copy_page_array + ARRAY_SIZE(copy_page_array));
-
-	pr_info("Synthesized copy page handler (%u instructions).\n",
-		(unsigned int)(epc - copy_page_array));
-
-	pr_debug("\t.set push\n");
-	pr_debug("\t.set noreorder\n");
-	for (i = 0; i < (epc - copy_page_array); i++)
-		pr_debug("\t.word 0x%08x\n", copy_page_array[i]);
-	pr_debug("\t.set pop\n");
-}
Index: linux.git/arch/mips/mm/uasm.c
===================================================================
--- linux.git.orig/arch/mips/mm/uasm.c	2008-02-14 17:03:48.000000000 +0000
+++ linux.git/arch/mips/mm/uasm.c	2008-02-14 20:02:28.000000000 +0000
@@ -58,13 +58,13 @@
 	insn_invalid,
 	insn_addu, insn_addiu, insn_and, insn_andi, insn_beq,
 	insn_beql, insn_bgez, insn_bgezl, insn_bltz, insn_bltzl,
-	insn_bne, insn_daddu, insn_daddiu, insn_dmfc0, insn_dmtc0,
-	insn_dsll, insn_dsll32, insn_dsra, insn_dsrl, insn_dsrl32,
-	insn_dsubu, insn_eret, insn_j, insn_jal, insn_jr, insn_ld,
-	insn_ll, insn_lld, insn_lui, insn_lw, insn_mfc0, insn_mtc0,
-	insn_ori, insn_rfe, insn_sc, insn_scd, insn_sd, insn_sll,
-	insn_sra, insn_srl, insn_subu, insn_sw, insn_tlbp, insn_tlbwi,
-	insn_tlbwr, insn_xor, insn_xori
+	insn_bne, insn_cache, insn_daddu, insn_daddiu, insn_dmfc0,
+	insn_dmtc0, insn_dsll, insn_dsll32, insn_dsra, insn_dsrl,
+	insn_dsrl32, insn_dsubu, insn_eret, insn_j, insn_jal, insn_jr,
+	insn_ld, insn_ll, insn_lld, insn_lui, insn_lw, insn_mfc0,
+	insn_mtc0, insn_ori, insn_pref, insn_rfe, insn_sc, insn_scd,
+	insn_sd, insn_sll, insn_sra, insn_srl, insn_subu, insn_sw,
+	insn_tlbp, insn_tlbwi, insn_tlbwr, insn_xor, insn_xori
 };
 
 struct insn {
@@ -94,6 +94,7 @@
 	{ insn_bltz, M(bcond_op, 0, bltz_op, 0, 0, 0), RS | BIMM },
 	{ insn_bltzl, M(bcond_op, 0, bltzl_op, 0, 0, 0), RS | BIMM },
 	{ insn_bne, M(bne_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
+	{ insn_cache,  M(cache_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
 	{ insn_daddiu, M(daddiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM },
 	{ insn_daddu, M(spec_op, 0, 0, 0, 0, daddu_op), RS | RT | RD },
 	{ insn_dmfc0, M(cop0_op, dmfc_op, 0, 0, 0, 0), RT | RD | SET},
@@ -116,6 +117,7 @@
 	{ insn_mfc0,  M(cop0_op, mfc_op, 0, 0, 0, 0),  RT | RD | SET},
 	{ insn_mtc0,  M(cop0_op, mtc_op, 0, 0, 0, 0),  RT | RD | SET},
 	{ insn_ori,  M(ori_op, 0, 0, 0, 0, 0),  RS | RT | UIMM },
+	{ insn_pref,  M(pref_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
 	{ insn_rfe,  M(cop0_op, cop_op, 0, 0, 0, rfe_op),  0 },
 	{ insn_sc,  M(sc_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
 	{ insn_scd,  M(scd_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
@@ -337,6 +339,7 @@
 I_u1s2(_bltz)
 I_u1s2(_bltzl)
 I_u1u2s3(_bne)
+I_u2s3u1(_cache)
 I_u1u2u3(_dmfc0)
 I_u1u2u3(_dmtc0)
 I_u2u1s3(_daddiu)
@@ -359,6 +362,7 @@
 I_u1u2u3(_mfc0)
 I_u1u2u3(_mtc0)
 I_u2u1u3(_ori)
+I_u2s3u1(_pref)
 I_0(_rfe)
 I_u2s3u1(_sc)
 I_u2s3u1(_scd)
@@ -555,6 +559,14 @@
 }
 
 void __init
+uasm_il_bne(u32 **p, struct uasm_reloc **r, unsigned int reg1,
+	    unsigned int reg2, int lid)
+{
+	uasm_r_mips_pc16(r, *p, lid);
+	uasm_i_bne(p, reg1, reg2, 0);
+}
+
+void __init
 uasm_il_bnez(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid)
 {
 	uasm_r_mips_pc16(r, *p, lid);
Index: linux.git/arch/mips/mm/uasm.h
===================================================================
--- linux.git.orig/arch/mips/mm/uasm.h	2008-02-14 17:03:48.000000000 +0000
+++ linux.git/arch/mips/mm/uasm.h	2008-02-14 20:02:28.000000000 +0000
@@ -55,6 +55,7 @@
 Ip_u1s2(_bltz);
 Ip_u1s2(_bltzl);
 Ip_u1u2s3(_bne);
+Ip_u2s3u1(_cache);
 Ip_u1u2u3(_dmfc0);
 Ip_u1u2u3(_dmtc0);
 Ip_u2u1s3(_daddiu);
@@ -77,6 +78,7 @@
 Ip_u1u2u3(_mfc0);
 Ip_u1u2u3(_mtc0);
 Ip_u2u1u3(_ori);
+Ip_u2s3u1(_pref);
 Ip_0(_rfe);
 Ip_u2s3u1(_sc);
 Ip_u2s3u1(_scd);
@@ -185,6 +187,9 @@
 void __init
 uasm_il_beqzl(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid);
 void __init
+uasm_il_bne(u32 **p, struct uasm_reloc **r, unsigned int reg1,
+	    unsigned int reg2, int lid);
+void __init
 uasm_il_bnez(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid);
 void __init
 uasm_il_bgezl(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid);
Index: linux.git/arch/mips/mm/pg-sb1.c
===================================================================
--- linux.git.orig/arch/mips/mm/pg-sb1.c	2008-02-14 20:02:19.000000000 +0000
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,302 +0,0 @@
-/*
- * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
- * Copyright (C) 1997, 2001 Ralf Baechle (ralf@gnu.org)
- * Copyright (C) 2000 SiByte, Inc.
- * Copyright (C) 2005 Thiemo Seufer
- *
- * Written by Justin Carlson of SiByte, Inc.
- *         and Kip Walker of Broadcom Corp.
- *
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
- */
-#include <linux/module.h>
-#include <linux/sched.h>
-#include <linux/smp.h>
-
-#include <asm/io.h>
-#include <asm/sibyte/sb1250.h>
-#include <asm/sibyte/sb1250_regs.h>
-#include <asm/sibyte/sb1250_dma.h>
-
-#ifdef CONFIG_SB1_PASS_1_WORKAROUNDS
-#define SB1_PREF_LOAD_STREAMED_HINT "0"
-#define SB1_PREF_STORE_STREAMED_HINT "1"
-#else
-#define SB1_PREF_LOAD_STREAMED_HINT "4"
-#define SB1_PREF_STORE_STREAMED_HINT "5"
-#endif
-
-static inline void clear_page_cpu(void *page)
-{
-	unsigned char *addr = (unsigned char *) page;
-	unsigned char *end = addr + PAGE_SIZE;
-
-	/*
-	 * JDCXXX - This should be bottlenecked by the write buffer, but these
-	 * things tend to be mildly unpredictable...should check this on the
-	 * performance model
-	 *
-	 * We prefetch 4 lines ahead.  We're also "cheating" slightly here...
-	 * since we know we're on an SB1, we force the assembler to take
-	 * 64-bit operands to speed things up
-	 */
-	__asm__ __volatile__(
-	"	.set	push		\n"
-	"	.set	mips4		\n"
-	"	.set	noreorder	\n"
-#ifdef CONFIG_CPU_HAS_PREFETCH
-	"	daddiu	%0, %0, 128	\n"
-	"	pref	" SB1_PREF_STORE_STREAMED_HINT ", -128(%0)  \n"
-					     /* Prefetch the first 4 lines */
-	"	pref	" SB1_PREF_STORE_STREAMED_HINT ",  -96(%0)  \n"
-	"	pref	" SB1_PREF_STORE_STREAMED_HINT ",  -64(%0)  \n"
-	"	pref	" SB1_PREF_STORE_STREAMED_HINT ",  -32(%0)  \n"
-	"1:	sd	$0, -128(%0)	\n"  /* Throw out a cacheline of 0's */
-	"	sd	$0, -120(%0)	\n"
-	"	sd	$0, -112(%0)	\n"
-	"	sd	$0, -104(%0)	\n"
-	"	daddiu	%0, %0, 32	\n"
-	"	bnel	%0, %1, 1b	\n"
-	"	 pref	" SB1_PREF_STORE_STREAMED_HINT ",  -32(%0)  \n"
-	"	daddiu	%0, %0, -128	\n"
-#endif
-	"	sd	$0, 0(%0)	\n"  /* Throw out a cacheline of 0's */
-	"1:	sd	$0, 8(%0)	\n"
-	"	sd	$0, 16(%0)	\n"
-	"	sd	$0, 24(%0)	\n"
-	"	daddiu	%0, %0, 32	\n"
-	"	bnel	%0, %1, 1b	\n"
-	"	 sd	$0, 0(%0)	\n"
-	"	.set	pop		\n"
-	: "+r" (addr)
-	: "r" (end)
-	: "memory");
-}
-
-static inline void copy_page_cpu(void *to, void *from)
-{
-	unsigned char *src = (unsigned char *)from;
-	unsigned char *dst = (unsigned char *)to;
-	unsigned char *end = src + PAGE_SIZE;
-
-	/*
-	 * The pref's used here are using "streaming" hints, which cause the
-	 * copied data to be kicked out of the cache sooner.  A page copy often
-	 * ends up copying a lot more data than is commonly used, so this seems
-	 * to make sense in terms of reducing cache pollution, but I've no real
-	 * performance data to back this up
-	 */
-	__asm__ __volatile__(
-	"	.set	push		\n"
-	"	.set	mips4		\n"
-	"	.set	noreorder	\n"
-#ifdef CONFIG_CPU_HAS_PREFETCH
-	"	daddiu	%0, %0, 128	\n"
-	"	daddiu	%1, %1, 128	\n"
-	"	pref	" SB1_PREF_LOAD_STREAMED_HINT  ", -128(%0)\n"
-					     /* Prefetch the first 4 lines */
-	"	pref	" SB1_PREF_STORE_STREAMED_HINT ", -128(%1)\n"
-	"	pref	" SB1_PREF_LOAD_STREAMED_HINT  ",  -96(%0)\n"
-	"	pref	" SB1_PREF_STORE_STREAMED_HINT ",  -96(%1)\n"
-	"	pref	" SB1_PREF_LOAD_STREAMED_HINT  ",  -64(%0)\n"
-	"	pref	" SB1_PREF_STORE_STREAMED_HINT ",  -64(%1)\n"
-	"	pref	" SB1_PREF_LOAD_STREAMED_HINT  ",  -32(%0)\n"
-	"1:	pref	" SB1_PREF_STORE_STREAMED_HINT ",  -32(%1)\n"
-# ifdef CONFIG_64BIT
-	"	ld	$8, -128(%0)	\n"  /* Block copy a cacheline */
-	"	ld	$9, -120(%0)	\n"
-	"	ld	$10, -112(%0)	\n"
-	"	ld	$11, -104(%0)	\n"
-	"	sd	$8, -128(%1)	\n"
-	"	sd	$9, -120(%1)	\n"
-	"	sd	$10, -112(%1)	\n"
-	"	sd	$11, -104(%1)	\n"
-# else
-	"	lw	$2, -128(%0)	\n"  /* Block copy a cacheline */
-	"	lw	$3, -124(%0)	\n"
-	"	lw	$6, -120(%0)	\n"
-	"	lw	$7, -116(%0)	\n"
-	"	lw	$8, -112(%0)	\n"
-	"	lw	$9, -108(%0)	\n"
-	"	lw	$10, -104(%0)	\n"
-	"	lw	$11, -100(%0)	\n"
-	"	sw	$2, -128(%1)	\n"
-	"	sw	$3, -124(%1)	\n"
-	"	sw	$6, -120(%1)	\n"
-	"	sw	$7, -116(%1)	\n"
-	"	sw	$8, -112(%1)	\n"
-	"	sw	$9, -108(%1)	\n"
-	"	sw	$10, -104(%1)	\n"
-	"	sw	$11, -100(%1)	\n"
-# endif
-	"	daddiu	%0, %0, 32	\n"
-	"	daddiu	%1, %1, 32	\n"
-	"	bnel	%0, %2, 1b	\n"
-	"	 pref	" SB1_PREF_LOAD_STREAMED_HINT  ",  -32(%0)\n"
-	"	daddiu	%0, %0, -128	\n"
-	"	daddiu	%1, %1, -128	\n"
-#endif
-#ifdef CONFIG_64BIT
-	"	ld	$8, 0(%0)	\n"  /* Block copy a cacheline */
-	"1:	ld	$9, 8(%0)	\n"
-	"	ld	$10, 16(%0)	\n"
-	"	ld	$11, 24(%0)	\n"
-	"	sd	$8, 0(%1)	\n"
-	"	sd	$9, 8(%1)	\n"
-	"	sd	$10, 16(%1)	\n"
-	"	sd	$11, 24(%1)	\n"
-#else
-	"	lw	$2, 0(%0)	\n"  /* Block copy a cacheline */
-	"1:	lw	$3, 4(%0)	\n"
-	"	lw	$6, 8(%0)	\n"
-	"	lw	$7, 12(%0)	\n"
-	"	lw	$8, 16(%0)	\n"
-	"	lw	$9, 20(%0)	\n"
-	"	lw	$10, 24(%0)	\n"
-	"	lw	$11, 28(%0)	\n"
-	"	sw	$2, 0(%1)	\n"
-	"	sw	$3, 4(%1)	\n"
-	"	sw	$6, 8(%1)	\n"
-	"	sw	$7, 12(%1)	\n"
-	"	sw	$8, 16(%1)	\n"
-	"	sw	$9, 20(%1)	\n"
-	"	sw	$10, 24(%1)	\n"
-	"	sw	$11, 28(%1)	\n"
-#endif
-	"	daddiu	%0, %0, 32	\n"
-	"	daddiu	%1, %1, 32	\n"
-	"	bnel	%0, %2, 1b	\n"
-#ifdef CONFIG_64BIT
-	"	 ld	$8, 0(%0)	\n"
-#else
-	"	 lw	$2, 0(%0)	\n"
-#endif
-	"	.set	pop		\n"
-	: "+r" (src), "+r" (dst)
-	: "r" (end)
-#ifdef CONFIG_64BIT
-	: "$8", "$9", "$10", "$11", "memory");
-#else
-	: "$2", "$3", "$6", "$7", "$8", "$9", "$10", "$11", "memory");
-#endif
-}
-
-
-#ifdef CONFIG_SIBYTE_DMA_PAGEOPS
-
-/*
- * Pad descriptors to cacheline, since each is exclusively owned by a
- * particular CPU.
- */
-typedef struct dmadscr_s {
-	u64 dscr_a;
-	u64 dscr_b;
-	u64 pad_a;
-	u64 pad_b;
-} dmadscr_t;
-
-static dmadscr_t page_descr[DM_NUM_CHANNELS]
-	__attribute__((aligned(SMP_CACHE_BYTES)));
-
-void sb1_dma_init(void)
-{
-	int i;
-
-	for (i = 0; i < DM_NUM_CHANNELS; i++) {
-		const u64 base_val = CPHYSADDR((unsigned long)&page_descr[i]) |
-				     V_DM_DSCR_BASE_RINGSZ(1);
-		void *base_reg = IOADDR(A_DM_REGISTER(i, R_DM_DSCR_BASE));
-
-		__raw_writeq(base_val, base_reg);
-		__raw_writeq(base_val | M_DM_DSCR_BASE_RESET, base_reg);
-		__raw_writeq(base_val | M_DM_DSCR_BASE_ENABL, base_reg);
-	}
-}
-
-void clear_page(void *page)
-{
-	u64 to_phys = CPHYSADDR((unsigned long)page);
-	unsigned int cpu = smp_processor_id();
-
-	/* if the page is not in KSEG0, use old way */
-	if ((long)KSEGX((unsigned long)page) != (long)CKSEG0)
-		return clear_page_cpu(page);
-
-	page_descr[cpu].dscr_a = to_phys | M_DM_DSCRA_ZERO_MEM |
-				 M_DM_DSCRA_L2C_DEST | M_DM_DSCRA_INTERRUPT;
-	page_descr[cpu].dscr_b = V_DM_DSCRB_SRC_LENGTH(PAGE_SIZE);
-	__raw_writeq(1, IOADDR(A_DM_REGISTER(cpu, R_DM_DSCR_COUNT)));
-
-	/*
-	 * Don't really want to do it this way, but there's no
-	 * reliable way to delay completion detection.
-	 */
-	while (!(__raw_readq(IOADDR(A_DM_REGISTER(cpu, R_DM_DSCR_BASE_DEBUG)))
-		 & M_DM_DSCR_BASE_INTERRUPT))
-		;
-	__raw_readq(IOADDR(A_DM_REGISTER(cpu, R_DM_DSCR_BASE)));
-}
-
-void copy_page(void *to, void *from)
-{
-	u64 from_phys = CPHYSADDR((unsigned long)from);
-	u64 to_phys = CPHYSADDR((unsigned long)to);
-	unsigned int cpu = smp_processor_id();
-
-	/* if any page is not in KSEG0, use old way */
-	if ((long)KSEGX((unsigned long)to) != (long)CKSEG0
-	    || (long)KSEGX((unsigned long)from) != (long)CKSEG0)
-		return copy_page_cpu(to, from);
-
-	page_descr[cpu].dscr_a = to_phys | M_DM_DSCRA_L2C_DEST |
-				 M_DM_DSCRA_INTERRUPT;
-	page_descr[cpu].dscr_b = from_phys | V_DM_DSCRB_SRC_LENGTH(PAGE_SIZE);
-	__raw_writeq(1, IOADDR(A_DM_REGISTER(cpu, R_DM_DSCR_COUNT)));
-
-	/*
-	 * Don't really want to do it this way, but there's no
-	 * reliable way to delay completion detection.
-	 */
-	while (!(__raw_readq(IOADDR(A_DM_REGISTER(cpu, R_DM_DSCR_BASE_DEBUG)))
-		 & M_DM_DSCR_BASE_INTERRUPT))
-		;
-	__raw_readq(IOADDR(A_DM_REGISTER(cpu, R_DM_DSCR_BASE)));
-}
-
-#else /* !CONFIG_SIBYTE_DMA_PAGEOPS */
-
-void clear_page(void *page)
-{
-	return clear_page_cpu(page);
-}
-
-void copy_page(void *to, void *from)
-{
-	return copy_page_cpu(to, from);
-}
-
-#endif /* !CONFIG_SIBYTE_DMA_PAGEOPS */
-
-EXPORT_SYMBOL(clear_page);
-EXPORT_SYMBOL(copy_page);
-
-void __init build_clear_page(void)
-{
-}
-
-void __init build_copy_page(void)
-{
-}
Index: linux.git/arch/mips/mm/Makefile
===================================================================
--- linux.git.orig/arch/mips/mm/Makefile	2008-02-14 17:03:48.000000000 +0000
+++ linux.git/arch/mips/mm/Makefile	2008-02-14 20:04:35.000000000 +0000
@@ -4,30 +4,29 @@
 
 obj-y				+= cache.o dma-default.o extable.o fault.o \
 				   init.o pgtable.o tlbex.o tlbex-fault.o \
-				   uasm.o
+				   uasm.o page.o
 
 obj-$(CONFIG_32BIT)		+= ioremap.o pgtable-32.o
 obj-$(CONFIG_64BIT)		+= pgtable-64.o
 obj-$(CONFIG_HIGHMEM)		+= highmem.o
 
-obj-$(CONFIG_CPU_LOONGSON2)	+= c-r4k.o cex-gen.o pg-r4k.o tlb-r4k.o
-obj-$(CONFIG_CPU_MIPS32)	+= c-r4k.o cex-gen.o pg-r4k.o tlb-r4k.o
-obj-$(CONFIG_CPU_MIPS64)	+= c-r4k.o cex-gen.o pg-r4k.o tlb-r4k.o
-obj-$(CONFIG_CPU_NEVADA)	+= c-r4k.o cex-gen.o pg-r4k.o tlb-r4k.o
-obj-$(CONFIG_CPU_R10000)	+= c-r4k.o cex-gen.o pg-r4k.o tlb-r4k.o
-obj-$(CONFIG_CPU_R3000)		+= c-r3k.o tlb-r3k.o pg-r4k.o
-obj-$(CONFIG_CPU_R4300)		+= c-r4k.o cex-gen.o pg-r4k.o tlb-r4k.o
-obj-$(CONFIG_CPU_R4X00)		+= c-r4k.o cex-gen.o pg-r4k.o tlb-r4k.o
-obj-$(CONFIG_CPU_R5000)		+= c-r4k.o cex-gen.o pg-r4k.o tlb-r4k.o
-obj-$(CONFIG_CPU_R5432)		+= c-r4k.o cex-gen.o pg-r4k.o tlb-r4k.o
-obj-$(CONFIG_CPU_R8000)		+= c-r4k.o cex-gen.o pg-r4k.o tlb-r8k.o
-obj-$(CONFIG_CPU_RM7000)	+= c-r4k.o cex-gen.o pg-r4k.o tlb-r4k.o
-obj-$(CONFIG_CPU_RM9000)	+= c-r4k.o cex-gen.o pg-r4k.o tlb-r4k.o
-obj-$(CONFIG_CPU_SB1)		+= c-r4k.o cerr-sb1.o cex-sb1.o pg-sb1.o \
-				   tlb-r4k.o
-obj-$(CONFIG_CPU_TX39XX)	+= c-tx39.o pg-r4k.o tlb-r3k.o
-obj-$(CONFIG_CPU_TX49XX)	+= c-r4k.o cex-gen.o pg-r4k.o tlb-r4k.o
-obj-$(CONFIG_CPU_VR41XX)	+= c-r4k.o cex-gen.o pg-r4k.o tlb-r4k.o
+obj-$(CONFIG_CPU_LOONGSON2)	+= c-r4k.o cex-gen.o tlb-r4k.o
+obj-$(CONFIG_CPU_MIPS32)	+= c-r4k.o cex-gen.o tlb-r4k.o
+obj-$(CONFIG_CPU_MIPS64)	+= c-r4k.o cex-gen.o tlb-r4k.o
+obj-$(CONFIG_CPU_NEVADA)	+= c-r4k.o cex-gen.o tlb-r4k.o
+obj-$(CONFIG_CPU_R10000)	+= c-r4k.o cex-gen.o tlb-r4k.o
+obj-$(CONFIG_CPU_R3000)		+= c-r3k.o tlb-r3k.o
+obj-$(CONFIG_CPU_R4300)		+= c-r4k.o cex-gen.o tlb-r4k.o
+obj-$(CONFIG_CPU_R4X00)		+= c-r4k.o cex-gen.o tlb-r4k.o
+obj-$(CONFIG_CPU_R5000)		+= c-r4k.o cex-gen.o tlb-r4k.o
+obj-$(CONFIG_CPU_R5432)		+= c-r4k.o cex-gen.o tlb-r4k.o
+obj-$(CONFIG_CPU_R8000)		+= c-r4k.o cex-gen.o tlb-r8k.o
+obj-$(CONFIG_CPU_RM7000)	+= c-r4k.o cex-gen.o tlb-r4k.o
+obj-$(CONFIG_CPU_RM9000)	+= c-r4k.o cex-gen.o tlb-r4k.o
+obj-$(CONFIG_CPU_SB1)		+= c-r4k.o cerr-sb1.o cex-sb1.o tlb-r4k.o
+obj-$(CONFIG_CPU_TX39XX)	+= c-tx39.o tlb-r3k.o
+obj-$(CONFIG_CPU_TX49XX)	+= c-r4k.o cex-gen.o tlb-r4k.o
+obj-$(CONFIG_CPU_VR41XX)	+= c-r4k.o cex-gen.o tlb-r4k.o
 
 obj-$(CONFIG_IP22_CPU_SCACHE)	+= sc-ip22.o
 obj-$(CONFIG_R5000_CPU_SCACHE)  += sc-r5k.o
Index: linux.git/arch/mips/mm/page.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux.git/arch/mips/mm/page.c	2008-02-14 20:02:28.000000000 +0000
@@ -0,0 +1,685 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2003, 04, 05 Ralf Baechle (ralf@linux-mips.org)
+ * Copyright (C) 2007  Maciej W. Rozycki
+ * Copyright (C) 2008  Thiemo Seufer
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/proc_fs.h>
+
+#include <asm/bugs.h>
+#include <asm/cacheops.h>
+#include <asm/inst.h>
+#include <asm/io.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/prefetch.h>
+#include <asm/system.h>
+#include <asm/bootinfo.h>
+#include <asm/mipsregs.h>
+#include <asm/mmu_context.h>
+#include <asm/cpu.h>
+#include <asm/war.h>
+
+#ifdef CONFIG_SIBYTE_DMA_PAGEOPS
+#include <asm/sibyte/sb1250.h>
+#include <asm/sibyte/sb1250_regs.h>
+#include <asm/sibyte/sb1250_dma.h>
+#endif
+
+#include "uasm.h"
+
+/* Registers used in the assembled routines. */
+#define ZERO 0
+#define AT 2
+#define A0 4
+#define A1 5
+#define A2 6
+#define T0 8
+#define T1 9
+#define T2 10
+#define T3 11
+#define T9 25
+#define RA 31
+
+/* Handle labels (which must be positive integers). */
+enum label_id {
+	label_clear_nopref = 1,
+	label_clear_pref,
+	label_copy_nopref,
+	label_copy_pref_both,
+	label_copy_pref_store,
+};
+
+UASM_L_LA(_clear_nopref)
+UASM_L_LA(_clear_pref)
+UASM_L_LA(_copy_nopref)
+UASM_L_LA(_copy_pref_both)
+UASM_L_LA(_copy_pref_store)
+
+/* We need one branch and therefore one relocation per target label. */
+static struct uasm_label __initdata labels[5];
+static struct uasm_reloc __initdata relocs[5];
+
+#define cpu_is_r4600_v1_x()	((read_c0_prid() & 0xfffffff0) == 0x00002010)
+#define cpu_is_r4600_v2_x()	((read_c0_prid() & 0xfffffff0) == 0x00002020)
+
+/*
+ * Maximum sizes:
+ *
+ * R4000 128 bytes S-cache:		0x058 bytes
+ * R4600 v1.7:				0x05c bytes
+ * R4600 v2.0:				0x060 bytes
+ * With prefetching, 16 word strides	0x120 bytes
+ */
+
+static u32 clear_page_array[0x120 / 4];
+
+#ifdef CONFIG_SIBYTE_DMA_PAGEOPS
+void clear_page_cpu(void *page) __attribute__((alias("clear_page_array")));
+#else
+void clear_page(void *page) __attribute__((alias("clear_page_array")));
+#endif
+
+EXPORT_SYMBOL(clear_page);
+
+/*
+ * Maximum sizes:
+ *
+ * R4000 128 bytes S-cache:		0x11c bytes
+ * R4600 v1.7:				0x080 bytes
+ * R4600 v2.0:				0x07c bytes
+ * With prefetching, 16 word strides	0x540 bytes
+ */
+static u32 copy_page_array[0x540 / 4];
+
+#ifdef CONFIG_SIBYTE_DMA_PAGEOPS
+void
+copy_page_cpu(void *to, void *from) __attribute__((alias("copy_page_array")));
+#else
+void copy_page(void *to, void *from) __attribute__((alias("copy_page_array")));
+#endif
+
+EXPORT_SYMBOL(copy_page);
+
+
+static int pref_bias_clear_store __initdata;
+static int pref_bias_copy_load __initdata;
+static int pref_bias_copy_store __initdata;
+
+static u32 pref_src_mode __initdata;
+static u32 pref_dst_mode __initdata;
+
+static int clear_word_size __initdata;
+static int copy_word_size __initdata;
+
+static int half_clear_loop_size __initdata;
+static int half_copy_loop_size __initdata;
+
+static int cache_line_size __initdata;
+#define cache_line_mask() (cache_line_size - 1)
+
+static inline void __init
+pg_addiu(u32 **buf, unsigned int reg1, unsigned int reg2, unsigned int off)
+{
+	if (cpu_has_64bit_gp_regs && DADDI_WAR && r4k_daddiu_bug()) {
+		if (off > 0x7fff) {
+			uasm_i_lui(buf, T9, uasm_rel_hi(off));
+			uasm_i_addiu(buf, T9, T9, uasm_rel_lo(off));
+		} else
+			uasm_i_addiu(buf, T9, ZERO, off);
+		uasm_i_daddu(buf, reg1, reg2, T9);
+	} else {
+		if (off > 0x7fff) {
+			uasm_i_lui(buf, T9, uasm_rel_hi(off));
+			uasm_i_addiu(buf, T9, T9, uasm_rel_lo(off));
+			UASM_i_ADDU(buf, reg1, reg2, T9);
+		} else
+			UASM_i_ADDIU(buf, reg1, reg2, off);
+	}
+}
+
+static void __init set_prefetch_parameters(void)
+{
+	if (cpu_has_64bit_gp_regs || cpu_has_64bit_zero_reg)
+		clear_word_size = 8;
+	else
+		clear_word_size = 4;
+
+	if (cpu_has_64bit_gp_regs)
+		copy_word_size = 8;
+	else
+		copy_word_size = 4;
+
+	/*
+	 * The pref's used here are using "streaming" hints, which cause the
+	 * copied data to be kicked out of the cache sooner.  A page copy often
+	 * ends up copying a lot more data than is commonly used, so this seems
+	 * to make sense in terms of reducing cache pollution, but I've no real
+	 * performance data to back this up.
+	 */
+	if (cpu_has_prefetch) {
+		/*
+		 * XXX: Most prefetch bias values in here are based on
+		 * guesswork.
+		 */
+		cache_line_size = cpu_dcache_line_size();
+		switch (current_cpu_type()) {
+		case CPU_TX49XX:
+			/* TX49 supports only Pref_Load */
+			pref_bias_copy_load = 256;
+			break;
+
+		case CPU_RM9000:
+			/*
+			 * As a workaround for erratum G105 which make the
+			 * PrepareForStore hint unusable we fall back to
+			 * StoreRetained on the RM9000.  Once it is known which
+			 * versions of the RM9000 we'll be able to condition-
+			 * alize this.
+			 */
+
+		case CPU_R10000:
+		case CPU_R12000:
+		case CPU_R14000:
+			/*
+			 * Those values have been experimentally tuned for an
+			 * Origin 200.
+			 */
+			pref_bias_clear_store = 512;
+			pref_bias_copy_load = 256;
+			pref_bias_copy_store = 256;
+			pref_src_mode = Pref_LoadStreamed;
+			pref_dst_mode = Pref_StoreStreamed;
+			break;
+
+		case CPU_SB1:
+		case CPU_SB1A:
+			pref_bias_clear_store = 128;
+			pref_bias_copy_load = 128;
+			pref_bias_copy_store = 128;
+			/*
+			 * SB1 pass1 Pref_LoadStreamed/Pref_StoreStreamed
+			 * hints are broken.
+			 */
+			if (current_cpu_type() == CPU_SB1 &&
+			    (current_cpu_data.processor_id & 0xff) < 0x02) {
+				pref_src_mode = Pref_Load;
+				pref_dst_mode = Pref_Store;
+			} else {
+				pref_src_mode = Pref_LoadStreamed;
+				pref_dst_mode = Pref_StoreStreamed;
+			}
+			break;
+
+		default:
+			pref_bias_clear_store = 128;
+			pref_bias_copy_load = 256;
+			pref_bias_copy_store = 128;
+			pref_src_mode = Pref_LoadStreamed;
+			pref_dst_mode = Pref_PrepareForStore;
+			break;
+		}
+	} else {
+		if (cpu_has_cache_cdex_s) {
+			cache_line_size = cpu_scache_line_size();
+		} else if (cpu_has_cache_cdex_p) {
+			cache_line_size = cpu_dcache_line_size();
+		}
+	}
+	/*
+	 * Too much unrolling will overflow the available space in
+	 * clear_space_array / copy_page_array. 8 words sounds generous,
+	 * but a R4000 with 128 byte L2 line length can exceed even that.
+	 */
+	half_clear_loop_size = min(8 * clear_word_size,
+				   max(cache_line_size >> 1,
+				       4 * clear_word_size));
+	half_copy_loop_size = min(8 * copy_word_size,
+				  max(cache_line_size >> 1,
+				      4 * copy_word_size));
+}
+
+static void __init build_clear_store(u32 **buf, int off)
+{
+	if (cpu_has_64bit_gp_regs || cpu_has_64bit_zero_reg) {
+		uasm_i_sd(buf, ZERO, off, A0);
+	} else {
+		uasm_i_sw(buf, ZERO, off, A0);
+	}
+}
+
+static inline void __init build_clear_pref(u32 **buf, int off)
+{
+	if (off & cache_line_mask())
+		return;
+
+	if (pref_bias_clear_store) {
+		uasm_i_pref(buf, pref_dst_mode, pref_bias_clear_store + off,
+			    A0);
+	} else if (cpu_has_cache_cdex_s) {
+		uasm_i_cache(buf, Create_Dirty_Excl_SD, off, A0);
+	} else if (cpu_has_cache_cdex_p) {
+		if (R4600_V1_HIT_CACHEOP_WAR && cpu_is_r4600_v1_x()) {
+			uasm_i_nop(buf);
+			uasm_i_nop(buf);
+			uasm_i_nop(buf);
+			uasm_i_nop(buf);
+		}
+
+		if (R4600_V2_HIT_CACHEOP_WAR && cpu_is_r4600_v2_x())
+			uasm_i_lw(buf, ZERO, ZERO, AT);
+
+		uasm_i_cache(buf, Create_Dirty_Excl_D, off, A0);
+	}
+}
+
+void __init build_clear_page(void)
+{
+	int off;
+	u32 *buf = (u32 *)&clear_page_array;
+	struct uasm_label *l = labels;
+	struct uasm_reloc *r = relocs;
+	int i;
+
+	memset(labels, 0, sizeof(labels));
+	memset(relocs, 0, sizeof(relocs));
+
+	set_prefetch_parameters();
+
+	/*
+	 * This algorithm makes the following assumptions:
+	 *   - The prefetch bias is a multiple of 2 words.
+	 *   - The prefetch bias is less than one page.
+	 */
+	BUG_ON(pref_bias_clear_store % (2 * clear_word_size));
+	BUG_ON(PAGE_SIZE < pref_bias_clear_store);
+
+	off = PAGE_SIZE - pref_bias_clear_store;
+	if (off > 0xffff)
+		pg_addiu(&buf, A2, A0, off);
+	else
+		uasm_i_ori(&buf, A2, A0, off);
+
+	if (R4600_V2_HIT_CACHEOP_WAR && cpu_is_r4600_v2_x())
+		uasm_i_lui(&buf, AT, 0xa000);
+
+	off = min(8, pref_bias_clear_store / cache_line_size) *
+	      cache_line_size;
+	while (off) {
+		build_clear_pref(&buf, -off);
+		off -= cache_line_size;
+	}
+	uasm_l_clear_pref(&l, buf);
+	do {
+		build_clear_pref(&buf, off);
+		build_clear_store(&buf, off);
+		off += clear_word_size;
+	} while (off < half_clear_loop_size);
+	pg_addiu(&buf, A0, A0, 2 * off);
+	off = -off;
+	do {
+		build_clear_pref(&buf, off);
+		if (off == -clear_word_size)
+			uasm_il_bne(&buf, &r, A0, A2, label_clear_pref);
+		build_clear_store(&buf, off);
+		off += clear_word_size;
+	} while (off < 0);
+
+	if (pref_bias_clear_store) {
+		pg_addiu(&buf, A2, A0, pref_bias_clear_store);
+		uasm_l_clear_nopref(&l, buf);
+		off = 0;
+		do {
+			build_clear_store(&buf, off);
+			off += clear_word_size;
+		} while (off < half_clear_loop_size);
+		pg_addiu(&buf, A0, A0, 2 * off);
+		off = -off;
+		do {
+			if (off == -clear_word_size)
+				uasm_il_bne(&buf, &r, A0, A2,
+					    label_clear_nopref);
+			build_clear_store(&buf, off);
+			off += clear_word_size;
+		} while (off < 0);
+	}
+
+	uasm_i_jr(&buf, RA);
+	uasm_i_nop(&buf);
+
+	BUG_ON(buf > clear_page_array + ARRAY_SIZE(clear_page_array));
+
+	uasm_resolve_relocs(relocs, labels);
+
+	pr_debug("Synthesized clear page handler (%u instructions).\n",
+		 (u32)(buf - clear_page_array));
+
+	pr_debug("\t.set push\n");
+	pr_debug("\t.set noreorder\n");
+	for (i = 0; i < (buf - clear_page_array); i++)
+		pr_debug("\t.word 0x%08x\n", clear_page_array[i]);
+	pr_debug("\t.set pop\n");
+}
+
+static void __init build_copy_load(u32 **buf, int reg, int off)
+{
+	if (cpu_has_64bit_gp_regs) {
+		uasm_i_ld(buf, reg, off, A1);
+	} else {
+		uasm_i_lw(buf, reg, off, A1);
+	}
+}
+
+static void __init build_copy_store(u32 **buf, int reg, int off)
+{
+	if (cpu_has_64bit_gp_regs) {
+		uasm_i_sd(buf, reg, off, A0);
+	} else {
+		uasm_i_sw(buf, reg, off, A0);
+	}
+}
+
+static inline void build_copy_load_pref(u32 **buf, int off)
+{
+	if (off & cache_line_mask())
+		return;
+
+	if (pref_bias_copy_load)
+		uasm_i_pref(buf, pref_src_mode, pref_bias_copy_load + off, A1);
+}
+
+static inline void build_copy_store_pref(u32 **buf, int off)
+{
+	if (off & cache_line_mask())
+		return;
+
+	if (pref_bias_copy_store) {
+		uasm_i_pref(buf, pref_dst_mode, pref_bias_copy_store + off,
+			    A0);
+	} else if (cpu_has_cache_cdex_s) {
+		uasm_i_cache(buf, Create_Dirty_Excl_SD, off, A0);
+	} else if (cpu_has_cache_cdex_p) {
+		if (R4600_V1_HIT_CACHEOP_WAR && cpu_is_r4600_v1_x()) {
+			uasm_i_nop(buf);
+			uasm_i_nop(buf);
+			uasm_i_nop(buf);
+			uasm_i_nop(buf);
+		}
+
+		if (R4600_V2_HIT_CACHEOP_WAR && cpu_is_r4600_v2_x())
+			uasm_i_lw(buf, ZERO, ZERO, AT);
+
+		uasm_i_cache(buf, Create_Dirty_Excl_D, off, A0);
+	}
+}
+
+void __init build_copy_page(void)
+{
+	int off;
+	u32 *buf = (u32 *)&copy_page_array;
+	struct uasm_label *l = labels;
+	struct uasm_reloc *r = relocs;
+	int i;
+
+	memset(labels, 0, sizeof(labels));
+	memset(relocs, 0, sizeof(relocs));
+
+	set_prefetch_parameters();
+
+	/*
+	 * This algorithm makes the following assumptions:
+	 *   - All prefetch biases are multiples of 8 words.
+	 *   - The prefetch biases are less than one page.
+	 *   - The store prefetch bias isn't greater than the load
+	 *     prefetch bias.
+	 */
+	BUG_ON(pref_bias_copy_load % (8 * copy_word_size));
+	BUG_ON(pref_bias_copy_store % (8 * copy_word_size));
+	BUG_ON(PAGE_SIZE < pref_bias_copy_load);
+	BUG_ON(pref_bias_copy_store > pref_bias_copy_load);
+
+	off = PAGE_SIZE - pref_bias_copy_load;
+	if (off > 0xffff)
+		pg_addiu(&buf, A2, A0, off);
+	else
+		uasm_i_ori(&buf, A2, A0, off);
+
+	if (R4600_V2_HIT_CACHEOP_WAR && cpu_is_r4600_v2_x())
+		uasm_i_lui(&buf, AT, 0xa000);
+
+	off = min(8, pref_bias_copy_load / cache_line_size) * cache_line_size;
+	while (off) {
+		build_copy_load_pref(&buf, -off);
+		off -= cache_line_size;
+	}
+	off = min(8, pref_bias_copy_store / cache_line_size) * cache_line_size;
+	while (off) {
+		build_copy_store_pref(&buf, -off);
+		off -= cache_line_size;
+	}
+	uasm_l_copy_pref_both(&l, buf);
+	do {
+		build_copy_load_pref(&buf, off);
+		build_copy_load(&buf, T0, off);
+		build_copy_load_pref(&buf, off + copy_word_size);
+		build_copy_load(&buf, T1, off + copy_word_size);
+		build_copy_load_pref(&buf, off + 2 * copy_word_size);
+		build_copy_load(&buf, T2, off + 2 * copy_word_size);
+		build_copy_load_pref(&buf, off + 3 * copy_word_size);
+		build_copy_load(&buf, T3, off + 3 * copy_word_size);
+		build_copy_store_pref(&buf, off);
+		build_copy_store(&buf, T0, off);
+		build_copy_store_pref(&buf, off + copy_word_size);
+		build_copy_store(&buf, T1, off + copy_word_size);
+		build_copy_store_pref(&buf, off + 2 * copy_word_size);
+		build_copy_store(&buf, T2, off + 2 * copy_word_size);
+		build_copy_store_pref(&buf, off + 3 * copy_word_size);
+		build_copy_store(&buf, T3, off + 3 * copy_word_size);
+		off += 4 * copy_word_size;
+	} while (off < half_copy_loop_size);
+	pg_addiu(&buf, A1, A1, 2 * off);
+	pg_addiu(&buf, A0, A0, 2 * off);
+	off = -off;
+	do {
+		build_copy_load_pref(&buf, off);
+		build_copy_load(&buf, T0, off);
+		build_copy_load_pref(&buf, off + copy_word_size);
+		build_copy_load(&buf, T1, off + copy_word_size);
+		build_copy_load_pref(&buf, off + 2 * copy_word_size);
+		build_copy_load(&buf, T2, off + 2 * copy_word_size);
+		build_copy_load_pref(&buf, off + 3 * copy_word_size);
+		build_copy_load(&buf, T3, off + 3 * copy_word_size);
+		build_copy_store_pref(&buf, off);
+		build_copy_store(&buf, T0, off);
+		build_copy_store_pref(&buf, off + copy_word_size);
+		build_copy_store(&buf, T1, off + copy_word_size);
+		build_copy_store_pref(&buf, off + 2 * copy_word_size);
+		build_copy_store(&buf, T2, off + 2 * copy_word_size);
+		build_copy_store_pref(&buf, off + 3 * copy_word_size);
+		if (off == -(4 * copy_word_size))
+			uasm_il_bne(&buf, &r, A2, A0, label_copy_pref_both);
+		build_copy_store(&buf, T3, off + 3 * copy_word_size);
+		off += 4 * copy_word_size;
+	} while (off < 0);
+
+	if (pref_bias_copy_load - pref_bias_copy_store) {
+		pg_addiu(&buf, A2, A0,
+			 pref_bias_copy_load - pref_bias_copy_store);
+		uasm_l_copy_pref_store(&l, buf);
+		off = 0;
+		do {
+			build_copy_load(&buf, T0, off);
+			build_copy_load(&buf, T1, off + copy_word_size);
+			build_copy_load(&buf, T2, off + 2 * copy_word_size);
+			build_copy_load(&buf, T3, off + 3 * copy_word_size);
+			build_copy_store_pref(&buf, off);
+			build_copy_store(&buf, T0, off);
+			build_copy_store_pref(&buf, off + copy_word_size);
+			build_copy_store(&buf, T1, off + copy_word_size);
+			build_copy_store_pref(&buf, off + 2 * copy_word_size);
+			build_copy_store(&buf, T2, off + 2 * copy_word_size);
+			build_copy_store_pref(&buf, off + 3 * copy_word_size);
+			build_copy_store(&buf, T3, off + 3 * copy_word_size);
+			off += 4 * copy_word_size;
+		} while (off < half_copy_loop_size);
+		pg_addiu(&buf, A1, A1, 2 * off);
+		pg_addiu(&buf, A0, A0, 2 * off);
+		off = -off;
+		do {
+			build_copy_load(&buf, T0, off);
+			build_copy_load(&buf, T1, off + copy_word_size);
+			build_copy_load(&buf, T2, off + 2 * copy_word_size);
+			build_copy_load(&buf, T3, off + 3 * copy_word_size);
+			build_copy_store_pref(&buf, off);
+			build_copy_store(&buf, T0, off);
+			build_copy_store_pref(&buf, off + copy_word_size);
+			build_copy_store(&buf, T1, off + copy_word_size);
+			build_copy_store_pref(&buf, off + 2 * copy_word_size);
+			build_copy_store(&buf, T2, off + 2 * copy_word_size);
+			build_copy_store_pref(&buf, off + 3 * copy_word_size);
+			if (off == -(4 * copy_word_size))
+				uasm_il_bne(&buf, &r, A2, A0,
+					    label_copy_pref_store);
+			build_copy_store(&buf, T3, off + 3 * copy_word_size);
+			off += 4 * copy_word_size;
+		} while (off < 0);
+	}
+
+	if (pref_bias_copy_store) {
+		pg_addiu(&buf, A2, A0, pref_bias_copy_store);
+		uasm_l_copy_nopref(&l, buf);
+		off = 0;
+		do {
+			build_copy_load(&buf, T0, off);
+			build_copy_load(&buf, T1, off + copy_word_size);
+			build_copy_load(&buf, T2, off + 2 * copy_word_size);
+			build_copy_load(&buf, T3, off + 3 * copy_word_size);
+			build_copy_store(&buf, T0, off);
+			build_copy_store(&buf, T1, off + copy_word_size);
+			build_copy_store(&buf, T2, off + 2 * copy_word_size);
+			build_copy_store(&buf, T3, off + 3 * copy_word_size);
+			off += 4 * copy_word_size;
+		} while (off < half_copy_loop_size);
+		pg_addiu(&buf, A1, A1, 2 * off);
+		pg_addiu(&buf, A0, A0, 2 * off);
+		off = -off;
+		do {
+			build_copy_load(&buf, T0, off);
+			build_copy_load(&buf, T1, off + copy_word_size);
+			build_copy_load(&buf, T2, off + 2 * copy_word_size);
+			build_copy_load(&buf, T3, off + 3 * copy_word_size);
+			build_copy_store(&buf, T0, off);
+			build_copy_store(&buf, T1, off + copy_word_size);
+			build_copy_store(&buf, T2, off + 2 * copy_word_size);
+			if (off == -(4 * copy_word_size))
+				uasm_il_bne(&buf, &r, A2, A0,
+					    label_copy_nopref);
+			build_copy_store(&buf, T3, off + 3 * copy_word_size);
+			off += 4 * copy_word_size;
+		} while (off < 0);
+	}
+
+	uasm_i_jr(&buf, RA);
+	uasm_i_nop(&buf);
+
+	BUG_ON(buf > copy_page_array + ARRAY_SIZE(copy_page_array));
+
+	uasm_resolve_relocs(relocs, labels);
+
+	pr_debug("Synthesized copy page handler (%u instructions).\n",
+		 (u32)(buf - copy_page_array));
+
+	pr_debug("\t.set push\n");
+	pr_debug("\t.set noreorder\n");
+	for (i = 0; i < (buf - copy_page_array); i++)
+		pr_debug("\t.word 0x%08x\n", copy_page_array[i]);
+	pr_debug("\t.set pop\n");
+}
+
+#ifdef CONFIG_SIBYTE_DMA_PAGEOPS
+
+/*
+ * Pad descriptors to cacheline, since each is exclusively owned by a
+ * particular CPU.
+ */
+struct dmadscr {
+	u64 dscr_a;
+	u64 dscr_b;
+	u64 pad_a;
+	u64 pad_b;
+} ____cacheline_aligned_in_smp page_descr[DM_NUM_CHANNELS];
+
+void sb1_dma_init(void)
+{
+	int i;
+
+	for (i = 0; i < DM_NUM_CHANNELS; i++) {
+		const u64 base_val = CPHYSADDR((unsigned long)&page_descr[i]) |
+				     V_DM_DSCR_BASE_RINGSZ(1);
+		void *base_reg = IOADDR(A_DM_REGISTER(i, R_DM_DSCR_BASE));
+
+		__raw_writeq(base_val, base_reg);
+		__raw_writeq(base_val | M_DM_DSCR_BASE_RESET, base_reg);
+		__raw_writeq(base_val | M_DM_DSCR_BASE_ENABL, base_reg);
+	}
+}
+
+void clear_page(void *page)
+{
+	u64 to_phys = CPHYSADDR((unsigned long)page);
+	unsigned int cpu = smp_processor_id();
+
+	/* if the page is not in KSEG0, use old way */
+	if ((long)KSEGX((unsigned long)page) != (long)CKSEG0)
+		return clear_page_cpu(page);
+
+	page_descr[cpu].dscr_a = to_phys | M_DM_DSCRA_ZERO_MEM |
+				 M_DM_DSCRA_L2C_DEST | M_DM_DSCRA_INTERRUPT;
+	page_descr[cpu].dscr_b = V_DM_DSCRB_SRC_LENGTH(PAGE_SIZE);
+	__raw_writeq(1, IOADDR(A_DM_REGISTER(cpu, R_DM_DSCR_COUNT)));
+
+	/*
+	 * Don't really want to do it this way, but there's no
+	 * reliable way to delay completion detection.
+	 */
+	while (!(__raw_readq(IOADDR(A_DM_REGISTER(cpu, R_DM_DSCR_BASE_DEBUG)))
+		 & M_DM_DSCR_BASE_INTERRUPT))
+		;
+	__raw_readq(IOADDR(A_DM_REGISTER(cpu, R_DM_DSCR_BASE)));
+}
+
+void copy_page(void *to, void *from)
+{
+	u64 from_phys = CPHYSADDR((unsigned long)from);
+	u64 to_phys = CPHYSADDR((unsigned long)to);
+	unsigned int cpu = smp_processor_id();
+
+	/* if any page is not in KSEG0, use old way */
+	if ((long)KSEGX((unsigned long)to) != (long)CKSEG0
+	    || (long)KSEGX((unsigned long)from) != (long)CKSEG0)
+		return copy_page_cpu(to, from);
+
+	page_descr[cpu].dscr_a = to_phys | M_DM_DSCRA_L2C_DEST |
+				 M_DM_DSCRA_INTERRUPT;
+	page_descr[cpu].dscr_b = from_phys | V_DM_DSCRB_SRC_LENGTH(PAGE_SIZE);
+	__raw_writeq(1, IOADDR(A_DM_REGISTER(cpu, R_DM_DSCR_COUNT)));
+
+	/*
+	 * Don't really want to do it this way, but there's no
+	 * reliable way to delay completion detection.
+	 */
+	while (!(__raw_readq(IOADDR(A_DM_REGISTER(cpu, R_DM_DSCR_BASE_DEBUG)))
+		 & M_DM_DSCR_BASE_INTERRUPT))
+		;
+	__raw_readq(IOADDR(A_DM_REGISTER(cpu, R_DM_DSCR_BASE)));
+}
+
+#endif /* CONFIG_SIBYTE_DMA_PAGEOPS */
