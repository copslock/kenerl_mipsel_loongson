Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2010 00:01:29 +0100 (CET)
Received: from g4t0017.houston.hp.com ([15.201.24.20]:4090 "EHLO
        g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492424Ab0BWXBY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Feb 2010 00:01:24 +0100
Received: from g4t0018.houston.hp.com (g4t0018.houston.hp.com [16.234.32.27])
        by g4t0017.houston.hp.com (Postfix) with ESMTP id B6A2738181;
        Tue, 23 Feb 2010 23:01:16 +0000 (UTC)
Received: from ldl (ldl.fc.hp.com [15.11.146.30])
        by g4t0018.houston.hp.com (Postfix) with ESMTP id 4B96110296;
        Tue, 23 Feb 2010 23:01:16 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
        by ldl (Postfix) with ESMTP id 21EB9CF0014;
        Tue, 23 Feb 2010 16:01:16 -0700 (MST)
Received: from ldl ([127.0.0.1])
        by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6QWOEgxECmTn; Tue, 23 Feb 2010 16:01:16 -0700 (MST)
Received: from tigger.helgaas (lart.fc.hp.com [15.11.146.31])
        by ldl (Postfix) with ESMTP id 0BEDBCF0008;
        Tue, 23 Feb 2010 16:01:16 -0700 (MST)
From:   Bjorn Helgaas <bjorn.helgaas@hp.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Reverting old hack
Date:   Tue, 23 Feb 2010 16:01:14 -0700
User-Agent: KMail/1.9.10
Cc:     Yoichi Yuasa <yuasa@linux-mips.org>, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20100220113134.GA27194@linux-mips.org> <1266815257.1959.23.camel@dc7800.home> <20100222132830.GA5017@linux-mips.org>
In-Reply-To: <20100222132830.GA5017@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201002231601.15136.bjorn.helgaas@hp.com>
Return-Path: <bjorn.helgaas@hp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26009
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bjorn.helgaas@hp.com
Precedence: bulk
X-list: linux-mips

On Monday 22 February 2010 06:28:30 am Ralf Baechle wrote:
> It's a while since I last looked into this but here's how things afair
> are working on a MIPS-based Cobalt system.
> 
> The system is based on a MIPS processor and a GT-64111 system controller.
> Addresses within a certain CPU address range are passed to the PCI bus as
> I/O cycles without address cycles.  Since memory is starting at CPU address
> zero (and has to because of the processors used), that address window has
> to get mapped somewhere else.  So a CPU access to some virtual address gets
> translated to physical address 0xf00001f0.  The GT-64111 passes this to the
> PCI bus as I/O port address 0xf00001f0.  Finally the VT82C586 chip which
> only decodes the low 16 bits drops treats this as an I/O port space address
> 0x1f0.

Yoichi, can you try the patch below?  I think this is basically the
approach Ben suggested long ago:
    http://marc.info/?l=linux-kernel&m=119733290624544&w=2

Thanks,
  Bjorn


diff --git a/arch/mips/pci/fixup-cobalt.c b/arch/mips/pci/fixup-cobalt.c
index 9553b14..7579551 100644
--- a/arch/mips/pci/fixup-cobalt.c
+++ b/arch/mips/pci/fixup-cobalt.c
@@ -51,6 +51,67 @@ static void qube_raq_galileo_early_fixup(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_MARVELL, PCI_DEVICE_ID_MARVELL_GT64111,
 	 qube_raq_galileo_early_fixup);
 
+static void __devinit cobalt_legacy_ide_resource_fixup(struct pci_dev *dev,
+						       struct resource *res)
+{
+	struct pci_controller *hose = (struct pci_controller *)dev->sysdata;
+	unsigned long offset = hose->io_offset;
+	struct resource orig = *res;
+
+	if (!(res->flags & IORESOURCE_IO) ||
+	    !(res->flags & IORESOURCE_PCI_FIXED))
+		return;
+
+	res->start -= offset;
+	res->end -= offset;
+	dev_printk(KERN_DEBUG, &dev->dev, "converted legacy %pR to bus %pR\n",
+		   &orig, res);
+}
+
+static void __devinit cobalt_legacy_ide_fixup(struct pci_dev *dev)
+{
+	u32 class;
+	u8 progif;
+
+	/*
+	 * If the IDE controller is in legacy mode, pci_setup_device() fills in
+	 * the resources with the legacy addresses that normally appear on the
+	 * PCI bus, just as if we had read them from a BAR.
+	 *
+	 * However, with the GT-64111, those legacy addresses, e.g., 0x1f0,
+	 * will never appear on the PCI bus because it converts memory accesses
+	 * in the PCI I/O region (which is never at address zero) into I/O port
+	 * accesses with no address translation.
+	 *
+	 * For example, if GT_DEF_PCI0_IO_BASE is 0x10000000, a load or store
+	 * to physical address 0x100001f0 will become a PCI access to I/O port
+	 * 0x100001f0.  There's no way to generate an access to I/O port 0x1f0,
+	 * but the VT82C586 IDE controller does respond at 0x100001f0 because
+	 * it only decodes the low 16 bits of the address.
+	 *
+	 * When this quirk runs, the pci_dev resources should contain bus
+	 * addresses, not Linux I/O port numbers, so convert legacy addresses
+	 * like 0x1f0 to bus addresses like 0x100001f0.  Later, we'll convert
+	 * them back with pcibios_fixup_bus() or pcibios_bus_to_resource().
+	 */
+	class = dev->class >> 8;
+	if (class != PCI_CLASS_STORAGE_IDE)
+		return;
+
+	pci_read_config_byte(dev, PCI_CLASS_PROG, &progif);
+	if ((progif & 1) == 0) {
+		cobalt_legacy_ide_resource_fixup(dev, &dev->resource[0]);
+		cobalt_legacy_ide_resource_fixup(dev, &dev->resource[1]);
+	}
+	if ((progif & 4) == 0) {
+		cobalt_legacy_ide_resource_fixup(dev, &dev->resource[2]);
+		cobalt_legacy_ide_resource_fixup(dev, &dev->resource[3]);
+	}
+}
+
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1,
+	  cobalt_legacy_ide_fixup);
+
 static void qube_raq_via_bmIDE_fixup(struct pci_dev *dev)
 {
 	unsigned short cfgword;
diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index f87f5e1..38bc280 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -251,8 +251,6 @@ static void pcibios_fixup_device_resources(struct pci_dev *dev,
 	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
 		if (!dev->resource[i].start)
 			continue;
-		if (dev->resource[i].flags & IORESOURCE_PCI_FIXED)
-			continue;
 		if (dev->resource[i].flags & IORESOURCE_IO)
 			offset = hose->io_offset;
 		else if (dev->resource[i].flags & IORESOURCE_MEM)
