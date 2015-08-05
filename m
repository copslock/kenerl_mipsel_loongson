Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Aug 2015 01:49:57 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:56416 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012622AbbHEXtigogW1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Aug 2015 01:49:38 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id D9F626F95C4DB;
        Thu,  6 Aug 2015 00:49:26 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 6 Aug
 2015 00:49:31 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.235.1; Thu, 6 Aug
 2015 00:49:30 +0100
Received: from [127.0.1.1] (10.20.3.79) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Wed, 5 Aug 2015
 16:49:27 -0700
Subject: [PATCH v4 2/3] MIPS: Setup an instruction emulation in VDSO
 protected page instead of user stack
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
To:     <daniel.sanders@imgtec.com>, <linux-mips@linux-mips.org>,
        <cernekee@gmail.com>, <Zubair.Kakakhel@imgtec.com>,
        <geert+renesas@glider.be>, <david.daney@cavium.com>,
        <peterz@infradead.org>, <heiko.carstens@de.ibm.com>,
        <paul.gortmaker@windriver.com>, <behanw@converseincode.com>,
        <macro@linux-mips.org>, <cl@linux.com>, <pkarat@mvista.com>,
        <linux@roeck-us.net>, <tkhai@yandex.ru>, <james.hogan@imgtec.com>,
        <alexinbeijing@gmail.com>, <rusty@rustcorp.com.au>,
        <Steven.Hill@imgtec.com>, <lars.persson@axis.com>,
        <aleksey.makarov@auriga.com>, <paul.burton@imgtec.com>,
        <linux-kernel@vger.kernel.org>, <ralf@linux-mips.org>,
        <luto@amacapital.net>, <dahi@linux.vnet.ibm.com>,
        <markos.chandras@imgtec.com>, <eunb.song@samsung.com>,
        <kumba@gentoo.org>
Date:   Wed, 5 Aug 2015 16:49:28 -0700
Message-ID: <20150805234928.20722.61455.stgit@ubuntu-yegoshin>
In-Reply-To: <20150805234348.20722.71740.stgit@ubuntu-yegoshin>
References: <20150805234348.20722.71740.stgit@ubuntu-yegoshin>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.3.79]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48630
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

Historically, during FPU emulation MIPS runs live BD-slot instruction in stack.
This is needed because it was the only way to correctly handle branch
exceptions with unknown COP2 or ASE instructions in BD-slot. Now there is
an eXecuteInhibit feature and it is desirable to protect stack from execution
for security reasons.
This patch moves FPU emulation from stack area to VDSO-located page which is set
write-protected for application access. VDSO page itself is now per-thread and
it's addresses and offsets are stored in thread_info.
Small stack of emulation blocks is supported because nested traps are possible
in MIPS32/64 R6 emulation mix with FPU emulation.
Signal happend during run in emulation block is handled properly - EPC is
changed to before an emulated jump or to target address, depending from point of
signal.

Explanation of problem (current state before patch):

If I set eXecute-disabled stack in ELF binary initialisation then GLIBC ignores
it and may change stack protection at library load. If this library has
eXecute-disabled stack then anything is OK, but if this section (PT_GNU_STACK)
is just missed as usual, then GLIBC applies it's own default == eXecute-enabled
stack.
So, ssh_keygen is built explicitly with eXecute-disabled stack. But GLIBC
ignores it and set stack executable. And because of that - anything works,
FPU emulation and hacker tools.
However, if I use all *.SO libraries with eXecute-disabled stack in PT_GNU_STACK
section then GLIBC keeps stack non-executable but things fails at FPU emulation
later.

