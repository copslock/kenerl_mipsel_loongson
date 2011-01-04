Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Jan 2011 21:29:10 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:48500 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490978Ab1ADU3H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Jan 2011 21:29:07 +0100
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id BD38345C016;
        Tue,  4 Jan 2011 21:29:01 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 369A21F0001;
        Tue,  4 Jan 2011 21:29:01 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Imre Kaloz <kaloz@openwrt.org>,
        "Luis R. Rodriguez" <lrodriguez@atheros.com>,
        Cliff Holden <Cliff.Holden@Atheros.com>,
        Kathy Giori <Kathy.Giori@Atheros.com>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH v5 00/16] MIPS: initial support for the Atheros AR71XX/AR724X/AR913X SoCs
Date:   Tue,  4 Jan 2011 21:28:13 +0100
Message-Id: <1294172909-1309-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
X-VBMS: A1089B7A9F5 | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28824
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch set contains initial support for the 
Atheros AR71XX/AR724X/AR913X SoCs.

Generic changes since v1:
    - rebased against 2.6.37-rc7
    - the 'MIPS: Add generic support for multiple machines within a single kernel' 
      patch has been removed, because that is in the mips-queue tree already
    - the 'input: add input driver for polled GPIO buttons' patch has been removed, 
      because a slightly different version of that driver is present in 2.6.37-rc7 
      already as 'gpio_keys_polled'

Generic changes since v2:
    - don't use __init for function declarations

Generic changes since v3:
    - rebased against 2.6.37-rc8
    
Generic changes since v4:
    - implement clock API

