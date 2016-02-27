Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Feb 2016 02:44:38 +0100 (CET)
Received: from bh-25.webhostbox.net ([208.91.199.152]:45215 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014911AbcB0BofVyIdT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 27 Feb 2016 02:44:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject;
        bh=94inJLrx72OOM++LBF39u/QMx97fHt9ge/aKeaT6D7g=; b=J5SB/s/QwKlvrR6s7KLgAFpy7W
        K3tif05u6tdnjI3NMPCZmL6RBDecPOn9QAZj/M1Ql6NTCKSQY0ebegqjt9SbGyDZATIgs2ArAv2tn
        mQUhR3hRKjPWPsgrCVIsC7sQvLRGJQGKTkW1X8WcIlbe4FDijyaOoVpQGtk24xFFHC3FIJq/TnTAS
        atM8Ynm6yQTKPBBxU+0bw5VD60m4k1HbXHLg0FrlQGh53aOV1cbIIa9D8Qj0vSaiflx8Nu56WzhS3
        BcQXPvo5nTIKb7thtR4Dz34XjzH5VzvjAYhcbFYxVMfWjQMAg8GHTBC+gU66ac1yBU7rdF5GYJPHX
        jmbd1bDA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:36702 helo=server.roeck-us.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
        (Exim 4.86)
        (envelope-from <linux@roeck-us.net>)
        id 1aZTvr-001AUH-Bu; Sat, 27 Feb 2016 01:44:32 +0000
Subject: Re: [PATCH v3 2/2] watchdog: pic32-wdt: Add PIC32 watchdog driver
To:     Joshua Henderson <joshua.henderson@microchip.com>,
        linux-kernel@vger.kernel.org
References: <1456507177-5502-2-git-send-email-joshua.henderson@microchip.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Purna Chandra Mandal <purna.mandal@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Wim Van Sebroeck <wim@iguana.be>, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <56D0FF78.7030208@roeck-us.net>
Date:   Fri, 26 Feb 2016 17:44:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1456507177-5502-2-git-send-email-joshua.henderson@microchip.com>
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
X-archive-position: 52348
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

On 02/26/2016 09:19 AM, Joshua Henderson wrote:
> Add support for the watchdog peripheral found on PIC32 class
> devices.
>
> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
> Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Note: Please merge this patch series through the MIPS tree.
>
> Changes since v2:
> 	- Remove pr_fmt and replace pr_debug with dev_dbg
> 	- Check whether rate is zero later when looking for div/zero
> 	- Be consistent and return u32 on pic32_wdt_get_timeout_secs()
> 	- Use -ENODEV instead of -EOPNOTSUPP in probe failure
> Changes since v1:
> 	- Shorten commit description
> 	- Don't default to y in Kconfig
> 	- Alphabetical ordering of includes
> 	- Use BIT() where applicable
> 	- Use consistent function name prefixes
> 	- Inline some single use functions
> 	- Use a return of bool when appropriate
> 	- Replace cpu_relax() with nop and explain why this is needed
> 	- Better error handling, especially to prevent divide by zero
> 	- Remove unecessary pr_info().
> 	- Remove redudant driver spinlock which is already covered by
> 	  watchdog core
> 	- Drop .get_timeleft implementation
> 	- Fix typo in compatibility flag and driver name
> 	- Remove wdt->timeout variable and calculation
> 	- Fix race condition in watchdog driver registration
> ---
>   drivers/watchdog/Kconfig     |   13 +++
>   drivers/watchdog/Makefile    |    1 +
>   drivers/watchdog/pic32-wdt.c |  263 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 277 insertions(+)
>   create mode 100644 drivers/watchdog/pic32-wdt.c
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 0f6d851..543fa81 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1414,6 +1414,19 @@ config MT7621_WDT
>   	help
>   	  Hardware driver for the Mediatek/Ralink MT7621/8 SoC Watchdog Timer.
>
> +config PIC32_WDT
> +	tristate "Microchip PIC32 hardware watchdog"
> +	select WATCHDOG_CORE
> +	depends on MACH_PIC32
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
> index 0000000..6047aa8
> --- /dev/null
> +++ b/drivers/watchdog/pic32-wdt.c
> @@ -0,0 +1,263 @@
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
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm.h>
> +#include <linux/watchdog.h>
> +
> +#include <asm/mach-pic32/pic32.h>
> +
> +/* Watchdog Timer Registers */
> +#define WDTCON_REG		0x00
> +
> +/* Watchdog Timer Control Register fields */
> +#define WDTCON_WIN_EN		BIT(0)
> +#define WDTCON_RMCS_MASK	0x0003
> +#define WDTCON_RMCS_SHIFT	0x0006
> +#define WDTCON_RMPS_MASK	0x001F
> +#define WDTCON_RMPS_SHIFT	0x0008
> +#define WDTCON_ON		BIT(15)
> +#define WDTCON_CLR_KEY		0x5743
> +
> +/* Reset Control Register fields for watchdog */
> +#define RESETCON_TIMEOUT_IDLE	BIT(2)
> +#define RESETCON_TIMEOUT_SLEEP	BIT(3)
> +#define RESETCON_WDT_TIMEOUT	BIT(4)
> +
> +struct pic32_wdt {
> +	void __iomem	*regs;
> +	void __iomem	*rst_base;
> +	struct clk	*clk;
> +};
> +
> +static inline bool pic32_wdt_is_win_enabled(struct pic32_wdt *wdt)
> +{
> +	return !!(readl(wdt->regs + WDTCON_REG) & WDTCON_WIN_EN);
> +}
> +
> +static inline u32 pic32_wdt_get_post_scaler(struct pic32_wdt *wdt)
> +{
> +	u32 v = readl(wdt->regs + WDTCON_REG);
> +
> +	return (v >> WDTCON_RMPS_SHIFT) & WDTCON_RMPS_MASK;
> +}
> +
> +static inline u32 pic32_wdt_get_clk_id(struct pic32_wdt *wdt)
> +{
> +	u32 v = readl(wdt->regs + WDTCON_REG);
> +
> +	return (v >> WDTCON_RMCS_SHIFT) & WDTCON_RMCS_MASK;
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
> +static u32 pic32_wdt_get_timeout_secs(struct pic32_wdt *wdt, struct device *dev)
> +{
> +	unsigned long rate;
> +	u32 period, ps, terminal;
> +
> +	rate = clk_get_rate(wdt->clk);
> +
> +	dev_dbg(dev, "wdt: clk_id %d, clk_rate %lu (prescale)\n",
> +		pic32_wdt_get_clk_id(wdt), rate);
> +
> +	/* default, prescaler of 32 (i.e. div-by-32) is implicit. */
> +	rate >>= 5;
> +	if (!rate)
> +		return 0;
> +
> +	/* calculate terminal count from postscaler. */
> +	ps = pic32_wdt_get_post_scaler(wdt);
> +	terminal = BIT(ps);
> +
> +	/* find time taken (in secs) to reach terminal count */
> +	period = terminal / rate;
> +	dev_dbg(dev,
> +		"wdt: clk_rate %lu (postscale) / terminal %d, timeout %dsec\n",
> +		rate, terminal, period);
> +
> +	return period;
> +}
> +
> +static void pic32_wdt_keepalive(struct pic32_wdt *wdt)
> +{
> +	/* write key through single half-word */
> +	writew(WDTCON_CLR_KEY, wdt->regs + WDTCON_REG + 2);
> +}
> +
> +static int pic32_wdt_start(struct watchdog_device *wdd)
> +{
> +	struct pic32_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	writel(WDTCON_ON, PIC32_SET(wdt->regs + WDTCON_REG));
> +	pic32_wdt_keepalive(wdt);
> +
> +	return 0;
> +}
> +
> +static int pic32_wdt_stop(struct watchdog_device *wdd)
> +{
> +	struct pic32_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	writel(WDTCON_ON, PIC32_CLR(wdt->regs + WDTCON_REG));
> +
> +	/*
> +	 * Cannot touch registers in the CPU cycle following clearing the
> +	 * ON bit.
> +	 */
> +	nop();
> +
> +	return 0;
> +}
> +
> +static int pic32_wdt_ping(struct watchdog_device *wdd)
> +{
> +	struct pic32_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	pic32_wdt_keepalive(wdt);
> +
> +	return 0;
> +}
> +
> +static const struct watchdog_ops pic32_wdt_fops = {
> +	.owner		= THIS_MODULE,
> +	.start		= pic32_wdt_start,
> +	.stop		= pic32_wdt_stop,
> +	.ping		= pic32_wdt_ping,
> +};
> +
> +static const struct watchdog_info pic32_wdt_ident = {
> +	.options = WDIOF_KEEPALIVEPING |
> +			WDIOF_MAGICCLOSE | WDIOF_CARDRESET,
> +	.identity = "PIC32 Watchdog",
> +};
> +
> +static struct watchdog_device pic32_wdd = {
> +	.info		= &pic32_wdt_ident,
> +	.ops		= &pic32_wdt_fops,
> +};
> +
> +static const struct of_device_id pic32_wdt_dt_ids[] = {
> +	{ .compatible = "microchip,pic32mzda-wdt", },
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
> +	if (pic32_wdt_is_win_enabled(wdt)) {
> +		dev_err(&pdev->dev, "windowed-clear mode is not supported.\n");
> +		ret = -ENODEV;
> +		goto out_disable_clk;
> +	}
> +
> +	wdd->timeout = pic32_wdt_get_timeout_secs(wdt, &pdev->dev);
> +	if (!wdd->timeout) {
> +		dev_err(&pdev->dev,
> +			"failed to read watchdog register timeout\n");
> +		ret = -EINVAL;
> +		goto out_disable_clk;
> +	}
> +
> +	dev_info(&pdev->dev, "timeout %d\n", wdd->timeout);
> +
> +	wdd->bootstatus = pic32_wdt_bootstatus(wdt) ? WDIOF_CARDRESET : 0;
> +
> +	watchdog_set_nowayout(wdd, WATCHDOG_NOWAYOUT);
> +	watchdog_set_drvdata(wdd, wdt);
> +
> +	ret = watchdog_register_device(wdd);
> +	if (ret) {
> +		dev_err(&pdev->dev, "watchdog register failed, err %d\n", ret);
> +		goto out_disable_clk;
> +	}
> +
> +	platform_set_drvdata(pdev, wdd);
> +
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
> +	watchdog_unregister_device(wdd);
> +	clk_disable_unprepare(wdt->clk);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver pic32_wdt_driver = {
> +	.probe		= pic32_wdt_drv_probe,
> +	.remove		= pic32_wdt_drv_remove,
> +	.driver		= {
> +		.name		= "pic32-wdt",
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
>
