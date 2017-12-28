Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Dec 2017 19:40:27 +0100 (CET)
Received: from mail-pl0-x242.google.com ([IPv6:2607:f8b0:400e:c01::242]:34687
        "EHLO mail-pl0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990633AbdL1SkSx9GuO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Dec 2017 19:40:18 +0100
Received: by mail-pl0-x242.google.com with SMTP id d21so21581291pll.1;
        Thu, 28 Dec 2017 10:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HXXEaFQZ0f7w+C3LvHJHBLrMvZKS6MP1Qx3N6I2GNac=;
        b=EToTLwSLTU07F7G1Z6LfkyefDh/Sb1aLGFhYj1ZQtXP1u08XvRhcDfVvOBrxbdCxn1
         YttqiUMjFieL9/iS5zHC3kihI86kiPfqvL5/PzihQOKCO+VHTQKJ5REUs20W91UTp/2E
         IfuqplfQtFo0Yd379HFhqtk6SwxDd8oNW5kR51vBguweCMNJsrOtG0c7fiBjmlbW2+zd
         o1d4nCPFntUentRSg77va7+weuBsbkm2MkOHCUMAZB0CfWOcQlmBYUp+zVYP+lHE5tzR
         cneEf3fE14LxH1NGbzRnT05ZGac2Swh3Nto4s7p0bB0UdIx0LrTLvOGUeacwWqlpMKPG
         Op7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HXXEaFQZ0f7w+C3LvHJHBLrMvZKS6MP1Qx3N6I2GNac=;
        b=RSk9o9eMenAexKjds94tQJKGQ7TdrCm6wtjFwSvd51nWVhYwZ0BGqf13U1nN5rCvxR
         mI2vR0H61vNnZ86oqaR4CzxOEHbFxk5/H8X+LQNlOsgQwPdNfDvhxdUCUXZNxPnDQsvD
         oOfMimTm0mdjk7G/NO0TnRb1BVUw7mOz/7wHiVDEWwf87e0Z6Lzg68VtlUD283bYKxDb
         SM6DPb1dczMrq04Ijndag/nnUw23//uhU59zn+ly9R8errPU4yQHk8fAjmogz1Zfs0Jb
         Nepjl7ewQ6NseGADHoyD4ns4NF9SE7yyEDcgXcLwzBVjGtJJHS/08hhUXGZe2KN0IvKE
         UF/A==
X-Gm-Message-State: AKGB3mJVpuPeZtsrk08R0SqFoUwqyAr3wtOLKJGGzmNk/xfzKaDSI0S0
        v41jS379B0yMVozZSWki6Yk=
X-Google-Smtp-Source: ACJfBotoBZR/oiPSTNcbcmAkU/hT+K5uKhJNfWCx39Rb2SoJZfed0sVTQdmM4wAuYXgZHIdsYSFMmw==
X-Received: by 10.84.172.195 with SMTP id n61mr31739907plb.78.1514486412886;
        Thu, 28 Dec 2017 10:40:12 -0800 (PST)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id i85sm71948421pfi.54.2017.12.28.10.40.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Dec 2017 10:40:12 -0800 (PST)
Subject: Re: [PATCH 2/7] watchdog: jz4740: Use devm_* functions
To:     Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>
Cc:     devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20171228162939.3928-1-paul@crapouillou.net>
 <20171228162939.3928-3-paul@crapouillou.net>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <9b5a2b88-995b-0540-6cf5-aba8b1ba6508@roeck-us.net>
Date:   Thu, 28 Dec 2017 10:40:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171228162939.3928-3-paul@crapouillou.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61686
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

On 12/28/2017 08:29 AM, Paul Cercueil wrote:
> - Use devm_clk_get instead of clk_get
> - Use devm_watchdog_register_device instead of watchdog_register_device
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

[ the change I suggested earlier should be made in a separate patch ]

> ---
>   drivers/watchdog/jz4740_wdt.c | 27 ++++++++-------------------
>   1 file changed, 8 insertions(+), 19 deletions(-)
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
