Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2006 03:26:04 +0100 (BST)
Received: from sccrmhc11.comcast.net ([63.240.77.81]:37279 "EHLO
	sccrmhc11.comcast.net") by ftp.linux-mips.org with ESMTP
	id S8126480AbWFHCZw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Jun 2006 03:25:52 +0100
Received: from [127.0.0.1] (unknown[69.140.185.142])
          by comcast.net (sccrmhc11) with ESMTP
          id <2006060802254201100fobdde>; Thu, 8 Jun 2006 02:25:46 +0000
Message-ID: <44878AAA.20007@gentoo.org>
Date:	Wed, 07 Jun 2006 22:25:46 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To:	"Joseph S. Myers" <joseph@codesourcery.com>
CC:	linux-mips@linux-mips.org
Subject: Re: N32 sigset and __COMPAT_ENDIAN_SWAP__
References: <Pine.LNX.4.64.0606080134480.26638@digraph.polyomino.org.uk>
In-Reply-To: <Pine.LNX.4.64.0606080134480.26638@digraph.polyomino.org.uk>
Content-Type: multipart/mixed;
 boundary="------------020308000807030801070508"
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11695
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------020308000807030801070508
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Joseph S. Myers wrote:
> I'm testing glibc on MIPS64, little-endian, N32, O32 and N64
> multilibs.
> 
> Among the NPTL test failures seen are some arising from sigsuspend
> problems for N32: it blocks the wrong signals, so SIGCANCEL (SIGRTMIN)
> is blocked despite glibc's carefully excluding it from sets of signals
> to block.  Specifically, testing suggests it blocks signal N^32
> instead of signal N, so (in the example tested) blocking SIGUSR1 (17)
> blocks signal 49 instead.
> 
> glibc's sigset_t uses an array of unsigned long, as does the kernel.
> In both cases, signal N+1 is represented as
> (1UL << (N % (8 * sizeof (unsigned long)))) in word number
> (N / (8 * sizeof (unsigned long))).
> 
> Thus the N32 glibc uses an array of 32-bit words and the N64 kernel
> uses an array of 64-bit words.  For little-endian, the layout is the
> same, with signals 1-32 in the first 4 bytes, signals 33-64 in the
> second, etc.; for big-endian, userspace has that layout while in the
> kernel each 8 bytes have the two halves swapped from the userspace
> layout.
> 
> The N32 sigsuspend syscall uses sigset_from_compat to convert the
> userspace sigset to kernel format.  If __COMPAT_ENDIAN_SWAP__ is *not*
> set, this uses logic of the form
> 
>   set->sig[0] = compat->sig[0] | (((long)compat->sig[1]) << 32 )
> 
> to convert the userspace sigset to a kernel one.  This looks correct
> to me for both big and little endian, given that in userspace
> compat->sig[1] will represent signals 33-64, and so will the high 32
> bits of set->sig[0] in the kernel.  If however __COMPAT_ENDIAN_SWAP__
> *is* set, as it is for __MIPSEL__, it uses
> 
>   set->sig[0] = compat->sig[1] | (((long)compat->sig[0]) << 32 );
> 
> which seems incorrect for both big and little endian, and would
> explain the observed symptoms.
> 
> This code is the only use of __COMPAT_ENDIAN_SWAP__, so if incorrect
> then that macro serves no purpose, in which case something like the
> following patch would seem appropriate to remove it.



You might find the attached patch of interest.

We've been using it gentoo-side for awhile now, as it allowed some N32 programs 
to work correctly.  Namely, a configure test in glib would trigger a non-fatal 
oops in the kernel due to an issue this patch fixes.  Daniel Jacobwitz wrote it 
up when he apparently stumbled across the issue (something wonky in n32's 
sigsuspend, as the name indicates.  I forget the specifics, though), but I'm 
unsure if the issue is in any way connected to what you're seeing as well.


--Kumba

-- 
Gentoo/MIPS Team Lead
Gentoo Foundation Board of Trustees

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond

--------------020308000807030801070508
Content-Type: text/plain;
 name="misc-2.6.13-n32-fix-sigsuspend.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="misc-2.6.13-n32-fix-sigsuspend.patch"

diff -Naurp linux-2.6.13.3.orig/arch/mips/kernel/linux32.c linux-2.6.13.3/arch/mips/kernel/linux32.c
--- linux-2.6.13.3.orig/arch/mips/kernel/linux32.c	2005-10-05 22:46:31.000000000 -0400
+++ linux-2.6.13.3/arch/mips/kernel/linux32.c	2005-10-05 22:34:45.000000000 -0400
@@ -1453,25 +1453,6 @@ sys32_timer_create(u32 clock, struct sig
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
diff -Naurp linux-2.6.13.3.orig/arch/mips/kernel/scall64-n32.S linux-2.6.13.3/arch/mips/kernel/scall64-n32.S
--- linux-2.6.13.3.orig/arch/mips/kernel/scall64-n32.S	2005-10-05 22:46:31.000000000 -0400
+++ linux-2.6.13.3/arch/mips/kernel/scall64-n32.S	2005-10-05 22:34:45.000000000 -0400
@@ -243,9 +243,9 @@ EXPORT(sysn32_call_table)
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
diff -Naurp linux-2.6.13.3.orig/arch/mips/kernel/signal.c linux-2.6.13.3/arch/mips/kernel/signal.c
--- linux-2.6.13.3.orig/arch/mips/kernel/signal.c	2005-10-05 22:46:31.000000000 -0400
+++ linux-2.6.13.3/arch/mips/kernel/signal.c	2005-10-05 22:47:07.000000000 -0400
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

--------------020308000807030801070508--
