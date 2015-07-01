From: Markos Chandras <markos.chandras@imgtec.com>
Date: Wed, 1 Jul 2015 09:13:32 +0100
Subject: MIPS: kernel: cps-vec: Replace KSEG0 with CKSEG0
Message-ID: <20150701081332.70W4d3Wg3VGuVb3EqxogyrifWg0eqC8LqbqhmdStVH0@z>

commit 717f14255a52ad445d6f0eca7d0f22f59d6ba1f8 upstream.

In preparation for 64-bit CPS support, we replace KSEG0 with CKSEG0
so 64-bit kernels can be supported.

Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/10590/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kernel/cps-vec.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index 21f714a..2f95568 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -107,7 +107,7 @@ not_nmi:
 	mul	t1, t1, t0
 	mul	t1, t1, t2

-	li	a0, KSEG0
+	li	a0, CKSEG0
 	add	a1, a0, t1
 1:	cache	Index_Store_Tag_I, 0(a0)
 	add	a0, a0, t0
@@ -134,7 +134,7 @@ icache_done:
 	mul	t1, t1, t0
 	mul	t1, t1, t2

-	li	a0, KSEG0
+	li	a0, CKSEG0
 	addu	a1, a0, t1
 	subu	a1, a1, t0
 1:	cache	Index_Store_Tag_D, 0(a0)
--
1.9.1
