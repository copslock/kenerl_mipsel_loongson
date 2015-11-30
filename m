Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2015 17:23:40 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:39301 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008007AbbK3QXTTnYkv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Nov 2015 17:23:19 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 81518FDB3DD3E;
        Mon, 30 Nov 2015 16:23:09 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Mon, 30 Nov 2015 16:23:12 +0000
Received: from localhost (10.100.200.236) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 30 Nov
 2015 16:23:11 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Joshua Kinard <kumba@gentoo.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        Yijing Wang <wangyijing@huawei.com>,
        John Crispin <blogic@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michal Simek <monstr@monstr.eu>
Subject: [PATCH 04/28] MIPS: PCI: compatibility with ARM-like PCI host drivers
Date:   Mon, 30 Nov 2015 16:21:29 +0000
Message-ID: <1448900513-20856-5-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
References: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.236]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50185
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Introduce support for struct hw_pci & the associated pci_common_init_dev
function as used by the PCI drivers written for ARM platforms under
drivers/pci. This is in preparation for reusing the xilinx-pcie driver
on the MIPS Boston board.

Platforms that make use of this more generic code will need to select
CONFIG_MIPS_GENERIC_PCI. Platforms which don't will continue to work as
they have, with the intent that PCI drivers be migrated towards struct
hw_pci & drivers/pci/ over time.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/Kconfig           |   6 ++
 arch/mips/include/asm/pci.h |  67 ++++++++++++-
 arch/mips/lib/iomap-pci.c   |   2 +-
 arch/mips/pci/Makefile      |   6 ++
 arch/mips/pci/pci-generic.c | 138 ++++++++++++++++++++++++++
 arch/mips/pci/pci-legacy.c  | 232 ++++++++++++++++++++++++++++++++++++++++++++
 arch/mips/pci/pci.c         | 226 ++----------------------------------------
 7 files changed, 456 insertions(+), 221 deletions(-)
 create mode 100644 arch/mips/pci/pci-generic.c
 create mode 100644 arch/mips/pci/pci-legacy.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 71683a8..6d11a41 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2834,11 +2834,14 @@ config HW_HAS_EISA
 	bool
 config HW_HAS_PCI
 	bool
+config MIPS_GENERIC_PCI
+	bool
 
 config PCI
 	bool "Support for PCI controller"
 	depends on HW_HAS_PCI
 	select PCI_DOMAINS
+	select PCI_DOMAINS_GENERIC if MIPS_GENERIC_PCI
 	select NO_GENERIC_PCI_IOPORT_MAP
 	help
 	  Find out whether you have a PCI motherboard. PCI is the name of a
@@ -2860,6 +2863,9 @@ config HT_PCI
 config PCI_DOMAINS
 	bool
 
+config PCI_DOMAINS_GENERIC
+	bool
+
 source "drivers/pci/Kconfig"
 
 source "drivers/pci/pcie/Kconfig"
diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
index 98c31e5..f02f3f8 100644
--- a/arch/mips/include/asm/pci.h
+++ b/arch/mips/include/asm/pci.h
@@ -19,12 +19,47 @@
 #include <linux/ioport.h>
 #include <linux/of.h>
 
