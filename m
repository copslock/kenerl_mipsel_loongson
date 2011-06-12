Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Jun 2011 18:31:08 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:55597 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491065Ab1FLQ3l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 12 Jun 2011 18:29:41 +0200
Received: by wyb28 with SMTP id 28so3778171wyb.36
        for <linux-mips@linux-mips.org>; Sun, 12 Jun 2011 09:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=i2RO+CcKABpEexZ30Qft6wAXBBn4cTI/X+Lcoetlwy4=;
        b=OtVlgDT+yBKLz6bdq+pkvgRV6kBnqEG2bnDHBfTLTh+SVFyZozrR9xJGlIsEhELpjB
         66RehQll5BcS1QkUav0mHVeVo1zK1ZfJJ3TcegQLaSokipzJeLj5d/nSs2QIbyPEV4pk
         i4YD/fhp2LrKbvh+FxL/qO7ImYTvaLFwZl1Bs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=o3/enKZfY+1yV0y59NDAK46IZDfaNA3szUcnSm/PiZc/TLNW//ULtkik68/xD79XNA
         SzfBFjs1chxWP9IZ6h39HZnalgWBVoe2str35NITG22QdRUCdM6QE3/d01i3nJEjL0PV
         wV/hF2/8ZoSC9WB8AZReg//LsWNDDvhfslGCM=
Received: by 10.216.145.131 with SMTP id p3mr3963932wej.82.1307896175684;
        Sun, 12 Jun 2011 09:29:35 -0700 (PDT)
Received: from localhost.localdomain (188-22-11-39.adsl.highway.telekom.at [188.22.11.39])
        by mx.google.com with ESMTPS id w62sm2437815wec.18.2011.06.12.09.29.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 12 Jun 2011 09:29:34 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [RFC PATCH 0/2] MIPS: Alchemy: Au1300 / DB1300 support
Date:   Sun, 12 Jun 2011 18:29:30 +0200
Message-Id: <1307896172-29460-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.5.3
X-archive-position: 30344
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10174

Here's another attempt at supporting the Au1300 and DB1300 in mainline
Linux.  Since the last submission I've added Framebuffer and USB
support, cleaned up a bit and rediffed against latest linus-git.

What works:
- Au1300 integration, GPIO, IRQs
- Au1300 USB (EHCI, 2x OHCI).  OTG and UDC need drivers (Synopsys IP).
- I can play ScummVM under X with sound off a CF card/NFS share with either
  USB mouse or the touchscreen (touch X axis is wired up in reverse).

These 2 patches depend on the "USB updates and more cleanups" patches
sent earlier.

Please test and critique the code.
Thanks!
        Manuel Lauss

-- 

Manuel Lauss (2):
  MIPS: Alchemy: Au1300 SoC support
  MIPS: Alchemy: DB1300 support

 arch/mips/alchemy/Kconfig                        |   16 +
 arch/mips/alchemy/Platform                       |    7 +
 arch/mips/alchemy/common/Makefile                |    4 +-
 arch/mips/alchemy/common/dbdma.c                 |   48 ++-
 arch/mips/alchemy/common/gpioint.c               |  437 +++++++++++++++
 arch/mips/alchemy/common/gpiolib-au1300.c        |   54 ++
 arch/mips/alchemy/common/platform.c              |   31 +-
 arch/mips/alchemy/common/power.c                 |    2 +
 arch/mips/alchemy/common/sleeper.S               |   73 +++
 arch/mips/alchemy/common/time.c                  |    1 +
 arch/mips/alchemy/common/usb.c                   |  278 ++++++++++
 arch/mips/alchemy/common/vss.c                   |   84 +++
 arch/mips/alchemy/devboards/Makefile             |    1 +
 arch/mips/alchemy/devboards/db1300/Makefile      |    1 +
 arch/mips/alchemy/devboards/db1300/platform.c    |  638 ++++++++++++++++++++++
 arch/mips/alchemy/devboards/db1300/setup.c       |  245 +++++++++
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
 40 files changed, 3152 insertions(+), 57 deletions(-)
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
