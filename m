Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Oct 2016 10:39:15 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:36055 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992181AbcJFIi1tyb0o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Oct 2016 10:38:27 +0200
Received: from localhost (unknown [62.214.2.210])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7A618901;
        Thu,  6 Oct 2016 08:38:21 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.7 056/141] MIPS: uprobes: fix use of uninitialised variable
Date:   Thu,  6 Oct 2016 10:28:12 +0200
Message-Id: <20161006074451.166112842@linuxfoundation.org>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161006074448.608056610@linuxfoundation.org>
References: <20161006074448.608056610@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55347
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>

commit ca86c9ef2b322ebf24772009fdea037688cbdac1 upstream.

arch_uprobe_pre_xol needs to emulate a branch if a branch instruction
has been replaced with a breakpoint, but in fact an uninitialised local
variable was passed to the emulator routine instead of the original
instruction

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Fixes: 40e084a506eb ('MIPS: Add uprobes support.')
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/14300/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/uprobes.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/arch/mips/kernel/uprobes.c
+++ b/arch/mips/kernel/uprobes.c
@@ -157,7 +157,6 @@ bool is_trap_insn(uprobe_opcode_t *insn)
 int arch_uprobe_pre_xol(struct arch_uprobe *aup, struct pt_regs *regs)
 {
 	struct uprobe_task *utask = current->utask;
-	union mips_instruction insn;
 
 	/*
 	 * Now find the EPC where to resume after the breakpoint has been
@@ -168,10 +167,10 @@ int arch_uprobe_pre_xol(struct arch_upro
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
