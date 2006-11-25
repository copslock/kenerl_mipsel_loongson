Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Nov 2006 16:04:51 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:55260 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20039419AbWKYQEq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 25 Nov 2006 16:04:46 +0000
Received: from localhost (p1028-ipad201funabasi.chiba.ocn.ne.jp [222.146.64.28])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 4CCA8BA66; Sun, 26 Nov 2006 01:04:39 +0900 (JST)
Date:	Sun, 26 Nov 2006 01:07:23 +0900 (JST)
Message-Id: <20061126.010723.108305134.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [PATCH 0/3] fix and cleanup FPU ownership management
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20061125.000334.75185150.anemo@mba.ocn.ne.jp>
References: <20061125.000334.75185150.anemo@mba.ocn.ne.jp>
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
X-archive-position: 13257
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 25 Nov 2006 00:03:34 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> The first patch ("do_fpe() cleanup") is just a cleanup to preparation.
> 
> The second patch ("Allow CpU exception in kernel partially") is main
> part.  This is an alternative of the patch posted before:
> http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=20060829.225631.41630441.anemo%40mba.ocn.ne.jp
> 
> The third patch ("Cleanup FPU ownership management") is an another
> cleanup and get rid of most preempt_disable()/preempt_enable() pairs
> around.

As the second patch shows, enabling CpU exception in kernel is
somewhat tricky and fragile (and add an additional instruction in
resume() code).

I still think the other one (a patch titled "rewrite
restore_fp_context/save_fp_context") might be better.  It is simple
and does not add additional overhead for most cases, I suppose.

If you took the other one, the first patch in this patchset is still
can be applied too as is, and some part of the third patch is still
useful.  Here is an alternative of the third patch which can be used
with the "rewrite restore_fp_context/save_fp_context" patch.


Subject: Cleanup FPU ownership management

Currently preempt_disable/preempt_enable are scattered in FPU
ownership management code.  This patch makes own_fpu() and lost_fpu()
can save/restore FPU context in itself and make these functions (and
init_fpu() too) preempt-proof.  This makes the FPU management codes
much readable.  Also this patch introduce raw_cpu_has_fpu macro which
is to be used if the caller did not need atomic context.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/kernel/signal-common.h |   13 ++-----------
 arch/mips/kernel/signal32.c      |   13 ++-----------
 arch/mips/kernel/traps.c         |   26 ++++----------------------
 include/asm-mips/cpu-features.h  |    3 +++
 include/asm-mips/cpu-info.h      |    1 +
 include/asm-mips/fpu.h           |   25 ++++++++++++++++++++-----
 6 files changed, 32 insertions(+), 49 deletions(-)

diff --git a/arch/mips/kernel/signal-common.h b/arch/mips/kernel/signal-common.h
index 5c431fb..d033027 100644
--- a/arch/mips/kernel/signal-common.h
+++ b/arch/mips/kernel/signal-common.h
@@ -85,14 +85,7 @@ #undef save_gp_reg
 	 * Save FPU state to signal context.  Signal handler will "inherit"
 	 * current FPU state.
 	 */
-	preempt_disable();
-	if (is_fpu_owner()) {
-		/* save current context to task_struct */
-		save_fp(current);
-		lose_fpu();
-	}
-	preempt_enable();
-
+	lose_fpu(1);
 	err |= save_fp_context(sc);
 out:
 	return err;
@@ -141,9 +134,7 @@ #undef restore_gp_reg
 	conditional_used_math(used_math);
 
 	/* signal handler may have used FPU.  Give it up. */
-	preempt_disable();
-	lose_fpu();
-	preempt_enable();
+	lose_fpu(0);
 
 	if (used_math()) {
 		/* restore fpu context if we have used it before */
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index 30f5f0f..1ca9223 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -400,9 +400,7 @@ #undef restore_gp_reg
 	conditional_used_math(used_math);
 
 	/* signal handler may have used FPU.  Give it up. */
-	preempt_disable();
-	lose_fpu();
-	preempt_enable();
+	lose_fpu(0);
 
 	if (used_math()) {
 		/* restore fpu context if we have used it before */
@@ -626,14 +624,7 @@ #undef save_gp_reg
 	 * Save FPU state to signal context.  Signal handler will "inherit"
 	 * current FPU state.
 	 */
-	preempt_disable();
-	if (is_fpu_owner()) {
-		/* save current context to task_struct */
-		save_fp(current);
-		lose_fpu();
-	}
-	preempt_enable();
-
+	lose_fpu(1);
 	err |= save_fp_context32(sc);
 out:
 	return err;
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 886ed13..03b80da 100644
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
+		own_fpu();	/* Using the FPU again.  */
 
 		/* If something went wrong, signal */
 		if (sig)
@@ -775,21 +763,15 @@ asmlinkage void do_cpu(struct pt_regs *r
 		break;
 
 	case 1:
-		preempt_disable();
-
-		own_fpu();
 		if (used_math()) {	/* Using the FPU again.  */
-			restore_fp(current);
+			own_fpu();
 		} else {			/* First time FPU user.  */
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
