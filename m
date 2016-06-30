Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2016 12:49:39 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:23175 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992870AbcF3KtUeWhpj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Jun 2016 12:49:20 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id E443D69BF5EB4;
        Thu, 30 Jun 2016 11:49:10 +0100 (IST)
Received: from localhost (10.100.200.138) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 30 Jun
 2016 11:49:12 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        Maciej Rozycki <maciej.rozycki@imgtec.com>,
        Faraz Shahbazker <faraz.shahbazker@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Matthew Fortune <matthew.fortune@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [RFC PATCH v4 1/2] MIPS: use per-mm page to execute branch delay slot instructions
Date:   Thu, 30 Jun 2016 11:48:41 +0100
Message-ID: <20160630104842.14361-2-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160630104842.14361-1-paul.burton@imgtec.com>
References: <20160630104842.14361-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.138]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54187
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

In some cases the kernel needs to execute an instruction from the delay
slot of an emulated branch instruction. These cases include:

  - Emulated floating point branch instructions (bc1[ft]l?) for systems
    which don't include an FPU, or upon which the kernel is run with the
    "nofpu" parameter.

  - MIPSr6 systems running binaries targeting older revisions of the
    architecture, which may include branch instructions whose encodings
    are no longer valid in MIPSr6.

Executing instructions from such delay slots is done by writing the
instruction to memory followed by a trap, as part of an "emuframe", and
executing it. This avoids the requirement of an emulator for the entire
MIPS instruction set. Prior to this patch such emuframes are written to
the user stack and executed from there.

This patch moves FP branch delay emuframes off of the user stack and
into a per-mm page. Allocating a page per-mm leaves userland with access
to only what it had access to previously, and compared to other
solutions is relatively simple.

When a thread requires a delay slot emulation, it is allocated a frame.
A thread may only have one frame allocated at any one time, since it may
only ever be executing one instruction at any one time. In order to
ensure that we can free up allocated frame later, its index is recorded
in struct thread_struct. In the typical case, after executing the delay
slot instruction we'll execute a break instruction with the BRK_MEMU
code. This traps back to the kernel & leads to a call to do_dsemulret
which frees the allocated frame & moves the user PC back to the
instruction that would have executed following the emulated branch.
In some cases the delay slot instruction may be invalid, such as a
branch, or may trigger an exception. In these cases the BRK_MEMU break
instruction will not be hit. In order to ensure that frames are freed
this patch introduces dsemul_thread_cleanup() and calls it to free any
allocated frame upon thread exit. If the instruction generated an
exception & leads to a signal being delivered to the thread, or indeed
if a signal simply happens to be delivered to the thread whilst it is
executing from the struct emuframe, then we need to take care to exit
the frame appropriately. This is done by either rolling back the user PC
to the branch or advancing it to the continuation PC prior to signal
delivery, using dsemul_thread_rollback(). If this were not done then a
sigreturn would return to the struct emuframe, and if that frame had
meanwhile been used in response to an emulated branch instruction within
the signal handler then we would execute the wrong user code.

Whilst a user could theoretically place something like a compact branch
to self in a delay slot and cause their thread to become stuck in an
infinite loop with the frame never being deallocated, this would:

  - Only affect the users single process.

  - Be architecturally invalid since there would be a branch in the
    delay slot, which is forbidden.

  - Be extremely unlikely to happen by mistake, and provide a program
    with no more ability to harm the system than a simple infinite loop
    would.

If a thread requires a delay slot emulation & no frame is available to
it (ie. the process has enough other threads that all frames are
currently in use) then the thread joins a waitqueue. It will sleep until
a frame is freed by another thread in the process.

Since we now know whether a thread has an allocated frame due to our
tracking of its index, the cookie field of struct emuframe is removed as
we can be more certain whether we have a valid frame. Since a thread may
only ever have a single frame at any given time, the epc field of struct
emuframe is also removed & the PC to continue from is instead stored in
struct thread_struct. Together these changes simplify & shrink struct
emuframe somewhat, allowing twice as many frames to fit into the page
allocated for them.

The primary benefit of this patch is that we are now free to mark the
user stack non-executable where that is possible.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>

---
v2 of this patch can be found here:

  https://patchwork.linux-mips.org/patch/6125/

This has become a higher priority than it was at the time of v2 since
Android has begun marking its stacks non-executable & on MIPSr6 devices
we use mips_dsemul() in the emulation of pre-r6 instructions. Since the
Android NDK MIPS target is MIPS32, this is important to backwards
compatibility for apps on MIPSr6 systems.

Changes in v4:
- Include asm/dsemul.h.
- If a thread is executing somewhere unexpected in the emupage when a rollback (signal) occurs, free the threads allocated frame anyway.

