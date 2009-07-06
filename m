Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jul 2009 20:40:50 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:16537 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491784AbZGFSkn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 6 Jul 2009 20:40:43 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a5243790002>; Mon, 06 Jul 2009 14:33:29 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 6 Jul 2009 11:33:14 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 6 Jul 2009 11:33:13 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n66IX8me008501;
	Mon, 6 Jul 2009 11:33:08 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n66IX7i7008499;
	Mon, 6 Jul 2009 11:33:07 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Avoid clobbering struct pt_regs in kthreads.
Date:	Mon,  6 Jul 2009 11:33:07 -0700
Message-Id: <1246905187-8475-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
X-OriginalArrivalTime: 06 Jul 2009 18:33:13.0269 (UTC) FILETIME=[3860C650:01C9FE68]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23668
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

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/kernel/head.S    |    3 ++-
 arch/mips/kernel/process.c |    4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
index 492a0a8..24b41c8 100644
--- a/arch/mips/kernel/head.S
+++ b/arch/mips/kernel/head.S
@@ -188,7 +188,8 @@ NESTED(kernel_entry, 16, sp)			# kernel entry point
 
 	MTC0		zero, CP0_CONTEXT	# clear context register
 	PTR_LA		$28, init_thread_union
-	PTR_LI		sp, _THREAD_SIZE - 32
+	/* Set the SP after an empty pt_regs.  */
+	PTR_LI		sp, _THREAD_SIZE - 32 - PT_SIZE - 32
 	PTR_ADDU	sp, $28
 	set_saved_sp	sp, t0, t1
 	PTR_SUBU	sp, 4 * SZREG		# init stack pointer
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index c09d681..d58a443 100644
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
+	childksp = (unsigned long) childregs - 32;
 	*childregs = *regs;
 	childregs->regs[7] = 0;	/* Clear error flag */
 
-- 
1.6.0.6
