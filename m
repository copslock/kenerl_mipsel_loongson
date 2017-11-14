Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 23:14:40 +0100 (CET)
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:53762 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992188AbdKNWM6f2Iov (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Nov 2017 23:12:58 +0100
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.224.233])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 5DC0730C025;
        Tue, 14 Nov 2017 14:12:56 -0800 (PST)
Received: from stbsrv-and-3.and.broadcom.com (stbsrv-and-3.and.broadcom.com [10.28.16.21])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id BC84081EAD;
        Tue, 14 Nov 2017 14:12:53 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>
Cc:     linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Jim Quinlan <jim2101024@gmail.com>
Subject: [PATCH v3 4/8] PCI: brcmstb: Add dma-range mapping for inbound traffic
Date:   Tue, 14 Nov 2017 17:12:08 -0500
Message-Id: <1510697532-32828-5-git-send-email-jim2101024@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
In-Reply-To: <1510697532-32828-1-git-send-email-jim2101024@gmail.com>
References: <1510697532-32828-1-git-send-email-jim2101024@gmail.com>
Return-Path: <jim2101024@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60943
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jim2101024@gmail.com
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

The Broadcom STB PCIe host controller is intimately related to the
memory subsystem.  This close relationship adds complexity to how cpu
system memory is mapped to PCIe memory.  Ideally, this mapping is an
identity mapping, or an identity mapping off by a constant.  Not so in
this case.

Consider the Broadcom reference board BCM97445LCC_4X8 which has 6 GB
of system memory.  Here is how the PCIe controller maps the
system memory to PCIe memory:

  memc0-a@[        0....3fffffff] <=> pci@[        0....3fffffff]
  memc0-b@[100000000...13fffffff] <=> pci@[ 40000000....7fffffff]
  memc1-a@[ 40000000....7fffffff] <=> pci@[ 80000000....bfffffff]
  memc1-b@[300000000...33fffffff] <=> pci@[ c0000000....ffffffff]
  memc2-a@[ 80000000....bfffffff] <=> pci@[100000000...13fffffff]
  memc2-b@[c00000000...c3fffffff] <=> pci@[140000000...17fffffff]

Although there are some "gaps" that can be added between the
individual mappings by software, the permutation of memory regions for
the most part is fixed by HW.  The solution of having something close
to an identity mapping is not possible.

The idea behind this HW design is that the same PCIe module can
act as an RC or EP, and if it acts as an EP it concatenates all
of system memory into a BAR so anything can be accessed.  Unfortunately,
when the PCIe block is in the role of an RC it also presents this
"BAR" to downstream PCIe devices, rather than offering an identity map
between its system memory and PCIe space.

Suppose that an endpoint driver allocs some DMA memory.  Suppose this
memory is located at 0x6000_0000, which is in the middle of memc1-a.
The driver wants a dma_addr_t value that it can pass on to the EP to
use.  Without doing any custom mapping, the EP will use this value for
DMA: the driver will get a dma_addr_t equal to 0x6000_0000.  But this
won't work; the device needs a dma_addr_t that reflects the PCIe space
address, namely 0xa000_0000.

So, essentially the solution to this problem must modify the
dma_addr_t returned by the DMA routines routines.  There are two
ways (I know of) of doing this:

(a) overriding/redefining the dma_to_phys() and phys_to_dma() calls
that are used by the dma_ops routines.  This is the approach of

	arch/mips/cavium-octeon/dma-octeon.c

In ARM and ARM64 these two routines are defiend in asm/dma-mapping.h
as static inline functions.

(b) Subscribe to a notifier that notifies when a device is added to a
bus.  When this happens, set_dma_ops() can be called for the device.
This method is mentioned in:

    http://lxr.free-electrons.com/source/drivers/of/platform.c?v=3.16#L152

where it says as a comment

    "In case if platform code need to use own special DMA
    configuration, it can use Platform bus notifier and
    handle BUS_NOTIFY_ADD_DEVICE event to fix up DMA
    configuration."

