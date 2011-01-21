Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Jan 2011 00:32:37 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:13953 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491831Ab1AUXcJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 22 Jan 2011 00:32:09 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d3a17a70001>; Fri, 21 Jan 2011 15:32:55 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 21 Jan 2011 15:32:06 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 21 Jan 2011 15:32:06 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p0LNW2Ve029168;
        Fri, 21 Jan 2011 15:32:02 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p0LNW1mK029166;
        Fri, 21 Jan 2011 15:32:01 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH v2 0/3] MIPS: Octeon: Add perf support.
Date:   Fri, 21 Jan 2011 15:31:57 -0800
Message-Id: <1295652720-29131-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 21 Jan 2011 23:32:06.0640 (UTC) FILETIME=[6A7B0700:01CBB9C3]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29019
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The first two patches fix the Octeon interrupt support so that the
perf interrupts work right.

The last patch actually adds support for the Octeon hardware perf counters.

Change from v1:

o Remove these patches from the set for 64-bit counters.

Chandrakala Chavva (1):
  MIPS: Octeon: Fix interrupt irq settings for performance counters.

David Daney (2):
  MIPS: Octeon: Enable per-CPU IRQs on all CPUs.
  MIPS: perf: Add Octeon support for hardware perf.

 arch/mips/Kconfig                                  |    2 +-
 arch/mips/cavium-octeon/octeon-irq.c               |   30 ++++-
 arch/mips/cavium-octeon/setup.c                    |    7 -
 arch/mips/cavium-octeon/smp.c                      |   10 ++
 .../asm/mach-cavium-octeon/kernel-entry-init.h     |    5 +
 arch/mips/kernel/perf_event_mipsxx.c               |  147 ++++++++++++++++++++
 6 files changed, 190 insertions(+), 11 deletions(-)

-- 
1.7.2.3
