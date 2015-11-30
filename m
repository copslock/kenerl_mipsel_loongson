Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2015 14:41:12 +0100 (CET)
Received: from mail-ob0-f174.google.com ([209.85.214.174]:33732 "EHLO
        mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006763AbbK3NlKQC-w- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Nov 2015 14:41:10 +0100
Received: by obbww6 with SMTP id ww6so126788689obb.0
        for <linux-mips@linux-mips.org>; Mon, 30 Nov 2015 05:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Qhk4nL/HJ4TU25zeQxUwW09rRzp+ZIF/xWUhcxCUrdQ=;
        b=PvkN2UFryLDVNVdunqXVAhjwKO2M4HpKcqgYInssVqlAKl3bl2ucCBzPwRXB0x3pvE
         xEXkkS9VNrhZH9OoUslDdz7co+y+NvbvgutnlG0T9XWuT1VXqbBPNGxNjcOOplNv8n32
         EdPQI4S93EeYMVdw+tDzaTYPDy31yVk5SydBi8CvxiYHs3cq/yMLwGu1apNQYktBSybQ
         vK8+sl/8gdnxBrnZIA86wvDqr+x+d3HMRWwSZudjfdtD53XD9sZwuU0jgBViaUhgd1ZP
         Ykc+6EdYmmrIBaCGpBfZ7u2O1Ep/3U/4Aw49ZHh9fy2FpugPyEyDubBw+KSHHkXPjlYa
         TtpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Qhk4nL/HJ4TU25zeQxUwW09rRzp+ZIF/xWUhcxCUrdQ=;
        b=FlhFVdz+VTjWvcQkJs+NOFH8JrdOSPL0l+X5ZvlPtfiTea5O4sc/mr9M3jrZpcnGtl
         fr5GxSG5dI6j1LlVIej3a/fgOwnxQ6A+iv9tM9zWLYOpGDUZLZHWA3WeSZpeIXNooN4v
         aNZCGHK1I3CxxSp7LquwS6fmC+nBG02FGx9yFRxAIyexCUpWp0sXkzgiwV5DqQJ8ziNI
         OthRzBx17L1oSpsNonCBXWb//zW9KiabLp/FesygMXAVyyCgcYCVWmaoDO7dXJKMJXDo
         gTsaQfQ/nMS6vfxrt6I9FPc4Yz6RfSZjA0vAj9OkjSqjp8Nt2ISzxKzmnrZdXOc8f15B
         hClQ==
X-Gm-Message-State: ALoCoQmkBdo11srE4ti4wR1ZMUbzS9SmKG2inNnsbicOFMIxRUKJ7c0mzL35Hq3ZzHXEVcgPpPZx
MIME-Version: 1.0
X-Received: by 10.182.200.201 with SMTP id ju9mr7056157obc.30.1448890864066;
 Mon, 30 Nov 2015 05:41:04 -0800 (PST)
Received: by 10.182.32.70 with HTTP; Mon, 30 Nov 2015 05:41:03 -0800 (PST)
In-Reply-To: <1448065205-15762-9-git-send-email-joshua.henderson@microchip.com>
References: <1448065205-15762-1-git-send-email-joshua.henderson@microchip.com>
        <1448065205-15762-9-git-send-email-joshua.henderson@microchip.com>
Date:   Mon, 30 Nov 2015 14:41:03 +0100
Message-ID: <CACRpkdaNFKfpn7nveZDvL_MwG9o_4U1Am+sa1C29WUQGGK7ZuA@mail.gmail.com>
Subject: Re: [PATCH 08/14] pinctrl: Add PIC32 pin control driver
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Joshua Henderson <joshua.henderson@microchip.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Andrei Pistirica <andrei.pistirica@microchip.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50174
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

On Sat, Nov 21, 2015 at 1:17 AM, Joshua Henderson
<joshua.henderson@microchip.com> wrote:

> From: Andrei Pistirica <andrei.pistirica@microchip.com>
>
> Add a driver for the pin controller present on the Microchip PIC32
> including the specific variant PIC32MZDA. This driver provides pinmux
> and pinconfig operations as well as GPIO and IRQ chips for the GPIO
> banks.
>
> Signed-off-by: Andrei Pistirica <andrei.pistirica@microchip.com>
> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>

> +config PINCTRL_PIC32
> +       bool "Microchip PIC32 pin controller driver"
> +       depends on OF
> +       depends on MACH_PIC32
> +       select PINMUX
> +       select GENERIC_PINCONF
> +       select GPIOLIB_IRQCHIP

Nice but...

> +struct pic32_gpio_irq {
> +       struct irq_chip         gpio_irqchip;
> +       struct irq_domain       *domain;


If you're using GPIOLIB_IRQCHIP with a separate irq_domain
you are totally missing the point of GPIOLIB_IRQCHIP.

Look closer at other drivers using GPIOLIB_IRQCHIP and
get your driver to use the infrastructure properly.

> +#define to_pic32_gpio_chip(c) container_of(c, struct pic32_gpio_chip, chip)

Make this a static inline function instead. #defines are
hard to read.

> +static struct pic32_gpio_chip *gpio_chips[MAX_PIO_BANKS];

Why? You should not need to keep track of the chips
in some local array.

> +int pic32_pinconf_open_drain_runtime(unsigned pin_id, int value)
> +{
> +       struct pic32_gpio_chip *pic32_chip = gpio_to_pic32_gpio_chip(pin_id);
> +       unsigned pin = pin_id % PINS_PER_BANK;
> +
> +       if (IS_ERR_OR_NULL(pic32_chip))
> +               return -ENODEV;
> +
> +       return pic32_pinconf_open_drain(pic32_chip, pin, value);
> +}
> +EXPORT_SYMBOL(pic32_pinconf_open_drain_runtime);

NO WAY are you going to call this from outside of the driver, even
less other modules.

Use pin control states to control the pins, no cross calling of
functions in the middle of everything thanks.

You shouldn't need one set of calls for "runtime" either, all pin
control states are possible to control at runtime, we have no
distinction between boot time and any other time.

> +static int pic32_gpio_request(struct gpio_chip *chip, unsigned offset)
> +{
> +       int gpio = chip->base + offset;
> +       int bank = chip->base / chip->ngpio;
> +
> +       dev_dbg(chip->dev, "%s: request GPIO-%c:%d(%d)\n", __func__,
> +                'A' + bank, offset, gpio);
> +
> +       return pinctrl_request_gpio(gpio);
> +}
> +
> +static void pic32_gpio_free(struct gpio_chip *chip, unsigned offset)
> +{
> +       int gpio = chip->base + offset;
> +       int bank = chip->base / chip->ngpio;
> +
> +       dev_dbg(chip->dev, "%s: free GPIO-%c:%d(%d)\n", __func__,
> +                'A' + bank, offset, gpio);
> +
> +       pinctrl_free_gpio(gpio);
> +}

This looks nice.

> +static int pic32_gpio_get(struct gpio_chip *chip, unsigned gpio)
> +{
> +       struct pic32_gpio_chip *pic32_chip = to_pic32_gpio_chip(chip);
> +       struct pic32_reg __iomem *port_reg = (struct pic32_reg __iomem *)
> +                               pic32_pio_get_reg(pic32_chip, PIC32_PORT);
> +       u32 mask = BIT(gpio);
> +
> +       if (WARN_ON(port_reg == NULL || gpio >= chip->ngpio))
> +               return -EINVAL;
> +
> +       return readl(&port_reg->val) & mask;

return !!(readl(&port_reg->val) & mask);

to clamp it to 0/1.

> +static int pic32_gpio_get_dir(struct gpio_chip *chip, unsigned offset)
> +{
> +       struct pic32_gpio_chip *pic32_chip = to_pic32_gpio_chip(chip);
> +       struct pic32_reg __iomem *tris_reg = (struct pic32_reg __iomem *)
> +                               pic32_pio_get_reg(pic32_chip, PIC32_TRIS);
> +       u32 mask = BIT(offset);
> +
> +       if (WARN_ON(tris_reg == NULL))
> +               return -EINVAL;
> +
> +       return readl(&tris_reg->val) & mask;

Dito.

> +static int pic32_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
> +{
> +       struct pic32_gpio_chip *pic32_chip = to_pic32_gpio_chip(chip);
> +       struct pic32_gpio_irq *gpio_irq = &pic32_chip->gpio_irq;
> +       int virq;
> +
> +       if (offset < chip->ngpio)
> +               virq = irq_create_mapping(gpio_irq->domain, offset);
> +       else
> +               virq = -ENXIO;
> +
> +       dev_dbg(chip->dev, "%s: request IRQ for GPIO:%d, return:%d\n",
> +                               __func__, offset + chip->base, virq);
> +
> +       return virq;
> +}

This is handled by GPIOLIB_IRQCHIP and you should not define
.to_irq() for a driver using that.

> +static void pic32_gpio_ranges_setup(struct platform_device *pdev,
> +                            struct pic32_gpio_chip *pic32_chip)
> +{
> +       struct device_node *np = pdev->dev.of_node;
> +       struct pinctrl_gpio_range *range;
> +       struct of_phandle_args args;
> +       int ret;
> +
> +       ret = of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3, 0, &args);
> +       pic32_chip->gpio_base = (ret == 0) ? args.args[1] + args.args[0] :
> +                                       pic32_chip->pio_idx * PINS_PER_BANK;
> +       pic32_chip->ngpio = (ret == 0) ? args.args[2] - args.args[0] :
> +                                       PINS_PER_BANK;
> +
> +       range = &pic32_chip->range;
> +       range->name = dev_name(&pdev->dev);
> +       range->id = pic32_chip->pio_idx;
> +       range->pin_base = range->base = pic32_chip->gpio_base;
> +
> +       range->npins = pic32_chip->ngpio;
> +       range->gc = &pic32_chip->chip;
> +
> +       dev_dbg(&pdev->dev, "%s: GPIO-%c ranges: (%d,%d)\n", __func__,
> +                               'A' + range->id,
> +                               pic32_chip->gpio_base, pic32_chip->ngpio);
> +}

What is the point of this? We alread add the ranged in the gpiolib
core.

> +static unsigned int gpio_irq_startup(struct irq_data *d)

This is a too generic name for a function, rename all of these
prefixed with your custom name like pic32_irq_type() etc.

> +{
> +       struct pic32_gpio_chip *pic32_chip = irq_data_get_irq_chip_data(d);
> +       struct pic32_gpio_irq *gpio_irq = &pic32_chip->gpio_irq;
> +       unsigned pin = d->hwirq;
> +       int ret;
> +
> +       ret = gpiochip_lock_as_irq(&pic32_chip->chip, pin);
> +       if (ret) {
> +               dev_err(pic32_chip->chip.dev, "unable to lock pind %lu IRQ\n",
> +                       d->hwirq);
> +               return ret;
> +       }

This should not be called in .irq_startup() but in .irq_request_resources()
and will not be needed at all if you use GPIOLIB_IRQCHIP properly
since it defines these callbacks for you and handle them in the
gpiolib core.

> +
> +       /* start CN */
> +       switch (gpio_irq->type[pin]) {
> +       case IRQ_TYPE_EDGE_RISING:
> +               pic32_gpio_irq_rise_dset(pic32_chip, pin);
> +       break;
> +       case IRQ_TYPE_EDGE_FALLING:
> +               pic32_gpio_irq_fall_dset(pic32_chip, pin);
> +       break;
> +       case IRQ_TYPE_EDGE_BOTH:
> +               pic32_gpio_irq_rise_dset(pic32_chip, pin);
> +               pic32_gpio_irq_fall_dset(pic32_chip, pin);
> +       break;
> +       default:
> +               return -EINVAL;
> +       }

Why are you doin this in the .startup() callback? This should be done
in .set_type().

> +static int gpio_irq_type(struct irq_data *d, unsigned type)

This is a too generic name for a function, rename all of these
prefixed with your custom name like pic32_irq_type() etc.

> +{
> +       struct pic32_gpio_chip *pic32_chip = irq_data_get_irq_chip_data(d);
> +       struct pic32_gpio_irq *gpio_irq = &pic32_chip->gpio_irq;
> +       unsigned pin = d->hwirq;
> +
> +       dev_dbg(pic32_chip->chip.dev, "%s: irq type:%u\n", __func__, type);
> +
> +       switch (type) {
> +       case IRQ_TYPE_EDGE_RISING:
> +       case IRQ_TYPE_EDGE_FALLING:
> +       case IRQ_TYPE_EDGE_BOTH:
> +               gpio_irq->type[pin] = type;
> +               return IRQ_SET_MASK_OK;
> +       default:
> +               gpio_irq->type[pin] = IRQ_TYPE_NONE;
> +               return -EINVAL;
> +       }
> +}

Do you rely on semantic call order like this being called before startup?

I do't think that's good, why can't you write to the hardware directly
in this function?

> +/* map virtual irq on hw irq: domain translation */
> +static int pic32_gpio_irq_map(struct irq_domain *d,
> +                             unsigned int virq,
> +                             irq_hw_number_t hw)
> +/* decode irq number: base + pin */
> +static int pic32_gpio_irq_domain_xlate(struct irq_domain *d,
> +                                      struct device_node *ctrlr,
> +                                      const u32 *intspec,
> +                                      unsigned int intsize,
> +                                      irq_hw_number_t *out_hwirq,
> +                                      unsigned int *out_type)
> +{

None of these should be needed if you use GPIOLIB_IRQCHIP.

> +static int pic32_gpio_irq_map(struct irq_domain *d,
> +                             unsigned int virq,
> +                             irq_hw_number_t hw)
> +{
> +       struct pic32_gpio_chip *pic32_chip = d->host_data;
> +       struct pic32_gpio_irq *gpio_irq = &pic32_chip->gpio_irq;
> +       struct irq_chip *irqchip = &gpio_irq->gpio_irqchip;
> +
> +       dev_dbg(pic32_chip->chip.dev, "%s: GPIO-%c:%d map virq:%u\n", __func__,
> +                               'A' + pic32_chip->pio_idx, virq, virq);
> +
> +       /* set the gpioX chip */
> +       irq_set_chip(virq, irqchip);
> +       irq_set_chip_data(virq, pic32_chip);
> +       irq_set_handler(virq, handle_simple_irq);

This driver should use handle_edge_irq() and implement .irq_ack().

> +static struct irq_domain_ops pic32_gpio_irqd_ops = {
> +       .map    = pic32_gpio_irq_map,
> +       .xlate  = pic32_gpio_irq_domain_xlate,
> +};

And no custom domain at all.

> +static int pic32_gpio_of_irq_setup(struct platform_device *pdev,
> +                                  struct pic32_gpio_chip *pic32_chip)
> +{
> +       struct device_node *node = pdev->dev.of_node;
> +       struct pic32_gpio_irq *gpio_irq = &pic32_chip->gpio_irq;
> +       struct irq_chip *irqchip = &gpio_irq->gpio_irqchip;
> +       int base_irq;
> +
> +       /* set irqchip */
> +       irqchip->name = kasprintf(GFP_KERNEL, "GPIO-%c",
> +                                               pic32_chip->pio_idx + 'A');
> +       irqchip->irq_startup    = gpio_irq_startup;
> +       irqchip->irq_shutdown   = gpio_irq_shutdown;
> +       irqchip->irq_set_type   = gpio_irq_type;

Since you are supporting *only* edge IRQs you should
implement and ->irq_ack() callback that ACKs the IRQ.
Most likely the gpio controller is holding a level IRQ to the
next interrupt controller active until you do this.

You should also make sure to use handle_edge_irq() as IRQ
handler as this is what the chip supports.

> +       base_irq = platform_get_irq(pdev, 0);
> +       if (base_irq < 0)
> +               return base_irq;
> +
> +       gpio_irq->pio_irq = base_irq;
> +
> +       /* Setup irq domain of ngpio lines */
> +       gpio_irq->domain = irq_domain_add_linear(
> +                                       node,
> +                                       pic32_chip->chip.ngpio,
> +                                       &pic32_gpio_irqd_ops, pic32_chip);
> +       if (!gpio_irq->domain) {
> +               dev_err(pic32_chip->chip.dev, "Couldn't allocate IRQ domain\n");
> +               return -ENXIO;
> +       }

This stuff should not be needed with GPIOLIB_IRQCHIP.

> +       dev_dbg(&pdev->dev, "%s: irq GPIO-%c, base_irq:%d, domain:%d\n",
> +                                        __func__, pic32_chip->pio_idx + 'A',
> +                                       base_irq, pic32_chip->chip.ngpio);
> +
> +       /* setup chained handler */
> +       irq_set_chip_data(gpio_irq->pio_irq, pic32_chip);
> +       irq_set_chained_handler(gpio_irq->pio_irq, gpio_irq_handler);

And you should add the GPIO irqchip with
gpiolib_add_irqchip().

> +int pic32_gpio_probe(struct platform_device *pdev,
> +                    unsigned (*reg_lookup_off)[],
> +                    unsigned lookup_size)
> +{
> +       struct device_node *np = pdev->dev.of_node;
> +       int alias_idx = of_alias_get_id(np, "gpio");
> +       struct pic32_gpio_chip *pic32_chip = NULL;
> +       struct gpio_chip *chip;
> +       struct resource *r;
> +       int ret = 0;
> +
> +       dev_dbg(&pdev->dev, "%s: probing...\n", __func__);
> +
> +       if (!np)
> +               return -ENODEV;
> +
> +       if (WARN_ON(alias_idx >= ARRAY_SIZE(gpio_chips)))
> +               return -EINVAL;
> +
> +       if (gpio_chips[alias_idx]) {
> +               dev_err(&pdev->dev, "Failure %i for GPIO %i\n", ret, alias_idx);
> +               return -EBUSY;
> +       }
> +
> +       /* pic32 gpio chip - private data */
> +       pic32_chip = devm_kzalloc(&pdev->dev, sizeof(*pic32_chip),
> +                                                               GFP_KERNEL);
> +       if (!pic32_chip)
> +               return -ENOMEM;
> +
> +       /* base address of pio(alias_idx) registers */
> +       r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!r) {
> +               ret = -EINVAL;
> +               goto probe_err;
> +       }
> +       pic32_chip->pio_base = devm_ioremap_nocache(&pdev->dev, r->start,
> +                                                       resource_size(r));
> +       if (IS_ERR(pic32_chip->pio_base)) {
> +               ret = PTR_ERR(pic32_chip->pio_base);
> +               goto probe_err;
> +       }
> +
> +       /* clocks */
> +       pic32_chip->clk = devm_clk_get(&pdev->dev, NULL);
> +       if (IS_ERR(pic32_chip->clk)) {
> +               ret = PTR_ERR(pic32_chip->clk);
> +               dev_err(&pdev->dev, "clk get failed\n");
> +               goto probe_err;
> +       }
> +
> +       ret = clk_prepare_enable(pic32_chip->clk);
> +       if (ret) {
> +               dev_err(&pdev->dev, "clk enable failed\n");
> +               goto probe_err;
> +       }
> +
> +       pic32_chip->reg_lookup_off = *reg_lookup_off;
> +       pic32_chip->lookup_size = lookup_size;
> +       pic32_chip->pio_idx = alias_idx;
> +       pic32_chip->chip = gpio_template;
> +       pic32_gpio_ranges_setup(pdev, pic32_chip);/* pin_ranges: unsupported */

I can't see why you have this. The gpiolib core handles this.

Please fix the above and repost, and I can look at the pin control
parts. As it is now there are too many problems with the GPIO
parts.

Yours,
Linus Walleij
