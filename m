Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Apr 2007 18:46:12 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:58328 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022028AbXDMRqK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 13 Apr 2007 18:46:10 +0100
Received: from localhost (p6152-ipad02funabasi.chiba.ocn.ne.jp [61.214.24.152])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 62C33B80B; Sat, 14 Apr 2007 02:44:50 +0900 (JST)
Date:	Sat, 14 Apr 2007 02:44:50 +0900 (JST)
Message-Id: <20070414.024450.07456615.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [PATCH] Disallow CpU exception in kernel again.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070414.023726.128617751.anemo@mba.ocn.ne.jp>
References: <20070414.022143.82357892.anemo@mba.ocn.ne.jp>
	<20070414.023726.128617751.anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14838
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 14 Apr 2007 02:37:26 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> Subject: [PATCH] Disallow CpU exception in kernel again.
> 
> The commit 4d40bff7110e9e1a97ff8c01bdd6350e9867cc10 ("Allow CpU
> exception in kernel partially") was broken.  The commit was to fix
> theoretical problem but broke usual case.  Revert it for now.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

And this is for 2.6.20-stable.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/kernel/r2300_switch.S  |   10 ++++------
 arch/mips/kernel/r4k_switch.S    |   10 ++++------
 arch/mips/kernel/signal-common.h |   10 +++++-----
 arch/mips/kernel/signal32.c      |   10 +++++-----
 arch/mips/kernel/traps.c         |   21 +++------------------
 include/asm-mips/fpu.h           |   16 ----------------
 include/asm-mips/thread_info.h   |    1 -
 7 files changed, 21 insertions(+), 57 deletions(-)

diff --git a/arch/mips/kernel/r2300_switch.S b/arch/mips/kernel/r2300_switch.S
index 28c2e2e..656bde2 100644
--- a/arch/mips/kernel/r2300_switch.S
+++ b/arch/mips/kernel/r2300_switch.S
@@ -49,7 +49,8 @@ LEAF(resume)
 #ifndef CONFIG_CPU_HAS_LLSC
 	sw      zero, ll_bit
 #endif
-	mfc0	t2, CP0_STATUS
+	mfc0	t1, CP0_STATUS
+	sw	t1, THREAD_STATUS(a0)
 	cpu_save_nonscratch a0
 	sw	ra, THREAD_REG31(a0)
 
@@ -59,8 +60,8 @@ LEAF(resume)
 	lw	t3, TASK_THREAD_INFO(a0)
 	lw	t0, TI_FLAGS(t3)
 	li	t1, _TIF_USEDFPU
-	and	t1, t0
-	beqz	t1, 1f
+	and	t2, t0, t1
+	beqz	t2, 1f
 	nor	t1, zero, t1
 
 	and	t0, t0, t1
@@ -73,13 +74,10 @@ LEAF(resume)
 	li	t1, ~ST0_CU1
 	and	t0, t0, t1
 	sw	t0, ST_OFF(t3)
-	/* clear thread_struct CU1 bit */
-	and	t2, t1
 
 	fpu_save_single a0, t0			# clobbers t0
 
 1:
-	sw	t2, THREAD_STATUS(a0)
 	/*
 	 * The order of restoring the registers takes care of the race
 	 * updating $28, $29 and kernelsp without disabling ints.
diff --git a/arch/mips/kernel/r4k_switch.S b/arch/mips/kernel/r4k_switch.S
index c7698fd..cc566cf 100644
--- a/arch/mips/kernel/r4k_switch.S
+++ b/arch/mips/kernel/r4k_switch.S
@@ -48,7 +48,8 @@
 #ifndef CONFIG_CPU_HAS_LLSC
 	sw	zero, ll_bit
 #endif
-	mfc0	t2, CP0_STATUS
+	mfc0	t1, CP0_STATUS
+	LONG_S	t1, THREAD_STATUS(a0)
 	cpu_save_nonscratch a0
 	LONG_S	ra, THREAD_REG31(a0)
 
@@ -58,8 +59,8 @@
 	PTR_L	t3, TASK_THREAD_INFO(a0)
 	LONG_L	t0, TI_FLAGS(t3)
 	li	t1, _TIF_USEDFPU
-	and	t1, t0
-	beqz	t1, 1f
+	and	t2, t0, t1
+	beqz	t2, 1f
 	nor	t1, zero, t1
 
 	and	t0, t0, t1
@@ -72,13 +73,10 @@
 	li	t1, ~ST0_CU1
 	and	t0, t0, t1
 	LONG_S	t0, ST_OFF(t3)
-	/* clear thread_struct CU1 bit */
-	and	t2, t1
 
 	fpu_save_double a0 t0 t1		# c0_status passed in t0
 						# clobbers t1
 1:
-	LONG_S	t2, THREAD_STATUS(a0)
 
 	/*
 	 * The order of restoring the registers takes care of the race
diff --git a/arch/mips/kernel/signal-common.h b/arch/mips/kernel/signal-common.h
index 87d8320..b625e9c 100644
--- a/arch/mips/kernel/signal-common.h
+++ b/arch/mips/kernel/signal-common.h
@@ -51,10 +51,10 @@ setup_sigcontext(struct pt_regs *regs, s
 	 * Save FPU state to signal context.  Signal handler will "inherit"
 	 * current FPU state.
 	 */
+	preempt_disable();
 	own_fpu(1);
-	enable_fp_in_kernel();
 	err |= save_fp_context(sc);
-	disable_fp_in_kernel();
+	preempt_enable();
 
 out:
 	return err;
@@ -71,7 +71,10 @@ check_and_restore_fp_context(struct sigc
 	err = sig = fpcsr_pending(&sc->sc_fpc_csr);
 	if (err > 0)
 		err = 0;
+	preempt_disable();
+	own_fpu(0);
 	err |= restore_fp_context(sc);
+	preempt_enable();
 	return err ?: sig;
 }
 
@@ -119,11 +122,8 @@ restore_sigcontext(struct pt_regs *regs,
 
 	if (used_math()) {
 		/* restore fpu context if we have used it before */
-		own_fpu(0);
-		enable_fp_in_kernel();
 		if (!err)
 			err = check_and_restore_fp_context(sc);
-		disable_fp_in_kernel();
 	} else {
 		/* signal handler may have used FPU.  Give it up. */
 		lose_fpu(0);
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index 4a32f99..1a3f541 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -145,7 +145,10 @@ check_and_restore_fp_context32(struct si
 	err = sig = fpcsr_pending(&sc->sc_fpc_csr);
 	if (err > 0)
 		err = 0;
+	preempt_disable();
+	own_fpu(0);
 	err |= restore_fp_context32(sc);
+	preempt_enable();
 	return err ?: sig;
 }
 
@@ -379,11 +382,8 @@ static int restore_sigcontext32(struct p
 
 	if (used_math()) {
 		/* restore fpu context if we have used it before */
-		own_fpu(0);
-		enable_fp_in_kernel();
 		if (!err)
 			err = check_and_restore_fp_context32(sc);
-		disable_fp_in_kernel();
 	} else {
 		/* signal handler may have used FPU.  Give it up. */
 		lose_fpu(0);
@@ -614,10 +614,10 @@ static inline int setup_sigcontext32(str
 	 * Save FPU state to signal context.  Signal handler will "inherit"
 	 * current FPU state.
 	 */
+	preempt_disable();
 	own_fpu(1);
-	enable_fp_in_kernel();
 	err |= save_fp_context32(sc);
-	disable_fp_in_kernel();
+	preempt_enable();
 
 out:
 	return err;
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index afb09e8..64b9dfb 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -758,11 +758,12 @@ asmlinkage void do_cpu(struct pt_regs *r
 {
 	unsigned int cpid;
 
+	die_if_kernel("do_cpu invoked from kernel context!", regs);
+
 	cpid = (regs->cp0_cause >> CAUSEB_CE) & 3;
 
 	switch (cpid) {
 	case 0:
-		die_if_kernel("do_cpu invoked from kernel context!", regs);
 		if (!cpu_has_llsc)
 			if (!simulate_llsc(regs))
 				return;
@@ -773,9 +774,6 @@ asmlinkage void do_cpu(struct pt_regs *r
 		break;
 
 	case 1:
-		if (!test_thread_flag(TIF_ALLOW_FP_IN_KERNEL))
-			die_if_kernel("do_cpu invoked from kernel context!",
-				      regs);
 		if (used_math())	/* Using the FPU again.  */
 			own_fpu(1);
 		else {			/* First time FPU user.  */
@@ -783,19 +781,7 @@ asmlinkage void do_cpu(struct pt_regs *r
 			set_used_math();
 		}
 
-		if (raw_cpu_has_fpu) {
-			if (test_thread_flag(TIF_ALLOW_FP_IN_KERNEL)) {
-				local_irq_disable();
-				if (cpu_has_fpu)
-					regs->cp0_status |= ST0_CU1;
-				/*
-				 * We must return without enabling
-				 * interrupts to ensure keep FPU
-				 * ownership until resume.
-				 */
-				return;
-			}
-		} else {
+		if (!raw_cpu_has_fpu) {
 			int sig;
 			sig = fpu_emulator_cop1Handler(regs,
 						&current->thread.fpu, 0);
@@ -837,7 +823,6 @@ asmlinkage void do_cpu(struct pt_regs *r
 
 	case 2:
 	case 3:
-		die_if_kernel("do_cpu invoked from kernel context!", regs);
 		break;
 	}
 
diff --git a/include/asm-mips/fpu.h b/include/asm-mips/fpu.h
index dfecb7b..6b9d1bf 100644
--- a/include/asm-mips/fpu.h
+++ b/include/asm-mips/fpu.h
@@ -68,8 +68,6 @@ do {									\
 	/* We don't care about the c0 hazard here  */			\
 } while (0)
 
-#define __fpu_enabled()	(read_c0_status() & ST0_CU1)
-
 #define enable_fpu()							\
 do {									\
 	if (cpu_has_fpu)						\
@@ -162,18 +160,4 @@ static inline fpureg_t *get_fpu_regs(str
 	return tsk->thread.fpu.fpr;
 }
 
-static inline void enable_fp_in_kernel(void)
-{
-	set_thread_flag(TIF_ALLOW_FP_IN_KERNEL);
-	/* make sure CU1 and FPU ownership are consistent */
-	if (!__is_fpu_owner() && __fpu_enabled())
-		__disable_fpu();
-}
-
-static inline void disable_fp_in_kernel(void)
-{
-	BUG_ON(!__is_fpu_owner() && __fpu_enabled());
-	clear_thread_flag(TIF_ALLOW_FP_IN_KERNEL);
-}
-
 #endif /* _ASM_FPU_H */
diff --git a/include/asm-mips/thread_info.h b/include/asm-mips/thread_info.h
index 6cf05f4..fbcda82 100644
--- a/include/asm-mips/thread_info.h
+++ b/include/asm-mips/thread_info.h
@@ -119,7 +119,6 @@ register struct thread_info *__current_t
 #define TIF_POLLING_NRFLAG	17	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_MEMDIE		18
 #define TIF_FREEZE		19
-#define TIF_ALLOW_FP_IN_KERNEL	20
 #define TIF_SYSCALL_TRACE	31	/* syscall trace active */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
