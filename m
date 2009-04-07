Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Apr 2009 18:41:51 +0100 (BST)
Received: from mail-bw0-f177.google.com ([209.85.218.177]:36314 "EHLO
	mail-bw0-f177.google.com") by ftp.linux-mips.org with ESMTP
	id S20030489AbZDGRlo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 7 Apr 2009 18:41:44 +0100
Received: by bwz25 with SMTP id 25so2665441bwz.0
        for <linux-mips@linux-mips.org>; Tue, 07 Apr 2009 10:41:37 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=K8uyohYw6OzxqDEhmDfuo6D3DU8onK0cueibZ9QghEI=;
        b=ZdhCE6GpiWUospffg4JnRzkbBMz5EspQOXaaWaBMSgKfHRtrii59Ah8TI3Py03prJM
         /Tn8Uxpc0fKaafMDXUKpIuVeayl+0P9yQPkCmwK1qd1UaITKFXS/1pVhi2uvTDIC0tze
         Vs1UiHdE25jNZN7O4D+syaXTNc7631DxzyWFw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=C8D8ZylJn0/2DL7hxyqzYZQbC23h7SNB1CuhvwMjYc2jDGkzHIqEmWfE50dyqoR8ZX
         U9QXHAo5hdWsVHBV6xwezl+KWmXPK4fI0t314YETaDm11m3uJgOkWz+Z9fE8S+c4zn9L
         2JMViQWc28YXPKRGBltTHqGpuXv5H/5mzK4CY=
Received: by 10.204.53.72 with SMTP id l8mr318706bkg.171.1239126097717;
        Tue, 07 Apr 2009 10:41:37 -0700 (PDT)
Received: from localhost.localdomain (p5496DCB6.dip.t-dialin.net [84.150.220.182])
        by mx.google.com with ESMTPS id h2sm2816582fkh.9.2009.04.07.10.41.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Apr 2009 10:41:36 -0700 (PDT)
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>,
	Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 1/2] Alchemy: rewrite GPIO support.
Date:	Tue,  7 Apr 2009 19:41:33 +0200
Message-Id: <1239126094-11385-1-git-send-email-mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.2
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22272
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

The current approach is not sufficiently generic for my needs:
I want to use the generic functions which deal with the GPIO1 and GPIO2
blocks, but don't want to use the gpio namespace established by them;
I also want to register my own gpio chip(s) if necessary for gpio
expanders.

To this end, the following changes are made:
- factor out the functions which deals with manipulating GPIO1 and GPIO2
  blocks, they are always useful.
- don't depend on gpiolib (not every board may want/need it).

  Instead, if CONFIG_GPIOLIB is not enabled, provide the equivalent
  functions by directly inlining the GPIO1/2 functions.  Obviously this
  limits the usable GPIOs to those present on the Alchemy chip.  GPIOs
  can be accessed as documented in the datasheets (GPIO0-31 and 200-215).

  If CONFIG_GPIOLIB is selected, by default 2 gpio_chips for GPIO1/2
  are registered which provide GPIO0-31 and GPIO200-215 as is docu-
  mented in the datasheets.

  However this is not yet flexible enough for my uses.  My Alchemy
  systems can support a variety of baseboards, some of which are
  equipped with I2C gpio expanders.  I want to be able to provide
  the default 16 GPIOs of the CPU board (numbered 0..15) and also
  support gpio expanders if present starting at gpio16.

  To that end, a new Kconfig symbol for Alchemy is introduced
  (CONFIG_ALCHEMY_GPIO_INDIRECT) which boards can use to signal
  whether they are okay with the default Alchemy GPIO functions AND
  namespace, or want to provide their own.  This also works for both
  CONFIG_GPIOLIB=y and CONFIG_GPIOLIB=n.  When this config symbol is
  selected, boards must provide their own gpio_* functions.

  see arch/mips/include/asm/mach-au1x00/gpio.h for more info.

Cc: Florian Fainelli <florian@openwrt.org>
Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/alchemy/Kconfig                |   10 +-
 arch/mips/alchemy/common/gpio.c          |  160 +++++--------------
 arch/mips/include/asm/mach-au1x00/gpio.h |  262 +++++++++++++++++++++++++++---
 3 files changed, 292 insertions(+), 140 deletions(-)

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
index 91a9c44..4893a05 100644
--- a/arch/mips/alchemy/common/gpio.c
+++ b/arch/mips/alchemy/common/gpio.c
@@ -27,6 +27,8 @@
  * 	others have a second one : GPIO2
  */
 
