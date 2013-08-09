Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Aug 2013 21:34:45 +0200 (CEST)
Received: from mail-pb0-f43.google.com ([209.85.160.43]:63690 "EHLO
        mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6865310Ab3HITe3iAALD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Aug 2013 21:34:29 +0200
Received: by mail-pb0-f43.google.com with SMTP id md4so3785381pbc.2
        for <linux-mips@linux-mips.org>; Fri, 09 Aug 2013 12:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=+Z6D2ZpaY8BpRuVFEi5JLf3nML7yrN29tmDBN3J2y2A=;
        b=QOf8FvuJMFJ02cJo0mWg+sOrGRPgHQyBhX7qKB8DZ8n1PozdutmpOSNYw3GpIXWEbm
         bI96Z1GHPd/bXl5iW2Ic/Fzc2qg6lVxQVM+lbtlHvxXTwTRw/wI0K+5ET+G/AY9khaFZ
         38I7C6/+E9NqsJvmpS9xUvQ9mCPTa0B9zwUO3AyXWvnIhWk8gMqnvbA9dgfAke3+nU1D
         YuLbfM34TDeW5lYJhcTPONoX9V8l7Dvfni+0odXbwbRrTjT4/qyU8Ydti6Po8DSVZM1q
         h29sPcMRDJD58U8pA0t3abaGy8kiLdD+Y6qVbQ8ZEseluRRylpUPdVbC80XbbopakCxX
         nh1A==
X-Received: by 10.66.149.73 with SMTP id ty9mr12881563pab.36.1376076862759;
        Fri, 09 Aug 2013 12:34:22 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by mx.google.com with ESMTPSA id ll5sm24072067pab.19.2013.08.09.12.34.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 09 Aug 2013 12:34:22 -0700 (PDT)
Date:   Fri, 9 Aug 2013 12:34:21 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     John Crispin <blogic@openwrt.org>
Cc:     Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] watchdog: MIPS: add ralink watchdog driver
Message-ID: <20130809193421.GD10417@roeck-us.net>
References: <1375954303-28830-1-git-send-email-blogic@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1375954303-28830-1-git-send-email-blogic@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37506
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

