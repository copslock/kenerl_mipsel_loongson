Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jun 2011 20:43:23 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:35402 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491021Ab1FNSmQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jun 2011 20:42:16 +0200
Received: by wyb28 with SMTP id 28so5552275wyb.36
        for <linux-mips@linux-mips.org>; Tue, 14 Jun 2011 11:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=OkqFqQzputEnv+Pe7GckznZ4dqTcfe9ycESgpmuNPs4=;
        b=OPqrnKfvs/pOY6XWkgaqEBGGyJx0jp5GHpQgllhRkG+vp97WjFmLkQvgk7/XQRx/CC
         eWTzFMCc8JJqBP9DyUTZ//f7ybjByvAxx8n6AAAGRr56bcU+wkANYpm4RUFSbUNdcxmF
         kz+5bEf7XPPaLU8Ha211CCJvCi+wk2PVxhGKo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=OxahUwFxvwrB6Bz0b3c0asybX8nc7nFkp38/k1m7YfTBvv8KjqWiSFcI5dO7OE/Jne
         mx3BVELXpqHO9MrNDk9k4tK2EMPQy4nAUtvmjmcD+HwAjlreAr7L0CUVK85pK9DG3Km3
         6Z+3JilKlAt1jF+V68RPkV/3IPLDXGoMeMCWI=
Received: by 10.216.62.195 with SMTP id y45mr7462314wec.15.1308076930664;
        Tue, 14 Jun 2011 11:42:10 -0700 (PDT)
Received: from localhost.localdomain (188-22-154-149.adsl.highway.telekom.at [188.22.154.149])
        by mx.google.com with ESMTPS id l5sm3650327weq.9.2011.06.14.11.42.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 14 Jun 2011 11:42:09 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [RFC V2 PATCH 0/2] MIPS: Alchemy: Au1300 / DB1300 support
Date:   Tue, 14 Jun 2011 20:42:01 +0200
Message-Id: <1308076923-13492-2-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.5.3
In-Reply-To: <1308076923-13492-1-git-send-email-manuel.lauss@googlemail.com>
References: <1308076923-13492-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 30381
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11808

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
  either USB mouse or the touchscreen. I consider that usable.

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
