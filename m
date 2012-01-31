Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2012 21:19:41 +0100 (CET)
Received: from mail-lpp01m010-f49.google.com ([209.85.215.49]:43323 "EHLO
        mail-lpp01m010-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904023Ab2AaUTf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Jan 2012 21:19:35 +0100
Received: by laam7 with SMTP id m7so291881laa.36
        for <multiple recipients>; Tue, 31 Jan 2012 12:19:29 -0800 (PST)
Received: by 10.152.148.106 with SMTP id tr10mr12126015lab.41.1328041169351;
        Tue, 31 Jan 2012 12:19:29 -0800 (PST)
Received: from localhost (S0106d8b37715ee14.cg.shawcable.net. [68.146.14.168])
        by mx.google.com with ESMTPS id i9sm18029268lbz.3.2012.01.31.12.19.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 31 Jan 2012 12:19:28 -0800 (PST)
Received: by localhost (Postfix, from userid 1000)
        id 968A13E0E86; Tue, 31 Jan 2012 13:19:22 -0700 (MST)
Date:   Tue, 31 Jan 2012 13:19:22 -0700
From:   Grant Likely <grant.likely@secretlab.ca>
To:     Florian Fainelli <florian@openwrt.org>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        spi-devel-general@lists.sourceforge.net,
        Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>
Subject: Re: [PATCH 9/9 v3] spi: add Broadcom BCM63xx SPI controller driver
Message-ID: <20120131201922.GE22611@ponder.secretlab.ca>
References: <1328019048-5892-1-git-send-email-florian@openwrt.org>
 <1328019048-5892-10-git-send-email-florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1328019048-5892-10-git-send-email-florian@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 32376
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, Jan 31, 2012 at 03:10:48PM +0100, Florian Fainelli wrote:
> This patch adds support for the SPI controller found on the Broadcom BCM63xx
> SoCs.
> 
> Signed-off-by: Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> Changes since v2:
> - reworked bcm63xx_spi_setup_transfer to choose closest spi transfer
>   frequency
> - removed invalid 25Mhz frequency
> - fixed some minor checkpatch issues
> 
> Changes since v1:
> - switched to the devm_* API which frees resources automatically
> - switched to dev_pm_ops
> - use module_platform_driver
> - remove MODULE_VERSION()
> - fixed return value when clock is not present using PTR_ERR()
> - fixed probe() error path to disable clock in case of failure
> 
>  drivers/spi/Kconfig       |    6 +
>  drivers/spi/Makefile      |    1 +
>  drivers/spi/spi-bcm63xx.c |  486 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 493 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/spi/spi-bcm63xx.c
> 

Looks okay.  There are a couple of problems that needs to be fixed
below, but otherwise:

Acked-by: Grant Likely <grant.likely@secretlab.ca>

Merge this through the same tree as patches 1-8

g.

> +static int __init bcm63xx_spi_probe(struct platform_device *pdev)

__devinit

> +static int __exit bcm63xx_spi_remove(struct platform_device *pdev)

__devexit

> +static const struct dev_pm_ops bcm63xx_spi_pm_ops = {
> +	.suspend	= bcm63xx_spi_suspend,
> +	.resume		= bcm63xx_spi_resume,
> +};
> +
> +#define BCM63XX_SPI_PM_OPS	(&bcm63xx_spi_pm_ops)
> +#else
> +#define BCM63XX_SPI_PM_OPS	NULL

A bit ugly.  Do this instead in the else clause and drop the BCM63XX_SPI_PM_OPS:

#define bcm63xx_spi_pm_ops NULL

> +#endif
> +
> +static struct platform_driver bcm63xx_spi_driver = {
> +	.driver = {
> +		.name	= "bcm63xx-spi",
> +		.owner	= THIS_MODULE,
> +		.pm	= BCM63XX_SPI_PM_OPS,
> +	},
> +	.probe		= bcm63xx_spi_probe,
> +	.remove		= __exit_p(bcm63xx_spi_remove),

__devexit_p

> +};
> +
> +module_platform_driver(bcm63xx_spi_driver);
> +
> +MODULE_ALIAS("platform:bcm63xx_spi");
> +MODULE_AUTHOR("Florian Fainelli <florian@openwrt.org>");
> +MODULE_AUTHOR("Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>");
> +MODULE_DESCRIPTION("Broadcom BCM63xx SPI Controller driver");
> +MODULE_LICENSE("GPL");
> -- 
> 1.7.5.4
> 
