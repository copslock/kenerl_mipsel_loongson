Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Nov 2015 01:16:54 +0100 (CET)
Received: from exsmtp01.microchip.com ([198.175.253.37]:13018 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27013023AbbKUAQ1aH6Nx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Nov 2015 01:16:27 +0100
Received: from mx.microchip.com (10.10.76.4) by CHN-SV-EXCH01.mchp-main.com
 (10.10.76.37) with Microsoft SMTP Server id 14.3.181.6; Fri, 20 Nov 2015
 17:16:24 -0700
Received: by mx.microchip.com (sSMTP sendmail emulation); Fri, 20 Nov 2015
 17:22:50 -0700
From:   Joshua Henderson <joshua.henderson@microchip.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>,
        Andrei Pistirica <andrei.pistirica@microchip.com>,
        Joshua Henderson <joshua.henderson@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>
Subject: [PATCH 08/14] pinctrl: Add PIC32 pin control driver
Date:   Fri, 20 Nov 2015 17:17:20 -0700
Message-ID: <1448065205-15762-9-git-send-email-joshua.henderson@microchip.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1448065205-15762-1-git-send-email-joshua.henderson@microchip.com>
References: <1448065205-15762-1-git-send-email-joshua.henderson@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Joshua.Henderson@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50015
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joshua.henderson@microchip.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

From: Andrei Pistirica <andrei.pistirica@microchip.com>

Add a driver for the pin controller present on the Microchip PIC32
including the specific variant PIC32MZDA. This driver provides pinmux
and pinconfig operations as well as GPIO and IRQ chips for the GPIO
banks.

Signed-off-by: Andrei Pistirica <andrei.pistirica@microchip.com>
Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
---
 drivers/pinctrl/Kconfig             |   17 +
 drivers/pinctrl/Makefile            |    2 +
 drivers/pinctrl/pinctrl-pic32.c     | 2127 +++++++++++++++++++++++++++++++++++
 drivers/pinctrl/pinctrl-pic32.h     |  158 +++
 drivers/pinctrl/pinctrl-pic32mzda.c |  294 +++++
 drivers/pinctrl/pinctrl-pic32mzda.h |   40 +
 6 files changed, 2638 insertions(+)
 create mode 100644 drivers/pinctrl/pinctrl-pic32.c
 create mode 100644 drivers/pinctrl/pinctrl-pic32.h
 create mode 100644 drivers/pinctrl/pinctrl-pic32mzda.c
 create mode 100644 drivers/pinctrl/pinctrl-pic32mzda.h

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index b422e4e..27feef0 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -248,6 +248,23 @@ config PINCTRL_ZYNQ
 	help
 	  This selectes the pinctrl driver for Xilinx Zynq.
 
+config PINCTRL_PIC32
+	bool "Microchip PIC32 pin controller driver"
+	depends on OF
+	depends on MACH_PIC32
+	select PINMUX
+	select GENERIC_PINCONF
+	select GPIOLIB_IRQCHIP
+	select GENERIC_IRQ_CHIP
+	help
+	  This is the pin controller and gpio driver for Microchip PIC32
+	  microcontrollers. This option is selected automatically when specific
+	  machine and arch are selected to build.
+
+config PINCTRL_PIC32MZDA
+	def_bool y if PIC32MZDA
+	select PINCTRL_PIC32
+
 source "drivers/pinctrl/bcm/Kconfig"
 source "drivers/pinctrl/berlin/Kconfig"
 source "drivers/pinctrl/freescale/Kconfig"
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 738cb49..149e723 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -54,3 +54,5 @@ obj-$(CONFIG_ARCH_SUNXI)	+= sunxi/
 obj-$(CONFIG_PINCTRL_UNIPHIER)	+= uniphier/
 obj-$(CONFIG_ARCH_VT8500)	+= vt8500/
 obj-$(CONFIG_ARCH_MEDIATEK)	+= mediatek/
+obj-$(CONFIG_PINCTRL_PIC32)	+= pinctrl-pic32.o
+obj-$(CONFIG_PINCTRL_PIC32MZDA)	+= pinctrl-pic32mzda.o
diff --git a/drivers/pinctrl/pinctrl-pic32.c b/drivers/pinctrl/pinctrl-pic32.c
new file mode 100644
index 0000000..ae2ab21
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-pic32.c
@@ -0,0 +1,2127 @@
+/*
+ * pic32 pinctrl core driver.
+ *
+ * Copyright (C) 2015 Microchip Technology, Inc.
+ * Author: Sorin-Andrei Pistirica <andrei.pistirica@microchip.com>
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/io.h>
+#include <linux/gpio.h>
+#include <linux/pinctrl/machine.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+/* Since we request GPIOs from ourself */
+#include <linux/pinctrl/consumer.h>
+
+#include "core.h"
+#include "pinctrl-pic32.h"
+
+/* struct pic32_gpio_irq - pic32 gpio irq descriptor
+ * @gpio_irqchip: irq chip descriptor related to pin bank
+ * @domain: associated irq domain
+ * @pio_irq: PIO bank hardware interrupt
+ * @type: type of interrupt per pin: RISE, FALL or BOTH.
+ **/
+struct pic32_gpio_irq {
+	struct irq_chip		gpio_irqchip;
+	struct irq_domain	*domain;
+	int			pio_irq;
+
+	u32			type[PINS_PER_BANK];
+};
+
+/* struct pic32_gpio_chip - pic32 gpio chip descriptor
+ * @chip: gpio chip descriptor
+ * @pio_base: port's registers base address
+ * @reg_lookup_off: registers offsets (map may vary within pic32 family chips)
+ * @pio_idx: port index (0-to-10 alias A-to-J)
+ * @clk: associated clock
+ * @gpio_irq: pic32 gpio irq descriptor
+ * @range: pin ranges as gpio in pinctrl device
+ **/
+struct pic32_gpio_chip {
+	struct gpio_chip		chip;
+	void __iomem			*pio_base;
+	unsigned			*reg_lookup_off;
+	unsigned			lookup_size;
+	int				pio_idx;
+	int				gpio_base;
+	int				ngpio;
+	struct clk			*clk;
+
+	struct pic32_gpio_irq		gpio_irq;
+	struct pinctrl_gpio_range	range;
+};
+#define to_pic32_gpio_chip(c) container_of(c, struct pic32_gpio_chip, chip)
+
+static struct pic32_gpio_chip *gpio_chips[MAX_PIO_BANKS];
+
+/* get a specific pic32:pio register */
+static void __iomem *pic32_pio_get_reg(struct pic32_gpio_chip *pic32_chip,
+				       enum pic32_pio_regs pic32_reg)
+{
+	void __iomem *base = pic32_chip->pio_base;
+	unsigned *lookup = pic32_chip->reg_lookup_off;
+	unsigned lookup_size = pic32_chip->lookup_size;
+
+	if (WARN_ON(pic32_reg > lookup_size ||
+			lookup[pic32_reg] == PIC32_OFF_UNSPEC)) {
+		dev_err(pic32_chip->chip.dev,
+			"BUG: Wrong register offset: %u!\n",
+			pic32_reg);
+
+		/* check against NULL before use the register !*/
+		return NULL;
+	}
+
+	return base + lookup[pic32_reg];
+}
+
+/* set pin to open-drain */
+static int pic32_pinconf_open_drain(struct pic32_gpio_chip *pic32_chip,
+				    unsigned pin, int value)
+{
+	struct pic32_reg __iomem *odc_reg = (struct pic32_reg __iomem *)
+			pic32_pio_get_reg(pic32_chip, PIC32_ODC);
+	u32 mask = BIT(pin);
+
+	if (WARN_ON(odc_reg == NULL || pin >= pic32_chip->chip.ngpio))
+		return -EINVAL;
+
+	if (value)
+		/* NOTE: I/O direction will be changed to out */
+		writel(mask, &odc_reg->set);
+	else
+		writel(mask, &odc_reg->clr);
+
+	dev_dbg(pic32_chip->chip.dev, "%s: OPEN-DRAIN pin (%u:%u)\n", __func__,
+						pic32_chip->pio_idx, pin);
+
+	return 0;
+}
+
+/* set pin to pull-up */
+static int pic32_pinconf_pullup(struct pic32_gpio_chip *pic32_chip,
+				unsigned pin, int value)
+{
+	struct pic32_reg __iomem *cnpu_reg = (struct pic32_reg __iomem *)
+			pic32_pio_get_reg(pic32_chip, PIC32_CNPU);
+	u32 mask = BIT(pin);
+
+	if (WARN_ON(cnpu_reg == NULL || pin >= pic32_chip->chip.ngpio))
+		return -EINVAL;
+
+	if (value)
+		writel(mask, &cnpu_reg->set);
+	else
+		writel(mask, &cnpu_reg->clr);
+
+	dev_dbg(pic32_chip->chip.dev, "%s: PULL-UP pin (%u:%u)\n", __func__,
+						pic32_chip->pio_idx, pin);
+
+	return 0;
+}
+
+/* set pin to pull-down */
+static int pic32_pinconf_pulldown(struct pic32_gpio_chip *pic32_chip,
+				  unsigned pin, int value)
+{
+	struct pic32_reg __iomem *cnpd_reg = (struct pic32_reg __iomem *)
+			pic32_pio_get_reg(pic32_chip, PIC32_CNPD);
+	u32 mask = BIT(pin);
+
+	if (WARN_ON(cnpd_reg == NULL || pin >= pic32_chip->chip.ngpio))
+		return -EINVAL;
+
+	if (value)
+		writel(mask, &cnpd_reg->set);
+	else
+		writel(mask, &cnpd_reg->clr);
+
+	dev_dbg(pic32_chip->chip.dev, "%s: PULL-DOWN pin (%u:%u)\n", __func__,
+						pic32_chip->pio_idx, pin);
+
+	return 0;
+}
+
+/* set pin to analog */
+static int pic32_pinconf_analog(struct pic32_gpio_chip *pic32_chip,
+				unsigned pin)
+{
+	struct pic32_reg __iomem *ansel_reg = (struct pic32_reg __iomem *)
+				pic32_pio_get_reg(pic32_chip, PIC32_ANSEL);
+	u32 mask = BIT(pin);
+
+	if (WARN_ON(ansel_reg == NULL || pin >= pic32_chip->chip.ngpio))
+		return -EINVAL;
+
+	writel(mask, &ansel_reg->set);
+
+	dev_dbg(pic32_chip->chip.dev, "%s: ANALOG pin (%u:%u)\n", __func__,
+						pic32_chip->pio_idx, pin);
+
+	return 0;
+}
+
+/* set pin as digital */
+static int pic32_pinconf_dg(struct pic32_gpio_chip *pic32_chip, unsigned pin)
+{
+	struct pic32_reg __iomem *ansel_reg = (struct pic32_reg __iomem *)
+				pic32_pio_get_reg(pic32_chip, PIC32_ANSEL);
+	u32 mask = BIT(pin);
+
+	if (WARN_ON(ansel_reg == NULL || pin >= pic32_chip->chip.ngpio))
+		return -EINVAL;
+
+	writel(mask, &ansel_reg->clr);
+
+	dev_dbg(pic32_chip->chip.dev, "%s: DIGITAL pin (%u:%u)\n", __func__,
+						pic32_chip->pio_idx, pin);
+
+	return 0;
+}
+
+/* set pin dir according to configuration */
+static int pic32_pinconf_set_dir(struct pic32_gpio_chip *pic32_chip,
+				 unsigned pin, unsigned long conf)
+{
+	struct pin_conf *pinconf = (struct pin_conf *)&conf;
+	struct pic32_reg __iomem *tris_reg = (struct pic32_reg __iomem *)
+				pic32_pio_get_reg(pic32_chip, PIC32_TRIS);
+	u32 mask = BIT(pin);
+
+	if (WARN_ON(tris_reg == NULL || pin >= pic32_chip->chip.ngpio))
+		goto err;
+
+	switch (pinconf->dir) {
+	case DIR_NONE:
+		goto out;
+	break;
+	case DIR_IN:
+		writel(mask, &tris_reg->set);
+	break;
+	case DIR_OUT:
+		writel(mask, &tris_reg->clr);
+	break;
+	default:
+		dev_err(pic32_chip->chip.dev,
+				"BUG: Wrong pin direction (%u)!\n",
+				pinconf->dir);
+		goto err;
+	break;
+	}
+
+out:
+	dev_dbg(pic32_chip->chip.dev, "%s: pin (%u:%u), DIR:%s\n", __func__,
+			pic32_chip->pio_idx, pin,
+			pinconf->dir == DIR_IN ? "IN" : "OUT");
+	return 0;
+err:
+	return -EINVAL;
+}
+
+/* exported wrappers - runtime manipulation */
+static struct pic32_gpio_chip *gpio_to_pic32_gpio_chip(unsigned pin_id)
+{
+	unsigned bank = pin_id / PINS_PER_BANK;
+	unsigned pin = pin_id % PINS_PER_BANK;
+
+	if (WARN_ON(pin > PINS_PER_BANK || bank >= MAX_PIO_BANKS))
+		return ERR_PTR(-EINVAL);
+
+	return gpio_chips[bank];
+}
+
+int pic32_pinconf_open_drain_runtime(unsigned pin_id, int value)
+{
+	struct pic32_gpio_chip *pic32_chip = gpio_to_pic32_gpio_chip(pin_id);
+	unsigned pin = pin_id % PINS_PER_BANK;
+
+	if (IS_ERR_OR_NULL(pic32_chip))
+		return -ENODEV;
+
+	return pic32_pinconf_open_drain(pic32_chip, pin, value);
+}
+EXPORT_SYMBOL(pic32_pinconf_open_drain_runtime);
+
+int pic32_pinconf_pullup_runtime(unsigned pin_id, int value)
+{
+	struct pic32_gpio_chip *pic32_chip = gpio_to_pic32_gpio_chip(pin_id);
+	unsigned pin = pin_id % PINS_PER_BANK;
+
+	if (IS_ERR_OR_NULL(pic32_chip))
+		return -ENODEV;
+
+	return pic32_pinconf_pullup(pic32_chip, pin, value);
+}
+EXPORT_SYMBOL(pic32_pinconf_pullup_runtime);
+
+int pic32_pinconf_pulldown_runtime(unsigned pin_id, int value)
+{
+	struct pic32_gpio_chip *pic32_chip = gpio_to_pic32_gpio_chip(pin_id);
+	unsigned pin = pin_id % PINS_PER_BANK;
+
+	if (IS_ERR_OR_NULL(pic32_chip))
+		return -ENODEV;
+
+	return pic32_pinconf_pulldown(pic32_chip, pin, value);
+}
+EXPORT_SYMBOL(pic32_pinconf_pulldown_runtime);
+
+int pic32_pinconf_analog_runtime(unsigned pin_id)
+{
+	struct pic32_gpio_chip *pic32_chip = gpio_to_pic32_gpio_chip(pin_id);
+	unsigned pin = pin_id % PINS_PER_BANK;
+
+	if (IS_ERR_OR_NULL(pic32_chip))
+		return -ENODEV;
+
+	return pic32_pinconf_analog(pic32_chip, pin);
+}
+EXPORT_SYMBOL(pic32_pinconf_analog_runtime);
+
+int pic32_pinconf_dg_runtime(unsigned pin_id)
+{
+	struct pic32_gpio_chip *pic32_chip = gpio_to_pic32_gpio_chip(pin_id);
+	unsigned pin = pin_id % PINS_PER_BANK;
+
+	if (IS_ERR_OR_NULL(pic32_chip))
+		return -ENODEV;
+
+	return pic32_pinconf_dg(pic32_chip, pin);
+}
+EXPORT_SYMBOL(pic32_pinconf_dg_runtime);
+
+static int pic32_gpio_request(struct gpio_chip *chip, unsigned offset)
+{
+	int gpio = chip->base + offset;
+	int bank = chip->base / chip->ngpio;
+
+	dev_dbg(chip->dev, "%s: request GPIO-%c:%d(%d)\n", __func__,
+		 'A' + bank, offset, gpio);
+
+	return pinctrl_request_gpio(gpio);
+}
+
+static void pic32_gpio_free(struct gpio_chip *chip, unsigned offset)
+{
+	int gpio = chip->base + offset;
+	int bank = chip->base / chip->ngpio;
+
+	dev_dbg(chip->dev, "%s: free GPIO-%c:%d(%d)\n", __func__,
+		 'A' + bank, offset, gpio);
+
+	pinctrl_free_gpio(gpio);
+}
+
+static void pic32_gpio_set(struct gpio_chip *chip, unsigned gpio, int val)
+{
+	struct pic32_gpio_chip *pic32_chip = to_pic32_gpio_chip(chip);
+	struct pic32_reg __iomem *port_reg = (struct pic32_reg __iomem *)
+				pic32_pio_get_reg(pic32_chip, PIC32_PORT);
+	u32 mask = BIT(gpio);
+
+	if (WARN_ON(port_reg == NULL || gpio >= chip->ngpio)) {
+		dev_err(pic32_chip->chip.dev, "gpio setting error!\n");
+		return;
+	}
+
+	if (val)
+		writel(mask, &port_reg->set);
+	else
+		writel(mask, &port_reg->clr);
+}
+
+static int pic32_gpio_get(struct gpio_chip *chip, unsigned gpio)
+{
+	struct pic32_gpio_chip *pic32_chip = to_pic32_gpio_chip(chip);
+	struct pic32_reg __iomem *port_reg = (struct pic32_reg __iomem *)
+				pic32_pio_get_reg(pic32_chip, PIC32_PORT);
+	u32 mask = BIT(gpio);
+
+	if (WARN_ON(port_reg == NULL || gpio >= chip->ngpio))
+		return -EINVAL;
+
+	return readl(&port_reg->val) & mask;
+}
+
+static int pic32_gpio_get_dir(struct gpio_chip *chip, unsigned offset)
+{
+	struct pic32_gpio_chip *pic32_chip = to_pic32_gpio_chip(chip);
+	struct pic32_reg __iomem *tris_reg = (struct pic32_reg __iomem *)
+				pic32_pio_get_reg(pic32_chip, PIC32_TRIS);
+	u32 mask = BIT(offset);
+
+	if (WARN_ON(tris_reg == NULL))
+		return -EINVAL;
+
+	return readl(&tris_reg->val) & mask;
+}
+
+static int pic32_gpio_set_dir(struct gpio_chip *chip, unsigned gpio, int dir)
+{
+	struct pic32_gpio_chip *pic32_chip = to_pic32_gpio_chip(chip);
+	struct pic32_reg __iomem *tris_reg = (struct pic32_reg __iomem *)
+				pic32_pio_get_reg(pic32_chip, PIC32_TRIS);
+	u32 mask = BIT(gpio);
+
+	if (WARN_ON(tris_reg == NULL || gpio >= chip->ngpio))
+		return -EINVAL;
+
+	/* clear analog selection when digital input is required! */
+	if (WARN_ON(pic32_pinconf_dg(pic32_chip, gpio) < 0))
+		return -EINVAL;
+
+	if (dir == DIR_IN)
+		writel(mask, &tris_reg->set);
+	else if (dir == DIR_OUT)
+		writel(mask, &tris_reg->clr);
+
+	return 0;
+}
+
+static int pic32_gpio_dir_in(struct gpio_chip *chip, unsigned gpio)
+{
+	return pic32_gpio_set_dir(chip, gpio, DIR_IN);
+}
+
+static int pic32_gpio_dir_out(struct gpio_chip *chip,
+			      unsigned gpio, int value)
+{
+	struct pic32_gpio_chip *pic32_chip = to_pic32_gpio_chip(chip);
+	struct pic32_reg __iomem *cnpu_reg = (struct pic32_reg __iomem *)
+				pic32_pio_get_reg(pic32_chip, PIC32_CNPU);
+	struct pic32_reg __iomem *cnpd_reg = (struct pic32_reg __iomem *)
+				pic32_pio_get_reg(pic32_chip, PIC32_CNPD);
+	u32 mask = BIT(gpio);
+	int ret = 0;
+
+	if (WARN_ON(cnpu_reg == NULL || cnpd_reg == NULL ||
+			gpio >= chip->ngpio)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* clear open-drain for value of 1 */
+	if (value) {
+		ret = pic32_pinconf_open_drain(pic32_chip, gpio, 0);
+		if (WARN_ON(ret < 0))
+			goto out;
+	}
+
+	/* set required value */
+	pic32_gpio_set(chip, gpio, value);
+
+	/* clear when digital output is required! */
+	writel(mask, &cnpu_reg->clr); /* pull-up */
+	writel(mask, &cnpd_reg->clr); /* pull-down */
+
+	return pic32_gpio_set_dir(chip, gpio, DIR_OUT);
+out:
+	return ret;
+}
+
+static int pic32_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
+{
+	struct pic32_gpio_chip *pic32_chip = to_pic32_gpio_chip(chip);
+	struct pic32_gpio_irq *gpio_irq = &pic32_chip->gpio_irq;
+	int virq;
+
+	if (offset < chip->ngpio)
+		virq = irq_create_mapping(gpio_irq->domain, offset);
+	else
+		virq = -ENXIO;
+
+	dev_dbg(chip->dev, "%s: request IRQ for GPIO:%d, return:%d\n",
+				__func__, offset + chip->base, virq);
+
+	return virq;
+}
+
+#ifdef CONFIG_DEBUG_FS
+static void pic32_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
+{
+	int i;
+
+	for (i = 0; i < chip->ngpio; i++) {
+		const char *gpio_label;
+
+		gpio_label = gpiochip_is_requested(chip, i);
+		if (!gpio_label)
+			continue;
+
+		seq_printf(s, "%s: GPIO-%s:%d\n", gpio_label, chip->label, i);
+	}
+}
+#else
+#define pic32_gpio_dbg_show	NULL
+#endif
+
+static void pic32_gpio_ranges_setup(struct platform_device *pdev,
+			     struct pic32_gpio_chip *pic32_chip)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct pinctrl_gpio_range *range;
+	struct of_phandle_args args;
+	int ret;
+
+	ret = of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3, 0, &args);
+	pic32_chip->gpio_base = (ret == 0) ? args.args[1] + args.args[0] :
+					pic32_chip->pio_idx * PINS_PER_BANK;
+	pic32_chip->ngpio = (ret == 0) ? args.args[2] - args.args[0] :
+					PINS_PER_BANK;
+
+	range = &pic32_chip->range;
+	range->name = dev_name(&pdev->dev);
+	range->id = pic32_chip->pio_idx;
+	range->pin_base = range->base = pic32_chip->gpio_base;
+
+	range->npins = pic32_chip->ngpio;
+	range->gc = &pic32_chip->chip;
+
+	dev_dbg(&pdev->dev, "%s: GPIO-%c ranges: (%d,%d)\n", __func__,
+				'A' + range->id,
+				pic32_chip->gpio_base, pic32_chip->ngpio);
+}
+
+
+static inline int
+pic32_gpio_irq_rise_dset(struct pic32_gpio_chip *pic32_chip, unsigned pin)
+{
+	struct pic32_reg __iomem *cncon_reg = (struct pic32_reg __iomem *)
+				pic32_pio_get_reg(pic32_chip, PIC32_CNCON);
+	struct pic32_reg __iomem *cnen_reg = (struct pic32_reg __iomem *)
+				pic32_pio_get_reg(pic32_chip, PIC32_CNEN);
+	u32 cn_en = BIT(PIC32_CNCON_ON);
+	u32 cn_edge = BIT(PIC32_CNCON_EDGE);
+	u32 pin_mask = BIT(pin);
+
+	if (WARN_ON(cncon_reg == NULL || cnen_reg == NULL ||
+			pin >= pic32_chip->chip.ngpio))
+		return -EINVAL;
+
+	/* enable RISE detection */
+	writel(pin_mask, &cnen_reg->set);
+
+	/* enable CN-EDGE detection */
+	writel(cn_edge, &cncon_reg->set);
+
+	/* enable CN module */
+	writel(cn_en, &cncon_reg->set);
+
+	dev_dbg(pic32_chip->chip.dev, "%s: CN rise edge set for pin:%u\n",
+		__func__, pin);
+
+	return 0;
+}
+
+static inline int
+pic32_gpio_irq_fall_dset(struct pic32_gpio_chip *pic32_chip, unsigned pin)
+{
+	struct pic32_reg __iomem *cncon_reg = (struct pic32_reg __iomem *)
+				pic32_pio_get_reg(pic32_chip, PIC32_CNCON);
+	struct pic32_reg __iomem *cnne_reg = (struct pic32_reg __iomem *)
+				pic32_pio_get_reg(pic32_chip, PIC32_CNNE);
+	u32 cn_en = BIT(PIC32_CNCON_ON);
+	u32 cn_edge = BIT(PIC32_CNCON_EDGE);
+	u32 pin_mask = BIT(pin);
+
+	if (WARN_ON(cncon_reg == NULL || cnne_reg == NULL ||
+			pin >= pic32_chip->chip.ngpio))
+		return -EINVAL;
+
+	/* enable FALL detection */
+	writel(pin_mask, &cnne_reg->set);
+
+	/* enable CN-EDGE detection */
+	writel(cn_edge, &cncon_reg->set);
+
+	/* enable CN module */
+	writel(cn_en, &cncon_reg->set);
+
+	dev_dbg(pic32_chip->chip.dev, "%s: CN fall edge set for pin:%u\n",
+		__func__, pin);
+
+	return 0;
+}
+
+static unsigned int gpio_irq_startup(struct irq_data *d)
+{
+	struct pic32_gpio_chip *pic32_chip = irq_data_get_irq_chip_data(d);
+	struct pic32_gpio_irq *gpio_irq = &pic32_chip->gpio_irq;
+	unsigned pin = d->hwirq;
+	int ret;
+
+	ret = gpiochip_lock_as_irq(&pic32_chip->chip, pin);
+	if (ret) {
+		dev_err(pic32_chip->chip.dev, "unable to lock pind %lu IRQ\n",
+			d->hwirq);
+		return ret;
+	}
+
+	/* start CN */
+	switch (gpio_irq->type[pin]) {
+	case IRQ_TYPE_EDGE_RISING:
+		pic32_gpio_irq_rise_dset(pic32_chip, pin);
+	break;
+	case IRQ_TYPE_EDGE_FALLING:
+		pic32_gpio_irq_fall_dset(pic32_chip, pin);
+	break;
+	case IRQ_TYPE_EDGE_BOTH:
+		pic32_gpio_irq_rise_dset(pic32_chip, pin);
+		pic32_gpio_irq_fall_dset(pic32_chip, pin);
+	break;
+	default:
+		return -EINVAL;
+	}
+
+	dev_dbg(pic32_chip->chip.dev, "%s: irq lock pin:%u\n", __func__, pin);
+
+	return 0;
+}
+
+static void gpio_irq_shutdown(struct irq_data *d)
+{
+	struct pic32_gpio_chip *pic32_chip = irq_data_get_irq_chip_data(d);
+	unsigned pin = d->hwirq;
+
+	gpiochip_unlock_as_irq(&pic32_chip->chip, pin);
+
+	dev_dbg(pic32_chip->chip.dev, "%s: irq unlock:%u\n", __func__, pin);
+}
+
+static int gpio_irq_type(struct irq_data *d, unsigned type)
+{
+	struct pic32_gpio_chip *pic32_chip = irq_data_get_irq_chip_data(d);
+	struct pic32_gpio_irq *gpio_irq = &pic32_chip->gpio_irq;
+	unsigned pin = d->hwirq;
+
+	dev_dbg(pic32_chip->chip.dev, "%s: irq type:%u\n", __func__, type);
+
+	switch (type) {
+	case IRQ_TYPE_EDGE_RISING:
+	case IRQ_TYPE_EDGE_FALLING:
+	case IRQ_TYPE_EDGE_BOTH:
+		gpio_irq->type[pin] = type;
+		return IRQ_SET_MASK_OK;
+	default:
+		gpio_irq->type[pin] = IRQ_TYPE_NONE;
+		return -EINVAL;
+	}
+}
+
+/* map virtual irq on hw irq: domain translation */
+static int pic32_gpio_irq_map(struct irq_domain *d,
+			      unsigned int virq,
+			      irq_hw_number_t hw)
+{
+	struct pic32_gpio_chip *pic32_chip = d->host_data;
+	struct pic32_gpio_irq *gpio_irq = &pic32_chip->gpio_irq;
+	struct irq_chip *irqchip = &gpio_irq->gpio_irqchip;
+
+	dev_dbg(pic32_chip->chip.dev, "%s: GPIO-%c:%d map virq:%u\n", __func__,
+				'A' + pic32_chip->pio_idx, virq, virq);
+
+	/* set the gpioX chip */
+	irq_set_chip(virq, irqchip);
+	irq_set_chip_data(virq, pic32_chip);
+	irq_set_handler(virq, handle_simple_irq);
+
+	return 0;
+}
+
+/* decode irq number: base + pin */
+static int pic32_gpio_irq_domain_xlate(struct irq_domain *d,
+				       struct device_node *ctrlr,
+				       const u32 *intspec,
+				       unsigned int intsize,
+				       irq_hw_number_t *out_hwirq,
+				       unsigned int *out_type)
+{
+	struct pic32_gpio_chip *pic32_chip = d->host_data;
+	int pin = pic32_chip->chip.base + intspec[0];
+	int ret;
+
+	if (WARN_ON(intsize < 2))
+		return -EINVAL;
+
+	ret = gpio_request(pin, ctrlr->full_name);
+	if (ret)
+		return ret;
+
+	*out_hwirq = intspec[0];
+	*out_type = intspec[1] & IRQ_TYPE_SENSE_MASK;
+
+	/* pic32_gpio_dir_in */
+	ret = gpio_direction_input(pin);
+	if (ret)
+		return ret;
+
+	dev_dbg(pic32_chip->chip.dev, "%s: xlate pin:%d\n", __func__, pin);
+	return 0;
+}
+
+static struct irq_domain_ops pic32_gpio_irqd_ops = {
+	.map	= pic32_gpio_irq_map,
+	.xlate	= pic32_gpio_irq_domain_xlate,
+};
+
+static unsigned long pic32_gpio_to_isr(struct pic32_gpio_chip *pic32_chip,
+					int status)
+{
+	struct pic32_gpio_irq *gpio_irq = &pic32_chip->gpio_irq;
+	struct pic32_reg __iomem *cnne_reg = (struct pic32_reg __iomem *)
+				pic32_pio_get_reg(pic32_chip, PIC32_CNNE);
+	struct pic32_reg __iomem *cnen_reg = (struct pic32_reg __iomem *)
+				pic32_pio_get_reg(pic32_chip, PIC32_CNEN);
+	unsigned long isr = (unsigned long)status;
+	unsigned long visr = 0;
+	int cnen_rise, cnne_fall;
+	int pin;
+
+	if (WARN_ON(cnne_reg == NULL || cnen_reg == NULL)) {
+		dev_err(pic32_chip->chip.dev,
+			"BUG: wrong register offsets!\n");
+		return 0;
+	}
+
+	cnen_rise = readl(cnen_reg);
+	cnne_fall = readl(cnne_reg);
+
+	/* for each change that occurred, match with irq type and
+	 * set it accordingly.
+	 */
+	visr = 0;
+	for_each_set_bit(pin, &isr, BITS_PER_BYTE * sizeof(u32)) {
+		u32 mask = BIT(pin);
+		bool type_rise = (gpio_irq->type[pin] == IRQ_TYPE_EDGE_RISING);
+		bool type_fall = (gpio_irq->type[pin] == IRQ_TYPE_EDGE_FALLING);
+		bool type_both = gpio_irq->type[pin] == IRQ_TYPE_EDGE_BOTH;
+		bool rise = cnen_rise & mask;
+		bool fall = cnne_fall & mask;
+
+		if ((type_rise && rise) || (type_fall && fall) || type_both)
+			visr |= mask;
+	}
+
+	return visr;
+}
+
+static void gpio_irq_handler(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct irq_data *idata = irq_desc_get_irq_data(desc);
+	struct pic32_gpio_chip *pic32_chip = irq_data_get_irq_chip_data(idata);
+	struct pic32_gpio_irq *gpio_irq = &pic32_chip->gpio_irq;
+	struct pic32_reg __iomem *cnf_reg = (struct pic32_reg __iomem *)
+				pic32_pio_get_reg(pic32_chip, PIC32_CNF);
+	u32 cnfstat = 0;
+	unsigned long isr;
+	int n;
+
+	if (WARN_ON(cnf_reg == NULL)) {
+		dev_err(pic32_chip->chip.dev,
+				"BUG: wrong register offsets!\n");
+		return;
+	}
+
+	/* read CN status */
+	cnfstat = readl(cnf_reg);
+
+	/* set a logical isr based on CN status
+	 * Note: in case of isr error, the isr will be 0.
+	 */
+	isr =  pic32_gpio_to_isr(pic32_chip, cnfstat);
+	dev_dbg(pic32_chip->chip.dev, "%s: isr:0x%lx\n", __func__, isr);
+
+	/* clear CN source */
+	writel(cnfstat, &cnf_reg->clr);
+
+	chained_irq_enter(chip, desc);
+
+	/* for each interrupt, call handle */
+	for_each_set_bit(n, &isr, BITS_PER_LONG) {
+		unsigned int irq = irq_find_mapping(gpio_irq->domain, n);
+
+		generic_handle_irq(irq);
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static int pic32_gpio_of_irq_setup(struct platform_device *pdev,
+				   struct pic32_gpio_chip *pic32_chip)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct pic32_gpio_irq *gpio_irq = &pic32_chip->gpio_irq;
+	struct irq_chip *irqchip = &gpio_irq->gpio_irqchip;
+	int base_irq;
+
+	/* set irqchip */
+	irqchip->name = kasprintf(GFP_KERNEL, "GPIO-%c",
+						pic32_chip->pio_idx + 'A');
+	irqchip->irq_startup	= gpio_irq_startup;
+	irqchip->irq_shutdown	= gpio_irq_shutdown;
+	irqchip->irq_set_type	= gpio_irq_type;
+
+	base_irq = platform_get_irq(pdev, 0);
+	if (base_irq < 0)
+		return base_irq;
+
+	gpio_irq->pio_irq = base_irq;
+
+	/* Setup irq domain of ngpio lines */
+	gpio_irq->domain = irq_domain_add_linear(
+					node,
+					pic32_chip->chip.ngpio,
+					&pic32_gpio_irqd_ops, pic32_chip);
+	if (!gpio_irq->domain) {
+		dev_err(pic32_chip->chip.dev, "Couldn't allocate IRQ domain\n");
+		return -ENXIO;
+	}
+
+	dev_dbg(&pdev->dev, "%s: irq GPIO-%c, base_irq:%d, domain:%d\n",
+					 __func__, pic32_chip->pio_idx + 'A',
+					base_irq, pic32_chip->chip.ngpio);
+
+	/* setup chained handler */
+	irq_set_chip_data(gpio_irq->pio_irq, pic32_chip);
+	irq_set_chained_handler(gpio_irq->pio_irq, gpio_irq_handler);
+
+	return 0;
+}
+
+static struct gpio_chip gpio_template = {
+	.request		= pic32_gpio_request,
+	.free			= pic32_gpio_free,
+	.get_direction		= pic32_gpio_get_dir,
+	.direction_input	= pic32_gpio_dir_in,
+	.direction_output	= pic32_gpio_dir_out,
+	.get			= pic32_gpio_get,
+	.set			= pic32_gpio_set,
+	.to_irq			= pic32_gpio_to_irq,
+	.dbg_show		= pic32_gpio_dbg_show,
+	.ngpio			= PINS_PER_BANK,
+	.can_sleep		= false,
+};
+
+int pic32_gpio_probe(struct platform_device *pdev,
+		     unsigned (*reg_lookup_off)[],
+		     unsigned lookup_size)
+{
+	struct device_node *np = pdev->dev.of_node;
+	int alias_idx = of_alias_get_id(np, "gpio");
+	struct pic32_gpio_chip *pic32_chip = NULL;
+	struct gpio_chip *chip;
+	struct resource *r;
+	int ret = 0;
+
+	dev_dbg(&pdev->dev, "%s: probing...\n", __func__);
+
+	if (!np)
+		return -ENODEV;
+
+	if (WARN_ON(alias_idx >= ARRAY_SIZE(gpio_chips)))
+		return -EINVAL;
+
+	if (gpio_chips[alias_idx]) {
+		dev_err(&pdev->dev, "Failure %i for GPIO %i\n", ret, alias_idx);
+		return -EBUSY;
+	}
+
+	/* pic32 gpio chip - private data */
+	pic32_chip = devm_kzalloc(&pdev->dev, sizeof(*pic32_chip),
+								GFP_KERNEL);
+	if (!pic32_chip)
+		return -ENOMEM;
+
+	/* base address of pio(alias_idx) registers */
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r) {
+		ret = -EINVAL;
+		goto probe_err;
+	}
+	pic32_chip->pio_base = devm_ioremap_nocache(&pdev->dev, r->start,
+							resource_size(r));
+	if (IS_ERR(pic32_chip->pio_base)) {
+		ret = PTR_ERR(pic32_chip->pio_base);
+		goto probe_err;
+	}
+
+	/* clocks */
+	pic32_chip->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(pic32_chip->clk)) {
+		ret = PTR_ERR(pic32_chip->clk);
+		dev_err(&pdev->dev, "clk get failed\n");
+		goto probe_err;
+	}
+
+	ret = clk_prepare_enable(pic32_chip->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "clk enable failed\n");
+		goto probe_err;
+	}
+
+	pic32_chip->reg_lookup_off = *reg_lookup_off;
+	pic32_chip->lookup_size = lookup_size;
+	pic32_chip->pio_idx = alias_idx;
+	pic32_chip->chip = gpio_template;
+	pic32_gpio_ranges_setup(pdev, pic32_chip);/* pin_ranges: unsupported */
+	pic32_gpio_of_irq_setup(pdev, pic32_chip);/* irq domain */
+
+	/* gpio chip */
+	chip		= &pic32_chip->chip;
+	chip->of_node	= np;
+	chip->label	= dev_name(&pdev->dev);
+	chip->dev	= &pdev->dev;
+	chip->owner	= THIS_MODULE;
+	chip->base	= pic32_chip->gpio_base;
+	chip->ngpio	= pic32_chip->ngpio;
+
+	ret = gpiochip_add(chip);
+	if (ret)
+		goto probe_err;
+	gpio_chips[alias_idx] = pic32_chip;
+
+	dev_info(&pdev->dev, "(%d) driver initialized.\n", alias_idx);
+	return 0;
+
+probe_err:
+	if (pic32_chip->pio_base)
+		devm_iounmap(&pdev->dev, pic32_chip->pio_base);
+	if (pic32_chip) {
+		devm_kfree(&pdev->dev, pic32_chip);
+		gpio_chips[alias_idx] = NULL;
+	}
+	return ret;
+}
+
+static struct pic32_pinctrl_prop pinctrl_props[PIC32_PINCTRL_PROP_LAST] = {
+	[PIC32_PINCTRL_PROP_SINGLE_PINS] =
+		PIC32_PINCTRL_DT_PROP("pic32,single-pins", 3),
+	[PIC32_PINCTRL_PROP_PINS] =
+		PIC32_PINCTRL_DT_PROP("pic32,pins", 3),
+};
+
+/* struct pin_function - pic32 pin function descriptor
+ * @name: the name of the pinmux function
+ * @ngroups: number of groups related to this function
+ * @groups: groups related to this function
+ **/
+struct pin_function {
+	const char	*name;
+	unsigned	ngroups;
+	const char	**groups;
+};
+
+/* struct gspin - pic32 single-pins descriptor
+ * @bank: the pin's bank(PORT)
+ * @pin: the pin's id within bank(PORT)
+ * @conf: the configuration of the pin: PULL_UP, MULTIDRIVE etc...
+ **/
+struct gspin {
+	unsigned	bank;
+	unsigned	pin;
+	unsigned long	conf;
+};
+
+/* struct gpins - pic32 pinmux descriptor
+ * @dir: pin direction (in or out)
+ * @bucket: remappable pin bucket (A(0):D(3))
+ * @bank: remappable pin's bank (A(0):K(9))
+ * @pin: the remappable pin in the @bank
+ * @ppin: peripheral pin mapped
+ * @cod: pinmux code
+ * @conf: the configuration of the pin: PULL_UP, MULTIDRIVE etc...
+ **/
+struct gpins {
+	u8		dir;
+	u8		bucket;
+	u8		bank;
+	u8		pin;
+	u8		ppin;
+	u16		cod;
+	unsigned long	conf;
+};
+
+/* struct pin_group - pic32 pin group descriptor
+ * @name: the name of the pin group
+ * @npins: number of pins in this group (no. single-pins + no. pinmux)
+ * @pins: array of pin ids (pinctrl forces to maintain such an array)
+ * @ngspins: number of single pins within group
+ * @gspins: descriptor of single pins within group
+ * @ngpins: number of pinmux pins within group
+ * @gpins: descriptor of pinmux pins within group
+ **/
+struct pin_group {
+	const char	*name;
+
+	unsigned	npins;
+	unsigned int	*pins;
+
+	unsigned	ngspins;
+	struct gspin	*gspins;
+	unsigned	ngpins;
+	struct gpins	*gpins;
+};
+
+/* struct pic32_pinctrl_data - pic32 pinctrl descriptor
+ * @dev: related device
+ * @pctl: related pinctrl device
+ * @ppsin_base: peripheral pin select input base address
+ * @ppsout_base: peripheral pin select output base address
+ * @pps_off: pps registers mapping
+ * @clk: associated clock
+ * @nbanks: number of banks (ports)
+ * @npins: number pf pins
+ * @ngroups: number of groups
+ * @groups: pinctrl's groups (related to all functions)
+ * @nfunctions: number of functions
+ * @functions: pinctrl's functions
+ **/
+struct pic32_pinctrl_data {
+	struct device			*dev;
+	struct pinctrl_dev		*pctl;
+
+	void __iomem			*ppsin_base;
+	void __iomem			*ppsout_base;
+	struct pic32_pps_off		*pps_off;
+	struct clk			*clk;
+
+	struct pic32_caps		caps;
+
+	unsigned			nbanks;
+	unsigned			npins;
+
+	unsigned			ngroups;
+	struct pin_group		*groups;
+
+	unsigned			nfunctions;
+	struct pin_function		*functions;
+};
+
+/* check pinconf capabilities and set the configuration */
+static int pic32_pinconf_set(struct pic32_pinctrl_data *data,
+			     struct pic32_gpio_chip *pic32_chip,
+			     unsigned long conf, unsigned pin)
+{
+	struct pic32_caps *caps = &data->caps;
+	int ret = 0;
+
+	/* check if pin configuration is supported */
+	if (!(conf & caps->pinconf_caps) &&
+	    !(conf & caps->pinconf_outcaps) &&
+	    !(conf & caps->pinconf_incaps)) {
+
+		dev_err(data->dev, "pin configuration not supported %lu\n",
+			conf);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* set direction */
+	if (WARN_ON(pic32_pinconf_set_dir(pic32_chip, pin, conf) < 0)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* set configuration */
+	switch (conf) {
+	case PIC32_PIN_CONF_OD:
+	case PIC32_PIN_CONF_OD_OUT:
+		return pic32_pinconf_open_drain(pic32_chip, pin, 1);
+	case PIC32_PIN_CONF_PU:
+	case PIC32_PIN_CONF_PU_IN:
+		return pic32_pinconf_pullup(pic32_chip, pin, 1);
+	case PIC32_PIN_CONF_PD:
+	case PIC32_PIN_CONF_PD_IN:
+		return pic32_pinconf_pulldown(pic32_chip, pin, 1);
+	case PIC32_PIN_CONF_AN:
+	case PIC32_PIN_CONF_AN_IN:
+		return pic32_pinconf_analog(pic32_chip, pin);
+	case PIC32_PIN_CONF_DG:
+	case PIC32_PIN_CONF_DG_IN:
+	case PIC32_PIN_CONF_DG_OUT:
+		return pic32_pinconf_dg(pic32_chip, pin);
+	default:
+		ret = -EINVAL;
+		goto out;
+	}
+
+out:
+	return ret;
+}
+
+/* is pin open-drain? */
+static u32 pic32_pinconf_is_open_drain(struct pic32_gpio_chip *pic32_chip,
+				       unsigned pin)
+{
+	struct pic32_reg __iomem *odc_reg = (struct pic32_reg __iomem *)
+			pic32_pio_get_reg(pic32_chip, PIC32_ODC);
+	u32 mask = BIT(pin);
+
+	if (WARN_ON(odc_reg == NULL || pin >= pic32_chip->chip.ngpio))
+		return -EINVAL;
+
+	return readl(&odc_reg->val) & mask;
+}
+
+/* is pin pull-up? */
+static u32 pic32_pinconf_is_pullup(struct pic32_gpio_chip *pic32_chip,
+				   unsigned pin)
+{
+	struct pic32_reg __iomem *cnpu_reg = (struct pic32_reg __iomem *)
+			pic32_pio_get_reg(pic32_chip, PIC32_CNPU);
+	u32 mask = BIT(pin);
+
+	if (WARN_ON(cnpu_reg == NULL || pin >= pic32_chip->chip.ngpio))
+		return -EINVAL;
+
+	return readl(&cnpu_reg->val) & mask;
+}
+
+/* is pin pull-down? */
+static u32 pic32_pinconf_is_pulldown(struct pic32_gpio_chip *pic32_chip,
+				     unsigned pin)
+{
+	struct pic32_reg __iomem *cnpd_reg = (struct pic32_reg __iomem *)
+			pic32_pio_get_reg(pic32_chip, PIC32_CNPD);
+	u32 mask = BIT(pin);
+
+	if (WARN_ON(cnpd_reg == NULL || pin >= pic32_chip->chip.ngpio))
+		return -EINVAL;
+
+	return readl(&cnpd_reg->set) & mask;
+}
+
+/* is pin analog? */
+static u32 pic32_pinconf_is_analog(struct pic32_gpio_chip *pic32_chip,
+				   unsigned pin)
+{
+	struct pic32_reg __iomem *ansel_reg = (struct pic32_reg __iomem *)
+				pic32_pio_get_reg(pic32_chip, PIC32_ANSEL);
+	u32 mask = BIT(pin);
+
+	if (WARN_ON(ansel_reg == NULL || pin >= pic32_chip->chip.ngpio))
+		return -EINVAL;
+
+	return readl(&ansel_reg->set) & mask;
+}
+
+/* get pin's configuration */
+static unsigned long pic32_pinconf_get(struct pic32_gpio_chip *pic32_chip,
+				       unsigned pin)
+{
+	u32 pinconf = 0;
+
+	pinconf |= pic32_pinconf_is_open_drain(pic32_chip, pin);
+	pinconf |= pic32_pinconf_is_pullup(pic32_chip, pin);
+	pinconf |= pic32_pinconf_is_pulldown(pic32_chip, pin);
+	pinconf |= pic32_pinconf_is_analog(pic32_chip, pin);
+
+	return (unsigned long)pinconf;
+}
+
+/* get the config of a certain pin */
+static int pic32_pin_config_get(struct pinctrl_dev *pctldev,
+				unsigned pin_id, unsigned long *config)
+{
+	struct pic32_pinctrl_data *data = pinctrl_dev_get_drvdata(pctldev);
+	unsigned bank = pin_id / PINS_PER_BANK;
+	unsigned pin = pin_id % PINS_PER_BANK;
+	struct pic32_gpio_chip *pic32_chip = gpio_chips[bank];
+
+	if (WARN_ON(pin_id > PINS_PER_BANK * MAX_PIO_BANKS))
+		return -EINVAL;
+
+	*config = pic32_pinconf_get(pic32_chip, pin);
+
+	dev_dbg(data->dev, "%s: get config:0x%lx of pin (%u,%u)\n", __func__,
+							*config, bank, pin);
+
+	return 0;
+}
+
+/* configure an individual pin */
+static int pic32_pin_config_set(struct pinctrl_dev *pctldev,
+				unsigned pin_id, unsigned long *configs,
+				unsigned num_configs)
+{
+	struct pic32_pinctrl_data *data = pinctrl_dev_get_drvdata(pctldev);
+	struct pic32_gpio_chip *pic32_chip;
+	unsigned bank = pin_id / PINS_PER_BANK;
+	unsigned pin = pin_id % PINS_PER_BANK;
+	int i;
+
+	if (WARN_ON(pin > PINS_PER_BANK || bank >= MAX_PIO_BANKS))
+		return -EINVAL;
+
+	pic32_chip = gpio_chips[bank];
+
+	for (i = 0; i < num_configs; i++) {
+		unsigned long config = configs[i];
+		int err;
+
+		if (config == PIC32_PIN_CONF_NONE)
+			continue;
+
+		dev_dbg(data->dev, "%s: set config:0x%lx to pin (%u,%u)\n",
+						__func__, config, bank, pin);
+
+		/* check caps and set a particular mux function */
+		err = pic32_pinconf_set(data, pic32_chip, config, pin);
+		if (WARN_ON(err < 0)) {
+			dev_err(data->dev, "pin(%u) settings failed.\n", pin);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_DEBUG_FS
+/* debugfs: info for a certain pin */
+static void pic32_pinconf_dbg_show(struct pinctrl_dev *pctldev,
+				   struct seq_file *s, unsigned pin)
+{
+	struct pic32_pinctrl_data *data = pinctrl_dev_get_drvdata(pctldev);
+
+	dev_dbg(data->dev, "%s: NULL\n", __func__);
+}
+
+/* debugfs: info for a certain pin group */
+static void pic32_pinconf_group_dbg_show(struct pinctrl_dev *pctldev,
+					 struct seq_file *s, unsigned group)
+{
+	struct pic32_pinctrl_data *data = pinctrl_dev_get_drvdata(pctldev);
+
+	dev_dbg(data->dev, "%s: NULL\n", __func__);
+}
+#else
+#define pic32_pinconf_dbg_show NULL
+#define pic32_pinconf_group_dbg_show NULL
+#endif
+
+/* pin config operations */
+static const struct pinconf_ops pic32_pinconf_ops = {
+	.pin_config_get = pic32_pin_config_get,
+	.pin_config_set = pic32_pin_config_set,
+	.pin_config_dbg_show = pic32_pinconf_dbg_show,
+	.pin_config_group_dbg_show = pic32_pinconf_group_dbg_show,
+};
+
+/* returns number of selectable functions */
+static int pic32_pinmux_get_funcs_count(struct pinctrl_dev *pctldev)
+{
+	struct pic32_pinctrl_data *data = pinctrl_dev_get_drvdata(pctldev);
+
+	dev_dbg(data->dev, "%s: nfunction=%u\n", __func__, data->nfunctions);
+
+	return data->nfunctions;
+}
+
+/* return the function name */
+static const char *pic32_pinmux_get_func_name(struct pinctrl_dev *pctldev,
+					      unsigned selector)
+{
+	struct pic32_pinctrl_data *data = pinctrl_dev_get_drvdata(pctldev);
+
+	dev_dbg(data->dev, "%s: get:%s\n", __func__,
+					data->functions[selector].name);
+
+	return data->functions[selector].name;
+}
+
+/* return an array of groups names */
+static int pic32_pinmux_get_func_groups(struct pinctrl_dev *pctldev,
+					unsigned selector,
+					const char * const **groups,
+					unsigned * const num_groups)
+{
+	struct pic32_pinctrl_data *data = pinctrl_dev_get_drvdata(pctldev);
+
+	*groups = data->functions[selector].groups;
+	*num_groups = data->functions[selector].ngroups;
+
+	dev_dbg(data->dev, "%s: get groups(%u) of function=%u\n", __func__,
+							*num_groups, selector);
+
+	return 0;
+}
+
+/* get offset within PPS-OUT register for a particular re-mappable pin */
+static unsigned pic32_get_ppsout_offset(struct pic32_pinctrl_data *data,
+					unsigned bank, unsigned pin)
+{
+	struct pic32_pps_off *pps_off = data->pps_off;
+	unsigned (*lookup)[MAX_PIO_BANKS][PINS_PER_BANK];
+
+	lookup = pps_off->ppsout_lookup_off;
+	if (bank >= MAX_PIO_BANKS || pin > PINS_PER_BANK ||
+	    (*lookup)[bank][pin] == PIC32_OFF_UNSPEC)
+		return -EINVAL;
+
+	return (*lookup)[bank][pin];
+}
+
+/* set a particular OUT mux function for a particular
+ * re-mappable pin (bank,pin)
+ */
+static void pic32_ppsout_set(struct pic32_pinctrl_data *data,
+			     struct gpins *gpins,
+			     bool en)
+{
+	void __iomem *base = data->ppsout_base;
+	unsigned bank = gpins->bank;
+	unsigned pin = gpins->pin;
+	unsigned off = pic32_get_ppsout_offset(data, bank, pin);
+
+	if (en)
+		writel(gpins->cod, base + off);
+	else
+		writel(0x0, base + off);
+
+	dev_dbg(data->dev, "%s: en=%d bank=%u pin=%u off=%u cod=0x%x\n",
+				__func__, en, bank, pin, off, gpins->cod);
+}
+
+/* get offset within PPS-IN register for a particular peripheral pin */
+static unsigned pic32_get_ppsin_offset(struct pic32_pinctrl_data *data,
+				       unsigned ppin)
+{
+	struct pic32_pps_off *pps_off = data->pps_off;
+	unsigned (*lookup)[PP_MAX] = pps_off->ppsin_lookup_off;
+
+	if ((*lookup)[ppin] == PIC32_OFF_UNSPEC)
+		return -EINVAL;
+
+	return (*lookup)[ppin];
+}
+
+/* set a particular IN mux function for a particular
+ * peripheral pin (bank,pin)
+ */
+static void pic32_ppsin_set(struct pic32_pinctrl_data *data,
+			    struct gpins *gpins, bool en)
+{
+	unsigned ppin = gpins->ppin;
+	unsigned off = pic32_get_ppsin_offset(data, ppin);
+	void __iomem *base = data->ppsin_base;
+
+	if (en)
+		writel(gpins->cod, base + off);
+	else
+		writel(0x0, base + off);
+
+	dev_dbg(data->dev, "%s: en=%d ppin=%u off=%u cod=0x%x\n",
+				__func__, en, ppin, off, gpins->cod);
+}
+
+/* set a particular pinmux function */
+static int pic32_pinmux_muxen(struct pic32_pinctrl_data *data,
+			      struct gpins *gpins,
+			      bool en)
+{
+	if (gpins->dir == DIR_IN)
+		pic32_ppsin_set(data, gpins, en);
+	else if (gpins->dir == DIR_OUT)
+		pic32_ppsout_set(data, gpins, en);
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+/* enable a certain pinmux function within a pin group and
+ * within a muxing function
+ */
+static int pic32_pinmux_set_mux(struct pinctrl_dev *pctldev,
+			       unsigned selector, unsigned group)
+{
+	struct pic32_pinctrl_data *data = pinctrl_dev_get_drvdata(pctldev);
+	struct pin_group *grp = &data->groups[group];
+	unsigned ngpins = grp->ngpins;
+	struct gpins *gpins = data->groups[group].gpins;
+	int i;
+
+	dev_dbg(data->dev, "enable function %s for group %s\n",
+			data->functions[selector].name, grp->name);
+
+	for (i = 0; i < ngpins; i++) {
+		struct gpins *pins = &gpins[i];
+
+		pic32_pinmux_muxen(data, pins, true);
+	}
+
+	return 0;
+}
+
+/* enable a pin to work in GPIO mode */
+static int pic32_gpio_request_enable(struct pinctrl_dev *pctldev,
+				     struct pinctrl_gpio_range *range,
+				     unsigned offset)
+{
+	struct pic32_pinctrl_data *data = pinctrl_dev_get_drvdata(pctldev);
+	struct gpio_chip *chip = range->gc;
+	struct pic32_gpio_chip *pic32_chip = to_pic32_gpio_chip(chip);
+	struct pic32_reg __iomem *ansel_reg = (struct pic32_reg __iomem *)
+				pic32_pio_get_reg(pic32_chip, PIC32_ANSEL);
+	int pin = offset - chip->base;
+	u32 mask = BIT(pin);
+
+	if (WARN_ON(ansel_reg == NULL || pin >= pic32_chip->chip.ngpio))
+		return -EINVAL;
+
+	if (unlikely(!range)) {
+		dev_err(data->dev, "invalid range\n");
+		return -EINVAL;
+	}
+	if (unlikely(!range->gc)) {
+		dev_err(data->dev, "missing GPIO chip in range\n");
+		return -EINVAL;
+	}
+
+	/* clear analog selection when digital input is required! */
+	writel(mask, &ansel_reg->clr);
+
+	dev_dbg(data->dev, "%s: enable pin %u as GPIO-%c:%d\n", __func__,
+			offset, 'A' + range->id, pin);
+
+	return 0;
+}
+
+/* disable a pin from GPIO mode */
+static void pic32_gpio_disable_free(struct pinctrl_dev *pctldev,
+				    struct pinctrl_gpio_range *range,
+				    unsigned offset)
+{
+	struct pic32_pinctrl_data *data = pinctrl_dev_get_drvdata(pctldev);
+	struct gpio_chip *chip = range->gc;
+
+	if (unlikely(!range)) {
+		dev_err(data->dev, "invalid range\n");
+		return;
+	}
+	if (unlikely(!range->gc)) {
+		dev_err(data->dev, "missing GPIO chip in range\n");
+		return;
+	}
+
+	dev_dbg(data->dev, "%s: free pin %u as GPIO-%c:%d\n", __func__,
+			offset, 'A' + range->id, offset - chip->base);
+}
+
+/* pinmux operations */
+static const struct pinmux_ops pic32_pinmux_ops = {
+	.get_functions_count = pic32_pinmux_get_funcs_count,
+	.get_function_name = pic32_pinmux_get_func_name,
+	.get_function_groups = pic32_pinmux_get_func_groups,
+	.set_mux = pic32_pinmux_set_mux,
+	.gpio_request_enable = pic32_gpio_request_enable,
+	.gpio_disable_free = pic32_gpio_disable_free,
+};
+
+static const struct pin_group *pic32_pinctrl_find_group_by_name(
+				const struct pic32_pinctrl_data *data,
+				const char *name)
+{
+	const struct pin_group *grp = NULL;
+	int i;
+
+	for (i = 0; i < data->ngroups; i++) {
+		if (strcmp(data->groups[i].name, name))
+			continue;
+
+		grp = &data->groups[i];
+		dev_dbg(data->dev, "%s: found group:%s\n", __func__, name);
+		break;
+	}
+
+	return grp;
+}
+
+static int pic32_get_groups_count(struct pinctrl_dev *pctldev)
+{
+	struct pic32_pinctrl_data *data = pinctrl_dev_get_drvdata(pctldev);
+
+	dev_dbg(data->dev, "%s: ngroups:%u\n", __func__, data->ngroups);
+
+	return data->ngroups;
+}
+
+static const char *pic32_get_group_name(struct pinctrl_dev *pctldev,
+					unsigned selector)
+{
+	struct pic32_pinctrl_data *data = pinctrl_dev_get_drvdata(pctldev);
+
+	dev_dbg(data->dev, "%s: selector=%u group=%s\n", __func__,
+					selector, data->groups[selector].name);
+
+	return data->groups[selector].name;
+}
+
+static int pic32_get_group_pins(struct pinctrl_dev *pctldev, unsigned selector,
+				const unsigned **pins, unsigned *npins)
+{
+	struct pic32_pinctrl_data *data = pinctrl_dev_get_drvdata(pctldev);
+
+	*pins = data->groups[selector].pins;
+	*npins = data->groups[selector].npins;
+
+	dev_dbg(data->dev, "%s: get pins(%u) for group=%u\n", __func__,
+							*npins, selector);
+
+	return 0;
+}
+
+static void pic32_pin_dbg_show(struct pinctrl_dev *pctldev,
+			       struct seq_file *s, unsigned offset)
+{
+	struct pic32_pinctrl_data *data = pinctrl_dev_get_drvdata(pctldev);
+
+	seq_printf(s, "%s", dev_name(data->dev));
+}
+
+/* construct a config map for pins(single and pinmux) within a group */
+static int pic32_dt_node_to_map(struct pinctrl_dev *pctldev,
+				struct device_node *np,
+				struct pinctrl_map **map,
+				unsigned *num_maps)
+{
+	struct pic32_pinctrl_data *data = pinctrl_dev_get_drvdata(pctldev);
+	const struct pin_group *grp;
+	struct pinctrl_map *new_map;
+	struct device_node *parent;
+	int map_num = 1;
+	int i;
+
+	/* first find the group of this node and check if we need create
+	 * config maps for pins
+	 */
+	grp = pic32_pinctrl_find_group_by_name(data, np->name);
+	if (!grp) {
+		dev_err(data->dev, "unable to find group for node %s\n",
+			np->name);
+		return -EINVAL;
+	}
+
+	map_num += (grp->ngspins + grp->ngpins);
+	new_map = devm_kzalloc(pctldev->dev,
+				sizeof(*new_map) * map_num, GFP_KERNEL);
+	if (!new_map)
+		return -ENOMEM;
+
+	*map = new_map;
+	*num_maps = map_num;
+
+	/* create mux map */
+	parent = of_get_parent(np);
+	if (!parent) {
+		devm_kfree(pctldev->dev, new_map);
+		return -EINVAL;
+	}
+	new_map[0].type = PIN_MAP_TYPE_MUX_GROUP;
+	new_map[0].data.mux.function = parent->name;
+	new_map[0].data.mux.group = np->name;
+	of_node_put(parent);
+
+	/* single-pins */
+	new_map++;
+	for (i = 0; i < grp->ngspins; i++) {
+		unsigned pin = grp->gspins[i].bank * PINS_PER_BANK +
+							grp->gspins[i].pin;
+
+		new_map[i].type = PIN_MAP_TYPE_CONFIGS_PIN;
+		new_map[i].data.configs.group_or_pin =
+				pin_get_name(pctldev, pin);
+		new_map[i].data.configs.configs = &grp->gspins[i].conf;
+		new_map[i].data.configs.num_configs = 1;
+
+	}
+
+	/* pin-mux */
+	for (i = 0; i < grp->ngpins; i++) {
+		unsigned pin = grp->gpins[i].bank * PINS_PER_BANK +
+							grp->gpins[i].pin;
+
+		new_map[grp->ngspins + i].type = PIN_MAP_TYPE_CONFIGS_PIN;
+		new_map[grp->ngspins + i].data.configs.group_or_pin =
+				pin_get_name(pctldev, pin);
+		new_map[grp->ngspins + i].data.configs.configs =
+				&grp->gpins[i].conf;
+		new_map[grp->ngspins + i].data.configs.num_configs = 1;
+
+	}
+
+	dev_dbg(pctldev->dev, "%s: maps: function:%s group:%s num:%d\n",
+	__func__, (*map)->data.mux.function, (*map)->data.mux.group, map_num);
+
+	return 0;
+}
+
+static void pic32_dt_free_map(struct pinctrl_dev *pctldev,
+			      struct pinctrl_map *map, unsigned num_maps)
+{
+	struct pic32_pinctrl_data *data = pinctrl_dev_get_drvdata(pctldev);
+
+	dev_dbg(data->dev, "%s: free map=%p\n", __func__, map);
+
+	devm_kfree(pctldev->dev, map);
+}
+
+static const struct pinctrl_ops pic32_pinctrl_ops = {
+	.get_groups_count = pic32_get_groups_count,
+	.get_group_name = pic32_get_group_name,
+	.get_group_pins = pic32_get_group_pins,
+	.pin_dbg_show = pic32_pin_dbg_show,
+	.dt_node_to_map = pic32_dt_node_to_map,
+	.dt_free_map = pic32_dt_free_map,
+};
+
+static struct pinctrl_desc pic32_pinctrl_desc = {
+	.pctlops = &pic32_pinctrl_ops,
+	.pmxops = &pic32_pinmux_ops,
+	.confops = &pic32_pinconf_ops,
+	.owner = THIS_MODULE,
+};
+
+/* pinctrl mechanism force to keep a pin array, therfore the pin array will
+ * contain single-pinss and pinmux as well.
+ */
+static int pic32_pinctrl_cout_pins(struct platform_device *pdev,
+				   struct pin_group *grp)
+{
+	int i;
+
+	grp->npins = grp->ngspins + grp->ngpins;
+	grp->pins = devm_kzalloc(&pdev->dev, grp->npins * sizeof(unsigned int),
+				 GFP_KERNEL);
+	if (!grp->pins)
+		return -ENOMEM;
+
+	/* the single-pinss */
+	for (i = 0; i < grp->ngspins; i++) {
+		grp->pins[i] =
+			grp->gspins[i].bank * PINS_PER_BANK +
+							grp->gspins[i].pin;
+	}
+
+	/* the pinmux */
+	for (i = 0; i < grp->ngpins; i++) {
+		grp->pins[grp->ngspins + i] =
+			grp->gpins[i].bank * PINS_PER_BANK +
+							grp->gpins[i].pin;
+	}
+
+	return 0;
+}
+
+/* return the idx of a property within the array of properties */
+static int get_pic32_pinctrl_propidx(struct property *prop)
+{
+	int i;
+
+	for (i = 0; i < PIC32_PINCTRL_PROP_LAST; i++) {
+		if (!strcmp(pinctrl_props[i].name, prop->name))
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+/* parse single-pins entry within a group */
+static int pic32_pinctrl_parse_single_pins(struct platform_device *pdev,
+					   struct device_node *np,
+					   struct pin_group *grp,
+					   struct pic32_pinctrl_data *data,
+					   int idx)
+{
+	struct property *prop;
+	int length;
+	int u32array_size;
+	u32 *u32array;
+	int i;
+	int ret = 0;
+
+	/* sanity check */
+	prop = of_find_property(np, pinctrl_props[idx].name, &length);
+	if (!prop) {
+		ret = -EINVAL;
+		goto out_err;
+	}
+
+	/* get single-pins entries */
+	u32array_size = length/sizeof(u32);
+	if (u32array_size % pinctrl_props[idx].narg) {
+		ret = -EINVAL;
+		goto out_err;
+	}
+
+	u32array = kcalloc(u32array_size, sizeof(u32), GFP_KERNEL);
+	if (!u32array) {
+		ret = -ENOMEM;
+		goto out_err;
+	}
+
+	ret = of_property_read_u32_array(np, pinctrl_props[idx].name,
+						u32array, u32array_size);
+	if (ret)
+		goto clean_out_err;
+
+	grp->ngspins = u32array_size/pinctrl_props[idx].narg;
+	grp->gspins = devm_kzalloc(&pdev->dev,
+				grp->ngspins * sizeof(struct gspin),
+				GFP_KERNEL);
+
+	dev_dbg(data->dev, "%s: parse %u pins\n", __func__,
+							grp->ngspins);
+	/* single-pins configuration entry:
+	 *   <pin-bank> <pin-idx> <pin-conf>
+	 */
+	for (i = 0; i < grp->ngspins; i++) {
+		u32 *bank = (i == 0 ? u32array : (++u32array));
+		u32 *pin = (++u32array);
+		struct pin_conf *pinconf = (struct pin_conf *)(++u32array);
+
+		grp->gspins[i].bank = *bank;
+		grp->gspins[i].pin = *pin;
+
+		/* we need the direction for differentiate between
+		 * PPS-in and PPS-out
+		 */
+		grp->gspins[i].conf = (CONF_DIR(pinconf->dir) |
+				       CONF_COD(pinconf->conf));
+	}
+
+	return 0;
+clean_out_err:
+	kfree(u32array);
+out_err:
+	dev_err(data->dev, "wrong single-pins entry\n");
+	return ret;
+}
+
+/* parse pinmux entry within a group */
+static int pic32_pinctrl_parse_pins(struct platform_device *pdev,
+				    struct device_node *np,
+				    struct pin_group *grp,
+				    struct pic32_pinctrl_data *data,
+				    int idx)
+{
+	struct property *prop;
+	int length;
+	int u32array_size;
+	u32 *u32array;
+	int i;
+	int ret = 0;
+
+	/* sanity check */
+	prop = of_find_property(np, pinctrl_props[idx].name, &length);
+	if (!prop) {
+		ret = -EINVAL;
+		goto out_err;
+	}
+
+	u32array_size = length/sizeof(u32);
+	if (u32array_size % pinctrl_props[idx].narg) {
+		ret = -EINVAL;
+		goto out_err;
+	}
+
+
+	/* get pinmux entries */
+	u32array = kcalloc(u32array_size, sizeof(u32), GFP_KERNEL);
+	if (!u32array) {
+		ret = -ENOMEM;
+		goto out_err;
+	}
+
+	ret = of_property_read_u32_array(np, pinctrl_props[idx].name,
+						u32array, u32array_size);
+	if (ret)
+		goto out_clean_err;
+
+	grp->ngpins = u32array_size/pinctrl_props[idx].narg;
+	grp->gpins = devm_kzalloc(&pdev->dev,
+				grp->ngpins * sizeof(struct gpins),
+				GFP_KERNEL);
+
+	dev_dbg(data->dev, "%s: parse %u pins\n", __func__,
+							grp->ngpins);
+	/* pinmux configuration entry:
+	 *   <pin-code> <peripheral-pin-code> <pin-conf>
+	 */
+	for (i = 0; i < grp->ngpins; i++) {
+		struct rpin_cod *pincod = (struct rpin_cod *)
+					  (i == 0 ? u32array : (++u32array));
+		struct ppin_cod *ppincod = (struct ppin_cod *)(++u32array);
+		struct pin_conf *pinconf = (struct pin_conf *)(++u32array);
+
+		dev_dbg(data->dev, "rpin(%x:%x:%x:%x:%x)\n",
+			pincod->bank, pincod->pin, pincod->bucket,
+			pincod->dir, pincod->cod);
+		dev_dbg(data->dev, "ppin(%x:%x:%x:%x)\n",
+			ppincod->pin, ppincod->bucket,
+			ppincod->dir, ppincod->cod);
+		dev_dbg(data->dev, "rpin-conf(%x:%x)\n",
+			pinconf->dir, pinconf->conf);
+
+		/* syntax check:
+		 * 1) if the function is not available for bucket or
+		 * 2) if the function is not availbale for direction
+		 */
+		if (((pincod->bucket & ppincod->bucket) == 0) ||
+		    (pincod->dir != ppincod->dir)) {
+			ret = -EINVAL;
+			goto out_clean_err;
+		}
+
+		grp->gpins[i].dir = pincod->dir;
+		grp->gpins[i].bucket = pincod->bucket;
+		grp->gpins[i].bank = pincod->bank;
+		grp->gpins[i].pin = pincod->pin;
+		grp->gpins[i].ppin = ppincod->pin;
+		if (grp->gpins[i].dir == DIR_OUT)
+			grp->gpins[i].cod = ppincod->cod;
+		else
+			grp->gpins[i].cod = pincod->cod;
+
+		grp->gpins[i].conf = (CONF_DIR(pinconf->dir) |
+				      CONF_COD(pinconf->conf));
+	}
+
+	return 0;
+out_clean_err:
+	kfree(u32array);
+out_err:
+	dev_err(data->dev, "wrong pins entry\n");
+	return ret;
+
+}
+
+/* parse group's properties */
+static int pic32_pinctrl_parse_group_prop(struct platform_device *pdev,
+					  struct device_node *np,
+					  struct pin_group *grp,
+					  struct pic32_pinctrl_data *data,
+					  int idx)
+{
+	switch (idx) {
+	case PIC32_PINCTRL_PROP_SINGLE_PINS:
+		return pic32_pinctrl_parse_single_pins(pdev, np, grp,
+						       data, idx);
+	break;
+	case PIC32_PINCTRL_PROP_PINS:
+		return pic32_pinctrl_parse_pins(pdev, np, grp,
+						data, idx);
+	break;
+	default:
+		return -EINVAL;
+	}
+
+	return -EINVAL;
+}
+
+/* parse groups within a function */
+static int pic32_pinctrl_parse_groups(struct platform_device *pdev,
+				      struct device_node *np,
+				      struct pin_group *grp,
+				      struct pic32_pinctrl_data *data,
+				      u32 gidx)
+{
+	struct property *prop;
+	int ret = 0;
+
+	dev_dbg(data->dev, "%s: group(%d): %s\n", __func__, gidx, np->name);
+
+	grp->name = np->name;
+
+	/* parse group's properties */
+	for_each_property_of_node(np, prop) {
+		int prop_idx;
+
+		if (!strcmp(prop->name, "name") ||
+		    !strcmp(prop->name, "phandle") ||
+		    !strcmp(prop->name, "linux,phandle"))
+			continue;
+
+		prop_idx = get_pic32_pinctrl_propidx(prop);
+		if (prop_idx == -EINVAL) {
+			dev_err(data->dev, "property (%s) not found!\n",
+								prop->name);
+			return -EINVAL;
+		}
+		dev_dbg(data->dev, "property found: %s\n",
+						pinctrl_props[prop_idx].name);
+
+		ret = pic32_pinctrl_parse_group_prop(pdev, np, grp,
+						     data, prop_idx);
+		if (ret) {
+			dev_err(data->dev, "wrong property (%s)!\n",
+								prop->name);
+			return ret;
+		}
+	}
+
+	return pic32_pinctrl_cout_pins(pdev, grp);
+}
+
+/* parse pinctrl's functions */
+static int pic32_pinctrl_parse_functions(struct platform_device *pdev,
+					 struct device_node *np,
+					 struct pic32_pinctrl_data *data,
+					 u32 fidx)
+{
+	struct device_node *child;
+	struct pin_function *func;
+	struct pin_group *grp;
+	static unsigned gidx; /* group index index related to pinctrl */
+	unsigned f_gidx = 0;  /* group index related to function */
+	int ret;
+
+	dev_dbg(data->dev, "%s: parse function(%d): %s\n", __func__,
+							fidx, np->name);
+
+	func = &data->functions[fidx];
+
+	/* initialise function */
+	func->name = np->name;
+	func->ngroups = of_get_child_count(np);
+	if (func->ngroups <= 0) {
+		dev_err(data->dev, "no groups defined\n");
+		return -EINVAL;
+	}
+	func->groups = devm_kzalloc(data->dev,
+			func->ngroups * sizeof(char *), GFP_KERNEL);
+	if (!func->groups)
+		return -ENOMEM;
+
+	/* parse groups within this function */
+	f_gidx = 0;
+	for_each_child_of_node(np, child) {
+		func->groups[f_gidx] = child->name;
+		grp = &data->groups[gidx++];
+		ret = pic32_pinctrl_parse_groups(pdev, child,
+						 grp, data, f_gidx++);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/* probe(parse) pinctrl's device tree node */
+static int pic32_pinctrl_probe_dt(struct platform_device *pdev,
+				  struct pic32_pinctrl_data *data)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *child;
+	const char *pio_compat = "microchip,pic32-gpio";
+	struct pinctrl_pin_desc *pdesc;
+	int f_idx = 0;
+	int i, kbank, kpio;
+	int ret = 0;
+
+	child = of_get_next_child(np, NULL);
+	if (!child) {
+		dev_err(&pdev->dev, "no group is defined\n");
+		return -ENOENT;
+	}
+
+	/* count total functions and groups */
+	for_each_child_of_node(np, child) {
+		if (of_device_is_compatible(child, pio_compat)) {
+			data->nbanks++;
+		} else {
+			data->nfunctions++;
+			data->ngroups += of_get_child_count(child);
+		}
+	}
+
+	if (data->nbanks < 1 || data->nbanks > MAX_PIO_BANKS) {
+		dev_err(&pdev->dev,
+			"gpio-controllers between 1 to %u.\n", MAX_PIO_BANKS);
+		return -EINVAL;
+	}
+	data->npins = data->nbanks * PINS_PER_BANK;
+
+	dev_dbg(&pdev->dev, "%s:(nbanks:%u, nfunctions:%u, ngroups:%u)\n",
+		__func__, data->nbanks, data->nfunctions, data->ngroups);
+
+	data->functions = devm_kzalloc(&pdev->dev, data->nfunctions *
+				   sizeof(*data->functions), GFP_KERNEL);
+	if (!data->functions)
+		return -ENOMEM;
+
+	data->groups = devm_kzalloc(&pdev->dev, data->ngroups *
+				   sizeof(*data->groups), GFP_KERNEL);
+	if (!data->groups)
+		return -ENOMEM;
+
+	/* parse all functions */
+	f_idx = 0;
+	for_each_child_of_node(np, child) {
+		if (of_device_is_compatible(child, pio_compat))
+			continue;
+
+		ret = pic32_pinctrl_parse_functions(pdev, child,
+						      data, f_idx++);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to parse function\n");
+			return ret;
+		}
+	}
+
+	pic32_pinctrl_desc.name = dev_name(&pdev->dev);
+	pic32_pinctrl_desc.npins = data->npins;
+	pic32_pinctrl_desc.pins = pdesc = devm_kzalloc(&pdev->dev,
+						sizeof(*pdesc) * data->npins,
+						GFP_KERNEL);
+	if (!pic32_pinctrl_desc.pins)
+		return -ENOMEM;
+
+	/* populate pinctrl pin descriptor */
+	kbank = 0;
+	for_each_child_of_node(np, child) {
+		if (of_device_is_compatible(child, pio_compat)) {
+			kpio = 0;
+			for (i = 0; i < PINS_PER_BANK; i++) {
+				pdesc->number = (kbank*PINS_PER_BANK) + kpio;
+				pdesc->name = kasprintf(GFP_KERNEL, "%s%c%d",
+						child->name,
+						kbank + 'A',
+						kpio);
+				pdesc->drv_data = NULL; /* unused */
+
+				pdesc++;
+				kpio++;
+			}
+			kbank++;
+		}
+	}
+
+	return 0;
+}
+
+/* probe pinctrl device */
+int pic32_pinctrl_probe(struct platform_device *pdev,
+			struct pic32_pps_off *pps_off,
+			struct pic32_caps *caps)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct pic32_pinctrl_data *data = NULL;
+	struct resource *r;
+	int i;
+	int ret = 0;
+
+	dev_dbg(&pdev->dev, "%s: probing...\n", __func__);
+
+	if (!np)
+		return -ENODEV;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	data->dev = &pdev->dev;
+	data->caps.pinconf_incaps = caps->pinconf_incaps;
+	data->caps.pinconf_outcaps = caps->pinconf_outcaps;
+
+	/* base address of pps(in, out) registers */
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r) {
+		ret = -EINVAL;
+		goto probe_err;
+	}
+	data->ppsin_base = devm_ioremap_nocache(&pdev->dev, r->start,
+							resource_size(r));
+	if (IS_ERR(data->ppsin_base)) {
+		ret = PTR_ERR(data->ppsin_base);
+		goto probe_err;
+	}
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!r) {
+		ret = -EINVAL;
+		goto probe_err;
+	}
+	data->ppsout_base = devm_ioremap_nocache(&pdev->dev, r->start,
+							resource_size(r));
+	if (IS_ERR(data->ppsout_base)) {
+		ret = PTR_ERR(data->ppsout_base);
+		goto probe_err;
+	}
+	data->pps_off = pps_off;
+
+	/* clocks */
+	data->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(data->clk)) {
+		ret = PTR_ERR(data->clk);
+		dev_err(&pdev->dev, "clk get failed\n");
+		goto probe_err;
+	}
+
+	ret = clk_prepare_enable(data->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "clk enable failed\n");
+		goto probe_err;
+	}
+
+	/* probe(parse) pinctrl device tree node */
+	ret = pic32_pinctrl_probe_dt(pdev, data);
+	if (ret) {
+		dev_err(&pdev->dev, "dt probe failed: %d\n", ret);
+		goto probe_err;
+	}
+
+	/* PIO driver must be probed first */
+	for (i = 0; i < data->nbanks; i++) {
+		if (!gpio_chips[i]) {
+			dev_warn(&pdev->dev,
+				"GPIO chip %d not registered\n", i);
+			ret = -EPROBE_DEFER;
+			goto probe_defer;
+		}
+	}
+
+	platform_set_drvdata(pdev, data);
+	data->pctl = pinctrl_register(&pic32_pinctrl_desc, &pdev->dev, data);
+	if (!data->pctl) {
+		dev_err(&pdev->dev, "Couldn't register pic32 pinctrl driver\n");
+		ret = -EINVAL;
+		goto probe_err;
+	}
+
+	/* Add gpio pin ranges - defined by GPIO nodes */
+	for (i = 0; i < data->nbanks; i++)
+		pinctrl_add_gpio_range(data->pctl, &gpio_chips[i]->range);
+
+	dev_info(&pdev->dev, "pic32 pinctrl driver initialized.\n");
+	return 0;
+
+probe_defer:
+probe_err:
+	if (data->ppsin_base)
+		devm_iounmap(&pdev->dev, data->ppsin_base);
+	if (data->ppsout_base)
+		devm_iounmap(&pdev->dev, data->ppsout_base);
+	if (data)
+		devm_kfree(&pdev->dev, data);
+	return ret;
+}
diff --git a/drivers/pinctrl/pinctrl-pic32.h b/drivers/pinctrl/pinctrl-pic32.h
new file mode 100644
index 0000000..4bc94f3
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-pic32.h
@@ -0,0 +1,158 @@
+/*
+ * pic32 pinctrl core definitions.
+ *
+ * Copyright (C) 2015 Microchip Technology, Inc.
+ * Author: Sorin-Andrei Pistirica <andrei.pistirica@microchip.com>
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#ifndef __DT_PIC32_PINCTRL_H__
+#define __DT_PIC32_PINCTRL_H__
+
+#include <linux/of_device.h>
+
+#ifdef CONFIG_PINCTRL_PIC32MZ
+#include "dt-bindings/pinctrl/pic32.h"
+#elif defined(CONFIG_PINCTRL_PIC32MZDA)
+#include "dt-bindings/pinctrl/pic32mzda.h"
+#endif
+
+#define MAX_PIO_BANKS	10
+#define PINS_PER_BANK	32
+
+/* device tree bindings */
+enum pic32_pinctrl_props {
+	PIC32_PINCTRL_PROP_SINGLE_PINS = 0,
+	PIC32_PINCTRL_PROP_PINS,
+
+	/* add above this line */
+	PIC32_PINCTRL_PROP_LAST
+};
+
+struct pic32_pinctrl_prop {
+	const char *name;
+	const unsigned int narg;
+};
+#define PIC32_PINCTRL_DT_PROP(_name, _narg) { .name = _name, .narg = _narg }
+
+#define PINMUX_MASK(off, size) (((1 << (size)) - 1) << (off))
+#define PINMUX_FIELD(entry, off, size) \
+		(((PINMUX_MASK(off, size)) & (entry)) >> (off))
+
+#define PIC32_OFF_UNSPEC (~0UL)
+#define PIC32_REG_SIZE 4
+
+/* struct rpin_cod - remapable pin code
+ * @bank: the pin's bank (PORT_A-to-PORT_J)
+ * @pin: the pin (0-to-31)
+ * @bucket: the bucket (BUCKET_A-to-BUCKET_D)
+ * @dir: the pin direction (DIR_IN or DIR_OUT)
+ * @cod: the code for input pinmux (COD(0x0)-to-COD(0xF))
+ **/
+struct rpin_cod {
+	u32 bank:5,
+	    pin:5,
+	    bucket:5,
+	    dir:1,
+	    cod:16;
+};
+
+/* struct ppin_cod - peripheral pin code
+ * @pin: peripherl pin code (e.g. PP_INT1, PP_T2CK...)
+ * @bucket: the bucket (BUCKET_A-to-BUCKET_D)
+ * @dir: the pin direction (DIR_IN or DIR_OUT)
+ * @cod: the code for output pinmux (COD(0x0)-to-COD(0xF))
+ **/
+struct ppin_cod {
+	u32 pin:10,
+	    bucket:5,
+	    dir:1,
+	    cod:16;
+};
+
+/* struct pin_conf - pin configuration code
+ * @dir: the pin direction (DIR_IN, DIR_OUT or DIR_NONE)
+ * @mode: the pinmux mode (PIC32_PIN_MODE_NONE, PIC32_PIN_MODE_SOURCING...)
+ **/
+struct pin_conf {
+	u32 dir:2,
+	    conf:30;
+};
+
+/* struct pic32_reg - pic register
+ * @val: register value
+ * @clr: clear register value
+ * @set: set register value
+ * @inv: invert bits of register value
+ **/
+struct pic32_reg {
+	u32 val;
+	u32 clr;
+	u32 set;
+	u32 inv;
+} __packed;
+#define PIC32_PIO_REGS 4
+
+/* enum pic32_pio_regs - pic32 regs for manipulate pin configuration; the
+ *                       mapping may vary between pic32 flavors (e.g. MZ).
+ **/
+enum pic32_pio_regs {
+	PIC32_UNKNOWN	= 0,
+
+	PIC32_ANSEL	= 1,
+	PIC32_TRIS	= 2,
+	PIC32_PORT	= 3,
+	PIC32_LAT	= 4,
+	PIC32_ODC	= 5,
+	PIC32_CNPU	= 6,
+	PIC32_CNPD	= 7,
+	PIC32_CNCON	= 8,
+	PIC32_CNEN	= 9,
+	PIC32_CNSTAT	= 10,
+
+	PIC32_CNNE	= 11,
+	PIC32_CNF	= 12,
+	PIC32_SRCON1	= 13,
+	PIC32_SRCON0	= 14,
+
+	/* add above this line */
+	PIC32_LAST
+};
+#define PIC32_CNCON_EDGE	11
+#define PIC32_CNCON_ON		15
+
+
+/* struct pic32_pps_off - pps registers mapping
+ * @ppsout_lookup_off: pps:out lookup registers offsets
+ * @ppsout_bank_start: pps:out mapping bank start
+ * @ppsout_bank_end: pps:out mapping bank end
+ * @ppsout_pin_start: pps:out mapping pin start
+ * @ppsout_pin_end: pps:out mapping pin end
+ * @ppsout_map_pins: pps:out mapping pins per bank
+ * @ppsin_lookup_off: pps:in lookup registers offsets
+ * @ppsin_lookup_size: pps:in lookup map size
+ **/
+struct pic32_pps_off {
+	unsigned (*ppsout_lookup_off)[MAX_PIO_BANKS][PINS_PER_BANK];
+	unsigned (*ppsin_lookup_off)[PP_MAX];
+};
+
+/* struct pic32_caps - pin configuration capabilities
+ * @pinconf_incaps: pin configuration input capabilities
+ * @pinconf_outcaps: pin configuration output capabilities
+ **/
+struct pic32_caps {
+	u32 pinconf_caps;
+	u32 pinconf_incaps;
+	u32 pinconf_outcaps;
+};
+
+int pic32_gpio_probe(struct platform_device *pdev,
+		     unsigned (*reg_lookup_off)[], unsigned lookup_size);
+
+int pic32_pinctrl_probe(struct platform_device *pdev,
+			struct pic32_pps_off *pps_off,
+			struct pic32_caps *caps);
+
+#endif /*__DT_PIC32_PINCTRL_H__*/
diff --git a/drivers/pinctrl/pinctrl-pic32mzda.c b/drivers/pinctrl/pinctrl-pic32mzda.c
new file mode 100644
index 0000000..137dce1
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-pic32mzda.c
@@ -0,0 +1,294 @@
+/*
+ * pic32mzda pinctrl driver.
+ *
+ * Copyright (C) 2015 Microchip Technology, Inc.
+ * Author: Sorin-Andrei Pistirica <andrei.pistirica@microchip.com>
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/of.h>
+
+#include "pinctrl-pic32.h"
+
+/* PIC32MZDA PORT I/O: register offsets */
+static unsigned pic32mzda_pio_lookup_off[PIC32_LAST] = {
+	[PIC32_ANSEL]	= 0  * PIC32_PIO_REGS * PIC32_REG_SIZE,
+	[PIC32_TRIS]	= 1  * PIC32_PIO_REGS * PIC32_REG_SIZE,
+	[PIC32_PORT]	= 2  * PIC32_PIO_REGS * PIC32_REG_SIZE,
+	[PIC32_LAT]	= 3  * PIC32_PIO_REGS * PIC32_REG_SIZE,
+	[PIC32_ODC]	= 4  * PIC32_PIO_REGS * PIC32_REG_SIZE,
+	[PIC32_CNPU]	= 5  * PIC32_PIO_REGS * PIC32_REG_SIZE,
+	[PIC32_CNPD]	= 6  * PIC32_PIO_REGS * PIC32_REG_SIZE,
+	[PIC32_CNCON]	= 7  * PIC32_PIO_REGS * PIC32_REG_SIZE,
+	[PIC32_CNEN]	= 8  * PIC32_PIO_REGS * PIC32_REG_SIZE,
+	[PIC32_CNSTAT]	= 9  * PIC32_PIO_REGS * PIC32_REG_SIZE,
+	[PIC32_CNNE]	= 10 * PIC32_PIO_REGS * PIC32_REG_SIZE,
+	[PIC32_CNF]	= 11 * PIC32_PIO_REGS * PIC32_REG_SIZE,
+	[PIC32_SRCON1]	= 12 * PIC32_PIO_REGS * PIC32_REG_SIZE,
+	[PIC32_SRCON0]	= 13 * PIC32_PIO_REGS * PIC32_REG_SIZE,
+};
+
+static void pic32mzda_build_pio_lookup_off(
+		unsigned (*pio_lookup_off)[PIC32_LAST])
+{
+	int i;
+
+	/* Guard unsupported registers by flag PIC32_OFF_UNSPEC. */
+	for (i = 0; i < PIC32_LAST; i++) {
+		if ((*pio_lookup_off)[i] == 0 && i != PIC32_ANSEL)
+			(*pio_lookup_off)[i] = PIC32_OFF_UNSPEC;
+	}
+}
+
+static int pic32mzda_gpio_probe(struct platform_device *pdev)
+{
+	pic32mzda_build_pio_lookup_off(&pic32mzda_pio_lookup_off);
+
+	return pic32_gpio_probe(pdev,
+				&pic32mzda_pio_lookup_off,
+				PIC32_LAST);
+}
+
+static const struct of_device_id pic32mzda_gpio_of_match[] = {
+	{ .compatible = "microchip,pic32-gpio" },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver pic32mzda_gpio_driver = {
+	.driver = {
+		.name = "gpio-pic32mzda",
+		.owner = THIS_MODULE,
+		.of_match_table = pic32mzda_gpio_of_match,
+	},
+	.probe = pic32mzda_gpio_probe,
+};
+
+/* Peripheral Pin Select (input): register offsets */
+static unsigned pic32mzda_ppsin_lookup_off[PP_MAX] = {
+	/*[PP_INT0]	= 0  * PIC32_REG_SIZE, Not remappable */
+	[PP_INT1]	= 1  * PIC32_REG_SIZE,
+	[PP_INT2]	= 2  * PIC32_REG_SIZE,
+	[PP_INT3]	= 3  * PIC32_REG_SIZE,
+	[PP_INT4]	= 4  * PIC32_REG_SIZE,
+	/*[PP_T1CK]	= 5  * PIC32_REG_SIZE, Not remappable */
+	[PP_T2CK]	= 6  * PIC32_REG_SIZE,
+	[PP_T3CK]	= 7  * PIC32_REG_SIZE,
+	[PP_T4CK]	= 8  * PIC32_REG_SIZE,
+	[PP_T5CK]	= 9  * PIC32_REG_SIZE,
+	[PP_T6CK]	= 10 * PIC32_REG_SIZE,
+	[PP_T7CK]	= 11 * PIC32_REG_SIZE,
+	[PP_T8CK]	= 12 * PIC32_REG_SIZE,
+	[PP_T9CK]	= 13 * PIC32_REG_SIZE,
+	[PP_IC1]	= 14 * PIC32_REG_SIZE,
+	[PP_IC2]	= 15 * PIC32_REG_SIZE,
+	[PP_IC3]	= 16 * PIC32_REG_SIZE,
+	[PP_IC4]	= 17 * PIC32_REG_SIZE,
+	[PP_IC5]	= 18 * PIC32_REG_SIZE,
+	[PP_IC6]	= 19 * PIC32_REG_SIZE,
+	[PP_IC7]	= 20 * PIC32_REG_SIZE,
+	[PP_IC8]	= 21 * PIC32_REG_SIZE,
+	[PP_IC9]	= 22 * PIC32_REG_SIZE,
+	/* rsv		= 23 */
+	[PP_OCFA]	= 24 * PIC32_REG_SIZE,
+	/*[PP_OCFB]	= 25 * PIC32_REG_SIZE, Not remappable */
+	[PP_U1RX]	= 26 * PIC32_REG_SIZE,
+	[PP_U1CTS]	= 27 * PIC32_REG_SIZE,
+	[PP_U2RX]	= 28 * PIC32_REG_SIZE,
+	[PP_U2CTS]	= 29 * PIC32_REG_SIZE,
+	[PP_U3RX]	= 30 * PIC32_REG_SIZE,
+	[PP_U3CTS]	= 31 * PIC32_REG_SIZE,
+	[PP_U4RX]	= 32 * PIC32_REG_SIZE,
+	[PP_U4CTS]	= 33 * PIC32_REG_SIZE,
+	[PP_U5RX]	= 34 * PIC32_REG_SIZE,
+	[PP_U5CTS]	= 35 * PIC32_REG_SIZE,
+	[PP_U6RX]	= 36 * PIC32_REG_SIZE,
+	[PP_U6CTS]	= 37 * PIC32_REG_SIZE,
+	/*[PP_SCK1IN]	= 38 * PIC32_REG_SIZE, Not remappable */
+	[PP_SDI1]	= 39 * PIC32_REG_SIZE,
+	[PP_SS1]	= 40 * PIC32_REG_SIZE,
+	/*[PP_SCK2IN]	= 41 * PIC32_REG_SIZE, Not remappable */
+	[PP_SDI2]	= 42 * PIC32_REG_SIZE,
+	[PP_SS2]	= 43 * PIC32_REG_SIZE,
+	/*[PP_SCK3IN]	= 44 * PIC32_REG_SIZE, Not remappable */
+	[PP_SDI3]	= 45 * PIC32_REG_SIZE,
+	[PP_SS3]	= 46 * PIC32_REG_SIZE,
+	/*[PP_SCK4IN]	= 47 * PIC32_REG_SIZE, Not remappable */
+	[PP_SDI4]	= 48 * PIC32_REG_SIZE,
+	[PP_SS4]	= 49 * PIC32_REG_SIZE,
+	/*[PP_SCK5IN]	= 50 * PIC32_REG_SIZE, Not remappable */
+	[PP_SDI5]	= 51 * PIC32_REG_SIZE,
+	[PP_SS5]	= 52 * PIC32_REG_SIZE,
+	/*[PP_SCK6IN]	= 53 * PIC32_REG_SIZE, Not remappable */
+	[PP_SDI6]	= 54 * PIC32_REG_SIZE,
+	[PP_SS6]	= 55 * PIC32_REG_SIZE,
+	[PP_C1RX]	= 56 * PIC32_REG_SIZE,
+	[PP_C2RX]	= 57 * PIC32_REG_SIZE,
+	[PP_REFCLKI1]	= 58 * PIC32_REG_SIZE,
+	/*[PP_REFCLKI2]	= 59 * PIC32_REG_SIZE, Not remappable */
+	[PP_REFCLKI3]	= 60 * PIC32_REG_SIZE,
+	[PP_REFCLKI4]	= 61 * PIC32_REG_SIZE
+};
+
+static void pic32mzda_build_ppsin_lookup_off(
+		unsigned (*ppsin_lookup_off)[PP_MAX])
+{
+	int i;
+
+	/* Guard unsupported configurations by flag PIC32_OFF_UNSPEC. */
+	for (i = 0; i < PP_MAX; i++) {
+		if ((*ppsin_lookup_off)[i] == 0)
+			(*ppsin_lookup_off)[i] = PIC32_OFF_UNSPEC;
+	}
+}
+
+/* Peripheral Pin Select (output): register offsets */
+static unsigned pic32mzda_ppsout_lookup_off[MAX_PIO_BANKS][PINS_PER_BANK] = {
+	[PORT_A][14] = (PORT_A * 16 + 14) * PIC32_REG_SIZE,
+	[PORT_A][15] = (PORT_A * 16 + 15) * PIC32_REG_SIZE,
+
+	[PORT_B][0]  = (PORT_B * 16 +  0) * PIC32_REG_SIZE,
+	[PORT_B][1]  = (PORT_B * 16 +  1) * PIC32_REG_SIZE,
+	[PORT_B][2]  = (PORT_B * 16 +  2) * PIC32_REG_SIZE,
+	[PORT_B][3]  = (PORT_B * 16 +  3) * PIC32_REG_SIZE,
+	[PORT_B][5]  = (PORT_B * 16 +  5) * PIC32_REG_SIZE,
+	[PORT_B][6]  = (PORT_B * 16 +  6) * PIC32_REG_SIZE,
+	[PORT_B][7]  = (PORT_B * 16 +  7) * PIC32_REG_SIZE,
+	[PORT_B][8]  = (PORT_B * 16 +  8) * PIC32_REG_SIZE,
+	[PORT_B][9]  = (PORT_B * 16 +  9) * PIC32_REG_SIZE,
+	[PORT_B][10] = (PORT_B * 16 + 10) * PIC32_REG_SIZE,
+	[PORT_B][15] = (PORT_B * 16 + 15) * PIC32_REG_SIZE,
+
+	[PORT_C][1]  = (PORT_C * 16 +  1) * PIC32_REG_SIZE,
+	[PORT_C][2]  = (PORT_C * 16 +  2) * PIC32_REG_SIZE,
+	[PORT_C][3]  = (PORT_C * 16 +  3) * PIC32_REG_SIZE,
+	[PORT_C][13] = (PORT_C * 16 +  13) * PIC32_REG_SIZE,
+	[PORT_C][14] = (PORT_C * 16 +  14) * PIC32_REG_SIZE,
+
+	[PORT_D][0]  = (PORT_D * 16 +  0) * PIC32_REG_SIZE,
+	[PORT_D][2]  = (PORT_D * 16 +  2) * PIC32_REG_SIZE,
+	[PORT_D][3]  = (PORT_D * 16 +  3) * PIC32_REG_SIZE,
+	[PORT_D][4]  = (PORT_D * 16 +  4) * PIC32_REG_SIZE,
+	[PORT_D][5]  = (PORT_D * 16 +  5) * PIC32_REG_SIZE,
+	[PORT_D][6]  = (PORT_D * 16 +  6) * PIC32_REG_SIZE,
+	[PORT_D][7]  = (PORT_D * 16 +  7) * PIC32_REG_SIZE,
+	[PORT_D][9]  = (PORT_D * 16 +  9) * PIC32_REG_SIZE,
+	[PORT_D][10] = (PORT_D * 16 + 10) * PIC32_REG_SIZE,
+	[PORT_D][11] = (PORT_D * 16 + 11) * PIC32_REG_SIZE,
+	[PORT_D][12] = (PORT_D * 16 + 12) * PIC32_REG_SIZE,
+	[PORT_D][14] = (PORT_D * 16 + 14) * PIC32_REG_SIZE,
+	[PORT_D][15] = (PORT_D * 16 + 15) * PIC32_REG_SIZE,
+
+	[PORT_E][3]  = (PORT_E * 16 +  3) * PIC32_REG_SIZE,
+	[PORT_E][5]  = (PORT_E * 16 +  5) * PIC32_REG_SIZE,
+	[PORT_E][8]  = (PORT_E * 16 +  8) * PIC32_REG_SIZE,
+	[PORT_E][9]  = (PORT_E * 16 +  9) * PIC32_REG_SIZE,
+
+	[PORT_F][0]  = (PORT_F * 16 +  0) * PIC32_REG_SIZE,
+	[PORT_F][1]  = (PORT_F * 16 +  1) * PIC32_REG_SIZE,
+	[PORT_F][2]  = (PORT_F * 16 +  2) * PIC32_REG_SIZE,
+	[PORT_F][3]  = (PORT_F * 16 +  3) * PIC32_REG_SIZE,
+	[PORT_F][4]  = (PORT_F * 16 +  4) * PIC32_REG_SIZE,
+	[PORT_F][5]  = (PORT_F * 16 +  5) * PIC32_REG_SIZE,
+	[PORT_F][8]  = (PORT_F * 16 +  8) * PIC32_REG_SIZE,
+	[PORT_F][12] = (PORT_F * 16 + 12) * PIC32_REG_SIZE,
+
+	[PORT_G][0]  = (PORT_G * 16 +  0) * PIC32_REG_SIZE,
+	[PORT_G][1]  = (PORT_G * 16 +  1) * PIC32_REG_SIZE,
+	[PORT_G][7]  = (PORT_G * 16 +  7) * PIC32_REG_SIZE,
+	[PORT_G][8]  = (PORT_G * 16 +  8) * PIC32_REG_SIZE,
+	[PORT_G][9]  = (PORT_G * 16 +  9) * PIC32_REG_SIZE,
+};
+
+static void pic32mzda_build_ppsout_lookup_off(
+		unsigned (*ppsout_lookup_off)[MAX_PIO_BANKS][PINS_PER_BANK])
+{
+	unsigned bank, pin;
+
+	/* Guard unsupported configurations by flag PIC32_OFF_UNSPEC. */
+	for (bank = 0; bank < MAX_PIO_BANKS; bank++) {
+		for (pin = 0; pin < PINS_PER_BANK; pin++)
+			if ((*ppsout_lookup_off)[bank][pin] == 0)
+				(*ppsout_lookup_off)[bank][pin] =
+							PIC32_OFF_UNSPEC;
+	}
+}
+
+static struct pic32_pps_off pic32mzda_pps_off = {
+	.ppsout_lookup_off = &pic32mzda_ppsout_lookup_off,
+	.ppsin_lookup_off = &pic32mzda_ppsin_lookup_off,
+};
+
+static struct pic32_caps pic32mzda_caps = {
+	.pinconf_caps = 0,
+	.pinconf_incaps = 0,
+	.pinconf_outcaps = 0
+};
+
+static void pic32mzda_build_caps(struct pic32_caps *caps)
+{
+	(caps->pinconf_caps)	= PIC32_PIN_CONF_NONE |
+				  PIC32_PIN_CONF_OD |
+				  PIC32_PIN_CONF_PU |
+				  PIC32_PIN_CONF_PD |
+				  PIC32_PIN_CONF_AN |
+				  PIC32_PIN_CONF_DG;
+	(caps->pinconf_outcaps) = PIC32_PIN_CONF_OD_OUT |
+				  PIC32_PIN_CONF_DG_OUT;
+	(caps->pinconf_incaps) = PIC32_PIN_CONF_PU_IN |
+				 PIC32_PIN_CONF_PD_IN |
+				 PIC32_PIN_CONF_AN_IN |
+				 PIC32_PIN_CONF_DG_IN;
+}
+
+static int pic32mzda_pinctrl_probe(struct platform_device *pdev)
+{
+	pic32mzda_build_caps(&pic32mzda_caps);
+
+	return pic32_pinctrl_probe(pdev,
+				   &pic32mzda_pps_off,
+				   &pic32mzda_caps);
+}
+
+static const struct of_device_id pic32mzda_pinctrl_of_match[] = {
+	{ .compatible = "microchip,pic32-pinctrl"},
+	{ /* sentinel */ }
+};
+
+static struct platform_driver pic32mzda_pinctrl_driver = {
+	.driver = {
+		.name = "pinctrl-pic32mzda",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(pic32mzda_pinctrl_of_match),
+	},
+	.probe = pic32mzda_pinctrl_probe,
+};
+
+static int __init pic32mzda_pinctrl_init(void)
+{
+	int ret = 0;
+
+	pic32mzda_build_ppsin_lookup_off(&pic32mzda_ppsin_lookup_off);
+	pic32mzda_build_ppsout_lookup_off(&pic32mzda_ppsout_lookup_off);
+
+	ret = platform_driver_register(&pic32mzda_gpio_driver);
+	if (ret)
+		return ret;
+
+	return platform_driver_register(&pic32mzda_pinctrl_driver);
+}
+arch_initcall(pic32mzda_pinctrl_init);
+
+static void __exit pic32mzda_pinctrl_exit(void)
+{
+	platform_driver_unregister(&pic32mzda_gpio_driver);
+	platform_driver_unregister(&pic32mzda_pinctrl_driver);
+}
+module_exit(pic32mzda_pinctrl_exit);
+
+MODULE_AUTHOR("Sorin-Andrei Pistirica <andrei.pistirica@microchip.com>");
+MODULE_DESCRIPTION("Microchop pic32mzda pinctrl driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/pinctrl/pinctrl-pic32mzda.h b/drivers/pinctrl/pinctrl-pic32mzda.h
new file mode 100644
index 0000000..1da0bc2
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-pic32mzda.h
@@ -0,0 +1,40 @@
+/*
+ * pic32mz pinctrl definitions.
+ *
+ * Copyright (C) 2015 Microchip Technology, Inc.
+ * Author: Sorin-Andrei Pistirica <andrei.pistirica@microchip.com>
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#ifndef __DT_PIC32MZ_PINCTRL_H__
+#define __DT_PIC32MZ_PINCTRL_H__
+
+#include "pinctrl-pic32.h"
+
+/* struct pic32mz_pio - portX config register map
+ * @ansel: operations of analog port pins
+ * @tris: data direction register
+ * @port: read from port pins
+ * @lat: write to the port pins
+ * @odc: digital or open-drain register
+ * @cnpu: weak pull-up register
+ * @cnpd: weak pull-down register
+ * @cncon: change notification (CN) control register
+ * @cnen: CN interrupt enable control bits
+ * @cnstat: change occurred on corresponding pins
+ **/
+struct pic32mz_pio {
+	struct pic32_reg ansel;
+	struct pic32_reg tris;
+	struct pic32_reg port;
+	struct pic32_reg lat;
+	struct pic32_reg odc;
+	struct pic32_reg cnpu;
+	struct pic32_reg cnpd;
+	struct pic32_reg cncon;
+	struct pic32_reg cnen;
+	struct pic32_reg cnstat;
+} __packed;
+
+#endif /*__DT_PIC32MZ_PINCTRL_H__*/
-- 
1.7.9.5
