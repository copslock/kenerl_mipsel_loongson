Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Jan 2011 08:35:53 +0100 (CET)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:63194 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491048Ab1AXHfq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Jan 2011 08:35:46 +0100
Received: by iwn38 with SMTP id 38so3850811iwn.36
        for <multiple recipients>; Sun, 23 Jan 2011 23:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=/tRAMJoBNJzJM/j1Cop9gbkb6cyy0DcZyYnqv3drAqA=;
        b=Q71mr+q3kPbpQ0PA0aUN6aOYxikFOtn9gkBwYnsRtNjrQZqhs4dWXbxLeHGOhBbywK
         rFIA2j7rczXwj6aC3RaiCTaFqR/vU191cc1tG3Gge9HJ4Jpa7wTr+eazZNTJmdZbZsEt
         DIl1IbZm7ltWIPPKOMsHjYSix6wQ4C/T/lCV8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=iKzPAvdb2AvBQUZ5rpG9bVRMeGJVnPCAWpZkYnhJvZD9OpI4S23a5VSm8JHOtMHOK7
         3FKDgQMNbK94dT35TRNopemfgbsTGaj4CMnkg51KtgIXd8NJ7wkK137gp0bNtQJVtLOz
         taTYUEhl1VTCxX4Ps0qensf0PRYyy8LOaaUt0=
Received: by 10.42.227.72 with SMTP id iz8mr4307602icb.302.1295854544942;
        Sun, 23 Jan 2011 23:35:44 -0800 (PST)
Received: from localhost.localdomain ([210.13.118.102])
        by mx.google.com with ESMTPS id 8sm10781545iba.22.2011.01.23.23.35.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 Jan 2011 23:35:43 -0800 (PST)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     ralf@linux-mips.org, a.p.zijlstra@chello.nl, fweisbec@gmail.com,
        will.deacon@arm.com
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        wuzhangjin@gmail.com, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, dengcheng.zhu@gmail.com, matt@console-pimps.org,
        sshtylyov@mvista.com, ddaney@caviumnetworks.com
Subject: [RESEND PATCH v4 0/5] MIPS/Perf-events: Sync with mainline upper layer (v4)
Date:   Mon, 24 Jan 2011 15:35:44 +0800
Message-Id: <1295854549-7928-1-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.7.2.3
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29026
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
