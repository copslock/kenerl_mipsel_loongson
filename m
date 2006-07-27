Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jul 2006 00:44:57 +0100 (BST)
Received: from wx-out-0102.google.com ([66.249.82.203]:45868 "EHLO
	wx-out-0102.google.com") by ftp.linux-mips.org with ESMTP
	id S8133593AbWG0Xop (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Jul 2006 00:44:45 +0100
Received: by wx-out-0102.google.com with SMTP id i31so1434591wxd
        for <linux-mips@linux-mips.org>; Thu, 27 Jul 2006 16:44:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type;
        b=jKxEM1mvRZvAxmKfnN5C3TfnGUATRG3NwuSyC/OUyFQJI1a0+JU9b4kAHUHSlChnqC+DqbQ8HBgKrWl5A5TSK5a/rn6vNUs2KDWLSSFWSs7AzyZkUs5UhcZSVvOt5YUwZNXHfW8ZyUrg5nhfeQzylEEjBr0AO/dnoyhEJZEOtV8=
Received: by 10.70.21.10 with SMTP id 10mr1247372wxu;
        Thu, 27 Jul 2006 16:44:45 -0700 (PDT)
Received: from ?10.0.1.104? ( [71.243.124.123])
        by mx.gmail.com with ESMTP id h16sm963784wxd.2006.07.27.16.44.43;
        Thu, 27 Jul 2006 16:44:44 -0700 (PDT)
Message-ID: <44C94FEA.1010607@gmail.com>
Date:	Thu, 27 Jul 2006 19:44:42 -0400
From:	Peter Watkins <treestem@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050831)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [PATCH] Use compat code to translate siginfo_t for N32
Content-Type: multipart/mixed;
 boundary="------------030007040606060806020005"
Return-Path: <treestem@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12104
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: treestem@gmail.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------030007040606060806020005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


This patch fixes incorrect data returned from waitid() for mips64el N32. 
It uses compat code to translate siginfo_t for N32, and factors out 
common O32 and N32 compat code for siginfo_t, to compat32.c. Tested on 
glibc suite and LTP.






--------------030007040606060806020005
Content-Type: text/plain;
 name="patch-siginfo-2.6.18-rc1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-siginfo-2.6.18-rc1"

From: Peter Watkins <treestem@gmail.com>
Date: Thu, 27 Jul 2006 19:13:09 -0400
Subject: Use compat code to translate siginfo_t for N32.
Use compat code to translate siginfo_t for N32.
Factor out common O32 and N32 compat code for siginfo_t, to compat32.c.
---
 arch/mips/kernel/Makefile     |    4 +-
 arch/mips/kernel/compat32.c   |   88 +++++++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/compat32.h   |   76 +++++++++++++++++++++++++++++++++++
 arch/mips/kernel/linux32.c    |   28 -------------
 arch/mips/kernel/signal32.c   |   52 ------------------------
 arch/mips/kernel/signal_n32.c |   37 ++++++++++++++++-
 6 files changed, 200 insertions(+), 85 deletions(-)

diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 881c467..108171a 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -56,8 +56,8 @@ obj-$(CONFIG_32BIT)		+= scall32-o32.o
 obj-$(CONFIG_64BIT)		+= scall64-64.o
 obj-$(CONFIG_BINFMT_IRIX)	+= binfmt_irix.o
 obj-$(CONFIG_MIPS32_COMPAT)	+= linux32.o signal32.o
-obj-$(CONFIG_MIPS32_N32)	+= binfmt_elfn32.o scall64-n32.o signal_n32.o
-obj-$(CONFIG_MIPS32_O32)	+= binfmt_elfo32.o scall64-o32.o ptrace32.o
+obj-$(CONFIG_MIPS32_N32)	+= binfmt_elfn32.o scall64-n32.o signal_n32.o compat32.o
+obj-$(CONFIG_MIPS32_O32)	+= binfmt_elfo32.o scall64-o32.o ptrace32.o compat32.o
 
 obj-$(CONFIG_KGDB)		+= gdb-low.o gdb-stub.o
 obj-$(CONFIG_PROC_FS)		+= proc.o
diff --git a/arch/mips/kernel/compat32.c b/arch/mips/kernel/compat32.c
new file mode 100644
index 0000000..858f7db
--- /dev/null
+++ b/arch/mips/kernel/compat32.c
@@ -0,0 +1,88 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1991, 1992  Linus Torvalds
+ * Copyright (C) 1994 - 2000  Ralf Baechle
+ * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
+ */
+#include <linux/cache.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/smp.h>
+#include <linux/smp_lock.h>
+#include <linux/kernel.h>
+#include <linux/signal.h>
+#include <linux/syscalls.h>
+#include <linux/errno.h>
+#include <linux/wait.h>
+#include <linux/ptrace.h>
+#include <linux/compat.h>
+#include <linux/suspend.h>
+#include <linux/compiler.h>
+
+#include <asm/abi.h>
+#include <asm/asm.h>
+#include <linux/bitops.h>
+#include <asm/sim.h>
+#include <asm/uaccess.h>
+#include <asm/ucontext.h>
+#include <asm/system.h>
+#include <asm/fpu.h>
+#include <asm/war.h>
+
+#include "compat32.h"
+
+
+int copy_siginfo_to_user32(compat_siginfo_t *to, siginfo_t *from)
+{
+	int err;
+
+	if (!access_ok (VERIFY_WRITE, to, sizeof(compat_siginfo_t)))
+		return -EFAULT;
+
+	/* If you change siginfo_t structure, please be sure
+	   this code is fixed accordingly.
+	   It should never copy any pad contained in the structure
+	   to avoid security leaks, but must copy the generic
+	   3 ints plus the relevant union member.
+	   This routine must convert siginfo from 64bit to 32bit as well
+	   at the same time.  */
+	err = __put_user(from->si_signo, &to->si_signo);
+	err |= __put_user(from->si_errno, &to->si_errno);
+	err |= __put_user((short)from->si_code, &to->si_code);
+	if (from->si_code < 0)
+		err |= __copy_to_user(&to->_sifields._pad, &from->_sifields._pad, SI_PAD_SIZE);
+	else {
+		switch (from->si_code >> 16) {
+		case __SI_TIMER >> 16:
+			err |= __put_user(from->si_tid, &to->si_tid);
+			err |= __put_user(from->si_overrun, &to->si_overrun);
+			err |= __put_user(from->si_int, &to->si_int);
+			break;
+		case __SI_CHLD >> 16:
+			err |= __put_user(from->si_utime, &to->si_utime);
+			err |= __put_user(from->si_stime, &to->si_stime);
+			err |= __put_user(from->si_status, &to->si_status);
+		default:
+			err |= __put_user(from->si_pid, &to->si_pid);
+			err |= __put_user(from->si_uid, &to->si_uid);
+			break;
+		case __SI_FAULT >> 16:
+			err |= __put_user((long)from->si_addr, &to->si_addr);
+			break;
+		case __SI_POLL >> 16:
+			err |= __put_user(from->si_band, &to->si_band);
+			err |= __put_user(from->si_fd, &to->si_fd);
+			break;
+		case __SI_RT >> 16: /* This is not generated by the kernel as of now.  */
+		case __SI_MESGQ >> 16:
+			err |= __put_user(from->si_pid, &to->si_pid);
+			err |= __put_user(from->si_uid, &to->si_uid);
+			err |= __put_user(from->si_int, &to->si_int);
+			break;
+		}
+	}
+	return err;
+}
diff --git a/arch/mips/kernel/compat32.h b/arch/mips/kernel/compat32.h
new file mode 100644
index 0000000..e2bb23b
--- /dev/null
+++ b/arch/mips/kernel/compat32.h
@@ -0,0 +1,76 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1991, 1992  Linus Torvalds
+ * Copyright (C) 1994 - 2000  Ralf Baechle
+ * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
+ */
+
+#define SI_PAD_SIZE32   ((SI_MAX_SIZE/sizeof(int)) - 3)
+
+typedef struct compat_siginfo {
+	int si_signo;
+	int si_code;
+	int si_errno;
+
+	union {
+		int _pad[SI_PAD_SIZE32];
+
+		/* kill() */
+		struct {
+			compat_pid_t _pid;	/* sender's pid */
+			compat_uid_t _uid;	/* sender's uid */
+		} _kill;
+
+		/* SIGCHLD */
+		struct {
+			compat_pid_t _pid;	/* which child */
+			compat_uid_t _uid;	/* sender's uid */
+			int _status;		/* exit code */
+			compat_clock_t _utime;
+			compat_clock_t _stime;
+		} _sigchld;
+
+		/* IRIX SIGCHLD */
+		struct {
+			compat_pid_t _pid;	/* which child */
+			compat_clock_t _utime;
+			int _status;		/* exit code */
+			compat_clock_t _stime;
+		} _irix_sigchld;
+
+		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
+		struct {
+			s32 _addr; /* faulting insn/memory ref. */
+		} _sigfault;
+
+		/* SIGPOLL, SIGXFSZ (To do ...)  */
+		struct {
+			int _band;	/* POLL_IN, POLL_OUT, POLL_MSG */
+			int _fd;
+		} _sigpoll;
+
+		/* POSIX.1b timers */
+		struct {
+			timer_t _tid;		/* timer id */
+			int _overrun;		/* overrun count */
+			compat_sigval_t _sigval;/* same as below */
+			int _sys_private;       /* not to be passed to user */
+		} _timer;
+
+		/* POSIX.1b signals */
+		struct {
+			compat_pid_t _pid;	/* sender's pid */
+			compat_uid_t _uid;	/* sender's uid */
+			compat_sigval_t _sigval;
+		} _rt;
+
+	} _sifields;
+} compat_siginfo_t;
+
+
+
+int copy_siginfo_to_user32(compat_siginfo_t *to, siginfo_t *from);
+
diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
index 450ac59..dd71096 100644
--- a/arch/mips/kernel/linux32.c
+++ b/arch/mips/kernel/linux32.c
@@ -163,34 +163,6 @@ out:
 	return error;
 }
 
