Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 May 2015 17:13:22 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:4373 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006775AbbEXPNSefWVC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 24 May 2015 17:13:18 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 769B6968DF71B;
        Sun, 24 May 2015 16:13:11 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Sun, 24 May 2015 16:13:14 +0100
Received: from localhost (192.168.159.140) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Sun, 24 May
 2015 16:13:04 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Mike Turquette <mturquette@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jslaby@suse.cz>,
        Joshua Kinard <kumba@gentoo.org>,
        Thierry Reding <treding@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kumar Gala <galak@codeaurora.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        "Rob Herring" <robh+dt@kernel.org>,
        Antony Pavlov <antonynpavlov@gmail.com>,
        "Felix Fietkau" <nbd@openwrt.org>,
        Apelete Seketeli <apelete@seketeli.net>,
        <linux-clk@vger.kernel.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        Huacai Chen <chenhc@lemote.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        "Pawel Moll" <pawel.moll@arm.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devicetree@vger.kernel.org>, Qais Yousef <qais.yousef@imgtec.com>,
        <linux-serial@vger.kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "Kuninori Morimoto" <kuninori.morimoto.gx@renesas.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hayato Suzuki <hytszk@gmail.com>,
        Alan Cox <alan@linux.intel.com>,
        Fabian Frederick <fabf@skynet.be>,
        Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        <linux-kernel@vger.kernel.org>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Arnaud Ebalard <arno@natisbad.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        "Ricardo Ribalda Delgado" <ricardo.ribalda@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH v5 00/37] JZ4780 & CI20 support
Date:   Sun, 24 May 2015 16:11:10 +0100
Message-ID: <1432480307-23789-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.4.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.140]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47600
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

This series introduces initial support for the Ingenic JZ4780 SoC and
the Imagination Technologies MIPS Creator CI20 board which is built
around it. In the process the existing JZ4740 & qi_lb60 code gains
initial support for using DeviceTree such that much of the existing
platform code under arch/mips/jz4740 can be shared.

The series applies atop v4.1-rc4. Review appreciated, and hopefully
this can make it in for v4.2.

