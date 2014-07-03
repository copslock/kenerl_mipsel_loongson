Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jul 2014 19:57:02 +0200 (CEST)
Received: from mail-qa0-f50.google.com ([209.85.216.50]:47575 "EHLO
        mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860317AbaGCR45TPOXE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Jul 2014 19:56:57 +0200
Received: by mail-qa0-f50.google.com with SMTP id m5so478126qaj.37
        for <linux-mips@linux-mips.org>; Thu, 03 Jul 2014 10:56:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-type;
        bh=laXfGHWxoycxrrj+Iph5pUx29ZjtC1LUZ9eXkgnHGds=;
        b=J2c3AYbhmXy6WFzfz+4a6/BiMXMLiPDMPkkVnnBKyugkGJbUIoxrto0fICEfL0iJy9
         GS+lCJik3IIgzabrAO/9lXOHFLgSjgmuxGo/ExngrnctAx14K+D4Z2phhocIdrZreece
         IfM1G78x68u//Hv/n/EHerfx0gquaGDYPVDjUBH4DZKtRId3B9LKyvDo7VaGH8oXQR+D
         jsWvkDN+sThZGDON4dBbPxg8yqqu/YEUHNZbxrv8nN+m3MtYau3vCEUrNa44gyENNW6H
         k+C3A2RHR+u8Ma1ZLq6EtGyIgswE6ZpWqEp+zLWpov5tl2OHekhLap4MvWRF+aHAjgn1
         5IUA==
X-Gm-Message-State: ALoCoQmuYDMrwirbRrh82czh9640Ny7mtgXvl+bcOPGHWdSQe2p+9w3vH1L6G9JFgNZy/oG/snIA
X-Received: by 10.224.171.195 with SMTP id i3mr10177234qaz.44.1404410210912;
 Thu, 03 Jul 2014 10:56:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.224.88.2 with HTTP; Thu, 3 Jul 2014 10:56:10 -0700 (PDT)
From:   Ed Swierk <eswierk@skyportsystems.com>
Date:   Thu, 3 Jul 2014 10:56:10 -0700
Message-ID: <CAO_EM_m8VV9RZV-zEg8MCWwKF-ymn-OTqN0=7POJKCXF8RKJbQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] mips: use per-mm page to execute FP branch delay slots
To:     linux-mips@linux-mips.org, Paul Burton <paul.burton@imgtec.com>
Cc:     ddaney.cavm@gmail.com, ralf@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <eswierk@skyportsystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41011
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eswierk@skyportsystems.com
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

Hi Paul,

I'm came across your patch while puzzling over mysterious segvs from
programs that do floating-point compares. I'm running a Debian 32-bit
mips userland, which is built with hard floating point operations, on
a Cavium Octeon2, which lacks an FPU. Now that Linux makes user stacks
non-executable by default, the current FP emulation approach is simply
broken.

Have you had the opportunity to revisit your patch in light of the
force_sig issue? I'm wondering if instead of trying to free the page
for the FP branch delay emuframe immediately, it would be simpler to
leave it around until the thread is destroyed.

--Ed

