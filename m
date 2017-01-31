Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2017 15:14:06 +0100 (CET)
Received: from mail-it0-x229.google.com ([IPv6:2607:f8b0:4001:c0b::229]:35576
        "EHLO mail-it0-x229.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993891AbdAaON7KDW3e (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Jan 2017 15:13:59 +0100
Received: by mail-it0-x229.google.com with SMTP id 203so217360205ith.0
        for <linux-mips@linux-mips.org>; Tue, 31 Jan 2017 06:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XuBZ2WUpDjEu9RLOdUA8kBdwPhMvngMewrbX4fw2l/s=;
        b=cQBNfPDLTVGx2tyJ9MKr554eIqWg2qxAwO5/p5pH5/9O6lYZcvEKYlSRH0iINhyMwZ
         53NER6AXv60HEA0WkgFlSxGv7ZWUnofc386kzAhUZZf2zsw04DMDxbcTXccKu2va2B7W
         lI66DJMgLf9w8mGxP9LgSFkq4hMK8bTGCUK+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XuBZ2WUpDjEu9RLOdUA8kBdwPhMvngMewrbX4fw2l/s=;
        b=D85pgp6qr5rn6TjEwOPNRW0paUbyLyZez8h1hlswzmn6wkHAmQXYwNwpMPMv1U4M4h
         HSc6IV+6UK2pcwPMZf0LW34kAyaPQ5eoP3uGTGmLcMtnx611s9LY0mz3cHZ1K+SQJk1N
         YV76TrFLDiXBeA3d4COqQTVOvyeur5upzh2h1drfmIjrtgkp4nSq4BETPRwbFHXDRtgE
         Q6z7UZ+1cPv/11iCJXKpHBGM8Be3T7opsjznOhdx9Us9xfF5dyGKiH9gmYVob9XZ0qbh
         Xj4rES/7kNNDqeJH5hormP0/qH9VyMoUii58bZ7YUV/OP1B7Jkya0e6B9mXUEdsHEBrp
         8BrA==
X-Gm-Message-State: AIkVDXJJ9UnCTbeNHeWNtV+jtONxLJler12Bnpp52PEBB3TScwu6VZ5S73YdwVRdgyrl4/uErSiJuiRo/Q6NIg/a
X-Received: by 10.36.26.9 with SMTP id 9mr20183420iti.25.1485872031887; Tue,
 31 Jan 2017 06:13:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.169.75 with HTTP; Tue, 31 Jan 2017 06:13:50 -0800 (PST)
In-Reply-To: <20170125185207.23902-5-paul@crapouillou.net>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170125185207.23902-1-paul@crapouillou.net> <20170125185207.23902-5-paul@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 31 Jan 2017 15:13:50 +0100
Message-ID: <CACRpkdaqQ2==B1_o-Ru81Nbu_kUF+Kxn=XFYms-1e=nAtHiJ4A@mail.gmail.com>
Subject: Re: [PATCH v3 04/14] GPIO: Add gpio-ingenic driver
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Burton <paul.burton@imgtec.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56547
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

On Wed, Jan 25, 2017 at 7:51 PM, Paul Cercueil <paul@crapouillou.net> wrote:

> This driver handles the GPIOs of all the Ingenic JZ47xx SoCs
> currently supported by the upsteam Linux kernel.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Looking nice.

> +#define JZ4740_GPIO_DATA       0x10
> +#define JZ4740_GPIO_SELECT     0x50
> +#define JZ4740_GPIO_DIR                0x60
> +#define JZ4740_GPIO_TRIG       0x70
> +#define JZ4740_GPIO_FLAG       0x80
> +
> +#define JZ4780_GPIO_INT                0x10
> +#define JZ4780_GPIO_PAT1       0x30
> +#define JZ4780_GPIO_PAT0       0x40
> +#define JZ4780_GPIO_FLAG       0x50
> +
> +#define REG_SET(x) ((x) + 0x4)
> +#define REG_CLEAR(x) ((x) + 0x8)
(...)
> +enum jz_version {
> +       ID_JZ4740,
> +       ID_JZ4780,
> +};
(...)
> +static inline bool gpio_get_value(struct ingenic_gpio_chip *jzgc, u8 offset)
> +{
> +       if (jzgc->version >= ID_JZ4780)
> +               return readl(jzgc->base + GPIO_PIN) & BIT(offset);
> +       else
> +               return readl(jzgc->base + JZ4740_GPIO_DATA) & BIT(offset);
> +}

This works for me, for sure.

What some people do, is to put the right virtual address in to the state
container.

So it would be just:

return !!readl(jzgc->datareg) & BIT(offset));

Notice also the double-bang that clamps the value to a bool. I know
the core does it too but I like to see it in drivers just to be sure.

> +static void gpio_set_value(struct ingenic_gpio_chip *jzgc, u8 offset, int value)
> +{
> +       u8 reg;
> +
> +       if (jzgc->version >= ID_JZ4780)
> +               reg = JZ4780_GPIO_PAT0;
> +       else
> +               reg = JZ4740_GPIO_DATA;
> +
> +       if (value)
> +               writel(BIT(offset), jzgc->base + REG_SET(reg));
> +       else
> +               writel(BIT(offset), jzgc->base + REG_CLEAR(reg));
> +}

Same comment.

What some drivers do when they just get/set a bit in a register
to get/set or set the direction of a GPIO, is to select GPIO_GENERIC
and just bgpio_init() with the right iomem pointers, then the core
will register handlers for get, set, set_direcition callback and
get_direction and your driver can just focus on the remainders.

> +static void ingenic_gpio_set(struct gpio_chip *gc,
> +               unsigned int offset, int value)
> +{
> +       struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
> +
> +       gpio_set_value(jzgc, offset, value);
> +}
> +
> +static int ingenic_gpio_get(struct gpio_chip *gc, unsigned int offset)
> +{
> +       struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
> +
> +       return (int) gpio_get_value(jzgc, offset);
> +}
> +
> +static int ingenic_gpio_direction_input(struct gpio_chip *gc,
> +               unsigned int offset)
> +{
> +       return pinctrl_gpio_direction_input(gc->base + offset);
> +}
> +
> +static int ingenic_gpio_direction_output(struct gpio_chip *gc,
> +               unsigned int offset, int value)
> +{
> +       ingenic_gpio_set(gc, offset, value);
> +       return pinctrl_gpio_direction_output(gc->base + offset);
> +}

If you're not just replacing these with GPIO_GENERIC, please also
include a .get_direction() callback.

It's especially nice as it reads out the state at probe and "lsgpio"
lists if pins are inputs or outputs.

Yours,
Linus Walleij
