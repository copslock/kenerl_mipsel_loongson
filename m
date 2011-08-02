Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Aug 2011 19:51:25 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:36145 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491200Ab1HBRvU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Aug 2011 19:51:20 +0200
Received: by fxd20 with SMTP id 20so73158fxd.36
        for <multiple recipients>; Tue, 02 Aug 2011 10:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=PX1elwv7/P436uVn2ExCvFKvnYqbVFOZ2JIacdIYxXQ=;
        b=vEXXR7bzgI/EPaJQwCFBKKIqsfDUVM0Y4ZQ68FHXloLqbVJB9vK+3kHZ9cMSizQkf6
         MnDcECiB8g61scUT7m0ARYbWzYdDN4bmevrrCS3o0Hp4NBqQitGyaQV1IT9mfY3lZ3Uh
         KgRnzZjGnwL60YObArPaOEGHPdZOr+vfRyF68=
Received: by 10.223.10.143 with SMTP id p15mr8431884fap.12.1312307475453;
        Tue, 02 Aug 2011 10:51:15 -0700 (PDT)
Received: from localhost.localdomain (188-22-5-211.adsl.highway.telekom.at [188.22.5.211])
        by mx.google.com with ESMTPS id r12sm3608450fam.24.2011.08.02.10.51.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 02 Aug 2011 10:51:14 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 00/15] MIPS: Alchemy updates
Date:   Tue,  2 Aug 2011 19:50:55 +0200
Message-Id: <1312307470-6841-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.6
X-archive-position: 30796
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 1611

Here's another round of Alchemy updates. It contains stuff I posted
previously plus some additional patches which accumulated in the
meantime.

Patch 1 fixes a typo,
Patch 2 removes the last hardcoded base address from Alchemy ethernet
 driver,
