Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Sep 2014 21:31:48 +0200 (CEST)
Received: from mail-lb0-f176.google.com ([209.85.217.176]:60416 "EHLO
        mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008806AbaINTbrO8ZTX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 14 Sep 2014 21:31:47 +0200
Received: by mail-lb0-f176.google.com with SMTP id z11so3332130lbi.21
        for <multiple recipients>; Sun, 14 Sep 2014 12:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=xzm46Cill6ygvtejefM+suH/WFnYiINjB2SKaDSqj1c=;
        b=nxkwUKC1fDB7qYc4O8o9LuBlJWnpX5OM4JVGX9jELJFDoEmK8hKwiN8qSkw57AG0km
         yA3DvpywvITYOvrYeJjnT5sp7GX2bWIohKTuSsoD4SoCzysQja6wh5AeckfkaYnMnktN
         xd93R05Z5WNkSbSFAlpha2RDxu6UH3YLJQHNTdSJmukbxeez4WTEq9QEj5+R8sWO0a1+
         8PyB9X1FS7Qgt6BxsmpcVtb7oVN5rrVsBR21mhB3j1UP2nDwQaK9icSnIoff7xbhBP0Z
         FD6pigurYX/3r3iUXbAyVYrtFWsUmXkeaQaie9o1Dd54ODBvsdEwj9i381UIKN6H2EEX
         wQzQ==
X-Received: by 10.153.4.39 with SMTP id cb7mr23354719lad.19.1410723101606;
        Sun, 14 Sep 2014 12:31:41 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by mx.google.com with ESMTPSA id y5sm3339621laa.20.2014.09.14.12.31.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Sep 2014 12:31:40 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>
Subject: [RFC 00/18] MIPS: support for the Atheros AR231X SoCs
Date:   Sun, 14 Sep 2014 23:33:15 +0400
Message-Id: <1410723213-22440-1-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 1.8.1.5
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42543
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

- Patches 1 through 15 add support for different parts of AR231x SoCs.
- Patch 12 provided only for reference, since it should be rewritten to use
  spi-nor framework.
- Patch 16 do a tiny cleanup in the ath5k driver.
- Patch 17 updates ath5k dependecy, since I rename the original ATHEROS_AR231X
  config symbol to AR231X.
- Patch 18 removes !PCI dependency from ath5k AHB support, since AR2315 has a
  builtin PCI controller.

The original code was based on 3.14.18 kernel and successfully tested with
AR2313, AR2315, AR2316, AR2317 SoCs. After rebasing the code was build tested
only.

This code has been written by OpenWRT developers and it resided in OpenWRT's
tree for a long time. My work was to cleanup the code and its rebase on the
latest linux-mips tree (3.17-rc2).

Sergey Ryazanov (18):
  MIPS: ar231x: add common parts
  MIPS: ar231x: add basic AR5312 SoC support
  MIPS: ar231x: add basic AR2315 SoC support
  MIPS: ar231x: add interrupts handling routines
  MIPS: ar231x: add early printk support
  MIPS: ar231x: add UART support
  MIPS: ar231x: add board configuration detection
  gpio: add driver for Atheros AR5312 SoC GPIO controller
  gpio: add driver for Atheros AR5312 SoC GPIO controller
  MIPS: ar231x: add SoC type detection
  MIPS: ar231x: add AR5312 flash support
  mtd: add Atheros AR2315 SPI Flash driver
  watchdog: add Atheros AR2315 watchdog driver
  MIPS: ar231x: add AR2315 PCI host controller driver
  MIPS: ar231x: add Wireless device support
  ath5k: correct conditional compilation
  ath5k: update dependency
  ath5k: correct dependency

 arch/mips/Kbuild.platforms                         |   1 +
 arch/mips/Kconfig                                  |  15 +
 arch/mips/ar231x/Kconfig                           |  18 +
 arch/mips/ar231x/Makefile                          |  16 +
 arch/mips/ar231x/Platform                          |   6 +
 arch/mips/ar231x/ar2315.c                          | 378 ++++++++++++++
 arch/mips/ar231x/ar2315.h                          |  22 +
 arch/mips/ar231x/ar5312.c                          | 374 +++++++++++++
 arch/mips/ar231x/ar5312.h                          |  22 +
 arch/mips/ar231x/board.c                           | 222 ++++++++
 arch/mips/ar231x/devices.c                         | 111 ++++
 arch/mips/ar231x/devices.h                         |  39 ++
 arch/mips/ar231x/early_printk.c                    |  45 ++
 arch/mips/ar231x/prom.c                            |  31 ++
 arch/mips/include/asm/mach-ar231x/ar2315_regs.h    | 581 +++++++++++++++++++++
 arch/mips/include/asm/mach-ar231x/ar231x.h         |  34 ++
 .../mips/include/asm/mach-ar231x/ar231x_platform.h |  73 +++
 arch/mips/include/asm/mach-ar231x/ar5312_regs.h    | 215 ++++++++
 .../asm/mach-ar231x/cpu-feature-overrides.h        |  84 +++
 arch/mips/include/asm/mach-ar231x/dma-coherence.h  |  76 +++
 arch/mips/include/asm/mach-ar231x/gpio.h           |  16 +
 arch/mips/include/asm/mach-ar231x/war.h            |  25 +
 arch/mips/pci/Makefile                             |   1 +
 arch/mips/pci/pci-ar2315.c                         | 345 ++++++++++++
 drivers/gpio/Kconfig                               |  14 +
 drivers/gpio/Makefile                              |   2 +
 drivers/gpio/gpio-ar2315.c                         | 233 +++++++++
 drivers/gpio/gpio-ar5312.c                         | 121 +++++
 drivers/mtd/devices/Kconfig                        |   5 +
 drivers/mtd/devices/Makefile                       |   1 +
 drivers/mtd/devices/ar2315.c                       | 459 ++++++++++++++++
 drivers/mtd/devices/ar2315_spiflash.h              | 106 ++++
 drivers/net/wireless/ath/ath5k/Kconfig             |  10 +-
 drivers/net/wireless/ath/ath5k/ath5k.h             |   2 +-
 drivers/net/wireless/ath/ath5k/base.c              |   4 +-
 drivers/net/wireless/ath/ath5k/led.c               |   4 +-
 drivers/watchdog/Kconfig                           |   7 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/ar2315-wtd.c                      | 202 +++++++
 39 files changed, 3911 insertions(+), 10 deletions(-)
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
1.8.1.5
