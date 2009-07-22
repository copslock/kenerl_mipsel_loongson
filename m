Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Jul 2009 17:18:58 +0200 (CEST)
Received: from mail-fx0-f220.google.com ([209.85.220.220]:34180 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492375AbZGVPSv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 22 Jul 2009 17:18:51 +0200
Received: by fxm20 with SMTP id 20so295944fxm.0
        for <linux-mips@linux-mips.org>; Wed, 22 Jul 2009 08:18:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=jtxdRjKbM1RVZOMZpWjViueKZoX76/nRmgv1MsP42hI=;
        b=Z4qKceh53xKxH9hq1kkyAaAqVtZhWKvJ1flB2lXpBTuodAdMaIFuStc2TbTouDgyRh
         uUAfSETGz9MLzzL1o2OmtTK1Hfdga4otSQ3K3PV4I9E6EZCnrdfxvAVRt8KQRUDZRPEq
         IFTuR8c60mj4agFJaKoCeuRucW114KA+tSMhc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=vH5vR/fQh8NaDfya0bOlredcmOXwOzqpWaZBh/3zpzoVnEWhK4ek078baICqSjcfhT
         S3KqUxf+szJoiaZbPyClV+BY6rvYT+gNeRgxVqpFsDNTZuiNPRFOawbjvTBYVSMW8WuJ
         5Tx/IUkrORT74RhxKSTDXmxG502aeAbZ8MPj8=
Received: by 10.103.241.15 with SMTP id t15mr289755mur.1.1248275923385;
        Wed, 22 Jul 2009 08:18:43 -0700 (PDT)
Received: from localhost.localdomain (p5496E29E.dip.t-dialin.net [84.150.226.158])
        by mx.google.com with ESMTPS id j10sm2370723mue.29.2009.07.22.08.18.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Jul 2009 08:18:42 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	linux-kernel@vger.kernel.org
Cc:	linux-mips@linux-mips.org, Manuel Lauss <manuel.lauss@gmail.com>,
	Frans Pop <elendil@planet.nl>
Subject: [PATCH V2] au1xmmc: dev_pm_ops conversion
Date:	Wed, 22 Jul 2009 17:18:39 +0200
Message-Id: <1248275919-3296-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.3.3
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23766
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Cc: Frans Pop <elendil@planet.nl>
Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
V1->V2: don't remove CONFIG_PM

 drivers/mmc/host/au1xmmc.c |   24 +++++++++++++++---------
 1 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
index d3f5561..2d4e20f 100644
--- a/drivers/mmc/host/au1xmmc.c
+++ b/drivers/mmc/host/au1xmmc.c
@@ -1132,12 +1132,12 @@ static int __devexit au1xmmc_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM
-static int au1xmmc_suspend(struct platform_device *pdev, pm_message_t state)
+static int au1xmmc_suspend(struct device *dev)
 {
-	struct au1xmmc_host *host = platform_get_drvdata(pdev);
+	struct au1xmmc_host *host = dev_get_drvdata(dev);
 	int ret;
 
-	ret = mmc_suspend_host(host->mmc, state);
+	ret = mmc_suspend_host(host->mmc, PMSG_SUSPEND);
 	if (ret)
 		return ret;
 
@@ -1150,27 +1150,33 @@ static int au1xmmc_suspend(struct platform_device *pdev, pm_message_t state)
 	return 0;
 }
 
-static int au1xmmc_resume(struct platform_device *pdev)
+static int au1xmmc_resume(struct device *dev)
 {
-	struct au1xmmc_host *host = platform_get_drvdata(pdev);
+	struct au1xmmc_host *host = dev_get_drvdata(dev);
 
 	au1xmmc_reset_controller(host);
 
 	return mmc_resume_host(host->mmc);
 }
+
+static struct dev_pm_ops au1xmmc_pmops = {
+	.resume		= au1xmmc_resume,
+	.suspend	= au1xmmc_suspend,
+};
+
+#define AU1XMMC_PMOPS &au1xmmc_pmops
+
 #else
-#define au1xmmc_suspend NULL
-#define au1xmmc_resume NULL
+#define AU1XMMC_PMOPS NULL
 #endif
 
 static struct platform_driver au1xmmc_driver = {
 	.probe         = au1xmmc_probe,
 	.remove        = au1xmmc_remove,
-	.suspend       = au1xmmc_suspend,
-	.resume        = au1xmmc_resume,
 	.driver        = {
 		.name  = DRIVER_NAME,
 		.owner = THIS_MODULE,
+		.pm    = AU1XMMC_PMOPS,
 	},
 };
 
-- 
1.6.3.3
