Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Aug 2015 17:55:26 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:14860 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012122AbbHCPzYjPh04 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Aug 2015 17:55:24 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 61F6CB830A0F3;
        Mon,  3 Aug 2015 16:55:15 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 3 Aug 2015 16:55:18 +0100
Received: from localhost (192.168.159.95) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 3 Aug
 2015 16:55:17 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Joshua Kinard <kumba@gentoo.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Huacai Chen <chenhc@lemote.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        "Maciej W. Rozycki" <macro@codesourcery.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alex Smith <alex.smith@imgtec.com>
Subject: [PATCH] MIPS: c-r4k: remove cpu_foreign_map
Date:   Mon, 3 Aug 2015 08:54:47 -0700
Message-ID: <1438617288-25261-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.5.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.95]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48549
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

Commit cccf34e9411c ("MIPS: c-r4k: Fix cache flushing for MT cores") did
2 things:

  - Introduced cpu_foreign_map to call cache maintenance functions on
    only a single CPU within each core in the system.

  - Stopped calling cache maintenance functions on non-local CPUs for
    systems which include a MIPS Coherence Manager.

Thus the introduction of cpu_foreign_map has no effect on any systems
with a CM, since the IPIs will be avoided entirely. Thus it can only
possibly affect other systems which have multiple logical CPUs per core,
which appears to only be netlogic. I'm pretty certain this wasn't the
intent, am unsure whether avoiding such cache maintenance calls is
correct for netlogic systems and believe the overhead of calculating
cpu_foreign_map is thus unnecessary & this code is almost certainly
untested.

This mostly reverts commit cccf34e9411c ("MIPS: c-r4k: Fix cache
flushing for MT cores"), leaving only the change for systems with a CM.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/include/asm/smp.h |  1 -
 arch/mips/kernel/smp.c      | 44 +-------------------------------------------
 arch/mips/mm/c-r4k.c        |  2 +-
 3 files changed, 2 insertions(+), 45 deletions(-)

diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
index 03722d4..a036e1f 100644
--- a/arch/mips/include/asm/smp.h
+++ b/arch/mips/include/asm/smp.h
@@ -23,7 +23,6 @@
 extern int smp_num_siblings;
 extern cpumask_t cpu_sibling_map[];
 extern cpumask_t cpu_core_map[];
-extern cpumask_t cpu_foreign_map;
 
 #define raw_smp_processor_id() (current_thread_info()->cpu)
 
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index a31896c..184876b 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -63,13 +63,6 @@ EXPORT_SYMBOL(cpu_sibling_map);
 cpumask_t cpu_core_map[NR_CPUS] __read_mostly;
 EXPORT_SYMBOL(cpu_core_map);
 
-/*
- * A logcal cpu mask containing only one VPE per core to
- * reduce the number of IPIs on large MT systems.
- */
-cpumask_t cpu_foreign_map __read_mostly;
-EXPORT_SYMBOL(cpu_foreign_map);
-
 /* representing cpus for which sibling maps can be computed */
 static cpumask_t cpu_sibling_setup_map;
 
@@ -110,29 +103,6 @@ static inline void set_cpu_core_map(int cpu)
 	}
 }
 
-/*
- * Calculate a new cpu_foreign_map mask whenever a
- * new cpu appears or disappears.
- */
-static inline void calculate_cpu_foreign_map(void)
-{
-	int i, k, core_present;
-	cpumask_t temp_foreign_map;
-
-	/* Re-calculate the mask */
-	for_each_online_cpu(i) {
-		core_present = 0;
-		for_each_cpu(k, &temp_foreign_map)
-			if (cpu_data[i].package == cpu_data[k].package &&
-			    cpu_data[i].core == cpu_data[k].core)
-				core_present = 1;
-		if (!core_present)
-			cpumask_set_cpu(i, &temp_foreign_map);
-	}
-
-	cpumask_copy(&cpu_foreign_map, &temp_foreign_map);
-}
-
 struct plat_smp_ops *mp_ops;
 EXPORT_SYMBOL(mp_ops);
 
@@ -176,8 +146,6 @@ asmlinkage void start_secondary(void)
 	set_cpu_sibling_map(cpu);
 	set_cpu_core_map(cpu);
 
-	calculate_cpu_foreign_map();
-
 	cpumask_set_cpu(cpu, &cpu_callin_map);
 
 	synchronise_count_slave(cpu);
@@ -195,18 +163,9 @@ asmlinkage void start_secondary(void)
 static void stop_this_cpu(void *dummy)
 {
 	/*
-	 * Remove this CPU. Be a bit slow here and
-	 * set the bits for every online CPU so we don't miss
-	 * any IPI whilst taking this VPE down.
+	 * Remove this CPU:
 	 */
-
-	cpumask_copy(&cpu_foreign_map, cpu_online_mask);
-
-	/* Make it visible to every other CPU */
-	smp_mb();
-
 	set_cpu_online(smp_processor_id(), false);
-	calculate_cpu_foreign_map();
 	local_irq_disable();
 	while (1);
 }
@@ -228,7 +187,6 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	mp_ops->prepare_cpus(max_cpus);
 	set_cpu_sibling_map(0);
 	set_cpu_core_map(0);
-	calculate_cpu_foreign_map();
 #ifndef CONFIG_HOTPLUG_CPU
 	init_cpu_present(cpu_possible_mask);
 #endif
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 5d3a25e..54f254c 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -61,7 +61,7 @@ static inline void r4k_on_each_cpu(void (*func) (void *info), void *info)
 	 * CM-based SMP protocols (CMP & CPS) restrict index-based cache ops.
 	 */
 	if (!mips_cm_present())
-		smp_call_function_many(&cpu_foreign_map, func, info, 1);
+		smp_call_function(func, info, 1);
 	func(info);
 	preempt_enable();
 }
-- 
2.5.0
