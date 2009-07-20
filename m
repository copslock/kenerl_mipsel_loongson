Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jul 2009 20:51:40 +0200 (CEST)
Received: from mail-bw0-f208.google.com ([209.85.218.208]:54072 "EHLO
	mail-bw0-f208.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492946AbZGTSvd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 20 Jul 2009 20:51:33 +0200
Received: by bwz4 with SMTP id 4so2465670bwz.0
        for <linux-mips@linux-mips.org>; Mon, 20 Jul 2009 11:51:28 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=dOx8O3I+zoeL1p309uVbv6SsyvLrdmj/L+gH6Lqq6Sk=;
        b=DZ6PhVjLFckFmkT7QY82Mj9PHYByHqsmcPYEH2V0+JkUBrfebte6D+h9tTXufKDRvG
         wTQZnTM8GdxqnmpYSgz5rMhV1wLw5lnG4IUezjKeQ+1yRU6RVlonkXE5p5JqrZHO9/ml
         7Fk+yY67l7hE45zSjfi0S458Yz7abtNmIk1OM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=bqIgRbD44a8ShCLdtlePjq+WCUXsqxezzE3v+qn0VLDvvFpiegf14B77r4tHaOUadm
         paDU16Heodfrktc/4BmBYHU1dBqEBHXAMfHd5SO4WQmTVbiOzAA7IxBwcZUmWyrkAfZI
         P5NuIUrwBRgVsfKnnHnyfkx3Cvuv8Gw4FucaY=
Received: by 10.103.248.17 with SMTP id a17mr2319619mus.97.1248115887945;
        Mon, 20 Jul 2009 11:51:27 -0700 (PDT)
Received: from localhost.localdomain (p5496D3B0.dip.t-dialin.net [84.150.211.176])
        by mx.google.com with ESMTPS id j9sm23733035mue.51.2009.07.20.11.51.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Jul 2009 11:51:27 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	linux-kernel@vger.kernel.org
Cc:	linux-mips@linux-mips.org, Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] au1xmmc: dev_pm_ops conversion
Date:	Mon, 20 Jul 2009 20:51:21 +0200
Message-Id: <1248115882-20221-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.3.3
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23753
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
Run-tested on Au1200.

 drivers/mmc/host/au1xmmc.c |   23 +++++++++++------------
 1 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
index d3f5561..70509c9 100644
--- a/drivers/mmc/host/au1xmmc.c
+++ b/drivers/mmc/host/au1xmmc.c
@@ -1131,13 +1131,12 @@ static int __devexit au1xmmc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
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
 
@@ -1150,27 +1149,27 @@ static int au1xmmc_suspend(struct platform_device *pdev, pm_message_t state)
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
-#else
-#define au1xmmc_suspend NULL
-#define au1xmmc_resume NULL
-#endif
+
+static struct dev_pm_ops au1xmmc_pmops = {
+	.resume		= au1xmmc_resume,
+	.suspend	= au1xmmc_suspend,
+};
 
 static struct platform_driver au1xmmc_driver = {
 	.probe         = au1xmmc_probe,
 	.remove        = au1xmmc_remove,
-	.suspend       = au1xmmc_suspend,
-	.resume        = au1xmmc_resume,
 	.driver        = {
 		.name  = DRIVER_NAME,
 		.owner = THIS_MODULE,
+		.pm    = &au1xmmc_pmops,
 	},
 };
 
-- 
1.6.3.3
