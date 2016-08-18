Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Aug 2016 07:14:31 +0200 (CEST)
Received: from mail-yw0-f196.google.com ([209.85.161.196]:32970 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992557AbcHRFOY267sp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Aug 2016 07:14:24 +0200
Received: by mail-yw0-f196.google.com with SMTP id z8so777467ywa.0;
        Wed, 17 Aug 2016 22:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SDkijBHkQ2e0bb8/DLH1nAkNYrJ+pVINngY4do+VoQ8=;
        b=CrUNLXPhzHgIi7KfWgvl9MEBZmI5GXRDWTjqNqLbf/cCH3Hra8omj/5WdgxfqtUSoR
         uZBfy4ZNqs8NPlBp5CfnEl4O4VMecRWT7Rwb/W093DQqRyvnu+2BHOvwC97K76git3OA
         zD3xHVuvfgNlI2WC1GuJTTz3Oy2g9up/fCKojwlQnRPBOrIetTK1ORiIoRi1ECE5NPDg
         i+4s3JVlRBvWYV5Mb+ZmH9iLHZlophtV+r4FN4H6oE1rmmPLN67XWe+nCMPAAKVwoE0L
         JY38udMSmT7aIoWYviu/+jwgn5ImzidDeeK9Idlp+ovu7nxbLZBHuqXUYkuoB1UHSFRt
         U9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SDkijBHkQ2e0bb8/DLH1nAkNYrJ+pVINngY4do+VoQ8=;
        b=jIDZgbLieBwafLC7vJBQYwa7bICs3IrU6vjjzJtYiPUp1aZx2+p1FCx5ph08QewwT3
         B84E5oP/PG9RCO4kjDYJWLFPg6oqbEQxAW1fGTM+sy/+eZKFQICRD/Gxagh6QazPeOJ9
         QLQC9s5JN1LaJaFyy94k1gKLR8cbkPbHYzmh+MxvRA2QKb3U6WL/4CsJyW1vFJ4r5xQO
         SrB0oCjPbe/XzWBE2FVlKEuJB/8yxL1oOWgyF/m5AUbCzdfjlIim5wCJemzFoponnA2h
         3nNqwesz2d2MT3Ax3mZy7F+jRJ3b7KvVFOW9zvldYhdMX+6wMKIp34ZDE7ZqQLTspGPd
         AbzQ==
X-Gm-Message-State: AEkooutd1CaZn2DAkymtErwqYVnUpKqKvuyqcPSMwex7YUf9CSSToMiQYzjiDjobtI3tv3pJRamem//QqSqp/Q==
X-Received: by 10.13.231.199 with SMTP id q190mr284999ywe.26.1471497258581;
 Wed, 17 Aug 2016 22:14:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.218.67 with HTTP; Wed, 17 Aug 2016 22:14:18 -0700 (PDT)
In-Reply-To: <92a00062-9a87-0053-2c99-17bd1a304a4a@gmail.com>
References: <1471448151-20850-1-git-send-email-prasannatsmkumar@gmail.com> <92a00062-9a87-0053-2c99-17bd1a304a4a@gmail.com>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Thu, 18 Aug 2016 10:44:18 +0530
Message-ID: <CANc+2y55ZCkauwKNtuuCxLx-WOtm8z+A_EBKsYSjEUdc+ZbZTQ@mail.gmail.com>
Subject: Re: [PATCH] Add Ingenic JZ4780 hardware RNG driver
To:     Corentin LABBE <clabbe.montjoie@gmail.com>
Cc:     mpm@selenic.com, Herbert Xu <herbert@gondor.apana.org.au>,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Ralf Baechle <ralf@linux-mips.org>, davem@davemloft.net,
        geert@linux-m68k.org, Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>, mchehab@kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        boris.brezillon@free-electrons.com, harvey.hunt@imgtec.com,
        alex.smith@imgtec.com,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        kieran@ksquared.org.uk, Krzysztof Kozlowski <krzk@kernel.org>,
        joshua.henderson@microchip.com, yendapally.reddy@broadcom.com,
        narmstrong@baylibre.com, wangkefeng.wang@huawei.com,
        Christian Lamparter <chunkeey@googlemail.com>,
        =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>, pankaj.dev@st.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54579
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prasannatsmkumar@gmail.com
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

> I have just some minor comments below

Appreciate your review.

>> diff --git a/drivers/char/hw_random/jz4780-rng.c b/drivers/char/hw_random/jz4780-rng.c
>> new file mode 100644
>> index 0000000..c9d2cde
>> --- /dev/null
>> +++ b/drivers/char/hw_random/jz4780-rng.c
>> @@ -0,0 +1,105 @@
>> +/*
>> + * jz4780-rng.c - Random Number Generator driver for J4780
>> + *
>> + * Copyright 2016 (C) PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
>> + *
>> + * This file is licensed under  the terms of the GNU General Public
>> + * License version 2. This program is licensed "as is" without any
>> + * warranty of any kind, whether express or implied.
>> + */
>> +
>> +#include <linux/hw_random.h>
>> +#include <linux/device.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/io.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/err.h>
>
> You could sort them by alphabetical order

Sure, will do.

>> +
>> +#define REG_RNG_CTRL 0x0
>> +#define REG_RNG_DATA 0x4
>> +
>> +struct jz4780_rng {
>> +     struct device *dev;
>> +     struct hwrng rng;
>> +     void __iomem *mem;
>> +};
>> +
>> +static u32 jz4780_rng_readl(struct jz4780_rng *rng, u32 offset)
>> +{
>> +     return readl(rng->mem + offset);
>> +}
>> +
>> +static void jz4780_rng_writel(struct jz4780_rng *rng, u32 val, u32 offset)
>> +{
>> +     writel(val, rng->mem + offset);
>> +}
>> +
>> +static int jz4780_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
>> +{
>> +     struct jz4780_rng *jz4780_rng = container_of(rng, struct jz4780_rng,
>> +                                                     rng);
>> +     u32 *data = buf;
>> +     *data = jz4780_rng_readl(jz4780_rng, REG_RNG_DATA);
>> +     return 4;
>> +}
>
> If max is less than 4, its bad

Data will be 4 bytes.

>> +
>> +static int jz4780_rng_probe(struct platform_device *pdev)
>> +{
>> +     struct jz4780_rng *jz4780_rng;
>> +     struct resource *res;
>> +     resource_size_t size;
>> +     int ret;
>> +
>> +     jz4780_rng = devm_kzalloc(&pdev->dev, sizeof(struct jz4780_rng),
>> +                                     GFP_KERNEL);
>
> You could write sizeof(*js480_rng)

Will do.

>> +     if (!jz4780_rng)
>> +             return -ENOMEM;
>> +
>> +     jz4780_rng->dev = &pdev->dev;
>> +     jz4780_rng->rng.name = "jz4780";
>> +     jz4780_rng->rng.read = jz4780_rng_read;
>> +
>> +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +     size = resource_size(res);
>> +
>> +     jz4780_rng->mem = devm_ioremap(&pdev->dev, res->start, size);
> You could save code by using devm_ioremap_resource (don't need size)

Will do.

>> +     if (IS_ERR(jz4780_rng->mem))
>> +             return PTR_ERR(jz4780_rng->mem);
>> +
>> +     platform_set_drvdata(pdev, jz4780_rng);
>> +     jz4780_rng_writel(jz4780_rng, 1, REG_RNG_CTRL);
>> +     ret = hwrng_register(&jz4780_rng->rng);
>> +
>> +     return ret;
>> +}
> You could write directly return hwrng_register(..)

Will do.
