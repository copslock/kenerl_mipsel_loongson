Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Oct 2014 11:43:55 +0200 (CEST)
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:49109
        "EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S27011062AbaJJJnxg6eNZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Oct 2014 11:43:53 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH] MIPS: ralink: add rt2880 pci driver
Date:   Fri, 10 Oct 2014 11:43:48 +0200
Message-Id: <1412934228-56554-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <blogic@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43198
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

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/pci/Makefile     |    1 +
 arch/mips/pci/pci-rt2880.c |  285 ++++++++++++++++++++++++++++++++++++++++++++
 arch/mips/ralink/Kconfig   |    1 +
 3 files changed, 287 insertions(+)
 create mode 100644 arch/mips/pci/pci-rt2880.c

diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index 6523d55..64a0caa 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_SIBYTE_BCM1x80)	+= pci-bcm1480.o pci-bcm1480ht.o
 obj-$(CONFIG_SNI_RM)		+= fixup-sni.o ops-sni.o
 obj-$(CONFIG_LANTIQ)		+= fixup-lantiq.o
 obj-$(CONFIG_PCI_LANTIQ)	+= pci-lantiq.o ops-lantiq.o
+obj-$(CONFIG_SOC_RT2880)	+= pci-rt2880.o
 obj-$(CONFIG_SOC_RT3883)	+= pci-rt3883.o
 obj-$(CONFIG_TANBAC_TB0219)	+= fixup-tb0219.o
 obj-$(CONFIG_TANBAC_TB0226)	+= fixup-tb0226.o
