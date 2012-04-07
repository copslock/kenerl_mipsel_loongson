Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Apr 2012 18:51:35 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:36609 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1904121Ab2DGQtA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 7 Apr 2012 18:49:00 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SGYoo-0004dH-6m; Sat, 07 Apr 2012 11:48:54 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH 06/10] MIPS: Code formatting fixes.
Date:   Sat,  7 Apr 2012 11:48:31 -0500
Message-Id: <1333817315-30091-7-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.6
In-Reply-To: <1333817315-30091-1-git-send-email-sjhill@mips.com>
References: <1333817315-30091-1-git-send-email-sjhill@mips.com>
X-archive-position: 32884
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/kernel/cpu-probe.c |   54 +++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 0fccb8c..7d95e62 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -343,7 +343,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		__cpu_name[cpu] = "R2000";
 		c->isa_level = MIPS_CPU_ISA_I;
 		c->options = MIPS_CPU_TLB | MIPS_CPU_3K_CACHE |
-		             MIPS_CPU_NOFPUEX;
+			     MIPS_CPU_NOFPUEX;
 		if (__cpu_has_fpu())
 			c->options |= MIPS_CPU_FPU;
 		c->tlbsize = 64;
@@ -364,7 +364,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		}
 		c->isa_level = MIPS_CPU_ISA_I;
 		c->options = MIPS_CPU_TLB | MIPS_CPU_3K_CACHE |
-		             MIPS_CPU_NOFPUEX;
+			     MIPS_CPU_NOFPUEX;
 		if (__cpu_has_fpu())
 			c->options |= MIPS_CPU_FPU;
 		c->tlbsize = 64;
@@ -390,8 +390,8 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 
 		c->isa_level = MIPS_CPU_ISA_III;
 		c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_32FPR |
-		             MIPS_CPU_WATCH | MIPS_CPU_VCE |
-		             MIPS_CPU_LLSC;
+			     MIPS_CPU_WATCH | MIPS_CPU_VCE |
+			     MIPS_CPU_LLSC;
 		c->tlbsize = 48;
 		break;
 	case PRID_IMP_VR41XX:
@@ -437,7 +437,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		__cpu_name[cpu] = "R4300";
 		c->isa_level = MIPS_CPU_ISA_III;
 		c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_32FPR |
-		             MIPS_CPU_LLSC;
+			     MIPS_CPU_LLSC;
 		c->tlbsize = 32;
 		break;
 	case PRID_IMP_R4600:
@@ -449,7 +449,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		c->tlbsize = 48;
 		break;
 	#if 0
- 	case PRID_IMP_R4650:
+	case PRID_IMP_R4650:
 		/*
 		 * This processor doesn't have an MMU, so it's not
 		 * "real easy" to run Linux on it. It is left purely
@@ -458,9 +458,9 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		 */
 		c->cputype = CPU_R4650;
 		__cpu_name[cpu] = "R4650";
-	 	c->isa_level = MIPS_CPU_ISA_III;
+		c->isa_level = MIPS_CPU_ISA_III;
 		c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_LLSC;
-	        c->tlbsize = 48;
+		c->tlbsize = 48;
 		break;
 	#endif
 	case PRID_IMP_TX39:
@@ -491,7 +491,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		__cpu_name[cpu] = "R4700";
 		c->isa_level = MIPS_CPU_ISA_III;
 		c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_32FPR |
-		             MIPS_CPU_LLSC;
+			     MIPS_CPU_LLSC;
 		c->tlbsize = 48;
 		break;
 	case PRID_IMP_TX49:
@@ -508,7 +508,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		__cpu_name[cpu] = "R5000";
 		c->isa_level = MIPS_CPU_ISA_IV;
 		c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_32FPR |
-		             MIPS_CPU_LLSC;
+			     MIPS_CPU_LLSC;
 		c->tlbsize = 48;
 		break;
 	case PRID_IMP_R5432:
@@ -516,7 +516,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		__cpu_name[cpu] = "R5432";
 		c->isa_level = MIPS_CPU_ISA_IV;
 		c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_32FPR |
-		             MIPS_CPU_WATCH | MIPS_CPU_LLSC;
+			     MIPS_CPU_WATCH | MIPS_CPU_LLSC;
 		c->tlbsize = 48;
 		break;
 	case PRID_IMP_R5500:
@@ -524,7 +524,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		__cpu_name[cpu] = "R5500";
 		c->isa_level = MIPS_CPU_ISA_IV;
 		c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_32FPR |
-		             MIPS_CPU_WATCH | MIPS_CPU_LLSC;
+			     MIPS_CPU_WATCH | MIPS_CPU_LLSC;
 		c->tlbsize = 48;
 		break;
 	case PRID_IMP_NEVADA:
@@ -532,7 +532,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		__cpu_name[cpu] = "Nevada";
 		c->isa_level = MIPS_CPU_ISA_IV;
 		c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_32FPR |
-		             MIPS_CPU_DIVEC | MIPS_CPU_LLSC;
+			     MIPS_CPU_DIVEC | MIPS_CPU_LLSC;
 		c->tlbsize = 48;
 		break;
 	case PRID_IMP_R6000:
@@ -540,7 +540,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		__cpu_name[cpu] = "R6000";
 		c->isa_level = MIPS_CPU_ISA_II;
 		c->options = MIPS_CPU_TLB | MIPS_CPU_FPU |
