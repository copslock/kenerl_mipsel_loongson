Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Nov 2002 20:25:04 +0100 (CET)
Received: from gateway-1237.mvista.com ([12.44.186.158]:12278 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S1121744AbSKATYJ>;
	Fri, 1 Nov 2002 20:24:09 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id gA1JO0W03948;
	Fri, 1 Nov 2002 11:24:00 -0800
Date: Fri, 1 Nov 2002 11:24:00 -0800
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH, 2.4&2.5, 32bit&64bit] new fpu code
Message-ID: <20021101112400.A2429@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 550
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Whew!  What an effort to create a patch for 4 arches instead of one!

Anyhow, attached are the complete patches for the new FPU context 
management code, for both 2.4 and 2.5, 32bit and 64bit.

. Get rid of lazy fpu switch.  New algorithm is SMP safe.
. Simplify signal/fpu handling
. Simplify FPU register access
. Unify FPU code between 2.4 and 2.5, and between 32bit and 64bit

Ralf, good enough?

Jun

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="021101.24-new-fpu-complete.patch"

diff -Nru link/arch/mips/kernel/process.c.orig link/arch/mips/kernel/process.c
--- link/arch/mips/kernel/process.c.orig	Tue Jul  2 08:47:33 2002
+++ link/arch/mips/kernel/process.c	Mon Oct 28 11:00:44 2002
@@ -21,6 +21,7 @@
 
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
+#include <asm/fpu.h>
 #include <asm/pgtable.h>
 #include <asm/system.h>
 #include <asm/mipsregs.h>
@@ -47,28 +48,25 @@
 	}
 }
 
-struct task_struct *last_task_used_math = NULL;
-
 asmlinkage void ret_from_fork(void);
 
+void start_thread(struct pt_regs * regs, unsigned long pc, unsigned long sp)
+{
+	regs->cp0_status &= ~(ST0_CU0|ST0_KSU|ST0_CU1);
+       	regs->cp0_status |= KU_USER;
+	current->used_math = 0;
+	loose_fpu();
+	regs->cp0_epc = pc;
+	regs->regs[29] = sp;
+	current->thread.current_ds = USER_DS;
+}
+
 void exit_thread(void)
 {
-	/* Forget lazy fpu state */
-	if (last_task_used_math == current && mips_cpu.options & MIPS_CPU_FPU) {
-		__enable_fpu();
-		__asm__ __volatile__("cfc1\t$0,$31");
-		last_task_used_math = NULL;
-	}
 }
 
 void flush_thread(void)
 {
-	/* Forget lazy fpu state */
-	if (last_task_used_math == current && mips_cpu.options & MIPS_CPU_FPU) {
-		__enable_fpu();
-		__asm__ __volatile__("cfc1\t$0,$31");
-		last_task_used_math = NULL;
-	}
 }
 
 int copy_thread(int nr, unsigned long clone_flags, unsigned long usp,
@@ -80,11 +78,10 @@
 
 	childksp = (unsigned long)p + KERNEL_STACK_SIZE - 32;
 
-	if (last_task_used_math == current)
-		if (mips_cpu.options & MIPS_CPU_FPU) {
-			__enable_fpu();
-			save_fp(p);
-		}
+	if (is_fpu_owner()) {
+		save_fp(p);
+	}
+	
 	/* set up new TSS. */
 	childregs = (struct pt_regs *) childksp - 1;
 	*childregs = *regs;
diff -Nru link/arch/mips/kernel/ptrace.c.orig link/arch/mips/kernel/ptrace.c
--- link/arch/mips/kernel/ptrace.c.orig	Mon Oct  7 07:34:14 2002
+++ link/arch/mips/kernel/ptrace.c	Mon Oct 28 11:08:26 2002
@@ -27,6 +27,7 @@
 #include <asm/uaccess.h>
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
+#include <asm/fpu.h>
 
 /*
  * Called by kernel/ptrace.c when detaching..
@@ -42,7 +43,6 @@
 {
 	struct task_struct *child;
 	int ret;
-	extern void save_fp(struct task_struct *);
 
 	lock_kernel();
 #if 0
@@ -113,20 +113,7 @@
 			break;
 		case FPR_BASE ... FPR_BASE + 31:
 			if (child->used_math) {
-			        unsigned long long *fregs
-					= (unsigned long long *)
-					    &child->thread.fpu.hard.fp_regs[0];
-			 	if(!(mips_cpu.options & MIPS_CPU_FPU)) {
-					fregs = (unsigned long long *)
-						child->thread.fpu.soft.regs;
-				} else
-					if (last_task_used_math == child) {
-						__enable_fpu();
-						save_fp(child);
-						__disable_fpu();
-						last_task_used_math = NULL;
-						regs->cp0_status &= ~ST0_CU1;
-					}
+			        unsigned long long *fregs = get_fpu_regs(child);
 				/*
 				 * The odd registers are actually the high
 				 * order bits of the values stored in the even
@@ -204,21 +191,8 @@
 			break;
 		case FPR_BASE ... FPR_BASE + 31: {
 			unsigned long long *fregs;
-			fregs = (unsigned long long *)&child->thread.fpu.hard.fp_regs[0];
-			if (child->used_math) {
-				if (last_task_used_math == child) {
-					if(!(mips_cpu.options & MIPS_CPU_FPU)) {
-						fregs = (unsigned long long *)
-						child->thread.fpu.soft.regs;
-					} else {
-						__enable_fpu();
-						save_fp(child);
-						__disable_fpu();
-						last_task_used_math = NULL;
-						regs->cp0_status &= ~ST0_CU1;
-					}
-				}
-			} else {
+			fregs = (unsigned long long *)get_fpu_regs(child);
+			if (!child->used_math) {
 				/* FP not yet used  */
 				memset(&child->thread.fpu.hard, ~0,
 				       sizeof(child->thread.fpu.hard));
diff -Nru link/arch/mips/kernel/signal.c.orig link/arch/mips/kernel/signal.c
--- link/arch/mips/kernel/signal.c.orig	Mon Aug  5 16:53:33 2002
+++ link/arch/mips/kernel/signal.c	Fri Nov  1 10:07:27 2002
@@ -22,6 +22,7 @@
 #include <asm/asm.h>
 #include <asm/bitops.h>
 #include <asm/cpu.h>
+#include <asm/fpu.h>
 #include <asm/offset.h>
 #include <asm/pgalloc.h>
 #include <asm/ptrace.h>
@@ -34,9 +35,6 @@
 
 extern asmlinkage int do_signal(sigset_t *oldset, struct pt_regs *regs);
 
-extern asmlinkage int (*save_fp_context)(struct sigcontext *sc);
-extern asmlinkage int (*restore_fp_context)(struct sigcontext *sc);
-
 extern asmlinkage void syscall_trace(void);
 
 int copy_siginfo_to_user(siginfo_t *to, siginfo_t *from)
@@ -185,59 +183,8 @@
 	return do_sigaltstack(uss, uoss, usp);
 }
 
-static inline int restore_thread_fp_context(struct sigcontext *sc)
-{
-	u64 *pfreg = &current->thread.fpu.soft.regs[0];
-	int err = 0;
-
-	/*
-	 * Copy all 32 64-bit values, for two reasons.  First, the R3000 and
-	 * R4000/MIPS32 kernels use the thread FP register storage differently,
-	 * such that a full copy is essentially necessary to support both.
-	 */
-
-#define restore_fpr(i) 						\
-	do { err |= __get_user(pfreg[i], &sc->sc_fpregs[i]); } while(0)
-
-	restore_fpr( 0); restore_fpr( 1); restore_fpr( 2); restore_fpr( 3);
-	restore_fpr( 4); restore_fpr( 5); restore_fpr( 6); restore_fpr( 7);
-	restore_fpr( 8); restore_fpr( 9); restore_fpr(10); restore_fpr(11);
-	restore_fpr(12); restore_fpr(13); restore_fpr(14); restore_fpr(15);
-	restore_fpr(16); restore_fpr(17); restore_fpr(18); restore_fpr(19);
-	restore_fpr(20); restore_fpr(21); restore_fpr(22); restore_fpr(23);
-	restore_fpr(24); restore_fpr(25); restore_fpr(26); restore_fpr(27);
-	restore_fpr(28); restore_fpr(29); restore_fpr(30); restore_fpr(31);
-
-	err |= __get_user(current->thread.fpu.soft.sr, &sc->sc_fpc_csr);
-
-	return err;
-}
-
-static inline int save_thread_fp_context(struct sigcontext *sc)
-{
-	u64 *pfreg = &current->thread.fpu.soft.regs[0];
-	int err = 0;
-
-#define save_fpr(i) 							\
-	do { err |= __put_user(pfreg[i], &sc->sc_fpregs[i]); } while(0)
-
-	save_fpr( 0); save_fpr( 1); save_fpr( 2); save_fpr( 3);
-	save_fpr( 4); save_fpr( 5); save_fpr( 6); save_fpr( 7);
-	save_fpr( 8); save_fpr( 9); save_fpr(10); save_fpr(11);
-	save_fpr(12); save_fpr(13); save_fpr(14); save_fpr(15);
-	save_fpr(16); save_fpr(17); save_fpr(18); save_fpr(19);
-	save_fpr(20); save_fpr(21); save_fpr(22); save_fpr(23);
-	save_fpr(24); save_fpr(25); save_fpr(26); save_fpr(27);
-	save_fpr(28); save_fpr(29); save_fpr(30); save_fpr(31);
-
-	err |= __put_user(current->thread.fpu.soft.sr, &sc->sc_fpc_csr);
-
-	return err;
-}
-
 static int restore_sigcontext(struct pt_regs *regs, struct sigcontext *sc)
 {
-	int owned_fp;
 	int err = 0;
 	u64 reg;
 
@@ -265,25 +212,17 @@
 	restore_gp_reg(31);
 #undef restore_gp_reg
 
-	err |= __get_user(owned_fp, &sc->sc_ownedfp);
 	err |= __get_user(current->used_math, &sc->sc_used_math);
 
-	if (owned_fp) {
-		err |= restore_fp_context(sc);
-		goto out;
-	}
-
-	if (current == last_task_used_math) {
-		/* Signal handler acquired FPU - give it back */
-		last_task_used_math = NULL;
-		regs->cp0_status &= ~ST0_CU1;
-	}
 	if (current->used_math) {
-		/* Undo possible contamination of thread state */
-		err |= restore_thread_fp_context(sc);
+		/* restore fpu context if we have used it before */
+		own_fpu();
+		err |= restore_fp_context(sc);
+	} else {
+		/* signal handler may have used FPU.  Give it up. */
+		loose_fpu();
 	}
 
-out:
 	return err;
 }
 