Patch 3 fixes suspend to ram on au1100 (it didn't enter it),
Patches 4-6 move knowledge of per-chip USB setup out of the glues into
 a common file, clean up USB setup and header information.
Patch 8 refactors GPIO a bit so that Au1000 and Au1300 GPIO headers can
 be included at the same time, and in case of GPIOLIB=y, the correct
 gpiochip is registered at runtime.
Patches 9-15 prepare for and remove all of the CONFIG_SOC_AU1??? symbols
 and the "au1xxx.h" header.
 Patch 9 removes au1xxx.h dependency from the old au1200 ide driver.
 Patch 11 kills it,
 Patch 10 removes CONFIG_SOC_AU1??? from DMA/DBDMA code
 Patch 12 does the same for au1xmmc.c
 Patches 13-14 rewrite Alchemy PCI support as a platform driver.
 Patch 15 finally does away with CONFIG_SOC_AU1???.  Some of the devices
  registered in platform.c have to be moved to the boards actually using
  them. 

I haven't yet tried it, but it should now theoretically be possible to
build one kernel which runs on all of the evaluation boards.

The whole pile has been compile tested with all alchemy defconfigs and
run-tested on Db1100,Db1200,Db1500,Db1550 and Db1300.

Manuel Lauss (15):
  MIPS: Alchemy: fix typo in MAC0 registration
  net: au1000_eth: pass MACDMA address through platform resource info.
  MIPS: Alchemy: include Au1100 in PM code.
  MIPS: Alchemy: abstract USB block control register access
  MIPS: Alchemy: rewrite USB platform setup.
  MIPS: Alchemy: more base address cleanup
  MIPS: Alchemy: always build power code
  MIPS: Alchemy: support multiple GPIO styles in one kernel
  MIPS: au1xxx: au1xxx-ide: remove pb1200/db1200 header dependencies
  MIPS: Alchemy: clean DMA code of CONFIG_SOC_AU1??? defines
  MIPS: Alchemy: kill au1xxx.h header
  MMC: au1xmmc: remove Alchemy CPU subtype dependencies
  MIPS: remove __init from add_wired_entry()
  MIPS: Alchemy: redo PCI as platform driver
  MIPS: Alchemy: remove all CONFIG_SOC_AU1??? defines

 arch/mips/Kconfig                                |    2 +
 arch/mips/alchemy/Kconfig                        |   50 +--
 arch/mips/alchemy/common/Makefile                |    8 +-
 arch/mips/alchemy/common/dbdma.c                 |  203 ++++-----
 arch/mips/alchemy/common/dma.c                   |   72 ++--
 arch/mips/alchemy/common/gpiolib-au1000.c        |  126 -----
 arch/mips/alchemy/common/gpiolib.c               |  133 +++++
 arch/mips/alchemy/common/pci.c                   |  104 ----
 arch/mips/alchemy/common/platform.c              |  372 ++++-----------
 arch/mips/alchemy/common/power.c                 |   68 +--
 arch/mips/alchemy/common/setup.c                 |    6 +-
 arch/mips/alchemy/common/usb.c                   |  337 +++++++++++++
 arch/mips/alchemy/devboards/db1200/platform.c    |  153 +++++--
 arch/mips/alchemy/devboards/db1x00/board_setup.c |   28 +-
 arch/mips/alchemy/devboards/db1x00/platform.c    |  199 +++++++-
 arch/mips/alchemy/devboards/pb1100/platform.c    |   49 ++-
 arch/mips/alchemy/devboards/pb1200/platform.c    |  190 +++++++-
 arch/mips/alchemy/devboards/pb1500/board_setup.c |   33 +-
 arch/mips/alchemy/devboards/pb1500/platform.c    |   71 +++-
 arch/mips/alchemy/devboards/pb1550/board_setup.c |    6 -
 arch/mips/alchemy/devboards/pb1550/platform.c    |  119 ++++-
 arch/mips/alchemy/gpr/board_setup.c              |   12 -
 arch/mips/alchemy/gpr/platform.c                 |   47 ++
 arch/mips/alchemy/mtx-1/board_setup.c            |   40 --
 arch/mips/alchemy/mtx-1/platform.c               |   62 +++
 arch/mips/alchemy/xxs1500/board_setup.c          |    8 -
 arch/mips/alchemy/xxs1500/platform.c             |   12 +-
 arch/mips/include/asm/mach-au1x00/au1000.h       |  559 ++++++++--------------
 arch/mips/include/asm/mach-au1x00/au1xxx.h       |   43 --
 arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h |  114 +++---
 arch/mips/include/asm/mach-au1x00/au1xxx_ide.h   |    1 +
 arch/mips/include/asm/mach-au1x00/au1xxx_psc.h   |   26 -
 arch/mips/include/asm/mach-au1x00/gpio-au1000.h  |   31 +--
 arch/mips/include/asm/mach-au1x00/gpio.h         |   79 +++-
 arch/mips/include/asm/mach-db1x00/db1200.h       |    2 -
 arch/mips/include/asm/mach-db1x00/db1x00.h       |   16 +-
 arch/mips/include/asm/mach-pb1x00/pb1200.h       |   18 +-
 arch/mips/include/asm/mach-pb1x00/pb1550.h       |   16 +-
 arch/mips/mm/tlb-r3k.c                           |    4 +-
 arch/mips/mm/tlb-r4k.c                           |    4 +-
 arch/mips/pci/Makefile                           |    3 +-
 arch/mips/pci/fixup-au1000.c                     |   43 --
 arch/mips/pci/ops-au1000.c                       |  308 ------------
 arch/mips/pci/pci-alchemy.c                      |  500 +++++++++++++++++++
 drivers/i2c/busses/Kconfig                       |    2 +-
 drivers/i2c/busses/i2c-au1550.c                  |    2 +-
 drivers/ide/Kconfig                              |    6 +-
 drivers/ide/au1xxx-ide.c                         |   46 +-
 drivers/mmc/host/Kconfig                         |    2 +-
 drivers/mmc/host/au1xmmc.c                       |   93 ++--
 drivers/mtd/nand/Kconfig                         |    2 +-
 drivers/mtd/nand/au1550nd.c                      |    6 +-
 drivers/net/au1000_eth.c                         |   48 ++-
 drivers/net/au1000_eth.h                         |    2 +-
 drivers/net/irda/Kconfig                         |    2 +-
 drivers/spi/Kconfig                              |    2 +-
 drivers/usb/Kconfig                              |    1 -
 drivers/usb/host/ehci-au1xxx.c                   |   77 +---
 drivers/usb/host/ehci-hcd.c                      |    2 +-
 drivers/usb/host/ohci-au1xxx.c                   |  110 +----
 drivers/video/Kconfig                            |    4 +-
 sound/mips/Kconfig                               |    2 +-
 sound/soc/au1x/Kconfig                           |    2 +-
 63 files changed, 2514 insertions(+), 2174 deletions(-)
 delete mode 100644 arch/mips/alchemy/common/gpiolib-au1000.c
 create mode 100644 arch/mips/alchemy/common/gpiolib.c
 delete mode 100644 arch/mips/alchemy/common/pci.c
 create mode 100644 arch/mips/alchemy/common/usb.c
 delete mode 100644 arch/mips/include/asm/mach-au1x00/au1xxx.h
 delete mode 100644 arch/mips/pci/fixup-au1000.c
 delete mode 100644 arch/mips/pci/ops-au1000.c
 create mode 100644 arch/mips/pci/pci-alchemy.c

-- 
1.7.6
