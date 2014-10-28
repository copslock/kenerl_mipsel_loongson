Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2014 15:37:43 +0100 (CET)
Received: from mail-ie0-f174.google.com ([209.85.223.174]:63862 "EHLO
        mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011346AbaJ1OhlgXRtP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Oct 2014 15:37:41 +0100
Received: by mail-ie0-f174.google.com with SMTP id x19so773779ier.33
        for <linux-mips@linux-mips.org>; Tue, 28 Oct 2014 07:37:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=xaopKYZdb6DFCBpnYMt+JsXDFYPP0mrd8ZUEYanh9U4=;
        b=b8l4zGGDrw4N1Du6+3HUwnTuO6wFvqudd84oLZiOqHhW6ZuS4OZIB5JC6sqqlhSUU+
         voKmoN7mOtGweNXqnmGx8sczAqUGnzwOgojEFTLcj2Iou0MIiSXEH/xpM0EiAlyyOK16
         Ne2BSZtfuwwwWhhdLnt1vODmwxdpcIVuAhG0S53ZcTpKA2FgjW+gdw4vQqFGpOGEOSHm
         sKSCLLD8qxEU5xrg0mHKIVG8DlyK3DjOx/oG+Cze9yVY6bTX5ShfPHzl4IRIJHnVhEbz
         /oblKqI/oe+jCmX0a2hlsoUs21wIAQutkm7db3RePFf3iY/rCnmAfsCuw42DMQcfO+yu
         SPew==
X-Gm-Message-State: ALoCoQmJLOyKzf5DRj4HMf005uRHESjRo7B7pK4oX+13yG6WQU4zQz513HD9M3EYmVaLqASbwGy6
MIME-Version: 1.0
X-Received: by 10.43.129.196 with SMTP id hj4mr4343341icc.21.1414507055449;
 Tue, 28 Oct 2014 07:37:35 -0700 (PDT)
Received: by 10.42.49.141 with HTTP; Tue, 28 Oct 2014 07:37:35 -0700 (PDT)
In-Reply-To: <CAHNKnsSj6gdZgc9JqWgskMB8v49t04g5B1TKC3TTnTgch4zNtA@mail.gmail.com>
References: <1411929195-23775-1-git-send-email-ryazanov.s.a@gmail.com>
        <1411929195-23775-11-git-send-email-ryazanov.s.a@gmail.com>
        <CACRpkdYWNjE1KS8GQo0fRrgT-Siwe7=SAOGQqBVqoW+Ypg-jAw@mail.gmail.com>
        <CAHNKnsSj6gdZgc9JqWgskMB8v49t04g5B1TKC3TTnTgch4zNtA@mail.gmail.com>
Date:   Tue, 28 Oct 2014 15:37:35 +0100
Message-ID: <CACRpkdZk9ZmoRELY8mT-6hbPkM3j9xPJzDFs1fyW17BxqxT0UQ@mail.gmail.com>
Subject: Re: [PATCH 10/16] gpio: add driver for Atheros AR2315 SoC GPIO controller
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43641
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
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

On Wed, Oct 15, 2014 at 1:12 PM, Sergey Ryazanov <ryazanov.s.a@gmail.com> wrote:
> 2014-10-15 12:58 GMT+04:00, Linus Walleij <linus.walleij@linaro.org>:
>> On Sun, Sep 28, 2014 at 8:33 PM, Sergey Ryazanov <ryazanov.s.a@gmail.com>

> I have one more generic question: could you merge driver without
> GPIOLIB_IRQCHIP usage?

No.

> Currently no one driver for the AR231x SoCs
> uses irq_domain and I do not like to enable IRQ_DOMAIN just for one
> driver. I plan to convert drivers to make them irq_domain aware a bit
> later.

I don't believe any such promises. It's nothing personal, just I've
been burned too many times by people promising to "fix later".

>>> +static u32 ar2315_gpio_intmask;
>>> +static u32 ar2315_gpio_intval;
>>> +static unsigned ar2315_gpio_irq_base;
>>> +static void __iomem *ar2315_mem;
>>
>> No static locals. Allocate and use a state container, see
>> Documentation/driver-model/design-patterns.txt
>>
> Is that rule mandatory for drivers, which serve only one device?

There is no central authority which decides what is mandatory
or not. It is mandatory to get a driver past the GPIO maintainer.

>>> +static inline u32 ar2315_gpio_reg_read(unsigned reg)
>>> +{
>>> +       return __raw_readl(ar2315_mem + reg);
>>> +}
>>
>> Use readl_relaxed() instead.
>>
> readl_relaxed() converts the bit ordering and seems inapplicable in this case.

It assumes the peripherals IO memory is little endian.

If the IO memory for this device is little endian, please stay with
[readl|writel]_relaxed so it looks familiar.

Or is this machine really using big endian hardware registers?
In that case I understand your comment...

>> When you use the state container, you need to do a
>> state dereference like that:
>>
>> mystate->base + reg
>>
>> So I don't think these inlines buy you anything. Just use
>> readl/writel_relaxed directly in the code.
>>
> These helpers make code shorter and clearer. I can use macros if you
> do preferred.

No big deal. Keep it if you like it this way.

>> So why is .set_type() not implemented and instead hard-coded into
>> the unmask function? Please fix this. It will be called by the
>> core eventually no matter what.
>>
> The interrupt configuration is a bit complex. This controller could be
> configured to generate interrupts only for two lines at once. Or in
> other words: user could select any two lines to generate interrupt.

Oh well, better just handle it I guess...

>>> +static int __init ar2315_gpio_init(void)
>>> +{
>>> +       return platform_driver_register(&ar2315_gpio_driver);
>>> +}
>>> +subsys_initcall(ar2315_gpio_init);
>>
>> Why are you using subsys_initcall()?
>>
>> This should not be necessary.
>>
> I have users of GPIO in arch code, what called earlier than the
> devices initcall.

OK? Why are there such users that early and what do they
use the GPIOs for? Any reason they cannot be device_initcall()s?

Yours,
Linus Walleij
