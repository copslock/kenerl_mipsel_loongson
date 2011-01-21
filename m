Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jan 2011 09:19:53 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:57964 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491141Ab1AUITu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Jan 2011 09:19:50 +0100
Received: by iyj21 with SMTP id 21so1442488iyj.36
        for <multiple recipients>; Fri, 21 Jan 2011 00:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=/tRAMJoBNJzJM/j1Cop9gbkb6cyy0DcZyYnqv3drAqA=;
        b=d1Ogxz4ceURnn12sDYzCdssyJmhGiGNDBLDiEG+B25q1DIrKauhtKGjMKLfcYMBeTu
         PsB0cueTpDgn3wxD7Ym7jZaaeki4d44YqiGSiq37340fvs246HhtpCOl/D72I1I7QWU0
         agFbhnXTGEA0DiLve+PFkG/CkQWDEt3aPNmh8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=mqNJ8bqsns/XC9ktgozVw6ysiAsKS3mC76wmdI96fMYxT+7eR58dYrn15DxTIV+mj3
         qoBT2RCdKqAU+J8Dw5vx2TflyzRDHNChuZjSUYmrpOmHjV9L1h4QJUHJecE+iIMpuLhC
         k6ifQhUcf6181ELJ3kAeU4+vqXL+mUKDBWYGk=
Received: by 10.42.230.137 with SMTP id jm9mr361261icb.282.1295597983399;
        Fri, 21 Jan 2011 00:19:43 -0800 (PST)
Received: from localhost.localdomain ([210.13.118.102])
        by mx.google.com with ESMTPS id he5sm6836460icb.22.2011.01.21.00.19.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 21 Jan 2011 00:19:41 -0800 (PST)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     ralf@linux-mips.org, a.p.zijlstra@chello.nl, fweisbec@gmail.com,
        will.deacon@arm.com
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        wuzhangjin@gmail.com, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, dengcheng.zhu@gmail.com, matt@console-pimps.org,
        sshtylyov@mvista.com, ddaney@caviumnetworks.com
Subject: [PATCH v4 0/5] MIPS/Perf-events: Sync with mainline upper layer (v4)
Date:   Fri, 21 Jan 2011 16:19:16 +0800
Message-Id: <1295597961-7565-1-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.7.2.3
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28999
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

Current MIPS Perf-events uses older interfaces to the generic layer. So it
will not work. This patch set fixes this issue (reported by Wu Zhangjin) by
adding MIPS counterparts for a list of previous commits that went to
mainline earlier.

Changes:
v4 - v3:
o Rebase this patch set to have early_initcall instead of arch_initcall for
init_hw_perf_events.
o Change the arguments of perf_pmu_register() in Patch #2.
v3 - v2:
o Keep all mentioned commits in the form of number + title + original
summary + (MIPS specific info when needed).
v2 - v1:
o Corrected the return value of the event check in validate_event().

Deng-Cheng Zhu (5):
  MIPS/Perf-events: Work with irq_work
  MIPS/Perf-events: Work with the new PMU interface
  MIPS/Perf-events: Fix event check in validate_event()
  MIPS/Perf-events: Work with the new callchain interface
  MIPS/Perf-events: Use unsigned delta for right shift in event update

 arch/mips/Kconfig                    |    1 +
 arch/mips/include/asm/perf_event.h   |   12 +-
 arch/mips/kernel/perf_event.c        |  345 ++++++++++++++++------------------
 arch/mips/kernel/perf_event_mipsxx.c |    4 +-
 4 files changed, 171 insertions(+), 191 deletions(-)
