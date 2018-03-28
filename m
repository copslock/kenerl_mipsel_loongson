Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2018 20:36:23 +0200 (CEST)
Received: from mail-ot0-x244.google.com ([IPv6:2607:f8b0:4003:c0f::244]:45213
        "EHLO mail-ot0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993928AbeC1SgRSGwMz convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Mar 2018 20:36:17 +0200
Received: by mail-ot0-x244.google.com with SMTP id h26-v6so3709149otj.12;
        Wed, 28 Mar 2018 11:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=UL3HEOyI5ntPgQ0j3yAMhhAsoCmImVZbsW5xHw8yVbY=;
        b=R8x5B+8ou25iUP57C68HKAvruSftqRRGrBp0WOn9ukC/0KifKVtqaHFUClvjZeoRTl
         NxYwyL/j+54HViJkfrQI2EC3yHEThfRBhit+5jLkbaDRT92G/dIMAWavlFyj+paPGHqE
         2hC5StiOSH2j2OiBMfypwx8irIV79P+o2f9EjXWppJMEIbe45Da7pwKzT+zRZf5v9x2X
         LPZjDGPS2LyV7Pydg7myS62UOg2mDedzrPdsMI3T4Hs84uiG1kqtaQPuis1eGsUQn4ZT
         qF8erjvIDfrlEFv3RmaYSp4CgvzQ1qnUF53A9XRv7NlmkSS8crw6i5O51Rv89Pq0b+qj
         YmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=UL3HEOyI5ntPgQ0j3yAMhhAsoCmImVZbsW5xHw8yVbY=;
        b=WwrwCaEWB5oUXDOHbB+2kdimaq1E0o2xvIpSwwyQXBIbUpMbEx+2ZWJboQXv7VoZA/
         gxhMJqyAkQ8rDL7krvwuSz7Av53KOU/x7g36XTXLT9+1xKFjI/R56yz4lQE0m34Dkrvu
         useFnHJIq2wSwHVsEOJtwNQAEWtfVIunwY4olv43JEZhQRfCcEncY2xRESON/QXxZ/jq
         NYVdgOHyxVPKytK+/JJZcfPf5I/xg+tJsp931UPQK4qijC53QZL9exJIcp5HursU9Iyb
         Vbagax3TdDQWkJZ/Uv/68UNH28azkDOMeIDksnVOiqRNny1+1FtP1/Cx0Zf04wIyHSFs
         Gkgw==
X-Gm-Message-State: ALQs6tAivKi1eDcnrIOQIRSeYnMuuuzL0uRp36Txgz6NnOjauhMkuHWi
        HQQij304nYTTJyaoerIL+8JRe1Ku9kg7Uz+iWTg=
X-Google-Smtp-Source: AIpwx4/1QRmmoOAKxeGXs5kC762r+b6dzPlxYRDqkHiRMPq/eyXkDS1hCOh7GyLaJBOR+VNgjta56equTl3nCjNmuuU=
X-Received: by 2002:a9d:29ea:: with SMTP id g39-v6mr3057850otd.241.1522262170771;
 Wed, 28 Mar 2018 11:36:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.138.3.76 with HTTP; Wed, 28 Mar 2018 11:35:50 -0700 (PDT)
In-Reply-To: <c02d2ae665890e7214bcfa6c42a49c69@crapouillou.net>
References: <20180110224838.16711-2-paul@crapouillou.net> <20180317232901.14129-1-paul@crapouillou.net>
 <20180317232901.14129-3-paul@crapouillou.net> <CA+7wUsyAkW+Bgmp6MuWTce1jMG-ug1b-UqFVen_vVeKFiW5Fww@mail.gmail.com>
 <c02d2ae665890e7214bcfa6c42a49c69@crapouillou.net>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Wed, 28 Mar 2018 20:35:50 +0200
X-Google-Sender-Auth: poi3CHIuufSvBUbH1UVKJwpWaUk
Message-ID: <CA+7wUswkTy=1BJwk0Ys=HFZ4Sk9pFr4jsE0LvDM1x41YRBCg4g@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] dt-bindings: ingenic: Add DT bindings for TCU clocks
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>,
        James Hogan <jhogan@kernel.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        linux-clk@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63298
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: malat@debian.org
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

