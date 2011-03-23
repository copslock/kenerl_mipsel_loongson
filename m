Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2011 22:08:53 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:47401 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491880Ab1CWVIv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Mar 2011 22:08:51 +0100
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q2VIK-0001vE-CH; Wed, 23 Mar 2011 22:08:44 +0100
Message-Id: <20110323210437.398062704@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Wed, 23 Mar 2011 21:08:44 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [patch 00/38] mips: irq chip overhaul and cleanup
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29429
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

Ralf,

the following series converts all mips irq chips to the new callbacks
and makes use of the enhancements which were made in the genirq core
code. That series includes two patches from Lars which do the initial
conversion of jz4740.

It requires two patches which are in

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip irq/for-mips

Please pull that branch into your tree.

The series is compile tested as far as the defconfigs compile. Some of
them refuse to build before that series, so I ignored them.

tarball of the quilt series can be found here for your conveniance:

	http://master.kernel.org/~tglx/patches.tar.bz2

Thanks,

	tglx
---

 Kconfig                          |    2 
 alchemy/common/irq.c             |   98 ++++++++--------
 alchemy/devboards/bcsr.c         |   18 +-
 ar7/irq.c                        |   42 +++---
 ath79/irq.c                      |   23 +--
 bcm63xx/irq.c                    |   77 +++++-------
 cavium-octeon/octeon-irq.c       |  237 ++++++++++++++++++---------------------
 dec/ioasic-irq.c                 |   60 ++-------
 dec/kn02-irq.c                   |   23 +--
 emma/markeins/irq.c              |   67 ++++-------
 include/asm/irq.h                |   64 +++++-----
 jazz/irq.c                       |   14 --
 jz4740/gpio.c                    |  111 ++++++++----------
 jz4740/irq.c                     |   32 +++--
 kernel/i8259.c                   |   37 ++----
 kernel/irq-gic.c                 |   44 ++-----
 kernel/irq-gt641xx.c             |   26 ++--
 kernel/irq-msc01.c               |   51 +++-----
 kernel/irq-rm7000.c              |   18 +-
 kernel/irq-rm9000.c              |   49 +++-----
 kernel/irq.c                     |   49 --------
 kernel/irq_cpu.c                 |   46 +++----
 kernel/irq_txx9.c                |   28 ++--
 kernel/smtc.c                    |   13 --
 lasat/interrupt.c                |   16 +-
 loongson/common/bonito-irq.c     |   16 +-
 mti-malta/malta-smtc.c           |    9 -
 pci/msi-octeon.c                 |   20 +--
 pmc-sierra/msp71xx/msp_irq_cic.c |   41 ++----
 pmc-sierra/msp71xx/msp_irq_per.c |   80 ++-----------
 pmc-sierra/msp71xx/msp_irq_slp.c |   18 +-
 pnx833x/common/interrupts.c      |   98 ++--------------
 pnx8550/common/int.c             |   18 +-
 powertv/asic/irq_asic.c          |   13 --
 rb532/irq.c                      |   32 ++---
 sgi-ip22/ip22-int.c              |   60 ++++-----
 sgi-ip27/ip27-irq.c              |   38 ++----
 sgi-ip27/ip27-timer.c            |   11 -
 sgi-ip32/ip32-irq.c              |  134 ++++++----------------
 sibyte/bcm1480/irq.c             |   55 +++------
 sibyte/sb1250/irq.c              |   53 ++------
 sni/a20r.c                       |   23 ---
 sni/pcimt.c                      |   21 ---
 sni/pcit.c                       |   21 ---
 sni/rm200.c                      |   42 ++----
 txx9/generic/irq_tx4939.c        |   28 ++--
 txx9/jmr3927/irq.c               |   14 --
 txx9/rbtx4927/irq.c              |   58 ++++-----
 txx9/rbtx4938/irq.c              |   54 +++-----
 txx9/rbtx4939/irq.c              |   14 --
 vr41xx/common/icu.c              |   72 +++++------
 vr41xx/common/irq.c              |   19 +--
 52 files changed, 944 insertions(+), 1363 deletions(-)
