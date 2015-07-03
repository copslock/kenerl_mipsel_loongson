Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jul 2015 11:12:58 +0200 (CEST)
Received: from smtp2-g21.free.fr ([212.27.42.2]:14740 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009179AbbGCJMhEk5sn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 3 Jul 2015 11:12:37 +0200
Received: from localhost.localdomain (unknown [78.50.173.214])
        (Authenticated sender: albeu)
        by smtp2-g21.free.fr (Postfix) with ESMTPA id 063BB4B01DD;
        Fri,  3 Jul 2015 11:12:27 +0200 (CEST)
From:   Alban Bedel <albeu@free.fr>
To:     linux-gpio@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Gabor Juhos <juhosg@openwrt.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Alban Bedel <albeu@free.fr>
Subject: [PATCH 2/2] MIPS: ath79: Move the GPIO driver to drivers/gpio
Date:   Fri,  3 Jul 2015 11:11:49 +0200
Message-Id: <1435914709-15092-3-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1435914709-15092-1-git-send-email-albeu@free.fr>
References: <1435914709-15092-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48061
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

GPIO drivers should be in drivers/gpio

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 arch/mips/ath79/Makefile  |   2 +-
 arch/mips/ath79/gpio.c    | 236 ----------------------------------------------
 drivers/gpio/Makefile     |   1 +
 drivers/gpio/gpio-ath79.c | 236 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 238 insertions(+), 237 deletions(-)
 delete mode 100644 arch/mips/ath79/gpio.c
 create mode 100644 drivers/gpio/gpio-ath79.c

diff --git a/arch/mips/ath79/Makefile b/arch/mips/ath79/Makefile
index 5c9ff69..fcc382c 100644
--- a/arch/mips/ath79/Makefile
+++ b/arch/mips/ath79/Makefile
@@ -8,7 +8,7 @@
 # under the terms of the GNU General Public License version 2 as published
 # by the Free Software Foundation.
 
-obj-y	:= prom.o setup.o irq.o common.o clock.o gpio.o
+obj-y	:= prom.o setup.o irq.o common.o clock.o
 
 obj-$(CONFIG_EARLY_PRINTK)		+= early_printk.o
 obj-$(CONFIG_PCI)			+= pci.o
diff --git a/arch/mips/ath79/gpio.c b/arch/mips/ath79/gpio.c
deleted file mode 100644
index c3c92eb..0000000
--- a/arch/mips/ath79/gpio.c
+++ /dev/null
@@ -1,236 +0,0 @@
-/*
- *  Atheros AR71XX/AR724X/AR913X GPIO API support
- *
- *  Copyright (C) 2010-2011 Jaiganesh Narayanan <jnarayanan@atheros.com>
- *  Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
- *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
- *
- *  Parts of this file are based on Atheros' 2.6.15/2.6.31 BSP
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/spinlock.h>
-#include <linux/io.h>
-#include <linux/ioport.h>
-#include <linux/gpio.h>
-#include <linux/platform_data/gpio-ath79.h>
-#include <linux/of_device.h>
-
-#include <asm/mach-ath79/ar71xx_regs.h>
-
-static void __iomem *ath79_gpio_base;
-static u32 ath79_gpio_count;
-static DEFINE_SPINLOCK(ath79_gpio_lock);
-
-static void __ath79_gpio_set_value(unsigned gpio, int value)
-{
-	void __iomem *base = ath79_gpio_base;
-
-	if (value)
-		__raw_writel(1 << gpio, base + AR71XX_GPIO_REG_SET);
-	else
-		__raw_writel(1 << gpio, base + AR71XX_GPIO_REG_CLEAR);
-}
-
-static int __ath79_gpio_get_value(unsigned gpio)
-{
-	return (__raw_readl(ath79_gpio_base + AR71XX_GPIO_REG_IN) >> gpio) & 1;
-}
-
-static int ath79_gpio_get_value(struct gpio_chip *chip, unsigned offset)
-{
-	return __ath79_gpio_get_value(offset);
-}
-
-static void ath79_gpio_set_value(struct gpio_chip *chip,
-				  unsigned offset, int value)
-{
-	__ath79_gpio_set_value(offset, value);
-}
-
-static int ath79_gpio_direction_input(struct gpio_chip *chip,
-				       unsigned offset)
-{
-	void __iomem *base = ath79_gpio_base;
-	unsigned long flags;
-
-	spin_lock_irqsave(&ath79_gpio_lock, flags);
-
-	__raw_writel(__raw_readl(base + AR71XX_GPIO_REG_OE) & ~(1 << offset),
-		     base + AR71XX_GPIO_REG_OE);
-
-	spin_unlock_irqrestore(&ath79_gpio_lock, flags);
-
-	return 0;
-}
-
-static int ath79_gpio_direction_output(struct gpio_chip *chip,
-					unsigned offset, int value)
-{
-	void __iomem *base = ath79_gpio_base;
-	unsigned long flags;
-
-	spin_lock_irqsave(&ath79_gpio_lock, flags);
-
-	if (value)
-		__raw_writel(1 << offset, base + AR71XX_GPIO_REG_SET);
-	else
-		__raw_writel(1 << offset, base + AR71XX_GPIO_REG_CLEAR);
-
-	__raw_writel(__raw_readl(base + AR71XX_GPIO_REG_OE) | (1 << offset),
-		     base + AR71XX_GPIO_REG_OE);
-
-	spin_unlock_irqrestore(&ath79_gpio_lock, flags);
-
-	return 0;
-}
-
-static int ar934x_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
-{
-	void __iomem *base = ath79_gpio_base;
-	unsigned long flags;
-
-	spin_lock_irqsave(&ath79_gpio_lock, flags);
-
-	__raw_writel(__raw_readl(base + AR71XX_GPIO_REG_OE) | (1 << offset),
-		     base + AR71XX_GPIO_REG_OE);
-
-	spin_unlock_irqrestore(&ath79_gpio_lock, flags);
-
-	return 0;
-}
-
-static int ar934x_gpio_direction_output(struct gpio_chip *chip, unsigned offset,
-					int value)
-{
-	void __iomem *base = ath79_gpio_base;
-	unsigned long flags;
-
-	spin_lock_irqsave(&ath79_gpio_lock, flags);
-
-	if (value)
-		__raw_writel(1 << offset, base + AR71XX_GPIO_REG_SET);
-	else
-		__raw_writel(1 << offset, base + AR71XX_GPIO_REG_CLEAR);
-
-	__raw_writel(__raw_readl(base + AR71XX_GPIO_REG_OE) & ~(1 << offset),
-		     base + AR71XX_GPIO_REG_OE);
-
-	spin_unlock_irqrestore(&ath79_gpio_lock, flags);
-
-	return 0;
-}
-
-static struct gpio_chip ath79_gpio_chip = {
-	.label			= "ath79",
-	.get			= ath79_gpio_get_value,
-	.set			= ath79_gpio_set_value,
-	.direction_input	= ath79_gpio_direction_input,
-	.direction_output	= ath79_gpio_direction_output,
-	.base			= 0,
-};
-
-static const struct of_device_id ath79_gpio_of_match[] = {
-	{ .compatible = "qca,ar7100-gpio" },
-	{ .compatible = "qca,ar9340-gpio" },
-	{},
-};
-
-static int ath79_gpio_probe(struct platform_device *pdev)
-{
-	struct ath79_gpio_platform_data *pdata = pdev->dev.platform_data;
-	struct device_node *np = pdev->dev.of_node;
-	struct resource *res;
-	bool oe_inverted;
-	int err;
-
-	if (np) {
-		err = of_property_read_u32(np, "ngpios", &ath79_gpio_count);
-		if (err) {
-			dev_err(&pdev->dev, "ngpios property is not valid\n");
-			return err;
-		}
-		if (ath79_gpio_count >= 32) {
-			dev_err(&pdev->dev, "ngpios must be less than 32\n");
-			return -EINVAL;
-		}
-		oe_inverted = of_device_is_compatible(np, "qca,ar9340-gpio");
-	} else if (pdata) {
-		ath79_gpio_count = pdata->ngpios;
-		oe_inverted = pdata->oe_inverted;
-	} else {
-		dev_err(&pdev->dev, "No DT node or platform data found\n");
-		return -EINVAL;
-	}
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ath79_gpio_base = devm_ioremap_nocache(
-		&pdev->dev, res->start, resource_size(res));
-	if (!ath79_gpio_base)
-		return -ENOMEM;
-
-	ath79_gpio_chip.dev = &pdev->dev;
-	ath79_gpio_chip.ngpio = ath79_gpio_count;
-	if (oe_inverted) {
-		ath79_gpio_chip.direction_input = ar934x_gpio_direction_input;
-		ath79_gpio_chip.direction_output = ar934x_gpio_direction_output;
-	}
-
-	err = gpiochip_add(&ath79_gpio_chip);
-	if (err) {
-		dev_err(&pdev->dev,
-			"cannot add AR71xx GPIO chip, error=%d", err);
-		return err;
-	}
-
-	return 0;
-}
-
-static struct platform_driver ath79_gpio_driver = {
-	.driver = {
-		.name = "ath79-gpio",
-		.of_match_table	= ath79_gpio_of_match,
-	},
-	.probe = ath79_gpio_probe,
-};
-
-module_platform_driver(ath79_gpio_driver);
-
-int gpio_get_value(unsigned gpio)
-{
-	if (gpio < ath79_gpio_count)
-		return __ath79_gpio_get_value(gpio);
-
-	return __gpio_get_value(gpio);
-}
-EXPORT_SYMBOL(gpio_get_value);
-
-void gpio_set_value(unsigned gpio, int value)
-{
-	if (gpio < ath79_gpio_count)
-		__ath79_gpio_set_value(gpio, value);
-	else
-		__gpio_set_value(gpio, value);
-}
-EXPORT_SYMBOL(gpio_set_value);
-
-int gpio_to_irq(unsigned gpio)
-{
-	/* FIXME */
-	return -EINVAL;
-}
-EXPORT_SYMBOL(gpio_to_irq);
-
-int irq_to_gpio(unsigned irq)
-{
-	/* FIXME */
-	return -EINVAL;
-}
-EXPORT_SYMBOL(irq_to_gpio);
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index f82cd67..2b64f61 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_GPIO_ADP5588)	+= gpio-adp5588.o
 obj-$(CONFIG_GPIO_ALTERA)  	+= gpio-altera.o
 obj-$(CONFIG_GPIO_AMD8111)	+= gpio-amd8111.o
 obj-$(CONFIG_GPIO_ARIZONA)	+= gpio-arizona.o
