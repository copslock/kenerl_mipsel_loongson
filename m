Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2014 15:03:58 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.115]:57327 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6837164AbaDPNCWEQZle (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Apr 2014 15:02:22 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 907522D572A53
        for <linux-mips@linux-mips.org>; Wed, 16 Apr 2014 14:02:11 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Wed, 16 Apr
 2014 14:02:13 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 16 Apr 2014 14:02:13 +0100
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Wed, 16 Apr 2014 14:02:12 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 26/39] MIPS: smp-cps: rework core/VPE initialisation
Date:   Wed, 16 Apr 2014 13:53:17 +0100
Message-ID: <1397652810-4336-27-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1397652810-4336-1-git-send-email-paul.burton@imgtec.com>
References: <1397652810-4336-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39833
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

When hotplug and/or a powered down idle state are supported cases will
arise where a non-zero VPE must be brought online without VPE 0, and it
where multiple VPEs must be onlined simultaneously. This patch prepares
for that by:

  - Splitting struct boot_config into core & VPE boot config structures,
    allocated one per core or VPE respectively. This allows for multiple
    VPEs to be onlined simultaneously without clobbering each others
    configuration.

  - Indicating which VPEs should be online within a core at any given
    time using a bitmap. This allows multiple VPEs to be brought online
    simultaneously and also indicates to VPE 0 whether it should halt
    after starting any non-zero VPEs that should be online within the
    core. For example if all VPEs within a core are offlined via hotplug
    and the user onlines the second VPE within that core:

      1) The core will be powered up.

      2) VPE 0 will run from the BEV (ie. mips_cps_core_entry) to
         initialise the core.

      3) VPE 0 will start VPE 1 because its bit is set in the cores
         bitmap.

      4) VPE 0 will halt itself because its bit is clear in the cores
         bitmap.

  - Moving the core & VPE initialisation to assembly code which does not
    make any use of the stack. This is because if a non-zero VPE is to
    be brought online in a powered down core then when VPE 0 of that
    core runs it may not have a valid stack, and even if it did then
    it's messy to run through parts of generic kernel code on VPE 0
    before starting the correct VPE.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/asm/smp-cps.h |  14 +-
 arch/mips/kernel/asm-offsets.c  |  14 +-
 arch/mips/kernel/cps-vec.S      | 282 ++++++++++++++++++++++++++++++++++++++--
 arch/mips/kernel/mips-cpc.c     |   2 +
 arch/mips/kernel/smp-cps.c      | 223 ++++++++++++-------------------
 5 files changed, 374 insertions(+), 161 deletions(-)

diff --git a/arch/mips/include/asm/smp-cps.h b/arch/mips/include/asm/smp-cps.h
index d60d1a2..d49279e 100644
--- a/arch/mips/include/asm/smp-cps.h
+++ b/arch/mips/include/asm/smp-cps.h
@@ -13,17 +13,23 @@
 
 #ifndef __ASSEMBLY__
 
