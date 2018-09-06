Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Sep 2018 00:39:04 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:35391 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994648AbeIFWjAa8DsL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 7 Sep 2018 00:39:00 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 81F1D207B4; Fri,  7 Sep 2018 00:38:55 +0200 (CEST)
Received: from localhost.localdomain (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id D353420789;
        Fri,  7 Sep 2018 00:38:54 +0200 (CEST)
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Ryan Mallon <rmallon@gmail.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        Alexander Clouter <alex@digriz.org.uk>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Subject: [PATCH 00/19] mtd: rawnand: API cleanup (2nd batch)
Date:   Fri,  7 Sep 2018 00:38:32 +0200
Message-Id: <20180906223851.6964-1-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.14.1
Return-Path: <boris.brezillon@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66101
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: boris.brezillon@bootlin.com
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

Hello,

This is the 2nd batch of API cleanup patches. This time we move
deprecated hooks/fields to the nand_legacy struct, and then move some
of the code found in nand_base.c into separate source/header files.

With this new organization, new comers should more easily identify the
bits they can use in their NAND controller drivers and those that are
only meant for core code. It also shrink a bit nand_base.c which was
over 6000 lines of code.

Note that existing coding style issues (reported by checkpatch) in arch
or driver code are intentionally not fixed to keep the series focused
on the API/core cleanup.

Regards,

Boris

Boris Brezillon (19):
  mtd: rawnand: Leave chip->IO_ADDR_{R,W} to NULL when unused
  mtd: rawnand: Create a legacy struct and move ->IO_ADDR_{R,W} there
  mtd: rawnand: Deprecate ->{read,write}_{byte,buf}() hooks
  mtd: rawnand: Deprecate ->cmd_ctrl() and ->cmdfunc()
  mtd: rawnand: Deprecate ->dev_ready() and ->waitfunc()
  mtd: rawnand: Deprecate ->block_{bad,markbad}() hooks
  mtd: rawnand: Deprecate ->erase()
  mtd: rawnand: Deprecate ->{set,get}_features() hooks
  mtd: rawnand: Deprecate ->chip_delay
  mtd: rawnand: Move function prototypes after struct declarations
  mtd: rawnand: Get rid of nand_flash_dev forward declation
  mtd: rawnand: Get rid of the duplicate nand_chip forward declaration
  mtd: rawnand: Get rid of a few unused definitions
  mtd: rawnand: Move platform_nand_xxx definitions out of rawnand.h
  mtd: rawnand: Inline onfi_get_async_timing_mode()
  mtd: rawnand: Keep all internal stuff private
  mtd: rawnand: Move legacy code to nand_legacy.c
  mtd: rawnand: Move ONFI code to nand_onfi.c
  mtd: rawnand: Move JEDEC code to nand_jedec.c

 Documentation/driver-api/mtdnand.rst             |   30 +-
 arch/arm/mach-ep93xx/snappercl15.c               |    8 +-
 arch/arm/mach-ep93xx/ts72xx.c                    |    9 +-
 arch/arm/mach-imx/mach-qong.c                    |    6 +-
 arch/arm/mach-ixp4xx/ixdp425-setup.c             |    2 +-
 arch/arm/mach-omap1/board-fsample.c              |    3 +-
 arch/arm/mach-omap1/board-h2.c                   |    3 +-
 arch/arm/mach-omap1/board-h3.c                   |    2 +-
 arch/arm/mach-omap1/board-nand.c                 |    2 +-
 arch/arm/mach-omap1/board-perseus2.c             |    3 +-
 arch/arm/mach-orion5x/ts78xx-setup.c             |    9 +-
 arch/arm/mach-pxa/balloon3.c                     |    5 +-
 arch/arm/mach-pxa/em-x270.c                      |    9 +-
 arch/arm/mach-pxa/palmtx.c                       |    5 +-
 arch/mips/alchemy/devboards/db1200.c             |    9 +-
 arch/mips/alchemy/devboards/db1300.c             |    9 +-
 arch/mips/alchemy/devboards/db1550.c             |    9 +-
 arch/mips/netlogic/xlr/platform-flash.c          |    3 +-
 arch/mips/pnx833x/common/platform.c              |    5 +-
 arch/mips/rb532/devices.c                        |    5 +-
 arch/sh/boards/mach-migor/setup.c                |    8 +-
 drivers/mtd/nand/raw/Makefile                    |    4 +-
 drivers/mtd/nand/raw/ams-delta.c                 |   22 +-
 drivers/mtd/nand/raw/atmel/nand-controller.c     |   22 +-
 drivers/mtd/nand/raw/au1550nd.c                  |   43 +-
 drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c |   22 +-
 drivers/mtd/nand/raw/brcmnand/brcmnand.c         |   15 +-
 drivers/mtd/nand/raw/cafe_nand.c                 |   22 +-
 drivers/mtd/nand/raw/cmx270_nand.c               |   28 +-
 drivers/mtd/nand/raw/cs553x_nand.c               |   42 +-
 drivers/mtd/nand/raw/davinci_nand.c              |   34 +-
 drivers/mtd/nand/raw/denali.c                    |   23 +-
 drivers/mtd/nand/raw/diskonchip.c                |   50 +-
 drivers/mtd/nand/raw/fsl_elbc_nand.c             |   18 +-
 drivers/mtd/nand/raw/fsl_ifc_nand.c              |   24 +-
 drivers/mtd/nand/raw/fsl_upm.c                   |   30 +-
 drivers/mtd/nand/raw/fsmc_nand.c                 |    1 -
 drivers/mtd/nand/raw/gpio.c                      |   16 +-
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c       |   22 +-
 drivers/mtd/nand/raw/hisi504_nand.c              |   18 +-
 drivers/mtd/nand/raw/internals.h                 |  114 ++
 drivers/mtd/nand/raw/jz4740_nand.c               |   14 +-
 drivers/mtd/nand/raw/jz4780_nand.c               |   10 +-
 drivers/mtd/nand/raw/lpc32xx_mlc.c               |   12 +-
 drivers/mtd/nand/raw/lpc32xx_slc.c               |   26 +-
 drivers/mtd/nand/raw/mpc5121_nfc.c               |   14 +-
 drivers/mtd/nand/raw/mtk_nand.c                  |   12 +-
 drivers/mtd/nand/raw/mxc_nand.c                  |   20 +-
 drivers/mtd/nand/raw/nand_amd.c                  |    2 +-
 drivers/mtd/nand/raw/nand_base.c                 | 1260 +++-------------------
 drivers/mtd/nand/raw/nand_bbt.c                  |    5 +-
 drivers/mtd/nand/raw/nand_hynix.c                |    9 +-
 drivers/mtd/nand/raw/nand_ids.c                  |    4 +-
 drivers/mtd/nand/raw/nand_jedec.c                |  113 ++
 drivers/mtd/nand/raw/nand_legacy.c               |  642 +++++++++++
 drivers/mtd/nand/raw/nand_macronix.c             |    2 +-
 drivers/mtd/nand/raw/nand_micron.c               |    3 +-
 drivers/mtd/nand/raw/nand_onfi.c                 |  305 ++++++
 drivers/mtd/nand/raw/nand_samsung.c              |    2 +-
 drivers/mtd/nand/raw/nand_timings.c              |   18 +-
 drivers/mtd/nand/raw/nand_toshiba.c              |    2 +-
 drivers/mtd/nand/raw/nandsim.c                   |   14 +-
 drivers/mtd/nand/raw/ndfc.c                      |   14 +-
 drivers/mtd/nand/raw/nuc900_nand.c               |   22 +-
 drivers/mtd/nand/raw/omap2.c                     |   62 +-
 drivers/mtd/nand/raw/orion_nand.c                |   12 +-
 drivers/mtd/nand/raw/oxnas_nand.c                |   10 +-
 drivers/mtd/nand/raw/pasemi_nand.c               |   32 +-
 drivers/mtd/nand/raw/plat_nand.c                 |   17 +-
 drivers/mtd/nand/raw/qcom_nandc.c                |   39 +-
 drivers/mtd/nand/raw/r852.c                      |   14 +-
 drivers/mtd/nand/raw/s3c2410.c                   |   34 +-
 drivers/mtd/nand/raw/sh_flctl.c                  |   18 +-
 drivers/mtd/nand/raw/sharpsl.c                   |   12 +-
 drivers/mtd/nand/raw/sm_common.c                 |    2 +-
 drivers/mtd/nand/raw/socrates_nand.c             |   16 +-
 drivers/mtd/nand/raw/sunxi_nand.c                |   14 +-
 drivers/mtd/nand/raw/tango_nand.c                |   12 +-
 drivers/mtd/nand/raw/tmio_nand.c                 |   20 +-
 drivers/mtd/nand/raw/txx9ndfmc.c                 |   12 +-
 drivers/mtd/nand/raw/xway_nand.c                 |   12 +-
 drivers/staging/mt29f_spinand/mt29f_spinand.c    |   16 +-
 include/linux/mtd/jedec.h                        |   91 ++
 include/linux/mtd/onfi.h                         |  178 +++
 include/linux/mtd/platnand.h                     |   74 ++
 include/linux/mtd/rawnand.h                      |  555 ++--------
 86 files changed, 2300 insertions(+), 2191 deletions(-)
 create mode 100644 drivers/mtd/nand/raw/internals.h
 create mode 100644 drivers/mtd/nand/raw/nand_jedec.c
 create mode 100644 drivers/mtd/nand/raw/nand_legacy.c
 create mode 100644 drivers/mtd/nand/raw/nand_onfi.c
 create mode 100644 include/linux/mtd/jedec.h
 create mode 100644 include/linux/mtd/onfi.h
 create mode 100644 include/linux/mtd/platnand.h

-- 
2.14.1
