Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2007 09:27:28 +0100 (BST)
Received: from p549F7FC7.dip.t-dialin.net ([84.159.127.199]:38071 "EHLO
	p549F7FC7.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S20021625AbXINIZ5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 14 Sep 2007 09:25:57 +0100
Received: from mo31.po.2iij.NET ([210.128.50.54]:7462 "EHLO mo31.po.2iij.net")
	by lappi.linux-mips.net with ESMTP id S1095623AbXINISM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 14 Sep 2007 10:18:12 +0200
Received: by mo.po.2iij.net (mo31) id l8E8FVbi052174; Fri, 14 Sep 2007 17:15:31 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox301) id l8E8FUrk010103
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 14 Sep 2007 17:15:30 +0900
Date:	Fri, 14 Sep 2007 17:14:20 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][1/9][MIPS] move Cobalt PCI definitions to
 arch/mips/pci/fixup-cobalt.c
Message-Id: <20070914171420.0b8cfd15.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16521
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Move Cobalt PCI definitions to arch/mips/pci/fixup-cobalt.c.

These definitions are only used in arch/mips/pci/fixup-cobalt.c.
They can be moved to fixup-cobalt.c.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/pci/fixup-cobalt.c mips/arch/mips/pci/fixup-cobalt.c
--- mips-orig/arch/mips/pci/fixup-cobalt.c	2007-09-14 14:24:04.932503500 +0900
+++ mips/arch/mips/pci/fixup-cobalt.c	2007-09-14 14:25:01.604045250 +0900
@@ -20,6 +20,23 @@
 #include <cobalt.h>
 #include <irq.h>
 
+/*
+ * PCI slot numbers
+ */
+#define COBALT_PCICONF_CPU	0x06
+#define COBALT_PCICONF_ETH0	0x07
+#define COBALT_PCICONF_RAQSCSI	0x08
+#define COBALT_PCICONF_VIA	0x09
+#define COBALT_PCICONF_PCISLOT	0x0A
+#define COBALT_PCICONF_ETH1	0x0C
+
+/*
+ * The Cobalt board ID information.  The boards have an ID number wired
+ * into the VIA that is available in the high nibble of register 94.
+ */
+#define VIA_COBALT_BRD_ID_REG  0x94
+#define VIA_COBALT_BRD_REG_to_ID(reg)	((unsigned char)(reg) >> 4)
+
 static void qube_raq_galileo_early_fixup(struct pci_dev *dev)
 {
 	if (dev->devfn == PCI_DEVFN(0, 0) &&
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/mach-cobalt/cobalt.h mips/include/asm-mips/mach-cobalt/cobalt.h
--- mips-orig/include/asm-mips/mach-cobalt/cobalt.h	2007-09-14 14:24:04.952504750 +0900
+++ mips/include/asm-mips/mach-cobalt/cobalt.h	2007-09-14 14:21:49.180019500 +0900
@@ -13,37 +13,15 @@
 #define __ASM_COBALT_H
 
 /*
- * PCI configuration space manifest constants.  These are wired into
- * the board layout according to the PCI spec to enable the software
- * to probe the hardware configuration space in a well defined manner.
- *
- * The PCI_DEVSHFT() macro transforms these values into numbers
- * suitable for passing as the dev parameter to the various
- * pcibios_read/write_config routines.
+ * The Cobalt board ID information.
  */
-#define COBALT_PCICONF_CPU      0x06
-#define COBALT_PCICONF_ETH0     0x07
-#define COBALT_PCICONF_RAQSCSI  0x08
-#define COBALT_PCICONF_VIA      0x09
-#define COBALT_PCICONF_PCISLOT  0x0A
-#define COBALT_PCICONF_ETH1     0x0C
-
+extern int cobalt_board_id;
 
-/*
- * The Cobalt board id information.  The boards have an ID number wired
- * into the VIA that is available in the high nibble of register 94.
- * This register is available in the VIA configuration space through the
- * interface routines qube_pcibios_read/write_config. See cobalt/pci.c
- */
-#define VIA_COBALT_BRD_ID_REG  0x94
-#define VIA_COBALT_BRD_REG_to_ID(reg)  ((unsigned char) (reg) >> 4)
 #define COBALT_BRD_ID_QUBE1    0x3
 #define COBALT_BRD_ID_RAQ1     0x4
 #define COBALT_BRD_ID_QUBE2    0x5
 #define COBALT_BRD_ID_RAQ2     0x6
 
-extern int cobalt_board_id;
-
 #define COBALT_LED_PORT		(*(volatile unsigned char *) CKSEG1ADDR(0x1c000000))
 # define COBALT_LED_BAR_LEFT	(1 << 0)	/* Qube */
 # define COBALT_LED_BAR_RIGHT	(1 << 1)	/* Qube */
