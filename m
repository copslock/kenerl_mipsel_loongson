Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2006 10:58:18 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:24330 "EHLO
	bacchus.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133677AbWBTK4J (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Feb 2006 10:56:09 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k1KB1Gwn005775;
	Mon, 20 Feb 2006 11:01:24 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k1IMhHj7004381;
	Sat, 18 Feb 2006 22:43:17 GMT
Date:	Sat, 18 Feb 2006 22:43:17 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Daniel Jacobowitz <dan@debian.org>
Cc:	Kumba <kumba@gentoo.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH]: Fix N32 sigsuspend syscall that causes non-fatal oopses
Message-ID: <20060218224316.GC3950@linux-mips.org>
References: <20060124191741.GB31197@toucan.gentoo.org> <20060124193459.GA24479@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060124193459.GA24479@nevyn.them.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10549
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 24, 2006 at 02:34:59PM -0500, Daniel Jacobowitz wrote:

> If you're going to mess around with sigsuspend, there's a better option
> now: take a look at the recently added TIF_RESTORE_SIGMASK (committed
> last week).
> 
> Everyone really should migrate over to that approach; it fixes (among
> other things) a nasty debugging corner case and some code duplication.

The patch as posted doesn't even compile anymore.  It was adding some
N32-specific stuff into signal.c where it has no business - there is
signal_n32.c after all.  So if fixed those things also.  New patch below.

Kumba, I'm going to check this patch in, can you test this asap please?

Thanks,

  Ralf

diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
index 60353f5..9996b6e 100644
--- a/arch/mips/kernel/linux32.c
+++ b/arch/mips/kernel/linux32.c
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
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index bc4980c..d87b544 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
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
diff --git a/arch/mips/kernel/signal_n32.c b/arch/mips/kernel/signal_n32.c
index 5a37760..3e168c0 100644
--- a/arch/mips/kernel/signal_n32.c
+++ b/arch/mips/kernel/signal_n32.c
@@ -81,6 +81,39 @@ struct rt_sigframe_n32 {
 #endif
 };
 
+extern void sigset_from_compat (sigset_t *set, compat_sigset_t *compat);
+
+save_static_function(sysn32_rt_sigsuspend);
+__attribute_used__ noinline static int
+_sysn32_rt_sigsuspend(nabi_no_regargs struct pt_regs regs)
+{
+	compat_sigset_t __user *unewset, uset;
+	size_t sigsetsize;
+	sigset_t newset;
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
+	current->saved_sigmask = current->blocked;
+	current->blocked = newset;
+        recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
+
+	current->state = TASK_INTERRUPTIBLE;
+	schedule();
+	set_thread_flag(TIF_RESTORE_SIGMASK);
+	return -ERESTARTNOHAND;
+}
+
 save_static_function(sysn32_rt_sigreturn);
 __attribute_used__ noinline static void
 _sysn32_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
diff --git a/kernel/compat.c b/kernel/compat.c
