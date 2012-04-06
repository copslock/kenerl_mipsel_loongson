Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Apr 2012 19:58:23 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:35098 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1904078Ab2DFR6Q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Apr 2012 19:58:16 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SGDQH-00045d-1Z; Fri, 06 Apr 2012 12:58:09 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, sjhill@realitydiluted.com
Subject: [PATCH 1/5] MIPS: Add support for the 1074K core.
Date:   Fri,  6 Apr 2012 12:57:44 -0500
Message-Id: <1333735064-15672-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.6
X-archive-position: 32867
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

This patch adds support for detecting and using 1074K cores.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/cpu.h          |    3 ++-
 arch/mips/kernel/cpu-probe.c         |    5 +++++
 arch/mips/kernel/spram.c             |    1 +
 arch/mips/mm/c-r4k.c                 |   28 +++++++++++++++++++++++++---
 arch/mips/oprofile/common.c          |    1 +
 arch/mips/oprofile/op_model_mipsxx.c |    7 +------
 6 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index f9fa2a4..ddd8b4a 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -94,6 +94,7 @@
 #define PRID_IMP_24KE		0x9600
 #define PRID_IMP_74K		0x9700
 #define PRID_IMP_1004K		0x9900
+#define PRID_IMP_1074K		0x9a00
 
 /*
  * These are the PRID's for when 23:16 == PRID_COMP_SIBYTE
@@ -260,7 +261,7 @@ enum cpu_type_enum {
 	 */
 	CPU_4KC, CPU_4KEC, CPU_4KSC, CPU_24K, CPU_34K, CPU_1004K, CPU_74K,
 	CPU_ALCHEMY, CPU_PR4450, CPU_BMIPS32, CPU_BMIPS3300, CPU_BMIPS4350,
-	CPU_BMIPS4380, CPU_BMIPS5000, CPU_JZRISC,
+	CPU_BMIPS4380, CPU_BMIPS5000, CPU_JZRISC, CPU_1074K,
 
 	/*
 	 * MIPS64 class processors
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 5099201..cb1e2e9 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -207,6 +207,7 @@ void __init check_wait(void)
 			cpu_wait = r4k_wait_irqoff;
 		break;
 
+	case CPU_1074K:
 	case CPU_74K:
 		cpu_wait = r4k_wait;
 		if ((c->processor_id & 0xff) >= PRID_REV_ENCODE_332(2, 1, 0))
@@ -835,6 +836,10 @@ static inline void cpu_probe_mips(struct cpuinfo_mips *c, unsigned int cpu)
 		c->cputype = CPU_1004K;
 		__cpu_name[cpu] = "MIPS 1004Kc";
 		break;
+	case PRID_IMP_1074K:
+		c->cputype = CPU_1074K;
+		__cpu_name[cpu] = "MIPS 1074Kc";
+		break;
 	}
 
 	spram_config();
diff --git a/arch/mips/kernel/spram.c b/arch/mips/kernel/spram.c
index 6af08d8..5781dbf 100644
--- a/arch/mips/kernel/spram.c
+++ b/arch/mips/kernel/spram.c
@@ -205,6 +205,7 @@ void __cpuinit spram_config(void)
 	case CPU_24K:
 	case CPU_34K:
 	case CPU_74K:
+	case CPU_1074K:
 	case CPU_1004K:
 		config0 = read_c0_config();
 		/* FIXME: addresses are Malta specific */
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index bda8eb2..a08e75d 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -977,7 +977,7 @@ static void __cpuinit probe_pcache(void)
 			c->icache.linesz = 2 << lsize;
 		else
 			c->icache.linesz = lsize;
-		c->icache.sets = 64 << ((config1 >> 22) & 7);
+		c->icache.sets = 32 << (((config1 >> 22) + 1) & 7);
 		c->icache.ways = 1 + ((config1 >> 16) & 7);
 
 		icache_size = c->icache.sets *
@@ -997,7 +997,7 @@ static void __cpuinit probe_pcache(void)
 			c->dcache.linesz = 2 << lsize;
 		else
 			c->dcache.linesz= lsize;
-		c->dcache.sets = 64 << ((config1 >> 13) & 7);
+		c->dcache.sets = 32 << (((config1 >> 13) + 1) & 7);
 		c->dcache.ways = 1 + ((config1 >> 7) & 7);
 
 		dcache_size = c->dcache.sets *
@@ -1051,9 +1051,30 @@ static void __cpuinit probe_pcache(void)
 	case CPU_R14000:
 		break;
 
+	case CPU_74K:
+		/*
+		 * Early versions of the 74k do not update
+		 * the cache tags on a vtag miss/ptag hit
+		 * which can occur in the case of KSEG0/KUSEG aliases
+		 * In this case it is better to treat the cache as always
+		 * having aliases
+		 */
+		if ((c->processor_id & 0xff) <= PRID_REV_ENCODE_332(2, 4, 0))
+			c->dcache.flags |= MIPS_CACHE_VTAG;
+		if ((c->processor_id & 0xff) == PRID_REV_ENCODE_332(2, 4, 0))
+			write_c0_config6(read_c0_config6() | MIPS_CONF6_SYND);
+		goto bypass1074;
+
+	case CPU_1074K:
+		if ((c->processor_id & 0xff) <= PRID_REV_ENCODE_332(1, 1, 0)) {
+			c->dcache.flags |= MIPS_CACHE_VTAG;
+			write_c0_config6(read_c0_config6() | MIPS_CONF6_SYND);
+		}
+		/* fall through */
+bypass1074:
+		;
 	case CPU_24K:
 	case CPU_34K:
-	case CPU_74K:
 	case CPU_1004K:
 		if ((read_c0_config7() & (1 << 16))) {
 			/* effectively physically indexed dcache,
@@ -1061,6 +1082,7 @@ static void __cpuinit probe_pcache(void)
 			c->dcache.flags |= MIPS_CACHE_PINDEX;
 			break;
 		}
+		/* fall through */
 	default:
 		if (c->dcache.waysize > PAGE_SIZE)
 			c->dcache.flags |= MIPS_CACHE_ALIASES;
diff --git a/arch/mips/oprofile/common.c b/arch/mips/oprofile/common.c
index d1f2d4c..846faf7 100644
--- a/arch/mips/oprofile/common.c
+++ b/arch/mips/oprofile/common.c
@@ -83,6 +83,7 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
 	case CPU_25KF:
 	case CPU_34K:
 	case CPU_1004K:
+	case CPU_1074K:
 	case CPU_74K:
 	case CPU_SB1:
 	case CPU_SB1A:
diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
index 54759f1..13487a9 100644
--- a/arch/mips/oprofile/op_model_mipsxx.c
+++ b/arch/mips/oprofile/op_model_mipsxx.c
@@ -330,16 +330,11 @@ static int __init mipsxx_init(void)
 		break;
 
 	case CPU_1004K:
-#if 0
-		/* FIXME: report as 34K for now */
-		op_model_mipsxx_ops.cpu_type = "mips/1004K";
-		break;
-#endif
-
 	case CPU_34K:
 		op_model_mipsxx_ops.cpu_type = "mips/34K";
 		break;
 
+	case CPU_1074K:
 	case CPU_74K:
 		op_model_mipsxx_ops.cpu_type = "mips/74K";
 		break;
-- 
1.7.9.6
