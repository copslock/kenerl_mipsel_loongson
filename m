Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Dec 2017 11:05:02 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:38542 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994641AbdLLKBRPM2xC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Dec 2017 11:01:17 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx2.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 12 Dec 2017 10:01:10 +0000
Received: from mredfearn-linux.mipstec.com (10.150.130.83) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Tue, 12 Dec 2017 02:00:04 -0800
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
CC:     <linux-mips@linux-mips.org>
Subject: [RFC PATCH 16/16] MIPS: Activate CONFIG_THREAD_INFO_IN_TASK
Date:   Tue, 12 Dec 2017 09:58:02 +0000
Message-ID: <1513072682-1371-17-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1513072682-1371-1-git-send-email-matt.redfearn@mips.com>
References: <1513072682-1371-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1513072842-298553-18501-36363-4
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187894
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61445
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
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

Enable CONFIG_THREAD_INFO_IN_TASK, which embeds the thread_info at the
start of the task struct, rather than locating it at the bottom of the
kernel stack. This is a step towards allowing mapped kernel stacks, and
is in general a kernel hardening feature because a kernel stack overflow
will not overwrite the thread_info (of course, it might overwrite
something else below the stack page, but that's where mapped stacks come
in...).
- Load the initial $28 with the init_task.
- Add a arch specific current.h, which replaces reading
  current_thread_info from $28 with reading $current. The generic kernel
  provides current_thread_info when CONFIG_THREAD_INFO_IN_TASK is
  enabled.
- When resume()ing a thread, pass the task's stack pointer rather that
  using task_thread_info() to get the stack base.
- Remove task and cpu members from the thread_info struct. Task is
  redundant since current / current_thread_info are now aliases to the
  same structure. The cpu field is not managed by the generic kernel when
  CONFIG_THREAD_INFO_IN_TASK is active, since task->cpu replaces it.
- Fix up all locations which get the task struct from the thread_info.
  They are now one and the same so the pointer dereference can be
  removed.

Since this is quite an invasive change, here is quantification of it's
impact. All tests are from start of series to this patch with a 64r6
defconfig on Boston platform.

Total: Before=10010245, After=10001800, chg -0.08%

Average latency of syscall (10 x lat_syscall -W 2 -N 10 null)
Before: 6.13729, After: 6.12153, chg -0.25%

Average latency of syscall (10 x lat_syscall -W 2 -N 10 stat /dev/null)
Before: 102.21804, After: 102.58439, chg +0.36%

