Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Nov 2015 01:49:19 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:13662 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013532AbbKMAshQVn4l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Nov 2015 01:48:37 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 9652FEAAA8B29;
        Fri, 13 Nov 2015 00:48:26 +0000 (GMT)
Received: from [10.100.200.62] (10.100.200.62) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server id 14.3.235.1; Fri, 13 Nov 2015
 00:48:29 +0000
Date:   Fri, 13 Nov 2015 00:48:29 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 8/8] MIPS: Add IEEE Std 754 conformance mode selection
In-Reply-To: <alpine.DEB.2.00.1511111418430.7097@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1511130006370.7097@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1511111418430.7097@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.62]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49917
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

Add an `ieee754=' kernel parameter to control IEEE Std 754 conformance 
mode.

Use separate flags copied from the respective CPU feature flags, and 
adjusted according to the conformance mode selected, to make binaries 
requesting individual NaN encoding modes accepted or rejected as needed.  
Update the initial setting for FCSR and, in the full FPU emulation mode, 
its read-only mask accordingly.  Accept the mode selection requested for 
legacy processors as well.

As with the EF_MIPS_NAN2008 ELF file header flag adjust both ABS2008 and
NAN2008 bits at the same time, to match the choice made for hardware 
currently implemented.

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
---
linux-mips-arg-ieee754.diff
Index: linux-sfr-test/Documentation/kernel-parameters.txt
===================================================================
--- linux-sfr-test.orig/Documentation/kernel-parameters.txt	2015-11-10 17:45:24.154444000 +0000
+++ linux-sfr-test/Documentation/kernel-parameters.txt	2015-11-11 02:20:23.310234000 +0000
@@ -1399,6 +1399,41 @@ bytes respectively. Such letter suffixes
 			In such case C2/C3 won't be used again.
 			idle=nomwait: Disable mwait for CPU C-states
 
+	ieee754=	[MIPS] Select IEEE Std 754 conformance mode
+			Format: { strict | legacy | 2008 | relaxed }
+			Default: strict
+
+			Choose which programs will be accepted for execution
+			based on the IEEE 754 NaN encoding(s) supported by
+			the FPU and the NaN encoding requested with the value
+			of an ELF file header flag individually set by each
+			binary.  Hardware implementations are permitted to
+			support either or both of the legacy and the 2008 NaN
+			encoding mode.
+
+			Available settings are as follows:
+			strict	accept binaries that request a NaN encoding
+				supported by the FPU
+			legacy	only accept legacy-NaN binaries, if supported
+				by the FPU
+			2008	only accept 2008-NaN binaries, if supported
+				by the FPU
+			relaxed	accept any binaries regardless of whether
+				supported by the FPU
+
+			The FPU emulator is always able to support both NaN
+			encodings, so if no FPU hardware is present or it has
+			been disabled with 'nofpu', then the settings of
+			'legacy' and '2008' strap the emulator accordingly,
+			'relaxed' straps the emulator for both legacy-NaN and
+			2008-NaN, whereas 'strict' enables legacy-NaN only on
+			legacy processors and both NaN encodings on MIPS32 or
+			MIPS64 CPUs.
+
+			The setting for ABS.fmt/NEG.fmt instruction execution
+			mode generally follows that for the NaN encoding,
+			except where unsupported by hardware.
+
 	ignore_loglevel	[KNL]
 			Ignore loglevel setting - this will print /all/
 			kernel messages to the console. Useful for debugging.
Index: linux-sfr-test/arch/mips/include/asm/elf.h
===================================================================
--- linux-sfr-test.orig/arch/mips/include/asm/elf.h	2015-11-11 02:20:16.030180000 +0000
+++ linux-sfr-test/arch/mips/include/asm/elf.h	2015-11-11 02:20:23.314234000 +0000
@@ -447,6 +447,10 @@ struct arch_elf_state {
 	.overall_fp_mode = -1,			\
 }
 
+/* Whether to accept legacy-NaN and 2008-NaN user binaries.  */
+extern bool mips_use_nan_legacy;
+extern bool mips_use_nan_2008;
+
 extern int arch_elf_pt_proc(void *ehdr, void *phdr, struct file *elf,
 			    bool is_interp, struct arch_elf_state *state);
 
Index: linux-sfr-test/arch/mips/kernel/cpu-probe.c
===================================================================
--- linux-sfr-test.orig/arch/mips/kernel/cpu-probe.c	2015-11-11 02:20:21.488222000 +0000
+++ linux-sfr-test/arch/mips/kernel/cpu-probe.c	2015-11-11 02:20:23.317237000 +0000
@@ -151,26 +151,109 @@ static void cpu_set_fpu_2008(struct cpui
 }
 
 /*
- * Set the IEEE 754 NaN encodings and ABS.fmt/NEG.fmt execution modes
- * for the FPU emulator.  Clear the flags where required in case called
- * from `fpu_disable', to override details obtained from FPU hardware.
+ * IEEE 754 conformance mode to use.  Affects the NaN encoding and the
+ * ABS.fmt/NEG.fmt execution mode.
+ */
+static enum { STRICT, LEGACY, STD2008, RELAXED } ieee754 = STRICT;
+
+/*
+ * Set the IEEE 754 NaN encodings and the ABS.fmt/NEG.fmt execution modes
+ * to support by the FPU emulator according to the IEEE 754 conformance
+ * mode selected.  Note that "relaxed" straps the emulator so that it
+ * allows 2008-NaN binaries even for legacy processors.
  */
 static void cpu_set_nofpu_2008(struct cpuinfo_mips *c)
 {
+	c->options &= ~(MIPS_CPU_NAN_2008 | MIPS_CPU_NAN_LEGACY);
 	c->fpu_csr31 &= ~(FPU_CSR_ABS2008 | FPU_CSR_NAN2008);
-	if (c->isa_level & (MIPS_CPU_ISA_M32R1 | MIPS_CPU_ISA_M64R1 |
-			    MIPS_CPU_ISA_M32R2 | MIPS_CPU_ISA_M64R2 |
-			    MIPS_CPU_ISA_M32R6 | MIPS_CPU_ISA_M64R6)) {
-		c->options |= MIPS_CPU_NAN_2008 | MIPS_CPU_NAN_LEGACY;
-		c->fpu_msk31 &= ~(FPU_CSR_ABS2008 | FPU_CSR_NAN2008);
-	} else {
-		c->options &= ~MIPS_CPU_NAN_2008;
+	c->fpu_msk31 &= ~(FPU_CSR_ABS2008 | FPU_CSR_NAN2008);
+
+	switch (ieee754) {
+	case STRICT:
+		if (c->isa_level & (MIPS_CPU_ISA_M32R1 | MIPS_CPU_ISA_M64R1 |
+				    MIPS_CPU_ISA_M32R2 | MIPS_CPU_ISA_M64R2 |
+				    MIPS_CPU_ISA_M32R6 | MIPS_CPU_ISA_M64R6)) {
+			c->options |= MIPS_CPU_NAN_2008 | MIPS_CPU_NAN_LEGACY;
+		} else {
+			c->options |= MIPS_CPU_NAN_LEGACY;
+			c->fpu_msk31 |= FPU_CSR_ABS2008 | FPU_CSR_NAN2008;
+		}
+		break;
+	case LEGACY:
 		c->options |= MIPS_CPU_NAN_LEGACY;
 		c->fpu_msk31 |= FPU_CSR_ABS2008 | FPU_CSR_NAN2008;
+		break;
+	case STD2008:
+		c->options |= MIPS_CPU_NAN_2008;
+		c->fpu_csr31 |= FPU_CSR_ABS2008 | FPU_CSR_NAN2008;
+		c->fpu_msk31 |= FPU_CSR_ABS2008 | FPU_CSR_NAN2008;
+		break;
+	case RELAXED:
+		c->options |= MIPS_CPU_NAN_2008 | MIPS_CPU_NAN_LEGACY;
+		break;
 	}
 }
 
 /*
+ * Override the IEEE 754 NaN encoding and ABS.fmt/NEG.fmt execution mode
+ * according to the "ieee754=" parameter.
+ */
+static void cpu_set_nan_2008(struct cpuinfo_mips *c)
+{
+	switch (ieee754) {
+	case STRICT:
+		mips_use_nan_legacy = !!cpu_has_nan_legacy;
+		mips_use_nan_2008 = !!cpu_has_nan_2008;
+		break;
+	case LEGACY:
+		mips_use_nan_legacy = !!cpu_has_nan_legacy;
+		mips_use_nan_2008 = !cpu_has_nan_legacy;
+		break;
+	case STD2008:
+		mips_use_nan_legacy = !cpu_has_nan_2008;
+		mips_use_nan_2008 = !!cpu_has_nan_2008;
+		break;
+	case RELAXED:
+		mips_use_nan_legacy = true;
+		mips_use_nan_2008 = true;
+		break;
+	}
+}
+
+/*
+ * IEEE 754 NaN encoding and ABS.fmt/NEG.fmt execution mode override
+ * settings:
+ *
+ * strict:  accept binaries that request a NaN encoding supported by the FPU
+ * legacy:  only accept legacy-NaN binaries
+ * 2008:    only accept 2008-NaN binaries
+ * relaxed: accept any binaries regardless of whether supported by the FPU
+ */
+static int __init ieee754_setup(char *s)
+{
+	if (!s)
+		return -1;
+	else if (!strcmp(s, "strict"))
+		ieee754 = STRICT;
+	else if (!strcmp(s, "legacy"))
+		ieee754 = LEGACY;
+	else if (!strcmp(s, "2008"))
+		ieee754 = STD2008;
+	else if (!strcmp(s, "relaxed"))
+		ieee754 = RELAXED;
+	else
+		return -1;
+
+	if (!(boot_cpu_data.options & MIPS_CPU_FPU))
+		cpu_set_nofpu_2008(&boot_cpu_data);
+	cpu_set_nan_2008(&boot_cpu_data);
+
+	return 0;
+}
+
+early_param("ieee754", ieee754_setup);
+
+/*
  * Set the FIR feature flags for the FPU emulator.
  */
 static void cpu_set_nofpu_id(struct cpuinfo_mips *c)
@@ -212,6 +295,7 @@ static void cpu_set_fpu_opts(struct cpui
 
 	cpu_set_fpu_fcsr_mask(c);
 	cpu_set_fpu_2008(c);
+	cpu_set_nan_2008(c);
 }
 
 /*
@@ -223,6 +307,7 @@ static void cpu_set_nofpu_opts(struct cp
 	c->fpu_msk31 = mips_nofpu_msk31;
 
 	cpu_set_nofpu_2008(c);
+	cpu_set_nan_2008(c);
 	cpu_set_nofpu_id(c);
 }
 
Index: linux-sfr-test/arch/mips/kernel/elf.c
===================================================================
--- linux-sfr-test.orig/arch/mips/kernel/elf.c	2015-11-11 02:20:16.033179000 +0000
+++ linux-sfr-test/arch/mips/kernel/elf.c	2015-11-11 02:20:23.319243000 +0000
@@ -13,6 +13,10 @@
 
 #include <asm/cpu-info.h>
 
+/* Whether to accept legacy-NaN and 2008-NaN user binaries.  */
+bool mips_use_nan_legacy;
+bool mips_use_nan_2008;
+
 /* FPU modes */
 enum {
 	FP_FRE,
@@ -150,16 +154,16 @@ int arch_check_elf(void *_ehdr, bool has
 	flags = elf32 ? ehdr->e32.e_flags : ehdr->e64.e_flags;
 
 	/*
-	 * Determine the NaN personality, reject the binary if no hardware
-	 * support.  Also ensure that any interpreter matches the executable.
+	 * Determine the NaN personality, reject the binary if not allowed.
+	 * Also ensure that any interpreter matches the executable.
 	 */
 	if (flags & EF_MIPS_NAN2008) {
-		if (cpu_has_nan_2008)
+		if (mips_use_nan_2008)
 			state->nan_2008 = 1;
 		else
 			return -ENOEXEC;
 	} else {
-		if (cpu_has_nan_legacy)
+		if (mips_use_nan_legacy)
 			state->nan_2008 = 0;
 		else
 			return -ENOEXEC;
