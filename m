From: Paul Burton <paul.burton@imgtec.com>
Date: Wed, 5 Aug 2015 15:42:37 -0700
Subject: MIPS: CPS: Don't include MT code in non-MT kernels.
Message-ID: <20150805224237.8NBc5M__bI1nSF4e0hnBLvtYQyXzxtUHMNwm8dbR2G8@z>

commit a5b0f6db0e6cf6224e50f6585e9c8f0c2d38a8f8 upstream.

The MT-specific code in mips_cps_boot_vpes can safely be omitted from
kernels which don't support MT, with the default VPE==0 case being used
as it would be after the has_mt (Config3.MT) check failed at runtime.
Discarding the code entirely will save us a few bytes & allow cleaner
handling of MT ASE instructions by later patches.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/10866/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kernel/cps-vec.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index 24b8c0b6..d729a5e 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -311,6 +311,7 @@ LEAF(mips_cps_boot_vpes)

 	/* Calculate this VPEs ID. If the core doesn't support MT use 0 */
 	li	t9, 0
+#ifdef CONFIG_MIPS_MT
 	has_mt	t6, 1f

 	/* Find the number of VPEs present in the core */
@@ -330,6 +331,7 @@ LEAF(mips_cps_boot_vpes)
 	/* Retrieve the VPE ID from EBase.CPUNum */
 	mfc0	t9, $15, 1
 	and	t9, t9, t1
+#endif

 1:	/* Calculate a pointer to this VPEs struct vpe_boot_config */
 	li	t1, VPEBOOTCFG_SIZE
--
1.9.1
