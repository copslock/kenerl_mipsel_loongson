Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Jan 2018 16:51:04 +0100 (CET)
Received: from mail-pf0-x242.google.com ([IPv6:2607:f8b0:400e:c00::242]:37855
        "EHLO mail-pf0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990397AbeATPu4fezn0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Jan 2018 16:50:56 +0100
Received: by mail-pf0-x242.google.com with SMTP id p1so3700703pfh.4;
        Sat, 20 Jan 2018 07:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/a2ZpdEwhBQiWQPo0dyRRux/M+g+ubK4t/gvWq+qUxg=;
        b=Ik3LXIYj4oxJ/6JzbU+hpasapHY21Zr9DB7TJHhhHBYic5xEEW0euMCjsECUNOvoTZ
         5ZuoyiRGwHXH1DxmpArEbIko/87mPSK4YSFr+/E1469nkkTXa7Y7wIUqP9HimwNPa6dg
         9c9JgIpegtX2v8iVC6nNv6t+pOaG63EvdiJmK0+tbl66aCFy1KPz5wcdNLVs644L62NY
         FwJA6NSFTk+eTqDfH21O7fh131EhPnKqpn4x5RDFr+AtG25mazkSBmK/RXP542916DAw
         e7tgr8FuNbk0P/aUje0OzqT6iPGDhWHDsJCgQv/sfllH4wzA+JSiWbwnjzNFdXKkHH06
         WpRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/a2ZpdEwhBQiWQPo0dyRRux/M+g+ubK4t/gvWq+qUxg=;
        b=JPkVvfyfa03jROtdWR2TJCWO0CT7nVNGEkppjWQW3Uq3uzVgwzfNSU7G2LHBoHaOCd
         Ksy72KDdTxWwd/7gBlr/GM9pDqIqzkbDlnGcyAkJB4joYyX/+Hp8I6nTXWJImQHcuhw0
         +nb2tjCqQN45aEO2J42deJzG6vWdl0zlKTd5H7u2yQPaw1LrhNci01If6Q7tS9tLRIIL
         Yl5th5dVxoPGsdebgs+78pG3D2IoPyxguuaKpxjC294uqXMpWun4S6mZ+Gu8iOraQcf/
         RkkDHsSGeM0ZJqQrI+eBbj5k5k8KfREOjWIfbc7Vkjd44mouoAEZD+L2jorJiKiAC4Gi
         AIMA==
X-Gm-Message-State: AKwxyteMyFYF5QWq86ud3ru0ZmqQkc2ESAzNlQtmTUrfTDWyrgE3Twd/
        IDZDJD5a9O4gVf2w6bVEWKBdUw==
X-Google-Smtp-Source: AH8x225ngRVg7PUX4H8NnrsNdLBJPVI7ks8QDfTHesGBLCW4rLH0Fw2F9cSIgdYc8SLvfT1A69UwjA==
X-Received: by 10.99.62.10 with SMTP id l10mr2305838pga.288.1516463450570;
        Sat, 20 Jan 2018 07:50:50 -0800 (PST)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 14sm19907592pga.12.2018.01.20.07.50.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jan 2018 07:50:50 -0800 (PST)
Subject: Re: [PATCH v2 4/8] watchdog: JZ4740: Drop module remove function
To:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org
References: <20171228162939.3928-2-paul@crapouillou.net>
 <20171230135108.6834-1-paul@crapouillou.net>
 <20171230135108.6834-4-paul@crapouillou.net>
 <CANc+2y4z-_++zUG8DUR6+zZYjc26AyJjU-yX+Lx37TSRXb4u0g@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <71845801-7edf-9e49-8591-2a4caf11c45b@roeck-us.net>
Date:   Sat, 20 Jan 2018 07:50:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CANc+2y4z-_++zUG8DUR6+zZYjc26AyJjU-yX+Lx37TSRXb4u0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62261
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

On 01/19/2018 11:41 PM, PrasannaKumar Muralidharan wrote:
> Hi Paul,
> 
> On 30 December 2017 at 19:21, Paul Cercueil <paul@crapouillou.net> wrote:
>> When the watchdog was configured for nowayout, and after the
>> userspace watchdog daemon closed the dev node without sending the
>> magic character, unloading this module stopped the watchdog
>> hardware, which was clearly a problem.
>>
>> Besides, unloading the module is not possible when the userspace
>> watchdog daemon is running, so it's safe to assume that we don't
>> need to stop the watchdog hardware in the jz4740_wdt_remove()
>> function.
>>
>> For this reason, the jz4740_wdt_remove() function can then be
>> dropped alltogether.
>>
>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>> ---
>>   drivers/watchdog/jz4740_wdt.c | 8 --------
>>   1 file changed, 8 deletions(-)
>>
>>   v2: New patch in this series
>>
>> diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
>> index fa7f49a3212c..02b9b8e946a2 100644
>> --- a/drivers/watchdog/jz4740_wdt.c
>> +++ b/drivers/watchdog/jz4740_wdt.c
>> @@ -205,16 +205,8 @@ static int jz4740_wdt_probe(struct platform_device *pdev)
>>          return 0;
>>   }
>>
>> -static int jz4740_wdt_remove(struct platform_device *pdev)
>> -{
>> -       struct jz4740_wdt_drvdata *drvdata = platform_get_drvdata(pdev);
>> -
>> -       return jz4740_wdt_stop(&drvdata->wdt);
>> -}
>> -
>>   static struct platform_driver jz4740_wdt_driver = {
>>          .probe = jz4740_wdt_probe,
>> -       .remove = jz4740_wdt_remove,
>>          .driver = {
>>                  .name = "jz4740-wdt",
>>                  .of_match_table = of_match_ptr(jz4740_wdt_of_matches),
>> --
>> 2.11.0
>>
>>
> 
> As ".remove" is removed and wdt is required for restarting the system
> I am thinking that stop callback is also not required. If so does it
> makes sense to remove the stop callback? I can submit a patch for the
> same once this patch series goes in.
> 
The remove function was removed because it would otherwise be an empty
function. Since it is optional, it can and should be removed if it does not
do anything. If the stop function is removed, it is no longer possible
to stop the watchdog. Why would this make sense, and why would it make sense
to drop the stop function if there is no remove function ?

Guenter
