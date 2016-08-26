Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2016 17:39:58 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:52465 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992479AbcHZPjN53SkI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Aug 2016 17:39:13 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id BCA7C72F8BFFD;
        Fri, 26 Aug 2016 16:38:52 +0100 (IST)
Received: from localhost (10.100.200.141) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 26 Aug
 2016 16:38:55 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>, John Crispin <blogic@openwrt.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>
Subject: [PATCH 04/26] MIPS: PCI: Split pci.c into pci.c & pci-legacy.c
Date:   Fri, 26 Aug 2016 16:37:03 +0100
Message-ID: <20160826153725.11629-5-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160826153725.11629-1-paul.burton@imgtec.com>
References: <20160826153725.11629-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.141]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54788
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

Split out the parts of pci.c that are used by existing systems with
MIPS-style PCI drivers but that will not be used by systems with more
generic PCI drivers such as pcie-xilinx. This is done in preparation for
allowing configurations where the code moved to pci-legacy.c is not
built.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/pci/Makefile     |   1 +
 arch/mips/pci/pci-legacy.c | 302 +++++++++++++++++++++++++++++++++++++++++++++
 arch/mips/pci/pci.c        | 287 +-----------------------------------------
 3 files changed, 306 insertions(+), 284 deletions(-)
 create mode 100644 arch/mips/pci/pci-legacy.c

diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index 139ad1d..5666637 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -3,6 +3,7 @@
 #
 
 obj-y				+= pci.o
+obj-y				+= pci-legacy.o
 
 #
 # PCI bus host bridge specific code
