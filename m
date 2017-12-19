Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Dec 2017 00:50:42 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:40783 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991971AbdLSXuezW55N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Dec 2017 00:50:34 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx28.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 19 Dec 2017 23:50:24 +0000
Received: from pburton-laptop.mipstec.com (10.20.1.18) by mips01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server id 14.3.361.1; Tue, 19 Dec 2017
 15:50:20 -0800
From:   Paul Burton <paul.burton@mips.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        stable <stable@vger.kernel.org>
Subject: [PATCH] MIPS: Schedule on CPUs we need to lose FPU for a mode switch
Date:   Tue, 19 Dec 2017 15:50:47 -0800
Message-ID: <20171219235047.14382-1-paul.burton@mips.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-BESS-ID: 1513727422-637138-20016-55083-11
X-BESS-VER: 2017.16-r1712182224
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.188163
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61522
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

Commit 6b8322576e9d ("MIPS: Force CPUs to lose FP context during mode
switches") ensures that we react to PR_SET_FP_MODE prctl syscalls
quickly by broadcasting an IPI in order to cause CPUs to lose FPU access
when necessary. Whilst it achieves that, unfortunately it causes all
sorts of strange race conditions because:

 1) The IPI may arrive at a point where the FPU is in the process of
    being enabled, but that process is not yet complete leading to a
    state we aren't prepared to handle. For example:

    do_cpu invoked from kernel context![#1]:
    CPU: 0 PID: 963 Comm: fp-prctl Not tainted 4.9.0-rc5-00323-g210db32-dirty #226
    task: a8000000fd672e00 task.stack: a8000000fd630000
    $ 0   : 0000000000000000 0000000000000001 0000000000000001 a8000000fd630000
    $ 4   : a8000000fd672e00 0000000000000000 0000000000000453 0000000000000000
    $ 8   : 0000000000000000 a8000000fd637c28 1000000000000000 0000000000000010
    $12   : 00000000140084e0 ffffffff80109c00 0000000000000000 0000000000000002
    $16   : ffffffff8092f080 a8000000fd672e00 ffffffff80107fe8 a8000000fd485000
    $20   : ffffffff8084d328 ffffffff80940000 0000000000000009 ffffffff80930000
    $24   : 0000000000000000 900000001612048c
    $28   : a8000000fd630000 a8000000fd637ac0 ffffffff80937300 ffffffff8010807c
    Hi    : 0000000000000000
    Lo    : 0000000000000200
    epc   : ffffffff80115d38 _save_fp+0x10/0xa0
    ra    : ffffffff8010807c prepare_for_fp_mode_switch+0x94/0x1b0
    Status: 140084e2 KX SX UX KERNEL EXL
    Cause : 1080002c (ExcCode 0b)
    PrId  : 0001a428 (MIPS P6600)
    Modules linked in:
    Process fp-prctl (pid: 963, threadinfo=a8000000fd630000, task=a8000000fd672e00, tls=00000000756e67d0)
    Stack : 0000000000000000 a8000000fd557dc0 0000000000000000 ffffffff801ca8e0
            0000000000000000 a8000000fd637b9c 0000000000000009 ffffffff80923780
            ffffffff80850000 ffffffff8011610c 00000000000000b8 ffffffff801a5084
            ffffffff8084a370 ffffffff8084a388 ffffffff80923780 ffffffff80923828
            0000000000010000 ffffffff809237a8 0000000000020000 ffffffff80a40000
            000000000000007c 00000000004a0000 00000000756dedd0 ffffffff801a5188
            a800000002014900 0000000000000001 ffffffff80923780 0000000080923828
            ffffffff80923780 ffffffff80923780 ffffffff80923828 ffffffff801a521c
            ffffffff80923780 ffffffff80923828 0000000000010000 ffffffff801a8f84
            ffffffff80a40000 a8000000fd637c20 ffffffff80a39240 0000000000000001
            ...
    Call Trace:
    [<ffffffff80115d38>] _save_fp+0x10/0xa0
    [<ffffffff8010807c>] prepare_for_fp_mode_switch+0x94/0x1b0
    [<ffffffff801ca8e0>] flush_smp_call_function_queue+0xf8/0x230
    [<ffffffff8011610c>] ipi_call_interrupt+0xc/0x20
    [<ffffffff801a5084>] __handle_irq_event_percpu+0xc4/0x1a8
    [<ffffffff801a5188>] handle_irq_event_percpu+0x20/0x68
    [<ffffffff801a521c>] handle_irq_event+0x4c/0x88
    [<ffffffff801a8f84>] handle_edge_irq+0x12c/0x210
    [<ffffffff801a47a0>] generic_handle_irq+0x38/0x48
    [<ffffffff804a2dbc>] gic_handle_shared_int+0x194/0x268
    [<ffffffff801a47a0>] generic_handle_irq+0x38/0x48
    [<ffffffff80107e60>] do_IRQ+0x18/0x28
    [<ffffffff804a1524>] plat_irq_dispatch+0xc4/0x140
    [<ffffffff80106230>] ret_from_irq+0x0/0x4
    [<ffffffff8010fad4>] do_ri+0x4fc/0x7e8
    [<ffffffff80106220>] ret_from_exception+0x0/0x10

 2) The IPI may arrive during kernel use of the FPU, since we generally
    only disable preemption around use of the FPU & leave interrupts
    enabled. This can lead to us unexpectedly losing access to the FPU
    in places where it previously had not been possible. For example:

    do_cpu invoked from kernel context![#2]:
    CPU: 2 PID: 7338 Comm: fp-prctl Tainted: G      D         4.7.0-00424-g49b0c82
    #2
    task: 838e4000 ti: 88d38000 task.ti: 88d38000
    $ 0   : 00000000 00000001 ffffffff 88d3fef8
    $ 4   : 838e4000 88d38004 00000000 00000001
    $ 8   : 3400fc01 801f8020 808e9100 24000000
    $12   : dbffffff 807b69d8 807b0000 00000000
    $16   : 00000000 80786150 00400fc4 809c0398
    $20   : 809c0338 0040273c 88d3ff28 808e9d30
    $24   : 808e9d30 00400fb4
    $28   : 88d38000 88d3fe88 00000000 8011a2ac
    Hi    : 0040273c
    Lo    : 88d3ff28
    epc   : 80114178 _restore_fp+0x10/0xa0
    ra    : 8011a2ac mipsr2_decoder+0xd5c/0x1660
    Status: 1400fc03    KERNEL EXL IE
    Cause : 1080002c (ExcCode 0b)
    PrId  : 0001a920 (MIPS I6400)
    Modules linked in:
    Process fp-prctl (pid: 7338, threadinfo=88d38000, task=838e4000, tls=766527d0)
    Stack : 00000000 00000000 00000000 88d3fe98 00000000 00000000 809c0398 809c0338
          808e9100 00000000 88d3ff28 00400fc4 00400fc4 0040273c 7fb69e18 004a0000
          004a0000 004a0000 7664add0 8010de18 00000000 00000000 88d3fef8 88d3ff28
          808e9100 00000000 766527d0 8010e534 000c0000 85755000 8181d580 00000000
          00000000 00000000 004a0000 00000000 766527d0 7fb69e18 004a0000 80105c20
          ...
    Call Trace:
    [<80114178>] _restore_fp+0x10/0xa0
    [<8011a2ac>] mipsr2_decoder+0xd5c/0x1660
    [<8010de18>] do_ri+0x90/0x6b8
    [<80105c20>] ret_from_exception+0x0/0x10

At first glance a simple fix may seem to be to disable interrupts around
kernel use of the FPU rather than merely preemption, however this would
introduce further overhead outside of the mode switch path & doesn't
solve the third problem:

 3) The IPI may arrive whilst the kernel is running code that will lead
    to a preempt_disable() call & FPU usage soon. If this happens then
    the IPI will be serviced & we'll proceed to enable an FPU whilst the
    mode switch is in progress, leading to strange & inconsistent
    behaviour.

