Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Apr 2016 14:12:44 +0200 (CEST)
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36504 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026130AbcDFMLoO1ky4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Apr 2016 14:11:44 +0200
Received: by mail-pf0-f196.google.com with SMTP id q129so4093447pfb.3;
        Wed, 06 Apr 2016 05:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JC7zsajJLXSVzpUQTYhQ0oE2RTby2CvnAHzZ+a88xlU=;
        b=lhibzw8CofgSs97wYNd0QuTktgNJ6zZWnJ2xjH+PRt2ZTTUIiWKfyEhDR0zo3BPVg7
         na845ybfKGa4dfAqsdKKmDRhvCQSJgQnbTzZ3uGajoYkrQLaCypBQIg2+nwVFEBEXtS8
         qDEadYcgouHMeDzRkUo8kG5qCTeYbKXai1PHiLnzcZ6F2S5cDs9fbkXa/hrfAOphtdEq
         /LVjWT9k3B4lwH5NmP7Gd3rxRv2DistPdOi6ATWZtLdRQIlmWyjZRm0cVVyOE6cHQB+v
         XiYLAr5nqZRCfEz9tz4oeCQj4gL/g5/mD0lhgGqSvpgA3y6QguclcPB8OCvcc0UcHxd3
         aDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JC7zsajJLXSVzpUQTYhQ0oE2RTby2CvnAHzZ+a88xlU=;
        b=MtxEW4FdXV+9A0Wfiqhf0+iTQMFTLrXsdYbPg7h3p4CGwiG6MDcJFqm1ZkIEsJNAGp
         lgaBieQs4RpOozatKyo6LQwGfVMJl4lkX4JA7KHwM1a/hJyKsbrZLxkg7KUZ+SNUhql4
         SGQDriBiaI0d6JQ14Tb21r7/xAVp0PDUeR37S2VtEWOrRn/8fIOVM7ZFAKRERNfTekNb
         p2afh2vSMWb8JKnFK+Nog+As/nC776ECgEDV6VZCO1eRjKbYDPKqWV+aSyM9ukx12IQf
         XmSWB4gnQyI9reMvM+cW0FAx+dPzHEWjrj5onExNSm7DIKYve0H35/93/7/43Plt0H+A
         /vrQ==
X-Gm-Message-State: AD7BkJIe2rjmobDM2/6slJW6NALriAsCsnJ9eIxn7YFJRWQ2APqt0uFUtgAZOAvCAZ0Lvw==
X-Received: by 10.98.71.91 with SMTP id u88mr37954751pfa.161.1459944697255;
        Wed, 06 Apr 2016 05:11:37 -0700 (PDT)
Received: from localhost.localdomain ([175.111.195.49])
        by smtp.gmail.com with ESMTPSA id 3sm4676177pfn.59.2016.04.06.05.11.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2016 05:11:36 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-mtd@lists.infradead.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vinod Koul <vinod.koul@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH 5/7] gpio: Loongson1: add Loongson1 GPIO driver
Date:   Wed,  6 Apr 2016 20:09:35 +0800
Message-Id: <1459944577-6423-6-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1459944577-6423-1-git-send-email-keguang.zhang@gmail.com>
References: <1459944577-6423-1-git-send-email-keguang.zhang@gmail.com>
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52902
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
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

From: Kelvin Cheung <keguang.zhang@gmail.com>

This patch adds GPIO driver for Loongson1B.

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
---
 drivers/gpio/Kconfig          |   7 +++
 drivers/gpio/Makefile         |   1 +
 drivers/gpio/gpio-loongson1.c | 102 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+)
 create mode 100644 drivers/gpio/gpio-loongson1.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 5f3429f..373b8a7 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -510,6 +510,13 @@ config GPIO_ZX
 	help
 	  Say yes here to support the GPIO device on ZTE ZX SoCs.
 
