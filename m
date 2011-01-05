Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Jan 2011 20:56:52 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:35669 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490983Ab1AETze (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 5 Jan 2011 20:55:34 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        linux-mips@linux-mips.org
Subject: [PATCH 03/10] MIPS: lantiq: add PCI controller support.
Date:   Wed,  5 Jan 2011 20:56:12 +0100
Message-Id: <1294257379-417-4-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1294257379-417-1-git-send-email-blogic@openwrt.org>
References: <1294257379-417-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28847
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips

The Lantiq family of SoCs have a EBU (External Bus Unit). This patch adds
the driver that allows us to use the EBU as a PCI controller. In order for
PCI to work the EBU is set to endianess swap all the data. In addition we
need to make use of SWAP_IO_SPACE for device->host DMA to work.

The clock of the PCI works in several modes (internal/external). If this
is not configured correctly the SoC will hang.

Currently only 1 pci irq pin is supported.

Signed-off-by: John Crispin <blogic@openwrt.org>
Signed-off-by: Ralph Hempel <ralph.hempel@lantiq.com>
Cc: linux-mips@linux-mips.org
---
 .../mips/include/asm/mach-lantiq/lantiq_platform.h |   25 ++
 arch/mips/pci/Makefile                             |    1 +
 arch/mips/pci/ops-lantiq.c                         |  118 ++++++++
 arch/mips/pci/pci-lantiq.c                         |  286 ++++++++++++++++++++
 arch/mips/pci/pci-lantiq.h                         |   18 ++
 5 files changed, 448 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-lantiq/lantiq_platform.h
 create mode 100644 arch/mips/pci/ops-lantiq.c
 create mode 100644 arch/mips/pci/pci-lantiq.c
 create mode 100644 arch/mips/pci/pci-lantiq.h

diff --git a/arch/mips/include/asm/mach-lantiq/lantiq_platform.h b/arch/mips/include/asm/mach-lantiq/lantiq_platform.h
new file mode 100644
index 0000000..c0d4c6c
--- /dev/null
+++ b/arch/mips/include/asm/mach-lantiq/lantiq_platform.h
@@ -0,0 +1,25 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ */
+
+#ifndef _LANTIQ_PLATFORM_H__
+#define _LANTIQ_PLATFORM_H__
+
+#include <linux/mtd/partitions.h>
+
+/* struct used to pass info to the pci core */
+enum {
+	PCI_CLOCK_INT = 0,
+	PCI_CLOCK_EXT
+};
+
+struct ltq_pci_data {
+	int clock;
+	int req_mask;
+};
+
+#endif
diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index c9209ca..4a5d1ae 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_ZAO_CAPCELLA)	+= fixup-capcella.o
 obj-$(CONFIG_WR_PPMC)		+= fixup-wrppmc.o
 obj-$(CONFIG_MIKROTIK_RB532)	+= pci-rc32434.o ops-rc32434.o fixup-rc32434.o
 obj-$(CONFIG_CPU_CAVIUM_OCTEON)	+= pci-octeon.o pcie-octeon.o
+obj-$(CONFIG_SOC_XWAY)	+= pci-lantiq.o ops-lantiq.o
 
 ifdef CONFIG_PCI_MSI
 obj-$(CONFIG_CPU_CAVIUM_OCTEON)	+= msi-octeon.o
