Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Jul 2017 09:41:28 +0200 (CEST)
Received: from mail-it0-x22a.google.com ([IPv6:2607:f8b0:4001:c0b::22a]:33424
        "EHLO mail-it0-x22a.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990505AbdGFHlUlaPkx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Jul 2017 09:41:20 +0200
Received: by mail-it0-x22a.google.com with SMTP id 188so18194718itx.0
        for <linux-mips@linux-mips.org>; Thu, 06 Jul 2017 00:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=fQ2tMerN4GIGNFIBVoPdLOGhAuJ6Miw2HsIGtuyQplI=;
        b=UFZBUeaDu/epREDD1H7SvtGYoZNPTifSgkpz1StFunkFgyDF8CYZUTV2auTQOmHNtc
         HMIxHOwo6n1avloWGdTSGBgVNv7cxkLfhCoEuO9Z9zpqOIbJnaduuGVc6kAjC3vos6+a
         LYOeh9v66wNKcBWfsXsBy2TiGA0Tu6GirZasA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=fQ2tMerN4GIGNFIBVoPdLOGhAuJ6Miw2HsIGtuyQplI=;
        b=QB25TE7R5ovP4LSWnEngLQNLVcrXtew2AnHf6do/ExK8+8TIo8te3nSB/ECJ43f07j
         Xbv3a4T6qbDbKk9LrHMQh8Du+4QULDgaZKYtksXBcGesGQGA5jDKWg9HqHNOL0issiBn
         dl0LwjyUiPvixfkki8IG/4r4tDFE2jrEbf9TIk9kaOMvtqeKpo4qNfY6uVuhpjL3L+iu
         5UnhGwe4eL7XIOFxkM9dqb7rlyp+X/pUFA9lwMnpYQSgNtJKPfXeL+lO8Yf2cns5KrQt
         ZC0luJJYIGsjTIkSdIlhzEXR/nAR3Eue/DzCwuCE3siRmMtsM6zqX/zOIVKwdG3f7e3R
         K85w==
X-Gm-Message-State: AIVw111hkAQi8FVVAyGZrsPblLUQTqiQvTFzg9KY9m5VrLA3KJ4CRnNL
        UfAJ79oCsvSb3NZ2aOYs+HETCV84ijdI
X-Received: by 10.36.10.16 with SMTP id 16mr21643627itw.7.1499326874143; Thu,
 06 Jul 2017 00:41:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.142.212 with HTTP; Thu, 6 Jul 2017 00:41:13 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 Jul 2017 09:41:13 +0200
Message-ID: <CACRpkdbEdLKPdjoj=7yS+OxgQ5nrc+gQR-ozpteRPgH3m1ociA@mail.gmail.com>
Subject: [GIT PULL] bulk pin control changes for v4.13
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59026
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
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

Hi Linus

Here is the big bulk of pin control changes for v4.13.

The description of the details are on the signed tag as usual. Here is
some administrativa:

There are a few commits to MMC, PWM, fbdev and MTD for the jz4740
cleanup. These are ACKed by the subsystem maintainers. This change
set also touches the jz4740 MIPS machine, and the patch submitter is
maintaining that machine in arch/mips.

I merged in v4.12-rc7 quite late. This was because we were reverting a
patch in fixes, that then gets reimplemented by a new patch touching the
same documentation file. Sorting out that conflict would just be a massive
mess, so I merged in -rc7 and applied the new stuff on top.

Then you will still get two conflicts in drivers/pinctrl/pinctrl-rockchip.c
this is because there were last minute fixes after v4.12-rc7 for this
driver. The conflicts are simply because of proximity in the raw text. It
looks like this:

<<<<<<< HEAD
=======
 * @irq_lock: bus lock for irq chip
 * @new_irqs: newly configured irqs which must be muxed as GPIOs in
 *    irq_bus_sync_unlock()
 * @route_mask: bits describing the routing pins of per bank
>>>>>>> d2ac9fe67277b411da9299a7cfdc2ae07d076050

The irq_lock and new_irqs were deleted and should go away, and
route_mask was added so it should be kept.

The same in the actual struct.

That said: please pull it in, resolve that little snag and we should be clear
to go! It was tested with the above resolution in linux-next.

Yours,
Linus Walleij


The following changes since commit c0bc126f97fb929b3ae02c1c62322645d70eb408:

  Linux 4.12-rc7 (2017-06-25 18:30:05 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v4.13-1

for you to fetch changes up to 3fa53ec2ed885b0aec3f0472e3b4a8a6f1cd748c:

  pinctrl: samsung: Remove bogus irq_[un]mask from resource management
(2017-06-30 15:51:42 +0200)

----------------------------------------------------------------
This is the big bulk of pin control changes for the v4.13 series:

Core:

- The documentation is moved over to RST.
- We now have agreed bindings for enabling input and output
  buffers without actually enabling input and/or output on a
  pin. We are chiseling out some details of pin control
  electronics.

New drivers:

- ZTE ZX
- Renesas RZA1
- MIPS Ingenic JZ47xx: also switch over existing drivers in the
  tree to use this pin controller and consolidate earlier
  spread out code.
- Microschip MCP23S08: this driver is migrated from the GPIO
  subsystem and totally rewritten to use proper pin control.
  All users are switched over.

New subdrivers:

- Renesas R8A7743 and R8A7745.
- Allwinner Sunxi A83T R_PIO.
- Marvell MVEBU Armada CP110 and AP806.
- Intel Cannon Lake PCH.
- Qualcomm IPQ8074.

Notable improvements:

- IRQ support on the Marvell MVEBU Armada 37xx.
- Meson driver supports HDMI CEC, AO, I2S, SPDIF and PWM.
- Rockchip driver now supports iomux-route switching for
  RK3228, RK3328 and RK3399.
- Rockchip A10 and A20 are merged into a single driver.
- STM32 has improved GPIO support.
- Samsung Exynos drivers are split per ARMv7 and ARMv8.
- Marvell MVEBU is converted to use regmap for register
  access.

Maintenance:

- Several Renesas SH-PFC refactorings and updates.
- Serious code size cut for Mediatek MT7623.
- Misc janitorial and MAINTAINERS fixes.

----------------------------------------------------------------
Alexandre TORGUE (3):
      pinctrl: stm32: set pin to gpio input when used as interrupt
      pinctrl: stm32: Implement .get_direction gpio_chip callback
      pinctrl: stm32: remove useless check

Arnd Bergmann (1):
      pinctrl: mcp23s08: improve I2C Kconfig dependency

Arvind Yadav (1):
      pinctrl: freescale: imx7d: make of_device_ids const.

Bjorn Andersson (1):
      MAINTAINERS: Add Qualcomm pinctrl drivers section

Chen-Yu Tsai (3):
      pinctrl: sunxi: Fix SPDIF function name for A83T
      dt-bindings: pinctrl: sunxi: Add compatible string for A83T R_PIO
      pinctrl: sunxi: Add support for A83T R_PIO

Christophe JAILLET (1):
      pinctrl: imx: Check for memory allocation failure

Colin Ian King (1):
      pinctrl: rza1: make structures rza1_gpiochip_template and
rza1_pinmux_ops static

Dan Carpenter (1):
      pinctrl: ingenic: checking for NULL instead of IS_ERR()

David Wu (4):
      pinctrl: rockchip: Add iomux-route switching support
      pinctrl: rockchip: Add iomux-route switching support for rk3228
      pinctrl: rockchip: Add iomux-route switching support for rk3328
      pinctrl: rockchip: Add iomux-route switching support for rk3399

Dong Aisheng (4):
      pinctrl: imx: fix debug message for SHARE_MUX_CONF_REG case
      pinctrl: imx: add generic pin config core support
      pinctrl: imx: add soc specific mux_mode mask and shift property
      pinctrl: DT: extend the pinmux property to support integers array

Geert Uytterhoeven (3):
      pinctrl: sh-pfc: r8a7796: Add group for AVB MDIO and MII pins
      pinctrl: sh-pfc: r8a7795: Add EtherAVB pins, groups and function
      pinctrl: rza1: Remove unneeded wrong check for wrong variable

Gregory CLEMENT (4):
      pinctrl: armada-37xx: Add irqchip support
      MAINTAINERS: extend mvebu SoC entry with pinctrl drivers
      pinctrl: mvebu: remove the offset property for regmap
      pinctrl: armada-37xx: Fix number of pin in sdio_sb

Hanna Hawa (2):
      pinctrl: mvebu: add driver for Armada AP806 pinctrl
      pinctrl: mvebu: add driver for Armada CP110 pinctrl

Heiner Kallweit (1):
      pinctrl: meson-gxbb: remove non-existing pin GPIOX_22

Icenowy Zheng (4):
      pinctrl: sunxi: Add SoC ID definitions for A10, A20 and R40 SoCs
      pinctrl: sunxi: add A20 support to A10 driver
      pinctrl: sunxi: drop dedicated A20 driver
      dt-bindings: add compatible string for Allwinner R40 pinctrl

Jacopo Mondi (4):
      pinctrl: Renesas RZ/A1 pin and gpio controller
      dt-bindings: pinctrl: Add RZ/A1 bindings doc
      arm: dts: dt-bindings: Add Renesas RZ/A1 pinctrl header
      pinctrl: generic: Add output-enable property

Jerome Brunet (2):
      pinctrl: meson: add interrupts to pinctrl data
      pinctrl: meson-gxl: add tsin_a pins

Ken Ma (1):
      pinctrl: armada-37xx: Fix uart2 group selection register mask

Krzysztof Kozlowski (5):
      pinctrl: samsung: Add include guard to local header
      pinctrl: samsung: Split Exynos drivers per ARMv7 and ARMv8
      pinctrl: samsung: Constify wakeup driver specific data
      pinctrl: samsung: Handle memory allocation failure during wakeup
banks init
      pinctrl: samsung: Explicitly cast pointer returned by of_iomap() to iomem

Kuninori Morimoto (6):
      pinctrl: sh-pfc: r8a7796: Rename SSI_{WS,SCK}0129 to SSI_{WS,SCK}01239
      pinctrl: sh-pfc: r8a7796: Rename SSI_{WS,SCK}34 to SSI_{WS,SCK}349
      pinctrl: sh-pfc: r8a7796: Add Audio SSI pin support
      pinctrl: sh-pfc: r8a7796: Add Audio clock pin support
      pinctrl: sh-pfc: r8a7795: Rename SSI_{WS,SCK}34 to SSI_{WS,SCK}349
      pinctrl: sh-pfc: r8a7795-es1: Rename SSI_{WS,SCK}34 to SSI_{WS,SCK}349

Laurent Pinchart (2):
      pinctrl: sh-pfc: r8a7795: Add DU parallel RGB output support
      pinctrl: sh-pfc: r8a7795: Add PWM support

Linus Walleij (7):
      Merge branch 'ingenic' into devel
      Merge branch 'mcp23s08' into devel
      gpio/pinctrl: ingenic: depend on OF
      Merge tag 'sh-pfc-for-v4.13-tag1' of
git://git.kernel.org/.../geert/renesas-drivers into devel
      Merge tag 'samsung-pinctrl-4.13' of
git://git.kernel.org/.../pinctrl/samsung into devel
      Merge tag 'v4.12-rc7' into devel
      Merge tag 'sh-pfc-for-v4.13-tag2' of
git://git.kernel.org/.../geert/renesas-drivers into devel

Markus Elfring (7):
      pinctrl: Use seq_putc() in three functions
      pinctrl: Replace two seq_printf() calls by seq_puts() in
pinconf_show_map()
      pinctrl: Adjust five checks for null pointers
      pinctrl: Combine substrings for a message in pin_config_group_get()
      pinctrl: Add spaces for better code readability
      pinctrl: Use seq_putc() in pinctrl_maps_show()
      pinctrl: Adjust nine checks for null pointers

Martin Blumenstingl (4):
      pinctrl: meson: meson8: add the PWM pins
      pinctrl: meson: meson8: add support for the I2S and SPDIF pins
      pinctrl: meson: meson8: add support for the AO remote output pin
      pinctrl: meson: meson8: add the AO HDMI CEC pin

Martin Schiller (1):
      pinctrl: xway: fix copy/paste error in xrx200_grps

Masahiro Yamada (5):
      pinctrl: samsung: Remove unneeded (void *) casts in of_match_table
      pinctrl: rockchip: remove unneeded (void *) casts in of_match_table
      pinctrl: single: use of_device_get_match_data() to get soc data
      pinctrl: uniphier: fix WARN_ON() of pingroups dump on LD11
      pinctrl: uniphier: fix WARN_ON() of pingroups dump on LD20

Mauro Carvalho Chehab (2):
      pinctrl: pinctrl.txt: standardize document format
      pinctrl.txt: move it to the driver-api book

Mika Westerberg (3):
      pinctrl: intel: Add support for variable size pad groups
      pinctrl: intel: Make it possible to specify mode per pin in a group
      pinctrl: intel: Add Intel Cannon Lake PCH pin controller support

Neil Armstrong (9):
      pinctrl: meson-gxl: Add SPI pins for the SPICC controller
      pinctrl: meson-gxbb: Add SPI pins for SPICC controller
      pinctrl: meson-gxl: Add missing GPIODV_18 pin entry
      pinctrl: meson-gxbb: Add missing GPIODV_18 pin entry
      pinctrl: meson-gxl: Fix typo in AO I2S pins
      pinctrl: meson-gxl: Fix typo in AO SPDIF pins
      pinctrl: meson-gxbb: Add CEC pins
      pinctrl: meson-gxl: Add CEC pins
      pinctrl: meson-gxl: Add Ethernet PHY LEDS pins

Nikita Yushchenko (1):
      pinctrl: When claiming hog, skip maps not served by same device

Paul Cercueil (14):
      dt/bindings: Document pinctrl-ingenic
      dt/bindings: Document gpio-ingenic
      pinctrl: add a pinctrl driver for the Ingenic jz47xx SoCs
      gpio: Add gpio-ingenic driver
      mmc: jz4740: Let the pinctrl driver configure the pins
      pwm: jz4740: Let the pinctrl driver configure the pins
      fbdev: jz4740-fb: Let the pinctrl driver configure the pins
      mtd: nand: jz4740: Let the pinctrl driver configure the pins
      MIPS: ingenic: Enable pinctrl for all ingenic SoCs
      MIPS: jz4740: DTS: Add nodes for ingenic pinctrl and gpio drivers
      MIPS: jz4780: DTS: Add nodes for ingenic pinctrl and gpio drivers
      MIPS: JZ4740: Qi LB60: Add pinctrl configuration for several drivers
      MIPS: JZ4780: CI20: Add pinctrl configuration for several drivers
      MIPS: jz4740: Remove custom GPIO code

Paul Gortmaker (3):
      pinctrl: samsung: Clean up modular vs. non-modular distinctions
      pinctrl: tegra: clean up modular vs. non-modular distinctions
      pinctrl: bcm: clean up modular vs. non-modular distinctions

Russell King (1):
      pinctrl: avoid PLAT_ORION dependency

Scott Branden (1):
      pinctrl: bcm: cleanup Broadcom license headers

Sean Wang (1):
      pinctrl: mediatek: reuse pinctrl driver for mt7623

Sebastian Reichel (14):
      gpio: mcp23s08: move to pinctrl
      pinctrl: mcp23s08: add pinconf support
      pinctrl: mcp23s08: drop pullup config from pdata
      pinctrl: mcp23s08: switch to regmap caching
      pinctrl: mcp23s08: drop OF_GPIO dependency
      pinctrl: mcp23s08: irq mapping is already done
      pinctrl: mcp23s08: use managed kzalloc for mcp
      pinctrl: mcp23s08: switch to devm_gpiochip_add_data
      pinctrl: mcp23s08: simplify i2c pdata handling
      pinctrl: mcp23s08: simplify spi pdata handling
      pinctrl: mcp23s08: generalize irq property handling
      pinctrl: mcp23s08: simplify spi_present_mask handling
      pinctrl: mcp23s08: drop comment about missing irq support
      pinctrl: mcp23s08: fix comment for mcp23s08_platform_data.base

Sergei Shtylyov (6):
      pinctrl: sh-pfc: r8a7791: Grand I2C rename
      pinctrl: sh-pfc: r8a7791: Add R8A7743 support
      pinctrl: sh-pfc: r8a7794: Rename some I2C signals
      pinctrl: sh-pfc: r8a7794: Remove AVB_AVTP_* groups
      pinctrl: sh-pfc: r8a7794: Remove reserved bits
      pinctrl: sh-pfc: r8a7794: Add R8A7745 support

Shawn Guo (3):
      dt-bindings: add bindings doc for ZTE pinctrl
      pinctrl: add ZTE ZX pinctrl driver support
      pinctrl: zte: fix group_desc initialization

Shyam Sundar S K (1):
      pinctrl/amd: Update contact information for AMD pinctrl/amd

Stefan Wahren (1):
      pinctrl: bcm2835: Avoid warning from __irq_do_set_handler

Takeshi Kihara (1):
      pinctrl: sh-pfc: r8a7796: Add PWM pins, groups and functions

Thomas Gleixner (1):
      pinctrl: samsung: Remove bogus irq_[un]mask from resource management

Tobias Klauser (1):
      pinctrl: sunxi: constify irq_domain_ops

Ulrich Hecht (1):
      pinctrl: sh-pfc: r8a7792: Add SCIF1 and SCIF2 pin groups

Varadarajan Narayanan (1):
      pinctrl: qcom: Add ipq8074 pinctrl driver

 .../devicetree/bindings/gpio/ingenic,gpio.txt      |   46 +
 .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |    2 +
 .../bindings/pinctrl/ingenic,pinctrl.txt           |   41 +
 .../bindings/pinctrl/pinctrl-bindings.txt          |   25 +-
 .../devicetree/bindings/pinctrl/pinctrl-zx.txt     |   85 +
 .../bindings/pinctrl/qcom,ipq8074-pinctrl.txt      |  172 ++
 .../bindings/pinctrl/renesas,pfc-pinctrl.txt       |    2 +
 .../bindings/pinctrl/renesas,rza1-pinctrl.txt      |  221 +++
 Documentation/driver-api/index.rst                 |    1 +
 .../{pinctrl.txt => driver-api/pinctl.rst}         | 1124 ++++++------
 MAINTAINERS                                        |    9 +-
 arch/arm/configs/lpc32xx_defconfig                 |    2 +-
 arch/blackfin/configs/BF609-EZKIT_defconfig        |    2 +-
 arch/blackfin/mach-bf527/boards/tll6527m.c         |    8 +-
 arch/blackfin/mach-bf609/boards/ezkit.c            |    4 +-
 arch/mips/Kconfig                                  |    1 +
 arch/mips/boot/dts/ingenic/ci20.dts                |   60 +
 arch/mips/boot/dts/ingenic/jz4740.dtsi             |   68 +
 arch/mips/boot/dts/ingenic/jz4780.dtsi             |   98 +
 arch/mips/boot/dts/ingenic/qi_lb60.dts             |   13 +
 arch/mips/include/asm/mach-jz4740/gpio.h           |  371 ----
 arch/mips/jz4740/Makefile                          |    2 -
 arch/mips/jz4740/board-qi_lb60.c                   |   48 +-
 arch/mips/jz4740/gpio.c                            |  519 ------
 drivers/gpio/Kconfig                               |   28 +-
 drivers/gpio/Makefile                              |    2 +-
 drivers/gpio/gpio-ingenic.c                        |  394 ++++
 drivers/mmc/host/jz4740_mmc.c                      |   44 +-
 drivers/mtd/nand/jz4740_nand.c                     |   23 +-
 drivers/pinctrl/Kconfig                            |   36 +
 drivers/pinctrl/Makefile                           |    4 +
 drivers/pinctrl/bcm/pinctrl-bcm281xx.c             |   13 +-
 drivers/pinctrl/bcm/pinctrl-bcm2835.c              |   24 +-
 drivers/pinctrl/bcm/pinctrl-cygnus-mux.c           |   12 +-
 drivers/pinctrl/bcm/pinctrl-iproc-gpio.c           |    6 +-
 drivers/pinctrl/bcm/pinctrl-nsp-gpio.c             |    6 +-
 drivers/pinctrl/core.c                             |   30 +-
 drivers/pinctrl/freescale/Kconfig                  |    2 +-
 drivers/pinctrl/freescale/pinctrl-imx.c            |  135 +-
 drivers/pinctrl/freescale/pinctrl-imx.h            |   29 +
 drivers/pinctrl/freescale/pinctrl-imx7d.c          |    6 +-
 drivers/pinctrl/freescale/pinctrl-vf610.c          |    2 +
 drivers/pinctrl/intel/Kconfig                      |    8 +
 drivers/pinctrl/intel/Makefile                     |    1 +
 drivers/pinctrl/intel/pinctrl-cannonlake.c         |  442 +++++
 drivers/pinctrl/intel/pinctrl-intel.c              |  200 +-
 drivers/pinctrl/intel/pinctrl-intel.h              |   65 +-
 drivers/pinctrl/intel/pinctrl-sunrisepoint.c       |    1 +
 drivers/pinctrl/mediatek/Kconfig                   |    9 +-
 drivers/pinctrl/mediatek/Makefile                  |    1 -
 drivers/pinctrl/mediatek/pinctrl-mt2701.c          |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt7623.c          |  379 ----
 drivers/pinctrl/mediatek/pinctrl-mtk-mt7623.h      | 1936 --------------------
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c         |   48 +-
 drivers/pinctrl/meson/pinctrl-meson-gxl.c          |   99 +-
 drivers/pinctrl/meson/pinctrl-meson.h              |   15 +-
 drivers/pinctrl/meson/pinctrl-meson8.c             |  147 +-
 drivers/pinctrl/meson/pinctrl-meson8b.c            |   32 +-
 drivers/pinctrl/mvebu/Kconfig                      |   12 +-
 drivers/pinctrl/mvebu/Makefile                     |    2 +
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c        |  238 ++-
 drivers/pinctrl/mvebu/pinctrl-armada-ap806.c       |  140 ++
 drivers/pinctrl/mvebu/pinctrl-armada-cp110.c       |  687 +++++++
 drivers/pinctrl/mvebu/pinctrl-mvebu.c              |    6 +-
 drivers/pinctrl/mvebu/pinctrl-mvebu.h              |    2 +-
 drivers/pinctrl/pinconf-generic.c                  |    3 +
 drivers/pinctrl/pinconf.c                          |   35 +-
 drivers/pinctrl/pinctrl-amd.c                      |    4 +
 drivers/pinctrl/pinctrl-ingenic.c                  |  852 +++++++++
 .../gpio-mcp23s08.c => pinctrl/pinctrl-mcp23s08.c} |  647 ++++---
 drivers/pinctrl/pinctrl-rockchip.c                 |  343 +++-
 drivers/pinctrl/pinctrl-rza1.c                     | 1308 +++++++++++++
 drivers/pinctrl/pinctrl-single.c                   |    8 +-
 drivers/pinctrl/pinctrl-xway.c                     |    2 +-
 drivers/pinctrl/qcom/Kconfig                       |   10 +
 drivers/pinctrl/qcom/Makefile                      |    1 +
 drivers/pinctrl/qcom/pinctrl-ipq8074.c             | 1076 +++++++++++
 drivers/pinctrl/samsung/Kconfig                    |   10 +
 drivers/pinctrl/samsung/Makefile                   |    2 +
 drivers/pinctrl/samsung/pinctrl-exynos-arm.c       |  815 ++++++++
 drivers/pinctrl/samsung/pinctrl-exynos-arm64.c     |  399 ++++
 drivers/pinctrl/samsung/pinctrl-exynos.c           | 1173 +-----------
 drivers/pinctrl/samsung/pinctrl-exynos.h           |   13 +
 drivers/pinctrl/samsung/pinctrl-exynos5440.c       |   15 +-
 drivers/pinctrl/samsung/pinctrl-s3c24xx.c          |    2 +-
 drivers/pinctrl/samsung/pinctrl-s3c64xx.c          |    2 +-
 drivers/pinctrl/samsung/pinctrl-samsung.c          |   39 +-
 drivers/pinctrl/sh-pfc/Kconfig                     |   10 +
 drivers/pinctrl/sh-pfc/Makefile                    |    2 +
 drivers/pinctrl/sh-pfc/core.c                      |   12 +
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c               | 1341 +++++++-------
 drivers/pinctrl/sh-pfc/pfc-r8a7792.c               |   55 +
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c               | 1256 ++++++-------
 drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c           |   30 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c               |  385 +++-
 drivers/pinctrl/sh-pfc/pfc-r8a7796.c               |  606 +++++-
 drivers/pinctrl/sh-pfc/sh_pfc.h                    |    2 +
 drivers/pinctrl/stm32/pinctrl-stm32.c              |   67 +-
 drivers/pinctrl/stm32/pinctrl-stm32.h              |    5 +-
 drivers/pinctrl/sunxi/Kconfig                      |   10 +-
 drivers/pinctrl/sunxi/Makefile                     |    2 +-
 drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c          |  287 ++-
 drivers/pinctrl/sunxi/pinctrl-sun7i-a20.c          | 1056 -----------
 drivers/pinctrl/sunxi/pinctrl-sun8i-a83t-r.c       |  128 ++
 drivers/pinctrl/sunxi/pinctrl-sunxi.c              |    2 +-
 drivers/pinctrl/sunxi/pinctrl-sunxi.h              |    3 +
 drivers/pinctrl/tegra/pinctrl-tegra.c              |    1 -
 drivers/pinctrl/tegra/pinctrl-tegra114.c           |   11 +-
 drivers/pinctrl/tegra/pinctrl-tegra124.c           |   11 +-
 drivers/pinctrl/tegra/pinctrl-tegra20.c            |   11 +-
 drivers/pinctrl/tegra/pinctrl-tegra210.c           |    9 +-
 drivers/pinctrl/tegra/pinctrl-tegra30.c            |   11 +-
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c   |  364 ++--
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c   |  383 ++--
 drivers/pinctrl/zte/Kconfig                        |   13 +
 drivers/pinctrl/zte/Makefile                       |    2 +
 drivers/pinctrl/zte/pinctrl-zx.c                   |  445 +++++
 drivers/pinctrl/zte/pinctrl-zx.h                   |  105 ++
 drivers/pinctrl/zte/pinctrl-zx296718.c             | 1027 +++++++++++
 drivers/pwm/pwm-jz4740.c                           |   29 -
 drivers/video/fbdev/jz4740_fb.c                    |  104 +-
 include/dt-bindings/pinctrl/r7s72100-pinctrl.h     |   16 +
 include/linux/pinctrl/pinconf-generic.h            |   15 +-
 include/linux/spi/mcp23s08.h                       |   38 +-
 124 files changed, 14175 insertions(+), 8629 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/ingenic,gpio.txt
 create mode 100644
Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-zx.txt
 create mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,ipq8074-pinctrl.txt
 create mode 100644
Documentation/devicetree/bindings/pinctrl/renesas,rza1-pinctrl.txt
 rename Documentation/{pinctrl.txt => driver-api/pinctl.rst} (74%)
 delete mode 100644 arch/mips/jz4740/gpio.c
 create mode 100644 drivers/gpio/gpio-ingenic.c
 create mode 100644 drivers/pinctrl/intel/pinctrl-cannonlake.c
 delete mode 100644 drivers/pinctrl/mediatek/pinctrl-mt7623.c
 delete mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt7623.h
 create mode 100644 drivers/pinctrl/mvebu/pinctrl-armada-ap806.c
 create mode 100644 drivers/pinctrl/mvebu/pinctrl-armada-cp110.c
 create mode 100644 drivers/pinctrl/pinctrl-ingenic.c
 rename drivers/{gpio/gpio-mcp23s08.c => pinctrl/pinctrl-mcp23s08.c} (64%)
 create mode 100644 drivers/pinctrl/pinctrl-rza1.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq8074.c
 create mode 100644 drivers/pinctrl/samsung/pinctrl-exynos-arm.c
 create mode 100644 drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
 delete mode 100644 drivers/pinctrl/sunxi/pinctrl-sun7i-a20.c
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun8i-a83t-r.c
 create mode 100644 drivers/pinctrl/zte/Kconfig
 create mode 100644 drivers/pinctrl/zte/Makefile
 create mode 100644 drivers/pinctrl/zte/pinctrl-zx.c
 create mode 100644 drivers/pinctrl/zte/pinctrl-zx.h
 create mode 100644 drivers/pinctrl/zte/pinctrl-zx296718.c
 create mode 100644 include/dt-bindings/pinctrl/r7s72100-pinctrl.h
