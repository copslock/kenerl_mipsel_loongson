Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Aug 2006 22:10:00 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:29370 "EHLO
	mail.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S20042657AbWHIVJ6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 9 Aug 2006 22:09:58 +0100
Received: from zaigor.enneenne.com ([192.168.32.1])
	by mail.enneenne.com with esmtp (Exim 4.50)
	id 1GAuK0-0002dd-8b
	for linux-mips@linux-mips.org; Wed, 09 Aug 2006 22:06:32 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1GAvKO-0000m4-BP
	for linux-mips@linux-mips.org; Wed, 09 Aug 2006 23:11:00 +0200
Date:	Wed, 9 Aug 2006 23:11:00 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org
Message-ID: <20060809211100.GF13145@enneenne.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nHwqXXcoX0o6fKCv"
Content-Disposition: inline
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: [PATCH] 5/7 AU1100 MMC support
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12261
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--nHwqXXcoX0o6fKCv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Interrupt management fix up.

Signed-off-by: Rodolfo Giometti <giometti@linux.it>

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--nHwqXXcoX0o6fKCv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-mmc-irq-fix

diff --git a/drivers/mmc/au1xmmc.c b/drivers/mmc/au1xmmc.c
index 10e8e06..f2d44cd 100644
--- a/drivers/mmc/au1xmmc.c
+++ b/drivers/mmc/au1xmmc.c
@@ -772,11 +772,7 @@ static irqreturn_t au1xmmc_irq(int irq, 
 {
 	struct au1xmmc_host *host = dev_id;
 	u32 status;
-	int i, ret = 0;
-
-	disable_irq(AU1100_SD_IRQ);
-
-	u32 handled = 1;
+	int ret = IRQ_HANDLED;
 
 	status = au_readl(HOST_STATUS(host));
 
@@ -821,15 +817,12 @@ #endif
 	}
 	else if (status & 0x203FBC70) {
 		dbg("Unhandled status %8.8x\n", host->id, status);
-		handled = 0;
+		ret = IRQ_NONE;
 	}
 
 	au_writel(status, HOST_STATUS(host));
 	au_sync();
 
-	ret |= handled;
-
-	enable_irq(AU1100_SD_IRQ);
 	return ret;
 }
 
@@ -987,7 +980,6 @@ static int __devinit au1xmmc_probe(struc
 	info("MMC controller set up at %x irq %d (mode=%s)\n",
 		host->id, base_addr_phys, host->irq, dma ? "dma" : "pio");
 
-	enable_irq(AU1100_SD_IRQ);
 	platform_set_drvdata(pdev, host);
 
 	return 0;
@@ -1021,8 +1013,6 @@ static int __devexit au1xmmc_remove(stru
 	if (!host)
 		return 0;
 
-	disable_irq(AU1100_SD_IRQ);
-
 	tasklet_kill(&host->data_task);
 	tasklet_kill(&host->finish_task);
 

--nHwqXXcoX0o6fKCv--
