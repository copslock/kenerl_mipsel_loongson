Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2012 17:26:42 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:39812 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903697Ab2DIPWb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Apr 2012 17:22:31 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SHGQC-0005vf-Ej; Mon, 09 Apr 2012 10:22:24 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>,
        Leonid Yegoshin <yegoshin@mips.com>
Subject: [PATCH 9/9] MIPS: Support microMIPS/MIPS16e floating point.
Date:   Mon,  9 Apr 2012 10:22:03 -0500
Message-Id: <1333984923-445-10-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.6
In-Reply-To: <1333984923-445-1-git-send-email-sjhill@mips.com>
References: <1333984923-445-1-git-send-email-sjhill@mips.com>
X-archive-position: 32901
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

Add logic needed to do floating point emulation when in
microMIPS or MIPS16e mode.

Signed-off-by: Leonid Yegoshin <yegoshin@mips.com>
Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/fpu_emulator.h |    7 +
 arch/mips/math-emu/cp1emu.c          |  766 ++++++++++++++++++++++++++++++----
 arch/mips/math-emu/dsemul.c          |   40 +-
 3 files changed, 717 insertions(+), 96 deletions(-)

diff --git a/arch/mips/include/asm/fpu_emulator.h b/arch/mips/include/asm/fpu_emulator.h
index 3b40927..67d5028 100644
--- a/arch/mips/include/asm/fpu_emulator.h
+++ b/arch/mips/include/asm/fpu_emulator.h
@@ -54,6 +54,12 @@ do {									\
 extern int mips_dsemul(struct pt_regs *regs, mips_instruction ir,
 	unsigned long cpc);
 extern int do_dsemulret(struct pt_regs *xcp);
+extern int fpu_emulator_cop1Handler(struct pt_regs *xcp,
+				    struct mips_fpu_struct *ctx, int has_fpu,
+				    void *__user *fault_addr);
+int process_fpemu_return(int sig, void __user *fault_addr);
+int mm_isBranchInstr(struct pt_regs *regs, struct decoded_instn dec_insn,
+		     unsigned long *contpc);
 
 /*
  * Instruction inserted following the badinst to further tag the sequence
@@ -64,5 +70,6 @@ extern int do_dsemulret(struct pt_regs *xcp);
  * Break instruction with special math emu break code set
  */
 #define BREAK_MATH (0x0000000d | (BRK_MEMU << 16))
+#define MM_BREAK_MATH (0x00000007 | (MM_BRK_MEMU << 16))
 
 #endif /* _ASM_FPU_EMULATOR_H */
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index a03bf00..366c0c5 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -45,6 +45,7 @@
 #include <asm/signal.h>
 #include <asm/mipsregs.h>
 #include <asm/fpu_emulator.h>
+#include <asm/fpu.h>
 #include <asm/uaccess.h>
 #include <asm/branch.h>
 
@@ -110,6 +111,477 @@ static const unsigned int fpucondbit[8] = {
 };
 #endif
 
+/* convert 16-bit register encoding to 32-bit register encoding */
+static const unsigned int reg16to32map[8] = {16, 17, 2, 3, 4, 5, 6, 7};
+
+/* convert micro_mips to mips32 format */
+static const int sd_format[] = {16, 17, 0, 0, 0, 0, 0, 0};
+static const int sdps_format[] = {16, 17, 22, 0, 0, 0, 0, 0};
+static const int dwl_format[] = {17, 20, 21, 0, 0, 0, 0, 0};
+static const int swl_format[] = {16, 20, 21, 0, 0, 0, 0, 0};
+
+/*
+ * This functions translates a 32 bit micro_mips instr into a 32 bit mips32 instr.
+ * It return 0 or SIGILL.
+ */
+static int micro_mips32_to_mips32(union mips_instruction *insn_ptr)
+{
+	union mips_instruction insn = *insn_ptr;
+	union mips_instruction mips32_insn = insn;  /* assume they are the same */
+	int func;
+	int fmt;
+	int op;
+
+	switch (insn.mm_i_format.opcode) {
+	case mm_ldc132_op:
+		mips32_insn.mm_i_format.opcode = ldc1_op;
+		mips32_insn.mm_i_format.rt = insn.mm_i_format.rs;
+		mips32_insn.mm_i_format.rs = insn.mm_i_format.rt;
+		break;
+	case mm_lwc132_op:
+		mips32_insn.mm_i_format.opcode = lwc1_op;
+		mips32_insn.mm_i_format.rt = insn.mm_i_format.rs;
+		mips32_insn.mm_i_format.rs = insn.mm_i_format.rt;
+		break;
+	case mm_sdc132_op:
+		mips32_insn.mm_i_format.opcode = sdc1_op;
+		mips32_insn.mm_i_format.rt = insn.mm_i_format.rs;
+		mips32_insn.mm_i_format.rs = insn.mm_i_format.rt;
+		break;
+	case mm_swc132_op:
+		mips32_insn.mm_i_format.opcode = swc1_op;
+		mips32_insn.mm_i_format.rt = insn.mm_i_format.rs;
+		mips32_insn.mm_i_format.rs = insn.mm_i_format.rt;
+		break;
+	case mm_pool32i_op:
+		/* NOTE: offset is << by 1 if in micro_mips mode */
+		if ((insn.mm_i_format.rt == mm_bc1f_op) || (insn.mm_i_format.rt == mm_bc1t_op)) {
+			mips32_insn.fb_format.opcode = cop1_op;
+			mips32_insn.fb_format.bc = bc_op;
+			mips32_insn.fb_format.flag = (insn.mm_i_format.rt == mm_bc1t_op) ? 1 : 0;
+		} else
+			return SIGILL;
+		break;
+	case mm_pool32f_op:
+		switch (insn.mm_fp0_format.func) {
+		case mm_32f_01_op:
+		case mm_32f_11_op:
+		case mm_32f_02_op:
+		case mm_32f_12_op:
+		case mm_32f_41_op:
+		case mm_32f_51_op:
+		case mm_32f_42_op:
+		case mm_32f_52_op:
+			op = insn.mm_fp0_format.func;
+			if (op == mm_32f_01_op)
+				func = madd_s_op;
+			else if (op == mm_32f_11_op)
+				func = madd_d_op;
+			else if (op == mm_32f_02_op)
+				func = nmadd_s_op;
+			else if (op == mm_32f_12_op)
+				func = nmadd_d_op;
+			else if (op == mm_32f_41_op)
+				func = msub_s_op;
+			else if (op == mm_32f_51_op)
+				func = msub_d_op;
+			else if (op == mm_32f_42_op)
+				func = nmsub_s_op;
+			else
+				func = nmsub_d_op;
+			mips32_insn.fp6_format.opcode = cop1x_op;
+			mips32_insn.fp6_format.fr = insn.mm_fp6_format.fr;
+			mips32_insn.fp6_format.ft = insn.mm_fp6_format.ft;
+			mips32_insn.fp6_format.fs = insn.mm_fp6_format.fs;
+			mips32_insn.fp6_format.fd = insn.mm_fp6_format.fd;
+			mips32_insn.fp6_format.func = func;
+			break;
+		case mm_32f_10_op:
+			func = -1;  /* set to invalid value */
+			op = insn.mm_fp5_format.op & 0x7;
+			if (op == mm_ldxc1_op)
+				func = ldxc1_op;
+			else if (op == mm_sdxc1_op)
+				func = sdxc1_op;
+			else if (op == mm_lwxc1_op)
+				func = lwxc1_op;
+			else if (op == mm_swxc1_op)
+				func = swxc1_op;
+
+			if (func != -1) {
+				mips32_insn.r_format.opcode = cop1x_op;
+				mips32_insn.r_format.rs = insn.mm_fp5_format.base;
+				mips32_insn.r_format.rt = insn.mm_fp5_format.index;
+				mips32_insn.r_format.rd = 0;
+				mips32_insn.r_format.re = insn.mm_fp5_format.fd;
+				mips32_insn.r_format.func = func;
+			} else
+				return SIGILL;
+			break;
+		case mm_32f_40_op:
+			op = -1;  /* set to invalid value */
+			if (insn.mm_fp2_format.op == mm_fmovt_op)
+				op = 1;
+			else if (insn.mm_fp2_format.op == mm_fmovf_op)
+				op = 0;
+			if (op != -1) {
+				mips32_insn.fp0_format.opcode = cop1_op;
+				mips32_insn.fp0_format.fmt = sdps_format[insn.mm_fp2_format.fmt];
+				mips32_insn.fp0_format.ft = (insn.mm_fp2_format.cc<<2) + op;
+				mips32_insn.fp0_format.fs = insn.mm_fp2_format.fs;
+				mips32_insn.fp0_format.fd = insn.mm_fp2_format.fd;
+				mips32_insn.fp0_format.func = fmovc_op;
+			} else
+				return SIGILL;
+			break;
+		case mm_32f_60_op:
+			func = -1;  /* set to invalid value */
+			if (insn.mm_fp0_format.op == mm_fadd_op)
+				func = fadd_op;
+			else if (insn.mm_fp0_format.op == mm_fsub_op)
+				func = fsub_op;
+			else if (insn.mm_fp0_format.op == mm_fmul_op)
+				func = fmul_op;
+			else if (insn.mm_fp0_format.op == mm_fdiv_op)
+				func = fdiv_op;
+			if (func != -1) {
+				mips32_insn.fp0_format.opcode = cop1_op;
+				mips32_insn.fp0_format.fmt = sdps_format[insn.mm_fp0_format.fmt];
+				mips32_insn.fp0_format.ft = insn.mm_fp0_format.ft;
+				mips32_insn.fp0_format.fs = insn.mm_fp0_format.fs;
+				mips32_insn.fp0_format.fd = insn.mm_fp0_format.fd;
+				mips32_insn.fp0_format.func = func;
+			} else
+				return SIGILL;
+			break;
+		case mm_32f_70_op:
+			func = -1;  /* set to invalid value */
+			if (insn.mm_fp0_format.op == mm_fmovn_op)
+				func = fmovn_op;
+			else if (insn.mm_fp0_format.op == mm_fmovz_op)
+				func = fmovz_op;
+			if (func != -1) {
+				mips32_insn.fp0_format.opcode = cop1_op;
+				mips32_insn.fp0_format.fmt = sdps_format[insn.mm_fp0_format.fmt];
+				mips32_insn.fp0_format.ft = insn.mm_fp0_format.ft;
+				mips32_insn.fp0_format.fs = insn.mm_fp0_format.fs;
+				mips32_insn.fp0_format.fd = insn.mm_fp0_format.fd;
+				mips32_insn.fp0_format.func = func;
+			} else
+				return SIGILL;
+			break;
+		case mm_32f_73_op:    /* POOL32FXF */
+			switch (insn.mm_fp1_format.op) {
+			case mm_movf0_op:
+			case mm_movf1_op:
+			case mm_movt0_op:
+			case mm_movt1_op:
+				if ((insn.mm_fp1_format.op & 0x7f) == mm_movf0_op)
+					op = 0;
+				else
+					op = 1;
+				mips32_insn.r_format.opcode = spec_op;
+				mips32_insn.r_format.rs = insn.mm_fp4_format.fs;
+				mips32_insn.r_format.rt = (insn.mm_fp4_format.cc<<2) + op;
+				mips32_insn.r_format.rd = insn.mm_fp4_format.rt;
+				mips32_insn.r_format.re = 0;
+				mips32_insn.r_format.func = movc_op;
+				break;
+			case mm_fcvtd0_op:
+			case mm_fcvtd1_op:
+			case mm_fcvts0_op:
+			case mm_fcvts1_op:
+				if ((insn.mm_fp1_format.op & 0x7f) == mm_fcvtd0_op) {
+					func = fcvtd_op;
+					fmt = swl_format[insn.mm_fp3_format.fmt];
+				} else {
+					func = fcvts_op;
+					fmt = dwl_format[insn.mm_fp3_format.fmt];
+				}
+				mips32_insn.fp0_format.opcode = cop1_op;
+				mips32_insn.fp0_format.fmt = fmt;
+				mips32_insn.fp0_format.ft = 0;
+				mips32_insn.fp0_format.fs = insn.mm_fp3_format.fs;
+				mips32_insn.fp0_format.fd = insn.mm_fp3_format.rt;
+				mips32_insn.fp0_format.func = func;
+				break;
+			case mm_fmov0_op:
+			case mm_fmov1_op:
+			case mm_fabs0_op:
+			case mm_fabs1_op:
+			case mm_fneg0_op:
+			case mm_fneg1_op:
+				if ((insn.mm_fp1_format.op & 0x7f) == mm_fmov0_op)
+					func = fmov_op;
+				else if ((insn.mm_fp1_format.op & 0x7f) == mm_fabs0_op)
+					func = fabs_op;
+				else
+					func = fneg_op;
+				mips32_insn.fp0_format.opcode = cop1_op;
+				mips32_insn.fp0_format.fmt = sdps_format[insn.mm_fp3_format.fmt];
+				mips32_insn.fp0_format.ft = 0;
+				mips32_insn.fp0_format.fs = insn.mm_fp3_format.fs;
+				mips32_insn.fp0_format.fd = insn.mm_fp3_format.rt;
+				mips32_insn.fp0_format.func = func;
+				break;
+			case mm_ffloorl_op:
+			case mm_ffloorw_op:
+			case mm_fceill_op:
+			case mm_fceilw_op:
+			case mm_ftruncl_op:
+			case mm_ftruncw_op:
+			case mm_froundl_op:
+			case mm_froundw_op:
+			case mm_fcvtl_op:
+			case mm_fcvtw_op:
+				if (insn.mm_fp1_format.op == mm_ffloorl_op)
+					func = ffloorl_op;
+				else if (insn.mm_fp1_format.op == mm_ffloorw_op)
+					func = ffloor_op;
+				else if (insn.mm_fp1_format.op == mm_fceill_op)
+					func = fceill_op;
+				else if (insn.mm_fp1_format.op == mm_fceilw_op)
+					func = fceil_op;
+				else if (insn.mm_fp1_format.op == mm_ftruncl_op)
+					func = ftruncl_op;
+				else if (insn.mm_fp1_format.op == mm_ftruncw_op)
+					func = ftrunc_op;
+				else if (insn.mm_fp1_format.op == mm_froundl_op)
+					func = froundl_op;
+				else if (insn.mm_fp1_format.op == mm_froundw_op)
+					func = fround_op;
+				else if (insn.mm_fp1_format.op == mm_fcvtl_op)
+					func = fcvtl_op;
+				else
+					func = fcvtw_op;
+				mips32_insn.fp0_format.opcode = cop1_op;
+				mips32_insn.fp0_format.fmt = sd_format[insn.mm_fp1_format.fmt];
+				mips32_insn.fp0_format.ft = 0;
+				mips32_insn.fp0_format.fs = insn.mm_fp1_format.fs;
+				mips32_insn.fp0_format.fd = insn.mm_fp1_format.rt;
+				mips32_insn.fp0_format.func = func;
+				break;
+			case mm_frsqrt_op:
+			case mm_fsqrt_op:
+			case mm_frecip_op:
+				if (insn.mm_fp1_format.op == mm_frsqrt_op)
+					func = frsqrt_op;
+				else if (insn.mm_fp1_format.op == mm_fsqrt_op)
+					func = fsqrt_op;
+				else
+					func = frecip_op;
+				mips32_insn.fp0_format.opcode = cop1_op;
+				mips32_insn.fp0_format.fmt = sdps_format[insn.mm_fp1_format.fmt];
+				mips32_insn.fp0_format.ft = 0;
+				mips32_insn.fp0_format.fs = insn.mm_fp1_format.fs;
+				mips32_insn.fp0_format.fd = insn.mm_fp1_format.rt;
+				mips32_insn.fp0_format.func = func;
+				break;
+			case mm_mfc1_op:
+			case mm_mtc1_op:
+			case mm_cfc1_op:
+			case mm_ctc1_op:
+				if (insn.mm_fp1_format.op == mm_mfc1_op)
+					op = mfc_op;
+				else if (insn.mm_fp1_format.op == mm_mtc1_op)
+					op = mtc_op;
+				else if (insn.mm_fp1_format.op == mm_cfc1_op)
+					op = cfc_op;
+				else
+					op = ctc_op;
+				mips32_insn.fp1_format.opcode = cop1_op;
+				mips32_insn.fp1_format.op = op;
+				mips32_insn.fp1_format.rt = insn.mm_fp1_format.rt;
+				mips32_insn.fp1_format.fs = insn.mm_fp1_format.fs;
+				mips32_insn.fp1_format.fd = 0;
+				mips32_insn.fp1_format.func = 0;
+				break;
+			default:
+				return SIGILL;
+				break;
+			}
+			break;
+		case mm_32f_74_op:    /* c.cond.fmt */
+			mips32_insn.fp0_format.opcode = cop1_op;
+			mips32_insn.fp0_format.fmt = sdps_format[insn.mm_fp4_format.fmt];
+			mips32_insn.fp0_format.ft = insn.mm_fp4_format.rt;
+			mips32_insn.fp0_format.fs = insn.mm_fp4_format.fs;
+			mips32_insn.fp0_format.fd = insn.mm_fp4_format.cc<<2;
+			mips32_insn.fp0_format.func = insn.mm_fp4_format.cond | MIPS32_COND_FC;
+			break;
+		default:
+			return SIGILL;
+			break;
+		}
+		break;
+	default:
+		return SIGILL;
+		break;
+	}
+
+	*insn_ptr = mips32_insn;
+	return 0;
+}
+
+/* micro_mips version of isBranchInstr() */
+int mm_isBranchInstr(struct pt_regs *regs, struct decoded_instn dec_insn,
+		     unsigned long *contpc)
+{
+	union mips_instruction insn = (union mips_instruction)dec_insn.insn;
+	int bc_false = 0;
+	unsigned int fcr31;
+	unsigned int bit;
+
+	/* NOTE: for 16-bit instructions, they are duplicated and stored as a 32-bit value. */
+	switch (insn.mm_i_format.opcode) {
+	case mm_pool32a_op:
+		if ((insn.mm_i_format.simmediate & MM_POOL32A_MINOR_MSK) == mm_pool32axf_op) {
+			switch (insn.mm_i_format.simmediate >> MM_POOL32A_MINOR_SFT) {
+			case mm_jalr_op:
+			case mm_jalrhb_op:
+			case mm_jalrs_op:
+			case mm_jalrshb_op:
+				if (insn.mm_i_format.rt != 0)   /* not a mm_jr_op */
+					regs->regs[insn.mm_i_format.rt] = regs->cp0_epc + dec_insn.pc_inc + dec_insn.next_pc_inc;
+				*contpc = regs->regs[insn.mm_i_format.rs];
+				return 1;
+				break;
+			}
+		}
+		break;
+	case mm_pool32i_op:
+		switch (insn.mm_i_format.rt) {
+		case mm_bltzals_op:
+		case mm_bltzal_op:
+			regs->regs[31] = regs->cp0_epc + dec_insn.pc_inc + dec_insn.next_pc_inc;
+			/* Fall through */
+		case mm_bltz_op:
+			if ((long)regs->regs[insn.mm_i_format.rs] < 0)
+				*contpc = regs->cp0_epc + dec_insn.pc_inc + (insn.mm_i_format.simmediate << 1);
+			else
+				*contpc = regs->cp0_epc + dec_insn.pc_inc + dec_insn.next_pc_inc;
+			return 1;
+			break;
+		case mm_bgezals_op:
+		case mm_bgezal_op:
+			regs->regs[31] = regs->cp0_epc + dec_insn.pc_inc + dec_insn.next_pc_inc;
+			/* Fall through */
+		case mm_bgez_op:
+			if ((long)regs->regs[insn.mm_i_format.rs] >= 0)
+				*contpc = regs->cp0_epc + dec_insn.pc_inc + (insn.mm_i_format.simmediate << 1);
+			else
+				*contpc = regs->cp0_epc + dec_insn.pc_inc + dec_insn.next_pc_inc;
+			return 1;
+			break;
+		case mm_blez_op:
+			if ((long)regs->regs[insn.mm_i_format.rs] <= 0)
+				*contpc = regs->cp0_epc + dec_insn.pc_inc + (insn.mm_i_format.simmediate << 1);
+			else
+				*contpc = regs->cp0_epc + dec_insn.pc_inc + dec_insn.next_pc_inc;
+			return 1;
+			break;
+		case mm_bgtz_op:
+			if ((long)regs->regs[insn.mm_i_format.rs] <= 0)
+				*contpc = regs->cp0_epc + dec_insn.pc_inc + (insn.mm_i_format.simmediate << 1);
+			else
+				*contpc = regs->cp0_epc + dec_insn.pc_inc + dec_insn.next_pc_inc;
+			return 1;
+			break;
+		case mm_bc2f_op:
+		case mm_bc1f_op:
+			bc_false = 1;
+			/* Fall through */
+		case mm_bc2t_op:
+		case mm_bc1t_op:
+			preempt_disable();
+			if (is_fpu_owner())
+				asm volatile("cfc1\t%0,$31" : "=r" (fcr31));
+			else
+				fcr31 = current->thread.fpu.fcr31;
+			preempt_enable();
+
+			if (bc_false)
+				fcr31 = ~fcr31;
+
+			bit = (insn.mm_i_format.rs >> 2);
+			bit += (bit != 0);
+			bit += 23;
+			if (fcr31 & (1 << bit))
+				*contpc = regs->cp0_epc + dec_insn.pc_inc + (insn.mm_i_format.simmediate << 1);
+			else
+				*contpc = regs->cp0_epc + dec_insn.pc_inc + dec_insn.next_pc_inc;
+			return 1;
+			break;
+		}
+		break;
+	case mm_pool16c_op:
+		switch (insn.mm_i_format.rt) {
+		case mm_jalr16_op:
+		case mm_jalrs16_op:
+			regs->regs[31] = regs->cp0_epc + dec_insn.pc_inc + dec_insn.next_pc_inc;
+			/* Fall through */
+		case mm_jr16_op:
+			*contpc = regs->regs[insn.mm_i_format.rs];
+			return 1;
+			break;
+		}
+		break;
+	case mm_beqz16_op:
+		if ((long)regs->regs[reg16to32map[insn.mm16b1_format.rs]] == 0)
+			*contpc = regs->cp0_epc + dec_insn.pc_inc + (insn.mm16b1_format.simmediate << 1);
+		else
+			*contpc = regs->cp0_epc + dec_insn.pc_inc + dec_insn.next_pc_inc;
+		return 1;
+		break;
+	case mm_bnez16_op:
+		if ((long)regs->regs[reg16to32map[insn.mm16b1_format.rs]] != 0)
+			*contpc = regs->cp0_epc + dec_insn.pc_inc + (insn.mm16b1_format.simmediate << 1);
+		else
+			*contpc = regs->cp0_epc + dec_insn.pc_inc + dec_insn.next_pc_inc;
+		return 1;
+		break;
+	case mm_b16_op:
+		*contpc = regs->cp0_epc + dec_insn.pc_inc + (insn.mm16b0_format.simmediate << 1);
+		return 1;
+		break;
+	case mm_beq32_op:
+		if (regs->regs[insn.mm_i_format.rs] == regs->regs[insn.mm_i_format.rt])
+			*contpc = regs->cp0_epc + dec_insn.pc_inc + (insn.mm_i_format.simmediate << 1);
+		else
+			*contpc = regs->cp0_epc + dec_insn.pc_inc + dec_insn.next_pc_inc;
+		return 1;
+		break;
+	case mm_bne32_op:
+		if (regs->regs[insn.mm_i_format.rs] != regs->regs[insn.mm_i_format.rt])
+			*contpc = regs->cp0_epc + dec_insn.pc_inc + (insn.mm_i_format.simmediate << 1);
+		else
+			*contpc = regs->cp0_epc + dec_insn.pc_inc + dec_insn.next_pc_inc;
+		return 1;
+		break;
+	case mm_jalx32_op:
+		regs->regs[31] = regs->cp0_epc + dec_insn.pc_inc +
+			dec_insn.next_pc_inc;
+		*contpc = regs->cp0_epc + dec_insn.pc_inc;
+		*contpc >>= 28;
+		*contpc <<= 28;
+		*contpc |= (insn.j_format.target << 2);
+		return 1;
+		break;
+	case mm_jals32_op:
+	case mm_jal32_op:
+		regs->regs[31] = regs->cp0_epc + dec_insn.pc_inc + dec_insn.next_pc_inc;
+		/* Fall through */
+	case mm_j32_op:
+		*contpc = regs->cp0_epc + dec_insn.pc_inc;
+		*contpc >>= 27;
+		*contpc <<= 27;
+		*contpc |= (insn.j_format.target << 1);
+		*contpc |= MIPS_ISA_MODE;
+		return 1;
+		break;
+	}
+	return 0;
+}
 
 /*
  * Redundant with logic already in kernel/branch.c,
@@ -117,53 +589,134 @@ static const unsigned int fpucondbit[8] = {
  * a single subroutine should be used across both
  * modules.
  */
-static int isBranchInstr(mips_instruction * i)
+static int isBranchInstr(struct pt_regs *regs, struct decoded_instn dec_insn, unsigned long *contpc)
 {
-	switch (MIPSInst_OPCODE(*i)) {
+	union mips_instruction insn = (union mips_instruction)dec_insn.insn;
+	unsigned int fcr31;
+	unsigned int bit = 0;
+
+	switch (insn.i_format.opcode) {
 	case spec_op:
-		switch (MIPSInst_FUNC(*i)) {
+		switch (insn.r_format.func) {
 		case jalr_op:
+			regs->regs[insn.r_format.rd] = regs->cp0_epc + dec_insn.pc_inc + dec_insn.next_pc_inc;
+			/* Fall through */
 		case jr_op:
+			*contpc = regs->regs[insn.r_format.rs];
 			return 1;
+			break;
 		}
 		break;
-
 	case bcond_op:
-		switch (MIPSInst_RT(*i)) {
+		switch (insn.i_format.rt) {
+		case bltzal_op:
+		case bltzall_op:
+			regs->regs[31] = regs->cp0_epc + dec_insn.pc_inc + dec_insn.next_pc_inc;
+			/* Fall through */
 		case bltz_op:
-		case bgez_op:
 		case bltzl_op:
-		case bgezl_op:
-		case bltzal_op:
+			if ((long)regs->regs[insn.i_format.rs] < 0)
+				*contpc = regs->cp0_epc + dec_insn.pc_inc + (insn.i_format.simmediate << 2);
+			else
+				*contpc = regs->cp0_epc + dec_insn.pc_inc + dec_insn.next_pc_inc;
+			return 1;
+			break;
 		case bgezal_op:
-		case bltzall_op:
 		case bgezall_op:
+			regs->regs[31] = regs->cp0_epc + dec_insn.pc_inc + dec_insn.next_pc_inc;
+			/* Fall through */
+		case bgez_op:
+		case bgezl_op:
+			if ((long)regs->regs[insn.i_format.rs] >= 0)
+				*contpc = regs->cp0_epc + dec_insn.pc_inc + (insn.i_format.simmediate << 2);
+			else
+				*contpc = regs->cp0_epc + dec_insn.pc_inc + dec_insn.next_pc_inc;
 			return 1;
+			break;
 		}
 		break;
-
-	case j_op:
-	case jal_op:
 	case jalx_op:
+		bit = MIPS_ISA_MODE;
+	case jal_op:
+		regs->regs[31] = regs->cp0_epc + dec_insn.pc_inc + dec_insn.next_pc_inc;
+		/* Fall through */
+	case j_op:
+		*contpc = regs->cp0_epc + dec_insn.pc_inc;
+		*contpc >>= 28;
+		*contpc <<= 28;
+		*contpc |= (insn.j_format.target << 2);
+		/* set micro_mips mode bit: xor for jalx. LY22 */
+		*contpc ^= bit;
+		return 1;
+		break;
 	case beq_op:
-	case bne_op:
-	case blez_op:
-	case bgtz_op:
 	case beql_op:
+		if (regs->regs[insn.i_format.rs] == regs->regs[insn.i_format.rt])
+			*contpc = regs->cp0_epc + dec_insn.pc_inc + (insn.i_format.simmediate << 2);
+		else
+			*contpc = regs->cp0_epc + dec_insn.pc_inc + dec_insn.next_pc_inc;
+		return 1;
+		break;
+	case bne_op:
 	case bnel_op:
+		if (regs->regs[insn.i_format.rs] != regs->regs[insn.i_format.rt])
+			*contpc = regs->cp0_epc + dec_insn.pc_inc + (insn.i_format.simmediate << 2);
+		else
+			*contpc = regs->cp0_epc + dec_insn.pc_inc + dec_insn.next_pc_inc;
+		return 1;
+		break;
+	case blez_op:
 	case blezl_op:
+		if ((long)regs->regs[insn.i_format.rs] <= 0)
+			*contpc = regs->cp0_epc + dec_insn.pc_inc + (insn.i_format.simmediate << 2);
+		else
+			*contpc = regs->cp0_epc + dec_insn.pc_inc + dec_insn.next_pc_inc;
+		return 1;
+		break;
+	case bgtz_op:
 	case bgtzl_op:
+		if ((long)regs->regs[insn.i_format.rs] > 0)
+			*contpc = regs->cp0_epc + dec_insn.pc_inc + (insn.i_format.simmediate << 2);
+		else
+			*contpc = regs->cp0_epc + dec_insn.pc_inc + dec_insn.next_pc_inc;
 		return 1;
-
+		break;
 	case cop0_op:
 	case cop1_op:
 	case cop2_op:
 	case cop1x_op:
-		if (MIPSInst_RS(*i) == bc_op)
-			return 1;
+		if (insn.i_format.rs == bc_op) {
+			preempt_disable();
+			if (is_fpu_owner())
+				asm volatile("cfc1\t%0,$31" : "=r" (fcr31));
+			else
+				fcr31 = current->thread.fpu.fcr31;
+			preempt_enable();
+
+			bit = (insn.i_format.rt >> 2);
+			bit += (bit != 0);
+			bit += 23;
+			switch (insn.i_format.rt & 3) {
+			case 0: /* bc1f */
+			case 2: /* bc1fl */
+				if (~fcr31 & (1 << bit))
+					*contpc = regs->cp0_epc + dec_insn.pc_inc + (insn.i_format.simmediate << 2);
+				else
+					*contpc = regs->cp0_epc + dec_insn.pc_inc + dec_insn.next_pc_inc;
+				return 1;
+				break;
+			case 1: /* bc1t */
+			case 3: /* bc1tl */
+				if (fcr31 & (1 << bit))
+					*contpc = regs->cp0_epc + dec_insn.pc_inc + (insn.i_format.simmediate << 2);
+				else
+					*contpc = regs->cp0_epc + dec_insn.pc_inc + dec_insn.next_pc_inc;
+				return 1;
+				break;
+			}  /* end of inner switch-statement */
+		}
 		break;
 	}
-
 	return 0;
 }
 
@@ -209,26 +762,23 @@ static inline int cop1_64bit(struct pt_regs *xcp)
  */
 
 static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
-		       void *__user *fault_addr)
+		struct decoded_instn dec_insn, void *__user *fault_addr)
 {
 	mips_instruction ir;
-	unsigned long emulpc, contpc;
+	unsigned long contpc = xcp->cp0_epc + dec_insn.pc_inc;
 	unsigned int cond;
-
-	if (!access_ok(VERIFY_READ, xcp->cp0_epc, sizeof(mips_instruction))) {
-		MIPS_FPU_EMU_INC_STATS(errors);
-		*fault_addr = (mips_instruction __user *)xcp->cp0_epc;
-		return SIGBUS;
-	}
-	if (__get_user(ir, (mips_instruction __user *) xcp->cp0_epc)) {
-		MIPS_FPU_EMU_INC_STATS(errors);
-		*fault_addr = (mips_instruction __user *)xcp->cp0_epc;
-		return SIGSEGV;
-	}
+	int pc_inc;
 
 	/* XXX NEC Vr54xx bug workaround */
-	if ((xcp->cp0_cause & CAUSEF_BD) && !isBranchInstr(&ir))
-		xcp->cp0_cause &= ~CAUSEF_BD;
+	if (xcp->cp0_cause & CAUSEF_BD) {
+		if (dec_insn.micro_mips_mode) {
+			if (!mm_isBranchInstr(xcp, dec_insn, &contpc))
+				xcp->cp0_cause &= ~CAUSEF_BD;
+		} else {
+			if (!isBranchInstr(xcp, dec_insn, &contpc))
+				xcp->cp0_cause &= ~CAUSEF_BD;
+		}
+	}
 
 	if (xcp->cp0_cause & CAUSEF_BD) {
 		/*
@@ -243,32 +793,27 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 		 * Linux MIPS branch emulator operates on context, updating the
 		 * cp0_epc.
 		 */
-		emulpc = xcp->cp0_epc + 4;	/* Snapshot emulation target */
 
-		if (__compute_return_epc(xcp) < 0) {
-#ifdef CP1DBG
-			printk("failed to emulate branch at %p\n",
-				(void *) (xcp->cp0_epc));
-#endif
-			return SIGILL;
-		}
-		if (!access_ok(VERIFY_READ, emulpc, sizeof(mips_instruction))) {
-			MIPS_FPU_EMU_INC_STATS(errors);
-			*fault_addr = (mips_instruction __user *)emulpc;
-			return SIGBUS;
-		}
-		if (__get_user(ir, (mips_instruction __user *) emulpc)) {
-			MIPS_FPU_EMU_INC_STATS(errors);
-			*fault_addr = (mips_instruction __user *)emulpc;
-			return SIGSEGV;
-		}
-		/* __compute_return_epc() will have updated cp0_epc */
-		contpc = xcp->cp0_epc;
-		/* In order not to confuse ptrace() et al, tweak context */
-		xcp->cp0_epc = emulpc - 4;
+		/* NOTE: contpc is modified by isBranchInstr() if it is a branch instr */
+
+		ir = dec_insn.next_insn;  /* process delay slot instr */
+		pc_inc = dec_insn.next_pc_inc;
 	} else {
-		emulpc = xcp->cp0_epc;
-		contpc = xcp->cp0_epc + 4;
+		ir = dec_insn.insn;       /* process current instr */
+		pc_inc = dec_insn.pc_inc;
+	}
+
+	/* Since micro_mips FPU instructios are a subset of mips32 FPU instructions,   */
+	/* we want to convert micro_mips FPU instructions into mips32 instrunction so  */
+	/* that we could reuse all of the FPU emulation code.                          */
+	/* NOTE: we can't do this for branch instructions since they are not a subset  */
+	/*       ex: can't emulate a 16-bit aligned target address with a mips32 instn */
+	if (dec_insn.micro_mips_mode) {
+		/* if next instn is a 16-bit instn then it can't be FPU instn */
+		/* This could happen since this function can be called with non FPU instructions. */
+		if ((pc_inc == 2) ||
+			(micro_mips32_to_mips32((union mips_instruction *)&ir) == SIGILL))
+			return SIGILL;
 	}
 
       emul:
@@ -473,22 +1018,30 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 				/* branch taken: emulate dslot
 				 * instruction
 				 */
-				xcp->cp0_epc += 4;
-				contpc = (xcp->cp0_epc +
-					(MIPSInst_SIMM(ir) << 2));
-
-				if (!access_ok(VERIFY_READ, xcp->cp0_epc,
-					       sizeof(mips_instruction))) {
-					MIPS_FPU_EMU_INC_STATS(errors);
-					*fault_addr = (mips_instruction __user *)xcp->cp0_epc;
-					return SIGBUS;
-				}
-				if (__get_user(ir,
-				    (mips_instruction __user *) xcp->cp0_epc)) {
-					MIPS_FPU_EMU_INC_STATS(errors);
-					*fault_addr = (mips_instruction __user *)xcp->cp0_epc;
-					return SIGSEGV;
-				}
+				xcp->cp0_epc += dec_insn.pc_inc;
+
+				contpc = MIPSInst_SIMM(ir);
+				ir = dec_insn.next_insn;
+				if (dec_insn.micro_mips_mode) {
+					contpc = (xcp->cp0_epc + (contpc << 1));
+
+					/* if next instn is a 16-bit instn then it can't be FPU instn */
+					if ((dec_insn.next_pc_inc == 2) ||
+						(micro_mips32_to_mips32((union mips_instruction *)&ir) == SIGILL)) {
+
+						/* since this instn will be put on the stack with 32-bit words */
+						/* get around this problem by putting a NOP16 as the 2nd instn */
+						if (dec_insn.next_pc_inc == 2)
+							ir = (ir & (~0xffff)) | MM_NOP16;
+
+						/*
+						 * Single step the non-cp1
+						 * instruction in the dslot
+						 */
+						return mips_dsemul(xcp, ir, contpc);
+					}
+				} else
+					contpc = (xcp->cp0_epc + (contpc << 2));
 
 				switch (MIPSInst_OPCODE(ir)) {
 				case lwc1_op:
@@ -524,8 +1077,8 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 					 * branch likely nullifies
 					 * dslot if not taken
 					 */
-					xcp->cp0_epc += 4;
-					contpc += 4;
+					xcp->cp0_epc += dec_insn.pc_inc;
+					contpc += dec_insn.pc_inc;
 					/*
 					 * else continue & execute
 					 * dslot as normal insn
@@ -1312,25 +1865,58 @@ int fpu_emulator_cop1Handler(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 	int has_fpu, void *__user *fault_addr)
 {
 	unsigned long oldepc, prevepc;
-	mips_instruction insn;
+	struct decoded_instn dec_insn;
+	u16 instr[4];
+	u16 *instr_ptr;
 	int sig = 0;
 
 	oldepc = xcp->cp0_epc;
 	do {
 		prevepc = xcp->cp0_epc;
 
-		if (!access_ok(VERIFY_READ, xcp->cp0_epc, sizeof(mips_instruction))) {
-			MIPS_FPU_EMU_INC_STATS(errors);
-			*fault_addr = (mips_instruction __user *)xcp->cp0_epc;
-			return SIGBUS;
-		}
-		if (__get_user(insn, (mips_instruction __user *) xcp->cp0_epc)) {
-			MIPS_FPU_EMU_INC_STATS(errors);
-			*fault_addr = (mips_instruction __user *)xcp->cp0_epc;
-			return SIGSEGV;
+		if (is16mode(xcp) && cpu_has_mmips) {
+			/* get the next 2 micro_mips instn and decode them into 2 mips32 instn */
+			if ((get_user(instr[0], (u16 __user *)(xcp->cp0_epc & ~MIPS_ISA_MODE))) ||
+			    (get_user(instr[1], (u16 __user *)((xcp->cp0_epc+2) & ~MIPS_ISA_MODE))) ||
+			    (get_user(instr[2], (u16 __user *)((xcp->cp0_epc+4) & ~MIPS_ISA_MODE))) ||
+			    (get_user(instr[3], (u16 __user *)((xcp->cp0_epc+6) & ~MIPS_ISA_MODE)))) {
+				MIPS_FPU_EMU_INC_STATS(errors);
+				return SIGBUS;
+			}
+			instr_ptr = instr;
+			/* get 1st instruction */
+			if (mm_is16bit(*instr_ptr)) {
+				dec_insn.insn = (*instr_ptr << 16) | (*instr_ptr); /* duplicate the half-word */
+				dec_insn.pc_inc = 2;         /* 16 bit instr */
+				instr_ptr += 1;
+			} else {
+				dec_insn.insn = (*instr_ptr << 16) | *(instr_ptr+1);
+				dec_insn.pc_inc = 4;         /* 32 bit instr */
+				instr_ptr += 2;
+			}
+			/* get 2nd instruction */
+			if (mm_is16bit(*instr_ptr)) {
+				dec_insn.next_insn = (*instr_ptr << 16) | (*instr_ptr); /* duplicate the half-word */
+				dec_insn.next_pc_inc = 2;    /* 16 bit instr */
+			} else {
+				dec_insn.next_insn = (*instr_ptr << 16) | *(instr_ptr+1);
+				dec_insn.next_pc_inc = 4;    /* 32 bit instr */
+			}
+			dec_insn.micro_mips_mode = 1;
+		} else {
+			if ((get_user(dec_insn.insn, (mips_instruction __user *) xcp->cp0_epc)) ||
+				(get_user(dec_insn.next_insn, (mips_instruction __user *)(xcp->cp0_epc+4)))) {
+				MIPS_FPU_EMU_INC_STATS(errors);
+				return SIGBUS;
+			}
+			dec_insn.pc_inc = 4;
+			dec_insn.next_pc_inc = 4;
+			dec_insn.micro_mips_mode = 0;
 		}
-		if (insn == 0)
-			xcp->cp0_epc += 4;	/* skip nops */
+
+		if ((dec_insn.insn == 0) ||
+			((dec_insn.pc_inc == 2) && ((dec_insn.insn & 0xffff) == MM_NOP16)))
+			xcp->cp0_epc += dec_insn.pc_inc;	/* skip nops */
 		else {
 			/*
 			 * The 'ieee754_csr' is an alias of
@@ -1340,7 +1926,7 @@ int fpu_emulator_cop1Handler(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			 */
 			/* convert to ieee library modes */
 			ieee754_csr.rm = ieee_rm[ieee754_csr.rm];
-			sig = cop1Emulate(xcp, ctx, fault_addr);
+			sig = cop1Emulate(xcp, ctx, dec_insn, fault_addr);
 			/* revert to mips rounding mode */
 			ieee754_csr.rm = mips_rm[ieee754_csr.rm];
 		}
@@ -1358,6 +1944,8 @@ int fpu_emulator_cop1Handler(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 		/* but if epc has advanced, then ignore it */
 		sig = 0;
 
+	/*if (sig == SIGILL) printk("Illegal micro_mips FPU instruction: 0x%x, 0x%x\n", dec_insn.insn, dec_insn.next_insn);*/
+
 	return sig;
 }
 
diff --git a/arch/mips/math-emu/dsemul.c b/arch/mips/math-emu/dsemul.c
index 384a3b0..67bf6d5 100644
--- a/arch/mips/math-emu/dsemul.c
+++ b/arch/mips/math-emu/dsemul.c
@@ -54,8 +54,15 @@ int mips_dsemul(struct pt_regs *regs, mips_instruction ir, unsigned long cpc)
 	extern asmlinkage void handle_dsemulret(void);
 	struct emuframe __user *fr;
 	int err;
+	int nop = 0;
 
-	if (ir == 0) {		/* a nop is easy */
+	if (regs->cp0_epc & 1) {
+		if ((ir >> 16) == MM_NOP16)
+			nop = 1;
+	} else if (ir == 0)
+			nop = 1;
+
+	if (nop == 1) {		/* a nop is easy */
 		regs->cp0_epc = cpc;
 		regs->cp0_cause &= ~CAUSEF_BD;
 		return 0;
@@ -91,8 +98,17 @@ int mips_dsemul(struct pt_regs *regs, mips_instruction ir, unsigned long cpc)
 	if (unlikely(!access_ok(VERIFY_WRITE, fr, sizeof(struct emuframe))))
 		return SIGBUS;
 
-	err = __put_user(ir, &fr->emul);
-	err |= __put_user((mips_instruction)BREAK_MATH, &fr->badinst);
+	if (regs->cp0_epc & 1) {
+		err = __put_user(ir >> 16, (u16 __user *)(&fr->emul));
+		err |= __put_user(ir & 0xffff, (u16 __user *)((long)(&fr->emul) + 2));
+		err |= __put_user(MM_BREAK_MATH >> 16, (u16 __user *)(&fr->badinst));
+		err |= __put_user(MM_BREAK_MATH & 0xffff, (u16 __user *)((long)(&fr->badinst) + 2));
+	} else {
+		err = __put_user(ir, &fr->emul);
+		err |= __put_user((mips_instruction)BREAK_MATH, &fr->badinst);
+	}
+
+	/* NOTE: assume the 2nd instn is never executed => can leave as mips32 instr */
 	err |= __put_user((mips_instruction)BD_COOKIE, &fr->cookie);
 	err |= __put_user(cpc, &fr->epc);
 
@@ -101,7 +117,7 @@ int mips_dsemul(struct pt_regs *regs, mips_instruction ir, unsigned long cpc)
 		return SIGBUS;
 	}
 
-	regs->cp0_epc = (unsigned long) &fr->emul;
+	regs->cp0_epc = ((unsigned long) &fr->emul) | (regs->cp0_epc & 1);
 
 	flush_cache_sigtramp((unsigned long)&fr->badinst);
 
@@ -114,9 +130,14 @@ int do_dsemulret(struct pt_regs *xcp)
 	unsigned long epc;
 	u32 insn, cookie;
 	int err = 0;
+	u32 break_math = BREAK_MATH;
+	u16 instr[2];
+
+	if (xcp->cp0_epc & 1)
+		break_math = MM_BREAK_MATH;
 
 	fr = (struct emuframe __user *)
-		(xcp->cp0_epc - sizeof(mips_instruction));
+		((xcp->cp0_epc & (~1)) - sizeof(mips_instruction));
 
 	/*
 	 * If we can't even access the area, something is very wrong, but we'll
@@ -131,10 +152,15 @@ int do_dsemulret(struct pt_regs *xcp)
 	 *  - Is the instruction pointed to by the EPC an BREAK_MATH?
 	 *  - Is the following memory word the BD_COOKIE?
 	 */
-	err = __get_user(insn, &fr->badinst);
+	if (xcp->cp0_epc & 1) {
+		err = __get_user(instr[0], (u16 __user *)(&fr->badinst));
+		err |= __get_user(instr[1], (u16 __user *)((long)(&fr->badinst) + 2));
+		insn = (instr[0] << 16) | instr[1];
+	} else
+		err = __get_user(insn, &fr->badinst);
 	err |= __get_user(cookie, &fr->cookie);
 
-	if (unlikely(err || (insn != BREAK_MATH) || (cookie != BD_COOKIE))) {
+	if (unlikely(err || (insn != break_math) || (cookie != BD_COOKIE))) {
 		MIPS_FPU_EMU_INC_STATS(errors);
 		return 0;
 	}
-- 
1.7.9.6
