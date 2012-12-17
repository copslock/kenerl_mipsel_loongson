Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Dec 2012 08:22:02 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:52241 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816668Ab2LQHWBSNrzz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Dec 2012 08:22:01 +0100
Received: by mail-bk0-f49.google.com with SMTP id jm19so2464483bkc.36
        for <multiple recipients>; Sun, 16 Dec 2012 23:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=OWmsNDNVI1yp0W7eeM4QJRQOOfNWza4xKRiOMbM2Tl0=;
        b=ElBM3erYm7/G7ODnGKmMzzKMAF/FXDydvtCm72jmfqhe2kPZ5WbjXEJhuXkdRcr64I
         zM/Vw7NiFc9fdkf58NpU1M0RB0sRDiKW6cEj5qZp7/v5v7PfT20EGFBqtdt+rb9mFjoD
         88YY5nNLp5gjWjZlYweTkv0FZ2e1BsdpixUIWptwQsPmH0cbpDO17JTjKziYM7yaxSz0
         SVPp+EC7x8iv7tqJ7HDEMRe8q9dYShm2739JvSNU2qtYVn1kA0nnXUP15imLyjh2bvRl
         YdXn5XC6si32Gq19ao228NKFiWxbEx/OqlhtbkZ/yIvETtvKYP+EDBg9T53N+sLoSlce
         KRJA==
Received: by 10.204.147.207 with SMTP id m15mr5407875bkv.54.1355728915947;
        Sun, 16 Dec 2012 23:21:55 -0800 (PST)
Received: from flagship.roarinelk.net (178-191-3-232.adsl.highway.telekom.at. [178.191.3.232])
        by mx.google.com with ESMTPS id d16sm8364392bkw.2.2012.12.16.23.21.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 16 Dec 2012 23:21:55 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Zi Shen Lim <zlim@netlogicmicro.com>,
        Jayachandran C <jchandra@broadcom.com>
Subject: [PATCH] MIPS: perf: fix build failure in XLP perf support.
Date:   Mon, 17 Dec 2012 08:21:46 +0100
Message-Id: <1355728906-24370-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.8.0.2
X-archive-position: 35300
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
Against Linus' latest -git.  That's also where the commit-id is from.

 arch/mips/kernel/perf_event_mipsxx.c | 38 ------------------------------------
 1 file changed, 38 deletions(-)

diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index b14c14d..51aa6a4 100644
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
@@ -1154,46 +1137,25 @@ static const struct mips_perf_event xlp_cache_map
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
 		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
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
-},
 };
 
 #ifdef CONFIG_MIPS_MT_SMP
-- 
1.8.0.2
