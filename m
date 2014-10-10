Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Oct 2014 21:55:37 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:54755 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011119AbaJJTzfo8wA2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Oct 2014 21:55:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Subject:CC:To:MIME-Version:From:Date:Message-ID; bh=kvRT5LvgKEvmwVR2d29mMiRPbotOuos/jMsdrYFK1s0=;
        b=TrbHA+2xtDp0HUjJi3F88wD+csOr5d3HM82IQmItdYD9BIHBy0PxnxATriyfoEZFq3YV85xYWBSOidimX4ek+3U45Xj8c3f2kxeUffmHwCyfMuEyXg2Fjq4bW6VyFUEPPFJAATlOOjeQuxqUOtZVGCV9r+NjaFDk9k2frF960NY=;
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1XcgHg-002Kuy-O4
        for linux-mips@linux-mips.org; Fri, 10 Oct 2014 19:55:28 +0000
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:48800 helo=server.roeck-us.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
        (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1XcgHf-002KdC-K7; Fri, 10 Oct 2014 19:55:28 +0000
Message-ID: <543839AA.8050808@roeck-us.net>
Date:   Fri, 10 Oct 2014 12:55:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>, Wim Van Sebroeck <wim@iguana.be>
CC:     linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] watchdog: add MT7621 watchdog support
References: <1412965669-5243-1-git-send-email-blogic@openwrt.org>
In-Reply-To: <1412965669-5243-1-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated_sender: linux@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-CTCH-PVer: 0000001
X-CTCH-Spam: Unknown
X-CTCH-VOD: Unknown
X-CTCH-Flags: 0
X-CTCH-RefID: str=0001.0A020209.543839B0.01EE,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-Score: 0.000
X-CTCH-ScoreCust: 0.000
X-CTCH-Rules: 
X-CTCH-SenderID: linux@roeck-us.net
X-CTCH-SenderID-Flags: 0
X-CTCH-SenderID-TotalMessages: 1
X-CTCH-SenderID-TotalSpam: 0
X-CTCH-SenderID-TotalSuspected: 0
X-CTCH-SenderID-TotalConfirmed: 0
X-CTCH-SenderID-TotalBulk: 0
X-CTCH-SenderID-TotalVirus: 0
X-CTCH-SenderID-TotalRecipients: 0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: mailgid no entry from get_relayhosts_entry
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43218
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

On 10/10/2014 11:27 AM, John Crispin wrote:
> This patch adds support for the watchdog core found on newer mediatek/ralink
> Wifi SoCs.
>
> Signed-off-by: John Crispin <blogic@openwrt.org>

Hi John,

> ---
>   .../devicetree/bindings/watchdog/mt7621-wdt.txt    |   12 ++
>   drivers/watchdog/Kconfig                           |    7 +
>   drivers/watchdog/Makefile                          |    1 +
>   drivers/watchdog/mt7621_wdt.c                      |  185 ++++++++++++++++++++
>   4 files changed, 205 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/watchdog/mt7621-wdt.txt
>   create mode 100644 drivers/watchdog/mt7621_wdt.c
>
> diff --git a/Documentation/devicetree/bindings/watchdog/mt7621-wdt.txt b/Documentation/devicetree/bindings/watchdog/mt7621-wdt.txt
> new file mode 100644
> index 0000000..c15ef0e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/mt7621-wdt.txt
> @@ -0,0 +1,12 @@
> +Ralink Watchdog Timers
> +
> +Required properties:
> +- compatible: must be "mediatek,mt7621-wdt"
> +- reg: physical base address of the controller and length of the register range
> +
> +Example:
> +
> +	watchdog@100 {
> +		compatible = "mediatek,mt7621-wdt";
> +		reg = <0x100 0x10>;
> +	};
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index f57312f..84c911f 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1186,6 +1186,13 @@ config RALINK_WDT
>   	help
>   	  Hardware driver for the Ralink SoC Watchdog Timer.
>
> +config MT7621_WDT
> +	tristate "Mediatek SoC watchdog"
> +	select WATCHDOG_CORE
> +	depends on SOC_MT7620 || SOC_MT7621
> +	help
> +	  Hardware driver for the Ralink SoC Watchdog Timer.
> +

