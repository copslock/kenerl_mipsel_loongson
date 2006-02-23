Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2006 15:34:11 +0000 (GMT)
Received: from rtsoft3.corbina.net ([85.21.88.6]:54592 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S8133515AbWBWPcw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Feb 2006 15:32:52 +0000
Received: from 192.168.1.104 ([10.150.0.9])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id k1NFdmt16463
	for <linux-mips@linux-mips.org>; Thu, 23 Feb 2006 19:39:48 +0400
Subject: NEC VR5701 support
From:	Sergey Podstavin <spodstavin@ru.mvista.com>
Reply-To: spodstavin@ru.mvista.com
To:	linux-mips <linux-mips@linux-mips.org>
Content-Type: multipart/mixed; boundary="=-ifWZKKWfjRQxfq5VvapC"
Organization: MontaVista
Date:	Thu, 23 Feb 2006 18:39:48 +0300
Message-Id: <1140709188.5741.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Return-Path: <spodstavin@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10619
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: spodstavin@ru.mvista.com
Precedence: bulk
X-list: linux-mips


--=-ifWZKKWfjRQxfq5VvapC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-ifWZKKWfjRQxfq5VvapC
Content-Disposition: attachment; filename=pro_mips_nec_vr5701_ide_udma_fix.patch
Content-Type: text/x-patch; name=pro_mips_nec_vr5701_ide_udma_fix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Source: MontaVista Software, Inc.
MR: 15910
Type: Defect Fix
Disposition: needs submitting to linuxmips-embedded mailing list
Signed-off-by: Aleskey Makarov <makarov@ru.mvista.com>
Description:
	This patch adds the code that changes 
	dma mode of the IPCI IDE controller.

Index: linux-2.6.10/drivers/ide/pci/nec_vr5701_sg2.c
===================================================================
--- linux-2.6.10.orig/drivers/ide/pci/nec_vr5701_sg2.c
+++ linux-2.6.10/drivers/ide/pci/nec_vr5701_sg2.c
@@ -34,6 +34,105 @@ static unsigned int __init init_chipset_
 	return 0;
 }
 
+static u8 nec_vr5701_ratemask(ide_drive_t * drive)
+{
+	u8 mode = 2;
+	if (!eighty_ninty_three(drive))
+		mode = min(mode, (u8)1);
+	return mode;
+}
+
+static void udma_set(ide_drive_t * drive, u16 udma_mode)
+{
+
+	ide_hwif_t * hwif = HWIF(drive);
+	struct pci_dev * dev = hwif->pci_dev;
+
+	u8 reg4b; /* udma control register */
+	u16 reg4c; /* udma timing register */
+
+	pci_read_config_word(dev, 0x4c, &reg4c);
+	reg4c &= ~(7 << (drive->dn * 4));
+	reg4c |= udma_mode << (drive->dn * 4);
+	pci_write_config_word(dev, 0x4c, reg4c);
+
+	pci_read_config_byte(dev, 0x4b, &reg4b);
+	reg4b |= 1 << drive->dn;
+	pci_write_config_byte(dev, 0x4b, reg4b);
+}
+
+static void udma_clean(ide_drive_t * drive)
+{
+
+	ide_hwif_t * hwif = HWIF(drive);
+	struct pci_dev * dev = hwif->pci_dev;
+
+	u8 reg4b; /* udma control register */
+
+	pci_read_config_byte(dev, 0x4b, &reg4b);
+	reg4b &= ~(1 << drive->dn);
+	pci_write_config_byte(dev, 0x4b, reg4b);
+}
+
+static void dma_set(ide_drive_t * drive, u32 dma_mode)
+{
+
+	ide_hwif_t * hwif = HWIF(drive);
+	struct pci_dev * dev = hwif->pci_dev;
+
+	u32 reg44; /* dma timing register */
+
+	udma_clean(drive);
+
+	pci_read_config_dword(dev, 0x44, &reg44);
+	reg44 &= ~(3 << (8 * drive->dn));
+	reg44 |= dma_mode << (8 * drive->dn);
+	pci_write_config_dword(dev, 0x44, reg44);
+}
+
+static int nec_vr5701_tune_chipset (ide_drive_t *drive, u8 xferspeed)
+{
+	u8 speed = ide_rate_filter(nec_vr5701_ratemask(drive), xferspeed);
+
+	switch(speed) {
+		case XFER_UDMA_4:
+			udma_set(drive, 4);
+			break;
+		case XFER_UDMA_3:
+			udma_set(drive, 3);
+			break;
+		case XFER_UDMA_2:
+			udma_set(drive, 2);
+			break;
+		case XFER_UDMA_1:
+			udma_set(drive, 1);
+			break;
+		case XFER_UDMA_0:
+			udma_set(drive, 0);
+			break;
+		case XFER_MW_DMA_2:
+			dma_set(drive, 2);
+			break;
+		case XFER_MW_DMA_1:
+			dma_set(drive, 1);
+			break;
+		case XFER_MW_DMA_0:
+			dma_set(drive, 0);
+			break;
+		case XFER_PIO_4:
+		case XFER_PIO_3:
+		case XFER_PIO_2:
+		case XFER_PIO_1:
+		case XFER_PIO_0:
+			udma_clean(drive);
+			break;
+		default:
+			return -1;
+	}
+
+	return (ide_config_drive_speed(drive, speed));
+}
+
 static void __init init_hwif_nec_vr5701(ide_hwif_t * hwif)
 {
 	if (!(hwif->dma_base))
@@ -44,6 +143,8 @@ static void __init init_hwif_nec_vr5701(
 	hwif->mwdma_mask = 0x07;
 	hwif->swdma_mask = 0x07;
 
+	hwif->speedproc = &nec_vr5701_tune_chipset;
+
 	{
 		struct pci_dev * pci_dev = hwif->pci_dev;
 		hwif->io_ports[IDE_CONTROL_OFFSET]
Index: linux-2.6.10/include/linux/lsppatchlevel.h
===================================================================
--- linux-2.6.10.orig/include/linux/lsppatchlevel.h
+++ linux-2.6.10/include/linux/lsppatchlevel.h
@@ -6,4 +6,4 @@
  * is licensed "as is" without any warranty of any kind, whether express
  * or implied.
  */
-#define LSP_PATCH_LEVEL "7"
+#define LSP_PATCH_LEVEL "8"
Index: linux-2.6.10/mvl_patches/pro-0008.c
===================================================================
--- /dev/null
+++ linux-2.6.10/mvl_patches/pro-0008.c
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
+        return mvl_register_patch(8);
+}
+module_init(regpatch);

--=-ifWZKKWfjRQxfq5VvapC--
