Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Nov 2010 08:03:39 +0100 (CET)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:64229 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492040Ab0KRHB7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Nov 2010 08:01:59 +0100
Received: by pwj8 with SMTP id 8so783650pwj.36
        for <multiple recipients>; Wed, 17 Nov 2010 23:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=WUu6kcEttuekio/n0lkxlFw8kzHygCPv7briK/4/z3w=;
        b=v4GkeJlcISmBaAGv9Zfycun4zE4TuFsPu3GZ2AQ0FGpSaN6il6q8FWFAm1yx+X5bsU
         /wS7HBgQJlCJuJlGHNLwHFP7bXt82Ib/482sRY8pM+SfzYwOPtMflxVYSOQP1mxM02Or
         jLswZzieU4bdfq78PFEplvdGdt+uql8jXnP8E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=eBIHbH1YCNDrx9shIllKgL16OSE80GFDhs6uPgfkk1VhWHaF9A63MBbAe8EsN5DZ8U
         AZHRTQvGTrXKv5B4W7ntdA6PFBssAYlESBPH/afnVyfI75OBwWlGboK+GlDLwdywABvx
         F0eWA1L3wL7UkI//IcnB2Z+NlZcZvwUuTfmNI=
Received: by 10.142.241.16 with SMTP id o16mr201795wfh.44.1290063712943;
        Wed, 17 Nov 2010 23:01:52 -0800 (PST)
Received: from localhost.localdomain ([210.13.118.102])
        by mx.google.com with ESMTPS id w27sm81044wfd.14.2010.11.17.23.01.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 17 Nov 2010 23:01:52 -0800 (PST)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     ralf@linux-mips.org, a.p.zijlstra@chello.nl, fweisbec@gmail.com,
        will.deacon@arm.com
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        wuzhangjin@gmail.com, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, dengcheng.zhu@gmail.com
Subject: [PATCH 5/5] MIPS/Perf-events: Use unsigned delta for right shift in event update
Date:   Thu, 18 Nov 2010 14:56:41 +0800
Message-Id: <1290063401-25440-6-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1290063401-25440-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1290063401-25440-1-git-send-email-dengcheng.zhu@gmail.com>
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28412
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

Leverage the commit for ARM by Will Deacon:

446a5a8b1eb91a6990e5c8fe29f14e7a95b69132
	ARM: 6205/1: perf: ensure counter delta is treated as unsigned

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
---
 arch/mips/kernel/perf_event.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/perf_event.c b/arch/mips/kernel/perf_event.c
index 345232a..0f1cdf5 100644
--- a/arch/mips/kernel/perf_event.c
+++ b/arch/mips/kernel/perf_event.c
@@ -169,7 +169,7 @@ static void mipspmu_event_update(struct perf_event *event,
 	unsigned long flags;
 	int shift = 64 - TOTAL_BITS;
 	s64 prev_raw_count, new_raw_count;
-	s64 delta;
+	u64 delta;
 
 again:
 	prev_raw_count = local64_read(&hwc->prev_count);
-- 
1.7.1
