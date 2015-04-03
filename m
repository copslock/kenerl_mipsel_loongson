Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:34:04 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025257AbbDCW0t0Iiqu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:26:49 +0200
Date:   Fri, 3 Apr 2015 23:26:49 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 36/48] MIPS: Correct FP ISA requirements
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504031719470.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46753
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Correct ISA requirements for floating-point instructions:

* the CU3 exception signifies a real COP3 instruction in MIPS I & II,

* the BC1FL and BC1TL instructions are not supported in MIPS I,

* the SQRT.fmt instructions are indeed supported in MIPS II,

* the LDC1 and SDC1 instructions are indeed supported in MIPS32r1,

* the CEIL.W.fmt, FLOOR.W.fmt, ROUND.W.fmt and TRUNC.W.fmt instructions 
  are indeed supported in MIPS32,

* the CVT.L.fmt and CVT.fmt.L instructions are indeed supported in 
  MIPS32r2 and MIPS32r6,

* the CEIL.L.fmt, FLOOR.L.fmt, ROUND.L.fmt and TRUNC.L.fmt instructions 
  are indeed supported in MIPS32r2 and MIPS32r6,

* the RSQRT.fmt and RECIP.fmt instructions are indeed supported in 
  MIPS64r1,

Also simplify conditionals for MIPS III and MIPS IV FPU instructions and 
the handling of the MOVCI minor opcode.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-emu-isa.diff
Index: linux/arch/mips/include/asm/cpu-features.h
===================================================================
--- linux.orig/arch/mips/include/asm/cpu-features.h	2015-04-02 20:27:56.252205000 +0100
+++ linux/arch/mips/include/asm/cpu-features.h	2015-04-02 20:27:57.478232000 +0100
@@ -221,8 +221,11 @@
 #define cpu_has_mips_4_5_r	(cpu_has_mips_4 | cpu_has_mips_5_r)
 #define cpu_has_mips_5_r	(cpu_has_mips_5 | cpu_has_mips_r)
 
-#define cpu_has_mips_4_5_r2_r6	(cpu_has_mips_4_5 | cpu_has_mips_r2 | \
-				 cpu_has_mips_r6)
+#define cpu_has_mips_3_4_5_64_r2_r6					\
+				(cpu_has_mips_3 | cpu_has_mips_4_5_64_r2_r6)
+#define cpu_has_mips_4_5_64_r2_r6					\
+				(cpu_has_mips_4_5 | cpu_has_mips64r1 |	\
+				 cpu_has_mips_r2 | cpu_has_mips_r6)
 
 #define cpu_has_mips32	(cpu_has_mips32r1 | cpu_has_mips32r2 | cpu_has_mips32r6)
 #define cpu_has_mips64	(cpu_has_mips64r1 | cpu_has_mips64r2 | cpu_has_mips64r6)
