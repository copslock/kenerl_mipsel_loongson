Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Aug 2013 14:03:48 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:42560 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6815748Ab3HWMDktCsJQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Aug 2013 14:03:40 +0200
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 593BD2804BA;
        Fri, 23 Aug 2013 14:02:59 +0200 (CEST)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Fri, 23 Aug 2013 14:02:59 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v3] MIPS: add driver for the built-in PCI controller of the RT3883 SoC
Date:   Fri, 23 Aug 2013 14:03:20 +0200
Message-Id: <1377259400-21211-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37656
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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

The Ralink RT3883 SoCs have a built-in PCI Host Controller
device. The patch adds a platform driver and device tree
binding documentation for that.

The patch also enables the HW_HAS_PCI config option. This
is required in order to be able to enable the PCI support.

Cc: devicetree@vger.kernel.org
Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Acked-by: John Crispin <blogic@openwrt.org>
---
Changes since v2:
  - fix compiler warning:

  CC      arch/mips/pci/pci-rt3883.o
  arch/mips/pci/pci-rt3883.c: In function 'rt3883_pci_probe':
  arch/mips/pci/pci-rt3883.c:458:4: warning: use of 'h' length modifier with 'a' type character [-Wformat]

Changes since v1:
  - change the 'status' property to optional in the binding doc
  - add board specific example to the binding doc

rt3883-pci: fix-build-warning

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 .../devicetree/bindings/pci/ralink,rt3883-pci.txt  |  190 ++++++
 arch/mips/pci/Makefile                             |    1 +
 arch/mips/pci/pci-rt3883.c                         |  636 ++++++++++++++++++++
 arch/mips/ralink/Kconfig                           |    1 +
 4 files changed, 828 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/ralink,rt3883-pci.txt
 create mode 100644 arch/mips/pci/pci-rt3883.c

