Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jan 2014 11:35:27 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:10844 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827367AbaAOKexZCmT1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Jan 2014 11:34:53 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 08/15] MIPS: Coherent Processing System SMP implementation
Date:   Wed, 15 Jan 2014 10:31:53 +0000
Message-ID: <1389781920-31151-9-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1389781920-31151-1-git-send-email-paul.burton@imgtec.com>
References: <1389781920-31151-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2014_01_15_10_34_48
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38992
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

This patch introduces a new SMP implementation for systems implementing
the MIPS Coherent Processing System architecture. The kernel will make
use of the Coherence Manager, Cluster Power Controller & Global
Interrupt Controller in order to detect, bring up & make use of other
cores in the system. SMTC is not supported, so only a single TC per VPE
in the system is used. That is, this option enables an SMVP style setup
but across multiple cores.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/Kconfig               |  21 +++
 arch/mips/include/asm/smp-cps.h |  33 ++++
 arch/mips/include/asm/smp-ops.h |   9 ++
 arch/mips/kernel/Makefile       |   1 +
 arch/mips/kernel/asm-offsets.c  |  13 ++
 arch/mips/kernel/cps-vec.S      | 191 +++++++++++++++++++++++
 arch/mips/kernel/cpu-probe.c    |   2 +
 arch/mips/kernel/smp-cps.c      | 329 ++++++++++++++++++++++++++++++++++++++++
 arch/mips/mm/c-r4k.c            |   2 +-
 9 files changed, 600 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/include/asm/smp-cps.h
 create mode 100644 arch/mips/kernel/cps-vec.S
 create mode 100644 arch/mips/kernel/smp-cps.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 8110934..a27863a 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1868,6 +1868,7 @@ config MIPS_MT_SMTC
 	bool "Use all TCs on all VPEs for SMP (DEPRECATED)"
 	depends on CPU_MIPS32_R2
 	depends on SYS_SUPPORTS_MULTITHREADING
+	depends on !MIPS_CPS
 	select CPU_MIPSR2_IRQ_VI
 	select CPU_MIPSR2_IRQ_EI
 	select MIPS_MT
@@ -1984,6 +1985,23 @@ config MIPS_CMP
 	help
 	  Enable Coherency Manager processor (CMP) support.
 
+config MIPS_CPS
+	bool "MIPS Coherent Processing System support"
+	depends on SYS_SUPPORTS_MIPS_CPS
+	select MIPS_CM
+	select MIPS_CPC
+	select MIPS_GIC_IPI
+	select SMP
+	select SYNC_R4K if (CEVT_R4K || CSRC_R4K)
+	select SYS_SUPPORTS_SMP
+	select WEAK_ORDERING
+	help
+	  Select this if you wish to run an SMP kernel across multiple cores
+	  within a MIPS Coherent Processing System. When this option is
+	  enabled the kernel will probe for other cores and boot them with
+	  no external assistance. It is safe to enable this when hardware
+	  support is unavailable.
+
 config MIPS_GIC_IPI
 	bool
 
@@ -2172,6 +2190,9 @@ config SMP_UP
 config SYS_SUPPORTS_MIPS_CMP
 	bool
 
+config SYS_SUPPORTS_MIPS_CPS
+	bool
+
 config SYS_SUPPORTS_SMP
 	bool
 
diff --git a/arch/mips/include/asm/smp-cps.h b/arch/mips/include/asm/smp-cps.h
new file mode 100644
index 0000000..d60d1a2
--- /dev/null
+++ b/arch/mips/include/asm/smp-cps.h
@@ -0,0 +1,33 @@
+/*
+ * Copyright (C) 2013 Imagination Technologies
+ * Author: Paul Burton <paul.burton@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __MIPS_ASM_SMP_CPS_H__
+#define __MIPS_ASM_SMP_CPS_H__
+
+#ifndef __ASSEMBLY__
+
+struct boot_config {
+	unsigned int core;
+	unsigned int vpe;
+	unsigned long pc;
+	unsigned long sp;
+	unsigned long gp;
+};
+
+extern struct boot_config mips_cps_bootcfg;
+
+extern void mips_cps_core_entry(void);
+
+#else /* __ASSEMBLY__ */
+
+.extern mips_cps_bootcfg;
+
+#endif /* __ASSEMBLY__ */
+#endif /* __MIPS_ASM_SMP_CPS_H__ */
diff --git a/arch/mips/include/asm/smp-ops.h b/arch/mips/include/asm/smp-ops.h
index 51458bb..a02c9d4 100644
--- a/arch/mips/include/asm/smp-ops.h
+++ b/arch/mips/include/asm/smp-ops.h
@@ -100,4 +100,13 @@ static inline int register_vsmp_smp_ops(void)
 #endif
 }
 
