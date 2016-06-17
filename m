Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jun 2016 17:04:01 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:24802 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27042861AbcFQPEAKXFAn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Jun 2016 17:04:00 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id B483DF3C4BE0E;
        Fri, 17 Jun 2016 16:03:49 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 17 Jun 2016 16:03:52 +0100
Received: from hhunt-arch.le.imgtec.org (192.168.154.26) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 17 Jun 2016 16:03:52 +0100
From:   Harvey Hunt <harvey.hunt@imgtec.com>
To:     <ralf@linux-mips.org>
CC:     Harvey Hunt <harvey.hunt@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Alex Smith <alex@alex-smith.me.uk>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] MIPS: Factor o32 specific code into signal_o32.c
Date:   Fri, 17 Jun 2016 16:03:45 +0100
Message-ID: <20160617150345.18722-1-harvey.hunt@imgtec.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.26]
Return-Path: <Harvey.Hunt@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54100
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: harvey.hunt@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

The commit ebb5e78cc634 ("MIPS: Initial implementation of a VDSO")
caused building a 64 bit kernel with support for n32 and not o32
to produce a build error:

arch/mips/kernel/signal32.c:415:11: error: ‘vdso_image_o32’ undeclared here (not in a function)
  .vdso  = &vdso_image_o32,

Fix this by moving the o32 specific code into signal_o32.c and
updating the Makefile accordingly.

Signed-off-by: Harvey Hunt <harvey.hunt@imgtec.com>
Cc: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc: Alex Smith <alex@alex-smith.me.uk>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 arch/mips/include/asm/signal.h |   2 +-
 arch/mips/kernel/Makefile      |   2 +-
 arch/mips/kernel/signal32.c    | 288 +----------------------------------------
 arch/mips/kernel/signal_o32.c  | 285 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 293 insertions(+), 284 deletions(-)
 create mode 100644 arch/mips/kernel/signal_o32.c

diff --git a/arch/mips/include/asm/signal.h b/arch/mips/include/asm/signal.h
index 2292373..77b3b95 100644
--- a/arch/mips/include/asm/signal.h
+++ b/arch/mips/include/asm/signal.h
@@ -11,7 +11,7 @@
 
 #include <uapi/asm/signal.h>
 
-#ifdef CONFIG_MIPS32_COMPAT
+#ifdef CONFIG_MIPS32_O32
 extern struct mips_abi mips_abi_32;
 
 #define sig_uses_siginfo(ka, abi)                               \
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index e6053d0..4a603a3 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -71,7 +71,7 @@ obj-$(CONFIG_32BIT)		+= scall32-o32.o
 obj-$(CONFIG_64BIT)		+= scall64-64.o
 obj-$(CONFIG_MIPS32_COMPAT)	+= linux32.o ptrace32.o signal32.o
 obj-$(CONFIG_MIPS32_N32)	+= binfmt_elfn32.o scall64-n32.o signal_n32.o
-obj-$(CONFIG_MIPS32_O32)	+= binfmt_elfo32.o scall64-o32.o
+obj-$(CONFIG_MIPS32_O32)	+= binfmt_elfo32.o scall64-o32.o signal_o32.o
 
 obj-$(CONFIG_KGDB)		+= kgdb.o
 obj-$(CONFIG_PROC_FS)		+= proc.o
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index 78c8349..97b7c51 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -6,129 +6,26 @@
  * Copyright (C) 1991, 1992  Linus Torvalds
  * Copyright (C) 1994 - 2000, 2006  Ralf Baechle
  * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
+ * Copyright (C) 2016, Imagination Technologies Ltd.
  */
-#include <linux/cache.h>
-#include <linux/compat.h>
-#include <linux/sched.h>
-#include <linux/mm.h>
-#include <linux/smp.h>
+#include <linux/compiler.h>
+#include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/signal.h>
 #include <linux/syscalls.h>
-#include <linux/errno.h>
-#include <linux/wait.h>
-#include <linux/ptrace.h>
-#include <linux/suspend.h>
-#include <linux/compiler.h>
-#include <linux/uaccess.h>
 
-#include <asm/abi.h>
-#include <asm/asm.h>
+#include <asm/compat.h>
 #include <asm/compat-signal.h>
-#include <linux/bitops.h>
-#include <asm/cacheflush.h>
-#include <asm/sim.h>
-#include <asm/ucontext.h>
-#include <asm/fpu.h>
-#include <asm/war.h>
-#include <asm/dsp.h>
+#include <asm/uaccess.h>
+#include <asm/unistd.h>
 
 #include "signal-common.h"
 
