Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Feb 2016 00:35:05 +0100 (CET)
Received: from exsmtp01.microchip.com ([198.175.253.37]:54705 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27010427AbcBDXfDLk7ma (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Feb 2016 00:35:03 +0100
Received: from [10.14.4.125] (10.10.76.4) by CHN-SV-EXCH01.mchp-main.com
 (10.10.76.37) with Microsoft SMTP Server id 14.3.181.6; Thu, 4 Feb 2016
 16:34:55 -0700
From:   Joshua Henderson <joshua.henderson@microchip.com>
Subject: Re: [PATCH 2/2] watchdog: pic32-dmt: Add PIC32 deadman timer driver
 support
To:     Guenter Roeck <linux@roeck-us.net>, <linux-kernel@vger.kernel.org>
References: <1454371348-25104-1-git-send-email-joshua.henderson@microchip.com>
 <1454371348-25104-2-git-send-email-joshua.henderson@microchip.com>
 <56B01CB6.6010700@roeck-us.net>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        Purna Chandra Mandal <purna.mandal@microchip.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        <linux-watchdog@vger.kernel.org>
Message-ID: <56B3E109.1060507@microchip.com>
Date:   Thu, 4 Feb 2016 16:38:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <56B01CB6.6010700@roeck-us.net>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-Path: <Joshua.Henderson@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51793
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joshua.henderson@microchip.com
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

Guenter,

On 02/01/2016 08:04 PM, Guenter Roeck wrote:
> On 02/01/2016 04:02 PM, Joshua Henderson wrote:
>> From: Purna Chandra Mandal <purna.mandal@microchip.com>
>>
>> The primary function of the deadman timer (DMT) is to reset the processor
>> in the event of a software malfunction. The DMT is a free-running
>> instruction fetch timer, which is clocked whenever an instruction fetch
>> occurs until a count match occurs. Instructions are not fetched when
>> the processor is in sleep mode.
>>
>> Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>
>> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
>> Cc: Ralf Baechle <ralf@linux-mips.org>
>> Cc: <linux-mips@linux-mips.org>
> 
> Please drop this Cc: from the commit log.
> 

Ack.

>> ---
>> Note: Please merge this patch series through the MIPS tree.
>> ---
>>   drivers/watchdog/Kconfig     |   14 ++
>>   drivers/watchdog/Makefile    |    1 +
>>   drivers/watchdog/pic32-dmt.c |  296 ++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 311 insertions(+)
>>   create mode 100644 drivers/watchdog/pic32-dmt.c
>>
>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> index 131abc2..87985c6 100644
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
>> @@ -1424,6 +1424,20 @@ config PIC32_WDT
>>         To compile this driver as a loadable module, choose M here.
>>         The module will be called pic32-wdt.
>>
>> +config PIC32_DMT
>> +    tristate "Microchip PIC32 Deadman Timer"
>> +    select WATCHDOG_CORE
>> +    depends on MACH_PIC32
>> +    default y
> 
> Are you sure ?

No. Will remove.

>> +    help
>> +      Watchdog driver for PIC32 instruction fetch counting timer. This specific
>> +      timer is typically be used in misson critical and safety critical
>> +      applications, where any single failure of the software functionality
>> +      and sequencing must be detected.
>> +
>> +      To compile this driver as a loadable module, choose M here.
>> +      The module will be called pic32-dmt.
>> +
>>   # PARISC Architecture
>>
>>   # POWERPC Architecture
>> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
>> index 244ed80..d051c9c 100644
>> --- a/drivers/watchdog/Makefile
>> +++ b/drivers/watchdog/Makefile
>> @@ -154,6 +154,7 @@ obj-$(CONFIG_RALINK_WDT) += rt2880_wdt.o
>>   obj-$(CONFIG_IMGPDC_WDT) += imgpdc_wdt.o
>>   obj-$(CONFIG_MT7621_WDT) += mt7621_wdt.o
>>   obj-$(CONFIG_PIC32_WDT) += pic32-wdt.o
>> +obj-$(CONFIG_PIC32_DMT) += pic32-dmt.o
>>
>>   # PARISC Architecture
>>
>> diff --git a/drivers/watchdog/pic32-dmt.c b/drivers/watchdog/pic32-dmt.c
>> new file mode 100644
>> index 0000000..13dd1e3
>> --- /dev/null
>> +++ b/drivers/watchdog/pic32-dmt.c
>> @@ -0,0 +1,296 @@
>> +/*
>> + * PIC32 deadman timer driver
>> + *
>> + * Purna Chandra Mandal <purna.mandal@microchip.com>
>> + * Copyright (c) 2016, Microchip Technology Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * as published by the Free Software Foundation; either version
>> + * 2 of the License, or (at your option) any later version.
>> + */
>> +
>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/clk.h>
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/pm.h>
>> +#include <linux/watchdog.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/device.h>
>> +#include <linux/platform_device.h>
> 
> Please list include files in alphabetic order.
> 

Will do.

>> +
>> +#include <asm/mach-pic32/pic32.h>
>> +
>> +/* Deadman Timer Regs */
>> +#define DMTCON_REG    0x00
>> +#define DMTPRECLR_REG    0x10
>> +#define DMTCLR_REG    0x20
>> +#define DMTSTAT_REG    0x30
>> +#define DMTCNT_REG    0x40
>> +#define DMTPSCNT_REG    0x60
>> +#define DMTPSINTV_REG    0x70
>> +
>> +/* Deadman Timer Regs fields */
>> +#define DMT_ON            0x8000
>> +#define DMT_STEP1_KEY        0x40
>> +#define DMT_STEP1_KEY_BYTE    1
>> +#define DMT_STEP2_KEY        0x08
>> +#define DMTSTAT_WINOPN        0x01
>> +#define DMTSTAT_EVENT        0x20
>> +#define DMTSTAT_BAD2        0x40
>> +#define DMTSTAT_BAD1        0x80
>> +
> 
> BIT() ?

Ack.

>> +/* Reset Control Register fields for watchdog */
>> +#define RESETCON_DMT_TIMEOUT    0x0020
>> +
>> +struct pic32_dmt {
>> +    spinlock_t    lock;
>> +    void __iomem    *regs;
>> +    struct clk    *clk;
>> +};
>> +
>> +static inline int dmt_is_enabled(struct pic32_dmt *dmt)
> 
> Should return bool.

This function will be dropped.

>> +{
>> +    return readl(dmt->regs + DMTCON_REG) & DMT_ON;
>> +}
>> +
>> +static inline void dmt_enable(struct pic32_dmt *dmt)
>> +{
>> +    writel(DMT_ON, PIC32_SET(dmt->regs + DMTCON_REG));
>> +}
>> +
>> +static inline void dmt_disable(struct pic32_dmt *dmt)
>> +{
>> +    writel(DMT_ON, PIC32_CLR(dmt->regs + DMTCON_REG));
>> +    cpu_relax();
> 
> Is this needed ?
> 

Something is, but probably not this. No watchdog registers may not be read or written in the CPU clock cycle immediately following the instruction that clears the module�s ON bit.  I'll comment and investigate a better solution.

>> +}
>> +
>> +static inline int dmt_bad_status(struct pic32_dmt *dmt)
>> +{
>> +    u32 val;
>> +
>> +    val = readl(dmt->regs + DMTSTAT_REG);
>> +    val &= (DMTSTAT_BAD1 | DMTSTAT_BAD2 | DMTSTAT_EVENT);
>> +    if (val)
>> +        pr_err("dmt: bad event generated: sts %08x\n", val);
>> +
> Is this error message really necessary (in addition to the error being reported
> to userspace) ?
> 
> Also, where used, the error is reported as EAGAIN, which suggests a normal condition.
> If so, please drop the message.

It's not really necessary. Probably should have been dbg, but will remove.

>> +    return val;
> 
> I would suggest to return a valid error code directly instead of converting
> the zero/nonzero result to an error in the calling code.

Ack.

>> +}
>> +
>> +static inline int dmt_keepalive(struct pic32_dmt *dmt)
>> +{
>> +    u32 v;
>> +
>> +    /* set pre-clear key */
>> +    writel(DMT_STEP1_KEY << 8, dmt->regs + DMTPRECLR_REG);
>> +
>> +    /* wait for DMT window to open */
>> +    for (;;) {
>> +        v = readl(dmt->regs + DMTSTAT_REG) & DMTSTAT_WINOPN;
>> +        if (v == DMTSTAT_WINOPN)
>> +            break;
>> +    }
> 
> Really wait forever in a hot loop with no timeout and no means to escape ?

I'll find a max to break the loop.  Whats the worst that could happen?  The CPU will reset. :)

> 
>> +
>> +    /* apply key2 */
>> +    writel(DMT_STEP2_KEY, dmt->regs + DMTCLR_REG);
>> +
>> +    /* check whether keys are latched correctly */
>> +    return dmt_bad_status(dmt);
>> +}
>> +
>> +static inline u32 dmt_timeleft(struct pic32_dmt *dmt)
>> +{
>> +    u32 top = readl(dmt->regs + DMTPSCNT_REG);
>> +
>> +    return top - readl(dmt->regs + DMTCNT_REG);
>> +}
>> +
>> +static inline u32 dmt_interval_time_to_clear(struct pic32_dmt *dmt)
>> +{
>> +    return readl(dmt->regs + DMTPSINTV_REG);
>> +}
>> +
> 
> This function is not used anywhere.

Removed.

>> +static inline u32 pic32_dmt_get_timeout_secs(struct pic32_dmt *dmt)
>> +{
>> +    return readl(dmt->regs + DMTPSCNT_REG) / clk_get_rate(dmt->clk);
>> +}
>> +
>> +static inline u32 pic32_dmt_bootstatus(struct pic32_dmt *dmt)
>> +{
>> +    u32 v;
>> +    void __iomem *rst_base;
>> +
>> +    rst_base = ioremap(PIC32_BASE_RESET, 0x10);
>> +    if (!rst_base)
>> +        return 0;
>> +
>> +    v = readl(rst_base);
>> +
>> +    writel(RESETCON_DMT_TIMEOUT, PIC32_CLR(rst_base));
>> +
>> +    iounmap(rst_base);
>> +    return v & RESETCON_DMT_TIMEOUT;
>> +}
>> +
>> +static int pic32_dmt_start(struct watchdog_device *wdd)
>> +{
>> +    struct pic32_dmt *dmt = watchdog_get_drvdata(wdd);
>> +
>> +    spin_lock(&dmt->lock);
> 
> Is this lock (on top of the watchdg core lock) needed ?

It's not needed the watchdog_core mutex in the path.

> 
>> +    if (dmt_is_enabled(dmt))
>> +        goto done;
>> +
> Can this happen ?

It can, but this logic isn't really necessary.

> 
>> +    dmt_enable(dmt);
> 
> If so, does it hurt to just enable it again ?

I will confirm, but I don't think it hurts to enable again in this case.

> 
>> +done:
>> +    dmt_keepalive(dmt);
> 
> This returns an error. Is it not reported on purpose ?

It does make sense to go ahead and report the error, as long as -EAGAIN makes sense from pic32_dmt_start().  Or some other error.  Any thoughts?

> 
>> +    spin_unlock(&dmt->lock);
>> +
>> +    return 0;
>> +}
>> +
>> +static int pic32_dmt_stop(struct watchdog_device *wdd)
>> +{
>> +    struct pic32_dmt *dmt = watchdog_get_drvdata(wdd);
>> +
>> +    spin_lock(&dmt->lock);
>> +    dmt_disable(dmt);
>> +    spin_unlock(&dmt->lock);
>> +
>> +    return 0;
>> +}
>> +
>> +static int pic32_dmt_ping(struct watchdog_device *wdd)
>> +{
>> +    struct pic32_dmt *dmt = watchdog_get_drvdata(wdd);
>> +    int ret;
>> +
>> +    spin_lock(&dmt->lock);
>> +    ret = dmt_keepalive(dmt);
>> +    spin_unlock(&dmt->lock);
>> +
>> +    return ret ? -EAGAIN : 0;
>> +}
>> +
>> +static unsigned int pic32_dmt_get_timeleft(struct watchdog_device *wdd)
>> +{
>> +    struct pic32_dmt *dmt = watchdog_get_drvdata(wdd);
>> +
>> +    return dmt_timeleft(dmt);
> 
> Does that function return the remaining time in seconds ?

It does not.  Will remove.

> 
>> +}
>> +
>> +static const struct watchdog_ops pic32_dmt_fops = {
>> +    .owner        = THIS_MODULE,
>> +    .start        = pic32_dmt_start,
>> +    .stop        = pic32_dmt_stop,
>> +    .get_timeleft    = pic32_dmt_get_timeleft,

Will also drop this function.

>> +    .ping        = pic32_dmt_ping,
>> +};
>> +
>> +static const struct watchdog_info pic32_dmt_ident = {
>> +    .options    = WDIOF_KEEPALIVEPING |
>> +              WDIOF_MAGICCLOSE,
>> +    .identity    = "PIC32 Deadman Timer",
>> +};
>> +
>> +static struct watchdog_device pic32_dmt_wdd = {
>> +    .info        = &pic32_dmt_ident,
>> +    .ops        = &pic32_dmt_fops,
>> +    .min_timeout    = 1,
>> +    .max_timeout    = UINT_MAX,
>> +};
>> +
>> +static int pic32_dmt_probe(struct platform_device *pdev)
>> +{
>> +    int ret;
>> +    struct pic32_dmt *dmt;
>> +    struct resource *mem;
>> +    struct watchdog_device *wdd = &pic32_dmt_wdd;
>> +
>> +    dmt = devm_kzalloc(&pdev->dev, sizeof(*dmt), GFP_KERNEL);
>> +    if (IS_ERR(dmt))
>> +        return PTR_ERR(dmt);
>> +
>> +    mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +    dmt->regs = devm_ioremap_resource(&pdev->dev, mem);
>> +    if (IS_ERR(dmt->regs))
>> +        return PTR_ERR(dmt->regs);
>> +
>> +    dmt->clk = devm_clk_get(&pdev->dev, NULL);
>> +    if (IS_ERR(dmt->clk)) {
>> +        dev_err(&pdev->dev, "clk not found\n");
>> +        return PTR_ERR(dmt->clk);
>> +    }
>> +
>> +    ret = clk_prepare_enable(dmt->clk);
>> +    if (ret)
>> +        return ret;
>> +
>> +    wdd->max_timeout /= clk_get_rate(dmt->clk);
> 
> Please just assign UINT_MAX / clk_get_rate(dmt->clk).
> 

As with the watchdog driver, I will just drop this calculation.

>> +    wdd->timeout = pic32_dmt_get_timeout_secs(dmt);
>> +    wdd->bootstatus = pic32_dmt_bootstatus(dmt) ? WDIOF_CARDRESET : 0;
>> +    if (!wdd->timeout) {
>> +        dev_err(&pdev->dev,
>> +            "timeout %dsec too small for DMT\n", wdd->timeout);
> 
> wdd->timeout is 0 here, so displaying the variable does not provide much value.
> Besides "0sec" looks a bit odd.

Agreed.

> 
>> +        ret = -EINVAL;
>> +        goto out_disable_clk;
>> +    }
>> +
>> +    spin_lock_init(&dmt->lock);
>> +
>> +    dev_info(&pdev->dev, "max_timeout %d, min_timeout %d, cur_timeout %d\n",
>> +         wdd->max_timeout, wdd->min_timeout, wdd->timeout);
> 
> min_timeout is a constant and thus not worth reporting.
> Please report the current timeout as "timeout".

Ack.

> 
>> +    ret = watchdog_register_device(wdd);
>> +    if (ret) {
>> +        dev_err(&pdev->dev, "watchdog register failed, err %d\n", ret);
>> +        goto out_disable_clk;
>> +    }
>> +
>> +    watchdog_set_nowayout(wdd, WATCHDOG_NOWAYOUT);
>> +    watchdog_set_drvdata(wdd, dmt);
> 
> Race condition: drvdata may be needed after the call to watchdog_register_device().

Ack.

> 
>> +
>> +    platform_set_drvdata(pdev, wdd);
>> +    return 0;
>> +
>> +out_disable_clk:
>> +    clk_disable_unprepare(dmt->clk);
>> +    return ret;
>> +}
>> +
>> +static int pic32_dmt_remove(struct platform_device *pdev)
>> +{
>> +    struct watchdog_device *wdd = platform_get_drvdata(pdev);
>> +    struct pic32_dmt *dmt = watchdog_get_drvdata(wdd);
>> +
>> +    clk_disable_unprepare(dmt->clk);
>> +    watchdog_unregister_device(wdd);
> 
> Unregister first ?

Ack.

> 
>> +
>> +    return 0;
>> +}
>> +
>> +static const struct of_device_id pic32_dmt_of_ids[] = {
>> +    { .compatible = "microchip,pic32mzda-dmt",},
> 
> Is the documentation for this compatible string added with a separate patch ?
> 

Yes. I goofed up and did not Cc: you directly. I'll make sure and Cc: you in V2.  See [PATCH 1/2] of this series: https://lkml.org/lkml/2016/2/1/865

>> +    { /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, pic32_dmt_of_ids);
>> +
>> +static struct platform_driver pic32_dmt_driver = {
>> +    .probe        = pic32_dmt_probe,
>> +    .remove        = pic32_dmt_remove,
>> +    .driver        = {
>> +        .name        = "pi32-dmt",
>> +        .owner        = THIS_MODULE,
>> +        .of_match_table = of_match_ptr(pic32_dmt_of_ids),
>> +    }
>> +};
>> +
>> +module_platform_driver(pic32_dmt_driver);
>> +
>> +MODULE_AUTHOR("Purna Chandra Mandal <purna.mandal@microchip.com>");
>> +MODULE_DESCRIPTION("Microchip PIC32 DMT Driver");
>> +MODULE_LICENSE("GPL");
>> -- 
>> 1.7.9.5
>>
>>
> 

Thanks,
Josh
