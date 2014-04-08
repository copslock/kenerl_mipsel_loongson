Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Apr 2014 12:54:17 +0200 (CEST)
Received: from mail-ee0-f52.google.com ([74.125.83.52]:33313 "EHLO
        mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816019AbaDHKyODe-8C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Apr 2014 12:54:14 +0200
Received: by mail-ee0-f52.google.com with SMTP id e49so530867eek.11
        for <linux-mips@linux-mips.org>; Tue, 08 Apr 2014 03:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=z2KI2qAWMdiTwXXS+pIQYY8+tZxpBKshYyNoiN1I3UA=;
        b=jQivxi6uz5CWPOEg+ljt5QAC8LnaDnn7FWbSCBmdoPqL7U0x57rn+7HCLebyPjCLMA
         TVIpatQzerde5iveW7JMWVSv1+KABztrxxSytR4kBHMLQPX47lcTnOmOVeJwhmO8IHEO
         bPc1kWq8MMUH+FxQ75FXFWc4DuExcu2M0AyFZpzFM0KgibSGsYSCC3px8eqE2XPaHCN2
         hzUXs4MOSQL52QVKmtVabs41KPtsSsgQqBN7VUTuhGZ1aI7uX8fs6Jh943Bn7XE4eLRE
         u16l6jE2a+klVVESVN3svz5hR4Up9CGbnxI4KtJNQDiRvqAOxrWYqjDeThMl/8HkN42s
         eWmg==
X-Received: by 10.14.87.201 with SMTP id y49mr2350189eee.62.1396954448530;
        Tue, 08 Apr 2014 03:54:08 -0700 (PDT)
Received: from localhost.localdomain (p4FD8D7E8.dip0.t-ipconnect.de. [79.216.215.232])
        by mx.google.com with ESMTPSA id w12sm3860178eez.36.2014.04.08.03.54.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Apr 2014 03:54:07 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH v6 1/2] MIPS: move mmips branch support code out of the fpu emu code
Date:   Tue,  8 Apr 2014 12:54:03 +0200
Message-Id: <1396954444-392675-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39696
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

moves mm_isBranchInstr() from math-emu code to branch code.  Required
for a follow-on patch to disable the math-emu code completely.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
v4/5/6: initial release, no changes

 arch/mips/include/asm/branch.h       |   2 +
 arch/mips/include/asm/fpu_emulator.h |   2 -
 arch/mips/kernel/branch.c            | 200 +++++++++++++++++++++++++++++++++++
 arch/mips/math-emu/cp1emu.c          | 198 ----------------------------------
 4 files changed, 202 insertions(+), 200 deletions(-)

diff --git a/arch/mips/include/asm/branch.h b/arch/mips/include/asm/branch.h
index e28a3e0..1c6b5c2 100644
--- a/arch/mips/include/asm/branch.h
+++ b/arch/mips/include/asm/branch.h
@@ -17,6 +17,8 @@ extern int __compute_return_epc_for_insn(struct pt_regs *regs,
 					 union mips_instruction insn);
 extern int __microMIPS_compute_return_epc(struct pt_regs *regs);
 extern int __MIPS16e_compute_return_epc(struct pt_regs *regs);
+int mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
+		     unsigned long *contpc);
 
 
 static inline int delay_slot(struct pt_regs *regs)
diff --git a/arch/mips/include/asm/fpu_emulator.h b/arch/mips/include/asm/fpu_emulator.h
index 2abb587..283e6f3 100644
--- a/arch/mips/include/asm/fpu_emulator.h
+++ b/arch/mips/include/asm/fpu_emulator.h
@@ -58,8 +58,6 @@ extern int fpu_emulator_cop1Handler(struct pt_regs *xcp,
 				    struct mips_fpu_struct *ctx, int has_fpu,
 				    void *__user *fault_addr);
 int process_fpemu_return(int sig, void __user *fault_addr);
