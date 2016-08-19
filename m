Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2016 14:54:25 +0200 (CEST)
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35715 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991104AbcHSMyTMK01U (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Aug 2016 14:54:19 +0200
Received: by mail-yw0-f196.google.com with SMTP id r9so786669ywg.2
        for <linux-mips@linux-mips.org>; Fri, 19 Aug 2016 05:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=reCbznfCbhwULJsJBl6Z1hHFJ4eGt1hvi/x6Kogb+/4=;
        b=lWcHYCPqWrSgbqXpQBl31fiXZSJDU/QMoQrBd026eWYKenM3bCUiIzsPtwtp9jEraM
         JMTW+arfh5oGbY4dhkR4u1er43nUHB20hAgjbZFusnzc02GLV0zGRpIlPSyV5cMQCo4o
         9kcI9+td/KO2xRfsZwU9Gtqm3a+vP29gTC0Nie/UaotNzEe8vKsdA5q6nERB+2FY5kBl
         MdBULRi3TpSHVstsQ8oWU9BhLbFAakUiCdtkcyFUMAAXVZXfQF8y6mTWh8oEQyiIZ6MT
         inRUVgCL0qHOYkomIIyEfphKm5vBUNuQm1wRER1P/mzwLNZCKEU14Gr+rTqsZbGK327k
         Rl7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=reCbznfCbhwULJsJBl6Z1hHFJ4eGt1hvi/x6Kogb+/4=;
        b=CPbWoGjimuAn0sz+9sTb9y02G22e7zew1ImkRFBZptRC1RK2ERUXtGr1vlfFZAw3yE
         ZzwhYHmcJLXPyH9HhpfaWhAJyfElvLtKx3UolyMjvepPJkSpHltzb/LHm9C4xU0lLR2B
         4t0YGoK/dxAmrZ+H8ibSiZ4pcexOmBe1PAgL0hgl2cFnfwzl+h1hcd2TBng+7GTwqN6/
         1tkz9PiIBMxOJQP+9U8+zlGhMyx2pTHWXwjf01vhJbRKufe5gJA3NEP5GqYe3HJs7f0d
         5tg21YQ4XqQgLyN0qV1pt2KxwnOrQAaSXqXC7FTC0OHx8HxdLyj3CNaSMsBDi6+w43d3
         ChcA==
X-Gm-Message-State: AEkoousEFvfHD/K2/RqswoXE0UpQMXKXcZFUKWNx3/jRxOIv9L0S7QdLDFCHzzA5lhMFvsxHVNoHzHGJ9N+m6w==
X-Received: by 10.129.177.198 with SMTP id p189mr6137595ywh.206.1471611253336;
 Fri, 19 Aug 2016 05:54:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.44.77 with HTTP; Fri, 19 Aug 2016 05:54:12 -0700 (PDT)
In-Reply-To: <CAH8yC8kt-+6tnzAc2bsu6GX4uX1bqVoE8sZXvCS34DDhGhP2XQ@mail.gmail.com>
References: <1471448151-20850-1-git-send-email-prasannatsmkumar@gmail.com> <CAH8yC8kt-+6tnzAc2bsu6GX4uX1bqVoE8sZXvCS34DDhGhP2XQ@mail.gmail.com>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Fri, 19 Aug 2016 18:24:12 +0530
Message-ID: <CANc+2y7YGGVVMHnbBVy7B6ZHyiUuLALvTeU6iVTP-9TYXjjHDA@mail.gmail.com>
Subject: Re: [PATCH] Add Ingenic JZ4780 hardware RNG driver
To:     noloader@gmail.com
Cc:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54684
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

> Please forgive my ignorance Prasanna...
>
> For the JZ4780 I have, there are two registers in play. The first is
> the control register which enables/disables the RNG. The control
> register is named ERNG. The second register is the data register, and
> it produces the random stream. The data register is named RNG. ERNG is
> located at 0x100000D8 and RNG is located at 0x100000DC. This kind of
> confuses me because I don't see where 0x100000D8 is ever added to
> those values (maybe its in the descriptor?):
>
> +#define REG_RNG_CTRL   0x0
> +#define REG_RNG_DATA   0x4

The base address 0x100000D8 is defined in jz4780.dtsi file.
REG_RNG_CTRL and REG_RNG_DATA are offsets. In jz4780_rng_readl and
jz4780_rng_writel functions the ioremap'd base address is added with
offset.

> Also, testing with a userland PoC for the device, you have to throttle
> reads from RNG register. If reads occur with a 0 delay, then the
> random value appears fixed. If the delay is too small, then you can
> watch random values being shifted-in in a barrel like fashion.
> Unfortunately, the manual did not discuss how long to wait for a value
> to be ready. I found spinning in a loop for 5000 was too small and
> witnessed the shifting; while spinning in a loop for 10000 avoided the
> shift observation. I don't what number of JIFFIES that translates to.

I can calculate the speed and make sure the delay is met in the
driver. Thanks a lot for providing this info.

> Finally, from looking at the native Ingenic driver (which was not very
> impressive), they enabled/disabled the RNG register on demand. There
> was also a [possible related] note in the manual about not applying
> VCC for over a second. I can only say "possibly related" because I was
> not sure if the register was part of the controller they were
> discussing. The userland PoC worked fine when enabling/disabling the
> RNG register. So I'm not sure about this (from jz4780_rng_probe):
>
> +       platform_set_drvdata(pdev, jz4780_rng);
> +       jz4780_rng_writel(jz4780_rng, 1, REG_RNG_CTRL);
> +       ret = hwrng_register(&jz4780_rng->rng);
>
> And this (from jz4780_rng_remove):
>
> +       jz4780_rng_writel(jz4780_rng, 0, REG_RNG_CTRL);
> +       hwrng_unregister(&jz4780_rng->rng);
>
> Anyway, I hope that helps you avoid some land mines (if they are present).

Looking at JZ4780 Programmers manual I could not find any info about
VCC. Can you point me to it?