Solution (b) is what this commit does.  It uses its own set of
dma_ops which are wrappers around the arch_dma_ops.  The
wrappers translate the dma addresses before/after invoking
the arch_dma_ops, as appropriate.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/host/Makefile           |   4 +-
 drivers/pci/host/pcie-brcmstb-dma.c | 319 ++++++++++++++++++++++++++++++++++++
 drivers/pci/host/pcie-brcmstb.c     | 139 +++++++++++++++-
 drivers/pci/host/pcie-brcmstb.h     |  22 +++
 4 files changed, 474 insertions(+), 10 deletions(-)
 create mode 100644 drivers/pci/host/pcie-brcmstb-dma.c
 create mode 100644 drivers/pci/host/pcie-brcmstb.h

diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index a8b9923..6b94c9c 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -21,7 +21,9 @@ obj-$(CONFIG_PCIE_ROCKCHIP) += pcie-rockchip.o
 obj-$(CONFIG_PCIE_MEDIATEK) += pcie-mediatek.o
 obj-$(CONFIG_PCIE_TANGO_SMP8759) += pcie-tango.o
 obj-$(CONFIG_VMD) += vmd.o
-obj-$(CONFIG_PCIE_BRCMSTB) += pcie-brcmstb.o
+
+obj-$(CONFIG_PCIE_BRCMSTB) += brcmstb-pcie.o
+brcmstb-pcie-objs := pcie-brcmstb.o pcie-brcmstb-dma.o
 
 # The following drivers are for devices that use the generic ACPI
 # pci_root.c driver but don't support standard ECAM config access.
