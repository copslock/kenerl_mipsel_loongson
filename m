Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2009 15:46:59 +0000 (GMT)
Received: from fg-out-1718.google.com ([72.14.220.158]:17128 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S21365163AbZAOPq4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Jan 2009 15:46:56 +0000
Received: by fg-out-1718.google.com with SMTP id d23so551447fga.32
        for <multiple recipients>; Thu, 15 Jan 2009 07:46:55 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=wsShpYo4XmtV9Manx+3ZZdJpGX/4L46HA8/J1ulhCxc=;
        b=hppTXskPwT3gAaq0LyvedtSwiPtBBOyFfQTz/OjNdKwQA4Q3Tn4L3VfaW4VgtHOEiK
         g788Zyz2Ia3TlNMPz50GSgDjpUrriA7o1NLJ/YxLgDf3VxdxY/4RkkNG1Xj/7DaNKHqJ
         a6D1VxIqQZluv1zL/+9ATgiy97lvu03B4z0Qs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=BfeeV12ImzbwAONca0pIkqr/p1V7xig28Ww1qjFB2tCaBLLFDGEzNT6Wixo42+gtrS
         cyofucAGQov+TGxjzpUR0GbmyAXxsIbruD61N7NH/Z2xITJMn9oLkZQ1Dw+FkONjib7g
         8I+UplORr6Yj+i+vGwGS3qC8fuSTGEQWwNPJI=
Received: by 10.103.224.17 with SMTP id b17mr726150mur.61.1232034414664;
        Thu, 15 Jan 2009 07:46:54 -0800 (PST)
Received: from ?192.168.2.188? (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id j2sm92879mue.5.2009.01.15.07.46.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Jan 2009 07:46:53 -0800 (PST)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Thu, 15 Jan 2009 16:46:48 +0100
Subject: [PATCH] au1000: convert to using gpiolib
MIME-Version: 1.0
X-UID:	50
X-Length: 11115
To:	ralf@linux-mips.org, Manuel Lauss <mano@roarinelk.homelinux.net>,
	Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200901151646.49591.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21749
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch converts the GPIO board code to use gpiolib.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/alchemy/Kconfig b/arch/mips/alchemy/Kconfig
index 7f8ef13..2fc5c13 100644
--- a/arch/mips/alchemy/Kconfig
+++ b/arch/mips/alchemy/Kconfig
@@ -135,3 +135,4 @@ config SOC_AU1X00
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_APM_EMULATION
 	select GENERIC_HARDIRQS_NO__DO_IRQ
+	select ARCH_REQUIRE_GPIOLIB
diff --git a/arch/mips/alchemy/common/gpio.c b/arch/mips/alchemy/common/gpio.c
index e660ddd..46be37b 100644
--- a/arch/mips/alchemy/common/gpio.c
+++ b/arch/mips/alchemy/common/gpio.c
@@ -1,5 +1,5 @@
 /*
- *  Copyright (C) 2007, OpenWrt.org, Florian Fainelli <florian@openwrt.org>
+ *  Copyright (C) 2007-2009, OpenWrt.org, Florian Fainelli <florian@openwrt.org>
  *  	Architecture specific GPIO support
  *
  *  This program is free software; you can redistribute	 it and/or modify it
@@ -27,122 +27,175 @@
  * 	others have a second one : GPIO2
  */
 
+#include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/types.h>
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
 
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/gpio.h>
 
-#define gpio1 sys
-#if !defined(CONFIG_SOC_AU1000)
-
-static struct au1x00_gpio2 *const gpio2 = (struct au1x00_gpio2 *) GPIO2_BASE;
-#define GPIO2_OUTPUT_ENABLE_MASK 	0x00010000
+struct au1000_gpio_chip {
+	struct gpio_chip	chip;
+	void __iomem		*regbase;
+};
 
-static int au1xxx_gpio2_read(unsigned gpio)
+#if !defined(CONFIG_SOC_AU1000)
+static int au1000_gpio2_get(struct gpio_chip *chip, unsigned offset)
 {
-	gpio -= AU1XXX_GPIO_BASE;
-	return ((gpio2->pinstate >> gpio) & 0x01);
+	u32 mask = 1 << offset;
+	struct au1000_gpio_chip *gpch;
+
+	gpch = container_of(chip, struct au1000_gpio_chip, chip);
+	return readl(gpch->regbase + AU1000_GPIO2_ST) & mask;
 }
 
-static void au1xxx_gpio2_write(unsigned gpio, int value)
+static void au1000_gpio2_set(struct gpio_chip *chip,
+				unsigned offset, int value)
 {
-	gpio -= AU1XXX_GPIO_BASE;
+	u32 mask = ((GPIO2_OUT_EN_MASK << offset) | (!!value << offset));
+	struct au1000_gpio_chip *gpch;
+	unsigned long flags;
+
+	gpch = container_of(chip, struct au1000_gpio_chip, chip);
 
-	gpio2->output = (GPIO2_OUTPUT_ENABLE_MASK << gpio) | ((!!value) << gpio);
+	local_irq_save(flags);
+	writel(mask, gpch->regbase + AU1000_GPIO2_OUT);
+	local_irq_restore(flags);
 }
 
-static int au1xxx_gpio2_direction_input(unsigned gpio)
+static int au1000_gpio2_direction_input(struct gpio_chip *chip, unsigned offset)
 {
-	gpio -= AU1XXX_GPIO_BASE;
-	gpio2->dir &= ~(0x01 << gpio);
+	u32 mask = 1 << offset;
+	u32 tmp;
+	struct au1000_gpio_chip *gpch;
+	unsigned long flags;
+
+	gpch = container_of(chip, struct au1000_gpio_chip, chip);
+
+	local_irq_save(flags);
+	tmp = readl(gpch->regbase + AU1000_GPIO2_DIR);
+	tmp &= ~mask;
+	writel(tmp, gpch->regbase + AU1000_GPIO2_DIR);
+	local_irq_restore(flags);
+
 	return 0;
 }
 
-static int au1xxx_gpio2_direction_output(unsigned gpio, int value)
+static int au1000_gpio2_direction_output(struct gpio_chip *chip,
+					unsigned offset, int value)
 {
-	gpio -= AU1XXX_GPIO_BASE;
-	gpio2->dir |= 0x01 << gpio;
-	gpio2->output = (GPIO2_OUTPUT_ENABLE_MASK << gpio) | ((!!value) << gpio);
+	u32 mask = 1 << offset;
+	u32 out_mask = ((GPIO2_OUT_EN_MASK << offset) | (!!value << offset));
+	u32 tmp;
+	struct au1000_gpio_chip *gpch;
+	unsigned long flags;
+
+	gpch = container_of(chip, struct au1000_gpio_chip, chip);
+
+	local_irq_save(flags);
+	tmp = readl(gpch->regbase + AU1000_GPIO2_DIR);
+	tmp |= mask;
+	writel(tmp, gpch->regbase + AU1000_GPIO2_DIR);
+	writel(out_mask, gpch->regbase + AU1000_GPIO2_OUT);
+	local_irq_restore(flags);
+
 	return 0;
 }
-
 #endif /* !defined(CONFIG_SOC_AU1000) */
 
-static int au1xxx_gpio1_read(unsigned gpio)
+static int au1000_gpio1_get(struct gpio_chip *chip, unsigned offset)
 {
-	return (gpio1->pinstaterd >> gpio) & 0x01;
+	u32 mask = 1 << offset;
+	struct au1000_gpio_chip *gpch;
+
+	gpch = container_of(chip, struct au1000_gpio_chip, chip);
+	return readl(gpch->regbase + AU1000_GPIO1_ST) & mask;
 }
 
-static void au1xxx_gpio1_write(unsigned gpio, int value)
+static void au1000_gpio1_set(struct gpio_chip *chip,
+				unsigned offset, int value)
 {
+	u32 mask = 1 << offset;
+	u32 reg_offset;
+	struct au1000_gpio_chip *gpch;
+	unsigned long flags;
+
+	gpch = container_of(chip, struct au1000_gpio_chip, chip);
+
 	if (value)
-		gpio1->outputset = (0x01 << gpio);
+		reg_offset = AU1000_GPIO1_OUT;
 	else
-		/* Output a zero */
-		gpio1->outputclr = (0x01 << gpio);
+		reg_offset = AU1000_GPIO1_CLR;
+
+	local_irq_save(flags);
+	writel(mask, gpch->regbase + reg_offset);
+	local_irq_restore(flags);
 }
 
-static int au1xxx_gpio1_direction_input(unsigned gpio)
+static int au1000_gpio1_direction_input(struct gpio_chip *chip, unsigned offset)
 {
-	gpio1->pininputen = (0x01 << gpio);
+	u32 mask = 1 << offset;
+	struct au1000_gpio_chip *gpch;
+
+	gpch = container_of(chip, struct au1000_gpio_chip, chip);
+	writel(mask, gpch->regbase + AU1000_GPIO1_ST);
+
 	return 0;
 }
 
-static int au1xxx_gpio1_direction_output(unsigned gpio, int value)
+static int au1000_gpio1_direction_output(struct gpio_chip *chip,
+					unsigned offset, int value)
 {
-	gpio1->trioutclr = (0x01 & gpio);
-	au1xxx_gpio1_write(gpio, value);
+	u32 mask = 1 << offset;
+	struct au1000_gpio_chip *gpch;
+
+	gpch = container_of(chip, struct au1000_gpio_chip, chip);
+
+	writel(mask, gpch->regbase + AU1000_GPIO1_TRI_OUT);
+	au1000_gpio1_set(chip, offset, value);
+
 	return 0;
 }
 
-int au1xxx_gpio_get_value(unsigned gpio)
-{
-	if (gpio >= AU1XXX_GPIO_BASE)
-#if defined(CONFIG_SOC_AU1000)
-		return 0;
-#else
-		return au1xxx_gpio2_read(gpio);
+struct au1000_gpio_chip au1000_gpio_chip[] = {
+	[0] = {
+		.regbase			= (void __iomem *)SYS_BASE,
+		.chip = {
+			.label			= "au1000-gpio1",
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
+		.regbase                        = (void __iomem *)GPIO2_BASE,
+		.chip = {
+			.label                  = "au1000-gpio2",
+			.direction_input        = au1000_gpio2_direction_input,
+			.direction_output       = au1000_gpio2_direction_output,
+			.get                    = au1000_gpio2_get,
+			.set                    = au1000_gpio2_set,
+			.base                   = AU1XXX_GPIO_BASE,
+			.ngpio                  = 32,
+		},
+	},
 #endif
-	else
-		return au1xxx_gpio1_read(gpio);
-}
-EXPORT_SYMBOL(au1xxx_gpio_get_value);
+};
 
-void au1xxx_gpio_set_value(unsigned gpio, int value)
+static int __init au1000_gpio_init(void)
 {
-	if (gpio >= AU1XXX_GPIO_BASE)
-#if defined(CONFIG_SOC_AU1000)
-		;
-#else
-		au1xxx_gpio2_write(gpio, value);
-#endif
-	else
-		au1xxx_gpio1_write(gpio, value);
-}
-EXPORT_SYMBOL(au1xxx_gpio_set_value);
+	gpiochip_add(&au1000_gpio_chip[0].chip);
+#if !defined(CONFIG_SOC_AU1000)
+	gpiochip_add(&au1000_gpio_chip[1].chip);
 
-int au1xxx_gpio_direction_input(unsigned gpio)
-{
-	if (gpio >= AU1XXX_GPIO_BASE)
-#if defined(CONFIG_SOC_AU1000)
-		return -ENODEV;
-#else
-		return au1xxx_gpio2_direction_input(gpio);
+	return 0;
 #endif
-
-	return au1xxx_gpio1_direction_input(gpio);
 }
-EXPORT_SYMBOL(au1xxx_gpio_direction_input);
+arch_initcall(au1000_gpio_init);
 
-int au1xxx_gpio_direction_output(unsigned gpio, int value)
-{
-	if (gpio >= AU1XXX_GPIO_BASE)
-#if defined(CONFIG_SOC_AU1000)
-		return -ENODEV;
-#else
-		return au1xxx_gpio2_direction_output(gpio, value);
-#endif
-
-	return au1xxx_gpio1_direction_output(gpio, value);
-}
-EXPORT_SYMBOL(au1xxx_gpio_direction_output);
diff --git a/arch/mips/include/asm/mach-au1x00/gpio.h b/arch/mips/include/asm/mach-au1x00/gpio.h
index 2dc61e0..34d9b72 100644
--- a/arch/mips/include/asm/mach-au1x00/gpio.h
+++ b/arch/mips/include/asm/mach-au1x00/gpio.h
@@ -5,65 +5,29 @@
 
 #define AU1XXX_GPIO_BASE	200
 
-struct au1x00_gpio2 {
-	u32	dir;
-	u32	reserved;
-	u32	output;
-	u32	pinstate;
-	u32	inten;
-	u32	enable;
-};
+/* GPIO bank 1 offsets */
+#define AU1000_GPIO1_TRI_OUT	0x0100
+#define AU1000_GPIO1_OUT	0x0108
+#define AU1000_GPIO1_ST		0x0110
+#define AU1000_GPIO1_CLR	0x010C
 
-extern int au1xxx_gpio_get_value(unsigned gpio);
-extern void au1xxx_gpio_set_value(unsigned gpio, int value);
-extern int au1xxx_gpio_direction_input(unsigned gpio);
-extern int au1xxx_gpio_direction_output(unsigned gpio, int value);
+/* GPIO bank 2 offsets */
+#define AU1000_GPIO2_DIR	0x00
+#define AU1000_GPIO2_RSVD	0x04
+#define AU1000_GPIO2_OUT	0x08
+#define AU1000_GPIO2_ST		0x0C
+#define AU1000_GPIO2_INT	0x10
+#define AU1000_GPIO2_EN		0x14
 
+#define GPIO2_OUT_EN_MASK	0x00010000
 
-/* Wrappers for the arch-neutral GPIO API */
+#define gpio_to_irq(gpio)	NULL
 
-static inline int gpio_request(unsigned gpio, const char *label)
-{
-	/* Not yet implemented */
-	return 0;
-}
+#define gpio_get_value __gpio_get_value
+#define gpio_set_value __gpio_set_value
 
-static inline void gpio_free(unsigned gpio)
-{
-	/* Not yet implemented */
-}
+#define gpio_cansleep __gpio_cansleep
 
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
-
-static inline void gpio_set_value(unsigned gpio, int value)
-{
-	au1xxx_gpio_set_value(gpio, value);
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
-
-/* For cansleep */
 #include <asm-generic/gpio.h>
 
 #endif /* _AU1XXX_GPIO_H_ */
