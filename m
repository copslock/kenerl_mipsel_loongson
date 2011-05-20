Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 May 2011 23:40:10 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:1129 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491133Ab1ETVjh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 May 2011 23:39:37 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4dd6dfd50000>; Fri, 20 May 2011 14:40:37 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 20 May 2011 14:39:33 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 20 May 2011 14:39:33 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p4KLdRpA030389;
        Fri, 20 May 2011 14:39:28 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p4KLdOLi030388;
        Fri, 20 May 2011 14:39:24 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Subject: [PATCH v4 0/5] MIPS: perf: Add support for 64-bit MIPS hardware counters.
Date:   Fri, 20 May 2011 14:39:17 -0700
Message-Id: <1305927562-30351-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 20 May 2011 21:39:33.0616 (UTC) FILETIME=[68859700:01CC1736]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30109
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

MIPS hardware performance counters may have either 32-bit or 64-bit
wide counter registers.  The current implementation only supports the
32-bit variety.

These patches aim to add support for 64-bit wide counters while
mantaining support for 32-bit.

Tested with perf top and perf record, which both work well on an
Octeon/Debian based system.

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
 arch/mips/kernel/perf_event.c        |  521 +--------------
 arch/mips/kernel/perf_event_mipsxx.c | 1267 ++++++++++++++++++++++++---------
 5 files changed, 935 insertions(+), 868 deletions(-)

Cc: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
-- 
1.7.2.3