+#ifdef CONFIG_MIPS_CPS
+extern int register_cps_smp_ops(void);
+#else
+static inline int register_cps_smp_ops(void)
+{
+	return -ENODEV;
+}
+#endif
+
 #endif /* __ASM_SMP_OPS_H */
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index a6a8717..277dab3 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_MIPS_MT_FPAFF)	+= mips-mt-fpaff.o
 obj-$(CONFIG_MIPS_MT_SMTC)	+= smtc.o smtc-asm.o smtc-proc.o
 obj-$(CONFIG_MIPS_MT_SMP)	+= smp-mt.o
 obj-$(CONFIG_MIPS_CMP)		+= smp-cmp.o
+obj-$(CONFIG_MIPS_CPS)		+= smp-cps.o cps-vec.o
 obj-$(CONFIG_MIPS_GIC_IPI)	+= smp-gic.o
 obj-$(CONFIG_CPU_MIPSR2)	+= spram.o
 
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index 0c2e853..8a2a45d 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -16,6 +16,7 @@
 #include <linux/suspend.h>
 #include <asm/ptrace.h>
 #include <asm/processor.h>
+#include <asm/smp-cps.h>
 
 #include <linux/kvm_host.h>
 
@@ -397,3 +398,15 @@ void output_kvm_defines(void)
 	OFFSET(COP0_STATUS, mips_coproc, reg[MIPS_CP0_STATUS][0]);
 	BLANK();
 }
