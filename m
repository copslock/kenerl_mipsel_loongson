Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Apr 2007 18:23:10 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:14059 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022002AbXDMRXE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 13 Apr 2007 18:23:04 +0100
Received: from localhost (p6152-ipad02funabasi.chiba.ocn.ne.jp [61.214.24.152])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 30B81B845; Sat, 14 Apr 2007 02:21:43 +0900 (JST)
Date:	Sat, 14 Apr 2007 02:21:43 +0900 (JST)
Message-Id: <20070414.022143.82357892.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Disallow CpU exception in kernel again.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
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
X-archive-position: 14835
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

The commit 4d40bff7110e9e1a97ff8c01bdd6350e9867cc10 ("Allow CpU
exception in kernel partially") was broken.  The commit was to fix
theoretical problem but broke usual case.  Revert it for now.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/kernel/r2300_switch.S |   10 ++++------
 arch/mips/kernel/r4k_switch.S   |   10 ++++------
 arch/mips/kernel/signal.c       |   10 +++++-----
 arch/mips/kernel/signal32.c     |   10 +++++-----
 arch/mips/kernel/traps.c        |   21 +++------------------
 include/asm-mips/fpu.h          |   16 ----------------
 include/asm-mips/thread_info.h  |    1 -
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
diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 8c3c5a5..fa58119 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -113,10 +113,10 @@ int setup_sigcontext(struct pt_regs *reg
 		 * Save FPU state to signal context. Signal handler
 		 * will "inherit" current FPU state.
 		 */
+		preempt_disable();
 		own_fpu(1);
-		enable_fp_in_kernel();
 		err |= save_fp_context(sc);
-		disable_fp_in_kernel();
+		preempt_enable();
 	}
 	return err;
 }
@@ -148,7 +148,10 @@ check_and_restore_fp_context(struct sigc
 	err = sig = fpcsr_pending(&sc->sc_fpc_csr);
 	if (err > 0)
 		err = 0;
+	preempt_disable();
+	own_fpu(0);
 	err |= restore_fp_context(sc);
+	preempt_enable();
 	return err ?: sig;
 }
 
@@ -187,11 +190,8 @@ int restore_sigcontext(struct pt_regs *r
 
 	if (used_math) {
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
index 151fd2f..2cfdd78 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -209,10 +209,10 @@ static int setup_sigcontext32(struct pt_
 		 * Save FPU state to signal context.  Signal handler
 		 * will "inherit" current FPU state.
 		 */
+		preempt_disable();
 		own_fpu(1);
-		enable_fp_in_kernel();
 		err |= save_fp_context32(sc);
-		disable_fp_in_kernel();
+		preempt_enable();
 	}
 	return err;
 }
@@ -225,6 +225,9 @@ check_and_restore_fp_context32(struct si
 	err = sig = fpcsr_pending(&sc->sc_fpc_csr);
 	if (err > 0)
 		err = 0;
+	preempt_disable();
+	own_fpu(0);
+	preempt_enable();
 	err |= restore_fp_context32(sc);
 	return err ?: sig;
 }
@@ -261,11 +264,8 @@ static int restore_sigcontext32(struct p
 
 	if (used_math) {
 		/* restore fpu context if we have used it before */
-		own_fpu(0);
-		enable_fp_in_kernel();
 		if (!err)
 			err = check_and_restore_fp_context32(sc);
-		disable_fp_in_kernel();
 	} else {
 		/* signal handler may have used FPU.  Give it up. */
 		lose_fpu(0);
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 56a770c..493cb29 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -757,11 +757,12 @@ asmlinkage void do_cpu(struct pt_regs *r
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
@@ -772,9 +773,6 @@ asmlinkage void do_cpu(struct pt_regs *r
 		break;
 
 	case 1:
-		if (!test_thread_flag(TIF_ALLOW_FP_IN_KERNEL))
-			die_if_kernel("do_cpu invoked from kernel context!",
-				      regs);
 		if (used_math())	/* Using the FPU again.  */
 			own_fpu(1);
 		else {			/* First time FPU user.  */
@@ -782,19 +780,7 @@ asmlinkage void do_cpu(struct pt_regs *r
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
@@ -836,7 +822,6 @@ asmlinkage void do_cpu(struct pt_regs *r
 
 	case 2:
 	case 3:
-		die_if_kernel("do_cpu invoked from kernel context!", regs);
 		break;
 	}
 
diff --git a/include/asm-mips/fpu.h b/include/asm-mips/fpu.h
index 4e12d1f..71436f9 100644
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
