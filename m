Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 04:54:55 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:64043 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993906AbdHMCx26gFz6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2017 04:53:28 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 2F80C25410A88;
        Sun, 13 Aug 2017 03:53:20 +0100 (IST)
Received: from localhost (10.20.79.142) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 13 Aug
 2017 03:53:21 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 11/19] MIPS: Abstract CPU core & VP(E) ID access through accessor functions
Date:   Sat, 12 Aug 2017 19:49:35 -0700
Message-ID: <20170813024943.14989-12-paul.burton@imgtec.com>
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
X-archive-position: 59507
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

We currently have fields in struct cpuinfo_mips for the core & VP(E) ID
of a particular CPU, and various pieces of code directly access those
fields. This patch abstracts such access by introducing accessor
functions cpu_core(), cpu_set_core(), cpu_vpe_id() & cpu_set_vpe_id()
and having code that needs to access these values call those functions
rather than directly accessing the struct cpuinfo_mips fields. This
prepares us for changes to the way in which those values are stored in
later patches.

The cpu_vpe_id() function is introduced even though we already had a
cpu_vpe_id() macro for a couple of reasons:

  1) It's more consistent with the core, and future cluster, accessors.

  2) It ensures a sensible return type without explicit casts.

  3) It's generally preferable to use functions rather than macros.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/include/asm/cpu-info.h      | 27 ++++++++++++++++++++++++---
 arch/mips/include/asm/mips-cm.h       |  2 +-
 arch/mips/include/asm/topology.h      |  2 +-
 arch/mips/kernel/cpu-probe.c          |  7 +++++--
 arch/mips/kernel/mips-cm.c            |  4 ++--
 arch/mips/kernel/mips-cpc.c           |  4 ++--
 arch/mips/kernel/pm-cps.c             |  6 +++---
 arch/mips/kernel/proc.c               |  6 +++---
 arch/mips/kernel/smp-bmips.c          |  2 +-
 arch/mips/kernel/smp-cps.c            | 28 ++++++++++++++--------------
 arch/mips/kernel/smp-mt.c             |  2 +-
 arch/mips/kernel/smp.c                |  8 ++++----
 arch/mips/loongson64/loongson-3/smp.c | 11 ++++++-----
 arch/mips/netlogic/common/smp.c       |  2 +-
 arch/mips/oprofile/op_model_mipsxx.c  |  4 ++--
 drivers/cpuidle/cpuidle-cps.c         |  2 +-
 16 files changed, 71 insertions(+), 46 deletions(-)

diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/cpu-info.h
index cd6efb07c980..2b2f97023705 100644
--- a/arch/mips/include/asm/cpu-info.h
+++ b/arch/mips/include/asm/cpu-info.h
@@ -144,11 +144,32 @@ struct proc_cpuinfo_notifier_args {
 	unsigned long n;
 };
 
