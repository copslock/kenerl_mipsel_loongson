Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Oct 2002 00:23:33 +0100 (CET)
Received: from gateway-1237.mvista.com ([12.44.186.158]:25335 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S1121743AbSJ1XXc>;
	Tue, 29 Oct 2002 00:23:32 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id g9SNNPW09298;
	Mon, 28 Oct 2002 15:23:25 -0800
Date: Mon, 28 Oct 2002 15:23:25 -0800
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: [PATCH] new fpu code
Message-ID: <20021028152325.F24266@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jq0ap7NbKX2Kqbes"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 528
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


I finally pull myself together and create a clean FPU/SMP patch.  See
the attachment.

After much discussion and experiments, it is clear approach 2) in my
original proposal is the winner.  In other words:

. we save the FPU context if process used FPU in the last run
. we restore FPU on next time it uses FPU again

On doing this I also cleaned up a couple of other FPU related places.

This patch only changes linux 2.4 for 32bit MIPS.  64bit MIPS is already
using a similar algorithm.  I will extend the patch to 2.5 and 64bit
if there are no further issues.

Jun

--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="021028.new-fpu.patch"


The original motivation is to make FPU work again in SMP.  Later
it becomes obvious that the most sensible thing to do is to get
rid of lazy fpu context switch, which leads to a bunch of other
releated cleanups.

. removed last_task_used_math and lazy fpu switch
. introduced asm/fpu.h as a place to hold inline fpu functions
. simplified fpu-related part in signal handling

This patch only applies to 32bit, linux_2_4 MIPS tree right now. 

Jun
021028

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
+++ link/arch/mips/kernel/signal.c	Mon Oct 28 13:30:04 2002
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
 
@@ -265,25 +212,13 @@
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
+		own_fpu();
+		err |= restore_fp_context(sc);
 	}
 
-out:
 	return err;
 }
 
