Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2015 12:09:01 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:65428 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010975AbbAPKyAlkNlq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jan 2015 11:54:00 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id CEDE3D6C58FB
        for <linux-mips@linux-mips.org>; Fri, 16 Jan 2015 10:53:52 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 16 Jan 2015 10:53:54 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.96) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Fri, 16 Jan 2015 10:53:54 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH RFC v2 61/70] MIPS: Emulate the new MIPS R6 BNEZC and JIALC instructions
Date:   Fri, 16 Jan 2015 10:49:40 +0000
Message-ID: <1421405389-15512-62-git-send-email-markos.chandras@imgtec.com>
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
X-archive-position: 45205
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

MIPS R6 uses the <R6 sdc2 opcode for the new BNEZC and JIALC instructions

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/uapi/asm/inst.h |  2 +-
 arch/mips/kernel/branch.c         | 10 ++++++++++
 arch/mips/math-emu/cp1emu.c       |  9 +++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
index 721f8fe705a4..fc0cf5ac0cf7 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -34,7 +34,7 @@ enum major_op {
 	ll_op, lwc1_op, lwc2_op, bc6_op = lwc2_op, pref_op,
 	lld_op, ldc1_op, ldc2_op, beqzcjic_op = ldc2_op, ld_op,
 	sc_op, swc1_op, swc2_op, balc6_op = swc2_op, major_3b_op,
-	scd_op, sdc1_op, sdc2_op, sd_op
+	scd_op, sdc1_op, sdc2_op, bnezcjialc_op = sdc2_op, sd_op
 };
 
 /*
diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
index c29ceaeaa96e..02d6032e91ab 100644
--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -841,6 +841,16 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
 		/* Compact branch: BEQZC || JIC */
 		regs->cp0_epc += 8;
 		break;
+	case bnezcjialc_op:
+		if (!cpu_has_mips_r6) {
+			ret = -SIGILL;
+			break;
+		}
+		/* Compact branch: BNEZC || JIALC */
+		if (insn.i_format.rs)
+			regs->regs[31] = epc + 4;
+		regs->cp0_epc += 8;
+		break;
 	}
 
 	return ret;
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 2b53036d5f09..bf4ccb15c541 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -662,6 +662,15 @@ static int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 			dec_insn.next_pc_inc;
 
 		return 1;
+	case bnezcjialc_op:
+		if (!cpu_has_mips_r6)
+			break;
+		if (!insn.i_format.rs)
+			regs->regs[31] = regs->cp0_epc + 4;
+		*contpc = regs->cp0_epc + dec_insn.pc_inc +
+			dec_insn.next_pc_inc;
+
+		return 1;
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
 	case lwc2_op: /* This is bbit0 on Octeon */
 		if ((regs->regs[insn.i_format.rs] & (1ull<<insn.i_format.rt)) == 0)
-- 
2.2.1
