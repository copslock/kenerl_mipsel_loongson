Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Feb 2013 23:52:59 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:49919 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6824757Ab3BEWwSZjLb0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Feb 2013 23:52:18 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1U2rN5-0008Ky-FW; Tue, 05 Feb 2013 16:52:11 -0600
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org,
        cernekee@gmail.com, kevink@paralogos.com, ddaney.cavm@gmail.com
Subject: [PATCH 2/4] MIPS: microMIPS: uasm: Split 'uasm.c' into two files.
Date:   Tue,  5 Feb 2013 16:52:01 -0600
Message-Id: <1360104723-29529-3-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1360104723-29529-1-git-send-email-sjhill@mips.com>
References: <1360104723-29529-1-git-send-email-sjhill@mips.com>
X-archive-position: 35710
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

Split 'uasm.c' into two files. The new file 'uasm-mips.c' has the
functions specific to the classic MIPS ISA. The 'uasm.c' file
contains common code that can be used by classic or other ISAs
that could be supported by the kernel.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/uasm.h |   62 ++++----
 arch/mips/mm/Makefile        |    2 +-
 arch/mips/mm/uasm-mips.c     |  196 +++++++++++++++++++++++++
 arch/mips/mm/uasm.c          |  326 ++++++++++--------------------------------
 4 files changed, 313 insertions(+), 273 deletions(-)
 create mode 100644 arch/mips/mm/uasm-mips.c

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index 058e941..f7d8f15 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -6,7 +6,7 @@
  * Copyright (C) 2004, 2005, 2006, 2008	 Thiemo Seufer
  * Copyright (C) 2005  Maciej W. Rozycki
  * Copyright (C) 2006  Ralf Baechle (ralf@linux-mips.org)
- * Copyright (C) 2012  MIPS Technologies, Inc.
+ * Copyright (C) 2012, 2013  MIPS Technologies, Inc.  All rights reserved.
  */
 
 #include <linux/types.h>
@@ -22,44 +22,57 @@
 #define UASM_EXPORT_SYMBOL(sym)
 #endif
 
+#define _UASM_ISA_CLASSIC	0
+
+#ifndef UASM_ISA
+#define UASM_ISA	_UASM_ISA_CLASSIC
+#endif
+
+#if (UASM_ISA == _UASM_ISA_CLASSIC)
+#define ISAOPC(op)	uasm_i##op
+#define ISAFUNC(x)	x
+#else
+#error Unsupported micro-assembler ISA!!!
+#endif
+
 #define Ip_u1u2u3(op)							\
 void __uasminit								\
-uasm_i##op(u32 **buf, unsigned int a, unsigned int b, unsigned int c)
+ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b, unsigned int c)
 
 #define Ip_u2u1u3(op)							\
 void __uasminit								\
-uasm_i##op(u32 **buf, unsigned int a, unsigned int b, unsigned int c)
+ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b, unsigned int c)
 
 #define Ip_u3u1u2(op)							\
 void __uasminit								\
-uasm_i##op(u32 **buf, unsigned int a, unsigned int b, unsigned int c)
+ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b, unsigned int c)
 
 #define Ip_u1u2s3(op)							\
 void __uasminit								\
-uasm_i##op(u32 **buf, unsigned int a, unsigned int b, signed int c)
+ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b, signed int c)
 
 #define Ip_u2s3u1(op)							\
 void __uasminit								\
-uasm_i##op(u32 **buf, unsigned int a, signed int b, unsigned int c)
+ISAOPC(op)(u32 **buf, unsigned int a, signed int b, unsigned int c)
 
 #define Ip_u2u1s3(op)							\
 void __uasminit								\
-uasm_i##op(u32 **buf, unsigned int a, unsigned int b, signed int c)
+ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b, signed int c)
 
 #define Ip_u2u1msbu3(op)						\
 void __uasminit								\
-uasm_i##op(u32 **buf, unsigned int a, unsigned int b, unsigned int c,	\
+ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b, unsigned int c,	\
 	   unsigned int d)
 
 #define Ip_u1u2(op)							\
-void __uasminit uasm_i##op(u32 **buf, unsigned int a, unsigned int b)
+void __uasminit ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b)
 
 #define Ip_u1s2(op)							\
-void __uasminit uasm_i##op(u32 **buf, unsigned int a, signed int b)
+void __uasminit ISAOPC(op)(u32 **buf, unsigned int a, signed int b)
 
-#define Ip_u1(op) void __uasminit uasm_i##op(u32 **buf, unsigned int a)
+#define Ip_u1(op) void __uasminit ISAOPC(op)(u32 **buf, unsigned int a)
 
-#define Ip_0(op) void __uasminit uasm_i##op(u32 **buf)
+#define Ip_0(op) void __uasminit ISAOPC(op)(u32 **buf)
 
 Ip_u2u1s3(_addiu);
 Ip_u3u1u2(_addu);
@@ -132,14 +145,15 @@ struct uasm_label {
 	int lab;
 };
 
-void __uasminit uasm_build_label(struct uasm_label **lab, u32 *addr, int lid);
+void __uasminit ISAFUNC(uasm_build_label)(struct uasm_label **lab, u32 *addr,
+			int lid);
 #ifdef CONFIG_64BIT
-int uasm_in_compat_space_p(long addr);
+int ISAFUNC(uasm_in_compat_space_p)(long addr);
 #endif
