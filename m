Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jan 2006 19:13:48 +0000 (GMT)
Received: from smtp.gentoo.org ([134.68.220.30]:50075 "EHLO smtp.gentoo.org")
	by ftp.linux-mips.org with ESMTP id S8133532AbWAXTN3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Jan 2006 19:13:29 +0000
Received: from kumba by smtp.gentoo.org with local (Exim 4.54)
	id 1F1Tfh-000309-Sf
	for linux-mips@linux-mips.org; Tue, 24 Jan 2006 19:17:41 +0000
Date:	Tue, 24 Jan 2006 19:17:41 +0000
From:	Kumba <kumba@gentoo.org>
To:	linux-mips@linux-mips.org
Subject: Re: [PATCH]: Fix N32 sigsuspend syscall that causes non-fatal oopses
Message-ID: <20060124191741.GB31197@toucan.gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tqI+Z3u+9OQ7kwn0"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10107
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips


--tqI+Z3u+9OQ7kwn0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fix to the sigsuspend syscall so N32 userlands work without triggering
non-fatal oopses.  Patch was originally drafted by Daniel Jacobwitz.

Problem was originally discovered via a configure test in the glib
package.  When run, the test triggered a segmentation fault and an
oops, as well as causing the test, and ultimately, configure, to fail.

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
---

 linux32.c     |   19 -------------------
 scall64-n32.S |    4 ++--
 signal.c      |   42 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 21 deletions(-)


--tqI+Z3u+9OQ7kwn0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="n32-fix-sigsuspend.patch"

diff -Naurp mipslinux/arch/mips/kernel/linux32.c mipslinux-sigsuspend/arch/mips/kernel/linux32.c
--- mipslinux/arch/mips/kernel/linux32.c	2006-01-22 21:14:11.000000000 -0500
+++ mipslinux-sigsuspend/arch/mips/kernel/linux32.c	2006-01-24 13:39:37.000000000 -0500
@@ -1450,25 +1450,6 @@ sys32_timer_create(u32 clock, struct sig
 	return sys_timer_create(clock, p, timer_id);
 }
 
-asmlinkage long
-sysn32_rt_sigtimedwait(const sigset_t __user *uthese,
-		       siginfo_t __user *uinfo,
-		       const struct compat_timespec __user *uts32,
-		       size_t sigsetsize)
-{
-	struct timespec __user *uts = NULL;
-
-	if (uts32) {
-		struct timespec ts;
-		uts = compat_alloc_user_space(sizeof(struct timespec));
-		if (get_user(ts.tv_sec, &uts32->tv_sec) ||
-		    get_user(ts.tv_nsec, &uts32->tv_nsec) ||
-		    copy_to_user (uts, &ts, sizeof (ts)))
-			return -EFAULT;
-	}
-	return sys_rt_sigtimedwait(uthese, uinfo, uts, sigsetsize);
-}
-
 save_static_function(sys32_clone);
 __attribute_used__ noinline static int
 _sys32_clone(nabi_no_regargs struct pt_regs regs)
diff -Naurp mipslinux/arch/mips/kernel/scall64-n32.S mipslinux-sigsuspend/arch/mips/kernel/scall64-n32.S
--- mipslinux/arch/mips/kernel/scall64-n32.S	2006-01-22 21:14:11.000000000 -0500
+++ mipslinux-sigsuspend/arch/mips/kernel/scall64-n32.S	2006-01-24 13:39:37.000000000 -0500
@@ -245,9 +245,9 @@ EXPORT(sysn32_call_table)
 	PTR	sys_capget
 	PTR	sys_capset
 	PTR	sys32_rt_sigpending		/* 6125 */
-	PTR	sysn32_rt_sigtimedwait
+	PTR	compat_sys_rt_sigtimedwait
 	PTR	sys_rt_sigqueueinfo
-	PTR	sys32_rt_sigsuspend
+	PTR	sysn32_rt_sigsuspend
 	PTR	sys32_sigaltstack
 	PTR	compat_sys_utime		/* 6130 */
 	PTR	sys_mknod
diff -Naurp mipslinux/arch/mips/kernel/signal.c mipslinux-sigsuspend/arch/mips/kernel/signal.c
--- mipslinux/arch/mips/kernel/signal.c	2006-01-22 21:14:11.000000000 -0500
+++ mipslinux-sigsuspend/arch/mips/kernel/signal.c	2006-01-24 13:39:37.000000000 -0500
@@ -21,6 +21,7 @@
 #include <linux/ptrace.h>
 #include <linux/unistd.h>
 #include <linux/compiler.h>
+#include <linux/compat.h>
 
 #include <asm/abi.h>
 #include <asm/asm.h>
@@ -39,6 +40,10 @@
 
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
+#ifdef CONFIG_MIPS32_N32
+extern void sigset_from_compat (sigset_t *set, compat_sigset_t *compat);
+#endif
+
 int do_signal(sigset_t *oldset, struct pt_regs *regs);
 
 /*
@@ -109,6 +114,43 @@ _sys_rt_sigsuspend(nabi_no_regargs struc
 	}
 }
 
+#ifdef CONFIG_MIPS32_N32
+save_static_function(sysn32_rt_sigsuspend);
+__attribute_used__ noinline static int
+_sysn32_rt_sigsuspend(nabi_no_regargs struct pt_regs regs)
+{
+	sigset_t saveset, newset;
+	compat_sigset_t __user *unewset, uset;
+	size_t sigsetsize;
+
+	/* XXX Don't preclude handling different sized sigset_t's.  */
+	sigsetsize = regs.regs[5];
+	if (sigsetsize != sizeof(sigset_t))
+		return -EINVAL;
+
+	unewset = (compat_sigset_t __user *) regs.regs[4];
+	if (copy_from_user(&uset, unewset, sizeof(uset)))
+		return -EFAULT;
+	sigset_from_compat (&newset, &uset);
+	sigdelsetmask(&newset, ~_BLOCKABLE);
+
+	spin_lock_irq(&current->sighand->siglock);
+	saveset = current->blocked;
+	current->blocked = newset;
+        recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
+
+	regs.regs[2] = EINTR;
+	regs.regs[7] = 1;
+	while (1) {
+		current->state = TASK_INTERRUPTIBLE;
+		schedule();
+		if (do_signal(&saveset, &regs))
+			return -EINTR;
+	}
+}
+#endif
+
 #ifdef CONFIG_TRAD_SIGNALS
 asmlinkage int sys_sigaction(int sig, const struct sigaction *act,
 	struct sigaction *oact)

--tqI+Z3u+9OQ7kwn0--
