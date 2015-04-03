Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:37:40 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025316AbbDCW1yMhp6F (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:27:54 +0200
Date:   Fri, 3 Apr 2015 23:27:54 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 48/48] MIPS: Factor out FPU feature probing
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504032259490.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46765
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

Factor out FPU feature probing, mainly to remove code duplication from 
`fpu_disable'.  No functional change although shuffle some code to avoid 
forward references.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-fpu-probe.diff
Index: linux/arch/mips/kernel/cpu-probe.c
===================================================================
--- linux.orig/arch/mips/kernel/cpu-probe.c	2015-04-02 20:27:59.750245000 +0100
+++ linux/arch/mips/kernel/cpu-probe.c	2015-04-02 20:28:00.091243000 +0100
@@ -33,6 +33,41 @@
 #include <asm/uaccess.h>
 
 /*
+ * Get the FPU Implementation/Revision.
+ */
+static inline unsigned long cpu_get_fpu_id(void)
+{
+	unsigned long tmp, fpu_id;
+
+	tmp = read_c0_status();
+	__enable_fpu(FPU_AS_IS);
+	fpu_id = read_32bit_cp1_register(CP1_REVISION);
+	write_c0_status(tmp);
+	return fpu_id;
+}
+
+/*
+ * Check if the CPU has an external FPU.
+ */
+static inline int __cpu_has_fpu(void)
+{
+	return (cpu_get_fpu_id() & FPIR_IMP_MASK) != FPIR_IMP_NONE;
+}
+
+static inline unsigned long cpu_get_msa_id(void)
+{
+	unsigned long status, msa_id;
+
+	status = read_c0_status();
+	__enable_fpu(FPU_64BIT);
+	enable_msa();
+	msa_id = read_msa_ir();
+	disable_msa();
+	write_c0_status(status);
+	return msa_id;
+}
+
+/*
  * Determine the FCSR mask for FPU hardware.
  */
 static inline void cpu_set_fpu_fcsr_mask(struct cpuinfo_mips *c)
@@ -82,13 +117,42 @@ static void cpu_set_nofpu_id(struct cpui
 /* Determined FPU emulator mask to use for the boot CPU with "nofpu".  */
 static unsigned int mips_nofpu_msk31;
 
+/*
+ * Set options for FPU hardware.
+ */
+static void cpu_set_fpu_opts(struct cpuinfo_mips *c)
+{
+	c->fpu_id = cpu_get_fpu_id();
+	mips_nofpu_msk31 = c->fpu_msk31;
+
+	if (c->isa_level & (MIPS_CPU_ISA_M32R1 | MIPS_CPU_ISA_M64R1 |
+			    MIPS_CPU_ISA_M32R2 | MIPS_CPU_ISA_M64R2 |
+			    MIPS_CPU_ISA_M32R6 | MIPS_CPU_ISA_M64R6)) {
+		if (c->fpu_id & MIPS_FPIR_3D)
+			c->ases |= MIPS_ASE_MIPS3D;
+		if (c->fpu_id & MIPS_FPIR_FREP)
+			c->options |= MIPS_CPU_FRE;
+	}
+
+	cpu_set_fpu_fcsr_mask(c);
+}
+
+/*
+ * Set options for the FPU emulator.
+ */
+static void cpu_set_nofpu_opts(struct cpuinfo_mips *c)
+{
+	c->options &= ~MIPS_CPU_FPU;
+	c->fpu_msk31 = mips_nofpu_msk31;
+
+	cpu_set_nofpu_id(c);
+}
+
 static int mips_fpu_disabled;
 
 static int __init fpu_disable(char *s)
 {
-	boot_cpu_data.options &= ~MIPS_CPU_FPU;
-	boot_cpu_data.fpu_msk31 = mips_nofpu_msk31;
-	cpu_set_nofpu_id(&boot_cpu_data);
+	cpu_set_nofpu_opts(&boot_cpu_data);
 	mips_fpu_disabled = 1;
 
 	return 1;
@@ -231,41 +295,6 @@ static inline void set_elf_platform(int 
 		__elf_platform = plat;
 }
 
-/*
- * Get the FPU Implementation/Revision.
- */
-static inline unsigned long cpu_get_fpu_id(void)
-{
-	unsigned long tmp, fpu_id;
-
-	tmp = read_c0_status();
-	__enable_fpu(FPU_AS_IS);
-	fpu_id = read_32bit_cp1_register(CP1_REVISION);
-	write_c0_status(tmp);
-	return fpu_id;
-}
-
-/*
- * Check if the CPU has an external FPU.
- */
-static inline int __cpu_has_fpu(void)
-{
-	return (cpu_get_fpu_id() & FPIR_IMP_MASK) != FPIR_IMP_NONE;
-}
-
-static inline unsigned long cpu_get_msa_id(void)
-{
-	unsigned long status, msa_id;
-
-	status = read_c0_status();
-	__enable_fpu(FPU_64BIT);
-	enable_msa();
-	msa_id = read_msa_ir();
-	disable_msa();
-	write_c0_status(status);
-	return msa_id;
-}
-
 static inline void cpu_probe_vmbits(struct cpuinfo_mips *c)
 {
 #ifdef __NEED_VMBITS_PROBE
@@ -1434,22 +1463,10 @@ void cpu_probe(void)
 			       ~(1 << MIPS_PWCTL_PWEN_SHIFT));
 	}
 
-	if (c->options & MIPS_CPU_FPU) {
-		c->fpu_id = cpu_get_fpu_id();
-		mips_nofpu_msk31 = c->fpu_msk31;
-
-		if (c->isa_level & (MIPS_CPU_ISA_M32R1 | MIPS_CPU_ISA_M64R1 |
-				    MIPS_CPU_ISA_M32R2 | MIPS_CPU_ISA_M64R2 |
-				    MIPS_CPU_ISA_M32R6 | MIPS_CPU_ISA_M64R6)) {
-			if (c->fpu_id & MIPS_FPIR_3D)
-				c->ases |= MIPS_ASE_MIPS3D;
-			if (c->fpu_id & MIPS_FPIR_FREP)
-				c->options |= MIPS_CPU_FRE;
-		}
-
-		cpu_set_fpu_fcsr_mask(c);
-	} else
-		cpu_set_nofpu_id(c);
+	if (c->options & MIPS_CPU_FPU)
+		cpu_set_fpu_opts(c);
+	else
+		cpu_set_nofpu_opts(c);
 
 	if (cpu_has_mips_r2_r6) {
 		c->srsets = ((read_c0_srsctl() >> 26) & 0x0f) + 1;
