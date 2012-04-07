Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Apr 2012 18:49:01 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:36596 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1904106Ab2DGQsy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 7 Apr 2012 18:48:54 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SGYof-0004dH-TH; Sat, 07 Apr 2012 11:48:45 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH 00/10] Add support MIPS SEAD-3 Development Platform.
Date:   Sat,  7 Apr 2012 11:48:25 -0500
Message-Id: <1333817315-30091-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.6
X-archive-position: 32878
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

This patch set adds support for the MIPS Technologies, Inc. SEAD-3
development platform. Please visit <http://www.mips.com/> for more
detailed information.

Steven J. Hill (10):
  MIPS: Add core files for MIPS SEAD-3 development platform.
  MIPS: Changes to configuration files for SEAD-3 platform.
  MIPS: Add support for the M14K core.
  MIPS: Add micro-assembler support for 'ins' and 'ext' instructions.
  MIPS: GIC interrupt changes for M14K and SEAD-3 support.
  MIPS: Code formatting fixes.
  MIPS: Add support for early serial debug and LCD device on SEAD-3.
  MIPS: MIPS32R2 optimisations for pipeline stalls and code size.
  cobalt_lcdfb: LCD panel framebuffer support for SEAD-3 platform.
  usb: host: mips: sead3: USB Host controller support for SEAD-3
    platform.

 arch/mips/Kbuild.platforms                         |    1 +
 arch/mips/Kconfig                                  |   33 +-
 arch/mips/configs/sead3_defconfig                  | 1757 ++++++++++++++++++++
 arch/mips/include/asm/cpu-features.h               |    4 +-
 arch/mips/include/asm/cpu.h                        |    5 +-
 .../include/asm/mach-sead3/cpu-feature-overrides.h |   72 +
 arch/mips/include/asm/mach-sead3/irq.h             |    9 +
 .../include/asm/mach-sead3/kernel-entry-init.h     |   52 +
 arch/mips/include/asm/mach-sead3/war.h             |   25 +
 arch/mips/include/asm/mips-boards/generic.h        |    1 +
 arch/mips/include/asm/mips-boards/sead3int.h       |   67 +
 arch/mips/include/asm/uasm.h                       |   15 +
 arch/mips/kernel/cevt-r4k.c                        |    5 +
 arch/mips/kernel/cpu-probe.c                       |   64 +-
 arch/mips/kernel/early_printk.c                    |   25 +
 arch/mips/kernel/irq-gic.c                         |  168 +-
 arch/mips/mm/c-r4k.c                               |    1 +
 arch/mips/mm/tlbex.c                               |   54 +-
 arch/mips/mm/uasm.c                                |   15 +
 arch/mips/mti-sead3/Makefile                       |   24 +
 arch/mips/mti-sead3/Platform                       |    7 +
 arch/mips/mti-sead3/leds-sead3.c                   |  133 ++
 arch/mips/mti-sead3/sead3-cmdline.c                |   59 +
 arch/mips/mti-sead3/sead3-console.c                |   52 +
 arch/mips/mti-sead3/sead3-display.c                |   90 +
 arch/mips/mti-sead3/sead3-ehci.c                   |   52 +
 arch/mips/mti-sead3/sead3-i2c-dev.c                |   38 +
 arch/mips/mti-sead3/sead3-i2c.c                    |   42 +
 arch/mips/mti-sead3/sead3-init.c                   |  244 +++
 arch/mips/mti-sead3/sead3-int.c                    |  146 ++
 arch/mips/mti-sead3/sead3-lcd.c                    |   55 +
 arch/mips/mti-sead3/sead3-leds.c                   |   91 +
 arch/mips/mti-sead3/sead3-memory.c                 |  178 ++
 arch/mips/mti-sead3/sead3-mtd.c                    |   58 +
 arch/mips/mti-sead3/sead3-net.c                    |   56 +
 arch/mips/mti-sead3/sead3-pic32-bus.c              |  112 ++
 arch/mips/mti-sead3/sead3-pic32-i2c-drv.c          |  441 +++++
 arch/mips/mti-sead3/sead3-platform.c               |   49 +
 arch/mips/mti-sead3/sead3-reset.c                  |   64 +
 arch/mips/mti-sead3/sead3-setup.c                  |   49 +
 arch/mips/mti-sead3/sead3-smtc.c                   |  162 ++
 arch/mips/mti-sead3/sead3-time.c                   |  145 ++
 arch/mips/oprofile/common.c                        |    1 +
 arch/mips/oprofile/op_model_mipsxx.c               |    4 +
 drivers/usb/host/Kconfig                           |    4 +-
 drivers/usb/host/ehci-hcd.c                        |    5 +
 drivers/usb/host/ehci-sead3.c                      |  299 ++++
 drivers/video/Kconfig                              |    2 +-
 drivers/video/cobalt_lcdfb.c                       |   45 +-
 49 files changed, 5029 insertions(+), 51 deletions(-)
 create mode 100644 arch/mips/configs/sead3_defconfig
 create mode 100644 arch/mips/include/asm/mach-sead3/cpu-feature-overrides.h
 create mode 100644 arch/mips/include/asm/mach-sead3/irq.h
 create mode 100644 arch/mips/include/asm/mach-sead3/kernel-entry-init.h
 create mode 100644 arch/mips/include/asm/mach-sead3/war.h
 create mode 100644 arch/mips/include/asm/mips-boards/sead3int.h
 create mode 100644 arch/mips/mti-sead3/Makefile
 create mode 100644 arch/mips/mti-sead3/Platform
 create mode 100644 arch/mips/mti-sead3/leds-sead3.c
 create mode 100644 arch/mips/mti-sead3/sead3-cmdline.c
 create mode 100644 arch/mips/mti-sead3/sead3-console.c
 create mode 100644 arch/mips/mti-sead3/sead3-display.c
 create mode 100644 arch/mips/mti-sead3/sead3-ehci.c
 create mode 100644 arch/mips/mti-sead3/sead3-i2c-dev.c
 create mode 100644 arch/mips/mti-sead3/sead3-i2c.c
 create mode 100644 arch/mips/mti-sead3/sead3-init.c
 create mode 100644 arch/mips/mti-sead3/sead3-int.c
 create mode 100644 arch/mips/mti-sead3/sead3-lcd.c
 create mode 100644 arch/mips/mti-sead3/sead3-leds.c
 create mode 100644 arch/mips/mti-sead3/sead3-memory.c
 create mode 100644 arch/mips/mti-sead3/sead3-mtd.c
 create mode 100644 arch/mips/mti-sead3/sead3-net.c
 create mode 100644 arch/mips/mti-sead3/sead3-pic32-bus.c
 create mode 100644 arch/mips/mti-sead3/sead3-pic32-i2c-drv.c
 create mode 100644 arch/mips/mti-sead3/sead3-platform.c
 create mode 100644 arch/mips/mti-sead3/sead3-reset.c
 create mode 100644 arch/mips/mti-sead3/sead3-setup.c
 create mode 100644 arch/mips/mti-sead3/sead3-smtc.c
 create mode 100644 arch/mips/mti-sead3/sead3-time.c
 create mode 100644 drivers/usb/host/ehci-sead3.c

-- 
1.7.9.6
