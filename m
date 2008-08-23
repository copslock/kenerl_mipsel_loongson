Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Aug 2008 17:55:47 +0100 (BST)
Received: from smtp4.int-evry.fr ([157.159.10.71]:14284 "EHLO
	smtp4.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S20027281AbYHWQzJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 23 Aug 2008 17:55:09 +0100
Received: from smtp2.int-evry.fr (smtp2.int-evry.fr [157.159.10.45])
	by smtp4.int-evry.fr (Postfix) with ESMTP id 0EC6FFE2E86;
	Sat, 23 Aug 2008 18:55:09 +0200 (CEST)
Received: from smtp-ext.int-evry.fr (smtp-ext.int-evry.fr [157.159.11.17])
	by smtp2.int-evry.fr (Postfix) with ESMTP id 6FBA63F0B2C;
	Sat, 23 Aug 2008 18:54:38 +0200 (CEST)
Received: from florian.maisel.int-evry.fr (unknown [157.159.47.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id 575A090004;
	Sat, 23 Aug 2008 18:54:38 +0200 (CEST)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Sat, 23 Aug 2008 18:54:34 +0200
Subject: [PATCH 4/5] rb532: convert to GPIO lib
MIME-Version: 1.0
X-UID:	1151
X-Length: 12844
To:	"linux-mips" <linux-mips@linux-mips.org>
Cc:	ralf@linux-mips.org
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200808231854.35014.florian@openwrt.org>
X-INT-MailScanner-Information: Please contact the ISP for more information
X-MailScanner-ID: 6FBA63F0B2C.7CA39
X-INT-MailScanner: Found to be clean
X-INT-MailScanner-SpamCheck: 
X-INT-MailScanner-From:	florian@openwrt.org
Return-Path: <florian@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20339
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch converts the rb532 code to use gpio library
and register its gpio chip.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 4da736e..ac4ce81 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -567,7 +567,7 @@ config MIKROTIK_RB532
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SWAP_IO_SPACE
 	select BOOT_RAW
-	select GENERIC_GPIO
+	select ARCH_REQUIRE_GPIOLIB
 	help
 	  Support the Mikrotik(tm) RouterBoard 532 series,
 	  based on the IDT RC32434 SoC.
diff --git a/arch/mips/rb532/gpio.c b/arch/mips/rb532/gpio.c
index 6782127..f65deaa 100644
--- a/arch/mips/rb532/gpio.c
+++ b/arch/mips/rb532/gpio.c
@@ -27,20 +27,23 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/types.h>
-#include <linux/pci.h>
 #include <linux/spinlock.h>
-#include <linux/io.h>
 #include <linux/platform_device.h>
-
-#include <asm/addrspace.h>
+#include <linux/gpio.h>
 
 #include <asm/mach-rc32434/rb.h>
-
-struct rb532_gpio_reg __iomem *rb532_gpio_reg0;
-EXPORT_SYMBOL(rb532_gpio_reg0);
+#include <asm/mach-rc32434/gpio.h>
+
+struct rb532_gpio_chip {
+	struct gpio_chip chip;
+	void __iomem	 *regbase;
+	void		(*set_int_level)(struct gpio_chip *chip, unsigned offset, int value);
+	int		(*get_int_level)(struct gpio_chip *chip, unsigned offset);
+	void		(*set_int_status)(struct gpio_chip *chip, unsigned offset, int value);
+	int		(*get_int_status)(struct gpio_chip *chip, unsigned offset);
+};
 
 struct mpmc_device dev3;
 
@@ -48,7 +51,7 @@ static struct resource rb532_gpio_reg0_res[] = {
 	{
 		.name 	= "gpio_reg0",
 		.start 	= REGBASE + GPIOBASE,
-		.end 	= REGBASE + GPIOBASE + sizeof(struct rb532_gpio_reg) -1,
+		.end 	= REGBASE + GPIOBASE + sizeof(struct rb532_gpio_reg) - 1,
 		.flags 	= IORESOURCE_MEM,
 	}
 };
@@ -57,7 +60,7 @@ static struct resource rb532_dev3_ctl_res[] = {
 	{
 		.name	= "dev3_ctl",
 		.start	= REGBASE + DEV3BASE,
-		.end	= REGBASE + DEV3BASE + sizeof(struct dev_reg) -1,
+		.end	= REGBASE + DEV3BASE + sizeof(struct dev_reg) - 1,
 		.flags	= IORESOURCE_MEM,
 	}
 };
@@ -108,108 +111,199 @@ unsigned char get_latch_u5(void)
 }
 EXPORT_SYMBOL(get_latch_u5);
 
-int rb532_gpio_get_value(unsigned gpio)
+/*
+ * Return GPIO level */
+static int rb532_gpio_get(struct gpio_chip *chip, unsigned offset)
 {
-	return readl(&rb532_gpio_reg0->gpiod) & (1 << gpio);
+	u32			mask = 1 << offset;
+	struct rb532_gpio_chip	*gpch;
+
+	gpch = container_of(chip, struct rb532_gpio_chip, chip);
+	return readl(gpch->regbase + GPIOD) & mask;
 }
-EXPORT_SYMBOL(rb532_gpio_get_value);
 
-void rb532_gpio_set_value(unsigned gpio, int value)
+/*
+ * Set output GPIO level
+ */
+static void rb532_gpio_set(struct gpio_chip *chip,
+				unsigned offset, int value)
 {
-	unsigned tmp;
-
-	tmp = readl(&rb532_gpio_reg0->gpiod) & ~(1 << gpio);
+	unsigned long		flags;
+	u32			mask = 1 << offset;
+	u32			tmp;
+	struct rb532_gpio_chip	*gpch;
+	void __iomem		*gpvr;
+
+	gpch = container_of(chip, struct rb532_gpio_chip, chip);
+	gpvr = gpch->regbase + GPIOD;
+	
+	local_irq_save(flags);
+	tmp = readl(gpvr);
 	if (value)
-		tmp |= 1 << gpio;
-
-	writel(tmp, (void *)&rb532_gpio_reg0->gpiod);
+		tmp |= mask;
+	else
+		tmp &= ~mask;
+	writel(tmp, gpvr);
+	local_irq_restore(flags);
 }
-EXPORT_SYMBOL(rb532_gpio_set_value);
 
-int rb532_gpio_direction_input(unsigned gpio)
+/*
+ * Set GPIO direction to input
+ */
+static int rb532_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 {
-	writel(readl(&rb532_gpio_reg0->gpiocfg) & ~(1 << gpio),
-	       (void *)&rb532_gpio_reg0->gpiocfg);
+	unsigned long		flags;
+	u32			mask = 1 << offset;
+	u32			value;
+	struct rb532_gpio_chip	*gpch;
+	void __iomem		*gpdr;
+
+	gpch = container_of(chip, struct rb532_gpio_chip, chip);
+	gpdr = gpch->regbase + GPIOCFG;
+	
+	local_irq_save(flags);
+	value = readl(gpdr);
+	value &= ~mask;
+	writel(value, gpdr);
+	local_irq_restore(flags);
 
 	return 0;
 }
-EXPORT_SYMBOL(rb532_gpio_direction_input);
 
-int rb532_gpio_direction_output(unsigned gpio, int value)
+/*
+ * Set GPIO direction to output
+ */
+static int rb532_gpio_direction_output(struct gpio_chip *chip,
+					unsigned offset, int value)
 {
-	gpio_set_value(gpio, value);
-	writel(readl(&rb532_gpio_reg0->gpiocfg) | (1 << gpio),
-	       (void *)&rb532_gpio_reg0->gpiocfg);
+	unsigned long		flags;
+	u32			mask = 1 << offset;
+	u32			tmp;
+	struct rb532_gpio_chip	*gpch;
+	void __iomem		*gpdr;
+
+	gpch = container_of(chip, struct rb532_gpio_chip, chip);
+	writel(mask, gpch->regbase + GPIOD);
+	gpdr = gpch->regbase + GPIOCFG;
+	
+	local_irq_save(flags);
+	tmp = readl(gpdr);
+	tmp |= mask;
+	writel(tmp, gpdr);
+	local_irq_restore(flags);
 
 	return 0;
 }
-EXPORT_SYMBOL(rb532_gpio_direction_output);
 
-void rb532_gpio_set_int_level(unsigned gpio, int value)
+/*
+ * Set the GPIO interrupt level
+ */
+static void rb532_gpio_set_int_level(struct gpio_chip *chip,
+					unsigned offset, int value)
 {
-	unsigned tmp;
-
-	tmp = readl(&rb532_gpio_reg0->gpioilevel) & ~(1 << gpio);
+	unsigned long		flags;
+	u32			mask = 1 << offset;
+	u32			tmp;
+	struct rb532_gpio_chip	*gpch;
+	void __iomem		*gpil;
+
+	gpch = container_of(chip, struct rb532_gpio_chip, chip);
+	gpil = gpch->regbase + GPIOILEVEL;
+	
+	local_irq_save(flags);
+	tmp = readl(gpil);
 	if (value)
-		tmp |= 1 << gpio;
-	writel(tmp, (void *)&rb532_gpio_reg0->gpioilevel);
+		tmp |= mask;
+	else
+		tmp &= ~mask;
+	writel(tmp, gpil);
+	local_irq_restore(flags);
 }
-EXPORT_SYMBOL(rb532_gpio_set_int_level);
 
-int rb532_gpio_get_int_level(unsigned gpio)
-{
-	return readl(&rb532_gpio_reg0->gpioilevel) & (1 << gpio);
-}
-EXPORT_SYMBOL(rb532_gpio_get_int_level);
-
-void rb532_gpio_set_int_status(unsigned gpio, int value)
+/*
+ * Get the GPIO interrupt level
+ */
+static int rb532_gpio_get_int_level(struct gpio_chip *chip, unsigned offset)
 {
-	unsigned tmp;
+	u32			mask = 1 << offset;
+	struct rb532_gpio_chip	*gpch;
 
-	tmp = readl(&rb532_gpio_reg0->gpioistat);
-	if (value)
-		tmp |= 1 << gpio;
-	writel(tmp, (void *)&rb532_gpio_reg0->gpioistat);
+	gpch = container_of(chip, struct rb532_gpio_chip, chip);
+	return readl(gpch->regbase + GPIOILEVEL) & mask;
 }
-EXPORT_SYMBOL(rb532_gpio_set_int_status);
 
-int rb532_gpio_get_int_status(unsigned gpio)
+/*
+ * Set the GPIO interrupt status
+ */
+static void rb532_gpio_set_int_status(struct gpio_chip *chip,
+				unsigned offset, int value)
 {
-	return readl(&rb532_gpio_reg0->gpioistat) & (1 << gpio);
+	unsigned long		flags;
+	u32			mask = 1 << offset;
+	u32			tmp;
+	struct rb532_gpio_chip	*gpch;
+	void __iomem		*gpis;
+
+	gpch = container_of(chip, struct rb532_gpio_chip, chip);
+	gpis = gpch->regbase + GPIOISTAT;
+	
+	local_irq_save(flags);
+	tmp = readl(gpis);
+	if (value)
+		tmp |= mask;
+	else
+		tmp &= ~mask;
+	writel(tmp, gpis);
+	local_irq_restore(flags);
 }
-EXPORT_SYMBOL(rb532_gpio_get_int_status);
 
-void rb532_gpio_set_func(unsigned gpio, int value)
+/*
+ * Get the GPIO interrupt status
+ */
+static int rb532_gpio_get_int_status(struct gpio_chip *chip, unsigned offset)
 {
-	unsigned tmp;
+	u32			mask = 1 << offset;
+	struct rb532_gpio_chip	*gpch;
 
-	tmp = readl(&rb532_gpio_reg0->gpiofunc);
-	if (value)
-		tmp |= 1 << gpio;
-	writel(tmp, (void *)&rb532_gpio_reg0->gpiofunc);
+	gpch = container_of(chip, struct rb532_gpio_chip, chip);
+	return readl(gpch->regbase + GPIOISTAT) & mask;
 }
-EXPORT_SYMBOL(rb532_gpio_set_func);
 
-int rb532_gpio_get_func(unsigned gpio)
-{
-	return readl(&rb532_gpio_reg0->gpiofunc) & (1 << gpio);
-}
-EXPORT_SYMBOL(rb532_gpio_get_func);
+static struct rb532_gpio_chip rb532_gpio_chip[] = {
+	[0] = {
+		.chip = {
+			.label			= "gpio0",
+			.direction_input	= rb532_gpio_direction_input,
+			.direction_output	= rb532_gpio_direction_output,
+			.get			= rb532_gpio_get,
+			.set			= rb532_gpio_set,
+			.base			= 0,
+			.ngpio			= 32,
+		},
+		.get_int_level		= rb532_gpio_get_int_level,
+		.set_int_level		= rb532_gpio_set_int_level,
+		.get_int_status		= rb532_gpio_get_int_status,
+		.set_int_status		= rb532_gpio_set_int_status,
+	},
+};
 
 int __init rb532_gpio_init(void)
 {
-	rb532_gpio_reg0 = ioremap_nocache(rb532_gpio_reg0_res[0].start,
-				rb532_gpio_reg0_res[0].end -
-				rb532_gpio_reg0_res[0].start);
+	struct resource *r;
 
-	if (!rb532_gpio_reg0) {
+	r = rb532_gpio_reg0_res;
+	rb532_gpio_chip->regbase = ioremap_nocache(r->start, r->end - r->start);
+
+	if (!rb532_gpio_chip->regbase) {
 		printk(KERN_ERR "rb532: cannot remap GPIO register 0\n");
 		return -ENXIO;
 	}
 
-	dev3.base = ioremap_nocache(rb532_dev3_ctl_res[0].start,
-				rb532_dev3_ctl_res[0].end -
-				rb532_dev3_ctl_res[0].start);
+	/* Register our GPIO chip */
+	gpiochip_add(&rb532_gpio_chip->chip);
+
+	r = rb532_dev3_ctl_res;
+	dev3.base = ioremap_nocache(r->start, r->end - r->start);
 
 	if (!dev3.base) {
 		printk(KERN_ERR "rb532: cannot remap device controller 3\n");
diff --git a/include/asm-mips/mach-rc32434/gpio.h b/include/asm-mips/mach-rc32434/gpio.h
index 4fe18db..77ac353 100644
--- a/include/asm-mips/mach-rc32434/gpio.h
+++ b/include/asm-mips/mach-rc32434/gpio.h
@@ -15,6 +15,16 @@
 
 #include <linux/types.h>
 
+#define gpio_get_value __gpio_get_value
+#define gpio_set_value __gpio_set_value
+
+#define gpio_cansleep __gpio_cansleep
+
+#define gpio_to_irq(gpio)	IRQ_GPIO(gpio)
+#define irq_to_gpio(irq)	IRQ_TO_GPIO(irq)
+
+#include <asm-generic/gpio.h>
+
 struct rb532_gpio_reg {
 	u32   gpiofunc;   /* GPIO Function Register
 			   * gpiofunc[x]==0 bit = gpio
@@ -62,74 +72,17 @@ struct rb532_gpio_reg {
 #define RC32434_PCI_MSU_GPIO	(1 << 13)
 
 /* NAND GPIO signals */
-#define GPIO_RDY		(1 << 0x08)
-#define GPIO_WPX		(1 << 0x09)
-#define GPIO_ALE		(1 << 0x0a)
-#define GPIO_CLE		(1 << 0x0b)
+#define GPIO_RDY		8
+#define GPIO_WPX	9
+#define GPIO_ALE		10
+#define GPIO_CLE		11
 
 /* Compact Flash GPIO pin */
 #define CF_GPIO_NUM		13
 
-
 extern void set_434_reg(unsigned reg_offs, unsigned bit, unsigned len, unsigned val);
 extern unsigned get_434_reg(unsigned reg_offs);
 extern void set_latch_u5(unsigned char or_mask, unsigned char nand_mask);
 extern unsigned char get_latch_u5(void);
 
-extern int rb532_gpio_get_value(unsigned gpio);
-extern void rb532_gpio_set_value(unsigned gpio, int value);
-extern int rb532_gpio_direction_input(unsigned gpio);
-extern int rb532_gpio_direction_output(unsigned gpio, int value);
-extern void rb532_gpio_set_int_level(unsigned gpio, int value);
-extern int rb532_gpio_get_int_level(unsigned gpio);
-extern void rb532_gpio_set_int_status(unsigned gpio, int value);
-extern int rb532_gpio_get_int_status(unsigned gpio);
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
-	return rb532_gpio_direction_input(gpio);
-}
-
-static inline int gpio_direction_output(unsigned gpio, int value)
-{
-	return rb532_gpio_direction_output(gpio, value);
-}
-
-static inline int gpio_get_value(unsigned gpio)
-{
-	return rb532_gpio_get_value(gpio);
-}
-
-static inline void gpio_set_value(unsigned gpio, int value)
-{
-	rb532_gpio_set_value(gpio, value);
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
-#include <asm-generic/gpio.h>
-
 #endif /* _RC32434_GPIO_H_ */
