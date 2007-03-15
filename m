Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Mar 2007 12:21:05 +0000 (GMT)
Received: from buzzloop.caiaq.de ([212.112.241.133]:56332 "EHLO
	buzzloop.caiaq.de") by ftp.linux-mips.org with ESMTP
	id S20021899AbXCOMVB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Mar 2007 12:21:01 +0000
Received: from localhost (localhost [127.0.0.1])
	by buzzloop.caiaq.de (Postfix) with ESMTP id DD6B17F402B
	for <linux-mips@linux-mips.org>; Thu, 15 Mar 2007 13:20:25 +0100 (CET)
Received: from buzzloop.caiaq.de ([127.0.0.1])
	by localhost (buzzloop [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 08680-03 for <linux-mips@linux-mips.org>;
	Thu, 15 Mar 2007 13:20:13 +0100 (CET)
Received: by buzzloop.caiaq.de (Postfix, from userid 1000)
	id D37857F4025; Thu, 15 Mar 2007 13:20:12 +0100 (CET)
Date:	Thu, 15 Mar 2007 13:20:12 +0100
From:	Daniel Mack <daniel@caiaq.de>
To:	linux-mips@linux-mips.org
Subject: [PATCH] IDE/DMA for au1xxx
Message-ID: <20070315122012.GA8612@ipxXXXXX>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at caiaq.de
Return-Path: <daniel@caiaq.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14479
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@caiaq.de
Precedence: bulk
X-list: linux-mips


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

this makes the DMA part of Au1xxx's IDE interface compile again.

Signed-of-by: Daniel Mack <daniel@caiaq.de>



--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="au1xxx-ide-dma.patch"

diff --git a/drivers/ide/mips/au1xxx-ide.c b/drivers/ide/mips/au1xxx-ide.c
index b2dc028..806b6d1 100644
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -443,7 +443,6 @@ static void auide_dma_host_on(ide_drive_t *drive)
 static int auide_dma_on(ide_drive_t *drive)
 {
 	drive->using_dma = 1;
-
 	return 0;
 }
 
@@ -638,6 +637,7 @@ static int au_ide_probe(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	_auide_hwif *ahwif = &auide_hwif;
 	ide_hwif_t *hwif;
+	hw_regs_t *hw;
 	struct resource *res;
 	int ret = 0;
 
@@ -681,7 +681,7 @@ static int au_ide_probe(struct device *dev)
 	/* FIXME:  This might possibly break PCMCIA IDE devices */
 
 	hwif                            = &ide_hwifs[pdev->id];
-	hw_regs_t *hw 			= &hwif->hw;
+	hw 				= &hwif->hw;
 	hwif->irq = hw->irq             = ahwif->irq;
 	hwif->chipset                   = ide_au1xxx;
 
diff --git a/include/asm-mips/mach-au1x00/au1xxx_ide.h b/include/asm-mips/mach-au1x00/au1xxx_ide.h
index e9fa252..e747814 100644
--- a/include/asm-mips/mach-au1x00/au1xxx_ide.h
+++ b/include/asm-mips/mach-au1x00/au1xxx_ide.h
@@ -166,13 +166,13 @@ int __init auide_probe(void);
         static int auide_dma_setup(ide_drive_t *drive);
         static int auide_dma_check(ide_drive_t *drive);
         static int auide_dma_test_irq(ide_drive_t *drive);
-        static int auide_dma_host_off(ide_drive_t *drive);
-        static int auide_dma_host_on(ide_drive_t *drive);
+        static void auide_dma_host_off(ide_drive_t *drive);
+        static void auide_dma_host_on(ide_drive_t *drive);
         static int auide_dma_lostirq(ide_drive_t *drive);
         static int auide_dma_on(ide_drive_t *drive);
         static void auide_ddma_tx_callback(int irq, void *param);
         static void auide_ddma_rx_callback(int irq, void *param);
-        static int auide_dma_off_quietly(ide_drive_t *drive);
+        static void auide_dma_off_quietly(ide_drive_t *drive);
 #endif /* end CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA */
 
 /*******************************************************************************

--+HP7ph2BbKc20aGI--