Average latency of syscall (10 x lat_syscall -W 2 -N 10 exec"
Before: 16051.1, After: 16130.0, chg +0.49%

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>

---

 arch/mips/Kconfig                       |  1 +
 arch/mips/cavium-octeon/octeon-memcpy.S |  6 ++----
 arch/mips/include/asm/Kbuild            |  1 -
 arch/mips/include/asm/current.h         | 22 ++++++++++++++++++++++
 arch/mips/include/asm/stackframe.h      |  2 --
 arch/mips/include/asm/switch_to.h       |  5 ++---
 arch/mips/include/asm/thread_info.h     | 12 ------------
 arch/mips/kernel/asm-offsets.c          |  2 --
 arch/mips/kernel/head.S                 |  5 +++--
 arch/mips/kernel/octeon_switch.S        |  5 ++---
 arch/mips/kernel/r2300_switch.S         |  5 ++---
 arch/mips/kernel/r4k_switch.S           |  5 ++---
 arch/mips/kernel/smp.c                  |  3 +--
 arch/mips/lib/csum_partial.S            |  7 ++-----
 arch/mips/lib/memcpy.S                  |  8 ++------
 arch/mips/lib/memset.S                  |  6 ++----
 16 files changed, 43 insertions(+), 52 deletions(-)
 create mode 100644 arch/mips/include/asm/current.h

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 350a990fc719..f50f87c6ef24 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -72,6 +72,7 @@ config MIPS
 	select PERF_USE_VMALLOC
 	select RTC_LIB if !MACH_LOONGSON64
 	select SYSCTL_EXCEPTION_TRACE
+	select THREAD_INFO_IN_TASK
 	select VIRT_TO_BUS
 
 menu "Machine selection"
diff --git a/arch/mips/cavium-octeon/octeon-memcpy.S b/arch/mips/cavium-octeon/octeon-memcpy.S
index 0a7c9834b81c..1621995c76b5 100644
--- a/arch/mips/cavium-octeon/octeon-memcpy.S
+++ b/arch/mips/cavium-octeon/octeon-memcpy.S
@@ -391,8 +391,7 @@ l_exc_copy:
 	 *
 	 * Assumes src < THREAD_BUADDR($28)
 	 */
-	LOAD	t0, TI_TASK($28)
-	LOAD	t0, THREAD_BUADDR(t0)
+	LOAD	t0, THREAD_BUADDR($28)
 1:
 EXC(	lb	t1, 0(src),	l_exc)
 	ADD	src, src, 1
@@ -400,8 +399,7 @@ EXC(	lb	t1, 0(src),	l_exc)
 	bne	src, t0, 1b
 	 ADD	dst, dst, 1
 l_exc:
-	LOAD	t0, TI_TASK($28)
-	LOAD	t0, THREAD_BUADDR(t0)	# t0 is just past last good address
+	LOAD	t0, THREAD_BUADDR($28)	# t0 is just past last good address
 	SUB	len, AT, t0		# len number of uncopied bytes
 	jr	ra
 	 nop
diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
index 7c8aab23bce8..21e15df89b4e 100644
--- a/arch/mips/include/asm/Kbuild
+++ b/arch/mips/include/asm/Kbuild
@@ -1,7 +1,6 @@
 # MIPS headers
 generic-(CONFIG_GENERIC_CSUM) += checksum.h
 generic-y += clkdev.h
-generic-y += current.h
 generic-y += dma-contiguous.h
 generic-y += emergency-restart.h
 generic-y += export.h
diff --git a/arch/mips/include/asm/current.h b/arch/mips/include/asm/current.h
new file mode 100644
index 000000000000..b004856d5b1f
--- /dev/null
+++ b/arch/mips/include/asm/current.h
@@ -0,0 +1,22 @@
+#ifndef __ASM_CURRENT_H
+#define __ASM_CURRENT_H
+
+#include <linux/compiler.h>
+
+#ifndef __ASSEMBLY__
+
+struct task_struct;
+
+/* How to get the thread information struct from C.  */
+register struct task_struct *__current_task __asm__("$28");
+
+static __always_inline struct task_struct *get_current(void)
+{
+	return __current_task;
+}
+
+#define current get_current()
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __ASM_CURRENT_H */
diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
index 2ba65600a8d9..92ea518edbf5 100644
--- a/arch/mips/include/asm/stackframe.h
+++ b/arch/mips/include/asm/stackframe.h
@@ -219,8 +219,6 @@
 		.macro	get_saved_sp docfi=0
 		/* Get current thread info into k1 */
 		get_saved_ti	k1, k0
-		/* Get task struct into k1 */
-		LONG_L		k1, TI_TASK(k1)
 		/* Get the stack into k1 */
 		LONG_L		k1, TASK_STACK(k1)
 		/* Get starting stack location */
diff --git a/arch/mips/include/asm/switch_to.h b/arch/mips/include/asm/switch_to.h
index e610473d61b8..446cf3e80276 100644
--- a/arch/mips/include/asm/switch_to.h
+++ b/arch/mips/include/asm/switch_to.h
@@ -24,13 +24,12 @@ struct task_struct;
  * resume - resume execution of a task
  * @prev:	The task previously executed.
  * @next:	The task to begin executing.
- * @next_ti:	task_thread_info(next).
  *
  * This function is used whilst scheduling to save the context of prev & load
  * the context of next. Returns prev.
  */
 extern asmlinkage struct task_struct *resume(struct task_struct *prev,
-		struct task_struct *next, struct thread_info *next_ti);
+					     struct task_struct *next);
 
 extern unsigned int ll_bit;
 extern struct task_struct *ll_task;
@@ -130,7 +129,7 @@ do {									\
 	if (cpu_has_userlocal)						\
 		write_c0_userlocal(task_thread_info(next)->tp_value);	\
 	__restore_watch(next);						\
-	(last) = resume(prev, next, task_thread_info(next));		\
+	(last) = resume(prev, next);					\
 } while (0)
 
 #endif /* _ASM_SWITCH_TO_H */
