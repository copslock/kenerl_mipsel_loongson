Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jun 2009 01:58:08 +0200 (CEST)
Received: from fw1-az.mvista.com ([65.200.49.156]:54641 "EHLO
	shomer.az.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by ftp.linux-mips.org with ESMTP id S1492818AbZFPX6A (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 17 Jun 2009 01:58:00 +0200
Received: from shomer.az.mvista.com (localhost.localdomain [127.0.0.1])
	by shomer.az.mvista.com (8.14.2/8.14.2) with ESMTP id n5GNufr5006372;
	Tue, 16 Jun 2009 16:56:41 -0700
Received: (from tsa@localhost)
	by shomer.az.mvista.com (8.14.2/8.14.2/Submit) id n5GNuee3006371;
	Tue, 16 Jun 2009 16:56:40 -0700
Date:	Tue, 16 Jun 2009 16:56:40 -0700
From:	Tim Anderson <tanderson@mvista.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH 0/5] Get 4 core 1004K Malta board working
Message-ID: <20090616235640.GC6346@shomer.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <tsa@shomer.az.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23436
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tanderson@mvista.com
Precedence: bulk
X-list: linux-mips

The following 5 patches add the modifications needed
to have the Malta 1004K board operational with 4 cores.

Tim Anderson (5):
  Extend the GIC IPI interrupts beyond 32
  Extend IPI handling to CPU number
  activate CMP support
  Move gcmp_probe to before the SMP ops
  Synchronise Count registers across multiple cores

 arch/mips/Kconfig                 |    2 +-
 arch/mips/include/asm/amon.h      |    7 ++
 arch/mips/include/asm/gcmpregs.h  |    2 +
 arch/mips/include/asm/gic.h       |    6 ++
 arch/mips/include/asm/r4k-timer.h |    2 +-
 arch/mips/kernel/irq-gic.c        |   19 ++---
 arch/mips/kernel/smp-cmp.c        |   66 +---------------
 arch/mips/mti-malta/malta-init.c  |   11 +++-
 arch/mips/mti-malta/malta-int.c   |   89 +++++++++++----------
 arch/mips/mti-malta/malta-time.c  |  154 +++++++++++++++++++++++++++++++++++++
 10 files changed, 241 insertions(+), 117 deletions(-)
 create mode 100644 arch/mips/include/asm/amon.h
