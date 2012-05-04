Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 May 2012 14:23:47 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:48633 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903686Ab2EDMUQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 May 2012 14:20:16 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>,
        devicetree-discuss@lists.ozlabs.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH 04/14] OF: pinctrl: MIPS: lantiq: implement lantiq/xway pinctrl support
Date:   Fri,  4 May 2012 14:18:29 +0200
Message-Id: <1336133919-26525-4-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1336133919-26525-1-git-send-email-blogic@openwrt.org>
References: <1336133919-26525-1-git-send-email-blogic@openwrt.org>
X-archive-position: 33148
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Implement support for pinctrl on lantiq/xway socs. The IO core found on these
socs has the registers for pinctrl, pinconf and gpio mixed up in the same
register range. As the gpio_chip handling is only a few lines, the driver also
implements the gpio functionality. This obseletes the old gpio driver that was
located in the arch/ folder.

Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: devicetree-discuss@lists.ozlabs.org
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>
---
This patch is part of a series moving the mips/lantiq target to OF and clkdev
support. The patch, once Acked, should go upstream via Ralf's MIPS tree.

 arch/mips/Kconfig                                  |    1 +
 .../mips/include/asm/mach-lantiq/xway/lantiq_soc.h |    2 -
 arch/mips/lantiq/Kconfig                           |    1 +
 arch/mips/lantiq/xway/Makefile                     |    2 +-
 arch/mips/lantiq/xway/gpio.c                       |  195 ------
 arch/mips/lantiq/xway/gpio_stp.c                   |    5 -
 arch/mips/pci/pci-lantiq.c                         |   44 +--
 drivers/pinctrl/Kconfig                            |    9 +
 drivers/pinctrl/Makefile                           |    2 +
 drivers/pinctrl/pinctrl-lantiq.c                   |  308 +++++++++
 drivers/pinctrl/pinctrl-lantiq.h                   |  184 +++++
 drivers/pinctrl/pinctrl-xway.c                     |  702 ++++++++++++++++++++
 12 files changed, 1209 insertions(+), 246 deletions(-)
 delete mode 100644 arch/mips/lantiq/xway/gpio.c
 create mode 100644 drivers/pinctrl/pinctrl-lantiq.c
 create mode 100644 drivers/pinctrl/pinctrl-lantiq.h
 create mode 100644 drivers/pinctrl/pinctrl-xway.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index fbb5639..00a0482 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -216,6 +216,7 @@ config MACH_JZ4740
 config LANTIQ
 	bool "Lantiq based platforms"
 	select DMA_NONCOHERENT
+	select PINCTRL
 	select IRQ_CPU
 	select CEVT_R4K
 	select CSRC_R4K
diff --git a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
index 15eb4dc..150c7be 100644
--- a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
+++ b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
@@ -153,8 +153,6 @@
 #define LTQ_MPS_CHIPID		((u32 *)(LTQ_MPS_BASE_ADDR + 0x0344))
 
 /* request a non-gpio and set the PIO config */
-extern int  ltq_gpio_request(unsigned int pin, unsigned int alt0,
-	unsigned int alt1, unsigned int dir, const char *name);
 extern void ltq_pmu_enable(unsigned int module);
 extern void ltq_pmu_disable(unsigned int module);
 
diff --git a/arch/mips/lantiq/Kconfig b/arch/mips/lantiq/Kconfig
index 9485fe5..b86d942 100644
--- a/arch/mips/lantiq/Kconfig
+++ b/arch/mips/lantiq/Kconfig
@@ -2,6 +2,7 @@ if LANTIQ
 
 config SOC_TYPE_XWAY
 	bool
+	select PINCTRL_XWAY
 	default n
 
 choice
diff --git a/arch/mips/lantiq/xway/Makefile b/arch/mips/lantiq/xway/Makefile
index 7a6c30f..323b574 100644
--- a/arch/mips/lantiq/xway/Makefile
+++ b/arch/mips/lantiq/xway/Makefile
@@ -1,4 +1,4 @@
-obj-y := prom.o pmu.o ebu.o reset.o gpio.o gpio_stp.o gpio_ebu.o dma.o
+obj-y := prom.o pmu.o ebu.o reset.o gpio_stp.o gpio_ebu.o dma.o
 
 obj-$(CONFIG_SOC_XWAY) += clk-xway.o
 obj-$(CONFIG_SOC_AMAZON_SE) += clk-ase.o
