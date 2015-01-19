Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2015 07:18:25 +0100 (CET)
Received: from mail-ie0-f174.google.com ([209.85.223.174]:53974 "EHLO
        mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011199AbbASGSW7CaMe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Jan 2015 07:18:22 +0100
Received: by mail-ie0-f174.google.com with SMTP id at20so29224422iec.5;
        Sun, 18 Jan 2015 22:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0VkCjs4s3LNgtoridFJDmrk3cqMuUhvZqJRcJqVe5BA=;
        b=0vkLDjd+rkUxQXCkz7upB9lo2oE2NGZi3pweViv8XF5U0Jild0twrT/xN23FJP26tl
         DoT101aR1sd+WQxvxlzbCljM0tjIkr+yKWIFUtR9tt9n1o+JVM82WMKfwCfzWboDky8C
         zTcReghLGdM/JEfWxv5JqMjz0t/c45gxGiBAGVbqkyPgLm5woD4F7yvKoACMhbgB3rMm
         4qFWCb92kK/ysht2BV4F+rj+P0MgePv9dL7fRkUPjGqztROamjGaILN7kFLj5RdSbG2z
         qv+7cIojsqt7HQXrseIZEcnnKPqkvAB0yNW/6tXg4NhyiK5vqQPhN4mhUbRCeyCckMcL
         FiRg==
X-Received: by 10.107.41.143 with SMTP id p137mr12759774iop.61.1421648296900;
 Sun, 18 Jan 2015 22:18:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.139.99 with HTTP; Sun, 18 Jan 2015 22:17:56 -0800 (PST)
In-Reply-To: <1419742654-15094-1-git-send-email-chenhc@lemote.com>
References: <1419742654-15094-1-git-send-email-chenhc@lemote.com>
From:   Alexandre Courbot <gnurou@gmail.com>
Date:   Mon, 19 Jan 2015 15:17:56 +0900
Message-ID: <CAAVeFu+-m98_O1poRaxurDiUFkFu6t93On4ZM6xMWVW0-3Uvzw@mail.gmail.com>
Subject: Re: [PATCH V6 3/8] MIPS: Cleanup Loongson-2F's gpio driver
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <gnurou@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45291
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gnurou@gmail.com
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

On Sun, Dec 28, 2014 at 1:57 PM, Huacai Chen <chenhc@lemote.com> wrote:
> This cleanup is prepare to move the driver to drivers/gpio. Custom
> definitions of gpio_get_value()/gpio_set_value() are dropped.
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/mips/include/asm/mach-loongson/gpio.h |   15 +++---
>  arch/mips/loongson/common/gpio.c           |   82 +++++++++++-----------------
>  2 files changed, 39 insertions(+), 58 deletions(-)
>
> diff --git a/arch/mips/include/asm/mach-loongson/gpio.h b/arch/mips/include/asm/mach-loongson/gpio.h
> index 211a7b7..b3b2169 100644
> --- a/arch/mips/include/asm/mach-loongson/gpio.h
> +++ b/arch/mips/include/asm/mach-loongson/gpio.h
> @@ -1,8 +1,9 @@
>  /*
> - * STLS2F GPIO Support
> + * Loongson GPIO Support
>   *
>   * Copyright (c) 2008  Richard Liu, STMicroelectronics <richard.liu@st.com>
>   * Copyright (c) 2008-2010  Arnaud Patard <apatard@mandriva.com>
> + * Copyright (c) 2014  Huacai Chen <chenhc@lemote.com>
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
> @@ -10,14 +11,14 @@
>   * (at your option) any later version.
>   */
>
> -#ifndef __STLS2F_GPIO_H
> -#define __STLS2F_GPIO_H
> +#ifndef __LOONGSON_GPIO_H
> +#define __LOONGSON_GPIO_H
>
>  #include <asm-generic/gpio.h>
>
> -extern void gpio_set_value(unsigned gpio, int value);
> -extern int gpio_get_value(unsigned gpio);
> -extern int gpio_cansleep(unsigned gpio);
> +#define gpio_get_value __gpio_get_value
> +#define gpio_set_value __gpio_set_value
> +#define gpio_cansleep __gpio_cansleep
>
>  /* The chip can do interrupt
>   * but it has not been tested and doc not clear
> @@ -32,4 +33,4 @@ static inline int irq_to_gpio(int gpio)
>         return -EINVAL;
>  }
>
> -#endif                         /* __STLS2F_GPIO_H */
> +#endif /* __LOONGSON_GPIO_H */
> diff --git a/arch/mips/loongson/common/gpio.c b/arch/mips/loongson/common/gpio.c
> index 29dbaa2..087aac3 100644
> --- a/arch/mips/loongson/common/gpio.c
> +++ b/arch/mips/loongson/common/gpio.c
> @@ -24,55 +24,6 @@
>
>  static DEFINE_SPINLOCK(gpio_lock);
>
> -int gpio_get_value(unsigned gpio)
> -{
> -       u32 val;
> -       u32 mask;
> -
> -       if (gpio >= STLS2F_N_GPIO)
> -               return __gpio_get_value(gpio);
> -
> -       mask = 1 << (gpio + STLS2F_GPIO_IN_OFFSET);
> -       spin_lock(&gpio_lock);
> -       val = LOONGSON_GPIODATA;
> -       spin_unlock(&gpio_lock);
> -
> -       return (val & mask) != 0;
> -}
> -EXPORT_SYMBOL(gpio_get_value);
> -
> -void gpio_set_value(unsigned gpio, int state)
> -{
> -       u32 val;
> -       u32 mask;
> -
> -       if (gpio >= STLS2F_N_GPIO) {
> -               __gpio_set_value(gpio, state);
> -               return ;
> -       }
> -
> -       mask = 1 << gpio;
> -
> -       spin_lock(&gpio_lock);
> -       val = LOONGSON_GPIODATA;
> -       if (state)
> -               val |= mask;
> -       else
> -               val &= (~mask);
> -       LOONGSON_GPIODATA = val;
> -       spin_unlock(&gpio_lock);
> -}
> -EXPORT_SYMBOL(gpio_set_value);
> -
> -int gpio_cansleep(unsigned gpio)
> -{
> -       if (gpio < STLS2F_N_GPIO)
> -               return 0;
> -       else
> -               return __gpio_cansleep(gpio);
> -}
> -EXPORT_SYMBOL(gpio_cansleep);
> -
>  static int ls2f_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
>  {
>         u32 temp;
> @@ -113,13 +64,41 @@ static int ls2f_gpio_direction_output(struct gpio_chip *chip,
>
>  static int ls2f_gpio_get_value(struct gpio_chip *chip, unsigned gpio)
>  {
> -       return gpio_get_value(gpio);
> +       u32 val;
> +       u32 mask;
> +
> +       if (gpio >= STLS2F_N_GPIO)
> +               return __gpio_get_value(gpio);
> +
> +       mask = 1 << (gpio + STLS2F_GPIO_IN_OFFSET);
> +       spin_lock(&gpio_lock);
> +       val = LOONGSON_GPIODATA;
> +       spin_unlock(&gpio_lock);

Careful, you are not anymore dealing with absolute GPIO numbers like
your former custom gpio_get_value() function did.

This function will be called by the gpiolib core after it has matched
the GPIO to your chip. So testing for gpio >= STLS2F_N_GPIO is not
needed.

Furthermore, the passed GPIO number will be relative to the chip's
base index. In your case it seems like the base is 0, so this doesn't
change anything, but be aware of this fact.

> +
> +       return (val & mask) != 0;
>  }
>
>  static void ls2f_gpio_set_value(struct gpio_chip *chip,
>                 unsigned gpio, int value)
>  {
> -       gpio_set_value(gpio, value);
> +       u32 val;
> +       u32 mask;
> +
> +       if (gpio >= STLS2F_N_GPIO) {
> +               __gpio_set_value(gpio, value);
> +               return;
> +       }
> +
> +       mask = 1 << gpio;
> +
> +       spin_lock(&gpio_lock);
> +       val = LOONGSON_GPIODATA;
> +       if (value)
> +               val |= mask;
> +       else
> +               val &= (~mask);
> +       LOONGSON_GPIODATA = val;

Same thing here.

Since this is a potentially dangerous refactoring of this driver, I'd
like a statement that confirms it is still working properly after
patches 3, 4, and 5 of this series. IOW, please test your driver after
each of these patches to ensure the refactoring is done properly.