+struct pci_sys_data;
+
+struct hw_pci {
+#ifdef CONFIG_PCI_DOMAINS
+	int		domain;
+#endif
+#ifdef CONFIG_PCI_MSI
+	struct msi_controller *msi_ctrl;
+#endif
+	struct pci_ops	*ops;
+	int		nr_controllers;
+	void		**private_data;
+	int		(*setup)(int nr, struct pci_sys_data *);
+	struct pci_bus *(*scan)(int nr, struct pci_sys_data *);
+	void		(*preinit)(void);
+	void		(*postinit)(void);
+	u8		(*swizzle)(struct pci_dev *dev, u8 *pin);
+	int		(*map_irq)(const struct pci_dev *dev, u8 slot, u8 pin);
+	resource_size_t (*align_resource)(struct pci_dev *dev,
+					  const struct resource *res,
+					  resource_size_t start,
+					  resource_size_t size,
+					  resource_size_t align);
+};
+
+struct pci_sys_data {
+	int busnr;
+	struct list_head resources;
+	void *private_data;
+#ifdef CONFIG_PCI_MSI
+	struct msi_controller *msi_ctrl;
+#endif
+};
+
 /*
  * Each pci channel is a top-level PCI bus seem by CPU.	 A machine  with
  * multiple PCI channels may have multiple PCI host controllers or a
  * single controller supporting multiple channels.
  */
 struct pci_controller {
+	struct pci_sys_data sysdata;
 	struct pci_controller *next;
 	struct pci_bus *bus;
 	struct device_node *of_node;
@@ -45,17 +80,36 @@ struct pci_controller {
 
 	int iommu;
 
+	int		(*map_irq)(const struct pci_dev *dev, u8 slot, u8 pin);
+	resource_size_t (*align_resource)(struct pci_dev *dev,
+					  const struct resource *res,
+					  resource_size_t start,
+					  resource_size_t size,
+					  resource_size_t align);
+
 	/* Optional access methods for reading/writing the bus number
 	   of the PCI controller */
 	int (*get_busno)(void);
 	void (*set_busno)(int busno);
 };
 
+extern struct pci_controller *hose_head;
+
+static inline struct pci_controller *
+sysdata_to_hose(struct pci_sys_data *sysdata)
+{
+	return container_of(sysdata, struct pci_controller, sysdata);
+}
+
+extern void pci_common_init_dev(struct device *, struct hw_pci *);
+
 /*
  * Used by boards to register their PCI busses before the actual scanning.
  */
 extern void register_pci_controller(struct pci_controller *hose);
 
+extern void add_pci_controller(struct pci_controller *hose);
+
 /*
  * board supplied pci irq fixup routine
  */
@@ -113,12 +167,19 @@ struct pci_dev;
  */
 extern unsigned int PCI_DMA_BUS_IS_PHYS;
 
-#ifdef CONFIG_PCI_DOMAINS
-#define pci_domain_nr(bus) ((struct pci_controller *)(bus)->sysdata)->index
+#ifdef CONFIG_PCI_DOMAINS_GENERIC
+
+static inline int pci_proc_domain(struct pci_bus *bus)
+{
+	return pci_domain_nr(bus);
+}
+
+#elif defined(CONFIG_PCI_DOMAINS)
+#define pci_domain_nr(bus) (sysdata_to_hose(bus->sysdata)->index)
 
 static inline int pci_proc_domain(struct pci_bus *bus)
 {
-	struct pci_controller *hose = bus->sysdata;
+	struct pci_controller *hose = sysdata_to_hose(bus->sysdata);
 	return hose->need_domain_info;
 }
 #endif /* CONFIG_PCI_DOMAINS */
diff --git a/arch/mips/lib/iomap-pci.c b/arch/mips/lib/iomap-pci.c
index fd35daa..9595827 100644
--- a/arch/mips/lib/iomap-pci.c
+++ b/arch/mips/lib/iomap-pci.c
@@ -13,7 +13,7 @@
 void __iomem *__pci_ioport_map(struct pci_dev *dev,
 			       unsigned long port, unsigned int nr)
 {
-	struct pci_controller *ctrl = dev->bus->sysdata;
+	struct pci_controller *ctrl = sysdata_to_hose(dev->bus->sysdata);
 	unsigned long base = ctrl->io_map_base;
 
 	/* This will eventually become a BUG_ON but for now be gentle */
diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index 2eda01e..30e4cdc 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -4,6 +4,12 @@
 
 obj-y				+= pci.o
 
+ifeq ($(CONFIG_MIPS_GENERIC_PCI),y)
+obj-y				+= pci-generic.o
+else
+obj-y				+= pci-legacy.o
+endif
+
 #
 # PCI bus host bridge specific code
 #
diff --git a/arch/mips/pci/pci-generic.c b/arch/mips/pci/pci-generic.c
new file mode 100644
index 0000000..f20adc0
--- /dev/null
+++ b/arch/mips/pci/pci-generic.c
@@ -0,0 +1,138 @@
+/*
+ * This program is free software; you can redistribute	it and/or modify it
+ * under  the terms of	the GNU General	 Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * Copyright (C) 2003, 04, 11 Ralf Baechle (ralf@linux-mips.org)
+ * Copyright (C) 2011 Wind River Systems,
+ *   written by Ralf Baechle (ralf@linux-mips.org)
+ */
+
+#include <linux/pci.h>
+
+int __weak pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	struct pci_sys_data *sysdata = dev->sysdata;
+	struct pci_controller *ctl = sysdata_to_hose(sysdata);
+
+	if (!ctl->map_irq)
+		return -1;
+
+	return ctl->map_irq(dev, slot, pin);
+}
+
+void pci_common_init_dev(struct device *parent, struct hw_pci *hw)
+{
+	struct pci_controller *ctl;
+	struct resource_entry *window;
+	struct resource **ctl_res;
+	int i, ret, next_busnr = 0;
+
+	for (i = 0; i < hw->nr_controllers; i++) {
+		ctl = kzalloc(sizeof(*ctl), GFP_KERNEL);
+		if (!ctl) {
+			pr_err("%s: unable to allocate pci_controller\n",
+			       __func__);
+			continue;
+		}
+
+		ctl->pci_ops = hw->ops;
+		ctl->align_resource = hw->align_resource;
+		ctl->map_irq = hw->map_irq;
+
+		INIT_LIST_HEAD(&ctl->sysdata.resources);
+
+		if (hw->private_data)
+			ctl->sysdata.private_data = hw->private_data[i];
+
+		ctl->sysdata.busnr = next_busnr;
+#ifdef CONFIG_PCI_MSI
+		ctl->sysdata.msi_ctrl = hw->msi_ctrl;
+#endif
+
+		if (hw->preinit)
+			hw->preinit();
+
+		ret = hw->setup(i, &ctl->sysdata);
+		if (ret < 0) {
+			pr_err("%s: unable to setup controller: %d\n",
+			       __func__, ret);
+			kfree(ctl);
+			continue;
+		}
+
+		resource_list_for_each_entry(window, &ctl->sysdata.resources) {
+			switch (resource_type(window->res)) {
+			case IORESOURCE_IO:
+				ctl_res = &ctl->io_resource;
+				break;
+
+			case IORESOURCE_MEM:
+				ctl_res = &ctl->mem_resource;
+				break;
+
+			default:
+				ctl_res = NULL;
+			}
+
+			if (!ctl_res)
+				continue;
+
+			if (*ctl_res) {
+				pr_warn("%s: multiple resources of type 0x%lx\n",
+					__func__, resource_type(window->res));
+				continue;
+			}
+
+			*ctl_res = window->res;
+		}
+
+		if (hw->scan)
+			ctl->bus = hw->scan(i, &ctl->sysdata);
+		else
+			ctl->bus = pci_scan_root_bus(parent,
+					ctl->sysdata.busnr,
+					hw->ops, &ctl->sysdata,
+					&ctl->sysdata.resources);
+
+		add_pci_controller(ctl);
+
+		if (hw->postinit)
+			hw->postinit();
+
+		pci_fixup_irqs(pci_common_swizzle, pcibios_map_irq);
+
+		if (ctl->bus) {
+			if (!pci_has_flag(PCI_PROBE_ONLY)) {
+				pci_bus_size_bridges(ctl->bus);
+				pci_bus_assign_resources(ctl->bus);
+			}
+
+			pci_bus_add_devices(ctl->bus);
+			next_busnr = ctl->bus->busn_res.end + 1;
+		}
+	}
+}
+
+void pcibios_fixup_bus(struct pci_bus *bus)
+{
+	pci_read_bridge_bases(bus);
+}
+
+int pcibios_enable_device(struct pci_dev *dev, int mask)
+{
+	if (pci_has_flag(PCI_PROBE_ONLY))
+		return 0;
+
+	return pci_enable_resources(dev, mask);
+}
+
+#ifdef CONFIG_PCI_MSI
+struct msi_controller *pcibios_msi_controller(struct pci_dev *dev)
+{
+	struct pci_sys_data *sysdata = dev->sysdata;
+
+	return sysdata->msi_ctrl;
+}
+#endif
diff --git a/arch/mips/pci/pci-legacy.c b/arch/mips/pci/pci-legacy.c
new file mode 100644
index 0000000..cf76a08
--- /dev/null
+++ b/arch/mips/pci/pci-legacy.c
@@ -0,0 +1,232 @@
+/*
+ * This program is free software; you can redistribute	it and/or modify it
+ * under  the terms of	the GNU General	 Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * Copyright (C) 2003, 04, 11 Ralf Baechle (ralf@linux-mips.org)
+ * Copyright (C) 2011 Wind River Systems,
+ *   written by Ralf Baechle (ralf@linux-mips.org)
+ */
+
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/of_address.h>
+#include <linux/pci.h>
+
+#include <asm/cpu-info.h>
+
+static int pci_initialized;
+static DEFINE_MUTEX(pci_scan_mutex);
+
+static void pcibios_scanbus(struct pci_controller *hose)
+{
+	static int next_busno;
+	static int need_domain_info;
+	LIST_HEAD(resources);
+	struct pci_bus *bus;
+
+	if (!hose->iommu)
+		PCI_DMA_BUS_IS_PHYS = 1;
+
+	if (hose->get_busno && pci_has_flag(PCI_PROBE_ONLY))
+		next_busno = (*hose->get_busno)();
+
+	hose->sysdata.busnr = next_busno;
+
+	pci_add_resource_offset(&resources,
+				hose->mem_resource, hose->mem_offset);
+	pci_add_resource_offset(&resources,
+				hose->io_resource, hose->io_offset);
+	pci_add_resource_offset(&resources,
+				hose->busn_resource, hose->busn_offset);
+	bus = pci_scan_root_bus(NULL, next_busno, hose->pci_ops, &hose->sysdata,
+				&resources);
+	hose->bus = bus;
+
+	need_domain_info = need_domain_info || hose->index;
+	hose->need_domain_info = need_domain_info;
+
+	if (!bus) {
+		pci_free_resource_list(&resources);
+		return;
+	}
+
+	next_busno = bus->busn_res.end + 1;
+	/* Don't allow 8-bit bus number overflow inside the hose -
+	   reserve some space for bridges. */
+	if (next_busno > 224) {
+		next_busno = 0;
+		need_domain_info = 1;
+	}
+
+	if (!pci_has_flag(PCI_PROBE_ONLY)) {
+		pci_bus_size_bridges(bus);
+		pci_bus_assign_resources(bus);
+	}
+	pci_bus_add_devices(bus);
+}
+
+#ifdef CONFIG_OF
+void pci_load_of_ranges(struct pci_controller *hose, struct device_node *node)
+{
+	struct of_pci_range range;
+	struct of_pci_range_parser parser;
+
+	pr_info("PCI host bridge %s ranges:\n", node->full_name);
+	hose->of_node = node;
+
+	if (of_pci_range_parser_init(&parser, node))
+		return;
+
+	for_each_of_pci_range(&parser, &range) {
+		struct resource *res = NULL;
+
+		switch (range.flags & IORESOURCE_TYPE_BITS) {
+		case IORESOURCE_IO:
+			pr_info("  IO 0x%016llx..0x%016llx\n",
+				range.cpu_addr,
+				range.cpu_addr + range.size - 1);
+			hose->io_map_base =
+				(unsigned long)ioremap(range.cpu_addr,
+						       range.size);
+			res = hose->io_resource;
+			break;
+		case IORESOURCE_MEM:
+			pr_info(" MEM 0x%016llx..0x%016llx\n",
+				range.cpu_addr,
+				range.cpu_addr + range.size - 1);
+			res = hose->mem_resource;
+			break;
+		}
+		if (res != NULL)
+			of_pci_range_to_resource(&range, node, res);
+	}
+}
+
+struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus)
+{
+	struct pci_controller *hose = sysdata_to_hose(bus->sysdata);
+
+	return of_node_get(hose->of_node);
+}
+#endif
+
+void register_pci_controller(struct pci_controller *hose)
+{
+	struct resource *parent;
+
+	parent = hose->mem_resource->parent;
+	if (!parent)
+		parent = &iomem_resource;
+
+	if (request_resource(parent, hose->mem_resource) < 0)
+		goto out;
+
+	parent = hose->io_resource->parent;
+	if (!parent)
+		parent = &ioport_resource;
+
+	if (request_resource(parent, hose->io_resource) < 0) {
+		release_resource(hose->mem_resource);
+		goto out;
+	}
+
+	add_pci_controller(hose);
+
+	/*
+	 * Do not panic here but later - this might happen before console init.
+	 */
+	if (!hose->io_map_base) {
+		printk(KERN_WARNING
+		       "registering PCI controller with io_map_base unset\n");
+	}
+
+	/*
+	 * Scan the bus if it is register after the PCI subsystem
+	 * initialization.
+	 */
+	if (pci_initialized) {
+		mutex_lock(&pci_scan_mutex);
+		pcibios_scanbus(hose);
+		mutex_unlock(&pci_scan_mutex);
+	}
+
+	return;
+
+out:
+	printk(KERN_WARNING
+	       "Skipping PCI bus scan due to resource conflict\n");
+}
+
+static int __init pcibios_init(void)
+{
+	struct pci_controller *hose;
+
+	/* Scan all of the recorded PCI controllers.  */
+	for (hose = hose_head; hose; hose = hose->next)
+		pcibios_scanbus(hose);
+
+	pci_fixup_irqs(pci_common_swizzle, pcibios_map_irq);
+
+	pci_initialized = 1;
+
+	return 0;
+}
+subsys_initcall(pcibios_init);
+
+static int pcibios_enable_resources(struct pci_dev *dev, int mask)
+{
+	u16 cmd, old_cmd;
+	int idx;
+	struct resource *r;
+
+	pci_read_config_word(dev, PCI_COMMAND, &cmd);
+	old_cmd = cmd;
+	for (idx = 0; idx < PCI_NUM_RESOURCES; idx++) {
+		/* Only set up the requested stuff */
+		if (!(mask & (1<<idx)))
+			continue;
+
+		r = &dev->resource[idx];
+		if (!(r->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
+			continue;
+		if ((idx == PCI_ROM_RESOURCE) &&
+				(!(r->flags & IORESOURCE_ROM_ENABLE)))
+			continue;
+		if (!r->start && r->end) {
+			printk(KERN_ERR "PCI: Device %s not available "
+			       "because of resource collisions\n",
+			       pci_name(dev));
+			return -EINVAL;
+		}
+		if (r->flags & IORESOURCE_IO)
+			cmd |= PCI_COMMAND_IO;
+		if (r->flags & IORESOURCE_MEM)
+			cmd |= PCI_COMMAND_MEMORY;
+	}
+	if (cmd != old_cmd) {
+		printk("PCI: Enabling device %s (%04x -> %04x)\n",
+		       pci_name(dev), old_cmd, cmd);
+		pci_write_config_word(dev, PCI_COMMAND, cmd);
+	}
+	return 0;
+}
+
+int pcibios_enable_device(struct pci_dev *dev, int mask)
+{
+	int err;
+
+	err = pcibios_enable_resources(dev, mask);
+	return err ?: pcibios_plat_dev_init(dev);
+}
+
+void pcibios_fixup_bus(struct pci_bus *bus)
+{
+	struct pci_dev *dev = bus->self;
+
+	if (pci_has_flag(PCI_PROBE_ONLY) && dev &&
+	    (dev->class >> 8) == PCI_CLASS_BRIDGE_PCI) {
+		pci_read_bridge_bases(bus);
+	}
+}
diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index b8a0bf5..18ea99b 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -29,13 +29,12 @@
  * The PCI controller list.
  */
 
-static struct pci_controller *hose_head, **hose_tail = &hose_head;
+struct pci_controller *hose_head;
+static struct pci_controller **hose_tail = &hose_head;
 
 unsigned long PCIBIOS_MIN_IO;
 unsigned long PCIBIOS_MIN_MEM;
 
-static int pci_initialized;
-
 /*
  * We need to avoid collisions with `mirrored' VGA ports
  * and other strange ISA hardware, so we always want the
@@ -54,7 +53,7 @@ pcibios_align_resource(void *data, const struct resource *res,
 		       resource_size_t size, resource_size_t align)
 {
 	struct pci_dev *dev = data;
-	struct pci_controller *hose = dev->sysdata;
+	struct pci_controller *hose = sysdata_to_hose(dev->sysdata);
 	resource_size_t start = res->start;
 
 	if (res->flags & IORESOURCE_IO) {
@@ -73,151 +72,19 @@ pcibios_align_resource(void *data, const struct resource *res,
 			start = PCIBIOS_MIN_MEM + hose->mem_resource->start;
 	}
 
-	return start;
-}
-
-static void pcibios_scanbus(struct pci_controller *hose)
-{
-	static int next_busno;
-	static int need_domain_info;
-	LIST_HEAD(resources);
-	struct pci_bus *bus;
-
-	if (!hose->iommu)
-		PCI_DMA_BUS_IS_PHYS = 1;
-
-	if (hose->get_busno && pci_has_flag(PCI_PROBE_ONLY))
-		next_busno = (*hose->get_busno)();
-
-	pci_add_resource_offset(&resources,
-				hose->mem_resource, hose->mem_offset);
-	pci_add_resource_offset(&resources,
-				hose->io_resource, hose->io_offset);
-	pci_add_resource_offset(&resources,
-				hose->busn_resource, hose->busn_offset);
-	bus = pci_scan_root_bus(NULL, next_busno, hose->pci_ops, hose,
-				&resources);
-	hose->bus = bus;
-
-	need_domain_info = need_domain_info || hose->index;
-	hose->need_domain_info = need_domain_info;
-
-	if (!bus) {
-		pci_free_resource_list(&resources);
-		return;
-	}
-
-	next_busno = bus->busn_res.end + 1;
-	/* Don't allow 8-bit bus number overflow inside the hose -
-	   reserve some space for bridges. */
-	if (next_busno > 224) {
-		next_busno = 0;
-		need_domain_info = 1;
-	}
-
-	if (!pci_has_flag(PCI_PROBE_ONLY)) {
-		pci_bus_size_bridges(bus);
-		pci_bus_assign_resources(bus);
-	}
-	pci_bus_add_devices(bus);
-}
-
-#ifdef CONFIG_OF
-void pci_load_of_ranges(struct pci_controller *hose, struct device_node *node)
-{
-	struct of_pci_range range;
-	struct of_pci_range_parser parser;
-
-	pr_info("PCI host bridge %s ranges:\n", node->full_name);
-	hose->of_node = node;
-
-	if (of_pci_range_parser_init(&parser, node))
-		return;
-
-	for_each_of_pci_range(&parser, &range) {
-		struct resource *res = NULL;
-
-		switch (range.flags & IORESOURCE_TYPE_BITS) {
-		case IORESOURCE_IO:
-			pr_info("  IO 0x%016llx..0x%016llx\n",
-				range.cpu_addr,
-				range.cpu_addr + range.size - 1);
-			hose->io_map_base =
-				(unsigned long)ioremap(range.cpu_addr,
-						       range.size);
-			res = hose->io_resource;
-			break;
-		case IORESOURCE_MEM:
-			pr_info(" MEM 0x%016llx..0x%016llx\n",
-				range.cpu_addr,
-				range.cpu_addr + range.size - 1);
-			res = hose->mem_resource;
-			break;
-		}
-		if (res != NULL)
-			of_pci_range_to_resource(&range, node, res);
-	}
-}
-
-struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus)
-{
-	struct pci_controller *hose = bus->sysdata;
+	if (hose->align_resource)
+		return hose->align_resource(dev, res, start, size, align);
 
-	return of_node_get(hose->of_node);
+	return start;
 }
