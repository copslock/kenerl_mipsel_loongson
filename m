Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Aug 2017 17:59:34 +0200 (CEST)
Received: from mail-wm0-x234.google.com ([IPv6:2a00:1450:400c:c09::234]:38264
        "EHLO mail-wm0-x234.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23995096AbdHDP7Sr7L51 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Aug 2017 17:59:18 +0200
Received: by mail-wm0-x234.google.com with SMTP id m85so23449797wma.1
        for <linux-mips@linux-mips.org>; Fri, 04 Aug 2017 08:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+76tjrzCyGxtsWyGV1LLyoHKgiJjdzaNlPLKaHO2MhM=;
        b=NUZlacrkQcY12gPBVar1q9bMYYsrFrn0jQ0LMwWWCc4KLGyAxUXJeAZvUziTkewjY3
         jZ3m91kWHOm/Ssu8MUu/hKDSyFIeadTMtfFuRPW5wLQR5CT731hEuOh1CGBIM0TINJTL
         lBrsBrkZFykFzM2waJqBKNKFIAmT39ASNcuUuYfqf6kPwofCrMVtx1sIK6gX/0nj5hv9
         88ysQB3yMUgqNtTi3XC8A51XXJpzXNNOe7fHjeqHncuadls371Vdkl3Q8zYtHR9OEwBC
         yz26yhIpdidg0hZL2pX3xQz62Jh+8/lbASVdyYgCfzB0cuBUtmCfFOjjcCsN4C2FZ3vH
         +0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+76tjrzCyGxtsWyGV1LLyoHKgiJjdzaNlPLKaHO2MhM=;
        b=nZPx0j//Z3SMMl2lzMvTUhXoslr9NJqyKNUNm5WRKad7001Vh7eCNkdAoSfV7tTNmY
         nF2NZ3ogLAqTn1LMGID92TS49uPr67su9Q8qRc+FADi3mQAA4SII0aa1e7i0cMcRXrc4
         CwddCDqR+PTzDjZ3vky8vFh1S29DUtDb90PXp2qyOml4X4qHgbnnQe8hWAu9e4Tfd8t9
         Sxpz8SEwXkS0f/1MOWZDlVtFKjuKYbkfuWkbhlHs83Z5JwWTsQiikKhZ3pIdRMb1uRoa
         Jhbj+QSvD4EtowNoQglUB8xPu0TEggVFY51pErZc+X7+D99nMG3rYQ8O0Ch4jkEq3kEg
         iaBA==
X-Gm-Message-State: AHYfb5j48+g1rXmvDIxVal2c4lAl1Y4rqkHu8aUaVVW+FzLXUGtu/s5J
        9aRKtsPGoDFNeoWR
X-Received: by 10.28.57.4 with SMTP id g4mr1578342wma.170.1501862348224;
        Fri, 04 Aug 2017 08:59:08 -0700 (PDT)
Received: from [192.168.1.21] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id m77sm4849063wmd.21.2017.08.04.08.59.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Aug 2017 08:59:07 -0700 (PDT)
Subject: Re: [PATCH] mtd: nand: Rename nand.h into rawnand.h
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
References: <1501860550-16506-1-git-send-email-boris.brezillon@free-electrons.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <c1b8cd3f-2db8-6f9f-286f-28992c8b5a8d@baylibre.com>
Date:   Fri, 4 Aug 2017 17:59:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1501860550-16506-1-git-send-email-boris.brezillon@free-electrons.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <narmstrong@baylibre.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59370
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: narmstrong@baylibre.com
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

On 08/04/2017 05:29 PM, Boris Brezillon wrote:
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
> ---
> Hi All,
> 
> Sorry for the huge Cc list, but I'd like to collect as much acks as
> possible for this patch which is actually part of a bigger series [1].
> 
> Note that there's nothing complicated here, it's just a mechanical
> s/nand\.h/rawnand\.h/ replacement, but it impacts several architectures,
> the doc and staging directories.
> 
> Regards,
> 
> Boris
> 
> [1]https://lwn.net/Articles/723694/
> ---
>  Documentation/driver-api/mtdnand.rst            | 8 ++++----
>  MAINTAINERS                                     | 2 +-
>  arch/arm/mach-davinci/board-da850-evm.c         | 2 +-
>  arch/arm/mach-davinci/board-dm355-evm.c         | 2 +-
>  arch/arm/mach-davinci/board-dm355-leopard.c     | 2 +-
>  arch/arm/mach-davinci/board-dm365-evm.c         | 2 +-
>  arch/arm/mach-davinci/board-dm644x-evm.c        | 2 +-
>  arch/arm/mach-davinci/board-dm646x-evm.c        | 2 +-
>  arch/arm/mach-davinci/board-sffsdr.c            | 2 +-
>  arch/arm/mach-dove/dove-db-setup.c              | 2 +-
>  arch/arm/mach-ep93xx/snappercl15.c              | 2 +-
>  arch/arm/mach-ep93xx/ts72xx.c                   | 2 +-
>  arch/arm/mach-imx/mach-qong.c                   | 2 +-
>  arch/arm/mach-ixp4xx/ixdp425-setup.c            | 2 +-
>  arch/arm/mach-mmp/aspenite.c                    | 2 +-
>  arch/arm/mach-omap1/board-fsample.c             | 2 +-
>  arch/arm/mach-omap1/board-h2.c                  | 2 +-
>  arch/arm/mach-omap1/board-h3.c                  | 2 +-
>  arch/arm/mach-omap1/board-nand.c                | 2 +-
>  arch/arm/mach-omap1/board-perseus2.c            | 2 +-
>  arch/arm/mach-orion5x/db88f5281-setup.c         | 2 +-
>  arch/arm/mach-orion5x/kurobox_pro-setup.c       | 2 +-
>  arch/arm/mach-orion5x/ts209-setup.c             | 2 +-
>  arch/arm/mach-orion5x/ts78xx-setup.c            | 2 +-
>  arch/arm/mach-pxa/balloon3.c                    | 2 +-
>  arch/arm/mach-pxa/em-x270.c                     | 2 +-
>  arch/arm/mach-pxa/eseries.c                     | 2 +-
>  arch/arm/mach-pxa/palmtx.c                      | 2 +-
>  arch/arm/mach-pxa/tosa.c                        | 2 +-
>  arch/arm/mach-s3c24xx/common-smdk.c             | 2 +-
>  arch/arm/mach-s3c24xx/mach-anubis.c             | 2 +-
>  arch/arm/mach-s3c24xx/mach-at2440evb.c          | 2 +-
>  arch/arm/mach-s3c24xx/mach-bast.c               | 2 +-
>  arch/arm/mach-s3c24xx/mach-gta02.c              | 2 +-
>  arch/arm/mach-s3c24xx/mach-jive.c               | 2 +-
>  arch/arm/mach-s3c24xx/mach-mini2440.c           | 2 +-
>  arch/arm/mach-s3c24xx/mach-osiris.c             | 2 +-
>  arch/arm/mach-s3c24xx/mach-qt2410.c             | 2 +-
>  arch/arm/mach-s3c24xx/mach-rx3715.c             | 2 +-
>  arch/arm/mach-s3c24xx/mach-vstms.c              | 2 +-
>  arch/blackfin/mach-bf537/boards/dnp5370.c       | 2 +-
>  arch/blackfin/mach-bf537/boards/stamp.c         | 2 +-
>  arch/blackfin/mach-bf561/boards/acvilon.c       | 2 +-
>  arch/cris/arch-v32/drivers/mach-a3/nandflash.c  | 2 +-
>  arch/cris/arch-v32/drivers/mach-fs/nandflash.c  | 2 +-
>  arch/mips/alchemy/devboards/db1200.c            | 2 +-
>  arch/mips/alchemy/devboards/db1300.c            | 2 +-
>  arch/mips/alchemy/devboards/db1550.c            | 2 +-
>  arch/mips/include/asm/mach-jz4740/jz4740_nand.h | 2 +-
>  arch/mips/netlogic/xlr/platform-flash.c         | 2 +-
>  arch/mips/pnx833x/common/platform.c             | 2 +-
>  arch/mips/rb532/devices.c                       | 2 +-
>  arch/sh/boards/mach-migor/setup.c               | 2 +-
>  drivers/mtd/inftlcore.c                         | 2 +-
>  drivers/mtd/nand/ams-delta.c                    | 2 +-
>  drivers/mtd/nand/atmel/nand-controller.c        | 2 +-
>  drivers/mtd/nand/atmel/pmecc.c                  | 2 +-
>  drivers/mtd/nand/au1550nd.c                     | 2 +-
>  drivers/mtd/nand/bcm47xxnflash/bcm47xxnflash.h  | 2 +-
>  drivers/mtd/nand/bf5xx_nand.c                   | 2 +-
>  drivers/mtd/nand/brcmnand/brcmnand.c            | 2 +-
>  drivers/mtd/nand/cafe_nand.c                    | 2 +-
>  drivers/mtd/nand/cmx270_nand.c                  | 2 +-
>  drivers/mtd/nand/cs553x_nand.c                  | 2 +-
>  drivers/mtd/nand/davinci_nand.c                 | 2 +-
>  drivers/mtd/nand/denali.h                       | 2 +-
>  drivers/mtd/nand/diskonchip.c                   | 2 +-
>  drivers/mtd/nand/docg4.c                        | 2 +-
>  drivers/mtd/nand/fsl_elbc_nand.c                | 2 +-
>  drivers/mtd/nand/fsl_ifc_nand.c                 | 2 +-
>  drivers/mtd/nand/fsl_upm.c                      | 2 +-
>  drivers/mtd/nand/fsmc_nand.c                    | 2 +-
>  drivers/mtd/nand/gpio.c                         | 2 +-
>  drivers/mtd/nand/gpmi-nand/gpmi-nand.h          | 2 +-
>  drivers/mtd/nand/hisi504_nand.c                 | 2 +-
>  drivers/mtd/nand/jz4740_nand.c                  | 2 +-
>  drivers/mtd/nand/jz4780_nand.c                  | 2 +-
>  drivers/mtd/nand/lpc32xx_mlc.c                  | 2 +-
>  drivers/mtd/nand/lpc32xx_slc.c                  | 2 +-
>  drivers/mtd/nand/mpc5121_nfc.c                  | 2 +-
>  drivers/mtd/nand/mtk_nand.c                     | 2 +-
>  drivers/mtd/nand/mxc_nand.c                     | 2 +-
>  drivers/mtd/nand/nand_amd.c                     | 2 +-
>  drivers/mtd/nand/nand_base.c                    | 2 +-
>  drivers/mtd/nand/nand_bbt.c                     | 2 +-
>  drivers/mtd/nand/nand_bch.c                     | 2 +-
>  drivers/mtd/nand/nand_ecc.c                     | 2 +-
>  drivers/mtd/nand/nand_hynix.c                   | 2 +-
>  drivers/mtd/nand/nand_ids.c                     | 2 +-
>  drivers/mtd/nand/nand_macronix.c                | 2 +-
>  drivers/mtd/nand/nand_micron.c                  | 2 +-
>  drivers/mtd/nand/nand_samsung.c                 | 2 +-
>  drivers/mtd/nand/nand_timings.c                 | 2 +-
>  drivers/mtd/nand/nand_toshiba.c                 | 2 +-
>  drivers/mtd/nand/nandsim.c                      | 2 +-
>  drivers/mtd/nand/ndfc.c                         | 2 +-
>  drivers/mtd/nand/nuc900_nand.c                  | 2 +-
>  drivers/mtd/nand/omap2.c                        | 2 +-
>  drivers/mtd/nand/orion_nand.c                   | 2 +-
>  drivers/mtd/nand/oxnas_nand.c                   | 2 +-
>  drivers/mtd/nand/pasemi_nand.c                  | 2 +-
>  drivers/mtd/nand/plat_nand.c                    | 2 +-
>  drivers/mtd/nand/pxa3xx_nand.c                  | 2 +-
>  drivers/mtd/nand/qcom_nandc.c                   | 2 +-
>  drivers/mtd/nand/r852.h                         | 2 +-
>  drivers/mtd/nand/s3c2410.c                      | 2 +-
>  drivers/mtd/nand/sh_flctl.c                     | 2 +-
>  drivers/mtd/nand/sharpsl.c                      | 2 +-
>  drivers/mtd/nand/sm_common.c                    | 2 +-
>  drivers/mtd/nand/socrates_nand.c                | 2 +-
>  drivers/mtd/nand/sunxi_nand.c                   | 2 +-
>  drivers/mtd/nand/tango_nand.c                   | 2 +-
>  drivers/mtd/nand/tmio_nand.c                    | 2 +-
>  drivers/mtd/nand/txx9ndfmc.c                    | 2 +-
>  drivers/mtd/nand/vf610_nfc.c                    | 2 +-
>  drivers/mtd/nand/xway_nand.c                    | 2 +-
>  drivers/mtd/nftlcore.c                          | 2 +-
>  drivers/mtd/nftlmount.c                         | 2 +-
>  drivers/mtd/ssfdc.c                             | 2 +-
>  drivers/mtd/tests/nandbiterrs.c                 | 2 +-
>  drivers/staging/mt29f_spinand/mt29f_spinand.c   | 2 +-
>  fs/jffs2/wbuf.c                                 | 2 +-
>  include/linux/mtd/nand-gpio.h                   | 2 +-
>  include/linux/mtd/{nand.h => rawnand.h}         | 8 +++-----
>  include/linux/mtd/sh_flctl.h                    | 2 +-
>  include/linux/mtd/sharpsl.h                     | 2 +-
>  include/linux/platform_data/mtd-davinci.h       | 2 +-
>  include/linux/platform_data/mtd-nand-s3c2410.h  | 2 +-
>  128 files changed, 133 insertions(+), 135 deletions(-)
>  rename include/linux/mtd/{nand.h => rawnand.h} (99%)
> 
[...]
> diff --git a/drivers/mtd/nand/oxnas_nand.c b/drivers/mtd/nand/oxnas_nand.c
> index 7061bb2923b4..d649d5944826 100644
> --- a/drivers/mtd/nand/oxnas_nand.c
> +++ b/drivers/mtd/nand/oxnas_nand.c
> @@ -21,7 +21,7 @@
>  #include <linux/clk.h>
>  #include <linux/reset.h>
>  #include <linux/mtd/mtd.h>
> -#include <linux/mtd/nand.h>
> +#include <linux/mtd/rawnand.h>
>  #include <linux/mtd/partitions.h>
>  #include <linux/of.h>
>  
[...]

For oxnas_nand.c :
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
