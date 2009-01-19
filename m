Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2009 17:12:34 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.175]:63723 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S21365752AbZASRMb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 19 Jan 2009 17:12:31 +0000
Received: by ug-out-1314.google.com with SMTP id k40so221433ugc.2
        for <multiple recipients>; Mon, 19 Jan 2009 09:12:30 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=GdA38ahhiAFWduC7YfwypjlqrkqJMWmw65lCGAK62hE=;
        b=keY7ltQ7o/Kk5R/WftHxPjgrpPxoEnUUBCrSDCMa+34jFUpNG5+isrBZAV0RB9Uvlo
         ZI0HfHh6917MAGgRTuGh/vu36WuCPltD2YnJQUol0B4ZgiYoZM3M4sR1kAwzMMoJYyaa
         yZNBJIWehpJ3hRQzb/SRy9m15yzMJp+oUiBzw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=utdBX+mnwJ0wup5L/Y9gduUrusRg1WUnrFHLTPIx0Rd3DyOhvYAv//4A3+LtXm2iwN
         3mlnM7Js2Uop3CXIEBjXsaLeyHe3IzhBW10vh21dS4pydj8lbPrfNCOaDhvcSJESLVpm
         KoQdZCqPo/XZRPdxjYoqxJQVXla2/9s9zhNQ8=
Received: by 10.67.116.12 with SMTP id t12mr1692586ugm.58.1232385150641;
        Mon, 19 Jan 2009 09:12:30 -0800 (PST)
Received: from flowlan.maisel.int-evry.fr ([157.159.47.25])
        by mx.google.com with ESMTPS id k30sm10585105ugc.59.2009.01.19.09.12.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Jan 2009 09:12:29 -0800 (PST)
From:	Florian Fainelli <florian@openwrt.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: Re: [PATCH] au1000: convert to using gpiolib
Date:	Mon, 19 Jan 2009 18:12:23 +0100
User-Agent: KMail/1.9.9
Cc:	ralf@linux-mips.org, Linux-MIPS <linux-mips@linux-mips.org>
References: <200901151646.49591.florian@openwrt.org> <86ee6fd0901160210pdb7f52nf761f8706a56f8fe@mail.gmail.com> <20090116174753.GA18764@roarinelk.homelinux.net>
In-Reply-To: <20090116174753.GA18764@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200901191812.24377.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21777
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Manuel,

Le Friday 16 January 2009 18:47:53 Manuel Lauss, vous avez écrit :
> Hi Florian,
>
> On Fri, Jan 16, 2009 at 11:10:25AM +0100, Florian Fainelli wrote:
> > > Can you please make the gpiolib registration dependent on a
> > > CONFIG symbol?  I.e. make the au1000_gpio{,2}_direction() and
> > > friends calls globally visible but let the individual boards
> > > decide whether they want to use the gpio numbering imposed by
> > > this patch.
> >
> > Would something like #ifdef CONFIG_AU1000_NON_STD_GPIOS be ok with you ?
> > Or maybe we could get the base information from board-specific code ?
>
> Well, we could move the core_initcall() to all boards' setup function,
> and stick a comment on top of it explaining why it's there.
>
> Config symbol or the above, either is fine with me.

I would prefer the config symbol, there is only one file to change ;). Patch attached below:
--
From: Florian Fainelli <florian@openwrt.org>
Subject: [PATCH v2] au1000: convert to using gpiolib

This patch converts the GPIO board code to use gpiolib.
Changes from v1:
- allow users not to use the default gpio accessors
- do not lock au1000_gpio2_set

Signed-off-by: Florian Fainelli <florian@openwrt.org>
--
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
index e660ddd..9ac1e4c 100644
--- a/arch/mips/alchemy/common/gpio.c
+++ b/arch/mips/alchemy/common/gpio.c
@@ -1,5 +1,5 @@
 /*
- *  Copyright (C) 2007, OpenWrt.org, Florian Fainelli <florian@openwrt.org>
+ *  Copyright (C) 2007-2009, OpenWrt.org, Florian Fainelli <florian@openwrt.org>
  *  	Architecture specific GPIO support
  *
  *  This program is free software; you can redistribute	 it and/or modify it
@@ -27,122 +27,172 @@
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
 
-	gpio2->output = (GPIO2_OUTPUT_ENABLE_MASK << gpio) | ((!!value) << gpio);
+	gpch = container_of(chip, struct au1000_gpio_chip, chip);
+	writel(mask, gpch->regbase + AU1000_GPIO2_OUT);
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
+			.base                   = AU1XXX_GPIO2_BASE,
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
-
-int au1xxx_gpio_direction_output(unsigned gpio, int value)
-{
-	if (gpio >= AU1XXX_GPIO_BASE)
-#if defined(CONFIG_SOC_AU1000)
-		return -ENODEV;
-#else
-		return au1xxx_gpio2_direction_output(gpio, value);
+#ifndef CONFIG_AU1X00_NON_STD_GPIOS
+arch_initcall(au1000_gpio_init);
 #endif
-
-	return au1xxx_gpio1_direction_output(gpio, value);
-}
-EXPORT_SYMBOL(au1xxx_gpio_direction_output);
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

-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
