Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Feb 2014 18:49:58 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:53095 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827346AbaBJRtYxPmwF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Feb 2014 18:49:24 +0100
From:   Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     <Markos.Chandras@imgtec.com>, <james.hogan@imgtec.com>,
        <Steven.Hill@imgtec.com>, Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
Subject: [PATCH 2/3] MIPS/Perf-events: Add proAptiv support
Date:   Mon, 10 Feb 2014 09:48:53 -0800
Message-ID: <1392054534-8678-3-git-send-email-dengcheng.zhu@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1392054534-8678-1-git-send-email-dengcheng.zhu@imgtec.com>
References: <1392054534-8678-1-git-send-email-dengcheng.zhu@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.136.61]
X-SEF-Processed: 7_3_0_01192__2014_02_10_17_49_19
Return-Path: <DengCheng.Zhu@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39266
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@imgtec.com
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

From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>

Choose event/cache maps and handle raw event mapping for proAptiv. Update
code comments.

Reviewed-by: Markos Chandras <Markos.Chandras@imgtec.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
---
 arch/mips/kernel/perf_event_mipsxx.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index a3c2a71..38e8d39 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -814,7 +814,7 @@ static const struct mips_perf_event mipsxxcore_event_map
 	[PERF_COUNT_HW_BRANCH_MISSES] = { 0x02, CNTR_ODD, T },
 };
 
-/* 74K core has different branch event code. */
+/* 74K/proAptiv core has different branch event code. */
 static const struct mips_perf_event mipsxxcore_event_map2
 				[PERF_COUNT_HW_MAX] = {
 	[PERF_COUNT_HW_CPU_CYCLES] = { 0x00, CNTR_EVEN | CNTR_ODD, P },
@@ -930,7 +930,7 @@ static const struct mips_perf_event mipsxxcore_cache_map
 },
 };
 
-/* 74K core has completely different cache event map. */
+/* 74K/proAptiv core has completely different cache event map. */
 static const struct mips_perf_event mipsxxcore_cache_map2
 				[PERF_COUNT_HW_CACHE_MAX]
 				[PERF_COUNT_HW_CACHE_OP_MAX]
@@ -978,6 +978,11 @@ static const struct mips_perf_event mipsxxcore_cache_map2
 		[C(RESULT_MISS)]	= { 0x1d, CNTR_EVEN, P },
 	},
 },
+/*
+ * 74K core does not have specific DTLB events. proAptiv core has
+ * "speculative" DTLB events which are numbered 0x63 (even/odd) and
+ * not included here. One can use raw events if really needed.
+ */
 [C(ITLB)] = {
 	[C(OP_READ)] = {
 		[C(RESULT_ACCESS)]	= { 0x04, CNTR_EVEN, T },
@@ -1378,6 +1383,10 @@ static irqreturn_t mipsxx_pmu_handle_irq(int irq, void *dev)
 #define IS_BOTH_COUNTERS_74K_EVENT(b)					\
 	((b) == 0 || (b) == 1)
 
+/* proAptiv */
+#define IS_BOTH_COUNTERS_PROAPTIV_EVENT(b)				\
+	((b) == 0 || (b) == 1)
+
 /* 1004K */
 #define IS_BOTH_COUNTERS_1004K_EVENT(b)					\
 	((b) == 0 || (b) == 1 || (b) == 11)
@@ -1451,6 +1460,16 @@ static const struct mips_perf_event *mipsxx_pmu_map_raw_event(u64 config)
 		raw_event.range = P;
 #endif
 		break;
+	case CPU_PROAPTIV:
+		if (IS_BOTH_COUNTERS_PROAPTIV_EVENT(base_id))
+			raw_event.cntr_mask = CNTR_EVEN | CNTR_ODD;
+		else
+			raw_event.cntr_mask =
+				raw_id > 127 ? CNTR_ODD : CNTR_EVEN;
+#ifdef CONFIG_MIPS_MT_SMP
+		raw_event.range = P;
+#endif
+		break;
 	case CPU_1004K:
 		if (IS_BOTH_COUNTERS_1004K_EVENT(base_id))
 			raw_event.cntr_mask = CNTR_EVEN | CNTR_ODD;
@@ -1579,6 +1598,11 @@ init_hw_perf_events(void)
 		mipspmu.general_event_map = &mipsxxcore_event_map2;
 		mipspmu.cache_event_map = &mipsxxcore_cache_map2;
 		break;
+	case CPU_PROAPTIV:
+		mipspmu.name = "mips/proAptiv";
+		mipspmu.general_event_map = &mipsxxcore_event_map2;
+		mipspmu.cache_event_map = &mipsxxcore_cache_map2;
+		break;
 	case CPU_1004K:
 		mipspmu.name = "mips/1004K";
 		mipspmu.general_event_map = &mipsxxcore_event_map;
-- 
1.8.5.3
