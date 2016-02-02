Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Feb 2016 04:27:13 +0100 (CET)
Received: from bh-25.webhostbox.net ([208.91.199.152]:38575 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006587AbcBBD1KwSmzQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Feb 2016 04:27:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject;
        bh=54KZ3oHcKKPt2RGCJbylxL3rEiCfpamc+56Zc8gb0Pg=; b=FPgLLmzEXxwaPdvOaWA3UDGQsK
        p5vT6jvY3zRKRNTyrPpZNewkwSLCLMCqkqnT++OOUHhBgW0Emo2Pjcvhlc4TrkzZ5WbxaZoS+d3jN
        Ir9j0oisw4IMXuF0sn8kgyUbkwCJqJiGGIOUjFVH1q+K92jpUAR3EsVwuLTF3L82P5cWDpIUwDMNh
        3VjWdEfOvYS59B0rSGeau6ueRatiLsEvGXS8k7hAM7z67JjK+OwZoWaaDLkTOtwR68fTmbxwSpMns
        FwoLTG8Sf3uV1Mq5TNwiqFuzArb+EDawQBlwjuH5JMVUB8+xq92q3RwXqEGCh2k4PoHk3XaRPE6mO
        2hxTB7FA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:43942 helo=server.roeck-us.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
        (Exim 4.86)
        (envelope-from <linux@roeck-us.net>)
        id 1aQRcN-001oYo-SD; Tue, 02 Feb 2016 03:27:04 +0000
Subject: Re: [PATCH 2/2] watchdog: pic32-wdt: Add PIC32 watchdog driver
To:     Joshua Henderson <joshua.henderson@microchip.com>,
        linux-kernel@vger.kernel.org
References: <1454371381-25160-1-git-send-email-joshua.henderson@microchip.com>
 <1454371381-25160-2-git-send-email-joshua.henderson@microchip.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Purna Chandra Mandal <purna.mandal@microchip.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <56B02206.2000002@roeck-us.net>
Date:   Mon, 1 Feb 2016 19:27:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1454371381-25160-2-git-send-email-joshua.henderson@microchip.com>
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
X-archive-position: 51614
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

On 02/01/2016 04:02 PM, Joshua Henderson wrote:
> When enabled, the watchdog peripheral can be used to reset the device if the
> WDT is not cleared periodically in software.

Commit description is a bit long.

>
> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
> Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: <linux-mips@linux-mips.org>
> ---
> Note: Please merge this patch series through the MIPS tree.
> ---
>   drivers/watchdog/Kconfig     |   14 ++
>   drivers/watchdog/Makefile    |    1 +
>   drivers/watchdog/pic32-wdt.c |  301 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 316 insertions(+)
>   create mode 100644 drivers/watchdog/pic32-wdt.c
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 4f0e7be..131abc2 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1410,6 +1410,20 @@ config MT7621_WDT
>   	help
>   	  Hardware driver for the Mediatek/Ralink MT7621/8 SoC Watchdog Timer.
>
> +config PIC32_WDT
> +	tristate "Microchip PIC32 hardware watchdog"
> +	select WATCHDOG_CORE
> +	depends on MACH_PIC32
> +	default y

Sure you want "y" here ?

> +	help
> +	  Watchdog driver for the built in watchdog hardware in a PIC32.
> +
> +	  Configuration bits must be set appropriately for the watchdog to be
> +	  controlled by this driver.
> +
> +	  To compile this driver as a loadable module, choose M here.
> +	  The module will be called pic32-wdt.
> +
>   # PARISC Architecture
>
>   # POWERPC Architecture
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index f566753..244ed80 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -153,6 +153,7 @@ obj-$(CONFIG_LANTIQ_WDT) += lantiq_wdt.o
>   obj-$(CONFIG_RALINK_WDT) += rt2880_wdt.o
>   obj-$(CONFIG_IMGPDC_WDT) += imgpdc_wdt.o
>   obj-$(CONFIG_MT7621_WDT) += mt7621_wdt.o
> +obj-$(CONFIG_PIC32_WDT) += pic32-wdt.o
>
>   # PARISC Architecture
>
> diff --git a/drivers/watchdog/pic32-wdt.c b/drivers/watchdog/pic32-wdt.c
> new file mode 100644
> index 0000000..d80e62d
> --- /dev/null
> +++ b/drivers/watchdog/pic32-wdt.c
> @@ -0,0 +1,301 @@
> +/*
> + * PIC32 watchdog driver
> + *
> + * Joshua Henderson <joshua.henderson@microchip.com>
> + * Copyright (c) 2016, Microchip Technology Inc.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/pm.h>
> +#include <linux/watchdog.h>
> +#include <linux/spinlock.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>

Alphabetic order, please.

> +
> +#include <asm/mach-pic32/pic32.h>
> +
> +/* Watchdog Timer Registers */
> +#define WDTCON_REG		0x00
> +
> +/* Watchdog Timer Control Register fields */
> +#define WDTCON_WIN_EN		0x0001
> +#define WDTCON_RMCS_MASK	0x0003
> +#define WDTCON_RMCS_SHIFT	0x0006
> +#define WDTCON_RMPS_MASK	0x001F
> +#define WDTCON_RMPS_SHIFT	0x0008
> +#define WDTCON_ON		0x8000
> +#define WDTCON_CLR_KEY		0x5743
> +
> +/* Reset Control Register fields for watchdog */
> +#define RESETCON_TIMEOUT_IDLE	0x0004
> +#define RESETCON_TIMEOUT_SLEEP	0x0008
> +#define RESETCON_WDT_TIMEOUT	0x0010
> +

Can you use BIT() to make it easier to understand which values are bit masks ?

> +struct pic32_wdt {
> +	spinlock_t	lock;
> +	void __iomem	*regs;
> +	void __iomem	*rst_base;
> +	struct clk	*clk;
> +	unsigned long	next_heartbeat;
> +	unsigned long	timeout;
> +};
> +
> +static inline int wdt_is_enabled(struct pic32_wdt *wdt)
> +{
> +	return readl(wdt->regs + WDTCON_REG) & WDTCON_ON;
> +}

Return bool.

> +
> +static inline int wdt_is_win_enabled(struct pic32_wdt *wdt)
> +{

Return bool.

> +	u32 v;
> +
> +	v = readl(wdt->regs + WDTCON_REG);
> +	v &= WDTCON_WIN_EN;
> +
> +	return v;

	return readl(wdt->regs + WDTCON_REG) & WDTCON_WIN_EN;

would be good enough and be more consistent with the other
function above.

> +}
> +
> +static inline void wdt_enable(struct pic32_wdt *wdt)
> +{
> +	writel(WDTCON_ON, PIC32_SET(wdt->regs + WDTCON_REG));
> +}
> +

Can you use consistent function name prefixes ?

> +static inline void wdt_disable(struct pic32_wdt *wdt)
> +{
> +	writel(WDTCON_ON, PIC32_CLR(wdt->regs + WDTCON_REG));
> +	cpu_relax();

Is this needed ?

> +}
> +
> +static inline u32 wdt_get_post_scaler(struct pic32_wdt *wdt)
> +{
> +	u32 v = readl(wdt->regs + WDTCON_REG);
> +
> +	return (v >> WDTCON_RMPS_SHIFT) & WDTCON_RMPS_MASK;
> +}
> +
> +static inline u32 wdt_get_clk_id(struct pic32_wdt *wdt)
> +{
> +	u32 v = readl(wdt->regs + WDTCON_REG);
> +
> +	return (v >> WDTCON_RMCS_SHIFT) & WDTCON_RMCS_MASK;
> +}
> +
> +static inline void wdt_keepalive(struct pic32_wdt *wdt)
> +{
> +	/* write key through single half-word */
> +	writew(WDTCON_CLR_KEY, wdt->regs + WDTCON_REG + 2);
> +}
> +
> +static int pic32_wdt_bootstatus(struct pic32_wdt *wdt)
> +{
> +	u32 v = readl(wdt->rst_base);
> +
> +	writel(RESETCON_WDT_TIMEOUT, PIC32_CLR(wdt->rst_base));
> +
> +	return v & RESETCON_WDT_TIMEOUT;
> +}
> +
> +static int pic32_wdt_get_timeout_secs(struct pic32_wdt *wdt)
> +{
> +	unsigned long rate;
> +	u32 period, ps, terminal;
> +
> +	rate = clk_get_rate(wdt->clk);
> +	pr_debug("wdt: clk_id %d, clk_rate %lu (prescale)\n",
> +		 wdt_get_clk_id(wdt), rate);
> +
> +	/* default, prescaler of 32 (i.e. div-by-32) is implicit. */
> +	rate >>= 5;
> +
> +	/* calculate terminal count from postscaler. */
> +	ps = wdt_get_post_scaler(wdt);
> +	terminal = 1 << ps;

BIT(ps) would be a bit nicer.

> +
> +	/* find time taken (in secs) to reach terminal count */
> +	period = terminal / rate;

Can rate be 0 ?

> +	pr_info("wdt: clk_rate %lu (postscale) / terminal %d, timeout %dsec\n",
> +		rate, terminal, period);

Is this needed ? Seems like a debug message to me.
Users won't be able to make sense of it.

> +
> +	return period;
> +}
> +
> +static void pic32_wdt_keepalive(struct pic32_wdt *wdt)
> +{
> +	wdt->next_heartbeat = jiffies +
> +		msecs_to_jiffies(wdt->timeout * MSEC_PER_SEC);
> +	wdt_keepalive(wdt);
> +}
> +
> +static int pic32_wdt_start(struct watchdog_device *wdd)
> +{
> +	struct pic32_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	spin_lock(&wdt->lock);

Is this lock (on top of the lock provided by the watchdog subsystem)
needed ? If so, please explain.

> +	if (wdt_is_enabled(wdt))
> +		goto done;

Can this happpen, and if so, does it matter ?

> +
> +	wdt_enable(wdt);
> +done:
> +	pic32_wdt_keepalive(wdt);
> +	spin_unlock(&wdt->lock);
> +
> +	return 0;
> +}
> +
> +static int pic32_wdt_stop(struct watchdog_device *wdd)
> +{
> +	struct pic32_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	spin_lock(&wdt->lock);
> +	wdt_disable(wdt);
> +	spin_unlock(&wdt->lock);
> +
> +	return 0;
> +}
> +
> +static int pic32_wdt_ping(struct watchdog_device *wdd)
> +{
> +	struct pic32_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	spin_lock(&wdt->lock);
> +	pic32_wdt_keepalive(wdt);
> +	spin_unlock(&wdt->lock);
> +
> +	return 0;
> +}
> +
> +static unsigned int pic32_wdt_get_timeleft(struct watchdog_device *wdd)
> +{
> +	struct pic32_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	return jiffies_to_msecs(wdt->next_heartbeat - jiffies) / MSEC_PER_SEC;
> +}

Please no software "get_timeleft" implementation. If this is desired,
we can implement it in the watchdog core.

> +
> +static const struct watchdog_ops pic32_wdt_fops = {
> +	.owner		= THIS_MODULE,
> +	.start		= pic32_wdt_start,
> +	.stop		= pic32_wdt_stop,
> +	.get_timeleft	= pic32_wdt_get_timeleft,
> +	.ping		= pic32_wdt_ping,
> +};
> +
> +static const struct watchdog_info pic32_wdt_ident = {
> +	.options = WDIOF_KEEPALIVEPING |
> +			WDIOF_MAGICCLOSE | WDIOF_CARDRESET,

Is the timeout truly not configurable ?

> +	.identity = "PIC32 Watchdog",
> +};
> +
> +static struct watchdog_device pic32_wdd = {
> +	.info		= &pic32_wdt_ident,
> +	.ops		= &pic32_wdt_fops,
> +	.min_timeout	= 1,
> +	.max_timeout	= 1048,

Real or arbitrary ?

> +};
> +
> +static const struct of_device_id pic32_wdt_dt_ids[] = {
> +	{ .compatible = "microchip,pic32mzda-wdt-v2", },

Is this compatible statement documented ?

> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, pic32_wdt_dt_ids);
> +
> +static int pic32_wdt_drv_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct watchdog_device *wdd = &pic32_wdd;
> +	struct pic32_wdt *wdt;
> +	struct resource *mem;
> +
> +	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> +	if (IS_ERR(wdt))
> +		return PTR_ERR(wdt);
> +
> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	wdt->regs = devm_ioremap_resource(&pdev->dev, mem);
> +	if (IS_ERR(wdt->regs))
> +		return PTR_ERR(wdt->regs);
> +
> +	wdt->rst_base = devm_ioremap(&pdev->dev, PIC32_BASE_RESET, 0x10);
> +	if (IS_ERR(wdt->rst_base))
> +		return PTR_ERR(wdt->rst_base);
> +
> +	wdt->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(wdt->clk)) {
> +		dev_err(&pdev->dev, "clk not found\n");
> +		return PTR_ERR(wdt->clk);
> +	}
> +
> +	ret = clk_prepare_enable(wdt->clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "clk enable failed\n");
> +		return ret;
> +	}
> +
> +	if (wdt_is_win_enabled(wdt)) {
> +		dev_err(&pdev->dev, "windowed-clear mode is not supported.\n");
> +		ret = -EOPNOTSUPP;
> +		goto out_disable_clk;

It might make more sense to check this first, before enabling the clock.

Also, can this not be disabled in software ?

> +	}
> +
> +	wdt->timeout = pic32_wdt_get_timeout_secs(wdt);

