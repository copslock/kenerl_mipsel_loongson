Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Dec 2017 20:59:48 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:52826 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990486AbdL1T7kwi4Jm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Dec 2017 20:59:40 +0100
Date:   Thu, 28 Dec 2017 20:59:27 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 2/7] watchdog: jz4740: Use devm_* functions
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Message-Id: <1514491167.6093.0@smtp.crapouillou.net>
In-Reply-To: <9778afd4-5841-0d48-cde3-c02872623a5f@roeck-us.net>
References: <20171228162939.3928-1-paul@crapouillou.net>
        <20171228162939.3928-3-paul@crapouillou.net>
        <9778afd4-5841-0d48-cde3-c02872623a5f@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1514491176; bh=VK05wWYKWBJ8tXTNBOrGMQNk4kAKDan2h6sC15NiVSM=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding; b=j/lLp1DXkfr1MZqFV9g4a/eSsS66U35bEfcAL38fq5SqMs2yVVQA3W5RFZX5r9+0HwLEyRv2aPpF8F/fDlESrB65bcvD7zK5ciwI+xBFexkLckI0YgY3miYxve/IvobHftoa8ev5inPUziRhs2YKabfwvnYv4R3fVl71rP6h8Yc=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61688
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

Le jeu. 28 d�c. 2017 � 18:48, Guenter Roeck <linux@roeck-us.net> a 
�crit :
> On 12/28/2017 08:29 AM, Paul Cercueil wrote:
>> - Use devm_clk_get instead of clk_get
>> - Use devm_watchdog_register_device instead of 
>> watchdog_register_device
>> 
>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>> ---
>>   drivers/watchdog/jz4740_wdt.c | 27 ++++++++-------------------
>>   1 file changed, 8 insertions(+), 19 deletions(-)
>> 
>> diff --git a/drivers/watchdog/jz4740_wdt.c 
>> b/drivers/watchdog/jz4740_wdt.c
>> index 6955deb100ef..92d6ca8ceb49 100644
>> --- a/drivers/watchdog/jz4740_wdt.c
>> +++ b/drivers/watchdog/jz4740_wdt.c
>> @@ -178,40 +178,29 @@ static int jz4740_wdt_probe(struct 
>> platform_device *pdev)
>>     	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>   	drvdata->base = devm_ioremap_resource(&pdev->dev, res);
>> -	if (IS_ERR(drvdata->base)) {
>> -		ret = PTR_ERR(drvdata->base);
>> -		goto err_out;
>> -	}
>> +	if (IS_ERR(drvdata->base))
>> +		return PTR_ERR(drvdata->base);
>>   -	drvdata->rtc_clk = clk_get(&pdev->dev, "rtc");
>> +	drvdata->rtc_clk = devm_clk_get(&pdev->dev, "rtc");
>>   	if (IS_ERR(drvdata->rtc_clk)) {
>>   		dev_err(&pdev->dev, "cannot find RTC clock\n");
>> -		ret = PTR_ERR(drvdata->rtc_clk);
>> -		goto err_out;
>> +		return PTR_ERR(drvdata->rtc_clk);
>>   	}
>>   -	ret = watchdog_register_device(&drvdata->wdt);
>> +	ret = devm_watchdog_register_device(&pdev->dev, &drvdata->wdt);
>>   	if (ret < 0)
>> -		goto err_disable_clk;
>> +		return ret;
>>     	platform_set_drvdata(pdev, drvdata);
>> -	return 0;
>>   -err_disable_clk:
>> -	clk_put(drvdata->rtc_clk);
>> -err_out:
>> -	return ret;
>> +	return 0;
>>   }
>>     static int jz4740_wdt_remove(struct platform_device *pdev)
>>   {
>>   	struct jz4740_wdt_drvdata *drvdata = platform_get_drvdata(pdev);
>>   -	jz4740_wdt_stop(&drvdata->wdt);
>> -	watchdog_unregister_device(&drvdata->wdt);
>> -	clk_put(drvdata->rtc_clk);
>> -
>> -	return 0;
>> +	return jz4740_wdt_stop(&drvdata->wdt);
> 
> If the watchdog is running, the module can not be unloaded. Even if 
> that wasn't
> the case, this defeats both WDIOF_MAGICCLOSE and 
> watchdog_set_nowayout().
> Are you sure this is what you want ? If so, please call
> watchdog_stop_on_unregister() before registration; this clarifies 
> that this
> is what you want, and you can drop the remove function.
> 
> Thanks,
> Guenter

This patch does not change the behaviour. We always used that driver 
built-in; what
should the behaviour be when unloading the module? Keep the watchdog 
hardware running
if configured for 'nowayout'?

Thanks,
-Paul

> 
>>   }
>>     static struct platform_driver jz4740_wdt_driver = {
>> 
> 
