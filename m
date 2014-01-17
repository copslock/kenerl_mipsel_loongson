Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jan 2014 17:20:22 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:54825 "EHLO localhost"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6817237AbaAQQTWYtft2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Jan 2014 17:19:22 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1W4C8T-0005A3-RL; Fri, 17 Jan 2014 10:19:09 -0600
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     blogic@openwrt.org
Subject: [PATCH 1/3] MIPS: CMP: Add support for CPU hotplugging.
Date:   Fri, 17 Jan 2014 10:18:53 -0600
Message-Id: <1389975535-62279-2-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1389975535-62279-1-git-send-email-Steven.Hill@imgtec.com>
References: <1389975535-62279-1-git-send-email-Steven.Hill@imgtec.com>
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39025
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

From: "Steven J. Hill" <Steven.Hill@imgtec.com>

Adds support CPU hotplugging using the CM/CM2 functionality.

Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/include/asm/gcmpregs.h |    2 +
 arch/mips/kernel/irq-gic.c       |    6 +-
 arch/mips/kernel/smp-cmp.c       |  167 +++++++++++++++++++++++++++-----------
 3 files changed, 124 insertions(+), 51 deletions(-)

diff --git a/arch/mips/include/asm/gcmpregs.h b/arch/mips/include/asm/gcmpregs.h
index a7359f7..d01315e 100644
--- a/arch/mips/include/asm/gcmpregs.h
+++ b/arch/mips/include/asm/gcmpregs.h
@@ -11,6 +11,8 @@
 #ifndef _ASM_GCMPREGS_H
 #define _ASM_GCMPREGS_H
 
+extern unsigned long _gcmp_base;
+extern int gcmp_present;
 
 /* Offsets to major blocks within GCMP from GCMP base */
 #define GCMP_GCB_OFS		0x0000 /* Global Control Block */
diff --git a/arch/mips/kernel/irq-gic.c b/arch/mips/kernel/irq-gic.c
index 5b5ddb2..cf8ef7d 100644
--- a/arch/mips/kernel/irq-gic.c
+++ b/arch/mips/kernel/irq-gic.c
@@ -213,13 +213,13 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
 	unsigned long	flags;
 	int		i;
 
+	/* Assumption : cpumask refers to a single CPU */
+	spin_lock_irqsave(&gic_lock, flags);
+
 	cpumask_and(&tmp, cpumask, cpu_online_mask);
 	if (cpus_empty(tmp))
 		return -1;
 
-	/* Assumption : cpumask refers to a single CPU */
-	spin_lock_irqsave(&gic_lock, flags);
-
 	/* Re-route this IRQ */
 	GIC_SH_MAP_TO_VPE_SMASK(irq, first_cpu(tmp));
 
diff --git a/arch/mips/kernel/smp-cmp.c b/arch/mips/kernel/smp-cmp.c
index 1b925d8..3984c01 100644
--- a/arch/mips/kernel/smp-cmp.c
+++ b/arch/mips/kernel/smp-cmp.c
@@ -1,43 +1,25 @@
 /*
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
  *
  * Copyright (C) 2007 MIPS Technologies, Inc.
  *    Chris Dearman (chris@mips.com)
+ * Copyright (C) 2013  Imagination Technologies Ltd.
  */
-
 #undef DEBUG
 
-#include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/smp.h>
-#include <linux/cpumask.h>
 #include <linux/interrupt.h>
-#include <linux/compiler.h>
+#include <linux/cpu.h>
 
-#include <linux/atomic.h>
-#include <asm/cacheflush.h>
-#include <asm/cpu.h>
-#include <asm/processor.h>
-#include <asm/hardirq.h>
 #include <asm/mmu_context.h>
-#include <asm/smp.h>
 #include <asm/time.h>
-#include <asm/mipsregs.h>
-#include <asm/mipsmtregs.h>
 #include <asm/mips_mt.h>
 #include <asm/amon.h>
 #include <asm/gic.h>
+#include <asm/gcmpregs.h>
+#include <asm/mips-boards/launch.h>
 
 static void ipi_call_function(unsigned int cpu)
 {
@@ -56,11 +38,7 @@ static void ipi_resched(unsigned int cpu)
 	gic_send_ipi(plat_ipi_resched_int_xlate(cpu));
 }
 
-/*
- * FIXME: This isn't restricted to CMP
- * The SMVP kernel could use GIC interrupts if available
- */
-void cmp_send_ipi_single(int cpu, unsigned int action)
+static void cmp_send_ipi_single(int cpu, unsigned int action)
 {
 	unsigned long flags;
 
@@ -112,15 +90,14 @@ static void cmp_smp_finish(void)
 {
 	pr_debug("SMPCMP: CPU%d: %s\n", smp_processor_id(), __func__);
 
-	/* CDFIXME: remove this? */
-	write_c0_compare(read_c0_count() + (8 * mips_hpt_frequency / HZ));
-
 #ifdef CONFIG_MIPS_MT_FPAFF
 	/* If we have an FPU, enroll ourselves in the FPU-full mask */
 	if (cpu_has_fpu)
 		cpu_set(smp_processor_id(), mt_fpu_cpumask);
 #endif /* CONFIG_MIPS_MT_FPAFF */
 
+	/* to generate the first CPU timer interrupt */
+	write_c0_compare(read_c0_count() + mips_hpt_frequency / HZ);
 	local_irq_enable();
 }
 
@@ -142,15 +119,6 @@ static void cmp_boot_secondary(int cpu, struct task_struct *idle)
 	unsigned long pc = (unsigned long)&smp_bootstrap;
 	unsigned long a0 = 0;
 
-	pr_debug("SMPCMP: CPU%d: %s cpu %d\n", smp_processor_id(),
-		__func__, cpu);
-
-#if 0
-	/* Needed? */
-	flush_icache_range((unsigned long)gp,
-			   (unsigned long)(gp + sizeof(struct thread_info)));
-#endif
-
 	amon_cpu_start(cpu, pc, sp, (unsigned long)gp, a0);
 }
 
