Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Nov 2010 22:51:57 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:56891 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492067Ab0KLVvx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Nov 2010 22:51:53 +0100
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id 4D58641C001;
        Fri, 12 Nov 2010 22:51:48 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 89891270001;
        Fri, 12 Nov 2010 22:51:47 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, "Luis R. Rodriguez" <mcgrof@gmail.com>,
        Cliff Holden <Cliff.Holden@Atheros.com>,
        Imre Kaloz <kaloz@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [RFC 00/18] MIPS: initial support for the Atheros AR71XX/AR724X/AR913X SoCs
Date:   Fri, 12 Nov 2010 22:51:06 +0100
Message-Id: <1289598684-30624-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
X-VBMS: A12258C7DF1 | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28366
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch set contains initial support for the 
Atheros AR71XX/AR724X/AR913X SoCs.

Gabor Juhos (18):
  MIPS: add initial support for the Atheros AR71XX/AR724X/AR931X SoCs
  MIPS: ath79: add GPIOLIB support
  MIPS: add generic support for multiple machines within a single kernel
  MIPS: ath79: utilize the MIPS multi-machine support
  MIPS: ath79: add initial support for the Atheros PB44 reference board
  MIPS: ath79: add common GPIO LEDs device
  watchdog: add driver for the Atheros AR71XX/AR724X/AR913X SoCs
  MIPS: ath79: add common watchdog device
  input: add input driver for polled GPIO buttons
  MIPS: ath79: add common GPIO buttons device
  spi: add SPI controller driver for the Atheros AR71XX/AR724X/AR913X SoCs
  MIPS: ath79: add common SPI controller device
  USB: ehci: add workaround for Synopsys HC bug
  USB: ehci: add bus glue for the Atheros AR71XX/AR724X/AR913X SoCs
  USB: ohci: add bus glue for the Atheros AR71XX/AR7240 SoCs
  MIPS: ath79: add common USB Host Controller device
  MIPS: ath79: add initial support for the Atheros AP81 reference board
  MIPS: ath79: add common WMAC device for AR913X based boards

 arch/mips/Kbuild.platforms                         |    1 +
 arch/mips/Kconfig                                  |   20 ++
 arch/mips/ath79/Kconfig                            |   63 +++++
 arch/mips/ath79/Makefile                           |   27 ++
 arch/mips/ath79/Platform                           |    7 +
 arch/mips/ath79/common.c                           |  113 ++++++++
 arch/mips/ath79/common.h                           |   67 +++++
 arch/mips/ath79/dev-ar913x-wmac.c                  |   60 ++++
 arch/mips/ath79/dev-ar913x-wmac.h                  |   17 ++
 arch/mips/ath79/dev-gpio-buttons.c                 |   58 ++++
 arch/mips/ath79/dev-gpio-buttons.h                 |   23 ++
 arch/mips/ath79/dev-leds-gpio.c                    |   56 ++++
 arch/mips/ath79/dev-leds-gpio.h                    |   21 ++
 arch/mips/ath79/dev-spi.c                          |   38 +++
 arch/mips/ath79/dev-spi.h                          |   22 ++
 arch/mips/ath79/dev-uart.c                         |   59 ++++
 arch/mips/ath79/dev-uart.h                         |   17 ++
 arch/mips/ath79/dev-usb.c                          |  192 +++++++++++++
 arch/mips/ath79/dev-usb.h                          |   17 ++
 arch/mips/ath79/dev-wdt.c                          |   30 ++
 arch/mips/ath79/dev-wdt.h                          |   17 ++
 arch/mips/ath79/early_printk.c                     |   36 +++
 arch/mips/ath79/gpio.c                             |  196 +++++++++++++
 arch/mips/ath79/irq.c                              |  187 +++++++++++++
 arch/mips/ath79/mach-ap81.c                        |   98 +++++++
 arch/mips/ath79/mach-pb44.c                        |  119 ++++++++
 arch/mips/ath79/machtypes.h                        |   23 ++
 arch/mips/ath79/prom.c                             |   57 ++++
 arch/mips/ath79/setup.c                            |  280 +++++++++++++++++++
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h     |  248 +++++++++++++++++
 arch/mips/include/asm/mach-ath79/ath79.h           |   50 ++++
 .../include/asm/mach-ath79/ath79_ehci_platform.h   |   18 ++
 .../include/asm/mach-ath79/ath79_spi_platform.h    |   19 ++
 .../include/asm/mach-ath79/cpu-feature-overrides.h |   56 ++++
 arch/mips/include/asm/mach-ath79/gpio.h            |   26 ++
 arch/mips/include/asm/mach-ath79/irq.h             |   36 +++
 .../include/asm/mach-ath79/kernel-entry-init.h     |   32 +++
 arch/mips/include/asm/mach-ath79/war.h             |   25 ++
 arch/mips/include/asm/mips_machine.h               |   54 ++++
 arch/mips/kernel/Makefile                          |    1 +
 arch/mips/kernel/mips_machine.c                    |   86 ++++++
 arch/mips/kernel/proc.c                            |    7 +-
 arch/mips/kernel/vmlinux.lds.S                     |    7 +
 drivers/input/misc/Kconfig                         |   16 +
 drivers/input/misc/Makefile                        |    1 +
 drivers/input/misc/gpio_buttons.c                  |  232 ++++++++++++++++
 drivers/spi/Kconfig                                |    8 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/ath79_spi.c                            |  291 +++++++++++++++++++
 drivers/usb/Kconfig                                |    5 +
 drivers/usb/host/Kconfig                           |   16 +
 drivers/usb/host/ehci-ath79.c                      |  176 ++++++++++++
 drivers/usb/host/ehci-hcd.c                        |    5 +
 drivers/usb/host/ehci-q.c                          |    3 +
 drivers/usb/host/ehci.h                            |    1 +
 drivers/usb/host/ohci-ath79.c                      |  162 +++++++++++
 drivers/usb/host/ohci-hcd.c                        |    5 +
 drivers/watchdog/Kconfig                           |    8 +
 drivers/watchdog/Makefile                          |    1 +
 drivers/watchdog/ath79_wdt.c                       |  293 ++++++++++++++++++++
 include/linux/gpio_buttons.h                       |   33 +++
 61 files changed, 3842 insertions(+), 1 deletions(-)
 create mode 100644 arch/mips/ath79/Kconfig
 create mode 100644 arch/mips/ath79/Makefile
 create mode 100644 arch/mips/ath79/Platform
 create mode 100644 arch/mips/ath79/common.c
 create mode 100644 arch/mips/ath79/common.h
 create mode 100644 arch/mips/ath79/dev-ar913x-wmac.c
 create mode 100644 arch/mips/ath79/dev-ar913x-wmac.h
 create mode 100644 arch/mips/ath79/dev-gpio-buttons.c
 create mode 100644 arch/mips/ath79/dev-gpio-buttons.h
 create mode 100644 arch/mips/ath79/dev-leds-gpio.c
 create mode 100644 arch/mips/ath79/dev-leds-gpio.h
 create mode 100644 arch/mips/ath79/dev-spi.c
 create mode 100644 arch/mips/ath79/dev-spi.h
 create mode 100644 arch/mips/ath79/dev-uart.c
 create mode 100644 arch/mips/ath79/dev-uart.h
 create mode 100644 arch/mips/ath79/dev-usb.c
 create mode 100644 arch/mips/ath79/dev-usb.h
 create mode 100644 arch/mips/ath79/dev-wdt.c
 create mode 100644 arch/mips/ath79/dev-wdt.h
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
 create mode 100644 arch/mips/include/asm/mips_machine.h
 create mode 100644 arch/mips/kernel/mips_machine.c
 create mode 100644 drivers/input/misc/gpio_buttons.c
 create mode 100644 drivers/spi/ath79_spi.c
 create mode 100644 drivers/usb/host/ehci-ath79.c
 create mode 100644 drivers/usb/host/ohci-ath79.c
 create mode 100644 drivers/watchdog/ath79_wdt.c
 create mode 100644 include/linux/gpio_buttons.h

-- 
1.7.2.1
