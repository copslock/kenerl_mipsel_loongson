Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Feb 2017 15:55:00 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:11892 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993866AbdBNOywI04XI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Feb 2017 15:54:52 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 11F0BE502D61E;
        Tue, 14 Feb 2017 14:54:42 +0000 (GMT)
Received: from [10.80.2.5] (10.80.2.5) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 14 Feb
 2017 14:54:44 +0000
Subject: Re: [PATCH 1/2] pwm: loongson1: Add PWM driver for Loongson1 SoC
To:     Yang Ling <gnaygnil@gmail.com>, <thierry.reding@gmail.com>,
        <keguang.zhang@gmail.com>
References: <20170213152801.GA32019@ubuntu>
CC:     <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-mips@linux-mips.org>
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Message-ID: <f27d34d4-b0ac-2fd6-bc75-89a6c913ba3c@imgtec.com>
Date:   Tue, 14 Feb 2017 15:54:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170213152801.GA32019@ubuntu>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56815
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

Hi Yang,


On 13.02.2017 16:28, Yang Ling wrote:
> Add support for the PWM controller present in Loongson1 family of SoCs.
>
> Signed-off-by: Yang Ling <gnaygnil@gmail.com>
> ---
>  drivers/pwm/Kconfig         |   9 +++
>  drivers/pwm/Makefile        |   1 +
>  drivers/pwm/pwm-loongson1.c | 169 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 179 insertions(+)
>  create mode 100644 drivers/pwm/pwm-loongson1.c
>
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index f92dd41..985f2fe 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -216,6 +216,15 @@ config PWM_JZ4740
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-jz4740.
>
> +config PWM_LOONGSON1
> +	tristate "Loongson1 PWM support"
> +	depends on MACH_LOONGSON32
> +	help
> +	  Generic PWM framework driver for Loongson1 based machines.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-loongson1.
> +
>  config PWM_LP3943
>  	tristate "TI/National Semiconductor LP3943 PWM support"
>  	depends on MFD_LP3943
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index a48bdb5..1979453 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -19,6 +19,7 @@ obj-$(CONFIG_PWM_HIBVT)		+= pwm-hibvt.o
>  obj-$(CONFIG_PWM_IMG)		+= pwm-img.o
>  obj-$(CONFIG_PWM_IMX)		+= pwm-imx.o
>  obj-$(CONFIG_PWM_JZ4740)	+= pwm-jz4740.o
> +obj-$(CONFIG_PWM_LOONGSON1)	+= pwm-loongson1.o
>  obj-$(CONFIG_PWM_LP3943)	+= pwm-lp3943.o
>  obj-$(CONFIG_PWM_LPC18XX_SCT)	+= pwm-lpc18xx-sct.o
>  obj-$(CONFIG_PWM_LPC32XX)	+= pwm-lpc32xx.o
> diff --git a/drivers/pwm/pwm-loongson1.c b/drivers/pwm/pwm-loongson1.c
> new file mode 100644
> index 0000000..72e3fe3
> --- /dev/null
> +++ b/drivers/pwm/pwm-loongson1.c
> @@ -0,0 +1,169 @@
> +/*
> + * Copyright (c) 2017 Yang Ling <gnaygnil@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or (at your
> + * option) any later version.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <loongson1.h>
> +
> +struct ls1x_pwm_chip {
> +	struct clk *clk;
> +	void __iomem *base;
> +	struct pwm_chip chip;
> +};
> +
> +struct ls1x_pwm_channel {
> +	u32 period_ns;
> +	u32 duty_ns;
> +};
> +static inline struct ls1x_pwm_chip *to_ls1x_pwm_chip(struct pwm_chip *chip)
> +{
> +	return container_of(chip, struct ls1x_pwm_chip, chip);
> +}
> +
> +static int ls1x_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct ls1x_pwm_channel *chan = NULL;
> +
> +	chan = devm_kzalloc(chip->dev, sizeof(*chan), GFP_KERNEL);
> +	if (!chan)
> +		return -ENOMEM;
> +
> +	pwm_set_chip_data(pwm, chan);
> +
> +	return 0;
> +}
> +
> +static void ls1x_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	devm_kfree(chip->dev, pwm_get_chip_data(pwm));
> +	pwm_set_chip_data(pwm, NULL);
> +}
> +

Period and duty are stored in the pwm_device already, so you're just 
duplicating the same data here. If you remove ls1x_pwm_channel then all 
of the code above becomes unnecessary ...

> +static int ls1x_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> +			int duty_ns, int period_ns)
> +{
> +	struct ls1x_pwm_chip *pc = to_ls1x_pwm_chip(chip);
> +	struct ls1x_pwm_channel *chan = pwm_get_chip_data(pwm);
> +	unsigned long long tmp;
> +	unsigned long period, duty;
> +
> +	if (period_ns == chan->period_ns && duty_ns == chan->duty_ns)
> +		return 0;
> +

above check is already handled in pwm core

> +	tmp = (unsigned long long)clk_get_rate(pc->clk) * period_ns;
> +	do_div(tmp, 1000000000);
> +	period = tmp;
> +
> +	tmp = (unsigned long long)period * duty_ns;
> +	do_div(tmp, period_ns);
> +	duty = period - tmp;
> +
> +	if (duty >= period)
> +		duty = period - 1;
> +
> +	if (duty >> 24 || period >> 24)
> +		return -EINVAL;
> +
> +	chan->period_ns = period_ns;
> +	chan->duty_ns = duty_ns;
> +
> +	writel(duty, pc->base + PWM_HRC(pwm->hwpwm));
> +	writel(period, pc->base + PWM_LRC(pwm->hwpwm));
> +	writel(0x00, pc->base + PWM_CNT(pwm->hwpwm));
> +

PWM_HRC and PWM_LRC names suggest that you're using high/low state 
counters here rather than duty/period - but with no documentation I'm 
just guessing here.

> +	return 0;
> +}
> +
> +static int ls1x_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct ls1x_pwm_chip *pc = to_ls1x_pwm_chip(chip);
> +
> +	writel(CNT_RST, pc->base + PWM_CTRL(pwm->hwpwm));
> +	writel(CNT_EN, pc->base + PWM_CTRL(pwm->hwpwm));
> +
> +	return 0;
> +}
> +
> +static void ls1x_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct ls1x_pwm_chip *pc = to_ls1x_pwm_chip(chip);
> +
> +	writel(PWM_OE, pc->base + PWM_CTRL(pwm->hwpwm));
> +}
> +
> +static const struct pwm_ops ls1x_pwm_ops = {
> +	.request = ls1x_pwm_request,
> +	.free = ls1x_pwm_free,
> +	.config = ls1x_pwm_config,
> +	.enable = ls1x_pwm_enable,
> +	.disable = ls1x_pwm_disable,
> +	.owner = THIS_MODULE,
> +};
> +
> +static int ls1x_pwm_probe(struct platform_device *pdev)
> +{
> +	struct ls1x_pwm_chip *pc = NULL;
> +	struct resource *res = NULL;
> +
> +	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
> +	if (!pc)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	pc->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(pc->base))
> +		return PTR_ERR(pc->base);
> +
> +	pc->clk = devm_clk_get(&pdev->dev, "ls1x-pwmtimer");
> +	if (IS_ERR(pc->clk)) {
> +		dev_err(&pdev->dev, "failed to get %s clock\n", pdev->name);
> +		return PTR_ERR(pc->clk);
> +	}
> +	clk_prepare_enable(pc->clk);

Should check for errors here

> +	pc->chip.ops = &ls1x_pwm_ops;
> +	pc->chip.dev = &pdev->dev;
> +	pc->chip.base = -1;
> +	pc->chip.npwm = 4;
> +
> +	platform_set_drvdata(pdev, pc);
> +
> +	return pwmchip_add(&pc->chip);

Should check for errors (and disable clk appropriately)

> +}
> +
> +static int ls1x_pwm_remove(struct platform_device *pdev)
> +{
> +	struct ls1x_pwm_chip *pc = platform_get_drvdata(pdev);
> +	int ret;
> +
> +	ret = pwmchip_remove(&pc->chip);
> +	if (ret < 0)
> +		return ret;
> +
> +	clk_disable_unprepare(pc->clk);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver ls1x_pwm_driver = {
> +	.driver = {
> +		.name = "ls1x-pwm",
> +	},
> +	.probe = ls1x_pwm_probe,
> +	.remove = ls1x_pwm_remove,
> +};
> +module_platform_driver(ls1x_pwm_driver);
> +
> +MODULE_AUTHOR("Yang Ling <gnaygnil@gmail.com>");
> +MODULE_DESCRIPTION("Loongson1 PWM driver");
> +MODULE_ALIAS("platform:loongson1-pwm");
> +MODULE_LICENSE("GPL");
>


Best regards,
Marcin
