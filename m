Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 May 2009 19:26:17 +0100 (BST)
Received: from ey-out-1920.google.com ([74.125.78.144]:12800 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20024191AbZEaSZw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 31 May 2009 19:25:52 +0100
Received: by ey-out-1920.google.com with SMTP id 4so302959eyg.54
        for <multiple recipients>; Sun, 31 May 2009 11:25:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=npfmOGPlrrm+ogrCOxBWxcv/9xckOrHx4iaZNWYyikI=;
        b=AUJoQB2KXA1f8hy9yHWFrksDlqwPg+uilHw4g7IhonSRfmqFVtD+rUtaBsRvuHPZxi
         YjwxcQ5SBsKEbbq4ZC76pwUHijolNilfKWyI0WwSmnLK3hIgQxsw7oaO5HglqaWviCE7
         tb+avXGC/6mrVrPv2TNi6C88ORoLzjX0CbXJc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=cLrfiYyTaidaksOD6PgYvHTBU5X5rC0/Qz08VQiH6C9JsRGQGd5TP6TkPVxzqO2CAs
         oTxsqV+1P4QNJFUcWR7aNusVqb49CHPit4RharA/98d9NmeI7/mnoSxzOl7VlWZqTjJH
         xel4mF4iaxuMGKO38h1ZQkSavBhen3y0kxuks=
Received: by 10.210.35.17 with SMTP id i17mr2015544ebi.67.1243794352132;
        Sun, 31 May 2009 11:25:52 -0700 (PDT)
Received: from ?192.168.1.20? (207.130.195-77.rev.gaoland.net [77.195.130.207])
        by mx.google.com with ESMTPS id 23sm157385eya.39.2009.05.31.11.25.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 31 May 2009 11:25:51 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Sun, 31 May 2009 20:25:47 +0200
Subject: [PATCH 01/10] bcm63xx: convert to use gpiolib
MIME-Version: 1.0
X-UID:	133
X-Length: 6924
To:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Maxime Bizon <mbizon@freebox.fr>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200905312025.48300.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23090
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch converts the existing GPIO
board code to use gpiolib.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 08f8e3c..05ee268 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -71,7 +71,7 @@ config BCM63XX
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_HAS_EARLY_PRINTK
 	select SWAP_IO_SPACE
-	select GENERIC_GPIO
+	select ARCH_REQUIRE_GPIOLIB
 	help
 	 Support for BCM63XX based boards
 
diff --git a/arch/mips/bcm63xx/gpio.c b/arch/mips/bcm63xx/gpio.c
index 2c203a6..b78d3fd 100644
--- a/arch/mips/bcm63xx/gpio.c
+++ b/arch/mips/bcm63xx/gpio.c
@@ -4,26 +4,29 @@
  * for more details.
  *
  * Copyright (C) 2008 Maxime Bizon <mbizon@freebox.fr>
+ * Copyright (C) 2008 Florian Fainelli <florian@openwrt.org>
  */
 
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+
 #include <bcm63xx_cpu.h>
 #include <bcm63xx_gpio.h>
 #include <bcm63xx_io.h>
 #include <bcm63xx_regs.h>
 
-static DEFINE_SPINLOCK(bcm63xx_gpio_lock);
-
-void bcm63xx_gpio_set_dataout(int gpio, int val)
+static void bcm63xx_gpio_set(struct gpio_chip *chip,
+				unsigned gpio, int val)
 {
 	u32 reg;
 	u32 mask;
 	u32 tmp;
 	unsigned long flags;
 
-	if (gpio >= BCM63XX_GPIO_COUNT)
+	if (gpio >= chip->ngpio)
 		BUG();
 
 	if (gpio < 32) {
@@ -34,24 +37,22 @@ void bcm63xx_gpio_set_dataout(int gpio, int val)
 		mask = 1 << (gpio - 32);
 	}
 
-	spin_lock_irqsave(&bcm63xx_gpio_lock, flags);
+	local_irq_save(flags);
 	tmp = bcm_gpio_readl(reg);
 	if (val)
 		tmp |= mask;
 	else
 		tmp &= ~mask;
 	bcm_gpio_writel(tmp, reg);
-	spin_unlock_irqrestore(&bcm63xx_gpio_lock, flags);
+	local_irq_restore(flags);
 }
 
-EXPORT_SYMBOL(bcm63xx_gpio_set_dataout);
-
-int bcm63xx_gpio_get_datain(int gpio)
+static int bcm63xx_gpio_get(struct gpio_chip *chip, unsigned gpio)
 {
 	u32 reg;
 	u32 mask;
 
-	if (gpio >= BCM63XX_GPIO_COUNT)
+	if (gpio >= chip->ngpio)
 		BUG();
 
 	if (gpio < 32) {
@@ -65,16 +66,15 @@ int bcm63xx_gpio_get_datain(int gpio)
 	return !!(bcm_gpio_readl(reg) & mask);
 }
 
-EXPORT_SYMBOL(bcm63xx_gpio_get_datain);
-
-void bcm63xx_gpio_set_direction(int gpio, int dir)
+static int bcm63xx_gpio_set_direction(struct gpio_chip *chip,
+					unsigned gpio, int dir)
 {
 	u32 reg;
 	u32 mask;
 	u32 tmp;
 	unsigned long flags;
 
-	if (gpio >= BCM63XX_GPIO_COUNT)
+	if (gpio >= chip->ngpio)
 		BUG();
 
 	if (gpio < 32) {
@@ -85,14 +85,44 @@ void bcm63xx_gpio_set_direction(int gpio, int dir)
 		mask = 1 << (gpio - 32);
 	}
 
-	spin_lock_irqsave(&bcm63xx_gpio_lock, flags);
+	local_irq_save(flags);
 	tmp = bcm_gpio_readl(reg);
 	if (dir == GPIO_DIR_IN)
 		tmp &= ~mask;
 	else
 		tmp |= mask;
 	bcm_gpio_writel(tmp, reg);
-	spin_unlock_irqrestore(&bcm63xx_gpio_lock, flags);
+	local_irq_restore(flags);
+
+	return 0;
+}
+
+static int bcm63xx_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
+{
+	return bcm63xx_gpio_set_direction(chip, gpio, GPIO_DIR_IN);
 }
 
-EXPORT_SYMBOL(bcm63xx_gpio_set_direction);
+static int bcm63xx_gpio_direction_output(struct gpio_chip *chip,
+					unsigned gpio, int value)
+{
+	bcm63xx_gpio_set(chip, gpio, value);
+	return bcm63xx_gpio_set_direction(chip, gpio, GPIO_DIR_OUT);
+}
+
+
+static struct gpio_chip bcm63xx_gpio_chip = {
+	.label			= "bcm63xx-gpio",
+	.direction_input	= bcm63xx_gpio_direction_input,
+	.direction_output	= bcm63xx_gpio_direction_output,
+	.get			= bcm63xx_gpio_get,
+	.set			= bcm63xx_gpio_set,
+	.base			= 0,
+	.ngpio			= BCM63XX_GPIO_COUNT,
+};
+
+static int __init bcm63xx_gpio_init(void)
+{
+	printk(KERN_INFO "registering %d GPIOs\n", BCM63XX_GPIO_COUNT);
+	return gpiochip_add(&bcm63xx_gpio_chip);
+}
+arch_initcall(bcm63xx_gpio_init);
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h
index 31145df..72cee75 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h
@@ -4,10 +4,6 @@
 /* all helpers will BUG() if gpio count is >= 37. */
 #define BCM63XX_GPIO_COUNT	37
 
-void bcm63xx_gpio_set_dataout(int gpio, int val);
-int bcm63xx_gpio_get_datain(int gpio);
-void bcm63xx_gpio_set_direction(int gpio, int dir);
-
 #define GPIO_DIR_OUT	0x0
 #define GPIO_DIR_IN	0x1
 
diff --git a/arch/mips/include/asm/mach-bcm63xx/gpio.h b/arch/mips/include/asm/mach-bcm63xx/gpio.h
index dd2c0f3..033c997 100644
--- a/arch/mips/include/asm/mach-bcm63xx/gpio.h
+++ b/arch/mips/include/asm/mach-bcm63xx/gpio.h
@@ -3,50 +3,15 @@
 
 #include <bcm63xx_gpio.h>
 
-static inline int gpio_is_valid(int number)
-{
-	return (number >= BCM63XX_GPIO_COUNT) ? 0 : 1;
-}
+#define NR_BUILTIN_GPIO		BCM63XX_GPIO_COUNT
 
-static inline int gpio_request(unsigned gpio, const char *label)
-{
-	return 0;
-}
+#define gpio_to_irq(gpio)	NULL
 
-static inline void gpio_free(unsigned gpio)
-{
-}
+#define gpio_get_value __gpio_get_value
+#define gpio_set_value __gpio_set_value
 
-static inline int gpio_direction_input(unsigned gpio)
-{
-	bcm63xx_gpio_set_direction(gpio, GPIO_DIR_IN);
-	return 0;
-}
+#define gpio_cansleep __gpio_cansleep
 
-static inline int gpio_direction_output(unsigned gpio, int value)
-{
-	bcm63xx_gpio_set_direction(gpio, GPIO_DIR_OUT);
-	return 0;
-}
-
-static inline int gpio_get_value(unsigned gpio)
-{
-	return bcm63xx_gpio_get_datain(gpio);
-}
-
-static inline void gpio_set_value(unsigned gpio, int value)
-{
-	bcm63xx_gpio_set_dataout(gpio, value);
-}
-
-static inline int gpio_to_irq(unsigned gpio)
-{
-	return gpio;
-}
-
-static inline int irq_to_gpio(unsigned irq)
-{
-	return irq;
-}
+#include <asm-generic/gpio.h>
 
 #endif /* __ASM_MIPS_MACH_BCM63XX_GPIO_H */
