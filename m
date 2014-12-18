Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 16:26:11 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:14128 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009204AbaLRPNSD2l69 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 16:13:18 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 59D4A7FAC9D
        for <linux-mips@linux-mips.org>; Thu, 18 Dec 2014 15:13:09 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 18 Dec 2014 15:13:12 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.125) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 18 Dec 2014 15:13:11 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH RFC 52/67] MIPS: kernel: branch: Add support for the BC1{EQ,NE}Z FPU branches
Date:   Thu, 18 Dec 2014 15:10:01 +0000
Message-ID: <1418915416-3196-53-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com>
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.125]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44787
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
 arch/mips/kernel/branch.c | 100 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 71 insertions(+), 29 deletions(-)

diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
index a6f7af2aa6ee..e6d78ab52aa7 100644
--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -406,7 +406,7 @@ int __MIPS16e_compute_return_epc(struct pt_regs *regs)
 int __compute_return_epc_for_insn(struct pt_regs *regs,
 				   union mips_instruction insn)
 {
-	unsigned int bit, fcr31, dspcontrol;
+	unsigned int bit, fcr31, dspcontrol, reg;
 	long epc = regs->cp0_epc;
 	int ret = 0;
 
@@ -640,40 +640,82 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
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
+		if ((insn.i_format.rs == bc1eqz_op && cpu_has_mips_r6) ||
+		    (insn.i_format.rs == bc1nez_op && cpu_has_mips_r6)) {
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
 	case lwc2_or_bc_op: /* This is bbit0 on Octeon */
 		if ((regs->regs[insn.i_format.rs] & (1ull<<insn.i_format.rt))
-- 
2.2.0
