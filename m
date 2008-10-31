Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Nov 2008 08:25:15 +0000 (GMT)
Received: from orbit.nwl.cc ([81.169.176.177]:32465 "EHLO
	mail.ifyouseekate.net") by ftp.linux-mips.org with ESMTP
	id S22834062AbYJaO6T (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 31 Oct 2008 14:58:19 +0000
Received: from base (localhost [127.0.0.1])
	by mail.ifyouseekate.net (Postfix) with ESMTP id 9182B38CE6F7;
	Fri, 31 Oct 2008 15:58:11 +0100 (CET)
From:	Phil Sutter <n0-1@freewrt.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] provide functions for gpio configuration
Date:	Fri, 31 Oct 2008 15:58:08 +0100
Message-Id: <1225465088-29365-1-git-send-email-n0-1@freewrt.org>
X-Mailer: git-send-email 1.5.6.4
In-Reply-To: <1225412757-17894-1-git-send-email-n0-1@freewrt.org>
References: <1225412757-17894-1-git-send-email-n0-1@freewrt.org>
Return-Path: <phil@nwl.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21141
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: n0-1@freewrt.org
Precedence: bulk
X-list: linux-mips

As gpiolib doesn't support pin multiplexing, it provides no way to
access the GPIOFUNC register. Also there is no support for setting
interrupt status and level. These functions provide access to them and
are needed by the CompactFlash driver.

This is a combined version of the first two patches send in this thread
on the linux-mips mailinglist. It's also addressing the conflict
generated due to the change in arch/mips/include/asm/mach-rc32434/rb.h.
Though this patch depends on it, it has been moved to another
(yet uncommitted) patch changing the same part of rb.h.

Signed-off-by: Phil Sutter <n0-1@freewrt.org>
---
 arch/mips/include/asm/mach-rc32434/gpio.h |    2 +
 arch/mips/rb532/gpio.c                    |  191 +++++++++++------------------
 2 files changed, 76 insertions(+), 117 deletions(-)

diff --git a/arch/mips/include/asm/mach-rc32434/gpio.h b/arch/mips/include/asm/mach-rc32434/gpio.h
index c8e554e..b5cf645 100644
--- a/arch/mips/include/asm/mach-rc32434/gpio.h
+++ b/arch/mips/include/asm/mach-rc32434/gpio.h
@@ -84,5 +84,7 @@ extern void set_434_reg(unsigned reg_offs, unsigned bit, unsigned len, unsigned
 extern unsigned get_434_reg(unsigned reg_offs);
 extern void set_latch_u5(unsigned char or_mask, unsigned char nand_mask);
 extern unsigned char get_latch_u5(void);
+extern void rb532_gpio_set_ilevel(int bit, unsigned gpio);
+extern void rb532_gpio_set_istat(int bit, unsigned gpio);
 
 #endif /* _RC32434_GPIO_H_ */
diff --git a/arch/mips/rb532/gpio.c b/arch/mips/rb532/gpio.c
index 76a7fd9..de29aba 100644
--- a/arch/mips/rb532/gpio.c
+++ b/arch/mips/rb532/gpio.c
@@ -39,10 +39,6 @@
 struct rb532_gpio_chip {
 	struct gpio_chip chip;
 	void __iomem	 *regbase;
-	void		(*set_int_level)(struct gpio_chip *chip, unsigned offset, int value);
-	int		(*get_int_level)(struct gpio_chip *chip, unsigned offset);
-	void		(*set_int_status)(struct gpio_chip *chip, unsigned offset, int value);
-	int		(*get_int_status)(struct gpio_chip *chip, unsigned offset);
 };
 
 struct mpmc_device dev3;
@@ -111,15 +107,47 @@ unsigned char get_latch_u5(void)
 }
 EXPORT_SYMBOL(get_latch_u5);
 
+/* rb532_set_bit - sanely set a bit
+ * 
+ * bitval: new value for the bit
+ * offset: bit index in the 4 byte address range
+ * ioaddr: 4 byte aligned address being altered
+ */
+static inline void rb532_set_bit(unsigned bitval,
+		unsigned offset, void __iomem *ioaddr)
+{
+	unsigned long flags;
+	u32 val;
+
+	bitval = !!bitval;              /* map parameter to {0,1} */
+
+	local_irq_save(flags);
+
+	val = readl(ioaddr);
+	val &= ~( ~bitval << offset );   /* unset bit if bitval == 0 */
+	val |=  (  bitval << offset );   /* set bit if bitval == 1 */
+	writel(val, ioaddr);
+
+	local_irq_restore(flags);
+}
+
+/* rb532_get_bit - read a bit
+ *
+ * returns the boolean state of the bit, which may be > 1
+ */
+static inline int rb532_get_bit(unsigned offset, void __iomem *ioaddr)
+{
+	return (readl(ioaddr) & (1 << offset));
+}
+
 /*
  * Return GPIO level */
 static int rb532_gpio_get(struct gpio_chip *chip, unsigned offset)
 {
-	u32			mask = 1 << offset;
 	struct rb532_gpio_chip	*gpch;
 
 	gpch = container_of(chip, struct rb532_gpio_chip, chip);
-	return readl(gpch->regbase + GPIOD) & mask;
+	return rb532_get_bit(offset, gpch->regbase + GPIOD);
 }
 
 /*
@@ -128,23 +156,10 @@ static int rb532_gpio_get(struct gpio_chip *chip, unsigned offset)
 static void rb532_gpio_set(struct gpio_chip *chip,
 				unsigned offset, int value)
 {
-	unsigned long		flags;
-	u32			mask = 1 << offset;
-	u32			tmp;
 	struct rb532_gpio_chip	*gpch;
-	void __iomem		*gpvr;
 
 	gpch = container_of(chip, struct rb532_gpio_chip, chip);
-	gpvr = gpch->regbase + GPIOD;
-
-	local_irq_save(flags);
-	tmp = readl(gpvr);
-	if (value)
-		tmp |= mask;
-	else
-		tmp &= ~mask;
-	writel(tmp, gpvr);
-	local_irq_restore(flags);
+	rb532_set_bit(value, offset, gpch->regbase + GPIOD);
 }
 
 /*
@@ -152,21 +167,14 @@ static void rb532_gpio_set(struct gpio_chip *chip,
  */
 static int rb532_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 {
-	unsigned long		flags;
-	u32			mask = 1 << offset;
-	u32			value;
 	struct rb532_gpio_chip	*gpch;
-	void __iomem		*gpdr;
 
 	gpch = container_of(chip, struct rb532_gpio_chip, chip);
-	gpdr = gpch->regbase + GPIOCFG;
 
-	local_irq_save(flags);
-	value = readl(gpdr);
-	value &= ~mask;
-	writel(value, gpdr);
-	local_irq_restore(flags);
+	if (rb532_get_bit(offset, gpch->regbase + GPIOFUNC))
+		return 1;	/* alternate function, GPIOCFG is ignored */
 
+	rb532_set_bit(0, offset, gpch->regbase + GPIOCFG);
 	return 0;
 }
 
@@ -176,117 +184,60 @@ static int rb532_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 static int rb532_gpio_direction_output(struct gpio_chip *chip,
 					unsigned offset, int value)
 {
-	unsigned long		flags;
-	u32			mask = 1 << offset;
-	u32			tmp;
 	struct rb532_gpio_chip	*gpch;
-	void __iomem		*gpdr;
 
 	gpch = container_of(chip, struct rb532_gpio_chip, chip);
-	writel(mask, gpch->regbase + GPIOD);
-	gpdr = gpch->regbase + GPIOCFG;
 
-	local_irq_save(flags);
-	tmp = readl(gpdr);
-	tmp |= mask;
-	writel(tmp, gpdr);
-	local_irq_restore(flags);
+	if (rb532_get_bit(offset, gpch->regbase + GPIOFUNC))
+		return 1;	/* alternate function, GPIOCFG is ignored */
+
+	/* set the initial output value */
+	rb532_set_bit(value, offset, gpch->regbase + GPIOD);
 
+	rb532_set_bit(1, offset, gpch->regbase + GPIOCFG);
 	return 0;
 }
 
-/*
- * Set the GPIO interrupt level
- */
-static void rb532_gpio_set_int_level(struct gpio_chip *chip,
-					unsigned offset, int value)
-{
-	unsigned long		flags;
-	u32			mask = 1 << offset;
-	u32			tmp;
-	struct rb532_gpio_chip	*gpch;
-	void __iomem		*gpil;
-
-	gpch = container_of(chip, struct rb532_gpio_chip, chip);
-	gpil = gpch->regbase + GPIOILEVEL;
-
-	local_irq_save(flags);
-	tmp = readl(gpil);
-	if (value)
-		tmp |= mask;
-	else
-		tmp &= ~mask;
-	writel(tmp, gpil);
-	local_irq_restore(flags);
-}
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
+	},
+};
 
 /*
- * Get the GPIO interrupt level
+ * Set GPIO interrupt level
  */
