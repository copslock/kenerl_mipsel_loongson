Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2015 12:06:23 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:50053 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010951AbbAPKxiAdra1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jan 2015 11:53:38 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id F0328664CC4EB
        for <linux-mips@linux-mips.org>; Fri, 16 Jan 2015 10:53:34 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 16 Jan 2015 10:53:37 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.96) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Fri, 16 Jan 2015 10:53:36 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH RFC v2 54/70] =?UTF-8?q?MIPS:=20Emulate=20the=20new=20MIPS?= =?UTF-8?q?=20R6=20B{L,G}=CE=95{Z,}{AL,}C=20instructions?=
Date:   Fri, 16 Jan 2015 10:49:33 +0000
Message-ID: <1421405389-15512-55-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45196
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

MIPS R6 added the following four instructions which share the
BLEZ and BLEZL opcodes:

BLEZALC: Compact branch-and-link if GPR rt is <= to zero
BGEZALC: Compact branch-and-link if GPR rt is >= to zero
BLEZC  : Compact branch if GPR rt is <= to zero
BGEZC  : Compact branch if GPR rt is >= to zero
BGEC   : Compact branch if GPR rs is less than or equal to GPR rt
BGEUC  : Similar to BGEC but unsigned.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/branch.c   | 31 +++++++++++++++++++++++++++++++
 arch/mips/math-emu/cp1emu.c | 23 +++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
index 41dcf5a45ec2..174d2f74f28c 100644
--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -399,6 +399,16 @@ int __MIPS16e_compute_return_epc(struct pt_regs *regs)
  * @returns:	-EFAULT on error and forces SIGBUS, and on success
  *		returns 0 or BRANCH_LIKELY_TAKEN as appropriate after
  *		evaluating the branch.
+ *
+ * MIPS R6 Compact branches and forbidden slots:
+ *	Compact branches do not throw exceptions because they do
+ *	not have delay slots. The forbidden slot instruction ($PC+4)
+ *	is only executed if the branch was not taken. Otherwise the
+ *	forbidden slot is skipped entirely. This means that the
+ *	only possible reason to be here because of a MIPS R6 compact
+ *	branch instruction is that the forbidden slot has thrown one.
+ *	In that case the branch was not taken, so the EPC can be safely
+ *	set to EPC + 8.
  */
 int __compute_return_epc_for_insn(struct pt_regs *regs,
 				   union mips_instruction insn)
@@ -606,6 +616,27 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
 			ret = -SIGILL;
 			break;
 		}
+		/*
+		 * Compact branches for R6 for the
+		 * blez and blezl opcodes.
+		 * BLEZ  | rs = 0 | rt != 0  == BLEZALC
+		 * BLEZ  | rs = rt != 0      == BGEZALC
+		 * BLEZ  | rs != 0 | rt != 0 == BGEUC
+		 * BLEZL | rs = 0 | rt != 0  == BLEZC
+		 * BLEZL | rs = rt != 0      == BGEZC
+		 * BLEZL | rs != 0 | rt != 0 == BGEC
+		 *
+		 * For real BLEZ{,L}, rt is always 0.
+		 */
+
+		if (cpu_has_mips_r6 && insn.i_format.rt) {
+			if ((insn.i_format.opcode == blez_op) &&
+			    ((!insn.i_format.rs && insn.i_format.rt) ||
+			     (insn.i_format.rs == insn.i_format.rt)))
+				regs->regs[31] = epc + 4;
+			regs->cp0_epc += 8;
+			break;
+		}
 		/* rt field assumed to be zero */
 		if ((long)regs->regs[insn.i_format.rs] <= 0) {
 			epc = epc + 4 + (insn.i_format.simmediate << 2);
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 433e9ebdc35a..0697bab067c0 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -555,6 +555,29 @@ static int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 		if (NO_R6EMU && (insn.i_format.opcode == blezl_op))
 			break;
 
+		/*
+		 * Compact branches for R6 for the
+		 * blez and blezl opcodes.
+		 * BLEZ  | rs = 0 | rt != 0  == BLEZALC
+		 * BLEZ  | rs = rt != 0      == BGEZALC
+		 * BLEZ  | rs != 0 | rt != 0 == BGEUC
+		 * BLEZL | rs = 0 | rt != 0  == BLEZC
+		 * BLEZL | rs = rt != 0      == BGEZC
+		 * BLEZL | rs != 0 | rt != 0 == BGEC
+		 *
+		 * For real BLEZ{,L}, rt is always 0.
+		 */
+		if (cpu_has_mips_r6 && insn.i_format.rt) {
+			if ((insn.i_format.opcode == blez_op) &&
+			    ((!insn.i_format.rs && insn.i_format.rt) ||
+			     (insn.i_format.rs == insn.i_format.rt)))
+				regs->regs[31] = regs->cp0_epc +
+					dec_insn.pc_inc;
+			*contpc = regs->cp0_epc + dec_insn.pc_inc +
+				dec_insn.next_pc_inc;
+
+			return 1;
+		}
 		if ((long)regs->regs[insn.i_format.rs] <= 0)
 			*contpc = regs->cp0_epc +
 				dec_insn.pc_inc +
-- 
2.2.1
