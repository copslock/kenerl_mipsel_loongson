Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Nov 2010 08:01:37 +0100 (CET)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:52603 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492040Ab0KRHBe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Nov 2010 08:01:34 +0100
Received: by pzk3 with SMTP id 3so602449pzk.36
        for <multiple recipients>; Wed, 17 Nov 2010 23:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=2WeiCj9vXGc7SwD6nQIQ9dJ9Y/ijZceXjGv1cKAQz/E=;
        b=nTWDdSXWFWV3G8MlpQYxICIGgU5jWJHiCNBPgRT1d8Izb33yP24vjUqG/EAosAJm+8
         DtKL3DlOBkI8smTE6jOOX0vG6xZb59oEhmCUUtt5RxQ/5W6fLP8oRlJJDtPadO4bx6AT
         jHjG25Owfz6zC/RSgCa+K1gIAZbl5qmeZP+p0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=sHf0X8h9onw/YrR7qmU6W02bKhoK7EmZoAsGSnbypFilEpC9F3dFeo6nJFHvoFpgAf
         iwBiU9w4Bnqp0Icrqc6AnxpXi4Nr6dYNguqz7xx9yQFIvaeE0UiT+8Qf085F5e37SAw2
         1h5yCe9AYNb9dkyxA7MVNlrsEcv6EmIN+jYf4=
Received: by 10.142.213.11 with SMTP id l11mr179587wfg.278.1290063687037;
        Wed, 17 Nov 2010 23:01:27 -0800 (PST)
Received: from localhost.localdomain ([210.13.118.102])
        by mx.google.com with ESMTPS id w27sm81044wfd.14.2010.11.17.23.01.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 17 Nov 2010 23:01:24 -0800 (PST)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     ralf@linux-mips.org, a.p.zijlstra@chello.nl, fweisbec@gmail.com,
        will.deacon@arm.com
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        wuzhangjin@gmail.com, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, dengcheng.zhu@gmail.com
Subject: [PATCH 0/5] MIPS/Perf-events: Sync with mainline upper layer
Date:   Thu, 18 Nov 2010 14:56:36 +0800
Message-Id: <1290063401-25440-1-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.7.1
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28407
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

Current MIPS Perf-events uses older interfaces to the generic layer. So it
will not work. This patch set fixes this issue by adding MIPS counterparts
for a list of previous commits that went to mainline earlier.

Deng-Cheng Zhu (5):
  MIPS/Perf-events: Work with irq_work
  MIPS/Perf-events: Work with the new PMU interface
  MIPS/Perf-events: Check event state in validate_event()
  MIPS/Perf-events: Work with the new callchain interface
  MIPS/Perf-events: Use unsigned delta for right shift in event update

 arch/mips/Kconfig                    |    1 +
 arch/mips/include/asm/perf_event.h   |   12 +-
 arch/mips/kernel/perf_event.c        |  342 ++++++++++++++++------------------
 arch/mips/kernel/perf_event_mipsxx.c |    4 +-
 4 files changed, 169 insertions(+), 190 deletions(-)
