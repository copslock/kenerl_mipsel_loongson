Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Jun 2011 18:56:46 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:37876 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491071Ab1FLQ4Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 12 Jun 2011 18:56:24 +0200
Received: by wwb17 with SMTP id 17so3489562wwb.24
        for <linux-mips@linux-mips.org>; Sun, 12 Jun 2011 09:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:to:subject:date:user-agent
         :organization:mime-version:content-type:content-transfer-encoding
         :message-id;
        bh=ow4IbsJ2DXFB763eZg4cX43K8zFjEVbuyBrVo9LzVGY=;
        b=fsoWUBOqw3ss6G3q85Zkpbd/126qCjdDIWH8x/2uLpxUPGYmO/6tIYkqit/eHhe2oH
         8eFehMClo6fZW6yvUP7cOEl7c+l3pOPaJCmt/p71idl+/GltYMDypb/KwI3RQoVOgTiN
         utelPHSVmvfM4LSGfWf+Z5sWYhbxIAwkaMI1w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:organization:mime-version
         :content-type:content-transfer-encoding:message-id;
        b=DxepwEU+JVLMY69aGctTpZT89Sigiz9nAZi3dFhvV+ys0+YxMWoZ4qjaeIUAeu1WQj
         /1TZv6TCnt41MhY4K/p9EUkf/MuqGZbnmU+odahS/q7tMyqrmeLvwADjrAvAQjYj8LFm
         rhP+gSdchuGVMeLfB8CM3r3rZMAdWWDj21ug0=
Received: by 10.216.136.207 with SMTP id w57mr1705004wei.63.1307897779638;
        Sun, 12 Jun 2011 09:56:19 -0700 (PDT)
Received: from bender.localnet (fbx.mimichou.net [82.236.225.16])
        by mx.google.com with ESMTPS id r20sm2448344wec.31.2011.06.12.09.56.18
        (version=SSLv3 cipher=OTHER);
        Sun, 12 Jun 2011 09:56:18 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Jamie Iles <jamie@jamieiles.com>, stable@kernel.org
Subject: [PATCH 2/5 v2] WATCHDOG: mtx1-wdt: request gpio before using it
Date:   Sun, 12 Jun 2011 18:56:17 +0200
User-Agent: KMail/1.13.6 (Linux/2.6.38-9-generic; KDE/4.6.2; x86_64; ; )
Organization: OpenWrt
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201106121856.17176.florian@openwrt.org>
X-archive-position: 30349
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10183

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

Stable: [2.6.39+]

diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
index 63df28c..9b63642 100644
--- a/drivers/watchdog/mtx-1_wdt.c
+++ b/drivers/watchdog/mtx-1_wdt.c
@@ -214,6 +214,12 @@ static int __devinit mtx1_wdt_probe(struct platform_device *pdev)
 	int ret;
 
 	mtx1_wdt_device.gpio = pdev->resource[0].start;
+	ret = gpio_request_one(mtx1_wdt_device.gpio,
+				GPIOF_OUT_INIT_HIGH,"mtx1-wdt");
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