Paul Burton (37):
  devicetree/bindings: add Ingenic Semiconductor vendor prefix
  devicetree/bindings: add Qi Hardware vendor prefix
  MIPS: JZ4740: introduce CONFIG_MACH_INGENIC
  MIPS: ingenic: add newer vendor IDs
  MIPS: JZ4740: require & include DT
  MIPS: irq_cpu: declare irqchip table entry
  MIPS: JZ4740: probe CPU interrupt controller via DT
  MIPS: JZ4740: use generic plat_irq_dispatch
  MIPS: JZ4740: move arch_init_irq out of arch/mips/jz4740/irq.c
  devicetree: document Ingenic SoC interrupt controller binding
  MIPS: JZ4740: probe interrupt controller via DT
  MIPS: JZ4740: parse SoC interrupt controller parent IRQ from DT
  MIPS: JZ4740: register an irq_domain for the interrupt controller
  MIPS: JZ4740: drop intc debugfs code
  MIPS: JZ4740: remove jz_intc_base global
  MIPS: JZ4740: support >32 interrupts
  MIPS: JZ4740: define IRQ numbers based on number of intc IRQs
  MIPS: JZ4740: read intc base address from DT
  MIPS: JZ4740: avoid JZ4740-specific naming
  MIPS: JZ4740: support newer SoC interrupt controllers
  irqchip: move Ingenic SoC intc driver to drivers/irqchip
  MIPS: JZ4740: call jz4740_clock_init earlier
  MIPS: JZ4740: replace use of jz4740_clock_bdata
  devicetree: add Ingenic CGU binding documentation
  clk: ingenic: add driver for Ingenic SoC CGU clocks
  MIPS,clk: migrate JZ4740 to common clock framework
  MIPS,clk: move jz4740_clock_set_wait_mode to jz4740-cgu
  MIPS, clk: move jz4740 UDC auto suspend functions to jz4740-cgu
  MIPS, clk: move jz4740 clock suspend, resume functions to jz4740-cgu
  clk: ingenic: add JZ4780 CGU support
  MIPS: JZ4740: remove clock.h
  MIPS: JZ4740: only detect RAM size if not specified in DT
  devicetree: document Ingenic SoC UART binding
  serial: 8250_ingenic: support for Ingenic SoC UARTs
  MIPS: JZ4740: use Ingenic SoC UART driver
  MIPS: ingenic: initial JZ4780 support
  MIPS: ingenic: initial MIPS Creator CI20 support

 .../devicetree/bindings/clock/ingenic,cgu.txt      |  53 ++
 .../bindings/interrupt-controller/ingenic,intc.txt |  28 +
 .../devicetree/bindings/serial/ingenic,uart.txt    |  22 +
 .../devicetree/bindings/vendor-prefixes.txt        |   2 +
 arch/mips/Kconfig                                  |  11 +-
 arch/mips/boot/dts/Makefile                        |   1 +
 arch/mips/boot/dts/ingenic/Makefile                |  10 +
 arch/mips/boot/dts/ingenic/ci20.dts                |  44 +
 arch/mips/boot/dts/ingenic/jz4740.dtsi             |  68 ++
 arch/mips/boot/dts/ingenic/jz4780.dtsi             | 111 +++
 arch/mips/boot/dts/ingenic/qi_lb60.dts             |  15 +
 arch/mips/configs/ci20_defconfig                   | 162 ++++
 arch/mips/configs/qi_lb60_defconfig                |   3 +-
 arch/mips/include/asm/cpu-type.h                   |   2 +-
 arch/mips/include/asm/cpu.h                        |   6 +-
 arch/mips/include/asm/mach-jz4740/clock.h          |   3 +
 .../asm/mach-jz4740/cpu-feature-overrides.h        |   3 -
 arch/mips/include/asm/mach-jz4740/irq.h            |  14 +-
 arch/mips/include/asm/mach-jz4740/platform.h       |   2 -
 arch/mips/jz4740/Kconfig                           |  17 +-
 arch/mips/jz4740/Makefile                          |   8 +-
 arch/mips/jz4740/Platform                          |   8 +-
 arch/mips/jz4740/board-qi_lb60.c                   |   7 -
 arch/mips/jz4740/clock-debugfs.c                   | 108 ---
 arch/mips/jz4740/clock.c                           | 924 ---------------------
 arch/mips/jz4740/clock.h                           |  76 --
 arch/mips/jz4740/gpio.c                            |   7 +-
 arch/mips/jz4740/irq.c                             | 162 ----
 arch/mips/jz4740/platform.c                        |  38 +-
 arch/mips/jz4740/pm.c                              |   2 -
 arch/mips/jz4740/prom.c                            |  13 -
 arch/mips/jz4740/reset.c                           |  13 +-
 arch/mips/jz4740/serial.c                          |  33 -
 arch/mips/jz4740/serial.h                          |  23 -
 arch/mips/jz4740/setup.c                           |  36 +-
 arch/mips/jz4740/time.c                            |  19 +-
 arch/mips/kernel/cpu-probe.c                       |   4 +-
 arch/mips/kernel/irq_cpu.c                         |   3 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/ingenic/Makefile                       |   3 +
 drivers/clk/ingenic/cgu.c                          | 711 ++++++++++++++++
 drivers/clk/ingenic/cgu.h                          | 223 +++++
 drivers/clk/ingenic/jz4740-cgu.c                   | 303 +++++++
 drivers/clk/ingenic/jz4780-cgu.c                   | 733 ++++++++++++++++
 drivers/irqchip/Kconfig                            |   5 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-ingenic.c                      | 177 ++++
 drivers/tty/serial/8250/8250_ingenic.c             | 266 ++++++
 drivers/tty/serial/8250/Kconfig                    |   9 +
 drivers/tty/serial/8250/Makefile                   |   3 +
 include/dt-bindings/clock/jz4740-cgu.h             |  37 +
 include/dt-bindings/clock/jz4780-cgu.h             |  88 ++
 .../irq.h => include/linux/irqchip/ingenic.h       |   8 +-
 53 files changed, 3205 insertions(+), 1424 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/ingenic,cgu.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.txt
 create mode 100644 Documentation/devicetree/bindings/serial/ingenic,uart.txt
 create mode 100644 arch/mips/boot/dts/ingenic/Makefile
 create mode 100644 arch/mips/boot/dts/ingenic/ci20.dts
 create mode 100644 arch/mips/boot/dts/ingenic/jz4740.dtsi
 create mode 100644 arch/mips/boot/dts/ingenic/jz4780.dtsi
 create mode 100644 arch/mips/boot/dts/ingenic/qi_lb60.dts
 create mode 100644 arch/mips/configs/ci20_defconfig
 delete mode 100644 arch/mips/jz4740/clock-debugfs.c
 delete mode 100644 arch/mips/jz4740/clock.c
 delete mode 100644 arch/mips/jz4740/clock.h
 delete mode 100644 arch/mips/jz4740/irq.c
 delete mode 100644 arch/mips/jz4740/serial.c
 delete mode 100644 arch/mips/jz4740/serial.h
 create mode 100644 drivers/clk/ingenic/Makefile
 create mode 100644 drivers/clk/ingenic/cgu.c
 create mode 100644 drivers/clk/ingenic/cgu.h
 create mode 100644 drivers/clk/ingenic/jz4740-cgu.c
 create mode 100644 drivers/clk/ingenic/jz4780-cgu.c
 create mode 100644 drivers/irqchip/irq-ingenic.c
 create mode 100644 drivers/tty/serial/8250/8250_ingenic.c
 create mode 100644 include/dt-bindings/clock/jz4740-cgu.h
 create mode 100644 include/dt-bindings/clock/jz4780-cgu.h
 rename arch/mips/jz4740/irq.h => include/linux/irqchip/ingenic.h (74%)

-- 
2.4.1
