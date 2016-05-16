Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 May 2016 20:32:51 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:46302 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27029297AbcEPSctrV2J5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 May 2016 20:32:49 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id 958FC19BD72E1;
        Mon, 16 May 2016 19:32:38 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Mon, 16 May 2016 19:32:42 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Mon, 16 May 2016 19:32:42 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] MIPS: perf: Fix I6400 event numbers
Date:   Mon, 16 May 2016 19:32:35 +0100
Message-ID: <1463423555-5184-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53466
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Fix perf hardware performance counter event numbers for I6400. This core
does not follow the performance event numbering scheme of previous MIPS
cores. All performance counters (both odd and even) are capable of
counting any of the available events.

Fixes: 4e88a8621301 ("MIPS: Add cases for CPU_I6400")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 arch/mips/kernel/perf_event_mipsxx.c | 54 ++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index 9bc1191b1ab0..d1d17d99a830 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -825,6 +825,16 @@ static const struct mips_perf_event mipsxxcore_event_map2
 	[PERF_COUNT_HW_BRANCH_MISSES] = { 0x27, CNTR_ODD, T },
 };
 
+static const struct mips_perf_event i6400_event_map[PERF_COUNT_HW_MAX] = {
+	[PERF_COUNT_HW_CPU_CYCLES]          = { 0x00, CNTR_EVEN | CNTR_ODD },
+	[PERF_COUNT_HW_INSTRUCTIONS]        = { 0x01, CNTR_EVEN | CNTR_ODD },
+	/* These only count dcache, not icache */
+	[PERF_COUNT_HW_CACHE_REFERENCES]    = { 0x45, CNTR_EVEN | CNTR_ODD },
+	[PERF_COUNT_HW_CACHE_MISSES]        = { 0x48, CNTR_EVEN | CNTR_ODD },
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = { 0x15, CNTR_EVEN | CNTR_ODD },
+	[PERF_COUNT_HW_BRANCH_MISSES]       = { 0x16, CNTR_EVEN | CNTR_ODD },
+};
+
 static const struct mips_perf_event loongson3_event_map[PERF_COUNT_HW_MAX] = {
 	[PERF_COUNT_HW_CPU_CYCLES] = { 0x00, CNTR_EVEN },
 	[PERF_COUNT_HW_INSTRUCTIONS] = { 0x00, CNTR_ODD },
@@ -1015,6 +1025,46 @@ static const struct mips_perf_event mipsxxcore_cache_map2
 },
 };
 
+static const struct mips_perf_event i6400_cache_map
+				[PERF_COUNT_HW_CACHE_MAX]
+				[PERF_COUNT_HW_CACHE_OP_MAX]
+				[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
+[C(L1D)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)]	= { 0x46, CNTR_EVEN | CNTR_ODD },
+		[C(RESULT_MISS)]	= { 0x49, CNTR_EVEN | CNTR_ODD },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)]	= { 0x47, CNTR_EVEN | CNTR_ODD },
+		[C(RESULT_MISS)]	= { 0x4a, CNTR_EVEN | CNTR_ODD },
+	},
+},
+[C(L1I)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)]	= { 0x84, CNTR_EVEN | CNTR_ODD },
+		[C(RESULT_MISS)]	= { 0x85, CNTR_EVEN | CNTR_ODD },
+	},
+},
+[C(DTLB)] = {
+	/* Can't distinguish read & write */
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)]	= { 0x40, CNTR_EVEN | CNTR_ODD },
+		[C(RESULT_MISS)]	= { 0x41, CNTR_EVEN | CNTR_ODD },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)]	= { 0x40, CNTR_EVEN | CNTR_ODD },
+		[C(RESULT_MISS)]	= { 0x41, CNTR_EVEN | CNTR_ODD },
+	},
+},
+[C(BPU)] = {
+	/* Conditional branches / mispredicted */
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)]	= { 0x15, CNTR_EVEN | CNTR_ODD },
+		[C(RESULT_MISS)]	= { 0x16, CNTR_EVEN | CNTR_ODD },
+	},
+},
+};
+
 static const struct mips_perf_event loongson3_cache_map
 				[PERF_COUNT_HW_CACHE_MAX]
 				[PERF_COUNT_HW_CACHE_OP_MAX]
@@ -1720,8 +1770,8 @@ init_hw_perf_events(void)
 		break;
 	case CPU_I6400:
 		mipspmu.name = "mips/I6400";
-		mipspmu.general_event_map = &mipsxxcore_event_map2;
-		mipspmu.cache_event_map = &mipsxxcore_cache_map2;
+		mipspmu.general_event_map = &i6400_event_map;
+		mipspmu.cache_event_map = &i6400_cache_map;
 		break;
 	case CPU_1004K:
 		mipspmu.name = "mips/1004K";
-- 
2.4.10