diff --git a/arch/mips/lantiq/xway/gpio.c b/arch/mips/lantiq/xway/gpio.c
deleted file mode 100644
index c429a5b..0000000
--- a/arch/mips/lantiq/xway/gpio.c
+++ /dev/null
@@ -1,195 +0,0 @@
-/*
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- *
- *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
- */
-
-#include <linux/slab.h>
-#include <linux/export.h>
-#include <linux/platform_device.h>
-#include <linux/gpio.h>
-#include <linux/ioport.h>
-#include <linux/io.h>
-
-#include <lantiq_soc.h>
-
-#define LTQ_GPIO_OUT		0x00
-#define LTQ_GPIO_IN		0x04
-#define LTQ_GPIO_DIR		0x08
-#define LTQ_GPIO_ALTSEL0	0x0C
-#define LTQ_GPIO_ALTSEL1	0x10
-#define LTQ_GPIO_OD		0x14
-
-#define PINS_PER_PORT		16
-#define MAX_PORTS		3
-
-#define ltq_gpio_getbit(m, r, p)	(!!(ltq_r32(m + r) & (1 << p)))
-#define ltq_gpio_setbit(m, r, p)	ltq_w32_mask(0, (1 << p), m + r)
-#define ltq_gpio_clearbit(m, r, p)	ltq_w32_mask((1 << p), 0, m + r)
-
-struct ltq_gpio {
-	void __iomem *membase;
-	struct gpio_chip chip;
-};
-
-static struct ltq_gpio ltq_gpio_port[MAX_PORTS];
-
-int gpio_to_irq(unsigned int gpio)
-{
-	return -EINVAL;
-}
-EXPORT_SYMBOL(gpio_to_irq);
-
-int irq_to_gpio(unsigned int gpio)
-{
-	return -EINVAL;
-}
-EXPORT_SYMBOL(irq_to_gpio);
-
-int ltq_gpio_request(unsigned int pin, unsigned int alt0,
-	unsigned int alt1, unsigned int dir, const char *name)
-{
-	int id = 0;
-
-	if (pin >= (MAX_PORTS * PINS_PER_PORT))
-		return -EINVAL;
-	if (gpio_request(pin, name)) {
-		pr_err("failed to setup lantiq gpio: %s\n", name);
-		return -EBUSY;
-	}
-	if (dir)
-		gpio_direction_output(pin, 1);
-	else
-		gpio_direction_input(pin);
-	while (pin >= PINS_PER_PORT) {
-		pin -= PINS_PER_PORT;
-		id++;
-	}
-	if (alt0)
-		ltq_gpio_setbit(ltq_gpio_port[id].membase,
-			LTQ_GPIO_ALTSEL0, pin);
-	else
-		ltq_gpio_clearbit(ltq_gpio_port[id].membase,
-			LTQ_GPIO_ALTSEL0, pin);
-	if (alt1)
-		ltq_gpio_setbit(ltq_gpio_port[id].membase,
-			LTQ_GPIO_ALTSEL1, pin);
-	else
-		ltq_gpio_clearbit(ltq_gpio_port[id].membase,
-			LTQ_GPIO_ALTSEL1, pin);
-	return 0;
-}
-EXPORT_SYMBOL(ltq_gpio_request);
-
-static void ltq_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
-{
-	struct ltq_gpio *ltq_gpio = container_of(chip, struct ltq_gpio, chip);
-
-	if (value)
-		ltq_gpio_setbit(ltq_gpio->membase, LTQ_GPIO_OUT, offset);
-	else
-		ltq_gpio_clearbit(ltq_gpio->membase, LTQ_GPIO_OUT, offset);
-}
-
-static int ltq_gpio_get(struct gpio_chip *chip, unsigned int offset)
-{
-	struct ltq_gpio *ltq_gpio = container_of(chip, struct ltq_gpio, chip);
-
-	return ltq_gpio_getbit(ltq_gpio->membase, LTQ_GPIO_IN, offset);
-}
-
-static int ltq_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
-{
-	struct ltq_gpio *ltq_gpio = container_of(chip, struct ltq_gpio, chip);
-
-	ltq_gpio_clearbit(ltq_gpio->membase, LTQ_GPIO_OD, offset);
-	ltq_gpio_clearbit(ltq_gpio->membase, LTQ_GPIO_DIR, offset);
-
-	return 0;
-}
-
-static int ltq_gpio_direction_output(struct gpio_chip *chip,
-	unsigned int offset, int value)
-{
-	struct ltq_gpio *ltq_gpio = container_of(chip, struct ltq_gpio, chip);
-
-	ltq_gpio_setbit(ltq_gpio->membase, LTQ_GPIO_OD, offset);
-	ltq_gpio_setbit(ltq_gpio->membase, LTQ_GPIO_DIR, offset);
-	ltq_gpio_set(chip, offset, value);
-
-	return 0;
-}
-
-static int ltq_gpio_req(struct gpio_chip *chip, unsigned offset)
-{
-	struct ltq_gpio *ltq_gpio = container_of(chip, struct ltq_gpio, chip);
-
-	ltq_gpio_clearbit(ltq_gpio->membase, LTQ_GPIO_ALTSEL0, offset);
-	ltq_gpio_clearbit(ltq_gpio->membase, LTQ_GPIO_ALTSEL1, offset);
-	return 0;
-}
-
-static int ltq_gpio_probe(struct platform_device *pdev)
-{
-	struct resource *res;
-
-	if (pdev->id >= MAX_PORTS) {
-		dev_err(&pdev->dev, "invalid gpio port %d\n",
-			pdev->id);
-		return -EINVAL;
-	}
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "failed to get memory for gpio port %d\n",
-			pdev->id);
-		return -ENOENT;
-	}
-	res = devm_request_mem_region(&pdev->dev, res->start,
-		resource_size(res), dev_name(&pdev->dev));
-	if (!res) {
-		dev_err(&pdev->dev,
-			"failed to request memory for gpio port %d\n",
-			pdev->id);
-		return -EBUSY;
-	}
-	ltq_gpio_port[pdev->id].membase = devm_ioremap_nocache(&pdev->dev,
-		res->start, resource_size(res));
-	if (!ltq_gpio_port[pdev->id].membase) {
-		dev_err(&pdev->dev, "failed to remap memory for gpio port %d\n",
-			pdev->id);
-		return -ENOMEM;
-	}
-	ltq_gpio_port[pdev->id].chip.label = "ltq_gpio";
-	ltq_gpio_port[pdev->id].chip.direction_input = ltq_gpio_direction_input;
-	ltq_gpio_port[pdev->id].chip.direction_output =
-		ltq_gpio_direction_output;
-	ltq_gpio_port[pdev->id].chip.get = ltq_gpio_get;
-	ltq_gpio_port[pdev->id].chip.set = ltq_gpio_set;
-	ltq_gpio_port[pdev->id].chip.request = ltq_gpio_req;
-	ltq_gpio_port[pdev->id].chip.base = PINS_PER_PORT * pdev->id;
-	ltq_gpio_port[pdev->id].chip.ngpio = PINS_PER_PORT;
-	platform_set_drvdata(pdev, &ltq_gpio_port[pdev->id]);
-	return gpiochip_add(&ltq_gpio_port[pdev->id].chip);
-}
-
-static struct platform_driver
-ltq_gpio_driver = {
-	.probe = ltq_gpio_probe,
-	.driver = {
-		.name = "ltq_gpio",
-		.owner = THIS_MODULE,
-	},
-};
-
-int __init ltq_gpio_init(void)
-{
-	int ret = platform_driver_register(&ltq_gpio_driver);
-
-	if (ret)
-		pr_info("ltq_gpio : Error registering platform driver!");
-	return ret;
-}
-
-postcore_initcall(ltq_gpio_init);
diff --git a/arch/mips/lantiq/xway/gpio_stp.c b/arch/mips/lantiq/xway/gpio_stp.c
index fd07d87..4f4bd61 100644
--- a/arch/mips/lantiq/xway/gpio_stp.c
+++ b/arch/mips/lantiq/xway/gpio_stp.c
@@ -78,11 +78,6 @@ static struct gpio_chip ltq_stp_chip = {
 
 static int ltq_stp_hw_init(void)
 {
-	/* the 3 pins used to control the external stp */
-	ltq_gpio_request(4, 1, 0, 1, "stp-st");
-	ltq_gpio_request(5, 1, 0, 1, "stp-d");
-	ltq_gpio_request(6, 1, 0, 1, "stp-sh");
-
 	/* sane defaults */
 	ltq_stp_w32(0, LTQ_STP_AR);
 	ltq_stp_w32(0, LTQ_STP_CPU0);
diff --git a/arch/mips/pci/pci-lantiq.c b/arch/mips/pci/pci-lantiq.c
index 70fdf2c..3418178 100644
--- a/arch/mips/pci/pci-lantiq.c
+++ b/arch/mips/pci/pci-lantiq.c
@@ -68,32 +68,6 @@
 #define ltq_pci_cfg_w32(x, y)	ltq_w32((x), ltq_pci_mapped_cfg + (y))
 #define ltq_pci_cfg_r32(x)	ltq_r32(ltq_pci_mapped_cfg + (x))
 
-struct ltq_pci_gpio_map {
-	int pin;
-	int alt0;
-	int alt1;
-	int dir;
-	char *name;
-};
-
-/* the pci core can make use of the following gpios */
-static struct ltq_pci_gpio_map ltq_pci_gpio_map[] = {
-	{ 0, 1, 0, 0, "pci-exin0" },
-	{ 1, 1, 0, 0, "pci-exin1" },
-	{ 2, 1, 0, 0, "pci-exin2" },
-	{ 39, 1, 0, 0, "pci-exin3" },
-	{ 10, 1, 0, 0, "pci-exin4" },
-	{ 9, 1, 0, 0, "pci-exin5" },
-	{ 30, 1, 0, 1, "pci-gnt1" },
-	{ 23, 1, 0, 1, "pci-gnt2" },
-	{ 19, 1, 0, 1, "pci-gnt3" },
-	{ 38, 1, 0, 1, "pci-gnt4" },
-	{ 29, 1, 0, 0, "pci-req1" },
-	{ 31, 1, 0, 0, "pci-req2" },
-	{ 3, 1, 0, 0, "pci-req3" },
-	{ 37, 1, 0, 0, "pci-req4" },
-};
-
 __iomem void *ltq_pci_mapped_cfg;
 static __iomem void *ltq_pci_membase;
 
@@ -151,22 +125,6 @@ static u32 ltq_calc_bar11mask(void)
 	return bar11mask;
 }
 
-static void ltq_pci_setup_gpio(int gpio)
-{
-	int i;
-	for (i = 0; i < ARRAY_SIZE(ltq_pci_gpio_map); i++) {
-		if (gpio & (1 << i)) {
-			ltq_gpio_request(ltq_pci_gpio_map[i].pin,
-				ltq_pci_gpio_map[i].alt0,
-				ltq_pci_gpio_map[i].alt1,
-				ltq_pci_gpio_map[i].dir,
-				ltq_pci_gpio_map[i].name);
-		}
-	}
-	ltq_gpio_request(21, 0, 0, 1, "pci-reset");
-	ltq_pci_req_mask = (gpio >> PCI_REQ_SHIFT) & PCI_REQ_MASK;
-}
-
 static int __devinit ltq_pci_startup(struct ltq_pci_data *conf)
 {
 	u32 temp_buffer;
@@ -192,7 +150,7 @@ static int __devinit ltq_pci_startup(struct ltq_pci_data *conf)
 	}
 
 	/* setup pci clock and gpis used by pci */
-	ltq_pci_setup_gpio(conf->gpio);
+	gpio_request(21, "pci-reset");
 
 	/* enable auto-switching between PCI and EBU */
 	ltq_pci_w32(0xa, PCI_CR_CLK_CTRL);
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index f73a5ea..a19bac96 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -30,6 +30,11 @@ config PINCTRL_PXA3xx
 	bool
 	select PINMUX
 
+config PINCTRL_LANTIQ
+	bool
+	select PINMUX
+	select PINCONF
+
 config PINCTRL_MMP2
 	bool "MMP2 pin controller driver"
 	depends on ARCH_MMP
@@ -83,6 +88,10 @@ config PINCTRL_COH901
 	  COH 901 335 and COH 901 571/3. They contain 3, 5 or 7
 	  ports of 8 GPIO pins each.
 
+config PINCTRL_XWAY
+	bool
+	select PINCTRL_LANTIQ
+
 endmenu
 
 endif
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 8e3c95a..15bf5a3 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -19,3 +19,5 @@ obj-$(CONFIG_PINCTRL_TEGRA20)	+= pinctrl-tegra20.o
 obj-$(CONFIG_PINCTRL_TEGRA30)	+= pinctrl-tegra30.o
 obj-$(CONFIG_PINCTRL_U300)	+= pinctrl-u300.o
 obj-$(CONFIG_PINCTRL_COH901)	+= pinctrl-coh901.o
+obj-$(CONFIG_PINCTRL_LANTIQ)	+= pinctrl-lantiq.o
+obj-$(CONFIG_PINCTRL_XWAY)	+= pinctrl-xway.o
diff --git a/drivers/pinctrl/pinctrl-lantiq.c b/drivers/pinctrl/pinctrl-lantiq.c
new file mode 100644
index 0000000..f2e28a5
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-lantiq.c
@@ -0,0 +1,308 @@
+/*
+ *  linux/drivers/pinctrl/pinctrl-lantiq.c
+ *  based on linux/drivers/pinctrl/pinctrl-pxa3xx.c
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  publishhed by the Free Software Foundation.
+ *
+ *  Copyright (C) 2012 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+
+#include "core.h"
+
+#include "pinctrl-lantiq.h"
+
+static int ltq_get_group_count(struct pinctrl_dev *pctrldev)
+{
+	struct ltq_pinmux_info *info = pinctrl_dev_get_drvdata(pctrldev);
+	return info->num_grps;
+}
+
+static const char *ltq_get_group_name(struct pinctrl_dev *pctrldev,
+					 unsigned selector)
+{
+	struct ltq_pinmux_info *info = pinctrl_dev_get_drvdata(pctrldev);
+	if (selector >= info->num_grps)
+		return NULL;
+	return info->grps[selector].name;
+}
+
+static int ltq_get_group_pins(struct pinctrl_dev *pctrldev,
+				 unsigned selector,
+				 const unsigned **pins,
+				 unsigned *num_pins)
+{
+	struct ltq_pinmux_info *info = pinctrl_dev_get_drvdata(pctrldev);
+	if (selector >= info->num_grps)
+		return -EINVAL;
+	*pins = info->grps[selector].pins;
+	*num_pins = info->grps[selector].npins;
+	return 0;
+}
+
+void ltq_pinctrl_dt_free_map(struct pinctrl_dev *pctldev,
+				struct pinctrl_map *map, unsigned num_maps)
+{
+	int i;
+
+	for (i = 0; i < num_maps; i++)
+		if (map[i].type == PIN_MAP_TYPE_CONFIGS_PIN)
+			kfree(map[i].data.configs.configs);
+	kfree(map);
+}
+
+static void ltq_pinctrl_pin_dbg_show(struct pinctrl_dev *pctldev,
+					struct seq_file *s,
+					unsigned offset)
+{
+	seq_printf(s, " %s", dev_name(pctldev->dev));
+}
+
+static int ltq_pinctrl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
+				struct device_node *np,
+				struct pinctrl_map **map)
+{
+	struct ltq_pinmux_info *info = pinctrl_dev_get_drvdata(pctldev);
+	unsigned long configs[3];
+	unsigned num_configs = 0;
+	struct property *prop;
+	const char *group, *pin;
+	const char *function;
+	int ret, i;
+
+	ret = of_property_read_string(np, "lantiq,function", &function);
+	if (!ret) {
+		of_property_for_each_string(np, "lantiq,groups", prop, group) {
+			(*map)->type = PIN_MAP_TYPE_MUX_GROUP;
+			(*map)->name = function;
+			(*map)->data.mux.group = group;
+			(*map)->data.mux.function = function;
+			(*map)++;
+		}
+		if (of_find_property(np, "lantiq,pins", NULL))
+			dev_err(pctldev->dev,
+				"%s mixes pins and groups settings\n",
+				np->name);
+		return 0;
+	}
+
+	for (i = 0; i < info->num_params; i++) {
+		u32 val;
+		int ret = of_property_read_u32(np,
+				info->params[i].property, &val);
+		if (!ret)
+			configs[num_configs++] =
+				LTQ_PINCONF_PACK(info->params[i].param,
+				val);
+	}
+
+	if (!num_configs)
+		return -EINVAL;
+
+	of_property_for_each_string(np, "lantiq,pins", prop, pin) {
+		(*map)->data.configs.configs = kmemdup(configs,
+					num_configs * sizeof(unsigned long),
+					GFP_KERNEL);
+		(*map)->type = PIN_MAP_TYPE_CONFIGS_PIN;
+		(*map)->name = pin;
+		(*map)->data.configs.group_or_pin = pin;
+		(*map)->data.configs.num_configs = num_configs;
+		(*map)++;
+	}
+	return 0;
+}
+
+static int ltq_pinctrl_dt_subnode_size(struct device_node *np)
+{
+	int ret;
+
+	ret = of_property_count_strings(np, "lantiq,groups");
+	if (ret < 0)
+		ret = of_property_count_strings(np, "lantiq,pins");
+	return ret;
+}
+
+int ltq_pinctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
+				struct device_node *np_config,
+				struct pinctrl_map **map,
+				unsigned *num_maps)
+{
+	struct pinctrl_map *tmp;
+	struct device_node *np;
+	int ret;
+
+	*num_maps = 0;
+	for_each_child_of_node(np_config, np)
+		*num_maps += ltq_pinctrl_dt_subnode_size(np);
+	*map = kzalloc(*num_maps * sizeof(struct pinctrl_map), GFP_KERNEL);
+	tmp = *map;
+
+	for_each_child_of_node(np_config, np) {
+		ret = ltq_pinctrl_dt_subnode_to_map(pctldev, np, &tmp);
+		if (ret < 0) {
+			ltq_pinctrl_dt_free_map(pctldev, *map, *num_maps);
+			return ret;
+		}
+	}
+	return 0;
+}
+
+static struct pinctrl_ops ltq_pctrl_ops = {
+	.get_groups_count	= ltq_get_group_count,
+	.get_group_name		= ltq_get_group_name,
+	.get_group_pins		= ltq_get_group_pins,
+	.pin_dbg_show		= ltq_pinctrl_pin_dbg_show,
+	.dt_node_to_map		= ltq_pinctrl_dt_node_to_map,
+	.dt_free_map		= ltq_pinctrl_dt_free_map,
+};
+
+static int ltq_pmx_func_count(struct pinctrl_dev *pctrldev)
+{
+	struct ltq_pinmux_info *info = pinctrl_dev_get_drvdata(pctrldev);
+
+	return info->num_funcs;
+}
+
+static const char *ltq_pmx_func_name(struct pinctrl_dev *pctrldev,
+					 unsigned selector)
+{
+	struct ltq_pinmux_info *info = pinctrl_dev_get_drvdata(pctrldev);
+
+	if (selector >= info->num_funcs)
+		return NULL;
+
+	return info->funcs[selector].name;
+}
+
+static int ltq_pmx_get_groups(struct pinctrl_dev *pctrldev,
+				unsigned func,
+				const char * const **groups,
+				unsigned * const num_groups)
+{
+	struct ltq_pinmux_info *info = pinctrl_dev_get_drvdata(pctrldev);
+
+	*groups = info->funcs[func].groups;
+	*num_groups = info->funcs[func].num_groups;
+
+	return 0;
+}
+
+/* Return function number. If failure, return negative value. */
+static int match_mux(const struct ltq_mfp_pin *mfp, unsigned mux)
+{
+	int i;
+	for (i = 0; i < LTQ_MAX_MUX; i++) {
+		if (mfp->func[i] == mux)
+			break;
+	}
+	if (i >= LTQ_MAX_MUX)
+		return -EINVAL;
+	return i;
+}
+
+/* check whether current pin configuration is valid. Negative for failure */
+static int match_group_mux(const struct ltq_pin_group *grp,
+			   const struct ltq_pinmux_info *info,
+			   unsigned mux)
+{
+	int i, pin, ret = 0;
+	for (i = 0; i < grp->npins; i++) {
+		pin = grp->pins[i];
+		ret = match_mux(&info->mfp[pin], mux);
+		if (ret < 0) {
+			dev_err(info->dev, "Can't find mux %d on pin%d\n",
+				mux, pin);
+			break;
+		}
+	}
+	return ret;
+}
+
+static int ltq_pmx_enable(struct pinctrl_dev *pctrldev,
+				unsigned func,
+				unsigned group)
+{
+	struct ltq_pinmux_info *info = pinctrl_dev_get_drvdata(pctrldev);
+	const struct ltq_pin_group *pin_grp = &info->grps[group];
+	int i, pin, pin_func;
+
+	if (!pin_grp->npins ||
+		(match_group_mux(pin_grp, info, pin_grp->mux) < 0)) {
+		dev_err(info->dev, "Failed to set the pin group: %s\n",
+			info->grps[group].name);
+		return -EINVAL;
+	}
+	for (i = 0; i < pin_grp->npins; i++) {
+		pin = pin_grp->pins[i];
+		pin_func = match_mux(&info->mfp[pin], pin_grp->mux);
+		info->apply_mux(pctrldev, pin, pin_func);
+	}
+	return 0;
+}
+
+static void ltq_pmx_disable(struct pinctrl_dev *pctrldev,
+				unsigned func,
+				unsigned group)
+{
+}
+
+static int ltq_pmx_gpio_request_enable(struct pinctrl_dev *pctrldev,
+				struct pinctrl_gpio_range *range,
+				unsigned pin)
+{
+	struct ltq_pinmux_info *info = pinctrl_dev_get_drvdata(pctrldev);
+	int pin_func;
+
+	/* all our pins are gpio when muxing is set to 0. check anyhow */
+	pin_func = match_mux(&info->mfp[pin], 0);
+	if (pin_func < 0) {
+		dev_err(info->dev, "No GPIO function on pin%d\n", pin);
+		return -EINVAL;
+	}
+
+	info->apply_mux(pctrldev, pin, 0);
+
+	return 0;
+}
+
+static struct pinmux_ops ltq_pmx_ops = {
+	.get_functions_count	= ltq_pmx_func_count,
+	.get_function_name	= ltq_pmx_func_name,
+	.get_function_groups	= ltq_pmx_get_groups,
+	.enable			= ltq_pmx_enable,
+	.disable		= ltq_pmx_disable,
+	.gpio_request_enable	= ltq_pmx_gpio_request_enable,
+};
+
+/*
+ * allow different socs to register with the generic part of the lanti
+ * pinctrl code
+ */
+int ltq_pinctrl_register(struct platform_device *pdev,
+				struct ltq_pinmux_info *info)
+{
+	struct pinctrl_desc *desc;
+
+	if (!info)
+		return -EINVAL;
+	desc = info->desc;
+	desc->pctlops = &ltq_pctrl_ops;
+	desc->pmxops = &ltq_pmx_ops;
+	info->dev = &pdev->dev;
+
+	info->pctrl = pinctrl_register(desc, &pdev->dev, info);
+	if (!info->pctrl) {
+		dev_err(&pdev->dev, "failed to register LTQ pinmux driver\n");
+		return -EINVAL;
+	}
+	platform_set_drvdata(pdev, info);
+	return 0;
+}
diff --git a/drivers/pinctrl/pinctrl-lantiq.h b/drivers/pinctrl/pinctrl-lantiq.h
new file mode 100644
index 0000000..dc84c09
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-lantiq.h
@@ -0,0 +1,184 @@
+/*
+ *  linux/drivers/pinctrl/pinctrl-lantiq.h
+ *  based on linux/drivers/pinctrl/pinctrl-pxa3xx.h
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  publishhed by the Free Software Foundation.
+ *
+ *  Copyright (C) 2012 John Crispin <blogic@openwrt.org>
+ */
+
+#ifndef __PINCTRL_LANTIQ_H
+
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/pinctrl/machine.h>
+
+#define ARRAY_AND_SIZE(x)	(x), ARRAY_SIZE(x)
+
+#define LTQ_MAX_MUX		4
+#define MFPR_FUNC_MASK		0x3
+
+#define LTQ_PINCONF_PACK(_param_, _arg_)	((_param_) << 16 | (_arg_))
+#define LTQ_PINCONF_UNPACK_PARAM(_conf_)	((_conf_) >> 16)
+#define LTQ_PINCONF_UNPACK_ARG(_conf_)		((_conf_) & 0xffff)
+
+enum ltq_pinconf_param {
+	LTQ_PINCONF_PARAM_PULL,
+	LTQ_PINCONF_PARAM_OPEN_DRAIN,
+	LTQ_PINCONF_PARAM_DRIVE_CURRENT,
+	LTQ_PINCONF_PARAM_SLEW_RATE,
+};
+
+struct ltq_cfg_param {
+	const char *property;
+	enum ltq_pinconf_param param;
+};
+
+struct ltq_mfp_pin {
+	const char *name;
+	const unsigned int pin;
+	const unsigned short func[LTQ_MAX_MUX];
+};
+
+struct ltq_pin_group {
+	const char *name;
+	const unsigned mux;
+	const unsigned *pins;
+	const unsigned npins;
+};
+
+struct ltq_pmx_func {
+	const char *name;
+	const char * const *groups;
+	const unsigned num_groups;
+};
+
+struct ltq_pinmux_info {
+	struct device *dev;
+	struct pinctrl_dev *pctrl;
+
+	/* we need to manage up to 5 padcontrolers */
+	void __iomem *membase[5];
+
+	/* the handler for the subsystem */
+	struct pinctrl_desc *desc;
+
+	/* we expose our pads to the subsystem */
+	struct pinctrl_pin_desc *pads;
+
+	/* the number of pads. this varies between socs */
+	unsigned int num_gpio;
+
+	/* these are our multifunction pins */
+	const struct ltq_mfp_pin *mfp;
+	unsigned int num_mfp;
+
+	/* a number of multifunction pins can be grouped together */
+	const struct ltq_pin_group *grps;
+	unsigned int num_grps;
+
+	/* a mapping between function string and id */
+	const struct ltq_pmx_func *funcs;
+	unsigned int num_funcs;
+
+	/* the pinconf options that we are able to read from the DT */
+	const struct ltq_cfg_param *params;
+	unsigned int num_params;
+
+	/* soc specific callback used to apply muxing */
+	int (*apply_mux)(struct pinctrl_dev *pctrldev, int pin, int mux);
+};
+
+enum ltq_pin_list {
+	GPIO0 = 0,
+	GPIO1,
+	GPIO2,
+	GPIO3,
+	GPIO4,
+	GPIO5,
+	GPIO6,
+	GPIO7,
+	GPIO8,
+	GPIO9,
+	GPIO10, /* 10 */
+	GPIO11,
+	GPIO12,
+	GPIO13,
+	GPIO14,
+	GPIO15,
+	GPIO16,
+	GPIO17,
+	GPIO18,
+	GPIO19,
+	GPIO20, /* 20 */
+	GPIO21,
+	GPIO22,
+	GPIO23,
+	GPIO24,
+	GPIO25,
+	GPIO26,
+	GPIO27,
+	GPIO28,
+	GPIO29,
+	GPIO30, /* 30 */
+	GPIO31,
+	GPIO32,
+	GPIO33,
+	GPIO34,
+	GPIO35,
+	GPIO36,
+	GPIO37,
+	GPIO38,
+	GPIO39,
+	GPIO40, /* 40 */
+	GPIO41,
+	GPIO42,
+	GPIO43,
+	GPIO44,
+	GPIO45,
+	GPIO46,
+	GPIO47,
+	GPIO48,
+	GPIO49,
+	GPIO50, /* 50 */
+	GPIO51,
+	GPIO52,
+	GPIO53,
+	GPIO54,
+	GPIO55,
+
+	GPIO64,
+	GPIO65,
+	GPIO66,
+	GPIO67,
+	GPIO68,
+	GPIO69,
+	GPIO70,
+	GPIO71,
+	GPIO72,
+	GPIO73,
+	GPIO74,
+	GPIO75,
+	GPIO76,
+	GPIO77,
+	GPIO78,
+	GPIO79,
+	GPIO80,
+	GPIO81,
+	GPIO82,
+	GPIO83,
+	GPIO84,
+	GPIO85,
+	GPIO86,
+	GPIO87,
+	GPIO88,
+};
+
+extern int ltq_pinctrl_register(struct platform_device *pdev,
+				   struct ltq_pinmux_info *info);
+extern int ltq_pinctrl_unregister(struct platform_device *pdev);
+#endif	/* __PINCTRL_PXA3XX_H */
diff --git a/drivers/pinctrl/pinctrl-xway.c b/drivers/pinctrl/pinctrl-xway.c
new file mode 100644
index 0000000..efc3174
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-xway.c
@@ -0,0 +1,702 @@
+/*
+ *  linux/drivers/pinctrl/pinmux-xway.c
+ *  based on linux/drivers/pinctrl/pinmux-pxa910.c
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  publishhed by the Free Software Foundation.
+ *
+ *  Copyright (C) 2012 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/of_gpio.h>
+#include <linux/ioport.h>
+#include <linux/io.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+
+#include "pinctrl-lantiq.h"
+
+#include <lantiq_soc.h>
+
+/* we have 3 1/2 banks of 16 bit each */
+#define PINS			16
+#define PORT(x)			(x / PINS)
+#define PORT_PIN(x)		(x % PINS)
+
+/*
+ * each bank has this offset apart from the 1/2 bank that is mixed into the
+ * other 3 ranges
+ */
+#define REG_OFF			0x30
+
+/* these are the offsets to our registers */
+#define GPIO_BASE(p)		(REG_OFF * PORT(p))
+#define GPIO_OUT(p)		GPIO_BASE(p)
+#define GPIO_IN(p)		(GPIO_BASE(p) + 0x04)
+#define GPIO_DIR(p)		(GPIO_BASE(p) + 0x08)
+#define GPIO_ALT0(p)		(GPIO_BASE(p) + 0x0C)
+#define GPIO_ALT1(p)		(GPIO_BASE(p) + 0x10)
+#define GPIO_OD(p)		(GPIO_BASE(p) + 0x14)
+#define GPIO_PUDSEL(p)		(GPIO_BASE(p) + 0x1c)
+#define GPIO_PUDEN(p)		(GPIO_BASE(p) + 0x20)
+
+/* the 1/2 port needs special offsets for some registers */
+#define GPIO3_OD		(GPIO_BASE(0) + 0x24)
+#define GPIO3_PUDSEL		(GPIO_BASE(0) + 0x28)
+#define GPIO3_PUDEN		(GPIO_BASE(0) + 0x2C)
+#define GPIO3_ALT1		(GPIO_BASE(PINS) + 0x24)
+
+/* PORT3 only has 8 pins and its register layout
+   is slightly different */
+#define PINS_PER_PORT		16
+#define PINS_PORT3		8
+#define MAX_PORTS		4
+#define MAX_PIN			56
+
+/* macros to help us access the registers */
+#define gpio_getbit(m, r, p)	(!!(ltq_r32(m + r) & (1 << p)))
+#define gpio_setbit(m, r, p)	ltq_w32_mask(0, (1 << p), m + r)
+#define gpio_clearbit(m, r, p)	ltq_w32_mask((1 << p), 0, m + r)
+
+#define MFP_XWAY(a, f0, f1, f2, f3)	\
+	{				\
+		.name = #a,		\
+		.pin = a,		\
+		.func = {		\
+			XWAY_MUX_##f0,	\
+			XWAY_MUX_##f1,	\
+			XWAY_MUX_##f2,	\
+			XWAY_MUX_##f3,	\
+		},			\
+	}
+
+#define GRP_MUX(a, m, p)		\
+	{ .name = a, .mux = XWAY_MUX_##m, .pins = p, .npins = ARRAY_SIZE(p), }
+
+#define FUNC_MUX(f, m)		\
+	{ .func = f, .mux = XWAY_MUX_##m, }
+
+enum xway_mux {
+	XWAY_MUX_GPIO = 0,
+	XWAY_MUX_SPI,
+	XWAY_MUX_ASC,
+	XWAY_MUX_PCI,
+	XWAY_MUX_CGU,
+	XWAY_MUX_EBU,
+	XWAY_MUX_JTAG,
+	XWAY_MUX_EXIN,
+	XWAY_MUX_TDM,
+	XWAY_MUX_STP,
+	XWAY_MUX_SIN,
+	XWAY_MUX_GPT,
+	XWAY_MUX_NMI,
+	XWAY_MUX_NONE = 0xffff,
+};
+
+static const struct ltq_mfp_pin xway_mfp[] = {
+	/*       pin    f0	f1	f2	f3   */
+	MFP_XWAY(GPIO0, GPIO,	EXIN,	NONE,	TDM),
+	MFP_XWAY(GPIO1, GPIO,	EXIN,	NONE,	NONE),
+	MFP_XWAY(GPIO2, GPIO,	CGU,	EXIN,	NONE),
+	MFP_XWAY(GPIO3, GPIO,	CGU,	NONE,	PCI),
+	MFP_XWAY(GPIO4, GPIO,	STP,	NONE,	ASC),
+	MFP_XWAY(GPIO5, GPIO,	STP,	NONE,	NONE),
+	MFP_XWAY(GPIO6, GPIO,	STP,	GPT,	ASC),
+	MFP_XWAY(GPIO7, GPIO,	CGU,	PCI,	NONE),
+	MFP_XWAY(GPIO8, GPIO,	CGU,	NMI,	NONE),
+	MFP_XWAY(GPIO9, GPIO,	ASC,	SPI,	NONE),
+	MFP_XWAY(GPIO10, GPIO,	ASC,	SPI,	NONE),
+	MFP_XWAY(GPIO11, GPIO,	ASC,	PCI,	SPI),
+	MFP_XWAY(GPIO12, GPIO,	ASC,	NONE,	NONE),
+	MFP_XWAY(GPIO13, GPIO,	EBU,	SPI,	NONE),
+	MFP_XWAY(GPIO14, GPIO,	CGU,	PCI,	NONE),
+	MFP_XWAY(GPIO15, GPIO,	SPI,	JTAG,	NONE),
+	MFP_XWAY(GPIO16, GPIO,	SPI,	NONE,	JTAG),
+	MFP_XWAY(GPIO17, GPIO,	SPI,	NONE,	JTAG),
+	MFP_XWAY(GPIO18, GPIO,	SPI,	NONE,	JTAG),
+	MFP_XWAY(GPIO19, GPIO,	PCI,	NONE,	NONE),
+	MFP_XWAY(GPIO20, GPIO,	JTAG,	NONE,	NONE),
+	MFP_XWAY(GPIO21, GPIO,	PCI,	EBU,	GPT),
+	MFP_XWAY(GPIO22, GPIO,	SPI,	NONE,	NONE),
+	MFP_XWAY(GPIO23, GPIO,	EBU,	PCI,	STP),
+	MFP_XWAY(GPIO24, GPIO,	EBU,	TDM,	PCI),
+	MFP_XWAY(GPIO25, GPIO,	TDM,	NONE,	ASC),
+	MFP_XWAY(GPIO26, GPIO,	EBU,	NONE,	TDM),
+	MFP_XWAY(GPIO27, GPIO,	TDM,	NONE,	ASC),
+	MFP_XWAY(GPIO28, GPIO,	GPT,	NONE,	NONE),
+	MFP_XWAY(GPIO29, GPIO,	PCI,	NONE,	NONE),
+	MFP_XWAY(GPIO30, GPIO,	PCI,	NONE,	NONE),
+	MFP_XWAY(GPIO31, GPIO,	EBU,	PCI,	NONE),
+	MFP_XWAY(GPIO32, GPIO,	NONE,	NONE,	EBU),
+	MFP_XWAY(GPIO33, GPIO,	NONE,	NONE,	EBU),
+	MFP_XWAY(GPIO34, GPIO,	NONE,	NONE,	EBU),
+	MFP_XWAY(GPIO35, GPIO,	NONE,	NONE,	EBU),
+	MFP_XWAY(GPIO36, GPIO,	SIN,	NONE,	EBU),
+	MFP_XWAY(GPIO37, GPIO,	PCI,	NONE,	NONE),
+	MFP_XWAY(GPIO38, GPIO,	PCI,	NONE,	NONE),
+	MFP_XWAY(GPIO39, GPIO,	EXIN,	NONE,	NONE),
+	MFP_XWAY(GPIO40, GPIO,	NONE,	NONE,	NONE),
+	MFP_XWAY(GPIO41, GPIO,	NONE,	NONE,	NONE),
+	MFP_XWAY(GPIO42, GPIO,	NONE,	NONE,	NONE),
+	MFP_XWAY(GPIO43, GPIO,	NONE,	NONE,	NONE),
+	MFP_XWAY(GPIO44, GPIO,	NONE,	NONE,	SIN),
+	MFP_XWAY(GPIO45, GPIO,	NONE,	NONE,	SIN),
+	MFP_XWAY(GPIO46, GPIO,	NONE,	NONE,	EXIN),
+	MFP_XWAY(GPIO47, GPIO,	NONE,	NONE,	SIN),
+	MFP_XWAY(GPIO48, GPIO,	EBU,	NONE,	NONE),
+	MFP_XWAY(GPIO49, GPIO,	EBU,	NONE,	NONE),
+	MFP_XWAY(GPIO50, GPIO,	NONE,	NONE,	NONE),
+	MFP_XWAY(GPIO51, GPIO,	NONE,	NONE,	NONE),
+	MFP_XWAY(GPIO52, GPIO,	NONE,	NONE,	NONE),
+	MFP_XWAY(GPIO53, GPIO,	NONE,	NONE,	NONE),
+	MFP_XWAY(GPIO54, GPIO,	NONE,	NONE,	NONE),
+	MFP_XWAY(GPIO55, GPIO,	NONE,	NONE,	NONE),
+};
+
+static const unsigned pins_jtag[] = {GPIO15, GPIO16, GPIO17, GPIO19, GPIO35};
+static const unsigned pins_asc0[] = {GPIO11, GPIO12};
+static const unsigned pins_asc0_cts_rts[] = {GPIO9, GPIO10};
+static const unsigned pins_stp[] = {GPIO4, GPIO5, GPIO6};
+static const unsigned pins_nmi[] = {GPIO8};
+
+static const unsigned pins_ebu_a24[] = {GPIO13};
+static const unsigned pins_ebu_clk[] = {GPIO21};
+static const unsigned pins_ebu_cs1[] = {GPIO23};
+static const unsigned pins_ebu_a23[] = {GPIO24};
+static const unsigned pins_ebu_wait[] = {GPIO26};
+static const unsigned pins_ebu_a25[] = {GPIO31};
+static const unsigned pins_ebu_rdy[] = {GPIO48};
+static const unsigned pins_ebu_rd[] = {GPIO49};
+
+static const unsigned pins_nand_ale[] = {GPIO13};
+static const unsigned pins_nand_cs1[] = {GPIO23};
+static const unsigned pins_nand_cle[] = {GPIO24};
+static const unsigned pins_nand_rdy[] = {GPIO48};
+static const unsigned pins_nand_rd[] = {GPIO49};
+
+static const unsigned pins_exin0[] = {GPIO0};
+static const unsigned pins_exin1[] = {GPIO1};
+static const unsigned pins_exin2[] = {GPIO2};
+static const unsigned pins_exin3[] = {GPIO39};
+static const unsigned pins_exin4[] = {GPIO46};
+
+static const unsigned pins_spi[] = {GPIO16, GPIO17, GPIO18};
+static const unsigned pins_spi_cs1[] = {GPIO15};
+static const unsigned pins_spi_cs2[] = {GPIO21};
+static const unsigned pins_spi_cs3[] = {GPIO13};
+static const unsigned pins_spi_cs4[] = {GPIO10};
+static const unsigned pins_spi_cs5[] = {GPIO9};
+static const unsigned pins_spi_cs6[] = {GPIO11};
+
+static const unsigned pins_gpt1[] = {GPIO28};
+static const unsigned pins_gpt2[] = {GPIO21};
+static const unsigned pins_gpt3[] = {GPIO6};
+
+static const unsigned pins_clkout0[] = {GPIO8};
+static const unsigned pins_clkout1[] = {GPIO7};
+static const unsigned pins_clkout2[] = {GPIO3};
+static const unsigned pins_clkout3[] = {GPIO2};
+
+static const unsigned pins_pci_gnt1[] = {GPIO30};
+static const unsigned pins_pci_gnt2[] = {GPIO23};
+static const unsigned pins_pci_gnt3[] = {GPIO19};
+static const unsigned pins_pci_gnt4[] = {GPIO38};
+static const unsigned pins_pci_req1[] = {GPIO29};
+static const unsigned pins_pci_req2[] = {GPIO31};
+static const unsigned pins_pci_req3[] = {GPIO3};
+static const unsigned pins_pci_req4[] = {GPIO37};
+
+static const struct ltq_pin_group xway_grps[] = {
+	GRP_MUX("exin0", EXIN, pins_exin0),
+	GRP_MUX("exin1", EXIN, pins_exin1),
+	GRP_MUX("exin2", EXIN, pins_exin2),
+	GRP_MUX("jtag", JTAG, pins_jtag),
+	GRP_MUX("ebu a23", EBU, pins_ebu_a23),
+	GRP_MUX("ebu a24", EBU, pins_ebu_a24),
+	GRP_MUX("ebu a25", EBU, pins_ebu_a25),
+	GRP_MUX("ebu clk", EBU, pins_ebu_clk),
+	GRP_MUX("ebu cs1", EBU, pins_ebu_cs1),
+	GRP_MUX("ebu wait", EBU, pins_ebu_wait),
+	GRP_MUX("nand ale", EBU, pins_nand_ale),
+	GRP_MUX("nand cs1", EBU, pins_nand_cs1),
+	GRP_MUX("nand cle", EBU, pins_nand_cle),
+	GRP_MUX("spi", SPI, pins_spi),
+	GRP_MUX("spi_cs1", SPI, pins_spi_cs1),
+	GRP_MUX("spi_cs2", SPI, pins_spi_cs2),
+	GRP_MUX("spi_cs3", SPI, pins_spi_cs3),
+	GRP_MUX("spi_cs4", SPI, pins_spi_cs4),
+	GRP_MUX("spi_cs5", SPI, pins_spi_cs5),
+	GRP_MUX("spi_cs6", SPI, pins_spi_cs6),
+	GRP_MUX("asc0", ASC, pins_asc0),
+	GRP_MUX("asc0 cts rts", ASC, pins_asc0_cts_rts),
+	GRP_MUX("stp", STP, pins_stp),
+	GRP_MUX("nmi", NMI, pins_nmi),
+	GRP_MUX("gpt1", GPT, pins_gpt1),
+	GRP_MUX("gpt2", GPT, pins_gpt2),
+	GRP_MUX("gpt3", GPT, pins_gpt3),
+	GRP_MUX("clkout0", CGU, pins_clkout0),
+	GRP_MUX("clkout1", CGU, pins_clkout1),
+	GRP_MUX("clkout2", CGU, pins_clkout2),
+	GRP_MUX("clkout3", CGU, pins_clkout3),
+	GRP_MUX("gnt1", PCI, pins_pci_gnt1),
+	GRP_MUX("gnt2", PCI, pins_pci_gnt2),
+	GRP_MUX("gnt3", PCI, pins_pci_gnt3),
+	GRP_MUX("req1", PCI, pins_pci_req1),
+	GRP_MUX("req2", PCI, pins_pci_req2),
+	GRP_MUX("req3", PCI, pins_pci_req3),
+/* xrx only */
+	GRP_MUX("nand rdy", EBU, pins_nand_rdy),
+	GRP_MUX("nand rd", EBU, pins_nand_rd),
+	GRP_MUX("exin3", EXIN, pins_exin3),
+	GRP_MUX("exin4", EXIN, pins_exin4),
+	GRP_MUX("gnt4", PCI, pins_pci_gnt4),
+	GRP_MUX("req4", PCI, pins_pci_gnt4),
+};
+
+static const char * const xway_pci_grps[] = {"gnt1", "gnt2",
+						"gnt3", "req1",
+						"req2", "req3"};
+static const char * const xway_spi_grps[] = {"spi", "spi_cs1",
+						"spi_cs2", "spi_cs3",
+						"spi_cs4", "spi_cs5",
+						"spi_cs6"};
+static const char * const xway_cgu_grps[] = {"clkout0", "clkout1",
+						"clkout2", "clkout3"};
+static const char * const xway_ebu_grps[] = {"ebu a23", "ebu a24",
+						"ebu a25", "ebu cs1",
+						"ebu wait", "ebu clk",
+						"nand ale", "nand cs1",
+						"nand cle"};
+static const char * const xway_exin_grps[] = {"exin0", "exin1", "exin2"};
+static const char * const xway_gpt_grps[] = {"gpt1", "gpt2", "gpt3"};
+static const char * const xway_asc_grps[] = {"asc0", "asc0 cts rts"};
+static const char * const xway_jtag_grps[] = {"jtag"};
+static const char * const xway_stp_grps[] = {"stp"};
+static const char * const xway_nmi_grps[] = {"nmi"};
+
+/* ar9/vr9/gr9 */
+static const char * const xrx_ebu_grps[] = {"ebu a23", "ebu a24",
+						"ebu a25", "ebu cs1",
+						"ebu wait", "ebu clk",
+						"nand ale", "nand cs1",
+						"nand cle", "nand rdy",
+						"nand rd"};
+static const char * const xrx_exin_grps[] = {"exin0", "exin1", "exin2",
+						"exin3", "exin4"};
+static const char * const xrx_pci_grps[] = {"gnt1", "gnt2",
+						"gnt3", "gnt4",
+						"req1", "req2",
+						"req3", "req4"};
+
+static const struct ltq_pmx_func danube_funcs[] = {
+	{"spi",		ARRAY_AND_SIZE(xway_spi_grps)},
+	{"asc",		ARRAY_AND_SIZE(xway_asc_grps)},
+	{"cgu",		ARRAY_AND_SIZE(xway_cgu_grps)},
+	{"jtag",	ARRAY_AND_SIZE(xway_jtag_grps)},
+	{"exin",	ARRAY_AND_SIZE(xway_exin_grps)},
+	{"stp",		ARRAY_AND_SIZE(xway_stp_grps)},
+	{"gpt",		ARRAY_AND_SIZE(xway_gpt_grps)},
+	{"nmi",		ARRAY_AND_SIZE(xway_nmi_grps)},
+	{"pci",		ARRAY_AND_SIZE(xway_pci_grps)},
+	{"ebu",		ARRAY_AND_SIZE(xway_ebu_grps)},
+};
+
+static const struct ltq_pmx_func xrx_funcs[] = {
+	{"spi",		ARRAY_AND_SIZE(xway_spi_grps)},
+	{"asc",		ARRAY_AND_SIZE(xway_asc_grps)},
+	{"cgu",		ARRAY_AND_SIZE(xway_cgu_grps)},
+	{"jtag",	ARRAY_AND_SIZE(xway_jtag_grps)},
+	{"exin",	ARRAY_AND_SIZE(xrx_exin_grps)},
+	{"stp",		ARRAY_AND_SIZE(xway_stp_grps)},
+	{"gpt",		ARRAY_AND_SIZE(xway_gpt_grps)},
+	{"nmi",		ARRAY_AND_SIZE(xway_nmi_grps)},
+	{"pci",		ARRAY_AND_SIZE(xrx_pci_grps)},
+	{"ebu",		ARRAY_AND_SIZE(xrx_ebu_grps)},
+};
+
+
+
+
+
+
+/* ---------  pinconf related code --------- */
+static int xway_pinconf_group_get(struct pinctrl_dev *pctldev,
+				unsigned group,
+				unsigned long *config)
+{
+	return -ENOTSUPP;
+}
+
+static int xway_pinconf_group_set(struct pinctrl_dev *pctldev,
+				unsigned group,
+				unsigned long config)
+{
+	return -ENOTSUPP;
+}
+
+static int xway_pinconf_get(struct pinctrl_dev *pctldev,
+				unsigned pin,
+				unsigned long *config)
+{
+	struct ltq_pinmux_info *info = pinctrl_dev_get_drvdata(pctldev);
+	enum ltq_pinconf_param param = LTQ_PINCONF_UNPACK_PARAM(*config);
+	int port = PORT(pin);
+	u32 reg;
+
+	switch (param) {
+	case LTQ_PINCONF_PARAM_OPEN_DRAIN:
+		if (port == 3)
+			reg = GPIO3_OD;
+		else
+			reg = GPIO_OD(port);
+		*config = LTQ_PINCONF_PACK(param,
+			!!gpio_getbit(info->membase[0], reg, PORT_PIN(port)));
+		break;
+
+	case LTQ_PINCONF_PARAM_PULL:
+		if (port == 3)
+			reg = GPIO3_PUDEN;
+		else
+			reg = GPIO_PUDEN(port);
+		if (!gpio_getbit(info->membase[0], reg, PORT_PIN(port))) {
+			*config = LTQ_PINCONF_PACK(param, 0);
+			break;
+		}
+
+		if (port == 3)
+			reg = GPIO3_PUDSEL;
+		else
+			reg = GPIO_PUDSEL(port);
+		if (!gpio_getbit(info->membase[0], reg, PORT_PIN(port)))
+			*config = LTQ_PINCONF_PACK(param, 2);
+		else
+			*config = LTQ_PINCONF_PACK(param, 1);
+		break;
+
+	default:
+		pr_err("%s: Invalid config param %04x\n",
+					pinctrl_dev_get_name(pctldev), param);
+		return -ENOTSUPP;
+	}
+	return 0;
+}
+
+static int xway_pinconf_set(struct pinctrl_dev *pctldev,
+				unsigned pin,
+				unsigned long config)
+{
+	struct ltq_pinmux_info *info = pinctrl_dev_get_drvdata(pctldev);
+	enum ltq_pinconf_param param = LTQ_PINCONF_UNPACK_PARAM(config);
+	int arg = LTQ_PINCONF_UNPACK_ARG(config);
+	int port = PORT(pin);
+	u32 reg;
+
+	switch (param) {
+	case LTQ_PINCONF_PARAM_OPEN_DRAIN:
+		if (port == 3)
+			reg = GPIO3_OD;
+		else
+			reg = GPIO_OD(port);
+		gpio_setbit(info->membase[0], reg, PORT_PIN(port));
+		break;
+
+	case LTQ_PINCONF_PARAM_PULL:
+		if (port == 3)
+			reg = GPIO3_PUDEN;
+		else
+			reg = GPIO_PUDEN(port);
+		if (arg == 0) {
+			gpio_clearbit(info->membase[0], reg, PORT_PIN(port));
+			break;
+		}
+		gpio_setbit(info->membase[0], reg, PORT_PIN(port));
+
+		if (port == 3)
+			reg = GPIO3_PUDSEL;
+		else
+			reg = GPIO_PUDSEL(port);
+		if (arg == 1)
+			gpio_clearbit(info->membase[0], reg, PORT_PIN(port));
+		else if (arg == 2)
+			gpio_setbit(info->membase[0], reg, PORT_PIN(port));
+		else
+			pr_err("%s: Invalid pull value %d\n",
+				pinctrl_dev_get_name(pctldev), arg);
+		break;
+
+	default:
+		pr_err("%s: Invalid config param %04x\n",
+					pinctrl_dev_get_name(pctldev), param);
+		return -ENOTSUPP;
+	}
+	return 0;
+}
+
+static void xway_pinconf_dbg_show(struct pinctrl_dev *pctldev,
+					struct seq_file *s, unsigned offset)
+{
+}
+
+static void xway_pinconf_group_dbg_show(struct pinctrl_dev *pctldev,
+					struct seq_file *s, unsigned selector)
+{
+}
+
+struct pinconf_ops xway_pinconf_ops = {
+	.pin_config_get			= xway_pinconf_get,
+	.pin_config_set			= xway_pinconf_set,
+	.pin_config_group_get		= xway_pinconf_group_get,
+	.pin_config_group_set		= xway_pinconf_group_set,
+	.pin_config_dbg_show		= xway_pinconf_dbg_show,
+	.pin_config_group_dbg_show	= xway_pinconf_group_dbg_show,
+};
+
+static struct pinctrl_desc xway_pctrl_desc = {
+	.owner		= THIS_MODULE,
+	.confops	= &xway_pinconf_ops,
+};
+
+static inline int xway_mux_apply(struct pinctrl_dev *pctrldev,
+				int pin, int mux)
+{
+	struct ltq_pinmux_info *info = pinctrl_dev_get_drvdata(pctrldev);
+	int port = PORT(pin);
+
+	if (mux & 0x1)
+		gpio_setbit(info->membase[0], GPIO_ALT0(pin), PORT_PIN(pin));
+	else
+		gpio_clearbit(info->membase[0], GPIO_ALT0(pin), PORT_PIN(pin));
+
+	if ((port == 3) && (mux & 0x2))
+		gpio_setbit(info->membase[0], GPIO3_ALT1, PORT_PIN(pin));
+	else if (mux & 0x2)
+		gpio_setbit(info->membase[0], GPIO_ALT1(pin), PORT_PIN(pin));
+	else if (port == 3)
+		gpio_clearbit(info->membase[0], GPIO3_ALT1, PORT_PIN(pin));
+	else
+		gpio_clearbit(info->membase[0], GPIO_ALT1(pin), PORT_PIN(pin));
+
+	return 0;
+}
+
+static const struct ltq_cfg_param xway_cfg_params[] = {
+	{"lantiq,pull",		LTQ_PINCONF_PARAM_PULL},
+	{"lantiq,open-drain",	LTQ_PINCONF_PARAM_OPEN_DRAIN},
+};
+
+static struct ltq_pinmux_info xway_info = {
+	.mfp		= xway_mfp,
+	.desc		= &xway_pctrl_desc,
+	.apply_mux	= xway_mux_apply,
+	.params		= xway_cfg_params,
+	.num_params	= ARRAY_SIZE(xway_cfg_params),
+};
+
+
+
+
+/* ---------  gpio_chip related code --------- */
+
+int gpio_to_irq(unsigned int gpio)
+{
+	return -EINVAL;
+}
+EXPORT_SYMBOL(gpio_to_irq);
+
+int irq_to_gpio(unsigned int gpio)
+{
+	return -EINVAL;
+}
+EXPORT_SYMBOL(irq_to_gpio);
+
+static inline int xway_gpio_pin_count(void)
+{
+	if (of_machine_is_compatible("lantiq,ar9") ||
+			of_machine_is_compatible("lantiq,gr9") ||
+			of_machine_is_compatible("lantiq,vr9"))
+		return 56;
+	return 32;
+}
+
+static void xway_gpio_set(struct gpio_chip *chip, unsigned int pin, int val)
+{
+	struct ltq_pinmux_info *info = dev_get_drvdata(chip->dev);
+
+	if (val)
+		gpio_setbit(info->membase[0], GPIO_OUT(pin), PORT_PIN(pin));
+	else
+		gpio_clearbit(info->membase[0], GPIO_OUT(pin), PORT_PIN(pin));
+}
+
+static int xway_gpio_get(struct gpio_chip *chip, unsigned int pin)
+{
+	struct ltq_pinmux_info *info = dev_get_drvdata(chip->dev);
+
+	return gpio_getbit(info->membase[0], GPIO_IN(pin), PORT_PIN(pin));
+}
+
+static int xway_gpio_dir_in(struct gpio_chip *chip, unsigned int pin)
+{
+	struct ltq_pinmux_info *info = dev_get_drvdata(chip->dev);
+
+	gpio_clearbit(info->membase[0], GPIO_DIR(pin), PORT_PIN(pin));
+
+	return 0;
+}
+
+static int xway_gpio_dir_out(struct gpio_chip *chip, unsigned int pin, int val)
+{
+	struct ltq_pinmux_info *info = dev_get_drvdata(chip->dev);
+
+	gpio_setbit(info->membase[0], GPIO_DIR(pin), PORT_PIN(pin));
+	xway_gpio_set(chip, pin, val);
+
+	return 0;
+}
+
+static int xway_gpio_req(struct gpio_chip *chip, unsigned offset)
+{
+	int gpio = chip->base + offset;
+
+	return pinctrl_request_gpio(gpio);
+}
+
+static void xway_gpio_free(struct gpio_chip *chip, unsigned offset)
+{
+	int gpio = chip->base + offset;
+
+	pinctrl_free_gpio(gpio);
+}
+
+static struct gpio_chip xway_chip = {
+	.label = "gpio-xway",
+	.direction_input = xway_gpio_dir_in,
+	.direction_output = xway_gpio_dir_out,
+	.get = xway_gpio_get,
+	.set = xway_gpio_set,
+	.request = xway_gpio_req,
+	.free = xway_gpio_free,
+	.base = 0,
+};
+
+
+
+
+/* --------- register the pinctrl layer --------- */
+
+static struct pinctrl_gpio_range xway_gpio_range = {
+	.name	= "XWAY GPIO",
+	.id	= 0,
+	.base	= 0,
+	.gc	= &xway_chip,
+};
+
+static int __devinit pinmux_xway_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	int ret, i;
+
+	/* get and remap our register range */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "Failed to get resource\n");
+		return -ENOENT;
+	}
+	xway_info.membase[0] = devm_request_and_ioremap(&pdev->dev, res);
+	if (!xway_info.membase[0]) {
+		dev_err(&pdev->dev, "Failed to remap resource\n");
+		return -ENOMEM;
+	}
+
+	/* find out how many pads we have */
+	xway_chip.ngpio = xway_gpio_pin_count();
+
+	/* load our pad descriptors */
+	xway_info.pads = devm_kzalloc(&pdev->dev,
+			sizeof(struct pinctrl_pin_desc) * xway_chip.ngpio,
+			GFP_KERNEL);
+	if (!xway_info.pads) {
+		dev_err(&pdev->dev, "Failed to allocate pads\n");
+		return -ENOMEM;
+	}
+	for (i = 0; i < xway_chip.ngpio; i++) {
+		/* strlen("ioXY") + 1 = 5 */
+		char *name = devm_kzalloc(&pdev->dev, 5, GFP_KERNEL);
+
+		if (!name) {
+			dev_err(&pdev->dev, "Failed to allocate pad name\n");
+			return -ENOMEM;
+		}
+		snprintf(name, 5, "io%d", i);
+		xway_info.pads[i].number = GPIO0 + i;
+		xway_info.pads[i].name = name;
+	}
+	xway_pctrl_desc.pins = xway_info.pads;
+
+	/* load the gpio chip */
+	xway_chip.dev = &pdev->dev;
+	of_gpiochip_add(&xway_chip);
+	ret = gpiochip_add(&xway_chip);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register gpio chip\n");
+		return ret;
+	}
+
+	/* setup the data needed by pinctrl */
+	xway_pctrl_desc.name	= dev_name(&pdev->dev);
+	xway_pctrl_desc.npins	= xway_chip.ngpio;
+
+	xway_info.num_gpio	= xway_chip.ngpio;
+	xway_info.num_mfp	= xway_chip.ngpio;
+	xway_info.grps		= xway_grps;
+	xway_info.num_grps	= ARRAY_SIZE(xway_grps);
+	if (xway_gpio_pin_count() == 56) {
+		xway_info.funcs		= xrx_funcs;
+		xway_info.num_funcs	= ARRAY_SIZE(xrx_funcs);
+	} else {
+		xway_info.funcs		= danube_funcs;
+		xway_info.num_funcs	= ARRAY_SIZE(danube_funcs);
+	}
+
+	/* register with the generic lantiq layer */
+	ret = ltq_pinctrl_register(pdev, &xway_info);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register pinctrl driver\n");
+		return ret;
+	}
+
+	/* finish with registering the gpio range in pinctrl */
+	xway_gpio_range.npins = xway_chip.ngpio;
+	pinctrl_add_gpio_range(xway_info.pctrl, &xway_gpio_range);
+	dev_info(&pdev->dev, "Init done\n");
+	return 0;
+}
+
+static const struct of_device_id xway_match[] = {
+	{ .compatible = "lantiq,pinctrl-xway" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, xway_match);
+
+static struct platform_driver pinmux_xway_driver = {
+	.probe	= pinmux_xway_probe,
+	.driver = {
+		.name	= "pinctrl-xway",
+		.owner	= THIS_MODULE,
+		.of_match_table = xway_match,
+	},
+};
+
+static int __init pinmux_xway_init(void)
+{
+	return platform_driver_register(&pinmux_xway_driver);
+}
+
+core_initcall_sync(pinmux_xway_init);
-- 
1.7.9.1
