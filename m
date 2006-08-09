Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Aug 2006 22:11:43 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:30906 "EHLO
	mail.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S20042657AbWHIVLl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 9 Aug 2006 22:11:41 +0100
Received: from zaigor.enneenne.com ([192.168.32.1])
	by mail.enneenne.com with esmtp (Exim 4.50)
	id 1GAuLf-0002dn-88
	for linux-mips@linux-mips.org; Wed, 09 Aug 2006 22:08:15 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1GAvM3-0000mK-BU
	for linux-mips@linux-mips.org; Wed, 09 Aug 2006 23:12:43 +0200
Date:	Wed, 9 Aug 2006 23:12:43 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org
Message-ID: <20060809211243.GH13145@enneenne.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="qoTlaiD+Y2fIM3Ll"
Content-Disposition: inline
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: [PATCH] 7/7 AU1100 MMC support
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12263
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--qoTlaiD+Y2fIM3Ll
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Power Management support for AU1100 (PIO mode) added.

Signed-off-by: Rodolfo Giometti <giometti@linux.it>

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--qoTlaiD+Y2fIM3Ll
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-mmc-pm-au1100

diff --git a/drivers/mmc/au1xmmc.c b/drivers/mmc/au1xmmc.c
index 61acf6b..920486d 100644
--- a/drivers/mmc/au1xmmc.c
+++ b/drivers/mmc/au1xmmc.c
@@ -19,6 +19,10 @@
  *     Rodolfo Giometti <giometti@linux.it>
  *     Eurotech S.p.A. <info@eurotech.it>
 
+ *  Power Management Support for AU1100 in PIO mode by:
+ *     Rodolfo Giometti <giometti@linux.it>
+ *     Eurotech S.p.A. <info@eurotech.it>
+
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -1086,11 +1090,79 @@ #endif
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static u32 sd_txport[2];
+static u32 sd_rxport[2];
+static u32 sd_config[2];
+static u32 sd_config2[2];
+static u32 sd_blksize[2];
+static u32 sd_status[2];
+static u32 sd_cmd[2];
+static u32 sd_cmdarg[2];
+static u32 sd_timeout[2];
+
+static int au1xmmc_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct au1xmmc_host *host = platform_get_drvdata(pdev);
+	struct mmc_host *mmc = host->mmc;
+	int ret = 0;
+
+printk("GU au1xmmc_suspend %d\n", host->id);
+	if (mmc)
+		ret = mmc_suspend_host(mmc, state);
+
+	sd_txport[host->id]  = au_readl(HOST_TXPORT(host));
+	sd_rxport[host->id]  = au_readl(HOST_RXPORT(host));
+	sd_config[host->id]  = au_readl(HOST_CONFIG(host));
+	sd_config2[host->id] = au_readl(HOST_CONFIG2(host));
+	sd_blksize[host->id] = au_readl(HOST_BLKSIZE(host));
+	sd_status[host->id]  = au_readl(HOST_STATUS(host));
+	sd_cmd[host->id]     = au_readl(HOST_CMD(host));
+	sd_cmdarg[host->id]  = au_readl(HOST_CMDARG(host));
+	sd_timeout[host->id] = au_readl(HOST_TIMEOUT(host));
+
+	au_writel(0x0, HOST_ENABLE(host));
+
+printk("GU au1xmmc_suspend END\n");
+	return ret;
+}
+
+static int au1xmmc_resume(struct platform_device *pdev)
+{
+	struct au1xmmc_host *host = platform_get_drvdata(pdev);
+	struct mmc_host *mmc = host->mmc;
+	int ret = 0;
+
+	au1xmmc_reset_controller(host);
+
+	au_writel(sd_txport[host->id],  HOST_TXPORT(host));
+	au_writel(sd_rxport[host->id],  HOST_RXPORT(host));
+	au_writel(sd_config[host->id],  HOST_CONFIG(host));
+	au_writel(sd_config2[host->id], HOST_CONFIG2(host));
+	au_writel(sd_blksize[host->id], HOST_BLKSIZE(host));
+	au_writel(sd_status[host->id],  HOST_STATUS(host));
+	au_writel(sd_cmd[host->id],     HOST_CMD(host));
+	au_writel(sd_cmdarg[host->id],  HOST_CMDARG(host));
+	au_writel(sd_timeout[host->id], HOST_TIMEOUT(host));
+
+printk("GU au1xmmc_resume\n");
+	if (mmc)
+		ret = mmc_resume_host(mmc);
+
+printk("GU au1xmmc_resume END\n");
+	return ret;
+}
+
+#else
+#define au1xmmc_suspend  NULL
+#define au1xmmc_resume   NULL
+#endif
+
 static struct platform_driver au1xmmc_driver = {
 	.probe         = au1xmmc_probe,
 	.remove        = au1xmmc_remove,
-	.suspend       = NULL,
-	.resume        = NULL,
+	.suspend       = au1xmmc_suspend,
+	.resume        = au1xmmc_resume,
 	.driver        = {
 		.name  = DRIVER_NAME,
 	},

--qoTlaiD+Y2fIM3Ll--
