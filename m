Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Aug 2016 14:20:15 +0200 (CEST)
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38866 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993262AbcHRMUIQcGBp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Aug 2016 14:20:08 +0200
Received: by mail-wm0-f47.google.com with SMTP id o80so29143993wme.1
        for <linux-mips@linux-mips.org>; Thu, 18 Aug 2016 05:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=kD9pg7wSuYkFZCZt1eY/IIQnUXSFFBLB5AThNVelVk0=;
        b=Unm52PnU1DGSGPT5Z3Ec2AZRtSMXUkjr8FSiRDk418HbIYtbIqOOxLLuvDNCIrH+ms
         BAMrzvbIvzGB41fIQ7YVRCSAnt7hdbU3pcLRVWVxLoHlw6DdVKnN26fKvaW/jpxFo/zE
         Hif+BijUZYXgDgDfESFfUt0s2l8fsu9DHGxtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=kD9pg7wSuYkFZCZt1eY/IIQnUXSFFBLB5AThNVelVk0=;
        b=fQvJOdhlgnoYCMX+/LnSVC06eq+pHpnT2tUkd/Y38PiLuoTdLOVCN4IXcHDWOfYaxZ
         XGM9KTtTGmzsPKFhalSJMGnFsq17K/7qle6n1B1LYUOeNieF/KlViBZcfV+HU/o0e7tZ
         b5hxD38halwIYnuQKWu2/TMX3TSAp8bzZqWJdrSgZr56DzPzD9YQfPunDa6vjSa+OgDH
         LtyvSgmwIr5XgfbYAS591UbkA96NxJf4zLsqwMNOJNGn9R6/d4Bxyg4RzJPJLTWPIx3y
         kYtaQmLYWe2DxiIKOXlU1nww3qFQIsQQt1J1AugU4NnSvXE9PIH42SptSzJfCFJqKdvW
         XaNg==
X-Gm-Message-State: AEkoouvPHgtJIRunUqNGwJoi+2c0LhPV+d7DENgGST6BZXOUnuCZCVxAH/ZBZM664T2Axbzb
X-Received: by 10.28.131.208 with SMTP id f199mr2216556wmd.116.1471522802848;
        Thu, 18 Aug 2016 05:20:02 -0700 (PDT)
Received: from [192.168.1.125] (cpc4-aztw19-0-0-cust71.18-1.cable.virginm.net. [82.33.25.72])
        by smtp.googlemail.com with ESMTPSA id lv9sm2017217wjb.22.2016.08.18.05.20.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Aug 2016 05:20:01 -0700 (PDT)
Subject: Re: [PATCH] Add Ingenic JZ4780 hardware RNG driver
To:     LABBE Corentin <clabbe.montjoie@gmail.com>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
References: <1471448151-20850-1-git-send-email-prasannatsmkumar@gmail.com>
 <92a00062-9a87-0053-2c99-17bd1a304a4a@gmail.com>
 <CANc+2y55ZCkauwKNtuuCxLx-WOtm8z+A_EBKsYSjEUdc+ZbZTQ@mail.gmail.com>
 <20160818115300.GA6621@Red>
Cc:     mpm@selenic.com, Herbert Xu <herbert@gondor.apana.org.au>,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Ralf Baechle <ralf@linux-mips.org>, davem@davemloft.net,
        geert@linux-m68k.org, Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>, mchehab@kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        boris.brezillon@free-electrons.com, harvey.hunt@imgtec.com,
        alex.smith@imgtec.com, Lee Jones <lee.jones@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        kieran@ksquared.org.uk, Krzysztof Kozlowski <krzk@kernel.org>,
        joshua.henderson@microchip.com, yendapally.reddy@broadcom.com,
        narmstrong@baylibre.com, wangkefeng.wang@huawei.com,
        Christian Lamparter <chunkeey@googlemail.com>,
        =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>, pankaj.dev@st.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
From:   Daniel Thompson <daniel.thompson@linaro.org>
Message-ID: <291974d6-1398-716f-3c76-662a7616eb6b@linaro.org>
Date:   Thu, 18 Aug 2016 13:19:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160818115300.GA6621@Red>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <daniel.thompson@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54614
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.thompson@linaro.org
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

On 18/08/16 12:53, LABBE Corentin wrote:
> On Thu, Aug 18, 2016 at 10:44:18AM +0530, PrasannaKumar Muralidharan wrote:
>>>> +static int jz4780_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
>>>> +{
>>>> +     struct jz4780_rng *jz4780_rng = container_of(rng, struct jz4780_rng,
>>>> +                                                     rng);
>>>> +     u32 *data = buf;
>>>> +     *data = jz4780_rng_readl(jz4780_rng, REG_RNG_DATA);
>>>> +     return 4;
>>>> +}
>>>
>>> If max is less than 4, its bad
>>
>> Data will be 4 bytes.
>>
>
> No, according to comment in include/linux/hw_random.h "drivers can fill up to max bytes of data"
> So you cannot write more than max bytes without risking buffer overflow.
>
> And if max > 4, hwrng client need to recall your read function.
> The better example I found is tpm_get_random() in drivers/char/tpm/tpm-interface.c for handling both problem.

Right now the core code will never actually ask a RNG driver for <4 
bytes so perhaps it would be better to update the comment in 
include/linux/hw_random.h !

For devices with 32-bit RNG registers the extra code to handle a special 
case that doesn't actually exist is a waste.

There are 14 drivers in drivers/char/hw_random that support the ->read() 
interface but only three of these actually support max == 1 (existing 
accepted behavior varies between return 0, return 2, return 4 and return 
-EIO).


Daniel.
