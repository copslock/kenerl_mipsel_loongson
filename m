Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Mar 2007 16:34:14 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.175.29]:27857 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021497AbXCIQeJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 9 Mar 2007 16:34:09 +0000
Received: from localhost (p4160-ipad211funabasi.chiba.ocn.ne.jp [58.91.160.160])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 77808B3F5; Sat, 10 Mar 2007 01:32:48 +0900 (JST)
Date:	Sat, 10 Mar 2007 01:32:48 +0900 (JST)
Message-Id: <20070310.013248.45177878.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Cleanup FPU ownership management (alternative version)
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
X-archive-position: 14408
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Currently preempt_disable/preempt_enable are scattered in FPU
ownership management code.  This patch makes own_fpu() and lost_fpu()
can save/restore FPU context in itself and make these functions (and
init_fpu() too) preempt-proof.  This makes the FPU management codes
much readable.  Also this patch introduce raw_cpu_has_fpu macro which
is to be used if the caller did not need atomic context.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
This is an update of:
http://www.linux-mips.org/archives/linux-mips/2006-11/msg00128.html

This patch depends on:
> Subject: [PATCH] do_fpe() cleanup
> Message-Id: <20070310.010745.07456268.anemo@mba.ocn.ne.jp>
> Subject: [PATCH] Allow CpU exception in kernel partially
> Message-Id: <20070310.012811.108982622.anemo@mba.ocn.ne.jp>

 arch/mips/kernel/signal.c       |   16 +++-------------
 arch/mips/kernel/signal32.c     |   17 +++--------------
 arch/mips/kernel/traps.c        |   33 ++++++++-------------------------
 include/asm-mips/cpu-features.h |    3 +++
 include/asm-mips/cpu-info.h     |    1 +
 include/asm-mips/fpu.h          |   30 +++++++++++++++++++++++-------
 6 files changed, 41 insertions(+), 59 deletions(-)

diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index c4ef270..4c1849b 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -111,13 +111,7 @@ int setup_sigcontext(struct pt_regs *reg
 		 * Save FPU state to signal context. Signal handler
 		 * will "inherit" current FPU state.
 		 */
-		preempt_disable();
-
-		if (!is_fpu_owner()) {
-			own_fpu();
-			restore_fp(current);
-		}
-
+		own_fpu(1);
 		preempt_enable();
 		enable_fp_in_kernel();
 		err |= save_fp_context(sc);
@@ -190,20 +184,16 @@ int restore_sigcontext(struct pt_regs *r
 	err |= __get_user(used_math, &sc->sc_used_math);
 	conditional_used_math(used_math);
 
-	preempt_disable();
-
 	if (used_math()) {
 		/* restore fpu context if we have used it before */
-		own_fpu();
-		preempt_enable();
+		own_fpu(0);
 		enable_fp_in_kernel();
 		if (!err)
 			err = check_and_restore_fp_context(sc);
 		disable_fp_in_kernel();
 	} else {
 		/* signal handler may have used FPU.  Give it up. */
-		lose_fpu();
-		preempt_enable();
+		lose_fpu(0);
 	}
 
 	return err;
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index cf5bbe0..c90c8cf 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -207,14 +207,7 @@ static int setup_sigcontext32(struct pt_
 		 * Save FPU state to signal context.  Signal handler
 		 * will "inherit" current FPU state.
 		 */
-		preempt_disable();
-
-		if (!is_fpu_owner()) {
-			own_fpu();
-			restore_fp(current);
-		}
-
-		preempt_enable();
+		own_fpu(1);
 		enable_fp_in_kernel();
 		err |= save_fp_context32(sc);
 		disable_fp_in_kernel();
@@ -264,20 +257,16 @@ static int restore_sigcontext32(struct p
 	err |= __get_user(used_math, &sc->sc_used_math);
 	conditional_used_math(used_math);
 
-	preempt_disable();
-
 	if (used_math()) {
 		/* restore fpu context if we have used it before */
-		own_fpu();
-		preempt_enable();
+		own_fpu(0);
 		enable_fp_in_kernel();
 		if (!err)
 			err = check_and_restore_fp_context32(sc);
 		disable_fp_in_kernel();
 	} else {
 		/* signal handler may have used FPU.  Give it up. */
-		lose_fpu();
-		preempt_enable();
+		lose_fpu(0);
 	}
 
 	return err;
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 2aaf76b..31c897b 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -620,15 +620,8 @@ asmlinkage void do_fpe(struct pt_regs *r
 		 * register operands before invoking the emulator, which seems
 		 * a bit extreme for what should be an infrequent event.
 		 */
-		preempt_disable();
-
-		/* We might have lost fpu before disabling preempt... */
-		if (is_fpu_owner())
-			save_fp(current);
 		/* Ensure 'resume' not overwrite saved fp context again. */
-		lose_fpu();
-
-		preempt_enable();
+		lose_fpu(1);
 
 		/* Run the emulator */
 		sig = fpu_emulator_cop1Handler (regs, &current->thread.fpu, 1);
@@ -639,13 +632,8 @@ asmlinkage void do_fpe(struct pt_regs *r
 		 */
 		current->thread.fpu.fcr31 &= ~FPU_CSR_ALL_X;
 
-		preempt_disable();
-
-		own_fpu();	/* Using the FPU again.  */
 		/* Restore the hardware register state */
-		restore_fp(current);
-
-		preempt_enable();
+		own_fpu(1);	/* Using the FPU again.  */
 
 		/* If something went wrong, signal */
 		if (sig)
@@ -787,18 +775,14 @@ asmlinkage void do_cpu(struct pt_regs *r
 		if (!test_thread_flag(TIF_ALLOW_FP_IN_KERNEL))
 			die_if_kernel("do_cpu invoked from kernel context!",
 				      regs);
-		preempt_disable();
-
-		own_fpu();
-		if (used_math()) {	/* Using the FPU again.  */
-			restore_fp(current);
-		} else {			/* First time FPU user.  */
+		if (used_math())	/* Using the FPU again.  */
+			own_fpu(1);
+		else {			/* First time FPU user.  */
 			init_fpu();
 			set_used_math();
 		}
 
-		if (cpu_has_fpu) {
-			preempt_enable();
+		if (raw_cpu_has_fpu) {
 			if (test_thread_flag(TIF_ALLOW_FP_IN_KERNEL)) {
 				local_irq_disable();
 				if (cpu_has_fpu)
@@ -812,7 +796,6 @@ asmlinkage void do_cpu(struct pt_regs *r
 			}
 		} else {
 			int sig;
-			preempt_enable();
 			sig = fpu_emulator_cop1Handler(regs,
 						&current->thread.fpu, 0);
 			if (sig)
@@ -1278,14 +1261,14 @@ extern asmlinkage int fpu_emulator_resto
 #ifdef CONFIG_SMP
 static int smp_save_fp_context(struct sigcontext *sc)
 {
-	return cpu_has_fpu
+	return raw_cpu_has_fpu
 	       ? _save_fp_context(sc)
 	       : fpu_emulator_save_context(sc);
 }
 
 static int smp_restore_fp_context(struct sigcontext *sc)
 {
-	return cpu_has_fpu
+	return raw_cpu_has_fpu
 	       ? _restore_fp_context(sc)
 	       : fpu_emulator_restore_context(sc);
 }
diff --git a/include/asm-mips/cpu-features.h b/include/asm-mips/cpu-features.h
index eadca26..5e4bed1 100644
--- a/include/asm-mips/cpu-features.h
+++ b/include/asm-mips/cpu-features.h
@@ -40,6 +40,9 @@
 #endif
 #ifndef cpu_has_fpu
 #define cpu_has_fpu		(current_cpu_data.options & MIPS_CPU_FPU)
+#define raw_cpu_has_fpu		(raw_current_cpu_data.options & MIPS_CPU_FPU)
+#else
+#define raw_cpu_has_fpu		cpu_has_fpu
 #endif
 #ifndef cpu_has_32fpr
 #define cpu_has_32fpr		(cpu_data[0].options & MIPS_CPU_32FPR)
diff --git a/include/asm-mips/cpu-info.h b/include/asm-mips/cpu-info.h
index 610d0cd..22fe845 100644
--- a/include/asm-mips/cpu-info.h
+++ b/include/asm-mips/cpu-info.h
@@ -87,6 +87,7 @@ struct cpuinfo_mips {
 
 extern struct cpuinfo_mips cpu_data[];
 #define current_cpu_data cpu_data[smp_processor_id()]
+#define raw_current_cpu_data cpu_data[raw_smp_processor_id()]
 
 extern void cpu_probe(void);
 extern void cpu_report(void);
diff --git a/include/asm-mips/fpu.h b/include/asm-mips/fpu.h
index 40536a2..dfecb7b 100644
--- a/include/asm-mips/fpu.h
+++ b/include/asm-mips/fpu.h
@@ -95,31 +95,47 @@ static inline int is_fpu_owner(void)
 	return cpu_has_fpu && __is_fpu_owner();
 }
 
-static inline void own_fpu(void)
+static inline void __own_fpu(void)
 {
-	if (cpu_has_fpu) {
-		__enable_fpu();
-		KSTK_STATUS(current) |= ST0_CU1;
-		set_thread_flag(TIF_USEDFPU);
+	__enable_fpu();
+	KSTK_STATUS(current) |= ST0_CU1;
+	set_thread_flag(TIF_USEDFPU);
+}
+
+static inline void own_fpu(int restore)
+{
+	preempt_disable();
+	if (cpu_has_fpu && !__is_fpu_owner()) {
+		__own_fpu();
+		if (restore)
+			_restore_fp(current);
 	}
+	preempt_enable();
 }
 
-static inline void lose_fpu(void)
+static inline void lose_fpu(int save)
 {
-	if (cpu_has_fpu) {
+	preempt_disable();
+	if (is_fpu_owner()) {
+		if (save)
+			_save_fp(current);
 		KSTK_STATUS(current) &= ~ST0_CU1;
 		clear_thread_flag(TIF_USEDFPU);
 		__disable_fpu();
 	}
+	preempt_enable();
 }
 
 static inline void init_fpu(void)
 {
+	preempt_disable();
 	if (cpu_has_fpu) {
+		__own_fpu();
 		_init_fpu();
 	} else {
 		fpu_emulator_init_fpu();
 	}
+	preempt_enable();
 }
 
 static inline void save_fp(struct task_struct *tsk)
