Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jul 2018 23:28:11 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:36588 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993047AbeG3V2H7C3Un convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Jul 2018 23:28:07 +0200
Date:   Mon, 30 Jul 2018 23:27:54 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v5 08/21] watchdog: jz4740: Use regmap and WDT clock
 provided by TCU driver
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org,
        linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
Message-Id: <1532986074.4702.1@smtp.crapouillou.net>
In-Reply-To: <9179ab75-f071-d6a2-ef61-52431ca6409b@roeck-us.net>
References: <20180724231958.20659-1-paul@crapouillou.net>
        <20180724231958.20659-9-paul@crapouillou.net>
        <9179ab75-f071-d6a2-ef61-52431ca6409b@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1532986085; bh=SCrFaxjsVxNYUu26GybTijZXW52ThaHUzrkbVb1ZRhQ=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding; b=ksgYRGDtZCQU5byVWaayWGIKE0/hKPbRNW78Yl6BZGKS6/olxLr2QejNFoxGDWvWufZJ8fmubzAmfckSqLLcTxDTCisQkMxbYx4jK1SDKEhaH9G0vul8pQOS8X8yOJKo5WRBRu9A+C77zrjZdOA0hV2A04q8IkYgKgn3ShbuLx0=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65263
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

Hi Guenter,

Le mer. 25 juil. 2018 � 3:14, Guenter Roeck <linux@roeck-us.net> a 
�crit :
> On 07/24/2018 04:19 PM, Paul Cercueil wrote:
>> Instead of requesting the "ext" clock and handling the watchdog clock
>> divider and gating in the watchdog driver, we now request and use the
>> "wdt" clock that is supplied by the ingenic-timer "TCU" driver.
>> 
>> The major benefit is that the watchdog's clock rate and parent can 
>> now
>> be specified from within devicetree, instead of hardcoded in the 
>> driver.
>> 
> 
> Where is the clock _rate_ specified in the devicetree file ?
> 
> Changing the clock rate in the driver may not be as hardcoded as 
> before,
> but the driver still changes the clock rate.

Right.

>> Also, this driver won't poke anymore into the TCU registers to
>> enable/disable the clock, as this is now handled by the TCU driver.
>> 
>> On the bad side, we break the ABI with devicetree - as we now 
>> request a
>> different clock. In this very specific case it is still okay, as 
>> every
>> Ingenic JZ47xx-based board out there compile the devicetree within 
>> the
>> kernel; so it's still time to push breaking changes, in order to get 
>> a
>> clean devicetree that won't break once it musn't.
> 
> mustn't
> 
>> 
> 
> This change needs to be documented in the devicetree bindings and 
> must be
> approved by a DT maintainer. The bindings change only changes the 
> clock name
> in the example, but not in the bindings description itself (which 
> still
> references the rtc clock).

Right, that's an error in the doc. Easily fixed.

>> Since we broke the ABI by changing the clock, the driver was also
>> updated to use the regmap provided by the TCU driver.
>> 
> 
> Odd logic. What does one have to do with the other ? Why not split
> the patch into two parts, one per logical change, as would be 
> customary ?

I didn't want to break the devicetree ABI twice ;)
I'll split them.

