Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Mar 2008 17:14:39 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:20643 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28597542AbYCPROg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 16 Mar 2008 17:14:36 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JawRQ-0006Tt-00; Sun, 16 Mar 2008 18:14:36 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 18556C226C; Sun, 16 Mar 2008 18:14:16 +0100 (CET)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] BCM1480: Fix PCI/HT IO access
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20080316171416.18556C226C@solo.franken.de>
Date:	Sun, 16 Mar 2008 18:14:16 +0100 (CET)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18405
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

- removed check for enable HT-PCI bridges, because some CFE version
  init only the needed one and scanning works even with disabled HT
  links
- implemented I/O access behind HT PCI busses
- fixed pci_map for IO resource behind PCI bridge

Tested with E100 and Tulip driver.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 arch/mips/pci/pci-bcm1480.c   |    6 ++++--
 arch/mips/pci/pci-bcm1480ht.c |   21 +++++++--------------
 2 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/arch/mips/pci/pci-bcm1480.c b/arch/mips/pci/pci-bcm1480.c
index ab68c43..87e2c8f 100644
--- a/arch/mips/pci/pci-bcm1480.c
+++ b/arch/mips/pci/pci-bcm1480.c
@@ -185,8 +185,8 @@ static struct resource bcm1480_mem_resource = {
 
 static struct resource bcm1480_io_resource = {
 	.name	= "BCM1480 PCI I/O",
-	.start	= 0x2c000000UL,
-	.end	= 0x2dffffffUL,
+	.start	= A_BCM1480_PHYS_PCI_IO_MATCH_BYTES,
+	.end	= A_BCM1480_PHYS_PCI_IO_MATCH_BYTES + 0x1ffffffUL,
 	.flags	= IORESOURCE_IO,
 };
 
@@ -194,6 +194,7 @@ struct pci_controller bcm1480_controller = {
 	.pci_ops	= &bcm1480_pci_ops,
 	.mem_resource	= &bcm1480_mem_resource,
 	.io_resource	= &bcm1480_io_resource,
+	.io_offset      = A_BCM1480_PHYS_PCI_IO_MATCH_BYTES,
 };
 
 
@@ -251,6 +252,7 @@ static int __init bcm1480_pcibios_init(void)
 
 	bcm1480_controller.io_map_base = (unsigned long)
 		ioremap(A_BCM1480_PHYS_PCI_IO_MATCH_BYTES, 65536);
+	bcm1480_controller.io_map_base -= bcm1480_controller.io_offset;
 	set_io_port_base(bcm1480_controller.io_map_base);
 	isa_slot_offset = (unsigned long)
 		ioremap(A_BCM1480_PHYS_PCI_MEM_MATCH_BYTES, 1024*1024);
diff --git a/arch/mips/pci/pci-bcm1480ht.c b/arch/mips/pci/pci-bcm1480ht.c
index 005e7fe..f54f454 100644
--- a/arch/mips/pci/pci-bcm1480ht.c
+++ b/arch/mips/pci/pci-bcm1480ht.c
@@ -180,8 +180,8 @@ static struct resource bcm1480ht_mem_resource = {
 
 static struct resource bcm1480ht_io_resource = {
 	.name	= "BCM1480 HT I/O",
-	.start	= 0x00000000UL,
-	.end	= 0x01ffffffUL,
+	.start	= A_BCM1480_PHYS_HT_IO_MATCH_BYTES,
+	.end	= A_BCM1480_PHYS_HT_IO_MATCH_BYTES + 0x01ffffffUL,
 	.flags	= IORESOURCE_IO,
 };
 
@@ -191,29 +191,22 @@ struct pci_controller bcm1480ht_controller = {
 	.io_resource	= &bcm1480ht_io_resource,
 	.index		= 1,
 	.get_busno	= bcm1480ht_pcibios_get_busno,
+	.io_offset      = A_BCM1480_PHYS_HT_IO_MATCH_BYTES,
 };
 
 static int __init bcm1480ht_pcibios_init(void)
 {
-	uint32_t cmdreg;
-
 	ht_cfg_space = ioremap(A_BCM1480_PHYS_HT_CFG_MATCH_BITS, 16*1024*1024);
 
-	/*
-	 * See if the PCI bus has been configured by the firmware.
-	 */
-	cmdreg = READCFG32(CFGOFFSET(0, PCI_DEVFN(PCI_BRIDGE_DEVICE, 0),
-				     PCI_COMMAND));
-	if (!(cmdreg & PCI_COMMAND_MASTER)) {
-		printk("HT: Skipping HT probe. Bus is not initialized.\n");
-		iounmap(ht_cfg_space);
-		return 1; /* XXX */
-	}
+	/* CFE doesn't always init all HT paths, so we always scan */
 	bcm1480ht_bus_status |= PCI_BUS_ENABLED;
 
 	ht_eoi_space = (unsigned long)
 		ioremap(A_BCM1480_PHYS_HT_SPECIAL_MATCH_BYTES,
 			4 * 1024 * 1024);
+	bcm1480ht_controller.io_map_base = (unsigned long)
+		ioremap(A_BCM1480_PHYS_HT_IO_MATCH_BYTES, 65536);
+	bcm1480ht_controller.io_map_base -= bcm1480ht_controller.io_offset;
 
 	register_pci_controller(&bcm1480ht_controller);
 
