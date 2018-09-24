Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Sep 2018 07:35:16 +0200 (CEST)
Received: from mail-wm1-x341.google.com ([IPv6:2a00:1450:4864:20::341]:32826
        "EHLO mail-wm1-x341.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992066AbeIXFfOAMpjO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Sep 2018 07:35:14 +0200
Received: by mail-wm1-x341.google.com with SMTP id r1-v6so8912925wmh.0
        for <linux-mips@linux-mips.org>; Sun, 23 Sep 2018 22:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z9R1aXWDdyaRlMfRGrp94QSZu/fyz5EfI5I6L2UcPxw=;
        b=F0A+IgX8KvCefyU4euLvooaN8cO+Z0pYMbkFBYMrjwVARWC0azKYZ4SdpFTUhsaGi8
         A6VyP3FiL1qHpmaymEvzUYH5q0i9Op5xgMz9NNjpzE4EgPk3xgJVKNwepYUgAc/kjLea
         jWMawZ9ALhUyFVxk/Osw8W0qusXqQ0HqRAh9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z9R1aXWDdyaRlMfRGrp94QSZu/fyz5EfI5I6L2UcPxw=;
        b=Ic/Na5W7XrzsLiaiwQQPwHh6zWEFhwIQUG33m7GZv2iYKO1eTjdJcavbqRnZLHRe7W
         Y+4pTYdia0JmojjU/u/+CXHEXGZDVS3Ximdqku2Z2PEeOLRzhNMMGDEMEUI+KmM5EkNG
         Sk5YU9uV89Dk0wTdQsRc1QBa4uolgicHHNFuW8zIR2ZJgjho8Cu3OlDdhSavFG8DnENy
         kRylNaQWaXqTzW+Z0zlY3nz4dTXgFpantfbkEvP0kzUUERu2nl2Wf72xqBcStmzNK+Az
         g9pWTlnsPr4i9/R7FlUAslheeffVderxHj1mQbfmL+vUwmDE+qvKd2M3EaxdzY5hjQto
         AC7A==
X-Gm-Message-State: APzg51ALrZ5TCCFzJTrDtqV7gbjuH82Xh73FZtOBjojwY3d/K4JuAvbI
        DF9HaffL01ulQC6lM77vYCqFUw==
X-Google-Smtp-Source: ACcGV60TeS+4vcb6rH4dZXvnDjrJlrphbSBaoBASF7zbDuvGACWs16RYgXPlwsoESjE1xZsta9UP8g==
X-Received: by 2002:a1c:f210:: with SMTP id s16-v6mr4263888wmc.36.1537767307505;
        Sun, 23 Sep 2018 22:35:07 -0700 (PDT)
Received: from [192.168.0.41] (89.154.136.77.rev.sfr.net. [77.136.154.89])
        by smtp.googlemail.com with ESMTPSA id g2-v6sm2558997wmh.16.2018.09.23.22.35.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 22:35:06 -0700 (PDT)
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
References: <5ba8750a.1c69fb81.501e8.d0f0SMTPIN_ADDED_MISSING@mx.google.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <58645f14-aec2-4f66-3a39-34beeabdb035@linaro.org>
Date:   Mon, 24 Sep 2018 07:35:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5ba8750a.1c69fb81.501e8.d0f0SMTPIN_ADDED_MISSING@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <daniel.lezcano@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66495
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

On 24/09/2018 07:24, Paul Cercueil wrote:
> Hi Daniel,
> 
> Le 24 sept. 2018 05:12, Daniel Lezcano <daniel.lezcano@linaro.org> a écrit :
>>
>> On 21/08/2018 19:16, Paul Cercueil wrote: 
>>> This driver handles the TCU (Timer Counter Unit) present on the Ingenic 
>>> JZ47xx SoCs, and provides the kernel with a system timer, and optionally 
>>> with a clocksource and a sched_clock. 
>>>
>>> It also provides clocks and interrupt handling to client drivers. 
>>
>> Can you provide a much more complete description of the timer in order 
>> to make my life easier for the review of this patch? 
> 
> See patch [03/24], it adds a doc file that describes the hardware.

Thanks, I went through but it is incomplete to understand what the timer
do. I will reverse-engineer the code but it would help if you can give
the gross approach. Why multiple channels ? mutexes and completion ?


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
