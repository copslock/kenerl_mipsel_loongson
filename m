Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Apr 2016 14:37:15 +0200 (CEST)
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34734 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026149AbcDFMgJ0nbOZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Apr 2016 14:36:09 +0200
Received: by mail-pf0-f196.google.com with SMTP id d184so4149470pfc.1;
        Wed, 06 Apr 2016 05:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JC7zsajJLXSVzpUQTYhQ0oE2RTby2CvnAHzZ+a88xlU=;
        b=n/HPgChfuzjKa5IpS+5CCW43EDXRzmoHpVuB0mQUZFq5tV7BC5ooYbi++804J2DRNZ
         2JAjk0V2OXZvWVP3C+1rtrlM09so3CALYTSpxLpz8QhHWXu/1ESIklZeRoIRMZ/joscH
         lNKXNoI2ncIGCw6Q3tkuoALNrn8rMa2GiWi1k+CoBwimCRpJ3tpzGT8lQbFeN0ncH1BR
         fYm12gW4gqn845su7ji3GcktqtrnuZMAhq2Ha4Y7+qQVJ4zA5u0zjKKTZdNi79ci0KIA
         TYJJxt2jKueDSM5qaJeKfMUa3nYqpWNCs2ymbmUf+eV9E9Uy0FLqm6XuSqeyJkNMUBNC
         +SMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JC7zsajJLXSVzpUQTYhQ0oE2RTby2CvnAHzZ+a88xlU=;
        b=X20jHfwup3RmA+z+fZCRPXSMQN1nCO2ECpFAxNVKFuSKSV/vp0ZVkYpKLFbqBS1opn
         uQ+NrelfLXpPxQWlS3ijEu4ZOtlSvws1DtUTcEBPJ2p7Z2IBVQQQ3ngVfqh0cqpN/UGA
         fnI5hSzcrUboFpkx5g435UiYPaf9WwJzmaszpIhCTPgY1I6/CHj3f0+hUF1curWtRqfL
         byFymxGtPtCOneiVPj/9VPsLKQDQ0C2hKcJsT68u9ELxkaC+EKEctAF3lOi0r+h2aIYe
         goDpNJzHgwfbgc8SzGXr+frCbPlcVbS+tTCLmyNVXBKmHkk+r85Wu5LaKu2L3N9OiaRs
         rDSw==
X-Gm-Message-State: AD7BkJIIqGnpU2rZIyWm1bik0b0YF+/NBll58YIuRVk8kWxbxjwy5Od0cXP1xc/Md9uDsA==
X-Received: by 10.98.10.29 with SMTP id s29mr38496860pfi.166.1459946163687;
        Wed, 06 Apr 2016 05:36:03 -0700 (PDT)
Received: from localhost.localdomain ([175.111.195.49])
        by smtp.gmail.com with ESMTPSA id 27sm4851789pfo.58.2016.04.06.05.35.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2016 05:36:02 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-mtd@lists.infradead.org
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
Subject: [PATCH V1 5/7] gpio: Loongson1: add Loongson1 GPIO driver
Date:   Wed,  6 Apr 2016 20:34:53 +0800
Message-Id: <1459946095-7637-6-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1459946095-7637-1-git-send-email-keguang.zhang@gmail.com>
References: <1459946095-7637-1-git-send-email-keguang.zhang@gmail.com>
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52911
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
