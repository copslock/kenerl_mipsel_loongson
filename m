Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2014 06:41:58 +0200 (CEST)
Received: from mail-ig0-f174.google.com ([209.85.213.174]:61478 "EHLO
        mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011847AbaJTEl42FNY8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2014 06:41:56 +0200
Received: by mail-ig0-f174.google.com with SMTP id a13so4628949igq.13
        for <multiple recipients>; Sun, 19 Oct 2014 21:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=uGWpSb5jlL+2Y+oPa3Wo+pFchvv20GatdOrPYp+S2b0=;
        b=VUc53egiWJeuqtEVeDjzqomYcMXvWR2d+06GMtfnJnhjS2e7sPIWJmSy7sBoqw6kCF
         Gw2aDCfRBVqtBLdhs1C0lBYRoGo29cg4oc2BGmNYYEph5/C7/nyn9ltiDiHG9EMl9eFY
         mynbBA4zRfPKeM5a8X+a8m5e5jF64QbSBPF3KunOHkR3SaqRpRWoSI4PvTvbu+3YXUj6
         +Wq6llJbxZi9XK90I78EKnzV/hFr2rKjpxMllZNr7oYhMgZFBZxAQ7SN2UdB46qeotGj
         WMQcKrshuDwqhFpCTBSRMiJVqEC+OB5MdvLtEzdHIKl6ILopH0YDarEciiay9s0G0BoU
         QeyQ==
X-Received: by 10.107.136.68 with SMTP id k65mr7002736iod.43.1413780109618;
 Sun, 19 Oct 2014 21:41:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.246.168 with HTTP; Sun, 19 Oct 2014 21:41:29 -0700 (PDT)
In-Reply-To: <1412972930-16777-2-git-send-email-blogic@openwrt.org>
References: <1412972930-16777-1-git-send-email-blogic@openwrt.org> <1412972930-16777-2-git-send-email-blogic@openwrt.org>
From:   Alexandre Courbot <gnurou@gmail.com>
Date:   Mon, 20 Oct 2014 13:41:29 +0900
Message-ID: <CAAVeFu+BAwDOV1siPkRSOes0iJETLWcKEBBFrTn6o=d+CYQPPw@mail.gmail.com>
Subject: Re: [PATCH 2/5] GPIO: MIPS: ralink: add gpio driver for ralink rt2880 SoC
To:     John Crispin <blogic@openwrt.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <gnurou@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43341
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

On Sat, Oct 11, 2014 at 5:28 AM, John Crispin <blogic@openwrt.org> wrote:
> Add gpio driver for Ralink SoC. This driver makes the gpio core on

Makes the gpio core what?

> RT2880, RT305x, rt3352, rt3662, rt3883, rt5350 and mt7620 work.
>
> Signed-off-by: John Crispin <blogic@openwrt.org>
> Cc: linux-mips@linux-mips.org
> Cc: linux-gpio@vger.kernel.org
> ---
>  drivers/gpio/Kconfig       |    6 +
>  drivers/gpio/Makefile      |    1 +
>  drivers/gpio/gpio-rt2880.c |  354 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 361 insertions(+)
>  create mode 100644 drivers/gpio/gpio-rt2880.c
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 9de1515..c91b15b 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -289,6 +289,12 @@ config GPIO_SCH311X
>           To compile this driver as a module, choose M here: the module will
>           be called gpio-sch311x.
>
> +config GPIO_RALINK
> +       bool "Ralink GPIO Support"
> +       depends on RALINK
> +       help
> +         Say yes here to support the Ralink SoC GPIO device
> +
>  config GPIO_SPEAR_SPICS
>         bool "ST SPEAr13xx SPI Chip Select as GPIO support"
>         depends on PLAT_SPEAR
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index 5d024e3..d8f0f17 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -67,6 +67,7 @@ obj-$(CONFIG_GPIO_PCF857X)    += gpio-pcf857x.o
>  obj-$(CONFIG_GPIO_PCH)         += gpio-pch.o
>  obj-$(CONFIG_GPIO_PL061)       += gpio-pl061.o
>  obj-$(CONFIG_GPIO_PXA)         += gpio-pxa.o
> +obj-$(CONFIG_GPIO_RALINK)      += gpio-rt2880.o
>  obj-$(CONFIG_GPIO_RC5T583)     += gpio-rc5t583.o
>  obj-$(CONFIG_GPIO_RDC321X)     += gpio-rdc321x.o
>  obj-$(CONFIG_GPIO_RCAR)                += gpio-rcar.o
> diff --git a/drivers/gpio/gpio-rt2880.c b/drivers/gpio/gpio-rt2880.c
> new file mode 100644
> index 0000000..c375210
> --- /dev/null
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

Please use <linux/gpio/driver.h> for new drivers.

> +#include <linux/spinlock.h>
> +#include <linux/platform_device.h>
> +#include <linux/of_irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/interrupt.h>
> +
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

You have a slight possibility for identifier collision with such
generic names. Maybe use RT2880_REG_ as a prefix?

> +
> +struct ralink_gpio_chip {
> +       struct gpio_chip chip;
> +       u8 regs[GPIO_REG_MAX];
> +
> +       spinlock_t lock;
> +       void __iomem *membase;
> +       struct irq_domain *domain;
> +       int irq;
> +
> +       u32 rising;
> +       u32 falling;
> +};
> +
> +#define MAP_MAX        4
> +static struct irq_domain *irq_map[MAP_MAX];
> +static int irq_map_count;
> +static atomic_t irq_refcount = ATOMIC_INIT(0);
> +
> +static inline struct ralink_gpio_chip *to_ralink_gpio(struct gpio_chip *chip)
> +{
> +       struct ralink_gpio_chip *rg;
> +
> +       rg = container_of(chip, struct ralink_gpio_chip, chip);
> +
> +       return rg;
> +}
> +
> +static inline void rt_gpio_w32(struct ralink_gpio_chip *rg, u8 reg, u32 val)

nit: reg could (should?) be of enum ralink_gpio_reg (same for other
functions that use a register index).

> +{
> +       iowrite32(val, rg->membase + rg->regs[reg]);
> +}
> +
> +static inline u32 rt_gpio_r32(struct ralink_gpio_chip *rg, u8 reg)
> +{
> +       return ioread32(rg->membase + rg->regs[reg]);
> +}
> +
> +static void ralink_gpio_set(struct gpio_chip *chip, unsigned offset, int value)

Isn't "offset" a gpio index? In that case renaming it to "gpio" might
made the code easier to understand (same for other functions).

> +{
> +       struct ralink_gpio_chip *rg = to_ralink_gpio(chip);
> +
> +       rt_gpio_w32(rg, (value) ? GPIO_REG_SET : GPIO_REG_RESET, BIT(offset));
> +}
> +
> +static int ralink_gpio_get(struct gpio_chip *chip, unsigned offset)
> +{
> +       struct ralink_gpio_chip *rg = to_ralink_gpio(chip);
> +
> +       return !!(rt_gpio_r32(rg, GPIO_REG_DATA) & BIT(offset));
> +}
> +
> +static int ralink_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
> +{
> +       struct ralink_gpio_chip *rg = to_ralink_gpio(chip);
> +       unsigned long flags;
> +       u32 t;
> +
> +       spin_lock_irqsave(&rg->lock, flags);
> +       t = rt_gpio_r32(rg, GPIO_REG_DIR);
> +       t &= ~BIT(offset);
> +       rt_gpio_w32(rg, GPIO_REG_DIR, t);
> +       spin_unlock_irqrestore(&rg->lock, flags);
> +
> +       return 0;
> +}
> +
> +static int ralink_gpio_direction_output(struct gpio_chip *chip,
> +                                       unsigned offset, int value)
> +{
> +       struct ralink_gpio_chip *rg = to_ralink_gpio(chip);
> +       unsigned long flags;
> +       u32 t;
> +
> +       spin_lock_irqsave(&rg->lock, flags);
> +       ralink_gpio_set(chip, offset, value);
> +       t = rt_gpio_r32(rg, GPIO_REG_DIR);
> +       t |= BIT(offset);
> +       rt_gpio_w32(rg, GPIO_REG_DIR, t);
> +       spin_unlock_irqrestore(&rg->lock, flags);
> +
> +       return 0;
> +}
> +
> +static int ralink_gpio_to_irq(struct gpio_chip *chip, unsigned pin)
> +{
> +       struct ralink_gpio_chip *rg = to_ralink_gpio(chip);
> +
> +       if (rg->irq < 1)
> +               return -1;
> +
> +       return irq_create_mapping(rg->domain, pin);
> +}
> +
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
> +
> +static void ralink_gpio_irq_unmask(struct irq_data *d)
> +{
> +       struct ralink_gpio_chip *rg;
> +       unsigned long flags;
> +       u32 val;
> +
> +       rg = (struct ralink_gpio_chip *) d->domain->host_data;
> +       val = rt_gpio_r32(rg, GPIO_REG_RENA);
> +
> +       spin_lock_irqsave(&rg->lock, flags);
> +       rt_gpio_w32(rg, GPIO_REG_RENA, val | (BIT(d->hwirq) & rg->rising));
> +       rt_gpio_w32(rg, GPIO_REG_FENA, val | (BIT(d->hwirq) & rg->falling));
> +       spin_unlock_irqrestore(&rg->lock, flags);
> +}
> +
> +static void ralink_gpio_irq_mask(struct irq_data *d)
> +{
> +       struct ralink_gpio_chip *rg;
> +       unsigned long flags;
> +       u32 val;
> +
> +       rg = (struct ralink_gpio_chip *) d->domain->host_data;
> +       val = rt_gpio_r32(rg, GPIO_REG_RENA);
> +
> +       spin_lock_irqsave(&rg->lock, flags);
> +       rt_gpio_w32(rg, GPIO_REG_FENA, val & ~BIT(d->hwirq));
> +       rt_gpio_w32(rg, GPIO_REG_RENA, val & ~BIT(d->hwirq));
> +       spin_unlock_irqrestore(&rg->lock, flags);
> +}
> +
> +static int ralink_gpio_irq_type(struct irq_data *d, unsigned int type)
> +{
> +       struct ralink_gpio_chip *rg;
> +       u32 mask = BIT(d->hwirq);
> +
> +       rg = (struct ralink_gpio_chip *) d->domain->host_data;
> +
> +       if (type == IRQ_TYPE_PROBE) {
> +               if ((rg->rising | rg->falling) & mask)
> +                       return 0;
> +
> +               type = IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING;
> +       }
> +
> +       if (type & IRQ_TYPE_EDGE_RISING)
> +               rg->rising |= mask;
> +       else
> +               rg->rising &= ~mask;
> +
> +       if (type & IRQ_TYPE_EDGE_FALLING)
> +               rg->falling |= mask;
> +       else
> +               rg->falling &= ~mask;
> +
> +       return 0;
> +}
> +
> +static struct irq_chip ralink_gpio_irq_chip = {
> +       .name           = "GPIO",
> +       .irq_unmask     = ralink_gpio_irq_unmask,
> +       .irq_mask       = ralink_gpio_irq_mask,
> +       .irq_mask_ack   = ralink_gpio_irq_mask,
> +       .irq_set_type   = ralink_gpio_irq_type,
> +};
> +
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
> +
> +static int ralink_gpio_request(struct gpio_chip *chip, unsigned offset)
> +{
> +       int gpio = chip->base + offset;
> +
> +       return pinctrl_request_gpio(gpio);
> +}
> +
> +static void ralink_gpio_free(struct gpio_chip *chip, unsigned offset)
> +{
> +       int gpio = chip->base + offset;
> +
> +       pinctrl_free_gpio(gpio);
> +}
> +
> +static int ralink_gpio_probe(struct platform_device *pdev)
> +{
> +       struct device_node *np = pdev->dev.of_node;
> +       struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       struct ralink_gpio_chip *rg;
> +       const __be32 *ngpio, *gpiobase;
> +
> +       if (!res) {
> +               dev_err(&pdev->dev, "failed to find resource\n");
> +               return -ENOMEM;
> +       }
> +
> +       rg = devm_kzalloc(&pdev->dev,
> +                       sizeof(struct ralink_gpio_chip), GFP_KERNEL);
> +       if (!rg)
> +               return -ENOMEM;
> +
> +       rg->membase = devm_ioremap_resource(&pdev->dev, res);
> +       if (!rg->membase) {
> +               dev_err(&pdev->dev, "cannot remap I/O memory region\n");
> +               return -ENOMEM;
> +       }
> +
> +       if (of_property_read_u8_array(np, "ralink,register-map",

This (and the device tree bindings) seems the indicate that the
registers offset can vary depending on the chip and bank. The chip can
be specified using the compatible property, as for the bank you can
also require a property giving the bank number. With these two bits of
information, this driver should be able to pick the right register
layout out of an in-driver table. This would be much cleaner that
letting the DT specify whatever layout it wants.

> +                       rg->regs, GPIO_REG_MAX)) {
> +               dev_err(&pdev->dev, "failed to read register definition\n");
> +               return -EINVAL;
> +       }
> +
> +       ngpio = of_get_property(np, "ralink,num-gpios", NULL);
> +       if (!ngpio) {
> +               dev_err(&pdev->dev, "failed to read number of pins\n");
> +               return -EINVAL;
> +       }
> +
> +       gpiobase = of_get_property(np, "ralink,gpio-base", NULL);

Mmm I am not sure this is a good idea - it let's the DT specify a
potentially already-used base for this GPIO chip. I'd get rid of this
option if it is not absolutely needed.

I haven't reviewed the IRQ part of this driver, being ignorant on the
matter. I will try to learn from Linus' review. :P
