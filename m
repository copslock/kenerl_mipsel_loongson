Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Sep 2014 22:43:49 +0200 (CEST)
Received: from mail-yh0-f49.google.com ([209.85.213.49]:58864 "EHLO
        mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010021AbaI2UnrYOSYL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 Sep 2014 22:43:47 +0200
Received: by mail-yh0-f49.google.com with SMTP id z6so5104982yhz.36
        for <multiple recipients>; Mon, 29 Sep 2014 13:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=cTEpul2D2jxj6gvSPAU1psU+1zYUvLSdEnjtXx5wXKQ=;
        b=dIYQuFKMZ6h2hPvDpidu4bK5Ufa5KOEg5/2Ws4EBfUl9olPlQy+W7AslU0OMkuOcPg
         RPt6sPnbV9aNFwBSHJpyCQR7adfGLHLnUxhueeVch45px7P2aXF8rqXSmLlJbtIcigYS
         0VOegEDwh00Wl/QP7rX0A6SVDQCEVEPZ2H4toEZ0Dpg0CgyXhl5WGE8SSPIOkn0ue21e
         RnYQEUeRNXRFBuusuhaNi5sKyPcCxlxi2xNpa+QHKAfOWrgk9iUhxbUrx7hTo7Pvvs6e
         Kv9Ui8maKoTYlwEbkKkcLOye6vlSvMQLgmXDN0vUWFIZkC/2Y+exHtuFV0PDdZtJBnby
         oTjg==
X-Received: by 10.236.34.196 with SMTP id s44mr17253049yha.57.1412023421370;
 Mon, 29 Sep 2014 13:43:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.170.153.135 with HTTP; Mon, 29 Sep 2014 13:43:21 -0700 (PDT)
In-Reply-To: <CACRpkda3Cq+d47DMm018nAC7ThcHAOv-tOqEbNsUY1mOSnKyoA@mail.gmail.com>
References: <1410723213-22440-1-git-send-email-ryazanov.s.a@gmail.com>
 <1410723213-22440-10-git-send-email-ryazanov.s.a@gmail.com> <CACRpkda3Cq+d47DMm018nAC7ThcHAOv-tOqEbNsUY1mOSnKyoA@mail.gmail.com>
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
Date:   Tue, 30 Sep 2014 00:43:21 +0400
Message-ID: <CAHNKnsSj-=0aFHD574yRW9BpH1ONhy7K0NA8xri2ez6ab_MPMA@mail.gmail.com>
Subject: Re: [RFC 09/18] gpio: add driver for Atheros AR5312 SoC GPIO controller
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
X-archive-position: 42890
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

2014-09-29 13:18 GMT+04:00 Linus Walleij <linus.walleij@linaro.org>:
> On Sun, Sep 14, 2014 at 9:33 PM, Sergey Ryazanov <ryazanov.s.a@gmail.com> wrote:
>
>> Atheros AR5312 SoC have a builtin GPIO controller, which could be
>> accessed via memory mapped registers. This patch adds new driver
>> for them.
>>
>> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Alexandre Courbot <gnurou@gmail.com>
>> Cc: linux-gpio@vger.kernel.org
> (...)
>> -       /* Attempt to jump to the mips reset location - the boot loader
>> -        * itself might be able to recover the system */
>> +       /* Cold reset does not work on the AR2315/6, use the GPIO reset bits
>> +        * a workaround. Give it some time to attempt a gpio based hardware
>> +        * reset (atheros reference design workaround) */
>> +       gpio_request_one(AR2315_RESET_GPIO, GPIOF_OUT_INIT_LOW, "Reset");
>> +       mdelay(100);
>
> Please try to use the new GPIO descriptor API.
> See Documentation/gpio/consumer.txt
>
I will investigate this possibility.

> (...)
>> +++ b/drivers/gpio/gpio-ar2315.c
>
>> +static u32 ar2315_gpio_intmask;
>> +static u32 ar2315_gpio_intval;
>> +static unsigned ar2315_gpio_irq_base;
>> +static void __iomem *ar2315_mem;
>
> Get rid of these local variables and put them into an allocated
> state container, see
> Documentation/driver-model/design-patterns.txt
>
AR2315 SoC contains only one GPIO unit, so there are no reasons to
increase driver complexity. But if you insist, I will add state
container.

> Get rid of _gpio_irq_base altogether. (See comments below.)
>
> (...)
>> +static inline u32 ar2315_gpio_reg_read(unsigned reg)
>> +{
>> +       return __raw_readl(ar2315_mem + reg);
>> +}
>
> Use readl_relaxed()
>
>> +static inline void ar2315_gpio_reg_write(unsigned reg, u32 val)
>> +{
>> +       __raw_writel(val, ar2315_mem + reg);
>> +}
>
> Use writel_relaxed()
>
>> +static void ar2315_gpio_irq_handler(unsigned irq, struct irq_desc *desc)
>> +{
>> +       u32 pend;
>> +       int bit = -1;
>> +
>> +       /* only do one gpio interrupt at a time */
>> +       pend = ar2315_gpio_reg_read(AR2315_GPIO_DI);
>> +       pend ^= ar2315_gpio_intval;
>> +       pend &= ar2315_gpio_intmask;
>> +
>> +       if (pend) {
>> +               bit = fls(pend) - 1;
>> +               pend &= ~(1 << bit);
>
> Do this:
>
> #include <linux/bitops.h>
>
> pend &= ~BIT(bit);
>
>> +       ar2315_gpio_intmask |= (1 << gpio);
>
> |= BIT(gpio);
>
>> +       ar2315_gpio_int_setup(gpio, AR2315_GPIO_INT_TRIG_EDGE);
>> +}
>> +
>> +static void ar2315_gpio_irq_mask(struct irq_data *d)
>> +{
>> +       unsigned gpio = d->irq - ar2315_gpio_irq_base;
>
> Wait, no. No keeping irq bases around like that please.
>
> unsigned offset = d->hwirq;
>
> And call it offset rather than "gpio" everywhere please, since
> it is local to this GPIO controller, not the global GPIO numberspace.
>
Sure.

>> +       /* Disable interrupt */
>> +       ar2315_gpio_intmask &= ~(1 << gpio);
>
> &= ~BIT(gpio);
>
>> +static int ar2315_gpio_get_val(struct gpio_chip *chip, unsigned gpio)
>> +{
>> +       return (ar2315_gpio_reg_read(AR2315_GPIO_DI) >> gpio) & 1;
>> +}
>
> Do this:
> return !!(ar2315_gpio_reg_read(AR2315_GPIO_DI) & BIT(gpio));
>
Ok.

>> +static void ar2315_gpio_set_val(struct gpio_chip *chip, unsigned gpio, int val)
>> +{
>> +       u32 reg = ar2315_gpio_reg_read(AR2315_GPIO_DO);
>> +
>> +       reg = val ? reg | (1 << gpio) : reg & ~(1 << gpio);
>> +       ar2315_gpio_reg_write(AR2315_GPIO_DO, reg);
>
> Convoluted, I would use an if() else construct rather than the ? operator.
>
Convoluted, but 3 lines shorter :) And checkpatch has no objections.

>> +static int ar2315_gpio_to_irq(struct gpio_chip *chip, unsigned gpio)
>> +{
>> +       return ar2315_gpio_irq_base + gpio;
>> +}
>
> Don't implement this at all. You're using the gpiolib irqchip helpers!
> It will just overrun this implementation.
>
Seems that I missed some new gpiolib features. I will try to rewrite this.

Thank you for detailed review!

-- 
BR,
Sergey