+config GPIO_LOONGSON1
+	tristate "Loongson1 GPIO support"
+	depends on MACH_LOONGSON32
+	select GPIO_GENERIC
+	help
+	  Say Y or M here to support GPIO on Loongson1 SoCs.
+
 endmenu
 
 menu "Port-mapped I/O GPIO drivers"
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 1e0b74f..40ab913 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -127,3 +127,4 @@ obj-$(CONFIG_GPIO_XTENSA)	+= gpio-xtensa.o
 obj-$(CONFIG_GPIO_ZEVIO)	+= gpio-zevio.o
 obj-$(CONFIG_GPIO_ZYNQ)		+= gpio-zynq.o
 obj-$(CONFIG_GPIO_ZX)		+= gpio-zx.o
+obj-$(CONFIG_GPIO_LOONGSON1)	+= gpio-loongson1.o
diff --git a/drivers/gpio/gpio-loongson1.c b/drivers/gpio/gpio-loongson1.c
new file mode 100644
index 0000000..10c09bd
--- /dev/null
+++ b/drivers/gpio/gpio-loongson1.c
@@ -0,0 +1,102 @@
+/*
+ * GPIO Driver for Loongson 1 SoC
+ *
+ * Copyright (C) 2015-2016 Zhang, Keguang <keguang.zhang@gmail.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/gpio/driver.h>
+#include <linux/platform_device.h>
+
+/* Loongson 1 GPIO Register Definitions */
+#define GPIO_CFG		0x0
+#define GPIO_DIR		0x10
+#define GPIO_DATA		0x20
+#define GPIO_OUTPUT		0x30
+
+static void __iomem *gpio_reg_base;
+
+static int ls1x_gpio_request(struct gpio_chip *gc, unsigned int offset)
+{
+	unsigned long pinmask = gc->pin2mask(gc, offset);
+	unsigned long flags;
+
+	spin_lock_irqsave(&gc->bgpio_lock, flags);
+	__raw_writel(__raw_readl(gpio_reg_base + GPIO_CFG) | pinmask,
+		     gpio_reg_base + GPIO_CFG);
+	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
+
+	return 0;
+}
+
+static void ls1x_gpio_free(struct gpio_chip *gc, unsigned int offset)
+{
+	unsigned long pinmask = gc->pin2mask(gc, offset);
+	unsigned long flags;
+
+	spin_lock_irqsave(&gc->bgpio_lock, flags);
+	__raw_writel(__raw_readl(gpio_reg_base + GPIO_CFG) & ~pinmask,
+		     gpio_reg_base + GPIO_CFG);
+	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
+}
+
+static int ls1x_gpio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct gpio_chip *gc;
+	struct resource *res;
+	int ret;
+
+	gc = devm_kzalloc(dev, sizeof(*gc), GFP_KERNEL);
+	if (!gc)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "failed to get I/O memory\n");
+		return -EINVAL;
+	}
+
+	gpio_reg_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(gpio_reg_base))
+		return PTR_ERR(gpio_reg_base);
+
+	ret = bgpio_init(gc, dev, 4, gpio_reg_base + GPIO_DATA,
+			 gpio_reg_base + GPIO_OUTPUT, NULL,
+			 NULL, gpio_reg_base + GPIO_DIR, 0);
+	if (ret)
+		goto err;
+
+	gc->owner = THIS_MODULE;
+	gc->request = ls1x_gpio_request;
+	gc->free = ls1x_gpio_free;
+	gc->base = pdev->id * 32;
+
+	ret = devm_gpiochip_add_data(dev, gc, NULL);
+	if (ret)
+		goto err;
+
+	platform_set_drvdata(pdev, gc);
+	dev_info(dev, "Loongson1 GPIO driver registered\n");
+
+	return 0;
+err:
+	dev_err(dev, "failed to register GPIO device\n");
+	return ret;
+}
+
+static struct platform_driver ls1x_gpio_driver = {
+	.probe	= ls1x_gpio_probe,
+	.driver	= {
+		.name	= "ls1x-gpio",
+	},
+};
+
+module_platform_driver(ls1x_gpio_driver);
+
+MODULE_AUTHOR("Kelvin Cheung <keguang.zhang@gmail.com>");
+MODULE_DESCRIPTION("Loongson1 GPIO driver");
+MODULE_LICENSE("GPL");
-- 
1.9.1
