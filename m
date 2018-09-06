Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Sep 2018 22:15:13 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:59044 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994641AbeIFUPKdXTmK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Sep 2018 22:15:10 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id F291B20756; Thu,  6 Sep 2018 22:15:04 +0200 (CEST)
Received: from xps13 (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 54267206EE;
        Thu,  6 Sep 2018 22:15:02 +0200 (CEST)
Date:   Thu, 6 Sep 2018 22:15:00 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Lukasz Majewski <lukma@denx.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Alexander Clouter <alex@digriz.org.uk>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Han Xu <han.xu@nxp.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Xiaolei Li <xiaolei.li@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Wan ZongShun <mcuos.com@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>, Stefan Agner <stefan@agner.ch>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH v2 00/23] mtd: rawnand: Stop passing mtd_info to drivers
Message-ID: <20180906221500.740fa928@xps13>
In-Reply-To: <20180906120535.21255-1-boris.brezillon@bootlin.com>
References: <20180906120535.21255-1-boris.brezillon@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <miquel.raynal@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66075
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: miquel.raynal@bootlin.com
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

Hi Boris,

Boris Brezillon <boris.brezillon@bootlin.com> wrote on Thu,  6 Sep 2018
14:05:12 +0200:

> Hello,
> 
> This is the first set of patches aiming at cleaning the raw NAND API.
> 
> This one focuses on inconsistencies we have in the API + the nand_chip
> and nand_ecc_ctrl interfaces. Some functions/hooks are passed a
> nand_chip object, some are passed an mtd_info object and some are
> passed both.
> 
> Since mtd_info can be extracted from nand_chip, we can simply always
> pass a nand_chip and make things consistent. Hopefully with these
> changes merged we'll stop seeing new drivers reproducing the same
> mistake (passing both mtd_info and nand_chip or using mtd_info where
> nand_chip is more appropriate).
> 
> For those who want to see what's in the pipe, here is a branch [1]
> containing all the cleanups I plan to merge.
> 
> Not much has changed in this v2. I just rebased on top of nand/next,
> fixed typos, added A-b/R-b tags, and that's all.
> 
> Regards,
> 
> Boris
> 
> [1]https://github.com/bbrezillon/linux-0day/commits/nand/api-cleanup
> 
> Boris Brezillon (23):
>   mtd: rawnand: plat_nand: Pass a nand_chip object to all
>     platform_nand_ctrl hooks
>   mtd: rawnand: Pass a nand_chip object to nand_scan()
>   mtd: rawnand: Pass a nand_chip object to nand_release()
>   mtd: rawnand: Pass a nand_chip object to nand_wait_ready()
>   mtd: rawnand: Pass a nand_chip object to ecc->hwctl()
>   mtd: rawnand: Pass a nand_chip object to ecc->calculate()
>   mtd: rawnand: Pass a nand_chip object to ecc->correct()
>   mtd: rawnand: Pass a nand_chip object to ecc->read_xxx() hooks
>   mtd: rawnand: Pass a nand_chip object to ecc->write_xxx() hooks
>   mtd: rawnand: Pass a nand_chip object to chip->read_xxx() hooks
>   mtd: rawnand: Pass a nand_chip object to chip->write_xxx() hooks
>   mtd: rawnand: Pass a nand_chip object to chip->select_chip()
>   mtd: rawnand: Pass a nand_chip object to chip->block_xxx() hooks
>   mtd: rawnand: Pass a nand_chip object to chip->cmd_ctrl()
>   mtd: rawnand: Pass a nand_chip object to chip->dev_ready()
>   mtd: rawnand: Pass a nand_chip object to chip->cmdfunc()
>   mtd: rawnand: Pass a nand_chip object to chip->waitfunc()
>   mtd: rawnand: Pass a nand_chip object to chip->erase()
>   mtd: rawnand: Pass a nand_chip object to chip->{get,set}_features()
>   mtd: rawnand: Pass a nand_chip object to chip->setup_read_retry()
>   mtd: rawnand: Pass a nand_chip object to chip->setup_data_interface()
>   mtd: rawnand: Pass a nand_chip object to all nand_xxx_bbt() helpers
>   mtd: rawnand: Pass a nand_chip object nand_erase_nand()
> 
>  Documentation/driver-api/mtdnand.rst             |   4 +-
>  arch/arm/mach-ep93xx/snappercl15.c               |   7 +-
>  arch/arm/mach-ep93xx/ts72xx.c                    |   7 +-
>  arch/arm/mach-imx/mach-qong.c                    |  11 +-
>  arch/arm/mach-ixp4xx/ixdp425-setup.c             |   3 +-
>  arch/arm/mach-omap1/board-fsample.c              |   2 +-
>  arch/arm/mach-omap1/board-h2.c                   |   2 +-
>  arch/arm/mach-omap1/board-h3.c                   |   2 +-
>  arch/arm/mach-omap1/board-nand.c                 |   3 +-
>  arch/arm/mach-omap1/board-perseus2.c             |   2 +-
>  arch/arm/mach-omap1/common.h                     |   2 +-
>  arch/arm/mach-orion5x/ts78xx-setup.c             |  18 +-
>  arch/arm/mach-pxa/balloon3.c                     |   8 +-
>  arch/arm/mach-pxa/em-x270.c                      |   5 +-
>  arch/arm/mach-pxa/palmtx.c                       |   5 +-
>  arch/mips/alchemy/devboards/db1200.c             |   5 +-
>  arch/mips/alchemy/devboards/db1300.c             |   5 +-
>  arch/mips/alchemy/devboards/db1550.c             |   5 +-
>  arch/mips/netlogic/xlr/platform-flash.c          |   4 +-
>  arch/mips/pnx833x/common/platform.c              |   3 +-
>  arch/mips/rb532/devices.c                        |   5 +-
>  arch/sh/boards/mach-migor/setup.c                |   6 +-
>  drivers/mtd/nand/raw/ams-delta.c                 |  24 +-
>  drivers/mtd/nand/raw/atmel/nand-controller.c     |  74 ++-
>  drivers/mtd/nand/raw/au1550nd.c                  |  70 ++-
>  drivers/mtd/nand/raw/bcm47xxnflash/main.c        |   2 +-
>  drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c |  38 +-
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c         |  78 +--
>  drivers/mtd/nand/raw/cafe_nand.c                 |  56 +--
>  drivers/mtd/nand/raw/cmx270_nand.c               |  20 +-
>  drivers/mtd/nand/raw/cs553x_nand.c               |  33 +-
>  drivers/mtd/nand/raw/davinci_nand.c              |  59 +--
>  drivers/mtd/nand/raw/denali.c                    |  87 ++--
>  drivers/mtd/nand/raw/diskonchip.c                | 116 ++---
>  drivers/mtd/nand/raw/docg4.c                     |  83 ++--
>  drivers/mtd/nand/raw/fsl_elbc_nand.c             |  52 +-
>  drivers/mtd/nand/raw/fsl_ifc_nand.c              |  46 +-
>  drivers/mtd/nand/raw/fsl_upm.c                   |  34 +-
>  drivers/mtd/nand/raw/fsmc_nand.c                 |  42 +-
>  drivers/mtd/nand/raw/gpio.c                      |  13 +-
>  drivers/mtd/nand/raw/gpmi-nand/gpmi-lib.c        |   3 +-
>  drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c       |  99 ++--
>  drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.h       |   2 +-
>  drivers/mtd/nand/raw/hisi504_nand.c              |  44 +-
>  drivers/mtd/nand/raw/jz4740_nand.c               |  39 +-
>  drivers/mtd/nand/raw/jz4780_nand.c               |  30 +-
>  drivers/mtd/nand/raw/lpc32xx_mlc.c               |  47 +-
>  drivers/mtd/nand/raw/lpc32xx_slc.c               |  67 ++-
>  drivers/mtd/nand/raw/marvell_nand.c              |  74 ++-
>  drivers/mtd/nand/raw/mpc5121_nfc.c               |  40 +-
>  drivers/mtd/nand/raw/mtk_nand.c                  |  81 ++-
>  drivers/mtd/nand/raw/mxc_nand.c                  |  85 ++--
>  drivers/mtd/nand/raw/nand_base.c                 | 606 ++++++++++-------------
>  drivers/mtd/nand/raw/nand_bbt.c                  |  21 +-
>  drivers/mtd/nand/raw/nand_bch.c                  |  10 +-
>  drivers/mtd/nand/raw/nand_ecc.c                  |  14 +-
>  drivers/mtd/nand/raw/nand_hynix.c                |  12 +-
>  drivers/mtd/nand/raw/nand_micron.c               |  16 +-
>  drivers/mtd/nand/raw/nand_toshiba.c              |  10 +-
>  drivers/mtd/nand/raw/nandsim.c                   |  28 +-
>  drivers/mtd/nand/raw/ndfc.c                      |  25 +-
>  drivers/mtd/nand/raw/nuc900_nand.c               |  27 +-
>  drivers/mtd/nand/raw/omap2.c                     | 148 +++---
>  drivers/mtd/nand/raw/orion_nand.c                |  14 +-
>  drivers/mtd/nand/raw/oxnas_nand.c                |  19 +-
>  drivers/mtd/nand/raw/pasemi_nand.c               |  19 +-
>  drivers/mtd/nand/raw/plat_nand.c                 |   6 +-
>  drivers/mtd/nand/raw/qcom_nandc.c                |  52 +-
>  drivers/mtd/nand/raw/r852.c                      |  54 +-
>  drivers/mtd/nand/raw/s3c2410.c                   |  72 +--
>  drivers/mtd/nand/raw/sh_flctl.c                  |  40 +-
>  drivers/mtd/nand/raw/sharpsl.c                   |  24 +-
>  drivers/mtd/nand/raw/sm_common.c                 |   5 +-
>  drivers/mtd/nand/raw/socrates_nand.c             |  32 +-
>  drivers/mtd/nand/raw/sunxi_nand.c                |  82 ++-
>  drivers/mtd/nand/raw/tango_nand.c                |  67 ++-
>  drivers/mtd/nand/raw/tegra_nand.c                |  36 +-
>  drivers/mtd/nand/raw/tmio_nand.c                 |  53 +-
>  drivers/mtd/nand/raw/txx9ndfmc.c                 |  38 +-
>  drivers/mtd/nand/raw/vf610_nfc.c                 |  43 +-
>  drivers/mtd/nand/raw/xway_nand.c                 |  27 +-
>  drivers/staging/mt29f_spinand/mt29f_spinand.c    |  33 +-
>  include/linux/mtd/nand_bch.h                     |  11 +-
>  include/linux/mtd/nand_ecc.h                     |   8 +-
>  include/linux/mtd/rawnand.h                      | 142 +++---
>  85 files changed, 1617 insertions(+), 1829 deletions(-)
> 

Series applied to nand/next.

Thanks,
Miquèl
