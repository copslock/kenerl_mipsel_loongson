Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Oct 2004 07:19:39 +0100 (BST)
Received: from out014pub.verizon.net ([IPv6:::ffff:206.46.170.46]:52873 "EHLO
	out014.verizon.net") by linux-mips.org with ESMTP
	id <S8224833AbUJCGTc>; Sun, 3 Oct 2004 07:19:32 +0100
Received: from [192.168.0.3] ([4.5.62.153]) by out014.verizon.net
          (InterMail vM.5.01.06.06 201-253-122-130-106-20030910) with ESMTP
          id <20041003061929.WBKU17054.out014.verizon.net@[192.168.0.3]>;
          Sun, 3 Oct 2004 01:19:29 -0500
Subject: [PATCH 2/6] janitor: net/gt96100eth: pci_find_device to
	pci_get_device
From: Scott Feldman <sfeldma@pobox.com>
Reply-To: sfeldma@pobox.com
To: kernel-janitors@lists.osdl.org, stevel@mvista.com,
	source@mvista.com, linux-mips@linux-mips.org
Content-Type: text/plain
Message-Id: <1096784371.3819.157.camel@sfeldma-mobl2.dsl-verizon.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 02 Oct 2004 23:19:31 -0700
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [4.5.62.153] at Sun, 3 Oct 2004 01:19:29 -0500
Return-Path: <sfeldma@pobox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5923
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sfeldma@pobox.com
Precedence: bulk
X-list: linux-mips

Replace pci_find_device with pci_get_device/pci_dev_put to plug
race with pci_find_device.

Signed-off-by: Scott Feldman <sfeldma@pobox.com>

--- linux-2.6.9-rc3/drivers/net/gt96100eth.c	2004-10-02 21:17:24.000000000 -0700
+++ linux-2.6.9-rc3-dsf/drivers/net/gt96100eth.c	2004-10-02 21:23:57.000000000 -0700
@@ -617,9 +617,9 @@ static int gt96100_init_module(void)
 	/*
 	 * Stupid probe because this really isn't a PCI device
 	 */
-	if (!(pci = pci_find_device(PCI_VENDOR_ID_MARVELL,
+	if (!(pci = pci_get_device(PCI_VENDOR_ID_MARVELL,
 	                            PCI_DEVICE_ID_MARVELL_GT96100, NULL)) &&
-	    !(pci = pci_find_device(PCI_VENDOR_ID_MARVELL,
+	    !(pci = pci_get_device(PCI_VENDOR_ID_MARVELL,
 		                    PCI_DEVICE_ID_MARVELL_GT96100A, NULL))) {
 		printk(KERN_ERR __FILE__ ": GT96100 not found!\n");
 		return -ENODEV;
@@ -629,12 +629,14 @@ static int gt96100_init_module(void)
 	if (cpuConfig & (1<<12)) {
 		printk(KERN_ERR __FILE__
 		       ": must be in Big Endian mode!\n");
+		pci_dev_put(pci);
 		return -ENODEV;
 	}
 
 	for (i=0; i < NUM_INTERFACES; i++)
 		retval |= gt96100_probe1(pci, i);
 
+	pci_dev_put(pci);
 	return retval;
 }
 