+#if defined(CONFIG_GPIOLIB) && !defined(CONFIG_ALCHEMY_GPIO_INDIRECT)
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/types.h>
@@ -34,168 +36,88 @@
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
+static int au1xxx_gpio2_get(struct gpio_chip *chip, unsigned offset)
 {
-	u32 mask = 1 << offset;
-	struct au1000_gpio_chip *gpch;
-
-	gpch = container_of(chip, struct au1000_gpio_chip, chip);
-	return readl(gpch->regbase + AU1000_GPIO2_ST) & mask;
+	return au1000_gpio2_get_value(offset + AU1XXX_GPIO2_BASE);
 }
 
-static void au1000_gpio2_set(struct gpio_chip *chip,
+static void au1xxx_gpio2_set(struct gpio_chip *chip,
 				unsigned offset, int value)
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
+	au1000_gpio2_set_value(offset + AU1XXX_GPIO2_BASE, value);
 }
 
-static int au1000_gpio2_direction_input(struct gpio_chip *chip, unsigned offset)
+static int au1xxx_gpio2_direction_input(struct gpio_chip *chip, unsigned offset)
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
+	return au1000_gpio2_direction_input(offset + AU1XXX_GPIO2_BASE);
 }
 
-static int au1000_gpio2_direction_output(struct gpio_chip *chip,
+static int au1xxx_gpio2_direction_output(struct gpio_chip *chip,
 					unsigned offset, int value)
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
-
-	return 0;
+	return au1000_gpio2_direction_output(offset + AU1XXX_GPIO2_BASE,
+						value);
 }
 #endif /* !defined(CONFIG_SOC_AU1000) */
 
-static int au1000_gpio1_get(struct gpio_chip *chip, unsigned offset)
+static int au1xxx_gpio1_get(struct gpio_chip *chip, unsigned offset)
 {
-	u32 mask = 1 << offset;
-	struct au1000_gpio_chip *gpch;
-
-	gpch = container_of(chip, struct au1000_gpio_chip, chip);
-	return readl(gpch->regbase + AU1000_GPIO1_ST) & mask;
+	return au1000_gpio1_get_value(offset + AU1XXX_GPIO1_BASE);
 }
 
