Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Sep 2008 20:24:03 +0100 (BST)
Received: from hall.aurel32.net ([91.121.138.14]:7356 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S29588664AbYIXTXz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 24 Sep 2008 20:23:55 +0100
Received: from volta.aurel32.net ([2002:52e8:2fb:1:21e:8cff:feb0:693b])
	by hall.aurel32.net with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <aurelien@aurel32.net>)
	id 1KiZxq-0003ob-MF; Wed, 24 Sep 2008 21:23:54 +0200
Received: from aurel32 by volta.aurel32.net with local (Exim 4.69)
	(envelope-from <aurelien@aurel32.net>)
	id 1KiZxp-0005Cw-GR; Wed, 24 Sep 2008 21:23:53 +0200
Date:	Wed, 24 Sep 2008 21:23:53 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [PATCH 6/6] [MIPS] Scan PCI busses when they are registered
Message-ID: <20080924192353.GG18700@volta.aurel32.net>
References: <20080924191840.GA18700@volta.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20080924191840.GA18700@volta.aurel32.net>
X-Mailer: Mutt 1.5.18 (2008-05-17)
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20621
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
index c7fe6ec..a377e9d 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -34,6 +34,8 @@ static struct pci_controller *hose_head, **hose_tail = &hose_head;
 unsigned long PCIBIOS_MIN_IO	= 0x0000;
 unsigned long PCIBIOS_MIN_MEM	= 0;
 
+static int pci_initialized;
+
 /*
  * We need to avoid collisions with `mirrored' VGA ports
  * and other strange ISA hardware, so we always want the
@@ -74,6 +76,42 @@ pcibios_align_resource(void *data, struct resource *res,
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
@@ -93,6 +131,17 @@ void __devinit register_pci_controller(struct pci_controller *hose)
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
@@ -125,38 +174,15 @@ static u8 __init common_swizzle(struct pci_dev *dev, u8 *pinp)
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
1.5.6.5


-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
