Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Aug 2018 10:30:25 +0200 (CEST)
Received: from mail.kmu-office.ch ([IPv6:2a02:418:6a02::a2]:33076 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992479AbeHRIaURimlT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 18 Aug 2018 10:30:20 +0200
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id D82E05C0160;
        Sat, 18 Aug 2018 10:30:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1534581018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wrzpGBwVdnGSCEPad0HzJWp1P5bASq7vWkSLXVz3Ywo=;
        b=R1oCVBxQ+84IhVvGhIWE7PYu8OJknZBj5ATtL9Y4HUG8TLf+rmW+GdZyJcSRSOBrA8VnWv
        k0TQjeaC+iOke+gA3xrpGr6l9tumNt8STicopKsaht4XZm4bQOdGb/yIh7wVYadoWGKyet
        FENG0aSeqjNlAuuZhkv7MZp/uQHVRn8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Sat, 18 Aug 2018 10:30:13 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org,
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
        Mans Rullgard <mans@mansr.com>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH 08/23] mtd: rawnand: Pass a nand_chip object to
 ecc->read_xxx() hooks
In-Reply-To: <20180817160922.6224-9-boris.brezillon@bootlin.com>
References: <20180817160922.6224-1-boris.brezillon@bootlin.com>
 <20180817160922.6224-9-boris.brezillon@bootlin.com>
Message-ID: <c08c6ecf720cc6b242094246b2f296c3@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Return-Path: <stefan@agner.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65635
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stefan@agner.ch
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