Gabor Juhos (16):
  MIPS: add initial support for the Atheros AR71XX/AR724X/AR931X SoCs
  MIPS: ath79: add GPIOLIB support
  MIPS: ath79: utilize the MIPS multi-machine support
  MIPS: ath79: add initial support for the Atheros PB44 reference board
  MIPS: ath79: add common GPIO LEDs device
  watchdog: add driver for the Atheros AR71XX/AR724X/AR913X SoCs
  MIPS: ath79: add common watchdog device
  MIPS: ath79: add common GPIO buttons device
  spi: add SPI controller driver for the Atheros AR71XX/AR724X/AR913X
    SoCs
  MIPS: ath79: add common SPI controller device
  USB: ehci: add workaround for Synopsys HC bug
  USB: ehci: add bus glue for the Atheros AR71XX/AR724X/AR913X SoCs
  USB: ohci: add bus glue for the Atheros AR71XX/AR7240 SoCs
  MIPS: ath79: add common USB Host Controller device
  MIPS: ath79: add initial support for the Atheros AP81 reference board
  MIPS: ath79: add common WMAC device for AR913X based boards

 arch/mips/Kbuild.platforms                         |    1 +
 arch/mips/Kconfig                                  |   17 ++
 arch/mips/ath79/Kconfig                            |   60 ++++
 arch/mips/ath79/Makefile                           |   29 ++
 arch/mips/ath79/Platform                           |    7 +
 arch/mips/ath79/clock.c                            |  183 ++++++++++++
 arch/mips/ath79/common.c                           |   97 +++++++
 arch/mips/ath79/common.h                           |   31 ++
 arch/mips/ath79/dev-ar913x-wmac.c                  |   60 ++++
 arch/mips/ath79/dev-ar913x-wmac.h                  |   17 ++
 arch/mips/ath79/dev-common.c                       |   77 +++++
 arch/mips/ath79/dev-common.h                       |   18 ++
 arch/mips/ath79/dev-gpio-buttons.c                 |   58 ++++
 arch/mips/ath79/dev-gpio-buttons.h                 |   23 ++
 arch/mips/ath79/dev-leds-gpio.c                    |   56 ++++
 arch/mips/ath79/dev-leds-gpio.h                    |   21 ++
 arch/mips/ath79/dev-spi.c                          |   38 +++
 arch/mips/ath79/dev-spi.h                          |   22 ++
 arch/mips/ath79/dev-usb.c                          |  194 +++++++++++++
 arch/mips/ath79/dev-usb.h                          |   17 ++
 arch/mips/ath79/early_printk.c                     |   36 +++
 arch/mips/ath79/gpio.c                             |  197 +++++++++++++
 arch/mips/ath79/irq.c                              |  187 ++++++++++++
 arch/mips/ath79/mach-ap81.c                        |  100 +++++++
 arch/mips/ath79/mach-pb44.c                        |  120 ++++++++
 arch/mips/ath79/machtypes.h                        |   23 ++
 arch/mips/ath79/prom.c                             |   57 ++++
 arch/mips/ath79/setup.c                            |  206 +++++++++++++
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h     |  253 ++++++++++++++++
 arch/mips/include/asm/mach-ath79/ath79.h           |   96 ++++++
 .../include/asm/mach-ath79/ath79_ehci_platform.h   |   18 ++
 .../include/asm/mach-ath79/ath79_spi_platform.h    |   23 ++
 .../include/asm/mach-ath79/cpu-feature-overrides.h |   56 ++++
 arch/mips/include/asm/mach-ath79/gpio.h            |   26 ++
 arch/mips/include/asm/mach-ath79/irq.h             |   36 +++
 .../include/asm/mach-ath79/kernel-entry-init.h     |   32 ++
 arch/mips/include/asm/mach-ath79/war.h             |   25 ++
 drivers/spi/Kconfig                                |    8 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/ath79_spi.c                            |  292 +++++++++++++++++++
 drivers/usb/host/Kconfig                           |   16 +
 drivers/usb/host/ehci-ath79.c                      |  176 +++++++++++
 drivers/usb/host/ehci-hcd.c                        |    5 +
 drivers/usb/host/ehci-q.c                          |    3 +
 drivers/usb/host/ehci.h                            |    1 +
 drivers/usb/host/ohci-ath79.c                      |  162 +++++++++++
 drivers/usb/host/ohci-hcd.c                        |    5 +
 drivers/watchdog/Kconfig                           |    7 +
 drivers/watchdog/Makefile                          |    1 +
 drivers/watchdog/ath79_wdt.c                       |  305 ++++++++++++++++++++
 50 files changed, 3499 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/ath79/Kconfig
 create mode 100644 arch/mips/ath79/Makefile
 create mode 100644 arch/mips/ath79/Platform
 create mode 100644 arch/mips/ath79/clock.c
 create mode 100644 arch/mips/ath79/common.c
 create mode 100644 arch/mips/ath79/common.h
 create mode 100644 arch/mips/ath79/dev-ar913x-wmac.c
 create mode 100644 arch/mips/ath79/dev-ar913x-wmac.h
 create mode 100644 arch/mips/ath79/dev-common.c
 create mode 100644 arch/mips/ath79/dev-common.h
 create mode 100644 arch/mips/ath79/dev-gpio-buttons.c
 create mode 100644 arch/mips/ath79/dev-gpio-buttons.h
 create mode 100644 arch/mips/ath79/dev-leds-gpio.c
 create mode 100644 arch/mips/ath79/dev-leds-gpio.h
 create mode 100644 arch/mips/ath79/dev-spi.c
 create mode 100644 arch/mips/ath79/dev-spi.h
 create mode 100644 arch/mips/ath79/dev-usb.c
 create mode 100644 arch/mips/ath79/dev-usb.h
 create mode 100644 arch/mips/ath79/early_printk.c
 create mode 100644 arch/mips/ath79/gpio.c
 create mode 100644 arch/mips/ath79/irq.c
 create mode 100644 arch/mips/ath79/mach-ap81.c
 create mode 100644 arch/mips/ath79/mach-pb44.c
 create mode 100644 arch/mips/ath79/machtypes.h
 create mode 100644 arch/mips/ath79/prom.c
 create mode 100644 arch/mips/ath79/setup.c
 create mode 100644 arch/mips/include/asm/mach-ath79/ar71xx_regs.h
 create mode 100644 arch/mips/include/asm/mach-ath79/ath79.h
 create mode 100644 arch/mips/include/asm/mach-ath79/ath79_ehci_platform.h
 create mode 100644 arch/mips/include/asm/mach-ath79/ath79_spi_platform.h
 create mode 100644 arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h
 create mode 100644 arch/mips/include/asm/mach-ath79/gpio.h
 create mode 100644 arch/mips/include/asm/mach-ath79/irq.h
 create mode 100644 arch/mips/include/asm/mach-ath79/kernel-entry-init.h
 create mode 100644 arch/mips/include/asm/mach-ath79/war.h
 create mode 100644 drivers/spi/ath79_spi.c
 create mode 100644 drivers/usb/host/ehci-ath79.c
 create mode 100644 drivers/usb/host/ohci-ath79.c
 create mode 100644 drivers/watchdog/ath79_wdt.c

-- 
1.7.2.1