diff --git a/drivers/pci/host/pcie-brcmstb-dma.c b/drivers/pci/host/pcie-brcmstb-dma.c
new file mode 100644
index 0000000..6c397be
--- /dev/null
+++ b/drivers/pci/host/pcie-brcmstb-dma.c
@@ -0,0 +1,319 @@
+/*
+ * Copyright (C) 2015-2017 Broadcom
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ */
+#include <linux/dma-mapping.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_pci.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/smp.h>
+
+#include "pcie-brcmstb.h"
+
+static const struct dma_map_ops *arch_dma_ops;
+static const struct dma_map_ops *brcm_dma_ops_ptr;
+
+static dma_addr_t brcm_to_pci(dma_addr_t addr)
+{
+	struct of_pci_range *p;
+
+	if (!num_dma_ranges)
+		return addr;
+
+	for (p = dma_ranges; p < &dma_ranges[num_dma_ranges]; p++)
+		if (addr >= p->cpu_addr && addr < (p->cpu_addr + p->size))
+			return addr - p->cpu_addr + p->pci_addr;
+
+	return addr;
+}
+
+static dma_addr_t brcm_to_cpu(dma_addr_t addr)
+{
+	struct of_pci_range *p;
+
+	if (!num_dma_ranges)
+		return addr;
+
+	for (p = dma_ranges; p < &dma_ranges[num_dma_ranges]; p++)
+		if (addr >= p->pci_addr && addr < (p->pci_addr + p->size))
+			return addr - p->pci_addr + p->cpu_addr;
+
+	return addr;
+}
+
+static void *brcm_alloc(struct device *dev, size_t size, dma_addr_t *handle,
+			gfp_t gfp, unsigned long attrs)
+{
+	void *ret;
+
+	ret = arch_dma_ops->alloc(dev, size, handle, gfp, attrs);
+	if (ret)
+		*handle = brcm_to_pci(*handle);
+	return ret;
+}
+
+static void brcm_free(struct device *dev, size_t size, void *cpu_addr,
+		      dma_addr_t handle, unsigned long attrs)
+{
+	handle = brcm_to_cpu(handle);
+	arch_dma_ops->free(dev, size, cpu_addr, handle, attrs);
+}
+
+static int brcm_mmap(struct device *dev, struct vm_area_struct *vma,
+		     void *cpu_addr, dma_addr_t dma_addr, size_t size,
+		     unsigned long attrs)
+{
+	dma_addr = brcm_to_cpu(dma_addr);
+	return arch_dma_ops->mmap(dev, vma, cpu_addr, dma_addr, size, attrs);
+}
+
+static int brcm_get_sgtable(struct device *dev, struct sg_table *sgt,
+			    void *cpu_addr, dma_addr_t handle, size_t size,
+			    unsigned long attrs)
+{
+	handle = brcm_to_cpu(handle);
+	return arch_dma_ops->get_sgtable(dev, sgt, cpu_addr, handle, size,
+				       attrs);
+}
+
+static dma_addr_t brcm_map_page(struct device *dev, struct page *page,
+				unsigned long offset, size_t size,
+				enum dma_data_direction dir,
+				unsigned long attrs)
+{
+	return brcm_to_pci(arch_dma_ops->map_page(dev, page, offset, size,
+						  dir, attrs));
+}
+
+static void brcm_unmap_page(struct device *dev, dma_addr_t handle,
+			    size_t size, enum dma_data_direction dir,
+			    unsigned long attrs)
+{
+	handle = brcm_to_cpu(handle);
+	arch_dma_ops->unmap_page(dev, handle, size, dir, attrs);
+}
+
+static int brcm_map_sg(struct device *dev, struct scatterlist *sgl,
+		       int nents, enum dma_data_direction dir,
+		       unsigned long attrs)
+{
+	int i, j;
+	struct scatterlist *sg;
+
+	for_each_sg(sgl, sg, nents, i) {
+#ifdef CONFIG_NEED_SG_DMA_LENGTH
+		sg->dma_length = sg->length;
+#endif
+		sg->dma_address =
+			brcm_dma_ops_ptr->map_page(dev, sg_page(sg), sg->offset,
+						   sg->length, dir, attrs);
+		if (dma_mapping_error(dev, sg->dma_address))
+			goto bad_mapping;
+	}
+	return nents;
+
+bad_mapping:
+	for_each_sg(sgl, sg, i, j)
+		brcm_dma_ops_ptr->unmap_page(dev, sg_dma_address(sg),
+					     sg_dma_len(sg), dir, attrs);
+	return 0;
+}
+
+static void brcm_unmap_sg(struct device *dev,
+			  struct scatterlist *sgl, int nents,
+			  enum dma_data_direction dir,
+			  unsigned long attrs)
+{
+	int i;
+	struct scatterlist *sg;
+
+	for_each_sg(sgl, sg, nents, i)
+		brcm_dma_ops_ptr->unmap_page(dev, sg_dma_address(sg),
+					     sg_dma_len(sg), dir, attrs);
+}
+
+static void brcm_sync_single_for_cpu(struct device *dev,
+				     dma_addr_t handle, size_t size,
+				     enum dma_data_direction dir)
+{
+	handle = brcm_to_cpu(handle);
+	arch_dma_ops->sync_single_for_cpu(dev, handle, size, dir);
+}
+
+static void brcm_sync_single_for_device(struct device *dev,
+					dma_addr_t handle, size_t size,
+					enum dma_data_direction dir)
+{
+	handle = brcm_to_cpu(handle);
+	arch_dma_ops->sync_single_for_device(dev, handle, size, dir);
+}
+
+static dma_addr_t brcm_map_resource(struct device *dev, phys_addr_t phys,
+				    size_t size,
+				    enum dma_data_direction dir,
+				    unsigned long attrs)
+{
+	if (arch_dma_ops->map_resource)
+		return brcm_to_pci(arch_dma_ops->map_resource
+				   (dev, phys, size, dir, attrs));
+	return brcm_to_pci((dma_addr_t)phys);
+}
+
+static void brcm_unmap_resource(struct device *dev, dma_addr_t handle,
+				size_t size, enum dma_data_direction dir,
+				unsigned long attrs)
+{
+	if (arch_dma_ops->unmap_resource)
+		arch_dma_ops->unmap_resource(dev, brcm_to_cpu(handle), size,
+					     dir, attrs);
+}
+
+void brcm_sync_sg_for_cpu(struct device *dev, struct scatterlist *sgl,
+			  int nents, enum dma_data_direction dir)
+{
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(sgl, sg, nents, i)
+		brcm_dma_ops_ptr->sync_single_for_cpu(dev, sg_dma_address(sg),
+						      sg->length, dir);
+}
+
+void brcm_sync_sg_for_device(struct device *dev, struct scatterlist *sgl,
+			     int nents, enum dma_data_direction dir)
+{
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(sgl, sg, nents, i)
+		brcm_dma_ops_ptr->sync_single_for_device(dev,
+							 sg_dma_address(sg),
+							 sg->length, dir);
+}
+
+static int brcm_mapping_error(struct device *dev, dma_addr_t dma_addr)
+{
+	return arch_dma_ops->mapping_error(dev, dma_addr);
+}
+
+static int brcm_dma_supported(struct device *dev, u64 mask)
+{
+	if (num_dma_ranges) {
+		/*
+		 * It is our translated addresses that the EP will "see", so
+		 * we check all of the ranges for the largest possible value.
+		 */
+		int i;
+
+		for (i = 0; i < num_dma_ranges; i++)
+			if (dma_ranges[i].pci_addr + dma_ranges[i].size - 1
+			    > mask)
+				return 0;
+		return 1;
+	}
+
+	return arch_dma_ops->dma_supported(dev, mask);
+}
+
+#ifdef ARCH_HAS_DMA_GET_REQUIRED_MASK
+u64 brcm_get_required_mask)(struct device *dev)
+{
+	return arch_dma_ops->get_required_mask(dev);
+}
+#endif
+
+static const struct dma_map_ops brcm_dma_ops = {
+	.alloc			= brcm_alloc,
+	.free			= brcm_free,
+	.mmap			= brcm_mmap,
+	.get_sgtable		= brcm_get_sgtable,
+	.map_page		= brcm_map_page,
+	.unmap_page		= brcm_unmap_page,
+	.map_sg			= brcm_map_sg,
+	.unmap_sg		= brcm_unmap_sg,
+	.map_resource		= brcm_map_resource,
+	.unmap_resource		= brcm_unmap_resource,
+	.sync_single_for_cpu	= brcm_sync_single_for_cpu,
+	.sync_single_for_device	= brcm_sync_single_for_device,
+	.sync_sg_for_cpu	= brcm_sync_sg_for_cpu,
+	.sync_sg_for_device	= brcm_sync_sg_for_device,
+	.mapping_error		= brcm_mapping_error,
+	.dma_supported		= brcm_dma_supported,
+#ifdef ARCH_HAS_DMA_GET_REQUIRED_MASK
+	.get_required_mask	= brcm_get_required_mask,
+#endif
+};
+
+static void brcm_set_dma_ops(struct device *dev)
+{
+	int ret;
+
+	if (IS_ENABLED(CONFIG_ARM64)) {
+		/*
+		 * We are going to invoke get_dma_ops().  That
+		 * function, at this point in time, invokes
+		 * get_arch_dma_ops(), and for ARM64 that function
+		 * returns a pointer to dummy_dma_ops.  So then we'd
+		 * like to call arch_setup_dma_ops(), but that isn't
+		 * exported.  Instead, we call of_dma_configure(),
+		 * which is exported, and this calls
+		 * arch_setup_dma_ops().  Once we do this the call to
+		 * get_dma_ops() will work properly because
+		 * dev->dma_ops will be set.
+		 */
+		ret = of_dma_configure(dev, dev->of_node);
+		if (ret) {
+			dev_err(dev, "of_dma_configure() failed: %d\n", ret);
+			return;
+		}
+	}
+
+	arch_dma_ops = get_dma_ops(dev);
+	if (!arch_dma_ops) {
+		dev_err(dev, "failed to get arch_dma_ops\n");
+		return;
+	}
+
+	set_dma_ops(dev, &brcm_dma_ops);
+}
+
+static int brcmstb_platform_notifier(struct notifier_block *nb,
+				     unsigned long event, void *__dev)
+{
+	struct device *dev = __dev;
+
+	brcm_dma_ops_ptr = &brcm_dma_ops;
+	if (event != BUS_NOTIFY_ADD_DEVICE)
+		return NOTIFY_DONE;
+
+	brcm_set_dma_ops(dev);
+	return NOTIFY_OK;
+}
+
+static struct notifier_block brcmstb_platform_nb = {
+	.notifier_call = brcmstb_platform_notifier,
+};
+
+int brcm_register_notifier(void)
+{
+	return bus_register_notifier(&pci_bus_type, &brcmstb_platform_nb);
+}
+
+int brcm_unregister_notifier(void)
+{
+	return bus_unregister_notifier(&pci_bus_type, &brcmstb_platform_nb);
+}
diff --git a/drivers/pci/host/pcie-brcmstb.c b/drivers/pci/host/pcie-brcmstb.c
index d8a8f7a..5f4c6aa 100644
--- a/drivers/pci/host/pcie-brcmstb.c
+++ b/drivers/pci/host/pcie-brcmstb.c
@@ -35,6 +35,7 @@
 #include <soc/brcmstb/memory_api.h>
 #include <linux/string.h>
 #include <linux/types.h>
