Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 04:55:51 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:27868 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992993AbdHMCyEwPq96 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2017 04:54:04 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 7F7902994301;
        Sun, 13 Aug 2017 03:53:56 +0100 (IST)
Received: from localhost (10.20.79.142) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 13 Aug
 2017 03:53:57 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 13/19] MIPS: Unify checks for sibling CPUs
Date:   Sat, 12 Aug 2017 19:49:37 -0700
Message-ID: <20170813024943.14989-14-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.0
In-Reply-To: <20170813024943.14989-1-paul.burton@imgtec.com>
References: <20170813024943.14989-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.79.142]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59509
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

Up until now we have open-coded checks for whether CPUs are siblings,
with slight variations on whether we consider the package ID or not.

This will only get more complex when we introduce cluster support, so in
preparation for that this patch introduces a cpus_are_siblings()
function which can be used to check whether or not 2 CPUs are siblings
in a consistent manner.

By checking globalnumber with the VP ID masked out this also has the
neat side effect of being ready for multi-cluster systems already.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/include/asm/cpu-info.h | 17 +++++++++++++++++
 arch/mips/kernel/smp-cps.c       |  8 ++++----
 arch/mips/kernel/smp.c           | 12 +++++-------
 drivers/cpuidle/cpuidle-cps.c    |  2 +-
 drivers/irqchip/irq-mips-cpu.c   |  2 +-
 5 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/cpu-info.h
index 9ae927282b12..0c61bdc82a53 100644
--- a/arch/mips/include/asm/cpu-info.h
+++ b/arch/mips/include/asm/cpu-info.h
@@ -158,6 +158,23 @@ static inline unsigned int cpu_vpe_id(struct cpuinfo_mips *cpuinfo)
 extern void cpu_set_core(struct cpuinfo_mips *cpuinfo, unsigned int core);
 extern void cpu_set_vpe_id(struct cpuinfo_mips *cpuinfo, unsigned int vpe);
 
+static inline bool cpus_are_siblings(int cpua, int cpub)
+{
+	struct cpuinfo_mips *infoa = &cpu_data[cpua];
+	struct cpuinfo_mips *infob = &cpu_data[cpub];
+	unsigned int gnuma, gnumb;
+
+	if (infoa->package != infob->package)
+		return false;
+
+	gnuma = infoa->globalnumber & ~MIPS_GLOBALNUMBER_VP;
+	gnumb = infob->globalnumber & ~MIPS_GLOBALNUMBER_VP;
+	if (gnuma != gnumb)
+		return false;
+
+	return true;
+}
+
 static inline unsigned long cpu_asid_inc(void)
 {
 	return 1 << CONFIG_MIPS_ASID_SHIFT;
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 699459ed293b..8cc508809466 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -147,7 +147,7 @@ static void __init cps_prepare_cpus(unsigned int max_cpus)
 			cpu_has_dc_aliases ? "dcache aliasing" : "");
 
 		for_each_present_cpu(c) {
-			if (cpu_core(&cpu_data[c]))
+			if (!cpus_are_siblings(smp_processor_id(), c))
 				set_cpu_present(c, false);
 		}
 	}
@@ -319,10 +319,10 @@ static void cps_boot_secondary(int cpu, struct task_struct *idle)
 		mips_cm_unlock_other();
 	}
 
-	if (core != cpu_core(&current_cpu_data)) {
+	if (!cpus_are_siblings(cpu, smp_processor_id())) {
 		/* Boot a VPE on another powered up core */
 		for (remote = 0; remote < NR_CPUS; remote++) {
-			if (cpu_core(&cpu_data[remote]) != core)
+			if (!cpus_are_siblings(cpu, remote))
 				continue;
 			if (cpu_online(remote))
 				break;
@@ -431,7 +431,7 @@ void play_dead(void)
 
 		/* Look for another online VPE within the core */
 		for_each_online_cpu(cpu_death_sibling) {
-			if (cpu_core(&cpu_data[cpu_death_sibling]) != core)
+			if (!cpus_are_siblings(cpu, cpu_death_sibling))
 				continue;
 
 			/*
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index a54e5857c227..4cc43892b959 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -96,8 +96,7 @@ static inline void set_cpu_sibling_map(int cpu)
 
 	if (smp_num_siblings > 1) {
 		for_each_cpu(i, &cpu_sibling_setup_map) {
-			if (cpu_data[cpu].package == cpu_data[i].package &&
-			    cpu_core(&cpu_data[cpu]) == cpu_core(&cpu_data[i])) {
+			if (cpus_are_siblings(cpu, i)) {
 				cpumask_set_cpu(i, &cpu_sibling_map[cpu]);
 				cpumask_set_cpu(cpu, &cpu_sibling_map[i]);
 			}
@@ -134,8 +133,7 @@ void calculate_cpu_foreign_map(void)
 	for_each_online_cpu(i) {
 		core_present = 0;
 		for_each_cpu(k, &temp_foreign_map)
-			if (cpu_data[i].package == cpu_data[k].package &&
-			    cpu_core(&cpu_data[i]) == cpu_core(&cpu_data[k]))
+			if (cpus_are_siblings(i, k))
 				core_present = 1;
 		if (!core_present)
 			cpumask_set_cpu(i, &temp_foreign_map);
@@ -186,11 +184,11 @@ void mips_smp_send_ipi_mask(const struct cpumask *mask, unsigned int action)
 
 	if (mips_cpc_present()) {
 		for_each_cpu(cpu, mask) {
-			core = cpu_core(&cpu_data[cpu]);
-
-			if (core == cpu_core(&current_cpu_data))
+			if (cpus_are_siblings(cpu, smp_processor_id()))
 				continue;
 
+			core = cpu_core(&cpu_data[cpu]);
+
 			while (!cpumask_test_cpu(cpu, &cpu_coherent_mask)) {
 				mips_cm_lock_other(core, 0);
 				mips_cpc_lock_other(core);
diff --git a/drivers/cpuidle/cpuidle-cps.c b/drivers/cpuidle/cpuidle-cps.c
index 6041b6104f3d..72b5e47286b4 100644
--- a/drivers/cpuidle/cpuidle-cps.c
+++ b/drivers/cpuidle/cpuidle-cps.c
@@ -37,7 +37,7 @@ static int cps_nc_enter(struct cpuidle_device *dev,
 	 * TODO: don't treat core 0 specially, just prevent the final core
 	 * TODO: remap interrupt affinity temporarily
 	 */
-	if (!cpu_core(&cpu_data[dev->cpu]) && (index > STATE_NC_WAIT))
+	if (cpus_are_siblings(0, dev->cpu) && (index > STATE_NC_WAIT))
 		index = STATE_NC_WAIT;
 
 	/* Select the appropriate cps_pm_state */
diff --git a/drivers/irqchip/irq-mips-cpu.c b/drivers/irqchip/irq-mips-cpu.c
index 14461cbfab2f..66f97fde13d8 100644
--- a/drivers/irqchip/irq-mips-cpu.c
+++ b/drivers/irqchip/irq-mips-cpu.c
@@ -101,7 +101,7 @@ static void mips_mt_send_ipi(struct irq_data *d, unsigned int cpu)
 	local_irq_save(flags);
 
 	/* We can only send IPIs to VPEs within the local core */
-	WARN_ON(cpu_data[cpu].core != current_cpu_data.core);
+	WARN_ON(!cpus_are_siblings(smp_processor_id(), cpu));
 
 	vpflags = dvpe();
 	settc(cpu_vpe_id(&cpu_data[cpu]));
-- 
2.14.0