@@ -380,7 +315,6 @@
 
 static int inline setup_sigcontext(struct pt_regs *regs, struct sigcontext *sc)
 {
-	int owned_fp;
 	int err = 0;
 	u64 reg;
 
@@ -408,25 +342,19 @@
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
+	/* Save FPU state to signal context */
+	if (!is_fpu_owner()) {
+		own_fpu();
+		restore_fp(current);
 	}
 
-	/*
-	 * Someone else has FPU.
-	 * Copy Thread context into signal context
-	 */
-	err |= save_thread_fp_context(sc);
+	/* fp is active.  Save context from FPU */
+	err |= save_fp_context(sc);
 
 out:
 	return err;
diff -Nru link/arch/mips/kernel/traps.c.orig link/arch/mips/kernel/traps.c
--- link/arch/mips/kernel/traps.c.orig	Mon Oct 28 10:55:17 2002
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
+++ link/arch/mips/kernel/r2300_switch.S	Mon Oct 28 11:21:18 2002
@@ -28,6 +28,9 @@
 	.set	mips1
 	.align	5
 
+#define PF_USEDFPU      0x00100000      /* task used FPU this quantum (SMP) */
+#define ST_OFF (KERNEL_STACK_SIZE - 32 - PT_SIZE + PT_STATUS)
+
 /*
  * task_struct *resume(task_struct *prev,
  *                     task_struct *next)
@@ -41,6 +44,32 @@
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
@@ -64,47 +93,20 @@
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
diff -Nru link/arch/mips/kernel/r4k_switch.S.orig link/arch/mips/kernel/r4k_switch.S
--- link/arch/mips/kernel/r4k_switch.S.orig	Mon Aug  5 16:53:33 2002
+++ link/arch/mips/kernel/r4k_switch.S	Mon Oct 28 10:56:40 2002
@@ -25,6 +25,9 @@
 
 #include <asm/asmmacro.h>
 
+#define PF_USEDFPU      0x00100000      /* task used FPU this quantum (SMP) */
+#define ST_OFF (KERNEL_STACK_SIZE - 32 - PT_SIZE + PT_STATUS)
+
 /*
  * task_struct *r4xx0_resume(task_struct *prev, task_struct *next)
  */
@@ -39,6 +42,32 @@
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
+	FPU_SAVE_DOUBLE(a0, t0)			# clobbers t0
+
+1:
 	/*
 	 * The order of restoring the registers takes care of the race
 	 * updating $28, $29 and kernelsp without disabling ints.
@@ -62,6 +91,8 @@
 	lw	a2, THREAD_STATUS($28)
 	nor	a3, $0, a3
 	and	a2, a3
+	li	t0, ~ST0_CU1		/* disable FPU */
+	and	a2, t0
 	or	a2, t1
 	mtc0	a2, CP0_STATUS
 	jr	ra
@@ -69,50 +100,20 @@
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
@@ -124,7 +125,7 @@
 
 #define FPU_DEFAULT  0x00000000
 
-LEAF(init_fpu)
+LEAF(_init_fpu)
 	.set	mips3
 	mfc0	t0, CP0_STATUS
 	li	t1, ST0_CU1
@@ -156,5 +157,5 @@
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
diff -Nru link/include/asm-mips/fpu.h.orig link/include/asm-mips/fpu.h
--- link/include/asm-mips/fpu.h.orig	Mon Oct 28 10:56:40 2002
+++ link/include/asm-mips/fpu.h	Mon Oct 28 13:28:00 2002
@@ -0,0 +1,135 @@
+/*
+ * Copyright (C) 2002 MontaVista Software Inc.
+ * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+
+#ifndef _ASM_FPU_H
+#define _ASM_FPU_H
+
+#include <linux/config.h>
+#include <linux/sched.h>
+
+#include <asm/mipsregs.h>
+#include <asm/cpu.h>
+#include <asm/processor.h>
+#include <asm/current.h>
+
+struct sigcontext;
+
+extern asmlinkage int (*save_fp_context)(struct sigcontext *sc);
+extern asmlinkage int (*restore_fp_context)(struct sigcontext *sc);
+
+extern void fpu_emulator_init_fpu(void);
+extern void _init_fpu(void);
+extern void _save_fp(struct task_struct *);
+extern void _restore_fp(struct task_struct *);
+
+#if defined(CONFIG_CPU_SB1)
+#define __enable_fpu_hazard()                                           \
+do {                                                                    \
+        asm(".set push          \n\t"                                   \
+            ".set mips64        \n\t"                                   \
+            ".set noreorder     \n\t"                                   \
+            "ssnop              \n\t"                                   \
+            "bnezl $0, .+4      \n\t"                                   \
+            "ssnop              \n\t"                                   \
+            ".set pop");                                                \
+} while (0)
+#else
+#define __enable_fpu_hazard()                                           \
+do {                                                                    \
+        asm("nop;nop;nop;nop");         /* max. hazard */               \
+} while (0)
+#endif
+
+#define __enable_fpu()                                                  \
+do {                                                                    \
+        set_cp0_status(ST0_CU1);                                        \
+        __enable_fpu_hazard();                                          \
+} while (0)
+
+#define __disable_fpu()							\
+do {									\
+	clear_cp0_status(ST0_CU1);					\
+	/* We don't care about the cp0 hazard here  */			\
+} while (0)
+
+#define enable_fpu()							\
+do {									\
+	if (mips_cpu.options & MIPS_CPU_FPU)				\
+		__enable_fpu();						\
+} while (0)
+
+#define disable_fpu()							\
+do {									\
+	if (mips_cpu.options & MIPS_CPU_FPU)				\
+		__disable_fpu();					\
+} while (0)
+
+
+#define clear_fpu_owner() do {current->flags &= ~PF_USEDFPU; } while(0)
+
+static inline int is_fpu_owner(void)
+{
+	return (mips_cpu.options & MIPS_CPU_FPU) && 
+		((current->flags & PF_USEDFPU) != 0); 
+}
+
+static inline void own_fpu(void)
+{
+	if(mips_cpu.options & MIPS_CPU_FPU) {
+		__enable_fpu();
+		KSTK_STATUS(current) |= ST0_CU1;
+		current->flags |= PF_USEDFPU;
+	}
+}
+
+static inline void loose_fpu(void)
+{
+	if (mips_cpu.options & MIPS_CPU_FPU) {
+		KSTK_STATUS(current) &= ~ST0_CU1;
+		current->flags &= ~PF_USEDFPU;
+		__disable_fpu();
+	}
+}
+
+static inline void init_fpu(void)
+{
+	if (mips_cpu.options & MIPS_CPU_FPU) {
+		_init_fpu();
+	} else {
+		fpu_emulator_init_fpu();
+	}
+}
+
+static inline void save_fp(struct task_struct *tsk)
+{
+	if (mips_cpu.options & MIPS_CPU_FPU) 
+		_save_fp(tsk);
+}
+
+static inline void restore_fp(struct task_struct *tsk)
+{
+	if (mips_cpu.options & MIPS_CPU_FPU) 
+		_restore_fp(tsk);
+}
+
+static inline unsigned long long *get_fpu_regs(struct task_struct *tsk)
+{
+	if(mips_cpu.options & MIPS_CPU_FPU) {
+		if ((tsk == current) && is_fpu_owner()) 
+			_save_fp(current);
+		return (unsigned long long *)&tsk->thread.fpu.hard.fp_regs[0];
+	} else {
+		return (unsigned long long *)tsk->thread.fpu.soft.regs;
+	}
+}
+
+#endif /* _ASM_FPU_H */
+
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

--jq0ap7NbKX2Kqbes--
