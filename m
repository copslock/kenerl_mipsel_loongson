Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Oct 2014 10:58:46 +0200 (CEST)
Received: from mail-ie0-f170.google.com ([209.85.223.170]:44432 "EHLO
        mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011484AbaJOI6odiKhj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Oct 2014 10:58:44 +0200
Received: by mail-ie0-f170.google.com with SMTP id rd18so801275iec.1
        for <linux-mips@linux-mips.org>; Wed, 15 Oct 2014 01:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=iiRCVx+ISBeIb6eHD0MMQVixSJ7DJAn5+9O+yGI5R5s=;
        b=gL9hlSBKw4MF5ik1y6sLUtUbQQaX2sV7rUdsGK1ENVYARKBOHgQzJkng+xcy8Dw/ea
         yYGBYcWWvqd3Y8g4JCQ57amNZbWp5DuobqAtTtYq1F46Ra/vIzY1ExXP9hbTNkWYindl
         KRxWCPRKdedT1u76E54xVsY6fUNSLjKh6zhJhR6qdCRsld73r9J+IJumWNlRMLb9/6pv
         o3yi/NlnnYbhOHzaMU5c5qDfBcJsyeirTYKFShJE9i3JN6dDuZz5Ez/tVV9ta9qVO62i
         2yYjMynTtIRsHVR4pFS8WxEQweNy1IEPxMApb16z0lvASvYqX/KPwx0jCt4vsecmHvlM
         PIBA==
X-Gm-Message-State: ALoCoQnrK3gbJ0O8IQv9MISoWW39ye3gA74UmQMIJR4e2mhlzuU2xSiQIzZT+9WflAgQVZM5OZkO
MIME-Version: 1.0
X-Received: by 10.107.29.209 with SMTP id d200mr1302919iod.57.1413363517810;
 Wed, 15 Oct 2014 01:58:37 -0700 (PDT)
Received: by 10.43.102.201 with HTTP; Wed, 15 Oct 2014 01:58:37 -0700 (PDT)
In-Reply-To: <1411929195-23775-11-git-send-email-ryazanov.s.a@gmail.com>
References: <1411929195-23775-1-git-send-email-ryazanov.s.a@gmail.com>
        <1411929195-23775-11-git-send-email-ryazanov.s.a@gmail.com>
Date:   Wed, 15 Oct 2014 10:58:37 +0200
Message-ID: <CACRpkdYWNjE1KS8GQo0fRrgT-Siwe7=SAOGQqBVqoW+Ypg-jAw@mail.gmail.com>
Subject: Re: [PATCH 10/16] gpio: add driver for Atheros AR2315 SoC GPIO controller
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43290
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

On Sun, Sep 28, 2014 at 8:33 PM, Sergey Ryazanov <ryazanov.s.a@gmail.com> wrote:

> Atheros AR2315 SoC have a builtin GPIO controller, which could be
> accessed via memory mapped registers. This patch adds new driver
> for them.
>
> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: linux-gpio@vger.kernel.org

> +config GPIO_AR2315
> +       bool "AR2315 SoC GPIO support"
> +       default y if SOC_AR2315
> +       depends on SOC_AR2315
> +       help
> +         Say yes here to enable GPIO support for Atheros AR2315+ SoCs.

select GPIOLIB_IRQCHIP

As far as I can see this driver should use the gpiolib irqchip helpers
and create a cascading irqchip. The code uses some copy/pasting
from earlier drivers which is not a good idea. Look at one of the drivers
using GPIOLIB_IRQCHIP and be inspired, check e.g. gpio-pl061.c
or gpio-zynq.c

> +static u32 ar2315_gpio_intmask;
> +static u32 ar2315_gpio_intval;
> +static unsigned ar2315_gpio_irq_base;
> +static void __iomem *ar2315_mem;

No static locals. Allocate and use a state container, see
Documentation/driver-model/design-patterns.txt

> +static inline u32 ar2315_gpio_reg_read(unsigned reg)
> +{
> +       return __raw_readl(ar2315_mem + reg);
> +}

Use readl_relaxed() instead.

> +static inline void ar2315_gpio_reg_write(unsigned reg, u32 val)
> +{
> +       __raw_writel(val, ar2315_mem + reg);
> +}

Use writel_relaxed() instead.

When you use the state container, you need to do a
state dereference like that:

mystate->base + reg

So I don't think these inlines buy you anything. Just use
readl/writel_relaxed directly in the code.

> +static inline void ar2315_gpio_reg_mask(unsigned reg, u32 mask, u32 val)
> +{
> +       ar2315_gpio_reg_write(reg, (ar2315_gpio_reg_read(reg) & ~mask) | val);
> +}

Too simple helper IMO, if you wanna do this in some organized fashion,
use regmap.

> +static void ar2315_gpio_int_setup(unsigned gpio, int trig)
> +{
> +       u32 reg = ar2315_gpio_reg_read(AR2315_GPIO_INT);
> +
> +       reg &= ~(AR2315_GPIO_INT_NUM_M | AR2315_GPIO_INT_TRIG_M);
> +       reg |= gpio | AR2315_GPIO_INT_TRIG(trig);
> +       ar2315_gpio_reg_write(AR2315_GPIO_INT, reg);
> +}

Trig? Isn't this supposed to be done in the .set_type()
callback?

> +static void ar2315_gpio_irq_unmask(struct irq_data *d)
> +{
> +       unsigned gpio = d->irq - ar2315_gpio_irq_base;

This kind of weird calculations go away with irqdomain and that
is in turn used by GPIOLIB_IRQCHIP.

After that you will just use d->hwirq. And name the variable
"offset" while you're at it.

> +       u32 dir = ar2315_gpio_reg_read(AR2315_GPIO_DIR);
> +
> +       /* Enable interrupt with edge detection */
> +       if ((dir & AR2315_GPIO_DIR_M(gpio)) != AR2315_GPIO_DIR_I(gpio))
> +               return;
> +
> +       ar2315_gpio_intmask |= (1 << gpio);

#include <linux/bitops.h>

ar2315_gpio_intmask |= BIT(gpio);

> +       ar2315_gpio_int_setup(gpio, AR2315_GPIO_INT_TRIG_EDGE);
> +}

> +static struct irq_chip ar2315_gpio_irq_chip = {
> +       .name           = DRIVER_NAME,
> +       .irq_unmask     = ar2315_gpio_irq_unmask,
> +       .irq_mask       = ar2315_gpio_irq_mask,
> +};

So why is .set_type() not implemented and instead hard-coded into
the unmask function? Please fix this. It will be called by the
core eventually no matter what.

> +static void ar2315_gpio_irq_init(unsigned irq)
> +{
> +       unsigned i;
> +
> +       ar2315_gpio_intval = ar2315_gpio_reg_read(AR2315_GPIO_DI);
> +       for (i = 0; i < AR2315_GPIO_NUM; i++) {
> +               unsigned _irq = ar2315_gpio_irq_base + i;
> +
> +               irq_set_chip_and_handler(_irq, &ar2315_gpio_irq_chip,
> +                                        handle_level_irq);
> +       }
> +       irq_set_chained_handler(irq, ar2315_gpio_irq_handler);
> +}

No, use the gpiolib irqchip helpers.

> +static int ar2315_gpio_get_val(struct gpio_chip *chip, unsigned gpio)
> +{
> +       return (ar2315_gpio_reg_read(AR2315_GPIO_DI) >> gpio) & 1;
> +}

Do this instead:

return !!(ar2315_gpio_reg_read(AR2315_GPIO_DI) & BIT(offset));

> +static int ar2315_gpio_to_irq(struct gpio_chip *chip, unsigned gpio)
> +{
> +       return ar2315_gpio_irq_base + gpio;
> +}

You do not implement this at all when using the gpiolib irqchip helpers.

> +static int ar2315_gpio_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct resource *res;
> +       unsigned irq;
> +       int ret;
> +
> +       if (ar2315_mem)
> +               return -EBUSY;
> +
> +       res = platform_get_resource_byname(pdev, IORESOURCE_IRQ, DRIVER_NAME);
> +       if (!res) {
> +               dev_err(dev, "not found IRQ number\n");
> +               return -ENXIO;
> +       }
> +       irq = res->start;

Use

irq = platform_get_irq_byname(pdev, DRIVER_NAME);
if (irq < 0)...

> +       ret = irq_alloc_descs(-1, 0, AR2315_GPIO_NUM, 0);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to allocate IRQ numbers\n");
> +               return ret;
> +       }
> +       ar2315_gpio_irq_base = ret;
> +
> +       ar2315_gpio_irq_init(irq);

No, let GPIOLIB_IRQCHIP handle this.

> +static int __init ar2315_gpio_init(void)
> +{
> +       return platform_driver_register(&ar2315_gpio_driver);
> +}
> +subsys_initcall(ar2315_gpio_init);

Why are you using subsys_initcall()?

This should not be necessary.

Yours,
Linus Walleij