Changes in v3:
- Rebase atop v4.7-rc5.
- Select CONFIG_HAVE_EXIT_THREAD.
- Track allocated frames per thread, allowing cleanup on exit or signal delivery.
- Remove signal blocking & thread information flag now we have other means to ensure frames are cleaned up.
- Introduce asm/dsemul.h to group prototypes & definitions logically.
- Avoid using 'fp' in names, since this isn't exclusive to FP branch emulation.
- Document with kerneldoc.
- Return a frame index from alloc_emuframe such that mips_dsemul can record it in struct thread_struct.
- Use bool return type for do_dsemulret rather than a bool-like int.
- Rework commit message.

Changes in v2:
- s/kernels/kernel's/
- Use (mm_)isBranchInstr in mips_dsemul rather than duplicating similar logic.

 arch/mips/Kconfig                     |   1 +
 arch/mips/include/asm/dsemul.h        |  90 +++++++++
 arch/mips/include/asm/fpu_emulator.h  |  17 +-
 arch/mips/include/asm/mmu.h           |  11 ++
 arch/mips/include/asm/mmu_context.h   |   7 +
 arch/mips/include/asm/processor.h     |  18 +-
 arch/mips/kernel/mips-r2-to-r6-emul.c |   8 +-
 arch/mips/kernel/process.c            |   6 +
 arch/mips/kernel/signal.c             |   8 +
 arch/mips/math-emu/cp1emu.c           |   8 +-
 arch/mips/math-emu/dsemul.c           | 342 +++++++++++++++++++++++-----------
 11 files changed, 383 insertions(+), 133 deletions(-)
 create mode 100644 arch/mips/include/asm/dsemul.h

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ac91939..49a5396 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -64,6 +64,7 @@ config MIPS
 	select GENERIC_TIME_VSYSCALL
 	select ARCH_CLOCKSOURCE_DATA
 	select HANDLE_DOMAIN_IRQ
+	select HAVE_EXIT_THREAD
 
 menu "Machine selection"
 
diff --git a/arch/mips/include/asm/dsemul.h b/arch/mips/include/asm/dsemul.h
new file mode 100644
index 0000000..0aae275
--- /dev/null
+++ b/arch/mips/include/asm/dsemul.h
@@ -0,0 +1,90 @@
+/*
+ * Copyright (C) 2016 Imagination Technologies
+ * Author: Paul Burton <paul.burton@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __MIPS_ASM_DSEMUL_H__
+#define __MIPS_ASM_DSEMUL_H__
+
+#include <asm/break.h>
+#include <asm/inst.h>
+
+/* Break instruction with special math emu break code set */
+#define BREAK_MATH(micromips)	(((micromips) ? 0x7 : 0xd) | (BRK_MEMU << 16))
+
+/* When used as a frame index, indicates the lack of a frame */
+#define BD_EMUFRAME_NONE	BIT(31)
+
+struct mm_struct;
+struct pt_regs;
+
+/**
+ * mips_dsemul() - 'Emulate' an instruction from a branch delay slot
+ * @regs:	User thread register context.
+ * @ir:		The instruction to be 'emulated'.
+ * @branch_pc:	The PC of the branch instruction.
+ * @cont_pc:	The PC to continue at following 'emulation'.
+ *
+ * Emulate or execute an arbitrary MIPS instruction within the context of
+ * the current user thread. This is used primarily to handle instructions
+ * in the delay slots of emulated branch instructions, for example FP
+ * branch instructions on systems without an FPU.
+ *
+ * Return: Zero on success, negative if ir is a NOP, signal number on failure.
+ */
+extern int mips_dsemul(struct pt_regs *regs, mips_instruction ir,
+		       unsigned long branch_pc, unsigned long cont_pc);
+
+/**
+ * do_dsemulret() - Return from a delay slot 'emulation' frame
+ * @xcp:	User thread register context.
+ *
+ * Call in response to the BRK_MEMU break instruction used to return to
+ * the kernel from branch delay slot 'emulation' frames following a call
+ * to mips_dsemul(). Restores the user thread PC to the value that was
+ * passed as the cpc parameter to mips_dsemul().
+ *
+ * Return: True if an emulation frame was returned from, else false.
+ */
+extern bool do_dsemulret(struct pt_regs *xcp);
+
+/**
+ * dsemul_thread_cleanup() - Cleanup thread 'emulation' frame
+ *
+ * If the current thread has a branch delay slot 'emulation' frame
+ * allocated to it then free that frame.
+ *
+ * Return: True if a frame was freed, else false.
+ */
+extern bool dsemul_thread_cleanup(void);
+
+/**
+ * dsemul_thread_rollback() - Rollback from an 'emulation' frame
+ * @regs:	User thread register context.
+ *
+ * If the current thread, whose register context is represented by @regs,
+ * is executing within a delay slot 'emulation' frame then exit that
+ * frame. The PC will be rolled back to the branch if the instruction
+ * that was being 'emulated' has not yet executed, or advanced to the
+ * continuation PC if it has.
+ *
+ * Return: True if a frame was exited, else false.
+ */
+extern bool dsemul_thread_rollback(struct pt_regs *regs);
+
+/**
+ * dsemul_mm_cleanup() - Cleanup per-mm delay slot 'emulation' state
+ * @mm:		The struct mm_struct to cleanup state for.
+ *
+ * Cleanup state for the given @mm, ensuring that any memory allocated
+ * for delay slot 'emulation' book-keeping is freed. This is to be called
+ * before @mm is freed in order to avoid memory leaks.
+ */
+extern void dsemul_mm_cleanup(struct mm_struct *mm);
+
+#endif /* __MIPS_ASM_DSEMUL_H__ */
diff --git a/arch/mips/include/asm/fpu_emulator.h b/arch/mips/include/asm/fpu_emulator.h
index 3225c3c..355dc25 100644
--- a/arch/mips/include/asm/fpu_emulator.h
+++ b/arch/mips/include/asm/fpu_emulator.h
@@ -24,7 +24,7 @@
 #define _ASM_FPU_EMULATOR_H
 
 #include <linux/sched.h>
