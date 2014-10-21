From: Markos Chandras <markos.chandras@imgtec.com>
Date: Tue, 21 Oct 2014 10:21:54 +0100
Subject: MIPS: cp1emu: Fix ISA restrictions for cop1x_op instructions
Message-ID: <20141021092154.c0tuCska-IjLYq9PVNe3OVXtRsJK9AB-1bABxHRcMRc@z>

commit a5466d7bba9af83a82cc7c081b2a7d557cde3204 upstream.

Commit 08a07904e1828 ("MIPS: math-emu: Remove most ifdefery") removed
the #ifdef ISA conditions and switched to runtime detection. However,
according to the instruction set manual, the cop1x_op instructions are
available in >=MIPS32r2 as well. This fixes a problem on MIPS32r2
with the ntpd package which failed to execute with a SIGILL exit code due
to the fact that a madd.d instruction was not being emulated.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Fixes: 08a07904e1828 ("MIPS: math-emu: Remove most ifdefery")
Cc: linux-mips@linux-mips.org
Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Patchwork: https://patchwork.linux-mips.org/patch/8173/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 arch/mips/math-emu/cp1emu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 7a4727795a70..51a0fde4bec1 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -1023,7 +1023,7 @@ emul:
 					goto emul;

 				case cop1x_op:
-					if (cpu_has_mips_4_5 || cpu_has_mips64)
+					if (cpu_has_mips_4_5 || cpu_has_mips64 || cpu_has_mips32r2)
 						/* its one of ours */
 						goto emul;

@@ -1068,7 +1068,7 @@ emul:
 		break;

 	case cop1x_op:
-		if (!cpu_has_mips_4_5 && !cpu_has_mips64)
+		if (!cpu_has_mips_4_5 && !cpu_has_mips64 && !cpu_has_mips32r2)
 			return SIGILL;

 		sig = fpux_emu(xcp, ctx, ir, fault_addr);
--
2.1.0
