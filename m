Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jul 2015 22:52:28 +0200 (CEST)
Received: from mail-la0-f52.google.com ([209.85.215.52]:36192 "EHLO
        mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013331AbbGFUw0LD37M (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jul 2015 22:52:26 +0200
Received: by lagc2 with SMTP id c2so169518704lag.3
        for <linux-mips@linux-mips.org>; Mon, 06 Jul 2015 13:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=d5pDa7gJXJMLzyKTMtbNIzZ9/9k4z9Xjunf03QOV8Ts=;
        b=GgU84Q6btISrQbjPgJB0WnYe+2OryZP35F9Hx5J4KFMcjXbUtbtr0ZhZY0oAZ22fwW
         fKNqKzYRHX3mfJPzSIepFXP3s6dpvfPr9PHkSdF+/RqN7gzKnW9rTZ1BBVROVkx9wb1D
         5rg5QExeTfpH+5idkjmUUf6yCRNDhAy3i7z//ILLAcXY7xSN2oOzShaCEJx1DHb7sRkl
         piRB573cEBMTC90ap/jGb6LBL/nr+I3h56dSlwWqV2T2Iz1hjiQ8u4yJoJjYBfUcnhz0
         Lra0B1VcBwm4dg/m9AE8ENTQuy3h+UR3cK486g1QivPcIeTgqAnKV6TEe8+Tt3Cc/JHM
         meAA==
X-Gm-Message-State: ALoCoQk8eOQ/TtVoDjafWAQIjNWvtq7uWBYl16fFKXdLEfzoAW+u0bshVrwvxDUreWl70F0E2ryh
MIME-Version: 1.0
X-Received: by 10.112.122.98 with SMTP id lr2mr770932lbb.34.1436215940874;
 Mon, 06 Jul 2015 13:52:20 -0700 (PDT)
Received: by 10.25.21.87 with HTTP; Mon, 6 Jul 2015 13:52:20 -0700 (PDT)
In-Reply-To: <1435914709-15092-3-git-send-email-albeu@free.fr>
References: <1435914709-15092-1-git-send-email-albeu@free.fr>
        <1435914709-15092-3-git-send-email-albeu@free.fr>
Date:   Mon, 6 Jul 2015 22:52:20 +0200
Message-ID: <CACRpkdaxxjQa1pCCuUsPFHAs295mtKPLP5Vh+-VaZ=3o6idNMA@mail.gmail.com>
Subject: Re: [PATCH 2/2] MIPS: ath79: Move the GPIO driver to drivers/gpio
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Alban Bedel <albeu@free.fr>
Cc:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Gabor Juhos <juhosg@openwrt.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48090
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

On Fri, Jul 3, 2015 at 11:11 AM, Alban Bedel <albeu@free.fr> wrote:

> +++ b/drivers/gpio/gpio-ath79.c
> @@ -0,0 +1,236 @@
> +/*
> + *  Atheros AR71XX/AR724X/AR913X GPIO API support
> + *
> + *  Copyright (C) 2010-2011 Jaiganesh Narayanan <jnarayanan@atheros.com>
> + *  Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
> + *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
> + *
> + *  Parts of this file are based on Atheros' 2.6.15/2.6.31 BSP
> + *
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under the terms of the GNU General Public License version 2 as published
> + *  by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include <linux/spinlock.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
> +#include <linux/gpio.h>

Nominally only <linux/gpio/driver.h> should be enough for a driver.

> +#include <linux/platform_data/gpio-ath79.h>
> +#include <linux/of_device.h>
> +
> +#include <asm/mach-ath79/ar71xx_regs.h>
> +
> +static void __iomem *ath79_gpio_base;
> +static u32 ath79_gpio_count;
> +static DEFINE_SPINLOCK(ath79_gpio_lock);

Would prefer to use the state container design pattern from
Documentation/driver-model/design-patterns.txt

> +static void __ath79_gpio_set_value(unsigned gpio, int value)
> +{
> +       void __iomem *base = ath79_gpio_base;
> +
> +       if (value)
> +               __raw_writel(1 << gpio, base + AR71XX_GPIO_REG_SET);
> +       else
> +               __raw_writel(1 << gpio, base + AR71XX_GPIO_REG_CLEAR);

I have a vague memory of some semantics being strange in the MIPS
camp, but doesn't writel_relaxed() do what you want? (Benji brought
something related up for discussion on the ksummit list...)

> +static int __ath79_gpio_get_value(unsigned gpio)
> +{
> +       return (__raw_readl(ath79_gpio_base + AR71XX_GPIO_REG_IN) >> gpio) & 1;
> +}
> +
> +static int ath79_gpio_get_value(struct gpio_chip *chip, unsigned offset)
> +{
> +       return __ath79_gpio_get_value(offset);
> +}

Strange double functions that can be refactored out I think.
All internal uses should be able to reference the gpio_chip.

> +static void ath79_gpio_set_value(struct gpio_chip *chip,
> +                                 unsigned offset, int value)
> +{
> +       __ath79_gpio_set_value(offset, value);
> +}

Same.

> +       __raw_writel(__raw_readl(base + AR71XX_GPIO_REG_OE) | (1 << offset),
> +                    base + AR71XX_GPIO_REG_OE);

I tend to #include <linux/bitops.h>

And just | BIT(offset) there in the end.

Some prefer it like this, I just think the explit bitops look neat.

> +int gpio_get_value(unsigned gpio)
> +EXPORT_SYMBOL(gpio_get_value);
> +void gpio_set_value(unsigned gpio, int value)
> +EXPORT_SYMBOL(gpio_set_value);
> +int gpio_to_irq(unsigned gpio)
> +EXPORT_SYMBOL(gpio_to_irq);

These are some quite horrific overrides of the gpiolib functions.
I would like it rooted out and replaced with the gpiolib implementations.
I think we managed to exorcise this "generic GPIO" from ARM but
I'm honestly not certain.

> +int irq_to_gpio(unsigned irq)
> +{
> +       /* FIXME */
> +       return -EINVAL;
> +}
> +EXPORT_SYMBOL(irq_to_gpio);

Can't you just delete this? It has been removed from generic GPIO and
gpiolib because of ambiguity.

Yours,
Linus Walleij
