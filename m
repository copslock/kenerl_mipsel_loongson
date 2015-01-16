Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2015 12:03:56 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:37123 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010877AbbAPKxa30sSp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jan 2015 11:53:30 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id CAF4D94A938B6
        for <linux-mips@linux-mips.org>; Fri, 16 Jan 2015 10:53:27 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 16 Jan 2015 10:53:29 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.96) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Fri, 16 Jan 2015 10:53:29 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH RFC v2 48/70] MIPS: kernel: branch: Prevent BGEZAL emulation for MIPS R6
Date:   Fri, 16 Jan 2015 10:49:27 +0000
Message-ID: <1421405389-15512-49-git-send-email-markos.chandras@imgtec.com>
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
X-archive-position: 45188
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

MIPS R6 removed the BGEZAL instruction so do not try to emulate it
if the R2-to-R6 emulator is not present.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/branch.c   | 22 ++++++++++++++++++++++
 arch/mips/math-emu/cp1emu.c |  4 ++++
 2 files changed, 26 insertions(+)

diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
index 311a2223da59..2273307f7c51 100644
--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -502,7 +502,29 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
 
 		case bgezal_op:
 		case bgezall_op:
+			if (NO_R6EMU && (insn.i_format.rs ||
+			    insn.i_format.rt == bgezall_op)) {
+				ret = -SIGILL;
+				break;
+			}
 			regs->regs[31] = epc + 8;
+			/*
+			 * OK we are here either because we hit a BAL
+			 * instruction or because we are emulating an
+			 * old bgezal{,l} one. Lets figure out what the
+			 * case really is.
+			 */
+			if (!insn.i_format.rs) {
+				/*
+				 * BAL or BGEZAL with rs == 0
+				 * Doesn't matter if we are R6 or not. The
+				 * result is the same
+				 */
+				regs->cp0_epc += 4 +
+					(insn.i_format.simmediate << 2);
+				break;
+			}
+			/* Now do the real thing for non-R6 BGEZAL{,L} */
 			if ((long)regs->regs[insn.i_format.rs] >= 0) {
 				epc = epc + 4 + (insn.i_format.simmediate << 2);
 				if (insn.i_format.rt == bgezall_op)
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 5429efe24d5a..8aa6a451104b 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -482,6 +482,10 @@ static int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 			return 1;
 		case bgezal_op:
 		case bgezall_op:
+			if (NO_R6EMU && (insn.i_format.rs ||
+			    insn.i_format.rt == bgezall_op))
+				break;
+
 			regs->regs[31] = regs->cp0_epc +
 				dec_insn.pc_inc +
 				dec_insn.next_pc_inc;
-- 
2.2.1
