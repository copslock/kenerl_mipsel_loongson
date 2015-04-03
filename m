Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:36:06 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025308AbbDCW10PH-af (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:27:26 +0200
Date:   Fri, 3 Apr 2015 23:27:26 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 43/48] MIPS: math-emu: Set FIR feature flags for full
 emulation
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504032103180.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46760
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

Implement FIR feature flags in the FPU emulator according to features 
supported and architecture level requirements.  The W, L and F64 bits 
have only been added at level #2 even though the features they refer to 
were also included with the MIPS64r1 ISA and the W fixed-point format 
also with the MIPS32r1 ISA.

This is only relevant for the full emulation mode and the emulated CFC1 
instruction as well as ptrace(2) accesses.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-emu-fir.diff
Index: linux/arch/mips/kernel/cpu-probe.c
===================================================================
--- linux.orig/arch/mips/kernel/cpu-probe.c	2015-04-02 20:27:58.700229000 +0100
+++ linux/arch/mips/kernel/cpu-probe.c	2015-04-02 20:27:58.890231000 +0100
@@ -20,6 +20,7 @@
 
 #include <asm/bugs.h>
 #include <asm/cpu.h>
+#include <asm/cpu-features.h>
 #include <asm/cpu-type.h>
 #include <asm/fpu.h>
 #include <asm/mipsregs.h>
@@ -31,11 +32,30 @@
 #include <asm/spram.h>
 #include <asm/uaccess.h>
 
+/*
+ * Set the FIR feature flags for the FPU emulator.
+ */
+static void cpu_set_nofpu_id(struct cpuinfo_mips *c)
+{
+	u32 value;
+
+	value = 0;
+	if (c->isa_level & (MIPS_CPU_ISA_M32R1 | MIPS_CPU_ISA_M64R1 |
+			    MIPS_CPU_ISA_M32R2 | MIPS_CPU_ISA_M64R2 |
+			    MIPS_CPU_ISA_M32R6 | MIPS_CPU_ISA_M64R6))
+		value |= MIPS_FPIR_D | MIPS_FPIR_S;
+	if (c->isa_level & (MIPS_CPU_ISA_M32R2 | MIPS_CPU_ISA_M64R2 |
+			    MIPS_CPU_ISA_M32R6 | MIPS_CPU_ISA_M64R6))
+		value |= MIPS_FPIR_F64 | MIPS_FPIR_L | MIPS_FPIR_W;
+	c->fpu_id = value;
+}
+
 static int mips_fpu_disabled;
 
 static int __init fpu_disable(char *s)
 {
-	cpu_data[0].options &= ~MIPS_CPU_FPU;
+	boot_cpu_data.options &= ~MIPS_CPU_FPU;
+	cpu_set_nofpu_id(&boot_cpu_data);
 	mips_fpu_disabled = 1;
 
 	return 1;
@@ -1375,7 +1395,8 @@ void cpu_probe(void)
 			if (c->fpu_id & MIPS_FPIR_FREP)
 				c->options |= MIPS_CPU_FRE;
 		}
-	}
+	} else
+		cpu_set_nofpu_id(c);
 
 	if (cpu_has_mips_r2_r6) {
 		c->srsets = ((read_c0_srsctl() >> 26) & 0x0f) + 1;
Index: linux/arch/mips/math-emu/cp1emu.c
===================================================================
--- linux.orig/arch/mips/math-emu/cp1emu.c	2015-04-02 20:27:57.710224000 +0100
+++ linux/arch/mips/math-emu/cp1emu.c	2015-04-02 20:27:58.894230000 +0100
@@ -45,6 +45,7 @@
 #include <asm/signal.h>
 #include <asm/uaccess.h>
 
+#include <asm/cpu-info.h>
 #include <asm/processor.h>
 #include <asm/fpu_emulator.h>
 #include <asm/fpu.h>
@@ -853,7 +854,7 @@ static inline void cop1_cfc(struct pt_re
 			 (void *)xcp->cp0_epc,
 			 MIPSInst_RT(ir), value);
 	} else if (MIPSInst_RD(ir) == FPCREG_RID)
-		value = 0;
+		value = current_cpu_data.fpu_id;
 	else
 		value = 0;
 	if (MIPSInst_RT(ir))
