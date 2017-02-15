Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Feb 2017 15:45:53 +0100 (CET)
Received: from mail-pf0-x242.google.com ([IPv6:2607:f8b0:400e:c00::242]:34419
        "EHLO mail-pf0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993882AbdBOOpr2WzVj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Feb 2017 15:45:47 +0100
Received: by mail-pf0-x242.google.com with SMTP id o64so7949730pfb.1
        for <linux-mips@linux-mips.org>; Wed, 15 Feb 2017 06:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=G0DufN/frCu1s6IEUPSofDib51Si+qNK0+QfeKeQijQ=;
        b=D1RGo9noVLeu7DlI4Bx0oarOA3HjKUprIrPP46ZiqOdtRuF79C9/9aaIs4yIrdhBvD
         LYk6opEzb+S0rcdXUS3b+UqF0quckByCXUOKJXDw+h/S2w6pEVB63qcokWqOD56RMP4i
         KGLJgC084VPRdPEi+YeQYpWW75yqa28anZ9gvSc53zvBc63UnVFecNGDeGZVVwCr9RXN
         lvUhX1n3MkQnmRbbGG/FqOhI0QfCpTBzQvL3W9EYlaNLnRoBivPotW8lgTarwwVYRc87
         dVvMEXmoF9468SFAnhR0e1lb9R+dAGp8N3cMwmud46w+CnwZ1F+T6wV+rXyhxByF/wn+
         EP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=G0DufN/frCu1s6IEUPSofDib51Si+qNK0+QfeKeQijQ=;
        b=is67uKRAUvHxDh7ZzUCnjeV5Hw897RVuf6/Jnf57Lj3ht/hrnVEE5uPe7dD6izLjrl
         ANQYyncSGGoBkQ/PAHxvtdfaHLGDGnFrMiStglGc1Y0h1NxJ3AAUhsO2j3eKm80rkrKz
         GvOyCuPyGNEaTIbQa8Fp1GXjf7siWIA74+baFjP6AWk3OYz2IvYL5mLw0ALhjObPEXBl
         GCe4oJsTQUCoOQyVMEBUQmTC3sVQ0B6uZmtaNIQoLUju0XtU6+Fqo4kxCzMN8qyfzVvm
         NsQOQ0qtHenk7i8i8cz0X5p70dY4B7PeBjdx1e7fcFjQZkPU1v9YWwqk/XALjGOtctJq
         lkBQ==
X-Gm-Message-State: AMke39m1VPLQ4BNvBd65/1gPgzQtthlb51pE+WBqGYlYr0OBWvqikkoUtoezbyTdbpQXVg==
X-Received: by 10.99.110.74 with SMTP id j71mr38697875pgc.134.1487169941416;
        Wed, 15 Feb 2017 06:45:41 -0800 (PST)
Received: from ubuntu ([180.102.123.175])
        by smtp.gmail.com with ESMTPSA id m6sm8075063pgn.58.2017.02.15.06.45.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Feb 2017 06:45:40 -0800 (PST)
Date:   Wed, 15 Feb 2017 22:45:31 +0800
From:   Yang Ling <gnaygnil@gmail.com>
To:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Keguang Zhang <keguang.zhang@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mips@linux-mips.org, Yang Ling <gnaygnil@gmail.com>
Subject: [PATCH v2 1/2] pwm: loongson1: Add PWM driver for Loongson1 SoC
Message-ID: <20170215144531.GA39000@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <gnaygnil@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56829
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

Add support for the PWM controller present in Loongson1 family of SoCs.

Signed-off-by: Yang Ling <gnaygnil@gmail.com>

---
V2:
  Remove ls1x_pwm_channel.
  Remove period_ns/duty_ns check.
  Add return values check.
---
 drivers/pwm/Kconfig         |   9 +++
 drivers/pwm/Makefile        |   1 +
 drivers/pwm/pwm-loongson1.c | 148 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 158 insertions(+)
 create mode 100644 drivers/pwm/pwm-loongson1.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index f92dd41..985f2fe 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -216,6 +216,15 @@ config PWM_JZ4740
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-jz4740.
 
+config PWM_LOONGSON1
+	tristate "Loongson1 PWM support"
+	depends on MACH_LOONGSON32
+	help
+	  Generic PWM framework driver for Loongson1 based machines.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-loongson1.
+
 config PWM_LP3943
 	tristate "TI/National Semiconductor LP3943 PWM support"
 	depends on MFD_LP3943
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index a48bdb5..1979453 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_PWM_HIBVT)		+= pwm-hibvt.o
 obj-$(CONFIG_PWM_IMG)		+= pwm-img.o
 obj-$(CONFIG_PWM_IMX)		+= pwm-imx.o
 obj-$(CONFIG_PWM_JZ4740)	+= pwm-jz4740.o
