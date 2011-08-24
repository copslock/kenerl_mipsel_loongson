Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Aug 2011 08:25:34 +0200 (CEST)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:49865 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491942Ab1HXGYq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Aug 2011 08:24:46 +0200
Received: by ywp17 with SMTP id 17so803564ywp.36
        for <multiple recipients>; Tue, 23 Aug 2011 23:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=GpcuRfQtR+FZrSwknrhup4at3yMrZ06jjuxTBUifiww=;
        b=P4oOLjrVkHpK/cybnTZy8EQPBidtPCMOgYxkRA9BbN5FWLQeBlUgHWr1hkUtTX9lwF
         qucGgVJ6MlqjgvfU7zxYlbWJuZI8LhF7j19zqHfWGCvt5Rs0MJT++dHX/B9BvJSmCIy2
         ugHQUI96TzIAqJqsWF5iDmNyT9/YiQXRyYwsw=
Received: by 10.236.116.233 with SMTP id g69mr27316216yhh.39.1314167080242;
        Tue, 23 Aug 2011 23:24:40 -0700 (PDT)
Received: from localhost.localdomain ([210.13.118.102])
        by mx.google.com with ESMTPS id f4sm1134483yhn.27.2011.08.23.23.24.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 23 Aug 2011 23:24:39 -0700 (PDT)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     jbarnes@virtuousgeek.org, ralf@linux-mips.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, eyal@mips.com, zenon@mips.com,
        dengcheng.zhu@gmail.com
Subject: [RFC PATCH 2/3] PCI: Pass available resources into pci_create_bus()
Date:   Wed, 24 Aug 2011 14:24:22 +0800
Message-Id: <1314167063-15785-3-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1314167063-15785-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1314167063-15785-1-git-send-email-dengcheng.zhu@gmail.com>
X-archive-position: 30963
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17580

Currently, after pci_create_bus(), resources available on the bus could be
handled by pci_scan_child_bus(). The problem is that, in
pci_scan_child_bus(), before calling arch-dependent pcibios_fixup_bus(),
PCI quirks will probably conflict (while doing pci_claim_resource()) with
resources like system controller's I/O resource that have not yet been
added to the bus. So, add those resources right before returning the newly
created bus in pci_create_bus().

A related discussion thread can be found here:
http://www.spinics.net/lists/mips/msg41654.html

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
---
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
index 8473727..7735fe7 100644
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
+	if (bus_res != NULL) {
+		list_add_tail(&b->resources, &bus_res->list);
+	} else {
+		pci_bus_add_resource(b, &ioport_resource, 0);
+		pci_bus_add_resource(b, &iomem_resource, 0);
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
