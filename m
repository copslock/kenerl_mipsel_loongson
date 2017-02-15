Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Feb 2017 14:09:24 +0100 (CET)
Received: from mail-pg0-x243.google.com ([IPv6:2607:f8b0:400e:c05::243]:34130
        "EHLO mail-pg0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993878AbdBONJPqo16E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Feb 2017 14:09:15 +0100
Received: by mail-pg0-x243.google.com with SMTP id v184so11144914pgv.1
        for <linux-mips@linux-mips.org>; Wed, 15 Feb 2017 05:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ipb0AcRSZmlZMofq7577ECnneYmV6Epr5PbTbDYM4wE=;
        b=artd1EAYGvh6zEJ1+c3ywadgQMg3VJ+zdzHU/iDBSzcLjuwW62l2RwdbhjLf5igOXq
         OX+mc3ZB0C5zAN4U06RxUzBz6xJopQxql0Cdo/wS4xQiQMlBePUofUub63wkdp6Xu9QM
         G4BLoUIdvdhubQbDKLaRgh8/hbZJG5y925Ybl1DayKI1KEBeAWrjEullZE7hjcN3IYV2
         AEgTM07zU3Hj+Gj8dImas9fzI2agRTZ8nB7VJ7H/+N5ynHw9j6upziq+F2BaNzFY72eC
         /HrqwzSf8L401tz1C2dG5glMwxwZrHtGlMmbEAs32+4NQ69zpRWLVV0X+t8/S7RjgaUN
         8ZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ipb0AcRSZmlZMofq7577ECnneYmV6Epr5PbTbDYM4wE=;
        b=F9NyEH8+Aort1Jqjn3Dv0wbGV23HFcosds7RZ7YpgWwrY1HsaUDRH4PRPPn3xBy5fO
         1Gu+qRS+OztBA3GE7oCCAdJ6fYKZYyHBjqiKaK9QQ4DRN02x9C5HB329L71BouGOAguI
         hx9Q/AsZz/bGjIQKz8WPEveOkTcM3+BrTPr5bOHOl1qPyDUatIVYiKdlaCHDH/CBwGD3
         s9PaHB95PIclsAET4qu6U4uNkiBWeptSHk2H3E10xeXGP92QrdN3MoWckIPNMZvq4V1Y
         Uc94XvkjRtIXKO4OmC6WbF9PmlgdqzfBbM0iKCitTim53ILNFUky72AKzUrkXLVuxoq7
         +WwA==
X-Gm-Message-State: AMke39lPxVBQuO1d+NolTx/jS+VRXYJsV2NyxapvXnY0McOZx3m9I1SiHF4/vw3HRH5DZg==
X-Received: by 10.84.212.2 with SMTP id d2mr43662765pli.152.1487164149681;
        Wed, 15 Feb 2017 05:09:09 -0800 (PST)
Received: from ubuntu ([180.102.123.175])
        by smtp.gmail.com with ESMTPSA id s26sm7650398pge.33.2017.02.15.05.09.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Feb 2017 05:09:07 -0800 (PST)
From:   Yang Ling <gnaygnil@gmail.com>
X-Google-Original-From: Yang Ling <gnaygnail@gmail.com>
Date:   Wed, 15 Feb 2017 21:09:02 +0800
To:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc:     Yang Ling <gnaygnil@gmail.com>, thierry.reding@gmail.com,
        keguang.zhang@gmail.com, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] pwm: loongson1: Add PWM driver for Loongson1 SoC
Message-ID: <20170215130902.GA32795@ubuntu>
References: <20170213152801.GA32019@ubuntu>
 <f27d34d4-b0ac-2fd6-bc75-89a6c913ba3c@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f27d34d4-b0ac-2fd6-bc75-89a6c913ba3c@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <gnaygnil@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56827
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gnaygnil@gmail.com
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

Hi Marcin,