@@ -159,8 +127,7 @@ static void cmp_boot_secondary(int cpu, struct task_struct *idle)
  */
 void __init cmp_smp_setup(void)
 {
-	int i;
-	int ncpu = 0;
+	int ncpu, i;
 
 	pr_debug("SMPCMP: CPU%d: %s\n", smp_processor_id(), __func__);
 
@@ -170,11 +137,16 @@ void __init cmp_smp_setup(void)
 		cpu_set(0, mt_fpu_cpumask);
 #endif /* CONFIG_MIPS_MT_FPAFF */
 
-	for (i = 1; i < NR_CPUS; i++) {
-		if (amon_cpu_avail(i)) {
+	__cpu_number_map[0] = 0;
+	__cpu_logical_map[0] = 0;
+
+
+	for (i = 1, ncpu = 0; i < nr_cpu_ids; i++) {
+		if (amon_cpu_avail(i) == LAUNCH_FREADY) {
 			set_cpu_possible(i, true);
-			__cpu_number_map[i]	= ++ncpu;
-			__cpu_logical_map[ncpu] = i;
+			set_cpu_present(i, true);
+			__cpu_number_map[i] = ++ncpu;
+			__cpu_logical_map[ncpu]	= i;
 		}
 	}
 
@@ -209,6 +181,101 @@ void __init cmp_prepare_cpus(unsigned int max_cpus)
 
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+
+/* State of each CPU. */
+DEFINE_PER_CPU(int, cpu_state);
+
+static int cmp_cpu_disable(void)
+{
+	unsigned int cpu = smp_processor_id();
+
+	if (cpu == 0)
+		return -EBUSY;
+
+	set_cpu_online(cpu, false);
+	cpu_clear(cpu, cpu_callin_map);
+	local_irq_disable();
+	__flush_cache_all();
+	local_flush_tlb_all();
+	clear_tasks_mm_cpumask(cpu);
+
+	return 0;
+}
+
+static void cmp_cpu_die(unsigned int cpu)
+{
+	while (per_cpu(cpu_state, cpu) != CPU_DEAD)
+		cpu_relax();
+	/*
+	 * If all of the CPU's on the other core are now disabled
+	 * the core can be powered down
+	 */
+}
+
+void play_dead(void)
+{
+	int cpu = smp_processor_id();
+
+	idle_task_exit();
+
+	per_cpu(cpu_state, cpu) = CPU_DEAD;
+
+	/*
+	 * This CPU is now inactive. Other CPU's (VPE's) on the
+	 * same core may still be active
+	 */
+	amon_cpu_dead();	/* This will not return */
+}
+
+static int cmp_cpu_callback(struct notifier_block *nfb,
+	unsigned long action, void *hcpu)
+{
+	unsigned int cpu = (unsigned long)hcpu;
+
+	switch (action) {
+	case CPU_UP_PREPARE:
+		pr_debug("CPU_UP_PREPARE for cpu#%d\n", cpu);
+		break;
+	case CPU_ONLINE:
+		pr_debug("CPU_ONLINE for cpu#%d\n", cpu);
+		break;
+	case CPU_DOWN_PREPARE:
+		pr_debug("CPU_DOWN_PREPARE for cpu#%d\n", cpu);
+		break;
+	case CPU_DYING:
+		pr_debug("CPU_DYING for cpu#%d\n", cpu);
+		break;
+	case CPU_DEAD:
+		pr_debug("CPU_DEAD for cpu#%d\n", cpu);
+		break;
+	case CPU_POST_DEAD:
+		pr_debug("CPU_POST_DEAD for cpu#%d\n", cpu);
+		break;
+	case CPU_STARTING:
+		pr_debug("CPU_STARTING for cpu#%d\n", cpu);
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block cmp_cpu_notifier = {
+	.notifier_call = cmp_cpu_callback,
+};
+
+static int register_cmp_notifier(void)
+{
+	register_hotcpu_notifier(&cmp_cpu_notifier);
+
+	return 0;
+}
+
+late_initcall(register_cmp_notifier);
+
+#endif  /* CONFIG_HOTPLUG_CPU */
+
+
 struct plat_smp_ops cmp_smp_ops = {
 	.send_ipi_single	= cmp_send_ipi_single,
 	.send_ipi_mask		= cmp_send_ipi_mask,
@@ -218,4 +285,8 @@ struct plat_smp_ops cmp_smp_ops = {
 	.boot_secondary		= cmp_boot_secondary,
 	.smp_setup		= cmp_smp_setup,
 	.prepare_cpus		= cmp_prepare_cpus,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_disable		= cmp_cpu_disable,
+	.cpu_die		= cmp_cpu_die,
+#endif
 };
-- 
1.7.10.4
