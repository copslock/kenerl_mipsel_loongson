Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2014 22:26:08 +0200 (CEST)
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:60282
        "EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S27011004AbaJIUZullnNW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Oct 2014 22:25:50 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mips@linux-mips.org, linux-gpio@vger.kernel.org
Subject: [PATCH 2/2] GPIO: MIPS: ralink: add gpio driver for ralink SoC
Date:   Thu,  9 Oct 2014 22:07:21 +0200
Message-Id: <1412885241-12476-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1412885241-12476-1-git-send-email-blogic@openwrt.org>
References: <1412885241-12476-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43165
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

Add gpio driver for Ralink SoC. This driver makes the gpio core on
RT2880, RT305x, rt3352, rt3662, rt3883, rt5350 and mt7620 work.

Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: linux-mips@linux-mips.org
Cc: linux-gpio@vger.kernel.org
---
 arch/mips/include/asm/mach-ralink/gpio.h |   24 ++
 drivers/gpio/Kconfig                     |    6 +
 drivers/gpio/Makefile                    |    1 +
 drivers/gpio/gpio-rt2880.c               |  354 ++++++++++++++++++++++++++++++
 4 files changed, 385 insertions(+)
 create mode 100644 arch/mips/include/asm/mach-ralink/gpio.h
 create mode 100644 drivers/gpio/gpio-rt2880.c

diff --git a/arch/mips/include/asm/mach-ralink/gpio.h b/arch/mips/include/asm/mach-ralink/gpio.h
new file mode 100644
index 0000000..f68ee16
--- /dev/null
+++ b/arch/mips/include/asm/mach-ralink/gpio.h
@@ -0,0 +1,24 @@
+/*
+ *  Ralink SoC GPIO API support
+ *
+ *  Copyright (C) 2008-2009 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ */
+
+#ifndef __ASM_MACH_RALINK_GPIO_H
+#define __ASM_MACH_RALINK_GPIO_H
+
+#define ARCH_NR_GPIOS	128
+#include <asm-generic/gpio.h>
+
+#define gpio_get_value	__gpio_get_value
+#define gpio_set_value	__gpio_set_value
+#define gpio_cansleep	__gpio_cansleep
+#define gpio_to_irq	__gpio_to_irq
+
+#endif /* __ASM_MACH_RALINK_GPIO_H */
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 9de1515..c91b15b 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -289,6 +289,12 @@ config GPIO_SCH311X
 	  To compile this driver as a module, choose M here: the module will
 	  be called gpio-sch311x.
 
+config GPIO_RALINK
+	bool "Ralink GPIO Support"
+	depends on RALINK
+	help
+	  Say yes here to support the Ralink SoC GPIO device
+
 config GPIO_SPEAR_SPICS
 	bool "ST SPEAr13xx SPI Chip Select as GPIO support"
 	depends on PLAT_SPEAR
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 5d024e3..d8f0f17 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_GPIO_PCF857X)	+= gpio-pcf857x.o
 obj-$(CONFIG_GPIO_PCH)		+= gpio-pch.o
 obj-$(CONFIG_GPIO_PL061)	+= gpio-pl061.o
 obj-$(CONFIG_GPIO_PXA)		+= gpio-pxa.o
+obj-$(CONFIG_GPIO_RALINK)	+= gpio-rt2880.o
 obj-$(CONFIG_GPIO_RC5T583)	+= gpio-rc5t583.o
 obj-$(CONFIG_GPIO_RDC321X)	+= gpio-rdc321x.o
 obj-$(CONFIG_GPIO_RCAR)		+= gpio-rcar.o
