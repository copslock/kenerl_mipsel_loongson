Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Nov 2006 15:02:24 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:20418 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038617AbWKXPBk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Nov 2006 15:01:40 +0000
Received: from localhost (p6014-ipad01funabasi.chiba.ocn.ne.jp [61.207.80.14])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 8AAF2B980; Sat, 25 Nov 2006 00:01:36 +0900 (JST)
Date:	Sat, 25 Nov 2006 00:04:20 +0900 (JST)
Message-Id: <20061125.000420.78705565.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 3/3] Cleanup FPU ownership management
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
X-archive-position: 13255
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
 arch/mips/kernel/signal-common.h |   17 +++--------------
 arch/mips/kernel/signal32.c      |   17 +++--------------
 arch/mips/kernel/traps.c         |   29 ++++++-----------------------
 include/asm-mips/cpu-features.h  |    3 +++
 include/asm-mips/cpu-info.h      |    1 +
 include/asm-mips/fpu.h           |   30 +++++++++++++++++++++++-------
 6 files changed, 39 insertions(+), 58 deletions(-)

diff --git a/arch/mips/kernel/signal-common.h b/arch/mips/kernel/signal-common.h
index b9051a0..2e077bc 100644
--- a/arch/mips/kernel/signal-common.h
+++ b/arch/mips/kernel/signal-common.h
@@ -51,14 +51,7 @@ #undef save_gp_reg
 	 * Save FPU state to signal context.  Signal handler will "inherit"
 	 * current FPU state.
 	 */
-	preempt_disable();
-
-	if (!is_fpu_owner()) {
-		own_fpu();
-		restore_fp(current);
-	}
-
-	preempt_enable();
+	own_fpu(1);
 	enable_fp_in_kernel();
 	err |= save_fp_context(sc);
 	disable_fp_in_kernel();
@@ -109,19 +102,15 @@ #undef restore_gp_reg
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
 		err |= restore_fp_context(sc);
 		disable_fp_in_kernel();
 	} else {
 		/* signal handler may have used FPU.  Give it up. */
-		lose_fpu();
-		preempt_enable();
+		lose_fpu(0);
 	}
 
 	return err;
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index 4d291b5..aab37e6 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -367,19 +367,15 @@ #undef restore_gp_reg
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
 		err |= restore_fp_context32(sc);
 		disable_fp_in_kernel();
 	} else {
 		/* signal handler may have used FPU.  Give it up. */
-		lose_fpu();
-		preempt_enable();
+		lose_fpu(0);
 	}
 
 	return err;
@@ -599,14 +595,7 @@ #undef save_gp_reg
 	 * Save FPU state to signal context.  Signal handler will "inherit"
 	 * current FPU state.
 	 */
-	preempt_disable();
-
-	if (!is_fpu_owner()) {
-		own_fpu();
-		restore_fp(current);
-	}
-
-	preempt_enable();
+	own_fpu(1);
 	enable_fp_in_kernel();
 	err |= save_fp_context32(sc);
 	disable_fp_in_kernel();
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 182646d..ab94113 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -624,15 +624,8 @@ asmlinkage void do_fpe(struct pt_regs *r
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
@@ -643,13 +636,8 @@ asmlinkage void do_fpe(struct pt_regs *r
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
@@ -777,18 +765,14 @@ asmlinkage void do_cpu(struct pt_regs *r
 		if (!test_thread_flag(TIF_ALLOW_FP_IN_KERNEL))
 			die_if_kernel("do_cpu invoked from kernel context!",
 				      regs);
-		preempt_disable();
-
-		own_fpu();
 		if (used_math()) {	/* Using the FPU again.  */
-			restore_fp(current);
+			own_fpu(1);
 		} else {			/* First time FPU user.  */
 			init_fpu();
 			set_used_math();
 		}
 
-		if (cpu_has_fpu) {
-			preempt_enable();
+		if (raw_cpu_has_fpu) {
 			if (test_thread_flag(TIF_ALLOW_FP_IN_KERNEL)) {
 				local_irq_disable();
 				if (cpu_has_fpu)
@@ -802,7 +786,6 @@ asmlinkage void do_cpu(struct pt_regs *r
 			}
 		} else {
 			int sig;
-			preempt_enable();
 			sig = fpu_emulator_cop1Handler(regs,
 						&current->thread.fpu, 0);
 			if (sig)
@@ -1268,14 +1251,14 @@ extern asmlinkage int fpu_emulator_resto
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
@@ -40,6 +40,9 @@ #define cpu_has_sb1_cache	(cpu_data[0].o
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
index a2f0c8e..6250da5 100644
--- a/include/asm-mips/cpu-info.h
+++ b/include/asm-mips/cpu-info.h
@@ -87,6 +87,7 @@ #endif /* CONFIG_MIPS_MT */
 
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
