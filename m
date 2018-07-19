Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jul 2018 10:21:03 +0200 (CEST)
Received: from mail-pg1-x544.google.com ([IPv6:2607:f8b0:4864:20::544]:43937
        "EHLO mail-pg1-x544.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992554AbeGSIU6r0Rqi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Jul 2018 10:20:58 +0200
Received: by mail-pg1-x544.google.com with SMTP id v13-v6so3273806pgr.10;
        Thu, 19 Jul 2018 01:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cOU+EpKxAXUczVvRLAuoZEtQWbsI0iqqmHd3wMFjiwQ=;
        b=CP8V/fm5BMDBcQ7yKt/w7zVgRotoEiaKwfN2s+6QY80MuhSTOcrwF5ndvOIG6WQKxI
         /TFWwjb3K8KviY0tbHd3ioTvbfCPGcpAKltMJ49p8XAZSG2PrGTFBMSt+IakYrR9uXof
         ApyPbOH6pQ72S+wrYx4K1cp3ckX6J4kSs6fZY/GM+oFmIuSJy+fT0KPTYhorlaotQ4Cz
         AoW8SChklFGYjOKCswFhZwCbTkSs2fQr7HeEMcfiABjeE1sg+YN4zdcPnqkNWvT1nVKr
         Nvltw21RBXKm2nbFNx58fIuzBvcjHesr+5b1tZQRunhgCeU5zlsbZ8sto/e/XufRrK6a
         HZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=cOU+EpKxAXUczVvRLAuoZEtQWbsI0iqqmHd3wMFjiwQ=;
        b=FxdTBP6w2tdSM9caumVJX3q2KU2RxRTPjGJTTuCZUfII9gToppFclyJjKBpkDh8eVB
         jLD7KV40ivdekuejV3Hx1nVM2rLNe5RPBOpMUOo5q2wrXQUQzgUUejd28SPty/730cSw
         P63wANp9ZgpaWFVwfcQ8RBcSo/a87USweA4hcoI61Ct6+/Ob6IvmF4db45zIXHTcShJI
         hzvYI+2kvVhqMoQoeoOhsC3CN/+dGcRkBVZnHhWgNs/nQccKXjhnbPUHC8CSAB0MQeSB
         LyeSu1e8d1SfqKn0c89NzTSc3yw2teJ+GeQ35Tlsx2hp2XN1Q5+KrK/sojWzKzrPVaLf
         GnMg==
X-Gm-Message-State: AOUpUlHltRyqMMrfeG1frCHitiBpudNUEqUFVwIDX2oRU/8wfVvFCMUM
        DCl2D3JuuWC7s6gL11LWs8AabRKNOA4=
X-Google-Smtp-Source: AAOMgpdluWTuQUvgms3N2E/ZJg6Ki4GEcVFqVciFz7Y+sMcG9bk7xiaW5B9JoebDZV0CBrKMr/BkHQ==
X-Received: by 2002:a63:6949:: with SMTP id e70-v6mr9293364pgc.119.1531988450623;
        Thu, 19 Jul 2018 01:20:50 -0700 (PDT)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id i6-v6sm7728360pfo.107.2018.07.19.01.20.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jul 2018 01:20:50 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>, stable@vger.kernel.org,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 2/2 4.4 Backport] MIPS: Use async IPIs for arch_trigger_cpumask_backtrace()
Date:   Thu, 19 Jul 2018 16:25:20 +0800
Message-Id: <1531988720-2431-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1531988720-2431-1-git-send-email-chenhc@lemote.com>
References: <1531988720-2431-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64944
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

From: Paul Burton <paul.burton@mips.com>

commit b63e132b6433a41cf311e8bc382d33fd2b73b505 upstream.

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

I've marked this for stable branches as far back as v4.9, to which it
applies cleanly. Strictly speaking the faulty MIPS implementation can be
traced further back to commit 856839b76836 ("MIPS: Add
arch_trigger_all_cpu_backtrace() function") in v3.19, but kernel
versions v3.19 through v4.8 will require further work to backport due to
the rework performed in commit 9a01c3ed5cdb ("nmi_backtrace: add more
trigger_*_cpu_backtrace() methods").

Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/19597/
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org
Fixes: 856839b76836 ("MIPS: Add arch_trigger_all_cpu_backtrace() function")
Fixes: 9a01c3ed5cdb ("nmi_backtrace: add more trigger_*_cpu_backtrace() methods")
[ Huacai: backported to 4.4: Restruction since generic NMI solution is unavailable ]
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/kernel/process.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index f96048a..354b99f 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -629,21 +629,48 @@ unsigned long arch_align_stack(unsigned long sp)
 	return sp & ALMASK;
 }
 
+static DEFINE_PER_CPU(struct call_single_data, backtrace_csd);
+static struct cpumask backtrace_csd_busy;
+
 static void arch_dump_stack(void *info)
 {
 	struct pt_regs *regs;
+	static arch_spinlock_t lock = __ARCH_SPIN_LOCK_UNLOCKED;
 
+	arch_spin_lock(&lock);
 	regs = get_irq_regs();
 
 	if (regs)
 		show_regs(regs);
 	else
 		dump_stack();
+	arch_spin_unlock(&lock);
+
+	cpumask_clear_cpu(smp_processor_id(), &backtrace_csd_busy);
 }
 
 void arch_trigger_all_cpu_backtrace(bool include_self)
 {
-	smp_call_function(arch_dump_stack, NULL, 1);
+	struct call_single_data *csd;
+	int cpu;
+
+	for_each_cpu(cpu, cpu_online_mask) {
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
+
+		csd = &per_cpu(backtrace_csd, cpu);
+		csd->func = arch_dump_stack;
+		smp_call_function_single_async(cpu, csd);
+	}
 }
 
 int mips_get_process_fp_mode(struct task_struct *task)
-- 
2.7.0
