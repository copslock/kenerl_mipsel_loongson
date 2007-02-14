Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Feb 2007 08:05:03 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:48477 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20027656AbXBNIE7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 14 Feb 2007 08:04:59 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Wed, 14 Feb 2007 17:04:54 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 104AF42056;
	Wed, 14 Feb 2007 17:04:22 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id F078E41C73;
	Wed, 14 Feb 2007 17:04:21 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l1E84LW0095097;
	Wed, 14 Feb 2007 17:04:21 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 14 Feb 2007 17:04:20 +0900 (JST)
Message-Id: <20070214.170420.85684996.nemoto@toshiba-tops.co.jp>
To:	vagabon.xyz@gmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	macro@linux-mips.org
Subject: Re: [MIPS] Check FCSR for pending interrupts before restoring from
 a context.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070209.130316.14978798.nemoto@toshiba-tops.co.jp>
References: <cda58cb80702080830n44627bafw88b0b6620eefb693@mail.gmail.com>
	<20070209.015405.08319291.anemo@mba.ocn.ne.jp>
	<20070209.130316.14978798.nemoto@toshiba-tops.co.jp>
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
X-archive-position: 14087
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Revised again.  Fix check_and_restore_fp_context32 and rediff against
current git.


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
index fdbdbdc..297dfcb 100644
--- a/arch/mips/kernel/signal-common.h
+++ b/arch/mips/kernel/signal-common.h
@@ -31,4 +31,7 @@ extern void __user *get_sigframe(struct k_sigaction *ka, struct pt_regs *regs,
  */
 extern int install_sigtramp(unsigned int __user *tramp, unsigned int syscall);
 
+/* Check and clear pending FPU exceptions in saved CSR */
+extern int fpcsr_pending(unsigned int __user *fpcsr);
+
 #endif	/* __SIGNAL_COMMON_H */
diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index b2e9ab1..2420ed6 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -121,6 +121,37 @@ int setup_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
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
@@ -155,7 +186,8 @@ int restore_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
 	if (used_math()) {
 		/* restore fpu context if we have used it before */
 		own_fpu();
-		err |= restore_fp_context(sc);
+		if (!err)
+			err = check_and_restore_fp_context(sc);
 	} else {
 		/* signal handler may have used FPU.  Give it up. */
 		lose_fpu();
@@ -325,6 +357,7 @@ asmlinkage void sys_sigreturn(nabi_no_regargs struct pt_regs regs)
 {
 	struct sigframe __user *frame;
 	sigset_t blocked;
+	int sig;
 
 	frame = (struct sigframe __user *) regs.regs[29];
 	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
@@ -338,8 +371,11 @@ asmlinkage void sys_sigreturn(nabi_no_regargs struct pt_regs regs)
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
@@ -361,6 +397,7 @@ asmlinkage void sys_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
 	struct rt_sigframe __user *frame;
 	sigset_t set;
 	stack_t st;
+	int sig;
 
 	frame = (struct rt_sigframe __user *) regs.regs[29];
 	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
@@ -374,8 +411,11 @@ asmlinkage void sys_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
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
index dd4e518..813279d 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -220,6 +220,18 @@ static int setup_sigcontext32(struct pt_regs *regs,
 	return err;
 }
 
+static int
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
 static int restore_sigcontext32(struct pt_regs *regs,
 				struct sigcontext32 __user *sc)
 {
@@ -255,7 +267,8 @@ static int restore_sigcontext32(struct pt_regs *regs,
 	if (used_math()) {
 		/* restore fpu context if we have used it before */
 		own_fpu();
-		err |= restore_fp_context32(sc);
+		if (!err)
+			err = check_and_restore_fp_context32(sc);
 	} else {
 		/* signal handler may have used FPU.  Give it up. */
 		lose_fpu();
@@ -508,6 +521,7 @@ asmlinkage void sys32_sigreturn(nabi_no_regargs struct pt_regs regs)
 {
 	struct sigframe32 __user *frame;
 	sigset_t blocked;
+	int sig;
 
 	frame = (struct sigframe32 __user *) regs.regs[29];
 	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
@@ -521,8 +535,11 @@ asmlinkage void sys32_sigreturn(nabi_no_regargs struct pt_regs regs)
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
@@ -545,6 +562,7 @@ asmlinkage void sys32_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
 	sigset_t set;
 	stack_t st;
 	s32 sp;
+	int sig;
 
 	frame = (struct rt_sigframe32 __user *) regs.regs[29];
 	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
@@ -558,8 +576,11 @@ asmlinkage void sys32_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
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
index 7ca2a07..26ca944 100644
--- a/arch/mips/kernel/signal_n32.c
+++ b/arch/mips/kernel/signal_n32.c
@@ -126,6 +126,7 @@ asmlinkage void sysn32_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
 	sigset_t set;
 	stack_t st;
 	s32 sp;
+	int sig;
 
 	frame = (struct rt_sigframe_n32 __user *) regs.regs[29];
 	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
@@ -139,8 +140,11 @@ asmlinkage void sysn32_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
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
