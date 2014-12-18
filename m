Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 16:21:03 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:8528 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009186AbaLRPMjcwWWm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 16:12:39 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 931D2A9CB222A
        for <linux-mips@linux-mips.org>; Thu, 18 Dec 2014 15:12:30 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 18 Dec 2014 15:12:33 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.125) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 18 Dec 2014 15:12:32 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH RFC 35/67] MIPS: uapi: inst: Add new opcodes for COP2 instructions
Date:   Thu, 18 Dec 2014 15:09:44 +0000
Message-ID: <1418915416-3196-36-git-send-email-markos.chandras@imgtec.com>
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
X-archive-position: 44770
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

MIPS R6 redefined the opcodes for LWC2, SWC2, LDC2 and SDC2
so add the new ones for R6.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/uapi/asm/inst.h | 16 ++++++++++++----
 arch/mips/kernel/branch.c         |  8 ++++----
 arch/mips/kernel/kprobes.c        |  8 ++++----
 arch/mips/kernel/unaligned.c      |  8 ++++----
 arch/mips/math-emu/cp1emu.c       |  8 ++++----
 arch/mips/mm/uasm-mips.c          |  4 ++--
 6 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
index c330de057558..b7aa4c788983 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -31,10 +31,10 @@ enum major_op {
 	lbu_op, lhu_op, lwr_op, lwu_op,
 	sb_op, sh_op, swl_op, sw_op,
 	sdl_op, sdr_op, swr_op, cache_op,
-	ll_op, lwc1_op, lwc2_op, pref_op,
-	lld_op, ldc1_op, ldc2_op, ld_op,
-	sc_op, swc1_op, swc2_op, major_3b_op,
-	scd_op, sdc1_op, sdc2_op, sd_op
+	ll_op, lwc1_op, lwc2_or_bc_op, pref_op,
+	lld_op, ldc1_op, ldc2_or_bzcjic_op, ld_op,
+	sc_op, swc1_op, swc2_or_balc_op, major_3b_op,
+	scd_op, sdc1_op, sdc2_or_bnzcjialc_op, sd_op
 };
 
 /*
@@ -188,6 +188,14 @@ enum cop1x_func {
 };
 
 /*
+ * minor opcode for cop2 instructions (R6)
+ */
+enum cop2r6_minor_op {
+	lwc2r6_op    = 0x0a, swc2r6_op     = 0x0b,
+	ldc2r6_op    = 0x0e, sdc2r6_op     = 0x0f
+};
+
+/*
  * func field for mad opcodes (MIPS IV).
  */
 enum mad_func {
diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
index 4d7d99d601cc..b7dd0926e87f 100644
--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -595,7 +595,7 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
 		}
 		break;
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
-	case lwc2_op: /* This is bbit0 on Octeon */
+	case lwc2_or_bc_op: /* This is bbit0 on Octeon */
 		if ((regs->regs[insn.i_format.rs] & (1ull<<insn.i_format.rt))
 		     == 0)
 			epc = epc + 4 + (insn.i_format.simmediate << 2);
@@ -603,7 +603,7 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
 			epc += 8;
 		regs->cp0_epc = epc;
 		break;
-	case ldc2_op: /* This is bbit032 on Octeon */
+	case ldc2_or_bzcjic_op: /* This is bbit032 on Octeon */
 		if ((regs->regs[insn.i_format.rs] &
 		    (1ull<<(insn.i_format.rt+32))) == 0)
 			epc = epc + 4 + (insn.i_format.simmediate << 2);
@@ -611,14 +611,14 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
 			epc += 8;
 		regs->cp0_epc = epc;
 		break;
-	case swc2_op: /* This is bbit1 on Octeon */
+	case swc2_or_balc_op: /* This is bbit1 on Octeon */
 		if (regs->regs[insn.i_format.rs] & (1ull<<insn.i_format.rt))
 			epc = epc + 4 + (insn.i_format.simmediate << 2);
 		else
 			epc += 8;
 		regs->cp0_epc = epc;
 		break;
-	case sdc2_op: /* This is bbit132 on Octeon */
+	case sdc2_or_bnzcjialc_op: /* This is bbit132 on Octeon */
 		if (regs->regs[insn.i_format.rs] &
 		    (1ull<<(insn.i_format.rt+32)))
 			epc = epc + 4 + (insn.i_format.simmediate << 2);