-#endif
 
-static DEFINE_MUTEX(pci_scan_mutex);
-
-void register_pci_controller(struct pci_controller *hose)
+void add_pci_controller(struct pci_controller *hose)
 {
-	struct resource *parent;
-
-	parent = hose->mem_resource->parent;
-	if (!parent)
-		parent = &iomem_resource;
-
-	if (request_resource(parent, hose->mem_resource) < 0)
-		goto out;
-
-	parent = hose->io_resource->parent;
-	if (!parent)
-		parent = &ioport_resource;
-
-	if (request_resource(parent, hose->io_resource) < 0) {
-		release_resource(hose->mem_resource);
-		goto out;
-	}
-
 	*hose_tail = hose;
 	hose_tail = &hose->next;
-
-	/*
-	 * Do not panic here but later - this might happen before console init.
-	 */
-	if (!hose->io_map_base) {
-		printk(KERN_WARNING
-		       "registering PCI controller with io_map_base unset\n");
-	}
-
-	/*
-	 * Scan the bus if it is register after the PCI subsystem
-	 * initialization.
-	 */
-	if (pci_initialized) {
-		mutex_lock(&pci_scan_mutex);
-		pcibios_scanbus(hose);
-		mutex_unlock(&pci_scan_mutex);
-	}
-
-	return;
-
-out:
-	printk(KERN_WARNING
-	       "Skipping PCI bus scan due to resource conflict\n");
 }
 