On 17.08.2018 18:09, Boris Brezillon wrote:
> Let's make the raw NAND API consistent by patching all helpers and
> hooks to take a nand_chip object instead of an mtd_info one or
> remove the mtd_info object when both are passed.
> 
> Let's tackle all ecc->read_xxx() hooks at once.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> ---
>  drivers/mtd/nand/raw/atmel/nand-controller.c  | 12 ++---
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c      | 21 ++++----
>  drivers/mtd/nand/raw/cafe_nand.c              | 10 ++--
>  drivers/mtd/nand/raw/denali.c                 | 17 +++---
>  drivers/mtd/nand/raw/docg4.c                  | 20 ++++----
>  drivers/mtd/nand/raw/fsl_elbc_nand.c          |  5 +-
>  drivers/mtd/nand/raw/fsl_ifc_nand.c           |  5 +-
>  drivers/mtd/nand/raw/fsmc_nand.c              |  6 +--
>  drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c    | 23 ++++-----
>  drivers/mtd/nand/raw/hisi504_nand.c           |  9 ++--
>  drivers/mtd/nand/raw/lpc32xx_mlc.c            | 10 ++--
>  drivers/mtd/nand/raw/lpc32xx_slc.c            | 14 ++---
>  drivers/mtd/nand/raw/marvell_nand.c           | 30 +++++------
>  drivers/mtd/nand/raw/mtk_nand.c               | 23 +++++----
>  drivers/mtd/nand/raw/mxc_nand.c               | 11 ++--
>  drivers/mtd/nand/raw/nand_base.c              | 74 +++++++++++++--------------
>  drivers/mtd/nand/raw/nand_micron.c            |  6 +--
>  drivers/mtd/nand/raw/omap2.c                  |  6 +--
>  drivers/mtd/nand/raw/qcom_nandc.c             | 11 ++--
>  drivers/mtd/nand/raw/r852.c                   |  5 +-
>  drivers/mtd/nand/raw/sh_flctl.c               |  6 ++-
>  drivers/mtd/nand/raw/sunxi_nand.c             | 26 +++++-----
>  drivers/mtd/nand/raw/tango_nand.c             | 16 +++---
>  drivers/mtd/nand/raw/tegra_nand.c             | 15 +++---
>  drivers/mtd/nand/raw/vf610_nfc.c              | 18 +++----
>  drivers/staging/mt29f_spinand/mt29f_spinand.c |  5 +-
>  include/linux/mtd/rawnand.h                   | 30 +++++------
>  27 files changed, 216 insertions(+), 218 deletions(-)
> 
[...]
> diff --git a/drivers/mtd/nand/raw/tegra_nand.c
> b/drivers/mtd/nand/raw/tegra_nand.c
> index 5dcee20e2a8c..bcc3a2888c4f 100644
> --- a/drivers/mtd/nand/raw/tegra_nand.c
> +++ b/drivers/mtd/nand/raw/tegra_nand.c
> @@ -615,10 +615,10 @@ static int tegra_nand_page_xfer(struct mtd_info
> *mtd, struct nand_chip *chip,
>  	return ret;
>  }
>  
> -static int tegra_nand_read_page_raw(struct mtd_info *mtd,
> -				    struct nand_chip *chip, u8 *buf,
> +static int tegra_nand_read_page_raw(struct nand_chip *chip, u8 *buf,
>  				    int oob_required, int page)
>  {
> +	struct mtd_info *mtd = nand_to_mtd(chip);
>  	void *oob_buf = oob_required ? chip->oob_poi : NULL;
>  
>  	return tegra_nand_page_xfer(mtd, chip, buf, oob_buf,

Since mtd is only required to pass it to tegra_nand_page_xfer, it would
be better to change tegra_nand_page_xfer to only take chip.

--
Stefan

> @@ -635,9 +635,10 @@ static int tegra_nand_write_page_raw(struct mtd_info *mtd,
>  				     mtd->oobsize, page, false);
>  }
>  
> -static int tegra_nand_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
> -			       int page)
> +static int tegra_nand_read_oob(struct nand_chip *chip, int page)
>  {
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +
>  	return tegra_nand_page_xfer(mtd, chip, NULL, chip->oob_poi,
>  				    mtd->oobsize, page, true);
>  }
> @@ -649,10 +650,10 @@ static int tegra_nand_write_oob(struct mtd_info
> *mtd, struct nand_chip *chip,
>  				    mtd->oobsize, page, false);
>  }
>  
> -static int tegra_nand_read_page_hwecc(struct mtd_info *mtd,
> -				      struct nand_chip *chip, u8 *buf,
> +static int tegra_nand_read_page_hwecc(struct nand_chip *chip, u8 *buf,
>  				      int oob_required, int page)
>  {
> +	struct mtd_info *mtd = nand_to_mtd(chip);
>  	struct tegra_nand_controller *ctrl = to_tegra_ctrl(chip->controller);
>  	struct tegra_nand_chip *nand = to_tegra_chip(chip);
>  	void *oob_buf = oob_required ? chip->oob_poi : NULL;
> @@ -716,7 +717,7 @@ static int tegra_nand_read_page_hwecc(struct mtd_info *mtd,
>  		 * erased or if error correction just failed for all sub-
>  		 * pages.
>  		 */
> -		ret = tegra_nand_read_oob(mtd, chip, page);
> +		ret = tegra_nand_read_oob(chip, page);
>  		if (ret < 0)
>  			return ret;
>  
> diff --git a/drivers/mtd/nand/raw/vf610_nfc.c b/drivers/mtd/nand/raw/vf610_nfc.c
> index a73213c835a5..7cbcc41cea95 100644
> --- a/drivers/mtd/nand/raw/vf610_nfc.c
> +++ b/drivers/mtd/nand/raw/vf610_nfc.c
> @@ -557,9 +557,10 @@ static void vf610_nfc_fill_row(struct nand_chip
> *chip, int page, u32 *code,
>  	}
>  }
>  
> -static int vf610_nfc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
> -				uint8_t *buf, int oob_required, int page)
> +static int vf610_nfc_read_page(struct nand_chip *chip, uint8_t *buf,
> +			       int oob_required, int page)
>  {
> +	struct mtd_info *mtd = nand_to_mtd(chip);
>  	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
>  	int trfr_sz = mtd->writesize + mtd->oobsize;
>  	u32 row = 0, cmd1 = 0, cmd2 = 0, code = 0;
> @@ -643,15 +644,15 @@ static int vf610_nfc_write_page(struct mtd_info
> *mtd, struct nand_chip *chip,
>  	return 0;
>  }
>  
> -static int vf610_nfc_read_page_raw(struct mtd_info *mtd,
> -				   struct nand_chip *chip, u8 *buf,
> +static int vf610_nfc_read_page_raw(struct nand_chip *chip, u8 *buf,
>  				   int oob_required, int page)
>  {
> +	struct mtd_info *mtd = nand_to_mtd(chip);
>  	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
>  	int ret;
>  
>  	nfc->data_access = true;
> -	ret = nand_read_page_raw(mtd, chip, buf, oob_required, page);
> +	ret = nand_read_page_raw(chip, buf, oob_required, page);
>  	nfc->data_access = false;
>  
>  	return ret;
> @@ -677,14 +678,13 @@ static int vf610_nfc_write_page_raw(struct mtd_info *mtd,
>  	return nand_prog_page_end_op(chip);
>  }
>  
> -static int vf610_nfc_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
> -			      int page)
> +static int vf610_nfc_read_oob(struct nand_chip *chip, int page)
>  {
> -	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
> +	struct vf610_nfc *nfc = mtd_to_nfc(nand_to_mtd(chip));
>  	int ret;
>  
>  	nfc->data_access = true;
> -	ret = nand_read_oob_std(mtd, chip, page);
> +	ret = nand_read_oob_std(chip, page);
>  	nfc->data_access = false;
>  
>  	return ret;
> diff --git a/drivers/staging/mt29f_spinand/mt29f_spinand.c
> b/drivers/staging/mt29f_spinand/mt29f_spinand.c
> index b50788b2d1d9..0776d38d4498 100644
> --- a/drivers/staging/mt29f_spinand/mt29f_spinand.c
> +++ b/drivers/staging/mt29f_spinand/mt29f_spinand.c
> @@ -643,14 +643,15 @@ static int spinand_write_page_hwecc(struct mtd_info *mtd,
>  	return nand_prog_page_op(chip, page, 0, p, eccsize * eccsteps);
>  }
>  
> -static int spinand_read_page_hwecc(struct mtd_info *mtd, struct
> nand_chip *chip,
> -				   u8 *buf, int oob_required, int page)
> +static int spinand_read_page_hwecc(struct nand_chip *chip, u8 *buf,
> +				   int oob_required, int page)
>  {
>  	int retval;
>  	u8 status;
>  	u8 *p = buf;
>  	int eccsize = chip->ecc.size;
>  	int eccsteps = chip->ecc.steps;
> +	struct mtd_info *mtd = nand_to_mtd(chip);
>  	struct spinand_info *info = nand_get_controller_data(chip);
>  
>  	enable_read_hw_ecc = 1;
> diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> index 24434310d126..a5f4a585f749 100644
> --- a/include/linux/mtd/rawnand.h
> +++ b/include/linux/mtd/rawnand.h
> @@ -652,14 +652,14 @@ struct nand_ecc_ctrl {
>  			 uint8_t *ecc_code);
>  	int (*correct)(struct nand_chip *chip, uint8_t *dat, uint8_t *read_ecc,
>  		       uint8_t *calc_ecc);
> -	int (*read_page_raw)(struct mtd_info *mtd, struct nand_chip *chip,
> -			uint8_t *buf, int oob_required, int page);
> +	int (*read_page_raw)(struct nand_chip *chip, uint8_t *buf,
> +			     int oob_required, int page);
>  	int (*write_page_raw)(struct mtd_info *mtd, struct nand_chip *chip,
>  			const uint8_t *buf, int oob_required, int page);
> -	int (*read_page)(struct mtd_info *mtd, struct nand_chip *chip,
> -			uint8_t *buf, int oob_required, int page);
> -	int (*read_subpage)(struct mtd_info *mtd, struct nand_chip *chip,
> -			uint32_t offs, uint32_t len, uint8_t *buf, int page);
> +	int (*read_page)(struct nand_chip *chip, uint8_t *buf,
> +			 int oob_required, int page);
> +	int (*read_subpage)(struct nand_chip *chip, uint32_t offs,
> +			    uint32_t len, uint8_t *buf, int page);
>  	int (*write_subpage)(struct mtd_info *mtd, struct nand_chip *chip,
>  			uint32_t offset, uint32_t data_len,
>  			const uint8_t *data_buf, int oob_required, int page);
> @@ -667,9 +667,8 @@ struct nand_ecc_ctrl {
>  			const uint8_t *buf, int oob_required, int page);
>  	int (*write_oob_raw)(struct mtd_info *mtd, struct nand_chip *chip,
>  			int page);
> -	int (*read_oob_raw)(struct mtd_info *mtd, struct nand_chip *chip,
> -			int page);
> -	int (*read_oob)(struct mtd_info *mtd, struct nand_chip *chip, int page);
> +	int (*read_oob_raw)(struct nand_chip *chip, int page);
> +	int (*read_oob)(struct nand_chip *chip, int page);
>  	int (*write_oob)(struct mtd_info *mtd, struct nand_chip *chip,
>  			int page);
>  };
> @@ -1676,11 +1675,10 @@ int nand_write_oob_syndrome(struct mtd_info
> *mtd, struct nand_chip *chip,
>  			    int page);
>  
>  /* Default read_oob implementation */
> -int nand_read_oob_std(struct mtd_info *mtd, struct nand_chip *chip, int page);
> +int nand_read_oob_std(struct nand_chip *chip, int page);
>  
>  /* Default read_oob syndrome implementation */
> -int nand_read_oob_syndrome(struct mtd_info *mtd, struct nand_chip *chip,
> -			   int page);
> +int nand_read_oob_syndrome(struct nand_chip *chip, int page);
>  
>  /* Wrapper to use in order for controllers/vendors to GET/SET FEATURES */
>  int nand_get_features(struct nand_chip *chip, int addr, u8 *subfeature_param);
> @@ -1690,10 +1688,10 @@ int nand_get_set_features_notsupp(struct
> mtd_info *mtd, struct nand_chip *chip,
>  				  int addr, u8 *subfeature_param);
>  
>  /* Default read_page_raw implementation */
> -int nand_read_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
> -		       uint8_t *buf, int oob_required, int page);
> -int nand_read_page_raw_notsupp(struct mtd_info *mtd, struct nand_chip *chip,
> -			       u8 *buf, int oob_required, int page);
> +int nand_read_page_raw(struct nand_chip *chip, uint8_t *buf, int oob_required,
> +		       int page);
> +int nand_read_page_raw_notsupp(struct nand_chip *chip, u8 *buf,
> +			       int oob_required, int page);
>  
>  /* Default write_page_raw implementation */
>  int nand_write_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
