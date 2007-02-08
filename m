Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Feb 2007 15:24:50 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:32224 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038557AbXBHPYo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 8 Feb 2007 15:24:44 +0000
Received: from localhost (p4240-ipad301funabasi.chiba.ocn.ne.jp [122.17.254.240])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 827BAB671; Fri,  9 Feb 2007 00:23:23 +0900 (JST)
Date:	Fri, 09 Feb 2007 00:23:23 +0900 (JST)
Message-Id: <20070209.002323.115905985.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, macro@linux-mips.org, vagabon.xyz@gmail.com
Subject: Re: [MIPS] Check FCSR for pending interrupts before restoring from
 a context.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070208.120219.96684712.nemoto@toshiba-tops.co.jp>
References: <20070208.012216.103777705.anemo@mba.ocn.ne.jp>
	<Pine.LNX.4.64N.0702071725150.9744@blysk.ds.pg.gda.pl>
	<20070208.120219.96684712.nemoto@toshiba-tops.co.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13990
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 08 Feb 2007 12:02:19 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> So we can do it in C, but it will conflicts with Franck's signal
> cleanup patchset.  I hope his patchset applied first.
> 
> Also I wonder SIGSEGV is correct behavior on this case.  SIGFPE?

And I found that if signal handler set FPU_CSR_UNI_X, kernel complains
"FP exception in kernel code" ...

Here is a first cut.  Changes in r4k_fpu.S can be reverted, and after
Franck's patchset applied, this patch can be a bit smaller.  Please
review.

Note that calling __get_user(), __put_user() might lose FPU ownership.
But restore_fp_context() already has this breakage.  I already sent
two alternative patches to fix this longstanding issue ("[PATCH]
rewrite restore_fp_context/save_fp_context" and "[PATCH 2/3] Allow CpU
exception in kernel partially").


diff --git a/arch/mips/kernel/signal-common.h b/arch/mips/kernel/signal-common.h
index b1f09d5..0811298 100644
--- a/arch/mips/kernel/signal-common.h
+++ b/arch/mips/kernel/signal-common.h
@@ -66,6 +66,38 @@ out:
 }
 
 static inline int
+fpcsr_pending(unsigned int __user *fpcsr)
+{
+	int err, sig = 0;
+	unsigned int csr, enabled;
+
+	err = __get_user(csr, fpcsr);
+	enabled = FPU_CSR_UNI_X | ((csr & FPU_CSR_ALL_E) << 5);
+	/*
+	 * If the signal handler set some FPU exceptions, clear it and
+	 * send SIGFPE.
+	 */
+	if (csr & enabled) {
+		csr &= ~enabled;
+		err |= __put_user(csr, fpcsr);
+		sig = SIGFPE;
+	}
+	return err ?: sig;
+}
+
+static inline int
+check_and_restore_fp_context(struct sigcontext __user *sc)
+{
+	int err, sig;
+
+	err = sig = fpcsr_pending(&sc->sc_fpc_csr);
+	if (err > 0)
+		err = 0;
+	err |= restore_fp_context(sc);
+	return err ?: sig;
+}
+
+static inline int
 restore_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
 {
 	unsigned int used_math;
@@ -112,7 +144,8 @@ restore_sigcontext(struct pt_regs *regs,
 	if (used_math()) {
 		/* restore fpu context if we have used it before */
 		own_fpu();
-		err |= restore_fp_context(sc);
+		if (!err)
+			err = check_and_restore_fp_context(sc);
 	} else {
 		/* signal handler may have used FPU.  Give it up. */
 		lose_fpu();
diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 9a44053..31d8ec0 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -190,6 +190,7 @@ _sys_sigreturn(nabi_no_regargs struct pt
 {
 	struct sigframe __user *frame;
 	sigset_t blocked;
+	int sig;
 
 	frame = (struct sigframe __user *) regs.regs[29];
 	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
@@ -203,8 +204,12 @@ _sys_sigreturn(nabi_no_regargs struct pt
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
 
-	if (restore_sigcontext(&regs, &frame->sf_sc))
+	sig = restore_sigcontext(&regs, &frame->sf_sc);
 		goto badframe;
+	if (sig < 0)
+		goto badframe;
+	else if (sig)
+		force_sig(sig, current);
 
 	/*
 	 * Don't let your children do this ...
@@ -228,6 +233,7 @@ _sys_rt_sigreturn(nabi_no_regargs struct
 	struct rt_sigframe __user *frame;
 	sigset_t set;
 	stack_t st;
+	int sig;
 
 	frame = (struct rt_sigframe __user *) regs.regs[29];
 	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
@@ -241,8 +247,11 @@ _sys_rt_sigreturn(nabi_no_regargs struct
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
 
-	if (restore_sigcontext(&regs, &frame->rs_uc.uc_mcontext))
+	sig = restore_sigcontext(&regs, &frame->rs_uc.uc_mcontext);
+	if (sig < 0)
 		goto badframe;
+	else if (sig)
+		force_sig(sig, current);
 
 	if (__copy_from_user(&st, &frame->rs_uc.uc_stack, sizeof(st)))
 		goto badframe;
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index c86a5dd..51eb21d 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -326,6 +326,38 @@ asmlinkage int sys32_sigaltstack(nabi_no
 	return ret;
 }
 
+static inline int
+fpcsr_pending(unsigned int __user *fpcsr)
+{
+	int err, sig = 0;
+	unsigned int csr, enabled;
+
+	err = __get_user(csr, fpcsr);
+	enabled = FPU_CSR_UNI_X | ((csr & FPU_CSR_ALL_E) << 5);
+	/*
+	 * If the signal handler set some FPU exceptions, clear it and
+	 * send SIGFPE.
+	 */
+	if (csr & enabled) {
+		csr &= ~enabled;
+		err |= __put_user(csr, fpcsr);
+		sig = SIGFPE;
+	}
+	return err ?: sig;
+}
+
+static inline int
+check_and_restore_fp_context32(struct sigcontext32 __user *sc)
+{
+	int err, sig;
+
+	sig = fpcsr_pending(&sc->sc_fpc_csr);
+	if (sig < 0)
+		err = sig;
+	err |= restore_fp_context32(sc);
+	return err ?: sig;
+}
+
 static int restore_sigcontext32(struct pt_regs *regs, struct sigcontext32 __user *sc)
 {
 	u32 used_math;
@@ -372,7 +404,8 @@ static int restore_sigcontext32(struct p
 	if (used_math()) {
 		/* restore fpu context if we have used it before */
 		own_fpu();
-		err |= restore_fp_context32(sc);
+		if (!err)
+			err = check_and_restore_fp_context(sc);
 	} else {
 		/* signal handler may have used FPU.  Give it up. */
 		lose_fpu();
@@ -469,6 +502,7 @@ _sys32_sigreturn(nabi_no_regargs struct
 {
 	struct sigframe __user *frame;
 	sigset_t blocked;
+	int sig;
 
 	frame = (struct sigframe __user *) regs.regs[29];
 	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
@@ -482,8 +516,11 @@ _sys32_sigreturn(nabi_no_regargs struct
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
 
-	if (restore_sigcontext32(&regs, &frame->sf_sc))
+	sig = restore_sigcontext32(&regs, &frame->sf_sc);
+	if (sig < 0)
 		goto badframe;
+	else if (sig)
+		force_sig(sig, current);
 
 	/*
 	 * Don't let your children do this ...
