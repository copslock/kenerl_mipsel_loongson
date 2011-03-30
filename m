Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2011 09:27:24 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:45647 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491091Ab1C3H0w (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 30 Mar 2011 09:26:52 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        linux-mips@linux-mips.org
Subject: [PATCH V5 00/10] MIPS: lantiq: add initial support for Lantiq SoCs
Date:   Wed, 30 Mar 2011 09:27:46 +0200
Message-Id: <1301470076-17279-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.2.3
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29622
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips

This series will add support for the Lantiq/XWAY family of SoCs.

Signed-off-by: John Crispin <blogic@openwrt.org>
Signed-off-by: Ralph Hempel <ralph.hempel@lantiq.com>
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
 arch/mips/include/asm/mach-lantiq/lantiq.h         |   60 ++
 .../mips/include/asm/mach-lantiq/lantiq_platform.h |   46 ++
 arch/mips/include/asm/mach-lantiq/war.h            |   24 +
 arch/mips/include/asm/mach-lantiq/xway/irq.h       |   18 +
 .../mips/include/asm/mach-lantiq/xway/lantiq_irq.h |   62 ++
 .../mips/include/asm/mach-lantiq/xway/lantiq_soc.h |  142 ++++
 arch/mips/lantiq/Kconfig                           |   23 +
 arch/mips/lantiq/Makefile                          |   11 +
 arch/mips/lantiq/Platform                          |    8 +
 arch/mips/lantiq/clk.c                             |  150 ++++
 arch/mips/lantiq/clk.h                             |   18 +
 arch/mips/lantiq/devices.c                         |  130 ++++
 arch/mips/lantiq/devices.h                         |   20 +
 arch/mips/lantiq/early_printk.c                    |   34 +
 arch/mips/lantiq/irq.c                             |  338 +++++++++
 arch/mips/lantiq/machtypes.h                       |   20 +
 arch/mips/lantiq/prom.c                            |   77 ++
 arch/mips/lantiq/prom.h                            |   24 +
 arch/mips/lantiq/setup.c                           |   72 ++
 arch/mips/lantiq/xway/Kconfig                      |   23 +
 arch/mips/lantiq/xway/Makefile                     |    7 +
 arch/mips/lantiq/xway/clk-ase.c                    |   52 ++
 arch/mips/lantiq/xway/clk-xway.c                   |  232 ++++++
 arch/mips/lantiq/xway/devices.c                    |   79 +++
 arch/mips/lantiq/xway/devices.h                    |   17 +
 arch/mips/lantiq/xway/ebu.c                        |   54 ++
 arch/mips/lantiq/xway/gpio.c                       |  203 ++++++
 arch/mips/lantiq/xway/gpio_ebu.c                   |  130 ++++
 arch/mips/lantiq/xway/gpio_stp.c                   |  160 +++++
 arch/mips/lantiq/xway/mach-easy50601.c             |   70 ++
 arch/mips/lantiq/xway/mach-easy50712.c             |   75 ++
 arch/mips/lantiq/xway/pmu.c                        |   73 ++
 arch/mips/lantiq/xway/prom-ase.c                   |   40 ++
 arch/mips/lantiq/xway/prom-xway.c                  |   55 ++
 arch/mips/lantiq/xway/reset.c                      |   82 +++
 arch/mips/pci/Makefile                             |    1 +
 arch/mips/pci/ops-lantiq.c                         |  119 ++++
 arch/mips/pci/pci-lantiq.c                         |  302 ++++++++
 arch/mips/pci/pci-lantiq.h                         |   18 +
 drivers/mtd/maps/Kconfig                           |    9 +
 drivers/mtd/maps/Makefile                          |    1 +
 drivers/mtd/maps/lantiq.c                          |  181 +++++
 drivers/tty/serial/Kconfig                         |    8 +
 drivers/tty/serial/Makefile                        |    1 +
 drivers/tty/serial/lantiq.c                        |  733 ++++++++++++++++++++
 drivers/watchdog/Kconfig                           |    6 +
 drivers/watchdog/Makefile                          |    1 +
 drivers/watchdog/lantiq_wdt.c                      |  217 ++++++
 50 files changed, 4246 insertions(+), 0 deletions(-)
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
