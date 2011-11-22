Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Nov 2011 04:29:38 +0100 (CET)
Received: from dns1.mips.com ([12.201.5.69]:39652 "EHLO dns1.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903703Ab1KVD3c (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 22 Nov 2011 04:29:32 +0100
Received: from exchdb01.mips.com (exchhub01.mips.com [192.168.36.84])
        by dns1.mips.com (8.13.8/8.13.8) with ESMTP id pAM3TEPJ016663;
        Mon, 21 Nov 2011 19:29:15 -0800
Received: from fun-lab.MIPSCN.CEC (192.168.225.107) by exchhub01.mips.com
 (192.168.36.84) with Microsoft SMTP Server id 14.1.270.1; Mon, 21 Nov 2011
 19:29:12 -0800
From:   Deng-Cheng Zhu <dczhu@mips.com>
To:     <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     <eyal@mips.com>, <zenon@mips.com>, Deng-Cheng Zhu <dczhu@mips.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
        Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v2 2/5] MIPS/Perf-events: Remove erroneous check on active_events
Date:   Tue, 22 Nov 2011 11:28:46 +0800
Message-ID: <1321932528-21098-3-git-send-email-dczhu@mips.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1321932528-21098-1-git-send-email-dczhu@mips.com>
References: <1321932528-21098-1-git-send-email-dczhu@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EMS-Proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
X-EMS-STAMP: kS0+e3nbwIfPYFlwEz3VUw==
X-archive-position: 31913
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dczhu@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 18205

Port the following patch for ARM by Mark Rutland:

- 57ce9bb39b476accf8fba6e16aea67ed76ea523d
    ARM: 6902/1: perf: Remove erroneous check on active_events

    When initialising a PMU, there is a check to protect against races with
    other CPUs filling all of the available event slots. Since armpmu_add
    checks that an event can be scheduled, we do not need to do this at
    initialisation time. Furthermore the current code is broken because it
    assumes that atomic_inc_not_zero will unconditionally increment
    active_counts and then tries to decrement it again on failure.

    This patch removes the broken, redundant code.

Signed-off-by: Deng-Cheng Zhu <dczhu@mips.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: David Daney <david.daney@cavium.com>
---
 arch/mips/kernel/perf_event_mipsxx.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index ab4c761..b5d6b3f 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -621,11 +621,6 @@ static int mipspmu_event_init(struct perf_event *event)
 		return -ENODEV;
 
 	if (!atomic_inc_not_zero(&active_events)) {
-		if (atomic_read(&active_events) > MIPS_MAX_HWEVENTS) {
-			atomic_dec(&active_events);
-			return -ENOSPC;
-		}
-
 		mutex_lock(&pmu_reserve_mutex);
 		if (atomic_read(&active_events) == 0)
 			err = mipspmu_get_irq();
-- 
1.7.1
