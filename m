Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 16:29:34 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:4490 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824805AbaA0P2rM-9Mn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 16:28:47 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 12/15] mips: basic MSA context switching support
Date:   Mon, 27 Jan 2014 15:23:11 +0000
Message-ID: <1390836194-26286-13-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1390836194-26286-1-git-send-email-paul.burton@imgtec.com>
References: <1390836194-26286-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2014_01_27_15_28_42
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39106
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

This patch adds support for context switching the MSA vector registers.
These 128 bit vector registers are aliased with the FP registers - an
FP register accesses the least significant bits of the vector register
with which it is aliased (ie. the register with the same index). Due to
both this & the requirement that the scalar FPU must be 64-bit (FR=1) if
enabled at the same time as MSA the kernel will enable MSA & scalar FP
at the same time for tasks which use MSA. If we restore the MSA vector
context then we might as well enable the scalar FPU since the reason it
was left disabled was to allow for lazy FP context restoring - but we
just restored the FP context as it's a subset of the vector context. If
we restore the FP context and have previously used MSA then we have to
restore the whole vector context anyway (see comment in
enable_restore_fp_context for details) so similarly we might as well
enable MSA.

Thus if a task does not use MSA then it will continue to behave as
without this patch - the scalar FP context will be saved & restored as
usual. But if a task executes an MSA instruction then it will save &
restore the vector context forever more.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/Kconfig                   |   9 ++--
 arch/mips/include/asm/asmmacro.h    |  70 +++++++++++++++++++++++++
 arch/mips/include/asm/msa.h         |  28 ++++++++++
 arch/mips/include/asm/processor.h   |   9 +++-
 arch/mips/include/asm/switch_to.h   |  22 ++++++--
 arch/mips/include/asm/thread_info.h |   4 ++
 arch/mips/kernel/genex.S            |   1 +
 arch/mips/kernel/process.c          |   7 ++-
 arch/mips/kernel/r4k_switch.S       |  58 +++++++++++++++------
 arch/mips/kernel/traps.c            | 101 +++++++++++++++++++++++++++++++++---
 10 files changed, 275 insertions(+), 34 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index bb08f1a..6f78eb3 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2054,10 +2054,11 @@ config CPU_HAS_MSA
 	help
 	  MIPS SIMD Architecture (MSA) introduces 128 bit wide vector registers
 	  and a set of SIMD instructions to operate on them. When this option
-	  is enabled the kernel will support detection of the MSA ASE. If you
-	  know that your kernel will only be running on CPUs which do not
-	  support MSA then you may wish to say N here to reduce the size of
-	  your kernel.
+	  is enabled the kernel will support allocating & switching MSA
+	  vector register contexts. If you know that your kernel will only be
+	  running on CPUs which do not support MSA or that your userland will
+	  not be making use of it then you may wish to say N here to reduce
+	  the size & complexity of your kernel.
 
 	  If unsure, say Y.
 
diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
index c759501..c087963 100644
--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -317,4 +317,74 @@
 	.endm
 #endif
 
