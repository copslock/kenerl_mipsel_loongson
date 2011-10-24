Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Oct 2011 12:58:32 +0200 (CEST)
Received: from dns1.mips.com ([12.201.5.69]:55750 "EHLO dns1.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491079Ab1JXK5R (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 24 Oct 2011 12:57:17 +0200
Received: from exchdb01.mips.com (exchhub01.mips.com [192.168.36.84])
        by dns1.mips.com (8.13.8/8.13.8) with ESMTP id p9OAunYc011262;
        Mon, 24 Oct 2011 03:56:49 -0700
Received: from fun-lab.MIPSCN.CEC (192.168.225.107) by exchhub01.mips.com
 (192.168.36.84) with Microsoft SMTP Server id 14.1.270.1; Mon, 24 Oct 2011
 03:56:45 -0700
From:   Deng-Cheng Zhu <dczhu@mips.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
CC:     Deng-Cheng Zhu <dczhu@mips.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
        Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 4/4] MIPS/Perf-events: Cleanup event->destroy at event init
Date:   Mon, 24 Oct 2011 18:56:02 +0800
Message-ID: <1319453762-12962-5-git-send-email-dczhu@mips.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1319453762-12962-1-git-send-email-dczhu@mips.com>
References: <1319453762-12962-1-git-send-email-dczhu@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EMS-Proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
X-EMS-STAMP: iG6TO23lkVVXFgbMYlS21A==
X-archive-position: 31290
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dczhu@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17073

Simplify the code by changing the place of event->destroy().

Signed-off-by: Deng-Cheng Zhu <dczhu@mips.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: David Daney <david.daney@cavium.com>
---
 arch/mips/kernel/perf_event.c        |    6 +-----
 arch/mips/kernel/perf_event_mipsxx.c |    3 +++
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/perf_event.c b/arch/mips/kernel/perf_event.c
index b1d51b5..7a8d0a0 100644
--- a/arch/mips/kernel/perf_event.c
+++ b/arch/mips/kernel/perf_event.c
@@ -397,11 +397,7 @@ static int mipspmu_event_init(struct perf_event *event)
 	if (err)
 		return err;
 
-	err = __hw_perf_event_init(event);
-	if (err)
-		hw_perf_event_destroy(event);
-
-	return err;
+	return __hw_perf_event_init(event);
 }
 
 static struct pmu pmu = {
diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index c804fdd..bd75473 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -628,6 +628,9 @@ static int __hw_perf_event_init(struct perf_event *event)
 
 	event->destroy = hw_perf_event_destroy;
 
+	if (err)
+		event->destroy(event);
+
 	return err;
 }
 
-- 
1.7.1