Here are two issues which are bind together and to solve an incorrect
behaviour of GLIBC (ignoring X ssh-keygen intention) the split of both issues
is needed. So, I did a kernel emulation protected and out of stack.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
---
 arch/mips/include/asm/fpu_emulator.h  |    2 
 arch/mips/include/asm/mmu.h           |    3 +
 arch/mips/include/asm/processor.h     |    2 
 arch/mips/include/asm/switch_to.h     |   14 +++
 arch/mips/include/asm/thread_info.h   |    3 +
 arch/mips/include/asm/tlbmisc.h       |    1 
 arch/mips/include/asm/vdso.h          |    3 +
 arch/mips/kernel/mips-r2-to-r6-emul.c |   10 +-
 arch/mips/kernel/process.c            |    7 ++
 arch/mips/kernel/signal.c             |    4 +
 arch/mips/kernel/vdso.c               |   44 +++++++++
 arch/mips/math-emu/cp1emu.c           |    8 +-
 arch/mips/math-emu/dsemul.c           |  154 +++++++++++++++++++++++++++------
 arch/mips/mm/fault.c                  |    5 +
 arch/mips/mm/tlb-r4k.c                |   42 +++++++++
 15 files changed, 267 insertions(+), 35 deletions(-)

diff --git a/arch/mips/include/asm/fpu_emulator.h b/arch/mips/include/asm/fpu_emulator.h
index 2f021cdfba4f..0c8d1191fa44 100644
--- a/arch/mips/include/asm/fpu_emulator.h
+++ b/arch/mips/include/asm/fpu_emulator.h
@@ -61,7 +61,7 @@ do {									\
 #endif /* CONFIG_DEBUG_FS */
 
 extern int mips_dsemul(struct pt_regs *regs, mips_instruction ir,
-	unsigned long cpc);
+	unsigned long cpc, unsigned long bpc, unsigned long r31);
 extern int do_dsemulret(struct pt_regs *xcp);
 extern int fpu_emulator_cop1Handler(struct pt_regs *xcp,
 				    struct mips_fpu_struct *ctx, int has_fpu,
diff --git a/arch/mips/include/asm/mmu.h b/arch/mips/include/asm/mmu.h
index 1afa1f986df8..8d2ce4d34005 100644
--- a/arch/mips/include/asm/mmu.h
+++ b/arch/mips/include/asm/mmu.h
@@ -5,7 +5,10 @@
 
 typedef struct {
 	unsigned long asid[NR_CPUS];
+	unsigned long vdso_asid[NR_CPUS];
+	struct page   *vdso_page[NR_CPUS];
 	void *vdso;
+	struct vm_area_struct   *vdso_vma;
 	atomic_t fp_mode_switching;
 } mm_context_t;
 
diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index 59ee6dcf6eed..cfe2e686bf9e 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -40,7 +40,7 @@ extern unsigned int vced_count, vcei_count;
  * A special page (the vdso) is mapped into all processes at the very
  * top of the virtual memory space.
  */
-#define SPECIAL_PAGES_SIZE PAGE_SIZE
+#define SPECIAL_PAGES_SIZE (PAGE_SIZE * 2)
 
 #ifdef CONFIG_32BIT
 #ifdef CONFIG_KVM_GUEST
diff --git a/arch/mips/include/asm/switch_to.h b/arch/mips/include/asm/switch_to.h
index 9733cd0266e4..d78469c68eef 100644
--- a/arch/mips/include/asm/switch_to.h
+++ b/arch/mips/include/asm/switch_to.h
@@ -17,6 +17,7 @@
 #include <asm/dsp.h>
 #include <asm/cop2.h>
 #include <asm/msa.h>
+#include <asm/mmu_context.h>
 
 struct task_struct;
 
@@ -83,6 +84,18 @@ do {	if (cpu_has_rw_llb) {						\
 	}								\
 } while (0)
 
+static inline void flush_vdso_page(void)
+{
+	int cpu = raw_smp_processor_id();
+
+	if (current->mm && cpu_context(cpu, current->mm) &&
+	    (current->mm->context.vdso_page[cpu] != current_thread_info()->vdso_page) &&
+	    (current->mm->context.vdso_asid[cpu] == cpu_asid(cpu, current->mm))) {
+		local_flush_tlb_page(current->mm->mmap, (unsigned long)current->mm->context.vdso);
+		current->mm->context.vdso_asid[cpu] = 0;
+	}
+}
+
 /*
  * For newly created kernel threads switch_to() will return to
  * ret_from_kernel_thread, newly created user threads to ret_from_fork.
@@ -117,6 +130,7 @@ do {									\
 		__fpsave = FP_SAVE_VECTOR;				\
 	if (cpu_has_userlocal)						\
 		write_c0_userlocal(task_thread_info(next)->tp_value);	\
+	flush_vdso_page();                                              \
 	__restore_watch();						\
 	disable_msa();							\
 	(last) = resume(prev, next, task_thread_info(next), __fpsave);	\
diff --git a/arch/mips/include/asm/thread_info.h b/arch/mips/include/asm/thread_info.h
index e309d8fcb516..e449b4ddb14f 100644
--- a/arch/mips/include/asm/thread_info.h
+++ b/arch/mips/include/asm/thread_info.h
@@ -33,6 +33,8 @@ struct thread_info {
 						 * 0x7fffffff for user-thead
 						 * 0xffffffff for kernel-thread
 						 */
+	unsigned long           vdso_offset;
+	struct page             *vdso_page;
 	struct pt_regs		*regs;
 	long			syscall;	/* syscall number */
 };
