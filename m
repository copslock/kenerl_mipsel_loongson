Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2012 22:20:56 +0100 (CET)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:37180 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904026Ab2AaVUt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Jan 2012 22:20:49 +0100
Received: by wgbdr13 with SMTP id dr13so443416wgb.24
        for <multiple recipients>; Tue, 31 Jan 2012 13:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        bh=HAcCWEKPy3nNvFOQ1mhSrgWxkMS1GJGbJ6W7FwCTfpI=;
        b=WAUwzCM4QEHRgppnzdOz9KGUq6Y5nC3tbkRbapYIDLN6EZxWDYC/vlSTv7XhydGa3H
         +/btrtYMd9KbrBedboQaWSPQYF+nKGXrrAYX1i4jyBiv0X7lwoeLfHiuVLSIj5iPGQC1
         l+uv7TenSA0JizF2mks4DHMgnY+jhJQZt+n48=
Received: by 10.180.19.97 with SMTP id d1mr37420614wie.12.1328044844474;
        Tue, 31 Jan 2012 13:20:44 -0800 (PST)
Received: from bender.localnet ([2a01:e35:2f70:4010:22cf:30ff:fe38:5254])
        by mx.google.com with ESMTPS id t15sm40083478wiv.6.2012.01.31.13.20.42
        (version=SSLv3 cipher=OTHER);
        Tue, 31 Jan 2012 13:20:43 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 9/9 v3] spi: add Broadcom BCM63xx SPI controller driver
Date:   Tue, 31 Jan 2012 22:20:41 +0100
User-Agent: KMail/1.13.6 (Linux/2.6.38-9-generic; KDE/4.6.5; x86_64; ; )
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        spi-devel-general@lists.sourceforge.net,
        Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>
References: <1328019048-5892-1-git-send-email-florian@openwrt.org> <1328019048-5892-10-git-send-email-florian@openwrt.org> <20120131201922.GE22611@ponder.secretlab.ca>
In-Reply-To: <20120131201922.GE22611@ponder.secretlab.ca>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201201312220.41561.florian@openwrt.org>
X-archive-position: 32378
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello Grant,

On Tuesday 31 January 2012 21:19:22 Grant Likely wrote:
> On Tue, Jan 31, 2012 at 03:10:48PM +0100, Florian Fainelli wrote:
> > This patch adds support for the SPI controller found on the Broadcom
> > BCM63xx SoCs.
> > 
> > Signed-off-by: Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>
> > Signed-off-by: Florian Fainelli <florian@openwrt.org>
> > ---
> > Changes since v2:
> > - reworked bcm63xx_spi_setup_transfer to choose closest spi transfer
> > 
> >   frequency
> > 
> > - removed invalid 25Mhz frequency
> > - fixed some minor checkpatch issues
> > 
> > Changes since v1:
> > - switched to the devm_* API which frees resources automatically
> > - switched to dev_pm_ops
> > - use module_platform_driver
> > - remove MODULE_VERSION()
> > - fixed return value when clock is not present using PTR_ERR()
> > - fixed probe() error path to disable clock in case of failure
> > 
> >  drivers/spi/Kconfig       |    6 +
> >  drivers/spi/Makefile      |    1 +
> >  drivers/spi/spi-bcm63xx.c |  486
> >  +++++++++++++++++++++++++++++++++++++++++++++ 3 files changed, 493
> >  insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/spi/spi-bcm63xx.c
> 
> Looks okay.  There are a couple of problems that needs to be fixed
> below, but otherwise:
> 
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> 
> Merge this through the same tree as patches 1-8
> 
> g.
> 
> > +static int __init bcm63xx_spi_probe(struct platform_device *pdev)
> 
> __devinit
> 
> > +static int __exit bcm63xx_spi_remove(struct platform_device *pdev)
> 
> __devexit
> 
> > +static const struct dev_pm_ops bcm63xx_spi_pm_ops = {
> > +	.suspend	= bcm63xx_spi_suspend,
> > +	.resume		= bcm63xx_spi_resume,
> > +};
> > +
> > +#define BCM63XX_SPI_PM_OPS	(&bcm63xx_spi_pm_ops)
> > +#else
> > +#define BCM63XX_SPI_PM_OPS	NULL
> 
> A bit ugly.  Do this instead in the else clause and drop the
> BCM63XX_SPI_PM_OPS:
> 
> #define bcm63xx_spi_pm_ops NULL

This won't work, because driver.pm must be set to a pointer to a struct 
dev_pm_ops, that's why I used this trick to make it build fine in both cases. 
If I follow your advice, with driver.pm = &bcm63xx_spi_pm_ops, it won't build 
for CONFIG_PM=n.

> 
> > +#endif
> > +
> > +static struct platform_driver bcm63xx_spi_driver = {
> > +	.driver = {
> > +		.name	= "bcm63xx-spi",
> > +		.owner	= THIS_MODULE,
> > +		.pm	= BCM63XX_SPI_PM_OPS,
> > +	},
> > +	.probe		= bcm63xx_spi_probe,
> > +	.remove		= __exit_p(bcm63xx_spi_remove),
> 
> __devexit_p
> 
> > +};
> > +
> > +module_platform_driver(bcm63xx_spi_driver);
> > +
> > +MODULE_ALIAS("platform:bcm63xx_spi");
> > +MODULE_AUTHOR("Florian Fainelli <florian@openwrt.org>");
> > +MODULE_AUTHOR("Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>");
> > +MODULE_DESCRIPTION("Broadcom BCM63xx SPI Controller driver");
> > +MODULE_LICENSE("GPL");

-- 
Florian
