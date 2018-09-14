Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2018 10:16:50 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:58125 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993094AbeINIQqvRC0Y (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Sep 2018 10:16:46 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A7DA5208F5; Fri, 14 Sep 2018 10:16:40 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4FF12206EE;
        Fri, 14 Sep 2018 10:16:30 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        andrew@lunn.ch, f.fainelli@gmail.com
Cc:     allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH net-next v3 00/11] mscc: ocelot: add support for SerDes muxing configuration
Date:   Fri, 14 Sep 2018 10:15:58 +0200
Message-Id: <cover.ff40d591b548a6da31716e6e600f11a303e0e643.1536912834.git-series.quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
Return-Path: <quentin.schulz@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66225
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quentin.schulz@bootlin.com
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

The Ocelot switch has currently an hardcoded SerDes muxing that suits only
a particular use case. Any other board setup will fail to work.

To prepare for upcoming boards' support that do not have the same muxing,
create a PHY driver that will handle all possible cases.

A SerDes can work in SGMII, QSGMII or PCIe and is also muxed to use a
given port depending on the selected mode or board design.

The SerDes configuration is in the middle of an address space (HSIO) that
is used to configure some parts in the MAC controller driver, that is why
we need to use a syscon so that we can write to the same address space from
different drivers safely using regmap.

This breaks backward compatibility but it's fine because there's only one
board at the moment that is using what's modified in this patch series.
This will break git bisect.

Even though this patch series is about SerDes __muxing__ configuration, the
DT node is named serdes for the simple reason that I couldn't find any
mention to SerDes anywhere else from the address space handled by this
driver.

Thanks,
Quentin

v3:
  - add Paul Burton's Acked-By on MIPS patches so that the patch series can
  be merged in the net tree in its entirety,

v2:
  - use a switch case for setting the phy_mode in the SerDes driver as
  suggested by Andrew,
  - stop replacing the value of the error pointer in the SerDes driver,
  - use a dev_dbg for the deferring of the probe in the SerDes driver,
  - use constants in the Device Tree to select the SerDes macro in use with
  a port,
  - adapt the SerDes driver to use those constants,
  - add a header file in include/dt-bindings for the constants,
  - fix space/tab issue,

Quentin Schulz (11):
  MIPS: mscc: ocelot: make HSIO registers address range a syscon
  dt-bindings: net: ocelot: remove hsio from the list of register address spaces
  net: mscc: ocelot: get HSIO regmap from syscon
  net: mscc: ocelot: move the HSIO header to include/soc
  net: mscc: ocelot: simplify register access for PLL5 configuration
  phy: add QSGMII and PCIE modes
  dt-bindings: phy: add DT binding for Microsemi Ocelot SerDes muxing
  MIPS: mscc: ocelot: add SerDes mux DT node
  dt-bindings: add constants for Microsemi Ocelot SerDes driver
  phy: add driver for Microsemi Ocelot SerDes muxing
  net: mscc: ocelot: make use of SerDes PHYs for handling their configuration

 Documentation/devicetree/bindings/mips/mscc.txt             |  16 +-
 Documentation/devicetree/bindings/net/mscc-ocelot.txt       |   9 +-
 Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt |  40 +-
 arch/mips/boot/dts/mscc/ocelot.dtsi                         |  19 +-
 drivers/net/ethernet/mscc/Kconfig                           |   2 +-
 drivers/net/ethernet/mscc/ocelot.c                          |  16 +-
 drivers/net/ethernet/mscc/ocelot.h                          |  79 +-
 drivers/net/ethernet/mscc/ocelot_board.c                    |  61 +-
 drivers/net/ethernet/mscc/ocelot_hsio.h                     | 785 +------
 drivers/net/ethernet/mscc/ocelot_regs.c                     |  93 +-
 drivers/phy/Kconfig                                         |   1 +-
 drivers/phy/Makefile                                        |   1 +-
 drivers/phy/mscc/Kconfig                                    |  11 +-
 drivers/phy/mscc/Makefile                                   |   5 +-
 drivers/phy/mscc/phy-ocelot-serdes.c                        | 288 ++-
 include/dt-bindings/phy/phy-ocelot-serdes.h                 |  19 +-
 include/linux/phy/phy.h                                     |   2 +-
 include/soc/mscc/ocelot_hsio.h                              | 859 +++++++-
 18 files changed, 1341 insertions(+), 965 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt
 delete mode 100644 drivers/net/ethernet/mscc/ocelot_hsio.h
 create mode 100644 drivers/phy/mscc/Kconfig
 create mode 100644 drivers/phy/mscc/Makefile
 create mode 100644 drivers/phy/mscc/phy-ocelot-serdes.c
 create mode 100644 include/dt-bindings/phy/phy-ocelot-serdes.h
 create mode 100644 include/soc/mscc/ocelot_hsio.h

base-commit: ee4fccbee7d397c4d937e20d8c76212ffc23a7e3
-- 
git-series 0.9.1
