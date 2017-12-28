Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Dec 2017 22:03:52 +0100 (CET)
Received: from mail-pg0-x241.google.com ([IPv6:2607:f8b0:400e:c05::241]:44259
        "EHLO mail-pg0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990486AbdL1VDobcvNZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Dec 2017 22:03:44 +0100
Received: by mail-pg0-x241.google.com with SMTP id i5so4282390pgq.11;
        Thu, 28 Dec 2017 13:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dS3mjhqIZ98R/eRVC94/WGkOe+2SwATB2PI8pdnsN5g=;
        b=RwXXbnGN9yUKNXlbm62YmCLiLa0TF3pzobLN6pZQgEjla1Fud8cDoK2RaWgsW9GGY3
         XhxAp8lfVO18KFznL0u0aGdNfp3s9UbdhIJ9SRSTemNHAE3ZiYfhOakcmBi67GRzsie6
         BQ5FjK1si0g5+ZDjgXsdXBqWBM9kmBP8yKZtB/04dLcF6db7MWkntvYCxTxbabOFuP8e
         v9ynehupxh8O7+prnfTA7N35w40HJkPvAfNFo4eOXFamMHt5f69TEZCwLpZZrMyHNztH
         8nWTR29qyrXnuIkDCGE537GjzAdtJwbfhHeUYyM+53WRAg0kuHUbkBPtfZvrJcJICImj
         kiMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dS3mjhqIZ98R/eRVC94/WGkOe+2SwATB2PI8pdnsN5g=;
        b=Cdqon8Mt2ZeUS/vEHtgsfU898sCgmiHSlmJFbG33YqRlXmTiGqeAXjSnHsyyjai/cW
         +IxvUZrmddwZcfyUy4/SYqpUGy3wctJ58LDCTio0aFiYGw9sT+w5UGDiT7l/Te24PYjw
         BSkenAiakEN1iBdvbE/1+K5hFx6tlTcQS8C+db6AQCt2CmIep9FznFUou1NABVLoyEX3
         8zQW0rtjReclPm4JF2YVkQqL4izlv1klZqO2kPjfe+HpWBc9r8yn2UqA/8XuGnIM/v1B
         UptRumizHN6H6UNH0iq8ijlc4UGnwBO3E9MTywtCYljapxA6kMkovwayMmIWktg4WM7K
         zv7Q==
X-Gm-Message-State: AKGB3mLGGHqK7MCFmGUeLh0AMVBGzcCOvXAQew0c6yNHyQS0Uol0R6Oa
        5I0opmJj6rPEKEGv6q5PhL4=
X-Google-Smtp-Source: ACJfBouOmr1FS7GQANJntMPmb8D/jKKxtgyP7jZUnxYjzfWWE1ALnqwWVpkpfZXTHHF0MToOMFMIUw==
X-Received: by 10.98.16.90 with SMTP id y87mr33245970pfi.116.1514495017738;
        Thu, 28 Dec 2017 13:03:37 -0800 (PST)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id i20sm72277856pfj.58.2017.12.28.13.03.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Dec 2017 13:03:36 -0800 (PST)
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
 <994187b3-113c-88ef-8ebd-cd57d0c833a0@roeck-us.net>
 <1514492538.6093.1@smtp.crapouillou.net>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <de7b629e-35b6-a55c-d7ca-57c145fa30ae@roeck-us.net>
Date:   Thu, 28 Dec 2017 13:03:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1514492538.6093.1@smtp.crapouillou.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61691
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

On 12/28/2017 12:22 PM, Paul Cercueil wrote:
> 
> 
> Le jeu. 28 déc. 2017 à 21:19, Guenter Roeck <linux@roeck-us.net> a écrit :
>> On 12/28/2017 11:59 AM, Paul Cercueil wrote:
>>> Hi Guenter,
>>>
>>> Le jeu. 28 déc. 2017 à 18:48, Guenter Roeck <linux@roeck-us.net> a écrit :
>>>> On 12/28/2017 08:29 AM, Paul Cercueil wrote:
>>>>> - Use devm_clk_get instead of clk_get
>>>>> - Use devm_watchdog_register_device instead of watchdog_register_device
>>>>>
>>>>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>>>> ---
>>>>>   drivers/watchdog/jz4740_wdt.c | 27 ++++++++-------------------
>>>>>   1 file changed, 8 insertions(+), 19 deletions(-)
>>>>>
>>>>> diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
>>>>> index 6955deb100ef..92d6ca8ceb49 100644
>>>>> --- a/drivers/watchdog/jz4740_wdt.c
>>>>> +++ b/drivers/watchdog/jz4740_wdt.c
>>>>> @@ -178,40 +178,29 @@ static int jz4740_wdt_probe(struct platform_device *pdev)
>>>>>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>>>       drvdata->base = devm_ioremap_resource(&pdev->dev, res);
>>>>> -    if (IS_ERR(drvdata->base)) {
>>>>> -        ret = PTR_ERR(drvdata->base);
>>>>> -        goto err_out;
>>>>> -    }
>>>>> +    if (IS_ERR(drvdata->base))
>>>>> +        return PTR_ERR(drvdata->base);
>>>>>   -    drvdata->rtc_clk = clk_get(&pdev->dev, "rtc");
>>>>> +    drvdata->rtc_clk = devm_clk_get(&pdev->dev, "rtc");
>>>>>       if (IS_ERR(drvdata->rtc_clk)) {
>>>>>           dev_err(&pdev->dev, "cannot find RTC clock\n");
>>>>> -        ret = PTR_ERR(drvdata->rtc_clk);
>>>>> -        goto err_out;
>>>>> +        return PTR_ERR(drvdata->rtc_clk);
>>>>>       }
>>>>>   -    ret = watchdog_register_device(&drvdata->wdt);
>>>>> +    ret = devm_watchdog_register_device(&pdev->dev, &drvdata->wdt);
>>>>>       if (ret < 0)
>>>>> -        goto err_disable_clk;
>>>>> +        return ret;
>>>>>         platform_set_drvdata(pdev, drvdata);
>>>>> -    return 0;
>>>>>   -err_disable_clk:
>>>>> -    clk_put(drvdata->rtc_clk);
>>>>> -err_out:
>>>>> -    return ret;
>>>>> +    return 0;
>>>>>   }
>>>>>     static int jz4740_wdt_remove(struct platform_device *pdev)
>>>>>   {
>>>>>       struct jz4740_wdt_drvdata *drvdata = platform_get_drvdata(pdev);
>>>>>   -    jz4740_wdt_stop(&drvdata->wdt);
>>>>> -    watchdog_unregister_device(&drvdata->wdt);
>>>>> -    clk_put(drvdata->rtc_clk);
>>>>> -
>>>>> -    return 0;
>>>>> +    return jz4740_wdt_stop(&drvdata->wdt);
>>>>
>>>> If the watchdog is running, the module can not be unloaded. Even if that wasn't
>>>> the case, this defeats both WDIOF_MAGICCLOSE and watchdog_set_nowayout().
>>>> Are you sure this is what you want ? If so, please call
>>>> watchdog_stop_on_unregister() before registration; this clarifies that this
>>>> is what you want, and you can drop the remove function.
>>>>
>>>> Thanks,
>>>> Guenter
>>>
>>> This patch does not change the behaviour. We always used that driver built-in; what
>>> should the behaviour be when unloading the module? Keep the watchdog hardware running
>>> if configured for 'nowayout'?
>>>
>>
>> One can still unload the driver. If you are fine with bypassing/dfeating nowayout
>> and WDIOF_MAGICCLOSE, may I ask why those are enabled in the first place ?
>>
> 
> Who knows? That code is very old :)

Probably copied from some other driver w/o thinking much about it.

> I'm fine with removing the remove() function completely, if you think it makes more sense.
> 

Yes, I do, but I won't insist on it either.

Thanks,
Guenter
