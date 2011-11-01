Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Nov 2011 20:04:06 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:32904 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903686Ab1KATEB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Nov 2011 20:04:01 +0100
Received: by faaq17 with SMTP id q17so947590faa.36
        for <multiple recipients>; Tue, 01 Nov 2011 12:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=jPZQHwIt0YJ6etljKaRa9DsYVdkvv34en04ig0pr9pg=;
        b=TNrFVGXfMfokVOQ9kbRq06WkyRQ/z9D63/kCHG/ZdvZRoLO0uFgplLtVy5MrhUUp1t
         0bcQF2+M4HoaYrzhdlaRRd3EuoPTA7isDA3vhiTd44bZkiishIpdf0jEz9ilcWHc+8TT
         pcfhu8GSJ8yiPdJvoFaeBjoh3kTV/SLxnaScU=
Received: by 10.223.5.201 with SMTP id 9mr2692787faw.5.1320174235746;
        Tue, 01 Nov 2011 12:03:55 -0700 (PDT)
Received: from localhost.localdomain (188-22-150-81.adsl.highway.telekom.at. [188.22.150.81])
        by mx.google.com with ESMTPS id a8sm327916faa.11.2011.11.01.12.03.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Nov 2011 12:03:54 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 00/18] MIPS: Alchemy board and driver updates
Date:   Tue,  1 Nov 2011 20:03:26 +0100
Message-Id: <1320174224-27305-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.7.1
X-archive-position: 31340
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 646

Here's a collection of patches to the Alchemy board and driver codebases I've
been sitting on a while.
All apply against latest linus-git (as of 2011-11-01 1800Z) merged with Ralf's
upstream-linus branch.

Overview:
#01-02 get rid of unused board code (PB1000, Bosporus/Mirage).  I have no test
       hardware; getting rid of Bosporus/Mirage makes it much easier to merge
       support for DB1000/1500/1100.  I have datasheets for all three and can
       bring them back if desired, but I'd rather not if at all possible.
#03    db1200 irq code optimization
#04-05 Au1300/Db1300 support
#06    better db1550 support, like db1200 and db1300.
#07-08 board support code is (imo needlessly) scattered across multiple files.
       these patches merge them into per-board files.
#09    au1200fb calls globally-visible functions to control panels.  this patch
       introduces platform data instead, because it's much nicer.
#10    pb1200 is just a db1200 with more mmc and camera sockets.  this patch
       implements board autodetection and setup for both to the db1200 code.
#11    db1000/1500/1100 are basically identical (plus PCI for db1500). after
       applying this patch a kernel image can be built which runs on all three.
#12    add MMC support to the DB1100
#13    add the on-chip RTC device to all pb/db boards.
#14    convert au1550nd.c to a platform driver.  I initially did this because
       gen_nand didn't seem to work on the DB1550 until I realized YAMON did
       not configure the NAND CS correctly (the original writers realized that
       and had au1550nd.c correct that).  After a YAMON update gen_nand works
       for the DB1550, but since I have no PB1550 I opted to keep au1550nd.
#15    with the au1550nd.c conversion some headers have become obsolete.
#16    convert au1k_ir IRDA driver to platform_driver.
#17    add IrDA platform data for DB1000/1100 (necessary after #16).
#18    add ADS78xx touchscreen support to DB1100.

All compile and run-tested where possible.

Thanks,
        Manuel Lauss

