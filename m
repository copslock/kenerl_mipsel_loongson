Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jul 2011 13:41:37 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:54536 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491805Ab1GOLla (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jul 2011 13:41:30 +0200
Received: by fxd20 with SMTP id 20so1823644fxd.36
        for <linux-mips@linux-mips.org>; Fri, 15 Jul 2011 04:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=cd4nQzv0O8ft5gUSBKxBrMs5c0IalUz4SLrOTr+7SAM=;
        b=HURw/1lriJrO02jIAlevsxPnoilwZiJDoolkWtR1AShVE1pmmL5hnrUsb2eBFYCcex
         HF3CNPc1+nryQkeY2U8nxqiVDxxSM7H3EPCRNshFBm/z6HO90UyB+Pj3jXUI7sDjyiQb
         YYyHilbQAsRZ80Wgx33U/ucy0aMv1vxZVAjBw=
Received: by 10.223.41.156 with SMTP id o28mr5270652fae.11.1310730084357;
        Fri, 15 Jul 2011 04:41:24 -0700 (PDT)
Received: from localhost.localdomain (178-191-8-8.adsl.highway.telekom.at [178.191.8.8])
        by mx.google.com with ESMTPS id q1sm794249faa.3.2011.07.15.04.41.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Jul 2011 04:41:22 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH RFC V3 0/2] MIPS: Alchemy: Au1300 / DB1300 support
Date:   Fri, 15 Jul 2011 13:41:16 +0200
Message-Id: <1310730078-30265-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.6
X-archive-position: 30624
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10919

For posterity, here's a final, V3 dump of my Au1300/DB1300 support patches.

Changes since V2:
- removed the debug macros and cleaned the comments in new IRQ code,
- renamed the gpiolib hooks to something more sensible,
- merged the core DB1300 code into a single file.

Changes since V1:
- Au1300: simplified plat_irq_dispatch, made the assembly significantly smaller
- DB1300: now uses the bcsr irq dispatcher like the db1200, with a small
          modification.

What works:
- Au1300 integration, GPIO, IRQs
- Au1300 USB (EHCI, 2x OHCI).  OTG and UDC need drivers (Synopsys IP).
- I can play ScummVM under X with sound off a IDE HDD/CF card/NFS share with
  either USB mouse or the touchscreen and use it as a wireless access point.

These 2 patches depend on the "MIPS: Alchemy: misc updates" I sent on 2011-07-08,
as well as patches I sent to linux-fbdev and linux-i2c to work properly (esp.
wrt. the I2S codec).
The whole series is available at http://mlau.at/files/db1300-patches/ as well.

Code is run-tested on both Db1200 and Db1300, as well as compile-tested on
a small selection of other alchemy hardware.

Manuel Lauss (2):
  MIPS: Alchemy: Au1300 SoC support
  MIPS: Alchemy: DB1300 support

 arch/mips/alchemy/Kconfig                        |   16 +
 arch/mips/alchemy/Platform                       |    7 +
 arch/mips/alchemy/common/Makefile                |    4 +-
 arch/mips/alchemy/common/dbdma.c                 |   48 ++-
 arch/mips/alchemy/common/gpioint.c               |  411 ++++++++++++
 arch/mips/alchemy/common/gpiolib-au1300.c        |   54 ++
 arch/mips/alchemy/common/platform.c              |   31 +-
 arch/mips/alchemy/common/power.c                 |    3 +
 arch/mips/alchemy/common/sleeper.S               |   73 ++
 arch/mips/alchemy/common/time.c                  |    1 +
 arch/mips/alchemy/common/usb.c                   |  277 ++++++++
 arch/mips/alchemy/common/vss.c                   |   84 +++
 arch/mips/alchemy/devboards/Makefile             |    1 +
 arch/mips/alchemy/devboards/bcsr.c               |    4 +
 arch/mips/alchemy/devboards/db1300.c             |  767 ++++++++++++++++++++++
 arch/mips/alchemy/devboards/prom.c               |    4 +
 arch/mips/boot/compressed/uart-alchemy.c         |    5 +-
 arch/mips/configs/db1300_defconfig               |  391 +++++++++++
 arch/mips/include/asm/cpu.h                      |    1 +
 arch/mips/include/asm/mach-au1x00/au1000.h       |  223 ++++++-
 arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h |   33 +
 arch/mips/include/asm/mach-au1x00/gpio-au1300.h  |  250 +++++++
 arch/mips/include/asm/mach-au1x00/gpio.h         |    4 +
 arch/mips/include/asm/mach-db1x00/bcsr.h         |   34 +-
 arch/mips/include/asm/mach-db1x00/db1300.h       |   40 ++
 arch/mips/include/asm/mach-db1x00/irq.h          |   23 +
 arch/mips/kernel/cpu-probe.c                     |    7 +
 drivers/i2c/busses/Kconfig                       |    6 +-
 drivers/pcmcia/Kconfig                           |    4 +-
 drivers/pcmcia/db1xxx_ss.c                       |   26 +-
 drivers/spi/Kconfig                              |    6 +-
 drivers/usb/Kconfig                              |    2 +-
 drivers/usb/host/ehci-hcd.c                      |    2 +-
 drivers/usb/host/ohci-au1xxx.c                   |   13 +-
 drivers/video/Kconfig                            |   10 +-
 drivers/video/au1200fb.c                         |   36 +
 sound/soc/au1x/Kconfig                           |   18 +-
 sound/soc/au1x/Makefile                          |    2 +
 sound/soc/au1x/db1200.c                          |    4 +
 sound/soc/au1x/db1300.c                          |  147 +++++
 40 files changed, 3017 insertions(+), 55 deletions(-)
 create mode 100644 arch/mips/alchemy/common/gpioint.c
 create mode 100644 arch/mips/alchemy/common/gpiolib-au1300.c
 create mode 100644 arch/mips/alchemy/common/vss.c
 create mode 100644 arch/mips/alchemy/devboards/db1300.c
 create mode 100644 arch/mips/configs/db1300_defconfig
 create mode 100644 arch/mips/include/asm/mach-au1x00/gpio-au1300.h
 create mode 100644 arch/mips/include/asm/mach-db1x00/db1300.h
 create mode 100644 arch/mips/include/asm/mach-db1x00/irq.h
 create mode 100644 sound/soc/au1x/db1300.c

-- 
1.7.6