diff --git a/Documentation/devicetree/bindings/pci/ralink,rt3883-pci.txt b/Documentation/devicetree/bindings/pci/ralink,rt3883-pci.txt
new file mode 100644
index 0000000..8e0a1eb
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/ralink,rt3883-pci.txt
@@ -0,0 +1,190 @@
+* Mediatek/Ralink RT3883 PCI controller
+
+1) Main node
+
+   Required properties:
+
+   - compatible: must be "ralink,rt3883-pci"
+
+   - reg: specifies the physical base address of the controller and
+     the length of the memory mapped region.
+
+   - #address-cells: specifies the number of cells needed to encode an
+     address. The value must be 1.
+
+   - #size-cells: specifies the number of cells used to represent the size
+     of an address. The value must be 1.
+
+   - ranges: specifies the translation between child address space and parent
+     address space
+
+  Optional properties:
+
+   - status: indicates the operational status of the device.
+     Value must be either "disabled" or "okay".
+
+2) Child nodes
+
+   The main node must have two child nodes which describes the built-in
+   interrupt controller and the PCI host bridge.
+
+   a) Interrupt controller:
+
+   Required properties:
+
+   - interrupt-controller: identifies the node as an interrupt controller
+
+   - #address-cells: specifies the number of cells needed to encode an
+     address. The value must be 0. As such, 'interrupt-map' nodes do not
+     have to specify a parent unit address.
+
+   - #interrupt-cells: specifies the number of cells needed to encode an
+     interrupt source. The value must be 1.
+
+   - interrupt-parent: the phandle for the interrupt controller that
+     services interrupts for this device.
+
+   - interrupts: specifies the interrupt source of the parent interrupt
+     controller. The format of the interrupt specifier depends on the
+     parent interrupt controller.
+
+   b) PCI host bridge:
+
+   Required properties:
+
+   - #address-cells: specifies the number of cells needed to encode an
+     address. The value must be 0.
+
+   - #size-cells: specifies the number of cells used to represent the size
+     of an address. The value must be 2.
+
+   - #interrupt-cells: specifies the number of cells needed to encode an
+     interrupt source. The value must be 1.
+
+   - device_type: must be "pci"
+
+   - bus-range: PCI bus numbers covered
+
+   - ranges: specifies the ranges for the PCI memory and I/O regions
+
+   - interrupt-map-mask,
+   - interrupt-map: standard PCI properties to define the mapping of the
+     PCI interface to interrupt numbers.
+
+   The PCI host bridge node migh have additional sub-nodes representing
+   the onboard PCI devices/PCI slots. Each such sub-node must have the
+   following mandatory properties:
+
+     - reg: used only for interrupt mapping, so only the first four bytes
+       are used to refer to the correct bus number and device number.
+
+     - device_type: must be "pci"
+
+   If a given sub-node represents a PCI bridge it must have following
+   mandatory properties as well:
+
+     - #address-cells: must be set to <3>
+
+     - #size-cells: must set to <2>
+
+     - #interrupt-cells: must be set to <1>
+
+     - interrupt-map-mask,
+     - interrupt-map: standard PCI properties to define the mapping of the
+       PCI interface to interrupt numbers.
+
+   Besides the required properties the sub-nodes may have these optional
+   properties:
+
+     - status: indicates the operational status of the sub-node.
+       Value must be either "disabled" or "okay".
+
+3) Example:
+
+   a) SoC specific dtsi file:
+
+	pci@10140000 {
+		compatible = "ralink,rt3883-pci";
+		reg = <0x10140000 0x20000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges; /* direct mapping */
+
+		status = "disabled";
+
+		pciintc: interrupt-controller {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+
+			interrupt-parent = <&cpuintc>;
+			interrupts = <4>;
+		};
+
+		host-bridge {
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+
+			device_type = "pci";
+
+			bus-range = <0 255>;
+			ranges = <
+				0x02000000 0 0x00000000 0x20000000 0 0x10000000 /* pci memory */
+				0x01000000 0 0x00000000 0x10160000 0 0x00010000 /* io space */
+			>;
+
+			interrupt-map-mask = <0xf800 0 0 7>;
+			interrupt-map = <
+				/* IDSEL 17 */
+				0x8800 0 0 1 &pciintc 18
+				0x8800 0 0 2 &pciintc 18
+				0x8800 0 0 3 &pciintc 18
+				0x8800 0 0 4 &pciintc 18
+				/* IDSEL 18 */
+				0x9000 0 0 1 &pciintc 19
+				0x9000 0 0 2 &pciintc 19
+				0x9000 0 0 3 &pciintc 19
+				0x9000 0 0 4 &pciintc 19
+			>;
+
+			pci-bridge@1 {
+				reg = <0x0800 0 0 0 0>;
+				device_type = "pci";
+				#interrupt-cells = <1>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+
+				interrupt-map-mask = <0x0 0 0 0>;
+				interrupt-map = <0x0 0 0 0 &pciintc 20>;
+
+				status = "disabled";
+			};
+
+			pci-slot@17 {
+				reg = <0x8800 0 0 0 0>;
+				device_type = "pci";
+
+				status = "disabled";
+			};
+
+			pci-slot@18 {
+				reg = <0x9000 0 0 0 0>;
+				device_type = "pci";
+
+				status = "disabled";
+			};
+		};
+	};
+
+   b) Board specific dts file:
+
+	pci@10140000 {
+		status = "okay";
+
+		host-bridge {
+			pci-bridge@1 {
+				status = "okay";
+			};
+		};
+	};
diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index c382042..719e455 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_SIBYTE_BCM1x80)	+= pci-bcm1480.o pci-bcm1480ht.o
 obj-$(CONFIG_SNI_RM)		+= fixup-sni.o ops-sni.o
 obj-$(CONFIG_LANTIQ)		+= fixup-lantiq.o
 obj-$(CONFIG_PCI_LANTIQ)	+= pci-lantiq.o ops-lantiq.o
+obj-$(CONFIG_SOC_RT3883)	+= pci-rt3883.o
 obj-$(CONFIG_TANBAC_TB0219)	+= fixup-tb0219.o
 obj-$(CONFIG_TANBAC_TB0226)	+= fixup-tb0226.o
 obj-$(CONFIG_TANBAC_TB0287)	+= fixup-tb0287.o