On Tue, Feb 14, 2017 at 03:54:44PM +0100, Marcin Nowakowski wrote:
> Hi Yang,
> 
> 
> On 13.02.2017 16:28, Yang Ling wrote:
> >Add support for the PWM controller present in Loongson1 family of SoCs.
> >
> >Signed-off-by: Yang Ling <gnaygnil@gmail.com>
> >---
> > drivers/pwm/Kconfig         |   9 +++
> > drivers/pwm/Makefile        |   1 +
> > drivers/pwm/pwm-loongson1.c | 169 ++++++++++++++++++++++++++++++++++++++++++++
> > 3 files changed, 179 insertions(+)
> > create mode 100644 drivers/pwm/pwm-loongson1.c
> >
> >diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> >index f92dd41..985f2fe 100644
> >--- a/drivers/pwm/Kconfig
> >+++ b/drivers/pwm/Kconfig
> >@@ -216,6 +216,15 @@ config PWM_JZ4740
> > 	  To compile this driver as a module, choose M here: the module
> > 	  will be called pwm-jz4740.
> >
> >+config PWM_LOONGSON1
> >+	tristate "Loongson1 PWM support"
> >+	depends on MACH_LOONGSON32
> >+	help
> >+	  Generic PWM framework driver for Loongson1 based machines.
> >+
> >+	  To compile this driver as a module, choose M here: the module
> >+	  will be called pwm-loongson1.
> >+
> > config PWM_LP3943
> > 	tristate "TI/National Semiconductor LP3943 PWM support"
> > 	depends on MFD_LP3943
> >diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> >index a48bdb5..1979453 100644
> >--- a/drivers/pwm/Makefile
> >+++ b/drivers/pwm/Makefile
> >@@ -19,6 +19,7 @@ obj-$(CONFIG_PWM_HIBVT)		+= pwm-hibvt.o
> > obj-$(CONFIG_PWM_IMG)		+= pwm-img.o
> > obj-$(CONFIG_PWM_IMX)		+= pwm-imx.o
> > obj-$(CONFIG_PWM_JZ4740)	+= pwm-jz4740.o
> >+obj-$(CONFIG_PWM_LOONGSON1)	+= pwm-loongson1.o
> > obj-$(CONFIG_PWM_LP3943)	+= pwm-lp3943.o
> > obj-$(CONFIG_PWM_LPC18XX_SCT)	+= pwm-lpc18xx-sct.o
> > obj-$(CONFIG_PWM_LPC32XX)	+= pwm-lpc32xx.o
> >diff --git a/drivers/pwm/pwm-loongson1.c b/drivers/pwm/pwm-loongson1.c
> >new file mode 100644
> >index 0000000..72e3fe3
> >--- /dev/null
> >+++ b/drivers/pwm/pwm-loongson1.c
> >@@ -0,0 +1,169 @@
> >+/*
> >+ * Copyright (c) 2017 Yang Ling <gnaygnil@gmail.com>
> >+ *
> >+ * This program is free software; you can redistribute it and/or modify it
> >+ * under the terms of the GNU General Public License as published by the
> >+ * Free Software Foundation; either version 2 of the License, or (at your
> >+ * option) any later version.
> >+ */
> >+
> >+#include <linux/clk.h>
> >+#include <linux/module.h>
> >+#include <linux/platform_device.h>
> >+#include <linux/pwm.h>
> >+#include <loongson1.h>
> >+
> >+struct ls1x_pwm_chip {
> >+	struct clk *clk;
> >+	void __iomem *base;
> >+	struct pwm_chip chip;
> >+};
> >+
> >+struct ls1x_pwm_channel {
> >+	u32 period_ns;
> >+	u32 duty_ns;
> >+};
> >+static inline struct ls1x_pwm_chip *to_ls1x_pwm_chip(struct pwm_chip *chip)
> >+{
> >+	return container_of(chip, struct ls1x_pwm_chip, chip);
> >+}
> >+
> >+static int ls1x_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
> >+{
> >+	struct ls1x_pwm_channel *chan = NULL;
> >+
> >+	chan = devm_kzalloc(chip->dev, sizeof(*chan), GFP_KERNEL);
> >+	if (!chan)
> >+		return -ENOMEM;
> >+
> >+	pwm_set_chip_data(pwm, chan);
> >+
> >+	return 0;
> >+}
> >+
> >+static void ls1x_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
> >+{
> >+	devm_kfree(chip->dev, pwm_get_chip_data(pwm));
> >+	pwm_set_chip_data(pwm, NULL);
> >+}
> >+
> 
> Period and duty are stored in the pwm_device already, so you're just
> duplicating the same data here. If you remove ls1x_pwm_channel then
> all of the code above becomes unnecessary ...

Remove ls1x_pwm_channel.

