Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Mar 2005 21:36:46 +0000 (GMT)
Received: from port535.ds1-van.adsl.cybercity.dk ([IPv6:::ffff:217.157.140.228]:37738
	"EHLO valis.murphy.dk") by linux-mips.org with ESMTP
	id <S8225547AbVCQVgF>; Thu, 17 Mar 2005 21:36:05 +0000
Received: from brian.localnet (root@[10.0.0.2])
	by valis.murphy.dk (8.13.2/8.13.2/Debian-1) with ESMTP id j2HLZtqM028508;
	Thu, 17 Mar 2005 22:35:55 +0100
Received: from brian.localnet (brm@localhost [127.0.0.1])
	by brian.localnet (8.12.11/8.12.11/Debian-5) with ESMTP id j2HLZtI8006207;
	Thu, 17 Mar 2005 22:35:55 +0100
Received: (from brm@localhost)
	by brian.localnet (8.12.11/8.12.11/Debian-5) id j2HLZtH0006206;
	Thu, 17 Mar 2005 22:35:55 +0100
Date:	Thu, 17 Mar 2005 22:35:55 +0100
From:	Brian Murphy <brm@murphy.dk>
Message-Id: <200503172135.j2HLZtH0006206@brian.localnet>
To:	ralf@linux-mips.org
Subject: [PATCH 2.6] Lasat cleanups (pci-lasat.c)
Cc:	linux-mips@linux-mips.org
Return-Path: <brm@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7460
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brm@murphy.dk
Precedence: bulk
X-list: linux-mips

Hi Ralf,
	this is some formatting fixups (linux coding style)
and removal of duplicate and unused headers from the Lasat pci setup code.

Please apply.

/Brian

Index: arch/mips/pci/pci-lasat.c
===================================================================
RCS file: /cvs/linux/arch/mips/pci/pci-lasat.c,v
retrieving revision 1.8
diff -u -r1.8 pci-lasat.c
--- arch/mips/pci/pci-lasat.c	31 Oct 2004 16:07:33 -0000	1.8
+++ arch/mips/pci/pci-lasat.c	17 Mar 2005 21:19:24 -0000
@@ -7,12 +7,8 @@
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <linux/types.h>
-#include <linux/interrupt.h>
-#include <linux/pci.h>
-#include <linux/delay.h>
 #include <asm/bootinfo.h>
 
 extern struct pci_ops nile4_pci_ops;
@@ -20,14 +16,14 @@
 static struct resource lasat_pci_mem_resource = {
 	.name	= "LASAT PCI MEM",
 	.start	= 0x18000000,
-	.end	= 0x19FFFFFF,
+	.end	= 0x19ffffff,
 	.flags	= IORESOURCE_MEM,
 };
 
 static struct resource lasat_pci_io_resource = {
 	.name	= "LASAT PCI IO",
 	.start	= 0x1a000000,
-	.end	= 0x1bFFFFFF,
+	.end	= 0x1bffffff,
 	.flags	= IORESOURCE_IO,
 };
 
@@ -38,21 +34,19 @@
 
 static int __init lasat_pci_setup(void)
 {
- 	printk("PCI: starting\n");
-
-        switch (mips_machtype) {
-            case MACH_LASAT_100:
-                lasat_pci_controller.pci_ops = &gt64120_pci_ops;
-                break;
-            case MACH_LASAT_200:
-                lasat_pci_controller.pci_ops = &nile4_pci_ops;
-                break;
-            default:
-                panic("pcibios_init: mips_machtype incorrect");
-        }
+	switch (mips_machtype) {
+	case MACH_LASAT_100:
+		lasat_pci_controller.pci_ops = &gt64120_pci_ops;
+		break;
+	case MACH_LASAT_200:
+		lasat_pci_controller.pci_ops = &nile4_pci_ops;
+		break;
+	default:
+		panic("pcibios_init: mips_machtype incorrect");
+	}
 
 	register_pci_controller(&lasat_pci_controller);
-        return 0;
+	return 0;
 }
 early_initcall(lasat_pci_setup);
 
@@ -68,24 +62,24 @@
 
 int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
-    switch (slot) {
-        case 1:
-            return LASATINT_PCIA;   /* Expansion Module 0 */
-        case 2:
-            return LASATINT_PCIB;   /* Expansion Module 1 */
-        case 3:
-            return LASATINT_PCIC;   /* Expansion Module 2 */
-        case 4:
-            return LASATINT_ETH1;   /* Ethernet 1 (LAN 2) */
-        case 5:
-            return LASATINT_ETH0;   /* Ethernet 0 (LAN 1) */
-        case 6:
-            return LASATINT_HDC;    /* IDE controller */
-        default:
-            return 0xff;            /* Illegal */
-    }
+	switch (slot) {
+	case 1:
+		return LASATINT_PCIA;
+	case 2:
+		return LASATINT_PCIB;
+	case 3:
+		return LASATINT_PCIC;
+	case 4:
+		return LASATINT_ETH1;   /* Ethernet 1 (LAN 2) */
+	case 5:
+		return LASATINT_ETH0;   /* Ethernet 0 (LAN 1) */
+	case 6:
+		return LASATINT_HDC;    /* IDE controller */
+	default:
+		return 0xff;            /* Illegal */
+	}
 
-    return -1;
+	return -1;
 }
 
 /* Do platform specific device initialization at pci_enable_device() time */
