Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Feb 2013 23:53:20 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:49920 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6824761Ab3BEWwSmiYHS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Feb 2013 23:52:18 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1U2rN6-0008Ky-6k; Tue, 05 Feb 2013 16:52:12 -0600
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org,
        cernekee@gmail.com, kevink@paralogos.com, ddaney.cavm@gmail.com
Subject: [PATCH 3/4] MIPS: microMIPS: uasm: Add microMIPS micro assembler support.
Date:   Tue,  5 Feb 2013 16:52:02 -0600
Message-Id: <1360104723-29529-4-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1360104723-29529-1-git-send-email-sjhill@mips.com>
References: <1360104723-29529-1-git-send-email-sjhill@mips.com>
X-archive-position: 35711
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

Add new file 'uasm-micromips.c' that allows the micro assembler
to generate microMIPS ISA code. It can be included in the kernel
alongside the classic ISA as long as the platform supports the
microMIPS ISA.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/Kconfig             |    4 +
 arch/mips/include/asm/uasm.h  |    4 +
 arch/mips/mm/Makefile         |    2 +
 arch/mips/mm/uasm-micromips.c |  220 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 230 insertions(+)
 create mode 100644 arch/mips/mm/uasm-micromips.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 47e3310..95ecc0a 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -351,6 +351,7 @@ config MIPS_SEAD3
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_SUPPORTS_SMARTMIPS
+	select SYS_SUPPORTS_MICROMIPS
 	select USB_ARCH_HAS_EHCI
 	select USB_EHCI_BIG_ENDIAN_DESC
 	select USB_EHCI_BIG_ENDIAN_MMIO
@@ -2117,6 +2118,9 @@ config SYS_SUPPORTS_HIGHMEM
 config SYS_SUPPORTS_SMARTMIPS
 	bool
 
+config SYS_SUPPORTS_MICROMIPS
+	bool
+
 config ARCH_FLATMEM_ENABLE
 	def_bool y
 	depends on !NUMA && !CPU_LOONGSON2
diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index f7d8f15..f924b87 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -23,6 +23,7 @@
 #endif
 
 #define _UASM_ISA_CLASSIC	0
+#define _UASM_ISA_MICROMIPS	1
 
 #ifndef UASM_ISA
 #define UASM_ISA	_UASM_ISA_CLASSIC
@@ -31,6 +32,9 @@
 #if (UASM_ISA == _UASM_ISA_CLASSIC)
 #define ISAOPC(op)	uasm_i##op
 #define ISAFUNC(x)	x
+#elif (UASM_ISA == _UASM_ISA_MICROMIPS)
+#define ISAOPC(op)	MM_uasm_i##op
+#define ISAFUNC(x)	MM_##x
 #else
 #error Unsupported micro-assembler ISA!!!
 #endif
diff --git a/arch/mips/mm/Makefile b/arch/mips/mm/Makefile
index 9e90c21..e87aae1 100644
--- a/arch/mips/mm/Makefile
+++ b/arch/mips/mm/Makefile
@@ -22,3 +22,5 @@ obj-$(CONFIG_IP22_CPU_SCACHE)	+= sc-ip22.o
 obj-$(CONFIG_R5000_CPU_SCACHE)	+= sc-r5k.o
 obj-$(CONFIG_RM7000_CPU_SCACHE) += sc-rm7k.o
 obj-$(CONFIG_MIPS_CPU_SCACHE)	+= sc-mips.o