Further to all of this is a separate but related problem:

 4) There are various paths through which we may enable the FPU without
    the user having triggered a coprocessor 1 disabled exception. These
    paths are those in which we emulate instructions & then enable the
    FPU with the expectation that the user might execute an FP
    instruction shortly afterwards. However these paths have not
    previously checked whether an FP mode switch is underway for the
    task, and therefore could enable the FPU whilst such a mode switch
    is in progress leading to strange & inconsistent behaviour for user
    code.

This patch fixes all of the above by taking a step back & re-examining
our approach to FP mode switches. Up until now we have taken these basic
steps:

 a) Prevent any threads that are part of the affected process from being
    able to obtain ownership of the FPU.

 b) Cause any threads that are part of the affected process and already
    have ownership of an FPU to lose it.

 c) Set the thread flags for each thread that is part of the affected
    process to reflect the new FP mode.

 d) Allow threads to obtain ownership of the FPU again.

This approach is however more complex than necessary. All that we really
require is that the mode switch has occurred for all threads that are
part of the affected process before mips_set_process_fp_mode(), and thus
the PR_SET_FP_MODE prctl() syscall, returns. This doesn't require that
we stop threads from owning or using an FPU whilst a mode switch occurs,
only that we force them to relinquish it after the mode switch has
occurred such that they next own an FPU with the correct mode
configured. Our basic steps therefore simplify to:

 A) Set the thread flags for each thread that is part of the affected
    process to reflect the new FP mode.

 B) Cause any threads that are part of the affected process and already
    have ownership of an FPU to lose it.