diff --git a/drivers/gpio/gpio-rt2880.c b/drivers/gpio/gpio-rt2880.c
new file mode 100644
index 0000000..745beb0
--- /dev/null
+++ b/drivers/gpio/gpio-rt2880.c
@@ -0,0 +1,354 @@
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ * Copyright (C) 2009-2011 Gabor Juhos <juhosg@openwrt.org>
+ * Copyright (C) 2013 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/gpio.h>
+#include <linux/spinlock.h>
+#include <linux/platform_device.h>
+#include <linux/of_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/interrupt.h>
+
+enum ralink_gpio_reg {
+	GPIO_REG_INT = 0,
+	GPIO_REG_EDGE,
+	GPIO_REG_RENA,
+	GPIO_REG_FENA,
+	GPIO_REG_DATA,
+	GPIO_REG_DIR,
+	GPIO_REG_POL,
+	GPIO_REG_SET,
+	GPIO_REG_RESET,
+	GPIO_REG_TOGGLE,
+	GPIO_REG_MAX
+};
+
+struct ralink_gpio_chip {
+	struct gpio_chip chip;
+	u8 regs[GPIO_REG_MAX];
+
+	spinlock_t lock;
+	void __iomem *membase;
+	struct irq_domain *domain;
+	int irq;
+
+	u32 rising;
+	u32 falling;
+};
+
+#define MAP_MAX	4
+static struct irq_domain *irq_map[MAP_MAX];
+static int irq_map_count;
+static atomic_t irq_refcount = ATOMIC_INIT(0);
+
+static inline struct ralink_gpio_chip *to_ralink_gpio(struct gpio_chip *chip)
+{
+	struct ralink_gpio_chip *rg;
+
+	rg = container_of(chip, struct ralink_gpio_chip, chip);
+
+	return rg;
+}
+
+static inline void rt_gpio_w32(struct ralink_gpio_chip *rg, u8 reg, u32 val)
+{
+	iowrite32(val, rg->membase + rg->regs[reg]);
+}
+
+static inline u32 rt_gpio_r32(struct ralink_gpio_chip *rg, u8 reg)
+{
+	return ioread32(rg->membase + rg->regs[reg]);
+}
+
+static void ralink_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
+{
+	struct ralink_gpio_chip *rg = to_ralink_gpio(chip);
+
+	rt_gpio_w32(rg, (value) ? GPIO_REG_SET : GPIO_REG_RESET, BIT(offset));
+}
+
+static int ralink_gpio_get(struct gpio_chip *chip, unsigned offset)
+{
+	struct ralink_gpio_chip *rg = to_ralink_gpio(chip);
+
+	return !!(rt_gpio_r32(rg, GPIO_REG_DATA) & BIT(offset));
+}
+
+static int ralink_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
+{
+	struct ralink_gpio_chip *rg = to_ralink_gpio(chip);
+	unsigned long flags;
+	u32 t;
+
+	spin_lock_irqsave(&rg->lock, flags);
+	t = rt_gpio_r32(rg, GPIO_REG_DIR);
+	t &= ~BIT(offset);
+	rt_gpio_w32(rg, GPIO_REG_DIR, t);
+	spin_unlock_irqrestore(&rg->lock, flags);
+
+	return 0;
+}
+
+static int ralink_gpio_direction_output(struct gpio_chip *chip,
+					unsigned offset, int value)
+{
+	struct ralink_gpio_chip *rg = to_ralink_gpio(chip);
+	unsigned long flags;
+	u32 t;
+
+	spin_lock_irqsave(&rg->lock, flags);
+	ralink_gpio_set(chip, offset, value);
+	t = rt_gpio_r32(rg, GPIO_REG_DIR);
+	t |= BIT(offset);
+	rt_gpio_w32(rg, GPIO_REG_DIR, t);
+	spin_unlock_irqrestore(&rg->lock, flags);
+
+	return 0;
+}
+
+static int ralink_gpio_to_irq(struct gpio_chip *chip, unsigned pin)
+{
+	struct ralink_gpio_chip *rg = to_ralink_gpio(chip);
+
+	if (rg->irq < 1)
+		return -1;
+
+	return irq_create_mapping(rg->domain, pin);
+}
+
+static void ralink_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
+{
+	int i;
+
+	for (i = 0; i < irq_map_count; i++) {
+		struct irq_domain *domain = irq_map[i];
+		struct ralink_gpio_chip *rg;
+		unsigned long pending;
+		int bit;
+
+		rg = (struct ralink_gpio_chip *) domain->host_data;
+		pending = rt_gpio_r32(rg, GPIO_REG_INT);
+
+		for_each_set_bit(bit, &pending, rg->chip.ngpio) {
+			u32 map = irq_find_mapping(domain, bit);
+
+			generic_handle_irq(map);
+			rt_gpio_w32(rg, GPIO_REG_INT, BIT(bit));
+		}
+	}
+}
+
+static void ralink_gpio_irq_unmask(struct irq_data *d)
+{
+	struct ralink_gpio_chip *rg;
+	unsigned long flags;
+	u32 val;
+
+	rg = (struct ralink_gpio_chip *) d->domain->host_data;
+	val = rt_gpio_r32(rg, GPIO_REG_RENA);
+
+	spin_lock_irqsave(&rg->lock, flags);
+	rt_gpio_w32(rg, GPIO_REG_RENA, val | (BIT(d->hwirq) & rg->rising));
+	rt_gpio_w32(rg, GPIO_REG_FENA, val | (BIT(d->hwirq) & rg->falling));
+	spin_unlock_irqrestore(&rg->lock, flags);
+}
+
+static void ralink_gpio_irq_mask(struct irq_data *d)
+{
+	struct ralink_gpio_chip *rg;
+	unsigned long flags;
+	u32 val;
+
+	rg = (struct ralink_gpio_chip *) d->domain->host_data;
+	val = rt_gpio_r32(rg, GPIO_REG_RENA);
+
+	spin_lock_irqsave(&rg->lock, flags);
+	rt_gpio_w32(rg, GPIO_REG_FENA, val & ~BIT(d->hwirq));
+	rt_gpio_w32(rg, GPIO_REG_RENA, val & ~BIT(d->hwirq));
+	spin_unlock_irqrestore(&rg->lock, flags);
+}
+
+static int ralink_gpio_irq_type(struct irq_data *d, unsigned int type)
+{
+	struct ralink_gpio_chip *rg;
+	u32 mask = BIT(d->hwirq);
+
+	rg = (struct ralink_gpio_chip *) d->domain->host_data;
+
+	if (type == IRQ_TYPE_PROBE) {
+		if ((rg->rising | rg->falling) & mask)
+			return 0;
+
+		type = IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING;
+	}
+
+	if (type & IRQ_TYPE_EDGE_RISING)
+		rg->rising |= mask;
+	else
+		rg->rising &= ~mask;
+
+	if (type & IRQ_TYPE_EDGE_FALLING)
+		rg->falling |= mask;
+	else
+		rg->falling &= ~mask;
+
+	return 0;
+}
+
+static struct irq_chip ralink_gpio_irq_chip = {
+	.name		= "GPIO",
+	.irq_unmask	= ralink_gpio_irq_unmask,
+	.irq_mask	= ralink_gpio_irq_mask,
+	.irq_mask_ack	= ralink_gpio_irq_mask,
+	.irq_set_type	= ralink_gpio_irq_type,
+};
+
+static int gpio_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
+{
+	irq_set_chip_and_handler(irq, &ralink_gpio_irq_chip, handle_level_irq);
+	irq_set_handler_data(irq, d);
+
+	return 0;
+}
+
+static const struct irq_domain_ops irq_domain_ops = {
+	.xlate = irq_domain_xlate_onecell,
+	.map = gpio_map,
+};
+
+static void ralink_gpio_irq_init(struct device_node *np,
+				 struct ralink_gpio_chip *rg)
+{
+	if (irq_map_count >= MAP_MAX)
+		return;
+
+	rg->irq = irq_of_parse_and_map(np, 0);
+	if (!rg->irq)
+		return;
+
+	rg->domain = irq_domain_add_linear(np, rg->chip.ngpio,
+					   &irq_domain_ops, rg);
+	if (!rg->domain) {
+		dev_err(rg->chip.dev, "irq_domain_add_linear failed\n");
+		return;
+	}
+
+	irq_map[irq_map_count++] = rg->domain;
+
+	rt_gpio_w32(rg, GPIO_REG_RENA, 0x0);
+	rt_gpio_w32(rg, GPIO_REG_FENA, 0x0);
+
+	if (!atomic_read(&irq_refcount))
+		irq_set_chained_handler(rg->irq, ralink_gpio_irq_handler);
+	atomic_inc(&irq_refcount);
+
+	dev_info(rg->chip.dev, "registering %d irq handlers\n", rg->chip.ngpio);
+}
+
+static int ralink_gpio_request(struct gpio_chip *chip, unsigned offset)
+{
+	int gpio = chip->base + offset;
+
+	return pinctrl_request_gpio(gpio);
+}
+
+static void ralink_gpio_free(struct gpio_chip *chip, unsigned offset)
+{
+	int gpio = chip->base + offset;
+
+	pinctrl_free_gpio(gpio);
+}
+
+static int ralink_gpio_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	struct ralink_gpio_chip *rg;
+	const __be32 *ngpio, *gpiobase;
+
+	if (!res) {
+		dev_err(&pdev->dev, "failed to find resource\n");
+		return -ENOMEM;
+	}
+
+	rg = devm_kzalloc(&pdev->dev,
+			sizeof(struct ralink_gpio_chip), GFP_KERNEL);
+	if (!rg)
+		return -ENOMEM;
+
+	rg->membase = devm_request_and_ioremap(&pdev->dev, res);
+	if (!rg->membase) {
+		dev_err(&pdev->dev, "cannot remap I/O memory region\n");
+		return -ENOMEM;
+	}
+
+	if (of_property_read_u8_array(np, "ralink,register-map",
+			rg->regs, GPIO_REG_MAX)) {
+		dev_err(&pdev->dev, "failed to read register definition\n");
+		return -EINVAL;
+	}
+
+	ngpio = of_get_property(np, "ralink,num-gpios", NULL);
+	if (!ngpio) {
+		dev_err(&pdev->dev, "failed to read number of pins\n");
+		return -EINVAL;
+	}
+
+	gpiobase = of_get_property(np, "ralink,gpio-base", NULL);
+	if (gpiobase)
+		rg->chip.base = be32_to_cpu(*gpiobase);
+	else
+		rg->chip.base = -1;
+
+	spin_lock_init(&rg->lock);
+
+	rg->chip.dev = &pdev->dev;
+	rg->chip.label = dev_name(&pdev->dev);
+	rg->chip.of_node = np;
+	rg->chip.ngpio = be32_to_cpu(*ngpio);
+	rg->chip.direction_input = ralink_gpio_direction_input;
+	rg->chip.direction_output = ralink_gpio_direction_output;
+	rg->chip.get = ralink_gpio_get;
+	rg->chip.set = ralink_gpio_set;
+	rg->chip.request = ralink_gpio_request;
+	rg->chip.to_irq = ralink_gpio_to_irq;
+	rg->chip.free = ralink_gpio_free;
+
+	/* set polarity to low for all lines */
+	rt_gpio_w32(rg, GPIO_REG_POL, 0);
+
+	dev_info(&pdev->dev, "registering %d gpios\n", rg->chip.ngpio);
+
+	ralink_gpio_irq_init(np, rg);
+
+	return gpiochip_add(&rg->chip);
+}
+
+static const struct of_device_id ralink_gpio_match[] = {
+	{ .compatible = "ralink,rt2880-gpio" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ralink_gpio_match);
+
+static struct platform_driver ralink_gpio_driver = {
+	.probe = ralink_gpio_probe,
+	.driver = {
+		.name = "rt2880_gpio",
+		.owner = THIS_MODULE,
+		.of_match_table = ralink_gpio_match,
+	},
+};
+
+static int __init ralink_gpio_init(void)
+{
+	return platform_driver_register(&ralink_gpio_driver);
+}
+
+subsys_initcall(ralink_gpio_init);
-- 
1.7.10.4