+
+#ifdef CONFIG_MIPS_CPS
+void output_cps_defines(void)
+{
+	COMMENT(" MIPS CPS offsets. ");
+	OFFSET(BOOTCFG_CORE, boot_config, core);
+	OFFSET(BOOTCFG_VPE, boot_config, vpe);
+	OFFSET(BOOTCFG_PC, boot_config, pc);
+	OFFSET(BOOTCFG_SP, boot_config, sp);
+	OFFSET(BOOTCFG_GP, boot_config, gp);
+}
+#endif
diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
new file mode 100644
index 0000000..d873fab
--- /dev/null
+++ b/arch/mips/kernel/cps-vec.S
@@ -0,0 +1,191 @@
+/*
+ * Copyright (C) 2013 Imagination Technologies
+ * Author: Paul Burton <paul.burton@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <asm/addrspace.h>
+#include <asm/asm.h>
+#include <asm/asm-offsets.h>
+#include <asm/asmmacro.h>
+#include <asm/cacheops.h>
+#include <asm/mipsregs.h>
+
+#define GCR_CL_COHERENCE_OFS 0x2008
+
+.section .text.cps-vec
+.balign 0x1000
+.set noreorder
+
+LEAF(mips_cps_core_entry)
+	/*
+	 * These first 8 bytes will be patched by cps_smp_setup to load the
+	 * base address of the CM GCRs into register v1.
+	 */
+	.quad	0
+
+	/* Check whether we're here due to an NMI */
+	mfc0	k0, CP0_STATUS
+	and	k0, t0, ST0_NMI
+	beqz	k0, not_nmi
+	 nop
+
+	/* This is an NMI */
+	la	k0, nmi_handler
+	jr	k0
+	 nop
+
+not_nmi:
+	/* Setup Cause */
+	li	t0, CAUSEF_IV
+	mtc0	t0, CP0_CAUSE
+
+	/* Setup Status */
+	li	t0, ST0_CU1 | ST0_CU0
+	mtc0	t0, CP0_STATUS
+
+	/*
+	 * Clear the bits used to index the caches. Note that the architecture
+	 * dictates that writing to any of TagLo or TagHi selects 0 or 2 should
+	 * be valid for all MIPS32 CPUs, even those for which said writes are
+	 * unnecessary.
+	 */
+	mtc0	zero, CP0_TAGLO, 0
+	mtc0	zero, CP0_TAGHI, 0
+	mtc0	zero, CP0_TAGLO, 2
+	mtc0	zero, CP0_TAGHI, 2
+	ehb
+
+	/* Primary cache configuration is indicated by Config1 */
+	mfc0	v0, CP0_CONFIG, 1
+
+	/* Detect I-cache line size */
+	_EXT	t0, v0, MIPS_CONF1_IL_SHF, MIPS_CONF1_IL_SZ
+	beqz	t0, icache_done
+	 li	t1, 2
+	sllv	t0, t1, t0
+
+	/* Detect I-cache size */
+	_EXT	t1, v0, MIPS_CONF1_IS_SHF, MIPS_CONF1_IS_SZ
+	xori	t2, t1, 0x7
+	beqz	t2, 1f
+	 li	t3, 32
+	addi	t1, t1, 1
+	sllv	t1, t3, t1
+1:	/* At this point t1 == I-cache sets per way */
+	_EXT	t2, v0, MIPS_CONF1_IA_SHF, MIPS_CONF1_IA_SZ
+	addi	t2, t2, 1
+	mul	t1, t1, t0
+	mul	t1, t1, t2
+
+	li	a0, KSEG0
+	add	a1, a0, t1
+1:	cache	Index_Store_Tag_I, 0(a0)
+	add	a0, a0, t0
+	bne	a0, a1, 1b
+	 nop
+icache_done:
+
+	/* Detect D-cache line size */
+	_EXT	t0, v0, MIPS_CONF1_DL_SHF, MIPS_CONF1_DL_SZ
+	beqz	t0, dcache_done
+	 li	t1, 2
+	sllv	t0, t1, t0
+
+	/* Detect D-cache size */
+	_EXT	t1, v0, MIPS_CONF1_DS_SHF, MIPS_CONF1_DS_SZ
+	xori	t2, t1, 0x7
+	beqz	t2, 1f
+	 li	t3, 32
+	addi	t1, t1, 1
+	sllv	t1, t3, t1
+1:	/* At this point t1 == D-cache sets per way */
+	_EXT	t2, v0, MIPS_CONF1_DA_SHF, MIPS_CONF1_DA_SZ
+	addi	t2, t2, 1
+	mul	t1, t1, t0
+	mul	t1, t1, t2
+
+	li	a0, KSEG0
+	addu	a1, a0, t1
+	subu	a1, a1, t0
+1:	cache	Index_Store_Tag_D, 0(a0)
+	bne	a0, a1, 1b
+	 add	a0, a0, t0
+dcache_done:
+
+	/* Set Kseg0 cacheable, coherent, write-back, write-allocate */
+	mfc0	t0, CP0_CONFIG
+	ori	t0, 0x7
+	xori	t0, 0x2
+	mtc0	t0, CP0_CONFIG
+	ehb
+
+	/* Enter the coherent domain */
+	li	t0, 0xff
+	sw	t0, GCR_CL_COHERENCE_OFS(v1)
+	ehb
+
+	/* Jump to kseg0 */
+	la	t0, 1f
+	jr	t0
+	 nop
+
+1:	/* We're up, cached & coherent */
+
+	/*
+	 * TODO: We should check the VPE number we intended to boot here, and
+	 *       if non-zero we should start that VPE and stop this one. For
+	 *       the moment this doesn't matter since CPUs are brought up
+	 *       sequentially and in order, but once hotplug is implemented
+	 *       this will need revisiting.
+	 */
+
+	/* Off we go! */
+	la	t0, mips_cps_bootcfg
+	lw	t1, BOOTCFG_PC(t0)
+	lw	gp, BOOTCFG_GP(t0)
+	lw	sp, BOOTCFG_SP(t0)
+	jr	t1
+	 nop
+	END(mips_cps_core_entry)
+
+.org 0x200
+LEAF(excep_tlbfill)
+	b	.
+	 nop
+	END(excep_tlbfill)
+
+.org 0x280
+LEAF(excep_xtlbfill)
+	b	.
+	 nop
+	END(excep_xtlbfill)
+
+.org 0x300
+LEAF(excep_cache)
+	b	.
+	 nop
+	END(excep_cache)
+
+.org 0x380
+LEAF(excep_genex)
+	b	.
+	 nop
+	END(excep_genex)
+
+.org 0x400
+LEAF(excep_intex)
+	b	.
+	 nop
+	END(excep_intex)
+
+.org 0x480
+LEAF(excep_ejtag)
+	la	k0, ejtag_debug_handler
+	jr	k0
+	 nop
+	END(excep_ejtag)
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 1babf25..d6a3ed8 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -398,8 +398,10 @@ static void decode_configs(struct cpuinfo_mips *c)
 
 	mips_probe_watch_registers(c);
 
