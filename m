Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jun 2018 19:56:43 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:48816 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994563AbeFVR4gbCP0O (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Jun 2018 19:56:36 +0200
Received: from mipsdag01.mipstec.com (mail1.mips.com [12.201.5.31]) by mx1402.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Fri, 22 Jun 2018 17:56:25 +0000
Received: from mipsdag02.mipstec.com (10.20.40.47) by mipsdag01.mipstec.com
 (10.20.40.46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Fri, 22
 Jun 2018 10:55:49 -0700
Received: from pburton-laptop.mipstec.com (10.20.2.29) by
 mipsdag02.mipstec.com (10.20.40.47) with Microsoft SMTP Server id 15.1.1415.2
 via Frontend Transport; Fri, 22 Jun 2018 10:55:49 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     <linux-mips@linux-mips.org>
CC:     Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paul.burton@mips.com>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 2/3] MIPS: Use async IPIs for arch_trigger_cpumask_backtrace()
Date:   Fri, 22 Jun 2018 10:55:46 -0700
Message-ID: <20180622175547.17716-3-paul.burton@mips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180622175547.17716-1-paul.burton@mips.com>
References: <20180622175547.17716-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-BESS-ID: 1529690136-321458-14409-5864-10
X-BESS-VER: 2018.7-r1806151722
X-BESS-Apparent-Source-IP: 12.201.5.31
X-BESS-Envelope-From: Paul.Burton@mips.com
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.194338
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-Orig-Rcpt: linux-mips@linux-mips.org,chenhc@lemote.com,ralf@linux-mips.org,jhogan@kernel.org
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64415
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

The current MIPS implementation of arch_trigger_cpumask_backtrace() is
broken because it attempts to use synchronous IPIs despite the fact that
it may be run with interrupts disabled.

This means that when arch_trigger_cpumask_backtrace() is invoked, for
example by the RCU CPU stall watchdog, we may:

  - Deadlock due to use of synchronous IPIs with interrupts disabled,
    causing the CPU that's attempting to generate the backtrace output
    to hang itself.

  - Not succeed in generating the desired output from remote CPUs.

  - Produce warnings about this from smp_call_function_many(), for
    example:

    [42760.526910] INFO: rcu_sched detected stalls on CPUs/tasks:
    [42760.535755]  0-...!: (1 GPs behind) idle=ade/140000000000000/0 softirq=526944/526945 fqs=0
    [42760.547874]  1-...!: (0 ticks this GP) idle=e4a/140000000000000/0 softirq=547885/547885 fqs=0
    [42760.559869]  (detected by 2, t=2162 jiffies, g=266689, c=266688, q=33)
    [42760.568927] ------------[ cut here ]------------
    [42760.576146] WARNING: CPU: 2 PID: 1216 at kernel/smp.c:416 smp_call_function_many+0x88/0x20c
    [42760.587839] Modules linked in:
    [42760.593152] CPU: 2 PID: 1216 Comm: sh Not tainted 4.15.4-00373-gee058bb4d0c2 #2
    [42760.603767] Stack : 8e09bd20 8e09bd20 8e09bd20 fffffff0 00000007 00000006 00000000 8e09bca8
    [42760.616937]         95b2b379 95b2b379 807a0080 00000007 81944518 0000018a 00000032 00000000
    [42760.630095]         00000000 00000030 80000000 00000000 806eca74 00000009 8017e2b8 000001a0
    [42760.643169]         00000000 00000002 00000000 8e09baa4 00000008 808b8008 86d69080 8e09bca0
    [42760.656282]         8e09ad50 805e20aa 00000000 00000000 00000000 8017e2b8 00000009 801070ca
    [42760.669424]         ...
    [42760.673919] Call Trace:
    [42760.678672] [<27fde568>] show_stack+0x70/0xf0
    [42760.685417] [<84751641>] dump_stack+0xaa/0xd0
    [42760.692188] [<699d671c>] __warn+0x80/0x92
    [42760.698549] [<68915d41>] warn_slowpath_null+0x28/0x36
    [42760.705912] [<f7c76c1c>] smp_call_function_many+0x88/0x20c
    [42760.713696] [<6bbdfc2a>] arch_trigger_cpumask_backtrace+0x30/0x4a
    [42760.722216] [<f845bd33>] rcu_dump_cpu_stacks+0x6a/0x98
    [42760.729580] [<796e7629>] rcu_check_callbacks+0x672/0x6ac
    [42760.737476] [<059b3b43>] update_process_times+0x18/0x34
    [42760.744981] [<6eb94941>] tick_sched_handle.isra.5+0x26/0x38
    [42760.752793] [<478d3d70>] tick_sched_timer+0x1c/0x50
    [42760.759882] [<e56ea39f>] __hrtimer_run_queues+0xc6/0x226
    [42760.767418] [<e88bbcae>] hrtimer_interrupt+0x88/0x19a
    [42760.775031] [<6765a19e>] gic_compare_interrupt+0x2e/0x3a
    [42760.782761] [<0558bf5f>] handle_percpu_devid_irq+0x78/0x168
    [42760.790795] [<90c11ba2>] generic_handle_irq+0x1e/0x2c
    [42760.798117] [<1b6d462c>] gic_handle_local_int+0x38/0x86
    [42760.805545] [<b2ada1c7>] gic_irq_dispatch+0xa/0x14
    [42760.812534] [<90c11ba2>] generic_handle_irq+0x1e/0x2c
    [42760.820086] [<c7521934>] do_IRQ+0x16/0x20
    [42760.826274] [<9aef3ce6>] plat_irq_dispatch+0x62/0x94
    [42760.833458] [<6a94b53c>] except_vec_vi_end+0x70/0x78
    [42760.840655] [<22284043>] smp_call_function_many+0x1ba/0x20c
    [42760.848501] [<54022b58>] smp_call_function+0x1e/0x2c
    [42760.855693] [<ab9fc705>] flush_tlb_mm+0x2a/0x98
    [42760.862730] [<0844cdd0>] tlb_flush_mmu+0x1c/0x44
    [42760.869628] [<cb259b74>] arch_tlb_finish_mmu+0x26/0x3e
    [42760.877021] [<1aeaaf74>] tlb_finish_mmu+0x18/0x66
    [42760.883907] [<b3fce717>] exit_mmap+0x76/0xea
    [42760.890428] [<c4c8a2f6>] mmput+0x80/0x11a
    [42760.896632] [<a41a08f4>] do_exit+0x1f4/0x80c
    [42760.903158] [<ee01cef6>] do_group_exit+0x20/0x7e
    [42760.909990] [<13fa8d54>] __wake_up_parent+0x0/0x1e
    [42760.917045] [<46cf89d0>] smp_call_function_many+0x1a2/0x20c
    [42760.924893] [<8c21a93b>] syscall_common+0x14/0x1c
    [42760.931765] ---[ end trace 02aa09da9dc52a60 ]---
    [42760.938342] ------------[ cut here ]------------
    [42760.945311] WARNING: CPU: 2 PID: 1216 at kernel/smp.c:291 smp_call_function_single+0xee/0xf8
    ...

This patch switches MIPS' arch_trigger_cpumask_backtrace() to use async
IPIs & smp_call_function_single_async() in order to resolve this
problem. We ensure use of the pre-allocated call_single_data_t
structures is serialized by maintaining a cpumask indicating that
they're busy, and refusing to attempt to send an IPI when a CPU's bit is
set in this mask. This should only happen if a CPU hasn't responded to a
previous backtrace IPI - ie. if it's hung - and we print a warning to
the console in this case.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Huacai Chen <chenhc@lemote.com>
Cc: linux-mips@linux-mips.org
---

 arch/mips/kernel/process.c | 45 +++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index d4cfeb931382..2cee3fb07243 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -29,6 +29,7 @@
 #include <linux/kallsyms.h>
 #include <linux/random.h>
 #include <linux/prctl.h>
+#include <linux/nmi.h>
 
 #include <asm/asm.h>
 #include <asm/bootinfo.h>
@@ -655,28 +656,42 @@ unsigned long arch_align_stack(unsigned long sp)
 	return sp & ALMASK;
 }
 
