Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Feb 2012 20:25:40 +0100 (CET)
Received: from mail.windriver.com ([147.11.1.11]:64672 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903774Ab2B1TZG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Feb 2012 20:25:06 +0100
Received: from yow-lpgnfs-02.corp.ad.wrs.com (yow-lpgnfs-02.ottawa.windriver.com [128.224.149.8])
        by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q1SJOuvR014095;
        Tue, 28 Feb 2012 11:24:57 -0800 (PST)
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 0/5] MIPS: module.h usage cleanup.
Date:   Tue, 28 Feb 2012 14:24:43 -0500
Message-Id: <1330457088-14587-1-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 1.7.9.1
X-archive-position: 32572
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi Ralf,

Not a lot to see here, really.  MIPS had usages of module.h tucked
away in a couple asm files, and that was masking some of the other
implicit users, plus preventing MIPS from getting the full benefit
of not having to feed module.h to cpp 35,000 times.

I've left the two drivers/serial commits separate, in case there
is a desire to have them go in via Greg's trees, but they are a
required dependency for the arch/mips fixes, so I think it makes
sense they stay together with the other changes here.

I will have some arch independent module.h cleanups (in fs and lib)
that will require me to create a module.h tree for 3.4, so I can
carry this there if required.  But this lot is all self-contained
to MIPS and so I'd be fine with (and actually prefer) this going in
via the MIPS tree.  No strong preference - either way, let me know.

Thanks,
Paul.
---

Paul Gortmaker (5):
  serial: MIPS DECstation zs.c driver needs module.h
  serial: MIPS swarm sb1250-duart.c driver needs module.h
  MIPS: fix several implicit uses of export.h/module.h
  MIPS: delete bogus module.h usage in termios.h
  MIPS: dont use module.h just to export symbols in asm/uasm.h

 arch/mips/alchemy/devboards/db1200.c  |    1 +
 arch/mips/cavium-octeon/setup.c       |    1 +
 arch/mips/include/asm/module.h        |    1 +
 arch/mips/include/asm/termios.h       |    2 +-
 arch/mips/include/asm/uasm.h          |    2 +-
 arch/mips/kernel/traps.c              |    1 +
 arch/mips/pmc-sierra/yosemite/setup.c |    1 +
 arch/mips/rb532/devices.c             |    1 +
 arch/mips/sni/setup.c                 |    1 +
 drivers/tty/serial/sb1250-duart.c     |    1 +
 drivers/tty/serial/zs.c               |    1 +
 11 files changed, 11 insertions(+), 2 deletions(-)

-- 
1.7.9.1
