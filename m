From: Paul Burton <paul.burton@imgtec.com>
Date: Wed, 5 Aug 2015 15:42:38 -0700
Subject: MIPS: CPS: #ifdef on CONFIG_MIPS_MT_SMP rather than CONFIG_MIPS_MT
Message-ID: <20150805224238.JLbePY4DSdnsM5iIa1AHl3ubCcQwzIjn8epEucI2IXs@z>

commit 7a63076d9a31a6c2073da45021eeb4f89d2a8b56 upstream.

The CONFIG_MIPS_MT symbol can be selected by CONFIG_MIPS_VPE_LOADER in
addition to CONFIG_MIPS_MT_SMP. We only want MT code in the CPS SMP boot
vector if we're using MT for SMP. Thus switch the config symbol we ifdef
against to CONFIG_MIPS_MT_SMP.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/10867/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
[ luis: backported to 3.16: adjusted context ]
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 arch/mips/kernel/cps-vec.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index acd9bd6daf99..05a96be42075 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -224,7 +224,7 @@ LEAF(excep_ejtag)
 	END(excep_ejtag)

 LEAF(mips_cps_core_init)
-#ifdef CONFIG_MIPS_MT
+#ifdef CONFIG_MIPS_MT_SMP
 	/* Check that the core implements the MT ASE */
 	has_mt	t0, 3f

@@ -310,7 +310,7 @@ LEAF(mips_cps_boot_vpes)

 	/* Calculate this VPEs ID. If the core doesn't support MT use 0 */
 	li	t9, 0
-#ifdef CONFIG_MIPS_MT
+#ifdef CONFIG_MIPS_MT_SMP
 	has_mt	t6, 1f

 	/* Find the number of VPEs present in the core */
@@ -338,7 +338,7 @@ LEAF(mips_cps_boot_vpes)
 	lw	t7, COREBOOTCFG_VPECONFIG(t0)
 	addu	v0, v0, t7

-#ifdef CONFIG_MIPS_MT
+#ifdef CONFIG_MIPS_MT_SMP

 	/* If the core doesn't support MT then return */
 	bnez	t6, 1f
@@ -451,7 +451,7 @@ LEAF(mips_cps_boot_vpes)

 2:	.set	pop

-#endif /* CONFIG_MIPS_MT */
+#endif /* CONFIG_MIPS_MT_SMP */

 	/* Return */
 	jr	ra
