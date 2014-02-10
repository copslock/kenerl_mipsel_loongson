Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Feb 2014 18:49:39 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:53093 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827344AbaBJRtWItuFS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Feb 2014 18:49:22 +0100
From:   Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     <Markos.Chandras@imgtec.com>, <james.hogan@imgtec.com>,
        <Steven.Hill@imgtec.com>, Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
Subject: [PATCH 1/3] MIPS/Perf-events: Rename 74K event/cache maps in preparation for Aptiv support
Date:   Mon, 10 Feb 2014 09:48:52 -0800
Message-ID: <1392054534-8678-2-git-send-email-dengcheng.zhu@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1392054534-8678-1-git-send-email-dengcheng.zhu@imgtec.com>
References: <1392054534-8678-1-git-send-email-dengcheng.zhu@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.136.61]
X-SEF-Processed: 7_3_0_01192__2014_02_10_17_49_16
Return-Path: <DengCheng.Zhu@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39265
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

74K/proAptiv share the same event/cache maps. So it's better to change the
names of the existing mipsxx74Kcore_[event|cache]_map.

Reviewed-by: Markos Chandras <Markos.Chandras@imgtec.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
---
 arch/mips/kernel/perf_event_mipsxx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index 24cdf64..a3c2a71 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -815,7 +815,7 @@ static const struct mips_perf_event mipsxxcore_event_map
 };
 
 /* 74K core has different branch event code. */
-static const struct mips_perf_event mipsxx74Kcore_event_map
+static const struct mips_perf_event mipsxxcore_event_map2
 				[PERF_COUNT_HW_MAX] = {
 	[PERF_COUNT_HW_CPU_CYCLES] = { 0x00, CNTR_EVEN | CNTR_ODD, P },
 	[PERF_COUNT_HW_INSTRUCTIONS] = { 0x01, CNTR_EVEN | CNTR_ODD, T },
@@ -931,7 +931,7 @@ static const struct mips_perf_event mipsxxcore_cache_map
 };
 
 /* 74K core has completely different cache event map. */
-static const struct mips_perf_event mipsxx74Kcore_cache_map
+static const struct mips_perf_event mipsxxcore_cache_map2
 				[PERF_COUNT_HW_CACHE_MAX]
 				[PERF_COUNT_HW_CACHE_OP_MAX]
 				[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
@@ -1576,8 +1576,8 @@ init_hw_perf_events(void)
 		break;
 	case CPU_74K:
 		mipspmu.name = "mips/74K";
-		mipspmu.general_event_map = &mipsxx74Kcore_event_map;
-		mipspmu.cache_event_map = &mipsxx74Kcore_cache_map;
+		mipspmu.general_event_map = &mipsxxcore_event_map2;
+		mipspmu.cache_event_map = &mipsxxcore_cache_map2;
 		break;
 	case CPU_1004K:
 		mipspmu.name = "mips/1004K";
-- 
1.8.5.3
