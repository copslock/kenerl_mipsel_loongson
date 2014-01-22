Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Jan 2014 15:45:13 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:24636 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6870555AbaAVOl4w5UvV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 22 Jan 2014 15:41:56 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 7/8] MIPS: seccomp: Handle indirect system calls (o32)
Date:   Wed, 22 Jan 2014 14:40:03 +0000
Message-ID: <1390401604-11830-8-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1390401604-11830-1-git-send-email-markos.chandras@imgtec.com>
References: <1390401604-11830-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_22_14_40_39
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39062
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

When userland uses syscall() to perform an indirect system call
the actually system call that needs to be checked by the filter
is on the first argument. The kernel code needs to handle this case
by looking at the original syscall number in v0 and if it's
NR_syscall, then it needs to examine the first argument to
identify the real system call that will be executed.
Similarly, we need to 'virtually' shift the syscall() arguments
so the syscall_get_arguments() function can fetch the correct
arguments for the indirect system call.

Reviewed-by: James Hogan <james.hogan@imgtec.com>
Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/ptrace.h  |  2 +-
 arch/mips/include/asm/syscall.h | 20 +++++++++++++++++++-
 arch/mips/kernel/ptrace.c       |  3 +--
 arch/mips/kernel/scall32-o32.S  | 11 ++++++++++-
 arch/mips/kernel/scall64-64.S   |  1 +
 arch/mips/kernel/scall64-n32.S  |  1 +
 arch/mips/kernel/scall64-o32.S  | 13 ++++++++++++-
 7 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
index 84257df..bf1ac8d3 100644
--- a/arch/mips/include/asm/ptrace.h
+++ b/arch/mips/include/asm/ptrace.h
@@ -82,7 +82,7 @@ static inline long regs_return_value(struct pt_regs *regs)
 #define instruction_pointer(regs) ((regs)->cp0_epc)
 #define profile_pc(regs) instruction_pointer(regs)
 
-extern asmlinkage long syscall_trace_enter(struct pt_regs *regs);
+extern asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall);
 extern asmlinkage void syscall_trace_leave(struct pt_regs *regs);
 
 extern void die(const char *, struct pt_regs *) __noreturn;
diff --git a/arch/mips/include/asm/syscall.h b/arch/mips/include/asm/syscall.h
index e7e0210..3073978 100644
--- a/arch/mips/include/asm/syscall.h
+++ b/arch/mips/include/asm/syscall.h
@@ -19,11 +19,22 @@
 #include <linux/sched.h>
 #include <linux/uaccess.h>
 #include <asm/ptrace.h>
+#include <asm/unistd.h>
+
+#ifndef __NR_syscall /* Only defined if _MIPS_SIM == _MIPS_SIM_ABI32 */
+#define __NR_syscall 4000
+#endif
 
 static inline long syscall_get_nr(struct task_struct *task,
 				  struct pt_regs *regs)
 {
-	return regs->regs[2];
+	/* O32 ABI syscall() - Either 64-bit with O32 or 32-bit */
+	if ((config_enabled(CONFIG_32BIT) ||
+	    test_tsk_thread_flag(task, TIF_32BIT_REGS)) &&
+	    (regs->regs[2] == __NR_syscall))
+		return regs->regs[4];
+	else
+		return regs->regs[2];
 }
 
 static inline unsigned long mips_get_syscall_arg(unsigned long *arg,
@@ -90,6 +101,13 @@ static inline void syscall_get_arguments(struct task_struct *task,
 					 unsigned long *args)
 {
 	int ret;
+	/* O32 ABI syscall() - Either 64-bit with O32 or 32-bit */
+	if ((config_enabled(CONFIG_32BIT) ||
+	    test_tsk_thread_flag(task, TIF_32BIT_REGS)) &&
+	    (regs->regs[2] == __NR_syscall)) {
+		i++;
+		n++;
+	}
 
 	while (n--)
 		ret |= mips_get_syscall_arg(args++, task, regs, i++);
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 7f9bcaa..a17a702 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -662,9 +662,8 @@ long arch_ptrace(struct task_struct *child, long request,
  * Notification of system call entry/exit
  * - triggered by current->work.syscall_trace
  */
-asmlinkage long syscall_trace_enter(struct pt_regs *regs)
+asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall)
 {
-	long syscall = regs->regs[2];
 	long ret = 0;
 	user_exit();
 
diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index ce6a1cc..0b1d70e 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -118,7 +118,16 @@ syscall_trace_entry:
 	SAVE_STATIC
 	move	s0, t2
 	move	a0, sp
-	jal	syscall_trace_enter
+
+	/*
+	 * syscall number is in v0 unless we called syscall(__NR_###)
+	 * where the real syscall number is in a0
+	 */
+	addiu	a1, v0,  __NR_O32_Linux
+	bnez	v0, 1f /* __NR_syscall at offset 0 */
+	lw	a1, PT_R4(sp)
+
+1:	jal	syscall_trace_enter
 
 	bltz	v0, 2f			# seccomp failed? Skip syscall
 
diff --git a/arch/mips/kernel/scall64-64.S b/arch/mips/kernel/scall64-64.S
index 88372a1..3d59f12 100644
--- a/arch/mips/kernel/scall64-64.S
+++ b/arch/mips/kernel/scall64-64.S
@@ -80,6 +80,7 @@ syscall_trace_entry:
 	SAVE_STATIC
 	move	s0, t2
 	move	a0, sp
+	daddiu	a1, v0, __NR_64_Linux
 	jal	syscall_trace_enter
 
 	bltz	v0, 2f			# seccomp failed? Skip syscall
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index d79d880..1dd21e5 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -72,6 +72,7 @@ n32_syscall_trace_entry:
 	SAVE_STATIC
 	move	s0, t2
 	move	a0, sp
+	daddiu	a1, v0, __NR_N32_Linux
 	jal	syscall_trace_enter
 
 	bltz	v0, 2f			# seccomp failed? Skip syscall
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index 375a72b..4405f5a 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -112,7 +112,18 @@ trace_a_syscall:
 
 	move	s0, t2			# Save syscall pointer
 	move	a0, sp
-	jal	syscall_trace_enter
+	/*
+	 * syscall number is in v0 unless we called syscall(__NR_###)
+	 * where the real syscall number is in a0
+	 * note: NR_syscall is the first O32 syscall but the macro is
+	 * only defined when compiling with -mabi=32 (CONFIG_32BIT)
+	 * therefore __NR_O32_Linux is used (4000)
+	 */
+	addiu	a1, v0,  __NR_O32_Linux
+	bnez	v0, 1f /* __NR_syscall at offset 0 */
+	lw	a1, PT_R4(sp)
+
+1:	jal	syscall_trace_enter
 
 	bltz	v0, 2f			# seccomp failed? Skip syscall
 
-- 
1.8.5.3
