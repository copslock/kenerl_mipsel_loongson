Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 10:20:15 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:38827 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990522AbcIBIUJA1hAm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Sep 2016 10:20:09 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 69CA6CE24303C;
        Fri,  2 Sep 2016 09:19:50 +0100 (IST)
Received: from WR-NOWAKOWSKI.kl.imgtec.org (10.80.2.5) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 2 Sep 2016 09:19:51 +0100
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <ralf@linux-mips.org>, <linux-s390@vger.kernel.org>,
        <schwidefsky@de.ibm.com>, <heiko.carstens@de.ibm.com>
CC:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Subject: [PATCH] uprobes: remove function declarations from arch/{mips,s390}
Date:   Fri, 2 Sep 2016 10:19:44 +0200
Message-ID: <1472804384-17830-1-git-send-email-marcin.nowakowski@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54972
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

The declarations of arch-specific functions have been moved to a common
header in commit 3820b4d2789f ('uprobes: Move function declarations out of
arch'), but MIPS and S390 has added them to their own trees later.
Remove the unnecessary duplicates.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
---
 arch/mips/include/asm/uprobes.h | 12 ------------
 arch/s390/include/asm/uprobes.h | 10 ----------
 2 files changed, 22 deletions(-)

diff --git a/arch/mips/include/asm/uprobes.h b/arch/mips/include/asm/uprobes.h
index 34c325c..28ab364 100644
--- a/arch/mips/include/asm/uprobes.h
+++ b/arch/mips/include/asm/uprobes.h
@@ -43,16 +43,4 @@ struct arch_uprobe_task {
 	unsigned long saved_trap_nr;
 };
 
-extern int arch_uprobe_analyze_insn(struct arch_uprobe *aup,
-	struct mm_struct *mm, unsigned long addr);
-extern int arch_uprobe_pre_xol(struct arch_uprobe *aup, struct pt_regs *regs);
-extern int arch_uprobe_post_xol(struct arch_uprobe *aup, struct pt_regs *regs);
-extern bool arch_uprobe_xol_was_trapped(struct task_struct *tsk);
-extern int arch_uprobe_exception_notify(struct notifier_block *self,
-	unsigned long val, void *data);
-extern void arch_uprobe_abort_xol(struct arch_uprobe *aup,
-	struct pt_regs *regs);
-extern unsigned long arch_uretprobe_hijack_return_addr(
-	unsigned long trampoline_vaddr, struct pt_regs *regs);
-
 #endif /* __ASM_UPROBES_H */
diff --git a/arch/s390/include/asm/uprobes.h b/arch/s390/include/asm/uprobes.h
index 1411dff..658393c 100644
--- a/arch/s390/include/asm/uprobes.h
+++ b/arch/s390/include/asm/uprobes.h
@@ -29,14 +29,4 @@ struct arch_uprobe {
 struct arch_uprobe_task {
 };
 
-int arch_uprobe_analyze_insn(struct arch_uprobe *aup, struct mm_struct *mm,
-			     unsigned long addr);
-int arch_uprobe_pre_xol(struct arch_uprobe *aup, struct pt_regs *regs);
-int arch_uprobe_post_xol(struct arch_uprobe *aup, struct pt_regs *regs);
-bool arch_uprobe_xol_was_trapped(struct task_struct *tsk);
-int arch_uprobe_exception_notify(struct notifier_block *self, unsigned long val,
-				 void *data);
-void arch_uprobe_abort_xol(struct arch_uprobe *ap, struct pt_regs *regs);
-unsigned long arch_uretprobe_hijack_return_addr(unsigned long trampoline,
-						struct pt_regs *regs);
 #endif	/* _ASM_UPROBES_H */
-- 
2.7.4
