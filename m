Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 May 2012 22:50:58 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:63400 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903711Ab2EQUuy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 May 2012 22:50:54 +0200
Received: by pbbrq13 with SMTP id rq13so3457383pbb.36
        for <linux-mips@linux-mips.org>; Thu, 17 May 2012 13:50:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:subject:to:cc:in-reply-to:references:date:message-id
         :x-gm-message-state;
        bh=noV6x4oBduj+AA48RlCA/tcQGoZKKO+dKyjNQ21WwJM=;
        b=DJL9TaprtzjtFsolW0aEsQdAr7hWk8iw4ZwsUiQ7j7xIru3FXfXvRoCS1SsCcB7j2X
         0aG4UI/dM0rPPQYo6WwH5JuTNzkakj6+82F0HkF7OJN/Ci7u8Pa+p3nb772GAV5gb9OZ
         SrxdaooCl7XRPX1wixrxECrq+vprOptbAZypSB6QZPg2pxt/Q90OcwDEK/fu5YPbGvwv
         /erd7o/gyDV/nTED8xK99IjK5XXoXXliBJtD2V0JaMF7P2JRUwPXzb/SCJa2fPCSge0b
         Gk3WUeFaxVaiRC1axevYaBkv16GC/KouIRpa+txc954E+Rit+Vf+a/LQcMaerdlO+FJf
         eHqA==
Received: by 10.68.240.135 with SMTP id wa7mr31178062pbc.7.1337287847255;
        Thu, 17 May 2012 13:50:47 -0700 (PDT)
Received: from localhost (S0106d8b37715ee14.cg.shawcable.net. [68.146.14.168])
        by mx.google.com with ESMTPS id x1sm10210780pbp.50.2012.05.17.13.50.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 May 2012 13:50:45 -0700 (PDT)
Received: by localhost (Postfix, from userid 1000)
        id 81B1C3E0621; Thu, 17 May 2012 14:50:44 -0600 (MDT)
From:   Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/2] gpio/MIPS/OCTEON: Add a driver for OCTEON's on-chip GPIO pins.
To:     David Daney <ddaney.cavm@gmail.com>, ralf@linux-mips.org,
        linux-mips@linux-mips.org,
        Linus Walleij <linus.walleij@stericsson.com>,
        Rob Herring <rob.herring@calxeda.com>,
        devicetree-discuss@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
In-Reply-To: <1334275820-7791-3-git-send-email-ddaney.cavm@gmail.com>
References: <1334275820-7791-1-git-send-email-ddaney.cavm@gmail.com> <1334275820-7791-3-git-send-email-ddaney.cavm@gmail.com>
Date:   Thu, 17 May 2012 14:50:44 -0600
Message-Id: <20120517205044.81B1C3E0621@localhost>
X-Gm-Message-State: ALoCoQnU5PtarrWfcFiMTJjWFOW6Ld3XcpkvtseLTdTWHsiHlaXKHz/ZTl1Xox+uq1bPRkJT5YQG
X-archive-position: 33358
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thu, 12 Apr 2012 17:10:20 -0700, David Daney <ddaney.cavm@gmail.com> wrote:
> From: David Daney <david.daney@cavium.com>
> 
> The SOCs in the OCTEON family have 16 (or in some cases 20) on-chip
> GPIO pins, this driver handles them all.  Configuring the pins as
> interrupt sources is handled elsewhere (OCTEON's irq handling code).
> 
> Signed-off-by: David Daney <david.daney@cavium.com>

Aside from the bugs already pointed out;

Acked-by: Grant Likely <grant.likely@secretlab.ca>

Will you merge this series via the MIPS tree, or do I need to pick it
up?

> ---
>  drivers/gpio/Kconfig       |    8 ++
>  drivers/gpio/Makefile      |    1 +
>  drivers/gpio/gpio-octeon.c |  166 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 175 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/gpio/gpio-octeon.c
> 
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index edadbda..d9d924c 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -136,6 +136,14 @@ config GPIO_MXS
>  	select GPIO_GENERIC
>  	select GENERIC_IRQ_CHIP
>  
> +config GPIO_OCTEON
> +	tristate "Cavium OCTEON GPIO"
> +	depends on GPIOLIB && CPU_CAVIUM_OCTEON
> +	default y
> +	help
> +	  Say yes here to support the on-chip GPIO lines on the OCTEON
> +	  family of SOCs.
> +
>  config GPIO_PL061
>  	bool "PrimeCell PL061 GPIO support"
>  	depends on ARM_AMBA
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index 007f54b..ce0348c 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -37,6 +37,7 @@ obj-$(CONFIG_GPIO_MSM_V2)	+= gpio-msm-v2.o
>  obj-$(CONFIG_GPIO_MXC)		+= gpio-mxc.o
>  obj-$(CONFIG_GPIO_MXS)		+= gpio-mxs.o
>  obj-$(CONFIG_PLAT_NOMADIK)	+= gpio-nomadik.o
> +obj-$(CONFIG_GPIO_OCTEON)	+= gpio-octeon.o
>  obj-$(CONFIG_ARCH_OMAP)		+= gpio-omap.o
>  obj-$(CONFIG_GPIO_PCA953X)	+= gpio-pca953x.o
>  obj-$(CONFIG_GPIO_PCF857X)	+= gpio-pcf857x.o
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
> +#include <linux/platform_device.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/gpio.h>
> +#include <linux/io.h>
> +
> +#include <asm/octeon/octeon.h>
> +#include <asm/octeon/cvmx-gpio-defs.h>
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
> +	if (gpio < 16)
> +		return 8 * gpio;
> +	else
> +		return 8 * (gpio - 16) + 0x100;
> +}
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
> +	u64 mask = 1ull << offset;
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
> +	return ((1ull << offset) & read_bits) != 0;
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
> +	chip = &gpio->chip;
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
> +	chip->dev = &pdev->dev;
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
> -- 
> 1.7.2.3
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
