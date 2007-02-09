Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Feb 2007 04:03:48 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:41421 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20039580AbXBIEDm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 9 Feb 2007 04:03:42 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Fri, 9 Feb 2007 13:03:40 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 40B8F261FB;
	Fri,  9 Feb 2007 13:03:17 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 2C2B220571;
	Fri,  9 Feb 2007 13:03:17 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l1943GW0072922;
	Fri, 9 Feb 2007 13:03:16 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 09 Feb 2007 13:03:16 +0900 (JST)
Message-Id: <20070209.130316.14978798.nemoto@toshiba-tops.co.jp>
To:	vagabon.xyz@gmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	macro@linux-mips.org
Subject: Re: [MIPS] Check FCSR for pending interrupts before restoring from
 a context.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070209.015405.08319291.anemo@mba.ocn.ne.jp>
References: <20070209.002323.115905985.anemo@mba.ocn.ne.jp>
	<cda58cb80702080830n44627bafw88b0b6620eefb693@mail.gmail.com>
	<20070209.015405.08319291.anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14003
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 09 Feb 2007 01:54:05 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> Here is a patch can be applied on top of your patchset.

I missed n32 part.  Revised.


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
 arch/mips/kernel/signal_n32.c    |    6 ++++
 5 files changed, 75 insertions(+), 23 deletions(-)

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
@@ -61,4 +61,7 @@ extern void __user *get_sigframe(struct k_sigaction *ka, struct pt_regs *regs,
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
@@ -103,6 +103,37 @@ int setup_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
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
@@ -137,7 +168,8 @@ int restore_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
 	if (used_math()) {
 		/* restore fpu context if we have used it before */
 		own_fpu();
-		err |= restore_fp_context(sc);
+		if (!err)
+			err = check_and_restore_fp_context(sc);
 	} else {
 		/* signal handler may have used FPU.  Give it up. */
 		lose_fpu();
@@ -307,6 +339,7 @@ asmlinkage void sys_sigreturn(nabi_no_regargs struct pt_regs regs)
 {
 	struct sigframe __user *frame;
 	sigset_t blocked;
+	int sig;
 
 	frame = (struct sigframe __user *) regs.regs[29];
 	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
@@ -320,8 +353,11 @@ asmlinkage void sys_sigreturn(nabi_no_regargs struct pt_regs regs)
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
@@ -343,6 +379,7 @@ asmlinkage void sys_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
 	struct rt_sigframe __user *frame;
 	sigset_t set;
 	stack_t st;
+	int sig;
 
 	frame = (struct rt_sigframe __user *) regs.regs[29];
 	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
@@ -356,8 +393,11 @@ asmlinkage void sys_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
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
@@ -207,6 +207,18 @@ static int setup_sigcontext32(struct pt_regs *regs,
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
@@ -242,7 +254,8 @@ static int restore_sigcontext32(struct pt_regs *regs,
 	if (used_math()) {
 		/* restore fpu context if we have used it before */
 		own_fpu();
-		err |= restore_fp_context32(sc);
+		if (!err)
+			err = check_and_restore_fp_context32(sc);
 	} else {
 		/* signal handler may have used FPU.  Give it up. */
 		lose_fpu();
@@ -495,6 +508,7 @@ asmlinkage void sys32_sigreturn(nabi_no_regargs struct pt_regs regs)
 {
 	struct sigframe __user *frame;
 	sigset_t blocked;
+	int sig;
 
 	frame = (struct sigframe __user *) regs.regs[29];
 	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
@@ -508,8 +522,11 @@ asmlinkage void sys32_sigreturn(nabi_no_regargs struct pt_regs regs)
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
@@ -532,6 +549,7 @@ asmlinkage void sys32_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
 	sigset_t set;
 	stack_t st;
 	s32 sp;
+	int sig;
 
 	frame = (struct rt_sigframe32 __user *) regs.regs[29];
 	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
@@ -545,8 +563,11 @@ asmlinkage void sys32_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
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
diff --git a/arch/mips/kernel/signal_n32.c b/arch/mips/kernel/signal_n32.c
index 57456e6..01c6627 100644
--- a/arch/mips/kernel/signal_n32.c
+++ b/arch/mips/kernel/signal_n32.c
@@ -123,6 +123,7 @@ asmlinkage void sysn32_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
 	sigset_t set;
 	stack_t st;
 	s32 sp;
+	int sig;
 
 	frame = (struct rt_sigframe_n32 __user *) regs.regs[29];
 	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
@@ -136,8 +137,11 @@ asmlinkage void sysn32_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
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