@@ -380,7 +319,6 @@
 
 static int inline setup_sigcontext(struct pt_regs *regs, struct sigcontext *sc)
 {
-	int owned_fp;
 	int err = 0;
 	u64 reg;
 
@@ -408,25 +346,20 @@
 	err |= __put_user(regs->cp0_cause, &sc->sc_cause);
 	err |= __put_user(regs->cp0_badvaddr, &sc->sc_badvaddr);
 
-	owned_fp = (current == last_task_used_math);
-	err |= __put_user(owned_fp, &sc->sc_ownedfp);
 	err |= __put_user(current->used_math, &sc->sc_used_math);
 
 	if (!current->used_math)
 		goto out;
 
-	/* There exists FP thread state that may be trashed by signal */
-	if (owned_fp) {
-		/* fp is active.  Save context from FPU */
-		err |= save_fp_context(sc);
-		goto out;
-	}
-
-	/*
-	 * Someone else has FPU.
-	 * Copy Thread context into signal context
+	/* 
+	 * Save FPU state to signal context.  Signal handler will "inherit"
+	 * current FPU state.
 	 */
-	err |= save_thread_fp_context(sc);
+	if (!is_fpu_owner()) {
+		own_fpu();
+		restore_fp(current);
+	}
+	err |= save_fp_context(sc);
 
 out:
 	return err;
diff -Nru link/arch/mips/kernel/traps.c.orig link/arch/mips/kernel/traps.c
--- link/arch/mips/kernel/traps.c.orig	Thu Oct 31 11:40:09 2002
+++ link/arch/mips/kernel/traps.c	Mon Oct 28 11:46:35 2002
@@ -24,6 +24,7 @@
 #include <asm/bootinfo.h>
 #include <asm/branch.h>
 #include <asm/cpu.h>
+#include <asm/fpu.h>
 #include <asm/cachectl.h>
 #include <asm/inst.h>
 #include <asm/jazz.h>
@@ -677,49 +678,33 @@
 asmlinkage void do_cpu(struct pt_regs *regs)
 {
 	unsigned int cpid;
-	void fpu_emulator_init_fpu(void);
-	int sig;
 
 	cpid = (regs->cp0_cause >> CAUSEB_CE) & 3;
 	if (cpid != 1)
 		goto bad_cid;
 
-	if (!(mips_cpu.options & MIPS_CPU_FPU))
-		goto fp_emul;
-
-	regs->cp0_status |= ST0_CU1;
-	if (last_task_used_math == current)
-		return;
+	die_if_kernel("do_cpu invoked from kernel context!", regs);
 
+	own_fpu();
 	if (current->used_math) {		/* Using the FPU again.  */
-		lazy_fpu_switch(last_task_used_math);
+		restore_fp(current);
 	} else {				/* First time FPU user.  */
-		if (last_task_used_math != NULL)
-			save_fp(last_task_used_math);
 		init_fpu();
 		current->used_math = 1;
 	}
-	last_task_used_math = current;
 
-	return;
-
-fp_emul:
-	if (last_task_used_math != current) {
-		if (!current->used_math) {
-			fpu_emulator_init_fpu();
-			current->used_math = 1;
+	if (!(mips_cpu.options & MIPS_CPU_FPU)) {
+		int sig = fpu_emulator_cop1Handler(0, regs, &current->thread.fpu.soft);
+		if (sig) {
+			/*
+		 	 * Return EPC is not calculated in the FPU emulator, if
+		   	 * a signal is being send. So we calculate it here.
+		 	 */
+			compute_return_epc(regs);
+			force_sig(sig, current);
 		}
 	}
-	sig = fpu_emulator_cop1Handler(0, regs, &current->thread.fpu.soft);
-	last_task_used_math = current;
-	if (sig) {
-		/*
-		 * Return EPC is not calculated in the FPU emulator, if
-		 * a signal is being send. So we calculate it here.
-		 */
-		compute_return_epc(regs);
-		force_sig(sig, current);
-	}
+
 	return;
 
 bad_cid:
@@ -901,6 +886,7 @@
 
 asmlinkage int (*save_fp_context)(struct sigcontext *sc);
 asmlinkage int (*restore_fp_context)(struct sigcontext *sc);
+
 extern asmlinkage int _save_fp_context(struct sigcontext *sc);
 extern asmlinkage int _restore_fp_context(struct sigcontext *sc);
 
diff -Nru link/arch/mips/kernel/r2300_switch.S.orig link/arch/mips/kernel/r2300_switch.S
--- link/arch/mips/kernel/r2300_switch.S.orig	Tue May 28 20:03:17 2002
+++ link/arch/mips/kernel/r2300_switch.S	Fri Nov  1 11:02:59 2002
@@ -28,6 +28,19 @@
 	.set	mips1
 	.align	5
 
+#define PF_USEDFPU      0x00100000      /* task used FPU this quantum (SMP) */
+#define ST_OFF (KERNEL_STACK_SIZE - 32 - PT_SIZE + PT_STATUS)
+
+/*
+ * [jsun] FPU context is saved if and only if the process has used FPU in 
+ * the current run (PF_USEDFPU).  In any case, the CU1 bit for user space 
+ * STATUS register should be 0, so that a process *always* starts its 
+ * userland with FPU disabled after each context switch.
+ *
+ * FPU will be enabled as soon as the process accesses FPU again, through
+ * do_cpu() trap.
+ */
+
 /*
  * task_struct *resume(task_struct *prev,
  *                     task_struct *next)
@@ -41,6 +54,32 @@
 	CPU_SAVE_NONSCRATCH(a0)
 	sw	ra, THREAD_REG31(a0)
 
+	/* 
+	 * check if we need to save FPU registers
+	 */
+	lw	t0, TASK_FLAGS(a0)
+	li	t1, PF_USEDFPU
+	and	t2, t0, t1
+	beqz	t2, 1f
+	nor	t1, zero, t1
+
+	/*
+	 * clear PF_USEDFPU bit in task flags
+	 */
+	and	t0, t0, t1
+	sw	t0, TASK_FLAGS(a0)
+
+	/*
+	 * clear user-saved stack CU1 bit
+	 */
+	lw	t0, ST_OFF(a0)
+	li	t1, ~ST0_CU1
+	and	t0, t0, t1
+	sw	t0, ST_OFF(a0)
+
+	FPU_SAVE_SINGLE(a0, t0)			# clobbers t0
+
+1:
 	/*
 	 * The order of restoring the registers takes care of the race
 	 * updating $28, $29 and kernelsp without disabling ints.
@@ -64,47 +103,20 @@
 	END(resume)
 
 /*
- * Do lazy fpu context switch.  Saves FPU context to the process in a0
- * and loads the new context of the current process.
- */
-
-#define ST_OFF (KERNEL_STACK_SIZE - 32 - PT_SIZE + PT_STATUS)
-
-LEAF(lazy_fpu_switch)
-	mfc0	t0, CP0_STATUS			# enable cp1
-	li	t3, ST0_CU1
-	or	t0, t3
-	mtc0	t0, CP0_STATUS
-
-	.set	noreorder
-	beqz	a0, 2f				# Save floating point state
-	 nor	t3, zero, t3
-	.set	reorder
-	lw	t1, ST_OFF(a0)			# last thread looses fpu
-	and	t1, t3
-	sw	t1, ST_OFF(a0)
-	FPU_SAVE_SINGLE(a0, t1)			# clobbers t1
-
-2:
-	FPU_RESTORE_SINGLE($28, t0)		# clobbers t0
-	jr	ra
-	END(lazy_fpu_switch)
-
-/*
  * Save a thread's fp context.
  */
-LEAF(save_fp)
+LEAF(_save_fp)
 	FPU_SAVE_SINGLE(a0, t1)			# clobbers t1
 	jr	ra
-	END(save_fp)
+	END(_save_fp)
 
 /*
  * Restore a thread's fp context.
  */
-LEAF(restore_fp)
+LEAF(_restore_fp)
 	FPU_RESTORE_SINGLE(a0, t1)		# clobbers t1
 	jr	ra
-	END(restore_fp)
+	END(_restore_fp)
 
 /*
  * Load the FPU with signalling NANS.  This bit pattern we're using has
@@ -116,7 +128,7 @@
 
 #define FPU_DEFAULT  0x00000000
 
-LEAF(init_fpu)
+LEAF(_init_fpu)
 	mfc0	t0, CP0_STATUS
 	li	t1, ST0_CU1
 	or	t0, t1
@@ -162,4 +174,4 @@
 	jr	ra
 	 mtc1	t0, $f31
 	.set	reorder
-	END(init_fpu)
+	END(_init_fpu)
diff -Nru link/arch/mips/kernel/r4k_switch.S.orig link/arch/mips/kernel/r4k_switch.S
--- link/arch/mips/kernel/r4k_switch.S.orig	Mon Aug  5 16:53:33 2002
+++ link/arch/mips/kernel/r4k_switch.S	Fri Nov  1 09:49:39 2002
@@ -25,6 +25,19 @@
 
 #include <asm/asmmacro.h>
 
+#define PF_USEDFPU      0x00100000      /* task used FPU this quantum (SMP) */
+#define ST_OFF (KERNEL_STACK_SIZE - 32 - PT_SIZE + PT_STATUS)
+
+/*
+ * [jsun] FPU context is saved if and only if the process has used FPU in 
+ * the current run (PF_USEDFPU).  In any case, the CU1 bit for user space 
+ * STATUS register should be 0, so that a process *always* starts its 
+ * userland with FPU disabled after each context switch.
+ *
+ * FPU will be enabled as soon as the process accesses FPU again, through 
+ * do_cpu() trap.
+ */
+
 /*
  * task_struct *r4xx0_resume(task_struct *prev, task_struct *next)
  */
@@ -39,6 +52,32 @@
 	CPU_SAVE_NONSCRATCH(a0)
 	sw	ra, THREAD_REG31(a0)
 
+	/* 
+	 * check if we need to save FPU registers
+	 */
+	lw	t0, TASK_FLAGS(a0)
+	li	t1, PF_USEDFPU
+	and	t2, t0, t1
+	beqz	t2, 1f
+	nor	t1, zero, t1
+
+	/*
+	 * clear PF_USEDFPU bit in task flags
+	 */
+	and	t0, t0, t1
+	sw	t0, TASK_FLAGS(a0)
+
+	/*
+	 * clear saved user stack CU1 bit
+	 */
+	lw	t0, ST_OFF(a0)
+	li	t1, ~ST0_CU1
+	and	t0, t0, t1
+	sw	t0, ST_OFF(a0)
+
+	FPU_SAVE_DOUBLE(a0, t0)			# clobbers t0
+
+1:
 	/*
 	 * The order of restoring the registers takes care of the race
 	 * updating $28, $29 and kernelsp without disabling ints.
@@ -69,50 +108,20 @@
 	END(resume)
 
 /*
- * Do lazy fpu context switch.  Saves FPU context to the process in a0
- * and loads the new context of the current process.
- */
-
-#define ST_OFF (KERNEL_STACK_SIZE - 32 - PT_SIZE + PT_STATUS)
-
-LEAF(lazy_fpu_switch)
-	mfc0	t0, CP0_STATUS			# enable cp1
-	li	t3, ST0_CU1
-	or	t0, t3
-	mtc0	t0, CP0_STATUS
-	FPU_ENABLE_HAZARD
-
-	beqz	a0, 2f				# Save floating point state
-	 nor	t3, zero, t3
-
-	lw	t1, ST_OFF(a0)			# last thread looses fpu
-	and	t1, t3
-	sw	t1, ST_OFF(a0)
-
-
-	FPU_SAVE_DOUBLE(a0, t1)			# clobbers t1
-2:
-
-	.set	reorder
-	FPU_RESTORE_DOUBLE($28, t0)		# clobbers t0
-	jr	ra
-	END(lazy_fpu_switch)
-
-/*
  * Save a thread's fp context.
  */
-LEAF(save_fp)
+LEAF(_save_fp)
 	FPU_SAVE_DOUBLE(a0, t1)			# clobbers t1
 	jr	ra
-	END(save_fp)
+	END(_save_fp)
 
 /*
  * Restore a thread's fp context.
  */
-LEAF(restore_fp)
+LEAF(_restore_fp)
 	FPU_RESTORE_DOUBLE(a0, t1)		# clobbers t1
 	jr	ra
-	END(restore_fp)
+	END(_restore_fp)
 
 /*
  * Load the FPU with signalling NANS.  This bit pattern we're using has
@@ -124,7 +133,7 @@
 
 #define FPU_DEFAULT  0x00000000
 
-LEAF(init_fpu)
+LEAF(_init_fpu)
 	.set	mips3
 	mfc0	t0, CP0_STATUS
 	li	t1, ST0_CU1
@@ -156,5 +165,5 @@
 	jr	ra
 	 dmtc1	t0, $f30
 	.set	reorder
-	END(init_fpu)
+	END(_init_fpu)
 
diff -Nru link/arch/mips/kernel/cpu-probe.c.orig link/arch/mips/kernel/cpu-probe.c
--- link/arch/mips/kernel/cpu-probe.c.orig	Mon Sep  2 07:41:19 2002
+++ link/arch/mips/kernel/cpu-probe.c	Mon Oct 28 13:21:35 2002
@@ -3,6 +3,7 @@
 #include <linux/stddef.h>
 #include <asm/bugs.h>
 #include <asm/cpu.h>
+#include <asm/fpu.h>
 #include <asm/mipsregs.h>
 
 /*
diff -Nru link/arch/mips/tools/offset.c.orig link/arch/mips/tools/offset.c
--- link/arch/mips/tools/offset.c.orig	Tue Jul 23 06:27:07 2002
+++ link/arch/mips/tools/offset.c	Mon Oct 28 10:56:40 2002
@@ -151,7 +151,6 @@
 	offset("#define SC_MDLO       ", struct sigcontext, sc_mdlo);
 	offset("#define SC_PC         ", struct sigcontext, sc_pc);
 	offset("#define SC_STATUS     ", struct sigcontext, sc_status);
-	offset("#define SC_OWNEDFP    ", struct sigcontext, sc_ownedfp);
 	offset("#define SC_FPC_CSR    ", struct sigcontext, sc_fpc_csr);
 	offset("#define SC_FPC_EIR    ", struct sigcontext, sc_fpc_eir);
 	offset("#define SC_CAUSE      ", struct sigcontext, sc_cause);
diff -Nru link/arch/mips64/kernel/process.c.orig link/arch/mips64/kernel/process.c
--- link/arch/mips64/kernel/process.c.orig	Tue Sep 17 19:50:17 2002
+++ link/arch/mips64/kernel/process.c	Wed Oct 30 17:22:16 2002
@@ -30,6 +30,7 @@
 #include <asm/io.h>
 #include <asm/elf.h>
 #include <asm/cpu.h>
+#include <asm/fpu.h>
 
 ATTRIB_NORET void cpu_idle(void)
 {
@@ -46,32 +47,30 @@
 	}
 }
 
-struct task_struct *last_task_used_math = NULL;
-
 asmlinkage void ret_from_fork(void);
 
+void start_thread(struct pt_regs * regs, unsigned long pc, unsigned long sp)
+{
+	unsigned long status;
+
+	/* New thread looses kernel privileges. */
+	status = regs->cp0_status & ~(ST0_CU0|ST0_FR|ST0_KSU);
+	status |= KSU_USER;
+	status |= (current->thread.mflags & MF_32BIT) ? 0 : ST0_FR;
+	regs->cp0_status = status;
+	current->used_math = 0;
+	loose_fpu();
+	regs->cp0_epc = pc;
+	regs->regs[29] = sp;
+	current->thread.current_ds = USER_DS;
+}
+
 void exit_thread(void)
 {
-	/* Forget lazy fpu state */
-	if (IS_FPU_OWNER()) {
-		if (mips_cpu.options & MIPS_CPU_FPU) {
-			__enable_fpu();
-			__asm__ __volatile__("cfc1\t$0,$31");
-		}
-		CLEAR_FPU_OWNER();
-	}
 }
 
 void flush_thread(void)
 {
-	/* Forget lazy fpu state */
-	if (IS_FPU_OWNER()) {
-		if (mips_cpu.options & MIPS_CPU_FPU) {
-			__enable_fpu();
-			__asm__ __volatile__("cfc1\t$0,$31");
-		}
-		CLEAR_FPU_OWNER();
-	}
 }
 
 int copy_thread(int nr, unsigned long clone_flags, unsigned long usp,
@@ -83,10 +82,10 @@
 
 	childksp = (unsigned long)p + KERNEL_STACK_SIZE - 32;
 
-	if (IS_FPU_OWNER()) {
-		if (mips_cpu.options & MIPS_CPU_FPU)
-			save_fp(p);
+	if (is_fpu_owner()) {
+		save_fp(p);
 	}
+
 	/* set up new TSS. */
 	childregs = (struct pt_regs *) childksp - 1;
 	*childregs = *regs;
diff -Nru link/arch/mips64/kernel/ptrace.c.orig link/arch/mips64/kernel/ptrace.c
--- link/arch/mips64/kernel/ptrace.c.orig	Tue Sep 17 19:15:08 2002
+++ link/arch/mips64/kernel/ptrace.c	Wed Oct 30 17:30:46 2002
@@ -23,6 +23,7 @@
 #include <linux/user.h>
 
 #include <asm/cpu.h>
+#include <asm/fpu.h>
 #include <asm/mipsregs.h>
 #include <asm/pgtable.h>
 #include <asm/page.h>
@@ -112,23 +113,7 @@
 			break;
 		case FPR_BASE ... FPR_BASE + 31:
 			if (child->used_math) {
-				unsigned long *fregs
-					= (unsigned long *)
-					    &child->thread.fpu.hard.fp_regs[0];
-				if (mips_cpu.options & MIPS_CPU_FPU) {
-#ifndef CONFIG_SMP
-					if (last_task_used_math == child) {
-						__enable_fpu();
-						save_fp(child);
-						__disable_fpu();
-						last_task_used_math = NULL;
-					}
-#endif
-				} else {
-					fregs = (unsigned long *)
-						child->thread.fpu.soft.regs;
-				}
-
+				unsigned long *fregs = get_fpu_regs(child);
 				tmp = (unsigned long) fregs[addr - FPR_BASE];
 			} else {
 				tmp = -EIO;
@@ -191,23 +176,8 @@
 			regs->regs[addr] = data;
 			break;
 		case FPR_BASE ... FPR_BASE + 31: {
-			unsigned long *fregs;
-			fregs = (unsigned long *)&child->thread.fpu.hard.fp_regs[0];
-			if (child->used_math) {
-#ifndef CONFIG_SMP
-				if (last_task_used_math == child)
-					if (mips_cpu.options & MIPS_CPU_FPU) {
-						__enable_fpu();
-						save_fp(child);
-						__disable_fpu();
-						last_task_used_math = NULL;
-						regs->cp0_status &= ~ST0_CU1;
-					} else {
-						fregs = (unsigned long *)
-						child->thread.fpu.soft.regs;
-					}
-#endif
-			} else {
+			unsigned long *fregs = get_fpu_regs(child);
+			if (!child->used_math) {
 				/* FP not yet used  */
 				memset(&child->thread.fpu.hard, ~0,
 				       sizeof(child->thread.fpu.hard));
diff -Nru link/arch/mips64/kernel/signal.c.orig link/arch/mips64/kernel/signal.c
--- link/arch/mips64/kernel/signal.c.orig	Wed Sep 18 06:03:07 2002
+++ link/arch/mips64/kernel/signal.c	Fri Nov  1 10:07:39 2002
@@ -26,14 +26,13 @@
 #include <asm/uaccess.h>
 #include <asm/ucontext.h>
 #include <asm/system.h>
+#include <asm/fpu.h>
 
 #define DEBUG_SIG 0
 
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
 extern asmlinkage int do_signal(sigset_t *oldset, struct pt_regs *regs);
-extern asmlinkage int (*save_fp_context)(struct sigcontext *sc);
-extern asmlinkage int (*restore_fp_context)(struct sigcontext *sc);
 
 extern asmlinkage void syscall_trace(void);
 
@@ -117,57 +116,8 @@
 	return do_sigaltstack(uss, uoss, usp);
 }
 
-static inline int restore_thread_fp_context(struct sigcontext *sc)
-{
-     u64 *pfreg = &current->thread.fpu.soft.regs[0];
-     int err = 0;
-
-     /*
-      * Copy all 32 64-bit values.
-      */
-
-#define restore_fpr(i)                          \
-     do { err |= __get_user(pfreg[i], &sc->sc_fpregs[i]); } while(0)
-
-     restore_fpr( 0); restore_fpr( 1); restore_fpr( 2); restore_fpr( 3);
-     restore_fpr( 4); restore_fpr( 5); restore_fpr( 6); restore_fpr( 7);
-     restore_fpr( 8); restore_fpr( 9); restore_fpr(10); restore_fpr(11);
-     restore_fpr(12); restore_fpr(13); restore_fpr(14); restore_fpr(15);
-     restore_fpr(16); restore_fpr(17); restore_fpr(18); restore_fpr(19);
-     restore_fpr(20); restore_fpr(21); restore_fpr(22); restore_fpr(23);
-     restore_fpr(24); restore_fpr(25); restore_fpr(26); restore_fpr(27);
-     restore_fpr(28); restore_fpr(29); restore_fpr(30); restore_fpr(31);
-
-     err |= __get_user(current->thread.fpu.soft.sr, &sc->sc_fpc_csr);
-
-     return err;
-}
-
-static inline int save_thread_fp_context(struct sigcontext *sc)
-{
-     u64 *pfreg = &current->thread.fpu.soft.regs[0];
-     int err = 0;
-
-#define save_fpr(i)                                     \
-     do { err |= __put_user(pfreg[i], &sc->sc_fpregs[i]); } while(0)
-
-     save_fpr( 0); save_fpr( 1); save_fpr( 2); save_fpr( 3);
-     save_fpr( 4); save_fpr( 5); save_fpr( 6); save_fpr( 7);
-     save_fpr( 8); save_fpr( 9); save_fpr(10); save_fpr(11);
-     save_fpr(12); save_fpr(13); save_fpr(14); save_fpr(15);
-     save_fpr(16); save_fpr(17); save_fpr(18); save_fpr(19);
-     save_fpr(20); save_fpr(21); save_fpr(22); save_fpr(23);
-     save_fpr(24); save_fpr(25); save_fpr(26); save_fpr(27);
-     save_fpr(28); save_fpr(29); save_fpr(30); save_fpr(31);
-
-     err |= __put_user(current->thread.fpu.soft.sr, &sc->sc_fpc_csr);
-
-     return err;
-}
-
 asmlinkage int restore_sigcontext(struct pt_regs *regs, struct sigcontext *sc)
 {
-	int owned_fp;
 	int err = 0;
 
 	err |= __get_user(regs->cp0_epc, &sc->sc_pc);
@@ -190,25 +140,17 @@
 	restore_gp_reg(31);
 #undef restore_gp_reg
 
-	err |= __get_user(owned_fp, &sc->sc_ownedfp);
 	err |= __get_user(current->used_math, &sc->sc_used_math);
 
-	if (owned_fp) {
-		err |= restore_fp_context(sc);
-		goto out;
-	}
-
-	if (IS_FPU_OWNER()) {
-		/* Signal handler acquired FPU - give it back */
-		CLEAR_FPU_OWNER();
-		regs->cp0_status &= ~ST0_CU1;
-	}
 	if (current->used_math) {
-		/* Undo possible contamination of thread state */
-		err |= restore_thread_fp_context(sc);
+		/* restore fpu context if we have used it before */
+		own_fpu();
+		err |= restore_fp_context(sc);
+	} else {
+		/* signal handler may have used FPU.  Give it up. */
+		loose_fpu();
 	}
 
-out:
 	return err;
 }
 
@@ -229,7 +171,6 @@
 static int inline setup_sigcontext(struct pt_regs *regs,
 	struct sigcontext *sc)
 {
-	int owned_fp;
 	int err = 0;
 
 	err |= __put_user(regs->cp0_epc, &sc->sc_pc);
@@ -254,25 +195,20 @@
 	err |= __put_user(regs->cp0_cause, &sc->sc_cause);
 	err |= __put_user(regs->cp0_badvaddr, &sc->sc_badvaddr);
 
-	owned_fp = IS_FPU_OWNER();
-	err |= __put_user(owned_fp, &sc->sc_ownedfp);
 	err |= __put_user(current->used_math, &sc->sc_used_math);
 
 	if (!current->used_math)
 		goto out;
 
-	/* There exists FP thread state that may be trashed by signal */
-	if (owned_fp) {
-		/* fp is active.  Save context from FPU */
-		err |= save_fp_context(sc);
-		goto out;
-	}
-
-	/*
-	 * Someone else has FPU.
-	 * Copy Thread context into signal context
+	/* 
+	 * Save FPU state to signal context.  Signal handler will "inherit"
+	 * current FPU state.
 	 */
-	err |= save_thread_fp_context(sc);
+	if (!is_fpu_owner()) {
+		own_fpu();
+		restore_fp(current);
+	}
+	err |= save_fp_context(sc);
 
 out:
 	return err;
diff -Nru link/arch/mips64/kernel/traps.c.orig link/arch/mips64/kernel/traps.c
--- link/arch/mips64/kernel/traps.c.orig	Mon Oct 28 10:55:17 2002
+++ link/arch/mips64/kernel/traps.c	Thu Oct 31 15:35:28 2002
@@ -21,6 +21,7 @@
 #include <asm/bootinfo.h>
 #include <asm/branch.h>
 #include <asm/cpu.h>
+#include <asm/fpu.h>
 #include <asm/module.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
@@ -560,58 +561,33 @@
 asmlinkage void do_cpu(struct pt_regs *regs)
 {
 	unsigned int cpid;
-	void fpu_emulator_init_fpu(void);
-	int sig;
 
 	cpid = (regs->cp0_cause >> CAUSEB_CE) & 3;
 	if (cpid != 1)
 		goto bad_cid;
 
-	if (!(mips_cpu.options & MIPS_CPU_FPU))
-		goto fp_emul;
+	die_if_kernel("do_cpu invoked from kernel context!", regs);
 
-	regs->cp0_status |= ST0_CU1;
-
-#ifdef CONFIG_SMP
-	if (current->used_math) {
-		lazy_fpu_switch(0, current);
+	own_fpu();
+	if (current->used_math) {               /* Using the FPU again.  */
+		restore_fp(current);
 	} else {
 		init_fpu();
 		current->used_math = 1;
 	}
-	current->flags |= PF_USEDFPU;
-#else
-	if (last_task_used_math == current)
-		return;
-
-	if (current->used_math) {		/* Using the FPU again.  */
-		lazy_fpu_switch(last_task_used_math, current);
-	} else {				/* First time FPU user.  */
-		lazy_fpu_switch(last_task_used_math, 0);
-		init_fpu();
-		current->used_math = 1;
-	}
-	last_task_used_math = current;
-#endif
-	return;
 
-fp_emul:
-	if (last_task_used_math != current) {
-		if (!current->used_math) {
-			fpu_emulator_init_fpu();
-			current->used_math = 1;
+	if (!(mips_cpu.options & MIPS_CPU_FPU)) {
+		int sig = fpu_emulator_cop1Handler(0, regs, &current->thread.fpu.soft);
+		if (sig) {
+			/*
+			 * Return EPC is not calculated in the FPU emulator, if
+			 * a signal is being send. So we calculate it here.
+			 */
+			compute_return_epc(regs);
+			force_sig(sig, current);
 		}
 	}
-	sig = fpu_emulator_cop1Handler(0, regs, &current->thread.fpu.soft);
-	last_task_used_math = current;
-	if (sig) {
-		/*
-		 * Return EPC is not calculated in the FPU emulator, if
-		 * a signal is being send. So we calculate it here.
-		 */
-		compute_return_epc(regs);
-		force_sig(sig, current);
-	}
+
 	return;
 
 bad_cid:
@@ -685,6 +661,7 @@
 
 asmlinkage int (*save_fp_context)(struct sigcontext *sc);
 asmlinkage int (*restore_fp_context)(struct sigcontext *sc);
+
 extern asmlinkage int _save_fp_context(struct sigcontext *sc);
 extern asmlinkage int _restore_fp_context(struct sigcontext *sc);
 
diff -Nru link/arch/mips64/kernel/r4k_switch.S.orig link/arch/mips64/kernel/r4k_switch.S
--- link/arch/mips64/kernel/r4k_switch.S.orig	Wed Jul 31 05:02:54 2002
+++ link/arch/mips64/kernel/r4k_switch.S	Fri Nov  1 09:51:08 2002
@@ -23,6 +23,19 @@
 
 	.set	mips3
 
+#define PF_USEDFPU      0x00100000      /* task used FPU this quantum (SMP) */
+#define ST_OFF (KERNEL_STACK_SIZE - 32 - PT_SIZE + PT_STATUS)
+
+/*
+ * [jsun] FPU context is saved if and only if the process has used FPU in 
+ * the current run (PF_USEDFPU).  In any case, the CU1 bit for user space 
+ * STATUS register should be 0, so that a process *always* starts its 
+ * userland with FPU disabled after each context switch.
+ *
+ * FPU will be enabled as soon as the process accesses FPU again, through
+ * do_cpu() trap.
+ */
+
 /*
  * task_struct *resume(task_struct *prev, task_struct *next)
  */
@@ -35,6 +48,38 @@
 	sd	ra, THREAD_REG31(a0)
 
 	/*
+	 * check if we need to save FPU registers
+	 */
+	ld	t0, TASK_FLAGS(a0)
+	li	t1, PF_USEDFPU
+	and	t2, t0, t1
+	beqz	t2, 1f
+	nor	t1, zero, t1
+
+	/*
+	 * clear PF_USEDFPU bit in task flags
+	 */
+	and	t0, t0, t1
+	sd	t0, TASK_FLAGS(a0)
+
+	/*
+	 * clear saved user stack CU1 bit
+	 */
+	ld	t0, ST_OFF(a0)
+	li	t1, ~ST0_CU1
+	and	t0, t0, t1
+	sd	t0, ST_OFF(a0)
+
+	
+	sll	t2, t0, 5
+	bgez	t2, 2f
+	sdc1	$f0, (THREAD_FPU + 0x00)(a0)
+        fpu_save_16odd a0
+2:
+        fpu_save_16even a0 t1                   # clobbers t1
+1:
+
+	/*
 	 * The order of restoring the registers takes care of the race
 	 * updating $28, $29 and kernelsp without disabling ints.
 	 */
@@ -57,51 +102,10 @@
 	END(resume)
 
 /*
- * Do lazy fpu context switch.  Saves FPU context to the process in a0
- * and loads the new context of the current process.
- */
-
-#define ST_OFF (KERNEL_STACK_SIZE - 32 - PT_SIZE + PT_STATUS)
-
-LEAF(lazy_fpu_switch)
-	mfc0	t0, CP0_STATUS			# enable cp1
-	li	t3, ST0_CU1
-	or	t0, t3
-	mtc0	t0, CP0_STATUS
-	FPU_ENABLE_HAZARD
-
-	beqz	a0, 2f				# Save floating point state
-	 nor	t3, zero, t3
-
-	ld	t1, ST_OFF(a0)			# last thread looses fpu
-	and	t1, t3
-	sd	t1, ST_OFF(a0)
-	sll	t2, t1, 5
-	bgez	t2, 1f
-	 sdc1	$f0, (THREAD_FPU + 0x00)(a0)
-	fpu_save_16odd a0
-1:
-	fpu_save_16even a0 t1			# clobbers t1
-2:
-
-	beqz	a1, 3f
-
-	sll	t0, t0, 5			# load new fp state
-	bgez	t0, 1f
-	 ldc1	$f0, (THREAD_FPU + 0x00)(a1)
-	fpu_restore_16odd a1
-1:
-	.set	reorder
-	fpu_restore_16even a1, t0		# clobbers t0
-3:
-	jr	ra
-	END(lazy_fpu_switch)
-
-/*
  * Save a thread's fp context.
  */
 	.set	noreorder
-LEAF(save_fp)
+LEAF(_save_fp)
 	mfc0	t0, CP0_STATUS
 	sll	t1, t0, 5
 	bgez	t1, 1f				# 16 register mode?
@@ -111,12 +115,12 @@
 	fpu_save_16even a0 t1			# clobbers t1
 	jr	ra
 	 sdc1	$f0, (THREAD_FPU + 0x00)(a0)
-	END(save_fp)
+	END(_save_fp)
 
 /*
  * Restore a thread's fp context.
  */
-LEAF(restore_fp)
+LEAF(_restore_fp)
 	mfc0	t0, CP0_STATUS
 	sll	t1, t0, 5
 	bgez	t1, 1f				# 16 register mode?
@@ -128,7 +132,7 @@
 
 	jr	ra
 	 ldc1	$f0, (THREAD_FPU + 0x00)(a0)
-	END(restore_fp)
+	END(_restore_fp)
 
 /*
  * Load the FPU with signalling NANS.  This bit pattern we're using has
@@ -140,7 +144,7 @@
 
 #define FPU_DEFAULT  0x00000000
 
-LEAF(init_fpu)
+LEAF(_init_fpu)
 	mfc0	t0, CP0_STATUS
 	li	t1, ST0_CU1
 	or	t0, t1
@@ -188,4 +192,4 @@
 	dmtc1	t0, $f28
 	jr	ra
 	 dmtc1	t0, $f30
-	END(init_fpu)
+	END(_init_fpu)
diff -Nru link/arch/mips64/kernel/cpu-probe.c.orig link/arch/mips64/kernel/cpu-probe.c
--- link/arch/mips64/kernel/cpu-probe.c.orig	Mon Sep  2 07:41:19 2002
+++ link/arch/mips64/kernel/cpu-probe.c	Wed Oct 30 18:14:48 2002
@@ -3,6 +3,7 @@
 #include <linux/stddef.h>
 #include <asm/bugs.h>
 #include <asm/cpu.h>
+#include <asm/fpu.h>
 #include <asm/mipsregs.h>
 
 /*
diff -Nru link/arch/mips64/kernel/signal32.c.orig link/arch/mips64/kernel/signal32.c
--- link/arch/mips64/kernel/signal32.c.orig	Mon Oct 28 10:55:17 2002
+++ link/arch/mips64/kernel/signal32.c	Fri Nov  1 10:51:53 2002
@@ -25,14 +25,13 @@
 #include <asm/uaccess.h>
 #include <asm/ucontext.h>
 #include <asm/system.h>
+#include <asm/fpu.h>
 
 #define DEBUG_SIG 0
 
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
 extern asmlinkage int do_signal32(sigset_t *oldset, struct pt_regs *regs);
-extern asmlinkage int (*save_fp_context)(struct sigcontext *sc);
-extern asmlinkage int (*restore_fp_context)(struct sigcontext *sc);
 
 extern asmlinkage void syscall_trace(void);
 
@@ -257,58 +256,9 @@
 	return ret;
 }
 
-static inline int restore_thread_fp_context(struct sigcontext *sc)
-{
-	u64 *pfreg = &current->thread.fpu.soft.regs[0];
-	int err = 0;
-
-	/*
-	 * Copy all 32 64-bit values.
-	 */
-
-#define restore_fpr(i) 						\
-	do { err |= __get_user(pfreg[i], &sc->sc_fpregs[i]); } while(0)
-
-	restore_fpr( 0); restore_fpr( 1); restore_fpr( 2); restore_fpr( 3);
-	restore_fpr( 4); restore_fpr( 5); restore_fpr( 6); restore_fpr( 7);
-	restore_fpr( 8); restore_fpr( 9); restore_fpr(10); restore_fpr(11);
-	restore_fpr(12); restore_fpr(13); restore_fpr(14); restore_fpr(15);
-	restore_fpr(16); restore_fpr(17); restore_fpr(18); restore_fpr(19);
-	restore_fpr(20); restore_fpr(21); restore_fpr(22); restore_fpr(23);
-	restore_fpr(24); restore_fpr(25); restore_fpr(26); restore_fpr(27);
-	restore_fpr(28); restore_fpr(29); restore_fpr(30); restore_fpr(31);
-
-	err |= __get_user(current->thread.fpu.soft.sr, &sc->sc_fpc_csr);
-
-	return err;
-}
-
-static inline int save_thread_fp_context(struct sigcontext *sc)
-{
-	u64 *pfreg = &current->thread.fpu.soft.regs[0];
-	int err = 0;
-
-#define save_fpr(i) 							\
-	do { err |= __put_user(pfreg[i], &sc->sc_fpregs[i]); } while(0)
-
-	save_fpr( 0); save_fpr( 1); save_fpr( 2); save_fpr( 3);
-	save_fpr( 4); save_fpr( 5); save_fpr( 6); save_fpr( 7);
-	save_fpr( 8); save_fpr( 9); save_fpr(10); save_fpr(11);
-	save_fpr(12); save_fpr(13); save_fpr(14); save_fpr(15);
-	save_fpr(16); save_fpr(17); save_fpr(18); save_fpr(19);
-	save_fpr(20); save_fpr(21); save_fpr(22); save_fpr(23);
-	save_fpr(24); save_fpr(25); save_fpr(26); save_fpr(27);
-	save_fpr(28); save_fpr(29); save_fpr(30); save_fpr(31);
-
-	err |= __put_user(current->thread.fpu.soft.sr, &sc->sc_fpc_csr);
-
-	return err;
-}
-
 static asmlinkage int restore_sigcontext(struct pt_regs *regs,
 					 struct sigcontext *sc)
 {
-	int owned_fp;
 	int err = 0;
 
 	err |= __get_user(regs->cp0_epc, &sc->sc_pc);
@@ -331,25 +281,17 @@
 	restore_gp_reg(31);
 #undef restore_gp_reg
 
-	err |= __get_user(owned_fp, &sc->sc_ownedfp);
 	err |= __get_user(current->used_math, &sc->sc_used_math);
 
-	if (owned_fp) {
-		err |= restore_fp_context(sc);
-		goto out;
-	}
-
-	if (IS_FPU_OWNER()) {
-		/* Signal handler acquired FPU - give it back */
-		CLEAR_FPU_OWNER();
-		regs->cp0_status &= ~ST0_CU1;
-	}
 	if (current->used_math) {
-		/* Undo possible contamination of thread state */
-		err |= restore_thread_fp_context(sc);
+		/* restore fpu context if we have used it before */
+		own_fpu();
+		err |= restore_fp_context(sc);
+	} else {
+		/* signal handler may have used FPU.  Give it up. */
+		loose_fpu();
 	}
 
-out:
 	return err;
 }
 
@@ -489,7 +431,6 @@
 static int inline setup_sigcontext(struct pt_regs *regs,
 				   struct sigcontext *sc)
 {
-	int owned_fp;
 	int err = 0;
 
 	err |= __put_user(regs->cp0_epc, &sc->sc_pc);
@@ -514,25 +455,20 @@
 	err |= __put_user(regs->cp0_cause, &sc->sc_cause);
 	err |= __put_user(regs->cp0_badvaddr, &sc->sc_badvaddr);
 
-	owned_fp = IS_FPU_OWNER();
-	err |= __put_user(owned_fp, &sc->sc_ownedfp);
 	err |= __put_user(current->used_math, &sc->sc_used_math);
 
 	if (!current->used_math)
 		goto out;
 
-	/* There exists FP thread state that may be trashed by signal */
-	if (owned_fp) {
-		/* fp is active.  Save context from FPU */
-		err |= save_fp_context(sc);
-		goto out;
-	}
-
-	/*
-	 * Someone else has FPU.
-	 * Copy Thread context into signal context
+	/* 
+	 * Save FPU state to signal context.  Signal handler will "inherit"
+	 * current FPU state.
 	 */
-	err |= save_thread_fp_context(sc);
+	if (!is_fpu_owner()) {
+		own_fpu();
+		restore_fp(current);
+	}
+	err |= save_fp_context(sc);
 
 out:
 	return err;
diff -Nru link/include/asm-mips/processor.h.orig link/include/asm-mips/processor.h
--- link/include/asm-mips/processor.h.orig	Mon Oct 28 13:45:08 2002
+++ link/include/asm-mips/processor.h	Mon Oct 28 11:55:24 2002
@@ -72,9 +72,6 @@
 #define wp_works_ok 1
 #define wp_works_ok__is_a_macro /* for versions in ksyms.c */
 
-/* Lazy FPU handling on uni-processor */
-extern struct task_struct *last_task_used_math;
-
 /*
  * User space process size: 2GB. This is hardcoded into a few places,
  * so don't change it unless you know what you are doing.  TASK_SIZE
@@ -211,20 +208,16 @@
 /*
  * Do necessary setup to start up a newly executed thread.
  */
-#define start_thread(regs, new_pc, new_sp) do {				\
-	/* New thread loses kernel and FPU privileges. */	       	\
-	regs->cp0_status = (regs->cp0_status & ~(ST0_CU0|ST0_KSU|ST0_CU1)) | KU_USER;\
-	regs->cp0_epc = new_pc;						\
-	regs->regs[29] = new_sp;					\
-	current->thread.current_ds = USER_DS;				\
-} while (0)
+extern void start_thread(struct pt_regs * regs, unsigned long pc, unsigned long sp);
 
+struct task_struct;
 unsigned long get_wchan(struct task_struct *p);
 
 #define __PT_REG(reg) ((long)&((struct pt_regs *)0)->reg - sizeof(struct pt_regs))
 #define __KSTK_TOS(tsk) ((unsigned long)(tsk) + KERNEL_STACK_SIZE - 32)
 #define KSTK_EIP(tsk) (*(unsigned long *)(__KSTK_TOS(tsk) + __PT_REG(cp0_epc)))
 #define KSTK_ESP(tsk) (*(unsigned long *)(__KSTK_TOS(tsk) + __PT_REG(regs[29])))
+#define KSTK_STATUS(tsk) (*(unsigned long *)(__KSTK_TOS(tsk) + __PT_REG(cp0_status)))
 
 /* Allocation and freeing of basic task resources. */
 /*
diff -Nru link/include/asm-mips/mipsregs.h.orig link/include/asm-mips/mipsregs.h
--- link/include/asm-mips/mipsregs.h.orig	Mon Oct 28 13:45:08 2002
+++ link/include/asm-mips/mipsregs.h	Mon Oct 28 11:55:24 2002
@@ -1002,48 +1002,6 @@
 __BUILD_SET_CP0(cause,CP0_CAUSE)
 __BUILD_SET_CP0(config,CP0_CONFIG)
 
-#if defined(CONFIG_CPU_SB1)
-#define __enable_fpu_hazard()						\
-do {									\
-	asm(".set push		\n\t"					\
-	    ".set mips64	\n\t"					\
-	    ".set noreorder	\n\t"					\
-	    "ssnop		\n\t"					\
-	    "bnezl $0, .+4	\n\t"					\
-	    "ssnop		\n\t"					\
-	    ".set pop");						\
-} while (0)
-#else
-#define __enable_fpu_hazard()						\
-do {									\
-	asm("nop;nop;nop;nop");		/* max. hazard */		\
-} while (0)
-#endif
-
-#define __enable_fpu()							\
-do {									\
-	set_cp0_status(ST0_CU1);					\
-	__enable_fpu_hazard();						\
-} while (0)
-
-#define __disable_fpu()							\
-do {									\
-	clear_cp0_status(ST0_CU1);					\
-	/* We don't care about the cp0 hazard here  */			\
-} while (0)
-
-#define enable_fpu()							\
-do {									\
-	if (mips_cpu.options & MIPS_CPU_FPU)				\
-		__enable_fpu();						\
-} while (0)
-
-#define disable_fpu()							\
-do {									\
-	if (mips_cpu.options & MIPS_CPU_FPU)				\
-		__disable_fpu();					\
-} while (0)
-
 #endif /* !__ASSEMBLY__ */
 
 #endif /* _ASM_MIPSREGS_H */
diff -Nru link/include/asm-mips/sigcontext.h.orig link/include/asm-mips/sigcontext.h
--- link/include/asm-mips/sigcontext.h.orig	Wed Dec 26 15:35:56 2001
+++ link/include/asm-mips/sigcontext.h	Mon Oct 28 10:56:40 2002
@@ -18,7 +18,6 @@
 	unsigned long long sc_pc;
 	unsigned long long sc_regs[32];
 	unsigned long long sc_fpregs[32];
-	unsigned int       sc_ownedfp;
 	unsigned int       sc_fpc_csr;
 	unsigned int       sc_fpc_eir;		/* Unused */
 	unsigned int       sc_used_math;
diff -Nru link/include/asm-mips/system.h.orig link/include/asm-mips/system.h
--- link/include/asm-mips/system.h.orig	Mon Oct 28 13:45:08 2002
+++ link/include/asm-mips/system.h	Mon Oct 28 11:55:19 2002
@@ -250,11 +250,6 @@
 
 struct task_struct;
 
-extern asmlinkage void lazy_fpu_switch(void *);
-extern asmlinkage void init_fpu(void);
-extern asmlinkage void save_fp(struct task_struct *);
-extern asmlinkage void restore_fp(struct task_struct *);
-
 #define switch_to(prev,next,last) \
 do { \
 	(last) = resume(prev, next); \
diff -Nru link/include/asm-mips64/processor.h.orig link/include/asm-mips64/processor.h
--- link/include/asm-mips64/processor.h.orig	Thu Oct 31 11:42:23 2002
+++ link/include/asm-mips64/processor.h	Thu Oct 31 14:26:15 2002
@@ -103,17 +103,6 @@
 #define wp_works_ok 1
 #define wp_works_ok__is_a_macro /* for versions in ksyms.c */
 
-/* Lazy FPU handling on uni-processor */
-extern struct task_struct *last_task_used_math;
-
-#ifndef CONFIG_SMP
-#define IS_FPU_OWNER()		(last_task_used_math == current)
-#define CLEAR_FPU_OWNER()	last_task_used_math = NULL;
-#else
-#define IS_FPU_OWNER()		(current->flags & PF_USEDFPU)
-#define CLEAR_FPU_OWNER()	current->flags &= ~PF_USEDFPU;
-#endif
-
 /*
  * User space process size: 1TB. This is hardcoded into a few places,
  * so don't change it unless you know what you are doing.  TASK_SIZE
@@ -256,26 +245,16 @@
 /*
  * Do necessary setup to start up a newly executed thread.
  */
-#define start_thread(regs, pc, sp) 					\
-do {									\
-	unsigned long __status;						\
-									\
-	/* New thread looses kernel privileges. */			\
-	__status = regs->cp0_status & ~(ST0_CU0|ST0_FR|ST0_KSU);	\
-	__status |= KSU_USER;						\
-	__status |= (current->thread.mflags & MF_32BIT) ? 0 : ST0_FR;	\
-	regs->cp0_status = __status;					\
-	regs->cp0_epc = pc;						\
-	regs->regs[29] = sp;						\
-	current->thread.current_ds = USER_DS;				\
-} while(0)
+extern void start_thread(struct pt_regs * regs, unsigned long pc, unsigned long sp);
 
+struct task_struct;
 unsigned long get_wchan(struct task_struct *p);
 
 #define __PT_REG(reg) ((long)&((struct pt_regs *)0)->reg - sizeof(struct pt_regs))
 #define __KSTK_TOS(tsk) ((unsigned long)(tsk) + KERNEL_STACK_SIZE - 32)
 #define KSTK_EIP(tsk) (*(unsigned long *)(__KSTK_TOS(tsk) + __PT_REG(cp0_epc)))
 #define KSTK_ESP(tsk) (*(unsigned long *)(__KSTK_TOS(tsk) + __PT_REG(regs[29])))
+#define KSTK_STATUS(tsk) (*(unsigned long *)(__KSTK_TOS(tsk) + __PT_REG(cp0_status)))
 
 /* Allocation and freeing of basic task resources. */
 /*
diff -Nru link/include/asm-mips64/mipsregs.h.orig link/include/asm-mips64/mipsregs.h
--- link/include/asm-mips64/mipsregs.h.orig	Thu Oct 31 11:42:23 2002
+++ link/include/asm-mips64/mipsregs.h	Thu Oct 31 10:28:30 2002
@@ -896,47 +896,6 @@
 __BUILD_SET_CP0(cause,CP0_CAUSE)
 __BUILD_SET_CP0(config,CP0_CONFIG)
 
-#if defined(CONFIG_CPU_SB1)
-#define __enable_fpu_hazard()						\
-do {									\
-	asm(".set push		\n\t"					\
-	    ".set mips2		\n\t"					\
-	    ".set noreorder	\n\t"					\
-	    "sll $0,$0,1	\n\t"					\
-	    "bnezl $0, .+4	\n\t"					\
-	    " sll $0,$0,1	\n\t"					\
-	    ".set pop");						\
-} while (0)
-#else
-#define __enable_fpu_hazard()						\
-do {									\
-	asm("nop;nop;nop;nop");		/* max. hazard */		\
-} while (0)
-#endif
-
-#define __enable_fpu()							\
-do {									\
-	set_cp0_status(ST0_CU1);					\
-	__enable_fpu_hazard();						\
-} while (0)
-
-#define __disable_fpu()							\
-do {									\
-	clear_cp0_status(ST0_CU1);					\
-	/* We don't care about the cp0 hazard here  */			\
-} while (0)
-
-#define enable_fpu()							\
-do {									\
-	if (mips_cpu.options & MIPS_CPU_FPU)				\
-		__enable_fpu();						\
-} while (0)
-
-#define disable_fpu()							\
-do {									\
-	if (mips_cpu.options & MIPS_CPU_FPU)				\
-		__disable_fpu();					\
-} while (0)
 #endif /* !__ASSEMBLY__ */
 
 #endif /* _ASM_MIPSREGS_H */
diff -Nru link/include/asm-mips64/sigcontext.h.orig link/include/asm-mips64/sigcontext.h
--- link/include/asm-mips64/sigcontext.h.orig	Tue Jul 30 19:41:21 2002
+++ link/include/asm-mips64/sigcontext.h	Wed Oct 30 18:25:25 2002
@@ -20,7 +20,6 @@
 	unsigned long long sc_mdlo;
 	unsigned long long sc_pc;
 	unsigned int       sc_status;
-	unsigned int       sc_ownedfp;
 	unsigned int       sc_fpc_csr;
 	unsigned int       sc_fpc_eir;
 	unsigned int       sc_used_math;
diff -Nru link/include/asm-mips64/system.h.orig link/include/asm-mips64/system.h
--- link/include/asm-mips64/system.h.orig	Thu Oct 31 11:42:23 2002
+++ link/include/asm-mips64/system.h	Thu Oct 31 14:26:15 2002
@@ -222,25 +222,8 @@
 
 struct task_struct;
 
-extern asmlinkage void lazy_fpu_switch(void *, void *);
-extern asmlinkage void init_fpu(void);
-extern asmlinkage void save_fp(struct task_struct *);
-extern asmlinkage void restore_fp(struct task_struct *);
-
-#ifdef CONFIG_SMP
-#define SWITCH_DO_LAZY_FPU \
-	if (prev->flags & PF_USEDFPU) { \
-		lazy_fpu_switch(prev, 0); \
-		clear_cp0_status(ST0_CU1); \
-		prev->flags &= ~PF_USEDFPU; \
-	}
-#else /* CONFIG_SMP */
-#define SWITCH_DO_LAZY_FPU	do { } while(0)
-#endif /* CONFIG_SMP */
-
 #define switch_to(prev,next,last) \
 do { \
-	SWITCH_DO_LAZY_FPU; \
 	(last) = resume(prev, next); \
 } while(0)
 

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="021101.25-new-fpu-complete.patch"

diff -Nru link/arch/mips/kernel/process.c.orig link/arch/mips/kernel/process.c
--- link/arch/mips/kernel/process.c.orig	Fri Nov  1 10:10:59 2002
+++ link/arch/mips/kernel/process.c	Fri Nov  1 10:20:50 2002
@@ -21,6 +21,7 @@
 
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
+#include <asm/fpu.h>
 #include <asm/pgtable.h>
 #include <asm/system.h>
 #include <asm/mipsregs.h>
@@ -56,28 +57,25 @@
 	}
 }
 
-struct task_struct *last_task_used_math = NULL;
-
 asmlinkage void ret_from_fork(void);
 
+void start_thread(struct pt_regs * regs, unsigned long pc, unsigned long sp)
+{
+	regs->cp0_status &= ~(ST0_CU0|ST0_KSU|ST0_CU1);
+       	regs->cp0_status |= KU_USER;
+	current->used_math = 0;
+	loose_fpu();
+	regs->cp0_epc = pc;
+	regs->regs[29] = sp;
+	current->thread.current_ds = USER_DS;
+}
+
 void exit_thread(void)
 {
-	/* Forget lazy fpu state */
-	if (last_task_used_math == current && mips_cpu.options & MIPS_CPU_FPU) {
-		__enable_fpu();
-		__asm__ __volatile__("cfc1\t$0,$31");
-		last_task_used_math = NULL;
-	}
 }
 
 void flush_thread(void)
 {
-	/* Forget lazy fpu state */
-	if (last_task_used_math == current && mips_cpu.options & MIPS_CPU_FPU) {
-		__enable_fpu();
-		__asm__ __volatile__("cfc1\t$0,$31");
-		last_task_used_math = NULL;
-	}
 }
 
 int copy_thread(int nr, unsigned long clone_flags, unsigned long usp,
@@ -90,11 +88,9 @@
 
 	childksp = (unsigned long)ti + KERNEL_STACK_SIZE - 32;
 
-	if (last_task_used_math == current)
-		if (mips_cpu.options & MIPS_CPU_FPU) {
-			__enable_fpu();
-			save_fp(p);
-		}
+	if (is_fpu_owner()) {
+		save_fp(p);
+	}
 
 	/* set up new TSS. */
 	childregs = (struct pt_regs *) childksp - 1;
diff -Nru link/arch/mips/kernel/ptrace.c.orig link/arch/mips/kernel/ptrace.c
--- link/arch/mips/kernel/ptrace.c.orig	Fri Nov  1 10:10:59 2002
+++ link/arch/mips/kernel/ptrace.c	Fri Nov  1 10:17:50 2002
@@ -28,6 +28,7 @@
 #include <asm/uaccess.h>
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
+#include <asm/fpu.h>
 
 /*
  * Called by kernel/ptrace.c when detaching..
@@ -43,7 +44,6 @@
 {
 	struct task_struct *child;
 	int ret;
-	extern void save_fp(struct task_struct *);
 
 	lock_kernel();
 #if 0
@@ -114,20 +114,7 @@
 			break;
 		case FPR_BASE ... FPR_BASE + 31:
 			if (child->used_math) {
-			        unsigned long long *fregs
-					= (unsigned long long *)
-					    &child->thread.fpu.hard.fp_regs[0];
-			 	if(!(mips_cpu.options & MIPS_CPU_FPU)) {
-					fregs = (unsigned long long *)
-						child->thread.fpu.soft.regs;
-				} else
-					if (last_task_used_math == child) {
-						__enable_fpu();
-						save_fp(child);
-						__disable_fpu();
-						last_task_used_math = NULL;
-						regs->cp0_status &= ~ST0_CU1;
-					}
+			        unsigned long long *fregs = get_fpu_regs(child);
 				/*
 				 * The odd registers are actually the high
 				 * order bits of the values stored in the even
@@ -205,21 +192,8 @@
 			break;
 		case FPR_BASE ... FPR_BASE + 31: {
 			unsigned long long *fregs;
-			fregs = (unsigned long long *)&child->thread.fpu.hard.fp_regs[0];
-			if (child->used_math) {
-				if (last_task_used_math == child) {
-					if(!(mips_cpu.options & MIPS_CPU_FPU)) {
-						fregs = (unsigned long long *)
-						child->thread.fpu.soft.regs;
-					} else {
-						__enable_fpu();
-						save_fp(child);
-						__disable_fpu();
-						last_task_used_math = NULL;
-						regs->cp0_status &= ~ST0_CU1;
-					}
-				}
-			} else {
+			fregs = (unsigned long long *)get_fpu_regs(child);
+			if (!child->used_math) {
 				/* FP not yet used  */
 				memset(&child->thread.fpu.hard, ~0,
 				       sizeof(child->thread.fpu.hard));
diff -Nru link/arch/mips/kernel/signal.c.orig link/arch/mips/kernel/signal.c
--- link/arch/mips/kernel/signal.c.orig	Fri Nov  1 10:10:59 2002
+++ link/arch/mips/kernel/signal.c	Fri Nov  1 10:22:09 2002
@@ -23,6 +23,7 @@
 #include <asm/bitops.h>
 #include <asm/cacheflush.h>
 #include <asm/cpu.h>
+#include <asm/fpu.h>
 #include <asm/offset.h>
 #include <asm/ptrace.h>
 #include <asm/uaccess.h>
@@ -34,9 +35,6 @@
 
 extern asmlinkage int do_signal(sigset_t *oldset, struct pt_regs *regs);
 
-extern asmlinkage int (*save_fp_context)(struct sigcontext *sc);
-extern asmlinkage int (*restore_fp_context)(struct sigcontext *sc);
-
 extern asmlinkage void do_syscall_trace(void);
 
 /*
@@ -150,59 +148,8 @@
 	return do_sigaltstack(uss, uoss, usp);
 }
 
-static inline int restore_thread_fp_context(struct sigcontext *sc)
-{
-	u64 *pfreg = &current->thread.fpu.soft.regs[0];
-	int err = 0;
-
-	/*
-	 * Copy all 32 64-bit values, for two reasons.  First, the R3000 and
-	 * R4000/MIPS32 kernels use the thread FP register storage differently,
-	 * such that a full copy is essentially necessary to support both.
-	 */
-
-#define restore_fpr(i) 						\
-	do { err |= __get_user(pfreg[i], &sc->sc_fpregs[i]); } while(0)
-
-	restore_fpr( 0); restore_fpr( 1); restore_fpr( 2); restore_fpr( 3);
-	restore_fpr( 4); restore_fpr( 5); restore_fpr( 6); restore_fpr( 7);
-	restore_fpr( 8); restore_fpr( 9); restore_fpr(10); restore_fpr(11);
-	restore_fpr(12); restore_fpr(13); restore_fpr(14); restore_fpr(15);
-	restore_fpr(16); restore_fpr(17); restore_fpr(18); restore_fpr(19);
-	restore_fpr(20); restore_fpr(21); restore_fpr(22); restore_fpr(23);
-	restore_fpr(24); restore_fpr(25); restore_fpr(26); restore_fpr(27);
-	restore_fpr(28); restore_fpr(29); restore_fpr(30); restore_fpr(31);
-
-	err |= __get_user(current->thread.fpu.soft.sr, &sc->sc_fpc_csr);
-
-	return err;
-}
-
-static inline int save_thread_fp_context(struct sigcontext *sc)
-{
-	u64 *pfreg = &current->thread.fpu.soft.regs[0];
-	int err = 0;
-
-#define save_fpr(i) 							\
-	do { err |= __put_user(pfreg[i], &sc->sc_fpregs[i]); } while(0)
-
-	save_fpr( 0); save_fpr( 1); save_fpr( 2); save_fpr( 3);
-	save_fpr( 4); save_fpr( 5); save_fpr( 6); save_fpr( 7);
-	save_fpr( 8); save_fpr( 9); save_fpr(10); save_fpr(11);
-	save_fpr(12); save_fpr(13); save_fpr(14); save_fpr(15);
-	save_fpr(16); save_fpr(17); save_fpr(18); save_fpr(19);
-	save_fpr(20); save_fpr(21); save_fpr(22); save_fpr(23);
-	save_fpr(24); save_fpr(25); save_fpr(26); save_fpr(27);
-	save_fpr(28); save_fpr(29); save_fpr(30); save_fpr(31);
-
-	err |= __put_user(current->thread.fpu.soft.sr, &sc->sc_fpc_csr);
-
-	return err;
-}
-
 static int restore_sigcontext(struct pt_regs *regs, struct sigcontext *sc)
 {
-	int owned_fp;
 	int err = 0;
 	u64 reg;
 
@@ -230,25 +177,17 @@
 	restore_gp_reg(31);
 #undef restore_gp_reg
 
-	err |= __get_user(owned_fp, &sc->sc_ownedfp);
 	err |= __get_user(current->used_math, &sc->sc_used_math);
 
-	if (owned_fp) {
-		err |= restore_fp_context(sc);
-		goto out;
-	}
-
-	if (current == last_task_used_math) {
-		/* Signal handler acquired FPU - give it back */
-		last_task_used_math = NULL;
-		regs->cp0_status &= ~ST0_CU1;
-	}
 	if (current->used_math) {
-		/* Undo possible contamination of thread state */
-		err |= restore_thread_fp_context(sc);
+		/* restore fpu context if we have used it before */
+		own_fpu();
+		err |= restore_fp_context(sc);
+	} else {
+		/* signal handler may have used FPU.  Give it up. */
+		loose_fpu();
 	}
 
-out:
 	return err;
 }
 
@@ -345,7 +284,6 @@
 
 static int inline setup_sigcontext(struct pt_regs *regs, struct sigcontext *sc)
 {
-	int owned_fp;
 	int err = 0;
 	u64 reg;
 
@@ -373,25 +311,20 @@
 	err |= __put_user(regs->cp0_cause, &sc->sc_cause);
 	err |= __put_user(regs->cp0_badvaddr, &sc->sc_badvaddr);
 
-	owned_fp = (current == last_task_used_math);
-	err |= __put_user(owned_fp, &sc->sc_ownedfp);
 	err |= __put_user(current->used_math, &sc->sc_used_math);
 
 	if (!current->used_math)
 		goto out;
 
-	/* There exists FP thread state that may be trashed by signal */
-	if (owned_fp) {
-		/* fp is active.  Save context from FPU */
-		err |= save_fp_context(sc);
-		goto out;
-	}
-
-	/*
-	 * Someone else has FPU.
-	 * Copy Thread context into signal context
+	/* 
+	 * Save FPU state to signal context.  Signal handler will "inherit"
+	 * current FPU state.
 	 */
-	err |= save_thread_fp_context(sc);
+	if (!is_fpu_owner()) {
+		own_fpu();
+		restore_fp(current);
+	}
+	err |= save_fp_context(sc);
 
 out:
 	return err;
diff -Nru link/arch/mips/kernel/traps.c.orig link/arch/mips/kernel/traps.c
--- link/arch/mips/kernel/traps.c.orig	Fri Nov  1 10:10:59 2002
+++ link/arch/mips/kernel/traps.c	Fri Nov  1 10:24:55 2002
@@ -24,6 +24,7 @@
 #include <asm/bootinfo.h>
 #include <asm/branch.h>
 #include <asm/cpu.h>
+#include <asm/fpu.h>
 #include <asm/inst.h>
 #include <asm/module.h>
 #include <asm/pgtable.h>
@@ -672,49 +673,32 @@
 asmlinkage void do_cpu(struct pt_regs *regs)
 {
 	unsigned int cpid;
-	void fpu_emulator_init_fpu(void);
-	int sig;
 
 	cpid = (regs->cp0_cause >> CAUSEB_CE) & 3;
 	if (cpid != 1)
 		goto bad_cid;
 
-	if (!(mips_cpu.options & MIPS_CPU_FPU))
-		goto fp_emul;
-
-	regs->cp0_status |= ST0_CU1;
-	if (last_task_used_math == current)
-		return;
+	die_if_kernel("do_cpu invoked from kernel context!", regs);
 
+	own_fpu();
 	if (current->used_math) {		/* Using the FPU again.  */
-		lazy_fpu_switch(last_task_used_math, current);
+		restore_fp(current);
 	} else {				/* First time FPU user.  */
-		if (last_task_used_math != NULL)
-			save_fp(last_task_used_math);
 		init_fpu();
 		current->used_math = 1;
 	}
-	last_task_used_math = current;
-
-	return;
-
-fp_emul:
-	if (last_task_used_math != current) {
-		if (!current->used_math) {
-			fpu_emulator_init_fpu();
-			current->used_math = 1;
+	if (!(mips_cpu.options & MIPS_CPU_FPU)) {
+		int sig = fpu_emulator_cop1Handler(0, regs, &current->thread.fpu.soft);
+		if (sig) {
+			/*
+			 * Return EPC is not calculated in the FPU emulator, if
+			 * a signal is being send. So we calculate it here.
+			 */
+			compute_return_epc(regs);
+			force_sig(sig, current);
 		}
 	}
-	sig = fpu_emulator_cop1Handler(0, regs, &current->thread.fpu.soft);
-	last_task_used_math = current;
-	if (sig) {
-		/*
-		 * Return EPC is not calculated in the FPU emulator, if
-		 * a signal is being send. So we calculate it here.
-		 */
-		compute_return_epc(regs);
-		force_sig(sig, current);
-	}
+
 	return;
 
 bad_cid:
@@ -896,6 +880,7 @@
 
 asmlinkage int (*save_fp_context)(struct sigcontext *sc);
 asmlinkage int (*restore_fp_context)(struct sigcontext *sc);
+
 extern asmlinkage int _save_fp_context(struct sigcontext *sc);
 extern asmlinkage int _restore_fp_context(struct sigcontext *sc);
 
diff -Nru link/arch/mips/kernel/r2300_switch.S.orig link/arch/mips/kernel/r2300_switch.S
--- link/arch/mips/kernel/r2300_switch.S.orig	Fri Nov  1 10:10:59 2002
+++ link/arch/mips/kernel/r2300_switch.S	Fri Nov  1 11:02:13 2002
@@ -26,6 +26,19 @@
 	.set	mips1
 	.align	5
 
+#define PF_USEDFPU      0x00100000      /* task used FPU this quantum (SMP) */
+#define ST_OFF (KERNEL_STACK_SIZE - 32 - PT_SIZE + PT_STATUS)
+
+/*
+ * [jsun] FPU context is saved if and only if the process has used FPU in 
+ * the current run (PF_USEDFPU).  In any case, the CU1 bit for user space 
+ * STATUS register should be 0, so that a process *always* starts its 
+ * userland with FPU disabled after each context switch.
+ *
+ * FPU will be enabled as soon as the process accesses FPU again, through
+ * do_cpu() trap.
+ */
+
 /*
  * task_struct *resume(task_struct *prev, task_struct *next,
  *                     struct thread_info *next_ti) )
@@ -39,6 +52,32 @@
 	CPU_SAVE_NONSCRATCH(a0)
 	sw	ra, THREAD_REG31(a0)
 
+	/* 
+	 * check if we need to save FPU registers
+	 */
+	lw	t0, TASK_FLAGS(a0)
+	li	t1, PF_USEDFPU
+	and	t2, t0, t1
+	beqz	t2, 1f
+	nor	t1, zero, t1
+
+	/*
+	 * clear PF_USEDFPU bit in task flags
+	 */
+	and	t0, t0, t1
+	sw	t0, TASK_FLAGS(a0)
+
+	/*
+	 * clear user-saved stack CU1 bit
+	 */
+	lw	t0, ST_OFF(a0)
+	li	t1, ~ST0_CU1
+	and	t0, t0, t1
+	sw	t0, ST_OFF(a0)
+
+	FPU_SAVE_SINGLE(a0, t0)			# clobbers t0
+
+1:
 	/*
 	 * The order of restoring the registers takes care of the race
 	 * updating $28, $29 and kernelsp without disabling ints.
@@ -62,45 +101,20 @@
 	END(resume)
 
 /*
- * Do lazy fpu context switch.  Saves FPU context to the process in a0
- * and loads the new context of the current process.
- */
-
-#define ST_OFF (KERNEL_STACK_SIZE - 32 - PT_SIZE + PT_STATUS)
-
-LEAF(lazy_fpu_switch)
-	mfc0	t0, CP0_STATUS			# enable cp1
-	li	t3, ST0_CU1
-	or	t0, t3
-	mtc0	t0, CP0_STATUS
-
-	nor	t3, zero, t3
-	beqz	a0, 2f				# Save floating point state
-	lw	t1, ST_OFF(a0)			# last thread looses fpu
-	and	t1, t3
-	sw	t1, ST_OFF(a0)
-	FPU_SAVE_SINGLE(a0, t1)			# clobbers t1
-
-2:
-	FPU_RESTORE_SINGLE(a1, t0)		# clobbers t0
-	jr	ra
-	END(lazy_fpu_switch)
-
-/*
  * Save a thread's fp context.
  */
-LEAF(save_fp)
+LEAF(_save_fp)
 	FPU_SAVE_SINGLE(a0, t1)			# clobbers t1
 	jr	ra
-	END(save_fp)
+	END(_save_fp)
 
 /*
  * Restore a thread's fp context.
  */
-LEAF(restore_fp)
+LEAF(_restore_fp)
 	FPU_RESTORE_SINGLE(a0, t1)		# clobbers t1
 	jr	ra
-	END(restore_fp)
+	END(_estore_fp)
 
 /*
  * Load the FPU with signalling NANS.  This bit pattern we're using has
@@ -112,7 +126,7 @@
 
 #define FPU_DEFAULT  0x00000000
 
-LEAF(init_fpu)
+LEAF(_init_fpu)
 	mfc0	t0, CP0_STATUS
 	li	t1, ST0_CU1
 	or	t0, t1
@@ -156,4 +170,4 @@
 	mtc1	t0, $f30
 	mtc1	t0, $f31
 	jr	ra
-	END(init_fpu)
+	END(_init_fpu)
diff -Nru link/arch/mips/kernel/r4k_switch.S.orig link/arch/mips/kernel/r4k_switch.S
--- link/arch/mips/kernel/r4k_switch.S.orig	Fri Nov  1 10:10:59 2002
+++ link/arch/mips/kernel/r4k_switch.S	Fri Nov  1 10:27:42 2002
@@ -24,6 +24,19 @@
 
 #include <asm/asmmacro.h>
 
+#define PF_USEDFPU      0x00100000      /* task used FPU this quantum (SMP) */
+#define ST_OFF (KERNEL_STACK_SIZE - 32 - PT_SIZE + PT_STATUS)
+
+/*
+ * [jsun] FPU context is saved if and only if the process has used FPU in 
+ * the current run (PF_USEDFPU).  In any case, the CU1 bit for user space 
+ * STATUS register should be 0, so that a process *always* starts its 
+ * userland with FPU disabled after each context switch.
+ *
+ * FPU will be enabled as soon as the process accesses FPU again, through 
+ * do_cpu() trap.
+ */
+
 /*
  * task_struct *r4xx0_resume(task_struct *prev, task_struct *next,
  *                           struct thread_info *next_ti)
@@ -38,6 +51,32 @@
 	CPU_SAVE_NONSCRATCH(a0)
 	sw	ra, THREAD_REG31(a0)
 
+	/* 
+	 * check if we need to save FPU registers
+	 */
+	lw	t0, TASK_FLAGS(a0)
+	li	t1, PF_USEDFPU
+	and	t2, t0, t1
+	beqz	t2, 1f
+	nor	t1, zero, t1
+
+	/*
+	 * clear PF_USEDFPU bit in task flags
+	 */
+	and	t0, t0, t1
+	sw	t0, TASK_FLAGS(a0)
+
+	/*
+	 * clear saved user stack CU1 bit
+	 */
+	lw	t0, ST_OFF(a0)
+	li	t1, ~ST0_CU1
+	and	t0, t0, t1
+	sw	t0, ST_OFF(a0)
+
+	FPU_SAVE_DOUBLE(a0, t0)			# clobbers t0
+
+1:
 	/*
 	 * The order of restoring the registers takes care of the race
 	 * updating $28, $29 and kernelsp without disabling ints.
@@ -70,39 +109,12 @@
 	END(resume)
 
 /*
- * Do lazy fpu context switch.  Saves FPU context to the process in a0
- * and loads the new context of the current process.
- */
-
-#define ST_OFF (KERNEL_STACK_SIZE - 32 - PT_SIZE + PT_STATUS)
-
-LEAF(lazy_fpu_switch)
-	mfc0	t0, CP0_STATUS			# enable cp1
-	li	t3, ST0_CU1
-	or	t0, t3
-	mtc0	t0, CP0_STATUS
-	FPU_ENABLE_HAZARD
-
-	nor	t3, zero, t3
-	beqz	a0, 2f				# Save floating point state
-
-	lw	t1, ST_OFF(a0)			# last thread looses fpu
-	and	t1, t3
-	sw	t1, ST_OFF(a0)
-
-
-	FPU_SAVE_DOUBLE(a0, t1)			# clobbers t1
-2:	FPU_RESTORE_DOUBLE(a1, t0)		# clobbers t0
-	jr	ra
-	END(lazy_fpu_switch)
-
-/*
  * Save a thread's fp context.
  */
-LEAF(save_fp)
+LEAF(_save_fp)
 	FPU_SAVE_DOUBLE(a0, t1)			# clobbers t1
 	jr	ra
-	END(save_fp)
+	END(_save_fp)
 
 /*
  * Restore a thread's fp context.
@@ -110,7 +122,7 @@
 LEAF(restore_fp)
 	FPU_RESTORE_DOUBLE(a0, t1)		# clobbers t1
 	jr	ra
-	END(restore_fp)
+	END(_restore_fp)
 
 /*
  * Load the FPU with signalling NANS.  This bit pattern we're using has
@@ -122,7 +134,7 @@
 
 #define FPU_DEFAULT  0x00000000
 
-LEAF(init_fpu)
+LEAF(_init_fpu)
 	.set	mips3
 	mfc0	t0, CP0_STATUS
 	li	t1, ST0_CU1
@@ -152,4 +164,4 @@
 	dmtc1	t0, $f28
 	dmtc1	t0, $f30
 	jr	ra
-	END(init_fpu)
+	END(_init_fpu)
diff -Nru link/arch/mips/kernel/cpu-probe.c.orig link/arch/mips/kernel/cpu-probe.c
--- link/arch/mips/kernel/cpu-probe.c.orig	Tue Sep  3 14:04:28 2002
+++ link/arch/mips/kernel/cpu-probe.c	Fri Nov  1 10:17:50 2002
@@ -3,6 +3,7 @@
 #include <linux/stddef.h>
 #include <asm/bugs.h>
 #include <asm/cpu.h>
+#include <asm/fpu.h>
 #include <asm/mipsregs.h>
 
 /*
diff -Nru link/arch/mips/tools/offset.c.orig link/arch/mips/tools/offset.c
--- link/arch/mips/tools/offset.c.orig	Fri Nov  1 10:11:03 2002
+++ link/arch/mips/tools/offset.c	Fri Nov  1 10:17:50 2002
@@ -155,7 +155,6 @@
 	offset("#define SC_MDLO       ", struct sigcontext, sc_mdlo);
 	offset("#define SC_PC         ", struct sigcontext, sc_pc);
 	offset("#define SC_STATUS     ", struct sigcontext, sc_status);
-	offset("#define SC_OWNEDFP    ", struct sigcontext, sc_ownedfp);
 	offset("#define SC_FPC_CSR    ", struct sigcontext, sc_fpc_csr);
 	offset("#define SC_FPC_EIR    ", struct sigcontext, sc_fpc_eir);
 	offset("#define SC_CAUSE      ", struct sigcontext, sc_cause);
diff -Nru link/arch/mips64/kernel/process.c.orig link/arch/mips64/kernel/process.c
--- link/arch/mips64/kernel/process.c.orig	Fri Nov  1 10:11:18 2002
+++ link/arch/mips64/kernel/process.c	Fri Nov  1 10:35:45 2002
@@ -30,6 +30,7 @@
 #include <asm/io.h>
 #include <asm/elf.h>
 #include <asm/cpu.h>
+#include <asm/fpu.h>
 
 /*
  * We use this if we don't have any better idle routine..
@@ -55,28 +56,30 @@
 	}
 }
 
-struct task_struct *last_task_used_math = NULL;
-
 asmlinkage void ret_from_fork(void);
 
+void start_thread(struct pt_regs * regs, unsigned long pc, unsigned long sp)
+{
+	unsigned long status;
+
+	/* New thread looses kernel privileges. */
+	status = regs->cp0_status & ~(ST0_CU0|ST0_FR|ST0_KSU);
+	status |= KSU_USER;
+	status |= (current->thread.mflags & MF_32BIT) ? 0 : ST0_FR;
+	regs->cp0_status = status;
+	current->used_math = 0;
+	loose_fpu();
+	regs->cp0_epc = pc;
+	regs->regs[29] = sp;
+	current_thread_info()->addr_limit = USER_DS;
+}
+
 void exit_thread(void)
 {
-	/* Forget lazy fpu state */
-	if (last_task_used_math == current && mips_cpu.options & MIPS_CPU_FPU) {
-		__enable_fpu();
-		__asm__ __volatile__("cfc1\t$0,$31");
-		last_task_used_math = NULL;
-	}
 }
 
 void flush_thread(void)
 {
-	/* Forget lazy fpu state */
-	if (last_task_used_math == current && mips_cpu.options & MIPS_CPU_FPU) {
-		__enable_fpu();
-		__asm__ __volatile__("cfc1\t$0,$31");
-		last_task_used_math = NULL;
-	}
 }
 
 int copy_thread(int nr, unsigned long clone_flags, unsigned long usp,
@@ -89,10 +92,8 @@
 
 	childksp = (unsigned long)ti + KERNEL_STACK_SIZE - 32;
 
-	if (last_task_used_math == current)
-		if (mips_cpu.options & MIPS_CPU_FPU) {
-			__enable_fpu();
-			save_fp(p);
+	if (is_fpu_owner()) {
+		save_fp(p);
 	}
 
 	/* set up new TSS. */
diff -Nru link/arch/mips64/kernel/ptrace.c.orig link/arch/mips64/kernel/ptrace.c
--- link/arch/mips64/kernel/ptrace.c.orig	Fri Nov  1 10:11:18 2002
+++ link/arch/mips64/kernel/ptrace.c	Fri Nov  1 10:37:41 2002
@@ -23,6 +23,7 @@
 #include <linux/user.h>
 
 #include <asm/cpu.h>
+#include <asm/fpu.h>
 #include <asm/mipsregs.h>
 #include <asm/pgtable.h>
 #include <asm/page.h>
@@ -112,23 +113,7 @@
 			break;
 		case FPR_BASE ... FPR_BASE + 31:
 			if (child->used_math) {
-				unsigned long *fregs
-					= (unsigned long *)
-					    &child->thread.fpu.hard.fp_regs[0];
-				if (mips_cpu.options & MIPS_CPU_FPU) {
-#ifndef CONFIG_SMP
-					if (last_task_used_math == child) {
-						__enable_fpu();
-						save_fp(child);
-						__disable_fpu();
-						last_task_used_math = NULL;
-					}
-#endif
-				} else {
-					fregs = (unsigned long *)
-						child->thread.fpu.soft.regs;
-				}
-
+				unsigned long *fregs = get_fpu_regs(child);
 				tmp = (unsigned long) fregs[addr - FPR_BASE];
 			} else {
 				tmp = -EIO;
@@ -191,24 +176,8 @@
 			regs->regs[addr] = data;
 			break;
 		case FPR_BASE ... FPR_BASE + 31: {
-			unsigned long *fregs;
-			fregs = (unsigned long *)&child->thread.fpu.hard.fp_regs[0];
-			if (child->used_math) {
-#ifndef CONFIG_SMP
-				if (last_task_used_math == child) {
-					if (mips_cpu.options & MIPS_CPU_FPU) {
-						__enable_fpu();
-						save_fp(child);
-						__disable_fpu();
-						last_task_used_math = NULL;
-						regs->cp0_status &= ~ST0_CU1;
-					} else {
-						fregs = (unsigned long *)
-						child->thread.fpu.soft.regs;
-					}
-				}
-#endif
-			} else {
+			unsigned long *fregs = get_fpu_regs(child);
+			if (!child->used_math) {
 				/* FP not yet used  */
 				memset(&child->thread.fpu.hard, ~0,
 				       sizeof(child->thread.fpu.hard));
diff -Nru link/arch/mips64/kernel/signal.c.orig link/arch/mips64/kernel/signal.c
--- link/arch/mips64/kernel/signal.c.orig	Fri Nov  1 10:11:18 2002
+++ link/arch/mips64/kernel/signal.c	Fri Nov  1 10:40:45 2002
@@ -27,14 +27,13 @@
 #include <asm/uaccess.h>
 #include <asm/ucontext.h>
 #include <asm/system.h>
+#include <asm/fpu.h>
 
 #define DEBUG_SIG 0
 
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
 extern asmlinkage int do_signal(sigset_t *oldset, struct pt_regs *regs);
-extern asmlinkage int (*save_fp_context)(struct sigcontext *sc);
-extern asmlinkage int (*restore_fp_context)(struct sigcontext *sc);
 
 extern asmlinkage void do_syscall_trace(void);
 
@@ -83,57 +82,8 @@
 	return do_sigaltstack(uss, uoss, usp);
 }
 
-static inline int restore_thread_fp_context(struct sigcontext *sc)
-{
-     u64 *pfreg = &current->thread.fpu.soft.regs[0];
-     int err = 0;
-
-     /*
-      * Copy all 32 64-bit values.
-      */
-
-#define restore_fpr(i)                          \
-     do { err |= __get_user(pfreg[i], &sc->sc_fpregs[i]); } while(0)
-
-     restore_fpr( 0); restore_fpr( 1); restore_fpr( 2); restore_fpr( 3);
-     restore_fpr( 4); restore_fpr( 5); restore_fpr( 6); restore_fpr( 7);
-     restore_fpr( 8); restore_fpr( 9); restore_fpr(10); restore_fpr(11);
-     restore_fpr(12); restore_fpr(13); restore_fpr(14); restore_fpr(15);
-     restore_fpr(16); restore_fpr(17); restore_fpr(18); restore_fpr(19);
-     restore_fpr(20); restore_fpr(21); restore_fpr(22); restore_fpr(23);
-     restore_fpr(24); restore_fpr(25); restore_fpr(26); restore_fpr(27);
-     restore_fpr(28); restore_fpr(29); restore_fpr(30); restore_fpr(31);
-
-     err |= __get_user(current->thread.fpu.soft.sr, &sc->sc_fpc_csr);
-
-     return err;
-}
-
-static inline int save_thread_fp_context(struct sigcontext *sc)
-{
-     u64 *pfreg = &current->thread.fpu.soft.regs[0];
-     int err = 0;
-
-#define save_fpr(i)                                     \
-     do { err |= __put_user(pfreg[i], &sc->sc_fpregs[i]); } while(0)
-
-     save_fpr( 0); save_fpr( 1); save_fpr( 2); save_fpr( 3);
-     save_fpr( 4); save_fpr( 5); save_fpr( 6); save_fpr( 7);
-     save_fpr( 8); save_fpr( 9); save_fpr(10); save_fpr(11);
-     save_fpr(12); save_fpr(13); save_fpr(14); save_fpr(15);
-     save_fpr(16); save_fpr(17); save_fpr(18); save_fpr(19);
-     save_fpr(20); save_fpr(21); save_fpr(22); save_fpr(23);
-     save_fpr(24); save_fpr(25); save_fpr(26); save_fpr(27);
-     save_fpr(28); save_fpr(29); save_fpr(30); save_fpr(31);
-
-     err |= __put_user(current->thread.fpu.soft.sr, &sc->sc_fpc_csr);
-
-     return err;
-}
-
 asmlinkage int restore_sigcontext(struct pt_regs *regs, struct sigcontext *sc)
 {
-	int owned_fp;
 	int err = 0;
 
 	err |= __get_user(regs->cp0_epc, &sc->sc_pc);
@@ -156,26 +106,17 @@
 	restore_gp_reg(31);
 #undef restore_gp_reg
 
-	err |= __get_user(owned_fp, &sc->sc_ownedfp);
 	err |= __get_user(current->used_math, &sc->sc_used_math);
 
-	if (owned_fp) {
-		err |= restore_fp_context(sc);
-		goto out;
-	}
-
-	if (current == last_task_used_math) {
-		/* Signal handler acquired FPU - give it back */
-		last_task_used_math = NULL;
-		regs->cp0_status &= ~ST0_CU1;
-	}
-
 	if (current->used_math) {
-		/* Undo possible contamination of thread state */
-		err |= restore_thread_fp_context(sc);
+		/* restore fpu context if we have used it before */
+		own_fpu();
+		err |= restore_fp_context(sc);
+	} else {
+		/* signal handler may have used FPU.  Give it up. */
+		loose_fpu();
 	}
 
-out:
 	return err;
 }
 
@@ -195,7 +136,6 @@
 
 static int inline setup_sigcontext(struct pt_regs *regs, struct sigcontext *sc)
 {
-	int owned_fp;
 	int err = 0;
 
 	err |= __put_user(regs->cp0_epc, &sc->sc_pc);
@@ -220,25 +160,20 @@
 	err |= __put_user(regs->cp0_cause, &sc->sc_cause);
 	err |= __put_user(regs->cp0_badvaddr, &sc->sc_badvaddr);
 
-	owned_fp = (current == last_task_used_math);
-	err |= __put_user(owned_fp, &sc->sc_ownedfp);
 	err |= __put_user(current->used_math, &sc->sc_used_math);
 
 	if (!current->used_math)
 		goto out;
 
-	/* There exists FP thread state that may be trashed by signal */
-	if (owned_fp) {
-		/* fp is active.  Save context from FPU */
-		err |= save_fp_context(sc);
-		goto out;
-	}
-
 	/*
-	 * Someone else has FPU.
-	 * Copy Thread context into signal context
+	 * Save FPU state to signal context.  Signal handler will "inherit"
+	 * current FPU state.
 	 */
-	err |= save_thread_fp_context(sc);
+	if (!is_fpu_owner()) {
+		own_fpu();
+		restore_fp(current);
+	}
+	err |= save_fp_context(sc);
 
 out:
 	return err;
diff -Nru link/arch/mips64/kernel/traps.c.orig link/arch/mips64/kernel/traps.c
--- link/arch/mips64/kernel/traps.c.orig	Fri Nov  1 10:11:19 2002
+++ link/arch/mips64/kernel/traps.c	Fri Nov  1 10:43:39 2002
@@ -21,6 +21,7 @@
 #include <asm/bootinfo.h>
 #include <asm/branch.h>
 #include <asm/cpu.h>
+#include <asm/fpu.h>
 #include <asm/module.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
@@ -560,49 +561,33 @@
 asmlinkage void do_cpu(struct pt_regs *regs)
 {
 	unsigned int cpid;
-	void fpu_emulator_init_fpu(void);
-	int sig;
 
 	cpid = (regs->cp0_cause >> CAUSEB_CE) & 3;
 	if (cpid != 1)
 		goto bad_cid;
 
-	if (!(mips_cpu.options & MIPS_CPU_FPU))
-		goto fp_emul;
+	die_if_kernel("do_cpu invoked from kernel context!", regs);
 
-	regs->cp0_status |= ST0_CU1;
-	if (last_task_used_math == current)
-		return;
-
-	if (current->used_math) {		/* Using the FPU again.  */
-		lazy_fpu_switch(last_task_used_math, current);
-	} else {				/* First time FPU user.  */
-		if (last_task_used_math != NULL)
-			save_fp(last_task_used_math);
+	own_fpu();
+	if (current->used_math) {               /* Using the FPU again.  */
+		restore_fp(current);
+	} else {
 		init_fpu();
 		current->used_math = 1;
 	}
-	last_task_used_math = current;
 
-	return;
-
-fp_emul:
-	if (last_task_used_math != current) {
-		if (!current->used_math) {
-			fpu_emulator_init_fpu();
-			current->used_math = 1;
+	if (!(mips_cpu.options & MIPS_CPU_FPU)) {
+		int sig = fpu_emulator_cop1Handler(0, regs, &current->thread.fpu.soft);
+		if (sig) {
+			/*
+			 * Return EPC is not calculated in the FPU emulator, if
+			 * a signal is being send. So we calculate it here.
+			 */
+			compute_return_epc(regs);
+			force_sig(sig, current);
 		}
 	}
-	sig = fpu_emulator_cop1Handler(0, regs, &current->thread.fpu.soft);
-	last_task_used_math = current;
-	if (sig) {
-		/*
-		 * Return EPC is not calculated in the FPU emulator, if
-		 * a signal is being send. So we calculate it here.
-		 */
-		compute_return_epc(regs);
-		force_sig(sig, current);
-	}
+
 	return;
 
 bad_cid:
@@ -676,6 +661,7 @@
 
 asmlinkage int (*save_fp_context)(struct sigcontext *sc);
 asmlinkage int (*restore_fp_context)(struct sigcontext *sc);
+
 extern asmlinkage int _save_fp_context(struct sigcontext *sc);
 extern asmlinkage int _restore_fp_context(struct sigcontext *sc);
 
diff -Nru link/arch/mips64/kernel/r4k_switch.S.orig link/arch/mips64/kernel/r4k_switch.S
--- link/arch/mips64/kernel/r4k_switch.S.orig	Fri Nov  1 10:11:18 2002
+++ link/arch/mips64/kernel/r4k_switch.S	Fri Nov  1 10:45:55 2002
@@ -23,6 +23,19 @@
 
 	.set	mips3
 
+#define PF_USEDFPU      0x00100000      /* task used FPU this quantum (SMP) */
+#define ST_OFF (KERNEL_STACK_SIZE - 32 - PT_SIZE + PT_STATUS)
+
+/*
+ * [jsun] FPU context is saved if and only if the process has used FPU in 
+ * the current run (PF_USEDFPU).  In any case, the CU1 bit for user space 
+ * STATUS register should be 0, so that a process *always* starts its 
+ * userland with FPU disabled after each context switch.
+ *
+ * FPU will be enabled as soon as the process accesses FPU again, through
+ * do_cpu() trap.
+ */
+
 /*
  * task_struct *resume(task_struct *prev, task_struct *next,
  *                     struct thread_info *next_ti))
@@ -35,6 +48,38 @@
 	sd	ra, THREAD_REG31(a0)
 
 	/*
+	 * check if we need to save FPU registers
+	 */
+	ld	t0, TASK_FLAGS(a0)
+	li	t1, PF_USEDFPU
+	and	t2, t0, t1
+	beqz	t2, 1f
+	nor	t1, zero, t1
+
+	/*
+	 * clear PF_USEDFPU bit in task flags
+	 */
+	and	t0, t0, t1
+	sd	t0, TASK_FLAGS(a0)
+
+	/*
+	 * clear saved user stack CU1 bit
+	 */
+	ld	t0, ST_OFF(a0)
+	li	t1, ~ST0_CU1
+	and	t0, t0, t1
+	sd	t0, ST_OFF(a0)
+
+	
+	sll	t2, t0, 5
+	bgez	t2, 2f
+	sdc1	$f0, (THREAD_FPU + 0x00)(a0)
+        fpu_save_16odd a0
+2:
+        fpu_save_16even a0 t1                   # clobbers t1
+1:
+
+	/*
 	 * The order of restoring the registers takes care of the race
 	 * updating $28, $29 and kernelsp without disabling ints.
 	 */
@@ -57,49 +102,9 @@
 	END(resume)
 
 /*
- * Do lazy fpu context switch.  Saves FPU context to the process in a0
- * and loads the new context of the current process.
- */
-
-#define ST_OFF (KERNEL_STACK_SIZE - 32 - PT_SIZE + PT_STATUS)
-
-LEAF(lazy_fpu_switch)
-	mfc0	t0, CP0_STATUS			# enable cp1
-	li	t3, ST0_CU1
-	or	t0, t3
-	mtc0	t0, CP0_STATUS
-	FPU_ENABLE_HAZARD
-
-	nor	t3, zero, t3
-	beqz	a0, 2f				# Save floating point state
-
-	ld	t1, ST_OFF(a0)			# last thread looses fpu
-	and	t1, t3
-	sd	t1, ST_OFF(a0)
-	sll	t2, t1, 5
-	sdc1	$f0, (THREAD_FPU + 0x00)(a0)
-	bgez	t2, 1f
-	fpu_save_16odd a0
-1:
-	fpu_save_16even a0 t1			# clobbers t1
-2:
-
-	beqz	a1, 3f
-
-	sll	t0, t0, 5			# load new fp state
-	ldc1	$f0, (THREAD_FPU + 0x00)(a1)
-	bgez	t0, 1f
-	fpu_restore_16odd a1
-1:
-	fpu_restore_16even a1, t0		# clobbers t0
-3:
-	jr	ra
-	END(lazy_fpu_switch)
-
-/*
  * Save a thread's fp context.
  */
-LEAF(save_fp)
+LEAF(_save_fp)
 	mfc0	t0, CP0_STATUS
 	sll	t1, t0, 5
 	bgez	t1, 1f				# 16 register mode?
@@ -108,12 +113,12 @@
 	fpu_save_16even a0 t1			# clobbers t1
 	sdc1	$f0, (THREAD_FPU + 0x00)(a0)
 	jr	ra
-	END(save_fp)
+	END(_save_fp)
 
 /*
  * Restore a thread's fp context.
  */
-LEAF(restore_fp)
+LEAF(_restore_fp)
 	mfc0	t0, CP0_STATUS
 	sll	t1, t0, 5
 	bgez	t1, 1f				# 16 register mode?
@@ -123,7 +128,7 @@
 	 ldc1	$f0, (THREAD_FPU + 0x00)(a0)
 
 	jr	ra
-	END(restore_fp)
+	END(_restore_fp)
 
 /*
  * Load the FPU with signalling NANS.  This bit pattern we're using has
@@ -135,7 +140,7 @@
 
 #define FPU_DEFAULT  0x00000000
 
-LEAF(init_fpu)
+LEAF(_init_fpu)
 	mfc0	t0, CP0_STATUS
 	li	t1, ST0_CU1
 	or	t0, t1
@@ -183,4 +188,4 @@
 	dmtc1	t0, $f28
 	dmtc1	t0, $f30
 	jr	ra
-	END(init_fpu)
+	END(_init_fpu)
diff -Nru link/arch/mips64/kernel/cpu-probe.c.orig link/arch/mips64/kernel/cpu-probe.c
--- link/arch/mips64/kernel/cpu-probe.c.orig	Tue Sep  3 14:04:31 2002
+++ link/arch/mips64/kernel/cpu-probe.c	Fri Nov  1 10:17:50 2002
@@ -3,6 +3,7 @@
 #include <linux/stddef.h>
 #include <asm/bugs.h>
 #include <asm/cpu.h>
+#include <asm/fpu.h>
 #include <asm/mipsregs.h>
 
 /*
diff -Nru link/arch/mips64/kernel/signal32.c.orig link/arch/mips64/kernel/signal32.c
--- link/arch/mips64/kernel/signal32.c.orig	Fri Nov  1 10:11:19 2002
+++ link/arch/mips64/kernel/signal32.c	Fri Nov  1 10:53:18 2002
@@ -25,14 +25,13 @@
 #include <asm/uaccess.h>
 #include <asm/ucontext.h>
 #include <asm/system.h>
+#include <asm/fpu.h>
 
 #define DEBUG_SIG 0
 
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
 extern asmlinkage int do_signal32(sigset_t *oldset, struct pt_regs *regs);
-extern asmlinkage int (*save_fp_context)(struct sigcontext *sc);
-extern asmlinkage int (*restore_fp_context)(struct sigcontext *sc);
 
 extern asmlinkage void do_syscall_trace(void);
 
@@ -257,58 +256,9 @@
 	return ret;
 }
 
-static inline int restore_thread_fp_context(struct sigcontext *sc)
-{
-	u64 *pfreg = &current->thread.fpu.soft.regs[0];
-	int err = 0;
-
-	/*
-	 * Copy all 32 64-bit values.
-	 */
-
-#define restore_fpr(i) 						\
-	do { err |= __get_user(pfreg[i], &sc->sc_fpregs[i]); } while(0)
-
-	restore_fpr( 0); restore_fpr( 1); restore_fpr( 2); restore_fpr( 3);
-	restore_fpr( 4); restore_fpr( 5); restore_fpr( 6); restore_fpr( 7);
-	restore_fpr( 8); restore_fpr( 9); restore_fpr(10); restore_fpr(11);
-	restore_fpr(12); restore_fpr(13); restore_fpr(14); restore_fpr(15);
-	restore_fpr(16); restore_fpr(17); restore_fpr(18); restore_fpr(19);
-	restore_fpr(20); restore_fpr(21); restore_fpr(22); restore_fpr(23);
-	restore_fpr(24); restore_fpr(25); restore_fpr(26); restore_fpr(27);
-	restore_fpr(28); restore_fpr(29); restore_fpr(30); restore_fpr(31);
-
-	err |= __get_user(current->thread.fpu.soft.sr, &sc->sc_fpc_csr);
-
-	return err;
-}
-
-static inline int save_thread_fp_context(struct sigcontext *sc)
-{
-	u64 *pfreg = &current->thread.fpu.soft.regs[0];
-	int err = 0;
-
-#define save_fpr(i) 							\
-	do { err |= __put_user(pfreg[i], &sc->sc_fpregs[i]); } while(0)
-
-	save_fpr( 0); save_fpr( 1); save_fpr( 2); save_fpr( 3);
-	save_fpr( 4); save_fpr( 5); save_fpr( 6); save_fpr( 7);
-	save_fpr( 8); save_fpr( 9); save_fpr(10); save_fpr(11);
-	save_fpr(12); save_fpr(13); save_fpr(14); save_fpr(15);
-	save_fpr(16); save_fpr(17); save_fpr(18); save_fpr(19);
-	save_fpr(20); save_fpr(21); save_fpr(22); save_fpr(23);
-	save_fpr(24); save_fpr(25); save_fpr(26); save_fpr(27);
-	save_fpr(28); save_fpr(29); save_fpr(30); save_fpr(31);
-
-	err |= __put_user(current->thread.fpu.soft.sr, &sc->sc_fpc_csr);
-
-	return err;
-}
-
 static asmlinkage int restore_sigcontext(struct pt_regs *regs,
 					 struct sigcontext *sc)
 {
-	int owned_fp;
 	int err = 0;
 
 	err |= __get_user(regs->cp0_epc, &sc->sc_pc);
@@ -331,26 +281,17 @@
 	restore_gp_reg(31);
 #undef restore_gp_reg
 
-	err |= __get_user(owned_fp, &sc->sc_ownedfp);
 	err |= __get_user(current->used_math, &sc->sc_used_math);
 
-	if (owned_fp) {
-		err |= restore_fp_context(sc);
-		goto out;
-	}
-
-	if (current == last_task_used_math) {
-		/* Signal handler acquired FPU - give it back */
-		last_task_used_math = NULL;
-		regs->cp0_status &= ~ST0_CU1;
-	}
-
 	if (current->used_math) {
-		/* Undo possible contamination of thread state */
-		err |= restore_thread_fp_context(sc);
+		/* restore fpu context if we have used it before */
+		own_fpu();
+		err |= restore_fp_context(sc);
+	} else {
+		/* signal handler may have used FPU.  Give it up. */
+		loose_fpu();
 	}
 
-out:
 	return err;
 }
 
@@ -490,7 +431,6 @@
 static int inline setup_sigcontext(struct pt_regs *regs,
 				   struct sigcontext *sc)
 {
-	int owned_fp;
 	int err = 0;
 
 	err |= __put_user(regs->cp0_epc, &sc->sc_pc);
@@ -515,25 +455,20 @@
 	err |= __put_user(regs->cp0_cause, &sc->sc_cause);
 	err |= __put_user(regs->cp0_badvaddr, &sc->sc_badvaddr);
 
-	owned_fp = (current == last_task_used_math);
-	err |= __put_user(owned_fp, &sc->sc_ownedfp);
 	err |= __put_user(current->used_math, &sc->sc_used_math);
 
 	if (!current->used_math)
 		goto out;
 
-	/* There exists FP thread state that may be trashed by signal */
-	if (owned_fp) {
-		/* fp is active.  Save context from FPU */
-		err |= save_fp_context(sc);
-		goto out;
-	}
-
-	/*
-	 * Someone else has FPU.
-	 * Copy Thread context into signal context
+	/* 
+	 * Save FPU state to signal context.  Signal handler will "inherit"
+	 * current FPU state.
 	 */
-	err |= save_thread_fp_context(sc);
+	if (!is_fpu_owner()) {
+		own_fpu();
+		restore_fp(current);
+	}
+	err |= save_fp_context(sc);
 
 out:
 	return err;
diff -Nru link/include/asm-mips/processor.h.orig link/include/asm-mips/processor.h
--- link/include/asm-mips/processor.h.orig	Fri Nov  1 10:13:26 2002
+++ link/include/asm-mips/processor.h	Fri Nov  1 11:11:19 2002
@@ -71,9 +71,6 @@
 #define wp_works_ok 1
 #define wp_works_ok__is_a_macro /* for versions in ksyms.c */
 
-/* Lazy FPU handling on uni-processor */
-extern struct task_struct *last_task_used_math;
-
 /*
  * User space process size: 2GB. This is hardcoded into a few places,
  * so don't change it unless you know what you are doing.  TASK_SIZE
@@ -196,20 +193,16 @@
 /*
  * Do necessary setup to start up a newly executed thread.
  */
-#define start_thread(regs, new_pc, new_sp) do {				\
-	/* New thread loses kernel and FPU privileges. */	       	\
-	regs->cp0_status = (regs->cp0_status & ~(ST0_CU0|ST0_KSU|ST0_CU1)) | KU_USER;\
-	regs->cp0_epc = new_pc;						\
-	regs->regs[29] = new_sp;					\
-	current_thread_info()->addr_limit = USER_DS;			\
-} while (0)
+extern void start_thread(struct pt_regs * regs, unsigned long pc, unsigned long sp);
 
+struct task_struct;
 unsigned long get_wchan(struct task_struct *p);
 
 #define __PT_REG(reg) ((long)&((struct pt_regs *)0)->reg - sizeof(struct pt_regs))
 #define __KSTK_TOS(tsk) ((unsigned long)(tsk->thread_info) + KERNEL_STACK_SIZE - 32)
 #define KSTK_EIP(tsk) (*(unsigned long *)(__KSTK_TOS(tsk) + __PT_REG(cp0_epc)))
 #define KSTK_ESP(tsk) (*(unsigned long *)(__KSTK_TOS(tsk) + __PT_REG(regs[29])))
+#define KSTK_STATUS(tsk) (*(unsigned long *)(__KSTK_TOS(tsk) + __PT_REG(cp0_status)))
 
 #define cpu_relax()	barrier()
 
diff -Nru link/include/asm-mips/mipsregs.h.orig link/include/asm-mips/mipsregs.h
--- link/include/asm-mips/mipsregs.h.orig	Fri Nov  1 10:13:26 2002
+++ link/include/asm-mips/mipsregs.h	Fri Nov  1 10:17:50 2002
@@ -1002,48 +1002,6 @@
 __BUILD_SET_CP0(cause,CP0_CAUSE)
 __BUILD_SET_CP0(config,CP0_CONFIG)
 
-#if defined(CONFIG_CPU_SB1)
-#define __enable_fpu_hazard()						\
-do {									\
-	asm(".set push		\n\t"					\
-	    ".set mips64	\n\t"					\
-	    ".set noreorder	\n\t"					\
-	    "ssnop		\n\t"					\
-	    "bnezl $0, .+4	\n\t"					\
-	    "ssnop		\n\t"					\
-	    ".set pop");						\
-} while (0)
-#else
-#define __enable_fpu_hazard()						\
-do {									\
-	asm("nop;nop;nop;nop");		/* max. hazard */		\
-} while (0)
-#endif
-
-#define __enable_fpu()							\
-do {									\
-	set_cp0_status(ST0_CU1);					\
-	__enable_fpu_hazard();						\
-} while (0)
-
-#define __disable_fpu()							\
-do {									\
-	clear_cp0_status(ST0_CU1);					\
-	/* We don't care about the cp0 hazard here  */			\
-} while (0)
-
-#define enable_fpu()							\
-do {									\
-	if (mips_cpu.options & MIPS_CPU_FPU)				\
-		__enable_fpu();						\
-} while (0)
-
-#define disable_fpu()							\
-do {									\
-	if (mips_cpu.options & MIPS_CPU_FPU)				\
-		__disable_fpu();					\
-} while (0)
-
 #endif /* !__ASSEMBLY__ */
 
 #endif /* _ASM_MIPSREGS_H */
diff -Nru link/include/asm-mips/sigcontext.h.orig link/include/asm-mips/sigcontext.h
--- link/include/asm-mips/sigcontext.h.orig	Wed Jul 10 14:26:34 2002
+++ link/include/asm-mips/sigcontext.h	Fri Nov  1 10:17:50 2002
@@ -18,7 +18,6 @@
 	unsigned long long sc_pc;
 	unsigned long long sc_regs[32];
 	unsigned long long sc_fpregs[32];
-	unsigned int       sc_ownedfp;
 	unsigned int       sc_fpc_csr;
 	unsigned int       sc_fpc_eir;		/* Unused */
 	unsigned int       sc_used_math;
diff -Nru link/include/asm-mips/system.h.orig link/include/asm-mips/system.h
--- link/include/asm-mips/system.h.orig	Fri Nov  1 10:13:26 2002
+++ link/include/asm-mips/system.h	Fri Nov  1 10:54:37 2002
@@ -225,11 +225,6 @@
 
 struct task_struct;
 
-extern asmlinkage void lazy_fpu_switch(void *prev, void *next);
-extern asmlinkage void init_fpu(void);
-extern asmlinkage void save_fp(struct task_struct *);
-extern asmlinkage void restore_fp(struct task_struct *);
-
 #define switch_to(prev,next,last) \
 do { \
 	(last) =resume(prev, next, next->thread_info); \
diff -Nru link/include/asm-mips64/mipsregs.h.orig link/include/asm-mips64/mipsregs.h
--- link/include/asm-mips64/mipsregs.h.orig	Fri Nov  1 10:13:27 2002
+++ link/include/asm-mips64/mipsregs.h	Fri Nov  1 10:17:53 2002
@@ -896,47 +896,6 @@
 __BUILD_SET_CP0(cause,CP0_CAUSE)
 __BUILD_SET_CP0(config,CP0_CONFIG)
 
-#if defined(CONFIG_CPU_SB1)
-#define __enable_fpu_hazard()						\
-do {									\
-	asm(".set push		\n\t"					\
-	    ".set mips2		\n\t"					\
-	    ".set noreorder	\n\t"					\
-	    "sll $0,$0,1	\n\t"					\
-	    "bnezl $0, .+4	\n\t"					\
-	    " sll $0,$0,1	\n\t"					\
-	    ".set pop");						\
-} while (0)
-#else
-#define __enable_fpu_hazard()						\
-do {									\
-	asm("nop;nop;nop;nop");		/* max. hazard */		\
-} while (0)
-#endif
-
-#define __enable_fpu()							\
-do {									\
-	set_cp0_status(ST0_CU1);					\
-	__enable_fpu_hazard();						\
-} while (0)
-
-#define __disable_fpu()							\
-do {									\
-	clear_cp0_status(ST0_CU1);					\
-	/* We don't care about the cp0 hazard here  */			\
-} while (0)
-
-#define enable_fpu()							\
-do {									\
-	if (mips_cpu.options & MIPS_CPU_FPU)				\
-		__enable_fpu();						\
-} while (0)
-
-#define disable_fpu()							\
-do {									\
-	if (mips_cpu.options & MIPS_CPU_FPU)				\
-		__disable_fpu();					\
-} while (0)
 #endif /* !__ASSEMBLY__ */
 
 #endif /* _ASM_MIPSREGS_H */
diff -Nru link/include/asm-mips64/sigcontext.h.orig link/include/asm-mips64/sigcontext.h
--- link/include/asm-mips64/sigcontext.h.orig	Tue Sep  3 14:07:16 2002
+++ link/include/asm-mips64/sigcontext.h	Fri Nov  1 10:17:53 2002
@@ -20,7 +20,6 @@
 	unsigned long long sc_mdlo;
 	unsigned long long sc_pc;
 	unsigned int       sc_status;
-	unsigned int       sc_ownedfp;
 	unsigned int       sc_fpc_csr;
 	unsigned int       sc_fpc_eir;
 	unsigned int       sc_used_math;
diff -Nru link/include/asm-mips64/system.h.orig link/include/asm-mips64/system.h
--- link/include/asm-mips64/system.h.orig	Fri Nov  1 10:13:27 2002
+++ link/include/asm-mips64/system.h	Fri Nov  1 10:58:08 2002
@@ -211,11 +211,6 @@
 
 struct task_struct;
 
-extern asmlinkage void lazy_fpu_switch(void *prev, void *next);
-extern asmlinkage void init_fpu(void);
-extern asmlinkage void save_fp(struct task_struct *);
-extern asmlinkage void restore_fp(struct task_struct *);
-
 #define switch_to(prev,next,last) \
 do { \
 	(last) = resume(prev, next, next->thread_info); \
diff -Nru link/include/asm-mips64/processor.h.orig link/include/asm-mips64/processor.h
--- link/include/asm-mips64/processor.h.orig	Fri Nov  1 10:13:27 2002
+++ link/include/asm-mips64/processor.h	Fri Nov  1 11:12:27 2002
@@ -100,9 +100,6 @@
 #define wp_works_ok 1
 #define wp_works_ok__is_a_macro /* for versions in ksyms.c */
 
-/* Lazy FPU handling on uni-processor */
-extern struct task_struct *last_task_used_math;
-
 /*
  * User space process size: 1TB. This is hardcoded into a few places,
  * so don't change it unless you know what you are doing.  TASK_SIZE
@@ -231,26 +228,16 @@
 /*
  * Do necessary setup to start up a newly executed thread.
  */
-#define start_thread(regs, pc, sp) 					\
-do {									\
-	unsigned long __status;						\
-									\
-	/* New thread looses kernel privileges. */			\
-	__status = regs->cp0_status & ~(ST0_CU0|ST0_FR|ST0_KSU);	\
-	__status |= KSU_USER;						\
-	__status |= (current->thread.mflags & MF_32BIT) ? 0 : ST0_FR;	\
-	regs->cp0_status = __status;					\
-	regs->cp0_epc = pc;						\
-	regs->regs[29] = sp;						\
-	current_thread_info()->addr_limit = USER_DS;			\
-} while(0)
+extern void start_thread(struct pt_regs * regs, unsigned long pc, unsigned long sp);
 
+struct task_struct;
 unsigned long get_wchan(struct task_struct *p);
 
 #define __PT_REG(reg) ((long)&((struct pt_regs *)0)->reg - sizeof(struct pt_regs))
 #define __KSTK_TOS(tsk) ((unsigned long)(tsk->thread_info) + KERNEL_STACK_SIZE - 32)
 #define KSTK_EIP(tsk) (*(unsigned long *)(__KSTK_TOS(tsk) + __PT_REG(cp0_epc)))
 #define KSTK_ESP(tsk) (*(unsigned long *)(__KSTK_TOS(tsk) + __PT_REG(regs[29])))
+#define KSTK_STATUS(tsk) (*(unsigned long *)(__KSTK_TOS(tsk) + __PT_REG(cp0_status)))
 
 #define cpu_relax()	barrier()
 

--zhXaljGHf11kAtnf--
