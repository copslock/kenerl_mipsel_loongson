Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Jan 2011 08:38:05 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:55822 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491057Ab1AXHgO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Jan 2011 08:36:14 +0100
Received: by mail-iy0-f177.google.com with SMTP id 21so3818114iyj.36
        for <multiple recipients>; Sun, 23 Jan 2011 23:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=0yaWtxWXj2tWlFLV/Xf2+RXs4pE06WU6wPggzWD8PpM=;
        b=oSAkvk6GpywqmJGvCFw7ft98zvn444AYElGrdeSF1/dGveUFS0VL2y9OIOpxiG4s60
         nTTwJ7AY97+AwxSt5fFrQ8iwX7EwL85eN9f1Q7brJ17folbkm46Cu6CcLBwrMhOkyfiS
         tk6Tu8/yobMPpPImCR0QpMdJWMszCZwKV5Qok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=SQIzUC3L2fOpFlctm6ebORBoL81qva1KCZ0PiRi20N54wSACEGt3qIzfyMeoXCP+Nn
         xmNlkvjTdy2x9IeKZ5Fxox4lkhexrBbJw8aovIhwNzs7NU2WRcqp15iJWLa8kyFyrlkR
         2tin1cFnb0nAoXaEeMPeHipr5MONCtIOSQ17o=
Received: by 10.231.15.8 with SMTP id i8mr4277502iba.125.1295854573526;
        Sun, 23 Jan 2011 23:36:13 -0800 (PST)
Received: from localhost.localdomain ([210.13.118.102])
        by mx.google.com with ESMTPS id 8sm10781545iba.22.2011.01.23.23.36.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 Jan 2011 23:36:13 -0800 (PST)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     ralf@linux-mips.org, a.p.zijlstra@chello.nl, fweisbec@gmail.com,
        will.deacon@arm.com
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        wuzhangjin@gmail.com, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, dengcheng.zhu@gmail.com, matt@console-pimps.org,
        sshtylyov@mvista.com, ddaney@caviumnetworks.com
Subject: [RESEND PATCH v4 5/5] MIPS/Perf-events: Use unsigned delta for right shift in event update
Date:   Mon, 24 Jan 2011 15:35:49 +0800
Message-Id: <1295854549-7928-6-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1295854549-7928-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1295854549-7928-1-git-send-email-dengcheng.zhu@gmail.com>
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29031
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

Leverage the commit for ARM by Will Deacon:

- 446a5a8b1eb91a6990e5c8fe29f14e7a95b69132
    ARM: 6205/1: perf: ensure counter delta is treated as unsigned

    Hardware performance counters on ARM are 32-bits wide but atomic64_t
    variables are used to represent counter data in the hw_perf_event structure.

    The armpmu_event_update function right-shifts a signed 64-bit delta variable
    and adds the result to the event count. This can lead to shifting in sign-bits
    if the MSB of the 32-bit counter value is set. This results in perf output
    such as:

     Performance counter stats for 'sleep 20':

     18446744073460670464  cycles             <-- 0xFFFFFFFFF12A6000
            7783773  instructions             #      0.000 IPC
                465  context-switches
                161  page-faults
            1172393  branches

       20.154242147  seconds time elapsed

    This patch ensures that the delta value is treated as unsigned so that the
    right shift sets the upper bits to zero.

Acked-by: Will Deacon <will.deacon@arm.com>
Acked-by: David Daney <ddaney@caviumnetworks.com>
Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
---
Changes:
v4 - v3:
o None
v3 - v2:
o Keep all mentioned commits in the form of number + title + original
summary + (MIPS specific info when needed).
v2 - v1:
o None

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
