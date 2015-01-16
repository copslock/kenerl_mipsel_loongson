Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2015 12:06:59 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:51888 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010954AbbAPKxmPeq46 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jan 2015 11:53:42 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id EAA1F94945656
        for <linux-mips@linux-mips.org>; Fri, 16 Jan 2015 10:53:33 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 16 Jan 2015 10:53:35 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.96) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Fri, 16 Jan 2015 10:53:35 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH RFC v2 53/70] MIPS: Emulate the BC1{EQ,NE}Z FPU instructions
Date:   Fri, 16 Jan 2015 10:49:32 +0000
Message-ID: <1421405389-15512-54-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45198
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

MIPS R6 introduced the following two branch instructions for COP1:

BC1EQZ: Branch if Cop1 (FPR) Register Bit 0 is Equal to Zero
BC1NEZ: Branch if Cop1 (FPR) Register Bit 0 is Not Equal to Zero

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/uapi/asm/inst.h |   3 +-
 arch/mips/kernel/branch.c         | 101 +++++++++++++++++++++++++++-----------
 arch/mips/math-emu/cp1emu.c       |  27 ++++++++++
 3 files changed, 101 insertions(+), 30 deletions(-)

diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
index 5c9e14a903af..19d3bc1e6510 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -115,7 +115,8 @@ enum cop_op {
 	mfhc_op       = 0x03, mtc_op	    = 0x04,
 	dmtc_op	      = 0x05, ctc_op	    = 0x06,
 	mthc0_op      = 0x06, mthc_op	    = 0x07,
-	bc_op	      = 0x08, cop_op	    = 0x10,
+	bc_op	      = 0x08, bc1eqz_op     = 0x09,
+	bc1nez_op     = 0x0d, cop_op	    = 0x10,
 	copm_op	      = 0x18
 };
 
diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
index fdc6316877c7..41dcf5a45ec2 100644
--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -403,7 +403,7 @@ int __MIPS16e_compute_return_epc(struct pt_regs *regs)
 int __compute_return_epc_for_insn(struct pt_regs *regs,
 				   union mips_instruction insn)
 {
-	unsigned int bit, fcr31, dspcontrol;
+	unsigned int bit, fcr31, dspcontrol, reg;
 	long epc = regs->cp0_epc;
 	int ret = 0;
 
@@ -637,40 +637,83 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
 	 * And now the FPA/cp1 branch instructions.
 	 */
 	case cop1_op:
-		preempt_disable();
-		if (is_fpu_owner())
-		        fcr31 = read_32bit_cp1_register(CP1_STATUS);
-		else
-			fcr31 = current->thread.fpu.fcr31;
-		preempt_enable();
-
-		bit = (insn.i_format.rt >> 2);
-		bit += (bit != 0);
-		bit += 23;
-		switch (insn.i_format.rt & 3) {
-		case 0: /* bc1f */
-		case 2: /* bc1fl */
-			if (~fcr31 & (1 << bit)) {
-				epc = epc + 4 + (insn.i_format.simmediate << 2);
-				if (insn.i_format.rt == 2)
-					ret = BRANCH_LIKELY_TAKEN;
-			} else
+		if (cpu_has_mips_r6 &&
+		    ((insn.i_format.rs == bc1eqz_op) ||
+		     (insn.i_format.rs == bc1nez_op))) {
+			if (!used_math()) { /* First time FPU user */
+				ret = init_fpu();
+				if (ret && NO_R6EMU) {
+					ret = -ret;
+					break;
+				}
+				ret = 0;
+				set_used_math();
+			}
+			lose_fpu(1);    /* Save FPU state for the emulator. */
+			reg = insn.i_format.rt;
+			bit = 0;
+			switch (insn.i_format.rs) {
+			case bc1eqz_op:
+				/* Test bit 0 */
+				if (get_fpr32(&current->thread.fpu.fpr[reg], 0)
+				    & 0x1)
+					bit = 1;
+				break;
+			case bc1nez_op:
+				/* Test bit 0 */
+				if (!(get_fpr32(&current->thread.fpu.fpr[reg], 0)
+				      & 0x1))
+					bit = 1;
+				break;
+			}
+			own_fpu(1);
+			if (bit)
+				epc = epc + 4 +
+					(insn.i_format.simmediate << 2);
+			else
 				epc += 8;
 			regs->cp0_epc = epc;
+
 			break;
+		} else {
 
-		case 1: /* bc1t */
-		case 3: /* bc1tl */
-			if (fcr31 & (1 << bit)) {
-				epc = epc + 4 + (insn.i_format.simmediate << 2);
-				if (insn.i_format.rt == 3)
-					ret = BRANCH_LIKELY_TAKEN;
-			} else
-				epc += 8;
-			regs->cp0_epc = epc;
+			preempt_disable();
+			if (is_fpu_owner())
+			        fcr31 = read_32bit_cp1_register(CP1_STATUS);
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
+				if (~fcr31 & (1 << bit)) {
+					epc = epc + 4 +
+						(insn.i_format.simmediate << 2);
+					if (insn.i_format.rt == 2)
+						ret = BRANCH_LIKELY_TAKEN;
+				} else
+					epc += 8;
+				regs->cp0_epc = epc;
+				break;
+
+			case 1: /* bc1t */
+			case 3: /* bc1tl */
+				if (fcr31 & (1 << bit)) {
+					epc = epc + 4 +
+						(insn.i_format.simmediate << 2);
+					if (insn.i_format.rt == 3)
+						ret = BRANCH_LIKELY_TAKEN;
+				} else
+					epc += 8;
+				regs->cp0_epc = epc;
+				break;
+			}
 			break;
 		}
-		break;
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
 	case lwc2_op: /* This is bbit0 on Octeon */
 		if ((regs->regs[insn.i_format.rs] & (1ull<<insn.i_format.rt))
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 472acb1dc3dd..433e9ebdc35a 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -606,6 +606,33 @@ static int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 #endif
 	case cop0_op:
 	case cop1_op:
+		/* Need to check for R6 bc1nez and bc1eqz branches */
+		if (cpu_has_mips_r6 &&
+		    ((insn.i_format.rs == bc1eqz_op) ||
+		     (insn.i_format.rs == bc1nez_op))) {
+			bit = 0;
+			switch (insn.i_format.rs) {
+			case bc1eqz_op:
+				if (get_fpr32(&current->thread.fpu.fpr[insn.i_format.rt], 0) & 0x1)
+				    bit = 1;
+				break;
+			case bc1nez_op:
+				if (!(get_fpr32(&current->thread.fpu.fpr[insn.i_format.rt], 0) & 0x1))
+				    bit = 1;
+				break;
+			}
+			if (bit)
+				*contpc = regs->cp0_epc +
+					dec_insn.pc_inc +
+					(insn.i_format.simmediate << 2);
+			else
+				*contpc = regs->cp0_epc +
+					dec_insn.pc_inc +
+					dec_insn.next_pc_inc;
+
+			return 1;
+		}
+		/* R2/R6 compatible cop1 instruction. Fall through */
 	case cop2_op:
 	case cop1x_op:
 		if (insn.i_format.rs == bc_op) {
-- 
2.2.1
