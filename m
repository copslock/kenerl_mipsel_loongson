Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Dec 2017 14:26:48 +0100 (CET)
Received: from mail-it0-x241.google.com ([IPv6:2607:f8b0:4001:c0b::241]:36234
        "EHLO mail-it0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992176AbdLRN0i5w11n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Dec 2017 14:26:38 +0100
Received: by mail-it0-x241.google.com with SMTP id d16so27612274itj.1;
        Mon, 18 Dec 2017 05:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uu9Sk+kqyA61UdDg0ryx74dB+dnPXpTtKbrafeY4foQ=;
        b=YhJrr4cYSuYGBdkzE+PKL0z+Toyo/mM/s5RboXIQQiWJ2PKO2WEENUiZu1z8mcaAji
         GaKGmd7+tH880TThnDIMxz8ku5Q6K8J1SYqjOX1Up/aAjFvDLtueQ6OrXTqgRlCUBHER
         CZEs+kAqV2z4dwGEqgOUoElMhphqkYqutPeewihcQzwJZS25jnATGhvj9s7xQxaaVwgd
         2e2U87i4RgzcM6NdT32gjv036v/rNSqza4h4EbUdwFdk+0GEh/dnDWYMreMH5ckHG2+8
         otqVvCdRGRD3lynK8eVb+Yr77uNcpWNTtWSI60GhMxTO1id+lzu00xKQC/oJ42SDu76k
         CBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uu9Sk+kqyA61UdDg0ryx74dB+dnPXpTtKbrafeY4foQ=;
        b=JwG+GvBbXPJtyJCnToW+rQ8V/ncr1tGUdp+qcpQvf1q4cGNQf+LPwdic9/uslkxhx9
         9PkzpddUO/U35O8Z7TasvSP/JBldoMWaHr3DMi3oBIYelLQS6gqObfkuE9ocvwAfRKae
         y10H4rhJAs6R8Qq9lqO76AFBaGC17TUe5f9ljU653GFv2b5ILQINKLORnGkZO8V05Hsa
         v57pLeDmeoth74RiARV+iKAHctEP94HogzJZpxa3qL+uUFSGU6JBJ33HPYuiG0oHN1qk
         BlGCyVUSu1lyXfp1lUrD4IJ/wSWMQP4SARaSHEK2b0zrwOHUyDnXJPYT7MNPcOi7wHom
         GHbg==
X-Gm-Message-State: AKGB3mJwZrGD6brNoztXLbVv1Zpy1tDei68zq7t9tzJX1Mkcf15gW70Q
        ibSMDfuh9tOb/qVwnr/7m+RMj1JiX4hJsrcCXus=
X-Google-Smtp-Source: ACJfBotfuMBQ0/E4fm9LRe4ZJ3TRaXXF4H2Yka60q/2Ielg/phzuDT6+XFw2NPjMTQdSDAIiU+ZVF6PUX2Z+BBIWY5k=
X-Received: by 10.36.217.208 with SMTP id p199mr19958000itg.106.1513603590635;
 Mon, 18 Dec 2017 05:26:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.169.20 with HTTP; Mon, 18 Dec 2017 05:26:30 -0800 (PST)
In-Reply-To: <20171208154618.20105-9-alexandre.belloni@free-electrons.com>
References: <20171208154618.20105-1-alexandre.belloni@free-electrons.com> <20171208154618.20105-9-alexandre.belloni@free-electrons.com>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Mon, 18 Dec 2017 18:56:30 +0530
Message-ID: <CANc+2y5itUahW9s9buhUxkM-tYQQqT3EU4JYGZaZk_a6rpN+Bg@mail.gmail.com>
Subject: Re: [PATCH v2 08/13] power: reset: Add a driver for the Microsemi
 Ocelot reset
To:     Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        open list <linux-kernel@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61512
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prasannatsmkumar@gmail.com
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

Hi Alexandre,

On 8 December 2017 at 21:16, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> The Microsemi Ocelot SoC has a register allowing to reset the MIPS core.
> Unfortunately, the syscon-reboot driver can't be used directly (but almost)
> as the reset control may be disabled using another register.
>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/power/reset/Kconfig        |  7 ++++
>  drivers/power/reset/Makefile       |  1 +
>  drivers/power/reset/ocelot-reset.c | 86 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 94 insertions(+)
>  create mode 100644 drivers/power/reset/ocelot-reset.c
>
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index ca0de1a78e85..2372f8e1040d 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -113,6 +113,13 @@ config POWER_RESET_MSM
>         help
>           Power off and restart support for Qualcomm boards.
>
> +config POWER_RESET_OCELOT_RESET
> +       bool "Microsemi Ocelot reset driver"
> +       depends on MSCC_OCELOT || COMPILE_TEST
> +       select MFD_SYSCON
> +       help
> +         This driver supports restart for Microsemi Ocelot SoC.
> +
>  config POWER_RESET_PIIX4_POWEROFF
>         tristate "Intel PIIX4 power-off driver"
>         depends on PCI
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index aeb65edb17b7..df9d92291c67 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_POWER_RESET_GPIO_RESTART) += gpio-restart.o
>  obj-$(CONFIG_POWER_RESET_HISI) += hisi-reboot.o
>  obj-$(CONFIG_POWER_RESET_IMX) += imx-snvs-poweroff.o
>  obj-$(CONFIG_POWER_RESET_MSM) += msm-poweroff.o
> +obj-$(CONFIG_POWER_RESET_OCELOT_RESET) += ocelot-reset.o
>  obj-$(CONFIG_POWER_RESET_PIIX4_POWEROFF) += piix4-poweroff.o
>  obj-$(CONFIG_POWER_RESET_LTC2952) += ltc2952-poweroff.o
>  obj-$(CONFIG_POWER_RESET_QNAP) += qnap-poweroff.o
> diff --git a/drivers/power/reset/ocelot-reset.c b/drivers/power/reset/ocelot-reset.c
> new file mode 100644
> index 000000000000..1fb14bf17191
> --- /dev/null
> +++ b/drivers/power/reset/ocelot-reset.c
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Microsemi MIPS SoC reset driver
> + *
> + * License: Dual MIT/GPL
> + * Copyright (c) 2017 Microsemi Corporation
> + */
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/notifier.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/reboot.h>
> +#include <linux/regmap.h>
> +
> +struct ocelot_reset_context {
> +       struct regmap *chip_regs;
> +       struct regmap *cpu_ctrl;
> +       struct notifier_block restart_handler;
> +};
> +
> +#define ICPU_CFG_CPU_SYSTEM_CTRL_RESET 0x20
> +#define CORE_RST_PROTECT BIT(2)
> +
> +#define CHIP_REGS_SOFT_RST 0x8
> +#define SOFT_CHIP_RST BIT(0)
> +
> +static int ocelot_restart_handle(struct notifier_block *this,
> +                                unsigned long mode, void *cmd)
> +{
> +       struct ocelot_reset_context *ctx = container_of(this, struct
> +                                                       ocelot_reset_context,
> +                                                       restart_handler);
> +
> +       /* Make sure the core is not protected from reset */
> +       regmap_update_bits(ctx->cpu_ctrl, ICPU_CFG_CPU_SYSTEM_CTRL_RESET,
> +                          CORE_RST_PROTECT, 0);
> +
> +       regmap_write(ctx->chip_regs, CHIP_REGS_SOFT_RST, SOFT_CHIP_RST);
> +
> +       pr_emerg("Unable to restart system\n");
> +       return NOTIFY_DONE;
> +}
> +
> +static int ocelot_reset_probe(struct platform_device *pdev)
> +{
> +       struct ocelot_reset_context *ctx;
> +       struct device *dev = &pdev->dev;
> +       int err;
> +
> +       ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
> +       if (!ctx)
> +               return -ENOMEM;
> +
> +       ctx->chip_regs = syscon_node_to_regmap(of_get_parent(dev->of_node));
> +       if (IS_ERR(ctx->chip_regs))
> +               return PTR_ERR(ctx->chip_regs);
> +
> +       ctx->cpu_ctrl = syscon_regmap_lookup_by_compatible("mscc,ocelot-cpu-syscon");
> +       if (IS_ERR(ctx->cpu_ctrl))
> +               return PTR_ERR(ctx->cpu_ctrl);
> +
> +       ctx->restart_handler.notifier_call = ocelot_restart_handle;
> +       ctx->restart_handler.priority = 192;
> +       err = register_restart_handler(&ctx->restart_handler);
> +       if (err)
> +               dev_err(dev, "can't register restart notifier (err=%d)\n", err);
> +
> +       return err;
> +}
> +
> +static const struct of_device_id ocelot_reset_of_match[] = {
> +       { .compatible = "mscc,ocelot-chip-reset" },
> +       {}
> +};
> +
> +static struct platform_driver ocelot_reset_driver = {
> +       .probe = ocelot_reset_probe,
> +       .driver = {
> +               .name = "ocelot-chip-reset",
> +               .of_match_table = ocelot_reset_of_match,
> +       },
> +};
> +builtin_platform_driver(ocelot_reset_driver);
> --
> 2.15.1
>
>

Looks good to me.
Reviewed-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>

Regards,
PrasannaKumar
