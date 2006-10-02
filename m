Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Oct 2006 12:55:18 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:54544 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20038745AbWJBLzM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 2 Oct 2006 12:55:12 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id B3346F5EC1;
	Mon,  2 Oct 2006 13:55:06 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OObclvLcQDeV; Mon,  2 Oct 2006 13:55:06 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 579DCE1CB2;
	Mon,  2 Oct 2006 13:55:06 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.1) with ESMTP id k92BtCt3027483;
	Mon, 2 Oct 2006 13:55:12 +0200
Date:	Mon, 2 Oct 2006 12:55:09 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	linux-mips@linux-mips.org
Subject: [patch] 2.6.18: TRDY timeout tweaks for Broadcom SiByte systems
Message-ID: <Pine.LNX.4.64N.0610021227150.1359@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.4/1965/Mon Oct  2 11:52:42 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12763
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

Hello,

 It was obesrved that at least one older PCI card predating the 
requirement for the TRDY signal to respond within 16 clock ticks actually 
does not meet this rule nor even the power-on defaults of the PCI bridges 
found in development systems built around the Broadcom SiByte SOCs.  Here 
is a patch that bumps up the timeout to the highest finite value supported 
by these chips, which is 255 clock ticks.  The bridges affected are the 
SiByte SOC itself and the SP1011.

 This change does not effectively affect systems only having PCI option 
cards installed that meet the TRDY requirement of the current PCI spec.  
The rule was introduced with PCI 2.1, so any older card may make the 
system affected.  If this is the case, performance of the system will 
suffer in return for the card working at all.  If this is a concern, then 
the solution is not to use such cards.

 Please apply the change.

  Maciej

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>

patch-mips-2.6.15-20060124-sb1250-retry-3
diff -up --recursive --new-file linux-mips-2.6.15-20060124.macro/arch/mips/pci/fixup-sb1250.c linux-mips-2.6.15-20060124/arch/mips/pci/fixup-sb1250.c
--- linux-mips-2.6.15-20060124.macro/arch/mips/pci/fixup-sb1250.c	2004-12-18 22:28:20.000000000 +0000
+++ linux-mips-2.6.15-20060124/arch/mips/pci/fixup-sb1250.c	2006-09-20 01:36:46.000000000 +0000
@@ -1,7 +1,7 @@
 /*
  *	arch/mips/pci/fixup-sb1250.c
  *
- *	Copyright (C) 2004  MIPS Technologies, Inc.  All rights reserved.
+ *	Copyright (C) 2004, 2006  MIPS Technologies, Inc.  All rights reserved.
  *	    Author:	Maciej W. Rozycki <macro@mips.com>
  *
  *	This program is free software; you can redistribute it and/or
@@ -14,6 +14,17 @@
 #include <linux/pci.h>
 
 /*
+ * Set the the BCM1250, etc. PCI host bridge's TRDY timeout
+ * to the finite max.
+ */
+static void __init quirk_sb1250_pci(struct pci_dev *dev)
+{
+	pci_write_config_byte(dev, 0x40, 0xff);
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SIBYTE, PCI_DEVICE_ID_BCM1250_PCI,
+			quirk_sb1250_pci);
+
+/*
  * The BCM1250, etc. PCI/HT bridge reports as a host bridge.
  */
 static void __init quirk_sb1250_ht(struct pci_dev *dev)
@@ -22,3 +33,13 @@ static void __init quirk_sb1250_ht(struc
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SIBYTE, PCI_DEVICE_ID_BCM1250_HT,
 			quirk_sb1250_ht);
+
+/*
+ * Set the the SP1011 HT/PCI bridge's TRDY timeout to the finite max.
+ */
+static void __init quirk_sp1011(struct pci_dev *dev)
+{
+	pci_write_config_byte(dev, 0x64, 0xff);
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SIPACKETS, PCI_DEVICE_ID_SP1011,
+			quirk_sp1011);
diff -up --recursive --new-file linux-mips-2.6.15-20060124.macro/include/linux/pci_ids.h linux-mips-2.6.15-20060124/include/linux/pci_ids.h
--- linux-mips-2.6.15-20060124.macro/include/linux/pci_ids.h	2006-01-12 06:00:39.000000000 +0000
+++ linux-mips-2.6.15-20060124/include/linux/pci_ids.h	2006-09-20 00:44:52.000000000 +0000
@@ -1834,6 +1834,8 @@
 #define PCI_DEVICE_ID_PANACOM_QUADMODEM	0x0400
 #define PCI_DEVICE_ID_PANACOM_DUALMODEM	0x0402
 
+#define PCI_VENDOR_ID_SIPACKETS		0x14d9
+#define PCI_DEVICE_ID_SP1011		0x0010
 
 #define PCI_VENDOR_ID_AFAVLAB		0x14db
 #define PCI_DEVICE_ID_AFAVLAB_P028	0x2180
@@ -1933,6 +1935,7 @@
 #define PCI_DEVICE_ID_FARSITE_TE1C      0x1612
 
 #define PCI_VENDOR_ID_SIBYTE		0x166d
+#define PCI_DEVICE_ID_BCM1250_PCI	0x0001
 #define PCI_DEVICE_ID_BCM1250_HT	0x0002
 
 #define PCI_VENDOR_ID_NETCELL		0x169c
