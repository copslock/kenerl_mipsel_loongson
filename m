Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2011 15:44:37 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:36619 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491850Ab1FBNoe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jun 2011 15:44:34 +0200
Received: by wwb17 with SMTP id 17so771584wwb.24
        for <linux-mips@linux-mips.org>; Thu, 02 Jun 2011 06:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:to:subject:date:user-agent
         :organization:mime-version:content-type:content-transfer-encoding
         :message-id;
        bh=TIWnWZuyMlqJuEjVySrHsNixA7A3kZcmkFQKSTZKInE=;
        b=J3Ydl8/H6gCdOl1JpFiPwSYyGH1OFDSsJP+Zht5or2b46F9m8urz4vTdVNlGYX0JLW
         Uvu/wOHkDdoG5u+mfVbAvApETUYDGhibz8ZC7mjc6vVuw6MI7YKz/4Z5LiJbNKbKJeEQ
         BnId888UvDhgf+qEHxPZiJACXMXOLo04UMXQk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:organization:mime-version
         :content-type:content-transfer-encoding:message-id;
        b=qkuVpDRG1rlf5RvRZt3Vy5Yk/vmpbIW0MuD/3gM0X41iz4ChQzyhH7+h+zFGZa2q5m
         l6NILG2KQVxfjiPb/SB+rUZUtaTK/3Nvq29XH0ccqNkIGdDzQHJfwJeDDPk4DLIfDhNg
         yzvzh9izxRtC40EuRtCR53xAuTBOBm3E3ABlU=
Received: by 10.216.145.131 with SMTP id p3mr716608wej.82.1307022269369;
        Thu, 02 Jun 2011 06:44:29 -0700 (PDT)
Received: from bender.localnet (fbx.mimichou.net [82.236.225.16])
        by mx.google.com with ESMTPS id a1sm331049wek.46.2011.06.02.06.44.27
        (version=SSLv3 cipher=OTHER);
        Thu, 02 Jun 2011 06:44:28 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 1/2] WATCHDOG: mtx1-wdt: fix section mismatch
Date:   Thu, 2 Jun 2011 15:44:26 +0200
User-Agent: KMail/1.13.6 (Linux/2.6.38-9-generic; KDE/4.6.2; x86_64; ; )
Organization: OpenWrt
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201106021544.26256.florian@openwrt.org>
X-archive-position: 30195
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 1772


Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
index 9756da9..f313d3b 100644
--- a/drivers/watchdog/mtx-1_wdt.c
+++ b/drivers/watchdog/mtx-1_wdt.c
@@ -245,7 +245,7 @@ static int __devexit mtx1_wdt_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_driver mtx1_wdt = {
+static struct platform_driver mtx1_wdt_driver = {
 	.probe = mtx1_wdt_probe,
 	.remove = __devexit_p(mtx1_wdt_remove),
 	.driver.name = "mtx1-wdt",
@@ -254,12 +254,12 @@ static struct platform_driver mtx1_wdt = {
 
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
