Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jul 2008 12:07:39 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:14269 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S28584408AbYGQLHh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 17 Jul 2008 12:07:37 +0100
Received: (qmail 15098 invoked by uid 1000); 17 Jul 2008 13:07:28 +0200
Date:	Thu, 17 Jul 2008 13:07:28 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	drzeus@drzeus.cx
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] au1xmmc: suspend/resume implementation
Message-ID: <20080717110728.GA15081@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19875
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

From: Manuel Lauss <mano@roarinelk.homelinux.net>

Basic suspend/resume support: disable peripheral on suspend and
reinit on resume.

Tested on Au1200.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 drivers/mmc/host/au1xmmc.c |   54 ++++++++++++++++++++++++++++++++++---------
 1 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
index 3f15eb2..99b2091 100644
--- a/drivers/mmc/host/au1xmmc.c
+++ b/drivers/mmc/host/au1xmmc.c
@@ -1043,7 +1043,7 @@ static int __devinit au1xmmc_probe(struct platform_device *pdev)
 		goto out6;
 	}
 
-	platform_set_drvdata(pdev, mmc);
+	platform_set_drvdata(pdev, host);
 
 	printk(KERN_INFO DRIVER_NAME ": MMC Controller %d set up at %8.8X"
 		" (mode=%s)\n", pdev->id, host->iobase,
@@ -1087,13 +1087,10 @@ out0:
 
 static int __devexit au1xmmc_remove(struct platform_device *pdev)
 {
-	struct mmc_host *mmc = platform_get_drvdata(pdev);
-	struct au1xmmc_host *host;
-
-	if (mmc) {
-		host  = mmc_priv(mmc);
+	struct au1xmmc_host *host = platform_get_drvdata(pdev);
 
-		mmc_remove_host(mmc);
+	if (host) {
+		mmc_remove_host(host->mmc);
 
 #ifdef CONFIG_LEDS_CLASS
 		if (host->platdata && host->platdata->led)
@@ -1101,8 +1098,8 @@ static int __devexit au1xmmc_remove(struct platform_device *pdev)
 #endif
 
 		if (host->platdata && host->platdata->cd_setup &&
-		    !(mmc->caps & MMC_CAP_NEEDS_POLL))
-			host->platdata->cd_setup(mmc, 0);
+		    !(host->mmc->caps & MMC_CAP_NEEDS_POLL))
+			host->platdata->cd_setup(host->mmc, 0);
 
 		au_writel(0, HOST_ENABLE(host));
 		au_writel(0, HOST_CONFIG(host));
@@ -1122,16 +1119,49 @@ static int __devexit au1xmmc_remove(struct platform_device *pdev)
 		release_resource(host->ioarea);
 		kfree(host->ioarea);
 
-		mmc_free_host(mmc);
+		mmc_free_host(host->mmc);
+		platform_set_drvdata(pdev, NULL);
 	}
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int au1xmmc_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct au1xmmc_host *host = platform_get_drvdata(pdev);
+	int ret;
+
+	ret = mmc_suspend_host(host->mmc, state);
+	if (ret)
+		return ret;
+
+	au_writel(0, HOST_CONFIG2(host));
+	au_writel(0, HOST_CONFIG(host));
+	au_writel(0xffffffff, HOST_STATUS(host));
+	au_writel(0, HOST_ENABLE(host));
+	au_sync();
+
+	return 0;
+}
+
+static int au1xmmc_resume(struct platform_device *pdev)
+{
+	struct au1xmmc_host *host = platform_get_drvdata(pdev);
+
+	au1xmmc_reset_controller(host);
+
+	return mmc_resume_host(host->mmc);
+}
+#else
+#define au1xmmc_suspend NULL
+#define au1xmmc_resume NULL
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
 		.owner = THIS_MODULE,
-- 
1.5.6.2