-asmlinkage long
-sysn32_waitid(int which, compat_pid_t pid,
-	      siginfo_t __user *uinfo, int options,
-	      struct compat_rusage __user *uru)
-{
-	struct rusage ru;
-	long ret;
-	mm_segment_t old_fs = get_fs();
-	int si_signo;
-
-	if (!access_ok(VERIFY_WRITE, uinfo, sizeof(*uinfo)))
-		return -EFAULT;
-
-	set_fs (KERNEL_DS);
-	ret = sys_waitid(which, pid, uinfo, options,
-			 uru ? (struct rusage __user *) &ru : NULL);
-	set_fs (old_fs);
-
-	if (__get_user(si_signo, &uinfo->si_signo))
-		return -EFAULT;
-	if (ret < 0 || si_signo == 0)
-		return ret;
-
-	if (uru)
-		ret = put_compat_rusage(&ru, uru);
-	return ret;
-}
-
 struct sysinfo32 {
         s32 uptime;
         u32 loads[3];
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index f32a229..2ba8c53 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -411,58 +411,6 @@ #if ICACHE_REFILLS_WORKAROUND_WAR
 #endif
 };
 
-int copy_siginfo_to_user32(compat_siginfo_t __user *to, siginfo_t *from)
-{
-	int err;
-
-	if (!access_ok (VERIFY_WRITE, to, sizeof(compat_siginfo_t)))
-		return -EFAULT;
-
-	/* If you change siginfo_t structure, please be sure
-	   this code is fixed accordingly.
-	   It should never copy any pad contained in the structure
-	   to avoid security leaks, but must copy the generic
-	   3 ints plus the relevant union member.
-	   This routine must convert siginfo from 64bit to 32bit as well
-	   at the same time.  */
-	err = __put_user(from->si_signo, &to->si_signo);
-	err |= __put_user(from->si_errno, &to->si_errno);
-	err |= __put_user((short)from->si_code, &to->si_code);
-	if (from->si_code < 0)
-		err |= __copy_to_user(&to->_sifields._pad, &from->_sifields._pad, SI_PAD_SIZE);
-	else {
-		switch (from->si_code >> 16) {
-		case __SI_TIMER >> 16:
-			err |= __put_user(from->si_tid, &to->si_tid);
-			err |= __put_user(from->si_overrun, &to->si_overrun);
-			err |= __put_user(from->si_int, &to->si_int);
-			break;
-		case __SI_CHLD >> 16:
-			err |= __put_user(from->si_utime, &to->si_utime);
-			err |= __put_user(from->si_stime, &to->si_stime);
-			err |= __put_user(from->si_status, &to->si_status);
-		default:
-			err |= __put_user(from->si_pid, &to->si_pid);
-			err |= __put_user(from->si_uid, &to->si_uid);
-			break;
-		case __SI_FAULT >> 16:
-			err |= __put_user((unsigned long)from->si_addr, &to->si_addr);
-			break;
-		case __SI_POLL >> 16:
-			err |= __put_user(from->si_band, &to->si_band);
-			err |= __put_user(from->si_fd, &to->si_fd);
-			break;
-		case __SI_RT >> 16: /* This is not generated by the kernel as of now.  */
-		case __SI_MESGQ >> 16:
-			err |= __put_user(from->si_pid, &to->si_pid);
-			err |= __put_user(from->si_uid, &to->si_uid);
-			err |= __put_user(from->si_int, &to->si_int);
-			break;
-		}
-	}
-	return err;
-}
-
 save_static_function(sys32_sigreturn);
 __attribute_used__ noinline static void
 _sys32_sigreturn(nabi_no_regargs struct pt_regs regs)
