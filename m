Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 12:42:37 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:59274 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006608AbbEVKmfVtbX7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2015 12:42:35 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 48803EE604C69;
        Fri, 22 May 2015 11:42:29 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 22 May 2015 11:42:31 +0100
Received: from localhost (192.168.159.131) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 22 May
 2015 11:42:30 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        <linux-kernel@vger.kernel.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        David Daney <david.daney@cavium.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH v2] MIPS: tidy up FPU context switching
Date:   Fri, 22 May 2015 11:42:12 +0100
Message-ID: <1432291332-16966-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.4.1
In-Reply-To: <1432225242-12470-1-git-send-email-paul.burton@imgtec.com>
References: <1432225242-12470-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.131]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47551
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Rather than saving the scalar FP or vector context in the assembly
resume function, reuse the existing C code we have in fpu.h to do
exactly that. This reduces duplication, results in a much easier to read
resume function & should allow the compiler to optimise out more MSA
code due to is_msa_enabled()/cpu_has_msa being known-zero at compile
time for kernels without MSA support.

As a side effect this correctly disables MSA on the first entry to a
task, in which case resume will "return" to ret_from_kernel_thread or
ret_from_fork in order to call schedule_tail. This would lead to the
disable_msa call in switch_to not being executed, as reported by Leonid.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Reported-by: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
---
How about this (lightly tested for the moment) alternative to 10082?

Changes in v2:
- Introduce lose_fpu_inatomic to skip the preempt_{en,dis}able calls
  and operate on the provided struct task_struct, which should be prev
  rather than current.

 arch/mips/include/asm/fpu.h       | 21 ++++++++++++--------
 arch/mips/include/asm/switch_to.h | 21 ++++----------------
 arch/mips/kernel/r4k_switch.S     | 41 +--------------------------------------
 3 files changed, 18 insertions(+), 65 deletions(-)

diff --git a/arch/mips/include/asm/fpu.h b/arch/mips/include/asm/fpu.h
index 084780b..87e8c78 100644
--- a/arch/mips/include/asm/fpu.h
+++ b/arch/mips/include/asm/fpu.h
@@ -164,25 +164,30 @@ static inline int own_fpu(int restore)
 	return ret;
 }
 
-static inline void lose_fpu(int save)
+static inline void lose_fpu_inatomic(int save, struct task_struct *tsk)
 {
-	preempt_disable();
 	if (is_msa_enabled()) {
 		if (save) {
-			save_msa(current);
-			current->thread.fpu.fcr31 =
+			save_msa(tsk);
+			tsk->thread.fpu.fcr31 =
 					read_32bit_cp1_register(CP1_STATUS);
 		}
 		disable_msa();
-		clear_thread_flag(TIF_USEDMSA);
+		clear_tsk_thread_flag(tsk, TIF_USEDMSA);
 		__disable_fpu();
 	} else if (is_fpu_owner()) {
 		if (save)
-			_save_fp(current);
+			_save_fp(tsk);
 		__disable_fpu();
 	}
-	KSTK_STATUS(current) &= ~ST0_CU1;
-	clear_thread_flag(TIF_USEDFPU);
+	KSTK_STATUS(tsk) &= ~ST0_CU1;
+	clear_tsk_thread_flag(tsk, TIF_USEDFPU);
+}
+
+static inline void lose_fpu(int save)
+{
+	preempt_disable();
+	lose_fpu_inatomic(save, current);
 	preempt_enable();
 }
 
diff --git a/arch/mips/include/asm/switch_to.h b/arch/mips/include/asm/switch_to.h
index e92d6c4b..c429d1a 100644
--- a/arch/mips/include/asm/switch_to.h
+++ b/arch/mips/include/asm/switch_to.h
@@ -16,29 +16,21 @@
 #include <asm/watch.h>
 #include <asm/dsp.h>
 #include <asm/cop2.h>
-#include <asm/msa.h>
+#include <asm/fpu.h>
 
 struct task_struct;
 
