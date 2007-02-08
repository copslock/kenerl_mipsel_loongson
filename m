Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Feb 2007 16:55:31 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:51960 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038631AbXBHQz0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 8 Feb 2007 16:55:26 +0000
Received: from localhost (p4240-ipad301funabasi.chiba.ocn.ne.jp [122.17.254.240])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 9A23A867E; Fri,  9 Feb 2007 01:54:05 +0900 (JST)
Date:	Fri, 09 Feb 2007 01:54:05 +0900 (JST)
Message-Id: <20070209.015405.08319291.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	macro@linux-mips.org
Subject: Re: [MIPS] Check FCSR for pending interrupts before restoring from
 a context.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <cda58cb80702080830n44627bafw88b0b6620eefb693@mail.gmail.com>
References: <20070208.120219.96684712.nemoto@toshiba-tops.co.jp>
	<20070209.002323.115905985.anemo@mba.ocn.ne.jp>
	<cda58cb80702080830n44627bafw88b0b6620eefb693@mail.gmail.com>
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
X-archive-position: 13998
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 8 Feb 2007 17:30:29 +0100, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> yes this's going to conflict a lot with the patchset I sent...

Here is a patch can be applied on top of your patchset.


Subject: Check FCSR for pending interrupts, alternative version

The commit 6d6671066a311703bca1b91645bb1e04cc983387 is incomplete and
misses non-r4k CPUs.  This patch reverts the commit and fixes in other
way.

* Do FCSR checking in caller of restore_fp_context.
* Send SIGFPE if the signal handler set any FPU exception bits.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/kernel/r4k_fpu.S       |   16 ------------
 arch/mips/kernel/signal-common.h |    3 ++
 arch/mips/kernel/signal.c        |   46 ++++++++++++++++++++++++++++++++++---
 arch/mips/kernel/signal32.c      |   27 +++++++++++++++++++--
 4 files changed, 70 insertions(+), 22 deletions(-)

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
index 9a8abd6..1f24288 100644
--- a/arch/mips/kernel/signal-common.h
+++ b/arch/mips/kernel/signal-common.h
@@ -61,4 +61,7 @@ extern void __user *get_sigframe(struct
  */
 extern int install_sigtramp(unsigned int __user *tramp, unsigned int syscall);
 
+/* Check and clear pending FPU exceptions in saved CSR */
+extern int fpcsr_pending(unsigned int __user *fpcsr);
+
 #endif	/* __SIGNAL_COMMON_H */
diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 8dfb7b1..d7531d5 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -103,6 +103,37 @@ int setup_sigcontext(struct pt_regs *reg
 	return err;
 }
 
+int fpcsr_pending(unsigned int __user *fpcsr)
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
+static int
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
 int restore_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
 {
 	unsigned int used_math;
@@ -137,7 +168,8 @@ int restore_sigcontext(struct pt_regs *r
 	if (used_math()) {
 		/* restore fpu context if we have used it before */
 		own_fpu();
-		err |= restore_fp_context(sc);
+		if (!err)
+			err = check_and_restore_fp_context(sc);
 	} else {
 		/* signal handler may have used FPU.  Give it up. */
 		lose_fpu();
@@ -307,6 +339,7 @@ asmlinkage void sys_sigreturn(nabi_no_re
 {
 	struct sigframe __user *frame;
 	sigset_t blocked;
+	int sig;
 
 	frame = (struct sigframe __user *) regs.regs[29];
 	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
@@ -320,8 +353,11 @@ asmlinkage void sys_sigreturn(nabi_no_re
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
@@ -343,6 +379,7 @@ asmlinkage void sys_rt_sigreturn(nabi_no
 	struct rt_sigframe __user *frame;
 	sigset_t set;
 	stack_t st;
+	int sig;
 
 	frame = (struct rt_sigframe __user *) regs.regs[29];
 	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
@@ -356,8 +393,11 @@ asmlinkage void sys_rt_sigreturn(nabi_no
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
index 183fc7e..c37ff65 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -207,6 +207,18 @@ static int setup_sigcontext32(struct pt_
 	return err;
 }
 
+static int
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
 static int restore_sigcontext32(struct pt_regs *regs,
 				struct sigcontext32 __user *sc)
 {
@@ -242,7 +254,8 @@ static int restore_sigcontext32(struct p
 	if (used_math()) {
 		/* restore fpu context if we have used it before */
 		own_fpu();
-		err |= restore_fp_context32(sc);
+		if (!err)
+			err = check_and_restore_fp_context32(sc);
 	} else {
 		/* signal handler may have used FPU.  Give it up. */
 		lose_fpu();
@@ -495,6 +508,7 @@ asmlinkage void sys32_sigreturn(nabi_no_
 {
 	struct sigframe __user *frame;
 	sigset_t blocked;
+	int sig;
 
 	frame = (struct sigframe __user *) regs.regs[29];
 	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
@@ -508,8 +522,11 @@ asmlinkage void sys32_sigreturn(nabi_no_
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
@@ -532,6 +549,7 @@ asmlinkage void sys32_rt_sigreturn(nabi_
 	sigset_t set;
 	stack_t st;
 	s32 sp;
+	int sig;
 
 	frame = (struct rt_sigframe32 __user *) regs.regs[29];
 	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
@@ -545,8 +563,11 @@ asmlinkage void sys32_rt_sigreturn(nabi_
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
 
-	if (restore_sigcontext32(&regs, &frame->rs_uc.uc_mcontext))
+	sig = restore_sigcontext32(&regs, &frame->rs_uc.uc_mcontext);
+	if (sig < 0)
 		goto badframe;
+	else if (sig)
+		force_sig(sig, current);
 
 	/* The ucontext contains a stack32_t, so we must convert!  */
 	if (__get_user(sp, &frame->rs_uc.uc_stack.ss_sp))
