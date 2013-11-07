Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Nov 2013 13:50:49 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:52394 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823073Ab3KGMtDO4CSC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 7 Nov 2013 13:49:03 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 5/6] mips: use per-mm page to execute FP branch delay slots
Date:   Thu, 7 Nov 2013 12:48:32 +0000
Message-ID: <1383828513-28462-6-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1383828513-28462-1-git-send-email-paul.burton@imgtec.com>
References: <1383828513-28462-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2013_11_07_12_48_58
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38475
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

If a floating point branch instruction (bc1[ft]l?) is emulated,
typically because we're running on a core with no FPU, then we need to
execute the instruction in its branch delay slot too. This is done by
writing that instruction to memory followed by a trap, as part of an
"emuframe", and executing it. This avoids the requirement of an emulator
for the entire MIPS instruction set. Prior to this patch such emuframes
are written to the user stack and executed from there.

This patch moves FP branch delay emuframes off of the user stack and
into a per-mm page. Allocating a page per-mm leaves userland with access
to only what it had access to previously, and prevents processes
interfering with each other as they might if a single system-wide page
were used. The book-keeping required to track the allocation of
emuframes is not cheap, but given that invoking the FP emulator is
already very expensive I don't expect this to be an issue.

The biggest issue with executing the instruction from an FP branch delay
is that we must ensure that we free the frame from which we ran it. That
means that we must trap back to the kernel after executing that
instruction, which means that we must take special care not to let the
PC be changed as a result of that instruction. Fortunately since we're
executing an instruction we found in a branch delay the result is
unpredictable if that instruction is a branch or jump, so we can simply
treat those as NOPs and avoid them causing a problem. However there is
still the possibility that a signal may be handled whilst executing the
branch delay instruction. This would usually be fine as we would simply
execute our trap back to the kernel after sigreturn, however it is
possible for userland to simply not return from the signal handler - for
example if it executes something like a longjmp. In that case we would
never trap back to the kernel and never free the frame. For that reason
a TIF_FP_BD_EMU flag is introduced and set whilst we are executing an FP
branch delay instruction. Whilst this flag is set, signals will be
ignored. This isn't exactly pretty, but it's simpler than most of the
alternatives. One other simple option I considered would be to just
kill a process if we find a branch in an FP branch delay slot, but I
chose the current approach because its result is closer to what would
previously happen.

The primary benefit of this patch is that we are now free to mark the
user stack non-executable where that is possible.

Additionally the FP emuframes themselves are simplified somewhat. The
cookie field is removed since we can be pretty certain that we're
looking at an emuframe by virtue of it being located in the page
allocated for them. The PC to continue from is moved into struct
thread_struct since the control flow of a thread can no longer be
modified for the duration of the 'emulation', meaning there will now
only ever be a single emuframe required for a thread at any given time.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/asm/fpu_emulator.h |   2 +
 arch/mips/include/asm/mmu.h          |  12 ++
 arch/mips/include/asm/mmu_context.h  |   7 +
 arch/mips/include/asm/processor.h    |   7 +-
 arch/mips/include/asm/thread_info.h  |   2 +
 arch/mips/kernel/entry.S             |  13 +-
 arch/mips/kernel/process.c           |   2 +
 arch/mips/kernel/vdso.c              |   2 +-
 arch/mips/math-emu/dsemul.c          | 346 ++++++++++++++++++++++++++---------
 9 files changed, 298 insertions(+), 95 deletions(-)

