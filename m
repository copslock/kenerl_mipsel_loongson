Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Nov 2006 15:01:55 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:33020 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038980AbWKXPBY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Nov 2006 15:01:24 +0000
Received: from localhost (p6014-ipad01funabasi.chiba.ocn.ne.jp [61.207.80.14])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 8968CB97A; Sat, 25 Nov 2006 00:01:20 +0900 (JST)
Date:	Sat, 25 Nov 2006 00:04:04 +0900 (JST)
Message-Id: <20061125.000404.30186881.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 2/3] Allow CpU exception in kernel partially
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
X-archive-position: 13254
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

The save_fp_context()/restore_fp_context() might sleep on accessing
user staack and therefore might lose FPU ownership in middle of them.
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
 arch/mips/kernel/r2300_switch.S  |   10 ++++++----
 arch/mips/kernel/r4k_switch.S    |   10 ++++++----
 arch/mips/kernel/signal-common.h |   10 +++++++---
 arch/mips/kernel/signal32.c      |   10 +++++++---
 arch/mips/kernel/traps.c         |   17 +++++++++++++++--
 include/asm-mips/fpu.h           |   16 ++++++++++++++++
 include/asm-mips/thread_info.h   |    1 +
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
 
@@ -60,8 +59,8 @@ #endif
 	lw	t3, TASK_THREAD_INFO(a0)
 	lw	t0, TI_FLAGS(t3)
 	li	t1, _TIF_USEDFPU
-	and	t2, t0, t1
-	beqz	t2, 1f
+	and	t1, t0
+	beqz	t1, 1f
 	nor	t1, zero, t1
 
 	and	t0, t0, t1
@@ -74,10 +73,13 @@ #endif
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
@@ -48,8 +48,7 @@ #define ST_OFF (_THREAD_SIZE - 32 - PT_S
 #ifndef CONFIG_CPU_HAS_LLSC
 	sw	zero, ll_bit
 #endif
-	mfc0	t1, CP0_STATUS
-	LONG_S	t1, THREAD_STATUS(a0)
+	mfc0	t2, CP0_STATUS
 	cpu_save_nonscratch a0
 	LONG_S	ra, THREAD_REG31(a0)
 
@@ -59,8 +58,8 @@ #endif
 	PTR_L	t3, TASK_THREAD_INFO(a0)
 	LONG_L	t0, TI_FLAGS(t3)
 	li	t1, _TIF_USEDFPU
-	and	t2, t0, t1
-	beqz	t2, 1f
+	and	t1, t0
+	beqz	t1, 1f
 	nor	t1, zero, t1
 
 	and	t0, t0, t1
@@ -73,10 +72,13 @@ #endif
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
diff --git a/arch/mips/kernel/signal-common.h b/arch/mips/kernel/signal-common.h
index b1f09d5..b9051a0 100644
--- a/arch/mips/kernel/signal-common.h
+++ b/arch/mips/kernel/signal-common.h
@@ -57,9 +57,11 @@ #undef save_gp_reg
 		own_fpu();
 		restore_fp(current);
 	}
-	err |= save_fp_context(sc);
 
 	preempt_enable();
+	enable_fp_in_kernel();
+	err |= save_fp_context(sc);
+	disable_fp_in_kernel();
 
 out:
 	return err;
@@ -112,14 +114,16 @@ #undef restore_gp_reg
 	if (used_math()) {
 		/* restore fpu context if we have used it before */
 		own_fpu();
+		preempt_enable();
+		enable_fp_in_kernel();
 		err |= restore_fp_context(sc);
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
index c86a5dd..4d291b5 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -372,14 +372,16 @@ #undef restore_gp_reg
 	if (used_math()) {
 		/* restore fpu context if we have used it before */
 		own_fpu();
+		preempt_enable();
+		enable_fp_in_kernel();
 		err |= restore_fp_context32(sc);
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
 
@@ -603,9 +605,11 @@ #undef save_gp_reg
 		own_fpu();
 		restore_fp(current);
 	}
-	err |= save_fp_context32(sc);
 
 	preempt_enable();
+	enable_fp_in_kernel();
+	err |= save_fp_context32(sc);
+	disable_fp_in_kernel();
 
 out:
 	return err;
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index b18aeb6..182646d 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -759,12 +759,11 @@ asmlinkage void do_cpu(struct pt_regs *r
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
@@ -775,6 +774,9 @@ asmlinkage void do_cpu(struct pt_regs *r
 		break;
 
 	case 1:
+		if (!test_thread_flag(TIF_ALLOW_FP_IN_KERNEL))
+			die_if_kernel("do_cpu invoked from kernel context!",
+				      regs);
 		preempt_disable();
 
 		own_fpu();
@@ -787,6 +789,17 @@ asmlinkage void do_cpu(struct pt_regs *r
 
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
index e475c45..8210a84 100644
--- a/include/asm-mips/thread_info.h
+++ b/include/asm-mips/thread_info.h
@@ -118,6 +118,7 @@ #define TIF_RESTORE_SIGMASK	9	/* restore
 #define TIF_USEDFPU		16	/* FPU was used by this task this quantum (SMP) */
 #define TIF_POLLING_NRFLAG	17	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_MEMDIE		18
+#define TIF_ALLOW_FP_IN_KERNEL	19
 #define TIF_SYSCALL_TRACE	31	/* syscall trace active */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
