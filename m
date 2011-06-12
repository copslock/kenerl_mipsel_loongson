Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Jun 2011 18:57:36 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:41175 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491105Ab1FLQ4e (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 12 Jun 2011 18:56:34 +0200
Received: by mail-wy0-f177.google.com with SMTP id 28so3788831wyb.36
        for <linux-mips@linux-mips.org>; Sun, 12 Jun 2011 09:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:to:subject:date:user-agent
         :organization:mime-version:content-type:content-transfer-encoding
         :message-id;
        bh=jt5lL815yz2/MtBsrYve0oXZsDzPL+ZP5uOG8o9sLJQ=;
        b=BHCU9mpXP8DwndtbPAEk4l3x+S/LhsCtUXNPTHegBjCyZP9yvXvCwGwNmtN8LK89nU
         SbistZuV2syD6f0Mz3pI/L/aw61yZKvTifrEo93HffjyOQmjOh/wum5EQZycOUYxPNAb
         LYG/LE9WThsX4mNFG3oYmisNAGChACAxpHUdM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:organization:mime-version
         :content-type:content-transfer-encoding:message-id;
        b=ZqNqBeimYn6ouuYp8ygZ+HRXLCLe5MK/l1bga7GGcOJWO+28EVV51XJoK/5immGoU3
         +oFlgjruMeqi9RFDqtz/CWPYh2ePM+cHWQ4RmX52VzAbrwj2VWOAJDwHbG8Yt/NEy/0s
         HpxLUzalK+L5R1DHgWQz1n+AZOf0aUJjVmo9c=
Received: by 10.227.55.20 with SMTP id s20mr4304910wbg.15.1307897794502;
        Sun, 12 Jun 2011 09:56:34 -0700 (PDT)
Received: from bender.localnet (fbx.mimichou.net [82.236.225.16])
        by mx.google.com with ESMTPS id m8sm3603830wbh.62.2011.06.12.09.56.33
        (version=SSLv3 cipher=OTHER);
        Sun, 12 Jun 2011 09:56:33 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Jamie Iles <jamie@jamieiles.com>
Subject: [PATCH 4/5 v2] WATCHDOG: mtx1-wdt: fix section mismatch
Date:   Sun, 12 Jun 2011 18:56:32 +0200
User-Agent: KMail/1.13.6 (Linux/2.6.38-9-generic; KDE/4.6.2; x86_64; ; )
Organization: OpenWrt
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201106121856.32317.florian@openwrt.org>
X-archive-position: 30351
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10185


Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
No changes since v1

diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
index 0e51dca..c5f6e72 100644
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
