From: Markos Chandras <markos.chandras@imgtec.com>
Date: Wed, 1 Jul 2015 09:13:33 +0100
Subject: MIPS: cps-vec: Use macros for various arithmetics and memory
 operations
Message-ID: <20150701081333.P44o7NWcEEcJoba0pFvlwUvgeC_cR2yMrbiFR5yFHzY@z>

commit b677bc03d757c7d749527cccdd2afcf34ebeeb07 upstream.

Replace lw/sw and various arithmetic instructions with macros so the
code can work on 64-bit kernels as well.

Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/10591/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kernel/cps-vec.S | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index 2f95568..1b6ca63 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -108,9 +108,9 @@ not_nmi:
 	mul	t1, t1, t2

 	li	a0, CKSEG0
-	add	a1, a0, t1
+	PTR_ADD	a1, a0, t1
 1:	cache	Index_Store_Tag_I, 0(a0)
-	add	a0, a0, t0
+	PTR_ADD	a0, a0, t0
 	bne	a0, a1, 1b
 	 nop
 icache_done:
@@ -135,11 +135,11 @@ icache_done:
 	mul	t1, t1, t2

 	li	a0, CKSEG0
-	addu	a1, a0, t1
-	subu	a1, a1, t0
+	PTR_ADDU a1, a0, t1
+	PTR_SUBU a1, a1, t0
 1:	cache	Index_Store_Tag_D, 0(a0)
 	bne	a0, a1, 1b
-	 add	a0, a0, t0
+	 PTR_ADD a0, a0, t0
 dcache_done:

 	/* Set Kseg0 CCA to that in s0 */
@@ -152,7 +152,7 @@ dcache_done:

 	/* Enter the coherent domain */
 	li	t0, 0xff
-	sw	t0, GCR_CL_COHERENCE_OFS(v1)
+	PTR_S	t0, GCR_CL_COHERENCE_OFS(v1)
 	ehb

 	/* Jump to kseg0 */
@@ -178,9 +178,9 @@ dcache_done:
 	 nop

 	/* Off we go! */
-	lw	t1, VPEBOOTCFG_PC(v0)
-	lw	gp, VPEBOOTCFG_GP(v0)
-	lw	sp, VPEBOOTCFG_SP(v0)
+	PTR_L	t1, VPEBOOTCFG_PC(v0)
+	PTR_L	gp, VPEBOOTCFG_GP(v0)
+	PTR_L	sp, VPEBOOTCFG_SP(v0)
 	jr	t1
 	 nop
 	END(mips_cps_core_entry)
@@ -299,15 +299,15 @@ LEAF(mips_cps_core_init)
 LEAF(mips_cps_boot_vpes)
 	/* Retrieve CM base address */
 	PTR_LA	t0, mips_cm_base
-	lw	t0, 0(t0)
+	PTR_L	t0, 0(t0)

 	/* Calculate a pointer to this cores struct core_boot_config */
-	lw	t0, GCR_CL_ID_OFS(t0)
+	PTR_L	t0, GCR_CL_ID_OFS(t0)
 	li	t1, COREBOOTCFG_SIZE
 	mul	t0, t0, t1
 	PTR_LA	t1, mips_cps_core_bootcfg
-	lw	t1, 0(t1)
-	addu	t0, t0, t1
+	PTR_L	t1, 0(t1)
+	PTR_ADDU t0, t0, t1

 	/* Calculate this VPEs ID. If the core doesn't support MT use 0 */
 	has_mt	ta2, 1f
@@ -334,8 +334,8 @@ LEAF(mips_cps_boot_vpes)
 1:	/* Calculate a pointer to this VPEs struct vpe_boot_config */
 	li	t1, VPEBOOTCFG_SIZE
 	mul	v0, t9, t1
-	lw	ta3, COREBOOTCFG_VPECONFIG(t0)
-	addu	v0, v0, ta3
+	PTR_L	ta3, COREBOOTCFG_VPECONFIG(t0)
+	PTR_ADDU v0, v0, ta3

 #ifdef CONFIG_MIPS_MT

@@ -360,7 +360,7 @@ LEAF(mips_cps_boot_vpes)
 	ehb

 	/* Loop through each VPE */
-	lw	ta2, COREBOOTCFG_VPEMASK(t0)
+	PTR_L	ta2, COREBOOTCFG_VPEMASK(t0)
 	move	t8, ta2
 	li	ta1, 0

--
1.9.1