+obj-$(CONFIG_PWM_LOONGSON1)	+= pwm-loongson1.o
 obj-$(CONFIG_PWM_LP3943)	+= pwm-lp3943.o
 obj-$(CONFIG_PWM_LPC18XX_SCT)	+= pwm-lpc18xx-sct.o
 obj-$(CONFIG_PWM_LPC32XX)	+= pwm-lpc32xx.o
diff --git a/drivers/pwm/pwm-loongson1.c b/drivers/pwm/pwm-loongson1.c
new file mode 100644
index 0000000..6c2d06d
--- /dev/null
+++ b/drivers/pwm/pwm-loongson1.c
@@ -0,0 +1,148 @@
+/*
+ * Copyright (c) 2017 Yang Ling <gnaygnil@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <loongson1.h>
+
+struct ls1x_pwm_chip {
+	struct clk *clk;
+	void __iomem *base;
+	struct pwm_chip chip;
+};
+
+static inline struct ls1x_pwm_chip *to_ls1x_pwm_chip(struct pwm_chip *chip)
+{
+	return container_of(chip, struct ls1x_pwm_chip, chip);
+}
+
+static int ls1x_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+			int duty_ns, int period_ns)
+{
+	unsigned long long tmp;
+	unsigned long period_cnt, duty_cnt;
+	struct ls1x_pwm_chip *pc = to_ls1x_pwm_chip(chip);
+
+	tmp = (unsigned long long)clk_get_rate(pc->clk) * period_ns;
+	do_div(tmp, 1000000000);
+	period_cnt = tmp;
+
+	tmp = (unsigned long long)period_cnt * duty_ns;
+	do_div(tmp, period_ns);
+	duty_cnt = period_cnt - tmp;
+
+	if (duty_cnt >= period_cnt)
+		duty_cnt = period_cnt - 1;
+
+	if (duty_cnt >> 24 || period_cnt >> 24)
+		return -EINVAL;
+
+	writel(duty_cnt, pc->base + PWM_HRC(pwm->hwpwm));
+	writel(period_cnt, pc->base + PWM_LRC(pwm->hwpwm));
+	writel(0, pc->base + PWM_CNT(pwm->hwpwm));
+
+	return 0;
+}
+
+static int ls1x_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct ls1x_pwm_chip *pc = to_ls1x_pwm_chip(chip);
+
+	writel(CNT_RST, pc->base + PWM_CTRL(pwm->hwpwm));
+	writel(CNT_EN, pc->base + PWM_CTRL(pwm->hwpwm));
+
+	return 0;
+}
+
+static void ls1x_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct ls1x_pwm_chip *pc = to_ls1x_pwm_chip(chip);
+
+	writel(PWM_OE, pc->base + PWM_CTRL(pwm->hwpwm));
+}
+
+static const struct pwm_ops ls1x_pwm_ops = {
+	.config = ls1x_pwm_config,
+	.enable = ls1x_pwm_enable,
+	.disable = ls1x_pwm_disable,
+	.owner = THIS_MODULE,
+};
+
+static int ls1x_pwm_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct ls1x_pwm_chip *pc = NULL;
+	struct resource *res = NULL;
+
+	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
+	if (!pc)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pc->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(pc->base))
+		return PTR_ERR(pc->base);
+
+	pc->clk = devm_clk_get(&pdev->dev, "ls1x-pwmtimer");
+	if (IS_ERR(pc->clk)) {
+		dev_err(&pdev->dev, "failed to get %s clock\n", pdev->name);
+		return PTR_ERR(pc->clk);
+	}
+
+	ret = clk_prepare_enable(pc->clk);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to enable clock: %d\n", ret);
+		return ret;
+	}
+
+	pc->chip.ops = &ls1x_pwm_ops;
+	pc->chip.dev = &pdev->dev;
+	pc->chip.base = -1;
+	pc->chip.npwm = 4;
+
+	platform_set_drvdata(pdev, pc);
+
+	ret = pwmchip_add(&pc->chip);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
+		clk_disable_unprepare(pc->clk);
+	}
+
+	return ret;
+}
+
+static int ls1x_pwm_remove(struct platform_device *pdev)
+{
+	struct ls1x_pwm_chip *pc = platform_get_drvdata(pdev);
+	int ret;
+
+	ret = pwmchip_remove(&pc->chip);
+	if (ret < 0)
+		return ret;
+
+	clk_disable_unprepare(pc->clk);
+
+	return 0;
+}
+
+static struct platform_driver ls1x_pwm_driver = {
+	.driver = {
+		.name = "ls1x-pwm",
+	},
+	.probe = ls1x_pwm_probe,
+	.remove = ls1x_pwm_remove,
+};
+module_platform_driver(ls1x_pwm_driver);
+
+MODULE_AUTHOR("Yang Ling <gnaygnil@gmail.com>");
+MODULE_DESCRIPTION("Loongson1 PWM driver");
+MODULE_ALIAS("platform:loongson1-pwm");
+MODULE_LICENSE("GPL");
-- 
1.9.1
