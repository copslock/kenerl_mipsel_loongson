Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Aug 2011 10:30:06 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:53091 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493615Ab1HXIaB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Aug 2011 10:30:01 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        Thomas Langer <thomas.langer@lantiq.com>,
        linux-mips@linux-mips.org
Subject: [PATCH 0/8] MIPS: lantiq: some fixes and support FALC-ON
Date:   Wed, 24 Aug 2011 10:31:36 +0200
Message-Id: <1314174704-15549-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 30965
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17641

This series adds support for the FALC-ON SoC made by Lantiq. In addition it
also fixes some bugs related to early_printk, cmdline parsing and the watchdog
code.


Signed-off-by: Thomas Langer <thomas.langer@lantiq.com>
Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: linux-mips@linux-mips.org


John Crispin (8):
  MIPS: lantiq: fix early printk
  MIPS: lantiq: fix cmdline parsing
  MIPS: lantiq: fix watchdogs timeout handling
  MIPS: lantiq: reorganize xway code
  MIPS: lantiq: make irq.c support the FALC-ON
  MIPS: lantiq: add basic support for FALC-ON
  MIPS: lantiq: add support for FALC-ON GPIOs
  MIPS: lantiq: add support for the EASY98000 evaluation board

 .../include/asm/mach-lantiq/falcon/falcon_irq.h    |  268 +++++++++++++
 arch/mips/include/asm/mach-lantiq/falcon/irq.h     |   18 +
 .../include/asm/mach-lantiq/falcon/lantiq_soc.h    |  140 +++++++
 arch/mips/include/asm/mach-lantiq/lantiq.h         |   15 +-
 .../mips/include/asm/mach-lantiq/xway/lantiq_soc.h |   18 +
 arch/mips/lantiq/Kconfig                           |    4 +
 arch/mips/lantiq/Makefile                          |    1 +
 arch/mips/lantiq/Platform                          |    1 +
 arch/mips/lantiq/clk.c                             |   25 +--
 arch/mips/lantiq/devices.c                         |   30 +--
 arch/mips/lantiq/devices.h                         |    4 +
 arch/mips/lantiq/early_printk.c                    |   14 +-
 arch/mips/lantiq/falcon/Kconfig                    |   11 +
 arch/mips/lantiq/falcon/Makefile                   |    2 +
 arch/mips/lantiq/falcon/clk.c                      |   44 +++
 arch/mips/lantiq/falcon/devices.c                  |  128 +++++++
 arch/mips/lantiq/falcon/devices.h                  |   20 +
 arch/mips/lantiq/falcon/gpio.c                     |  398 ++++++++++++++++++++
 arch/mips/lantiq/falcon/mach-easy98000.c           |  110 ++++++
 arch/mips/lantiq/falcon/prom.c                     |   72 ++++
 arch/mips/lantiq/falcon/reset.c                    |   87 +++++
 arch/mips/lantiq/falcon/sysctrl.c                  |  181 +++++++++
 arch/mips/lantiq/irq.c                             |   24 +-
 arch/mips/lantiq/machtypes.h                       |    5 +
 arch/mips/lantiq/prom.c                            |   56 +++-
 arch/mips/lantiq/prom.h                            |    4 +
 arch/mips/lantiq/xway/Makefile                     |    6 +-
 arch/mips/lantiq/xway/devices.c                    |   42 +--
 arch/mips/lantiq/xway/dma.c                        |   21 +-
 arch/mips/lantiq/xway/ebu.c                        |   53 ---
 arch/mips/lantiq/xway/pmu.c                        |   70 ----
 arch/mips/lantiq/xway/prom-ase.c                   |    9 +
 arch/mips/lantiq/xway/prom-xway.c                  |   10 +
 arch/mips/lantiq/xway/reset.c                      |   21 +-
 arch/mips/lantiq/xway/setup-ase.c                  |   19 -
 arch/mips/lantiq/xway/setup-xway.c                 |   20 -
 arch/mips/lantiq/xway/sysctrl.c                    |   77 ++++
 drivers/watchdog/lantiq_wdt.c                      |   10 +-
 38 files changed, 1721 insertions(+), 317 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-lantiq/falcon/falcon_irq.h
 create mode 100644 arch/mips/include/asm/mach-lantiq/falcon/irq.h
 create mode 100644 arch/mips/include/asm/mach-lantiq/falcon/lantiq_soc.h
 create mode 100644 arch/mips/lantiq/falcon/Kconfig
 create mode 100644 arch/mips/lantiq/falcon/Makefile
 create mode 100644 arch/mips/lantiq/falcon/clk.c
 create mode 100644 arch/mips/lantiq/falcon/devices.c
 create mode 100644 arch/mips/lantiq/falcon/devices.h
 create mode 100644 arch/mips/lantiq/falcon/gpio.c
 create mode 100644 arch/mips/lantiq/falcon/mach-easy98000.c
 create mode 100644 arch/mips/lantiq/falcon/prom.c
 create mode 100644 arch/mips/lantiq/falcon/reset.c
 create mode 100644 arch/mips/lantiq/falcon/sysctrl.c
 delete mode 100644 arch/mips/lantiq/xway/ebu.c
 delete mode 100644 arch/mips/lantiq/xway/pmu.c
 delete mode 100644 arch/mips/lantiq/xway/setup-ase.c
 delete mode 100644 arch/mips/lantiq/xway/setup-xway.c
 create mode 100644 arch/mips/lantiq/xway/sysctrl.c

-- 
1.7.2.3
