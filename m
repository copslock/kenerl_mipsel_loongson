Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Aug 2008 15:50:04 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:42918 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28577545AbYHQOtc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 17 Aug 2008 15:49:32 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KUjZR-0000uc-01; Sun, 17 Aug 2008 16:49:29 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 0425BC3F17; Sun, 17 Aug 2008 16:49:25 +0200 (CEST)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] Use compat_sys_ptrace
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20080817144926.0425BC3F17@solo.franken.de>
Date:	Sun, 17 Aug 2008 16:49:25 +0200 (CEST)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20239
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

This replaces mips's sys_ptrace32 with a compat_arch_ptrace and
enables the new generic definition of compat_sys_ptrace instead.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 arch/mips/kernel/ptrace32.c    |   43 +++++++--------------------------------
 arch/mips/kernel/scall64-n32.S |    2 +-
 arch/mips/kernel/scall64-o32.S |    2 +-
 arch/mips/kernel/signal32.c    |   12 +++++++++++
 include/asm-mips/ptrace.h      |    3 ++
 5 files changed, 25 insertions(+), 37 deletions(-)

diff --git a/arch/mips/kernel/ptrace32.c b/arch/mips/kernel/ptrace32.c
index 76818be..cac56a8 100644
--- a/arch/mips/kernel/ptrace32.c
+++ b/arch/mips/kernel/ptrace32.c
@@ -15,6 +15,7 @@
  * binaries.
  */
 #include <linux/compiler.h>
+#include <linux/compat.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
@@ -46,37 +47,13 @@ int ptrace_setfpregs(struct task_struct *child, __u32 __user *data);
  * Tracing a 32-bit process with a 64-bit strace and vice versa will not
  * work.  I don't know how to fix this.
  */
-asmlinkage int sys32_ptrace(int request, int pid, int addr, int data)
+long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
+			compat_ulong_t caddr, compat_ulong_t cdata)
 {
-	struct task_struct *child;
+	int addr = caddr;
+	int data = cdata;
 	int ret;
 
-#if 0
-	printk("ptrace(r=%d,pid=%d,addr=%08lx,data=%08lx)\n",
-	       (int) request, (int) pid, (unsigned long) addr,
-	       (unsigned long) data);
-#endif
-	lock_kernel();
-	if (request == PTRACE_TRACEME) {
-		ret = ptrace_traceme();
-		goto out;
-	}
-
-	child = ptrace_get_task_struct(pid);
-	if (IS_ERR(child)) {
-		ret = PTR_ERR(child);
-		goto out;
-	}
-
-	if (request == PTRACE_ATTACH) {
-		ret = ptrace_attach(child);
-		goto out_tsk;
-	}
-
-	ret = ptrace_check_attach(child, request == PTRACE_KILL);
-	if (ret < 0)
-		goto out_tsk;
-
 	switch (request) {
 	/* when I and D space are separate, these will need to be fixed. */
 	case PTRACE_PEEKTEXT: /* read word at location addr. */
@@ -214,7 +191,7 @@ asmlinkage int sys32_ptrace(int request, int pid, int addr, int data)
 			if (!cpu_has_dsp) {
 				tmp = 0;
 				ret = -EIO;
-				goto out_tsk;
+				goto out;
 			}
 			dregs = __get_dsp_regs(child);
 			tmp = (unsigned long) (dregs[addr - DSP_BASE]);
@@ -224,14 +201,14 @@ asmlinkage int sys32_ptrace(int request, int pid, int addr, int data)
 			if (!cpu_has_dsp) {
 				tmp = 0;
 				ret = -EIO;
-				goto out_tsk;
+				goto out;
 			}
 			tmp = child->thread.dsp.dspcontrol;
 			break;
 		default:
 			tmp = 0;
 			ret = -EIO;
-			goto out_tsk;
+			goto out;
 		}
 		ret = put_user(tmp, (unsigned __user *) (unsigned long) data);
 		break;
@@ -414,10 +391,6 @@ asmlinkage int sys32_ptrace(int request, int pid, int addr, int data)
 		ret = ptrace_request(child, request, addr, data);
 		break;
 	}
-
-out_tsk:
-	put_task_struct(child);
 out:
-	unlock_kernel();
 	return ret;
 }
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index da7f1b6..324c549 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -219,7 +219,7 @@ EXPORT(sysn32_call_table)
 	PTR	compat_sys_getrusage
 	PTR	compat_sys_sysinfo
 	PTR	compat_sys_times
-	PTR	sys32_ptrace
+	PTR	compat_sys_ptrace
 	PTR	sys_getuid			/* 6100 */
 	PTR	sys_syslog
 	PTR	sys_getgid
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index d7cd1aa..85fedac 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -231,7 +231,7 @@ sys_call_table:
 	PTR	sys_setuid
 	PTR	sys_getuid
 	PTR	compat_sys_stime		/* 4025 */
-	PTR	sys32_ptrace
+	PTR	compat_sys_ptrace
 	PTR	sys_alarm
 	PTR	sys_ni_syscall			/* was sys_fstat */
 	PTR	sys_pause
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index 572c610..652709b 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -482,6 +482,18 @@ int copy_siginfo_to_user32(compat_siginfo_t __user *to, siginfo_t *from)
 	return err;
 }
 
+int copy_siginfo_from_user32(siginfo_t *to, compat_siginfo_t __user *from)
+{
+	memset(to, 0, sizeof *to);
+
+	if (copy_from_user(to, from, 3*sizeof(int)) ||
+	    copy_from_user(to->_sifields._pad,
+			   from->_sifields._pad, SI_PAD_SIZE32))
+		return -EFAULT;
+
+	return 0;
+}
+
 asmlinkage void sys32_sigreturn(nabi_no_regargs struct pt_regs regs)
 {
 	struct sigframe32 __user *frame;
diff --git a/include/asm-mips/ptrace.h b/include/asm-mips/ptrace.h
index 786f7e3..c00cca2 100644
--- a/include/asm-mips/ptrace.h
+++ b/include/asm-mips/ptrace.h
@@ -9,6 +9,9 @@
 #ifndef _ASM_PTRACE_H
 #define _ASM_PTRACE_H
 
+#ifdef CONFIG_64BIT
+#define __ARCH_WANT_COMPAT_SYS_PTRACE
+#endif
 
 /* 0 - 31 are integer registers, 32 - 63 are fp registers.  */
 #define FPR_BASE	32