-#include <asm/break.h>
+#include <asm/dsemul.h>
 #include <asm/thread_info.h>
 #include <asm/inst.h>
 #include <asm/local.h>
@@ -60,27 +60,16 @@ do {									\
 #define MIPS_FPU_EMU_INC_STATS(M) do { } while (0)
 #endif /* CONFIG_DEBUG_FS */
 
-extern int mips_dsemul(struct pt_regs *regs, mips_instruction ir,
-	unsigned long cpc);
-extern int do_dsemulret(struct pt_regs *xcp);
 extern int fpu_emulator_cop1Handler(struct pt_regs *xcp,
 				    struct mips_fpu_struct *ctx, int has_fpu,
 				    void *__user *fault_addr);
 int process_fpemu_return(int sig, void __user *fault_addr,
 			 unsigned long fcr31);
+int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
+		  unsigned long *contpc);
 int mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 		     unsigned long *contpc);
 
-/*
- * Instruction inserted following the badinst to further tag the sequence
- */
-#define BD_COOKIE 0x0000bd36	/* tne $0, $0 with baggage */
-
-/*
- * Break instruction with special math emu break code set
- */
-#define BREAK_MATH(micromips) (((micromips) ? 0x7 : 0xd) | (BRK_MEMU << 16))
-
 #define SIGNALLING_NAN 0x7ff800007ff80000LL
 
 static inline void fpu_emulator_init_fpu(void)
diff --git a/arch/mips/include/asm/mmu.h b/arch/mips/include/asm/mmu.h
index 1afa1f9..df6ec07 100644
--- a/arch/mips/include/asm/mmu.h
+++ b/arch/mips/include/asm/mmu.h
@@ -2,11 +2,22 @@
 #define __ASM_MMU_H
 
 #include <linux/atomic.h>
+#include <linux/mutex.h>
+#include <linux/wait.h>
 
 typedef struct {
 	unsigned long asid[NR_CPUS];
 	void *vdso;
 	atomic_t fp_mode_switching;
+
+	/* address of page used to hold FP branch delay emulation frames */
+	unsigned long bd_emupage;
+	/* bitmap tracking allocation of fp_bd_emupage */
+	unsigned long *bd_emupage_allocmap;
+	/* mutex to be held whilst modifying fp_bd_emupage(_allocmap) */
+	struct mutex bd_emupage_mutex;
+	/* wait queue for threads requiring an emuframe */
+	wait_queue_head_t bd_emupage_queue;
 } mm_context_t;
 
 #endif /* __ASM_MMU_H */
diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mmu_context.h
index fc57e13..174d68a 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -16,6 +16,7 @@
 #include <linux/smp.h>
 #include <linux/slab.h>
 #include <asm/cacheflush.h>
+#include <asm/dsemul.h>
 #include <asm/hazards.h>
 #include <asm/tlbflush.h>
 #include <asm-generic/mm_hooks.h>
@@ -128,6 +129,11 @@ init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 
 	atomic_set(&mm->context.fp_mode_switching, 0);
 
