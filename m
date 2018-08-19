Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Aug 2018 12:14:27 +0200 (CEST)
Received: from mail-wr1-x442.google.com ([IPv6:2a00:1450:4864:20::442]:39698
        "EHLO mail-wr1-x442.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990945AbeHSKON4CzH8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 19 Aug 2018 12:14:13 +0200
Received: by mail-wr1-x442.google.com with SMTP id o37-v6so1690342wrf.6;
        Sun, 19 Aug 2018 03:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=MUX690iee6Uv4JxZQBrijq1WybE1sglwnlOd7W5C1aQ=;
        b=o8JNb2uKkQfvlORu8CEYJ29W+Gi5aXq6xdjBNG2742dH+BDrohHKd4jVY9QWzoswzK
         T3JF7MIThxFH9iLyvNDn2pekdP8Thc8JuKtZ3bmj4PbczUd0IGY04PIGuSasNDmCXQc4
         VMe37tqrchG8Z5B8Ctk4NFXcCfCejV/2CFxVdI6rGMsFb5LV6T8qme1o5CZiuWtH6tpC
         Y6Z8PeC1s2UUctSWr1Ftt7dEzlaQVkyiCz6wJJKN/UbAfJZEF5t36nW/086SXVWNd4FQ
         rXawiNzym1xE/QJrDViSzpbLPx4SuEC/PEaZyrOKFF/PCtdRDx6ufNEqufGXSNIL7PNJ
         YY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=MUX690iee6Uv4JxZQBrijq1WybE1sglwnlOd7W5C1aQ=;
        b=sc/bVtdo37uu4BZYphLYi9QPIfCkCWcTv8GcNquKYXAbH6IYKyZOn4Urfmefn4QQuF
         N4NwkMK4zxax4v/FmKwBV/22APSVraQsdpG+wwdD8kqEVvdzmmIdxmLldfIGXdfuEJc3
         xZ/+x1jkiK4IXWXeTn4oJryetCEfyAO4rskO+XLoTZVi1F2z+9mv5O3EOXeCSFW+yGPM
         4M0BpVprIJsUm06rhaTtZeC8UxCD3uw8/EeqDuIKtVpd/GBTDwM1mcrASWPQVrAImRAm
         k7u+x3zZDhLV7RXP53+pbcWDGEsO7evKGAUyHDL9UVxFgblSyVsefXvSSu7RFa5vw3yn
         D2lQ==
X-Gm-Message-State: AOUpUlFsB12Cy/ncPRPq/TataZk3xW2nw+RiuPXlgFP6v+VOUQ1DE9oJ
        fl7MAr0kzTmGsXLWv+jugoA=
X-Google-Smtp-Source: AA+uWPyNm23TCnwgnzh8ch6Gu8RKk+3otKqm7BmvksR7q5nGNmkEj+YKz9aLLCCupQA72r0h6EB8RA==
X-Received: by 2002:adf:b583:: with SMTP id c3-v6mr27025768wre.79.1534673648312;
        Sun, 19 Aug 2018 03:14:08 -0700 (PDT)
Received: from [172.28.172.2] ([46.188.134.42])
        by smtp.gmail.com with ESMTPSA id m8-v6sm14979543wrf.93.2018.08.19.03.13.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Aug 2018 03:14:06 -0700 (PDT)
Subject: Re: [PATCH 01/23] mtd: rawnand: plat_nand: Pass a nand_chip object to
 all platform_nand_ctrl hooks
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Hartley Sweeten <hsweeten@visionengravers.com>,
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
References: <20180817160922.6224-1-boris.brezillon@bootlin.com>
 <20180817160922.6224-2-boris.brezillon@bootlin.com>
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
Message-ID: <157f4cfb-ea3b-7e10-e4f2-3acaf5fd6df0@gmail.com>
Date:   Sun, 19 Aug 2018 12:13:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180817160922.6224-2-boris.brezillon@bootlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Return-Path: <alexander.sverdlin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65639
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexander.sverdlin@gmail.com
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

Hello!

On 17/08/18 18:09, Boris Brezillon wrote:
> Let's make the raw NAND API consistent by patching all helpers and
> hooks to take a nand_chip object instead of an mtd_info one or
> remove the mtd_info object when both are passed.
>
> In order to do that, we first need to update the platform_nand_ctrl
> hooks to take a nand_chip object instead of an mtd_info.
>
> We had temporary plat_nand_xxx() wrappers to the do the mtd -> chip
> conversion, but those will be dropped when doing the patching nand_chip
> hooks to take a nand_chip object.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
For the EP93xx parts:
Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
>   arch/arm/mach-ep93xx/snappercl15.c      |  7 ++--
>   arch/arm/mach-ep93xx/ts72xx.c           |  7 ++--
>   arch/arm/mach-imx/mach-qong.c           | 11 +++----
>   arch/arm/mach-ixp4xx/ixdp425-setup.c    |  3 +-
>   arch/arm/mach-omap1/board-fsample.c     |  2 +-
>   arch/arm/mach-omap1/board-h2.c          |  2 +-
>   arch/arm/mach-omap1/board-h3.c          |  2 +-
>   arch/arm/mach-omap1/board-nand.c        |  3 +-
>   arch/arm/mach-omap1/board-perseus2.c    |  2 +-
>   arch/arm/mach-omap1/common.h            |  2 +-
>   arch/arm/mach-orion5x/ts78xx-setup.c    | 18 ++++-------
>   arch/arm/mach-pxa/balloon3.c            |  8 ++---
>   arch/arm/mach-pxa/em-x270.c             |  5 ++-
>   arch/arm/mach-pxa/palmtx.c              |  5 ++-
>   arch/mips/alchemy/devboards/db1200.c    |  5 ++-
>   arch/mips/alchemy/devboards/db1300.c    |  5 ++-
>   arch/mips/alchemy/devboards/db1550.c    |  5 ++-
>   arch/mips/netlogic/xlr/platform-flash.c |  4 +--
>   arch/mips/pnx833x/common/platform.c     |  3 +-
>   arch/mips/rb532/devices.c               |  5 ++-
>   arch/sh/boards/mach-migor/setup.c       |  6 ++--
>   drivers/mtd/nand/raw/plat_nand.c        | 57 ++++++++++++++++++++++++++++++---
>   include/linux/mtd/rawnand.h             | 10 +++---
>   23 files changed, 101 insertions(+), 76 deletions(-)
>
> diff --git a/arch/arm/mach-ep93xx/snappercl15.c b/arch/arm/mach-ep93xx/snappercl15.c
> index 45940c1d7787..aa03ea79c5f5 100644
> --- a/arch/arm/mach-ep93xx/snappercl15.c
> +++ b/arch/arm/mach-ep93xx/snappercl15.c
> @@ -45,10 +45,9 @@
>   
>   #define NAND_CTRL_ADDR(chip) 	(chip->IO_ADDR_W + 0x40)
>   
> -static void snappercl15_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
> +static void snappercl15_nand_cmd_ctrl(struct nand_chip *chip, int cmd,
>   				      unsigned int ctrl)
>   {
> -	struct nand_chip *chip = mtd_to_nand(mtd);
>   	static u16 nand_state = SNAPPERCL15_NAND_WPN;
>   	u16 set;
>   
> @@ -73,10 +72,8 @@ static void snappercl15_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
>   		__raw_writew((cmd & 0xff) | nand_state, chip->IO_ADDR_W);
>   }
>   
> -static int snappercl15_nand_dev_ready(struct mtd_info *mtd)
> +static int snappercl15_nand_dev_ready(struct nand_chip *chip)
>   {
> -	struct nand_chip *chip = mtd_to_nand(mtd);
> -
>   	return !!(__raw_readw(NAND_CTRL_ADDR(chip)) & SNAPPERCL15_NAND_RDY);
>   }
>   
> diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
> index c089a2a4fe30..26259dd9e951 100644
> --- a/arch/arm/mach-ep93xx/ts72xx.c
> +++ b/arch/arm/mach-ep93xx/ts72xx.c
> @@ -76,11 +76,9 @@ static void __init ts72xx_map_io(void)
>   #define TS72XX_NAND_CONTROL_ADDR_LINE	22	/* 0xN0400000 */
>   #define TS72XX_NAND_BUSY_ADDR_LINE	23	/* 0xN0800000 */
>   
> -static void ts72xx_nand_hwcontrol(struct mtd_info *mtd,
> +static void ts72xx_nand_hwcontrol(struct nand_chip *chip,
>   				  int cmd, unsigned int ctrl)
>   {
> -	struct nand_chip *chip = mtd_to_nand(mtd);
> -
>   	if (ctrl & NAND_CTRL_CHANGE) {
>   		void __iomem *addr = chip->IO_ADDR_R;
>   		unsigned char bits;
> @@ -99,9 +97,8 @@ static void ts72xx_nand_hwcontrol(struct mtd_info *mtd,
>   		__raw_writeb(cmd, chip->IO_ADDR_W);
>   }
>   
> -static int ts72xx_nand_device_ready(struct mtd_info *mtd)
> +static int ts72xx_nand_device_ready(struct nand_chip *chip)
>   {
> -	struct nand_chip *chip = mtd_to_nand(mtd);
>   	void __iomem *addr = chip->IO_ADDR_R;
>   
>   	addr += (1 << TS72XX_NAND_BUSY_ADDR_LINE);
> diff --git a/arch/arm/mach-imx/mach-qong.c b/arch/arm/mach-imx/mach-qong.c
> index 42a700053103..ff015f603ac9 100644
> --- a/arch/arm/mach-imx/mach-qong.c
> +++ b/arch/arm/mach-imx/mach-qong.c
> @@ -129,10 +129,9 @@ static void qong_init_nor_mtd(void)
>   /*
>    * Hardware specific access to control-lines
>    */
> -static void qong_nand_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
> +static void qong_nand_cmd_ctrl(struct nand_chip *nand_chip, int cmd,
> +			       unsigned int ctrl)
>   {
> -	struct nand_chip *nand_chip = mtd_to_nand(mtd);
> -
>   	if (cmd == NAND_CMD_NONE)
>   		return;
>   
> @@ -145,14 +144,14 @@ static void qong_nand_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
>   /*
>    * Read the Device Ready pin.
>    */
> -static int qong_nand_device_ready(struct mtd_info *mtd)
> +static int qong_nand_device_ready(struct nand_chip *chip)
>   {
>   	return gpio_get_value(IOMUX_TO_GPIO(MX31_PIN_NFRB));
>   }
>   
> -static void qong_nand_select_chip(struct mtd_info *mtd, int chip)
> +static void qong_nand_select_chip(struct nand_chip *chip, int cs)
>   {
> -	if (chip >= 0)
> +	if (cs >= 0)
>   		gpio_set_value(IOMUX_TO_GPIO(MX31_PIN_NFCE_B), 0);
>   	else
>   		gpio_set_value(IOMUX_TO_GPIO(MX31_PIN_NFCE_B), 1);
> diff --git a/arch/arm/mach-ixp4xx/ixdp425-setup.c b/arch/arm/mach-ixp4xx/ixdp425-setup.c
> index 3ec829d52cdd..7c39edc121ba 100644
> --- a/arch/arm/mach-ixp4xx/ixdp425-setup.c
> +++ b/arch/arm/mach-ixp4xx/ixdp425-setup.c
> @@ -75,9 +75,8 @@ static struct mtd_partition ixdp425_partitions[] = {
>   };
>   
>   static void
> -ixdp425_flash_nand_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
> +ixdp425_flash_nand_cmd_ctrl(struct nand_chip *this, int cmd, unsigned int ctrl)
>   {
> -	struct nand_chip *this = mtd_to_nand(mtd);
>   	int offset = (int)nand_get_controller_data(this);
>   
>   	if (ctrl & NAND_CTRL_CHANGE) {
> diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
> index 69bd601feb83..e9f512a0602e 100644
> --- a/arch/arm/mach-omap1/board-fsample.c
> +++ b/arch/arm/mach-omap1/board-fsample.c
> @@ -186,7 +186,7 @@ static struct platform_device nor_device = {
>   
>   #define FSAMPLE_NAND_RB_GPIO_PIN	62
>   
> -static int nand_dev_ready(struct mtd_info *mtd)
> +static int nand_dev_ready(struct nand_chip *chip)
>   {
>   	return gpio_get_value(FSAMPLE_NAND_RB_GPIO_PIN);
>   }
> diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
> index ab51f8554697..23f5512142f2 100644
> --- a/arch/arm/mach-omap1/board-h2.c
> +++ b/arch/arm/mach-omap1/board-h2.c
> @@ -182,7 +182,7 @@ static struct mtd_partition h2_nand_partitions[] = {
>   
>   #define H2_NAND_RB_GPIO_PIN	62
>   
> -static int h2_nand_dev_ready(struct mtd_info *mtd)
> +static int h2_nand_dev_ready(struct nand_chip *chip)
>   {
>   	return gpio_get_value(H2_NAND_RB_GPIO_PIN);
>   }
> diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
> index ad339f51cc78..98e7cb42e2c1 100644
> --- a/arch/arm/mach-omap1/board-h3.c
> +++ b/arch/arm/mach-omap1/board-h3.c
> @@ -185,7 +185,7 @@ static struct mtd_partition nand_partitions[] = {
>   
>   #define H3_NAND_RB_GPIO_PIN	10
>   
> -static int nand_dev_ready(struct mtd_info *mtd)
> +static int nand_dev_ready(struct nand_chip *chip)
>   {
>   	return gpio_get_value(H3_NAND_RB_GPIO_PIN);
>   }
> diff --git a/arch/arm/mach-omap1/board-nand.c b/arch/arm/mach-omap1/board-nand.c
> index 1bffbb4e050f..59d56a30bc63 100644
> --- a/arch/arm/mach-omap1/board-nand.c
> +++ b/arch/arm/mach-omap1/board-nand.c
> @@ -20,9 +20,8 @@
>   
>   #include "common.h"
>   
> -void omap1_nand_cmd_ctl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
> +void omap1_nand_cmd_ctl(struct nand_chip *this, int cmd, unsigned int ctrl)
>   {
> -	struct nand_chip *this = mtd_to_nand(mtd);
>   	unsigned long mask;
>   
>   	if (cmd == NAND_CMD_NONE)
> diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
> index b4951eb82898..c61c7c7520ca 100644
> --- a/arch/arm/mach-omap1/board-perseus2.c
> +++ b/arch/arm/mach-omap1/board-perseus2.c
> @@ -144,7 +144,7 @@ static struct platform_device nor_device = {
>   
>   #define P2_NAND_RB_GPIO_PIN	62
>   
> -static int nand_dev_ready(struct mtd_info *mtd)
> +static int nand_dev_ready(struct nand_chip *chip)
>   {
>   	return gpio_get_value(P2_NAND_RB_GPIO_PIN);
>   }
> diff --git a/arch/arm/mach-omap1/common.h b/arch/arm/mach-omap1/common.h
> index c6537d2c2859..11b87a4c84d4 100644
> --- a/arch/arm/mach-omap1/common.h
> +++ b/arch/arm/mach-omap1/common.h
> @@ -82,7 +82,7 @@ void omap1_restart(enum reboot_mode, const char *);
>   
>   extern void __init omap_check_revision(void);
>   
> -extern void omap1_nand_cmd_ctl(struct mtd_info *mtd, int cmd,
> +extern void omap1_nand_cmd_ctl(struct nand_chip *this, int cmd,
>   			       unsigned int ctrl);
>   
>   extern void omap1_timer_init(void);
> diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
> index 94778739e38f..48d85ddf7c31 100644
> --- a/arch/arm/mach-orion5x/ts78xx-setup.c
> +++ b/arch/arm/mach-orion5x/ts78xx-setup.c
> @@ -131,11 +131,9 @@ static void ts78xx_ts_rtc_unload(void)
>    * NAND_CLE: bit 1 -> bit 1
>    * NAND_ALE: bit 2 -> bit 0
>    */
> -static void ts78xx_ts_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
> -			unsigned int ctrl)
> +static void ts78xx_ts_nand_cmd_ctrl(struct nand_chip *this, int cmd,
> +				    unsigned int ctrl)
>   {
> -	struct nand_chip *this = mtd_to_nand(mtd);
> -
>   	if (ctrl & NAND_CTRL_CHANGE) {
>   		unsigned char bits;
>   
> @@ -150,15 +148,14 @@ static void ts78xx_ts_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
>   		writeb(cmd, this->IO_ADDR_W);
>   }
>   
> -static int ts78xx_ts_nand_dev_ready(struct mtd_info *mtd)
> +static int ts78xx_ts_nand_dev_ready(struct nand_chip *chip)
>   {
>   	return readb(TS_NAND_CTRL) & 0x20;
>   }
>   
> -static void ts78xx_ts_nand_write_buf(struct mtd_info *mtd,
> -			const uint8_t *buf, int len)
> +static void ts78xx_ts_nand_write_buf(struct nand_chip *chip,
> +				     const uint8_t *buf, int len)
>   {
> -	struct nand_chip *chip = mtd_to_nand(mtd);
>   	void __iomem *io_base = chip->IO_ADDR_W;
>   	unsigned long off = ((unsigned long)buf & 3);
>   	int sz;
> @@ -182,10 +179,9 @@ static void ts78xx_ts_nand_write_buf(struct mtd_info *mtd,
>   		writesb(io_base, buf, len);
>   }
>   
> -static void ts78xx_ts_nand_read_buf(struct mtd_info *mtd,
> -			uint8_t *buf, int len)
> +static void ts78xx_ts_nand_read_buf(struct nand_chip *chip,
> +				    uint8_t *buf, int len)
>   {
> -	struct nand_chip *chip = mtd_to_nand(mtd);
>   	void __iomem *io_base = chip->IO_ADDR_R;
>   	unsigned long off = ((unsigned long)buf & 3);
>   	int sz;
> diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
> index af46d2182533..71fda90b9599 100644
> --- a/arch/arm/mach-pxa/balloon3.c
> +++ b/arch/arm/mach-pxa/balloon3.c
> @@ -571,9 +571,9 @@ static inline void balloon3_i2c_init(void) {}
>    * NAND
>    ******************************************************************************/
>   #if defined(CONFIG_MTD_NAND_PLATFORM)||defined(CONFIG_MTD_NAND_PLATFORM_MODULE)
> -static void balloon3_nand_cmd_ctl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
> +static void balloon3_nand_cmd_ctl(struct nand_chip *this, int cmd,
> +				  unsigned int ctrl)
>   {
> -	struct nand_chip *this = mtd_to_nand(mtd);
>   	uint8_t balloon3_ctl_set = 0, balloon3_ctl_clr = 0;
>   
>   	if (ctrl & NAND_CTRL_CHANGE) {
> @@ -600,7 +600,7 @@ static void balloon3_nand_cmd_ctl(struct mtd_info *mtd, int cmd, unsigned int ct
>   		writeb(cmd, this->IO_ADDR_W);
>   }
>   
> -static void balloon3_nand_select_chip(struct mtd_info *mtd, int chip)
> +static void balloon3_nand_select_chip(struct nand_chip *this, int chip)
>   {
>   	if (chip < 0 || chip > 3)
>   		return;
> @@ -616,7 +616,7 @@ static void balloon3_nand_select_chip(struct mtd_info *mtd, int chip)
>   		BALLOON3_NAND_CONTROL_REG);
>   }
>   
> -static int balloon3_nand_dev_ready(struct mtd_info *mtd)
> +static int balloon3_nand_dev_ready(struct nand_chip *this)
>   {
>   	return __raw_readl(BALLOON3_NAND_STAT_REG) & BALLOON3_NAND_STAT_RNB;
>   }
> diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
> index 29be04c6cc48..ba1ec9992830 100644
> --- a/arch/arm/mach-pxa/em-x270.c
> +++ b/arch/arm/mach-pxa/em-x270.c
> @@ -285,10 +285,9 @@ static void nand_cs_off(void)
>   }
>   
>   /* hardware specific access to control-lines */
> -static void em_x270_nand_cmd_ctl(struct mtd_info *mtd, int dat,
> +static void em_x270_nand_cmd_ctl(struct nand_chip *this, int dat,
>   				 unsigned int ctrl)
>   {
> -	struct nand_chip *this = mtd_to_nand(mtd);
>   	unsigned long nandaddr = (unsigned long)this->IO_ADDR_W;
>   
>   	dsb();
> @@ -317,7 +316,7 @@ static void em_x270_nand_cmd_ctl(struct mtd_info *mtd, int dat,
>   }
>   
>   /* read device ready pin */
> -static int em_x270_nand_device_ready(struct mtd_info *mtd)
> +static int em_x270_nand_device_ready(struct nand_chip *this)
>   {
>   	dsb();
>   
> diff --git a/arch/arm/mach-pxa/palmtx.c b/arch/arm/mach-pxa/palmtx.c
> index 47e3e38e9bec..ed9661e70b83 100644
> --- a/arch/arm/mach-pxa/palmtx.c
> +++ b/arch/arm/mach-pxa/palmtx.c
> @@ -247,10 +247,9 @@ static inline void palmtx_keys_init(void) {}
>    ******************************************************************************/
>   #if defined(CONFIG_MTD_NAND_PLATFORM) || \
>   	defined(CONFIG_MTD_NAND_PLATFORM_MODULE)
> -static void palmtx_nand_cmd_ctl(struct mtd_info *mtd, int cmd,
> -				 unsigned int ctrl)
> +static void palmtx_nand_cmd_ctl(struct nand_chip *this, int cmd,
> +				unsigned int ctrl)
>   {
> -	struct nand_chip *this = mtd_to_nand(mtd);
>   	char __iomem *nandaddr = this->IO_ADDR_W;
>   
>   	if (cmd == NAND_CMD_NONE)
> diff --git a/arch/mips/alchemy/devboards/db1200.c b/arch/mips/alchemy/devboards/db1200.c
> index da7663770425..f043615c1a99 100644
> --- a/arch/mips/alchemy/devboards/db1200.c
> +++ b/arch/mips/alchemy/devboards/db1200.c
> @@ -197,10 +197,9 @@ static struct i2c_board_info db1200_i2c_devs[] __initdata = {
>   
>   /**********************************************************************/
>   
> -static void au1200_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
> +static void au1200_nand_cmd_ctrl(struct nand_chip *this, int cmd,
>   				 unsigned int ctrl)
>   {
> -	struct nand_chip *this = mtd_to_nand(mtd);
>   	unsigned long ioaddr = (unsigned long)this->IO_ADDR_W;
>   
>   	ioaddr &= 0xffffff00;
> @@ -220,7 +219,7 @@ static void au1200_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
>   	}
>   }
>   
> -static int au1200_nand_device_ready(struct mtd_info *mtd)
> +static int au1200_nand_device_ready(struct nand_chip *this)
>   {
>   	return alchemy_rdsmem(AU1000_MEM_STSTAT) & 1;
>   }
> diff --git a/arch/mips/alchemy/devboards/db1300.c b/arch/mips/alchemy/devboards/db1300.c
> index efb318e03e0a..1201fa655e78 100644
> --- a/arch/mips/alchemy/devboards/db1300.c
> +++ b/arch/mips/alchemy/devboards/db1300.c
> @@ -149,10 +149,9 @@ static void __init db1300_gpio_config(void)
>   
>   /**********************************************************************/
>   
> -static void au1300_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
> +static void au1300_nand_cmd_ctrl(struct nand_chip *this, int cmd,
>   				 unsigned int ctrl)
>   {
> -	struct nand_chip *this = mtd_to_nand(mtd);
>   	unsigned long ioaddr = (unsigned long)this->IO_ADDR_W;
>   
>   	ioaddr &= 0xffffff00;
> @@ -172,7 +171,7 @@ static void au1300_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
>   	}
>   }
>   
> -static int au1300_nand_device_ready(struct mtd_info *mtd)
> +static int au1300_nand_device_ready(struct nand_chip *this)
>   {
>   	return alchemy_rdsmem(AU1000_MEM_STSTAT) & 1;
>   }
> diff --git a/arch/mips/alchemy/devboards/db1550.c b/arch/mips/alchemy/devboards/db1550.c
> index 7d3dfaa10231..cae39cde5de6 100644
> --- a/arch/mips/alchemy/devboards/db1550.c
> +++ b/arch/mips/alchemy/devboards/db1550.c
> @@ -126,10 +126,9 @@ static struct i2c_board_info db1550_i2c_devs[] __initdata = {
>   
>   /**********************************************************************/
>   
> -static void au1550_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
> +static void au1550_nand_cmd_ctrl(struct nand_chip *this, int cmd,
>   				 unsigned int ctrl)
>   {
> -	struct nand_chip *this = mtd_to_nand(mtd);
>   	unsigned long ioaddr = (unsigned long)this->IO_ADDR_W;
>   
>   	ioaddr &= 0xffffff00;
> @@ -149,7 +148,7 @@ static void au1550_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
>   	}
>   }
>   
> -static int au1550_nand_device_ready(struct mtd_info *mtd)
> +static int au1550_nand_device_ready(struct nand_chip *this)
>   {
>   	return alchemy_rdsmem(AU1000_MEM_STSTAT) & 1;
>   }
> diff --git a/arch/mips/netlogic/xlr/platform-flash.c b/arch/mips/netlogic/xlr/platform-flash.c
> index 4d1b4c003376..4f76b85b44c9 100644
> --- a/arch/mips/netlogic/xlr/platform-flash.c
> +++ b/arch/mips/netlogic/xlr/platform-flash.c
> @@ -92,8 +92,8 @@ struct xlr_nand_flash_priv {
>   
>   static struct xlr_nand_flash_priv nand_priv;
>   
> -static void xlr_nand_ctrl(struct mtd_info *mtd, int cmd,
> -		unsigned int ctrl)
> +static void xlr_nand_ctrl(struct nand_chip *chip, int cmd,
> +			  unsigned int ctrl)
>   {
>   	if (ctrl & NAND_CLE)
>   		nlm_write_reg(nand_priv.flash_mmio,
> diff --git a/arch/mips/pnx833x/common/platform.c b/arch/mips/pnx833x/common/platform.c
> index a7a4e9f5146d..ca8a2889431e 100644
> --- a/arch/mips/pnx833x/common/platform.c
> +++ b/arch/mips/pnx833x/common/platform.c
> @@ -178,9 +178,8 @@ static struct platform_device pnx833x_sata_device = {
>   };
>   
>   static void
> -pnx833x_flash_nand_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
> +pnx833x_flash_nand_cmd_ctrl(struct nand_chip *this, int cmd, unsigned int ctrl)
>   {
> -	struct nand_chip *this = mtd_to_nand(mtd);
>   	unsigned long nandaddr = (unsigned long)this->IO_ADDR_W;
>   
>   	if (cmd == NAND_CMD_NONE)
> diff --git a/arch/mips/rb532/devices.c b/arch/mips/rb532/devices.c
> index 354d258396ff..9173949892ed 100644
> --- a/arch/mips/rb532/devices.c
> +++ b/arch/mips/rb532/devices.c
> @@ -141,14 +141,13 @@ static struct platform_device cf_slot0 = {
>   };
>   
>   /* Resources and device for NAND */
> -static int rb532_dev_ready(struct mtd_info *mtd)
> +static int rb532_dev_ready(struct nand_chip *chip)
>   {
>   	return gpio_get_value(GPIO_RDY);
>   }
>   
> -static void rb532_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
> +static void rb532_cmd_ctrl(struct nand_chip *chip, int cmd, unsigned int ctrl)
>   {
> -	struct nand_chip *chip = mtd_to_nand(mtd);
>   	unsigned char orbits, nandbits;
>   
>   	if (ctrl & NAND_CTRL_CHANGE) {
> diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
> index 3d7d0046cf49..1e16f8a861d3 100644
> --- a/arch/sh/boards/mach-migor/setup.c
> +++ b/arch/sh/boards/mach-migor/setup.c
> @@ -166,11 +166,9 @@ static struct mtd_partition migor_nand_flash_partitions[] = {
>   	},
>   };
>   
> -static void migor_nand_flash_cmd_ctl(struct mtd_info *mtd, int cmd,
> +static void migor_nand_flash_cmd_ctl(struct nand_chip *chip, int cmd,
>   				     unsigned int ctrl)
>   {
> -	struct nand_chip *chip = mtd_to_nand(mtd);
> -
>   	if (cmd == NAND_CMD_NONE)
>   		return;
>   
> @@ -182,7 +180,7 @@ static void migor_nand_flash_cmd_ctl(struct mtd_info *mtd, int cmd,
>   		writeb(cmd, chip->IO_ADDR_W);
>   }
>   
> -static int migor_nand_flash_ready(struct mtd_info *mtd)
> +static int migor_nand_flash_ready(struct nand_chip *chip)
>   {
>   	return gpio_get_value(GPIO_PTA1); /* NAND_RBn */
>   }
> diff --git a/drivers/mtd/nand/raw/plat_nand.c b/drivers/mtd/nand/raw/plat_nand.c
> index 222626df4b96..24f904300c44 100644
> --- a/drivers/mtd/nand/raw/plat_nand.c
> +++ b/drivers/mtd/nand/raw/plat_nand.c
> @@ -23,6 +23,42 @@ struct plat_nand_data {
>   	void __iomem		*io_base;
>   };
>   
> +static void plat_nand_cmd_ctrl(struct mtd_info *mtd, int dat, unsigned int ctrl)
> +{
> +	struct platform_nand_data *pdata = dev_get_platdata(mtd->dev.parent);
> +
> +	pdata->ctrl.cmd_ctrl(mtd_to_nand(mtd), dat, ctrl);
> +}
> +
> +static int plat_nand_dev_ready(struct mtd_info *mtd)
> +{
> +	struct platform_nand_data *pdata = dev_get_platdata(mtd->dev.parent);
> +
> +	return pdata->ctrl.dev_ready(mtd_to_nand(mtd));
> +}
> +
> +static void plat_nand_select_chip(struct mtd_info *mtd, int cs)
> +{
> +	struct platform_nand_data *pdata = dev_get_platdata(mtd->dev.parent);
> +
> +	pdata->ctrl.select_chip(mtd_to_nand(mtd), cs);
> +}
> +
> +static void plat_nand_write_buf(struct mtd_info *mtd, const uint8_t *buf,
> +				int len)
> +{
> +	struct platform_nand_data *pdata = dev_get_platdata(mtd->dev.parent);
> +
> +	pdata->ctrl.write_buf(mtd_to_nand(mtd), buf, len);
> +}
> +
> +static void plat_nand_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
> +{
> +	struct platform_nand_data *pdata = dev_get_platdata(mtd->dev.parent);
> +
> +	pdata->ctrl.read_buf(mtd_to_nand(mtd), buf, len);
> +}
> +
>   /*
>    * Probe for the NAND device.
>    */
> @@ -62,11 +98,22 @@ static int plat_nand_probe(struct platform_device *pdev)
>   
>   	data->chip.IO_ADDR_R = data->io_base;
>   	data->chip.IO_ADDR_W = data->io_base;
> -	data->chip.cmd_ctrl = pdata->ctrl.cmd_ctrl;
> -	data->chip.dev_ready = pdata->ctrl.dev_ready;
> -	data->chip.select_chip = pdata->ctrl.select_chip;
> -	data->chip.write_buf = pdata->ctrl.write_buf;
> -	data->chip.read_buf = pdata->ctrl.read_buf;
> +
> +	if (pdata->ctrl.cmd_ctrl)
> +		data->chip.cmd_ctrl = plat_nand_cmd_ctrl;
> +
> +	if (pdata->ctrl.dev_ready)
> +		data->chip.dev_ready = plat_nand_dev_ready;
> +
> +	if (pdata->ctrl.select_chip)
> +		data->chip.select_chip = plat_nand_select_chip;
> +
> +	if (pdata->ctrl.write_buf)
> +		data->chip.write_buf = plat_nand_write_buf;
> +
> +	if (pdata->ctrl.read_buf)
> +		data->chip.read_buf = plat_nand_read_buf;
> +
>   	data->chip.chip_delay = pdata->chip.chip_delay;
>   	data->chip.options |= pdata->chip.options;
>   	data->chip.bbt_options |= pdata->chip.bbt_options;
> diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> index d155470f53c8..818cdc0a4dbb 100644
> --- a/include/linux/mtd/rawnand.h
> +++ b/include/linux/mtd/rawnand.h
> @@ -1595,11 +1595,11 @@ struct platform_device;
>   struct platform_nand_ctrl {
>   	int (*probe)(struct platform_device *pdev);
>   	void (*remove)(struct platform_device *pdev);
> -	int (*dev_ready)(struct mtd_info *mtd);
> -	void (*select_chip)(struct mtd_info *mtd, int chip);
> -	void (*cmd_ctrl)(struct mtd_info *mtd, int dat, unsigned int ctrl);
> -	void (*write_buf)(struct mtd_info *mtd, const uint8_t *buf, int len);
> -	void (*read_buf)(struct mtd_info *mtd, uint8_t *buf, int len);
> +	int (*dev_ready)(struct nand_chip *chip);
> +	void (*select_chip)(struct nand_chip *chip, int cs);
> +	void (*cmd_ctrl)(struct nand_chip *chip, int dat, unsigned int ctrl);
> +	void (*write_buf)(struct nand_chip *chip, const uint8_t *buf, int len);
> +	void (*read_buf)(struct nand_chip *chip, uint8_t *buf, int len);
>   	void *priv;
>   };
>   