We implement B) by forcing each CPU which might be running a thread
which is part of the affected process to schedule a no-op function,
which causes the affected thread to lose its FPU ownership when it is
descheduled.

The end result is simpler FP mode switching with less overhead in the
FPU enable path (ie. enable_restore_fp_context()) and fewer moving
parts.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Fixes: 9791554b45a2 ("MIPS,prctl: add PR_[GS]ET_FP_MODE prctl options for MIPS")
Fixes: 6b8322576e9d ("MIPS: Force CPUs to lose FP context during mode switches")
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: stable <stable@vger.kernel.org> # v4.0+
---

 arch/mips/include/asm/mmu_context.h |  2 -
 arch/mips/kernel/process.c          | 80 +++++++++++++++++++------------------
 arch/mips/kernel/traps.c            |  7 ----
 3 files changed, 42 insertions(+), 47 deletions(-)

diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mmu_context.h
index da2004cef2d5..b509371a6b0c 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -126,8 +126,6 @@ init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 	for_each_possible_cpu(i)
 		cpu_context(i, mm) = 0;
 
-	atomic_set(&mm->context.fp_mode_switching, 0);
-
 	mm->context.bd_emupage_allocmap = NULL;
 	spin_lock_init(&mm->context.bd_emupage_lock);
 	init_waitqueue_head(&mm->context.bd_emupage_queue);
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 45d0b6b037ee..680a91ba2030 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -29,6 +29,7 @@
 #include <linux/kallsyms.h>
 #include <linux/random.h>
 #include <linux/prctl.h>
+#include <linux/cpu.h>
 
 #include <asm/asm.h>
 #include <asm/bootinfo.h>
@@ -691,19 +692,25 @@ int mips_get_process_fp_mode(struct task_struct *task)
 	return value;
 }
 
