Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 May 2012 23:14:17 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:60830 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903691Ab2EJVON (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 May 2012 23:14:13 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SSagW-0000zV-T2; Thu, 10 May 2012 16:14:04 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH v2,1/5] MIPS: Add support for the 1074K core.
Date:   Thu, 10 May 2012 16:13:59 -0500
Message-Id: <1336684439-25109-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10
X-archive-position: 33233
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
 arch/mips/include/asm/cpu.h          |    1 +
 arch/mips/kernel/cpu-probe.c         |    4 ++++
 arch/mips/mm/c-r4k.c                 |   24 +++++++++++++++++++++---
 arch/mips/oprofile/op_model_mipsxx.c |    6 ------
 4 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index f9fa2a4..9f8feeb 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -94,6 +94,7 @@
 #define PRID_IMP_24KE		0x9600
 #define PRID_IMP_74K		0x9700
 #define PRID_IMP_1004K		0x9900
+#define PRID_IMP_1074K		0x9a00
 
 /*
  * These are the PRID's for when 23:16 == PRID_COMP_SIBYTE
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 5099201..4b5c7d6 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -835,6 +835,10 @@ static inline void cpu_probe_mips(struct cpuinfo_mips *c, unsigned int cpu)
 		c->cputype = CPU_1004K;
 		__cpu_name[cpu] = "MIPS 1004Kc";
 		break;
+	case PRID_IMP_1074K:
+		c->cputype = CPU_74K;
+		__cpu_name[cpu] = "MIPS 1074Kc";
+		break;
 	}
 
 	spram_config();
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index bda8eb2..c646a79 100644
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
@@ -1051,9 +1051,26 @@ static void __cpuinit probe_pcache(void)
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
+		if (((c->processor_id & 0xff00) == PRID_IMP_1074K) &&
+		   ((c->processor_id & 0xff) <= PRID_REV_ENCODE_332(1, 1, 0))) {
+			c->dcache.flags |= MIPS_CACHE_VTAG;
+			write_c0_config6(read_c0_config6() | MIPS_CONF6_SYND);
+		}
+		/* fall through */
 	case CPU_24K:
 	case CPU_34K:
-	case CPU_74K:
 	case CPU_1004K:
 		if ((read_c0_config7() & (1 << 16))) {
 			/* effectively physically indexed dcache,
@@ -1061,6 +1078,7 @@ static void __cpuinit probe_pcache(void)
 			c->dcache.flags |= MIPS_CACHE_PINDEX;
 			break;
 		}
+		/* fall through */
 	default:
 		if (c->dcache.waysize > PAGE_SIZE)
 			c->dcache.flags |= MIPS_CACHE_ALIASES;
diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
index 54759f1..53bbe55 100644
--- a/arch/mips/oprofile/op_model_mipsxx.c
+++ b/arch/mips/oprofile/op_model_mipsxx.c
@@ -330,12 +330,6 @@ static int __init mipsxx_init(void)
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
-- 
1.7.10
