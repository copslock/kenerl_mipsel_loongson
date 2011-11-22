Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Nov 2011 04:31:00 +0100 (CET)
Received: from dns1.mips.com ([12.201.5.69]:39660 "EHLO dns1.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903706Ab1KVD3j (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 22 Nov 2011 04:29:39 +0100
Received: from exchdb01.mips.com (exchhub01.mips.com [192.168.36.84])
        by dns1.mips.com (8.13.8/8.13.8) with ESMTP id pAM3TPst016670;
        Mon, 21 Nov 2011 19:29:25 -0800
Received: from fun-lab.MIPSCN.CEC (192.168.225.107) by exchhub01.mips.com
 (192.168.36.84) with Microsoft SMTP Server id 14.1.270.1; Mon, 21 Nov 2011
 19:29:22 -0800
From:   Deng-Cheng Zhu <dczhu@mips.com>
To:     <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     <eyal@mips.com>, <zenon@mips.com>, Deng-Cheng Zhu <dczhu@mips.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
        Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v2 4/5] MIPS/Perf-events: Cleanup event->destroy at event init
Date:   Tue, 22 Nov 2011 11:28:48 +0800
Message-ID: <1321932528-21098-5-git-send-email-dczhu@mips.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1321932528-21098-1-git-send-email-dczhu@mips.com>
References: <1321932528-21098-1-git-send-email-dczhu@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EMS-Proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
X-EMS-STAMP: oqdXS1Q72LVU8sWHXdcfgw==
X-archive-position: 31916
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dczhu@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 18209

Simplify the code by changing the place of event->destroy().

Signed-off-by: Deng-Cheng Zhu <dczhu@mips.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: David Daney <david.daney@cavium.com>
---
 arch/mips/kernel/perf_event_mipsxx.c |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index b22cc5f..bda4bc9 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -633,11 +633,7 @@ static int mipspmu_event_init(struct perf_event *event)
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
@@ -1262,13 +1258,14 @@ static int __hw_perf_event_init(struct perf_event *event)
 	}
 
 	err = 0;
-	if (event->group_leader != event) {
+	if (event->group_leader != event)
 		err = validate_group(event);
-		if (err)
-			return -EINVAL;
-	}
 
 	event->destroy = hw_perf_event_destroy;
+
+	if (err)
+		event->destroy(event);
+
 	return err;
 }
 
-- 
1.7.1
