Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Apr 2007 12:38:13 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:40630 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20022051AbXDHLiL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 8 Apr 2007 12:38:11 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1HaVfh-0003wA-00
	for linux-mips@linux-mips.org; Sun, 08 Apr 2007 13:35:01 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 32808C2238; Sun,  8 Apr 2007 13:28:44 +0200 (CEST)
Date:	Sun, 8 Apr 2007 13:28:44 +0200
To:	linux-mips@linux-mips.org
Subject: [PATCH] Register PCI host bridge resource earlier 
Message-ID: <20070408112844.GA7553@alpha.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14808
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

Hi,

PCI based SNI RM machines have their EISA bus behind an Intel PCI/EISA
bridge. So the PCI IO range must start at 0x0000. Changing that will
break the PCI bus, because i8259.c already has registered it's IO
addresses before the PCI bus gets initialized. Below is a patch,
which will register the PCI host bridge resources inside
register_pci_controller(). It also changes i8259.c to use insert_region(),
because request_resource() will fail, if the IO space of the PIT hanging
of the PCI host bridge (maybe passing the resource parent to
init_i8259_irqs() is a cleaner fix for that).

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---


diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index f901140..67e01fd 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -77,6 +77,13 @@ pcibios_align_resource(void *data, struct resource *res,
 
 void __init register_pci_controller(struct pci_controller *hose)
 {
+	if (request_resource(&iomem_resource, hose->mem_resource) < 0)
+		goto out;
+	if (request_resource(&ioport_resource, hose->io_resource) < 0) {
+		release_resource(hose->mem_resource);
+		goto out;
+	}
+
 	*hose_tail = hose;
 	hose_tail = &hose->next;
 
@@ -87,6 +94,11 @@ void __init register_pci_controller(struct pci_controller *hose)
 		printk(KERN_WARNING
 		       "registering PCI controller with io_map_base unset\n");
 	}
+	return;
+
+out:
+	printk(KERN_WARNING
+	       "Skipping PCI bus scan due to resource conflict\n");
 }
 
 /* Most MIPS systems have straight-forward swizzling needs.  */
@@ -126,11 +138,6 @@ static int __init pcibios_init(void)
 	/* Scan all of the recorded PCI controllers.  */
 	for (next_busno = 0, hose = hose_head; hose; hose = hose->next) {
 
-		if (request_resource(&iomem_resource, hose->mem_resource) < 0)
-			goto out;
-		if (request_resource(&ioport_resource, hose->io_resource) < 0)
-			goto out_free_mem_resource;
-
 		if (!hose->iommu)
 			PCI_DMA_BUS_IS_PHYS = 1;
 
@@ -149,14 +156,6 @@ static int __init pcibios_init(void)
 				need_domain_info = 1;
 			}
 		}
-		continue;
-
-out_free_mem_resource:
-		release_resource(hose->mem_resource);
-
-out:
-		printk(KERN_WARNING
-		       "Skipping PCI bus scan due to resource conflict\n");
 	}
 
 	if (!pci_probe_only)
diff --git a/arch/mips/kernel/i8259.c b/arch/mips/kernel/i8259.c
index 9c79703..2345160 100644
--- a/arch/mips/kernel/i8259.c
+++ b/arch/mips/kernel/i8259.c
@@ -328,8 +328,8 @@ void __init init_i8259_irqs (void)
 {
 	int i;
 
-	request_resource(&ioport_resource, &pic1_io_resource);
-	request_resource(&ioport_resource, &pic2_io_resource);
+	insert_resource(&ioport_resource, &pic1_io_resource);
+	insert_resource(&ioport_resource, &pic2_io_resource);
 
 	init_8259A(0);
 


-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
