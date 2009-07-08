Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jul 2009 19:09:30 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:2826 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492043AbZGHRJV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 8 Jul 2009 19:09:21 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a54d2a80001>; Wed, 08 Jul 2009 13:08:56 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 8 Jul 2009 10:07:55 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 8 Jul 2009 10:07:54 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n68H7q27014486;
	Wed, 8 Jul 2009 10:07:52 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n68H7oYO014484;
	Wed, 8 Jul 2009 10:07:50 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Avoid clobbering struct pt_regs in kthreads (v2).
Date:	Wed,  8 Jul 2009 10:07:50 -0700
Message-Id: <1247072870-14460-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
X-OriginalArrivalTime: 08 Jul 2009 17:07:55.0004 (UTC) FILETIME=[A27B03C0:01C9FFEE]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23680
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The resume() implementation octeon_switch.S examines the saved
cp0_status register.  We were clobbering the entire pt_regs structure
in kernel threads leading to random crashes.

When switching away from a kernel thread, the saved cp0_status is
examined and if bit 30 is set it is cleared and the CP2 state saved
into the pt_regs structure.  Since the kernel thread stack overlaid
the pt_regs structure this resulted in a corrupt stack.  When the
kthread with the corrupt stack was resumed, it could crash if it used
any of the data in the stack that was clobbered.

We fix it by moving the kernel thread stack down so it doesn't overlay
pt_regs.

Differences from v1: Don't adjust the sp by an additional 32 bytes, it
                     was not needed.  Also fix up __KSTK_TOS and
                     task_pt_regs.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/processor.h |    5 +++--
 arch/mips/kernel/head.S           |    3 ++-
 arch/mips/kernel/process.c        |    4 +++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index 0f926aa..46d9e04 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -311,8 +311,9 @@ extern void start_thread(struct pt_regs * regs, unsigned long pc, unsigned long
 
 unsigned long get_wchan(struct task_struct *p);
 
-#define __KSTK_TOS(tsk) ((unsigned long)task_stack_page(tsk) + THREAD_SIZE - 32)
-#define task_pt_regs(tsk) ((struct pt_regs *)__KSTK_TOS(tsk) - 1)
+#define __KSTK_TOS(tsk) ((unsigned long)task_stack_page(tsk) + \
+			 THREAD_SIZE - 32 - sizeof (struct pt_regs))
+#define task_pt_regs(tsk) ((struct pt_regs *)__KSTK_TOS(tsk))
 #define KSTK_EIP(tsk) (task_pt_regs(tsk)->cp0_epc)
 #define KSTK_ESP(tsk) (task_pt_regs(tsk)->regs[29])
 #define KSTK_STATUS(tsk) (task_pt_regs(tsk)->cp0_status)
diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
index 492a0a8..531ce7b 100644
--- a/arch/mips/kernel/head.S
+++ b/arch/mips/kernel/head.S
@@ -188,7 +188,8 @@ NESTED(kernel_entry, 16, sp)			# kernel entry point
 
 	MTC0		zero, CP0_CONTEXT	# clear context register
 	PTR_LA		$28, init_thread_union
-	PTR_LI		sp, _THREAD_SIZE - 32
+	/* Set the SP after an empty pt_regs.  */
+	PTR_LI		sp, _THREAD_SIZE - 32 - PT_SIZE
 	PTR_ADDU	sp, $28
 	set_saved_sp	sp, t0, t1
 	PTR_SUBU	sp, 4 * SZREG		# init stack pointer
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index c09d681..f3d73e1 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -115,7 +115,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 {
 	struct thread_info *ti = task_thread_info(p);
 	struct pt_regs *childregs;
-	long childksp;
+	unsigned long childksp;
 	p->set_child_tid = p->clear_child_tid = NULL;
 
 	childksp = (unsigned long)task_stack_page(p) + THREAD_SIZE - 32;
@@ -132,6 +132,8 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 
 	/* set up new TSS. */
 	childregs = (struct pt_regs *) childksp - 1;
+	/*  Put the stack after the struct pt_regs.  */
+	childksp = (unsigned long) childregs;
 	*childregs = *regs;
 	childregs->regs[7] = 0;	/* Clear error flag */
 
-- 
1.6.0.6
