Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jul 2010 19:44:39 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:9759 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492139Ab0GWRoD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Jul 2010 19:44:03 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c49d4fc0000>; Fri, 23 Jul 2010 10:44:28 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 23 Jul 2010 10:44:01 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 23 Jul 2010 10:44:00 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o6NHht9v024109;
        Fri, 23 Jul 2010 10:43:55 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o6NHhqKe024108;
        Fri, 23 Jul 2010 10:43:52 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 0/5] Interrupt handling improvements for OCTEON
Date:   Fri, 23 Jul 2010 10:43:44 -0700
Message-Id: <1279907029-24071-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.1.1
X-OriginalArrivalTime: 23 Jul 2010 17:44:00.0988 (UTC) FILETIME=[A27AF1C0:01CB2A8E]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27445
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

There were some areas where the OCTEON interrupt handling code could
be improved:

o Octeon irq affinity was a little weird.

o MSI code was spread out into several different files/directories.

o IRQ migration on CPU hot-plug was fragil to the point of almost
  being completely broken.

This patch set aims to make things better.

David Daney (5):
  MIPS: Octeon: Move MSI code out of octeon-irq.c.
  MIPS: Octeon: Improve interrupt handling.
  MIPS: Octeon: Fix fixup_irqs for HOTPLUG_CPU
  MIPS: Octeon: Get rid of a bunch of MSI IRQ number definitions.
  MIPS: Octeon: Make MSI use handle_simple_irq().

 arch/mips/cavium-octeon/octeon-irq.c           |  553 ++++++++++++++----------
 arch/mips/include/asm/mach-cavium-octeon/irq.h |   66 +---
 arch/mips/pci/msi-octeon.c                     |  103 ++++-
 3 files changed, 404 insertions(+), 318 deletions(-)
