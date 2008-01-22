Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jan 2008 00:00:58 +0000 (GMT)
Received: from relay01.mx.bawue.net ([193.7.176.67]:29139 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S28587632AbYAVAAs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 22 Jan 2008 00:00:48 +0000
Received: from lagash (88-106-232-89.dynamic.dsl.as9105.com [88.106.232.89])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id 9F04148917;
	Tue, 22 Jan 2008 01:00:29 +0100 (CET)
Received: from ths by lagash with local (Exim 4.68)
	(envelope-from <ths@networkno.de>)
	id 1JH6Z0-0000Cl-GQ; Tue, 22 Jan 2008 00:00:26 +0000
Date:	Tue, 22 Jan 2008 00:00:26 +0000
From:	Thiemo Seufer <ths@networkno.de>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Message-ID: <20080122000026.GN28842@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-12-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18108
Subject: (no subject)
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Hello All,

This patch moves the micro-assembler in a separate implementation, as
it is useful for further run-time optimizations. The only change in
behaviour is cutting down printk noise at kernel startup time.

Checkpatch complains about macro parameters which aren't protected by
parentheses. I believe this is a flaw in checkpatch, the paste operator
used in those macros won't work with parenthesised parameters.

Tested on:
- Qemu 32-bit little endian
- BCM1480 64-bit big endian


Thiemo


---
Split the micro-assembler from tlbex.c.

Signed-off-by:  Thiemo Seufer <ths@networkno.de>


diff --git a/arch/mips/mm/Makefile b/arch/mips/mm/Makefile
index 32fd5db..c6f832e 100644
--- a/arch/mips/mm/Makefile
+++ b/arch/mips/mm/Makefile
@@ -3,7 +3,8 @@
 #
 
 obj-y				+= cache.o dma-default.o extable.o fault.o \
-				   init.o pgtable.o tlbex.o tlbex-fault.o
+				   init.o pgtable.o tlbex.o tlbex-fault.o \
+				   uasm.o
 
 obj-$(CONFIG_32BIT)		+= ioremap.o pgtable-32.o
 obj-$(CONFIG_64BIT)		+= pgtable-64.o
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index a61246d..48a2589 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -5,7 +5,7 @@
  *
  * Synthesize TLB refill handlers at runtime.
  *
- * Copyright (C) 2004,2005,2006 by Thiemo Seufer
+ * Copyright (C) 2004,2005,2006,2008  Thiemo Seufer
  * Copyright (C) 2005  Maciej W. Rozycki
  * Copyright (C) 2006  Ralf Baechle (ralf@linux-mips.org)
  *
@@ -19,8 +19,6 @@
  * (Condolences to Napoleon XIV)
  */
 
-#include <stdarg.h>
-
 #include <linux/mm.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
@@ -30,11 +28,11 @@
 #include <asm/pgtable.h>
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
-#include <asm/inst.h>
-#include <asm/elf.h>
 #include <asm/smp.h>
 #include <asm/war.h>
 
+#include "uasm.h"
+
 static inline int r45k_bvahwbug(void)
 {
 	/* XXX: We should probe for the presence of this bug, but we don't. */
@@ -72,371 +70,9 @@ static __init int __attribute__((unused)) m4kc_tlbp_war(void)
 	       (PRID_COMP_MIPS | PRID_IMP_4KC);
 }
 
-/*
- * A little micro-assembler, intended for TLB refill handler
- * synthesizing. It is intentionally kept simple, does only support
- * a subset of instructions, and does not try to hide pipeline effects
- * like branch delay slots.
- */
-
-enum fields
-{
-	RS = 0x001,
-	RT = 0x002,
-	RD = 0x004,
-	RE = 0x008,
-	SIMM = 0x010,
-	UIMM = 0x020,
-	BIMM = 0x040,
-	JIMM = 0x080,
-	FUNC = 0x100,
-	SET = 0x200
-};
-
-#define OP_MASK		0x3f
-#define OP_SH		26
-#define RS_MASK		0x1f
-#define RS_SH		21
-#define RT_MASK		0x1f
-#define RT_SH		16
-#define RD_MASK		0x1f
-#define RD_SH		11
-#define RE_MASK		0x1f
-#define RE_SH		6
-#define IMM_MASK	0xffff
-#define IMM_SH		0
-#define JIMM_MASK	0x3ffffff
-#define JIMM_SH		0
-#define FUNC_MASK	0x3f
-#define FUNC_SH		0
-#define SET_MASK	0x7
-#define SET_SH		0
-
-enum opcode {
-	insn_invalid,
-	insn_addu, insn_addiu, insn_and, insn_andi, insn_beq,
-	insn_beql, insn_bgez, insn_bgezl, insn_bltz, insn_bltzl,
-	insn_bne, insn_daddu, insn_daddiu, insn_dmfc0, insn_dmtc0,
-	insn_dsll, insn_dsll32, insn_dsra, insn_dsrl, insn_dsrl32,
-	insn_dsubu, insn_eret, insn_j, insn_jal, insn_jr, insn_ld,
-	insn_ll, insn_lld, insn_lui, insn_lw, insn_mfc0, insn_mtc0,
-	insn_ori, insn_rfe, insn_sc, insn_scd, insn_sd, insn_sll,
-	insn_sra, insn_srl, insn_subu, insn_sw, insn_tlbp, insn_tlbwi,
-	insn_tlbwr, insn_xor, insn_xori
-};
-
-struct insn {
-	enum opcode opcode;
-	u32 match;
-	enum fields fields;
-};
-
-/* This macro sets the non-variable bits of an instruction. */
-#define M(a, b, c, d, e, f)					\
-	((a) << OP_SH						\
-	 | (b) << RS_SH						\
-	 | (c) << RT_SH						\
-	 | (d) << RD_SH						\
-	 | (e) << RE_SH						\
-	 | (f) << FUNC_SH)
-
-static __initdata struct insn insn_table[] = {
-	{ insn_addiu, M(addiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM },
-	{ insn_addu, M(spec_op, 0, 0, 0, 0, addu_op), RS | RT | RD },
-	{ insn_and, M(spec_op, 0, 0, 0, 0, and_op), RS | RT | RD },
-	{ insn_andi, M(andi_op, 0, 0, 0, 0, 0), RS | RT | UIMM },
-	{ insn_beq, M(beq_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
-	{ insn_beql, M(beql_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
-	{ insn_bgez, M(bcond_op, 0, bgez_op, 0, 0, 0), RS | BIMM },
-	{ insn_bgezl, M(bcond_op, 0, bgezl_op, 0, 0, 0), RS | BIMM },
-	{ insn_bltz, M(bcond_op, 0, bltz_op, 0, 0, 0), RS | BIMM },
-	{ insn_bltzl, M(bcond_op, 0, bltzl_op, 0, 0, 0), RS | BIMM },
-	{ insn_bne, M(bne_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
-	{ insn_daddiu, M(daddiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM },
-	{ insn_daddu, M(spec_op, 0, 0, 0, 0, daddu_op), RS | RT | RD },
-	{ insn_dmfc0, M(cop0_op, dmfc_op, 0, 0, 0, 0), RT | RD | SET},
-	{ insn_dmtc0, M(cop0_op, dmtc_op, 0, 0, 0, 0), RT | RD | SET},
-	{ insn_dsll, M(spec_op, 0, 0, 0, 0, dsll_op), RT | RD | RE },
-	{ insn_dsll32, M(spec_op, 0, 0, 0, 0, dsll32_op), RT | RD | RE },
-	{ insn_dsra, M(spec_op, 0, 0, 0, 0, dsra_op), RT | RD | RE },
-	{ insn_dsrl, M(spec_op, 0, 0, 0, 0, dsrl_op), RT | RD | RE },
-	{ insn_dsrl32, M(spec_op, 0, 0, 0, 0, dsrl32_op), RT | RD | RE },
-	{ insn_dsubu, M(spec_op, 0, 0, 0, 0, dsubu_op), RS | RT | RD },
-	{ insn_eret,  M(cop0_op, cop_op, 0, 0, 0, eret_op),  0 },
-	{ insn_j,  M(j_op, 0, 0, 0, 0, 0),  JIMM },
-	{ insn_jal,  M(jal_op, 0, 0, 0, 0, 0),  JIMM },
-	{ insn_jr,  M(spec_op, 0, 0, 0, 0, jr_op),  RS },
-	{ insn_ld,  M(ld_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
-	{ insn_ll,  M(ll_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
-	{ insn_lld,  M(lld_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
-	{ insn_lui,  M(lui_op, 0, 0, 0, 0, 0),  RT | SIMM },
-	{ insn_lw,  M(lw_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
-	{ insn_mfc0,  M(cop0_op, mfc_op, 0, 0, 0, 0),  RT | RD | SET},
-	{ insn_mtc0,  M(cop0_op, mtc_op, 0, 0, 0, 0),  RT | RD | SET},
-	{ insn_ori,  M(ori_op, 0, 0, 0, 0, 0),  RS | RT | UIMM },
-	{ insn_rfe,  M(cop0_op, cop_op, 0, 0, 0, rfe_op),  0 },
-	{ insn_sc,  M(sc_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
-	{ insn_scd,  M(scd_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
-	{ insn_sd,  M(sd_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
-	{ insn_sll,  M(spec_op, 0, 0, 0, 0, sll_op),  RT | RD | RE },
-	{ insn_sra,  M(spec_op, 0, 0, 0, 0, sra_op),  RT | RD | RE },
-	{ insn_srl,  M(spec_op, 0, 0, 0, 0, srl_op),  RT | RD | RE },
-	{ insn_subu,  M(spec_op, 0, 0, 0, 0, subu_op),  RS | RT | RD },
-	{ insn_sw,  M(sw_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
-	{ insn_tlbp,  M(cop0_op, cop_op, 0, 0, 0, tlbp_op),  0 },
-	{ insn_tlbwi,  M(cop0_op, cop_op, 0, 0, 0, tlbwi_op),  0 },
-	{ insn_tlbwr,  M(cop0_op, cop_op, 0, 0, 0, tlbwr_op),  0 },
-	{ insn_xor,  M(spec_op, 0, 0, 0, 0, xor_op),  RS | RT | RD },
-	{ insn_xori,  M(xori_op, 0, 0, 0, 0, 0),  RS | RT | UIMM },
-	{ insn_invalid, 0, 0 }
-};
-
-#undef M
-
-static __init u32 build_rs(u32 arg)
-{
-	if (arg & ~RS_MASK)
-		printk(KERN_WARNING "TLB synthesizer field overflow\n");
-
-	return (arg & RS_MASK) << RS_SH;
-}
-
-static __init u32 build_rt(u32 arg)
-{
-	if (arg & ~RT_MASK)
-		printk(KERN_WARNING "TLB synthesizer field overflow\n");
-
-	return (arg & RT_MASK) << RT_SH;
-}
-
-static __init u32 build_rd(u32 arg)
-{
-	if (arg & ~RD_MASK)
-		printk(KERN_WARNING "TLB synthesizer field overflow\n");
-
-	return (arg & RD_MASK) << RD_SH;
-}
-
-static __init u32 build_re(u32 arg)
-{
-	if (arg & ~RE_MASK)
-		printk(KERN_WARNING "TLB synthesizer field overflow\n");
-
-	return (arg & RE_MASK) << RE_SH;
-}
-
-static __init u32 build_simm(s32 arg)
-{
-	if (arg > 0x7fff || arg < -0x8000)
-		printk(KERN_WARNING "TLB synthesizer field overflow\n");
-
-	return arg & 0xffff;
-}
-
-static __init u32 build_uimm(u32 arg)
-{
-	if (arg & ~IMM_MASK)
-		printk(KERN_WARNING "TLB synthesizer field overflow\n");
-
-	return arg & IMM_MASK;
-}
-
-static __init u32 build_bimm(s32 arg)
-{
-	if (arg > 0x1ffff || arg < -0x20000)
-		printk(KERN_WARNING "TLB synthesizer field overflow\n");
-
-	if (arg & 0x3)
-		printk(KERN_WARNING "Invalid TLB synthesizer branch target\n");
-
-	return ((arg < 0) ? (1 << 15) : 0) | ((arg >> 2) & 0x7fff);
-}
-
-static __init u32 build_jimm(u32 arg)
-{
-	if (arg & ~((JIMM_MASK) << 2))
-		printk(KERN_WARNING "TLB synthesizer field overflow\n");
-
-	return (arg >> 2) & JIMM_MASK;
-}
-
-static __init u32 build_func(u32 arg)
-{
-	if (arg & ~FUNC_MASK)
-		printk(KERN_WARNING "TLB synthesizer field overflow\n");
-
-	return arg & FUNC_MASK;
-}
-
-static __init u32 build_set(u32 arg)
-{
-	if (arg & ~SET_MASK)
-		printk(KERN_WARNING "TLB synthesizer field overflow\n");
-
-	return arg & SET_MASK;
-}
-
-/*
- * The order of opcode arguments is implicitly left to right,
- * starting with RS and ending with FUNC or IMM.
- */
-static void __init build_insn(u32 **buf, enum opcode opc, ...)
-{
-	struct insn *ip = NULL;
-	unsigned int i;
-	va_list ap;
-	u32 op;
-
-	for (i = 0; insn_table[i].opcode != insn_invalid; i++)
-		if (insn_table[i].opcode == opc) {
-			ip = &insn_table[i];
-			break;
-		}
-
-	if (!ip)
-		panic("Unsupported TLB synthesizer instruction %d", opc);
-
-	op = ip->match;
-	va_start(ap, opc);
-	if (ip->fields & RS) op |= build_rs(va_arg(ap, u32));
-	if (ip->fields & RT) op |= build_rt(va_arg(ap, u32));
-	if (ip->fields & RD) op |= build_rd(va_arg(ap, u32));
-	if (ip->fields & RE) op |= build_re(va_arg(ap, u32));
-	if (ip->fields & SIMM) op |= build_simm(va_arg(ap, s32));
-	if (ip->fields & UIMM) op |= build_uimm(va_arg(ap, u32));
-	if (ip->fields & BIMM) op |= build_bimm(va_arg(ap, s32));
-	if (ip->fields & JIMM) op |= build_jimm(va_arg(ap, u32));
-	if (ip->fields & FUNC) op |= build_func(va_arg(ap, u32));
-	if (ip->fields & SET) op |= build_set(va_arg(ap, u32));
-	va_end(ap);
-
-	**buf = op;
-	(*buf)++;
-}
-
-#define I_u1u2u3(op)						\
-	static inline void __init i##op(u32 **buf, unsigned int a,	\
-	 	unsigned int b, unsigned int c)			\
-	{							\
-		build_insn(buf, insn##op, a, b, c);		\
-	}
-
-#define I_u2u1u3(op)						\
-	static inline void __init i##op(u32 **buf, unsigned int a,	\
-	 	unsigned int b, unsigned int c)			\
-	{							\
-		build_insn(buf, insn##op, b, a, c);		\
-	}
-
-#define I_u3u1u2(op)						\
-	static inline void __init i##op(u32 **buf, unsigned int a,	\
-	 	unsigned int b, unsigned int c)			\
-	{							\
-		build_insn(buf, insn##op, b, c, a);		\
-	}
-
-#define I_u1u2s3(op)						\
-	static inline void __init i##op(u32 **buf, unsigned int a,	\
-	 	unsigned int b, signed int c)			\
-	{							\
-		build_insn(buf, insn##op, a, b, c);		\
-	}
-
-#define I_u2s3u1(op)						\
-	static inline void __init i##op(u32 **buf, unsigned int a,	\
-	 	signed int b, unsigned int c)			\
-	{							\
-		build_insn(buf, insn##op, c, a, b);		\
-	}
-
-#define I_u2u1s3(op)						\
-	static inline void __init i##op(u32 **buf, unsigned int a,	\
-	 	unsigned int b, signed int c)			\
-	{							\
-		build_insn(buf, insn##op, b, a, c);		\
-	}
-
-#define I_u1u2(op)						\
-	static inline void __init i##op(u32 **buf, unsigned int a,	\
-	 	unsigned int b)					\
-	{							\
-		build_insn(buf, insn##op, a, b);		\
-	}
-
-#define I_u1s2(op)						\
-	static inline void __init i##op(u32 **buf, unsigned int a,	\
-	 	signed int b)					\
-	{							\
-		build_insn(buf, insn##op, a, b);		\
-	}
-
-#define I_u1(op)						\
-	static inline void __init i##op(u32 **buf, unsigned int a)	\
-	{							\
-		build_insn(buf, insn##op, a);			\
-	}
-
-#define I_0(op)							\
-	static inline void __init i##op(u32 **buf)		\
-	{							\
-		build_insn(buf, insn##op);			\
-	}
-
-I_u2u1s3(_addiu);
-I_u3u1u2(_addu);
-I_u2u1u3(_andi);
-I_u3u1u2(_and);
-I_u1u2s3(_beq);
-I_u1u2s3(_beql);
-I_u1s2(_bgez);
-I_u1s2(_bgezl);
-I_u1s2(_bltz);
-I_u1s2(_bltzl);
-I_u1u2s3(_bne);
-I_u1u2u3(_dmfc0);
-I_u1u2u3(_dmtc0);
-I_u2u1s3(_daddiu);
-I_u3u1u2(_daddu);
-I_u2u1u3(_dsll);
-I_u2u1u3(_dsll32);
-I_u2u1u3(_dsra);
-I_u2u1u3(_dsrl);
-I_u2u1u3(_dsrl32);
-I_u3u1u2(_dsubu);
-I_0(_eret);
-I_u1(_j);
-I_u1(_jal);
-I_u1(_jr);
-I_u2s3u1(_ld);
-I_u2s3u1(_ll);
-I_u2s3u1(_lld);
-I_u1s2(_lui);
-I_u2s3u1(_lw);
-I_u1u2u3(_mfc0);
-I_u1u2u3(_mtc0);
-I_u2u1u3(_ori);
-I_0(_rfe);
-I_u2s3u1(_sc);
-I_u2s3u1(_scd);
-I_u2s3u1(_sd);
-I_u2u1u3(_sll);
-I_u2u1u3(_sra);
-I_u2u1u3(_srl);
-I_u3u1u2(_subu);
-I_u2s3u1(_sw);
-I_0(_tlbp);
-I_0(_tlbwi);
-I_0(_tlbwr);
-I_u3u1u2(_xor)
-I_u2u1u3(_xori);
-
-/*
- * handling labels
- */
-
+/* Handle labels (which must be positive integers). */
 enum label_id {
-	label_invalid,
-	label_second_part,
+	label_second_part = 1,
 	label_leave,
 #ifdef MODULE_START
 	label_module_alloc,
@@ -452,267 +88,20 @@ enum label_id {
 	label_r3000_write_probe_fail,
 };
 
-struct label {
-	u32 *addr;
-	enum label_id lab;
-};
-
-static __init void build_label(struct label **lab, u32 *addr,
-			       enum label_id l)
-{
-	(*lab)->addr = addr;
-	(*lab)->lab = l;
-	(*lab)++;
-}
-
-#define L_LA(lb)						\
-	static inline void l##lb(struct label **lab, u32 *addr) \
-	{							\
-		build_label(lab, addr, label##lb);		\
-	}
-
-L_LA(_second_part)
-L_LA(_leave)
+UASM_L_LA(_second_part)
+UASM_L_LA(_leave)
 #ifdef MODULE_START
-L_LA(_module_alloc)
-#endif
-L_LA(_vmalloc)
-L_LA(_vmalloc_done)
-L_LA(_tlbw_hazard)
-L_LA(_split)
-L_LA(_nopage_tlbl)
-L_LA(_nopage_tlbs)
-L_LA(_nopage_tlbm)
-L_LA(_smp_pgtable_change)
-L_LA(_r3000_write_probe_fail)
-
-/* convenience macros for instructions */
-#ifdef CONFIG_64BIT
-# define i_LW(buf, rs, rt, off) i_ld(buf, rs, rt, off)
-# define i_SW(buf, rs, rt, off) i_sd(buf, rs, rt, off)
-# define i_SLL(buf, rs, rt, sh) i_dsll(buf, rs, rt, sh)
-# define i_SRA(buf, rs, rt, sh) i_dsra(buf, rs, rt, sh)
-# define i_SRL(buf, rs, rt, sh) i_dsrl(buf, rs, rt, sh)
-# define i_MFC0(buf, rt, rd...) i_dmfc0(buf, rt, rd)
-# define i_MTC0(buf, rt, rd...) i_dmtc0(buf, rt, rd)
-# define i_ADDIU(buf, rs, rt, val) i_daddiu(buf, rs, rt, val)
-# define i_ADDU(buf, rs, rt, rd) i_daddu(buf, rs, rt, rd)
-# define i_SUBU(buf, rs, rt, rd) i_dsubu(buf, rs, rt, rd)
-# define i_LL(buf, rs, rt, off) i_lld(buf, rs, rt, off)
-# define i_SC(buf, rs, rt, off) i_scd(buf, rs, rt, off)
-#else
-# define i_LW(buf, rs, rt, off) i_lw(buf, rs, rt, off)
-# define i_SW(buf, rs, rt, off) i_sw(buf, rs, rt, off)
-# define i_SLL(buf, rs, rt, sh) i_sll(buf, rs, rt, sh)
-# define i_SRA(buf, rs, rt, sh) i_sra(buf, rs, rt, sh)
-# define i_SRL(buf, rs, rt, sh) i_srl(buf, rs, rt, sh)
-# define i_MFC0(buf, rt, rd...) i_mfc0(buf, rt, rd)
-# define i_MTC0(buf, rt, rd...) i_mtc0(buf, rt, rd)
-# define i_ADDIU(buf, rs, rt, val) i_addiu(buf, rs, rt, val)
-# define i_ADDU(buf, rs, rt, rd) i_addu(buf, rs, rt, rd)
-# define i_SUBU(buf, rs, rt, rd) i_subu(buf, rs, rt, rd)
-# define i_LL(buf, rs, rt, off) i_ll(buf, rs, rt, off)
-# define i_SC(buf, rs, rt, off) i_sc(buf, rs, rt, off)
-#endif
-
-#define i_b(buf, off) i_beq(buf, 0, 0, off)
-#define i_beqz(buf, rs, off) i_beq(buf, rs, 0, off)
-#define i_beqzl(buf, rs, off) i_beql(buf, rs, 0, off)
-#define i_bnez(buf, rs, off) i_bne(buf, rs, 0, off)
-#define i_bnezl(buf, rs, off) i_bnel(buf, rs, 0, off)
-#define i_move(buf, a, b) i_ADDU(buf, a, 0, b)
-#define i_nop(buf) i_sll(buf, 0, 0, 0)
-#define i_ssnop(buf) i_sll(buf, 0, 0, 1)
-#define i_ehb(buf) i_sll(buf, 0, 0, 3)
-
-#ifdef CONFIG_64BIT
-static __init int __maybe_unused in_compat_space_p(long addr)
-{
-	/* Is this address in 32bit compat space? */
-	return (((addr) & 0xffffffff00000000L) == 0xffffffff00000000L);
-}
-
-static __init int __maybe_unused rel_highest(long val)
-{
-	return ((((val + 0x800080008000L) >> 48) & 0xffff) ^ 0x8000) - 0x8000;
-}
-
-static __init int __maybe_unused rel_higher(long val)
-{
-	return ((((val + 0x80008000L) >> 32) & 0xffff) ^ 0x8000) - 0x8000;
-}
-#endif
-
-static __init int rel_hi(long val)
-{
-	return ((((val + 0x8000L) >> 16) & 0xffff) ^ 0x8000) - 0x8000;
-}
-
-static __init int rel_lo(long val)
-{
-	return ((val & 0xffff) ^ 0x8000) - 0x8000;
-}
-
-static __init void i_LA_mostly(u32 **buf, unsigned int rs, long addr)
-{
-#ifdef CONFIG_64BIT
-	if (!in_compat_space_p(addr)) {
-		i_lui(buf, rs, rel_highest(addr));
-		if (rel_higher(addr))
-			i_daddiu(buf, rs, rs, rel_higher(addr));
-		if (rel_hi(addr)) {
-			i_dsll(buf, rs, rs, 16);
-			i_daddiu(buf, rs, rs, rel_hi(addr));
-			i_dsll(buf, rs, rs, 16);
-		} else
-			i_dsll32(buf, rs, rs, 0);
-	} else
+UASM_L_LA(_module_alloc)
 #endif
-		i_lui(buf, rs, rel_hi(addr));
-}
-
-static __init void __maybe_unused i_LA(u32 **buf, unsigned int rs,
-					     long addr)
-{
-	i_LA_mostly(buf, rs, addr);
-	if (rel_lo(addr))
-		i_ADDIU(buf, rs, rs, rel_lo(addr));
-}
-
-/*
- * handle relocations
- */
-
-struct reloc {
-	u32 *addr;
-	unsigned int type;
-	enum label_id lab;
-};
-
-static __init void r_mips_pc16(struct reloc **rel, u32 *addr,
-			       enum label_id l)
-{
-	(*rel)->addr = addr;
-	(*rel)->type = R_MIPS_PC16;
-	(*rel)->lab = l;
-	(*rel)++;
-}
-
-static inline void __resolve_relocs(struct reloc *rel, struct label *lab)
-{
-	long laddr = (long)lab->addr;
-	long raddr = (long)rel->addr;
-
-	switch (rel->type) {
-	case R_MIPS_PC16:
-		*rel->addr |= build_bimm(laddr - (raddr + 4));
-		break;
-
-	default:
-		panic("Unsupported TLB synthesizer relocation %d",
-		      rel->type);
-	}
-}
-
-static __init void resolve_relocs(struct reloc *rel, struct label *lab)
-{
-	struct label *l;
-
-	for (; rel->lab != label_invalid; rel++)
-		for (l = lab; l->lab != label_invalid; l++)
-			if (rel->lab == l->lab)
-				__resolve_relocs(rel, l);
-}
-
-static __init void move_relocs(struct reloc *rel, u32 *first, u32 *end,
-			       long off)
-{
-	for (; rel->lab != label_invalid; rel++)
-		if (rel->addr >= first && rel->addr < end)
-			rel->addr += off;
-}
-
-static __init void move_labels(struct label *lab, u32 *first, u32 *end,
-			       long off)
-{
-	for (; lab->lab != label_invalid; lab++)
-		if (lab->addr >= first && lab->addr < end)
-			lab->addr += off;
-}
-
-static __init void copy_handler(struct reloc *rel, struct label *lab,
-				u32 *first, u32 *end, u32 *target)
-{
-	long off = (long)(target - first);
-
-	memcpy(target, first, (end - first) * sizeof(u32));
-
-	move_relocs(rel, first, end, off);
-	move_labels(lab, first, end, off);
-}
-
-static __init int __maybe_unused insn_has_bdelay(struct reloc *rel,
-						       u32 *addr)
-{
-	for (; rel->lab != label_invalid; rel++) {
-		if (rel->addr == addr
-		    && (rel->type == R_MIPS_PC16
-			|| rel->type == R_MIPS_26))
-			return 1;
-	}
-
-	return 0;
-}
-
-/* convenience functions for labeled branches */
-static void __init __maybe_unused
-	il_bltz(u32 **p, struct reloc **r, unsigned int reg, enum label_id l)
-{
-	r_mips_pc16(r, *p, l);
-	i_bltz(p, reg, 0);
-}
-
-static void __init __maybe_unused il_b(u32 **p, struct reloc **r,
-					     enum label_id l)
-{
-	r_mips_pc16(r, *p, l);
-	i_b(p, 0);
-}
-
-static void __init il_beqz(u32 **p, struct reloc **r, unsigned int reg,
-		    enum label_id l)
-{
-	r_mips_pc16(r, *p, l);
-	i_beqz(p, reg, 0);
-}
-
-static void __init __maybe_unused
-il_beqzl(u32 **p, struct reloc **r, unsigned int reg, enum label_id l)
-{
-	r_mips_pc16(r, *p, l);
-	i_beqzl(p, reg, 0);
-}
-
-static void __init il_bnez(u32 **p, struct reloc **r, unsigned int reg,
-		    enum label_id l)
-{
-	r_mips_pc16(r, *p, l);
-	i_bnez(p, reg, 0);
-}
-
-static void __init il_bgezl(u32 **p, struct reloc **r, unsigned int reg,
-		     enum label_id l)
-{
-	r_mips_pc16(r, *p, l);
-	i_bgezl(p, reg, 0);
-}
-
-static void __init __maybe_unused
-il_bgez(u32 **p, struct reloc **r, unsigned int reg, enum label_id l)
-{
-	r_mips_pc16(r, *p, l);
-	i_bgez(p, reg, 0);
-}
+UASM_L_LA(_vmalloc)
+UASM_L_LA(_vmalloc_done)
+UASM_L_LA(_tlbw_hazard)
+UASM_L_LA(_split)
+UASM_L_LA(_nopage_tlbl)
+UASM_L_LA(_nopage_tlbs)
+UASM_L_LA(_nopage_tlbm)
+UASM_L_LA(_smp_pgtable_change)
+UASM_L_LA(_r3000_write_probe_fail)
 
 /* The only general purpose registers allowed in TLB handlers. */
 #define K0		26
@@ -730,9 +119,9 @@ il_bgez(u32 **p, struct reloc **r, unsigned int reg, enum label_id l)
 #define C0_XCONTEXT	20, 0
 
 #ifdef CONFIG_64BIT
-# define GET_CONTEXT(buf, reg) i_MFC0(buf, reg, C0_XCONTEXT)
+# define GET_CONTEXT(buf, reg) UASM_i_MFC0(buf, reg, C0_XCONTEXT)
 #else
-# define GET_CONTEXT(buf, reg) i_MFC0(buf, reg, C0_CONTEXT)
+# define GET_CONTEXT(buf, reg) UASM_i_MFC0(buf, reg, C0_CONTEXT)
 #endif
 
 /* The worst case length of the handler is around 18 instructions for
@@ -746,8 +135,8 @@ il_bgez(u32 **p, struct reloc **r, unsigned int reg, enum label_id l)
 static __initdata u32 tlb_handler[128];
 
 /* simply assume worst case size for labels and relocs */
-static __initdata struct label labels[128];
-static __initdata struct reloc relocs[128];
+static __initdata struct uasm_label labels[128];
+static __initdata struct uasm_reloc relocs[128];
 
 /*
  * The R3000 TLB handler is simple.
@@ -761,29 +150,29 @@ static void __init build_r3000_tlb_refill_handler(void)
 	memset(tlb_handler, 0, sizeof(tlb_handler));
 	p = tlb_handler;
 
-	i_mfc0(&p, K0, C0_BADVADDR);
-	i_lui(&p, K1, rel_hi(pgdc)); /* cp0 delay */
-	i_lw(&p, K1, rel_lo(pgdc), K1);
-	i_srl(&p, K0, K0, 22); /* load delay */
-	i_sll(&p, K0, K0, 2);
-	i_addu(&p, K1, K1, K0);
-	i_mfc0(&p, K0, C0_CONTEXT);
-	i_lw(&p, K1, 0, K1); /* cp0 delay */
-	i_andi(&p, K0, K0, 0xffc); /* load delay */
-	i_addu(&p, K1, K1, K0);
-	i_lw(&p, K0, 0, K1);
-	i_nop(&p); /* load delay */
-	i_mtc0(&p, K0, C0_ENTRYLO0);
-	i_mfc0(&p, K1, C0_EPC); /* cp0 delay */
-	i_tlbwr(&p); /* cp0 delay */
-	i_jr(&p, K1);
-	i_rfe(&p); /* branch delay */
+	uasm_i_mfc0(&p, K0, C0_BADVADDR);
+	uasm_i_lui(&p, K1, uasm_rel_hi(pgdc)); /* cp0 delay */
+	uasm_i_lw(&p, K1, uasm_rel_lo(pgdc), K1);
+	uasm_i_srl(&p, K0, K0, 22); /* load delay */
+	uasm_i_sll(&p, K0, K0, 2);
+	uasm_i_addu(&p, K1, K1, K0);
+	uasm_i_mfc0(&p, K0, C0_CONTEXT);
+	uasm_i_lw(&p, K1, 0, K1); /* cp0 delay */
+	uasm_i_andi(&p, K0, K0, 0xffc); /* load delay */
+	uasm_i_addu(&p, K1, K1, K0);
+	uasm_i_lw(&p, K0, 0, K1);
+	uasm_i_nop(&p); /* load delay */
+	uasm_i_mtc0(&p, K0, C0_ENTRYLO0);
+	uasm_i_mfc0(&p, K1, C0_EPC); /* cp0 delay */
+	uasm_i_tlbwr(&p); /* cp0 delay */
+	uasm_i_jr(&p, K1);
+	uasm_i_rfe(&p); /* branch delay */
 
 	if (p > tlb_handler + 32)
 		panic("TLB refill handler space exceeded");
 
-	pr_info("Synthesized TLB refill handler (%u instructions).\n",
-		(unsigned int)(p - tlb_handler));
+	pr_debug("Wrote TLB refill handler (%u instructions).\n",
+		 (unsigned int)(p - tlb_handler));
 
 	pr_debug("\t.set push\n");
 	pr_debug("\t.set noreorder\n");
@@ -833,12 +222,12 @@ static __init void __maybe_unused build_tlb_probe_entry(u32 **p)
 	case CPU_R5000:
 	case CPU_R5000A:
 	case CPU_NEVADA:
-		i_nop(p);
-		i_tlbp(p);
+		uasm_i_nop(p);
+		uasm_i_tlbp(p);
 		break;
 
 	default:
-		i_tlbp(p);
+		uasm_i_tlbp(p);
 		break;
 	}
 }
@@ -849,15 +238,15 @@ static __init void __maybe_unused build_tlb_probe_entry(u32 **p)
  */
 enum tlb_write_entry { tlb_random, tlb_indexed };
 
-static __init void build_tlb_write_entry(u32 **p, struct label **l,
-					 struct reloc **r,
+static __init void build_tlb_write_entry(u32 **p, struct uasm_label **l,
+					 struct uasm_reloc **r,
 					 enum tlb_write_entry wmode)
 {
 	void(*tlbw)(u32 **) = NULL;
 
 	switch (wmode) {
-	case tlb_random: tlbw = i_tlbwr; break;
-	case tlb_indexed: tlbw = i_tlbwi; break;
+	case tlb_random: tlbw = uasm_i_tlbwr; break;
+	case tlb_indexed: tlbw = uasm_i_tlbwi; break;
 	}
 
 	switch (current_cpu_type()) {
@@ -871,19 +260,19 @@ static __init void build_tlb_write_entry(u32 **p, struct label **l,
 		 * This branch uses up a mtc0 hazard nop slot and saves
 		 * two nops after the tlbw instruction.
 		 */
-		il_bgezl(p, r, 0, label_tlbw_hazard);
+		uasm_il_bgezl(p, r, 0, label_tlbw_hazard);
 		tlbw(p);
-		l_tlbw_hazard(l, *p);
-		i_nop(p);
+		uasm_l_tlbw_hazard(l, *p);
+		uasm_i_nop(p);
 		break;
 
 	case CPU_R4600:
 	case CPU_R4700:
 	case CPU_R5000:
 	case CPU_R5000A:
-		i_nop(p);
+		uasm_i_nop(p);
 		tlbw(p);
-		i_nop(p);
+		uasm_i_nop(p);
 		break;
 
 	case CPU_R4300:
@@ -895,7 +284,7 @@ static __init void build_tlb_write_entry(u32 **p, struct label **l,
 	case CPU_AU1550:
 	case CPU_AU1200:
 	case CPU_PR4450:
-		i_nop(p);
+		uasm_i_nop(p);
 		tlbw(p);
 		break;
 
@@ -912,26 +301,26 @@ static __init void build_tlb_write_entry(u32 **p, struct label **l,
 	case CPU_BCM4710:
 	case CPU_LOONGSON2:
 		if (m4kc_tlbp_war())
-			i_nop(p);
+			uasm_i_nop(p);
 		tlbw(p);
 		break;
 
 	case CPU_NEVADA:
-		i_nop(p); /* QED specifies 2 nops hazard */
+		uasm_i_nop(p); /* QED specifies 2 nops hazard */
 		/*
 		 * This branch uses up a mtc0 hazard nop slot and saves
 		 * a nop after the tlbw instruction.
 		 */
-		il_bgezl(p, r, 0, label_tlbw_hazard);
+		uasm_il_bgezl(p, r, 0, label_tlbw_hazard);
 		tlbw(p);
-		l_tlbw_hazard(l, *p);
+		uasm_l_tlbw_hazard(l, *p);
 		break;
 
 	case CPU_RM7000:
-		i_nop(p);
-		i_nop(p);
-		i_nop(p);
-		i_nop(p);
+		uasm_i_nop(p);
+		uasm_i_nop(p);
+		uasm_i_nop(p);
+		uasm_i_nop(p);
 		tlbw(p);
 		break;
 
@@ -939,7 +328,7 @@ static __init void build_tlb_write_entry(u32 **p, struct label **l,
 	case CPU_24K:
 	case CPU_34K:
 	case CPU_74K:
-		i_ehb(p);
+		uasm_i_ehb(p);
 		tlbw(p);
 		break;
 
@@ -950,15 +339,15 @@ static __init void build_tlb_write_entry(u32 **p, struct label **l,
 		 * cpu cycles and use for data translations should not occur
 		 * for 3 cpu cycles.
 		 */
-		i_ssnop(p);
-		i_ssnop(p);
-		i_ssnop(p);
-		i_ssnop(p);
+		uasm_i_ssnop(p);
+		uasm_i_ssnop(p);
+		uasm_i_ssnop(p);
+		uasm_i_ssnop(p);
 		tlbw(p);
-		i_ssnop(p);
-		i_ssnop(p);
-		i_ssnop(p);
-		i_ssnop(p);
+		uasm_i_ssnop(p);
+		uasm_i_ssnop(p);
+		uasm_i_ssnop(p);
+		uasm_i_ssnop(p);
 		break;
 
 	case CPU_VR4111:
@@ -966,18 +355,18 @@ static __init void build_tlb_write_entry(u32 **p, struct label **l,
 	case CPU_VR4122:
 	case CPU_VR4181:
 	case CPU_VR4181A:
-		i_nop(p);
-		i_nop(p);
+		uasm_i_nop(p);
+		uasm_i_nop(p);
 		tlbw(p);
-		i_nop(p);
-		i_nop(p);
+		uasm_i_nop(p);
+		uasm_i_nop(p);
 		break;
 
 	case CPU_VR4131:
 	case CPU_VR4133:
 	case CPU_R5432:
-		i_nop(p);
-		i_nop(p);
+		uasm_i_nop(p);
+		uasm_i_nop(p);
 		tlbw(p);
 		break;
 
@@ -994,7 +383,7 @@ static __init void build_tlb_write_entry(u32 **p, struct label **l,
  * TMP will be clobbered, PTR will hold the pmd entry.
  */
 static __init void
-build_get_pmde64(u32 **p, struct label **l, struct reloc **r,
+build_get_pmde64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 		 unsigned int tmp, unsigned int ptr)
 {
 	long pgdc = (long)pgd_current;
@@ -1002,52 +391,52 @@ build_get_pmde64(u32 **p, struct label **l, struct reloc **r,
 	/*
 	 * The vmalloc handling is not in the hotpath.
 	 */
-	i_dmfc0(p, tmp, C0_BADVADDR);
+	uasm_i_dmfc0(p, tmp, C0_BADVADDR);
 #ifdef MODULE_START
-	il_bltz(p, r, tmp, label_module_alloc);
+	uasm_il_bltz(p, r, tmp, label_module_alloc);
 #else
-	il_bltz(p, r, tmp, label_vmalloc);
+	uasm_il_bltz(p, r, tmp, label_vmalloc);
 #endif
-	/* No i_nop needed here, since the next insn doesn't touch TMP. */
+	/* No uasm_i_nop needed here, since the next insn doesn't touch TMP. */
 
 #ifdef CONFIG_SMP
 # ifdef  CONFIG_MIPS_MT_SMTC
 	/*
 	 * SMTC uses TCBind value as "CPU" index
 	 */
-	i_mfc0(p, ptr, C0_TCBIND);
-	i_dsrl(p, ptr, ptr, 19);
+	uasm_i_mfc0(p, ptr, C0_TCBIND);
+	uasm_i_dsrl(p, ptr, ptr, 19);
 # else
 	/*
 	 * 64 bit SMP running in XKPHYS has smp_processor_id() << 3
 	 * stored in CONTEXT.
 	 */
-	i_dmfc0(p, ptr, C0_CONTEXT);
-	i_dsrl(p, ptr, ptr, 23);
+	uasm_i_dmfc0(p, ptr, C0_CONTEXT);
+	uasm_i_dsrl(p, ptr, ptr, 23);
 #endif
-	i_LA_mostly(p, tmp, pgdc);
-	i_daddu(p, ptr, ptr, tmp);
-	i_dmfc0(p, tmp, C0_BADVADDR);
-	i_ld(p, ptr, rel_lo(pgdc), ptr);
+	UASM_i_LA_mostly(p, tmp, pgdc);
+	uasm_i_daddu(p, ptr, ptr, tmp);
+	uasm_i_dmfc0(p, tmp, C0_BADVADDR);
+	uasm_i_ld(p, ptr, uasm_rel_lo(pgdc), ptr);
 #else
-	i_LA_mostly(p, ptr, pgdc);
-	i_ld(p, ptr, rel_lo(pgdc), ptr);
+	UASM_i_LA_mostly(p, ptr, pgdc);
+	uasm_i_ld(p, ptr, uasm_rel_lo(pgdc), ptr);
 #endif
 
-	l_vmalloc_done(l, *p);
+	uasm_l_vmalloc_done(l, *p);
 
 	if (PGDIR_SHIFT - 3 < 32)		/* get pgd offset in bytes */
-		i_dsrl(p, tmp, tmp, PGDIR_SHIFT-3);
+		uasm_i_dsrl(p, tmp, tmp, PGDIR_SHIFT-3);
 	else
-		i_dsrl32(p, tmp, tmp, PGDIR_SHIFT - 3 - 32);
-
-	i_andi(p, tmp, tmp, (PTRS_PER_PGD - 1)<<3);
-	i_daddu(p, ptr, ptr, tmp); /* add in pgd offset */
-	i_dmfc0(p, tmp, C0_BADVADDR); /* get faulting address */
-	i_ld(p, ptr, 0, ptr); /* get pmd pointer */
-	i_dsrl(p, tmp, tmp, PMD_SHIFT-3); /* get pmd offset in bytes */
-	i_andi(p, tmp, tmp, (PTRS_PER_PMD - 1)<<3);
-	i_daddu(p, ptr, ptr, tmp); /* add in pmd offset */
+		uasm_i_dsrl32(p, tmp, tmp, PGDIR_SHIFT - 3 - 32);
+
+	uasm_i_andi(p, tmp, tmp, (PTRS_PER_PGD - 1)<<3);
+	uasm_i_daddu(p, ptr, ptr, tmp); /* add in pgd offset */
+	uasm_i_dmfc0(p, tmp, C0_BADVADDR); /* get faulting address */
+	uasm_i_ld(p, ptr, 0, ptr); /* get pmd pointer */
+	uasm_i_dsrl(p, tmp, tmp, PMD_SHIFT-3); /* get pmd offset in bytes */
+	uasm_i_andi(p, tmp, tmp, (PTRS_PER_PMD - 1)<<3);
+	uasm_i_daddu(p, ptr, ptr, tmp); /* add in pmd offset */
 }
 
 /*
@@ -1055,7 +444,7 @@ build_get_pmde64(u32 **p, struct label **l, struct reloc **r,
  * PTR will hold the pgd for vmalloc.
  */
 static __init void
-build_get_pgd_vmalloc64(u32 **p, struct label **l, struct reloc **r,
+build_get_pgd_vmalloc64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 			unsigned int bvaddr, unsigned int ptr)
 {
 	long swpd = (long)swapper_pg_dir;
@@ -1063,52 +452,54 @@ build_get_pgd_vmalloc64(u32 **p, struct label **l, struct reloc **r,
 #ifdef MODULE_START
 	long modd = (long)module_pg_dir;
 
-	l_module_alloc(l, *p);
+	uasm_l_module_alloc(l, *p);
 	/*
 	 * Assumption:
 	 * VMALLOC_START >= 0xc000000000000000UL
 	 * MODULE_START >= 0xe000000000000000UL
 	 */
-	i_SLL(p, ptr, bvaddr, 2);
-	il_bgez(p, r, ptr, label_vmalloc);
+	UASM_i_SLL(p, ptr, bvaddr, 2);
+	uasm_il_bgez(p, r, ptr, label_vmalloc);
 
-	if (in_compat_space_p(MODULE_START) && !rel_lo(MODULE_START)) {
-		i_lui(p, ptr, rel_hi(MODULE_START)); /* delay slot */
+	if (uasm_in_compat_space_p(MODULE_START) &&
+	    !uasm_rel_lo(MODULE_START)) {
+		uasm_i_lui(p, ptr, uasm_rel_hi(MODULE_START)); /* delay slot */
 	} else {
 		/* unlikely configuration */
-		i_nop(p); /* delay slot */
-		i_LA(p, ptr, MODULE_START);
+		uasm_i_nop(p); /* delay slot */
+		UASM_i_LA(p, ptr, MODULE_START);
 	}
-	i_dsubu(p, bvaddr, bvaddr, ptr);
+	uasm_i_dsubu(p, bvaddr, bvaddr, ptr);
 
-	if (in_compat_space_p(modd) && !rel_lo(modd)) {
-		il_b(p, r, label_vmalloc_done);
-		i_lui(p, ptr, rel_hi(modd));
+	if (uasm_in_compat_space_p(modd) && !uasm_rel_lo(modd)) {
+		uasm_il_b(p, r, label_vmalloc_done);
+		uasm_i_lui(p, ptr, uasm_rel_hi(modd));
 	} else {
-		i_LA_mostly(p, ptr, modd);
-		il_b(p, r, label_vmalloc_done);
-		i_daddiu(p, ptr, ptr, rel_lo(modd));
+		UASM_i_LA_mostly(p, ptr, modd);
+		uasm_il_b(p, r, label_vmalloc_done);
+		uasm_i_daddiu(p, ptr, ptr, uasm_rel_lo(modd));
 	}
 
-	l_vmalloc(l, *p);
-	if (in_compat_space_p(MODULE_START) && !rel_lo(MODULE_START) &&
+	uasm_l_vmalloc(l, *p);
+	if (uasm_in_compat_space_p(MODULE_START) &&
+	    !uasm_rel_lo(MODULE_START) &&
 	    MODULE_START << 32 == VMALLOC_START)
-		i_dsll32(p, ptr, ptr, 0);	/* typical case */
+		uasm_i_dsll32(p, ptr, ptr, 0);	/* typical case */
 	else
-		i_LA(p, ptr, VMALLOC_START);
+		UASM_i_LA(p, ptr, VMALLOC_START);
 #else
-	l_vmalloc(l, *p);
-	i_LA(p, ptr, VMALLOC_START);
+	uasm_l_vmalloc(l, *p);
+	UASM_i_LA(p, ptr, VMALLOC_START);
 #endif
-	i_dsubu(p, bvaddr, bvaddr, ptr);
+	uasm_i_dsubu(p, bvaddr, bvaddr, ptr);
 
-	if (in_compat_space_p(swpd) && !rel_lo(swpd)) {
-		il_b(p, r, label_vmalloc_done);
-		i_lui(p, ptr, rel_hi(swpd));
+	if (uasm_in_compat_space_p(swpd) && !uasm_rel_lo(swpd)) {
+		uasm_il_b(p, r, label_vmalloc_done);
+		uasm_i_lui(p, ptr, uasm_rel_hi(swpd));
 	} else {
-		i_LA_mostly(p, ptr, swpd);
-		il_b(p, r, label_vmalloc_done);
-		i_daddiu(p, ptr, ptr, rel_lo(swpd));
+		UASM_i_LA_mostly(p, ptr, swpd);
+		uasm_il_b(p, r, label_vmalloc_done);
+		uasm_i_daddiu(p, ptr, ptr, uasm_rel_lo(swpd));
 	}
 }
 
@@ -1129,26 +520,26 @@ build_get_pgde32(u32 **p, unsigned int tmp, unsigned int ptr)
 	/*
 	 * SMTC uses TCBind value as "CPU" index
 	 */
-	i_mfc0(p, ptr, C0_TCBIND);
-	i_LA_mostly(p, tmp, pgdc);
-	i_srl(p, ptr, ptr, 19);
+	uasm_i_mfc0(p, ptr, C0_TCBIND);
+	UASM_i_LA_mostly(p, tmp, pgdc);
+	uasm_i_srl(p, ptr, ptr, 19);
 #else
 	/*
 	 * smp_processor_id() << 3 is stored in CONTEXT.
          */
-	i_mfc0(p, ptr, C0_CONTEXT);
-	i_LA_mostly(p, tmp, pgdc);
-	i_srl(p, ptr, ptr, 23);
+	uasm_i_mfc0(p, ptr, C0_CONTEXT);
+	UASM_i_LA_mostly(p, tmp, pgdc);
+	uasm_i_srl(p, ptr, ptr, 23);
 #endif
-	i_addu(p, ptr, tmp, ptr);
+	uasm_i_addu(p, ptr, tmp, ptr);
 #else
-	i_LA_mostly(p, ptr, pgdc);
+	UASM_i_LA_mostly(p, ptr, pgdc);
 #endif
-	i_mfc0(p, tmp, C0_BADVADDR); /* get faulting address */
-	i_lw(p, ptr, rel_lo(pgdc), ptr);
-	i_srl(p, tmp, tmp, PGDIR_SHIFT); /* get pgd only bits */
-	i_sll(p, tmp, tmp, PGD_T_LOG2);
-	i_addu(p, ptr, ptr, tmp); /* add in pgd offset */
+	uasm_i_mfc0(p, tmp, C0_BADVADDR); /* get faulting address */
+	uasm_i_lw(p, ptr, uasm_rel_lo(pgdc), ptr);
+	uasm_i_srl(p, tmp, tmp, PGDIR_SHIFT); /* get pgd only bits */
+	uasm_i_sll(p, tmp, tmp, PGD_T_LOG2);
+	uasm_i_addu(p, ptr, ptr, tmp); /* add in pgd offset */
 }
 
 #endif /* !CONFIG_64BIT */
@@ -1175,8 +566,8 @@ static __init void build_adjust_context(u32 **p, unsigned int ctx)
 	}
 
 	if (shift)
-		i_SRL(p, ctx, ctx, shift);
-	i_andi(p, ctx, ctx, mask);
+		UASM_i_SRL(p, ctx, ctx, shift);
+	uasm_i_andi(p, ctx, ctx, mask);
 }
 
 static __init void build_get_ptep(u32 **p, unsigned int tmp, unsigned int ptr)
@@ -1190,18 +581,18 @@ static __init void build_get_ptep(u32 **p, unsigned int tmp, unsigned int ptr)
 	 */
 	switch (current_cpu_type()) {
 	case CPU_NEVADA:
-		i_LW(p, ptr, 0, ptr);
+		UASM_i_LW(p, ptr, 0, ptr);
 		GET_CONTEXT(p, tmp); /* get context reg */
 		break;
 
 	default:
 		GET_CONTEXT(p, tmp); /* get context reg */
-		i_LW(p, ptr, 0, ptr);
+		UASM_i_LW(p, ptr, 0, ptr);
 		break;
 	}
 
 	build_adjust_context(p, tmp);
-	i_ADDU(p, ptr, ptr, tmp); /* add in offset */
+	UASM_i_ADDU(p, ptr, ptr, tmp); /* add in offset */
 }
 
 static __init void build_update_entries(u32 **p, unsigned int tmp,
@@ -1213,45 +604,45 @@ static __init void build_update_entries(u32 **p, unsigned int tmp,
 	 */
 #ifdef CONFIG_64BIT_PHYS_ADDR
 	if (cpu_has_64bits) {
-		i_ld(p, tmp, 0, ptep); /* get even pte */
-		i_ld(p, ptep, sizeof(pte_t), ptep); /* get odd pte */
-		i_dsrl(p, tmp, tmp, 6); /* convert to entrylo0 */
-		i_mtc0(p, tmp, C0_ENTRYLO0); /* load it */
-		i_dsrl(p, ptep, ptep, 6); /* convert to entrylo1 */
-		i_mtc0(p, ptep, C0_ENTRYLO1); /* load it */
+		uasm_i_ld(p, tmp, 0, ptep); /* get even pte */
+		uasm_i_ld(p, ptep, sizeof(pte_t), ptep); /* get odd pte */
+		uasm_i_dsrl(p, tmp, tmp, 6); /* convert to entrylo0 */
+		uasm_i_mtc0(p, tmp, C0_ENTRYLO0); /* load it */
+		uasm_i_dsrl(p, ptep, ptep, 6); /* convert to entrylo1 */
+		uasm_i_mtc0(p, ptep, C0_ENTRYLO1); /* load it */
 	} else {
 		int pte_off_even = sizeof(pte_t) / 2;
 		int pte_off_odd = pte_off_even + sizeof(pte_t);
 
 		/* The pte entries are pre-shifted */
-		i_lw(p, tmp, pte_off_even, ptep); /* get even pte */
-		i_mtc0(p, tmp, C0_ENTRYLO0); /* load it */
-		i_lw(p, ptep, pte_off_odd, ptep); /* get odd pte */
-		i_mtc0(p, ptep, C0_ENTRYLO1); /* load it */
+		uasm_i_lw(p, tmp, pte_off_even, ptep); /* get even pte */
+		uasm_i_mtc0(p, tmp, C0_ENTRYLO0); /* load it */
+		uasm_i_lw(p, ptep, pte_off_odd, ptep); /* get odd pte */
+		uasm_i_mtc0(p, ptep, C0_ENTRYLO1); /* load it */
 	}
 #else
-	i_LW(p, tmp, 0, ptep); /* get even pte */
-	i_LW(p, ptep, sizeof(pte_t), ptep); /* get odd pte */
+	UASM_i_LW(p, tmp, 0, ptep); /* get even pte */
+	UASM_i_LW(p, ptep, sizeof(pte_t), ptep); /* get odd pte */
 	if (r45k_bvahwbug())
 		build_tlb_probe_entry(p);
-	i_SRL(p, tmp, tmp, 6); /* convert to entrylo0 */
+	UASM_i_SRL(p, tmp, tmp, 6); /* convert to entrylo0 */
 	if (r4k_250MHZhwbug())
-		i_mtc0(p, 0, C0_ENTRYLO0);
-	i_mtc0(p, tmp, C0_ENTRYLO0); /* load it */
-	i_SRL(p, ptep, ptep, 6); /* convert to entrylo1 */
+		uasm_i_mtc0(p, 0, C0_ENTRYLO0);
+	uasm_i_mtc0(p, tmp, C0_ENTRYLO0); /* load it */
+	UASM_i_SRL(p, ptep, ptep, 6); /* convert to entrylo1 */
 	if (r45k_bvahwbug())
-		i_mfc0(p, tmp, C0_INDEX);
+		uasm_i_mfc0(p, tmp, C0_INDEX);
 	if (r4k_250MHZhwbug())
-		i_mtc0(p, 0, C0_ENTRYLO1);
-	i_mtc0(p, ptep, C0_ENTRYLO1); /* load it */
+		uasm_i_mtc0(p, 0, C0_ENTRYLO1);
+	uasm_i_mtc0(p, ptep, C0_ENTRYLO1); /* load it */
 #endif
 }
 
 static void __init build_r4000_tlb_refill_handler(void)
 {
 	u32 *p = tlb_handler;
-	struct label *l = labels;
-	struct reloc *r = relocs;
+	struct uasm_label *l = labels;
+	struct uasm_reloc *r = relocs;
 	u32 *f;
 	unsigned int final_len;
 	int i;
@@ -1265,12 +656,12 @@ static void __init build_r4000_tlb_refill_handler(void)
 	 * create the plain linear handler
 	 */
 	if (bcm1250_m3_war()) {
-		i_MFC0(&p, K0, C0_BADVADDR);
-		i_MFC0(&p, K1, C0_ENTRYHI);
-		i_xor(&p, K0, K0, K1);
-		i_SRL(&p, K0, K0, PAGE_SHIFT + 1);
-		il_bnez(&p, &r, K0, label_leave);
-		/* No need for i_nop */
+		UASM_i_MFC0(&p, K0, C0_BADVADDR);
+		UASM_i_MFC0(&p, K1, C0_ENTRYHI);
+		uasm_i_xor(&p, K0, K0, K1);
+		UASM_i_SRL(&p, K0, K0, PAGE_SHIFT + 1);
+		uasm_il_bnez(&p, &r, K0, label_leave);
+		/* No need for uasm_i_nop */
 	}
 
 #ifdef CONFIG_64BIT
@@ -1282,8 +673,8 @@ static void __init build_r4000_tlb_refill_handler(void)
 	build_get_ptep(&p, K0, K1);
 	build_update_entries(&p, K0, K1);
 	build_tlb_write_entry(&p, &l, &r, tlb_random);
-	l_leave(&l, p);
-	i_eret(&p); /* return from trap */
+	uasm_l_leave(&l, p);
+	uasm_i_eret(&p); /* return from trap */
 
 #ifdef CONFIG_64BIT
 	build_get_pgd_vmalloc64(&p, &l, &r, K0, K1);
@@ -1303,7 +694,7 @@ static void __init build_r4000_tlb_refill_handler(void)
 #else
 	if (((p - tlb_handler) > 63)
 	    || (((p - tlb_handler) > 61)
-		&& insn_has_bdelay(relocs, tlb_handler + 29)))
+		&& uasm_insn_has_bdelay(relocs, tlb_handler + 29)))
 		panic("TLB refill handler space exceeded");
 #endif
 
@@ -1313,13 +704,13 @@ static void __init build_r4000_tlb_refill_handler(void)
 #if defined(CONFIG_32BIT) || defined(CONFIG_CPU_LOONGSON2)
 	f = final_handler;
 	/* Simplest case, just copy the handler. */
-	copy_handler(relocs, labels, tlb_handler, p, f);
+	uasm_copy_handler(relocs, labels, tlb_handler, p, f);
 	final_len = p - tlb_handler;
 #else /* CONFIG_64BIT */
 	f = final_handler + 32;
 	if ((p - tlb_handler) <= 32) {
 		/* Just copy the handler. */
-		copy_handler(relocs, labels, tlb_handler, p, f);
+		uasm_copy_handler(relocs, labels, tlb_handler, p, f);
 		final_len = p - tlb_handler;
 	} else {
 		u32 *split = tlb_handler + 30;
@@ -1327,34 +718,34 @@ static void __init build_r4000_tlb_refill_handler(void)
 		/*
 		 * Find the split point.
 		 */
-		if (insn_has_bdelay(relocs, split - 1))
+		if (uasm_insn_has_bdelay(relocs, split - 1))
 			split--;
 
 		/* Copy first part of the handler. */
-		copy_handler(relocs, labels, tlb_handler, split, f);
+		uasm_copy_handler(relocs, labels, tlb_handler, split, f);
 		f += split - tlb_handler;
 
 		/* Insert branch. */
-		l_split(&l, final_handler);
-		il_b(&f, &r, label_split);
-		if (insn_has_bdelay(relocs, split))
-			i_nop(&f);
+		uasm_l_split(&l, final_handler);
+		uasm_il_b(&f, &r, label_split);
+		if (uasm_insn_has_bdelay(relocs, split))
+			uasm_i_nop(&f);
 		else {
-			copy_handler(relocs, labels, split, split + 1, f);
-			move_labels(labels, f, f + 1, -1);
+			uasm_copy_handler(relocs, labels, split, split + 1, f);
+			uasm_move_labels(labels, f, f + 1, -1);
 			f++;
 			split++;
 		}
 
 		/* Copy the rest of the handler. */
-		copy_handler(relocs, labels, split, p, final_handler);
+		uasm_copy_handler(relocs, labels, split, p, final_handler);
 		final_len = (f - (final_handler + 32)) + (p - split);
 	}
 #endif /* CONFIG_64BIT */
 
-	resolve_relocs(relocs, labels);
-	pr_info("Synthesized TLB refill handler (%u instructions).\n",
-		final_len);
+	uasm_resolve_relocs(relocs, labels);
+	pr_debug("Wrote TLB refill handler (%u instructions).\n",
+		 final_len);
 
 	f = final_handler;
 #if defined(CONFIG_64BIT) && !defined(CONFIG_CPU_LOONGSON2)
@@ -1395,75 +786,75 @@ u32 __tlb_handler_align handle_tlbs[FASTPATH_SIZE];
 u32 __tlb_handler_align handle_tlbm[FASTPATH_SIZE];
 
 static void __init
-iPTE_LW(u32 **p, struct label **l, unsigned int pte, unsigned int ptr)
+iPTE_LW(u32 **p, struct uasm_label **l, unsigned int pte, unsigned int ptr)
 {
 #ifdef CONFIG_SMP
 # ifdef CONFIG_64BIT_PHYS_ADDR
 	if (cpu_has_64bits)
-		i_lld(p, pte, 0, ptr);
+		uasm_i_lld(p, pte, 0, ptr);
 	else
 # endif
-		i_LL(p, pte, 0, ptr);
+		UASM_i_LL(p, pte, 0, ptr);
 #else
 # ifdef CONFIG_64BIT_PHYS_ADDR
 	if (cpu_has_64bits)
-		i_ld(p, pte, 0, ptr);
+		uasm_i_ld(p, pte, 0, ptr);
 	else
 # endif
-		i_LW(p, pte, 0, ptr);
+		UASM_i_LW(p, pte, 0, ptr);
 #endif
 }
 
 static void __init
-iPTE_SW(u32 **p, struct reloc **r, unsigned int pte, unsigned int ptr,
+iPTE_SW(u32 **p, struct uasm_reloc **r, unsigned int pte, unsigned int ptr,
 	unsigned int mode)
 {
 #ifdef CONFIG_64BIT_PHYS_ADDR
 	unsigned int hwmode = mode & (_PAGE_VALID | _PAGE_DIRTY);
 #endif
 
-	i_ori(p, pte, pte, mode);
+	uasm_i_ori(p, pte, pte, mode);
 #ifdef CONFIG_SMP
 # ifdef CONFIG_64BIT_PHYS_ADDR
 	if (cpu_has_64bits)
-		i_scd(p, pte, 0, ptr);
+		uasm_i_scd(p, pte, 0, ptr);
 	else
 # endif
-		i_SC(p, pte, 0, ptr);
+		UASM_i_SC(p, pte, 0, ptr);
 
 	if (r10000_llsc_war())
-		il_beqzl(p, r, pte, label_smp_pgtable_change);
+		uasm_il_beqzl(p, r, pte, label_smp_pgtable_change);
 	else
-		il_beqz(p, r, pte, label_smp_pgtable_change);
+		uasm_il_beqz(p, r, pte, label_smp_pgtable_change);
 
 # ifdef CONFIG_64BIT_PHYS_ADDR
 	if (!cpu_has_64bits) {
-		/* no i_nop needed */
-		i_ll(p, pte, sizeof(pte_t) / 2, ptr);
-		i_ori(p, pte, pte, hwmode);
-		i_sc(p, pte, sizeof(pte_t) / 2, ptr);
-		il_beqz(p, r, pte, label_smp_pgtable_change);
-		/* no i_nop needed */
-		i_lw(p, pte, 0, ptr);
+		/* no uasm_i_nop needed */
+		uasm_i_ll(p, pte, sizeof(pte_t) / 2, ptr);
+		uasm_i_ori(p, pte, pte, hwmode);
+		uasm_i_sc(p, pte, sizeof(pte_t) / 2, ptr);
+		uasm_il_beqz(p, r, pte, label_smp_pgtable_change);
+		/* no uasm_i_nop needed */
+		uasm_i_lw(p, pte, 0, ptr);
 	} else
-		i_nop(p);
+		uasm_i_nop(p);
 # else
-	i_nop(p);
+	uasm_i_nop(p);
 # endif
 #else
 # ifdef CONFIG_64BIT_PHYS_ADDR
 	if (cpu_has_64bits)
-		i_sd(p, pte, 0, ptr);
+		uasm_i_sd(p, pte, 0, ptr);
 	else
 # endif
-		i_SW(p, pte, 0, ptr);
+		UASM_i_SW(p, pte, 0, ptr);
 
 # ifdef CONFIG_64BIT_PHYS_ADDR
 	if (!cpu_has_64bits) {
-		i_lw(p, pte, sizeof(pte_t) / 2, ptr);
-		i_ori(p, pte, pte, hwmode);
-		i_sw(p, pte, sizeof(pte_t) / 2, ptr);
-		i_lw(p, pte, 0, ptr);
+		uasm_i_lw(p, pte, sizeof(pte_t) / 2, ptr);
+		uasm_i_ori(p, pte, pte, hwmode);
+		uasm_i_sw(p, pte, sizeof(pte_t) / 2, ptr);
+		uasm_i_lw(p, pte, 0, ptr);
 	}
 # endif
 #endif
@@ -1475,18 +866,18 @@ iPTE_SW(u32 **p, struct reloc **r, unsigned int pte, unsigned int ptr,
  * with it's original value.
  */
 static void __init
-build_pte_present(u32 **p, struct label **l, struct reloc **r,
+build_pte_present(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 		  unsigned int pte, unsigned int ptr, enum label_id lid)
 {
-	i_andi(p, pte, pte, _PAGE_PRESENT | _PAGE_READ);
-	i_xori(p, pte, pte, _PAGE_PRESENT | _PAGE_READ);
-	il_bnez(p, r, pte, lid);
+	uasm_i_andi(p, pte, pte, _PAGE_PRESENT | _PAGE_READ);
+	uasm_i_xori(p, pte, pte, _PAGE_PRESENT | _PAGE_READ);
+	uasm_il_bnez(p, r, pte, lid);
 	iPTE_LW(p, l, pte, ptr);
 }
 
 /* Make PTE valid, store result in PTR. */
 static void __init
-build_make_valid(u32 **p, struct reloc **r, unsigned int pte,
+build_make_valid(u32 **p, struct uasm_reloc **r, unsigned int pte,
 		 unsigned int ptr)
 {
 	unsigned int mode = _PAGE_VALID | _PAGE_ACCESSED;
@@ -1499,12 +890,12 @@ build_make_valid(u32 **p, struct reloc **r, unsigned int pte,
  * restore PTE with value from PTR when done.
  */
 static void __init
-build_pte_writable(u32 **p, struct label **l, struct reloc **r,
+build_pte_writable(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 		   unsigned int pte, unsigned int ptr, enum label_id lid)
 {
-	i_andi(p, pte, pte, _PAGE_PRESENT | _PAGE_WRITE);
-	i_xori(p, pte, pte, _PAGE_PRESENT | _PAGE_WRITE);
-	il_bnez(p, r, pte, lid);
+	uasm_i_andi(p, pte, pte, _PAGE_PRESENT | _PAGE_WRITE);
+	uasm_i_xori(p, pte, pte, _PAGE_PRESENT | _PAGE_WRITE);
+	uasm_il_bnez(p, r, pte, lid);
 	iPTE_LW(p, l, pte, ptr);
 }
 
@@ -1512,7 +903,7 @@ build_pte_writable(u32 **p, struct label **l, struct reloc **r,
  * at PTR.
  */
 static void __init
-build_make_write(u32 **p, struct reloc **r, unsigned int pte,
+build_make_write(u32 **p, struct uasm_reloc **r, unsigned int pte,
 		 unsigned int ptr)
 {
 	unsigned int mode = (_PAGE_ACCESSED | _PAGE_MODIFIED | _PAGE_VALID
@@ -1526,11 +917,11 @@ build_make_write(u32 **p, struct reloc **r, unsigned int pte,
  * restore PTE with value from PTR when done.
  */
 static void __init
-build_pte_modifiable(u32 **p, struct label **l, struct reloc **r,
+build_pte_modifiable(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 		     unsigned int pte, unsigned int ptr, enum label_id lid)
 {
-	i_andi(p, pte, pte, _PAGE_WRITE);
-	il_beqz(p, r, pte, lid);
+	uasm_i_andi(p, pte, pte, _PAGE_WRITE);
+	uasm_il_beqz(p, r, pte, lid);
 	iPTE_LW(p, l, pte, ptr);
 }
 
@@ -1545,11 +936,11 @@ build_pte_modifiable(u32 **p, struct label **l, struct reloc **r,
 static void __init
 build_r3000_pte_reload_tlbwi(u32 **p, unsigned int pte, unsigned int tmp)
 {
-	i_mtc0(p, pte, C0_ENTRYLO0); /* cp0 delay */
-	i_mfc0(p, tmp, C0_EPC); /* cp0 delay */
-	i_tlbwi(p);
-	i_jr(p, tmp);
-	i_rfe(p); /* branch delay */
+	uasm_i_mtc0(p, pte, C0_ENTRYLO0); /* cp0 delay */
+	uasm_i_mfc0(p, tmp, C0_EPC); /* cp0 delay */
+	uasm_i_tlbwi(p);
+	uasm_i_jr(p, tmp);
+	uasm_i_rfe(p); /* branch delay */
 }
 
 /*
@@ -1559,20 +950,21 @@ build_r3000_pte_reload_tlbwi(u32 **p, unsigned int pte, unsigned int tmp)
  * kseg2 access, i.e. without refill.  Then it returns.
  */
 static void __init
-build_r3000_tlb_reload_write(u32 **p, struct label **l, struct reloc **r,
-			     unsigned int pte, unsigned int tmp)
-{
-	i_mfc0(p, tmp, C0_INDEX);
-	i_mtc0(p, pte, C0_ENTRYLO0); /* cp0 delay */
-	il_bltz(p, r, tmp, label_r3000_write_probe_fail); /* cp0 delay */
-	i_mfc0(p, tmp, C0_EPC); /* branch delay */
-	i_tlbwi(p); /* cp0 delay */
-	i_jr(p, tmp);
-	i_rfe(p); /* branch delay */
-	l_r3000_write_probe_fail(l, *p);
-	i_tlbwr(p); /* cp0 delay */
-	i_jr(p, tmp);
-	i_rfe(p); /* branch delay */
+build_r3000_tlb_reload_write(u32 **p, struct uasm_label **l,
+			     struct uasm_reloc **r, unsigned int pte,
+			     unsigned int tmp)
+{
+	uasm_i_mfc0(p, tmp, C0_INDEX);
+	uasm_i_mtc0(p, pte, C0_ENTRYLO0); /* cp0 delay */
+	uasm_il_bltz(p, r, tmp, label_r3000_write_probe_fail); /* cp0 delay */
+	uasm_i_mfc0(p, tmp, C0_EPC); /* branch delay */
+	uasm_i_tlbwi(p); /* cp0 delay */
+	uasm_i_jr(p, tmp);
+	uasm_i_rfe(p); /* branch delay */
+	uasm_l_r3000_write_probe_fail(l, *p);
+	uasm_i_tlbwr(p); /* cp0 delay */
+	uasm_i_jr(p, tmp);
+	uasm_i_rfe(p); /* branch delay */
 }
 
 static void __init
@@ -1581,25 +973,25 @@ build_r3000_tlbchange_handler_head(u32 **p, unsigned int pte,
 {
 	long pgdc = (long)pgd_current;
 
-	i_mfc0(p, pte, C0_BADVADDR);
-	i_lui(p, ptr, rel_hi(pgdc)); /* cp0 delay */
-	i_lw(p, ptr, rel_lo(pgdc), ptr);
-	i_srl(p, pte, pte, 22); /* load delay */
-	i_sll(p, pte, pte, 2);
-	i_addu(p, ptr, ptr, pte);
-	i_mfc0(p, pte, C0_CONTEXT);
-	i_lw(p, ptr, 0, ptr); /* cp0 delay */
-	i_andi(p, pte, pte, 0xffc); /* load delay */
-	i_addu(p, ptr, ptr, pte);
-	i_lw(p, pte, 0, ptr);
-	i_tlbp(p); /* load delay */
+	uasm_i_mfc0(p, pte, C0_BADVADDR);
+	uasm_i_lui(p, ptr, uasm_rel_hi(pgdc)); /* cp0 delay */
+	uasm_i_lw(p, ptr, uasm_rel_lo(pgdc), ptr);
+	uasm_i_srl(p, pte, pte, 22); /* load delay */
+	uasm_i_sll(p, pte, pte, 2);
+	uasm_i_addu(p, ptr, ptr, pte);
+	uasm_i_mfc0(p, pte, C0_CONTEXT);
+	uasm_i_lw(p, ptr, 0, ptr); /* cp0 delay */
+	uasm_i_andi(p, pte, pte, 0xffc); /* load delay */
+	uasm_i_addu(p, ptr, ptr, pte);
+	uasm_i_lw(p, pte, 0, ptr);
+	uasm_i_tlbp(p); /* load delay */
 }
 
 static void __init build_r3000_tlb_load_handler(void)
 {
 	u32 *p = handle_tlbl;
-	struct label *l = labels;
-	struct reloc *r = relocs;
+	struct uasm_label *l = labels;
+	struct uasm_reloc *r = relocs;
 	int i;
 
 	memset(handle_tlbl, 0, sizeof(handle_tlbl));
@@ -1608,20 +1000,20 @@ static void __init build_r3000_tlb_load_handler(void)
 
 	build_r3000_tlbchange_handler_head(&p, K0, K1);
 	build_pte_present(&p, &l, &r, K0, K1, label_nopage_tlbl);
-	i_nop(&p); /* load delay */
+	uasm_i_nop(&p); /* load delay */
 	build_make_valid(&p, &r, K0, K1);
 	build_r3000_tlb_reload_write(&p, &l, &r, K0, K1);
 
-	l_nopage_tlbl(&l, p);
-	i_j(&p, (unsigned long)tlb_do_page_fault_0 & 0x0fffffff);
-	i_nop(&p);
+	uasm_l_nopage_tlbl(&l, p);
+	uasm_i_j(&p, (unsigned long)tlb_do_page_fault_0 & 0x0fffffff);
+	uasm_i_nop(&p);
 
 	if ((p - handle_tlbl) > FASTPATH_SIZE)
 		panic("TLB load handler fastpath space exceeded");
 
-	resolve_relocs(relocs, labels);
-	pr_info("Synthesized TLB load handler fastpath (%u instructions).\n",
-		(unsigned int)(p - handle_tlbl));
+	uasm_resolve_relocs(relocs, labels);
+	pr_debug("Wrote TLB load handler fastpath (%u instructions).\n",
+		 (unsigned int)(p - handle_tlbl));
 
 	pr_debug("\t.set push\n");
 	pr_debug("\t.set noreorder\n");
@@ -1633,8 +1025,8 @@ static void __init build_r3000_tlb_load_handler(void)
 static void __init build_r3000_tlb_store_handler(void)
 {
 	u32 *p = handle_tlbs;
-	struct label *l = labels;
-	struct reloc *r = relocs;
+	struct uasm_label *l = labels;
+	struct uasm_reloc *r = relocs;
 	int i;
 
 	memset(handle_tlbs, 0, sizeof(handle_tlbs));
@@ -1643,20 +1035,20 @@ static void __init build_r3000_tlb_store_handler(void)
 
 	build_r3000_tlbchange_handler_head(&p, K0, K1);
 	build_pte_writable(&p, &l, &r, K0, K1, label_nopage_tlbs);
-	i_nop(&p); /* load delay */
+	uasm_i_nop(&p); /* load delay */
 	build_make_write(&p, &r, K0, K1);
 	build_r3000_tlb_reload_write(&p, &l, &r, K0, K1);
 
-	l_nopage_tlbs(&l, p);
-	i_j(&p, (unsigned long)tlb_do_page_fault_1 & 0x0fffffff);
-	i_nop(&p);
+	uasm_l_nopage_tlbs(&l, p);
+	uasm_i_j(&p, (unsigned long)tlb_do_page_fault_1 & 0x0fffffff);
+	uasm_i_nop(&p);
 
 	if ((p - handle_tlbs) > FASTPATH_SIZE)
 		panic("TLB store handler fastpath space exceeded");
 
-	resolve_relocs(relocs, labels);
-	pr_info("Synthesized TLB store handler fastpath (%u instructions).\n",
-		(unsigned int)(p - handle_tlbs));
+	uasm_resolve_relocs(relocs, labels);
+	pr_debug("Wrote TLB store handler fastpath (%u instructions).\n",
+		 (unsigned int)(p - handle_tlbs));
 
 	pr_debug("\t.set push\n");
 	pr_debug("\t.set noreorder\n");
@@ -1668,8 +1060,8 @@ static void __init build_r3000_tlb_store_handler(void)
 static void __init build_r3000_tlb_modify_handler(void)
 {
 	u32 *p = handle_tlbm;
-	struct label *l = labels;
-	struct reloc *r = relocs;
+	struct uasm_label *l = labels;
+	struct uasm_reloc *r = relocs;
 	int i;
 
 	memset(handle_tlbm, 0, sizeof(handle_tlbm));
@@ -1678,20 +1070,20 @@ static void __init build_r3000_tlb_modify_handler(void)
 
 	build_r3000_tlbchange_handler_head(&p, K0, K1);
 	build_pte_modifiable(&p, &l, &r, K0, K1, label_nopage_tlbm);
-	i_nop(&p); /* load delay */
+	uasm_i_nop(&p); /* load delay */
 	build_make_write(&p, &r, K0, K1);
 	build_r3000_pte_reload_tlbwi(&p, K0, K1);
 
-	l_nopage_tlbm(&l, p);
-	i_j(&p, (unsigned long)tlb_do_page_fault_1 & 0x0fffffff);
-	i_nop(&p);
+	uasm_l_nopage_tlbm(&l, p);
+	uasm_i_j(&p, (unsigned long)tlb_do_page_fault_1 & 0x0fffffff);
+	uasm_i_nop(&p);
 
 	if ((p - handle_tlbm) > FASTPATH_SIZE)
 		panic("TLB modify handler fastpath space exceeded");
 
-	resolve_relocs(relocs, labels);
-	pr_info("Synthesized TLB modify handler fastpath (%u instructions).\n",
-		(unsigned int)(p - handle_tlbm));
+	uasm_resolve_relocs(relocs, labels);
+	pr_debug("Wrote TLB modify handler fastpath (%u instructions).\n",
+		 (unsigned int)(p - handle_tlbm));
 
 	pr_debug("\t.set push\n");
 	pr_debug("\t.set noreorder\n");
@@ -1704,8 +1096,8 @@ static void __init build_r3000_tlb_modify_handler(void)
  * R4000 style TLB load/store/modify handlers.
  */
 static void __init
-build_r4000_tlbchange_handler_head(u32 **p, struct label **l,
-				   struct reloc **r, unsigned int pte,
+build_r4000_tlbchange_handler_head(u32 **p, struct uasm_label **l,
+				   struct uasm_reloc **r, unsigned int pte,
 				   unsigned int ptr)
 {
 #ifdef CONFIG_64BIT
@@ -1714,14 +1106,14 @@ build_r4000_tlbchange_handler_head(u32 **p, struct label **l,
 	build_get_pgde32(p, pte, ptr); /* get pgd in ptr */
 #endif
 
-	i_MFC0(p, pte, C0_BADVADDR);
-	i_LW(p, ptr, 0, ptr);
-	i_SRL(p, pte, pte, PAGE_SHIFT + PTE_ORDER - PTE_T_LOG2);
-	i_andi(p, pte, pte, (PTRS_PER_PTE - 1) << PTE_T_LOG2);
-	i_ADDU(p, ptr, ptr, pte);
+	UASM_i_MFC0(p, pte, C0_BADVADDR);
+	UASM_i_LW(p, ptr, 0, ptr);
+	UASM_i_SRL(p, pte, pte, PAGE_SHIFT + PTE_ORDER - PTE_T_LOG2);
+	uasm_i_andi(p, pte, pte, (PTRS_PER_PTE - 1) << PTE_T_LOG2);
+	UASM_i_ADDU(p, ptr, ptr, pte);
 
 #ifdef CONFIG_SMP
-	l_smp_pgtable_change(l, *p);
+	uasm_l_smp_pgtable_change(l, *p);
 # endif
 	iPTE_LW(p, l, pte, ptr); /* get even pte */
 	if (!m4kc_tlbp_war())
@@ -1729,16 +1121,16 @@ build_r4000_tlbchange_handler_head(u32 **p, struct label **l,
 }
 
 static void __init
-build_r4000_tlbchange_handler_tail(u32 **p, struct label **l,
-				   struct reloc **r, unsigned int tmp,
+build_r4000_tlbchange_handler_tail(u32 **p, struct uasm_label **l,
+				   struct uasm_reloc **r, unsigned int tmp,
 				   unsigned int ptr)
 {
-	i_ori(p, ptr, ptr, sizeof(pte_t));
-	i_xori(p, ptr, ptr, sizeof(pte_t));
+	uasm_i_ori(p, ptr, ptr, sizeof(pte_t));
+	uasm_i_xori(p, ptr, ptr, sizeof(pte_t));
 	build_update_entries(p, tmp, ptr);
 	build_tlb_write_entry(p, l, r, tlb_indexed);
-	l_leave(l, *p);
-	i_eret(p); /* return from trap */
+	uasm_l_leave(l, *p);
+	uasm_i_eret(p); /* return from trap */
 
 #ifdef CONFIG_64BIT
 	build_get_pgd_vmalloc64(p, l, r, tmp, ptr);
@@ -1748,8 +1140,8 @@ build_r4000_tlbchange_handler_tail(u32 **p, struct label **l,
 static void __init build_r4000_tlb_load_handler(void)
 {
 	u32 *p = handle_tlbl;
-	struct label *l = labels;
-	struct reloc *r = relocs;
+	struct uasm_label *l = labels;
+	struct uasm_reloc *r = relocs;
 	int i;
 
 	memset(handle_tlbl, 0, sizeof(handle_tlbl));
@@ -1757,12 +1149,12 @@ static void __init build_r4000_tlb_load_handler(void)
 	memset(relocs, 0, sizeof(relocs));
 
 	if (bcm1250_m3_war()) {
-		i_MFC0(&p, K0, C0_BADVADDR);
-		i_MFC0(&p, K1, C0_ENTRYHI);
-		i_xor(&p, K0, K0, K1);
-		i_SRL(&p, K0, K0, PAGE_SHIFT + 1);
-		il_bnez(&p, &r, K0, label_leave);
-		/* No need for i_nop */
+		UASM_i_MFC0(&p, K0, C0_BADVADDR);
+		UASM_i_MFC0(&p, K1, C0_ENTRYHI);
+		uasm_i_xor(&p, K0, K0, K1);
+		UASM_i_SRL(&p, K0, K0, PAGE_SHIFT + 1);
+		uasm_il_bnez(&p, &r, K0, label_leave);
+		/* No need for uasm_i_nop */
 	}
 
 	build_r4000_tlbchange_handler_head(&p, &l, &r, K0, K1);
@@ -1772,16 +1164,16 @@ static void __init build_r4000_tlb_load_handler(void)
 	build_make_valid(&p, &r, K0, K1);
 	build_r4000_tlbchange_handler_tail(&p, &l, &r, K0, K1);
 
-	l_nopage_tlbl(&l, p);
-	i_j(&p, (unsigned long)tlb_do_page_fault_0 & 0x0fffffff);
-	i_nop(&p);
+	uasm_l_nopage_tlbl(&l, p);
+	uasm_i_j(&p, (unsigned long)tlb_do_page_fault_0 & 0x0fffffff);
+	uasm_i_nop(&p);
 
 	if ((p - handle_tlbl) > FASTPATH_SIZE)
 		panic("TLB load handler fastpath space exceeded");
 
-	resolve_relocs(relocs, labels);
-	pr_info("Synthesized TLB load handler fastpath (%u instructions).\n",
-		(unsigned int)(p - handle_tlbl));
+	uasm_resolve_relocs(relocs, labels);
+	pr_debug("Wrote TLB load handler fastpath (%u instructions).\n",
+		 (unsigned int)(p - handle_tlbl));
 
 	pr_debug("\t.set push\n");
 	pr_debug("\t.set noreorder\n");
@@ -1793,8 +1185,8 @@ static void __init build_r4000_tlb_load_handler(void)
 static void __init build_r4000_tlb_store_handler(void)
 {
 	u32 *p = handle_tlbs;
-	struct label *l = labels;
-	struct reloc *r = relocs;
+	struct uasm_label *l = labels;
+	struct uasm_reloc *r = relocs;
 	int i;
 
 	memset(handle_tlbs, 0, sizeof(handle_tlbs));
@@ -1808,16 +1200,16 @@ static void __init build_r4000_tlb_store_handler(void)
 	build_make_write(&p, &r, K0, K1);
 	build_r4000_tlbchange_handler_tail(&p, &l, &r, K0, K1);
 
-	l_nopage_tlbs(&l, p);
-	i_j(&p, (unsigned long)tlb_do_page_fault_1 & 0x0fffffff);
-	i_nop(&p);
+	uasm_l_nopage_tlbs(&l, p);
+	uasm_i_j(&p, (unsigned long)tlb_do_page_fault_1 & 0x0fffffff);
+	uasm_i_nop(&p);
 
 	if ((p - handle_tlbs) > FASTPATH_SIZE)
 		panic("TLB store handler fastpath space exceeded");
 
-	resolve_relocs(relocs, labels);
-	pr_info("Synthesized TLB store handler fastpath (%u instructions).\n",
-		(unsigned int)(p - handle_tlbs));
+	uasm_resolve_relocs(relocs, labels);
+	pr_debug("Wrote TLB store handler fastpath (%u instructions).\n",
+		 (unsigned int)(p - handle_tlbs));
 
 	pr_debug("\t.set push\n");
 	pr_debug("\t.set noreorder\n");
@@ -1829,8 +1221,8 @@ static void __init build_r4000_tlb_store_handler(void)
 static void __init build_r4000_tlb_modify_handler(void)
 {
 	u32 *p = handle_tlbm;
-	struct label *l = labels;
-	struct reloc *r = relocs;
+	struct uasm_label *l = labels;
+	struct uasm_reloc *r = relocs;
 	int i;
 
 	memset(handle_tlbm, 0, sizeof(handle_tlbm));
@@ -1845,16 +1237,16 @@ static void __init build_r4000_tlb_modify_handler(void)
 	build_make_write(&p, &r, K0, K1);
 	build_r4000_tlbchange_handler_tail(&p, &l, &r, K0, K1);
 
-	l_nopage_tlbm(&l, p);
-	i_j(&p, (unsigned long)tlb_do_page_fault_1 & 0x0fffffff);
-	i_nop(&p);
+	uasm_l_nopage_tlbm(&l, p);
+	uasm_i_j(&p, (unsigned long)tlb_do_page_fault_1 & 0x0fffffff);
+	uasm_i_nop(&p);
 
 	if ((p - handle_tlbm) > FASTPATH_SIZE)
 		panic("TLB modify handler fastpath space exceeded");
 
-	resolve_relocs(relocs, labels);
-	pr_info("Synthesized TLB modify handler fastpath (%u instructions).\n",
-		(unsigned int)(p - handle_tlbm));
+	uasm_resolve_relocs(relocs, labels);
+	pr_debug("Wrote TLB modify handler fastpath (%u instructions).\n",
+		 (unsigned int)(p - handle_tlbm));
 
 	pr_debug("\t.set push\n");
 	pr_debug("\t.set noreorder\n");
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
new file mode 100644
index 0000000..889176a
--- /dev/null
+++ b/arch/mips/mm/uasm.c
@@ -0,0 +1,566 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * A small micro-assembler. It is intentionally kept simple, does only
+ * support a subset of instructions, and does not try to hide pipeline
+ * effects like branch delay slots.
+ *
+ * Copyright (C) 2004,2005,2006,2008  Thiemo Seufer
+ * Copyright (C) 2005  Maciej W. Rozycki
+ * Copyright (C) 2006  Ralf Baechle (ralf@linux-mips.org)
+ */
+
+#include <stdarg.h>
+
+#include <linux/mm.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/init.h>
+
+#include <asm/inst.h>
+#include <asm/elf.h>
+
+#include "uasm.h"
+
+enum fields {
+	RS = 0x001,
+	RT = 0x002,
+	RD = 0x004,
+	RE = 0x008,
+	SIMM = 0x010,
+	UIMM = 0x020,
+	BIMM = 0x040,
+	JIMM = 0x080,
+	FUNC = 0x100,
+	SET = 0x200
+};
+
+#define OP_MASK		0x3f
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
+#define FUNC_MASK	0x3f
+#define FUNC_SH		0
+#define SET_MASK	0x7
+#define SET_SH		0
+
+enum opcode {
+	insn_invalid,
+	insn_addu, insn_addiu, insn_and, insn_andi, insn_beq,
+	insn_beql, insn_bgez, insn_bgezl, insn_bltz, insn_bltzl,
+	insn_bne, insn_daddu, insn_daddiu, insn_dmfc0, insn_dmtc0,
+	insn_dsll, insn_dsll32, insn_dsra, insn_dsrl, insn_dsrl32,
+	insn_dsubu, insn_eret, insn_j, insn_jal, insn_jr, insn_ld,
+	insn_ll, insn_lld, insn_lui, insn_lw, insn_mfc0, insn_mtc0,
+	insn_ori, insn_rfe, insn_sc, insn_scd, insn_sd, insn_sll,
+	insn_sra, insn_srl, insn_subu, insn_sw, insn_tlbp, insn_tlbwi,
+	insn_tlbwr, insn_xor, insn_xori
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
+	{ insn_addiu, M(addiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM },
+	{ insn_addu, M(spec_op, 0, 0, 0, 0, addu_op), RS | RT | RD },
+	{ insn_and, M(spec_op, 0, 0, 0, 0, and_op), RS | RT | RD },
+	{ insn_andi, M(andi_op, 0, 0, 0, 0, 0), RS | RT | UIMM },
+	{ insn_beq, M(beq_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
+	{ insn_beql, M(beql_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
+	{ insn_bgez, M(bcond_op, 0, bgez_op, 0, 0, 0), RS | BIMM },
+	{ insn_bgezl, M(bcond_op, 0, bgezl_op, 0, 0, 0), RS | BIMM },
+	{ insn_bltz, M(bcond_op, 0, bltz_op, 0, 0, 0), RS | BIMM },
+	{ insn_bltzl, M(bcond_op, 0, bltzl_op, 0, 0, 0), RS | BIMM },
+	{ insn_bne, M(bne_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
+	{ insn_daddiu, M(daddiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM },
+	{ insn_daddu, M(spec_op, 0, 0, 0, 0, daddu_op), RS | RT | RD },
+	{ insn_dmfc0, M(cop0_op, dmfc_op, 0, 0, 0, 0), RT | RD | SET},
+	{ insn_dmtc0, M(cop0_op, dmtc_op, 0, 0, 0, 0), RT | RD | SET},
+	{ insn_dsll, M(spec_op, 0, 0, 0, 0, dsll_op), RT | RD | RE },
+	{ insn_dsll32, M(spec_op, 0, 0, 0, 0, dsll32_op), RT | RD | RE },
+	{ insn_dsra, M(spec_op, 0, 0, 0, 0, dsra_op), RT | RD | RE },
+	{ insn_dsrl, M(spec_op, 0, 0, 0, 0, dsrl_op), RT | RD | RE },
+	{ insn_dsrl32, M(spec_op, 0, 0, 0, 0, dsrl32_op), RT | RD | RE },
+	{ insn_dsubu, M(spec_op, 0, 0, 0, 0, dsubu_op), RS | RT | RD },
+	{ insn_eret,  M(cop0_op, cop_op, 0, 0, 0, eret_op),  0 },
+	{ insn_j,  M(j_op, 0, 0, 0, 0, 0),  JIMM },
+	{ insn_jal,  M(jal_op, 0, 0, 0, 0, 0),  JIMM },
+	{ insn_jr,  M(spec_op, 0, 0, 0, 0, jr_op),  RS },
+	{ insn_ld,  M(ld_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
+	{ insn_ll,  M(ll_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
+	{ insn_lld,  M(lld_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
+	{ insn_lui,  M(lui_op, 0, 0, 0, 0, 0),  RT | SIMM },
+	{ insn_lw,  M(lw_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
+	{ insn_mfc0,  M(cop0_op, mfc_op, 0, 0, 0, 0),  RT | RD | SET},
+	{ insn_mtc0,  M(cop0_op, mtc_op, 0, 0, 0, 0),  RT | RD | SET},
+	{ insn_ori,  M(ori_op, 0, 0, 0, 0, 0),  RS | RT | UIMM },
+	{ insn_rfe,  M(cop0_op, cop_op, 0, 0, 0, rfe_op),  0 },
+	{ insn_sc,  M(sc_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
+	{ insn_scd,  M(scd_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
+	{ insn_sd,  M(sd_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
+	{ insn_sll,  M(spec_op, 0, 0, 0, 0, sll_op),  RT | RD | RE },
+	{ insn_sra,  M(spec_op, 0, 0, 0, 0, sra_op),  RT | RD | RE },
+	{ insn_srl,  M(spec_op, 0, 0, 0, 0, srl_op),  RT | RD | RE },
+	{ insn_subu,  M(spec_op, 0, 0, 0, 0, subu_op),  RS | RT | RD },
+	{ insn_sw,  M(sw_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
+	{ insn_tlbp,  M(cop0_op, cop_op, 0, 0, 0, tlbp_op),  0 },
+	{ insn_tlbwi,  M(cop0_op, cop_op, 0, 0, 0, tlbwi_op),  0 },
+	{ insn_tlbwr,  M(cop0_op, cop_op, 0, 0, 0, tlbwr_op),  0 },
+	{ insn_xor,  M(spec_op, 0, 0, 0, 0, xor_op),  RS | RT | RD },
+	{ insn_xori,  M(xori_op, 0, 0, 0, 0, 0),  RS | RT | UIMM },
+	{ insn_invalid, 0, 0 }
+};
+
+#undef M
+
+static inline __init u32 build_rs(u32 arg)
+{
+	if (arg & ~RS_MASK)
+		printk(KERN_WARNING "Micro-assembler field overflow\n");
+
+	return (arg & RS_MASK) << RS_SH;
+}
+
+static inline __init u32 build_rt(u32 arg)
+{
+	if (arg & ~RT_MASK)
+		printk(KERN_WARNING "Micro-assembler field overflow\n");
+
+	return (arg & RT_MASK) << RT_SH;
+}
+
+static inline __init u32 build_rd(u32 arg)
+{
+	if (arg & ~RD_MASK)
+		printk(KERN_WARNING "Micro-assembler field overflow\n");
+
+	return (arg & RD_MASK) << RD_SH;
+}
+
+static inline __init u32 build_re(u32 arg)
+{
+	if (arg & ~RE_MASK)
+		printk(KERN_WARNING "Micro-assembler field overflow\n");
+
+	return (arg & RE_MASK) << RE_SH;
+}
+
+static inline __init u32 build_simm(s32 arg)
+{
+	if (arg > 0x7fff || arg < -0x8000)
+		printk(KERN_WARNING "Micro-assembler field overflow\n");
+
+	return arg & 0xffff;
+}
+
+static inline __init u32 build_uimm(u32 arg)
+{
+	if (arg & ~IMM_MASK)
+		printk(KERN_WARNING "Micro-assembler field overflow\n");
+
+	return arg & IMM_MASK;
+}
+
+static inline __init u32 build_bimm(s32 arg)
+{
+	if (arg > 0x1ffff || arg < -0x20000)
+		printk(KERN_WARNING "Micro-assembler field overflow\n");
+
+	if (arg & 0x3)
+		printk(KERN_WARNING "Invalid micro-assembler branch target\n");
+
+	return ((arg < 0) ? (1 << 15) : 0) | ((arg >> 2) & 0x7fff);
+}
+
+static inline __init u32 build_jimm(u32 arg)
+{
+	if (arg & ~((JIMM_MASK) << 2))
+		printk(KERN_WARNING "Micro-assembler field overflow\n");
+
+	return (arg >> 2) & JIMM_MASK;
+}
+
+static inline __init u32 build_func(u32 arg)
+{
+	if (arg & ~FUNC_MASK)
+		printk(KERN_WARNING "Micro-assembler field overflow\n");
+
+	return arg & FUNC_MASK;
+}
+
+static inline __init u32 build_set(u32 arg)
+{
+	if (arg & ~SET_MASK)
+		printk(KERN_WARNING "Micro-assembler field overflow\n");
+
+	return arg & SET_MASK;
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
+		panic("Unsupported Micro-assembler instruction %d", opc);
+
+	op = ip->match;
+	va_start(ap, opc);
+	if (ip->fields & RS)
+		op |= build_rs(va_arg(ap, u32));
+	if (ip->fields & RT)
+		op |= build_rt(va_arg(ap, u32));
+	if (ip->fields & RD)
+		op |= build_rd(va_arg(ap, u32));
+	if (ip->fields & RE)
+		op |= build_re(va_arg(ap, u32));
+	if (ip->fields & SIMM)
+		op |= build_simm(va_arg(ap, s32));
+	if (ip->fields & UIMM)
+		op |= build_uimm(va_arg(ap, u32));
+	if (ip->fields & BIMM)
+		op |= build_bimm(va_arg(ap, s32));
+	if (ip->fields & JIMM)
+		op |= build_jimm(va_arg(ap, u32));
+	if (ip->fields & FUNC)
+		op |= build_func(va_arg(ap, u32));
+	if (ip->fields & SET)
+		op |= build_set(va_arg(ap, u32));
+	va_end(ap);
+
+	**buf = op;
+	(*buf)++;
+}
+
+#define I_u1u2u3(op)					\
+Ip_u1u2u3(op)						\
+{							\
+	build_insn(buf, insn##op, a, b, c);		\
+}
+
+#define I_u2u1u3(op)					\
+Ip_u2u1u3(op)						\
+{							\
+	build_insn(buf, insn##op, b, a, c);		\
+}
+
+#define I_u3u1u2(op)					\
+Ip_u3u1u2(op)						\
+{							\
+	build_insn(buf, insn##op, b, c, a);		\
+}
+
+#define I_u1u2s3(op)					\
+Ip_u1u2s3(op)						\
+{							\
+	build_insn(buf, insn##op, a, b, c);		\
+}
+
+#define I_u2s3u1(op)					\
+Ip_u2s3u1(op)						\
+{							\
+	build_insn(buf, insn##op, c, a, b);		\
+}
+
+#define I_u2u1s3(op)					\
+Ip_u2u1s3(op)						\
+{							\
+	build_insn(buf, insn##op, b, a, c);		\
+}
+
+#define I_u1u2(op)					\
+Ip_u1u2(op)						\
+{							\
+	build_insn(buf, insn##op, a, b);		\
+}
+
+#define I_u1s2(op)					\
+Ip_u1s2(op)						\
+{							\
+	build_insn(buf, insn##op, a, b);		\
+}
+
+#define I_u1(op)					\
+Ip_u1(op)						\
+{							\
+	build_insn(buf, insn##op, a);			\
+}
+
+#define I_0(op)						\
+Ip_0(op)						\
+{							\
+	build_insn(buf, insn##op);			\
+}
+
+I_u2u1s3(_addiu)
+I_u3u1u2(_addu)
+I_u2u1u3(_andi)
+I_u3u1u2(_and)
+I_u1u2s3(_beq)
+I_u1u2s3(_beql)
+I_u1s2(_bgez)
+I_u1s2(_bgezl)
+I_u1s2(_bltz)
+I_u1s2(_bltzl)
+I_u1u2s3(_bne)
+I_u1u2u3(_dmfc0)
+I_u1u2u3(_dmtc0)
+I_u2u1s3(_daddiu)
+I_u3u1u2(_daddu)
+I_u2u1u3(_dsll)
+I_u2u1u3(_dsll32)
+I_u2u1u3(_dsra)
+I_u2u1u3(_dsrl)
+I_u2u1u3(_dsrl32)
+I_u3u1u2(_dsubu)
+I_0(_eret)
+I_u1(_j)
+I_u1(_jal)
+I_u1(_jr)
+I_u2s3u1(_ld)
+I_u2s3u1(_ll)
+I_u2s3u1(_lld)
+I_u1s2(_lui)
+I_u2s3u1(_lw)
+I_u1u2u3(_mfc0)
+I_u1u2u3(_mtc0)
+I_u2u1u3(_ori)
+I_0(_rfe)
+I_u2s3u1(_sc)
+I_u2s3u1(_scd)
+I_u2s3u1(_sd)
+I_u2u1u3(_sll)
+I_u2u1u3(_sra)
+I_u2u1u3(_srl)
+I_u3u1u2(_subu)
+I_u2s3u1(_sw)
+I_0(_tlbp)
+I_0(_tlbwi)
+I_0(_tlbwr)
+I_u3u1u2(_xor)
+I_u2u1u3(_xori)
+
+/* Handle labels. */
+__init void uasm_build_label(struct uasm_label **lab, u32 *addr, int lid)
+{
+	(*lab)->addr = addr;
+	(*lab)->lab = lid;
+	(*lab)++;
+}
+
+#ifdef CONFIG_64BIT
+__init int uasm_in_compat_space_p(long addr)
+{
+	/* Is this address in 32bit compat space? */
+	return (((addr) & 0xffffffff00000000L) == 0xffffffff00000000L);
+}
+
+__init int uasm_rel_highest(long val)
+{
+	return ((((val + 0x800080008000L) >> 48) & 0xffff) ^ 0x8000) - 0x8000;
+}
+
+__init int uasm_rel_higher(long val)
+{
+	return ((((val + 0x80008000L) >> 32) & 0xffff) ^ 0x8000) - 0x8000;
+}
+#endif
+
+__init int uasm_rel_hi(long val)
+{
+	return ((((val + 0x8000L) >> 16) & 0xffff) ^ 0x8000) - 0x8000;
+}
+
+__init int uasm_rel_lo(long val)
+{
+	return ((val & 0xffff) ^ 0x8000) - 0x8000;
+}
+
+__init void UASM_i_LA_mostly(u32 **buf, unsigned int rs, long addr)
+{
+#ifdef CONFIG_64BIT
+	if (!uasm_in_compat_space_p(addr)) {
+		uasm_i_lui(buf, rs, uasm_rel_highest(addr));
+		if (uasm_rel_higher(addr))
+			uasm_i_daddiu(buf, rs, rs, uasm_rel_higher(addr));
+		if (uasm_rel_hi(addr)) {
+			uasm_i_dsll(buf, rs, rs, 16);
+			uasm_i_daddiu(buf, rs, rs, uasm_rel_hi(addr));
+			uasm_i_dsll(buf, rs, rs, 16);
+		} else
+			uasm_i_dsll32(buf, rs, rs, 0);
+	} else
+#endif
+		uasm_i_lui(buf, rs, uasm_rel_hi(addr));
+}
+
+__init void UASM_i_LA(u32 **buf, unsigned int rs, long addr)
+{
+	UASM_i_LA_mostly(buf, rs, addr);
+	if (uasm_rel_lo(addr))
+		UASM_i_ADDIU(buf, rs, rs, uasm_rel_lo(addr));
+}
+
+/* Handle relocations. */
+__init void
+uasm_r_mips_pc16(struct uasm_reloc **rel, u32 *addr, int lid)
+{
+	(*rel)->addr = addr;
+	(*rel)->type = R_MIPS_PC16;
+	(*rel)->lab = lid;
+	(*rel)++;
+}
+
+static inline void
+__resolve_relocs(struct uasm_reloc *rel, struct uasm_label *lab)
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
+		panic("Unsupported Micro-assembler relocation %d",
+		      rel->type);
+	}
+}
+
+__init void
+uasm_resolve_relocs(struct uasm_reloc *rel, struct uasm_label *lab)
+{
+	struct uasm_label *l;
+
+	for (; rel->lab != UASM_LABEL_INVALID; rel++)
+		for (l = lab; l->lab != UASM_LABEL_INVALID; l++)
+			if (rel->lab == l->lab)
+				__resolve_relocs(rel, l);
+}
+
+__init void
+uasm_move_relocs(struct uasm_reloc *rel, u32 *first, u32 *end, long off)
+{
+	for (; rel->lab != UASM_LABEL_INVALID; rel++)
+		if (rel->addr >= first && rel->addr < end)
+			rel->addr += off;
+}
+
+__init void
+uasm_move_labels(struct uasm_label *lab, u32 *first, u32 *end, long off)
+{
+	for (; lab->lab != UASM_LABEL_INVALID; lab++)
+		if (lab->addr >= first && lab->addr < end)
+			lab->addr += off;
+}
+
+__init void
+uasm_copy_handler(struct uasm_reloc *rel, struct uasm_label *lab, u32 *first,
+		  u32 *end, u32 *target)
+{
+	long off = (long)(target - first);
+
+	memcpy(target, first, (end - first) * sizeof(u32));
+
+	uasm_move_relocs(rel, first, end, off);
+	uasm_move_labels(lab, first, end, off);
+}
+
+__init int uasm_insn_has_bdelay(struct uasm_reloc *rel, u32 *addr)
+{
+	for (; rel->lab != UASM_LABEL_INVALID; rel++) {
+		if (rel->addr == addr
+		    && (rel->type == R_MIPS_PC16
+			|| rel->type == R_MIPS_26))
+			return 1;
+	}
+
+	return 0;
+}
+
+/* Convenience functions for labeled branches. */
+void __init
+uasm_il_bltz(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid)
+{
+	uasm_r_mips_pc16(r, *p, lid);
+	uasm_i_bltz(p, reg, 0);
+}
+
+void __init
+uasm_il_b(u32 **p, struct uasm_reloc **r, int lid)
+{
+	uasm_r_mips_pc16(r, *p, lid);
+	uasm_i_b(p, 0);
+}
+
+void __init
+uasm_il_beqz(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid)
+{
+	uasm_r_mips_pc16(r, *p, lid);
+	uasm_i_beqz(p, reg, 0);
+}
+
+void __init
+uasm_il_beqzl(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid)
+{
+	uasm_r_mips_pc16(r, *p, lid);
+	uasm_i_beqzl(p, reg, 0);
+}
+
+void __init
+uasm_il_bnez(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid)
+{
+	uasm_r_mips_pc16(r, *p, lid);
+	uasm_i_bnez(p, reg, 0);
+}
+
+void __init
+uasm_il_bgezl(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid)
+{
+	uasm_r_mips_pc16(r, *p, lid);
+	uasm_i_bgezl(p, reg, 0);
+}
+
+void __init
+uasm_il_bgez(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid)
+{
+	uasm_r_mips_pc16(r, *p, lid);
+	uasm_i_bgez(p, reg, 0);
+}
diff --git a/arch/mips/mm/uasm.h b/arch/mips/mm/uasm.h
new file mode 100644
index 0000000..e0053b0
--- /dev/null
+++ b/arch/mips/mm/uasm.h
@@ -0,0 +1,192 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2004,2005,2006,2008  Thiemo Seufer
+ * Copyright (C) 2005  Maciej W. Rozycki
+ * Copyright (C) 2006  Ralf Baechle (ralf@linux-mips.org)
+ */
+
+#include <linux/types.h>
+
+#define Ip_u1u2u3(op)							\
+void __init								\
+uasm_i##op(u32 **buf, unsigned int a, unsigned int b, unsigned int c)
+
+#define Ip_u2u1u3(op)							\
+void __init								\
+uasm_i##op(u32 **buf, unsigned int a, unsigned int b, unsigned int c)
+
+#define Ip_u3u1u2(op)							\
+void __init								\
+uasm_i##op(u32 **buf, unsigned int a, unsigned int b, unsigned int c)
+
+#define Ip_u1u2s3(op)							\
+void __init								\
+uasm_i##op(u32 **buf, unsigned int a, unsigned int b, signed int c)
+
+#define Ip_u2s3u1(op)							\
+void __init								\
+uasm_i##op(u32 **buf, unsigned int a, signed int b, unsigned int c)
+
+#define Ip_u2u1s3(op)							\
+void __init								\
+uasm_i##op(u32 **buf, unsigned int a, unsigned int b, signed int c)
+
+#define Ip_u1u2(op)							\
+void __init uasm_i##op(u32 **buf, unsigned int a, unsigned int b)
+
+#define Ip_u1s2(op)							\
+void __init uasm_i##op(u32 **buf, unsigned int a, signed int b)
+
+#define Ip_u1(op) void __init uasm_i##op(u32 **buf, unsigned int a)
+
+#define Ip_0(op) void __init uasm_i##op(u32 **buf)
+
+Ip_u2u1s3(_addiu);
+Ip_u3u1u2(_addu);
+Ip_u2u1u3(_andi);
+Ip_u3u1u2(_and);
+Ip_u1u2s3(_beq);
+Ip_u1u2s3(_beql);
+Ip_u1s2(_bgez);
+Ip_u1s2(_bgezl);
+Ip_u1s2(_bltz);
+Ip_u1s2(_bltzl);
+Ip_u1u2s3(_bne);
+Ip_u1u2u3(_dmfc0);
+Ip_u1u2u3(_dmtc0);
+Ip_u2u1s3(_daddiu);
+Ip_u3u1u2(_daddu);
+Ip_u2u1u3(_dsll);
+Ip_u2u1u3(_dsll32);
+Ip_u2u1u3(_dsra);
+Ip_u2u1u3(_dsrl);
+Ip_u2u1u3(_dsrl32);
+Ip_u3u1u2(_dsubu);
+Ip_0(_eret);
+Ip_u1(_j);
+Ip_u1(_jal);
+Ip_u1(_jr);
+Ip_u2s3u1(_ld);
+Ip_u2s3u1(_ll);
+Ip_u2s3u1(_lld);
+Ip_u1s2(_lui);
+Ip_u2s3u1(_lw);
+Ip_u1u2u3(_mfc0);
+Ip_u1u2u3(_mtc0);
+Ip_u2u1u3(_ori);
+Ip_0(_rfe);
+Ip_u2s3u1(_sc);
+Ip_u2s3u1(_scd);
+Ip_u2s3u1(_sd);
+Ip_u2u1u3(_sll);
+Ip_u2u1u3(_sra);
+Ip_u2u1u3(_srl);
+Ip_u3u1u2(_subu);
+Ip_u2s3u1(_sw);
+Ip_0(_tlbp);
+Ip_0(_tlbwi);
+Ip_0(_tlbwr);
+Ip_u3u1u2(_xor);
+Ip_u2u1u3(_xori);
+
+/* Handle labels. */
+struct uasm_label {
+	u32 *addr;
+	int lab;
+};
+
+__init void uasm_build_label(struct uasm_label **lab, u32 *addr, int lid);
+#ifdef CONFIG_64BIT
+__init int uasm_in_compat_space_p(long addr);
+__init int uasm_rel_highest(long val);
+__init int uasm_rel_higher(long val);
+#endif
+__init int uasm_rel_hi(long val);
+__init int uasm_rel_lo(long val);
+__init void UASM_i_LA_mostly(u32 **buf, unsigned int rs, long addr);
+__init void UASM_i_LA(u32 **buf, unsigned int rs, long addr);
+
+#define UASM_L_LA(lb)							\
+static inline void uasm_l##lb(struct uasm_label **lab, u32 *addr)	\
+{									\
+	uasm_build_label(lab, addr, label##lb);				\
+}
+
+/* convenience macros for instructions */
+#ifdef CONFIG_64BIT
+# define UASM_i_LW(buf, rs, rt, off) uasm_i_ld(buf, rs, rt, off)
+# define UASM_i_SW(buf, rs, rt, off) uasm_i_sd(buf, rs, rt, off)
+# define UASM_i_SLL(buf, rs, rt, sh) uasm_i_dsll(buf, rs, rt, sh)
+# define UASM_i_SRA(buf, rs, rt, sh) uasm_i_dsra(buf, rs, rt, sh)
+# define UASM_i_SRL(buf, rs, rt, sh) uasm_i_dsrl(buf, rs, rt, sh)
+# define UASM_i_MFC0(buf, rt, rd...) uasm_i_dmfc0(buf, rt, rd)
+# define UASM_i_MTC0(buf, rt, rd...) uasm_i_dmtc0(buf, rt, rd)
+# define UASM_i_ADDIU(buf, rs, rt, val) uasm_i_daddiu(buf, rs, rt, val)
+# define UASM_i_ADDU(buf, rs, rt, rd) uasm_i_daddu(buf, rs, rt, rd)
+# define UASM_i_SUBU(buf, rs, rt, rd) uasm_i_dsubu(buf, rs, rt, rd)
+# define UASM_i_LL(buf, rs, rt, off) uasm_i_lld(buf, rs, rt, off)
+# define UASM_i_SC(buf, rs, rt, off) uasm_i_scd(buf, rs, rt, off)
+#else
+# define UASM_i_LW(buf, rs, rt, off) uasm_i_lw(buf, rs, rt, off)
+# define UASM_i_SW(buf, rs, rt, off) uasm_i_sw(buf, rs, rt, off)
+# define UASM_i_SLL(buf, rs, rt, sh) uasm_i_sll(buf, rs, rt, sh)
+# define UASM_i_SRA(buf, rs, rt, sh) uasm_i_sra(buf, rs, rt, sh)
+# define UASM_i_SRL(buf, rs, rt, sh) uasm_i_srl(buf, rs, rt, sh)
+# define UASM_i_MFC0(buf, rt, rd...) uasm_i_mfc0(buf, rt, rd)
+# define UASM_i_MTC0(buf, rt, rd...) uasm_i_mtc0(buf, rt, rd)
+# define UASM_i_ADDIU(buf, rs, rt, val) uasm_i_addiu(buf, rs, rt, val)
+# define UASM_i_ADDU(buf, rs, rt, rd) uasm_i_addu(buf, rs, rt, rd)
+# define UASM_i_SUBU(buf, rs, rt, rd) uasm_i_subu(buf, rs, rt, rd)
+# define UASM_i_LL(buf, rs, rt, off) uasm_i_ll(buf, rs, rt, off)
+# define UASM_i_SC(buf, rs, rt, off) uasm_i_sc(buf, rs, rt, off)
+#endif
+
+#define uasm_i_b(buf, off) uasm_i_beq(buf, 0, 0, off)
+#define uasm_i_beqz(buf, rs, off) uasm_i_beq(buf, rs, 0, off)
+#define uasm_i_beqzl(buf, rs, off) uasm_i_beql(buf, rs, 0, off)
+#define uasm_i_bnez(buf, rs, off) uasm_i_bne(buf, rs, 0, off)
+#define uasm_i_bnezl(buf, rs, off) uasm_i_bnel(buf, rs, 0, off)
+#define uasm_i_move(buf, a, b) UASM_i_ADDU(buf, a, 0, b)
+#define uasm_i_nop(buf) uasm_i_sll(buf, 0, 0, 0)
+#define uasm_i_ssnop(buf) uasm_i_sll(buf, 0, 0, 1)
+#define uasm_i_ehb(buf) uasm_i_sll(buf, 0, 0, 3)
+
+/* Handle relocations. */
+struct uasm_reloc {
+	u32 *addr;
+	unsigned int type;
+	int lab;
+};
+
+/* This is zero so we can use zeroed label arrays. */
+#define UASM_LABEL_INVALID 0
+
+__init void uasm_r_mips_pc16(struct uasm_reloc **rel, u32 *addr, int lid);
+__init void
+uasm_resolve_relocs(struct uasm_reloc *rel, struct uasm_label *lab);
+__init void
+uasm_move_relocs(struct uasm_reloc *rel, u32 *first, u32 *end, long off);
+__init void
+uasm_move_labels(struct uasm_label *lab, u32 *first, u32 *end, long off);
+__init void
+uasm_copy_handler(struct uasm_reloc *rel, struct uasm_label *lab, u32 *first,
+		  u32 *end, u32 *target);
+__init int uasm_insn_has_bdelay(struct uasm_reloc *rel, u32 *addr);
+
+/* Convenience functions for labeled branches. */
+void __init
+uasm_il_bltz(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid);
+void __init uasm_il_b(u32 **p, struct uasm_reloc **r, int lid);
+void __init
+uasm_il_beqz(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid);
+void __init
+uasm_il_beqzl(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid);
+void __init
+uasm_il_bnez(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid);
+void __init
+uasm_il_bgezl(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid);
+void __init
+uasm_il_bgez(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid);
