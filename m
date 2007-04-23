Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Apr 2007 16:15:01 +0100 (BST)
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:28546 "EHLO
	the-village.bc.nu") by ftp.linux-mips.org with ESMTP
	id S20021740AbXDWPPA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Apr 2007 16:15:00 +0100
Received: from the-village.bc.nu (localhost.localdomain [127.0.0.1])
	by the-village.bc.nu (8.13.8/8.13.8) with ESMTP id l3NFIZMM008133;
	Mon, 23 Apr 2007 16:18:35 +0100
Date:	Mon, 23 Apr 2007 16:18:35 +0100
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] IOC3: Switch to pci refcounting safe APIs
Message-ID: <20070423161835.4ae29965@the-village.bc.nu>
In-Reply-To: <20070423143507.GA8877@linux-mips.org>
References: <20070423150640.1faf693f@the-village.bc.nu>
	<462CBE33.2060208@ru.mvista.com>
	<20070423151918.477ffb6a@the-village.bc.nu>
	<20070423143507.GA8877@linux-mips.org>
X-Mailer: Claws Mail 2.9.1 (GTK+ 2.10.8; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14902
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

> > Makes no real difference, but if you know the MIPS tree never ends up
> > with pdev->bus = NULL for the root bus then its a trivial change
> 
> That's the case on MIPS.

Revised patch then


---

Convert the IOC3 driver to use ref counting pci interfaces so that we can
obsolete the (usually unsafe) pci_find_{slot/device} interfaces and avoid
future authors writing hotplug-unsafe device drivers.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc6-mm1/drivers/net/ioc3-eth.c linux-2.6.21-rc6-mm1/drivers/net/ioc3-eth.c
--- linux.vanilla-2.6.21-rc6-mm1/drivers/net/ioc3-eth.c	2007-04-12 14:15:04.000000000 +0100
+++ linux-2.6.21-rc6-mm1/drivers/net/ioc3-eth.c	2007-04-23 15:58:21.431489816 +0100
@@ -1103,20 +1103,29 @@
  * MiniDINs; all other subdevices are left swinging in the wind, leave
  * them disabled.
  */
-static inline int ioc3_is_menet(struct pci_dev *pdev)
+ 
+static int ioc3_adjacent_is_ioc3(struct pci_dev *pdev, int dev)
+{
+	struct pci_dev *dev = pci_get_slot(pdev->bus, PCI_DEVFN(dev, 0));
+	int ret = 0;
+	
+	if (dev) {
+		if (dev->vendor == PCI_VENDOR_ID_SGI &&
+			dev->device == PCI_DEVICE_ID_SGI_IOC3)
+			ret = 1;
+		pci_dev_put(dev);
+	}
+	return ret;
+}
+
+static int ioc3_is_menet(struct pci_dev *pdev)
 {
 	struct pci_dev *dev;
 
-	return pdev->bus->parent == NULL
-	       && (dev = pci_find_slot(pdev->bus->number, PCI_DEVFN(0, 0)))
-	       && dev->vendor == PCI_VENDOR_ID_SGI
-	       && dev->device == PCI_DEVICE_ID_SGI_IOC3
-	       && (dev = pci_find_slot(pdev->bus->number, PCI_DEVFN(1, 0)))
-	       && dev->vendor == PCI_VENDOR_ID_SGI
-	       && dev->device == PCI_DEVICE_ID_SGI_IOC3
-	       && (dev = pci_find_slot(pdev->bus->number, PCI_DEVFN(2, 0)))
-	       && dev->vendor == PCI_VENDOR_ID_SGI
-	       && dev->device == PCI_DEVICE_ID_SGI_IOC3;
+	return pdev->bus->parent == NULL &&
+	       ioc3_adjacent_is_ioc3(pdev, 0) &&
+	       ioc3_adjacent_is_ioc3(pdev, 1) &&
+	       ioc3_adjacent_is_ioc3(pdev, 2));
 }
 
 #ifdef CONFIG_SERIAL_8250
