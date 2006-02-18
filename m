Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Feb 2006 14:49:29 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:56847 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133525AbWBROtT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 18 Feb 2006 14:49:19 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id B551C64D59; Sat, 18 Feb 2006 14:56:01 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id EC2148D5D; Sat, 18 Feb 2006 14:55:45 +0000 (GMT)
Date:	Sat, 18 Feb 2006 14:55:45 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Ralf Baechle <ralf@linux-mips.org>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: Oops with git: do_signal32 on 64-bit
Message-ID: <20060218145545.GX20785@deprecation.cyrius.com>
References: <20060217191937.GA20521@deprecation.cyrius.com> <20060217225216.GA15781@deprecation.cyrius.com> <20060218.220701.25910111.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060218.220701.25910111.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10510
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Atsushi Nemoto <anemo@mba.ocn.ne.jp> [2006-02-18 22:07]:
> It seems following commit on 8 Feb broke signal32.c.
>     [MIPS] Add support for TIF_RESTORE_SIGMASK.
> Obviously do_signal32() was not synced.  I can not fix it by myself
> for a few days.  Someone?

Done now, and tested on Cobalt.


From: Martin Michlmayr <tbm@cyrius.com>

[PATCH] [MIPS] Add support for TIF_RESTORE_SIGMASK for signal32

Following the recent implementation of TIF_RESTORE_SIGMASK in
arch/mips/kernel/signal.c, 64-bit kernels with 32-bit user-land
compatibility oops when starting init.  signal32.c needs to be
converted to use TIF_RESTORE_SIGMASK too.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

---

 signal32.c |   68 ++++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 41 insertions(+), 27 deletions(-)

diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index 8a8b8dd..c070195 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -106,8 +106,6 @@ typedef struct compat_siginfo {
 
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
-extern int do_signal32(sigset_t *oldset, struct pt_regs *regs);
-
 /* 32-bit compatibility types */
 
 #define _NSIG_BPW32	32
@@ -198,7 +196,7 @@ __attribute_used__ noinline static int
 _sys32_sigsuspend(nabi_no_regargs struct pt_regs regs)
 {
 	compat_sigset_t *uset;
-	sigset_t newset, saveset;
+	sigset_t newset;
 
 	uset = (compat_sigset_t *) regs.regs[4];
 	if (get_sigset(&newset, uset))
@@ -206,19 +204,15 @@ _sys32_sigsuspend(nabi_no_regargs struct
 	sigdelsetmask(&newset, ~_BLOCKABLE);
 
 	spin_lock_irq(&current->sighand->siglock);
-	saveset = current->blocked;
+	current->saved_sigmask = current->blocked;
 	current->blocked = newset;
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
 
-	regs.regs[2] = EINTR;
-	regs.regs[7] = 1;
-	while (1) {
-		current->state = TASK_INTERRUPTIBLE;
-		schedule();
-		if (do_signal32(&saveset, &regs))
-			return -EINTR;
-	}
+	current->state = TASK_INTERRUPTIBLE;
+	schedule();
+	set_thread_flag(TIF_RESTORE_SIGMASK);
+	return -ERESTARTNOHAND;
 }
 
 save_static_function(sys32_rt_sigsuspend);
@@ -226,7 +220,7 @@ __attribute_used__ noinline static int
 _sys32_rt_sigsuspend(nabi_no_regargs struct pt_regs regs)
 {
 	compat_sigset_t *uset;
-	sigset_t newset, saveset;
+	sigset_t newset;
         size_t sigsetsize;
 
 	/* XXX Don't preclude handling different sized sigset_t's.  */
@@ -240,19 +234,15 @@ _sys32_rt_sigsuspend(nabi_no_regargs str
 	sigdelsetmask(&newset, ~_BLOCKABLE);
 
 	spin_lock_irq(&current->sighand->siglock);
-	saveset = current->blocked;
+	current->saved_sigmask = current->blocked;
 	current->blocked = newset;
         recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
 
-	regs.regs[2] = EINTR;
-	regs.regs[7] = 1;
-	while (1) {
-		current->state = TASK_INTERRUPTIBLE;
-		schedule();
-		if (do_signal32(&saveset, &regs))
-			return -EINTR;
-	}
+	current->state = TASK_INTERRUPTIBLE;
+	schedule();
+	set_thread_flag(TIF_RESTORE_SIGMASK);
+	return -ERESTARTNOHAND;
 }
 
 asmlinkage int sys32_sigaction(int sig, const struct sigaction32 *act,
@@ -783,7 +773,7 @@ static inline int handle_signal(unsigned
 		regs->regs[2] = EINTR;
 		break;
 	case ERESTARTSYS:
-		if(!(ka->sa.sa_flags & SA_RESTART)) {
+		if (!(ka->sa.sa_flags & SA_RESTART)) {
 			regs->regs[2] = EINTR;
 			break;
 		}
@@ -810,9 +800,10 @@ static inline int handle_signal(unsigned
 	return ret;
 }
 
-int do_signal32(sigset_t *oldset, struct pt_regs *regs)
+int do_signal32(struct pt_regs *regs)
 {
 	struct k_sigaction ka;
+	sigset_t *oldset;
 	siginfo_t info;
 	int signr;
 
@@ -827,12 +818,25 @@ int do_signal32(sigset_t *oldset, struct
 	if (try_to_freeze())
 		goto no_signal;
 
-	if (!oldset)
+	if (test_thread_flag(TIF_RESTORE_SIGMASK))
+		oldset = &current->saved_sigmask;
+	else
 		oldset = &current->blocked;
 
 	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
-	if (signr > 0)
-		return handle_signal(signr, &info, &ka, oldset, regs);
+	if (signr > 0) {
+		/* Whee! Actually deliver the signal. */
+		if (handle_signal(signr, &info, &ka, oldset, regs) == 0) {
+			/*
+			* A signal was successfully delivered; the saved
+			* sigmask will have been stored in the signal frame,
+			* and will be restored by sigreturn, so we can simply
+			* clear the TIF_RESTORE_SIGMASK flag.
+			*/
+			if (test_thread_flag(TIF_RESTORE_SIGMASK))
+				clear_thread_flag(TIF_RESTORE_SIGMASK);
+		}
+	}
 
 no_signal:
 	/*
@@ -853,6 +857,16 @@ no_signal:
 			regs->cp0_epc -= 4;
 		}
 	}
+
+	/*
+	* If there's no signal to deliver, we just put the saved sigmask
+	* back
+	*/
+	if (test_thread_flag(TIF_RESTORE_SIGMASK)) {
+		clear_thread_flag(TIF_RESTORE_SIGMASK);
+		sigprocmask(SIG_SETMASK, &current->saved_sigmask, NULL);
+	}
+
 	return 0;
 }
 

-- 
Martin Michlmayr
http://www.cyrius.com/
