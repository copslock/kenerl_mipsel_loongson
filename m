Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jul 2011 10:37:32 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:48013 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491014Ab1G2IhZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Jul 2011 10:37:25 +0200
Received: by fxd20 with SMTP id 20so2661804fxd.36
        for <multiple recipients>; Fri, 29 Jul 2011 01:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=T48bn1aDa/TDwmxHtEvDu931yHFnROiONT8wNuzWBqE=;
        b=gQHVN5B0UUKOmcr0CJIivKOd5Sw2P8jeWv1sE4VQqcI5nOAHKG6aYwrmVuZQnLV5Sr
         ZbK6iQGHePBm1Zep81kvp5xOToFi3OUhpU19j/+oK/DOx5DEWqVBhiUUh1XYfbEDTrZT
         p2nUZhaNq0qbv30WE7tCfPVA7WhF7X624HMJo=
Received: by 10.223.70.197 with SMTP id e5mr739879faj.94.1311928640290;
        Fri, 29 Jul 2011 01:37:20 -0700 (PDT)
Received: from localhost.localdomain (178-191-3-196.adsl.highway.telekom.at [178.191.3.196])
        by mx.google.com with ESMTPS id q5sm955747fah.30.2011.07.29.01.37.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 29 Jul 2011 01:37:19 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [RFC PATCH 0/2] MIPS: selectively eliminate plat_irq_dispatch
Date:   Fri, 29 Jul 2011 10:37:14 +0200
Message-Id: <1311928636-18854-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.6
X-archive-position: 30763
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

These 2 patches provide a means to eliminate plat_irq_dispatch() on platforms
that can do without it.

Patch #1 adds a new config symbol which, when set, calls a generic MIPS irq
  dispatcher.  All interrupts controllers hanging off these interrupts must
  be registered as chain handlers.

Patch #2 implements the above on Alchemy.

Tested on various DB1xxx boards, with and without the C0 timer.

Finally, all credits should go to Ralf as he suggested the idea to me.

Please share your comments,
	Manuel Lauss

Manuel Lauss (2):
  MIPS: add option to the rid of plat_irq_dispatch
  MIPS: Alchemy: make ICs chained handler of MIPS ints.

 arch/mips/Kconfig              |    4 +++
 arch/mips/alchemy/common/irq.c |   55 ++++++++++++++--------------------------
 arch/mips/kernel/genex.S       |    4 +++
 arch/mips/kernel/irq_cpu.c     |    7 +++++
 4 files changed, 34 insertions(+), 36 deletions(-)

-- 
1.7.6