+	.macro	msa_save_all	thread
+	st_d	0, THREAD_FPR0, \thread
+	st_d	1, THREAD_FPR1, \thread
+	st_d	2, THREAD_FPR2, \thread
+	st_d	3, THREAD_FPR3, \thread
+	st_d	4, THREAD_FPR4, \thread
+	st_d	5, THREAD_FPR5, \thread
+	st_d	6, THREAD_FPR6, \thread
+	st_d	7, THREAD_FPR7, \thread
+	st_d	8, THREAD_FPR8, \thread
+	st_d	9, THREAD_FPR9, \thread
+	st_d	10, THREAD_FPR10, \thread
+	st_d	11, THREAD_FPR11, \thread
+	st_d	12, THREAD_FPR12, \thread
+	st_d	13, THREAD_FPR13, \thread
+	st_d	14, THREAD_FPR14, \thread
+	st_d	15, THREAD_FPR15, \thread
+	st_d	16, THREAD_FPR16, \thread
+	st_d	17, THREAD_FPR17, \thread
+	st_d	18, THREAD_FPR18, \thread
+	st_d	19, THREAD_FPR19, \thread
+	st_d	20, THREAD_FPR20, \thread
+	st_d	21, THREAD_FPR21, \thread
+	st_d	22, THREAD_FPR22, \thread
+	st_d	23, THREAD_FPR23, \thread
+	st_d	24, THREAD_FPR24, \thread
+	st_d	25, THREAD_FPR25, \thread
+	st_d	26, THREAD_FPR26, \thread
+	st_d	27, THREAD_FPR27, \thread
+	st_d	28, THREAD_FPR28, \thread
+	st_d	29, THREAD_FPR29, \thread
+	st_d	30, THREAD_FPR30, \thread
+	st_d	31, THREAD_FPR31, \thread
+	.endm
+
+	.macro	msa_restore_all	thread
+	ld_d	0, THREAD_FPR0, \thread
+	ld_d	1, THREAD_FPR1, \thread
+	ld_d	2, THREAD_FPR2, \thread
+	ld_d	3, THREAD_FPR3, \thread
+	ld_d	4, THREAD_FPR4, \thread
+	ld_d	5, THREAD_FPR5, \thread
+	ld_d	6, THREAD_FPR6, \thread
+	ld_d	7, THREAD_FPR7, \thread
+	ld_d	8, THREAD_FPR8, \thread
+	ld_d	9, THREAD_FPR9, \thread
+	ld_d	10, THREAD_FPR10, \thread
+	ld_d	11, THREAD_FPR11, \thread
+	ld_d	12, THREAD_FPR12, \thread
+	ld_d	13, THREAD_FPR13, \thread
+	ld_d	14, THREAD_FPR14, \thread
+	ld_d	15, THREAD_FPR15, \thread
+	ld_d	16, THREAD_FPR16, \thread
+	ld_d	17, THREAD_FPR17, \thread
+	ld_d	18, THREAD_FPR18, \thread
+	ld_d	19, THREAD_FPR19, \thread
+	ld_d	20, THREAD_FPR20, \thread
+	ld_d	21, THREAD_FPR21, \thread
+	ld_d	22, THREAD_FPR22, \thread
+	ld_d	23, THREAD_FPR23, \thread
+	ld_d	24, THREAD_FPR24, \thread
+	ld_d	25, THREAD_FPR25, \thread
+	ld_d	26, THREAD_FPR26, \thread
+	ld_d	27, THREAD_FPR27, \thread
+	ld_d	28, THREAD_FPR28, \thread
+	ld_d	29, THREAD_FPR29, \thread
+	ld_d	30, THREAD_FPR30, \thread
+	ld_d	31, THREAD_FPR31, \thread
+	.endm
+
 #endif /* _ASM_ASMMACRO_H */
diff --git a/arch/mips/include/asm/msa.h b/arch/mips/include/asm/msa.h
index a306ea8..d7fd8e1 100644
--- a/arch/mips/include/asm/msa.h
+++ b/arch/mips/include/asm/msa.h
@@ -12,6 +12,9 @@
 
 #include <asm/mipsregs.h>
 
+extern void _save_msa(struct task_struct *);
+extern void _restore_msa(struct task_struct *);
+
 static inline void enable_msa(void)
 {
 	if (cpu_has_msa)
@@ -32,6 +35,31 @@ static inline int is_msa_enabled(void)
 	return read_c0_config5() & MIPS_CONF5_MSAEN;
 }
 
