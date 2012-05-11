Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2012 06:21:40 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:33944 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903543Ab2EKEVc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 May 2012 06:21:32 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SShM5-0001hE-DE; Thu, 10 May 2012 23:21:25 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH v3,06/10] MIPS: Code formatting fixes.
Date:   Thu, 10 May 2012 23:21:18 -0500
Message-Id: <1336710078-29231-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10
X-archive-position: 33241
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
 arch/mips/kernel/proc.c      |   26 ++++++++++----------
 2 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index bffb33d..33c59e9 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -341,7 +341,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		__cpu_name[cpu] = "R2000";
 		c->isa_level = MIPS_CPU_ISA_I;
 		c->options = MIPS_CPU_TLB | MIPS_CPU_3K_CACHE |
-		             MIPS_CPU_NOFPUEX;
+			     MIPS_CPU_NOFPUEX;
 		if (__cpu_has_fpu())
 			c->options |= MIPS_CPU_FPU;
 		c->tlbsize = 64;
@@ -362,7 +362,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		}
 		c->isa_level = MIPS_CPU_ISA_I;
 		c->options = MIPS_CPU_TLB | MIPS_CPU_3K_CACHE |
-		             MIPS_CPU_NOFPUEX;
+			     MIPS_CPU_NOFPUEX;
 		if (__cpu_has_fpu())
 			c->options |= MIPS_CPU_FPU;
 		c->tlbsize = 64;
@@ -388,8 +388,8 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 
 		c->isa_level = MIPS_CPU_ISA_III;
 		c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_32FPR |
-		             MIPS_CPU_WATCH | MIPS_CPU_VCE |
-		             MIPS_CPU_LLSC;
+			     MIPS_CPU_WATCH | MIPS_CPU_VCE |
+			     MIPS_CPU_LLSC;
 		c->tlbsize = 48;
 		break;
 	case PRID_IMP_VR41XX:
@@ -435,7 +435,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		__cpu_name[cpu] = "R4300";
 		c->isa_level = MIPS_CPU_ISA_III;
 		c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_32FPR |
-		             MIPS_CPU_LLSC;
+			     MIPS_CPU_LLSC;
 		c->tlbsize = 32;
 		break;
 	case PRID_IMP_R4600:
@@ -447,7 +447,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		c->tlbsize = 48;
 		break;
 	#if 0
- 	case PRID_IMP_R4650:
+	case PRID_IMP_R4650:
 		/*
 		 * This processor doesn't have an MMU, so it's not
 		 * "real easy" to run Linux on it. It is left purely
@@ -456,9 +456,9 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
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
@@ -489,7 +489,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		__cpu_name[cpu] = "R4700";
 		c->isa_level = MIPS_CPU_ISA_III;
 		c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_32FPR |
-		             MIPS_CPU_LLSC;
+			     MIPS_CPU_LLSC;
 		c->tlbsize = 48;
 		break;
 	case PRID_IMP_TX49:
@@ -506,7 +506,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		__cpu_name[cpu] = "R5000";
 		c->isa_level = MIPS_CPU_ISA_IV;
 		c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_32FPR |
-		             MIPS_CPU_LLSC;
+			     MIPS_CPU_LLSC;
 		c->tlbsize = 48;
 		break;
 	case PRID_IMP_R5432:
@@ -514,7 +514,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		__cpu_name[cpu] = "R5432";
 		c->isa_level = MIPS_CPU_ISA_IV;
 		c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_32FPR |
-		             MIPS_CPU_WATCH | MIPS_CPU_LLSC;
+			     MIPS_CPU_WATCH | MIPS_CPU_LLSC;
 		c->tlbsize = 48;
 		break;
 	case PRID_IMP_R5500:
@@ -522,7 +522,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		__cpu_name[cpu] = "R5500";
 		c->isa_level = MIPS_CPU_ISA_IV;
 		c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_32FPR |
-		             MIPS_CPU_WATCH | MIPS_CPU_LLSC;
+			     MIPS_CPU_WATCH | MIPS_CPU_LLSC;
 		c->tlbsize = 48;
 		break;
 	case PRID_IMP_NEVADA:
@@ -530,7 +530,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		__cpu_name[cpu] = "Nevada";
 		c->isa_level = MIPS_CPU_ISA_IV;
 		c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_32FPR |
-		             MIPS_CPU_DIVEC | MIPS_CPU_LLSC;
+			     MIPS_CPU_DIVEC | MIPS_CPU_LLSC;
 		c->tlbsize = 48;
 		break;
 	case PRID_IMP_R6000:
@@ -538,7 +538,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		__cpu_name[cpu] = "R6000";
 		c->isa_level = MIPS_CPU_ISA_II;
 		c->options = MIPS_CPU_TLB | MIPS_CPU_FPU |
-		             MIPS_CPU_LLSC;
+			     MIPS_CPU_LLSC;
 		c->tlbsize = 32;
 		break;
 	case PRID_IMP_R6000A:
@@ -546,7 +546,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		__cpu_name[cpu] = "R6000A";
 		c->isa_level = MIPS_CPU_ISA_II;
 		c->options = MIPS_CPU_TLB | MIPS_CPU_FPU |
-		             MIPS_CPU_LLSC;
+			     MIPS_CPU_LLSC;
 		c->tlbsize = 32;
 		break;
 	case PRID_IMP_RM7000:
@@ -554,7 +554,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		__cpu_name[cpu] = "RM7000";
 		c->isa_level = MIPS_CPU_ISA_IV;
 		c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_32FPR |
-		             MIPS_CPU_LLSC;
+			     MIPS_CPU_LLSC;
 		/*
 		 * Undocumented RM7000:  Bit 29 in the info register of
 		 * the RM7000 v2.0 indicates if the TLB has 48 or 64
@@ -570,7 +570,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		__cpu_name[cpu] = "RM9000";
 		c->isa_level = MIPS_CPU_ISA_IV;
 		c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_32FPR |
-		             MIPS_CPU_LLSC;
+			     MIPS_CPU_LLSC;
 		/*
 		 * Bit 29 in the info register of the RM9000
 		 * indicates if the TLB has 48 or 64 entries.
@@ -585,8 +585,8 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
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
@@ -594,9 +594,9 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
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
@@ -604,9 +604,9 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
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
@@ -614,9 +614,9 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
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
@@ -740,7 +740,7 @@ static inline unsigned int decode_config3(struct cpuinfo_mips *c)
 	if (config3 & MIPS_CONF3_VEIC)
 		c->options |= MIPS_CPU_VEIC;
 	if (config3 & MIPS_CONF3_MT)
-	        c->ases |= MIPS_ASE_MIPSMT;
+		c->ases |= MIPS_ASE_MIPSMT;
 	if (config3 & MIPS_CONF3_ULRI)
 		c->options |= MIPS_CPU_ULRI;
 
@@ -768,7 +768,7 @@ static void __cpuinit decode_configs(struct cpuinfo_mips *c)
 
 	/* MIPS32 or MIPS64 compliant CPU.  */
 	c->options = MIPS_CPU_4KEX | MIPS_CPU_4K_CACHE | MIPS_CPU_COUNTER |
