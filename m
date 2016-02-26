Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Feb 2016 20:46:32 +0100 (CET)
Received: from mail.kmu-office.ch ([178.209.48.109]:59418 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006817AbcBZTq3Hv2z3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Feb 2016 20:46:29 +0100
Received: from webmail.kmu-office.ch (unknown [178.209.48.103])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 4C3505C006D;
        Fri, 26 Feb 2016 20:46:15 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Fri, 26 Feb 2016 11:43:46 -0800
From:   Stefan Agner <stefan@agner.ch>
To:     Boris Brezillon <boris.brezillon@free-electrons.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-mtd@lists.infradead.org, Daniel Mack <daniel@zonque.org>,
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
        bcm-kernel-feedback-list@broadcom.com, linux-api@vger.kernel.org
Subject: Re: [PATCH v3 48/52] mtd: nand: vf610: switch to mtd_ooblayout_ops
In-Reply-To: <1456448280-27788-49-git-send-email-boris.brezillon@free-electrons.com>
References: <1456448280-27788-1-git-send-email-boris.brezillon@free-electrons.com>
 <1456448280-27788-49-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <43666dfa2308e6575d47c76b688174ef@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.1.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim; t=1456515975; bh=u8QN79gMx60/fMkL2PR++yW+NJXygNN6ldL3Fui5Y2w=; h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID; b=Gjtn7ma4OQIg7uEY8vFDYtXBeMN8VHvFLsyzEXIm0QmXgZVw137HzUfsMRVqRH7fP5mXcb7pO5rrn2mT90nRSR1wOM0kvdLYliICs6NkQQE5Fh8E6mPqxQv0ahrfqk4LclUbaTi2xQr1g3vNf5vGwFvCDSfMZtPYdvenuUuVMkQ=
Return-Path: <stefan@agner.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52346
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

On 2016-02-25 16:57, Boris Brezillon wrote:
> Implementing the mtd_ooblayout_ops interface is the new way of exposing
> ECC/OOB layout to MTD users.
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


When I add a printk in nand_ooblayout_free_lp, I get this values:
free offset 2 lenth 62

This seems wrong to me. It seems that nand_ooblayout_free_lp needs steps
to be set to calculate the free bytes correctly. With chip->ecc.steps =
1 the calculated values look good to me.

I quickly tried to run mtd_oobtest.ko test, however that faild:
Kernel BUG at 80399764 [verbose debug info unavailable]
Internal error: Oops - BUG: 0 [#1] ARM
Modules linked in: mtd_oobtest(+)
CPU: 0 PID: 676 Comm: insmod Tainted: G        W      
4.5.0-rc1-00097-g4c60bde-dirty #320
Hardware name: Freescale Vybrid VF5xx/VF6xx (Device Tree)
task: 8db27180 ti: 8ce74000 task.ti: 8ce74000
PC is at nand_fill_oob+0x48/0xac
LR is at mtd_ooblayout_free+0x5c/0x74

mtd_ooblayout_set_databytes seems to return -ERANGE...

Do you know what is going on here?

--
Stefan


> -			chip->ecc.layout = &vf610_nfc_ecc60;
>  		} else if (chip->ecc.strength == 24) {
>  			nfc->ecc_mode = ECC_45_BYTE;
>  			chip->ecc.bytes = 45;
> -			chip->ecc.layout = &vf610_nfc_ecc45;
>  		} else {
>  			dev_err(nfc->dev, "Unsupported ECC strength\n");
>  			err = -ENXIO;
