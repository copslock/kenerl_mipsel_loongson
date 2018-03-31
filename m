Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 31 Mar 2018 10:10:26 +0200 (CEST)
Received: from mail-wm0-x230.google.com ([IPv6:2a00:1450:400c:c09::230]:40444
        "EHLO mail-wm0-x230.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990401AbeCaIKTixTQ0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 31 Mar 2018 10:10:19 +0200
Received: by mail-wm0-x230.google.com with SMTP id x4so19564867wmh.5
        for <linux-mips@linux-mips.org>; Sat, 31 Mar 2018 01:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fW0SEuK8scGBMA/m7lC76lqBtYQUJ2WAUA9NxgYsXUg=;
        b=gBTHZK2TATIKpZ0TAzJtmeSuFPSKq4IfeHVufeptcef8gtTjhmWL/SvhxivSWibu0l
         KjuYSk546jKaGUt61NIad6bIA03Y7tqvfGgNfX/AsbwfjZLYjC2uo5dvZBxetaYFkRJ+
         FHiH4+j5fJfateHEG0s4ozMWKdwGXuoqwWHM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fW0SEuK8scGBMA/m7lC76lqBtYQUJ2WAUA9NxgYsXUg=;
        b=fDcbEuvLdOTsEnujxWXkVduE7SNtX+zMPlNjyLRCq2B/wud0RDPZ9Fzm0VKxvi12Aw
         dJrRLCLvkOBs+mu4ASXKjLa7Aff75DWipkiq6mq5tiV4d5hmeGSz58TPQEV2sXBTYkT7
         V7mGwquYg+3Af2lQNAMOCC98qRt8Aw7eej7nJihQKttTX1+h+k4DOoyGHc0v64u9SLRW
         M6hYwJCuTwinJJl3wGtJD7tnOQYpVjnJwuVjhuF1UH9VaDwVqOks37IsIHsblqfy1NNn
         gErI9gHLWhhZuoNiceDiaAjbHsRUQpEJvxGCnzLMInDmjlYSMv/6D2mDsnn5jJvsdc0P
         QBCQ==
X-Gm-Message-State: AElRT7ELMWGJSYBFYTFIode8kf0tAhCMp01gq2fM8x7CWjQ7E+du0sMv
        dn7MrqyLdln3elh3BK9wNB91Lw==
X-Google-Smtp-Source: AIpwx499jXrK9wXmca/BjWWb5GP8ymzSi1VxWkTBO+D3rHzvtP4iF52z80n3zD7oA/mV5mqIlKUnxQ==
X-Received: by 10.28.37.134 with SMTP id l128mr4405233wml.10.1522483814065;
        Sat, 31 Mar 2018 01:10:14 -0700 (PDT)
Received: from [192.168.0.77] (135-224-190-109.dsl.ovh.fr. [109.190.224.135])
        by smtp.googlemail.com with ESMTPSA id n29sm7303358wmi.32.2018.03.31.01.10.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Mar 2018 01:10:13 -0700 (PDT)
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
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <2234006b-30ff-d5a8-b14a-d6e307c06145@linaro.org>
Date:   Sat, 31 Mar 2018 10:10:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1522335149.1792.0@smtp.crapouillou.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <daniel.lezcano@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63371
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

On 29/03/2018 16:52, Paul Cercueil wrote:
> 
> 
> Le mer. 28 mars 2018 à 18:25, Daniel Lezcano <daniel.lezcano@linaro.org>
> a écrit :
>> On 28/03/2018 17:15, Paul Cercueil wrote:
>>>  Le 2018-03-24 07:26, Daniel Lezcano a écrit :
>>>>  On 18/03/2018 00:29, Paul Cercueil wrote:
>>>>>  This driver will use the TCU (Timer Counter Unit) present on the
>>>>> Ingenic
>>>>>  JZ47xx SoCs to provide the kernel with a clocksource and timers.
>>>>
>>>>  Please provide a more detailed description about the timer.
>>>
>>>  There's a doc file for that :)
>>
>> Usually, when there is a new driver I ask for a description in the
>> changelog for reference.
>>
>>>>  Where is the clocksource ?
>>>
>>>  Right, there is no clocksource, just timers.
>>>
>>>>  I don't see the point of using channel idx and pwm checking here.
>>>>
>>>>  There is one clockevent, why create multiple channels ? Can't you
>>>> stick
>>>>  to the usual init routine for a timer.
>>>
>>>  So the idea is that we use all the TCU channels that won't be used
>>> for PWM
>>>  as timers. Hence the PWM checking. Why is this bad?
>>
>> It is not bad but arguable. By checking the channels used by the pwm in
>> the code, you introduce an adherence between two subsystems even if it
>> is just related to the DT parsing part.
>>
>> As it is not needed to have more than one timer in the time framework
>> (at least with the same characteristics), the pwm channels check is
>> pointless. We can assume the author of the DT file is smart enough to
>> prevent conflicts and define a pwm and a timer properly instead of
>> adding more code complexity.
>>
>> In addition, simplifying the code will allow you to use the timer-of
>> code and reduce very significantly the init function.
> 
> That's what I had in my V1 and V2, my DT node for the timer-ingenic driver
> had a "timers" property (e.g. "timers = <4 5>;") to select the channels
> that
> should be used as timers. Then Rob told me I shouldn't do that, and instead
> detect the channels that will be used for PWM.
> 

[ ... ]

How do you specify the channels used for PWM ?

>>>>>
>>>>>  +config INGENIC_TIMER
>>>>>  +    bool "Clocksource/timer using the TCU in Ingenic JZ SoCs"
>>>>>  +    depends on MACH_INGENIC || COMPILE_TEST
>>>>
>>>>  bool "Clocksource/timer using the TCU in Ingenic JZ SoCs" if
>>>> COMPILE_TEST
>>>>
>>>>  Remove the depends MACH_INGENIC.
>>>
>>>  This driver is not useful on anything else than Ingenic SoCs, why
>>> should I
>>>  remove MACH_INGENIC then?
>>
>> For COMPILE_TEST on x86.
> 
> Well that's a logical OR right here, so it will work...

Right, I missed the second part of the condition. For consistency
reason, we don't add a dependency on the platform. The platform will
select it. Look the other timer options and you will see there is no
MACH deps. I'm trying consolidating all these options to have same
format and hopefully factor them out.





-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
