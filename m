Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Dec 2017 21:19:46 +0100 (CET)
Received: from mail-pg0-x243.google.com ([IPv6:2607:f8b0:400e:c05::243]:37389
        "EHLO mail-pg0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990491AbdL1UTh6JlOm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Dec 2017 21:19:37 +0100
Received: by mail-pg0-x243.google.com with SMTP id o13so9485822pgp.4;
        Thu, 28 Dec 2017 12:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z4aDVpce/W4gayYL1c5FMqDLSvmjZ43ypchulIzHlzw=;
        b=GK3y2bwy0mMvIwOQDwDtUvockzC7V6E/hHelbqjL2AxeaJtgrIvdacgLb06aXQ/hfF
         QYNkSZjTXlC2hvpwSryd0Io98K6Qp7bDh3alFdnZY33oPf1/cH+FRFSbeupTN1qezQ4w
         OQWxJDX4SgMAGPo9rvtxR5Rl5m66gu7Fhog1EQjKRnzk/7s9xqRVCmPLD5P9sZpQOTQx
         RzoiDgKCo+Jvx8DaxiwOlxlb1JylU84VeK4bsDGnNUy62QVj/ITpJrEObyKrDw2Kstey
         /wozOaNLRV4NbkXsYTcvwW7KDLGylwdc/Qw9QmcClGQ2HiID9wsQPuSHHZ6nxOeE1sbB
         ihmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z4aDVpce/W4gayYL1c5FMqDLSvmjZ43ypchulIzHlzw=;
        b=Pn9BQiiBDJIcacl8s7P+uvOGJIrdGsKwnx97aNBDJ5mv5gbUV/eNvc3KVHIyXU12/g
         pifGWTKb4QY+EQUzyyicexQUYjeyxc82auaR+t6Gx2pXUSnU6tyFJ3C+LNMC0mUH2RLt
         G2rnRRHXajR7lPOxG+aTG9pUODKtKbZqSsoPD+Z3GsloQMREqgnsIf7uN4Fz85Ete0AH
         w/hbcyYqOCJTBN7zVxu7FXbq0tlpIJDb5bHavmyUWEcB3oUhwTBglw/aqtC4xvs7zdIe
         i0DaVMBa5h0EcEJiv+qNFBsc/5PxRdR+vorkBKzsDhO4cc8iBeDyY8hyaitHENrRpbcl
         s49g==
X-Gm-Message-State: AKGB3mLiE2NIIv9q65Gy4E8EBnEphZwq2ISzAwWL8hvUCNP2mozx2zdT
        1zfZs6kf5S/FQg1DzgrH/bo=
X-Google-Smtp-Source: ACJfBovUctAEeLa90lArcnuiu/e14oIpccRHDS2ntyBVdckzDHGuhDcEGDje1c9woior9KOwLWp6/g==
X-Received: by 10.98.163.200 with SMTP id q69mr32203790pfl.21.1514492371385;
        Thu, 28 Dec 2017 12:19:31 -0800 (PST)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 75sm74562083pfo.103.2017.12.28.12.19.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Dec 2017 12:19:29 -0800 (PST)
Subject: Re: [PATCH 2/7] watchdog: jz4740: Use devm_* functions
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org
References: <20171228162939.3928-1-paul@crapouillou.net>
 <20171228162939.3928-3-paul@crapouillou.net>
 <9778afd4-5841-0d48-cde3-c02872623a5f@roeck-us.net>
 <1514491167.6093.0@smtp.crapouillou.net>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <994187b3-113c-88ef-8ebd-cd57d0c833a0@roeck-us.net>
Date:   Thu, 28 Dec 2017 12:19:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1514491167.6093.0@smtp.crapouillou.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61689
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

On 12/28/2017 11:59 AM, Paul Cercueil wrote:
> Hi Guenter,
> 
> Le jeu. 28 déc. 2017 à 18:48, Guenter Roeck <linux@roeck-us.net> a écrit :
>> On 12/28/2017 08:29 AM, Paul Cercueil wrote:
>>> - Use devm_clk_get instead of clk_get
>>> - Use devm_watchdog_register_device instead of watchdog_register_device
>>>
>>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>> ---
>>>   drivers/watchdog/jz4740_wdt.c | 27 ++++++++-------------------
>>>   1 file changed, 8 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
>>> index 6955deb100ef..92d6ca8ceb49 100644
>>> --- a/drivers/watchdog/jz4740_wdt.c
>>> +++ b/drivers/watchdog/jz4740_wdt.c
>>> @@ -178,40 +178,29 @@ static int jz4740_wdt_probe(struct platform_device *pdev)
>>>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>       drvdata->base = devm_ioremap_resource(&pdev->dev, res);
>>> -    if (IS_ERR(drvdata->base)) {
>>> -        ret = PTR_ERR(drvdata->base);
>>> -        goto err_out;
>>> -    }
>>> +    if (IS_ERR(drvdata->base))
>>> +        return PTR_ERR(drvdata->base);
>>>   -    drvdata->rtc_clk = clk_get(&pdev->dev, "rtc");
>>> +    drvdata->rtc_clk = devm_clk_get(&pdev->dev, "rtc");
>>>       if (IS_ERR(drvdata->rtc_clk)) {
>>>           dev_err(&pdev->dev, "cannot find RTC clock\n");
>>> -        ret = PTR_ERR(drvdata->rtc_clk);
>>> -        goto err_out;
>>> +        return PTR_ERR(drvdata->rtc_clk);
>>>       }
>>>   -    ret = watchdog_register_device(&drvdata->wdt);
>>> +    ret = devm_watchdog_register_device(&pdev->dev, &drvdata->wdt);
>>>       if (ret < 0)
>>> -        goto err_disable_clk;
>>> +        return ret;
>>>         platform_set_drvdata(pdev, drvdata);
>>> -    return 0;
>>>   -err_disable_clk:
>>> -    clk_put(drvdata->rtc_clk);
>>> -err_out:
>>> -    return ret;
>>> +    return 0;
>>>   }
>>>     static int jz4740_wdt_remove(struct platform_device *pdev)
>>>   {
>>>       struct jz4740_wdt_drvdata *drvdata = platform_get_drvdata(pdev);
>>>   -    jz4740_wdt_stop(&drvdata->wdt);
>>> -    watchdog_unregister_device(&drvdata->wdt);
>>> -    clk_put(drvdata->rtc_clk);
>>> -
>>> -    return 0;
>>> +    return jz4740_wdt_stop(&drvdata->wdt);
>>
>> If the watchdog is running, the module can not be unloaded. Even if that wasn't
>> the case, this defeats both WDIOF_MAGICCLOSE and watchdog_set_nowayout().
>> Are you sure this is what you want ? If so, please call
>> watchdog_stop_on_unregister() before registration; this clarifies that this
>> is what you want, and you can drop the remove function.
>>
>> Thanks,
>> Guenter
> 
> This patch does not change the behaviour. We always used that driver built-in; what
> should the behaviour be when unloading the module? Keep the watchdog hardware running
> if configured for 'nowayout'?
> 

One can still unload the driver. If you are fine with bypassing/dfeating nowayout
and WDIOF_MAGICCLOSE, may I ask why those are enabled in the first place ?

Thanks,
Guenter
