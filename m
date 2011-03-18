Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Mar 2011 22:49:25 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:3464 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491115Ab1CRVtH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Mar 2011 22:49:07 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d83d3870002>; Fri, 18 Mar 2011 14:49:59 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 18 Mar 2011 14:48:49 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 18 Mar 2011 14:48:49 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p2ILmgbP011178;
        Fri, 18 Mar 2011 14:48:42 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p2ILmehG011176;
        Fri, 18 Mar 2011 14:48:40 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     tglx@linutronix.de, linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org,
        David Daney <ddaney@caviumnetworks.com>
Subject: [RFC PATCH 0/2] Add IRQ chip hooks for taking CPUs on/off line.
Date:   Fri, 18 Mar 2011 14:48:34 -0700
Message-Id: <1300484916-11133-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 18 Mar 2011 21:48:49.0283 (UTC) FILETIME=[43B36530:01CBE5B6]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29414
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

When a CPU is brought on-line, per-CPU interrupts need to be enabled
on the new CPU.  The local timer and things like perf counters that
rely on interrupts don't work if their interrupts are not enabled.

Likewise when a CPU is taken off-line, we may need to clean up the
interrupts.

I solve both of these problems by adding a pair of function pointers
to the irq_chip structure, along with some simple helper functions to
call them.

When the CPU is being brought on-line, but before interrupts are
enabled, I iterate through all possible IRQs and invoke their
irq_cpu_online() hooks.  Most of these are null, so are not called,
but my per-CPU IRQs do have hooks and the corresponding signals are
routed to the new CPU.

There are two patches here.

1) Changes to the core irq code.

2) My SOC/Board interrupt handling rewrite that uses the new
   functions.


David Daney (2):
  genirq: Add chip hooks for taking CPUs on/off line.
  MIPS: Octeon: Rewrite interrupt handling code.

 arch/mips/Kconfig                              |    1 +
 arch/mips/cavium-octeon/octeon-irq.c           | 1388 ++++++++++++++----------
 arch/mips/cavium-octeon/setup.c                |   12 -
 arch/mips/cavium-octeon/smp.c                  |   39 +-
 arch/mips/include/asm/mach-cavium-octeon/irq.h |  243 ++---
 arch/mips/include/asm/octeon/octeon.h          |    2 +
 arch/mips/pci/msi-octeon.c                     |   20 +-
 include/linux/irq.h                            |    8 +
 include/linux/irqdesc.h                        |    6 +
 kernel/irq/chip.c                              |   35 +
 10 files changed, 968 insertions(+), 786 deletions(-)

-- 
1.7.2.3
