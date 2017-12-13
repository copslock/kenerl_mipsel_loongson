Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Dec 2017 09:15:35 +0100 (CET)
Received: from mail-io0-x243.google.com ([IPv6:2607:f8b0:4001:c06::243]:45895
        "EHLO mail-io0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992396AbdLMIP1MbRjA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Dec 2017 09:15:27 +0100
Received: by mail-io0-x243.google.com with SMTP id e204so1943460iof.12
        for <linux-mips@linux-mips.org>; Wed, 13 Dec 2017 00:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=THrNlQy1vBJr3L+SpDVFRhseTP8Sc5CihI7e7qUau4A=;
        b=XUdWtlIuySYF+5IEtSBOx3251OHCmS80Duxv36YvL7Dpl5TBv4vPMJxEGaJZgd+cgb
         S0sN/WaYTsgKlyLw2ebMvSWFi8LAidlNZciIz7+dTDpRVImvZ1MPJd9uRypW6vPTHTCt
         6okt8sJNh4ZQaG9ix7Up/j75dV77mPMGtLorc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=THrNlQy1vBJr3L+SpDVFRhseTP8Sc5CihI7e7qUau4A=;
        b=Ka6mPQtuTxLgZ/StuVEwT8sjO6iWvYqY2U36wYvJWwJDWxFp2Z0oMnmYfuhPOtcD1m
         h2hBI/XhHNRbJlJicpnOKTNk7sidSPCm6/FLFGJvB5ZvpabIBFJ649T0ckb2x5F+tjlR
         r65oyG/hns8ExFSvAFqjYis7RPoZonHGwq30OCkoKgi/c8dsUkqIDhX6qt+fKIK/GkP1
         QNRHtJcGQmvxryMJHARpfeZG4jiXpa36i9HCXKitBXET5tFggl9CHoh1ZQJNa3xSOPzM
         +xlpgptd/PnaZhtDYl/CQxmw3XrilUB4oID4AwufgjwclMXFngW1GGTyHTFv1O8WHuKz
         MD5g==
X-Gm-Message-State: AKGB3mJN538b+S3WB35zDaNZVp4Qr6GEgvT6nZnSuh3hzB6AaGBr36eo
        5MIBTrS7iqBxRnzValL4B7xJ3zAsRjhLSIxFVq4q4Q==
X-Google-Smtp-Source: ACJfBou16gNihr7msaRsLLzt9IuVEHxmohnPwqNXQSIYvLTfLOz+oQQ5WBECSN+gznDiKE0YWd5eealFzRyqOe7pyz4=
X-Received: by 10.107.143.75 with SMTP id r72mr1831099iod.95.1513152920578;
 Wed, 13 Dec 2017 00:15:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.87.84 with HTTP; Wed, 13 Dec 2017 00:15:20 -0800 (PST)
In-Reply-To: <20171208154618.20105-6-alexandre.belloni@free-electrons.com>
References: <20171208154618.20105-1-alexandre.belloni@free-electrons.com> <20171208154618.20105-6-alexandre.belloni@free-electrons.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Dec 2017 09:15:20 +0100
Message-ID: <CACRpkdZ=+pFZYteq=wM=z-CGejY+dX_SqhtDbbGBn+q60arQ4w@mail.gmail.com>
Subject: Re: [PATCH v2 05/13] pinctrl: Add Microsemi Ocelot SoC driver
To:     Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61463
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

On Fri, Dec 8, 2017 at 4:46 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:

> The Microsemi Ocelot SoC has a few pins that can be used as GPIOs or take
> multiple other functions. Add a driver for the pinmuxing and the GPIOs.
>
> There is currently no support for interrupts.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-gpio@vger.kernel.org
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

This looks very good. Nice work!

I was close to just applying it but found some very minor things.
When you resend this just send this patch and I can apply it directly
since there are only Kconfig symbol dependencies and no
compile-time dependencies in this patch.

> +config PINCTRL_OCELOT
> +       bool "Pinctrl driver for the Microsemi Ocelot SoCs"
> +       default y
> +       depends on OF
> +       depends on MSCC_OCELOT || COMPILE_TEST
> +       select GENERIC_PINCONF
> +       select GENERIC_PINCTRL_GROUPS
> +       select GENERIC_PINMUX_FUNCTIONS
> +       select REGMAP_MMIO

select GPIOLIB

When you run COMPILE_TEST you don't know if you have
GPIOLIB so select it.

> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)

Wow never saw that before. OK I guess.

> +#include <linux/compiler.h>
> +#include <linux/gpio.h>

Just:
#include <linux/gpio/driver.h>

<linux/gpio.h> is a legacy include and should not be used.

