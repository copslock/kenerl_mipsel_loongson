Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Mar 2011 20:39:09 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:19559 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491198Ab1CYTjF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Mar 2011 20:39:05 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d8cef8b0001>; Fri, 25 Mar 2011 12:39:55 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 25 Mar 2011 12:38:59 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 25 Mar 2011 12:38:59 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p2PJctQg011278;
        Fri, 25 Mar 2011 12:38:56 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p2PJcsEg011277;
        Fri, 25 Mar 2011 12:38:54 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     tglx@linutronix.de, linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     linux-kernel@vger.kernel.org,
        David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH v3 0/4] Add IRQ chip hooks for taking CPUs on/off line.
Date:   Fri, 25 Mar 2011 12:38:47 -0700
Message-Id: <1301081931-11240-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 25 Mar 2011 19:38:59.0048 (UTC) FILETIME=[49401E80:01CBEB24]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29563
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

There are a pair of helper functions, irq_cpu_{on,off}line(), iterate
through all irqs calling the chip.irq_cpu_{on,off}line() for each irq.

For this iteration to work, we must make sure that all active irqs are
in the allocated_irqs set.  To do this we call irq_reserve_irq() from
irq_set_chip().

My chip.irq_cpu_offline() need to adjust the affinity of some irqs, so
I split up irq_set_affinity() in to two parts, one of which I can call
with the irq desc lock held.

Finally I completely rewrite my irq handling code which uses the
changes to the core irq code.

David Daney (4):
  genirq: Reserve the irq when calling irq_set_chip()
  genirq: Add chip hooks for taking CPUs on/off line.
  genirq: Split irq_set_affinity() so it can be called with lock held.
  MIPS: Octeon: Rewrite interrupt handling code.

 arch/mips/cavium-octeon/octeon-irq.c           | 1423 ++++++++++++++----------
 arch/mips/cavium-octeon/setup.c                |   12 -
 arch/mips/cavium-octeon/smp.c                  |   39 +-
 arch/mips/include/asm/mach-cavium-octeon/irq.h |  243 ++---
 arch/mips/include/asm/octeon/octeon.h          |    2 +
 arch/mips/pci/msi-octeon.c                     |   20 +-
 include/linux/interrupt.h                      |    2 +
 include/linux/irq.h                            |    8 +
 kernel/irq/chip.c                              |   68 ++
 kernel/irq/manage.c                            |   40 +-
 10 files changed, 1026 insertions(+), 831 deletions(-)

-- 
1.7.2.3
