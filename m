Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jan 2009 09:40:07 +0000 (GMT)
Received: from fg-out-1718.google.com ([72.14.220.157]:46812 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S21102823AbZA0JkE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 27 Jan 2009 09:40:04 +0000
Received: by fg-out-1718.google.com with SMTP id 16so48274fgg.32
        for <multiple recipients>; Tue, 27 Jan 2009 01:40:03 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=m4KqlN+/AVFedZOSmAUHeDCcDsnsE8dw0Z1IPbl73sc=;
        b=NRTHF6ixHb3Ks7XwRV7XJNMokCt0FUukBW4ZHe7URpw+PPhWR5ASWeFsHqcHX0KOB9
         xEPjzy8ZMaPL/3KxRAGRrRW6JPgNizruFVleA4nbtMl+UPVcSVv0xZFRGighs2u6EYw6
         J9ZqBaWARfu2qXsqRkwF+GDnZOKH4WGoCYkjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=vlPZmeUbNs60iA7taMwA8TPHl414paEEuyPvbV4s/uqlEPj8J9QHM8G7haxSCXOcIq
         hDhLmaWORf+uZSgDAiVZ/9WUE4N+j+2hExpdeHfOnz8xF+dgbWohfCs/KrLF/CeXmdr7
         YYOHUeDFvXcUvR4odXF8lgQlYBYBSGZ+EXbZ4=
Received: by 10.223.112.132 with SMTP id w4mr444948fap.67.1233049203838;
        Tue, 27 Jan 2009 01:40:03 -0800 (PST)
Received: from lenovo.mimichou.home (florian.mimichou.net [82.241.112.26])
        by mx.google.com with ESMTPS id 25sm24419616mul.8.2009.01.27.01.40.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Jan 2009 01:40:02 -0800 (PST)
From:	Florian Fainelli <florian@openwrt.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: Re: [PATCH] au1000: convert to using gpiolib
Date:	Tue, 27 Jan 2009 10:39:30 +0100
User-Agent: KMail/1.9.9
Cc:	ralf@linux-mips.org, Linux-MIPS <linux-mips@linux-mips.org>
References: <200901151646.49591.florian@openwrt.org> <200901262340.27613.florian@openwrt.org> <20090127065827.GA14985@roarinelk.homelinux.net>
In-Reply-To: <20090127065827.GA14985@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200901271039.31680.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21830
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Tuesday 27 January 2009 07:58:27 Manuel Lauss, vous avez écrit :
> Florian,
>
> > Le Monday 19 January 2009 18:12:23 Florian Fainelli, vous avez ?crit?:
> > > This patch converts the GPIO board code to use gpiolib.
> > > Changes from v1:
> > > - allow users not to use the default gpio accessors
> > > - do not lock au1000_gpio2_set
> >
> > I did not receive comments from you on this patch, can I consider it
> > being ok ?
>
> Oh sorry.  Please export all the au1000_gpioX_* functions and I'm happy.
>
> Thanks!
> 	Manuel Lauss

Here we go. Thanks !
--
From: Florian Fainelli <florian@openwrt.org>
Subject: [PATCH v3] Alchemy: convert to gpiolib

This patch converts Alchemy SoC GPIO code to use
gpiolib instead of the old GENERIC_GPIO implementation.

Changes from v2:
- export all gpio accessors so that custom boards can use them

Changes from v1:
- allow users not to use the default gpio accessors
- do not lock au1000_gpio2_set

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
index e660ddd..535c565 100644
--- a/arch/mips/alchemy/common/gpio.c
+++ b/arch/mips/alchemy/common/gpio.c
@@ -1,5 +1,5 @@
 /*
- *  Copyright (C) 2007, OpenWrt.org, Florian Fainelli <florian@openwrt.org>
+ *  Copyright (C) 2007-2009, OpenWrt.org, Florian Fainelli <florian@openwrt.org>
  *  	Architecture specific GPIO support
  *
  *  This program is free software; you can redistribute	 it and/or modify it
@@ -27,122 +27,180 @@
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
+int au1000_gpio2_get(struct gpio_chip *chip, unsigned offset)
 {
-	gpio -= AU1XXX_GPIO_BASE;
-	return ((gpio2->pinstate >> gpio) & 0x01);
+	u32 mask = 1 << offset;
+	struct au1000_gpio_chip *gpch;
+
+	gpch = container_of(chip, struct au1000_gpio_chip, chip);
+	return readl(gpch->regbase + AU1000_GPIO2_ST) & mask;
 }
+EXPORT_SYMBOL(au1000_gpio2_get);
 
-static void au1xxx_gpio2_write(unsigned gpio, int value)
+void au1000_gpio2_set(struct gpio_chip *chip,
+				unsigned offset, int value)
 {
-	gpio -= AU1XXX_GPIO_BASE;
+	u32 mask = ((GPIO2_OUT_EN_MASK << offset) | (!!value << offset));
+	struct au1000_gpio_chip *gpch;
 
-	gpio2->output = (GPIO2_OUTPUT_ENABLE_MASK << gpio) | ((!!value) << gpio);
+	gpch = container_of(chip, struct au1000_gpio_chip, chip);
+	writel(mask, gpch->regbase + AU1000_GPIO2_OUT);
 }
+EXPORT_SYMBOL(au1000_gpio2_set);
 
-static int au1xxx_gpio2_direction_input(unsigned gpio)
+int au1000_gpio2_direction_input(struct gpio_chip *chip, unsigned offset)
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
+EXPORT_SYMBOL(au1000_gpio2_direction_input);
 
-static int au1xxx_gpio2_direction_output(unsigned gpio, int value)
+int au1000_gpio2_direction_output(struct gpio_chip *chip,
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
+EXPORT_SYMBOL(au1000_gpio2_direction_output);
 #endif /* !defined(CONFIG_SOC_AU1000) */
 
-static int au1xxx_gpio1_read(unsigned gpio)
+int au1000_gpio1_get(struct gpio_chip *chip, unsigned offset)
 {
-	return (gpio1->pinstaterd >> gpio) & 0x01;
+	u32 mask = 1 << offset;
+	struct au1000_gpio_chip *gpch;
+
+	gpch = container_of(chip, struct au1000_gpio_chip, chip);
+	return readl(gpch->regbase + AU1000_GPIO1_ST) & mask;
 }
+EXPORT_SYMBOL(au1000_gpio1_get);
 
-static void au1xxx_gpio1_write(unsigned gpio, int value)
+void au1000_gpio1_set(struct gpio_chip *chip,
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
-}
+		reg_offset = AU1000_GPIO1_CLR;
 
-static int au1xxx_gpio1_direction_input(unsigned gpio)
-{
-	gpio1->pininputen = (0x01 << gpio);
-	return 0;
+	local_irq_save(flags);
+	writel(mask, gpch->regbase + reg_offset);
+	local_irq_restore(flags);
 }
+EXPORT_SYMBOL(au1000_gpio1_set);
 
-static int au1xxx_gpio1_direction_output(unsigned gpio, int value)
+int au1000_gpio1_direction_input(struct gpio_chip *chip, unsigned offset)
 {
-	gpio1->trioutclr = (0x01 & gpio);
-	au1xxx_gpio1_write(gpio, value);
+	u32 mask = 1 << offset;
+	struct au1000_gpio_chip *gpch;
+
+	gpch = container_of(chip, struct au1000_gpio_chip, chip);
+	writel(mask, gpch->regbase + AU1000_GPIO1_ST);
+
 	return 0;
 }
+EXPORT_SYMBOL(au1000_gpio1_direction_input);
 
-int au1xxx_gpio_get_value(unsigned gpio)
+int au1000_gpio1_direction_output(struct gpio_chip *chip,
+					unsigned offset, int value)
 {
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
+	u32 mask = 1 << offset;
+	struct au1000_gpio_chip *gpch;
 
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
-}
-EXPORT_SYMBOL(au1xxx_gpio_set_value);
+	gpch = container_of(chip, struct au1000_gpio_chip, chip);
 
-int au1xxx_gpio_direction_input(unsigned gpio)
-{
-	if (gpio >= AU1XXX_GPIO_BASE)
-#if defined(CONFIG_SOC_AU1000)
-		return -ENODEV;
-#else
-		return au1xxx_gpio2_direction_input(gpio);
-#endif
+	writel(mask, gpch->regbase + AU1000_GPIO1_TRI_OUT);
+	au1000_gpio1_set(chip, offset, value);
 
-	return au1xxx_gpio1_direction_input(gpio);
+	return 0;
 }
-EXPORT_SYMBOL(au1xxx_gpio_direction_input);
+EXPORT_SYMBOL(au1000_gpio1_direction_output);
+
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
+			.base                   = AU1XXX_GPIO2_BASE,
+			.ngpio                  = 32,
+		},
+	},
+#endif
+};
 
