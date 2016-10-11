Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Oct 2016 16:54:20 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:37016 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992160AbcJKOyL5Dmzo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Oct 2016 16:54:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject;
        bh=e+aHX4Df3HhNs3tKCA2PK9IfoumpF6gC7vyWGUx2ikU=; b=oQumHx2Att/WnQNEyrHzthkzOm
        WYZ6EdYDw0DIK0UWR0G0/iua1Dg/tfYAkIfXlEbaAXwUuY1vhCVwv58faRWCNTCrz1518Zr64UGxF
        mpaxmjrUh3GlwDRk1y3J4HK1cembs3RHM23m9xlVNXWj+4obL66PC6z456XMsmd3FeYzhy0l5zY+X
        eLwVW2no0S1phNGJOhhJsuM5czG53YiQcQfo4GoRLy0uaJ/kLX7IEN357/0VBqvvLHDEQpw8BBePn
        5g5Xqi97Qn7W/KrvzwMjy42OaYF4JEO3vUNFEMVAXS8VLyNBPjvdM+gNKBUK8kieD5EbNi68oXGno
        5wS09R/w==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:34558 helo=server.roeck-us.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
        (Exim 4.86_1)
        (envelope-from <linux@roeck-us.net>)
        id 1btyRN-000Mcm-5M; Tue, 11 Oct 2016 14:54:01 +0000
Subject: Re: [PATCH v1.1 1/2] watchdog: loongson1: Add Loongson1 SoC watchdog
 driver
To:     Yang Ling <gnaygnil@gmail.com>, Wim Van Sebroeck <wim@iguana.be>,
        Keguang Zhang <keguang.zhang@gmail.com>
