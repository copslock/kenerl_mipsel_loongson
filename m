Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 04:19:33 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:15300 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009964AbcBCDTFmze30 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 04:19:05 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id DBDBC276AF672;
        Wed,  3 Feb 2016 03:18:58 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 3 Feb 2016 03:18:59 +0000
Received: from localhost (10.100.200.215) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 3 Feb
 2016 03:18:58 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 11/15] MIPS: smp-cps: Pull boot config retrieval out of mips_cps_boot_vpes
Date:   Wed, 3 Feb 2016 03:15:31 +0000
Message-ID: <1454469335-14778-12-git-send-email-paul.burton@imgtec.com>
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
X-archive-position: 51639
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

The mips_cps_boot_vpes function previously included code to retrieve
pointers to the core & VPE boot configuration structs. These structures
were used both by mips_cps_boot_vpes and by its mips_cps_core_entry
callsite. In preparation for skipping the call to mips_cps_boot_vpes on
some invocations of mips_cps_core_entry, pull the calculation of those
pointers out into a separate function such that it can continue to be
shared.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/include/asm/smp-cps.h |  2 +-
 arch/mips/kernel/cps-vec.S      | 74 +++++++++++++++++++++++++----------------
 arch/mips/kernel/smp-cps.c      |  7 ++--
 3 files changed, 52 insertions(+), 31 deletions(-)

diff --git a/arch/mips/include/asm/smp-cps.h b/arch/mips/include/asm/smp-cps.h
index 326c16e..2ae1f61 100644
--- a/arch/mips/include/asm/smp-cps.h
+++ b/arch/mips/include/asm/smp-cps.h
@@ -29,7 +29,7 @@ extern struct core_boot_config *mips_cps_core_bootcfg;
 extern void mips_cps_core_entry(void);
 extern void mips_cps_core_init(void);
 
-extern struct vpe_boot_config *mips_cps_boot_vpes(void);
+extern void mips_cps_boot_vpes(struct core_boot_config *cfg, unsigned vpe);
 
 extern void mips_cps_pm_save(void);
 extern void mips_cps_pm_restore(void);
diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index 8d5ea4b..2613de9 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -60,6 +60,17 @@
 	 nop
 	.endm
 
+	/* Calculate an uncached address for the CM GCRs */
+	.macro	cmgcrb	dest
+	.set	push
+	.set	noat
+	MFC0	$1, CP0_CMGCRBASE
+	PTR_SLL	$1, $1, 4
+	PTR_LI	\dest, UNCAC_BASE
+	PTR_ADDU \dest, \dest, $1
+	.set	pop
+	.endm
+
 .section .text.cps-vec
 .balign 0x1000
 
@@ -102,13 +113,8 @@ not_nmi:
 	mtc0	t0, CP0_CONFIG
 	ehb
 
-	/* Calculate an uncached address for the CM GCRs */
-	MFC0	v1, CP0_CMGCRBASE
-	PTR_SLL	v1, v1, 4
-	PTR_LI	t0, UNCAC_BASE
-	PTR_ADDU v1, v1, t0
-
 	/* Enter the coherent domain */
+	cmgcrb	v1
 	li	t0, 0xff
 	sw	t0, GCR_CL_COHERENCE_OFS(v1)
 	ehb
@@ -128,17 +134,22 @@ not_nmi:
 	/* Do any EVA initialization if necessary */
 	eva_init
 
+	/* Retrieve boot configuration pointers */
+	jal	mips_cps_get_bootcfg
+	 nop
+
 	/*
 	 * Boot any other VPEs within this core that should be online, and
 	 * deactivate this VPE if it should be offline.
 	 */
+	move	a1, t9
 	jal	mips_cps_boot_vpes
-	 nop
+	 move	a0, v0
 
 	/* Off we go! */
-	PTR_L	t1, VPEBOOTCFG_PC(v0)
-	PTR_L	gp, VPEBOOTCFG_GP(v0)
-	PTR_L	sp, VPEBOOTCFG_SP(v0)
+	PTR_L	t1, VPEBOOTCFG_PC(v1)
+	PTR_L	gp, VPEBOOTCFG_GP(v1)
+	PTR_L	sp, VPEBOOTCFG_SP(v1)
 	jr	t1
 	 nop
 	END(mips_cps_core_entry)
