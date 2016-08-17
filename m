Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Aug 2016 21:07:10 +0200 (CEST)
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35386 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992843AbcHQTHDrTOSx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Aug 2016 21:07:03 +0200
Received: by mail-wm0-f67.google.com with SMTP id i5so92469wmg.2;
        Wed, 17 Aug 2016 12:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=I3UFOxe039mQ4Zjeeu8P4P7heqsOmPM8kYBNLiovx0I=;
        b=SFXdaS5Godp0MoHqVsqgeOnccMu68cvxuFPBBuEQAGMu2D0ossREWhIWxg81A6BCjE
         4n9XsW9OjOEExcs9uzuLKsqzvWdokdLyagOsHL8ben528XhLTq+Yop2ix6XADEHtidoD
         iyn3UU9LQQ08oG+bku4zvl6Pz6DG+25AMd6iXxb4GekeWeSGnZqxWhbHNoXNjjmxlubf
         h9O+KKw+glCL+03k2ylT1w8S5LqIo4qirl9ZoGHH3wMDOjQlW6GexyBacg2Uv0bSBM6W
         qgVgzm5s+BODf135rLKYuxRDv1aOZvi6fQHmR4Lc9T+8OAnckRFTsPGRgN1Cy8HdzdZ6
         wpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=I3UFOxe039mQ4Zjeeu8P4P7heqsOmPM8kYBNLiovx0I=;
        b=exS3KZ8Kc/l9Jl9GU1kq1RKHNAJOaj0fhbY0AK3j0/550aEc9zGmyXT2ekjVUCQzr8
         rqlbCtAOpxbGt8ABoXictSLY6FDxoaHyg+kVV5QhxxD4H9eweoZeXy6dMSYH9LD9nfmy
         ukTph4AUb2G9SBV654gJ6q5xlp2m4fd+YceHFU0bkbf2n57UL4UgGwtKq3Zqw+qfePcQ
         m37w0gF7kDiYUTCUMG5daznwfbVVXGp7UX7SjpaW6kWPRoGkMzHJhf2dWAKroAH0UlTD
         SrIbV7V/LdeXZGBEYaz00560Z46zwgjpHuLFdzROIc2g/LHvE2Mpu9ikM3aY43sqf8Eh
         GrOg==
X-Gm-Message-State: AEkoouu0FRIlyt4XUzxGGcMmbq1K4j/CT1CO+VNYwO9uS4J7zHMjiKqSixdhmHXzVUgfCg==
X-Received: by 10.194.143.17 with SMTP id sa17mr44127235wjb.97.1471460818459;
        Wed, 17 Aug 2016 12:06:58 -0700 (PDT)
Received: from [192.168.1.100] (ANice-651-1-11-220.w86-203.abo.wanadoo.fr. [86.203.162.220])
        by smtp.googlemail.com with ESMTPSA id p4sm32888540wjq.27.2016.08.17.12.06.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Aug 2016 12:06:57 -0700 (PDT)
Subject: Re: [PATCH] Add Ingenic JZ4780 hardware RNG driver
To:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        mpm@selenic.com, herbert@gondor.apana.org.au, robh+dt@kernel.org,
        mark.rutland@arm.com, ralf@linux-mips.org, davem@davemloft.net,
        geert@linux-m68k.org, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, mchehab@kernel.org, linux@roeck-us.net,
        boris.brezillon@free-electrons.com, harvey.hunt@imgtec.com,
        alex.smith@imgtec.com, daniel.thompson@linaro.org,
        lee.jones@linaro.org, f.fainelli@gmail.com, kieran@ksquared.org.uk,
        krzk@kernel.org, joshua.henderson@microchip.com,
        yendapally.reddy@broadcom.com, narmstrong@baylibre.com,
        wangkefeng.wang@huawei.com, chunkeey@googlemail.com,
        noltari@gmail.com, linus.walleij@linaro.org, pankaj.dev@st.com,
        mathieu.poirier@linaro.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
References: <1471448151-20850-1-git-send-email-prasannatsmkumar@gmail.com>
From:   Corentin LABBE <clabbe.montjoie@gmail.com>
Message-ID: <92a00062-9a87-0053-2c99-17bd1a304a4a@gmail.com>
Date:   Wed, 17 Aug 2016 21:06:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1471448151-20850-1-git-send-email-prasannatsmkumar@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <clabbe.montjoie@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54578
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clabbe.montjoie@gmail.com
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

Hello

I have just some minor comments below

> diff --git a/drivers/char/hw_random/jz4780-rng.c b/drivers/char/hw_random/jz4780-rng.c
> new file mode 100644
> index 0000000..c9d2cde
> --- /dev/null
> +++ b/drivers/char/hw_random/jz4780-rng.c
> @@ -0,0 +1,105 @@
> +/*
> + * jz4780-rng.c - Random Number Generator driver for J4780
> + *
> + * Copyright 2016 (C) PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
> + *
> + * This file is licensed under  the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/hw_random.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/io.h>
> +#include <linux/platform_device.h>
> +#include <linux/err.h>

You could sort them by alphabetical order

> +
> +#define REG_RNG_CTRL	0x0
> +#define REG_RNG_DATA	0x4
> +
> +struct jz4780_rng {
> +	struct device *dev;
> +	struct hwrng rng;
> +	void __iomem *mem;
> +};
> +
> +static u32 jz4780_rng_readl(struct jz4780_rng *rng, u32 offset)
> +{
> +	return readl(rng->mem + offset);
> +}
> +
> +static void jz4780_rng_writel(struct jz4780_rng *rng, u32 val, u32 offset)
> +{
> +	writel(val, rng->mem + offset);
> +}
> +
> +static int jz4780_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
> +{
> +	struct jz4780_rng *jz4780_rng = container_of(rng, struct jz4780_rng,
> +							rng);
> +	u32 *data = buf;
> +	*data = jz4780_rng_readl(jz4780_rng, REG_RNG_DATA);
> +	return 4;
> +}

If max is less than 4, its bad

> +
> +static int jz4780_rng_probe(struct platform_device *pdev)
> +{
> +	struct jz4780_rng *jz4780_rng;
> +	struct resource *res;
> +	resource_size_t size;
> +	int ret;
> +
> +	jz4780_rng = devm_kzalloc(&pdev->dev, sizeof(struct jz4780_rng),
> +					GFP_KERNEL);

You could write sizeof(*js480_rng)

> +	if (!jz4780_rng)
> +		return -ENOMEM;
> +
> +	jz4780_rng->dev = &pdev->dev;
> +	jz4780_rng->rng.name = "jz4780";
> +	jz4780_rng->rng.read = jz4780_rng_read;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	size = resource_size(res);
> +
> +	jz4780_rng->mem = devm_ioremap(&pdev->dev, res->start, size);
You could save code by using devm_ioremap_resource (don't need size)

> +	if (IS_ERR(jz4780_rng->mem))
> +		return PTR_ERR(jz4780_rng->mem);
> +
> +	platform_set_drvdata(pdev, jz4780_rng);
> +	jz4780_rng_writel(jz4780_rng, 1, REG_RNG_CTRL);
> +	ret = hwrng_register(&jz4780_rng->rng);
> +
> +	return ret;
> +}
You could write directly return hwrng_register(..)

Regards

LABBE Corentin