-		             MIPS_CPU_LLSC;
+			     MIPS_CPU_LLSC;
 		c->tlbsize = 32;
 		break;
 	case PRID_IMP_R6000A:
@@ -548,7 +548,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		__cpu_name[cpu] = "R6000A";
 		c->isa_level = MIPS_CPU_ISA_II;
 		c->options = MIPS_CPU_TLB | MIPS_CPU_FPU |
-		             MIPS_CPU_LLSC;
+			     MIPS_CPU_LLSC;
 		c->tlbsize = 32;
 		break;
 	case PRID_IMP_RM7000:
@@ -556,7 +556,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		__cpu_name[cpu] = "RM7000";
 		c->isa_level = MIPS_CPU_ISA_IV;
 		c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_32FPR |
-		             MIPS_CPU_LLSC;
+			     MIPS_CPU_LLSC;
 		/*
 		 * Undocumented RM7000:  Bit 29 in the info register of
 		 * the RM7000 v2.0 indicates if the TLB has 48 or 64
@@ -572,7 +572,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		__cpu_name[cpu] = "RM9000";
 		c->isa_level = MIPS_CPU_ISA_IV;
 		c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_32FPR |
-		             MIPS_CPU_LLSC;
+			     MIPS_CPU_LLSC;
 		/*
 		 * Bit 29 in the info register of the RM9000
 		 * indicates if the TLB has 48 or 64 entries.
@@ -587,8 +587,8 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		__cpu_name[cpu] = "RM8000";
 		c->isa_level = MIPS_CPU_ISA_IV;
 		c->options = MIPS_CPU_TLB | MIPS_CPU_4KEX |
-		             MIPS_CPU_FPU | MIPS_CPU_32FPR |
-		             MIPS_CPU_LLSC;
+			     MIPS_CPU_FPU | MIPS_CPU_32FPR |
+			     MIPS_CPU_LLSC;
 		c->tlbsize = 384;      /* has weird TLB: 3-way x 128 */
 		break;
 	case PRID_IMP_R10000:
@@ -596,9 +596,9 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		__cpu_name[cpu] = "R10000";
 		c->isa_level = MIPS_CPU_ISA_IV;
 		c->options = MIPS_CPU_TLB | MIPS_CPU_4K_CACHE | MIPS_CPU_4KEX |
-		             MIPS_CPU_FPU | MIPS_CPU_32FPR |
+			     MIPS_CPU_FPU | MIPS_CPU_32FPR |
 			     MIPS_CPU_COUNTER | MIPS_CPU_WATCH |
-		             MIPS_CPU_LLSC;
+			     MIPS_CPU_LLSC;
 		c->tlbsize = 64;
 		break;
 	case PRID_IMP_R12000:
@@ -606,9 +606,9 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		__cpu_name[cpu] = "R12000";
 		c->isa_level = MIPS_CPU_ISA_IV;
 		c->options = MIPS_CPU_TLB | MIPS_CPU_4K_CACHE | MIPS_CPU_4KEX |
-		             MIPS_CPU_FPU | MIPS_CPU_32FPR |
+			     MIPS_CPU_FPU | MIPS_CPU_32FPR |
 			     MIPS_CPU_COUNTER | MIPS_CPU_WATCH |
-		             MIPS_CPU_LLSC;
+			     MIPS_CPU_LLSC;
 		c->tlbsize = 64;
 		break;
 	case PRID_IMP_R14000:
@@ -616,9 +616,9 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		__cpu_name[cpu] = "R14000";
 		c->isa_level = MIPS_CPU_ISA_IV;
 		c->options = MIPS_CPU_TLB | MIPS_CPU_4K_CACHE | MIPS_CPU_4KEX |
-		             MIPS_CPU_FPU | MIPS_CPU_32FPR |
+			     MIPS_CPU_FPU | MIPS_CPU_32FPR |
 			     MIPS_CPU_COUNTER | MIPS_CPU_WATCH |
-		             MIPS_CPU_LLSC;
+			     MIPS_CPU_LLSC;
 		c->tlbsize = 64;
 		break;
 	case PRID_IMP_LOONGSON2:
@@ -742,7 +742,7 @@ static inline unsigned int decode_config3(struct cpuinfo_mips *c)
 	if (config3 & MIPS_CONF3_VEIC)
 		c->options |= MIPS_CPU_VEIC;
 	if (config3 & MIPS_CONF3_MT)
-	        c->ases |= MIPS_ASE_MIPSMT;
+		c->ases |= MIPS_ASE_MIPSMT;
 	if (config3 & MIPS_CONF3_ULRI)
 		c->options |= MIPS_CPU_ULRI;
 	if (config3 & MIPS_CONF3_CTXTC)
@@ -772,7 +772,7 @@ static void __cpuinit decode_configs(struct cpuinfo_mips *c)
 
 	/* MIPS32 or MIPS64 compliant CPU.  */
 	c->options = MIPS_CPU_4KEX | MIPS_CPU_4K_CACHE | MIPS_CPU_COUNTER |
-	             MIPS_CPU_DIVEC | MIPS_CPU_LLSC | MIPS_CPU_MCHECK;
+		     MIPS_CPU_DIVEC | MIPS_CPU_LLSC | MIPS_CPU_MCHECK;
 
 	c->scache.flags = MIPS_CACHE_NOT_PRESENT;
 
-- 
1.7.9.6
