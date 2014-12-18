Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 16:26:32 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:55318 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009205AbaLRPNTkwWW3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 16:13:19 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id B544128EF5C10
        for <linux-mips@linux-mips.org>; Thu, 18 Dec 2014 15:13:10 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 18 Dec 2014 15:13:13 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.125) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 18 Dec 2014 15:13:13 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH RFC 53/67] =?UTF-8?q?MIPS:=20kernel:=20branch:=20Add=20new?= =?UTF-8?q?=20MIPS=20R6=20B{L,G}=CE=95Z{AL,}C=20emulation?=
Date:   Thu, 18 Dec 2014 15:10:02 +0000
Message-ID: <1418915416-3196-54-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com>
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.125]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44788
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
BLEZC: Compact branch if GPR rt is < to zero
BGEZC: Compact branch if GPR rt is > to zero

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/branch.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
index e6d78ab52aa7..7bc2df026b51 100644
--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -402,6 +402,16 @@ int __MIPS16e_compute_return_epc(struct pt_regs *regs)
  * @returns:	-EFAULT on error and forces SIGBUS, and on success
  *		returns 0 or BRANCH_LIKELY_TAKEN as appropriate after
  *		evaluating the branch.
+ *
+ * MIPS R6 Compact branches and forbidden slots:
+ *	Compact branches do not throw exceptions because they do
+ *	not have delay slots. The forbidden slot instruction ($PC+4)
+ *	is only executed if the branch was not taken. Otherwise the
+ *	forbidden slot is skipped entirely. This means that they
+ *	only possible reason to be here because of a MIPS R6 compact
+ *	branch instruction is that the forbidden slot has thrown one.
+ *	In that case the branch was not taken, so the EPC can be safely
+ *	set to EPC + 8.
  */
 int __compute_return_epc_for_insn(struct pt_regs *regs,
 				   union mips_instruction insn)
@@ -609,6 +619,18 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
 			ret = -SIGILL;
 			break;
 		}
+		/* blezalc, bgezalc, blezc, bgezc */
+		if (cpu_has_mips_r6) {
+			if (insn.i_format.rt) {
+				if (insn.i_format.opcode == blez_op)
+					if ((insn.i_format.rs ==
+					     insn.i_format.rt) ||
+					    !insn.i_format.rs)
+						regs->regs[31] = epc + 4;
+				regs->cp0_epc += 8;
+				break;
+			}
+		}
 		/* rt field assumed to be zero */
 		if ((long)regs->regs[insn.i_format.rs] <= 0) {
 			epc = epc + 4 + (insn.i_format.simmediate << 2);
-- 
2.2.0
