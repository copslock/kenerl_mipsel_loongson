Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Nov 2004 05:58:00 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:14390
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225238AbUK3F5k>; Tue, 30 Nov 2004 05:57:40 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CZ119-0008Nw-00; Tue, 30 Nov 2004 06:57:39 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CZ118-000741-00; Tue, 30 Nov 2004 06:57:38 +0100
Date: Tue, 30 Nov 2004 06:57:38 +0100
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Subject: [PATCH] Updated: signal handling code improvements
Message-ID: <20041130055738.GA26966@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6501
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Hello All,

this is an update of the earlier signal handling code improvements
patch in order to handle the PLAT_TRAMPOLINE_STUFF_LINE stuff as well.

In addition to the earlier fixes it extends the use of
PLAT_TRAMPOLINE_STUFF_LINE to cover N32 ABI, and uses __clear_user
instead of __builtin_memset.


Thiemo


Index: arch/mips/kernel/signal.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/signal.c,v
retrieving revision 1.81
diff -u -p -r1.81 signal.c
--- arch/mips/kernel/signal.c	29 Nov 2004 13:21:07 -0000	1.81
+++ arch/mips/kernel/signal.c	30 Nov 2004 05:39:51 -0000
@@ -29,12 +29,15 @@
 #include <asm/sim.h>
 #include <asm/uaccess.h>
 #include <asm/ucontext.h>