On Thu, Aug 08, 2013 at 11:31:43AM +0200, John Crispin wrote:
> Add a driver for the watchdog timer found on Ralink SoC
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> Cc: linux-watchdog@vger.kernel.org
> Cc: linux-mips@linux-mips.org

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/Kconfig      |    7 ++
>  drivers/watchdog/Makefile     |    1 +
>  drivers/watchdog/rt2880_wdt.c |  208 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 216 insertions(+)
>  create mode 100644 drivers/watchdog/rt2880_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 362085d..00b1450 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1117,6 +1117,13 @@ config LANTIQ_WDT
>  	help
>  	  Hardware driver for the Lantiq SoC Watchdog Timer.
>  
> +config RALINK_WDT
> +	tristate "Ralink SoC watchdog"
> +	select WATCHDOG_CORE
> +	depends on RALINK
> +	help
> +	  Hardware driver for the Ralink SoC Watchdog Timer.
> +
>  # PARISC Architecture
>  
>  # POWERPC Architecture
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 2f26a0b..8ce381d 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -135,6 +135,7 @@ obj-$(CONFIG_TXX9_WDT) += txx9wdt.o
>  obj-$(CONFIG_OCTEON_WDT) += octeon-wdt.o
>  octeon-wdt-y := octeon-wdt-main.o octeon-wdt-nmi.o
>  obj-$(CONFIG_LANTIQ_WDT) += lantiq_wdt.o
> +obj-$(CONFIG_RALINK_WDT) += rt2880_wdt.o
>  
>  # PARISC Architecture
>  
> diff --git a/drivers/watchdog/rt2880_wdt.c b/drivers/watchdog/rt2880_wdt.c
> new file mode 100644
> index 0000000..4d07964
> --- /dev/null
> +++ b/drivers/watchdog/rt2880_wdt.c
> @@ -0,0 +1,208 @@
> +/*
> + * Ralink RT288x/RT3xxx/MT76xx built-in hardware watchdog timer
> + *
> + * Copyright (C) 2011 Gabor Juhos <juhosg@openwrt.org>
> + * Copyright (C) 2013 John Crispin <blogic@openwrt.org>
> + *
> + * This driver was based on: drivers/watchdog/softdog.c
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/reset.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/watchdog.h>
> +#include <linux/miscdevice.h>
> +#include <linux/moduleparam.h>
> +#include <linux/platform_device.h>
> +
> +#include <asm/mach-ralink/ralink_regs.h>
> +
> +#define SYSC_RSTSTAT			0x38
> +#define WDT_RST_CAUSE			BIT(1)
> +
> +#define RALINK_WDT_TIMEOUT		30
> +#define RALINK_WDT_PRESCALE		65536
> +
> +#define TIMER_REG_TMR1LOAD		0x00
> +#define TIMER_REG_TMR1CTL		0x08
> +
> +#define TMRSTAT_TMR1RST			BIT(5)
> +
> +#define TMR1CTL_ENABLE			BIT(7)
> +#define TMR1CTL_MODE_SHIFT		4
> +#define TMR1CTL_MODE_MASK		0x3
> +#define TMR1CTL_MODE_FREE_RUNNING	0x0
> +#define TMR1CTL_MODE_PERIODIC		0x1
> +#define TMR1CTL_MODE_TIMEOUT		0x2
> +#define TMR1CTL_MODE_WDT		0x3
> +#define TMR1CTL_PRESCALE_MASK		0xf
> +#define TMR1CTL_PRESCALE_65536		0xf
> +
> +static struct clk *rt288x_wdt_clk;
> +static unsigned long rt288x_wdt_freq;
> +static void __iomem *rt288x_wdt_base;
> +
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout,
> +		"Watchdog cannot be stopped once started (default="
> +		__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +static inline void rt_wdt_w32(unsigned reg, u32 val)
> +{
> +	iowrite32(val, rt288x_wdt_base + reg);
> +}
> +
> +static inline u32 rt_wdt_r32(unsigned reg)
> +{
> +	return ioread32(rt288x_wdt_base + reg);
> +}
> +
> +static int rt288x_wdt_ping(struct watchdog_device *w)
> +{
> +	rt_wdt_w32(TIMER_REG_TMR1LOAD, w->timeout * rt288x_wdt_freq);
> +
> +	return 0;
> +}
> +
> +static int rt288x_wdt_start(struct watchdog_device *w)
> +{
> +	u32 t;
> +
> +	t = rt_wdt_r32(TIMER_REG_TMR1CTL);
> +	t &= ~(TMR1CTL_MODE_MASK << TMR1CTL_MODE_SHIFT |
> +		TMR1CTL_PRESCALE_MASK);
> +	t |= (TMR1CTL_MODE_WDT << TMR1CTL_MODE_SHIFT |
> +		TMR1CTL_PRESCALE_65536);
> +	rt_wdt_w32(TIMER_REG_TMR1CTL, t);
> +
> +	rt288x_wdt_ping(w);
> +
> +	t = rt_wdt_r32(TIMER_REG_TMR1CTL);
> +	t |= TMR1CTL_ENABLE;
> +	rt_wdt_w32(TIMER_REG_TMR1CTL, t);
> +
> +	return 0;
> +}
> +
> +static int rt288x_wdt_stop(struct watchdog_device *w)
> +{
> +	u32 t;
> +
> +	rt288x_wdt_ping(w);
> +
> +	t = rt_wdt_r32(TIMER_REG_TMR1CTL);
> +	t &= ~TMR1CTL_ENABLE;
> +	rt_wdt_w32(TIMER_REG_TMR1CTL, t);
> +
> +	return 0;
> +}
> +
> +static int rt288x_wdt_set_timeout(struct watchdog_device *w, unsigned int t)
> +{
> +	w->timeout = t;
> +	rt288x_wdt_ping(w);
> +
> +	return 0;
> +}
> +
> +static int rt288x_wdt_bootcause(void)
> +{
> +	if (rt_sysc_r32(SYSC_RSTSTAT) & WDT_RST_CAUSE)
> +		return WDIOF_CARDRESET;
> +
> +	return 0;
> +}
> +
> +static struct watchdog_info rt288x_wdt_info = {
> +	.identity = "Ralink Watchdog",
> +	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
> +};
> +
> +static struct watchdog_ops rt288x_wdt_ops = {
> +	.owner = THIS_MODULE,
> +	.start = rt288x_wdt_start,
> +	.stop = rt288x_wdt_stop,
> +	.ping = rt288x_wdt_ping,
> +	.set_timeout = rt288x_wdt_set_timeout,
> +};
> +
> +static struct watchdog_device rt288x_wdt_dev = {
> +	.info = &rt288x_wdt_info,
> +	.ops = &rt288x_wdt_ops,
> +	.min_timeout = 1,
> +};
> +
> +static int rt288x_wdt_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	int ret;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	rt288x_wdt_base = devm_request_and_ioremap(&pdev->dev, res);
> +	if (IS_ERR(rt288x_wdt_base))
> +		return PTR_ERR(rt288x_wdt_base);
> +
> +	rt288x_wdt_clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(rt288x_wdt_clk))
> +		return PTR_ERR(rt288x_wdt_clk);
> +
> +	device_reset(&pdev->dev);
> +
> +	rt288x_wdt_freq = clk_get_rate(rt288x_wdt_clk) / RALINK_WDT_PRESCALE;
> +
> +	rt288x_wdt_dev.dev = &pdev->dev;
> +	rt288x_wdt_dev.bootstatus = rt288x_wdt_bootcause();
> +
> +	rt288x_wdt_dev.max_timeout = (0xfffful / rt288x_wdt_freq);
> +	rt288x_wdt_dev.timeout = rt288x_wdt_dev.max_timeout;
> +
> +	watchdog_set_nowayout(&rt288x_wdt_dev, nowayout);
> +
> +	ret = watchdog_register_device(&rt288x_wdt_dev);
> +	if (!ret)
> +		dev_info(&pdev->dev, "Initialized\n");
> +
> +	return 0;
> +}
> +
> +static int rt288x_wdt_remove(struct platform_device *pdev)
> +{
> +	watchdog_unregister_device(&rt288x_wdt_dev);
> +
> +	return 0;
> +}
> +
> +static void rt288x_wdt_shutdown(struct platform_device *pdev)
> +{
> +	rt288x_wdt_stop(&rt288x_wdt_dev);
> +}
> +
> +static const struct of_device_id rt288x_wdt_match[] = {
> +	{ .compatible = "ralink,rt2880-wdt" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, rt288x_wdt_match);
> +
> +static struct platform_driver rt288x_wdt_driver = {
> +	.probe		= rt288x_wdt_probe,
> +	.remove		= rt288x_wdt_remove,
> +	.shutdown	= rt288x_wdt_shutdown,
> +	.driver		= {
> +		.name		= KBUILD_MODNAME,
> +		.owner		= THIS_MODULE,
> +		.of_match_table	= rt288x_wdt_match,
> +	},
> +};
> +
> +module_platform_driver(rt288x_wdt_driver);
> +
> +MODULE_DESCRIPTION("MediaTek/Ralink RT288x/RT3xxx hardware watchdog driver");
> +MODULE_AUTHOR("Gabor Juhos <juhosg@openwrt.org");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