diff --git a/arch/mips/kernel/signal_n32.c b/arch/mips/kernel/signal_n32.c
index 477c533..f805bea 100644
--- a/arch/mips/kernel/signal_n32.c
+++ b/arch/mips/kernel/signal_n32.c
@@ -23,6 +23,7 @@ #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/kernel.h>
 #include <linux/signal.h>
+#include <linux/syscalls.h>
 #include <linux/errno.h>
 #include <linux/wait.h>
 #include <linux/ptrace.h>
@@ -41,6 +42,7 @@ #include <asm/cpu-features.h>
 #include <asm/war.h>
 
 #include "signal-common.h"
+#include "compat32.h"
 
 /*
  * Including <asm/unistd.h> would give use the 64-bit syscall numbers ...
@@ -74,7 +76,7 @@ #if ICACHE_REFILLS_WORKAROUND_WAR
 #else
 	u32 rs_code[2];			/* signal trampoline */
 #endif
-	struct siginfo rs_info;
+	compat_siginfo_t rs_info;
 	struct ucontextn32 rs_uc;
 #if ICACHE_REFILLS_WORKAROUND_WAR
 	u32 rs_code[8] ____cacheline_aligned;		/* signal trampoline */
@@ -180,7 +182,7 @@ int setup_rt_frame_n32(struct k_sigactio
 	install_sigtramp(frame->rs_code, __NR_N32_rt_sigreturn);
 
 	/* Create siginfo.  */
-	err |= copy_siginfo_to_user(&frame->rs_info, info);
+	err |= copy_siginfo_to_user32(&frame->rs_info, info);
 
 	/* Create the ucontext.  */
 	err |= __put_user(0, &frame->rs_uc.uc_flags);
@@ -215,7 +217,7 @@ int setup_rt_frame_n32(struct k_sigactio
 	regs->regs[31] = (unsigned long) frame->rs_code;
 	regs->cp0_epc = regs->regs[25] = (unsigned long) ka->sa.sa_handler;
 
-#if DEBUG_SIG
+#ifdef DEBUG_SIG
 	printk("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%p\n",
 	       current->comm, current->pid,
 	       frame, regs->cp0_epc, regs->regs[31]);
@@ -226,3 +228,32 @@ give_sigsegv:
 	force_sigsegv(signr, current);
 	return -EFAULT;
 }
+
+
+
+asmlinkage long
+sysn32_waitid(int which, compat_pid_t pid,
+	      compat_siginfo_t __user *uinfo, int options,
+	      struct compat_rusage __user *uru)
+{
+	siginfo_t info;
+	struct rusage ru;
+	long ret;
+	mm_segment_t old_fs = get_fs();
+
+	info.si_signo = 0;
+	set_fs (KERNEL_DS);
+	ret = sys_waitid(which, pid, (siginfo_t __user *) &info, options,
+			 uru ? (struct rusage __user *) &ru : NULL);
+	set_fs (old_fs);
+
+	if (ret < 0 || info.si_signo == 0)
+		return ret;
+
+	if (uru && (ret = put_compat_rusage(&ru, uru)))
+		return ret;
+
+	BUG_ON(info.si_code & __SI_MASK);
+	info.si_code |= __SI_CHLD;
+	return copy_siginfo_to_user32(uinfo, &info);
+}
-- 
1.4.1


--------------030007040606060806020005--
