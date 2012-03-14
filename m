Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2012 10:33:28 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:42661 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903723Ab2CNJax (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Mar 2012 10:30:53 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 69D2323C00E0;
        Wed, 14 Mar 2012 10:00:09 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, juhosg@openwrt.org,
        Imre Kaloz <kaloz@openwrt.org>
Subject: [PATCH v3 08/12] MIPS: ath79: add support for the PCI host controller of the AR71XX SoCs
Date:   Wed, 14 Mar 2012 11:36:10 +0100
Message-Id: <1331721374-4144-9-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1331721374-4144-1-git-send-email-juhosg@openwrt.org>
References: <1331721374-4144-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 32687
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

The Atheros AR71XX SoCs have a built-in PCI Host Controller.
This patch adds a driver for that, and modifies the relevant
files in order to allow to register the PCI controller from
board specific setup.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
---
v3: - fix build error if PCI is disabled
v2: - add missing pci-ar71xx.c

 arch/mips/ath79/Kconfig                |    1 +
 arch/mips/include/asm/mach-ath79/pci.h |    6 +
 arch/mips/pci/Makefile                 |    1 +
 arch/mips/pci/pci-ar71xx.c             |  375 ++++++++++++++++++++++++++++++++
 4 files changed, 383 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/pci/pci-ar71xx.c

diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
index e0fae8f..bc6edad 100644
--- a/arch/mips/ath79/Kconfig
+++ b/arch/mips/ath79/Kconfig
@@ -52,6 +52,7 @@ endmenu
 config SOC_AR71XX
 	select USB_ARCH_HAS_EHCI
 	select USB_ARCH_HAS_OHCI
+	select HW_HAS_PCI
 	def_bool n
 
 config SOC_AR724X
diff --git a/arch/mips/include/asm/mach-ath79/pci.h b/arch/mips/include/asm/mach-ath79/pci.h
index 2eb0181..b12b087 100644
--- a/arch/mips/include/asm/mach-ath79/pci.h
+++ b/arch/mips/include/asm/mach-ath79/pci.h
@@ -11,6 +11,12 @@
 #ifndef __ASM_MACH_ATH79_PCI_H
 #define __ASM_MACH_ATH79_PCI_H
 
+#if defined(CONFIG_PCI) && defined(CONFIG_SOC_AR71XX)
+int ar71xx_pcibios_init(void);
+#else
+static inline int ar71xx_pcibios_init(void) { return 0; }
+#endif
+
 #if defined(CONFIG_PCI) && defined(CONFIG_SOC_AR724X)
 int ar724x_pcibios_init(int irq);
 #else
diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index 172277c..b1c0a1c 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_BCM47XX)		+= pci-bcm47xx.o
 obj-$(CONFIG_BCM63XX)		+= pci-bcm63xx.o fixup-bcm63xx.o \
 					ops-bcm63xx.o
 obj-$(CONFIG_MIPS_ALCHEMY)	+= pci-alchemy.o
+obj-$(CONFIG_SOC_AR71XX)	+= pci-ar71xx.o
 obj-$(CONFIG_SOC_AR724X)	+= pci-ar724x.o
 
 #
