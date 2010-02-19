Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Feb 2010 01:14:31 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:9510 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492154Ab0BSANx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Feb 2010 01:13:53 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b7dd7c70003>; Thu, 18 Feb 2010 16:13:59 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 18 Feb 2010 16:13:29 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 18 Feb 2010 16:13:28 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.2) with ESMTP id o1J0DQgH029147;
        Thu, 18 Feb 2010 16:13:26 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o1J0DQpg029146;
        Thu, 18 Feb 2010 16:13:26 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 3/3] MIPS: Move signal trampolines off of the stack.
Date:   Thu, 18 Feb 2010 16:13:05 -0800
Message-Id: <1266538385-29088-4-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6
In-Reply-To: <1266538385-29088-1-git-send-email-ddaney@caviumnetworks.com>
References: <1266538385-29088-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 19 Feb 2010 00:13:28.0838 (UTC) FILETIME=[5CC6A260:01CAB0F8]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25958
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

This is a follow on to the vdso patch.

Since all processes now have signal trampolines permanently mapped, we
can use those instead of putting the trampoline on the stack and
invalidating the corresponding icache across all CPUs.  We also get
rid of a bunch of ICACHE_REFILLS_WORKAROUND_WAR code.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/abi.h      |    6 ++-
 arch/mips/kernel/signal-common.h |    5 --
 arch/mips/kernel/signal.c        |   86 ++++++++-----------------------------
 arch/mips/kernel/signal32.c      |   55 ++++++------------------
 arch/mips/kernel/signal_n32.c    |   26 +++---------
 5 files changed, 43 insertions(+), 135 deletions(-)

diff --git a/arch/mips/include/asm/abi.h b/arch/mips/include/asm/abi.h
index 1dd74fb..9252d9b 100644
--- a/arch/mips/include/asm/abi.h
+++ b/arch/mips/include/asm/abi.h
@@ -13,12 +13,14 @@
 #include <asm/siginfo.h>
 
 struct mips_abi {
-	int (* const setup_frame)(struct k_sigaction * ka,
+	int (* const setup_frame)(void *sig_return, struct k_sigaction *ka,
 	                          struct pt_regs *regs, int signr,
 	                          sigset_t *set);
-	int (* const setup_rt_frame)(struct k_sigaction * ka,
+	const unsigned long	signal_return_offset;
+	int (* const setup_rt_frame)(void *sig_return, struct k_sigaction *ka,
 	                       struct pt_regs *regs, int signr,
 	                       sigset_t *set, siginfo_t *info);
+	const unsigned long	rt_signal_return_offset;
 	const unsigned long	restart;
 };
 
diff --git a/arch/mips/kernel/signal-common.h b/arch/mips/kernel/signal-common.h
index 6c8e8c4..10263b4 100644
--- a/arch/mips/kernel/signal-common.h
+++ b/arch/mips/kernel/signal-common.h
@@ -26,11 +26,6 @@
  */
 extern void __user *get_sigframe(struct k_sigaction *ka, struct pt_regs *regs,
 				 size_t frame_size);
-/*
- * install trampoline code to get back from the sig handler
- */
-extern int install_sigtramp(unsigned int __user *tramp, unsigned int syscall);
-
 /* Check and clear pending FPU exceptions in saved CSR */
 extern int fpcsr_pending(unsigned int __user *fpcsr);
 
diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index d0c68b5..2099d5a 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -32,6 +32,7 @@
 #include <asm/ucontext.h>
 #include <asm/cpu-features.h>
 #include <asm/war.h>
+#include <asm/vdso.h>
 
 #include "signal-common.h"
 
@@ -44,47 +45,20 @@ extern asmlinkage int _restore_fp_context(struct sigcontext __user *sc);
 extern asmlinkage int fpu_emulator_save_context(struct sigcontext __user *sc);
 extern asmlinkage int fpu_emulator_restore_context(struct sigcontext __user *sc);
 
-/*
- * Horribly complicated - with the bloody RM9000 workarounds enabled
- * the signal trampolines is moving to the end of the structure so we can
- * increase the alignment without breaking software compatibility.
- */
-#if ICACHE_REFILLS_WORKAROUND_WAR == 0
-
 struct sigframe {
 	u32 sf_ass[4];		/* argument save space for o32 */
-	u32 sf_code[2];		/* signal trampoline */
+	u32 sf_pad[2];		/* Was: signal trampoline */
 	struct sigcontext sf_sc;
 	sigset_t sf_mask;
 };
 
 struct rt_sigframe {
 	u32 rs_ass[4];		/* argument save space for o32 */
-	u32 rs_code[2];		/* signal trampoline */
+	u32 rs_pad[2];		/* Was: signal trampoline */
 	struct siginfo rs_info;
 	struct ucontext rs_uc;
 };
 
-#else
-
-struct sigframe {
-	u32 sf_ass[4];			/* argument save space for o32 */
-	u32 sf_pad[2];
-	struct sigcontext sf_sc;	/* hw context */
-	sigset_t sf_mask;
-	u32 sf_code[8] ____cacheline_aligned;	/* signal trampoline */
-};
-
-struct rt_sigframe {
-	u32 rs_ass[4];			/* argument save space for o32 */
-	u32 rs_pad[2];
-	struct siginfo rs_info;
-	struct ucontext rs_uc;
-	u32 rs_code[8] ____cacheline_aligned;	/* signal trampoline */
-};
-
-#endif
-
 /*
  * Helper routines
  */
@@ -266,32 +240,6 @@ void __user *get_sigframe(struct k_sigaction *ka, struct pt_regs *regs,
 	return (void __user *)((sp - frame_size) & (ICACHE_REFILLS_WORKAROUND_WAR ? ~(cpu_icache_line_size()-1) : ALMASK));
 }
 
-int install_sigtramp(unsigned int __user *tramp, unsigned int syscall)
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
-	err |= __put_user(0x0000000c         , tramp + 1);
-	if (ICACHE_REFILLS_WORKAROUND_WAR) {
-		err |= __put_user(0, tramp + 2);
-		err |= __put_user(0, tramp + 3);
-		err |= __put_user(0, tramp + 4);
-		err |= __put_user(0, tramp + 5);
-		err |= __put_user(0, tramp + 6);
-		err |= __put_user(0, tramp + 7);
-	}
-	flush_cache_sigtramp((unsigned long) tramp);
-
-	return err;
-}
-
 /*
  * Atomically swap in the new signal mask, and wait for a signal.
  */
@@ -484,8 +432,8 @@ badframe:
 }
 
 #ifdef CONFIG_TRAD_SIGNALS
