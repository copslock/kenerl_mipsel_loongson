Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 May 2014 21:46:12 +0200 (CEST)
Received: from [195.59.15.196] ([195.59.15.196]:48586 "EHLO
        mailapp01.imgtec.com" rhost-flags-FAIL-FAIL-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817664AbaEBTqGtmiMC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 May 2014 21:46:06 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 4214B482CC6C4
        for <linux-mips@linux-mips.org>; Fri,  2 May 2014 20:45:55 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Fri, 2 May
 2014 20:45:58 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Fri, 2 May 2014 20:45:58 +0100
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Fri, 2 May 2014 20:45:57 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v2 30/39] MIPS: pm-cps: add PM state entry code for CPS systems
Date:   Fri, 2 May 2014 20:45:49 +0100
Message-ID: <1399059949-26590-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1397653501-4524-1-git-send-email-paul.burton@imgtec.com>
References: <1397653501-4524-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40015
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

This patch adds code to generate entry & exit code for various low power
states available on systems based around the MIPS Coherent Processing
System architecture (ie. those with a Coherence Manager, Global
Interrupt Controller & for >=CM2 a Cluster Power Controller). States
supported are:

  - Non-coherent wait. This state first leaves the coherent domain and
    then executes a regular MIPS wait instruction. Power savings are
    found from the elimination of coherency interventions between the
    core and any other coherent requestors in the system.

  - Clock gated. This state leaves the coherent domain and then gates
    the clock input to the core. This removes all dynamic power from the
    core but leaves the core at the mercy of another to restart its
    clock. Register state is preserved, but the core can not service
    interrupts whilst its clock is gated.

  - Power gated. This deepest state removes all power input to the core.
    All register state is lost and the core will restart execution from
    its BEV when another core powers it back up. Because register state
    is lost this state requires cooperation with the CONFIG_MIPS_CPS SMP
    implementation in order for the core to exit the state successfully.

The code will detect which states are available on the current system
during boot & generate the entry/exit code for those states. This will
be used by cpuidle & hotplug implementations.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
Changes in v2:
  - Fix the proAptiv case to skip the FSB flush on revisions >= 1.1.0
    and not support it on prior revisions.
  - Skip the FSB flush for P5600.
  - Remove the M5150 case until hardware requirements are clear.
  - Disable states which require the FSB flush when it is unsupported.
---
 arch/mips/Kconfig               |   3 +
 arch/mips/include/asm/pm-cps.h  |  51 +++
 arch/mips/include/asm/smp-cps.h |   3 +
 arch/mips/kernel/Makefile       |   1 +
 arch/mips/kernel/cps-vec.S      |  35 ++
 arch/mips/kernel/pm-cps.c       | 716 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 809 insertions(+)
 create mode 100644 arch/mips/include/asm/pm-cps.h
 create mode 100644 arch/mips/kernel/pm-cps.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 5cdc53b..c79e6a4 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2071,6 +2071,9 @@ config MIPS_CPS
 	  no external assistance. It is safe to enable this when hardware
 	  support is unavailable.
 
+config MIPS_CPS_PM
+	bool
+
 config MIPS_GIC_IPI
 	bool
 
diff --git a/arch/mips/include/asm/pm-cps.h b/arch/mips/include/asm/pm-cps.h
new file mode 100644
index 0000000..625eda5
--- /dev/null
+++ b/arch/mips/include/asm/pm-cps.h
@@ -0,0 +1,51 @@
+/*
+ * Copyright (C) 2014 Imagination Technologies
+ * Author: Paul Burton <paul.burton@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __MIPS_ASM_PM_CPS_H__
+#define __MIPS_ASM_PM_CPS_H__
+
+/*
+ * The CM & CPC can only handle coherence & power control on a per-core basis,
+ * thus in an MT system the VPEs within each core are coupled and can only
+ * enter or exit states requiring CM or CPC assistance in unison.
+ */
+#ifdef CONFIG_MIPS_MT
+# define coupled_coherence cpu_has_mipsmt
+#else
+# define coupled_coherence 0
+#endif
+
+/* Enumeration of possible PM states */
+enum cps_pm_state {
+	CPS_PM_NC_WAIT,		/* MIPS wait instruction, non-coherent */
+	CPS_PM_CLOCK_GATED,	/* Core clock gated */
+	CPS_PM_POWER_GATED,	/* Core power gated */
+	CPS_PM_STATE_COUNT,
+};
+
+/**
+ * cps_pm_support_state - determine whether the system supports a PM state
+ * @state: the state to test for support
+ *
+ * Returns true if the system supports the given state, otherwise false.
+ */
+extern bool cps_pm_support_state(enum cps_pm_state state);
+
+/**
+ * cps_pm_enter_state - enter a PM state
+ * @state: the state to enter
+ *
+ * Enter the given PM state. If coupled_coherence is non-zero then it is
+ * expected that this function be called at approximately the same time on
+ * each coupled CPU. Returns 0 on successful entry & exit, otherwise -errno.
+ */
+extern int cps_pm_enter_state(enum cps_pm_state state);
+
+#endif /* __MIPS_ASM_PM_CPS_H__ */
diff --git a/arch/mips/include/asm/smp-cps.h b/arch/mips/include/asm/smp-cps.h
index 324df2c..a06a08a 100644
--- a/arch/mips/include/asm/smp-cps.h
+++ b/arch/mips/include/asm/smp-cps.h
@@ -33,6 +33,9 @@ extern struct vpe_boot_config *mips_cps_boot_vpes(void);
 
 extern bool mips_cps_smp_in_use(void);
 
