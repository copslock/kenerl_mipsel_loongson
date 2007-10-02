Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Oct 2007 15:24:32 +0100 (BST)
Received: from mo30.po.2iij.NET ([210.128.50.53]:22790 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20024277AbXJBOXz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 2 Oct 2007 15:23:55 +0100
Received: by mo.po.2iij.net (mo30) id l92EMbt4093754; Tue, 2 Oct 2007 23:22:37 +0900 (JST)
Received: from delta (221.25.30.125.dy.iij4u.or.jp [125.30.25.221])
	by mbox.po.2iij.net (po-mbox303) id l92EMX8N007181
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 2 Oct 2007 23:22:33 +0900
Date:	Tue, 2 Oct 2007 22:54:41 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][1/4] move Cobalt PCI definitions to
 arch/mips/pci/fixup-cobalt.c
Message-Id: <20071002225441.63d935eb.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.0 (GTK+ 2.10.11; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16792
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Move Cobalt PCI definitions to arch/mips/pci/fixup-cobalt.c.
These PCI definitions are only used in arch/mips/pci/fixup-cobalt.c.

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
