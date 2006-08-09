Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Aug 2006 22:08:26 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:27834 "EHLO
	mail.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S20042657AbWHIVIZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 9 Aug 2006 22:08:25 +0100
Received: from zaigor.enneenne.com ([192.168.32.1])
	by mail.enneenne.com with esmtp (Exim 4.50)
	id 1GAuIV-0002dT-69
	for linux-mips@linux-mips.org; Wed, 09 Aug 2006 22:04:59 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1GAvIt-0000lo-8k
	for linux-mips@linux-mips.org; Wed, 09 Aug 2006 23:09:27 +0200
Date:	Wed, 9 Aug 2006 23:09:27 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org
Message-ID: <20060809210927.GD13145@enneenne.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Y5rl02BVI9TCfPar"
Content-Disposition: inline
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: [PATCH] 3/7 AU1100 MMC support
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12259
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Kernel messages fixup.

Signed-off-by: Rodolfo Giometti <giometti@linux.it>

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-mmc-kmsg-fix

diff --git a/drivers/mmc/au1xmmc.c b/drivers/mmc/au1xmmc.c
index 6084bb8..560d6e3 100644
--- a/drivers/mmc/au1xmmc.c
+++ b/drivers/mmc/au1xmmc.c
@@ -54,13 +54,16 @@ #include "au1xmmc.h"
 
 #define DRIVER_NAME "au1xxx-mmc"
 
-/* Set this to enable special debugging macros */
-
-#ifdef DEBUG
-#define DBG(fmt, idx, args...) printk("au1xx(%d): DEBUG: " fmt, idx, ##args)
+#ifdef CONFIG_MMC_DEBUG
+#define dbg(fmt, idx, args...) printk(KERN_DEBUG "%s(%d): DEBUG: " \
+					fmt, DRIVER_NAME, idx, ##args)
 #else
-#define DBG(fmt, idx, args...)
+#define dbg(fmt, idx, args...)
 #endif
+#define err(fmt, idx, args...) printk(KERN_DEBUG "%s(%d): ERROR: " \
+					fmt, DRIVER_NAME, idx, ##args)
+#define info(fmt, idx, args...) printk(KERN_INFO "%s(%d): " \
+					fmt, DRIVER_NAME, idx, ##args)
 
 const struct {
 	u32 iobase;
@@ -445,18 +448,18 @@ static void au1xmmc_receive_pio(struct a
 			break;
 
 		if (status & SD_STATUS_RC) {
-			DBG("RX CRC Error [%d + %d].\n", host->id,
+			dbg("RX CRC Error [%d + %d].\n", host->id,
 					host->pio.len, count);
 			break;
 		}
 
 		if (status & SD_STATUS_RO) {
-			DBG("RX Overrun [%d + %d]\n", host->id,
+			dbg("RX Overrun [%d + %d]\n", host->id,
 					host->pio.len, count);
 			break;
 		}
 		else if (status & SD_STATUS_RU) {
-			DBG("RX Underrun [%d + %d]\n", host->id,
+			dbg("RX Underrun [%d + %d]\n", host->id,
 					host->pio.len,	count);
 			break;
 		}
@@ -829,7 +832,7 @@ #endif
 				au1xmmc_receive_pio(host);
 		}
 		else if (status & 0x203FBC70) {
-			DBG("Unhandled status %8.8x\n", host->id, status);
+			dbg("Unhandled status %8.8x\n", host->id, status);
 			handled = 0;
 		}
 
@@ -856,10 +859,8 @@ static void au1xmmc_poll_event(unsigned 
 		mmc_detect_change(host->mmc, 0);
 	}
 
-	if (host->mrq != NULL) {
-		u32 status = au_readl(HOST_STATUS(host));
-		DBG("PENDING - %8.8x\n", host->id, status);
-	}
+	if (host->mrq != NULL)
+		dbg("PENDING - %8.8x\n", host->id, au_readl(HOST_STATUS(host)));
 
 	mod_timer(&host->timer, jiffies + AU1XMMC_DETECT_TIMEOUT);
 }
@@ -914,7 +915,7 @@ static int __devinit au1xmmc_probe(struc
 	ret = request_irq(AU1100_SD_IRQ, au1xmmc_irq, IRQF_DISABLED, "MMC", 0);
 
 	if (ret) {
-		printk(DRIVER_NAME "ERROR: Couldn't get int %d: %d\n",
+		err("ERROR: Couldn't get int %d: %d\n",
 				AU1100_SD_IRQ, ret);
 		return -ENXIO;
 	}
@@ -926,7 +927,7 @@ static int __devinit au1xmmc_probe(struc
 		struct au1xmmc_host *host = 0;
 
 		if (!mmc) {
-			printk(DRIVER_NAME "ERROR: no mem for host %d\n", i);
+			err("ERROR: no mem for host %d\n", i);
 			au1xmmc_hosts[i] = 0;
 			continue;
 		}
@@ -976,7 +977,7 @@ static int __devinit au1xmmc_probe(struc
 
 		add_timer(&host->timer);
 
-		printk(KERN_INFO DRIVER_NAME ": MMC Controller %d set up at %8.8X (mode=%s)\n",
+		info("MMC Controller %d set up at %x (mode=%s)\n",
 		       host->id, host->iobase, dma ? "dma" : "pio");
 	}
 

--Y5rl02BVI9TCfPar--
