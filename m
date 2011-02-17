Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Feb 2011 22:34:02 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:8730 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491116Ab1BQVd5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Feb 2011 22:33:57 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d5d94750001>; Thu, 17 Feb 2011 13:34:45 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 17 Feb 2011 13:33:53 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 17 Feb 2011 13:33:53 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p1HLXjb5025348;
        Thu, 17 Feb 2011 13:33:46 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p1HLXfhN025345;
        Thu, 17 Feb 2011 13:33:41 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Dezhong Diao <dediao@cisco.com>,
        Gabor Juhos <juhosg@openwrt.org>,
        Grant Likely <grant.likely@secretlab.ca>,
        Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Subject: [PATCH v3 0/4] MIPS: perf: Add support for 64-bit MIPS hardware counters.
Date:   Thu, 17 Feb 2011 13:33:35 -0800
Message-Id: <1297978419-25309-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 17 Feb 2011 21:33:53.0191 (UTC) FILETIME=[5F9BDB70:01CBCEEA]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29214
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

David Daney (4):
  MIPS: Add accessor macros for 64-bit performance counter registers.
  MIPS: perf: Cleanup formatting in arch/mips/kernel/perf_event.c
  MIPS: perf: Reorganize contents of perf support files.
  MIPS: perf: Add support for 64-bit perf counters.

 arch/mips/Kconfig                    |    2 +-
 arch/mips/include/asm/mipsregs.h     |    8 +
 arch/mips/kernel/Makefile            |    5 +-
 arch/mips/kernel/perf_event.c        |  521 +----------------
 arch/mips/kernel/perf_event_mipsxx.c | 1100 +++++++++++++++++++++++-----------
 5 files changed, 778 insertions(+), 858 deletions(-)

Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Dezhong Diao <dediao@cisco.com>
Cc: Gabor Juhos <juhosg@openwrt.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
-- 
1.7.2.3
