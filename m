Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Feb 2007 18:03:37 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:13050 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28573750AbXBOSDc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 15 Feb 2007 18:03:32 +0000
Received: from localhost (p8089-ipad32funabasi.chiba.ocn.ne.jp [221.189.140.89])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id B3F1DBEB0; Fri, 16 Feb 2007 03:02:09 +0900 (JST)
Date:	Fri, 16 Feb 2007 03:02:09 +0900 (JST)
Message-Id: <20070216.030209.93206265.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	macro@linux-mips.org
Subject: Re: [MIPS] Check FCSR for pending interrupts before restoring from
 a context.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070214.170420.85684996.nemoto@toshiba-tops.co.jp>
References: <20070209.015405.08319291.anemo@mba.ocn.ne.jp>
	<20070209.130316.14978798.nemoto@toshiba-tops.co.jp>
	<20070214.170420.85684996.nemoto@toshiba-tops.co.jp>
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
X-archive-position: 14106
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 14 Feb 2007 17:04:20 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> Subject: Check FCSR for pending interrupts, alternative version
> 
> The commit 6d6671066a311703bca1b91645bb1e04cc983387 is incomplete and
> misses non-r4k CPUs.  This patch reverts the commit and fixes in other
> way.
> 
> * Do FCSR checking in caller of restore_fp_context.
> * Send SIGFPE if the signal handler set any FPU exception bits.

And this is for 2.6.20-stable tree.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/kernel/r4k_fpu.S       |   16 --------------
 arch/mips/kernel/signal-common.h |   35 ++++++++++++++++++++++++++++++-
 arch/mips/kernel/signal.c        |   12 +++++++++-
 arch/mips/kernel/signal32.c      |   41 +++++++++++++++++++++++++++++++++++--
 arch/mips/kernel/signal_n32.c    |    6 ++++-
 5 files changed, 88 insertions(+), 22 deletions(-)

diff --git a/arch/mips/kernel/r4k_fpu.S b/arch/mips/kernel/r4k_fpu.S
index 59c1577..dbd42ad 100644
--- a/arch/mips/kernel/r4k_fpu.S
+++ b/arch/mips/kernel/r4k_fpu.S
@@ -114,14 +114,6 @@ LEAF(_save_fp_context32)
  */
 LEAF(_restore_fp_context)
 	EX	lw t0, SC_FPC_CSR(a0)
-
-	/* Fail if the CSR has exceptions pending */
-	srl	t1, t0, 5
-	and	t1, t0
-	andi	t1, 0x1f << 7
-	bnez	t1, fault
-	 nop
-
 #ifdef CONFIG_64BIT
 	EX	ldc1 $f1, SC_FPREGS+8(a0)
 	EX	ldc1 $f3, SC_FPREGS+24(a0)
@@ -165,14 +157,6 @@ LEAF(_restore_fp_context)
 LEAF(_restore_fp_context32)
 	/* Restore an o32 sigcontext.  */
 	EX	lw t0, SC32_FPC_CSR(a0)
-
-	/* Fail if the CSR has exceptions pending */
-	srl	t1, t0, 5
-	and	t1, t0
-	andi	t1, 0x1f << 7
-	bnez	t1, fault
-	 nop
-
 	EX	ldc1 $f0, SC32_FPREGS+0(a0)
 	EX	ldc1 $f2, SC32_FPREGS+16(a0)
 	EX	ldc1 $f4, SC32_FPREGS+32(a0)
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
index b9d358e..c19408e 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -190,6 +190,7 @@ _sys_sigreturn(nabi_no_regargs struct pt
 {
 	struct sigframe __user *frame;
 	sigset_t blocked;
+	int sig;
 
 	frame = (struct sigframe __user *) regs.regs[29];
 	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
@@ -203,8 +204,11 @@ _sys_sigreturn(nabi_no_regargs struct pt
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
 
-	if (restore_sigcontext(&regs, &frame->sf_sc))
+	sig = restore_sigcontext(&regs, &frame->sf_sc);
+	if (sig < 0)
 		goto badframe;
+	else if (sig)
+		force_sig(sig, current);
 
 	/*
 	 * Don't let your children do this ...
@@ -228,6 +232,7 @@ _sys_rt_sigreturn(nabi_no_regargs struct
 	struct rt_sigframe __user *frame;
 	sigset_t set;
 	stack_t st;
+	int sig;
 
 	frame = (struct rt_sigframe __user *) regs.regs[29];
 	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
@@ -241,8 +246,11 @@ _sys_rt_sigreturn(nabi_no_regargs struct
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
index 7464df4..80ac070 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -321,6 +321,38 @@ asmlinkage int sys32_sigaltstack(nabi_no
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
+	err = sig = fpcsr_pending(&sc->sc_fpc_csr);
+	if (err > 0)
+		err = 0;
+	err |= restore_fp_context32(sc);
+	return err ?: sig;
+}
+
 static int restore_sigcontext32(struct pt_regs *regs, struct sigcontext32 __user *sc)
 {
 	u32 used_math;
@@ -367,7 +399,8 @@ static int restore_sigcontext32(struct p
 	if (used_math()) {
 		/* restore fpu context if we have used it before */
 		own_fpu();
-		err |= restore_fp_context32(sc);
+		if (!err)
+			err = check_and_restore_fp_context32(sc);
 	} else {
 		/* signal handler may have used FPU.  Give it up. */
 		lose_fpu();
@@ -464,6 +497,7 @@ _sys32_sigreturn(nabi_no_regargs struct
 {
 	struct sigframe __user *frame;
 	sigset_t blocked;
+	int sig;
 
 	frame = (struct sigframe __user *) regs.regs[29];
 	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
@@ -477,8 +511,11 @@ _sys32_sigreturn(nabi_no_regargs struct
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
diff --git a/arch/mips/kernel/signal_n32.c b/arch/mips/kernel/signal_n32.c
index d6160c9..617edd9 100644
--- a/arch/mips/kernel/signal_n32.c
+++ b/arch/mips/kernel/signal_n32.c
@@ -123,6 +123,7 @@ _sysn32_rt_sigreturn(nabi_no_regargs str
 	sigset_t set;
 	stack_t st;
 	s32 sp;
+	int sig;
 
 	frame = (struct rt_sigframe_n32 __user *) regs.regs[29];
 	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
@@ -136,8 +137,11 @@ _sysn32_rt_sigreturn(nabi_no_regargs str
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
 
-	if (restore_sigcontext(&regs, &frame->rs_uc.uc_mcontext))
+	sig = restore_sigcontext(&regs, &frame->rs_uc.uc_mcontext);
+	if (sig < 0)
 		goto badframe;
+	else if (sig)
+		force_sig(sig, current);
 
 	/* The ucontext contains a stack32_t, so we must convert!  */
 	if (__get_user(sp, &frame->rs_uc.uc_stack.ss_sp))
