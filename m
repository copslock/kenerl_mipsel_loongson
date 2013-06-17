Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jun 2013 10:51:56 +0200 (CEST)
Received: from mail-ob0-f182.google.com ([209.85.214.182]:40689 "EHLO
        mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824790Ab3FQIvsvDQh9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Jun 2013 10:51:48 +0200
Received: by mail-ob0-f182.google.com with SMTP id va7so2836402obc.41
        for <linux-mips@linux-mips.org>; Mon, 17 Jun 2013 01:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-gm-message-state;
        bh=t6vVCDcT7FfoklSjHy8S5/k6RoXz2LZ35KCeygfy9mE=;
        b=jlctuMCZBczixme+19AjnBlnRCUJqD8CoVYlvIv/74HT93+Xmy8yeeE998OuSlEFZ2
         RiVGsRHeBGZlTjBnUwjgwjhUZDJ2ZtG+xDvgjWMvyyw2RnfZiiHNABTMcXVuV0P4M8NP
         0tU6AmqV8/EvFpluZo+2L7AwbOweItFpkFAUTFfZI24ZT9oqDngWVqur0bmVulBUZJxl
         WrOWz0VqCK8l7Of4ybaD35mdnOJAFLDKPAvqsQc48rDhIiqSOIM/JxYttL2Y80YdXNx7
         hNXbBIIUXj5LBCFpuv3WIp/9N4HRTw4RVcoRn4073+vA5jDNZZSRSKacTiMdgSLvktju
         kHkw==
MIME-Version: 1.0
X-Received: by 10.182.171.74 with SMTP id as10mr8113673obc.70.1371459102718;
 Mon, 17 Jun 2013 01:51:42 -0700 (PDT)
Received: by 10.182.120.7 with HTTP; Mon, 17 Jun 2013 01:51:42 -0700 (PDT)
In-Reply-To: <1371251915-18271-1-git-send-email-ddaney.cavm@gmail.com>
References: <1371251915-18271-1-git-send-email-ddaney.cavm@gmail.com>
Date:   Mon, 17 Jun 2013 10:51:42 +0200
Message-ID: <CACRpkdYHzBBbPNujYRGkMFGuQRzeYKs9jgfc3e3HWyxQFahvRQ@mail.gmail.com>
Subject: Re: [PATCH] gpio MIPS/OCTEON: Add a driver for OCTEON's on-chip GPIO pins.
From:   Linus Walleij <linus.walleij@linaro.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Grant Likely <grant.likely@linaro.org>,
        Rob Herring <rob.herring@calxeda.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree-discuss@lists.ozlabs.org" 
        <devicetree-discuss@lists.ozlabs.org>,
        David Daney <david.daney@cavium.com>
Content-Type: text/plain; charset=ISO-8859-1
X-Gm-Message-State: ALoCoQmSIlCYfCvZIDO9oUCsCZAs4705e0iCtx4PwsE9Kgqc5ecJKYqqcR3Wu1zTIz5KsAW64X/2
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36938
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

On Sat, Jun 15, 2013 at 1:18 AM, David Daney <ddaney.cavm@gmail.com> wrote:

> From: David Daney <david.daney@cavium.com>
>
> The SOCs in the OCTEON family have 16 (or in some cases 20) on-chip
> GPIO pins, this driver handles them all.  Configuring the pins as
> interrupt sources is handled elsewhere (OCTEON's irq handling code).
>
> Signed-off-by: David Daney <david.daney@cavium.com>

> This patch depends somewhat on patches in Ralf's MIPS/Linux -next tree
> where we have patches that enable the Kconfig CAVIUM_OCTEON_SOC and
> ARCH_REQUIRE_GPIOLIB symbols.  Apart from that it is stand-alone and
> is probably suitable for merging via the GPIO tree.

Really? You're using this:

+#include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-gpio-defs.h>

I cannot find this in my tree.

Further I ask why that second file is not part of *this* patch?
It surely seems GPIO-related, and would probably need to
go into include/linux/platform_data/gpio-octeon.h or something
rather than such platform dirs.

(...)
> +config GPIO_OCTEON
> +       tristate "Cavium OCTEON GPIO"
> +       depends on GPIOLIB && CAVIUM_OCTEON_SOC

depend on OF as well right? Or does the CAVIUM_OCTEON_SOC already
imply that?

(...)
> +++ b/drivers/gpio/gpio-octeon.c


> +#define RX_DAT 0x80
> +#define TX_SET 0x88
> +#define TX_CLEAR 0x90


> +/*
> + * The address offset of the GPIO configuration register for a given
> + * line.
> + */
> +static unsigned int bit_cfg_reg(unsigned int gpio)
+       default y
+       help
+         Say yes here to support the on-chip GPIO lines on the OCTEON
+         family of SOCs.
+

Maybe the passed variable shall be named "offset" here, as it is named
offset on all call sites, and it surely local for this instance?

> +{
> +       if (gpio < 16)
> +               return 8 * gpio;
> +       else
> +               return 8 * (gpio - 16) + 0x100;

Put this 0x100 in the #defines above with the name something like
STRIDE.

> +struct octeon_gpio {
> +       struct gpio_chip chip;
> +       u64 register_base;
> +};

OMG everything is 64 bit. Well has to come to this I guess.

> +static void octeon_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
> +{
> +       struct octeon_gpio *gpio = container_of(chip, struct octeon_gpio, chip);
> +       u64 mask = 1ull << offset;

And now BIT(offset) does not work anymore because it is defined as
#define BIT(nr)                 (1UL << (nr))
OK we will have to live with this FTM I guess.

> +static int octeon_gpio_dir_out(struct gpio_chip *chip, unsigned offset,
> +                              int value)
> +{
> +       struct octeon_gpio *gpio = container_of(chip, struct octeon_gpio, chip);
> +       union cvmx_gpio_bit_cfgx cfgx;
> +
> +       octeon_gpio_set(chip, offset, value);
> +
> +       cfgx.u64 = 0;
> +       cfgx.s.tx_oe = 1;

This makes me want to review that magic header file of yours,
I guess this comes from <asm/octeon/cvmx-gpio-defs.h>?

Should not this latter variable be a bool?

I'm not a fan of packed bitfields like this, I prefer if you just
OR | and AND & the bits together in the driver.

> +static int octeon_gpio_get(struct gpio_chip *chip, unsigned offset)
> +{
> +       struct octeon_gpio *gpio = container_of(chip, struct octeon_gpio, chip);
> +       u64 read_bits = cvmx_read_csr(gpio->register_base + RX_DAT);
> +
> +       return ((1ull << offset) & read_bits) != 0;

A common idiom we use for this is:

return !!(read_bits & (1ull << offset));

> +       pdev->dev.platform_data = chip;
> +       chip->label = "octeon-gpio";
> +       chip->dev = &pdev->dev;
> +       chip->owner = THIS_MODULE;
> +       chip->base = 0;
> +       chip->can_sleep = 0;
> +       chip->ngpio = 20;
> +       chip->direction_input = octeon_gpio_dir_in;
> +       chip->get = octeon_gpio_get;
> +       chip->direction_output = octeon_gpio_dir_out;
> +       chip->set = octeon_gpio_set;
> +       err = gpiochip_add(chip);
> +       if (err)
> +               goto out;
> +
> +       dev_info(&pdev->dev, "OCTEON GPIO\n");

This is like shouting "REAL MADRID!" in the bootlog, be a bit more
precise: "octeon GPIO driver probed\n" or something so we know what
is happening.

Yours,
Linus Walleij
