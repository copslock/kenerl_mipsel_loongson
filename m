Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Aug 2008 22:51:02 +0100 (BST)
Received: from smtp4.int-evry.fr ([157.159.10.71]:52168 "EHLO
	smtp4.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S20036672AbYHWVuz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 23 Aug 2008 22:50:55 +0100
Received: from smtp2.int-evry.fr (smtp2.int-evry.fr [157.159.10.45])
	by smtp4.int-evry.fr (Postfix) with ESMTP id A0F49FE2D6E;
	Sat, 23 Aug 2008 23:50:54 +0200 (CEST)
Received: from smtp-ext.int-evry.fr (smtp-ext.int-evry.fr [157.159.11.17])
	by smtp2.int-evry.fr (Postfix) with ESMTP id 599F23F0C23;
	Sat, 23 Aug 2008 23:49:33 +0200 (CEST)
Received: from lenovo.mimichou.home (florian.mimichou.net [82.241.112.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id 1A4D990004;
	Sat, 23 Aug 2008 23:49:33 +0200 (CEST)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Sat, 23 Aug 2008 23:49:27 +0200
Subject: [PATCH][RFT] au1000: convert to gpiolib
MIME-Version: 1.0
X-UID:	1163
X-Length: 10947
To:	"linux-mips" <linux-mips@linux-mips.org>
Cc:	ralf@linux-mips.org, Kevin Hickey <khickey@rmicorp.com>,
	Manuel Lauss <mano@roarinelk.homelinux.net>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200808232349.28277.florian@openwrt.org>
X-INT-MailScanner-Information: Please contact the ISP for more information
X-MailScanner-ID: 599F23F0C23.574E0
X-INT-MailScanner: Found to be clean
X-INT-MailScanner-SpamCheck: 
X-INT-MailScanner-From:	florian@openwrt.org
Return-Path: <florian@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20343
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch converts Au1000 to use gpiolib. Testers
welcome !

Manuel, Kevin, could you test this on your boards ? Thanks

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/au1000/Kconfig b/arch/mips/au1000/Kconfig
index e4a057d..e4f257f 100644
--- a/arch/mips/au1000/Kconfig
+++ b/arch/mips/au1000/Kconfig
@@ -134,3 +134,4 @@ config SOC_AU1X00
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_APM_EMULATION
+	select ARCH_REQUIRE_GPIOLIB
diff --git a/arch/mips/au1000/common/gpio.c b/arch/mips/au1000/common/gpio.c
index b485d94..67b3a6b 100644
--- a/arch/mips/au1000/common/gpio.c
+++ b/arch/mips/au1000/common/gpio.c
@@ -1,5 +1,5 @@
 /*
- *  Copyright (C) 2007, OpenWrt.org, Florian Fainelli <florian@openwrt.org>
+ *  Copyright (C) 2007-2008, Florian Fainelli <florian@openwrt.org>
  *  	Architecture specific GPIO support
  *
  *  This program is free software; you can redistribute	 it and/or modify it
@@ -27,120 +27,194 @@
  * 	others have a second one : GPIO2
  */
 
-#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
 
 #include <asm/mach-au1x00/au1000.h>
-#include <asm/gpio.h>
+#include <asm/mach-au1x00/gpio.h>
 
-#define gpio1 sys
-#if !defined(CONFIG_SOC_AU1000)
+struct au1000_gpio_chip {
+	struct gpio_chip	chip;
+	void __iomem 		*regbase;
+};
 
-static struct au1x00_gpio2 *const gpio2 = (struct au1x00_gpio2 *) GPIO2_BASE;
+#if !defined(CONFIG_SOC_AU1000)
 #define GPIO2_OUTPUT_ENABLE_MASK 	0x00010000
 
-static int au1xxx_gpio2_read(unsigned gpio)
+/*
+ * Return GPIO bank 2 level
+ */
+static int au1000_gpio2_get(struct gpio_chip *chip, unsigned offset)
 {
-	gpio -= AU1XXX_GPIO_BASE;
-	return ((gpio2->pinstate >> gpio) & 0x01);
+	u32			mask = 1 << offset;
+	struct au1000_gpio_chip	*gpch;
+
+	gpch = container_of(chip, struct au1000_gpio_chip, chip);
+	return readl(gpch->regbase + AU1000_GPIO2_ST) & mask;
 }
 
-static void au1xxx_gpio2_write(unsigned gpio, int value)
+/*
+ * Set output GPIO bank 2 level
+ */
+static void au1000_gpio2_set(struct gpio_chip *chip,
+				unsigned offset, int value)
 {
-	gpio -= AU1XXX_GPIO_BASE;
-
-	gpio2->output = (GPIO2_OUTPUT_ENABLE_MASK << gpio) | (value << gpio);
+	u32			mask = value << offset;
+	struct au1000_gpio_chip	*gpch;
+	
+	gpch = container_of(chip, struct au1000_gpio_chip, chip);
+	writel((GPIO2_OUTPUT_ENABLE_MASK << offset) | mask,
+					gpch->regbase + AU1000_GPIO2_OUT);
 }
 
-static int au1xxx_gpio2_direction_input(unsigned gpio)
+/*
+ * Set GPIO bank 2 direction to input
+ */
+static int au1000_gpio2_direction_input(struct gpio_chip *chip, unsigned offset)
 {
-	gpio -= AU1XXX_GPIO_BASE;
-	gpio2->dir &= ~(0x01 << gpio);
+	unsigned long		flags;
+	u32			mask = 1 << offset;
+	u32			value;
+	struct au1000_gpio_chip	*gpch;
+	void __iomem		*gpdr;
+
+	gpch = container_of(chip, struct au1000_gpio_chip, chip);
+	gpdr = gpch->regbase + AU1000_GPIO2_DIR;
+
+	local_irq_save(flags);
+	value = readl(gpdr);
+	value &= ~mask;
+	writel(value, gpdr);
+	local_irq_restore(flags);
+	
 	return 0;
 }
 
-static int au1xxx_gpio2_direction_output(unsigned gpio, int value)
+/*
+ * Set GPIO bank2 direction to output
+ */
+static int au1000_gpio2_direction_output(struct gpio_chip *chip,
+					unsigned offset, int value)
 {
-	gpio -= AU1XXX_GPIO_BASE;
-	gpio2->dir = (0x01 << gpio) | (value << gpio);
+	unsigned long		flags;
+	u32			mask = 1 << offset;
+	u32			tmp;
+	struct au1000_gpio_chip *gpch;
+	void __iomem		*gpdr;
+
+	gpch = container_of(chip, struct au1000_gpio_chip, chip);
+	gpdr = gpch->regbase + AU1000_GPIO2_DIR;
+
+	local_irq_save(flags);
+	tmp = readl(gpdr);
+	tmp |= mask;
+	writel(tmp, gpdr);
+	local_irq_restore(flags);
+
 	return 0;
 }
 
 #endif /* !defined(CONFIG_SOC_AU1000) */
 
-static int au1xxx_gpio1_read(unsigned gpio)
+static int au1000_gpio1_get(struct gpio_chip *chip, unsigned offset)
 {
-	return (gpio1->pinstaterd >> gpio) & 0x01;
+	u32			mask = 1 << offset;
+	struct au1000_gpio_chip *gpch;
+
+	gpch = container_of(chip, struct au1000_gpio_chip, chip);
+	return readl(gpch->regbase + 0x0110) & mask;
 }
 
-static void au1xxx_gpio1_write(unsigned gpio, int value)
+static void au1000_gpio1_set(struct gpio_chip *chip,
+				unsigned offset, int value)
 {
+	u32			mask = 1 << offset;
+	struct au1000_gpio_chip	*gpch;
+
+	gpch = container_of(chip, struct au1000_gpio_chip, chip);
 	if (value)
-		gpio1->outputset = (0x01 << gpio);
+		writel(mask, gpch->regbase + 0x0108);
 	else
-		/* Output a zero */
-		gpio1->outputclr = (0x01 << gpio);
+		writel(mask, gpch->regbase + 0x010C);
 }
 
-static int au1xxx_gpio1_direction_input(unsigned gpio)
+static int au1000_gpio1_direction_input(struct gpio_chip *chip, unsigned offset)
 {
-	gpio1->pininputen = (0x01 << gpio);
+	unsigned long		flags;
+	u32			mask = 1 << offset;
+	u32			value;
+	struct au1000_gpio_chip	*gpch;
+	void __iomem		*gpdr;
+
+	gpch = container_of(chip, struct au1000_gpio_chip, chip);
+	gpdr = gpch->regbase + 0x0110;
+	local_irq_save(flags);
+	value = readl(gpdr);
+	value |= mask;
+	writel(mask, gpdr);
+	local_irq_restore(flags);
+	
 	return 0;
 }
 
-static int au1xxx_gpio1_direction_output(unsigned gpio, int value)
+static int au1000_gpio1_direction_output(struct gpio_chip *chip,
+					unsigned offset, int value)
 {
-	gpio1->trioutclr = (0x01 & gpio);
-	return 0;
-}
+	unsigned long		flags;
+	u32			mask = 1 << offset;
+	u32			tmp;
+	struct au1000_gpio_chip	*gpch;
+	void __iomem		*gpdr;
+
+	gpch = container_of(chip, struct au1000_gpio_chip, chip);
+	gpdr = gpch->regbase + 0x0100;
+	local_irq_save(flags);
+	tmp = readl(gpdr);
+	tmp &= mask;
+	writel(mask, gpdr);
+	local_irq_restore(flags);
 
-int au1xxx_gpio_get_value(unsigned gpio)
-{
-	if (gpio >= AU1XXX_GPIO_BASE)
-#if defined(CONFIG_SOC_AU1000)
-		return 0;
-#else
-		return au1xxx_gpio2_read(gpio);
-#endif
-	else
-		return au1xxx_gpio1_read(gpio);
-}
-EXPORT_SYMBOL(au1xxx_gpio_get_value);
-
-void au1xxx_gpio_set_value(unsigned gpio, int value)
-{
-	if (gpio >= AU1XXX_GPIO_BASE)
-#if defined(CONFIG_SOC_AU1000)
-		;
-#else
-		au1xxx_gpio2_write(gpio, value);
-#endif
-	else
-		au1xxx_gpio1_write(gpio, value);
+	return 0;
 }
-EXPORT_SYMBOL(au1xxx_gpio_set_value);
 
-int au1xxx_gpio_direction_input(unsigned gpio)
-{
-	if (gpio >= AU1XXX_GPIO_BASE)
-#if defined(CONFIG_SOC_AU1000)
-		return -ENODEV;
-#else
-		return au1xxx_gpio2_direction_input(gpio);
+struct au1000_gpio_chip au1000_gpio_chip[] = {
+	[0] = {
+		.regbase			= (void __iomem *)SYS_BASE,
+		.chip = {
+			.label			= "au1000-gpio0",
+			.direction_input	= au1000_gpio1_direction_input,
+			.direction_output	= au1000_gpio1_direction_output,
+			.get			= au1000_gpio1_get,
+			.set			= au1000_gpio1_set,
+			.base			= 0,
+			.ngpio			= 32,
+		},
+	},
+#if !defined(CONFIG_SOC_AU1000)
+	[1] = {
+		.regbase			= (void __iomem *)GPIO2_BASE,
+		.chip = {
+			.label			= "au1000-gpio1",
+			.direction_input	= au1000_gpio2_direction_input,
+			.direction_output	= au1000_gpio2_direction_output,
+			.get			= au1000_gpio2_get,
+			.set			= au1000_gpio2_set,
+			.base			= AU1XXX_GPIO_BASE,
+			.ngpio			= 32,
+		},
+	},
 #endif
+};
 
-	return au1xxx_gpio1_direction_input(gpio);
-}
-EXPORT_SYMBOL(au1xxx_gpio_direction_input);
 
-int au1xxx_gpio_direction_output(unsigned gpio, int value)
+int __init au1000_gpio_init(void)
 {
-	if (gpio >= AU1XXX_GPIO_BASE)
-#if defined(CONFIG_SOC_AU1000)
-		return -ENODEV;
-#else
-		return au1xxx_gpio2_direction_output(gpio, value);
-#endif
-
-	return au1xxx_gpio1_direction_output(gpio, value);
+	gpiochip_add(&au1000_gpio_chip[0].chip);
+#if !defined(CONFIG_SOC_AU1000)
+	gpiochip_add(&au1000_gpio_chip[1].chip);
+#endif	
+	return 0;
 }
-EXPORT_SYMBOL(au1xxx_gpio_direction_output);
+arch_initcall(au1000_gpio_init);
diff --git a/include/asm-mips/mach-au1x00/gpio.h b/include/asm-mips/mach-au1x00/gpio.h
index 2dc61e0..d43c8f4 100644
--- a/include/asm-mips/mach-au1x00/gpio.h
+++ b/include/asm-mips/mach-au1x00/gpio.h
@@ -1,67 +1,22 @@
 #ifndef _AU1XXX_GPIO_H_
 #define _AU1XXX_GPIO_H_
 
-#include <linux/types.h>
-
 #define AU1XXX_GPIO_BASE	200
 
-struct au1x00_gpio2 {
-	u32	dir;
-	u32	reserved;
-	u32	output;
-	u32	pinstate;
-	u32	inten;
-	u32	enable;
-};
-
-extern int au1xxx_gpio_get_value(unsigned gpio);
-extern void au1xxx_gpio_set_value(unsigned gpio, int value);
-extern int au1xxx_gpio_direction_input(unsigned gpio);
-extern int au1xxx_gpio_direction_output(unsigned gpio, int value);
-
-
-/* Wrappers for the arch-neutral GPIO API */
-
-static inline int gpio_request(unsigned gpio, const char *label)
-{
-	/* Not yet implemented */
-	return 0;
-}
-
-static inline void gpio_free(unsigned gpio)
-{
-	/* Not yet implemented */
-}
-
-static inline int gpio_direction_input(unsigned gpio)
-{
-	return au1xxx_gpio_direction_input(gpio);
-}
-
-static inline int gpio_direction_output(unsigned gpio, int value)
-{
-	return au1xxx_gpio_direction_output(gpio, value);
-}
-
-static inline int gpio_get_value(unsigned gpio)
-{
-	return au1xxx_gpio_get_value(gpio);
-}
+#define AU1000_GPIO2_DIR	0x00
+#define AU1000_GPIO2_RSVD	0x04
+#define AU1000_GPIO2_OUT	0x08
+#define AU1000_GPIO2_ST		0x0C
+#define AU1000_GPIO2_INT	0x10
+#define AU1000_GPIO2_EN		0x14
 
-static inline void gpio_set_value(unsigned gpio, int value)
-{
-	au1xxx_gpio_set_value(gpio, value);
-}
+#define gpio_get_value __gpio_get_value
+#define gpio_set_value __gpio_set_value
 
-static inline int gpio_to_irq(unsigned gpio)
-{
-	return gpio;
-}
+#define gpio_cansleep __gpio_cansleep
 
-static inline int irq_to_gpio(unsigned irq)
-{
-	return irq;
-}
+#define gpio_to_irq(gpio)	IRQ_GPIO(gpio)
+#define irq_to_gpio(irq)	IRQ_TO_GPIO(irq)
 
 /* For cansleep */
 #include <asm-generic/gpio.h>