-static void arch_dump_stack(void *info)
-{
-	struct pt_regs *regs;
+static struct cpumask backtrace_csd_busy;
 
-	regs = get_irq_regs();
-
-	if (regs)
-		show_regs(regs);
-	else
-		dump_stack();
+static void handle_backtrace(void *info)
+{
+	nmi_cpu_backtrace(get_irq_regs());
+	cpumask_clear_cpu(smp_processor_id(), &backtrace_csd_busy);
 }
 
-void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
+static void raise_backtrace(cpumask_t *mask)
 {
-	long this_cpu = get_cpu();
+	static DEFINE_PER_CPU(call_single_data_t, static_csd);
+	call_single_data_t *csd;
+	int cpu;
 
-	if (cpumask_test_cpu(this_cpu, mask) && !exclude_self)
-		dump_stack();
+	for_each_cpu(cpu, mask) {
+		/*
+		 * If we previously sent an IPI to the target CPU & it hasn't
+		 * cleared its bit in the busy cpumask then it didn't handle
+		 * our previous IPI & it's not safe for us to reuse the
+		 * call_single_data_t.
+		 */
+		if (cpumask_test_and_set_cpu(cpu, &backtrace_csd_busy)) {
+			pr_warn("Unable to send backtrace IPI to CPU%u - perhaps it hung?\n",
+				cpu);
+			continue;
+		}
 
-	smp_call_function_many(mask, arch_dump_stack, NULL, 1);
+		csd = &per_cpu(static_csd, cpu);
+		csd->func = handle_backtrace;
+		smp_call_function_single_async(cpu, csd);
+	}
+}
 
-	put_cpu();
+void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
+{
+	nmi_trigger_cpumask_backtrace(mask, exclude_self, raise_backtrace);
 }
 
 int mips_get_process_fp_mode(struct task_struct *task)
-- 
2.17.1
