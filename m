Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Oct 2011 12:57:16 +0200 (CEST)
Received: from dns1.mips.com ([12.201.5.69]:55740 "EHLO dns1.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491062Ab1JXK5I (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 24 Oct 2011 12:57:08 +0200
Received: from exchdb01.mips.com (exchhub01.mips.com [192.168.36.84])
        by dns1.mips.com (8.13.8/8.13.8) with ESMTP id p9OAuY7m011253;
        Mon, 24 Oct 2011 03:56:34 -0700
Received: from fun-lab.MIPSCN.CEC (192.168.225.107) by exchhub01.mips.com
 (192.168.36.84) with Microsoft SMTP Server id 14.1.270.1; Mon, 24 Oct 2011
 03:56:28 -0700
From:   Deng-Cheng Zhu <dczhu@mips.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
CC:     Deng-Cheng Zhu <dczhu@mips.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
        Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 1/4] MIPS/Perf-events: update the map of unsupported events for 74K
Date:   Mon, 24 Oct 2011 18:55:59 +0800
Message-ID: <1319453762-12962-2-git-send-email-dczhu@mips.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1319453762-12962-1-git-send-email-dczhu@mips.com>
References: <1319453762-12962-1-git-send-email-dczhu@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EMS-Proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
X-EMS-STAMP: QsNynZnxbdKJqUDW64uqKg==
X-archive-position: 31287
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dczhu@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17068

Update the raw event info for 74K according to the latest document.

Signed-off-by: Deng-Cheng Zhu <dczhu@mips.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: David Daney <david.daney@cavium.com>
---
 arch/mips/kernel/perf_event_mipsxx.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index e5ad09a..1f654ca 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -858,13 +858,16 @@ mipsxx_pmu_disable_event(int idx)
 #endif
 
 /* 74K */
+/*
+ * MIPS document MD00519 (MIPS32(r) 74K(tm) Processor Core Family Software
+ * User's Manual, Revision 01.05)
+ */
 #define IS_UNSUPPORTED_74K_EVENT(r, b)					\
-	((r) == 5 || ((r) >= 135 && (r) <= 137) ||			\
-	 ((b) >= 10 && (b) <= 12) || (b) == 22 || (b) == 27 ||		\
-	 (b) == 33 || (b) == 34 || ((b) >= 47 && (b) <= 49) ||		\
-	 (r) == 178 || (b) == 55 || (b) == 57 || (b) == 60 ||		\
-	 (b) == 61 || (r) == 62 || (r) == 191 ||			\
-	 ((b) >= 64 && (b) <= 127))
+	((r) == 5 || (r) == 135 || ((b) >= 10 && (b) <= 12) ||		\
+	 (b) == 27 || (b) == 33 || (b) == 34 || (b) == 47 ||		\
+	 (b) == 48 || (r) == 178 || (r) == 187 || (b) == 60 ||		\
+	 (b) == 61 || (r) == 191 || (r) == 71 || (r) == 72 ||		\
+	 (b) == 73 || ((b) >= 77 && (b) <= 127))
 #define IS_BOTH_COUNTERS_74K_EVENT(b)					\
 	((b) == 0 || (b) == 1)
 
-- 
1.7.1