Manuel Lauss (18):
  MIPS: Alchemy: remove PB1000 support
  MIPS: Alchemy: drop MIRAGE/BOSPORUS board support
  MIPS: Alchemy: devboards: remove unneeded BCSR IRQ register writes
  MIPS: Alchemy: Au1300 SoC support
  MIPS: Alchemy: DB1300 support
  MIPS: Alchemy: better DB1550 support
  MIPS: Alchemy: merge GPR/MTX-1/XXS1500 board code into single files
  MIPS: Alchemy: merge devboard code into single per-board files.
  MIPS: Alchemy: move au1200fb global functions to platform data
  MIPS: Alchemy: Merge PB1200 support into DB1200 code.
  MIPS: Alchemy: one kernel for DB1000/DB1500/DB1100
  MIPS: Alchemy: MMC for DB1100
  MIPS: Alchemy: add RTC device to all devboards
  MTD: nand: make au1550nd.c a platform_driver
  MIPS: Alchemy: remove unused board headers
  net/irda: convert au1k_ir to platform driver.
  MIPS: Alchemy: hook up IrDA on DB1000/DB1100
  MIPS: Alchemy: Touchscreen support on DB1100

 arch/mips/alchemy/Kconfig                        |   60 +-
 arch/mips/alchemy/Makefile                       |    3 +
 arch/mips/alchemy/Platform                       |   58 +-
 arch/mips/alchemy/board-gpr.c                    |  303 ++++++
 arch/mips/alchemy/board-mtx1.c                   |  313 ++++++
 arch/mips/alchemy/board-xxs1500.c                |  154 +++
 arch/mips/alchemy/common/Makefile                |    3 +-
 arch/mips/alchemy/common/dbdma.c                 |   46 +
 arch/mips/alchemy/common/gpioint.c               |  411 ++++++++
 arch/mips/alchemy/common/gpiolib.c               |   42 +
 arch/mips/alchemy/common/irq.c                   |   11 -
 arch/mips/alchemy/common/platform.c              |   31 +-
 arch/mips/alchemy/common/power.c                 |    3 +
 arch/mips/alchemy/common/sleeper.S               |   73 ++
 arch/mips/alchemy/common/time.c                  |    1 +
 arch/mips/alchemy/common/vss.c                   |   84 ++
 arch/mips/alchemy/devboards/Makefile             |   19 +-
 arch/mips/alchemy/devboards/bcsr.c               |   11 +-
 arch/mips/alchemy/devboards/db1000.c             |  564 ++++++++++
 arch/mips/alchemy/devboards/db1200.c             |  913 ++++++++++++++++
 arch/mips/alchemy/devboards/db1200/Makefile      |    1 -
 arch/mips/alchemy/devboards/db1200/platform.c    |  648 ------------
 arch/mips/alchemy/devboards/db1200/setup.c       |   81 --
 arch/mips/alchemy/devboards/db1300.c             |  784 ++++++++++++++
 arch/mips/alchemy/devboards/db1550.c             |  498 +++++++++
 arch/mips/alchemy/devboards/db1x00/Makefile      |    8 -
 arch/mips/alchemy/devboards/db1x00/board_setup.c |  229 ----
 arch/mips/alchemy/devboards/db1x00/platform.c    |  315 ------
 arch/mips/alchemy/devboards/pb1000/Makefile      |    8 -
 arch/mips/alchemy/devboards/pb1000/board_setup.c |  209 ----
 arch/mips/alchemy/devboards/pb1100.c             |  167 +++
 arch/mips/alchemy/devboards/pb1100/Makefile      |    8 -
 arch/mips/alchemy/devboards/pb1100/board_setup.c |  127 ---
 arch/mips/alchemy/devboards/pb1100/platform.c    |   77 --
 arch/mips/alchemy/devboards/pb1200/Makefile      |    5 -
 arch/mips/alchemy/devboards/pb1200/board_setup.c |  174 ---
 arch/mips/alchemy/devboards/pb1200/platform.c    |  339 ------
 arch/mips/alchemy/devboards/pb1500.c             |  198 ++++
 arch/mips/alchemy/devboards/pb1500/Makefile      |    8 -
 arch/mips/alchemy/devboards/pb1500/board_setup.c |  139 ---
 arch/mips/alchemy/devboards/pb1500/platform.c    |   94 --
 arch/mips/alchemy/devboards/pb1550.c             |  244 +++++
 arch/mips/alchemy/devboards/pb1550/Makefile      |    8 -
 arch/mips/alchemy/devboards/pb1550/board_setup.c |   80 --
 arch/mips/alchemy/devboards/pb1550/platform.c    |  140 ---
 arch/mips/alchemy/devboards/platform.c           |   13 +-
 arch/mips/alchemy/devboards/prom.c               |   11 +-
 arch/mips/alchemy/gpr/Makefile                   |    8 -
 arch/mips/alchemy/gpr/board_setup.c              |   75 --
 arch/mips/alchemy/gpr/init.c                     |   63 --
 arch/mips/alchemy/gpr/platform.c                 |  230 ----
 arch/mips/alchemy/mtx-1/Makefile                 |    9 -
 arch/mips/alchemy/mtx-1/board_setup.c            |   94 --
 arch/mips/alchemy/mtx-1/init.c                   |   66 --
 arch/mips/alchemy/mtx-1/platform.c               |  230 ----
 arch/mips/alchemy/xxs1500/Makefile               |    8 -
 arch/mips/alchemy/xxs1500/board_setup.c          |   93 --
 arch/mips/alchemy/xxs1500/init.c                 |   63 --
 arch/mips/alchemy/xxs1500/platform.c             |   63 --
 arch/mips/boot/compressed/uart-alchemy.c         |    5 +-
 arch/mips/configs/db1000_defconfig               |  369 ++++++--
 arch/mips/configs/db1100_defconfig               |  122 ---
 arch/mips/configs/db1300_defconfig               |  391 +++++++
 arch/mips/configs/db1500_defconfig               |  128 ---
 arch/mips/configs/db1550_defconfig               |  288 ++++--
 arch/mips/configs/pb1200_defconfig               |  170 ---
 arch/mips/include/asm/cpu.h                      |    1 +
 arch/mips/include/asm/mach-au1x00/au1000.h       |  273 ++++-
 arch/mips/include/asm/mach-au1x00/au1100_mmc.h   |    2 +
 arch/mips/include/asm/mach-au1x00/au1200fb.h     |   14 +
 arch/mips/include/asm/mach-au1x00/au1550nd.h     |   16 +
 arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h |   31 +
 arch/mips/include/asm/mach-au1x00/gpio-au1300.h  |  241 +++++
 arch/mips/include/asm/mach-au1x00/gpio.h         |    3 +
 arch/mips/include/asm/mach-db1x00/bcsr.h         |   36 +-
 arch/mips/include/asm/mach-db1x00/db1200.h       |   11 +-
 arch/mips/include/asm/mach-db1x00/db1300.h       |   40 +
 arch/mips/include/asm/mach-db1x00/db1x00.h       |   79 --
 arch/mips/include/asm/mach-db1x00/irq.h          |   23 +
 arch/mips/include/asm/mach-pb1x00/mc146818rtc.h  |   34 -
 arch/mips/include/asm/mach-pb1x00/pb1000.h       |   87 --
 arch/mips/include/asm/mach-pb1x00/pb1200.h       |  139 ---
 arch/mips/include/asm/mach-pb1x00/pb1550.h       |   73 --
 arch/mips/kernel/cpu-probe.c                     |    7 +
 drivers/i2c/busses/Kconfig                       |    4 +-
 drivers/mmc/host/au1xmmc.c                       |   45 +-
 drivers/mtd/nand/au1550nd.c                      |  308 +++---
 drivers/net/irda/Kconfig                         |    6 +-
 drivers/net/irda/au1000_ircc.h                   |  125 ---
 drivers/net/irda/au1k_ir.c                       | 1229 ++++++++++++----------
 drivers/pcmcia/Kconfig                           |    8 +-
 drivers/pcmcia/Makefile                          |    4 -
 drivers/pcmcia/au1000_generic.c                  |  545 ----------
 drivers/pcmcia/au1000_generic.h                  |  135 ---
 drivers/pcmcia/au1000_pb1x00.c                   |  294 ------
 drivers/pcmcia/db1xxx_ss.c                       |   26 +-
 drivers/spi/Kconfig                              |    4 +-
 drivers/usb/host/alchemy-common.c                |  277 +++++
 drivers/usb/host/ohci-au1xxx.c                   |   13 +-
 drivers/video/Kconfig                            |    8 +-
 drivers/video/au1100fb.c                         |   12 -
 drivers/video/au1200fb.c                         |  273 +++---
 sound/soc/au1x/Kconfig                           |   16 +-
 sound/soc/au1x/db1200.c                          |   73 ++-
 104 files changed, 7817 insertions(+), 6889 deletions(-)
 create mode 100644 arch/mips/alchemy/Makefile
 create mode 100644 arch/mips/alchemy/board-gpr.c
 create mode 100644 arch/mips/alchemy/board-mtx1.c
 create mode 100644 arch/mips/alchemy/board-xxs1500.c
 create mode 100644 arch/mips/alchemy/common/gpioint.c
 create mode 100644 arch/mips/alchemy/common/vss.c
 create mode 100644 arch/mips/alchemy/devboards/db1000.c
 create mode 100644 arch/mips/alchemy/devboards/db1200.c
 delete mode 100644 arch/mips/alchemy/devboards/db1200/Makefile
 delete mode 100644 arch/mips/alchemy/devboards/db1200/platform.c
 delete mode 100644 arch/mips/alchemy/devboards/db1200/setup.c
 create mode 100644 arch/mips/alchemy/devboards/db1300.c
 create mode 100644 arch/mips/alchemy/devboards/db1550.c
 delete mode 100644 arch/mips/alchemy/devboards/db1x00/Makefile
 delete mode 100644 arch/mips/alchemy/devboards/db1x00/board_setup.c
 delete mode 100644 arch/mips/alchemy/devboards/db1x00/platform.c
 delete mode 100644 arch/mips/alchemy/devboards/pb1000/Makefile
 delete mode 100644 arch/mips/alchemy/devboards/pb1000/board_setup.c
 create mode 100644 arch/mips/alchemy/devboards/pb1100.c
 delete mode 100644 arch/mips/alchemy/devboards/pb1100/Makefile
 delete mode 100644 arch/mips/alchemy/devboards/pb1100/board_setup.c
 delete mode 100644 arch/mips/alchemy/devboards/pb1100/platform.c
 delete mode 100644 arch/mips/alchemy/devboards/pb1200/Makefile
 delete mode 100644 arch/mips/alchemy/devboards/pb1200/board_setup.c
 delete mode 100644 arch/mips/alchemy/devboards/pb1200/platform.c
 create mode 100644 arch/mips/alchemy/devboards/pb1500.c
 delete mode 100644 arch/mips/alchemy/devboards/pb1500/Makefile
 delete mode 100644 arch/mips/alchemy/devboards/pb1500/board_setup.c
 delete mode 100644 arch/mips/alchemy/devboards/pb1500/platform.c
 create mode 100644 arch/mips/alchemy/devboards/pb1550.c
 delete mode 100644 arch/mips/alchemy/devboards/pb1550/Makefile
 delete mode 100644 arch/mips/alchemy/devboards/pb1550/board_setup.c
 delete mode 100644 arch/mips/alchemy/devboards/pb1550/platform.c
 delete mode 100644 arch/mips/alchemy/gpr/Makefile
 delete mode 100644 arch/mips/alchemy/gpr/board_setup.c
 delete mode 100644 arch/mips/alchemy/gpr/init.c
 delete mode 100644 arch/mips/alchemy/gpr/platform.c
 delete mode 100644 arch/mips/alchemy/mtx-1/Makefile
 delete mode 100644 arch/mips/alchemy/mtx-1/board_setup.c
 delete mode 100644 arch/mips/alchemy/mtx-1/init.c
 delete mode 100644 arch/mips/alchemy/mtx-1/platform.c
 delete mode 100644 arch/mips/alchemy/xxs1500/Makefile
 delete mode 100644 arch/mips/alchemy/xxs1500/board_setup.c
 delete mode 100644 arch/mips/alchemy/xxs1500/init.c
 delete mode 100644 arch/mips/alchemy/xxs1500/platform.c
 delete mode 100644 arch/mips/configs/db1100_defconfig
 create mode 100644 arch/mips/configs/db1300_defconfig
 delete mode 100644 arch/mips/configs/db1500_defconfig
 delete mode 100644 arch/mips/configs/pb1200_defconfig
 create mode 100644 arch/mips/include/asm/mach-au1x00/au1200fb.h
 create mode 100644 arch/mips/include/asm/mach-au1x00/au1550nd.h
 create mode 100644 arch/mips/include/asm/mach-au1x00/gpio-au1300.h
 create mode 100644 arch/mips/include/asm/mach-db1x00/db1300.h
 delete mode 100644 arch/mips/include/asm/mach-db1x00/db1x00.h
 create mode 100644 arch/mips/include/asm/mach-db1x00/irq.h
 delete mode 100644 arch/mips/include/asm/mach-pb1x00/mc146818rtc.h
 delete mode 100644 arch/mips/include/asm/mach-pb1x00/pb1000.h
 delete mode 100644 arch/mips/include/asm/mach-pb1x00/pb1200.h
 delete mode 100644 arch/mips/include/asm/mach-pb1x00/pb1550.h
 delete mode 100644 drivers/net/irda/au1000_ircc.h
 delete mode 100644 drivers/pcmcia/au1000_generic.c
 delete mode 100644 drivers/pcmcia/au1000_generic.h
 delete mode 100644 drivers/pcmcia/au1000_pb1x00.c

-- 
1.7.7.1
