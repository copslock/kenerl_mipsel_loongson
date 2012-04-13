Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Apr 2012 11:58:42 +0200 (CEST)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:42580 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903545Ab2DMJ60 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Apr 2012 11:58:26 +0200
Received: by bkcjk13 with SMTP id jk13so2979716bkc.36
        for <multiple recipients>; Fri, 13 Apr 2012 02:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:organization:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=4naVc57H8A5kH4y+wM1xfe2QsW19NrYUEepX5yP91Bk=;
        b=Y28mBVMxortpzYSk09dgPFQ52Tn4tDiMwyULZArwYcp1E4uQiwj/Qs32YKUDSufeH/
         TXtMy/OYh/ULrX1BH7AcfauHPGOo23M9UxN/TqifyJ4FYKHGC19GACZGk5lXpOOf2oEP
         o4E4TZo35SBELYMBUt3XovR+Tb5Xesj+hLOqhgSl52F13XUJxYG+EKsq7g2y4N1k6rnG
         mM8CZOOu+rJTcGkf5CfE1apD6WHN5n019MU/TH/SKCNSJ2r0BS8SSI6Ixqm5/XZKuR0i
         KLKB+/ZCHMybyuncdLA+OkPSG7svfzjyHijReWcVopDnW4oHnKK7mrtYfxntm2JlBQHp
         FK8A==
Received: by 10.205.139.67 with SMTP id iv3mr316028bkc.8.1334311100131;
        Fri, 13 Apr 2012 02:58:20 -0700 (PDT)
Received: from [192.168.108.37] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by mx.google.com with ESMTPS id z17sm15630817bkw.12.2012.04.13.02.58.17
        (version=SSLv3 cipher=OTHER);
        Fri, 13 Apr 2012 02:58:18 -0700 (PDT)
Message-ID: <4F87F868.1080804@openwrt.org>
Date:   Fri, 13 Apr 2012 11:56:56 +0200
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120329 Thunderbird/11.0.1
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     Grant Likely <grant.likely@secretlab.ca>, ralf@linux-mips.org,
        linux-mips@linux-mips.org,
        Linus Walleij <linus.walleij@stericsson.com>,
        Rob Herring <rob.herring@calxeda.com>,
        devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 2/2] gpio/MIPS/OCTEON: Add a driver for OCTEON's on-chip
 GPIO pins.
References: <1334275820-7791-1-git-send-email-ddaney.cavm@gmail.com> <1334275820-7791-3-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1334275820-7791-3-git-send-email-ddaney.cavm@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-archive-position: 32940
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi David,

