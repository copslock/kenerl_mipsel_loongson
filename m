Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Sep 2014 20:31:05 +0200 (CEST)
Received: from mail-lb0-f169.google.com ([209.85.217.169]:60973 "EHLO
        mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009775AbaI1SbDD4bOx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 28 Sep 2014 20:31:03 +0200
Received: by mail-lb0-f169.google.com with SMTP id u10so3371089lbd.0
        for <multiple recipients>; Sun, 28 Sep 2014 11:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=yhFayeK6QCe5sVm0HvLva9Oz0yMbPv0QcnvDswX7JMA=;
        b=ZMuMLpkMrEShs4U1WI9TdzEavuPh6quO4yStjrfwfuejbhC6G53xja7N8Yixl/Yz8I
         ASAzNzA1Jk4c1NcAUpHKvueGFzmd9bRr6EKrhztpQjhrFUm3hoiobLRkFKLUUkg2J+Tf
         MKcarK0mP/RNxUOvpfF0WWXPTARiypwShd8CamHlGSClC9j+vkcHtlY54BlGk+jvWV9X
         M5/JGtCwlErgq9FTQEM+0O0VFKaqdJAAe7AGjQik4CPneoNiAIkmLRQbm4bRd9TURrq8
         h/JstBloU6i+MuJcnjJ0Yg+6e4Tvupam+chlcdPL014+OcRjcr6X/Bmx3TYAd4hMP6oD
         M1Iw==
X-Received: by 10.112.184.161 with SMTP id ev1mr31524538lbc.82.1411929057247;
        Sun, 28 Sep 2014 11:30:57 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by mx.google.com with ESMTPSA id je9sm581674lbc.3.2014.09.28.11.30.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Sep 2014 11:30:56 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>
Subject: [PATCH 00/16] MIPS: support for the Atheros AR231X SoCs
Date:   Sun, 28 Sep 2014 22:32:59 +0400
Message-Id: <1411929195-23775-1-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 1.8.1.5
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42851
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

This patch set contains initial support for the following Atheros SoCs: AR5312,
AR2312, AR2313, AR2315, AR2316, AR2317, AR2318.

- Patches 1 through 14 and patch 16 add support for different parts of AR231x
  SoCs.
- Patch 11 provided only for reference, since it should be rewritten to use
  spi-nor framework.
- Patch 15 updates ath5k dependecies

The code was successfully tested with AR2313, AR2315 and AR2317 SoCs.

This code has been written by OpenWRT developers and it resided in OpenWRT's
tree for a long time. My work was to cleanup the code and its rebase on the
latest linux-mips tree.

Changes since RFC:
  - use dynamic IRQ numbers allocation
  - group ath5 related changes in one patch
  - group devices registration in separate patch

Sergey Ryazanov (16):
  MIPS: ar231x: add common parts
  MIPS: ar231x: add basic AR5312 SoC support
  MIPS: ar231x: add basic AR2315 SoC support
  MIPS: ar231x: add interrupts handling routines
  MIPS: ar231x: add early printk support
  MIPS: ar231x: add UART support
  MIPS: ar231x: add board configuration detection
  MIPS: ar231x: add SoC type detection
  gpio: add driver for Atheros AR5312 SoC GPIO controller
  gpio: add driver for Atheros AR2315 SoC GPIO controller
  mtd: add Atheros AR2315 SPI Flash driver
  watchdog: add Atheros AR2315 watchdog driver
  MIPS: ar231x: register various chip devices
  MIPS: ar231x: add AR2315 PCI host controller driver
  ath5k: update dependencies
  MIPS: ar231x: add Wireless device support

 arch/mips/Kbuild.platforms                         |   1 +
 arch/mips/Kconfig                                  |  15 +
 arch/mips/ar231x/Kconfig                           |  18 +
 arch/mips/ar231x/Makefile                          |  16 +
 arch/mips/ar231x/Platform                          |   6 +
 arch/mips/ar231x/ar2315.c                          | 385 ++++++++++++++
 arch/mips/ar231x/ar2315.h                          |  24 +
 arch/mips/ar231x/ar5312.c                          | 392 ++++++++++++++
 arch/mips/ar231x/ar5312.h                          |  24 +
 arch/mips/ar231x/board.c                           | 222 ++++++++
 arch/mips/ar231x/devices.c                         | 120 +++++
 arch/mips/ar231x/devices.h                         |  39 ++
 arch/mips/ar231x/early_printk.c                    |  45 ++
 arch/mips/ar231x/prom.c                            |  31 ++
 arch/mips/include/asm/mach-ar231x/ar2315_regs.h    | 580 +++++++++++++++++++++
 arch/mips/include/asm/mach-ar231x/ar231x.h         |  31 ++
 .../mips/include/asm/mach-ar231x/ar231x_platform.h |  73 +++
 arch/mips/include/asm/mach-ar231x/ar5312_regs.h    | 215 ++++++++
 .../asm/mach-ar231x/cpu-feature-overrides.h        |  84 +++
 arch/mips/include/asm/mach-ar231x/dma-coherence.h  |  76 +++
 arch/mips/include/asm/mach-ar231x/gpio.h           |  16 +
 arch/mips/include/asm/mach-ar231x/war.h            |  25 +
 arch/mips/pci/Makefile                             |   1 +
 arch/mips/pci/pci-ar2315.c                         | 353 +++++++++++++
 drivers/gpio/Kconfig                               |  14 +
 drivers/gpio/Makefile                              |   2 +
 drivers/gpio/gpio-ar2315.c                         | 232 +++++++++
 drivers/gpio/gpio-ar5312.c                         | 121 +++++
 drivers/mtd/devices/Kconfig                        |   5 +
 drivers/mtd/devices/Makefile                       |   1 +
 drivers/mtd/devices/ar2315.c                       | 459 ++++++++++++++++
 drivers/mtd/devices/ar2315_spiflash.h              | 106 ++++
 drivers/net/wireless/ath/ath5k/Kconfig             |  10 +-
 drivers/net/wireless/ath/ath5k/ath5k.h             |   2 +-
 drivers/net/wireless/ath/ath5k/base.c              |   4 +-
 drivers/net/wireless/ath/ath5k/led.c               |   4 +-
 drivers/watchdog/Kconfig                           |   8 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/ar2315-wtd.c                      | 167 ++++++
 39 files changed, 3918 insertions(+), 10 deletions(-)
 create mode 100644 arch/mips/ar231x/Kconfig
 create mode 100644 arch/mips/ar231x/Makefile
 create mode 100644 arch/mips/ar231x/Platform
 create mode 100644 arch/mips/ar231x/ar2315.c
 create mode 100644 arch/mips/ar231x/ar2315.h
 create mode 100644 arch/mips/ar231x/ar5312.c
 create mode 100644 arch/mips/ar231x/ar5312.h
 create mode 100644 arch/mips/ar231x/board.c
 create mode 100644 arch/mips/ar231x/devices.c
 create mode 100644 arch/mips/ar231x/devices.h
 create mode 100644 arch/mips/ar231x/early_printk.c
 create mode 100644 arch/mips/ar231x/prom.c
 create mode 100644 arch/mips/include/asm/mach-ar231x/ar2315_regs.h
 create mode 100644 arch/mips/include/asm/mach-ar231x/ar231x.h
 create mode 100644 arch/mips/include/asm/mach-ar231x/ar231x_platform.h
 create mode 100644 arch/mips/include/asm/mach-ar231x/ar5312_regs.h
 create mode 100644 arch/mips/include/asm/mach-ar231x/cpu-feature-overrides.h
 create mode 100644 arch/mips/include/asm/mach-ar231x/dma-coherence.h
 create mode 100644 arch/mips/include/asm/mach-ar231x/gpio.h
 create mode 100644 arch/mips/include/asm/mach-ar231x/war.h
 create mode 100644 arch/mips/pci/pci-ar2315.c
 create mode 100644 drivers/gpio/gpio-ar2315.c
 create mode 100644 drivers/gpio/gpio-ar5312.c
 create mode 100644 drivers/mtd/devices/ar2315.c
 create mode 100644 drivers/mtd/devices/ar2315_spiflash.h
 create mode 100644 drivers/watchdog/ar2315-wtd.c

-- 
1.8.5.5
