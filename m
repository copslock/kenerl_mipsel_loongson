Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Aug 2017 22:58:39 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:62586 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994818AbdHKU5imo0Vw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Aug 2017 22:57:38 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 5876863581DD2;
        Fri, 11 Aug 2017 21:57:27 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 11 Aug 2017 21:57:31 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Lars Persson <larper@axis.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Subject: [PATCH 3/4] MIPS/ptrace: Update syscall nr on register changes
Date:   Fri, 11 Aug 2017 21:56:52 +0100
Message-ID: <20170811205653.21873-4-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170811205653.21873-1-james.hogan@imgtec.com>
References: <20170811205653.21873-1-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59488
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Update the thread_info::syscall field when registers are modified via
ptrace to change or cancel the system call being entered.

This is important to allow seccomp and the syscall entry and exit trace
events to observe the new syscall number changed by the normal ptrace
hook or seccomp. That includes allowing seccomp's recheck of the system
call number after SECCOMP_RET_TRACE to notice if the syscall is changed
to a denied one, which happens in seccomp since commit ce6526e8afa4
("seccomp: recheck the syscall after RET_TRACE") in v4.8.

In the process of doing this, the logic to determine whether an indirect
system call is in progress (i.e. the O32 ABI's syscall()) is abstracted
into mips_syscall_is_indirect(), and a new mips_syscall_update_nr() is
used to update the thread_info::syscall based on the register state.

The following ptrace operations are updated:
 - PTRACE_SETREGS (ptrace_setregs()).
 - PTRACE_SETREGSET with NT_PRSTATUS (gpr32_set() and gpr64_set()).
 - PTRACE_POKEUSR with 2/v0 or 4/a0 for indirect syscall
   ([compat_]arch_ptrace()).

Fixes: c2d9f1775731 ("MIPS: Fix syscall_get_nr for the syscall exit tracing.")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Lars Persson <larper@axis.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/syscall.h | 29 +++++++++++++++++++++++++----
 arch/mips/kernel/ptrace.c       | 15 +++++++++++++++
 arch/mips/kernel/ptrace32.c     |  7 +++++++
 3 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/syscall.h b/arch/mips/include/asm/syscall.h
index 7c713025b23f..0170602a1e4e 100644
--- a/arch/mips/include/asm/syscall.h
+++ b/arch/mips/include/asm/syscall.h
@@ -26,12 +26,34 @@
 #define __NR_syscall 4000
 #endif
 
+static inline bool mips_syscall_is_indirect(struct task_struct *task,
+					    struct pt_regs *regs)
+{
+	/* O32 ABI syscall() - Either 64-bit with O32 or 32-bit */
+	return (IS_ENABLED(CONFIG_32BIT) ||
+		test_tsk_thread_flag(task, TIF_32BIT_REGS)) &&
+		(regs->regs[2] == __NR_syscall);
+}
+
 static inline long syscall_get_nr(struct task_struct *task,
 				  struct pt_regs *regs)
 {
 	return current_thread_info()->syscall;
 }
 
+static inline void mips_syscall_update_nr(struct task_struct *task,
+					  struct pt_regs *regs)
+{
+	/*
+	 * v0 is the system call number, except for O32 ABI syscall(), where it
+	 * ends up in a0.
+	 */
+	if (mips_syscall_is_indirect(task, regs))
+		task_thread_info(task)->syscall = regs->regs[4];
+	else
+		task_thread_info(task)->syscall = regs->regs[2];
+}
+
 static inline unsigned long mips_get_syscall_arg(unsigned long *arg,
 	struct task_struct *task, struct pt_regs *regs, unsigned int n)
 {
@@ -98,10 +120,9 @@ static inline void syscall_get_arguments(struct task_struct *task,
 					 unsigned long *args)
 {
 	int ret;
-	/* O32 ABI syscall() - Either 64-bit with O32 or 32-bit */
-	if ((IS_ENABLED(CONFIG_32BIT) ||
-	    test_tsk_thread_flag(task, TIF_32BIT_REGS)) &&
-	    (regs->regs[2] == __NR_syscall))
+
+	/* O32 ABI syscall() */
+	if (mips_syscall_is_indirect(task, regs))
 		i++;
 
 	while (n--)
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index be5d5fefcc7c..465fc5633e61 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -144,6 +144,9 @@ int ptrace_setregs(struct task_struct *child, struct user_pt_regs __user *data)
 
 	/* badvaddr, status, and cause may not be written.  */
 
+	/* System call number may have been changed */
+	mips_syscall_update_nr(child, regs);
+
 	return 0;
 }
 
@@ -345,6 +348,9 @@ static int gpr32_set(struct task_struct *target,
 		}
 	}
 
+	/* System call number may have been changed */
+	mips_syscall_update_nr(target, regs);
+
 	return 0;
 }
 
@@ -405,6 +411,9 @@ static int gpr64_set(struct task_struct *target,
 		}
 	}
 
+	/* System call number may have been changed */
+	mips_syscall_update_nr(target, regs);
+
 	return 0;
 }
 
@@ -753,6 +762,12 @@ long arch_ptrace(struct task_struct *child, long request,
 		switch (addr) {
 		case 0 ... 31:
 			regs->regs[addr] = data;
+			/* System call number may have been changed */
+			if (addr == 2)
+				mips_syscall_update_nr(child, regs);
+			else if (addr == 4 &&
+				 mips_syscall_is_indirect(child, regs))
+				mips_syscall_update_nr(child, regs);
 			break;
 		case FPR_BASE ... FPR_BASE + 31: {
 			union fpureg *fregs = get_fpu_regs(child);
diff --git a/arch/mips/kernel/ptrace32.c b/arch/mips/kernel/ptrace32.c
index 40e212d6b26b..2b9260f92ccd 100644
--- a/arch/mips/kernel/ptrace32.c
+++ b/arch/mips/kernel/ptrace32.c
@@ -33,6 +33,7 @@
 #include <asm/pgtable.h>
 #include <asm/page.h>
 #include <asm/reg.h>
+#include <asm/syscall.h>
 #include <linux/uaccess.h>
 #include <asm/bootinfo.h>
 
@@ -195,6 +196,12 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 		switch (addr) {
 		case 0 ... 31:
 			regs->regs[addr] = data;
+			/* System call number may have been changed */
+			if (addr == 2)
+				mips_syscall_update_nr(child, regs);
+			else if (addr == 4 &&
+				 mips_syscall_is_indirect(child, regs))
+				mips_syscall_update_nr(child, regs);
 			break;
 		case FPR_BASE ... FPR_BASE + 31: {
 			union fpureg *fregs = get_fpu_regs(child);
-- 
2.13.2
