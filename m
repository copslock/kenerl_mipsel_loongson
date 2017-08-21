Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Aug 2017 23:04:33 +0200 (CEST)
Received: from mail.free-electrons.com ([62.4.15.54]:52366 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23995050AbdHUVEWz6sC7 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 21 Aug 2017 23:04:22 +0200
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id D40D5209E4; Mon, 21 Aug 2017 23:04:15 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 691C0209D7;
        Mon, 21 Aug 2017 23:04:04 +0200 (CEST)
Date:   Mon, 21 Aug 2017 23:04:04 +0200
From:   Boris Brezillon <boris.brezillon@free-electrons.com>
To:     Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Peter Pan <peterpandong@micron.com>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@free-electrons.com>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Alexander Clouter <alex@digriz.org.uk>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Steven Miao <realmz6@gmail.com>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Wenyou Yang <wenyou.yang@atmel.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Han Xu <han.xu@nxp.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wan ZongShun <mcuos.com@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
        Stefan Agner <stefan@agner.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-cris-kernel@axis.com, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-mediatek@lists.infradead.org,
        linux-oxnas@lists.tuxfamily.org, linuxppc-dev@lists.ozlabs.org,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH] mtd: nand: Rename nand.h into rawnand.h
Message-ID: <20170821230404.0c768f90@bbrezillon>
In-Reply-To: <1501860550-16506-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1501860550-16506-1-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59752
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: boris.brezillon@free-electrons.com
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

Le Fri,  4 Aug 2017 17:29:09 +0200,
Boris Brezillon <boris.brezillon@free-electrons.com> a écrit :

> We are planning to share more code between different NAND based
> devices (SPI NAND, OneNAND and raw NANDs), but before doing that
> we need to move the existing include/linux/mtd/nand.h file into
> include/linux/mtd/rawnand.h so we can later create a nand.h header
> containing all common structure and function prototypes.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Signed-off-by: Peter Pan <peterpandong@micron.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Imre Kaloz <kaloz@openwrt.org>
> Cc: Krzysztof Halasa <khalasa@piap.pl>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Alexander Clouter <alex@digriz.org.uk>
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: Marek Vasut <marek.vasut@gmail.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Simtec Linux Team <linux@simtec.co.uk>
> Cc: Steven Miao <realmz6@gmail.com>
> Cc: Mikael Starvik <starvik@axis.com>
> Cc: Jesper Nilsson <jesper.nilsson@axis.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: Wenyou Yang <wenyou.yang@atmel.com>
> Cc: Josh Wu <rainyfeeling@outlook.com>
> Cc: Kamal Dasu <kdasu.kdev@gmail.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Han Xu <han.xu@nxp.com>
> Cc: Harvey Hunt <harveyhuntnexus@gmail.com>
> Cc: Vladimir Zapolskiy <vz@mleia.com>
> Cc: Sylvain Lemieux <slemieux.tyco@gmail.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Wan ZongShun <mcuos.com@gmail.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Cc: Maxim Levitsky <maximlevitsky@gmail.com>
> Cc: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-omap@vger.kernel.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: adi-buildroot-devel@lists.sourceforge.net
> Cc: linux-cris-kernel@axis.com
> Cc: linux-mips@linux-mips.org
> Cc: linux-sh@vger.kernel.org
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-oxnas@lists.tuxfamily.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: devel@driverdev.osuosl.org

Created the nand/rename-header-file immutable branch which I then
merged in nand/next.

This way, anyone can pull the nand/rename-header-file branch in case a
conflict arise on one of the file modified by this patch.

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.infradead.org/l2-mtd.git nand/rename-header-file

for you to fetch changes up to d4092d76a4a4e57b65910899948a83cc8646c5a5:

  mtd: nand: Rename nand.h into rawnand.h (2017-08-13 10:11:49 +0200)

