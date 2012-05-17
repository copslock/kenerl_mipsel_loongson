Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 May 2012 12:10:39 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:51296 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903632Ab2EQKKc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 May 2012 12:10:32 +0200
Received: by dadm1 with SMTP id m1so2524865dad.36
        for <multiple recipients>; Thu, 17 May 2012 03:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=x9zoQJ6Hlnsm/BMvAgUa5xMM7Pv3IfXPJNdHbnSIAqg=;
        b=OdKhF2m/kj4ygBhi9nWERWhglU1x3hV8gjJphcA6EJsiSOpdbdGqlhdcW6bPzZg2XK
         JPBW3LOUu0261BMCoETn6j1TcroCbwOX/I4PH4X+xYpahNUUrwepx7j/JFz44CKfdM/0
         v9UOT5BY7mewo0gVTmM7Nx/DDK9F1e9KW7EDq6pN3pw2uGBqC1AgiEyT/XwzmJa6AD+j
         cJJWsJmqVUuAkCJh3Iu7X498Q/M2RBZEE2v93e4e8mNBy02RVEDUXOFciFMWdxDANBOx
         oMDg+NWa/rpcdOpN4uD+5B4ihAsc7FeDwKx/K1JeVTPIIblcw4Qr2oB7PA8sRYITrhwU
         6RHg==
Received: by 10.68.240.135 with SMTP id wa7mr26207480pbc.7.1337249425284;
        Thu, 17 May 2012 03:10:25 -0700 (PDT)
Received: from localhost ([221.223.131.58])
        by mx.google.com with ESMTPS id qt10sm8637665pbc.57.2012.05.17.03.10.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 May 2012 03:10:23 -0700 (PDT)
From:   Yong Zhang <yong.zhang0@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     ralf@linux-mips.org, david.daney@cavium.com
Subject: [PATCH 0/8] patchset focus on MIPS SMP woes
Date:   Thu, 17 May 2012 18:10:02 +0800
Message-Id: <1337249410-7162-1-git-send-email-yong.zhang0@gmail.com>
X-Mailer: git-send-email 1.7.1
X-archive-position: 33341
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yong.zhang0@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Yong Zhang <yong.zhang@windriver.com>

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

Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>

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
