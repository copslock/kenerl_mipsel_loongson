Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Nov 2015 01:48:58 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:50688 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013482AbbKMAsXCcnQl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Nov 2015 01:48:23 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 931AE96B3D7CF;
        Fri, 13 Nov 2015 00:48:12 +0000 (GMT)
Received: from [10.100.200.62] (10.100.200.62) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server id 14.3.235.1; Fri, 13 Nov 2015
 00:48:16 +0000
Date:   Fri, 13 Nov 2015 00:48:15 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/8] MIPS: Determine the presence of IEEE Std 754-2008
 features
In-Reply-To: <alpine.DEB.2.00.1511111418430.7097@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1511130006310.7097@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1511111418430.7097@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.62]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49916
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

Determine the presence of and the amount of control available over IEEE 
Std 754-2008 features.

In the case of a hardware FPU being used examine the FIR register for 
the presence of the HAS2008 bit and then the FCSR register for the 
writability of the ABS2008 and NAN2008 bits and the hardwired state of 
each of these bits if read-only.  Update the initial FCSR contents used 
for threads and the FCSR writability mask accordingly.

For full FPU emulation and MIPS32 or MIPS64 processors make the FCSR 
ABS2008 and NAN2008 bits writable.

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
---
linux-mips-cpu-nan2008.diff
Index: linux-sfr-test/arch/mips/kernel/cpu-probe.c
===================================================================
--- linux-sfr-test.orig/arch/mips/kernel/cpu-probe.c	2015-09-04 21:35:56.582838000 +0100
+++ linux-sfr-test/arch/mips/kernel/cpu-probe.c	2015-09-04 21:36:39.738114000 +0100
@@ -99,6 +99,78 @@ static inline void cpu_set_fpu_fcsr_mask
 }
 
 /*
+ * Determine the IEEE 754 NaN encodings and ABS.fmt/NEG.fmt execution modes
+ * supported by FPU hardware.
+ */
+static void cpu_set_fpu_2008(struct cpuinfo_mips *c)
+{
+	if (c->isa_level & (MIPS_CPU_ISA_M32R1 | MIPS_CPU_ISA_M64R1 |
+			    MIPS_CPU_ISA_M32R2 | MIPS_CPU_ISA_M64R2 |
+			    MIPS_CPU_ISA_M32R6 | MIPS_CPU_ISA_M64R6)) {
+		unsigned long sr, fir, fcsr, fcsr0, fcsr1;
+
+		sr = read_c0_status();
+		__enable_fpu(FPU_AS_IS);
+
+		fir = read_32bit_cp1_register(CP1_REVISION);
+		if (fir & MIPS_FPIR_HAS2008) {
+			fcsr = read_32bit_cp1_register(CP1_STATUS);
+
+			fcsr0 = fcsr & ~(FPU_CSR_ABS2008 | FPU_CSR_NAN2008);
+			write_32bit_cp1_register(CP1_STATUS, fcsr0);
+			fcsr0 = read_32bit_cp1_register(CP1_STATUS);
+
+			fcsr1 = fcsr | FPU_CSR_ABS2008 | FPU_CSR_NAN2008;
+			write_32bit_cp1_register(CP1_STATUS, fcsr1);
+			fcsr1 = read_32bit_cp1_register(CP1_STATUS);
+
+			write_32bit_cp1_register(CP1_STATUS, fcsr);
+
+			if (!(fcsr0 & FPU_CSR_NAN2008))
+				c->options |= MIPS_CPU_NAN_LEGACY;
+			if (fcsr1 & FPU_CSR_NAN2008)
+				c->options |= MIPS_CPU_NAN_2008;
+
+			if ((fcsr0 ^ fcsr1) & FPU_CSR_ABS2008)
+				c->fpu_msk31 &= ~FPU_CSR_ABS2008;
+			else
+				c->fpu_csr31 |= fcsr & FPU_CSR_ABS2008;
+
+			if ((fcsr0 ^ fcsr1) & FPU_CSR_NAN2008)
+				c->fpu_msk31 &= ~FPU_CSR_NAN2008;
+			else
+				c->fpu_csr31 |= fcsr & FPU_CSR_NAN2008;
+		} else {
+			c->options |= MIPS_CPU_NAN_LEGACY;
+		}
+
+		write_c0_status(sr);
+	} else {
+		c->options |= MIPS_CPU_NAN_LEGACY;
+	}
+}
+
+/*
+ * Set the IEEE 754 NaN encodings and ABS.fmt/NEG.fmt execution modes
+ * for the FPU emulator.  Clear the flags where required in case called
+ * from `fpu_disable', to override details obtained from FPU hardware.
+ */
+static void cpu_set_nofpu_2008(struct cpuinfo_mips *c)
+{
+	c->fpu_csr31 &= ~(FPU_CSR_ABS2008 | FPU_CSR_NAN2008);
+	if (c->isa_level & (MIPS_CPU_ISA_M32R1 | MIPS_CPU_ISA_M64R1 |
+			    MIPS_CPU_ISA_M32R2 | MIPS_CPU_ISA_M64R2 |
+			    MIPS_CPU_ISA_M32R6 | MIPS_CPU_ISA_M64R6)) {
+		c->options |= MIPS_CPU_NAN_2008 | MIPS_CPU_NAN_LEGACY;
+		c->fpu_msk31 &= ~(FPU_CSR_ABS2008 | FPU_CSR_NAN2008);
+	} else {
+		c->options &= ~MIPS_CPU_NAN_2008;
+		c->options |= MIPS_CPU_NAN_LEGACY;
+		c->fpu_msk31 |= FPU_CSR_ABS2008 | FPU_CSR_NAN2008;
+	}
+}
+
+/*
  * Set the FIR feature flags for the FPU emulator.
  */
 static void cpu_set_nofpu_id(struct cpuinfo_mips *c)
@@ -139,7 +211,7 @@ static void cpu_set_fpu_opts(struct cpui
 	}
 
 	cpu_set_fpu_fcsr_mask(c);
-	c->options |= MIPS_CPU_NAN_LEGACY;
+	cpu_set_fpu_2008(c);
 }
 
 /*
@@ -150,7 +222,7 @@ static void cpu_set_nofpu_opts(struct cp
 	c->options &= ~MIPS_CPU_FPU;
 	c->fpu_msk31 = mips_nofpu_msk31;
 
-	c->options |= MIPS_CPU_NAN_LEGACY;
+	cpu_set_nofpu_2008(c);
 	cpu_set_nofpu_id(c);
 }
 
