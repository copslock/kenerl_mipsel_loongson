Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Dec 2016 15:00:19 +0100 (CET)
Received: from mail-pf0-f196.google.com ([209.85.192.196]:32779 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993066AbcLDOAMRe2ie (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 4 Dec 2016 15:00:12 +0100
Received: by mail-pf0-f196.google.com with SMTP id 144so15794822pfv.0
        for <linux-mips@linux-mips.org>; Sun, 04 Dec 2016 06:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PNCy+Ag2PkLsS9MTKMOzonioCLUDuqb/52+4wsk88n0=;
        b=kXWpXEgaltEgsydqECCwrwQqPzYJv7JAq05s+Kb25hghz1MwyA/eg1gRoeIfkPR9KP
         EJAPJ7vsk6LlrwC65SNW0DApF9TFC2mDz4MtpT8mC8GDp53vDkxsOrXodl+qcGbsECvI
         Usac4APqi7xn1g5IaFdkAuBOKE/TxDX5kGnD/ajgSRSay3/SipvgHrzYgJPpMRq8RT1l
         Ha1P395bT4vHbSlwY1nnOhU9tZup2POH2xTkAjYTZe45bpU9L+l8UoFl3H9aOaDXEDcI
         v0h82WcmAh6uq2PzavfrW8tnHQcd7KDs1SopoaUxx1Bju5cROCgqCQefZo7S1RfTEB+R
         EMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PNCy+Ag2PkLsS9MTKMOzonioCLUDuqb/52+4wsk88n0=;
        b=K2g61jDXiFoaolvkqDHEoS7Snvh6HIspRMkD9rQxudcUMa9xKr+6P8EPmBD6GE3MH+
         x6F30ESDD/1NkWzBYZBqKUNGks8ip8pC7CxX6Jfbsz6i2LjGQpD8wY0IipQaVI9nokJv
         +mowWE3kP41qBgM5T6KmwHGCSOERY0D6rx4W3fiH4Oy6G3psgwTGR3VKjwC4NJVZe46j
         laGtO6159ZGu98aqdrtdhkGojJcMPq8wkglvOwh112qbE6lDOE7PtgmqYJ/zUXuko3Hy
         xUAQsS1qX/TpEYEomfWDf8KKzHMeZI4/Fs/81WR+1CE4v3AlfBBisYKiUK5CdFkfxuWW
         fJ0Q==
X-Gm-Message-State: AKaTC01hIWh91Lr642dow8O2hbx3V53w40ArdwSLJbKXToIIm6ea4OixGFkPHCUt547aDw==
X-Received: by 10.98.29.205 with SMTP id d196mr53239871pfd.111.1480860005990;
        Sun, 04 Dec 2016 06:00:05 -0800 (PST)
Received: from ubuntu ([180.102.121.189])
        by smtp.gmail.com with ESMTPSA id o68sm20616351pfb.42.2016.12.04.06.00.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 04 Dec 2016 06:00:05 -0800 (PST)
From:   Yang Ling <gnaygnil@gmail.com>
X-Google-Original-From: Yang Ling <gnaygnail@gmail.com>
Date:   Sun, 4 Dec 2016 21:59:54 +0800
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Yang Ling <gnaygnil@gmail.com>, Wim Van Sebroeck <wim@iguana.be>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [v2.1,1/2] watchdog: loongson1: Add Loongson1 SoC watchdog driver
Message-ID: <20161204135954.GA28818@ubuntu>
References: <20161021054539.GA6237@ly-pc>
 <20161124160558.GA31064@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161124160558.GA31064@roeck-us.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <gnaygnil@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55935
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

On Thu, Nov 24, 2016 at 08:05:58AM -0800, Guenter Roeck wrote:
> On Fri, Oct 21, 2016 at 01:45:39PM +0800, Yang Ling wrote:
> > Add watchdog timer specific driver for Loongson1 SoC.
> > 
> > Signed-off-by: Yang Ling <gnaygnil@gmail.com>
> 
> First of all, sorry for the late reply. I'll try to do better next time.
> 
> > ---
> > V2.1 from Kelvin Cheung:
> >   Use max_hw_heartbeat_ms instead of max_timeout.
> > V2:
> >   Increase the value of the default heartbeat.
> >   Modify the setup process for register.
> >   Order include files and Makefile alphabetically.
> > V1.1:
> >   Add a little debugging information.
> > ---
> >  drivers/watchdog/Kconfig         |   7 ++
> >  drivers/watchdog/Makefile        |   1 +
> >  drivers/watchdog/loongson1_wdt.c | 158 +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 166 insertions(+)
> >  create mode 100644 drivers/watchdog/loongson1_wdt.c
> > 
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > index 50dbaa8..6707d43 100644
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
> > index cba0043..b6a8d70 100644
> > --- a/drivers/watchdog/Makefile
> > +++ b/drivers/watchdog/Makefile
> > @@ -157,6 +157,7 @@ obj-$(CONFIG_TXX9_WDT) += txx9wdt.o
> >  obj-$(CONFIG_OCTEON_WDT) += octeon-wdt.o
> >  octeon-wdt-y := octeon-wdt-main.o octeon-wdt-nmi.o
> >  obj-$(CONFIG_LANTIQ_WDT) += lantiq_wdt.o
> > +obj-$(CONFIG_LOONGSON1_WDT) += loongson1_wdt.o
> >  obj-$(CONFIG_RALINK_WDT) += rt2880_wdt.o
> >  obj-$(CONFIG_IMGPDC_WDT) += imgpdc_wdt.o
> >  obj-$(CONFIG_MT7621_WDT) += mt7621_wdt.o
> > diff --git a/drivers/watchdog/loongson1_wdt.c b/drivers/watchdog/loongson1_wdt.c
> > new file mode 100644
> > index 0000000..f885294
> > --- /dev/null
> > +++ b/drivers/watchdog/loongson1_wdt.c
> > @@ -0,0 +1,158 @@
> > +/*
> > + * Copyright (c) 2016 Yang Ling <gnaygnil@gmail.com>
> > + *
> > + * This program is free software; you can redistribute	it and/or modify it
> > + * under  the terms of	the GNU General	 Public License as published by the
> > + * Free Software Foundation;  either version 2 of the  License, or (at your
> > + * option) any later version.
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/watchdog.h>
> > +#include <loongson1.h>
> > +
> > +#define DEFAULT_HEARTBEAT	30
> > +
> > +static bool nowayout = WATCHDOG_NOWAYOUT;
> > +module_param(nowayout, bool, 0444);
> > +
> > +static unsigned int heartbeat = DEFAULT_HEARTBEAT;
> > +module_param(heartbeat, uint, 0444);
> > +
> > +struct ls1x_wdt_drvdata {
> > +	void __iomem *base;
> > +	struct clk *clk;
> > +	unsigned int counts_per_second;
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
> > +	unsigned int counts;
> > +
> > +	wdt_dev->timeout = min(timeout, wdt_dev->max_hw_heartbeat_ms / 1000);
> 
> wdt_dev->timeout needs to be set to the 'soft' timeout. The hardware timeout,
> if needed, needs to be saved internally (in struct ls1x_wdt_drvdata).
> Not that it is needed here, though - the value is not used elsewhere in the
> driver. So you can do something like
> 
> 	wdt->timeout = timeout;
> 	timeout = min(timeout, wdt_dev->max_hw_heartbeat_ms / 1000);
> 	counts = drvdata->counts_per_second * timeout;
> 
> > +	counts = drvdata->counts_per_second * wdt_dev->timeout;
> > +
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
> > +	struct resource *res;
> > +	int ret;
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
> > +	if (IS_ERR(drvdata->clk)) {
> > +		dev_err(&pdev->dev, "failed to get %s clock\n", pdev->name);
> 
> devm_clk_get() can return -EPROBE_DEFER, in which case you would not want
> an error message.
> 
> > +		return PTR_ERR(drvdata->clk);
> > +	}
> > +	clk_prepare_enable(drvdata->clk);
> > +
> > +	drvdata->counts_per_second = clk_get_rate(drvdata->clk);
> 
> clk_get_rate() can at least in theory return 0.
> 
> > +
> > +	ls1x_wdt = &drvdata->wdt;
> > +	ls1x_wdt->info = &ls1x_wdt_info;
> > +	ls1x_wdt->ops = &ls1x_wdt_ops;
> > +	ls1x_wdt->min_timeout = 1;
> > +	ls1x_wdt->max_hw_heartbeat_ms = U32_MAX / drvdata->counts_per_second *
> > +					1000;
> > +	ls1x_wdt->parent = &pdev->dev;
> > +
> > +	watchdog_init_timeout(ls1x_wdt, heartbeat, &pdev->dev);
> 
> This has little practical effect. Problem is two-fold. First, the default
> heartbeat is not pre-set in ls1x_wdt. This means if the user specifies
> heartbeat=0 as module parameter, the timeout will be set to 0. Second,
> since heartbeat is -re-initialized, watchdog_init_timeout() will never fall
> back to devicetree data to initialize the timeout (maybe that doesn't matter
> for this architecture).
> 
> In general it is better to set the default module parameter value to 0
> and initialize the timeout together with min_timeout and max_hw_heartbeat_ms.
> 
> static unsigned int heartbeat;
> ...
> ls1x_wdt->timeout = DEFAULT_HEARTBEAT;
> ...
> watchdog_init_timeout(ls1x_wdt, heartbeat, &pdev->dev);
> 
> > +	watchdog_set_nowayout(ls1x_wdt, nowayout);
> > +	watchdog_set_drvdata(ls1x_wdt, drvdata);
> > +
> > +	ret = watchdog_register_device(&drvdata->wdt);
> > +	if (ret < 0) {
> > +		dev_err(&pdev->dev, "failed to register watchdog device\n");
> > +		return ret;
> > +	}
> > +
> > +	platform_set_drvdata(pdev, drvdata);
> > +
> > +	dev_info(&pdev->dev, "Loongson1 Watchdog driver registered\n");
> > +
> > +	return 0;
> > +}
> > +
> > +static int ls1x_wdt_remove(struct platform_device *pdev)
> > +{
> > +	struct ls1x_wdt_drvdata *drvdata = platform_get_drvdata(pdev);
> > +
> > +	ls1x_wdt_stop(&drvdata->wdt);
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

Hi Guenter,

These will be fix in next release.

Thanks for your friendly reminder.