-static int setup_frame(struct k_sigaction * ka, struct pt_regs *regs,
-	int signr, sigset_t *set)
+static int setup_frame(void *sig_return, struct k_sigaction *ka,
+		       struct pt_regs *regs, int signr, sigset_t *set)
 {
 	struct sigframe __user *frame;
 	int err = 0;
@@ -494,8 +442,6 @@ static int setup_frame(struct k_sigaction * ka, struct pt_regs *regs,
 	if (!access_ok(VERIFY_WRITE, frame, sizeof (*frame)))
 		goto give_sigsegv;
 
-	err |= install_sigtramp(frame->sf_code, __NR_sigreturn);
-
 	err |= setup_sigcontext(regs, &frame->sf_sc);
 	err |= __copy_to_user(&frame->sf_mask, set, sizeof(*set));
 	if (err)
@@ -515,7 +461,7 @@ static int setup_frame(struct k_sigaction * ka, struct pt_regs *regs,
 	regs->regs[ 5] = 0;
 	regs->regs[ 6] = (unsigned long) &frame->sf_sc;
 	regs->regs[29] = (unsigned long) frame;
-	regs->regs[31] = (unsigned long) frame->sf_code;
+	regs->regs[31] = (unsigned long) sig_return;
 	regs->cp0_epc = regs->regs[25] = (unsigned long) ka->sa.sa_handler;
 
 	DEBUGP("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%lx\n",
@@ -529,8 +475,9 @@ give_sigsegv:
 }
 #endif
 
-static int setup_rt_frame(struct k_sigaction * ka, struct pt_regs *regs,
-	int signr, sigset_t *set, siginfo_t *info)
+static int setup_rt_frame(void *sig_return, struct k_sigaction *ka,
+			  struct pt_regs *regs,	int signr, sigset_t *set,
+			  siginfo_t *info)
 {
 	struct rt_sigframe __user *frame;
 	int err = 0;
@@ -539,8 +486,6 @@ static int setup_rt_frame(struct k_sigaction * ka, struct pt_regs *regs,
 	if (!access_ok(VERIFY_WRITE, frame, sizeof (*frame)))
 		goto give_sigsegv;
 
-	err |= install_sigtramp(frame->rs_code, __NR_rt_sigreturn);
-
 	/* Create siginfo.  */
 	err |= copy_siginfo_to_user(&frame->rs_info, info);
 
@@ -573,7 +518,7 @@ static int setup_rt_frame(struct k_sigaction * ka, struct pt_regs *regs,
 	regs->regs[ 5] = (unsigned long) &frame->rs_info;
 	regs->regs[ 6] = (unsigned long) &frame->rs_uc;
 	regs->regs[29] = (unsigned long) frame;
-	regs->regs[31] = (unsigned long) frame->rs_code;
+	regs->regs[31] = (unsigned long) sig_return;
 	regs->cp0_epc = regs->regs[25] = (unsigned long) ka->sa.sa_handler;
 
 	DEBUGP("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%lx\n",
@@ -590,8 +535,11 @@ give_sigsegv:
 struct mips_abi mips_abi = {
 #ifdef CONFIG_TRAD_SIGNALS
 	.setup_frame	= setup_frame,
+	.signal_return_offset = offsetof(struct mips_vdso, signal_trampoline),
 #endif
 	.setup_rt_frame	= setup_rt_frame,
+	.rt_signal_return_offset =
+		offsetof(struct mips_vdso, rt_signal_trampoline),
 	.restart	= __NR_restart_syscall
 };
 
@@ -599,6 +547,8 @@ static int handle_signal(unsigned long sig, siginfo_t *info,
 	struct k_sigaction *ka, sigset_t *oldset, struct pt_regs *regs)
 {
 	int ret;
+	struct mips_abi *abi = current->thread.abi;
+	void *vdso = current->mm->context.vdso;
 
 	switch(regs->regs[0]) {
 	case ERESTART_RESTARTBLOCK:
@@ -619,9 +569,11 @@ static int handle_signal(unsigned long sig, siginfo_t *info,
 	regs->regs[0] = 0;		/* Don't deal with this again.  */
 
 	if (sig_uses_siginfo(ka))
-		ret = current->thread.abi->setup_rt_frame(ka, regs, sig, oldset, info);
+		ret = abi->setup_rt_frame(vdso + abi->rt_signal_return_offset,
+					  ka, regs, sig, oldset, info);
 	else
-		ret = current->thread.abi->setup_frame(ka, regs, sig, oldset);
+		ret = abi->setup_frame(vdso + abi->signal_return_offset,
+				       ka, regs, sig, oldset);
 
 	spin_lock_irq(&current->sighand->siglock);
 	sigorsets(&current->blocked, &current->blocked, &ka->sa.sa_mask);
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index 03abaf0..a0ed0e0 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -32,6 +32,7 @@
 #include <asm/system.h>
 #include <asm/fpu.h>
 #include <asm/war.h>
+#include <asm/vdso.h>
 
 #include "signal-common.h"
 
@@ -47,8 +48,6 @@ extern asmlinkage int fpu_emulator_restore_context32(struct sigcontext32 __user
 /*
  * Including <asm/unistd.h> would give use the 64-bit syscall numbers ...
  */
-#define __NR_O32_sigreturn		4119
-#define __NR_O32_rt_sigreturn		4193
 #define __NR_O32_restart_syscall        4253
 
 /* 32-bit compatibility types */
@@ -77,47 +76,20 @@ struct ucontext32 {
 	compat_sigset_t     uc_sigmask;   /* mask last for extensibility */
 };
 
-/*
- * Horribly complicated - with the bloody RM9000 workarounds enabled
- * the signal trampolines is moving to the end of the structure so we can
- * increase the alignment without breaking software compatibility.
- */
-#if ICACHE_REFILLS_WORKAROUND_WAR == 0
-
 struct sigframe32 {
 	u32 sf_ass[4];		/* argument save space for o32 */
-	u32 sf_code[2];		/* signal trampoline */
+	u32 sf_pad[2];		/* Was: signal trampoline */
 	struct sigcontext32 sf_sc;
 	compat_sigset_t sf_mask;
 };
 
 struct rt_sigframe32 {
 	u32 rs_ass[4];			/* argument save space for o32 */
-	u32 rs_code[2];			/* signal trampoline */
+	u32 rs_pad[2];			/* Was: signal trampoline */
 	compat_siginfo_t rs_info;
 	struct ucontext32 rs_uc;
 };
 
-#else  /* ICACHE_REFILLS_WORKAROUND_WAR */
-
-struct sigframe32 {
-	u32 sf_ass[4];			/* argument save space for o32 */
-	u32 sf_pad[2];
-	struct sigcontext32 sf_sc;	/* hw context */
-	compat_sigset_t sf_mask;
-	u32 sf_code[8] ____cacheline_aligned;	/* signal trampoline */
-};
-
-struct rt_sigframe32 {
-	u32 rs_ass[4];			/* argument save space for o32 */
-	u32 rs_pad[2];
-	compat_siginfo_t rs_info;
-	struct ucontext32 rs_uc;
-	u32 rs_code[8] __attribute__((aligned(32)));	/* signal trampoline */
-};
-
-#endif	/* !ICACHE_REFILLS_WORKAROUND_WAR */
-
 /*
  * sigcontext handlers
  */
@@ -598,8 +570,8 @@ badframe:
 	force_sig(SIGSEGV, current);
 }
 
-static int setup_frame_32(struct k_sigaction * ka, struct pt_regs *regs,
-	int signr, sigset_t *set)
+static int setup_frame_32(void *sig_return, struct k_sigaction *ka,
+			  struct pt_regs *regs, int signr, sigset_t *set)
 {
 	struct sigframe32 __user *frame;
 	int err = 0;
@@ -608,8 +580,6 @@ static int setup_frame_32(struct k_sigaction * ka, struct pt_regs *regs,
 	if (!access_ok(VERIFY_WRITE, frame, sizeof (*frame)))
 		goto give_sigsegv;
 
-	err |= install_sigtramp(frame->sf_code, __NR_O32_sigreturn);
-
 	err |= setup_sigcontext32(regs, &frame->sf_sc);
 	err |= __copy_conv_sigset_to_user(&frame->sf_mask, set);
 
@@ -630,7 +600,7 @@ static int setup_frame_32(struct k_sigaction * ka, struct pt_regs *regs,
 	regs->regs[ 5] = 0;
 	regs->regs[ 6] = (unsigned long) &frame->sf_sc;
 	regs->regs[29] = (unsigned long) frame;
-	regs->regs[31] = (unsigned long) frame->sf_code;
+	regs->regs[31] = (unsigned long) sig_return;
 	regs->cp0_epc = regs->regs[25] = (unsigned long) ka->sa.sa_handler;
 
 	DEBUGP("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%lx\n",
@@ -644,8 +614,9 @@ give_sigsegv:
 	return -EFAULT;
 }
 
-static int setup_rt_frame_32(struct k_sigaction * ka, struct pt_regs *regs,
-	int signr, sigset_t *set, siginfo_t *info)
+static int setup_rt_frame_32(void *sig_return, struct k_sigaction *ka,
+			     struct pt_regs *regs, int signr, sigset_t *set,
+			     siginfo_t *info)
 {
 	struct rt_sigframe32 __user *frame;
 	int err = 0;
@@ -655,8 +626,6 @@ static int setup_rt_frame_32(struct k_sigaction * ka, struct pt_regs *regs,
 	if (!access_ok(VERIFY_WRITE, frame, sizeof (*frame)))
 		goto give_sigsegv;
 
-	err |= install_sigtramp(frame->rs_code, __NR_O32_rt_sigreturn);
-
 	/* Convert (siginfo_t -> compat_siginfo_t) and copy to user. */
 	err |= copy_siginfo_to_user32(&frame->rs_info, info);
 
@@ -690,7 +659,7 @@ static int setup_rt_frame_32(struct k_sigaction * ka, struct pt_regs *regs,
 	regs->regs[ 5] = (unsigned long) &frame->rs_info;
 	regs->regs[ 6] = (unsigned long) &frame->rs_uc;
 	regs->regs[29] = (unsigned long) frame;
-	regs->regs[31] = (unsigned long) frame->rs_code;
+	regs->regs[31] = (unsigned long) sig_return;
 	regs->cp0_epc = regs->regs[25] = (unsigned long) ka->sa.sa_handler;
 
 	DEBUGP("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%lx\n",
@@ -709,7 +678,11 @@ give_sigsegv:
  */
 struct mips_abi mips_abi_32 = {
 	.setup_frame	= setup_frame_32,
+	.signal_return_offset =
+		offsetof(struct mips_vdso, o32_signal_trampoline),
 	.setup_rt_frame	= setup_rt_frame_32,
+	.rt_signal_return_offset =
+		offsetof(struct mips_vdso, o32_rt_signal_trampoline),
 	.restart	= __NR_O32_restart_syscall
 };
 
diff --git a/arch/mips/kernel/signal_n32.c b/arch/mips/kernel/signal_n32.c
index bb277e8..2c5df81 100644
--- a/arch/mips/kernel/signal_n32.c
+++ b/arch/mips/kernel/signal_n32.c
@@ -39,13 +39,13 @@
 #include <asm/fpu.h>
 #include <asm/cpu-features.h>
 #include <asm/war.h>
+#include <asm/vdso.h>
 
 #include "signal-common.h"
 
 /*
  * Including <asm/unistd.h> would give use the 64-bit syscall numbers ...
  */
-#define __NR_N32_rt_sigreturn		6211
 #define __NR_N32_restart_syscall	6214
 
 extern int setup_sigcontext(struct pt_regs *, struct sigcontext __user *);
@@ -67,27 +67,13 @@ struct ucontextn32 {
 	compat_sigset_t     uc_sigmask;   /* mask last for extensibility */
 };
 
-#if ICACHE_REFILLS_WORKAROUND_WAR == 0
-
-struct rt_sigframe_n32 {
-	u32 rs_ass[4];			/* argument save space for o32 */
-	u32 rs_code[2];			/* signal trampoline */
-	struct compat_siginfo rs_info;
-	struct ucontextn32 rs_uc;
-};
-
-#else  /* ICACHE_REFILLS_WORKAROUND_WAR */
-
 struct rt_sigframe_n32 {
 	u32 rs_ass[4];			/* argument save space for o32 */
-	u32 rs_pad[2];
+	u32 rs_pad[2];			/* Was: signal trampoline */
 	struct compat_siginfo rs_info;
 	struct ucontextn32 rs_uc;
-	u32 rs_code[8] ____cacheline_aligned;		/* signal trampoline */
 };
 
-#endif	/* !ICACHE_REFILLS_WORKAROUND_WAR */
-
 extern void sigset_from_compat(sigset_t *set, compat_sigset_t *compat);
 
 asmlinkage int sysn32_rt_sigsuspend(nabi_no_regargs struct pt_regs regs)
@@ -173,7 +159,7 @@ badframe:
 	force_sig(SIGSEGV, current);
 }
 
-static int setup_rt_frame_n32(struct k_sigaction * ka,
+static int setup_rt_frame_n32(void *sig_return, struct k_sigaction *ka,
 	struct pt_regs *regs, int signr, sigset_t *set, siginfo_t *info)
 {
 	struct rt_sigframe_n32 __user *frame;
@@ -184,8 +170,6 @@ static int setup_rt_frame_n32(struct k_sigaction * ka,
 	if (!access_ok(VERIFY_WRITE, frame, sizeof (*frame)))
 		goto give_sigsegv;
 
-	install_sigtramp(frame->rs_code, __NR_N32_rt_sigreturn);
-
 	/* Create siginfo.  */
 	err |= copy_siginfo_to_user32(&frame->rs_info, info);
 
@@ -219,7 +203,7 @@ static int setup_rt_frame_n32(struct k_sigaction * ka,
 	regs->regs[ 5] = (unsigned long) &frame->rs_info;
 	regs->regs[ 6] = (unsigned long) &frame->rs_uc;
 	regs->regs[29] = (unsigned long) frame;
-	regs->regs[31] = (unsigned long) frame->rs_code;
+	regs->regs[31] = (unsigned long) sig_return;
 	regs->cp0_epc = regs->regs[25] = (unsigned long) ka->sa.sa_handler;
 
 	DEBUGP("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%lx\n",
@@ -235,5 +219,7 @@ give_sigsegv:
 
 struct mips_abi mips_abi_n32 = {
 	.setup_rt_frame	= setup_rt_frame_n32,
+	.rt_signal_return_offset =
+		offsetof(struct mips_vdso, n32_rt_signal_trampoline),
 	.restart	= __NR_N32_restart_syscall
 };
-- 
1.6.6
