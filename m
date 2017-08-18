Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Aug 2017 16:06:56 +0200 (CEST)
Received: from mail-io0-x243.google.com ([IPv6:2607:f8b0:4001:c06::243]:36430
        "EHLO mail-io0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994912AbdHROGuUmm7K (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Aug 2017 16:06:50 +0200
Received: by mail-io0-x243.google.com with SMTP id j32so5727127iod.3;
        Fri, 18 Aug 2017 07:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=K9E6pGZr2CMKGrVL7/Nx47x/bDvMJu+ih5UDysDwOBU=;
        b=m8QiPH9GWLsnhYRFP0VexddvamwEGedkPpo39Dh4yLsoCdQ36swwkXoAyGOgNbBn0g
         n5qpIJ1IZuRJZpO47H+PJnNUVyvTpBtfOE4KCQZro5Uq2mmAOXkGE3jIgJG4m2Q6o/k4
         ATOR7q2xJHnmT+ffjVSc8U825l319c0xOsjT7LP9wA8pqLps2eiprYw5Lqqoj76/xots
         EwuhzrRpGz7yezyq0FuOnWK0rA1TWuiyVVWZgjvQoQP4du0hpj8/BUsOnDNI8VDzswNq
         s6ln9xBfoPClOWJIaoCfh05Zu8BqwDzyDOQt9NaT3YIRE/HbyHrpf3q2I4AYdUYa1kBW
         mM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=K9E6pGZr2CMKGrVL7/Nx47x/bDvMJu+ih5UDysDwOBU=;
        b=ZJCxodJFa4z2cKOO0MLhq7NVj1GFBrvErXOrfxkfWL84NHYrnHaGRibiG+uIjX+mWJ
         zLplrdfFb2/7sh2h2dKaA9ggtw70+USAis/vpwecSps4fU5uCsxeg8QdbM1b+PqGN7Zh
         3qaTmBPz6oSLY/k3Nzig5hUbeg2eDTPa7vnE7i3oWLcBwrY5Cg49IJUu05jCygW3fPCw
         yt+thpLUNikMzzNg1pneHg71ajihaZTYFicPFnc69IbzO8osDWfd7mIL0inwJIYDxkXG
         DCr2wB7Q/FWAyvsbiJJ59gqQ5F9T0nS5QlKWwKQ+Qz3e9Hl3vqMi7jy1vJ9MtsNCHrsV
         4eYQ==
X-Gm-Message-State: AHYfb5i6785OKqoV9feq7lYfVBlFbaFb4N/iAx4jqsbTnzI9RP4M7H94
        /tYWCcR6pmkp5A5+YyRku3REttiAYw==
X-Received: by 10.107.130.33 with SMTP id e33mr8226735iod.322.1503065204270;
 Fri, 18 Aug 2017 07:06:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.2.14.197 with HTTP; Fri, 18 Aug 2017 07:06:43 -0700 (PDT)
In-Reply-To: <20325029.4QLNKKN8OS@tauon.chronox.de>
References: <20170817182520.20102-1-prasannatsmkumar@gmail.com>
 <20170817182520.20102-4-prasannatsmkumar@gmail.com> <20325029.4QLNKKN8OS@tauon.chronox.de>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Fri, 18 Aug 2017 19:36:43 +0530
Message-ID: <CANc+2y5zEg7NeE7a8JK+ALwtPN0FJ6Ajo2PxBGGZ=fBzxtKbjA@mail.gmail.com>
Subject: Re: [PATCH 3/6] crypto: jz4780-rng: Add Ingenic JZ4780 hardware PRNG driver
To:     Stephan Mueller <smueller@chronox.de>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        sboyd@codeaurora.org, "David S . Miller" <davem@davemloft.net>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-crypto@vger.kernel.org, linux-mips@linux-mips.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59666
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

Hi Stephan,

On 18 August 2017 at 00:22, Stephan Mueller <smueller@chronox.de> wrote:
> Am Donnerstag, 17. August 2017, 20:25:17 CEST schrieb PrasannaKumar
> Muralidharan:
>
> Hi PrasannaKumar,
>
>> +
>> +static int jz4780_rng_generate(struct crypto_rng *tfm,
>> +                            const u8 *src, unsigned int slen,
>> +                            u8 *dst, unsigned int dlen)
>> +{
>> +     struct jz4780_rng_ctx *ctx = crypto_rng_ctx(tfm);
>> +     struct jz4780_rng *rng = ctx->rng;
>> +     u32 data;
>> +
>> +     /*
>> +      * JZ4780 Programmers manual says the RNG should not run continuously
>> +      * for more than 1s. So enable RNG, read data and disable it.
>> +      * NOTE: No issue was observed with MIPS creator CI20 board even when
>> +      * RNG ran continuously for longer periods. This is just a precaution.
>> +      *
>> +      * A delay is required so that the current RNG data is not bit shifted
>> +      * version of previous RNG data which could happen if random data is
>> +      * read continuously from this device.
>> +      */
>> +     jz4780_rng_writel(rng, 1, REG_RNG_CTRL);
>> +     do {
>> +             data = jz4780_rng_readl(rng, REG_RNG_DATA);
>> +             memcpy((void *)dst, (void *)&data, 4);
>
> How do you know that dst is a multiple of 4 bytes? When dlen is only 3, you
> overflow the buffer.

You are right. I initially used hw_random framework for this driver.
But later realised that PRNG driver should use crypto framework. When
I started using crypto I reused most of the code. This was because of
porting. Will change it and send next version.

>
>> +             dlen -= 4;
>> +             dst += 4;
>> +             udelay(20);
>> +     } while (dlen >= 4);
>> +
>> +     if (dlen > 0) {
>> +             data = jz4780_rng_readl(rng, REG_RNG_DATA);
>> +             memcpy((void *)dst, (void *)&data, dlen);
>> +     }
>> +     jz4780_rng_writel(rng, 0, REG_RNG_CTRL);
>> +
>> +     return 0;
>> +}
>
> Ciao
> Stephan

Thanks,
PrasannaKumar
