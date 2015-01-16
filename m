Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2015 12:04:12 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:9132 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010896AbbAPKxar22HZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jan 2015 11:53:30 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 00FF668878D37
        for <linux-mips@linux-mips.org>; Fri, 16 Jan 2015 10:53:23 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 16 Jan 2015 10:53:25 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.96) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Fri, 16 Jan 2015 10:53:24 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH RFC v2 44/70] MIPS: kernel: Prepare the JR instruction for emulation on MIPS R6
Date:   Fri, 16 Jan 2015 10:49:23 +0000
Message-ID: <1421405389-15512-45-git-send-email-markos.chandras@imgtec.com>
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
X-archive-position: 45189
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

The MIPS R6 JR instruction is an alias to the JALR one, so it may
need emulation for non-R6 userlands.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/branch.h | 3 +++
 arch/mips/kernel/branch.c      | 5 +++++
 arch/mips/math-emu/cp1emu.c    | 3 +++
 3 files changed, 11 insertions(+)

diff --git a/arch/mips/include/asm/branch.h b/arch/mips/include/asm/branch.h
index de781cf54bc7..2894ea58454d 100644
--- a/arch/mips/include/asm/branch.h
+++ b/arch/mips/include/asm/branch.h
@@ -13,6 +13,9 @@
 #include <asm/ptrace.h>
 #include <asm/inst.h>
 
+static int mipsr2_emulation = 0;
+#define NO_R6EMU	(cpu_has_mips_r6 && !mipsr2_emulation)
+
 extern int __isa_exception_epc(struct pt_regs *regs);
 extern int __compute_return_epc(struct pt_regs *regs);
 extern int __compute_return_epc_for_insn(struct pt_regs *regs,
diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
index 4d7d99d601cc..9b622ca391d8 100644
--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -417,6 +417,11 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
 			regs->regs[insn.r_format.rd] = epc + 8;
 			/* Fall through */
 		case jr_op:
+			if (NO_R6EMU && (insn.r_format.func == jr_op)) {
+				ret = -SIGILL;
+				/* For R6, JR already emulated in jalr_op */
+				break;
+			}
 			regs->cp0_epc = regs->regs[insn.r_format.rs];
 			break;
 		}
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 9dfcd7fc1bc3..9707af43913f 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -448,6 +448,9 @@ static int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 				dec_insn.next_pc_inc;
 			/* Fall through */
 		case jr_op:
+			/* For R6, JR already emulated in jalr_op */
+			if (NO_R6EMU && (insn.r_format.opcode == jr_op))
+				break;
 			*contpc = regs->regs[insn.r_format.rs];
 			return 1;
 		}
-- 
2.2.1
