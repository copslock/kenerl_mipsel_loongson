Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Sep 2016 15:40:02 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:61178 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992143AbcIVNivXRBAr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Sep 2016 15:38:51 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 4DEE9D6C439B1;
        Thu, 22 Sep 2016 14:38:42 +0100 (IST)
Received: from WR-NOWAKOWSKI.kl.imgtec.org (10.80.2.5) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 22 Sep 2016 14:38:45 +0100
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
CC:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Subject: [PATCH 3/3] MIPS: uprobes: fix use of uninitialised variable
Date:   Thu, 22 Sep 2016 15:38:33 +0200
Message-ID: <1474551513-30647-4-git-send-email-marcin.nowakowski@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1474551513-30647-1-git-send-email-marcin.nowakowski@imgtec.com>
References: <1474551513-30647-1-git-send-email-marcin.nowakowski@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55235
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

arch_uprobe_pre_xol needs to emulate a branch if a branch instruction
has been replaced with a breakpoint, but in fact an uninitialised local
variable was passed to the emulator routine instead of the original
instruction

Fixes: 40e084a506eb ('MIPS: Add uprobes support.')
Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
---
 arch/mips/kernel/uprobes.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/uprobes.c b/arch/mips/kernel/uprobes.c
index 3b8accb..4c7c155 100644
--- a/arch/mips/kernel/uprobes.c
+++ b/arch/mips/kernel/uprobes.c
@@ -157,7 +157,6 @@ bool is_trap_insn(uprobe_opcode_t *insn)
 int arch_uprobe_pre_xol(struct arch_uprobe *aup, struct pt_regs *regs)
 {
 	struct uprobe_task *utask = current->utask;
-	union mips_instruction insn;
 
 	/*
 	 * Now find the EPC where to resume after the breakpoint has been
@@ -168,10 +167,10 @@ int arch_uprobe_pre_xol(struct arch_uprobe *aup, struct pt_regs *regs)
 		unsigned long epc;
 
 		epc = regs->cp0_epc;
-		__compute_return_epc_for_insn(regs, insn);
+		__compute_return_epc_for_insn(regs,
+			(union mips_instruction) aup->insn[0]);
 		aup->resume_epc = regs->cp0_epc;
 	}
-
 	utask->autask.saved_trap_nr = current->thread.trap_nr;
 	current->thread.trap_nr = UPROBE_TRAP_NR;
 	regs->cp0_epc = current->utask->xol_vaddr;
-- 
2.7.4
