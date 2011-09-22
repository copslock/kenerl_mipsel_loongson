Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Sep 2011 19:27:17 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:5950 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491917Ab1IVR0d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Sep 2011 19:26:33 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4e7b70100001>; Thu, 22 Sep 2011 10:27:44 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 22 Sep 2011 10:26:29 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 22 Sep 2011 10:26:29 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id p8MHQLD3007320;
        Thu, 22 Sep 2011 10:26:27 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p8MHQKqB007319;
        Thu, 22 Sep 2011 10:26:20 -0700
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>,
        Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Subject: [PATCH v5 0/5] MIPS: perf: Add support for 64-bit MIPS hardware counters.
Date:   Thu, 22 Sep 2011 10:26:13 -0700
Message-Id: <1316712378-7282-1-git-send-email-david.daney@cavium.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 22 Sep 2011 17:26:29.0782 (UTC) FILETIME=[C3E32360:01CC794C]
X-archive-position: 31129
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12719

MIPS hardware performance counters may have either 32-bit or 64-bit
wide counter registers.  The current implementation only supports the
32-bit variety.

These patches aim to add support for 64-bit wide counters while
mantaining support for 32-bit.

Tested with perf top and perf record, which both work well on an
Octeon/Debian based system.

Changes from v4:

o Rebased against 3.1.0-rc6

Changes from v3:

o Rebased against 2.6.39.

o Re-Include Octeon processor support.

Changes from v2:

o Quit sign extending 32-bit counter values.

o Remove usless local_irq_save() in several places.

Changes from v1:

o Removed Octeon processor support to a separate patch set.

o Rebased against v5 of Deng-Cheng Zhu's cleanups:
      http://patchwork.linux-mips.org/patch/2011/
      http://patchwork.linux-mips.org/patch/2012/
      http://patchwork.linux-mips.org/patch/2013/
      http://patchwork.linux-mips.org/patch/2014/
      http://patchwork.linux-mips.org/patch/2015/

o Tried to fix problem where 32-bit counters generated way too many
  interrupts.

David Daney (5):
  MIPS: Add accessor macros for 64-bit performance counter registers.
  MIPS: perf: Cleanup formatting in arch/mips/kernel/perf_event.c
  MIPS: perf: Reorganize contents of perf support files.
  MIPS: perf: Add support for 64-bit perf counters.
  MIPS: perf: Add Octeon support for hardware perf.

 arch/mips/Kconfig                    |    2 +-
 arch/mips/include/asm/mipsregs.h     |    8 +
 arch/mips/kernel/Makefile            |    5 +-
 arch/mips/kernel/perf_event.c        |  519 +--------------
 arch/mips/kernel/perf_event_mipsxx.c | 1265 ++++++++++++++++++++++++----------
 5 files changed, 933 insertions(+), 866 deletions(-)

Cc: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
-- 
1.7.2.3
