Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Oct 2016 16:23:40 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:38423 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992328AbcJUOXc5SQbM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Oct 2016 16:23:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject;
        bh=SHDMRUtoRCvCif1abWQXNQIlKa8aDy8HF63K1/jzMPQ=; b=t1QSxB97WU4XKmTFj87sLGs4tk
        +LunxTqsI0qDwc5SZMBpsCMHaAvt6anKLu+nv/YKzKhbhJfoPt5ALnj0PiD9GjdzK4YAUq9mrV+Gh
        JKGunV4mCqcnQbE/phSbbEauL7Kv6CILLn1a+zLrFobdH0vMjHP0lHrfs8TJ7XSqdgY3iErH1A5dS
        lSE1vLeDGed3CnLfTiVi7fWxdxZC3nn9qdI5ls4h5K8mnUpJk6f6hsrKMxsBWnto86TMADMQYBzKC
        t+z4aszymbDAsICy7YVHIaCQFh945GDYxqe2K47myg7AdNAFr2Ctt5BEAAW5muLEbjkfsyd3OsfS/
        M1Xhp/TA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:47040 helo=server.roeck-us.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
        (Exim 4.86_1)
        (envelope-from <linux@roeck-us.net>)
        id 1bxaj9-003uOU-F4; Fri, 21 Oct 2016 14:23:19 +0000
Subject: Re: [PATCH v2.1 1/2] watchdog: loongson1: Add Loongson1 SoC watchdog
 driver
To:     Yang Ling <gnaygnil@gmail.com>, Wim Van Sebroeck <wim@iguana.be>,
        Keguang Zhang <keguang.zhang@gmail.com>
References: <20161021054539.GA6237@ly-pc>
Cc:     linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <74afb2ed-35a3-8c08-5878-5d98b91e19a2@roeck-us.net>
Date:   Fri, 21 Oct 2016 07:23:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20161021054539.GA6237@ly-pc>
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
X-archive-position: 55543
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

On 10/20/2016 10:45 PM, Yang Ling wrote:
> Add watchdog timer specific driver for Loongson1 SoC.
>
> Signed-off-by: Yang Ling <gnaygnil@gmail.com>
>
> ---
> V2.1 from Kelvin Cheung:
>   Use max_hw_heartbeat_ms instead of max_timeout.
> V2:
>   Increase the value of the default heartbeat.
>   Modify the setup process for register.
>   Order include files and Makefile alphabetically.
> V1.1:
>   Add a little debugging information.
> ---
>  drivers/watchdog/Kconfig         |   7 ++
>  drivers/watchdog/Makefile        |   1 +
>  drivers/watchdog/loongson1_wdt.c | 158 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 166 insertions(+)
>  create mode 100644 drivers/watchdog/loongson1_wdt.c
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 50dbaa8..6707d43 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1513,6 +1513,13 @@ config LANTIQ_WDT
>  	help
>  	  Hardware driver for the Lantiq SoC Watchdog Timer.
>
> +config LOONGSON1_WDT
> +	tristate "Loongson1 SoC hardware watchdog"
> +	depends on MACH_LOONGSON32
> +	select WATCHDOG_CORE
> +	help
> +	  Hardware driver for the Loongson1 SoC Watchdog Timer.
> +
>  config RALINK_WDT
>  	tristate "Ralink SoC watchdog"
>  	select WATCHDOG_CORE
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index cba0043..b6a8d70 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -157,6 +157,7 @@ obj-$(CONFIG_TXX9_WDT) += txx9wdt.o
>  obj-$(CONFIG_OCTEON_WDT) += octeon-wdt.o
>  octeon-wdt-y := octeon-wdt-main.o octeon-wdt-nmi.o
>  obj-$(CONFIG_LANTIQ_WDT) += lantiq_wdt.o
> +obj-$(CONFIG_LOONGSON1_WDT) += loongson1_wdt.o
>  obj-$(CONFIG_RALINK_WDT) += rt2880_wdt.o
>  obj-$(CONFIG_IMGPDC_WDT) += imgpdc_wdt.o
>  obj-$(CONFIG_MT7621_WDT) += mt7621_wdt.o
> diff --git a/drivers/watchdog/loongson1_wdt.c b/drivers/watchdog/loongson1_wdt.c
> new file mode 100644
> index 0000000..f885294
> --- /dev/null
> +++ b/drivers/watchdog/loongson1_wdt.c
> @@ -0,0 +1,158 @@
> +/*
> + * Copyright (c) 2016 Yang Ling <gnaygnil@gmail.com>
> + *
> + * This program is free software; you can redistribute	it and/or modify it
> + * under  the terms of	the GNU General	 Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.

Odd spacing.

> + */
> +
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/watchdog.h>
> +#include <loongson1.h>
> +
> +#define DEFAULT_HEARTBEAT	30
> +
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0444);
> +
> +static unsigned int heartbeat = DEFAULT_HEARTBEAT;
> +module_param(heartbeat, uint, 0444);
> +
> +struct ls1x_wdt_drvdata {
> +	void __iomem *base;
> +	struct clk *clk;
> +	unsigned int counts_per_second;
> +	struct watchdog_device wdt;
> +};
> +
> +static int ls1x_wdt_ping(struct watchdog_device *wdt_dev)
> +{
> +	struct ls1x_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
> +
> +	writel(0x1, drvdata->base + WDT_SET);
> +
> +	return 0;
> +}
> +
> +static int ls1x_wdt_set_timeout(struct watchdog_device *wdt_dev,
> +				unsigned int timeout)
> +{
> +	struct ls1x_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
> +	unsigned int counts;
> +
> +	wdt_dev->timeout = min(timeout, wdt_dev->max_hw_heartbeat_ms / 1000);

The point of using max_hw_heartbeat_ms is that the watchdog core takes care of
timeouts larger than the maximum supported by the hardware. What you should do
here is something along the line of

	wdt_dev->timeout = timeout;
	counts = drvdata->counts_per_second * min(timeout, wdt_dev->max_hw_heartbeat_ms / 1000);

> +	counts = drvdata->counts_per_second * wdt_dev->timeout;
> +
> +	writel(counts, drvdata->base + WDT_TIMER);
> +
> +	return 0;
> +}
> +
> +static int ls1x_wdt_start(struct watchdog_device *wdt_dev)
> +{
> +	struct ls1x_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
> +
> +	writel(0x1, drvdata->base + WDT_EN);
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
> +	drvdata->counts_per_second = clk_get_rate(drvdata->clk);

clk_get_rate() can at least in theory return 0,

> +
> +	ls1x_wdt = &drvdata->wdt;
> +	ls1x_wdt->info = &ls1x_wdt_info;
> +	ls1x_wdt->ops = &ls1x_wdt_ops;
> +	ls1x_wdt->min_timeout = 1;
> +	ls1x_wdt->max_hw_heartbeat_ms = U32_MAX / drvdata->counts_per_second *
> +					1000;

which would result in a crash here.

> +	ls1x_wdt->parent = &pdev->dev;
> +
> +	watchdog_init_timeout(ls1x_wdt, heartbeat, &pdev->dev);
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

This should not be necessary. If the watchdog device is open (meaning the
watchdog may be running), you should not be able to unload the driver.
Can you test ?

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
