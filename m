Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Apr 2013 13:54:25 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:41798 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823073Ab3DJLve3jJBD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Apr 2013 13:51:34 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Gabor Juhos <juhosg@openwrt.org>, linux-mips@linux-mips.org,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH 00/18] MIPS: ralink: add several new Ralink SoC
Date:   Wed, 10 Apr 2013 13:47:09 +0200
Message-Id: <1365594447-13068-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36046
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

This series adds support for the Ralink WiSoCs that we do not support so far.

In parallel to this series we are also pushing spi and gpio drivers.

If all goes well, v3.10 will have full SoC support.
(with the exception of Ethernet which still needs a rewrite)

Thanks go to Gabor who has been heavily involved in testing an crunching bugs.

Signed-off-by: John Crispin <blogic@openwrt.org

Gabor Juhos (2):
  MIPS: ralink: add PCI IRQ handling
  MIPS: ralink: add cpu-feature-overrides.h

John Crispin (16):
  MIPS: ralink: fix RT305x clock setup
  MIPS: ralink: add missing comment in irq driver
  MIPS: ralink: add RT5350 sdram register defines
  MIPS: ralink: add RT3352 usb register defines
  MIPS: ralink: add pinmux driver
  MIPS: ralink: extend RT3050 dtsi file
  MIPS: ralink: add RT5350 dtsi file
  MIPS: ralink: make early_printk work on RT2880
  MIPS: ralink: adds support for RT2880 SoC family
  MIPS: ralink: add rt2880 dts files
  MIPS: ralink: adds support for RT3883 SoC family
  MIPS: ralink: add rt3883 dts files
  MIPS: ralink: adds support for MT7620 SoC family
  MIPS: ralink: add MT7620 dts files
  MIPS: ralink: add support for periodic timer irq
  MIPS: ralink: add support for runtime memory detection

 arch/mips/Kconfig                                  |    2 +-
 arch/mips/include/asm/mach-ralink/mt7620.h         |   66 ++++++
 arch/mips/include/asm/mach-ralink/rt288x.h         |   49 ++++
 .../asm/mach-ralink/rt288x/cpu-feature-overrides.h |   56 +++++
 arch/mips/include/asm/mach-ralink/rt305x.h         |   19 ++
 .../asm/mach-ralink/rt305x/cpu-feature-overrides.h |   56 +++++
 arch/mips/include/asm/mach-ralink/rt3883.h         |  247 ++++++++++++++++++++
 .../asm/mach-ralink/rt3883/cpu-feature-overrides.h |   55 +++++
 arch/mips/ralink/Kconfig                           |   23 ++
 arch/mips/ralink/Makefile                          |    5 +-
 arch/mips/ralink/Platform                          |   18 ++
 arch/mips/ralink/common.h                          |   11 +-
 arch/mips/ralink/dts/Makefile                      |    3 +
 arch/mips/ralink/dts/mt7620.dtsi                   |  138 +++++++++++
 arch/mips/ralink/dts/mt7620_eval.dts               |   22 ++
 arch/mips/ralink/dts/rt2880.dtsi                   |  116 +++++++++
 arch/mips/ralink/dts/rt2880_eval.dts               |   52 +++++
 arch/mips/ralink/dts/rt3050.dtsi                   |   96 ++++++--
 arch/mips/ralink/dts/rt3052_eval.dts               |    2 +-
 arch/mips/ralink/dts/rt3883.dtsi                   |  186 +++++++++++++++
 arch/mips/ralink/dts/rt3883_eval.dts               |   52 +++++
 arch/mips/ralink/dts/rt5350.dtsi                   |  181 ++++++++++++++
 arch/mips/ralink/early_printk.c                    |    4 +
 arch/mips/ralink/irq.c                             |    5 +
 arch/mips/ralink/memory.c                          |  119 ++++++++++
 arch/mips/ralink/mt7620.c                          |  209 +++++++++++++++++
 arch/mips/ralink/of.c                              |    5 +
 arch/mips/ralink/pinmux.c                          |   95 ++++++++
 arch/mips/ralink/rt288x.c                          |  143 ++++++++++++
 arch/mips/ralink/rt305x.c                          |   20 +-
 arch/mips/ralink/rt3883.c                          |  244 +++++++++++++++++++
 arch/mips/ralink/timer.c                           |  192 +++++++++++++++
 32 files changed, 2468 insertions(+), 23 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-ralink/mt7620.h
 create mode 100644 arch/mips/include/asm/mach-ralink/rt288x.h
 create mode 100644 arch/mips/include/asm/mach-ralink/rt288x/cpu-feature-overrides.h
 create mode 100644 arch/mips/include/asm/mach-ralink/rt305x/cpu-feature-overrides.h
 create mode 100644 arch/mips/include/asm/mach-ralink/rt3883.h
 create mode 100644 arch/mips/include/asm/mach-ralink/rt3883/cpu-feature-overrides.h
 create mode 100644 arch/mips/ralink/dts/mt7620.dtsi
 create mode 100644 arch/mips/ralink/dts/mt7620_eval.dts
 create mode 100644 arch/mips/ralink/dts/rt2880.dtsi
 create mode 100644 arch/mips/ralink/dts/rt2880_eval.dts
 create mode 100644 arch/mips/ralink/dts/rt3883.dtsi
 create mode 100644 arch/mips/ralink/dts/rt3883_eval.dts
 create mode 100644 arch/mips/ralink/dts/rt5350.dtsi
 create mode 100644 arch/mips/ralink/memory.c
 create mode 100644 arch/mips/ralink/mt7620.c
 create mode 100644 arch/mips/ralink/pinmux.c
 create mode 100644 arch/mips/ralink/rt288x.c
 create mode 100644 arch/mips/ralink/rt3883.c
 create mode 100644 arch/mips/ralink/timer.c

-- 
1.7.10.4
