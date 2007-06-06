Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2007 05:46:11 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:19948 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20022075AbXFFEnz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 Jun 2007 05:43:55 +0100
Received: (qmail 26261 invoked by uid 511); 6 Jun 2007 04:50:07 -0000
Received: from unknown (HELO localhost.localdomain) (192.168.2.233)
  by lemote.com with SMTP; 6 Jun 2007 04:50:07 -0000
From:	tiansm@lemote.com
To:	linux-mips@linux-mips.org
Subject: Lemote Loongson 2E patch update
Date:	Wed,  6 Jun 2007 12:42:27 +0800
Message-Id: <11811049622818-git-send-email-tiansm@lemote.com>
X-Mailer: git-send-email 1.5.2.1
Return-Path: <tiansm@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15270
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiansm@lemote.com
Precedence: bulk
X-list: linux-mips


loongson 2e patch updated for 2.6.22-rc4

arch/mips/Kconfig                            |   37 ++
arch/mips/Makefile                           |    8
arch/mips/kernel/Makefile                    |    1
arch/mips/kernel/cpu-probe.c                 |    9
arch/mips/kernel/proc.c                      |    2
arch/mips/kernel/setup.c                     |    9
arch/mips/lemote/lm2e/Makefile               |    7
arch/mips/lemote/lm2e/bonito-irq.c           |   74 +++++
arch/mips/lemote/lm2e/dbg_io.c               |  146 ++++++++++
arch/mips/lemote/lm2e/irq.c                  |  146 ++++++++++
arch/mips/lemote/lm2e/pci.c                  |   72 +++++
arch/mips/lemote/lm2e/prom.c                 |  109 +++++++
arch/mips/lemote/lm2e/reset.c                |   49 +++
arch/mips/lemote/lm2e/setup.c                |  144 ++++++++++
arch/mips/lib-32/Makefile                    |    1
arch/mips/lib-64/Makefile                    |    1
arch/mips/mm/Makefile                        |    1
arch/mips/mm/c-r4k.c                         |   58 ++++
arch/mips/mm/tlb-r4k.c                       |   23 +
arch/mips/mm/tlbex.c                         |    9
arch/mips/pci/Makefile                       |    2
arch/mips/pci/fixup-lm2e.c                   |  255 ++++++++++++++++++
arch/mips/pci/ops-lm2e.c                     |  153 ++++++++++
drivers/char/mem.c                           |    5
include/asm-mips/addrspace.h                 |    3
include/asm-mips/bootinfo.h                  |    7
include/asm-mips/cacheops.h                  |    5
include/asm-mips/cpu.h                       |    8
include/asm-mips/mach-lemote/bonito.h        |  381 +++++++++++++++++++++++++++
include/asm-mips/mach-lemote/dma-coherence.h |   43 +++
include/asm-mips/mach-lemote/mc146818rtc.h   |   37 ++
include/asm-mips/module.h                    |    3
include/asm-mips/serial.h                    |   10
33 files changed, 1796 insertions(+), 22 deletions(-)
