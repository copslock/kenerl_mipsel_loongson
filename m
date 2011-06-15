Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2011 19:11:26 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:43802 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491141Ab1FORLH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jun 2011 19:11:07 +0200
Received: by mail-ww0-f43.google.com with SMTP id 17so593173wwb.24
        for <linux-mips@linux-mips.org>; Wed, 15 Jun 2011 10:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:organization:to:subject:date
         :user-agent:cc:mime-version:content-type:content-transfer-encoding
         :message-id;
        bh=GXxPJX9SAuonyUGumJJD32CPaiWW3/8JWs7ZpNaMqnw=;
        b=jIyrMkOqt5Slm6QgPBcpEAJbo65WPaObEGcLb50vbFCXX0HQV172h6smZSkqMnyBH4
         oI0TEQSnoaGu5hHiUkHyI57slhsUqw8Xb785VwDdqiBTm9uQo54wNw6zkvCH1zzDXYcl
         ImnHe9gQn4a9FnXS4wyGrJKRhQ1Jj4YKnKVpI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:message-id;
        b=hS2qqcuFo1vbGdP1xZ8eA0uH7neMWXkXGaBn1iZTCrLBjK2WZJLUSCo9PjEtUM1117
         lVRWBCUlFWBl7Sl2cIAFrFoUjQEpd/A3aRWqh41LMZPcQD4tV7YEPkj4+mUci5jWHcuS
         oNZofvqwZdXIAeRv5S3WITePfwkuUrT0zPca0=
Received: by 10.216.237.65 with SMTP id x43mr831549weq.70.1308157867584;
        Wed, 15 Jun 2011 10:11:07 -0700 (PDT)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id z66sm376019weq.0.2011.06.15.10.11.06
        (version=SSLv3 cipher=OTHER);
        Wed, 15 Jun 2011 10:11:06 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 2/5 v3] WATCHDOG: mtx1-wdt: request gpio before using it
Date:   Wed, 15 Jun 2011 19:15:23 +0200
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-server; KDE/4.6.2; x86_64; ; )
Cc:     linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Jamie Iles <jamie@jamieiles.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201106151915.24007.florian@openwrt.org>
X-archive-position: 30418
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12529

Otherwise, the gpiolib autorequest feature will produce a WARN_ON():

WARNING: at drivers/gpio/gpiolib.c:101 0x8020ec6c()
autorequest GPIO-215
[...]

CC:stable@kernel.org
Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Changes since v1:
- use gpio_request_one()
- added missing gpio_free() in mtx1_wdt_remove

Changes since v2:
- added space between GPIOF_OUT_INIT_HIGH and "mtx1-wdt"

diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
index 63df28c..b93926e 100644
--- a/drivers/watchdog/mtx-1_wdt.c
+++ b/drivers/watchdog/mtx-1_wdt.c
@@ -214,6 +214,12 @@ static int __devinit mtx1_wdt_probe(struct platform_device *pdev)
 	int ret;
 
 	mtx1_wdt_device.gpio = pdev->resource[0].start;
+	ret = gpio_request_one(mtx1_wdt_device.gpio,
+				GPIOF_OUT_INIT_HIGH, "mtx1-wdt");
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to request gpio");
+		return ret;
+	}
 
 	spin_lock_init(&mtx1_wdt_device.lock);
 	init_completion(&mtx1_wdt_device.stop);
@@ -239,6 +245,8 @@ static int __devexit mtx1_wdt_remove(struct platform_device *pdev)
 		mtx1_wdt_device.queue = 0;
 		wait_for_completion(&mtx1_wdt_device.stop);
 	}
+
+	gpio_free(mtx1_wdt_device.gpio);
 	misc_deregister(&mtx1_wdt_misc);
 	return 0;
 }
-- 
1.7.4.1
