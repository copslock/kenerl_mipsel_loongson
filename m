Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jul 2015 10:29:28 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:64946 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009073AbbGJI30xhIYv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Jul 2015 10:29:26 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id D5E43D373C40C;
        Fri, 10 Jul 2015 09:29:18 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 10 Jul 2015 09:29:20 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.48) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Fri, 10 Jul 2015 09:29:19 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v2] MIPS: mm: c-r4k: Fix cache flushing for MT cores
Date:   Fri, 10 Jul 2015 09:29:10 +0100
Message-ID: <1436516950-13980-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1435746639-7019-1-git-send-email-markos.chandras@imgtec.com>
References: <1435746639-7019-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.48]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48168
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

MT_SMP is not the only SMP option for MT cores. The MT_SMP option
allows more than one VPE per core to appear as a secondary CPU in the
system. Because of how CM works, it propagates the address-based
cache ops to the secondary cores but not the index-based ones.
Because of that, the code does not use IPIs to flush the L1 caches on
secondary cores because the CM would have done that already. However,
the CM functionality is independent of the type of SMP kernel so even in
non-MT kernels, IPIs are not necessary. As a result of which, we change
the conditional to depend on the CM presence. Moreover, since VPEs on
the same core share the same L1 caches, there is no need to send an
IPI on all of them so we calculate a suitable cpumask with only one
VPE per core.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Cc: <stable@vger.kernel.org> # 3.15+
---
Changes since v1:
- Include <asm/mips-cm.h> header
---
 arch/mips/include/asm/smp.h |  1 +
 arch/mips/kernel/smp.c      | 44 +++++++++++++++++++++++++++++++++++++++++++-
 arch/mips/mm/c-r4k.c        | 14 +++++++++++---
 3 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
index 2b25d1ba1ea0..16f1ea9ab191 100644
--- a/arch/mips/include/asm/smp.h
+++ b/arch/mips/include/asm/smp.h
@@ -23,6 +23,7 @@
 extern int smp_num_siblings;
 extern cpumask_t cpu_sibling_map[];
 extern cpumask_t cpu_core_map[];
+extern cpumask_t cpu_foreign_map;
 
 #define raw_smp_processor_id() (current_thread_info()->cpu)
 
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index faa46ebd9dda..d0744cc77ea7 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -63,6 +63,13 @@ EXPORT_SYMBOL(cpu_sibling_map);
 cpumask_t cpu_core_map[NR_CPUS] __read_mostly;
 EXPORT_SYMBOL(cpu_core_map);
 
+/*
+ * A logcal cpu mask containing only one VPE per core to
+ * reduce the number of IPIs on large MT systems.
+ */
+cpumask_t cpu_foreign_map __read_mostly;
+EXPORT_SYMBOL(cpu_foreign_map);
+
 /* representing cpus for which sibling maps can be computed */
 static cpumask_t cpu_sibling_setup_map;
 
@@ -103,6 +110,29 @@ static inline void set_cpu_core_map(int cpu)
 	}
 }
 
+/*
+ * Calculate a new cpu_foreign_map mask whenever a
+ * new cpu appears or disappears.
+ */
+static inline void calculate_cpu_foreign_map(void)
+{
+	int i, k, core_present;
+	cpumask_t temp_foreign_map;
+
+	/* Re-calculate the mask */
+	for_each_online_cpu(i) {
+		core_present = 0;
+		for_each_cpu(k, &temp_foreign_map)
+			if (cpu_data[i].package == cpu_data[k].package &&
+			    cpu_data[i].core == cpu_data[k].core)
+				core_present = 1;
+		if (!core_present)
+			cpumask_set_cpu(i, &temp_foreign_map);
+	}
+
+	cpumask_copy(&cpu_foreign_map, &temp_foreign_map);
+}
+
 struct plat_smp_ops *mp_ops;
 EXPORT_SYMBOL(mp_ops);
 
@@ -146,6 +176,8 @@ asmlinkage void start_secondary(void)
 	set_cpu_sibling_map(cpu);
 	set_cpu_core_map(cpu);
 
+	calculate_cpu_foreign_map();
+
 	cpumask_set_cpu(cpu, &cpu_callin_map);
 
 	synchronise_count_slave(cpu);
@@ -173,9 +205,18 @@ void __irq_entry smp_call_function_interrupt(void)
 static void stop_this_cpu(void *dummy)
 {
 	/*
-	 * Remove this CPU:
+	 * Remove this CPU. Be a bit slow here and
+	 * set the bits for every online CPU so we don't miss
+	 * any IPI whilst taking this VPE down.
 	 */
+
+	cpumask_copy(&cpu_foreign_map, cpu_online_mask);
+
+	/* Make it visible to every other CPU */
+	smp_mb();
+
 	set_cpu_online(smp_processor_id(), false);
+	calculate_cpu_foreign_map();
 	local_irq_disable();
 	while (1);
 }
@@ -197,6 +238,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	mp_ops->prepare_cpus(max_cpus);
 	set_cpu_sibling_map(0);
 	set_cpu_core_map(0);
+	calculate_cpu_foreign_map();
 #ifndef CONFIG_HOTPLUG_CPU
 	init_cpu_present(cpu_possible_mask);
 #endif
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 375ccf678e9d..fbea4432f3f2 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -37,6 +37,7 @@
 #include <asm/cacheflush.h> /* for run_uncached() */
 #include <asm/traps.h>
 #include <asm/dma-coherence.h>
+#include <asm/mips-cm.h>
 
 /*
  * Special Variant of smp_call_function for use by cache functions:
@@ -51,9 +52,16 @@ static inline void r4k_on_each_cpu(void (*func) (void *info), void *info)
 {
 	preempt_disable();
 
-#ifndef CONFIG_MIPS_MT_SMP
-	smp_call_function(func, info, 1);
-#endif
+	/*
+	 * The Coherent Manager propagates address-based cache ops to other
+	 * cores but not index-based ops. However, r4k_on_each_cpu is used
+	 * in both cases so there is no easy way to tell what kind of op is
+	 * executed to the other cores. The best we can probably do is
+	 * to restrict that call when a CM is not present because both
+	 * CM-based SMP protocols (CMP & CPS) restrict index-based cache ops.
+	 */
+	if (!mips_cm_present())
+		smp_call_function_many(&cpu_foreign_map, func, info, 1);
 	func(info);
 	preempt_enable();
 }
-- 
2.4.5
