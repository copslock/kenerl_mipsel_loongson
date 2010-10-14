Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Oct 2010 12:43:23 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:56754 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491833Ab0JNKlz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Oct 2010 12:41:55 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o9EAfspj029695
        for <linux-mips@linux-mips.org>; Thu, 14 Oct 2010 11:41:54 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o9EAfsdl029694
        for linux-mips@linux-mips.org; Thu, 14 Oct 2010 11:41:54 +0100
Resent-From: ralf@linux-mips.org
Resent-Date: Thu, 14 Oct 2010 11:41:54 +0100
Resent-Message-ID: <20101014104154.GE28911@linux-mips.org>
Resent-To: linux-mips@linux-mips.org
Received: from zeniv.linux.org.uk ([195.92.253.2]:46427 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491964Ab0I1Ru5 (ORCPT <rfc822;ralf@linux-mips.org>);
        Tue, 28 Sep 2010 19:50:57 +0200
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.69 #1 (Red Hat Linux))
        id 1P0eKP-0006jZ-5F; Tue, 28 Sep 2010 17:50:57 +0000
Date:   Tue, 28 Sep 2010 18:50:57 +0100
To:     ralf@linux-mips.org
Subject: [PATCH 5/5] mips: do_sigaltstack() expects userland pointers
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
User-Agent: Heirloom mailx 12.4 7/29/08
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1P0eKP-0006jZ-5F@ZenIV.linux.org.uk>
From:   Al Viro <viro@ftp.linux.org.uk>
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28068
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips


o32 compat does the right thing, native and n32 compat do not...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/mips/kernel/signal.c     |    5 +----
 arch/mips/kernel/signal_n32.c |    5 +++++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 604f077..5922342 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -390,7 +390,6 @@ asmlinkage void sys_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
 {
 	struct rt_sigframe __user *frame;
 	sigset_t set;
-	stack_t st;
 	int sig;
 
 	frame = (struct rt_sigframe __user *) regs.regs[29];
@@ -411,11 +410,9 @@ asmlinkage void sys_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
 	else if (sig)
 		force_sig(sig, current);
 
-	if (__copy_from_user(&st, &frame->rs_uc.uc_stack, sizeof(st)))
-		goto badframe;
 	/* It is more difficult to avoid calling this function than to
 	   call it and ignore errors.  */
-	do_sigaltstack((stack_t __user *)&st, NULL, regs.regs[29]);
+	do_sigaltstack(&frame->rs_uc.uc_stack, NULL, regs.regs[29]);
 
 	/*
 	 * Don't let your children do this ...
diff --git a/arch/mips/kernel/signal_n32.c b/arch/mips/kernel/signal_n32.c
index 2c5df81..ee24d81 100644
--- a/arch/mips/kernel/signal_n32.c
+++ b/arch/mips/kernel/signal_n32.c
@@ -109,6 +109,7 @@ asmlinkage int sysn32_rt_sigsuspend(nabi_no_regargs struct pt_regs regs)
 asmlinkage void sysn32_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
 {
 	struct rt_sigframe_n32 __user *frame;
+	mm_segment_t old_fs;
 	sigset_t set;
 	stack_t st;
 	s32 sp;
@@ -143,7 +144,11 @@ asmlinkage void sysn32_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
 
 	/* It is more difficult to avoid calling this function than to
 	   call it and ignore errors.  */
+	old_fs = get_fs();
+	set_fs(KERNEL_DS);
 	do_sigaltstack((stack_t __user *)&st, NULL, regs.regs[29]);
+	set_fs(old_fs);
+
 
 	/*
 	 * Don't let your children do this ...
-- 
1.5.6.5
