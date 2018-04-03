Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Apr 2018 12:00:02 +0200 (CEST)
Received: from mail-wm0-x22e.google.com ([IPv6:2a00:1450:400c:c09::22e]:39197
        "EHLO mail-wm0-x22e.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993256AbeDCJ7ze83jx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Apr 2018 11:59:55 +0200
Received: by mail-wm0-x22e.google.com with SMTP id f125so33801365wme.4
        for <linux-mips@linux-mips.org>; Tue, 03 Apr 2018 02:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BecnRLaCn0wbhGIQvQbp7BrO/Uis+jhcKzZJCifxjVE=;
        b=VBhADR0XfKyJFZBYTObXlVO40b2YJ4PINA7c548MUXtDLA20m8bbk61Wp1Pd+idDyu
         jXH+Gk4wEDaNDtQs4tcXhmgRZWjB5hCKX4eJJq/7GkXE1SdUJoUxfN9zlMGA6gZk1D2V
         xgQwCAiDfDZXKYctHGZvvXSFpkGicwl1gxCMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BecnRLaCn0wbhGIQvQbp7BrO/Uis+jhcKzZJCifxjVE=;
        b=P2EMWH+0hQLtVQBpNgivztbtaOmY5Cw1MFQkYpiA1O5/qKQNd/sjlvVQw9NUcvEHqL
         IiGWXJinte/c4gls2jswjIs/E5UUlv8W6a3vQLFQtC4/R3knBeTWixnut9AY66NhG+/9
         sXPapfc2oH81cMEQ2SVZJgWXRQAuxjLtZo+J50OwsQx0DCpUvB3RyuBTpm6g6uOC8rMm
         cl8rDn3eZ6i3OtYCRNebwly/UQp2L+AjLHHg4kgvoci88y0B2VPzmh43wRd/jU8CsaF+
         a1iB8a0GN6lJY6R3i6jYXYCeNsZYjNyzklA/mKUudwVv11P6/9pb9SGQ/ySqbpp0+2dg
         41dw==
X-Gm-Message-State: AElRT7Hv9jKYd3zUqspWjFY8h1PVWNnPiX0gsBKiUnRi2AuK7vxLs4km
        NueL28Hp7WuiZNNbldoP6tUCLA==
X-Google-Smtp-Source: AIpwx48cPjCwtY0ySArm0KhhMU6I9kH6QfCi8tzJ2FA7ojLTjO3MqcAejlgTKDG34GK2OsDjc+3WYQ==
X-Received: by 10.80.190.70 with SMTP id b6mr8087570edi.283.1522749589993;
        Tue, 03 Apr 2018 02:59:49 -0700 (PDT)
Received: from [192.168.1.75] (lft31-1-88-121-166-205.fbx.proxad.net. [88.121.166.205])
        by smtp.googlemail.com with ESMTPSA id s10sm1573680edc.63.2018.04.03.02.59.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Apr 2018 02:59:49 -0700 (PDT)
Subject: Re: [PATCH v4 7/8] clocksource: Add a new timer-ingenic driver
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>,
        James Hogan <jhogan@kernel.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-doc@vger.kernel.org
References: <20180110224838.16711-2-paul@crapouillou.net>
 <20180317232901.14129-1-paul@crapouillou.net>
 <20180317232901.14129-8-paul@crapouillou.net>
 <a8d28b2b-4e40-83b9-d65e-beecbd36ad33@linaro.org>
 <06976e4ae275c4cc0bddacc5e0c0c9a9@crapouillou.net>
 <af33e522-7f87-d62a-0a35-d56a403387b7@linaro.org>
 <1522335149.1792.0@smtp.crapouillou.net>
 <2234006b-30ff-d5a8-b14a-d6e307c06145@linaro.org>
 <4532f9e86184afab8c46e8debd8abe61@crapouillou.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <73091b00-205b-3133-6650-21b6e3fda70f@linaro.org>
Date:   Tue, 3 Apr 2018 11:59:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <4532f9e86184afab8c46e8debd8abe61@crapouillou.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <daniel.lezcano@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63390
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

On 31/03/2018 19:46, Paul Cercueil wrote:
> Le 2018-03-31 10:10, Daniel Lezcano a écrit :
>> On 29/03/2018 16:52, Paul Cercueil wrote:
>>>
>>>
>>> Le mer. 28 mars 2018 à 18:25, Daniel Lezcano <daniel.lezcano@linaro.org>
>>> a écrit :
>>>> On 28/03/2018 17:15, Paul Cercueil wrote:
>>>>>  Le 2018-03-24 07:26, Daniel Lezcano a écrit :
>>>>>>  On 18/03/2018 00:29, Paul Cercueil wrote:
>>>>>>>  This driver will use the TCU (Timer Counter Unit) present on the
>>>>>>> Ingenic
>>>>>>>  JZ47xx SoCs to provide the kernel with a clocksource and timers.
>>>>>>
>>>>>>  Please provide a more detailed description about the timer.
>>>>>
>>>>>  There's a doc file for that :)
>>>>
>>>> Usually, when there is a new driver I ask for a description in the
>>>> changelog for reference.
>>>>
>>>>>>  Where is the clocksource ?
>>>>>
>>>>>  Right, there is no clocksource, just timers.
>>>>>
>>>>>>  I don't see the point of using channel idx and pwm checking here.
>>>>>>
>>>>>>  There is one clockevent, why create multiple channels ? Can't you
>>>>>> stick
>>>>>>  to the usual init routine for a timer.
>>>>>
>>>>>  So the idea is that we use all the TCU channels that won't be used
>>>>> for PWM
>>>>>  as timers. Hence the PWM checking. Why is this bad?
>>>>
>>>> It is not bad but arguable. By checking the channels used by the pwm in
>>>> the code, you introduce an adherence between two subsystems even if it
>>>> is just related to the DT parsing part.
>>>>
>>>> As it is not needed to have more than one timer in the time framework
>>>> (at least with the same characteristics), the pwm channels check is
>>>> pointless. We can assume the author of the DT file is smart enough to
>>>> prevent conflicts and define a pwm and a timer properly instead of
>>>> adding more code complexity.
>>>>
>>>> In addition, simplifying the code will allow you to use the timer-of
>>>> code and reduce very significantly the init function.
>>>
>>> That's what I had in my V1 and V2, my DT node for the timer-ingenic
>>> driver
>>> had a "timers" property (e.g. "timers = <4 5>;") to select the channels
>>> that
>>> should be used as timers. Then Rob told me I shouldn't do that, and
>>> instead
>>> detect the channels that will be used for PWM.
>>>
>>
>> [ ... ]
>>
>> How do you specify the channels used for PWM ?
> 
> To detect the channels that will be used as PWM I parse the whole
> devicetree
> searching for "pwms" properties; check that the PWM handle is for our
> TCU PWM
> driver; then read the PWM number from there.
> 
> Of course it's hackish, and it only works for devicetree. I preferred the
> method with the "timers" property.

Do you have a DT portion describing that? Eg somewhere in the kernel's
git tree ?

From what I understood, we can specify the channel for a pwm but not for
a timer, there is certainly something I'm missing.

>>>>>>>
>>>>>>>  +config INGENIC_TIMER
>>>>>>>  +    bool "Clocksource/timer using the TCU in Ingenic JZ SoCs"
>>>>>>>  +    depends on MACH_INGENIC || COMPILE_TEST
>>>>>>
>>>>>>  bool "Clocksource/timer using the TCU in Ingenic JZ SoCs" if
>>>>>> COMPILE_TEST
>>>>>>
>>>>>>  Remove the depends MACH_INGENIC.
>>>>>
>>>>>  This driver is not useful on anything else than Ingenic SoCs, why
>>>>> should I
>>>>>  remove MACH_INGENIC then?
>>>>
>>>> For COMPILE_TEST on x86.
>>>
>>> Well that's a logical OR right here, so it will work...
>>
>> Right, I missed the second part of the condition. For consistency
>> reason, we don't add a dependency on the platform. The platform will
>> select it. Look the other timer options and you will see there is no
>> MACH deps. I'm trying consolidating all these options to have same
>> format and hopefully factor them out.
> 
> I'm all for factorisation, but what I dislike with not depending on
> MACH_INGENIC, is that the driver now appears in the menuconfig for
> every arch, even if it only applies to one MIPS SoC.

Can you do the following change?

bool "Clocksource/timer using the TCU in Ingenic JZ SoCs" if COMPILE_TEST

so it will appear only when the COMPILE_TEST option is set whatever the
platform which is the purpose of this option to increase compile test
coverage.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
