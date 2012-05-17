Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 May 2012 20:35:13 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:54768 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903643Ab2EQSfH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 May 2012 20:35:07 +0200
Received: by pbbrq13 with SMTP id rq13so3291819pbb.36
        for <linux-mips@linux-mips.org>; Thu, 17 May 2012 11:35:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:subject:to:cc:in-reply-to:references:date:message-id
         :x-gm-message-state;
        bh=C0jSnE60lkoYRkDdM99XFrSNlrwoKOu2v9Zq39vXvbU=;
        b=Y/TaSyxEVbtE2dMwY4jCMVWwhcVISLxurfW+EYUA/4n+/8Jflv0ZcXsDbJfPThMMXQ
         aBqW92rKxXS6TzyaCVWfF7BTZoT5NnnQzO3CuaIoCTLAeotNfAnmc/yAv2bhRi0eDCI+
         O/YR7CxIxoeqofFUBBzGcOZn1Z1l5k0NQI30MxHeKikk+8PqtAi/6k6ClgFQPZ7OnZ0e
         SuhJHoIgOu3DpBe8mWDwLD0DVRcmV7sK7ckb7y+3X4YDw/wJ7sjga+6ngM/6lRc+WQ58
         8YXVU2fg9oUlUXldHLESJ0+GOTWliTJpNwDl6e5g4Kv2RobBt8ns+lmJO/PQjFM+Vfue
         5z0w==
Received: by 10.68.230.68 with SMTP id sw4mr3899828pbc.142.1337279701226;
        Thu, 17 May 2012 11:35:01 -0700 (PDT)
Received: from localhost (S0106d8b37715ee14.cg.shawcable.net. [68.146.14.168])
        by mx.google.com with ESMTPS id gl5sm9079082pbc.58.2012.05.17.11.35.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 May 2012 11:35:00 -0700 (PDT)
Received: by localhost (Postfix, from userid 1000)
        id 9C9B83E0621; Thu, 17 May 2012 12:34:59 -0600 (MDT)
From:   Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH V3 2/3] GPIO: MIPS: lantiq: convert gpio-mm-lantiq to OF and of_mm_gpio
To:     John Crispin <blogic@openwrt.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1337201394-11431-2-git-send-email-blogic@openwrt.org>
References: <1337201394-11431-1-git-send-email-blogic@openwrt.org> <1337201394-11431-2-git-send-email-blogic@openwrt.org>
Date:   Thu, 17 May 2012 12:34:59 -0600
Message-Id: <20120517183459.9C9B83E0621@localhost>
X-Gm-Message-State: ALoCoQmz8O9vUkPw+pVoZxH/uzS6Y0M70c2HVBDy5M9dNreDLCXKqCK2i2kwO7VsdKGHRincKfh0
X-archive-position: 33356
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, 16 May 2012 22:49:53 +0200, John Crispin <blogic@openwrt.org> wrote:
> Implements OF support and convert to of_mm_gpio.
> 
> By attaching hardware latches to the External Bus Unit (EBU) on Lantiq SoC, it
> is possible to create output only gpios. This driver configures a special
> memory address, which when written to, outputs 16 bit to the latches.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: linux-kernel@vger.kernel.org

Ummm...

Acked-by: Grant Likely <grant.likely@secretlab.ca>

... but there are comments below that should be addressed before
merging.

Also this patch conflates a lot of changes that should be in
separate patches.  It's a lot easier to review discrete changes
instead of a bunch of stuff lumped together.  It's just a device
driver and the code is better after the patch so I'm not going to make
a big deal about it.

g.

> ---
> This patch is part of a series moving the mips/lantiq target to OF and clkdev
> support. The patch, once Acked, should go upstream via Ralf's MIPS tree.
> 
>  drivers/gpio/gpio-mm-lantiq.c |  147 +++++++++++++++++++++++++----------------
>  1 files changed, 89 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-mm-lantiq.c b/drivers/gpio/gpio-mm-lantiq.c
> index b91c7f1..9296801 100644
> --- a/drivers/gpio/gpio-mm-lantiq.c
> +++ b/drivers/gpio/gpio-mm-lantiq.c
> @@ -3,16 +3,18 @@
>   *  under the terms of the GNU General Public License version 2 as published
>   *  by the Free Software Foundation.
>   *
> - *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
> + *  Copyright (C) 2012 John Crispin <blogic@openwrt.org>
>   */
>  
>  #include <linux/init.h>
> -#include <linux/export.h>
> +#include <linux/module.h>
>  #include <linux/types.h>
>  #include <linux/platform_device.h>
>  #include <linux/mutex.h>
> -#include <linux/gpio.h>

