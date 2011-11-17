Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Nov 2011 10:39:58 +0100 (CET)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:63280 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904019Ab1KQJjw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Nov 2011 10:39:52 +0100
Received: by yenr8 with SMTP id r8so385422yen.36
        for <multiple recipients>; Thu, 17 Nov 2011 01:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Z0QDKfHf/bmdQN3TioP6MjLSykDyU2G3sUKsHS85RxE=;
        b=UFDnC9S8//PkD7aSo6+Jaf49v5VHJ1n3CLm2BuF+iRDoO1X8scwrXie7jh8q3UwsfE
         DdXxxMyoCredqqtLrF8OzA4qc/jYHzZewNG+wpjdUCTlxiVQxh2Yju+wFi1eeStgjs+y
         HG1/AdZheZQKvQT4i8A25yPLVLFitERpC6XJ0=
Received: by 10.236.197.99 with SMTP id s63mr7571080yhn.14.1321522786365;
        Thu, 17 Nov 2011 01:39:46 -0800 (PST)
Received: from kelvin-Work.chd.intersil.com ([182.148.112.76])
        by mx.google.com with ESMTPS id j25sm5198496yhm.12.2011.11.17.01.39.29
        (version=SSLv3 cipher=OTHER);
        Thu, 17 Nov 2011 01:39:45 -0800 (PST)
From:   keguang.zhang@gmail.com
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     ralf@linux-mips.org, zhzhl555@gmail.com, peppe.cavallaro@st.com,
        wuzhangjin@gmail.com, r0bertz@gentoo.org,
        Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH V3 1/5] MIPS: Add CPU support for Loongson1B
Date:   Thu, 17 Nov 2011 17:39:04 +0800
Message-Id: <1321522748-21391-1-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.7.1
X-archive-position: 31714
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14286

From: Kelvin Cheung <keguang.zhang@gmail.com>

This patch adds CPU support for Loongson1B.

Loongson 1B is a 32-bit SoC designed by Institute of
Computing Technology (ICT), Chinese Academy of Sciences (CAS),
which implements the MIPS32 release 2 instruction set.

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
---
 arch/mips/include/asm/cpu.h          |    3 ++-
 arch/mips/include/asm/module.h       |    2 ++
 arch/mips/kernel/cpu-probe.c         |   15 +++++++++++++++
 arch/mips/kernel/perf_event_mipsxx.c |    6 ++++++
 arch/mips/kernel/traps.c             |    1 +
 arch/mips/oprofile/common.c          |    1 +
 arch/mips/oprofile/op_model_mipsxx.c |    4 ++++
 7 files changed, 31 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 5f95a4b..975f372 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -191,6 +191,7 @@
 #define PRID_REV_34K_V1_0_2	0x0022
 #define PRID_REV_LOONGSON2E	0x0002
 #define PRID_REV_LOONGSON2F	0x0003
+#define PRID_REV_LOONGSON1B	0x0020
 
 /*
  * Older processors used to encode processor version and revision in two
@@ -253,7 +254,7 @@ enum cpu_type_enum {
 	 */
 	CPU_4KC, CPU_4KEC, CPU_4KSC, CPU_24K, CPU_34K, CPU_1004K, CPU_74K,
 	CPU_ALCHEMY, CPU_PR4450, CPU_BMIPS32, CPU_BMIPS3300, CPU_BMIPS4350,
-	CPU_BMIPS4380, CPU_BMIPS5000, CPU_JZRISC,
+	CPU_BMIPS4380, CPU_BMIPS5000, CPU_JZRISC, CPU_LOONGSON1,
 
 	/*
 	 * MIPS64 class processors
diff --git a/arch/mips/include/asm/module.h b/arch/mips/include/asm/module.h
index bc01a02..b53d642 100644
--- a/arch/mips/include/asm/module.h
+++ b/arch/mips/include/asm/module.h
@@ -116,6 +116,8 @@ search_module_dbetables(unsigned long addr)
 #define MODULE_PROC_FAMILY "SB1 "
 #elif defined CONFIG_CPU_LOONGSON2
 #define MODULE_PROC_FAMILY "LOONGSON2 "
+#elif defined CONFIG_CPU_LOONGSON1
+#define MODULE_PROC_FAMILY "LOONGSON1 "
 #elif defined CONFIG_CPU_CAVIUM_OCTEON
 #define MODULE_PROC_FAMILY "OCTEON "
 #elif defined CONFIG_CPU_XLR
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 664bc13..98d4235 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -37,6 +37,8 @@
 void (*cpu_wait)(void);
 EXPORT_SYMBOL(cpu_wait);
 
+static void __cpuinit decode_configs(struct cpuinfo_mips *c);
+
 static void r3081_wait(void)
 {
 	unsigned long cfg = read_c0_conf();
@@ -191,6 +193,7 @@ void __init check_wait(void)
 	case CPU_CAVIUM_OCTEON2:
 	case CPU_JZRISC:
 	case CPU_XLR:
+	case CPU_LOONGSON1:
 		cpu_wait = r4k_wait;
 		break;
 
@@ -636,6 +639,18 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 			     MIPS_CPU_32FPR;
 		c->tlbsize = 64;
 		break;
+	case PRID_IMP_LOONGSON1:
+		decode_configs(c);
+
+		c->cputype = CPU_LOONGSON1;
+
+		switch (c->processor_id & PRID_REV_MASK) {
+		case PRID_REV_LOONGSON1B:
+			__cpu_name[cpu] = "Loongson 1B";
+			break;
+		}
+
+		break;
 	}
 }
 
diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index e5ad09a..e316b0e 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -1062,6 +1062,12 @@ init_hw_perf_events(void)
 		mipsxxcore_pmu.irq = irq;
 		mipspmu = &mipsxxcore_pmu;
 		break;
+	case CPU_LOONGSON1:
+		mipsxxcore_pmu.name = "mips/loongson1";
+		mipsxxcore_pmu.num_counters = counters;
+		mipsxxcore_pmu.irq = irq;
+		mipspmu = &mipsxxcore_pmu;
+		break;
 	default:
 		pr_cont("Either hardware does not support performance "
 			"counters, or not yet implemented.\n");
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 01eff7e..cd55823 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1241,6 +1241,7 @@ static inline void parity_protection_init(void)
 		break;
 
 	case CPU_5KC:
+	case CPU_LOONGSON1:
 		write_c0_ecc(0x80000000);
 		back_to_back_c0_hazard();
 		/* Set the PE bit (bit 31) in the c0_errctl register. */
diff --git a/arch/mips/oprofile/common.c b/arch/mips/oprofile/common.c
index d1f2d4c..99216f0 100644
--- a/arch/mips/oprofile/common.c
+++ b/arch/mips/oprofile/common.c
@@ -89,6 +89,7 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
 	case CPU_R10000:
 	case CPU_R12000:
 	case CPU_R14000:
+	case CPU_LOONGSON1:
 		lmodel = &op_model_mipsxx_ops;
 		break;
 
diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
index 54759f1..03be670 100644
--- a/arch/mips/oprofile/op_model_mipsxx.c
+++ b/arch/mips/oprofile/op_model_mipsxx.c
@@ -365,6 +365,10 @@ static int __init mipsxx_init(void)
 		op_model_mipsxx_ops.cpu_type = "mips/sb1";
 		break;
 
+	case CPU_LOONGSON1:
+		op_model_mipsxx_ops.cpu_type = "mips/loongson1";
+		break;
+
 	default:
 		printk(KERN_ERR "Profiling unsupported for this CPU\n");
 
-- 
1.7.1
