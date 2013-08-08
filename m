Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Aug 2013 16:27:01 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:32889 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817904Ab3HHO0zP7Vcr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Aug 2013 16:26:55 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Grant Likely <grant.likely@linaro.org>
Cc:     Rob Herring <rob.herring@calxeda.com>,
        Thomas Langer <thomas.langer@lantiq.com>,
        linux-mips@linux-mips.org, linux-gpio@vger.kernel.org
Subject: [PATCH 2/2] GPIO: MIPS: lantiq: add gpio driver for falcon SoC
Date:   Thu,  8 Aug 2013 16:19:15 +0200
Message-Id: <1375971555-24128-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1375971555-24128-1-git-send-email-blogic@openwrt.org>
References: <1375971555-24128-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37477
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

From: Thomas Langer <thomas.langer@lantiq.com>

Add driver for GPIO blocks found on Lantiq FALCON SoC. The SoC has 5 banks of
up to 32 pads. The GPIO blocks have a per pin IRQs.

Signed-off-by: Thomas Langer <thomas.langer@lantiq.com>
Acked-by: John Crispin <blogic@openwrt.org>
Cc: linux-mips@linux-mips.org
Cc: linux-gpio@vger.kernel.org
---
 drivers/gpio/Kconfig       |    5 +
 drivers/gpio/Makefile      |    1 +
 drivers/gpio/gpio-falcon.c |  348 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 354 insertions(+)
 create mode 100644 drivers/gpio/gpio-falcon.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index b26c996..dcfe680 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -138,6 +138,11 @@ config GPIO_EP93XX
 	depends on ARCH_EP93XX
 	select GPIO_GENERIC
 
+config GPIO_FALCON
+	def_bool y
+	depends on MIPS && SOC_FALCON
+	select GPIO_GENERIC
+
 config GPIO_MM_LANTIQ
 	bool "Lantiq Memory mapped GPIOs"
 	depends on LANTIQ && SOC_XWAY
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 95d8aee..8169245 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_GPIO_DA9055)	+= gpio-da9055.o
 obj-$(CONFIG_ARCH_DAVINCI)	+= gpio-davinci.o
 obj-$(CONFIG_GPIO_EM)		+= gpio-em.o
 obj-$(CONFIG_GPIO_EP93XX)	+= gpio-ep93xx.o
+obj-$(CONFIG_GPIO_FALCON)	+= gpio-falcon.o
 obj-$(CONFIG_GPIO_GE_FPGA)	+= gpio-ge.o
 obj-$(CONFIG_GPIO_GRGPIO)	+= gpio-grgpio.o
 obj-$(CONFIG_GPIO_ICH)		+= gpio-ich.o
