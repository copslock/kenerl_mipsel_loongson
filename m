Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Feb 2007 13:52:49 +0000 (GMT)
Received: from e36.co.us.ibm.com ([32.97.110.154]:12472 "EHLO
	e36.co.us.ibm.com") by ftp.linux-mips.org with ESMTP
	id S20038542AbXBHNwo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Feb 2007 13:52:44 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l18DnQxY027225
	for <linux-mips@linux-mips.org>; Thu, 8 Feb 2007 08:49:26 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id l18DnQ9Z527924
	for <linux-mips@linux-mips.org>; Thu, 8 Feb 2007 06:49:26 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l18DnQKd026151
	for <linux-mips@linux-mips.org>; Thu, 8 Feb 2007 06:49:26 -0700
Received: from [9.67.123.9] (wecm-9-67-123-9.wecm.ibm.com [9.67.123.9])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id l18DnOMO026084;
	Thu, 8 Feb 2007 06:49:25 -0700
Subject: Re: [PATCH] eXcite nand flash driver
From:	Josh Boyer <jwboyer@linux.vnet.ibm.com>
To:	Thomas Koeller <thomas.koeller@baslerweb.com>
Cc:	linux-mtd@lists.infradead.org, linux-mips@linux-mips.org
In-Reply-To: <200702080157.25432.thomas.koeller@baslerweb.com>
References: <200702080157.25432.thomas.koeller@baslerweb.com>
Content-Type: text/plain
Date:	Thu, 08 Feb 2007 07:50:27 -0600
Message-Id: <1170942627.4884.89.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Return-Path: <jwboyer@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13986
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jwboyer@linux.vnet.ibm.com
Precedence: bulk
X-list: linux-mips

On Thu, 2007-02-08 at 01:57 +0100, Thomas Koeller wrote:
> 
> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> index 358f55a..5b50396 100644
> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -216,10 +216,26 @@ config MTD_NAND_DISKONCHIP_BBTWRITE
>  	  Even if you leave this disabled, you can enable BBT writes at module
>  	  load time (assuming you build diskonchip as a module) with the module
>  	  parameter "inftl_bbt_write=1".
> -
> +	  
>  config MTD_NAND_SHARPSL
>  	tristate "Support for NAND Flash on Sharp SL Series (C7xx + others)"
>  	depends on MTD_NAND && ARCH_PXA
> + 
> +config MTD_NAND_BASLER_EXCITE
> +	tristate  "Support for NAND Flash on Basler eXcite"
> +	depends on MTD_NAND && BASLER_EXCITE
> +	help
> +          This enables the driver for the NAND flash device found on the
> +          Basler eXcite Smart Camera. If built as a module, the driver
> +	  will be named "excite_nandflash.ko".
> +
> +config MTD_NAND_BASLER_EXCITE
> +	tristate  "Support for NAND Flash on Basler eXcite"
> +	depends on MTD_NAND && BASLER_EXCITE
> +	help
> +          This enables the driver for the NAND flash device found on the
> +          Basler eXcite Smart Camera. If built as a module, the driver
> +	  will be named "excite_nandflash.ko".

You have the same config option twice...  Cut and paste error?

> diff --git a/drivers/mtd/nand/excite_nandflash.c 
> b/drivers/mtd/nand/excite_nandflash.c
> new file mode 100644
> index 0000000..d683659
> --- /dev/null
> +++ b/drivers/mtd/nand/excite_nandflash.c

<snip>

> +
> +#define io_readb(__a__)		__raw_readb((__a__))
> +#define io_writeb(__v__, __a__)	__raw_writeb((__v__), (__a__))

Do you really need these defines?  Why can't you call
__raw_{readb,writeb} directly?

> +
> +typedef void __iomem *io_reg_t;

Ugh... typdef?

<snip>

> +static inline io_reg_t
> +excite_nand_map_regs(struct platform_device *d, const char *basename)
> +{
> +	void *result = NULL;
> +	const struct resource *const r =
> +	    excite_nand_get_resource(d, IORESOURCE_MEM, basename);
> +	if (likely(r))
> +		result = ioremap_nocache(r->start, r->end + 1 - r->start);

Does this likely really buy you anything?  I would think doing the
converse (if any sort of *likely at all) would be better.

<snip>

> + */
> +static int __exit excite_nand_remove(struct device *dev)
> +{
> +	struct excite_nand_drvdata * const this = dev_get_drvdata(dev);
> +
> +	dev_set_drvdata(dev, NULL);
> +
> +	if (unlikely(!this)) {
> +		printk(KERN_ERR "%s: called %s without private data!!",
> +		       module_id, __func__);
> +		return -EINVAL;
> +	}
> +
> +	/* first thing we need to do is release our mtd
> +	 * then go through freeing the resource used
> +	 */
> +	nand_release(&this->board_mtd);
> +
> +	/* free the common resources */
> +	if (likely(this->regs)) {
> +		iounmap(this->regs);
> +		this->regs = NULL;
> +	}

Same likely usage comment as above.

josh
