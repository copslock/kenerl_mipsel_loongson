Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Jan 2018 18:57:06 +0100 (CET)
Received: from mail-pg0-x242.google.com ([IPv6:2607:f8b0:400e:c05::242]:38156
        "EHLO mail-pg0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990439AbeATR46yS8xD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Jan 2018 18:56:58 +0100
Received: by mail-pg0-x242.google.com with SMTP id y27so3857111pgc.5;
        Sat, 20 Jan 2018 09:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Si7KRwpeozYat4RhCBTpjcWvJhU3rJkyDf4cG8c9Goc=;
        b=d/22EEvpHzS/Y5/esUVX/WXX+Jlt8hQO/Zzr8suSgUZKE0+d+RlR8l9l27x1gpg+61
         HfVP+YQbb640/QKGIFhMk0cBkQkM9eEkvvv1V8DHjc878zt0ghdsW8GwKlOBduk8DgoS
         oRNrVLtd7hLJPqRxUgjOdPbj2BEvbUlWYQdgGzrun18d3s2x/Lx9z6I3NSOsvQoGfEtH
         +2JGRyHeSWL5QzTc58DfMXRVamnVvDyRmxmjt+zgF3XObtwm6SIWJ6YjgvCZiw8pHD9N
         +be9r/jx/zu4s/xJDkIhZc9YQ5+nEVKCfbQ0aYrhlt4mTwl32RcDs9B/9gIJ8NOhh2qr
         fz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Si7KRwpeozYat4RhCBTpjcWvJhU3rJkyDf4cG8c9Goc=;
        b=WZZgUcgmSvQR71nNcE377mgyxxhv1VH3u5NKoJ44lXse00ufKoATqDqbOEhtI69ZHb
         8Rz+BYrAwt0Z/sNroRpjVr0Qb9fgHXWoao8UvrWmhAllnvgpPUPqEitSo4urEhXkZnSY
         GCpo5Jk/qXuvkJsineJLIGoeJbr/Ka2tXbB5qgTYO/KWJEYAuzDM0ioySlHv0PzlqoI1
         Iq4PmytjuyfGmi/8P1C4zOg9wjOTwg1Q5oHatnWSFu77EgRdJBios1uyxhDvjhCdtgHp
         VR5bWlhKLHJYvn3FJTq4agk0rfZXQ+YIbiZZ0fYFgDKJF27oMEjt+chcvlPtf/HckWy2
         10Ag==
X-Gm-Message-State: AKwxyteMZDPVtreDVplBvXWJJ98UvJb9pMkmjzXUhqacz5ct3BjQGL7Q
        4diqFIYkhrHUYo8KJ14xyu8=
X-Google-Smtp-Source: AH8x224WZLGETVs31vNmcfkwUVJzwrGGzK2CJVipfm8XYHkZGet+N5yxetV5S2wTCIdtInrJ8fD+9A==
X-Received: by 10.99.53.15 with SMTP id c15mr2677500pga.333.1516471012203;
        Sat, 20 Jan 2018 09:56:52 -0800 (PST)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id q24sm9682431pgn.15.2018.01.20.09.56.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jan 2018 09:56:51 -0800 (PST)
Subject: Re: [PATCH v2 3/8] watchdog: JZ4740: Register a restart handler
To:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>,
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
 <20171230135108.6834-3-paul@crapouillou.net>
 <CANc+2y7CT150cO61RfRgc6hCLEasx+NmqCacZtaFPKLgTPyt4w@mail.gmail.com>
 <20061de8-fa1f-93eb-eb9b-089c699018aa@roeck-us.net>
 <CANc+2y52ObW773=20=-gbztvoH0DSRSO1N5Srf3WYcKLZbPNBg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <fa472dc7-7e5a-aaba-2953-27f68a01d872@roeck-us.net>
Date:   Sat, 20 Jan 2018 09:56:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CANc+2y52ObW773=20=-gbztvoH0DSRSO1N5Srf3WYcKLZbPNBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62264
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

On 01/20/2018 08:04 AM, PrasannaKumar Muralidharan wrote:
> Hi Guenter,
> 
> On 20 January 2018 at 21:15, Guenter Roeck <linux@roeck-us.net> wrote:
>> On 01/19/2018 11:31 PM, PrasannaKumar Muralidharan wrote:
>>>
>>> Hi Paul,
>>>
>>> On 30 December 2017 at 19:21, Paul Cercueil <paul@crapouillou.net> wrote:
>>>>
>>>> The watchdog driver can restart the system by simply configuring the
>>>> hardware for a timeout of 0 seconds.
>>>>
>>>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>>>> ---
>>>>    drivers/watchdog/jz4740_wdt.c | 9 +++++++++
>>>>    1 file changed, 9 insertions(+)
>>>>
>>>>    v2: No change
>>>>
>>>> diff --git a/drivers/watchdog/jz4740_wdt.c
>>>> b/drivers/watchdog/jz4740_wdt.c
>>>> index 92d6ca8ceb49..fa7f49a3212c 100644
>>>> --- a/drivers/watchdog/jz4740_wdt.c
>>>> +++ b/drivers/watchdog/jz4740_wdt.c
>>>> @@ -130,6 +130,14 @@ static int jz4740_wdt_stop(struct watchdog_device
>>>> *wdt_dev)
>>>>           return 0;
>>>>    }
>>>>
>>>> +static int jz4740_wdt_restart(struct watchdog_device *wdt_dev,
>>>> +                             unsigned long action, void *data)
>>>> +{
>>>> +       wdt_dev->timeout = 0;
>>>> +       jz4740_wdt_start(wdt_dev);
>>>> +       return 0;
>>>> +}
>>>> +
>>>>    static const struct watchdog_info jz4740_wdt_info = {
>>>>           .options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
>>>> WDIOF_MAGICCLOSE,
>>>>           .identity = "jz4740 Watchdog",
>>>> @@ -141,6 +149,7 @@ static const struct watchdog_ops jz4740_wdt_ops = {
>>>>           .stop = jz4740_wdt_stop,
>>>>           .ping = jz4740_wdt_ping,
>>>>           .set_timeout = jz4740_wdt_set_timeout,
>>>> +       .restart = jz4740_wdt_restart,
>>>>    };
>>>>
>>>>    #ifdef CONFIG_OF
>>>> --
>>>> 2.11.0
>>>>
>>>>
>>>
>>> Noticed that min_timeout of the watchdog device is set to 1 but this
>>> function calls start with timeout set to 0. Even though this works I
>>> feel it is better to set min_timeout to 0.
>>>
>>
>> No. That would be wrong. If you want to be pedantic, write a new function
>> __jz4740_wdt_set_timeout(u16 clock_div, u16 timeout_value) and call it
>> instead, but don't mess with min_timeout.
>>
>> Guenter
> 
> What is the effect of changing min_timeout? I could see only
> validation checks with it.
> 
Let me ask you - you want to let userspace set a timeout of 0, which would
effectively reboot the system through the backdoor. Why ?

Guenter
