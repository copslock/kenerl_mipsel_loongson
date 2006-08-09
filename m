Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Aug 2006 22:07:42 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:27066 "EHLO
	mail.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S20042657AbWHIVHl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 9 Aug 2006 22:07:41 +0100
Received: from zaigor.enneenne.com ([192.168.32.1])
	by mail.enneenne.com with esmtp (Exim 4.50)
	id 1GAuHn-0002dO-C8
	for linux-mips@linux-mips.org; Wed, 09 Aug 2006 22:04:15 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1GAvIB-0000lf-EO
	for linux-mips@linux-mips.org; Wed, 09 Aug 2006 23:08:43 +0200
Date:	Wed, 9 Aug 2006 23:08:43 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org
Message-ID: <20060809210843.GC13145@enneenne.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gatW/ieO32f1wygP"
Content-Disposition: inline
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: [PATCH] 2/7 AU1100 MMC support
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12258
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Protect code on "BCSR" device.

Signed-off-by: Rodolfo Giometti <giometti@linux.it>

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-mmc-de-bcsr

diff --git a/drivers/mmc/au1xmmc.c b/drivers/mmc/au1xmmc.c
index b0dc1d0..6084bb8 100644
--- a/drivers/mmc/au1xmmc.c
+++ b/drivers/mmc/au1xmmc.c
@@ -65,8 +65,8 @@ #endif
 const struct {
 	u32 iobase;
 	u32 tx_devid, rx_devid;
-	u16 bcsrpwr;
-	u16 bcsrstatus;
+	u16 power;
+	u16 status;
 	u16 wpstatus;
 } au1xmmc_card_table[] = {
 	{ SD0_BASE, DSCR_CMD0_SDMS_TX0, DSCR_CMD0_SDMS_RX0,
@@ -138,24 +138,42 @@ static inline void SEND_STOP(struct au1x
 static void au1xmmc_set_power(struct au1xmmc_host *host, int state)
 {
 
-	u32 val = au1xmmc_card_table[host->id].bcsrpwr;
+	u32 val;
 
+	val = au1xmmc_card_table[host->id].power;
+
+#if defined(CONFIG_MIPS_DB1200)
 	bcsr->board &= ~val;
 	if (state) bcsr->board |= val;
+#endif
 
 	au_sync_delay(1);
 }
 
 static inline int au1xmmc_card_inserted(struct au1xmmc_host *host)
 {
-	return (bcsr->sig_status & au1xmmc_card_table[host->id].bcsrstatus)
-		? 1 : 0;
+	u32 val, data = 1;
+
+	val = au1xmmc_card_table[host->id].status;
+
+#if defined(CONFIG_MIPS_DB1200)
+	data = bcsr->sig_status & val;
+#endif
+
+	return !!data;
 }
 
 static inline int au1xmmc_card_readonly(struct au1xmmc_host *host)
 {
-	return (bcsr->status & au1xmmc_card_table[host->id].wpstatus)
-		? 1 : 0;
+	u32 val, data = 0;
+
+	val = au1xmmc_card_table[host->id].wpstatus;
+
+#if defined(CONFIG_MIPS_DB1200)
+	data = bcsr->status & val;
+#endif
+
+	return !!data;
 }
 
 static void au1xmmc_finish_request(struct au1xmmc_host *host)
@@ -175,7 +193,9 @@ static void au1xmmc_finish_request(struc
 
 	host->status = HOST_S_IDLE;
 
+#if defined(CONFIG_MIPS_DB1200)
 	bcsr->disk_leds |= (1 << 8);
+#endif
 
 	mmc_request_done(host->mmc, mrq);
 }
@@ -670,7 +690,9 @@ static void au1xmmc_request(struct mmc_h
 	host->mrq = mrq;
 	host->status = HOST_S_CMD;
 
+#if defined(CONFIG_MIPS_DB1200)
 	bcsr->disk_leds &= ~(1 << 8);
+#endif
 
 	if (mrq->data) {
 		FLUSH_FIFO(host);

--gatW/ieO32f1wygP--