+#include <asm/cpu-features.h>
+
+#include "signal64.h"
 
 #define DEBUG_SIG 0
 
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
-extern asmlinkage int do_signal(sigset_t *oldset, struct pt_regs *regs);
+static int do_signal(sigset_t *oldset, struct pt_regs *regs);
 
 /*
  * Atomically swap in the new signal mask, and wait for a signal.
@@ -152,51 +155,6 @@ asmlinkage int sys_sigaltstack(nabi_no_r
 	return do_sigaltstack(uss, uoss, usp);
 }
 
-asmlinkage int restore_sigcontext(struct pt_regs *regs, struct sigcontext *sc)
-{
-	int err = 0;
-
-	/* Always make any pending restarted system calls return -EINTR */
-	current_thread_info()->restart_block.fn = do_no_restart_syscall;
-
-	err |= __get_user(regs->cp0_epc, &sc->sc_pc);
-	err |= __get_user(regs->hi, &sc->sc_mdhi);
-	err |= __get_user(regs->lo, &sc->sc_mdlo);
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
-	err |= __get_user(current->used_math, &sc->sc_used_math);
-
-	preempt_disable();
-
-	if (current->used_math) {
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
-
 #if PLAT_TRAMPOLINE_STUFF_LINE
 #define __tramp __attribute__((aligned(PLAT_TRAMPOLINE_STUFF_LINE)))
 #else
@@ -220,7 +178,9 @@ struct rt_sigframe {
 };
 
 #ifdef CONFIG_TRAD_SIGNALS
-asmlinkage void sys_sigreturn(struct pt_regs regs)
+save_static_function(sys_sigreturn);
+__attribute_used__ noinline static void
+_sys_sigreturn(nabi_no_regargs struct pt_regs regs)
 {
 	struct sigframe *frame;
 	sigset_t blocked;
@@ -257,7 +217,9 @@ badframe:
 }
 #endif
 
-asmlinkage void sys_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
+save_static_function(sys_rt_sigreturn);
+__attribute_used__ noinline static void
+_sys_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
 {
 	struct rt_sigframe *frame;
 	sigset_t set;
@@ -298,85 +260,6 @@ badframe:
 	force_sig(SIGSEGV, current);
 }
 
-inline int setup_sigcontext(struct pt_regs *regs, struct sigcontext *sc)
-{
-	int err = 0;
-
-	err |= __put_user(regs->cp0_epc, &sc->sc_pc);
-	err |= __put_user(regs->cp0_status, &sc->sc_status);
-
-#define save_gp_reg(i) do {						\
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
-	err |= __put_user(regs->cp0_cause, &sc->sc_cause);
-	err |= __put_user(regs->cp0_badvaddr, &sc->sc_badvaddr);
-
-	err |= __put_user(current->used_math, &sc->sc_used_math);
-
-	if (!current->used_math)
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
-	err |= save_fp_context(sc);
-
-	preempt_enable();
-
-out:
-	return err;
-}
-
-/*
- * Determine which stack to use..
- */
-static inline void *get_sigframe(struct k_sigaction *ka, struct pt_regs *regs,
-	size_t frame_size)
-{
-	unsigned long sp, almask;
-
-	/* Default to using normal stack */
-	sp = regs->regs[29];
-
-	/*
- 	 * FPU emulator may have it's own trampoline active just
- 	 * above the user stack, 16-bytes before the next lowest
- 	 * 16 byte boundary.  Try to avoid trashing it.
- 	 */
- 	sp -= 32;
-
-	/* This is the X/Open sanctioned signal stack switching.  */
-	if ((ka->sa.sa_flags & SA_ONSTACK) && (sas_ss_flags (sp) == 0))
-		sp = current->sas_ss_sp + current->sas_ss_size;
-
-	if (PLAT_TRAMPOLINE_STUFF_LINE)
-		almask = ~(PLAT_TRAMPOLINE_STUFF_LINE - 1);
-	else
-		almask = ALMASK;
-
-	return (void *)((sp - frame_size) & almask);
-}
-
 #ifdef CONFIG_TRAD_SIGNALS
 static void inline setup_frame(struct k_sigaction * ka, struct pt_regs *regs,
 	int signr, sigset_t *set)
@@ -395,8 +278,7 @@ static void inline setup_frame(struct k_
 	 *         syscall
 	 */
 	if (PLAT_TRAMPOLINE_STUFF_LINE)
-		__builtin_memset(frame->sf_code, '0',
-		                 PLAT_TRAMPOLINE_STUFF_LINE);
+		__clear_user(frame->sf_code, PLAT_TRAMPOLINE_STUFF_LINE);
 	err |= __put_user(0x24020000 + __NR_sigreturn, frame->sf_code + 0);
 	err |= __put_user(0x0000000c                 , frame->sf_code + 1);
 	flush_cache_sigtramp((unsigned long) frame->sf_code);
@@ -452,8 +334,7 @@ static void inline setup_rt_frame(struct
 	 *         syscall
 	 */
 	if (PLAT_TRAMPOLINE_STUFF_LINE)
-		__builtin_memset(frame->rs_code, '0',
-		                 PLAT_TRAMPOLINE_STUFF_LINE);
+		__clear_user(frame->rs_code, PLAT_TRAMPOLINE_STUFF_LINE);
 	err |= __put_user(0x24020000 + __NR_rt_sigreturn, frame->rs_code + 0);
 	err |= __put_user(0x0000000c                    , frame->rs_code + 1);
 	flush_cache_sigtramp((unsigned long) frame->rs_code);
@@ -557,7 +438,7 @@ static inline void handle_signal(unsigne
 extern int do_signal32(sigset_t *oldset, struct pt_regs *regs);
 extern int do_irix_signal(sigset_t *oldset, struct pt_regs *regs);
 
-asmlinkage int do_signal(sigset_t *oldset, struct pt_regs *regs)
+static int do_signal(sigset_t *oldset, struct pt_regs *regs)
 {
 	struct k_sigaction ka;
 	siginfo_t info;
Index: arch/mips/kernel/signal32.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/signal32.c,v
retrieving revision 1.18
diff -u -p -r1.18 signal32.c
--- arch/mips/kernel/signal32.c	11 Nov 2004 14:09:09 -0000	1.18
+++ arch/mips/kernel/signal32.c	30 Nov 2004 05:39:51 -0000
@@ -106,7 +106,7 @@ typedef struct siginfo32 {
 
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
-extern asmlinkage int do_signal32(sigset_t *oldset, struct pt_regs *regs);
+extern int do_signal32(sigset_t *oldset, struct pt_regs *regs);
 
 /* 32-bit compatibility types */
 
@@ -192,6 +192,7 @@ static inline int get_sigset(sigset_t *k
 /*
  * Atomically swap in the new signal mask, and wait for a signal.
  */
+
 save_static_function(sys32_sigsuspend);
 __attribute_used__ noinline static int
 _sys32_sigsuspend(nabi_no_regargs struct pt_regs regs)
@@ -333,8 +334,7 @@ asmlinkage int sys32_sigaltstack(nabi_no
 	return ret;
 }
 
-static asmlinkage int restore_sigcontext32(struct pt_regs *regs,
-					   struct sigcontext32 *sc)
+static int restore_sigcontext32(struct pt_regs *regs, struct sigcontext32 *sc)
 {
 	int err = 0;
 
@@ -440,7 +440,9 @@ static int copy_siginfo_to_user32(siginf
 	return err;
 }
 
-asmlinkage void sys32_sigreturn(nabi_no_regargs struct pt_regs regs)
+save_static_function(sys32_sigreturn);
+__attribute_used__ noinline static void
+_sys32_sigreturn(nabi_no_regargs struct pt_regs regs)
 {
 	struct sigframe *frame;
 	sigset_t blocked;
@@ -476,7 +478,9 @@ badframe:
 	force_sig(SIGSEGV, current);
 }
 
-asmlinkage void sys32_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
+save_static_function(sys32_rt_sigreturn);
+__attribute_used__ noinline static void
+_sys32_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
 {
 	struct rt_sigframe32 *frame;
 	sigset_t set;
@@ -759,7 +763,7 @@ static inline void handle_signal(unsigne
 	}
 }
 
-asmlinkage int do_signal32(sigset_t *oldset, struct pt_regs *regs)
+int do_signal32(sigset_t *oldset, struct pt_regs *regs)
 {
 	struct k_sigaction ka;
 	siginfo_t info;
Index: arch/mips/kernel/signal_n32.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/signal_n32.c,v
retrieving revision 1.8
diff -u -p -r1.8 signal_n32.c
--- arch/mips/kernel/signal_n32.c	25 Oct 2004 20:44:17 -0000	1.8
+++ arch/mips/kernel/signal_n32.c	30 Nov 2004 05:39:51 -0000
@@ -35,6 +35,9 @@
 #include <asm/ucontext.h>
 #include <asm/system.h>
 #include <asm/fpu.h>
+#include <asm/cpu-features.h>
+
+#include "signal64.h"
 
 /*
  * Including <asm/unistd.h would give use the 64-bit syscall numbers ...
@@ -59,17 +62,22 @@ struct ucontextn32 {
 	sigset_t            uc_sigmask;   /* mask last for extensibility */
 };
 
+#if PLAT_TRAMPOLINE_STUFF_LINE
+#define __tramp __attribute__((aligned(PLAT_TRAMPOLINE_STUFF_LINE)))
+#else
+#define __tramp
+#endif
+
 struct rt_sigframe_n32 {
 	u32 rs_ass[4];			/* argument save space for o32 */
-	u32 rs_code[2];			/* signal trampoline */
-	struct siginfo rs_info;
+	u32 rs_code[2] __tramp;		/* signal trampoline */
+	struct siginfo rs_info __tramp;
 	struct ucontextn32 rs_uc;
 };
 
-extern asmlinkage int restore_sigcontext(struct pt_regs *regs, struct sigcontext *sc);
-extern int inline setup_sigcontext(struct pt_regs *regs, struct sigcontext *sc);
-
-asmlinkage void sysn32_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
+save_static_function(sysn32_rt_sigreturn);
+__attribute_used__ noinline static void
+_sysn32_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
 {
 	struct rt_sigframe_n32 *frame;
 	sigset_t set;
@@ -118,31 +126,6 @@ badframe:
 	force_sig(SIGSEGV, current);
 }
 
-/*
- * Determine which stack to use..
- */
-static inline void *get_sigframe(struct k_sigaction *ka, struct pt_regs *regs,
-	size_t frame_size)
-{
-	unsigned long sp;
-
-	/* Default to using normal stack */
-	sp = regs->regs[29];
-
-	/*
- 	 * FPU emulator may have it's own trampoline active just
- 	 * above the user stack, 16-bytes before the next lowest
- 	 * 16 byte boundary.  Try to avoid trashing it.
- 	 */
- 	sp -= 32;
-
-	/* This is the X/Open sanctioned signal stack switching.  */
-	if ((ka->sa.sa_flags & SA_ONSTACK) && (sas_ss_flags (sp) == 0))
-		sp = current->sas_ss_sp + current->sas_ss_size;
-
-	return (void *)((sp - frame_size) & ALMASK);
-}
-
 void setup_rt_frame_n32(struct k_sigaction * ka,
 	struct pt_regs *regs, int signr, sigset_t *set, siginfo_t *info)
 {
@@ -160,8 +143,10 @@ void setup_rt_frame_n32(struct k_sigacti
 	 *         li      v0, __NR_rt_sigreturn
 	 *         syscall
 	 */
+	if (PLAT_TRAMPOLINE_STUFF_LINE)
+		__clear_user(frame->rs_code, PLAT_TRAMPOLINE_STUFF_LINE);
 	err |= __put_user(0x24020000 + __NR_N32_rt_sigreturn, frame->rs_code + 0);
-	err |= __put_user(0x0000000c                    , frame->rs_code + 1);
+	err |= __put_user(0x0000000c                        , frame->rs_code + 1);
 	flush_cache_sigtramp((unsigned long) frame->rs_code);
 
 	/* Create siginfo.  */
--- /dev/null	2004-08-24 19:23:08.000000000 +0200
+++ arch/mips/kernel/signal64.h	2004-11-30 06:29:37.000000000 +0100
@@ -0,0 +1,125 @@
+extern inline int
+setup_sigcontext(struct pt_regs *regs, struct sigcontext *sc)
+{
+	int err = 0;
+
+	err |= __put_user(regs->cp0_epc, &sc->sc_pc);
+	err |= __put_user(regs->cp0_status, &sc->sc_status);
+
+#define save_gp_reg(i) do {						\
+	err |= __put_user(regs->regs[i], &sc->sc_regs[i]);		\
+} while(0)
+	__put_user(0, &sc->sc_regs[0]); save_gp_reg(1); save_gp_reg(2);
+	save_gp_reg(3); save_gp_reg(4); save_gp_reg(5); save_gp_reg(6);
+	save_gp_reg(7); save_gp_reg(8); save_gp_reg(9); save_gp_reg(10);
+	save_gp_reg(11); save_gp_reg(12); save_gp_reg(13); save_gp_reg(14);
+	save_gp_reg(15); save_gp_reg(16); save_gp_reg(17); save_gp_reg(18);
+	save_gp_reg(19); save_gp_reg(20); save_gp_reg(21); save_gp_reg(22);
+	save_gp_reg(23); save_gp_reg(24); save_gp_reg(25); save_gp_reg(26);
+	save_gp_reg(27); save_gp_reg(28); save_gp_reg(29); save_gp_reg(30);
+	save_gp_reg(31);
+#undef save_gp_reg
+
+	err |= __put_user(regs->hi, &sc->sc_mdhi);
+	err |= __put_user(regs->lo, &sc->sc_mdlo);
+	err |= __put_user(regs->cp0_cause, &sc->sc_cause);
+	err |= __put_user(regs->cp0_badvaddr, &sc->sc_badvaddr);
+
+	err |= __put_user(current->used_math, &sc->sc_used_math);
+
+	if (!current->used_math)
+		goto out;
+
+	/*
+	 * Save FPU state to signal context.  Signal handler will "inherit"
+	 * current FPU state.
+	 */
+	preempt_disable();
+
+	if (!is_fpu_owner()) {
+		own_fpu();
+		restore_fp(current);
+	}
+	err |= save_fp_context(sc);
+
+	preempt_enable();
+
+out:
+	return err;
+}
+
+extern inline int
+restore_sigcontext(struct pt_regs *regs, struct sigcontext *sc)
+{
+	int err = 0;
+
+	/* Always make any pending restarted system calls return -EINTR */
+	current_thread_info()->restart_block.fn = do_no_restart_syscall;
+
+	err |= __get_user(regs->cp0_epc, &sc->sc_pc);
+	err |= __get_user(regs->hi, &sc->sc_mdhi);
+	err |= __get_user(regs->lo, &sc->sc_mdlo);
+
+#define restore_gp_reg(i) do {						\
+	err |= __get_user(regs->regs[i], &sc->sc_regs[i]);		\
+} while(0)
+	restore_gp_reg( 1); restore_gp_reg( 2); restore_gp_reg( 3);
+	restore_gp_reg( 4); restore_gp_reg( 5); restore_gp_reg( 6);
+	restore_gp_reg( 7); restore_gp_reg( 8); restore_gp_reg( 9);
+	restore_gp_reg(10); restore_gp_reg(11); restore_gp_reg(12);
+	restore_gp_reg(13); restore_gp_reg(14); restore_gp_reg(15);
+	restore_gp_reg(16); restore_gp_reg(17); restore_gp_reg(18);
+	restore_gp_reg(19); restore_gp_reg(20); restore_gp_reg(21);
+	restore_gp_reg(22); restore_gp_reg(23); restore_gp_reg(24);
+	restore_gp_reg(25); restore_gp_reg(26); restore_gp_reg(27);
+	restore_gp_reg(28); restore_gp_reg(29); restore_gp_reg(30);
+	restore_gp_reg(31);
+#undef restore_gp_reg
+
+	err |= __get_user(current->used_math, &sc->sc_used_math);
+
+	preempt_disable();
+
+	if (current->used_math) {
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
+/*
+ * Determine which stack to use..
+ */
+extern inline void *
+get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size)
+{
+	unsigned long sp, almask;
+
+	/* Default to using normal stack */
+	sp = regs->regs[29];
+
+	/*
+ 	 * FPU emulator may have it's own trampoline active just
+ 	 * above the user stack, 16-bytes before the next lowest
+ 	 * 16 byte boundary.  Try to avoid trashing it.
+ 	 */
+ 	sp -= 32;
+
+	/* This is the X/Open sanctioned signal stack switching.  */
+	if ((ka->sa.sa_flags & SA_ONSTACK) && (sas_ss_flags (sp) == 0))
+		sp = current->sas_ss_sp + current->sas_ss_size;
+
+	if (PLAT_TRAMPOLINE_STUFF_LINE)
+		almask = ~(PLAT_TRAMPOLINE_STUFF_LINE - 1);
+	else
+		almask = ALMASK;
+
+	return (void *)((sp - frame_size) & almask);
+}
