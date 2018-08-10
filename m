Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Aug 2018 15:37:27 +0200 (CEST)
Received: from mail-pg1-x542.google.com ([IPv6:2607:f8b0:4864:20::542]:38305
        "EHLO mail-pg1-x542.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993920AbeHJNhUWdrg6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Aug 2018 15:37:20 +0200
Received: by mail-pg1-x542.google.com with SMTP id k3-v6so4425242pgq.5;
        Fri, 10 Aug 2018 06:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qrD4MvwhbLXYx3O4UgxKv0JmcAAJsljb/JibsHFiXpY=;
        b=EsfKQ/LrQi4sFaomV5SkvorBmveqoIYRx3GnMheCQF41otR5FKp1/gISuLyu4iELqj
         btzsmYkpFIHAz8za+KSdRGDbzQltZFT1AaR/y6AGhIatmrPPwDEr2pV6iAzcC6d8Vsfm
         eulRtJf2bq0DcmxKyRj8sfBI7MwN2/AhYKgmO6Eco8XJ9PgPuCNiliSZYnTYtPmIjjhS
         +dji1qoPUH8ItKVB4qiOrNeLiSJhk1JvAkO+VakKRrJJJ1R4Mo2QijzWCKRKZVNfxRs+
         NWMSSICv12or1FMhN1vfNiDeoESIWJUAZcBv7TUwGYwkhGaLohYifhf85q6zJGnYkMQM
         Pnaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qrD4MvwhbLXYx3O4UgxKv0JmcAAJsljb/JibsHFiXpY=;
        b=J+T6J+AmoV859AEEmU95XgqoM9Akh6rmKicgiuBiF4X+ayC6f0RnyTG6vhKEAs0y04
         ylv8NR3XAuTZm96MXdR7+h5tU94FZKk0oK/4PcyndDQglAtZw99lLg5KQ58r3KirksbT
         NgnQ+1BqHtBNOnSKEyvAEn1ynu48sientUp/QyJ8AS35xxsUKMPyogpoRB8/dU62buy6
         WfuBpq7MmJ0gstT3ow4j8iDQFRRtRYSmBOJidFz8eHgRFitEzp4QoTe2k0BMQxGQspzm
         rbKxRKCxfLZpfDmJEshJF09mMF3kJi6CQ9wNdGp3WVXJswXRD9gVO9JreyZF+aB911DR
         wz+w==
X-Gm-Message-State: AOUpUlE2VP7qg9hkTT0PKbLqQ0+xTCHs7wSIaX3X0jyELpcKrj/X+Clj
        L0kBpoY0OJvk0J1gP0fmbXQ=
X-Google-Smtp-Source: AA+uWPzGRUoq/rQF+MhLIARGldHLiuDiNMCKRLJLRnjt69lvBjDkGVexMXzCK0AEddQHuVDA8vNy4g==
X-Received: by 2002:a62:63c2:: with SMTP id x185-v6mr7034537pfb.13.1533908234304;
        Fri, 10 Aug 2018 06:37:14 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id a15-v6sm16487309pfe.32.2018.08.10.06.37.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 06:37:13 -0700 (PDT)
Date:   Fri, 10 Aug 2018 06:37:12 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mathieu Malaterre <malat@debian.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v6 09/24] watchdog: jz4740: Use regmap provided by TCU
 driver
Message-ID: <20180810133712.GB29028@roeck-us.net>
References: <20180809214414.20905-1-paul@crapouillou.net>
 <20180809214414.20905-10-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809214414.20905-10-paul@crapouillou.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65535
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

