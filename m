Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2011 19:12:11 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:43802 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491149Ab1FORLg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jun 2011 19:11:36 +0200
Received: by mail-ww0-f43.google.com with SMTP id 17so593173wwb.24
        for <linux-mips@linux-mips.org>; Wed, 15 Jun 2011 10:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:organization:to:subject:date
         :user-agent:cc:mime-version:content-type:content-transfer-encoding
         :message-id;
        bh=M1Wk46Lg73Jhd/aVpCta1BQ9gn0srSi4C0keAUcV0h4=;
        b=AfqCkhY+DtOx1jwl3pmcNxtnIsjxEPFw+MJdx9sTbmCWC9JfX4VLd1jo1C7n1GxOWk
         1DwRxt6cs1ObMU6biQqRCBwkh+BvA9g82O0VTkYtErYfAn1DbpJ0OqPIUY/lkxfGZdDz
         g68J9iH0y5QA2uoSBfk00qdxyxXuVKTtVc6kY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:message-id;
        b=FEpHeAnDEzp6j8QdZrOtt7BYm36aGC/fJnAvHqpst6va+nBT0NdK8OTthYCuTydj57
         R4JRAqHSjN49H4nEffXo4z0k5IJcf6EZ4gjBs6gV2mc36T6PCCNsSvq5h9IpXT9Q2hCr
         OkXtMYxpiAaB+JiHUuwz7C8O1iaxBwzZZIrJY=
Received: by 10.227.100.219 with SMTP id z27mr867934wbn.45.1308157896706;
        Wed, 15 Jun 2011 10:11:36 -0700 (PDT)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id fl19sm502699wbb.66.2011.06.15.10.11.35
        (version=SSLv3 cipher=OTHER);
        Wed, 15 Jun 2011 10:11:35 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 4/5 v3] WATCHDOG: mtx1-wdt: fix section mismatch
Date:   Wed, 15 Jun 2011 19:15:52 +0200
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-server; KDE/4.6.2; x86_64; ; )
Cc:     linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Jamie Iles <jamie@jamieiles.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201106151915.52793.florian@openwrt.org>
X-archive-position: 30420
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12532


Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
No changes in v1, v2 and v3

diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
index 4b0134e..03cab33 100644
--- a/drivers/watchdog/mtx-1_wdt.c
+++ b/drivers/watchdog/mtx-1_wdt.c
@@ -248,7 +248,7 @@ static int __devexit mtx1_wdt_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_driver mtx1_wdt = {
+static struct platform_driver mtx1_wdt_driver = {
 	.probe = mtx1_wdt_probe,
 	.remove = __devexit_p(mtx1_wdt_remove),
 	.driver.name = "mtx1-wdt",
@@ -257,12 +257,12 @@ static struct platform_driver mtx1_wdt = {
 
 static int __init mtx1_wdt_init(void)
 {
-	return platform_driver_register(&mtx1_wdt);
+	return platform_driver_register(&mtx1_wdt_driver);
 }
 
 static void __exit mtx1_wdt_exit(void)
 {
-	platform_driver_unregister(&mtx1_wdt);
+	platform_driver_unregister(&mtx1_wdt_driver);
 }
 
 module_init(mtx1_wdt_init);
-- 
1.7.4.1
