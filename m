Return-Path: <SRS0=SfrM=P7=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98353C282C5
	for <linux-mips@archiver.kernel.org>; Wed, 23 Jan 2019 12:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70CE421726
	for <linux-mips@archiver.kernel.org>; Wed, 23 Jan 2019 12:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfAWM7I (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 23 Jan 2019 07:59:08 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35710 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfAWM7I (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 23 Jan 2019 07:59:08 -0500
Received: by mail-oi1-f195.google.com with SMTP id v6so1708262oif.2;
        Wed, 23 Jan 2019 04:59:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XHGy2u/11eXPSFni0sMfXkFaHQdGHE3Q55CE9Ed5d0I=;
        b=U0lD7+n4gI2rK/dKoeC+7YJzsGPRBVOnoOAJ4S6Rw3wfp628/wPIddTYjUJa1gVULa
         ehIrm6DkBqcncmEBoPrp6aG6fzYCOodln5ZinTpEytO2bMraMgOoYpYS/X27qeO1gU/8
         GAi+ZdMF3kZvDUnPXA4P8o+q+Qjhfvng/IUtI7z8j6CEeAj2/R2WggSY4tENeztYBilX
         gnhKTaC/LZXMxXZLXZPBaBPlQ6OZa2o2USMNOSoJKgTRGbLCq3CCy9zB5lDN4jMZl3y9
         Bs9u9dn8ASoMACkqEyo/qSYslMIfjS1IejvIngsCZkBZ8rYf6x4P+zxMm1moX5pjcgSH
         KIZw==
X-Gm-Message-State: AJcUukfAoiv5GuQ7Y1AtPGmaGO9gJegRSKPQhUYUWKrX4+F9v4CcVDbP
        bqHsEwpqcdBIHBlHgPsUFzOK7TBFWUNF7i1Ys78=
X-Google-Smtp-Source: ALg8bN5ZJ5a/qgKbJknBe7SKlbnM+7/Ry9S8WJ6BMwVADrhb9MXe6Rezv8MY1StlcL9OB9BwnkDGsT31CrY1Tja2jao=
X-Received: by 2002:aca:5117:: with SMTP id f23mr1377256oib.72.1548248345676;
 Wed, 23 Jan 2019 04:59:05 -0800 (PST)
MIME-Version: 1.0
References: <20181212220922.18759-1-paul@crapouillou.net> <20181212220922.18759-6-paul@crapouillou.net>
In-Reply-To: <20181212220922.18759-6-paul@crapouillou.net>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Wed, 23 Jan 2019 13:58:53 +0100
Message-ID: <CA+7wUsxNN2SL9_7tDh0DiBAgdUwxd_osgmi=09HP7110Tm0DYQ@mail.gmail.com>
Subject: Re: [PATCH v8 05/26] clocksource: Add driver for the Ingenic JZ47xx OST
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        linux-pwm@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-clk@vger.kernel.org, od@zcrc.me,
        Maarten ter Huurne <maarten@treewalker.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Wed, Dec 12, 2018 at 11:09 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> From: Maarten ter Huurne <maarten@treewalker.org>
>
> OST is the OS Timer, a 64-bit timer/counter with buffered reading.
>
> SoCs before the JZ4770 had (if any) a 32-bit OST; the JZ4770 and
> JZ4780 have a 64-bit OST.
>
> This driver will register both a clocksource and a sched_clock to the
> system.
>
> Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>
> Notes:
>      v5: New patch
>
>      v6: - Get rid of SoC IDs; pass pointer to ingenic_ost_soc_info as
>            devicetree match data instead.
>          - Use device_get_match_data() instead of the of_* variant
>          - Handle error of dev_get_regmap() properly
>
>      v7: Fix section mismatch by using builtin_platform_driver_probe()
>
>      v8: builtin_platform_driver_probe() does not work anymore in
>          4.20-rc6? The probe function won't be called. Work around this
>          for now by using late_initcall.
>
>  drivers/clocksource/Kconfig       |   8 ++
>  drivers/clocksource/Makefile      |   1 +
>  drivers/clocksource/ingenic-ost.c | 215 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 224 insertions(+)
>  create mode 100644 drivers/clocksource/ingenic-ost.c
>
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 4e69af15c3e7..e0646878b0de 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -648,4 +648,12 @@ config INGENIC_TIMER
>         help
>           Support for the timer/counter unit of the Ingenic JZ SoCs.
>
> +config INGENIC_OST
> +       bool "Ingenic JZ47xx Operating System Timer"
> +       depends on MIPS || COMPILE_TEST
> +       depends on COMMON_CLK
> +       select INGENIC_TIMER
> +       help
> +         Support for the OS Timer of the Ingenic JZ4770 or similar SoC.
> +
>  endmenu
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index 7c8f790dcf67..7faa8108574a 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -75,6 +75,7 @@ obj-$(CONFIG_ASM9260_TIMER)           += asm9260_timer.o
>  obj-$(CONFIG_H8300_TMR8)               += h8300_timer8.o
>  obj-$(CONFIG_H8300_TMR16)              += h8300_timer16.o
>  obj-$(CONFIG_H8300_TPU)                        += h8300_tpu.o
> +obj-$(CONFIG_INGENIC_OST)              += ingenic-ost.o
>  obj-$(CONFIG_INGENIC_TIMER)            += ingenic-timer.o
>  obj-$(CONFIG_CLKSRC_ST_LPC)            += clksrc_st_lpc.o
>  obj-$(CONFIG_X86_NUMACHIP)             += numachip.o
> diff --git a/drivers/clocksource/ingenic-ost.c b/drivers/clocksource/ingenic-ost.c
> new file mode 100644
> index 000000000000..cc0fee3efd29
> --- /dev/null
> +++ b/drivers/clocksource/ingenic-ost.c
> @@ -0,0 +1,215 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * JZ47xx SoCs TCU Operating System Timer driver
> + *
> + * Copyright (C) 2016 Maarten ter Huurne <maarten@treewalker.org>
> + * Copyright (C) 2018 Paul Cercueil <paul@crapouillou.net>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clocksource.h>
> +#include <linux/mfd/ingenic-tcu.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm.h>
> +#include <linux/regmap.h>
> +#include <linux/sched_clock.h>
> +
> +#include "ingenic-timer.h"
> +
> +#define TCU_OST_TCSR_MASK      0xc0
> +#define TCU_OST_TCSR_CNT_MD    BIT(15)
> +
> +#define TCU_OST_CHANNEL                15
> +
> +struct ingenic_ost_soc_info {
> +       bool is64bit;
> +};
> +
> +struct ingenic_ost {
> +       struct regmap *map;
> +       struct clk *clk;
> +
> +       struct clocksource cs;
> +};
> +
> +static u64 notrace ingenic_ost_read_cntl(void)
> +{
> +       /* Bypass the regmap here as we must return as soon as possible */
> +       return readl(ingenic_tcu_base + TCU_REG_OST_CNTL);
> +}
> +
> +static u64 notrace ingenic_ost_read_cnth(void)
> +{
> +       /* Bypass the regmap here as we must return as soon as possible */
> +       return readl(ingenic_tcu_base + TCU_REG_OST_CNTH);
> +}
> +
> +static u64 notrace ingenic_ost_clocksource_read(struct clocksource *cs)
> +{
> +       u32 val1, val2;
> +       u64 count, recount;
> +       s64 diff;
> +
> +       /*
> +        * The buffering of the upper 32 bits of the timer prevents wrong
> +        * results from the bottom 32 bits overflowing due to the timer ticking
> +        * along. However, it does not prevent wrong results from simultaneous
> +        * reads of the timer, which could reset the buffer mid-read.
> +        * Since this kind of wrong read can happen only when the bottom bits
> +        * overflow, there will be minutes between wrong reads, so if we read
> +        * twice in succession, at least one of the reads will be correct.
> +        */
> +
> +       /* Bypass the regmap here as we must return as soon as possible */
> +       val1 = readl(ingenic_tcu_base + TCU_REG_OST_CNTL);
> +       val2 = readl(ingenic_tcu_base + TCU_REG_OST_CNTHBUF);
> +       count = (u64)val1 | (u64)val2 << 32;
> +
> +       val1 = readl(ingenic_tcu_base + TCU_REG_OST_CNTL);
> +       val2 = readl(ingenic_tcu_base + TCU_REG_OST_CNTHBUF);
> +       recount = (u64)val1 | (u64)val2 << 32;
> +
> +       /*
> +        * A wrong read will produce a result that is 1<<32 too high: the bottom
> +        * part from before overflow and the upper part from after overflow.
> +        * Therefore, the lower value of the two reads is the correct value.
> +        */
> +
> +       diff = (s64)(recount - count);
> +       if (unlikely(diff < 0))
> +               count = recount;
> +
> +       return count;
> +}
> +
> +static int __init ingenic_ost_probe(struct platform_device *pdev)
> +{
> +       const struct ingenic_ost_soc_info *soc_info;
> +       struct device *dev = &pdev->dev;
> +       struct ingenic_ost *ost;
> +       struct clocksource *cs;
> +       unsigned long rate, flags;
> +       int err;
> +
> +       soc_info = device_get_match_data(dev);
> +       if (!soc_info)
> +               return -EINVAL;
> +
> +       ost = devm_kzalloc(dev, sizeof(*ost), GFP_KERNEL);
> +       if (!ost)
> +               return -ENOMEM;
> +
> +       ost->map = dev_get_regmap(dev->parent, NULL);
> +       if (!ost->map) {
> +               dev_err(dev, "regmap not found\n");
> +               return -EINVAL;
> +       }
> +
> +       ost->clk = devm_clk_get(dev, "ost");
> +       if (IS_ERR(ost->clk))
> +               return PTR_ERR(ost->clk);
> +
> +       err = clk_prepare_enable(ost->clk);
> +       if (err)
> +               return err;
> +
> +       /* Clear counter high/low registers */
> +       if (soc_info->is64bit)
> +               regmap_write(ost->map, TCU_REG_OST_CNTL, 0);
> +       regmap_write(ost->map, TCU_REG_OST_CNTH, 0);
> +
> +       /* Don't reset counter at compare value. */
> +       regmap_update_bits(ost->map, TCU_REG_OST_TCSR,
> +                          TCU_OST_TCSR_MASK, TCU_OST_TCSR_CNT_MD);
> +
> +       rate = clk_get_rate(ost->clk);
> +
> +       /* Enable OST TCU channel */
> +       regmap_write(ost->map, TCU_REG_TESR, BIT(TCU_OST_CHANNEL));
> +
> +       cs = &ost->cs;
> +       cs->name        = "ingenic-ost";
> +       cs->rating      = 320;
> +       cs->flags       = CLOCK_SOURCE_IS_CONTINUOUS;
> +
> +       if (soc_info->is64bit) {
> +               cs->mask = CLOCKSOURCE_MASK(64);
> +               cs->read = ingenic_ost_clocksource_read;
> +       } else {
> +               cs->mask = CLOCKSOURCE_MASK(32);
> +               cs->read = (u64 (*)(struct clocksource *))ingenic_ost_read_cnth;

The function is declared as ingenic_ost_read_cnth(void), are you sure
this is going to work ?

> +       }
> +
> +       err = clocksource_register_hz(cs, rate);
> +       if (err) {
> +               dev_err(dev, "clocksource registration failed: %d\n", err);
> +               clk_disable_unprepare(ost->clk);
> +               return err;
> +       }
> +
> +       /* Cannot register a sched_clock with interrupts on */
> +       local_irq_save(flags);
> +       if (soc_info->is64bit)
> +               sched_clock_register(ingenic_ost_read_cntl, 32, rate);
> +       else
> +               sched_clock_register(ingenic_ost_read_cnth, 32, rate);
> +       local_irq_restore(flags);
> +
> +       return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int ingenic_ost_suspend(struct device *dev)
> +{
> +       struct ingenic_ost *ost = dev_get_drvdata(dev);
> +
> +       clk_disable(ost->clk);
> +       return 0;
> +}
> +
> +static int ingenic_ost_resume(struct device *dev)
> +{
> +       struct ingenic_ost *ost = dev_get_drvdata(dev);
> +
> +       return clk_enable(ost->clk);
> +}
> +
> +static SIMPLE_DEV_PM_OPS(ingenic_ost_pm_ops, ingenic_ost_suspend,
> +                        ingenic_ost_resume);
> +#define INGENIC_OST_PM_OPS (&ingenic_ost_pm_ops)
> +#else
> +#define INGENIC_OST_PM_OPS NULL
> +#endif /* CONFIG_PM_SUSPEND */
> +
> +static const struct ingenic_ost_soc_info jz4725b_ost_soc_info = {
> +       .is64bit = false,
> +};
> +
> +static const struct ingenic_ost_soc_info jz4770_ost_soc_info = {
> +       .is64bit = true,
> +};
> +
> +static const struct of_device_id ingenic_ost_of_match[] = {
> +       { .compatible = "ingenic,jz4725b-ost", .data = &jz4725b_ost_soc_info, },
> +       { .compatible = "ingenic,jz4770-ost",  .data = &jz4770_ost_soc_info,  },
> +       { }
> +};
> +
> +static struct platform_driver ingenic_ost_driver = {
> +       .driver = {
> +               .name   = "ingenic-ost",
> +               .pm     = INGENIC_OST_PM_OPS,
> +               .of_match_table = ingenic_ost_of_match,
> +       },
> +};
> +
> +/* FIXME: Using device_initcall (or buildin_platform_driver_probe) results
> + * in the driver not being probed at all. It worked in 4.18...
> + */
> +static int __init ingenic_ost_drv_register(void)
> +{
> +       return platform_driver_probe(&ingenic_ost_driver,
> +                                    ingenic_ost_probe);
> +}
> +late_initcall(ingenic_ost_drv_register);
> --
> 2.11.0
>
