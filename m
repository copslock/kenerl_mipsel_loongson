Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Dec 2010 21:31:27 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:37484 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491061Ab0LVUbW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Dec 2010 21:31:22 +0100
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id A86ED80F0;
        Wed, 22 Dec 2010 21:31:17 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id F22DE1F0001;
        Wed, 22 Dec 2010 21:31:16 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Imre Kaloz <kaloz@openwrt.org>,
        "Luis R. Rodriguez" <lrodriguez@atheros.com>,
        Cliff Holden <Cliff.Holden@Atheros.com>,
        Kathy Giori <Kathy.Giori@Atheros.com>,
        Gabor Juhos <juhosg@openwrt.org>,
        David Brownell <dbrownell@users.sourceforge.net>
Subject: [PATCH v2 02/16] MIPS: ath79: add GPIOLIB support
Date:   Wed, 22 Dec 2010 21:30:47 +0100
Message-Id: <1293049861-28913-3-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1293049861-28913-1-git-send-email-juhosg@openwrt.org>
References: <1293049861-28913-1-git-send-email-juhosg@openwrt.org>
X-VBMS: A10F2572671 | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28683
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch implements generic GPIO routines for the built-in
GPIO controllers of the Atheros AR71XX/AR724X/AR913X SoCs.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
Cc: David Brownell <dbrownell@users.sourceforge.net>
---

Changes since RFC: ---

Changes since v1:
    - rebased against 2.6.37-rc7

 arch/mips/Kconfig                              |    1 +
 arch/mips/ath79/Makefile                       |    2 +-
 arch/mips/ath79/common.h                       |    5 +
 arch/mips/ath79/gpio.c                         |  197 ++++++++++++++++++++++++
 arch/mips/ath79/setup.c                        |    2 +-
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |   21 +++
 arch/mips/include/asm/mach-ath79/gpio.h        |   26 +++
 7 files changed, 252 insertions(+), 2 deletions(-)
 create mode 100644 arch/mips/ath79/gpio.c
 create mode 100644 arch/mips/include/asm/mach-ath79/gpio.h

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index c0511d6..c3270a4 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -67,6 +67,7 @@ config AR7
 
 config ATH79
 	bool "Atheros AR71XX/AR724X/AR913X based boards"
+	select ARCH_REQUIRE_GPIOLIB
 	select BOOT_RAW
 	select CEVT_R4K
 	select CSRC_R4K
diff --git a/arch/mips/ath79/Makefile b/arch/mips/ath79/Makefile
index b4ec9c2..facbb70 100644
--- a/arch/mips/ath79/Makefile
+++ b/arch/mips/ath79/Makefile
@@ -8,7 +8,7 @@
 # under the terms of the GNU General Public License version 2 as published
 # by the Free Software Foundation.
 
-obj-y	:= prom.o setup.o irq.o common.o
+obj-y	:= prom.o setup.o irq.o common.o gpio.o
 
 obj-$(CONFIG_EARLY_PRINTK)		+= early_printk.o
 
diff --git a/arch/mips/ath79/common.h b/arch/mips/ath79/common.h
index a1bcdbb..cb2f3e8 100644
--- a/arch/mips/ath79/common.h
+++ b/arch/mips/ath79/common.h
@@ -22,4 +22,9 @@
 
 void ath79_ddr_wb_flush(unsigned int reg);
 
+void ath79_gpio_function_enable(u32 mask);
+void ath79_gpio_function_disable(u32 mask);
+void ath79_gpio_function_setup(u32 set, u32 clear);
+void ath79_gpio_init(void) __init;
+
 #endif /* __ATH79_COMMON_H */
