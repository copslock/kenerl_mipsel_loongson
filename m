Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jan 2016 00:55:56 +0100 (CET)
Received: from exsmtp01.microchip.com ([198.175.253.37]:33466 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27010161AbcAGXzxHUGIu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Jan 2016 00:55:53 +0100
Received: from mx.microchip.com (10.10.76.4) by CHN-SV-EXCH01.mchp-main.com
 (10.10.76.37) with Microsoft SMTP Server id 14.3.181.6; Thu, 7 Jan 2016
 16:55:44 -0700
Received: by mx.microchip.com (sSMTP sendmail emulation); Thu, 07 Jan 2016
 17:03:22 -0700
From:   Joshua Henderson <joshua.henderson@microchip.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        Joshua Henderson <joshua.henderson@microchip.com>,
        Andrei Pistirica <andrei.pistirica@microchip.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        Andy Green <andy.green@linaro.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Corneliu Doban <cdoban@broadcom.com>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Jean Delvare <jdelvare@suse.de>,
        Kevin Hao <haokexin@gmail.com>, <linux-api@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        "ludovic.desroches@atmel.com" <ludovic.desroches@atmel.com>,
        Luis de Bethencourt <luisbg@osg.samsung.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Purna Chandra Mandal <purna.mandal@microchip.com>,
        Rob Herring <robh@kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Vincent Yang <vincent.yang.fujitsu@gmail.com>,
        Weijun Yang <Weijun.Yang@csr.com>,
        yangbo lu <yangbo.lu@freescale.com>
Subject: [PATCH v3 00/14] Initial Microchip PIC32MZDA Support
Date:   Thu, 7 Jan 2016 17:00:15 -0700
Message-ID: <1452211389-31025-1-git-send-email-joshua.henderson@microchip.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Joshua.Henderson@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50967
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joshua.henderson@microchip.com
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

This patch series adds support for the Microchip PIC32MZDA MIPS platform.
All drivers required to boot from a MMC uSD card are included. Clock,
external interrupt controller, serial, SDHCI, and pinctrl drivers are
included. This has been tested on a PIC32MZDA Starter Kit. A tree with
these changes is available at [0].

[0] https://github.com/joshua-henderson/linux/tree/pic32-upstream-v3

Changes since v2 (https://lkml.org/lkml/2015/12/14/818):

	+ Prefer dt/bindings: prefix for subject
	+ Remove redundant irq_chip functions in interrupt driver
	+ Use 'sdhci_pltfm_*' instead of 'sdhci_*_host' and other cleanup
	+ Use dynamic major/minor and ttyPIC* instead of ttyS*
	+ Follow device-tree node naming convention for clocks
	+ Remove pinctrl pins that are not port pins
	+ Force lowercase in PIC32 clock binding documentation
	+ Replace __clk_debug with pr_debug
	+ Add of_clk_parent_fill usage in PIC32 clock driver
	+ UART: Remove unused header files
	+ UART: Refactor register read/write functions
	+ UART: Reorder arguments to readl/writel functions
	+ UART: Add missing initializations to termios
	+ UART: Fix clk enable/disable mismatch

Changes since v1 (https://lkml.org/lkml/2015/11/20/848):

	+ Rename all DT compatible properties to be chip specific.
	+ Remove hardware interrupt priorities from interrupt controller DT
	  bindings.
	+ Remove all dependencies on include headers used by PIC32 DTS
	  files.
	+ Remove arch/mips/include/asm/mach-pic32/gpio.h
	+ Drop usage of the following, mostly non-standard, properties in
	  DT bindings:
		device_type
		piomode
		no-1-8-v
		uart-has-rtscts
		clock-frequency => assigned-clock-rate
	+ Remove PIC32 memory PLL support from DT.
	+ Replace empty 'ranges' with populated one for clock tree node.
	+ Rename all instances of "USART" to "UART".
	+ Remove 'interrupts' property from FSCM of PIC32 clock tree node.
	+ Add default REFCLK rate initialization required for SDHCI in DTS.
	+ Remove default frequency setup for REFOSC clocks in -clk DTS.
	+ Address missing static on local functions and other sparse
	  warnings in several drivers.
	+ Update pinctrl driver to address major binding and architectural
	  issues.
	+ Remove redundant probing 'pb7_clk' to find CPU clock.
	+ Remove unused PIC32 MPLL support.
	+ Remove support for initializing default parent/rate for REFOSC
	  clocks.
	+ Be consistent and use only "SDHCI" when referring to SD host
	  controller
	+ Remove unnecessary PIC32 sdhci_ops min clock function.
	+ Make platform PIC32[_CLR|_SET|_INV] register macros safer.


Andrei Pistirica (4):
  dt/bindings: Add bindings for PIC32 UART driver
  serial: pic32_uart: Add PIC32 UART driver
  dt/bindings: Add bindings for PIC32 SDHCI host controller
  mmc: sdhci-pic32: Add PIC32 SDHCI host controller driver

Cristian Birsan (2):
  dt/bindings: Add bindings for PIC32 interrupt controller
  irqchip: irq-pic32-evic: Add support for PIC32 interrupt controller

Joshua Henderson (6):
  dt/bindings: Add bindings for PIC32/MZDA platforms
  MIPS: Add support for PIC32MZDA platform
  dt/bindings: Add bindings for PIC32 pin control and GPIO
  pinctrl: pinctrl-pic32: Add PIC32 pin control driver
  MIPS: dts: Add initial DTS for the PIC32MZDA Starter Kit
  MIPS: pic32mzda: Add initial PIC32MZDA Starter Kit defconfig

Purna Chandra Mandal (2):
  dt/bindings: Add PIC32 clock binding documentation
  clk: clk-pic32: Add PIC32 clock driver

 .../devicetree/bindings/clock/microchip,pic32.txt  |  257 +++
 .../bindings/gpio/microchip,pic32-gpio.txt         |   49 +
 .../interrupt-controller/microchip,pic32-evic.txt  |   58 +
 .../bindings/mips/pic32/microchip,pic32mzda.txt    |   33 +
 .../bindings/mmc/microchip,sdhci-pic32.txt         |   29 +
 .../bindings/pinctrl/microchip,pic32-pinctrl.txt   |   60 +
 .../bindings/serial/microchip,pic32-uart.txt       |   29 +
 arch/mips/Kbuild.platforms                         |    1 +
 arch/mips/Kconfig                                  |    9 +
 arch/mips/boot/dts/Makefile                        |    1 +
 arch/mips/boot/dts/pic32/Makefile                  |   12 +
 arch/mips/boot/dts/pic32/pic32mzda-clk.dtsi        |  236 ++
 arch/mips/boot/dts/pic32/pic32mzda.dtsi            |  275 +++
 arch/mips/boot/dts/pic32/pic32mzda_sk.dts          |  151 ++
 arch/mips/configs/pic32mzda_defconfig              |   89 +
 .../include/asm/mach-pic32/cpu-feature-overrides.h |   32 +
 arch/mips/include/asm/mach-pic32/irq.h             |   22 +
 arch/mips/include/asm/mach-pic32/pic32.h           |   44 +
 arch/mips/include/asm/mach-pic32/spaces.h          |   24 +
 arch/mips/pic32/Kconfig                            |   50 +
 arch/mips/pic32/Makefile                           |    6 +
 arch/mips/pic32/Platform                           |    7 +
 arch/mips/pic32/common/Makefile                    |    5 +
 arch/mips/pic32/common/irq.c                       |   21 +
 arch/mips/pic32/common/reset.c                     |   62 +
 arch/mips/pic32/pic32mzda/Makefile                 |    9 +
 arch/mips/pic32/pic32mzda/config.c                 |  126 ++
 arch/mips/pic32/pic32mzda/early_clk.c              |  106 +
 arch/mips/pic32/pic32mzda/early_console.c          |  171 ++
 arch/mips/pic32/pic32mzda/early_pin.c              |  275 +++
 arch/mips/pic32/pic32mzda/early_pin.h              |  241 ++
 arch/mips/pic32/pic32mzda/init.c                   |  156 ++
 arch/mips/pic32/pic32mzda/pic32mzda.h              |   29 +
 arch/mips/pic32/pic32mzda/time.c                   |   44 +
 drivers/clk/Kconfig                                |    3 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/clk-pic32.c                            | 1801 +++++++++++++++
 drivers/irqchip/Makefile                           |    1 +
 drivers/irqchip/irq-pic32-evic.c                   |  307 +++
 drivers/mmc/host/Kconfig                           |   11 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/sdhci-pic32.c                     |  257 +++
 drivers/pinctrl/Kconfig                            |   17 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/pinctrl-pic32.c                    | 2339 ++++++++++++++++++++
 drivers/pinctrl/pinctrl-pic32.h                    |  141 ++
 drivers/tty/serial/Kconfig                         |   21 +
 drivers/tty/serial/Makefile                        |    1 +
 drivers/tty/serial/pic32_uart.c                    |  955 ++++++++
 drivers/tty/serial/pic32_uart.h                    |  126 ++
 include/linux/irqchip/pic32-evic.h                 |   19 +
 include/linux/platform_data/sdhci-pic32.h          |   22 +
 include/uapi/linux/serial_core.h                   |    3 +
 53 files changed, 8746 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/microchip,pic32.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/microchip,pic32-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/microchip,pic32-evic.txt
 create mode 100644 Documentation/devicetree/bindings/mips/pic32/microchip,pic32mzda.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/microchip,sdhci-pic32.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/microchip,pic32-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/serial/microchip,pic32-uart.txt
 create mode 100644 arch/mips/boot/dts/pic32/Makefile
 create mode 100644 arch/mips/boot/dts/pic32/pic32mzda-clk.dtsi
 create mode 100644 arch/mips/boot/dts/pic32/pic32mzda.dtsi
 create mode 100644 arch/mips/boot/dts/pic32/pic32mzda_sk.dts
 create mode 100644 arch/mips/configs/pic32mzda_defconfig
 create mode 100644 arch/mips/include/asm/mach-pic32/cpu-feature-overrides.h
 create mode 100644 arch/mips/include/asm/mach-pic32/irq.h
 create mode 100644 arch/mips/include/asm/mach-pic32/pic32.h
 create mode 100644 arch/mips/include/asm/mach-pic32/spaces.h
 create mode 100644 arch/mips/pic32/Kconfig
 create mode 100644 arch/mips/pic32/Makefile
 create mode 100644 arch/mips/pic32/Platform
 create mode 100644 arch/mips/pic32/common/Makefile
 create mode 100644 arch/mips/pic32/common/irq.c
 create mode 100644 arch/mips/pic32/common/reset.c
 create mode 100644 arch/mips/pic32/pic32mzda/Makefile
 create mode 100644 arch/mips/pic32/pic32mzda/config.c
 create mode 100644 arch/mips/pic32/pic32mzda/early_clk.c
 create mode 100644 arch/mips/pic32/pic32mzda/early_console.c
 create mode 100644 arch/mips/pic32/pic32mzda/early_pin.c
 create mode 100644 arch/mips/pic32/pic32mzda/early_pin.h
 create mode 100644 arch/mips/pic32/pic32mzda/init.c
 create mode 100644 arch/mips/pic32/pic32mzda/pic32mzda.h
 create mode 100644 arch/mips/pic32/pic32mzda/time.c
 create mode 100644 drivers/clk/clk-pic32.c
 create mode 100644 drivers/irqchip/irq-pic32-evic.c
 create mode 100644 drivers/mmc/host/sdhci-pic32.c
 create mode 100644 drivers/pinctrl/pinctrl-pic32.c
 create mode 100644 drivers/pinctrl/pinctrl-pic32.h
 create mode 100644 drivers/tty/serial/pic32_uart.c
 create mode 100644 drivers/tty/serial/pic32_uart.h
 create mode 100644 include/linux/irqchip/pic32-evic.h
 create mode 100644 include/linux/platform_data/sdhci-pic32.h

--
1.7.9.5
