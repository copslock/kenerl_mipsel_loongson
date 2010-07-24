Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jul 2010 03:42:12 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:16596 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492616Ab0GXBmI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Jul 2010 03:42:08 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c4a450a0000>; Fri, 23 Jul 2010 18:42:34 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 23 Jul 2010 18:42:06 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 23 Jul 2010 18:42:06 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o6O1fupJ004046;
        Fri, 23 Jul 2010 18:41:56 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o6O1fphR004044;
        Fri, 23 Jul 2010 18:41:51 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org, wim@iguana.be
Cc:     linux-kernel@vger.kernel.org,
        David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 0/7] Watchdog driver for Octeon SOCs.
Date:   Fri, 23 Jul 2010 18:41:40 -0700
Message-Id: <1279935707-3997-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.1.1
X-OriginalArrivalTime: 24 Jul 2010 01:42:06.0859 (UTC) FILETIME=[6C977DB0:01CB2AD1]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27466
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The main point of this patch set is to add a watchdog driver for
Octeon SOCs.  There is however, some perperation that has to be done
first.

The first two patches add some instructions to the MIPS uasm that are
needed by the watchdog.

If we want the watchdog to be usable as a module we need to export the
uasm APIs, prom_putchar and  __cpu_*_map (third, forth and fifth patchs).

The watch dog tests the c0_Status.NMI bit, so we define this in the
sixth patch.

That brings us to the grand finale, the watchdog driver itself.


David Daney (7):
  MIPS: Add drotr32 and uasm_i_drotr_safe to uasm.
  MIPS: Add BBIT0 and BBIT1 instructions to uasm
  MIPS: Add option to export uasm API.
  MIPS: Octeon: Export prom_putchar().
  MIPS: Export __cpu_number_map and __cpu_logical_map.
  MIPS: Define ST0_NMI in asm/mipsregs.h
  watchdog: Add watchdog driver for OCTEON SOCs.

 arch/mips/Kconfig                  |    3 +
 arch/mips/cavium-octeon/setup.c    |    6 +-
 arch/mips/include/asm/mipsregs.h   |    1 +
 arch/mips/include/asm/uasm.h       |   51 ++-
 arch/mips/kernel/cpu-bugs64.c      |    2 +-
 arch/mips/kernel/smp.c             |    4 +
 arch/mips/mm/uasm.c                |  162 ++++++---
 drivers/watchdog/Kconfig           |   18 +
 drivers/watchdog/Makefile          |    2 +
 drivers/watchdog/octeon-wdt-main.c |  745 ++++++++++++++++++++++++++++++++++++
 drivers/watchdog/octeon-wdt-nmi.S  |   64 +++
 11 files changed, 990 insertions(+), 68 deletions(-)
 create mode 100644 drivers/watchdog/octeon-wdt-main.c
 create mode 100644 drivers/watchdog/octeon-wdt-nmi.S
