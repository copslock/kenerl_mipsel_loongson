Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jul 2007 16:12:55 +0100 (BST)
Received: from gw-eur4.philips.com ([161.85.125.10]:65346 "EHLO
	gw-eur4.philips.com") by ftp.linux-mips.org with ESMTP
	id S20022618AbXGSPMx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Jul 2007 16:12:53 +0100
Received: from smtpscan-eur7.philips.com (smtpscan-eur7.mail.philips.com [130.144.57.172])
	by gw-eur4.philips.com (Postfix) with ESMTP id B0E2B49713
	for <linux-mips@linux-mips.org>; Thu, 19 Jul 2007 15:12:17 +0000 (UTC)
Received: from smtpscan-eur7.philips.com (localhost [127.0.0.1])
	by localhost.philips.com (Postfix) with ESMTP id 7C2D6C0
	for <linux-mips@linux-mips.org>; Thu, 19 Jul 2007 15:12:17 +0000 (GMT)
Received: from smtprelay-eur1.philips.com (smtprelay-eur1.philips.com [130.144.57.170])
	by smtpscan-eur7.philips.com (Postfix) with ESMTP id D2453402
	for <linux-mips@linux-mips.org>; Thu, 19 Jul 2007 15:12:16 +0000 (GMT)
Received: from lnx32www01.soton.sc.philips.com (pww.osrp.sc.philips.com [130.141.89.1])
	by smtprelay-eur1.philips.com (Postfix) with ESMTP id 6F061241E
	for <linux-mips@linux-mips.org>; Thu, 19 Jul 2007 15:12:16 +0000 (GMT)
Received: from krate.soton.sc.philips.com (krate [130.141.7.10])
	by lnx32www01.soton.sc.philips.com (8.13.7/8.13.7) with ESMTP id l6JFCFjf025108
	for <linux-mips@linux-mips.org>; Thu, 19 Jul 2007 16:12:15 +0100
Received: from stout.soton.sc.philips.com (root@stout [130.141.7.8])
	by krate.soton.sc.philips.com (8.12.11/8.12.11) with ESMTP id l6JFCBHX029067
	for <linux-mips@linux-mips.org>; Thu, 19 Jul 2007 16:12:11 +0100 (BST)
Received: from [130.141.93.19] (host9319 [130.141.93.19])
	by stout.soton.sc.philips.com (8.11.3/8.11.3) with ESMTP id l6JFCBl23516
	for <linux-mips@linux-mips.org>; Thu, 19 Jul 2007 16:12:11 +0100 (BST)
Message-ID: <469F7F4A.1060507@nxp.com>
Date:	Thu, 19 Jul 2007 16:12:10 +0100
From:	Daniel Laird <daniel.j.laird@nxp.com>
User-Agent: Thunderbird 2.0.0.4 (Windows/20070604)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [PATCH] Add missing interrupts for STB810/PNX8550 system 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <daniel.j.laird@nxp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15816
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.j.laird@nxp.com
Precedence: bulk
X-list: linux-mips

Add Missing interrupts for STB810 systems

Signed-off-by: Daniel Laird <daniel.j.laird@nxp.com>
---
 irqmap.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)
---
 
Index: linux-2.6.22.1_nxp/arch/mips/philips/pnx8550/stb810/irqmap.c
===================================================================
--- linux-2.6.22.1_orig/arch/mips/philips/pnx8550/stb810/irqmap.c   
 (revision 9)
+++ linux-2.6.22.1_new/arch/mips/philips/pnx8550/stb810/irqmap.c   
 (working copy)
@@ -15,9 +15,18 @@
 #include <linux/init.h>
 #include <int.h>
 
+/* Fill in the correct interrupts for STB810
+ * [8]  = SATA Controller
+ * [9]  = USB Controller
+ * [10] = Ethernet Controller
+ * [11] = External PCI Slot
+ * [12] = Mini PCI Slot
+ */
 char pnx8550_irq_tab[][5] __initdata = {
-    [8]    = { -1, PNX8550_INT_PCI_INTA, 0xff, 0xff, 0xff},
-    [9]    = { -1, PNX8550_INT_PCI_INTA, 0xff, 0xff, 0xff},
-    [10]    = { -1, PNX8550_INT_PCI_INTA, 0xff, 0xff, 0xff},
+    [8]    = { -1, PNX8550_INT_PCI_INTA, 0xff, 0xff, 0xff},
+    [9]    = { -1, PNX8550_INT_PCI_INTA, 0xff, 0xff, 0xff},
+    [10]    = { -1, PNX8550_INT_PCI_INTA, 0xff, 0xff, 0xff},
+    [11] = { -1, PNX8550_INT_PCI_INTA, 0xff, 0xff, 0xff},
+    [12] = { -1, PNX8550_INT_PCI_INTA, 0xff, 0xff, 0xff},
 };
 
