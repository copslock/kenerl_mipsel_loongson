Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Apr 2012 20:38:09 +0200 (CEST)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:63011 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904016Ab2DEShv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Apr 2012 20:37:51 +0200
Received: by eaak13 with SMTP id k13so600516eaa.36
        for <multiple recipients>; Thu, 05 Apr 2012 11:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:from:to:cc:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=UYRGSNYuaPrcuTTxZZpdBdLtYo1uIiSqKXvur1rj4g0=;
        b=fclZzgLCkqYxa0edQ56xLrsD73y1bacG4amLyjEwP0CEVgz3Qj2Vx1Rqz7uKZER9Tt
         8U6cADx4oomtVrsRW6y+04f+x0XXFrqd1nYhOxWknof5MCeB7w5bQypQsg3e01AHPaQ4
         sZDXXj4TKWYey8obnXYFAkGkpIyIi34B9MLsq0eJ/JRXnG3e8x7k2HeREQvg+E7GSF5L
         B3FWEUrU7BMt87BTQHEN9ueAuSF1GtS9rOluKoiKCD/r2oBhOUbM4iDZIjN8PtGQenl6
         rNxRW4xjloYC5MIDDPR7Hd09BJm5OjUiUpsmcaivPOOVJbYfQt3ELu36R/vl2IcFPAQ/
         pgHw==
Received: by 10.213.20.19 with SMTP id d19mr500835ebb.37.1333651066333;
        Thu, 05 Apr 2012 11:37:46 -0700 (PDT)
Received: from [192.168.0.100] (d54C476BA.access.telenet.be. [84.196.118.186])
        by mx.google.com with ESMTPS id n56sm15803855eeb.4.2012.04.05.11.37.44
        (version=SSLv3 cipher=OTHER);
        Thu, 05 Apr 2012 11:37:45 -0700 (PDT)
Subject: [PATCH] mips: fix endless loop when processing signals for kernel
 tasks
From:   dimm <dmitry.adamushko@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset="UTF-8"
Date:   Thu, 05 Apr 2012 20:37:34 +0200
Message-ID: <1333651054.3680.11.camel@dimm>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
X-archive-position: 32860
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitry.adamushko@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Dmitry Adamushko <dmitry.adamushka_ext@softathome.com>

The problem occurs [1] when a kernel-mode task returns from a system
call with a pending signal.

A real-life scenario is a child of 'khelper' returning from a failed
kernel_execve() in ____call_usermodehelper() [ kernel/kmod.c ].
kernel_execve() fails due to a pending SIGKILL, which is the result of
"kill -9 -1" (at least, busybox's init does it upon reboot).

The loop is as follows:

* syscall_exit_work:
 - work_pending:            // start_of_the_loop
 - work_notifysig:
   - do_notify_resume()
     - do_signal()
       - if (!user_mode(regs)) return;
 - resume_userspace         // TIF_SIGPENDING is still set
 - work_pending             // so we call work_pending => goto 
                            // start_of_the_loop

More information can be found in another LKML thread:
http://www.serverphorums.com/read.php?12,457826

[1] The problem was also reproduced on !CONFIG_VM86 x86, and the
following fix was accepted.

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=29a2e2836ff9ea65a603c89df217f4198973a74f

Signed-off-by: Dmitry Adamushko <dmitry.adamushko@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org

--- arch/mips/kernel/entry.S.old	2012-04-05 10:57:12.500976124 +0200
+++ arch/mips/kernel/entry.S	2012-04-05 11:21:24.128174358 +0200
@@ -36,6 +36,11 @@ FEXPORT(ret_from_exception)
 FEXPORT(ret_from_irq)
 	LONG_S	s0, TI_REGS($28)
 FEXPORT(__ret_from_irq)
+/*
+ * We can be coming here from a syscall done in the kernel space,
+ * e.g. a failed kernel_execve().
+ */
+resume_userspace_check:
 	LONG_L	t0, PT_STATUS(sp)		# returning to kernel mode?
 	andi	t0, t0, KU_USER
 	beqz	t0, resume_kernel
@@ -162,7 +167,7 @@ work_notifysig:				# deal with pending s
 	move	a0, sp
 	li	a1, 0
 	jal	do_notify_resume	# a2 already loaded
-	j	resume_userspace
+	j	resume_userspace_check
 
 FEXPORT(syscall_exit_work_partial)
 	SAVE_STATIC