Why is include/gpio.h being dropped?  This file uses that header.
Depending on another include file using it isn't recommended.

> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
>  #include <linux/io.h>
> +#include <linux/slab.h>
>  
>  #include <lantiq_soc.h>
>  
> @@ -25,102 +27,131 @@
>  #define LTQ_EBU_BUSCON	0x1e7ff		/* 16 bit access, slowest timing */
>  #define LTQ_EBU_WP	0x80000000	/* write protect bit */
>  
> -/* we keep a shadow value of the last value written to the ebu */
> -static int ltq_ebu_gpio_shadow = 0x0;
> -static void __iomem *ltq_ebu_gpio_membase;
> +struct ltq_mm {
> +	struct of_mm_gpio_chip mmchip;
> +	u16 shadow;	/* shadow the latches state */
> +};
>  
> -static void ltq_ebu_apply(void)
> +/*
> + * ltq_mm_apply - write the shadow value to the ebu address.

nit: Kerneldoc format should be:

/**
 * ltq_mm_apply() - write the shadow value to the ebu address.

See Documentation/kernel-doc-nano-HOWTO.txt

> + * @chip:     Pointer to our private data structure.
> + *
> + * Write the shadow value to the EBU to set the gpios. We need to set the
> + * global EBU lock to make sure that PCI/MTD dont break.
> + */
> +static void ltq_mm_apply(struct ltq_mm *chip)
>  {
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&ebu_lock, flags);
>  	ltq_ebu_w32(LTQ_EBU_BUSCON, LTQ_EBU_BUSCON1);
> -	*((__u16 *)ltq_ebu_gpio_membase) = ltq_ebu_gpio_shadow;
> +	*((__u16 *)chip->mmchip.regs) = chip->shadow;

Nasty casting.

