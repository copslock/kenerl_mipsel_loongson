From: Markos Chandras <markos.chandras@imgtec.com>
Date: Wed, 1 Jul 2015 09:13:29 +0100
Subject: MIPS: kernel: cps-vec: Replace 'la' macro with PTR_LA
Message-ID: <20150701081329.R7FdMX0uD6vPC8NWRRDHzRqmjko2E254fnBicSGH508@z>

commit 81a02e34ded906357deac7003fbb0d36b6cc503f upstream.

The PTR_LA macro will pick the correct "la" or "dla" macro to
load an address to a register. This gets rids of the following
warnings (and others) when building a 64-bit CPS kernel:

arch/mips/kernel/cps-vec.S:63: Warning: la used to load 64-bit address
arch/mips/kernel/cps-vec.S:159: Warning: la used to load 64-bit address
arch/mips/kernel/cps-vec.S:220: Warning: la used to load 64-bit address
arch/mips/kernel/cps-vec.S:240: Warning: la used to load 64-bit address
[...]

Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/10587/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kernel/cps-vec.S | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index 55b759a..a4b2d81 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -60,7 +60,7 @@ LEAF(mips_cps_core_entry)
 	 nop

 	/* This is an NMI */
-	la	k0, nmi_handler
+	PTR_LA	k0, nmi_handler
 	jr	k0
 	 nop

@@ -156,7 +156,7 @@ dcache_done:
 	ehb

 	/* Jump to kseg0 */
-	la	t0, 1f
+	PTR_LA	t0, 1f
 	jr	t0
 	 nop

@@ -217,7 +217,7 @@ LEAF(excep_intex)

 .org 0x480
 LEAF(excep_ejtag)
-	la	k0, ejtag_debug_handler
+	PTR_LA	k0, ejtag_debug_handler
 	jr	k0
 	 nop
 	END(excep_ejtag)
@@ -237,7 +237,7 @@ LEAF(mips_cps_core_init)

 	/* ...and for the moment only 1 VPE */
 	dvpe
-	la	t1, 1f
+	PTR_LA	t1, 1f
 	jr.hb	t1
 	 nop

@@ -298,14 +298,14 @@ LEAF(mips_cps_core_init)

 LEAF(mips_cps_boot_vpes)
 	/* Retrieve CM base address */
-	la	t0, mips_cm_base
+	PTR_LA	t0, mips_cm_base
 	lw	t0, 0(t0)

 	/* Calculate a pointer to this cores struct core_boot_config */
 	lw	t0, GCR_CL_ID_OFS(t0)
 	li	t1, COREBOOTCFG_SIZE
 	mul	t0, t0, t1
-	la	t1, mips_cps_core_bootcfg
+	PTR_LA	t1, mips_cps_core_bootcfg
 	lw	t1, 0(t1)
 	addu	t0, t0, t1

@@ -351,7 +351,7 @@ LEAF(mips_cps_boot_vpes)

 1:	/* Enter VPE configuration state */
 	dvpe
-	la	t1, 1f
+	PTR_LA	t1, 1f
 	jr.hb	t1
 	 nop
 1:	mfc0	t1, CP0_MVPCONTROL
@@ -445,7 +445,7 @@ LEAF(mips_cps_boot_vpes)
 	/* This VPE should be offline, halt the TC */
 	li	t0, TCHALT_H
 	mtc0	t0, CP0_TCHALT
-	la	t0, 1f
+	PTR_LA	t0, 1f
 1:	jr.hb	t0
 	 nop

@@ -466,10 +466,10 @@ LEAF(mips_cps_boot_vpes)
 	.set	noat
 	lw	$1, TI_CPU(gp)
 	sll	$1, $1, LONGLOG
-	la	\dest, __per_cpu_offset
+	PTR_LA	\dest, __per_cpu_offset
 	addu	$1, $1, \dest
 	lw	$1, 0($1)
-	la	\dest, cps_cpu_state
+	PTR_LA	\dest, cps_cpu_state
 	addu	\dest, \dest, $1
 	.set	pop
 	.endm
--
1.9.1
