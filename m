Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2006 15:33:13 +0000 (GMT)
Received: from rtsoft3.corbina.net ([85.21.88.6]:54336 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S8133500AbWBWPbx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Feb 2006 15:31:53 +0000
Received: from 192.168.1.104 ([10.150.0.9])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id k1NFd8t16410
	for <linux-mips@linux-mips.org>; Thu, 23 Feb 2006 19:39:08 +0400
Subject: NEC VR5701 support
From:	Sergey Podstavin <spodstavin@ru.mvista.com>
Reply-To: spodstavin@ru.mvista.com
To:	linux-mips <linux-mips@linux-mips.org>
Content-Type: multipart/mixed; boundary="=-RHajCj5sMobUZ9wfJIFh"
Organization: MontaVista
Date:	Thu, 23 Feb 2006 18:39:09 +0300
Message-Id: <1140709149.5741.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Return-Path: <spodstavin@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10618
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: spodstavin@ru.mvista.com
Precedence: bulk
X-list: linux-mips


--=-RHajCj5sMobUZ9wfJIFh
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-RHajCj5sMobUZ9wfJIFh
Content-Disposition: attachment; filename=pro_mips_nec_vr5701_ide_fix.patch
Content-Type: text/x-patch; name=pro_mips_nec_vr5701_ide_fix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Source: MontaVista Software, Inc.
MR: 14884
Type: Defect Fix
Disposition: needs submitting to linuxmips-embedded mailing list
Signed-off-by: Aleskey Makarov <makarov@ru.mvista.com>
Description:
    The address of IDE control register on this platform
    is not standard. Also, an unnecessary check for pci
    vendor/device/class was removed and
    an unnamed constant assignment was fixed.

Index: linux-2.6.10/arch/mips/vr5701/tcube/setup.c
===================================================================
--- linux-2.6.10.orig/arch/mips/vr5701/tcube/setup.c
+++ linux-2.6.10/arch/mips/vr5701/tcube/setup.c
@@ -123,7 +123,7 @@ static void __init tcube_board_init(void
 	 * IO_BASE in CPU physical address space.
 	 */
 	ddb_set_pmr(EPCI_INIT0, DDB_PCICMD_MEM, 0x10000000, DDB_PCI_ACCESS_32);
-	ddb_set_pmr(EPCI_INIT1, DDB_PCICMD_IO, 0x00001000, DDB_PCI_ACCESS_32);
+	ddb_set_pmr(EPCI_INIT1, DDB_PCICMD_IO, 0x00000000, DDB_PCI_ACCESS_32);
 	ddb_set_pmr(IPCI_INIT0, DDB_PCICMD_MEM, 0x18800000, DDB_PCI_ACCESS_32);
 	ddb_set_pmr(IPCI_INIT1, DDB_PCICMD_IO, 0x01000000, DDB_PCI_ACCESS_32);
 
Index: linux-2.6.10/drivers/ide/pci/nec_vr5701_sg2.c
===================================================================
--- linux-2.6.10.orig/drivers/ide/pci/nec_vr5701_sg2.c
+++ linux-2.6.10/drivers/ide/pci/nec_vr5701_sg2.c
@@ -44,6 +44,13 @@ static void __init init_hwif_nec_vr5701(
 	hwif->mwdma_mask = 0x07;
 	hwif->swdma_mask = 0x07;
 
+	{
+		struct pci_dev * pci_dev = hwif->pci_dev;
+		hwif->io_ports[IDE_CONTROL_OFFSET]
+			= hwif->hw.io_ports[IDE_CONTROL_OFFSET]
+			= pci_resource_start(pci_dev, 1) + 0x06;
+	}
+
 	if (!noautodma)
 		hwif->autodma = 1;
 	hwif->drives[0].autodma = hwif->autodma;
@@ -65,15 +72,9 @@ static int __devinit nec_vr5701_init_one
 	ide_pci_device_t *d = &nec_vr5701_chipset;
 	u16 command;
 
-	if (dev->vendor == PCI_VENDOR_ID_NEC &&
-	    dev->device == PCI_DEVICE_ID_NEC_USB_AND_IDE &&
-	    dev->class == 0x0c0310)
-		return 1;
-	udelay(100);
 	pci_enable_device(dev);
-	*(volatile unsigned char *)0xb9001010 = 6;
-	asm("sync");
-	udelay(100);
+
+	outb(6, pci_resource_start(dev, 5));
 
 	pci_read_config_word(dev, PCI_COMMAND, &command);
 	if (!(command & PCI_COMMAND_IO)) {
Index: linux-2.6.10/include/linux/lsppatchlevel.h
===================================================================
--- linux-2.6.10.orig/include/linux/lsppatchlevel.h
+++ linux-2.6.10/include/linux/lsppatchlevel.h
@@ -6,4 +6,4 @@
  * is licensed "as is" without any warranty of any kind, whether express
  * or implied.
  */
-#define LSP_PATCH_LEVEL "6"
+#define LSP_PATCH_LEVEL "7"
Index: linux-2.6.10/mvl_patches/pro-0007.c
===================================================================
--- /dev/null
+++ linux-2.6.10/mvl_patches/pro-0007.c
@@ -0,0 +1,16 @@
+/*
+ * Author: MontaVista Software, Inc. <source@mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#include <linux/init.h>
+#include <linux/mvl_patch.h>
+
+static __init int regpatch(void)
+{
+        return mvl_register_patch(7);
+}
+module_init(regpatch);

--=-RHajCj5sMobUZ9wfJIFh--
