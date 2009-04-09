Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Apr 2009 18:22:12 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:44206 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20023394AbZDIRVl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 9 Apr 2009 18:21:41 +0100
Received: (qmail 2203 invoked from network); 9 Apr 2009 19:21:39 +0200
Received: from flagship.roarinelk.net (HELO localhost.localdomain) (192.168.0.197)
  by 192.168.0.1 with SMTP; 9 Apr 2009 19:21:39 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>,
	Florian Fainelli <florian@openwrt.org>
Subject: [PATCH v2 1/2] Alchemy: rewrite GPIO support.
Date:	Thu,  9 Apr 2009 19:21:38 +0200
Message-Id: <1239297699-17407-1-git-send-email-mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.2
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22315
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

The current approach is not sufficiently generic for my needs:
I want to use generic functions which deal with the GPIO1 and GPIO2
blocks, but don't want the default gpio numberspace as imposed by the
databooks;  instead I also want the option to register gpio_chips for
my board with a custom gpio namespace.

To address this, the following changes are made to the alchemy gpio
code:

- create linux-gpio-system compatible functions which deal with
  manipulating the GPIO1/2 blocks.  These functions are universally
  useful.
- gpiolib is optional

  If CONFIG_GPIOLIB is not enabled, provide the equivalent functions
  by directly inlining the GPIO1/2 functions.  Obviously this limits
  the usable GPIOs to those present on the Alchemy chip.  GPIOs can
  be accessed as documented in the datasheets (GPIO0-31 and 200-215).

  If CONFIG_GPIOLIB is selected, by default 2 gpio_chips for GPIO1/2
  are registered, and the inlines are no longer usable.  The number-
  space is as is documented in the datasheets.

  However this is not yet flexible enough for my uses.  My Alchemy
  systems have a documented "external" gpio interface (fixed number-
  space) and can support a variety of baseboards, some of which are
  equipped with I2C gpio expanders.  I want to be able to provide
  the default 16 GPIOs of the CPU board numbered as 0..15 and also
  support gpio expanders, if present, starting as gpio16.

  To achieve this, a new Kconfig symbol for Alchemy is introduced,
  CONFIG_ALCHEMY_GPIO_INDIRECT, which boards can enable to signal
  that they are not okay with the default Alchemy GPIO functions AND
  numberspace and want to provide their own.  This also works for both
  CONFIG_GPIOLIB=y and CONFIG_GPIOLIB=n.  When this config symbol is
  selected, boards must provide their own gpio_* functions; either in
  a custom gpio.h header (in board include directory) or with gpio_chips.

  To make the board-specific inlined gpio functions work, the MIPS
  Makefile must be changed so that the mach-au1x00/gpio.h header is
  included _after_ the board headers.

  see arch/mips/include/asm/mach-au1x00/gpio.h for more info.

Cc: Florian Fainelli <florian@openwrt.org>
Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
v2: added gpio_to_irq and irq_to_gpio, some renaming.

As always, tested on DB1200 and a custom Au1200 platform.

 arch/mips/Makefile                       |    5 +-
 arch/mips/alchemy/Kconfig                |   10 +-
 arch/mips/alchemy/common/gpio.c          |  177 ++++--------
 arch/mips/include/asm/mach-au1x00/gpio.h |  473 ++++++++++++++++++++++++++++--
 4 files changed, 519 insertions(+), 146 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 8d544c7..676f8d4 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -183,7 +183,6 @@ load-$(CONFIG_MACH_JAZZ)	+= 0xffffffff80080000
 # Common Alchemy Au1x00 stuff
 #
 core-$(CONFIG_SOC_AU1X00)	+= arch/mips/alchemy/common/
-cflags-$(CONFIG_SOC_AU1X00)	+= -I$(srctree)/arch/mips/include/asm/mach-au1x00
 
 #
 # AMD Alchemy Pb1000 eval board
@@ -281,6 +280,10 @@ load-$(CONFIG_MIPS_MTX1)	+= 0xffffffff80100000
 libs-$(CONFIG_MIPS_XXS1500)	+= arch/mips/alchemy/xxs1500/
 load-$(CONFIG_MIPS_XXS1500)	+= 0xffffffff80100000
 
+# must be last for Alchemy systems for GPIO to work properly
+cflags-$(CONFIG_SOC_AU1X00)	+= -I$(srctree)/arch/mips/include/asm/mach-au1x00
+
+
 #
 # Cobalt Server
 #