Index: linux/arch/mips/kernel/traps.c
===================================================================
--- linux.orig/arch/mips/kernel/traps.c	2015-04-02 20:27:56.948213000 +0100
+++ linux/arch/mips/kernel/traps.c	2015-04-02 20:27:57.489216000 +0100
@@ -1349,19 +1349,18 @@ asmlinkage void do_cpu(struct pt_regs *r
 
 	case 3:
 		/*
-		 * Old (MIPS I and MIPS II) processors will set this code
-		 * for COP1X opcode instructions that replaced the original
-		 * COP3 space.	We don't limit COP1 space instructions in
-		 * the emulator according to the CPU ISA, so we want to
-		 * treat COP1X instructions consistently regardless of which
-		 * code the CPU chose.	Therefore we redirect this trap to
-		 * the FP emulator too.
-		 *
-		 * Then some newer FPU-less processors use this code
-		 * erroneously too, so they are covered by this choice
-		 * as well.
+		 * The COP3 opcode space and consequently the CP0.Status.CU3
+		 * bit and the CP0.Cause.CE=3 encoding have been removed as
+		 * of the MIPS III ISA.  From the MIPS IV and MIPS32r2 ISAs
+		 * up the space has been reused for COP1X instructions, that
+		 * are enabled by the CP0.Status.CU1 bit and consequently
+		 * use the CP0.Cause.CE=1 encoding for Coprocessor Unusable
+		 * exceptions.  Some FPU-less processors that implement one
+		 * of these ISAs however use this code erroneously for COP1X
+		 * instructions.  Therefore we redirect this trap to the FP
+		 * emulator too.
 		 */
-		if (raw_cpu_has_fpu) {
+		if (raw_cpu_has_fpu || !cpu_has_mips_4_5_64_r2_r6) {
 			force_sig(SIGILL, current);
 			break;
 		}
Index: linux/arch/mips/math-emu/cp1emu.c
===================================================================
--- linux.orig/arch/mips/math-emu/cp1emu.c	2015-04-02 20:27:54.459192000 +0100
+++ linux/arch/mips/math-emu/cp1emu.c	2015-04-02 20:27:57.493218000 +0100
@@ -1115,17 +1115,18 @@ static int cop1Emulate(struct pt_regs *x
 			likely = 0;
 			switch (MIPSInst_RT(ir) & 3) {
 			case bcfl_op:
-				likely = 1;
+				if (cpu_has_mips_2_3_4_5_r)
+					likely = 1;
+				/* Fall through */
 			case bcf_op:
 				cond = !cond;
 				break;
 			case bctl_op:
-				likely = 1;
+				if (cpu_has_mips_2_3_4_5_r)
+					likely = 1;
+				/* Fall through */
 			case bct_op:
 				break;
-			default:
-				/* thats an illegal instruction */
-				return SIGILL;
 			}
 
 			set_delay_slot(xcp);
@@ -1165,36 +1166,34 @@ static int cop1Emulate(struct pt_regs *x
 
 				switch (MIPSInst_OPCODE(ir)) {
 				case lwc1_op:
-					goto emul;
-
 				case swc1_op:
 					goto emul;
 
 				case ldc1_op:
 				case sdc1_op:
-					if (cpu_has_mips_2_3_4_5 ||
-					    cpu_has_mips64)
+					if (cpu_has_mips_2_3_4_5_r)
 						goto emul;
 
 					return SIGILL;
-					goto emul;
 
 				case cop1_op:
 					goto emul;
 
 				case cop1x_op:
-					if (cpu_has_mips_4_5 || cpu_has_mips64 || cpu_has_mips32r2)
+					if (cpu_has_mips_4_5_64_r2_r6)
 						/* its one of ours */
 						goto emul;
 
 					return SIGILL;
 
 				case spec_op:
-					if (!cpu_has_mips_4_5_r)
-						return SIGILL;
+					switch (MIPSInst_FUNC(ir)) {
+					case movc_op:
+						if (cpu_has_mips_4_5_r)
+							goto emul;
 
-					if (MIPSInst_FUNC(ir) == movc_op)
-						goto emul;
+						return SIGILL;
+					}
 					break;
 				}
 
@@ -1228,7 +1227,7 @@ static int cop1Emulate(struct pt_regs *x
 		break;
 
 	case cop1x_op:
-		if (!cpu_has_mips_4_5 && !cpu_has_mips64 && !cpu_has_mips32r2)
+		if (!cpu_has_mips_4_5_64_r2_r6)
 			return SIGILL;
 
 		sig = fpux_emu(xcp, ctx, ir, fault_addr);
@@ -1561,7 +1560,7 @@ static int fpu_emu(struct pt_regs *xcp, 
 
 			/* unary  ops */
 		case fsqrt_op:
-			if (!cpu_has_mips_4_5_r)
+			if (!cpu_has_mips_2_3_4_5_r)
 				return SIGILL;
 
 			handler.u = ieee754sp_sqrt;
@@ -1573,14 +1572,14 @@ static int fpu_emu(struct pt_regs *xcp, 
 		 * achieve full IEEE-754 accuracy - however this emulator does.
 		 */
 		case frsqrt_op:
-			if (!cpu_has_mips_4_5_r2_r6)
+			if (!cpu_has_mips_4_5_64_r2_r6)
 				return SIGILL;
 
 			handler.u = fpemu_sp_rsqrt;
 			goto scopuop;
 
 		case frecip_op:
-			if (!cpu_has_mips_4_5_r2_r6)
+			if (!cpu_has_mips_4_5_64_r2_r6)
 				return SIGILL;
 
 			handler.u = fpemu_sp_recip;
@@ -1682,7 +1681,7 @@ static int fpu_emu(struct pt_regs *xcp, 
 		case ftrunc_op:
 		case fceil_op:
 		case ffloor_op:
-			if (!cpu_has_mips_2_3_4_5 && !cpu_has_mips64)
+			if (!cpu_has_mips_2_3_4_5_r)
 				return SIGILL;
 
 			oldrm = ieee754_csr.rm;
@@ -1694,7 +1693,7 @@ static int fpu_emu(struct pt_regs *xcp, 
 			goto copcsr;
 
 		case fcvtl_op:
-			if (!cpu_has_mips_3_4_5 && !cpu_has_mips64)
+			if (!cpu_has_mips_3_4_5_64_r2_r6)
 				return SIGILL;
 
 			SPFROMREG(fs, MIPSInst_FS(ir));
@@ -1706,7 +1705,7 @@ static int fpu_emu(struct pt_regs *xcp, 
 		case ftruncl_op:
 		case fceill_op:
 		case ffloorl_op:
-			if (!cpu_has_mips_3_4_5 && !cpu_has_mips64)
+			if (!cpu_has_mips_3_4_5_64_r2_r6)
 				return SIGILL;
 
 			oldrm = ieee754_csr.rm;
@@ -1775,13 +1774,13 @@ static int fpu_emu(struct pt_regs *xcp, 
 		 * achieve full IEEE-754 accuracy - however this emulator does.
 		 */
 		case frsqrt_op:
-			if (!cpu_has_mips_4_5_r2_r6)
+			if (!cpu_has_mips_4_5_64_r2_r6)
 				return SIGILL;
 
 			handler.u = fpemu_dp_rsqrt;
 			goto dcopuop;
 		case frecip_op:
-			if (!cpu_has_mips_4_5_r2_r6)
+			if (!cpu_has_mips_4_5_64_r2_r6)
 				return SIGILL;
 
 			handler.u = fpemu_dp_recip;
@@ -1871,7 +1870,7 @@ static int fpu_emu(struct pt_regs *xcp, 
 			goto copcsr;
 
 		case fcvtl_op:
-			if (!cpu_has_mips_3_4_5 && !cpu_has_mips64)
+			if (!cpu_has_mips_3_4_5_64_r2_r6)
 				return SIGILL;
 
 			DPFROMREG(fs, MIPSInst_FS(ir));
@@ -1883,7 +1882,7 @@ static int fpu_emu(struct pt_regs *xcp, 
 		case ftruncl_op:
 		case fceill_op:
 		case ffloorl_op:
-			if (!cpu_has_mips_3_4_5 && !cpu_has_mips64)
+			if (!cpu_has_mips_3_4_5_64_r2_r6)
 				return SIGILL;
 
 			oldrm = ieee754_csr.rm;
@@ -1942,7 +1941,7 @@ static int fpu_emu(struct pt_regs *xcp, 
 
 	case l_fmt:
 
-		if (!cpu_has_mips_3_4_5 && !cpu_has_mips64)
+		if (!cpu_has_mips_3_4_5_64_r2_r6)
 			return SIGILL;
 
 		DIFROMREG(bits, MIPSInst_FS(ir));
@@ -2006,7 +2005,7 @@ static int fpu_emu(struct pt_regs *xcp, 
 		SITOREG(rv.w, MIPSInst_FD(ir));
 		break;
 	case l_fmt:
-		if (!cpu_has_mips_3_4_5 && !cpu_has_mips64)
+		if (!cpu_has_mips_3_4_5_64_r2_r6)
 			return SIGILL;
 
 		DITOREG(rv.l, MIPSInst_FD(ir));
