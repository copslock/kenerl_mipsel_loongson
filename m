Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jan 2011 03:35:27 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:13362 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491008Ab1AGCfY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Jan 2011 03:35:24 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d267c160000>; Thu, 06 Jan 2011 18:36:06 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 6 Jan 2011 18:35:19 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 6 Jan 2011 18:35:19 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p072ZCvL002633;
        Thu, 6 Jan 2011 18:35:12 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p072ZApl002631;
        Thu, 6 Jan 2011 18:35:10 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Subject: [PATCH 0/6] MIPS: perf: Make perf work for 64-bit/Octeon counters.
Date:   Thu,  6 Jan 2011 18:35:01 -0800
Message-Id: <1294367707-2593-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 07 Jan 2011 02:35:19.0469 (UTC) FILETIME=[86855DD0:01CBAE13]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28872
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The existing MIPS perf hardware counter support only handles 32-bit
wide counters.  Some CPUs (like Octeon) have the 64-bit wide variety.
This patch set allows perf to work on Octeon, and I hope not break
existing systems.  I have not tested it on non-Octeon systems, so it
would be good if someone could test that.

Summary of the patches:

1) Fix faulty Octeon interrupt controller code.

2) Add some register definitions.

3,4) Clean up existing code.

5) 64-bit perf counter support.

6) Octeon perf event bindings.

Patch 4/6 is the biggest and has the highest chance of having broken
something.

This patch set depends on a couple of others that have previously been
sent to Ralf:

http://patchwork.linux-mips.org/patch/1927/
http://patchwork.linux-mips.org/patch/1850/
http://patchwork.linux-mips.org/patch/1851/
http://patchwork.linux-mips.org/patch/1852/
http://patchwork.linux-mips.org/patch/1853/
http://patchwork.linux-mips.org/patch/1854/

David Daney (6):
  MIPS: Octeon: Enable per-CPU IRQs on all CPUs.
  MIPS: Add accessor macros for 64-bit performance counter registers.
  MIPS: perf: Cleanup formatting in arch/mips/kernel/perf_event.c
  MIPS: perf: Reorganize contents of perf support files.
  MIPS: perf: Add support for 64-bit perf counters.
  MIPS: perf: Add Octeon support for hardware perf.

 arch/mips/Kconfig                    |    2 +-
 arch/mips/cavium-octeon/octeon-irq.c |   30 +-
 arch/mips/cavium-octeon/smp.c        |   10 +
 arch/mips/include/asm/mipsregs.h     |    8 +
 arch/mips/kernel/Makefile            |    5 +-
 arch/mips/kernel/perf_event.c        |  521 +--------------
 arch/mips/kernel/perf_event_mipsxx.c | 1265 +++++++++++++++++++++++++---------
 7 files changed, 977 insertions(+), 864 deletions(-)

Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
-- 
1.7.2.3