Can timeout end up being 0 (less than 1 second) ?

> +	spin_lock_init(&wdt->lock);
> +
> +	wdd->timeout = wdt->timeout;

wdt->timeout is only used to calculate next_timeout which is only used
to calculate the time left in software, which you should not do. Please drop.

> +	wdd->bootstatus = pic32_wdt_bootstatus(wdt) ? WDIOF_CARDRESET : 0;
> +
> +	ret = watchdog_register_device(wdd);
> +	if (ret) {
> +		dev_err(&pdev->dev, "watchdog register failed, err %d\n", ret);
> +		goto out_disable_clk;
> +	}
> +
> +	watchdog_set_nowayout(wdd, WATCHDOG_NOWAYOUT);
> +	watchdog_set_drvdata(wdd, wdt);

Race condition.

> +
> +	platform_set_drvdata(pdev, wdd);
> +	return 0;
> +
> +out_disable_clk:
> +	clk_disable_unprepare(wdt->clk);
> +
> +	return ret;
> +}
> +
> +static int pic32_wdt_drv_remove(struct platform_device *pdev)
> +{
> +	struct watchdog_device *wdd = platform_get_drvdata(pdev);
> +	struct pic32_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	clk_disable_unprepare(wdt->clk);
> +	watchdog_unregister_device(wdd);

Please call unregister first.

> +
> +	return 0;
> +}
> +
> +static struct platform_driver pic32_wdt_driver = {
> +	.probe		= pic32_wdt_drv_probe,
> +	.remove		= pic32_wdt_drv_remove,
> +	.driver		= {
> +		.name		= "pi32-wdt",

pi32 or pic32 ?

> +		.owner		= THIS_MODULE,
> +		.of_match_table = of_match_ptr(pic32_wdt_dt_ids),
> +	}
> +};
> +
> +module_platform_driver(pic32_wdt_driver);
> +
> +MODULE_AUTHOR("Joshua Henderson <joshua.henderson@microchip.com>");
> +MODULE_DESCRIPTION("Microchip PIC32 Watchdog Timer");
> +MODULE_LICENSE("GPL");
> --
> 1.7.9.5
>
>