diff --git a/arch/mips/include/asm/thread_info.h b/arch/mips/include/asm/thread_info.h
index b8cc81055d57..2d83cb9e238d 100644
--- a/arch/mips/include/asm/thread_info.h
+++ b/arch/mips/include/asm/thread_info.h
@@ -23,10 +23,8 @@
  *   must also be changed
  */
 struct thread_info {
-	struct task_struct	*task;		/* main task structure */
 	unsigned long		flags;		/* low level flags */
 	unsigned long		tp_value;	/* thread pointer */
-	__u32			cpu;		/* current CPU */
 	int			preempt_count;	/* 0 => preemptable, <0 => BUG */
 	mm_segment_t		addr_limit;	/*
 						 * thread address space limit:
@@ -42,9 +40,7 @@ struct thread_info {
  */
 #define INIT_THREAD_INFO(tsk)			\
 {						\
-	.task		= &tsk,			\
 	.flags		= _TIF_FIXADE,		\
-	.cpu		= 0,			\
 	.preempt_count	= INIT_PREEMPT_COUNT,	\
 	.addr_limit	= KERNEL_DS,		\
 }
@@ -52,17 +48,9 @@ struct thread_info {
 #define init_thread_info	(init_thread_union.thread_info)
 #define init_stack		(init_thread_union.stack)
 
-/* How to get the thread information struct from C.  */
-register struct thread_info *__current_thread_info __asm__("$28");
-
 /* thread_info pointer for each CPU */
 extern unsigned long thread_info_ptr[NR_CPUS];
 
-static inline struct thread_info *current_thread_info(void)
-{
-	return __current_thread_info;
-}
-
 #endif /* !__ASSEMBLY__ */
 
 /* thread information allocation */
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index b682a77a0072..9af07a9fa2b6 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -93,10 +93,8 @@ void output_task_defines(void)
 void output_thread_info_defines(void)
 {
 	COMMENT("MIPS thread_info offsets.");
-	OFFSET(TI_TASK, thread_info, task);
 	OFFSET(TI_FLAGS, thread_info, flags);
 	OFFSET(TI_TP_VALUE, thread_info, tp_value);
-	OFFSET(TI_CPU, thread_info, cpu);
 	OFFSET(TI_PRE_COUNT, thread_info, preempt_count);
 	OFFSET(TI_ADDR_LIMIT, thread_info, addr_limit);
 	OFFSET(TI_REGS, thread_info, regs);
diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
index 5a7e0dac8ada..6b71a1316a52 100644
--- a/arch/mips/kernel/head.S
+++ b/arch/mips/kernel/head.S
@@ -130,10 +130,11 @@ dtb_found:
 #endif
 
 	MTC0		zero, CP0_CONTEXT	# clear context register
-	PTR_LA		$28, init_thread_union
+	PTR_LA          $28, init_task
 	/* Set the SP after an empty pt_regs.  */
+	PTR_LA		t0, init_thread_union
 	PTR_LI		sp, _THREAD_SIZE - 32 - PT_SIZE
-	PTR_ADDU	sp, $28
+	PTR_ADDU	sp, t0
 	back_to_back_c0_hazard
 	set_saved_ti	$28, t0
 	PTR_SUBU	sp, 4 * SZREG		# init stack pointer
diff --git a/arch/mips/kernel/octeon_switch.S b/arch/mips/kernel/octeon_switch.S
index 8f2d80b9b8a4..f3c8eefcf63c 100644
--- a/arch/mips/kernel/octeon_switch.S
+++ b/arch/mips/kernel/octeon_switch.S
@@ -18,8 +18,7 @@
 #include <asm/stackframe.h>
 
 /*
- * task_struct *resume(task_struct *prev, task_struct *next,
- *		       struct thread_info *next_ti)
+ * task_struct *resume(task_struct *prev, task_struct *next)
  */
 	.align	7
 	LEAF(resume)
@@ -71,7 +70,7 @@
 	 * The order of restoring the registers takes care of the race
 	 * updating $28, $29 and saved_ti without disabling ints.
 	 */
-	move	$28, a2
+	move	$28, a1
 	cpu_restore_nonscratch a1
 	set_saved_ti	$28, t0
 
diff --git a/arch/mips/kernel/r2300_switch.S b/arch/mips/kernel/r2300_switch.S
index db8186ed9b24..32a68596df1d 100644
--- a/arch/mips/kernel/r2300_switch.S
+++ b/arch/mips/kernel/r2300_switch.S
@@ -27,8 +27,7 @@
 	.align	5
 
 /*
- * task_struct *resume(task_struct *prev, task_struct *next,
- *		       struct thread_info *next_ti)
+ * task_struct *resume(task_struct *prev, task_struct *next)
  */
 LEAF(resume)
 	mfc0	t1, CP0_STATUS
@@ -46,7 +45,7 @@ LEAF(resume)
 	 * The order of restoring the registers takes care of the race
 	 * updating $28, $29 and saved_ti without disabling ints.
 	 */
-	move	$28, a2
+	move	$28, a1
 	cpu_restore_nonscratch a1
 	set_saved_ti	$28, t0
 
diff --git a/arch/mips/kernel/r4k_switch.S b/arch/mips/kernel/r4k_switch.S
index 6428904a34c7..c5b29aca6d31 100644
--- a/arch/mips/kernel/r4k_switch.S
+++ b/arch/mips/kernel/r4k_switch.S
@@ -21,8 +21,7 @@
 #include <asm/asmmacro.h>
 
 /*
- * task_struct *resume(task_struct *prev, task_struct *next,
- *		       struct thread_info *next_ti)
+ * task_struct *resume(task_struct *prev, task_struct *next)
  */
 	.align	5
 	LEAF(resume)
@@ -41,7 +40,7 @@
 	 * The order of restoring the registers takes care of the race
 	 * updating $28, $29 and saved_ti without disabling ints.
 	 */
-	move	$28, a2
+	move	$28, a1
 	cpu_restore_nonscratch a1
 	set_saved_ti	$28, t0
 
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index b93e6748f38d..bd9d893469e2 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -353,7 +353,7 @@ early_initcall(mips_smp_ipi_init);
  */
 asmlinkage void start_secondary(void)
 {
-	unsigned int cpu = current_thread_info()->cpu;
+	unsigned int cpu = current->cpu;
 
 	/* Stash this CPUs ID in CP0 for smp_processor_id() */
 #ifdef CONFIG_MIPS_PGD_C0_CONTEXT
@@ -436,7 +436,6 @@ void __init smp_cpus_done(unsigned int max_cpus)
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 	init_new_context(current, &init_mm);
-	current_thread_info()->cpu = 0;
 	mp_ops->prepare_cpus(max_cpus);
 	set_cpu_sibling_map(0);
 	set_cpu_core_map(0);
diff --git a/arch/mips/lib/csum_partial.S b/arch/mips/lib/csum_partial.S
index 2ff84f4b1717..5c0365973836 100644
--- a/arch/mips/lib/csum_partial.S
+++ b/arch/mips/lib/csum_partial.S
@@ -766,9 +766,8 @@ EXPORT_SYMBOL(csum_partial)
 	 *
 	 * Assumes src < THREAD_BUADDR($28)
 	 */
-	LOADK	t0, TI_TASK($28)
 	 li	t2, SHIFT_START
-	LOADK	t0, THREAD_BUADDR(t0)
+	LOADK	t0, THREAD_BUADDR($28)
 1:
 	LOADBU(t1, 0(src), .Ll_exc\@)
 	ADD	src, src, 1
@@ -781,9 +780,7 @@ EXPORT_SYMBOL(csum_partial)
 	bne	src, t0, 1b
 	.set	noreorder
 .Ll_exc\@:
-	LOADK	t0, TI_TASK($28)
-	 nop
-	LOADK	t0, THREAD_BUADDR(t0)	# t0 is just past last good address
+	LOADK	t0, THREAD_BUADDR($28)	# t0 is just past last good address
 	 nop
 	SUB	len, AT, t0		# len number of uncopied bytes
 	/*
diff --git a/arch/mips/lib/memcpy.S b/arch/mips/lib/memcpy.S
index 03e3304d6ae5..5a2cf36dfba6 100644
--- a/arch/mips/lib/memcpy.S
+++ b/arch/mips/lib/memcpy.S
@@ -548,9 +548,7 @@
 	 *
 	 * Assumes src < THREAD_BUADDR($28)
 	 */
-	LOADK	t0, TI_TASK($28)
-	 nop
-	LOADK	t0, THREAD_BUADDR(t0)
+	LOADK	t0, THREAD_BUADDR($28)
 1:
 	LOADB(t1, 0(src), .Ll_exc\@)
 	ADD	src, src, 1
@@ -560,9 +558,7 @@
 	bne	src, t0, 1b
 	.set	noreorder
 .Ll_exc\@:
-	LOADK	t0, TI_TASK($28)
-	 nop
-	LOADK	t0, THREAD_BUADDR(t0)	# t0 is just past last good address
+	LOADK	t0, THREAD_BUADDR($28)	# t0 is just past last good address
 	 nop
 	SUB	len, AT, t0		# len number of uncopied bytes
 	jr	ra
diff --git a/arch/mips/lib/memset.S b/arch/mips/lib/memset.S
index a1456664d6c2..34062b5a95e1 100644
--- a/arch/mips/lib/memset.S
+++ b/arch/mips/lib/memset.S
@@ -241,17 +241,15 @@
 	nop
 
 .Lfwd_fixup\@:
-	PTR_L		t0, TI_TASK($28)
 	andi		a2, 0x3f
-	LONG_L		t0, THREAD_BUADDR(t0)
+	LONG_L		t0, THREAD_BUADDR($28)
 	LONG_ADDU	a2, t1
 	jr		ra
 	LONG_SUBU	a2, t0
 
 .Lpartial_fixup\@:
-	PTR_L		t0, TI_TASK($28)
 	andi		a2, STORMASK
-	LONG_L		t0, THREAD_BUADDR(t0)
+	LONG_L		t0, THREAD_BUADDR($28)
 	LONG_ADDU	a2, t1
 	jr		ra
 	LONG_SUBU	a2, t0
-- 
2.7.4