+#ifndef CONFIG_MIPS_CPS
 	if (cpu_has_mips_r2)
 		c->core = read_c0_ebase() & 0x3ff;
+#endif
 }
 
 #define R4K_OPTS (MIPS_CPU_TLB | MIPS_CPU_4KEX | MIPS_CPU_4K_CACHE \
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
new file mode 100644
index 0000000..2998906
--- /dev/null
+++ b/arch/mips/kernel/smp-cps.c
@@ -0,0 +1,329 @@
+/*
+ * Copyright (C) 2013 Imagination Technologies
+ * Author: Paul Burton <paul.burton@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/io.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/smp.h>
+#include <linux/types.h>
+
+#include <asm/cacheflush.h>
+#include <asm/gic.h>
+#include <asm/mips-cm.h>
+#include <asm/mips-cpc.h>
+#include <asm/mips_mt.h>
+#include <asm/mipsregs.h>
+#include <asm/smp-cps.h>
+#include <asm/time.h>
+#include <asm/uasm.h>
+
+static DECLARE_BITMAP(core_power, NR_CPUS);
+
+struct boot_config mips_cps_bootcfg;
+
+static void init_core(void)
+{
+	unsigned int nvpes, t;
+	u32 mvpconf0, vpeconf0, vpecontrol, tcstatus, tcbind, status;
+
+	if (!cpu_has_mipsmt)
+		return;
+
+	/* Enter VPE configuration state */
+	dvpe();
+	set_c0_mvpcontrol(MVPCONTROL_VPC);
+
+	/* Retrieve the count of VPEs in this core */
+	mvpconf0 = read_c0_mvpconf0();
+	nvpes = ((mvpconf0 & MVPCONF0_PVPE) >> MVPCONF0_PVPE_SHIFT) + 1;
+	smp_num_siblings = nvpes;
+
+	for (t = 1; t < nvpes; t++) {
+		/* Use a 1:1 mapping of TC index to VPE index */
+		settc(t);
+
+		/* Bind 1 TC to this VPE */
+		tcbind = read_tc_c0_tcbind();
+		tcbind &= ~TCBIND_CURVPE;
+		tcbind |= t << TCBIND_CURVPE_SHIFT;
+		write_tc_c0_tcbind(tcbind);
+
+		/* Set exclusive TC, non-active, master */
+		vpeconf0 = read_vpe_c0_vpeconf0();
+		vpeconf0 &= ~(VPECONF0_XTC | VPECONF0_VPA);
+		vpeconf0 |= t << VPECONF0_XTC_SHIFT;
+		vpeconf0 |= VPECONF0_MVP;
+		write_vpe_c0_vpeconf0(vpeconf0);
+
+		/* Declare TC non-active, non-allocatable & interrupt exempt */
+		tcstatus = read_tc_c0_tcstatus();
+		tcstatus &= ~(TCSTATUS_A | TCSTATUS_DA);
+		tcstatus |= TCSTATUS_IXMT;
+		write_tc_c0_tcstatus(tcstatus);
+
+		/* Halt the TC */
+		write_tc_c0_tchalt(TCHALT_H);
+
+		/* Allow only 1 TC to execute */
+		vpecontrol = read_vpe_c0_vpecontrol();
+		vpecontrol &= ~VPECONTROL_TE;
+		write_vpe_c0_vpecontrol(vpecontrol);
+
+		/* Copy (most of) Status from VPE 0 */
+		status = read_c0_status();
+		status &= ~(ST0_IM | ST0_IE | ST0_KSU);
+		status |= ST0_CU0;
+		write_vpe_c0_status(status);
+
+		/* Copy Config from VPE 0 */
+		write_vpe_c0_config(read_c0_config());
+		write_vpe_c0_config7(read_c0_config7());
+
+		/* Ensure no software interrupts are pending */
+		write_vpe_c0_cause(0);
+
+		/* Sync Count */
+		write_vpe_c0_count(read_c0_count());
+	}
+
+	/* Leave VPE configuration state */
+	clear_c0_mvpcontrol(MVPCONTROL_VPC);
+}
+
+static void __init cps_smp_setup(void)
+{
+	unsigned int ncores, nvpes, core_vpes;
+	int c, v;
+	u32 core_cfg, *entry_code;
+
+	/* Detect & record VPE topology */
+	ncores = mips_cm_numcores();
+	pr_info("VPE topology ");
+	for (c = nvpes = 0; c < ncores; c++) {
+		if (cpu_has_mipsmt && config_enabled(CONFIG_MIPS_MT_SMP)) {
+			write_gcr_cl_other(c << CM_GCR_Cx_OTHER_CORENUM_SHF);
+			core_cfg = read_gcr_co_config();
+			core_vpes = ((core_cfg & CM_GCR_Cx_CONFIG_PVPE_MSK) >>
+				     CM_GCR_Cx_CONFIG_PVPE_SHF) + 1;
+		} else {
+			core_vpes = 1;
+		}
+
+		pr_cont("%c%u", c ? ',' : '{', core_vpes);
+
+		for (v = 0; v < min_t(int, core_vpes, NR_CPUS - nvpes); v++) {
+			cpu_data[nvpes + v].core = c;
+			cpu_data[nvpes + v].vpe_id = v;
+		}
+
+		nvpes += core_vpes;
+	}
+	pr_cont("} total %u\n", nvpes);
+
+	/* Indicate present CPUs (CPU being synonymous with VPE) */
+	for (v = 0; v < min_t(unsigned, nvpes, NR_CPUS); v++) {
+		set_cpu_possible(v, true);
+		set_cpu_present(v, true);
+		__cpu_number_map[v] = v;
+		__cpu_logical_map[v] = v;
+	}
+
+	/* Core 0 is powered up (we're running on it) */
+	bitmap_set(core_power, 0, 1);
+
+	/* Disable MT - we only want to run 1 TC per VPE */
+	dmt();
+
+	/* Initialise core 0 */
+	init_core();
+
+	/* Patch the start of mips_cps_core_entry to provide the CM base */
+	entry_code = (u32 *)&mips_cps_core_entry;
+	UASM_i_LA(&entry_code, 3, (long)mips_cm_base);
+
+	/* Make core 0 coherent with everything */
+	write_gcr_cl_coherence(0xff);
+}
+
+static void __init cps_prepare_cpus(unsigned int max_cpus)
+{
+	mips_mt_set_cpuoptions();
+}
+
+static void boot_core(struct boot_config *cfg)
+{
+	u32 access;
+
+	/* Select the appropriate core */
+	write_gcr_cl_other(cfg->core << CM_GCR_Cx_OTHER_CORENUM_SHF);
+
+	/* Set its reset vector */
+	write_gcr_co_reset_base(CKSEG1ADDR((unsigned long)mips_cps_core_entry));
+
+	/* Ensure its coherency is disabled */
+	write_gcr_co_coherence(0);
+
+	/* Ensure the core can access the GCRs */
+	access = read_gcr_access();
+	access |= 1 << (CM_GCR_ACCESS_ACCESSEN_SHF + cfg->core);
+	write_gcr_access(access);
+
+	/* Copy cfg */
+	mips_cps_bootcfg = *cfg;
+
+	if (mips_cpc_present()) {
+		/* Select the appropriate core */
+		write_cpc_cl_other(cfg->core << CPC_Cx_OTHER_CORENUM_SHF);
+
+		/* Reset the core */
+		write_cpc_co_cmd(CPC_Cx_CMD_RESET);
+	} else {
+		/* Take the core out of reset */
+		write_gcr_co_reset_release(0);
+	}
+
+	/* The core is now powered up */
+	bitmap_set(core_power, cfg->core, 1);
+}
+
+static void boot_vpe(void *info)
+{
+	struct boot_config *cfg = info;
+	u32 tcstatus, vpeconf0;
+
+	/* Enter VPE configuration state */
+	dvpe();
+	set_c0_mvpcontrol(MVPCONTROL_VPC);
+
+	settc(cfg->vpe);
+
+	/* Set the TC restart PC */
+	write_tc_c0_tcrestart((unsigned long)&smp_bootstrap);
+
+	/* Activate the TC, allow interrupts */
+	tcstatus = read_tc_c0_tcstatus();
+	tcstatus &= ~TCSTATUS_IXMT;
+	tcstatus |= TCSTATUS_A;
+	write_tc_c0_tcstatus(tcstatus);
+
+	/* Clear the TC halt bit */
+	write_tc_c0_tchalt(0);
+
+	/* Activate the VPE */
+	vpeconf0 = read_vpe_c0_vpeconf0();
+	vpeconf0 |= VPECONF0_VPA;
+	write_vpe_c0_vpeconf0(vpeconf0);
+
+	/* Set the stack & global pointer registers */
+	write_tc_gpr_sp(cfg->sp);
+	write_tc_gpr_gp(cfg->gp);
+
+	/* Leave VPE configuration state */
+	clear_c0_mvpcontrol(MVPCONTROL_VPC);
+
+	/* Enable other VPEs to execute */
+	evpe(EVPE_ENABLE);
+}
+
+static void cps_boot_secondary(int cpu, struct task_struct *idle)
+{
+	struct boot_config cfg;
+	unsigned int remote;
+	int err;
+
+	cfg.core = cpu_data[cpu].core;
+	cfg.vpe = cpu_data[cpu].vpe_id;
+	cfg.pc = (unsigned long)&smp_bootstrap;
+	cfg.sp = __KSTK_TOS(idle);
+	cfg.gp = (unsigned long)task_thread_info(idle);
+
+	if (!test_bit(cfg.core, core_power)) {
+		/* Boot a VPE on a powered down core */
+		boot_core(&cfg);
+		return;
+	}
+
+	if (cfg.core != current_cpu_data.core) {
+		/* Boot a VPE on another powered up core */
+		for (remote = 0; remote < NR_CPUS; remote++) {
+			if (cpu_data[remote].core != cfg.core)
+				continue;
+			if (cpu_online(remote))
+				break;
+		}
+		BUG_ON(remote >= NR_CPUS);
+
+		err = smp_call_function_single(remote, boot_vpe, &cfg, 1);
+		if (err)
+			panic("Failed to call remote CPU\n");
+		return;
+	}
+
+	/* Boot a VPE on this core */
+	boot_vpe(&cfg);
+}
+
+static void cps_init_secondary(void)
+{
+	/* Disable MT - we only want to run 1 TC per VPE */
+	dmt();
+
+	/* TODO: revisit this assumption once hotplug is implemented */
+	if (current_cpu_data.vpe_id == 0)
+		init_core();
+
+	change_c0_status(ST0_IM, STATUSF_IP3 | STATUSF_IP4 |
+				 STATUSF_IP6 | STATUSF_IP7);
+}
+
+static void cps_smp_finish(void)
+{
+	write_c0_compare(read_c0_count() + (8 * mips_hpt_frequency / HZ));
+
+#ifdef CONFIG_MIPS_MT_FPAFF
+	/* If we have an FPU, enroll ourselves in the FPU-full mask */
+	if (cpu_has_fpu)
+		cpu_set(smp_processor_id(), mt_fpu_cpumask);
+#endif /* CONFIG_MIPS_MT_FPAFF */
+
+	local_irq_enable();
+}
+
+static void cps_cpus_done(void)
+{
+}
+
+static struct plat_smp_ops cps_smp_ops = {
+	.smp_setup		= cps_smp_setup,
+	.prepare_cpus		= cps_prepare_cpus,
+	.boot_secondary		= cps_boot_secondary,
+	.init_secondary		= cps_init_secondary,
+	.smp_finish		= cps_smp_finish,
+	.send_ipi_single	= gic_send_ipi_single,
+	.send_ipi_mask		= gic_send_ipi_mask,
+	.cpus_done		= cps_cpus_done,
+};
+
+int register_cps_smp_ops(void)
+{
+	if (!mips_cm_present()) {
+		pr_warn("MIPS CPS SMP unable to proceed without a CM\n");
+		return -ENODEV;
+	}
+
+	/* check we have a GIC - we need one for IPIs */
+	if (!(read_gcr_gic_status() & CM_GCR_GIC_STATUS_EX_MSK)) {
+		pr_warn("MIPS CPS SMP unable to proceed without a GIC\n");
+		return -ENODEV;
+	}
+
+	register_smp_ops(&cps_smp_ops);
+	return 0;
+}
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 13b549a..924f60f 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -57,7 +57,7 @@ static inline void r4k_on_each_cpu(void (*func) (void *info), void *info)
 	preempt_enable();
 }
 
-#if defined(CONFIG_MIPS_CMP)
+#if defined(CONFIG_MIPS_CMP) || defined(CONFIG_MIPS_CPS)
 #define cpu_has_safe_index_cacheops 0
 #else
 #define cpu_has_safe_index_cacheops 1
-- 
1.8.4.2
