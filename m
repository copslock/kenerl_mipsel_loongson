Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Apr 2016 18:41:18 +0200 (CEST)
Received: from mail.kmu-office.ch ([178.209.48.109]:57905 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007002AbcDAQlOr5BWx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Apr 2016 18:41:14 +0200
Received: from webmail.kmu-office.ch (unknown [178.209.48.103])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 99C465C156E;
        Fri,  1 Apr 2016 18:40:07 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Fri, 01 Apr 2016 09:38:04 -0700
From:   Stefan Agner <stefan@agner.ch>
To:     Boris Brezillon <boris.brezillon@free-electrons.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Wenyou Yang <wenyou.yang@atmel.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        punnaiah choudary kalluri <punnaia@xilinx.com>,
        Priit Laes <plaes@plaes.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-api@vger.kernel.org,
        Harvey Hunt <harvey.hunt@imgtec.com>,
        Archit Taneja <architt@codeaurora.org>,
        Han Xu <b45815@freescale.com>,
        Huang Shijie <shijie.huang@arm.com>
Subject: Re: [PATCH v5 45/50] mtd: nand: vf610: switch to mtd_ooblayout_ops
In-Reply-To: <1459354505-32551-46-git-send-email-boris.brezillon@free-electrons.com>
References: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459354505-32551-46-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <93c11b0392cdbcd64c3760e8fe7f6549@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.1.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim; t=1459528807; bh=vCA/xnLjXp2/1QyP8hYSCaKLXUdFgCQ0IoRWpqYQC1c=; h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID; b=m09yssKGg8DwTctCpWWYq6JLSuK96sbZvs18OzBzD3F6trCLd+FXcIQUwA5y33gK9TxaVdA6eKjVqWrYJJICEfyq5KosgaAZ2vg9b9tiduQSJ5IyGv8fUevblZhOTHJXlKYR8JlT1pPx8eW03P0ZJjRBxhYGbCI32ZB2qBzyiwo=
Return-Path: <stefan@agner.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52834
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

On 2016-03-30 09:15, Boris Brezillon wrote:
> Implementing the mtd_ooblayout_ops interface is the new way of exposing
> ECC/OOB layout to MTD users.

I think I sent this already in the last revision:

Tested-by: Stefan Agner <stefan@agner.ch>
Acked-by: Stefan Agner <stefan@agner.ch>

--
Stefan

> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/mtd/nand/vf610_nfc.c | 34 ++++------------------------------
>  1 file changed, 4 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/mtd/nand/vf610_nfc.c b/drivers/mtd/nand/vf610_nfc.c
> index 293feb1..da34de1 100644
> --- a/drivers/mtd/nand/vf610_nfc.c
> +++ b/drivers/mtd/nand/vf610_nfc.c
> @@ -175,34 +175,6 @@ static inline struct vf610_nfc *mtd_to_nfc(struct
> mtd_info *mtd)
>  	return container_of(mtd_to_nand(mtd), struct vf610_nfc, chip);
>  }
>  
> -static struct nand_ecclayout vf610_nfc_ecc45 = {
> -	.eccbytes = 45,
> -	.eccpos = {19, 20, 21, 22, 23,
> -		   24, 25, 26, 27, 28, 29, 30, 31,
> -		   32, 33, 34, 35, 36, 37, 38, 39,
> -		   40, 41, 42, 43, 44, 45, 46, 47,
> -		   48, 49, 50, 51, 52, 53, 54, 55,
> -		   56, 57, 58, 59, 60, 61, 62, 63},
> -	.oobfree = {
> -		{.offset = 2,
> -		 .length = 17} }
> -};
> -
> -static struct nand_ecclayout vf610_nfc_ecc60 = {
> -	.eccbytes = 60,
> -	.eccpos = { 4,  5,  6,  7,  8,  9, 10, 11,
> -		   12, 13, 14, 15, 16, 17, 18, 19,
> -		   20, 21, 22, 23, 24, 25, 26, 27,
> -		   28, 29, 30, 31, 32, 33, 34, 35,
> -		   36, 37, 38, 39, 40, 41, 42, 43,
> -		   44, 45, 46, 47, 48, 49, 50, 51,
> -		   52, 53, 54, 55, 56, 57, 58, 59,
> -		   60, 61, 62, 63 },
> -	.oobfree = {
> -		{.offset = 2,
> -		 .length = 2} }
> -};
> -
>  static inline u32 vf610_nfc_read(struct vf610_nfc *nfc, uint reg)
>  {
>  	return readl(nfc->regs + reg);
> @@ -781,14 +753,16 @@ static int vf610_nfc_probe(struct platform_device *pdev)
>  		if (mtd->oobsize > 64)
>  			mtd->oobsize = 64;
>  
> +		/*
> +		 * mtd->ecclayout is not specified here because we're using the
> +		 * default large page ECC layout defined in NAND core.
> +		 */
>  		if (chip->ecc.strength == 32) {
>  			nfc->ecc_mode = ECC_60_BYTE;
>  			chip->ecc.bytes = 60;
> -			chip->ecc.layout = &vf610_nfc_ecc60;
>  		} else if (chip->ecc.strength == 24) {
>  			nfc->ecc_mode = ECC_45_BYTE;
>  			chip->ecc.bytes = 45;
> -			chip->ecc.layout = &vf610_nfc_ecc45;
>  		} else {
>  			dev_err(nfc->dev, "Unsupported ECC strength\n");
>  			err = -ENXIO;