diff --git a/arch/mips/pci/pci-rt3883.c b/arch/mips/pci/pci-rt3883.c
new file mode 100644
index 0000000..95c9d41
--- /dev/null
+++ b/arch/mips/pci/pci-rt3883.c
@@ -0,0 +1,636 @@
+/*
+ *  Ralink RT3662/RT3883 SoC PCI support
+ *
+ *  Copyright (C) 2011-2013 Gabor Juhos <juhosg@openwrt.org>
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
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_pci.h>
+#include <linux/platform_device.h>
+
+#include <asm/mach-ralink/rt3883.h>
+#include <asm/mach-ralink/ralink_regs.h>
+
+#define RT3883_MEMORY_BASE		0x00000000
+#define RT3883_MEMORY_SIZE		0x02000000
+
+#define RT3883_PCI_REG_PCICFG		0x00
+#define   RT3883_PCICFG_P2P_BR_DEVNUM_M 0xf
+#define   RT3883_PCICFG_P2P_BR_DEVNUM_S 16
+#define   RT3883_PCICFG_PCIRST		BIT(1)
+#define RT3883_PCI_REG_PCIRAW		0x04
+#define RT3883_PCI_REG_PCIINT		0x08
+#define RT3883_PCI_REG_PCIENA		0x0c
+
+#define RT3883_PCI_REG_CFGADDR		0x20
+#define RT3883_PCI_REG_CFGDATA		0x24
+#define RT3883_PCI_REG_MEMBASE		0x28
+#define RT3883_PCI_REG_IOBASE		0x2c
+#define RT3883_PCI_REG_ARBCTL		0x80
+
+#define RT3883_PCI_REG_BASE(_x)		(0x1000 + (_x) * 0x1000)
+#define RT3883_PCI_REG_BAR0SETUP(_x)	(RT3883_PCI_REG_BASE((_x)) + 0x10)
+#define RT3883_PCI_REG_IMBASEBAR0(_x)	(RT3883_PCI_REG_BASE((_x)) + 0x18)
+#define RT3883_PCI_REG_ID(_x)		(RT3883_PCI_REG_BASE((_x)) + 0x30)
+#define RT3883_PCI_REG_CLASS(_x)	(RT3883_PCI_REG_BASE((_x)) + 0x34)
+#define RT3883_PCI_REG_SUBID(_x)	(RT3883_PCI_REG_BASE((_x)) + 0x38)
+#define RT3883_PCI_REG_STATUS(_x)	(RT3883_PCI_REG_BASE((_x)) + 0x50)
+
+#define RT3883_PCI_MODE_NONE	0
+#define RT3883_PCI_MODE_PCI	BIT(0)
+#define RT3883_PCI_MODE_PCIE	BIT(1)
+#define RT3883_PCI_MODE_BOTH	(RT3883_PCI_MODE_PCI | RT3883_PCI_MODE_PCIE)
+
+#define RT3883_PCI_IRQ_COUNT	32
+
+#define RT3883_P2P_BR_DEVNUM	1
+
+struct rt3883_pci_controller {
+	void __iomem *base;
+	spinlock_t lock;
+
+	struct device_node *intc_of_node;
+	struct irq_domain *irq_domain;
+
+	struct pci_controller pci_controller;
+	struct resource io_res;
+	struct resource mem_res;
+
+	bool pcie_ready;
+};
+
+static inline struct rt3883_pci_controller *
+pci_bus_to_rt3883_controller(struct pci_bus *bus)
+{
+	struct pci_controller *hose;
+
+	hose = (struct pci_controller *) bus->sysdata;
+	return container_of(hose, struct rt3883_pci_controller, pci_controller);
+}
+
+static inline u32 rt3883_pci_r32(struct rt3883_pci_controller *rpc,
+				 unsigned reg)
+{
+	return ioread32(rpc->base + reg);
+}
+
+static inline void rt3883_pci_w32(struct rt3883_pci_controller *rpc,
+				  u32 val, unsigned reg)
+{
+	iowrite32(val, rpc->base + reg);
+}
+
+static inline u32 rt3883_pci_get_cfgaddr(unsigned int bus, unsigned int slot,
+					 unsigned int func, unsigned int where)
+{
+	return (bus << 16) | (slot << 11) | (func << 8) | (where & 0xfc) |
+	       0x80000000;
+}
+
+static u32 rt3883_pci_read_cfg32(struct rt3883_pci_controller *rpc,
+			       unsigned bus, unsigned slot,
+			       unsigned func, unsigned reg)
+{
+	unsigned long flags;
+	u32 address;
+	u32 ret;
+
+	address = rt3883_pci_get_cfgaddr(bus, slot, func, reg);
+
+	spin_lock_irqsave(&rpc->lock, flags);
+	rt3883_pci_w32(rpc, address, RT3883_PCI_REG_CFGADDR);
+	ret = rt3883_pci_r32(rpc, RT3883_PCI_REG_CFGDATA);
+	spin_unlock_irqrestore(&rpc->lock, flags);
+
+	return ret;
+}
+
+static void rt3883_pci_write_cfg32(struct rt3883_pci_controller *rpc,
+				 unsigned bus, unsigned slot,
+				 unsigned func, unsigned reg, u32 val)
+{
+	unsigned long flags;
+	u32 address;
+
+	address = rt3883_pci_get_cfgaddr(bus, slot, func, reg);
+
+	spin_lock_irqsave(&rpc->lock, flags);
+	rt3883_pci_w32(rpc, address, RT3883_PCI_REG_CFGADDR);
+	rt3883_pci_w32(rpc, val, RT3883_PCI_REG_CFGDATA);
+	spin_unlock_irqrestore(&rpc->lock, flags);
+}
+
+static void rt3883_pci_irq_handler(unsigned int irq, struct irq_desc *desc)
+{
+	struct rt3883_pci_controller *rpc;
+	u32 pending;
+
+	rpc = irq_get_handler_data(irq);
+
+	pending = rt3883_pci_r32(rpc, RT3883_PCI_REG_PCIINT) &
+		  rt3883_pci_r32(rpc, RT3883_PCI_REG_PCIENA);
+
+	if (!pending) {
+		spurious_interrupt();
+		return;
+	}
+
+	while (pending) {
+		unsigned bit = __ffs(pending);
+
+		irq = irq_find_mapping(rpc->irq_domain, bit);
+		generic_handle_irq(irq);
+
+		pending &= ~BIT(bit);
+	}
+}
+
+static void rt3883_pci_irq_unmask(struct irq_data *d)
+{
+	struct rt3883_pci_controller *rpc;
+	u32 t;
+
+	rpc = irq_data_get_irq_chip_data(d);
+
+	t = rt3883_pci_r32(rpc, RT3883_PCI_REG_PCIENA);
+	rt3883_pci_w32(rpc, t | BIT(d->hwirq), RT3883_PCI_REG_PCIENA);
+	/* flush write */
+	rt3883_pci_r32(rpc, RT3883_PCI_REG_PCIENA);
+}
+
+static void rt3883_pci_irq_mask(struct irq_data *d)
+{
+	struct rt3883_pci_controller *rpc;
+	u32 t;
+
+	rpc = irq_data_get_irq_chip_data(d);
+
+	t = rt3883_pci_r32(rpc, RT3883_PCI_REG_PCIENA);
+	rt3883_pci_w32(rpc, t & ~BIT(d->hwirq), RT3883_PCI_REG_PCIENA);
+	/* flush write */
+	rt3883_pci_r32(rpc, RT3883_PCI_REG_PCIENA);
+}
+
+static struct irq_chip rt3883_pci_irq_chip = {
+	.name		= "RT3883 PCI",
+	.irq_mask	= rt3883_pci_irq_mask,
+	.irq_unmask	= rt3883_pci_irq_unmask,
+	.irq_mask_ack	= rt3883_pci_irq_mask,
+};
+
+static int rt3883_pci_irq_map(struct irq_domain *d, unsigned int irq,
+			      irq_hw_number_t hw)
+{
+	irq_set_chip_and_handler(irq, &rt3883_pci_irq_chip, handle_level_irq);
+	irq_set_chip_data(irq, d->host_data);
+
+	return 0;
+}
+
+static const struct irq_domain_ops rt3883_pci_irq_domain_ops = {
+	.map = rt3883_pci_irq_map,
+	.xlate = irq_domain_xlate_onecell,
+};
+
+static int rt3883_pci_irq_init(struct device *dev,
+			       struct rt3883_pci_controller *rpc)
+{
+	int irq;
+
+	irq = irq_of_parse_and_map(rpc->intc_of_node, 0);
+	if (irq == 0) {
+		dev_err(dev, "%s has no IRQ",
+			of_node_full_name(rpc->intc_of_node));
+		return -EINVAL;
+	}
+
+	/* disable all interrupts */
+	rt3883_pci_w32(rpc, 0, RT3883_PCI_REG_PCIENA);
+
+	rpc->irq_domain =
+		irq_domain_add_linear(rpc->intc_of_node, RT3883_PCI_IRQ_COUNT,
+				      &rt3883_pci_irq_domain_ops,
+				      rpc);
+	if (!rpc->irq_domain) {
+		dev_err(dev, "unable to add IRQ domain\n");
+		return -ENODEV;
+	}
+
+	irq_set_handler_data(irq, rpc);
+	irq_set_chained_handler(irq, rt3883_pci_irq_handler);
+
+	return 0;
+}
+
+static int rt3883_pci_config_read(struct pci_bus *bus, unsigned int devfn,
+				  int where, int size, u32 *val)
+{
+	struct rt3883_pci_controller *rpc;
+	unsigned long flags;
+	u32 address;
+	u32 data;
+
+	rpc = pci_bus_to_rt3883_controller(bus);
+
+	if (!rpc->pcie_ready && bus->number == 1)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	address = rt3883_pci_get_cfgaddr(bus->number, PCI_SLOT(devfn),
+					 PCI_FUNC(devfn), where);
+
+	spin_lock_irqsave(&rpc->lock, flags);
+	rt3883_pci_w32(rpc, address, RT3883_PCI_REG_CFGADDR);
+	data = rt3883_pci_r32(rpc, RT3883_PCI_REG_CFGDATA);
+	spin_unlock_irqrestore(&rpc->lock, flags);
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
+static int rt3883_pci_config_write(struct pci_bus *bus, unsigned int devfn,
+				   int where, int size, u32 val)
+{
+	struct rt3883_pci_controller *rpc;
+	unsigned long flags;
+	u32 address;
+	u32 data;
+
+	rpc = pci_bus_to_rt3883_controller(bus);
+
+	if (!rpc->pcie_ready && bus->number == 1)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	address = rt3883_pci_get_cfgaddr(bus->number, PCI_SLOT(devfn),
+					 PCI_FUNC(devfn), where);
+
+	spin_lock_irqsave(&rpc->lock, flags);
+	rt3883_pci_w32(rpc, address, RT3883_PCI_REG_CFGADDR);
+	data = rt3883_pci_r32(rpc, RT3883_PCI_REG_CFGDATA);
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
+	rt3883_pci_w32(rpc, data, RT3883_PCI_REG_CFGDATA);
+	spin_unlock_irqrestore(&rpc->lock, flags);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static struct pci_ops rt3883_pci_ops = {
+	.read	= rt3883_pci_config_read,
+	.write	= rt3883_pci_config_write,
+};
+
+static void rt3883_pci_preinit(struct rt3883_pci_controller *rpc, unsigned mode)
+{
+	u32 syscfg1;
+	u32 rstctrl;
+	u32 clkcfg1;
+	u32 t;
+
+	rstctrl = rt_sysc_r32(RT3883_SYSC_REG_RSTCTRL);
+	syscfg1 = rt_sysc_r32(RT3883_SYSC_REG_SYSCFG1);
+	clkcfg1 = rt_sysc_r32(RT3883_SYSC_REG_CLKCFG1);
+
+	if (mode & RT3883_PCI_MODE_PCIE) {
+		rstctrl |= RT3883_RSTCTRL_PCIE;
+		rt_sysc_w32(rstctrl, RT3883_SYSC_REG_RSTCTRL);
+
+		/* setup PCI PAD drive mode */
+		syscfg1 &= ~(0x30);
+		syscfg1 |= (2 << 4);
+		rt_sysc_w32(syscfg1, RT3883_SYSC_REG_SYSCFG1);
+
+		t = rt_sysc_r32(RT3883_SYSC_REG_PCIE_CLK_GEN0);
+		t &= ~BIT(31);
+		rt_sysc_w32(t, RT3883_SYSC_REG_PCIE_CLK_GEN0);
+
+		t = rt_sysc_r32(RT3883_SYSC_REG_PCIE_CLK_GEN1);
+		t &= 0x80ffffff;
+		rt_sysc_w32(t, RT3883_SYSC_REG_PCIE_CLK_GEN1);
+
+		t = rt_sysc_r32(RT3883_SYSC_REG_PCIE_CLK_GEN1);
+		t |= 0xa << 24;
+		rt_sysc_w32(t, RT3883_SYSC_REG_PCIE_CLK_GEN1);
+
+		t = rt_sysc_r32(RT3883_SYSC_REG_PCIE_CLK_GEN0);
+		t |= BIT(31);
+		rt_sysc_w32(t, RT3883_SYSC_REG_PCIE_CLK_GEN0);
+
+		msleep(50);
+
+		rstctrl &= ~RT3883_RSTCTRL_PCIE;
+		rt_sysc_w32(rstctrl, RT3883_SYSC_REG_RSTCTRL);
+	}
+
+	syscfg1 |= (RT3883_SYSCFG1_PCIE_RC_MODE | RT3883_SYSCFG1_PCI_HOST_MODE);
+
+	clkcfg1 &= ~(RT3883_CLKCFG1_PCI_CLK_EN | RT3883_CLKCFG1_PCIE_CLK_EN);
+
+	if (mode & RT3883_PCI_MODE_PCI) {
+		clkcfg1 |= RT3883_CLKCFG1_PCI_CLK_EN;
+		rstctrl &= ~RT3883_RSTCTRL_PCI;
+	}
+
+	if (mode & RT3883_PCI_MODE_PCIE) {
+		clkcfg1 |= RT3883_CLKCFG1_PCIE_CLK_EN;
+		rstctrl &= ~RT3883_RSTCTRL_PCIE;
+	}
+
+	rt_sysc_w32(syscfg1, RT3883_SYSC_REG_SYSCFG1);
+	rt_sysc_w32(rstctrl, RT3883_SYSC_REG_RSTCTRL);
+	rt_sysc_w32(clkcfg1, RT3883_SYSC_REG_CLKCFG1);
+
+	msleep(500);
+
+	/*
+	 * setup the device number of the P2P bridge
+	 * and de-assert the reset line
+	 */
+	t = (RT3883_P2P_BR_DEVNUM << RT3883_PCICFG_P2P_BR_DEVNUM_S);
+	rt3883_pci_w32(rpc, t, RT3883_PCI_REG_PCICFG);
+
+	/* flush write */
+	rt3883_pci_r32(rpc, RT3883_PCI_REG_PCICFG);
+	msleep(500);
+
+	if (mode & RT3883_PCI_MODE_PCIE) {
+		msleep(500);
+
+		t = rt3883_pci_r32(rpc, RT3883_PCI_REG_STATUS(1));
+
+		rpc->pcie_ready = t & BIT(0);
+
+		if (!rpc->pcie_ready) {
+			/* reset the PCIe block */
+			t = rt_sysc_r32(RT3883_SYSC_REG_RSTCTRL);
+			t |= RT3883_RSTCTRL_PCIE;
+			rt_sysc_w32(t, RT3883_SYSC_REG_RSTCTRL);
+			t &= ~RT3883_RSTCTRL_PCIE;
+			rt_sysc_w32(t, RT3883_SYSC_REG_RSTCTRL);
+
+			/* turn off PCIe clock */
+			t = rt_sysc_r32(RT3883_SYSC_REG_CLKCFG1);
+			t &= ~RT3883_CLKCFG1_PCIE_CLK_EN;
+			rt_sysc_w32(t, RT3883_SYSC_REG_CLKCFG1);
+
+			t = rt_sysc_r32(RT3883_SYSC_REG_PCIE_CLK_GEN0);
+			t &= ~0xf000c080;
+			rt_sysc_w32(t, RT3883_SYSC_REG_PCIE_CLK_GEN0);
+		}
+	}
+
+	/* enable PCI arbiter */
+	rt3883_pci_w32(rpc, 0x79, RT3883_PCI_REG_ARBCTL);
+}
+
+static int rt3883_pci_probe(struct platform_device *pdev)
+{
+	struct rt3883_pci_controller *rpc;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct resource *res;
+	struct device_node *child;
+	u32 val;
+	int err;
+	int mode;
+
+	rpc = devm_kzalloc(dev, sizeof(*rpc), GFP_KERNEL);
+	if (!rpc)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
+
+	rpc->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(rpc->base))
+		return PTR_ERR(rpc->base);
+
+	/* find the interrupt controller child node */
+	for_each_child_of_node(np, child) {
+		if (of_get_property(child, "interrupt-controller", NULL) &&
+		    of_node_get(child)) {
+			rpc->intc_of_node = child;
+			break;
+		}
+	}
+
+	if (!rpc->intc_of_node) {
+		dev_err(dev, "%s has no %s child node",
+			of_node_full_name(rpc->intc_of_node),
+			"interrupt controller");
+		return -EINVAL;
+	}
+
+	/* find the PCI host bridge child node */
+	for_each_child_of_node(np, child) {
+		if (child->type &&
+		    of_node_cmp(child->type, "pci") == 0 &&
+		    of_node_get(child)) {
+			rpc->pci_controller.of_node = child;
+			break;
+		}
+	}
+
+	if (!rpc->pci_controller.of_node) {
+		dev_err(dev, "%s has no %s child node",
+			of_node_full_name(rpc->intc_of_node),
+			"PCI host bridge");
+		err = -EINVAL;
+		goto err_put_intc_node;
+	}
+
+	mode = RT3883_PCI_MODE_NONE;
+	for_each_available_child_of_node(rpc->pci_controller.of_node, child) {
+		int devfn;
+
+		if (!child->type ||
+		    of_node_cmp(child->type, "pci") != 0)
+			continue;
+
+		devfn = of_pci_get_devfn(child);
+		if (devfn < 0)
+			continue;
+
+		switch (PCI_SLOT(devfn)) {
+		case 1:
+			mode |= RT3883_PCI_MODE_PCIE;
+			break;
+
+		case 17:
+		case 18:
+			mode |= RT3883_PCI_MODE_PCI;
+			break;
+		}
+	}
+
+	if (mode == RT3883_PCI_MODE_NONE) {
+		dev_err(dev, "unable to determine PCI mode\n");
+		err = -EINVAL;
+		goto err_put_hb_node;
+	}
+
+	dev_info(dev, "mode:%s%s\n",
+		 (mode & RT3883_PCI_MODE_PCI) ? " PCI" : "",
+		 (mode & RT3883_PCI_MODE_PCIE) ? " PCIe" : "");
+
+	rt3883_pci_preinit(rpc, mode);
+
+	rpc->pci_controller.pci_ops = &rt3883_pci_ops;
+	rpc->pci_controller.io_resource = &rpc->io_res;
+	rpc->pci_controller.mem_resource = &rpc->mem_res;
+
+	/* Load PCI I/O and memory resources from DT */
+	pci_load_of_ranges(&rpc->pci_controller,
+			   rpc->pci_controller.of_node);
+
+	rt3883_pci_w32(rpc, rpc->mem_res.start, RT3883_PCI_REG_MEMBASE);
+	rt3883_pci_w32(rpc, rpc->io_res.start, RT3883_PCI_REG_IOBASE);
+
+	ioport_resource.start = rpc->io_res.start;
+	ioport_resource.end = rpc->io_res.end;
+
+	/* PCI */
+	rt3883_pci_w32(rpc, 0x03ff0000, RT3883_PCI_REG_BAR0SETUP(0));
+	rt3883_pci_w32(rpc, RT3883_MEMORY_BASE, RT3883_PCI_REG_IMBASEBAR0(0));
+	rt3883_pci_w32(rpc, 0x08021814, RT3883_PCI_REG_ID(0));
+	rt3883_pci_w32(rpc, 0x00800001, RT3883_PCI_REG_CLASS(0));
+	rt3883_pci_w32(rpc, 0x28801814, RT3883_PCI_REG_SUBID(0));
+
+	/* PCIe */
+	rt3883_pci_w32(rpc, 0x03ff0000, RT3883_PCI_REG_BAR0SETUP(1));
+	rt3883_pci_w32(rpc, RT3883_MEMORY_BASE, RT3883_PCI_REG_IMBASEBAR0(1));
+	rt3883_pci_w32(rpc, 0x08021814, RT3883_PCI_REG_ID(1));
+	rt3883_pci_w32(rpc, 0x06040001, RT3883_PCI_REG_CLASS(1));
+	rt3883_pci_w32(rpc, 0x28801814, RT3883_PCI_REG_SUBID(1));
+
+	err = rt3883_pci_irq_init(dev, rpc);
+	if (err)
+		goto err_put_hb_node;
+
+	/* PCIe */
+	val = rt3883_pci_read_cfg32(rpc, 0, 0x01, 0, PCI_COMMAND);
+	val |= PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER;
+	rt3883_pci_write_cfg32(rpc, 0, 0x01, 0, PCI_COMMAND, val);
+
+	/* PCI */
+	val = rt3883_pci_read_cfg32(rpc, 0, 0x00, 0, PCI_COMMAND);
+	val |= PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER;
+	rt3883_pci_write_cfg32(rpc, 0, 0x00, 0, PCI_COMMAND, val);
+
+	if (mode == RT3883_PCI_MODE_PCIE) {
+		rt3883_pci_w32(rpc, 0x03ff0001, RT3883_PCI_REG_BAR0SETUP(0));
+		rt3883_pci_w32(rpc, 0x03ff0001, RT3883_PCI_REG_BAR0SETUP(1));
+
+		rt3883_pci_write_cfg32(rpc, 0, RT3883_P2P_BR_DEVNUM, 0,
+				       PCI_BASE_ADDRESS_0,
+				       RT3883_MEMORY_BASE);
+		/* flush write */
+		rt3883_pci_read_cfg32(rpc, 0, RT3883_P2P_BR_DEVNUM, 0,
+				      PCI_BASE_ADDRESS_0);
+	} else {
+		rt3883_pci_write_cfg32(rpc, 0, RT3883_P2P_BR_DEVNUM, 0,
+				       PCI_IO_BASE, 0x00000101);
+	}
+
+	register_pci_controller(&rpc->pci_controller);
+
+	return 0;
+
+err_put_hb_node:
+	of_node_put(rpc->pci_controller.of_node);
+err_put_intc_node:
+	of_node_put(rpc->intc_of_node);
+	return err;
+}
+
+int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	struct of_irq dev_irq;
+	int err;
+	int irq;
+
+	err = of_irq_map_pci(dev, &dev_irq);
+	if (err) {
+		pr_err("pci %s: unable to get irq map, err=%d\n",
+		       pci_name((struct pci_dev *) dev), err);
+		return 0;
+	}
+
+	irq = irq_create_of_mapping(dev_irq.controller,
+				    dev_irq.specifier,
+				    dev_irq.size);
+
+	if (irq == 0)
+		pr_crit("pci %s: no irq found for pin %u\n",
+			pci_name((struct pci_dev *) dev), pin);
+	else
+		pr_info("pci %s: using irq %d for pin %u\n",
+			pci_name((struct pci_dev *) dev), irq, pin);
+
+	return irq;
+}
+
+int pcibios_plat_dev_init(struct pci_dev *dev)
+{
+	return 0;
+}
+
+static const struct of_device_id rt3883_pci_ids[] = {
+	{ .compatible = "ralink,rt3883-pci" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rt3883_pci_ids);
+
+static struct platform_driver rt3883_pci_driver = {
+	.probe = rt3883_pci_probe,
+	.driver = {
+		.name = "rt3883-pci",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(rt3883_pci_ids),
+	},
+};
+
+static int __init rt3883_pci_init(void)
+{
+	return platform_driver_register(&rt3883_pci_driver);
+}
+
+postcore_initcall(rt3883_pci_init);
diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
index 026e823..71730fa 100644
--- a/arch/mips/ralink/Kconfig
+++ b/arch/mips/ralink/Kconfig
@@ -19,6 +19,7 @@ choice
 		bool "RT3883"
 		select USB_ARCH_HAS_OHCI
 		select USB_ARCH_HAS_EHCI
+		select HW_HAS_PCI
 
 	config SOC_MT7620
 		bool "MT7620"
-- 
1.7.10
