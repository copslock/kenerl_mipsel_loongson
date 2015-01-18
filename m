Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Jan 2015 23:28:29 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:23900 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010992AbbARW21NE7BN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Jan 2015 23:28:27 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id D55A4D00FD45C
        for <linux-mips@linux-mips.org>; Sun, 18 Jan 2015 22:28:16 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Sun, 18 Jan 2015 22:28:20 +0000
Received: from localhost (192.168.159.114) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Sun, 18 Jan
 2015 22:28:16 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 00/36] jz4780 & CI20 support
Date:   Sun, 18 Jan 2015 14:27:11 -0800
Message-ID: <1421620067-23933-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.2.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.114]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45249
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

This series introduces initial support for the Ingenic jz4780 SoC & the
MIPS Creator CI20 board which is based upon it. Along the way the jz4740
& qi_lb60 (Ben NanoNote) are converted to use DT for some things in
order to ease the process of sharing code.

Paul Burton (36):
  devicetree/bindings: add Ingenic Semiconductor vendor prefix
  MIPS: jz4740: require & include DT
  MIPS: irq_cpu: declare irqchip table entry
  MIPS: jz4740: probe CPU interrupt controller via DT
  MIPS: jz4740: use generic plat_irq_dispatch
  MIPS: jz4740: move arch_init_irq out of arch/mips/jz4740/irq.c
  devicetree: document ingenic,jz4740-intc binding
  MIPS: jz4740: allow interrupt controller probe via DT
  MIPS: jz4740: probe interrupt controller via DT
  MIPS: jz4740: remove non-DT interrupt controller init
  MIPS: jz4740: register an irq_domain for the interrupt controller
  MIPS: jz4740: call jz4740_clock_init earlier
  MIPS: jz4740: replace use of jz4740_clock_bdata
  clk: jz47xx-cgu: add driver for Ingenic jz47xx series CGU clocks
  devicetree: add ingenic,jz4740-cgu binding documentation
  MIPS,clk: migrate jz4740 to common clock framework
  MIPS,clk: move jz4740_clock_set_wait_mode to jz4740-cgu
  MIPS,clk: move jz4740 UDC auto suspend functions to jz4740-cgu
  MIPS,clk: move jz4740 clock suspend,resume functions to jz4740-cgu
  MIPS: jz4740: remove clock.h
  MIPS: jz4740: only detect RAM size if not specified in DT
  MIPS: jz4740: support >32 interrupts
  MIPS: jz4740: define IRQ numbers based on number of intc IRQs
  devicetree: document ingenic,jz4740-uart binding
  devicetree: document ingenic,jz4780-uart binding
  serial: 8250_jz47xx: support for Ingenic jz47xx UARTs
  MIPS: allow mach-provided serial.h
  MIPS: jz4740: use jz47xx-uart & DT for UART output
  devicetree: add ingenic,jz4780-cgu binding documentation
  clk: add Ingenic jz4780 CGU driver
  devicetree: document ingenic,jz4780-intc binding
  MIPS: jz4740: add jz4780 interrupt controller support
  MIPS: add jz4780 Ingenic vendor ID
  MIPS: initial Ingenic jz4780 support
  MIPS: initial MIPS Creator CI20 board support
  MIPS: allow jz4780 to be selected in Kconfig

 .../bindings/clock/ingenic,jz4740-cgu.txt          |  52 ++
 .../bindings/clock/ingenic,jz4780-cgu.txt          |  52 ++
 .../interrupt-controller/ingenic,jz4740-intc.txt   |  24 +
 .../interrupt-controller/ingenic,jz4780-intc.txt   |  24 +
 .../bindings/serial/ingenic,jz4740-uart.txt        |  22 +
 .../bindings/serial/ingenic,jz4780-uart.txt        |  22 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/mips/Kconfig                                  |  22 +-
 arch/mips/boot/dts/Makefile                        |   2 +
 arch/mips/boot/dts/ci20.dts                        |  21 +
 arch/mips/boot/dts/jz4740.dtsi                     |  68 ++
 arch/mips/boot/dts/jz4780.dtsi                     | 101 +++
 arch/mips/boot/dts/qi_lb60.dts                     |  15 +
 arch/mips/configs/ci20_defconfig                   | 128 +++
 arch/mips/include/asm/Kbuild                       |   1 -
 arch/mips/include/asm/cpu.h                        |   1 +
 arch/mips/include/asm/mach-generic/serial.h        |  25 +
 arch/mips/include/asm/mach-jz4740/clock.h          |   3 +
 arch/mips/include/asm/mach-jz4740/irq.h            |  15 +-
 arch/mips/include/asm/mach-jz4740/platform.h       |   2 -
 arch/mips/include/asm/mach-jz4740/serial.h         |  31 +
 arch/mips/include/asm/serial.h                     |  25 +
 arch/mips/jz4740/Kconfig                           |  10 +
 arch/mips/jz4740/Makefile                          |   6 +-
 arch/mips/jz4740/Platform                          |   4 +
 arch/mips/jz4740/board-qi_lb60.c                   |   7 -
 arch/mips/jz4740/clock-debugfs.c                   | 108 ---
 arch/mips/jz4740/clock.c                           | 924 ---------------------
 arch/mips/jz4740/clock.h                           |  76 --
 arch/mips/jz4740/irq.c                             | 103 ++-
 arch/mips/jz4740/platform.c                        |  37 +-
 arch/mips/jz4740/pm.c                              |   2 -
 arch/mips/jz4740/prom.c                            |  13 -
 arch/mips/jz4740/reset.c                           |  13 +-
 arch/mips/jz4740/serial.c                          |  33 -
 arch/mips/jz4740/serial.h                          |  23 -
 arch/mips/jz4740/setup.c                           |  33 +-
 arch/mips/jz4740/time.c                            |  19 +-
 arch/mips/kernel/cpu-probe.c                       |   1 +
 arch/mips/kernel/irq_cpu.c                         |   3 +
 drivers/clk/Makefile                               |   2 +
 drivers/clk/jz47xx/Makefile                        |   3 +
 drivers/clk/jz47xx/jz4740-cgu.c                    | 299 +++++++
 drivers/clk/jz47xx/jz4780-cgu.c                    | 746 +++++++++++++++++
 drivers/clk/jz47xx/jz47xx-cgu.c                    | 724 ++++++++++++++++
 drivers/clk/jz47xx/jz47xx-cgu.h                    | 209 +++++
 drivers/tty/serial/8250/8250_jz47xx.c              | 228 +++++
 drivers/tty/serial/8250/Kconfig                    |   8 +
 drivers/tty/serial/8250/Makefile                   |   1 +
 include/dt-bindings/clock/jz4740-cgu.h             |  37 +
 include/dt-bindings/clock/jz4780-cgu.h             |  88 ++
 51 files changed, 3141 insertions(+), 1276 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/ingenic,jz4740-cgu.txt
 create mode 100644 Documentation/devicetree/bindings/clock/ingenic,jz4780-cgu.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ingenic,jz4740-intc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ingenic,jz4780-intc.txt
 create mode 100644 Documentation/devicetree/bindings/serial/ingenic,jz4740-uart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/ingenic,jz4780-uart.txt
 create mode 100644 arch/mips/boot/dts/ci20.dts
 create mode 100644 arch/mips/boot/dts/jz4740.dtsi
 create mode 100644 arch/mips/boot/dts/jz4780.dtsi
 create mode 100644 arch/mips/boot/dts/qi_lb60.dts
 create mode 100644 arch/mips/configs/ci20_defconfig
 create mode 100644 arch/mips/include/asm/mach-generic/serial.h
 create mode 100644 arch/mips/include/asm/mach-jz4740/serial.h
 create mode 100644 arch/mips/include/asm/serial.h
 delete mode 100644 arch/mips/jz4740/clock-debugfs.c
 delete mode 100644 arch/mips/jz4740/clock.c
 delete mode 100644 arch/mips/jz4740/clock.h
 delete mode 100644 arch/mips/jz4740/serial.c
 delete mode 100644 arch/mips/jz4740/serial.h
 create mode 100644 drivers/clk/jz47xx/Makefile
 create mode 100644 drivers/clk/jz47xx/jz4740-cgu.c
 create mode 100644 drivers/clk/jz47xx/jz4780-cgu.c
 create mode 100644 drivers/clk/jz47xx/jz47xx-cgu.c
 create mode 100644 drivers/clk/jz47xx/jz47xx-cgu.h
 create mode 100644 drivers/tty/serial/8250/8250_jz47xx.c
 create mode 100644 include/dt-bindings/clock/jz4740-cgu.h
 create mode 100644 include/dt-bindings/clock/jz4780-cgu.h

-- 
2.2.1
