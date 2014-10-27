Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2014 17:36:14 +0100 (CET)
Received: from mail-ie0-f175.google.com ([209.85.223.175]:59913 "EHLO
        mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011405AbaJ0QgJuOiSa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Oct 2014 17:36:09 +0100
Received: by mail-ie0-f175.google.com with SMTP id at20so4766893iec.34
        for <linux-mips@linux-mips.org>; Mon, 27 Oct 2014 09:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=qz+3/viUSIgCglfWSTbCJhnxGxf7R0Nt7JYGAY0Bdak=;
        b=a3jy2nJ54BA6+PG0qcVVZcQtQ8pUTZ69F44g4+iDF+RgDnGLDQW/bYFALUdKG6Jh6F
         jrjsGkEST2Z0YqYW2rJtU5Kotr1kEpu/qB8xw2k9u+nw1PXaDQ5xiwdi0Y8e6ez3u1BK
         oaxigxvF5LW1SuzkyEcoRL7k5ukA0JJGKBG+0SA7mP0HVObzrSw8Kb8RxpKRlXsVAOEi
         nZgIxnBWgYVVbhkeNez9twgv259CJ9LJpv/burH8zjF3esvxlOZCjxVRzZDKv9+z40yJ
         arzcORBVzT1nE1zIGd7aSljgOPoLaAiz+q3wEgxh23/aGu/VJ3Un8ymKtsmqkouI2OPs
         YoIQ==
X-Gm-Message-State: ALoCoQnSvqdvZIIZ+UiKQnZpAkZ4meYAIxeweQMycjZJnVRZUwA1IU3peTB13eoVvXYMJuqtpm5J
MIME-Version: 1.0
X-Received: by 10.43.129.196 with SMTP id hj4mr2519339icc.21.1414427763649;
 Mon, 27 Oct 2014 09:36:03 -0700 (PDT)
Received: by 10.42.49.141 with HTTP; Mon, 27 Oct 2014 09:36:03 -0700 (PDT)
In-Reply-To: <1412885241-12476-2-git-send-email-blogic@openwrt.org>
References: <1412885241-12476-1-git-send-email-blogic@openwrt.org>
        <1412885241-12476-2-git-send-email-blogic@openwrt.org>
Date:   Mon, 27 Oct 2014 17:36:03 +0100
Message-ID: <CACRpkdb62hLJqAW2cP4jvDpn9M4j4zxypjSf2fOoNK+LwOHjtw@mail.gmail.com>
Subject: Re: [PATCH 2/2] GPIO: MIPS: ralink: add gpio driver for ralink SoC
From:   Linus Walleij <linus.walleij@linaro.org>
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43599
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

On Thu, Oct 9, 2014 at 10:07 PM, John Crispin <blogic@openwrt.org> wrote:

> Add gpio driver for Ralink SoC. This driver makes the gpio core on
> RT2880, RT305x, rt3352, rt3662, rt3883, rt5350 and mt7620 work.
>
> Signed-off-by: John Crispin <blogic@openwrt.org>
> Cc: linux-mips@linux-mips.org
> Cc: linux-gpio@vger.kernel.org

As mentioned I think this driver should register the GPIO to pin
range using gpiochip_add_pin_range() or
gpiochip_add_pingroup_range().

> +++ b/arch/mips/include/asm/mach-ralink/gpio.h
> @@ -0,0 +1,24 @@
> +/*
> + *  Ralink SoC GPIO API support
> + *
> + *  Copyright (C) 2008-2009 Gabor Juhos <juhosg@openwrt.org>
> + *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
> + *
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under the terms of the GNU General Public License version 2 as published
> + *  by the Free Software Foundation.
> + *
> + */
> +
> +#ifndef __ASM_MACH_RALINK_GPIO_H
> +#define __ASM_MACH_RALINK_GPIO_H
> +
> +#define ARCH_NR_GPIOS  128

The generic definition is 512, do you really need to
modify this?

> +#include <asm-generic/gpio.h>
> +
> +#define gpio_get_value __gpio_get_value
> +#define gpio_set_value __gpio_set_value
> +#define gpio_cansleep  __gpio_cansleep
> +#define gpio_to_irq    __gpio_to_irq
> +
> +#endif /* __ASM_MACH_RALINK_GPIO_H */

The rest is jus what you get without providing this file
at all, right?

> +++ b/drivers/gpio/gpio-rt2880.c
> @@ -0,0 +1,354 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation.
> + *
> + * Copyright (C) 2009-2011 Gabor Juhos <juhosg@openwrt.org>
> + * Copyright (C) 2013 John Crispin <blogic@openwrt.org>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/io.h>
> +#include <linux/gpio.h>
> +#include <linux/spinlock.h>
> +#include <linux/platform_device.h>
> +#include <linux/of_irq.h>
> +#include <linux/irqdomain.h>

If this is a cascaded GPIO chip (one accumulated IRQ line from all the
GPIO lines) you should instead select GPIOLIB_IRQCHIP
and follow the example of the drivers that use this.

> +enum ralink_gpio_reg {
> +       GPIO_REG_INT = 0,
> +       GPIO_REG_EDGE,
> +       GPIO_REG_RENA,
> +       GPIO_REG_FENA,
> +       GPIO_REG_DATA,
> +       GPIO_REG_DIR,
> +       GPIO_REG_POL,
> +       GPIO_REG_SET,
> +       GPIO_REG_RESET,
> +       GPIO_REG_TOGGLE,
> +       GPIO_REG_MAX
> +};

No that I see why this needs an enumerator and cannot just
be #defined, but whatdoIknow...

> +struct ralink_gpio_chip {
> +       struct gpio_chip chip;
> +       u8 regs[GPIO_REG_MAX];
> +
> +       spinlock_t lock;
> +       void __iomem *membase;
> +       struct irq_domain *domain;
> +       int irq;

Usually you don't need to keep the irq number around.

> +
> +       u32 rising;
> +       u32 falling;
> +};

Some of this could use some kerneldoc.

> +#define MAP_MAX        4
> +static struct irq_domain *irq_map[MAP_MAX];
> +static int irq_map_count;
> +static atomic_t irq_refcount = ATOMIC_INIT(0);

I don't get why you have a per-device state container and then
add these static locals for the irqdomains that seems unnecessary.
I prefer if all of it goes into the state container.

> +static int ralink_gpio_to_irq(struct gpio_chip *chip, unsigned pin)
> +{
> +       struct ralink_gpio_chip *rg = to_ralink_gpio(chip);
> +
> +       if (rg->irq < 1)
> +               return -1;
> +
> +       return irq_create_mapping(rg->domain, pin);
> +}

So this would rather use
irq_find_mapping(chip->irqdomain, pin);
with GPIOLIB_IRQCHIP selected.

> +static void ralink_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
> +{
> +       int i;
> +
> +       for (i = 0; i < irq_map_count; i++) {
> +               struct irq_domain *domain = irq_map[i];
> +               struct ralink_gpio_chip *rg;
> +               unsigned long pending;
> +               int bit;
> +
> +               rg = (struct ralink_gpio_chip *) domain->host_data;
> +               pending = rt_gpio_r32(rg, GPIO_REG_INT);
> +
> +               for_each_set_bit(bit, &pending, rg->chip.ngpio) {
> +                       u32 map = irq_find_mapping(domain, bit);
> +
> +                       generic_handle_irq(map);
> +                       rt_gpio_w32(rg, GPIO_REG_INT, BIT(bit));
> +               }
> +       }
> +}

Atleast set the driver state container in irq_get_handler_data() so you don't
need the static locals to find the maps.

If you use GPIOLIB_IRQCHIP you have the gpiochip in the handler datar,
and the irqdomain in the gpiochip.

> +static int gpio_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
> +{
> +       irq_set_chip_and_handler(irq, &ralink_gpio_irq_chip, handle_level_irq);
> +       irq_set_handler_data(irq, d);
> +
> +       return 0;
> +}
> +
> +static const struct irq_domain_ops irq_domain_ops = {
> +       .xlate = irq_domain_xlate_onecell,
> +       .map = gpio_map,
> +};
> +
> +static void ralink_gpio_irq_init(struct device_node *np,
> +                                struct ralink_gpio_chip *rg)
> +{
> +       if (irq_map_count >= MAP_MAX)
> +               return;
> +
> +       rg->irq = irq_of_parse_and_map(np, 0);
> +       if (!rg->irq)
> +               return;
> +
> +       rg->domain = irq_domain_add_linear(np, rg->chip.ngpio,
> +                                          &irq_domain_ops, rg);
> +       if (!rg->domain) {
> +               dev_err(rg->chip.dev, "irq_domain_add_linear failed\n");
> +               return;
> +       }
> +
> +       irq_map[irq_map_count++] = rg->domain;
> +
> +       rt_gpio_w32(rg, GPIO_REG_RENA, 0x0);
> +       rt_gpio_w32(rg, GPIO_REG_FENA, 0x0);
> +
> +       if (!atomic_read(&irq_refcount))
> +               irq_set_chained_handler(rg->irq, ralink_gpio_irq_handler);
> +       atomic_inc(&irq_refcount);
> +
> +       dev_info(rg->chip.dev, "registering %d irq handlers\n", rg->chip.ngpio);
> +}

Use GPIOLIB_IRQCHIP to centralize all this complex stuff.

> +       if (of_property_read_u8_array(np, "ralink,register-map",
> +                       rg->regs, GPIO_REG_MAX)) {
> +               dev_err(&pdev->dev, "failed to read register definition\n");
> +               return -EINVAL;
> +       }

Is this really wise? Isn't it better to encode the type of block
and then have these register maps statically in the driver here.

> +       ngpio = of_get_property(np, "ralink,num-gpios", NULL);
> +       if (!ngpio) {
> +               dev_err(&pdev->dev, "failed to read number of pins\n");
> +               return -EINVAL;
> +       }

Also the number of gpios would come from the version ID.

> +       gpiobase = of_get_property(np, "ralink,gpio-base", NULL);
> +       if (gpiobase)
> +               rg->chip.base = be32_to_cpu(*gpiobase);
> +       else
> +               rg->chip.base = -1;

Over my dead body. We want dynamic GPIO numbers.
Nobody will OK that DT binding anyway.

Just set this to -1 and be happy.

> +subsys_initcall(ralink_gpio_init);

Does it need to be this early, really?

Yours,
Linus Walleij
