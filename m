Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Nov 2012 13:50:40 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:35486 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6826558Ab2KKMuj06yeX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Nov 2012 13:50:39 +0100
Received: by mail-bk0-f49.google.com with SMTP id j4so2053444bkw.36
        for <multiple recipients>; Sun, 11 Nov 2012 04:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=iEDRyXzm/D8UNn6XXzqEAfCIztAU7uJUbp600SYcTW8=;
        b=vu8iOHzmHkF/YWXn5MVKuwC7DAqNWTtYxZTqBUic6QGcpdGgu5otrR1t+T3tiGWDqh
         HQbEt87iK2hwQTtNzWRXOdXmRmYmZ+eWSSXMeqVbQrdXBrPvnjTAl8aiqGBSd84uBBdR
         NZ5qfqsRPyHraFoZx5TaV82Kwm9AwmWSwmyDJoDklCeaZeeBPGX2Z/Ni7xDQ9+ME4Ta3
         sQPdba0oQO6uALFtHC5pl3VDY3ILbjr6+qdnriMkHj3xStr7rlaP4g1L/H/B68oStO8L
         4GCfrJLq7w5ExRrf8ER6uU0iiegCTEsDhAjLodQyMa06cPMMKnLL/kf9nyGmJ5boNmK9
         /LkQ==
Received: by 10.204.150.220 with SMTP id z28mr6051387bkv.125.1352638233914;
        Sun, 11 Nov 2012 04:50:33 -0800 (PST)