The above claims to do the same. Should this be Mediatek ?

>   # PARISC Architecture
>
>   # POWERPC Architecture
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 468c320..5b2031e 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -138,6 +138,7 @@ obj-$(CONFIG_OCTEON_WDT) += octeon-wdt.o
>   octeon-wdt-y := octeon-wdt-main.o octeon-wdt-nmi.o
>   obj-$(CONFIG_LANTIQ_WDT) += lantiq_wdt.o
>   obj-$(CONFIG_RALINK_WDT) += rt2880_wdt.o
> +obj-$(CONFIG_MT7621_WDT) += mt7621_wdt.o
>
>   # PARISC Architecture
>
> diff --git a/drivers/watchdog/mt7621_wdt.c b/drivers/watchdog/mt7621_wdt.c
> new file mode 100644
> index 0000000..542ed97
> --- /dev/null
> +++ b/drivers/watchdog/mt7621_wdt.c
> @@ -0,0 +1,185 @@
> +/*
> + * Ralink RT288x/RT3xxx/MT76xx built-in hardware watchdog timer
> + *

The rt2880_wdt driver claims to do the same. Either the statement here
or there or both is wrong.

> + * Copyright (C) 2011 Gabor Juhos <juhosg@openwrt.org>
> + * Copyright (C) 2013 John Crispin <blogic@openwrt.org>
> + *
> + * This driver was based on: drivers/watchdog/softdog.c
> + *
Seems to be based on the rt2880 driver ?

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

No longer needed.

> +#include <linux/moduleparam.h>
> +#include <linux/platform_device.h>
> +
> +#include <asm/mach-ralink/ralink_regs.h>
> +
> +#define SYSC_RSTSTAT			0x38
> +#define WDT_RST_CAUSE			BIT(1)
> +
> +#define RALINK_WDT_TIMEOUT		30
> +
> +#define TIMER_REG_TMRSTAT		0x00
> +#define TIMER_REG_TMR1LOAD		0x24
> +#define TIMER_REG_TMR1CTL		0x20
> +
> +#define TMR1CTL_ENABLE			BIT(7)
> +#define TMR1CTL_RESTART			BIT(9)
> +
> +static void __iomem *mt7621_wdt_base;
> +
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout,
> +		"Watchdog cannot be stopped once started (default="
> +		__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");

Please align continuation lines with '('.

> +
> +static inline void rt_wdt_w32(unsigned reg, u32 val)
> +{
> +	iowrite32(val, mt7621_wdt_base + reg);
> +}
> +
> +static inline u32 rt_wdt_r32(unsigned reg)
> +{
> +	return ioread32(mt7621_wdt_base + reg);
> +}
> +
> +static int mt7621_wdt_ping(struct watchdog_device *w)
> +{
> +	rt_wdt_w32(TIMER_REG_TMRSTAT, TMR1CTL_RESTART);
> +
> +	return 0;
> +}
> +
> +static int mt7621_wdt_set_timeout(struct watchdog_device *w, unsigned int t)
> +{
> +	w->timeout = t;
> +	rt_wdt_w32(TIMER_REG_TMR1LOAD, t * 1000);
> +	mt7621_wdt_ping(w);
> +
> +	return 0;
> +}
> +
> +static int mt7621_wdt_start(struct watchdog_device *w)
> +{
> +	u32 t;
> +
> +	rt_wdt_w32(TIMER_REG_TMR1CTL, 1000 << 16);

Can you explain this a bit ?

> +	mt7621_wdt_set_timeout(w, w->timeout);
> +
> +	t = rt_wdt_r32(TIMER_REG_TMR1CTL);
> +	t |= TMR1CTL_ENABLE;
> +	rt_wdt_w32(TIMER_REG_TMR1CTL, t);
> +
> +	return 0;
> +}
> +
> +static int mt7621_wdt_stop(struct watchdog_device *w)
> +{
> +	u32 t;
> +
> +	mt7621_wdt_ping(w);
> +
> +	t = rt_wdt_r32(TIMER_REG_TMR1CTL);
> +	t &= ~TMR1CTL_ENABLE;
> +	rt_wdt_w32(TIMER_REG_TMR1CTL, t);
> +
> +	return 0;
> +}
> +
> +static int mt7621_wdt_bootcause(void)
> +{
> +	if (rt_sysc_r32(SYSC_RSTSTAT) & WDT_RST_CAUSE)
> +		return WDIOF_CARDRESET;
> +
That concerns me a bit. What guarantees that rt_sysc_membase is set ?
I understand that rt2880 driver has the same problem, but that doesn't
really make it better.

> +	return 0;
> +}
> +
> +static struct watchdog_info mt7621_wdt_info = {
> +	.identity = "Mediatek Watchdog",
> +	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
> +};
> +
> +static struct watchdog_ops mt7621_wdt_ops = {
> +	.owner = THIS_MODULE,
> +	.start = mt7621_wdt_start,
> +	.stop = mt7621_wdt_stop,
> +	.ping = mt7621_wdt_ping,
> +	.set_timeout = mt7621_wdt_set_timeout,
> +};
> +
> +static struct watchdog_device mt7621_wdt_dev = {
> +	.info = &mt7621_wdt_info,
> +	.ops = &mt7621_wdt_ops,
> +	.min_timeout = 1,
> +};
> +
> +static int mt7621_wdt_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	int ret;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	mt7621_wdt_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(mt7621_wdt_base))
> +		return PTR_ERR(mt7621_wdt_base);
> +
> +	device_reset(&pdev->dev);
> +
Just wondering ... is this doing anything in the real world,
or in other words is there a reset bit (or controller, for
that matter) associated with the watchdog timer ?

I see a reset controller registration for the rl2880,
but not for the mt7621.

> +	mt7621_wdt_dev.dev = &pdev->dev;
> +	mt7621_wdt_dev.bootstatus = mt7621_wdt_bootcause();
> +	mt7621_wdt_dev.max_timeout = (0xfffful / 1000);
> +	mt7621_wdt_dev.timeout = mt7621_wdt_dev.max_timeout;
> +
Why not just set max_timeout and timeout directly in the data structure ?
Also, since the driver supports devicetree, would it make sense
to use watchdog_init_timeout to support the timeout-sec property ?

> +	watchdog_set_nowayout(&mt7621_wdt_dev, nowayout);
> +
> +	ret = watchdog_register_device(&mt7621_wdt_dev);
> +	if (!ret)
> +		dev_info(&pdev->dev, "Initialized\n");
> +
Is that noise really necessary ?

> +	return 0;
> +}
> +
> +static int mt7621_wdt_remove(struct platform_device *pdev)
> +{
> +	watchdog_unregister_device(&mt7621_wdt_dev);
> +
> +	return 0;
> +}
> +
> +static void mt7621_wdt_shutdown(struct platform_device *pdev)
> +{
> +	mt7621_wdt_stop(&mt7621_wdt_dev);
> +}
> +
> +static const struct of_device_id mt7621_wdt_match[] = {
> +	{ .compatible = "mediatek,mt7621-wdt" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, mt7621_wdt_match);
> +
> +static struct platform_driver mt7621_wdt_driver = {
> +	.probe		= mt7621_wdt_probe,
> +	.remove		= mt7621_wdt_remove,
> +	.shutdown	= mt7621_wdt_shutdown,
> +	.driver		= {
> +		.name		= KBUILD_MODNAME,
> +		.owner		= THIS_MODULE,
> +		.of_match_table	= mt7621_wdt_match,
> +	},
> +};
> +
> +module_platform_driver(mt7621_wdt_driver);
> +
> +MODULE_DESCRIPTION("MediaTek MT762x hardware watchdog driver");
> +MODULE_AUTHOR("John Crispin <blogic@openwrt.org");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);

No longer needed.

Thanks,
Guenter