>  	ltq_ebu_w32(LTQ_EBU_BUSCON | LTQ_EBU_WP, LTQ_EBU_BUSCON1);
>  	spin_unlock_irqrestore(&ebu_lock, flags);
>  }
>  
> -static void ltq_ebu_set(struct gpio_chip *chip, unsigned offset, int value)
> +/*
> + * ltq_mm_set - gpio_chip->set - set gpios.
> + * @gc:     Pointer to gpio_chip device structure.
> + * @gpio:   GPIO signal number.
> + * @val:    Value to be written to specified signal.
> + *
> + * Set the shadow value and call ltq_mm_apply.
> + */
> +static void ltq_mm_set(struct gpio_chip *gc, unsigned offset, int value)
>  {
> +	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> +	struct ltq_mm *chip =
> +		container_of(mm_gc, struct ltq_mm, mmchip);
> +
>  	if (value)
> -		ltq_ebu_gpio_shadow |= (1 << offset);
> +		chip->shadow |= (1 << offset);
>  	else
> -		ltq_ebu_gpio_shadow &= ~(1 << offset);
> -	ltq_ebu_apply();
> +		chip->shadow &= ~(1 << offset);
> +	ltq_mm_apply(chip);
>  }
>  
> -static int ltq_ebu_direction_output(struct gpio_chip *chip, unsigned offset,
> -	int value)
> +/*
> + * ltq_mm_dir_out - gpio_chip->dir_out - set gpio direction.
> + * @gc:     Pointer to gpio_chip device structure.
> + * @gpio:   GPIO signal number.
> + * @val:    Value to be written to specified signal.
> + *
> + * Same as ltq_mm_set, always returns 0.
> + */
> +static int ltq_mm_dir_out(struct gpio_chip *gc, unsigned offset, int value)
>  {
> -	ltq_ebu_set(chip, offset, value);
> +	ltq_mm_set(gc, offset, value);
>  
>  	return 0;
>  }
>  
> -static struct gpio_chip ltq_ebu_chip = {
> -	.label = "ltq_ebu",
> -	.direction_output = ltq_ebu_direction_output,
> -	.set = ltq_ebu_set,
> -	.base = 72,
> -	.ngpio = 16,
> -	.can_sleep = 1,
> -	.owner = THIS_MODULE,
> -};
> +/*
> + * ltq_mm_save_regs - Set initial values of GPIO pins
> + * @mm_gc: pointer to memory mapped GPIO chip structure
> + */
> +static void ltq_mm_save_regs(struct of_mm_gpio_chip *mm_gc)
> +{
> +	struct ltq_mm *chip =
> +		container_of(mm_gc, struct ltq_mm, mmchip);
> +
> +	/* tell the ebu controller which memory address we will be using */
> +	ltq_ebu_w32(CPHYSADDR(chip->mmchip.regs) | 0x1, LTQ_EBU_ADDRSEL1);
>  
> -static int ltq_ebu_probe(struct platform_device *pdev)
> +	ltq_mm_apply(chip);
> +}
> +
> +static int ltq_mm_probe(struct platform_device *pdev)
>  {
> -	int ret = 0;
>  	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	struct ltq_mm *chip;
> +	const __be32 *shadow;
> +	int ret = 0;
>  
>  	if (!res) {
>  		dev_err(&pdev->dev, "failed to get memory resource\n");
>  		return -ENOENT;
>  	}
>  
> -	res = devm_request_mem_region(&pdev->dev, res->start,
> -		resource_size(res), dev_name(&pdev->dev));
> -	if (!res) {
> -		dev_err(&pdev->dev, "failed to request memory resource\n");
> -		return -EBUSY;
> -	}
> -
> -	ltq_ebu_gpio_membase = devm_ioremap_nocache(&pdev->dev, res->start,
> -		resource_size(res));
> -	if (!ltq_ebu_gpio_membase) {
> -		dev_err(&pdev->dev, "Failed to ioremap mem region\n");
> +	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
>  		return -ENOMEM;
> -	}
>  
> -	/* grab the default shadow value passed form the platform code */
> -	ltq_ebu_gpio_shadow = (unsigned int) pdev->dev.platform_data;
> +	chip->mmchip.gc.ngpio = 16;
> +	chip->mmchip.gc.label = "gpio-mm-ltq";
> +	chip->mmchip.gc.direction_output = ltq_mm_dir_out;
> +	chip->mmchip.gc.set = ltq_mm_set;
> +	chip->mmchip.save_regs = ltq_mm_save_regs;
>  
> -	/* tell the ebu controller which memory address we will be using */
> -	ltq_ebu_w32(pdev->resource->start | 0x1, LTQ_EBU_ADDRSEL1);
> +	/* store the shadow value if one was passed by the devicetree */
> +	shadow = of_get_property(pdev->dev.of_node, "lantiq,shadow", NULL);
> +	if (shadow)
> +		chip->shadow = *shadow;

Device tree properties are big-endian.  You'll need to use
be32_to_cpu() or of_property_read_u32().

>  
> -	/* write protect the region */
> -	ltq_ebu_w32(LTQ_EBU_BUSCON | LTQ_EBU_WP, LTQ_EBU_BUSCON1);
> -
> -	ret = gpiochip_add(&ltq_ebu_chip);
> -	if (!ret)
> -		ltq_ebu_apply();
> +	ret = of_mm_gpiochip_add(pdev->dev.of_node, &chip->mmchip);
> +	if (ret)
> +		kfree(chip);
>  	return ret;
>  }
>  
> -static struct platform_driver ltq_ebu_driver = {
> -	.probe = ltq_ebu_probe,
> +static const struct of_device_id ltq_mm_match[] = {
> +	{ .compatible = "lantiq,gpio-mm" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, ltq_mm_match);
> +
> +static struct platform_driver ltq_mm_driver = {
> +	.probe = ltq_mm_probe,
>  	.driver = {
> -		.name = "ltq_ebu",
> +		.name = "gpio-mm-ltq",
>  		.owner = THIS_MODULE,
> +		.of_match_table = ltq_mm_match,
>  	},
>  };
>  
> -static int __init ltq_ebu_init(void)
> +static int __init ltq_mm_init(void)
>  {
> -	int ret = platform_driver_register(&ltq_ebu_driver);
> -
> -	if (ret)
> -		pr_info("ltq_ebu : Error registering platfom driver!");
> -	return ret;
> +	return platform_driver_register(&ltq_mm_driver);
>  }
>  
> -postcore_initcall(ltq_ebu_init);
> +subsys_initcall(ltq_mm_init);

Why the change of initcall level?

g.
