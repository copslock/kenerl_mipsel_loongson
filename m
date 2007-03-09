Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Mar 2007 16:29:37 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.175.29]:65238 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021502AbXCIQ3b (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 9 Mar 2007 16:29:31 +0000
Received: from localhost (p4160-ipad211funabasi.chiba.ocn.ne.jp [58.91.160.160])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 1228FBB90; Sat, 10 Mar 2007 01:28:12 +0900 (JST)
Date:	Sat, 10 Mar 2007 01:28:11 +0900 (JST)
Message-Id: <20070310.012811.108982622.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Allow CpU exception in kernel partially
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14407
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

The save_fp_context()/restore_fp_context() might sleep on accessing
user stack and therefore might lose FPU ownership in middle of them.
Also we should not disable preempt around these functions.  This patch
files this problem by allowing CpU exception in kernel partially.

* Introduce TIF_ALLOW_FP_IN_KERNEL thread flag.  If the flag was set,
  CpU exception handler enables CU1 bit in interrupted kernel context
  and returns without enabling interrupt (preempt) to make sure keep
  FPU ownership until resume.
* Introduce enable_fp_in_kernel() and disable_fp_in_kernel().  While
  we might lost FPU ownership in middle of CP0_STATUS manipulation
  (for example local_irq_disable()), we can not assume CU1 bit always
  reflects TIF_USEDFPU.  Therefore enable_fp_in_kernel() must drop CU1
  bit if TIF_USEDFPU was cleared.
* The resume() function must drop CU1 bit in CP0_STATUS which are to
  be saved.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
This is an update of:
http://www.linux-mips.org/archives/linux-mips/2006-11/msg00127.html

This patch depends on:
> Subject: [PATCH] Check FCSR for pending interrupts, alternative version
> Message-Id: <20070310.010348.72708233.anemo@mba.ocn.ne.jp>

This patch conflict with:
> Subject: [PATCH] rewrite restore_fp_context/save_fp_context
> Message-Id: <20070310.011845.85420915.anemo@mba.ocn.ne.jp>

 arch/mips/kernel/r2300_switch.S |   10 ++++++----
 arch/mips/kernel/r4k_switch.S   |   10 ++++++----
 arch/mips/kernel/signal.c       |   10 +++++++---
 arch/mips/kernel/signal32.c     |   10 +++++++---
 arch/mips/kernel/traps.c        |   17 +++++++++++++++--
 include/asm-mips/fpu.h          |   16 ++++++++++++++++
 include/asm-mips/thread_info.h  |    1 +
 7 files changed, 58 insertions(+), 16 deletions(-)

diff --git a/arch/mips/kernel/r2300_switch.S b/arch/mips/kernel/r2300_switch.S
index 656bde2..28c2e2e 100644
--- a/arch/mips/kernel/r2300_switch.S
+++ b/arch/mips/kernel/r2300_switch.S
@@ -49,8 +49,7 @@ LEAF(resume)
 #ifndef CONFIG_CPU_HAS_LLSC
 	sw      zero, ll_bit
 #endif
-	mfc0	t1, CP0_STATUS
-	sw	t1, THREAD_STATUS(a0)
+	mfc0	t2, CP0_STATUS
 	cpu_save_nonscratch a0
 	sw	ra, THREAD_REG31(a0)
 
@@ -60,8 +59,8 @@ LEAF(resume)
 	lw	t3, TASK_THREAD_INFO(a0)
 	lw	t0, TI_FLAGS(t3)
 	li	t1, _TIF_USEDFPU
-	and	t2, t0, t1
-	beqz	t2, 1f
+	and	t1, t0
+	beqz	t1, 1f
 	nor	t1, zero, t1
 
 	and	t0, t0, t1
@@ -74,10 +73,13 @@ LEAF(resume)
 	li	t1, ~ST0_CU1
 	and	t0, t0, t1
 	sw	t0, ST_OFF(t3)
+	/* clear thread_struct CU1 bit */
+	and	t2, t1
 
 	fpu_save_single a0, t0			# clobbers t0
 
 1:
+	sw	t2, THREAD_STATUS(a0)
 	/*
 	 * The order of restoring the registers takes care of the race
 	 * updating $28, $29 and kernelsp without disabling ints.
diff --git a/arch/mips/kernel/r4k_switch.S b/arch/mips/kernel/r4k_switch.S
index cc566cf..c7698fd 100644
--- a/arch/mips/kernel/r4k_switch.S
+++ b/arch/mips/kernel/r4k_switch.S
@@ -48,8 +48,7 @@
 #ifndef CONFIG_CPU_HAS_LLSC
 	sw	zero, ll_bit
 #endif
-	mfc0	t1, CP0_STATUS
-	LONG_S	t1, THREAD_STATUS(a0)
+	mfc0	t2, CP0_STATUS
 	cpu_save_nonscratch a0
 	LONG_S	ra, THREAD_REG31(a0)
 
@@ -59,8 +58,8 @@
 	PTR_L	t3, TASK_THREAD_INFO(a0)
 	LONG_L	t0, TI_FLAGS(t3)
 	li	t1, _TIF_USEDFPU
-	and	t2, t0, t1
-	beqz	t2, 1f
+	and	t1, t0
+	beqz	t1, 1f
 	nor	t1, zero, t1
 
 	and	t0, t0, t1
@@ -73,10 +72,13 @@
 	li	t1, ~ST0_CU1
 	and	t0, t0, t1
 	LONG_S	t0, ST_OFF(t3)
+	/* clear thread_struct CU1 bit */
+	and	t2, t1
 
 	fpu_save_double a0 t0 t1		# c0_status passed in t0
 						# clobbers t1
 1:
+	LONG_S	t2, THREAD_STATUS(a0)
 
 	/*
 	 * The order of restoring the registers takes care of the race
diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index bf094fc..c4ef270 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -117,9 +117,11 @@ int setup_sigcontext(struct pt_regs *reg
 			own_fpu();
 			restore_fp(current);
 		}
-		err |= save_fp_context(sc);
 
 		preempt_enable();
+		enable_fp_in_kernel();
+		err |= save_fp_context(sc);
+		disable_fp_in_kernel();
 	}
 	return err;
 }
@@ -193,15 +195,17 @@ int restore_sigcontext(struct pt_regs *r
 	if (used_math()) {
 		/* restore fpu context if we have used it before */
 		own_fpu();
+		preempt_enable();
+		enable_fp_in_kernel();
 		if (!err)
 			err = check_and_restore_fp_context(sc);
+		disable_fp_in_kernel();
 	} else {
 		/* signal handler may have used FPU.  Give it up. */
 		lose_fpu();
+		preempt_enable();
 	}
 