-static int rb532_gpio_get_int_level(struct gpio_chip *chip, unsigned offset)
+void rb532_gpio_set_ilevel(int bit, unsigned gpio)
 {
-	u32			mask = 1 << offset;
-	struct rb532_gpio_chip	*gpch;
-
-	gpch = container_of(chip, struct rb532_gpio_chip, chip);
-	return readl(gpch->regbase + GPIOILEVEL) & mask;
+	rb532_set_bit(bit, gpio, rb532_gpio_chip->regbase + GPIOILEVEL);
 }
+EXPORT_SYMBOL(rb532_gpio_set_ilevel);
 
 /*
- * Set the GPIO interrupt status
+ * Set GPIO interrupt status 
  */
-static void rb532_gpio_set_int_status(struct gpio_chip *chip,
-				unsigned offset, int value)
+void rb532_gpio_set_istat(int bit, unsigned gpio)
 {
-	unsigned long		flags;
-	u32			mask = 1 << offset;
-	u32			tmp;
-	struct rb532_gpio_chip	*gpch;
-	void __iomem		*gpis;
-
-	gpch = container_of(chip, struct rb532_gpio_chip, chip);
-	gpis = gpch->regbase + GPIOISTAT;
-
-	local_irq_save(flags);
-	tmp = readl(gpis);
-	if (value)
-		tmp |= mask;
-	else
-		tmp &= ~mask;
-	writel(tmp, gpis);
-	local_irq_restore(flags);
+	rb532_set_bit(bit, gpio, rb532_gpio_chip->regbase + GPIOISTAT);
 }
