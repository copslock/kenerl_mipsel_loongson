Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Aug 2004 22:38:36 +0100 (BST)
Received: from atlrel9.hp.com ([IPv6:::ffff:156.153.255.214]:62879 "EHLO
	atlrel9.hp.com") by linux-mips.org with ESMTP id <S8225201AbUHDVic>;
	Wed, 4 Aug 2004 22:38:32 +0100
Received: from smtp1.fc.hp.com (smtp.fc.hp.com [15.11.136.119])
	by atlrel9.hp.com (Postfix) with ESMTP
	id 7E7D81A2B7; Wed,  4 Aug 2004 17:38:30 -0400 (EDT)
Received: from ldl.fc.hp.com (ldl.fc.hp.com [15.11.146.30])
	by smtp1.fc.hp.com (Postfix) with ESMTP
	id AE0B438592; Wed,  4 Aug 2004 15:38:22 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by ldl.fc.hp.com (Postfix) with ESMTP id 85E3A1340F2;
	Wed,  4 Aug 2004 15:38:22 -0600 (MDT)
Received: from ldl.fc.hp.com ([127.0.0.1])
	by localhost (ldl [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 04129-01; Wed, 4 Aug 2004 15:38:21 -0600 (MDT)
Received: from eeyore.helgaas (lart.fc.hp.com [15.11.146.31])
	by ldl.fc.hp.com (Postfix) with ESMTP id 7719A1340D4;
	Wed,  4 Aug 2004 15:38:21 -0600 (MDT)
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] ioc3-eth.c: add missing pci_enable_device()
Date: Wed, 4 Aug 2004 15:38:21 -0600
User-Agent: KMail/1.6.2
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408041538.21128.bjorn.helgaas@hp.com>
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at ldl.fc.hp.com
Return-Path: <bjorn.helgaas@hp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5593
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bjorn.helgaas@hp.com
Precedence: bulk
X-list: linux-mips

I don't have this hardware, so this has not been tested.


Add pci_enable_device()/pci_disable_device().  In the past, drivers
often worked without this, but it is now required in order to route
PCI interrupts correctly.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

===== drivers/net/ioc3-eth.c 1.26 vs edited =====
--- 1.26/drivers/net/ioc3-eth.c	2004-06-04 09:49:59 -06:00
+++ edited/drivers/net/ioc3-eth.c	2004-08-04 13:24:07 -06:00
@@ -1172,9 +1172,14 @@
 	u32 vendor, model, rev;
 	int err;
 
+	if (pci_enable_device(pdev))
+		return -ENODEV;
+
 	dev = alloc_etherdev(sizeof(struct ioc3_private));
-	if (!dev)
-		return -ENOMEM;
+	if (!dev) {
+		err = -ENOMEM;
+		goto out_disable;
+	}
 
 	err = pci_request_regions(pdev, "ioc3");
 	if (err)
@@ -1269,6 +1274,8 @@
 	pci_release_regions(pdev);
 out_free:
 	free_netdev(dev);
+out_disable:
+	pci_disable_device(pdev);
 	return err;
 }
 
@@ -1282,6 +1289,7 @@
 	iounmap(ioc3);
 	pci_release_regions(pdev);
 	free_netdev(dev);
+	pci_disable_device(pdev);
 }
 
 static struct pci_device_id ioc3_pci_tbl[] = {
