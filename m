Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Mar 2005 08:38:54 +0000 (GMT)
Received: from purplechoc.demon.co.uk ([IPv6:::ffff:80.176.224.106]:14720 "EHLO
	skeleton-jack.localnet") by linux-mips.org with ESMTP
	id <S8225242AbVCAIih>; Tue, 1 Mar 2005 08:38:37 +0000
Received: from pdh by skeleton-jack.localnet with local (Exim 3.36 #1 (Debian))
	id 1D62u4-0000Xb-00
	for <linux-mips@linux-mips.org>; Tue, 01 Mar 2005 08:38:52 +0000
Date:	Tue, 1 Mar 2005 08:38:52 +0000
To:	linux-mips@linux-mips.org
Subject: [PATCH 2.6] Cobalt 1/2: tidy up PCI fixups
Message-ID: <20050301083852.GA2017@skeleton-jack>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From:	Peter Horton <pdh@colonel-panic.org>
Return-Path: <pdh@colonel-panic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7353
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pdh@colonel-panic.org
Precedence: bulk
X-list: linux-mips

It's not necessary to hide Galileo if we correctly mark it as a host
bridge.

P.

--

diff -urpN linux-cvs/arch/mips/cobalt/setup.c linux-wip/arch/mips/cobalt/setup.c
--- linux-cvs/arch/mips/cobalt/setup.c	2005-02-21 16:18:36.000000000 +0000
+++ linux-wip/arch/mips/cobalt/setup.c	2005-02-27 11:37:10.000000000 +0000
@@ -62,11 +62,11 @@ static void __init cobalt_timer_setup(st
 extern struct pci_ops gt64111_pci_ops;
 
 static struct resource cobalt_mem_resource = {
-	"GT64111 PCI MEM", GT64111_MEM_BASE, GT64111_MEM_END, IORESOURCE_MEM
+	"PCI memory", GT64111_MEM_BASE, GT64111_MEM_END, IORESOURCE_MEM
 };
 
 static struct resource cobalt_io_resource = {
-	"GT64111 IO MEM", 0x00001000UL, GT64111_IO_END - GT64111_IO_BASE, IORESOURCE_IO
+	"PCI I/O", 0x1000, 0xffff, IORESOURCE_IO
 };
 
 static struct resource cobalt_io_resources[] = {
@@ -100,7 +100,7 @@ static int __init cobalt_setup(void)
 
         set_io_port_base(CKSEG1ADDR(GT64111_IO_BASE));
 
-	/* IO region should cover all Galileo IO */
+	/* I/O port resource must include UART and LCD/buttons */
 	ioport_resource.end = 0x0fffffff;
 
 	/*
diff -urpN linux-cvs/arch/mips/pci/fixup-cobalt.c linux-wip/arch/mips/pci/fixup-cobalt.c
--- linux-cvs/arch/mips/pci/fixup-cobalt.c	2005-02-21 16:24:02.000000000 +0000
+++ linux-wip/arch/mips/pci/fixup-cobalt.c	2005-02-27 11:24:44.000000000 +0000
@@ -21,6 +21,20 @@
 
 extern int cobalt_board_id;
 
+static void qube_raq_galileo_early_fixup(struct pci_dev *dev)
+{
+	if (dev->devfn == PCI_DEVFN(0, 0) &&
+		(dev->class >> 8) == PCI_CLASS_MEMORY_OTHER) {
+
+		dev->class = (PCI_CLASS_BRIDGE_HOST << 8) | (dev->class & 0xff);
+
+		printk(KERN_INFO "Galileo: fixed bridge class\n");
+	}
+}
+
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_MARVELL, PCI_DEVICE_ID_MARVELL_GT64111,
+	 qube_raq_galileo_early_fixup);
+
 static void qube_raq_via_bmIDE_fixup(struct pci_dev *dev)
 {
 	unsigned short cfgword;
@@ -47,8 +61,10 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_V
 static void qube_raq_galileo_fixup(struct pci_dev *dev)
 {
 	unsigned short galileo_id;
-	int i;
 
+	if (dev->devfn != PCI_DEVFN(0, 0))
+		return;
+		
 	/* Fix PCI latency-timer and cache-line-size values in Galileo
 	 * host bridge.
 	 */
@@ -73,7 +89,7 @@ static void qube_raq_galileo_fixup(struc
 	pci_read_config_word(dev, PCI_REVISION_ID, &galileo_id);
 	galileo_id &= 0xff;	/* mask off class info */
 
- 	printk("Galileo ID: %u\n", galileo_id);
+ 	printk(KERN_INFO "Galileo: revision %u\n", galileo_id);
 
 #if 0
 	if (galileo_id >= 0x10) {
@@ -88,18 +104,9 @@ static void qube_raq_galileo_fixup(struc
 		/* Old Galileo, assumes PCI STOP line to VIA is disconnected. */
 		GALILEO_OUTL(0xffff, GT_PCI0_TOR_OFS);
 	}
-
-	/*
-	 * hide Galileo from the kernel's PCI resource assignment. The BARs
-	 * on Galileo will already have been set up by the boot loader to
-	 * match the DRAM configuration so we don't want them being monkeyed
-	 * around with.
-	 */
-	for (i = 0; i < DEVICE_COUNT_RESOURCE; ++i)
-		dev->resource[i].start = dev->resource[i].end = dev->resource[i].flags = 0;
 }
 
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL, PCI_ANY_ID,
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL, PCI_DEVICE_ID_MARVELL_GT64111,
 	 qube_raq_galileo_fixup);
 
 static char irq_tab_cobalt[] __initdata = {
