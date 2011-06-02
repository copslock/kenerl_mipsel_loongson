Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2011 14:54:28 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:57025 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491184Ab1FBMyZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jun 2011 14:54:25 +0200
Received: by wwb17 with SMTP id 17so727282wwb.24
        for <linux-mips@linux-mips.org>; Thu, 02 Jun 2011 05:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:to:subject:date:user-agent
         :organization:mime-version:content-type:content-transfer-encoding
         :message-id;
        bh=aWDeU6QVXXBoo3NpNDwImSlZesuFNDZf07bkip1VCRw=;
        b=PV5Sfp1t21vKYwaBc6aS8WciXxfOX8SAJmXOrA9hobv/zd65VTRdoskdTlR2Hoon/u
         WoduPkEo8E8RSrgIqHaYThtCbJ1pMQBEFISNsFc7IpIdR75Hozq/0lIYvX0kU99yZB3q
         nfE1u2qJ1/7sqVUyGoq24cu374dngSZaurrq0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:organization:mime-version
         :content-type:content-transfer-encoding:message-id;
        b=HyK42AboX67rJftSLlU7vWJr9atAPg2EnzuJGVB0WzJu6CKZoHGPcSdlEzIK6MGFtf
         NTfV++EQSigHBPJ71Y0OLpGHAN7xPpM13Mzlt8XKOy5E0Xus87UQ4TVsO0YUr15C2mZr
         G99FCQjzDoKTy/chKPV8P3ZCTRNPSItrSY4dM=
Received: by 10.216.235.158 with SMTP id u30mr657427weq.104.1307019260041;
        Thu, 02 Jun 2011 05:54:20 -0700 (PDT)
Received: from bender.localnet (fbx.mimichou.net [82.236.225.16])
        by mx.google.com with ESMTPS id f73sm307336wef.43.2011.06.02.05.54.18
        (version=SSLv3 cipher=OTHER);
        Thu, 02 Jun 2011 05:54:19 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 1/3] WATCHDOG: mtx1-wdt: use dev_{err,info} instead of printk()
Date:   Thu, 2 Jun 2011 14:54:17 +0200
User-Agent: KMail/1.13.6 (Linux/2.6.38-9-generic; KDE/4.6.2; x86_64; ; )
Organization: OpenWrt
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201106021454.17652.florian@openwrt.org>
X-archive-position: 30191
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 1729


Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
index 1479dc4..63df28c 100644
--- a/drivers/watchdog/mtx-1_wdt.c
+++ b/drivers/watchdog/mtx-1_wdt.c
@@ -224,11 +224,11 @@ static int __devinit mtx1_wdt_probe(struct platform_device *pdev)
 
 	ret = misc_register(&mtx1_wdt_misc);
 	if (ret < 0) {
-		printk(KERN_ERR " mtx-1_wdt : failed to register\n");
+		dev_err(&pdev->dev, "failed to register\n");
 		return ret;
 	}
 	mtx1_wdt_start();
-	printk(KERN_INFO "MTX-1 Watchdog driver\n");
+	dev_info(&pdev->dev, "MTX-1 Watchdog driver\n");
 	return 0;
 }
 
-- 
1.7.4.1