> 
> >+static int ls1x_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> >+			int duty_ns, int period_ns)
> >+{
> >+	struct ls1x_pwm_chip *pc = to_ls1x_pwm_chip(chip);
> >+	struct ls1x_pwm_channel *chan = pwm_get_chip_data(pwm);
> >+	unsigned long long tmp;
> >+	unsigned long period, duty;
> >+
> >+	if (period_ns == chan->period_ns && duty_ns == chan->duty_ns)
> >+		return 0;
> >+
> 
> above check is already handled in pwm core

Remove it.

> 
> >+	tmp = (unsigned long long)clk_get_rate(pc->clk) * period_ns;
> >+	do_div(tmp, 1000000000);
> >+	period = tmp;
> >+
> >+	tmp = (unsigned long long)period * duty_ns;
> >+	do_div(tmp, period_ns);
> >+	duty = period - tmp;
> >+
> >+	if (duty >= period)
> >+		duty = period - 1;
> >+
> >+	if (duty >> 24 || period >> 24)
> >+		return -EINVAL;
> >+
> >+	chan->period_ns = period_ns;
> >+	chan->duty_ns = duty_ns;
> >+
> >+	writel(duty, pc->base + PWM_HRC(pwm->hwpwm));
> >+	writel(period, pc->base + PWM_LRC(pwm->hwpwm));
> >+	writel(0x00, pc->base + PWM_CNT(pwm->hwpwm));
> >+
> 
> PWM_HRC and PWM_LRC names suggest that you're using high/low state
> counters here rather than duty/period - but with no documentation
> I'm just guessing here.

Indeed, the high/low state counters is used here.
Change the name to duty_cnt/period_cnt.

> 
> >+	return 0;
> >+}
> >+
> >+static int ls1x_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> >+{
> >+	struct ls1x_pwm_chip *pc = to_ls1x_pwm_chip(chip);
> >+
> >+	writel(CNT_RST, pc->base + PWM_CTRL(pwm->hwpwm));
> >+	writel(CNT_EN, pc->base + PWM_CTRL(pwm->hwpwm));
> >+
> >+	return 0;
> >+}
> >+
> >+static void ls1x_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
> >+{
> >+	struct ls1x_pwm_chip *pc = to_ls1x_pwm_chip(chip);
> >+
> >+	writel(PWM_OE, pc->base + PWM_CTRL(pwm->hwpwm));
> >+}
> >+
> >+static const struct pwm_ops ls1x_pwm_ops = {
> >+	.request = ls1x_pwm_request,
> >+	.free = ls1x_pwm_free,
> >+	.config = ls1x_pwm_config,
> >+	.enable = ls1x_pwm_enable,
> >+	.disable = ls1x_pwm_disable,
> >+	.owner = THIS_MODULE,
> >+};
> >+
> >+static int ls1x_pwm_probe(struct platform_device *pdev)
> >+{
> >+	struct ls1x_pwm_chip *pc = NULL;
> >+	struct resource *res = NULL;
> >+
> >+	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
> >+	if (!pc)
> >+		return -ENOMEM;
> >+
> >+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >+	pc->base = devm_ioremap_resource(&pdev->dev, res);
> >+	if (IS_ERR(pc->base))
> >+		return PTR_ERR(pc->base);
> >+
> >+	pc->clk = devm_clk_get(&pdev->dev, "ls1x-pwmtimer");
> >+	if (IS_ERR(pc->clk)) {
> >+		dev_err(&pdev->dev, "failed to get %s clock\n", pdev->name);
> >+		return PTR_ERR(pc->clk);
> >+	}
> >+	clk_prepare_enable(pc->clk);
> 
> Should check for errors here
> 
> >+	pc->chip.ops = &ls1x_pwm_ops;
> >+	pc->chip.dev = &pdev->dev;
> >+	pc->chip.base = -1;
> >+	pc->chip.npwm = 4;
> >+
> >+	platform_set_drvdata(pdev, pc);
> >+
> >+	return pwmchip_add(&pc->chip);
> 
> Should check for errors (and disable clk appropriately)

These will be modified.

> 
> >+}
> >+
> >+static int ls1x_pwm_remove(struct platform_device *pdev)
> >+{
> >+	struct ls1x_pwm_chip *pc = platform_get_drvdata(pdev);
> >+	int ret;
> >+
> >+	ret = pwmchip_remove(&pc->chip);
> >+	if (ret < 0)
> >+		return ret;
> >+
> >+	clk_disable_unprepare(pc->clk);
> >+
> >+	return 0;
> >+}
> >+
> >+static struct platform_driver ls1x_pwm_driver = {
> >+	.driver = {
> >+		.name = "ls1x-pwm",
> >+	},
> >+	.probe = ls1x_pwm_probe,
> >+	.remove = ls1x_pwm_remove,
> >+};
> >+module_platform_driver(ls1x_pwm_driver);
> >+
> >+MODULE_AUTHOR("Yang Ling <gnaygnil@gmail.com>");
> >+MODULE_DESCRIPTION("Loongson1 PWM driver");
> >+MODULE_ALIAS("platform:loongson1-pwm");
> >+MODULE_LICENSE("GPL");
> >
> 
> 
> Best regards,
> Marcin

Thanks for your friendly reminder.

Yang
