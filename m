Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2018 18:26:05 +0200 (CEST)
Received: from mail-wm0-x244.google.com ([IPv6:2a00:1450:400c:c09::244]:38186
        "EHLO mail-wm0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992404AbeC1QZzV4oqv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Mar 2018 18:25:55 +0200
Received: by mail-wm0-x244.google.com with SMTP id l16so6484799wmh.3
        for <linux-mips@linux-mips.org>; Wed, 28 Mar 2018 09:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BXKDMJG3JeCpej2WnLf9wqzx5IMUXIkH5dpeKYi6VvU=;
        b=A20CcuINqjOypQe/pFrKhZYvabm2UxnSDgnRiva6XUEAR+ZyZ+mQaVtMD+yO5lG6t9
         4+3E9VugFKPMnQ8b6u8MwEZl5BJqhersmE6zIS8ALIo6fGZXq1WdRj9teM6Mq8VdWIUd
         E8ncp85Nntir3428iWSF9UdoN1Cz9VnhcTYpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BXKDMJG3JeCpej2WnLf9wqzx5IMUXIkH5dpeKYi6VvU=;
        b=EyPhjJoiJc1YdPBHzTIsA1YEa/YtuzGt6JU9+nvi/eReoFaK+RxybGRHF/bnaWf8ih
         m2k01dpU/sT6rYUt144jA5JM/6DZ4E9jftmNCxPv1ugRnx6RLXx7IpnDLmT93Nis5KOy
         5hx63c3FqYF35mgT4UQ0T5ZsETIwW4PlBrZdxmoQmQ/cBKjEmg/ZiS4Duk3HRdPiup8s
         0yllETamuHK+bYICPz9+USGHsAz085wIGklXkZJIS0d+LYCGfF7GK8MKCCkJ8pIuqew3
         rmcAnzYYGrbcpTgaMsNeV/XjE3xusGZBpFx0P8w4lxL/pb1Le+N81w+0Rhr+9H3e1XTN
         ql6g==
X-Gm-Message-State: AElRT7H/W1DQTGzxO6V8JPzyRRmEx6AaHs+D8dqy8bUQUmqru92aLCmw
        JxM/jnTKpkRyefUG3WL4PImDHQ==
X-Google-Smtp-Source: AIpwx48VNu4+BWNyeezFgHKTTr3sNGMJ2dFhw03oSKkfdoc75R8eqZxgHf6m+FKrnt4WpiHF+Gajuw==
X-Received: by 10.28.134.203 with SMTP id i194mr3525664wmd.114.1522254349714;
        Wed, 28 Mar 2018 09:25:49 -0700 (PDT)
Received: from ?IPv6:2001:41d0:fe90:b800:b0a9:da92:8c72:d9e2? ([2001:41d0:fe90:b800:b0a9:da92:8c72:d9e2])
        by smtp.googlemail.com with ESMTPSA id e27sm7813448wre.86.2018.03.28.09.25.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Mar 2018 09:25:48 -0700 (PDT)
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
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <af33e522-7f87-d62a-0a35-d56a403387b7@linaro.org>
Date:   Wed, 28 Mar 2018 18:25:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <06976e4ae275c4cc0bddacc5e0c0c9a9@crapouillou.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <daniel.lezcano@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63292
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

On 28/03/2018 17:15, Paul Cercueil wrote:
> Le 2018-03-24 07:26, Daniel Lezcano a écrit :
>> On 18/03/2018 00:29, Paul Cercueil wrote:
>>> This driver will use the TCU (Timer Counter Unit) present on the Ingenic
>>> JZ47xx SoCs to provide the kernel with a clocksource and timers.
>>
>> Please provide a more detailed description about the timer.
> 
> There's a doc file for that :)

Usually, when there is a new driver I ask for a description in the
changelog for reference.

>> Where is the clocksource ?
> 
> Right, there is no clocksource, just timers.
> 
>> I don't see the point of using channel idx and pwm checking here.
>>
>> There is one clockevent, why create multiple channels ? Can't you stick
>> to the usual init routine for a timer.
> 
> So the idea is that we use all the TCU channels that won't be used for PWM
> as timers. Hence the PWM checking. Why is this bad?

It is not bad but arguable. By checking the channels used by the pwm in
the code, you introduce an adherence between two subsystems even if it
is just related to the DT parsing part.

As it is not needed to have more than one timer in the time framework
(at least with the same characteristics), the pwm channels check is
pointless. We can assume the author of the DT file is smart enough to
prevent conflicts and define a pwm and a timer properly instead of
adding more code complexity.

In addition, simplifying the code will allow you to use the timer-of
code and reduce very significantly the init function.

>>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>> ---
>>>  drivers/clocksource/Kconfig         |   8 ++
>>>  drivers/clocksource/Makefile        |   1 +
>>>  drivers/clocksource/timer-ingenic.c | 278
>>> ++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 287 insertions(+)
>>>  create mode 100644 drivers/clocksource/timer-ingenic.c
>>>
>>>  v2: Use SPDX identifier for the license
>>>  v3: - Move documentation to its own patch
>>>      - Search the devicetree for PWM clients, and use all the TCU
>>>        channels that won't be used for PWM
>>>  v4: - Add documentation about why we search for PWM clients
>>>      - Verify that the PWM clients are for the TCU PWM driver
>>>
>>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>>> index d2e5382821a4..481422145fb4 100644
>>> --- a/drivers/clocksource/Kconfig
>>> +++ b/drivers/clocksource/Kconfig
>>> @@ -592,4 +592,12 @@ config CLKSRC_ST_LPC
>>>        Enable this option to use the Low Power controller timer
>>>        as clocksource.
>>>
>>> +config INGENIC_TIMER
>>> +    bool "Clocksource/timer using the TCU in Ingenic JZ SoCs"
>>> +    depends on MACH_INGENIC || COMPILE_TEST
>>
>> bool "Clocksource/timer using the TCU in Ingenic JZ SoCs" if COMPILE_TEST
>>
>> Remove the depends MACH_INGENIC.
> 
> This driver is not useful on anything else than Ingenic SoCs, why should I
> remove MACH_INGENIC then?

For COMPILE_TEST on x86.

>>> +    select CLKSRC_OF
>>> +    default y
>>
>> No default, Kconfig platform selects the timer.
> 
> Alright.
[ ... ]

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
