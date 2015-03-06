Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Mar 2015 12:55:20 +0100 (CET)
Received: from mail-ob0-f169.google.com ([209.85.214.169]:39858 "EHLO
        mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012651AbbCFLzSBgEXp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Mar 2015 12:55:18 +0100
Received: by obcwp18 with SMTP id wp18so8754027obc.6
        for <linux-mips@linux-mips.org>; Fri, 06 Mar 2015 03:55:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=asC7e/7usDKLycpaVW3hry8KcLsAZm4Qv6j/kMOS+BQ=;
        b=hLPPy6YjrwQwQRQ29w/xiJVUqO+wm8tA+o7Tdde1joxrp5MePCDkxtxTKPV+uK/83Q
         G/2cePkyfdCjFqcW9/3zhFGzrch/VC43tczMWv4HdpWICC/YeGha7ZYZm3XgcF8W4Z8B
         l7WJmpYrSCxWZ0RNWZB7721Nmn/gzkZm9IIY5sXjQJKXd1zuzX9pqCqIWSqd6JcUkrNJ
         qvkcFkyUaU+maWwjsg4tNlPyJbX9k6qxRaOSwzq46Q1w9gxCptDksGJPVsJfTGOHN8id
         YHB09sQ8czqj+DGtoM7q9axGTnnhENuvnW8Igt20QMt+8HPQcq/FFvUqw5LbJwWTgnL9
         NCng==
X-Gm-Message-State: ALoCoQkQR7r8k/vjAQdHKSoWvt88meiLdMOgvbsQlN18CKldFIKnAeWZaWBcaHF/RY7un0VbPkTr
MIME-Version: 1.0
X-Received: by 10.60.42.42 with SMTP id k10mr10716749oel.15.1425642912735;
 Fri, 06 Mar 2015 03:55:12 -0800 (PST)
Received: by 10.182.132.45 with HTTP; Fri, 6 Mar 2015 03:55:12 -0800 (PST)
In-Reply-To: <1424744104-14151-3-git-send-email-abrestic@chromium.org>
References: <1424744104-14151-1-git-send-email-abrestic@chromium.org>
        <1424744104-14151-3-git-send-email-abrestic@chromium.org>
Date:   Fri, 6 Mar 2015 12:55:12 +0100
Message-ID: <CACRpkdbqioAreyDwM2JN87=gH20n1OkUXPjdkW885iDWUV1NnA@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: Add Pistachio SoC pin control driver
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Andrew Bresticker <abrestic@chromium.org>
Cc:     Alexandre Courbot <gnurou@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        Govindraj Raja <govindraj.raja@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46230
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

On Tue, Feb 24, 2015 at 3:15 AM, Andrew Bresticker
<abrestic@chromium.org> wrote:

> Add a driver for the pin controller present on the IMG Pistachio SoC.
> This driver provides pinmux and pinconfig operations as well as GPIO
> and IRQ chips for the GPIO banks.
>
> Signed-off-by: Damien Horsley <Damien.Horsley@imgtec.com>
> Signed-off-by: Govindraj Raja <govindraj.raja@imgtec.com>
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>

(...)
> +static inline u32 pctl_readl(struct pistachio_pinctrl *pctl, u32 reg)
> +{
> +       return readl(pctl->base + reg);
> +}
> +
> +static inline void pctl_writel(struct pistachio_pinctrl *pctl, u32 val, u32 reg)
> +{
> +       writel(val, pctl->base + reg);
> +}
> +
> +static inline u32 gpio_readl(struct pistachio_gpio_bank *bank, u32 reg)
> +{
> +       return readl(bank->base + reg);
> +}
> +
> +static inline void gpio_writel(struct pistachio_gpio_bank *bank, u32 val,
> +                              u32 reg)
> +{
> +       writel(val, bank->base + reg);
> +}

I don't see the point of these special readl/writel accessors. Just
use readl/writel
directly. Or consider readl/writel_relaxed() if MIPS has this.

> +static inline void gpio_mask_writel(struct pistachio_gpio_bank *bank,
> +                                   u32 reg, unsigned int bit, u32 val)
> +{
> +       gpio_writel(bank, (0x10000 | val) << bit, reg);
> +}

Magic mask? Some comment on what is happening here when OR:in
on 0x10000?

(...)
> +static int pistachio_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
> +{
> +       struct pistachio_gpio_bank *bank = gc_to_bank(chip);
> +
> +       if (gpio_readl(bank, GPIO_OUTPUT_EN) & BIT(offset))
> +               return GPIOF_DIR_OUT;
> +       return GPIOF_DIR_IN;
> +}

These flags are not for the driver API.

Do this:

return !gpio_readl(bank, GPIO_OUTPUT_EN) & BIT(offset));

> +static void pistachio_gpio_set(struct gpio_chip *chip, unsigned offset,
> +                              int value)
> +{
> +       struct pistachio_gpio_bank *bank = gc_to_bank(chip);
> +
> +       gpio_mask_writel(bank, GPIO_OUTPUT, offset, !!value);
> +}

Hm we should clamp value in the core and make the parameter "value"
a bool.... sigh for another day when things are calm.

(...)
> +static void pistachio_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
> +{
> +       struct gpio_chip *gc = irq_get_handler_data(irq);
> +       struct pistachio_gpio_bank *bank = gc_to_bank(gc);
> +       struct irq_chip *chip = irq_get_chip(irq);
> +       unsigned long pending;
> +       unsigned int pin, virq;

Don't call it virq, just call it irq. All Linux irq numbers are virtual
so just go with irq.

> +
> +       chained_irq_enter(chip, desc);
> +       pending = gpio_readl(bank, GPIO_INTERRUPT_STATUS) &
> +               gpio_readl(bank, GPIO_INTERRUPT_EN);
> +       for_each_set_bit(pin, &pending, 16) {
> +               virq = irq_linear_revmap(gc->irqdomain, pin);
> +               generic_handle_irq(virq);
> +       }
> +       chained_irq_exit(chip, desc);
> +}

(...)
> +static int pistachio_gpio_register(struct pistachio_pinctrl *pctl)
> +{
> +       struct device_node *child, *node = pctl->dev->of_node;
> +       struct pistachio_gpio_bank *bank;
> +       unsigned int i = 0;
> +       int irq, ret = 0;
> +
> +       for_each_child_of_node(node, child) {
> +               if (!of_find_property(child, "gpio-controller", NULL))
> +                       continue;

So why not instead specify "simple-bus" as compatible on the parent node
and have each subnode be its own device (simple-bus will spawn platform
devices for all subnodes).

Overall this composite-device pattern is discouraged if we can instead have
unique devices for each bank.

Apart from these things the driver looks very nice!

Yours,
Linus Walleij