-int au1xxx_gpio_direction_output(unsigned gpio, int value)
+static int __init au1000_gpio_init(void)
 {
-	if (gpio >= AU1XXX_GPIO_BASE)
-#if defined(CONFIG_SOC_AU1000)
-		return -ENODEV;
-#else
-		return au1xxx_gpio2_direction_output(gpio, value);
-#endif
+	gpiochip_add(&au1000_gpio_chip[0].chip);
+#if !defined(CONFIG_SOC_AU1000)
+	gpiochip_add(&au1000_gpio_chip[1].chip);
 
-	return au1xxx_gpio1_direction_output(gpio, value);
+	return 0;
+#endif
 }
-EXPORT_SYMBOL(au1xxx_gpio_direction_output);
+#ifndef CONFIG_AU1X00_NON_STD_GPIOS
+arch_initcall(au1000_gpio_init);
+#endif
diff --git a/arch/mips/include/asm/mach-au1x00/gpio.h b/arch/mips/include/asm/mach-au1x00/gpio.h
index 2dc61e0..f1a5d48 100644
--- a/arch/mips/include/asm/mach-au1x00/gpio.h
+++ b/arch/mips/include/asm/mach-au1x00/gpio.h
@@ -3,67 +3,31 @@
 
 #include <linux/types.h>
 
-#define AU1XXX_GPIO_BASE	200
+#define AU1XXX_GPIO2_BASE	200
 
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
