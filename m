Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Nov 2011 04:30:37 +0100 (CET)
Received: from dns1.mips.com ([12.201.5.69]:39657 "EHLO dns1.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903657Ab1KVD3i (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 22 Nov 2011 04:29:38 +0100
Received: from exchdb01.mips.com (exchhub01.mips.com [192.168.36.84])
        by dns1.mips.com (8.13.8/8.13.8) with ESMTP id pAM3TKmS016666;
        Mon, 21 Nov 2011 19:29:20 -0800
Received: from fun-lab.MIPSCN.CEC (192.168.225.107) by exchhub01.mips.com
 (192.168.36.84) with Microsoft SMTP Server id 14.1.270.1; Mon, 21 Nov 2011
 19:29:17 -0800
From:   Deng-Cheng Zhu <dczhu@mips.com>
To:     <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     <eyal@mips.com>, <zenon@mips.com>, Deng-Cheng Zhu <dczhu@mips.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
        Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v2 3/5] MIPS/Perf-events: Remove pmu and event state checking in validate_event()
Date:   Tue, 22 Nov 2011 11:28:47 +0800
Message-ID: <1321932528-21098-4-git-send-email-dczhu@mips.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1321932528-21098-1-git-send-email-dczhu@mips.com>
References: <1321932528-21098-1-git-send-email-dczhu@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EMS-Proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
X-EMS-STAMP: rOhD+03BTJm/WX0dZaC+sw==
X-archive-position: 31915
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dczhu@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 18208

Why removing pmu checking:
Since 3.2-rc1, when arch level event init is called, the event is already
connected to its PMU. Also, validate_event() is _only_ called by
validate_group() in event init, so there is no need of checking or
temporarily assigning event pmu during validate_group().

Why removing event state checking:
Events could be created in PERF_EVENT_STATE_OFF (attr->disabled == 1), when
these events go through this checking, validate_group() does dummy work.
But we do need to do group scheduling emulation for them in event init.
Again, validate_event() is _only_ called by validate_group().

Reference: http://www.spinics.net/lists/mips/msg42190.html
Signed-off-by: Deng-Cheng Zhu <dczhu@mips.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: David Daney <david.daney@cavium.com>
---
 arch/mips/kernel/perf_event_mipsxx.c |   18 +++---------------
 1 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index b5d6b3f..b22cc5f 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -707,18 +707,6 @@ static const struct mips_perf_event *mipspmu_map_cache_event(u64 config)
 
 }
 
-static int validate_event(struct cpu_hw_events *cpuc,
-	       struct perf_event *event)
-{
-	struct hw_perf_event fake_hwc = event->hw;
-
-	/* Allow mixed event group. So return 1 to pass validation. */
-	if (event->pmu != &pmu || event->state <= PERF_EVENT_STATE_OFF)
-		return 1;
-
-	return mipsxx_pmu_alloc_counter(cpuc, &fake_hwc) >= 0;
-}
-
 static int validate_group(struct perf_event *event)
 {
 	struct perf_event *sibling, *leader = event->group_leader;
@@ -726,15 +714,15 @@ static int validate_group(struct perf_event *event)
 
 	memset(&fake_cpuc, 0, sizeof(fake_cpuc));
 
-	if (!validate_event(&fake_cpuc, leader))
+	if (mipsxx_pmu_alloc_counter(&fake_cpuc, &leader->hw) < 0)
 		return -ENOSPC;
 
 	list_for_each_entry(sibling, &leader->sibling_list, group_entry) {
-		if (!validate_event(&fake_cpuc, sibling))
+		if (mipsxx_pmu_alloc_counter(&fake_cpuc, &sibling->hw) < 0)
 			return -ENOSPC;
 	}
 
-	if (!validate_event(&fake_cpuc, event))
+	if (mipsxx_pmu_alloc_counter(&fake_cpuc, &event->hw) < 0)
 		return -ENOSPC;
 
 	return 0;
-- 
1.7.1
