From: Paul Burton <paul.burton@imgtec.com>
Date: Wed, 5 Aug 2015 15:42:36 -0700
Subject: MIPS: CPS: Stop dangling delay slot from has_mt.
Message-ID: <20150805224236.y-TOoSPNi15nQqQT014b96v8u7M0JOHbp3jRE7Kr_aE@z>

commit 1e5fb282f8eda889776ee83f9214d5df9edaa26d upstream.

The has_mt macro ended with a branch, leaving its callers with a delay
slot that would be executed if Config3.MT is not set. However it would
not be executed if Config3 (or earlier Config registers) don't exist
which makes it somewhat inconsistent at best. Fill the delay slot in the
macro & fix the mips_cps_boot_vpes caller appropriately.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/10865/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
[ luis: backported to 3.16: adjusted context ]
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 arch/mips/kernel/cps-vec.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index 3b3fb8924628..5652af5786ef 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -39,6 +39,7 @@
 	 mfc0	\dest, CP0_CONFIG, 3
 	andi	\dest, \dest, MIPS_CONF3_MT
 	beqz	\dest, \nomt
+	 nop
 	.endm

 .section .text.cps-vec
@@ -226,7 +227,6 @@ LEAF(mips_cps_core_init)
 #ifdef CONFIG_MIPS_MT
 	/* Check that the core implements the MT ASE */
 	has_mt	t0, 3f
-	 nop

 	.set	push
 	.set	mt
@@ -309,8 +309,8 @@ LEAF(mips_cps_boot_vpes)
 	addu	t0, t0, t1

 	/* Calculate this VPEs ID. If the core doesn't support MT use 0 */
+	li	t9, 0
 	has_mt	t6, 1f
-	 li	t9, 0

 	/* Find the number of VPEs present in the core */
 	mfc0	t1, CP0_MVPCONF0
