Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Nov 2010 04:05:53 +0100 (CET)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:49563 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492142Ab0KZDET (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Nov 2010 04:04:19 +0100
Received: by mail-gy0-f177.google.com with SMTP id 4so785137gyg.36
        for <multiple recipients>; Thu, 25 Nov 2010 19:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=MxBC0U4GXr4bQj7YLx82Dx+y6v34Fa3v1H76lvpMqlg=;
        b=ozYNuv2zJv72biP7hcRjwDi4p5f4gifUCeGWmrWOihfH1/3pswbcVrk30ZsuagwbPb
         e5zVi++fCr46Fm6YwSgjQL7Ha9omlm8nhprRfznRcsieTH9zhmOtVw3sPkRs9ANwhgqS
         iGYqi7Rp6wVm9FrE+VwqzpRydt9wmYR0fA+LE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=BRDa8UfYgN+8nlHi+qnuatPIc3Ul+C9dUE8UdbcARlSdeUcNBGuE1HVtqUEgYK/OwU
         HZ0xOPlIUsV/QGhSpNp8TsfloA1WZco7Oi6Rtg368Aouoh2uvK9LYeW11gVGZ3la/Fez
         BB2iC6jIkoxOl/2ES0FdyJV8qM9ul1Y/TUPbE=
Received: by 10.151.9.9 with SMTP id m9mr514177ybi.141.1290740658364;
        Thu, 25 Nov 2010 19:04:18 -0800 (PST)
Received: from localhost.localdomain ([210.13.118.102])
        by mx.google.com with ESMTPS id 43sm933046yhl.37.2010.11.25.19.04.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 19:04:17 -0800 (PST)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     ralf@linux-mips.org, a.p.zijlstra@chello.nl, fweisbec@gmail.com,
        will.deacon@arm.com
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        wuzhangjin@gmail.com, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, dengcheng.zhu@gmail.com
Subject: [PATCH v2 5/5] MIPS/Perf-events: Use unsigned delta for right shift in event update
Date:   Fri, 26 Nov 2010 11:05:07 +0800
Message-Id: <1290740707-32586-6-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1290740707-32586-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1290740707-32586-1-git-send-email-dengcheng.zhu@gmail.com>
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28534
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

Leverage the commit for ARM by Will Deacon:

446a5a8b1eb91a6990e5c8fe29f14e7a95b69132
        ARM: 6205/1: perf: ensure counter delta is treated as unsigned

Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
---
 arch/mips/kernel/perf_event.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/perf_event.c b/arch/mips/kernel/perf_event.c
index 8f7d2f8..a824485 100644
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
