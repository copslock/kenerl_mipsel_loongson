Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 May 2014 21:47:28 +0200 (CEST)
Received: from [195.59.15.196] ([195.59.15.196]:21747 "EHLO
        mailapp01.imgtec.com" rhost-flags-FAIL-FAIL-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817664AbaEBTr0mjz8b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 May 2014 21:47:26 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id B0409F074CF90
        for <linux-mips@linux-mips.org>; Fri,  2 May 2014 20:47:15 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Fri, 2 May
 2014 20:47:19 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Fri, 2 May 2014 20:47:18 +0100
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Fri, 2 May 2014 20:47:18 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v2 31/39] MIPS: smp-cps: hotplug support
Date:   Fri, 2 May 2014 20:47:13 +0100
Message-ID: <1399060033-26685-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1397653512-4582-1-git-send-email-paul.burton@imgtec.com>
References: <1397653512-4582-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40016
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

This patch adds support for offlining CPUs via hotplug when using the
CONFIG_MIPS_CPS SMP implementation. When a CPU is offlined one of 2
things will happen:

  - If the CPU is part of a core which implements the MT ASE and there
    is at least one other VPE online within that core then the VPE will
    be halted by settings its TCHalt bit.

  - Otherwise if supported the core will be powered down via the CPC.

  - Otherwise the CPU will hang by executing an infinite loop.

Bringing CPUs back online is then a process of either clearing the
appropriate VPEs TCHalt bit or powering up the appropriate core via the
CPC. Throughout the process the struct core_boot_config vpe_mask field
must be maintained such that mips_cps_boot_vpes will start & stop the
correct VPEs.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
Changes in v2:
  - Disable hotplug where powering down a core is unsupported.
---
 arch/mips/Kconfig          |   2 +
 arch/mips/kernel/smp-cps.c | 155 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 155 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index c79e6a4..860a1e9 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2059,9 +2059,11 @@ config MIPS_CPS
 	depends on SYS_SUPPORTS_MIPS_CPS
 	select MIPS_CM
 	select MIPS_CPC
+	select MIPS_CPS_PM if HOTPLUG_CPU
 	select MIPS_GIC_IPI
 	select SMP
 	select SYNC_R4K if (CEVT_R4K || CSRC_R4K)
+	select SYS_SUPPORTS_HOTPLUG_CPU
 	select SYS_SUPPORTS_SMP
 	select WEAK_ORDERING
 	help
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index b519c85..3c30891 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -20,6 +20,7 @@
 #include <asm/mips-cpc.h>
 #include <asm/mips_mt.h>
 #include <asm/mipsregs.h>
+#include <asm/pm-cps.h>
 #include <asm/smp-cps.h>
 #include <asm/time.h>
 #include <asm/uasm.h>
@@ -194,10 +195,12 @@ static void cps_boot_secondary(int cpu, struct task_struct *idle)
 
 	atomic_or(1 << cpu_vpe_id(&cpu_data[cpu]), &core_cfg->vpe_mask);
 
+	preempt_disable();
+
 	if (!test_bit(core, core_power)) {
 		/* Boot a VPE on a powered down core */
 		boot_core(core);
-		return;
+		goto out;
 	}
 
 	if (core != current_cpu_data.core) {
@@ -214,13 +217,15 @@ static void cps_boot_secondary(int cpu, struct task_struct *idle)
 					       NULL, 1);
 		if (err)
 			panic("Failed to call remote CPU\n");
-		return;
+		goto out;
 	}
 
 	BUG_ON(!cpu_has_mipsmt);
 
 	/* Boot a VPE on this core */
 	mips_cps_boot_vpes();
+out:
+	preempt_enable();
 }
 
 static void cps_init_secondary(void)
