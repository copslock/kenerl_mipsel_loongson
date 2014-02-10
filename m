Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Feb 2014 18:50:17 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:53096 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827348AbaBJRt2CKjRb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Feb 2014 18:49:28 +0100
From:   Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     <Markos.Chandras@imgtec.com>, <james.hogan@imgtec.com>,
        <Steven.Hill@imgtec.com>, Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
Subject: [PATCH 3/3] MIPS/Perf-events: Add interAptiv support
Date:   Mon, 10 Feb 2014 09:48:54 -0800
Message-ID: <1392054534-8678-4-git-send-email-dengcheng.zhu@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1392054534-8678-1-git-send-email-dengcheng.zhu@imgtec.com>
References: <1392054534-8678-1-git-send-email-dengcheng.zhu@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.136.61]
X-SEF-Processed: 7_3_0_01192__2014_02_10_17_49_22
Return-Path: <DengCheng.Zhu@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39267
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

Choose event/cache maps and handle raw event mapping for interAptiv. Update
code comments.

Reviewed-by: Markos Chandras <Markos.Chandras@imgtec.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
---
 arch/mips/kernel/perf_event_mipsxx.c | 38 ++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index 38e8d39..1c22aba 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -805,7 +805,7 @@ static void reset_counters(void *arg)
 	}
 }
 
-/* 24K/34K/1004K cores can share the same event map. */
+/* 24K/34K/1004K/interAptiv/loongson1 cores share the same event map. */
 static const struct mips_perf_event mipsxxcore_event_map
 				[PERF_COUNT_HW_MAX] = {
 	[PERF_COUNT_HW_CPU_CYCLES] = { 0x00, CNTR_EVEN | CNTR_ODD, P },
@@ -849,7 +849,7 @@ static const struct mips_perf_event xlp_event_map[PERF_COUNT_HW_MAX] = {
 	[PERF_COUNT_HW_BRANCH_MISSES] = { 0x1c, CNTR_ALL }, /* PAPI_BR_MSP */
 };
 
-/* 24K/34K/1004K cores can share the same cache event map. */
+/* 24K/34K/1004K/interAptiv/loongson1 cores share the same cache event map. */
 static const struct mips_perf_event mipsxxcore_cache_map
 				[PERF_COUNT_HW_CACHE_MAX]
 				[PERF_COUNT_HW_CACHE_OP_MAX]
@@ -1400,6 +1400,20 @@ static irqreturn_t mipsxx_pmu_handle_irq(int irq, void *dev)
 #define IS_RANGE_V_1004K_EVENT(r)	((r) == 47)
 #endif
 
+/* interAptiv */
+#define IS_BOTH_COUNTERS_INTERAPTIV_EVENT(b)				\
+	((b) == 0 || (b) == 1 || (b) == 11)
+#ifdef CONFIG_MIPS_MT_SMP
+/* The P/V/T info is not provided for "(b) == 38" in SUM, assume P. */
+#define IS_RANGE_P_INTERAPTIV_EVENT(r, b)				\
+	((b) == 0 || (r) == 18 || (b) == 21 || (b) == 22 ||		\
+	 (b) == 25 || (b) == 36 || (b) == 38 || (b) == 39 ||		\
+	 (r) == 44 || (r) == 174 || (r) == 176 || ((b) >= 50 &&		\
+	 (b) <= 59) || (r) == 188 || (b) == 61 || (b) == 62 ||		\
+	 ((b) >= 64 && (b) <= 67))
+#define IS_RANGE_V_INTERAPTIV_EVENT(r)	((r) == 47 || (r) == 175)
+#endif
+
 /* BMIPS5000 */
 #define IS_BOTH_COUNTERS_BMIPS5000_EVENT(b)				\
 	((b) == 0 || (b) == 1)
@@ -1485,6 +1499,21 @@ static const struct mips_perf_event *mipsxx_pmu_map_raw_event(u64 config)
 			raw_event.range = T;
 #endif
 		break;
+	case CPU_INTERAPTIV:
+		if (IS_BOTH_COUNTERS_INTERAPTIV_EVENT(base_id))
+			raw_event.cntr_mask = CNTR_EVEN | CNTR_ODD;
+		else
+			raw_event.cntr_mask =
+				raw_id > 127 ? CNTR_ODD : CNTR_EVEN;
+#ifdef CONFIG_MIPS_MT_SMP
+		if (IS_RANGE_P_INTERAPTIV_EVENT(raw_id, base_id))
+			raw_event.range = P;
+		else if (unlikely(IS_RANGE_V_INTERAPTIV_EVENT(raw_id)))
+			raw_event.range = V;
+		else
+			raw_event.range = T;
+#endif
+		break;
 	case CPU_BMIPS5000:
 		if (IS_BOTH_COUNTERS_BMIPS5000_EVENT(base_id))
 			raw_event.cntr_mask = CNTR_EVEN | CNTR_ODD;
@@ -1608,6 +1637,11 @@ init_hw_perf_events(void)
 		mipspmu.general_event_map = &mipsxxcore_event_map;
 		mipspmu.cache_event_map = &mipsxxcore_cache_map;
 		break;
+	case CPU_INTERAPTIV:
+		mipspmu.name = "mips/interAptiv";
+		mipspmu.general_event_map = &mipsxxcore_event_map;
+		mipspmu.cache_event_map = &mipsxxcore_cache_map;
+		break;
 	case CPU_LOONGSON1:
 		mipspmu.name = "mips/loongson1";
 		mipspmu.general_event_map = &mipsxxcore_event_map;
-- 
1.8.5.3
