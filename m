Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 May 2012 14:22:25 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:48626 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903680Ab2EDMUO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 May 2012 14:20:14 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH 07/14] MIPS: pci: convert lantiq driver to OF
Date:   Fri,  4 May 2012 14:18:32 +0200
Message-Id: <1336133919-26525-7-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1336133919-26525-1-git-send-email-blogic@openwrt.org>
References: <1336133919-26525-1-git-send-email-blogic@openwrt.org>
X-archive-position: 33145
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Implement support for OF inside the lantiq PCI driver. The patch also splits
pcibios_plat_dev_init and pcibios_map_irq out into their own file to accomodate
coexistance with the upcoming pcie driver.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/Kconfig     |    5 +-
 arch/mips/pci/Makefile       |    3 +-
 arch/mips/pci/fixup-lantiq.c |   40 ++++++++++
 arch/mips/pci/pci-lantiq.c   |  177 ++++++++++++++++++++----------------------
 4 files changed, 131 insertions(+), 94 deletions(-)
 create mode 100644 arch/mips/pci/fixup-lantiq.c

diff --git a/arch/mips/lantiq/Kconfig b/arch/mips/lantiq/Kconfig
index b86d942..c645b44 100644
--- a/arch/mips/lantiq/Kconfig
+++ b/arch/mips/lantiq/Kconfig
@@ -19,7 +19,6 @@ config SOC_XWAY
 	select HW_HAS_PCI
 endchoice
 
-
 choice
 	prompt "Devicetree"
 
@@ -28,4 +27,8 @@ config DT_EASY50712
 	depends on SOC_XWAY
 endchoice
 
+config PCI_LANTIQ
+	bool "PCI Support"
+	depends on SOC_XWAY && PCI
+
 endif
diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index c3ac4b0..499a019 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -41,7 +41,8 @@ obj-$(CONFIG_SIBYTE_SB1250)	+= fixup-sb1250.o pci-sb1250.o
 obj-$(CONFIG_SIBYTE_BCM112X)	+= fixup-sb1250.o pci-sb1250.o
 obj-$(CONFIG_SIBYTE_BCM1x80)	+= pci-bcm1480.o pci-bcm1480ht.o
 obj-$(CONFIG_SNI_RM)		+= fixup-sni.o ops-sni.o
-obj-$(CONFIG_SOC_XWAY)		+= pci-lantiq.o ops-lantiq.o
+obj-$(CONFIG_LANTIQ)		+= fixup-lantiq.o
+obj-$(CONFIG_PCI_LANTIQ)	+= pci-lantiq.o ops-lantiq.o
 obj-$(CONFIG_TANBAC_TB0219)	+= fixup-tb0219.o
 obj-$(CONFIG_TANBAC_TB0226)	+= fixup-tb0226.o
 obj-$(CONFIG_TANBAC_TB0287)	+= fixup-tb0287.o
diff --git a/arch/mips/pci/fixup-lantiq.c b/arch/mips/pci/fixup-lantiq.c
new file mode 100644
index 0000000..6c829df
--- /dev/null
+++ b/arch/mips/pci/fixup-lantiq.c
@@ -0,0 +1,40 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2012 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/of_irq.h>
+#include <linux/of_pci.h>
+
+int (*ltq_pci_plat_arch_init)(struct pci_dev *dev) = NULL;
+int (*ltq_pci_plat_dev_init)(struct pci_dev *dev) = NULL;
+
+int pcibios_plat_dev_init(struct pci_dev *dev)
+{
+	if (ltq_pci_plat_arch_init)
+		return ltq_pci_plat_arch_init(dev);
+
+	if (ltq_pci_plat_dev_init)
+		return ltq_pci_plat_dev_init(dev);
+
+	return 0;
+}
+
+int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	struct of_irq dev_irq;
+	int irq;
+
+	if (of_irq_map_pci(dev, &dev_irq)) {
+		dev_err(&dev->dev, "trying to map irq for unknown slot:%d pin:%d\n",
+			slot, pin);
+		return 0;
+	}
+	irq = irq_create_of_mapping(dev_irq.controller, dev_irq.specifier,
+					dev_irq.size);
+	dev_info(&dev->dev, "SLOT:%d PIN:%d IRQ:%d\n", slot, pin, irq);
+	return irq;
+}
diff --git a/arch/mips/pci/pci-lantiq.c b/arch/mips/pci/pci-lantiq.c
index 3418178..ea45353 100644
--- a/arch/mips/pci/pci-lantiq.c
+++ b/arch/mips/pci/pci-lantiq.c
@@ -13,8 +13,12 @@
 #include <linux/delay.h>
 #include <linux/mm.h>
 #include <linux/vmalloc.h>
