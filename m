From: Markos Chandras <markos.chandras@imgtec.com>
Date: Wed, 1 Jul 2015 09:13:31 +0100
Subject: MIPS: kernel: cps-vec: Use ta0-ta3 pseudo-registers for 64-bit
Message-ID: <20150701081331.E3a4sqor230lvQkNTNzjSsg8jFqJhv_YdUUzcngAiVo@z>

commit 0586ac75cd0746a4d5c43372dabcea8739ae0176 upstream.

The cps-vec code assumes O32 ABI and uses t4-t7 in quite a few places. This
breaks the build on 64-bit. As a result of which, use the pseudo-registers
ta0-ta3 to make the code compatible with 64-bit.

Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/10589/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kernel/cps-vec.S | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index bbbd88e..21f714a 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -250,25 +250,25 @@ LEAF(mips_cps_core_init)
 	mfc0	t0, CP0_MVPCONF0
 	srl	t0, t0, MVPCONF0_PVPE_SHIFT
 	andi	t0, t0, (MVPCONF0_PVPE >> MVPCONF0_PVPE_SHIFT)
-	addiu	t7, t0, 1
+	addiu	ta3, t0, 1

 	/* If there's only 1, we're done */
 	beqz	t0, 2f
 	 nop

 	/* Loop through each VPE within this core */
-	li	t5, 1
+	li	ta1, 1

 1:	/* Operate on the appropriate TC */
-	mtc0	t5, CP0_VPECONTROL
+	mtc0	ta1, CP0_VPECONTROL
 	ehb

 	/* Bind TC to VPE (1:1 TC:VPE mapping) */
-	mttc0	t5, CP0_TCBIND
+	mttc0	ta1, CP0_TCBIND

 	/* Set exclusive TC, non-active, master */
 	li	t0, VPECONF0_MVP
-	sll	t1, t5, VPECONF0_XTC_SHIFT
+	sll	t1, ta1, VPECONF0_XTC_SHIFT
 	or	t0, t0, t1
 	mttc0	t0, CP0_VPECONF0

@@ -280,8 +280,8 @@ LEAF(mips_cps_core_init)
 	mttc0	t0, CP0_TCHALT

 	/* Next VPE */
-	addiu	t5, t5, 1
-	slt	t0, t5, t7
+	addiu	ta1, ta1, 1
+	slt	t0, ta1, ta3
 	bnez	t0, 1b
 	 nop

@@ -310,7 +310,7 @@ LEAF(mips_cps_boot_vpes)
 	addu	t0, t0, t1

 	/* Calculate this VPEs ID. If the core doesn't support MT use 0 */
-	has_mt	t6, 1f
+	has_mt	ta2, 1f
 	 li	t9, 0

 	/* Find the number of VPEs present in the core */
@@ -334,13 +334,13 @@ LEAF(mips_cps_boot_vpes)
 1:	/* Calculate a pointer to this VPEs struct vpe_boot_config */
 	li	t1, VPEBOOTCFG_SIZE
 	mul	v0, t9, t1
-	lw	t7, COREBOOTCFG_VPECONFIG(t0)
-	addu	v0, v0, t7
+	lw	ta3, COREBOOTCFG_VPECONFIG(t0)
+	addu	v0, v0, ta3

 #ifdef CONFIG_MIPS_MT

 	/* If the core doesn't support MT then return */
-	bnez	t6, 1f
+	bnez	ta2, 1f
 	 nop
 	jr	ra
 	 nop
@@ -360,12 +360,12 @@ LEAF(mips_cps_boot_vpes)
 	ehb

 	/* Loop through each VPE */
-	lw	t6, COREBOOTCFG_VPEMASK(t0)
-	move	t8, t6
-	li	t5, 0
+	lw	ta2, COREBOOTCFG_VPEMASK(t0)
+	move	t8, ta2
+	li	ta1, 0

 	/* Check whether the VPE should be running. If not, skip it */
-1:	andi	t0, t6, 1
+1:	andi	t0, ta2, 1
 	beqz	t0, 2f
 	 nop

@@ -373,7 +373,7 @@ LEAF(mips_cps_boot_vpes)
 	mfc0	t0, CP0_VPECONTROL
 	ori	t0, t0, VPECONTROL_TARGTC
 	xori	t0, t0, VPECONTROL_TARGTC
-	or	t0, t0, t5
+	or	t0, t0, ta1
 	mtc0	t0, CP0_VPECONTROL
 	ehb

@@ -384,8 +384,8 @@ LEAF(mips_cps_boot_vpes)

 	/* Calculate a pointer to the VPEs struct vpe_boot_config */
 	li	t0, VPEBOOTCFG_SIZE
-	mul	t0, t0, t5
-	addu	t0, t0, t7
+	mul	t0, t0, ta1
+	addu	t0, t0, ta3

 	/* Set the TC restart PC */
 	lw	t1, VPEBOOTCFG_PC(t0)
@@ -423,9 +423,9 @@ LEAF(mips_cps_boot_vpes)
 	mttc0	t0, CP0_VPECONF0

 	/* Next VPE */
-2:	srl	t6, t6, 1
-	addiu	t5, t5, 1
-	bnez	t6, 1b
+2:	srl	ta2, ta2, 1
+	addiu	ta1, ta1, 1
+	bnez	ta2, 1b
 	 nop

 	/* Leave VPE configuration state */
--
1.9.1
