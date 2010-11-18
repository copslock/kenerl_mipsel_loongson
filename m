Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Nov 2010 08:03:16 +0100 (CET)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:35419 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492049Ab0KRHBy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Nov 2010 08:01:54 +0100
Received: by pwj8 with SMTP id 8so783632pwj.36
        for <multiple recipients>; Wed, 17 Nov 2010 23:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=zeFJ/G7Zo4m6FcSjcQ1z2PiISXw/VUK5Czf4Fr/d1/M=;
        b=n/IO6gPcdACUY/XnXqTYa3D78AyalnReRPWxczb6cQLU7jE5kJCaKQmMzZAHUMCP1U
         bZsP7Z9vaQkD4HtqkuZ6ulyZ33NeNE8YxFBkU/0s0Jpi0ajCaocYtmMLD2mYHQ+OVEFC
         KtKTCIpcx7nHGOCIlyvDJGoR5i7MKvT03yds0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AWj0KK4qaI847m0nXW8lWlwSxpJSHe3g1JwdNDtOI5/s2mykmyUh2+NCzhMs8Pvim7
         1lLGXVr5O32fAxmeQXtXkkDNeqJD8y9dDitzN7jR0q8+s2GTvu30XtZREDRM14/CYSqL
         a/sYjeU4OBd8DS/vIVsCZCx40SHWMI1QsbjrQ=
Received: by 10.142.223.3 with SMTP id v3mr205710wfg.12.1290063702640;
        Wed, 17 Nov 2010 23:01:42 -0800 (PST)
Received: from localhost.localdomain ([210.13.118.102])
        by mx.google.com with ESMTPS id w27sm81044wfd.14.2010.11.17.23.01.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 17 Nov 2010 23:01:41 -0800 (PST)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     ralf@linux-mips.org, a.p.zijlstra@chello.nl, fweisbec@gmail.com,
        will.deacon@arm.com
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        wuzhangjin@gmail.com, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, dengcheng.zhu@gmail.com
Subject: [PATCH 3/5] MIPS/Perf-events: Check event state in validate_event()
Date:   Thu, 18 Nov 2010 14:56:39 +0800
Message-Id: <1290063401-25440-4-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1290063401-25440-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1290063401-25440-1-git-send-email-dengcheng.zhu@gmail.com>
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28411
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

Ignore events that are not for this PMU or are in off/error state.

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
---
 arch/mips/kernel/perf_event.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/perf_event.c b/arch/mips/kernel/perf_event.c
index 1ee44a3..9c6442a 100644
--- a/arch/mips/kernel/perf_event.c
+++ b/arch/mips/kernel/perf_event.c
@@ -486,7 +486,7 @@ static int validate_event(struct cpu_hw_events *cpuc,
 {
 	struct hw_perf_event fake_hwc = event->hw;
 
-	if (event->pmu && event->pmu != &pmu)
+	if (event->pmu != &pmu || event->state <= PERF_EVENT_STATE_OFF)
 		return 0;
 
 	return mipspmu->alloc_counter(cpuc, &fake_hwc) >= 0;
-- 
1.7.1