References: <20161011141029.GA26146@ubuntu>
Cc:     linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <701c5b53-c2b5-88af-1ff7-549edf68d7ae@roeck-us.net>
Date:   Tue, 11 Oct 2016 07:54:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20161011141029.GA26146@ubuntu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated_sender: linux@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: linux@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: linux@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55389
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On 10/11/2016 07:10 AM, Yang Ling wrote:
> Add watchdog timer specific driver for Loongson1 SoC.
>
> Signed-off-by: Yang Ling <gnaygnil@gmail.com>
>
> ---
> V1.1:
>  Add a little debugging information.
> ---
>  drivers/watchdog/Kconfig         |   7 ++
>  drivers/watchdog/Makefile        |   1 +
>  drivers/watchdog/loongson1_wdt.c | 160 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 168 insertions(+)
>  create mode 100644 drivers/watchdog/loongson1_wdt.c
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 50dbaa8..28c44f2 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1553,6 +1553,13 @@ config PIC32_DMT
>  	  To compile this driver as a loadable module, choose M here.
>  	  The module will be called pic32-dmt.
>
> +config LOONGSON1_WDT
> +	tristate "Loongson1 SoC hardware watchdog"
> +	depends on MACH_LOONGSON32
> +	select WATCHDOG_CORE
> +	help
> +	  Hardware driver for the Loongson1 SoC Watchdog Timer.
> +
>  # PARISC Architecture
>
>  # POWERPC Architecture
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index cba0043..bd3b00e 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -162,6 +162,7 @@ obj-$(CONFIG_IMGPDC_WDT) += imgpdc_wdt.o
>  obj-$(CONFIG_MT7621_WDT) += mt7621_wdt.o
>  obj-$(CONFIG_PIC32_WDT) += pic32-wdt.o
>  obj-$(CONFIG_PIC32_DMT) += pic32-dmt.o
> +obj-$(CONFIG_LOONGSON1_WDT) += loongson1_wdt.o
>
>  # PARISC Architecture
>
> diff --git a/drivers/watchdog/loongson1_wdt.c b/drivers/watchdog/loongson1_wdt.c
> new file mode 100644
> index 0000000..77b11f9
> --- /dev/null
> +++ b/drivers/watchdog/loongson1_wdt.c
> @@ -0,0 +1,160 @@
> +/*
> + * Copyright (c) 2016 Yang Ling <gnaygnil@gmail.com>
> + *
> + * This program is free software; you can redistribute	it and/or modify it
> + * under  the terms of	the GNU General	 Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/watchdog.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>
> +
> +#include <loongson1.h>
> +
> +#define MIN_HEARTBEAT		1
> +#define MAX_HEARTBEAT		30
> +#define DEFAULT_HEARTBEAT	10
> +

The limits are pretty low. On many systems such low limits may result
in boot failures if the watchdog is already running at boot.

It might make more sense to determine the maximum timeout dynamically based
on the clock rate, and possibly use max_hw_heartbeat_ms instead of max_timeout
to let the infrastructure handle small maximum timeouts.

Also, if it is possible that the watchdog is already running at boot, it might
be desirable to detect this situation and inform the infrastructure about it
(see WDOG_HW_RUNNING flag).

> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0);
> +
> +static unsigned int heartbeat = DEFAULT_HEARTBEAT;
> +module_param(heartbeat, uint, 0);
> +
> +struct ls1x_wdt_drvdata {
> +	struct watchdog_device wdt;
> +	void __iomem *base;
> +	unsigned int count;
> +	struct clk *clk;
> +};
> +
> +static int ls1x_wdt_ping(struct watchdog_device *wdt_dev)
> +{
> +	struct ls1x_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
> +
> +	writel(0x1, drvdata->base + WDT_EN);

Does this enable the timeout ? If so, does it always have to be called ?
And is it a good idea to call it prior to setting the counter ?

> +	writel(drvdata->count, drvdata->base + WDT_TIMER);

Is this needed for each ping ?

> +	writel(0x1, drvdata->base + WDT_SET);
> +
Or is this the actual ping ?

> +	return 0;
> +}
> +
> +static int ls1x_wdt_set_timeout(struct watchdog_device *wdt_dev,
> +				unsigned int new_timeout)
> +{
> +	struct ls1x_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
> +	int counts_per_second;
> +
> +	if (watchdog_init_timeout(wdt_dev, new_timeout, NULL))
> +		return -EINVAL;

This is supposed to be called from the init function. The set_timeout
is supposed to set the timeout, not to call back the infrastructure.

> +
> +	counts_per_second = clk_get_rate(drvdata->clk);

clk_get_rate() can, at least in theory, return 0.
In general it is better to call it once in the probe function,
validate it, and store the value in the local data structure.

> +	drvdata->count = counts_per_second * wdt_dev->timeout;
> +
> +	ls1x_wdt_ping(wdt_dev);

No. This function can be called with the watchdog stopped.
The infrastructure will call the ping function if needed.

> +
> +	return 0;
> +}
> +
> +static int ls1x_wdt_start(struct watchdog_device *wdt_dev)
> +{
> +	ls1x_wdt_set_timeout(wdt_dev, wdt_dev->timeout);

This function is supposed to start the watchdog, not to set the timeout.

> +
> +	return 0;
> +}
> +
> +static int ls1x_wdt_stop(struct watchdog_device *wdt_dev)
> +{
> +	struct ls1x_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
> +
> +	writel(0x0, drvdata->base + WDT_EN);
> +
> +	return 0;
> +}
> +
> +static const struct watchdog_info ls1x_wdt_info = {
> +	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
> +	.identity = "Loongson1 Watchdog",
> +};
> +
> +static const struct watchdog_ops ls1x_wdt_ops = {
> +	.owner = THIS_MODULE,
> +	.start = ls1x_wdt_start,
> +	.stop = ls1x_wdt_stop,
> +	.ping = ls1x_wdt_ping,
> +	.set_timeout = ls1x_wdt_set_timeout,
> +};
> +
> +static int ls1x_wdt_probe(struct platform_device *pdev)
> +{
> +	struct ls1x_wdt_drvdata *drvdata;
> +	struct watchdog_device *ls1x_wdt;
> +	struct resource *res;
> +	int ret;
> +
> +	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
> +	if (!drvdata)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	drvdata->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(drvdata->base))
> +		return PTR_ERR(drvdata->base);
> +
> +	drvdata->clk = devm_clk_get(&pdev->dev, pdev->name);
> +	if (IS_ERR(drvdata->clk)) {
> +		dev_err(&pdev->dev, "failed to get %s clock\n", pdev->name);
> +		return PTR_ERR(drvdata->clk);
> +	}
> +	clk_prepare_enable(drvdata->clk);
> +
> +	ls1x_wdt = &drvdata->wdt;
> +	ls1x_wdt->info = &ls1x_wdt_info;
> +	ls1x_wdt->ops = &ls1x_wdt_ops;
> +	ls1x_wdt->timeout = heartbeat;
> +	ls1x_wdt->min_timeout = MIN_HEARTBEAT;
> +	ls1x_wdt->max_timeout = MAX_HEARTBEAT;
> +	ls1x_wdt->parent = &pdev->dev;
> +	watchdog_set_nowayout(ls1x_wdt, nowayout);
> +	watchdog_set_drvdata(ls1x_wdt, drvdata);
> +
> +	ret = watchdog_register_device(&drvdata->wdt);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to register watchdog device\n");
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, drvdata);
> +
> +	dev_info(&pdev->dev, "Loongson1 Watchdog driver registered\n");
> +
> +	return 0;
> +}
> +
> +static int ls1x_wdt_remove(struct platform_device *pdev)
> +{
> +	struct ls1x_wdt_drvdata *drvdata = platform_get_drvdata(pdev);
> +
> +	ls1x_wdt_stop(&drvdata->wdt);
> +	watchdog_unregister_device(&drvdata->wdt);
> +	clk_disable_unprepare(drvdata->clk);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver ls1x_wdt_driver = {
> +	.probe = ls1x_wdt_probe,
> +	.remove = ls1x_wdt_remove,
> +	.driver = {
> +		.name = "ls1x-wdt",
> +	},
> +};
> +
> +module_platform_driver(ls1x_wdt_driver);
> +
> +MODULE_AUTHOR("Yang Ling <gnaygnil@gmail.com>");
> +MODULE_DESCRIPTION("Loongson1 Watchdog Driver");
> +MODULE_LICENSE("GPL");
>