-/*
- * Including <asm/unistd.h> would give use the 64-bit syscall numbers ...
- */
-#define __NR_O32_restart_syscall	4253
-
 /* 32-bit compatibility types */
 
 typedef unsigned int __sighandler32_t;
 typedef void (*vfptr_t)(void);
 
-struct ucontext32 {
-	u32		    uc_flags;
-	s32		    uc_link;
-	compat_stack_t      uc_stack;
-	struct sigcontext32 uc_mcontext;
-	compat_sigset_t	    uc_sigmask;	  /* mask last for extensibility */
-};
-
-struct sigframe32 {
-	u32 sf_ass[4];		/* argument save space for o32 */
-	u32 sf_pad[2];		/* Was: signal trampoline */
-	struct sigcontext32 sf_sc;
-	compat_sigset_t sf_mask;
-};
-
-struct rt_sigframe32 {
-	u32 rs_ass[4];			/* argument save space for o32 */
-	u32 rs_pad[2];			/* Was: signal trampoline */
-	compat_siginfo_t rs_info;
-	struct ucontext32 rs_uc;
-};
-
-static int setup_sigcontext32(struct pt_regs *regs,
-			      struct sigcontext32 __user *sc)
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
-		err |= __put_user(rddsp(DSP_MASK), &sc->sc_dsp);
-		err |= __put_user(mfhi1(), &sc->sc_hi1);
-		err |= __put_user(mflo1(), &sc->sc_lo1);
-		err |= __put_user(mfhi2(), &sc->sc_hi2);
-		err |= __put_user(mflo2(), &sc->sc_lo2);
-		err |= __put_user(mfhi3(), &sc->sc_hi3);
-		err |= __put_user(mflo3(), &sc->sc_lo3);
-	}
-
-	/*
-	 * Save FPU state to signal context.  Signal handler
-	 * will "inherit" current FPU state.
-	 */
-	err |= protected_save_fp_context(sc);
-
-	return err;
-}
-
-static int restore_sigcontext32(struct pt_regs *regs,
-				struct sigcontext32 __user *sc)
-{
-	int err = 0;
-	s32 treg;
-	int i;
-
-	/* Always make any pending restarted system calls return -EINTR */
-	current->restart_block.fn = do_no_restart_syscall;
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
-	return err ?: protected_restore_fp_context(sc);
-}
-
 /*
  * Atomically swap in the new signal mask, and wait for a signal.
  */
@@ -247,176 +144,3 @@ int copy_siginfo_from_user32(siginfo_t *to, compat_siginfo_t __user *from)
 
 	return 0;
 }
