Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jul 2011 01:36:51 +0200 (CEST)
Received: from sj-iport-5.cisco.com ([171.68.10.87]:42815 "EHLO
        sj-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491175Ab1GFXg1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jul 2011 01:36:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=dvomlehn@cisco.com; l=139599; q=dns/txt;
  s=iport; t=1309995383; x=1311204983;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7W8L6MKo+E6XN+QluyqwLHJda0m4XDXf1RzW2niEle0=;
  b=AO15J5+nTaTPbNhPBBQMMTmA2Exvrnmz7cSE7OkeH1Ic6WqBGqXsouE0
   HXfnnvkFeUsJWS180gxQyBAcVx5wPbhwCZORelbVIW2zR3inpeFB6GURl
   +ewIQWojKDGVufkVFT5vvT9xw8QcgyPICI8hIaxssGqDDJO5sZD9NboDf
   E=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EAMXwFE6rRDoJ/2dsb2JhbABTqAt3rVidfIY3BIdGm1g
X-IronPort-AV: E=Sophos;i="4.65,489,1304294400"; 
   d="scan'208";a="362807677"
Received: from mtv-core-4.cisco.com ([171.68.58.9])
  by sj-iport-5.cisco.com with ESMTP; 06 Jul 2011 23:36:15 +0000
Received: from dvomlehn-lnx2.corp.sa.net (dhcp-171-71-47-241.cisco.com [171.71.47.241])
        by mtv-core-4.cisco.com (8.14.3/8.14.3) with ESMTP id p66NaEIq001369;
        Wed, 6 Jul 2011 23:36:14 GMT
Date:   Wed, 6 Jul 2011 16:36:15 -0700
From:   David VomLehn <dvomlehn@cisco.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH 1/1] Pendantic stack backtrace code
Message-ID: <20110706233614.GA19332@dvomlehn-lnx2.corp.sa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 30586
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4599

This is the much updated version of the MIPS stack backtrace code submitted
a few years ago. It has a few bugs fixed and should be easier to understand
as a result of a signficant rewrite. There are some references to 64-bit
support, but support is not complete. As a result, this is only enabled
for 32-bit systems.

The code does code analysis according to the o32 backtracing rules, plus
using information the kernel knows and a few simple heuristics. There are
a few things no such backtracer can do, but it handles quite a large
number of cases.

In addition to simple backtracing, the code also traces over exception
frames.  So, if you have an exception handler that panics, you will be able
to see how the code got to where the exception occurred.

This file contains one cleanpatch.pl false positive:
arch/mips/kernel/backtrace/kernel-backtrace-symbols.c: A preprocessor macro
used to create declarations has "extern" in the macro body.

Signed-off-by: David VomLehn <dvomlehn@cisco.com>
---
 arch/mips/Kconfig.debug                          |   11 +
 arch/mips/include/asm/base-backtrace.h           |  440 ++++++
 arch/mips/include/asm/kernel-backtrace-symbols.h |  151 ++
 arch/mips/include/asm/kernel-backtrace.h         |  101 ++
 arch/mips/include/asm/sigframe.h                 |   39 +
 arch/mips/include/asm/thread-backtrace.h         |   87 ++
 arch/mips/kernel/entry.S                         |   17 +-
 arch/mips/kernel/scall32-o32.S                   |   10 +-
 arch/mips/kernel/signal.c                        |   15 +-
 arch/mips/kernel/traps.c                         |   78 +-
 arch/mips/kernel/vdso.c                          |    8 +-
 arch/mips/lib/Makefile                           |    3 +
 arch/mips/lib/base-backtrace.c                   | 1679 ++++++++++++++++++++++
 arch/mips/lib/kernel-backtrace-symbols.c         |   41 +
 arch/mips/lib/kernel-backtrace.c                 | 1080 ++++++++++++++
 arch/mips/lib/thread-backtrace.c                 |  289 ++++
 scripts/module-common.lds                        |   19 -
 17 files changed, 4020 insertions(+), 48 deletions(-)

diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
index 83ed00a..af3582c 100644
--- a/arch/mips/Kconfig.debug
+++ b/arch/mips/Kconfig.debug
@@ -121,6 +121,17 @@ config DEBUG_ZBOOT
 	  to reduce the kernel image size and speed up the booting procedure a
 	  little.
 
+config MIPS_PEDANTIC_BACKTRACE
+	bool "More comprehensive backtrace code"
+	default n
+	depends on KALLSYMS && 32BIT
+	help
+	  Use backtrace code that more completely handles the various
+	  complexities of the MIPS processors, including branch delay
+	  slots. This is substantially larger than the standard backtrace
+	  code. It also allows tracing over exception frames, which is
+	  occasionally very useful.
+
 config SPINLOCK_TEST
 	bool "Enable spinlock timing tests in debugfs"
 	depends on DEBUG_FS
