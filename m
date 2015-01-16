Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2015 12:08:29 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:29272 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010969AbbAPKx5EjfYF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jan 2015 11:53:57 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 3EEABF8BAF9BF
        for <linux-mips@linux-mips.org>; Fri, 16 Jan 2015 10:53:49 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 16 Jan 2015 10:53:51 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.96) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Fri, 16 Jan 2015 10:53:50 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH RFC v2 59/70] MIPS: Emulate the new MIPS R6 BALC instruction
Date:   Fri, 16 Jan 2015 10:49:38 +0000
Message-ID: <1421405389-15512-60-git-send-email-markos.chandras@imgtec.com>
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
X-archive-position: 45203
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

MIPS R6 uses the <R6 swc2 opcode for the new BALC instructions.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/uapi/asm/inst.h |  2 +-
 arch/mips/kernel/branch.c         | 10 ++++++++++
 arch/mips/math-emu/cp1emu.c       |  7 +++++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
index 78335414b18a..32063c52f24b 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -33,7 +33,7 @@ enum major_op {
 	sdl_op, sdr_op, swr_op, cache_op,
 	ll_op, lwc1_op, lwc2_op, bc6_op = lwc2_op, pref_op,
 	lld_op, ldc1_op, ldc2_op, ld_op,
-	sc_op, swc1_op, swc2_op, major_3b_op,
+	sc_op, swc1_op, swc2_op, balc6_op = swc2_op, major_3b_op,
 	scd_op, sdc1_op, sdc2_op, sd_op
 };
 
diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
index fa780ac87863..93e90c27a0cd 100644
--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -823,6 +823,16 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
 			regs->regs[31] = epc + 4;
 		regs->cp0_epc += 8;
 		break;
+	case balc6_op:
+		if (!cpu_has_mips_r6) {
+			ret = -SIGILL;
+			break;
+		}
+		/* Compact branch: BALC */
+		regs->regs[31] = epc + 4;
+		epc += 4 + (insn.i_format.simmediate << 2);
+		regs->cp0_epc = epc;
+		break;
 	}
 
 	return ret;
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index a9c19441795b..b66d77ad5504 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -647,7 +647,14 @@ static int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 			dec_insn.next_pc_inc;
 
 		return 1;
+	case balc6_op:
+		if (!cpu_has_mips_r6)
+			break;
+		regs->regs[31] = regs->cp0_epc + 4;
+		*contpc = regs->cp0_epc + dec_insn.pc_inc +
+			dec_insn.next_pc_inc;
 
+		return 1;
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
 	case lwc2_op: /* This is bbit0 on Octeon */
 		if ((regs->regs[insn.i_format.rs] & (1ull<<insn.i_format.rt)) == 0)
-- 
2.2.1