@@ -250,6 +255,148 @@ static void cps_cpus_done(void)
 {
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+
+static int cps_cpu_disable(void)
+{
+	unsigned cpu = smp_processor_id();
+	struct core_boot_config *core_cfg;
+
+	if (!cpu)
+		return -EBUSY;
+
+	if (!cps_pm_support_state(CPS_PM_POWER_GATED))
+		return -EINVAL;
+
+	core_cfg = &mips_cps_core_bootcfg[current_cpu_data.core];
+	atomic_sub(1 << cpu_vpe_id(&current_cpu_data), &core_cfg->vpe_mask);
+	smp_mb__after_atomic_dec();
+	set_cpu_online(cpu, false);
+	cpu_clear(cpu, cpu_callin_map);
+
+	return 0;
+}
+
+static DECLARE_COMPLETION(cpu_death_chosen);
+static unsigned cpu_death_sibling;
+static enum {
+	CPU_DEATH_HALT,
+	CPU_DEATH_POWER,
+} cpu_death;
+
+void play_dead(void)
+{
+	unsigned cpu, core;
+
+	local_irq_disable();
+	idle_task_exit();
+	cpu = smp_processor_id();
+	cpu_death = CPU_DEATH_POWER;
+
+	if (cpu_has_mipsmt) {
+		core = cpu_data[cpu].core;
+
+		/* Look for another online VPE within the core */
+		for_each_online_cpu(cpu_death_sibling) {
+			if (cpu_data[cpu_death_sibling].core != core)
+				continue;
+
+			/*
+			 * There is an online VPE within the core. Just halt
+			 * this TC and leave the core alone.
+			 */
+			cpu_death = CPU_DEATH_HALT;
+			break;
+		}
+	}
+
+	/* This CPU has chosen its way out */
+	complete(&cpu_death_chosen);
+
+	if (cpu_death == CPU_DEATH_HALT) {
+		/* Halt this TC */
+		write_c0_tchalt(TCHALT_H);
+		instruction_hazard();
+	} else {
+		/* Power down the core */
+		cps_pm_enter_state(CPS_PM_POWER_GATED);
+	}
+
+	/* This should never be reached */
+	panic("Failed to offline CPU %u", cpu);
+}
+
+static void wait_for_sibling_halt(void *ptr_cpu)
+{
+	unsigned cpu = (unsigned)ptr_cpu;
+	unsigned vpe_id = cpu_data[cpu].vpe_id;
+	unsigned halted;
+	unsigned long flags;
+
+	do {
+		local_irq_save(flags);
+		settc(vpe_id);
+		halted = read_tc_c0_tchalt();
+		local_irq_restore(flags);
+	} while (!(halted & TCHALT_H));
+}
+
+static void cps_cpu_die(unsigned int cpu)
+{
+	unsigned core = cpu_data[cpu].core;
+	unsigned stat;
+	int err;
+
+	/* Wait for the cpu to choose its way out */
+	if (!wait_for_completion_timeout(&cpu_death_chosen,
+					 msecs_to_jiffies(5000))) {
+		pr_err("CPU%u: didn't offline\n", cpu);
+		return;
+	}
+
+	/*
+	 * Now wait for the CPU to actually offline. Without doing this that
+	 * offlining may race with one or more of:
+	 *
+	 *   - Onlining the CPU again.
+	 *   - Powering down the core if another VPE within it is offlined.
+	 *   - A sibling VPE entering a non-coherent state.
+	 *
+	 * In the non-MT halt case (ie. infinite loop) the CPU is doing nothing
+	 * with which we could race, so do nothing.
+	 */
+	if (cpu_death == CPU_DEATH_POWER) {
+		/*
+		 * Wait for the core to enter a powered down or clock gated
+		 * state, the latter happening when a JTAG probe is connected
+		 * in which case the CPC will refuse to power down the core.
+		 */
+		do {
+			mips_cpc_lock_other(core);
+			stat = read_cpc_co_stat_conf();
+			stat &= CPC_Cx_STAT_CONF_SEQSTATE_MSK;
+			mips_cpc_unlock_other();
+		} while (stat != CPC_Cx_STAT_CONF_SEQSTATE_D0 &&
+			 stat != CPC_Cx_STAT_CONF_SEQSTATE_D2 &&
+			 stat != CPC_Cx_STAT_CONF_SEQSTATE_U2);
+
+		/* Indicate the core is powered off */
+		bitmap_clear(core_power, core, 1);
+	} else if (cpu_has_mipsmt) {
+		/*
+		 * Have a CPU with access to the offlined CPUs registers wait
+		 * for its TC to halt.
+		 */
+		err = smp_call_function_single(cpu_death_sibling,
+					       wait_for_sibling_halt,
+					       (void *)cpu, 1);
+		if (err)
+			panic("Failed to call remote sibling CPU\n");
+	}
+}
+
+#endif /* CONFIG_HOTPLUG_CPU */
+
 static struct plat_smp_ops cps_smp_ops = {
 	.smp_setup		= cps_smp_setup,
 	.prepare_cpus		= cps_prepare_cpus,
@@ -259,6 +406,10 @@ static struct plat_smp_ops cps_smp_ops = {
 	.send_ipi_single	= gic_send_ipi_single,
 	.send_ipi_mask		= gic_send_ipi_mask,
 	.cpus_done		= cps_cpus_done,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_disable		= cps_cpu_disable,
+	.cpu_die		= cps_cpu_die,
+#endif
 };
 
 bool mips_cps_smp_in_use(void)
-- 
1.8.5.3