diff --git a/arch/mips/include/asm/base-backtrace.h b/arch/mips/include/asm/base-backtrace.h
new file mode 100644
index 0000000..ddc61d1
--- /dev/null
+++ b/arch/mips/include/asm/base-backtrace.h
@@ -0,0 +1,440 @@
+/*
+ * Definitions handling one stack frame's worth of stack backtrace.
+ *
+ * Copyright(C) 2007  Scientific-Atlanta, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef	_BASE_BACKTRACE_H_
+#define	_BASE_BACKTRACE_H_
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/stddef.h>
+#include <linux/module.h>
+#include <linux/string.h>
+
+#include <asm/inst.h>
+#include <asm/ptrace.h>
+#include <asm/errno.h>
+
+#define	dbg_print	printk
+
+#define	PRIORITY	KERN_CRIT
+
+#undef DEBUG
+
+#ifdef	DEBUG
+#define bt_dbg(fmt, ...)	do {					\
+			dbg_print("%s: " fmt, __func__, ##__VA_ARGS__); \
+		} while (0)
+
+static const char *const backtrace_rule[] = {
+	"o32 ABI", "bounded"
+};
+#else
+#define bt_dbg(fmt, ...)	do { } while (0)
+#endif
+
+/*
+ * Value to be returned by functions that processes each frame to indicate
+ * a non-error termination of the backtrace. Errors cause a negative errno
+ * to be returned and a frame that does not terminate the back trace cause
+ * a zero to be returned.
+ */
+#define	BASE_BT_END_NULL_PC	1
+#define BASE_BT_N_END		1
+
+/*
+ * Macros for loading addresses and storing registers:
+ * LOAD_ADDR    Load the address of the given object into the $at register
+ * STORE_REG    Store the given register. Assumes that $at points to the
+ *              location for the store.
+ */
+#ifdef CONFIG_64BIT
+#warning TODO: 64-bit code needs to be verified
+#define LOAD_ADDR(obj)  "dla    $at," #obj "\n"
+#define STORE_REG(reg)  "sd     " #reg ",0($at)\n"
+#endif
+
+#ifdef CONFIG_32BIT
+#define LOAD_ADDR(obj)  "la     $at," #obj "\n"
+#define STORE_REG(reg)  "sw     " #reg ",0($at)\n"
+#endif
+
+/*
+ * __base_backtrace_here - set the PC, SP, and return address for current func
+ * @bbt:	Pointer to the &struct base_bt to set
+ */
+#define __base_backtrace_here(bbt)		do {			\
+			register unsigned long s0 asm("s0");		\
+			register unsigned long s1 asm("s1");		\
+			register unsigned long s2 asm("s2");		\
+			register unsigned long s3 asm("s3");		\
+			register unsigned long s4 asm("s4");		\
+			register unsigned long s5 asm("s5");		\
+			register unsigned long s6 asm("s6");		\
+			register unsigned long s7 asm("s7");		\
+			register unsigned long fp asm("fp");		\
+			register unsigned long gp asm("gp");		\
+			(bbt)->pc = __base_backtrace_here_pc();		\
+			(bbt)->sp = __builtin_frame_address(0);		\
+			(bbt)->ra = __builtin_return_address(0);	\
+			(bbt)->gprs[SREG_S0].value = s0;		\
+			(bbt)->gprs[SREG_S1].value = s1;		\
+			(bbt)->gprs[SREG_S2].value = s2;		\
+			(bbt)->gprs[SREG_S3].value = s3;		\
+			(bbt)->gprs[SREG_S4].value = s4;		\
+			(bbt)->gprs[SREG_S5].value = s5;		\
+			(bbt)->gprs[SREG_S6].value = s6;		\
+			(bbt)->gprs[SREG_S7].value = s7;		\
+			(bbt)->gprs[SREG_S8].value = fp;		\
+			(bbt)->gprs[SREG_GP].value = gp;		\
+			(bbt)->gprs[SREG_RA].value = (unsigned long)(bbt)->ra;\
+			(bbt)->gprs[SREG_S0].read = true;		\
+			(bbt)->gprs[SREG_S1].read = true;		\
+			(bbt)->gprs[SREG_S2].read = true;		\
+			(bbt)->gprs[SREG_S3].read = true;		\
+			(bbt)->gprs[SREG_S4].read = true;		\
+			(bbt)->gprs[SREG_S5].read = true;		\
+			(bbt)->gprs[SREG_S6].read = true;		\
+			(bbt)->gprs[SREG_S7].read = true;		\
+			(bbt)->gprs[SREG_S8].read = true;		\
+			(bbt)->gprs[SREG_GP].read = true;		\
+			(bbt)->gprs[SREG_RA].read = true;		\
+			(bbt)->next_pc = NULL;				\
+		} while (0)
+
+/*
+ * base_backtrace_first - process the first stack frame.
+ * @bt:	Pointer to struct base_bt object.
+ * Returns:	Zero on success, otherwise a negative errno value.
+ *		A value of -ENOSYS indicates that the $pc and $sp are valid
+ *		but we can't continue the backtrace.
+ */
+#define base_backtrace_first(bbt, rule)		({			\
+			memset(bbt, 0, sizeof(*(bbt)));			\
+			__base_backtrace_here(bbt);			\
+			__base_backtrace_analyze_frame(bbt, rule);	\
+		})
+
+/* General purpose register (GPR) numbers */
+enum mips_reg_num {
+	MREG_ZERO,	MREG_AT,	MREG_V0,	MREG_V1,
+	MREG_A0,	MREG_A1,	MREG_A2,	MREG_A3,
+	MREG_T0,	MREG_T1,	MREG_T2,	MREG_T3,
+	MREG_T4,	MREG_T5,	MREG_T6,	MREG_T7,
+	MREG_S0,	MREG_S1,	MREG_S2,	MREG_S3,
+	MREG_S4,	MREG_S5,	MREG_S6,	MREG_S7,
+	MREG_T8,	MREG_T9,	MREG_K0,	MREG_K1,
+	MREG_GP,	MREG_SP,	MREG_S8,	MREG_RA,
+	N_MREGS		/* This last one is the number of GPRs */
+};
+
+/* Indices into list of GPRs that must be saved before use */
+enum saved_gpr_num {
+	SREG_S0,	SREG_S1,	SREG_S2,	SREG_S3,
+	SREG_S4,	SREG_S5,	SREG_S6,	SREG_S7,
+	SREG_GP,	SREG_S8,	SREG_RA,
+	N_SREGS		/* Number of saved gprs */
+};
+
+/* True if the corresponding MIPS register must be saved before use */
+extern const bool save_before_use[N_MREGS];
+
+/* Convert saved_gpr_num to mips_reg_num */
+extern const enum mips_reg_num sreg_to_mreg[N_SREGS];
+
+/* Convert mips_reg_num to saved_gpr_num */
+extern const enum saved_gpr_num mreg_to_sreg[N_MREGS];
+
+/*
+ * Additional instruction formats that might be nice to define in
+ * asm/inst.h
+ * */
+#ifdef	__MIPSEB__
+	struct	any_format {		/* Generic format */
+		unsigned int opcode:6;
+		unsigned int remainder:26;
+	};
+
+	struct syscall_format {
+		unsigned int opcode:6;
+		unsigned int code:20;
+		unsigned int func:6;
+	};
+
+	struct	eret_format {
+		unsigned int opcode:6;
+		unsigned int co:1;
+		unsigned int zero:19;
+		unsigned int func:6;
+	};
+#else
+	struct	any_format {		/* Generic format */
+		unsigned int remainder:26;
+		unsigned int opcode:6;
+	};
+
+	struct syscall_format {
+		unsigned int func:6;
+		unsigned int code:20;
+		unsigned int opcode:6;
+	};
+
+	struct	eret_format {
+		unsigned int func:6;
+		unsigned int zero:19;
+		unsigned int co:1;
+		unsigned int opcode:6;
+	};
+#endif
+
+/* Rules for interpreting a stack frame */
+enum base_bt_rule {
+	BASE_BACKTRACE_O32_ABI,	/* Backtrace using o32 ABI rules */
+	BASE_BACKTRACE_LOOKUP_FUNC,	/* Look up function start and size */
+};
+
+struct base_bt_gpr_info {
+	unsigned long	value;
+	bool		read;
+};
+
+/*
+ * struct base_bt - data passed in to and return from a single frame backtrace
+ * @pc:			Program counter
+ * @sp:			Stack pointer value
+ * @fp:			Start of stack frame, which is the same as @sp if
+ *			the stack pointer is being used as the frame poiner
+ * @frame_size:		Number of bytes in this stack frame
+ * @ra:			Address from which this function was called
+ */
+struct base_bt {
+	mips_instruction	*pc;
+	unsigned long		*sp;
+	unsigned long		*fp;
+	unsigned long		frame_size;
+	mips_instruction	*ra;
+	/* This is data to help set the registers for getting the next frame */
+	int			framepointer;
+	struct base_bt_gpr_info	gprs[N_SREGS];
+	mips_instruction	*next_pc;
+};
+
+/*
+ * Helper functions for code analysis
+ */
+
+/* Opcode: addu */
+static inline int is_addu_noreg(mips_instruction inst)
+{
+	struct r_format	*op_p = (struct r_format *)&inst;
+	return op_p->opcode == spec_op && op_p->func == addu_op &&
+			op_p->re == 0;
+}
+
+/* Opcode: inline addu rd, rs, rt */
+static inline int is_addu(mips_instruction inst, unsigned long rd,
+	unsigned long rs, unsigned long rt)
+{
+	struct r_format	*op_p = (struct r_format *)&inst;
+	return is_addu_noreg(inst) &&
+		op_p->rd == rd && op_p->rs == rs && op_p->rt == rt;
+}
+
+/* Opcode: addiu rs, rt, imm */
+static inline int is_addiu(mips_instruction inst, unsigned long rs,
+	unsigned long rt)
+{
+	struct i_format *op_p = (struct i_format *)&inst;
+	return op_p->opcode == addiu_op &&
+		op_p->rs == rs &&  op_p->rt == rt;
+}
+
+/*
+ * is_li determine whether instruction is from an "li" pseudo-instruction
+ * @inst:	Instruction to check
+ * @rt:		Destination register
+ */
+static inline int is_li(mips_instruction inst, unsigned long rt)
+{
+	return is_addiu(inst, MREG_ZERO, rt);
+}
+
+/* Opcode: eret */
+static inline int is_eret(mips_instruction inst)
+{
+	struct eret_format *op_p = (struct eret_format *)&inst;
+	return op_p->opcode == cop0_op && op_p->func == eret_op &&
+		op_p->co == 1 && op_p->zero == 0;
+}
+
+/*
+ * has_bds - determine whether the instruction has a branch delay slot
+ * @op:	Instruction to check
+ *
+ * Returns true if the instruction has a branch delay slot, false otherwise.
+ */
+static inline bool has_bds(mips_instruction op)
+{
+	struct any_format	*op_p = (struct any_format *)&op;
+	struct r_format		*op_p_r;
+	struct i_format		*op_p_i;
+
+	switch (op_p->opcode) {
+	case j_op:
+	case jal_op:
+	case beq_op:
+	case bne_op:
+	case blez_op:
+	case bgtz_op:
+	case beql_op:
+	case bnel_op:
+	case blezl_op:
+	case bgtzl_op:
+		return true;
+		break;
+
+	case spec_op:
+		op_p_r = (struct r_format *)&op;
+		return (op_p_r->func == jr_op || op_p_r->func == jalr_op) &&
+			op_p_r->rt == 0 && op_p_r->rd == 0;
+		break;
+
+	case bcond_op:
+		op_p_i = (struct i_format *)&op;
+		switch (op_p_i->rt) {
+		case bltz_op:
+		case bgez_op:
+		case bltzl_op:
+		case bgezl_op:
+		case bltzal_op:
+		case bgezal_op:
+		case bltzall_op:
+		case bgezall_op:
+			return true;
+			break;
+
+		default:
+			return false;
+			break;
+		}
+		break;
+
+	default:
+		break;
+	}
+
+	return false;
+}
+
+
+/*
+ * is_bb_end - is the given instruction one that ends basic blocks?
+ * @op:	instruction to check
+ *
+ * Returns true if the instruction is one that ends basic blocks, false
+ * if it is not.
+ *
+ * Basic blocks, at least as defined for MIPS backtracing, are ended by
+ * jumps and branches that don't return, and the ERET instructions
+ */
+static inline bool is_bb_end(mips_instruction op)
+{
+	struct any_format	*op_p = (struct any_format *)&op;
+	struct r_format		*op_p_r;
+	struct i_format		*op_p_i;
+	struct eret_format	*op_p_eret;
+
+	switch (op_p->opcode) {
+	case j_op:
+	case beq_op:
+	case bne_op:
+	case blez_op:
+	case bgtz_op:
+	case beql_op:
+	case bnel_op:
+	case blezl_op:
+	case bgtzl_op:
+		return true;
+		break;
+
+	case spec_op:
+		op_p_r = (struct r_format *)&op;
+		return (op_p_r->func == jr_op) &&
+			op_p_r->rt == 0 && op_p_r->rd == 0;
+		break;
+
+	case bcond_op:
+		op_p_i = (struct i_format *)&op;
+		switch (op_p_i->rt) {
+		case bltz_op:
+		case bgez_op:
+		case bltzl_op:
+		case bgezl_op:
+			return true;
+			break;
+
+		default:
+			return false;
+			break;
+		}
+		break;
+
+	case cop0_op:
+		op_p_eret = (struct eret_format *)&op;
+		if (op_p_eret->func == eret_op && op_p_eret->co == 1 &&
+			op_p_eret->zero == 0)
+			return true;
+		break;
+
+	default:
+		break;
+	}
+
+	return false;
+}
+
+/* Internal backtrace functions */
+extern void __base_backtrace_set_from_pt_regs(struct base_bt *bbt,
+	const struct pt_regs *regs);
+extern mips_instruction *__base_backtrace_here_pc(void);
+extern int __base_backtrace_analyze_frame(struct base_bt *bbt,
+	enum base_bt_rule rule);
+
+/*
+ * Functions that are required by the base-backtrace.c code but which must
+ * be supplied by users of that code.
+ * bt_ip_lookup - Look up the symbol start and size, given an address
+ * bt_get_op - Get an opcode-sized element.
+ * bt_get_reg - Get a register-sized element.
+ */
+extern int bt_symbol_lookup(mips_instruction *ip, mips_instruction **start,
+	unsigned long *size);
+extern int bt_get_op(mips_instruction *ip, mips_instruction *op);
+extern int bt_get_reg(unsigned long *rp, unsigned long *reg);
+
+/* Functions exported from the base backtrace code */
+extern int base_backtrace_pop_frame(struct base_bt *bbt);
+extern int base_backtrace_next(struct base_bt *bbt, enum base_bt_rule rule);
+extern int base_backtrace_first_from_pt_regs(struct base_bt *bt,
+	enum base_bt_rule rule, const struct pt_regs *regs);
+extern int base_backtrace_analyze_frame(struct base_bt *bt,
+	enum base_bt_rule rule);
+extern int base_backtrace_pop_frame(struct base_bt *bbt);
+extern int __base_backtrace_generic_pop_frame(struct base_bt *bbt);
+#endif	/* _BASE_BACKTRACE_H_ */
diff --git a/arch/mips/include/asm/kernel-backtrace-symbols.h b/arch/mips/include/asm/kernel-backtrace-symbols.h
new file mode 100644
index 0000000..ed980f3
--- /dev/null
+++ b/arch/mips/include/asm/kernel-backtrace-symbols.h
@@ -0,0 +1,151 @@
+/*
+ *			kernel-backtrace-symbols.h
+ *
+ * This file contains symbols that need to be handled specially. The
+ * idea is that code will define a macro named SPECIAL_SYMBOL that
+ * appropriately generates code for an external reference, then redefines
+ * it to generate a table with the symbols.
+ *
+ * It should be mentioned that, though this is not especially pretty, having
+ * this list of symbols in only one place makes it impossible to define
+ * the external reference for the symbol and then forget to add it to the
+ * table of symbols, which is a big win on the maintenance front.
+ *
+ * To make this list easier to maintain, it is best to keep the symbols
+ * for a given file together and in the order in which they appear in that
+ * file.
+ *
+ * Copyright (C) 2007  Scientific-Atlanta, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+/* The first part is protected against multiple inclusions, but the
+ * rest isn't */
+#ifndef	_KERNEL_BACKTRACE_SYMBOLS_H_
+#define	_KERNEL_BACKTRACE_SYMBOLS_H_
+#include <asm/inst.h>
+#include <asm/kernel-backtrace.h>
+
+struct kern_special_sym {
+	const mips_instruction	*start;
+	enum kernel_bt_type	type;
+};
+
+extern const struct kern_special_sym kernel_backtrace_symbols[];
+extern unsigned kernel_backtrace_symbols_size;
+#endif	/* _KERNEL_BACKTRACE_SYMBOLS_H_ */
+
+/* Only define the symbol list if someone has defined the macro we use
+ * to construct it. This allows the above symbols to be included even by
+ * things which only reference the list. */
+
+#ifdef	SPECIAL_SYMBOL
+/* arch/mips/kernel/entry.S */
+SPECIAL_SYMBOL(ret_from_exception, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(ret_from_irq, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(resume_userspace, KERNEL_FRAME_GLUE)
+#ifdef CONFIG_PREEMPT
+SPECIAL_SYMBOL(resume_kernel, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(_need_resched, KERNEL_FRAME_GLUE)
+#endif
+SPECIAL_SYMBOL(ret_from_fork, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(syscall_exit, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(restore_all, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(restore_partial, KERNEL_FRAME_RESTORE_SOME)
+SPECIAL_SYMBOL(work_pending, KERNEL_FRAME_RESTORE_SOME)
+SPECIAL_SYMBOL(work_resched, KERNEL_FRAME_RESTORE_SOME)
+SPECIAL_SYMBOL(work_notifysig, KERNEL_FRAME_RESTORE_SOME)
+SPECIAL_SYMBOL(syscall_exit_work_partial, KERNEL_FRAME_SAVE_STATIC)
+SPECIAL_SYMBOL(syscall_exit_work, KERNEL_FRAME_GLUE)
+
+/* arch/mips/kernel/genex.S */
+SPECIAL_SYMBOL(except_vec_vi_end, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(except_vec_vi_handler, KERNEL_FRAME_SAVE_STATIC)
+SPECIAL_SYMBOL(handle_adel, KERNEL_FRAME_SAVE_ALL)
+SPECIAL_SYMBOL(handle_adel_int, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(handle_ades, KERNEL_FRAME_SAVE_ALL)
+SPECIAL_SYMBOL(handle_ades_int, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(handle_ibe, KERNEL_FRAME_SAVE_ALL)
+SPECIAL_SYMBOL(handle_ibe_int, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(handle_dbe, KERNEL_FRAME_SAVE_ALL)
+SPECIAL_SYMBOL(handle_dbe_int, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(handle_bp, KERNEL_FRAME_SAVE_ALL)
+SPECIAL_SYMBOL(handle_bp_int, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(handle_ri, KERNEL_FRAME_SAVE_ALL)
+SPECIAL_SYMBOL(handle_ri_int, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(handle_cpu, KERNEL_FRAME_SAVE_ALL)
+SPECIAL_SYMBOL(handle_cpu_int, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(handle_ov, KERNEL_FRAME_SAVE_ALL)
+SPECIAL_SYMBOL(handle_ov_int, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(handle_tr, KERNEL_FRAME_SAVE_ALL)
+SPECIAL_SYMBOL(handle_tr_int, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(handle_fpe, KERNEL_FRAME_SAVE_ALL)
+SPECIAL_SYMBOL(handle_fpe_int, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(handle_mdmx, KERNEL_FRAME_SAVE_ALL)
+SPECIAL_SYMBOL(handle_mdmx_int, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(handle_watch, KERNEL_FRAME_SAVE_ALL)
+SPECIAL_SYMBOL(handle_watch_int, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(handle_mcheck, KERNEL_FRAME_SAVE_ALL)
+SPECIAL_SYMBOL(handle_mcheck_int, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(handle_mt, KERNEL_FRAME_SAVE_ALL)
+SPECIAL_SYMBOL(handle_mt_int, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(handle_dsp, KERNEL_FRAME_SAVE_ALL)
+SPECIAL_SYMBOL(handle_dsp_int, KERNEL_FRAME_GLUE)
+
+/* arch/mips/kernel/scall32-o32.S */
+#ifdef	CONFIG_32BIT
+SPECIAL_SYMBOL(handle_sys, KERNEL_FRAME_SAVE_SOME)
+SPECIAL_SYMBOL(stack_done, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(o32_syscall_exit, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(o32_syscall_exit_work, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(syscall_trace_entry, KERNEL_FRAME_SAVE_STATIC)
+SPECIAL_SYMBOL(stackargs, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(_bad_stack, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(illegal_syscall, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(sys_sysmips, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(sys_syscall, KERNEL_FRAME_GLUE)
+SPECIAL_SYMBOL(einval, KERNEL_FRAME_GLUE)
+#endif
+
+/* arch/mips/kernel/scall64-64.S */
+#ifdef	CONFIG_64BIT
+#warning TODO: include symbols for arch/mips/kernel/scall64-64.S
+#endif
+
+/* arch/mips/kernel/scall64-n32.S */
+#ifdef	CONFIG_MIPS32_N32
+#warning TODO: include symbols for arch/mips/kernel/scall64-n32.S
+#endif
+
+/* arch/mips/kernel/scall64-o32.S */
+#ifdef	CONFIG_MIPS32_O32
+#warning TODO: include symbols for arch/mips/kernel/scall64-o32.S
+#endif
+
+/* arch/mips/kernel/smtc-asm.S */
+#ifdef	CONFIG_MIPS32_MT_SMTC
+#warning TODO: include symbols for arch/mips/kernel/smtc-asm.S
+#endif
+
+/* arch/mips/mm/tlbex-fault.S */
+SPECIAL_SYMBOL(tlb_do_page_fault_0, KERNEL_FRAME_SAVE_ALL)
+SPECIAL_SYMBOL(tlb_do_page_fault_1, KERNEL_FRAME_SAVE_ALL)
+
+/* arch/mips/mm/tlbex.c (Code generated dynamically) */
+SPECIAL_SYMBOL(handle_tlbl, KERNEL_FRAME_K0_K1_ONLY)
+SPECIAL_SYMBOL(handle_tlbm, KERNEL_FRAME_K0_K1_ONLY)
+SPECIAL_SYMBOL(handle_tlbs, KERNEL_FRAME_K0_K1_ONLY)
+#endif	/* SPECIAL_SYMBOL */
diff --git a/arch/mips/include/asm/kernel-backtrace.h b/arch/mips/include/asm/kernel-backtrace.h
new file mode 100644
index 0000000..0b28c31
--- /dev/null
+++ b/arch/mips/include/asm/kernel-backtrace.h
@@ -0,0 +1,101 @@
+/*
+ *				kernel-backtrace.h
+ *
+ * Definitions for stack backtracing in the kernel. In addition to handle
+ * process backtraces, because kernel threads can get signals, too, this has
+ * to handle interrupts and exceptions.
+ *
+ * Copyright (C) 2007  Scientific-Atlanta, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef	_ASM_KERNEL_BACKTRACE_H_
+#define	_ASM_KERNEL_BACKTRACE_H_
+
+#include <asm/thread-backtrace.h>
+
+/* Frame type for kernel frame analysis */
+enum kernel_bt_type {
+	KERNEL_FRAME_THREAD,
+	KERNEL_FRAME_TLB_REFILL,	/* In the general exception vector */
+	KERNEL_FRAME_GENERAL_EXCEPTION,	/* In the general exception vector */
+	KERNEL_FRAME_INTERRUPT,		/* In the general exception vector */
+	KERNEL_FRAME_K0_K1_ONLY,	/* Code uses only $k0 & $k1 registers */
+	KERNEL_FRAME_SAVE_SOME,		/* Code uses SAVE_SOME macro */
+	KERNEL_FRAME_SAVE_STATIC,	/* Code uses SAVE_STATIC macro */
+	KERNEL_FRAME_SAVE_ALL,		/* Code uses SAVE_ALL macro */
+	KERNEL_FRAME_GLUE,		/* Registers saved in struct pt_regs */
+	KERNEL_FRAME_RESTORE_SOME,	/* Code uses RESTORE_SOME macro */
+	KERNEL_FRAME_UNEXPECTED		/* Never expect to be in this code */
+};
+
+/*
+ * Postive, non-zero codes returned for normal termination of backtraces.
+ * These extend the codes returned by other layers of the backtrace code
+ * so a unified presentation of backtrace termination is possible.
+ */
+#define	KERNEL_BT_END_CTX_SWITCH	(BASE_BT_N_END + 1)
+#define KERNEL_BT_END_IN_START_KERNEL	(KERNEL_BT_END_CTX_SWITCH + 1)
+#define KERNEL_BT_END_NULL_PC		(KERNEL_BT_END_IN_START_KERNEL + 1)
+
+/*
+ * __kernel_backtrace_here - gets the PC and SP register values for the invoker
+ * @kbt:	Pointer to the struct kernel_bt structure to set
+ */
+#define __kernel_backtrace_here(kbt)	do {				\
+			__thread_backtrace_here(&(kbt)->tbt);		\
+		} while (0)
+
+/*
+ * Gets the first stack frame.
+ * @kbt:	Pointer to &struct kernel_bt object
+ * Returns:	KERNEL_BACKTRACE_CONTEXT_SWITCH	The backtrace should stop
+ *					because the next frame is from user
+ *					mode.
+ *		Zero			This is a good frame.
+ *		A negative errno value	The backtrace should stop because an
+ *					error has occurred.
+ */
+#define kernel_backtrace_first(kbt)		({			\
+			memset((kbt), 0, sizeof(*(kbt)));		\
+			__kernel_backtrace_here(kbt);			\
+			(kbt)->cp0_status = read_c0_status();		\
+			(kbt)->cp0_epc = (mips_instruction *)read_c0_epc();\
+			__kernel_backtrace_analyze_frame(kbt);		\
+		})
+/*
+ * @_next_ra:		Value from RA register. Same as entry RA unless handling
+ *			exceptions and signals.
+ */
+struct kernel_bt {
+	struct thread_bt	tbt;
+	enum kernel_bt_type	type;
+	u32			cp0_status;
+	mips_instruction	*cp0_epc;
+};
+
+/* Internal backtrace functions */
+extern void __kernel_backtrace_set_from_pt_regs(struct kernel_bt *kbt,
+	 const struct pt_regs *regs);
+extern int __kernel_backtrace_analyze_frame(struct kernel_bt *kbt);
+
+/* External backtrace functions */
+extern int kernel_backtrace_pop_frame(struct kernel_bt *kbt);
+extern int kernel_backtrace_next(struct kernel_bt *kbt);
+extern int kernel_backtrace_first_from_pt_regs(struct kernel_bt *kbt,
+	const struct pt_regs *regs);
+extern int kernel_backtrace_analyze_frame(struct kernel_bt *kbt);
+#endif	/* _KERNEL_BACKTRACE_H_ */
diff --git a/arch/mips/include/asm/sigframe.h b/arch/mips/include/asm/sigframe.h
new file mode 100644
index 0000000..75b6c24
--- /dev/null
+++ b/arch/mips/include/asm/sigframe.h
@@ -0,0 +1,39 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1991, 1992  Linus Torvalds
+ * Copyright (C) 1994 - 2000  Ralf Baechle
+ * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
+ */
+#ifndef _ASM_SIGFRAME_H_
+#define _ASM_SIGFRAME_H_
+
+#include <linux/types.h>
+
+#include <asm/signal.h>
+#include <asm/ucontext.h>
+#include <asm-generic/siginfo.h>
+
+/*
+ * Including <asm/unistd.h> would give use the 64-bit syscall numbers ...
+ */
+#define __NR_O32_sigreturn		4119
+#define __NR_O32_rt_sigreturn		4193
+#define __NR_N32_rt_sigreturn		6211
+
+struct sigframe {
+	u32 sf_ass[4];		/* argument save space for o32 */
+	u32 sf_pad[2];		/* Was: signal trampoline */
+	struct sigcontext sf_sc;
+	sigset_t sf_mask;
+};
+
+struct rt_sigframe {
+	u32 rs_ass[4];		/* argument save space for o32 */
+	u32 rs_pad[2];		/* Was: signal trampoline */
+	struct siginfo rs_info;
+	struct ucontext rs_uc;
+};
+#endif
diff --git a/arch/mips/include/asm/thread-backtrace.h b/arch/mips/include/asm/thread-backtrace.h
new file mode 100644
index 0000000..40fa6fe
--- /dev/null
+++ b/arch/mips/include/asm/thread-backtrace.h
@@ -0,0 +1,87 @@
+/*
+ * Backtrace code for Linux operating system processes. This means that, in
+ * addition to handling the normal ABI-conformant stack frames, it must also
+ * handle Linux-specific signal stack frames.
+ *
+ * Copyright (C) 2007  Scientific-Atlanta, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef	_THREAD_BACKTRACE_H_
+#define	_THREAD_BACKTRACE_H_
+
+#include <asm/sigcontext.h>
+#include <asm/base-backtrace.h>
+
+#define	NUM_SIGARGS	4		/* # of signal function arguments */
+
+/* Stack frame type */
+enum thread_frame_type {THREAD_FRAME_BASE, THREAD_FRAME_SIGNAL,
+	THREAD_FRAME_RT_SIGNAL};
+
+/*
+ * struct thread_bt - information for thread backtracing
+ * @bbt:	Base backtrace information, for frames that are not signal
+ *		frames
+ * @sigargs:	Arguments to the signal handler
+ * @type:	Indicates the frame type
+ */
+struct thread_bt {
+	struct base_bt		bbt;
+	enum thread_frame_type	type;
+	unsigned long		*sigargs; /* Arguments to the signal handler */
+};
+
+/*
+ * __thread_backtrace_here - gets the PC and SP register values for the invoker
+ * @tbt:	Pointer to the struct thread_bt structure to set
+ */
+#define __thread_backtrace_here(tbt)	do {				\
+			__base_backtrace_here(&(tbt)->bbt);		\
+		} while (0)
+
+/*
+ * thread_backtrace_first - Get information for the first stack frame
+ * @tbt:	Pointer to trace_backtrace_t object initialized with
+ *		thread_backtrace_init.
+ * @rule:	Rules to use for analyzing the function
+ * Returns:	Zero on success, a negative errno otherwise.
+ */
+#define thread_backtrace_first(tbt, rule)	({			\
+			memset(tbt, 0, sizeof(*(tbt)));			\
+			__thread_backtrace_here(tbt);			\
+			__thread_backtrace_analyze_frame(tbt, rule);	\
+		})
+
+/* Internal backtrace functions */
+extern void __thread_backtrace_set_from_pt_regs(struct thread_bt *tbt,
+	 const struct pt_regs *regs);
+extern int __thread_backtrace_analyze_frame(struct thread_bt *tbt,
+	enum base_bt_rule rule);
+/*
+ * The following function must be supplied by users of this code:
+ * bt_get_sc_reg - get a signal context register
+ */
+extern int bt_get_sc_reg(unsigned long long *rp, unsigned long *reg);
+
+extern int thread_backtrace_pop_frame(struct thread_bt *tbt);
+extern int thread_backtrace_next(struct thread_bt *tbt,
+	enum base_bt_rule rule);
+extern int thread_backtrace_first_from_pt_regs(struct thread_bt *tbt,
+	enum base_bt_rule rule, const struct pt_regs *regs);
+extern int thread_backtrace_analyze_frame(struct thread_bt *tbt,
+	enum base_bt_rule rule);
+#endif	/* _THREAD_BACKTRACE_H_ */
diff --git a/arch/mips/kernel/entry.S b/arch/mips/kernel/entry.S
index 37acfa0..6548ae3 100644
--- a/arch/mips/kernel/entry.S
+++ b/arch/mips/kernel/entry.S
@@ -40,9 +40,10 @@ FEXPORT(__ret_from_irq)
 	andi	t0, t0, KU_USER
 	beqz	t0, resume_kernel
 
+	.globl	resume_userspace
 resume_userspace:
 	local_irq_disable		# make sure we dont miss an
-					# interrupt setting need_resched
+					# interrupt setting _need_resched
 					# between sampling and return
 	LONG_L	a2, TI_FLAGS($28)	# current->work
 	andi	t0, a2, _TIF_WORK_MASK	# (ignoring syscall_trace)
@@ -50,11 +51,13 @@ resume_userspace:
 	j	restore_all
 
 #ifdef CONFIG_PREEMPT
+	.globl resume_kernel
 resume_kernel:
 	local_irq_disable
 	lw	t0, TI_PRE_COUNT($28)
 	bnez	t0, restore_all
-need_resched:
+	.globl	_need_resched
+_need_resched:
 	LONG_L	t0, TI_FLAGS($28)
 	andi	t1, t0, _TIF_NEED_RESCHED
 	beqz	t1, restore_all
@@ -62,14 +65,14 @@ need_resched:
 	andi	t0, 1
 	beqz	t0, restore_all
 	jal	preempt_schedule_irq
-	b	need_resched
+	b	_need_resched
 #endif
 
 FEXPORT(ret_from_fork)
 	jal	schedule_tail		# a0 = struct task_struct *prev
 
 FEXPORT(syscall_exit)
-	local_irq_disable		# make sure need_resched and
+	local_irq_disable		# make sure _need_resched and
 					# signals dont change between
 					# sampling and return
 	LONG_L	a2, TI_FLAGS($28)	# current->work
@@ -141,13 +144,15 @@ FEXPORT(restore_partial)		# restore partial frame
 	RESTORE_SP_AND_RET
 	.set	at
 
+	.globl	work_pending
 work_pending:
 	andi	t0, a2, _TIF_NEED_RESCHED # a2 is preloaded with TI_FLAGS
 	beqz	t0, work_notifysig
+	.globl	work_resched
 work_resched:
 	jal	schedule
 
-	local_irq_disable		# make sure need_resched and
+	local_irq_disable		# make sure _need_resched and
 					# signals dont change between
 					# sampling and return
 	LONG_L	a2, TI_FLAGS($28)
@@ -157,6 +162,7 @@ work_resched:
 	andi	t0, a2, _TIF_NEED_RESCHED
 	bnez	t0, work_resched
 
+	.globl	work_notifysig
 work_notifysig:				# deal with pending signals and
 					# notify-resume requests
 	move	a0, sp
@@ -166,6 +172,7 @@ work_notifysig:				# deal with pending signals and
 
 FEXPORT(syscall_exit_work_partial)
 	SAVE_STATIC
+	.globl	syscall_exit_work
 syscall_exit_work:
 	li	t0, _TIF_WORK_SYSCALL_EXIT
 	and	t0, a2			# a2 is preloaded with TI_FLAGS
diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index 99e656e..a32b0e7 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -50,6 +50,7 @@ NESTED(handle_sys, PT_SIZE, sp)
 	sw	a3, PT_R26(sp)		# save a3 for syscall restarting
 	bgez	t3, stackargs
 
+	.globl	stack_done
 stack_done:
 	lw	t0, TI_FLAGS($28)	# syscall tracing enabled?
 	li	t1, _TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT
@@ -68,6 +69,7 @@ stack_done:
 	sw	t1, PT_R0(sp)		# save it for syscall restarting
 1:	sw	v0, PT_R2(sp)		# result
 
+	.globl	o32_syscall_exit
 o32_syscall_exit:
 	local_irq_disable		# make sure need_resched and
 					# signals dont change between
@@ -79,11 +81,13 @@ o32_syscall_exit:
 
 	j	restore_partial
 
+	.globl	o32_syscall_exit_work
 o32_syscall_exit_work:
 	j	syscall_exit_work_partial
 
 /* ------------------------------------------------------------------------ */
 
+	.globl	syscall_trace_entry
 syscall_trace_entry:
 	SAVE_STATIC
 	move	s0, t2
@@ -117,6 +121,7 @@ syscall_trace_entry:
 	 * stack arguments from the user stack to the kernel stack.
 	 * This Sucks (TM).
 	 */
+	 .globl	stackargs
 stackargs:
 	lw	t0, PT_R29(sp)		# get old user stack pointer
 
@@ -167,7 +172,8 @@ stackargs:
 	 * The stackpointer for a call with more than 4 arguments is bad.
 	 * We probably should handle this case a bit more drastic.
 	 */
-bad_stack:
+	 .globl	_bad_stack
+_bad_stack:
 	li	v0, EFAULT
 	sw	v0, PT_R2(sp)
 	li	t0, 1				# set error flag
@@ -177,6 +183,7 @@ bad_stack:
 	/*
 	 * The system call does not exist in this kernel
 	 */
+	.globl	illegal_syscall
 illegal_syscall:
 	li	v0, ENOSYS			# error
 	sw	v0, PT_R2(sp)
@@ -216,6 +223,7 @@ illegal_syscall:
 	jr	t2
 	/* Unreached */
 
+	.globl	einval
 einval:	li	v0, -ENOSYS
 	jr	ra
 	END(sys_syscall)
diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index dbbe0ce..713c320 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -33,6 +33,7 @@
 #include <asm/cpu-features.h>
 #include <asm/war.h>
 #include <asm/vdso.h>
+#include <asm/sigframe.h>
 
 #include "signal-common.h"
 
@@ -45,20 +46,6 @@ extern asmlinkage int _restore_fp_context(struct sigcontext __user *sc);
 extern asmlinkage int fpu_emulator_save_context(struct sigcontext __user *sc);
 extern asmlinkage int fpu_emulator_restore_context(struct sigcontext __user *sc);
 
-struct sigframe {
-	u32 sf_ass[4];		/* argument save space for o32 */
-	u32 sf_pad[2];		/* Was: signal trampoline */
-	struct sigcontext sf_sc;
-	sigset_t sf_mask;
-};
-
-struct rt_sigframe {
-	u32 rs_ass[4];		/* argument save space for o32 */
-	u32 rs_pad[2];		/* Was: signal trampoline */
-	struct siginfo rs_info;
-	struct ucontext rs_uc;
-};
-
 /*
  * Helper routines
  */
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index e9b3af2..dbf53b5 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -53,6 +53,7 @@
 #include <asm/mmu_context.h>
 #include <asm/types.h>
 #include <asm/stacktrace.h>
+#include <asm/kernel-backtrace.h>
 #include <asm/uasm.h>
 
 extern void check_wait(void);
@@ -86,6 +87,8 @@ extern int fpu_emulator_cop1Handler(struct pt_regs *xcp,
 				    struct mips_fpu_struct *ctx, int has_fpu,
 				    void *__user *fault_addr);
 
+#define MAX_STACK_FRAMES_PRINTED	100
+
 void (*board_be_init)(void);
 int (*board_be_handler)(struct pt_regs *regs, int is_fixup);
 void (*board_nmi_handler_setup)(void);
@@ -125,7 +128,52 @@ static int __init set_raw_show_trace(char *str)
 __setup("raw_show_trace", set_raw_show_trace);
 #endif
 
-static void show_backtrace(struct task_struct *task, const struct pt_regs *regs)
+#ifdef	CONFIG_MIPS_PEDANTIC_BACKTRACE
+/**
+ * show_unwinding_backtrace - Print the backtrace by unwinding stack frames
+ *	one at a time.
+ * @task:	Pointer to the task structure for the task to be unwound
+ * @regs:	Pointer to &pt_regs structure with the initial registers
+ */
+static void show_unwinding_backtrace(struct task_struct *task,
+	const struct pt_regs *regs)
+{
+	int frame_count = 0;
+	int rc;
+	struct kernel_bt kbt;
+	bool called_prev;		/* Entered prev frame with JAL/JALR? */
+
+	called_prev = true;
+	rc = kernel_backtrace_first_from_pt_regs(&kbt, regs);
+
+	while (rc == 0) {
+		mips_instruction *pc;
+
+		frame_count++;
+		if (frame_count > MAX_STACK_FRAMES_PRINTED) {
+			printk(KERN_WARNING "Exceeded maximum number of "
+				"frames (%u)\n", frame_count);
+			rc = -EINVAL;
+			break;
+		}
+
+		/*
+		 * If the last frame we popped was entered with a JAL or JALR
+		 * we subtract two instruction from this PC so that it points
+		 * at the instruction used to do the call.
+		 * */
+		pc = kbt.tbt.bbt.pc - (called_prev ? 2 : 0);
+		print_ip_sym((unsigned long)pc);
+		rc = kernel_backtrace_next(&kbt);
+	}
+
+	if (rc < 0)
+		printk(KERN_WARNING "Backtrace terminated with error %d\n",
+			rc);
+}
+#else
+static void show_unwinding_backtrace(struct task_struct *task,
+	const struct pt_regs *regs)
 {
 	unsigned long sp = regs->regs[29];
 	unsigned long ra = regs->regs[31];
@@ -140,7 +188,33 @@ static void show_backtrace(struct task_struct *task, const struct pt_regs *regs)
 		print_ip_sym(pc);
 		pc = unwind_stack(task, &sp, pc, &ra);
 	} while (pc);
-	printk("\n");
+}
+#endif
+
+#ifdef CONFIG_MIPS_PEDANTIC_BACKTRACE
+static bool show_raw(const struct pt_regs *regs)
+{
+	unsigned long pc = regs->cp0_epc;
+	return raw_show_trace || !__kernel_text_address(pc);
+}
+#else
+static bool show_raw(const struct pt_regs *void)
+{
+	return raw_show_trace;
+}
+#endif
+
+static void show_backtrace(struct task_struct *task, const struct pt_regs *regs)
+{
+	unsigned long sp = regs->regs[29];
+
+	if (show_raw(regs)) {
+		show_raw_backtrace(sp);
+		return;
+	}
+	pr_crit("Symbolic Call Trace:\n");
+	show_unwinding_backtrace(task, regs);
+	pr_crit("\n");
 }
 
 /*
diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
index e5cdfd6..c2d043d 100644
--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -19,13 +19,7 @@
 
 #include <asm/vdso.h>
 #include <asm/uasm.h>
-
-/*
- * Including <asm/unistd.h> would give use the 64-bit syscall numbers ...
- */
-#define __NR_O32_sigreturn		4119
-#define __NR_O32_rt_sigreturn		4193
-#define __NR_N32_rt_sigreturn		6211
+#include <asm/sigframe.h>
 
 static struct page *vdso_page;
 
diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
index b2cad4f..027a803 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -32,3 +32,6 @@ obj-$(CONFIG_CPU_XLR)		+= dump_tlb.o
 
 # libgcc-style stuff needed in the kernel
 obj-y += ashldi3.o ashrdi3.o cmpdi2.o lshrdi3.o ucmpdi2.o
+
+obj-$(CONFIG_MIPS_PEDANTIC_BACKTRACE) += kernel-backtrace.o \
+	kernel-backtrace-symbols.o base-backtrace.o thread-backtrace.o
diff --git a/arch/mips/lib/base-backtrace.c b/arch/mips/lib/base-backtrace.c
new file mode 100644
index 0000000..4c847d7
--- /dev/null
+++ b/arch/mips/lib/base-backtrace.c
@@ -0,0 +1,1679 @@
+/*
+ * Implement an analysis and backtrace of stackframes. It only supports
+ * processing a single frame as multiple frame backtracing requires operating
+ * system-depending things like signal frames and/or exception handling.
+ * It knows how to handle "o32" ABI-conformant backtraces and backtraces
+ * where a function start and size may be determined.
+ *
+ * Though this has been designed with some thought towards working in a 64-bit
+ * environment, only the 32-bit implementation is complete.
+ *
+ * Since this completely implements the ABI rules for processing a stack
+ * backtrace, without any OS dependencies, keeping this file a separate entity
+ * will allow reuse in other situations.
+ *
+ * Copyright(C) 2007-2011  Scientific-Atlanta, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ * Author: David VomLehn
+ */
+
+#define DEBUG
+
+#include <asm/base-backtrace.h>
+
+/*
+ * struct base_bt_ctx - data for one frame's worth of stack backtrace
+ * @rules:			Specifies which rules to use to guide the
+ *				backtrace
+ * @bbt:			Pointer to the backtrace info to be returned
+ *				to the caller
+ * @possible_framepointer:	Register number for the register that may be
+ *				a frame pointer.
+ * @fp_restore:			Pointer to the instruction where the frame
+ *				pointer is restored to the function entry value
+ * @sf_allocation:		Pointer to the instruction that allocated the
+ *				stack frame
+ * @sf_deallocation:		Pointer to instruction that pops the stack frame
+ * @fn_start:			Address of 1st opcode of function
+ * @fn_return:			Address of the function's return instruction
+ * @framepointer:		Actual frame pointer register number
+ * @func_size:			Size of the function, in bytes
+ * @jump_linked:		True if entered with jal or jalr
+ * @saved_this_frame:		Index indicating this saved register has been
+ *				saved in this frame
+ * Once we've finished analyzing a frame, we can toss this information. It
+ * isn't made available to the caller.
+ */
+struct base_bt_ctx {
+	struct base_bt	*bbt;
+	enum base_bt_rule	rule;
+	int			possible_framepointer;
+	mips_instruction	*fp_restore;
+	mips_instruction	*sf_allocation;
+	mips_instruction	*sf_deallocation;
+	mips_instruction	*fn_return;
+	mips_instruction	*fn_start;
+	int			framepointer;
+	unsigned long		func_size;
+	bool			jump_linked;
+	bool			saved_this_frame[N_SREGS];
+};
+
+/* Pointers to functions to analyze the current function. This depends on
+ * the value of the enum base_bt_rule passed to the stack frame
+ * analysis functions */
+struct bt_ops {
+	int(*find_func_start) (struct base_bt_ctx *ctx, mips_instruction *pc);
+	int(*find_return) (struct base_bt_ctx *ctx);
+};
+
+/* True if a register must be saved before use, false otherwise. */
+const bool save_before_use[N_MREGS] = {
+	[MREG_S0] = true,
+	[MREG_S1] = true,
+	[MREG_S2] = true,
+	[MREG_S3] = true,
+	[MREG_S4] = true,
+	[MREG_S5] = true,
+	[MREG_S6] = true,
+	[MREG_S7] = true,
+	[MREG_GP] = true,
+	[MREG_S8] = true,
+	[MREG_RA] = true,
+};
+
+/* Convert SREG number to an MREG number */
+const enum mips_reg_num sreg_to_mreg[N_SREGS] = {
+	[SREG_S0] = MREG_S0,
+	[SREG_S1] = MREG_S1,
+	[SREG_S2] = MREG_S2,
+	[SREG_S3] = MREG_S3,
+	[SREG_S4] = MREG_S4,
+	[SREG_S5] = MREG_S5,
+	[SREG_S6] = MREG_S6,
+	[SREG_S7] = MREG_S7,
+	[SREG_GP] = MREG_GP,
+	[SREG_S8] = MREG_S8,
+	[SREG_RA] = MREG_RA,
+};
+
+/* Convert MREG number to SREG number */
+const enum saved_gpr_num mreg_to_sreg[N_MREGS] = {
+	[MREG_S0] = SREG_S0,
+	[MREG_S1] = SREG_S1,
+	[MREG_S2] = SREG_S2,
+	[MREG_S3] = SREG_S3,
+	[MREG_S4] = SREG_S4,
+	[MREG_S5] = SREG_S5,
+	[MREG_S6] = SREG_S6,
+	[MREG_S7] = SREG_S7,
+	[MREG_GP] = SREG_GP,
+	[MREG_S8] = SREG_S8,
+	[MREG_RA] = SREG_RA,
+};
+
+/*
+ * struct vpc - virtual instruction pointer for hiding branch delay slots
+ * @pc:		Point to the instruction if this vpc does not point into a
+ *		branch delay slot. Otherwise, this points to the instruction
+ *		with the branch delay slot.
+ * @have_bds:	True if the instruction pointed to by @pc has a branch
+ *		delay slot
+ * @in_bds:	If @have_bds is true, this is true to indicate the current
+ *		instruction, in the virtual VPC space, is the one in the
+ *		branch delay slot. Otherwise, the current instruction is the
+ *		one *with* the branch delay slot. Ignored if @have_bds is false.
+ *
+ * The intent of vpcs is to hide branch delay slots from code scanning
+ * instructions. It works in a virtual space in which the instruction in the
+ * branch delay slot appears before the branch. This allows the scanning to
+ * pretend that instructions that end basic blocks are actually the last
+ * instruction in the basic block.
+ *
+ * For example, take the following instruction stream as it is stored in
+ * memory:
+ *	100:	move	a0, t1
+ *	104	bne	t0, label
+ *	108:	move	a1, t2
+ *	10c:	addu	t4, t4, t5
+ * Starting at the beginning, this sequence is executed as though it were:
+ *	vpcaddr				addr
+ *	v100:	move	a0, t1		100
+ *	v104:	move	a1, t2		108
+ *	v108:	bne	t0, label	104
+ *	v10c	addu	t4, t4, t5	10c
+ * where v100, etc are vpc-world addresses. If the current instruction, in
+ * the non-vpc world, does not have a branch delay slot and isn't in a branch
+ * delay slot, the non-vpc and vpc addresses are numerically the same. There
+ * are no branch delay slots in vpc-world, but if the current instruction
+ * has a branch delay slot in the non-vpc world, its vpc-world address is
+ * the non-vpc address plus 4. If an instruction is in a branch delay slot in
+ * the non-vpc world, its vpc-world address is its non-vpc address minus 4.
+ *
+ * Operation if an instruction with a branch delay slot is in a branch delay
+ * slot is undefined, so this code ignores the possibility.
+ *
+ * The VPC has three fields:
+ *	pc	Points to the instruction with the branch delay slot or to
+ *		the instruction if it neither has nor is in a branch delay slot.
+ *	has_bds	Boolean to indicate whether the instruction pointed to by pc
+ *		has a branch delay slot
+ *	in_bds	If has_bds is true, this will be true to indicate that the
+ *		current instructions follows that pointed to by the pc field.
+ *		Otherwise, the current instrution is the one pointed to by
+ *		pc. This is ignored if had_bds is false.
+ * With the code above, vpc values for various instructions are:
+ *					pc	has_bs	in_bds	vpcaddr
+ *	100:	move	a0, t1		100	false	n/a	100
+ *	104	bne	t0, label	104	true	false	108
+ *	108:	move	a1, t2		104	true	true	104
+ *	10c:	addu	t4, t4, t5	10c	false	n/a	10c
+ */
+struct vpc {
+	mips_instruction	*pc;
+	bool			have_bds;
+	bool			in_bds;
+};
+
+static int is_jr(mips_instruction inst, unsigned long rs)
+{
+	struct r_format	*op_p = (struct r_format *)&inst;
+	return op_p->opcode == spec_op && op_p->func == jr_op &&
+		op_p->rs == rs && op_p->rt == 0 && op_p->rd == 0;
+}
+
+static int is_lui(mips_instruction inst, unsigned long rt)
+{
+	struct u_format	*op_p = (struct u_format *)&inst;
+	return op_p->opcode == lui_op && op_p->rs == 0 &&
+		op_p->rt == rt;
+}
+
+/*
+ * Is this the save of a register with an offset from the given frame pointer
+ * register?
+ */
+static inline int is_frame_save(mips_instruction inst,
+	enum mips_reg_num framepointer)
+{
+	struct i_format	*op_p = (struct i_format *) &inst;
+	return op_p->opcode == sw_op &&
+		op_p->rs == framepointer;
+}
+
+/*
+ * Returns the number of the register being saved when the opcode is a frame
+ * save.
+ */
+static inline enum mips_reg_num frame_save_rt(mips_instruction op)
+{
+	struct i_format	*op_p = (struct i_format *) &op;
+	return op_p->rt;
+}
+
+/* Returns the offset in the stack frame for a frame save */
+static inline int frame_save_offset(mips_instruction op)
+{
+	struct i_format *op_p = (struct i_format *) &op;
+	return op_p->simmediate;
+}
+
+/*
+ * Return the vpc-addr, i.e the location in vpc address space where the
+ * instruction in a branch delay slot preceeds the instruction with the
+ * branch delay slot. This should not be used for anything other than
+ * debugging.
+ */
+#ifdef DEBUG
+static mips_instruction __used *vpc_vpcaddr(const struct vpc *vpc)
+{
+	if (!vpc->have_bds)
+		return vpc->pc;
+	else if (vpc->in_bds)
+		return vpc->pc;
+	else
+		return vpc->pc + 1;
+}
+#endif
+
+/*
+ * Set the vpc fields when the current instruction might have a branch
+ * delay slot. For example:
+ *	100:	move	a0, t1
+ *	104	bne	t0, label	<-- current instruction
+ *	108:	move	a1, t2
+ *	10c:	addu	t4, t4, t5
+ */
+static int __vpc_might_have_bds(struct vpc *vpc, mips_instruction *p)
+{
+	mips_instruction op;
+	int rc;
+
+	vpc->pc = p;
+
+	/* Get the current instruction */
+	rc = bt_get_op(p, &op);
+	if (rc != 0)
+		return rc;
+	vpc->have_bds = has_bds(op);
+	vpc->in_bds = true;
+
+	return 0;
+}
+
+/*
+ * Set vpc fields when the current instruction might be in a branch delay
+ * slot, which means we have to look at the instruction that precedes the
+ * current instruction. We must have already excluded the possibility that
+ * the current instruction has a branch delay slot. For example:
+ *	100:	move	a0, t1
+ *	104	bne	t0, label
+ *	108:	move	a1, t2		<-- current instruction
+ *	10c:	addu	t4, t4, t5
+ *
+ * When this function is done, either vpc->have_bds won't be set or it
+ * will be set and vpc->pc will point to an instruction with a branch
+ * delay slot. So, if vpc->have-bds is set, the instruction before
+ * vpc->pc can't be an instruction with a branch delay slot.
+ */
+static int __vpc_might_be_in_bds(struct vpc *vpc, mips_instruction *p)
+{
+	mips_instruction op;
+	int rc;
+
+	vpc->pc = p;
+
+	/* Get the instruction before the current one */
+	rc = bt_get_op(p - 1, &op);
+	if (rc != 0)
+		vpc->have_bds = false;
+	else
+		vpc->have_bds = has_bds(op);
+
+	if (vpc->have_bds) {
+		vpc->in_bds = false;
+		vpc->pc -= 1;		/* Point to the opcode with the BDS */
+	}
+
+	return 0;
+}
+
+/*
+ * vpc_set - Set the virtual PC from virtual address
+ * @vpc:	The virtual IP structure to use
+ * @p:		The address to which to set it
+ *
+ * Returns the pointer to vpc it was passed if successful, otherwise
+ * a NULL value.
+ *
+ * The vpc is set so that, if @pc points to an opcode and you use
+ * vpc_get_op() immediately after the call to vpc_set(), you will get the
+ * same opcode.
+ */
+static int vpc_set(struct vpc *vpc, mips_instruction *p)
+{
+	int rc;
+
+	vpc->pc = p;
+
+	/* Check to see if this instruction has a branch delay slot */
+	rc = __vpc_might_have_bds(vpc, p);
+	if (rc == 0) {
+		/*
+		 * If it doesn't have a branch delay slot, it might be in a
+		 * branch delay slot. It would be undefined to have an
+		 * instruction that both has a branch delay slot and is in a
+		 * branch delay slot, so we ignore the possibility.
+		 */
+		if (!vpc->have_bds)
+			rc = __vpc_might_be_in_bds(vpc, p);
+	}
+
+	return rc;
+}
+
+/*
+ * vpc_get - convert a virtual PC address to a normal virtual address
+ */
+static mips_instruction *vpc_get(const struct vpc *vpc)
+{
+	mips_instruction *res;
+
+	if (vpc->have_bds && vpc->in_bds)
+		res = vpc->pc + 1;
+	else
+		res = vpc->pc;
+	return res;
+}
+
+/*
+ * vpc_get_op - get the instruction at a location specified by a &struct vpc
+ * @vpc:	virtual PC with address from which to get instruction
+ *
+ * Returns the instruction at the given virtual PC location.
+ */
+static int vpc_get_op(const struct vpc *vpc,
+	mips_instruction *op)
+{
+	int rc;
+
+	rc = bt_get_op(vpc_get(vpc), op);
+
+	return rc;
+}
+
+/*
+ * vpc_inc - increment the virtual PC
+ * @vpc:	Pointer to the &struct vpc to increment
+ *
+ * Returns 0 on success, otherwise a negative errno value.
+ *
+ * Recapping the above instruction sequence and ordering the instructions as
+ * vpc presents them:
+ *	vpcaddr				vaddr	pc	have_bds	in_bds
+ *	100:	move	a0, t1		100	100	false		n/a
+ *	104:	move	a1, t2		108	104	true		true
+ *	108:	bne	t0, label	104	104	true		false
+ *	10c	addu	t4, t4, t5	10c	10c	false		n/a
+ * To increment:
+ * 1.	If have_bds is false, just increment vpc->pc.
+ * 2.	If have_bds is true and in_bds is false, add two to vpc->pc so that
+ *	it points to the instruction after the one in the branch delay slot.
+ * 3.	If have_bds is true and in_bds is true, simply set in_bds to false.
+ */
+static int vpc_inc(struct vpc *vpc)
+{
+	int rc = 0;
+
+	/*
+	 * If we do not have a branch delay slot, we also know that the
+	 * following instruction is not in a branch delay slot. If we are
+	 * not at the branch delay slot, we also know that the next instruction
+	 * can't be in a branch delay slot since that would have meant that
+	 * the instruction in our branch delay slot had a branch delay slot.
+	 * That's a no-no, so we don't worry about it.
+	 */
+#if 1
+	if (!vpc->have_bds)
+		rc = __vpc_might_have_bds(vpc, vpc->pc + 1);
+	else if (!vpc->in_bds)
+		rc = __vpc_might_have_bds(vpc, vpc->pc + 2);
+	else
+		vpc->in_bds = false;
+#else
+	if (!vpc->have_bds)
+		rc = __vpc_might_have_bds(vpc, vpc->pc + 1);
+	else if (!vpc->in_bds)
+		rc = __vpc_might_have_bds(vpc, vpc->pc + 2);
+	else
+		vpc->in_bds = false;
+#endif
+
+	return rc;
+}
+
+/*
+ * vpc_dec - decrement the virtual PC
+ * @vpc:	Pointer to the &struct vpc to decrement
+ *
+ * Returns zero on success, otherwise a negative errno value.
+ *
+ * To recap the above example, putting the instructions in order as returned
+ * by vpc:
+ *	vpcaddr				vaddr	pc	have_bds	in_bds
+ *	100:	move	a0, t1		100	100	false		n/a
+ *	104:	move	a1, t2		108	104	true		true
+ *	108:	bne	t0, label	104	104	true		false
+ *	10c	addu	t4, t4, t5	10c	10c	false		n/a
+ * To decrement:
+ * 1.	If have_bds is false, just decrement vpc->pc.
+ * 2.	If have_bds is true and in_bds is true, also decrement vpc->pc
+ * 3.	If have bds is true and in_bds is false, simply set vpc->in_bds to true.
+ */
+static int vpc_dec(struct vpc *vpc)
+{
+	int rc = 0;
+
+	/*
+	 * If we don't have a branch delay slot, then we also know we are
+	 * not in a branch delay slot, so the previous instruction can't be
+	 * a branch. If we are at the instruction with a branch delay slot,
+	 * we know the previous instruction cannot be a branch. In other
+	 * words, we only worry whether the previous instruction is in the
+	 * branch delay slot of the instruction before it.
+	 */
+	if (!vpc->have_bds || vpc->in_bds)
+		rc = __vpc_might_be_in_bds(vpc, vpc->pc - 1);
+	else
+		vpc->in_bds = true;
+
+	return rc;
+}
+
+/*
+ * vpc_get_op_inc - get the opcode pointed to and then increment the pointer
+ * @vpc:	Virtual PC with address from which to get the instruction
+ * @op:		Pointer to the location in which to store the opcode
+ *
+ * Returns zero on success, otherwise a negative errno value
+ */
+static int vpc_get_op_inc(struct vpc *vpc, mips_instruction *op)
+{
+	int rc;
+
+	rc = vpc_get_op(vpc, op);
+	if (rc != 0)
+		return rc;
+	return vpc_inc(vpc);
+}
+
+/*
+ * vpc_dec_get_op - decrement the pointer, then get the opcode pointed to
+ * @vpc:	Virtual PC with address from which to get the instruction
+ * @op:		Pointer to the location in which to store the opcode
+ *
+ * Returns zero on success, otherwise a negative errno value
+ */
+static int vpc_dec_get_op(struct vpc *vpc, mips_instruction *op)
+{
+	int rc;
+
+	rc = vpc_dec(vpc);
+	if (rc != 0)
+		return rc;
+	return vpc_get_op(vpc, op);
+}
+
+/*
+ * __vpc_get_vpc - return the virtual address associated with a vpc
+ * @vpc:	Pointer to the vpc
+ *
+ * Returns the virtual PC address.
+ */
+static void *__vpc_get_vpc(const struct vpc *vpc)
+{
+	void *res;
+
+	if (!vpc->have_bds || vpc->in_bds)
+		res = vpc->pc;
+	else
+		res = vpc->pc + 1;
+
+	return res;
+}
+
+/*
+ * vpc_eq - Compare two struct vpc values for equality
+ */
+static bool vpc_eq(const struct vpc *a, const struct vpc *b)
+{
+	return __vpc_get_vpc(a) == __vpc_get_vpc(b);
+}
+
+/*
+ * vpc_gt - Is one vpc value greater than another?
+ */
+static bool vpc_gt(const struct vpc *a, const struct vpc *b)
+{
+	return __vpc_get_vpc(a) > __vpc_get_vpc(b);
+}
+
+/*
+ * vpc_le - Is one vpc value less than or equal to another?
+ */
+static bool vpc_le(const struct vpc *a, const struct vpc *b)
+{
+	return __vpc_get_vpc(a) <= __vpc_get_vpc(b);
+}
+
+/*
+ * Functions that determine whether the opcode falls into a class of
+ * instructions.
+ */
+/* Is this a move to a register from the stack pointer? This could be
+ * initializing a frame pointer. */
+static int is_move_to_fp(mips_instruction inst)
+{
+	struct r_format	*op_p = (struct r_format *) &inst;
+	return is_addu_noreg(inst) &&
+		op_p->rs == MREG_SP && op_p->rt == MREG_ZERO;
+}
+
+/* Is this a move from a register to the stack pointer? If so, it's a restore
+ * of the stack pointer from a frame pointer. */
+static int is_move_from_fp(mips_instruction inst)
+{
+	struct r_format	*op_p = (struct r_format *) &inst;
+	return is_addu_noreg(inst) &&
+		op_p->rt == MREG_ZERO && op_p->rd == MREG_SP;
+}
+
+/* Is this a decrement of the stack pointer register? */
+static int is_sp_dec(mips_instruction op)
+{
+	struct i_format *op_p = (struct i_format *) &op;
+	return is_addiu(op, MREG_SP, MREG_SP) &&
+		op_p->simmediate < 0;
+}
+
+/* Is this an increment of the stack pointer register? */
+static int is_sp_inc(mips_instruction op)
+{
+	struct i_format *op_p = (struct i_format *) &op;
+	return is_addiu(op, MREG_SP, MREG_SP) &&
+		op_p->simmediate > 0;
+}
+
+/* Is this a jump through the return register $ra? */
+static int is_return(mips_instruction op)
+{
+	return is_jr(op, MREG_RA);
+}
+
+/*
+ * This finishes the analysis of this stack frame, based on the analysis
+ * that has already been done. It assumes that:
+ * o	The stack frame size is correct, if one has been allocated, or zero
+ *	if one has not been allocated.
+ * o	A basic block ending with a function return instruction, "jr ra", has
+ *	been found, the stack frame deallocation has been located, and, if
+ *	a stack frame pointer is in use, the location where it is transferred
+ *	to $sp has been found.
+ * @bt:	Pointer to the struct base_bt object used to keep
+ *			track of the analysis.
+ */
+static void complete_analysis(struct base_bt *bt, struct base_bt_ctx *ctx)
+{
+	bt_dbg("frame_size %ld ra %p\n", bt->frame_size, bt->ra);
+
+	if (bt->frame_size != 0) {
+		struct vpc vpc_pc;
+		struct vpc vpc_fp_restore;
+		struct vpc vpc_fn_return;
+		struct vpc vpc_sf_deallocation;
+
+		vpc_set(&vpc_pc, bt->pc);
+		vpc_set(&vpc_fn_return, ctx->fn_return);
+
+		/*
+		 * If a stack frame pointer has been allocated, have we
+		 * executed the instruction where it is moved back to $sp
+		 * on the way to executing a return?
+		 */
+		if (ctx->fp_restore != NULL) {
+			bt_dbg("have a stack frame, restored to sp?\n");
+			vpc_set(&vpc_fp_restore, ctx->fp_restore);
+
+			if (ctx->bbt->framepointer != MREG_SP &&
+				vpc_gt(&vpc_pc, &vpc_fp_restore) &&
+				vpc_le(&vpc_pc, &vpc_fn_return)) {
+				bt_dbg("After stack frame restored to $sp\n");
+				ctx->bbt->framepointer = MREG_SP;
+			}
+		}
+
+		/*
+		 * If we couldn't spot a place where the stack frame was
+		 * deallocated, assume that we're in a function that
+		 * doesn't return.
+		 */
+		if (ctx->sf_deallocation == NULL) {
+			bt_dbg("No stack frame deallocation; "
+				"using heuristic\n");
+		} else {
+			/* If we have passed the point where the stack frame is
+			 * deallocated on our way to a return from the function,
+			 * the frame size is now effectively zero. */
+			vpc_set(&vpc_sf_deallocation, ctx->sf_deallocation);
+
+			if (vpc_gt(&vpc_pc, &vpc_sf_deallocation) &&
+				vpc_le(&vpc_pc, &vpc_fn_return)) {
+				bt_dbg("After stack frame deallocated\n");
+				bt->frame_size = 0;
+			}
+		}
+	}
+}
+
+/*
+ * match_short_get_got - checks for a match for short GOT recovery code
+ * @in_vpc:	Pointer to the &struct vpc for the instruction at which
+ *		the GOT recovery code may start.
+ *
+ * Returns:	true if it matches, zero if it does not.
+ *
+ * Matches the code fragment:
+ *	li	gp,<value>
+ *	addu	gp, gp, t9
+ * which is a short version of the code used to recover the GOT (global offset
+ * table) pointer from the address of the current function.
+ */
+static bool match_short_get_got(const struct vpc *in_vpc)
+{
+	int rc;
+	mips_instruction op;
+	struct vpc vpc;
+
+	vpc = *in_vpc;
+	rc = vpc_dec_get_op(&vpc, &op);
+	if (rc != 0)
+		return false;
+	if (!is_addu(op, MREG_GP, MREG_GP, MREG_T9))
+		return false;
+
+	rc = vpc_dec_get_op(&vpc, &op);
+	if (rc != 0)
+		return false;
+
+	return is_li(op, MREG_GP);
+}
+
+/*
+ * match_long_get_got - match the long version of the GOT recovery code
+ * @in_vpc:	Pointer to the &struct vpc structure describing the current
+ *		code location.
+ * Returns:	True if it matches, false if it does not.
+ *
+ * Matches the code fragment:
+ *	lui	gp,%hi(<value>)
+ *	addiu	gp,gp,%lo(<value>)
+ *	addu	gp, gp, t9
+ * which is a long version of the code used to recover the GOT (global offset
+ * table) pointer from the address of the current function.
+ */
+static bool match_long_get_got(const struct vpc *in_vpc)
+{
+	int rc;
+	mips_instruction op;
+	struct vpc vpc;
+
+	vpc = *in_vpc;
+	rc = vpc_dec_get_op(&vpc, &op);
+	if (rc != 0 || !is_addu(op, MREG_GP, MREG_GP, MREG_T9))
+		return false;
+
+	rc = vpc_dec_get_op(&vpc, &op);
+	if (rc != 0 || !is_addiu(op, MREG_GP, MREG_GP))
+		return false;
+
+	rc = vpc_dec_get_op(&vpc, &op);
+	if (rc != 0)
+		return false;
+	return is_lui(op, MREG_GP);
+}
+
+/*
+ * find_return_bounded_range - find function return within address limits
+ * @bt:	Points to the current struct base_bt object
+ * @start:	Starting address.
+ * @end:	One instruction past the last instruction to check.
+ *			The address here should not be checked.
+ * Returns zero if no error occurred during the scan, otherwise a
+ *		negative errno value.
+ *
+ * This starts at the given address and looks for a function return. If
+ * it finds one, it sets the fn_return field to its address, otherwise it
+ * sets it to NULL_REG.
+ */
+static int find_return_bounded_range(struct base_bt_ctx *ctx,
+	mips_instruction *start, mips_instruction *end)
+{
+	int rc = 0;	/* Assume success */
+	mips_instruction op;
+	struct vpc vpc;
+	struct vpc end_vpc;
+
+	ctx->fn_return = (unsigned long)NULL;
+	rc = vpc_set(&end_vpc, (mips_instruction *)end);
+	if (rc != 0)
+		return rc;
+	rc = vpc_set(&vpc, (mips_instruction *)start);
+	if (rc != 0)
+		return rc;
+
+	while (!vpc_eq(&vpc, &end_vpc)) {
+		rc = vpc_get_op(&vpc, &op);
+		if (rc != 0)
+			return rc;
+		if (is_return(op))
+			break;
+		rc = vpc_inc(&vpc);
+	}
+
+	if (is_return(op)) {
+		bt_dbg("Function return at %p\n", vpc_get(&vpc));
+		ctx->fn_return = vpc_get(&vpc);
+	}
+
+	return rc;
+}
+
+/*
+ * backup_from_sp_decrement - find beginning of ABI function from setting GP
+ * @ctx:	Pointer to backtrace context
+ * @sp_dec:	Pointer to the stack pointer decrement instruction
+ *
+ * We are trying to find the beginning of a MIPS o32 ABI conformant function
+ * and found a stack pointer decrement at the given address. The means we
+ * must be in the first basic block of the current function. We want to
+ * keep backing up until we reach the beginning of the current function.
+ *
+ * The stack pointer decrement may be the first instruction of this
+ * function, but there is the possibility that we have code that
+ * is used to get the address of the GOT (global offset table) into
+ * the gp register. We look to see if we have such code and, if so,
+ * assume that the beginning of that code is the beginning of this
+ * function. This code will look like:
+ *	la	gp,<value>
+ *	addu	gp,gp,t9
+ * where la might expand into either:
+ *	lui	gp,%hi(<value>)
+ *	addiu	gp,gp,%lo(<value>)
+ * or, if <value> fits, as a signed value, in 16 bits:
+ *	li	gp,<value>	(implement as addiu gp,zero,<value>)
+ *
+ * @bt:	Pointer to struct base_bt object.
+ * @sp_dec:	Location of stack pointer decrement instruction
+ * Returns:	Zero if we found the start of the function and a negative
+ *		errno value if not.
+ */
+static int back_up_from_sp_decrement(struct base_bt_ctx *ctx,
+	mips_instruction *sp_dec)
+{
+	int rc;
+	struct vpc vpc;
+	bool matched;
+
+	rc = vpc_set(&vpc, sp_dec);
+	if (rc != 0)
+		return rc;
+
+	/* Try matching the three instruction GOT code */
+	matched = match_long_get_got(&vpc);
+	if (matched) {
+		ctx->fn_start = sp_dec - 3;
+	} else {
+		matched = match_short_get_got(&vpc);
+		if (matched)
+			ctx->fn_start = sp_dec - 2;
+		else
+			ctx->fn_start = sp_dec;
+	}
+
+	return 0;
+}
+
+/*
+ * Find the beginning of the function in which the given address is found.
+ * @bt:	Points to the struct base_bt object
+ * @addr:	Address for which to locate the function start
+ * Returns:	Zero on success, otherwise:
+ *		-ESRCH	The given address is not in known code(inherited from
+ *			bt_symbol_lookup)
+ */
+static int find_func_start_abi(struct base_bt_ctx *ctx, mips_instruction *addr)
+{
+	int rc;
+	struct vpc vpc;
+	mips_instruction op;
+	mips_instruction *p;
+
+	/* Scan backwards until:
+	 * 1.	We can't read an instruction, which we take to indicate we
+	 *	went one instruction past the beginning of the function,
+	 * 2.	We found a "jr ra", which marks the end of the previous
+	 *	function, or
+	 * 3.	We found a decrement of the sp register, which is the stack
+	 *	frame allocation for this function.
+	 */
+	rc = vpc_set(&vpc, addr);
+	if (rc != 0)
+		return rc;
+
+	for (;;) {
+		rc = vpc_get_op(&vpc, &op);
+		if (rc != 0 || is_return(op) || is_sp_dec(op))
+			break;
+
+		rc = vpc_dec(&vpc);
+		if (rc != 0)
+			break;
+	}
+
+	p = vpc_get(&vpc);
+
+	switch (rc) {
+	case -EFAULT:
+		ctx->fn_start = p + 1;
+		bt_dbg("Found function start at %p by running out of "
+			"code\n", ctx->fn_start);
+		break;
+
+	case 0:
+		if (is_return(op)) {
+			ctx->fn_start = p + 2;
+			bt_dbg("Found function start at %p by "
+				"finding previous function end at %p\n",
+				ctx->fn_start, p);
+		}
+
+		else
+			rc = back_up_from_sp_decrement(ctx, p);
+		break;
+
+	default:				/* Got some other error */
+		ctx->fn_start = NULL;
+		break;
+	}
+
+	return rc;
+}
+
+/*
+ * Find the beginning of the function in which the given address is found.
+ * @bt:	Points to the struct base_bt object
+ * @addr:	Address for which to locate the function start
+ * Returns:	Zero on success, otherwise:
+ *		-ESRCH	The given address is not in known code(inherited from
+ *			bt_symbol_lookup)
+ */
+static int find_func_start_bounded(struct base_bt_ctx *ctx,
+	mips_instruction *addr)
+{
+	int	rc;
+
+	rc = bt_symbol_lookup(addr, &ctx->fn_start,
+		&ctx->func_size);
+
+	return rc;
+}
+
+/*
+ * find_return_abi - Find the end of the function by o32 ABI rules.
+ * @bt:	Pointer to struct base_bt object.
+ * Returns:	Zero if we found the end of the function, a negative errno value
+ *		if we could not.
+ *
+ * If the function was found, ctx->fn_return will point to the "jr ra"
+ * instruction, otherwise it will be set to NULL.
+ * If the function was not found, ctx->fn_return will be set to NULL_REG.
+ */
+static int find_return_abi(struct base_bt_ctx *ctx)
+{
+	int rc;
+	struct vpc vpc;
+	mips_instruction op;
+
+	ctx->fn_return = NULL;
+
+	/* Scan forward to find the "jr ra" that marks the end
+	 * of the current function */
+	rc = vpc_set(&vpc, ctx->bbt->pc);
+	if (rc != 0)
+		return rc;
+
+	for (;;) {
+		rc = vpc_get_op(&vpc, &op);
+		if (is_return(op))
+			break;
+		if (rc != 0)
+			return rc;
+		vpc_inc(&vpc);
+	}
+
+	bt_dbg("Function return at %p\n", vpc_get(&vpc));
+	ctx->fn_return = vpc_get(&vpc);
+
+	return rc;
+}
+
+/*
+ * @bt:	Pointer to a struct base_bt object
+ * Returns:	Zero if successful, otherwise a negative errno value.
+ * Find the return instruction starting at the current instruction, but if
+ * we don't find one by the end of the function, try again at the top.
+ */
+static int find_return_bounded(struct base_bt_ctx *ctx)
+{
+	int rc;
+	mips_instruction *end;
+
+	/* Start the search at the next instruction to be excuted and search to
+	 * the end */
+	end = (mips_instruction *)((char *)ctx->fn_start + ctx->func_size);
+	rc = find_return_bounded_range(ctx, ctx->bbt->pc, end);
+
+	/* Start by scanning forward to find the "jr ra" that marks the end
+	 * of the current function. If we didn't get an error, but didn't
+	 * find the instruction, try again from the beginning. */
+
+	if (rc == 0 && ctx->fn_return == NULL) {
+		mips_instruction *alloc_loc;
+
+		/* We couldn't find a "jr ra" after the current
+		 * location, let's try for one before it. We know that
+		 * it can't be before the stack allocation and the
+		 * stack allocation isn't a return, so start right
+		 *  after that.*/
+		alloc_loc = ctx->sf_allocation + 1;
+		bt_dbg("No return after $pc, try starting at %p\n", alloc_loc);
+		rc = find_return_bounded_range(ctx, alloc_loc,
+			ctx->bbt->pc);
+
+		/* If we failed, return an error code */
+		if (rc == 0 && ctx->fn_return == NULL) {
+			bt_dbg("No function return found\n");
+			bt_dbg("1st search: %p to %p, "
+				"2nd: %p to %p\n", ctx->bbt->pc, end,
+				alloc_loc, ctx->bbt->pc);
+
+			rc = -ENOSYS;
+		}
+	}
+
+	return rc;
+}
+
+static struct bt_ops ops[] = {
+	{find_func_start_abi, find_return_abi},
+	{find_func_start_bounded, find_return_bounded},
+};
+
+/*
+ * Locates the first instruction in the current function. We start by
+ * finding the function containing the instruction to which $pc points. Recall
+ * that $pc is actually the return address from a call. It will normally
+ * point to the same function that contains the call, except in the case
+ * where the call is the last thing in the current function. In that special
+ * case, $pc will actually point to the first instruction in the function
+ * after the current function. This arises when the last thing the current
+ * function did was to call a function defined with __attribute__((noreturn)).
+ *
+ * To detect this special case, note that there are two ways that we can
+ * be doing a stack backtrace with $pc pointing to the first instruction of
+ * a function:
+ * 1.	We got a signal, exception, or interrupt just before executing the
+ *	first instruction of a function.
+ * 2.	We called a function, with a jal or jalr instruction, that, with the
+ *	instruction in its branch delay slot, immediately preceeds the
+ *	function to whose instruction $pc currently points.
+ * In the first case, we called the function from somewhere else and the
+ * value in the the ra register will be something other than the value of
+ * the $pc register. In the second case, however, the ra and $pc register
+ * values will be the same. In that case, the current function is the
+ * function in which the jal or jalr instruction is located, which is two
+ * instructions before the current value of the $pc register.
+ * @bt:	Points to the struct base_bt object. The start
+ *			field will be set to the result.
+ * Returns:	Zero on success, otherwise a negative errno value.
+ */
+static int find_func_start(struct base_bt_ctx *ctx)
+{
+	int	rc;
+
+	ctx->jump_linked = true;
+
+	rc = ops[ctx->rule].find_func_start(ctx, ctx->bbt->pc);
+
+	if (rc == 0) {
+		bt_dbg("Comparing $pc %p with function start %p and "
+			"ra 0x%p\n", ctx->bbt->pc, ctx->fn_start,
+			ctx->bbt->ra);
+		if (ctx->bbt->pc == ctx->fn_start &&
+			ctx->bbt->pc == ctx->bbt->ra) {
+			bt_dbg("Detected call in previous function with "
+				"pc %p\n", ctx->bbt->pc);
+			rc = ops[ctx->rule].find_func_start(ctx,
+				ctx->bbt->pc - 2);
+		}
+	}
+
+	if (rc == 0)
+		bt_dbg("Function start detected at %p\n", ctx->fn_start);
+
+	return rc;
+}
+
+/*
+ * Look for a return from the current function. The search starts with the
+ * current location so that, later on, we can determine whether we are
+ * executing in a basic block that ends with a return. If there isn't
+ * a return in the current function that follows the current location, the
+ * search should look for a return before the current location.
+ *
+ * If successful, ctx->fn_return will be set to the address of the
+ * "jr ra" instruction used to do the return.
+ * @bt:	Pointer to a struct base_bt object.
+ * Returns: Zero on success, otherwise a negative errno value.
+ */
+static int find_return(struct base_bt_ctx *ctx)
+{
+	/* Array, indexed by an enum base_bt_rule value, that holds the
+	 * function analysis function pointers. */
+
+	return ops[ctx->rule].find_return(ctx);
+}
+
+/*
+ * Sets the state to indicate that no stack frame has been allocated.
+ * @bt:	Points to the struct base_bt object to set
+ */
+static void set_no_sf_allocation(struct base_bt_ctx *ctx)
+{
+	ctx->sf_allocation = NULL;
+	ctx->bbt->frame_size = 0;
+}
+
+/*
+ * Sets the state that records where the stack frame is allocated and
+ * the frame size.
+ * @bt:	Points to the struct base_bt object to set
+ * @pc:	Location where the stack frame is allocated
+ * @op:	Opcode used to allocate the stack frame, from which
+ *			the size will be taken.
+ */
+static void set_sf_allocation(struct base_bt_ctx *ctx, mips_instruction *pc,
+	mips_instruction op)
+{
+	struct i_format *op_p;
+
+	ctx->sf_allocation = pc;
+	op_p = (struct i_format *) &op;
+	ctx->bbt->frame_size = -op_p->simmediate;
+	bt_dbg("Found frame allocation for %lu bytes at %p\n",
+		ctx->bbt->frame_size, pc);
+}
+
+/*
+ * Finds the location where the stack frame is allocated. If one was found,
+ * the location is stored in sf_allocation, otherwise sf_allocation is set
+ * to NULL.
+ * @bt:	Points to the struct base_bt object. The start
+ *			field will be set to the result.
+ * Returns:	Zero on success, otherwise a negative errno value.
+ */
+static int find_sf_allocation(struct base_bt_ctx *ctx)
+{
+	int rc = 0;
+	struct vpc vpc;
+	struct vpc pc_vpc;
+	mips_instruction op;
+
+	/* Scan forwards from the start of the function until one of the
+	 * following:
+	 * 1.	We reach the current execution location, in which case
+	 *	no stack frame has been allocated,
+	 * 2.	We fail to read an opcode, which is an error,
+	 * 3.	We see a stack frame decrement instruction, which is how
+	 *	the stack frame is allocated, or
+	 * 4.	We reach an instruction marking the end of a basic block,
+	 *	in which the function does not allocate a stack frame at all.
+	 */
+	vpc_set(&pc_vpc, ctx->bbt->pc);
+	rc = vpc_set(&vpc, ctx->fn_start);
+
+	if (rc == 0) {
+		while (!vpc_eq(&vpc, &pc_vpc)) {
+			rc = vpc_get_op(&vpc, &op);
+			if (rc != 0)
+				return rc;
+			if (is_sp_dec(op) || is_bb_end(op))
+				break;
+			vpc_inc(&vpc);
+		}
+	}
+
+	if (vpc_eq(&vpc, &pc_vpc))
+		set_no_sf_allocation(ctx);
+
+	else {
+		if (is_sp_dec(op))
+			set_sf_allocation(ctx, vpc_get(&vpc), op);
+
+		else {
+			/* We exited the loop because we found the end of
+			 * the basic block. If the instruction that marked
+			 * the end of the basic block uses a branch delay
+			 * slot, we need to examine that instruction to see
+			 * if it allocated a stack frame. */
+
+			vpc_dec(&vpc);	/* Point to inst @ branch delay slot */
+			rc = vpc_get_op(&vpc, &op);
+
+			if (rc == 0) {
+				if (is_sp_dec(op))
+					set_sf_allocation(ctx, vpc_get(&vpc),
+						op);
+
+				else
+					set_no_sf_allocation(ctx);
+			}
+		}
+	}
+
+	return rc;
+}
+
+/*
+ * This looks at the given opcode, which comes from the given address, to see
+ * if it is a move to the stack pointer or a stack pointer increment. If so,
+ * it records that information.
+ *
+ * We assume that the basic block that includes the function return instruction
+ * can have only one move to the $sp register, but don't check for that
+ * fact. We also don't check that the frame pointer restore preceeds the
+ * stack frame deallocation.
+ *
+ * This may set the following struct base_bt fields:
+ *	possible_framepointer	Register number used in "move sp, rx"
+ *				instruction.
+ *	fp_restore		Address of the "move sp, rx" instruction
+ *	sf_deallocation		Address of "addiu sp, sp, framesize" instruction
+ *
+ * @bt:	Pointer to the struct base_bt object.
+ * @pc:	Address of the instruction being analyzed
+ * @op:	Instruction to analyze
+ */
+static void analyze_return_block_op(struct base_bt_ctx *ctx,
+	mips_instruction *pc, mips_instruction op)
+{
+	if (is_move_from_fp(op)) {
+		struct r_format	*op_p = (struct r_format *) &op;
+		ctx->possible_framepointer = op_p->rs;
+		ctx->fp_restore = pc;
+		bt_dbg("possible frame pointer $r%d at %p\n",
+			ctx->possible_framepointer, ctx->fp_restore);
+	}
+
+	else if (is_sp_inc(op)) {
+		ctx->sf_deallocation = pc;
+		bt_dbg("frame deallocation at %p\n", pc);
+	}
+}
+
+/*
+ * This function analyzes a basic block ending with the function return
+ * at fn_return. We do a backwards scan, starting with the "jr ra" instruction
+ * until we reach the end of the previous basic block, or the stack frame
+ * allocation, whichever comes first. If sf_deallocation is NULL when this
+ * returns, no stack deallocation was found.
+ * @bt:	Pointer to the struct base_bt object.
+ * Returns:	Zero on success, otherwise a negative errno value.
+ */
+static int analyze_return_block(struct base_bt_ctx *ctx)
+{
+	int rc;
+	struct vpc vpc;
+	struct vpc sf_allocation_vpc;
+	mips_instruction op;
+
+	ctx->possible_framepointer = MREG_SP;
+	ctx->fp_restore = NULL;
+	ctx->sf_deallocation = NULL;
+	vpc_set(&sf_allocation_vpc, ctx->sf_allocation);
+	vpc_set(&vpc, ctx->fn_return);	/* Point to the jr ra */
+
+	/*
+	 * Scan backwards until we reach the instruction where the stack
+	 * frame was allocated or we reach the beginning of the basic block
+	 */
+	do {
+		rc = vpc_dec_get_op(&vpc, &op);
+		if (rc != 0)
+			return rc;
+		analyze_return_block_op(ctx, vpc_get(&vpc), op);
+	} while (!is_bb_end(op) && !vpc_eq(&vpc, &sf_allocation_vpc));
+
+	return rc;
+}
+
+/*
+ * This looks at the given opcode, which comes from the given address, to see
+ * if it is a move from the stack pointer to another register. If this matches
+ * a move from the same register to the stack pointer in the return block,
+ * this must be initialization of a frame pointer.
+ *
+ * This might set the following struct base_bt fields:
+ *	framepointer	Register being used as a frame pointer.
+ *
+ * @bt:	Pointer to struct base_bt object
+ * @op:	Instruction to examine.
+ */
+static void analyze_procedure_prelude_op(struct base_bt_ctx *ctx,
+	mips_instruction op)
+{
+	if (is_move_to_fp(op)) {
+		enum mips_reg_num	rd;
+		struct r_format	*op_p = (struct r_format *) &op;
+
+		rd = op_p->rd;
+		bt_dbg("Checking $r%d to see if is a frame pointer\n", rd);
+		if (rd == ctx->possible_framepointer) {
+			enum saved_gpr_num	sreg;
+
+			bt_dbg("Confirmed frame pointer $r%d\n", rd);
+			sreg = mreg_to_sreg[rd];
+			ctx->bbt->framepointer = rd;
+			if (ctx->bbt->gprs[sreg].read)
+				ctx->bbt->fp = (unsigned long *)ctx->bbt->
+					gprs[sreg].value;
+			else
+				ctx->bbt->fp = ctx->bbt->sp;
+		}
+	}
+}
+
+/*
+ * analyze_procedure_prelude - analyze the first part of the function
+ * @bt:	Pointer to the struct base_bt object.
+ *
+ * Returns zero on success, otherwise a negative errno value.
+ *
+ * This function analyzes the procedure prelude, which is the first basic
+ * in the function, to see if a frame pointer has been established. It stops
+ * when it sees a frame pointer established, it reaches the end of the basic
+ * block, or when when it reaches $pc. This function assumes that the
+ * framepointer element of the struct base_bt has already been set to
+ * MREG_SP.
+ */
+static int analyze_procedure_prelude(struct base_bt_ctx *ctx)
+{
+	int rc = 0;	/* Assume good result */
+	struct vpc vpc;
+	struct vpc pc_vpc;
+	mips_instruction op;
+
+	vpc_set(&pc_vpc, ctx->bbt->pc);
+
+	/*
+	 * Starting at the instruction after the allocation of the stack
+	 * frame, look at each opcode to see if a frame pointer has been
+	 * established. Continue looking until:
+	 * 1.	We have reached the instruction about to be executed,
+	 * 2.	We have established a frame pointer,
+	 * 3.	We aren't able to read the next opcode, and
+	 * 4.	The opcode we read marks the end of a basic block.
+	 *
+	 * Each time we loop, we check to see if a frame pointer was
+	 * established. This very well may not happen; the stack pointer
+	 * is usually used as a frame pointer.
+	 */
+	rc = vpc_set(&vpc, ctx->sf_allocation);
+	if (rc != 0)
+		return rc;
+
+	while (!vpc_eq(&vpc, &pc_vpc) && ctx->bbt->framepointer == MREG_SP) {
+		rc = vpc_get_op_inc(&vpc, &op);
+		if (rc != 0)
+			return rc;
+		if (is_bb_end(op))
+			break;
+		analyze_procedure_prelude_op(ctx, op);
+	}
+
+	return rc;
+}
+
+/*
+ * read_saved_reg_from_frame - read a register saved in the stack frame
+ * @ctx:	Pointer to base backtrace context
+ * @op:		Opcode that might be saving a register
+ *
+ * Returns 0 on success, otherwise a negative errno value.
+ */
+static int read_saved_reg_from_frame(struct base_bt_ctx *ctx,
+	mips_instruction op)
+{
+	enum mips_reg_num rt;
+	int rc = 0;
+	enum saved_gpr_num sreg;
+
+	rt = frame_save_rt(op);
+	sreg = mreg_to_sreg[rt];
+
+	/* Only worry about the first save. Subsequent saves in this
+	 * function would not be saves of the caller's values for this
+	 * register. */
+	if (save_before_use[rt] && !ctx->saved_this_frame[sreg]) {
+		int offset;		/* Offset from frame pointer */
+		unsigned long *rp;
+		unsigned long reg;
+
+		ctx->bbt->gprs[sreg].read = true;
+		ctx->saved_this_frame[sreg] = true;
+		offset = frame_save_offset(op);
+		rp = (unsigned long *)((char *)ctx->bbt->fp + offset);
+		rc = bt_get_reg(rp, &reg);
+		if (rc == 0)
+			ctx->bbt->gprs[sreg].value = reg;
+	}
+
+	return rc;
+}
+
+/*
+ * read_saved_regs_from_frame - read registers saved on the stack
+ * @ctx:	Pointer to struct base_bt_ctx object.
+ * @op:		Opcode used to save the register through the frame pointer
+ *
+ * Returns zero on success, otherwise a negative errno value.
+ *
+ * If the RA register or the current frame pointer were saved on the
+ * stack by the given instruction, retrieve them.
+ */
+static int read_saved_regs_from_frame(struct base_bt_ctx *ctx,
+	mips_instruction op)
+{
+	int rc = 0;
+
+	/* If the given instruction is a save through the
+	 * frame pointer, retrieve the value from the stack.
+	 *
+	 * Note: the o32 ABI says that the registers will be
+	 * saved through the frame pointer, but the reality is
+	 * that they are saved through the stack pointer.
+	 * Accomodate both. */
+	if (is_frame_save(op, ctx->bbt->framepointer))
+		rc = read_saved_reg_from_frame(ctx, op);
+
+	else if (is_frame_save(op, MREG_SP))
+		rc = read_saved_reg_from_frame(ctx, op);
+
+	return rc;
+}
+
+/*
+ * scan_reg_saves - grab registers saved on the stack before use
+ * @ctx:	Pointer to the base_bt_ctx
+ *
+ * There is a set of registers that must be saved before use, which includes
+ * registers eligible to be frame pointers. Scan the first part of the
+ * function to grab the values of those.
+ */
+static int scan_reg_saves(struct base_bt_ctx *ctx)
+{
+	struct vpc vpc;
+	struct vpc pc_vpc;
+	mips_instruction op;
+	int rc = 0;
+
+
+	if (ctx->bbt->frame_size != 0) {
+		vpc_set(&vpc, ctx->sf_allocation);
+		vpc_set(&pc_vpc, ctx->bbt->pc);
+
+		/*
+		 * Loop through the code, starting with the first instruction
+		 * after the stack frame allocation, and each time a register
+		 * is saved in the stack frame, read its value into the array
+		 * with the general purpose register values. We keep doing
+		 * this until:
+		 * 1.	We have reached the instruction we are about to execute,
+		 * 2.	We can't read the next opcode, or
+		 * 3.	The opcode we read marks the end of a basic block.
+		 */
+		vpc_set(&pc_vpc, ctx->bbt->pc);
+		vpc_set(&vpc, ctx->sf_allocation);
+		vpc_inc(&vpc);
+
+		while (!vpc_eq(&vpc, &pc_vpc)) {
+			rc = vpc_get_op(&vpc, &op);
+			if (rc != 0)
+				return rc;
+			if (is_bb_end(op))
+				break;
+
+			rc = read_saved_regs_from_frame(ctx, op);
+			if (rc != 0)
+				return rc;
+			rc = vpc_inc(&vpc);
+			if (rc != 0)
+				return rc;
+		}
+	}
+
+	return rc;
+}
+
+/*
+ * __base_backtrace_analyze_frame - gather info about the current stack frame.
+ * @bt:	Pointer to the struct base_bt object.
+ *
+ * Returns:	Zero on success, otherwise a negative errno value.
+ *
+ * The base_bt is initialized with the current PC and SP values and only those
+ * values. It analyzes the current frame to get enough information to pop the
+ * frame.
+ */
+int __base_backtrace_analyze_frame(struct base_bt *bbt, enum base_bt_rule rule)
+{
+	int	rc = 0;	/* Assume good backtrace */
+	struct base_bt_ctx ctx;
+	int i;
+
+	/* Initialize for the analysis of the current stack frame */
+	ctx.bbt = bbt;
+	ctx.rule = rule;
+
+	/* Clear old information */
+	bbt->frame_size = 0;
+	for (i = 0; i < ARRAY_SIZE(ctx.saved_this_frame); i++)
+		ctx.saved_this_frame[i] = false;
+
+	rc = find_func_start(&ctx);
+	if (rc != 0)
+		return rc;
+
+	ctx.bbt->framepointer = MREG_SP;/* Default frame pointer is $sp */
+	bbt->fp = bbt->sp;		/* Use a default guess */
+
+	/* Find the place where we allocate the stack fame, if any */
+	rc = find_sf_allocation(&ctx);
+
+	/*
+	 * If we are in a leaf function or early in a non-leaf function, we
+	 * won't have allocated a stack frame at this point. If no stack
+	 * frame has been allocated, use the current stack pointer as the
+	 * caller's stack frame and use the current the return address,
+	 * still in $ra. We are then done with the analysis. Otherwise, get
+	 * the current stack frame pointer and see whether the return address
+	 * has been saved on the stack yet.
+	 */
+	if (rc == 0 && bbt->frame_size != 0) {
+		rc = find_return(&ctx);
+
+		switch (rc) {
+		case 0:
+			rc = analyze_return_block(&ctx);
+			if (rc == 0) {
+				rc = analyze_procedure_prelude(&ctx);
+				if (rc == 0)
+					complete_analysis(bbt, &ctx);
+			}
+			break;
+
+		case -ENOSYS:
+			bt_dbg("No return found, applying heuristic\n");
+			ctx.possible_framepointer = MREG_S8;
+			rc = analyze_procedure_prelude(&ctx);
+			break;
+
+		default:			/* Leave the result unchanged */
+			break;
+		}
+
+		/* Grab registers we need from the stack */
+		if (rc == 0)
+			rc = scan_reg_saves(&ctx);
+	}
+
+	return rc;
+}
+EXPORT_SYMBOL(__base_backtrace_analyze_frame);
+
+/*
+ * Updates the $pc and $sp registers with the new values passed. It checks
+ * for stack loops and NULL values of pc.
+ * @bbt:	Pointer to the struct base_bt object.
+ * Returns:	Zero on success, a positive, non-zero value to terminate
+ *		the stack trace, otherwise a negative errno value.
+ */
+int __base_backtrace_generic_pop_frame(struct base_bt *bbt)
+{
+	mips_instruction *previous_pc;
+	unsigned long *previous_sp;
+
+	bt_dbg("Pop %lu-byte frame@%p ra %p fp %p\n", bbt->frame_size,
+		bbt->sp, bbt->ra, bbt->fp);
+
+	previous_pc = bbt->pc;
+	previous_sp = bbt->sp;
+
+	if (bbt->gprs[SREG_RA].read) {
+		bbt->ra = (mips_instruction *)bbt->gprs[SREG_RA].value;
+		bbt->gprs[SREG_RA].read = false;
+	}
+
+	if (bbt->next_pc != NULL) {
+		bbt->pc = bbt->next_pc;
+		bbt->next_pc = NULL;
+	} else {
+		bbt->pc = bbt->ra;
+	}
+
+	bbt->sp = (unsigned long *)((char *)bbt->fp + bbt->frame_size);
+
+	/* Are we in a stack loop? */
+	if (previous_pc == bbt->pc && previous_sp == bbt->sp) {
+		bt_dbg("Terminating backtrace because of stack loop\n");
+		return -ENOSYS;
+	}
+	if (bbt->pc == NULL) {
+		bt_dbg("Terminating backtrace due to NULL pc value\n");
+		return BASE_BT_END_NULL_PC;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(__base_backtrace_generic_pop_frame);
+
+/*
+ * Updates the $pc and $sp registers, given the current values of the
+ * $ra register and the size of the stack frame.
+ * @bt:	Pointer to the struct base_bt object.
+ * Returns:	Zero on success, otherwise a negative errno value.
+ *
+ * It uses values stored in the structure pointed to by @bt to set the PC
+ * and SP registers to the values for the previous frame.
+ */
+int base_backtrace_pop_frame(struct base_bt *bbt)
+{
+	int rc;
+
+	rc = __base_backtrace_generic_pop_frame(bbt);
+
+	return rc;
+}
+EXPORT_SYMBOL(base_backtrace_pop_frame);
+
+/*
+ * __base_backtrace_here_pc - Determine the PC and SP values of the caller
+ * @bbt:	Pointer to the backtrace information
+ */
+noinline mips_instruction *__base_backtrace_here_pc()
+{
+	return (mips_instruction *)__builtin_return_address(0);
+}
+EXPORT_SYMBOL(__base_backtrace_here_pc);
+
+/*
+ * Process one stack frame. The given register values will be updated
+ * based on the processing of the stack frame.
+ * @bt:	Pointer to copies of the register values that
+ *			apply for this frame.
+ * Returns:	Zero on success, otherwise a negative errno value.
+ *		A value of -ENOSYS indicates that the $pc and $sp are valid
+ *		but we can't continue the backtrace.
+ */
+
+int base_backtrace_next(struct base_bt *bbt, enum base_bt_rule rule)
+{
+	int rc;
+
+	rc = base_backtrace_pop_frame(bbt);
+
+	if (rc == 0)
+		rc = __base_backtrace_analyze_frame(bbt, rule);
+
+	return rc;
+}
+EXPORT_SYMBOL(base_backtrace_next);
+
+/*
+ * __base_backtrace_set_from_pt_regs - set the registers from a struct pt_regs
+ * @bt:		Pointer to the &struct base_bt
+ * @regs:	Pointer to the register values to start with
+ *
+ * Returns zero on success, otherwise a negative errno value.
+ */
+void __base_backtrace_set_from_pt_regs(struct base_bt *bbt,
+	const struct pt_regs *regs)
+{
+	int i;
+
+	memset(bbt, 0, sizeof(*bbt));
+
+	bbt->pc = (mips_instruction *)regs->cp0_epc;
+	bbt->sp = (unsigned long *)regs->regs[MREG_SP];
+	bbt->ra = (mips_instruction *)regs->regs[MREG_RA];
+
+	/* Initialize all of the mandatory save registers. */
+	for (i = 0; i < ARRAY_SIZE(bbt->gprs); i++) {
+		if (save_before_use[i]) {
+			enum saved_gpr_num sreg;
+			sreg = mreg_to_sreg[i];
+			bbt->gprs[sreg].value = regs->regs[i];
+			bbt->gprs[sreg].read = true;
+		}
+	}
+}
+EXPORT_SYMBOL(__base_backtrace_set_from_pt_regs);
+
+/*
+ * base_backtrace_first_from_pt_regs - Initialize base_bt struct from pt_regs
+ * @bt:		Pointer to the &struct base_bt
+ * @rule:	Rules to use for the backtrace
+ * @regs:	Pointer to the register values to start with
+ *
+ * Returns zero on success, otherwise a negative errno value.
+ */
+int base_backtrace_first_from_pt_regs(struct base_bt *bbt,
+	enum base_bt_rule rule, const struct pt_regs *regs)
+{
+	int rc;
+
+	__base_backtrace_set_from_pt_regs(bbt, regs);
+
+	/*
+	 * Analyzing the frame gets us the frame size and the return address.
+	 * Note that, though we have the value of the ra register, this is
+	 * likely not to be the return address for the current function.
+	 */
+	rc = __base_backtrace_analyze_frame(bbt, rule);
+	return rc;
+}
+EXPORT_SYMBOL(base_backtrace_first_from_pt_regs);
diff --git a/arch/mips/lib/kernel-backtrace-symbols.c b/arch/mips/lib/kernel-backtrace-symbols.c
new file mode 100644
index 0000000..46622a2
--- /dev/null
+++ b/arch/mips/lib/kernel-backtrace-symbols.c
@@ -0,0 +1,41 @@
+/*
+ * Array with backtrace symbols for the kernel;
+ *
+ * Copyright (C) 2007  Scientific-Atlanta, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ * Author: David VomLehn
+ */
+
+#include <linux/kernel.h>
+
+/* Generate external references for the symbols that correspond to pieces
+ * of code that should be handled specially in order to do a proper kernel
+ * backtrace. */
+#define	SPECIAL_SYMBOL(name, type) extern mips_instruction	name[];
+#include <asm/kernel-backtrace-symbols.h>
+#undef SPECIAL_SYMBOL
+
+/* Now generate the table for the symbols that we handle specially */
+#define	SPECIAL_SYMBOL(name, type) \
+	{name, type},
+
+const struct kern_special_sym kernel_backtrace_symbols[] = {
+#include <asm/kernel-backtrace-symbols.h>
+};
+#undef SPECIAL_SYMBOL
+
+unsigned kernel_backtrace_symbols_size = ARRAY_SIZE(kernel_backtrace_symbols);
diff --git a/arch/mips/lib/kernel-backtrace.c b/arch/mips/lib/kernel-backtrace.c
new file mode 100644
index 0000000..5ba012e
--- /dev/null
+++ b/arch/mips/lib/kernel-backtrace.c
@@ -0,0 +1,1080 @@
+/*
+ * Perform backtrace in the kernel. This means that, besides handling signals
+ * (which can happen to kernel threads, too), it must handle backtracing over
+ * exceptions and interrupts.
+ *
+ * Copyright (C)2007  Scientific-Atlanta, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option)any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ * Author: David VomLehn
+ */
+
+#include <linux/kallsyms.h>
+#include <linux/irq.h>
+
+#include <asm/ptrace.h>
+#include <asm/asm-offsets.h>
+
+#include <asm/kernel-backtrace.h>
+#include <asm/kernel-backtrace-symbols.h>
+
+/* Offsets and sizes in the exception vector */
+#define	TLB_REFILL_OFFSET	0
+#define	TLB_REFILL_SIZE		0x80
+#define	GEN_EX_OFFSET		0x180
+#define	GEN_EX_SIZE		0x80
+#define	INTERRUPT_OFFSET	0x200
+#define	INTERRUPT_SIZE		(NR_IRQS * vectorspacing())
+#define	UNEXPECTED_OFFSET	0x80
+#define	UNEXPECTED_SIZE		0x100
+
+/*
+ * struct kernel_bt_ctx - kernel backtrace context used to analyze frames
+ * @kbt:		Points to the structure used to communicate with the
+ *			caller
+ * @start:		Start of current section of code
+ * @size:		Size of current section of code
+ *
+ * Annotation data passed to the frame handler. This is only good for the
+ * lifetime of the frame.
+ */
+struct kernel_bt_ctx {
+	struct kernel_bt	*kbt;
+	mips_instruction	*start;
+	unsigned long		size;
+};
+
+/* Opcode: move rd, rs. Synonym for addu rd, rs, zero. */
+static int is_move(mips_instruction inst, unsigned long rd, unsigned long rs)
+{
+	return is_addu(inst, rd, rs, MREG_ZERO);
+}
+
+static int is_sw(mips_instruction inst, unsigned long rt, unsigned long base)
+{
+	struct i_format	*op_p = (struct i_format *)&inst;
+	return op_p->opcode == sw_op &&
+		op_p->rs == base && op_p->rt == rt;
+}
+
+/* Returns the offset in the stack frame for a frame save */
+static int frame_save_offset(mips_instruction op)
+{
+	struct i_format *op_p = (struct i_format *)&op;
+	return op_p->simmediate;
+}
+
+/*
+ * Is this the save of a register with an offset from the given frame pointer
+ * register?
+ */
+static int is_frame_save(mips_instruction inst, enum mips_reg_num framepointer)
+{
+	struct i_format	*op_p = (struct i_format *)&inst;
+	return op_p->opcode == sw_op &&
+		op_p->rs == framepointer;
+}
+
+/*
+ * Check to see if a given address is in the start_kernel function.
+ * @addr:	Virtual address to check
+ * Returns false if it couldn't get the address of start_kernel or the address
+ * given is not in start_kernel. Otherwise, it returns true.
+ */
+static bool in_start_kernel(mips_instruction *addr)
+{
+	static unsigned long where;
+	static unsigned long size;
+	static bool lookup_done;
+
+	/* Lookup start_kernel just once */
+	if (!lookup_done) {
+		unsigned long offset;
+
+		lookup_done = true;
+		where = kallsyms_lookup_name("start_kernel");
+
+		if (where)
+			if (!kallsyms_lookup_size_offset(where, &size, &offset))
+				where = 0;
+	}
+
+	return where != 0 && (unsigned long)addr >= where &&
+		(unsigned long)addr - where < size;
+}
+
+/*
+ * Returns the number of bytes in each entry of the interrupt vector.
+ */
+static unsigned vectorspacing(void)
+{
+	const unsigned	M_VS = 0x000003e0;
+	const unsigned	S_VS = 0;
+
+	return (read_c0_intctl() & M_VS) >> S_VS;
+}
+
+/*
+ * Function that determines whether we are in some section of the exception
+ * vector. If no exception vector has been set up, which we determine
+ * by seeing whether ebase has yet been set, we can't be in the exception
+ * vector code.
+ * @pc:		Current program counter
+ *		start	Offset of the start of the section from ebase
+ *		size	Size of the section.
+ * Returns:	Non-zero if we are in the given section, zero otherwise.
+ */
+static int in_exception_vector(mips_instruction *pc, unsigned start,
+	unsigned size)
+{
+	int			result;
+
+	if (ebase == 0)
+		result = 0;
+
+	else {
+		unsigned long	offset;
+
+		offset = (unsigned long)pc - ebase;
+		result = (offset >= start && offset < size);
+	}
+
+	return result;
+}
+
+/*
+ * This looks for the given pc value in the list of pieces of code that must
+ * be handled specially for backtrace purposes. If found, it will store the
+ * symbol start and size.
+ * @pc:		Value of pc to look for
+ *		start	Address of the start of the code section.
+ *		size	Number of bytes in the code section.
+ * Returns:	A pointer to the entry in the table of special symbols
+ *		corresponding to pc if it could be found, NULL if not.
+ */
+static const struct kern_special_sym *special_symbol(mips_instruction *pc,
+	mips_instruction **start, unsigned long *size)
+{
+	const struct kern_special_sym	*result;
+	unsigned long			symbolsize;
+	unsigned long			offset;
+
+	/* We could look up each symbol and then see whether it contained the
+	 * pc, but a faster way is to look up the symbol corresponding to the
+	 * pc, then just quickly go through the table looking for it. This
+	 * could be even faster if the table were sorted by address because
+	 * we would be able to do a binary search of the table, but this is
+	 * simpler and only rarely done. */
+
+	/* Find the symbol corresponding to the pc */
+	if (!kallsyms_lookup_size_offset((unsigned long)pc, &symbolsize,
+		&offset))
+		result = NULL;
+
+	else {
+		size_t		i;
+		mips_instruction	*symbol_start;
+
+		/* Search for the address within our table of special symbols.
+		 * We do a simple linear search, now, but if the table were
+		 * sorted we could use a faster binary search. Ah, someday when
+		 * we have time... */
+		symbol_start = (mips_instruction *)((char *)pc - offset);
+
+		for (i = 0;
+			i < kernel_backtrace_symbols_size &&
+				symbol_start !=
+					kernel_backtrace_symbols[i].start;
+			i++)
+			;
+
+		if (i == kernel_backtrace_symbols_size)
+			result = NULL;
+
+		else {
+			result = &kernel_backtrace_symbols[i];
+			*start = (mips_instruction *)symbol_start;
+			*size = symbolsize;
+		}
+	}
+
+	return result;
+}
+
+/*
+ * read_pt_regs_sp - handle stack pointer stored in pt_regs structure
+ * @ctx:	Pointer to the kernel backtrace context
+ * @regs:	Pointer to the &struct pt_regs structure from which to read
+ *
+ * Returns 0 on success, otherwise a negative errno value.
+ */
+static int read_pt_regs_sp(struct kernel_bt_ctx *ctx, struct pt_regs *regs)
+{
+	int rc;
+	struct base_bt *bbt;
+	unsigned long new_sp;
+
+	bbt = &ctx->kbt->tbt.bbt;
+	rc = bt_get_reg(&regs->regs[MREG_SP], &new_sp);
+
+	if (rc == 0)
+		bbt->frame_size = (char *)new_sp - (char *)bbt->sp;
+
+	return rc;
+}
+
+/*
+ * read_pt_regs_epc - handle an exception PC stored in pt_regs structure
+ * @ctx:	Pointer to the kernel backtrace context
+ * @regs:	Pointer to the &struct pt_regs structure from which to read
+ *
+ * Returns 0 on success, otherwise a negative errno value.
+ */
+static int read_pt_regs_epc(struct kernel_bt_ctx *ctx, struct pt_regs *regs)
+{
+	int rc;
+	struct base_bt *bbt;
+	unsigned long new_cp0_epc;
+
+	bbt = &ctx->kbt->tbt.bbt;
+	rc = bt_get_reg(&regs->cp0_epc, &new_cp0_epc);
+
+	return rc;
+}
+
+/*
+ * read_pt_regs_status - handle CP0 Status register stored in pt_regs structure
+ * @ctx:	Pointer to the kernel backtrace context
+ * @regs:	Pointer to the &struct pt_regs structure from which to read
+ *
+ * Returns 0 on success, otherwise a negative errno value.
+ */
+static int read_pt_regs_status(struct kernel_bt_ctx *ctx, struct pt_regs *regs)
+{
+	int rc;
+	unsigned long new_cp0_status;
+
+	rc = bt_get_reg(&regs->cp0_status, &new_cp0_status);
+
+	if (rc == 0)
+		ctx->kbt->cp0_status = new_cp0_status;
+
+	return rc;
+}
+
+/*
+ * read_pt_regs_sp_epc_status - read SP, EPC, and Status registers
+ */
+static int read_pt_regs_sp_epc_status(struct kernel_bt_ctx *ctx,
+	struct pt_regs *regs)
+{
+	int rc;
+	rc = read_pt_regs_sp(ctx, regs);
+	if (rc != 0)
+		return rc;
+
+	rc = read_pt_regs_epc(ctx, regs);
+	if (rc != 0)
+		return rc;
+
+	rc = read_pt_regs_status(ctx, regs);
+	if (rc != 0)
+		return rc;
+
+	return 0;
+}
+
+/*
+ * read_pt_regs_gpr_by_mreg - reads a register from a struct pt_regs, if saved
+ * @kbt:	Pointer to the struct kernel_bt_ctx object in which
+ *			to store the value.
+ * @reg_num:	The particular register to store.
+ * @ptr:	Location of the value
+ * Returns zero on success, a negative errno value otherwise.
+ */
+static int read_pt_regs_gpr_by_mreg(struct kernel_bt_ctx *ctx,
+	struct pt_regs *regs, enum mips_reg_num mreg)
+{
+	int rc;
+	struct base_bt *bbt;
+
+	if (save_before_use[mreg]) {
+		unsigned long reg;
+
+		bbt = &ctx->kbt->tbt.bbt;
+		rc = bt_get_reg(&regs->regs[mreg], &reg);
+		if (rc == 0) {
+			bbt->gprs[mreg_to_sreg[mreg]].value = reg;
+			bbt->gprs[mreg_to_sreg[mreg]].read = true;
+		}
+	}
+
+	return rc;
+}
+
+/*
+ * read_pt_regs_gpr_by_offset - read the gprs from the stack frame by offset
+ * @kbt:	Pointer to the struct kernel_bt_ctx object
+ * @ptr:	Pointer to the memory location where the struct
+ *		pt_regs object is stored.
+ * @offset:	Offset from the pointer to the value for the
+ *		register we want to read
+ *
+ * Returns zero on success, a negative errno value otherwise.
+ * The current instruction is a save through the frame pointer. Retrieve
+ * the value that was saved. The offset tells us which register to retrieve,
+ * as well as being the offset in the struct pt_regs from which to retrieve it.
+ */
+static int read_pt_regs_gpr_by_offset(struct kernel_bt_ctx *ctx,
+	struct pt_regs *regs, int offset)
+{
+	int result = 0;		/* Assume success */
+
+	/*
+	 * The registers mentioned in this statement are those saved by the
+	 * SAVE_SOME or SAVE_STATIC macros. We only really care about saved
+	 * registers and a few special ones, so only some of the possibilities
+	 * are actually interesting.
+	 */
+	switch (offset) {
+	case PT_R0:	/* MREG_ZERO */				/* SAVE_SOME*/
+	case PT_R2:	/* MREG_V0 */				/* SAVE_SOME*/
+	case PT_R3:	/* MREG_V1 */				/* SAVE_SOME*/
+	case PT_R4:	/* MREG_A0 */				/* SAVE_SOME*/
+	case PT_R5:	/* MREG_A1 */				/* SAVE_SOME*/
+	case PT_R6:	/* MREG_A1 */				/* SAVE_SOME*/
+	case PT_R7:	/* MREG_A3 */				/* SAVE_SOME*/
+	case PT_R25:	/* MREG_T9 */				/* SAVE_SOME */
+	case PT_R31:	/* MREG_T9 */				/* SAVE_SOME */
+		break;
+
+	case PT_R16:						/* SAVE_STATIC*/
+		result = read_pt_regs_gpr_by_offset(ctx, regs, MREG_S0);
+		break;
+	case PT_R17:						/* SAVE_STATIC*/
+		result = read_pt_regs_gpr_by_offset(ctx, regs, MREG_S1);
+		break;
+	case PT_R18:						/* SAVE_STATIC*/
+		result = read_pt_regs_gpr_by_offset(ctx, regs, MREG_S2);
+		break;
+	case PT_R19:						/* SAVE_STATIC*/
+		result = read_pt_regs_gpr_by_offset(ctx, regs, MREG_S3);
+		break;
+	case PT_R20:						/* SAVE_STATIC*/
+		result = read_pt_regs_gpr_by_offset(ctx, regs, MREG_S4);
+		break;
+	case PT_R21:						/* SAVE_STATIC*/
+		result = read_pt_regs_gpr_by_offset(ctx, regs, MREG_S5);
+		break;
+	case PT_R22:						/* SAVE_STATIC*/
+		result = read_pt_regs_gpr_by_offset(ctx, regs, MREG_S6);
+		break;
+	case PT_R23:						/* SAVE_STATIC*/
+		result = read_pt_regs_gpr_by_offset(ctx, regs, MREG_S7);
+		break;
+	case PT_R28:						/* SAVE_SOME */
+		result = read_pt_regs_gpr_by_offset(ctx, regs, MREG_GP);
+		break;
+	case PT_R30:						/* SAVE_STATIC*/
+		result = read_pt_regs_gpr_by_offset(ctx, regs, MREG_S8);
+		break;
+
+	/*
+	 * The following are special cases. They aren't saved registers by
+	 * they greatly affect what follows.
+	 */
+	case PT_R29:						/* SAVE_SOME */
+		result = read_pt_regs_sp(ctx, regs);
+		break;
+	case PT_EPC:						/* SAVE_SOME */
+		result = read_pt_regs_epc(ctx, regs);
+		break;
+	case PT_STATUS:
+		result = read_pt_regs_status(ctx, regs);	/* SAVE_SOME */
+		break;
+	}
+
+	return result;
+}
+
+/*
+ * read_pt_regs_already_saved - read registers saved in a sequence of code
+ * @kbt:	Pointer to the struct kernel_bt_ctx object
+ * @ip:		Pointer to the first instruction to examine to see if
+ *		it is a store.
+ * @ptr:	Pointer to the struct pt_regs object in which values
+ *		are stored.
+ *
+ * Returns zero on success, a negative errno value otherwise.
+ *
+ * At this point the SAVE_SOME or SAVE_STATIC macro has started to save
+ * register values into a struct pt_regs object. We run through the current
+ * code looking for stores relative to the $sp register and restore values
+ * from there.
+ */
+static int read_pt_regs_already_saved(struct kernel_bt_ctx *ctx,
+	mips_instruction *ip, struct pt_regs *regs)
+{
+	int		result = 0;	/* Assume success */
+	mips_instruction	op;
+
+	for (; ip != ctx->kbt->tbt.bbt.pc &&
+			(result = bt_get_op(ip, &op)) == 0 &&
+			!is_bb_end(op);
+			ip += 1) {
+
+		/* If this is a save, we use the offset to determine which
+		 * register is being saved. Since all we want to do is to
+		 * restore the register value, the offset is all we need to
+		 * determine which register is to be restored. */
+		if (is_frame_save(op, MREG_SP))
+			result = read_pt_regs_gpr_by_offset(ctx, regs,
+				frame_save_offset(op));
+	}
+
+	return result;
+}
+
+/*
+ * read_pt_regs_all_saved - read all saved register from a pt_regs structure
+ * @ctx:	Pointer to struct kernel_bt_ctx
+ * @regs:	Pointer to the struct pt_regs
+ */
+static int read_pt_regs_all_saved(struct kernel_bt_ctx *ctx)
+{
+	enum saved_gpr_num i;
+	int rc;
+	struct pt_regs *regs;
+
+	regs = (struct pt_regs *)ctx->kbt->tbt.bbt.sp;
+
+	rc = read_pt_regs_sp_epc_status(ctx, regs);
+	if (rc != 0)
+		return rc;
+
+	/* Loop through the saved registers */
+	for (i = SREG_S0; i < N_SREGS; i++) {
+		rc = read_pt_regs_gpr_by_mreg(ctx, regs, sreg_to_mreg[i]);
+		if (rc != 0)
+			return rc;
+	}
+
+	return 0;
+}
+
+/*
+ * Loads the next register values for code that uses the $k0 and $k1
+ * registers only. In this case, the $pc value is in the CP0 EPC register
+ * and all other registers still have their original values.
+ * @ctx:	Pointer to the current struct kernel_bt_ctx object.
+ * Returns:	KERNEL_BT_END_CTX_SWITCH The backtrace should stop because
+ *					the next frame is from user mode.
+ *		Zero			This is a good frame.
+ *		A negative errno value	The backtrace should stop because an
+ *					error has occurred.
+ */
+static int analyze_k0_k1_only_frame(struct kernel_bt_ctx *ctx)
+{
+	int	result = 0;		/* Assume success */
+
+	ctx->kbt->tbt.bbt.pc = ctx->kbt->cp0_epc;
+
+	return result;
+}
+
+/*
+ * This handles a code section that starts with use of a SAVE_SOME macro and
+ * which *may* then save additional registers using macros like SAVE_STATIC,
+ * etc.
+ * @ctx:	Pointer to the current struct kernel_bt_ctx object.
+ * Returns:	KERNEL_BT_END_CTX_SWITCH The backtrace should stop because
+ *					the next frame is from user mode.
+ *		Zero			This is a good frame.
+ *		A negative errno value	The backtrace should stop because an
+ *					error has occurred.
+ */
+static int analyze_save_some_or_all_frame(struct kernel_bt_ctx *ctx)
+{
+	int		result = 0;	/* Assume success */
+	enum		{OLD_SP_IN_SP, OLD_SP_IN_K0, OLD_SP_ON_STACK} sp_loc;
+	mips_instruction	*ip;
+	mips_instruction	op;
+	struct base_bt	*bbt;
+	struct pt_regs *pt_regs;
+
+	bbt = &ctx->kbt->tbt.bbt;
+	pt_regs = (struct pt_regs *)ctx->kbt->tbt.bbt.sp;
+
+	/* First, loop until the old stack pointer gets stored on the
+	 * stack. No other registers get stored in the struct pt_regs
+	 * object on the stack until after the stack pointer gets
+	 * stored. */
+
+	for (ip = ctx->start, sp_loc = OLD_SP_IN_SP; ; ip += 1) {
+		/* If we reach the current execution point or we have stored
+		 * the old SP on the stack, we are done. */
+		if (ip == bbt->pc ||
+			sp_loc == OLD_SP_ON_STACK)
+			break;
+		result = bt_get_op(ip, &op);
+		if (result != 0)
+			break;
+
+		if (is_move(op, MREG_K0, MREG_SP))
+			sp_loc = OLD_SP_IN_K0;
+
+		else if (sp_loc == OLD_SP_IN_K0 &&
+			is_sw(op, MREG_K0, MREG_SP))
+			sp_loc = OLD_SP_ON_STACK;
+	}
+
+	switch (sp_loc) {
+	case OLD_SP_IN_SP:		/* Nothing to do */
+		bbt->frame_size = (char *)pt_regs->regs[MREG_SP] -
+			(char *)bbt->sp;
+		break;
+
+	case OLD_SP_IN_K0:
+
+		bbt->frame_size = (char *)pt_regs->regs[MREG_K0] -
+			(char *)bbt->sp;
+		break;
+
+	case OLD_SP_ON_STACK:
+		result = read_pt_regs_already_saved(ctx, ip,
+			(struct pt_regs *)bbt->sp);
+		break;
+
+	default:
+		result = -EINVAL;	/* Internal failure: shouldn't happen */
+		bt_dbg("Unexpected sp_loc value: %d\n", sp_loc);
+		break;
+	}
+
+	return result;
+}
+
+/*
+ * Loads the next register values for code that uses the SAVE_SOME macro.
+ * @ctx:	Pointer to the current struct kernel_bt_ctx object.
+ * Returns:	KERNEL_BT_END_CTX_SWITCH The backtrace should stop because the
+ *					next frame is from user mode.
+ *		Zero			This is a good frame.
+ *		A negative errno value	The backtrace should stop because an
+ *					error has occurred.
+ */
+static int analyze_save_some_frame(struct kernel_bt_ctx *ctx)
+{
+	return analyze_save_some_or_all_frame(ctx);
+}
+
+/*
+ * Loads the next register values for code that uses the SAVE_ALL macro. The
+ * SAVE_ALL macro starts by using the SAVE_SOME macro, then saves additional
+ * registers. We could simply have used analyze_save_some_or_all_frame directly,
+ * but this extra, tiny, function allows a more directly mapping from what
+ * appears in the kernel code to the way we break things down here.
+ * @ctx:	Pointer to the current struct kernel_bt_ctx object.
+ * Returns:	KERNEL_BT_END_CTX_SWITCH The backtrace should stop because the
+ *					next frame is from user mode.
+ *		Zero			This is a good frame.
+ *		A negative errno value	The backtrace should stop because an
+ *					error has occurred.
+ */
+static int analyze_save_all_frame(struct kernel_bt_ctx *ctx)
+{
+	return analyze_save_some_or_all_frame(ctx);
+}
+
+/*
+ * Loads the next register values for code that uses the SAVE_STATIC macro.
+ * @ctx:	Pointer to the current struct kernel_bt_ctx object.
+ * Returns:	KERNEL_BT_END_CTX_SWITCH The backtrace should stop because the
+ *					next frame is from user mode.
+ *		Zero			This is a good frame.
+ *		A negative errno value	The backtrace should stop because an
+ *					error has occurred.
+ */
+static int analyze_save_static_frame(struct kernel_bt_ctx *ctx)
+{
+	int rc;
+	struct pt_regs *regs;
+
+	regs = (struct pt_regs *)ctx->kbt->tbt.bbt.sp;
+
+	/* We must have already completed a SAVE_SOME macro in some previous
+	 * section of code, which has saved general purpose registers zero,
+	 * v0-v1, a0-a3, t9, gp, sp, and ra(r0, r2-r7, r25, r28, r29, r31),
+	 * and CP0 registers Cause, EPC, and Status. Only sp and gp of the
+	 * general purpose registers might take place in the backtrace,
+	 * but we do have to read some of the others.
+	 */
+	rc = read_pt_regs_sp_epc_status(ctx, regs);
+	if (rc != 0)
+		return rc;
+
+	rc = read_pt_regs_gpr_by_mreg(ctx, regs, MREG_GP);
+
+	/* Now read the registers which have been saved so far in this
+	 * section of code */
+	rc = read_pt_regs_already_saved(ctx, ctx->start, regs);
+
+	return rc;
+}
+
+/*
+ * Loads the next register values for glue code that is used after SAVE_SOME
+ * and SAVE_STATIC have been called and before RESTORE_SOME is called. This
+ * means that the values for the previous frame are all in a struct pt_regs
+ * object pointed to by $sp.
+ * @ctx:	Pointer to the current struct kernel_bt_ctx object.
+ * Returns:	KERNEL_BT_END_CTX_SWITCH The backtrace should stop because the
+ *					next frame is from user mode.
+ *		Zero			This is a good frame.
+ *		A negative errno value	The backtrace should stop because an
+ *					error has occurred.
+ */
+static int analyze_glue_frame(struct kernel_bt_ctx *ctx)
+{
+	int		result;
+
+	result = read_pt_regs_all_saved(ctx);
+
+	return result;
+}
+
+/*
+ * Loads the next register values for code that uses the RESTORE_SOME macro.
+ * Until we reach the eret instruction, the $sp register points to a struct
+ * pt_regs object from which the values can be fetched. When we get to the
+ * eret, all registers except $pc have been loaded and we get the next $pc
+ * value from the CP0_EPC register.
+ * @ctx:	Pointer to the current struct kernel_bt_ctx object.
+ * Returns:	KERNEL_BT_END_CTX_SWITCH The backtrace should stop because the
+ *					next frame is from user mode.
+ *		Zero			This is a good frame.
+ *		A negative errno value	The backtrace should stop because an
+ *					error has occurred.
+ */
+static int analyze_restore_some_frame(struct kernel_bt_ctx *ctx)
+{
+	int		result;
+	mips_instruction	op;
+
+	/* Check to see whether we got to the eret instruction. If
+	 * not, use the stack pointer to get to the save values.
+	 * Otherwise, use the ones we have. */
+	result = bt_get_op(ctx->start, &op);
+
+	if (result == 0) {
+		if (!is_eret(op))
+			result = read_pt_regs_all_saved(ctx);
+	}
+
+	return result;
+}
+
+/*
+ * analyze_special_frame - analyze frame when the PC is in non-C code
+ * @ctx:	Pointer to &struct kernel_bt_ctx.
+ *
+ * Returns 0 on success, a negative errno otherwise
+ */
+static int analyze_special_frame(struct kernel_bt_ctx *ctx)
+{
+	int	result;
+	struct thread_bt *tbt;
+
+	switch (ctx->kbt->type) {
+	case KERNEL_FRAME_THREAD:
+		tbt = &ctx->kbt->tbt;
+
+		/* Special case if we are in start_kernel. The space for
+		 * the function has been handed to the buddy allocator, so
+		 * we can't say anything about it. It's still useful to
+		 * return the frame, though, so we dummy things up so that
+		 * they shouldn't cause problems. */
+		if (in_start_kernel(tbt->bbt.pc)) {
+			bt_dbg("Passing back frame for start_kernel\n");
+			tbt->bbt.frame_size = 0;
+			tbt->bbt.ra = NULL;
+			result = 0;
+		} else {
+			result = __thread_backtrace_analyze_frame(tbt,
+				BASE_BACKTRACE_LOOKUP_FUNC);
+		}
+		break;
+
+	case KERNEL_FRAME_TLB_REFILL:
+	case KERNEL_FRAME_GENERAL_EXCEPTION:
+	case KERNEL_FRAME_K0_K1_ONLY:
+		result = analyze_k0_k1_only_frame(ctx);
+		break;
+
+	case KERNEL_FRAME_INTERRUPT:
+	case KERNEL_FRAME_SAVE_SOME:
+		result = analyze_save_some_frame(ctx);
+		break;
+
+	case KERNEL_FRAME_SAVE_STATIC:
+		result = analyze_save_static_frame(ctx);
+		break;
+
+	case KERNEL_FRAME_SAVE_ALL:
+		result = analyze_save_all_frame(ctx);
+		break;
+
+	case KERNEL_FRAME_GLUE:
+		result = analyze_glue_frame(ctx);
+		break;
+
+	case KERNEL_FRAME_RESTORE_SOME:
+		result = analyze_restore_some_frame(ctx);
+		break;
+
+	case KERNEL_FRAME_UNEXPECTED:
+		result = -ENOSYS;
+		break;
+
+	default:
+		result = -EINVAL;	/* Internal failure: Shouldn't happen */
+		bt_dbg("Unexpected frame type: %d\n", ctx->kbt->type);
+		break;
+	}
+
+	return result;
+}
+
+static int analyze_unexpected_frame(struct kernel_bt_ctx *ctx)
+{
+	return 0;
+}
+
+/*
+ * This determines the type of the current frame. This is done by looking at
+ * the $pc register and seeing whether it is in some sort of interrupt or
+ * exception frame. If not, it passes the analysis on to the thread_backtrace
+ * code.
+ * @kbt:	Pointer to a struct kernel_bt_ctx object.
+ * Returns zero if it was able to determine the frame type, or a negative
+ *		errno value if an error occurred during processing.
+ */
+int __kernel_backtrace_analyze_frame(struct kernel_bt *kbt)
+{
+	int			result = 0;	/* Assume success */
+	mips_instruction *pc;
+	const struct kern_special_sym	*symbol;
+	struct kernel_bt_ctx ctx;
+
+	ctx.kbt = kbt;
+
+	kbt->tbt.bbt.frame_size = 0;
+	pc = kbt->tbt.bbt.pc;
+	kbt->tbt.bbt.fp = kbt->tbt.bbt.sp;	/* Default frame pointer */
+
+	/* Fake values for start_kernel() */
+	if (in_start_kernel(pc)) {
+		kbt->tbt.bbt.frame_size = 0;
+		kbt->tbt.bbt.ra = 0;
+		return 0;
+	}
+
+	/* Check to see if we came from user mode */
+	if ((kbt->cp0_status & ST0_CU0) == 0) {
+		bt_dbg("Terminate backtrace because exception was in user "
+			"code\n");
+		return KERNEL_BT_END_CTX_SWITCH;
+	}
+
+	/* The kernel is kind enough to arrange things so that the return
+	 * address is NULL if we have reached the end of a kernel stack, so
+	 * if we see that case, we are done. */
+	if (pc == NULL)
+		result = KERNEL_BT_END_NULL_PC;
+
+	else {
+		symbol = special_symbol(pc, &ctx.start, &ctx.size);
+
+		if (symbol != NULL) {
+			ctx.kbt->type = symbol->type;
+			result = analyze_special_frame(&ctx);
+		}
+
+		else if (in_exception_vector(pc, TLB_REFILL_OFFSET,
+			TLB_REFILL_SIZE)) {
+			ctx.kbt->type = KERNEL_FRAME_TLB_REFILL;
+			ctx.start = (mips_instruction *)(ebase +
+				TLB_REFILL_OFFSET);
+			ctx.size = TLB_REFILL_SIZE;
+			result = analyze_k0_k1_only_frame(&ctx);
+		}
+
+		else if (in_exception_vector(pc, GEN_EX_OFFSET, GEN_EX_SIZE)) {
+			ctx.kbt->type = KERNEL_FRAME_GENERAL_EXCEPTION;
+			ctx.start = (mips_instruction *)(ebase + GEN_EX_OFFSET);
+			ctx.size = GEN_EX_SIZE;
+			result = analyze_k0_k1_only_frame(&ctx);
+		}
+
+		else if (in_exception_vector(pc, INTERRUPT_OFFSET,
+			INTERRUPT_SIZE)) {
+			unsigned	offset, irq, spacing;
+			ctx.kbt->type = KERNEL_FRAME_INTERRUPT;
+
+			/* Since we are using the exception vector for handling
+			 * interrupts, i.e. the CP0 Config3 register has VEIC
+			 * or VI set and the CP0 Cause register has the IV bit
+			 * set, we subtract ebase + INTERRUPT_OFFSET from $pc
+			 * to get the offset into the interrupt vector portion.
+			 * We divide this by the space of the interrupt vector
+			 * entries to get the interrupt number. Then the start
+			 * of the entry for this interrupt is computed by
+			 * multiplying the interrupt number by the spacing and
+			 * adding ebase and INTERRUPT_OFFSET back in. The size
+			 * of the entry is given by the spacing of the
+			 * interrupt vector entries. */
+			spacing = vectorspacing();
+			offset = (unsigned long)pc - (ebase + INTERRUPT_OFFSET);
+			irq = offset / spacing;
+			ctx.start = (mips_instruction *)(ebase +
+				INTERRUPT_OFFSET + irq * spacing);
+			ctx.size = spacing;
+			result = analyze_save_some_frame(&ctx);
+		}
+
+		else if (in_exception_vector(pc, UNEXPECTED_OFFSET,
+			UNEXPECTED_SIZE)) {
+			ctx.kbt->type = KERNEL_FRAME_UNEXPECTED;
+			ctx.start = (mips_instruction *)(ebase +
+				UNEXPECTED_OFFSET);
+			ctx.size = UNEXPECTED_SIZE;
+			result = analyze_unexpected_frame(&ctx);
+		}
+
+		else {
+			result = __thread_backtrace_analyze_frame(&ctx.kbt->tbt,
+				BASE_BACKTRACE_LOOKUP_FUNC);
+			ctx.kbt->type = KERNEL_FRAME_THREAD;
+		}
+	}
+
+	return result;
+}
+EXPORT_SYMBOL(__kernel_backtrace_analyze_frame);
+
+/*
+ * Use kallsyms_lookup to find the symbol corresponding to a given address.
+ * All we care about for backtracing is where the section of code starts
+ * and the number of bytes in it.
+ * @ip:		Address for which to find the symbol
+ * @start:	Pointer to location in which to store the starting
+ *		address for the symbol.
+ * @size:	Pointer to location in which to store the size of the
+ *		symbol.
+ *
+ * Returns zero on success, otherwise a negative errno value.
+ */
+int bt_symbol_lookup(mips_instruction *ip, mips_instruction **start,
+	unsigned long *size)
+{
+	int		result;
+	const char	*symname;
+	unsigned long	symbolsize;
+	unsigned long	offset;
+	char		*modname;
+	char		namebuf[KSYM_NAME_LEN + 1];
+
+	symname = kallsyms_lookup((unsigned long)ip, &symbolsize,
+		&offset, &modname, namebuf);
+
+	/* Perhaps, if we couldn't find the symbol, it is a two-instruction
+	 * signal trampoline. It won't hurt to pretend because everything
+	 * validates that the address from which it fetches instructions. */
+	if (symname == NULL) {
+		result = 0;
+		*start = ip;
+		*size = 2 * sizeof(mips_instruction);
+	}
+
+	else {
+		result = 0;
+		*start = (mips_instruction *)((char *)ip - offset);
+		*size = symbolsize;
+	}
+
+	return result;
+}
+
+/*
+ * Read an opcode-sized piece of data.
+ * @ip:	Address from which to read the opcode
+ * @op:	Location in which to store the opcode once it has
+ *	been read.
+ * Returns zero on success, a negative errno value otherwise.
+ */
+int bt_get_op(mips_instruction *ip, mips_instruction *op)
+{
+	int		result;
+
+	result = __get_user(*op, (mips_instruction *)ip);
+
+	return result;
+}
+
+/*
+ * Read an general purpose register-sized piece of data.
+ * @rp:		Address from which to read the data
+ * @reg:	Location in which to store the value once it has
+ *		been read.
+ * Returns zero on success, a negative errno value otherwise.
+ */
+int bt_get_reg(unsigned long *rp, unsigned long *reg)
+{
+	int		result;
+
+	result = __get_user(*reg, rp);
+	return result;
+}
+
+/*
+ * Read an piece of data as big as is used in the struct sigcontext registers.
+ * @rp:		Address from which to read the data
+ * @reg:	Location in which to store the value once it has
+ *		been read.
+ * Returns zero on success, a negative errno value otherwise.
+ */
+int bt_get_sc_reg(unsigned long long *rp, unsigned long *reg)
+{
+	int			result;
+	unsigned long long	sc_reg;
+
+	result = __get_user(sc_reg, rp);
+
+	if (result == 0)
+		*reg = sc_reg;
+
+	return result;
+}
+
+
+/*
+ * Advances to the next frame based on the analysis of the current frame
+ * done by kernel_backtrace_analyze_frame().
+ * @ctx:	Pointer to struct struct kernel_bt_ctx object.
+ * Returns:	KERNEL_BT_END_CTX_SWITCH The backtrace should stop because the
+ *					next frame is from user mode.
+ *		Zero			This is a good frame.
+ *		A negative errno value	The backtrace should stop because an
+ *					error has occurred.
+ */
+int kernel_backtrace_pop_frame(struct kernel_bt *kbt)
+{
+	int rc;
+
+	if (kbt->type == KERNEL_FRAME_THREAD) {
+		rc = thread_backtrace_pop_frame(&kbt->tbt);
+	} else {
+		struct pt_regs *regs;
+		struct base_bt *bbt;
+
+		bbt = &kbt->tbt.bbt;
+		regs = (struct pt_regs *)bbt->sp;
+
+		bbt->pc = (mips_instruction *)regs->cp0_epc;
+		bbt->ra = (mips_instruction *)regs->regs[MREG_RA];
+		bbt->sp = (unsigned long *)regs->regs[MREG_SP];
+
+		rc = 0;
+	}
+
+	return rc;
+}
+
+/*
+ * This handles getting the next kernel stackframe. It checks to see if we are
+ * in an exception or interrupt frame. If not, we just pass it along to the
+ * process backtracing.
+ * @kbt:	Pointer to the struct kernel_bt object
+ *
+ * Returns:	KERNEL_BT_END_IN_START_KERNEL The backtrace should stop
+ *					because the next frame is for
+ *					start_kernel(), whose memory has
+ *					probably been freed and overwritten.
+ *		Zero			This is a good frame.
+ *		A negative errno value	The backtrace should stop because an
+ *					error has occurred.
+ */
+int kernel_backtrace_next(struct kernel_bt *kbt)
+{
+	int	rc;
+
+	/*
+	 * If we're about to go off to start_kernel(), stop. The
+	 * address space for the start_kernel() code was released to
+	 * the buddy allocator and there is no telling what that address
+	 * space might hold.
+	 */
+	if (in_start_kernel(kbt->tbt.bbt.pc)) {
+		bt_dbg("Terminating backtrace because of entering "
+			"start_kernel()\n");
+		return KERNEL_BT_END_IN_START_KERNEL;
+	}
+
+	rc = kernel_backtrace_pop_frame(kbt);
+
+	if (rc == 0)
+		rc = __kernel_backtrace_analyze_frame(kbt);
+
+	return rc;
+}
+EXPORT_SYMBOL(kernel_backtrace_next);
+
+/*
+ * __kernel_backtrace_set_from_pt_regs - set values from struct pt_regs
+ * @bt:		Pointer to the &struct kernel_bt
+ * @regs:	Pointer to the register values to start with
+ */
+void __kernel_backtrace_set_from_pt_regs(struct kernel_bt *kbt,
+	 const struct pt_regs *regs)
+{
+	memset(kbt, 0, sizeof(*kbt));
+	__thread_backtrace_set_from_pt_regs(&kbt->tbt, regs);
+	kbt->cp0_status = regs->cp0_status;
+	kbt->cp0_epc = (mips_instruction *)regs->cp0_epc;
+}
+EXPORT_SYMBOL(__kernel_backtrace_set_from_pt_regs);
+
+/*
+ * kernel_backtrace_first_from_pt_regs - backtrace trace from pt_regs object
+ * @regs:	Pointer to a struct pt_regs object with the initial
+ *		register values to be used for the backtrace
+ * @process:	Function that processes a stack frame
+ * @arg:	Argument passed to the function that processes a
+ *		stack frame
+ *
+ * Returns zero on success, otherwise a negative errno value.
+ */
+int kernel_backtrace_first_from_pt_regs(struct kernel_bt *kbt,
+	const struct pt_regs *regs)
+{
+	int rc;
+
+	__kernel_backtrace_set_from_pt_regs(kbt, regs);
+	rc = __kernel_backtrace_analyze_frame(kbt);
+
+	return rc;
+}
+EXPORT_SYMBOL(kernel_backtrace_first_from_pt_regs);
diff --git a/arch/mips/lib/thread-backtrace.c b/arch/mips/lib/thread-backtrace.c
new file mode 100644
index 0000000..a9eb2e7
--- /dev/null
+++ b/arch/mips/lib/thread-backtrace.c
@@ -0,0 +1,289 @@
+/*
+ *			thread-backtrace.c
+ *
+ * Performs Linux-dependent MIPS processor stack backtracing for processes. It
+ * builds on the MIPS processor ABI-conformant stack backtracing code, but
+ * does the OS-dependent portions that handle signal frames, too. This allows
+ * it to do multi-frame backtracing.
+ *
+ * Copyright(C) 2007  Scientific-Atlanta, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ * Author: David VomLehn
+ */
+
+#include <asm/thread-backtrace.h>
+#include <asm/sigframe.h>
+
+/*
+ * thread_bt_ctx - info used only while analyzing a single frame
+ * @tbt:			Pointer to the thread_bt structure
+ */
+struct thread_bt_ctx {
+	struct thread_bt	*tbt;
+	enum base_bt_rule	rule;
+};
+
+/*
+ * is_syscall - determine whether op code is a syscall instruction
+ * @inst:	Instruction to check
+ *
+ * Returns true if @inst is a syscall, false otherwise.
+ */
+static inline int is_syscall(mips_instruction inst)
+{
+	struct syscall_format *op_p = (struct syscall_format *) &inst;
+	return op_p->opcode == spec_op &&
+		op_p->func == syscall_op;
+}
+
+/*
+ * analyze_non_signal_frame - analyze an ordinary signal frame
+ * @ctx:	Pointer to the &struct thread_bt_ctx for this frame
+ *
+ * Returns zero on success, otherwise a negative errno value.  Mostly this
+ * consists of handling the work of to the base backtrace code.
+ */
+static int analyze_non_signal_frame(struct thread_bt_ctx *ctx)
+{
+	ctx->tbt->type = THREAD_FRAME_BASE;
+	return __base_backtrace_analyze_frame(&ctx->tbt->bbt, ctx->rule);
+}
+
+/*
+ * analyze_signal_frame - complete analyze of a stack from from a signal
+ * @ctx:		Pointer to the &struct thread_bt_ctx
+ * @type:		Type of the frame
+ * @sc:			Pointer to the &struct sigcontext on the stack
+ * @sigframe_offset	Number of bytes between the address indicated by
+ *			the stack pointer and the arguments to the
+ *			signal handler
+ *
+ * Returns zero on success or a negative errno value.
+ */
+static int analyze_signal_frame(struct thread_bt_ctx *ctx,
+	enum thread_frame_type type, struct sigcontext *sc,
+	unsigned long sigargs_offset)
+{
+	struct base_bt *bbt;
+	unsigned long *next_sp;
+	unsigned long reg;
+	int rc;
+	int i;
+
+	bbt = &ctx->tbt->bbt;
+
+	for (i = 0; i < ARRAY_SIZE(sc->sc_regs); i++) {
+		if (save_before_use[i]) {
+			enum saved_gpr_num sreg;
+
+			sreg = mreg_to_sreg[i];
+			rc = bt_get_sc_reg(&sc->sc_regs[i], &reg);
+			if (rc != 0)
+				return rc;
+			bbt->gprs[sreg].value = reg;
+			bbt->gprs[sreg].read = true;
+		}
+	}
+
+	ctx->tbt->type = type;
+
+	rc = bt_get_sc_reg(&sc->sc_regs[MREG_SP], &reg);
+	if (rc != 0)
+		return rc;
+
+	next_sp = (unsigned long *)reg;
+	bbt->frame_size = (char *)next_sp - (char *)bbt->fp;
+	ctx->tbt->sigargs = (unsigned long *)((char *)ctx->tbt->bbt.sp +
+		sigargs_offset);
+
+	bbt->next_pc = (mips_instruction *)(unsigned long)sc->sc_pc;
+
+	return 0;
+}
+
+/*
+ * __thread_backtrace_analyze_frame - handles possible signal frame
+ * @tbt:	Pointer to backtrace register and other information.
+ * @rule:	Parsing rule to use
+ *
+ * Returns zero if we were able to determine whether we were in a
+ *		signal trampoline and a negative errno value if not.
+ *
+ * Analyzes the current stack frame to see whether we are executing in a
+ * signal trampoline. To do this, we look at the instructions at the
+ * return address. If we have a load of $v0 with one of a few special values,
+ * followed by a syscall, this frame is actually for a signal trampoline.
+ */
+int __thread_backtrace_analyze_frame(struct thread_bt *tbt,
+	enum base_bt_rule rule)
+{
+	int rc;
+	mips_instruction op1, op2;
+	mips_instruction *pc;
+	struct thread_bt_ctx ctx;
+
+	/* Start by trying to read two instructions since that's how long the
+	 * signal trampoline is. */
+	ctx.tbt = tbt;
+	ctx.rule = rule;
+
+	pc = tbt->bbt.pc;
+	rc = bt_get_op(pc, &op1);
+
+	if (rc == 0)
+		rc = bt_get_op(pc + 1, &op2);
+
+	if (rc == 0) {
+		struct base_bt *bbt;
+
+		bbt = &ctx.tbt->bbt;
+
+		/* If we could read the instructions, check to see whether
+		 * they are the right ones for the signal trampoline. */
+		if (!is_li(op1, MREG_V0) || !is_syscall(op2)) {
+			rc = analyze_non_signal_frame(&ctx);
+		} else {
+			unsigned long sigargs_offset;
+
+			/*
+			 * We do have an 'li v0,<value>' followed by a
+			 * syscall. Is the system call we are doing one that
+			 * is involved with signal return processing?
+			 */
+
+			switch (((struct u_format *)&op1)->uimmediate) {
+			case __NR_O32_sigreturn:
+				sigargs_offset = offsetof(struct sigframe,
+					sf_ass);
+				rc = analyze_signal_frame(&ctx,
+					THREAD_FRAME_SIGNAL,
+					&((struct sigframe *)bbt->sp)->sf_sc,
+					sigargs_offset);
+				break;
+
+			case __NR_O32_rt_sigreturn:
+				sigargs_offset = offsetof(struct rt_sigframe,
+					rs_ass);
+				rc = analyze_signal_frame(&ctx,
+					THREAD_FRAME_RT_SIGNAL,
+					&((struct rt_sigframe *)bbt->sp)->
+						rs_uc.uc_mcontext,
+					sigargs_offset);
+				break;
+
+			default:
+				/* Some other type of system call */
+				rc = analyze_non_signal_frame(&ctx);
+				break;
+			}
+		}
+	}
+
+	return rc;
+}
+EXPORT_SYMBOL(__thread_backtrace_analyze_frame);
+
+/*
+ * pop_signal_frame - advance to the next frame after a signal frame
+ */
+static int pop_signal_frame(struct thread_bt *tbt)
+{
+	int rc;
+
+	rc = base_backtrace_pop_frame(&tbt->bbt);
+
+	return rc;
+}
+
+/*
+ * thread_backtrace_pop_frame - Advances to the next stack frame.
+ * @tbt:	Pointer to a struct thread_bt object.
+ * Returns zero on success and a negative errno on failure.
+ */
+int thread_backtrace_pop_frame(struct thread_bt *tbt)
+{
+	int	result;
+
+	switch (tbt->type) {
+	case THREAD_FRAME_BASE:
+		result = base_backtrace_pop_frame(&tbt->bbt);
+		break;
+
+	case THREAD_FRAME_SIGNAL:
+	case THREAD_FRAME_RT_SIGNAL:
+		result = pop_signal_frame(tbt);
+		break;
+
+	default:
+		result = -EINVAL;	/* Internal failure: shouldn't happen */
+		bt_dbg("Unexpected frame type: %d\n", tbt->type);
+		break;
+	}
+
+	return result;
+}
+
+/*
+ * Handle one stack backtrace frame, updating the register according to what
+ * is found.
+ * @tbt:	Pointer to register and backtrace information.
+ * Returns aero on success, a negative errno otherwise.
+ */
+int thread_backtrace_next(struct thread_bt *tbt, enum base_bt_rule rule)
+{
+	int		result;
+
+	result = thread_backtrace_pop_frame(tbt);
+
+	if (result == 0)
+		result = __thread_backtrace_analyze_frame(tbt, rule);
+
+	return result;
+}
+EXPORT_SYMBOL(thread_backtrace_next);
+
+/*
+ * __thread_backtrace_set_from_pt_regs - set values from struct pt_regs
+ * @bt:		Pointer to the &struct thread_bt
+ * @regs:	Pointer to the register values to start with
+ */
+void __thread_backtrace_set_from_pt_regs(struct thread_bt *tbt,
+	 const struct pt_regs *regs)
+{
+	memset(tbt, 0, sizeof(*tbt));
+	__base_backtrace_set_from_pt_regs(&tbt->bbt, regs);
+}
+EXPORT_SYMBOL(__thread_backtrace_set_from_pt_regs);
+
+/*
+ * thread_backtrace_first_from_pt_regs - backtrace starting with struct pt_regs
+ * @bt:		Pointer to the &struct thread_bt
+ * @rule:	Rules to use for the backtrace
+ * @regs:	Pointer to the register values to start with
+ */
+int thread_backtrace_first_from_pt_regs(struct thread_bt *tbt,
+	enum base_bt_rule rule, const struct pt_regs *regs)
+{
+	int rc;
+
+	memset(tbt, 0, sizeof(*tbt));
+	__thread_backtrace_set_from_pt_regs(tbt, regs);
+	rc = __thread_backtrace_analyze_frame(tbt, rule);
+
+	return rc;
+}
+EXPORT_SYMBOL(thread_backtrace_first_from_pt_regs);
diff --git a/scripts/module-common.lds b/scripts/module-common.lds
deleted file mode 100644
index 0865b3e..0000000
--- a/scripts/module-common.lds
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * Common module linker script, always used when linking a module.
- * Archs are free to supply their own linker scripts.  ld will
- * combine them automatically.
- */
-SECTIONS {
-	/DISCARD/ : { *(.discard) }
-
-	__ksymtab		: { *(SORT(___ksymtab+*)) }
-	__ksymtab_gpl		: { *(SORT(___ksymtab_gpl+*)) }
-	__ksymtab_unused	: { *(SORT(___ksymtab_unused+*)) }
-	__ksymtab_unused_gpl	: { *(SORT(___ksymtab_unused_gpl+*)) }
-	__ksymtab_gpl_future	: { *(SORT(___ksymtab_gpl_future+*)) }
-	__kcrctab		: { *(SORT(___kcrctab+*)) }
-	__kcrctab_gpl		: { *(SORT(___kcrctab_gpl+*)) }
-	__kcrctab_unused	: { *(SORT(___kcrctab_unused+*)) }
-	__kcrctab_unused_gpl	: { *(SORT(___kcrctab_unused_gpl+*)) }
-	__kcrctab_gpl_future	: { *(SORT(___kcrctab_gpl_future+*)) }
-}
