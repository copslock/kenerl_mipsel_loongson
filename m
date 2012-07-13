Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jul 2012 22:47:33 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:1344 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903727Ab2GMUqS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 Jul 2012 22:46:18 +0200
Received: from [10.9.200.131] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Fri, 13 Jul 2012 13:45:03 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB01.corp.ad.broadcom.com (10.9.200.131) with Microsoft SMTP
 Server id 8.2.247.2; Fri, 13 Jul 2012 13:45:57 -0700
Received: from stbsrv-and-2.and.broadcom.com (
 stbsrv-and-2.and.broadcom.com [10.32.128.96]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 29DDF9F9F5; Fri, 13
 Jul 2012 13:45:57 -0700 (PDT)
From:   "Al Cooper" <alcooperx@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
cc:     "Al Cooper" <alcooperx@gmail.com>
Subject: [PATCH 5/5] MIPS: perf: Add perf functionality for BMIPS5000
Date:   Fri, 13 Jul 2012 16:44:54 -0400
Message-ID: <1342212294-23014-5-git-send-email-alcooperx@gmail.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1342212294-23014-1-git-send-email-alcooperx@gmail.com>
References: <y> <1342212294-23014-1-git-send-email-alcooperx@gmail.com>
MIME-Version: 1.0
X-WSS-ID: 7C1E57453NK5453393-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 33926
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alcooperx@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Add hardware performance counter support to kernel "perf" code for
BMIPS5000. The BMIPS5000 performance counters are similar to MIPS
MTI cores, so the changes were mostly made in perf_event_mipsxx.c
which is typically for MTI cores.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 arch/mips/kernel/perf_event_mipsxx.c |  103 +++++++++++++++++++++++++++++++++-
 1 files changed, 102 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index cb21308..a9b995d 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -28,6 +28,8 @@
 #include <asm/time.h> /* For perf_irq */
 
 #define MIPS_MAX_HWEVENTS 4
+#define MIPS_TCS_PER_COUNTER 2
+#define MIPS_CPUID_TO_COUNTER_MASK (MIPS_TCS_PER_COUNTER - 1)
 
 struct cpu_hw_events {
 	/* Array of events on this cpu. */
@@ -108,13 +110,20 @@ static struct mips_pmu mipspmu;
 #define M_PERFCTL_INTERRUPT_ENABLE	(1      <<  4)
 #define M_PERFCTL_EVENT(event)		(((event) & 0x3ff)  << 5)
 #define M_PERFCTL_VPEID(vpe)		((vpe)    << 16)
+
+#ifdef CONFIG_CPU_BMIPS5000
+#define M_PERFCTL_MT_EN(filter)		0
+#else /* !CONFIG_CPU_BMIPS5000 */
 #define M_PERFCTL_MT_EN(filter)		((filter) << 20)
+#endif /* CONFIG_CPU_BMIPS5000 */
+
 #define    M_TC_EN_ALL			M_PERFCTL_MT_EN(0)
 #define    M_TC_EN_VPE			M_PERFCTL_MT_EN(1)
 #define    M_TC_EN_TC			M_PERFCTL_MT_EN(2)
 #define M_PERFCTL_TCID(tcid)		((tcid)   << 22)
 #define M_PERFCTL_WIDE			(1      << 30)
 #define M_PERFCTL_MORE			(1      << 31)
+#define M_PERFCTL_TC			(1      << 30)
 
 #define M_PERFCTL_COUNT_EVENT_WHENEVER	(M_PERFCTL_EXL |		\
 					M_PERFCTL_KERNEL |		\
@@ -135,12 +144,17 @@ static int cpu_has_mipsmt_pertccounters;
 
 static DEFINE_RWLOCK(pmuint_rwlock);
 
+#if defined(CONFIG_CPU_BMIPS5000)
+#define vpe_id()	(cpu_has_mipsmt_pertccounters ? \
+			 0 : (smp_processor_id() & MIPS_CPUID_TO_COUNTER_MASK))
+#else
 /*
  * FIXME: For VSMP, vpe_id() is redefined for Perf-events, because
  * cpu_data[cpuid].vpe_id reports 0 for _both_ CPUs.
  */
 #define vpe_id()	(cpu_has_mipsmt_pertccounters ? \
-			0 : smp_processor_id())
+			 0 : smp_processor_id())
+#endif
 
 /* Copied from op_model_mipsxx.c */
 static unsigned int vpe_shift(void)
@@ -334,6 +348,11 @@ static void mipsxx_pmu_enable_event(struct hw_perf_event *evt, int idx)
 		(evt->config_base & M_PERFCTL_CONFIG_MASK) |
 		/* Make sure interrupt enabled. */
 		M_PERFCTL_INTERRUPT_ENABLE;
+	if (IS_ENABLED(CONFIG_CPU_BMIPS5000))
+		/* enable the counter for the calling thread */
+		cpuc->saved_ctrl[idx] |=
+			(1 << (12 + vpe_id())) | M_PERFCTL_TC;
+
 	/*
 	 * We do not actually let the counter run. Leave it until start().
 	 */
