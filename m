Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Sep 2018 07:58:53 +0200 (CEST)
Received: from mail-wm1-x342.google.com ([IPv6:2a00:1450:4864:20::342]:37514
        "EHLO mail-wm1-x342.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990757AbeIXF6ueaKaO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Sep 2018 07:58:50 +0200
Received: by mail-wm1-x342.google.com with SMTP id n11-v6so8676247wmc.2
        for <linux-mips@linux-mips.org>; Sun, 23 Sep 2018 22:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/johJ3UyAOovSnx7TvEP6A5RKo8jLj2X0tlzzx2ruyo=;
        b=DkJKM64m94Fipj2V9siEbJQoLhtrQO9vO+px1kjB+a+qCQh3yNXpipc++iOEhRcgZd
         X/EGCmu4Vvg1pq53fyDodIy/ZF3KVtMhzalTj59PmYKMccEqn7UUDIGPHJJLPj4weyJ2
         l25ZVlZpHMMJDE9/6pI8dESkuizHM4ow6TYnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/johJ3UyAOovSnx7TvEP6A5RKo8jLj2X0tlzzx2ruyo=;
        b=F2VKWf7X/p563c83ZoB19vFmgsDQKZfHVY8ICu3tv+0X8hlJTC7I38vacHuAYTYHNa
         8YEmIj1swohmxxHzzs9WqNXtXSd/aXy1eOkn/cYP9MEkceXE83p1tKmD5E2W3CWhsP9k
         vYaqcD3rurptshUmVYt8HEIxHwMg5OgXMFYzOE36wDu1DgKi4TgViZYT/30zMSugFtds
         cT/WA13J7XjHuB4j/oNylHnw1FRqTL0aSRszkyu4mUC8VYJjVZLddWg9wYueDf3CbrgV
         r/oSE4XJTwN2itrWcuzZ2K/g1HnWJBvWECl/gJuN7wUrGQsvePObBEyZ6nIZwLFCzB03
         EIDQ==
X-Gm-Message-State: ABuFfohfXOBwakmlWcKlQ6ZOYkWrzwjFRli1SERHY0V0dYLYaP8xGpVg
        /TtDcXrILtXh09gR9qei1G3LVg==
X-Google-Smtp-Source: ACcGV63cwHQVPBsV0vN2M23izrDaFz7GC0tR1yqrl/uWJD0bz84zGR3F6YHiampD1L1paaZWC2dkkw==
X-Received: by 2002:a1c:208c:: with SMTP id g134-v6mr5833681wmg.144.1537768724934;
        Sun, 23 Sep 2018 22:58:44 -0700 (PDT)
Received: from [192.168.0.41] (89.154.136.77.rev.sfr.net. [77.136.154.89])
        by smtp.googlemail.com with ESMTPSA id v192-v6sm14197856wmf.40.2018.09.23.22.58.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 22:58:44 -0700 (PDT)
Subject: Re: [PATCH v7 05/24] clocksource: Add a new timer-ingenic driver
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        linux-watchdog@vger.kernel.org, od@zcrc.me,
        linux-mips@linux-mips.org, Paul Burton <paul.burton@mips.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
References: <5ba87b02.1c69fb81.1da88.1457SMTPIN_ADDED_MISSING@mx.google.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e5104bd9-1564-266d-4f27-affa8a9e825d@linaro.org>
Date:   Mon, 24 Sep 2018 07:58:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5ba87b02.1c69fb81.1da88.1457SMTPIN_ADDED_MISSING@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <daniel.lezcano@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66497
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.lezcano@linaro.org
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

On 24/09/2018 07:49, Paul Cercueil wrote:
> 
> Le 24 sept. 2018 07:35, Daniel Lezcano <daniel.lezcano@linaro.org> a
> écrit :
>> 
>> On 24/09/2018 07:24, Paul Cercueil wrote:
>>> Hi Daniel,
>>> 
>>> Le 24 sept. 2018 05:12, Daniel Lezcano
>>> <daniel.lezcano@linaro.org> a écrit :
>>>> 
>>>> On 21/08/2018 19:16, Paul Cercueil wrote:
>>>>> This driver handles the TCU (Timer Counter Unit) present on
>>>>> the Ingenic JZ47xx SoCs, and provides the kernel with a
>>>>> system timer, and optionally with a clocksource and a
>>>>> sched_clock.
>>>>> 
>>>>> It also provides clocks and interrupt handling to client
>>>>> drivers.
>>>> 
>>>> Can you provide a much more complete description of the timer
>>>> in order to make my life easier for the review of this patch?
>>> 
>>> See patch [03/24], it adds a doc file that describes the
>>> hardware.
>> 
>> Thanks, I went through but it is incomplete to understand what the
>> timer do. I will reverse-engineer the code but it would help if you
>> can give the gross approach. Why multiple channels ? mutexes and
>> completion ?
> 
> Much of the complexity is because of the multi-purpose nature of the
> TCU channels. Each one can be used as timer/clocksource, or PWM.
> 
> The driver starts by using channels 0 and 1 as system timer and
> clocksource, respectively, the other ones being unused for now. Then,
> *if* the PWM driver requests one of the channels in use by the
> timer/clocksource driver, say channel 0, the timer/clocksource driver
> will dynamically reassign the system timer to a free channel, from
> channel 0 to e.g. channel 2. Only in that case the completion/mutex
> are actually used.

Why do you need to do this? Can't be the channels dedicated and reserved
for clocksource and clockevent?


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
