Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Apr 2013 12:19:59 +0200 (CEST)
Received: from fw-tnat.cambridge.arm.com ([217.140.96.21]:35859 "EHLO
        cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6835173Ab3DPKTSXr18a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Apr 2013 12:19:18 +0200
Received: from localhost.localdomain (e106165-lin.cambridge.arm.com [10.1.197.23])
        by cam-smtp0.cambridge.arm.com (8.13.8/8.13.8) with ESMTP id r3GAIh8A000318;
        Tue, 16 Apr 2013 11:18:55 +0100
From:   Andrew Murray <Andrew.Murray@arm.com>
To:     linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org
Cc:     rob.herring@calxeda.com, jgunthorpe@obsidianresearch.com,
        linux@arm.linux.org.uk, siva.kallam@samsung.com,
        linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
        jg1.han@samsung.com, Liviu.Dudau@arm.com,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        kgene.kim@samsung.com, bhelgaas@google.com,
        suren.reddy@samsung.com, linux-arm-kernel@lists.infradead.org,
        monstr@monstr.eu, benh@kernel.crashing.org, paulus@samba.org,
        grant.likely@secretlab.ca, thomas.petazzoni@free-electrons.com,
        thierry.reding@avionic-design.de, thomas.abraham@linaro.org,
        arnd@arndb.de, linus.walleij@linaro.org,
        Andrew Murray <Andrew.Murray@arm.com>
Subject: [PATCH v7 1/3] of/pci: Unify pci_process_bridge_OF_ranges from Microblaze and PowerPC
Date:   Tue, 16 Apr 2013 11:18:26 +0100
Message-Id: <1366107508-12672-2-git-send-email-Andrew.Murray@arm.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1366107508-12672-1-git-send-email-Andrew.Murray@arm.com>
References: <1366107508-12672-1-git-send-email-Andrew.Murray@arm.com>
Return-Path: <Andrew.Murray@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36237
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Andrew.Murray@arm.com
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

The pci_process_bridge_OF_ranges function, used to parse the "ranges"
property of a PCI host device, is found in both Microblaze and PowerPC
architectures. These implementations are nearly identical. This patch
moves this common code to a common place.

Signed-off-by: Andrew Murray <Andrew.Murray@arm.com>
Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
Reviewed-by: Rob Herring <rob.herring@calxeda.com>
Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Tested-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Michal Simek <monstr@monstr.eu>
---
 arch/microblaze/include/asm/pci-bridge.h |    5 +-
 arch/microblaze/pci/pci-common.c         |  192 ----------------------------
 arch/powerpc/include/asm/pci-bridge.h    |    5 +-
 arch/powerpc/kernel/pci-common.c         |  192 ----------------------------
 drivers/of/of_pci.c                      |  200 ++++++++++++++++++++++++++++++
 include/linux/of_pci.h                   |    4 +
 6 files changed, 206 insertions(+), 392 deletions(-)

diff --git a/arch/microblaze/include/asm/pci-bridge.h b/arch/microblaze/include/asm/pci-bridge.h
index cb5d397..5783cd6 100644
--- a/arch/microblaze/include/asm/pci-bridge.h
+++ b/arch/microblaze/include/asm/pci-bridge.h
@@ -10,6 +10,7 @@
 #include <linux/pci.h>
 #include <linux/list.h>
 #include <linux/ioport.h>
+#include <linux/of_pci.h>
 
 struct device_node;
 
@@ -132,10 +133,6 @@ extern void setup_indirect_pci(struct pci_controller *hose,
 extern struct pci_controller *pci_find_hose_for_OF_device(
 			struct device_node *node);
 
-/* Fill up host controller resources from the OF node */
-extern void pci_process_bridge_OF_ranges(struct pci_controller *hose,
-			struct device_node *dev, int primary);
-
 /* Allocate & free a PCI host bridge structure */
 extern struct pci_controller *pcibios_alloc_controller(struct device_node *dev);
 extern void pcibios_free_controller(struct pci_controller *phb);
diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index 9ea521e..2735ad9 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -622,198 +622,6 @@ void pci_resource_to_user(const struct pci_dev *dev, int bar,
 	*end = rsrc->end - offset;
 }
 
-/**
- * pci_process_bridge_OF_ranges - Parse PCI bridge resources from device tree
- * @hose: newly allocated pci_controller to be setup
- * @dev: device node of the host bridge
- * @primary: set if primary bus (32 bits only, soon to be deprecated)
- *
- * This function will parse the "ranges" property of a PCI host bridge device
- * node and setup the resource mapping of a pci controller based on its
- * content.
- *
- * Life would be boring if it wasn't for a few issues that we have to deal
- * with here:
- *
- *   - We can only cope with one IO space range and up to 3 Memory space
- *     ranges. However, some machines (thanks Apple !) tend to split their
- *     space into lots of small contiguous ranges. So we have to coalesce.
- *
- *   - We can only cope with all memory ranges having the same offset
- *     between CPU addresses and PCI addresses. Unfortunately, some bridges
- *     are setup for a large 1:1 mapping along with a small "window" which
- *     maps PCI address 0 to some arbitrary high address of the CPU space in
- *     order to give access to the ISA memory hole.
- *     The way out of here that I've chosen for now is to always set the
- *     offset based on the first resource found, then override it if we
- *     have a different offset and the previous was set by an ISA hole.
- *
- *   - Some busses have IO space not starting at 0, which causes trouble with
- *     the way we do our IO resource renumbering. The code somewhat deals with
- *     it for 64 bits but I would expect problems on 32 bits.
- *
- *   - Some 32 bits platforms such as 4xx can have physical space larger than
- *     32 bits so we need to use 64 bits values for the parsing
- */
-void pci_process_bridge_OF_ranges(struct pci_controller *hose,
-				  struct device_node *dev, int primary)
-{
-	const u32 *ranges;
-	int rlen;
-	int pna = of_n_addr_cells(dev);
-	int np = pna + 5;
-	int memno = 0, isa_hole = -1;
-	u32 pci_space;
-	unsigned long long pci_addr, cpu_addr, pci_next, cpu_next, size;
-	unsigned long long isa_mb = 0;
-	struct resource *res;
-
-	pr_info("PCI host bridge %s %s ranges:\n",
-	       dev->full_name, primary ? "(primary)" : "");
-
-	/* Get ranges property */
-	ranges = of_get_property(dev, "ranges", &rlen);
-	if (ranges == NULL)
-		return;
-
-	/* Parse it */
-	pr_debug("Parsing ranges property...\n");
-	while ((rlen -= np * 4) >= 0) {
-		/* Read next ranges element */
-		pci_space = ranges[0];
-		pci_addr = of_read_number(ranges + 1, 2);
-		cpu_addr = of_translate_address(dev, ranges + 3);
-		size = of_read_number(ranges + pna + 3, 2);
-
-		pr_debug("pci_space: 0x%08x pci_addr:0x%016llx ",
-				pci_space, pci_addr);
-		pr_debug("cpu_addr:0x%016llx size:0x%016llx\n",
-					cpu_addr, size);
-
-		ranges += np;
-
-		/* If we failed translation or got a zero-sized region
-		 * (some FW try to feed us with non sensical zero sized regions
-		 * such as power3 which look like some kind of attempt
-		 * at exposing the VGA memory hole)
-		 */
-		if (cpu_addr == OF_BAD_ADDR || size == 0)
-			continue;
-
-		/* Now consume following elements while they are contiguous */
-		for (; rlen >= np * sizeof(u32);
-		     ranges += np, rlen -= np * 4) {
-			if (ranges[0] != pci_space)
-				break;
-			pci_next = of_read_number(ranges + 1, 2);
-			cpu_next = of_translate_address(dev, ranges + 3);
-			if (pci_next != pci_addr + size ||
-			    cpu_next != cpu_addr + size)
-				break;
-			size += of_read_number(ranges + pna + 3, 2);
-		}
-
-		/* Act based on address space type */
-		res = NULL;
-		switch ((pci_space >> 24) & 0x3) {
-		case 1:		/* PCI IO space */
-			pr_info("  IO 0x%016llx..0x%016llx -> 0x%016llx\n",
-			       cpu_addr, cpu_addr + size - 1, pci_addr);
-
-			/* We support only one IO range */
-			if (hose->pci_io_size) {
-				pr_info(" \\--> Skipped (too many) !\n");
-				continue;
-			}
-			/* On 32 bits, limit I/O space to 16MB */
-			if (size > 0x01000000)
-				size = 0x01000000;
-
-			/* 32 bits needs to map IOs here */
-			hose->io_base_virt = ioremap(cpu_addr, size);
-
-			/* Expect trouble if pci_addr is not 0 */
-			if (primary)
-				isa_io_base =
-					(unsigned long)hose->io_base_virt;
-			/* pci_io_size and io_base_phys always represent IO
-			 * space starting at 0 so we factor in pci_addr
-			 */
-			hose->pci_io_size = pci_addr + size;
-			hose->io_base_phys = cpu_addr - pci_addr;
-
-			/* Build resource */
-			res = &hose->io_resource;
-			res->flags = IORESOURCE_IO;
-			res->start = pci_addr;
-			break;
-		case 2:		/* PCI Memory space */
-		case 3:		/* PCI 64 bits Memory space */
-			pr_info(" MEM 0x%016llx..0x%016llx -> 0x%016llx %s\n",
-			       cpu_addr, cpu_addr + size - 1, pci_addr,
-			       (pci_space & 0x40000000) ? "Prefetch" : "");
-
-			/* We support only 3 memory ranges */
-			if (memno >= 3) {
-				pr_info(" \\--> Skipped (too many) !\n");
-				continue;
-			}
-			/* Handles ISA memory hole space here */
-			if (pci_addr == 0) {
-				isa_mb = cpu_addr;
-				isa_hole = memno;
-				if (primary || isa_mem_base == 0)
-					isa_mem_base = cpu_addr;
-				hose->isa_mem_phys = cpu_addr;
-				hose->isa_mem_size = size;
-			}
-
-			/* We get the PCI/Mem offset from the first range or
-			 * the, current one if the offset came from an ISA
-			 * hole. If they don't match, bugger.
-			 */
-			if (memno == 0 ||
-			    (isa_hole >= 0 && pci_addr != 0 &&
-			     hose->pci_mem_offset == isa_mb))
-				hose->pci_mem_offset = cpu_addr - pci_addr;
-			else if (pci_addr != 0 &&
-				 hose->pci_mem_offset != cpu_addr - pci_addr) {
-				pr_info(" \\--> Skipped (offset mismatch) !\n");
-				continue;
-			}
-
-			/* Build resource */
-			res = &hose->mem_resources[memno++];
-			res->flags = IORESOURCE_MEM;
-			if (pci_space & 0x40000000)
-				res->flags |= IORESOURCE_PREFETCH;
-			res->start = cpu_addr;
-			break;
-		}
-		if (res != NULL) {
-			res->name = dev->full_name;
-			res->end = res->start + size - 1;
-			res->parent = NULL;
-			res->sibling = NULL;
-			res->child = NULL;
-		}
-	}
-
-	/* If there's an ISA hole and the pci_mem_offset is -not- matching
-	 * the ISA hole offset, then we need to remove the ISA hole from
-	 * the resource list for that brige
-	 */
-	if (isa_hole >= 0 && hose->pci_mem_offset != isa_mb) {
-		unsigned int next = isa_hole + 1;
-		pr_info(" Removing ISA hole at 0x%016llx\n", isa_mb);
-		if (next < memno)
-			memmove(&hose->mem_resources[isa_hole],
-				&hose->mem_resources[next],
-				sizeof(struct resource) * (memno - next));
-		hose->mem_resources[--memno].flags = 0;
-	}
-}
-
 /* Decide whether to display the domain number in /proc */
 int pci_proc_domain(struct pci_bus *bus)
 {
diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 025a130..205bfba 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -10,6 +10,7 @@
 #include <linux/pci.h>
 #include <linux/list.h>
 #include <linux/ioport.h>
+#include <linux/of_pci.h>
 #include <asm-generic/pci-bridge.h>
 
 struct device_node;
@@ -231,10 +232,6 @@ extern int pcibios_map_io_space(struct pci_bus *bus);
 extern struct pci_controller *pci_find_hose_for_OF_device(
 			struct device_node* node);
 
-/* Fill up host controller resources from the OF node */
-extern void pci_process_bridge_OF_ranges(struct pci_controller *hose,
-			struct device_node *dev, int primary);
-
 /* Allocate & free a PCI host bridge structure */
 extern struct pci_controller *pcibios_alloc_controller(struct device_node *dev);
 extern void pcibios_free_controller(struct pci_controller *phb);
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index fa12ae4..6edf396 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -640,198 +640,6 @@ void pci_resource_to_user(const struct pci_dev *dev, int bar,
 	*end = rsrc->end - offset;
 }
 
-/**
- * pci_process_bridge_OF_ranges - Parse PCI bridge resources from device tree
- * @hose: newly allocated pci_controller to be setup
- * @dev: device node of the host bridge
- * @primary: set if primary bus (32 bits only, soon to be deprecated)
- *
- * This function will parse the "ranges" property of a PCI host bridge device
- * node and setup the resource mapping of a pci controller based on its
- * content.
- *
- * Life would be boring if it wasn't for a few issues that we have to deal
- * with here:
- *
- *   - We can only cope with one IO space range and up to 3 Memory space
- *     ranges. However, some machines (thanks Apple !) tend to split their
- *     space into lots of small contiguous ranges. So we have to coalesce.
- *
- *   - We can only cope with all memory ranges having the same offset
- *     between CPU addresses and PCI addresses. Unfortunately, some bridges
- *     are setup for a large 1:1 mapping along with a small "window" which
- *     maps PCI address 0 to some arbitrary high address of the CPU space in
- *     order to give access to the ISA memory hole.
- *     The way out of here that I've chosen for now is to always set the
- *     offset based on the first resource found, then override it if we
- *     have a different offset and the previous was set by an ISA hole.
- *
- *   - Some busses have IO space not starting at 0, which causes trouble with
- *     the way we do our IO resource renumbering. The code somewhat deals with
- *     it for 64 bits but I would expect problems on 32 bits.
- *
- *   - Some 32 bits platforms such as 4xx can have physical space larger than
- *     32 bits so we need to use 64 bits values for the parsing
- */
-void pci_process_bridge_OF_ranges(struct pci_controller *hose,
-				  struct device_node *dev, int primary)
-{
-	const u32 *ranges;
-	int rlen;
-	int pna = of_n_addr_cells(dev);
-	int np = pna + 5;
-	int memno = 0, isa_hole = -1;
-	u32 pci_space;
-	unsigned long long pci_addr, cpu_addr, pci_next, cpu_next, size;
-	unsigned long long isa_mb = 0;
-	struct resource *res;
-
-	printk(KERN_INFO "PCI host bridge %s %s ranges:\n",
-	       dev->full_name, primary ? "(primary)" : "");
-
-	/* Get ranges property */
-	ranges = of_get_property(dev, "ranges", &rlen);
-	if (ranges == NULL)
-		return;
-
-	/* Parse it */
-	while ((rlen -= np * 4) >= 0) {
-		/* Read next ranges element */
-		pci_space = ranges[0];
-		pci_addr = of_read_number(ranges + 1, 2);
-		cpu_addr = of_translate_address(dev, ranges + 3);
-		size = of_read_number(ranges + pna + 3, 2);
-		ranges += np;
-
-		/* If we failed translation or got a zero-sized region
-		 * (some FW try to feed us with non sensical zero sized regions
-		 * such as power3 which look like some kind of attempt at exposing
-		 * the VGA memory hole)
-		 */
-		if (cpu_addr == OF_BAD_ADDR || size == 0)
-			continue;
-
-		/* Now consume following elements while they are contiguous */
-		for (; rlen >= np * sizeof(u32);
-		     ranges += np, rlen -= np * 4) {
-			if (ranges[0] != pci_space)
-				break;
-			pci_next = of_read_number(ranges + 1, 2);
-			cpu_next = of_translate_address(dev, ranges + 3);
-			if (pci_next != pci_addr + size ||
-			    cpu_next != cpu_addr + size)
-				break;
-			size += of_read_number(ranges + pna + 3, 2);
-		}
-
-		/* Act based on address space type */
-		res = NULL;
-		switch ((pci_space >> 24) & 0x3) {
-		case 1:		/* PCI IO space */
-			printk(KERN_INFO
-			       "  IO 0x%016llx..0x%016llx -> 0x%016llx\n",
-			       cpu_addr, cpu_addr + size - 1, pci_addr);
-
-			/* We support only one IO range */
-			if (hose->pci_io_size) {
-				printk(KERN_INFO
-				       " \\--> Skipped (too many) !\n");
-				continue;
-			}
-#ifdef CONFIG_PPC32
-			/* On 32 bits, limit I/O space to 16MB */
-			if (size > 0x01000000)
-				size = 0x01000000;
-
-			/* 32 bits needs to map IOs here */
-			hose->io_base_virt = ioremap(cpu_addr, size);
-
-			/* Expect trouble if pci_addr is not 0 */
-			if (primary)
-				isa_io_base =
-					(unsigned long)hose->io_base_virt;
-#endif /* CONFIG_PPC32 */
-			/* pci_io_size and io_base_phys always represent IO
-			 * space starting at 0 so we factor in pci_addr
-			 */
-			hose->pci_io_size = pci_addr + size;
-			hose->io_base_phys = cpu_addr - pci_addr;
-
-			/* Build resource */
-			res = &hose->io_resource;
-			res->flags = IORESOURCE_IO;
-			res->start = pci_addr;
-			break;
-		case 2:		/* PCI Memory space */
-		case 3:		/* PCI 64 bits Memory space */
-			printk(KERN_INFO
-			       " MEM 0x%016llx..0x%016llx -> 0x%016llx %s\n",
-			       cpu_addr, cpu_addr + size - 1, pci_addr,
-			       (pci_space & 0x40000000) ? "Prefetch" : "");
-
-			/* We support only 3 memory ranges */
-			if (memno >= 3) {
-				printk(KERN_INFO
-				       " \\--> Skipped (too many) !\n");
-				continue;
-			}
-			/* Handles ISA memory hole space here */
-			if (pci_addr == 0) {
-				isa_mb = cpu_addr;
-				isa_hole = memno;
-				if (primary || isa_mem_base == 0)
-					isa_mem_base = cpu_addr;
-				hose->isa_mem_phys = cpu_addr;
-				hose->isa_mem_size = size;
-			}
-
-			/* We get the PCI/Mem offset from the first range or
-			 * the, current one if the offset came from an ISA
-			 * hole. If they don't match, bugger.
-			 */
-			if (memno == 0 ||
-			    (isa_hole >= 0 && pci_addr != 0 &&
-			     hose->pci_mem_offset == isa_mb))
-				hose->pci_mem_offset = cpu_addr - pci_addr;
-			else if (pci_addr != 0 &&
-				 hose->pci_mem_offset != cpu_addr - pci_addr) {
-				printk(KERN_INFO
-				       " \\--> Skipped (offset mismatch) !\n");
-				continue;
-			}
-
-			/* Build resource */
-			res = &hose->mem_resources[memno++];
-			res->flags = IORESOURCE_MEM;
-			if (pci_space & 0x40000000)
-				res->flags |= IORESOURCE_PREFETCH;
-			res->start = cpu_addr;
-			break;
-		}
-		if (res != NULL) {
-			res->name = dev->full_name;
-			res->end = res->start + size - 1;
-			res->parent = NULL;
-			res->sibling = NULL;
-			res->child = NULL;
-		}
-	}
-
-	/* If there's an ISA hole and the pci_mem_offset is -not- matching
-	 * the ISA hole offset, then we need to remove the ISA hole from
-	 * the resource list for that brige
-	 */
-	if (isa_hole >= 0 && hose->pci_mem_offset != isa_mb) {
-		unsigned int next = isa_hole + 1;
-		printk(KERN_INFO " Removing ISA hole at 0x%016llx\n", isa_mb);
-		if (next < memno)
-			memmove(&hose->mem_resources[isa_hole],
-				&hose->mem_resources[next],
-				sizeof(struct resource) * (memno - next));
-		hose->mem_resources[--memno].flags = 0;
-	}
-}
-
 /* Decide whether to display the domain number in /proc */
 int pci_proc_domain(struct pci_bus *bus)
 {
diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
index 13e37e2..1626172 100644
--- a/drivers/of/of_pci.c
+++ b/drivers/of/of_pci.c
@@ -4,6 +4,10 @@
 #include <linux/of_pci.h>
 #include <asm/prom.h>
 
+#if defined(CONFIG_PPC32) || defined(CONFIG_PPC64) || defined(CONFIG_MICROBLAZE)
+#include <asm/pci-bridge.h>
+#endif
+
 static inline int __of_pci_pci_compare(struct device_node *node,
 				       unsigned int devfn)
 {
@@ -40,3 +44,199 @@ struct device_node *of_pci_find_child_device(struct device_node *parent,
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(of_pci_find_child_device);
+
+/**
+ * pci_process_bridge_OF_ranges - Parse PCI bridge resources from device tree
+ * @hose: newly allocated pci_controller to be setup
+ * @dev: device node of the host bridge
+ * @primary: set if primary bus (32 bits only, soon to be deprecated)
+ *
+ * This function will parse the "ranges" property of a PCI host bridge device
+ * node and setup the resource mapping of a pci controller based on its
+ * content.
+ *
+ * Life would be boring if it wasn't for a few issues that we have to deal
+ * with here:
+ *
+ *   - We can only cope with one IO space range and up to 3 Memory space
+ *     ranges. However, some machines (thanks Apple !) tend to split their
+ *     space into lots of small contiguous ranges. So we have to coalesce.
+ *
+ *   - We can only cope with all memory ranges having the same offset
+ *     between CPU addresses and PCI addresses. Unfortunately, some bridges
+ *     are setup for a large 1:1 mapping along with a small "window" which
+ *     maps PCI address 0 to some arbitrary high address of the CPU space in
+ *     order to give access to the ISA memory hole.
+ *     The way out of here that I've chosen for now is to always set the
+ *     offset based on the first resource found, then override it if we
+ *     have a different offset and the previous was set by an ISA hole.
+ *
+ *   - Some busses have IO space not starting at 0, which causes trouble with
+ *     the way we do our IO resource renumbering. The code somewhat deals with
+ *     it for 64 bits but I would expect problems on 32 bits.
+ *
+ *   - Some 32 bits platforms such as 4xx can have physical space larger than
+ *     32 bits so we need to use 64 bits values for the parsing
+ */
+#if defined(CONFIG_PPC32) || defined(CONFIG_PPC64) || defined(CONFIG_MICROBLAZE)
+void pci_process_bridge_OF_ranges(struct pci_controller *hose,
+				  struct device_node *dev, int primary)
+{
+	const u32 *ranges;
+	int rlen;
+	int pna = of_n_addr_cells(dev);
+	int np = pna + 5;
+	int memno = 0, isa_hole = -1;
+	u32 pci_space;
+	unsigned long long pci_addr, cpu_addr, pci_next, cpu_next, size;
+	unsigned long long isa_mb = 0;
+	struct resource *res;
+
+	pr_info("PCI host bridge %s %s ranges:\n",
+	       dev->full_name, primary ? "(primary)" : "");
+
+	/* Get ranges property */
+	ranges = of_get_property(dev, "ranges", &rlen);
+	if (ranges == NULL)
+		return;
+
+	/* Parse it */
+	pr_debug("Parsing ranges property...\n");
+	while ((rlen -= np * 4) >= 0) {
+		/* Read next ranges element */
+		pci_space = ranges[0];
+		pci_addr = of_read_number(ranges + 1, 2);
+		cpu_addr = of_translate_address(dev, ranges + 3);
+		size = of_read_number(ranges + pna + 3, 2);
+
+		pr_debug("pci_space: 0x%08x pci_addr:0x%016llx ",
+				pci_space, pci_addr);
+		pr_debug("cpu_addr:0x%016llx size:0x%016llx\n",
+					cpu_addr, size);
+
+		ranges += np;
+
+		/* If we failed translation or got a zero-sized region
+		 * (some FW try to feed us with non sensical zero sized regions
+		 * such as power3 which look like some kind of attempt
+		 * at exposing the VGA memory hole)
+		 */
+		if (cpu_addr == OF_BAD_ADDR || size == 0)
+			continue;
+
+		/* Now consume following elements while they are contiguous */
+		for (; rlen >= np * sizeof(u32);
+		     ranges += np, rlen -= np * 4) {
+			if (ranges[0] != pci_space)
+				break;
+			pci_next = of_read_number(ranges + 1, 2);
+			cpu_next = of_translate_address(dev, ranges + 3);
+			if (pci_next != pci_addr + size ||
+			    cpu_next != cpu_addr + size)
+				break;
+			size += of_read_number(ranges + pna + 3, 2);
+		}
+
+		/* Act based on address space type */
+		res = NULL;
+		switch ((pci_space >> 24) & 0x3) {
+		case 1:		/* PCI IO space */
+			pr_info("  IO 0x%016llx..0x%016llx -> 0x%016llx\n",
+			       cpu_addr, cpu_addr + size - 1, pci_addr);
+
+			/* We support only one IO range */
+			if (hose->pci_io_size) {
+				pr_info(" \\--> Skipped (too many) !\n");
+				continue;
+			}
+#if (!IS_ENABLED(CONFIG_64BIT))
+			/* On 32 bits, limit I/O space to 16MB */
+			if (size > 0x01000000)
+				size = 0x01000000;
+
+			/* 32 bits needs to map IOs here */
+			hose->io_base_virt = ioremap(cpu_addr, size);
+
+			/* Expect trouble if pci_addr is not 0 */
+			if (primary)
+				isa_io_base =
+					(unsigned long)hose->io_base_virt;
+#endif /* !CONFIG_64BIT */
+			/* pci_io_size and io_base_phys always represent IO
+			 * space starting at 0 so we factor in pci_addr
+			 */
+			hose->pci_io_size = pci_addr + size;
+			hose->io_base_phys = cpu_addr - pci_addr;
+
+			/* Build resource */
+			res = &hose->io_resource;
+			res->flags = IORESOURCE_IO;
+			res->start = pci_addr;
+			break;
+		case 2:		/* PCI Memory space */
+		case 3:		/* PCI 64 bits Memory space */
+			pr_info(" MEM 0x%016llx..0x%016llx -> 0x%016llx %s\n",
+			       cpu_addr, cpu_addr + size - 1, pci_addr,
+			       (pci_space & 0x40000000) ? "Prefetch" : "");
+
+			/* We support only 3 memory ranges */
+			if (memno >= 3) {
+				pr_info(" \\--> Skipped (too many) !\n");
+				continue;
+			}
+			/* Handles ISA memory hole space here */
+			if (pci_addr == 0) {
+				isa_mb = cpu_addr;
+				isa_hole = memno;
+				if (primary || isa_mem_base == 0)
+					isa_mem_base = cpu_addr;
+				hose->isa_mem_phys = cpu_addr;
+				hose->isa_mem_size = size;
+			}
+
+			/* We get the PCI/Mem offset from the first range or
+			 * the, current one if the offset came from an ISA
+			 * hole. If they don't match, bugger.
+			 */
+			if (memno == 0 ||
+			    (isa_hole >= 0 && pci_addr != 0 &&
+			     hose->pci_mem_offset == isa_mb))
+				hose->pci_mem_offset = cpu_addr - pci_addr;
+			else if (pci_addr != 0 &&
+				 hose->pci_mem_offset != cpu_addr - pci_addr) {
+				pr_info(" \\--> Skipped (offset mismatch) !\n");
+				continue;
+			}
+
+			/* Build resource */
+			res = &hose->mem_resources[memno++];
+			res->flags = IORESOURCE_MEM;
+			if (pci_space & 0x40000000)
+				res->flags |= IORESOURCE_PREFETCH;
+			res->start = cpu_addr;
+			break;
+		}
+		if (res != NULL) {
+			res->name = dev->full_name;
+			res->end = res->start + size - 1;
+			res->parent = NULL;
+			res->sibling = NULL;
+			res->child = NULL;
+		}
+	}
+
+	/* If there's an ISA hole and the pci_mem_offset is -not- matching
+	 * the ISA hole offset, then we need to remove the ISA hole from
+	 * the resource list for that brige
+	 */
+	if (isa_hole >= 0 && hose->pci_mem_offset != isa_mb) {
+		unsigned int next = isa_hole + 1;
+		pr_info(" Removing ISA hole at 0x%016llx\n", isa_mb);
+		if (next < memno)
+			memmove(&hose->mem_resources[isa_hole],
+				&hose->mem_resources[next],
+				sizeof(struct resource) * (memno - next));
+		hose->mem_resources[--memno].flags = 0;
+	}
+}
+#endif
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index bb115de..33e8ead 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -11,4 +11,8 @@ struct device_node;
 struct device_node *of_pci_find_child_device(struct device_node *parent,
 					     unsigned int devfn);
 
+struct pci_controller;
+void pci_process_bridge_OF_ranges(struct pci_controller *hose,
+			struct device_node *dev, int primary);
+
 #endif
-- 
1.7.0.4