-enum {
-	FP_SAVE_NONE	= 0,
-	FP_SAVE_VECTOR	= -1,
-	FP_SAVE_SCALAR	= 1,
-};
-
 /**
  * resume - resume execution of a task
  * @prev:	The task previously executed.
  * @next:	The task to begin executing.
  * @next_ti:	task_thread_info(next).
- * @fp_save:	Which, if any, FP context to save for prev.
  *
  * This function is used whilst scheduling to save the context of prev & load
  * the context of next. Returns prev.
  */
 extern asmlinkage struct task_struct *resume(struct task_struct *prev,
-		struct task_struct *next, struct thread_info *next_ti,
-		s32 fp_save);
+		struct task_struct *next, struct thread_info *next_ti);
 
 extern unsigned int ll_bit;
 extern struct task_struct *ll_task;
@@ -86,8 +78,8 @@ do {	if (cpu_has_rw_llb) {						\
 #define switch_to(prev, next, last)					\
 do {									\
 	u32 __c0_stat;							\
-	s32 __fpsave = FP_SAVE_NONE;					\
 	__mips_mt_fpaff_switch_to(prev);				\
+	lose_fpu_inatomic(1, prev);					\
 	if (cpu_has_dsp)						\
 		__save_dsp(prev);					\
 	if (cop2_present && (KSTK_STATUS(prev) & ST0_CU2)) {		\
@@ -99,12 +91,7 @@ do {									\
 		write_c0_status(__c0_stat & ~ST0_CU2);			\
 	}								\
 	__clear_software_ll_bit();					\
-	if (test_and_clear_tsk_thread_flag(prev, TIF_USEDFPU))		\
-		__fpsave = FP_SAVE_SCALAR;				\
-	if (test_and_clear_tsk_thread_flag(prev, TIF_USEDMSA))		\
-		__fpsave = FP_SAVE_VECTOR;				\
-	(last) = resume(prev, next, task_thread_info(next), __fpsave);	\
-	disable_msa();							\
+	(last) = resume(prev, next, task_thread_info(next));		\
 } while (0)
 
 #define finish_arch_switch(prev)					\
diff --git a/arch/mips/kernel/r4k_switch.S b/arch/mips/kernel/r4k_switch.S
index 04cbbde3..92cd051 100644
--- a/arch/mips/kernel/r4k_switch.S
+++ b/arch/mips/kernel/r4k_switch.S
@@ -34,7 +34,7 @@
 #ifndef USE_ALTERNATE_RESUME_IMPL
 /*
  * task_struct *resume(task_struct *prev, task_struct *next,
- *		       struct thread_info *next_ti, s32 fp_save)
+ *		       struct thread_info *next_ti)
  */
 	.align	5
 	LEAF(resume)
@@ -43,45 +43,6 @@
 	cpu_save_nonscratch a0
 	LONG_S	ra, THREAD_REG31(a0)
 
-	/*
-	 * Check whether we need to save any FP context. FP context is saved
-	 * iff the process has used the context with the scalar FPU or the MSA
-	 * ASE in the current time slice, as indicated by _TIF_USEDFPU and
-	 * _TIF_USEDMSA respectively. switch_to will have set fp_save
-	 * accordingly to an FP_SAVE_ enum value.
-	 */
-	beqz	a3, 2f
-
-	/*
-	 * We do. Clear the saved CU1 bit for prev, such that next time it is
-	 * scheduled it will start in userland with the FPU disabled. If the
-	 * task uses the FPU then it will be enabled again via the do_cpu trap.
-	 * This allows us to lazily restore the FP context.
-	 */
-	PTR_L	t3, TASK_THREAD_INFO(a0)
-	LONG_L	t0, ST_OFF(t3)
-	li	t1, ~ST0_CU1
-	and	t0, t0, t1
-	LONG_S	t0, ST_OFF(t3)
-
-	/* Check whether we're saving scalar or vector context. */
-	bgtz	a3, 1f
-
-	/* Save 128b MSA vector context + scalar FP control & status. */
-	.set push
-	SET_HARDFLOAT
-	cfc1	t1, fcr31
-	msa_save_all	a0
-	.set pop	/* SET_HARDFLOAT */
-
-	sw	t1, THREAD_FCR31(a0)
-	b	2f
-
-1:	/* Save 32b/64b scalar FP context. */
-	fpu_save_double a0 t0 t1		# c0_status passed in t0
-						# clobbers t1
-2:
-
 #if defined(CONFIG_CC_STACKPROTECTOR) && !defined(CONFIG_SMP)
 	PTR_LA	t8, __stack_chk_guard
 	LONG_L	t9, TASK_STACK_CANARY(a1)
-- 
2.4.1