-#include <linux/export.h>
-#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/of_platform.h>
+#include <linux/of_gpio.h>
+#include <linux/of_irq.h>
+#include <linux/of_pci.h>
 
 #include <asm/pci.h>
 #include <asm/gpio.h>
@@ -22,17 +26,9 @@
 
 #include <lantiq_soc.h>
 #include <lantiq_irq.h>
-#include <lantiq_platform.h>
 
 #include "pci-lantiq.h"
 
-#define LTQ_PCI_CFG_BASE		0x17000000
-#define LTQ_PCI_CFG_SIZE		0x00008000
-#define LTQ_PCI_MEM_BASE		0x18000000
-#define LTQ_PCI_MEM_SIZE		0x02000000
-#define LTQ_PCI_IO_BASE			0x1AE00000
-#define LTQ_PCI_IO_SIZE			0x00200000
-
 #define PCI_CR_FCI_ADDR_MAP0		0x00C0
 #define PCI_CR_FCI_ADDR_MAP1		0x00C4
 #define PCI_CR_FCI_ADDR_MAP2		0x00C8
@@ -71,50 +67,24 @@
 __iomem void *ltq_pci_mapped_cfg;
 static __iomem void *ltq_pci_membase;
 
-int (*ltqpci_plat_dev_init)(struct pci_dev *dev) = NULL;
-
-/* Since the PCI REQ pins can be reused for other functionality, make it
-   possible to exclude those from interpretation by the PCI controller */
-static int ltq_pci_req_mask = 0xf;
-
-static int *ltq_pci_irq_map;
-
-struct pci_ops ltq_pci_ops = {
+static int reset_gpio;
+static struct clk *clk_pci, *clk_external;
+static struct resource pci_io_resource;
+static struct resource pci_mem_resource;
+static struct pci_ops pci_ops = {
 	.read	= ltq_pci_read_config_dword,
 	.write	= ltq_pci_write_config_dword
 };
 
-static struct resource pci_io_resource = {
-	.name	= "pci io space",
-	.start	= LTQ_PCI_IO_BASE,
-	.end	= LTQ_PCI_IO_BASE + LTQ_PCI_IO_SIZE - 1,
-	.flags	= IORESOURCE_IO
-};
-
-static struct resource pci_mem_resource = {
-	.name	= "pci memory space",
-	.start	= LTQ_PCI_MEM_BASE,
-	.end	= LTQ_PCI_MEM_BASE + LTQ_PCI_MEM_SIZE - 1,
-	.flags	= IORESOURCE_MEM
-};
-
-static struct pci_controller ltq_pci_controller = {
-	.pci_ops	= &ltq_pci_ops,
+static struct pci_controller pci_controller = {
+	.pci_ops	= &pci_ops,
 	.mem_resource	= &pci_mem_resource,
 	.mem_offset	= 0x00000000UL,
 	.io_resource	= &pci_io_resource,
 	.io_offset	= 0x00000000UL,
 };
 
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
-	if (ltqpci_plat_dev_init)
-		return ltqpci_plat_dev_init(dev);
-
-	return 0;
-}
-
-static u32 ltq_calc_bar11mask(void)
+static inline u32 ltq_calc_bar11mask(void)
 {
 	u32 mem, bar11mask;
 
@@ -125,32 +95,42 @@ static u32 ltq_calc_bar11mask(void)
 	return bar11mask;
 }
 
-static int __devinit ltq_pci_startup(struct ltq_pci_data *conf)
+static int __devinit ltq_pci_startup(struct platform_device *pdev)
 {
+	struct device_node *node = pdev->dev.of_node;
+	const __be32 *req_mask, *bus_clk;
 	u32 temp_buffer;
 
-	/* set clock to 33Mhz */
-	if (ltq_is_ar9()) {
-		ltq_cgu_w32(ltq_cgu_r32(LTQ_CGU_IFCCR) & ~0x1f00000, LTQ_CGU_IFCCR);
-		ltq_cgu_w32(ltq_cgu_r32(LTQ_CGU_IFCCR) | 0xe00000, LTQ_CGU_IFCCR);
-	} else {
-		ltq_cgu_w32(ltq_cgu_r32(LTQ_CGU_IFCCR) & ~0xf00000, LTQ_CGU_IFCCR);
-		ltq_cgu_w32(ltq_cgu_r32(LTQ_CGU_IFCCR) | 0x800000, LTQ_CGU_IFCCR);
+	/* get our clocks */
+	clk_pci = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(clk_pci)) {
+		dev_err(&pdev->dev, "failed to get pci clock\n");
+		return PTR_ERR(clk_pci);
 	}
 
-	/* external or internal clock ? */
-	if (conf->clock) {
-		ltq_cgu_w32(ltq_cgu_r32(LTQ_CGU_IFCCR) & ~(1 << 16),
-			LTQ_CGU_IFCCR);
-		ltq_cgu_w32((1 << 30), LTQ_CGU_PCICR);
-	} else {
-		ltq_cgu_w32(ltq_cgu_r32(LTQ_CGU_IFCCR) | (1 << 16),
-			LTQ_CGU_IFCCR);
-		ltq_cgu_w32((1 << 31) | (1 << 30), LTQ_CGU_PCICR);
+	clk_external = clk_get(&pdev->dev, "external");
+	if (IS_ERR(clk_external)) {
+		clk_put(clk_pci);
+		dev_err(&pdev->dev, "failed to get external pci clock\n");
+		return PTR_ERR(clk_external);
 	}
 
-	/* setup pci clock and gpis used by pci */
-	gpio_request(21, "pci-reset");
+	/* read the bus speed that we want */
+	bus_clk = of_get_property(node, "lantiq,bus-clock", NULL);
+	if (bus_clk)
+		clk_set_rate(clk_pci, *bus_clk);
+
+	/* and enable the clocks */
+	clk_enable(clk_pci);
+	if (of_find_property(node, "lantiq,external-clock", NULL))
+		clk_enable(clk_external);
+	else
+		clk_disable(clk_external);
+
+	/* setup reset gpio used by pci */
+	reset_gpio = of_get_named_gpio(node, "gpio-reset", 0);
+	if (reset_gpio > 0)
+		devm_gpio_request(&pdev->dev, reset_gpio, "pci-reset");
 
 	/* enable auto-switching between PCI and EBU */
 	ltq_pci_w32(0xa, PCI_CR_CLK_CTRL);
@@ -163,7 +143,12 @@ static int __devinit ltq_pci_startup(struct ltq_pci_data *conf)
 
 	/* enable external 2 PCI masters */
 	temp_buffer = ltq_pci_r32(PCI_CR_PC_ARB);
-	temp_buffer &= (~(ltq_pci_req_mask << 16));
+	/* setup the request mask */
+	req_mask = of_get_property(node, "req-mask", NULL);
+	if (req_mask)
+		temp_buffer &= ~((*req_mask & 0xf) << 16);
+	else
+		temp_buffer &= ~0xf0000;
 	/* enable internal arbiter */
 	temp_buffer |= (1 << INTERNAL_ARB_ENABLE_BIT);
 	/* enable internal PCI master reqest */
@@ -207,47 +192,55 @@ static int __devinit ltq_pci_startup(struct ltq_pci_data *conf)
 	ltq_ebu_w32(ltq_ebu_r32(LTQ_EBU_PCC_IEN) | 0x10, LTQ_EBU_PCC_IEN);
 
 	/* toggle reset pin */
-	__gpio_set_value(21, 0);
-	wmb();
-	mdelay(1);
-	__gpio_set_value(21, 1);
-	return 0;
-}
-
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
-{
-	if (ltq_pci_irq_map[slot])
-		return ltq_pci_irq_map[slot];
-	printk(KERN_ERR "lq_pci: trying to map irq for unknown slot %d\n",
-		slot);
-
+	if (reset_gpio > 0) {
+		__gpio_set_value(reset_gpio, 0);
+		wmb();
+		mdelay(1);
+		__gpio_set_value(reset_gpio, 1);
+	}
 	return 0;
 }
 
 static int __devinit ltq_pci_probe(struct platform_device *pdev)
 {
-	struct ltq_pci_data *ltq_pci_data =
-		(struct ltq_pci_data *) pdev->dev.platform_data;
+	struct resource *res_cfg, *res_bridge;
 
 	pci_clear_flags(PCI_PROBE_ONLY);
-	ltq_pci_irq_map = ltq_pci_data->irq;
-	ltq_pci_membase = ioremap_nocache(PCI_CR_BASE_ADDR, PCI_CR_SIZE);
-	ltq_pci_mapped_cfg =
-		ioremap_nocache(LTQ_PCI_CFG_BASE, LTQ_PCI_CFG_BASE);
-	ltq_pci_controller.io_map_base =
-		(unsigned long)ioremap(LTQ_PCI_IO_BASE, LTQ_PCI_IO_SIZE - 1);
-	ltq_pci_startup(ltq_pci_data);
-	register_pci_controller(&ltq_pci_controller);
 
+	res_cfg = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	res_bridge = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!res_cfg || !res_bridge) {
+		dev_err(&pdev->dev, "missing memory reources\n");
+		return -EINVAL;
+	}
+
+	ltq_pci_membase = devm_request_and_ioremap(&pdev->dev, res_bridge);
+	ltq_pci_mapped_cfg = devm_request_and_ioremap(&pdev->dev, res_cfg);
+
+	if (!ltq_pci_membase || !ltq_pci_mapped_cfg) {
+		dev_err(&pdev->dev, "failed to remap resources\n");
+		return -ENOMEM;
+	}
+
+	ltq_pci_startup(pdev);
+
+	pci_load_of_ranges(&pci_controller, pdev->dev.of_node);
+	register_pci_controller(&pci_controller);
 	return 0;
 }
 
-static struct platform_driver
-ltq_pci_driver = {
+static const struct of_device_id ltq_pci_match[] = {
+	{ .compatible = "lantiq,pci-xway" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ltq_pci_match);
+
+static struct platform_driver ltq_pci_driver = {
 	.probe = ltq_pci_probe,
 	.driver = {
-		.name = "ltq_pci",
+		.name = "pci-xway",
 		.owner = THIS_MODULE,
+		.of_match_table = ltq_pci_match,
 	},
 };
 
@@ -255,7 +248,7 @@ int __init pcibios_init(void)
 {
 	int ret = platform_driver_register(&ltq_pci_driver);
 	if (ret)
-		printk(KERN_INFO "ltq_pci: Error registering platform driver!");
+		pr_info("pci-xway: Error registering platform driver!");
 	return ret;
 }
 
-- 
1.7.9.1
