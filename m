Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Apr 2016 17:28:34 +0200 (CEST)
Received: from eusmtp01.atmel.com ([212.144.249.243]:9722 "EHLO
        eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006955AbcDMP2atlk-5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Apr 2016 17:28:30 +0200
Received: from HNOCHT01.corp.atmel.com (10.161.30.161) by eusmtp01.atmel.com
 (10.161.101.31) with Microsoft SMTP Server (TLS) id 14.3.235.1; Wed, 13 Apr
 2016 17:28:18 +0200
Received: from [10.159.245.112] (10.161.30.18) by HNOCHT01.corp.atmel.com
 (10.161.30.161) with Microsoft SMTP Server (TLS) id 14.3.235.1; Wed, 13 Apr
 2016 17:28:22 +0200
Subject: Re: [PATCH v5 04/50] mtd: nand: atmel: use mtd_ooblayout_xxx()
 helpers where appropriate
To:     Boris Brezillon <boris.brezillon@free-electrons.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        <linux-mtd@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>
References: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459354505-32551-5-git-send-email-boris.brezillon@free-electrons.com>
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
X-Enigmail-Draft-Status: N1110
Organization: atmel
Message-ID: <570E65A7.5000705@atmel.com>
Date:   Wed, 13 Apr 2016 17:28:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1459354505-32551-5-git-send-email-boris.brezillon@free-electrons.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.161.30.18]
Return-Path: <Nicolas.FERRE@atmel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52971
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
> The mtd_ooblayout_xxx() helper functions have been added to avoid direct
> accesses to the ecclayout field, and thus ease for future reworks.
> Use these helpers in all places where the oobfree[] and eccpos[] arrays
> where directly accessed.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/mtd/nand/atmel_nand.c | 48 ++++++++++++++++++++++++++-----------------
>  1 file changed, 29 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
> index 0b5da72..321d331 100644
> --- a/drivers/mtd/nand/atmel_nand.c
> +++ b/drivers/mtd/nand/atmel_nand.c
> @@ -836,13 +836,16 @@ static void pmecc_correct_data(struct mtd_info *mtd, uint8_t *buf, uint8_t *ecc,
>  			dev_dbg(host->dev, "Bit flip in data area, byte_pos: %d, bit_pos: %d, 0x%02x -> 0x%02x\n",
>  				pos, bit_pos, err_byte, *(buf + byte_pos));
>  		} else {
> +			struct mtd_oob_region oobregion;
> +
>  			/* Bit flip in OOB area */
>  			tmp = sector_num * nand_chip->ecc.bytes
>  					+ (byte_pos - sector_size);
>  			err_byte = ecc[tmp];
>  			ecc[tmp] ^= (1 << bit_pos);
>  
> -			pos = tmp + nand_chip->ecc.layout->eccpos[0];
> +			mtd_ooblayout_ecc(mtd, 0, &oobregion);
> +			pos = tmp + oobregion.offset;
>  			dev_dbg(host->dev, "Bit flip in OOB, oob_byte_pos: %d, bit_pos: %d, 0x%02x -> 0x%02x\n",
>  				pos, bit_pos, err_byte, ecc[tmp]);
>  		}
> @@ -934,7 +937,6 @@ static int atmel_nand_pmecc_read_page(struct mtd_info *mtd,
>  	struct atmel_nand_host *host = nand_get_controller_data(chip);
>  	int eccsize = chip->ecc.size * chip->ecc.steps;
>  	uint8_t *oob = chip->oob_poi;
> -	uint32_t *eccpos = chip->ecc.layout->eccpos;
>  	uint32_t stat;
>  	unsigned long end_time;
>  	int bitflips = 0;
> @@ -956,7 +958,11 @@ static int atmel_nand_pmecc_read_page(struct mtd_info *mtd,
>  
>  	stat = pmecc_readl_relaxed(host->ecc, ISR);
>  	if (stat != 0) {
> -		bitflips = pmecc_correction(mtd, stat, buf, &oob[eccpos[0]]);
> +		struct mtd_oob_region oobregion;
> +
> +		mtd_ooblayout_ecc(mtd, 0, &oobregion);
> +		bitflips = pmecc_correction(mtd, stat, buf,
> +					    &oob[oobregion.offset]);
>  		if (bitflips < 0)
>  			/* uncorrectable errors */
>  			return 0;
> @@ -970,8 +976,8 @@ static int atmel_nand_pmecc_write_page(struct mtd_info *mtd,
>  		int page)
>  {
>  	struct atmel_nand_host *host = nand_get_controller_data(chip);
> -	uint32_t *eccpos = chip->ecc.layout->eccpos;
> -	int i, j;
> +	struct mtd_oob_region oobregion = { };
> +	int i, j, section = 0;
>  	unsigned long end_time;
>  
>  	if (!host->nfc || !host->nfc->write_by_sram) {
> @@ -990,11 +996,12 @@ static int atmel_nand_pmecc_write_page(struct mtd_info *mtd,
>  
>  	for (i = 0; i < chip->ecc.steps; i++) {
>  		for (j = 0; j < chip->ecc.bytes; j++) {
> -			int pos;
> +			if (!oobregion.length)
> +				mtd_ooblayout_ecc(mtd, section++, &oobregion);

Here...


>  
> -			pos = i * chip->ecc.bytes + j;
> -			chip->oob_poi[eccpos[pos]] =
> +			chip->oob_poi[oobregion.offset++] =

... and there, are you sure to increment the variable inside the
function call or the table index?

I must say that I don't like it at all.


>  				pmecc_readb_ecc_relaxed(host->ecc, i, j);
> +			oobregion.length--;

Simply do it here, it's so much easier to read and fool proof!


>  		}
>  	}
>  	chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
> @@ -1008,6 +1015,7 @@ static void atmel_pmecc_core_init(struct mtd_info *mtd)
>  	struct atmel_nand_host *host = nand_get_controller_data(nand_chip);
>  	uint32_t val = 0;
>  	struct nand_ecclayout *ecc_layout;
> +	struct mtd_oob_region oobregion;
>  
>  	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_RST);
>  	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DISABLE);
> @@ -1059,9 +1067,10 @@ static void atmel_pmecc_core_init(struct mtd_info *mtd)
>  
>  	ecc_layout = nand_chip->ecc.layout;
>  	pmecc_writel(host->ecc, SAREA, mtd->oobsize - 1);
> -	pmecc_writel(host->ecc, SADDR, ecc_layout->eccpos[0]);
> +	mtd_ooblayout_ecc(mtd, 0, &oobregion);
> +	pmecc_writel(host->ecc, SADDR, oobregion.offset);
>  	pmecc_writel(host->ecc, EADDR,
> -			ecc_layout->eccpos[ecc_layout->eccbytes - 1]);
> +		     oobregion.offset + ecc_layout->eccbytes - 1);
>  	/* See datasheet about PMECC Clock Control Register */
>  	pmecc_writel(host->ecc, CLK, 2);
>  	pmecc_writel(host->ecc, IDR, 0xff);
> @@ -1362,12 +1371,12 @@ static int atmel_nand_read_page(struct mtd_info *mtd, struct nand_chip *chip,
>  {
>  	int eccsize = chip->ecc.size;
>  	int eccbytes = chip->ecc.bytes;
> -	uint32_t *eccpos = chip->ecc.layout->eccpos;
>  	uint8_t *p = buf;
>  	uint8_t *oob = chip->oob_poi;
>  	uint8_t *ecc_pos;
>  	int stat;
>  	unsigned int max_bitflips = 0;
> +	struct mtd_oob_region oobregion = {};
>  
>  	/*
>  	 * Errata: ALE is incorrectly wired up to the ECC controller
> @@ -1385,19 +1394,20 @@ static int atmel_nand_read_page(struct mtd_info *mtd, struct nand_chip *chip,
>  	chip->read_buf(mtd, p, eccsize);
>  
>  	/* move to ECC position if needed */
> -	if (eccpos[0] != 0) {
> -		/* This only works on large pages
> -		 * because the ECC controller waits for
> -		 * NAND_CMD_RNDOUTSTART after the
> -		 * NAND_CMD_RNDOUT.
> -		 * anyway, for small pages, the eccpos[0] == 0
> +	mtd_ooblayout_ecc(mtd, 0, &oobregion);
> +	if (oobregion.offset != 0) {
> +		/*
> +		 * This only works on large pages because the ECC controller
> +		 * waits for NAND_CMD_RNDOUTSTART after the NAND_CMD_RNDOUT.
> +		 * Anyway, for small pages, the first ECC byte is at offset
> +		 * 0 in the OOB area.
>  		 */
>  		chip->cmdfunc(mtd, NAND_CMD_RNDOUT,
> -				mtd->writesize + eccpos[0], -1);
> +			      mtd->writesize + oobregion.offset, -1);
>  	}
>  
>  	/* the ECC controller needs to read the ECC just after the data */
> -	ecc_pos = oob + eccpos[0];
> +	ecc_pos = oob + oobregion.offset;
>  	chip->read_buf(mtd, ecc_pos, eccbytes);
>  
>  	/* check if there's an error */
> 


-- 
Nicolas Ferre
