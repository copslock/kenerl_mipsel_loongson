Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2012 11:36:10 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:36925 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903693Ab2BQKdg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Feb 2012 11:33:36 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH 0/9] MIPS: lantiq: convert to clkdev api
Date:   Fri, 17 Feb 2012 11:33:11 +0100
Message-Id: <1329474800-20979-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
X-archive-position: 32444
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

arch/mips/lantiq/* used its own functions to handle some clocks and the clock
gating. This series changes the code to use clkdev api instead.

This change also allows us to merge the clock code for all xway socs into a
single file.


John Crispin (9):
  MIPS: add clkdev.h
  MIPS: lantiq: convert to clkdev api
  MIPS: lantiq: convert xway to clkdev api
  MIPS: lantiq: convert falcon to clkdev api
  MIPS: lantiq: convert dma driver to clkdev api
  MIPS: lantiq: convert gpio_stp driver to clkdev api
  SERIAL: MIPS: lantiq: convert serial driver to clkdev api
  NET: MIPS: lantiq: convert etop driver to clkdev api
  WDT: MIPS: lantiq: convert watchdog driver to clkdev api

 arch/mips/Kconfig                                  |    3 +-
 arch/mips/include/asm/clkdev.h                     |   25 ++
 .../include/asm/mach-lantiq/falcon/lantiq_soc.h    |    8 +-
 arch/mips/include/asm/mach-lantiq/lantiq.h         |   17 +-
 .../mips/include/asm/mach-lantiq/xway/lantiq_soc.h |   13 -
 arch/mips/lantiq/clk.c                             |   85 +++----
 arch/mips/lantiq/clk.h                             |   59 ++++-
 arch/mips/lantiq/falcon/Makefile                   |    2 +-
 arch/mips/lantiq/falcon/clk.c                      |   44 ----
 arch/mips/lantiq/falcon/sysctrl.c                  |  131 ++++++----
 arch/mips/lantiq/prom.c                            |    1 -
 arch/mips/lantiq/xway/Makefile                     |    6 +-
 arch/mips/lantiq/xway/clk-ase.c                    |   48 ----
 arch/mips/lantiq/xway/clk-xway.c                   |  223 ----------------
 arch/mips/lantiq/xway/clk.c                        |  266 ++++++++++++++++++++
 arch/mips/lantiq/xway/dma.c                        |    5 +-
 arch/mips/lantiq/xway/gpio_stp.c                   |    6 +-
 arch/mips/lantiq/xway/sysctrl.c                    |  106 +++++++-
 drivers/net/ethernet/lantiq_etop.c                 |   27 ++-
 drivers/tty/serial/lantiq.c                        |    2 +-
 drivers/watchdog/lantiq_wdt.c                      |    2 +-
 21 files changed, 603 insertions(+), 476 deletions(-)
 create mode 100644 arch/mips/include/asm/clkdev.h
 delete mode 100644 arch/mips/lantiq/falcon/clk.c
 delete mode 100644 arch/mips/lantiq/xway/clk-ase.c
 delete mode 100644 arch/mips/lantiq/xway/clk-xway.c
 create mode 100644 arch/mips/lantiq/xway/clk.c

-- 
1.7.7.1
