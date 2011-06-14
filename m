Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jun 2011 20:42:18 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:40778 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491000Ab1FNSmP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jun 2011 20:42:15 +0200
Received: by wwb17 with SMTP id 17so5199458wwb.24
        for <linux-mips@linux-mips.org>; Tue, 14 Jun 2011 11:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=aSfXYQYpPxgeYFN43CA/eYtFp3TwjGp7ARo8EiTxw68=;
        b=kJdb6bdxnEpqUeQbJIzy6otxKgWBplj+Fxig7YH10Fkw5uQYXYawpMRjbRdH9EZubq
         fTL8QD1XPh5CymK5XFjhEhojG6y1FElmwUYyKm0e+YYTn4UuzI0Rob6eFprfr7D0V/Zv
         9/iIFJnD6hw/GxX9/RYSp1A+lF3zHUKzSTFeE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=wdCYvfzj2iJvQVHWnkACEDLBEHWZWpuYXEz+TUSkCNARrO8Ntgkg30BBjLyBHbCopr
         8XoFnz8zJ8f+BKEK8rJwB4Onp3dQB6FoD8KrpIUasPsXOQHvPF1i+HZsgxEbstDw8LwY
         pCt5f9J8YNdh9DgtDh04/VYM4gHiLegqkBtHc=
Received: by 10.216.254.90 with SMTP id g68mr891564wes.16.1308076928963;
        Tue, 14 Jun 2011 11:42:08 -0700 (PDT)
Received: from localhost.localdomain (188-22-154-149.adsl.highway.telekom.at [188.22.154.149])
        by mx.google.com with ESMTPS id l5sm3650327weq.9.2011.06.14.11.42.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 14 Jun 2011 11:42:07 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [RFC V2 PATCH 0/2] MIPS: Alchemy: Au1300 / DB1300 support
Date:   Tue, 14 Jun 2011 20:42:00 +0200
Message-Id: <1308076923-13492-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.5.3
X-archive-position: 30379
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11804

Here's another attempt at supporting the Au1300 and DB1300 in mainline
Linux.  Since the last submission I've added Framebuffer and USB
support, cleaned up a bit and rediffed against latest linus-git.

Changes since V1:
- Au1300: simplified plat_irq_dispatch, made the assembly significantly smaller
- DB1300: now uses the bcsr irq dispatcher like the db1200, with a small
	  modification.

What works:
- Au1300 integration, GPIO, IRQs
- Au1300 USB (EHCI, 2x OHCI).  OTG and UDC need drivers (Synopsys IP).
- I can play ScummVM under X with sound off a IDE HDD/CF card/NFS share with
  either USB mouse or the touchscreen and use it as a wireless access point.
  I consider that usable.

These 2 patches depend on the "USB updates and more cleanups" patches
sent earlier.

Comments welcome,
Thanks!
        Manuel Lauss

(a complete patchseries can be found @ http://mlau.at/files/db1300-patches/ )

-- 

Manuel Lauss (2):
  MIPS: Alchemy: Au1300 SoC support
  MIPS: Alchemy: DB1300 support

 arch/mips/alchemy/Kconfig                        |   16 +
 arch/mips/alchemy/Platform                       |    7 +
 arch/mips/alchemy/common/Makefile                |    4 +-
 arch/mips/alchemy/common/dbdma.c                 |   48 ++-
 arch/mips/alchemy/common/gpioint.c               |  428 +++++++++++++++
 arch/mips/alchemy/common/gpiolib-au1300.c        |   54 ++
 arch/mips/alchemy/common/platform.c              |   31 +-
 arch/mips/alchemy/common/power.c                 |    2 +
 arch/mips/alchemy/common/sleeper.S               |   73 +++
 arch/mips/alchemy/common/time.c                  |    1 +
 arch/mips/alchemy/common/usb.c                   |  278 ++++++++++
 arch/mips/alchemy/common/vss.c                   |   84 +++
 arch/mips/alchemy/devboards/Makefile             |    1 +
 arch/mips/alchemy/devboards/bcsr.c               |    4 +
 arch/mips/alchemy/devboards/db1300/Makefile      |    1 +
 arch/mips/alchemy/devboards/db1300/platform.c    |  638 ++++++++++++++++++++++
 arch/mips/alchemy/devboards/db1300/setup.c       |  147 +++++
 arch/mips/alchemy/devboards/prom.c               |    4 +
 arch/mips/boot/compressed/uart-alchemy.c         |    5 +-
 arch/mips/configs/db1300_defconfig               |  391 +++++++++++++
 arch/mips/include/asm/cpu.h                      |    1 +
 arch/mips/include/asm/mach-au1x00/au1000.h       |  223 +++++++-
 arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h |   33 ++
 arch/mips/include/asm/mach-au1x00/gpio-au1300.h  |  250 +++++++++
 arch/mips/include/asm/mach-au1x00/gpio.h         |    4 +
 arch/mips/include/asm/mach-db1x00/bcsr.h         |   34 +-
 arch/mips/include/asm/mach-db1x00/db1300.h       |   40 ++
 arch/mips/include/asm/mach-db1x00/irq.h          |   23 +
 arch/mips/kernel/cpu-probe.c                     |    8 +
 drivers/i2c/busses/Kconfig                       |    6 +-
 drivers/pcmcia/Kconfig                           |    4 +-
 drivers/pcmcia/db1xxx_ss.c                       |   30 +-
 drivers/spi/Kconfig                              |    6 +-
 drivers/usb/Kconfig                              |    2 +-
 drivers/usb/host/ehci-hcd.c                      |    2 +-
 drivers/usb/host/ohci-au1xxx.c                   |   10 +-
 drivers/video/Kconfig                            |   10 +-
 drivers/video/au1200fb.c                         |   36 ++
 sound/soc/au1x/Kconfig                           |   18 +-
 sound/soc/au1x/Makefile                          |    2 +
 sound/soc/au1x/db1300.c                          |  147 +++++
 41 files changed, 3049 insertions(+), 57 deletions(-)
 create mode 100644 arch/mips/alchemy/common/gpioint.c
 create mode 100644 arch/mips/alchemy/common/gpiolib-au1300.c
 create mode 100644 arch/mips/alchemy/common/vss.c
 create mode 100644 arch/mips/alchemy/devboards/db1300/Makefile
 create mode 100644 arch/mips/alchemy/devboards/db1300/platform.c
 create mode 100644 arch/mips/alchemy/devboards/db1300/setup.c
 create mode 100644 arch/mips/configs/db1300_defconfig
 create mode 100644 arch/mips/include/asm/mach-au1x00/gpio-au1300.h
 create mode 100644 arch/mips/include/asm/mach-db1x00/db1300.h
 create mode 100644 arch/mips/include/asm/mach-db1x00/irq.h
 create mode 100644 sound/soc/au1x/db1300.c

-- 
1.7.5.3