+	mm->context.bd_emupage = 0;
+	mm->context.bd_emupage_allocmap = NULL;
+	mutex_init(&mm->context.bd_emupage_mutex);
+	init_waitqueue_head(&mm->context.bd_emupage_queue);
+
 	return 0;
 }
 
@@ -162,6 +168,7 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
  */
 static inline void destroy_context(struct mm_struct *mm)
 {
+	dsemul_mm_cleanup(mm);
 }
 
 #define deactivate_mm(tsk, mm)	do { } while (0)
diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index 7e78b62..0d36c87 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -11,12 +11,14 @@
 #ifndef _ASM_PROCESSOR_H
 #define _ASM_PROCESSOR_H
 
+#include <linux/atomic.h>
 #include <linux/cpumask.h>
 #include <linux/threads.h>
 
 #include <asm/cachectl.h>
 #include <asm/cpu.h>
 #include <asm/cpu-info.h>
+#include <asm/dsemul.h>
 #include <asm/mipsregs.h>
 #include <asm/prefetch.h>
 
@@ -78,7 +80,11 @@ extern unsigned int vced_count, vcei_count;
 
 #endif
 
-#define STACK_TOP	(TASK_SIZE & PAGE_MASK)
+/*
+ * One page above the stack is used for branch delay slot "emulation".
+ * See dsemul.c for details.
+ */
+#define STACK_TOP	((TASK_SIZE & PAGE_MASK) - PAGE_SIZE)
 
 /*
  * This decides where the kernel will search for a free chunk of vm
@@ -256,6 +262,12 @@ struct thread_struct {
 
 	/* Saved fpu/fpu emulator stuff. */
 	struct mips_fpu_struct fpu FPU_ALIGN;
+	/* Assigned branch delay slot 'emulation' frame */
+	atomic_t bd_emu_frame;
+	/* PC of the branch from a branch delay slot 'emulation' */
+	unsigned long bd_emu_branch_pc;
+	/* PC to continue from following a branch delay slot 'emulation' */
+	unsigned long bd_emu_cont_pc;
 #ifdef CONFIG_MIPS_MT_FPAFF
 	/* Emulated instruction count */
 	unsigned long emulated_fp;
