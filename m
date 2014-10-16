Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Oct 2014 15:48:17 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:52840 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011613AbaJPNsPZbKu5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Oct 2014 15:48:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Subject:CC:To:MIME-Version:From:Date:Message-ID; bh=wE/T5orbbNfG5Zqeg3631ZoTNS0ohvdM4PrPBQvRO1A=;
        b=AErLbsEzvnAIfNM1HdpYZdzW/Ose/HLkBg4IVMLq4CtDDQm2vAEgoyn5Ftj8nmf9CTcAgEv/+oknZARzdyuxu78m5ZCZUVB8fwv5t6U3ASZA0jBqXrLsPHAhl09vPuO8OXJUq6bBM+nw7zO6pbQM1sGEYEuMEmffLbogM4VWwuw=;
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1XelPU-003e7P-H0
        for linux-mips@linux-mips.org; Thu, 16 Oct 2014 13:48:08 +0000
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:35752 helo=server.roeck-us.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
        (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1XelPT-003e6r-NP; Thu, 16 Oct 2014 13:48:08 +0000
Message-ID: <543FCC94.1020102@roeck-us.net>
Date:   Thu, 16 Oct 2014 06:48:04 -0700
From:   Guenter Roeck <linux@roeck-us.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>, Wim Van Sebroeck <wim@iguana.be>
CC:     linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH V2] watchdog: add MT7621 watchdog support
References: <1413454099-2836-1-git-send-email-blogic@openwrt.org>
In-Reply-To: <1413454099-2836-1-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated_sender: linux@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-CTCH-PVer: 0000001
X-CTCH-Spam: Unknown
X-CTCH-VOD: Unknown
X-CTCH-Flags: 0
X-CTCH-RefID: str=0001.0A020206.543FCC98.01DF,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-Score: 0.000
X-CTCH-ScoreCust: 0.000
X-CTCH-Rules: C_4847,
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
X-archive-position: 43303
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

On 10/16/2014 03:08 AM, John Crispin wrote:
> This patch adds support for the watchdog core found on newer mediatek/ralink
> Wifi SoCs.
>
> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
> Changes since V1
>
> * fix the comments identifying the driver
> * add a comment to the code setting the prescaler
> * use watchdog_init_timeout
> * use devm_reset_control_get
> * get rid of the miscdev code
>
>   .../devicetree/bindings/watchdog/mt7621-wdt.txt    |   12 ++
>   drivers/watchdog/Kconfig                           |    7 +
>   drivers/watchdog/Makefile                          |    1 +
>   drivers/watchdog/mt7621_wdt.c                      |  186 ++++++++++++++++++++
>   4 files changed, 206 insertions(+)
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
> index f57312f..9ee0d32 100644
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

There is no SOC_MT7621 symbol, at least not in the current kernel.

> +	help
> +	  Hardware driver for the Mediatek/Ralink SoC Watchdog Timer.
> +
How about mentioning the supported chips (7620 ? 7621 ? 7628 ?)

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
> index 0000000..0cb9e0b
> --- /dev/null
> +++ b/drivers/watchdog/mt7621_wdt.c
> @@ -0,0 +1,186 @@
> +/*
> + * Ralink MT7621/MT7628 built-in hardware watchdog timer
> + *
MT7628 or MT7620 ?

Thanks,
Guenter

> + * Copyright (C) 2014 John Crispin <blogic@openwrt.org>
> + *
> + * This driver was based on: drivers/watchdog/rt2880_wdt.c
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
> +#define TMR1CTL_PRESCALE_SHIFT		16
> +
> +static void __iomem *mt7621_wdt_base;
> +static struct reset_control *mt7621_wdt_reset;
> +
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout,
> +		 "Watchdog cannot be stopped once started (default="
> +		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
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
> +	/* set the prescaler to 1ms == 1000us */
> +	rt_wdt_w32(TIMER_REG_TMR1CTL, 1000 << TMR1CTL_PRESCALE_SHIFT);
> +
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
> +	.max_timeout = 0xfffful / 1000,
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
> +	mt7621_wdt_reset = devm_reset_control_get(&pdev->dev, NULL);
> +	if (!IS_ERR(mt7621_wdt_reset))
> +		reset_control_deassert(mt7621_wdt_reset);
> +
> +	mt7621_wdt_dev.dev = &pdev->dev;
> +	mt7621_wdt_dev.bootstatus = mt7621_wdt_bootcause();
> +
> +	watchdog_init_timeout(&mt7621_wdt_dev, mt7621_wdt_dev.max_timeout, &pdev->dev);
> +	watchdog_set_nowayout(&mt7621_wdt_dev, nowayout);
> +
> +	ret = watchdog_register_device(&mt7621_wdt_dev);
> +
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
>
