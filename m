Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 May 2012 12:51:50 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:50452 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903663Ab2EDKvn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 May 2012 12:51:43 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH V4 02/14] MIPS: pci: parse memory ranges from devicetree
Date:   Fri,  4 May 2012 12:50:13 +0200
Message-Id: <1336128613-7661-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.9.1
X-archive-position: 33137
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Implement pci_load_of_ranges on MIPS. Due to lack of test hardware only 32bit
bus width is supported. This function is based on pci_process_bridge_OF_ranges
from powerpc.

Signed-off-by: John Crispin <blogic@openwrt.org>

---
Changes in V2
* remove some #ifdefs
* rename to pci_load_of_ranges

Changes in V3
* set pointers to NULL and not 0

Changes in V4
* use u64 rather than unsigned long long
* make sure pci_space has the correct endianess

 arch/mips/include/asm/pci.h |    6 ++++
 arch/mips/pci/pci.c         |   55 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
index fcd4060..90bf3b3 100644
--- a/arch/mips/include/asm/pci.h
+++ b/arch/mips/include/asm/pci.h
@@ -17,6 +17,7 @@
  */
 
 #include <linux/ioport.h>
+#include <linux/of.h>
 
 /*
  * Each pci channel is a top-level PCI bus seem by CPU.  A machine  with
@@ -26,6 +27,7 @@
 struct pci_controller {
 	struct pci_controller *next;
 	struct pci_bus *bus;
+	struct device_node *of_node;
 
 	struct pci_ops *pci_ops;
 	struct resource *mem_resource;
@@ -142,4 +144,8 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 
 extern char * (*pcibios_plat_setup)(char *str);
 
+/* this function parses memory ranges from a device node */
+extern void __devinit pci_load_of_ranges(struct pci_controller *hose,
+					 struct device_node *node);
+
 #endif /* _ASM_PCI_H */
diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index 0514866..271e8c4a 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/pci.h>
+#include <linux/of_address.h>
 
 #include <asm/cpu-info.h>
 
@@ -114,9 +115,63 @@ static void __devinit pcibios_scanbus(struct pci_controller *hose)
 			pci_bus_assign_resources(bus);
 			pci_enable_bridges(bus);
 		}
+		bus->dev.of_node = hose->of_node;
 	}
 }
 
+#ifdef CONFIG_OF
+void __devinit pci_load_of_ranges(struct pci_controller *hose,
+				struct device_node *node)
+{
+	const __be32 *ranges;
+	int rlen;
+	int pna = of_n_addr_cells(node);
+	int np = pna + 5;
+
+	pr_info("PCI host bridge %s ranges:\n", node->full_name);
+	ranges = of_get_property(node, "ranges", &rlen);
+	if (ranges == NULL)
+		return;
+	hose->of_node = node;
+
+	while ((rlen -= np * 4) >= 0) {
+		u32 pci_space;
+		struct resource *res = NULL;
+		u64 addr, size;
+
+		pci_space = be32_to_cpup(&ranges[0]);
+		addr = of_translate_address(node, ranges + 3);
+		size = of_read_number(ranges + pna + 3, 2);
+		ranges += np;
+		switch ((pci_space >> 24) & 0x3) {
+		case 1:		/* PCI IO space */
+			pr_info("  IO 0x%016llx..0x%016llx\n",
+					addr, addr + size - 1);
+			hose->io_map_base =
+				(unsigned long)ioremap(addr, size);
+			res = hose->io_resource;
+			res->flags = IORESOURCE_IO;
+			break;
+		case 2:		/* PCI Memory space */
+		case 3:		/* PCI 64 bits Memory space */
+			pr_info(" MEM 0x%016llx..0x%016llx\n",
+					addr, addr + size - 1);
+			res = hose->mem_resource;
+			res->flags = IORESOURCE_MEM;
+			break;
+		}
+		if (res != NULL) {
+			res->start = addr;
+			res->name = node->full_name;
+			res->end = res->start + size - 1;
+			res->parent = NULL;
+			res->sibling = NULL;
+			res->child = NULL;
+		}
+	}
+}
+#endif
+
 static DEFINE_MUTEX(pci_scan_mutex);
 
 void __devinit register_pci_controller(struct pci_controller *hose)
-- 
1.7.9.1