-	             MIPS_CPU_DIVEC | MIPS_CPU_LLSC | MIPS_CPU_MCHECK;
+		     MIPS_CPU_DIVEC | MIPS_CPU_LLSC | MIPS_CPU_MCHECK;
 
 	c->scache.flags = MIPS_CACHE_NOT_PRESENT;
 
diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index f8b2c59..5542817 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -41,27 +41,27 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 
 	seq_printf(m, "processor\t\t: %ld\n", n);
 	sprintf(fmt, "cpu model\t\t: %%s V%%d.%%d%s\n",
-	        cpu_data[n].options & MIPS_CPU_FPU ? "  FPU V%d.%d" : "");
+		      cpu_data[n].options & MIPS_CPU_FPU ? "  FPU V%d.%d" : "");
 	seq_printf(m, fmt, __cpu_name[n],
-	                           (version >> 4) & 0x0f, version & 0x0f,
-	                           (fp_vers >> 4) & 0x0f, fp_vers & 0x0f);
+		      (version >> 4) & 0x0f, version & 0x0f,
+		      (fp_vers >> 4) & 0x0f, fp_vers & 0x0f);
 	seq_printf(m, "BogoMIPS\t\t: %u.%02u\n",
-	              cpu_data[n].udelay_val / (500000/HZ),
-	              (cpu_data[n].udelay_val / (5000/HZ)) % 100);
+		      cpu_data[n].udelay_val / (500000/HZ),
+		      (cpu_data[n].udelay_val / (5000/HZ)) % 100);
 	seq_printf(m, "wait instruction\t: %s\n", cpu_wait ? "yes" : "no");
 	seq_printf(m, "microsecond timers\t: %s\n",
-	              cpu_has_counter ? "yes" : "no");
+		      cpu_has_counter ? "yes" : "no");
 	seq_printf(m, "tlb_entries\t\t: %d\n", cpu_data[n].tlbsize);
 	seq_printf(m, "extra interrupt vector\t: %s\n",
-	              cpu_has_divec ? "yes" : "no");
+		      cpu_has_divec ? "yes" : "no");
 	seq_printf(m, "hardware watchpoint\t: %s",
-		   cpu_has_watch ? "yes, " : "no\n");
+		      cpu_has_watch ? "yes, " : "no\n");
 	if (cpu_has_watch) {
 		seq_printf(m, "count: %d, address/irw mask: [",
-			   cpu_data[n].watch_reg_count);
+		      cpu_data[n].watch_reg_count);
 		for (i = 0; i < cpu_data[n].watch_reg_count; i++)
 			seq_printf(m, "%s0x%04x", i ? ", " : "" ,
-				   cpu_data[n].watch_reg_masks[i]);
+				cpu_data[n].watch_reg_masks[i]);
 		seq_printf(m, "]\n");
 	}
 	seq_printf(m, "ASEs implemented\t:%s%s%s%s%s%s\n",
@@ -73,13 +73,13 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 		      cpu_has_mipsmt ? " mt" : ""
 		);
 	seq_printf(m, "shadow register sets\t: %d\n",
-		       cpu_data[n].srsets);
+		      cpu_data[n].srsets);
 	seq_printf(m, "kscratch registers\t: %d\n",
-		   hweight8(cpu_data[n].kscratch_mask));
+		      hweight8(cpu_data[n].kscratch_mask));
 	seq_printf(m, "core\t\t\t: %d\n", cpu_data[n].core);
 
 	sprintf(fmt, "VCE%%c exceptions\t\t: %s\n",
-	        cpu_has_vce ? "%u" : "not available");
+		      cpu_has_vce ? "%u" : "not available");
 	seq_printf(m, fmt, 'D', vced_count);
 	seq_printf(m, fmt, 'I', vcei_count);
 	seq_printf(m, "\n");
-- 
1.7.10