diff --git a/arch/mips/pci/ops-lantiq.c b/arch/mips/pci/ops-lantiq.c
new file mode 100644
index 0000000..457c9f1
--- /dev/null
+++ b/arch/mips/pci/ops-lantiq.c
@@ -0,0 +1,118 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/mm.h>
+#include <asm/addrspace.h>
+#include <linux/vmalloc.h>
+
+#include <lantiq_soc.h>
+
+#include "pci-lantiq.h"
+
+#define LTQ_PCI_CFG_BUSNUM_SHF 16
+#define LTQ_PCI_CFG_DEVNUM_SHF 11
+#define LTQ_PCI_CFG_FUNNUM_SHF 8
+
+#define PCI_ACCESS_READ  0
+#define PCI_ACCESS_WRITE 1
+
+static int
+ltq_pci_config_access(unsigned char access_type, struct pci_bus *bus,
+	unsigned int devfn, unsigned int where, u32 *data)
+{
+	unsigned long cfg_base;
+	unsigned long flags;
+
+	u32 temp;
+
+	/* we support slot from 0 to 15 */
+	/* dev_fn 0&0x68 (AD29) is ifxmips itself */
+	if ((bus->number != 0) || ((devfn & 0xf8) > 0x78)
+			|| ((devfn & 0xf8) == 0) || ((devfn & 0xf8) == 0x68))
+		return 1;
+
+	spin_lock_irqsave(&ebu_lock, flags);
+
+	cfg_base = ltq_pci_mapped_cfg;
+	cfg_base |= (bus->number << LTQ_PCI_CFG_BUSNUM_SHF) | (devfn <<
+			LTQ_PCI_CFG_FUNNUM_SHF) | (where & ~0x3);
+
+	/* Perform access */
+	if (access_type == PCI_ACCESS_WRITE) {
+		ltq_w32(swab32(*data), ((u32 *)cfg_base));
+	} else {
+		*data = ltq_r32(((u32 *)(cfg_base)));
+		*data = swab32(*data);
+	}
+	wmb();
+
+	/* clean possible Master abort */
+	cfg_base = (ltq_pci_mapped_cfg | (0x0 << LTQ_PCI_CFG_FUNNUM_SHF)) + 4;
+	temp = ltq_r32(((u32 *)(cfg_base)));
+	temp = swab32(temp);
+	cfg_base = (ltq_pci_mapped_cfg | (0x68 << LTQ_PCI_CFG_FUNNUM_SHF)) + 4;
+	ltq_w32(temp, ((u32 *)cfg_base));
+
+	spin_unlock_irqrestore(&ebu_lock, flags);
+
+	if (((*data) == 0xffffffff) && (access_type == PCI_ACCESS_READ))
+		return 1;
+
+	return 0;
+}
+
+int
+ltq_pci_read_config_dword(struct pci_bus *bus, unsigned int devfn,
+		int where, int size, u32 *val)
+{
+	u32 data = 0;
+
+	if (ltq_pci_config_access(PCI_ACCESS_READ, bus, devfn, where, &data))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if (size == 1)
+		*val = (data >> ((where & 3) << 3)) & 0xff;
+	else if (size == 2)
+		*val = (data >> ((where & 3) << 3)) & 0xffff;
+	else
+		*val = data;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+int
+ltq_pci_write_config_dword(struct pci_bus *bus, unsigned int devfn,
+		int where, int size, u32 val)
+{
+	u32 data = 0;
+
+	if (size == 4) {
+		data = val;
+	} else {
+		if (ltq_pci_config_access(PCI_ACCESS_READ, bus,
+				devfn, where, &data))
+			return PCIBIOS_DEVICE_NOT_FOUND;
+
+		if (size == 1)
+			data = (data & ~(0xff << ((where & 3) << 3))) |
+				(val << ((where & 3) << 3));
+		else if (size == 2)
+			data = (data & ~(0xffff << ((where & 3) << 3))) |
+				(val << ((where & 3) << 3));
+	}
+
+	if (ltq_pci_config_access(PCI_ACCESS_WRITE, bus, devfn, where, &data))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	return PCIBIOS_SUCCESSFUL;
+}
diff --git a/arch/mips/pci/pci-lantiq.c b/arch/mips/pci/pci-lantiq.c
new file mode 100644
index 0000000..70f7c0f
--- /dev/null
+++ b/arch/mips/pci/pci-lantiq.c
@@ -0,0 +1,286 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/mm.h>
+#include <linux/vmalloc.h>
+#include <linux/platform_device.h>
+
+#include <asm/pci.h>
+#include <asm/gpio.h>
+#include <asm/addrspace.h>
+
+#include <lantiq_soc.h>
+#include <lantiq_irq.h>
+#include <lantiq_platform.h>
+
+#include "pci-lantiq.h"
+
+#define LTQ_PCI_CFG_BASE		0x17000000
+#define LTQ_PCI_CFG_SIZE		0x00008000
+#define LTQ_PCI_MEM_BASE		0x18000000
+#define LTQ_PCI_MEM_SIZE		0x02000000
+#define LTQ_PCI_IO_BASE		0x1AE00000
+#define LTQ_PCI_IO_SIZE		0x00200000
+
+#define PCI_CR_FCI_ADDR_MAP0	((u32 *)(PCI_CR_BASE_ADDR + 0x00C0))
+#define PCI_CR_FCI_ADDR_MAP1	((u32 *)(PCI_CR_BASE_ADDR + 0x00C4))
+#define PCI_CR_FCI_ADDR_MAP2	((u32 *)(PCI_CR_BASE_ADDR + 0x00C8))
+#define PCI_CR_FCI_ADDR_MAP3	((u32 *)(PCI_CR_BASE_ADDR + 0x00CC))
+#define PCI_CR_FCI_ADDR_MAP4	((u32 *)(PCI_CR_BASE_ADDR + 0x00D0))
+#define PCI_CR_FCI_ADDR_MAP5	((u32 *)(PCI_CR_BASE_ADDR + 0x00D4))
+#define PCI_CR_FCI_ADDR_MAP6	((u32 *)(PCI_CR_BASE_ADDR + 0x00D8))
+#define PCI_CR_FCI_ADDR_MAP7	((u32 *)(PCI_CR_BASE_ADDR + 0x00DC))
+#define PCI_CR_CLK_CTRL			((u32 *)(PCI_CR_BASE_ADDR + 0x0000))
+#define PCI_CR_PCI_MOD			((u32 *)(PCI_CR_BASE_ADDR + 0x0030))
+#define PCI_CR_PC_ARB			((u32 *)(PCI_CR_BASE_ADDR + 0x0080))
+#define PCI_CR_FCI_ADDR_MAP11hg	((u32 *)(PCI_CR_BASE_ADDR + 0x00E4))
+#define PCI_CR_BAR11MASK		((u32 *)(PCI_CR_BASE_ADDR + 0x0044))
+#define PCI_CR_BAR12MASK		((u32 *)(PCI_CR_BASE_ADDR + 0x0048))
+#define PCI_CR_BAR13MASK		((u32 *)(PCI_CR_BASE_ADDR + 0x004C))
+#define PCI_CS_BASE_ADDR1		((u32 *)(PCI_CS_BASE_ADDR + 0x0010))
+#define PCI_CR_PCI_ADDR_MAP11	((u32 *)(PCI_CR_BASE_ADDR + 0x0064))
+#define PCI_CR_FCI_BURST_LENGTH	((u32 *)(PCI_CR_BASE_ADDR + 0x00E8))
+#define PCI_CR_PCI_EOI			((u32 *)(PCI_CR_BASE_ADDR + 0x002C))
+#define PCI_CS_STS_CMD			((u32 *)(PCI_CS_BASE_ADDR + 0x0004))
+
+#define PCI_MASTER0_REQ_MASK_2BITS	8
+#define PCI_MASTER1_REQ_MASK_2BITS	10
+#define PCI_MASTER2_REQ_MASK_2BITS	12
+#define INTERNAL_ARB_ENABLE_BIT		0
+
+#define LTQ_CGU_IFCCR	((u32 *)(LTQ_CGU_BASE_ADDR + 0x0018))
+#define LTQ_CGU_PCICR	((u32 *)(LTQ_CGU_BASE_ADDR + 0x0034))
+
+u32 ltq_pci_mapped_cfg;
+
+int (*ltqpci_plat_dev_init)(struct pci_dev *dev) = NULL;
+
+/* Since the PCI REQ pins can be reused for other functionality, make it
+   possible to exclude those from interpretation by the PCI controller */
+static int ltq_pci_req_mask = 0xf;
+
+struct pci_ops ltq_pci_ops = {
+	.read = ltq_pci_read_config_dword,
+	.write = ltq_pci_write_config_dword
+};
+
+static struct resource pci_io_resource = {
+	.name = "pci io space",
+	.start = LTQ_PCI_IO_BASE,
+	.end = LTQ_PCI_IO_BASE + LTQ_PCI_IO_SIZE - 1,
+	.flags = IORESOURCE_IO
+};
+
+static struct resource pci_mem_resource = {
+	.name = "pci memory space",
+	.start = LTQ_PCI_MEM_BASE,
+	.end = LTQ_PCI_MEM_BASE + LTQ_PCI_MEM_SIZE - 1,
+	.flags = IORESOURCE_MEM
+};
+
+static struct pci_controller ltq_pci_controller = {
+	.pci_ops = &ltq_pci_ops,
+	.mem_resource = &pci_mem_resource,
+	.mem_offset	= 0x00000000UL,
+	.io_resource = &pci_io_resource,
+	.io_offset	= 0x00000000UL,
+};
+
+int
+pcibios_plat_dev_init(struct pci_dev *dev)
+{
+	u8 pin;
+
+	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
+	switch (pin) {
+	case 0:
+		break;
+	case 1:
+		/* falling edge level triggered:0x4
+		   low level:0xc, rising edge:0x2 */
+		ltq_w32(ltq_r32(LTQ_EBU_PCC_CON) | 0xc, LTQ_EBU_PCC_CON);
+		ltq_w32(ltq_r32(LTQ_EBU_PCC_IEN) | 0x10, LTQ_EBU_PCC_IEN);
+		break;
+	case 2:
+	case 3:
+	case 4:
+		printk(KERN_WARNING "interrupt pin %d not supported yet!\n",
+			pin);
+	default:
+		printk(KERN_WARNING "invalid interrupt pin %d\n", pin);
+		return 1;
+	}
+
+	if (ltqpci_plat_dev_init)
+		return ltqpci_plat_dev_init(dev);
+
+	return 0;
+}
+
+static u32
+ltq_calc_bar11mask(void)
+{
+	u32 mem, bar11mask;
+
+	/* BAR11MASK value depends on available memory on system. */
+	mem = num_physpages * PAGE_SIZE;
+	bar11mask = (0x0ffffff0 & ~((1 << (fls(mem) - 1)) - 1)) | 8;
+
+	return bar11mask;
+}
+
+static void
+ltq_pci_setup_clk(int external_clock)
+{
+	/* set clock to 33Mhz */
+	ltq_w32(ltq_r32(LTQ_CGU_IFCCR) & ~0xf00000, LTQ_CGU_IFCCR);
+	ltq_w32(ltq_r32(LTQ_CGU_IFCCR) | 0x800000,	LTQ_CGU_IFCCR);
+	if (external_clock) {
+		ltq_w32(ltq_r32(LTQ_CGU_IFCCR) & ~(1 << 16), LTQ_CGU_IFCCR);
+		ltq_w32((1 << 30), LTQ_CGU_PCICR);
+	} else {
+		ltq_w32(ltq_r32(LTQ_CGU_IFCCR) | (1 << 16), LTQ_CGU_IFCCR);
+		ltq_w32((1 << 31) | (1 << 30), LTQ_CGU_PCICR);
+	}
+}
+
+static void
+ltq_pci_setup_gpio(void)
+{
+	/* PCI reset line is gpio driven */
+	ltq_gpio_request(21, 0, 0, 1, "pci-reset");
+
+	/* PCI_REQ line */
+	ltq_gpio_request(29, 1, 0, 0, "pci-req");
+
+	/* PCI_GNT line */
+	ltq_gpio_request(30, 1, 0, 1, "pci-gnt");
+}
+
+static int __devinit
+ltq_pci_startup(void)
+{
+	u32 temp_buffer;
+
+	/* setup pci clock and gpis used by pci */
+	ltq_pci_setup_gpio();
+
+	/* enable auto-switching between PCI and EBU */
+	ltq_w32(0xa, PCI_CR_CLK_CTRL);
+
+	/* busy, i.e. configuration is not done, PCI access has to be retried */
+	ltq_w32(ltq_r32(PCI_CR_PCI_MOD) & ~(1 << 24), PCI_CR_PCI_MOD);
+	wmb();
+	/* BUS Master/IO/MEM access */
+	ltq_w32(ltq_r32(PCI_CS_STS_CMD) | 7, PCI_CS_STS_CMD);
+
+	/* enable external 2 PCI masters */
+	temp_buffer = ltq_r32(PCI_CR_PC_ARB);
+	temp_buffer &= (~(ltq_pci_req_mask << 16));
+	/* enable internal arbiter */
+	temp_buffer |= (1 << INTERNAL_ARB_ENABLE_BIT);
+	/* enable internal PCI master reqest */
+	temp_buffer &= (~(3 << PCI_MASTER0_REQ_MASK_2BITS));
+
+	/* enable EBU request */
+	temp_buffer &= (~(3 << PCI_MASTER1_REQ_MASK_2BITS));
+
+	/* enable all external masters request */
+	temp_buffer &= (~(3 << PCI_MASTER2_REQ_MASK_2BITS));
+	ltq_w32(temp_buffer, PCI_CR_PC_ARB);
+	wmb();
+
+	/* setup BAR memory regions */
+	ltq_w32(0x18000000, PCI_CR_FCI_ADDR_MAP0);
+	ltq_w32(0x18400000, PCI_CR_FCI_ADDR_MAP1);
+	ltq_w32(0x18800000, PCI_CR_FCI_ADDR_MAP2);
+	ltq_w32(0x18c00000, PCI_CR_FCI_ADDR_MAP3);
+	ltq_w32(0x19000000, PCI_CR_FCI_ADDR_MAP4);
+	ltq_w32(0x19400000, PCI_CR_FCI_ADDR_MAP5);
+	ltq_w32(0x19800000, PCI_CR_FCI_ADDR_MAP6);
+	ltq_w32(0x19c00000, PCI_CR_FCI_ADDR_MAP7);
+	ltq_w32(0x1ae00000, PCI_CR_FCI_ADDR_MAP11hg);
+	ltq_w32(ltq_calc_bar11mask(), PCI_CR_BAR11MASK);
+	ltq_w32(0, PCI_CR_PCI_ADDR_MAP11);
+	ltq_w32(0, PCI_CS_BASE_ADDR1);
+	/* both TX and RX endian swap are enabled */
+	ltq_w32(ltq_r32(PCI_CR_PCI_EOI) | 3, PCI_CR_PCI_EOI);
+	wmb();
+	ltq_w32(ltq_r32(PCI_CR_BAR12MASK) | 0x80000000, PCI_CR_BAR12MASK);
+	ltq_w32(ltq_r32(PCI_CR_BAR13MASK) | 0x80000000, PCI_CR_BAR13MASK);
+	/*use 8 dw burst length */
+	ltq_w32(0x303, PCI_CR_FCI_BURST_LENGTH);
+	ltq_w32(ltq_r32(PCI_CR_PCI_MOD) | (1 << 24), PCI_CR_PCI_MOD);
+	wmb();
+
+	/* toggle reset pin */
+	__gpio_set_value(21, 0);
+	wmb();
+	mdelay(1);
+	__gpio_set_value(21, 1);
+	return 0;
+}
+
+int __init
+pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	switch (slot) {
+	case 13:
+		/* IDSEL = AD29 --> USB Host Controller */
+		return INT_NUM_IM1_IRL0 + 17;
+	case 14:
+		/* IDSEL = AD30 --> mini PCI connector */
+		return INT_NUM_IM0_IRL0 + 22;
+	default:
+		printk(KERN_INFO "ltq_pci: no IRQ found for slot %d, pin %d\n",
+			slot, pin);
+		return 0;
+	}
+}
+
+static int __devinit
+ltq_pci_probe(struct platform_device *pdev)
+{
+	struct ltq_pci_data *ltq_pci_data =
+		(struct ltq_pci_data *) pdev->dev.platform_data;
+	pci_probe_only = 0;
+	ltq_pci_req_mask = ltq_pci_data->req_mask;
+	ltq_pci_setup_clk(ltq_pci_data->clock);
+	ltq_pci_startup();
+	ltq_pci_mapped_cfg =
+		(u32)ioremap_nocache(LTQ_PCI_CFG_BASE, LTQ_PCI_CFG_BASE);
+	ltq_pci_controller.io_map_base =
+		(unsigned long)ioremap(LTQ_PCI_IO_BASE, LTQ_PCI_IO_SIZE - 1);
+	register_pci_controller(&ltq_pci_controller);
+	return 0;
+}
+
+static struct platform_driver
+ltq_pci_driver = {
+	.probe = ltq_pci_probe,
+	.driver = {
+		.name = "ltq_pci",
+		.owner = THIS_MODULE,
+	},
+};
+
+int __init
+pcibios_init(void)
+{
+	int ret = platform_driver_register(&ltq_pci_driver);
+	if (ret)
+		printk(KERN_INFO "ltq_pci: Error registering platfom driver!");
+	return ret;
+}
+
+arch_initcall(pcibios_init);
diff --git a/arch/mips/pci/pci-lantiq.h b/arch/mips/pci/pci-lantiq.h
new file mode 100644
index 0000000..de75dd7
--- /dev/null
+++ b/arch/mips/pci/pci-lantiq.h
@@ -0,0 +1,18 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ */
+
+#ifndef _LTQ_PCI_H__
+#define _LTQ_PCI_H__
+
+extern u32 ltq_pci_mapped_cfg;
+extern int ltq_pci_read_config_dword(struct pci_bus *bus,
+	unsigned int devfn, int where, int size, u32 *val);
+extern int ltq_pci_write_config_dword(struct pci_bus *bus,
+	unsigned int devfn, int where, int size, u32 val);
+
+#endif
-- 
1.7.2.3