diff --git a/arch/mips/pci/pci-rt2880.c b/arch/mips/pci/pci-rt2880.c
new file mode 100644
index 0000000..a457494
--- /dev/null
+++ b/arch/mips/pci/pci-rt2880.c
@@ -0,0 +1,285 @@
+/*
+ *  Ralink RT288x SoC PCI register definitions
+ *
+ *  Copyright (C) 2009 John Crispin <blogic@openwrt.org>
+ *  Copyright (C) 2009 Gabor Juhos <juhosg@openwrt.org>
+ *
+ *  Parts of this file are based on Ralink's 2.6.21 BSP
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ */
+
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/io.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/of_irq.h>
+#include <linux/of_pci.h>
+
+#include <asm/mach-ralink/rt288x.h>
+
+#define RT2880_PCI_BASE		0x00440000
+#define RT288X_CPU_IRQ_PCI	4
+
+#define RT2880_PCI_MEM_BASE	0x20000000
+#define RT2880_PCI_MEM_SIZE	0x10000000
+#define RT2880_PCI_IO_BASE	0x00460000
+#define RT2880_PCI_IO_SIZE	0x00010000
+
+#define RT2880_PCI_REG_PCICFG_ADDR	0x00
+#define RT2880_PCI_REG_PCIMSK_ADDR	0x0c
+#define RT2880_PCI_REG_BAR0SETUP_ADDR	0x10
+#define RT2880_PCI_REG_IMBASEBAR0_ADDR	0x18
+#define RT2880_PCI_REG_CONFIG_ADDR	0x20
+#define RT2880_PCI_REG_CONFIG_DATA	0x24
+#define RT2880_PCI_REG_MEMBASE		0x28
+#define RT2880_PCI_REG_IOBASE		0x2c
+#define RT2880_PCI_REG_ID		0x30
+#define RT2880_PCI_REG_CLASS		0x34
+#define RT2880_PCI_REG_SUBID		0x38
+#define RT2880_PCI_REG_ARBCTL		0x80
+
+static void __iomem *rt2880_pci_base;
+static DEFINE_SPINLOCK(rt2880_pci_lock);
+
+static u32 rt2880_pci_reg_read(u32 reg)
+{
+	return readl(rt2880_pci_base + reg);
+}
+
+static void rt2880_pci_reg_write(u32 val, u32 reg)
+{
+	writel(val, rt2880_pci_base + reg);
+}
+
+static inline u32 rt2880_pci_get_cfgaddr(unsigned int bus, unsigned int slot,
+					 unsigned int func, unsigned int where)
+{
+	return ((bus << 16) | (slot << 11) | (func << 8) | (where & 0xfc) |
+		0x80000000);
+}
+
+static int rt2880_pci_config_read(struct pci_bus *bus, unsigned int devfn,
+				  int where, int size, u32 *val)
+{
+	unsigned long flags;
+	u32 address;
+	u32 data;
+
+	address = rt2880_pci_get_cfgaddr(bus->number, PCI_SLOT(devfn),
+					 PCI_FUNC(devfn), where);
+
+	spin_lock_irqsave(&rt2880_pci_lock, flags);
+	rt2880_pci_reg_write(address, RT2880_PCI_REG_CONFIG_ADDR);
+	data = rt2880_pci_reg_read(RT2880_PCI_REG_CONFIG_DATA);
+	spin_unlock_irqrestore(&rt2880_pci_lock, flags);
+
+	switch (size) {
+	case 1:
+		*val = (data >> ((where & 3) << 3)) & 0xff;
+		break;
+	case 2:
+		*val = (data >> ((where & 3) << 3)) & 0xffff;
+		break;
+	case 4:
+		*val = data;
+		break;
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int rt2880_pci_config_write(struct pci_bus *bus, unsigned int devfn,
+				   int where, int size, u32 val)
+{
+	unsigned long flags;
+	u32 address;
+	u32 data;
+
+	address = rt2880_pci_get_cfgaddr(bus->number, PCI_SLOT(devfn),
+					 PCI_FUNC(devfn), where);
+
+	spin_lock_irqsave(&rt2880_pci_lock, flags);
+	rt2880_pci_reg_write(address, RT2880_PCI_REG_CONFIG_ADDR);
+	data = rt2880_pci_reg_read(RT2880_PCI_REG_CONFIG_DATA);
+
+	switch (size) {
+	case 1:
+		data = (data & ~(0xff << ((where & 3) << 3))) |
+		       (val << ((where & 3) << 3));
+		break;
+	case 2:
+		data = (data & ~(0xffff << ((where & 3) << 3))) |
+		       (val << ((where & 3) << 3));
+		break;
+	case 4:
+		data = val;
+		break;
+	}
+
+	rt2880_pci_reg_write(data, RT2880_PCI_REG_CONFIG_DATA);
+	spin_unlock_irqrestore(&rt2880_pci_lock, flags);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static struct pci_ops rt2880_pci_ops = {
+	.read	= rt2880_pci_config_read,
+	.write	= rt2880_pci_config_write,
+};
+
+static struct resource rt2880_pci_mem_resource = {
+	.name	= "PCI MEM space",
+	.start	= RT2880_PCI_MEM_BASE,
+	.end	= RT2880_PCI_MEM_BASE + RT2880_PCI_MEM_SIZE - 1,
+	.flags	= IORESOURCE_MEM,
+};
+
+static struct resource rt2880_pci_io_resource = {
+	.name	= "PCI IO space",
+	.start	= RT2880_PCI_IO_BASE,
+	.end	= RT2880_PCI_IO_BASE + RT2880_PCI_IO_SIZE - 1,
+	.flags	= IORESOURCE_IO,
+};
+
+static struct pci_controller rt2880_pci_controller = {
+	.pci_ops	= &rt2880_pci_ops,
+	.mem_resource	= &rt2880_pci_mem_resource,
+	.io_resource	= &rt2880_pci_io_resource,
+};
+
+static inline u32 rt2880_pci_read_u32(unsigned long reg)
+{
+	unsigned long flags;
+	u32 address;
+	u32 ret;
+
+	address = rt2880_pci_get_cfgaddr(0, 0, 0, reg);
+
+	spin_lock_irqsave(&rt2880_pci_lock, flags);
+	rt2880_pci_reg_write(address, RT2880_PCI_REG_CONFIG_ADDR);
+	ret = rt2880_pci_reg_read(RT2880_PCI_REG_CONFIG_DATA);
+	spin_unlock_irqrestore(&rt2880_pci_lock, flags);
+
+	return ret;
+}
+
+static inline void rt2880_pci_write_u32(unsigned long reg, u32 val)
+{
+	unsigned long flags;
+	u32 address;
+
+	address = rt2880_pci_get_cfgaddr(0, 0, 0, reg);
+
+	spin_lock_irqsave(&rt2880_pci_lock, flags);
+	rt2880_pci_reg_write(address, RT2880_PCI_REG_CONFIG_ADDR);
+	rt2880_pci_reg_write(val, RT2880_PCI_REG_CONFIG_DATA);
+	spin_unlock_irqrestore(&rt2880_pci_lock, flags);
+}
+
+int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	u16 cmd;
+	int irq = -1;
+
+	if (dev->bus->number != 0)
+		return irq;
+
+	switch (PCI_SLOT(dev->devfn)) {
+	case 0x00:
+		rt2880_pci_write_u32(PCI_BASE_ADDRESS_0, 0x08000000);
+		(void) rt2880_pci_read_u32(PCI_BASE_ADDRESS_0);
+		break;
+	case 0x11:
+		irq = RT288X_CPU_IRQ_PCI;
+		break;
+	default:
+		pr_err("%s:%s[%d] trying to alloc unknown pci irq\n",
+		       __FILE__, __func__, __LINE__);
+		BUG();
+		break;
+	}
+
+	pci_write_config_byte((struct pci_dev *) dev,
+		PCI_CACHE_LINE_SIZE, 0x14);
+	pci_write_config_byte((struct pci_dev *) dev, PCI_LATENCY_TIMER, 0xFF);
+	pci_read_config_word((struct pci_dev *) dev, PCI_COMMAND, &cmd);
+	cmd |= PCI_COMMAND_MASTER | PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
+		PCI_COMMAND_INVALIDATE | PCI_COMMAND_FAST_BACK |
+		PCI_COMMAND_SERR | PCI_COMMAND_WAIT | PCI_COMMAND_PARITY;
+	pci_write_config_word((struct pci_dev *) dev, PCI_COMMAND, cmd);
+	pci_write_config_byte((struct pci_dev *) dev, PCI_INTERRUPT_LINE,
+			      dev->irq);
+	return irq;
+}
+
+static int rt288x_pci_probe(struct platform_device *pdev)
+{
+	void __iomem *io_map_base;
+	int i;
+
+	rt2880_pci_base = ioremap_nocache(RT2880_PCI_BASE, PAGE_SIZE);
+
+	io_map_base = ioremap(RT2880_PCI_IO_BASE, RT2880_PCI_IO_SIZE);
+	rt2880_pci_controller.io_map_base = (unsigned long) io_map_base;
+	set_io_port_base((unsigned long) io_map_base);
+
+	ioport_resource.start = RT2880_PCI_IO_BASE;
+	ioport_resource.end = RT2880_PCI_IO_BASE + RT2880_PCI_IO_SIZE - 1;
+
+	rt2880_pci_reg_write(0, RT2880_PCI_REG_PCICFG_ADDR);
+	for (i = 0; i < 0xfffff; i++)
+		;
+
+	rt2880_pci_reg_write(0x79, RT2880_PCI_REG_ARBCTL);
+	rt2880_pci_reg_write(0x07FF0001, RT2880_PCI_REG_BAR0SETUP_ADDR);
+	rt2880_pci_reg_write(RT2880_PCI_MEM_BASE, RT2880_PCI_REG_MEMBASE);
+	rt2880_pci_reg_write(RT2880_PCI_IO_BASE, RT2880_PCI_REG_IOBASE);
+	rt2880_pci_reg_write(0x08000000, RT2880_PCI_REG_IMBASEBAR0_ADDR);
+	rt2880_pci_reg_write(0x08021814, RT2880_PCI_REG_ID);
+	rt2880_pci_reg_write(0x00800001, RT2880_PCI_REG_CLASS);
+	rt2880_pci_reg_write(0x28801814, RT2880_PCI_REG_SUBID);
+	rt2880_pci_reg_write(0x000c0000, RT2880_PCI_REG_PCIMSK_ADDR);
+
+	rt2880_pci_write_u32(PCI_BASE_ADDRESS_0, 0x08000000);
+	(void) rt2880_pci_read_u32(PCI_BASE_ADDRESS_0);
+
+	register_pci_controller(&rt2880_pci_controller);
+	return 0;
+}
+
+int pcibios_plat_dev_init(struct pci_dev *dev)
+{
+	return 0;
+}
+
+static const struct of_device_id rt288x_pci_match[] = {
+	{ .compatible = "ralink,rt288x-pci" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rt288x_pci_match);
+
+static struct platform_driver rt288x_pci_driver = {
+	.probe = rt288x_pci_probe,
+	.driver = {
+		.name = "rt288x-pci",
+		.owner = THIS_MODULE,
+		.of_match_table = rt288x_pci_match,
+	},
+};
+
+int __init pcibios_init(void)
+{
+	int ret = platform_driver_register(&rt288x_pci_driver);
+
+	if (ret)
+		pr_info("rt288x-pci: Error registering platform driver!");
+
+	return ret;
+}
+
+arch_initcall(pcibios_init);
diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
index 186b209..4705678 100644
--- a/arch/mips/ralink/Kconfig
+++ b/arch/mips/ralink/Kconfig
@@ -21,6 +21,7 @@ choice
 	config SOC_RT288X
 		bool "RT288x"
 		select MIPS_L1_CACHE_SHIFT_4
+		select HW_HAS_PCI
 
 	config SOC_RT305X
 		bool "RT305x"
-- 
1.7.10.4
