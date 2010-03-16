Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Mar 2010 12:36:02 +0100 (CET)
Received: from mail2.marcant.net ([217.14.160.186]:56961 "EHLO
        mail2.marcant.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492128Ab0CPLf6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Mar 2010 12:35:58 +0100
Received: from localhost (mcontrol3.marcant.net [217.14.168.56])
        by localhost (Postfix) with ESMTP id 72F917FA007;
        Tue, 16 Mar 2010 12:35:55 +0100 (CET)
Received: from mail2.marcant.net ([127.0.0.1])
 by localhost (mail2.marcant.net [127.0.0.1]) (amavisd-maia, port 10030)
 with ESMTP id 05730-01; Tue, 16 Mar 2010 12:35:51 +0100 (CET)
Received: from admins.marcant.net (eth2.rossini.bi.marcant.net [217.14.160.189])
        by mail2.marcant.net (Postfix) with ESMTP id 44C0C7FA003;
        Tue, 16 Mar 2010 12:35:51 +0100 (CET)
Received: from sirius.intern.marcant.net (unknown [192.168.1.67])
        by admins.marcant.net (Postfix) with ESMTP id 31B62180F4;
        Tue, 16 Mar 2010 12:35:51 +0100 (CET)
Received: from aferber by sirius.intern.marcant.net with local (Exim 4.69)
        (envelope-from <af@chaos-agency.de>)
        id 1NrV3v-0005WF-3J; Tue, 16 Mar 2010 12:35:51 +0100
Date:   Tue, 16 Mar 2010 12:35:51 +0100
From:   Andreas Ferber <af@chaos-agency.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Markus Wigge <markus@cultcom.de>, Michael Buesch <mb@bu3sch.de>,
        linux-mips@linux-mips.org
Subject: [PATCH] mips: Fix SSB PCIcore IO resource management
Message-ID: <20100316113551.GB19241@marcant.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: MarcanT Internet-Services GmbH
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: Maia Mailguard 1.0.2
Return-Path: <af@chaos-agency.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26238
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: af@chaos-agency.de
Precedence: bulk
X-list: linux-mips

The SSB PCIcore code reused the IO resource fixup code from the original
2.4.x Broadcom patch for BCM47xx based devices, which was a quick hack
for doing PCI IO resource configuration back then (the boot loader
doesn't configure PCI devices on this platform).

However, this code is no longer necessary since the kernel now can do
PCI resource management fine all by itself, so remove the old code.

When removing the code, it becomes obvious that the mem_offset setting
in the PCIcore driver was wrong, however this was masked by the fixup
code before, except in a few cases involving yenta_socket. For
BCM47xx, the correct offset is 0, and since this is the only device
using PCIcore in host mode, the offset can simply be removed
unconditionally.

Signed-off-by: Andreas Ferber <af@chaos-agency.de>
Signed-off-by: Michael Buesch <mb@bu3sch.de>

---

The patch has been tested on the following devices:

 - Linksys WRT54G3G V1.0
 - Asus WL500g Premium V1
 - Asus WL500g Premium V2
 - Netgear WGT634U

Regards,
Andreas

Index: linux-2.6.33/drivers/ssb/driver_pcicore.c
===================================================================
--- linux-2.6.33.orig/drivers/ssb/driver_pcicore.c	2010-03-15 14:52:55.000000000 +0100
+++ linux-2.6.33/drivers/ssb/driver_pcicore.c	2010-03-15 15:57:38.000000000 +0100
@@ -246,20 +246,12 @@
 	.pci_ops	= &ssb_pcicore_pciops,
 	.io_resource	= &ssb_pcicore_io_resource,
 	.mem_resource	= &ssb_pcicore_mem_resource,
-	.mem_offset	= 0x24000000,
 };
 
-static u32 ssb_pcicore_pcibus_iobase = 0x100;
-static u32 ssb_pcicore_pcibus_membase = SSB_PCI_DMA;
-
 /* This function is called when doing a pci_enable_device().
  * We must first check if the device is a device on the PCI-core bridge. */
 int ssb_pcicore_plat_dev_init(struct pci_dev *d)
 {
-	struct resource *res;
-	int pos, size;
-	u32 *base;
-
 	if (d->bus->ops != &ssb_pcicore_pciops) {
 		/* This is not a device on the PCI-core bridge. */
 		return -ENODEV;
@@ -268,27 +260,6 @@
 	ssb_printk(KERN_INFO "PCI: Fixing up device %s\n",
 		   pci_name(d));
 
-	/* Fix up resource bases */
-	for (pos = 0; pos < 6; pos++) {
-		res = &d->resource[pos];
-		if (res->flags & IORESOURCE_IO)
-			base = &ssb_pcicore_pcibus_iobase;
-		else
-			base = &ssb_pcicore_pcibus_membase;
-		res->flags |= IORESOURCE_PCI_FIXED;
-		if (res->end) {
-			size = res->end - res->start + 1;
-			if (*base & (size - 1))
-				*base = (*base + size) & ~(size - 1);
-			res->start = *base;
-			res->end = res->start + size - 1;
-			*base += size;
-			pci_write_config_dword(d, PCI_BASE_ADDRESS_0 + (pos << 2), res->start);
-		}
-		/* Fix up PCI bridge BAR0 only */
-		if (d->bus->number == 0 && PCI_SLOT(d->devfn) == 0)
-			break;
-	}
 	/* Fix up interrupt lines */
 	d->irq = ssb_mips_irq(extpci_core->dev) + 2;
 	pci_write_config_byte(d, PCI_INTERRUPT_LINE, d->irq);