+
+obj-$(CONFIG_SYS_SUPPORTS_MICROMIPS) += uasm-micromips.o
diff --git a/arch/mips/mm/uasm-micromips.c b/arch/mips/mm/uasm-micromips.c
new file mode 100644
index 0000000..476d50c
--- /dev/null
+++ b/arch/mips/mm/uasm-micromips.c
@@ -0,0 +1,220 @@
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
+ * Copyright (C) 2012, 2013   MIPS Technologies, Inc.  All rights reserved.
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/init.h>
+
+#include <asm/inst.h>
+#include <asm/elf.h>
+#include <asm/bugs.h>
+#define UASM_ISA	_UASM_ISA_MICROMIPS
+#include <asm/uasm.h>
+
+#define RS_MASK		0x1f
+#define RS_SH		16
+#define RT_MASK		0x1f
+#define RT_SH		21
+#define SCIMM_MASK	0x3ff
+#define SCIMM_SH	16
+
+/* This macro sets the non-variable bits of an instruction. */
+#define M(a, b, c, d, e, f)					\
+	((a) << OP_SH						\
+	 | (b) << RT_SH						\
+	 | (c) << RS_SH						\
+	 | (d) << RD_SH						\
+	 | (e) << RE_SH						\
+	 | (f) << FUNC_SH)
+
+/* Define these when we are not the ISA the kernel is being compiled with. */
+#ifndef CONFIG_CPU_MICROMIPS
+#define MM_uasm_i_b(buf, off) ISAOPC(_beq)(buf, 0, 0, off)
+#define MM_uasm_i_beqz(buf, rs, off) ISAOPC(_beq)(buf, rs, 0, off)
+#define MM_uasm_i_beqzl(buf, rs, off) ISAOPC(_beql)(buf, rs, 0, off)
+#define MM_uasm_i_bnez(buf, rs, off) ISAOPC(_bne)(buf, rs, 0, off)
+#endif
+
+#include "uasm.c"
+
+static struct insn insn_table_MM[] __uasminitdata = {
+	{ insn_addu, M(mm_pool32a_op, 0, 0, 0, 0, mm_addu32_op), RT | RS | RD },
+	{ insn_addiu, M(mm_addiu32_op, 0, 0, 0, 0, 0), RT | RS | SIMM },
+	{ insn_and, M(mm_pool32a_op, 0, 0, 0, 0, mm_and_op), RT | RS | RD },
+	{ insn_andi, M(mm_andi32_op, 0, 0, 0, 0, 0), RT | RS | UIMM },
+	{ insn_beq, M(mm_beq32_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
+	{ insn_beql, 0, 0 },
+	{ insn_bgez, M(mm_pool32i_op, mm_bgez_op, 0, 0, 0, 0), RS | BIMM },
+	{ insn_bgezl, 0, 0 },
+	{ insn_bltz, M(mm_pool32i_op, mm_bltz_op, 0, 0, 0, 0), RS | BIMM },
+	{ insn_bltzl, 0, 0 },
+	{ insn_bne, M(mm_bne32_op, 0, 0, 0, 0, 0), RT | RS | BIMM },
+	{ insn_cache, M(mm_pool32b_op, 0, 0, mm_cache_func, 0, 0), RT | RS | SIMM },
+	{ insn_daddu, 0, 0 },
+	{ insn_daddiu, 0, 0 },
+	{ insn_dmfc0, 0, 0 },
+	{ insn_dmtc0, 0, 0 },
+	{ insn_dsll, 0, 0 },
+	{ insn_dsll32, 0, 0 },
+	{ insn_dsra, 0, 0 },
+	{ insn_dsrl, 0, 0 },
+	{ insn_dsrl32, 0, 0 },
+	{ insn_drotr, 0, 0 },
+	{ insn_drotr32, 0, 0 },
+	{ insn_dsubu, 0, 0 },
+	{ insn_eret, M(mm_pool32a_op, 0, 0, 0, mm_eret_op, mm_pool32axf_op), 0 },
+	{ insn_ins, M(mm_pool32a_op, 0, 0, 0, 0, mm_ins_op), RT | RS | RD | RE },
+	{ insn_ext, M(mm_pool32a_op, 0, 0, 0, 0, mm_ext_op), RT | RS | RD | RE },
+	{ insn_j, M(mm_j32_op, 0, 0, 0, 0, 0), JIMM },
+	{ insn_jal, M(mm_jal32_op, 0, 0, 0, 0, 0), JIMM },
+	{ insn_jr, M(mm_pool32a_op, 0, 0, 0, mm_jalr_op, mm_pool32axf_op), RS },
+	{ insn_ld, 0, 0 },
+	{ insn_ll, M(mm_pool32c_op, 0, 0, (mm_ll_func << 1), 0, 0), RS | RT | SIMM },
+	{ insn_lld, 0, 0 },
+	{ insn_lui, M(mm_pool32i_op, mm_lui_op, 0, 0, 0, 0), RS | SIMM },
+	{ insn_lw, M(mm_lw32_op, 0, 0, 0, 0, 0), RT | RS | SIMM },
+	{ insn_mfc0, M(mm_pool32a_op, 0, 0, 0, mm_mfc0_op, mm_pool32axf_op), RT | RS | RD },
+	{ insn_mtc0, M(mm_pool32a_op, 0, 0, 0, mm_mtc0_op, mm_pool32axf_op), RT | RS | RD },
+	{ insn_or, M(mm_pool32a_op, 0, 0, 0, 0, mm_or32_op), RT | RS | RD },
+	{ insn_ori, M(mm_ori32_op, 0, 0, 0, 0, 0), RT | RS | UIMM },
+	{ insn_pref, M(mm_pool32c_op, 0, 0, (mm_pref_func << 1), 0, 0), RT | RS | SIMM },
+	{ insn_rfe, 0, 0 },
+	{ insn_sc, M(mm_pool32c_op, 0, 0, (mm_sc_func << 1), 0, 0), RT | RS | SIMM },
+	{ insn_scd, 0, 0 },
+	{ insn_sd, 0, 0 },
+	{ insn_sll, M(mm_pool32a_op, 0, 0, 0, 0, mm_sll32_op), RT | RS | RD },
+	{ insn_sra, M(mm_pool32a_op, 0, 0, 0, 0, mm_sra_op), RT | RS | RD },
+	{ insn_srl, M(mm_pool32a_op, 0, 0, 0, 0, mm_srl32_op), RT | RS | RD },
+	{ insn_rotr, M(mm_pool32a_op, 0, 0, 0, 0, mm_rotr_op), RT | RS | RD },
+	{ insn_subu, M(mm_pool32a_op, 0, 0, 0, 0, mm_subu32_op), RT | RS | RD },
+	{ insn_sw, M(mm_sw32_op, 0, 0, 0, 0, 0), RT | RS | SIMM },
+	{ insn_tlbp, M(mm_pool32a_op, 0, 0, 0, mm_tlbp_op, mm_pool32axf_op), 0 },
+	{ insn_tlbr, M(mm_pool32a_op, 0, 0, 0, mm_tlbr_op, mm_pool32axf_op), 0 },
+	{ insn_tlbwi, M(mm_pool32a_op, 0, 0, 0, mm_tlbwi_op, mm_pool32axf_op), 0 },
+	{ insn_tlbwr, M(mm_pool32a_op, 0, 0, 0, mm_tlbwr_op, mm_pool32axf_op), 0 },
+	{ insn_xor, M(mm_pool32a_op, 0, 0, 0, 0, mm_xor32_op), RT | RS | RD },
+	{ insn_xori, M(mm_xori32_op, 0, 0, 0, 0, 0), RT | RS | UIMM },
+	{ insn_dins, 0, 0 },
+	{ insn_dinsm, 0, 0 },
+	{ insn_syscall, M(mm_pool32a_op, 0, 0, 0, mm_syscall_op, mm_pool32axf_op), SCIMM},
+	{ insn_bbit0, 0, 0 },
+	{ insn_bbit1, 0, 0 },
+	{ insn_lwx, 0, 0 },
+	{ insn_ldx, 0, 0 },
+	{ insn_invalid, 0, 0 }
+};
+
+#undef M
+
+static inline __uasminit u32 build_bimm(s32 arg)
+{
+	WARN(arg > 0xffff || arg < -0x10000,
+	     KERN_WARNING "Micro-assembler field overflow\n");
+
+	WARN(arg & 0x3, KERN_WARNING "Invalid micro-assembler branch target\n");
+
+	return ((arg < 0) ? (1 << 15) : 0) | ((arg >> 1) & 0x7fff);
+}
+
+static inline __uasminit u32 build_jimm(u32 arg)
+{
+	WARN(arg & ~(JIMM_MASK << 2),
+	     KERN_WARNING "Micro-assembler field overflow\n");
+
+	return (arg >> 1) & JIMM_MASK;
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
+	for (i = 0; insn_table_MM[i].opcode != insn_invalid; i++)
+		if (insn_table_MM[i].opcode == opc) {
+			ip = &insn_table_MM[i];
+			break;
+		}
+
+	if (!ip || (opc == insn_daddiu && r4k_daddiu_bug()))
+		panic("Unsupported Micro-assembler instruction %d", opc);
+
+	op = ip->match;
+	va_start(ap, opc);
+	if (ip->fields & RS) {
+		if (opc == insn_mfc0 || opc == insn_mtc0)
+			op |= build_rt(va_arg(ap, u32));
+		else
+			op |= build_rs(va_arg(ap, u32));
+	}
+	if (ip->fields & RT) {
+		if (opc == insn_mfc0 || opc == insn_mtc0)
+			op |= build_rs(va_arg(ap, u32));
+		else
+			op |= build_rt(va_arg(ap, u32));
+	}
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
+#ifdef CONFIG_CPU_LITTLE_ENDIAN
+	**buf = ((op & 0xffff) << 16) | (op >> 16);
+#else
+	**buf = op;
+#endif
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
+#ifdef CONFIG_CPU_LITTLE_ENDIAN
+		*rel->addr |= (build_bimm(laddr - (raddr + 4)) << 16);
+#else
+		*rel->addr |= build_bimm(laddr - (raddr + 4));
+#endif
+		break;
+
+	default:
+		panic("Unsupported Micro-assembler relocation %d",
+		      rel->type);
+	}
+}
-- 
1.7.9.5