diff --git a/arch/mips/alchemy/Kconfig b/arch/mips/alchemy/Kconfig
index 8128aeb..2290dbd 100644
--- a/arch/mips/alchemy/Kconfig
+++ b/arch/mips/alchemy/Kconfig
@@ -1,3 +1,11 @@
+
+# select this in your board config if you don't want to use the gpio
+# namespace as documented in the manuals.  In this case however you need
+# to create the necessary gpio_* functions in your board code/headers!
+# see arch/mips/include/asm/mach-au1x00/gpio.h   for more information.
+config ALCHEMY_GPIO_INDIRECT
+	def_bool n
+
 choice
 	prompt "Machine type"
 	depends on MACH_ALCHEMY
@@ -134,4 +142,4 @@ config SOC_AU1X00
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_APM_EMULATION
-	select ARCH_REQUIRE_GPIOLIB
+	select ARCH_WANT_OPTIONAL_GPIOLIB
diff --git a/arch/mips/alchemy/common/gpio.c b/arch/mips/alchemy/common/gpio.c
index 91a9c44..6d63e94 100644
--- a/arch/mips/alchemy/common/gpio.c
+++ b/arch/mips/alchemy/common/gpio.c
@@ -1,6 +1,6 @@
 /*
  *  Copyright (C) 2007-2009, OpenWrt.org, Florian Fainelli <florian@openwrt.org>
- *  	Architecture specific GPIO support
+ *  	GPIO support for Au1000, Au1500, Au1100, Au1550 and Au12x0.
  *
  *  This program is free software; you can redistribute	 it and/or modify it
  *  under  the terms of	 the GNU General  Public License as published by the
@@ -23,10 +23,12 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  *
  *  Notes :
- * 	au1000 SoC have only one GPIO line : GPIO1
- * 	others have a second one : GPIO2
+ * 	au1000 SoC have only one GPIO block : GPIO1
+ * 	Au1100, Au15x0, Au12x0 have a second one : GPIO2
  */
 
+#if defined(CONFIG_GPIOLIB) && !defined(CONFIG_ALCHEMY_GPIO_INDIRECT)
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/types.h>
@@ -34,168 +36,99 @@
 #include <linux/gpio.h>
 
 #include <asm/mach-au1x00/au1000.h>
-#include <asm/gpio.h>
-
-struct au1000_gpio_chip {
-	struct gpio_chip	chip;
-	void __iomem		*regbase;
-};
+#include <asm/mach-au1x00/gpio.h>
 
 #if !defined(CONFIG_SOC_AU1000)
-static int au1000_gpio2_get(struct gpio_chip *chip, unsigned offset)
+static int gpio2_get(struct gpio_chip *chip, unsigned offset)
 {
-	u32 mask = 1 << offset;
-	struct au1000_gpio_chip *gpch;
-
-	gpch = container_of(chip, struct au1000_gpio_chip, chip);
-	return readl(gpch->regbase + AU1000_GPIO2_ST) & mask;
+	return alchemy_gpio2_get_value(offset + ALCHEMY_GPIO2_BASE);
 }
 
-static void au1000_gpio2_set(struct gpio_chip *chip,
-				unsigned offset, int value)
+static void gpio2_set(struct gpio_chip *chip, unsigned offset, int value)
 {
-	u32 mask = ((GPIO2_OUT_EN_MASK << offset) | (!!value << offset));
-	struct au1000_gpio_chip *gpch;
-	unsigned long flags;
-
-	gpch = container_of(chip, struct au1000_gpio_chip, chip);
-
-	local_irq_save(flags);
-	writel(mask, gpch->regbase + AU1000_GPIO2_OUT);
-	local_irq_restore(flags);
+	alchemy_gpio2_set_value(offset + ALCHEMY_GPIO2_BASE, value);
 }
 
-static int au1000_gpio2_direction_input(struct gpio_chip *chip, unsigned offset)
+static int gpio2_direction_input(struct gpio_chip *chip, unsigned offset)
 {
-	u32 mask = 1 << offset;
-	u32 tmp;
-	struct au1000_gpio_chip *gpch;
-	unsigned long flags;
-
-	gpch = container_of(chip, struct au1000_gpio_chip, chip);
-
-	local_irq_save(flags);
-	tmp = readl(gpch->regbase + AU1000_GPIO2_DIR);
-	tmp &= ~mask;
-	writel(tmp, gpch->regbase + AU1000_GPIO2_DIR);
-	local_irq_restore(flags);
-
-	return 0;
+	return alchemy_gpio2_direction_input(offset + ALCHEMY_GPIO2_BASE);
 }
 
