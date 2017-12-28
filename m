Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Dec 2017 18:48:32 +0100 (CET)
Received: from mail-pl0-x242.google.com ([IPv6:2607:f8b0:400e:c01::242]:39683
        "EHLO mail-pl0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990493AbdL1RsWKTED2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Dec 2017 18:48:22 +0100
Received: by mail-pl0-x242.google.com with SMTP id bi12so21498600plb.6;
        Thu, 28 Dec 2017 09:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=niPbrEyzIsbRVtQFNzqIXQV+K7tQt2XKBFIMKUd5zLk=;
        b=OXtny8an4XpeUw9PxxgtEpkJMEgPHT/7Jpz5C2odRWBpmZTGQ9+NPMYxwuUVmUkhfU
         Al3FAM5wVsC5OsCkqGWII2UxLoYgpgzNm2YogoK9JWsM23Lz4YxSpkyg8vhfyC8mfvvM
         qvwSXfUGW2FMIqn2PsgfR8ENsxw9yuHWfn5TkiijfBvJBdESSXWWZkra8lAzUPzMnDzU
         t2RMxGhFRS2ujRfoNtVlubuFEaEvgrAhP/NG0SRbQD/imVa5NYyAyXZ7+uBJWj3iKpaO
         2brnw2wcca8PXtQW/Sb6xrgubtCKo50q1vynhYs6VXVylP2qzbZKUln8GLpKjFB0Wzyu
         hZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=niPbrEyzIsbRVtQFNzqIXQV+K7tQt2XKBFIMKUd5zLk=;
        b=ovAcoKsCwIgCh4NYyIfsdjGJSgMyjDV/pa9I1Jakoap8B4/t76k8ZnArD9iwW/a6S7
         7mjGbwE9wLV9ND5L2pKzWTV4HpQcNJ5K8oqa9ilTVY2Qk+vj3iMytiiWAEdQgKPyd55C
         HPkdpMWIfTDlEq95idN37BIPAdNWtOqJgVAjf7SjTKEpSMPjZPBnfNT4cJgkeVui86n1
         I69L81hZacoi0DEYuPoWhBhWr7OorUxwm3KRPPX/KFqpBGV7nku4FxS8ixGrU8xMnhWF
         xvvSb38hnkLqmfj8DgemAo2a9h1s8csPHNgU6Oqwr/sYd0DNjULp+Fz4NyI66Gazq3Wr
         wx9Q==
X-Gm-Message-State: AKGB3mIRU7PNrv+UyfqoC8DLYFR1MmnFvoElaXHhxAg7uysA88UdpFh7
        72ysFHBKuw07hDOB6GgYq33JuQ==
X-Google-Smtp-Source: ACJfBot0PGVvg5/NVi70NEYJ/idOo67wPkXlNBDBdBKLjGPMEEjo8S6gsbgbsb3hUiVlLBhJoJ496w==
X-Received: by 10.84.168.198 with SMTP id f64mr32818626plb.324.1514483292515;
        Thu, 28 Dec 2017 09:48:12 -0800 (PST)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id x3sm57361661pgv.73.2017.12.28.09.48.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Dec 2017 09:48:11 -0800 (PST)
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
Message-ID: <9778afd4-5841-0d48-cde3-c02872623a5f@roeck-us.net>
Date:   Thu, 28 Dec 2017 09:48:09 -0800
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
X-archive-position: 61679
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

If the watchdog is running, the module can not be unloaded. Even if that wasn't
the case, this defeats both WDIOF_MAGICCLOSE and watchdog_set_nowayout().
Are you sure this is what you want ? If so, please call
watchdog_stop_on_unregister() before registration; this clarifies that this
is what you want, and you can drop the remove function.

Thanks,
Guenter

>   }
>   
>   static struct platform_driver jz4740_wdt_driver = {
> 
