Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Aug 2011 11:40:04 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:50901 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491153Ab1HLJjz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Aug 2011 11:39:55 +0200
Received: by fxd20 with SMTP id 20so2860465fxd.36
        for <multiple recipients>; Fri, 12 Aug 2011 02:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=nbpP1uGZewVw8PuUcSIXMe2MG9kopu6lKGmIEIKGPKU=;
        b=PHBT063+YFp9avZeHxhyNl6NpmYrnXPZ8A4UwE082u50rkMjdzoecp6DFsM/6pPAsx
         DJgxFCVWbAMbrwpfomXi5Gy2GgTGna9eLejFAoSL0Md6EQp9Yfrje7QrgunPp0GezqGv
         mrdYITkzPgdGLdGoegyqGOM5hpRTwftYl2Xx4=
Received: by 10.223.161.214 with SMTP id s22mr989576fax.59.1313141990608;
        Fri, 12 Aug 2011 02:39:50 -0700 (PDT)
Received: from localhost.localdomain (178-191-11-228.adsl.highway.telekom.at [178.191.11.228])
        by mx.google.com with ESMTPS id s14sm467338fah.29.2011.08.12.02.39.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 12 Aug 2011 02:39:49 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH RESEND 0/8] MIPS: Alchemy updates
Date:   Fri, 12 Aug 2011 11:39:37 +0200
Message-Id: <1313141985-5830-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.6
X-archive-position: 30855
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9259

This is a resend of the Alchemy updates without the patches Ralf already
accepted and with Cc's added to others.

Patches 1-3 move knowledge of per-chip USB setup out of the glues into
 a common file, clean up USB setup and header information.

Patches 4-8 prepare for and remove all of the CONFIG_SOC_AU1??? symbols
 and the "au1xxx.h" header.
 Patch 4 removes au1xxx.h dependency from the old au1200 ide driver.
 Patch 6 kills it,
 Patch 5 removes CONFIG_SOC_AU1??? from DMA/DBDMA code
 Patch 7 rewrites Alchemy PCI support as a platform driver.
 Patch 8 finally does away with CONFIG_SOC_AU1???.  Some of the devices
  registered in platform.c have to be moved to the boards actually using
  them. 

Manuel Lauss (8):
  MIPS: Alchemy: abstract USB block control register access
  MIPS: Alchemy: rewrite USB platform setup.
  MIPS: Alchemy: more base address cleanup
  MIPS: au1xxx: au1xxx-ide: remove pb1200/db1200 header dependencies
  MIPS: Alchemy: clean DMA code of CONFIG_SOC_AU1??? defines
  MIPS: Alchemy: kill au1xxx.h header
  MIPS: Alchemy: redo PCI as platform driver
  MIPS: Alchemy: remove all CONFIG_SOC_AU1??? defines

The whole pile has been compile tested with all alchemy defconfigs and
run-tested on Db1100,Db1200,Db1500,Db1550 and Db1300.

 arch/mips/Kconfig                                |    2 +
 arch/mips/alchemy/Kconfig                        |   50 +--
 arch/mips/alchemy/common/Makefile                |    4 +-
 arch/mips/alchemy/common/dbdma.c                 |  203 ++++-----
 arch/mips/alchemy/common/dma.c                   |   72 ++--
 arch/mips/alchemy/common/pci.c                   |  104 ----
 arch/mips/alchemy/common/platform.c              |  340 +++-----------
 arch/mips/alchemy/common/power.c                 |   42 --
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
 arch/mips/include/asm/mach-db1x00/db1200.h       |    2 -
 arch/mips/include/asm/mach-db1x00/db1x00.h       |   16 +-
 arch/mips/include/asm/mach-pb1x00/pb1200.h       |   18 +-
 arch/mips/include/asm/mach-pb1x00/pb1550.h       |   16 +-
 arch/mips/pci/Makefile                           |    3 +-
 arch/mips/pci/fixup-au1000.c                     |   43 --
 arch/mips/pci/ops-au1000.c                       |  308 ------------
 arch/mips/pci/pci-alchemy.c                      |  516 ++++++++++++++++++++
 drivers/i2c/busses/Kconfig                       |    2 +-
 drivers/i2c/busses/i2c-au1550.c                  |    2 +-
 drivers/ide/Kconfig                              |    6 +-
 drivers/ide/au1xxx-ide.c                         |   46 +-
 drivers/mmc/host/Kconfig                         |    2 +-
 drivers/mtd/nand/Kconfig                         |    2 +-
 drivers/mtd/nand/au1550nd.c                      |    6 +-
 drivers/net/irda/Kconfig                         |    2 +-
 drivers/spi/Kconfig                              |    2 +-
 drivers/usb/Kconfig                              |    1 -
 drivers/usb/host/ehci-au1xxx.c                   |   77 +---
 drivers/usb/host/ehci-hcd.c                      |    2 +-
 drivers/usb/host/ohci-au1xxx.c                   |  110 +----
 drivers/video/Kconfig                            |    4 +-
 sound/mips/Kconfig                               |    2 +-
 sound/soc/au1x/Kconfig                           |    2 +-
 54 files changed, 2191 insertions(+), 1931 deletions(-)
 delete mode 100644 arch/mips/alchemy/common/pci.c
 create mode 100644 arch/mips/alchemy/common/usb.c
 delete mode 100644 arch/mips/include/asm/mach-au1x00/au1xxx.h
 delete mode 100644 arch/mips/pci/fixup-au1000.c
 delete mode 100644 arch/mips/pci/ops-au1000.c
 create mode 100644 arch/mips/pci/pci-alchemy.c

-- 
1.7.6
