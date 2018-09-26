Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Sep 2018 10:05:32 +0200 (CEST)
Received: from mail-wm1-x343.google.com ([IPv6:2a00:1450:4864:20::343]:54789
        "EHLO mail-wm1-x343.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991082AbeIZIFVjwIri (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Sep 2018 10:05:21 +0200
Received: by mail-wm1-x343.google.com with SMTP id c14-v6so1192728wmb.4
        for <linux-mips@linux-mips.org>; Wed, 26 Sep 2018 01:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ONWisPtFURwS+Dv/RY9Ijg+ZXudgqyV5XWp/wD93EE4=;
        b=KDukd2ySxu3ajHjovgrOo8VKtSSAwHEUxFESObdGL6Gp9oEw5g8aXWSVu3aHB3ar5a
         4GrQte6urNaoeZ4/7RB2JAyflTfF8kZHR/ksDpGVqNXl0nfznGnNOAYQN8YnCX84ROiO
         c14ErtmL52sfmrXmUbmK39VwmE55Rr07MRCSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ONWisPtFURwS+Dv/RY9Ijg+ZXudgqyV5XWp/wD93EE4=;
        b=b7RM/SWG8t7TLMBtSyHCw5Py6lTm3Co4JYSeO4nAyJRzFiiAD/BCa11EQqIpA4/uYF
         imdU/YPWAI//mAdq2E0Zyw2E7914zBMSQZcD7+MI0ggGzT3jpdx5fxDZSfDZgpuJ9Xbc
         WES9i+2At0SLJded1z4DSBjFEgHv3nc+1BGHAJ+8XAkI1jvjuZ0rBvKTyD48sneG1P5W
         uSpt289L1BcA40GYml6qtT6Y6utf1gF5hOxOZJWJxcqaOONqZWUq7UNQxEIOvV1f3j/g
         XXD5M4WyrMb9FbkHQ3ZAs57HZZEuX+Gs6N4gPOAwyBQ8FYDZg87ejyBJcUAKSGZoyq8J
         bJNA==
X-Gm-Message-State: ABuFfoinS8N6hbSVwrKaxzeVumY463H9D28FxZxN9cSoyY2xvogFQ5Ak
        ATKtD7XjCxiliKMJZVAIgoZ/aA==
X-Google-Smtp-Source: ACcGV61YB0//qGNB5fJ37rThZMXcjhFfRTt3HGmJf+URWtGGKGr19WXg+SGonBnZo+OihsEdZHK8cw==
X-Received: by 2002:a1c:b58e:: with SMTP id e136-v6mr3234019wmf.114.1537949115637;
        Wed, 26 Sep 2018 01:05:15 -0700 (PDT)
Received: from [192.168.0.41] (42.168.88.92.rev.sfr.net. [92.88.168.42])
        by smtp.googlemail.com with ESMTPSA id k7-v6sm4468535wmf.41.2018.09.26.01.05.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 01:05:14 -0700 (PDT)
Subject: Re: [PATCH v7 05/24] clocksource: Add a new timer-ingenic driver
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>, linux-doc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        od@zcrc.me, linux-mips@linux-mips.org,
        Paul Burton <paul.burton@mips.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
References: <5bab3024.1c69fb81.b6a71.9c38SMTPIN_ADDED_MISSING@mx.google.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <5af26854-0752-312b-6148-3ffa9abb2570@linaro.org>
Date:   Wed, 26 Sep 2018 10:05:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5bab3024.1c69fb81.b6a71.9c38SMTPIN_ADDED_MISSING@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <daniel.lezcano@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66565
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

On 26/09/2018 08:01, Paul Cercueil wrote:
> 
> Le 25 sept. 2018 10:12 PM, Daniel Lezcano <daniel.lezcano@linaro.org> a écrit :
>>
>> On 25/09/2018 15:38, Paul Cercueil wrote: 
>>>
>>> Le 24 sept. 2018 9:14 AM, Daniel Lezcano <daniel.lezcano@linaro.org> a écrit : 
>>>>
>>>> On 24/09/2018 08:53, Paul Cercueil wrote: 
>>>>>
>>>>> Le 24 sept. 2018 07:58, Daniel Lezcano <daniel.lezcano@linaro.org> a écrit : 
>>>>>>
>>>>>> On 24/09/2018 07:49, Paul Cercueil wrote: 
>>>>>>>
>>>>>>> Le 24 sept. 2018 07:35, Daniel Lezcano <daniel.lezcano@linaro.org> a 
>>>>>>> écrit : 
>>>>>>>>
>>>>>>>> On 24/09/2018 07:24, Paul Cercueil wrote: 
>>>>>>>>> Hi Daniel, 
>>>>>>>>>
>>>>>>>>> Le 24 sept. 2018 05:12, Daniel Lezcano 
>>>>>>>>> <daniel.lezcano@linaro.org> a écrit : 
>>>>>>>>>>
>>>>>>>>>> On 21/08/2018 19:16, Paul Cercueil wrote: 
>>>>>>>>>>> This driver handles the TCU (Timer Counter Unit) present on 
>>>>>>>>>>> the Ingenic JZ47xx SoCs, and provides the kernel with a 
>>>>>>>>>>> system timer, and optionally with a clocksource and a 
>>>>>>>>>>> sched_clock. 
>>>>>>>>>>>
>>>>>>>>>>> It also provides clocks and interrupt handling to client 
>>>>>>>>>>> drivers. 
>>>>>>>>>>
>>>>>>>>>> Can you provide a much more complete description of the timer 
>>>>>>>>>> in order to make my life easier for the review of this patch? 
>>>>>>>>>
>>>>>>>>> See patch [03/24], it adds a doc file that describes the 
>>>>>>>>> hardware. 
>>>>>>>>
>>>>>>>> Thanks, I went through but it is incomplete to understand what the 
>>>>>>>> timer do. I will reverse-engineer the code but it would help if you 
>>>>>>>> can give the gross approach. Why multiple channels ? mutexes and 
>>>>>>>> completion ? 
>>>>>>>
>>>>>>> Much of the complexity is because of the multi-purpose nature of the 
>>>>>>> TCU channels. Each one can be used as timer/clocksource, or PWM. 
>>>>>>>
>>>>>>> The driver starts by using channels 0 and 1 as system timer and 
>>>>>>> clocksource, respectively, the other ones being unused for now. Then, 
>>>>>>> *if* the PWM driver requests one of the channels in use by the 
>>>>>>> timer/clocksource driver, say channel 0, the timer/clocksource driver 
>>>>>>> will dynamically reassign the system timer to a free channel, from 
>>>>>>> channel 0 to e.g. channel 2. Only in that case the completion/mutex 
>>>>>>> are actually used. 
>>>>>>
>>>>>> Why do you need to do this? Can't be the channels dedicated and reserved 
>>>>>> for clocksource and clockevent? 
>>>>>
>>>>> That's what I had in place (ingenic,timer-channel and ingenic,clocksource-channel DT properties), but Rob didn't want any linux-specific properties in the devicetree binding :( 
>>>>
>>>> Isn't possible to specify the channel to use in the DT? like renesas16 ? 
>>>
>>> That's what I did in V6 (and before), but Rob did not want me to add properties for Linux-specific concepts such as clocksource. 
>>
>> Hmm, I remember something like that, yes but I did a delete of the 
>> previous version when you posted the v7. Can you give a pointer to its 
>> answer ? 
> 
> Yes, this was his answer:
> https://lkml.org/lkml/2018/7/25/508
> 
> Then mine:
> https://lkml.org/lkml/2018/7/30/883

Thanks !


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
