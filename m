Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Jul 2018 17:32:18 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:42663 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993087AbeGGPcKOawyd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 7 Jul 2018 17:32:10 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6DC06207BD; Sat,  7 Jul 2018 17:32:03 +0200 (CEST)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1C2D82072D;
        Sat,  7 Jul 2018 17:32:03 +0200 (CEST)
Date:   Sat, 7 Jul 2018 17:32:03 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 05/27] mtd: rawnand: s3c2410: Allow selection of this
 driver when COMPILE_TEST=y
Message-ID: <20180707173203.2a9eb05f@bbrezillon>
In-Reply-To: <20180705094522.12138-6-boris.brezillon@bootlin.com>
References: <20180705094522.12138-1-boris.brezillon@bootlin.com>
        <20180705094522.12138-6-boris.brezillon@bootlin.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <boris.brezillon@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64706
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: boris.brezillon@bootlin.com
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

On Thu,  5 Jul 2018 11:45:00 +0200
Boris Brezillon <boris.brezillon@bootlin.com> wrote:

> It just makes NAND maintainers' life easier by allowing them to
> compile-test this driver without having ARCH_S3C24XX or ARCH_S3C64XX
> enabled.
> 
> We also need to add a dependency on HAS_IOMEM to make sure the driver
> compiles correctly.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> ---
>  drivers/mtd/nand/raw/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index c6764992cdfc..033900c0c618 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -119,7 +119,8 @@ config MTD_NAND_AU1550
>  
>  config MTD_NAND_S3C2410
>  	tristate "NAND Flash support for Samsung S3C SoCs"
> -	depends on ARCH_S3C24XX || ARCH_S3C64XX
> +	depends on ARCH_S3C24XX || ARCH_S3C64XX || COMPILE_TEST
> +	depends on HAS_IOMEM

Looks like ia64 does not define {read,write}s{b,w,l}() IO accessors.
I'll just add a 'depends on !IA64' on both s3c2410 and orion to
address that.

>  	help
>  	  This enables the NAND flash controller on the S3C24xx and S3C64xx
>  	  SoCs
