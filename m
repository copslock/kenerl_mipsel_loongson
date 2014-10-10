Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Oct 2014 22:02:34 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:33707 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011115AbaJJUCbqEvO4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 10 Oct 2014 22:02:31 +0200
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id D6CA42802FD;
        Fri, 10 Oct 2014 22:01:34 +0200 (CEST)
Received: from Dicker-Alter.local (p5B324634.dip0.t-ipconnect.de [91.50.70.52])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Fri, 10 Oct 2014 22:01:34 +0200 (CEST)
Message-ID: <54383B52.1000103@openwrt.org>
Date:   Fri, 10 Oct 2014 22:02:26 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Guenter Roeck <linux@roeck-us.net>,
        John Crispin <blogic@openwrt.org>,
        Wim Van Sebroeck <wim@iguana.be>
CC:     linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] watchdog: add MT7621 watchdog support
References: <1412965669-5243-1-git-send-email-blogic@openwrt.org> <543839AA.8050808@roeck-us.net>
In-Reply-To: <543839AA.8050808@roeck-us.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43219
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

Hi,

Thanks for the review i will prepare a fixed version of the patch. the
driver is indeed copied from rt2880.

2 comments inline

On 10/10/2014 21:55, Guenter Roeck wrote:
> On 10/10/2014 11:27 AM, John Crispin wrote:
>> This patch adds support for the watchdog core found on newer 
>> mediatek/ralink Wifi SoCs.
>> 
>> Signed-off-by: John Crispin <blogic@openwrt.org>


