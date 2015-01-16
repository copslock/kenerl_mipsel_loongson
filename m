Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2015 12:08:13 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:23478 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010968AbbAPKxzo0Mvx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jan 2015 11:53:55 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id F0BC4141B558B
        for <linux-mips@linux-mips.org>; Fri, 16 Jan 2015 10:53:47 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 16 Jan 2015 10:53:49 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.96) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Fri, 16 Jan 2015 10:53:49 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH RFC v2 58/70] MIPS: Emulate the new MIPS R6 BNVC, BNEC and BNEZLAC instructions
Date:   Fri, 16 Jan 2015 10:49:37 +0000
Message-ID: <1421405389-15512-59-git-send-email-markos.chandras@imgtec.com>
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
X-archive-position: 45202
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

MIPS R6 uses the <R6 DADDI opcode for the new BNVC, BNEC and
BNEZLAC instructions.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/uapi/asm/inst.h | 2 +-
 arch/mips/kernel/branch.c         | 6 +++++-
 arch/mips/math-emu/cp1emu.c       | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
index 782af0f83421..78335414b18a 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -25,7 +25,7 @@ enum major_op {
 	andi_op, ori_op, xori_op, lui_op,
 	cop0_op, cop1_op, cop2_op, cop1x_op,
 	beql_op, bnel_op, blezl_op, bgtzl_op,
-	daddi_op, daddiu_op, ldl_op, ldr_op,
+	daddi_op, cbcond1_op = daddi_op, daddiu_op, ldl_op, ldr_op,
 	spec2_op, jalx_op, mdmx_op, spec3_op,
 	lb_op, lh_op, lwl_op, lw_op,
 	lbu_op, lhu_op, lwr_op, lwu_op,
diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
index c084b38e727b..fa780ac87863 100644
--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -809,12 +809,16 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
 		regs->cp0_epc += 8;
 		break;
 	case cbcond0_op:
+	case cbcond1_op:
 		/* Only valid for MIPS R6 */
 		if (!cpu_has_mips_r6) {
 			ret = -SIGILL;
 			break;
 		}
-		/* Compact branches: bovc, beqc, beqzalc */
+		/*
+		 * Compact branches:
+		 * bovc, beqc, beqzalc, bnvc, bnec, bnezlac
+		 */
 		if (insn.i_format.rt && !insn.i_format.rs)
 			regs->regs[31] = epc + 4;
 		regs->cp0_epc += 8;
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index cafeb54b7cf1..a9c19441795b 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -638,6 +638,7 @@ static int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 
 		return 1;
 	case cbcond0_op:
+	case cbcond1_op:
 		if (!cpu_has_mips_r6)
 			break;
 		if (insn.i_format.rt && !insn.i_format.rs)
-- 
2.2.1