diff --git a/drivers/gpio/gpio-falcon.c b/drivers/gpio/gpio-falcon.c
new file mode 100644
index 0000000..ae3bdfb
--- /dev/null
+++ b/drivers/gpio/gpio-falcon.c
@@ -0,0 +1,348 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2012 Thomas Langer <thomas.langer@lantiq.com>
+ *  Copyright (C) 2012 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/slab.h>
+#include <linux/export.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/platform_device.h>
+
+#include <lantiq_soc.h>
+
+/* Data Output Register */
+#define GPIO_OUT            0x00000000
+/* Data Input Register */
+#define GPIO_IN             0x00000004
+/* Direction Register */
+#define GPIO_DIR            0x00000008
+/* External Interrupt Control Register 0 */
+#define GPIO_EXINTCR0       0x00000018
+/* External Interrupt Control Register 1 */
+#define GPIO_EXINTCR1       0x0000001C
+/* IRN Capture Register */
+#define GPIO_IRNCR          0x00000020
+/* IRN Interrupt Configuration Register */
+#define GPIO_IRNCFG		0x0000002C
+/* IRN Interrupt Enable Set Register */
+#define GPIO_IRNRNSET       0x00000030
+/* IRN Interrupt Enable Clear Register */
+#define GPIO_IRNENCLR       0x00000034
+/* Output Set Register */
+#define GPIO_OUTSET         0x00000040
+/* Output Cler Register */
+#define GPIO_OUTCLR         0x00000044
+/* Direction Clear Register */
+#define GPIO_DIRSET         0x00000048
+/* Direction Set Register */
+#define GPIO_DIRCLR         0x0000004C
+
+/* turn a gpio_chip into a falcon_gpio_port */
+#define ctop(c)		container_of(c, struct falcon_gpio_port, gpio_chip)
+/* turn a irq_data into a falcon_gpio_port */
+#define itop(i)		((struct falcon_gpio_port *) irq_get_chip_data(i->irq))
+
+#define port_r32(p, reg)	ltq_r32(p->port + reg)
+#define port_w32(p, val, reg)	ltq_w32(val, p->port + reg)
+#define port_w32_mask(p, clear, set, reg) \
+		port_w32(p, (port_r32(p, reg) & ~(clear)) | (set), reg)
+
+#define MAX_BANKS		5
+#define PINS_PER_PORT		32
+
+struct falcon_gpio_port {
+	struct gpio_chip gpio_chip;
+	void __iomem *port;
+	unsigned int irq_base;
+	unsigned int chained_irq;
+	struct clk *clk;
+	char name[6];
+};
+
+static struct irq_chip falcon_gpio_irq_chip;
+
+static int falcon_gpio_direction_input(struct gpio_chip *chip,
+					unsigned int offset)
+{
+	port_w32(ctop(chip), 1 << offset, GPIO_DIRCLR);
+
+	return 0;
+}
+
+static void falcon_gpio_set(struct gpio_chip *chip, unsigned int offset,
+					int value)
+{
+	if (value)
+		port_w32(ctop(chip), 1 << offset, GPIO_OUTSET);
+	else
+		port_w32(ctop(chip), 1 << offset, GPIO_OUTCLR);
+}
+
+static int falcon_gpio_direction_output(struct gpio_chip *chip,
+					unsigned int offset, int value)
+{
+	falcon_gpio_set(chip, offset, value);
+	port_w32(ctop(chip), 1 << offset, GPIO_DIRSET);
+
+	return 0;
+}
+
+static int falcon_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	if ((port_r32(ctop(chip), GPIO_DIR) >> offset) & 1)
+		return (port_r32(ctop(chip), GPIO_OUT) >> offset) & 1;
+	else
+		return (port_r32(ctop(chip), GPIO_IN) >> offset) & 1;
+}
+
+static int falcon_gpio_request(struct gpio_chip *chip, unsigned offset)
+{
+	int gpio = chip->base + offset;
+
+	return pinctrl_request_gpio(gpio);
+}
+
+static void falcon_gpio_free(struct gpio_chip *chip, unsigned offset)
+{
+	int gpio = chip->base + offset;
+
+	pinctrl_free_gpio(gpio);
+}
+
+static int falcon_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
+{
+	return ctop(chip)->irq_base + offset;
+}
+
+static void falcon_gpio_disable_irq(struct irq_data *d)
+{
+	unsigned int offset = d->irq - itop(d)->irq_base;
+
+	port_w32(itop(d), 1 << offset, GPIO_IRNENCLR);
+}
+
+static void falcon_gpio_enable_irq(struct irq_data *d)
+{
+	unsigned int offset = d->irq - itop(d)->irq_base;
+
+	port_w32(itop(d), 1 << offset, GPIO_IRNRNSET);
+}
+
+static void falcon_gpio_ack_irq(struct irq_data *d)
+{
+	unsigned int offset = d->irq - itop(d)->irq_base;
+
+	port_w32(itop(d), 1 << offset, GPIO_IRNCR);
+}
+
+static void falcon_gpio_mask_and_ack_irq(struct irq_data *d)
+{
+	unsigned int offset = d->irq - itop(d)->irq_base;
+
+	port_w32(itop(d), 1 << offset, GPIO_IRNENCLR);
+	port_w32(itop(d), 1 << offset, GPIO_IRNCR);
+}
+
+static int falcon_gpio_irq_type(struct irq_data *d, unsigned int type)
+{
+	unsigned int offset = d->irq - itop(d)->irq_base;
+	unsigned int mask = 1 << offset;
+
+	if ((type & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_NONE)
+		return 0;
+
+	if ((type & (IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW)) != 0) {
+		/* level triggered */
+		port_w32_mask(itop(d), 0, mask, GPIO_IRNCFG);
+		irq_set_chip_and_handler_name(d->irq,
+			&falcon_gpio_irq_chip, handle_level_irq, "mux");
+	} else {
+		/* edge triggered */
+		port_w32_mask(itop(d), mask, 0, GPIO_IRNCFG);
+		irq_set_chip_and_handler_name(d->irq,
+			&falcon_gpio_irq_chip, handle_simple_irq, "mux");
+	}
+
+	if ((type & IRQ_TYPE_EDGE_BOTH) == IRQ_TYPE_EDGE_BOTH) {
+		port_w32_mask(itop(d), mask, 0, GPIO_EXINTCR0);
+		port_w32_mask(itop(d), 0, mask, GPIO_EXINTCR1);
+	} else {
+		if ((type & (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_LEVEL_HIGH)) != 0)
+			/* positive logic: rising edge, high level */
+			port_w32_mask(itop(d), mask, 0, GPIO_EXINTCR0);
+		else
+			/* negative logic: falling edge, low level */
+			port_w32_mask(itop(d), 0, mask, GPIO_EXINTCR0);
+		port_w32_mask(itop(d), mask, 0, GPIO_EXINTCR1);
+	}
+
+	return gpio_direction_input(itop(d)->gpio_chip.base + offset);
+}
+
+static void falcon_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
+{
+	struct falcon_gpio_port *gpio_port = irq_desc_get_handler_data(desc);
+	unsigned long irncr;
+	int offset;
+
+	/* acknowledge interrupt */
+	irncr = port_r32(gpio_port, GPIO_IRNCR);
+	port_w32(gpio_port, irncr, GPIO_IRNCR);
+
+	desc->irq_data.chip->irq_ack(&desc->irq_data);
+
+	for_each_set_bit(offset, &irncr, gpio_port->gpio_chip.ngpio)
+		generic_handle_irq(gpio_port->irq_base + offset);
+}
+
+static int falcon_gpio_irq_map(struct irq_domain *d, unsigned int irq,
+				irq_hw_number_t hw)
+{
+	struct falcon_gpio_port *port = d->host_data;
+
+	irq_set_chip_and_handler_name(irq, &falcon_gpio_irq_chip,
+			handle_simple_irq, "mux");
+	irq_set_chip_data(irq, port);
+
+	/* set to negative logic (falling edge, low level) */
+	port_w32_mask(port, 0, 1 << hw, GPIO_EXINTCR0);
+	return 0;
+}
+
+static struct irq_chip falcon_gpio_irq_chip = {
+	.name = "gpio_irq_mux",
+	.irq_mask = falcon_gpio_disable_irq,
+	.irq_unmask = falcon_gpio_enable_irq,
+	.irq_ack = falcon_gpio_ack_irq,
+	.irq_mask_ack = falcon_gpio_mask_and_ack_irq,
+	.irq_set_type = falcon_gpio_irq_type,
+};
+
+static const struct irq_domain_ops irq_domain_ops = {
+	.xlate = irq_domain_xlate_onetwocell,
+	.map = falcon_gpio_irq_map,
+};
+
+static struct irqaction gpio_cascade = {
+	.handler = no_action,
+	.flags = IRQF_DISABLED,
+	.name = "gpio_cascade",
+};
+
+static int falcon_gpio_probe(struct platform_device *pdev)
+{
+	struct pinctrl_gpio_range *gpio_range;
+	struct device_node *node = pdev->dev.of_node;
+	const __be32 *bank = of_get_property(node, "lantiq,bank", NULL);
+	struct falcon_gpio_port *gpio_port;
+	struct resource *gpiores, irqres;
+	int ret, size;
+
+	if (!bank || *bank >= MAX_BANKS)
+		return -ENODEV;
+
+	size = pinctrl_falcon_get_range_size(*bank);
+	if (size < 1) {
+		dev_err(&pdev->dev, "pad not loaded for bank %d\n", *bank);
+		return size;
+	}
+
+	gpio_range = devm_kzalloc(&pdev->dev, sizeof(struct pinctrl_gpio_range),
+				GFP_KERNEL);
+	if (!gpio_range)
+		return -ENOMEM;
+
+	gpio_port = devm_kzalloc(&pdev->dev, sizeof(struct falcon_gpio_port),
+				GFP_KERNEL);
+	if (!gpio_port)
+		return -ENOMEM;
+
+	snprintf(gpio_port->name, 6, "gpio%d", *bank);
+	gpio_port->gpio_chip.label = gpio_port->name;
+	gpio_port->gpio_chip.direction_input = falcon_gpio_direction_input;
+	gpio_port->gpio_chip.direction_output = falcon_gpio_direction_output;
+	gpio_port->gpio_chip.get = falcon_gpio_get;
+	gpio_port->gpio_chip.set = falcon_gpio_set;
+	gpio_port->gpio_chip.request = falcon_gpio_request;
+	gpio_port->gpio_chip.free = falcon_gpio_free;
+	gpio_port->gpio_chip.base = *bank * PINS_PER_PORT;
+	gpio_port->gpio_chip.ngpio = size;
+	gpio_port->gpio_chip.dev = &pdev->dev;
+
+	gpiores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	gpio_port->port = devm_request_and_ioremap(&pdev->dev, gpiores);
+	if (IS_ERR(gpio_port->port))
+		return PTR_ERR(gpio_port->port);
+
+	gpio_port->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(gpio_port->clk))
+		return PTR_ERR(gpio_port->clk);
+	clk_activate(gpio_port->clk);
+
+	if (of_irq_to_resource_table(node, &irqres, 1) == 1) {
+		gpio_port->irq_base = INT_NUM_EXTRA_START + (32 * *bank);
+		gpio_port->gpio_chip.to_irq = falcon_gpio_to_irq;
+		gpio_port->chained_irq = irqres.start;
+		irq_domain_add_legacy(node, size, gpio_port->irq_base, 0,
+					&irq_domain_ops, gpio_port);
+		setup_irq(irqres.start, &gpio_cascade);
+		irq_set_handler_data(irqres.start, gpio_port);
+		irq_set_chained_handler(irqres.start, falcon_gpio_irq_handler);
+	}
+
+	ret = gpiochip_add(&gpio_port->gpio_chip);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, gpio_port);
+
+	gpio_range->name = "FALCON GPIO";
+	gpio_range->id = *bank;
+	gpio_range->base = gpio_port->gpio_chip.base;
+	gpio_range->pin_base = gpio_port->gpio_chip.base;
+	gpio_range->npins = gpio_port->gpio_chip.ngpio;
+	gpio_range->gc = &gpio_port->gpio_chip;
+
+	pinctrl_falcon_add_gpio_range(gpio_range);
+
+	return 0;
+}
+
+static const struct of_device_id falcon_gpio_match[] = {
+	{ .compatible = "lantiq,falcon-gpio" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, falcon_gpio_match);
+
+static struct platform_driver falcon_gpio_driver = {
+	.probe = falcon_gpio_probe,
+	.driver = {
+		.name = "gpio-falcon",
+		.owner = THIS_MODULE,
+		.of_match_table = falcon_gpio_match,
+	},
+};
+
+int __init falcon_gpio_init(void)
+{
+	int ret;
+
+	pr_info("FALC(tm) ON GPIO Driver, (C) 2012 Lantiq Deutschland Gmbh\n");
+	ret = platform_driver_register(&falcon_gpio_driver);
+	if (ret)
+		pr_err("falcon_gpio: Error registering platform driver!");
+	return ret;
+}
+
+subsys_initcall(falcon_gpio_init);
-- 
1.7.10.4