+static inline unsigned int cpu_core(struct cpuinfo_mips *cpuinfo)
+{
+	return cpuinfo->core;
+}
+
+static inline void cpu_set_core(struct cpuinfo_mips *cpuinfo,
+				unsigned int core)
+{
+	cpuinfo->core = core;
+}
+
+static inline unsigned int cpu_vpe_id(struct cpuinfo_mips *cpuinfo)
+{
 #if defined(CONFIG_MIPS_MT_SMP) || defined(CONFIG_CPU_MIPSR6)
-# define cpu_vpe_id(cpuinfo)	((cpuinfo)->vpe_id)
-#else
-# define cpu_vpe_id(cpuinfo)	({ (void)cpuinfo; 0; })
+	return cpuinfo->vpe_id;
 #endif
+	return 0;
+}
+
+static inline void cpu_set_vpe_id(struct cpuinfo_mips *cpuinfo,
+				  unsigned int vpe)
+{
+#if defined(CONFIG_MIPS_MT_SMP) || defined(CONFIG_CPU_MIPSR6)
+	cpuinfo->vpe_id = vpe;
+#endif
+}
 
 static inline unsigned long cpu_asid_inc(void)
 {
diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
index 225586bdd81c..6cfc0cc265d7 100644
--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -428,7 +428,7 @@ static inline unsigned int mips_cm_max_vp_width(void)
  */
 static inline unsigned int mips_cm_vp_id(unsigned int cpu)
 {
-	unsigned int core = cpu_data[cpu].core;
+	unsigned int core = cpu_core(&cpu_data[cpu]);
 	unsigned int vp = cpu_vpe_id(&cpu_data[cpu]);
 
 	return (core * mips_cm_max_vp_width()) + vp;
diff --git a/arch/mips/include/asm/topology.h b/arch/mips/include/asm/topology.h
index 7afda4150a59..0673d2d0f2e6 100644
--- a/arch/mips/include/asm/topology.h
+++ b/arch/mips/include/asm/topology.h
@@ -13,7 +13,7 @@
 
 #ifdef CONFIG_SMP
 #define topology_physical_package_id(cpu)	(cpu_data[cpu].package)
-#define topology_core_id(cpu)			(cpu_data[cpu].core)
+#define topology_core_id(cpu)			(cpu_core(&cpu_data[cpu]))
 #define topology_core_cpumask(cpu)		(&cpu_core_map[cpu])
 #define topology_sibling_cpumask(cpu)		(&cpu_sibling_map[cpu])
 #endif
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 19ae0e279c86..ed39b8e98bc1 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -919,9 +919,12 @@ static void decode_configs(struct cpuinfo_mips *c)
 
 #ifndef CONFIG_MIPS_CPS
 	if (cpu_has_mips_r2_r6) {
-		c->core = get_ebase_cpunum();
+		unsigned int core;
+
+		core = get_ebase_cpunum();
 		if (cpu_has_mipsmt)
-			c->core >>= fls(core_nvpes()) - 1;
+			core >>= fls(core_nvpes()) - 1;
+		cpu_set_core(c, core);
 	}
 #endif
 }
diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
index aa62a9e5254c..64ad8d0a6986 100644
--- a/arch/mips/kernel/mips-cm.c
+++ b/arch/mips/kernel/mips-cm.c
@@ -287,7 +287,7 @@ void mips_cm_lock_other(unsigned int core, unsigned int vp)
 		 * CM 2.5 & older, so have to ensure other VP(E)s don't
 		 * race with us.
 		 */
-		curr_core = current_cpu_data.core;
+		curr_core = cpu_core(&current_cpu_data);
 		spin_lock_irqsave(&per_cpu(cm_core_lock, curr_core),
 				  per_cpu(cm_core_lock_flags, curr_core));
 
@@ -308,7 +308,7 @@ void mips_cm_unlock_other(void)
 	unsigned int curr_core;
 
 	if (mips_cm_revision() < CM_REV_CM3) {
-		curr_core = current_cpu_data.core;
+		curr_core = cpu_core(&current_cpu_data);
 		spin_unlock_irqrestore(&per_cpu(cm_core_lock, curr_core),
 				       per_cpu(cm_core_lock_flags, curr_core));
 	} else {
diff --git a/arch/mips/kernel/mips-cpc.c b/arch/mips/kernel/mips-cpc.c
index 0e3ac6d05e75..06952bb34395 100644
--- a/arch/mips/kernel/mips-cpc.c
+++ b/arch/mips/kernel/mips-cpc.c
@@ -86,7 +86,7 @@ void mips_cpc_lock_other(unsigned int core)
 		return;
 
 	preempt_disable();
-	curr_core = current_cpu_data.core;
+	curr_core = cpu_core(&current_cpu_data);
 	spin_lock_irqsave(&per_cpu(cpc_core_lock, curr_core),
 			  per_cpu(cpc_core_lock_flags, curr_core));
 	write_cpc_cl_other(core << __ffs(CPC_Cx_OTHER_CORENUM));
@@ -106,7 +106,7 @@ void mips_cpc_unlock_other(void)
 		/* Systems with CM >= 3 lock the CPC via mips_cm_lock_other */
 		return;
 
-	curr_core = current_cpu_data.core;
+	curr_core = cpu_core(&current_cpu_data);
 	spin_unlock_irqrestore(&per_cpu(cpc_core_lock, curr_core),
 			       per_cpu(cpc_core_lock_flags, curr_core));
 	preempt_enable();
diff --git a/arch/mips/kernel/pm-cps.c b/arch/mips/kernel/pm-cps.c
index df1a1a5b58b9..daff76056609 100644
--- a/arch/mips/kernel/pm-cps.c
+++ b/arch/mips/kernel/pm-cps.c
@@ -114,7 +114,7 @@ static void coupled_barrier(atomic_t *a, unsigned online)
 int cps_pm_enter_state(enum cps_pm_state state)
 {
 	unsigned cpu = smp_processor_id();
-	unsigned core = current_cpu_data.core;
+	unsigned core = cpu_core(&current_cpu_data);
 	unsigned online, left;
 	cpumask_t *coupled_mask = this_cpu_ptr(&online_coupled);
 	u32 *core_ready_count, *nc_core_ready_count;
@@ -486,7 +486,7 @@ static void *cps_gen_entry_code(unsigned cpu, enum cps_pm_state state)
 		* defined by the interAptiv & proAptiv SUMs as ensuring that the
 		*  operation resulting from the preceding store is complete.
 		*/
-		uasm_i_addiu(&p, t0, zero, 1 << cpu_data[cpu].core);
+		uasm_i_addiu(&p, t0, zero, 1 << cpu_core(&cpu_data[cpu]));
 		uasm_i_sw(&p, t0, 0, r_pcohctl);
 		uasm_i_lw(&p, t0, 0, r_pcohctl);
 
@@ -640,7 +640,7 @@ static void *cps_gen_entry_code(unsigned cpu, enum cps_pm_state state)
 static int cps_pm_online_cpu(unsigned int cpu)
 {
 	enum cps_pm_state state;
-	unsigned core = cpu_data[cpu].core;
+	unsigned core = cpu_core(&cpu_data[cpu]);
 	void *entry_fn, *core_rc;
 
 	for (state = CPS_PM_NC_WAIT; state < CPS_PM_STATE_COUNT; state++) {
diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index 70604c753aa4..bd9bf528f19b 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -134,13 +134,13 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	seq_printf(m, "kscratch registers\t: %d\n",
 		      hweight8(cpu_data[n].kscratch_mask));
 	seq_printf(m, "package\t\t\t: %d\n", cpu_data[n].package);
-	seq_printf(m, "core\t\t\t: %d\n", cpu_data[n].core);
+	seq_printf(m, "core\t\t\t: %d\n", cpu_core(&cpu_data[n]));
 
 #if defined(CONFIG_MIPS_MT_SMP) || defined(CONFIG_CPU_MIPSR6)
 	if (cpu_has_mipsmt)
-		seq_printf(m, "VPE\t\t\t: %d\n", cpu_data[n].vpe_id);
+		seq_printf(m, "VPE\t\t\t: %d\n", cpu_vpe_id(&cpu_data[n]));
 	else if (cpu_has_vp)
-		seq_printf(m, "VP\t\t\t: %d\n", cpu_data[n].vpe_id);
+		seq_printf(m, "VP\t\t\t: %d\n", cpu_vpe_id(&cpu_data[n]));
 #endif
 
 	sprintf(fmt, "VCE%%c exceptions\t\t: %s\n",
diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index f86d755e3d75..4ac576c68034 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -245,7 +245,7 @@ static void bmips_init_secondary(void)
 		break;
 	case CPU_BMIPS5000:
 		write_c0_brcm_action(ACTION_CLR_IPI(smp_processor_id(), 0));
-		current_cpu_data.core = (read_c0_brcm_config() >> 25) & 3;
+		cpu_set_core(&current_cpu_data, (read_c0_brcm_config() >> 25) & 3);
 		break;
 	}
 }
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 5729d2c77461..699459ed293b 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -76,10 +76,8 @@ static void __init cps_smp_setup(void)
 			smp_num_siblings = core_vpes;
 
 		for (v = 0; v < min_t(int, core_vpes, NR_CPUS - nvpes); v++) {
-			cpu_data[nvpes + v].core = c;
-#if defined(CONFIG_MIPS_MT_SMP) || defined(CONFIG_CPU_MIPSR6)
-			cpu_data[nvpes + v].vpe_id = v;
-#endif
+			cpu_set_core(&cpu_data[nvpes + v], c);
+			cpu_set_vpe_id(&cpu_data[nvpes + v], v);
 		}
 
 		nvpes += core_vpes;
@@ -149,7 +147,7 @@ static void __init cps_prepare_cpus(unsigned int max_cpus)
 			cpu_has_dc_aliases ? "dcache aliasing" : "");
 
 		for_each_present_cpu(c) {
-			if (cpu_data[c].core)
+			if (cpu_core(&cpu_data[c]))
 				set_cpu_present(c, false);
 		}
 	}
@@ -189,7 +187,7 @@ static void __init cps_prepare_cpus(unsigned int max_cpus)
 	}
 
 	/* Mark this CPU as booted */
-	atomic_set(&mips_cps_core_bootcfg[current_cpu_data.core].vpe_mask,
+	atomic_set(&mips_cps_core_bootcfg[cpu_core(&current_cpu_data)].vpe_mask,
 		   1 << cpu_vpe_id(&current_cpu_data));
 
 	return;
@@ -284,7 +282,7 @@ static void boot_core(unsigned int core, unsigned int vpe_id)
 
 static void remote_vpe_boot(void *dummy)
 {
-	unsigned core = current_cpu_data.core;
+	unsigned core = cpu_core(&current_cpu_data);
 	struct core_boot_config *core_cfg = &mips_cps_core_bootcfg[core];
 
 	mips_cps_boot_vpes(core_cfg, cpu_vpe_id(&current_cpu_data));
@@ -292,7 +290,7 @@ static void remote_vpe_boot(void *dummy)
 
 static void cps_boot_secondary(int cpu, struct task_struct *idle)
 {
-	unsigned core = cpu_data[cpu].core;
+	unsigned core = cpu_core(&cpu_data[cpu]);
 	unsigned vpe_id = cpu_vpe_id(&cpu_data[cpu]);
 	struct core_boot_config *core_cfg = &mips_cps_core_bootcfg[core];
 	struct vpe_boot_config *vpe_cfg = &core_cfg->vpe_config[vpe_id];
@@ -321,10 +319,10 @@ static void cps_boot_secondary(int cpu, struct task_struct *idle)
 		mips_cm_unlock_other();
 	}
 
-	if (core != current_cpu_data.core) {
+	if (core != cpu_core(&current_cpu_data)) {
 		/* Boot a VPE on another powered up core */
 		for (remote = 0; remote < NR_CPUS; remote++) {
-			if (cpu_data[remote].core != core)
+			if (cpu_core(&cpu_data[remote]) != core)
 				continue;
 			if (cpu_online(remote))
 				break;
@@ -401,7 +399,7 @@ static int cps_cpu_disable(void)
 	if (!cps_pm_support_state(CPS_PM_POWER_GATED))
 		return -EINVAL;
 
-	core_cfg = &mips_cps_core_bootcfg[current_cpu_data.core];
+	core_cfg = &mips_cps_core_bootcfg[cpu_core(&current_cpu_data)];
 	atomic_sub(1 << cpu_vpe_id(&current_cpu_data), &core_cfg->vpe_mask);
 	smp_mb__after_atomic();
 	set_cpu_online(cpu, false);
@@ -423,15 +421,17 @@ void play_dead(void)
 	local_irq_disable();
 	idle_task_exit();
 	cpu = smp_processor_id();
-	core = cpu_data[cpu].core;
+	core = cpu_core(&cpu_data[cpu]);
 	cpu_death = CPU_DEATH_POWER;
 
 	pr_debug("CPU%d going offline\n", cpu);
 
 	if (cpu_has_mipsmt || cpu_has_vp) {
+		core = cpu_core(&cpu_data[cpu]);
+
 		/* Look for another online VPE within the core */
 		for_each_online_cpu(cpu_death_sibling) {
-			if (cpu_data[cpu_death_sibling].core != core)
+			if (cpu_core(&cpu_data[cpu_death_sibling]) != core)
 				continue;
 
 			/*
@@ -487,7 +487,7 @@ static void wait_for_sibling_halt(void *ptr_cpu)
 
 static void cps_cpu_die(unsigned int cpu)
 {
-	unsigned core = cpu_data[cpu].core;
+	unsigned core = cpu_core(&cpu_data[cpu]);
 	unsigned int vpe_id = cpu_vpe_id(&cpu_data[cpu]);
 	ktime_t fail_time;
 	unsigned stat;
diff --git a/arch/mips/kernel/smp-mt.c b/arch/mips/kernel/smp-mt.c
index 004ff5e8a820..5a7b5857d083 100644
--- a/arch/mips/kernel/smp-mt.c
+++ b/arch/mips/kernel/smp-mt.c
@@ -83,7 +83,7 @@ static unsigned int __init smvp_vpe_init(unsigned int tc, unsigned int mvpconf0,
 	if (tc != 0)
 		smvp_copy_vpe_config();
 
-	cpu_data[ncpu].vpe_id = tc;
+	cpu_set_vpe_id(&cpu_data[ncpu], tc);
 
 	return ncpu;
 }
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 20c1f9ac946a..a54e5857c227 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -97,7 +97,7 @@ static inline void set_cpu_sibling_map(int cpu)
 	if (smp_num_siblings > 1) {
 		for_each_cpu(i, &cpu_sibling_setup_map) {
 			if (cpu_data[cpu].package == cpu_data[i].package &&
-				    cpu_data[cpu].core == cpu_data[i].core) {
+			    cpu_core(&cpu_data[cpu]) == cpu_core(&cpu_data[i])) {
 				cpumask_set_cpu(i, &cpu_sibling_map[cpu]);
 				cpumask_set_cpu(cpu, &cpu_sibling_map[i]);
 			}
@@ -135,7 +135,7 @@ void calculate_cpu_foreign_map(void)
 		core_present = 0;
 		for_each_cpu(k, &temp_foreign_map)
 			if (cpu_data[i].package == cpu_data[k].package &&
-			    cpu_data[i].core == cpu_data[k].core)
+			    cpu_core(&cpu_data[i]) == cpu_core(&cpu_data[k]))
 				core_present = 1;
 		if (!core_present)
 			cpumask_set_cpu(i, &temp_foreign_map);
@@ -186,9 +186,9 @@ void mips_smp_send_ipi_mask(const struct cpumask *mask, unsigned int action)
 
 	if (mips_cpc_present()) {
 		for_each_cpu(cpu, mask) {
-			core = cpu_data[cpu].core;
+			core = cpu_core(&cpu_data[cpu]);
 
-			if (core == current_cpu_data.core)
+			if (core == cpu_core(&current_cpu_data))
 				continue;
 
 			while (!cpumask_test_cpu(cpu, &cpu_coherent_mask)) {
diff --git a/arch/mips/loongson64/loongson-3/smp.c b/arch/mips/loongson64/loongson-3/smp.c
index 5b5a44f50b0b..bde64b0f1e47 100644
--- a/arch/mips/loongson64/loongson-3/smp.c
+++ b/arch/mips/loongson64/loongson-3/smp.c
@@ -319,8 +319,8 @@ static void loongson3_init_secondary(void)
 		loongson3_ipi_write32(0xffffffff, ipi_en0_regs[cpu_logical_map(i)]);
 
 	per_cpu(cpu_state, cpu) = CPU_ONLINE;
-	cpu_data[cpu].core =
-		cpu_logical_map(cpu) % loongson_sysconf.cores_per_package;
+	cpu_set_core(&cpu_data[cpu],
+		     cpu_logical_map(cpu) % loongson_sysconf.cores_per_package);
 	cpu_data[cpu].package =
 		cpu_logical_map(cpu) / loongson_sysconf.cores_per_package;
 
@@ -386,7 +386,8 @@ static void __init loongson3_smp_setup(void)
 	ipi_status0_regs_init();
 	ipi_en0_regs_init();
 	ipi_mailbox_buf_init();
-	cpu_data[0].core = cpu_logical_map(0) % loongson_sysconf.cores_per_package;
+	cpu_set_core(&cpu_data[0],
+		     cpu_logical_map(0) % loongson_sysconf.cores_per_package);
 	cpu_data[0].package = cpu_logical_map(0) / loongson_sysconf.cores_per_package;
 }
 
@@ -697,7 +698,7 @@ void play_dead(void)
 
 static int loongson3_disable_clock(unsigned int cpu)
 {
-	uint64_t core_id = cpu_data[cpu].core;
+	uint64_t core_id = cpu_core(&cpu_data[cpu]);
 	uint64_t package_id = cpu_data[cpu].package;
 
 	if ((read_c0_prid() & PRID_REV_MASK) == PRID_REV_LOONGSON3A_R1) {
@@ -711,7 +712,7 @@ static int loongson3_disable_clock(unsigned int cpu)
 
 static int loongson3_enable_clock(unsigned int cpu)
 {
-	uint64_t core_id = cpu_data[cpu].core;
+	uint64_t core_id = cpu_core(&cpu_data[cpu]);
 	uint64_t package_id = cpu_data[cpu].package;
 
 	if ((read_c0_prid() & PRID_REV_MASK) == PRID_REV_LOONGSON3A_R1) {
diff --git a/arch/mips/netlogic/common/smp.c b/arch/mips/netlogic/common/smp.c
index eac3f2950b14..615027863f54 100644
--- a/arch/mips/netlogic/common/smp.c
+++ b/arch/mips/netlogic/common/smp.c
@@ -122,7 +122,7 @@ static void nlm_init_secondary(void)
 	int hwtid;
 
 	hwtid = hard_smp_processor_id();
-	current_cpu_data.core = hwtid / NLM_THREADS_PER_CORE;
+	cpu_set_core(&current_cpu_data, hwtid / NLM_THREADS_PER_CORE);
 	current_cpu_data.package = nlm_nodeid();
 	nlm_percpu_init(hwtid);
 	nlm_smp_irq_init(hwtid);
diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
index c57da6f13929..c3e4c18ef8d4 100644
--- a/arch/mips/oprofile/op_model_mipsxx.c
+++ b/arch/mips/oprofile/op_model_mipsxx.c
@@ -38,9 +38,9 @@ static int perfcount_irq;
 #ifdef CONFIG_MIPS_MT_SMP
 static int cpu_has_mipsmt_pertccounters;
 #define WHAT		(MIPS_PERFCTRL_MT_EN_VPE | \
-			 M_PERFCTL_VPEID(cpu_data[smp_processor_id()].vpe_id))
+			 M_PERFCTL_VPEID(cpu_vpe_id(&current_cpu_data)))
 #define vpe_id()	(cpu_has_mipsmt_pertccounters ? \
-			0 : cpu_data[smp_processor_id()].vpe_id)
+			0 : cpu_vpe_id(&current_cpu_data))
 
 /*
  * The number of bits to shift to convert between counters per core and
diff --git a/drivers/cpuidle/cpuidle-cps.c b/drivers/cpuidle/cpuidle-cps.c
index 12b9145913de..6041b6104f3d 100644
--- a/drivers/cpuidle/cpuidle-cps.c
+++ b/drivers/cpuidle/cpuidle-cps.c
@@ -37,7 +37,7 @@ static int cps_nc_enter(struct cpuidle_device *dev,
 	 * TODO: don't treat core 0 specially, just prevent the final core
 	 * TODO: remap interrupt affinity temporarily
 	 */
-	if (!cpu_data[dev->cpu].core && (index > STATE_NC_WAIT))
+	if (!cpu_core(&cpu_data[dev->cpu]) && (index > STATE_NC_WAIT))
 		index = STATE_NC_WAIT;
 
 	/* Select the appropriate cps_pm_state */
-- 
2.14.0