Paul Burton <paul.burton@imgtec.com> wrote:
> Hmm, I believe there may still be an issue with this patch. If the
> instruction in the branch delay slot being "emulated" traps to the
> kernel, and the kernel does a force_sig then that signal won't get
> processed because signals are being temporarily ignored. So I think
> we'd go back off to userland & execute the same instruction from the
> branch delay slot again, trap again, force_sig again, go back to
> userland etc etc. I need to think about this...
>
> In the meantime, Ralf: if you get to merging this series please drop
> this patch & 6/6 (the stack exec change) for the time being. The "Some
> (mostly FP) cleanups" series I submitted will still apply after only
> the first 4 patches of this series.
>
> Thanks,
>      Paul
>
> On 08/11/13 14:50, Paul Burton wrote:
>> If a floating point branch instruction (bc1[ft]l?) is emulated,
>> typically because we're running on a core with no FPU, then we need to
>> execute the instruction in its branch delay slot too. This is done by
>> writing that instruction to memory followed by a trap, as part of an
>> "emuframe", and executing it. This avoids the requirement of an emulator
>> for the entire MIPS instruction set. Prior to this patch such emuframes
>> are written to the user stack and executed from there.
>>
>> This patch moves FP branch delay emuframes off of the user stack and
>> into a per-mm page. Allocating a page per-mm leaves userland with access
>> to only what it had access to previously, and prevents processes
>> interfering with each other as they might if a single system-wide page
>> were used. The book-keeping required to track the allocation of
>> emuframes is not cheap, but given that invoking the FP emulator is
>> already very expensive I don't expect this to be an issue.
>>
>> The biggest issue with executing the instruction from an FP branch delay
>> is that we must ensure that we free the frame from which we ran it. That
>> means that we must trap back to the kernel after executing that
>> instruction, which means that we must take special care not to let the
>> PC be changed as a result of that instruction. Fortunately since we're
>> executing an instruction we found in a branch delay the result is
>> unpredictable if that instruction is a branch or jump, so we can simply
>> treat those as NOPs and avoid them causing a problem. However there is
>> still the possibility that a signal may be handled whilst executing the
>> branch delay instruction. This would usually be fine as we would simply
>> execute our trap back to the kernel after sigreturn, however it is
>> possible for userland to simply not return from the signal handler - for
>> example if it executes something like a longjmp. In that case we would
>> never trap back to the kernel and never free the frame. For that reason
>> a TIF_FP_BD_EMU flag is introduced and set whilst we are executing an FP
>> branch delay instruction. Whilst this flag is set, signals will be
>> ignored. This isn't exactly pretty, but it's simpler than most of the
>> alternatives. One other simple option I considered would be to just
>> kill a process if we find a branch in an FP branch delay slot, but I
>> chose the current approach because its result is closer to what would
>> previously happen.
>>
>> The primary benefit of this patch is that we are now free to mark the
>> user stack non-executable where that is possible.
>>
>> Additionally the FP emuframes themselves are simplified somewhat. The
>> cookie field is removed since we can be pretty certain that we're
>> looking at an emuframe by virtue of it being located in the page
>> allocated for them. The PC to continue from is moved into struct
>> thread_struct since the control flow of a thread can no longer be
>> modified for the duration of the 'emulation', meaning there will now
>> only ever be a single emuframe required for a thread at any given time.
>>
>> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
>> ---
>> Changes in v2:
>>    - s/kernels/kernel's/
>>    - Use (mm_)isBranchInstr in mips_dsemul rather than duplicating
>>      similar logic.
>> ---
>>   arch/mips/include/asm/fpu_emulator.h |   4 +
>>   arch/mips/include/asm/mmu.h          |  12 ++
>>   arch/mips/include/asm/mmu_context.h  |   7 +
>>   arch/mips/include/asm/processor.h    |   7 +-
>>   arch/mips/include/asm/thread_info.h  |   2 +
>>   arch/mips/kernel/entry.S             |  13 +-
>>   arch/mips/kernel/process.c           |   2 +
>>   arch/mips/kernel/vdso.c              |   2 +-
>>   arch/mips/math-emu/cp1emu.c          |   4 +-
>>   arch/mips/math-emu/dsemul.c          | 266 ++++++++++++++++++++++++-----------
>>   10 files changed, 226 insertions(+), 93 deletions(-)
>>
>> diff --git a/arch/mips/include/asm/fpu_emulator.h b/arch/mips/include/asm/fpu_emulator.h
>> index 2abb587..16f7b0b 100644
>> --- a/arch/mips/include/asm/fpu_emulator.h
>> +++ b/arch/mips/include/asm/fpu_emulator.h
>> @@ -51,6 +51,8 @@ do { \
>>   #define MIPS_FPU_EMU_INC_STATS(M) do { } while (0)
>>   #endif /* CONFIG_DEBUG_FS */
>>
>> +extern void dsemul_thread_cleanup(void);
>> +extern void dsemul_mm_cleanup(struct mm_struct *mm);
>>   extern int mips_dsemul(struct pt_regs *regs, mips_instruction ir,
>>   unsigned long cpc);
>>   extern int do_dsemulret(struct pt_regs *xcp);
>> @@ -58,6 +60,8 @@ extern int fpu_emulator_cop1Handler(struct pt_regs *xcp,
>>      struct mips_fpu_struct *ctx, int has_fpu,
>>      void *__user *fault_addr);
>>   int process_fpemu_return(int sig, void __user *fault_addr);
>> +int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
>> +  unsigned long *contpc);
>>   int mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
>>       unsigned long *contpc);
>>
>> diff --git a/arch/mips/include/asm/mmu.h b/arch/mips/include/asm/mmu.h
>> index c436138..08214da 100644
>> --- a/arch/mips/include/asm/mmu.h
>> +++ b/arch/mips/include/asm/mmu.h
>> @@ -1,9 +1,21 @@
>>   #ifndef __ASM_MMU_H
>>   #define __ASM_MMU_H
>>
>> +#include <linux/mutex.h>
>> +#include <linux/wait.h>
>> +
>>   typedef struct {
>>   unsigned long asid[NR_CPUS];
>>   void *vdso;
>> +
>> + /* address of page used to hold FP branch delay emulation frames */
>> + unsigned long fp_bd_emupage;
>> + /* bitmap tracking allocation of fp_bd_emupage */
>> + unsigned long *fp_bd_emupage_allocmap;
>> + /* mutex to be held whilst modifying fp_bd_emupage(_allocmap) */
>> + struct mutex fp_bd_emupage_mutex;
>> + /* wait queue for threads requiring an emuframe */
>> + wait_queue_head_t fp_bd_emupage_queue;
>>   } mm_context_t;
>>
>>   #endif /* __ASM_MMU_H */
>> diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mmu_context.h
>> index e277bba..c55e864 100644
>> --- a/arch/mips/include/asm/mmu_context.h
>> +++ b/arch/mips/include/asm/mmu_context.h
>> @@ -16,6 +16,7 @@
>>   #include <linux/smp.h>
>>   #include <linux/slab.h>
>>   #include <asm/cacheflush.h>
>> +#include <asm/fpu_emulator.h>
>>   #include <asm/hazards.h>
>>   #include <asm/tlbflush.h>
>>   #ifdef CONFIG_MIPS_MT_SMTC
>> @@ -133,6 +134,11 @@ init_new_context(struct task_struct *tsk, struct mm_struct *mm)
>>   for_each_possible_cpu(i)
>>   cpu_context(i, mm) = 0;
>>
>> + mm->context.fp_bd_emupage = 0;
>> + mm->context.fp_bd_emupage_allocmap = NULL;
>> + mutex_init(&mm->context.fp_bd_emupage_mutex);
>> + init_waitqueue_head(&mm->context.fp_bd_emupage_queue);
>> +
>>   return 0;
>>   }
>>
>> @@ -199,6 +205,7 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>>    */
>>   static inline void destroy_context(struct mm_struct *mm)
>>   {
>> + dsemul_mm_cleanup(mm);
>>   }
>>
>>   #define deactivate_mm(tsk, mm) do { } while (0)
>> diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
>> index 3605b84..683a3d6 100644
>> --- a/arch/mips/include/asm/processor.h
>> +++ b/arch/mips/include/asm/processor.h
>> @@ -38,9 +38,10 @@ extern unsigned int vced_count, vcei_count;
>>
>>   /*
>>    * A special page (the vdso) is mapped into all processes at the very
>> - * top of the virtual memory space.
>> + * top of the virtual memory space. The page below it is used for FP
>> + * emulator branch delay slot executions.
>>    */
>> -#define SPECIAL_PAGES_SIZE PAGE_SIZE
>> +#define SPECIAL_PAGES_SIZE (PAGE_SIZE * 2)
>>
>>   #ifdef CONFIG_32BIT
>>   #ifdef CONFIG_KVM_GUEST
>> @@ -226,6 +227,8 @@ struct thread_struct {
>>
>>   /* Saved fpu/fpu emulator stuff. */
>>   struct mips_fpu_struct fpu;
>> + /* PC to continue from following an FP branch delay 'emulation' */
>> + unsigned long fp_bd_emu_cpc;
>>   #ifdef CONFIG_MIPS_MT_FPAFF
>>   /* Emulated instruction count */
>>   unsigned long emulated_fp;
>> diff --git a/arch/mips/include/asm/thread_info.h b/arch/mips/include/asm/thread_info.h
>> index b6da8b7..eee6e18 100644
>> --- a/arch/mips/include/asm/thread_info.h
>> +++ b/arch/mips/include/asm/thread_info.h
>> @@ -118,6 +118,7 @@ static inline struct thread_info *current_thread_info(void)
>>   #define TIF_LOAD_WATCH 25 /* If set, load watch registers */
>>   #define TIF_SYSCALL_TRACEPOINT 26 /* syscall tracepoint instrumentation */
>>   #define TIF_32BIT_FPREGS 27 /* 32-bit floating point registers */
>> +#define TIF_FP_BD_EMU 28 /* executing an FP branch delay */
>>   #define TIF_SYSCALL_TRACE 31 /* syscall trace active */
>>
>>   #define _TIF_SYSCALL_TRACE (1<<TIF_SYSCALL_TRACE)
>> @@ -135,6 +136,7 @@ static inline struct thread_info *current_thread_info(void)
>>   #define _TIF_FPUBOUND (1<<TIF_FPUBOUND)
>>   #define _TIF_LOAD_WATCH (1<<TIF_LOAD_WATCH)
>>   #define _TIF_32BIT_FPREGS (1<<TIF_32BIT_FPREGS)
>> +#define _TIF_FP_BD_EMU (1<<TIF_FP_BD_EMU)
>>   #define _TIF_SYSCALL_TRACEPOINT (1<<TIF_SYSCALL_TRACEPOINT)
>>
>>   #define _TIF_WORK_SYSCALL_ENTRY (_TIF_NOHZ | _TIF_SYSCALL_TRACE | \
>> diff --git a/arch/mips/kernel/entry.S b/arch/mips/kernel/entry.S
>> index e578685..24707d7 100644
>> --- a/arch/mips/kernel/entry.S
>> +++ b/arch/mips/kernel/entry.S
>> @@ -168,10 +168,15 @@ work_resched:
>>   andi t0, a2, _TIF_NEED_RESCHED
>>   bnez t0, work_resched
>>
>> -work_notifysig: # deal with pending signals and
>> - # notify-resume requests
>> - move a0, sp
>> - li a1, 0
>> +work_notifysig:
>> + and t0, a2, _TIF_FP_BD_EMU # are we currently 'emulating' the
>> + # delay slot of an FP branch?
>> + beqz t0, 1f # no, continue below
>> + and a2, a2, ~_TIF_SIGPENDING # yes, skip handling signals
>> + beqz a2, restore_all # which leaves us nothing to do
>> +
>> +1: move a0, sp # deal with pending signals and
>> + li a1, 0 # notify-resume requests
>>   jal do_notify_resume # a2 already loaded
>>   j resume_userspace_check
>>
>> diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
>> index 747a6cf..0219502 100644
>> --- a/arch/mips/kernel/process.c
>> +++ b/arch/mips/kernel/process.c
>> @@ -32,6 +32,7 @@
>>   #include <asm/cpu.h>
>>   #include <asm/dsp.h>
>>   #include <asm/fpu.h>
>> +#include <asm/fpu_emulator.h>
>>   #include <asm/pgtable.h>
>>   #include <asm/mipsregs.h>
>>   #include <asm/processor.h>
>> @@ -72,6 +73,7 @@ void start_thread(struct pt_regs * regs, unsigned long pc, unsigned long sp)
>>
>>   void exit_thread(void)
>>   {
>> + dsemul_thread_cleanup();
>>   }
>>
>>   void flush_thread(void)
>> diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
>> index 0f1af58..213d871 100644
>> --- a/arch/mips/kernel/vdso.c
>> +++ b/arch/mips/kernel/vdso.c
>> @@ -78,7 +78,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
>>
>>   down_write(&mm->mmap_sem);
>>
>> - addr = vdso_addr(mm->start_stack);
>> + addr = vdso_addr(mm->start_stack) + PAGE_SIZE;
>>
>>   addr = get_unmapped_area(NULL, addr, PAGE_SIZE, 0, 0);
>>   if (IS_ERR_VALUE(addr)) {
>> diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
>> index 22f7b11..a0566c8 100644
>> --- a/arch/mips/math-emu/cp1emu.c
>> +++ b/arch/mips/math-emu/cp1emu.c
>> @@ -665,8 +665,8 @@ int mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
>>    * a single subroutine should be used across both
>>    * modules.
>>    */
>> -static int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
>> - unsigned long *contpc)
>> +int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
>> +  unsigned long *contpc)
>>   {
>>   union mips_instruction insn = (union mips_instruction)dec_insn.insn;
>>   unsigned int fcr31;
>> diff --git a/arch/mips/math-emu/dsemul.c b/arch/mips/math-emu/dsemul.c
>> index 7ea622a..3e64b17 100644
>> --- a/arch/mips/math-emu/dsemul.c
>> +++ b/arch/mips/math-emu/dsemul.c
>> @@ -1,6 +1,8 @@
>>   #include <linux/compiler.h>
>> +#include <linux/err.h>
>>   #include <linux/mm.h>
>>   #include <linux/signal.h>
>> +#include <linux/slab.h>
>>   #include <linux/smp.h>
>>
>>   #include <asm/asm.h>
>> @@ -45,52 +47,173 @@
>>   struct emuframe {
>>   mips_instruction emul;
>>   mips_instruction badinst;
>> - mips_instruction cookie;
>> - unsigned long epc;
>>   };
>>
>> +static const int emupage_frame_count = PAGE_SIZE / sizeof(struct emuframe);
>> +
>> +static struct emuframe __user *alloc_emuframe(void)
>> +{
>> + mm_context_t *mm_ctx = &current->mm->context;
>> + struct emuframe __user *fr = NULL;
>> + unsigned long addr;
>> + int idx;
>> +
>> +retry:
>> + mutex_lock(&mm_ctx->fp_bd_emupage_mutex);
>> +
>> + /* Ensure we have a page allocated for emuframes */
>> + if (!mm_ctx->fp_bd_emupage) {
>> + addr = mmap_region(NULL, STACK_TOP, PAGE_SIZE,
>> +   VM_READ|VM_WRITE|VM_EXEC|
>> +   VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
>> +   0);
>> + if (IS_ERR_VALUE(addr))
>> + goto out_unlock;
>> +
>> + mm_ctx->fp_bd_emupage = addr;
>> + pr_debug("allocate emupage at 0x%08lx to %d\n", addr,
>> + current->pid);
>> + }
>> +
>> + /* Ensure we have an allocation bitmap */
>> + if (!mm_ctx->fp_bd_emupage_allocmap) {
>> + mm_ctx->fp_bd_emupage_allocmap =
>> + kcalloc(BITS_TO_LONGS(emupage_frame_count),
>> +      sizeof(unsigned long),
>> + GFP_KERNEL);
>> +
>> + if (!mm_ctx->fp_bd_emupage_allocmap)
>> + goto out_unlock;
>> + }
>> +
>> + /* Attempt to allocate a single bit/frame */
>> + idx = bitmap_find_free_region(mm_ctx->fp_bd_emupage_allocmap,
>> +      emupage_frame_count, 0);
>> + if (idx < 0) {
>> + /*
>> + * Failed to allocate a frame. We'll wait until one becomes
>> + * available. The mutex is unlocked so that other threads
>> + * actually get the opportunity to free their frames, which
>> + * means technically the result of bitmap_full may be incorrect.
>> + * However the worst case is that we repeat all this and end up
>> + * back here again.
>> + */
>> + mutex_unlock(&mm_ctx->fp_bd_emupage_mutex);
>> + if (!wait_event_killable(mm_ctx->fp_bd_emupage_queue,
>> + !bitmap_full(mm_ctx->fp_bd_emupage_allocmap,
>> +     emupage_frame_count)))
>> + goto retry;
>> +
>> + /* Received a fatal signal - just give in */
>> + return NULL;
>> + }
>> +
>> + /* Success! */
>> + fr = (struct emuframe __user *)mm_ctx->fp_bd_emupage + idx;
>> + pr_debug("allocate emuframe %d to %d\n", idx, current->pid);
>> +out_unlock:
>> + mutex_unlock(&mm_ctx->fp_bd_emupage_mutex);
>> + return fr;
>> +}
>> +
>> +static void free_emuframe(struct emuframe __user *frame)
>> +{
>> + mm_context_t *mm_ctx = &current->mm->context;
>> + int idx;
>> +
>> + mutex_lock(&mm_ctx->fp_bd_emupage_mutex);
>> +
>> + idx = frame - (struct emuframe __user *)mm_ctx->fp_bd_emupage;
>> + pr_debug("free emuframe %d from %d\n", idx, current->pid);
>> + bitmap_clear(mm_ctx->fp_bd_emupage_allocmap, idx, 1);
>> +
>> + /* If some thread is waiting for a frame, now's its chance */
>> + wake_up(&mm_ctx->fp_bd_emupage_queue);
>> +
>> + mutex_unlock(&mm_ctx->fp_bd_emupage_mutex);
>> +}
>> +
>> +void dsemul_thread_cleanup(void)
>> +{
>> + /*
>> + * We should always have passed through do_dsemulret prior to the
>> + * thread exiting, so TIF_FP_BD_EMU should never be set here.
>> + */
>> + BUG_ON(test_thread_flag(TIF_FP_BD_EMU));
>> +}
>> +
>> +void dsemul_mm_cleanup(struct mm_struct *mm)
>> +{
>> + mm_context_t *mm_ctx = &mm->context;
>> +
>> + kfree(mm_ctx->fp_bd_emupage_allocmap);
>> +}
>> +
>>   int mips_dsemul(struct pt_regs *regs, mips_instruction ir, unsigned long cpc)
>>   {
>> - extern asmlinkage void handle_dsemulret(void);
>> + struct mm_decoded_insn mm_inst = { .insn = ir };
>>   struct emuframe __user *fr;
>> - int err;
>> + struct pt_regs dummy_regs;
>> + unsigned long dummy_cpc;
>> + int err, is_mm;
>>
>> - if ((get_isa16_mode(regs->cp0_epc) && ((ir >> 16) == MM_NOP16)) ||
>> - (ir == 0)) {
>> - /* NOP is easy */
>> + /*
>> + * Trivially handle typical NOP encodings:
>> + *
>> + *   MIPS32: sll r0, r0, r0
>> + *   microMIPS: move16 r0, r0
>> + */
>> + is_mm = get_isa16_mode(regs->cp0_epc);
>> + if ((!is_mm && !ir) || (is_mm && ((ir >> 16) == MM_NOP16))) {
>> +is_nop:
>>   regs->cp0_epc = cpc;
>>   regs->cp0_cause &= ~CAUSEF_BD;
>>   return 0;
>>   }
>> -#ifdef DSEMUL_TRACE
>> - printk("dsemul %lx %lx\n", regs->cp0_epc, cpc);
>> -
>> -#endif
>>
>>   /*
>> - * The strategy is to push the instruction onto the user stack
>> - * and put a trap after it which we can catch and jump to
>> - * the required address any alternative apart from full
>> - * instruction emulation!!.
>> + * In order for us to clean up the emuframe properly, we'll need to
>> + * execute a break instruction after ir. If ir is a branch then we may
>> + * never reach that break instruction and thus never free the emuframe.
>>   *
>> - * Algorithmics used a system call instruction, and
>> - * borrowed that vector.  MIPS/Linux version is a bit
>> - * more heavyweight in the interests of portability and
>> - * multiprocessor support.  For Linux we generate a
>> - * an unaligned access and force an address error exception.
>> + * Fortunately we know that ir is in a branch delay slot and thus if
>> + * it is a branch then its operation is unpredictable. So we can just
>> + * treat branches as NOPs and skip the 'emulation' entirely.
>>   *
>> - * For embedded systems (stand-alone) we prefer to use a
>> - * non-existing CP1 instruction. This prevents us from emulating
>> - * branches, but gives us a cleaner interface to the exception
>> - * handler (single entry point).
>> + * If the worst happens and we miss a branch/jump instruction here, or
>> + * some processor implements a custom one, then it would be possible
>> + * for us to allocate an emuframe and never free it. Fortunately this
>> + * would:
>> + *
>> + *  1) Be a bug in the userland code, because it has a branch/jump in
>> + *     a branch delay slot. So if we run out of emuframes and the
>> + *     userland code hangs it's not exactly the kernel's fault.
>> + *
>> + *  2) Only affect that userland process, since emuframes are allocated
>> + *     per-mm and kernel threads don't use them at all.
>>   */
>> + if ((!is_mm && isBranchInstr(&dummy_regs, mm_inst, &dummy_cpc)) ||
>> +    (is_mm && mm_isBranchInstr(&dummy_regs, mm_inst, &dummy_cpc))) {
>> + pr_warn("PID %d has a branch in an FP branch delay slot at 0x%08lx\n",
>> + current->pid, regs->cp0_epc);
>> + goto is_nop;
>> + }
>>
>> - /* Ensure that the two instructions are in the same cache line */
>> - fr = (struct emuframe __user *)
>> - ((regs->regs[29] - sizeof(struct emuframe)) & ~0x7);
>> + pr_debug("dsemul 0x%08lx cont at 0x%08lx\n", regs->cp0_epc, cpc);
>>
>> - /* Verify that the stack pointer is not competely insane */
>> - if (unlikely(!access_ok(VERIFY_WRITE, fr, sizeof(struct emuframe))))
>> + /*
>> + * The strategy is to write the instruction to a per-mm page followed
>> + * by a trap which we can catch to return to the required address. Any
>> + * alternative to full instruction emulation!!
>> + *
>> + * Algorithmics used a system call instruction, and borrowed that
>> + * vector.  MIPS/Linux version is a bit more heavyweight in the
>> + * interests of portability and multiprocessor support.  For Linux we
>> + * generate a BREAK instruction with a break code reserved for this
>> + * purpose.
>> + */
>> + fr = alloc_emuframe();
>> + if (!fr)
>>   return SIGBUS;
>>
>>   if (get_isa16_mode(regs->cp0_epc)) {
>> @@ -103,17 +226,18 @@ int mips_dsemul(struct pt_regs *regs, mips_instruction ir, unsigned long cpc)
>>   err |= __put_user((mips_instruction)BREAK_MATH, &fr->badinst);
>>   }
>>
>> - err |= __put_user((mips_instruction)BD_COOKIE, &fr->cookie);
>> - err |= __put_user(cpc, &fr->epc);
>> -
>>   if (unlikely(err)) {
>>   MIPS_FPU_EMU_INC_STATS(errors);
>> + free_emuframe(fr);
>>   return SIGBUS;
>>   }
>>
>>   regs->cp0_epc = ((unsigned long) &fr->emul) |
>>   get_isa16_mode(regs->cp0_epc);
>>
>> + current->thread.fp_bd_emu_cpc = cpc;
>> + set_thread_flag(TIF_FP_BD_EMU);
>> +
>>   flush_cache_sigtramp((unsigned long)&fr->badinst);
>>
>>   return SIGILL; /* force out of emulation loop */
>> @@ -121,64 +245,38 @@ int mips_dsemul(struct pt_regs *regs, mips_instruction ir, unsigned long cpc)
>>
>>   int do_dsemulret(struct pt_regs *xcp)
>>   {
>> - struct emuframe __user *fr;
>> - unsigned long epc;
>> - u32 insn, cookie;
>> - int err = 0;
>> - u16 instr[2];
>> -
>> - fr = (struct emuframe __user *)
>> - (msk_isa16_mode(xcp->cp0_epc) - sizeof(mips_instruction));
>> -
>> - /*
>> - * If we can't even access the area, something is very wrong, but we'll
>> - * leave that to the default handling
>> - */
>> - if (!access_ok(VERIFY_READ, fr, sizeof(struct emuframe)))
>> - return 0;
>> -
>> - /*
>> - * Do some sanity checking on the stackframe:
>> - *
>> - *  - Is the instruction pointed to by the EPC an BREAK_MATH?
>> - *  - Is the following memory word the BD_COOKIE?
>> - */
>> - if (get_isa16_mode(xcp->cp0_epc)) {
>> - err = __get_user(instr[0], (u16 __user *)(&fr->badinst));
>> - err |= __get_user(instr[1], (u16 __user *)((long)(&fr->badinst) + 2));
>> - insn = (instr[0] << 16) | instr[1];
>> - } else {
>> - err = __get_user(insn, &fr->badinst);
>> - }
>> - err |= __get_user(cookie, &fr->cookie);
>> + mm_context_t *mm_ctx = &current->mm->context;
>> + struct emuframe __user *fr = NULL;
>> + unsigned long fr_addr;
>> + int success = 0;
>>
>> - if (unlikely(err || (insn != BREAK_MATH) || (cookie != BD_COOKIE))) {
>> - MIPS_FPU_EMU_INC_STATS(errors);
>> - return 0;
>> - }
>> + /* If we don't have TIF_FP_BD_EMU set... */
>> + if (!test_and_clear_thread_flag(TIF_FP_BD_EMU))
>> + goto out;
>>
>>   /*
>> - * At this point, we are satisfied that it's a BD emulation trap.  Yes,
>> - * a user might have deliberately put two malformed and useless
>> - * instructions in a row in his program, in which case he's in for a
>> - * nasty surprise - the next instruction will be treated as a
>> - * continuation address!  Alas, this seems to be the only way that we
>> - * can handle signals, recursion, and longjmps() in the context of
>> - * emulating the branch delay instruction.
>> + * ...or EPC is outside of the expected page or misaligned then
>> + * something is wrong. Leave it to the default trap/break code to
>> + * handle.
>>   */
>> + fr_addr = msk_isa16_mode(xcp->cp0_epc) - sizeof(mips_instruction);
>> + if ((fr_addr < mm_ctx->fp_bd_emupage) ||
>> +    (fr_addr > (mm_ctx->fp_bd_emupage + PAGE_SIZE - sizeof(*fr))) ||
>> +    (fr_addr & (sizeof(*fr) - 1)))
>> + goto out;
>>
>> -#ifdef DSEMUL_TRACE
>> - printk("dsemulret\n");
>> -#endif
>> - if (__get_user(epc, &fr->epc)) { /* Saved EPC */
>> - /* This is not a good situation to be in */
>> - force_sig(SIGBUS, current);
>> -
>> - return 0;
>> - }
>> + /* At this point, we are satisfied that it's a BD emulation trap. */
>> + fr = (struct emuframe __user *)fr_addr;
>>
>>   /* Set EPC to return to post-branch instruction */
>> - xcp->cp0_epc = epc;
>> + xcp->cp0_epc = current->thread.fp_bd_emu_cpc;
>> + success = 1;
>>
>> - return 1;
>> + pr_debug("dsemulret to 0x%08lx\n", xcp->cp0_epc);
>> +out:
>> + if (fr)
>> + free_emuframe(fr);
>> + if (!success)
>> + MIPS_FPU_EMU_INC_STATS(errors);
>> + return success;
>>   }
>>
