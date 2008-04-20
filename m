Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Apr 2008 23:31:18 +0100 (BST)
Received: from hall2.aurel32.net ([91.121.138.14]:10893 "EHLO
	hall2.aurel32.net") by ftp.linux-mips.org with ESMTP
	id S20036869AbYDTWbQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 20 Apr 2008 23:31:16 +0100
Received: from aurel32 by hall2.aurel32.net with local (Exim 4.63)
	(envelope-from <aurelien@aurel32.net>)
	id 1Jni43-0002YD-QL; Mon, 21 Apr 2008 00:31:15 +0200
Date:	Mon, 21 Apr 2008 00:31:15 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [PATCH 1/4] Scan PCI busses when they are registered
Message-ID: <20080420223115.GA9783@hall2.aurel32.net>
References: <20080420223028.GA9282@hall2.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20080420223028.GA9282@hall2.aurel32.net>
X-Mailer: Mutt 1.5.13 (2006-08-11)
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18970
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

The patch below changes register_pci_controller() such that controllers
being added after pcibios_init() has run are be scanned immediately.

This is needed for example by the BCM47xx PCI controller, which is
located on the SSB bus, which is now initialized after the PCI
subsystem.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 arch/mips/pci/pci.c |   80 +++++++++++++++++++++++++++++++++-----------------
 1 files changed, 53 insertions(+), 27 deletions(-)

diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index 358ad62..d0d811d 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -35,6 +35,8 @@ struct pci_controller *pci_isa_hose;
 unsigned long PCIBIOS_MIN_IO	= 0x0000;
 unsigned long PCIBIOS_MIN_MEM	= 0;
 
+static int pci_initialized;
+
 /*
  * We need to avoid collisions with `mirrored' VGA ports
  * and other strange ISA hardware, so we always want the
@@ -75,6 +77,42 @@ pcibios_align_resource(void *data, struct resource *res,
 	res->start = start;
 }
 
+static void __devinit pcibios_scanbus(struct pci_controller *hose)
+{
+	static int next_busno;
+	static int need_domain_info;
+	struct pci_bus *bus;
+
+	if (!hose->iommu)
+		PCI_DMA_BUS_IS_PHYS = 1;
+
+	if (hose->get_busno && pci_probe_only)
+		next_busno = (*hose->get_busno)();
+
+	bus = pci_scan_bus(next_busno, hose->pci_ops, hose);
+	hose->bus = bus;
+
+	need_domain_info = need_domain_info || hose->index;
+	hose->need_domain_info = need_domain_info;
+	if (bus) {
+		next_busno = bus->subordinate + 1;
+		/* Don't allow 8-bit bus number overflow inside the hose -
+		   reserve some space for bridges. */
+		if (next_busno > 224) {
+			next_busno = 0;
+			need_domain_info = 1;
+		}
+
+		if (!pci_probe_only) {
+			pci_bus_size_bridges(bus);
+			pci_bus_assign_resources(bus);
+			pci_enable_bridges(bus);
+		}
+	}
+}
+
+static DEFINE_MUTEX(pci_scan_mutex);
+
 void __devinit register_pci_controller(struct pci_controller *hose)
 {
 	if (request_resource(&iomem_resource, hose->mem_resource) < 0)
@@ -94,6 +132,17 @@ void __devinit register_pci_controller(struct pci_controller *hose)
 		printk(KERN_WARNING
 		       "registering PCI controller with io_map_base unset\n");
 	}
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
 	return;
 
 out:
@@ -126,38 +175,15 @@ static u8 __init common_swizzle(struct pci_dev *dev, u8 *pinp)
 static int __init pcibios_init(void)
 {
 	struct pci_controller *hose;
-	struct pci_bus *bus;
-	int next_busno;
-	int need_domain_info = 0;
 
 	/* Scan all of the recorded PCI controllers.  */
-	for (next_busno = 0, hose = hose_head; hose; hose = hose->next) {
-
-		if (!hose->iommu)
-			PCI_DMA_BUS_IS_PHYS = 1;
-
-		if (hose->get_busno && pci_probe_only)
-			next_busno = (*hose->get_busno)();
-
-		bus = pci_scan_bus(next_busno, hose->pci_ops, hose);
-		hose->bus = bus;
-		need_domain_info = need_domain_info || hose->index;
-		hose->need_domain_info = need_domain_info;
-		if (bus) {
-			next_busno = bus->subordinate + 1;
-			/* Don't allow 8-bit bus number overflow inside the hose -
-			   reserve some space for bridges. */
-			if (next_busno > 224) {
-				next_busno = 0;
-				need_domain_info = 1;
-			}
-		}
-	}
+	for (hose = hose_head; hose; hose = hose->next)
+		pcibios_scanbus(hose);
 
-	if (!pci_probe_only)
-		pci_assign_unassigned_resources();
 	pci_fixup_irqs(common_swizzle, pcibios_map_irq);
 
+	pci_initialized = 1;
+
 	return 0;
 }
 
-- 
1.5.5


-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
