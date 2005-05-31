Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 May 2005 15:52:22 +0100 (BST)
Received: from RT-soft-1.Moscow.itn.ru ([IPv6:::ffff:80.240.96.90]:63375 "EHLO
	buildserver.ru.mvista.com") by linux-mips.org with ESMTP
	id <S8225799AbVEaOwH>; Tue, 31 May 2005 15:52:07 +0100
Received: from 192.168.1.226 ([10.150.0.9])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id j4VEq5t06824;
	Tue, 31 May 2005 19:52:05 +0500
Subject: [PATCH]  PCI IDs for NEC VR5701-SG2 Board
From:	Sergey Podstavin <spodstavin@ru.mvista.com>
Reply-To: spodstavin@ru.mvista.com
To:	mj@ucw.cz
Cc:	linux-mips <linux-mips@linux-mips.org>
Content-Type: multipart/mixed; boundary="=-0N0Ff8XkG2RMe9cCGPzZ"
Organization: MontaVista
Date:	Tue, 31 May 2005 18:52:23 +0400
Message-Id: <1117551143.5564.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Return-Path: <spodstavin@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8032
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: spodstavin@ru.mvista.com
Precedence: bulk
X-list: linux-mips


--=-0N0Ff8XkG2RMe9cCGPzZ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Martin!

Attached is PCI IDs for NEC VR5701-SG2 Board. The CPU is Vr5701, Vr5500
core. The CPU has internal IDE interface and USB interface with the same
device ID - 0000. The internal AC97 interface uses the same device ID as
VRC5477 system controller for AC97 interface. The board works with
Lynx3DM SM722 video adapter, Silicon Motion Inc. The Silicon Motion IDs
had been added to drivers/pci/pci.ids early. Please review it.

Best wishes,
Sergey Podstavin.



--=-0N0Ff8XkG2RMe9cCGPzZ
Content-Disposition: attachment; filename=community_mips_nec_vr5701_pci_id.patch
Content-Type: text/x-patch; name=community_mips_nec_vr5701_pci_id.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Naurp --exclude=CVS linux_save/drivers/pci/pci.ids linux_mips/drivers/pci/pci.ids
--- linux_save/drivers/pci/pci.ids	2005-04-08 22:58:21.000000000 +0400
+++ linux_mips/drivers/pci/pci.ids	2005-05-31 18:38:16.000000000 +0400
@@ -1612,7 +1612,7 @@
 	6057  MiroVideo DC10/DC30+
 1032  Compaq
 1033  NEC Corporation
-	0000  Vr4181A USB Host or Function Control Unit
+	0000  Vr4181A USB Host or IDE Controller
 	0001  PCI to 486-like bus Bridge
 	0002  PCI to VL98 Bridge
 	0003  ATM Controller
@@ -1653,7 +1653,7 @@
 		1033 8014  RCV56ACF 56k Voice Modem
 	009b  Vrc5476
 	00a5  VRC4173
-	00a6  VRC5477 AC97
+	00a6  VRC5477 or VR5701 AC97 Controller
 	00cd  IEEE 1394 [OrangeLink] Host Controller
 		12ee 8011  Root hub
 	00ce  IEEE 1394 Host Controller
diff -Naurp --exclude=CVS linux_save/include/linux/pci_ids.h linux_mips/include/linux/pci_ids.h
--- linux_save/include/linux/pci_ids.h	2005-05-26 13:12:48.000000000 +0400
+++ linux_mips/include/linux/pci_ids.h	2005-05-31 18:38:16.000000000 +0400
@@ -582,6 +582,7 @@
 #define PCI_DEVICE_ID_MIRO_DC30PLUS	0xd801
 
 #define PCI_VENDOR_ID_NEC		0x1033
+#define PCI_DEVICE_ID_NEC_USB_AND_IDE	0x0000 /* USB 1.1 or IDE Controller*/
 #define PCI_DEVICE_ID_NEC_CBUS_1	0x0001 /* PCI-Cbus Bridge */
 #define PCI_DEVICE_ID_NEC_LOCAL		0x0002 /* Local Bridge */
 #define PCI_DEVICE_ID_NEC_ATM		0x0003 /* ATM LAN Controller */
@@ -1787,6 +1788,11 @@
 #define PCI_DEVICE_ID_SATSAGEM_PCR2101	0x5352
 #define PCI_DEVICE_ID_SATSAGEM_TELSATTURBO 0x5a4b
 
+#define PCI_VENDOR_ID_SMI		0x126f
+#define PCI_DEVICE_ID_SMI_LYNX_EM	0x0710
+#define PCI_DEVICE_ID_SMI_LYNX_EM_PLUS	0x0712
+#define PCI_DEVICE_ID_SMI_LYNX_3DM	0x0720
+
 #define PCI_VENDOR_ID_HUGHES		0x1273
 #define PCI_DEVICE_ID_HUGHES_DIRECPC	0x0002
 

--=-0N0Ff8XkG2RMe9cCGPzZ--