diff --git a/arch/mips/ath79/gpio.c b/arch/mips/ath79/gpio.c
new file mode 100644
index 0000000..a0c426b
--- /dev/null
+++ b/arch/mips/ath79/gpio.c
@@ -0,0 +1,197 @@
+/*
+ *  Atheros AR71XX/AR724X/AR913X GPIO API support
+ *
+ *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
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
+
+#include <asm/mach-ath79/ar71xx_regs.h>
+#include <asm/mach-ath79/ath79.h>
+#include "common.h"
+
+static void __iomem *ath79_gpio_base;
+static unsigned long ath79_gpio_count;
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
+static struct gpio_chip ath79_gpio_chip = {
+	.label			= "ath79",
+	.get			= ath79_gpio_get_value,
+	.set			= ath79_gpio_set_value,
+	.direction_input	= ath79_gpio_direction_input,
+	.direction_output	= ath79_gpio_direction_output,
+	.base			= 0,
+};
+
+void ath79_gpio_function_enable(u32 mask)
+{
+	void __iomem *base = ath79_gpio_base;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ath79_gpio_lock, flags);
+
+	__raw_writel(__raw_readl(base + AR71XX_GPIO_REG_FUNC) | mask,
+		     base + AR71XX_GPIO_REG_FUNC);
+	/* flush write */
+	__raw_readl(base + AR71XX_GPIO_REG_FUNC);
+
+	spin_unlock_irqrestore(&ath79_gpio_lock, flags);
+}
+
+void ath79_gpio_function_disable(u32 mask)
+{
+	void __iomem *base = ath79_gpio_base;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ath79_gpio_lock, flags);
+
+	__raw_writel(__raw_readl(base + AR71XX_GPIO_REG_FUNC) & ~mask,
+		     base + AR71XX_GPIO_REG_FUNC);
+	/* flush write */
+	__raw_readl(base + AR71XX_GPIO_REG_FUNC);
+
+	spin_unlock_irqrestore(&ath79_gpio_lock, flags);
+}
+
+void ath79_gpio_function_setup(u32 set, u32 clear)
+{
+	void __iomem *base = ath79_gpio_base;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ath79_gpio_lock, flags);
+
+	__raw_writel((__raw_readl(base + AR71XX_GPIO_REG_FUNC) & ~clear) | set,
+		     base + AR71XX_GPIO_REG_FUNC);
+	/* flush write */
+	__raw_readl(base + AR71XX_GPIO_REG_FUNC);
+
+	spin_unlock_irqrestore(&ath79_gpio_lock, flags);
+}
+
+void __init ath79_gpio_init(void)
+{
+	int err;
+
+	if (soc_is_ar71xx())
+		ath79_gpio_count = AR71XX_GPIO_COUNT;
+	else if (soc_is_ar724x())
+		ath79_gpio_count = AR724X_GPIO_COUNT;
+	else if (soc_is_ar913x())
+		ath79_gpio_count = AR913X_GPIO_COUNT;
+	else
+		BUG();
+
+	ath79_gpio_base = ioremap_nocache(AR71XX_GPIO_BASE, AR71XX_GPIO_SIZE);
+	ath79_gpio_chip.ngpio = ath79_gpio_count;
+
+	err = gpiochip_add(&ath79_gpio_chip);
+	if (err)
+		panic("cannot add AR71xx GPIO chip, error=%d", err);
+}
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
diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
index 4157ddc..83dd855 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -230,7 +230,6 @@ void __init plat_mem_setup(void)
 					   AR71XX_RESET_SIZE);
 	ath79_pll_base = ioremap_nocache(AR71XX_PLL_BASE,
 					 AR71XX_PLL_SIZE);
-
 	ath79_ddr_base = ioremap_nocache(AR71XX_DDR_CTRL_BASE,
 					 AR71XX_DDR_CTRL_SIZE);
 
@@ -256,6 +255,7 @@ void __init plat_time_init(void)
 
 static int __init ath79_setup(void)
 {
+	ath79_gpio_init();
 	ath79_register_uart();
 	return 0;
 }
diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
index 5a9e5e1..7f2933d 100644
--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -25,6 +25,8 @@
 #define AR71XX_DDR_CTRL_SIZE	0x100
 #define AR71XX_UART_BASE	(AR71XX_APB_BASE + 0x00020000)
 #define AR71XX_UART_SIZE	0x100
+#define AR71XX_GPIO_BASE        (AR71XX_APB_BASE + 0x00040000)
+#define AR71XX_GPIO_SIZE        0x100
 #define AR71XX_PLL_BASE		(AR71XX_APB_BASE + 0x00050000)
 #define AR71XX_PLL_SIZE		0x100
 #define AR71XX_RESET_BASE	(AR71XX_APB_BASE + 0x00060000)
@@ -204,4 +206,23 @@
 #define AR71XX_SPI_IOC_CS_ALL	(AR71XX_SPI_IOC_CS0 | AR71XX_SPI_IOC_CS1 | \
 				 AR71XX_SPI_IOC_CS2)
 
+/*
+ * GPIO block
+ */
+#define AR71XX_GPIO_REG_OE		0x00
+#define AR71XX_GPIO_REG_IN		0x04
+#define AR71XX_GPIO_REG_OUT		0x08
+#define AR71XX_GPIO_REG_SET		0x0c
+#define AR71XX_GPIO_REG_CLEAR		0x10
+#define AR71XX_GPIO_REG_INT_MODE	0x14
+#define AR71XX_GPIO_REG_INT_TYPE	0x18
+#define AR71XX_GPIO_REG_INT_POLARITY	0x1c
+#define AR71XX_GPIO_REG_INT_PENDING	0x20
+#define AR71XX_GPIO_REG_INT_ENABLE	0x24
+#define AR71XX_GPIO_REG_FUNC		0x28
+
+#define AR71XX_GPIO_COUNT		16
+#define AR724X_GPIO_COUNT		18
+#define AR913X_GPIO_COUNT		22
+
 #endif /* __ASM_MACH_AR71XX_REGS_H */
diff --git a/arch/mips/include/asm/mach-ath79/gpio.h b/arch/mips/include/asm/mach-ath79/gpio.h
new file mode 100644
index 0000000..60dcb62
--- /dev/null
+++ b/arch/mips/include/asm/mach-ath79/gpio.h
@@ -0,0 +1,26 @@
+/*
+ *  Atheros AR71XX/AR724X/AR913X GPIO API definitions
+ *
+ *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ */
+
+#ifndef __ASM_MACH_ATH79_GPIO_H
+#define __ASM_MACH_ATH79_GPIO_H
+
+#define ARCH_NR_GPIOS	64
+#include <asm-generic/gpio.h>
+
+int gpio_to_irq(unsigned gpio);
+int irq_to_gpio(unsigned irq);
+int gpio_get_value(unsigned gpio);
+void gpio_set_value(unsigned gpio, int value);
+
+#define gpio_cansleep	__gpio_cansleep
+
+#endif /* __ASM_MACH_ATH79_GPIO_H */
-- 
1.7.2.1
