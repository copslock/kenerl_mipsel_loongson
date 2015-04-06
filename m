Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Apr 2015 12:14:05 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:32901 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009842AbbDFKOD2HLmu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Apr 2015 12:14:03 +0200
Received: by lbbzk7 with SMTP id zk7so16806440lbb.0;
        Mon, 06 Apr 2015 03:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ZIkSgt8QM467LSjQifS7R2EID0jslFft+YDE70Ing+U=;
        b=gPScU2bhVpI8wNpEWJDM3YhpTNRjkQTQn2SzOXaaaRbgFGZ8FWckBFaUK+bKuDH1X4
         UFxUCwGgL3C563iNEhyYV0+XBDjpirs+Xf8rC276GRAq87fY+xcez0ybhzdpi1zi7xo2
         KoT8uzTc0SkTv54pw+HyndHhXxDzO48pggLLPGWFt1cyBX5wmZi5gW1VKC7+y2duzYcl
         eH+vdED7yjXw2XFNWoDrZzSAr7GMT0x3vtH6PtUuyIukduUs7hvgOF3+VznzPLHN1MW0
         SU9P5BMRDVD1ia1CtkXRomPdyp/pSEac0XdFan9OA4cExadk//1CijmssiwE92+FJRZl
         qxTg==
MIME-Version: 1.0
X-Received: by 10.112.51.138 with SMTP id k10mr12933467lbo.82.1428315239279;
 Mon, 06 Apr 2015 03:13:59 -0700 (PDT)
Received: by 10.25.23.157 with HTTP; Mon, 6 Apr 2015 03:13:59 -0700 (PDT)
In-Reply-To: <1428285076-14269-1-git-send-email-bert@biot.com>
References: <1428285076-14269-1-git-send-email-bert@biot.com>
Date:   Mon, 6 Apr 2015 13:13:59 +0300
Message-ID: <CAHp75VfeY80hu9kZWJ1KPos7gzTgV53OT-X67MJWT2h8nGSjqw@mail.gmail.com>
Subject: Re: [PATCH] mfd: Add support for CPLD chip on Mikrotik RB4xx boards
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Bert Vermeulen <bert@biot.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>, linux-mips@linux-mips.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <andy.shevchenko@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46788
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andy.shevchenko@gmail.com
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

On Mon, Apr 6, 2015 at 4:51 AM, Bert Vermeulen <bert@biot.com> wrote:
> The SPI-connected CPLD chip controls access to the main NAND flash
> chip and five LEDs.
>

Few comments below.