-int uasm_rel_hi(long val);
-int uasm_rel_lo(long val);
-void UASM_i_LA_mostly(u32 **buf, unsigned int rs, long addr);
-void UASM_i_LA(u32 **buf, unsigned int rs, long addr);
+int ISAFUNC(uasm_rel_hi)(long val);
+int ISAFUNC(uasm_rel_lo)(long val);
+void ISAFUNC(UASM_i_LA_mostly)(u32 **buf, unsigned int rs, long addr);
+void ISAFUNC(UASM_i_LA)(u32 **buf, unsigned int rs, long addr);
 
 #define UASM_L_LA(lb)							\
 static inline void __uasminit uasm_l##lb(struct uasm_label **lab, u32 *addr) \
@@ -196,27 +210,27 @@ static inline void uasm_i_drotr_safe(u32 **p, unsigned int a1,
 				     unsigned int a2, unsigned int a3)
 {
 	if (a3 < 32)
-		uasm_i_drotr(p, a1, a2, a3);
+		ISAOPC(_drotr)(p, a1, a2, a3);
 	else
-		uasm_i_drotr32(p, a1, a2, a3 - 32);
+		ISAOPC(_drotr32)(p, a1, a2, a3 - 32);
 }
 
 static inline void uasm_i_dsll_safe(u32 **p, unsigned int a1,
 				    unsigned int a2, unsigned int a3)
 {
 	if (a3 < 32)
-		uasm_i_dsll(p, a1, a2, a3);
+		ISAOPC(_dsll)(p, a1, a2, a3);
 	else
-		uasm_i_dsll32(p, a1, a2, a3 - 32);
+		ISAOPC(_dsll32)(p, a1, a2, a3 - 32);
 }
 
 static inline void uasm_i_dsrl_safe(u32 **p, unsigned int a1,
 				    unsigned int a2, unsigned int a3)
 {
 	if (a3 < 32)
-		uasm_i_dsrl(p, a1, a2, a3);
+		ISAOPC(_dsrl)(p, a1, a2, a3);
 	else
-		uasm_i_dsrl32(p, a1, a2, a3 - 32);
+		ISAOPC(_dsrl32)(p, a1, a2, a3 - 32);
 }
 
 /* Handle relocations. */
diff --git a/arch/mips/mm/Makefile b/arch/mips/mm/Makefile
index 1dcec30..9e90c21 100644
--- a/arch/mips/mm/Makefile
+++ b/arch/mips/mm/Makefile
@@ -4,7 +4,7 @@
 
 obj-y				+= cache.o dma-default.o extable.o fault.o \
 				   gup.o init.o mmap.o page.o page-funcs.o \
-				   tlbex.o tlbex-fault.o uasm.o
+				   tlbex.o tlbex-fault.o uasm-mips.o
 
 obj-$(CONFIG_32BIT)		+= ioremap.o pgtable-32.o
 obj-$(CONFIG_64BIT)		+= pgtable-64.o
