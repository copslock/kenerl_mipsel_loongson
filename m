Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Apr 2016 17:15:46 +0200 (CEST)
Received: from eusmtp01.atmel.com ([212.144.249.242]:3657 "EHLO
        eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006955AbcDMPPmetZGK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Apr 2016 17:15:42 +0200
Received: from HNOCHT01.corp.atmel.com (10.161.30.161) by eusmtp01.atmel.com
 (10.161.101.30) with Microsoft SMTP Server (TLS) id 14.3.235.1; Wed, 13 Apr
 2016 17:15:32 +0200
Received: from [10.159.245.112] (10.161.30.18) by HNOCHT01.corp.atmel.com
 (10.161.30.161) with Microsoft SMTP Server (TLS) id 14.3.235.1; Wed, 13 Apr
 2016 17:15:35 +0200
Subject: Re: [PATCH v5 22/50] mtd: nand: atmel: switch to mtd_ooblayout_ops
To:     Boris Brezillon <boris.brezillon@free-electrons.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        <linux-mtd@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>
References: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459354505-32551-23-git-send-email-boris.brezillon@free-electrons.com>
CC:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        "Kukjin Kim" <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>,
        Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Wenyou Yang <wenyou.yang@atmel.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, <linux-sunxi@googlegroups.com>,
        Stefan Agner <stefan@agner.ch>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        "punnaiah choudary kalluri" <punnaia@xilinx.com>,
        Priit Laes <plaes@plaes.org>,
        "Kamal Dasu" <kdasu.kdev@gmail.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-api@vger.kernel.org>, Harvey Hunt <harvey.hunt@imgtec.com>,
        "Archit Taneja" <architt@codeaurora.org>,
        Han Xu <b45815@freescale.com>,
        Huang Shijie <shijie.huang@arm.com>
From:   Nicolas Ferre <nicolas.ferre@atmel.com>
Organization: atmel
Message-ID: <570E62A9.5020204@atmel.com>
Date:   Wed, 13 Apr 2016 17:15:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1459354505-32551-23-git-send-email-boris.brezillon@free-electrons.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.161.30.18]
Return-Path: <Nicolas.FERRE@atmel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52970
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nicolas.ferre@atmel.com
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

Le 30/03/2016 18:14, Boris Brezillon a écrit :
> Implementing the mtd_ooblayout_ops interface is the new way of exposing
> ECC/OOB layout to MTD users.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

It seems good:
Reviewed-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Bye,


