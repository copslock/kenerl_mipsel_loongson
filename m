Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Apr 2008 17:45:16 +0100 (BST)
Received: from rtsoft3.corbina.net ([85.21.88.6]:18438 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S28574922AbYDOQpN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 15 Apr 2008 17:45:13 +0100
Received: from wasted.dev.rtsoft.ru (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id 6F1BC8814; Tue, 15 Apr 2008 21:45:11 +0500 (SAMST)
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
To:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org
Subject: [PATCH] Pb1200/DBAu1200: fix bad IDE resource size
Date:	Tue, 15 Apr 2008 20:44:32 +0400
User-Agent: KMail/1.5
Cc:	ralf@linux-mips.org, bzolnier@gmail.com
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200804152044.32912.sshtylyov@ru.mvista.com>
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18924
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

The header files for the Pb1200/DBAu1200 boards have wrong definition for the
IDE interface's  decoded range length -- it should be 512 bytes according to
what the IDE driver does.  In addition, the IDE platform device claims 1 byte
too many for its memory resource -- fix the platform code and the IDE driver
in accordance.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
I'm not sure thru which tree this should go -- probably thru Linux/MIPS one...

 arch/mips/au1000/common/platform.c    |    2 +-
 drivers/ide/mips/au1xxx-ide.c         |    7 ++++---
 include/asm-mips/mach-db1x00/db1200.h |    4 ++--
 include/asm-mips/mach-pb1x00/pb1200.h |    4 ++--
 4 files changed, 9 insertions(+), 8 deletions(-)

Index: linux-2.6/arch/mips/au1000/common/platform.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/platform.c
+++ linux-2.6/arch/mips/au1000/common/platform.c
@@ -189,7 +189,7 @@ static struct resource au1200_lcd_resour
 static struct resource au1200_ide0_resources[] = {
 	[0] = {
 		.start		= AU1XXX_ATA_PHYS_ADDR,
-		.end 		= AU1XXX_ATA_PHYS_ADDR + AU1XXX_ATA_PHYS_LEN,
+		.end 		= AU1XXX_ATA_PHYS_ADDR + AU1XXX_ATA_PHYS_LEN - 1,
 		.flags		= IORESOURCE_MEM,
 	},
 	[1] = {
Index: linux-2.6/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/mips/au1xxx-ide.c
+++ linux-2.6/drivers/ide/mips/au1xxx-ide.c
@@ -591,13 +591,14 @@ static int au_ide_probe(struct device *d
 		goto out;
 	}
 
-	if (!request_mem_region (res->start, res->end-res->start, pdev->name)) {
+	if (!request_mem_region(res->start, res->end - res->start + 1,
+				pdev->name)) {
 		pr_debug("%s: request_mem_region failed\n", DRV_NAME);
 		ret =  -EBUSY;
 		goto out;
 	}
 
-	ahwif->regbase = (u32)ioremap(res->start, res->end-res->start);
+	ahwif->regbase = (u32)ioremap(res->start, res->end - res->start + 1);
 	if (ahwif->regbase == 0) {
 		ret = -ENOMEM;
 		goto out;
@@ -682,7 +683,7 @@ static int au_ide_remove(struct device *
 	iounmap((void *)ahwif->regbase);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(res->start, res->end - res->start);
+	release_mem_region(res->start, res->end - res->start + 1);
 
 	return 0;
 }
Index: linux-2.6/include/asm-mips/mach-db1x00/db1200.h
===================================================================
--- linux-2.6.orig/include/asm-mips/mach-db1x00/db1200.h
+++ linux-2.6/include/asm-mips/mach-db1x00/db1200.h
@@ -173,8 +173,8 @@ static BCSR * const bcsr = (BCSR *)BCSR_
 #define AU1XXX_SMC91111_IRQ			DB1200_ETH_INT
 
 #define AU1XXX_ATA_PHYS_ADDR		(0x18800000)
-#define AU1XXX_ATA_PHYS_LEN			(0x100)
-#define AU1XXX_ATA_REG_OFFSET	(5)
+#define AU1XXX_ATA_REG_OFFSET		(5)
+#define AU1XXX_ATA_PHYS_LEN		(16 << AU1XXX_ATA_REG_OFFSET)
 #define AU1XXX_ATA_INT			DB1200_IDE_INT
 #define AU1XXX_ATA_DDMA_REQ		DSCR_CMD0_DMA_REQ1;
 #define AU1XXX_ATA_RQSIZE		128
Index: linux-2.6/include/asm-mips/mach-pb1x00/pb1200.h
===================================================================
--- linux-2.6.orig/include/asm-mips/mach-pb1x00/pb1200.h
+++ linux-2.6/include/asm-mips/mach-pb1x00/pb1200.h
@@ -186,8 +186,8 @@ static BCSR * const bcsr = (BCSR *)BCSR_
 #define AU1XXX_SMC91111_IRQ			PB1200_ETH_INT
 
 #define AU1XXX_ATA_PHYS_ADDR		(0x0C800000)
-#define AU1XXX_ATA_PHYS_LEN			(0x100)
-#define AU1XXX_ATA_REG_OFFSET	(5)
+#define AU1XXX_ATA_REG_OFFSET		(5)
+#define AU1XXX_ATA_PHYS_LEN		(16 << AU1XXX_ATA_REG_OFFSET)
 #define AU1XXX_ATA_INT			PB1200_IDE_INT
 #define AU1XXX_ATA_DDMA_REQ		DSCR_CMD0_DMA_REQ1;
 #define AU1XXX_ATA_RQSIZE		128