+static inline int thread_msa_context_live(void)
+{
+	/*
+	 * Check cpu_has_msa only if it's a constant. This will allow the
+	 * compiler to optimise out code for CPUs without MSA without adding
+	 * an extra redundant check for CPUs with MSA.
+	 */
+	if (__builtin_constant_p(cpu_has_msa) && !cpu_has_msa)
+		return 0;
+
+	return test_thread_flag(TIF_MSA_CTX_LIVE);
+}
+
+static inline void save_msa(struct task_struct *t)
+{
+	if (cpu_has_msa)
+		_save_msa(t);
+}
+
+static inline void restore_msa(struct task_struct *t)
+{
+	if (cpu_has_msa)
+		_restore_msa(t);
+}
+
 #ifdef TOOLCHAIN_SUPPORTS_MSA
 
 #define __BUILD_MSA_CTL_REG(name, cs)				\
diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index 50cf4c3..ad70cba 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -96,7 +96,12 @@ extern unsigned int vced_count, vcei_count;
 
 
 #define NUM_FPU_REGS	32
-#define FPU_REG_WIDTH	64
+
+#ifdef CONFIG_CPU_HAS_MSA
+# define FPU_REG_WIDTH	128
+#else
+# define FPU_REG_WIDTH	64
+#endif
 
 union fpureg {
 	__u32	val32[FPU_REG_WIDTH / 32];
@@ -133,6 +138,7 @@ BUILD_FPR_ACCESS(64)
 struct mips_fpu_struct {
 	union fpureg	fpr[NUM_FPU_REGS];
 	unsigned int	fcr31;
+	unsigned int	msacsr;
 };
 
 #define NUM_DSP_REGS   6
@@ -310,6 +316,7 @@ struct thread_struct {
 	.fpu			= {				\
 		.fpr		= {{{0,},},},			\
 		.fcr31		= 0,				\
+		.msacsr		= 0,				\
 	},							\
 	/*							\
 	 * FPU affinity state (null if not FPAFF)		\
diff --git a/arch/mips/include/asm/switch_to.h b/arch/mips/include/asm/switch_to.h
index 278d45a..495c104 100644
--- a/arch/mips/include/asm/switch_to.h
+++ b/arch/mips/include/asm/switch_to.h
@@ -16,22 +16,29 @@
 #include <asm/watch.h>
 #include <asm/dsp.h>
 #include <asm/cop2.h>
+#include <asm/msa.h>
 
 struct task_struct;
 
+enum {
+	FP_SAVE_NONE	= 0,
+	FP_SAVE_VECTOR	= -1,
+	FP_SAVE_SCALAR	= 1,
+};
+
 /**
  * resume - resume execution of a task
  * @prev:	The task previously executed.
  * @next:	The task to begin executing.
  * @next_ti:	task_thread_info(next).
- * @usedfpu:	Non-zero if prev's FP context should be saved.
+ * @fp_save:	Which, if any, FP context to save for prev.
  *
  * This function is used whilst scheduling to save the context of prev & load
  * the context of next. Returns prev.
  */
 extern asmlinkage struct task_struct *resume(struct task_struct *prev,
 		struct task_struct *next, struct thread_info *next_ti,
-		u32 usedfpu);
+		s32 fp_save);
 
 extern unsigned int ll_bit;
 extern struct task_struct *ll_task;
@@ -75,7 +82,8 @@ do {									\
 
 #define switch_to(prev, next, last)					\
 do {									\
-	u32 __usedfpu, __c0_stat;					\
+	u32 __c0_stat;							\
+	s32 __fpsave = FP_SAVE_NONE;					\
 	__mips_mt_fpaff_switch_to(prev);				\
 	if (cpu_has_dsp)						\
 		__save_dsp(prev);					\
@@ -88,8 +96,12 @@ do {									\
 		write_c0_status(__c0_stat & ~ST0_CU2);			\
 	}								\
 	__clear_software_ll_bit();					\
-	__usedfpu = test_and_clear_tsk_thread_flag(prev, TIF_USEDFPU);	\
-	(last) = resume(prev, next, task_thread_info(next), __usedfpu); \
+	if (test_and_clear_tsk_thread_flag(prev, TIF_USEDFPU))		\
+		__fpsave = FP_SAVE_SCALAR;				\
+	if (test_and_clear_tsk_thread_flag(prev, TIF_USEDMSA))		\
+		__fpsave = FP_SAVE_VECTOR;				\
+	(last) = resume(prev, next, task_thread_info(next), __fpsave);	\
+	disable_msa();							\
 } while (0)
 
 #define finish_arch_switch(prev)					\
diff --git a/arch/mips/include/asm/thread_info.h b/arch/mips/include/asm/thread_info.h
index 24846f9..b18a4e2 100644
--- a/arch/mips/include/asm/thread_info.h
+++ b/arch/mips/include/asm/thread_info.h
@@ -116,6 +116,8 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_LOAD_WATCH		25	/* If set, load watch registers */
 #define TIF_SYSCALL_TRACEPOINT	26	/* syscall tracepoint instrumentation */
 #define TIF_32BIT_FPREGS	27	/* 32-bit floating point registers */
+#define TIF_USEDMSA		29	/* MSA has been used this quantum */
+#define TIF_MSA_CTX_LIVE	30	/* MSA context must be preserved */
 #define TIF_SYSCALL_TRACE	31	/* syscall trace active */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
@@ -133,6 +135,8 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_FPUBOUND		(1<<TIF_FPUBOUND)
 #define _TIF_LOAD_WATCH		(1<<TIF_LOAD_WATCH)
 #define _TIF_32BIT_FPREGS	(1<<TIF_32BIT_FPREGS)
+#define _TIF_USEDMSA		(1<<TIF_USEDMSA)
+#define _TIF_MSA_CTX_LIVE	(1<<TIF_MSA_CTX_LIVE)
 #define _TIF_SYSCALL_TRACEPOINT	(1<<TIF_SYSCALL_TRACEPOINT)
 
 #define _TIF_WORK_SYSCALL_ENTRY	(_TIF_NOHZ | _TIF_SYSCALL_TRACE |	\
diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index d84f6a5..278a49b 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -477,6 +477,7 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	BUILD_HANDLER tr tr sti silent			/* #13 */
 	BUILD_HANDLER fpe fpe fpe silent		/* #15 */
 	BUILD_HANDLER ftlb ftlb none silent		/* #16 */
+	BUILD_HANDLER msa msa sti silent		/* #21 */
 	BUILD_HANDLER mdmx mdmx sti silent		/* #22 */
 #ifdef	CONFIG_HARDWARE_WATCHPOINTS
 	/*
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 2f01f3d..60e39dc 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -32,6 +32,7 @@
 #include <asm/cpu.h>
 #include <asm/dsp.h>
 #include <asm/fpu.h>
+#include <asm/msa.h>
 #include <asm/pgtable.h>
 #include <asm/mipsregs.h>
 #include <asm/processor.h>
@@ -65,6 +66,8 @@ void start_thread(struct pt_regs * regs, unsigned long pc, unsigned long sp)
 	clear_used_math();
 	clear_fpu_owner();
 	init_dsp();
+	clear_thread_flag(TIF_MSA_CTX_LIVE);
+	disable_msa();
 	regs->cp0_epc = pc;
 	regs->regs[29] = sp;
 }
@@ -89,7 +92,9 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 
 	preempt_disable();
 
-	if (is_fpu_owner())
+	if (is_msa_enabled())
+		save_msa(p);
+	else if (is_fpu_owner())
 		save_fp(p);
 
 	if (cpu_has_dsp)
diff --git a/arch/mips/kernel/r4k_switch.S b/arch/mips/kernel/r4k_switch.S
index cc78dd9..f938ecd 100644
--- a/arch/mips/kernel/r4k_switch.S
+++ b/arch/mips/kernel/r4k_switch.S
@@ -29,18 +29,8 @@
 #define ST_OFF (_THREAD_SIZE - 32 - PT_SIZE + PT_STATUS)
 
 /*
- * FPU context is saved iff the process has used it's FPU in the current
- * time slice as indicated by _TIF_USEDFPU.  In any case, the CU1 bit for user
- * space STATUS register should be 0, so that a process *always* starts its
- * userland with FPU disabled after each context switch.
- *
- * FPU will be enabled as soon as the process accesses FPU again, through
- * do_cpu() trap.
- */
-
-/*
  * task_struct *resume(task_struct *prev, task_struct *next,
- *		       struct thread_info *next_ti, int usedfpu)
+ *		       struct thread_info *next_ti, s32 fp_save)
  */
 	.align	5
 	LEAF(resume)
@@ -50,23 +40,37 @@
 	LONG_S	ra, THREAD_REG31(a0)
 
 	/*
-	 * check if we need to save FPU registers
+	 * Check whether we need to save any FP context. FP context is saved
+	 * iff the process has used the context with the scalar FPU or the MSA
+	 * ASE in the current time slice, as indicated by _TIF_USEDFPU and
+	 * _TIF_USEDMSA respectively. switch_to will have set fp_save
+	 * accordingly to an FP_SAVE_ enum value.
 	 */
+	beqz	a3, 2f
 
-	beqz	a3, 1f
-
-	PTR_L	t3, TASK_THREAD_INFO(a0)
 	/*
-	 * clear saved user stack CU1 bit
+	 * We do. Clear the saved CU1 bit for prev, such that next time it is
+	 * scheduled it will start in userland with the FPU disabled. If the
+	 * task uses the FPU then it will be enabled again via the do_cpu trap.
+	 * This allows us to lazily restore the FP context.
 	 */
+	PTR_L	t3, TASK_THREAD_INFO(a0)
 	LONG_L	t0, ST_OFF(t3)
 	li	t1, ~ST0_CU1
 	and	t0, t0, t1
 	LONG_S	t0, ST_OFF(t3)
 
+	/* Check whether we're saving scalar or vector context. */
+	bgtz	a3, 1f
+
+	/* Save 128b MSA vector context. */
+	msa_save_all	a0
+	b	2f
+
+1:	/* Save 32b/64b scalar FP context. */
 	fpu_save_double a0 t0 t1		# c0_status passed in t0
 						# clobbers t1
-1:
+2:
 
 #if defined(CONFIG_CC_STACKPROTECTOR) && !defined(CONFIG_SMP)
 	PTR_LA	t8, __stack_chk_guard
@@ -141,6 +145,26 @@ LEAF(_restore_fp)
 	jr	ra
 	END(_restore_fp)
 
+#ifdef CONFIG_CPU_HAS_MSA
+
+/*
+ * Save a thread's MSA vector context.
+ */
+LEAF(_save_msa)
+	msa_save_all	a0
+	jr	ra
+	END(_save_msa)
+
+/*
+ * Restore a thread's MSA vector context.
+ */
+LEAF(_restore_msa)
+	msa_restore_all	a0
+	jr	ra
+	END(_restore_msa)
+
+#endif
+
 /*
  * Load the FPU with signalling NANS.  This bit pattern we're using has
  * the property that no matter whether considered as single or as double
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index e0b4996..e609c89 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -47,6 +47,7 @@
 #include <asm/mipsregs.h>
 #include <asm/mipsmtregs.h>
 #include <asm/module.h>
+#include <asm/msa.h>
 #include <asm/pgtable.h>
 #include <asm/ptrace.h>
 #include <asm/sections.h>
@@ -79,6 +80,7 @@ extern asmlinkage void handle_ov(void);
 extern asmlinkage void handle_tr(void);
 extern asmlinkage void handle_fpe(void);
 extern asmlinkage void handle_ftlb(void);
+extern asmlinkage void handle_msa(void);
 extern asmlinkage void handle_mdmx(void);
 extern asmlinkage void handle_watch(void);
 extern asmlinkage void handle_mt(void);
@@ -1074,6 +1076,76 @@ static int default_cu2_call(struct notifier_block *nfb, unsigned long action,
 	return NOTIFY_OK;
 }
 
+static int enable_restore_fp_context(int msa)
+{
+	int err, was_fpu_owner;
+
+	if (!used_math()) {
+		/* First time FP context user. */
+		err = init_fpu();
+		if (msa && !err)
+			enable_msa();
+		if (!err)
+			set_used_math();
+		return err;
+	}
+
+	/*
+	 * This task has formerly used the FP context.
+	 *
+	 * If this thread has no live MSA vector context then we can simply
+	 * restore the scalar FP context. If it has live MSA vector context
+	 * (that is, it has or may have used MSA since last performing a
+	 * function call) then we'll need to restore the vector context. This
+	 * applies even if we're currently only executing a scalar FP
+	 * instruction. This is because if we were to later execute an MSA
+	 * instruction then we'd either have to:
+	 *
+	 *  - Restore the vector context & clobber any registers modified by
+	 *    scalar FP instructions between now & then.
+	 *
+	 * or
+	 *
+	 *  - Not restore the vector context & lose the most significant bits
+	 *    of all vector registers.
+	 *
+	 * Neither of those options is acceptable. We cannot restore the least
+	 * significant bits of the registers now & only restore the most
+	 * significant bits later because the most significant bits of any
+	 * vector registers whose aliased FP register is modified now will have
+	 * been zeroed. We'd have no way to know that when restoring the vector
+	 * context & thus may load an outdated value for the most significant
+	 * bits of a vector register.
+	 */
+	if (!msa && !thread_msa_context_live())
+		return own_fpu(1);
+
+	/*
+	 * This task is using or has previously used MSA. Thus we require
+	 * that Status.FR == 1.
+	 */
+	was_fpu_owner = is_fpu_owner();
+	err = own_fpu(0);
+	if (err)
+		return err;
+
+	enable_msa();
+	write_msa_csr(current->thread.fpu.msacsr);
+	set_thread_flag(TIF_USEDMSA);
+
+	/*
+	 * If this is the first time that the task is using MSA and it has
+	 * previously used scalar FP in this time slice then we already nave
+	 * FP context which we shouldn't clobber.
+	 */
+	if (!test_and_set_thread_flag(TIF_MSA_CTX_LIVE) && was_fpu_owner)
+		return 0;
+
+	/* We need to restore the vector context. */
+	restore_msa(current);
+	return 0;
+}
+
 asmlinkage void do_cpu(struct pt_regs *regs)
 {
 	enum ctx_state prev_state;
@@ -1153,12 +1225,7 @@ asmlinkage void do_cpu(struct pt_regs *regs)
 		/* Fall through.  */
 
 	case 1:
-		if (used_math())	/* Using the FPU again.	 */
-			err = own_fpu(1);
-		else {			/* First time FPU user.	 */
-			err = init_fpu();
-			set_used_math();
-		}
+		err = enable_restore_fp_context(0);
 
 		if (!raw_cpu_has_fpu || err) {
 			int sig;
@@ -1183,6 +1250,27 @@ out:
 	exception_exit(prev_state);
 }
 
+asmlinkage void do_msa(struct pt_regs *regs)
+{
+	enum ctx_state prev_state;
+	int err;
+
+	prev_state = exception_enter();
+
+	if (!cpu_has_msa || test_thread_flag(TIF_32BIT_FPREGS)) {
+		force_sig(SIGILL, current);
+		goto out;
+	}
+
+	die_if_kernel("do_msa invoked from kernel context!", regs);
+
+	err = enable_restore_fp_context(1);
+	if (err)
+		force_sig(SIGILL, current);
+out:
+	exception_exit(prev_state);
+}
+
 asmlinkage void do_mdmx(struct pt_regs *regs)
 {
 	enum ctx_state prev_state;
@@ -2040,6 +2128,7 @@ void __init trap_init(void)
 		set_except_vector(15, handle_fpe);
 
 	set_except_vector(16, handle_ftlb);
+	set_except_vector(21, handle_msa);
 	set_except_vector(22, handle_mdmx);
 
 	if (cpu_has_mcheck)
-- 
1.8.5.3