@@ -47,6 +49,7 @@ struct thread_info {
 	.cpu		= 0,			\
 	.preempt_count	= INIT_PREEMPT_COUNT,	\
 	.addr_limit	= KERNEL_DS,		\
+	.vdso_page      = NULL,                 \
 }
 
 #define init_thread_info	(init_thread_union.thread_info)
diff --git a/arch/mips/include/asm/tlbmisc.h b/arch/mips/include/asm/tlbmisc.h
index 3a452282cba0..abd7bf6ac2c6 100644
--- a/arch/mips/include/asm/tlbmisc.h
+++ b/arch/mips/include/asm/tlbmisc.h
@@ -6,5 +6,6 @@
  */
 extern void add_wired_entry(unsigned long entrylo0, unsigned long entrylo1,
 	unsigned long entryhi, unsigned long pagemask);
+int install_vdso_tlb(void);
 
 #endif /* __ASM_TLBMISC_H */
diff --git a/arch/mips/include/asm/vdso.h b/arch/mips/include/asm/vdso.h
index cca56aa40ff4..77056fc38df6 100644
--- a/arch/mips/include/asm/vdso.h
+++ b/arch/mips/include/asm/vdso.h
@@ -11,6 +11,9 @@
 
 #include <linux/types.h>
 
+void mips_thread_vdso(struct thread_info *ti);
+void arch_release_thread_info(struct thread_info *info);
+void vdso_epc_adjust(struct pt_regs *xcp);
 
 #ifdef CONFIG_32BIT
 struct mips_vdso {
diff --git a/arch/mips/kernel/mips-r2-to-r6-emul.c b/arch/mips/kernel/mips-r2-to-r6-emul.c
index f2977f00911b..040842a3aec4 100644
--- a/arch/mips/kernel/mips-r2-to-r6-emul.c
+++ b/arch/mips/kernel/mips-r2-to-r6-emul.c
@@ -245,6 +245,7 @@ static int jr_func(struct pt_regs *regs, u32 ir)
 {
 	int err;
 	unsigned long cepc, epc, nepc;
+	unsigned long r31;
 	u32 nir;
 
 	if (delay_slot(regs))
@@ -255,6 +256,7 @@ static int jr_func(struct pt_regs *regs, u32 ir)
 	/* Roll back to the reserved R2 JR instruction */
 	regs->cp0_epc -= 4;
 	epc = regs->cp0_epc;
+	r31 = regs->regs[31];
 	err = __compute_return_epc(regs);
 
 	if (err < 0)
@@ -281,7 +283,7 @@ static int jr_func(struct pt_regs *regs, u32 ir)
 		err = mipsr6_emul(regs, nir);
 		if (err > 0) {
 			regs->cp0_epc = nepc;
-			err = mips_dsemul(regs, nir, cepc);
+			err = mips_dsemul(regs, nir, cepc, epc, r31);
 			if (err == SIGILL)
 				err = SIGEMT;
 			MIPS_R2_STATS(dsemul);
@@ -1031,7 +1033,7 @@ repeat:
 			if (nir) {
 				err = mipsr6_emul(regs, nir);
 				if (err > 0) {
-					err = mips_dsemul(regs, nir, cpc);
+					err = mips_dsemul(regs, nir, cpc, epc, r31);
 					if (err == SIGILL)
 						err = SIGEMT;
 					MIPS_R2_STATS(dsemul);
@@ -1080,7 +1082,7 @@ repeat:
 			if (nir) {
 				err = mipsr6_emul(regs, nir);
 				if (err > 0) {
-					err = mips_dsemul(regs, nir, cpc);
+					err = mips_dsemul(regs, nir, cpc, epc, r31);
 					if (err == SIGILL)
 						err = SIGEMT;
 					MIPS_R2_STATS(dsemul);
@@ -1147,7 +1149,7 @@ repeat:
 		if (nir) {
 			err = mipsr6_emul(regs, nir);
 			if (err > 0) {
-				err = mips_dsemul(regs, nir, cpc);
+				err = mips_dsemul(regs, nir, cpc, epc, r31);
 				if (err == SIGILL)
 					err = SIGEMT;
 				MIPS_R2_STATS(dsemul);
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index f2975d4d1e44..cbbb4430cf1d 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -44,6 +44,7 @@
 #include <asm/inst.h>
 #include <asm/stacktrace.h>
 #include <asm/irq_regs.h>
+#include <asm/vdso.h>
 
 #ifdef CONFIG_HOTPLUG_CPU
 void arch_cpu_idle_dead(void)
@@ -61,6 +62,8 @@ void start_thread(struct pt_regs * regs, unsigned long pc, unsigned long sp)
 {
 	unsigned long status;
 
+	mips_thread_vdso(current_thread_info());
+
 	/* New thread loses kernel privileges. */
 	status = regs->cp0_status & ~(ST0_CU0|ST0_CU1|ST0_FR|KU_MASK);
 	status |= KU_USER;
@@ -77,6 +80,7 @@ void start_thread(struct pt_regs * regs, unsigned long pc, unsigned long sp)
 
 void exit_thread(void)
 {
+	arch_release_thread_info(current_thread_info());
 }
 
 void flush_thread(void)
@@ -120,6 +124,9 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 
 	childksp = (unsigned long)task_stack_page(p) + THREAD_SIZE - 32;
 
+	ti->vdso_page = NULL;
+	mips_thread_vdso(ti);
+
 	/* set up new TSS. */
 	childregs = (struct pt_regs *) childksp - 1;
 	/*  Put the stack after the struct pt_regs.  */
diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 2fec67bfc457..e88e164da5bb 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -800,6 +800,10 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 		regs->regs[0] = 0;		/* Don't deal with this again.	*/
 	}
 
+	/* adjust emulation stack if signal happens during emulation */
+	if (current_thread_info()->vdso_page)
+		vdso_epc_adjust(regs);
+
 	if (sig_uses_siginfo(&ksig->ka))
 		ret = abi->setup_rt_frame(vdso + abi->rt_signal_return_offset,
 					  ksig, regs, oldset);
diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
index ed2a278722a9..ecc884e051a4 100644
--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -21,6 +21,8 @@
 #include <asm/vdso.h>
 #include <asm/uasm.h>
 #include <asm/processor.h>
+#include <asm/cacheflush.h>
+#include <asm/tlbflush.h>
 
 /*
  * Including <asm/unistd.h> would give use the 64-bit syscall numbers ...
@@ -101,14 +103,18 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 
 	ret = install_special_mapping(mm, addr, PAGE_SIZE,
 				      VM_READ|VM_EXEC|
-				      VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
+				      VM_MAYREAD|VM_MAYEXEC,
 				      &vdso_page);
 
 	if (ret)
 		goto up_fail;
 
 	mm->context.vdso = (void *)addr;
+	/* if cache aliasing - use a different cache flush later */
+	if (cpu_has_rixi && cpu_has_dc_aliases)
+		mm->context.vdso_vma = find_vma(mm,addr);
 
+	mips_thread_vdso(current_thread_info());
 up_fail:
 	up_write(&mm->mmap_sem);
 	return ret;
@@ -120,3 +126,39 @@ const char *arch_vma_name(struct vm_area_struct *vma)
 		return "[vdso]";
 	return NULL;
 }
+
+void mips_thread_vdso(struct thread_info *ti)
+{
+	struct page *vdso;
+	unsigned long addr;
+
+	if (cpu_has_rixi && ti->task->mm && !ti->vdso_page) {
+		vdso = alloc_page(GFP_USER);
+		if (!vdso)
+			return;
+		ti->vdso_page = vdso;
+		ti->vdso_offset = PAGE_SIZE;
+		addr = (unsigned long)page_address(vdso);
+		copy_page((void *)addr, (void *)page_address(vdso_page));
+		if (!cpu_has_ic_fills_f_dc)
+			flush_data_cache_page(addr);
+		/* any vma in mmap is used, just to get ASIDs back from mm */
+		local_flush_tlb_page(ti->task->mm->mmap,
+				    (unsigned long)ti->task->mm->context.vdso);
+	}
+}
+
+void arch_release_thread_info(struct thread_info *info)
+{
+	if (info->vdso_page) {
+		if (info->task->mm) {
+			preempt_disable();
+			/* any vma in mmap is used, just to get ASIDs */
+			local_flush_tlb_page(info->task->mm->mmap,(unsigned long)info->task->mm->context.vdso);
+			info->task->mm->context.vdso_asid[smp_processor_id()] = 0;
+			preempt_enable();
+		}
+		__free_page(info->vdso_page);
+		info->vdso_page = NULL;
+	}
+}
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 8a5b0eb4ddef..ba91d4d01406 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -973,6 +973,8 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 		struct mm_decoded_insn dec_insn, void *__user *fault_addr)
 {
 	unsigned long contpc = xcp->cp0_epc + dec_insn.pc_inc;
+	unsigned long r31;
+	unsigned long s_epc;
 	unsigned int cond, cbit;
 	mips_instruction ir;
 	int likely, pc_inc;
@@ -989,6 +991,8 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 	if (!cpu_has_mmips && dec_insn.micro_mips_mode)
 		unreachable();
 
+	s_epc = xcp->cp0_epc;
+	r31 = xcp->regs[31];
 	/* XXX NEC Vr54xx bug workaround */
 	if (delay_slot(xcp)) {
 		if (dec_insn.micro_mips_mode) {
@@ -1265,7 +1269,7 @@ branch_common:
 						 * instruction in the dslot.
 						 */
 						sig = mips_dsemul(xcp, ir,
-								  contpc);
+							    contpc, s_epc, r31);
 						if (sig)
 							xcp->cp0_epc = bcpc;
 						/*
@@ -1318,7 +1322,7 @@ branch_common:
 				 * Single step the non-cp1
 				 * instruction in the dslot
 				 */
-				sig = mips_dsemul(xcp, ir, contpc);
+				sig = mips_dsemul(xcp, ir, contpc, s_epc, r31);
 				if (sig)
 					xcp->cp0_epc = bcpc;
 				/* SIGILL forces out of the emulation loop.  */
diff --git a/arch/mips/math-emu/dsemul.c b/arch/mips/math-emu/dsemul.c
index e0b5cc27d78b..eac76a09d822 100644
--- a/arch/mips/math-emu/dsemul.c
+++ b/arch/mips/math-emu/dsemul.c
@@ -3,6 +3,7 @@
 #include <asm/fpu_emulator.h>
 #include <asm/inst.h>
 #include <asm/mipsregs.h>
+#include <asm/vdso.h>
 #include <asm/uaccess.h>
 
 #include "ieee754.h"
@@ -29,13 +30,19 @@ struct emuframe {
 	mips_instruction	badinst;
 	mips_instruction	cookie;
 	unsigned long		epc;
+	unsigned long           bpc;
+	unsigned long           r31;
 };
+/* round structure size to N*8 to force a fit two instructions in a single cache line */
+#define EMULFRAME_ROUNDED_SIZE  ((sizeof(struct emuframe) + 0x7) & ~0x7)
 
-int mips_dsemul(struct pt_regs *regs, mips_instruction ir, unsigned long cpc)
+int mips_dsemul(struct pt_regs *regs, mips_instruction ir, unsigned long cpc,
+		unsigned long bpc, unsigned long r31)
 {
 	extern asmlinkage void handle_dsemulret(void);
 	struct emuframe __user *fr;
 	int err;
+	unsigned char *pg_addr;
 
 	if ((get_isa16_mode(regs->cp0_epc) && ((ir >> 16) == MM_NOP16)) ||
 		(ir == 0)) {
@@ -48,7 +55,7 @@ int mips_dsemul(struct pt_regs *regs, mips_instruction ir, unsigned long cpc)
 	pr_debug("dsemul %lx %lx\n", regs->cp0_epc, cpc);
 
 	/*
-	 * The strategy is to push the instruction onto the user stack
+	 * The strategy is to push the instruction onto the user stack/VDSO page
 	 * and put a trap after it which we can catch and jump to
 	 * the required address any alternative apart from full
 	 * instruction emulation!!.
@@ -65,36 +72,81 @@ int mips_dsemul(struct pt_regs *regs, mips_instruction ir, unsigned long cpc)
 	 * handler (single entry point).
 	 */
 
-	/* Ensure that the two instructions are in the same cache line */
-	fr = (struct emuframe __user *)
-		((regs->regs[29] - sizeof(struct emuframe)) & ~0x7);
+	if (current_thread_info()->vdso_page) {
+		/*
+		 * Use VDSO page and fill structure via kernel VA,
+		 * user write is disabled
+		 */
+		pg_addr = (unsigned char *)page_address(current_thread_info()->vdso_page);
+		fr = (struct emuframe __user *)
+			    (pg_addr + current_thread_info()->vdso_offset -
+			     EMULFRAME_ROUNDED_SIZE);
+
+		/* verify that we don't overflow into trampoline areas */
+		if ((unsigned char *)fr < (unsigned char *)(((struct mips_vdso *)pg_addr) + 1)) {
+			MIPS_FPU_EMU_INC_STATS(errors);
+			return SIGBUS;
+		}
+
+		current_thread_info()->vdso_offset -= EMULFRAME_ROUNDED_SIZE;
 
-	/* Verify that the stack pointer is not competely insane */
-	if (unlikely(!access_ok(VERIFY_WRITE, fr, sizeof(struct emuframe))))
-		return SIGBUS;
+		if (get_isa16_mode(regs->cp0_epc)) {
+			*(u16 *)&fr->emul = (u16)(ir >> 16);
+			*((u16 *)(&fr->emul) + 1) = (u16)(ir & 0xffff);
+			*((u16 *)(&fr->emul) + 2) = (u16)(BREAK_MATH >> 16);
+			*((u16 *)(&fr->emul) + 3) = (u16)(BREAK_MATH &0xffff);
+		} else {
+			fr->emul = ir;
+			fr->badinst = (mips_instruction)BREAK_MATH;
+		}
+		fr->cookie = (mips_instruction)BD_COOKIE;
+		fr->epc = cpc;
+		fr->bpc = bpc;
+		fr->r31 = r31;
 
-	if (get_isa16_mode(regs->cp0_epc)) {
-		err = __put_user(ir >> 16, (u16 __user *)(&fr->emul));
-		err |= __put_user(ir & 0xffff, (u16 __user *)((long)(&fr->emul) + 2));
-		err |= __put_user(BREAK_MATH >> 16, (u16 __user *)(&fr->badinst));
-		err |= __put_user(BREAK_MATH & 0xffff, (u16 __user *)((long)(&fr->badinst) + 2));
+		/* fill CP0_EPC with user VA */
+		regs->cp0_epc = ((unsigned long)(current->mm->context.vdso +
+				current_thread_info()->vdso_offset)) |
+				get_isa16_mode(regs->cp0_epc);
+		if (cpu_has_dc_aliases)
+			mips_flush_data_cache_range(current->mm->context.vdso_vma,
+				regs->cp0_epc, current_thread_info()->vdso_page,
+				(unsigned long)fr, sizeof(struct emuframe));
+		else
+			/* it is a less expensive on CPU with correct SYNCI */
+			flush_cache_sigtramp((unsigned long)fr);
 	} else {
-		err = __put_user(ir, &fr->emul);
-		err |= __put_user((mips_instruction)BREAK_MATH, &fr->badinst);
-	}
+		/* Ensure that the two instructions are in the same cache line */
+		fr = (struct emuframe __user *)
+			((regs->regs[29] - sizeof(struct emuframe)) & ~0x7);
 
-	err |= __put_user((mips_instruction)BD_COOKIE, &fr->cookie);
-	err |= __put_user(cpc, &fr->epc);
+		/* Verify that the stack pointer is not competely insane */
+		if (unlikely(!access_ok(VERIFY_WRITE, fr, sizeof(struct emuframe))))
+			return SIGBUS;
 
-	if (unlikely(err)) {
-		MIPS_FPU_EMU_INC_STATS(errors);
-		return SIGBUS;
-	}
+		if (get_isa16_mode(regs->cp0_epc)) {
+			err = __put_user(ir >> 16, (u16 __user *)(&fr->emul));
+			err |= __put_user(ir & 0xffff, (u16 __user *)((long)(&fr->emul) + 2));
+			err |= __put_user(BREAK_MATH >> 16, (u16 __user *)(&fr->badinst));
+			err |= __put_user(BREAK_MATH & 0xffff, (u16 __user *)((long)(&fr->badinst) + 2));
+		} else {
+			err = __put_user(ir, &fr->emul);
+			err |= __put_user((mips_instruction)BREAK_MATH, &fr->badinst);
+		}
 
-	regs->cp0_epc = ((unsigned long) &fr->emul) |
-		get_isa16_mode(regs->cp0_epc);
+		err |= __put_user((mips_instruction)BD_COOKIE, &fr->cookie);
+		err |= __put_user(cpc, &fr->epc);
 
-	flush_cache_sigtramp((unsigned long)&fr->emul);
+		if (unlikely(err)) {
+			MIPS_FPU_EMU_INC_STATS(errors);
+			return SIGBUS;
+		}
+
+		regs->cp0_epc = ((unsigned long) &fr->emul) |
+			get_isa16_mode(regs->cp0_epc);
+
+		flush_cache_sigtramp((unsigned long)&fr->emul);
+	}
 
 	return 0;
 }
@@ -132,7 +184,10 @@ int do_dsemulret(struct pt_regs *xcp)
 	}
 	err |= __get_user(cookie, &fr->cookie);
 
-	if (unlikely(err || (insn != BREAK_MATH) || (cookie != BD_COOKIE))) {
+	if (unlikely(err || (insn != BREAK_MATH) || (cookie != BD_COOKIE) ||
+	    (current_thread_info()->vdso_page &&
+	     ((xcp->cp0_epc & PAGE_MASK) !=
+			(unsigned long)current->mm->context.vdso)))) {
 		MIPS_FPU_EMU_INC_STATS(errors);
 		return 0;
 	}
@@ -156,8 +211,55 @@ int do_dsemulret(struct pt_regs *xcp)
 		return 0;
 	}
 
+	if (current_thread_info()->vdso_page) {
+		/* restore VDSO stack level */
+		current_thread_info()->vdso_offset += EMULFRAME_ROUNDED_SIZE;
+		if (current_thread_info()->vdso_offset > PAGE_SIZE) {
+			/* This is not a good situation to be in */
+			current_thread_info()->vdso_offset -= EMULFRAME_ROUNDED_SIZE;
+			force_sig(SIGBUS, current);
+
+			return 0;
+		}
+	}
+
 	/* Set EPC to return to post-branch instruction */
 	xcp->cp0_epc = epc;
 	MIPS_FPU_EMU_INC_STATS(ds_emul);
 	return 1;
 }
+
+/* check and adjust an emulation stack before start a signal handler */
+void vdso_epc_adjust(struct pt_regs *xcp)
+{
+	struct emuframe __user *fr;
+	unsigned long epc;
+	unsigned long r31;
+
+	while (current_thread_info()->vdso_offset < PAGE_SIZE) {
+		epc = msk_isa16_mode(xcp->cp0_epc);
+		if ((epc >= ((unsigned long)current->mm->context.vdso + PAGE_SIZE)) ||
+		    (epc < (unsigned long)((struct mips_vdso *)current->mm->context.vdso + 1)))
+			return;
+
+		fr = (struct emuframe __user *)
+			((unsigned long)current->mm->context.vdso +
+			 current_thread_info()->vdso_offset);
+
+		/*
+		 * epc must point to emul instruction or badinst
+		 * in case of emul - it is not executed, so return to start
+		 *                   and restore GPR31
+		 * in case of badinst - instruction is executed, return to destination
+		 */
+		if (epc == (unsigned long)&fr->emul) {
+			__get_user(r31, &fr->r31);
+			xcp->regs[31] = r31;
+			__get_user(epc, &fr->bpc);
+		} else {
+			__get_user(epc, &fr->epc);
+		}
+		xcp->cp0_epc = epc;
+		current_thread_info()->vdso_offset += EMULFRAME_ROUNDED_SIZE;
+	}
+}
diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index 4b88fa031891..cdbf0cefe997 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -27,6 +27,7 @@
 #include <asm/mmu_context.h>
 #include <asm/ptrace.h>
 #include <asm/highmem.h>		/* For VMALLOC_END */
+#include <asm/tlbmisc.h>
 #include <linux/kdebug.h>
 
 int show_unhandled_signals = 1;
@@ -142,6 +143,9 @@ good_area:
 #endif
 				goto bad_area;
 			}
+			if (((address & PAGE_MASK) == (unsigned long)(mm->context.vdso)) &&
+			    install_vdso_tlb())
+				goto up_return;
 		} else {
 			if (!(vma->vm_flags & (VM_READ | VM_WRITE | VM_EXEC)))
 				goto bad_area;
@@ -192,6 +196,7 @@ good_area:
 		}
 	}
 
+up_return:
 	up_read(&mm->mmap_sem);
 	return;
 
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index 5037d5868cef..9e3f9d3235c7 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -360,6 +360,48 @@ void __update_tlb(struct vm_area_struct * vma, unsigned long address, pte_t pte)
 	local_irq_restore(flags);
 }
 
+int install_vdso_tlb(void)
+{
+	int tlbidx;
+	int cpu;
+	unsigned long flags;
+
+	if (!current_thread_info()->vdso_page)
+		return(0);
+
+	local_irq_save(flags);
+	cpu = smp_processor_id();
+	write_c0_entryhi(((unsigned long)current->mm->context.vdso & (PAGE_MASK << 1)) |
+			 cpu_asid(cpu, current->mm));
+
+	mtc0_tlbw_hazard();
+	tlb_probe();
+	tlb_probe_hazard();
+	tlbidx = read_c0_index();
+#if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
+		write_c0_entrylo0(pte_val(pfn_pte(
+			page_to_pfn(current_thread_info()->vdso_page),
+			__pgprot(_page_cachable_default|_PAGE_VALID)))>>32);
+#else
+		write_c0_entrylo0(pte_to_entrylo(pte_val(pfn_pte(
+			page_to_pfn(current_thread_info()->vdso_page),
+			__pgprot(_page_cachable_default|_PAGE_VALID)))));
+#endif
+	write_c0_entrylo1(0);
+	mtc0_tlbw_hazard();
+	if (tlbidx < 0)
+		tlb_write_random();
+	else
+		tlb_write_indexed();
+	tlbw_use_hazard();
+
+	current->mm->context.vdso_asid[cpu] = cpu_asid(cpu, current->mm);
+	current->mm->context.vdso_page[cpu] = current_thread_info()->vdso_page;
+	local_irq_restore(flags);
+
+	return(1);
+}
+
 void add_wired_entry(unsigned long entrylo0, unsigned long entrylo1,
 		     unsigned long entryhi, unsigned long pagemask)
 {
