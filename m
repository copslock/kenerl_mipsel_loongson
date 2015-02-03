Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Feb 2015 17:08:33 +0100 (CET)
Received: from bastet.se.axis.com ([195.60.68.11]:36336 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014824AbbBCQIcFW9vB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Feb 2015 17:08:32 +0100
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id E93C518084;
        Tue,  3 Feb 2015 17:08:26 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id zZAZNr3BIYod; Tue,  3 Feb 2015 17:08:26 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
        by bastet.se.axis.com (Postfix) with ESMTP id 25F11180DC;
        Tue,  3 Feb 2015 17:08:26 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
        by postfix.imss71 (Postfix) with ESMTP id 1029812DB;
        Tue,  3 Feb 2015 17:08:26 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
        by boulder.se.axis.com (Postfix) with ESMTP id 04B401061;
        Tue,  3 Feb 2015 17:08:26 +0100 (CET)
Received: from lnxlarper.se.axis.com (lnxlarper.se.axis.com [10.88.41.1])
        by thoth.se.axis.com (Postfix) with ESMTP id 03506342AB;
        Tue,  3 Feb 2015 17:08:26 +0100 (CET)
Received: by lnxlarper.se.axis.com (Postfix, from userid 20456)
        id F1209801F3; Tue,  3 Feb 2015 17:08:25 +0100 (CET)
From:   Lars Persson <lars.persson@axis.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     Lars Persson <larper@axis.com>
Subject: [PATCH] MIPS: Fix syscall_get_nr for the syscall exit tracing.
Date:   Tue,  3 Feb 2015 17:08:17 +0100
Message-Id: <1422979697-1509-1-git-send-email-larper@axis.com>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <lars.persson@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45635
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars.persson@axis.com
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

Register 2 is alredy overwritten by the return value when
syscall_trace_leave() is called.

Signed-off-by: Lars Persson <larper@axis.com>
---
 arch/mips/include/asm/syscall.h     |    8 +-------
 arch/mips/include/asm/thread_info.h |    1 +
 arch/mips/kernel/ptrace.c           |    2 ++
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/mips/include/asm/syscall.h b/arch/mips/include/asm/syscall.h
index bb79637..6499d93 100644
--- a/arch/mips/include/asm/syscall.h
+++ b/arch/mips/include/asm/syscall.h
@@ -29,13 +29,7 @@
 static inline long syscall_get_nr(struct task_struct *task,
 				  struct pt_regs *regs)
 {
-	/* O32 ABI syscall() - Either 64-bit with O32 or 32-bit */
-	if ((config_enabled(CONFIG_32BIT) ||
-	    test_tsk_thread_flag(task, TIF_32BIT_REGS)) &&
-	    (regs->regs[2] == __NR_syscall))
-		return regs->regs[4];
-	else
-		return regs->regs[2];
+	return current_thread_info()->syscall;
 }
 
 static inline unsigned long mips_get_syscall_arg(unsigned long *arg,
diff --git a/arch/mips/include/asm/thread_info.h b/arch/mips/include/asm/thread_info.h
index 99eea59..e4440f9 100644
--- a/arch/mips/include/asm/thread_info.h
+++ b/arch/mips/include/asm/thread_info.h
@@ -36,6 +36,7 @@ struct thread_info {
 						 */
 	struct restart_block	restart_block;
 	struct pt_regs		*regs;
+	long			syscall;	/* syscall number */
 };
 
 /*
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 9d1487d..5104528 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -770,6 +770,8 @@ asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall)
 	long ret = 0;
 	user_exit();
 
+	current_thread_info()->syscall = syscall;
+
 	if (secure_computing() == -1)
 		return -1;
 
-- 
1.7.10.4
