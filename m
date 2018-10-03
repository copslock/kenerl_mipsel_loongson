Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Oct 2018 15:02:58 +0200 (CEST)
Received: from mail-wm1-x341.google.com ([IPv6:2a00:1450:4864:20::341]:55634
        "EHLO mail-wm1-x341.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993945AbeJCNCtbiUyk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Oct 2018 15:02:49 +0200
Received: by mail-wm1-x341.google.com with SMTP id 206-v6so5647074wmb.5
        for <linux-mips@linux-mips.org>; Wed, 03 Oct 2018 06:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A+aivF/32R1ktzeou5fE9ytY0sBoviKtCVouuPwcBio=;
        b=hUibl2zs39ZWGRNCDzgezwncyk2K6+SmPP5qussWgvUhtTj/4eymODGSZpVRTmBEvB
         vgBsNpOzgZeAQJk0zEaH4h8Zq/lNbBkPXMgsCDYCREtFRvAQCxjTrqq5ftAJUkPX4ROS
         tu8kkDM56XoKwkFwsvmFcHG89B0U0z1hzd1YU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A+aivF/32R1ktzeou5fE9ytY0sBoviKtCVouuPwcBio=;
        b=ejCb2mO5+jwaXAB87qfXTBIZdHAFQ/p8qdcO93X3DaKwgYSASQGqf+l8IxZkfK1EsL
         KHQEIehUoO0tII5WLFN2kdIQfnHEbSzfr82+yjuBnlstlUbE/SNEeZTeLriJQmAlZ4mz
         tnUQ/5B8jyUqolRZhDJnJ/VmwlJMPeiWRTyey/Z/wa/gI2UaIfAOoftM37dbCio7Yk6w
         DhA1WKqtU0OZNVh/AFBVGCPVUvfK92SCAQNGtOLtml5cNzmB6Nnr2IvxjnyzkMLaaEz8
         xGkI2NLGPh8iqA2hOe+2FamVAV00le0bZN8rpOjp8O3gQCLD6j4eJyMsGlwjALOUZdaN
         7n3A==
X-Gm-Message-State: ABuFfoiSWfj4+Fe9ibrC2of0l8K0mqPipTGiv8e4MYSWJcGC8P7zpKPq
        7z1LZd/LsRK0pHVp68/7hWeZoSo4lRo=
X-Google-Smtp-Source: ACcGV63ogankSLUvImdLvYTQBlnfKCox3HBy5wg15/BEutwYe4tgE3TLg8IqIDvMApIxBg5z3wzrxA==
X-Received: by 2002:a1c:e4c6:: with SMTP id b189-v6mr1432893wmh.114.1538571763766;
        Wed, 03 Oct 2018 06:02:43 -0700 (PDT)
Received: from [192.168.0.41] (84.152.136.77.rev.sfr.net. [77.136.152.84])
        by smtp.googlemail.com with ESMTPSA id a105-v6sm2949592wrc.23.2018.10.03.06.02.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 06:02:42 -0700 (PDT)
Subject: Re: [PATCH v5 04/21] dt-bindings: Add doc for the Ingenic TCU drivers
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        linux-watchdog@vger.kernel.org, robh@kernel.org,
        linux-mips@linux-mips.org, Stephen Boyd <sboyd@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
References: <5bb4bb5d.1c69fb81.ed9a6.adc6SMTPIN_ADDED_MISSING@mx.google.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <fa8dd794-3077-eb5c-5657-f62d1a6521b5@linaro.org>
Date:   Wed, 3 Oct 2018 15:02:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5bb4bb5d.1c69fb81.ed9a6.adc6SMTPIN_ADDED_MISSING@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <daniel.lezcano@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66664
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

On 03/10/2018 14:51, Paul Cercueil wrote:
> 
> Le 3 oct. 2018 2:47 PM, Daniel Lezcano <daniel.lezcano@linaro.org> a
> écrit :
>> 
>> On 03/10/2018 12:32, Paul Cercueil wrote:
>>> 
>>> Le 1 oct. 2018 10:48, Daniel Lezcano <daniel.lezcano@linaro.org>
>>> a écrit :
>>>> 
>>>> On 31/07/2018 00:01, Paul Cercueil wrote:
>>>> 
>>>> [ ... ]
>>>> 
>>>>>>> +- ingenic,timer-channel: Specifies the TCU channel that
>>>>>>>  should be used as +  system timer. If not provided, the
>>>>>>> TCU channel 0 is used for the system timer. + +- 
>>>>>>> ingenic,clocksource-channel: Specifies the TCU channel
>>>>>>> that should be used +  as clocksource and sched_clock. It
>>>>>>> must be a different channel than the one +  used as
>>>>>>> system timer. If not provided, neither a clocksource nor
>>>>>>> a +  sched_clock is instantiated.
>>>>>> 
>>>>>> clocksource and sched_clock are Linux specific and don't
>>>>>> belong in DT. You should define properties of the hardware
>>>>>> or use existing properties like interrupts or clocks to
>>>>>> figure out which channel to use. For example, if some
>>>>>> channels don't have an interrupt, then use them for
>>>>>> clocksource and not a clockevent. Or you could have timers
>>>>>> that run in low-power modes or not. If all the channels are
>>>>>> identical, then it shouldn't matter which ones the OS
>>>>>> picks.
>>>> 
>>>> It can't work in this case because the pmw and the timer driver
>>>> are not communicating and the first one can stole a channel to
>>>> the last one.
>>> 
>>> In that particular case the timer driver will always request its
>>>  channels first; with no timer set the system hangs before 
>>> subsys_initcall, and the PWM driver is a subnode of the timer
>>> node, so is probed only after the timer probed.
>>> 
>>>>> We already talked about that. All the TCU channels can be
>>>>> used for PWM. The problem is I cannot know from the driver's
>>>>> scope which channels will be free and which channels will be
>>>>> requested for PWM. You suggested that I parse the devicetree
>>>>> for clients, and I did that in the V3/V4 patchset. But it
>>>>> only works for clients requesting through devicetree, not
>>>>> from platform code or even sysfs.
>>>>> 
>>>>> One thing I can try is to dynamically change the channels the
>>>>>  system timer and clocksource are using when the current ones
>>>>> are requested for PWM. But that sounds hardcore...
>>>> 
>>>> Yes, it is :/
>>>> 
>>>> Sorry for letting you wasting time and effort to write an
>>>> overkill code not suitable for upstream.
>>>> 
>>>> A very gross thought, wouldn't be possible to "register" a
>>>> channel from the timer driver code in a shared data area (but
>>>> well self-encapsulated) and the pwm code will check such
>>>> channel isn't in use ?
>>> 
>>> Probably, but it's the contrary I need to do. The timer driver
>>> code can use any channel, and probes first. The PWM driver code
>>> must use specific channels, and probes last. So either the timer
>>> driver knows what channels it can't use, thanks to a device
>>> property, or it adapts itself when a channel in use is requested
>>> for PWM, which is what I tried in v7.
>> 
>> When you say "must use specific channels", where is coming this 
>> information ?
> 
> If the backlight for the LCD is connected to the pin that corresponds
> to PWM1, then you must use the TCU channel 1. It's that simple.

Is it a runtime detection or is it hardcoded somewhere ?

(just trying to understand the whole picture)

>>> I think we could find a way to use a devicetree property that
>>> doesn't trigger Rob. That would still be the easiest and cleanest
>>> solution.
>>> 
>>> Maybe "ingenic,reserved-channels-mask", which would contain a
>>> mask of channels that can only be used by the timer driver. And
>>> what the timer driver does with these channels, would be specific
>>> to the implementation and would not appear in the bindings. I
>>> hope Rob can work with that.
>>> 
>>> -Paul


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
