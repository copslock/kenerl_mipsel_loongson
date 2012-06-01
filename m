Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jun 2012 11:13:39 +0200 (CEST)
Received: from e28smtp02.in.ibm.com ([122.248.162.2]:45503 "EHLO
        e28smtp02.in.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903605Ab2FAJN3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Jun 2012 11:13:29 +0200
Received: from /spool/local
        by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
        Fri, 1 Jun 2012 14:43:21 +0530
Received: from d28relay03.in.ibm.com (9.184.220.60)
        by e28smtp02.in.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Fri, 1 Jun 2012 14:43:18 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
        by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q519DHGn55443464;
        Fri, 1 Jun 2012 14:43:17 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
        by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q51Egpu6026697;
        Fri, 1 Jun 2012 20:12:53 +0530
Received: from srivatsabhat.in.ibm.com (srivatsabhat.in.ibm.com [9.124.35.113])
        by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id q51EgoMF026615;
        Fri, 1 Jun 2012 20:12:50 +0530
From:   "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 10/27] mips, smpboot: Use generic SMP booting infrastructure
To:     tglx@linutronix.de, peterz@infradead.org,
        paulmck@linux.vnet.ibm.com
Cc:     rusty@rustcorp.com.au, mingo@kernel.org, yong.zhang0@gmail.com,
        akpm@linux-foundation.org, vatsa@linux.vnet.ibm.com, rjw@sisk.pl,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        srivatsa.bhat@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
        Ralf Baechle <ralf@linux-mips.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Mike Frysinger <vapier@gentoo.org>,
        David Howells <dhowells@redhat.com>,
        Arun Sharma <asharma@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rusty Russell <rusty@rustcorp.com.au>,
        linux-mips@linux-mips.org
Date:   Fri, 01 Jun 2012 14:42:32 +0530
Message-ID: <20120601091226.31979.62223.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20120601090952.31979.24799.stgit@srivatsabhat.in.ibm.com>
References: <20120601090952.31979.24799.stgit@srivatsabhat.in.ibm.com>
User-Agent: StGIT/0.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
x-cbid: 12060109-5816-0000-0000-000002F5CFC1
X-archive-position: 33503
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: srivatsa.bhat@linux.vnet.ibm.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Convert mips to use the generic framework to boot secondary CPUs.

Notes:
1. The boot processor was setting the secondary cpu in cpu_online_mask!
Instead, leave it up to the secondary cpu (... and it will be done by the
generic code now).

2. Make the boot cpu wait for the secondary cpu to be set in cpu_online_mask
before returning.

3. Don't enable interrupts in cmp_smp_finish() and vsmp_smp_finish().
Do it much later, in generic code.

4. In synchronise_count_slave(), use local_save_flags() instead of
local_irq_save() because irqs are still disabled.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Mike Frysinger <vapier@gentoo.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Arun Sharma <asharma@fb.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-mips@linux-mips.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/mips/kernel/smp-cmp.c  |    8 ++++----
 arch/mips/kernel/smp-mt.c   |    2 --
 arch/mips/kernel/smp.c      |   23 +++++++++++++++--------
 arch/mips/kernel/sync-r4k.c |    3 ++-
 4 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/arch/mips/kernel/smp-cmp.c b/arch/mips/kernel/smp-cmp.c
index e7e03ec..7ecd6db 100644
--- a/arch/mips/kernel/smp-cmp.c
+++ b/arch/mips/kernel/smp-cmp.c
@@ -108,7 +108,9 @@ static void cmp_init_secondary(void)
 
 static void cmp_smp_finish(void)
 {
-	pr_debug("SMPCMP: CPU%d: %s\n", smp_processor_id(), __func__);
+	unsigned int cpu = smp_processor_id();
+
+	pr_debug("SMPCMP: CPU%d: %s\n", cpu, __func__);
 
 	/* CDFIXME: remove this? */
 	write_c0_compare(read_c0_count() + (8 * mips_hpt_frequency / HZ));
@@ -116,10 +118,8 @@ static void cmp_smp_finish(void)
 #ifdef CONFIG_MIPS_MT_FPAFF
 	/* If we have an FPU, enroll ourselves in the FPU-full mask */
 	if (cpu_has_fpu)
-		cpu_set(smp_processor_id(), mt_fpu_cpumask);
+		cpumask_set_cpu(cpu, &mt_fpu_cpumask);
 #endif /* CONFIG_MIPS_MT_FPAFF */
-
-	local_irq_enable();
 }
 
 static void cmp_cpus_done(void)
diff --git a/arch/mips/kernel/smp-mt.c b/arch/mips/kernel/smp-mt.c
index ff17868..25f7b09 100644
--- a/arch/mips/kernel/smp-mt.c
+++ b/arch/mips/kernel/smp-mt.c
@@ -171,8 +171,6 @@ static void __cpuinit vsmp_smp_finish(void)
 	if (cpu_has_fpu)
 		cpu_set(smp_processor_id(), mt_fpu_cpumask);
 #endif /* CONFIG_MIPS_MT_FPAFF */
-
-	local_irq_enable();
 }
 
 static void vsmp_cpus_done(void)
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 71a95f5..4453d4d 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -33,6 +33,7 @@
 #include <linux/cpu.h>
 #include <linux/err.h>
 #include <linux/ftrace.h>
