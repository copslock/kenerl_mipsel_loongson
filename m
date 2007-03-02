Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Mar 2007 21:11:55 +0000 (GMT)
Received: from smtp-ext.int-evry.fr ([157.159.11.17]:50596 "EHLO
	smtp-ext.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S20039618AbXCBVKX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 2 Mar 2007 21:10:23 +0000
Received: from mini.int.alphacore.net (florian.maisel.int-evry.fr [157.159.41.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id E736A8D1696
	for <linux-mips@linux-mips.org>; Fri,  2 Mar 2007 22:09:30 +0100 (CET)
From:	Florian Fainelli <florian.fainelli@int-evry.fr>
To:	linux-mips@linux-mips.org
Subject: [PATCH 4/7] MTX1 isdel carbus ressources
Date:	Fri, 2 Mar 2007 22:07:48 +0100
User-Agent: KMail/1.9.6
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_kIJ6Flu0c4KDnm/"
Message-Id: <200703022207.48159.florian.fainelli@int-evry.fr>
Return-Path: <florian.fainelli@int-evry.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14315
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@int-evry.fr
Precedence: bulk
X-list: linux-mips

--Boundary-00=_kIJ6Flu0c4KDnm/
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch adds cardbus ressources for MTX1 boards which have a PCMCIA 
controller.

Signed-off-by: Florian Fainelli <florian.fainelli@int-evry.fr>
--

--Boundary-00=_kIJ6Flu0c4KDnm/
Content-Type: text/x-diff;
  charset="us-ascii";
  name="008-isdel_cardbus.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="008-isdel_cardbus.patch"

diff -urN linux-2.6.16.7/arch/mips/au1000/mtx-1/board_setup.c linux-2.6.16.7.new/arch/mips/au1000/mtx-1/board_setup.c
--- linux-2.6.16.7/arch/mips/au1000/mtx-1/board_setup.c	2006-04-23 14:39:21.000000000 +0200
+++ linux-2.6.16.7.new/arch/mips/au1000/mtx-1/board_setup.c	2006-04-23 14:39:03.000000000 +0200
@@ -44,6 +44,9 @@
 #include <asm/pgtable.h>
 #include <asm/mach-au1x00/au1000.h>
 
+extern int (*board_pci_idsel)(unsigned int devsel, int assert);
+int    mtx1_pci_idsel(unsigned int devsel, int assert);
+
 void board_reset (void)
 {
 	/* Hit BCSR.SYSTEM_CONTROL[SW_RST] */
@@ -77,11 +80,37 @@
 	au_writel( 0xFFFFFFFF, SYS_TRIOUTCLR );
 	au_writel( 0x00000001, SYS_OUTPUTCLR ); // set M66EN (PCI 66MHz) to OFF
 	au_writel( 0x00000008, SYS_OUTPUTSET ); // set PCI CLKRUN# to OFF
+	au_writel( 0x00000002, SYS_OUTPUTSET ); // set EXT_IO3 ON
 	au_writel( 0x00000020, SYS_OUTPUTCLR ); // set eth PHY TX_ER to OFF
 
 	// enable LED and set it to green
 	au_writel( au_readl(GPIO2_DIR) | 0x1800, GPIO2_DIR );
 	au_writel( 0x18000800, GPIO2_OUTPUT );
 
+	board_pci_idsel = mtx1_pci_idsel;
+
 	printk("4G Systems MTX-1 Board\n");
 }
+
+int
+mtx1_pci_idsel(unsigned int devsel, int assert)
+{
+#define MTX_IDSEL_ONLY_0_AND_3 0
+#if MTX_IDSEL_ONLY_0_AND_3
+       if (devsel != 0 && devsel != 3) {
+               printk("*** not 0 or 3\n");
+               return 0;
+       }
+#endif
+
+       if (assert && devsel != 0) {
+               // supress signal to cardbus
+               au_writel( 0x00000002, SYS_OUTPUTCLR ); // set EXT_IO3 OFF
+       }
+       else {
+               au_writel( 0x00000002, SYS_OUTPUTSET ); // set EXT_IO3 ON
+       }
+       au_sync_udelay(1);
+       return 1;
+}
+
diff -urN linux-2.6.16.7/arch/mips/au1000/mtx-1/irqmap.c linux-2.6.16.7.new/arch/mips/au1000/mtx-1/irqmap.c
--- linux-2.6.16.7/arch/mips/au1000/mtx-1/irqmap.c	2006-04-23 14:40:54.000000000 +0200
+++ linux-2.6.16.7.new/arch/mips/au1000/mtx-1/irqmap.c	2006-04-23 14:40:12.000000000 +0200
@@ -48,7 +48,7 @@
 #include <asm/mach-au1x00/au1000.h>
 
 char irq_tab_alchemy[][5] __initdata = {
- [0] = { -1, INTA, INTB, INTX, INTX},   /* IDSEL 00 - AdapterA-Slot0 (top)    */
+ [0] = { -1, INTA, INTA, INTX, INTX},   /* IDSEL 00 - AdapterA-Slot0 (top)    */
  [1] = { -1, INTB, INTA, INTX, INTX},   /* IDSEL 01 - AdapterA-Slot1 (bottom) */
  [2] = { -1, INTC, INTD, INTX, INTX},   /* IDSEL 02 - AdapterB-Slot0 (top)    */
  [3] = { -1, INTD, INTC, INTX, INTX},   /* IDSEL 03 - AdapterB-Slot1 (bottom) */

--Boundary-00=_kIJ6Flu0c4KDnm/--
