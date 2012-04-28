Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Apr 2012 16:07:21 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:4781 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903696Ab2D1OGs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 28 Apr 2012 16:06:48 +0200
Received: from [10.9.200.131] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Sat, 28 Apr 2012 07:06:41 -0700
X-Server-Uuid: 72204117-5C29-4314-8910-60DB108979CB
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB01.corp.ad.broadcom.com (10.9.200.131) with Microsoft SMTP
 Server id 8.2.247.2; Sat, 28 Apr 2012 07:06:30 -0700
Received: from hqcas01.netlogicmicro.com (unknown [10.65.50.14]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 0FE5A9F9F6; Sat, 28
 Apr 2012 07:06:30 -0700 (PDT)
Received: from jayachandranc.netlogicmicro.com (10.7.0.77) by
 hqcas01.netlogicmicro.com (10.65.50.14) with Microsoft SMTP Server id
 14.1.339.1; Sat, 28 Apr 2012 07:06:29 -0700
From:   "Jayachandran C" <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Zi Shen Lim" <zlim@netlogicmicro.com>,
        "Jayachandran C" <jayachandranc@netlogicmicro.com>
Subject: [PATCH 2/2] MIPS: perf: Add XLP support for hardware perf.
Date:   Sat, 28 Apr 2012 19:36:21 +0530
Message-ID: <1335621981-18259-2-git-send-email-jayachandranc@netlogicmicro.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1335621981-18259-1-git-send-email-jayachandranc@netlogicmicro.com>
References: <1335621981-18259-1-git-send-email-jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
X-Originating-IP: [10.7.0.77]
X-WSS-ID: 638526FB3JG2125333-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 33068
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Zi Shen Lim <zlim@netlogicmicro.com>

Signed-off-by: Zi Shen Lim <zlim@netlogicmicro.com>
Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/Kconfig                    |    2 +-
 arch/mips/kernel/perf_event_mipsxx.c |  124 ++++++++++++++++++++++++++++++++++
 2 files changed, 125 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index db465fb..5fde8d7 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2130,7 +2130,7 @@ config NODES_SHIFT
 
 config HW_PERF_EVENTS
 	bool "Enable hardware performance counter support for perf events"
-	depends on PERF_EVENTS && !MIPS_MT_SMTC && OPROFILE=n && (CPU_MIPS32 || CPU_MIPS64 || CPU_R10000 || CPU_SB1 || CPU_CAVIUM_OCTEON)
+	depends on PERF_EVENTS && !MIPS_MT_SMTC && OPROFILE=n && (CPU_MIPS32 || CPU_MIPS64 || CPU_R10000 || CPU_SB1 || CPU_CAVIUM_OCTEON || CPU_XLP)
 	default y
 	help
 	  Enable hardware performance counter support for perf events. If
diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index 811084f..3e53081 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -834,6 +834,16 @@ static const struct mips_perf_event octeon_event_map[PERF_COUNT_HW_MAX] = {
 	[PERF_COUNT_HW_BUS_CYCLES] = { 0x25, CNTR_ALL },
 };
 
+static const struct mips_perf_event xlp_event_map[PERF_COUNT_HW_MAX] = {
+	[PERF_COUNT_HW_CPU_CYCLES] = { 0x01, CNTR_ALL },
+	[PERF_COUNT_HW_INSTRUCTIONS] = { 0x18, CNTR_ALL }, /* PAPI_TOT_INS */
+	[PERF_COUNT_HW_CACHE_REFERENCES] = { 0x04, CNTR_ALL }, /* PAPI_L1_ICA */
+	[PERF_COUNT_HW_CACHE_MISSES] = { 0x07, CNTR_ALL }, /* PAPI_L1_ICM */
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = { 0x1b, CNTR_ALL }, /* PAPI_BR_CN */
+	[PERF_COUNT_HW_BRANCH_MISSES] = { 0x1c, CNTR_ALL }, /* PAPI_BR_MSP */
+	[PERF_COUNT_HW_BUS_CYCLES] = { UNSUPPORTED_PERF_EVENT_ID },
+};
+
 /* 24K/34K/1004K cores can share the same cache event map. */
 static const struct mips_perf_event mipsxxcore_cache_map
 				[PERF_COUNT_HW_CACHE_MAX]
@@ -1163,6 +1173,100 @@ static const struct mips_perf_event octeon_cache_map
 },
 };
 
+static const struct mips_perf_event xlp_cache_map
+				[PERF_COUNT_HW_CACHE_MAX]
+				[PERF_COUNT_HW_CACHE_OP_MAX]
+				[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
+[C(L1D)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)]	= { 0x31, CNTR_ALL }, /* PAPI_L1_DCR */
+		[C(RESULT_MISS)]	= { 0x30, CNTR_ALL }, /* PAPI_L1_LDM */
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)]	= { 0x2f, CNTR_ALL }, /* PAPI_L1_DCW */
+		[C(RESULT_MISS)]	= { 0x2e, CNTR_ALL }, /* PAPI_L1_STM */
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+},
+[C(L1I)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)]	= { 0x04, CNTR_ALL }, /* PAPI_L1_ICA */
+		[C(RESULT_MISS)]	= { 0x07, CNTR_ALL }, /* PAPI_L1_ICM */
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
+[C(LL)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)]	= { 0x35, CNTR_ALL }, /* PAPI_L2_DCR */
+		[C(RESULT_MISS)]	= { 0x37, CNTR_ALL }, /* PAPI_L2_LDM */
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)]	= { 0x34, CNTR_ALL }, /* PAPI_L2_DCA */
+		[C(RESULT_MISS)]	= { 0x36, CNTR_ALL }, /* PAPI_L2_DCM */
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
+		[C(RESULT_MISS)]	= { 0x2d, CNTR_ALL }, /* PAPI_TLB_DM */
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { 0x2d, CNTR_ALL }, /* PAPI_TLB_DM */
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+},
+[C(ITLB)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { 0x08, CNTR_ALL }, /* PAPI_TLB_IM */
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { 0x08, CNTR_ALL }, /* PAPI_TLB_IM */
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+},
+[C(BPU)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { 0x25, CNTR_ALL },
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
@@ -1504,6 +1608,20 @@ static const struct mips_perf_event *octeon_pmu_map_raw_event(u64 config)
 	return &raw_event;
 }
 
+static const struct mips_perf_event *xlp_pmu_map_raw_event(u64 config)
+{
+	unsigned int raw_id = config & 0xff;
+
+	/* Only 1-63 are defined */
+	if ((raw_id < 0x01) || (raw_id > 0x3f))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	raw_event.cntr_mask = CNTR_ALL;
+	raw_event.event_id = raw_id;
+
+	return &raw_event;
+}
+
 static int __init
 init_hw_perf_events(void)
 {
@@ -1571,6 +1689,12 @@ init_hw_perf_events(void)
 		mipspmu.cache_event_map = &octeon_cache_map;
 		mipspmu.map_raw_event = octeon_pmu_map_raw_event;
 		break;
+	case CPU_XLP:
+		mipspmu.name = "xlp";
+		mipspmu.general_event_map = &xlp_event_map;
+		mipspmu.cache_event_map = &xlp_cache_map;
+		mipspmu.map_raw_event = xlp_pmu_map_raw_event;
+		break;
 	default:
 		pr_cont("Either hardware does not support performance "
 			"counters, or not yet implemented.\n");
-- 
1.7.9.5
