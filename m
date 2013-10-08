Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Oct 2013 17:18:06 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:2025 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822674Ab3JHPSDdU1tA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Oct 2013 17:18:03 +0200
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH] MIPS/Perf-events: Fix 74K cache map
Date:   Tue, 8 Oct 2013 16:17:48 +0100
Message-ID: <1381245468-1726-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.3.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.31]
X-SEF-Processed: 7_3_0_01192__2013_10_08_16_17_58
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38273
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

According to Software User's Manual, the event of last-level-cache
read/write misses is mapped to even counters. Odd counters of that
event number count miss cycles.

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
This patch is for the upstream-sfr/mips-for-linux-next tree
---
 arch/mips/kernel/perf_event_mipsxx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index 45f1ffc..24cdf64 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -971,11 +971,11 @@ static const struct mips_perf_event mipsxx74Kcore_cache_map
 [C(LL)] = {
 	[C(OP_READ)] = {
 		[C(RESULT_ACCESS)]	= { 0x1c, CNTR_ODD, P },
-		[C(RESULT_MISS)]	= { 0x1d, CNTR_EVEN | CNTR_ODD, P },
+		[C(RESULT_MISS)]	= { 0x1d, CNTR_EVEN, P },
 	},
 	[C(OP_WRITE)] = {
 		[C(RESULT_ACCESS)]	= { 0x1c, CNTR_ODD, P },
-		[C(RESULT_MISS)]	= { 0x1d, CNTR_EVEN | CNTR_ODD, P },
+		[C(RESULT_MISS)]	= { 0x1d, CNTR_EVEN, P },
 	},
 },
 [C(ITLB)] = {
-- 
1.8.3.2
