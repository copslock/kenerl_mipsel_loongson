Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Apr 2015 13:41:53 +0200 (CEST)
Received: from smtp6-g21.free.fr ([212.27.42.6]:17608 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012172AbbDXLlwAY8lo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 24 Apr 2015 13:41:52 +0200
Received: from localhost.localdomain (unknown [85.177.202.128])
        (Authenticated sender: albeu)
        by smtp6-g21.free.fr (Postfix) with ESMTPA id CDF21822F6;
        Fri, 24 Apr 2015 13:39:16 +0200 (CEST)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alban Bedel <albeu@free.fr>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Gabor Juhos <juhosg@openwrt.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/12] MIPS: ath79: Add OF support and DTS for TL-WR1043ND
Date:   Fri, 24 Apr 2015 13:41:07 +0200
Message-Id: <1429875679-14973-1-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47021
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

This series add OF bindings and code support for the interrupt
controllers, clocks and GPIOs. However it was only tested on a
TL-WR1043ND with an AR9132, others SoCs are untested, and a few are
not supported at all.

Most code changes base on the previous bug fix series:
[PATCH v2 0/5] MIPS: ath79: Various small fix to prepare OF support

The requested patch to move the GPIO driver to drivers/gpio is ready and
will follow once it is clearer if this serie get merged.

ChangeLog:
v2: * Fixed the OF bindings and DTS to use ePAPR standardized names
    * Fixed the typos in the OF bindings
    * Added an ngpios property to the GPIO binding and driver
    * Removed all the soc_is_xxx() calls out of the GPIO driver probe()
    * Updated the DTS patches to the new directory structure and merged both
      in one. Having 3 patches to add Makefile, SoC dtsi and board DTS seemed
      a bit overkill.
    * Moved the patch to use the common clk API to the bug fix serie to keep
      this one cleaner.

v3: * Moved the builtin DTB menu to the patch adding the TL-WR1043ND DTS
    * Made the builtin DTB menu optional
    * Fixed more typos
    * Really fixed the DDR controller binding example to use ePAPR names
    * Fixed the qca9550 compatible string in the PLL bindings and driver
    * Fixed the example in the GPIO controller binding
    * Moved the new vendor entry to the correct place

Alban Bedel (12):
  devicetree: Add bindings for the SoC of the ATH79 family
  MIPS: ath79: Add basic device tree support
  devicetree: Add bindings for the ATH79 DDR controllers
  devicetree: Add bindings for the ATH79 interrupt controllers
  devicetree: Add bindings for the ATH79 MISC interrupt controllers
  MIPS: ath79: Add OF support to the IRQ controllers
  devicetree: Add bindings for the ATH79 PLL controllers
  MIPS: ath79: Add OF support to the clocks
  devicetree: Add bindings for the ATH79 GPIO controllers
  MIPS: ath79: Add OF support to the GPIO driver
  of: Add vendor prefix for TP-Link Technologies Co. Ltd
  MIPS: Add basic support for the TL-WR1043ND version 1

 .../devicetree/bindings/clock/qca,ath79-pll.txt    |  33 ++++++
 .../devicetree/bindings/gpio/gpio-ath79.txt        |  38 +++++++
 .../interrupt-controller/qca,ath79-cpu-intc.txt    |  44 ++++++++
 .../interrupt-controller/qca,ath79-misc-intc.txt   |  30 +++++
 .../memory-controllers/ath79-ddr-controller.txt    |  35 ++++++
 .../devicetree/bindings/mips/ath79-soc.txt         |  21 ++++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/mips/Kconfig                                  |   1 +
 arch/mips/ath79/Kconfig                            |  12 ++
 arch/mips/ath79/clock.c                            |  63 +++++++----
 arch/mips/ath79/dev-common.c                       |  51 +++++++++
 arch/mips/ath79/gpio.c                             |  79 ++++++++++----
 arch/mips/ath79/irq.c                              |  87 ++++++++++++++-
 arch/mips/ath79/machtypes.h                        |   1 +
 arch/mips/ath79/setup.c                            |  27 ++++-
 arch/mips/boot/dts/Makefile                        |   1 +
 arch/mips/boot/dts/qca/Makefile                    |   9 ++
 arch/mips/boot/dts/qca/ar9132.dtsi                 | 121 +++++++++++++++++++++
 arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts   |  83 ++++++++++++++
 include/linux/platform_data/gpio-ath79.h           |  19 ++++
 20 files changed, 713 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qca,ath79-pll.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-ath79.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/qca,ath79-cpu-intc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/qca,ath79-misc-intc.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ath79-ddr-controller.txt
 create mode 100644 Documentation/devicetree/bindings/mips/ath79-soc.txt
 create mode 100644 arch/mips/boot/dts/qca/Makefile
 create mode 100644 arch/mips/boot/dts/qca/ar9132.dtsi
 create mode 100644 arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
 create mode 100644 include/linux/platform_data/gpio-ath79.h

-- 
2.0.0