@@ -258,18 +269,21 @@ LEAF(mips_cps_core_init)
 	 nop
 	END(mips_cps_core_init)
 
-LEAF(mips_cps_boot_vpes)
-	/* Retrieve CM base address */
-	PTR_LA	t0, mips_cm_base
-	PTR_L	t0, 0(t0)
-
+/**
+ * mips_cps_get_bootcfg() - retrieve boot configuration pointers
+ *
+ * Returns: pointer to struct core_boot_config in v0, pointer to
+ *          struct vpe_boot_config in v1, VPE ID in t9
+ */
+LEAF(mips_cps_get_bootcfg)
 	/* Calculate a pointer to this cores struct core_boot_config */
+	cmgcrb	t0
 	lw	t0, GCR_CL_ID_OFS(t0)
 	li	t1, COREBOOTCFG_SIZE
 	mul	t0, t0, t1
 	PTR_LA	t1, mips_cps_core_bootcfg
 	PTR_L	t1, 0(t1)
-	PTR_ADDU t0, t0, t1
+	PTR_ADDU v0, t0, t1
 
 	/* Calculate this VPEs ID. If the core doesn't support MT use 0 */
 	li	t9, 0
@@ -297,22 +311,27 @@ LEAF(mips_cps_boot_vpes)
 
 1:	/* Calculate a pointer to this VPEs struct vpe_boot_config */
 	li	t1, VPEBOOTCFG_SIZE
-	mul	v0, t9, t1
-	PTR_L	ta3, COREBOOTCFG_VPECONFIG(t0)
-	PTR_ADDU v0, v0, ta3
-
-#ifdef CONFIG_MIPS_MT_SMP
+	mul	v1, t9, t1
+	PTR_L	ta3, COREBOOTCFG_VPECONFIG(v0)
+	PTR_ADDU v1, v1, ta3
 
-	/* If the core doesn't support MT then return */
-	bnez	ta2, 1f
-	 nop
 	jr	ra
 	 nop
+	END(mips_cps_get_bootcfg)
+
+LEAF(mips_cps_boot_vpes)
+	PTR_L	ta2, COREBOOTCFG_VPEMASK(a0)
+	PTR_L	ta3, COREBOOTCFG_VPECONFIG(a0)
+
+#ifdef CONFIG_MIPS_MT
 
 	.set	push
 	.set	mt
 
-1:	/* Enter VPE configuration state */
+	/* If the core doesn't support MT then return */
+	has_mt	t0, 5f
+
+	/* Enter VPE configuration state */
 	dvpe
 	PTR_LA	t1, 1f
 	jr.hb	t1
@@ -323,7 +342,6 @@ LEAF(mips_cps_boot_vpes)
 	ehb
 
 	/* Loop through each VPE */
-	PTR_L	ta2, COREBOOTCFG_VPEMASK(t0)
 	move	t8, ta2
 	li	ta1, 0
 
@@ -400,7 +418,7 @@ LEAF(mips_cps_boot_vpes)
 
 	/* Check whether this VPE is meant to be running */
 	li	t0, 1
-	sll	t0, t0, t9
+	sll	t0, t0, a1
 	and	t0, t0, t8
 	bnez	t0, 2f
 	 nop
@@ -417,7 +435,7 @@ LEAF(mips_cps_boot_vpes)
 #endif /* CONFIG_MIPS_MT_SMP */
 
 	/* Return */
-	jr	ra
+5:	jr	ra
 	 nop
 	END(mips_cps_boot_vpes)
 
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 7b35dec..afc727f 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -250,7 +250,10 @@ static void boot_core(unsigned core)
 
 static void remote_vpe_boot(void *dummy)
 {
-	mips_cps_boot_vpes();
+	unsigned core = current_cpu_data.core;
+	struct core_boot_config *core_cfg = &mips_cps_core_bootcfg[core];
+
+	mips_cps_boot_vpes(core_cfg, cpu_vpe_id(&current_cpu_data));
 }
 
 static void cps_boot_secondary(int cpu, struct task_struct *idle)
@@ -296,7 +299,7 @@ static void cps_boot_secondary(int cpu, struct task_struct *idle)
 	BUG_ON(!cpu_has_mipsmt);
 
 	/* Boot a VPE on this core */
-	mips_cps_boot_vpes();
+	mips_cps_boot_vpes(core_cfg, vpe_id);
 out:
 	preempt_enable();
 }
-- 
2.7.0
