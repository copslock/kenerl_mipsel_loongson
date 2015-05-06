Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 May 2015 09:15:04 +0200 (CEST)
Received: from mail-ob0-f171.google.com ([209.85.214.171]:36501 "EHLO
        mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008868AbbEFHPCGtux5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 May 2015 09:15:02 +0200
Received: by obbkp3 with SMTP id kp3so809718obb.3
        for <linux-mips@linux-mips.org>; Wed, 06 May 2015 00:14:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=d/UHqkMlrc8gkk/4yCgILKwYkQM98uf7sW56SbD8ZyQ=;
        b=ZD6J742MpgacFJadQwHNnQJiizD/F351q4YIAROj5+8OkwjdivYL8+hYayRm5emIq5
         4QlZcOgXjHOIEtK1Yv/agrbuLocnNo8r9lIObgA5hw2vhFVV5EsZ3UyfmBHnxZtjs3j1
         qlm1QAvrvP14jJBZ+Ent/sI8EcaYtyIaJP46MoOdlHPheTGfayiwvDOZEuNp4IC4e4nH
         aY9uLUkQVVuzAOaGrIYI73dBeIDb6LRH3zhQX5Ke1kGQ3USefAnG/BUwF/uOa5kYhxSN
         MVopbWBxFldHOg+MC5by7tu/ke7g+zHmr+wLBgfYsFhyRTsvaOQ4Nitfn92Z7utI1IZK
         7qlQ==
X-Gm-Message-State: ALoCoQkVveDDadFSOiRKiJ6MC2a6IdAYP1SIWniF+schZqSECE/N5YlN0US7ZzEgfKhMqVJP7r6H
MIME-Version: 1.0
X-Received: by 10.182.128.234 with SMTP id nr10mr2706041obb.81.1430896498297;
 Wed, 06 May 2015 00:14:58 -0700 (PDT)
Received: by 10.182.204.41 with HTTP; Wed, 6 May 2015 00:14:58 -0700 (PDT)
In-Reply-To: <1430269982-24129-3-git-send-email-abrestic@chromium.org>
References: <1430269982-24129-1-git-send-email-abrestic@chromium.org>
        <1430269982-24129-3-git-send-email-abrestic@chromium.org>
Date:   Wed, 6 May 2015 09:14:58 +0200
Message-ID: <CACRpkdZXYcULynAVOU-K+8f2qnQkEFgzK2+Ku7xXzGQx0=uvBQ@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] pinctrl: Add Pistachio SoC pin control driver
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Andrew Bresticker <abrestic@chromium.org>
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
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47251
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

Hi Andrew and sorry for a slow review process, I've been
overloaded :(

On Wed, Apr 29, 2015 at 3:13 AM, Andrew Bresticker
<abrestic@chromium.org> wrote:

> Add a driver for the pin controller present on the IMG Pistachio SoC.
> This driver provides pinmux and pinconfig operations as well as GPIO
> and IRQ chips for the GPIO banks.
>
> Signed-off-by: Damien Horsley <Damien.Horsley@imgtec.com>
> Signed-off-by: Govindraj Raja <govindraj.raja@imgtec.com>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
> Signed-off-by: Kevin Cernekee <cernekee@chromium.org>
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> ---
> Changes from v3:
>  - Addressed review comments from Ezequiel.

Overall this is a very very nice looking driver so expect it to
be merged after addressing or answering my last few
concerns.

> +config PINCTRL_PISTACHIO
> +       def_bool y if MACH_PISTACHIO
> +       select PINMUX
> +       select GENERIC_PINCONF
> +       select GPIOLIB_IRQCHIP

I think you also need
depends on / select GPIOLIB
select OF_GPIO

x86_64 allmodconfig is usually the best way to test
if your GPIOs and pin control fragments are correctly Kconfig:ed.

> +#define PADS_DRIVE_STRENGTH_2MA                0x0
> +#define PADS_DRIVE_STRENGTH_4MA                0x1
> +#define PADS_DRIVE_STRENGTH_8MA                0x2
> +#define PADS_DRIVE_STRENGTH_12MA       0x3

Thanks for being clear on the defines and not using magic
values. This makes things so much easier for people
using and maintaining the driver!

> +#define GPIO_BANK(_bank, _pin_base, _npins)                            \
> +       {                                                               \
> +               .gpio_chip = {                                          \
> +                       .label = "GPIO" #_bank,                         \
> +                       .request = pistachio_gpio_request,              \
> +                       .free = pistachio_gpio_free,                    \
> +                       .get_direction = pistachio_gpio_get_direction,  \
> +                       .direction_input = pistachio_gpio_direction_input, \
> +                       .direction_output = pistachio_gpio_direction_output, \
> +                       .get = pistachio_gpio_get,                      \
> +                       .set = pistachio_gpio_set,                      \
> +                       .base = _pin_base,                              \
> +                       .ngpio = _npins,                                \
> +               },                                                      \
> +               .irq_chip = {                                           \
> +                       .name = "GPIO" #_bank,                          \
> +                       .irq_startup = pistachio_gpio_irq_startup,      \
> +                       .irq_ack = pistachio_gpio_irq_ack,              \
> +                       .irq_mask = pistachio_gpio_irq_mask,            \
> +                       .irq_unmask = pistachio_gpio_irq_unmask,        \
> +                       .irq_set_type = pistachio_gpio_irq_set_type,    \
> +               },                                                      \
> +               .gpio_range = {                                         \
> +                       .name = "GPIO" #_bank,                          \
> +                       .id = _bank,                                    \
> +                       .base = _pin_base,                              \
> +                       .pin_base = _pin_base,                          \
> +                       .npins = _npins,                                \
> +               },                                                      \
> +       }

This -gpio_range is the only thing that bothers me a little, combined with
this:

> +               bank->gpio_range.gc = &bank->gpio_chip;
> +               pinctrl_add_gpio_range(pctl->pctldev, &bank->gpio_range);

Because it adds the ranges from the pinctrl side instead of
doing it from the gpiochip side using
gpiochip_add_pin_range() or gpiochip_add_pingroup_range().

Have you tried using those (from <linux/gpio/driver.h> instead?

They have the upside that .base is taken from the gpio_chip
meaning it is unnecessary to define .base for the gpiochip
too and you can just go for what gpiolib dynamically assigns
for you.

> +               pinctrl_remove_gpio_range(pctl->pctldev, &bank->gpio_range);

And this will then be done automatically by gpiochio_remove().

> +static int __init pistachio_pinctrl_register(void)
> +{
> +       return platform_driver_register(&pistachio_pinctrl_driver);
> +}
> +arch_initcall(pistachio_pinctrl_register);

Is it necessary to have it registered so early?

Apart from these, as noted it looks very nice.

Yours,
Linus Walleij
