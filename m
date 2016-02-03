Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 04:20:11 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:43341 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011169AbcBCDTfNa5I0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 04:19:35 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 430A0E493A345;
        Wed,  3 Feb 2016 03:19:27 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 3 Feb 2016 03:19:28 +0000
Received: from localhost (10.100.200.215) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 3 Feb
 2016 03:19:27 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        <linux-kernel@vger.kernel.org>,
        "Niklas Cassel" <niklas.cassel@axis.com>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 13/15] MIPS: smp-cps: Support MIPSr6 Virtual Processors
Date:   Wed, 3 Feb 2016 03:15:33 +0000
Message-ID: <1454469335-14778-14-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454469335-14778-1-git-send-email-paul.burton@imgtec.com>
References: <1454469335-14778-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.215]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51641
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

Introduce support for bringing up Virtual Processors in MIPSr6 systems
as CPUs, much like their VPE parallel from the now-deprecated MT ASE.
The existing mips_cps_boot_vpes function fits the MIPSr6 architecture
pretty well - it can now simply write the mask of running VPs to the
VC_RUN register, rather than looping through each & starting or stopping
as appropriate as is done for VPEs from the MT ASE. Thus the VP support
is in general an extension & simplification of the existing MT ASE VPE
(aka SMVP) support.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/Kconfig                |  2 +-
 arch/mips/include/asm/cpu-info.h |  4 +--
 arch/mips/kernel/cps-vec.S       | 53 ++++++++++++++++++++++++++++++++++++++--
 arch/mips/kernel/smp-cps.c       | 35 +++++++++++++++++++++++---
 4 files changed, 85 insertions(+), 9 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 57a945e..3edb582 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2283,7 +2283,7 @@ config MIPS_CMP
 
 config MIPS_CPS
 	bool "MIPS Coherent Processing System support"
-	depends on SYS_SUPPORTS_MIPS_CPS && !CPU_MIPSR6
+	depends on SYS_SUPPORTS_MIPS_CPS
 	select MIPS_CM
 	select MIPS_CPC
 	select MIPS_CPS_PM if HOTPLUG_CPU
diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/cpu-info.h
index e7dc785..aa526c3 100644
--- a/arch/mips/include/asm/cpu-info.h
+++ b/arch/mips/include/asm/cpu-info.h
@@ -68,7 +68,7 @@ struct cpuinfo_mips {
 #ifdef CONFIG_64BIT
 	int			vmbits; /* Virtual memory size in bits */
 #endif
-#ifdef CONFIG_MIPS_MT_SMP
+#if defined(CONFIG_MIPS_MT_SMP) || defined(CONFIG_CPU_MIPSR6)
 	/*
 	 * There is not necessarily a 1:1 mapping of VPE num to CPU number
 	 * in particular on multi-core systems.
@@ -125,7 +125,7 @@ struct proc_cpuinfo_notifier_args {
 	unsigned long n;
 };
 
-#ifdef CONFIG_MIPS_MT_SMP
+#if defined(CONFIG_MIPS_MT_SMP) || defined(CONFIG_CPU_MIPSR6)
 # define cpu_vpe_id(cpuinfo)	((cpuinfo)->vpe_id)
 #else
 # define cpu_vpe_id(cpuinfo)	({ (void)cpuinfo; 0; })
diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index 4849cbd..c28138d 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -18,9 +18,12 @@
 #include <asm/mipsmtregs.h>
 #include <asm/pm.h>
 
+#define GCR_CPC_BASE_OFS	0x0088
 #define GCR_CL_COHERENCE_OFS	0x2008
 #define GCR_CL_ID_OFS		0x2028
 
+#define CPC_CL_VC_RUN_OFS	0x2028
+
 .extern mips_cm_base
 
 .set noreorder
@@ -60,6 +63,26 @@
 	 nop
 	.endm
 
+	/*
+	 * Set dest to non-zero if the core supports MIPSr6 multithreading
+	 * (ie. VPs), else zero. If MIPSr6 multithreading is not supported then
+	 * branch to nomt.
+	 */
+	.macro	has_vp	dest, nomt
+	mfc0	\dest, CP0_CONFIG, 1
+	bgez	\dest, \nomt
+	 mfc0	\dest, CP0_CONFIG, 2
+	bgez	\dest, \nomt
+	 mfc0	\dest, CP0_CONFIG, 3
+	bgez	\dest, \nomt
+	 mfc0	\dest, CP0_CONFIG, 4
+	bgez	\dest, \nomt
+	 mfc0	\dest, CP0_CONFIG, 5
+	andi	\dest, \dest, MIPS_CONF5_VP
+	beqz	\dest, \nomt
+	 nop
+	.endm
+
 	/* Calculate an uncached address for the CM GCRs */
 	.macro	cmgcrb	dest
 	.set	push
@@ -296,7 +319,17 @@ LEAF(mips_cps_get_bootcfg)
 
 	/* Calculate this VPEs ID. If the core doesn't support MT use 0 */
 	li	t9, 0
-#ifdef CONFIG_MIPS_MT_SMP
+#if defined(CONFIG_CPU_MIPSR6)
+	has_vp	ta2, 1f
+
+	/*
+	 * Assume non-contiguous numbering. Perhaps some day we'll need
+	 * to handle contiguous VP numbering, but no such systems yet
+	 * exist.
+	 */
+	mfc0	t9, $3, 1
+	andi	t9, t9, 0xff
+#elif defined(CONFIG_MIPS_MT_SMP)
 	has_mt	ta2, 1f
 
 	/* Find the number of VPEs present in the core */
@@ -332,7 +365,23 @@ LEAF(mips_cps_boot_vpes)
 	PTR_L	ta2, COREBOOTCFG_VPEMASK(a0)
 	PTR_L	ta3, COREBOOTCFG_VPECONFIG(a0)
 
-#ifdef CONFIG_MIPS_MT
+#if defined(CONFIG_CPU_MIPSR6)
+
+	has_vp	t0, 5f
+
+	/* Find base address of CPC */
+	cmgcrb	t3
+	PTR_L	t1, GCR_CPC_BASE_OFS(t3)
+	PTR_LI	t2, ~0x7fff
+	and	t1, t1, t2
+	PTR_LI	t2, UNCAC_BASE
+	PTR_ADD	t1, t1, t2
+
+	/* Set VC_RUN to the VPE mask */
+	PTR_S	ta2, CPC_CL_VC_RUN_OFS(t1)
+	ehb
+
+#elif defined(CONFIG_MIPS_MT)
 
 	.set	push
 	.set	mt
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index afc727f..27f1c04 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -35,7 +35,8 @@ static unsigned core_vpe_count(unsigned core)
 {
 	unsigned cfg;
 
-	if (!config_enabled(CONFIG_MIPS_MT_SMP) || !cpu_has_mipsmt)
+	if ((!config_enabled(CONFIG_MIPS_MT_SMP) || !cpu_has_mipsmt)
+		&& (!config_enabled(CONFIG_CPU_MIPSR6) || !cpu_has_vp))
 		return 1;
 
 	mips_cm_lock_other(core, 0);
@@ -47,11 +48,12 @@ static unsigned core_vpe_count(unsigned core)
 static void __init cps_smp_setup(void)
 {
 	unsigned int ncores, nvpes, core_vpes;
+	unsigned long core_entry;
 	int c, v;
 
 	/* Detect & record VPE topology */
 	ncores = mips_cm_numcores();
-	pr_info("VPE topology ");
+	pr_info("%s topology ", cpu_has_mips_r6 ? "VP" : "VPE");
 	for (c = nvpes = 0; c < ncores; c++) {
 		core_vpes = core_vpe_count(c);
 		pr_cont("%c%u", c ? ',' : '{', core_vpes);
@@ -62,7 +64,7 @@ static void __init cps_smp_setup(void)
 
 		for (v = 0; v < min_t(int, core_vpes, NR_CPUS - nvpes); v++) {
 			cpu_data[nvpes + v].core = c;
-#ifdef CONFIG_MIPS_MT_SMP
+#if defined(CONFIG_MIPS_MT_SMP) || defined(CONFIG_CPU_MIPSR6)
 			cpu_data[nvpes + v].vpe_id = v;
 #endif
 		}
@@ -91,6 +93,11 @@ static void __init cps_smp_setup(void)
 	/* Make core 0 coherent with everything */
 	write_gcr_cl_coherence(0xff);
 
+	if (mips_cm_revision() >= CM_REV_CM3) {
+		core_entry = CKSEG1ADDR((unsigned long)mips_cps_core_entry);
+		write_gcr_bev_base(core_entry);
+	}
+
 #ifdef CONFIG_MIPS_MT_FPAFF
 	/* If we have an FPU, enroll ourselves in the FPU-full mask */
 	if (cpu_has_fpu)
@@ -213,6 +220,18 @@ static void boot_core(unsigned core)
 	if (mips_cpc_present()) {
 		/* Reset the core */
 		mips_cpc_lock_other(core);
+
+		if (mips_cm_revision() >= CM_REV_CM3) {
+			/* Run VP0 following the reset */
+			write_cpc_co_vp_run(0x1);
+
+			/*
+			 * Ensure that the VP_RUN register is written before the
+			 * core leaves reset.
+			 */
+			wmb();
+		}
+
 		write_cpc_co_cmd(CPC_Cx_CMD_RESET);
 
 		timeout = 100;
@@ -262,6 +281,7 @@ static void cps_boot_secondary(int cpu, struct task_struct *idle)
 	unsigned vpe_id = cpu_vpe_id(&cpu_data[cpu]);
 	struct core_boot_config *core_cfg = &mips_cps_core_bootcfg[core];
 	struct vpe_boot_config *vpe_cfg = &core_cfg->vpe_config[vpe_id];
+	unsigned long core_entry;
 	unsigned int remote;
 	int err;
 
@@ -279,6 +299,13 @@ static void cps_boot_secondary(int cpu, struct task_struct *idle)
 		goto out;
 	}
 
+	if (cpu_has_vp) {
+		mips_cm_lock_other(core, vpe_id);
+		core_entry = CKSEG1ADDR((unsigned long)mips_cps_core_entry);
+		write_gcr_co_reset_base(core_entry);
+		mips_cm_unlock_other();
+	}
+
 	if (core != current_cpu_data.core) {
 		/* Boot a VPE on another powered up core */
 		for (remote = 0; remote < NR_CPUS; remote++) {
@@ -296,7 +323,7 @@ static void cps_boot_secondary(int cpu, struct task_struct *idle)
 		goto out;
 	}
 
-	BUG_ON(!cpu_has_mipsmt);
+	BUG_ON(!cpu_has_mipsmt && !cpu_has_vp);
 
 	/* Boot a VPE on this core */
 	mips_cps_boot_vpes(core_cfg, vpe_id);
-- 
2.7.0