diff --git a/arch/mips/include/asm/fpu_emulator.h b/arch/mips/include/asm/fpu_emulator.h
index 2abb587..7aef609 100644
--- a/arch/mips/include/asm/fpu_emulator.h
+++ b/arch/mips/include/asm/fpu_emulator.h
@@ -51,6 +51,8 @@ do {									\
 #define MIPS_FPU_EMU_INC_STATS(M) do { } while (0)
 #endif /* CONFIG_DEBUG_FS */
 
+extern void dsemul_thread_cleanup(void);
+extern void dsemul_mm_cleanup(struct mm_struct *mm);
 extern int mips_dsemul(struct pt_regs *regs, mips_instruction ir,
 	unsigned long cpc);
 extern int do_dsemulret(struct pt_regs *xcp);
diff --git a/arch/mips/include/asm/mmu.h b/arch/mips/include/asm/mmu.h
index c436138..08214da 100644
--- a/arch/mips/include/asm/mmu.h
+++ b/arch/mips/include/asm/mmu.h
@@ -1,9 +1,21 @@
 #ifndef __ASM_MMU_H
 #define __ASM_MMU_H
 
+#include <linux/mutex.h>
+#include <linux/wait.h>
+
 typedef struct {
 	unsigned long asid[NR_CPUS];
 	void *vdso;
+
+	/* address of page used to hold FP branch delay emulation frames */
+	unsigned long fp_bd_emupage;
+	/* bitmap tracking allocation of fp_bd_emupage */
+	unsigned long *fp_bd_emupage_allocmap;
+	/* mutex to be held whilst modifying fp_bd_emupage(_allocmap) */
+	struct mutex fp_bd_emupage_mutex;
+	/* wait queue for threads requiring an emuframe */
+	wait_queue_head_t fp_bd_emupage_queue;
 } mm_context_t;
 
 #endif /* __ASM_MMU_H */
diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mmu_context.h
index e277bba..c55e864 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -16,6 +16,7 @@
 #include <linux/smp.h>
 #include <linux/slab.h>
 #include <asm/cacheflush.h>
+#include <asm/fpu_emulator.h>
 #include <asm/hazards.h>
 #include <asm/tlbflush.h>
 #ifdef CONFIG_MIPS_MT_SMTC
@@ -133,6 +134,11 @@ init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 	for_each_possible_cpu(i)
 		cpu_context(i, mm) = 0;
 
+	mm->context.fp_bd_emupage = 0;
+	mm->context.fp_bd_emupage_allocmap = NULL;
+	mutex_init(&mm->context.fp_bd_emupage_mutex);
+	init_waitqueue_head(&mm->context.fp_bd_emupage_queue);
+
 	return 0;
 }
 
@@ -199,6 +205,7 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
  */
 static inline void destroy_context(struct mm_struct *mm)
 {
+	dsemul_mm_cleanup(mm);
 }
 
 #define deactivate_mm(tsk, mm)	do { } while (0)
diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index 3605b84..683a3d6 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -38,9 +38,10 @@ extern unsigned int vced_count, vcei_count;
 
 /*
  * A special page (the vdso) is mapped into all processes at the very
- * top of the virtual memory space.
+ * top of the virtual memory space. The page below it is used for FP
+ * emulator branch delay slot executions.
  */
-#define SPECIAL_PAGES_SIZE PAGE_SIZE
+#define SPECIAL_PAGES_SIZE (PAGE_SIZE * 2)
 
 #ifdef CONFIG_32BIT
 #ifdef CONFIG_KVM_GUEST
