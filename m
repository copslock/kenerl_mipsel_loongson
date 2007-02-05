Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Feb 2007 14:29:26 +0000 (GMT)
Received: from hu-out-0506.google.com ([72.14.214.225]:7335 "EHLO
	hu-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20037737AbXBEO0j (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Feb 2007 14:26:39 +0000
Received: by hu-out-0506.google.com with SMTP id 22so786024hug
        for <linux-mips@linux-mips.org>; Mon, 05 Feb 2007 06:25:34 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=TUW1cLDbNTiVEj00yc+QUVLH2Z0Qo1hrMBXyPUI3Omn1MZvprjb5QFcXc2mv4c1OBJVyVC7SUdfgD4H02g5c1j13d4oO2yTc4pfDxPiCi05+++sMf8SuXtEjMCRoCbPitFOBZYBq1ChJN4VpabCRXRE/CaM9o24EdZPGtdSpUkc=
Received: by 10.48.240.10 with SMTP id n10mr2278484nfh.1170685533409;
        Mon, 05 Feb 2007 06:25:33 -0800 (PST)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id p43sm27151883nfa.2007.02.05.06.25.30;
        Mon, 05 Feb 2007 06:25:32 -0800 (PST)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id D724C23F776; Mon,  5 Feb 2007 15:24:29 +0100 (CET)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, Franck Bui-Huu <fbuihuu@gmail.com>
Subject: [PATCH 7/10] signal32: reduce {setup,restore}_sigcontext32 sizes
Date:	Mon,  5 Feb 2007 15:24:25 +0100
Message-Id: <11706854691291-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.4.3.ge6d4
In-Reply-To: <11706854683935-git-send-email-fbuihuu@gmail.com>
References: <11706854683935-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13934
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

This trivial changes should decrease a lot the size of these
2 functions.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/kernel/signal32.c |  211 ++++++++++++++++++++-----------------------
 1 files changed, 97 insertions(+), 114 deletions(-)

diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index 1a99a57..5d102ef 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -160,6 +160,103 @@ struct rt_sigframe32 {
 
 #endif	/* !ICACHE_REFILLS_WORKAROUND_WAR */
 
+/*
+ * sigcontext handlers
+ */
+static int setup_sigcontext32(struct pt_regs *regs,
+			      struct sigcontext32 __user *sc)
+{
+	int err = 0;
+	int i;
+
+	err |= __put_user(regs->cp0_epc, &sc->sc_pc);
+	err |= __put_user(regs->cp0_status, &sc->sc_status);
+
+	err |= __put_user(0, &sc->sc_regs[0]);
+	for (i = 1; i < 32; i++)
+		err |= __put_user(regs->regs[i], &sc->sc_regs[i]);
+
+	err |= __put_user(regs->hi, &sc->sc_mdhi);
+	err |= __put_user(regs->lo, &sc->sc_mdlo);
+	if (cpu_has_dsp) {
+		err |= __put_user(rddsp(DSP_MASK), &sc->sc_dsp);
+		err |= __put_user(mfhi1(), &sc->sc_hi1);
+		err |= __put_user(mflo1(), &sc->sc_lo1);
+		err |= __put_user(mfhi2(), &sc->sc_hi2);
+		err |= __put_user(mflo2(), &sc->sc_lo2);
+		err |= __put_user(mfhi3(), &sc->sc_hi3);
+		err |= __put_user(mflo3(), &sc->sc_lo3);
+	}
+
+	err |= __put_user(!!used_math(), &sc->sc_used_math);
+
+	if (used_math()) {
+		/*
+		 * Save FPU state to signal context.  Signal handler
+		 * will "inherit" current FPU state.
+		 */
+		preempt_disable();
+
+		if (!is_fpu_owner()) {
+			own_fpu();
+			restore_fp(current);
+		}
+		err |= save_fp_context32(sc);
+
+		preempt_enable();
+	}
+	return err;
+}
+
+static int restore_sigcontext32(struct pt_regs *regs,
+				struct sigcontext32 __user *sc)
+{
+	u32 used_math;
+	int err = 0;
+	s32 treg;
+	int i;
+
+	/* Always make any pending restarted system calls return -EINTR */
+	current_thread_info()->restart_block.fn = do_no_restart_syscall;
+
+	err |= __get_user(regs->cp0_epc, &sc->sc_pc);
+	err |= __get_user(regs->hi, &sc->sc_mdhi);
+	err |= __get_user(regs->lo, &sc->sc_mdlo);
+	if (cpu_has_dsp) {
+		err |= __get_user(treg, &sc->sc_hi1); mthi1(treg);
+		err |= __get_user(treg, &sc->sc_lo1); mtlo1(treg);
+		err |= __get_user(treg, &sc->sc_hi2); mthi2(treg);
+		err |= __get_user(treg, &sc->sc_lo2); mtlo2(treg);
+		err |= __get_user(treg, &sc->sc_hi3); mthi3(treg);
+		err |= __get_user(treg, &sc->sc_lo3); mtlo3(treg);
+		err |= __get_user(treg, &sc->sc_dsp); wrdsp(treg, DSP_MASK);
+	}
+
+	for (i = 1; i < 32; i++)
+		err |= __get_user(regs->regs[i], &sc->sc_regs[i]);
+
+	err |= __get_user(used_math, &sc->sc_used_math);
+	conditional_used_math(used_math);
+
+	preempt_disable();
+
+	if (used_math()) {
+		/* restore fpu context if we have used it before */
+		own_fpu();
+		err |= restore_fp_context32(sc);
+	} else {
+		/* signal handler may have used FPU.  Give it up. */
+		lose_fpu();
+	}
+
+	preempt_enable();
+
+	return err;
+}
+
+/*
+ *
+ */
 extern void __put_sigset_unknown_nsig(void);
 extern void __get_sigset_unknown_nsig(void);
 
@@ -347,63 +444,6 @@ asmlinkage int sys32_sigaltstack(nabi_no_regargs struct pt_regs regs)
 	return ret;
 }
 
-static int restore_sigcontext32(struct pt_regs *regs, struct sigcontext32 __user *sc)
-{
-	u32 used_math;
-	int err = 0;
-	s32 treg;
-
-	/* Always make any pending restarted system calls return -EINTR */
-	current_thread_info()->restart_block.fn = do_no_restart_syscall;
-
-	err |= __get_user(regs->cp0_epc, &sc->sc_pc);
-	err |= __get_user(regs->hi, &sc->sc_mdhi);
-	err |= __get_user(regs->lo, &sc->sc_mdlo);
-	if (cpu_has_dsp) {
-		err |= __get_user(treg, &sc->sc_hi1); mthi1(treg);
-		err |= __get_user(treg, &sc->sc_lo1); mtlo1(treg);
-		err |= __get_user(treg, &sc->sc_hi2); mthi2(treg);
-		err |= __get_user(treg, &sc->sc_lo2); mtlo2(treg);
-		err |= __get_user(treg, &sc->sc_hi3); mthi3(treg);
-		err |= __get_user(treg, &sc->sc_lo3); mtlo3(treg);
-		err |= __get_user(treg, &sc->sc_dsp); wrdsp(treg, DSP_MASK);
-	}
-
-#define restore_gp_reg(i) do {						\
-	err |= __get_user(regs->regs[i], &sc->sc_regs[i]);		\
-} while(0)
-	restore_gp_reg( 1); restore_gp_reg( 2); restore_gp_reg( 3);
-	restore_gp_reg( 4); restore_gp_reg( 5); restore_gp_reg( 6);
-	restore_gp_reg( 7); restore_gp_reg( 8); restore_gp_reg( 9);
-	restore_gp_reg(10); restore_gp_reg(11); restore_gp_reg(12);
-	restore_gp_reg(13); restore_gp_reg(14); restore_gp_reg(15);
-	restore_gp_reg(16); restore_gp_reg(17); restore_gp_reg(18);
-	restore_gp_reg(19); restore_gp_reg(20); restore_gp_reg(21);
-	restore_gp_reg(22); restore_gp_reg(23); restore_gp_reg(24);
-	restore_gp_reg(25); restore_gp_reg(26); restore_gp_reg(27);
-	restore_gp_reg(28); restore_gp_reg(29); restore_gp_reg(30);
-	restore_gp_reg(31);
-#undef restore_gp_reg
-
-	err |= __get_user(used_math, &sc->sc_used_math);
-	conditional_used_math(used_math);
-
-	preempt_disable();
-
-	if (used_math()) {
-		/* restore fpu context if we have used it before */
-		own_fpu();
-		err |= restore_fp_context32(sc);
-	} else {
-		/* signal handler may have used FPU.  Give it up. */
-		lose_fpu();
-	}
-
-	preempt_enable();
-
-	return err;
-}
-
 int copy_siginfo_to_user32(compat_siginfo_t __user *to, siginfo_t *from)
 {
 	int err;
@@ -547,63 +587,6 @@ badframe:
 	force_sig(SIGSEGV, current);
 }
 
-static inline int setup_sigcontext32(struct pt_regs *regs,
-				     struct sigcontext32 __user *sc)
-{
-	int err = 0;
-
-	err |= __put_user(regs->cp0_epc, &sc->sc_pc);
-	err |= __put_user(regs->cp0_status, &sc->sc_status);
-
-#define save_gp_reg(i) {						\
-	err |= __put_user(regs->regs[i], &sc->sc_regs[i]);		\
-} while(0)
-	__put_user(0, &sc->sc_regs[0]); save_gp_reg(1); save_gp_reg(2);
-	save_gp_reg(3); save_gp_reg(4); save_gp_reg(5); save_gp_reg(6);
-	save_gp_reg(7); save_gp_reg(8); save_gp_reg(9); save_gp_reg(10);
-	save_gp_reg(11); save_gp_reg(12); save_gp_reg(13); save_gp_reg(14);
-	save_gp_reg(15); save_gp_reg(16); save_gp_reg(17); save_gp_reg(18);
-	save_gp_reg(19); save_gp_reg(20); save_gp_reg(21); save_gp_reg(22);
-	save_gp_reg(23); save_gp_reg(24); save_gp_reg(25); save_gp_reg(26);
-	save_gp_reg(27); save_gp_reg(28); save_gp_reg(29); save_gp_reg(30);
-	save_gp_reg(31);
-#undef save_gp_reg
-
-	err |= __put_user(regs->hi, &sc->sc_mdhi);
-	err |= __put_user(regs->lo, &sc->sc_mdlo);
-	if (cpu_has_dsp) {
-		err |= __put_user(rddsp(DSP_MASK), &sc->sc_dsp);
-		err |= __put_user(mfhi1(), &sc->sc_hi1);
-		err |= __put_user(mflo1(), &sc->sc_lo1);
-		err |= __put_user(mfhi2(), &sc->sc_hi2);
-		err |= __put_user(mflo2(), &sc->sc_lo2);
-		err |= __put_user(mfhi3(), &sc->sc_hi3);
-		err |= __put_user(mflo3(), &sc->sc_lo3);
-	}
-
-	err |= __put_user(!!used_math(), &sc->sc_used_math);
-
-	if (!used_math())
-		goto out;
-
-	/*
-	 * Save FPU state to signal context.  Signal handler will "inherit"
-	 * current FPU state.
-	 */
-	preempt_disable();
-
-	if (!is_fpu_owner()) {
-		own_fpu();
-		restore_fp(current);
-	}
-	err |= save_fp_context32(sc);
-
-	preempt_enable();
-
-out:
-	return err;
-}
-
 int setup_frame_32(struct k_sigaction * ka, struct pt_regs *regs,
 	int signr, sigset_t *set)
 {
-- 
1.4.4.3.ge6d4