Le 04/13/12 02:10, David Daney a écrit :
> From: David Daney<david.daney@cavium.com>
>
> The SOCs in the OCTEON family have 16 (or in some cases 20) on-chip
> GPIO pins, this driver handles them all.  Configuring the pins as
> interrupt sources is handled elsewhere (OCTEON's irq handling code).
>
> Signed-off-by: David Daney<david.daney@cavium.com>
> ---
>   drivers/gpio/Kconfig       |    8 ++
>   drivers/gpio/Makefile      |    1 +
>   drivers/gpio/gpio-octeon.c |  166 ++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 175 insertions(+), 0 deletions(-)
>   create mode 100644 drivers/gpio/gpio-octeon.c
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index edadbda..d9d924c 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -136,6 +136,14 @@ config GPIO_MXS
>   	select GPIO_GENERIC
>   	select GENERIC_IRQ_CHIP
>
> +config GPIO_OCTEON
> +	tristate "Cavium OCTEON GPIO"
> +	depends on GPIOLIB&&  CPU_CAVIUM_OCTEON
> +	default y
> +	help
> +	  Say yes here to support the on-chip GPIO lines on the OCTEON
> +	  family of SOCs.
> +
>   config GPIO_PL061
>   	bool "PrimeCell PL061 GPIO support"
>   	depends on ARM_AMBA
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index 007f54b..ce0348c 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -37,6 +37,7 @@ obj-$(CONFIG_GPIO_MSM_V2)	+= gpio-msm-v2.o
>   obj-$(CONFIG_GPIO_MXC)		+= gpio-mxc.o
>   obj-$(CONFIG_GPIO_MXS)		+= gpio-mxs.o
>   obj-$(CONFIG_PLAT_NOMADIK)	+= gpio-nomadik.o
> +obj-$(CONFIG_GPIO_OCTEON)	+= gpio-octeon.o
>   obj-$(CONFIG_ARCH_OMAP)		+= gpio-omap.o
>   obj-$(CONFIG_GPIO_PCA953X)	+= gpio-pca953x.o
>   obj-$(CONFIG_GPIO_PCF857X)	+= gpio-pcf857x.o
> diff --git a/drivers/gpio/gpio-octeon.c b/drivers/gpio/gpio-octeon.c
> new file mode 100644
> index 0000000..e679b44
> --- /dev/null
> +++ b/drivers/gpio/gpio-octeon.c
> @@ -0,0 +1,166 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 2011,2012 Cavium Inc.
> + */
> +
> +#include<linux/platform_device.h>
> +#include<linux/kernel.h>
> +#include<linux/module.h>
> +#include<linux/gpio.h>
> +#include<linux/io.h>
> +
> +#include<asm/octeon/octeon.h>
> +#include<asm/octeon/cvmx-gpio-defs.h>
> +
> +#define DRV_VERSION "1.0"
> +#define DRV_DESCRIPTION "Cavium Inc. OCTEON GPIO Driver"
> +
> +#define RX_DAT 0x80
> +#define TX_SET 0x88
> +#define TX_CLEAR 0x90
> +/*
> + * The address offset of the GPIO configuration register for a given
> + * line.
> + */
> +static unsigned int bit_cfg_reg(unsigned int gpio)
> +{
> +	if (gpio<  16)
> +		return 8 * gpio;
> +	else
> +		return 8 * (gpio - 16) + 0x100;
> +}

You could explicitely inline this one, though the compiler will 
certainly do it by itself.

> +
> +struct octeon_gpio {
> +	struct gpio_chip chip;
> +	u64 register_base;
> +};
> +
> +static int octeon_gpio_dir_in(struct gpio_chip *chip, unsigned offset)
> +{
> +	struct octeon_gpio *gpio = container_of(chip, struct octeon_gpio, chip);
> +
> +	cvmx_write_csr(gpio->register_base + bit_cfg_reg(offset), 0);
> +	return 0;
> +}
> +
> +static void octeon_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
> +{
> +	struct octeon_gpio *gpio = container_of(chip, struct octeon_gpio, chip);
> +	u64 mask = 1ull<<  offset;
> +	u64 reg = gpio->register_base + (value ? TX_SET : TX_CLEAR);
> +	cvmx_write_csr(reg, mask);
> +}
> +
> +static int octeon_gpio_dir_out(struct gpio_chip *chip, unsigned offset,
> +			       int value)
> +{
> +	struct octeon_gpio *gpio = container_of(chip, struct octeon_gpio, chip);
> +	union cvmx_gpio_bit_cfgx cfgx;
> +
> +
> +	octeon_gpio_set(chip, offset, value);
> +
> +	cfgx.u64 = 0;
> +	cfgx.s.tx_oe = 1;
> +
> +	cvmx_write_csr(gpio->register_base + bit_cfg_reg(offset), cfgx.u64);
> +	return 0;
> +}
> +
> +static int octeon_gpio_get(struct gpio_chip *chip, unsigned offset)
> +{
> +	struct octeon_gpio *gpio = container_of(chip, struct octeon_gpio, chip);
> +	u64 read_bits = cvmx_read_csr(gpio->register_base + RX_DAT);
> +
> +	return ((1ull<<  offset)&  read_bits) != 0;
> +}
> +
> +static int __init octeon_gpio_probe(struct platform_device *pdev)
> +{
> +	struct octeon_gpio *gpio;
> +	struct gpio_chip *chip;
> +	struct resource *res_mem;
> +	int err = 0;
> +
> +	gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
> +	if (!gpio)
> +		return -ENOMEM;
> +	chip =&gpio->chip;
> +
> +	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (res_mem == NULL) {
> +		dev_err(&pdev->dev, "found no memory resource\n");
> +		err = -ENXIO;
> +		goto out;
> +	}
> +	if (!devm_request_mem_region(&pdev->dev, res_mem->start,
> +					resource_size(res_mem),
> +				     res_mem->name)) {
> +		dev_err(&pdev->dev, "request_mem_region failed\n");
> +		err = -ENXIO;
> +		goto out;
> +	}
> +	gpio->register_base = (u64)devm_ioremap(&pdev->dev, res_mem->start,
> +						resource_size(res_mem));
> +
> +
> +	pdev->dev.platform_data = chip;
> +	chip->label = "octeon-gpio";
> +	chip->dev =&pdev->dev;
> +	chip->owner = THIS_MODULE;
> +	chip->base = 0;
> +	chip->can_sleep = 0;
> +
> +	if (OCTEON_IS_MODEL(OCTEON_CN66XX) ||
> +	    OCTEON_IS_MODEL(OCTEON_CN61XX) ||
> +	    OCTEON_IS_MODEL(OCTEON_CNF71XX))
> +		chip->ngpio = 20;
> +	else
> +		chip->ngpio = 16;

What about getting the number of gpios from platform_data and/or device 
tree?

> +
> +	chip->direction_input = octeon_gpio_dir_in;
> +	chip->get = octeon_gpio_get;
> +	chip->direction_output = octeon_gpio_dir_out;
> +	chip->set = octeon_gpio_set;
> +	err = gpiochip_add(chip);
> +	if (err)
> +		goto out;
> +
> +	dev_info(&pdev->dev, "version: " DRV_VERSION "\n");
> +out:
> +	return err;
> +}
> +
> +static int __exit octeon_gpio_remove(struct platform_device *pdev)
> +{
> +	struct gpio_chip *chip = pdev->dev.platform_data;
> +	return gpiochip_remove(chip);
> +}
> +
> +static struct of_device_id octeon_gpio_match[] = {
> +	{
> +		.compatible = "cavium,octeon-3860-gpio",
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, octeon_mgmt_match);

You are using linux/of.h definitions here but you did not include it. 
Also, there is a typo, you want octeon_gpio_match instead.

> +
> +static struct platform_driver octeon_gpio_driver = {
> +	.driver = {
> +		.name		= "octeon_gpio",
> +		.owner		= THIS_MODULE,
> +		.of_match_table = octeon_gpio_match,
> +	},
> +	.probe		= octeon_gpio_probe,
> +	.remove		= __exit_p(octeon_gpio_remove),
> +};
> +
> +module_platform_driver(octeon_gpio_driver);
> +
> +MODULE_DESCRIPTION(DRV_DESCRIPTION);
> +MODULE_AUTHOR("David Daney");
> +MODULE_LICENSE("GPL");
> +MODULE_VERSION(DRV_VERSION);
