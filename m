Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Feb 2016 11:46:05 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:33515 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007259AbcB2KqDKUuZE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 Feb 2016 11:46:03 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id DB875536EEBF;
        Mon, 29 Feb 2016 10:45:54 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Mon, 29 Feb 2016 10:45:56 +0000
Received: from [192.168.154.40] (192.168.154.40) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Mon, 29 Feb
 2016 10:45:56 +0000
Subject: Re: [PATCH v3 39/52] mtd: nand: jz4780: switch to mtd_ooblayout_ops
To:     Boris Brezillon <boris.brezillon@free-electrons.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        <linux-mtd@lists.infradead.org>
References: <1456448280-27788-1-git-send-email-boris.brezillon@free-electrons.com>
 <1456448280-27788-40-git-send-email-boris.brezillon@free-electrons.com>
CC:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        "Kukjin Kim" <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>,
        "Nicolas Ferre" <nicolas.ferre@atmel.com>,
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
        <linux-api@vger.kernel.org>
From:   Harvey Hunt <harvey.hunt@imgtec.com>
Message-ID: <56D42164.9030007@imgtec.com>
Date:   Mon, 29 Feb 2016 10:45:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1456448280-27788-40-git-send-email-boris.brezillon@free-electrons.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.40]
Return-Path: <Harvey.Hunt@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52359
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: harvey.hunt@imgtec.com
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

On 26/02/16 00:57, Boris Brezillon wrote:
> Implementing the mtd_ooblayout_ops interface is the new way of exposing
> ECC/OOB layout to MTD users.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>   drivers/mtd/nand/jz4780_nand.c | 19 +++++--------------
>   1 file changed, 5 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mtd/nand/jz4780_nand.c b/drivers/mtd/nand/jz4780_nand.c
> index e1c016c..b86a579 100644
> --- a/drivers/mtd/nand/jz4780_nand.c
> +++ b/drivers/mtd/nand/jz4780_nand.c
> @@ -56,8 +56,6 @@ struct jz4780_nand_chip {
>   	struct nand_chip chip;
>   	struct list_head chip_list;
>
> -	struct nand_ecclayout ecclayout;
> -
>   	struct gpio_desc *busy_gpio;
>   	struct gpio_desc *wp_gpio;
>   	unsigned int reading: 1;
> @@ -165,8 +163,7 @@ static int jz4780_nand_init_ecc(struct jz4780_nand_chip *nand, struct device *de
>   	struct nand_chip *chip = &nand->chip;
>   	struct mtd_info *mtd = nand_to_mtd(chip);
>   	struct jz4780_nand_controller *nfc = to_jz4780_nand_controller(chip->controller);
> -	struct nand_ecclayout *layout = &nand->ecclayout;
> -	u32 start, i;
> +	int eccbytes;
>
>   	chip->ecc.bytes = fls((1 + 8) * chip->ecc.size)	*
>   				(chip->ecc.strength / 8);
> @@ -201,23 +198,17 @@ static int jz4780_nand_init_ecc(struct jz4780_nand_chip *nand, struct device *de
>   		return 0;
>
>   	/* Generate ECC layout. ECC codes are right aligned in the OOB area. */
> -	layout->eccbytes = mtd->writesize / chip->ecc.size * chip->ecc.bytes;
> +	eccbytes = mtd->writesize / chip->ecc.size * chip->ecc.bytes;
>
> -	if (layout->eccbytes > mtd->oobsize - 2) {
> +	if (eccbytes > mtd->oobsize - 2) {
>   		dev_err(dev,
>   			"invalid ECC config: required %d ECC bytes, but only %d are available",
> -			layout->eccbytes, mtd->oobsize - 2);
> +			eccbytes, mtd->oobsize - 2);
>   		return -EINVAL;
>   	}
>
> -	start = mtd->oobsize - layout->eccbytes;
> -	for (i = 0; i < layout->eccbytes; i++)
> -		layout->eccpos[i] = start + i;
> -
> -	layout->oobfree[0].offset = 2;
> -	layout->oobfree[0].length = mtd->oobsize - layout->eccbytes - 2;
> +	mtd->ooblayout = &nand_ooblayout_lp_ops;
>
> -	chip->ecc.layout = layout;
>   	return 0;
>   }
>
>

With your patch applied [0] that you gave me earlier in the patchset, I 
am able to boot to userland on my Ci20 (jz4780_{nand,bch}) with a NAND 
rootfs. So, dependant upon that patch (or equivalent) being added to 
this patchset:

Tested-by: Harvey Hunt <harvey.hunt@imgtec.com>

Thanks,

Harvey

[0] http://code.bulix.org/36oytz-91960
