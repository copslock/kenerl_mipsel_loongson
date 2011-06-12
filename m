Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Jun 2011 18:56:25 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:41175 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491065Ab1FLQ4U (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 12 Jun 2011 18:56:20 +0200
Received: by wyb28 with SMTP id 28so3788831wyb.36
        for <linux-mips@linux-mips.org>; Sun, 12 Jun 2011 09:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:to:subject:date:user-agent
         :organization:mime-version:content-type:content-transfer-encoding
         :message-id;
        bh=Keq3zFs/ceudYueQ8OtRMeF30h9+ZPZTe0+bL+Anbao=;
        b=DLIv3qMxuuL2j4/dbaObKtsZ/9VIZdTwP7RcggUNDFRBGtePCLDJlgtJSdbkN7NiW+
         EvVIj532emeQUSS/XHBrg0JlqypYGeHGn9EvzvEeU1wwS79es6yl9bj+l9GCCGIpRRqS
         y+0MRCOc1F2RTIAsBVfAH3WSW9DZ6atg1Dcns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:organization:mime-version
         :content-type:content-transfer-encoding:message-id;
        b=UVeAandO9tJLa4iKCMJKC7/4gUYp6rsFw7N9p0ngQaONNPAHMpFWwwz60q7cFHP1Fu
         QvUpW59oqz59AzvrgtEzHYnXDvvBy/MCyWIOv9TA+GpM3wSWh7K2LAWDmH9eSyWvntHb
         lC62v0njqE2c0y2QghJJcaGYCCwTpneHsGh6I=
Received: by 10.216.80.32 with SMTP id j32mr4045748wee.91.1307897774385;
        Sun, 12 Jun 2011 09:56:14 -0700 (PDT)
Received: from bender.localnet (fbx.mimichou.net [82.236.225.16])
        by mx.google.com with ESMTPS id o75sm2448726weq.16.2011.06.12.09.56.12
        (version=SSLv3 cipher=OTHER);
        Sun, 12 Jun 2011 09:56:13 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Jamie Iles <jamie@jamieiles.com>
Subject: [PATCH 1/5 v2] WATCHDOG: mtx1-wdt: use dev_{err,info} instead of printk()
Date:   Sun, 12 Jun 2011 18:56:10 +0200
User-Agent: KMail/1.13.6 (Linux/2.6.38-9-generic; KDE/4.6.2; x86_64; ; )
Organization: OpenWrt
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201106121856.11031.florian@openwrt.org>
X-archive-position: 30348
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10182


Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
No changes since v1

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
