Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2011 14:54:54 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:46681 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491187Ab1FBMy0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jun 2011 14:54:26 +0200
Received: by wwb17 with SMTP id 17so727296wwb.24
        for <linux-mips@linux-mips.org>; Thu, 02 Jun 2011 05:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:to:subject:date:user-agent
         :organization:cc:mime-version:content-type:content-transfer-encoding
         :message-id;
        bh=gAApRguzQVtjd2qJOo9OPNZMZm6AXgRxbhAC6T13dOQ=;
        b=iC3VU/dEvEnQE6jnxra9pWgQn+WCBHx+wjvE/+/RVAbOhTx+eX7sTqplmj5qP3G5IO
         ngcAyh0brisqGxdu4/bK5vE53o+/dZiKFCVl+WtqUDjh7v3ha10XSgiGwI6sNKlweOMC
         kvvdeJvufPWJbLbscTHmf9wXCkQB6VI/aFH5M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:organization:cc:mime-version
         :content-type:content-transfer-encoding:message-id;
        b=SG884ZPSDgTfG+yxgAjJDa47DXzxIdprwmmLkvco5J9BOlYd8QobEDKBiuHeqg52SB
         +qssx9GoL/ICy7T0spm3S4YCG7aBAH8Z8blV4g+8ynwlSszmdcESm5gf/aZTTlUVIimt
         3CNNZE34lJjxYl4wO4/moLZd47fpy5DydDhGA=
Received: by 10.216.241.78 with SMTP id f56mr664838wer.76.1307019261398;
        Thu, 02 Jun 2011 05:54:21 -0700 (PDT)
Received: from bender.localnet (fbx.mimichou.net [82.236.225.16])
        by mx.google.com with ESMTPS id f73sm307336wef.43.2011.06.02.05.54.20
        (version=SSLv3 cipher=OTHER);
        Thu, 02 Jun 2011 05:54:20 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 2/3] WATCHDOG: mtx1-wdt: request gpio before using it
Date:   Thu, 2 Jun 2011 14:54:20 +0200
User-Agent: KMail/1.13.6 (Linux/2.6.38-9-generic; KDE/4.6.2; x86_64; ; )
Organization: OpenWrt
Cc:     stable@kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201106021454.20111.florian@openwrt.org>
X-archive-position: 30192
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 1731

Otherwise, the gpiolib autorequest feature will produce a WARN_ON():

WARNING: at drivers/gpio/gpiolib.c:101 0x8020ec6c()
autorequest GPIO-215
[...]

CC: stable@kernel.org
Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
index 63df28c..16086f8 100644
--- a/drivers/watchdog/mtx-1_wdt.c
+++ b/drivers/watchdog/mtx-1_wdt.c
@@ -214,6 +214,11 @@ static int __devinit mtx1_wdt_probe(struct platform_device *pdev)
 	int ret;
 
 	mtx1_wdt_device.gpio = pdev->resource[0].start;
+	ret = gpio_request(mtx1_wdt_device.gpio, "mtx1-wdt");
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to request gpio");
+		return ret;
+	}
 
 	spin_lock_init(&mtx1_wdt_device.lock);
 	init_completion(&mtx1_wdt_device.stop);
-- 
1.7.4.1
