Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2014 22:09:13 +0100 (CET)
Received: from mail-yk0-f181.google.com ([209.85.160.181]:38987 "EHLO
        mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011726AbaJ1VJLv0oJm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Oct 2014 22:09:11 +0100
Received: by mail-yk0-f181.google.com with SMTP id 19so720897ykq.26
        for <multiple recipients>; Tue, 28 Oct 2014 14:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ttHbP7SxL/LC7HZkKSonmSR+ufEhbv6OBRXfJKrUyaA=;
        b=ySbEtzTa3J5sBYci5mU8Q8P+nrQZoOp/Ll6GB0COOD4cPZCC2S8kMPjZSh8T2kFo0l
         i03ForVNJQA8fTzs2yTkJU/v+Qj/gqsuxIXwnV+F+1pNYwyQcFWT9XCJmZSHFpoPlZOf
         0yVEZRvtoS98GAGtY1Sl3qGiqq/JwttS+MBiCBtvo9Hj2qoxEWMRcWqgQRF6OQTQ02lX
         5TXGhouydDF8gr/OeP1mIsRMb2NMO0I37X11/9HEfHmLhF2QaR9yMpAs94W6aWuh/heY
         6YC/mnp9X+DzGJERka0sMwbNoNoSrgz/AQ7jxg+M8XqHzmRv4fgIXz+xgZ4ZavHOkqdq
         8InQ==
X-Received: by 10.170.83.198 with SMTP id z189mr6594761ykz.70.1414530545567;
 Tue, 28 Oct 2014 14:09:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.170.153.196 with HTTP; Tue, 28 Oct 2014 14:08:45 -0700 (PDT)
In-Reply-To: <CACRpkdZk9ZmoRELY8mT-6hbPkM3j9xPJzDFs1fyW17BxqxT0UQ@mail.gmail.com>
References: <1411929195-23775-1-git-send-email-ryazanov.s.a@gmail.com>
 <1411929195-23775-11-git-send-email-ryazanov.s.a@gmail.com>
 <CACRpkdYWNjE1KS8GQo0fRrgT-Siwe7=SAOGQqBVqoW+Ypg-jAw@mail.gmail.com>
 <CAHNKnsSj6gdZgc9JqWgskMB8v49t04g5B1TKC3TTnTgch4zNtA@mail.gmail.com> <CACRpkdZk9ZmoRELY8mT-6hbPkM3j9xPJzDFs1fyW17BxqxT0UQ@mail.gmail.com>
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
Date:   Wed, 29 Oct 2014 00:08:45 +0300
Message-ID: <CAHNKnsRgH9tZ2T9JpVRGARarzSJAmwzyw6cF+VgR1XQ9UkKRuA@mail.gmail.com>
Subject: Re: [PATCH 10/16] gpio: add driver for Atheros AR2315 SoC GPIO controller
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43648
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
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

2014-10-28 17:37 GMT+03:00 Linus Walleij <linus.walleij@linaro.org>:
> On Wed, Oct 15, 2014 at 1:12 PM, Sergey Ryazanov <ryazanov.s.a@gmail.com> wrote:
>> 2014-10-15 12:58 GMT+04:00, Linus Walleij <linus.walleij@linaro.org>:
>>> On Sun, Sep 28, 2014 at 8:33 PM, Sergey Ryazanov <ryazanov.s.a@gmail.com>
>
>> I have one more generic question: could you merge driver without
>> GPIOLIB_IRQCHIP usage?
>
> No.
>
Ok.

>> Currently no one driver for the AR231x SoCs
>> uses irq_domain and I do not like to enable IRQ_DOMAIN just for one
>> driver. I plan to convert drivers to make them irq_domain aware a bit
>> later.
>
> I don't believe any such promises. It's nothing personal, just I've
> been burned too many times by people promising to "fix later".
>
Now I drop the driver from the series and return to the development a
bit later, when finished the basic code for the MIPS architecture. In
that case I will have a time to write the driver that does not require
further fixes.


>>>> +static u32 ar2315_gpio_intmask;
>>>> +static u32 ar2315_gpio_intval;
>>>> +static unsigned ar2315_gpio_irq_base;
>>>> +static void __iomem *ar2315_mem;
>>>
>>> No static locals. Allocate and use a state container, see
>>> Documentation/driver-model/design-patterns.txt
>>>
>> Is that rule mandatory for drivers, which serve only one device?
>
> There is no central authority which decides what is mandatory
> or not. It is mandatory to get a driver past the GPIO maintainer.
>
Nice point :)

>>>> +static inline u32 ar2315_gpio_reg_read(unsigned reg)
>>>> +{
>>>> +       return __raw_readl(ar2315_mem + reg);
>>>> +}
>>>
>>> Use readl_relaxed() instead.
>>>
>> readl_relaxed() converts the bit ordering and seems inapplicable in this case.
>
> It assumes the peripherals IO memory is little endian.
>
> If the IO memory for this device is little endian, please stay with
> [readl|writel]_relaxed so it looks familiar.
>
> Or is this machine really using big endian hardware registers?
> In that case I understand your comment...
>
Yes, AR5312 and AR2315 SoCs are big endian machines with big endian registers.


>>> When you use the state container, you need to do a
>>> state dereference like that:
>>>
>>> mystate->base + reg
>>>
>>> So I don't think these inlines buy you anything. Just use
>>> readl/writel_relaxed directly in the code.
>>>
>> These helpers make code shorter and clearer. I can use macros if you
>> do preferred.
>
> No big deal. Keep it if you like it this way.
>
>>> So why is .set_type() not implemented and instead hard-coded into
>>> the unmask function? Please fix this. It will be called by the
>>> core eventually no matter what.
>>>
>> The interrupt configuration is a bit complex. This controller could be
>> configured to generate interrupts only for two lines at once. Or in
>> other words: user could select any two lines to generate interrupt.
>
> Oh well, better just handle it I guess...
>
Will do in v2.

>>>> +static int __init ar2315_gpio_init(void)
>>>> +{
>>>> +       return platform_driver_register(&ar2315_gpio_driver);
>>>> +}
>>>> +subsys_initcall(ar2315_gpio_init);
>>>
>>> Why are you using subsys_initcall()?
>>>
>>> This should not be necessary.
>>>
>> I have users of GPIO in arch code, what called earlier than the
>> devices initcall.
>
> OK? Why are there such users that early and what do they
> use the GPIOs for? Any reason they cannot be device_initcall()s?
>
One GPIO line is used in reset handler to be able to reliably reset
the chip. This is a workaround from vendor's reference design to
eliminate a hw bug in the reset circuit of the AR2315 SoC. So I prefer
to have GPIO controller in ready state as soon as possible.

> Yours,
> Linus Walleij

-- 
BR,
Sergey
