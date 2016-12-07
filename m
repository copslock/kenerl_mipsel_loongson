Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Dec 2016 11:01:40 +0100 (CET)
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36309 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992285AbcLGKBdOL3Ut (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Dec 2016 11:01:33 +0100
Received: by mail-pf0-f196.google.com with SMTP id c4so20344165pfb.3
        for <linux-mips@linux-mips.org>; Wed, 07 Dec 2016 02:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HYCWwwG0v9baB4otMv0jpC6R5ukbkpft/fX7QrHX2Yo=;
        b=J16YV+a2CCqonKu5SQhFI11dMewrxz7TQ6XyoLAimuqnqVXf4onPGeWhlXWVIzMSTU
         ndlrzU3szU3OrwSmddjWlsYqN2JKfMXnDQk10rVi8kyoOB5qduzq0InIL1JVO9Br0543
         C+l98cZEpLhosdQ20pJlDM6uZ8kn7UOMY64naHCuIPZZV97bqSeH9jtAUK2UkF6L+Nai
         UwCdXIW18hV9obX7YJFX2n12h5Erv9t7XWmGjVrjyPG9jwzfppv97BwhZN7CcfYRB8/T
         TgsD02ExWsepoUcz7rniaU13iwbUvJ9rAi0BzMzOOTiFICsrjoPXsFw97gWNWahNfPpx
         VdxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HYCWwwG0v9baB4otMv0jpC6R5ukbkpft/fX7QrHX2Yo=;
        b=MVI4C7G2kY3AquV7AxqmBR8goPT0izTxipxD+S8GQ7RTmvoTuyBzXHtzyB0TSU931x
         zs+FlhgI2KkY6ZQKH1apSkaHIE2SMXwzmgsD3prIGpP0Z0UyS6QGMQnfl3WhPkSWJXfv
         cYhU7Ph2h2G0cCK+dRHKk0efuGmPCecRZZl2R9k3dQxaM8lxzFb547ZXLOS877k/gvP+
         ocbmg8oi+ydUOVjOIRErGuJkYcAhXdGtQeUyMcpK+y04rIhpvVLlLK0pxbmCYfeJczTE
         kLdwZnlfYemiurvrIpZvdqixwUiRRYSyy8PAlY784y8RI6aj8jkVdEJ4VsH5z+o1+wPM
         Eg3A==
X-Gm-Message-State: AKaTC02uBcfsm0bEsD/RiQkENKM415IAaV120rhkECEBHSfPvcgeW9ff/ffxEF3VfIASFg==
X-Received: by 10.99.228.5 with SMTP id a5mr121393629pgi.1.1481104887081;
        Wed, 07 Dec 2016 02:01:27 -0800 (PST)
Received: from ly-pc ([114.221.237.78])
        by smtp.gmail.com with ESMTPSA id r1sm41146642pfg.56.2016.12.07.02.01.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 07 Dec 2016 02:01:25 -0800 (PST)
From:   Yang Ling <gnaygnil@gmail.com>
X-Google-Original-From: Yang Ling <gnaygnail@gmail.com>
Date:   Wed, 7 Dec 2016 18:01:18 +0800
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Yang Ling <gnaygnil@gmail.com>, wim@iguana.be,
        keguang.zhang@gmail.com, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v2.4 2/3] watchdog: loongson1: Add Loongson1 SoC watchdog
 driver
Message-ID: <20161207100118.GA14343@ly-pc>
References: <20161205150053.GA12931@ubuntu>
 <20161206000501.GA5964@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161206000501.GA5964@roeck-us.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <gnaygnil@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55954
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gnaygnil@gmail.com
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

