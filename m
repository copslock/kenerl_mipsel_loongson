Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4TCW4nC010310
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 29 May 2002 05:32:04 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4TCW4Co010309
	for linux-mips-outgoing; Wed, 29 May 2002 05:32:04 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from ubik.localnet (port48.ds1-vbr.adsl.cybercity.dk [212.242.58.113])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4TCVsnC008829
	for <linux-mips@oss.sgi.com>; Wed, 29 May 2002 05:31:55 -0700
Received: from murphy.dk (brm@brian.localnet [10.0.0.2])
	by ubik.localnet (8.12.2/8.12.2/Debian -5) with ESMTP id g4TCXGtS010463
	for <linux-mips@oss.sgi.com>; Wed, 29 May 2002 14:33:16 +0200
Message-ID: <3CF4CA8C.9040802@murphy.dk>
Date: Wed, 29 May 2002 14:33:16 +0200
From: Brian Murphy <brian@murphy.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips <linux-mips@oss.sgi.com>
Subject: ioremap?
Content-Type: multipart/mixed;
 boundary="------------060405030301000005000902"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------060405030301000005000902
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

In three files/drivers I have had problems with physical addresses not 
being ioremapped.
I include my patch to fix things up and request comments. How come 
others don't have similar
problems?

/Brian

--------------060405030301000005000902
Content-Type: text/plain;
 name="ioremap.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ioremap.diff"

--- drivers/ide/ide-dma.c	2001/10/19 01:24:24	1.9
+++ drivers/ide/ide-dma.c	2002/05/29 11:49:14
@@ -741,7 +741,8 @@
 	if (hwif->mate && hwif->mate->dma_base) {
 		dma_base = hwif->mate->dma_base - (hwif->channel ? 0 : 8);
 	} else {
-		dma_base = pci_resource_start(dev, 4);
+		dma_base = ioremap(pci_resource_start(dev, 4), 
+				pci_resource_len(dev, 4));
 		if (!dma_base) {
 			printk("%s: dma_base is invalid (0x%04lx)\n", name, dma_base);
 			dma_base = 0;
--- drivers/ide/ide-pci.c	2001/11/19 13:53:59	1.20
+++ drivers/ide/ide-pci.c	2002/05/29 11:49:15
@@ -716,8 +716,10 @@
 		if (IDE_PCI_DEVID_EQ(d->devid, DEVID_HPT366) && (port) && (class_rev < 0x03))
 			return;
 		if ((dev->class >> 8) != PCI_CLASS_STORAGE_IDE || (dev->class & (port ? 4 : 1)) != 0) {
-			ctl  = dev->resource[(2*port)+1].start;
-			base = dev->resource[2*port].start;
+			ctl = ioremap(pci_resource_start(dev, (2*port)+1), 
+			              pci_resource_len(dev, (2*port)+1));
+			base = ioremap(pci_resource_start(dev, 2*port), 
+			              pci_resource_len(dev, 2*port));
 			if (!(ctl & PCI_BASE_ADDRESS_IO_MASK) ||
 			    !(base & PCI_BASE_ADDRESS_IO_MASK)) {
 				printk("%s: IO baseregs (BIOS) are reported as MEM, report to <andre@linux-ide.org>.\n", d->name);
--- drivers/net/pcnet32.c	2002/02/26 05:59:35	1.33.2.1
+++ drivers/net/pcnet32.c	2002/05/29 11:49:18
@@ -494,7 +494,8 @@
     }
     pci_set_master(pdev);
 
-    ioaddr = pci_resource_start (pdev, 0);
+    ioaddr = ioremap(pci_resource_start (pdev, 0),
+		    pci_resource_len (pdev, 0));
     printk(KERN_INFO "    ioaddr=%#08lx  resource_flags=%#08lx\n", ioaddr, pci_resource_flags (pdev, 0));
     if (!ioaddr) {
         printk (KERN_ERR "no PCI IO resources, aborting\n");


--------------060405030301000005000902--
