From: Paul Burton <paul.burton@imgtec.com>
Date: Wed, 5 Aug 2015 15:42:40 -0700
Subject: MIPS: CPS: drop .set mips64r2 directives
Message-ID: <20150805224240.74iEs99Ask1REjB6QZKNp9KyOmFcAH6aUfPR3-KRPTg@z>

commit f3575e230cf8537951ebe3cc19974c5db2ff4f1c upstream.

Commit 977e043d5ea1 ("MIPS: kernel: cps-vec: Replace mips32r2 ISA level
with mips64r2") leads to .set mips64r2 directives being present in 32
bit (ie. CONFIG_32BIT=y) kernels. This is incorrect & leads to MIPS64
instructions being emitted by the assembler when expanding
pseudo-instructions. For example the "move" instruction can legitimately
be expanded to a "daddu". This causes problems when the kernel is run on
a MIPS32 CPU, as CONFIG_32BIT kernels of course often are...

Fix this by dropping the .set <ISA> directives entirely now that Kconfig
should be ensuring that kernels including this code are built with a
suitable -march= compiler flag.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/10869/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kernel/cps-vec.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index 209ded1..763d8b7 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -229,7 +229,6 @@ LEAF(mips_cps_core_init)
 	has_mt	t0, 3f

 	.set	push
-	.set	mips64r2
 	.set	mt

 	/* Only allow 1 TC per VPE to execute... */
@@ -348,7 +347,6 @@ LEAF(mips_cps_boot_vpes)
 	 nop

 	.set	push
-	.set	mips64r2
 	.set	mt

 1:	/* Enter VPE configuration state */
--
1.9.1