On Mon, Dec 05, 2016 at 04:05:01PM -0800, Guenter Roeck wrote:
> On Mon, Dec 05, 2016 at 11:00:53PM +0800, Yang Ling wrote:
> > Add watchdog timer specific driver for Loongson1 SoC.
> > 
> > Signed-off-by: Yang Ling <gnaygnil@gmail.com>
> > 
> > ---
> > V2.4:
> >   Set DEFAULT_HEARTBEAT to 0.
> > V2.3:
> >   Set DEFAULT_HEARTBEAT value to ls1x_wdt->timeout.
> > V2.2:
> >   Remove the wide character.
> >   Check the return value for clk_get_rate().
> > V2.1 from Kelvin Cheung:
> >   Use max_hw_heartbeat_ms instead of max_timeout.
> > V2.0:
> >   Increase the value of the default heartbeat.
> >   Modify the setup process for register.
> >   Order include files and Makefile alphabetically.
> > V1.1:
> >   Add a little debugging information.
> > ---
> >  drivers/watchdog/Kconfig         |   7 ++
> >  drivers/watchdog/Makefile        |   1 +
> >  drivers/watchdog/loongson1_wdt.c | 170 +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 178 insertions(+)
> >  create mode 100644 drivers/watchdog/loongson1_wdt.c
> > 
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > index fdd3228..c5b9c6e 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -1513,6 +1513,13 @@ config LANTIQ_WDT
> >  	help
> >  	  Hardware driver for the Lantiq SoC Watchdog Timer.
> >  
> > +config LOONGSON1_WDT
> > +	tristate "Loongson1 SoC hardware watchdog"
> > +	depends on MACH_LOONGSON32
> > +	select WATCHDOG_CORE
> > +	help
> > +	  Hardware driver for the Loongson1 SoC Watchdog Timer.
> > +
> >  config RALINK_WDT
> >  	tristate "Ralink SoC watchdog"
> >  	select WATCHDOG_CORE
> > diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> > index caa9f4a..0c3d35e 100644
> > --- a/drivers/watchdog/Makefile
> > +++ b/drivers/watchdog/Makefile
> > @@ -163,6 +163,7 @@ obj-$(CONFIG_TXX9_WDT) += txx9wdt.o
> >  obj-$(CONFIG_OCTEON_WDT) += octeon-wdt.o
> >  octeon-wdt-y := octeon-wdt-main.o octeon-wdt-nmi.o
> >  obj-$(CONFIG_LANTIQ_WDT) += lantiq_wdt.o
> > +obj-$(CONFIG_LOONGSON1_WDT) += loongson1_wdt.o
> >  obj-$(CONFIG_RALINK_WDT) += rt2880_wdt.o
> >  obj-$(CONFIG_IMGPDC_WDT) += imgpdc_wdt.o
> >  obj-$(CONFIG_MT7621_WDT) += mt7621_wdt.o
> > diff --git a/drivers/watchdog/loongson1_wdt.c b/drivers/watchdog/loongson1_wdt.c
> > new file mode 100644
> > index 0000000..1c75bda
> > --- /dev/null
> > +++ b/drivers/watchdog/loongson1_wdt.c
> > @@ -0,0 +1,170 @@
> > +/*
> > + * Copyright (c) 2016 Yang Ling <gnaygnil@gmail.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify it
> > + * under the terms of the GNU General Public License as published by the
> > + * Free Software Foundation; either version 2 of the License, or (at your
> > + * option) any later version.
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/watchdog.h>
> > +#include <loongson1.h>
> > +
> > +#define DEFAULT_HEARTBEAT	0
> > +
> 
> This is not what I said or meant, and quite pointless.
> 
> > +static bool nowayout = WATCHDOG_NOWAYOUT;
> > +module_param(nowayout, bool, 0444);
> > +
> > +static unsigned int heartbeat = DEFAULT_HEARTBEAT;
> 
> What I said and meant was that this variable should be initialized with 0,
> ie just be declared as
> 
> static unsigned int heartbeat;
> 
> Guenter
> 
Hi Guenter,

I'm sorry I made a mistake about your intentions.

> > +module_param(heartbeat, uint, 0444);
> > +
> > +struct ls1x_wdt_drvdata {
> > +	void __iomem *base;
> > +	struct clk *clk;
> > +	unsigned long clk_rate;
> > +	struct watchdog_device wdt;
> > +};
> > +
> > +static int ls1x_wdt_ping(struct watchdog_device *wdt_dev)
> > +{
> > +	struct ls1x_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
> > +
> > +	writel(0x1, drvdata->base + WDT_SET);
> > +
> > +	return 0;
> > +}
> > +
> > +static int ls1x_wdt_set_timeout(struct watchdog_device *wdt_dev,
> > +				unsigned int timeout)
> > +{
> > +	struct ls1x_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
> > +	unsigned int max_hw_heartbeat = wdt_dev->max_hw_heartbeat_ms / 1000;
> > +	unsigned int counts;
> > +
> > +	wdt_dev->timeout = timeout;
> > +
> > +	counts = drvdata->clk_rate * min(timeout, max_hw_heartbeat);
> > +	writel(counts, drvdata->base + WDT_TIMER);
> > +
> > +	return 0;
> > +}
> > +
> > +static int ls1x_wdt_start(struct watchdog_device *wdt_dev)
> > +{
> > +	struct ls1x_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
> > +
> > +	writel(0x1, drvdata->base + WDT_EN);
> > +
> > +	return 0;
> > +}
> > +
> > +static int ls1x_wdt_stop(struct watchdog_device *wdt_dev)
> > +{
> > +	struct ls1x_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
> > +
> > +	writel(0x0, drvdata->base + WDT_EN);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct watchdog_info ls1x_wdt_info = {
> > +	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
> > +	.identity = "Loongson1 Watchdog",
> > +};
> > +
> > +static const struct watchdog_ops ls1x_wdt_ops = {
> > +	.owner = THIS_MODULE,
> > +	.start = ls1x_wdt_start,
> > +	.stop = ls1x_wdt_stop,
> > +	.ping = ls1x_wdt_ping,
> > +	.set_timeout = ls1x_wdt_set_timeout,
> > +};
> > +
> > +static int ls1x_wdt_probe(struct platform_device *pdev)
> > +{
> > +	struct ls1x_wdt_drvdata *drvdata;
> > +	struct watchdog_device *ls1x_wdt;
> > +	unsigned long clk_rate;
> > +	struct resource *res;
> > +	int err;
> > +
> > +	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
> > +	if (!drvdata)
> > +		return -ENOMEM;
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	drvdata->base = devm_ioremap_resource(&pdev->dev, res);
> > +	if (IS_ERR(drvdata->base))
> > +		return PTR_ERR(drvdata->base);
> > +
> > +	drvdata->clk = devm_clk_get(&pdev->dev, pdev->name);
> > +	if (IS_ERR(drvdata->clk))
> > +		return PTR_ERR(drvdata->clk);
> > +
> > +	err = clk_prepare_enable(drvdata->clk);
> > +	if (err) {
> > +		dev_err(&pdev->dev, "clk enable failed\n");
> > +		return err;
> > +	}
> > +
> > +	clk_rate = clk_get_rate(drvdata->clk);
> > +	if (!clk_rate) {
> > +		err = -EINVAL;
> > +		goto err0;
> > +	}
> > +	drvdata->clk_rate = clk_rate;
> > +
> > +	ls1x_wdt = &drvdata->wdt;
> > +	ls1x_wdt->info = &ls1x_wdt_info;
> > +	ls1x_wdt->ops = &ls1x_wdt_ops;
> > +	ls1x_wdt->timeout = DEFAULT_HEARTBEAT;
> > +	ls1x_wdt->min_timeout = 1;
> > +	ls1x_wdt->max_hw_heartbeat_ms = U32_MAX / clk_rate * 1000;
> > +	ls1x_wdt->parent = &pdev->dev;
> > +
> > +	watchdog_init_timeout(ls1x_wdt, heartbeat, &pdev->dev);
> > +	watchdog_set_nowayout(ls1x_wdt, nowayout);
> > +	watchdog_set_drvdata(ls1x_wdt, drvdata);
> > +
> > +	err = watchdog_register_device(&drvdata->wdt);
> > +	if (err) {
> > +		dev_err(&pdev->dev, "failed to register watchdog device\n");
> > +		goto err0;
> > +	}
> > +
> > +	platform_set_drvdata(pdev, drvdata);
> > +
> > +	dev_info(&pdev->dev, "Loongson1 Watchdog driver registered\n");
> > +
> > +	return 0;
> > +err0:
> > +	clk_disable_unprepare(drvdata->clk);
> > +	return err;
> > +}
> > +
> > +static int ls1x_wdt_remove(struct platform_device *pdev)
> > +{
> > +	struct ls1x_wdt_drvdata *drvdata = platform_get_drvdata(pdev);
> > +
> > +	watchdog_unregister_device(&drvdata->wdt);
> > +	clk_disable_unprepare(drvdata->clk);
> > +
> > +	return 0;
> > +}
> > +
> > +static struct platform_driver ls1x_wdt_driver = {
> > +	.probe = ls1x_wdt_probe,
> > +	.remove = ls1x_wdt_remove,
> > +	.driver = {
> > +		.name = "ls1x-wdt",
> > +	},
> > +};
> > +
> > +module_platform_driver(ls1x_wdt_driver);
> > +
> > +MODULE_AUTHOR("Yang Ling <gnaygnil@gmail.com>");
> > +MODULE_DESCRIPTION("Loongson1 Watchdog Driver");
> > +MODULE_LICENSE("GPL");
> > -- 
> > 1.9.1
> > 
