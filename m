Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Sep 2018 22:12:43 +0200 (CEST)
Received: from mail-wr1-x443.google.com ([IPv6:2a00:1450:4864:20::443]:36750
        "EHLO mail-wr1-x443.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993946AbeIYUMhUtg-k (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Sep 2018 22:12:37 +0200
Received: by mail-wr1-x443.google.com with SMTP id l10-v6so1497980wrp.3
        for <linux-mips@linux-mips.org>; Tue, 25 Sep 2018 13:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KD68OO+Zb8yNT0w8I5hNpU0qCH3+ExU40WmiuRcgeRo=;
        b=X9az/ZJOX1sLQP8M2TIj2losjHqznGeV/ki94HxOy/5ekO4rfs/cA/CVt/ULTPD9kB
         5ckH+v5AKBxhoTE1MFxU+6pG2ZU3DhR4NTDWBYD4ACon93jbORPlqKfqZl/YeKYhL8Is
         kJc90YmrwEttTsKpqdSdJUT3AjeEr4MNCSoW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KD68OO+Zb8yNT0w8I5hNpU0qCH3+ExU40WmiuRcgeRo=;
        b=Nb3lWjuurELaF98TCjrW9YM6pgxVj1w2u+dDXGu4qMFNFrKBJWVn9VHM4HE+S8EAEi
         xw5prNTdIwvO+mJhNSGpK2sXitttpWVPEoV/8y9ZiSRwntmB76iPVteWuI80DaPxK6jY
         I+TWmVeNc7KAlNby9/CE721Lsu0uHhH5iVPCZPNXsLGBGo17eXf8XUmGpIkG28Z+Sh88
         2+IZ7DTbPWyrFM+NHK2gn6yceUqq9iMfzQfyQIakBQbBaaJ32VD+uyvgZA+MQ2Kmh4l/
         Cka0cld3LzxgWwreCJrcqBgGsWRZnC1CA/sMkGGjHTsZHbIv6OqgsuTATU5kwWFbq6Ae
         Srpg==
X-Gm-Message-State: ABuFfogqrotVlI2EYb1Tw1/rccjJvr8wOf12XHo26MnOADRKulF9CZbq
        QTD1wKw5DwvjR+gZ5NQ6iU+log==
X-Google-Smtp-Source: ACcGV60OqFoavW+v4tDJ6TV48WmE7122ILnvjvGMFWlfHWEreh8Pj+XUlHZXxF0/nzPQGvLLcvplHA==
X-Received: by 2002:adf:ff08:: with SMTP id k8-v6mr2604535wrr.15.1537906351050;
        Tue, 25 Sep 2018 13:12:31 -0700 (PDT)
Received: from [192.168.0.41] (251.150.136.77.rev.sfr.net. [77.136.150.251])
        by smtp.googlemail.com with ESMTPSA id u12-v6sm2840653wrs.48.2018.09.25.13.12.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 13:12:30 -0700 (PDT)
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
References: <5baa3fa9.1c69fb81.4c7b7.19fdSMTPIN_ADDED_MISSING@mx.google.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <346cb95c-f9ce-f19b-30f3-75e9fb379290@linaro.org>
Date:   Tue, 25 Sep 2018 22:12:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5baa3fa9.1c69fb81.4c7b7.19fdSMTPIN_ADDED_MISSING@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <daniel.lezcano@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66560
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

On 25/09/2018 15:38, Paul Cercueil wrote:
> 
> Le 24 sept. 2018 9:14 AM, Daniel Lezcano <daniel.lezcano@linaro.org> a écrit :
>>
>> On 24/09/2018 08:53, Paul Cercueil wrote: 
>>>
>>> Le 24 sept. 2018 07:58, Daniel Lezcano <daniel.lezcano@linaro.org> a écrit : 
>>>>
>>>> On 24/09/2018 07:49, Paul Cercueil wrote: 
>>>>>
>>>>> Le 24 sept. 2018 07:35, Daniel Lezcano <daniel.lezcano@linaro.org> a 
>>>>> écrit : 
>>>>>>
>>>>>> On 24/09/2018 07:24, Paul Cercueil wrote: 
>>>>>>> Hi Daniel, 
>>>>>>>
>>>>>>> Le 24 sept. 2018 05:12, Daniel Lezcano 
>>>>>>> <daniel.lezcano@linaro.org> a écrit : 
>>>>>>>>
>>>>>>>> On 21/08/2018 19:16, Paul Cercueil wrote: 
>>>>>>>>> This driver handles the TCU (Timer Counter Unit) present on 
>>>>>>>>> the Ingenic JZ47xx SoCs, and provides the kernel with a 
>>>>>>>>> system timer, and optionally with a clocksource and a 
>>>>>>>>> sched_clock. 
>>>>>>>>>
>>>>>>>>> It also provides clocks and interrupt handling to client 
>>>>>>>>> drivers. 
>>>>>>>>
>>>>>>>> Can you provide a much more complete description of the timer 
>>>>>>>> in order to make my life easier for the review of this patch? 
>>>>>>>
>>>>>>> See patch [03/24], it adds a doc file that describes the 
>>>>>>> hardware. 
>>>>>>
>>>>>> Thanks, I went through but it is incomplete to understand what the 
>>>>>> timer do. I will reverse-engineer the code but it would help if you 
>>>>>> can give the gross approach. Why multiple channels ? mutexes and 
>>>>>> completion ? 
>>>>>
>>>>> Much of the complexity is because of the multi-purpose nature of the 
>>>>> TCU channels. Each one can be used as timer/clocksource, or PWM. 
>>>>>
>>>>> The driver starts by using channels 0 and 1 as system timer and 
>>>>> clocksource, respectively, the other ones being unused for now. Then, 
>>>>> *if* the PWM driver requests one of the channels in use by the 
>>>>> timer/clocksource driver, say channel 0, the timer/clocksource driver 
>>>>> will dynamically reassign the system timer to a free channel, from 
>>>>> channel 0 to e.g. channel 2. Only in that case the completion/mutex 
>>>>> are actually used. 
>>>>
>>>> Why do you need to do this? Can't be the channels dedicated and reserved 
>>>> for clocksource and clockevent? 
>>>
>>> That's what I had in place (ingenic,timer-channel and ingenic,clocksource-channel DT properties), but Rob didn't want any linux-specific properties in the devicetree binding :( 
>>
>> Isn't possible to specify the channel to use in the DT? like renesas16 ? 
> 
> That's what I did in V6 (and before), but Rob did not want me to add properties for Linux-specific concepts such as clocksource.

Hmm, I remember something like that, yes but I did a delete of the
previous version when you posted the v7. Can you give a pointer to its
answer ?



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
