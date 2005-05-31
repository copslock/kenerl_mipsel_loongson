Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 May 2005 15:25:10 +0100 (BST)
Received: from RT-soft-1.Moscow.itn.ru ([IPv6:::ffff:80.240.96.90]:53135 "EHLO
	buildserver.ru.mvista.com") by linux-mips.org with ESMTP
	id <S8225792AbVEaOYz>; Tue, 31 May 2005 15:24:55 +0100
Received: from 192.168.1.226 ([10.150.0.9])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id j4VEOmt06157;
	Tue, 31 May 2005 19:24:48 +0500
Subject: [PATCH] An IDE driver for NEC VR5701-SG2 Board
From:	Sergey Podstavin <spodstavin@ru.mvista.com>
Reply-To: spodstavin@ru.mvista.com
To:	B.Zolnierkiewicz@elka.pw.edu.pl
Cc:	linux-mips <linux-mips@linux-mips.org>
Content-Type: multipart/mixed; boundary="=-1QT6C8KMS2odChJmeBIX"
Organization: MontaVista
Date:	Tue, 31 May 2005 18:25:06 +0400
Message-Id: <1117549506.5564.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Return-Path: <spodstavin@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8029
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: spodstavin@ru.mvista.com
Precedence: bulk
X-list: linux-mips


--=-1QT6C8KMS2odChJmeBIX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Bartlomiej!

Attached is an IDE driver for NEC VR5701-SG2 Board. It works on CPU
VR5701 internal IDE interface. The IDE has the same vendor ID and Device
ID for internal USB interface, so the driver check class ID. Please
review it.

Best wishes,
Sergey Podstavin.

--=-1QT6C8KMS2odChJmeBIX
Content-Disposition: attachment; filename=community_mips_nec_vr5701_ide.patch
Content-Type: text/x-patch; name=community_mips_nec_vr5701_ide.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Naurp --exclude=CVS linux_save/drivers/ide/Kconfig linux_mips/drivers/ide/Kconfig
--- linux_save/drivers/ide/Kconfig	2005-03-18 20:37:18.000000000 +0300
+++ linux_mips/drivers/ide/Kconfig	2005-05-31 17:58:08.000000000 +0400
@@ -835,6 +835,12 @@ config BLK_DEV_GAYLE
 	  Note that you also have to enable Zorro bus support if you want to
 	  use Gayle IDE interfaces on the Zorro expansion bus.
 
+config BLK_DEV_NEC_VR5701_SG2
+	bool "NEC VR5701-SG2 IDE interface support"
+	depends on TCUBE
+	help
+	  This is the IDE driver for the NEC VR5701-SG2 IDE interface. 
+
 config BLK_DEV_IDEDOUBLER
 	bool "Amiga IDE Doubler support (EXPERIMENTAL)"
 	depends on BLK_DEV_GAYLE && EXPERIMENTAL
diff -Naurp --exclude=CVS linux_save/drivers/ide/pci/Makefile linux_mips/drivers/ide/pci/Makefile
--- linux_save/drivers/ide/pci/Makefile	2005-02-13 23:16:22.000000000 +0300
+++ linux_mips/drivers/ide/pci/Makefile	2005-05-31 17:58:08.000000000 +0400
@@ -27,6 +27,7 @@ obj-$(CONFIG_BLK_DEV_SLC90E66)		+= slc90
 obj-$(CONFIG_BLK_DEV_TRIFLEX)		+= triflex.o
 obj-$(CONFIG_BLK_DEV_TRM290)		+= trm290.o
 obj-$(CONFIG_BLK_DEV_VIA82CXXX)		+= via82cxxx.o
+obj-$(CONFIG_BLK_DEV_NEC_VR5701_SG2)	+= nec_vr5701_sg2.o
 
 # Must appear at the end of the block
 obj-$(CONFIG_BLK_DEV_GENERIC)          += generic.o
diff -Naurp --exclude=CVS linux_save/drivers/ide/pci/nec_vr5701_sg2.c linux_mips/drivers/ide/pci/nec_vr5701_sg2.c
--- linux_save/drivers/ide/pci/nec_vr5701_sg2.c	1970-01-01 03:00:00.000000000 +0300
+++ linux_mips/drivers/ide/pci/nec_vr5701_sg2.c	2005-05-31 17:58:08.000000000 +0400
@@ -0,0 +1,111 @@
+/*
+ * drivers/ide/pci/nec_vr5701_sg2.c
+ *
+ * NEC VR5701-SG2 IDE controller driver
+ *
+ * Author: Sergey Podstavin <spodstavin@ru.mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#include <linux/config.h>
+#include <linux/pci.h>
+#include <linux/ide.h>
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/timer.h>
+#include <linux/mm.h>
+#include <linux/ioport.h>
+#include <linux/blkdev.h>
+#include <linux/hdreg.h>
+#include <linux/pci.h>
+#include <linux/ide.h>
+#include <linux/init.h>
+#include <asm/io.h>
+
+static unsigned int __init init_chipset_nec_vr5701(struct pci_dev *dev,
+						   const char *name)
+{
+	return 0;
+}
+
+static void __init init_hwif_nec_vr5701(ide_hwif_t * hwif)
+{
+	if (!(hwif->dma_base))
+		return;
+
+	hwif->atapi_dma = 1;
+	hwif->ultra_mask = 0x7f;
+	hwif->mwdma_mask = 0x07;
+	hwif->swdma_mask = 0x07;
+
+	if (!noautodma)
+		hwif->autodma = 1;
+	hwif->drives[0].autodma = hwif->autodma;
+	hwif->drives[1].autodma = hwif->autodma;
+}
+
+static ide_pci_device_t nec_vr5701_chipset __devinitdata = {
+	.name = "NEC VR5701",
+	.init_chipset = init_chipset_nec_vr5701,
+	.init_hwif = init_hwif_nec_vr5701,
+	.channels = 2,
+	.autodma = AUTODMA,
+	.bootable = ON_BOARD,
+};
+
+static int __devinit nec_vr5701_init_one(struct pci_dev *dev,
+					 const struct pci_device_id *id)
+{
+	ide_pci_device_t *d = &nec_vr5701_chipset;
+	u16 command;
+
+	if (dev->vendor == PCI_VENDOR_ID_NEC &&
+	    dev->device == PCI_DEVICE_ID_NEC_USB_AND_IDE &&
+	    dev->class == 0x0c0310)
+		return 1;
+	udelay(100);
+	pci_enable_device(dev);
+	*(volatile unsigned char *)0xb9001010 = 6;
+	asm("sync");
+	udelay(100);
+
+	pci_read_config_word(dev, PCI_COMMAND, &command);
+	if (!(command & PCI_COMMAND_IO)) {
+		printk(KERN_INFO "Skipping disabled %s IDE controller.\n",
+		       d->name);
+		return 1;
+	}
+	ide_setup_pci_device(dev, d);
+	return 0;
+}
+
+static struct pci_device_id nec_vr5701_pci_tbl[] = {
+	{PCI_VENDOR_ID_NEC, PCI_DEVICE_ID_NEC_USB_AND_IDE, PCI_ANY_ID,
+	 PCI_ANY_ID, 0x010185, 0xffffff, 0},
+	{0,},
+};
+
+MODULE_DEVICE_TABLE(pci, nec_vr5701_pci_tbl);
+
+static struct pci_driver driver = {
+	.name = "nec_vr5701_IDE",
+	.id_table = nec_vr5701_pci_tbl,
+	.probe = nec_vr5701_init_one,
+};
+
+static int nec_vr5701_ide_init(void)
+{
+	return ide_pci_register_driver(&driver);
+}
+
+module_init(nec_vr5701_ide_init);
+
+MODULE_AUTHOR("Sergey Podstavin");
+MODULE_DESCRIPTION("PCI driver module for nec vr5701 IDE");
+MODULE_LICENSE("GPL");

--=-1QT6C8KMS2odChJmeBIX--