-struct boot_config {
-	unsigned int core;
-	unsigned int vpe;
+struct vpe_boot_config {
 	unsigned long pc;
 	unsigned long sp;
 	unsigned long gp;
 };
 
-extern struct boot_config mips_cps_bootcfg;
+struct core_boot_config {
+	atomic_t vpe_mask;
+	struct vpe_boot_config *vpe_config;
+};
+
+extern struct core_boot_config *mips_cps_core_bootcfg;
 
 extern void mips_cps_core_entry(void);
+extern void mips_cps_core_init(void);
+
+extern struct vpe_boot_config *mips_cps_boot_vpes(void);
 
 #else /* __ASSEMBLY__ */
 
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index e085cde..d63490d 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -487,10 +487,14 @@ void output_kvm_defines(void)
 void output_cps_defines(void)
 {
 	COMMENT(" MIPS CPS offsets. ");
-	OFFSET(BOOTCFG_CORE, boot_config, core);
-	OFFSET(BOOTCFG_VPE, boot_config, vpe);
-	OFFSET(BOOTCFG_PC, boot_config, pc);
-	OFFSET(BOOTCFG_SP, boot_config, sp);
-	OFFSET(BOOTCFG_GP, boot_config, gp);
+
+	OFFSET(COREBOOTCFG_VPEMASK, core_boot_config, vpe_mask);
+	OFFSET(COREBOOTCFG_VPECONFIG, core_boot_config, vpe_config);
+	DEFINE(COREBOOTCFG_SIZE, sizeof(struct core_boot_config));
+
+	OFFSET(VPEBOOTCFG_PC, vpe_boot_config, pc);
+	OFFSET(VPEBOOTCFG_SP, vpe_boot_config, sp);
+	OFFSET(VPEBOOTCFG_GP, vpe_boot_config, gp);
+	DEFINE(VPEBOOTCFG_SIZE, sizeof(struct vpe_boot_config));
 }
 #endif
diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index f7a46db..57ec18c 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -14,12 +14,33 @@
 #include <asm/asmmacro.h>
 #include <asm/cacheops.h>
 #include <asm/mipsregs.h>
+#include <asm/mipsmtregs.h>
 
-#define GCR_CL_COHERENCE_OFS 0x2008
+#define GCR_CL_COHERENCE_OFS	0x2008
+#define GCR_CL_ID_OFS		0x2028
+
+.extern mips_cm_base
+
+.set noreorder
+
+	/*
+	 * Set dest to non-zero if the core supports the MT ASE, else zero. If
+	 * MT is not supported then branch to nomt.
+	 */
+	.macro	has_mt	dest, nomt
+	mfc0	\dest, CP0_CONFIG
+	bgez	\dest, \nomt
+	 mfc0	\dest, CP0_CONFIG, 1
+	bgez	\dest, \nomt
+	 mfc0	\dest, CP0_CONFIG, 2
+	bgez	\dest, \nomt
+	 mfc0	\dest, CP0_CONFIG, 3
+	andi	\dest, \dest, MIPS_CONF3_MT
+	beqz	\dest, \nomt
+	.endm
 
 .section .text.cps-vec
 .balign 0x1000
-.set noreorder
 
 LEAF(mips_cps_core_entry)
 	/*
@@ -134,21 +155,24 @@ dcache_done:
 	jr	t0
 	 nop
 
-1:	/* We're up, cached & coherent */
+	/*
+	 * We're up, cached & coherent. Perform any further required core-level
+	 * initialisation.
+	 */
+1:	jal	mips_cps_core_init
+	 nop
 
 	/*
-	 * TODO: We should check the VPE number we intended to boot here, and
-	 *       if non-zero we should start that VPE and stop this one. For
-	 *       the moment this doesn't matter since CPUs are brought up
-	 *       sequentially and in order, but once hotplug is implemented
-	 *       this will need revisiting.
+	 * Boot any other VPEs within this core that should be online, and
+	 * deactivate this VPE if it should be offline.
 	 */
+	jal	mips_cps_boot_vpes
+	 nop
 
 	/* Off we go! */
-	la	t0, mips_cps_bootcfg
-	lw	t1, BOOTCFG_PC(t0)
-	lw	gp, BOOTCFG_GP(t0)
-	lw	sp, BOOTCFG_SP(t0)
+	lw	t1, VPEBOOTCFG_PC(v0)
+	lw	gp, VPEBOOTCFG_GP(v0)
+	lw	sp, VPEBOOTCFG_SP(v0)
 	jr	t1
 	 nop
 	END(mips_cps_core_entry)
@@ -189,3 +213,237 @@ LEAF(excep_ejtag)
 	jr	k0
 	 nop
 	END(excep_ejtag)
+
+LEAF(mips_cps_core_init)
+#ifdef CONFIG_MIPS_MT
+	/* Check that the core implements the MT ASE */
+	has_mt	t0, 3f
+	 nop
+
+	.set	push
+	.set	mt
+
+	/* Only allow 1 TC per VPE to execute... */
+	dmt
+
+	/* ...and for the moment only 1 VPE */
+	dvpe
+	la	t1, 1f
+	jr.hb	t1
+	 nop
+
+	/* Enter VPE configuration state */
+1:	mfc0	t0, CP0_MVPCONTROL
+	ori	t0, t0, MVPCONTROL_VPC
+	mtc0	t0, CP0_MVPCONTROL
+
+	/* Retrieve the number of VPEs within the core */
+	mfc0	t0, CP0_MVPCONF0
+	srl	t0, t0, MVPCONF0_PVPE_SHIFT
+	andi	t0, t0, (MVPCONF0_PVPE >> MVPCONF0_PVPE_SHIFT)
+	addi	t7, t0, 1
+
+	/* If there's only 1, we're done */
+	beqz	t0, 2f
+	 nop
+
+	/* Loop through each VPE within this core */
+	li	t5, 1
+
+1:	/* Operate on the appropriate TC */
+	mtc0	t5, CP0_VPECONTROL
+	ehb
+
+	/* Bind TC to VPE (1:1 TC:VPE mapping) */
+	mttc0	t5, CP0_TCBIND
+
+	/* Set exclusive TC, non-active, master */
+	li	t0, VPECONF0_MVP
+	sll	t1, t5, VPECONF0_XTC_SHIFT
+	or	t0, t0, t1
+	mttc0	t0, CP0_VPECONF0
+
+	/* Set TC non-active, non-allocatable */
+	mttc0	zero, CP0_TCSTATUS
+
+	/* Set TC halted */
+	li	t0, TCHALT_H
+	mttc0	t0, CP0_TCHALT
+
+	/* Next VPE */
+	addi	t5, t5, 1
+	slt	t0, t5, t7
+	bnez	t0, 1b
+	 nop
+
+	/* Leave VPE configuration state */
+2:	mfc0	t0, CP0_MVPCONTROL
+	xori	t0, t0, MVPCONTROL_VPC
+	mtc0	t0, CP0_MVPCONTROL
+
+3:	.set	pop
+#endif
+	jr	ra
+	 nop
+	END(mips_cps_core_init)
+
+LEAF(mips_cps_boot_vpes)
+	/* Retrieve CM base address */
+	la	t0, mips_cm_base
+	lw	t0, 0(t0)
+
+	/* Calculate a pointer to this cores struct core_boot_config */
+	lw	t0, GCR_CL_ID_OFS(t0)
+	li	t1, COREBOOTCFG_SIZE
+	mul	t0, t0, t1
+	la	t1, mips_cps_core_bootcfg
+	lw	t1, 0(t1)
+	addu	t0, t0, t1
+
+	/* Calculate this VPEs ID. If the core doesn't support MT use 0 */
+	has_mt	t6, 1f
+	 li	t9, 0
+
+	/* Find the number of VPEs present in the core */
+	mfc0	t1, CP0_MVPCONF0
+	srl	t1, t1, MVPCONF0_PVPE_SHIFT
+	andi	t1, t1, MVPCONF0_PVPE >> MVPCONF0_PVPE_SHIFT
+	addi	t1, t1, 1
+
+	/* Calculate a mask for the VPE ID from EBase.CPUNum */
+	clz	t1, t1
+	li	t2, 31
+	subu	t1, t2, t1
+	li	t2, 1
+	sll	t1, t2, t1
+	addiu	t1, t1, -1
+
+	/* Retrieve the VPE ID from EBase.CPUNum */
+	mfc0	t9, $15, 1
+	and	t9, t9, t1
+
+1:	/* Calculate a pointer to this VPEs struct vpe_boot_config */
+	li	t1, VPEBOOTCFG_SIZE
+	mul	v0, t9, t1
+	lw	t7, COREBOOTCFG_VPECONFIG(t0)
+	addu	v0, v0, t7
+
+#ifdef CONFIG_MIPS_MT
+
+	/* If the core doesn't support MT then return */
+	bnez	t6, 1f
+	 nop
+	jr	ra
+	 nop
+
+	.set	push
+	.set	mt
+
+1:	/* Enter VPE configuration state */
+	dvpe
+	la	t1, 1f
+	jr.hb	t1
+	 nop
+1:	mfc0	t1, CP0_MVPCONTROL
+	ori	t1, t1, MVPCONTROL_VPC
+	mtc0	t1, CP0_MVPCONTROL
+	ehb
+
+	/* Loop through each VPE */
+	lw	t6, COREBOOTCFG_VPEMASK(t0)
+	move	t8, t6
+	li	t5, 0
+
+	/* Check whether the VPE should be running. If not, skip it */
+1:	andi	t0, t6, 1
+	beqz	t0, 2f
+	 nop
+
+	/* Operate on the appropriate TC */
+	mfc0	t0, CP0_VPECONTROL
+	ori	t0, t0, VPECONTROL_TARGTC
+	xori	t0, t0, VPECONTROL_TARGTC
+	or	t0, t0, t5
+	mtc0	t0, CP0_VPECONTROL
+	ehb
+
+	/* Skip the VPE if its TC is not halted */
+	mftc0	t0, CP0_TCHALT
+	beqz	t0, 2f
+	 nop
+
+	/* Calculate a pointer to the VPEs struct vpe_boot_config */
+	li	t0, VPEBOOTCFG_SIZE
+	mul	t0, t0, t5
+	addu	t0, t0, t7
+
+	/* Set the TC restart PC */
+	lw	t1, VPEBOOTCFG_PC(t0)
+	mttc0	t1, CP0_TCRESTART
+
+	/* Set the TC stack pointer */
+	lw	t1, VPEBOOTCFG_SP(t0)
+	mttgpr	t1, sp
+
+	/* Set the TC global pointer */
+	lw	t1, VPEBOOTCFG_GP(t0)
+	mttgpr	t1, gp
+
+	/* Copy config from this VPE */
+	mfc0	t0, CP0_CONFIG
+	mttc0	t0, CP0_CONFIG
+
+	/* Ensure no software interrupts are pending */
+	mttc0	zero, CP0_CAUSE
+	mttc0	zero, CP0_STATUS
+
+	/* Set TC active, not interrupt exempt */
+	mftc0	t0, CP0_TCSTATUS
+	li	t1, ~TCSTATUS_IXMT
+	and	t0, t0, t1
+	ori	t0, t0, TCSTATUS_A
+	mttc0	t0, CP0_TCSTATUS
+
+	/* Clear the TC halt bit */
+	mttc0	zero, CP0_TCHALT
+
+	/* Set VPE active */
+	mftc0	t0, CP0_VPECONF0
+	ori	t0, t0, VPECONF0_VPA
+	mttc0	t0, CP0_VPECONF0
+
+	/* Next VPE */
+2:	srl	t6, t6, 1
+	addi	t5, t5, 1
+	bnez	t6, 1b
+	 nop
+
+	/* Leave VPE configuration state */
+	mfc0	t1, CP0_MVPCONTROL
+	xori	t1, t1, MVPCONTROL_VPC
+	mtc0	t1, CP0_MVPCONTROL
+	ehb
+	evpe
+
+	/* Check whether this VPE is meant to be running */
+	li	t0, 1
+	sll	t0, t0, t9
+	and	t0, t0, t8
+	bnez	t0, 2f
+	 nop
+
+	/* This VPE should be offline, halt the TC */
+	li	t0, TCHALT_H
+	mtc0	t0, CP0_TCHALT
+	la	t0, 1f
+1:	jr.hb	t0
+	 nop
+
+2:	.set	pop
+
+#endif /* CONFIG_MIPS_MT */
+
+	/* Return */
+	jr	ra
+	 nop
+	END(mips_cps_boot_vpes)
diff --git a/arch/mips/kernel/mips-cpc.c b/arch/mips/kernel/mips-cpc.c
index 2368fc5..ba47360 100644
--- a/arch/mips/kernel/mips-cpc.c
+++ b/arch/mips/kernel/mips-cpc.c
@@ -9,6 +9,8 @@
  */
 
 #include <linux/errno.h>
+#include <linux/percpu.h>
+#include <linux/spinlock.h>
 
 #include <asm/mips-cm.h>
 #include <asm/mips-cpc.h>
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 536eec0..af90e82 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -26,98 +26,37 @@
 
 static DECLARE_BITMAP(core_power, NR_CPUS);
 
-struct boot_config mips_cps_bootcfg;
+struct core_boot_config *mips_cps_core_bootcfg;
 
-static void init_core(void)
+static unsigned core_vpe_count(unsigned core)
 {
-	unsigned int nvpes, t;
-	u32 mvpconf0, vpeconf0, vpecontrol, tcstatus, tcbind, status;
+	unsigned cfg;
 
-	if (!cpu_has_mipsmt)
-		return;
-
-	/* Enter VPE configuration state */
-	dvpe();
-	set_c0_mvpcontrol(MVPCONTROL_VPC);
-
-	/* Retrieve the count of VPEs in this core */
-	mvpconf0 = read_c0_mvpconf0();
-	nvpes = ((mvpconf0 & MVPCONF0_PVPE) >> MVPCONF0_PVPE_SHIFT) + 1;
-	smp_num_siblings = nvpes;
-
-	for (t = 1; t < nvpes; t++) {
-		/* Use a 1:1 mapping of TC index to VPE index */
-		settc(t);
-
-		/* Bind 1 TC to this VPE */
-		tcbind = read_tc_c0_tcbind();
-		tcbind &= ~TCBIND_CURVPE;
-		tcbind |= t << TCBIND_CURVPE_SHIFT;
-		write_tc_c0_tcbind(tcbind);
-
-		/* Set exclusive TC, non-active, master */
-		vpeconf0 = read_vpe_c0_vpeconf0();
-		vpeconf0 &= ~(VPECONF0_XTC | VPECONF0_VPA);
-		vpeconf0 |= t << VPECONF0_XTC_SHIFT;
-		vpeconf0 |= VPECONF0_MVP;
-		write_vpe_c0_vpeconf0(vpeconf0);
-
-		/* Declare TC non-active, non-allocatable & interrupt exempt */
-		tcstatus = read_tc_c0_tcstatus();
-		tcstatus &= ~(TCSTATUS_A | TCSTATUS_DA);
-		tcstatus |= TCSTATUS_IXMT;
-		write_tc_c0_tcstatus(tcstatus);
-
-		/* Halt the TC */
-		write_tc_c0_tchalt(TCHALT_H);
-
-		/* Allow only 1 TC to execute */
-		vpecontrol = read_vpe_c0_vpecontrol();
-		vpecontrol &= ~VPECONTROL_TE;
-		write_vpe_c0_vpecontrol(vpecontrol);
-
-		/* Copy (most of) Status from VPE 0 */
-		status = read_c0_status();
-		status &= ~(ST0_IM | ST0_IE | ST0_KSU);
-		status |= ST0_CU0;
-		write_vpe_c0_status(status);
-
-		/* Copy Config from VPE 0 */
-		write_vpe_c0_config(read_c0_config());
-		write_vpe_c0_config7(read_c0_config7());
-
-		/* Ensure no software interrupts are pending */
-		write_vpe_c0_cause(0);
-
-		/* Sync Count */
-		write_vpe_c0_count(read_c0_count());
-	}
+	if (!config_enabled(CONFIG_MIPS_MT_SMP) || !cpu_has_mipsmt)
+		return 1;
 
-	/* Leave VPE configuration state */
-	clear_c0_mvpcontrol(MVPCONTROL_VPC);
+	write_gcr_cl_other(core << CM_GCR_Cx_OTHER_CORENUM_SHF);
+	cfg = read_gcr_co_config() & CM_GCR_Cx_CONFIG_PVPE_MSK;
+	return (cfg >> CM_GCR_Cx_CONFIG_PVPE_SHF) + 1;
 }
 
 static void __init cps_smp_setup(void)
 {
 	unsigned int ncores, nvpes, core_vpes;
 	int c, v;
-	u32 core_cfg, *entry_code;
+	u32 *entry_code;
 
 	/* Detect & record VPE topology */
 	ncores = mips_cm_numcores();
 	pr_info("VPE topology ");
 	for (c = nvpes = 0; c < ncores; c++) {
-		if (cpu_has_mipsmt && config_enabled(CONFIG_MIPS_MT_SMP)) {
-			write_gcr_cl_other(c << CM_GCR_Cx_OTHER_CORENUM_SHF);
-			core_cfg = read_gcr_co_config();
-			core_vpes = ((core_cfg & CM_GCR_Cx_CONFIG_PVPE_MSK) >>
-				     CM_GCR_Cx_CONFIG_PVPE_SHF) + 1;
-		} else {
-			core_vpes = 1;
-		}
-
+		core_vpes = core_vpe_count(c);
 		pr_cont("%c%u", c ? ',' : '{', core_vpes);
 
+		/* Use the number of VPEs in core 0 for smp_num_siblings */
+		if (!c)
+			smp_num_siblings = core_vpes;
+
 		for (v = 0; v < min_t(int, core_vpes, NR_CPUS - nvpes); v++) {
 			cpu_data[nvpes + v].core = c;
 #ifdef CONFIG_MIPS_MT_SMP
@@ -140,12 +79,8 @@ static void __init cps_smp_setup(void)
 	/* Core 0 is powered up (we're running on it) */
 	bitmap_set(core_power, 0, 1);
 
-	/* Disable MT - we only want to run 1 TC per VPE */
-	if (cpu_has_mipsmt)
-		dmt();
-
 	/* Initialise core 0 */
-	init_core();
+	mips_cps_core_init();
 
 	/* Patch the start of mips_cps_core_entry to provide the CM base */
 	entry_code = (u32 *)&mips_cps_core_entry;
@@ -157,15 +92,60 @@ static void __init cps_smp_setup(void)
 
 static void __init cps_prepare_cpus(unsigned int max_cpus)
 {
+	unsigned ncores, core_vpes, c;
+
 	mips_mt_set_cpuoptions();
+
+	/* Allocate core boot configuration structs */
+	ncores = mips_cm_numcores();
+	mips_cps_core_bootcfg = kcalloc(ncores, sizeof(*mips_cps_core_bootcfg),
+					GFP_KERNEL);
+	if (!mips_cps_core_bootcfg) {
+		pr_err("Failed to allocate boot config for %u cores\n", ncores);
+		goto err_out;
+	}
+
+	/* Allocate VPE boot configuration structs */
+	for (c = 0; c < ncores; c++) {
+		core_vpes = core_vpe_count(c);
+		mips_cps_core_bootcfg[c].vpe_config = kcalloc(core_vpes,
+				sizeof(*mips_cps_core_bootcfg[c].vpe_config),
+				GFP_KERNEL);
+		if (!mips_cps_core_bootcfg[c].vpe_config) {
+			pr_err("Failed to allocate %u VPE boot configs\n",
+			       core_vpes);
+			goto err_out;
+		}
+	}
+
+	/* Mark this CPU as booted */
+	atomic_set(&mips_cps_core_bootcfg[current_cpu_data.core].vpe_mask,
+		   1 << cpu_vpe_id(&current_cpu_data));
+
+	return;
+err_out:
+	/* Clean up allocations */
+	if (mips_cps_core_bootcfg) {
+		for (c = 0; c < ncores; c++)
+			kfree(mips_cps_core_bootcfg[c].vpe_config);
+		kfree(mips_cps_core_bootcfg);
+		mips_cps_core_bootcfg = NULL;
+	}
+
+	/* Effectively disable SMP by declaring CPUs not present */
+	for_each_possible_cpu(c) {
+		if (c == 0)
+			continue;
+		set_cpu_present(c, false);
+	}
 }
 
-static void boot_core(struct boot_config *cfg)
+static void boot_core(unsigned core)
 {
 	u32 access;
 
 	/* Select the appropriate core */
-	write_gcr_cl_other(cfg->core << CM_GCR_Cx_OTHER_CORENUM_SHF);
+	write_gcr_cl_other(core << CM_GCR_Cx_OTHER_CORENUM_SHF);
 
 	/* Set its reset vector */
 	write_gcr_co_reset_base(CKSEG1ADDR((unsigned long)mips_cps_core_entry));
@@ -175,15 +155,12 @@ static void boot_core(struct boot_config *cfg)
 
 	/* Ensure the core can access the GCRs */
 	access = read_gcr_access();
-	access |= 1 << (CM_GCR_ACCESS_ACCESSEN_SHF + cfg->core);
+	access |= 1 << (CM_GCR_ACCESS_ACCESSEN_SHF + core);
 	write_gcr_access(access);
 
-	/* Copy cfg */
-	mips_cps_bootcfg = *cfg;
-
 	if (mips_cpc_present()) {
 		/* Select the appropriate core */
-		write_cpc_cl_other(cfg->core << CPC_Cx_OTHER_CORENUM_SHF);
+		write_cpc_cl_other(core << CPC_Cx_OTHER_CORENUM_SHF);
 
 		/* Reset the core */
 		write_cpc_co_cmd(CPC_Cx_CMD_RESET);
@@ -193,77 +170,47 @@ static void boot_core(struct boot_config *cfg)
 	}
 
 	/* The core is now powered up */
-	bitmap_set(core_power, cfg->core, 1);
+	bitmap_set(core_power, core, 1);
 }
 
-static void boot_vpe(void *info)
+static void remote_vpe_boot(void *dummy)
 {
-	struct boot_config *cfg = info;
-	u32 tcstatus, vpeconf0;
-
-	/* Enter VPE configuration state */
-	dvpe();
-	set_c0_mvpcontrol(MVPCONTROL_VPC);
-
-	settc(cfg->vpe);
-
-	/* Set the TC restart PC */
-	write_tc_c0_tcrestart((unsigned long)&smp_bootstrap);
-
-	/* Activate the TC, allow interrupts */
-	tcstatus = read_tc_c0_tcstatus();
-	tcstatus &= ~TCSTATUS_IXMT;
-	tcstatus |= TCSTATUS_A;
-	write_tc_c0_tcstatus(tcstatus);
-
-	/* Clear the TC halt bit */
-	write_tc_c0_tchalt(0);
-
-	/* Activate the VPE */
-	vpeconf0 = read_vpe_c0_vpeconf0();
-	vpeconf0 |= VPECONF0_VPA;
-	write_vpe_c0_vpeconf0(vpeconf0);
-
-	/* Set the stack & global pointer registers */
-	write_tc_gpr_sp(cfg->sp);
-	write_tc_gpr_gp(cfg->gp);
-
-	/* Leave VPE configuration state */
-	clear_c0_mvpcontrol(MVPCONTROL_VPC);
-
-	/* Enable other VPEs to execute */
-	evpe(EVPE_ENABLE);
+	mips_cps_boot_vpes();
 }
 
 static void cps_boot_secondary(int cpu, struct task_struct *idle)
 {
-	struct boot_config cfg;
+	unsigned core = cpu_data[cpu].core;
+	unsigned vpe_id = cpu_vpe_id(&cpu_data[cpu]);
+	struct core_boot_config *core_cfg = &mips_cps_core_bootcfg[core];
+	struct vpe_boot_config *vpe_cfg = &core_cfg->vpe_config[vpe_id];
 	unsigned int remote;
 	int err;
 
-	cfg.core = cpu_data[cpu].core;
-	cfg.vpe = cpu_vpe_id(&cpu_data[cpu]);
-	cfg.pc = (unsigned long)&smp_bootstrap;
-	cfg.sp = __KSTK_TOS(idle);
-	cfg.gp = (unsigned long)task_thread_info(idle);
+	vpe_cfg->pc = (unsigned long)&smp_bootstrap;
+	vpe_cfg->sp = __KSTK_TOS(idle);
+	vpe_cfg->gp = (unsigned long)task_thread_info(idle);
 
-	if (!test_bit(cfg.core, core_power)) {
+	atomic_or(1 << cpu_vpe_id(&cpu_data[cpu]), &core_cfg->vpe_mask);
+
+	if (!test_bit(core, core_power)) {
 		/* Boot a VPE on a powered down core */
-		boot_core(&cfg);
+		boot_core(core);
 		return;
 	}
 
-	if (cfg.core != current_cpu_data.core) {
+	if (core != current_cpu_data.core) {
 		/* Boot a VPE on another powered up core */
 		for (remote = 0; remote < NR_CPUS; remote++) {
-			if (cpu_data[remote].core != cfg.core)
+			if (cpu_data[remote].core != core)
 				continue;
 			if (cpu_online(remote))
 				break;
 		}
 		BUG_ON(remote >= NR_CPUS);
 
-		err = smp_call_function_single(remote, boot_vpe, &cfg, 1);
+		err = smp_call_function_single(remote, remote_vpe_boot,
+					       NULL, 1);
 		if (err)
 			panic("Failed to call remote CPU\n");
 		return;
@@ -272,7 +219,7 @@ static void cps_boot_secondary(int cpu, struct task_struct *idle)
 	BUG_ON(!cpu_has_mipsmt);
 
 	/* Boot a VPE on this core */
-	boot_vpe(&cfg);
+	mips_cps_boot_vpes();
 }
 
 static void cps_init_secondary(void)
@@ -281,10 +228,6 @@ static void cps_init_secondary(void)
 	if (cpu_has_mipsmt)
 		dmt();
 
-	/* TODO: revisit this assumption once hotplug is implemented */
-	if (cpu_vpe_id(&current_cpu_data) == 0)
-		init_core();
-
 	change_c0_status(ST0_IM, STATUSF_IP3 | STATUSF_IP4 |
 				 STATUSF_IP6 | STATUSF_IP7);
 }
-- 
1.8.5.3