diff --git a/arch/mips/kernel/kprobes.c b/arch/mips/kernel/kprobes.c
index 212f46f2014e..c12d50b241fa 100644
--- a/arch/mips/kernel/kprobes.c
+++ b/arch/mips/kernel/kprobes.c
@@ -101,10 +101,10 @@ static int __kprobes insn_has_delayslot(union mips_instruction insn)
 	case cop1_op:
 
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
-	case lwc2_op: /* This is bbit0 on Octeon */
-	case ldc2_op: /* This is bbit032 on Octeon */
-	case swc2_op: /* This is bbit1 on Octeon */
-	case sdc2_op: /* This is bbit132 on Octeon */
+	case lwc2_or_bc_op: /* This is bbit0 on Octeon */
+	case ldc2_or_bzcjic_op: /* This is bbit032 on Octeon */
+	case swc2_or_balc_op: /* This is bbit1 on Octeon */
+	case sdc2_or_bnzcjialc_op: /* This is bbit132 on Octeon */
 #endif
 		return 1;
 	default:
diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
index e11906dff885..3665905cbbe2 100644
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -708,19 +708,19 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 	 * It's up to applications to register a notifier chain and do
 	 * whatever they have to do, including possible sending of signals.
 	 */
-	case lwc2_op:
+	case lwc2_or_bc_op:
 		cu2_notifier_call_chain(CU2_LWC2_OP, regs);
 		break;
 
-	case ldc2_op:
+	case ldc2_or_bzcjic_op:
 		cu2_notifier_call_chain(CU2_LDC2_OP, regs);
 		break;
 
-	case swc2_op:
+	case swc2_or_balc_op:
 		cu2_notifier_call_chain(CU2_SWC2_OP, regs);
 		break;
 
-	case sdc2_op:
+	case sdc2_or_bnzcjialc_op:
 		cu2_notifier_call_chain(CU2_SDC2_OP, regs);
 		break;
 
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index cac529a405b8..a426c176ee54 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -552,25 +552,25 @@ static int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 				dec_insn.next_pc_inc;
 		return 1;
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
-	case lwc2_op: /* This is bbit0 on Octeon */
+	case lwc2_or_bc_op: /* This is bbit0 on Octeon */
 		if ((regs->regs[insn.i_format.rs] & (1ull<<insn.i_format.rt)) == 0)
 			*contpc = regs->cp0_epc + 4 + (insn.i_format.simmediate << 2);
 		else
 			*contpc = regs->cp0_epc + 8;
 		return 1;
-	case ldc2_op: /* This is bbit032 on Octeon */
+	case ldc2_or_bzcjic_op: /* This is bbit032 on Octeon */
 		if ((regs->regs[insn.i_format.rs] & (1ull<<(insn.i_format.rt + 32))) == 0)
 			*contpc = regs->cp0_epc + 4 + (insn.i_format.simmediate << 2);
 		else
 			*contpc = regs->cp0_epc + 8;
 		return 1;
-	case swc2_op: /* This is bbit1 on Octeon */
+	case swc2_balc_op: /* This is bbit1 on Octeon */
 		if (regs->regs[insn.i_format.rs] & (1ull<<insn.i_format.rt))
 			*contpc = regs->cp0_epc + 4 + (insn.i_format.simmediate << 2);
 		else
 			*contpc = regs->cp0_epc + 8;
 		return 1;
-	case sdc2_op: /* This is bbit132 on Octeon */
+	case sdc2_bnzcjialc_op: /* This is bbit132 on Octeon */
 		if (regs->regs[insn.i_format.rs] & (1ull<<(insn.i_format.rt + 32)))
 			*contpc = regs->cp0_epc + 4 + (insn.i_format.simmediate << 2);
 		else
diff --git a/arch/mips/mm/uasm-mips.c b/arch/mips/mm/uasm-mips.c
index c1fb8bdfb06d..97b0a5c80360 100644
--- a/arch/mips/mm/uasm-mips.c
+++ b/arch/mips/mm/uasm-mips.c
@@ -61,8 +61,8 @@ static struct insn insn_table[] = {
 	{ insn_addu, M(spec_op, 0, 0, 0, 0, addu_op), RS | RT | RD },
 	{ insn_andi, M(andi_op, 0, 0, 0, 0, 0), RS | RT | UIMM },
 	{ insn_and, M(spec_op, 0, 0, 0, 0, and_op), RS | RT | RD },
-	{ insn_bbit0, M(lwc2_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
-	{ insn_bbit1, M(swc2_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
+	{ insn_bbit0, M(lwc2_or_bc_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
+	{ insn_bbit1, M(swc2_or_balc_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
 	{ insn_beql, M(beql_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
 	{ insn_beq, M(beq_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
 	{ insn_bgezl, M(bcond_op, 0, bgezl_op, 0, 0, 0), RS | BIMM },
-- 
2.2.0