-static int au1000_gpio2_direction_output(struct gpio_chip *chip,
-					unsigned offset, int value)
+static int gpio2_direction_output(struct gpio_chip *chip, unsigned offset,
+				  int value)
 {
-	u32 mask = 1 << offset;
-	u32 out_mask = ((GPIO2_OUT_EN_MASK << offset) | (!!value << offset));
-	u32 tmp;
-	struct au1000_gpio_chip *gpch;
-	unsigned long flags;
-
-	gpch = container_of(chip, struct au1000_gpio_chip, chip);
-
-	local_irq_save(flags);
-	tmp = readl(gpch->regbase + AU1000_GPIO2_DIR);
-	tmp |= mask;
-	writel(tmp, gpch->regbase + AU1000_GPIO2_DIR);
-	writel(out_mask, gpch->regbase + AU1000_GPIO2_OUT);
-	local_irq_restore(flags);
+	return alchemy_gpio2_direction_output(offset + ALCHEMY_GPIO2_BASE,
+						value);
+}
 
-	return 0;
+static int gpio2_to_irq(struct gpio_chip *chip, unsigned offset)
+{
+	return alchemy_gpio2_to_irq(offset + ALCHEMY_GPIO2_BASE);
 }
 #endif /* !defined(CONFIG_SOC_AU1000) */
 
-static int au1000_gpio1_get(struct gpio_chip *chip, unsigned offset)
+static int gpio1_get(struct gpio_chip *chip, unsigned offset)
 {
-	u32 mask = 1 << offset;
-	struct au1000_gpio_chip *gpch;
-
-	gpch = container_of(chip, struct au1000_gpio_chip, chip);
-	return readl(gpch->regbase + AU1000_GPIO1_ST) & mask;
+	return alchemy_gpio1_get_value(offset + ALCHEMY_GPIO1_BASE);
 }
 
