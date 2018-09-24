Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Sep 2018 09:14:37 +0200 (CEST)
Received: from mail-wr1-x444.google.com ([IPv6:2a00:1450:4864:20::444]:45683
        "EHLO mail-wr1-x444.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991947AbeIXHOeNl0KD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Sep 2018 09:14:34 +0200
Received: by mail-wr1-x444.google.com with SMTP id m16so2029774wrx.12
        for <linux-mips@linux-mips.org>; Mon, 24 Sep 2018 00:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WuG1X1M3KFSddiJgkJ0AwqTU/xMGLDpRyA5DOLC5w1U=;
        b=S+o2Fv41yiCbgxZnkAkjHKlxTtIEptB915xs1gdcKJQ3uXDJvskK56BFGCRuopQQ2t
         gWLg0P3P8LXWegkr66xzTgMxPp8E3i9huZUKOGup/ehJb7LxiIqhZx1MkJ25C6FRWo/p
         KaqGgKbUCeup3TLkPgxlf/W1mRwj/ceywId9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WuG1X1M3KFSddiJgkJ0AwqTU/xMGLDpRyA5DOLC5w1U=;
        b=TpmeUlgIZKMsZYcShn3cqIb6P4g+7vB+N0+GzoJvX/KqownsXxWaeoeq0CJtxoTTE1
         lxD0OvbC8YtujkhtXxpfWjCQcgRGm+Hu8DIBSUdARk8J17XbmSLFh6KIdcLcO6d1OWeY
         hiOe0GoT1syf8hcoZTHRWGGqGpDLRW06c+ZVhbN1lOIw3tlI2J+EqDUgAP1JLzilUgD+
         y0S07opO95+1Pa6q5XDaHvlX2m3KThZy1dnUQDDTIlJ3VxUSIL7vsOgfzv9xuG/sxKyA
         c8W7U3cyK4z/PnxF/RgtzEjdvNG87oCnb7o/ckDCGuHnO/ktmFlbRbVhwqcltVR7c3Jt
         oZXw==
X-Gm-Message-State: ABuFfoi2NpRKut3IvpxUU7slEHfXj+xEo44UY8cVAWCrIxi5BV/zxm3J
        gulVM6ZgPrgri5FO6dWfZ21ItQ==
X-Google-Smtp-Source: ACcGV60s4laND56QrgYhaZFALQur/k4kF1YTXHLrwNFcFHOwCO/BhsK4F0Mi5w89AooR/Mwfby0jJg==
X-Received: by 2002:a5d:4b52:: with SMTP id w18-v6mr7202299wrs.87.1537773268575;
        Mon, 24 Sep 2018 00:14:28 -0700 (PDT)
Received: from [192.168.0.41] (89.154.136.77.rev.sfr.net. [77.136.154.89])
        by smtp.googlemail.com with ESMTPSA id l5sm838709wrx.69.2018.09.24.00.14.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 00:14:27 -0700 (PDT)
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
References: <5ba88a1a.1c69fb81.2ba56.ccdaSMTPIN_ADDED_MISSING@mx.google.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a9d7366a-7118-9819-4d15-cdc10fa6c41c@linaro.org>
Date:   Mon, 24 Sep 2018 09:14:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5ba88a1a.1c69fb81.2ba56.ccdaSMTPIN_ADDED_MISSING@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <daniel.lezcano@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66499
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

On 24/09/2018 08:53, Paul Cercueil wrote:
> 
> Le 24 sept. 2018 07:58, Daniel Lezcano <daniel.lezcano@linaro.org> a écrit :
>>
>> On 24/09/2018 07:49, Paul Cercueil wrote: 
>>>
>>> Le 24 sept. 2018 07:35, Daniel Lezcano <daniel.lezcano@linaro.org> a 
>>> écrit : 
>>>>
>>>> On 24/09/2018 07:24, Paul Cercueil wrote: 
>>>>> Hi Daniel, 
>>>>>
>>>>> Le 24 sept. 2018 05:12, Daniel Lezcano 
>>>>> <daniel.lezcano@linaro.org> a écrit : 
>>>>>>
>>>>>> On 21/08/2018 19:16, Paul Cercueil wrote: 
>>>>>>> This driver handles the TCU (Timer Counter Unit) present on 
>>>>>>> the Ingenic JZ47xx SoCs, and provides the kernel with a 
>>>>>>> system timer, and optionally with a clocksource and a 
>>>>>>> sched_clock. 
>>>>>>>
>>>>>>> It also provides clocks and interrupt handling to client 
>>>>>>> drivers. 
>>>>>>
>>>>>> Can you provide a much more complete description of the timer 
>>>>>> in order to make my life easier for the review of this patch? 
>>>>>
>>>>> See patch [03/24], it adds a doc file that describes the 
>>>>> hardware. 
>>>>
>>>> Thanks, I went through but it is incomplete to understand what the 
>>>> timer do. I will reverse-engineer the code but it would help if you 
>>>> can give the gross approach. Why multiple channels ? mutexes and 
>>>> completion ? 
>>>
>>> Much of the complexity is because of the multi-purpose nature of the 
>>> TCU channels. Each one can be used as timer/clocksource, or PWM. 
>>>
>>> The driver starts by using channels 0 and 1 as system timer and 
>>> clocksource, respectively, the other ones being unused for now. Then, 
>>> *if* the PWM driver requests one of the channels in use by the 
>>> timer/clocksource driver, say channel 0, the timer/clocksource driver 
>>> will dynamically reassign the system timer to a free channel, from 
>>> channel 0 to e.g. channel 2. Only in that case the completion/mutex 
>>> are actually used. 
>>
>> Why do you need to do this? Can't be the channels dedicated and reserved 
>> for clocksource and clockevent? 
> 
> That's what I had in place (ingenic,timer-channel and ingenic,clocksource-channel DT properties), but Rob didn't want any linux-specific properties in the devicetree binding :(

Isn't possible to specify the channel to use in the DT? like renesas16 ?

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