@@ -814,6 +833,13 @@ static const struct mips_perf_event octeon_event_map[PERF_COUNT_HW_MAX] = {
 	[PERF_COUNT_HW_BUS_CYCLES] = { 0x25, CNTR_ALL },
 };
 
+static const struct mips_perf_event bmips5000_event_map
+				[PERF_COUNT_HW_MAX] = {
+	[PERF_COUNT_HW_CPU_CYCLES] = { 0x00, CNTR_EVEN | CNTR_ODD, T },
+	[PERF_COUNT_HW_INSTRUCTIONS] = { 0x01, CNTR_EVEN | CNTR_ODD, T },
+	[PERF_COUNT_HW_BRANCH_MISSES] = { 0x02, CNTR_ODD, T },
+};
+
 /* 24K/34K/1004K cores can share the same cache event map. */
 static const struct mips_perf_event mipsxxcore_cache_map
 				[PERF_COUNT_HW_CACHE_MAX]
@@ -966,6 +992,65 @@ static const struct mips_perf_event mipsxx74Kcore_cache_map
 },
 };
 
+/* BMIPS5000 */
+static const struct mips_perf_event bmips5000_cache_map
+				[PERF_COUNT_HW_CACHE_MAX]
+				[PERF_COUNT_HW_CACHE_OP_MAX]
+				[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
+[C(L1D)] = {
+	/*
+	 * Like some other architectures (e.g. ARM), the performance
+	 * counters don't differentiate between read and write
+	 * accesses/misses, so this isn't strictly correct, but it's the
+	 * best we can do. Writes and reads get combined.
+	 */
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)]	= { 12, CNTR_EVEN, T },
+		[C(RESULT_MISS)]	= { 12, CNTR_ODD, T },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)]	= { 12, CNTR_EVEN, T },
+		[C(RESULT_MISS)]	= { 12, CNTR_ODD, T },
+	},
+},
+[C(L1I)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)]	= { 10, CNTR_EVEN, T },
+		[C(RESULT_MISS)]	= { 10, CNTR_ODD, T },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)]	= { 10, CNTR_EVEN, T },
+		[C(RESULT_MISS)]	= { 10, CNTR_ODD, T },
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)]	= { 23, CNTR_EVEN, T },
+		/*
+		 * Note that MIPS has only "hit" events countable for
+		 * the prefetch operation.
+		 */
+	},
+},
+[C(LL)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)]	= { 28, CNTR_EVEN, P },
+		[C(RESULT_MISS)]	= { 28, CNTR_ODD, P },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)]	= { 28, CNTR_EVEN, P },
+		[C(RESULT_MISS)]	= { 28, CNTR_ODD, P },
+	},
+},
+[C(BPU)] = {
+	/* Using the same code for *HW_BRANCH* */
+	[C(OP_READ)] = {
+		[C(RESULT_MISS)]	= { 0x02, CNTR_ODD, T },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_MISS)]	= { 0x02, CNTR_ODD, T },
+	},
+},
+};
+
 
 static const struct mips_perf_event octeon_cache_map
 				[PERF_COUNT_HW_CACHE_MAX]
@@ -1240,6 +1325,11 @@ static irqreturn_t mipsxx_pmu_handle_irq(int irq, void *dev)
 #define IS_RANGE_V_1004K_EVENT(r)	((r) == 47)
 #endif
 
+/* BMIPS5000 */
+#define IS_BOTH_COUNTERS_BMIPS5000_EVENT(b)				\
+	((b) == 0 || (b) == 1)
+
+
 /*
  * User can use 0-255 raw events, where 0-127 for the events of even
  * counters, and 128-255 for odd counters. Note that bit 7 is used to
@@ -1310,6 +1400,12 @@ static const struct mips_perf_event *mipsxx_pmu_map_raw_event(u64 config)
 			raw_event.range = T;
 #endif
 		break;
+	case CPU_BMIPS5000:
+		if (IS_BOTH_COUNTERS_BMIPS5000_EVENT(base_id))
+			raw_event.cntr_mask = CNTR_EVEN | CNTR_ODD;
+		else
+			raw_event.cntr_mask =
+				raw_id > 127 ? CNTR_ODD : CNTR_EVEN;
 	}
 
 	return &raw_event;
@@ -1421,6 +1517,11 @@ init_hw_perf_events(void)
 		mipspmu.cache_event_map = &octeon_cache_map;
 		mipspmu.map_raw_event = octeon_pmu_map_raw_event;
 		break;
+	case CPU_BMIPS5000:
+		mipspmu.name = "BMIPS5000";
+		mipspmu.general_event_map = &bmips5000_event_map;
+		mipspmu.cache_event_map = &bmips5000_cache_map;
+		break;
 	default:
 		pr_cont("Either hardware does not support performance "
 			"counters, or not yet implemented.\n");
-- 
1.7.6
