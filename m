Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 May 2017 15:10:40 +0200 (CEST)
Received: from hauke-m.de ([IPv6:2001:41d0:8:b27b::1]:54276 "EHLO
        mail.hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993418AbdEUNJoPnRtB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 21 May 2017 15:09:44 +0200
Received: from hauke-desktop.lan (p2003008628380100610A1109F04F7762.dip0.t-ipconnect.de [IPv6:2003:86:2838:100:610a:1109:f04f:7762])
        by mail.hauke-m.de (Postfix) with ESMTPSA id B85A2100036;
        Sun, 21 May 2017 15:09:40 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        robh@kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 00/15] MIPS: lantiq: handle RCU register by separate drivers
Date:   Sun, 21 May 2017 15:09:03 +0200
Message-Id: <20170521130918.27446-1-hauke@hauke-m.de>
X-Mailer: git-send-email 2.11.0
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57908
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

The RCU (Reset controller Unit) register block provides many different 
functionalities. Before they were handed by the code in arch/mips/lantiq
/xway/reset.c, now there are separate drivers for the functionality.
This block provides support for reset controller, GPHY firmware 
loading, USB PHY initialization and cross bar configuration. 

These changes are making the old device tree incompatible with the 
current kernel. The upstream Linux kernel supports loading the device 
tree blob from the boot loader since about one year, the latest 
released vendor kernel does not support loading the device tree from a 
bot loader.

I would prefer if this would go through the mips tree.
There are more patches planed which would convert the Lantiq code 
to the common clock framework.

This is based on patches from Martin Blumenstingl and is a preparation 
to convert the Lantiq target to the common clock framework which was 
also started by Martin Blumenstingl.

Changelog: 
v2:
 * remove the rcu_ prefix for device names in device tree
 * add both clocks to the gphy driver documentation
 * use 2 cells for the reset controller, one for the status bit and one 
   for the set bit, they are different for some reset bits.
   reset-status and reset-request attribute were removed then.
 * remove the documentation of the not existing sub nodes of the usb phy
 * remove manual gpio vbus handling in the usb phy driver and use the 
   generic phy regulator now.
 * do not check if the usb phy reset is not null, the reset framework does this.
 * do not print an error message when -EPROBE_DEFER was returned


Hauke Mehrtens (7):
  mtd: lantiq-flash: drop check of boot select
  mtd: spi-falcon: drop check of boot select
  watchdog: lantiq: access boot cause register through regmap
  MIPS: lantiq: remove ltq_reset_cause() and ltq_boot_select()
  MIPS: lantiq: remove old reset controller implementation
  MIPS: lantiq: remove old GPHY loader code
  MIPS: lantiq: remove old USB PHY initialisation

Martin Blumenstingl (8):
  MIPS: lantiq: Use of_platform_populate instead of __dt_register_buses
  MIPS: lantiq: Enable MFD_SYSCON to be able to use it for the RCU MFD
  Documentation: DT: MIPS: lantiq: Add docs for the RCU bindings
  MIPS: lantiq: Convert the xbar driver to a platform_driver
  reset: Add a reset controller driver for the Lantiq XWAY based SoCs
  MIPS: lantiq: Add a GPHY driver which uses the RCU syscon-mfd
  phy: Add an USB PHY driver for the Lantiq SoCs using the RCU module
  MIPS: lantiq: Remove the arch/mips/lantiq/xway/reset.c implementation

 .../devicetree/bindings/mips/lantiq/rcu-gphy.txt   |  38 ++
 .../devicetree/bindings/mips/lantiq/rcu.txt        |  84 +++++
 .../devicetree/bindings/mips/lantiq/xbar.txt       |  24 ++
 .../bindings/phy/phy-lantiq-rcu-usb2.txt           |  41 +++
 .../devicetree/bindings/reset/lantiq,rcu-reset.txt |  30 ++
 MAINTAINERS                                        |   1 +
 arch/mips/include/asm/mach-lantiq/lantiq.h         |   4 -
 arch/mips/lantiq/Kconfig                           |   2 +
 arch/mips/lantiq/falcon/reset.c                    |  22 --
 arch/mips/lantiq/prom.c                            |   3 +-
 arch/mips/lantiq/xway/Makefile                     |   4 +-
 arch/mips/lantiq/xway/reset.c                      | 387 ---------------------
 arch/mips/lantiq/xway/sysctrl.c                    |  69 +---
 arch/mips/lantiq/xway/xrx200_phy_fw.c              | 113 ------
 drivers/mtd/maps/lantiq-flash.c                    |   6 -
 drivers/phy/Kconfig                                |   8 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-lantiq-rcu-usb2.c                  | 275 +++++++++++++++
 drivers/reset/Kconfig                              |   6 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-lantiq-rcu.c                   | 201 +++++++++++
 drivers/soc/Makefile                               |   1 +
 drivers/soc/lantiq/Makefile                        |   2 +
 drivers/soc/lantiq/gphy.c                          | 243 +++++++++++++
 drivers/soc/lantiq/xbar.c                          | 101 ++++++
 drivers/spi/spi-falcon.c                           |   5 -
 drivers/watchdog/lantiq_wdt.c                      |  48 ++-
 include/dt-bindings/mips/lantiq_rcu_gphy.h         |  15 +
 28 files changed, 1135 insertions(+), 600 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mips/lantiq/rcu-gphy.txt
 create mode 100644 Documentation/devicetree/bindings/mips/lantiq/rcu.txt
 create mode 100644 Documentation/devicetree/bindings/mips/lantiq/xbar.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
 create mode 100644 Documentation/devicetree/bindings/reset/lantiq,rcu-reset.txt
 delete mode 100644 arch/mips/lantiq/xway/reset.c
 delete mode 100644 arch/mips/lantiq/xway/xrx200_phy_fw.c
 create mode 100644 drivers/phy/phy-lantiq-rcu-usb2.c
 create mode 100644 drivers/reset/reset-lantiq-rcu.c
 create mode 100644 drivers/soc/lantiq/Makefile
 create mode 100644 drivers/soc/lantiq/gphy.c
 create mode 100644 drivers/soc/lantiq/xbar.c
 create mode 100644 include/dt-bindings/mips/lantiq_rcu_gphy.h

-- 
2.11.0