@@ -323,6 +335,10 @@ struct thread_struct {
 	 * FPU affinity state (null if not FPAFF)		\
 	 */							\
 	FPAFF_INIT						\
+	/* Delay slot emulation */				\
+	.bd_emu_frame = ATOMIC_INIT(BD_EMUFRAME_NONE),		\
+	.bd_emu_branch_pc = 0,					\
+	.bd_emu_cont_pc = 0,					\
 	/*							\
 	 * Saved DSP stuff					\
 	 */							\
diff --git a/arch/mips/kernel/mips-r2-to-r6-emul.c b/arch/mips/kernel/mips-r2-to-r6-emul.c
index 7ff2a55..ef23c61 100644
--- a/arch/mips/kernel/mips-r2-to-r6-emul.c
+++ b/arch/mips/kernel/mips-r2-to-r6-emul.c
@@ -283,7 +283,7 @@ static int jr_func(struct pt_regs *regs, u32 ir)
 		err = mipsr6_emul(regs, nir);
 		if (err > 0) {
 			regs->cp0_epc = nepc;
-			err = mips_dsemul(regs, nir, cepc);
+			err = mips_dsemul(regs, nir, epc, cepc);
 			if (err == SIGILL)
 				err = SIGEMT;
 			MIPS_R2_STATS(dsemul);
@@ -1033,7 +1033,7 @@ repeat:
 			if (nir) {
 				err = mipsr6_emul(regs, nir);
 				if (err > 0) {
-					err = mips_dsemul(regs, nir, cpc);
+					err = mips_dsemul(regs, nir, epc, cpc);
 					if (err == SIGILL)
 						err = SIGEMT;
 					MIPS_R2_STATS(dsemul);
@@ -1082,7 +1082,7 @@ repeat:
 			if (nir) {
 				err = mipsr6_emul(regs, nir);
 				if (err > 0) {
-					err = mips_dsemul(regs, nir, cpc);
+					err = mips_dsemul(regs, nir, epc, cpc);
 					if (err == SIGILL)
 						err = SIGEMT;
 					MIPS_R2_STATS(dsemul);
@@ -1149,7 +1149,7 @@ repeat:
 		if (nir) {
 			err = mipsr6_emul(regs, nir);
 			if (err > 0) {
-				err = mips_dsemul(regs, nir, cpc);
+				err = mips_dsemul(regs, nir, epc, cpc);
 				if (err == SIGILL)
 					err = SIGEMT;
 				MIPS_R2_STATS(dsemul);
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 813ed78..0fb1e8c 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -30,6 +30,7 @@
 #include <asm/asm.h>
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
+#include <asm/dsemul.h>
 #include <asm/dsp.h>
 #include <asm/fpu.h>
 #include <asm/msa.h>
@@ -73,6 +74,11 @@ void start_thread(struct pt_regs * regs, unsigned long pc, unsigned long sp)
 	regs->regs[29] = sp;
 }
 
+void exit_thread(struct task_struct *tsk)
+{
+	dsemul_thread_cleanup();
+}
+
 int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 {
 	/*
diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index ae42314..9383635 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -772,6 +772,14 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 	struct mips_abi *abi = current->thread.abi;
 	void *vdso = current->mm->context.vdso;
 
+	/*
+	 * If we were emulating a delay slot instruction, exit that frame such
+	 * that addresses in the sigframe are as expected for userland and we
+	 * don't have a problem if we reuse the thread's frame for an
+	 * instruction within the signal handler.
+	 */
+	dsemul_thread_rollback(regs);
+
 	if (regs->regs[0]) {
 		switch(regs->regs[2]) {
 		case ERESTART_RESTARTBLOCK:
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index d96e912..8afa090 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -434,8 +434,8 @@ static int microMIPS32_to_MIPS32(union mips_instruction *insn_ptr)
  * a single subroutine should be used across both
  * modules.
  */
-static int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
-			 unsigned long *contpc)
+int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
+		  unsigned long *contpc)
 {
 	union mips_instruction insn = (union mips_instruction)dec_insn.insn;
 	unsigned int fcr31;
@@ -1268,7 +1268,7 @@ branch_common:
 						 * instruction in the dslot.
 						 */
 						sig = mips_dsemul(xcp, ir,
-								  contpc);
+								  bcpc, contpc);
 						if (sig < 0)
 							break;
 						if (sig)
@@ -1323,7 +1323,7 @@ branch_common:
 				 * Single step the non-cp1
 				 * instruction in the dslot
 				 */
-				sig = mips_dsemul(xcp, ir, contpc);
+				sig = mips_dsemul(xcp, ir, bcpc, contpc);
 				if (sig < 0)
 					break;
 				if (sig)
diff --git a/arch/mips/math-emu/dsemul.c b/arch/mips/math-emu/dsemul.c
index 4707488..92083d0 100644
--- a/arch/mips/math-emu/dsemul.c
+++ b/arch/mips/math-emu/dsemul.c
@@ -1,3 +1,6 @@
+#include <linux/err.h>
+#include <linux/slab.h>
+
 #include <asm/branch.h>
 #include <asm/cacheflush.h>
 #include <asm/fpu_emulator.h>
@@ -5,43 +8,220 @@
 #include <asm/mipsregs.h>
 #include <asm/uaccess.h>
 
-#include "ieee754.h"
-
-/*
- * Emulate the arbitrary instruction ir at xcp->cp0_epc.  Required when
- * we have to emulate the instruction in a COP1 branch delay slot.  Do
- * not change cp0_epc due to the instruction
+/**
+ * struct emuframe - The 'emulation' frame structure
+ * @emul:	The instruction to 'emulate'.
+ * @badinst:	A break instruction to cause a return to the kernel.
  *
- * According to the spec:
- * 1) it shouldn't be a branch :-)
- * 2) it can be a COP instruction :-(
- * 3) if we are tring to run a protected memory space we must take
- *    special care on memory access instructions :-(
- */
-
-/*
- * "Trampoline" return routine to catch exception following
- *  execution of delay-slot instruction execution.
+ * This structure defines the frames placed within the delay slot emulation
+ * page in response to a call to mips_dsemul(). Each thread may be allocated
+ * only one frame at any given time. The kernel stores within it the
+ * instruction to be 'emulated' followed by a break instruction, then
+ * executes the frame in user mode. The break causes a trap to the kernel
+ * which leads to do_dsemulret() being called unless the instruction in
+ * @emul causes a trap itself, is a branch, or a signal is delivered to
+ * the thread. In these cases the allocated frame will either be reused by
+ * a subsequent delay slot 'emulation', or be freed during signal delivery or
+ * upon thread exit.
+ *
+ * This approach is used because:
+ *
+ * - Actually emulating all instructions isn't feasible. We would need to
+ *   be able to handle instructions from all revisions of the MIPS ISA,
+ *   all ASEs & all vendor instruction set extensions. This would be a
+ *   whole lot of work & continual maintenance burden as new instructions
+ *   are introduced, and in the case of some vendor extensions may not
+ *   even be possible. Thus we need to take the approach of actually
+ *   executing the instruction.
+ *
+ * - We must execute the instruction within user context. If we were to
+ *   execute the instruction in kernel mode then it would have access to
+ *   kernel resources without very careful checks, leaving us with a
+ *   high potential for security or stability issues to arise.
+ *
+ * - We used to place the frame on the users stack, but this requires
+ *   that the stack be executable. This is bad for security so the
+ *   per-process page is now used instead.
+ *
+ * - The instruction in @emul may be something entirely invalid for a
+ *   delay slot. The user may (intentionally or otherwise) place a branch
+ *   in a delay slot, or a kernel mode instruction, or something else
+ *   which generates an exception. Thus we can't rely upon the break in
+ *   @badinst always being hit. For this reason we track the index of the
+ *   frame allocated to each thread, allowing us to clean it up at later
+ *   points such as signal delivery or thread exit.
+ *
+ * - The user may generate a fake struct emuframe if they wish, invoking
+ *   the BRK_MEMU break instruction themselves. We must therefore not
+ *   trust that BRK_MEMU means there's actually a valid frame allocated
+ *   to the thread, and must not allow the user to do anything they
+ *   couldn't already.
  */
-
 struct emuframe {
 	mips_instruction	emul;
 	mips_instruction	badinst;
-	mips_instruction	cookie;
-	unsigned long		epc;
 };
 
-/*
- * Set up an emulation frame for instruction IR, from a delay slot of
- * a branch jumping to CPC.  Return 0 if successful, -1 if no emulation
- * required, otherwise a signal number causing a frame setup failure.
- */
-int mips_dsemul(struct pt_regs *regs, mips_instruction ir, unsigned long cpc)
+static const int emupage_frame_count = PAGE_SIZE / sizeof(struct emuframe);
+
+static int alloc_emuframe(void)
+{
+	mm_context_t *mm_ctx = &current->mm->context;
+	unsigned long addr;
+	int idx;
+
+retry:
+	mutex_lock(&mm_ctx->bd_emupage_mutex);
+
+	/* Ensure we have a page allocated for emuframes */
+	if (!mm_ctx->bd_emupage) {
+		addr = mmap_region(NULL, STACK_TOP, PAGE_SIZE,
+				   VM_READ|VM_WRITE|VM_EXEC|
+				   VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
+				   0);
+		if (IS_ERR_VALUE(addr)) {
+			idx = BD_EMUFRAME_NONE;
+			goto out_unlock;
+		}
+
+		mm_ctx->bd_emupage = addr;
+		pr_debug("allocate emupage at 0x%08lx to %d\n", addr,
+			 current->pid);
+	}
+
+	/* Ensure we have an allocation bitmap */
+	if (!mm_ctx->bd_emupage_allocmap) {
+		mm_ctx->bd_emupage_allocmap =
+			kcalloc(BITS_TO_LONGS(emupage_frame_count),
+					      sizeof(unsigned long),
+				GFP_KERNEL);
+
+		if (!mm_ctx->bd_emupage_allocmap) {
+			idx = BD_EMUFRAME_NONE;
+			goto out_unlock;
+		}
+	}
+
+	/* Attempt to allocate a single bit/frame */
+	idx = bitmap_find_free_region(mm_ctx->bd_emupage_allocmap,
+				      emupage_frame_count, 0);
+	if (idx < 0) {
+		/*
+		 * Failed to allocate a frame. We'll wait until one becomes
+		 * available. The mutex is unlocked so that other threads
+		 * actually get the opportunity to free their frames, which
+		 * means technically the result of bitmap_full may be incorrect.
+		 * However the worst case is that we repeat all this and end up
+		 * back here again.
+		 */
+		mutex_unlock(&mm_ctx->bd_emupage_mutex);
+		if (!wait_event_killable(mm_ctx->bd_emupage_queue,
+			!bitmap_full(mm_ctx->bd_emupage_allocmap,
+				     emupage_frame_count)))
+			goto retry;
+
+		/* Received a fatal signal - just give in */
+		return BD_EMUFRAME_NONE;
+	}
+
+	/* Success! */
+	pr_debug("allocate emuframe %d to %d\n", idx, current->pid);
+out_unlock:
+	mutex_unlock(&mm_ctx->bd_emupage_mutex);
+	return idx;
+}
+
+static void free_emuframe(int idx)
+{
+	mm_context_t *mm_ctx = &current->mm->context;
+
+	mutex_lock(&mm_ctx->bd_emupage_mutex);
+
+	pr_debug("free emuframe %d from %d\n", idx, current->pid);
+	bitmap_clear(mm_ctx->bd_emupage_allocmap, idx, 1);
+
+	/* If some thread is waiting for a frame, now's its chance */
+	wake_up(&mm_ctx->bd_emupage_queue);
+
+	mutex_unlock(&mm_ctx->bd_emupage_mutex);
+}
+
+static bool within_emuframe(struct pt_regs *regs)
+{
+	mm_context_t *mm_ctx = &current->mm->context;
+
+	if (regs->cp0_epc < mm_ctx->bd_emupage)
+		return false;
+	if (regs->cp0_epc >= (mm_ctx->bd_emupage + PAGE_SIZE))
+		return false;
+
+	return true;
+}
+
+bool dsemul_thread_cleanup(void)
+{
+	int fr_idx;
+
+	/* Clear any allocated frame, retrieving its index */
+	fr_idx = atomic_xchg(&current->thread.bd_emu_frame, BD_EMUFRAME_NONE);
+
+	/* If no frame was allocated, we're done */
+	if (fr_idx == BD_EMUFRAME_NONE)
+		return false;
+
+	/* Free the frame that this thread had allocated */
+	free_emuframe(fr_idx);
+	return true;
+}
+
+bool dsemul_thread_rollback(struct pt_regs *regs)
+{
+	mm_context_t *mm_ctx = &current->mm->context;
+	struct emuframe __user *fr;
+	int fr_idx;
+
+	/* Do nothing if we're not executing from a frame */
+	if (!within_emuframe(regs))
+		return false;
+
+	/* Find the frame being executed */
+	fr_idx = atomic_read(&current->thread.bd_emu_frame);
+	if (fr_idx == BD_EMUFRAME_NONE)
+		return false;
+	fr = &((struct emuframe __user *)mm_ctx->bd_emupage)[fr_idx];
+
+	/*
+	 * If the PC is at the emul instruction, roll back to the branch. If
+	 * PC is at the badinst (break) instruction, we've already emulated the
+	 * instruction so progress to the continue PC. If it's anything else
+	 * then something is amiss & the user has branched into some other area
+	 * of the emupage - we'll free the allocated frame anyway.
+	 */
+	if (msk_isa16_mode(regs->cp0_epc) == (unsigned long)&fr->emul)
+		regs->cp0_epc = current->thread.bd_emu_branch_pc;
+	else if (msk_isa16_mode(regs->cp0_epc) == (unsigned long)&fr->badinst)
+		regs->cp0_epc = current->thread.bd_emu_cont_pc;
+
+	atomic_set(&current->thread.bd_emu_frame, BD_EMUFRAME_NONE);
+	free_emuframe(fr_idx);
+	return true;
+}
+
+void dsemul_mm_cleanup(struct mm_struct *mm)
+{
+	mm_context_t *mm_ctx = &mm->context;
+
+	kfree(mm_ctx->bd_emupage_allocmap);
+}
+
+int mips_dsemul(struct pt_regs *regs, mips_instruction ir,
+		unsigned long branch_pc, unsigned long cont_pc)
 {
 	int isa16 = get_isa16_mode(regs->cp0_epc);
 	mips_instruction break_math;
+	mm_context_t *mm_ctx = &current->mm->context;
 	struct emuframe __user *fr;
-	int err;
+	int err, fr_idx;
 
 	/* NOP is easy */
 	if (ir == 0)
@@ -68,30 +248,20 @@ int mips_dsemul(struct pt_regs *regs, mips_instruction ir, unsigned long cpc)
 		}
 	}
 
-	pr_debug("dsemul %lx %lx\n", regs->cp0_epc, cpc);
+	pr_debug("dsemul 0x%08lx cont at 0x%08lx\n", regs->cp0_epc, cont_pc);
 
-	/*
-	 * The strategy is to push the instruction onto the user stack
-	 * and put a trap after it which we can catch and jump to
-	 * the required address any alternative apart from full
-	 * instruction emulation!!.
-	 *
-	 * Algorithmics used a system call instruction, and
-	 * borrowed that vector.  MIPS/Linux version is a bit
-	 * more heavyweight in the interests of portability and
-	 * multiprocessor support.  For Linux we use a BREAK 514
-	 * instruction causing a breakpoint exception.
-	 */
-	break_math = BREAK_MATH(isa16);
-
-	/* Ensure that the two instructions are in the same cache line */
-	fr = (struct emuframe __user *)
-		((regs->regs[29] - sizeof(struct emuframe)) & ~0x7);
-
-	/* Verify that the stack pointer is not completely insane */
-	if (unlikely(!access_ok(VERIFY_WRITE, fr, sizeof(struct emuframe))))
+	/* Allocate a frame if we don't already have one */
+	fr_idx = atomic_read(&current->thread.bd_emu_frame);
+	if (fr_idx == BD_EMUFRAME_NONE)
+		fr_idx = alloc_emuframe();
+	if (fr_idx == BD_EMUFRAME_NONE)
 		return SIGBUS;
+	fr = &((struct emuframe __user *)mm_ctx->bd_emupage)[fr_idx];
+
+	/* Retrieve the appropriately encoded break instruction */
+	break_math = BREAK_MATH(isa16);
 
+	/* Write the instructions to the frame */
 	if (isa16) {
 		err = __put_user(ir >> 16,
 				 (u16 __user *)(&fr->emul));
@@ -106,84 +276,36 @@ int mips_dsemul(struct pt_regs *regs, mips_instruction ir, unsigned long cpc)
 		err |= __put_user(break_math, &fr->badinst);
 	}
 
-	err |= __put_user((mips_instruction)BD_COOKIE, &fr->cookie);
-	err |= __put_user(cpc, &fr->epc);
-
 	if (unlikely(err)) {
 		MIPS_FPU_EMU_INC_STATS(errors);
+		free_emuframe(fr_idx);
 		return SIGBUS;
 	}
 
+	/* Record the PC of the branch, PC to continue from & frame index */
+	current->thread.bd_emu_branch_pc = branch_pc;
+	current->thread.bd_emu_cont_pc = cont_pc;
+	atomic_set(&current->thread.bd_emu_frame, fr_idx);
+
+	/* Change user register context to execute the frame */
 	regs->cp0_epc = (unsigned long)&fr->emul | isa16;
 
+	/* Ensure the icache observes our newly written frame */
 	flush_cache_sigtramp((unsigned long)&fr->emul);
 
 	return 0;
 }
 
-int do_dsemulret(struct pt_regs *xcp)
+bool do_dsemulret(struct pt_regs *xcp)
 {
-	int isa16 = get_isa16_mode(xcp->cp0_epc);
-	struct emuframe __user *fr;
-	unsigned long epc;
-	u32 insn, cookie;
-	int err = 0;
-	u16 instr[2];
-
-	fr = (struct emuframe __user *)
-		(msk_isa16_mode(xcp->cp0_epc) - sizeof(mips_instruction));
-
-	/*
-	 * If we can't even access the area, something is very wrong, but we'll
-	 * leave that to the default handling
-	 */
-	if (!access_ok(VERIFY_READ, fr, sizeof(struct emuframe)))
-		return 0;
-
-	/*
-	 * Do some sanity checking on the stackframe:
-	 *
-	 *  - Is the instruction pointed to by the EPC an BREAK_MATH?
-	 *  - Is the following memory word the BD_COOKIE?
-	 */
-	if (isa16) {
-		err = __get_user(instr[0],
-				 (u16 __user *)(&fr->badinst));
-		err |= __get_user(instr[1],
-				  (u16 __user *)((long)(&fr->badinst) + 2));
-		insn = (instr[0] << 16) | instr[1];
-	} else {
-		err = __get_user(insn, &fr->badinst);
-	}
-	err |= __get_user(cookie, &fr->cookie);
-
-	if (unlikely(err ||
-		     insn != BREAK_MATH(isa16) || cookie != BD_COOKIE)) {
+	/* Cleanup the allocated frame, returning if there wasn't one */
+	if (!dsemul_thread_cleanup()) {
 		MIPS_FPU_EMU_INC_STATS(errors);
-		return 0;
-	}
-
-	/*
-	 * At this point, we are satisfied that it's a BD emulation trap.  Yes,
-	 * a user might have deliberately put two malformed and useless
-	 * instructions in a row in his program, in which case he's in for a
-	 * nasty surprise - the next instruction will be treated as a
-	 * continuation address!  Alas, this seems to be the only way that we
-	 * can handle signals, recursion, and longjmps() in the context of
-	 * emulating the branch delay instruction.
-	 */
-
-	pr_debug("dsemulret\n");
-
-	if (__get_user(epc, &fr->epc)) {		/* Saved EPC */
-		/* This is not a good situation to be in */
-		force_sig(SIGBUS, current);
-
-		return 0;
+		return false;
 	}
 
 	/* Set EPC to return to post-branch instruction */
-	xcp->cp0_epc = epc;
-	MIPS_FPU_EMU_INC_STATS(ds_emul);
-	return 1;
+	xcp->cp0_epc = current->thread.bd_emu_cont_pc;
+	pr_debug("dsemulret to 0x%08lx\n", xcp->cp0_epc);
+	return true;
 }
-- 
2.9.0