> 
> Hi John,
> 
>> --- .../devicetree/bindings/watchdog/mt7621-wdt.txt    |   12 ++
>>  drivers/watchdog/Kconfig                           |    7 + 
>> drivers/watchdog/Makefile                          |    1 + 
>> drivers/watchdog/mt7621_wdt.c                      |  185 
>> ++++++++++++++++++++ 4 files changed, 205 insertions(+) create 
>> mode 100644 
>> Documentation/devicetree/bindings/watchdog/mt7621-wdt.txt create 
>> mode 100644 drivers/watchdog/mt7621_wdt.c
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/watchdog/mt7621-wdt.txt 
>> b/Documentation/devicetree/bindings/watchdog/mt7621-wdt.txt new 
>> file mode 100644 index 0000000..c15ef0e --- /dev/null +++ 
>> b/Documentation/devicetree/bindings/watchdog/mt7621-wdt.txt @@ 
>> -0,0 +1,12 @@ +Ralink Watchdog Timers + +Required properties: +- 
>> compatible: must be "mediatek,mt7621-wdt" +- reg: physical base 
>> address of the controller and length of the register range + 
>> +Example: + +    watchdog@100 { +        compatible = 
>> "mediatek,mt7621-wdt"; +        reg = <0x100 0x10>; +    }; diff 
>> --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> index f57312f..84c911f 100644 --- a/drivers/watchdog/Kconfig +++ 
>> b/drivers/watchdog/Kconfig @@ -1186,6 +1186,13 @@ config 
>> RALINK_WDT help Hardware driver for the Ralink SoC Watchdog 
>> Timer.
>> 
>> +config MT7621_WDT +    tristate "Mediatek SoC watchdog" + select
>> WATCHDOG_CORE +    depends on SOC_MT7620 || SOC_MT7621 + help +
>> Hardware driver for the Ralink SoC Watchdog Timer. +
> 
> The above claims to do the same. Should this be Mediatek ?
> 
>> # PARISC Architecture
>> 
>> # POWERPC Architecture diff --git a/drivers/watchdog/Makefile 
>> b/drivers/watchdog/Makefile index 468c320..5b2031e 100644 --- 
>> a/drivers/watchdog/Makefile +++ b/drivers/watchdog/Makefile @@ 
>> -138,6 +138,7 @@ obj-$(CONFIG_OCTEON_WDT) += octeon-wdt.o 
>> octeon-wdt-y := octeon-wdt-main.o octeon-wdt-nmi.o 
>> obj-$(CONFIG_LANTIQ_WDT) += lantiq_wdt.o
>> obj-$(CONFIG_RALINK_WDT) += rt2880_wdt.o
>> +obj-$(CONFIG_MT7621_WDT) += mt7621_wdt.o
>> 
>> # PARISC Architecture
>> 
>> diff --git a/drivers/watchdog/mt7621_wdt.c 
>> b/drivers/watchdog/mt7621_wdt.c new file mode 100644 index 
>> 0000000..542ed97 --- /dev/null +++ 
>> b/drivers/watchdog/mt7621_wdt.c @@ -0,0 +1,185 @@ +/* + * Ralink 
>> RT288x/RT3xxx/MT76xx built-in hardware watchdog timer + *
> 
> The rt2880_wdt driver claims to do the same. Either the statement 
> here or there or both is wrong.
> 
>> + * Copyright (C) 2011 Gabor Juhos <juhosg@openwrt.org> + * 
>> Copyright (C) 2013 John Crispin <blogic@openwrt.org> + * + *
>> This driver was based on: drivers/watchdog/softdog.c + *
> Seems to be based on the rt2880 driver ?
> 
>> + * This program is free software; you can redistribute it and/or
>> modify it + * under the terms of the GNU General Public License
>> version 2 as published + * by the Free Software Foundation. + */
>> + +#include <linux/clk.h> +#include <linux/reset.h> +#include
>> <linux/module.h> +#include <linux/kernel.h> +#include
>> <linux/watchdog.h> +#include <linux/miscdevice.h>
> 
> No longer needed.
> 
>> +#include <linux/moduleparam.h> +#include 
>> <linux/platform_device.h> + +#include 
>> <asm/mach-ralink/ralink_regs.h> + +#define SYSC_RSTSTAT 0x38
>> +#define WDT_RST_CAUSE            BIT(1) + +#define 
>> RALINK_WDT_TIMEOUT        30 + +#define TIMER_REG_TMRSTAT 0x00
>> +#define TIMER_REG_TMR1LOAD        0x24 +#define 
>> TIMER_REG_TMR1CTL        0x20 + +#define TMR1CTL_ENABLE BIT(7)
>> +#define TMR1CTL_RESTART            BIT(9) + +static void __iomem
>> *mt7621_wdt_base; + +static bool nowayout = WATCHDOG_NOWAYOUT;
>> +module_param(nowayout, bool, 0); +MODULE_PARM_DESC(nowayout, +
>> "Watchdog cannot be stopped once started (default=" + 
>> __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> 
> Please align continuation lines with '('.
> 
>> + +static inline void rt_wdt_w32(unsigned reg, u32 val) +{ + 
>> iowrite32(val, mt7621_wdt_base + reg); +} + +static inline u32 
>> rt_wdt_r32(unsigned reg) +{ +    return ioread32(mt7621_wdt_base 
>> + reg); +} + +static int mt7621_wdt_ping(struct watchdog_device 
>> *w) +{ +    rt_wdt_w32(TIMER_REG_TMRSTAT, TMR1CTL_RESTART); + + 
>> return 0; +} + +static int mt7621_wdt_set_timeout(struct 
>> watchdog_device *w, unsigned int t) +{ +    w->timeout = t; + 
>> rt_wdt_w32(TIMER_REG_TMR1LOAD, t * 1000); + mt7621_wdt_ping(w); +
>> +    return 0; +} + +static int mt7621_wdt_start(struct
>> watchdog_device *w) +{ +    u32 t; + + 
>> rt_wdt_w32(TIMER_REG_TMR1CTL, 1000 << 16);
> 
> Can you explain this a bit ?
> 
>> +    mt7621_wdt_set_timeout(w, w->timeout); + +    t = 
>> rt_wdt_r32(TIMER_REG_TMR1CTL); +    t |= TMR1CTL_ENABLE; + 
>> rt_wdt_w32(TIMER_REG_TMR1CTL, t); + +    return 0; +} + +static 
>> int mt7621_wdt_stop(struct watchdog_device *w) +{ +    u32 t; +
>> + mt7621_wdt_ping(w); + +    t = rt_wdt_r32(TIMER_REG_TMR1CTL);
>> + t &= ~TMR1CTL_ENABLE; +    rt_wdt_w32(TIMER_REG_TMR1CTL, t); +
>> + return 0; +} + +static int mt7621_wdt_bootcause(void) +{ +
>> if (rt_sysc_r32(SYSC_RSTSTAT) & WDT_RST_CAUSE) +        return 
>> WDIOF_CARDRESET; +
> That concerns me a bit. What guarantees that rt_sysc_membase is
> set ? I understand that rt2880 driver has the same problem, but
> that doesn't really make it better.

it is always set. without the SoC won't boot.


> 
>> +    return 0; +} + +static struct watchdog_info mt7621_wdt_info 
>> = { +    .identity = "Mediatek Watchdog", +    .options = 
>> WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE, +}; +
>>  +static struct watchdog_ops mt7621_wdt_ops = { +    .owner = 
>> THIS_MODULE, +    .start = mt7621_wdt_start, +    .stop = 
>> mt7621_wdt_stop, +    .ping = mt7621_wdt_ping, +    .set_timeout 
>> = mt7621_wdt_set_timeout, +}; + +static struct watchdog_device 
>> mt7621_wdt_dev = { +    .info = &mt7621_wdt_info, +    .ops = 
>> &mt7621_wdt_ops, +    .min_timeout = 1, +}; + +static int 
>> mt7621_wdt_probe(struct platform_device *pdev) +{ +    struct 
>> resource *res; +    int ret; + +    res = 
>> platform_get_resource(pdev, IORESOURCE_MEM, 0); + mt7621_wdt_base
>> = devm_ioremap_resource(&pdev->dev, res); +    if 
>> (IS_ERR(mt7621_wdt_base)) +        return 
>> PTR_ERR(mt7621_wdt_base); + +    device_reset(&pdev->dev); +
> Just wondering ... is this doing anything in the real world, or in 
> other words is there a reset bit (or controller, for that matter) 
> associated with the watchdog timer ?
> 
> I see a reset controller registration for the rl2880, but not for 
> the mt7621.
> 

i am in the process of sending the mt7621 code upstream so that it
gets merged in the same window. and yes, there is an actual reset bit
that gets toggled by this call.

Thanks,
	John


>> +    mt7621_wdt_dev.dev = &pdev->dev; + mt7621_wdt_dev.bootstatus
>> = mt7621_wdt_bootcause(); + mt7621_wdt_dev.max_timeout =
>> (0xfffful / 1000); + mt7621_wdt_dev.timeout =
>> mt7621_wdt_dev.max_timeout; +
> Why not just set max_timeout and timeout directly in the data 
> structure ? Also, since the driver supports devicetree, would it 
> make sense to use watchdog_init_timeout to support the timeout-sec 
> property ?
> 
>> +    watchdog_set_nowayout(&mt7621_wdt_dev, nowayout); + +
>> ret = watchdog_register_device(&mt7621_wdt_dev); +    if (!ret)
>> + dev_info(&pdev->dev, "Initialized\n"); +
> Is that noise really necessary ?
> 
>> +    return 0; +} + +static int mt7621_wdt_remove(struct 
>> platform_device *pdev) +{ + 
>> watchdog_unregister_device(&mt7621_wdt_dev); + +    return 0; +}
>>  + +static void mt7621_wdt_shutdown(struct platform_device *pdev)
>>  +{ +    mt7621_wdt_stop(&mt7621_wdt_dev); +} + +static const 
>> struct of_device_id mt7621_wdt_match[] = { +    { .compatible = 
>> "mediatek,mt7621-wdt" }, +    {}, +}; +MODULE_DEVICE_TABLE(of, 
>> mt7621_wdt_match); + +static struct platform_driver 
>> mt7621_wdt_driver = { +    .probe        = mt7621_wdt_probe, + 
>> .remove        = mt7621_wdt_remove, +    .shutdown    = 
>> mt7621_wdt_shutdown, +    .driver        = { +        .name =
>> KBUILD_MODNAME, +        .owner        = THIS_MODULE, + 
>> .of_match_table    = mt7621_wdt_match, +    }, +}; + 
>> +module_platform_driver(mt7621_wdt_driver); + 
>> +MODULE_DESCRIPTION("MediaTek MT762x hardware watchdog driver");
>>  +MODULE_AUTHOR("John Crispin <blogic@openwrt.org"); 
>> +MODULE_LICENSE("GPL v2"); 
>> +MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
> 
> No longer needed.
> 
> Thanks, Guenter
> 
> 
> 