+obj-$(CONFIG_ATH79)		+= gpio-ath79.o
 obj-$(CONFIG_GPIO_BCM_KONA)	+= gpio-bcm-kona.o
 obj-$(CONFIG_GPIO_BRCMSTB)	+= gpio-brcmstb.o
 obj-$(CONFIG_GPIO_BT8XX)	+= gpio-bt8xx.o
diff --git a/drivers/gpio/gpio-ath79.c b/drivers/gpio/gpio-ath79.c
new file mode 100644
index 0000000..c3c92eb
--- /dev/null
+++ b/drivers/gpio/gpio-ath79.c
@@ -0,0 +1,236 @@
+/*
+ *  Atheros AR71XX/AR724X/AR913X GPIO API support
+ *
+ *  Copyright (C) 2010-2011 Jaiganesh Narayanan <jnarayanan@atheros.com>
+ *  Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
+ *
+ *  Parts of this file are based on Atheros' 2.6.15/2.6.31 BSP
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/spinlock.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/gpio.h>
+#include <linux/platform_data/gpio-ath79.h>
+#include <linux/of_device.h>
+
+#include <asm/mach-ath79/ar71xx_regs.h>
+
+static void __iomem *ath79_gpio_base;
+static u32 ath79_gpio_count;
+static DEFINE_SPINLOCK(ath79_gpio_lock);
+
+static void __ath79_gpio_set_value(unsigned gpio, int value)
+{
+	void __iomem *base = ath79_gpio_base;
+
+	if (value)
+		__raw_writel(1 << gpio, base + AR71XX_GPIO_REG_SET);
+	else
+		__raw_writel(1 << gpio, base + AR71XX_GPIO_REG_CLEAR);
+}
+
+static int __ath79_gpio_get_value(unsigned gpio)
+{
+	return (__raw_readl(ath79_gpio_base + AR71XX_GPIO_REG_IN) >> gpio) & 1;
+}
+
+static int ath79_gpio_get_value(struct gpio_chip *chip, unsigned offset)
+{
+	return __ath79_gpio_get_value(offset);
+}
+
+static void ath79_gpio_set_value(struct gpio_chip *chip,
+				  unsigned offset, int value)
+{
+	__ath79_gpio_set_value(offset, value);
+}
+
+static int ath79_gpio_direction_input(struct gpio_chip *chip,
+				       unsigned offset)
+{
+	void __iomem *base = ath79_gpio_base;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ath79_gpio_lock, flags);
+
+	__raw_writel(__raw_readl(base + AR71XX_GPIO_REG_OE) & ~(1 << offset),
+		     base + AR71XX_GPIO_REG_OE);
+
+	spin_unlock_irqrestore(&ath79_gpio_lock, flags);
+
+	return 0;
+}
+
+static int ath79_gpio_direction_output(struct gpio_chip *chip,
+					unsigned offset, int value)
+{
+	void __iomem *base = ath79_gpio_base;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ath79_gpio_lock, flags);
+
+	if (value)
+		__raw_writel(1 << offset, base + AR71XX_GPIO_REG_SET);
+	else
+		__raw_writel(1 << offset, base + AR71XX_GPIO_REG_CLEAR);
+
+	__raw_writel(__raw_readl(base + AR71XX_GPIO_REG_OE) | (1 << offset),
+		     base + AR71XX_GPIO_REG_OE);
+
+	spin_unlock_irqrestore(&ath79_gpio_lock, flags);
+
+	return 0;
+}
+
+static int ar934x_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
+{
+	void __iomem *base = ath79_gpio_base;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ath79_gpio_lock, flags);
+
+	__raw_writel(__raw_readl(base + AR71XX_GPIO_REG_OE) | (1 << offset),
+		     base + AR71XX_GPIO_REG_OE);
+
+	spin_unlock_irqrestore(&ath79_gpio_lock, flags);
+
+	return 0;
+}
+
+static int ar934x_gpio_direction_output(struct gpio_chip *chip, unsigned offset,
+					int value)
+{
+	void __iomem *base = ath79_gpio_base;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ath79_gpio_lock, flags);
+
+	if (value)
+		__raw_writel(1 << offset, base + AR71XX_GPIO_REG_SET);
+	else
+		__raw_writel(1 << offset, base + AR71XX_GPIO_REG_CLEAR);
+
+	__raw_writel(__raw_readl(base + AR71XX_GPIO_REG_OE) & ~(1 << offset),
+		     base + AR71XX_GPIO_REG_OE);
+
+	spin_unlock_irqrestore(&ath79_gpio_lock, flags);
+
+	return 0;
+}
+
+static struct gpio_chip ath79_gpio_chip = {
+	.label			= "ath79",
+	.get			= ath79_gpio_get_value,
+	.set			= ath79_gpio_set_value,
+	.direction_input	= ath79_gpio_direction_input,
+	.direction_output	= ath79_gpio_direction_output,
+	.base			= 0,
+};
+
+static const struct of_device_id ath79_gpio_of_match[] = {
+	{ .compatible = "qca,ar7100-gpio" },
+	{ .compatible = "qca,ar9340-gpio" },
+	{},
+};
+
+static int ath79_gpio_probe(struct platform_device *pdev)
+{
+	struct ath79_gpio_platform_data *pdata = pdev->dev.platform_data;
+	struct device_node *np = pdev->dev.of_node;
+	struct resource *res;
+	bool oe_inverted;
+	int err;
+
+	if (np) {
+		err = of_property_read_u32(np, "ngpios", &ath79_gpio_count);
+		if (err) {
+			dev_err(&pdev->dev, "ngpios property is not valid\n");
+			return err;
+		}
+		if (ath79_gpio_count >= 32) {
+			dev_err(&pdev->dev, "ngpios must be less than 32\n");
+			return -EINVAL;
+		}
+		oe_inverted = of_device_is_compatible(np, "qca,ar9340-gpio");
+	} else if (pdata) {
+		ath79_gpio_count = pdata->ngpios;
+		oe_inverted = pdata->oe_inverted;
+	} else {
+		dev_err(&pdev->dev, "No DT node or platform data found\n");
+		return -EINVAL;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ath79_gpio_base = devm_ioremap_nocache(
+		&pdev->dev, res->start, resource_size(res));
+	if (!ath79_gpio_base)
+		return -ENOMEM;
+
+	ath79_gpio_chip.dev = &pdev->dev;
+	ath79_gpio_chip.ngpio = ath79_gpio_count;
+	if (oe_inverted) {
+		ath79_gpio_chip.direction_input = ar934x_gpio_direction_input;
+		ath79_gpio_chip.direction_output = ar934x_gpio_direction_output;
+	}
+
+	err = gpiochip_add(&ath79_gpio_chip);
+	if (err) {
+		dev_err(&pdev->dev,
+			"cannot add AR71xx GPIO chip, error=%d", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static struct platform_driver ath79_gpio_driver = {
+	.driver = {
+		.name = "ath79-gpio",
+		.of_match_table	= ath79_gpio_of_match,
+	},
+	.probe = ath79_gpio_probe,
+};
+
+module_platform_driver(ath79_gpio_driver);
+
+int gpio_get_value(unsigned gpio)
+{
+	if (gpio < ath79_gpio_count)
+		return __ath79_gpio_get_value(gpio);
+
+	return __gpio_get_value(gpio);
+}
+EXPORT_SYMBOL(gpio_get_value);
+
+void gpio_set_value(unsigned gpio, int value)
+{
+	if (gpio < ath79_gpio_count)
+		__ath79_gpio_set_value(gpio, value);
+	else
+		__gpio_set_value(gpio, value);
+}
+EXPORT_SYMBOL(gpio_set_value);
+
+int gpio_to_irq(unsigned gpio)
+{
+	/* FIXME */
+	return -EINVAL;
+}
+EXPORT_SYMBOL(gpio_to_irq);
+
+int irq_to_gpio(unsigned irq)
+{
+	/* FIXME */
+	return -EINVAL;
+}
+EXPORT_SYMBOL(irq_to_gpio);
-- 
2.0.0
