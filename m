Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Dec 2017 17:08:21 +0100 (CET)
Received: from mail-pl0-x242.google.com ([IPv6:2607:f8b0:400e:c01::242]:38171
        "EHLO mail-pl0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990412AbdL3QIOMc-wh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Dec 2017 17:08:14 +0100
Received: by mail-pl0-x242.google.com with SMTP id s10so24608110plj.5;
        Sat, 30 Dec 2017 08:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fuGDC9Y6enOhX/kFsNd+UhB9SrO35jOXe6viGPBMqOI=;
        b=V5+eJeQq6xjlEiOT7ZV4YPMFEv2hJ/Rgig/ZmmVXV0k5kgxQ5dcB4hYuu/U5IF7R6h
         kR4Z3n+h8u+m1tPOHs5J6ie69LxEu0NkYOfWl3v14Zg6X9lXTGrdkQz/PbLcNIT1jNsR
         5MhkIwafQuLWUdVjtt67tpQ6caA7UCflnpU+Zp+R9AZhsXejQj1u6tgkzpi5X51blen/
         z1uO10uyctraJNACkK/zVANZOY9UyER7cUFDK2V8i2Yq7gh68tEkCaHJy5ox/D8204Yn
         Eh6A9O+nyzL5ZaVyvpdRlmIw7jmou7H20095cqqYAOKJNFK2USCiOMcUgOBEwvhfQY8k
         ST3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fuGDC9Y6enOhX/kFsNd+UhB9SrO35jOXe6viGPBMqOI=;
        b=s9BxMoOjD8Srk4Qc5mCTJT3qPypKsqTrShMX+6xzfr3AocVFXuUdxvrZ71SpIdoUVt
         fBsCqPjpgnI+jUAPwxsEC8m9aps583EtAIcM+VhDdt+LAj+gl2RDlPgRqcMCKRDJTA6i
         9oqa/rwfZEkOGMdaB6EA7u9FlTnuY9W0p7YA/vJECNpNXDpJrTy8Uocd2IUZ+lZfCw1H
         vW3C/mnXvDuplo0ZOgBP/emvzmFJrc7myl3cwgWwS6O/+8lcyYvwznZptyxNW+lVo2lT
         /RC4M+r7UjIyN/UdOwnbbtv3Db3L04hs22SharMPOk7CQYORHuKYiTcryFWQ3nZWMXfc
         fA5Q==
X-Gm-Message-State: AKGB3mL8+JcFLf63ACVAWkUui1bBL0o3aHkPHqzpxulb8OZWzagsCzq5
        067qxQp2oc4Ym+oJRAfF9e0=
X-Google-Smtp-Source: ACJfBotFeTQi4Oe0DJuGbMX2BcceaxN7gkAubtrqy0+s7Ic3Q4mcxc40QjMXlGnKCgtyes9dMyuPlg==
X-Received: by 10.84.234.193 with SMTP id i1mr37546099plt.206.1514650087525;
        Sat, 30 Dec 2017 08:08:07 -0800 (PST)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id z78sm84065698pfk.115.2017.12.30.08.08.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Dec 2017 08:08:06 -0800 (PST)
Subject: Re: [PATCH v2 2/8] watchdog: jz4740: Use devm_* functions
To:     Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>
Cc:     devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20171228162939.3928-2-paul@crapouillou.net>
 <20171230135108.6834-1-paul@crapouillou.net>
 <20171230135108.6834-2-paul@crapouillou.net>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <b0d75a0e-a698-a06e-22ff-446a186357d0@roeck-us.net>
Date:   Sat, 30 Dec 2017 08:08:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171230135108.6834-2-paul@crapouillou.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61786
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

On 12/30/2017 05:51 AM, Paul Cercueil wrote:
> - Use devm_clk_get instead of clk_get
> - Use devm_watchdog_register_device instead of watchdog_register_device
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/jz4740_wdt.c | 27 ++++++++-------------------
>   1 file changed, 8 insertions(+), 19 deletions(-)
> 
>   v2: No change
> 
> diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
> index 6955deb100ef..92d6ca8ceb49 100644
> --- a/drivers/watchdog/jz4740_wdt.c
> +++ b/drivers/watchdog/jz4740_wdt.c
> @@ -178,40 +178,29 @@ static int jz4740_wdt_probe(struct platform_device *pdev)
>   
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   	drvdata->base = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(drvdata->base)) {
> -		ret = PTR_ERR(drvdata->base);
> -		goto err_out;
> -	}
> +	if (IS_ERR(drvdata->base))
> +		return PTR_ERR(drvdata->base);
>   
> -	drvdata->rtc_clk = clk_get(&pdev->dev, "rtc");
> +	drvdata->rtc_clk = devm_clk_get(&pdev->dev, "rtc");
>   	if (IS_ERR(drvdata->rtc_clk)) {
>   		dev_err(&pdev->dev, "cannot find RTC clock\n");
> -		ret = PTR_ERR(drvdata->rtc_clk);
> -		goto err_out;
> +		return PTR_ERR(drvdata->rtc_clk);
>   	}
>   
> -	ret = watchdog_register_device(&drvdata->wdt);
> +	ret = devm_watchdog_register_device(&pdev->dev, &drvdata->wdt);
>   	if (ret < 0)
> -		goto err_disable_clk;
> +		return ret;
>   
>   	platform_set_drvdata(pdev, drvdata);
> -	return 0;
>   
> -err_disable_clk:
> -	clk_put(drvdata->rtc_clk);
> -err_out:
> -	return ret;
> +	return 0;
>   }
>   
>   static int jz4740_wdt_remove(struct platform_device *pdev)
>   {
>   	struct jz4740_wdt_drvdata *drvdata = platform_get_drvdata(pdev);
>   
> -	jz4740_wdt_stop(&drvdata->wdt);
> -	watchdog_unregister_device(&drvdata->wdt);
> -	clk_put(drvdata->rtc_clk);
> -
> -	return 0;
> +	return jz4740_wdt_stop(&drvdata->wdt);
>   }
>   
>   static struct platform_driver jz4740_wdt_driver = {
> 