-static void __init pcibios_set_cache_line_size(void)
+static int __init pcibios_set_cache_line_size(void)
 {
 	struct cpuinfo_mips *c = &current_cpu_data;
 	unsigned int lsize;
@@ -235,90 +102,15 @@ static void __init pcibios_set_cache_line_size(void)
 	pci_dfl_cache_line_size = lsize >> 2;
 
 	pr_debug("PCI: pci_cache_line_size set to %d bytes\n", lsize);
-}
-
-static int __init pcibios_init(void)
-{
-	struct pci_controller *hose;
-
-	pcibios_set_cache_line_size();
-
-	/* Scan all of the recorded PCI controllers.  */
-	for (hose = hose_head; hose; hose = hose->next)
-		pcibios_scanbus(hose);
-
-	pci_fixup_irqs(pci_common_swizzle, pcibios_map_irq);
-
-	pci_initialized = 1;
-
-	return 0;
-}
-
-subsys_initcall(pcibios_init);
-
-static int pcibios_enable_resources(struct pci_dev *dev, int mask)
-{
-	u16 cmd, old_cmd;
-	int idx;
-	struct resource *r;
-
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-	old_cmd = cmd;
-	for (idx=0; idx < PCI_NUM_RESOURCES; idx++) {
-		/* Only set up the requested stuff */
-		if (!(mask & (1<<idx)))
-			continue;
-
-		r = &dev->resource[idx];
-		if (!(r->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
-			continue;
-		if ((idx == PCI_ROM_RESOURCE) &&
-				(!(r->flags & IORESOURCE_ROM_ENABLE)))
-			continue;
-		if (!r->start && r->end) {
-			printk(KERN_ERR "PCI: Device %s not available "
-			       "because of resource collisions\n",
-			       pci_name(dev));
-			return -EINVAL;
-		}
-		if (r->flags & IORESOURCE_IO)
-			cmd |= PCI_COMMAND_IO;
-		if (r->flags & IORESOURCE_MEM)
-			cmd |= PCI_COMMAND_MEMORY;
-	}
-	if (cmd != old_cmd) {
-		printk("PCI: Enabling device %s (%04x -> %04x)\n",
-		       pci_name(dev), old_cmd, cmd);
-		pci_write_config_word(dev, PCI_COMMAND, cmd);
-	}
 	return 0;
 }
+arch_initcall(pcibios_set_cache_line_size);
 
 unsigned int pcibios_assign_all_busses(void)
 {
 	return 1;
 }
 
-int pcibios_enable_device(struct pci_dev *dev, int mask)
-{
-	int err;
-
-	if ((err = pcibios_enable_resources(dev, mask)) < 0)
-		return err;
-
-	return pcibios_plat_dev_init(dev);
-}
-
-void pcibios_fixup_bus(struct pci_bus *bus)
-{
-	struct pci_dev *dev = bus->self;
-
-	if (pci_has_flag(PCI_PROBE_ONLY) && dev &&
-	    (dev->class >> 8) == PCI_CLASS_BRIDGE_PCI) {
-		pci_read_bridge_bases(bus);
-	}
-}
-
 EXPORT_SYMBOL(PCIBIOS_MIN_IO);
 EXPORT_SYMBOL(PCIBIOS_MIN_MEM);
 
-- 
2.6.2
