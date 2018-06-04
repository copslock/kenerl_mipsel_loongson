Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jun 2018 17:53:30 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:50082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994562AbeFDPxX05Vf9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 4 Jun 2018 17:53:23 +0200
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9786A20896;
        Mon,  4 Jun 2018 15:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528127596;
        bh=oWJaCDLTi+igdzV+vF4jWbvfReFewdO7c6illdHDiUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KDG3bRCSyjavjdNN0a8bQa7GEclrrAWk0aQsFMhxMmEqvPD8xjNRYHsqzZgpCBgUD
         gtkJEHY095ZxHPrGgde8UTVYLRRQ/wR1WqbaRbUOig3fQwG8LlmbnwNXDrgeHdsDUB
         KxH5ztM2D3bUtH9pYhtn23WBnFtuwDT8RW6qGriw=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-arch@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Subject: [RFC PATCH -tip v5 09/27] MIPS: kprobes: Remove jprobe implementation
Date:   Tue,  5 Jun 2018 00:52:52 +0900
Message-Id: <152812757230.10068.6282345214798526578.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152812730943.10068.5166429445118734697.stgit@devbox>
References: <152812730943.10068.5166429445118734697.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <mhiramat@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64174
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mhiramat@kernel.org
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

Remove arch dependent setjump/longjump functions
and unused fields in kprobe_ctlblk for jprobes
from arch/mips.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/kprobes.h |   13 -----------
 arch/mips/kernel/kprobes.c      |   45 ---------------------------------------
 2 files changed, 58 deletions(-)

diff --git a/arch/mips/include/asm/kprobes.h b/arch/mips/include/asm/kprobes.h
index ad1a99948f27..a72dfbf1babb 100644
--- a/arch/mips/include/asm/kprobes.h
+++ b/arch/mips/include/asm/kprobes.h
@@ -68,16 +68,6 @@ struct prev_kprobe {
 	unsigned long saved_epc;
 };
 
-#define MAX_JPROBES_STACK_SIZE 128
-#define MAX_JPROBES_STACK_ADDR \
-	(((unsigned long)current_thread_info()) + THREAD_SIZE - 32 - sizeof(struct pt_regs))
-
-#define MIN_JPROBES_STACK_SIZE(ADDR)					\
-	((((ADDR) + MAX_JPROBES_STACK_SIZE) > MAX_JPROBES_STACK_ADDR)	\
-		? MAX_JPROBES_STACK_ADDR - (ADDR)			\
-		: MAX_JPROBES_STACK_SIZE)
-
-
 #define SKIP_DELAYSLOT 0x0001
 
 /* per-cpu kprobe control block */
@@ -86,12 +76,9 @@ struct kprobe_ctlblk {
 	unsigned long kprobe_old_SR;
 	unsigned long kprobe_saved_SR;
 	unsigned long kprobe_saved_epc;
-	unsigned long jprobe_saved_sp;
-	struct pt_regs jprobe_saved_regs;
 	/* Per-thread fields, used while emulating branches */
 	unsigned long flags;
 	unsigned long target_epc;
-	u8 jprobes_stack[MAX_JPROBES_STACK_SIZE];
 	struct prev_kprobe prev_kprobe;
 };
 
diff --git a/arch/mips/kernel/kprobes.c b/arch/mips/kernel/kprobes.c
index f5c8bce70db2..efdcd0b1ce12 100644
--- a/arch/mips/kernel/kprobes.c
+++ b/arch/mips/kernel/kprobes.c
@@ -468,51 +468,6 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
 	return ret;
 }
 
-int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct jprobe *jp = container_of(p, struct jprobe, kp);
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-
-	kcb->jprobe_saved_regs = *regs;
-	kcb->jprobe_saved_sp = regs->regs[29];
-
-	memcpy(kcb->jprobes_stack, (void *)kcb->jprobe_saved_sp,
-	       MIN_JPROBES_STACK_SIZE(kcb->jprobe_saved_sp));
-
-	regs->cp0_epc = (unsigned long)(jp->entry);
-
-	return 1;
-}
-
-/* Defined in the inline asm below. */
-void jprobe_return_end(void);
-
-void __kprobes jprobe_return(void)
-{
-	/* Assembler quirk necessitates this '0,code' business.	 */
-	asm volatile(
-		"break 0,%0\n\t"
-		".globl jprobe_return_end\n"
-		"jprobe_return_end:\n"
-		: : "n" (BRK_KPROBE_BP) : "memory");
-}
-
-int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-
-	if (regs->cp0_epc >= (unsigned long)jprobe_return &&
-	    regs->cp0_epc <= (unsigned long)jprobe_return_end) {
-		*regs = kcb->jprobe_saved_regs;
-		memcpy((void *)kcb->jprobe_saved_sp, kcb->jprobes_stack,
-		       MIN_JPROBES_STACK_SIZE(kcb->jprobe_saved_sp));
-		preempt_enable_no_resched();
-
-		return 1;
-	}
-	return 0;
-}
-
 /*
  * Function return probe trampoline:
  *	- init_kprobes() establishes a probepoint here
