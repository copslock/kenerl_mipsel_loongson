Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Jul 2018 15:06:48 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:50616 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992747AbeGHNGivz9Hm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 8 Jul 2018 15:06:38 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 615C120737; Sun,  8 Jul 2018 15:06:30 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 15F14203B4;
        Sun,  8 Jul 2018 15:06:30 +0200 (CEST)
Date:   Sun, 8 Jul 2018 15:06:30 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 17/27] mtd: rawnand: fsmc: Allow selection of this
 driver when COMPILE_TEST=y
Message-ID: <20180708150630.06367498@bbrezillon>
In-Reply-To: <20180705094522.12138-18-boris.brezillon@bootlin.com>
References: <20180705094522.12138-1-boris.brezillon@bootlin.com>
        <20180705094522.12138-18-boris.brezillon@bootlin.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <boris.brezillon@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64707
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

On Thu,  5 Jul 2018 11:45:12 +0200
Boris Brezillon <boris.brezillon@bootlin.com> wrote:

> It just makes NAND maintainers' life easier by allowing them to
> compile-test this driver without having PLAT_SPEAR, ARCH_NOMADIK,
> ARCH_U8500 or MACH_U300 enabled.
> 
> We also need to add a dependency on HAS_IOMEM to make sure the driver
> compiles correctly.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> ---
>  drivers/mtd/nand/raw/Kconfig | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index b89bd94a654c..245f1b56b94f 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -502,8 +502,9 @@ config MTD_NAND_JZ4780
>  
>  config MTD_NAND_FSMC
>  	tristate "Support for NAND on ST Micros FSMC"
> -	depends on OF
> -	depends on PLAT_SPEAR || ARCH_NOMADIK || ARCH_U8500 || MACH_U300
> +	depends on OF && HAS_IOMEM
> +	depends on PLAT_SPEAR || ARCH_NOMADIK || ARCH_U8500 || MACH_U300 || \
> +		   COMPILE_TEST

Looks like we have a conflict on the PC definition when compiling a
MIPS kernel. I'll add a patch suffixing PC with FSMC_ to avoid that.
Please don't apply this patch yet. 

>  	help
>  	  Enables support for NAND Flash chips on the ST Microelectronics
>  	  Flexible Static Memory Controller (FSMC)
