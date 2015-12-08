Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2015 23:08:39 +0100 (CET)
Received: from exsmtp01.microchip.com ([198.175.253.37]:48974 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27013406AbbLHWIiBrxiZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Dec 2015 23:08:38 +0100
Received: from [10.14.4.125] (10.10.76.4) by CHN-SV-EXCH01.mchp-main.com
 (10.10.76.37) with Microsoft SMTP Server id 14.3.181.6; Tue, 8 Dec 2015
 15:08:31 -0700
Subject: Re: [PATCH 08/14] pinctrl: Add PIC32 pin control driver
To:     Linus Walleij <linus.walleij@linaro.org>
References: <1448065205-15762-1-git-send-email-joshua.henderson@microchip.com>
 <1448065205-15762-9-git-send-email-joshua.henderson@microchip.com>
 <CACRpkdaNFKfpn7nveZDvL_MwG9o_4U1Am+sa1C29WUQGGK7ZuA@mail.gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Andrei Pistirica <andrei.pistirica@microchip.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
From:   Joshua Henderson <joshua.henderson@microchip.com>
Message-ID: <5667567C.9060108@microchip.com>
Date:   Tue, 8 Dec 2015 15:15:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdaNFKfpn7nveZDvL_MwG9o_4U1Am+sa1C29WUQGGK7ZuA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <Joshua.Henderson@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50452
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joshua.henderson@microchip.com
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

Linus,

On 11/30/2015 06:41 AM, Linus Walleij wrote:
> On Sat, Nov 21, 2015 at 1:17 AM, Joshua Henderson
> <joshua.henderson@microchip.com> wrote:
> 
>> From: Andrei Pistirica <andrei.pistirica@microchip.com>
>>
>> Add a driver for the pin controller present on the Microchip PIC32
>> including the specific variant PIC32MZDA. This driver provides pinmux
>> and pinconfig operations as well as GPIO and IRQ chips for the GPIO
>> banks.
>>
>> Signed-off-by: Andrei Pistirica <andrei.pistirica@microchip.com>
>> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
> 
>> +config PINCTRL_PIC32
>> +       bool "Microchip PIC32 pin controller driver"
>> +       depends on OF
>> +       depends on MACH_PIC32
>> +       select PINMUX
>> +       select GENERIC_PINCONF
>> +       select GPIOLIB_IRQCHIP
> 
> Nice but...
> 
>> +struct pic32_gpio_irq {
>> +       struct irq_chip         gpio_irqchip;
>> +       struct irq_domain       *domain;
> 
> 
> If you're using GPIOLIB_IRQCHIP with a separate irq_domain
> you are totally missing the point of GPIOLIB_IRQCHIP.
> 
> Look closer at other drivers using GPIOLIB_IRQCHIP and
> get your driver to use the infrastructure properly.
> 

Consider it done.

>> +#define to_pic32_gpio_chip(c) container_of(c, struct pic32_gpio_chip, chip)
> 
> Make this a static inline function instead. #defines are
> hard to read.
> 

Ack.

>> +static struct pic32_gpio_chip *gpio_chips[MAX_PIO_BANKS];
> 
> Why? You should not need to keep track of the chips
> in some local array.

Ack.

> 
>> +int pic32_pinconf_open_drain_runtime(unsigned pin_id, int value)
>> +{
>> +       struct pic32_gpio_chip *pic32_chip = gpio_to_pic32_gpio_chip(pin_id);
>> +       unsigned pin = pin_id % PINS_PER_BANK;
>> +
>> +       if (IS_ERR_OR_NULL(pic32_chip))
>> +               return -ENODEV;
>> +
>> +       return pic32_pinconf_open_drain(pic32_chip, pin, value);
>> +}
>> +EXPORT_SYMBOL(pic32_pinconf_open_drain_runtime);
> 
> NO WAY are you going to call this from outside of the driver, even
> less other modules.
> 
> Use pin control states to control the pins, no cross calling of
> functions in the middle of everything thanks.
> 
> You shouldn't need one set of calls for "runtime" either, all pin
> control states are possible to control at runtime, we have no
> distinction between boot time and any other time.
> 

Ack.

>> +static int pic32_gpio_request(struct gpio_chip *chip, unsigned offset)
>> +{
>> +       int gpio = chip->base + offset;
>> +       int bank = chip->base / chip->ngpio;
>> +
>> +       dev_dbg(chip->dev, "%s: request GPIO-%c:%d(%d)\n", __func__,
>> +                'A' + bank, offset, gpio);
>> +
>> +       return pinctrl_request_gpio(gpio);
>> +}
>> +
>> +static void pic32_gpio_free(struct gpio_chip *chip, unsigned offset)
>> +{
>> +       int gpio = chip->base + offset;
>> +       int bank = chip->base / chip->ngpio;
>> +
>> +       dev_dbg(chip->dev, "%s: free GPIO-%c:%d(%d)\n", __func__,
>> +                'A' + bank, offset, gpio);
>> +
>> +       pinctrl_free_gpio(gpio);
>> +}
> 
> This looks nice.
>

With existing rework, these are gone.
 
>> +static int pic32_gpio_get(struct gpio_chip *chip, unsigned gpio)
>> +{
>> +       struct pic32_gpio_chip *pic32_chip = to_pic32_gpio_chip(chip);
>> +       struct pic32_reg __iomem *port_reg = (struct pic32_reg __iomem *)
>> +                               pic32_pio_get_reg(pic32_chip, PIC32_PORT);
>> +       u32 mask = BIT(gpio);
>> +
>> +       if (WARN_ON(port_reg == NULL || gpio >= chip->ngpio))
>> +               return -EINVAL;
>> +
>> +       return readl(&port_reg->val) & mask;
> 
> return !!(readl(&port_reg->val) & mask);
> 
> to clamp it to 0/1.

Ack.

> 
>> +static int pic32_gpio_get_dir(struct gpio_chip *chip, unsigned offset)
>> +{
>> +       struct pic32_gpio_chip *pic32_chip = to_pic32_gpio_chip(chip);
>> +       struct pic32_reg __iomem *tris_reg = (struct pic32_reg __iomem *)
>> +                               pic32_pio_get_reg(pic32_chip, PIC32_TRIS);
>> +       u32 mask = BIT(offset);
>> +
>> +       if (WARN_ON(tris_reg == NULL))
>> +               return -EINVAL;
>> +
>> +       return readl(&tris_reg->val) & mask;
> 
> Dito.

Ack.

> 
>> +static int pic32_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
>> +{
>> +       struct pic32_gpio_chip *pic32_chip = to_pic32_gpio_chip(chip);
>> +       struct pic32_gpio_irq *gpio_irq = &pic32_chip->gpio_irq;
>> +       int virq;
>> +
>> +       if (offset < chip->ngpio)
>> +               virq = irq_create_mapping(gpio_irq->domain, offset);
>> +       else
>> +               virq = -ENXIO;
>> +
>> +       dev_dbg(chip->dev, "%s: request IRQ for GPIO:%d, return:%d\n",
>> +                               __func__, offset + chip->base, virq);
>> +
>> +       return virq;
>> +}
> 
> This is handled by GPIOLIB_IRQCHIP and you should not define
> .to_irq() for a driver using that.
> 

Ack.

>> +static void pic32_gpio_ranges_setup(struct platform_device *pdev,
>> +                            struct pic32_gpio_chip *pic32_chip)
>> +{
>> +       struct device_node *np = pdev->dev.of_node;
>> +       struct pinctrl_gpio_range *range;
>> +       struct of_phandle_args args;
>> +       int ret;
>> +
>> +       ret = of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3, 0, &args);
>> +       pic32_chip->gpio_base = (ret == 0) ? args.args[1] + args.args[0] :
>> +                                       pic32_chip->pio_idx * PINS_PER_BANK;
>> +       pic32_chip->ngpio = (ret == 0) ? args.args[2] - args.args[0] :
>> +                                       PINS_PER_BANK;
>> +
>> +       range = &pic32_chip->range;
>> +       range->name = dev_name(&pdev->dev);
>> +       range->id = pic32_chip->pio_idx;
>> +       range->pin_base = range->base = pic32_chip->gpio_base;
>> +
>> +       range->npins = pic32_chip->ngpio;
>> +       range->gc = &pic32_chip->chip;
>> +
>> +       dev_dbg(&pdev->dev, "%s: GPIO-%c ranges: (%d,%d)\n", __func__,
>> +                               'A' + range->id,
>> +                               pic32_chip->gpio_base, pic32_chip->ngpio);
>> +}
> 
> What is the point of this? We alread add the ranged in the gpiolib
> core.
> 

Ack. It's no longer necessary when using gpiolib properly.

>> +static unsigned int gpio_irq_startup(struct irq_data *d)
> 
> This is a too generic name for a function, rename all of these
> prefixed with your custom name like pic32_irq_type() etc.
> 

Ack.

>> +{
>> +       struct pic32_gpio_chip *pic32_chip = irq_data_get_irq_chip_data(d);
>> +       struct pic32_gpio_irq *gpio_irq = &pic32_chip->gpio_irq;
>> +       unsigned pin = d->hwirq;
>> +       int ret;
>> +
>> +       ret = gpiochip_lock_as_irq(&pic32_chip->chip, pin);
>> +       if (ret) {
>> +               dev_err(pic32_chip->chip.dev, "unable to lock pind %lu IRQ\n",
>> +                       d->hwirq);
>> +               return ret;
>> +       }
> 
> This should not be called in .irq_startup() but in .irq_request_resources()
> and will not be needed at all if you use GPIOLIB_IRQCHIP properly
> since it defines these callbacks for you and handle them in the
> gpiolib core.
> 

Ack.

>> +
>> +       /* start CN */
>> +       switch (gpio_irq->type[pin]) {
>> +       case IRQ_TYPE_EDGE_RISING:
>> +               pic32_gpio_irq_rise_dset(pic32_chip, pin);
>> +       break;
>> +       case IRQ_TYPE_EDGE_FALLING:
>> +               pic32_gpio_irq_fall_dset(pic32_chip, pin);
>> +       break;
>> +       case IRQ_TYPE_EDGE_BOTH:
>> +               pic32_gpio_irq_rise_dset(pic32_chip, pin);
>> +               pic32_gpio_irq_fall_dset(pic32_chip, pin);
>> +       break;
>> +       default:
>> +               return -EINVAL;
>> +       }
> 
> Why are you doin this in the .startup() callback? This should be done
> in .set_type().
> 

Agreed.

>> +static int gpio_irq_type(struct irq_data *d, unsigned type)
> 
> This is a too generic name for a function, rename all of these
> prefixed with your custom name like pic32_irq_type() etc.
> 

Ack.

>> +{
>> +       struct pic32_gpio_chip *pic32_chip = irq_data_get_irq_chip_data(d);
>> +       struct pic32_gpio_irq *gpio_irq = &pic32_chip->gpio_irq;
>> +       unsigned pin = d->hwirq;
>> +
>> +       dev_dbg(pic32_chip->chip.dev, "%s: irq type:%u\n", __func__, type);
>> +
>> +       switch (type) {
>> +       case IRQ_TYPE_EDGE_RISING:
>> +       case IRQ_TYPE_EDGE_FALLING:
>> +       case IRQ_TYPE_EDGE_BOTH:
>> +               gpio_irq->type[pin] = type;
>> +               return IRQ_SET_MASK_OK;
>> +       default:
>> +               gpio_irq->type[pin] = IRQ_TYPE_NONE;
>> +               return -EINVAL;
>> +       }
>> +}
> 
> Do you rely on semantic call order like this being called before startup?
> 
> I do't think that's good, why can't you write to the hardware directly
> in this function?

Agreed.  I see no reason why we can't write to the hardware directly.  Simpler and cleaner.

> 
>> +/* map virtual irq on hw irq: domain translation */
>> +static int pic32_gpio_irq_map(struct irq_domain *d,
>> +                             unsigned int virq,
>> +                             irq_hw_number_t hw)
>> +/* decode irq number: base + pin */
>> +static int pic32_gpio_irq_domain_xlate(struct irq_domain *d,
>> +                                      struct device_node *ctrlr,
>> +                                      const u32 *intspec,
>> +                                      unsigned int intsize,
>> +                                      irq_hw_number_t *out_hwirq,
>> +                                      unsigned int *out_type)
>> +{
> 
> None of these should be needed if you use GPIOLIB_IRQCHIP.

Ack.

> 
>> +static int pic32_gpio_irq_map(struct irq_domain *d,
>> +                             unsigned int virq,
>> +                             irq_hw_number_t hw)
>> +{
>> +       struct pic32_gpio_chip *pic32_chip = d->host_data;
>> +       struct pic32_gpio_irq *gpio_irq = &pic32_chip->gpio_irq;
>> +       struct irq_chip *irqchip = &gpio_irq->gpio_irqchip;
>> +
>> +       dev_dbg(pic32_chip->chip.dev, "%s: GPIO-%c:%d map virq:%u\n", __func__,
>> +                               'A' + pic32_chip->pio_idx, virq, virq);
>> +
>> +       /* set the gpioX chip */
>> +       irq_set_chip(virq, irqchip);
>> +       irq_set_chip_data(virq, pic32_chip);
>> +       irq_set_handler(virq, handle_simple_irq);
> 
> This driver should use handle_edge_irq() and implement .irq_ack().

Ack.

> 
>> +static struct irq_domain_ops pic32_gpio_irqd_ops = {
>> +       .map    = pic32_gpio_irq_map,
>> +       .xlate  = pic32_gpio_irq_domain_xlate,
>> +};
> 
> And no custom domain at all.

Removed.

> 
>> +static int pic32_gpio_of_irq_setup(struct platform_device *pdev,
>> +                                  struct pic32_gpio_chip *pic32_chip)
>> +{
>> +       struct device_node *node = pdev->dev.of_node;
>> +       struct pic32_gpio_irq *gpio_irq = &pic32_chip->gpio_irq;
>> +       struct irq_chip *irqchip = &gpio_irq->gpio_irqchip;
>> +       int base_irq;
>> +
>> +       /* set irqchip */
>> +       irqchip->name = kasprintf(GFP_KERNEL, "GPIO-%c",
>> +                                               pic32_chip->pio_idx + 'A');
>> +       irqchip->irq_startup    = gpio_irq_startup;
>> +       irqchip->irq_shutdown   = gpio_irq_shutdown;
>> +       irqchip->irq_set_type   = gpio_irq_type;
> 
> Since you are supporting *only* edge IRQs you should
> implement and ->irq_ack() callback that ACKs the IRQ.
> Most likely the gpio controller is holding a level IRQ to the
> next interrupt controller active until you do this.
> 
> You should also make sure to use handle_edge_irq() as IRQ
> handler as this is what the chip supports.

Ack.  The hardware only supports edge interrupts for gpios.  I am curious what impact only supporting edge here will be.  Would you suggest emulating level interrupts in this case?

> 
>> +       base_irq = platform_get_irq(pdev, 0);
>> +       if (base_irq < 0)
>> +               return base_irq;
>> +
>> +       gpio_irq->pio_irq = base_irq;
>> +
>> +       /* Setup irq domain of ngpio lines */
>> +       gpio_irq->domain = irq_domain_add_linear(
>> +                                       node,
>> +                                       pic32_chip->chip.ngpio,
>> +                                       &pic32_gpio_irqd_ops, pic32_chip);
>> +       if (!gpio_irq->domain) {
>> +               dev_err(pic32_chip->chip.dev, "Couldn't allocate IRQ domain\n");
>> +               return -ENXIO;
>> +       }
> 
> This stuff should not be needed with GPIOLIB_IRQCHIP.
> 

Ack.

>> +       dev_dbg(&pdev->dev, "%s: irq GPIO-%c, base_irq:%d, domain:%d\n",
>> +                                        __func__, pic32_chip->pio_idx + 'A',
>> +                                       base_irq, pic32_chip->chip.ngpio);
>> +
>> +       /* setup chained handler */
>> +       irq_set_chip_data(gpio_irq->pio_irq, pic32_chip);
>> +       irq_set_chained_handler(gpio_irq->pio_irq, gpio_irq_handler);
> 
> And you should add the GPIO irqchip with
> gpiolib_add_irqchip().

Ack.

> 
>> +int pic32_gpio_probe(struct platform_device *pdev,
>> +                    unsigned (*reg_lookup_off)[],
>> +                    unsigned lookup_size)
>> +{
>> +       struct device_node *np = pdev->dev.of_node;
>> +       int alias_idx = of_alias_get_id(np, "gpio");
>> +       struct pic32_gpio_chip *pic32_chip = NULL;
>> +       struct gpio_chip *chip;
>> +       struct resource *r;
>> +       int ret = 0;
>> +
>> +       dev_dbg(&pdev->dev, "%s: probing...\n", __func__);
>> +
>> +       if (!np)
>> +               return -ENODEV;
>> +
>> +       if (WARN_ON(alias_idx >= ARRAY_SIZE(gpio_chips)))
>> +               return -EINVAL;
>> +
>> +       if (gpio_chips[alias_idx]) {
>> +               dev_err(&pdev->dev, "Failure %i for GPIO %i\n", ret, alias_idx);
>> +               return -EBUSY;
>> +       }
>> +
>> +       /* pic32 gpio chip - private data */
>> +       pic32_chip = devm_kzalloc(&pdev->dev, sizeof(*pic32_chip),
>> +                                                               GFP_KERNEL);
>> +       if (!pic32_chip)
>> +               return -ENOMEM;
>> +
>> +       /* base address of pio(alias_idx) registers */
>> +       r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       if (!r) {
>> +               ret = -EINVAL;
>> +               goto probe_err;
>> +       }
>> +       pic32_chip->pio_base = devm_ioremap_nocache(&pdev->dev, r->start,
>> +                                                       resource_size(r));
>> +       if (IS_ERR(pic32_chip->pio_base)) {
>> +               ret = PTR_ERR(pic32_chip->pio_base);
>> +               goto probe_err;
>> +       }
>> +
>> +       /* clocks */
>> +       pic32_chip->clk = devm_clk_get(&pdev->dev, NULL);
>> +       if (IS_ERR(pic32_chip->clk)) {
>> +               ret = PTR_ERR(pic32_chip->clk);
>> +               dev_err(&pdev->dev, "clk get failed\n");
>> +               goto probe_err;
>> +       }
>> +
>> +       ret = clk_prepare_enable(pic32_chip->clk);
>> +       if (ret) {
>> +               dev_err(&pdev->dev, "clk enable failed\n");
>> +               goto probe_err;
>> +       }
>> +
>> +       pic32_chip->reg_lookup_off = *reg_lookup_off;
>> +       pic32_chip->lookup_size = lookup_size;
>> +       pic32_chip->pio_idx = alias_idx;
>> +       pic32_chip->chip = gpio_template;
>> +       pic32_gpio_ranges_setup(pdev, pic32_chip);/* pin_ranges: unsupported */
> 
> I can't see why you have this. The gpiolib core handles this.
> 
> Please fix the above and repost, and I can look at the pin control
> parts. As it is now there are too many problems with the GPIO
> parts.
> 

Agreed.

> Yours,
> Linus Walleij
> 

Thanks,
Josh
