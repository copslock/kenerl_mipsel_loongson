Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jun 2009 01:22:05 +0200 (CEST)
Received: from fw1-az.mvista.com ([65.200.49.156]:4823 "EHLO
	shomer.az.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by ftp.linux-mips.org with ESMTP id S1492154AbZFQXV6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 18 Jun 2009 01:21:58 +0200
Received: from shomer.az.mvista.com (localhost.localdomain [127.0.0.1])
	by shomer.az.mvista.com (8.14.2/8.14.2) with ESMTP id n5HNKKFw010731
	for <linux-mips@linux-mips.org>; Wed, 17 Jun 2009 16:20:20 -0700
Received: (from tsa@localhost)
	by shomer.az.mvista.com (8.14.2/8.14.2/Submit) id n5HNKJm2010730
	for linux-mips@linux-mips.org; Wed, 17 Jun 2009 16:20:19 -0700
Date:	Wed, 17 Jun 2009 16:20:19 -0700
From:	Tim Anderson <tanderson@mvista.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH 0/5] Get 4 core 1004K Malta board working v2
Message-ID: <20090617232019.GA10714@shomer.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <tsa@shomer.az.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23457
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tanderson@mvista.com
Precedence: bulk
X-list: linux-mips

The following 5 patches add the modifications necessary
to have the Malta 1004K board operational with 4 cores.
This is version 2, I  have updated patches 2, 4 and 5
based on comments from the mail list.

Tim Anderson (5):
  Extend the GIC IPI interrupts beyond 32
  Extend IPI handling to CPU number
  activate CMP support
  Move gcmp_probe to before the SMP ops
  Update sync-r4k for current kernel

 arch/mips/Kconfig                |    4 +-
 arch/mips/include/asm/amon.h     |    7 +++
 arch/mips/include/asm/gcmpregs.h |    2 +
 arch/mips/include/asm/gic.h      |    6 +++
 arch/mips/kernel/irq-gic.c       |   19 +++-----
 arch/mips/kernel/smp-cmp.c       |   66 ++--------------------------
 arch/mips/kernel/sync-r4k.c      |   26 ++++++-----
 arch/mips/mti-malta/malta-init.c |   14 ++++++-
 arch/mips/mti-malta/malta-int.c  |   89 ++++++++++++++++++++------------------
 9 files changed, 104 insertions(+), 129 deletions(-)
 create mode 100644 arch/mips/include/asm/amon.h
