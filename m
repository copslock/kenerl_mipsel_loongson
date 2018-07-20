Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jul 2018 13:58:50 +0200 (CEST)
Received: from nbd.name ([IPv6:2a01:4f8:221:3d45::2]:46150 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993256AbeGTL6rzq72A (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 Jul 2018 13:58:47 +0200
From:   John Crispin <john@phrozen.org>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <john@phrozen.org>
Subject: [PATCH V2 00/25] MIPS: ath79: convert target to pure OF
Date:   Fri, 20 Jul 2018 13:58:17 +0200
Message-Id: <20180720115842.8406-1-john@phrozen.org>
X-Mailer: git-send-email 2.11.0
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64957
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

In the last couple of months we have been conevrting this target to OF
inside OpenWrt. This series is an aggragte of all the patches that have
been produced in that period. There have been plenty of dts contributions
already and we hope to be able to drop the old mach file based target in
the not too distant future.

Felix Fietkau (9):
  MIPS: ath79: fix register address in ath79_ddr_wb_flush()
  MIPS: ath79: fix system restart
  MIPS: ath79: finetune cpu-overrides
  MIPS: ath79: add helpers for setting clocks and expose the ref clock
  MIPS: ath79: move legacy "wdt" and "uart" clock aliases out of soc
    init
  MIPS: ath79: pass PLL base to clock init functions
  MIPS: ath79: make specifying the reference clock in DT optional
  MIPS: ath79: support setting up clock via DT on all SoC types
  MIPS: ath79: export switch MDIO reference clock

Gabor Juhos (2):
  MIPS: ath79: add lots of missing registers
  MIPS: ath79: enable uart during early_prink

John Crispin (12):
  MIPS: ath79: select the PINCTRL subsystem
  dt-bindings: PCI: qcom,ar7100: adds binding doc
  MIPS: pci-ar71xx: convert to OF
  dt-bindings: PCI: qcom,ar7240: adds binding doc
  MIPS: pci-ar724x: convert to OF
  MIPS: ath79: drop legacy IRQ code
  MIPS: ath79: drop machfiles
  MIPS: ath79: drop legacy pci code
  MIPS: ath79: drop platform device registration code
  MIPS: ath79: drop !OF clock code
  MIPS: ath79: sanitize symbols
  spi: ath79: drop pdata support

Mathias Kresin (1):
  MIPS: ath79: get PCIe controller out of reset

Matthias Schiffer (1):
  MIPS: ath79: add support for QCA953x QCA956x TP9343

---
Changes in V1->V2
* minor fixes in DT binding docs
* add a few missing SoBs
* add the SPI patch to the series
* drop the unreachable patch

 .../devicetree/bindings/pci/qcom,ar7100-pci.txt    |  38 +
 .../devicetree/bindings/pci/qcom,ar7240-pci.txt    |  42 ++
 arch/mips/Kconfig                                  |   4 +-
 arch/mips/ath79/Kconfig                            | 117 +---
 arch/mips/ath79/Makefile                           |  23 +-
 arch/mips/ath79/clock.c                            | 463 ++++++++-----
 arch/mips/ath79/common.c                           |  10 +-
 arch/mips/ath79/common.h                           |   5 -
 arch/mips/ath79/dev-common.c                       | 159 -----
 arch/mips/ath79/dev-common.h                       |  18 -
 arch/mips/ath79/dev-gpio-buttons.c                 |  56 --
 arch/mips/ath79/dev-gpio-buttons.h                 |  23 -
 arch/mips/ath79/dev-leds-gpio.c                    |  54 --
 arch/mips/ath79/dev-leds-gpio.h                    |  21 -
 arch/mips/ath79/dev-spi.c                          |  38 -
 arch/mips/ath79/dev-spi.h                          |  22 -
 arch/mips/ath79/dev-usb.c                          | 242 -------
 arch/mips/ath79/dev-usb.h                          |  17 -
 arch/mips/ath79/dev-wmac.c                         | 155 -----
 arch/mips/ath79/dev-wmac.h                         |  17 -
 arch/mips/ath79/early_printk.c                     |  48 +-
 arch/mips/ath79/irq.c                              | 169 -----
 arch/mips/ath79/mach-ap121.c                       |  92 ---
 arch/mips/ath79/mach-ap136.c                       | 156 -----
 arch/mips/ath79/mach-ap81.c                        | 100 ---
 arch/mips/ath79/mach-db120.c                       | 136 ----
 arch/mips/ath79/mach-pb44.c                        | 128 ----
 arch/mips/ath79/mach-ubnt-xm.c                     | 126 ----
 arch/mips/ath79/machtypes.h                        |  28 -
 arch/mips/ath79/pci.c                              | 273 --------
 arch/mips/ath79/pci.h                              |  35 -
 arch/mips/ath79/setup.c                            | 113 ++-
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h     | 771 ++++++++++++++++++++-
 arch/mips/include/asm/mach-ath79/ath79.h           |  38 +-
 .../include/asm/mach-ath79/ath79_spi_platform.h    |  19 -
 .../include/asm/mach-ath79/cpu-feature-overrides.h |   6 +
 arch/mips/pci/Makefile                             |   3 +-
 arch/mips/pci/fixup-ath79.c                        |  21 +
 arch/mips/pci/pci-ar71xx.c                         |  82 +--
 arch/mips/pci/pci-ar724x.c                         | 130 ++--
 drivers/spi/spi-ath79.c                            |   8 -
 include/dt-bindings/clock/ath79-clk.h              |   4 +-
 42 files changed, 1454 insertions(+), 2556 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,ar7100-pci.txt
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,ar7240-pci.txt
 delete mode 100644 arch/mips/ath79/dev-common.c
 delete mode 100644 arch/mips/ath79/dev-common.h
 delete mode 100644 arch/mips/ath79/dev-gpio-buttons.c
 delete mode 100644 arch/mips/ath79/dev-gpio-buttons.h
 delete mode 100644 arch/mips/ath79/dev-leds-gpio.c
 delete mode 100644 arch/mips/ath79/dev-leds-gpio.h
 delete mode 100644 arch/mips/ath79/dev-spi.c
 delete mode 100644 arch/mips/ath79/dev-spi.h
 delete mode 100644 arch/mips/ath79/dev-usb.c
 delete mode 100644 arch/mips/ath79/dev-usb.h
 delete mode 100644 arch/mips/ath79/dev-wmac.c
 delete mode 100644 arch/mips/ath79/dev-wmac.h
 delete mode 100644 arch/mips/ath79/irq.c
 delete mode 100644 arch/mips/ath79/mach-ap121.c
 delete mode 100644 arch/mips/ath79/mach-ap136.c
 delete mode 100644 arch/mips/ath79/mach-ap81.c
 delete mode 100644 arch/mips/ath79/mach-db120.c
 delete mode 100644 arch/mips/ath79/mach-pb44.c
 delete mode 100644 arch/mips/ath79/mach-ubnt-xm.c
 delete mode 100644 arch/mips/ath79/machtypes.h
 delete mode 100644 arch/mips/ath79/pci.c
 delete mode 100644 arch/mips/ath79/pci.h
 delete mode 100644 arch/mips/include/asm/mach-ath79/ath79_spi_platform.h
 create mode 100644 arch/mips/pci/fixup-ath79.c

-- 
2.11.0