----------------------------------------------------------------
Boris Brezillon (1):
      mtd: nand: Rename nand.h into rawnand.h

 Documentation/driver-api/mtdnand.rst            | 8 ++++----
 MAINTAINERS                                     | 2 +-
 arch/arm/mach-davinci/board-da850-evm.c         | 2 +-
 arch/arm/mach-davinci/board-dm355-evm.c         | 2 +-
 arch/arm/mach-davinci/board-dm355-leopard.c     | 2 +-
 arch/arm/mach-davinci/board-dm365-evm.c         | 2 +-
 arch/arm/mach-davinci/board-dm644x-evm.c        | 2 +-
 arch/arm/mach-davinci/board-dm646x-evm.c        | 2 +-
 arch/arm/mach-davinci/board-sffsdr.c            | 2 +-
 arch/arm/mach-dove/dove-db-setup.c              | 2 +-
 arch/arm/mach-ep93xx/snappercl15.c              | 2 +-
 arch/arm/mach-ep93xx/ts72xx.c                   | 2 +-
 arch/arm/mach-imx/mach-qong.c                   | 2 +-
 arch/arm/mach-ixp4xx/ixdp425-setup.c            | 2 +-
 arch/arm/mach-mmp/aspenite.c                    | 2 +-
 arch/arm/mach-omap1/board-fsample.c             | 2 +-
 arch/arm/mach-omap1/board-h2.c                  | 2 +-
 arch/arm/mach-omap1/board-h3.c                  | 2 +-
 arch/arm/mach-omap1/board-nand.c                | 2 +-
 arch/arm/mach-omap1/board-perseus2.c            | 2 +-
 arch/arm/mach-orion5x/db88f5281-setup.c         | 2 +-
 arch/arm/mach-orion5x/kurobox_pro-setup.c       | 2 +-
 arch/arm/mach-orion5x/ts209-setup.c             | 2 +-
 arch/arm/mach-orion5x/ts78xx-setup.c            | 2 +-
 arch/arm/mach-pxa/balloon3.c                    | 2 +-
 arch/arm/mach-pxa/em-x270.c                     | 2 +-
 arch/arm/mach-pxa/eseries.c                     | 2 +-
 arch/arm/mach-pxa/palmtx.c                      | 2 +-
 arch/arm/mach-pxa/tosa.c                        | 2 +-
 arch/arm/mach-s3c24xx/common-smdk.c             | 2 +-
 arch/arm/mach-s3c24xx/mach-anubis.c             | 2 +-
 arch/arm/mach-s3c24xx/mach-at2440evb.c          | 2 +-
 arch/arm/mach-s3c24xx/mach-bast.c               | 2 +-
 arch/arm/mach-s3c24xx/mach-gta02.c              | 2 +-
 arch/arm/mach-s3c24xx/mach-jive.c               | 2 +-
 arch/arm/mach-s3c24xx/mach-mini2440.c           | 2 +-
 arch/arm/mach-s3c24xx/mach-osiris.c             | 2 +-
 arch/arm/mach-s3c24xx/mach-qt2410.c             | 2 +-
 arch/arm/mach-s3c24xx/mach-rx3715.c             | 2 +-
 arch/arm/mach-s3c24xx/mach-vstms.c              | 2 +-
 arch/blackfin/mach-bf537/boards/dnp5370.c       | 2 +-
 arch/blackfin/mach-bf537/boards/stamp.c         | 2 +-
 arch/blackfin/mach-bf561/boards/acvilon.c       | 2 +-
 arch/cris/arch-v32/drivers/mach-a3/nandflash.c  | 2 +-
 arch/cris/arch-v32/drivers/mach-fs/nandflash.c  | 2 +-
 arch/mips/alchemy/devboards/db1200.c            | 2 +-
 arch/mips/alchemy/devboards/db1300.c            | 2 +-
 arch/mips/alchemy/devboards/db1550.c            | 2 +-
 arch/mips/include/asm/mach-jz4740/jz4740_nand.h | 2 +-
 arch/mips/netlogic/xlr/platform-flash.c         | 2 +-
 arch/mips/pnx833x/common/platform.c             | 2 +-
 arch/mips/rb532/devices.c                       | 2 +-
 arch/sh/boards/mach-migor/setup.c               | 2 +-
 drivers/mtd/inftlcore.c                         | 2 +-
 drivers/mtd/nand/ams-delta.c                    | 2 +-
 drivers/mtd/nand/atmel/nand-controller.c        | 2 +-
 drivers/mtd/nand/atmel/pmecc.c                  | 2 +-
 drivers/mtd/nand/au1550nd.c                     | 2 +-
 drivers/mtd/nand/bcm47xxnflash/bcm47xxnflash.h  | 2 +-
 drivers/mtd/nand/bf5xx_nand.c                   | 2 +-
 drivers/mtd/nand/brcmnand/brcmnand.c            | 2 +-
 drivers/mtd/nand/cafe_nand.c                    | 2 +-
 drivers/mtd/nand/cmx270_nand.c                  | 2 +-
 drivers/mtd/nand/cs553x_nand.c                  | 2 +-
 drivers/mtd/nand/davinci_nand.c                 | 2 +-
 drivers/mtd/nand/denali.h                       | 2 +-
 drivers/mtd/nand/diskonchip.c                   | 2 +-
 drivers/mtd/nand/docg4.c                        | 2 +-
 drivers/mtd/nand/fsl_elbc_nand.c                | 2 +-
 drivers/mtd/nand/fsl_ifc_nand.c                 | 2 +-
 drivers/mtd/nand/fsl_upm.c                      | 2 +-
 drivers/mtd/nand/fsmc_nand.c                    | 2 +-
 drivers/mtd/nand/gpio.c                         | 2 +-
 drivers/mtd/nand/gpmi-nand/gpmi-nand.h          | 2 +-
 drivers/mtd/nand/hisi504_nand.c                 | 2 +-
 drivers/mtd/nand/jz4740_nand.c                  | 2 +-
 drivers/mtd/nand/jz4780_nand.c                  | 2 +-
 drivers/mtd/nand/lpc32xx_mlc.c                  | 2 +-
 drivers/mtd/nand/lpc32xx_slc.c                  | 2 +-
 drivers/mtd/nand/mpc5121_nfc.c                  | 2 +-
 drivers/mtd/nand/mtk_nand.c                     | 2 +-
 drivers/mtd/nand/mxc_nand.c                     | 2 +-
 drivers/mtd/nand/nand_amd.c                     | 2 +-
 drivers/mtd/nand/nand_base.c                    | 2 +-
 drivers/mtd/nand/nand_bbt.c                     | 2 +-
 drivers/mtd/nand/nand_bch.c                     | 2 +-
 drivers/mtd/nand/nand_ecc.c                     | 2 +-
 drivers/mtd/nand/nand_hynix.c                   | 2 +-
 drivers/mtd/nand/nand_ids.c                     | 2 +-
 drivers/mtd/nand/nand_macronix.c                | 2 +-
 drivers/mtd/nand/nand_micron.c                  | 2 +-
 drivers/mtd/nand/nand_samsung.c                 | 2 +-
 drivers/mtd/nand/nand_timings.c                 | 2 +-
 drivers/mtd/nand/nand_toshiba.c                 | 2 +-
 drivers/mtd/nand/nandsim.c                      | 2 +-
 drivers/mtd/nand/ndfc.c                         | 2 +-
 drivers/mtd/nand/nuc900_nand.c                  | 2 +-
 drivers/mtd/nand/omap2.c                        | 2 +-
 drivers/mtd/nand/orion_nand.c                   | 2 +-
 drivers/mtd/nand/oxnas_nand.c                   | 2 +-
 drivers/mtd/nand/pasemi_nand.c                  | 2 +-
 drivers/mtd/nand/plat_nand.c                    | 2 +-
 drivers/mtd/nand/pxa3xx_nand.c                  | 2 +-
 drivers/mtd/nand/qcom_nandc.c                   | 2 +-
 drivers/mtd/nand/r852.h                         | 2 +-
 drivers/mtd/nand/s3c2410.c                      | 2 +-
 drivers/mtd/nand/sh_flctl.c                     | 2 +-
 drivers/mtd/nand/sharpsl.c                      | 2 +-
 drivers/mtd/nand/sm_common.c                    | 2 +-
 drivers/mtd/nand/socrates_nand.c                | 2 +-
 drivers/mtd/nand/sunxi_nand.c                   | 2 +-
 drivers/mtd/nand/tango_nand.c                   | 2 +-
 drivers/mtd/nand/tmio_nand.c                    | 2 +-
 drivers/mtd/nand/txx9ndfmc.c                    | 2 +-
 drivers/mtd/nand/vf610_nfc.c                    | 2 +-
 drivers/mtd/nand/xway_nand.c                    | 2 +-
 drivers/mtd/nftlcore.c                          | 2 +-
 drivers/mtd/nftlmount.c                         | 2 +-
 drivers/mtd/ssfdc.c                             | 2 +-
 drivers/mtd/tests/nandbiterrs.c                 | 2 +-
 drivers/staging/mt29f_spinand/mt29f_spinand.c   | 2 +-
 fs/jffs2/wbuf.c                                 | 2 +-
 include/linux/mtd/nand-gpio.h                   | 2 +-
 include/linux/mtd/{nand.h => rawnand.h}         | 8 +++-----
 include/linux/mtd/sh_flctl.h                    | 2 +-
 include/linux/mtd/sharpsl.h                     | 2 +-
 include/linux/platform_data/mtd-davinci.h       | 2 +-
 include/linux/platform_data/mtd-nand-s3c2410.h  | 2 +-
 128 files changed, 133 insertions(+), 135 deletions(-)
 rename include/linux/mtd/{nand.h => rawnand.h} (99%)
