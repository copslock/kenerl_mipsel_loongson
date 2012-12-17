Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Dec 2012 08:26:30 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:61799 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816671Ab2LQH03uWmQr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Dec 2012 08:26:29 +0100
Received: by mail-bk0-f49.google.com with SMTP id jm19so2465762bkc.36
        for <multiple recipients>; Sun, 16 Dec 2012 23:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=ItrBgqnjIyPlHpvNnhMCeNerYfVRaHaSgaydA8+Hj4I=;
        b=Q6EcymrKnlEfVJfUJSsFqB+w1d2jU85IEr+oFNqqe7PGvhcihR6bAwqURq+kJe0wf9
         oTfjQ1uhoeqXicOxwsBkurIzGTTn6Gg6Vj6tRXdueIAfsmfd9xASgONc0SurwobdVsR/
         G+8mCnvkJFwptr6oVfT/leCGmH+YsVr0wAlkOfUj3s33W5viQsW19zIlcNtjx9va3hT6
         vIatobzHZag+vKz5dp5XaKmuz+S4ksxn17ZlqaNoyzEqdTiUBEnjxBLyD6DnBUxXLlU8
         p0z5PKz031LCMHqzIZFQKpFw1PSfrGG/2DONyKmQT4gbyjfe36XiQu3LkLXnIc7/YTo/
         gNRQ==
Received: by 10.204.146.6 with SMTP id f6mr5373172bkv.69.1355729184487;
        Sun, 16 Dec 2012 23:26:24 -0800 (PST)
Received: from flagship.roarinelk.net (178-191-3-232.adsl.highway.telekom.at. [178.191.3.232])
        by mx.google.com with ESMTPS id i20sm8369277bkw.5.2012.12.16.23.26.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 16 Dec 2012 23:26:23 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Zi Shen Lim <zlim@netlogicmicro.com>,
        Jayachandran C <jchandra@broadcom.com>
Subject: [PATCH v2] MIPS: perf: fix build failure in XLP perf support.
Date:   Mon, 17 Dec 2012 08:26:19 +0100
Message-Id: <1355729179-5442-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.8.0.2
X-archive-position: 35301
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Commit 4be3d2f3966b9f010bb997dcab25e7af489a841e ("MIPS: perf: Add
XLP support for hardware perf.") added UNSUPPORTED_PERF_EVENT_ID
which was removed a while back.

Cc: Zi Shen Lim <zlim@netlogicmicro.com>
Cc: Jayachandran C <jchandra@broadcom.com>
Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
v2: one escaped me and I left the array in a bad state. Now fixed and compile tested!

Against Linus' latest -git.  That's also where the commit-id is from.

 arch/mips/kernel/perf_event_mipsxx.c | 38 ------------------------------------
 1 file changed, 38 deletions(-)

diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index b14c14d..d9c81c5 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -847,7 +847,6 @@ static const struct mips_perf_event xlp_event_map[PERF_COUNT_HW_MAX] = {
 	[PERF_COUNT_HW_CACHE_MISSES] = { 0x07, CNTR_ALL }, /* PAPI_L1_ICM */
 	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = { 0x1b, CNTR_ALL }, /* PAPI_BR_CN */
 	[PERF_COUNT_HW_BRANCH_MISSES] = { 0x1c, CNTR_ALL }, /* PAPI_BR_MSP */
-	[PERF_COUNT_HW_BUS_CYCLES] = { UNSUPPORTED_PERF_EVENT_ID },
 };
 
 /* 24K/34K/1004K cores can share the same cache event map. */
@@ -1115,24 +1114,12 @@ static const struct mips_perf_event xlp_cache_map
 		[C(RESULT_ACCESS)]	= { 0x2f, CNTR_ALL }, /* PAPI_L1_DCW */
 		[C(RESULT_MISS)]	= { 0x2e, CNTR_ALL }, /* PAPI_L1_STM */
 	},
-	[C(OP_PREFETCH)] = {
-		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
-		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
-	},
 },
 [C(L1I)] = {
 	[C(OP_READ)] = {
 		[C(RESULT_ACCESS)]	= { 0x04, CNTR_ALL }, /* PAPI_L1_ICA */
 		[C(RESULT_MISS)]	= { 0x07, CNTR_ALL }, /* PAPI_L1_ICM */
 	},
-	[C(OP_WRITE)] = {
-		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
-		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
-	},
-	[C(OP_PREFETCH)] = {
-		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
-		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
-	},
 },
 [C(LL)] = {
 	[C(OP_READ)] = {
@@ -1143,10 +1130,6 @@ static const struct mips_perf_event xlp_cache_map
 		[C(RESULT_ACCESS)]	= { 0x34, CNTR_ALL }, /* PAPI_L2_DCA */
 		[C(RESULT_MISS)]	= { 0x36, CNTR_ALL }, /* PAPI_L2_DCM */
 	},
-	[C(OP_PREFETCH)] = {
-		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
-		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
-	},
 },
 [C(DTLB)] = {
 	/*
@@ -1154,45 +1137,24 @@ static const struct mips_perf_event xlp_cache_map
 	 * read and write.
 	 */
 	[C(OP_READ)] = {
-		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
 		[C(RESULT_MISS)]	= { 0x2d, CNTR_ALL }, /* PAPI_TLB_DM */
 	},
 	[C(OP_WRITE)] = {
-		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
 		[C(RESULT_MISS)]	= { 0x2d, CNTR_ALL }, /* PAPI_TLB_DM */
 	},
-	[C(OP_PREFETCH)] = {
-		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
-		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
-	},
 },
 [C(ITLB)] = {
 	[C(OP_READ)] = {
-		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
 		[C(RESULT_MISS)]	= { 0x08, CNTR_ALL }, /* PAPI_TLB_IM */
 	},
 	[C(OP_WRITE)] = {
-		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
 		[C(RESULT_MISS)]	= { 0x08, CNTR_ALL }, /* PAPI_TLB_IM */
 	},
-	[C(OP_PREFETCH)] = {
-		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
-		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
-	},
 },
 [C(BPU)] = {
 	[C(OP_READ)] = {
-		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
 		[C(RESULT_MISS)]	= { 0x25, CNTR_ALL },
 	},
-	[C(OP_WRITE)] = {
-		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
-		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
-	},
-	[C(OP_PREFETCH)] = {
-		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
-		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
-	},
 },
 };
 
-- 
1.8.0.2
