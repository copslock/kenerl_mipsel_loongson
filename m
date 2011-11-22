Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Nov 2011 04:30:11 +0100 (CET)
Received: from dns1.mips.com ([12.201.5.69]:39653 "EHLO dns1.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903704Ab1KVD3d (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 22 Nov 2011 04:29:33 +0100
Received: from exchdb01.mips.com (exchhub01.mips.com [192.168.36.84])
        by dns1.mips.com (8.13.8/8.13.8) with ESMTP id pAM3T4dR016657;
        Mon, 21 Nov 2011 19:29:09 -0800
Received: from fun-lab.MIPSCN.CEC (192.168.225.107) by exchhub01.mips.com
 (192.168.36.84) with Microsoft SMTP Server id 14.1.270.1; Mon, 21 Nov 2011
 19:29:02 -0800
From:   Deng-Cheng Zhu <dczhu@mips.com>
To:     <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     <eyal@mips.com>, <zenon@mips.com>, Deng-Cheng Zhu <dczhu@mips.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
        Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v2 1/5] MIPS/Perf-events: Don't do validation on raw events
Date:   Tue, 22 Nov 2011 11:28:45 +0800
Message-ID: <1321932528-21098-2-git-send-email-dczhu@mips.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1321932528-21098-1-git-send-email-dczhu@mips.com>
References: <1321932528-21098-1-git-send-email-dczhu@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EMS-Proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
X-EMS-STAMP: EMr+NMSPX8g24NSf5eqJDQ==
X-archive-position: 31914
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dczhu@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 18206

MIPS licensees may want to modify performance counters to count extra
events. Also, now that the user is working on raw events, the manual is
being used for sure. And feeding unsupported events shouldn't cause
hardware failure and the like.

Signed-off-by: Deng-Cheng Zhu <dczhu@mips.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: David Daney <david.daney@cavium.com>
---
 arch/mips/kernel/perf_event_mipsxx.c |   34 ++--------------------------------
 1 files changed, 2 insertions(+), 32 deletions(-)

diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index 4f2971b..ab4c761 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -1380,20 +1380,10 @@ static irqreturn_t mipsxx_pmu_handle_irq(int irq, void *dev)
 }
 
 /* 24K */
-#define IS_UNSUPPORTED_24K_EVENT(r, b)					\
-	((b) == 12 || (r) == 151 || (r) == 152 || (b) == 26 ||		\
-	 (b) == 27 || (r) == 28 || (r) == 158 || (b) == 31 ||		\
-	 (b) == 32 || (b) == 34 || (b) == 36 || (r) == 168 ||		\
-	 (r) == 172 || (b) == 47 || ((b) >= 56 && (b) <= 63) ||		\
-	 ((b) >= 68 && (b) <= 127))
 #define IS_BOTH_COUNTERS_24K_EVENT(b)					\
 	((b) == 0 || (b) == 1 || (b) == 11)
 
 /* 34K */
-#define IS_UNSUPPORTED_34K_EVENT(r, b)					\
-	((b) == 12 || (r) == 27 || (r) == 158 || (b) == 36 ||		\
-	 (b) == 38 || (r) == 175 || ((b) >= 56 && (b) <= 63) ||		\
-	 ((b) >= 68 && (b) <= 127))
 #define IS_BOTH_COUNTERS_34K_EVENT(b)					\
 	((b) == 0 || (b) == 1 || (b) == 11)
 #ifdef CONFIG_MIPS_MT_SMP
@@ -1406,20 +1396,10 @@ static irqreturn_t mipsxx_pmu_handle_irq(int irq, void *dev)
 #endif
 
 /* 74K */
-#define IS_UNSUPPORTED_74K_EVENT(r, b)					\
-	((r) == 5 || ((r) >= 135 && (r) <= 137) ||			\
-	 ((b) >= 10 && (b) <= 12) || (b) == 22 || (b) == 27 ||		\
-	 (b) == 33 || (b) == 34 || ((b) >= 47 && (b) <= 49) ||		\
-	 (r) == 178 || (b) == 55 || (b) == 57 || (b) == 60 ||		\
-	 (b) == 61 || (r) == 62 || (r) == 191 ||			\
-	 ((b) >= 64 && (b) <= 127))
 #define IS_BOTH_COUNTERS_74K_EVENT(b)					\
 	((b) == 0 || (b) == 1)
 
 /* 1004K */
-#define IS_UNSUPPORTED_1004K_EVENT(r, b)				\
-	((b) == 12 || (r) == 27 || (r) == 158 || (b) == 38 ||		\
-	 (r) == 175 || (b) == 63 || ((b) >= 68 && (b) <= 127))
 #define IS_BOTH_COUNTERS_1004K_EVENT(b)					\
 	((b) == 0 || (b) == 1 || (b) == 11)
 #ifdef CONFIG_MIPS_MT_SMP
@@ -1445,11 +1425,10 @@ static const struct mips_perf_event *mipsxx_pmu_map_raw_event(u64 config)
 	unsigned int raw_id = config & 0xff;
 	unsigned int base_id = raw_id & 0x7f;
 
+	raw_event.event_id = base_id;
+
 	switch (current_cpu_type()) {
 	case CPU_24K:
-		if (IS_UNSUPPORTED_24K_EVENT(raw_id, base_id))
-			return ERR_PTR(-EOPNOTSUPP);
-		raw_event.event_id = base_id;
 		if (IS_BOTH_COUNTERS_24K_EVENT(base_id))
 			raw_event.cntr_mask = CNTR_EVEN | CNTR_ODD;
 		else
@@ -1464,9 +1443,6 @@ static const struct mips_perf_event *mipsxx_pmu_map_raw_event(u64 config)
 #endif
 		break;
 	case CPU_34K:
-		if (IS_UNSUPPORTED_34K_EVENT(raw_id, base_id))
-			return ERR_PTR(-EOPNOTSUPP);
-		raw_event.event_id = base_id;
 		if (IS_BOTH_COUNTERS_34K_EVENT(base_id))
 			raw_event.cntr_mask = CNTR_EVEN | CNTR_ODD;
 		else
@@ -1482,9 +1458,6 @@ static const struct mips_perf_event *mipsxx_pmu_map_raw_event(u64 config)
 #endif
 		break;
 	case CPU_74K:
-		if (IS_UNSUPPORTED_74K_EVENT(raw_id, base_id))
-			return ERR_PTR(-EOPNOTSUPP);
-		raw_event.event_id = base_id;
 		if (IS_BOTH_COUNTERS_74K_EVENT(base_id))
 			raw_event.cntr_mask = CNTR_EVEN | CNTR_ODD;
 		else
@@ -1495,9 +1468,6 @@ static const struct mips_perf_event *mipsxx_pmu_map_raw_event(u64 config)
 #endif
 		break;
 	case CPU_1004K:
-		if (IS_UNSUPPORTED_1004K_EVENT(raw_id, base_id))
-			return ERR_PTR(-EOPNOTSUPP);
-		raw_event.event_id = base_id;
 		if (IS_BOTH_COUNTERS_1004K_EVENT(base_id))
 			raw_event.cntr_mask = CNTR_EVEN | CNTR_ODD;
 		else
-- 
1.7.1