>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>> ---
>>   drivers/watchdog/Kconfig      |   2 +
>>   drivers/watchdog/jz4740_wdt.c | 128 
>> +++++++++++++++++++++---------------------
>>   2 files changed, 66 insertions(+), 64 deletions(-)
>> 
>>   v5: New patch
>> 
>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> index 9af07fd92763..834222abbbdb 100644
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
>> @@ -1476,7 +1476,9 @@ config INDYDOG
>>   config JZ4740_WDT
>>   	tristate "Ingenic jz4740 SoC hardware watchdog"
>>   	depends on MACH_JZ4740 || MACH_JZ4780
>> +	depends on COMMON_CLK
>>   	select WATCHDOG_CORE
>> +	select INGENIC_TIMER
>>   	help
>>   	  Hardware driver for the built-in watchdog timer on Ingenic 
>> jz4740 SoCs.
>>   diff --git a/drivers/watchdog/jz4740_wdt.c 
>> b/drivers/watchdog/jz4740_wdt.c
>> index ec4d99a830ba..aaa6fc87136c 100644
>> --- a/drivers/watchdog/jz4740_wdt.c
>> +++ b/drivers/watchdog/jz4740_wdt.c
>> @@ -13,6 +13,7 @@
>>    *
>>    */
>>   +#include <linux/mfd/ingenic-tcu.h>
>>   #include <linux/module.h>
>>   #include <linux/moduleparam.h>
>>   #include <linux/types.h>
>> @@ -25,26 +26,7 @@
>>   #include <linux/slab.h>
>>   #include <linux/err.h>
>>   #include <linux/of.h>
>> -
>> -#include <asm/mach-jz4740/timer.h>
>> -
>> -#define JZ_REG_WDT_TIMER_DATA     0x0
>> -#define JZ_REG_WDT_COUNTER_ENABLE 0x4
>> -#define JZ_REG_WDT_TIMER_COUNTER  0x8
>> -#define JZ_REG_WDT_TIMER_CONTROL  0xC
>> -
>> -#define JZ_WDT_CLOCK_PCLK 0x1
>> -#define JZ_WDT_CLOCK_RTC  0x2
>> -#define JZ_WDT_CLOCK_EXT  0x4
>> -
>> -#define JZ_WDT_CLOCK_DIV_SHIFT   3
>> -
>> -#define JZ_WDT_CLOCK_DIV_1    (0 << JZ_WDT_CLOCK_DIV_SHIFT)
>> -#define JZ_WDT_CLOCK_DIV_4    (1 << JZ_WDT_CLOCK_DIV_SHIFT)
>> -#define JZ_WDT_CLOCK_DIV_16   (2 << JZ_WDT_CLOCK_DIV_SHIFT)
>> -#define JZ_WDT_CLOCK_DIV_64   (3 << JZ_WDT_CLOCK_DIV_SHIFT)
>> -#define JZ_WDT_CLOCK_DIV_256  (4 << JZ_WDT_CLOCK_DIV_SHIFT)
>> -#define JZ_WDT_CLOCK_DIV_1024 (5 << JZ_WDT_CLOCK_DIV_SHIFT)
>> +#include <linux/regmap.h>
>>     #define DEFAULT_HEARTBEAT 5
>>   #define MAX_HEARTBEAT     2048
>> @@ -64,15 +46,15 @@ MODULE_PARM_DESC(heartbeat,
>>     struct jz4740_wdt_drvdata {
>>   	struct watchdog_device wdt;
>> -	void __iomem *base;
>> -	struct clk *rtc_clk;
>> +	struct regmap *map;
>> +	struct clk *clk;
>>   };
>>     static int jz4740_wdt_ping(struct watchdog_device *wdt_dev)
>>   {
>>   	struct jz4740_wdt_drvdata *drvdata = 
>> watchdog_get_drvdata(wdt_dev);
>>   -	writew(0x0, drvdata->base + JZ_REG_WDT_TIMER_COUNTER);
>> +	regmap_write(drvdata->map, TCU_REG_WDT_TCNT, 0);
>>   	return 0;
>>   }
>>   @@ -80,52 +62,65 @@ static int jz4740_wdt_set_timeout(struct 
>> watchdog_device *wdt_dev,
>>   				    unsigned int new_timeout)
>>   {
>>   	struct jz4740_wdt_drvdata *drvdata = 
>> watchdog_get_drvdata(wdt_dev);
>> -	unsigned int rtc_clk_rate;
>> -	unsigned int timeout_value;
>> -	unsigned short clock_div = JZ_WDT_CLOCK_DIV_1;
>> -
>> -	rtc_clk_rate = clk_get_rate(drvdata->rtc_clk);
>> -
>> -	timeout_value = rtc_clk_rate * new_timeout;
>> -	while (timeout_value > 0xffff) {
>> -		if (clock_div == JZ_WDT_CLOCK_DIV_1024) {
>> -			/* Requested timeout too high;
>> -			* use highest possible value. */
>> -			timeout_value = 0xffff;
>> -			break;
>> -		}
>> -		timeout_value >>= 2;
>> -		clock_div += (1 << JZ_WDT_CLOCK_DIV_SHIFT);
>> +	struct clk *clk = drvdata->clk;
>> +	unsigned long clk_rate, timeout_value;
>> +	bool change_rate = false;
>> +	u32 tcer;
>> +	int ret = 0;
>> +
>> +	clk_rate = clk_get_rate(clk);
>> +	timeout_value = clk_rate * new_timeout;
>> +
>> +	if (timeout_value > 0xffff) {
>> +		clk_rate = clk_round_rate(clk, 0xffff / new_timeout);
>> +		timeout_value = clk_rate * new_timeout;
>> +		if (timeout_value > 0xffff)
>> +			return -EINVAL;
> 
> This is conceptually wrong. The probe code should determine the
> maximum timeout and report it to the watchdog core, and it should
> not be necessary to validate the timeout in this function.

That sounds better indeed.

> Also, unless I am missing something, the new code only ever reduces 
> the clock
> rate and never increases it. Given that, you might as well set the 
> clock
> rate to the lowest possible rate when instantiating the driver and not
> bother with updating it later. That would simplify the code 
> significantly
> and make it much easier to understand.

Actually I could even use whatever rate the clock is running at without 
trying
to change it within the driver. Then my clock provider can default to 
the highest
divider, and the rate would be overridable in devicetree for those who 
don't like
the default rate.

> Also, clk_round_rate() can technically return 0 or even a negative 
> (error)
> value. Please make sure that the returned rate is valid.
> 
>> +		change_rate = true;
>>   	}
>>   -	writeb(0x0, drvdata->base + JZ_REG_WDT_COUNTER_ENABLE);
>> -	writew(clock_div, drvdata->base + JZ_REG_WDT_TIMER_CONTROL);
>> +	regmap_read(drvdata->map, TCU_REG_WDT_TCER, &tcer);
>> +	regmap_write(drvdata->map, TCU_REG_WDT_TCER, 0);
>>   -	writew((u16)timeout_value, drvdata->base + 
>> JZ_REG_WDT_TIMER_DATA);
>> -	writew(0x0, drvdata->base + JZ_REG_WDT_TIMER_COUNTER);
>> -	writew(clock_div | JZ_WDT_CLOCK_RTC,
>> -		drvdata->base + JZ_REG_WDT_TIMER_CONTROL);
>> +	if (change_rate) {
>> +		clk_disable_unprepare(clk);
>> +		ret = clk_set_rate(clk, clk_rate);
>> +		clk_prepare_enable(clk);
>> +		if (ret)
>> +			goto done;
>> +	}
>>   -	writeb(0x1, drvdata->base + JZ_REG_WDT_COUNTER_ENABLE);
>> +	regmap_write(drvdata->map, TCU_REG_WDT_TDR, (u16)timeout_value);
>> +	regmap_write(drvdata->map, TCU_REG_WDT_TCNT, 0);
>>     	wdt_dev->timeout = new_timeout;
>> -	return 0;
>> +
>> +done:
>> +	regmap_write(drvdata->map, TCU_REG_WDT_TCER, tcer & 
>> TCU_WDT_TCER_TCEN);
> 
> regmap_read() and regmap_write return errors. Are those ignored on 
> purpose ?

Sort of. It's MMIO without IOMMU, what can go wrong?

>> +	return ret;
>>   }
>>     static int jz4740_wdt_start(struct watchdog_device *wdt_dev)
>>   {
>> -	jz4740_timer_enable_watchdog();
>> -	jz4740_wdt_set_timeout(wdt_dev, wdt_dev->timeout);
>> +	struct jz4740_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
>> +	int ret;
>>   -	return 0;
>> +	clk_prepare_enable(drvdata->clk);
>> +	ret = jz4740_wdt_set_timeout(wdt_dev, wdt_dev->timeout);
>> +	if (ret)
>> +		clk_disable_unprepare(drvdata->clk);
>> +	else
>> +		regmap_write(drvdata->map, TCU_REG_WDT_TCER, TCU_WDT_TCER_TCEN);
>> +
> 
> No else here please. Proper error handling is preferred.

Sure.

>> +	return ret;
>>   }
>>     static int jz4740_wdt_stop(struct watchdog_device *wdt_dev)
>>   {
>>   	struct jz4740_wdt_drvdata *drvdata = 
>> watchdog_get_drvdata(wdt_dev);
>>   -	writeb(0x0, drvdata->base + JZ_REG_WDT_COUNTER_ENABLE);
>> -	jz4740_timer_disable_watchdog();
>> +	regmap_write(drvdata->map, TCU_REG_WDT_TCER, 0);
>> +	clk_disable_unprepare(drvdata->clk);
>>     	return 0;
>>   }
>> @@ -163,13 +158,17 @@ MODULE_DEVICE_TABLE(of, jz4740_wdt_of_matches);
>>     static int jz4740_wdt_probe(struct platform_device *pdev)
>>   {
>> +	struct device *dev = &pdev->dev;
>>   	struct jz4740_wdt_drvdata *drvdata;
>>   	struct watchdog_device *jz4740_wdt;
>> -	struct resource	*res;
>>   	int ret;
>>   -	drvdata = devm_kzalloc(&pdev->dev, sizeof(struct 
>> jz4740_wdt_drvdata),
>> -			       GFP_KERNEL);
>> +	if (!dev->of_node) {
>> +		dev_err(dev, "jz4740-wdt must be probed via devicetree\n");
>> +		return -ENODEV;
>> +	}
>> +
> 
> Please explain. This check seems technically unnecessary and thus 
> pointless.
> The driver doesn't even initialize its watchdog timeout from 
> devicetree data.

Right, we get the regmap from the device's parent but that does not 
imply devicetree.
I'll remove that.

>> +	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>>   	if (!drvdata)
>>   		return -ENOMEM;
>>   @@ -182,19 +181,20 @@ static int jz4740_wdt_probe(struct 
>> platform_device *pdev)
>>   	jz4740_wdt->timeout = heartbeat;
>>   	jz4740_wdt->min_timeout = 1;
>>   	jz4740_wdt->max_timeout = MAX_HEARTBEAT;
>> -	jz4740_wdt->parent = &pdev->dev;
>> +	jz4740_wdt->parent = dev;
>>   	watchdog_set_nowayout(jz4740_wdt, nowayout);
>>   	watchdog_set_drvdata(jz4740_wdt, drvdata);
>>   -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> -	drvdata->base = devm_ioremap_resource(&pdev->dev, res);
>> -	if (IS_ERR(drvdata->base))
>> -		return PTR_ERR(drvdata->base);
>> +	drvdata->map = dev_get_regmap(dev->parent, NULL);
>> +	if (IS_ERR(drvdata->map)) {
> 
> dev_get_regmap() does not return an ERR_PTR().

Oops.

>> +		dev_warn(dev, "regmap not found\n");
>> +		return PTR_ERR(drvdata->map);
>> +	}
>>   -	drvdata->rtc_clk = devm_clk_get(&pdev->dev, "rtc");
>> -	if (IS_ERR(drvdata->rtc_clk)) {
>> -		dev_err(&pdev->dev, "cannot find RTC clock\n");
>> -		return PTR_ERR(drvdata->rtc_clk);
>> +	drvdata->clk = devm_clk_get(&pdev->dev, "wdt");
>> +	if (IS_ERR(drvdata->clk)) {
>> +		dev_err(&pdev->dev, "cannot find WDT clock\n");
>> +		return PTR_ERR(drvdata->clk);
>>   	}
>>     	ret = devm_watchdog_register_device(&pdev->dev, &drvdata->wdt);
>> 
> 

Thanks!
-Paul Cercueil
