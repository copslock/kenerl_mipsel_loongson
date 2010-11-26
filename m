Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Nov 2010 04:05:27 +0100 (CET)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:49563 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492136Ab0KZDEM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Nov 2010 04:04:12 +0100
Received: by gyg4 with SMTP id 4so785137gyg.36
        for <multiple recipients>; Thu, 25 Nov 2010 19:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=TTwn7Sa7hhzDGQmuonoWGRuERvKySdxN9gNkdSjKDEs=;
        b=mH9Al/T7TB9p4ro58c4kjkdkbkVxImVTPbYUlhWwsuU+ga5sCrIXXKhSs33FekVGJI
         DhrCVsBFgVqTObTpV4wPg54QVc+x+keOk1w8z49Ne8nvuA96mDopoLX6YxpT0/LxvkmX
         hVNWBoZ6lBNK8LFmxLXybtumEA3HY8OPh5YKU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=IPkDy+cKxkKZfcdbJs66tf6E7W/alEr9CIK1YMW9T3KAMqvs7iPmsxDc4k8y0Rj9CI
         A87o135b+QmZTZ8f4IobaOpCySDp0BW6YRaZoH/UinE7T4JaqktyTt2gWlfIFNDCp4uy
         1ixsSsxH3dO/6DIm5Kluz6A7zk74N9sTTm430=
Received: by 10.91.42.39 with SMTP id u39mr3691435agj.71.1290740646797;
        Thu, 25 Nov 2010 19:04:06 -0800 (PST)
Received: from localhost.localdomain ([210.13.118.102])
        by mx.google.com with ESMTPS id 43sm933046yhl.37.2010.11.25.19.04.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 19:04:06 -0800 (PST)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     ralf@linux-mips.org, a.p.zijlstra@chello.nl, fweisbec@gmail.com,
        will.deacon@arm.com
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        wuzhangjin@gmail.com, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, dengcheng.zhu@gmail.com
Subject: [PATCH v2 3/5] MIPS/Perf-events: Fix event check in validate_event()
Date:   Fri, 26 Nov 2010 11:05:05 +0800
Message-Id: <1290740707-32586-4-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1290740707-32586-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1290740707-32586-1-git-send-email-dengcheng.zhu@gmail.com>
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28533
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

Ignore events that are in off/error state or belong to a different PMU.

This patch originates from the following commit for ARM by Will Deacon:

65b4711ff513767341aa1915c822de6ec0de65cb
	ARM: 6352/1: perf: fix event validation

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
---
 arch/mips/kernel/perf_event.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/perf_event.c b/arch/mips/kernel/perf_event.c
index 1ee44a3..3d55761 100644
--- a/arch/mips/kernel/perf_event.c
+++ b/arch/mips/kernel/perf_event.c
@@ -486,8 +486,9 @@ static int validate_event(struct cpu_hw_events *cpuc,
 {
 	struct hw_perf_event fake_hwc = event->hw;
 
-	if (event->pmu && event->pmu != &pmu)
-		return 0;
+	/* Allow mixed event group. So return 1 to pass validation. */
+	if (event->pmu != &pmu || event->state <= PERF_EVENT_STATE_OFF)
+		return 1;
 
 	return mipspmu->alloc_counter(cpuc, &fake_hwc) >= 0;
 }
-- 
1.7.1