-	preempt_enable();
-
 	return err;
 }
 
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index 20013b6..cf5bbe0 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -213,9 +213,11 @@ static int setup_sigcontext32(struct pt_
 			own_fpu();
 			restore_fp(current);
 		}
-		err |= save_fp_context32(sc);
 
 		preempt_enable();
+		enable_fp_in_kernel();
+		err |= save_fp_context32(sc);
+		disable_fp_in_kernel();
 	}
 	return err;
 }
@@ -267,15 +269,17 @@ static int restore_sigcontext32(struct p
 	if (used_math()) {
 		/* restore fpu context if we have used it before */
 		own_fpu();
+		preempt_enable();
+		enable_fp_in_kernel();
 		if (!err)
 			err = check_and_restore_fp_context32(sc);
+		disable_fp_in_kernel();
 	} else {
 		/* signal handler may have used FPU.  Give it up. */
 		lose_fpu();
+		preempt_enable();
 	}
 
-	preempt_enable();
-
 	return err;
 }
 
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 18f56a9..d5833a4 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -775,12 +775,11 @@ asmlinkage void do_cpu(struct pt_regs *r
 {
 	unsigned int cpid;
 
-	die_if_kernel("do_cpu invoked from kernel context!", regs);
-
 	cpid = (regs->cp0_cause >> CAUSEB_CE) & 3;
 
 	switch (cpid) {
 	case 0:
+		die_if_kernel("do_cpu invoked from kernel context!", regs);
 		if (!cpu_has_llsc)
 			if (!simulate_llsc(regs))
 				return;
@@ -791,6 +790,9 @@ asmlinkage void do_cpu(struct pt_regs *r
 		break;
 
 	case 1:
+		if (!test_thread_flag(TIF_ALLOW_FP_IN_KERNEL))
+			die_if_kernel("do_cpu invoked from kernel context!",
+				      regs);
 		preempt_disable();
 
 		own_fpu();
@@ -803,6 +805,17 @@ asmlinkage void do_cpu(struct pt_regs *r
 
 		if (cpu_has_fpu) {
 			preempt_enable();
+			if (test_thread_flag(TIF_ALLOW_FP_IN_KERNEL)) {
+				local_irq_disable();
+				if (cpu_has_fpu)
+					regs->cp0_status |= ST0_CU1;
+				/*
+				 * We must return without enabling
+				 * interrupts to ensure keep FPU
+				 * ownership until resume.
+				 */
+				return;
+			}
 		} else {
 			int sig;
 			preempt_enable();
diff --git a/include/asm-mips/fpu.h b/include/asm-mips/fpu.h
index efef843..40536a2 100644
--- a/include/asm-mips/fpu.h
+++ b/include/asm-mips/fpu.h
@@ -68,6 +68,8 @@ do {									\
 	/* We don't care about the c0 hazard here  */			\
 } while (0)
 
+#define __fpu_enabled()	(read_c0_status() & ST0_CU1)
+
 #define enable_fpu()							\
 do {									\
 	if (cpu_has_fpu)						\
@@ -144,4 +146,18 @@ static inline fpureg_t *get_fpu_regs(str
 	return tsk->thread.fpu.fpr;
 }
 
+static inline void enable_fp_in_kernel(void)
+{
+	set_thread_flag(TIF_ALLOW_FP_IN_KERNEL);
+	/* make sure CU1 and FPU ownership are consistent */
+	if (!__is_fpu_owner() && __fpu_enabled())
+		__disable_fpu();
+}
+
+static inline void disable_fp_in_kernel(void)
+{
+	BUG_ON(!__is_fpu_owner() && __fpu_enabled());
+	clear_thread_flag(TIF_ALLOW_FP_IN_KERNEL);
+}
+
 #endif /* _ASM_FPU_H */
diff --git a/include/asm-mips/thread_info.h b/include/asm-mips/thread_info.h
index fbcda82..6cf05f4 100644
--- a/include/asm-mips/thread_info.h
+++ b/include/asm-mips/thread_info.h
@@ -119,6 +119,7 @@ register struct thread_info *__current_t
 #define TIF_POLLING_NRFLAG	17	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_MEMDIE		18
 #define TIF_FREEZE		19
+#define TIF_ALLOW_FP_IN_KERNEL	20
 #define TIF_SYSCALL_TRACE	31	/* syscall trace active */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
