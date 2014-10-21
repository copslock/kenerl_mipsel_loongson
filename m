Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 01:03:40 +0200 (CEST)
Received: from mail-lb0-f178.google.com ([209.85.217.178]:52070 "EHLO
        mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012099AbaJUXDivbjqu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Oct 2014 01:03:38 +0200
Received: by mail-lb0-f178.google.com with SMTP id w7so1898626lbi.37
        for <multiple recipients>; Tue, 21 Oct 2014 16:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=x3hUfu97Q8MnQjwRJynmh9UBMSgHbxRo4Qf7r06Gqpk=;
        b=p2dEP5zjGphaYZjmD+C11OBbMnUKUdCiN10NqCdvys1rpkxzeVuSDtoAUQOCAioSYE
         827tBbZyt26yTCXNy9BVnzDXrZ/ETRGwNsIHl6LEa/F94r3KXQbYV5X5KjajlH7kFtjo
         +muVj+zVxtOL0OPrTeXVXGTz613+hrQvB1QUJH5rQSTsn9eyN9VMo+RtfAmXiw3+63lP
         FpeoLUZ1p9GIoCs5CKCZJ8C1IPccEYdta4JxxehEpq9oB7m8mZcW75r6pCgN/mvpPw5m
         +jhlUcMg/SPesTFxXCKl7mSMTbB3h+AcztPpk/4KbBEQlX4qtAeyTd+dLjbecit+l8ak
         xp/A==
X-Received: by 10.112.89.8 with SMTP id bk8mr38374914lbb.30.1413932613091;
        Tue, 21 Oct 2014 16:03:33 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by mx.google.com with ESMTPSA id lk5sm5077133lac.45.2014.10.21.16.03.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2014 16:03:32 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>
Subject: [PATCH v2 00/13] MIPS: support for the Atheros AR231X SoCs
Date:   Wed, 22 Oct 2014 03:03:38 +0400
Message-Id: <1413932631-12866-1-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 1.8.1.5
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43447
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

- Patches 1 through 10 and patch 13 add support for different parts of AR231x
  SoCs.
- Patch 11 recover ath5k AHB bus support
- Patch 12 updates ath5k dependecies

The code was successfully tested with AR2313, AR2315 and AR2317 SoCs.

This code has been written by OpenWRT developers and it resided in OpenWRT's
tree for a long time. My work was to cleanup the code and its rebase on the
latest linux-mips tree.

Changes since RFC:
  - use dynamic IRQ numbers allocation
  - group ath5 related changes in one patch
  - group devices registration in separate patch

Changes since v1:
  - rename MIPS machine ar231x -> ath25
  - drop the GPIO and Watchdog drivers, since they need more work
  - add patch which recover ath5k AHB bus support
  - rebased on top of 3.18-rc1

Sergey Ryazanov (13):
  MIPS: ath25: add common parts
  MIPS: ath25: add basic AR5312 SoC support
  MIPS: ath25: add basic AR2315 SoC support
  MIPS: ath25: add interrupts handling routines
  MIPS: ath25: add early printk support
  MIPS: ath25: add UART support
  MIPS: ath25: add board configuration detection
  MIPS: ath25: add SoC type detection
  MIPS: ath25: register various chip devices
  MIPS: ath25: add AR2315 PCI host controller driver
  ath5k: revert AHB bus support removing
  ath5k: update dependencies
  MIPS: ath25: add Wireless device support

 arch/mips/Kbuild.platforms                         |   1 +
 arch/mips/Kconfig                                  |  15 +
 arch/mips/ath25/Kconfig                            |  18 +
 arch/mips/ath25/Makefile                           |  16 +
 arch/mips/ath25/Platform                           |   6 +
 arch/mips/ath25/ar2315.c                           | 367 +++++++++++++
 arch/mips/ath25/ar2315.h                           |  24 +
 arch/mips/ath25/ar5312.c                           | 374 +++++++++++++
 arch/mips/ath25/ar5312.h                           |  24 +
 arch/mips/ath25/board.c                            | 228 ++++++++
 arch/mips/ath25/devices.c                          | 125 +++++
 arch/mips/ath25/devices.h                          |  39 ++
 arch/mips/ath25/early_printk.c                     |  45 ++
 arch/mips/ath25/prom.c                             |  34 ++
 arch/mips/include/asm/mach-ath25/ar2315_regs.h     | 580 +++++++++++++++++++++
 arch/mips/include/asm/mach-ath25/ar5312_regs.h     | 215 ++++++++
 arch/mips/include/asm/mach-ath25/ath25.h           |  31 ++
 arch/mips/include/asm/mach-ath25/ath25_platform.h  |  73 +++
 .../include/asm/mach-ath25/cpu-feature-overrides.h |  84 +++
 arch/mips/include/asm/mach-ath25/dma-coherence.h   |  76 +++
 arch/mips/include/asm/mach-ath25/gpio.h            |  16 +
 arch/mips/include/asm/mach-ath25/war.h             |  25 +
 arch/mips/pci/Makefile                             |   1 +
 arch/mips/pci/pci-ar2315.c                         | 352 +++++++++++++
 drivers/net/wireless/ath/ath5k/Kconfig             |  14 +-
 drivers/net/wireless/ath/ath5k/Makefile            |   1 +
 drivers/net/wireless/ath/ath5k/ahb.c               | 234 +++++++++
 drivers/net/wireless/ath/ath5k/ath5k.h             |  28 +
 drivers/net/wireless/ath/ath5k/base.c              |  14 +
 drivers/net/wireless/ath/ath5k/led.c               |   6 +
 30 files changed, 3063 insertions(+), 3 deletions(-)
 create mode 100644 arch/mips/ath25/Kconfig
 create mode 100644 arch/mips/ath25/Makefile
 create mode 100644 arch/mips/ath25/Platform
 create mode 100644 arch/mips/ath25/ar2315.c
 create mode 100644 arch/mips/ath25/ar2315.h
 create mode 100644 arch/mips/ath25/ar5312.c
 create mode 100644 arch/mips/ath25/ar5312.h
 create mode 100644 arch/mips/ath25/board.c
 create mode 100644 arch/mips/ath25/devices.c
 create mode 100644 arch/mips/ath25/devices.h
 create mode 100644 arch/mips/ath25/early_printk.c
 create mode 100644 arch/mips/ath25/prom.c
 create mode 100644 arch/mips/include/asm/mach-ath25/ar2315_regs.h
 create mode 100644 arch/mips/include/asm/mach-ath25/ar5312_regs.h
 create mode 100644 arch/mips/include/asm/mach-ath25/ath25.h
 create mode 100644 arch/mips/include/asm/mach-ath25/ath25_platform.h
 create mode 100644 arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h
 create mode 100644 arch/mips/include/asm/mach-ath25/dma-coherence.h
 create mode 100644 arch/mips/include/asm/mach-ath25/gpio.h
 create mode 100644 arch/mips/include/asm/mach-ath25/war.h
 create mode 100644 arch/mips/pci/pci-ar2315.c
 create mode 100644 drivers/net/wireless/ath/ath5k/ahb.c

-- 
1.8.5.5
