Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 00:18:56 +0100 (CET)
Received: from mail-lb0-f172.google.com ([209.85.217.172]:47373 "EHLO
        mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011494AbaJ1XSyx2F3R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 00:18:54 +0100
Received: by mail-lb0-f172.google.com with SMTP id n15so1544489lbi.17
        for <multiple recipients>; Tue, 28 Oct 2014 16:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=LaD8AJgjecwqzR0zlEOkh6Yd2XHe0rmgdFo+sqHqRvU=;
        b=T6DofCf9W3xRt7MCvvMfDxcflj0tlLsVARmaXzoYMj5HhRFsAmnQ4vDHIqNkc0dc44
         gQ8wYOAsU/Lzs0UWe6lZiQPH7lyxhhEy6ruKikw8QY4C8mYfQ1ldTJqDokNsG0oga2/d
         p3QL1vB00qkTkNYzJWxvgwyzak5xDRtkTtlTURKI0mTC2Vti28uIbZbiflAiOzYJE46u
         xD2GCZSfSqZDihLJS8CR4g+2K0lF9tbthFoz3UWs8fZtGoPJ08FgG/8NWUnYUiNOHqR6
         zFm1G5lcHZuXd+kFvKdTYp6bby9KbWSjH2+3uxcLvEX4gXuyuBxbACq69mKQR8b//ou5
         SiMw==
X-Received: by 10.152.45.72 with SMTP id k8mr7297281lam.79.1414538328318;
        Tue, 28 Oct 2014 16:18:48 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by mx.google.com with ESMTPSA id i6sm1173752laf.47.2014.10.28.16.18.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Oct 2014 16:18:47 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>
Subject: [PATCH v3 00/13] MIPS: support for the Atheros AR231X SoCs
Date:   Wed, 29 Oct 2014 03:18:37 +0400
Message-Id: <1414538330-5548-1-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 1.8.1.5
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43651
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

Changes since v2:
  - use irq_domain
  - truely remap I/O memory (avoid KSEG1ADDR usage)
  - move some headers from global include directory to machine specific dir
  - a lot of cosmetic changes

Sergey Ryazanov (13):
  MIPS: ath25: add common parts
  MIPS: ath25: add basic AR5312 SoC support
  MIPS: ath25: add basic AR2315 SoC support
  MIPS: ath25: add interrupts handling routines
  MIPS: ath25: add early printk support
  MIPS: ath25: add UART support
  MIPS: ath25: add board configuration detection
  MIPS: ath25: add SoC type detection
  MIPS: ath25: register AR5312 flash controller
  MIPS: ath25: add AR2315 PCI host controller driver
  ath5k: revert AHB bus support removing
  ath5k: update dependencies
  MIPS: ath25: add Wireless device support

 arch/mips/Kbuild.platforms                         |   1 +
 arch/mips/Kconfig                                  |  15 +
 arch/mips/ath25/Kconfig                            |  16 +
 arch/mips/ath25/Makefile                           |  16 +
 arch/mips/ath25/Platform                           |   6 +
 arch/mips/ath25/ar2315.c                           | 364 +++++++++++++++
 arch/mips/ath25/ar2315.h                           |  22 +
 arch/mips/ath25/ar2315_regs.h                      | 410 +++++++++++++++++
 arch/mips/ath25/ar5312.c                           | 393 ++++++++++++++++
 arch/mips/ath25/ar5312.h                           |  22 +
 arch/mips/ath25/ar5312_regs.h                      | 224 +++++++++
 arch/mips/ath25/board.c                            | 235 ++++++++++
 arch/mips/ath25/devices.c                          | 125 +++++
 arch/mips/ath25/devices.h                          |  43 ++
 arch/mips/ath25/early_printk.c                     |  45 ++
 arch/mips/ath25/prom.c                             |  26 ++
 arch/mips/include/asm/mach-ath25/ath25_platform.h  |  73 +++
 .../include/asm/mach-ath25/cpu-feature-overrides.h |  64 +++
 arch/mips/include/asm/mach-ath25/dma-coherence.h   |  82 ++++
 arch/mips/include/asm/mach-ath25/gpio.h            |  16 +
 arch/mips/include/asm/mach-ath25/war.h             |  25 +
 arch/mips/pci/Makefile                             |   1 +
 arch/mips/pci/pci-ar2315.c                         | 511 +++++++++++++++++++++
 drivers/net/wireless/ath/ath5k/Kconfig             |  14 +-
 drivers/net/wireless/ath/ath5k/Makefile            |   1 +
 drivers/net/wireless/ath/ath5k/ahb.c               | 234 ++++++++++
 drivers/net/wireless/ath/ath5k/ath5k.h             |  28 ++
 drivers/net/wireless/ath/ath5k/base.c              |  14 +
 drivers/net/wireless/ath/ath5k/led.c               |   6 +
 29 files changed, 3029 insertions(+), 3 deletions(-)
 create mode 100644 arch/mips/ath25/Kconfig
 create mode 100644 arch/mips/ath25/Makefile
 create mode 100644 arch/mips/ath25/Platform
 create mode 100644 arch/mips/ath25/ar2315.c
 create mode 100644 arch/mips/ath25/ar2315.h
 create mode 100644 arch/mips/ath25/ar2315_regs.h
 create mode 100644 arch/mips/ath25/ar5312.c
 create mode 100644 arch/mips/ath25/ar5312.h
 create mode 100644 arch/mips/ath25/ar5312_regs.h
 create mode 100644 arch/mips/ath25/board.c
 create mode 100644 arch/mips/ath25/devices.c
 create mode 100644 arch/mips/ath25/devices.h
 create mode 100644 arch/mips/ath25/early_printk.c
 create mode 100644 arch/mips/ath25/prom.c
 create mode 100644 arch/mips/include/asm/mach-ath25/ath25_platform.h
 create mode 100644 arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h
 create mode 100644 arch/mips/include/asm/mach-ath25/dma-coherence.h
 create mode 100644 arch/mips/include/asm/mach-ath25/gpio.h
 create mode 100644 arch/mips/include/asm/mach-ath25/war.h
 create mode 100644 arch/mips/pci/pci-ar2315.c
 create mode 100644 drivers/net/wireless/ath/ath5k/ahb.c

-- 
1.8.5.5
