Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Jan 2010 21:17:13 +0100 (CET)
Received: from mail-ew0-f223.google.com ([209.85.219.223]:50138 "EHLO
        mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492583Ab0ACURJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Jan 2010 21:17:09 +0100
Received: by ewy23 with SMTP id 23so416198ewy.24
        for <multiple recipients>; Sun, 03 Jan 2010 12:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:cc:reply-to:content-type
         :content-transfer-encoding:message-id;
        bh=4yniO0wslh/Cc1BZ6s1zJphBnDiT1JHV8IzmEJ4FkD4=;
        b=Om6QyjNPmogH7bPHgKP8KYOLZM4hFYQIKNcYTmUAgaxu+YA9QMlYh0HkN6rddcFtt8
         mEZhBH7vdOuyuBnMq8kcUprqMuzMP6xVQCPdkDZBrqjL1ZuNmmJ9oGUzoT5ZX3bg+Y2Y
         xxlmNSAAeoRvQf4kOV3wfU2E1saja1GelT6ds=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:cc:reply-to
         :content-type:content-transfer-encoding:message-id;
        b=p5x6BQU1KyR/Vm8YfOCS6hfLPBhbdcJTkRpBCWPSPKgFaa/hHEjdzUF1PZU/1Qk4Lh
         BmA3xT/JacGLpk1zkpoQG9dOb9Hv2qS9S5nO89bXaF8AqU4uUwq/NB1pSqtA8yFBnru0
         LeJ+bTvGXmvDrNyA3nSC+5dH+fNJMzbGvKhNQ=
Received: by 10.216.164.9 with SMTP id b9mr3227121wel.153.1262549815640;
        Sun, 03 Jan 2010 12:16:55 -0800 (PST)
Received: from lenovo.localnet (92.59.76-86.rev.gaoland.net [86.76.59.92])
        by mx.google.com with ESMTPS id 28sm41922519eye.5.2010.01.03.12.16.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 03 Jan 2010 12:16:55 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
Date:   Sun, 3 Jan 2010 21:16:51 +0100
Subject: [PATCH 1/4] ar7: implement gpiolib
MIME-Version: 1.0
X-Length: 8020
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Reply-To: Florian Fainelli <florian@openwrt.org>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201001032116.52819.florian@openwrt.org>
X-archive-position: 25486
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 1991

This patch implements gpiolib for the AR7 SoC.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 9541171..bd80252 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -41,7 +41,7 @@ config AR7
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_SUPPORTS_ZBOOT_UART16550
-	select GENERIC_GPIO
+	select ARCH_REQUIRE_GPIOLIB
 	select GCD
 	select VLYNQ
 	help
diff --git a/arch/mips/ar7/gpio.c b/arch/mips/ar7/gpio.c
index 74e14a3..0e9f4e1 100644
--- a/arch/mips/ar7/gpio.c
+++ b/arch/mips/ar7/gpio.c
@@ -1,6 +1,7 @@
 /*
  * Copyright (C) 2007 Felix Fietkau <nbd@openwrt.org>
  * Copyright (C) 2007 Eugene Konev <ejka@openwrt.org>
+ * Copyright (C) 2009 Florian Fainelli <florian@openwrt.org>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -18,31 +19,113 @@
  */
 
 #include <linux/module.h>
+#include <linux/gpio.h>
 
 #include <asm/mach-ar7/gpio.h>
 
-static const char *ar7_gpio_list[AR7_GPIO_MAX];
+struct ar7_gpio_chip {
+	void __iomem	*regs;
+	struct gpio_chip chip;
+};
 
-int gpio_request(unsigned gpio, const char *label)
+static int ar7_gpio_get_value(struct gpio_chip *chip, unsigned gpio)
 {
-	if (gpio >= AR7_GPIO_MAX)
-		return -EINVAL;
+	struct ar7_gpio_chip *gpch =
+				container_of(chip, struct ar7_gpio_chip, chip);
+	void __iomem *gpio_in = gpch->regs + AR7_GPIO_INPUT;
 
-	if (ar7_gpio_list[gpio])
-		return -EBUSY;
+	return readl(gpio_in) & (1 << gpio);
+}
+
+static void ar7_gpio_set_value(struct gpio_chip *chip,
+				unsigned gpio, int value)
+{
+	struct ar7_gpio_chip *gpch =
+				container_of(chip, struct ar7_gpio_chip, chip);
+	void __iomem *gpio_out = gpch->regs + AR7_GPIO_OUTPUT;
+	unsigned tmp;
+
+	tmp = readl(gpio_out) & ~(1 << gpio);
+	if (value)
+		tmp |= 1 << gpio;
+	writel(tmp, gpio_out);
+}
+
+static int ar7_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
+{
+	struct ar7_gpio_chip *gpch =
+				container_of(chip, struct ar7_gpio_chip, chip);
+	void __iomem *gpio_dir = gpch->regs + AR7_GPIO_DIR;
 
-	if (label)
-		ar7_gpio_list[gpio] = label;
-	else
-		ar7_gpio_list[gpio] = "busy";
+	writel(readl(gpio_dir) | (1 << gpio), gpio_dir);
 
 	return 0;
 }
-EXPORT_SYMBOL(gpio_request);
 
-void gpio_free(unsigned gpio)
+static int ar7_gpio_direction_output(struct gpio_chip *chip,
+					unsigned gpio, int value)
 {
-	BUG_ON(!ar7_gpio_list[gpio]);
-	ar7_gpio_list[gpio] = NULL;
+	struct ar7_gpio_chip *gpch =
+				container_of(chip, struct ar7_gpio_chip, chip);
+	void __iomem *gpio_dir = gpch->regs + AR7_GPIO_DIR;
+
+	ar7_gpio_set_value(chip, gpio, value);
+	writel(readl(gpio_dir) & ~(1 << gpio), gpio_dir);
+
+	return 0;
+}
+
+static struct ar7_gpio_chip ar7_gpio_chip = {
+	.chip = {
+		.label		= "ar7-gpio",
+		.direction_input	= ar7_gpio_direction_input,
+		.direction_output	= ar7_gpio_direction_output,
+		.set			= ar7_gpio_set_value,
+		.get			= ar7_gpio_get_value,
+		.base			= 0,
+		.ngpio			= AR7_GPIO_MAX,
+	}
+};
+
+int ar7_gpio_enable(unsigned gpio)
+{
+	void __iomem *gpio_en = ar7_gpio_chip.regs + AR7_GPIO_ENABLE;
+
+	writel(readl(gpio_en) | (1 << gpio), gpio_en);
+
+	return 0;
+}
+EXPORT_SYMBOL(ar7_gpio_enable);
+
+int ar7_gpio_disable(unsigned gpio)
+{
+	void __iomem *gpio_en = ar7_gpio_chip.regs + AR7_GPIO_ENABLE;
+
+	writel(readl(gpio_en) & ~(1 << gpio), gpio_en);
+
+	return 0;
+}
+EXPORT_SYMBOL(ar7_gpio_disable);
+
+static int __init ar7_gpio_init(void)
+{
+	int ret;
+
+	ar7_gpio_chip.regs = ioremap_nocache(AR7_REGS_GPIO,
+					AR7_REGS_GPIO + 0x10);
+
+	if (!ar7_gpio_chip.regs) {
+		printk(KERN_ERR "ar7-gpio: failed to ioremap regs\n");
+		return -ENOMEM;
+	}
+
+	ret = gpiochip_add(&ar7_gpio_chip.chip);
+	if (ret) {
+		printk(KERN_ERR "ar7-gpio: failed to add gpiochip\n");
+		return ret;
+	}
+	printk(KERN_INFO "ar7-gpio: registered %d GPIOs\n",
+				ar7_gpio_chip.chip.ngpio);
+	return ret;
 }
-EXPORT_SYMBOL(gpio_free);
+arch_initcall(ar7_gpio_init);
diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
index 85169c0..acbe147 100644
--- a/arch/mips/ar7/platform.c
+++ b/arch/mips/ar7/platform.c
@@ -34,6 +34,7 @@
 #include <linux/etherdevice.h>
 #include <linux/phy.h>
 #include <linux/phy_fixed.h>
+#include <linux/gpio.h>
 
 #include <asm/addrspace.h>
 #include <asm/mach-ar7/ar7.h>
diff --git a/arch/mips/include/asm/mach-ar7/gpio.h b/arch/mips/include/asm/mach-ar7/gpio.h
index cbe9c4f..73f9b16 100644
--- a/arch/mips/include/asm/mach-ar7/gpio.h
+++ b/arch/mips/include/asm/mach-ar7/gpio.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007 Florian Fainelli <florian@openwrt.org>
+ * Copyright (C) 2007-2009 Florian Fainelli <florian@openwrt.org>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -22,88 +22,18 @@
 #include <asm/mach-ar7/ar7.h>
 
 #define AR7_GPIO_MAX 32
+#define NR_BUILTIN_GPIO AR7_GPIO_MAX
 
-extern int gpio_request(unsigned gpio, const char *label);
-extern void gpio_free(unsigned gpio);
+#define gpio_to_irq(gpio)	NULL
 
-/* Common GPIO layer */
-static inline int gpio_get_value(unsigned gpio)
-{
-	void __iomem *gpio_in =
-		(void __iomem *)KSEG1ADDR(AR7_REGS_GPIO + AR7_GPIO_INPUT);
+#define gpio_get_value __gpio_get_value
+#define gpio_set_value __gpio_set_value
 
-	return readl(gpio_in) & (1 << gpio);
-}
-
-static inline void gpio_set_value(unsigned gpio, int value)
-{
-	void __iomem *gpio_out =
-		(void __iomem *)KSEG1ADDR(AR7_REGS_GPIO + AR7_GPIO_OUTPUT);
-	unsigned tmp;
-
-	tmp = readl(gpio_out) & ~(1 << gpio);
-	if (value)
-		tmp |= 1 << gpio;
-	writel(tmp, gpio_out);
-}
-
-static inline int gpio_direction_input(unsigned gpio)
-{
-	void __iomem *gpio_dir =
-		(void __iomem *)KSEG1ADDR(AR7_REGS_GPIO + AR7_GPIO_DIR);
-
-	if (gpio >= AR7_GPIO_MAX)
-		return -EINVAL;
-
-	writel(readl(gpio_dir) | (1 << gpio), gpio_dir);
-
-	return 0;
-}
-
-static inline int gpio_direction_output(unsigned gpio, int value)
-{
-	void __iomem *gpio_dir =
-		(void __iomem *)KSEG1ADDR(AR7_REGS_GPIO + AR7_GPIO_DIR);
-
-	if (gpio >= AR7_GPIO_MAX)
-		return -EINVAL;
-
-	gpio_set_value(gpio, value);
-	writel(readl(gpio_dir) & ~(1 << gpio), gpio_dir);
-
-	return 0;
-}
-
-static inline int gpio_to_irq(unsigned gpio)
-{
-	return -EINVAL;
-}
-
-static inline int irq_to_gpio(unsigned irq)
-{
-	return -EINVAL;
-}
+#define gpio_cansleep __gpio_cansleep
 
 /* Board specific GPIO functions */
-static inline int ar7_gpio_enable(unsigned gpio)
-{
-	void __iomem *gpio_en =
-		(void __iomem *)KSEG1ADDR(AR7_REGS_GPIO + AR7_GPIO_ENABLE);
-
-	writel(readl(gpio_en) | (1 << gpio), gpio_en);
-
-	return 0;
-}
-
-static inline int ar7_gpio_disable(unsigned gpio)
-{
-	void __iomem *gpio_en =
-		(void __iomem *)KSEG1ADDR(AR7_REGS_GPIO + AR7_GPIO_ENABLE);
-
-	writel(readl(gpio_en) & ~(1 << gpio), gpio_en);
-
-	return 0;
-}
+int ar7_gpio_enable(unsigned gpio);
+int ar7_gpio_disable(unsigned gpio);
 
 #include <asm-generic/gpio.h>
 