> ---
>  drivers/mtd/nand/atmel_nand.c | 84 ++++++++++++++++++++-----------------------
>  1 file changed, 38 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
> index 321d331..46a601e 100644
> --- a/drivers/mtd/nand/atmel_nand.c
> +++ b/drivers/mtd/nand/atmel_nand.c
> @@ -72,30 +72,44 @@ struct atmel_nand_nfc_caps {
>  	uint32_t rb_mask;
>  };
>  
> -/* oob layout for large page size
> +/*
> + * oob layout for large page size
>   * bad block info is on bytes 0 and 1
>   * the bytes have to be consecutives to avoid
>   * several NAND_CMD_RNDOUT during read
> - */
> -static struct nand_ecclayout atmel_oobinfo_large = {
> -	.eccbytes = 4,
> -	.eccpos = {60, 61, 62, 63},
> -	.oobfree = {
> -		{2, 58}
> -	},
> -};
> -
> -/* oob layout for small page size
> + *
> + * oob layout for small page size
>   * bad block info is on bytes 4 and 5
>   * the bytes have to be consecutives to avoid
>   * several NAND_CMD_RNDOUT during read
>   */
> -static struct nand_ecclayout atmel_oobinfo_small = {
> -	.eccbytes = 4,
> -	.eccpos = {0, 1, 2, 3},
> -	.oobfree = {
> -		{6, 10}
> -	},
> +static int atmel_ooblayout_ecc_sp(struct mtd_info *mtd, int section,
> +				  struct mtd_oob_region *oobregion)
> +{
> +	if (section)
> +		return -ERANGE;
> +
> +	oobregion->length = 4;
> +	oobregion->offset = 0;
> +
> +	return 0;
> +}
> +
> +static int atmel_ooblayout_free_sp(struct mtd_info *mtd, int section,
> +				   struct mtd_oob_region *oobregion)
> +{
> +	if (section)
> +		return -ERANGE;
> +
> +	oobregion->offset = 6;
> +	oobregion->length = mtd->oobsize - oobregion->offset;
> +
> +	return 0;
> +}
> +
> +static const struct mtd_ooblayout_ops atmel_ooblayout_sp_ops = {
> +	.ecc = atmel_ooblayout_ecc_sp,
> +	.free = atmel_ooblayout_free_sp,
>  };
>  
>  struct atmel_nfc {
> @@ -163,8 +177,6 @@ struct atmel_nand_host {
>  	int			*pmecc_delta;
>  };
>  
> -static struct nand_ecclayout atmel_pmecc_oobinfo;
> -
>  /*
>   * Enable NAND.
>   */
> @@ -483,22 +495,6 @@ static int pmecc_get_ecc_bytes(int cap, int sector_size)
>  	return (m * cap + 7) / 8;
>  }
>  
> -static void pmecc_config_ecc_layout(struct nand_ecclayout *layout,
> -				    int oobsize, int ecc_len)
> -{
> -	int i;
> -
> -	layout->eccbytes = ecc_len;
> -
> -	/* ECC will occupy the last ecc_len bytes continuously */
> -	for (i = 0; i < ecc_len; i++)
> -		layout->eccpos[i] = oobsize - ecc_len + i;
> -
> -	layout->oobfree[0].offset = PMECC_OOB_RESERVED_BYTES;
> -	layout->oobfree[0].length =
> -		oobsize - ecc_len - layout->oobfree[0].offset;
> -}
> -
>  static void __iomem *pmecc_get_alpha_to(struct atmel_nand_host *host)
>  {
>  	int table_size;
> @@ -1013,8 +1009,8 @@ static void atmel_pmecc_core_init(struct mtd_info *mtd)
>  {
>  	struct nand_chip *nand_chip = mtd_to_nand(mtd);
>  	struct atmel_nand_host *host = nand_get_controller_data(nand_chip);
> +	int eccbytes = mtd_ooblayout_count_eccbytes(mtd);
>  	uint32_t val = 0;
> -	struct nand_ecclayout *ecc_layout;
>  	struct mtd_oob_region oobregion;
>  
>  	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_RST);
> @@ -1065,12 +1061,11 @@ static void atmel_pmecc_core_init(struct mtd_info *mtd)
>  		| PMECC_CFG_AUTO_DISABLE);
>  	pmecc_writel(host->ecc, CFG, val);
>  
> -	ecc_layout = nand_chip->ecc.layout;
>  	pmecc_writel(host->ecc, SAREA, mtd->oobsize - 1);
>  	mtd_ooblayout_ecc(mtd, 0, &oobregion);
>  	pmecc_writel(host->ecc, SADDR, oobregion.offset);
>  	pmecc_writel(host->ecc, EADDR,
> -		     oobregion.offset + ecc_layout->eccbytes - 1);
> +		     oobregion.offset + eccbytes - 1);
>  	/* See datasheet about PMECC Clock Control Register */
>  	pmecc_writel(host->ecc, CLK, 2);
>  	pmecc_writel(host->ecc, IDR, 0xff);
> @@ -1292,11 +1287,8 @@ static int atmel_pmecc_nand_init_params(struct platform_device *pdev,
>  			err_no = -EINVAL;
>  			goto err;
>  		}
> -		pmecc_config_ecc_layout(&atmel_pmecc_oobinfo,
> -					mtd->oobsize,
> -					nand_chip->ecc.total);
>  
> -		nand_chip->ecc.layout = &atmel_pmecc_oobinfo;
> +		mtd_set_ooblayout(mtd, &nand_ooblayout_lp_ops);
>  		break;
>  	default:
>  		dev_warn(host->dev,
> @@ -1644,19 +1636,19 @@ static int atmel_hw_nand_init_params(struct platform_device *pdev,
>  	/* set ECC page size and oob layout */
>  	switch (mtd->writesize) {
>  	case 512:
> -		nand_chip->ecc.layout = &atmel_oobinfo_small;
> +		mtd_set_ooblayout(mtd, &atmel_ooblayout_sp_ops);
>  		ecc_writel(host->ecc, MR, ATMEL_ECC_PAGESIZE_528);
>  		break;
>  	case 1024:
> -		nand_chip->ecc.layout = &atmel_oobinfo_large;
> +		mtd_set_ooblayout(mtd, &nand_ooblayout_lp_ops);
>  		ecc_writel(host->ecc, MR, ATMEL_ECC_PAGESIZE_1056);
>  		break;
>  	case 2048:
> -		nand_chip->ecc.layout = &atmel_oobinfo_large;
> +		mtd_set_ooblayout(mtd, &nand_ooblayout_lp_ops);
>  		ecc_writel(host->ecc, MR, ATMEL_ECC_PAGESIZE_2112);
>  		break;
>  	case 4096:
> -		nand_chip->ecc.layout = &atmel_oobinfo_large;
> +		mtd_set_ooblayout(mtd, &nand_ooblayout_lp_ops);
>  		ecc_writel(host->ecc, MR, ATMEL_ECC_PAGESIZE_4224);
>  		break;
>  	default:
> 


-- 
Nicolas Ferre
