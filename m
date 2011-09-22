Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Sep 2011 19:28:29 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:6007 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491922Ab1IVR0v (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Sep 2011 19:26:51 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4e7b701b0001>; Thu, 22 Sep 2011 10:27:55 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 22 Sep 2011 10:26:41 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 22 Sep 2011 10:26:40 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id p8MHQbDS007342;
        Thu, 22 Sep 2011 10:26:38 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p8MHQbCQ007341;
        Thu, 22 Sep 2011 10:26:37 -0700
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Subject: [PATCH v5 5/5] MIPS: perf: Add Octeon support for hardware perf.
Date:   Thu, 22 Sep 2011 10:26:18 -0700
Message-Id: <1316712378-7282-6-git-send-email-david.daney@cavium.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1316712378-7282-1-git-send-email-david.daney@cavium.com>
References: <1316712378-7282-1-git-send-email-david.daney@cavium.com>
X-OriginalArrivalTime: 22 Sep 2011 17:26:41.0032 (UTC) FILETIME=[CA97C080:01CC794C]
X-archive-position: 31131
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12725

Enable hardware counters for Octeon, and add the corresponding event
mappings.

Signed-off-by: David Daney <david.daney@cavium.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
---
 arch/mips/Kconfig                    |    2 +-
 arch/mips/kernel/perf_event_mipsxx.c |  147 ++++++++++++++++++++++++++++++++++
 2 files changed, 148 insertions(+), 1 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index cf714ea..b02d59e 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2098,7 +2098,7 @@ config NODES_SHIFT
 
 config HW_PERF_EVENTS
 	bool "Enable hardware performance counter support for perf events"
-	depends on PERF_EVENTS && !MIPS_MT_SMTC && OPROFILE=n && (CPU_MIPS32 || CPU_MIPS64 || CPU_R10000 || CPU_SB1)
+	depends on PERF_EVENTS && !MIPS_MT_SMTC && OPROFILE=n && (CPU_MIPS32 || CPU_MIPS64 || CPU_R10000 || CPU_SB1 || CPU_CAVIUM_OCTEON)
 	default y
 	help
 	  Enable hardware performance counter support for perf events. If
diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index 0c95494..4f2971b 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -841,6 +841,16 @@ static const struct mips_perf_event mipsxx74Kcore_event_map
 	[PERF_COUNT_HW_BUS_CYCLES] = { UNSUPPORTED_PERF_EVENT_ID },
 };
 
+static const struct mips_perf_event octeon_event_map[PERF_COUNT_HW_MAX] = {
+	[PERF_COUNT_HW_CPU_CYCLES] = { 0x01, CNTR_ALL },
+	[PERF_COUNT_HW_INSTRUCTIONS] = { 0x03, CNTR_ALL },
+	[PERF_COUNT_HW_CACHE_REFERENCES] = { 0x2b, CNTR_ALL },
+	[PERF_COUNT_HW_CACHE_MISSES] = { 0x2e, CNTR_ALL  },
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = { 0x08, CNTR_ALL },
+	[PERF_COUNT_HW_BRANCH_MISSES] = { 0x09, CNTR_ALL },
+	[PERF_COUNT_HW_BUS_CYCLES] = { 0x25, CNTR_ALL },
+};
+
 /* 24K/34K/1004K cores can share the same cache event map. */
 static const struct mips_perf_event mipsxxcore_cache_map
 				[PERF_COUNT_HW_CACHE_MAX]
@@ -1074,6 +1084,102 @@ static const struct mips_perf_event mipsxx74Kcore_cache_map
 },
 };
 
+
+static const struct mips_perf_event octeon_cache_map
+				[PERF_COUNT_HW_CACHE_MAX]
+				[PERF_COUNT_HW_CACHE_OP_MAX]
+				[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
+[C(L1D)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)]	= { 0x2b, CNTR_ALL },
+		[C(RESULT_MISS)]	= { 0x2e, CNTR_ALL },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)]	= { 0x30, CNTR_ALL },
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+},
+[C(L1I)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)]	= { 0x18, CNTR_ALL },
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)]	= { 0x19, CNTR_ALL },
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+},
+[C(LL)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+},
+[C(DTLB)] = {
+	/*
+	 * Only general DTLB misses are counted use the same event for
+	 * read and write.
+	 */
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { 0x35, CNTR_ALL },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { 0x35, CNTR_ALL },
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+},
+[C(ITLB)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { 0x37, CNTR_ALL },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+},
+[C(BPU)] = {
+	/* Using the same code for *HW_BRANCH* */
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+},
+};
+
 #ifdef CONFIG_MIPS_MT_SMP
 static void check_and_calc_range(struct perf_event *event,
 				 const struct mips_perf_event *pev)
@@ -1411,6 +1517,39 @@ static const struct mips_perf_event *mipsxx_pmu_map_raw_event(u64 config)
 	return &raw_event;
 }
 
+static const struct mips_perf_event *octeon_pmu_map_raw_event(u64 config)
+{
+	unsigned int raw_id = config & 0xff;
+	unsigned int base_id = raw_id & 0x7f;
+
+
+	raw_event.cntr_mask = CNTR_ALL;
+	raw_event.event_id = base_id;
+
+	if (current_cpu_type() == CPU_CAVIUM_OCTEON2) {
+		if (base_id > 0x42)
+			return ERR_PTR(-EOPNOTSUPP);
+	} else {
+		if (base_id > 0x3a)
+			return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	switch (base_id) {
+	case 0x00:
+	case 0x0f:
+	case 0x1e:
+	case 0x1f:
+	case 0x2f:
+	case 0x34:
+	case 0x3b ... 0x3f:
+		return ERR_PTR(-EOPNOTSUPP);
+	default:
+		break;
+	}
+
+	return &raw_event;
+}
+
 static int __init
 init_hw_perf_events(void)
 {
@@ -1470,6 +1609,14 @@ init_hw_perf_events(void)
 		mipspmu.general_event_map = &mipsxxcore_event_map;
 		mipspmu.cache_event_map = &mipsxxcore_cache_map;
 		break;
+	case CPU_CAVIUM_OCTEON:
+	case CPU_CAVIUM_OCTEON_PLUS:
+	case CPU_CAVIUM_OCTEON2:
+		mipspmu.name = "octeon";
+		mipspmu.general_event_map = &octeon_event_map;
+		mipspmu.cache_event_map = &octeon_cache_map;
+		mipspmu.map_raw_event = octeon_pmu_map_raw_event;
+		break;
 	default:
 		pr_cont("Either hardware does not support performance "
 			"counters, or not yet implemented.\n");
-- 
1.7.2.3