-static void prepare_for_fp_mode_switch(void *info)
+static long prepare_for_fp_mode_switch(void *unused)
 {
-	struct mm_struct *mm = info;
-
-	if (current->mm == mm)
-		lose_fpu(1);
+	/*
+	 * This is icky, but we use this to simply ensure that all CPUs have
+	 * context switched, regardless of whether they were previously running
+	 * kernel or user code. This ensures that no CPU currently has its FPU
+	 * enabled, or is about to attempt to enable it through any path other
+	 * than enable_restore_fp_context() which will wait appropriately for
+	 * fp_mode_switching to be zero.
+	 */
+	return 0;
 }
 
 int mips_set_process_fp_mode(struct task_struct *task, unsigned int value)
 {
 	const unsigned int known_bits = PR_FP_MODE_FR | PR_FP_MODE_FRE;
 	struct task_struct *t;
-	int max_users;
+	struct cpumask process_cpus;
+	int cpu;
 
 	/* Check the value is valid */
 	if (value & ~known_bits)
@@ -720,35 +727,7 @@ int mips_set_process_fp_mode(struct task_struct *task, unsigned int value)
 	if (!(value & PR_FP_MODE_FR) && raw_cpu_has_fpu && cpu_has_mips_r6)
 		return -EOPNOTSUPP;
 
-	/* Proceed with the mode switch */
-	preempt_disable();
-
-	/* Save FP & vector context, then disable FPU & MSA */
-	if (task->signal == current->signal)
-		lose_fpu(1);
-
-	/* Prevent any threads from obtaining live FP context */
-	atomic_set(&task->mm->context.fp_mode_switching, 1);
-	smp_mb__after_atomic();
-
-	/*
-	 * If there are multiple online CPUs then force any which are running
-	 * threads in this process to lose their FPU context, which they can't
-	 * regain until fp_mode_switching is cleared later.
-	 */
-	if (num_online_cpus() > 1) {
-		/* No need to send an IPI for the local CPU */
-		max_users = (task->mm == current->mm) ? 1 : 0;
-
-		if (atomic_read(&current->mm->mm_users) > max_users)
-			smp_call_function(prepare_for_fp_mode_switch,
-					  (void *)current->mm, 1);
-	}
-
-	/*
-	 * There are now no threads of the process with live FP context, so it
-	 * is safe to proceed with the FP mode switch.
-	 */
+	/* Indicate the new FP mode in each thread */
 	for_each_thread(task, t) {
 		/* Update desired FP register width */
 		if (value & PR_FP_MODE_FR) {
@@ -765,9 +744,34 @@ int mips_set_process_fp_mode(struct task_struct *task, unsigned int value)
 			clear_tsk_thread_flag(t, TIF_HYBRID_FPREGS);
 	}
 
-	/* Allow threads to use FP again */
-	atomic_set(&task->mm->context.fp_mode_switching, 0);
-	preempt_enable();
+	/*
+	 * We need to ensure that all threads in the process have switched mode
+	 * before returning, in order to allow userland to not worry about
+	 * races. We can do this by forcing all CPUs that any thread in the
+	 * process may be running on to schedule something else - in this case
+	 * prepare_for_fp_mode_switch().
+	 *
+	 * We begin by generating a mask of all CPUs that any thread in the
+	 * process may be running on.
+	 */
+	cpumask_clear(&process_cpus);
+	for_each_thread(task, t)
+		cpumask_set_cpu(task_cpu(t), &process_cpus);
+
+	/*
+	 * Now we schedule prepare_for_fp_mode_switch() on each of those CPUs.
+	 *
+	 * The CPUs may have rescheduled already since we switched mode or
+	 * generated the cpumask, but that doesn't matter. If the task in this
+	 * process is scheduled out then our scheduling
+	 * prepare_for_fp_mode_switch() will simply be redundant. If it's
+	 * scheduled in then it will already have picked up the new FP mode
+	 * whilst doing so.
+	 */
+	get_online_cpus();
+	for_each_cpu_and(cpu, &process_cpus, cpu_online_mask)
+		work_on_cpu(cpu, prepare_for_fp_mode_switch, NULL);
+	put_online_cpus();
 
 	return 0;
 }
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 5d19ed07e99d..b0a684e7b8fa 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1237,13 +1237,6 @@ static int enable_restore_fp_context(int msa)
 {
 	int err, was_fpu_owner, prior_msa;
 
-	/*
-	 * If an FP mode switch is currently underway, wait for it to
-	 * complete before proceeding.
-	 */
-	wait_on_atomic_t(&current->mm->context.fp_mode_switching,
-			 atomic_t_wait, TASK_KILLABLE);
-
 	if (!used_math()) {
 		/* First time FP context user. */
 		preempt_disable();
-- 
2.15.1