-static void au1000_gpio1_set(struct gpio_chip *chip,
+static void gpio1_set(struct gpio_chip *chip,
 				unsigned offset, int value)
 {
-	u32 mask = 1 << offset;
-	u32 reg_offset;
-	struct au1000_gpio_chip *gpch;
-	unsigned long flags;
-
-	gpch = container_of(chip, struct au1000_gpio_chip, chip);
-
-	if (value)
-		reg_offset = AU1000_GPIO1_OUT;
-	else
-		reg_offset = AU1000_GPIO1_CLR;
-
-	local_irq_save(flags);
-	writel(mask, gpch->regbase + reg_offset);
-	local_irq_restore(flags);
+	alchemy_gpio1_set_value(offset + ALCHEMY_GPIO1_BASE, value);
 }
 
-static int au1000_gpio1_direction_input(struct gpio_chip *chip, unsigned offset)
+static int gpio1_direction_input(struct gpio_chip *chip, unsigned offset)
 {
-	u32 mask = 1 << offset;
-	struct au1000_gpio_chip *gpch;
-
-	gpch = container_of(chip, struct au1000_gpio_chip, chip);
-	writel(mask, gpch->regbase + AU1000_GPIO1_ST);
-
-	return 0;
+	return alchemy_gpio1_direction_input(offset + ALCHEMY_GPIO1_BASE);
 }
 
-static int au1000_gpio1_direction_output(struct gpio_chip *chip,
+static int gpio1_direction_output(struct gpio_chip *chip,
 					unsigned offset, int value)
 {
-	u32 mask = 1 << offset;
-	struct au1000_gpio_chip *gpch;
-
-	gpch = container_of(chip, struct au1000_gpio_chip, chip);
-
-	writel(mask, gpch->regbase + AU1000_GPIO1_TRI_OUT);
-	au1000_gpio1_set(chip, offset, value);
+	return alchemy_gpio1_direction_output(offset + ALCHEMY_GPIO1_BASE,
+					     value);
+}
 
-	return 0;
+static int gpio1_to_irq(struct gpio_chip *chip, unsigned offset)
+{
+	return alchemy_gpio1_to_irq(offset + ALCHEMY_GPIO1_BASE);
 }
 
-struct au1000_gpio_chip au1000_gpio_chip[] = {
+struct gpio_chip alchemy_gpio_chip[] = {
 	[0] = {
-		.regbase			= (void __iomem *)SYS_BASE,
-		.chip = {
-			.label			= "au1000-gpio1",
-			.direction_input	= au1000_gpio1_direction_input,
-			.direction_output	= au1000_gpio1_direction_output,
-			.get			= au1000_gpio1_get,
-			.set			= au1000_gpio1_set,
-			.base			= 0,
-			.ngpio			= 32,
-		},
+		.label			= "alchemy-gpio1",
+		.direction_input	= gpio1_direction_input,
+		.direction_output	= gpio1_direction_output,
+		.get			= gpio1_get,
+		.set			= gpio1_set,
+		.to_irq			= gpio1_to_irq,
+		.base			= ALCHEMY_GPIO1_BASE,
+		.ngpio			= ALCHEMY_GPIO1_NUM,
 	},
 #if !defined(CONFIG_SOC_AU1000)
 	[1] = {
-		.regbase                        = (void __iomem *)GPIO2_BASE,
-		.chip = {
-			.label                  = "au1000-gpio2",
-			.direction_input        = au1000_gpio2_direction_input,
-			.direction_output       = au1000_gpio2_direction_output,
-			.get                    = au1000_gpio2_get,
-			.set                    = au1000_gpio2_set,
-			.base                   = AU1XXX_GPIO_BASE,
-			.ngpio                  = 32,
-		},
+		.label                  = "alchemy-gpio2",
+		.direction_input        = gpio2_direction_input,
+		.direction_output       = gpio2_direction_output,
+		.get                    = gpio2_get,
+		.set                    = gpio2_set,
+		.to_irq			= gpio2_to_irq,
+		.base                   = ALCHEMY_GPIO2_BASE,
+		.ngpio                  = ALCHEMY_GPIO2_NUM,
 	},
 #endif
 };
 
-static int __init au1000_gpio_init(void)
+static int __init alchemy_gpio_init(void)
 {
-	gpiochip_add(&au1000_gpio_chip[0].chip);
+	gpiochip_add(&alchemy_gpio_chip[0]);
 #if !defined(CONFIG_SOC_AU1000)
-	gpiochip_add(&au1000_gpio_chip[1].chip);
+	gpiochip_add(&alchemy_gpio_chip[1]);
 #endif
 
 	return 0;
 }
-arch_initcall(au1000_gpio_init);
+arch_initcall(alchemy_gpio_init);
 
+#endif	/* GPIOLIB && !ALCHEMY_GPIO_INDIRECT */
diff --git a/arch/mips/include/asm/mach-au1x00/gpio.h b/arch/mips/include/asm/mach-au1x00/gpio.h
index 34d9b72..5c29577 100644
--- a/arch/mips/include/asm/mach-au1x00/gpio.h
+++ b/arch/mips/include/asm/mach-au1x00/gpio.h
@@ -1,33 +1,462 @@
-#ifndef _AU1XXX_GPIO_H_
-#define _AU1XXX_GPIO_H_
+/*
+ * GPIO functions for Au1000, Au1500, Au1100, Au1550, Au1200
+ *
+ * Copyright (c) 2009 Manuel Lauss.
+ *
+ * Licensed under the terms outlined in the file COPYING.
+ */
 
-#include <linux/types.h>
+#ifndef _ALCHEMY_GPIO_H_
+#define _ALCHEMY_GPIO_H_
 
-#define AU1XXX_GPIO_BASE	200
+#include <asm/mach-au1x00/au1000.h>
 
-/* GPIO bank 1 offsets */
-#define AU1000_GPIO1_TRI_OUT	0x0100
-#define AU1000_GPIO1_OUT	0x0108
-#define AU1000_GPIO1_ST		0x0110
-#define AU1000_GPIO1_CLR	0x010C
+/* The default GPIO namespace as documented in the Alchemy manuals.
+ * GPIO0-31 from GPIO1 block,   GPIO200-215 from GPIO2 block.
+ */
+#define ALCHEMY_GPIO1_BASE	0
+#define ALCHEMY_GPIO2_BASE	200
 
-/* GPIO bank 2 offsets */
-#define AU1000_GPIO2_DIR	0x00
-#define AU1000_GPIO2_RSVD	0x04
-#define AU1000_GPIO2_OUT	0x08
-#define AU1000_GPIO2_ST		0x0C
-#define AU1000_GPIO2_INT	0x10
-#define AU1000_GPIO2_EN		0x14
+#define ALCHEMY_GPIO1_NUM	32
+#define ALCHEMY_GPIO2_NUM	16
+#define ALCHEMY_GPIO1_MAX 	(ALCHEMY_GPIO1_BASE + ALCHEMY_GPIO1_NUM - 1)
+#define ALCHEMY_GPIO2_MAX	(ALCHEMY_GPIO2_BASE + ALCHEMY_GPIO2_NUM - 1)
 
-#define GPIO2_OUT_EN_MASK	0x00010000
+#define MAKE_IRQ(intc, off)	(AU1000_INTC##intc##_INT_BASE + (off))
 
-#define gpio_to_irq(gpio)	NULL
+static inline int au1000_gpio1_to_irq(int gpio)
+{
+	return MAKE_IRQ(1, gpio - ALCHEMY_GPIO1_BASE);
+}
 
-#define gpio_get_value __gpio_get_value
-#define gpio_set_value __gpio_set_value
+static inline int au1000_gpio2_to_irq(int gpio)
+{
+	return -ENXIO;
+}
 
-#define gpio_cansleep __gpio_cansleep
+#ifdef CONFIG_SOC_AU1000
+static inline int au1000_irq_to_gpio(int irq)
+{
+	if ((irq >= AU1000_GPIO_0) && (irq <= AU1000_GPIO_31))
+		return ALCHEMY_GPIO1_BASE + (irq - AU1000_GPIO_0) + 0;
+
+	return -ENXIO;
+}
+#endif
+
+static inline int au1500_gpio1_to_irq(int gpio)
+{
+	gpio -= ALCHEMY_GPIO1_BASE;
+
+	if (((gpio >= 0) && (gpio <= 15)) || (gpio == 20) ||
+	    ((gpio >= 23) && (gpio <= 28)))
+		return MAKE_IRQ(1, gpio);
+
+	return -ENXIO;
+}
+
+static inline int au1500_gpio2_to_irq(int gpio)
+{
+	gpio -= ALCHEMY_GPIO2_BASE;
+
+	if ((gpio >= 0) && (gpio <= 3))
+		return MAKE_IRQ(1, 16 + gpio);
+	else if ((gpio >= 4) && (gpio <= 5))
+		return MAKE_IRQ(1, 21 + gpio - 4);
+	else if ((gpio >= 6) && (gpio <= 7))
+		return MAKE_IRQ(1, 29 + gpio - 6);
+
+	return -ENXIO;
+}
+
+#ifdef CONFIG_SOC_AU1500
+static inline int au1500_irq_to_gpio(int irq)
+{
+	switch (irq) {
+	case AU1000_GPIO_0...AU1000_GPIO_15:
+	case AU1500_GPIO_20:
+	case AU1500_GPIO_23...AU1500_GPIO_28:
+		return ALCHEMY_GPIO1_BASE + (irq - AU1000_GPIO_0) + 0;
+	case AU1500_GPIO_200...AU1500_GPIO_203:
+		return ALCHEMY_GPIO2_BASE + (irq - AU1500_GPIO_200) + 0;
+	case AU1500_GPIO_204...AU1500_GPIO_205:
+		return ALCHEMY_GPIO2_BASE + (irq - AU1500_GPIO_204) + 4;
+	case AU1500_GPIO_206...AU1500_GPIO_207:
+		return ALCHEMY_GPIO2_BASE + (irq - AU1500_GPIO_206) + 6;
+	case AU1500_GPIO_208_215:
+		return ALCHEMY_GPIO2_BASE + 8;
+	}
+	return -ENXIO;
+}
+#endif
+
+static inline int au1100_gpio1_to_irq(int gpio)
+{
+	return MAKE_IRQ(1, gpio - ALCHEMY_GPIO1_BASE);
+}
+
+static inline int au1100_gpio2_to_irq(int gpio)
+{
+	gpio -= ALCHEMY_GPIO2_BASE;
+
+	if ((gpio >= 8) && (gpio <= 15))
+		return MAKE_IRQ(0, 29);
+}
+
+#ifdef CONFIG_SOC_AU1100
+static inline int au1100_irq_to_gpio(int irq)
+{
+	switch (irq) {
+	case AU1000_GPIO_0...AU1000_GPIO_31:
+		return ALCHEMY_GPIO1_BASE + (irq - AU1000_GPIO_0) + 0;
+	case AU1100_GPIO_208_215:
+		return ALCHEMY_GPIO2_BASE + 8;
+	}
+	return -ENXIO;
+}
+#endif
+
+static inline int au1550_gpio1_to_irq(int gpio)
+{
+	gpio -= ALCHEMY_GPIO1_BASE;
+
+	if (((gpio >= 0) && (gpio <= 15)) ||
+	    ((gpio >= 20) && (gpio <= 28)))
+		return MAKE_IRQ(1, gpio);
+	else if ((gpio >= 16) && (gpio <= 17))
+		return MAKE_IRQ(1, gpio + 2);
+
+	return -ENXIO;
+}
+
+static inline int au1550_gpio2_to_irq(int gpio)
+{
+	gpio -= ALCHEMY_GPIO2_BASE;
+
+	if (gpio == 0)
+		return MAKE_IRQ(1, 16);
+	else if ((gpio >= 1) && (gpio <= 5))
+		return MAKE_IRQ(1, 17);
+	else if ((gpio >= 6) && (gpio <= 7))
+		return MAKE_IRQ(1, 29 + gpio - 6);
+	else if ((gpio >= 8) && (gpio <= 15))
+		return MAKE_IRQ(1, 31);
+
+	return -ENXIO;
+}
+
+#ifdef CONFIG_SOC_AU1550
+static inline int au1550_irq_to_gpio(int irq)
+{
+	switch (irq) {
+	case AU1000_GPIO_0...AU1000_GPIO_15:
+		return ALCHEMY_GPIO1_BASE + (irq - AU1000_GPIO_0) + 0;
+	case AU1550_GPIO_200:
+	case AU1500_GPIO_201_205:
+		return ALCHEMY_GPIO2_BASE + (irq - AU1550_GPIO_200) + 0;
+	case AU1500_GPIO_16...AU1500_GPIO_28:
+		return ALCHEMY_GPIO1_BASE + (irq - AU1500_GPIO_16) + 16;
+	case AU1500_GPIO_206...AU1500_GPIO_208_218:
+		return ALCHEMY_GPIO2_BASE + (irq - AU1500_GPIO_206) + 6;
+	}
+	return -ENXIO;
+}
+#endif
+
+static inline int au1200_gpio1_to_irq(int gpio)
+{
+	return MAKE_IRQ(1, gpio - ALCHEMY_GPIO1_BASE);
+}
+
+static inline int au1200_gpio2_to_irq(int gpio)
+{
+	gpio -= ALCHEMY_GPIO2_BASE;
+
+	if ((gpio >= 0) && (gpio <= 2))
+		return MAKE_IRQ(0, 5 + gpio);
+	else if (gpio == 3)
+		return MAKE_IRQ(0, 22);
+	else if ((gpio >= 4) && (gpio <= 7))
+		return MAKE_IRQ(0, 24 - gpio - 4);
+	else if ((gpio >= 8) && (gpio <= 15))
+		return MAKE_IRQ(0, 28);
+
+	return -ENXIO;
+}
+
+#ifdef CONFIG_SOC_AU1200
+static inline int au1200_irq_to_gpio(int irq)
+{
+	switch (irq) {
+	case AU1000_GPIO_0...AU1000_GPIO_31:
+		return ALCHEMY_GPIO1_BASE + (irq - AU1000_GPIO_0) + 0;
+	case AU1200_GPIO_200...AU1200_GPIO_202:
+		return ALCHEMY_GPIO2_BASE + (irq - AU1200_GPIO_200) + 0;
+	case AU1200_GPIO_203:
+		return ALCHEMY_GPIO2_BASE + 3;
+	case AU1200_GPIO_204...AU1200_GPIO_208_215:
+		return ALCHEMY_GPIO2_BASE + (irq - AU1200_GPIO_204) + 4;
+	}
+
+	return -ENXIO;
+}
+#endif
+
+/*
+ * GPIO1 block macros for common linux gpio functions.
+ */
+static inline void alchemy_gpio1_set_value(int gpio, int v)
+{
+	unsigned long mask = 1 << (gpio - ALCHEMY_GPIO1_BASE);
+	unsigned long r = v ? SYS_OUTPUTSET : SYS_OUTPUTCLR;
+	au_writel(mask, r);
+	au_sync();
+}
+
+static inline int alchemy_gpio1_get_value(int gpio)
+{
+	unsigned long mask = 1 << (gpio - ALCHEMY_GPIO1_BASE);
+	return au_readl(SYS_PINSTATERD) & mask;
+}
+
+static inline int alchemy_gpio1_direction_input(int gpio)
+{
+	unsigned long mask = 1 << (gpio - ALCHEMY_GPIO1_BASE);
+	au_writel(mask, SYS_TRIOUTCLR);
+	au_sync();
+	return 0;
+}
+
+static inline int alchemy_gpio1_direction_output(int gpio, int v)
+{
+	/* hardware switches to "output" mode when one of the two
+	 * "set_value" registers is accessed.
+	 */
+	alchemy_gpio1_set_value(gpio, v);
+	return 0;
+}
+
+static inline int alchemy_gpio1_is_valid(int gpio)
+{
+	return ((gpio >= ALCHEMY_GPIO1_BASE) && (gpio <= ALCHEMY_GPIO1_MAX));
+}
+
+static inline int alchemy_gpio1_to_irq(int gpio)
+{
+#if defined(CONFIG_SOC_AU1000)
+	return au1000_gpio1_to_irq(gpio);
+#elif defined(CONFIG_SOC_AU1100)
+	return au1100_gpio1_to_irq(gpio);
+#elif defined(CONFIG_SOC_AU1500)
+	return au1500_gpio1_to_irq(gpio);
+#elif defined(CONFIG_SOC_AU1550)
+	return au1550_gpio1_to_irq(gpio);
+#elif defined(CONFIG_SOC_AU1200)
+	return au1200_gpio1_to_irq(gpio);
+#else
+	return -ENXIO;
+#endif
+}
+
+/*
+ * GPIO2 block macros for common linux GPIO functions. The 'gpio'
+ * parameter must be in range of ALCHEMY_GPIO2_BASE..ALCHEMY_GPIO2_MAX.
+ */
+/* unlocked versions of to_input/to_output */
+static inline void __alchemy_gpio2_to_output(int gpio)
+{
+	unsigned long mask = 1 << (gpio - ALCHEMY_GPIO2_BASE);
+	unsigned long d = au_readl(GPIO2_DIR);
+	d |= mask;
+	au_writel(d, GPIO2_DIR);
+	au_sync();
+}
+
+static inline void __alchemy_gpio2_to_input(int gpio)
+{
+	unsigned long mask = 1 << (gpio - ALCHEMY_GPIO2_BASE);
+	unsigned long d = au_readl(GPIO2_DIR);
+	d &= ~mask;
+	au_writel(d, GPIO2_DIR);
+	au_sync();
+}
+
+static inline void alchemy_gpio2_set_value(int gpio, int v)
+{
+	unsigned long mask;
+	mask = ((v) ? 0x0101 : 0x0100) << (gpio - ALCHEMY_GPIO2_BASE);
+	au_writel(mask, GPIO2_OUTPUT);
+	au_sync();
+}
+
+static inline int alchemy_gpio2_get_value(int gpio)
+{
+	return au_readl(GPIO2_PINSTATE) & (1 << (gpio - ALCHEMY_GPIO2_BASE));
+}
+
+static inline int alchemy_gpio2_direction_input(int gpio)
+{
+	unsigned long flags;
+	local_irq_save(flags);
+	__alchemy_gpio2_to_input(gpio);
+	local_irq_restore(flags);
+	return 0;
+}
+
+static inline int alchemy_gpio2_direction_output(int gpio, int v)
+{
+	unsigned long flags;
+	local_irq_save(flags);
+	__alchemy_gpio2_to_output(gpio);
+	local_irq_restore(flags);
+	alchemy_gpio2_set_value(gpio, v);
+	return 0;
+}
+
+static inline int alchemy_gpio2_is_valid(int gpio)
+{
+	return ((gpio >= ALCHEMY_GPIO2_BASE) && (gpio <= ALCHEMY_GPIO2_MAX));
+}
+
+static inline int alchemy_gpio2_to_irq(int gpio)
+{
+#if defined(CONFIG_SOC_AU1000)
+	return au1000_gpio2_to_irq(gpio);
+#elif defined(CONFIG_SOC_AU1100)
+	return au1100_gpio2_to_irq(gpio);
+#elif defined(CONFIG_SOC_AU1500)
+	return au1500_gpio2_to_irq(gpio);
+#elif defined(CONFIG_SOC_AU1550)
+	return au1550_gpio2_to_irq(gpio);
+#elif defined(CONFIG_SOC_AU1200)
+	return au1200_gpio2_to_irq(gpio);
+#else
+	return -ENXIO;
+#endif
+}
+
+static inline int alchemy_irq_to_gpio(int irq)
+{
+#if defined(CONFIG_SOC_AU1000)
+	return au1000_irq_to_gpio(irq);
+#elif defined(CONFIG_SOC_AU1100)
+	return au1100_irq_to_gpio(irq);
+#elif defined(CONFIG_SOC_AU1500)
+	return au1500_irq_to_gpio(irq);
+#elif defined(CONFIG_SOC_AU1550)
+	return au1550_irq_to_gpio(irq);
+#elif defined(CONFIG_SOC_AU1200)
+	return au1200_irq_to_gpio(irq);
+#else
+	return -ENXIO;
+#endif
+}
+
+
+/**********************************************************************/
+
+/*
+ * 4 use cases of Au1000-Au1200 GPIOS:
+ *(1) GPIOLIB=y, ALCHEMY_GPIO_INDIRECT=y:
+ *	Board must register gpiochips.
+ *(2) GPIOLIB=y, ALCHEMY_GPIO_INDIRECT=n:
+ *	2 (1 for Au1000) gpio_chips are registered.
+ *
+ *(3) GPIOLIB=n, ALCHEMY_GPIO_INDIRECT=y:
+ *	the boards' gpio.h must provide	the linux gpio wrapper functions,
+ *
+ *(4) GPIOLIB=n, ALCHEMY_GPIO_INDIRECT=n:
+ *	inlinable gpio functions are provided which enable access to the
+ *	Au1000 gpios only by using the numbers straight out of the data-
+ *	sheets.
+
+ * Cases 1 and 3 are intended for boards which want to provide their own
+ * GPIO namespace and -operations (i.e. for example you have 8 GPIOs
+ * which are in part provided by spare Au1000 GPIO pins and in part by
+ * an external FPGA but you still want them to be accssible in linux
+ * as gpio0-7. The board can of course use the alchemy_gpioX_* functions
+ * as required).
+ */
+
+#ifndef CONFIG_GPIOLIB
+
+
+#ifndef CONFIG_ALCHEMY_GPIO_INDIRECT	/* case (4) */
+
+static inline int gpio_direction_input(int gpio)
+{
+	return (gpio >= ALCHEMY_GPIO2_BASE) ?
+		alchemy_gpio2_direction_input(gpio) :
+		alchemy_gpio1_direction_input(gpio);
+}
+
+static inline int gpio_direction_output(int gpio, int v)
+{
+	return (gpio >= ALCHEMY_GPIO2_BASE) ?
+		alchemy_gpio2_direction_output(gpio, v) :
+		alchemy_gpio1_direction_output(gpio, v);
+}
+
+static inline int gpio_get_value(int gpio)
+{
+	return (gpio >= ALCHEMY_GPIO2_BASE) ?
+		alchemy_gpio2_get_value(gpio) :
+		alchemy_gpio1_direction_input(gpio);
+}
+
+static inline void gpio_set_value(int gpio, int v)
+{
+	if (gpio >= ALCHEMY_GPIO2_BASE)
+		alchemy_gpio2_set_value(gpio, v);
+	else
+		alchemy_gpio1_set_value(gpio, v);
+}
+
+static inline int gpio_is_valid(int gpio)
+{
+	return (gpio >= ALCHEMY_GPIO2_BASE) ?
+		alchemy_gpio2_is_valid(gpio) :
+		alchemy_gpio1_is_valid(gpio);
+}
+
+static inline int gpio_cansleep(int gpio)
+{
+	return 0;	/* Alchemy never gets tired */
+}
+
+static inline int gpio_to_irq(int gpio)
+{
+	return (gpio >= ALCHEMY_GPIO2_BASE) ?
+		alchemy_gpio2_to_irq(gpio) :
+		alchemy_gpio1_to_irq(gpio);
+}
+
+static inline int irq_to_gpio(int irq)
+{
+	return alchemy_irq_to_gpio(irq);
+}
+
+#endif	/* !CONFIG_ALCHEMY_GPIO_INDIRECT */
+
+
+#else	/* CONFIG GPIOLIB */
+
+
+ /* using gpiolib to provide up to 2 gpio_chips for on-chip gpios */
+#ifndef CONFIG_ALCHEMY_GPIO_INDIRECT	/* case (2) */
+
+/* get everything through gpiolib */
+#define gpio_to_irq	__gpio_to_irq
+#define gpio_get_value	__gpio_get_value
+#define gpio_set_value	__gpio_set_value
+#define gpio_cansleep	__gpio_cansleep
+#define irq_to_gpio	alchemy_irq_to_gpio
 
 #include <asm-generic/gpio.h>
 
-#endif /* _AU1XXX_GPIO_H_ */
+#endif	/* !CONFIG_ALCHEMY_GPIO_INDIRECT */
+
+
+#endif	/* !CONFIG_GPIOLIB */
+
+#endif /* _ALCHEMY_GPIO_H_ */
-- 
1.6.2