+#include "pcie-brcmstb.h"
 
 /* BRCM_PCIE_CAP_REGS - Offset for the mandatory capability config regs */
 #define BRCM_PCIE_CAP_REGS				0x00ac
@@ -332,6 +333,10 @@ static void __iomem *brcm_pcie_map_conf(struct pci_bus *bus, unsigned int devfn,
 	((val & ~reg##_##field##_MASK) | \
 	 (reg##_##field##_MASK & (field_val << reg##_##field##_SHIFT)))
 
+/* Also used by pci-brcmstb-dma.c */
+struct of_pci_range *dma_ranges;
+int num_dma_ranges;
+
 static struct list_head brcm_pcie = LIST_HEAD_INIT(brcm_pcie);
 static phys_addr_t scb_size[BRCM_MAX_SCB];
 static int num_memc;
@@ -642,25 +647,42 @@ static inline void brcm_pcie_perst_set(struct brcm_pcie *pcie,
 
 static int brcm_pcie_add_controller(struct brcm_pcie *pcie)
 {
+	int ret = 0;
+
 	mutex_lock(&brcm_pcie_lock);
+	if (list_empty(&brcm_pcie)) {
+		ret = brcm_register_notifier();
+		if (ret) {
+			dev_err(pcie->dev,
+				"failed to register pci bus notifier\n");
+			goto done;
+		}
+	}
 	list_add_tail(&pcie->list, &brcm_pcie);
+done:
 	mutex_unlock(&brcm_pcie_lock);
-
-	return 0;
+	return ret;
 }
 
 static void brcm_pcie_remove_controller(struct brcm_pcie *pcie)
 {
 	struct list_head *pos, *q;
 	struct brcm_pcie *tmp;
+	static const char *err_msg = "failed to unregister pci bus notifier\n";
 
 	mutex_lock(&brcm_pcie_lock);
 	list_for_each_safe(pos, q, &brcm_pcie) {
 		tmp = list_entry(pos, struct brcm_pcie, list);
 		if (tmp == pcie) {
 			list_del(pos);
-			if (list_empty(&brcm_pcie))
+			if (list_empty(&brcm_pcie)) {
+				if (brcm_unregister_notifier())
+					dev_err(pcie->dev, err_msg);
+				kfree(dma_ranges);
+				dma_ranges = NULL;
+				num_dma_ranges = 0;
 				num_memc = 0;
+			}
 			break;
 		}
 	}
@@ -712,6 +734,75 @@ static int brcm_pcie_parse_request_of_pci_ranges(struct brcm_pcie *pcie)
 	return 0;
 }
 
+static int pci_dma_range_parser_init(struct of_pci_range_parser *parser,
+				     struct device_node *node)
+{
+	const int na = 3, ns = 2;
+	int rlen;
+
+	parser->node = node;
+	parser->pna = of_n_addr_cells(node);
+	parser->np = parser->pna + na + ns;
+
+	parser->range = of_get_property(node, "dma-ranges", &rlen);
+	if (!parser->range)
+		return -ENOENT;
+
+	parser->end = parser->range + rlen / sizeof(__be32);
+
+	return 0;
+}
+
+static int brcm_pcie_parse_map_dma_ranges(struct brcm_pcie *pcie)
+{
+	int i, ret = 0;
+	struct of_pci_range_parser parser;
+	struct device_node *dn = pcie->dn;
+
+	mutex_lock(&brcm_pcie_lock);
+	if (dma_ranges)
+		goto done;
+
+	/*
+	 * Parse dma-ranges property if present.  If there are multiple
+	 * PCI controllers, we only have to parse from one of them since
+	 * the others will have an identical mapping.
+	 */
+	if (!pci_dma_range_parser_init(&parser, dn)) {
+		unsigned int max_ranges
+			= (parser.end - parser.range) / parser.np;
+
+		dma_ranges = kcalloc(max_ranges, sizeof(struct of_pci_range),
+				     GFP_KERNEL);
+		if (!dma_ranges) {
+			ret =  -ENOMEM;
+			goto done;
+		}
+		for (i = 0; of_pci_range_parser_one(&parser, dma_ranges + i);
+		     i++)
+			num_dma_ranges++;
+	}
+
+	for (i = 0, num_memc = 0; i < BRCM_MAX_SCB; i++) {
+		u64 size = brcmstb_memory_memc_size(i);
+
+		if (size == (u64)-1) {
+			dev_err(pcie->dev, "cannot get memc%d size", i);
+			ret = -EINVAL;
+			goto done;
+		} else if (size) {
+			scb_size[i] = roundup_pow_of_two_64(size);
+			num_memc++;
+		} else {
+			break;
+		}
+	}
+
+done:
+	mutex_unlock(&brcm_pcie_lock);
+	return ret;
+}
+
 static int brcm_pcie_setup(struct brcm_pcie *pcie)
 {
 	void __iomem *base = pcie->base;
@@ -781,6 +872,38 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	 */
 	rc_bar2_offset = 0;
 
+	if (dma_ranges) {
+		/*
+		 * The best-case scenario is to place the inbound
+		 * region in the first 4GB of pci-space, as some
+		 * legacy devices can only address 32bits.
+		 * We would also like to put the MSI under 4GB
+		 * as well, since some devices require a 32bit
+		 * MSI target address.
+		 */
+		if (total_mem_size <= 0xc0000000ULL &&
+		    rc_bar2_size <= 0x100000000ULL) {
+			rc_bar2_offset = 0;
+		} else {
+			/*
+			 * The system memory is 4GB or larger so we
+			 * cannot start the inbound region at location
+			 * 0 (since we have to allow some space for
+			 * outbound memory @ 3GB).  So instead we
+			 * start it at the 1x multiple of its size
+			 */
+			rc_bar2_offset = rc_bar2_size;
+		}
+
+	} else {
+		/*
+		 * Set simple configuration based on memory sizes
+		 * only.  We always start the viewport at address 0,
+		 * and set the MSI target address accordingly.
+		 */
+		rc_bar2_offset = 0;
+	}
+
 	tmp = lower_32_bits(rc_bar2_offset);
 	tmp = INSERT_FIELD(tmp, PCIE_MISC_RC_BAR2_CONFIG_LO, SIZE,
 			   encode_ibar_size(rc_bar2_size));
@@ -995,7 +1118,6 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	struct brcm_pcie *pcie;
 	struct resource *res;
 	void __iomem *base;
-	u32 tmp;
 	struct pci_host_bridge *bridge;
 	struct pci_bus *child;
 
@@ -1012,11 +1134,6 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	if (of_property_read_u32(dn, "dma-ranges", &tmp) == 0) {
-		dev_err(&pdev->dev, "cannot yet handle dma-ranges\n");
-		return -EINVAL;
-	}
-
 	data = of_id->data;
 	pcie->reg_offsets = data->offsets;
 	pcie->reg_field_info = data->reg_field_info;
@@ -1059,6 +1176,10 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = brcm_pcie_parse_map_dma_ranges(pcie);
+	if (ret)
+		return ret;
+
 	ret = clk_prepare_enable(pcie->clk);
 	if (ret) {
 		dev_err(&pdev->dev, "could not enable clock\n");
diff --git a/drivers/pci/host/pcie-brcmstb.h b/drivers/pci/host/pcie-brcmstb.h
new file mode 100644
index 0000000..d7233f0
--- /dev/null
+++ b/drivers/pci/host/pcie-brcmstb.h
@@ -0,0 +1,22 @@
+#ifndef __BRCMSTB_PCI_H
+#define __BRCMSTB_PCI_H
+/*
+ * Copyright (C) 2015 - 2017 Broadcom
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+int brcm_register_notifier(void);
+int brcm_unregister_notifier(void);
+
+extern struct of_pci_range *dma_ranges;
+extern int num_dma_ranges;
+
+#endif /* __BRCMSTB_PCI_H */
-- 
1.9.0.138.g2de3478
