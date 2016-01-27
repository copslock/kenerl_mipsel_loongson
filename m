Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2016 14:49:35 +0100 (CET)
Received: from mail-ob0-f170.google.com ([209.85.214.170]:34283 "EHLO
        mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011245AbcA0Ntck82jN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jan 2016 14:49:32 +0100
Received: by mail-ob0-f170.google.com with SMTP id vt7so7322175obb.1
        for <linux-mips@linux-mips.org>; Wed, 27 Jan 2016 05:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UoOYUPyy+RgtIrjZMZQsgQdLzD6SSUxWxo9FIJj5/vE=;
        b=VJ9ap0Ul1y3oYdl/+FDEuVuGEWPSS2iS+Vt+Pu/KGtnTw6PAeXI+f8OUHkWUtLZ1bW
         mDfZfSD4mFG8wEGN68amt6y063sXRp569SCbQ1Rb6FLzwzvUxSB8/zNZYt3ahkpQTija
         S9tpPVhlq6tMfu0ehLu0DRPVMxEgt03yB1Qic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=UoOYUPyy+RgtIrjZMZQsgQdLzD6SSUxWxo9FIJj5/vE=;
        b=XHHSIaxuGR0Psz+8tw4skZDglY7hI1mEypDJUeMt64MKaskGELKEh3OZCINmtP33AV
         VR6bpnSUkBt/+qUYycx/0YUc7KL9Ov4KoZkAg03RLvSAjhA7Wf379O+wy91pk6a8u0oi
         z4NHehXUmNpIR2UlT3XrCbay3Tst1vLFEhcigK4AV8fEVcmr47vdyLKitHduMF2YqyN5
         lMdPrThr/L0iCLPLGBC4FZPEhs93aHY9GJQdUuZNdynsAADPxpZZ3Q0BUSnkxv4s5df+
         JCvXdmbF3TZeI7Wi2H3i2i63WtQGVL77SoWp+BKVsHaQVnXXcV/gQZ5ydxGXtXNhwWRA
         RB5A==
X-Gm-Message-State: AG10YOS2OGLq1IHW5QU8nPbxrR7PkvSsLYpyej4OlVfWJl9Wl7RTtujID5jUf7qAr5wrdr312ua2SRjc5AAe8Wah
MIME-Version: 1.0
X-Received: by 10.60.177.67 with SMTP id co3mr22994473oec.62.1453902566620;
 Wed, 27 Jan 2016 05:49:26 -0800 (PST)
Received: by 10.182.55.105 with HTTP; Wed, 27 Jan 2016 05:49:26 -0800 (PST)
In-Reply-To: <1452734299-460-9-git-send-email-joshua.henderson@microchip.com>
References: <1452734299-460-1-git-send-email-joshua.henderson@microchip.com>
        <1452734299-460-9-git-send-email-joshua.henderson@microchip.com>
Date:   Wed, 27 Jan 2016 14:49:26 +0100
Message-ID: <CACRpkdaDC5LLcQx5_=vm=tjAV0z6RHvzgjzSFK6S+_1M7faMuA@mail.gmail.com>
Subject: Re: [PATCH v5 08/14] pinctrl: pinctrl-pic32: Add PIC32 pin control driver
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Joshua Henderson <joshua.henderson@microchip.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51478
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

On Thu, Jan 14, 2016 at 2:15 AM, Joshua Henderson
<joshua.henderson@microchip.com> wrote:

> Add a driver for the pin controller present on the Microchip PIC32
> including the specific variant PIC32MZDA. This driver provides pinmux
> and pinconfig operations as well as GPIO and IRQ chips for the GPIO
> banks.
>
> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> ---
> Changes since v4: None

Sorry for the delay. Fell between the cracks.

Overall this looks nice. Small things that need to be fixed below.

Is it possible to merge this patch separately into the pinctrl tree?

I was hoping there are no compile-time dependencies to the
MIPS tree so I can just merge this. Else I can provide some
kind of immutable branch to the MIPS maintainers.
(Having dangling symbols in Kconfig is OK with me if I know
they will come in from some other tree.)

> +#include <linux/clk.h>
> +#include <linux/gpio.h>

This include should not be needed, just the one below.

> +#include <linux/gpio/driver.h>
(...)
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/pinctrl/pinconf.h>
> +#include <linux/pinctrl/pinconf-generic.h>
> +#include <linux/pinctrl/pinctrl.h>
> +#include <linux/pinctrl/pinmux.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +
> +#include <asm/mach-pic32/pic32.h>

Oh this is how you do things still? Is this necessary? :/
Then I guess it has to be applied to the MIPS tree.

> +static inline u32 pctl_readl(struct pic32_pinctrl *pctl, u32 reg)
> +{
> +       return readl(pctl->reg_base + reg);
> +}
> +
> +static inline void pctl_writel(struct pic32_pinctrl *pctl, u32 val, u32 reg)
> +{
> +       writel(val, pctl->reg_base + reg);
> +}

This is a bit excess abstraction, I would just readl() and writel()
directly in the code, adding the offset. Butr it's you pick.

> +static inline struct pic32_gpio_bank *gc_to_bank(struct gpio_chip *gc)
> +{
> +       return container_of(gc, struct pic32_gpio_bank, gpio_chip);
> +}

Don't do this anymore.

Se all the "use gpiochip data pointer" patches I merged last
merge window.

Replace

= gc_to_bank(gc)
with
= gpiochip_get_data(gc);

everywhere and use

gpiochip_add_data(&gc, bank)

to make sure that gpipchip_get_data() returns what you want.

> +static inline struct pic32_gpio_bank *irqd_to_bank(struct irq_data *d)
> +{
> +       return gc_to_bank(irq_data_get_irq_chip_data(d));
> +}

For example this becomes:
return gpiochip_get_data(irq_data_get_irq_chip_data(d));

> +static inline u32 gpio_readl(struct pic32_gpio_bank *bank, u32 reg)
> +{
> +       return readl(bank->reg_base + reg);
> +}
> +
> +static inline void gpio_writel(struct pic32_gpio_bank *bank, u32 val,
> +                              u32 reg)
> +{
> +       writel(val, bank->reg_base + reg);
> +}

Again excessive abstraction IMO.

> +#define GPIO_BANK(_bank, _npins)                                       \
> +       {                                                               \
> +               .gpio_chip = {                                          \
> +                       .label = "GPIO" #_bank,                         \
> +                       .request = gpiochip_generic_request,            \
> +                       .free = gpiochip_generic_free,                  \
> +                       .get_direction = pic32_gpio_get_direction,      \
> +                       .direction_input = pic32_gpio_direction_input,  \
> +                       .direction_output = pic32_gpio_direction_output, \
> +                       .get = pic32_gpio_get,                          \
> +                       .set = pic32_gpio_set,                          \
> +                       .ngpio = _npins,                                \
> +                       .base = GPIO_BANK_START(_bank),                 \
> +                       .owner = THIS_MODULE,                           \
> +                       .can_sleep = 0,                                 \
> +               },                                                      \
> +               .irq_chip = {                                           \
> +                       .name = "GPIO" #_bank,                          \
> +                       .irq_startup = pic32_gpio_irq_startup,  \
> +                       .irq_ack = pic32_gpio_irq_ack,          \
> +                       .irq_mask = pic32_gpio_irq_mask,                \
> +                       .irq_unmask = pic32_gpio_irq_unmask,            \
> +                       .irq_set_type = pic32_gpio_irq_set_type,        \
> +               },                                                      \
> +       }
> +
> +static struct pic32_gpio_bank pic32_gpio_banks[] = {
> +       GPIO_BANK(0, PINS_PER_BANK),
> +       GPIO_BANK(1, PINS_PER_BANK),
> +       GPIO_BANK(2, PINS_PER_BANK),
> +       GPIO_BANK(3, PINS_PER_BANK),
> +       GPIO_BANK(4, PINS_PER_BANK),
> +       GPIO_BANK(5, PINS_PER_BANK),
> +       GPIO_BANK(6, PINS_PER_BANK),
> +       GPIO_BANK(7, PINS_PER_BANK),
> +       GPIO_BANK(8, PINS_PER_BANK),
> +       GPIO_BANK(9, PINS_PER_BANK),
> +};

Ewwwww.... I guess it's OK though. I would have made it with
some dynamic allocation and a for() loop in code.

> +       bank->gpio_chip.dev = &pdev->dev;

This is named .parent in the upstream kernel so you need to change it.

> +       bank->gpio_chip.of_node = np;
> +       ret = gpiochip_add(&bank->gpio_chip);

So use gpiochip_add_data()

Apart from this it looks pretty OK.

Yours,
Linus Walleij
