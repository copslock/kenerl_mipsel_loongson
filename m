Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Feb 2006 18:10:18 +0000 (GMT)
Received: from amdext4.amd.com ([163.181.251.6]:13978 "EHLO amdext4.amd.com")
	by ftp.linux-mips.org with ESMTP id S8133472AbWBJSKG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 10 Feb 2006 18:10:06 +0000
Received: from SAUSGW02.amd.com (sausgw02.amd.com [163.181.250.22])
	by amdext4.amd.com (8.12.11/8.12.11/AMD) with ESMTP id k1AIFx7W021270;
	Fri, 10 Feb 2006 12:15:59 -0600
Received: from 163.181.22.101 by SAUSGW01.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Fri, 10 Feb 2006 12:15:53 -0600
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
Received: from ldcmail.amd.com ([147.5.200.40]) by sausexbh1.amd.com
 with Microsoft SMTPSVC(6.0.3790.0); Fri, 10 Feb 2006 10:15:52 -0800
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id 7F1082028; Fri, 10 Feb 2006
 11:15:52 -0700 (MST)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id k1AIKYkR027535; Fri, 10 Feb 2006 11:20:34
 -0700
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id k1AIKXkC027534; Fri, 10 Feb 2006 11:20:33
 -0700
Date:	Fri, 10 Feb 2006 11:20:33 -0700
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org
cc:	enrico.walther@amd.com
Subject: [PATCH] Enable MwDMA for AU1200 IDE driver
Message-ID: <20060210182033.GA24353@cosmic.amd.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 10 Feb 2006 18:15:52.0938 (UTC)
 FILETIME=[073D5CA0:01C62E6E]
X-WSS-ID: 6FF207D30MS4470519-01-01
Content-Type: multipart/mixed;
 boundary=dDRMvlgZJXvWKvBx
Content-Disposition: inline
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10396
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips


--dDRMvlgZJXvWKvBx
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Greetings all - the attached patch enables MwDMA mode for the AU1200
IDE driver.  If one heavily uses the USB on the DB1200 board with IDE
in PIO mode, you may experience hangs from overloading the bus with
interrupts - this should help.  Since it is obvious that this is the
desired mode, I'm adding it to the defconfig to enable by default.

Also, I snuck in a fix for a warning (mixed code and declarations = evil!).
Applies against latest lmo git, but it should work for linux-ide as well.

Regards,
Jordan
-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>

--dDRMvlgZJXvWKvBx
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline;
 filename=auide-fixes.patch
Content-Transfer-Encoding: 7bit

[PATCH] Enable MWDMA mode for the AU1200 IDE driver

This enables MwDMA mode for the AU1200 driver - this will benefit
anybody using IDE + USB, which together seem to cause hangs when IDE is 
in PIO due to the large number of interrupts on the same bus.

Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
---

 arch/mips/configs/db1200_defconfig        |    4 ++--
 drivers/ide/mips/au1xxx-ide.c             |   14 ++++++++++++--
 include/asm-mips/mach-au1x00/au1xxx_ide.h |    9 ---------
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/mips/configs/db1200_defconfig b/arch/mips/configs/db1200_defconfig
index 9288847..355b32f 100644
--- a/arch/mips/configs/db1200_defconfig
+++ b/arch/mips/configs/db1200_defconfig
@@ -497,8 +497,8 @@ CONFIG_BLK_DEV_IDECS=m
 #
 CONFIG_IDE_GENERIC=y
 CONFIG_BLK_DEV_IDE_AU1XXX=y
-CONFIG_BLK_DEV_IDE_AU1XXX_PIO_DBDMA=y
-# CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA is not set
+#CONFIG_BLK_DEV_IDE_AU1XXX_PIO_DBDMA is not set
+CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA=y
 CONFIG_BLK_DEV_IDE_AU1XXX_SEQTS_PER_RQ=128
 # CONFIG_IDE_ARM is not set
 # CONFIG_BLK_DEV_IDEDMA is not set
diff --git a/drivers/ide/mips/au1xxx-ide.c b/drivers/ide/mips/au1xxx-ide.c
index 32431dc..c2bf766 100644
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -652,6 +652,7 @@ static int au_ide_probe(struct device *d
 	struct platform_device *pdev = to_platform_device(dev);
 	_auide_hwif *ahwif = &auide_hwif;
 	ide_hwif_t *hwif;
+	hw_regs_t *hw;
 	struct resource *res;
 	int ret = 0;
 
@@ -690,17 +691,26 @@ static int au_ide_probe(struct device *d
 	/* FIXME:  This might possibly break PCMCIA IDE devices */
 
 	hwif                            = &ide_hwifs[pdev->id];
-	hw_regs_t *hw 			= &hwif->hw;
+	hw				= &hwif->hw;
 	hwif->irq = hw->irq             = ahwif->irq;
 	hwif->chipset                   = ide_au1xxx;
 
 	auide_setup_ports(hw, ahwif);
 	memcpy(hwif->io_ports, hw->io_ports, sizeof(hwif->io_ports));
 
+#ifdef CONFIG_BLK_DEV_IDE_AU1XXX_SEQTS_PER_RQ
+	hwif->rqsize = CONFIG_BLK_DEV_IDE_AU1XXX_SEQTS_PER_RQ;
+	hwif->rqsize = ((hwif->rqsize > AU1XXX_ATA_RQSIZE)
+			|| (hwif->rqsize < 32)) 
+                        ? AU1XXX_ATA_RQSIZE : hwif->rqsize;
+#else /* if kernel config is not set */
+	hwif->rqsize                    = AU1XXX_ATA_RQSIZE;
+#endif
+			
 	hwif->ultra_mask                = 0x0;  /* Disable Ultra DMA */
 #ifdef CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA
 	hwif->mwdma_mask                = 0x07; /* Multimode-2 DMA  */
-	hwif->swdma_mask                = 0x00;
+	hwif->swdma_mask                = 0x07;
 #else
 	hwif->mwdma_mask                = 0x0;
 	hwif->swdma_mask                = 0x0;
diff --git a/include/asm-mips/mach-au1x00/au1xxx_ide.h b/include/asm-mips/mach-au1x00/au1xxx_ide.h
index 5dab100..b9713c3 100644
--- a/include/asm-mips/mach-au1x00/au1xxx_ide.h
+++ b/include/asm-mips/mach-au1x00/au1xxx_ide.h
@@ -42,11 +42,6 @@
         #define AU1XXX_ATA_RQSIZE       128
 #endif
 
-/* Disable Burstable-Support for DBDMA */
-#ifndef CONFIG_BLK_DEV_IDE_AU1XXX_BURSTABLE_ON
-        #define CONFIG_BLK_DEV_IDE_AU1XXX_BURSTABLE_ON  0
-#endif
-
 typedef struct
 {
         u32                     tx_dev_id, rx_dev_id, target_dev_id;
@@ -65,10 +60,6 @@ typedef struct
 } _auide_hwif;
 
 #ifdef CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA
-struct drive_list_entry {
-	const char *id_model;
-	const char *id_firmware;
-};
 
 /* HD white list */
 static const struct drive_list_entry dma_white_list [] = {

--dDRMvlgZJXvWKvBx--