-int mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
-		     unsigned long *contpc);
 
 /*
  * Instruction inserted following the badinst to further tag the sequence
diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
index 4d78bf4..47eadf0 100644
--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -19,6 +19,13 @@
 #include <asm/ptrace.h>
 #include <asm/uaccess.h>
 
+/* microMIPS bitfields */
+#define MM_POOL32A_MINOR_MASK	0x3f
+#define MM_POOL32A_MINOR_SHIFT	0x6
+
+/* (microMIPS) Convert 16-bit register encoding to 32-bit register encoding. */
+static const unsigned int reg16to32map[8] = {16, 17, 2, 3, 4, 5, 6, 7};
+
 /*
  * Calculate and return exception PC in case of branch delay slot
  * for microMIPS and MIPS16e. It does not clear the ISA mode bit.
@@ -48,6 +55,199 @@ int __isa_exception_epc(struct pt_regs *regs)
 	return epc;
 }
 
+int mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
+		     unsigned long *contpc)
+{
+	union mips_instruction insn = (union mips_instruction)dec_insn.insn;
+	int bc_false = 0;
+	unsigned int fcr31;
+	unsigned int bit;
+
+	if (!cpu_has_mmips)
+		return 0;
+
+	switch (insn.mm_i_format.opcode) {
+	case mm_pool32a_op:
+		if ((insn.mm_i_format.simmediate & MM_POOL32A_MINOR_MASK) ==
+		    mm_pool32axf_op) {
+			switch (insn.mm_i_format.simmediate >>
+				MM_POOL32A_MINOR_SHIFT) {
+			case mm_jalr_op:
+			case mm_jalrhb_op:
+			case mm_jalrs_op:
+			case mm_jalrshb_op:
+				if (insn.mm_i_format.rt != 0)	/* Not mm_jr */
+					regs->regs[insn.mm_i_format.rt] =
+						regs->cp0_epc +
+						dec_insn.pc_inc +
+						dec_insn.next_pc_inc;
+				*contpc = regs->regs[insn.mm_i_format.rs];
+				return 1;
+			}
+		}
+		break;
+	case mm_pool32i_op:
+		switch (insn.mm_i_format.rt) {
+		case mm_bltzals_op:
+		case mm_bltzal_op:
+			regs->regs[31] = regs->cp0_epc +
+				dec_insn.pc_inc +
+				dec_insn.next_pc_inc;
+			/* Fall through */
+		case mm_bltz_op:
+			if ((long)regs->regs[insn.mm_i_format.rs] < 0)
+				*contpc = regs->cp0_epc +
+					dec_insn.pc_inc +
+					(insn.mm_i_format.simmediate << 1);
+			else
+				*contpc = regs->cp0_epc +
+					dec_insn.pc_inc +
+					dec_insn.next_pc_inc;
+			return 1;
+		case mm_bgezals_op:
+		case mm_bgezal_op:
+			regs->regs[31] = regs->cp0_epc +
+					dec_insn.pc_inc +
+					dec_insn.next_pc_inc;
+			/* Fall through */
+		case mm_bgez_op:
+			if ((long)regs->regs[insn.mm_i_format.rs] >= 0)
+				*contpc = regs->cp0_epc +
+					dec_insn.pc_inc +
+					(insn.mm_i_format.simmediate << 1);
+			else
+				*contpc = regs->cp0_epc +
+					dec_insn.pc_inc +
+					dec_insn.next_pc_inc;
+			return 1;
+		case mm_blez_op:
+			if ((long)regs->regs[insn.mm_i_format.rs] <= 0)
+				*contpc = regs->cp0_epc +
+					dec_insn.pc_inc +
+					(insn.mm_i_format.simmediate << 1);
+			else
+				*contpc = regs->cp0_epc +
+					dec_insn.pc_inc +
+					dec_insn.next_pc_inc;
+			return 1;
+		case mm_bgtz_op:
+			if ((long)regs->regs[insn.mm_i_format.rs] <= 0)
+				*contpc = regs->cp0_epc +
+					dec_insn.pc_inc +
+					(insn.mm_i_format.simmediate << 1);
+			else
+				*contpc = regs->cp0_epc +
+					dec_insn.pc_inc +
+					dec_insn.next_pc_inc;
+			return 1;
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
+				*contpc = regs->cp0_epc +
+					dec_insn.pc_inc +
+					(insn.mm_i_format.simmediate << 1);
+			else
+				*contpc = regs->cp0_epc +
+					dec_insn.pc_inc + dec_insn.next_pc_inc;
+			return 1;
+		}
+		break;
+	case mm_pool16c_op:
+		switch (insn.mm_i_format.rt) {
+		case mm_jalr16_op:
+		case mm_jalrs16_op:
+			regs->regs[31] = regs->cp0_epc +
+				dec_insn.pc_inc + dec_insn.next_pc_inc;
+			/* Fall through */
+		case mm_jr16_op:
+			*contpc = regs->regs[insn.mm_i_format.rs];
+			return 1;
+		}
+		break;
+	case mm_beqz16_op:
+		if ((long)regs->regs[reg16to32map[insn.mm_b1_format.rs]] == 0)
+			*contpc = regs->cp0_epc +
+				dec_insn.pc_inc +
+				(insn.mm_b1_format.simmediate << 1);
+		else
+			*contpc = regs->cp0_epc +
+				dec_insn.pc_inc + dec_insn.next_pc_inc;
+		return 1;
+	case mm_bnez16_op:
+		if ((long)regs->regs[reg16to32map[insn.mm_b1_format.rs]] != 0)
+			*contpc = regs->cp0_epc +
+				dec_insn.pc_inc +
+				(insn.mm_b1_format.simmediate << 1);
+		else
+			*contpc = regs->cp0_epc +
+				dec_insn.pc_inc + dec_insn.next_pc_inc;
+		return 1;
+	case mm_b16_op:
+		*contpc = regs->cp0_epc + dec_insn.pc_inc +
+			 (insn.mm_b0_format.simmediate << 1);
+		return 1;
+	case mm_beq32_op:
+		if (regs->regs[insn.mm_i_format.rs] ==
+		    regs->regs[insn.mm_i_format.rt])
+			*contpc = regs->cp0_epc +
+				dec_insn.pc_inc +
+				(insn.mm_i_format.simmediate << 1);
+		else
+			*contpc = regs->cp0_epc +
+				dec_insn.pc_inc +
+				dec_insn.next_pc_inc;
+		return 1;
+	case mm_bne32_op:
+		if (regs->regs[insn.mm_i_format.rs] !=
+		    regs->regs[insn.mm_i_format.rt])
+			*contpc = regs->cp0_epc +
+				dec_insn.pc_inc +
+				(insn.mm_i_format.simmediate << 1);
+		else
+			*contpc = regs->cp0_epc +
+				dec_insn.pc_inc + dec_insn.next_pc_inc;
+		return 1;
+	case mm_jalx32_op:
+		regs->regs[31] = regs->cp0_epc +
+			dec_insn.pc_inc + dec_insn.next_pc_inc;
+		*contpc = regs->cp0_epc + dec_insn.pc_inc;
+		*contpc >>= 28;
+		*contpc <<= 28;
+		*contpc |= (insn.j_format.target << 2);
+		return 1;
+	case mm_jals32_op:
+	case mm_jal32_op:
+		regs->regs[31] = regs->cp0_epc +
+			dec_insn.pc_inc + dec_insn.next_pc_inc;
+		/* Fall through */
+	case mm_j32_op:
+		*contpc = regs->cp0_epc + dec_insn.pc_inc;
+		*contpc >>= 27;
+		*contpc <<= 27;
+		*contpc |= (insn.j_format.target << 1);
+		set_isa16_mode(*contpc);
+		return 1;
+	}
+	return 0;
+}
+
 /*
  * Compute return address and emulate branch in microMIPS mode after an
  * exception only. It does not handle compact branches/jumps and cannot
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 7b3c9ac..8f36146 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -83,8 +83,6 @@ DEFINE_PER_CPU(struct mips_fpu_emulator_stats, fpuemustats);
 #define modeindex(v) ((v) & FPU_CSR_RM)
 
 /* microMIPS bitfields */