diff --git a/arch/mips/mm/uasm-mips.c b/arch/mips/mm/uasm-mips.c
new file mode 100644
index 0000000..e78e74d
--- /dev/null
+++ b/arch/mips/mm/uasm-mips.c
@@ -0,0 +1,196 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * A small micro-assembler. It is intentionally kept simple, does only
+ * support a subset of instructions, and does not try to hide pipeline
+ * effects like branch delay slots.
+ *
+ * Copyright (C) 2004, 2005, 2006, 2008	 Thiemo Seufer
+ * Copyright (C) 2005, 2007  Maciej W. Rozycki
+ * Copyright (C) 2006  Ralf Baechle (ralf@linux-mips.org)
+ * Copyright (C) 2012, 2013  MIPS Technologies, Inc.  All rights reserved.
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/init.h>
+
+#include <asm/inst.h>
+#include <asm/elf.h>
+#include <asm/bugs.h>
+#include <asm/uasm.h>
+
+#define RS_MASK		0x1f
+#define RS_SH		21
+#define RT_MASK		0x1f
+#define RT_SH		16
+#define SCIMM_MASK	0xfffff
+#define SCIMM_SH	6
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
+#include "uasm.c"
+
+static struct insn insn_table[] __uasminitdata = {
+	{ insn_addiu, M(addiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM },
+	{ insn_addu, M(spec_op, 0, 0, 0, 0, addu_op), RS | RT | RD },
+	{ insn_andi, M(andi_op, 0, 0, 0, 0, 0), RS | RT | UIMM },
+	{ insn_and, M(spec_op, 0, 0, 0, 0, and_op), RS | RT | RD },
+	{ insn_bbit0, M(lwc2_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
+	{ insn_bbit1, M(swc2_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
+	{ insn_beql, M(beql_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
+	{ insn_beq, M(beq_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
+	{ insn_bgezl, M(bcond_op, 0, bgezl_op, 0, 0, 0), RS | BIMM },
+	{ insn_bgez, M(bcond_op, 0, bgez_op, 0, 0, 0), RS | BIMM },
+	{ insn_bltzl, M(bcond_op, 0, bltzl_op, 0, 0, 0), RS | BIMM },
+	{ insn_bltz, M(bcond_op, 0, bltz_op, 0, 0, 0), RS | BIMM },
+	{ insn_bne, M(bne_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
+	{ insn_cache,  M(cache_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
+	{ insn_daddiu, M(daddiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM },
+	{ insn_daddu, M(spec_op, 0, 0, 0, 0, daddu_op), RS | RT | RD },
+	{ insn_dinsm, M(spec3_op, 0, 0, 0, 0, dinsm_op), RS | RT | RD | RE },
+	{ insn_dins, M(spec3_op, 0, 0, 0, 0, dins_op), RS | RT | RD | RE },
+	{ insn_dmfc0, M(cop0_op, dmfc_op, 0, 0, 0, 0), RT | RD | SET},
+	{ insn_dmtc0, M(cop0_op, dmtc_op, 0, 0, 0, 0), RT | RD | SET},
+	{ insn_drotr32, M(spec_op, 1, 0, 0, 0, dsrl32_op), RT | RD | RE },
+	{ insn_drotr, M(spec_op, 1, 0, 0, 0, dsrl_op), RT | RD | RE },
+	{ insn_dsll32, M(spec_op, 0, 0, 0, 0, dsll32_op), RT | RD | RE },
+	{ insn_dsll, M(spec_op, 0, 0, 0, 0, dsll_op), RT | RD | RE },
+	{ insn_dsra, M(spec_op, 0, 0, 0, 0, dsra_op), RT | RD | RE },
+	{ insn_dsrl32, M(spec_op, 0, 0, 0, 0, dsrl32_op), RT | RD | RE },
+	{ insn_dsrl, M(spec_op, 0, 0, 0, 0, dsrl_op), RT | RD | RE },
+	{ insn_dsubu, M(spec_op, 0, 0, 0, 0, dsubu_op), RS | RT | RD },
+	{ insn_eret,  M(cop0_op, cop_op, 0, 0, 0, eret_op),  0 },
+	{ insn_ext, M(spec3_op, 0, 0, 0, 0, ext_op), RS | RT | RD | RE },
+	{ insn_ins, M(spec3_op, 0, 0, 0, 0, ins_op), RS | RT | RD | RE },
+	{ insn_j,  M(j_op, 0, 0, 0, 0, 0),  JIMM },
+	{ insn_jal,  M(jal_op, 0, 0, 0, 0, 0),	JIMM },
+	{ insn_j,  M(j_op, 0, 0, 0, 0, 0),  JIMM },
+	{ insn_jr,  M(spec_op, 0, 0, 0, 0, jr_op),  RS },
+	{ insn_ld,  M(ld_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
+	{ insn_ldx, M(spec3_op, 0, 0, 0, ldx_op, lx_op), RS | RT | RD },
+	{ insn_lld,  M(lld_op, 0, 0, 0, 0, 0),	RS | RT | SIMM },
+	{ insn_ll,  M(ll_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
+	{ insn_lui,  M(lui_op, 0, 0, 0, 0, 0),	RT | SIMM },
+	{ insn_lw,  M(lw_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
+	{ insn_lwx, M(spec3_op, 0, 0, 0, lwx_op, lx_op), RS | RT | RD },
+	{ insn_mfc0,  M(cop0_op, mfc_op, 0, 0, 0, 0),  RT | RD | SET},
+	{ insn_mtc0,  M(cop0_op, mtc_op, 0, 0, 0, 0),  RT | RD | SET},
+	{ insn_ori,  M(ori_op, 0, 0, 0, 0, 0),	RS | RT | UIMM },
+	{ insn_or,  M(spec_op, 0, 0, 0, 0, or_op),  RS | RT | RD },
+	{ insn_pref,  M(pref_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
+	{ insn_rfe,  M(cop0_op, cop_op, 0, 0, 0, rfe_op),  0 },
+	{ insn_rotr,  M(spec_op, 1, 0, 0, 0, srl_op),  RT | RD | RE },
+	{ insn_scd,  M(scd_op, 0, 0, 0, 0, 0),	RS | RT | SIMM },
+	{ insn_sc,  M(sc_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
+	{ insn_sd,  M(sd_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
+	{ insn_sll,  M(spec_op, 0, 0, 0, 0, sll_op),  RT | RD | RE },
+	{ insn_sra,  M(spec_op, 0, 0, 0, 0, sra_op),  RT | RD | RE },
+	{ insn_srl,  M(spec_op, 0, 0, 0, 0, srl_op),  RT | RD | RE },
+	{ insn_subu,  M(spec_op, 0, 0, 0, 0, subu_op),	RS | RT | RD },
+	{ insn_sw,  M(sw_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
+	{ insn_syscall, M(spec_op, 0, 0, 0, 0, syscall_op), SCIMM},
+	{ insn_tlbp,  M(cop0_op, cop_op, 0, 0, 0, tlbp_op),  0 },
+	{ insn_tlbr,  M(cop0_op, cop_op, 0, 0, 0, tlbr_op),  0 },
+	{ insn_tlbwi,  M(cop0_op, cop_op, 0, 0, 0, tlbwi_op),  0 },
+	{ insn_tlbwr,  M(cop0_op, cop_op, 0, 0, 0, tlbwr_op),  0 },
+	{ insn_xori,  M(xori_op, 0, 0, 0, 0, 0),  RS | RT | UIMM },
+	{ insn_xor,  M(spec_op, 0, 0, 0, 0, xor_op),  RS | RT | RD },
+	{ insn_invalid, 0, 0 }
+};
+
+#undef M
+
+static inline __uasminit u32 build_bimm(s32 arg)
+{
+	WARN(arg > 0x1ffff || arg < -0x20000,
+	     KERN_WARNING "Micro-assembler field overflow\n");
+
+	WARN(arg & 0x3, KERN_WARNING "Invalid micro-assembler branch target\n");
+
+	return ((arg < 0) ? (1 << 15) : 0) | ((arg >> 2) & 0x7fff);
+}
+
+static inline __uasminit u32 build_jimm(u32 arg)
+{
+	WARN(arg & ~(JIMM_MASK << 2),
+	     KERN_WARNING "Micro-assembler field overflow\n");
+
+	return (arg >> 2) & JIMM_MASK;
+}
+
+/*
+ * The order of opcode arguments is implicitly left to right,
+ * starting with RS and ending with FUNC or IMM.
+ */
+static void __uasminit build_insn(u32 **buf, enum opcode opc, ...)
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
+	if (!ip || (opc == insn_daddiu && r4k_daddiu_bug()))
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
+	if (ip->fields & SCIMM)
+		op |= build_scimm(va_arg(ap, u32));
+	va_end(ap);
+
+	**buf = op;
+	(*buf)++;
+}
+
+static inline void __uasminit
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
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index 942ff6c..7eb5e43 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -10,17 +10,9 @@
  * Copyright (C) 2004, 2005, 2006, 2008	 Thiemo Seufer
  * Copyright (C) 2005, 2007  Maciej W. Rozycki
  * Copyright (C) 2006  Ralf Baechle (ralf@linux-mips.org)
+ * Copyright (C) 2012, 2013  MIPS Technologies, Inc.  All rights reserved.
  */
 
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/init.h>
-
-#include <asm/inst.h>
-#include <asm/elf.h>
-#include <asm/bugs.h>
-#include <asm/uasm.h>
-
 enum fields {
 	RS = 0x001,
 	RT = 0x002,
@@ -37,10 +29,6 @@ enum fields {
 
 #define OP_MASK		0x3f
 #define OP_SH		26
-#define RS_MASK		0x1f
-#define RS_SH		21
-#define RT_MASK		0x1f
-#define RT_SH		16
 #define RD_MASK		0x1f
 #define RD_SH		11
 #define RE_MASK		0x1f
@@ -53,8 +41,6 @@ enum fields {
 #define FUNC_SH		0
 #define SET_MASK	0x7
 #define SET_SH		0
-#define SCIMM_MASK	0xfffff
-#define SCIMM_SH	6
 
 enum opcode {
 	insn_invalid,
@@ -77,85 +63,6 @@ struct insn {
 	enum fields fields;
 };
 
-/* This macro sets the non-variable bits of an instruction. */
-#define M(a, b, c, d, e, f)					\
-	((a) << OP_SH						\
-	 | (b) << RS_SH						\
-	 | (c) << RT_SH						\
-	 | (d) << RD_SH						\
-	 | (e) << RE_SH						\
-	 | (f) << FUNC_SH)
-
-static struct insn insn_table[] __uasminitdata = {
-	{ insn_addiu, M(addiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM },
-	{ insn_addu, M(spec_op, 0, 0, 0, 0, addu_op), RS | RT | RD },
-	{ insn_andi, M(andi_op, 0, 0, 0, 0, 0), RS | RT | UIMM },
-	{ insn_and, M(spec_op, 0, 0, 0, 0, and_op), RS | RT | RD },
-	{ insn_bbit0, M(lwc2_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
-	{ insn_bbit1, M(swc2_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
-	{ insn_beql, M(beql_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
-	{ insn_beq, M(beq_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
-	{ insn_bgezl, M(bcond_op, 0, bgezl_op, 0, 0, 0), RS | BIMM },
-	{ insn_bgez, M(bcond_op, 0, bgez_op, 0, 0, 0), RS | BIMM },
-	{ insn_bltzl, M(bcond_op, 0, bltzl_op, 0, 0, 0), RS | BIMM },
-	{ insn_bltz, M(bcond_op, 0, bltz_op, 0, 0, 0), RS | BIMM },
-	{ insn_bne, M(bne_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
-	{ insn_cache,  M(cache_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
-	{ insn_daddiu, M(daddiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM },
-	{ insn_daddu, M(spec_op, 0, 0, 0, 0, daddu_op), RS | RT | RD },
-	{ insn_dinsm, M(spec3_op, 0, 0, 0, 0, dinsm_op), RS | RT | RD | RE },
-	{ insn_dins, M(spec3_op, 0, 0, 0, 0, dins_op), RS | RT | RD | RE },
-	{ insn_dmfc0, M(cop0_op, dmfc_op, 0, 0, 0, 0), RT | RD | SET},
-	{ insn_dmtc0, M(cop0_op, dmtc_op, 0, 0, 0, 0), RT | RD | SET},
-	{ insn_drotr32, M(spec_op, 1, 0, 0, 0, dsrl32_op), RT | RD | RE },
-	{ insn_drotr, M(spec_op, 1, 0, 0, 0, dsrl_op), RT | RD | RE },
-	{ insn_dsll32, M(spec_op, 0, 0, 0, 0, dsll32_op), RT | RD | RE },
-	{ insn_dsll, M(spec_op, 0, 0, 0, 0, dsll_op), RT | RD | RE },
-	{ insn_dsra, M(spec_op, 0, 0, 0, 0, dsra_op), RT | RD | RE },
-	{ insn_dsrl32, M(spec_op, 0, 0, 0, 0, dsrl32_op), RT | RD | RE },
-	{ insn_dsrl, M(spec_op, 0, 0, 0, 0, dsrl_op), RT | RD | RE },
-	{ insn_dsubu, M(spec_op, 0, 0, 0, 0, dsubu_op), RS | RT | RD },
-	{ insn_eret,  M(cop0_op, cop_op, 0, 0, 0, eret_op),  0 },
-	{ insn_ext, M(spec3_op, 0, 0, 0, 0, ext_op), RS | RT | RD | RE },
-	{ insn_ins, M(spec3_op, 0, 0, 0, 0, ins_op), RS | RT | RD | RE },
-	{ insn_j,  M(j_op, 0, 0, 0, 0, 0),  JIMM },
-	{ insn_jal,  M(jal_op, 0, 0, 0, 0, 0),	JIMM },
-	{ insn_j,  M(j_op, 0, 0, 0, 0, 0),  JIMM },
-	{ insn_jr,  M(spec_op, 0, 0, 0, 0, jr_op),  RS },
-	{ insn_ld,  M(ld_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
-	{ insn_ldx, M(spec3_op, 0, 0, 0, ldx_op, lx_op), RS | RT | RD },
-	{ insn_lld,  M(lld_op, 0, 0, 0, 0, 0),	RS | RT | SIMM },
-	{ insn_ll,  M(ll_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
-	{ insn_lui,  M(lui_op, 0, 0, 0, 0, 0),	RT | SIMM },
-	{ insn_lw,  M(lw_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
-	{ insn_lwx, M(spec3_op, 0, 0, 0, lwx_op, lx_op), RS | RT | RD },
-	{ insn_mfc0,  M(cop0_op, mfc_op, 0, 0, 0, 0),  RT | RD | SET},
-	{ insn_mtc0,  M(cop0_op, mtc_op, 0, 0, 0, 0),  RT | RD | SET},
-	{ insn_ori,  M(ori_op, 0, 0, 0, 0, 0),	RS | RT | UIMM },
-	{ insn_or,  M(spec_op, 0, 0, 0, 0, or_op),  RS | RT | RD },
-	{ insn_pref,  M(pref_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
-	{ insn_rfe,  M(cop0_op, cop_op, 0, 0, 0, rfe_op),  0 },
-	{ insn_rotr,  M(spec_op, 1, 0, 0, 0, srl_op),  RT | RD | RE },
-	{ insn_scd,  M(scd_op, 0, 0, 0, 0, 0),	RS | RT | SIMM },
-	{ insn_sc,  M(sc_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
-	{ insn_sd,  M(sd_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
-	{ insn_sll,  M(spec_op, 0, 0, 0, 0, sll_op),  RT | RD | RE },
-	{ insn_sra,  M(spec_op, 0, 0, 0, 0, sra_op),  RT | RD | RE },
-	{ insn_srl,  M(spec_op, 0, 0, 0, 0, srl_op),  RT | RD | RE },
-	{ insn_subu,  M(spec_op, 0, 0, 0, 0, subu_op),	RS | RT | RD },
-	{ insn_sw,  M(sw_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
-	{ insn_syscall, M(spec_op, 0, 0, 0, 0, syscall_op), SCIMM},
-	{ insn_tlbp,  M(cop0_op, cop_op, 0, 0, 0, tlbp_op),  0 },
-	{ insn_tlbr,  M(cop0_op, cop_op, 0, 0, 0, tlbr_op),  0 },
-	{ insn_tlbwi,  M(cop0_op, cop_op, 0, 0, 0, tlbwi_op),  0 },
-	{ insn_tlbwr,  M(cop0_op, cop_op, 0, 0, 0, tlbwr_op),  0 },
-	{ insn_xori,  M(xori_op, 0, 0, 0, 0, 0),  RS | RT | UIMM },
-	{ insn_xor,  M(spec_op, 0, 0, 0, 0, xor_op),  RS | RT | RD },
-	{ insn_invalid, 0, 0 }
-};
-
-#undef M
-
 static inline __uasminit u32 build_rs(u32 arg)
 {
 	WARN(arg & ~RS_MASK, KERN_WARNING "Micro-assembler field overflow\n");
@@ -199,24 +106,6 @@ static inline __uasminit u32 build_uimm(u32 arg)
 	return arg & IMM_MASK;
 }
 
-static inline __uasminit u32 build_bimm(s32 arg)
-{
-	WARN(arg > 0x1ffff || arg < -0x20000,
-	     KERN_WARNING "Micro-assembler field overflow\n");
-
-	WARN(arg & 0x3, KERN_WARNING "Invalid micro-assembler branch target\n");
-
-	return ((arg < 0) ? (1 << 15) : 0) | ((arg >> 2) & 0x7fff);
-}
-
-static inline __uasminit u32 build_jimm(u32 arg)
-{
-	WARN(arg & ~(JIMM_MASK << 2),
-	     KERN_WARNING "Micro-assembler field overflow\n");
-
-	return (arg >> 2) & JIMM_MASK;
-}
-
 static inline __uasminit u32 build_scimm(u32 arg)
 {
 	WARN(arg & ~SCIMM_MASK,
@@ -239,55 +128,7 @@ static inline __uasminit u32 build_set(u32 arg)
 	return arg & SET_MASK;
 }
 
-/*
- * The order of opcode arguments is implicitly left to right,
- * starting with RS and ending with FUNC or IMM.
- */
-static void __uasminit build_insn(u32 **buf, enum opcode opc, ...)
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
-	if (!ip || (opc == insn_daddiu && r4k_daddiu_bug()))
-		panic("Unsupported Micro-assembler instruction %d", opc);
-
-	op = ip->match;
-	va_start(ap, opc);
-	if (ip->fields & RS)
-		op |= build_rs(va_arg(ap, u32));
-	if (ip->fields & RT)
-		op |= build_rt(va_arg(ap, u32));
-	if (ip->fields & RD)
-		op |= build_rd(va_arg(ap, u32));
-	if (ip->fields & RE)
-		op |= build_re(va_arg(ap, u32));
-	if (ip->fields & SIMM)
-		op |= build_simm(va_arg(ap, s32));
-	if (ip->fields & UIMM)
-		op |= build_uimm(va_arg(ap, u32));
-	if (ip->fields & BIMM)
-		op |= build_bimm(va_arg(ap, s32));
-	if (ip->fields & JIMM)
-		op |= build_jimm(va_arg(ap, u32));
-	if (ip->fields & FUNC)
-		op |= build_func(va_arg(ap, u32));
-	if (ip->fields & SET)
-		op |= build_set(va_arg(ap, u32));
-	if (ip->fields & SCIMM)
-		op |= build_scimm(va_arg(ap, u32));
-	va_end(ap);
-
-	**buf = op;
-	(*buf)++;
-}
+static void __uasminit build_insn(u32 **buf, enum opcode opc, ...);
 
 #define I_u1u2u3(op)					\
 Ip_u1u2u3(op)						\
@@ -445,7 +286,7 @@ I_u3u1u2(_ldx)
 
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
 #include <asm/octeon/octeon.h>
-void __uasminit uasm_i_pref(u32 **buf, unsigned int a, signed int b,
+void __uasminit ISAFUNC(uasm_i_pref)(u32 **buf, unsigned int a, signed int b,
 			    unsigned int c)
 {
 	if (OCTEON_IS_MODEL(OCTEON_CN63XX_PASS1_X) && a <= 24 && a != 5)
@@ -457,21 +298,21 @@ void __uasminit uasm_i_pref(u32 **buf, unsigned int a, signed int b,
 	else
 		build_insn(buf, insn_pref, c, a, b);
 }
-UASM_EXPORT_SYMBOL(uasm_i_pref);
+UASM_EXPORT_SYMBOL(ISAFUNC(uasm_i_pref));
 #else
 I_u2s3u1(_pref)
 #endif
 
 /* Handle labels. */
-void __uasminit uasm_build_label(struct uasm_label **lab, u32 *addr, int lid)
+void __uasminit ISAFUNC(uasm_build_label)(struct uasm_label **lab, u32 *addr, int lid)
 {
 	(*lab)->addr = addr;
 	(*lab)->lab = lid;
 	(*lab)++;
 }
-UASM_EXPORT_SYMBOL(uasm_build_label);
+UASM_EXPORT_SYMBOL(ISAFUNC(uasm_build_label));
 
-int __uasminit uasm_in_compat_space_p(long addr)
+int __uasminit ISAFUNC(uasm_in_compat_space_p)(long addr)
 {
 	/* Is this address in 32bit compat space? */
 #ifdef CONFIG_64BIT
@@ -480,7 +321,7 @@ int __uasminit uasm_in_compat_space_p(long addr)
 	return 1;
 #endif
 }
-UASM_EXPORT_SYMBOL(uasm_in_compat_space_p);
+UASM_EXPORT_SYMBOL(ISAFUNC(uasm_in_compat_space_p));
 
 static int __uasminit uasm_rel_highest(long val)
 {
@@ -500,77 +341,66 @@ static int __uasminit uasm_rel_higher(long val)
 #endif
 }
 
-int __uasminit uasm_rel_hi(long val)
+int __uasminit ISAFUNC(uasm_rel_hi)(long val)
 {
 	return ((((val + 0x8000L) >> 16) & 0xffff) ^ 0x8000) - 0x8000;
 }
-UASM_EXPORT_SYMBOL(uasm_rel_hi);
+UASM_EXPORT_SYMBOL(ISAFUNC(uasm_rel_hi));
 
-int __uasminit uasm_rel_lo(long val)
+int __uasminit ISAFUNC(uasm_rel_lo)(long val)
 {
 	return ((val & 0xffff) ^ 0x8000) - 0x8000;
 }
-UASM_EXPORT_SYMBOL(uasm_rel_lo);
+UASM_EXPORT_SYMBOL(ISAFUNC(uasm_rel_lo));
 
-void __uasminit UASM_i_LA_mostly(u32 **buf, unsigned int rs, long addr)
+void __uasminit ISAFUNC(UASM_i_LA_mostly)(u32 **buf, unsigned int rs, long addr)
 {
-	if (!uasm_in_compat_space_p(addr)) {
-		uasm_i_lui(buf, rs, uasm_rel_highest(addr));
+	if (!ISAFUNC(uasm_in_compat_space_p)(addr)) {
+		ISAFUNC(uasm_i_lui)(buf, rs, uasm_rel_highest(addr));
 		if (uasm_rel_higher(addr))
-			uasm_i_daddiu(buf, rs, rs, uasm_rel_higher(addr));
-		if (uasm_rel_hi(addr)) {
-			uasm_i_dsll(buf, rs, rs, 16);
-			uasm_i_daddiu(buf, rs, rs, uasm_rel_hi(addr));
-			uasm_i_dsll(buf, rs, rs, 16);
+			ISAFUNC(uasm_i_daddiu)(buf, rs, rs, uasm_rel_higher(addr));
+		if (ISAFUNC(uasm_rel_hi(addr))) {
+			ISAFUNC(uasm_i_dsll)(buf, rs, rs, 16);
+			ISAFUNC(uasm_i_daddiu)(buf, rs, rs,
+					ISAFUNC(uasm_rel_hi)(addr));
+			ISAFUNC(uasm_i_dsll)(buf, rs, rs, 16);
 		} else
-			uasm_i_dsll32(buf, rs, rs, 0);
+			ISAFUNC(uasm_i_dsll32)(buf, rs, rs, 0);
 	} else
-		uasm_i_lui(buf, rs, uasm_rel_hi(addr));
+		ISAFUNC(uasm_i_lui)(buf, rs, ISAFUNC(uasm_rel_hi(addr)));
 }
-UASM_EXPORT_SYMBOL(UASM_i_LA_mostly);
+UASM_EXPORT_SYMBOL(ISAFUNC(UASM_i_LA_mostly));
 
-void __uasminit UASM_i_LA(u32 **buf, unsigned int rs, long addr)
+void __uasminit ISAFUNC(UASM_i_LA)(u32 **buf, unsigned int rs, long addr)
 {
-	UASM_i_LA_mostly(buf, rs, addr);
-	if (uasm_rel_lo(addr)) {
-		if (!uasm_in_compat_space_p(addr))
-			uasm_i_daddiu(buf, rs, rs, uasm_rel_lo(addr));
+	ISAFUNC(UASM_i_LA_mostly)(buf, rs, addr);
+	if (ISAFUNC(uasm_rel_lo(addr))) {
+		if (!ISAFUNC(uasm_in_compat_space_p)(addr))
+			ISAFUNC(uasm_i_daddiu)(buf, rs, rs,
+					ISAFUNC(uasm_rel_lo(addr)));
 		else
-			uasm_i_addiu(buf, rs, rs, uasm_rel_lo(addr));
+			ISAFUNC(uasm_i_addiu)(buf, rs, rs,
+					ISAFUNC(uasm_rel_lo(addr)));
 	}
 }
-UASM_EXPORT_SYMBOL(UASM_i_LA);
+UASM_EXPORT_SYMBOL(ISAFUNC(UASM_i_LA));
 
 /* Handle relocations. */
 void __uasminit
-uasm_r_mips_pc16(struct uasm_reloc **rel, u32 *addr, int lid)
+ISAFUNC(uasm_r_mips_pc16)(struct uasm_reloc **rel, u32 *addr, int lid)
 {
 	(*rel)->addr = addr;
 	(*rel)->type = R_MIPS_PC16;
 	(*rel)->lab = lid;
 	(*rel)++;
 }
-UASM_EXPORT_SYMBOL(uasm_r_mips_pc16);
+UASM_EXPORT_SYMBOL(ISAFUNC(uasm_r_mips_pc16));
 
 static inline void __uasminit
-__resolve_relocs(struct uasm_reloc *rel, struct uasm_label *lab)
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
-		panic("Unsupported Micro-assembler relocation %d",
-		      rel->type);
-	}
-}
+__resolve_relocs(struct uasm_reloc *rel, struct uasm_label *lab);
 
 void __uasminit
-uasm_resolve_relocs(struct uasm_reloc *rel, struct uasm_label *lab)
+ISAFUNC(uasm_resolve_relocs)(struct uasm_reloc *rel, struct uasm_label *lab)
 {
 	struct uasm_label *l;
 
@@ -579,40 +409,40 @@ uasm_resolve_relocs(struct uasm_reloc *rel, struct uasm_label *lab)
 			if (rel->lab == l->lab)
 				__resolve_relocs(rel, l);
 }
-UASM_EXPORT_SYMBOL(uasm_resolve_relocs);
+UASM_EXPORT_SYMBOL(ISAFUNC(uasm_resolve_relocs));
 
 void __uasminit
-uasm_move_relocs(struct uasm_reloc *rel, u32 *first, u32 *end, long off)
+ISAFUNC(uasm_move_relocs)(struct uasm_reloc *rel, u32 *first, u32 *end, long off)
 {
 	for (; rel->lab != UASM_LABEL_INVALID; rel++)
 		if (rel->addr >= first && rel->addr < end)
 			rel->addr += off;
 }
-UASM_EXPORT_SYMBOL(uasm_move_relocs);
+UASM_EXPORT_SYMBOL(ISAFUNC(uasm_move_relocs));
 
 void __uasminit
-uasm_move_labels(struct uasm_label *lab, u32 *first, u32 *end, long off)
+ISAFUNC(uasm_move_labels)(struct uasm_label *lab, u32 *first, u32 *end, long off)
 {
 	for (; lab->lab != UASM_LABEL_INVALID; lab++)
 		if (lab->addr >= first && lab->addr < end)
 			lab->addr += off;
 }
-UASM_EXPORT_SYMBOL(uasm_move_labels);
+UASM_EXPORT_SYMBOL(ISAFUNC(uasm_move_labels));
 
 void __uasminit
-uasm_copy_handler(struct uasm_reloc *rel, struct uasm_label *lab, u32 *first,
+ISAFUNC(uasm_copy_handler)(struct uasm_reloc *rel, struct uasm_label *lab, u32 *first,
 		  u32 *end, u32 *target)
 {
 	long off = (long)(target - first);
 
 	memcpy(target, first, (end - first) * sizeof(u32));
 
-	uasm_move_relocs(rel, first, end, off);
-	uasm_move_labels(lab, first, end, off);
+	ISAFUNC(uasm_move_relocs(rel, first, end, off));
+	ISAFUNC(uasm_move_labels(lab, first, end, off));
 }
-UASM_EXPORT_SYMBOL(uasm_copy_handler);
+UASM_EXPORT_SYMBOL(ISAFUNC(uasm_copy_handler));
 
-int __uasminit uasm_insn_has_bdelay(struct uasm_reloc *rel, u32 *addr)
+int __uasminit ISAFUNC(uasm_insn_has_bdelay)(struct uasm_reloc *rel, u32 *addr)
 {
 	for (; rel->lab != UASM_LABEL_INVALID; rel++) {
 		if (rel->addr == addr
@@ -623,88 +453,88 @@ int __uasminit uasm_insn_has_bdelay(struct uasm_reloc *rel, u32 *addr)
 
 	return 0;
 }
-UASM_EXPORT_SYMBOL(uasm_insn_has_bdelay);
+UASM_EXPORT_SYMBOL(ISAFUNC(uasm_insn_has_bdelay));
 
 /* Convenience functions for labeled branches. */
 void __uasminit
-uasm_il_bltz(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid)
+ISAFUNC(uasm_il_bltz)(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid)
 {
 	uasm_r_mips_pc16(r, *p, lid);
-	uasm_i_bltz(p, reg, 0);
+	ISAFUNC(uasm_i_bltz)(p, reg, 0);
 }
-UASM_EXPORT_SYMBOL(uasm_il_bltz);
+UASM_EXPORT_SYMBOL(ISAFUNC(uasm_il_bltz));
 
 void __uasminit
-uasm_il_b(u32 **p, struct uasm_reloc **r, int lid)
+ISAFUNC(uasm_il_b)(u32 **p, struct uasm_reloc **r, int lid)
 {
 	uasm_r_mips_pc16(r, *p, lid);
-	uasm_i_b(p, 0);
+	ISAFUNC(uasm_i_b)(p, 0);
 }
-UASM_EXPORT_SYMBOL(uasm_il_b);
+UASM_EXPORT_SYMBOL(ISAFUNC(uasm_il_b));
 
 void __uasminit
-uasm_il_beqz(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid)
+ISAFUNC(uasm_il_beqz)(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid)
 {
 	uasm_r_mips_pc16(r, *p, lid);
-	uasm_i_beqz(p, reg, 0);
+	ISAFUNC(uasm_i_beqz)(p, reg, 0);
 }
-UASM_EXPORT_SYMBOL(uasm_il_beqz);
+UASM_EXPORT_SYMBOL(ISAFUNC(uasm_il_beqz));
 
 void __uasminit
-uasm_il_beqzl(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid)
+ISAFUNC(uasm_il_beqzl)(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid)
 {
 	uasm_r_mips_pc16(r, *p, lid);
-	uasm_i_beqzl(p, reg, 0);
+	ISAFUNC(uasm_i_beqzl)(p, reg, 0);
 }
-UASM_EXPORT_SYMBOL(uasm_il_beqzl);
+UASM_EXPORT_SYMBOL(ISAFUNC(uasm_il_beqzl));
 
 void __uasminit
-uasm_il_bne(u32 **p, struct uasm_reloc **r, unsigned int reg1,
+ISAFUNC(uasm_il_bne)(u32 **p, struct uasm_reloc **r, unsigned int reg1,
 	unsigned int reg2, int lid)
 {
 	uasm_r_mips_pc16(r, *p, lid);
-	uasm_i_bne(p, reg1, reg2, 0);
+	ISAFUNC(uasm_i_bne)(p, reg1, reg2, 0);
 }
-UASM_EXPORT_SYMBOL(uasm_il_bne);
+UASM_EXPORT_SYMBOL(ISAFUNC(uasm_il_bne));
 
 void __uasminit
-uasm_il_bnez(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid)
+ISAFUNC(uasm_il_bnez)(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid)
 {
 	uasm_r_mips_pc16(r, *p, lid);
-	uasm_i_bnez(p, reg, 0);
+	ISAFUNC(uasm_i_bnez)(p, reg, 0);
 }
-UASM_EXPORT_SYMBOL(uasm_il_bnez);
+UASM_EXPORT_SYMBOL(ISAFUNC(uasm_il_bnez));
 
 void __uasminit
-uasm_il_bgezl(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid)
+ISAFUNC(uasm_il_bgezl)(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid)
 {
 	uasm_r_mips_pc16(r, *p, lid);
-	uasm_i_bgezl(p, reg, 0);
+	ISAFUNC(uasm_i_bgezl)(p, reg, 0);
 }
-UASM_EXPORT_SYMBOL(uasm_il_bgezl);
+UASM_EXPORT_SYMBOL(ISAFUNC(uasm_il_bgezl));
 
 void __uasminit
-uasm_il_bgez(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid)
+ISAFUNC(uasm_il_bgez)(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid)
 {
 	uasm_r_mips_pc16(r, *p, lid);
-	uasm_i_bgez(p, reg, 0);
+	ISAFUNC(uasm_i_bgez)(p, reg, 0);
 }
-UASM_EXPORT_SYMBOL(uasm_il_bgez);
+UASM_EXPORT_SYMBOL(ISAFUNC(uasm_il_bgez));
 
 void __uasminit
-uasm_il_bbit0(u32 **p, struct uasm_reloc **r, unsigned int reg,
+ISAFUNC(uasm_il_bbit0)(u32 **p, struct uasm_reloc **r, unsigned int reg,
 	      unsigned int bit, int lid)
 {
 	uasm_r_mips_pc16(r, *p, lid);
-	uasm_i_bbit0(p, reg, bit, 0);
+	ISAFUNC(uasm_i_bbit0)(p, reg, bit, 0);
 }
-UASM_EXPORT_SYMBOL(uasm_il_bbit0);
+UASM_EXPORT_SYMBOL(ISAFUNC(uasm_il_bbit0));
 
 void __uasminit
-uasm_il_bbit1(u32 **p, struct uasm_reloc **r, unsigned int reg,
+ISAFUNC(uasm_il_bbit1)(u32 **p, struct uasm_reloc **r, unsigned int reg,
 	      unsigned int bit, int lid)
 {
 	uasm_r_mips_pc16(r, *p, lid);
-	uasm_i_bbit1(p, reg, bit, 0);
+	ISAFUNC(uasm_i_bbit1)(p, reg, bit, 0);
 }
-UASM_EXPORT_SYMBOL(uasm_il_bbit1);
+UASM_EXPORT_SYMBOL(ISAFUNC(uasm_il_bbit1));
-- 
1.7.9.5