> Signed-off-by: Bert Vermeulen <bert@biot.com>
> ---
>  arch/mips/include/asm/mach-ath79/rb4xx_cpld.h |  49 +++++
>  drivers/mfd/Kconfig                           |   7 +
>  drivers/mfd/Makefile                          |   1 +
>  drivers/mfd/rb4xx-cpld.c                      | 279 ++++++++++++++++++++++++++
>  4 files changed, 336 insertions(+)
>  create mode 100644 arch/mips/include/asm/mach-ath79/rb4xx_cpld.h
>  create mode 100644 drivers/mfd/rb4xx-cpld.c
>
> diff --git a/arch/mips/include/asm/mach-ath79/rb4xx_cpld.h b/arch/mips/include/asm/mach-ath79/rb4xx_cpld.h
> new file mode 100644
> index 0000000..40c109c
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-ath79/rb4xx_cpld.h
> @@ -0,0 +1,49 @@
> +/*
> + * SPI driver definitions for the CPLD chip on the Mikrotik RB4xx boards
> + *
> + * Copyright (C) 2010 Gabor Juhos <juhosg@openwrt.org>
> + *
> + * This file was based on the patches for Linux 2.6.27.39 published by
> + * MikroTik for their RouterBoard 4xx series devices.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation.
> + */
> +
> +#define CPLD_GPIO_LED1         0
> +#define CPLD_GPIO_LED2         1
> +#define CPLD_GPIO_LED3         2
> +#define CPLD_GPIO_LED4         3
> +#define CPLD_GPIO_FAN          4
> +#define CPLD_GPIO_ALE          5
> +#define CPLD_GPIO_CLE          6
> +#define CPLD_GPIO_nCE          7
> +#define CPLD_GPIO_LED5         8
> +
> +#define CPLD_NUM_GPIOS         9
> +
> +#define CPLD_CFG_LED1          BIT(CPLD_GPIO_LED1)
> +#define CPLD_CFG_LED2          BIT(CPLD_GPIO_LED2)
> +#define CPLD_CFG_LED3          BIT(CPLD_GPIO_LED3)
> +#define CPLD_CFG_LED4          BIT(CPLD_GPIO_LED4)
> +#define CPLD_CFG_FAN           BIT(CPLD_GPIO_FAN)
> +#define CPLD_CFG_ALE           BIT(CPLD_GPIO_ALE)
> +#define CPLD_CFG_CLE           BIT(CPLD_GPIO_CLE)
> +#define CPLD_CFG_nCE           BIT(CPLD_GPIO_nCE)
> +#define CPLD_CFG_LED5          BIT(CPLD_GPIO_LED5)
> +
> +#define CPLD_CMD_WRITE_NAND    0x08 /* send cmd, n x send data, send idle */
> +#define CPLD_CMD_WRITE_CFG     0x09 /* send cmd, n x send cfg */
> +#define CPLD_CMD_READ_NAND     0x0a /* send cmd, send idle, n x read data */
> +#define CPLD_CMD_READ_FAST     0x0b /* send cmd, 4 x idle, n x read data */
> +#define CPLD_CMD_LED5_ON       0x0c /* send cmd */
> +#define CPLD_CMD_LED5_OFF      0x0d /* send cmd */
> +
> +struct rb4xx_cpld_platform_data {
> +       unsigned gpio_base;
> +};
> +
> +extern int rb4xx_cpld_read(struct spi_device *spi, unsigned char *rx_buf,
> +                          unsigned len);
> +extern int rb4xx_cpld_write(struct spi_device *spi, const u8 *buf, int len);
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 38356e3..c4a6a4e 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -631,6 +631,13 @@ config MFD_SPMI_PMIC
>           Say M here if you want to include support for the SPMI PMIC
>           series as a module.  The module will be called "qcom-spmi-pmic".
>
> +config MFD_RB4XX_CPLD
> +       tristate "MikroTik RB4XX CPLD driver"
> +       depends on ATH79 && SPI_RB4XX
> +       help
> +         Driver for the CPLD chip present on MikroTik RB4xx boards.
> +         It controls CPU access to NAND flash and user LEDs.
> +
>  config MFD_RDC321X
>         tristate "RDC R-321x southbridge"
>         select MFD_CORE
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 19f3d74..6cc9fe3 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -155,6 +155,7 @@ obj-$(CONFIG_MFD_OMAP_USB_HOST)     += omap-usb-host.o omap-usb-tll.o
>  obj-$(CONFIG_MFD_PM8921_CORE)  += pm8921-core.o ssbi.o
>  obj-$(CONFIG_MFD_QCOM_RPM)     += qcom_rpm.o
>  obj-$(CONFIG_MFD_SPMI_PMIC)    += qcom-spmi-pmic.o
> +obj-$(CONFIG_MFD_RB4XX_CPLD)   += rb4xx-cpld.o
>  obj-$(CONFIG_TPS65911_COMPARATOR)      += tps65911-comparator.o
>  obj-$(CONFIG_MFD_TPS65090)     += tps65090.o
>  obj-$(CONFIG_MFD_AAT2870_CORE) += aat2870-core.o
> diff --git a/drivers/mfd/rb4xx-cpld.c b/drivers/mfd/rb4xx-cpld.c
> new file mode 100644
> index 0000000..0f8de62
> --- /dev/null
> +++ b/drivers/mfd/rb4xx-cpld.c
> @@ -0,0 +1,279 @@
> +/*
> + * SPI driver for the CPLD chip on the Mikrotik RB4xx boards
> + *
> + * Copyright (C) 2010 Gabor Juhos <juhosg@openwrt.org>
> + *
> + * This file was based on the patches for Linux 2.6.27.39 published by
> + * MikroTik for their RouterBoard 4xx series devices.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation.
> + */
> +
> +#include <linux/types.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/bitops.h>
> +#include <linux/spi/spi.h>
> +#include <linux/gpio.h>
> +#include <linux/slab.h>
> +
> +#include <asm/mach-ath79/rb4xx_cpld.h>
> +
> +struct rb4xx_cpld {
> +       struct spi_device *spi;
> +       struct mutex lock;
> +       struct gpio_chip chip;
> +       unsigned int config;
> +};
> +
> +static inline struct rb4xx_cpld *gpio_to_cpld(struct gpio_chip *chip)
> +{
> +       return container_of(chip, struct rb4xx_cpld, chip);
> +}
> +
> +static int rb4xx_cpld_write_cmd(struct rb4xx_cpld *cpld, unsigned char cmd)
> +{
> +       struct spi_transfer t[1];

Just t. And modify below accordingly.

> +       struct spi_message m;
> +       unsigned char tx_buf[1];
> +       int err;
> +
> +       spi_message_init(&m);
> +       memset(&t, 0, sizeof(t));
> +
> +       t[0].tx_buf = tx_buf;
> +       t[0].len = sizeof(tx_buf);
> +       spi_message_add_tail(&t[0], &m);

> +
> +       tx_buf[0] = cmd;
> +
> +       err = spi_sync(cpld->spi, &m);
> +       return err;

There is no point for two lines and err variable.

> +}
> +
> +static int rb4xx_cpld_write_cfg(struct rb4xx_cpld *cpld, unsigned char config)
> +{
> +       struct spi_transfer t[1];

Same as for previous.


> +       struct spi_message m;
> +       unsigned char cmd[2];

Can you keep similar name as in previous function? Either cmd or tx_buf.

> +       int err;
> +
> +       spi_message_init(&m);
> +       memset(&t, 0, sizeof(t));
> +
> +       t[0].tx_buf = cmd;
> +       t[0].len = sizeof(cmd);
> +       spi_message_add_tail(&t[0], &m);
> +
> +       cmd[0] = CPLD_CMD_WRITE_CFG;
> +       cmd[1] = config;
> +
> +       err = spi_sync(cpld->spi, &m);
> +       return err;

Same as for previous.

> +}
> +
> +static int rb4xx_cpld_change_cfg(struct rb4xx_cpld *cpld, u32 mask, u32 value)
> +{
> +       unsigned int config;
> +       int err;
> +
> +       config = cpld->config & ~mask;
> +       config |= value;
> +
> +       if ((cpld->config ^ config) & 0xff) {
> +               err = rb4xx_cpld_write_cfg(cpld, config);
> +               if (err)
> +                       return err;
> +       }
> +
> +       if ((cpld->config ^ config) & CPLD_CFG_LED5) {
> +               err = rb4xx_cpld_write_cmd(cpld, (value) ? CPLD_CMD_LED5_ON :
> +                                                          CPLD_CMD_LED5_OFF);
> +               if (err)
> +                       return err;
> +       }
> +
> +       cpld->config = config;
> +       return 0;
> +}
> +
> +int rb4xx_cpld_read(struct spi_device *spi, unsigned char *rx_buf, unsigned len)
> +{
> +       struct spi_message m;
> +       static const unsigned char cmd[2] = { CPLD_CMD_READ_NAND, 0 };

Why different style of assignment across functions?

> +       struct spi_transfer t[2] = {
> +               {
> +                       .tx_buf = &cmd,
> +                       .len = 2,
> +               }, {
> +                       .rx_buf = rx_buf,
> +                       .len = len,
> +               },
> +       };
> +
> +       spi_message_init(&m);
> +       spi_message_add_tail(&t[0], &m);
> +       spi_message_add_tail(&t[1], &m);
> +       return spi_sync(spi, &m);
> +}
> +EXPORT_SYMBOL_GPL(rb4xx_cpld_read);
> +
> +/* The cs_change flag indicates to the spi-rb4xx driver to use "fast mode". */
> +int rb4xx_cpld_write(struct spi_device *spi, const u8 *buf, int len)
> +{
> +       struct spi_message m;
> +       static const unsigned char cmd = CPLD_CMD_WRITE_NAND;
> +       static const unsigned char dummy = 0x00;
> +       struct spi_transfer t[3] = {
> +               {
> +                       .tx_buf = &cmd,

Ditto.

> +                       .len = 1,
> +               }, {
> +                       .tx_buf = buf,
> +                       .len = len,
> +                       .cs_change = 1,
> +               }, {
> +                       .tx_buf = &dummy,
> +                       .len = 1,
> +                       .cs_change = 1,
> +               },
> +       };
> +
> +       spi_message_init(&m);
> +       spi_message_add_tail(&t[0], &m);
> +       spi_message_add_tail(&t[1], &m);
> +       spi_message_add_tail(&t[2], &m);
> +       return spi_sync(spi, &m);
> +}
> +EXPORT_SYMBOL_GPL(rb4xx_cpld_write);
> +
> +static int rb4xx_cpld_gpio_get(struct gpio_chip *chip, unsigned offset)
> +{
> +       struct rb4xx_cpld *cpld = gpio_to_cpld(chip);
> +       int ret;
> +
> +       mutex_lock(&cpld->lock);
> +       ret = (cpld->config >> offset) & 1;
> +       mutex_unlock(&cpld->lock);
> +
> +       return ret;
> +}
> +
> +static void rb4xx_cpld_gpio_set(struct gpio_chip *chip,
> +                               unsigned offset, int value)
> +{
> +       struct rb4xx_cpld *cpld = gpio_to_cpld(chip);
> +
> +       mutex_lock(&cpld->lock);
> +       rb4xx_cpld_change_cfg(cpld, (1 << offset), !!value << offset);
> +       mutex_unlock(&cpld->lock);
> +}
> +
> +static int rb4xx_cpld_gpio_direction_input(struct gpio_chip *chip,
> +                                          unsigned offset)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +static int rb4xx_cpld_gpio_direction_output(struct gpio_chip *chip,
> +                                           unsigned offset, int value)
> +{
> +       struct rb4xx_cpld *cpld = gpio_to_cpld(chip);
> +       int ret;
> +
> +       mutex_lock(&cpld->lock);
> +       ret = rb4xx_cpld_change_cfg(cpld, (1 << offset), !!value << offset);
> +       mutex_unlock(&cpld->lock);
> +
> +       return ret;
> +}
> +
> +static int rb4xx_cpld_gpio_init(struct rb4xx_cpld *cpld, unsigned int base)
> +{
> +       int err;

In some it is err in other ret. Choose one for all.

> +
> +       cpld->chip.label = "rb4xx-cpld";
> +       cpld->chip.base = base;
> +       cpld->chip.ngpio = CPLD_NUM_GPIOS;
> +       cpld->chip.can_sleep = 1;
> +       cpld->chip.dev = &cpld->spi->dev;

> +       cpld->chip.owner = THIS_MODULE;

Do we really need this?

> +       cpld->chip.get = rb4xx_cpld_gpio_get;
> +       cpld->chip.set = rb4xx_cpld_gpio_set;
> +       cpld->chip.direction_input = rb4xx_cpld_gpio_direction_input;
> +       cpld->chip.direction_output = rb4xx_cpld_gpio_direction_output;
> +
> +       err = gpiochip_add(&cpld->chip);
> +       if (err)
> +               dev_err(&cpld->spi->dev, "adding GPIO chip failed, error %d\n",
> +                       err);
> +
> +       return err;
> +}
> +
> +static int rb4xx_cpld_probe(struct spi_device *spi)
> +{
> +       struct rb4xx_cpld *cpld;
> +       struct rb4xx_cpld_platform_data *pdata;
> +       int err;
> +
> +       pdata = spi->dev.platform_data;

Shouldn't be standard getter for this?

> +       if (!pdata) {
> +               dev_dbg(&spi->dev, "no platform data\n");

It's an error condition for the driver, so, following might help as
well as dev_err() here.

> +               return -EINVAL;

I think -ENODATA suits better.

> +       }
> +
> +       cpld = devm_kzalloc(&spi->dev, sizeof(*cpld), GFP_KERNEL);
> +       if (!cpld)
> +               return -ENOMEM;
> +
> +       mutex_init(&cpld->lock);
> +       cpld->spi = spi_dev_get(spi);
> +       dev_set_drvdata(&spi->dev, cpld);
> +
> +       spi->mode = SPI_MODE_0;
> +       err = spi_setup(spi);
> +       if (err) {
> +               dev_err(&spi->dev, "SPI setup failed, error %d\n", err);
> +               return err;
> +       }
> +
> +       err = rb4xx_cpld_gpio_init(cpld, pdata->gpio_base);
> +       if (err)
> +               return err;
> +
> +       return 0;

Too many lines:
return rb4xx_cpld_gpio_init();

> +}
> +
> +static int rb4xx_cpld_remove(struct spi_device *spi)
> +{
> +       struct rb4xx_cpld_platform_data *pdata;
> +       struct rb4xx_cpld *cpld;
> +
> +       pdata = spi->dev.platform_data;

Same question as for probe.

> +       cpld = dev_get_drvdata(&spi->dev);
> +       mutex_destroy(&cpld->lock);
> +
> +       return 0;
> +}
> +
> +static struct spi_driver rb4xx_cpld_driver = {
> +       .probe = rb4xx_cpld_probe,
> +       .remove = rb4xx_cpld_remove,
> +       .driver = {
> +               .name = "rb4xx-cpld",
> +               .bus = &spi_bus_type,
> +               .owner = THIS_MODULE,

Do we really need this line?

> +       },
> +};
> +
> +module_spi_driver(rb4xx_cpld_driver);
> +
> +MODULE_DESCRIPTION("RB4xx CPLD driver");
> +MODULE_AUTHOR("Gabor Juhos <juhosg@openwrt.org>");
> +MODULE_LICENSE("GPL v2");
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



-- 
With Best Regards,
Andy Shevchenko