diff --git a/arch/mips/pci/pci-ar71xx.c b/arch/mips/pci/pci-ar71xx.c
new file mode 100644
index 0000000..1552522
--- /dev/null
+++ b/arch/mips/pci/pci-ar71xx.c
@@ -0,0 +1,375 @@
+/*
+ *  Atheros AR71xx PCI host controller driver
+ *
+ *  Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
+ *
+ *  Parts of this file are based on Atheros' 2.6.15 BSP
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ */
+
+#include <linux/resource.h>
+#include <linux/types.h>
+#include <linux/delay.h>
+#include <linux/bitops.h>
+#include <linux/pci.h>
+#include <linux/pci_regs.h>
+#include <linux/interrupt.h>
+
+#include <asm/mach-ath79/ar71xx_regs.h>
+#include <asm/mach-ath79/ath79.h>
+#include <asm/mach-ath79/pci.h>
+
+#define AR71XX_PCI_MEM_BASE	0x10000000
+#define AR71XX_PCI_MEM_SIZE	0x08000000
+
+#define AR71XX_PCI_WIN0_OFFS		0x10000000
+#define AR71XX_PCI_WIN1_OFFS		0x11000000
+#define AR71XX_PCI_WIN2_OFFS		0x12000000
+#define AR71XX_PCI_WIN3_OFFS		0x13000000
+#define AR71XX_PCI_WIN4_OFFS		0x14000000
+#define AR71XX_PCI_WIN5_OFFS		0x15000000
+#define AR71XX_PCI_WIN6_OFFS		0x16000000
+#define AR71XX_PCI_WIN7_OFFS		0x07000000
+
+#define AR71XX_PCI_CFG_BASE		\
+	(AR71XX_PCI_MEM_BASE + AR71XX_PCI_WIN7_OFFS + 0x10000)
+#define AR71XX_PCI_CFG_SIZE		0x100
+
+#define AR71XX_PCI_REG_CRP_AD_CBE	0x00
+#define AR71XX_PCI_REG_CRP_WRDATA	0x04
+#define AR71XX_PCI_REG_CRP_RDDATA	0x08
+#define AR71XX_PCI_REG_CFG_AD		0x0c
+#define AR71XX_PCI_REG_CFG_CBE		0x10
+#define AR71XX_PCI_REG_CFG_WRDATA	0x14
+#define AR71XX_PCI_REG_CFG_RDDATA	0x18
+#define AR71XX_PCI_REG_PCI_ERR		0x1c
+#define AR71XX_PCI_REG_PCI_ERR_ADDR	0x20
+#define AR71XX_PCI_REG_AHB_ERR		0x24
+#define AR71XX_PCI_REG_AHB_ERR_ADDR	0x28
+
+#define AR71XX_PCI_CRP_CMD_WRITE	0x00010000
+#define AR71XX_PCI_CRP_CMD_READ		0x00000000
+#define AR71XX_PCI_CFG_CMD_READ		0x0000000a
+#define AR71XX_PCI_CFG_CMD_WRITE	0x0000000b
+
+#define AR71XX_PCI_INT_CORE		BIT(4)
+#define AR71XX_PCI_INT_DEV2		BIT(2)
+#define AR71XX_PCI_INT_DEV1		BIT(1)
+#define AR71XX_PCI_INT_DEV0		BIT(0)
+
+#define AR71XX_PCI_IRQ_COUNT		5
+
+static DEFINE_SPINLOCK(ar71xx_pci_lock);
+static void __iomem *ar71xx_pcicfg_base;
+
+/* Byte lane enable bits */
+static const u8 ar71xx_pci_ble_table[4][4] = {
+	{0x0, 0xf, 0xf, 0xf},
+	{0xe, 0xd, 0xb, 0x7},
+	{0xc, 0xf, 0x3, 0xf},
+	{0xf, 0xf, 0xf, 0xf},
+};
+
+static const u32 ar71xx_pci_read_mask[8] = {
+	0, 0xff, 0xffff, 0, 0xffffffff, 0, 0, 0
+};
+
+static inline u32 ar71xx_pci_get_ble(int where, int size, int local)
+{
+	u32 t;
+
+	t = ar71xx_pci_ble_table[size & 3][where & 3];
+	BUG_ON(t == 0xf);
+	t <<= (local) ? 20 : 4;
+
+	return t;
+}
+
+static inline u32 ar71xx_pci_bus_addr(struct pci_bus *bus, unsigned int devfn,
+				      int where)
+{
+	u32 ret;
+
+	if (!bus->number) {
+		/* type 0 */
+		ret = (1 << PCI_SLOT(devfn)) | (PCI_FUNC(devfn) << 8) |
+		      (where & ~3);
+	} else {
+		/* type 1 */
+		ret = (bus->number << 16) | (PCI_SLOT(devfn) << 11) |
+		      (PCI_FUNC(devfn) << 8) | (where & ~3) | 1;
+	}
+
+	return ret;
+}
+
+static int ar71xx_pci_check_error(int quiet)
+{
+	void __iomem *base = ar71xx_pcicfg_base;
+	u32 pci_err;
+	u32 ahb_err;
+
+	pci_err = __raw_readl(base + AR71XX_PCI_REG_PCI_ERR) & 3;
+	if (pci_err) {
+		if (!quiet) {
+			u32 addr;
+
+			addr = __raw_readl(base + AR71XX_PCI_REG_PCI_ERR_ADDR);
+			pr_crit("ar71xx: %s bus error %d at addr 0x%x\n",
+				"PCI", pci_err, addr);
+		}
+
+		/* clear PCI error status */
+		__raw_writel(pci_err, base + AR71XX_PCI_REG_PCI_ERR);
+	}
+
+	ahb_err = __raw_readl(base + AR71XX_PCI_REG_AHB_ERR) & 1;
+	if (ahb_err) {
+		if (!quiet) {
+			u32 addr;
+
+			addr = __raw_readl(base + AR71XX_PCI_REG_AHB_ERR_ADDR);
+			pr_crit("ar71xx: %s bus error %d at addr 0x%x\n",
+				"AHB", ahb_err, addr);
+		}
+
+		/* clear AHB error status */
+		__raw_writel(ahb_err, base + AR71XX_PCI_REG_AHB_ERR);
+	}
+
+	return !!(ahb_err | pci_err);
+}
+
+static inline void ar71xx_pci_local_write(int where, int size, u32 value)
+{
+	void __iomem *base = ar71xx_pcicfg_base;
+	u32 ad_cbe;
+
+	value = value << (8 * (where & 3));
+
+	ad_cbe = AR71XX_PCI_CRP_CMD_WRITE | (where & ~3);
+	ad_cbe |= ar71xx_pci_get_ble(where, size, 1);
+
+	__raw_writel(ad_cbe, base + AR71XX_PCI_REG_CRP_AD_CBE);
+	__raw_writel(value, base + AR71XX_PCI_REG_CRP_WRDATA);
+}
+
+static inline int ar71xx_pci_set_cfgaddr(struct pci_bus *bus,
+					 unsigned int devfn,
+					 int where, int size, u32 cmd)
+{
+	void __iomem *base = ar71xx_pcicfg_base;
+	u32 addr;
+
+	addr = ar71xx_pci_bus_addr(bus, devfn, where);
+
+	__raw_writel(addr, base + AR71XX_PCI_REG_CFG_AD);
+	__raw_writel(cmd | ar71xx_pci_get_ble(where, size, 0),
+		     base + AR71XX_PCI_REG_CFG_CBE);
+
+	return ar71xx_pci_check_error(1);
+}
+
+static int ar71xx_pci_read_config(struct pci_bus *bus, unsigned int devfn,
+				  int where, int size, u32 *value)
+{
+	void __iomem *base = ar71xx_pcicfg_base;
+	unsigned long flags;
+	u32 data;
+	int err;
+	int ret;
+
+	ret = PCIBIOS_SUCCESSFUL;
+	data = ~0;
+
+	spin_lock_irqsave(&ar71xx_pci_lock, flags);
+
+	err = ar71xx_pci_set_cfgaddr(bus, devfn, where, size,
+				     AR71XX_PCI_CFG_CMD_READ);
+	if (err)
+		ret = PCIBIOS_DEVICE_NOT_FOUND;
+	else
+		data = __raw_readl(base + AR71XX_PCI_REG_CFG_RDDATA);
+
+	spin_unlock_irqrestore(&ar71xx_pci_lock, flags);
+
+	*value = (data >> (8 * (where & 3))) & ar71xx_pci_read_mask[size & 7];
+
+	return ret;
+}
+
+static int ar71xx_pci_write_config(struct pci_bus *bus, unsigned int devfn,
+				   int where, int size, u32 value)
+{
+	void __iomem *base = ar71xx_pcicfg_base;
+	unsigned long flags;
+	int err;
+	int ret;
+
+	value = value << (8 * (where & 3));
+	ret = PCIBIOS_SUCCESSFUL;
+
+	spin_lock_irqsave(&ar71xx_pci_lock, flags);
+
+	err = ar71xx_pci_set_cfgaddr(bus, devfn, where, size,
+				     AR71XX_PCI_CFG_CMD_WRITE);
+	if (err)
+		ret = PCIBIOS_DEVICE_NOT_FOUND;
+	else
+		__raw_writel(value, base + AR71XX_PCI_REG_CFG_WRDATA);
+
+	spin_unlock_irqrestore(&ar71xx_pci_lock, flags);
+
+	return ret;
+}
+
+static struct pci_ops ar71xx_pci_ops = {
+	.read	= ar71xx_pci_read_config,
+	.write	= ar71xx_pci_write_config,
+};
+
+static struct resource ar71xx_pci_io_resource = {
+	.name		= "PCI IO space",
+	.start		= 0,
+	.end		= 0,
+	.flags		= IORESOURCE_IO,
+};
+
+static struct resource ar71xx_pci_mem_resource = {
+	.name		= "PCI memory space",
+	.start		= AR71XX_PCI_MEM_BASE,
+	.end		= AR71XX_PCI_MEM_BASE + AR71XX_PCI_MEM_SIZE - 1,
+	.flags		= IORESOURCE_MEM
+};
+
+static struct pci_controller ar71xx_pci_controller = {
+	.pci_ops	= &ar71xx_pci_ops,
+	.mem_resource	= &ar71xx_pci_mem_resource,
+	.io_resource	= &ar71xx_pci_io_resource,
+};
+
+static void ar71xx_pci_irq_handler(unsigned int irq, struct irq_desc *desc)
+{
+	void __iomem *base = ath79_reset_base;
+	u32 pending;
+
+	pending = __raw_readl(base + AR71XX_RESET_REG_PCI_INT_STATUS) &
+		  __raw_readl(base + AR71XX_RESET_REG_PCI_INT_ENABLE);
+
+	if (pending & AR71XX_PCI_INT_DEV0)
+		generic_handle_irq(ATH79_PCI_IRQ(0));
+
+	else if (pending & AR71XX_PCI_INT_DEV1)
+		generic_handle_irq(ATH79_PCI_IRQ(1));
+
+	else if (pending & AR71XX_PCI_INT_DEV2)
+		generic_handle_irq(ATH79_PCI_IRQ(2));
+
+	else if (pending & AR71XX_PCI_INT_CORE)
+		generic_handle_irq(ATH79_PCI_IRQ(4));
+
+	else
+		spurious_interrupt();
+}
+
+static void ar71xx_pci_irq_unmask(struct irq_data *d)
+{
+	unsigned int irq = d->irq - ATH79_PCI_IRQ_BASE;
+	void __iomem *base = ath79_reset_base;
+	u32 t;
+
+	t = __raw_readl(base + AR71XX_RESET_REG_PCI_INT_ENABLE);
+	__raw_writel(t | (1 << irq), base + AR71XX_RESET_REG_PCI_INT_ENABLE);
+
+	/* flush write */
+	__raw_readl(base + AR71XX_RESET_REG_PCI_INT_ENABLE);
+}
+
+static void ar71xx_pci_irq_mask(struct irq_data *d)
+{
+	unsigned int irq = d->irq - ATH79_PCI_IRQ_BASE;
+	void __iomem *base = ath79_reset_base;
+	u32 t;
+
+	t = __raw_readl(base + AR71XX_RESET_REG_PCI_INT_ENABLE);
+	__raw_writel(t & ~(1 << irq), base + AR71XX_RESET_REG_PCI_INT_ENABLE);
+
+	/* flush write */
+	__raw_readl(base + AR71XX_RESET_REG_PCI_INT_ENABLE);
+}
+
+static struct irq_chip ar71xx_pci_irq_chip = {
+	.name		= "AR71XX PCI",
+	.irq_mask	= ar71xx_pci_irq_mask,
+	.irq_unmask	= ar71xx_pci_irq_unmask,
+	.irq_mask_ack	= ar71xx_pci_irq_mask,
+};
+
+static __init void ar71xx_pci_irq_init(void)
+{
+	void __iomem *base = ath79_reset_base;
+	int i;
+
+	__raw_writel(0, base + AR71XX_RESET_REG_PCI_INT_ENABLE);
+	__raw_writel(0, base + AR71XX_RESET_REG_PCI_INT_STATUS);
+
+	BUILD_BUG_ON(ATH79_PCI_IRQ_COUNT < AR71XX_PCI_IRQ_COUNT);
+
+	for (i = ATH79_PCI_IRQ_BASE;
+	     i < ATH79_PCI_IRQ_BASE + AR71XX_PCI_IRQ_COUNT; i++)
+		irq_set_chip_and_handler(i, &ar71xx_pci_irq_chip,
+					 handle_level_irq);
+
+	irq_set_chained_handler(ATH79_CPU_IRQ_IP2, ar71xx_pci_irq_handler);
+}
+
+static __init void ar71xx_pci_reset(void)
+{
+	void __iomem *ddr_base = ath79_ddr_base;
+
+	ath79_device_reset_set(AR71XX_RESET_PCI_BUS | AR71XX_RESET_PCI_CORE);
+	mdelay(100);
+
+	ath79_device_reset_clear(AR71XX_RESET_PCI_BUS | AR71XX_RESET_PCI_CORE);
+	mdelay(100);
+
+	__raw_writel(AR71XX_PCI_WIN0_OFFS, ddr_base + AR71XX_DDR_REG_PCI_WIN0);
+	__raw_writel(AR71XX_PCI_WIN1_OFFS, ddr_base + AR71XX_DDR_REG_PCI_WIN1);
+	__raw_writel(AR71XX_PCI_WIN2_OFFS, ddr_base + AR71XX_DDR_REG_PCI_WIN2);
+	__raw_writel(AR71XX_PCI_WIN3_OFFS, ddr_base + AR71XX_DDR_REG_PCI_WIN3);
+	__raw_writel(AR71XX_PCI_WIN4_OFFS, ddr_base + AR71XX_DDR_REG_PCI_WIN4);
+	__raw_writel(AR71XX_PCI_WIN5_OFFS, ddr_base + AR71XX_DDR_REG_PCI_WIN5);
+	__raw_writel(AR71XX_PCI_WIN6_OFFS, ddr_base + AR71XX_DDR_REG_PCI_WIN6);
+	__raw_writel(AR71XX_PCI_WIN7_OFFS, ddr_base + AR71XX_DDR_REG_PCI_WIN7);
+
+	mdelay(100);
+}
+
+__init int ar71xx_pcibios_init(void)
+{
+	u32 t;
+
+	ar71xx_pcicfg_base = ioremap(AR71XX_PCI_CFG_BASE, AR71XX_PCI_CFG_SIZE);
+	if (ar71xx_pcicfg_base == NULL)
+		return -ENOMEM;
+
+	ar71xx_pci_reset();
+
+	/* setup COMMAND register */
+	t = PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER | PCI_COMMAND_INVALIDATE
+	  | PCI_COMMAND_PARITY | PCI_COMMAND_SERR | PCI_COMMAND_FAST_BACK;
+	ar71xx_pci_local_write(PCI_COMMAND, 4, t);
+
+	/* clear bus errors */
+	ar71xx_pci_check_error(1);
+
+	ar71xx_pci_irq_init();
+
+	register_pci_controller(&ar71xx_pci_controller);
+
+	return 0;
+}
-- 
1.7.2.1
