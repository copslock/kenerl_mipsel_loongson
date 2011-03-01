Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Mar 2011 17:12:59 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:51009 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491821Ab1CAQM2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 1 Mar 2011 17:12:28 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        linux-mips@linux-mips.org
Subject: [PATCH V2 00/10]  MIPS: add support for Lantiq SoCs
Date:   Tue,  1 Mar 2011 17:13:16 +0100
Message-Id: <1298996006-15960-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.2.3
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29303
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips

This series will add support for the Lantiq/XWAY family of SoCs.

Cc: Ralph Hempel <ralph.hempel@lantiq.com>
Cc: linux-mips@linux-mips.org

John Crispin (10):
  MIPS: lantiq: add initial support for Lantiq SoCs
  MIPS: lantiq: add SoC specific code for XWAY family
  MIPS: lantiq: add PCI controller support.
  MIPS: lantiq: add serial port support
  MIPS: lantiq: add watchdog support
  MIPS: lantiq: add NOR flash support
  MIPS: lantiq: add platform device support
  MIPS: lantiq: add mips_machine support
  MIPS: lantiq: add machtypes for lantiq eval kits
  MIPS: lantiq: add more gpio drivers

 arch/mips/Kbuild.platforms                         |    1 +
 arch/mips/Kconfig                                  |   19 +
 arch/mips/include/asm/mach-lantiq/lantiq.h         |   58 ++
 .../mips/include/asm/mach-lantiq/lantiq_platform.h |   46 ++
 arch/mips/include/asm/mach-lantiq/war.h            |   24 +
 arch/mips/include/asm/mach-lantiq/xway/irq.h       |   18 +
 .../mips/include/asm/mach-lantiq/xway/lantiq_irq.h |   62 ++
 .../mips/include/asm/mach-lantiq/xway/lantiq_soc.h |  145 ++++
 arch/mips/lantiq/Kconfig                           |   23 +
 arch/mips/lantiq/Makefile                          |   11 +
 arch/mips/lantiq/Platform                          |    8 +
 arch/mips/lantiq/clk.c                             |  132 ++++
 arch/mips/lantiq/clk.h                             |   18 +
 arch/mips/lantiq/devices.c                         |  128 ++++
 arch/mips/lantiq/devices.h                         |   20 +
 arch/mips/lantiq/early_printk.c                    |   33 +
 arch/mips/lantiq/irq.c                             |  311 ++++++++
 arch/mips/lantiq/machtypes.h                       |   20 +
 arch/mips/lantiq/prom.c                            |   74 ++
 arch/mips/lantiq/prom.h                            |   24 +
 arch/mips/lantiq/setup.c                           |   72 ++
 arch/mips/lantiq/xway/Kconfig                      |   25 +
 arch/mips/lantiq/xway/Makefile                     |    7 +
 arch/mips/lantiq/xway/clk-ase.c                    |   52 ++
 arch/mips/lantiq/xway/clk-xway.c                   |  224 ++++++
 arch/mips/lantiq/xway/devices.c                    |   79 ++
 arch/mips/lantiq/xway/devices.h                    |   17 +
 arch/mips/lantiq/xway/ebu.c                        |   36 +
 arch/mips/lantiq/xway/gpio.c                       |  195 +++++
 arch/mips/lantiq/xway/gpio_ebu.c                   |  125 ++++
 arch/mips/lantiq/xway/gpio_stp.c                   |  157 ++++
 arch/mips/lantiq/xway/mach-easy50601.c             |   70 ++
 arch/mips/lantiq/xway/mach-easy50712.c             |   75 ++
 arch/mips/lantiq/xway/pmu.c                        |   57 ++
 arch/mips/lantiq/xway/prom-ase.c                   |   40 +
 arch/mips/lantiq/xway/prom-xway.c                  |   55 ++
 arch/mips/lantiq/xway/reset.c                      |   67 ++
 arch/mips/pci/Makefile                             |    1 +
 arch/mips/pci/ops-lantiq.c                         |  119 +++
 arch/mips/pci/pci-lantiq.c                         |  303 ++++++++
 arch/mips/pci/pci-lantiq.h                         |   18 +
 drivers/mtd/maps/Kconfig                           |    7 +
 drivers/mtd/maps/Makefile                          |    1 +
 drivers/mtd/maps/lantiq.c                          |  186 +++++
 drivers/tty/serial/Kconfig                         |    8 +
 drivers/tty/serial/Makefile                        |    1 +
 drivers/tty/serial/lantiq.c                        |  775 ++++++++++++++++++++
 drivers/watchdog/Kconfig                           |    6 +
 drivers/watchdog/Makefile                          |    1 +
 drivers/watchdog/lantiq_wdt.c                      |  233 ++++++
 50 files changed, 4187 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-lantiq/lantiq.h
 create mode 100644 arch/mips/include/asm/mach-lantiq/lantiq_platform.h
 create mode 100644 arch/mips/include/asm/mach-lantiq/war.h
 create mode 100644 arch/mips/include/asm/mach-lantiq/xway/irq.h
 create mode 100644 arch/mips/include/asm/mach-lantiq/xway/lantiq_irq.h
 create mode 100644 arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
 create mode 100644 arch/mips/lantiq/Kconfig
 create mode 100644 arch/mips/lantiq/Makefile
 create mode 100644 arch/mips/lantiq/Platform
 create mode 100644 arch/mips/lantiq/clk.c
 create mode 100644 arch/mips/lantiq/clk.h
 create mode 100644 arch/mips/lantiq/devices.c
 create mode 100644 arch/mips/lantiq/devices.h
 create mode 100644 arch/mips/lantiq/early_printk.c
 create mode 100644 arch/mips/lantiq/irq.c
 create mode 100644 arch/mips/lantiq/machtypes.h
 create mode 100644 arch/mips/lantiq/prom.c
 create mode 100644 arch/mips/lantiq/prom.h
 create mode 100644 arch/mips/lantiq/setup.c
 create mode 100644 arch/mips/lantiq/xway/Kconfig
 create mode 100644 arch/mips/lantiq/xway/Makefile
 create mode 100644 arch/mips/lantiq/xway/clk-ase.c
 create mode 100644 arch/mips/lantiq/xway/clk-xway.c
 create mode 100644 arch/mips/lantiq/xway/devices.c
 create mode 100644 arch/mips/lantiq/xway/devices.h
 create mode 100644 arch/mips/lantiq/xway/ebu.c
 create mode 100644 arch/mips/lantiq/xway/gpio.c
 create mode 100644 arch/mips/lantiq/xway/gpio_ebu.c
 create mode 100644 arch/mips/lantiq/xway/gpio_stp.c
 create mode 100644 arch/mips/lantiq/xway/mach-easy50601.c
 create mode 100644 arch/mips/lantiq/xway/mach-easy50712.c
 create mode 100644 arch/mips/lantiq/xway/pmu.c
 create mode 100644 arch/mips/lantiq/xway/prom-ase.c
 create mode 100644 arch/mips/lantiq/xway/prom-xway.c
 create mode 100644 arch/mips/lantiq/xway/reset.c
 create mode 100644 arch/mips/pci/ops-lantiq.c
 create mode 100644 arch/mips/pci/pci-lantiq.c
 create mode 100644 arch/mips/pci/pci-lantiq.h
 create mode 100644 drivers/mtd/maps/lantiq.c
 create mode 100644 drivers/tty/serial/lantiq.c
 create mode 100644 drivers/watchdog/lantiq_wdt.c

-- 
1.7.2.3
