Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2008 00:31:46 +0100 (BST)
Received: from bby1mta03.pmc-sierra.com ([216.241.235.118]:34456 "EHLO
	bby1mta03.pmc-sierra.bc.ca") by ftp.linux-mips.org with ESMTP
	id S28579612AbYHRXbh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 19 Aug 2008 00:31:37 +0100
Received: from bby1mta03.pmc-sierra.bc.ca (localhost.pmc-sierra.bc.ca [127.0.0.1])
	by localhost (Postfix) with SMTP id 2C9E110700DE;
	Mon, 18 Aug 2008 16:35:43 -0700 (PDT)
Received: from bby1infra06.pmc-sierra.bc.ca (bby1infra06.pmc-sierra.bc.ca [216.241.226.185])
	by bby1mta03.pmc-sierra.bc.ca (Postfix) with ESMTP id B5FA610700D6;
	Mon, 18 Aug 2008 16:35:42 -0700 (PDT)
Received: from pmc-sierra.com (bby1swd01.pmc-sierra.bc.ca [216.241.226.177])
	by bby1infra06.pmc-sierra.com (8.13.4/8.12.7) with ESMTP id m7ILfVDn028042;
	Mon, 18 Aug 2008 14:41:31 -0700 (PDT)
Received: from bby1swd01.pmc-sierra.bc.ca ([127.0.0.1])
	by pmc-sierra.com (8.13.1/8.13.1) with ESMTP id m7ILfUHS010341;
	Mon, 18 Aug 2008 14:41:31 -0700
From:	Patrick Glass <patrickglass@gmail.com>
Subject: [PATCH] mips: PMC MSP71XX gpio drivers
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Date:	Mon, 18 Aug 2008 14:41:30 -0700
Message-ID: <20080818214130.10283.80918.stgit@bby1swd01.pmc-sierra.bc.ca>
User-Agent: StGIT/0.14
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-PMX-Version: 5.4.4.348488, Antispam-Engine: 2.6.0.325393, Antispam-Data: 2008.8.18.231917
X-PMC-SpamCheck: Gauge=IIIIIIIII, Probability=10%, Report='HASHBUSTER_BLOCK_V2 0.5, FORGED_FROM_GMAIL 0.1, BODY_SIZE_10000_PLUS 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __FRAUD_419_BODY_WEBMAIL 0, __FRAUD_419_WEBMAIL 0, __FRAUD_419_WEBMAIL_FROM 0, __FROM_GMAIL 0, __HASHBUSTER_BLOCK_V2_1 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Return-Path: <patrickglass@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20251
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: patrickglass@gmail.com
Precedence: bulk
X-list: linux-mips

This new gpio driver for PMC-Sierra's MSP71xx SoC allows
standard api calls for access to the general and extended
gpio's.

Signed-off-by: Patrick Glass <patrickglass@gmail.com>
---

 arch/mips/pmc-sierra/msp71xx/Makefile        |    1 
 arch/mips/pmc-sierra/msp71xx/gpio.c          |  218 ++++++++++++++++++++++++++
 arch/mips/pmc-sierra/msp71xx/gpio_extended.c |  148 ++++++++++++++++++
 include/asm-mips/pmc-sierra/msp71xx/gpio.h   |   46 +++++
 4 files changed, 413 insertions(+), 0 deletions(-)
 create mode 100755 arch/mips/pmc-sierra/msp71xx/gpio.c
 create mode 100755 arch/mips/pmc-sierra/msp71xx/gpio_extended.c
 create mode 100755 include/asm-mips/pmc-sierra/msp71xx/gpio.h


diff --git a/arch/mips/pmc-sierra/msp71xx/Makefile b/arch/mips/pmc-sierra/msp71xx/Makefile
index 4bba79c..e107f79 100644
--- a/arch/mips/pmc-sierra/msp71xx/Makefile
+++ b/arch/mips/pmc-sierra/msp71xx/Makefile
@@ -3,6 +3,7 @@
 #
 obj-y += msp_prom.o msp_setup.o msp_irq.o \
 	 msp_time.o msp_serial.o msp_elb.o
+obj-$(CONFIG_HAVE_GPIO_LIB) += gpio.o gpio_extended.o
 obj-$(CONFIG_PMC_MSP7120_GW) += msp_hwbutton.o
 obj-$(CONFIG_IRQ_MSP_SLP) += msp_irq_slp.o
 obj-$(CONFIG_IRQ_MSP_CIC) += msp_irq_cic.o
diff --git a/arch/mips/pmc-sierra/msp71xx/gpio.c b/arch/mips/pmc-sierra/msp71xx/gpio.c
new file mode 100755
index 0000000..0e9e86d
--- /dev/null
+++ b/arch/mips/pmc-sierra/msp71xx/gpio.c
@@ -0,0 +1,218 @@
+/**
+ * @file /arch/mips/pmc-sierra/msp71xx/gpio.c
+ *
+ * Generic PMC MSP71xx GPIO handling. These base gpio are controlled by two
+ * types of registers. The data register sets the output level when in output
+ * mode and when in input mode will contain the value at the input. The config
+ * register sets the various modes for each gpio.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * @author Patrick Glass <patrickglass@gmail.com>
+ **/
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/gpio.h>
+#include <linux/spinlock.h>
+#include <linux/io.h>
+
+#define MSP71XX_CFG_OFFSET(gpio)	(4 * (gpio))
+#define CONF_MASK			0x0F
+#define MSP71XX_GPIO_INPUT		0x01
+#define MSP71XX_GPIO_OUTPUT		0x08
+
+#define MSP71XX_GPIO_BASE		0x0B8400000L
+
+#define to_msp71xx_gpio_chip(c) container_of(c, struct msp71xx_gpio_chip, chip)
+
+static spinlock_t gpio_lock;
+
+/**
+ * struct msp71xx_gpio_chip - container for gpio chip and registers
+ * @chip: chip structure for the specified gpio bank
+ * @data_reg: register for reading and writing the gpio pin value
+ * @config_reg: register to set the mode for the gpio pin bank
+ * @out_drive_reg: register to set the output drive mode for the gpio pin bank
+ **/
+struct msp71xx_gpio_chip {
+	struct gpio_chip chip;
+	void __iomem *data_reg;
+	void __iomem *config_reg;
+	void __iomem *out_drive_reg;
+};
+
+/**
+ * msp71xx_gpio_get() - return the chip's gpio value
+ * @chip: chip structure which controls the specified gpio
+ * @offset: gpio whose value will be returned
+ *
+ * It will return 0 if gpio value is low and other if high.
+ **/
+static int msp71xx_gpio_get(struct gpio_chip *chip, unsigned offset)
+{
+	struct msp71xx_gpio_chip *msp_chip = to_msp71xx_gpio_chip(chip);
+
+	return __raw_readl(msp_chip->data_reg) & (1 << offset);
+}
+
+/**
+ * msp71xx_gpio_set() - set the output value for the gpio
+ * @chip: chip structure who controls the specified gpio
+ * @offset: gpio whose value will be assigned
+ * @value: logic level to assign to the gpio initially
+ *
+ * This will set the gpio bit specified to the desired value. It will set the
+ * gpio pin low if value is 0 otherwise it will be high.
+ **/
+static void msp71xx_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
+{
+	struct msp71xx_gpio_chip *msp_chip = to_msp71xx_gpio_chip(chip);
+	unsigned long flags;
+	u32 data;
+
+	spin_lock_irqsave(&gpio_lock, flags);
+
+	data = __raw_readl(msp_chip->data_reg);
+	if (value)
+		data |= (1 << offset);
+	else
+		data &= ~(1 << offset);
+	__raw_writel(data, msp_chip->data_reg);
+
+	spin_unlock_irqrestore(&gpio_lock, flags);
+}
+
+/**
+ * msp71xx_set_gpio_mode() - declare the mode for a gpio
+ * @chip: chip structure which controls the specified gpio
+ * @offset: gpio whose value will be assigned
+ * @mode: desired configuration for the gpio (see datasheet)
+ *
+ * It will set the gpio pin config to the @mode value passed in.
+ **/
+static int msp71xx_set_gpio_mode(struct gpio_chip *chip,
+				 unsigned offset, int mode)
+{
+	struct msp71xx_gpio_chip *msp_chip = to_msp71xx_gpio_chip(chip);
+	const unsigned bit_offset = MSP71XX_CFG_OFFSET(offset);
+	unsigned long flags;
+	u32 cfg;
+
+	spin_lock_irqsave(&gpio_lock, flags);
+
+	cfg = __raw_readl(msp_chip->config_reg);
+	cfg &= ~(CONF_MASK << bit_offset);
+	cfg |= (mode << bit_offset);
+	__raw_writel(cfg, msp_chip->config_reg);
+
+	spin_unlock_irqrestore(&gpio_lock, flags);
+
+	return 0;
+}
+
+/**
+ * msp71xx_direction_output() - declare the direction mode for a gpio
+ * @chip: chip structure which controls the specified gpio
+ * @offset: gpio whose value will be assigned
+ * @value: logic level to assign to the gpio initially
+ *
+ * This call will set the mode for the @gpio to output. It will set the
+ * gpio pin low if value is 0 otherwise it will be high.
+ **/
+static int msp71xx_direction_output(struct gpio_chip *chip,
+				    unsigned offset, int value)
+{
+	msp71xx_gpio_set(chip, offset, value);
+
+	return msp71xx_set_gpio_mode(chip, offset, MSP71XX_GPIO_OUTPUT);
+}
+
+/**
+ * msp71xx_direction_input() - declare the direction mode for a gpio
+ * @chip: chip structure which controls the specified gpio
+ * @offset: gpio whose to which the value will be assigned
+ *
+ * This call will set the mode for the @gpio to input.
+ **/
+static int msp71xx_direction_input(struct gpio_chip *chip, unsigned offset)
+{
+	return msp71xx_set_gpio_mode(chip, offset, MSP71XX_GPIO_INPUT);
+}
+
+/**
+ * msp71xx_set_output_drive() - declare the output drive for the gpio line
+ * @gpio: gpio pin whose output drive you wish to modify
+ * @value: zero for active drain 1 for open drain drive
+ *
+ * This call will set the output drive mode for the @gpio to output.
+ **/
+int msp71xx_set_output_drive(unsigned gpio, int value)
+{
+	unsigned long flags;
+	u32 data;
+
+	if (gpio > 15 || gpio < 0)
+		return -EINVAL;
+
+	spin_lock_irqsave(&gpio_lock, flags);
+
+	data = __raw_readl((void __iomem *)(MSP71XX_GPIO_BASE + 0x190));
+	if (value)
+		data |= (1 << gpio);
+	else
+		data &= ~(1 << gpio);
+	__raw_writel(data, (void __iomem *)(MSP71XX_GPIO_BASE + 0x190));
+
+	spin_unlock_irqrestore(&gpio_lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL(msp71xx_set_output_drive);
+
+#define MSP71XX_GPIO_BANK(name, dr, cr, base_gpio, num_gpio) \
+{ \
+	.chip = { \
+		.label		  = name, \
+		.direction_input  = msp71xx_direction_input, \
+		.direction_output = msp71xx_direction_output, \
+		.get		  = msp71xx_gpio_get, \
+		.set		  = msp71xx_gpio_set, \
+		.base		  = base_gpio, \
+		.ngpio		  = num_gpio \
+	}, \
+	.data_reg	= (void __iomem *)(MSP71XX_GPIO_BASE + dr), \
+	.config_reg	= (void __iomem *)(MSP71XX_GPIO_BASE + cr), \
+	.out_drive_reg	= (void __iomem *)(MSP71XX_GPIO_BASE + 0x190), \
+}
+
+/**
+ * struct msp71xx_gpio_banks[] - container array of gpio banks
+ * @chip: chip structure for the specified gpio bank
+ * @data_reg: register for reading and writing the gpio pin value
+ * @config_reg: register to set the mode for the gpio pin bank
+ *
+ * This array structure defines the gpio banks for the PMC MIPS Processor.
+ * We specify the bank name, the data register, the config register, base
+ * starting gpio number, and the number of gpios exposed by the bank.
+ **/
+static struct msp71xx_gpio_chip msp71xx_gpio_banks[] = {
+
+	MSP71XX_GPIO_BANK("GPIO_1_0", 0x170, 0x180, 0, 2),
+	MSP71XX_GPIO_BANK("GPIO_5_2", 0x174, 0x184, 2, 4),
+	MSP71XX_GPIO_BANK("GPIO_9_6", 0x178, 0x188, 6, 4),
+	MSP71XX_GPIO_BANK("GPIO_15_10", 0x17C, 0x18C, 10, 6),
+};
+
+void __init msp71xx_init_gpio(void)
+{
+	int i;
+
+	spin_lock_init(&gpio_lock);
+
+	for (i = 0; i < ARRAY_SIZE(msp71xx_gpio_banks); i++)
+		gpiochip_add(&msp71xx_gpio_banks[i].chip);
+}
diff --git a/arch/mips/pmc-sierra/msp71xx/gpio_extended.c b/arch/mips/pmc-sierra/msp71xx/gpio_extended.c
new file mode 100755
index 0000000..fe6a04c
--- /dev/null
+++ b/arch/mips/pmc-sierra/msp71xx/gpio_extended.c
@@ -0,0 +1,148 @@
+/**
+ * @file /arch/mips/pmc-sierra/msp71xx/gpio_extended.c
+ *
+ * Generic PMC MSP71xx EXTENDED (EXD) GPIO handling. The extended gpio is
+ * a set of hardware registers that have no need for explicit locking as
+ * it is handled by unique method of writing individual set/clr bits.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * @author Patrick Glass <patrickglass@gmail.com>
+ **/
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/gpio.h>
+#include <linux/io.h>
+
+#define MSP71XX_DATA_OFFSET(gpio)	(2 * (gpio))
+#define MSP71XX_READ_OFFSET(gpio)	(MSP71XX_DATA_OFFSET(gpio) + 1)
+#define MSP71XX_CFG_OUT_OFFSET(gpio)	(MSP71XX_DATA_OFFSET(gpio) + 16)
+#define MSP71XX_CFG_IN_OFFSET(gpio)	(MSP71XX_CFG_OUT_OFFSET(gpio) + 1)
+
+#define MSP71XX_EXD_GPIO_BASE	0x0BC000000L
+
+#define to_msp71xx_exd_gpio_chip(c) \
+			container_of(c, struct msp71xx_exd_gpio_chip, chip)
+
+/**
+ * struct msp71xx_exd_gpio_chip - container for gpio chip and registers
+ * @chip: chip structure for the specified gpio bank
+ * @reg: register for control and data of gpio pin
+ **/
+struct msp71xx_exd_gpio_chip {
+	struct gpio_chip chip;
+	void __iomem *reg;
+};
+
+/**
+ * msp71xx_exd_gpio_get() - return the chip's gpio value
+ * @chip: chip structure which controls the specified gpio
+ * @offset: gpio whose value will be returned
+ *
+ * It will return 0 if gpio value is low and other if high.
+ **/
+static int msp71xx_exd_gpio_get(struct gpio_chip *chip, unsigned offset)
+{
+	struct msp71xx_exd_gpio_chip *msp71xx_chip =
+	    to_msp71xx_exd_gpio_chip(chip);
+	const unsigned bit = MSP71XX_READ_OFFSET(offset);
+
+	return __raw_readl(msp71xx_chip->reg) & (1 << bit);
+}
+
+/**
+ * msp71xx_exd_gpio_set() - set the output value for the gpio
+ * @chip: chip structure who controls the specified gpio
+ * @offset: gpio whose value will be assigned
+ * @value: logic level to assign to the gpio initially
+ *
+ * This will set the gpio bit specified to the desired value. It will set the
+ * gpio pin low if value is 0 otherwise it will be high.
+ **/
+static void msp71xx_exd_gpio_set(struct gpio_chip *chip,
+				 unsigned offset, int value)
+{
+	struct msp71xx_exd_gpio_chip *msp71xx_chip =
+	    to_msp71xx_exd_gpio_chip(chip);
+	const unsigned bit = MSP71XX_DATA_OFFSET(offset);
+
+	__raw_writel(1 << (bit + (value ? 1 : 0)), msp71xx_chip->reg);
+}
+
+/**
+ * msp71xx_exd_direction_output() - declare the direction mode for a gpio
+ * @chip: chip structure which controls the specified gpio
+ * @offset: gpio whose value will be assigned
+ * @value: logic level to assign to the gpio initially
+ *
+ * This call will set the mode for the @gpio to output. It will set the
+ * gpio pin low if value is 0 otherwise it will be high.
+ **/
+static int msp71xx_exd_direction_output(struct gpio_chip *chip,
+					unsigned offset, int value)
+{
+	struct msp71xx_exd_gpio_chip *msp71xx_chip =
+	    to_msp71xx_exd_gpio_chip(chip);
+
+	msp71xx_exd_gpio_set(chip, offset, value);
+	__raw_writel(1 << MSP71XX_CFG_OUT_OFFSET(offset), msp71xx_chip->reg);
+	return 0;
+}
+
+/**
+ * msp71xx_exd_direction_input() - declare the direction mode for a gpio
+ * @chip: chip structure which controls the specified gpio
+ * @offset: gpio whose to which the value will be assigned
+ *
+ * This call will set the mode for the @gpio to input.
+ **/
+static int msp71xx_exd_direction_input(struct gpio_chip *chip, unsigned offset)
+{
+	struct msp71xx_exd_gpio_chip *msp71xx_chip =
+	    to_msp71xx_exd_gpio_chip(chip);
+
+	__raw_writel(1 << MSP71XX_CFG_IN_OFFSET(offset), msp71xx_chip->reg);
+	return 0;
+}
+
+#define MSP71XX_EXD_GPIO_BANK(name, exd_reg, base_gpio, num_gpio) \
+{ \
+	.chip = { \
+		.label		  = name, \
+		.direction_input  = msp71xx_exd_direction_input, \
+		.direction_output = msp71xx_exd_direction_output, \
+		.get		  = msp71xx_exd_gpio_get, \
+		.set		  = msp71xx_exd_gpio_set, \
+		.base		  = base_gpio, \
+		.ngpio		  = num_gpio, \
+	}, \
+	.reg	= (void __iomem *)(MSP71XX_EXD_GPIO_BASE + exd_reg), \
+}
+
+/**
+ * struct msp71xx_exd_gpio_banks[] - container array of gpio banks
+ * @chip: chip structure for the specified gpio bank
+ * @reg: register for reading and writing the gpio pin value
+ *
+ * This array structure defines the extended gpio banks for the
+ * PMC MIPS Processor. We specify the bank name, the data/config
+ * register,the base starting gpio number, and the number of
+ * gpios exposed by the bank of gpios.
+ **/
+static struct msp71xx_exd_gpio_chip msp71xx_exd_gpio_banks[] = {
+
+	MSP71XX_EXD_GPIO_BANK("GPIO_23_16", 0x188, 16, 8),
+	MSP71XX_EXD_GPIO_BANK("GPIO_27_24", 0x18C, 24, 4),
+};
+
+void __init msp71xx_init_gpio_extended(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(msp71xx_exd_gpio_banks); i++)
+		gpiochip_add(&msp71xx_exd_gpio_banks[i].chip);
+}
diff --git a/include/asm-mips/pmc-sierra/msp71xx/gpio.h b/include/asm-mips/pmc-sierra/msp71xx/gpio.h
new file mode 100755
index 0000000..5b6d481
--- /dev/null
+++ b/include/asm-mips/pmc-sierra/msp71xx/gpio.h
@@ -0,0 +1,46 @@
+/**
+ * include/asm-mips/pmc-sierra/msp71xx/gpio.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * @author Patrick Glass <patrickglass@gmail.com>
+ **/
+
+#ifndef __PMC_MSP71XX_GPIO_H
+#define __PMC_MSP71XX_GPIO_H
+
+/* Max number of gpio's is 28 on chip plus 3 banks of I2C IO Expanders */
+#define ARCH_NR_GPIOS (28 + (3 * 8))
+
+/* new generic GPIO API - see Documentation/gpio.txt */
+#include <asm-generic/gpio.h>
+
+#define gpio_get_value	__gpio_get_value
+#define gpio_set_value	__gpio_set_value
+#define gpio_cansleep	__gpio_cansleep
+
+/* Setup calls for the gpio and gpio extended */
+extern void msp71xx_init_gpio(void);
+extern void msp71xx_init_gpio_extended(void);
+extern int msp71xx_set_output_drive(unsigned gpio, int value);
+
+/* Custom output drive functionss */
+static inline int gpio_set_output_drive(unsigned gpio, int value)
+{
+	return msp71xx_set_output_drive(gpio, value);
+}
+
+/* IRQ's are not supported for gpio lines */
+static inline int gpio_to_irq(unsigned gpio)
+{
+	return -EINVAL;
+}
+
+static inline int irq_to_gpio(unsigned irq)
+{
+	return -EINVAL;
+}
+
+#endif /* __PMC_MSP71XX_GPIO_H */
