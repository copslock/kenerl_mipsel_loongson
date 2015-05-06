Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 May 2015 20:45:09 +0200 (CEST)
Received: from mail-qg0-f54.google.com ([209.85.192.54]:34218 "EHLO
        mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012596AbbEFSpHZcsU1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 May 2015 20:45:07 +0200
Received: by qgfi89 with SMTP id i89so9388031qgf.1
        for <linux-mips@linux-mips.org>; Wed, 06 May 2015 11:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=qU54B62Grq0YWwYUebvfEOdlX4y5Xr7i+jS87Ds/R+0=;
        b=LEvkwFz2o5vKxHAZJTxRiX1lx9E/v7Bcag5WL/tgaVzdK+xcyuSoYl9Wke1Tw5hI3D
         YoUKRB8Q5Grrt9N9UOeFk+O8dIVJeksj+R3nK07MSc1YK2fG0SYqwL+C+smQmTLmEaaE
         11TMeqxqZGVG9HzmyK5wcJ/feUKV4cFLOX6ASzxFEGTRUAJyVZgzt3RhbWspaqWrEGYr
         XsevThiVFbhl/bFoHUUTOWZtMLDXYj/fmpAbTD8VWpSFY7HM/qcFQymtAnFk7b+6l6c2
         OsjwTuemefgrUFTJN3D2UgXwEO2DBIJDmCWt+AHHuW1P+FEyqBdQ9a00u2xoqyLJX0SS
         k5cQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=qU54B62Grq0YWwYUebvfEOdlX4y5Xr7i+jS87Ds/R+0=;
        b=K103M5AaW8O4uhwTOmDLO8sC2cbE355bmzPZKUMrEoNJ8Fn7DoIPG+S794JxVXBqeH
         wSFynOPisFxCCcQyhPDP7R8wQ9jz/mJ2TIq1SEIWq+TtHfWOB+K2CaS70p+G98ijlzjR
         utcM0U+DctuBs/g8WQz9Ht01XuomK6oaTwIP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=qU54B62Grq0YWwYUebvfEOdlX4y5Xr7i+jS87Ds/R+0=;
        b=RjS/iUF1LSih5cRcXftSjEZNynP2U1nsYZJXVlYiWGgQ0byRC5ZrcwqyPG4o9oydux
         xj3HA82GOj6oxh/GjRJW5FPSbX6nzxofD83TPPYTPBso7/HS4tOzgQoLrfw7xa9xFgb+
         MK8b5NL23FmS1q1HxfdIwm4PVLu5QOwj1wqvfWtP0GsF4iIBeSzBQL8NFRTnDbmiib4o
         pQYHXIA8RknOyEKJI7iovShBPR2khRk4YIyh73u+m4Xxxsny4f5pumMYkfSDTuVwk4ul
         AKE+E1nN0YBWPTMN+Rmma+5JwdgTEb9K2+yaPaoM1Yj8YZVE9hL/1V+VBry/FckhvVFu
         9fjA==
X-Gm-Message-State: ALoCoQnd7RhcZPKzSxBDVYhJXHy6eo2L3rGrSnqKZASuzsb7BaBio//I8wjEB3CFbCEU4/0ebqYz
MIME-Version: 1.0
X-Received: by 10.55.56.8 with SMTP id f8mr164883qka.97.1430937903618; Wed, 06
 May 2015 11:45:03 -0700 (PDT)
Received: by 10.140.23.72 with HTTP; Wed, 6 May 2015 11:45:03 -0700 (PDT)
In-Reply-To: <CACRpkdZXYcULynAVOU-K+8f2qnQkEFgzK2+Ku7xXzGQx0=uvBQ@mail.gmail.com>
References: <1430269982-24129-1-git-send-email-abrestic@chromium.org>
        <1430269982-24129-3-git-send-email-abrestic@chromium.org>
        <CACRpkdZXYcULynAVOU-K+8f2qnQkEFgzK2+Ku7xXzGQx0=uvBQ@mail.gmail.com>
Date:   Wed, 6 May 2015 11:45:03 -0700
X-Google-Sender-Auth: RVKcLUbajUp5Vw_fCMdavAEqv6k
Message-ID: <CAL1qeaF9ykWLpmXBe7EhVcUGpUSaqMqj-ckTef=6Ng=t+pBOGQ@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] pinctrl: Add Pistachio SoC pin control driver
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        Govindraj Raja <govindraj.raja@imgtec.com>,
        Kevin Cernekee <cernekee@chromium.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47260
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

