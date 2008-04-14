Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Apr 2008 18:08:14 +0100 (BST)
Received: from rtsoft3.corbina.net ([85.21.88.6]:45107 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S20022494AbYDNRIM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 Apr 2008 18:08:12 +0100
Received: from wasted.dev.rtsoft.ru (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id 461298810; Mon, 14 Apr 2008 22:08:08 +0500 (SAMST)
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
To:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org
Subject: [PATCH] Pb1200/DBAu1200: IDE resource size off by one
Date:	Mon, 14 Apr 2008 21:07:30 +0400
User-Agent: KMail/1.5
Cc:	ralf@linux-mips.org, bzolnier@gmail.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200804142107.30799.sshtylyov@ru.mvista.com>
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18918
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

The IDE platform device on Pb1200/DBAu1200 boards claims one byte too many for
its memory resource -- fix the platform code and the IDE driver in accordance.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
I'm not sure thru which tree this should go -- probably thru Linux/MIPS one...

 arch/mips/au1000/common/platform.c |    2 +-
 drivers/ide/mips/au1xxx-ide.c      |    7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

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
