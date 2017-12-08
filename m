Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Dec 2017 16:47:47 +0100 (CET)
Received: from mail.free-electrons.com ([62.4.15.54]:40673 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990474AbdLHPrjnDKsP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Dec 2017 16:47:39 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id E639820973; Fri,  8 Dec 2017 16:47:33 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.free-electrons.com (Postfix) with ESMTPSA id B8E5F2037E;
        Fri,  8 Dec 2017 16:47:23 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@free-electrons.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 00/13] MIPS: add support for the Microsemi MIPS SoCs
Date:   Fri,  8 Dec 2017 16:46:05 +0100
Message-Id: <20171208154618.20105-1-alexandre.belloni@free-electrons.com>
X-Mailer: git-send-email 2.15.1
Return-Path: <alexandre.belloni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61359
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@free-electrons.com
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

Hi,

This patch series adds initial support for the Microsemi MIPS SoCs. It
is currently focusing on the Microsemi Ocelot (VSC7513, VSC7514).

It adds support for the IRQ controller, pinmux and gpio controller and
reset control.

This produces a kernel that can boot to the console.

This is a single series for reference but it can also be taken
separately by each maintainer as each drivers are independant.

Changes in v2:
 - removed the wildcard in MAINAINERS
 - corrected the Cc list
 - added proper documentation for both syscons
 - removed the mscc,cpucontrol property
 - updated the ranges property in the ocelot dtsi

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org


Alexandre Belloni (13):
  dt-bindings: Add vendor prefix for Microsemi Corporation
  dt-bindings: interrupt-controller: Add binding for the Microsemi
    Ocelot interrupt controller
  irqchip: Add a driver for the Microsemi Ocelot controller
  dt-bindings: pinctrl: Add bindings for Microsemi Ocelot
  pinctrl: Add Microsemi Ocelot SoC driver
  dt-bindings: mips: Add bindings for Microsemi SoCs
  dt-bindings: power: reset: Document ocelot-reset binding
  power: reset: Add a driver for the Microsemi Ocelot reset
  MIPS: mscc: Add initial support for Microsemi MIPS SoCs
  MIPS: mscc: add ocelot dtsi
  MIPS: mscc: add ocelot PCB123 device tree
  MIPS: defconfigs: add a defconfig for Microsemi SoCs
  MAINTAINERS: Add entry for Microsemi MIPS SoCs

 .../interrupt-controller/mscc,ocelot-icpu-intr.txt |  22 +
 Documentation/devicetree/bindings/mips/mscc.txt    |  46 ++
 .../bindings/pinctrl/mscc,ocelot-pinctrl.txt       |  39 ++
 .../bindings/power/reset/ocelot-reset.txt          |  17 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 MAINTAINERS                                        |   7 +
 arch/mips/Kbuild.platforms                         |   1 +
 arch/mips/Kconfig                                  |  24 +
 arch/mips/boot/dts/Makefile                        |   1 +
 arch/mips/boot/dts/mscc/Makefile                   |   6 +
 arch/mips/boot/dts/mscc/ocelot.dtsi                | 115 +++++
 arch/mips/boot/dts/mscc/ocelot_pcb123.dts          |  27 ++
 arch/mips/configs/mscc_defconfig                   |  84 ++++
 arch/mips/mscc/Makefile                            |  11 +
 arch/mips/mscc/Platform                            |  12 +
 arch/mips/mscc/setup.c                             | 106 +++++
 drivers/irqchip/Kconfig                            |   5 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-mscc-ocelot.c                  | 109 +++++
 drivers/pinctrl/Kconfig                            |  10 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/pinctrl-ocelot.c                   | 505 +++++++++++++++++++++
 drivers/power/reset/Kconfig                        |   7 +
 drivers/power/reset/Makefile                       |   1 +
 drivers/power/reset/ocelot-reset.c                 |  86 ++++
 25 files changed, 1244 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt
 create mode 100644 Documentation/devicetree/bindings/mips/mscc.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
 create mode 100644 arch/mips/boot/dts/mscc/Makefile
 create mode 100644 arch/mips/boot/dts/mscc/ocelot.dtsi
 create mode 100644 arch/mips/boot/dts/mscc/ocelot_pcb123.dts
 create mode 100644 arch/mips/configs/mscc_defconfig
 create mode 100644 arch/mips/mscc/Makefile
 create mode 100644 arch/mips/mscc/Platform
 create mode 100644 arch/mips/mscc/setup.c
 create mode 100644 drivers/irqchip/irq-mscc-ocelot.c
 create mode 100644 drivers/pinctrl/pinctrl-ocelot.c
 create mode 100644 drivers/power/reset/ocelot-reset.c

-- 
2.15.1