+#include <linux/smpboot.h>
 
 #include <linux/atomic.h>
 #include <asm/cpu.h>
@@ -98,8 +99,11 @@ __cpuinit void register_smp_ops(struct plat_smp_ops *ops)
  */
 asmlinkage __cpuinit void start_secondary(void)
 {
-	unsigned int cpu;
+	smpboot_start_secondary(NULL);
+}
 
+void __cpuinit __cpu_pre_starting(void *unused)
+{
 #ifdef CONFIG_MIPS_MT_SMTC
 	/* Only do cpu_probe for first TC of CPU */
 	if ((read_c0_tcbind() & TCBIND_CURTC) == 0)
@@ -116,20 +120,22 @@ asmlinkage __cpuinit void start_secondary(void)
 	 */
 
 	calibrate_delay();
-	preempt_disable();
-	cpu = smp_processor_id();
-	cpu_data[cpu].udelay_val = loops_per_jiffy;
+	cpu_data[smp_processor_id()].udelay_val = loops_per_jiffy;
+}
 
-	notify_cpu_starting(cpu);
+void __cpuinit __cpu_pre_online(void *unused)
+{
+	unsigned int cpu = smp_processor_id();
 
 	mp_ops->smp_finish();
 	set_cpu_sibling_map(cpu);
 
 	cpu_set(cpu, cpu_callin_map);
+}
 
+void __cpuinit __cpu_post_online(void *unused)
+{
 	synchronise_count_slave();
-
-	cpu_idle();
 }
 
 /*
@@ -196,7 +202,8 @@ int __cpuinit __cpu_up(unsigned int cpu, struct task_struct *tidle)
 	while (!cpu_isset(cpu, cpu_callin_map))
 		udelay(100);
 
-	set_cpu_online(cpu, true);
+	while (!cpu_online(cpu))
+		udelay(100);
 
 	return 0;
 }
diff --git a/arch/mips/kernel/sync-r4k.c b/arch/mips/kernel/sync-r4k.c
index 99f913c..7f43069 100644
--- a/arch/mips/kernel/sync-r4k.c
+++ b/arch/mips/kernel/sync-r4k.c
@@ -46,7 +46,8 @@ void __cpuinit synchronise_count_master(void)
 	printk(KERN_INFO "Synchronize counters across %u CPUs: ",
 	       num_online_cpus());
 
-	local_irq_save(flags);
+	/* IRQs are already disabled. So just save the flags */
+	local_save_flags(flags);
 
 	/*
 	 * Notify the slaves that it's time to start