Received: from shaker64.lan (dslb-088-073-158-247.pools.arcor-ip.net. [88.73.158.247])
        by mx.google.com with ESMTPS id z22sm1436133bkw.2.2012.11.11.04.50.32
        (version=SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 04:50:33 -0800 (PST)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [RFC] MIPS: BCM63XX: add initial Device Tree support
Date:   Sun, 11 Nov 2012 13:50:34 +0100
Message-Id: <1352638249-29298-1-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
X-archive-position: 34931
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

This patch series adds initial Device Tree support to BCM63XX by adding
bindings for interrupts, GPIOs and clocks to Device Tree. Finally it adds
one "real" user, the serial driver, to the device tree boards.

The main intention of this patch series is to make the transition to
device tree as smooth as possible by retaining backward compatibility
with not yet DT enabled drivers. Also to reduce the number of potential
regressions I tried to make the changes as small as possible. The resulting
code has therefore still a lot of room for improvement.

The first patches add support for loading kernel embedded DTBs, and
add generic fallback DTSs for boards not yet having a DTS.

Next the IRQ controllers get registered through device tree.

The next set prepares all bcm63xx drivers using clocks for switching to
the generic clock framework, add bindings for the clocks present, then
replaces the custom implementation with one using the common clock
framework.

Last of the generic controllers the GPIO controller is converted to
Device Tree. This is more of an interim solution, as I plan to replace
the driver with a proper pinctrl driver in the future.

Finally, to have a user for some of this, I added support for
registering the serial console through device tree and added appropriate
board files for all currently supported boards.

These patches have been tested on BCM6348, BCM6358, BCM6368 and BCM6328, but
still need to be tested on BCM6338 and BCM6345.

The next steps after this will be:
 * convert the reminder of the device drivers and PCI(e) and pccard
   controllers to device tree support
 * improve the device tree bindings of currently registered devices
 * replace the GPIO controller driver with a pinctrl implementation

This patch series is based on Ralf's upstream-sfr mips tree. My hope is
that these changes eventually go through Ralf's tree instead of through each
subsystem's tree, to make the switch less slow.

Jonas Gorski (15):
  MIPS: BCM63XX: add support for loading DTB
  MIPS: BCM63XX: add simple Device Tree includes for all SoCs
  MIPS: BCM63XX: add generic fallback device trees
  MIPS: BCM63XX: add Device Tree glue code for IRQ handling
  SPI: spi-bcm63xx: use clk_{prepare_enable,disable_unprepare}
  bcm63xx-rng: use clk_{prepare_enable,disable_unprepare}
  net: ethernet: bcm63xx_enet: use
    clk_{prepare_enable,disable_unprepare}
  serial: bcm63xx_uart: remove unnecessary include
  MIPS: BCM63XX: add Device Tree clock definitions
  MIPS: BCM63XX: switch to common clock and Device Tree
  MIPS: BCM63XX: register GPIO controller through Device Tree
  serial: bcm63xx_uart: allow probing through Device Tree
  MIPS: BCM63XX: add serial blocks to Device Tree includes
  MIPS: BCM63XX: add empty Device Trees for all supported boards
  MIPS: BCM63XX: enable serial through Device Tree

 .../devicetree/bindings/clock/bcm63xx-clock.txt    |   32 ++
 .../devicetree/bindings/gpio/bcm63xx-gpio.txt      |   24 ++
 .../devicetree/bindings/mips/bcm63xx/epic.txt      |   20 ++
 .../devicetree/bindings/mips/bcm63xx/ipic.txt      |   18 +
 .../bindings/tty/serial/bcm63xx-uart.txt           |   17 +
 arch/mips/Kconfig                                  |    4 +-
 arch/mips/bcm63xx/Kconfig                          |    2 +
 arch/mips/bcm63xx/Makefile                         |    8 +-
 arch/mips/bcm63xx/boards/board_bcm963xx.c          |   15 -
 arch/mips/bcm63xx/clk.c                            |  331 --------------------
 arch/mips/bcm63xx/dts/96328avng.dts                |   25 ++
 arch/mips/bcm63xx/dts/96338gw.dts                  |   25 ++
 arch/mips/bcm63xx/dts/96338w.dts                   |   25 ++
 arch/mips/bcm63xx/dts/96345gw2.dts                 |   25 ++
 arch/mips/bcm63xx/dts/96348gw.dts                  |   25 ++
 arch/mips/bcm63xx/dts/96348gw_10.dts               |   25 ++
 arch/mips/bcm63xx/dts/96348gw_11.dts               |   25 ++
 arch/mips/bcm63xx/dts/96348gw_a.dts                |   25 ++
 arch/mips/bcm63xx/dts/96348r.dts                   |   25 ++
 arch/mips/bcm63xx/dts/96358vw.dts                  |   25 ++
 arch/mips/bcm63xx/dts/96358vw2.dts                 |   26 ++
 arch/mips/bcm63xx/dts/Kconfig                      |   67 ++++
 arch/mips/bcm63xx/dts/Makefile                     |   28 ++
 arch/mips/bcm63xx/dts/agpf_s0.dts                  |   22 ++
 arch/mips/bcm63xx/dts/bcm6328.dtsi                 |  158 ++++++++++
 arch/mips/bcm63xx/dts/bcm6338.dtsi                 |  108 +++++++
 arch/mips/bcm63xx/dts/bcm6345.dtsi                 |   94 ++++++
 arch/mips/bcm63xx/dts/bcm6348.dtsi                 |  115 +++++++
 arch/mips/bcm63xx/dts/bcm6358.dtsi                 |  156 +++++++++
 arch/mips/bcm63xx/dts/bcm6368.dtsi                 |  196 ++++++++++++
 arch/mips/bcm63xx/dts/bcm96328_generic.dts         |   21 ++
 arch/mips/bcm63xx/dts/bcm96338_generic.dts         |   21 ++
 arch/mips/bcm63xx/dts/bcm96345_generic.dts         |   21 ++
 arch/mips/bcm63xx/dts/bcm96348_generic.dts         |   21 ++
 arch/mips/bcm63xx/dts/bcm96358_generic.dts         |   21 ++
 arch/mips/bcm63xx/dts/bcm96368_generic.dts         |   21 ++
 arch/mips/bcm63xx/dts/dv201amr.dts                 |   25 ++
 arch/mips/bcm63xx/dts/dwv_s0.dts                   |   25 ++
 arch/mips/bcm63xx/dts/fast2404.dts                 |   25 ++
 arch/mips/bcm63xx/dts/rta1025w_16.dts              |   25 ++
 arch/mips/bcm63xx/gpio.c                           |   35 ++-
 arch/mips/bcm63xx/irq.c                            |   32 ++
 arch/mips/bcm63xx/prom.c                           |    3 -
 arch/mips/bcm63xx/setup.c                          |   85 +++++
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_clk.h   |   11 -
 drivers/char/hw_random/bcm63xx-rng.c               |    6 +-
 drivers/clk/Makefile                               |    1 +
 drivers/clk/clk-bcm63xx.c                          |  241 ++++++++++++++
 drivers/net/ethernet/broadcom/bcm63xx_enet.c       |   12 +-
 drivers/spi/spi-bcm63xx.c                          |    6 +-
 drivers/tty/serial/bcm63xx_uart.c                  |   36 ++-
 51 files changed, 1993 insertions(+), 392 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/bcm63xx-clock.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/bcm63xx-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/mips/bcm63xx/epic.txt
 create mode 100644 Documentation/devicetree/bindings/mips/bcm63xx/ipic.txt
 create mode 100644 Documentation/devicetree/bindings/tty/serial/bcm63xx-uart.txt
 delete mode 100644 arch/mips/bcm63xx/clk.c
 create mode 100644 arch/mips/bcm63xx/dts/96328avng.dts
 create mode 100644 arch/mips/bcm63xx/dts/96338gw.dts
 create mode 100644 arch/mips/bcm63xx/dts/96338w.dts
 create mode 100644 arch/mips/bcm63xx/dts/96345gw2.dts
 create mode 100644 arch/mips/bcm63xx/dts/96348gw.dts
 create mode 100644 arch/mips/bcm63xx/dts/96348gw_10.dts
 create mode 100644 arch/mips/bcm63xx/dts/96348gw_11.dts
 create mode 100644 arch/mips/bcm63xx/dts/96348gw_a.dts
 create mode 100644 arch/mips/bcm63xx/dts/96348r.dts
 create mode 100644 arch/mips/bcm63xx/dts/96358vw.dts
 create mode 100644 arch/mips/bcm63xx/dts/96358vw2.dts
 create mode 100644 arch/mips/bcm63xx/dts/Kconfig
 create mode 100644 arch/mips/bcm63xx/dts/Makefile
 create mode 100644 arch/mips/bcm63xx/dts/agpf_s0.dts
 create mode 100644 arch/mips/bcm63xx/dts/bcm6328.dtsi
 create mode 100644 arch/mips/bcm63xx/dts/bcm6338.dtsi
 create mode 100644 arch/mips/bcm63xx/dts/bcm6345.dtsi
 create mode 100644 arch/mips/bcm63xx/dts/bcm6348.dtsi
 create mode 100644 arch/mips/bcm63xx/dts/bcm6358.dtsi
 create mode 100644 arch/mips/bcm63xx/dts/bcm6368.dtsi
 create mode 100644 arch/mips/bcm63xx/dts/bcm96328_generic.dts
 create mode 100644 arch/mips/bcm63xx/dts/bcm96338_generic.dts
 create mode 100644 arch/mips/bcm63xx/dts/bcm96345_generic.dts
 create mode 100644 arch/mips/bcm63xx/dts/bcm96348_generic.dts
 create mode 100644 arch/mips/bcm63xx/dts/bcm96358_generic.dts
 create mode 100644 arch/mips/bcm63xx/dts/bcm96368_generic.dts
 create mode 100644 arch/mips/bcm63xx/dts/dv201amr.dts
 create mode 100644 arch/mips/bcm63xx/dts/dwv_s0.dts
 create mode 100644 arch/mips/bcm63xx/dts/fast2404.dts
 create mode 100644 arch/mips/bcm63xx/dts/rta1025w_16.dts
 delete mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_clk.h
 create mode 100644 drivers/clk/clk-bcm63xx.c

-- 
1.7.2.5
