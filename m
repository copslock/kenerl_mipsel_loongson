Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jan 2014 22:04:06 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:55165 "EHLO localhost"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6825493AbaAQVEDyKLmp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Jan 2014 22:04:03 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1W4Ga4-0005KL-ET; Fri, 17 Jan 2014 15:03:56 -0600
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH] MIPS: Add 1074K CPU support explicitly.
Date:   Fri, 17 Jan 2014 15:03:50 -0600
Message-Id: <1389992630-64139-1-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39029
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

From: "Steven J. Hill" <Steven.Hill@imgtec.com>

The 1074K is a multiprocessing coherent processing system (CPS) based
on modified 74K cores. This patch makes the 1074K an actual unique
CPU type, instead of a 74K derivative, which it is not.

Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
Reviewed-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
---
 arch/mips/bcm47xx/setup.c            |    2 +-
 arch/mips/include/asm/cpu.h          |    2 +-
 arch/mips/kernel/cpu-probe.c         |    2 +-
 arch/mips/kernel/idle.c              |    1 +
 arch/mips/kernel/perf_event_mipsxx.c |    6 ++++++
 arch/mips/kernel/spram.c             |    1 +
 arch/mips/kernel/traps.c             |    1 +
 arch/mips/mm/c-r4k.c                 |    3 ++-
 arch/mips/mm/sc-mips.c               |    1 +
 arch/mips/mm/tlbex.c                 |    1 +
 arch/mips/oprofile/common.c          |    1 +
 arch/mips/oprofile/op_model_mipsxx.c |    1 +
 12 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index 12d77e9..1f286ca 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -209,7 +209,7 @@ void __init plat_mem_setup(void)
 {
 	struct cpuinfo_mips *c = &current_cpu_data;
 
-	if (c->cputype == CPU_74K) {
+	if ((c->cputype == CPU_74K) || (c->cputype == CPU_1074K)) {
 		printk(KERN_INFO "bcm47xx: using bcma bus\n");
 #ifdef CONFIG_BCM47XX_BCMA
 		bcm47xx_bus_type = BCM47XX_BUS_TYPE_BCMA;
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 76411df..559c668 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -296,7 +296,7 @@ enum cpu_type_enum {
 	CPU_4KC, CPU_4KEC, CPU_4KSC, CPU_24K, CPU_34K, CPU_1004K, CPU_74K,
 	CPU_ALCHEMY, CPU_PR4450, CPU_BMIPS32, CPU_BMIPS3300, CPU_BMIPS4350,
 	CPU_BMIPS4380, CPU_BMIPS5000, CPU_JZRISC, CPU_LOONGSON1, CPU_M14KC,
-	CPU_M14KEC, CPU_INTERAPTIV, CPU_PROAPTIV,
+	CPU_M14KEC, CPU_INTERAPTIV, CPU_PROAPTIV, CPU_1074K,
 
 	/*
 	 * MIPS64 class processors
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 530f832..ac09248 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -806,7 +806,7 @@ static inline void cpu_probe_mips(struct cpuinfo_mips *c, unsigned int cpu)
 		__cpu_name[cpu] = "MIPS 1004Kc";
 		break;
 	case PRID_IMP_1074K:
-		c->cputype = CPU_74K;
+		c->cputype = CPU_1074K;
 		__cpu_name[cpu] = "MIPS 1074Kc";
 		break;
 	case PRID_IMP_INTERAPTIV_UP:
diff --git a/arch/mips/kernel/idle.c b/arch/mips/kernel/idle.c
index 3553243..c1fd0bc 100644
--- a/arch/mips/kernel/idle.c
+++ b/arch/mips/kernel/idle.c
@@ -184,6 +184,7 @@ void __init check_wait(void)
 	case CPU_24K:
 	case CPU_34K:
 	case CPU_1004K:
+	case CPU_1074K:
 	case CPU_INTERAPTIV:
 	case CPU_PROAPTIV:
 		cpu_wait = r4k_wait;
diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index 24cdf64..17594b8 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -1442,6 +1442,7 @@ static const struct mips_perf_event *mipsxx_pmu_map_raw_event(u64 config)
 #endif
 		break;
 	case CPU_74K:
+	case CPU_1074K:
 		if (IS_BOTH_COUNTERS_74K_EVENT(base_id))
 			raw_event.cntr_mask = CNTR_EVEN | CNTR_ODD;
 		else
@@ -1584,6 +1585,11 @@ init_hw_perf_events(void)
 		mipspmu.general_event_map = &mipsxxcore_event_map;
 		mipspmu.cache_event_map = &mipsxxcore_cache_map;
 		break;
+	case CPU_1074K:
+		mipspmu.name = "mips/1074K";
+		mipspmu.general_event_map = &mipsxxcore_event_map;
+		mipspmu.cache_event_map = &mipsxxcore_cache_map;
+		break;
 	case CPU_LOONGSON1:
 		mipspmu.name = "mips/loongson1";
 		mipspmu.general_event_map = &mipsxxcore_event_map;
diff --git a/arch/mips/kernel/spram.c b/arch/mips/kernel/spram.c
index dfed8a4..ac512b6 100644
--- a/arch/mips/kernel/spram.c
+++ b/arch/mips/kernel/spram.c
@@ -206,6 +206,7 @@ void spram_config(void)
 	case CPU_34K:
 	case CPU_74K:
 	case CPU_1004K:
+	case CPU_1074K:
 	case CPU_INTERAPTIV:
 	case CPU_PROAPTIV:
 		config0 = read_c0_config();
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index e0b4996..b0c7f80 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1337,6 +1337,7 @@ static inline void parity_protection_init(void)
 	case CPU_34K:
 	case CPU_74K:
 	case CPU_1004K:
+	case CPU_1074K:
 	case CPU_INTERAPTIV:
 	case CPU_PROAPTIV:
 		{
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 13b549a..7184363 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1106,9 +1106,10 @@ static void probe_pcache(void)
 	case CPU_34K:
 	case CPU_74K:
 	case CPU_1004K:
+	case CPU_1074K:
 	case CPU_INTERAPTIV:
 	case CPU_PROAPTIV:
-		if (current_cpu_type() == CPU_74K)
+		if ((c->cputype == CPU_74K) || (c->cputype == CPU_1074K))
 			alias_74k_erratum(c);
 		if ((read_c0_config7() & (1 << 16))) {
 			/* effectively physically indexed dcache,
diff --git a/arch/mips/mm/sc-mips.c b/arch/mips/mm/sc-mips.c
index 7a56aee..7b39770 100644
--- a/arch/mips/mm/sc-mips.c
+++ b/arch/mips/mm/sc-mips.c
@@ -76,6 +76,7 @@ static inline int mips_sc_is_activated(struct cpuinfo_mips *c)
 	case CPU_34K:
 	case CPU_74K:
 	case CPU_1004K:
+	case CPU_1074K:
 	case CPU_INTERAPTIV:
 	case CPU_PROAPTIV:
 	case CPU_BMIPS5000:
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 6fdfe1f..8646d2a 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -510,6 +510,7 @@ static void build_tlb_write_entry(u32 **p, struct uasm_label **l,
 		switch (current_cpu_type()) {
 		case CPU_M14KC:
 		case CPU_74K:
+		case CPU_1074K:
 		case CPU_PROAPTIV:
 			break;
 
diff --git a/arch/mips/oprofile/common.c b/arch/mips/oprofile/common.c
index 2a86e38..710e7f0 100644
--- a/arch/mips/oprofile/common.c
+++ b/arch/mips/oprofile/common.c
@@ -86,6 +86,7 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
 	case CPU_34K:
 	case CPU_1004K:
 	case CPU_74K:
+	case CPU_1074K:
 	case CPU_INTERAPTIV:
 	case CPU_PROAPTIV:
 	case CPU_LOONGSON1:
diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
index 4d94d75..3a040eb 100644
--- a/arch/mips/oprofile/op_model_mipsxx.c
+++ b/arch/mips/oprofile/op_model_mipsxx.c
@@ -372,6 +372,7 @@ static int __init mipsxx_init(void)
 		op_model_mipsxx_ops.cpu_type = "mips/34K";
 		break;
 
+	case CPU_1074K:
 	case CPU_74K:
 		op_model_mipsxx_ops.cpu_type = "mips/74K";
 		break;
-- 
1.7.10.4