+extern void mips_cps_pm_save(void);
+extern void mips_cps_pm_restore(void);
+
 #else /* __ASSEMBLY__ */
 
 .extern mips_cps_bootcfg;
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 97540a8..6133e8b 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -108,6 +108,7 @@ obj-$(CONFIG_MIPS_CM)		+= mips-cm.o
 obj-$(CONFIG_MIPS_CPC)		+= mips-cpc.o
 
 obj-$(CONFIG_CPU_PM)		+= pm.o
+obj-$(CONFIG_MIPS_CPS_PM)	+= pm-cps.o
 
 #
 # DSP ASE supported for MIPS32 or MIPS64 Release 2 cores only. It is not
diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index 57ec18c..1c865ae 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -15,6 +15,7 @@
 #include <asm/cacheops.h>
 #include <asm/mipsregs.h>
 #include <asm/mipsmtregs.h>
+#include <asm/pm.h>
 
 #define GCR_CL_COHERENCE_OFS	0x2008
 #define GCR_CL_ID_OFS		0x2028
@@ -447,3 +448,37 @@ LEAF(mips_cps_boot_vpes)
 	jr	ra
 	 nop
 	END(mips_cps_boot_vpes)
+
+#if defined(CONFIG_MIPS_CPS_PM) && defined(CONFIG_CPU_PM)
+
+	/* Calculate a pointer to this CPUs struct mips_static_suspend_state */
+	.macro	psstate	dest
+	.set	push
+	.set	noat
+	lw	$1, TI_CPU(gp)
+	sll	$1, $1, LONGLOG
+	la	\dest, __per_cpu_offset
+	addu	$1, $1, \dest
+	lw	$1, 0($1)
+	la	\dest, cps_cpu_state
+	addu	\dest, \dest, $1
+	.set	pop
+	.endm
+
+LEAF(mips_cps_pm_save)
+	/* Save CPU state */
+	SUSPEND_SAVE_REGS
+	psstate	t1
+	SUSPEND_SAVE_STATIC
+	jr	v0
+	 nop
+	END(mips_cps_pm_save)
+
+LEAF(mips_cps_pm_restore)
+	/* Restore CPU state */
+	psstate	t1
+	RESUME_RESTORE_STATIC
+	RESUME_RESTORE_REGS_RETURN
+	END(mips_cps_pm_restore)
+
+#endif /* CONFIG_MIPS_CPS_PM && CONFIG_CPU_PM */
diff --git a/arch/mips/kernel/pm-cps.c b/arch/mips/kernel/pm-cps.c
new file mode 100644
index 0000000..5aa4c6f
--- /dev/null
+++ b/arch/mips/kernel/pm-cps.c
@@ -0,0 +1,716 @@
+/*
+ * Copyright (C) 2014 Imagination Technologies
+ * Author: Paul Burton <paul.burton@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/percpu.h>
+#include <linux/slab.h>
+
+#include <asm/asm-offsets.h>
+#include <asm/cacheflush.h>
+#include <asm/cacheops.h>
+#include <asm/idle.h>
+#include <asm/mips-cm.h>
+#include <asm/mips-cpc.h>
+#include <asm/mipsmtregs.h>
+#include <asm/pm.h>
+#include <asm/pm-cps.h>
+#include <asm/smp-cps.h>
+#include <asm/uasm.h>
+
+/*
+ * cps_nc_entry_fn - type of a generated non-coherent state entry function
+ * @online: the count of online coupled VPEs
+ * @nc_ready_count: pointer to a non-coherent mapping of the core ready_count
+ *
+ * The code entering & exiting non-coherent states is generated at runtime
+ * using uasm, in order to ensure that the compiler cannot insert a stray
+ * memory access at an unfortunate time and to allow the generation of optimal
+ * core-specific code particularly for cache routines. If coupled_coherence
+ * is non-zero and this is the entry function for the CPS_PM_NC_WAIT state,
+ * returns the number of VPEs that were in the wait state at the point this
+ * VPE left it. Returns garbage if coupled_coherence is zero or this is not
+ * the entry function for CPS_PM_NC_WAIT.
+ */
+typedef unsigned (*cps_nc_entry_fn)(unsigned online, u32 *nc_ready_count);
+
+/*
+ * The entry point of the generated non-coherent idle state entry/exit
+ * functions. Actually per-core rather than per-CPU.
+ */
+static DEFINE_PER_CPU_READ_MOSTLY(cps_nc_entry_fn[CPS_PM_STATE_COUNT],
+				  nc_asm_enter);
+
+/* Bitmap indicating which states are supported by the system */
+DECLARE_BITMAP(state_support, CPS_PM_STATE_COUNT);
+
+/*
+ * Indicates the number of coupled VPEs ready to operate in a non-coherent
+ * state. Actually per-core rather than per-CPU.
+ */
+static DEFINE_PER_CPU_ALIGNED(u32*, ready_count);
+static DEFINE_PER_CPU_ALIGNED(void*, ready_count_alloc);
+
+/* Indicates online CPUs coupled with the current CPU */
+static DEFINE_PER_CPU_ALIGNED(cpumask_t, online_coupled);
+
+/*
+ * Used to synchronize entry to deep idle states. Actually per-core rather
+ * than per-CPU.
+ */
+static DEFINE_PER_CPU_ALIGNED(atomic_t, pm_barrier);
+
+/* Saved CPU state across the CPS_PM_POWER_GATED state */
+DEFINE_PER_CPU_ALIGNED(struct mips_static_suspend_state, cps_cpu_state);
+
+/* A somewhat arbitrary number of labels & relocs for uasm */
+static struct uasm_label labels[32] __initdata;
+static struct uasm_reloc relocs[32] __initdata;
+
+/* CPU dependant sync types */
+static unsigned stype_intervention;
+static unsigned stype_memory;
+static unsigned stype_ordering;
+
+enum mips_reg {
+	zero, at, v0, v1, a0, a1, a2, a3,
+	t0, t1, t2, t3, t4, t5, t6, t7,
+	s0, s1, s2, s3, s4, s5, s6, s7,
+	t8, t9, k0, k1, gp, sp, fp, ra,
+};
+
+bool cps_pm_support_state(enum cps_pm_state state)
+{
+	return test_bit(state, state_support);
+}
+
+static void coupled_barrier(atomic_t *a, unsigned online)
+{
+	/*
+	 * This function is effectively the same as
+	 * cpuidle_coupled_parallel_barrier, which can't be used here since
+	 * there's no cpuidle device.
+	 */
+
+	if (!coupled_coherence)
+		return;
+
+	smp_mb__before_atomic_inc();
+	atomic_inc(a);
+
+	while (atomic_read(a) < online)
+		cpu_relax();
+
+	if (atomic_inc_return(a) == online * 2) {
+		atomic_set(a, 0);
+		return;
+	}
+
+	while (atomic_read(a) > online)
+		cpu_relax();
+}
+
+int cps_pm_enter_state(enum cps_pm_state state)
+{
+	unsigned cpu = smp_processor_id();
+	unsigned core = current_cpu_data.core;
+	unsigned online, left;
+	cpumask_t *coupled_mask = this_cpu_ptr(&online_coupled);
+	u32 *core_ready_count, *nc_core_ready_count;
+	void *nc_addr;
+	cps_nc_entry_fn entry;
+	struct core_boot_config *core_cfg;
+	struct vpe_boot_config *vpe_cfg;
+
+	/* Check that there is an entry function for this state */
+	entry = per_cpu(nc_asm_enter, core)[state];
+	if (!entry)
+		return -EINVAL;
+
+	/* Calculate which coupled CPUs (VPEs) are online */
+#ifdef CONFIG_MIPS_MT
+	if (cpu_online(cpu)) {
+		cpumask_and(coupled_mask, cpu_online_mask,
+			    &cpu_sibling_map[cpu]);
+		online = cpumask_weight(coupled_mask);
+		cpumask_clear_cpu(cpu, coupled_mask);
+	} else
+#endif
+	{
+		cpumask_clear(coupled_mask);
+		online = 1;
+	}
+
+	/* Setup the VPE to run mips_cps_pm_restore when started again */
+	if (config_enabled(CONFIG_CPU_PM) && state == CPS_PM_POWER_GATED) {
+		core_cfg = &mips_cps_core_bootcfg[core];
+		vpe_cfg = &core_cfg->vpe_config[current_cpu_data.vpe_id];
+		vpe_cfg->pc = (unsigned long)mips_cps_pm_restore;
+		vpe_cfg->gp = (unsigned long)current_thread_info();
+		vpe_cfg->sp = 0;
+	}
+
+	/* Indicate that this CPU might not be coherent */
+	cpumask_clear_cpu(cpu, &cpu_coherent_mask);
+	smp_mb__after_clear_bit();
+
+	/* Create a non-coherent mapping of the core ready_count */
+	core_ready_count = per_cpu(ready_count, core);
+	nc_addr = kmap_noncoherent(virt_to_page(core_ready_count),
+				   (unsigned long)core_ready_count);
+	nc_addr += ((unsigned long)core_ready_count & ~PAGE_MASK);
+	nc_core_ready_count = nc_addr;
+
+	/* Ensure ready_count is zero-initialised before the assembly runs */
+	ACCESS_ONCE(*nc_core_ready_count) = 0;
+	coupled_barrier(&per_cpu(pm_barrier, core), online);
+
+	/* Run the generated entry code */
+	left = entry(online, nc_core_ready_count);
+
+	/* Remove the non-coherent mapping of ready_count */
+	kunmap_noncoherent();
+
+	/* Indicate that this CPU is definitely coherent */
+	cpumask_set_cpu(cpu, &cpu_coherent_mask);
+
+	/*
+	 * If this VPE is the first to leave the non-coherent wait state then
+	 * it needs to wake up any coupled VPEs still running their wait
+	 * instruction so that they return to cpuidle, which can then complete
+	 * coordination between the coupled VPEs & provide the governor with
+	 * a chance to reflect on the length of time the VPEs were in the
+	 * idle state.
+	 */
+	if (coupled_coherence && (state == CPS_PM_NC_WAIT) && (left == online))
+		arch_send_call_function_ipi_mask(coupled_mask);
+
+	return 0;
+}
+
+static void __init cps_gen_cache_routine(u32 **pp, struct uasm_label **pl,
+					 struct uasm_reloc **pr,
+					 const struct cache_desc *cache,
+					 unsigned op, int lbl)
+{
+	unsigned cache_size = cache->ways << cache->waybit;
+	unsigned i;
+	const unsigned unroll_lines = 32;
+
+	/* If the cache isn't present this function has it easy */
+	if (cache->flags & MIPS_CACHE_NOT_PRESENT)
+		return;
+
+	/* Load base address */
+	UASM_i_LA(pp, t0, (long)CKSEG0);
+
+	/* Calculate end address */
+	if (cache_size < 0x8000)
+		uasm_i_addiu(pp, t1, t0, cache_size);
+	else
+		UASM_i_LA(pp, t1, (long)(CKSEG0 + cache_size));
+
+	/* Start of cache op loop */
+	uasm_build_label(pl, *pp, lbl);
+
+	/* Generate the cache ops */
+	for (i = 0; i < unroll_lines; i++)
+		uasm_i_cache(pp, op, i * cache->linesz, t0);
+
+	/* Update the base address */
+	uasm_i_addiu(pp, t0, t0, unroll_lines * cache->linesz);
+
+	/* Loop if we haven't reached the end address yet */
+	uasm_il_bne(pp, pr, t0, t1, lbl);
+	uasm_i_nop(pp);
+}
+
+static int __init cps_gen_flush_fsb(u32 **pp, struct uasm_label **pl,
+				    struct uasm_reloc **pr,
+				    const struct cpuinfo_mips *cpu_info,
+				    int lbl)
+{
+	unsigned i, fsb_size = 8;
+	unsigned num_loads = (fsb_size * 3) / 2;
+	unsigned line_stride = 2;
+	unsigned line_size = cpu_info->dcache.linesz;
+	unsigned perf_counter, perf_event;
+	unsigned revision = cpu_info->processor_id & PRID_REV_MASK;
+
+	/*
+	 * Determine whether this CPU requires an FSB flush, and if so which
+	 * performance counter/event reflect stalls due to a full FSB.
+	 */
+	switch (__get_cpu_type(cpu_info->cputype)) {
+	case CPU_INTERAPTIV:
+		perf_counter = 1;
+		perf_event = 51;
+		break;
+
+	case CPU_PROAPTIV:
+		/* Newer proAptiv cores don't require this workaround */
+		if (revision >= PRID_REV_ENCODE_332(1, 1, 0))
+			return 0;
+
+		/* On older ones it's unavailable */
+		return -1;
+
+	/* CPUs which do not require the workaround */
+	case CPU_P5600:
+		return 0;
+
+	default:
+		WARN_ONCE(1, "pm-cps: FSB flush unsupported for this CPU\n");
+		return -1;
+	}
+
+	/*
+	 * Ensure that the fill/store buffer (FSB) is not holding the results
+	 * of a prefetch, since if it is then the CPC sequencer may become
+	 * stuck in the D3 (ClrBus) state whilst entering a low power state.
+	 */
+
+	/* Preserve perf counter setup */
+	uasm_i_mfc0(pp, t2, 25, (perf_counter * 2) + 0); /* PerfCtlN */
+	uasm_i_mfc0(pp, t3, 25, (perf_counter * 2) + 1); /* PerfCntN */
+
+	/* Setup perf counter to count FSB full pipeline stalls */
+	uasm_i_addiu(pp, t0, zero, (perf_event << 5) | 0xf);
+	uasm_i_mtc0(pp, t0, 25, (perf_counter * 2) + 0); /* PerfCtlN */
+	uasm_i_ehb(pp);
+	uasm_i_mtc0(pp, zero, 25, (perf_counter * 2) + 1); /* PerfCntN */
+	uasm_i_ehb(pp);
+
+	/* Base address for loads */
+	UASM_i_LA(pp, t0, (long)CKSEG0);
+
+	/* Start of clear loop */
+	uasm_build_label(pl, *pp, lbl);
+
+	/* Perform some loads to fill the FSB */
+	for (i = 0; i < num_loads; i++)
+		uasm_i_lw(pp, zero, i * line_size * line_stride, t0);
+
+	/*
+	 * Invalidate the new D-cache entries so that the cache will need
+	 * refilling (via the FSB) if the loop is executed again.
+	 */
+	for (i = 0; i < num_loads; i++) {
+		uasm_i_cache(pp, Hit_Invalidate_D,
+			     i * line_size * line_stride, t0);
+		uasm_i_cache(pp, Hit_Writeback_Inv_SD,
+			     i * line_size * line_stride, t0);
+	}
+
+	/* Completion barrier */
+	uasm_i_sync(pp, stype_memory);
+	uasm_i_ehb(pp);
+
+	/* Check whether the pipeline stalled due to the FSB being full */
+	uasm_i_mfc0(pp, t1, 25, (perf_counter * 2) + 1); /* PerfCntN */
+
+	/* Loop if it didn't */
+	uasm_il_beqz(pp, pr, t1, lbl);
+	uasm_i_nop(pp);
+
+	/* Restore perf counter 1. The count may well now be wrong... */
+	uasm_i_mtc0(pp, t2, 25, (perf_counter * 2) + 0); /* PerfCtlN */
+	uasm_i_ehb(pp);
+	uasm_i_mtc0(pp, t3, 25, (perf_counter * 2) + 1); /* PerfCntN */
+	uasm_i_ehb(pp);
+
+	return 0;
+}
+
+static void __init cps_gen_set_top_bit(u32 **pp, struct uasm_label **pl,
+				       struct uasm_reloc **pr,
+				       unsigned r_addr, int lbl)
+{
+	uasm_i_lui(pp, t0, uasm_rel_hi(0x80000000));
+	uasm_build_label(pl, *pp, lbl);
+	uasm_i_ll(pp, t1, 0, r_addr);
+	uasm_i_or(pp, t1, t1, t0);
+	uasm_i_sc(pp, t1, 0, r_addr);
+	uasm_il_beqz(pp, pr, t1, lbl);
+	uasm_i_nop(pp);
+}
+
+static void * __init cps_gen_entry_code(unsigned cpu, enum cps_pm_state state)
+{
+	struct uasm_label *l = labels;
+	struct uasm_reloc *r = relocs;
+	u32 *buf, *p;
+	const unsigned r_online = a0;
+	const unsigned r_nc_count = a1;
+	const unsigned r_pcohctl = t7;
+	const unsigned max_instrs = 256;
+	unsigned cpc_cmd;
+	int err;
+	enum {
+		lbl_incready = 1,
+		lbl_poll_cont,
+		lbl_secondary_hang,
+		lbl_disable_coherence,
+		lbl_flush_fsb,
+		lbl_invicache,
+		lbl_flushdcache,
+		lbl_hang,
+		lbl_set_cont,
+		lbl_secondary_cont,
+		lbl_decready,
+	};
+
+	/* Allocate a buffer to hold the generated code */
+	p = buf = kcalloc(max_instrs, sizeof(u32), GFP_KERNEL);
+	if (!buf)
+		return NULL;
+
+	/* Clear labels & relocs ready for (re)use */
+	memset(labels, 0, sizeof(labels));
+	memset(relocs, 0, sizeof(relocs));
+
+	if (config_enabled(CONFIG_CPU_PM) && state == CPS_PM_POWER_GATED) {
+		/*
+		 * Save CPU state. Note the non-standard calling convention
+		 * with the return address placed in v0 to avoid clobbering
+		 * the ra register before it is saved.
+		 */
+		UASM_i_LA(&p, t0, (long)mips_cps_pm_save);
+		uasm_i_jalr(&p, v0, t0);
+		uasm_i_nop(&p);
+	}
+
+	/*
+	 * Load addresses of required CM & CPC registers. This is done early
+	 * because they're needed in both the enable & disable coherence steps
+	 * but in the coupled case the enable step will only run on one VPE.
+	 */
+	UASM_i_LA(&p, r_pcohctl, (long)addr_gcr_cl_coherence());
+
+	if (coupled_coherence) {
+		/* Increment ready_count */
+		uasm_i_sync(&p, stype_ordering);
+		uasm_build_label(&l, p, lbl_incready);
+		uasm_i_ll(&p, t1, 0, r_nc_count);
+		uasm_i_addiu(&p, t2, t1, 1);
+		uasm_i_sc(&p, t2, 0, r_nc_count);
+		uasm_il_beqz(&p, &r, t2, lbl_incready);
+		uasm_i_addiu(&p, t1, t1, 1);
+
+		/* Ordering barrier */
+		uasm_i_sync(&p, stype_ordering);
+
+		/*
+		 * If this is the last VPE to become ready for non-coherence
+		 * then it should branch below.
+		 */
+		uasm_il_beq(&p, &r, t1, r_online, lbl_disable_coherence);
+		uasm_i_nop(&p);
+
+		if (state < CPS_PM_POWER_GATED) {
+			/*
+			 * Otherwise this is not the last VPE to become ready
+			 * for non-coherence. It needs to wait until coherence
+			 * has been disabled before proceeding, which it will do
+			 * by polling for the top bit of ready_count being set.
+			 */
+			uasm_i_addiu(&p, t1, zero, -1);
+			uasm_build_label(&l, p, lbl_poll_cont);
+			uasm_i_lw(&p, t0, 0, r_nc_count);
+			uasm_il_bltz(&p, &r, t0, lbl_secondary_cont);
+			uasm_i_ehb(&p);
+			uasm_i_yield(&p, zero, t1);
+			uasm_il_b(&p, &r, lbl_poll_cont);
+			uasm_i_nop(&p);
+		} else {
+			/*
+			 * The core will lose power & this VPE will not continue
+			 * so it can simply halt here.
+			 */
+			uasm_i_addiu(&p, t0, zero, TCHALT_H);
+			uasm_i_mtc0(&p, t0, 2, 4);
+			uasm_build_label(&l, p, lbl_secondary_hang);
+			uasm_il_b(&p, &r, lbl_secondary_hang);
+			uasm_i_nop(&p);
+		}
+	}
+
+	/*
+	 * This is the point of no return - this VPE will now proceed to
+	 * disable coherence. At this point we *must* be sure that no other
+	 * VPE within the core will interfere with the L1 dcache.
+	 */
+	uasm_build_label(&l, p, lbl_disable_coherence);
+
+	/* Invalidate the L1 icache */
+	cps_gen_cache_routine(&p, &l, &r, &cpu_data[cpu].icache,
+			      Index_Invalidate_I, lbl_invicache);
+
+	/* Writeback & invalidate the L1 dcache */
+	cps_gen_cache_routine(&p, &l, &r, &cpu_data[cpu].dcache,
+			      Index_Writeback_Inv_D, lbl_flushdcache);
+
+	/* Completion barrier */
+	uasm_i_sync(&p, stype_memory);
+	uasm_i_ehb(&p);
+
+	/*
+	 * Disable all but self interventions. The load from COHCTL is defined
+	 * by the interAptiv & proAptiv SUMs as ensuring that the operation
+	 * resulting from the preceeding store is complete.
+	 */
+	uasm_i_addiu(&p, t0, zero, 1 << cpu_data[cpu].core);
+	uasm_i_sw(&p, t0, 0, r_pcohctl);
+	uasm_i_lw(&p, t0, 0, r_pcohctl);
+
+	/* Sync to ensure previous interventions are complete */
+	uasm_i_sync(&p, stype_intervention);
+	uasm_i_ehb(&p);
+
+	/* Disable coherence */
+	uasm_i_sw(&p, zero, 0, r_pcohctl);
+	uasm_i_lw(&p, t0, 0, r_pcohctl);
+
+	if (state >= CPS_PM_CLOCK_GATED) {
+		err = cps_gen_flush_fsb(&p, &l, &r, &cpu_data[cpu],
+					lbl_flush_fsb);
+		if (err)
+			goto out_err;
+
+		/* Determine the CPC command to issue */
+		switch (state) {
+		case CPS_PM_CLOCK_GATED:
+			cpc_cmd = CPC_Cx_CMD_CLOCKOFF;
+			break;
+		case CPS_PM_POWER_GATED:
+			cpc_cmd = CPC_Cx_CMD_PWRDOWN;
+			break;
+		default:
+			BUG();
+			goto out_err;
+		}
+
+		/* Issue the CPC command */
+		UASM_i_LA(&p, t0, (long)addr_cpc_cl_cmd());
+		uasm_i_addiu(&p, t1, zero, cpc_cmd);
+		uasm_i_sw(&p, t1, 0, t0);
+
+		if (state == CPS_PM_POWER_GATED) {
+			/* If anything goes wrong just hang */
+			uasm_build_label(&l, p, lbl_hang);
+			uasm_il_b(&p, &r, lbl_hang);
+			uasm_i_nop(&p);
+
+			/*
+			 * There's no point generating more code, the core is
+			 * powered down & if powered back up will run from the
+			 * reset vector not from here.
+			 */
+			goto gen_done;
+		}
+
+		/* Completion barrier */
+		uasm_i_sync(&p, stype_memory);
+		uasm_i_ehb(&p);
+	}
+
+	if (state == CPS_PM_NC_WAIT) {
+		/*
+		 * At this point it is safe for all VPEs to proceed with
+		 * execution. This VPE will set the top bit of ready_count
+		 * to indicate to the other VPEs that they may continue.
+		 */
+		if (coupled_coherence)
+			cps_gen_set_top_bit(&p, &l, &r, r_nc_count,
+					    lbl_set_cont);
+
+		/*
+		 * VPEs which did not disable coherence will continue
+		 * executing, after coherence has been disabled, from this
+		 * point.
+		 */
+		uasm_build_label(&l, p, lbl_secondary_cont);
+
+		/* Now perform our wait */
+		uasm_i_wait(&p, 0);
+	}
+
+	/*
+	 * Re-enable coherence. Note that for CPS_PM_NC_WAIT all coupled VPEs
+	 * will run this. The first will actually re-enable coherence & the
+	 * rest will just be performing a rather unusual nop.
+	 */
+	uasm_i_addiu(&p, t0, zero, CM_GCR_Cx_COHERENCE_COHDOMAINEN_MSK);
+	uasm_i_sw(&p, t0, 0, r_pcohctl);
+	uasm_i_lw(&p, t0, 0, r_pcohctl);
+
+	/* Completion barrier */
+	uasm_i_sync(&p, stype_memory);
+	uasm_i_ehb(&p);
+
+	if (coupled_coherence && (state == CPS_PM_NC_WAIT)) {
+		/* Decrement ready_count */
+		uasm_build_label(&l, p, lbl_decready);
+		uasm_i_sync(&p, stype_ordering);
+		uasm_i_ll(&p, t1, 0, r_nc_count);
+		uasm_i_addiu(&p, t2, t1, -1);
+		uasm_i_sc(&p, t2, 0, r_nc_count);
+		uasm_il_beqz(&p, &r, t2, lbl_decready);
+		uasm_i_andi(&p, v0, t1, (1 << fls(smp_num_siblings)) - 1);
+
+		/* Ordering barrier */
+		uasm_i_sync(&p, stype_ordering);
+	}
+
+	if (coupled_coherence && (state == CPS_PM_CLOCK_GATED)) {
+		/*
+		 * At this point it is safe for all VPEs to proceed with
+		 * execution. This VPE will set the top bit of ready_count
+		 * to indicate to the other VPEs that they may continue.
+		 */
+		cps_gen_set_top_bit(&p, &l, &r, r_nc_count, lbl_set_cont);
+
+		/*
+		 * This core will be reliant upon another core sending a
+		 * power-up command to the CPC in order to resume operation.
+		 * Thus an arbitrary VPE can't trigger the core leaving the
+		 * idle state and the one that disables coherence might as well
+		 * be the one to re-enable it. The rest will continue from here
+		 * after that has been done.
+		 */
+		uasm_build_label(&l, p, lbl_secondary_cont);
+
+		/* Ordering barrier */
+		uasm_i_sync(&p, stype_ordering);
+	}
+
+	/* The core is coherent, time to return to C code */
+	uasm_i_jr(&p, ra);
+	uasm_i_nop(&p);
+
+gen_done:
+	/* Ensure the code didn't exceed the resources allocated for it */
+	BUG_ON((p - buf) > max_instrs);
+	BUG_ON((l - labels) > ARRAY_SIZE(labels));
+	BUG_ON((r - relocs) > ARRAY_SIZE(relocs));
+
+	/* Patch branch offsets */
+	uasm_resolve_relocs(relocs, labels);
+
+	/* Flush the icache */
+	local_flush_icache_range((unsigned long)buf, (unsigned long)p);
+
+	return buf;
+out_err:
+	kfree(buf);
+	return NULL;
+}
+
+static int __init cps_gen_core_entries(unsigned cpu)
+{
+	enum cps_pm_state state;
+	unsigned core = cpu_data[cpu].core;
+	unsigned dlinesz = cpu_data[cpu].dcache.linesz;
+	void *entry_fn, *core_rc;
+
+	for (state = CPS_PM_NC_WAIT; state < CPS_PM_STATE_COUNT; state++) {
+		if (per_cpu(nc_asm_enter, core)[state])
+			continue;
+		if (!test_bit(state, state_support))
+			continue;
+
+		entry_fn = cps_gen_entry_code(cpu, state);
+		if (!entry_fn) {
+			pr_err("Failed to generate core %u state %u entry\n",
+			       core, state);
+			clear_bit(state, state_support);
+		}
+
+		per_cpu(nc_asm_enter, core)[state] = entry_fn;
+	}
+
+	if (!per_cpu(ready_count, core)) {
+		core_rc = kmalloc(dlinesz * 2, GFP_KERNEL);
+		if (!core_rc) {
+			pr_err("Failed allocate core %u ready_count\n", core);
+			return -ENOMEM;
+		}
+		per_cpu(ready_count_alloc, core) = core_rc;
+
+		/* Ensure ready_count is aligned to a cacheline boundary */
+		core_rc += dlinesz - 1;
+		core_rc = (void *)((unsigned long)core_rc & ~(dlinesz - 1));
+		per_cpu(ready_count, core) = core_rc;
+	}
+
+	return 0;
+}
+
+static int __init cps_pm_init(void)
+{
+	unsigned cpu;
+	int err;
+
+	/* Detect appropriate sync types for the system */
+	switch (current_cpu_data.cputype) {
+	case CPU_INTERAPTIV:
+	case CPU_PROAPTIV:
+	case CPU_M5150:
+	case CPU_P5600:
+		stype_intervention = 0x2;
+		stype_memory = 0x3;
+		stype_ordering = 0x10;
+		break;
+
+	default:
+		pr_warn("Power management is using heavyweight sync 0\n");
+	}
+
+	/* A CM is required for all non-coherent states */
+	if (!mips_cm_present()) {
+		pr_warn("pm-cps: no CM, non-coherent states unavailable\n");
+		goto out;
+	}
+
+	/*
+	 * If interrupts were enabled whilst running a wait instruction on a
+	 * non-coherent core then the VPE may end up processing interrupts
+	 * whilst non-coherent. That would be bad.
+	 */
+	if (cpu_wait == r4k_wait_irqoff)
+		set_bit(CPS_PM_NC_WAIT, state_support);
+	else
+		pr_warn("pm-cps: non-coherent wait unavailable\n");
+
+	/* Detect whether a CPC is present */
+	if (mips_cpc_present()) {
+		/* Detect whether clock gating is implemented */
+		if (read_cpc_cl_stat_conf() & CPC_Cx_STAT_CONF_CLKGAT_IMPL_MSK)
+			set_bit(CPS_PM_CLOCK_GATED, state_support);
+		else
+			pr_warn("pm-cps: CPC does not support clock gating\n");
+
+		/* Power gating is available with CPS SMP & any CPC */
+		if (mips_cps_smp_in_use())
+			set_bit(CPS_PM_POWER_GATED, state_support);
+		else
+			pr_warn("pm-cps: CPS SMP not in use, power gating unavailable\n");
+	} else {
+		pr_warn("pm-cps: no CPC, clock & power gating unavailable\n");
+	}
+
+	for_each_present_cpu(cpu) {
+		err = cps_gen_core_entries(cpu);
+		if (err)
+			return err;
+	}
+out:
+	return 0;
+}
+arch_initcall(cps_pm_init);
-- 
1.8.5.3
