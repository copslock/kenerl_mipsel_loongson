Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Sep 2011 04:58:00 +0200 (CEST)
Received: from dns1.mips.com ([12.201.5.69]:49985 "EHLO dns1.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491201Ab1IAC5c (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 1 Sep 2011 04:57:32 +0200
Received: from exchdb01.mips.com (exchhub01.mips.com [192.168.36.84])
        by dns1.mips.com (8.13.8/8.13.8) with ESMTP id p812mqFv000538;
        Wed, 31 Aug 2011 19:48:53 -0700
Received: from fun-lab.MIPSCN.CEC (192.168.225.107) by exchhub01.mips.com
 (192.168.36.84) with Microsoft SMTP Server id 14.1.270.1; Wed, 31 Aug 2011
 19:48:47 -0700
From:   Deng-Cheng Zhu <dczhu@mips.com>
To:     <bhelgaas@google.com>, <jbarnes@virtuousgeek.org>,
        <ralf@linux-mips.org>, <monstr@monstr.eu>,
        <benh@kernel.crashing.org>, <paulus@samba.org>,
        <davem@davemloft.net>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <hpa@zytor.com>, <x86@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <eyal@mips.com>, <zenon@mips.com>,
        <dczhu@mips.com>, <dengcheng.zhu@gmail.com>
Subject: [RESEND PATCH v3 1/2] PCI: Pass available resources into pci_create_bus()
Date:   Thu, 1 Sep 2011 10:48:28 +0800
Message-ID: <1314845309-3277-2-git-send-email-dczhu@mips.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1314845309-3277-1-git-send-email-dczhu@mips.com>
References: <1314845309-3277-1-git-send-email-dczhu@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EMS-Proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
X-EMS-STAMP: 2gIJ6+cDy8UI0H/cL/LiXg==
X-archive-position: 31026
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dczhu@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 138

Currently, after pci_create_bus(), resources available on the bus could be
handled by pci_scan_child_bus(). The problem is that, in
pci_scan_child_bus(), before calling arch-dependent pcibios_fixup_bus(),
PCI quirks will probably conflict (while doing pci_claim_resource()) with
resources like system controller's I/O resource that have not yet been
added to the bus. One can see that, by default, ioport_resource and
iomem_resource are filled into the bus->resource[] array as the initial
resources in pci_create_bus(). So, to avoid such conflicts, add those
really available resources right before returning the newly created bus in
pci_create_bus() whose interface should then be extended to receive them.

A related discussion thread can be found here:
http://www.spinics.net/lists/mips/msg41654.html

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Deng-Cheng Zhu <dczhu@mips.com>
---
Changes (v3 - v2):
None

Changes (v2 - v1):
o Add more info to the patch description.
o Fix arch breaks in default resource setup discovered by Bjorn Helgaas.

 arch/microblaze/pci/pci-common.c |    3 ++-
 arch/powerpc/kernel/pci-common.c |    3 ++-
 arch/sparc/kernel/pci.c          |    3 ++-
 arch/x86/pci/acpi.c              |    2 +-
 drivers/pci/probe.c              |   15 +++++++++++----
 include/linux/pci.h              |    3 ++-
 6 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index 4cfae20..9c35aa6 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -1581,7 +1581,8 @@ static void __devinit pcibios_scan_phb(struct pci_controller *hose)
 		 node ? node->full_name : "<NO NAME>");
 
 	/* Create an empty bus for the toplevel */
-	bus = pci_create_bus(hose->parent, hose->first_busno, hose->ops, hose);
+	bus = pci_create_bus(hose->parent, hose->first_busno,
+			     hose->ops, hose, NULL);
 	if (bus == NULL) {
 		printk(KERN_ERR "Failed to create bus for PCI domain %04x\n",
 		       hose->global_number);
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 32656f1..2ede26a 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1703,7 +1703,8 @@ void __devinit pcibios_scan_phb(struct pci_controller *hose)
 		 node ? node->full_name : "<NO NAME>");
 
 	/* Create an empty bus for the toplevel */
-	bus = pci_create_bus(hose->parent, hose->first_busno, hose->ops, hose);
+	bus = pci_create_bus(hose->parent, hose->first_busno,
+			     hose->ops, hose, NULL);
 	if (bus == NULL) {
 		pr_err("Failed to create bus for PCI domain %04x\n",
 			hose->global_number);
diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 1e94f94..77c38bb 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -689,7 +689,8 @@ struct pci_bus * __devinit pci_scan_one_pbm(struct pci_pbm_info *pbm,
 
 	printk("PCI: Scanning PBM %s\n", node->full_name);
 
-	bus = pci_create_bus(parent, pbm->pci_first_busno, pbm->pci_ops, pbm);
+	bus = pci_create_bus(parent, pbm->pci_first_busno,
+			     pbm->pci_ops, pbm, NULL);
 	if (!bus) {
 		printk(KERN_ERR "Failed to create bus for %s\n",
 		       node->full_name);
diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index c953302..bab2113 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -353,7 +353,7 @@ struct pci_bus * __devinit pci_acpi_scan_root(struct acpi_pci_root *root)
 		memcpy(bus->sysdata, sd, sizeof(*sd));
 		kfree(sd);
 	} else {
-		bus = pci_create_bus(NULL, busnum, &pci_root_ops, sd);
+		bus = pci_create_bus(NULL, busnum, &pci_root_ops, sd, NULL);
 		if (bus) {
 			get_current_resources(device, busnum, domain, bus);
 			bus->subordinate = pci_scan_child_bus(bus);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 8473727..47a364c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1516,7 +1516,8 @@ unsigned int __devinit pci_scan_child_bus(struct pci_bus *bus)
 }
 
 struct pci_bus * pci_create_bus(struct device *parent,
-		int bus, struct pci_ops *ops, void *sysdata)
+		int bus, struct pci_ops *ops, void *sysdata,
+		struct pci_bus_resource *bus_res)
 {
 	int error;
 	struct pci_bus *b, *b2;
@@ -1570,8 +1571,14 @@ struct pci_bus * pci_create_bus(struct device *parent,
 	pci_create_legacy_files(b);
 
 	b->number = b->secondary = bus;
-	b->resource[0] = &ioport_resource;
-	b->resource[1] = &iomem_resource;
+
+	/* Add initial resources to the bus */
+	if (bus_res != NULL)
+		list_add_tail(&b->resources, &bus_res->list);
+	else {
+		b->resource[0] = &ioport_resource;
+		b->resource[1] = &iomem_resource;
+	}
 
 	return b;
 
@@ -1592,7 +1599,7 @@ struct pci_bus * __devinit pci_scan_bus_parented(struct device *parent,
 {
 	struct pci_bus *b;
 
-	b = pci_create_bus(parent, bus, ops, sysdata);
+	b = pci_create_bus(parent, bus, ops, sysdata, NULL);
 	if (b)
 		b->subordinate = pci_scan_child_bus(b);
 	return b;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8c230cb..5e1bacd 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -666,7 +666,8 @@ static inline struct pci_bus * __devinit pci_scan_bus(int bus, struct pci_ops *o
 	return root_bus;
 }
 struct pci_bus *pci_create_bus(struct device *parent, int bus,
-			       struct pci_ops *ops, void *sysdata);
+			       struct pci_ops *ops, void *sysdata,
+			       struct pci_bus_resource *bus_res);
 struct pci_bus *pci_add_new_bus(struct pci_bus *parent, struct pci_dev *dev,
 				int busnr);
 void pcie_update_link_speed(struct pci_bus *bus, u16 link_status);
-- 
1.7.1