On Wed, Mar 28, 2018 at 5:04 PM, Paul Cercueil <paul@crapouillou.net> wrote:
> Le 2018-03-20 08:15, Mathieu Malaterre a écrit :
>>
>> Hi Paul,
>>
>> Two things:
>>
>> On Sun, Mar 18, 2018 at 12:28 AM, Paul Cercueil <paul@crapouillou.net>
>> wrote:
>>>
>>> This header provides clock numbers for the ingenic,tcu
>>> DT binding.
>>
>>
>> I have tested the whole series on my Creator CI20 with success, using:
>>
>> + tcu@10002000 {
>> + compatible = "ingenic,jz4780-tcu";
>> + reg = <0x10002000 0x140>;
>> +
>> + interrupt-parent = <&intc>;
>> + interrupts = <27 26 25>;
>> + };
>>
>>
>> So:
>>
>> Tested-by: Mathieu Malaterre <malat@debian.org>
>
>
> Great! Is that for the whole patchset or just this one patch?

The sentence just above was "whole series"  :) so yes that was for the
whole series. Technically I only tested it on JZ4780, I hope this is
acceptable for the tag.



>
>>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>> ---
>>>  include/dt-bindings/clock/ingenic,tcu.h | 23 +++++++++++++++++++++++
>>>  1 file changed, 23 insertions(+)
>>>  create mode 100644 include/dt-bindings/clock/ingenic,tcu.h
>>>
>>>  v2: Use SPDX identifier for the license
>>>  v3: No change
>>>  v4: No change
>>>
>>> diff --git a/include/dt-bindings/clock/ingenic,tcu.h
>>> b/include/dt-bindings/clock/ingenic,tcu.h
>>> new file mode 100644
>>> index 000000000000..179815d7b3bb
>>> --- /dev/null
>>> +++ b/include/dt-bindings/clock/ingenic,tcu.h
>>> @@ -0,0 +1,23 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +/*
>>> + * This header provides clock numbers for the ingenic,tcu DT binding.
>>> + */
>>> +
>>> +#ifndef __DT_BINDINGS_CLOCK_INGENIC_TCU_H__
>>> +#define __DT_BINDINGS_CLOCK_INGENIC_TCU_H__
>>> +
>>> +#define JZ4740_CLK_TIMER0      0
>>> +#define JZ4740_CLK_TIMER1      1
>>> +#define JZ4740_CLK_TIMER2      2
>>> +#define JZ4740_CLK_TIMER3      3
>>> +#define JZ4740_CLK_TIMER4      4
>>> +#define JZ4740_CLK_TIMER5      5
>>> +#define JZ4740_CLK_TIMER6      6
>>> +#define JZ4740_CLK_TIMER7      7
>>> +#define JZ4740_CLK_WDT         8
>>> +#define JZ4740_CLK_LAST                JZ4740_CLK_WDT
>>> +
>>> +#define JZ4770_CLK_OST         9
>>> +#define JZ4770_CLK_LAST                JZ4770_CLK_OST
>>> +
>>
>>
>> When working on JZ4780 support, I always struggle to read those kind
>> of #define. Since this is a new patch would you mind changing
>> s/JZ4740/JZ47XX/ in your header ?
>
>
> Well the idea was that these defines are for JZ4740 and newer.
> But that means all Ingenic SoCs, so I guess I can change it.
>
>> Thanks for your work on JZ !
>
>
> Sure, thank you for testing!
>
>
>>> +#endif /* __DT_BINDINGS_CLOCK_INGENIC_TCU_H__ */
>>> --
>>> 2.11.0
>>>
>>>
>
