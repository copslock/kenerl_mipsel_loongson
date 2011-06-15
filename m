Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2011 19:11:02 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:43802 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491099Ab1FORK7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jun 2011 19:10:59 +0200
Received: by wwb17 with SMTP id 17so593173wwb.24
        for <linux-mips@linux-mips.org>; Wed, 15 Jun 2011 10:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:organization:to:subject:date
         :user-agent:cc:mime-version:content-type:content-transfer-encoding
         :message-id;
        bh=lF2IwhRc6aBwoNMHypoXCrNxv7rhrkOmNf7j+mwZpXM=;
        b=WwsqYjlXWyzPcTUzWBXH88WG3uZhKk8gzqeQ41kPkEbg+twPB91qVC7LUVSh3sRbJr
         gfEAy9DMBSmCr8VFsc4vtSqOIRV9beJcKFEL21grKnJLhN3J5Wh5w8nTbzBuy9u2cozx
         Kz1G3HIl9bOlBX3859S6Q5i6kYEWRpiP94atQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:message-id;
        b=ACbUcmTPouZWF7HpsL1du05Wqp3+nUzmLmQ74BtY5iOEsIxFGdmglOhRpm2+oTGJqd
         qiVRF+aTp3uwPJjxdGzxawu5jyQa9hmJIBWoaRPo//uVWo37vGSU59R0WWNSDtQcIOr6
         LKEwH9CFEU5c5IUiJNV4DjQOMf8xmRoHtWJp4=
Received: by 10.216.230.138 with SMTP id j10mr2435767weq.46.1308157853726;
        Wed, 15 Jun 2011 10:10:53 -0700 (PDT)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id ex2sm504975wbb.31.2011.06.15.10.10.52
        (version=SSLv3 cipher=OTHER);
        Wed, 15 Jun 2011 10:10:52 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 1/5 v3] WATCHDOG: mtx1-wdt: use dev_{err,info} instead of printk()
Date:   Wed, 15 Jun 2011 19:15:09 +0200
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-server; KDE/4.6.2; x86_64; ; )
Cc:     linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Jamie Iles <jamie@jamieiles.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201106151915.09729.florian@openwrt.org>
X-archive-position: 30417
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12528


Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
No changes in v1, v2 and v3

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
