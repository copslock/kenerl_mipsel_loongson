Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 May 2012 08:00:38 +0200 (CEST)
Received: from mail-wi0-f169.google.com ([209.85.212.169]:37232 "EHLO
        mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903550Ab2EUGA0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 May 2012 08:00:26 +0200
Received: by wibhn14 with SMTP id hn14so2339493wib.0
        for <multiple recipients>; Sun, 20 May 2012 23:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=SNorlJvzkxMIDeK11vUYJXafsnNsoMRj8j6HUdzEuKM=;
        b=Bh75Oihh3qwxqG6jXkNMUlDjia0mT+cg37NDMG3uR7jQtKA4wDUMLcMcpaEf957dnI
         G36a9ycAz1L82j84Ycq0lE6RS76URuhEtb7L6dUit72zidVZY/2eSLlcV6TiUPKlIMPJ
         IDga2CJR14XENXPzgaIYibJEE7nPXcEuVUWoWnJlI7s3Xt4kGjPPuXlbUFnMIhr/XIrM
         RjZWJUB9U8GUE1Wg7vBHFrVRl+lqAB1GsNy3kSpBAlYUyqtzhcS1yCx2EN2hcADM1Bgv
         EvDOT7kO+U2RGdLzTRfA2U//6PUuOxa42umDpFIUo1VfEOWJ+tbqzh/vYlygGmR9pct0
         Ma/Q==
Received: by 10.180.105.69 with SMTP id gk5mr21964634wib.3.1337580020797;
        Sun, 20 May 2012 23:00:20 -0700 (PDT)
Received: from localhost ([61.148.56.138])
        by mx.google.com with ESMTPS id ez4sm23579951wid.3.2012.05.20.23.00.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 20 May 2012 23:00:20 -0700 (PDT)
From:   Yong Zhang <yong.zhang0@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     ralf@linux-mips.org, sshtylyov@mvista.com, david.daney@cavium.com
Subject: [V1 PATCH 0/8] patchset focus on MIPS SMP woes
Date:   Mon, 21 May 2012 14:00:00 +0800
Message-Id: <1337580008-7280-1-git-send-email-yong.zhang0@gmail.com>
X-Mailer: git-send-email 1.7.5.4
X-archive-position: 33389
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yong.zhang0@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Changes from V0:
  a) Fix grammar and add summary for commit reference; (Sergei Shtylyov)
  b) Collect Acks


Since commit 5fbd036b [sched: Cleanup cpu_active madness] and
commit 2baab4e9 [sched: Fix select_fallback_rq() vs cpu_active/cpu_online],
it's more safe to put notify_cpu_starting() and set_cpu_online() with
irq disabled, otherwise we will have a typical race condition which
above two commits try to resolve:

       CPU1                            CPU2
__cpu_up();
    mp_ops->boot_secondary();
                               start_secondary();
                                 ->init_secondary();
                                   local_irq_enable();
                               <IRQ>
                               do something;
                                     wake up softirqd;
                                     try_to_wake_up();
                                       select_fallback_rq();
                                       /* select wrong cpu */
    set_cpu_online();


This patchset fix the above issue as well as set_cpu_online is
called on the caller cpu.

BTW, I'm only running it on Cavium board because of limited source,
so if anyone is interested to test it on other board, that's great :)

Yong Zhang (8):
  MIPS: Octeon: delay enable irq to ->smp_finish()
  MIPS: BMIPS: delay irq enable to ->smp_finish()
  MIPS: SMTC: delay irq enable to ->smp_finish()
  MIPS: Yosemite: delay irq enable to ->smp_finish()
  MIPS: call ->smp_finish() a little late
  MIPS: call set_cpu_online() on the uping cpu with irq disabled
  MIPS: smp: Warn on too early irq enable
  MIPS: sync-r4k: remove redundant irq operation

 arch/mips/cavium-octeon/smp.c       |    2 +-
 arch/mips/kernel/smp-bmips.c        |   14 +++++++-------
 arch/mips/kernel/smp.c              |   12 +++++++++---
 arch/mips/kernel/smtc.c             |    3 ++-
 arch/mips/kernel/sync-r4k.c         |    5 -----
 arch/mips/pmc-sierra/yosemite/smp.c |    2 +-
 6 files changed, 20 insertions(+), 18 deletions(-)

-- 
1.7.5.4