-static void au1000_gpio1_set(struct gpio_chip *chip,
+static void au1xxx_gpio1_set(struct gpio_chip *chip,
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
+	au1000_gpio1_set_value(offset + AU1XXX_GPIO1_BASE, value);
 }
 
-static int au1000_gpio1_direction_input(struct gpio_chip *chip, unsigned offset)
+static int au1xxx_gpio1_direction_input(struct gpio_chip *chip, unsigned offset)
 {
-	u32 mask = 1 << offset;
-	struct au1000_gpio_chip *gpch;
-
-	gpch = container_of(chip, struct au1000_gpio_chip, chip);
-	writel(mask, gpch->regbase + AU1000_GPIO1_ST);
-
-	return 0;
+	return au1000_gpio1_direction_input(offset + AU1XXX_GPIO1_BASE);
 }
 
-static int au1000_gpio1_direction_output(struct gpio_chip *chip,
+static int au1xxx_gpio1_direction_output(struct gpio_chip *chip,
 					unsigned offset, int value)
 {
-	u32 mask = 1 << offset;
-	struct au1000_gpio_chip *gpch;
-
-	gpch = container_of(chip, struct au1000_gpio_chip, chip);
-
-	writel(mask, gpch->regbase + AU1000_GPIO1_TRI_OUT);
-	au1000_gpio1_set(chip, offset, value);
-
-	return 0;
+	return au1000_gpio1_direction_output(offset + AU1XXX_GPIO1_BASE,
+					     value);
 }
 
-struct au1000_gpio_chip au1000_gpio_chip[] = {
+struct gpio_chip au1xxx_gpio_chip[] = {
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
+		.label			= "au1000-gpio1",
+		.direction_input	= au1xxx_gpio1_direction_input,
+		.direction_output	= au1xxx_gpio1_direction_output,
+		.get			= au1xxx_gpio1_get,
+		.set			= au1xxx_gpio1_set,
+		.base			= AU1XXX_GPIO1_BASE,
+		.ngpio			= AU1XXX_GPIO1_NUM,
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
+		.label                  = "au1000-gpio2",
+		.direction_input        = au1xxx_gpio2_direction_input,
+		.direction_output       = au1xxx_gpio2_direction_output,
+		.get                    = au1xxx_gpio2_get,
+		.set                    = au1xxx_gpio2_set,
+		.base                   = AU1XXX_GPIO2_BASE,
+		.ngpio                  = AU1XXX_GPIO2_NUM,
 	},
 #endif
 };
 
-static int __init au1000_gpio_init(void)
+static int __init au1xxx_gpio_init(void)
 {
-	gpiochip_add(&au1000_gpio_chip[0].chip);
+	gpiochip_add(&au1xxx_gpio_chip[0]);
 #if !defined(CONFIG_SOC_AU1000)
-	gpiochip_add(&au1000_gpio_chip[1].chip);
+	gpiochip_add(&au1xxx_gpio_chip[1]);
 #endif
 
 	return 0;
 }
-arch_initcall(au1000_gpio_init);
+arch_initcall(au1xxx_gpio_init);
 
+#endif	/* GPIOLIB && !ALCHEMY_GPIO_INDIRECT */
diff --git a/arch/mips/include/asm/mach-au1x00/gpio.h b/arch/mips/include/asm/mach-au1x00/gpio.h
index 34d9b72..6e5a320 100644
--- a/arch/mips/include/asm/mach-au1x00/gpio.h
+++ b/arch/mips/include/asm/mach-au1x00/gpio.h
@@ -1,33 +1,255 @@
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
+#define AU1XXX_GPIO1_BASE	0
+#define AU1XXX_GPIO2_BASE	200
 
-/* GPIO bank 2 offsets */
-#define AU1000_GPIO2_DIR	0x00
-#define AU1000_GPIO2_RSVD	0x04
-#define AU1000_GPIO2_OUT	0x08
-#define AU1000_GPIO2_ST		0x0C
-#define AU1000_GPIO2_INT	0x10
-#define AU1000_GPIO2_EN		0x14
+#define AU1XXX_GPIO1_NUM	32
+#define AU1XXX_GPIO2_NUM	16
+#define AU1XXX_GPIO1_MAX 	(AU1XXX_GPIO1_BASE + AU1XXX_GPIO1_NUM - 1)
+#define AU1XXX_GPIO2_MAX	(AU1XXX_GPIO2_BASE + AU1XXX_GPIO2_NUM - 1)
 
-#define GPIO2_OUT_EN_MASK	0x00010000
+/*
+ * GPIO1 block macros for common linux gpio functions.
+ */
+static inline void au1000_gpio1_set_value(int gpio, int v)
+{
+	unsigned long mask = 1 << (gpio - AU1XXX_GPIO1_BASE);
+	unsigned long r = v ? SYS_OUTPUTSET : SYS_OUTPUTCLR;
+	au_writel(mask, r);
+	au_sync();
+}
 
-#define gpio_to_irq(gpio)	NULL
+static inline int au1000_gpio1_get_value(int gpio)
+{
+	unsigned long mask = 1 << (gpio - AU1XXX_GPIO1_BASE);
+	return au_readl(SYS_PINSTATERD) & mask;
+}
 
+static inline int au1000_gpio1_direction_input(int gpio)
+{
+	unsigned long mask = 1 << (gpio - AU1XXX_GPIO1_BASE);
+	au_writel(mask, SYS_TRIOUTCLR);
+	au_sync();
+	return 0;
+}
+
+static inline int au1000_gpio1_direction_output(int gpio, int v)
+{
+	/* hardware switches to "output" mode when one of the two
+	 * "set_value" registers is accessed.
+	 */
+	au1000_gpio1_set_value(gpio, v);
+	return 0;
+}
+
+static inline int au1000_gpio1_is_valid(int gpio)
+{
+	return ((gpio >= AU1XXX_GPIO1_BASE) && (gpio <= AU1XXX_GPIO1_MAX));
+}
+
+static inline int au1000_gpio1_cansleep(int gpio)
+{
+	return 0;	/* Alchemy never gets tired */
+}
+
+static inline int au1000_gpio1_to_irq(int gpio)
+{
+	return -ENXIO;
+}
+
+/*
+ * GPIO2 block macros for common linux GPIO functions. The 'gpio'
+ * parameter must be in range of AU1XXX_GPIO2_BASE..AU1XXX_GPIO2_MAX.
+ */
+/* unlocked versions of to_input/to_output */
+static inline void __au1000_gpio2_to_output(int gpio)
+{
+	unsigned long mask = 1 << (gpio - AU1XXX_GPIO2_BASE);
+	unsigned long d = au_readl(GPIO2_DIR);
+	d |= mask;
+	au_writel(d, GPIO2_DIR);
+	au_sync();
+}
+
+static inline void __au1000_gpio2_to_input(int gpio)
+{
+	unsigned long mask = 1 << (gpio - AU1XXX_GPIO2_BASE);
+	unsigned long d = au_readl(GPIO2_DIR);
+	d &= ~mask;
+	au_writel(d, GPIO2_DIR);
+	au_sync();
+}
+
+static inline void au1000_gpio2_set_value(int gpio, int v)
+{
+	unsigned long mask = 1 << (gpio - AU1XXX_GPIO2_BASE);
+
+	if (v)
+		mask |= mask << 16;
+	else
+		mask <<= 16;
+
+	au_writel(mask, GPIO2_OUTPUT);
+	au_sync();
+}
+
+static inline int au1000_gpio2_get_value(int gpio)
+{
+	return au_readl(GPIO2_PINSTATE) & (1 << (gpio - AU1XXX_GPIO2_BASE));
+}
+
+static inline int au1000_gpio2_direction_input(int gpio)
+{
+	unsigned long flags;
+	local_irq_save(flags);
+	__au1000_gpio2_to_input(gpio);
+	local_irq_restore(flags);
+	return 0;
+}
+
+static inline int au1000_gpio2_direction_output(int gpio, int v)
+{
+	unsigned long flags;
+	local_irq_save(flags);
+	__au1000_gpio2_to_output(gpio);
+	local_irq_restore(flags);
+	au1000_gpio2_set_value(gpio, v);
+	return 0;
+}
+
+static inline int au1000_gpio2_cansleep(int gpio)
+{
+	return 0;
+}
+
+static inline int au1000_gpio2_is_valid(int gpio)
+{
+	return ((gpio >= AU1XXX_GPIO2_BASE) && (gpio <= AU1XXX_GPIO2_MAX));
+}
+
+static inline int au1000_gpio2_to_irq(int gpio)
+{
+	return -ENXIO;
+}
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
+ * as gpio0-7. The board can of course use the au1000_gpioX_* functions
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
+	return (gpio >= AU1XXX_GPIO2_BASE) ?
+		au1000_gpio2_direction_input(gpio) :
+		au1000_gpio1_direction_input(gpio);
+}
+
+static inline int gpio_direction_output(int gpio, int v)
+{
+	return (gpio >= AU1XXX_GPIO2_BASE) ?
+		au1000_gpio2_direction_output(gpio, v) :
+		au1000_gpio1_direction_output(gpio, v);
+}
+
+static inline int gpio_get_value(int gpio)
+{
+	return (gpio >= AU1XXX_GPIO2_BASE) ?
+		au1000_gpio2_get_value(gpio) :
+		au1000_gpio1_direction_input(gpio);
+}
+
+static inline void gpio_set_value(int gpio, int v)
+{
+	if (gpio >= AU1XXX_GPIO2_BASE)
+		au1000_gpio2_set_value(gpio, v);
+	else
+		au1000_gpio1_set_value(gpio, v);
+}
+
+static inline int gpio_is_valid(int gpio)
+{
+	return (gpio >= AU1XXX_GPIO2_BASE) ?
+		au1000_gpio2_is_valid(gpio) :
+		au1000_gpio1_is_valid(gpio);
+}
+
+static inline int gpio_cansleep(int gpio)
+{
+	return (gpio >= AU1XXX_GPIO2_BASE) ?
+		au1000_gpio2_cansleep(gpio) :
+		au1000_gpio1_cansleep(gpio);
+}
+
+static inline int gpio_to_irq(int gpio)
+{
+	return (gpio >= AU1XXX_GPIO2_BASE) ?
+		au1000_gpio2_to_irq(gpio) :
+		au1000_gpio1_to_irq(gpio);
+}
+
+static inline int irq_to_gpio(int irq)
+{
+	return -ENXIO;
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
+#define gpio_to_irq __gpio_to_irq
 #define gpio_get_value __gpio_get_value
 #define gpio_set_value __gpio_set_value
-
 #define gpio_cansleep __gpio_cansleep
 
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