Hi Linus,

On Wed, May 6, 2015 at 12:14 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> Hi Andrew and sorry for a slow review process, I've been
> overloaded :(
>
> On Wed, Apr 29, 2015 at 3:13 AM, Andrew Bresticker
> <abrestic@chromium.org> wrote:
>
>> Add a driver for the pin controller present on the IMG Pistachio SoC.
>> This driver provides pinmux and pinconfig operations as well as GPIO
>> and IRQ chips for the GPIO banks.
>>
>> Signed-off-by: Damien Horsley <Damien.Horsley@imgtec.com>
>> Signed-off-by: Govindraj Raja <govindraj.raja@imgtec.com>
>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
>> Signed-off-by: Kevin Cernekee <cernekee@chromium.org>
>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> ---
>> Changes from v3:
>>  - Addressed review comments from Ezequiel.
>
> Overall this is a very very nice looking driver so expect it to
> be merged after addressing or answering my last few
> concerns.
>
>> +config PINCTRL_PISTACHIO
>> +       def_bool y if MACH_PISTACHIO
>> +       select PINMUX
>> +       select GENERIC_PINCONF
>> +       select GPIOLIB_IRQCHIP
>
> I think you also need
> depends on / select GPIOLIB
> select OF_GPIO
>
> x86_64 allmodconfig is usually the best way to test
> if your GPIOs and pin control fragments are correctly Kconfig:ed.

Right, will fix.

>> +#define GPIO_BANK(_bank, _pin_base, _npins)                            \
>> +       {                                                               \
>> +               .gpio_chip = {                                          \
>> +                       .label = "GPIO" #_bank,                         \
>> +                       .request = pistachio_gpio_request,              \
>> +                       .free = pistachio_gpio_free,                    \
>> +                       .get_direction = pistachio_gpio_get_direction,  \
>> +                       .direction_input = pistachio_gpio_direction_input, \
>> +                       .direction_output = pistachio_gpio_direction_output, \
>> +                       .get = pistachio_gpio_get,                      \
>> +                       .set = pistachio_gpio_set,                      \
>> +                       .base = _pin_base,                              \
>> +                       .ngpio = _npins,                                \
>> +               },                                                      \
>> +               .irq_chip = {                                           \
>> +                       .name = "GPIO" #_bank,                          \
>> +                       .irq_startup = pistachio_gpio_irq_startup,      \
>> +                       .irq_ack = pistachio_gpio_irq_ack,              \
>> +                       .irq_mask = pistachio_gpio_irq_mask,            \
>> +                       .irq_unmask = pistachio_gpio_irq_unmask,        \
>> +                       .irq_set_type = pistachio_gpio_irq_set_type,    \
>> +               },                                                      \
>> +               .gpio_range = {                                         \
>> +                       .name = "GPIO" #_bank,                          \
>> +                       .id = _bank,                                    \
>> +                       .base = _pin_base,                              \
>> +                       .pin_base = _pin_base,                          \
>> +                       .npins = _npins,                                \
>> +               },                                                      \
>> +       }
>
> This -gpio_range is the only thing that bothers me a little, combined with
> this:
>
>> +               bank->gpio_range.gc = &bank->gpio_chip;
>> +               pinctrl_add_gpio_range(pctl->pctldev, &bank->gpio_range);
>
> Because it adds the ranges from the pinctrl side instead of
> doing it from the gpiochip side using
> gpiochip_add_pin_range() or gpiochip_add_pingroup_range().
>
> Have you tried using those (from <linux/gpio/driver.h> instead?
>
> They have the upside that .base is taken from the gpio_chip
> meaning it is unnecessary to define .base for the gpiochip
> too and you can just go for what gpiolib dynamically assigns
> for you.

Yup, switching to gpiochip_add_pin_range() works just fine here.

>> +static int __init pistachio_pinctrl_register(void)
>> +{
>> +       return platform_driver_register(&pistachio_pinctrl_driver);
>> +}
>> +arch_initcall(pistachio_pinctrl_register);
>
> Is it necessary to have it registered so early?

No, nothing depends on it being initialized this early.  When I was
asked to remove the module stuff, I just picked arch_initcall since
that's what most other pinctrl drivers not using
module_platform_driver() use.  It also has the benefit of reducing the
number of probe deferrals.

Thanks,
Andrew
