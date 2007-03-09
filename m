Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Mar 2007 16:24:44 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.175.29]:8153 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021493AbXCIQYj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 9 Mar 2007 16:24:39 +0000
Received: from localhost (p4160-ipad211funabasi.chiba.ocn.ne.jp [58.91.160.160])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 6B7B9BB60; Sat, 10 Mar 2007 01:23:19 +0900 (JST)
Date:	Sat, 10 Mar 2007 01:23:19 +0900 (JST)
Message-Id: <20070310.012319.52129805.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Cleanup FPU ownership management
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
X-archive-position: 14406
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
http://www.linux-mips.org/archives/linux-mips/2006-11/msg00130.html

This patch depends on:
> Subject: [PATCH] do_fpe() cleanup
> Message-Id: <20070310.010745.07456268.anemo@mba.ocn.ne.jp>
> Subject: [PATCH] rewrite restore_fp_context/save_fp_context
> Message-Id: <20070310.011845.85420915.anemo@mba.ocn.ne.jp>

 arch/mips/kernel/signal.c       |   12 ++----------
 arch/mips/kernel/signal32.c     |   12 ++----------
 arch/mips/kernel/traps.c        |   30 ++++++------------------------
 include/asm-mips/cpu-features.h |    3 +++
 include/asm-mips/cpu-info.h     |    1 +
 include/asm-mips/fpu.h          |   25 ++++++++++++++++++++-----
 6 files changed, 34 insertions(+), 49 deletions(-)

diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index d2e6c50..ce00a50 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -143,13 +143,7 @@ int setup_sigcontext(struct pt_regs *reg
 		 * Save FPU state to signal context. Signal handler
 		 * will "inherit" current FPU state.
 		 */
-		preempt_disable();
-		if (is_fpu_owner()) {
-			/* save current context to task_struct */
-			save_fp(current);
-			lose_fpu();
-		}
-		preempt_enable();
+		lose_fpu(1);
 		err |= save_fp_context(sc);
 	}
 	return err;
@@ -220,9 +214,7 @@ int restore_sigcontext(struct pt_regs *r
 	conditional_used_math(used_math);
 
 	/* signal handler may have used FPU.  Give it up. */
-	preempt_disable();
-	lose_fpu();
-	preempt_enable();
+	lose_fpu(0);
 
 	if (used_math()) {
 		/* restore fpu context if we have used it before */
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index f966fc4..3557f17 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -231,13 +231,7 @@ static int setup_sigcontext32(struct pt_
 		 * Save FPU state to signal context.  Signal handler
 		 * will "inherit" current FPU state.
 		 */
-		preempt_disable();
-		if (is_fpu_owner()) {
-			/* save current context to task_struct */
-			save_fp(current);
-			lose_fpu();
-		}
-		preempt_enable();
+		lose_fpu(1);
 		err |= save_fp_context32(sc);
 	}
 	return err;
@@ -286,9 +280,7 @@ static int restore_sigcontext32(struct p
 	conditional_used_math(used_math);
 
 	/* signal handler may have used FPU.  Give it up. */
-	preempt_disable();
-	lose_fpu();
-	preempt_enable();
+	lose_fpu(0);
 
 	if (used_math()) {
 		/* restore fpu context if we have used it before */
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 0873834..441b9a9 100644
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
+		own_fpu();	/* Using the FPU again.  */
 
 		/* If something went wrong, signal */
 		if (sig)
@@ -785,21 +773,15 @@ asmlinkage void do_cpu(struct pt_regs *r
 		break;
 
 	case 1:
-		preempt_disable();
-
-		own_fpu();
-		if (used_math()) {	/* Using the FPU again.  */
-			restore_fp(current);
-		} else {			/* First time FPU user.  */
+		if (used_math())	/* Using the FPU again.  */
+			own_fpu();
+		else {			/* First time FPU user.  */
 			init_fpu();
 			set_used_math();
 		}
 
-		if (cpu_has_fpu) {
-			preempt_enable();
-		} else {
+		if (!raw_cpu_has_fpu) {
 			int sig;
-			preempt_enable();
 			sig = fpu_emulator_cop1Handler(regs,
 						&current->thread.fpu, 0);
 			if (sig)
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
index 979839c..538dabc 100644
--- a/include/asm-mips/fpu.h
+++ b/include/asm-mips/fpu.h
@@ -84,31 +84,46 @@ static inline int is_fpu_owner(void)
 	return cpu_has_fpu && __is_fpu_owner();
 }
 
+static inline void __own_fpu(void)
+{
+	__enable_fpu();
+	KSTK_STATUS(current) |= ST0_CU1;
+	set_thread_flag(TIF_USEDFPU);
+}
+
 static inline void own_fpu(void)
 {
+	preempt_disable();
 	if (cpu_has_fpu) {
-		__enable_fpu();
-		KSTK_STATUS(current) |= ST0_CU1;
-		set_thread_flag(TIF_USEDFPU);
+		__own_fpu();
+		_restore_fp(current);
 	}
+	preempt_enable();
 }
 
-static inline void lose_fpu(void)
+static inline void lose_fpu(int save)
 {
-	if (cpu_has_fpu) {
+	preempt_disable();
+	if (cpu_has_fpu && __is_fpu_owner()) {
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