diff --git a/arch/mips/pci/pci-legacy.c b/arch/mips/pci/pci-legacy.c
new file mode 100644
index 0000000..014649b
--- /dev/null
+++ b/arch/mips/pci/pci-legacy.c
@@ -0,0 +1,302 @@
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
+#include <linux/bug.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/bootmem.h>
+#include <linux/export.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/of_address.h>
+
+#include <asm/cpu-info.h>
+
+/*
+ * If PCI_PROBE_ONLY in pci_flags is set, we don't change any PCI resource
+ * assignments.
+ */
+
+/*
+ * The PCI controller list.
+ */
+static LIST_HEAD(controllers);
+
+static int pci_initialized;
+
+/*
+ * We need to avoid collisions with `mirrored' VGA ports
+ * and other strange ISA hardware, so we always want the
+ * addresses to be allocated in the 0x000-0x0ff region
+ * modulo 0x400.
+ *
+ * Why? Because some silly external IO cards only decode
+ * the low 10 bits of the IO address. The 0x00-0xff region
+ * is reserved for motherboard devices that decode all 16
+ * bits, so it's ok to allocate at, say, 0x2800-0x28ff,
+ * but we want to try to avoid allocating at 0x2900-0x2bff
+ * which might have be mirrored at 0x0100-0x03ff..
+ */
+resource_size_t
+pcibios_align_resource(void *data, const struct resource *res,
+		       resource_size_t size, resource_size_t align)
+{
+	struct pci_dev *dev = data;
+	struct pci_controller *hose = dev->sysdata;
+	resource_size_t start = res->start;
+
+	if (res->flags & IORESOURCE_IO) {
+		/* Make sure we start at our min on all hoses */
+		if (start < PCIBIOS_MIN_IO + hose->io_resource->start)
+			start = PCIBIOS_MIN_IO + hose->io_resource->start;
+
+		/*
+		 * Put everything into 0x00-0xff region modulo 0x400
+		 */
+		if (start & 0x300)
+			start = (start + 0x3ff) & ~0x3ff;
+	} else if (res->flags & IORESOURCE_MEM) {
+		/* Make sure we start at our min on all hoses */
+		if (start < PCIBIOS_MIN_MEM + hose->mem_resource->start)
+			start = PCIBIOS_MIN_MEM + hose->mem_resource->start;
+	}
+
+	return start;
+}
+
+static void pcibios_scanbus(struct pci_controller *hose)
+{
+	static int next_busno;
+	static int need_domain_info;
+	LIST_HEAD(resources);
+	struct pci_bus *bus;
+
+	if (hose->get_busno && pci_has_flag(PCI_PROBE_ONLY))
+		next_busno = (*hose->get_busno)();
+
+	pci_add_resource_offset(&resources,
+				hose->mem_resource, hose->mem_offset);
+	pci_add_resource_offset(&resources,
+				hose->io_resource, hose->io_offset);
+	pci_add_resource_offset(&resources,
+				hose->busn_resource, hose->busn_offset);
+	bus = pci_scan_root_bus(NULL, next_busno, hose->pci_ops, hose,
+				&resources);
+	hose->bus = bus;
+
+	need_domain_info = need_domain_info || pci_domain_nr(bus);
+	set_pci_need_domain_info(hose, need_domain_info);
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
+	/*
+	 * We insert PCI resources into the iomem_resource and
+	 * ioport_resource trees in either pci_bus_claim_resources()
+	 * or pci_bus_assign_resources().
+	 */
+	if (pci_has_flag(PCI_PROBE_ONLY)) {
+		pci_bus_claim_resources(bus);
+	} else {
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
+	struct pci_controller *hose = bus->sysdata;
+
+	return of_node_get(hose->of_node);
+}
+#endif
+
+static DEFINE_MUTEX(pci_scan_mutex);
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
+	INIT_LIST_HEAD(&hose->list);
+	list_add(&hose->list, &controllers);
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
+	list_for_each_entry(hose, &controllers, list)
+		pcibios_scanbus(hose);
+
+	pci_fixup_irqs(pci_common_swizzle, pcibios_map_irq);
+
+	pci_initialized = 1;
+
+	return 0;
+}
+
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
+	for (idx=0; idx < PCI_NUM_RESOURCES; idx++) {
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
+	if ((err = pcibios_enable_resources(dev, mask)) < 0)
+		return err;
+
+	return pcibios_plat_dev_init(dev);
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
+
+char * (*pcibios_plat_setup)(char *str) __initdata;
+
+char *__init pcibios_setup(char *str)
+{
+	if (pcibios_plat_setup)
+		return pcibios_plat_setup(str);
+	return str;
+}
diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index 8cc6ea4..f6325fa 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -20,205 +20,11 @@
 
 #include <asm/cpu-info.h>
 
-/*
- * If PCI_PROBE_ONLY in pci_flags is set, we don't change any PCI resource
- * assignments.
- */
-
-/*
- * The PCI controller list.
- */
-static LIST_HEAD(controllers);
-
 unsigned long PCIBIOS_MIN_IO;
-unsigned long PCIBIOS_MIN_MEM;
-
-static int pci_initialized;
-
-/*
- * We need to avoid collisions with `mirrored' VGA ports
- * and other strange ISA hardware, so we always want the
- * addresses to be allocated in the 0x000-0x0ff region
- * modulo 0x400.
- *
- * Why? Because some silly external IO cards only decode
- * the low 10 bits of the IO address. The 0x00-0xff region
- * is reserved for motherboard devices that decode all 16
- * bits, so it's ok to allocate at, say, 0x2800-0x28ff,
- * but we want to try to avoid allocating at 0x2900-0x2bff
- * which might have be mirrored at 0x0100-0x03ff..
- */
-resource_size_t
-pcibios_align_resource(void *data, const struct resource *res,
-		       resource_size_t size, resource_size_t align)
-{
-	struct pci_dev *dev = data;
-	struct pci_controller *hose = dev->sysdata;
-	resource_size_t start = res->start;
-
-	if (res->flags & IORESOURCE_IO) {
-		/* Make sure we start at our min on all hoses */
-		if (start < PCIBIOS_MIN_IO + hose->io_resource->start)
-			start = PCIBIOS_MIN_IO + hose->io_resource->start;
-
-		/*
-		 * Put everything into 0x00-0xff region modulo 0x400
-		 */
-		if (start & 0x300)
-			start = (start + 0x3ff) & ~0x3ff;
-	} else if (res->flags & IORESOURCE_MEM) {
-		/* Make sure we start at our min on all hoses */
-		if (start < PCIBIOS_MIN_MEM + hose->mem_resource->start)
-			start = PCIBIOS_MIN_MEM + hose->mem_resource->start;
-	}
-
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
-	need_domain_info = need_domain_info || pci_domain_nr(bus);
-	set_pci_need_domain_info(hose, need_domain_info);
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
-	/*
-	 * We insert PCI resources into the iomem_resource and
-	 * ioport_resource trees in either pci_bus_claim_resources()
-	 * or pci_bus_assign_resources().
-	 */
-	if (pci_has_flag(PCI_PROBE_ONLY)) {
-		pci_bus_claim_resources(bus);
-	} else {
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
-
-	return of_node_get(hose->of_node);
-}
-#endif
-
-static DEFINE_MUTEX(pci_scan_mutex);
-
-void register_pci_controller(struct pci_controller *hose)
-{
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
-	INIT_LIST_HEAD(&hose->list);
-	list_add(&hose->list, &controllers);
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
+EXPORT_SYMBOL(PCIBIOS_MIN_IO);
 
-out:
-	printk(KERN_WARNING
-	       "Skipping PCI bus scan due to resource conflict\n");
-}
+unsigned long PCIBIOS_MIN_MEM;
+EXPORT_SYMBOL(PCIBIOS_MIN_MEM);
 
 static int __init pcibios_set_cache_line_size(void)
 {
@@ -242,84 +48,6 @@ static int __init pcibios_set_cache_line_size(void)
 }
 arch_initcall(pcibios_set_cache_line_size);
 
-static int __init pcibios_init(void)
-{
-	struct pci_controller *hose;
-
-	/* Scan all of the recorded PCI controllers.  */
-	list_for_each_entry(hose, &controllers, list)
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
-	return 0;
-}
-
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
-EXPORT_SYMBOL(PCIBIOS_MIN_IO);
-EXPORT_SYMBOL(PCIBIOS_MIN_MEM);
-
 void pci_resource_to_user(const struct pci_dev *dev, int bar,
 			  const struct resource *rsrc, resource_size_t *start,
 			  resource_size_t *end)
@@ -353,12 +81,3 @@ int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
 		vma->vm_end - vma->vm_start, vma->vm_page_prot);
 }
-
-char * (*pcibios_plat_setup)(char *str) __initdata;
-
-char *__init pcibios_setup(char *str)
-{
-	if (pcibios_plat_setup)
-		return pcibios_plat_setup(str);
-	return str;
-}
-- 
2.9.3