-#define MM_POOL32A_MINOR_MASK	0x3f
-#define MM_POOL32A_MINOR_SHIFT	0x6
 #define MM_MIPS32_COND_FC	0x30
 
 /* Convert Mips rounding mode (0..3) to IEEE library modes. */
@@ -116,9 +114,6 @@ static const unsigned int fpucondbit[8] = {
 };
 #endif
 
-/* (microMIPS) Convert 16-bit register encoding to 32-bit register encoding. */
-static const unsigned int reg16to32map[8] = {16, 17, 2, 3, 4, 5, 6, 7};
-
 /* (microMIPS) Convert certain microMIPS instructions to MIPS32 format. */
 static const int sd_format[] = {16, 17, 0, 0, 0, 0, 0, 0};
 static const int sdps_format[] = {16, 17, 22, 0, 0, 0, 0, 0};
@@ -466,199 +461,6 @@ static int microMIPS32_to_MIPS32(union mips_instruction *insn_ptr)
 	return 0;
 }
 
-int mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
-		     unsigned long *contpc)
-{
-	union mips_instruction insn = (union mips_instruction)dec_insn.insn;
-	int bc_false = 0;
-	unsigned int fcr31;
-	unsigned int bit;
-
-	if (!cpu_has_mmips)
-		return 0;
-
-	switch (insn.mm_i_format.opcode) {
-	case mm_pool32a_op:
-		if ((insn.mm_i_format.simmediate & MM_POOL32A_MINOR_MASK) ==
-		    mm_pool32axf_op) {
-			switch (insn.mm_i_format.simmediate >>
-				MM_POOL32A_MINOR_SHIFT) {
-			case mm_jalr_op:
-			case mm_jalrhb_op:
-			case mm_jalrs_op:
-			case mm_jalrshb_op:
-				if (insn.mm_i_format.rt != 0)	/* Not mm_jr */
-					regs->regs[insn.mm_i_format.rt] =
-						regs->cp0_epc +
-						dec_insn.pc_inc +
-						dec_insn.next_pc_inc;
-				*contpc = regs->regs[insn.mm_i_format.rs];
-				return 1;
-			}
-		}
-		break;
-	case mm_pool32i_op:
-		switch (insn.mm_i_format.rt) {
-		case mm_bltzals_op:
-		case mm_bltzal_op:
-			regs->regs[31] = regs->cp0_epc +
-				dec_insn.pc_inc +
-				dec_insn.next_pc_inc;
-			/* Fall through */
-		case mm_bltz_op:
-			if ((long)regs->regs[insn.mm_i_format.rs] < 0)
-				*contpc = regs->cp0_epc +
-					dec_insn.pc_inc +
-					(insn.mm_i_format.simmediate << 1);
-			else
-				*contpc = regs->cp0_epc +
-					dec_insn.pc_inc +
-					dec_insn.next_pc_inc;
-			return 1;
-		case mm_bgezals_op:
-		case mm_bgezal_op:
-			regs->regs[31] = regs->cp0_epc +
-					dec_insn.pc_inc +
-					dec_insn.next_pc_inc;
-			/* Fall through */
-		case mm_bgez_op:
-			if ((long)regs->regs[insn.mm_i_format.rs] >= 0)
-				*contpc = regs->cp0_epc +
-					dec_insn.pc_inc +
-					(insn.mm_i_format.simmediate << 1);
-			else
-				*contpc = regs->cp0_epc +
-					dec_insn.pc_inc +
-					dec_insn.next_pc_inc;
-			return 1;
-		case mm_blez_op:
-			if ((long)regs->regs[insn.mm_i_format.rs] <= 0)
-				*contpc = regs->cp0_epc +
-					dec_insn.pc_inc +
-					(insn.mm_i_format.simmediate << 1);
-			else
-				*contpc = regs->cp0_epc +
-					dec_insn.pc_inc +
-					dec_insn.next_pc_inc;
-			return 1;
-		case mm_bgtz_op:
-			if ((long)regs->regs[insn.mm_i_format.rs] <= 0)
-				*contpc = regs->cp0_epc +
-					dec_insn.pc_inc +
-					(insn.mm_i_format.simmediate << 1);
-			else
-				*contpc = regs->cp0_epc +
-					dec_insn.pc_inc +
-					dec_insn.next_pc_inc;
-			return 1;
-		case mm_bc2f_op:
-		case mm_bc1f_op:
-			bc_false = 1;
-			/* Fall through */
-		case mm_bc2t_op:
-		case mm_bc1t_op:
-			preempt_disable();
-			if (is_fpu_owner())
-				asm volatile("cfc1\t%0,$31" : "=r" (fcr31));
-			else
-				fcr31 = current->thread.fpu.fcr31;
-			preempt_enable();
-
-			if (bc_false)
-				fcr31 = ~fcr31;
-
-			bit = (insn.mm_i_format.rs >> 2);
-			bit += (bit != 0);
-			bit += 23;
-			if (fcr31 & (1 << bit))
-				*contpc = regs->cp0_epc +
-					dec_insn.pc_inc +
-					(insn.mm_i_format.simmediate << 1);
-			else
-				*contpc = regs->cp0_epc +
-					dec_insn.pc_inc + dec_insn.next_pc_inc;
-			return 1;
-		}
-		break;
-	case mm_pool16c_op:
-		switch (insn.mm_i_format.rt) {
-		case mm_jalr16_op:
-		case mm_jalrs16_op:
-			regs->regs[31] = regs->cp0_epc +
-				dec_insn.pc_inc + dec_insn.next_pc_inc;
-			/* Fall through */
-		case mm_jr16_op:
-			*contpc = regs->regs[insn.mm_i_format.rs];
-			return 1;
-		}
-		break;
-	case mm_beqz16_op:
-		if ((long)regs->regs[reg16to32map[insn.mm_b1_format.rs]] == 0)
-			*contpc = regs->cp0_epc +
-				dec_insn.pc_inc +
-				(insn.mm_b1_format.simmediate << 1);
-		else
-			*contpc = regs->cp0_epc +
-				dec_insn.pc_inc + dec_insn.next_pc_inc;
-		return 1;
-	case mm_bnez16_op:
-		if ((long)regs->regs[reg16to32map[insn.mm_b1_format.rs]] != 0)
-			*contpc = regs->cp0_epc +
-				dec_insn.pc_inc +
-				(insn.mm_b1_format.simmediate << 1);
-		else
-			*contpc = regs->cp0_epc +
-				dec_insn.pc_inc + dec_insn.next_pc_inc;
-		return 1;
-	case mm_b16_op:
-		*contpc = regs->cp0_epc + dec_insn.pc_inc +
-			 (insn.mm_b0_format.simmediate << 1);
-		return 1;
-	case mm_beq32_op:
-		if (regs->regs[insn.mm_i_format.rs] ==
-		    regs->regs[insn.mm_i_format.rt])
-			*contpc = regs->cp0_epc +
-				dec_insn.pc_inc +
-				(insn.mm_i_format.simmediate << 1);
-		else
-			*contpc = regs->cp0_epc +
-				dec_insn.pc_inc +
-				dec_insn.next_pc_inc;
-		return 1;
-	case mm_bne32_op:
-		if (regs->regs[insn.mm_i_format.rs] !=
-		    regs->regs[insn.mm_i_format.rt])
-			*contpc = regs->cp0_epc +
-				dec_insn.pc_inc +
-				(insn.mm_i_format.simmediate << 1);
-		else
-			*contpc = regs->cp0_epc +
-				dec_insn.pc_inc + dec_insn.next_pc_inc;
-		return 1;
-	case mm_jalx32_op:
-		regs->regs[31] = regs->cp0_epc +
-			dec_insn.pc_inc + dec_insn.next_pc_inc;
-		*contpc = regs->cp0_epc + dec_insn.pc_inc;
-		*contpc >>= 28;
-		*contpc <<= 28;
-		*contpc |= (insn.j_format.target << 2);
-		return 1;
-	case mm_jals32_op:
-	case mm_jal32_op:
-		regs->regs[31] = regs->cp0_epc +
-			dec_insn.pc_inc + dec_insn.next_pc_inc;
-		/* Fall through */
-	case mm_j32_op:
-		*contpc = regs->cp0_epc + dec_insn.pc_inc;
-		*contpc >>= 27;
-		*contpc <<= 27;
-		*contpc |= (insn.j_format.target << 1);
-		set_isa16_mode(*contpc);
-		return 1;
-	}
-	return 0;
-}
-
 /*
  * Redundant with logic already in kernel/branch.c,
  * embedded in compute_return_epc.  At some point,
-- 
1.9.1
