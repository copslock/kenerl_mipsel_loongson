Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Feb 2017 07:15:29 +0100 (CET)
Received: from smtp.gentoo.org ([140.211.166.183]:34046 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992127AbdBGGOMQ3X9r (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 7 Feb 2017 07:14:12 +0100
Received: from helcaraxe.arda (c-73-201-78-97.hsd1.md.comcast.net [73.201.78.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kumba)
        by smtp.gentoo.org (Postfix) with ESMTPSA id CD5AD34169E;
        Tue,  7 Feb 2017 06:14:05 +0000 (UTC)
From:   Joshua Kinard <kumba@gentoo.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux/MIPS <linux-mips@linux-mips.org>
Subject: [PATCH 03/12] MIPS: PCI: Minor clean-ups to pci-legacy.c
Date:   Tue,  7 Feb 2017 01:13:47 -0500
Message-Id: <20170207061356.8270-4-kumba@gentoo.org>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <20170207061356.8270-1-kumba@gentoo.org>
References: <20170207061356.8270-1-kumba@gentoo.org>
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56677
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

From: Joshua Kinard <kumba@gentoo.org>

Apply several minor clean-ups to arch/mips/pci/pci-legacy.c:
 - Collapse one-line comments to use a single /* ... */
 - Move 2nd arg to pci_add_resource_offset up a line
 - Put a pr_info message all on one line (checkpatch)
 - Replace several printk's with pr_info/pr_warn/pr_err
 - Add whitespace around operators in for loop and conditional

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
---
 arch/mips/pci/pci-legacy.c | 48 ++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/arch/mips/pci/pci-legacy.c b/arch/mips/pci/pci-legacy.c
index 014649be158d..98f36ed8f7da 100644
--- a/arch/mips/pci/pci-legacy.c
+++ b/arch/mips/pci/pci-legacy.c
@@ -58,9 +58,7 @@ pcibios_align_resource(void *data, const struct resource *res,
 		if (start < PCIBIOS_MIN_IO + hose->io_resource->start)
 			start = PCIBIOS_MIN_IO + hose->io_resource->start;
 
-		/*
-		 * Put everything into 0x00-0xff region modulo 0x400
-		 */
+		/* Put everything into 0x00-0xff region modulo 0x400 */
 		if (start & 0x300)
 			start = (start + 0x3ff) & ~0x3ff;
 	} else if (res->flags & IORESOURCE_MEM) {
@@ -82,12 +80,12 @@ static void pcibios_scanbus(struct pci_controller *hose)
 	if (hose->get_busno && pci_has_flag(PCI_PROBE_ONLY))
 		next_busno = (*hose->get_busno)();
 
-	pci_add_resource_offset(&resources,
-				hose->mem_resource, hose->mem_offset);
-	pci_add_resource_offset(&resources,
-				hose->io_resource, hose->io_offset);
-	pci_add_resource_offset(&resources,
-				hose->busn_resource, hose->busn_offset);
+	pci_add_resource_offset(&resources, hose->mem_resource,
+				hose->mem_offset);
+	pci_add_resource_offset(&resources, hose->io_resource,
+				hose->io_offset);
+	pci_add_resource_offset(&resources, hose->busn_resource,
+				hose->busn_offset);
 	bus = pci_scan_root_bus(NULL, next_busno, hose->pci_ops, hose,
 				&resources);
 	hose->bus = bus;
@@ -139,18 +137,16 @@ void pci_load_of_ranges(struct pci_controller *hose, struct device_node *node)
 
 		switch (range.flags & IORESOURCE_TYPE_BITS) {
 		case IORESOURCE_IO:
-			pr_info("  IO 0x%016llx..0x%016llx\n",
-				range.cpu_addr,
-				range.cpu_addr + range.size - 1);
+			pr_info("  IO 0x%016llx..0x%016llx\n", range.cpu_addr,
+				(range.cpu_addr + range.size - 1));
 			hose->io_map_base =
 				(unsigned long)ioremap(range.cpu_addr,
 						       range.size);
 			res = hose->io_resource;
 			break;
 		case IORESOURCE_MEM:
-			pr_info(" MEM 0x%016llx..0x%016llx\n",
-				range.cpu_addr,
-				range.cpu_addr + range.size - 1);
+			pr_info(" MEM 0x%016llx..0x%016llx\n", range.cpu_addr,
+				(range.cpu_addr + range.size - 1));
 			res = hose->mem_resource;
 			break;
 		}
@@ -195,10 +191,8 @@ void register_pci_controller(struct pci_controller *hose)
 	/*
 	 * Do not panic here but later - this might happen before console init.
 	 */
-	if (!hose->io_map_base) {
-		printk(KERN_WARNING
-		       "registering PCI controller with io_map_base unset\n");
-	}
+	if (!hose->io_map_base)
+		pr_warn("registering PCI controller with io_map_base unset\n");
 
 	/*
 	 * Scan the bus if it is register after the PCI subsystem
@@ -213,8 +207,7 @@ void register_pci_controller(struct pci_controller *hose)
 	return;
 
 out:
-	printk(KERN_WARNING
-	       "Skipping PCI bus scan due to resource conflict\n");
+	pr_warn("Skipping PCI bus scan due to resource conflict\n");
 }
 
 static int __init pcibios_init(void)
@@ -242,9 +235,9 @@ static int pcibios_enable_resources(struct pci_dev *dev, int mask)
 
 	pci_read_config_word(dev, PCI_COMMAND, &cmd);
 	old_cmd = cmd;
-	for (idx=0; idx < PCI_NUM_RESOURCES; idx++) {
+	for (idx = 0; idx < PCI_NUM_RESOURCES; idx++) {
 		/* Only set up the requested stuff */
-		if (!(mask & (1<<idx)))
+		if (!(mask & (1 << idx)))
 			continue;
 
 		r = &dev->resource[idx];
@@ -254,8 +247,7 @@ static int pcibios_enable_resources(struct pci_dev *dev, int mask)
 				(!(r->flags & IORESOURCE_ROM_ENABLE)))
 			continue;
 		if (!r->start && r->end) {
-			printk(KERN_ERR "PCI: Device %s not available "
-			       "because of resource collisions\n",
+			pr_err("PCI: Device %s not available because of resource collisions\n",
 			       pci_name(dev));
 			return -EINVAL;
 		}
@@ -265,10 +257,11 @@ static int pcibios_enable_resources(struct pci_dev *dev, int mask)
 			cmd |= PCI_COMMAND_MEMORY;
 	}
 	if (cmd != old_cmd) {
-		printk("PCI: Enabling device %s (%04x -> %04x)\n",
-		       pci_name(dev), old_cmd, cmd);
+		pr_info("PCI: Enabling device %s (%04x -> %04x)\n",
+			pci_name(dev), old_cmd, cmd);
 		pci_write_config_word(dev, PCI_COMMAND, cmd);
 	}
+
 	return 0;
 }
 
@@ -298,5 +291,6 @@ char *__init pcibios_setup(char *str)
 {
 	if (pcibios_plat_setup)
 		return pcibios_plat_setup(str);
+
 	return str;
 }
-- 
2.11.1
