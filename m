From: Markos Chandras <markos.chandras@imgtec.com>
Date: Wed, 1 Jul 2015 09:13:30 +0100
Subject: MIPS: kernel: cps-vec: Replace mips32r2 ISA level with mips64r2
Message-ID: <20150701081330.wjqpN2FZ3nchzaT_IW1ctC8frEXdiXp85HF8PYpaxRQ@z>

commit 977e043d5ea1270ce985e4c165724ff91dc3c3e2 upstream.

mips32r2 is a subset of mips64r2, so we replace mips32r2 with mips64r2
in preparation for 64-bit CPS support.

Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/10588/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kernel/cps-vec.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index a4b2d81..bbbd88e 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -229,7 +229,7 @@ LEAF(mips_cps_core_init)
 	 nop

 	.set	push
-	.set	mips32r2
+	.set	mips64r2
 	.set	mt

 	/* Only allow 1 TC per VPE to execute... */
@@ -346,7 +346,7 @@ LEAF(mips_cps_boot_vpes)
 	 nop

 	.set	push
-	.set	mips32r2
+	.set	mips64r2
 	.set	mt

 1:	/* Enter VPE configuration state */
--
1.9.1