@@ -226,6 +227,8 @@ struct thread_struct {
 
 	/* Saved fpu/fpu emulator stuff. */
 	struct mips_fpu_struct fpu;
+	/* PC to continue from following an FP branch delay 'emulation' */
+	unsigned long fp_bd_emu_cpc;
 #ifdef CONFIG_MIPS_MT_FPAFF
 	/* Emulated instruction count */
 	unsigned long emulated_fp;
diff --git a/arch/mips/include/asm/thread_info.h b/arch/mips/include/asm/thread_info.h
index b6da8b7..eee6e18 100644
--- a/arch/mips/include/asm/thread_info.h
+++ b/arch/mips/include/asm/thread_info.h
@@ -118,6 +118,7 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_LOAD_WATCH		25	/* If set, load watch registers */
 #define TIF_SYSCALL_TRACEPOINT	26	/* syscall tracepoint instrumentation */
 #define TIF_32BIT_FPREGS	27	/* 32-bit floating point registers */
+#define TIF_FP_BD_EMU		28	/* executing an FP branch delay */
 #define TIF_SYSCALL_TRACE	31	/* syscall trace active */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
@@ -135,6 +136,7 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_FPUBOUND		(1<<TIF_FPUBOUND)
 #define _TIF_LOAD_WATCH		(1<<TIF_LOAD_WATCH)
 #define _TIF_32BIT_FPREGS	(1<<TIF_32BIT_FPREGS)
+#define _TIF_FP_BD_EMU		(1<<TIF_FP_BD_EMU)
 #define _TIF_SYSCALL_TRACEPOINT	(1<<TIF_SYSCALL_TRACEPOINT)
 
 #define _TIF_WORK_SYSCALL_ENTRY	(_TIF_NOHZ | _TIF_SYSCALL_TRACE |	\
diff --git a/arch/mips/kernel/entry.S b/arch/mips/kernel/entry.S
index e578685..24707d7 100644
--- a/arch/mips/kernel/entry.S
+++ b/arch/mips/kernel/entry.S
@@ -168,10 +168,15 @@ work_resched:
 	andi	t0, a2, _TIF_NEED_RESCHED
 	bnez	t0, work_resched
 
-work_notifysig:				# deal with pending signals and
-					# notify-resume requests
-	move	a0, sp
-	li	a1, 0
+work_notifysig:
+	and	t0, a2, _TIF_FP_BD_EMU	# are we currently 'emulating' the
+					# delay slot of an FP branch?
+	beqz	t0, 1f			# no, continue below
+	and	a2, a2, ~_TIF_SIGPENDING	# yes, skip handling signals
+	beqz	a2, restore_all		# which leaves us nothing to do
+
+1:	move	a0, sp			# deal with pending signals and
+	li	a1, 0			# notify-resume requests
 	jal	do_notify_resume	# a2 already loaded
 	j	resume_userspace_check
 
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 747a6cf..0219502 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -32,6 +32,7 @@
 #include <asm/cpu.h>
 #include <asm/dsp.h>
 #include <asm/fpu.h>
+#include <asm/fpu_emulator.h>
 #include <asm/pgtable.h>
 #include <asm/mipsregs.h>
 #include <asm/processor.h>
@@ -72,6 +73,7 @@ void start_thread(struct pt_regs * regs, unsigned long pc, unsigned long sp)
 
 void exit_thread(void)
 {
+	dsemul_thread_cleanup();
 }
 
 void flush_thread(void)
diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
index 0f1af58..213d871 100644
--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -78,7 +78,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 
 	down_write(&mm->mmap_sem);
 
-	addr = vdso_addr(mm->start_stack);
+	addr = vdso_addr(mm->start_stack) + PAGE_SIZE;
 
 	addr = get_unmapped_area(NULL, addr, PAGE_SIZE, 0, 0);
 	if (IS_ERR_VALUE(addr)) {
diff --git a/arch/mips/math-emu/dsemul.c b/arch/mips/math-emu/dsemul.c
index 7ea622a..05b74b3 100644
--- a/arch/mips/math-emu/dsemul.c
+++ b/arch/mips/math-emu/dsemul.c
@@ -1,6 +1,8 @@
 #include <linux/compiler.h>
+#include <linux/err.h>
 #include <linux/mm.h>
 #include <linux/signal.h>
+#include <linux/slab.h>
 #include <linux/smp.h>
 
 #include <asm/asm.h>
@@ -45,52 +47,245 @@
 struct emuframe {
 	mips_instruction	emul;
 	mips_instruction	badinst;
-	mips_instruction	cookie;
-	unsigned long		epc;
 };
 
-int mips_dsemul(struct pt_regs *regs, mips_instruction ir, unsigned long cpc)
+static const int emupage_frame_count = PAGE_SIZE / sizeof(struct emuframe);
+
+static struct emuframe __user *alloc_emuframe(void)
 {
-	extern asmlinkage void handle_dsemulret(void);
-	struct emuframe __user *fr;
-	int err;
+	mm_context_t *mm_ctx = &current->mm->context;
+	struct emuframe __user *fr = NULL;
+	unsigned long addr;
+	int idx;
+
+retry:
+	mutex_lock(&mm_ctx->fp_bd_emupage_mutex);
 
-	if ((get_isa16_mode(regs->cp0_epc) && ((ir >> 16) == MM_NOP16)) ||
-		(ir == 0)) {
-		/* NOP is easy */
-		regs->cp0_epc = cpc;
-		regs->cp0_cause &= ~CAUSEF_BD;
-		return 0;
+	/* Ensure we have a page allocated for emuframes */
+	if (!mm_ctx->fp_bd_emupage) {
+		addr = mmap_region(NULL, STACK_TOP, PAGE_SIZE,
+				   VM_READ|VM_WRITE|VM_EXEC|
+				   VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
+				   0);
+		if (IS_ERR_VALUE(addr))
+			goto out_unlock;
+
+		mm_ctx->fp_bd_emupage = addr;
+		pr_debug("allocate emupage at 0x%08lx to %d\n", addr,
+			 current->pid);
 	}
-#ifdef DSEMUL_TRACE
-	printk("dsemul %lx %lx\n", regs->cp0_epc, cpc);
 
-#endif
+	/* Ensure we have an allocation bitmap */
+	if (!mm_ctx->fp_bd_emupage_allocmap) {
+		mm_ctx->fp_bd_emupage_allocmap =
+			kcalloc(BITS_TO_LONGS(emupage_frame_count),
+					      sizeof(unsigned long),
+				GFP_KERNEL);
+
+		if (!mm_ctx->fp_bd_emupage_allocmap)
+			goto out_unlock;
+	}
+
+	/* Attempt to allocate a single bit/frame */
+	idx = bitmap_find_free_region(mm_ctx->fp_bd_emupage_allocmap,
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
+		mutex_unlock(&mm_ctx->fp_bd_emupage_mutex);
+		if (!wait_event_killable(mm_ctx->fp_bd_emupage_queue,
+			!bitmap_full(mm_ctx->fp_bd_emupage_allocmap,
+				     emupage_frame_count)))
+			goto retry;
+
+		/* Received a fatal signal - just give in */
+		return NULL;
+	}
+
+	/* Success! */
+	fr = (struct emuframe __user *)mm_ctx->fp_bd_emupage + idx;
+	pr_debug("allocate emuframe %d to %d\n", idx, current->pid);
+out_unlock:
+	mutex_unlock(&mm_ctx->fp_bd_emupage_mutex);
+	return fr;
+}
+
+static void free_emuframe(struct emuframe __user *frame)
+{
+	mm_context_t *mm_ctx = &current->mm->context;
+	int idx;
+
+	mutex_lock(&mm_ctx->fp_bd_emupage_mutex);
 
+	idx = frame - (struct emuframe __user *)mm_ctx->fp_bd_emupage;
+	pr_debug("free emuframe %d from %d\n", idx, current->pid);
+	bitmap_clear(mm_ctx->fp_bd_emupage_allocmap, idx, 1);
+
+	/* If some thread is waiting for a frame, now's its chance */
+	wake_up(&mm_ctx->fp_bd_emupage_queue);
+
+	mutex_unlock(&mm_ctx->fp_bd_emupage_mutex);
+}
+
+void dsemul_thread_cleanup(void)
+{
 	/*
-	 * The strategy is to push the instruction onto the user stack
-	 * and put a trap after it which we can catch and jump to
-	 * the required address any alternative apart from full
-	 * instruction emulation!!.
+	 * We should always have passed through do_dsemulret prior to the
+	 * thread exiting, so TIF_FP_BD_EMU should never be set here.
+	 */
+	BUG_ON(test_thread_flag(TIF_FP_BD_EMU));
+}
+
+void dsemul_mm_cleanup(struct mm_struct *mm)
+{
+	mm_context_t *mm_ctx = &mm->context;
+
+	kfree(mm_ctx->fp_bd_emupage_allocmap);
+}
+
+int mips_dsemul(struct pt_regs *regs, mips_instruction ir, unsigned long cpc)
+{
+	union mips_instruction inst = { .word = ir };
+	struct emuframe __user *fr;
+	int err;
+
+	/*
+	 * In order for us to clean up the emuframe properly, we'll need to
+	 * execute a break instruction after ir. If ir is a branch then we may
+	 * never reach that break instruction and thus never free the emuframe.
+	 *
+	 * Fortunately we know that ir is in a branch delay slot and thus if
+	 * it is a branch then its operation is unpredictable. So we can just
+	 * treat branches as NOPs and skip the 'emulation' entirely.
+	 *
+	 * If the worst happens and we miss a branch/jump instruction here, or
+	 * some processor implements a custom one, then it would be possible
+	 * for us to allocate an emuframe and never free it. Fortunately this
+	 * would:
 	 *
-	 * Algorithmics used a system call instruction, and
-	 * borrowed that vector.  MIPS/Linux version is a bit
-	 * more heavyweight in the interests of portability and
-	 * multiprocessor support.  For Linux we generate a
-	 * an unaligned access and force an address error exception.
+	 *  1) Be a bug in the userland code, because it has a branch/jump in
+	 *     a branch delay slot. So if we run out of emuframes and the
+	 *     userland code hangs it's not exactly the kernels fault.
 	 *
-	 * For embedded systems (stand-alone) we prefer to use a
-	 * non-existing CP1 instruction. This prevents us from emulating
-	 * branches, but gives us a cleaner interface to the exception
-	 * handler (single entry point).
+	 *  2) Only affect that userland process, since emuframes are allocated
+	 *     per-mm and kernel threads don't use them at all.
 	 */
+	if (!get_isa16_mode(regs->cp0_epc)) {
+		if (!ir) {
+			/* typical NOP encoding: sll r0, r0, r0 */
+is_nop:
+			regs->cp0_epc = cpc;
+			regs->cp0_cause &= ~CAUSEF_BD;
+			return 0;
+		}
 
-	/* Ensure that the two instructions are in the same cache line */
-	fr = (struct emuframe __user *)
-		((regs->regs[29] - sizeof(struct emuframe)) & ~0x7);
+		switch (inst.j_format.opcode) {
+		case bcond_op:
+			switch (inst.i_format.rt) {
+			case bltz_op:
+			case bgez_op:
+			case bltzl_op:
+			case bgezl_op:
+			case bltzal_op:
+			case bgezal_op:
+			case bltzall_op:
+			case bgezall_op:
+				goto is_branch;
+			}
+			break;
 
-	/* Verify that the stack pointer is not competely insane */
-	if (unlikely(!access_ok(VERIFY_WRITE, fr, sizeof(struct emuframe))))
+		case cop1_op:
+			switch (inst.i_format.rs) {
+			case bc_op:
+				goto is_branch;
+			}
+			break;
+
+		case j_op:
+		case jal_op:
+		case beq_op:
+		case bne_op:
+		case blez_op:
+		case bgtz_op:
+		case beql_op:
+		case bnel_op:
+		case blezl_op:
+		case bgtzl_op:
+		case jalx_op:
+is_branch:
+			pr_warn("PID %d has a branch in an FP branch delay slot at 0x%08lx\n",
+				current->pid, regs->cp0_epc);
+			goto is_nop;
+		}
+	} else {
+		if ((ir >> 16) == MM_NOP16)
+			goto is_nop;
+
+		switch (inst.mm_i_format.opcode) {
+		case mm_beqz16_op:
+		case mm_beq32_op:
+		case mm_bnez16_op:
+		case mm_bne32_op:
+		case mm_b16_op:
+		case mm_j32_op:
+		case mm_jalx32_op:
+		case mm_jal32_op:
+			goto is_branch;
+
+		case mm_pool32i_op:
+			switch (inst.mm_i_format.rt) {
+			case mm_bltz_op:
+			case mm_bltzal_op:
+			case mm_bgez_op:
+			case mm_bgezal_op:
+			case mm_blez_op:
+			case mm_bnezc_op:
+			case mm_bgtz_op:
+			case mm_beqzc_op:
+			case mm_bltzals_op:
+			case mm_bgezals_op:
+			case mm_bc2f_op:
+			case mm_bc2t_op:
+			case mm_bc1f_op:
+			case mm_bc1t_op:
+				goto is_branch;
+			}
+			break;
+
+		case mm_pool16c_op:
+			switch (inst.mm16_r5_format.rt) {
+			case mm_jr16_op:
+			case mm_jrc_op:
+			case mm_jalr16_op:
+			case mm_jalrs16_op:
+			case mm_jraddiusp_op:
+				goto is_branch;
+			}
+			break;
+		}
+	}
+
+	pr_debug("dsemul 0x%08lx cont at 0x%08lx\n", regs->cp0_epc, cpc);
+
+	/*
+	 * The strategy is to write the instruction to a per-mm page followed
+	 * by a trap which we can catch to return to the required address. Any
+	 * alternative to full instruction emulation!!
+	 *
+	 * Algorithmics used a system call instruction, and borrowed that
+	 * vector.  MIPS/Linux version is a bit more heavyweight in the
+	 * interests of portability and multiprocessor support.  For Linux we
+	 * generate a BREAK instruction with a break code reserved for this
+	 * purpose.
+	 */
+	fr = alloc_emuframe();
+	if (!fr)
 		return SIGBUS;
 
 	if (get_isa16_mode(regs->cp0_epc)) {
@@ -103,17 +298,18 @@ int mips_dsemul(struct pt_regs *regs, mips_instruction ir, unsigned long cpc)
 		err |= __put_user((mips_instruction)BREAK_MATH, &fr->badinst);
 	}
 
-	err |= __put_user((mips_instruction)BD_COOKIE, &fr->cookie);
-	err |= __put_user(cpc, &fr->epc);
-
 	if (unlikely(err)) {
 		MIPS_FPU_EMU_INC_STATS(errors);
+		free_emuframe(fr);
 		return SIGBUS;
 	}
 
 	regs->cp0_epc = ((unsigned long) &fr->emul) |
 		get_isa16_mode(regs->cp0_epc);
 
+	current->thread.fp_bd_emu_cpc = cpc;
+	set_thread_flag(TIF_FP_BD_EMU);
+
 	flush_cache_sigtramp((unsigned long)&fr->badinst);
 
 	return SIGILL;		/* force out of emulation loop */
@@ -121,64 +317,38 @@ int mips_dsemul(struct pt_regs *regs, mips_instruction ir, unsigned long cpc)
 
 int do_dsemulret(struct pt_regs *xcp)
 {
-	struct emuframe __user *fr;
-	unsigned long epc;
-	u32 insn, cookie;
-	int err = 0;
-	u16 instr[2];
+	mm_context_t *mm_ctx = &current->mm->context;
+	struct emuframe __user *fr = NULL;
+	unsigned long fr_addr;
+	int success = 0;
 
-	fr = (struct emuframe __user *)
-		(msk_isa16_mode(xcp->cp0_epc) - sizeof(mips_instruction));
+	/* If we don't have TIF_FP_BD_EMU set... */
+	if (!test_and_clear_thread_flag(TIF_FP_BD_EMU))
+		goto out;
 
 	/*
-	 * If we can't even access the area, something is very wrong, but we'll
-	 * leave that to the default handling
+	 * ...or EPC is outside of the expected page or misaligned then
+	 * something is wrong. Leave it to the default trap/break code to
+	 * handle.
 	 */
-	if (!access_ok(VERIFY_READ, fr, sizeof(struct emuframe)))
-		return 0;
+	fr_addr = msk_isa16_mode(xcp->cp0_epc) - sizeof(mips_instruction);
+	if ((fr_addr < mm_ctx->fp_bd_emupage) ||
+	    (fr_addr > (mm_ctx->fp_bd_emupage + PAGE_SIZE - sizeof(*fr))) ||
+	    (fr_addr & (sizeof(*fr) - 1)))
+		goto out;
 
-	/*
-	 * Do some sanity checking on the stackframe:
-	 *
-	 *  - Is the instruction pointed to by the EPC an BREAK_MATH?
-	 *  - Is the following memory word the BD_COOKIE?
-	 */
-	if (get_isa16_mode(xcp->cp0_epc)) {
-		err = __get_user(instr[0], (u16 __user *)(&fr->badinst));
-		err |= __get_user(instr[1], (u16 __user *)((long)(&fr->badinst) + 2));
-		insn = (instr[0] << 16) | instr[1];
-	} else {
-		err = __get_user(insn, &fr->badinst);
-	}
-	err |= __get_user(cookie, &fr->cookie);
-
-	if (unlikely(err || (insn != BREAK_MATH) || (cookie != BD_COOKIE))) {
-		MIPS_FPU_EMU_INC_STATS(errors);
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
-#ifdef DSEMUL_TRACE
-	printk("dsemulret\n");
-#endif
-	if (__get_user(epc, &fr->epc)) {		/* Saved EPC */
-		/* This is not a good situation to be in */
-		force_sig(SIGBUS, current);
-
-		return 0;
-	}
+	/* At this point, we are satisfied that it's a BD emulation trap. */
+	fr = (struct emuframe __user *)fr_addr;
 
 	/* Set EPC to return to post-branch instruction */
-	xcp->cp0_epc = epc;
+	xcp->cp0_epc = current->thread.fp_bd_emu_cpc;
+	success = 1;
 
-	return 1;
+	pr_debug("dsemulret to 0x%08lx\n", xcp->cp0_epc);
+out:
+	if (fr)
+		free_emuframe(fr);
+	if (!success)
+		MIPS_FPU_EMU_INC_STATS(errors);
+	return success;
 }
-- 
1.8.4.1