> +static int ocelot_pinmux_set_mux(struct pinctrl_dev *pctldev,
> +                                unsigned int selector, unsigned int group)
> +{
> +       struct ocelot_pinctrl *info = pinctrl_dev_get_drvdata(pctldev);
> +       struct ocelot_pin_caps *pin = ocelot_pins[group].drv_data;
> +       int f;
> +
> +       f = ocelot_pin_function_idx(group, selector);
> +       if (f < 0)
> +               return -EINVAL;
> +
> +       regmap_update_bits(info->map, OCELOT_GPIO_ALT0, BIT(pin->pin),
> +                          f << pin->pin);
> +       regmap_update_bits(info->map, OCELOT_GPIO_ALT1, BIT(pin->pin),
> +                          f << (pin->pin - 1));

You need to add some comment on what is happening here and how the
bits are used because just reading these two lines is pretty hard.

I guess f = 0, 1, 2 .... 31 or so.

pin->pin is also 0, 1, 2 ... 31?

BIT(pin->pin) is pretty self-evident. It is masking the bit controlling
this pin in each register.

But setting bits (f << (pin->pin)) and then in the other register
(f << (pin->pin -1))?

Maybe you should even add an illustrative dev_dbg() print here
showing which bits you mask and set, or use some helper bools
so it is crystal clear what is going on.

So there is two registers to select "alternative functions" (I guess?)
And each has one bit for the *same* pin.

This is the case also in drivers/pinctrl/nomadik/pinctrl-nomadik.c.
It turns out to be a pretty horrible design decision: since the two
bits are not changed in the same register transaction, switching
from say function "00" to function "11" creates a "glitch" where
you first activate funcion "10" after writing the first register,
then finally go to function "11" after writing the second.

This had horrible electrical consequences and required special
workarounds in Nomadik so be on the lookout for this type
of problem.

> +static int ocelot_gpio_set_direction(struct pinctrl_dev *pctldev,
> +                                    struct pinctrl_gpio_range *range,
> +                                    unsigned int pin, bool input)
> +{
> +       struct ocelot_pinctrl *info = pinctrl_dev_get_drvdata(pctldev);
> +
> +       regmap_update_bits(info->map, OCELOT_GPIO_OE, BIT(pin),
> +                          input ? BIT(pin) : 0);
> +
> +       return 0;
> +}
(...)
> +static const struct pinmux_ops ocelot_pmx_ops = {
> +       .get_functions_count = ocelot_get_functions_count,
> +       .get_function_name = ocelot_get_function_name,
> +       .get_function_groups = ocelot_get_function_groups,
> +       .set_mux = ocelot_pinmux_set_mux,
> +       .gpio_set_direction = ocelot_gpio_set_direction,
> +       .gpio_request_enable = ocelot_gpio_request_enable,
> +};

This looks a bit weird since the same register is also written
by the gpiochip to set direction.

If you want to relay the direction setting entirely to the pin
control subsystem, then just have your callbacks in the
gpiochip like this:

static int ocelot_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
{
        return pinctrl_gpio_direction_input(chip->base + offset);
}

static int ocelot_gpio_direction_output(struct gpio_chip *chip, unsigned offset,
                                       int value)
{
       struct ocelot_pinctrl *info = gpiochip_get_data(chip);
       unsigned int pin = BIT(offset);

       if (value)
               regmap_write(info->map, OCELOT_GPIO_OUT_SET, pin);
       else
               regmap_write(info->map, OCELOT_GPIO_OUT_CLR, pin);

        return pinctrl_gpio_direction_output(chip->base + offset);
}

Then all direction setting will just be relayed to the pin control
side.

Shouldn't this call also set up the altfunction so you know
the pin is now set in GPIO mode? That is how some other
drivers do it at least. But maybe you prefer to do the
muxing "on the side" (using pinmux ops only, and explicitly
setting up the line as GPIO in e.g. the device tree)?

In that case I think you might not need this callback at all.

Also: are you should you do not need to disable OCELOT_GPIO_OE
in the .gpio_disable_free() callback?

> +static const struct pinctrl_ops ocelot_pctl_ops = {
> +       .get_groups_count = ocelot_pctl_get_groups_count,
> +       .get_group_name = ocelot_pctl_get_group_name,
> +       .get_group_pins = ocelot_pctl_get_group_pins,
> +       .dt_node_to_map = pinconf_generic_dt_node_to_map_pin,
> +       .dt_free_map = pinconf_generic_dt_free_map,
> +};

Nice use of the generic parsers, thanks!

> +       ret = devm_gpiochip_add_data(&pdev->dev, gc, info);
> +       if (ret)
> +               return ret;
> +       //TODO irqchip

/* Please use oldschool comments for now, the license on the top is
fine though */

> +static const struct regmap_config ocelot_pinctrl_regmap_config = {
> +       .reg_bits = 32,
> +       .val_bits = 32,
> +       .reg_stride = 4,
> +};

Looks like it could have some more limitations (like max register
and so on) but it's OK.

> +       base = devm_ioremap_resource(dev,
> +                       platform_get_resource(pdev, IORESOURCE_MEM, 0));
> +       if (IS_ERR(base)) {
> +               dev_err(dev, "Failed to ioremap registers\n");
> +               return PTR_ERR(base);
> +       }
> +
> +       info->map = devm_regmap_init_mmio(dev, base,
> +                                         &ocelot_pinctrl_regmap_config);
> +       if (IS_ERR(info->map)) {
> +               dev_err(dev, "Failed to create regmap\n");
> +               return PTR_ERR(info->map);
> +       }

Nice use of regmap MMIO!

Yours,
Linus Walleij