+EXPORT_SYMBOL(rb532_gpio_set_istat);
 
 /*
- * Get the GPIO interrupt status
+ * Configure GPIO alternate function
  */
-static int rb532_gpio_get_int_status(struct gpio_chip *chip, unsigned offset)
+static void rb532_gpio_set_func(int bit, unsigned gpio)
 {
-	u32			mask = 1 << offset;
-	struct rb532_gpio_chip	*gpch;
-
-	gpch = container_of(chip, struct rb532_gpio_chip, chip);
-	return readl(gpch->regbase + GPIOISTAT) & mask;
+       rb532_set_bit(bit, gpio, rb532_gpio_chip->regbase + GPIOFUNC);
 }
 
-static struct rb532_gpio_chip rb532_gpio_chip[] = {
-	[0] = {
-		.chip = {
-			.label			= "gpio0",
-			.direction_input	= rb532_gpio_direction_input,
-			.direction_output	= rb532_gpio_direction_output,
-			.get			= rb532_gpio_get,
-			.set			= rb532_gpio_set,
-			.base			= 0,
-			.ngpio			= 32,
-		},
-		.get_int_level		= rb532_gpio_get_int_level,
-		.set_int_level		= rb532_gpio_set_int_level,
-		.get_int_status		= rb532_gpio_get_int_status,
-		.set_int_status		= rb532_gpio_set_int_status,
-	},
-};
-
 int __init rb532_gpio_init(void)
 {
 	struct resource *r;
@@ -310,6 +261,12 @@ int __init rb532_gpio_init(void)
 		return -ENXIO;
 	}
 
+	/* configure CF_GPIO_NUM as CFRDY IRQ source */
+	rb532_gpio_set_func(0, CF_GPIO_NUM);
+	rb532_gpio_direction_input(&rb532_gpio_chip->chip, CF_GPIO_NUM);
+	rb532_gpio_set_ilevel(1, CF_GPIO_NUM);
+	rb532_gpio_set_istat(0, CF_GPIO_NUM);
+
 	return 0;
 }
 arch_initcall(rb532_gpio_init);
-- 
1.5.6.4
