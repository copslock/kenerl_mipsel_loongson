Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Feb 2007 14:55:55 +0000 (GMT)
Received: from hu-out-0506.google.com ([72.14.214.238]:4290 "EHLO
	hu-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20037726AbXBEOzt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Feb 2007 14:55:49 +0000
Received: by hu-out-0506.google.com with SMTP id 22so789668hug
        for <linux-mips@linux-mips.org>; Mon, 05 Feb 2007 06:54:45 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=HXiSh2ca8LnxLl7oy9HNs2HNreDHVvmX8joj7fO9d1xQ7ieHaY/mJzxdNCdYjCLmOHj2+TrMygo2ljzTNjY5NPAHiunPrUFHK13q2wSWmpdeNytKebJjLX34MGc0sP7fBK2yBa/LV41odEizcbfGWgIwvijeTvqSocND9ZNaI5Y=
Received: by 10.82.152.16 with SMTP id z16mr2002254bud.1170687284178;
        Mon, 05 Feb 2007 06:54:44 -0800 (PST)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id p72sm27309769nfc.2007.02.05.06.54.42;
        Mon, 05 Feb 2007 06:54:43 -0800 (PST)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 544C623F770; Mon,  5 Feb 2007 15:24:29 +0100 (CET)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, Franck Bui-Huu <fbuihuu@gmail.com>
Subject: [PATCH 2/10] signal: do not inline functions in signal-common.h
Date:	Mon,  5 Feb 2007 15:24:20 +0100
Message-Id: <11706854691613-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.4.3.ge6d4
In-Reply-To: <11706854683935-git-send-email-fbuihuu@gmail.com>
References: <11706854683935-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13938
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

These functions are quite big and there are no points to make
them inlined. So this patch moves the functions implementation
in signal.c and make them available for others source files
which need them.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/kernel/signal-common.h |  150 ++++----------------------------------
 arch/mips/kernel/signal.c        |  139 +++++++++++++++++++++++++++++++++++
 2 files changed, 153 insertions(+), 136 deletions(-)

diff --git a/arch/mips/kernel/signal-common.h b/arch/mips/kernel/signal-common.h
index bb3c631..03d2b60 100644
--- a/arch/mips/kernel/signal-common.h
+++ b/arch/mips/kernel/signal-common.h
@@ -8,145 +8,23 @@
  * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
  */
 
+#ifndef __SIGNAL_COMMON_H
+#define __SIGNAL_COMMON_H
 
-static inline int
-setup_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
-{
-	int err = 0;
-	int i;
-
-	err |= __put_user(regs->cp0_epc, &sc->sc_pc);
-
-	err |= __put_user(0, &sc->sc_regs[0]);
-	for (i = 1; i < 32; i++)
-		err |= __put_user(regs->regs[i], &sc->sc_regs[i]);
-
-	err |= __put_user(regs->hi, &sc->sc_mdhi);
-	err |= __put_user(regs->lo, &sc->sc_mdlo);
-	if (cpu_has_dsp) {
-		err |= __put_user(mfhi1(), &sc->sc_hi1);
-		err |= __put_user(mflo1(), &sc->sc_lo1);
-		err |= __put_user(mfhi2(), &sc->sc_hi2);
-		err |= __put_user(mflo2(), &sc->sc_lo2);
-		err |= __put_user(mfhi3(), &sc->sc_hi3);
-		err |= __put_user(mflo3(), &sc->sc_lo3);
-		err |= __put_user(rddsp(DSP_MASK), &sc->sc_dsp);
-	}
-
-	err |= __put_user(!!used_math(), &sc->sc_used_math);
-
-	if (used_math()) {
-		/*
-		 * Save FPU state to signal context.  Signal handler
-		 * will "inherit" current FPU state.
-		 */
-		preempt_disable();
-
-		if (!is_fpu_owner()) {
-			own_fpu();
-			restore_fp(current);
-		}
-		err |= save_fp_context(sc);
-
-		preempt_enable();
-	}
-	return err;
-}
-
-static inline int
-restore_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
-{
-	unsigned int used_math;
-	unsigned long treg;
-	int err = 0;
-	int i;
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
-	for (i = 1; i < 32; i++)
-		err |= __get_user(regs->regs[i], &sc->sc_regs[i]);
-
-	err |= __get_user(used_math, &sc->sc_used_math);
-	conditional_used_math(used_math);
-
-	preempt_disable();
-
-	if (used_math()) {
-		/* restore fpu context if we have used it before */
-		own_fpu();
-		err |= restore_fp_context(sc);
-	} else {
-		/* signal handler may have used FPU.  Give it up. */
-		lose_fpu();
-	}
-
-	preempt_enable();
-
-	return err;
-}
+/*
+ * handle hardware context
+ */
+extern int setup_sigcontext(struct pt_regs *, struct sigcontext __user *);
+extern int restore_sigcontext(struct pt_regs *, struct sigcontext __user *);
 
 /*
  * Determine which stack to use..
  */
-static inline void __user *
-get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size)
-{
-	unsigned long sp;
-
-	/* Default to using normal stack */
-	sp = regs->regs[29];
-
-	/*
-	 * FPU emulator may have it's own trampoline active just
-	 * above the user stack, 16-bytes before the next lowest
-	 * 16 byte boundary.  Try to avoid trashing it.
-	 */
-	sp -= 32;
-
-	/* This is the X/Open sanctioned signal stack switching.  */
-	if ((ka->sa.sa_flags & SA_ONSTACK) && (sas_ss_flags (sp) == 0))
-		sp = current->sas_ss_sp + current->sas_ss_size;
-
-	return (void __user *)((sp - frame_size) & (ICACHE_REFILLS_WORKAROUND_WAR ? ~(cpu_icache_line_size()-1) : ALMASK));
-}
-
-static inline int install_sigtramp(unsigned int __user *tramp,
-	unsigned int syscall)
-{
-	int err;
-
-	/*
-	 * Set up the return code ...
-	 *
-	 *         li      v0, __NR__foo_sigreturn
-	 *         syscall
-	 */
-
-	err = __put_user(0x24020000 + syscall, tramp + 0);
-	err |= __put_user(0x0000000c          , tramp + 1);
-	if (ICACHE_REFILLS_WORKAROUND_WAR) {
-		err |= __put_user(0, tramp + 2);
-		err |= __put_user(0, tramp + 3);
-		err |= __put_user(0, tramp + 4);
-		err |= __put_user(0, tramp + 5);
-		err |= __put_user(0, tramp + 6);
-		err |= __put_user(0, tramp + 7);
-	}
-	flush_cache_sigtramp((unsigned long) tramp);
+extern void __user *get_sigframe(struct k_sigaction *ka, struct pt_regs *regs,
+				 size_t frame_size);
+/*
+ * install trampoline code to get back from the sig handler
+ */
+extern int install_sigtramp(unsigned int __user *tramp, unsigned int syscall);
 
-	return err;
-}
+#endif	/* __SIGNAL_COMMON_H */
diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index b9d358e..7ec73f2 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -39,6 +39,145 @@
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
 /*
+ * Helper routines
+ */
+int setup_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
+{
+	int err = 0;
+	int i;
+
+	err |= __put_user(regs->cp0_epc, &sc->sc_pc);
+
+	err |= __put_user(0, &sc->sc_regs[0]);
+	for (i = 1; i < 32; i++)
+		err |= __put_user(regs->regs[i], &sc->sc_regs[i]);
+
+	err |= __put_user(regs->hi, &sc->sc_mdhi);
+	err |= __put_user(regs->lo, &sc->sc_mdlo);
+	if (cpu_has_dsp) {
+		err |= __put_user(mfhi1(), &sc->sc_hi1);
+		err |= __put_user(mflo1(), &sc->sc_lo1);
+		err |= __put_user(mfhi2(), &sc->sc_hi2);
+		err |= __put_user(mflo2(), &sc->sc_lo2);
+		err |= __put_user(mfhi3(), &sc->sc_hi3);
+		err |= __put_user(mflo3(), &sc->sc_lo3);
+		err |= __put_user(rddsp(DSP_MASK), &sc->sc_dsp);
+	}
+
+	err |= __put_user(!!used_math(), &sc->sc_used_math);
+
+	if (used_math()) {
+		/*
+		 * Save FPU state to signal context. Signal handler
+		 * will "inherit" current FPU state.
+		 */
+		preempt_disable();
+
+		if (!is_fpu_owner()) {
+			own_fpu();
+			restore_fp(current);
+		}
+		err |= save_fp_context(sc);
+
+		preempt_enable();
+	}
+	return err;
+}
+
+int restore_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
+{
+	unsigned int used_math;
+	unsigned long treg;
+	int err = 0;
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
+		err |= restore_fp_context(sc);
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
+void __user *get_sigframe(struct k_sigaction *ka, struct pt_regs *regs,
+			  size_t frame_size)
+{
+	unsigned long sp;
+
+	/* Default to using normal stack */
+	sp = regs->regs[29];
+
+	/*
+	 * FPU emulator may have it's own trampoline active just
+	 * above the user stack, 16-bytes before the next lowest
+	 * 16 byte boundary.  Try to avoid trashing it.
+	 */
+	sp -= 32;
+
+	/* This is the X/Open sanctioned signal stack switching.  */
+	if ((ka->sa.sa_flags & SA_ONSTACK) && (sas_ss_flags (sp) == 0))
+		sp = current->sas_ss_sp + current->sas_ss_size;
+
+	return (void __user *)((sp - frame_size) & (ICACHE_REFILLS_WORKAROUND_WAR ? ~(cpu_icache_line_size()-1) : ALMASK));
+}
+
+int install_sigtramp(unsigned int __user *tramp, unsigned int syscall)
+{
+	int err;
+
+	/*
+	 * Set up the return code ...
+	 *
+	 *         li      v0, __NR__foo_sigreturn
+	 *         syscall
+	 */
+
+	err = __put_user(0x24020000 + syscall, tramp + 0);
+	err |= __put_user(0x0000000c          , tramp + 1);
+	if (ICACHE_REFILLS_WORKAROUND_WAR) {
+		err |= __put_user(0, tramp + 2);
+		err |= __put_user(0, tramp + 3);
+		err |= __put_user(0, tramp + 4);
+		err |= __put_user(0, tramp + 5);
+		err |= __put_user(0, tramp + 6);
+		err |= __put_user(0, tramp + 7);
+	}
+	flush_cache_sigtramp((unsigned long) tramp);
+
+	return err;
+}
+
+/*
  * Atomically swap in the new signal mask, and wait for a signal.
  */
 
-- 
1.4.4.3.ge6d4
