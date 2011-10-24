Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Oct 2011 12:57:43 +0200 (CEST)
Received: from dns1.mips.com ([12.201.5.69]:55744 "EHLO dns1.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491071Ab1JXK5L (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 24 Oct 2011 12:57:11 +0200
Received: from exchdb01.mips.com (exchhub01.mips.com [192.168.36.84])
        by dns1.mips.com (8.13.8/8.13.8) with ESMTP id p9OAuiwU011259;
        Mon, 24 Oct 2011 03:56:44 -0700
Received: from fun-lab.MIPSCN.CEC (192.168.225.107) by exchhub01.mips.com
 (192.168.36.84) with Microsoft SMTP Server id 14.1.270.1; Mon, 24 Oct 2011
 03:56:40 -0700
From:   Deng-Cheng Zhu <dczhu@mips.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
CC:     Deng-Cheng Zhu <dczhu@mips.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
        Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 3/4] MIPS/Perf-events: temporarily connect event to its pmu at event init
Date:   Mon, 24 Oct 2011 18:56:01 +0800
Message-ID: <1319453762-12962-4-git-send-email-dczhu@mips.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1319453762-12962-1-git-send-email-dczhu@mips.com>
References: <1319453762-12962-1-git-send-email-dczhu@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EMS-Proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
X-EMS-STAMP: Hcjd1XzbaSuHI/Ei/zvPaA==
X-archive-position: 31288
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dczhu@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17069

When arch level event init is called, the event is not yet connected to
the PMU, thereby causing validate_group() to always do dummy work. On MIPS,
this is due to the following lines in validate_event() called by
validate_group():

if (event->pmu != &pmu || event->state <= PERF_EVENT_STATE_OFF)
        return 1;

This patch fixes it.

Signed-off-by: Deng-Cheng Zhu <dczhu@mips.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: David Daney <david.daney@cavium.com>
---
 arch/mips/kernel/perf_event_mipsxx.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index 1f654ca..c804fdd 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -548,6 +548,7 @@ static int __hw_perf_event_init(struct perf_event *event)
 	struct perf_event_attr *attr = &event->attr;
 	struct hw_perf_event *hwc = &event->hw;
 	const struct mips_perf_event *pev;
+	struct pmu *tmp;
 	int err;
 
 	/* Returning MIPS event descriptor for generic perf event. */
@@ -611,11 +612,19 @@ static int __hw_perf_event_init(struct perf_event *event)
 	}
 
 	err = 0;
-	if (event->group_leader != event) {
+
+	/*
+	 * we temporarily connect event to its pmu such that
+	 * validate_event() in validate_group() can classify
+	 * it as a MIPS event by passing (event->pmu == &pmu).
+	 */
+	tmp = event->pmu;
+	event->pmu = &pmu;
+
+	if (event->group_leader != event)
 		err = validate_group(event);
-		if (err)
-			return -EINVAL;
-	}
+
+	event->pmu = tmp;
 
 	event->destroy = hw_perf_event_destroy;
 
-- 
1.7.1