-
-asmlinkage void sys32_sigreturn(nabi_no_regargs struct pt_regs regs)
-{
-	struct sigframe32 __user *frame;
-	sigset_t blocked;
-	int sig;
-
-	frame = (struct sigframe32 __user *) regs.regs[29];
-	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
-		goto badframe;
-	if (__copy_conv_sigset_from_user(&blocked, &frame->sf_mask))
-		goto badframe;
-
-	set_current_blocked(&blocked);
-
-	sig = restore_sigcontext32(&regs, &frame->sf_sc);
-	if (sig < 0)
-		goto badframe;
-	else if (sig)
-		force_sig(sig, current);
-
-	/*
-	 * Don't let your children do this ...
-	 */
-	__asm__ __volatile__(
-		"move\t$29, %0\n\t"
-		"j\tsyscall_exit"
-		:/* no outputs */
-		:"r" (&regs));
-	/* Unreached */
-
-badframe:
-	force_sig(SIGSEGV, current);
-}
-
-asmlinkage void sys32_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
-{
-	struct rt_sigframe32 __user *frame;
-	sigset_t set;
-	int sig;
-
-	frame = (struct rt_sigframe32 __user *) regs.regs[29];
-	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
-		goto badframe;
-	if (__copy_conv_sigset_from_user(&set, &frame->rs_uc.uc_sigmask))
-		goto badframe;
-
-	set_current_blocked(&set);
-
-	sig = restore_sigcontext32(&regs, &frame->rs_uc.uc_mcontext);
-	if (sig < 0)
-		goto badframe;
-	else if (sig)
-		force_sig(sig, current);
-
-	if (compat_restore_altstack(&frame->rs_uc.uc_stack))
-		goto badframe;
-
-	/*
-	 * Don't let your children do this ...
-	 */
-	__asm__ __volatile__(
-		"move\t$29, %0\n\t"
-		"j\tsyscall_exit"
-		:/* no outputs */
-		:"r" (&regs));
-	/* Unreached */
-
-badframe:
-	force_sig(SIGSEGV, current);
-}
-
-static int setup_frame_32(void *sig_return, struct ksignal *ksig,
-			  struct pt_regs *regs, sigset_t *set)
-{
-	struct sigframe32 __user *frame;
-	int err = 0;
-
-	frame = get_sigframe(ksig, regs, sizeof(*frame));
-	if (!access_ok(VERIFY_WRITE, frame, sizeof (*frame)))
-		return -EFAULT;
-
-	err |= setup_sigcontext32(regs, &frame->sf_sc);
-	err |= __copy_conv_sigset_to_user(&frame->sf_mask, set);
-
-	if (err)
-		return -EFAULT;
-
-	/*
-	 * Arguments to signal handler:
-	 *
-	 *   a0 = signal number
-	 *   a1 = 0 (should be cause)
-	 *   a2 = pointer to struct sigcontext
-	 *
-	 * $25 and c0_epc point to the signal handler, $29 points to the
-	 * struct sigframe.
-	 */
-	regs->regs[ 4] = ksig->sig;
-	regs->regs[ 5] = 0;
-	regs->regs[ 6] = (unsigned long) &frame->sf_sc;
-	regs->regs[29] = (unsigned long) frame;
-	regs->regs[31] = (unsigned long) sig_return;
-	regs->cp0_epc = regs->regs[25] = (unsigned long) ksig->ka.sa.sa_handler;
-
-	DEBUGP("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%lx\n",
-	       current->comm, current->pid,
-	       frame, regs->cp0_epc, regs->regs[31]);
-
-	return 0;
-}
-
-static int setup_rt_frame_32(void *sig_return, struct ksignal *ksig,
-			     struct pt_regs *regs, sigset_t *set)
-{
-	struct rt_sigframe32 __user *frame;
-	int err = 0;
-
-	frame = get_sigframe(ksig, regs, sizeof(*frame));
-	if (!access_ok(VERIFY_WRITE, frame, sizeof (*frame)))
-		return -EFAULT;
-
-	/* Convert (siginfo_t -> compat_siginfo_t) and copy to user. */
-	err |= copy_siginfo_to_user32(&frame->rs_info, &ksig->info);
-
-	/* Create the ucontext.	 */
-	err |= __put_user(0, &frame->rs_uc.uc_flags);
-	err |= __put_user(0, &frame->rs_uc.uc_link);
-	err |= __compat_save_altstack(&frame->rs_uc.uc_stack, regs->regs[29]);
-	err |= setup_sigcontext32(regs, &frame->rs_uc.uc_mcontext);
-	err |= __copy_conv_sigset_to_user(&frame->rs_uc.uc_sigmask, set);
-
-	if (err)
-		return -EFAULT;
-
-	/*
-	 * Arguments to signal handler:
-	 *
-	 *   a0 = signal number
-	 *   a1 = 0 (should be cause)
-	 *   a2 = pointer to ucontext
-	 *
-	 * $25 and c0_epc point to the signal handler, $29 points to
-	 * the struct rt_sigframe32.
-	 */
-	regs->regs[ 4] = ksig->sig;
-	regs->regs[ 5] = (unsigned long) &frame->rs_info;
-	regs->regs[ 6] = (unsigned long) &frame->rs_uc;
-	regs->regs[29] = (unsigned long) frame;
-	regs->regs[31] = (unsigned long) sig_return;
-	regs->cp0_epc = regs->regs[25] = (unsigned long) ksig->ka.sa.sa_handler;
-
-	DEBUGP("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%lx\n",
-	       current->comm, current->pid,
-	       frame, regs->cp0_epc, regs->regs[31]);
-
-	return 0;
-}
-
-/*
- * o32 compatibility on 64-bit kernels, without DSP ASE
- */
-struct mips_abi mips_abi_32 = {
-	.setup_frame	= setup_frame_32,
-	.setup_rt_frame = setup_rt_frame_32,
-	.restart	= __NR_O32_restart_syscall,
-
-	.off_sc_fpregs = offsetof(struct sigcontext32, sc_fpregs),
-	.off_sc_fpc_csr = offsetof(struct sigcontext32, sc_fpc_csr),
-	.off_sc_used_math = offsetof(struct sigcontext32, sc_used_math),
-
-	.vdso		= &vdso_image_o32,
-};
diff --git a/arch/mips/kernel/signal_o32.c b/arch/mips/kernel/signal_o32.c
new file mode 100644
index 0000000..5e169fc
--- /dev/null
+++ b/arch/mips/kernel/signal_o32.c
@@ -0,0 +1,285 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1991, 1992  Linus Torvalds
+ * Copyright (C) 1994 - 2000, 2006  Ralf Baechle
+ * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
+ * Copyright (C) 2016, Imagination Technologies Ltd.
+ */
+#include <linux/compiler.h>
+#include <linux/errno.h>
+#include <linux/signal.h>
+#include <linux/uaccess.h>
+
+#include <asm/abi.h>
+#include <asm/compat-signal.h>
+#include <asm/dsp.h>
+#include <asm/sim.h>
+#include <asm/unistd.h>
+
+#include "signal-common.h"
+
+/*
+ * Including <asm/unistd.h> would give use the 64-bit syscall numbers ...
+ */
+#define __NR_O32_restart_syscall	4253
+
+struct sigframe32 {
+	u32 sf_ass[4];		/* argument save space for o32 */
+	u32 sf_pad[2];		/* Was: signal trampoline */
+	struct sigcontext32 sf_sc;
+	compat_sigset_t sf_mask;
+};
+
+struct ucontext32 {
+	u32		    uc_flags;
+	s32		    uc_link;
+	compat_stack_t      uc_stack;
+	struct sigcontext32 uc_mcontext;
+	compat_sigset_t	    uc_sigmask;	  /* mask last for extensibility */
+};
+
+struct rt_sigframe32 {
+	u32 rs_ass[4];			/* argument save space for o32 */
+	u32 rs_pad[2];			/* Was: signal trampoline */
+	compat_siginfo_t rs_info;
+	struct ucontext32 rs_uc;
+};
+
+static int setup_sigcontext32(struct pt_regs *regs,
+			      struct sigcontext32 __user *sc)
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
+		err |= __put_user(rddsp(DSP_MASK), &sc->sc_dsp);
+		err |= __put_user(mfhi1(), &sc->sc_hi1);
+		err |= __put_user(mflo1(), &sc->sc_lo1);
+		err |= __put_user(mfhi2(), &sc->sc_hi2);
+		err |= __put_user(mflo2(), &sc->sc_lo2);
+		err |= __put_user(mfhi3(), &sc->sc_hi3);
+		err |= __put_user(mflo3(), &sc->sc_lo3);
+	}
+
+	/*
+	 * Save FPU state to signal context.  Signal handler
+	 * will "inherit" current FPU state.
+	 */
+	err |= protected_save_fp_context(sc);
+
+	return err;
+}
+
+static int restore_sigcontext32(struct pt_regs *regs,
+				struct sigcontext32 __user *sc)
+{
+	int err = 0;
+	s32 treg;
+	int i;
+
+	/* Always make any pending restarted system calls return -EINTR */
+	current->restart_block.fn = do_no_restart_syscall;
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
+	return err ?: protected_restore_fp_context(sc);
+}
+
+static int setup_frame_32(void *sig_return, struct ksignal *ksig,
+			  struct pt_regs *regs, sigset_t *set)
+{
+	struct sigframe32 __user *frame;
+	int err = 0;
+
+	frame = get_sigframe(ksig, regs, sizeof(*frame));
+	if (!access_ok(VERIFY_WRITE, frame, sizeof (*frame)))
+		return -EFAULT;
+
+	err |= setup_sigcontext32(regs, &frame->sf_sc);
+	err |= __copy_conv_sigset_to_user(&frame->sf_mask, set);
+
+	if (err)
+		return -EFAULT;
+
+	/*
+	 * Arguments to signal handler:
+	 *
+	 *   a0 = signal number
+	 *   a1 = 0 (should be cause)
+	 *   a2 = pointer to struct sigcontext
+	 *
+	 * $25 and c0_epc point to the signal handler, $29 points to the
+	 * struct sigframe.
+	 */
+	regs->regs[ 4] = ksig->sig;
+	regs->regs[ 5] = 0;
+	regs->regs[ 6] = (unsigned long) &frame->sf_sc;
+	regs->regs[29] = (unsigned long) frame;
+	regs->regs[31] = (unsigned long) sig_return;
+	regs->cp0_epc = regs->regs[25] = (unsigned long) ksig->ka.sa.sa_handler;
+
+	DEBUGP("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%lx\n",
+	       current->comm, current->pid,
+	       frame, regs->cp0_epc, regs->regs[31]);
+
+	return 0;
+}
+
+asmlinkage void sys32_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
+{
+	struct rt_sigframe32 __user *frame;
+	sigset_t set;
+	int sig;
+
+	frame = (struct rt_sigframe32 __user *) regs.regs[29];
+	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
+		goto badframe;
+	if (__copy_conv_sigset_from_user(&set, &frame->rs_uc.uc_sigmask))
+		goto badframe;
+
+	set_current_blocked(&set);
+
+	sig = restore_sigcontext32(&regs, &frame->rs_uc.uc_mcontext);
+	if (sig < 0)
+		goto badframe;
+	else if (sig)
+		force_sig(sig, current);
+
+	if (compat_restore_altstack(&frame->rs_uc.uc_stack))
+		goto badframe;
+
+	/*
+	 * Don't let your children do this ...
+	 */
+	__asm__ __volatile__(
+		"move\t$29, %0\n\t"
+		"j\tsyscall_exit"
+		:/* no outputs */
+		:"r" (&regs));
+	/* Unreached */
+
+badframe:
+	force_sig(SIGSEGV, current);
+}
+
+static int setup_rt_frame_32(void *sig_return, struct ksignal *ksig,
+			     struct pt_regs *regs, sigset_t *set)
+{
+	struct rt_sigframe32 __user *frame;
+	int err = 0;
+
+	frame = get_sigframe(ksig, regs, sizeof(*frame));
+	if (!access_ok(VERIFY_WRITE, frame, sizeof (*frame)))
+		return -EFAULT;
+
+	/* Convert (siginfo_t -> compat_siginfo_t) and copy to user. */
+	err |= copy_siginfo_to_user32(&frame->rs_info, &ksig->info);
+
+	/* Create the ucontext.	 */
+	err |= __put_user(0, &frame->rs_uc.uc_flags);
+	err |= __put_user(0, &frame->rs_uc.uc_link);
+	err |= __compat_save_altstack(&frame->rs_uc.uc_stack, regs->regs[29]);
+	err |= setup_sigcontext32(regs, &frame->rs_uc.uc_mcontext);
+	err |= __copy_conv_sigset_to_user(&frame->rs_uc.uc_sigmask, set);
+
+	if (err)
+		return -EFAULT;
+
+	/*
+	 * Arguments to signal handler:
+	 *
+	 *   a0 = signal number
+	 *   a1 = 0 (should be cause)
+	 *   a2 = pointer to ucontext
+	 *
+	 * $25 and c0_epc point to the signal handler, $29 points to
+	 * the struct rt_sigframe32.
+	 */
+	regs->regs[ 4] = ksig->sig;
+	regs->regs[ 5] = (unsigned long) &frame->rs_info;
+	regs->regs[ 6] = (unsigned long) &frame->rs_uc;
+	regs->regs[29] = (unsigned long) frame;
+	regs->regs[31] = (unsigned long) sig_return;
+	regs->cp0_epc = regs->regs[25] = (unsigned long) ksig->ka.sa.sa_handler;
+
+	DEBUGP("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%lx\n",
+	       current->comm, current->pid,
+	       frame, regs->cp0_epc, regs->regs[31]);
+
+	return 0;
+}
+
+/*
+ * o32 compatibility on 64-bit kernels, without DSP ASE
+ */
+struct mips_abi mips_abi_32 = {
+	.setup_frame	= setup_frame_32,
+	.setup_rt_frame = setup_rt_frame_32,
+	.restart	= __NR_O32_restart_syscall,
+
+	.off_sc_fpregs = offsetof(struct sigcontext32, sc_fpregs),
+	.off_sc_fpc_csr = offsetof(struct sigcontext32, sc_fpc_csr),
+	.off_sc_used_math = offsetof(struct sigcontext32, sc_used_math),
+
+	.vdso		= &vdso_image_o32,
+};
+
+
+asmlinkage void sys32_sigreturn(nabi_no_regargs struct pt_regs regs)
+{
+	struct sigframe32 __user *frame;
+	sigset_t blocked;
+	int sig;
+
+	frame = (struct sigframe32 __user *) regs.regs[29];
+	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
+		goto badframe;
+	if (__copy_conv_sigset_from_user(&blocked, &frame->sf_mask))
+		goto badframe;
+
+	set_current_blocked(&blocked);
+
+	sig = restore_sigcontext32(&regs, &frame->sf_sc);
+	if (sig < 0)
+		goto badframe;
+	else if (sig)
+		force_sig(sig, current);
+
+	/*
+	 * Don't let your children do this ...
+	 */
+	__asm__ __volatile__(
+		"move\t$29, %0\n\t"
+		"j\tsyscall_exit"
+		:/* no outputs */
+		:"r" (&regs));
+	/* Unreached */
+
+badframe:
+	force_sig(SIGSEGV, current);
+}
-- 
2.8.3