On Thu, Aug 09, 2018 at 11:43:59PM +0200, Paul Cercueil wrote:
> Since we broke the ABI by changing the clock, the driver was also
> updated to use the regmap provided by the TCU driver.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/jz4740_wdt.c | 30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
> 
>  v6: New patch
> 
> diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
> index 1d504ecf45e1..0f54306aee25 100644
> --- a/drivers/watchdog/jz4740_wdt.c
> +++ b/drivers/watchdog/jz4740_wdt.c
> @@ -13,6 +13,7 @@
>   *
>   */
>  
> +#include <linux/mfd/ingenic-tcu.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
>  #include <linux/types.h>
> @@ -25,10 +26,7 @@
>  #include <linux/slab.h>
>  #include <linux/err.h>
>  #include <linux/of.h>
> -
> -#define JZ_REG_WDT_TIMER_DATA     0x0
> -#define JZ_REG_WDT_COUNTER_ENABLE 0x4
> -#define JZ_REG_WDT_TIMER_COUNTER  0x8
> +#include <linux/regmap.h>
>  
>  #define DEFAULT_HEARTBEAT 5
>  #define MAX_HEARTBEAT     2048
> @@ -48,7 +46,7 @@ MODULE_PARM_DESC(heartbeat,
>  
>  struct jz4740_wdt_drvdata {
>  	struct watchdog_device wdt;
> -	void __iomem *base;
> +	struct regmap *map;
>  	struct clk *clk;
>  	unsigned long clk_rate;
>  };
> @@ -57,7 +55,7 @@ static int jz4740_wdt_ping(struct watchdog_device *wdt_dev)
>  {
>  	struct jz4740_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
>  
> -	writew(0x0, drvdata->base + JZ_REG_WDT_TIMER_COUNTER);
> +	regmap_write(drvdata->map, TCU_REG_WDT_TCNT, 0);
>  	return 0;
>  }
>  
> @@ -67,12 +65,12 @@ static int jz4740_wdt_set_timeout(struct watchdog_device *wdt_dev,
>  	struct jz4740_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
>  	u16 timeout_value = (u16)(drvdata->clk_rate * new_timeout);
>  
> -	writeb(0x0, drvdata->base + JZ_REG_WDT_COUNTER_ENABLE);
> +	regmap_write(drvdata->map, TCU_REG_WDT_TCER, 0);
>  
> -	writew((u16)timeout_value, drvdata->base + JZ_REG_WDT_TIMER_DATA);
> -	writew(0x0, drvdata->base + JZ_REG_WDT_TIMER_COUNTER);
> +	regmap_write(drvdata->map, TCU_REG_WDT_TDR, timeout_value);
> +	regmap_write(drvdata->map, TCU_REG_WDT_TCNT, 0);
>  
> -	writeb(0x1, drvdata->base + JZ_REG_WDT_COUNTER_ENABLE);
> +	regmap_write(drvdata->map, TCU_REG_WDT_TCER, TCU_WDT_TCER_TCEN);
>  
>  	wdt_dev->timeout = new_timeout;
>  	return 0;
> @@ -96,7 +94,7 @@ static int jz4740_wdt_stop(struct watchdog_device *wdt_dev)
>  {
>  	struct jz4740_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
>  
> -	writeb(0x0, drvdata->base + JZ_REG_WDT_COUNTER_ENABLE);
> +	regmap_write(drvdata->map, TCU_REG_WDT_TCER, 0);
>  	clk_disable_unprepare(drvdata->clk);
>  
>  	return 0;
> @@ -138,7 +136,6 @@ static int jz4740_wdt_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct jz4740_wdt_drvdata *drvdata;
>  	struct watchdog_device *jz4740_wdt;
> -	struct resource	*res;
>  	long rate;
>  	int ret;
>  
> @@ -174,10 +171,11 @@ static int jz4740_wdt_probe(struct platform_device *pdev)
>  	watchdog_set_nowayout(jz4740_wdt, nowayout);
>  	watchdog_set_drvdata(jz4740_wdt, drvdata);
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	drvdata->base = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(drvdata->base))
> -		return PTR_ERR(drvdata->base);
> +	drvdata->map = dev_get_regmap(dev->parent, NULL);
> +	if (!drvdata->map) {
> +		dev_err(dev, "regmap not found\n");
> +		return -EINVAL;
> +	}
>  
>  	ret = devm_watchdog_register_device(&pdev->dev, &drvdata->wdt);
>  	if (ret < 0)
> -- 
> 2.11.0
> 
