Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Dec 2009 13:22:08 +0100 (CET)
Received: from mail-ew0-f223.google.com ([209.85.219.223]:58589 "EHLO
        mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492337AbZLBMWE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Dec 2009 13:22:04 +0100
Received: by ewy23 with SMTP id 23so153795ewy.24
        for <multiple recipients>; Wed, 02 Dec 2009 04:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:organization:to:cc:content-type
         :content-transfer-encoding:message-id;
        bh=2GzoOAe2WUrdb5yI4ZrvyskojHq0XXoMX3q7VnT0UY4=;
        b=wcVPTKlBNK1oaPfp5eSSnCVrgx+ky+ZdtpDrt9A8HjU2ZhtZYyFUDpXwgiH61btGJZ
         pzm46Fro6Ngb2489msFrkzriWKgfIQfCF62ti/K8tDhlIoweU2c0WxzweiXD3/NuwXXO
         UbJEUFGfdaAfuwomd5YQCTdzDRijXfZWdmqHo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:organization
         :to:cc:content-type:content-transfer-encoding:message-id;
        b=cxVxW/9tp3p/BeZTv+t9J2Rm1quNTPYionKPyS+HWBYEmn2H6mByBaqArpFP8PtD3Z
         iXKHO5/lv6tpgU2pzqBzK2+bUVfAO9d4aDRBFBEYUjshycYGj2tX7AQU2YzCn1SZeatf
         z41KdzS5k9QZllLNkGhj6yP9cJwfoxqQ2W2Ik=
Received: by 10.213.110.4 with SMTP id l4mr7469237ebp.81.1259756511415;
        Wed, 02 Dec 2009 04:21:51 -0800 (PST)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id 16sm695140ewy.14.2009.12.02.04.21.47
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 02 Dec 2009 04:21:50 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
Date:   Wed, 2 Dec 2009 13:21:23 +0100
Subject: [PATCH] rc32434_wdt: fix compilation failure
MIME-Version: 1.0
X-UID:  151
X-Length: 1439
Organization: OpenWrt
To:     Wim Van Sebroeck <wim@iguana.be>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200912021321.24198.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25270
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Wim,

This is a pretty critical fix, please try to get it in 2.6.32. Thank you
very much!
---
From: Florian Fainelli <florian@openwrt.org>
Subject: [PATCH] rc32434_wdt: fix compilation failure

This patch fixes the compilation failure of
rc32434 due to a bad module parameter description.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/drivers/watchdog/rc32434_wdt.c b/drivers/watchdog/rc32434_wdt.c
index f6cccc9..47588de 100644
--- a/drivers/watchdog/rc32434_wdt.c
+++ b/drivers/watchdog/rc32434_wdt.c
@@ -62,7 +62,7 @@ extern unsigned int idt_cpu_freq;
 static int timeout = WATCHDOG_TIMEOUT;
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout, "Watchdog timeout value, in seconds (default="
-		WATCHDOG_TIMEOUT ")");
+		__MODULE_STRING(WATCHDOG_TIMEOUT) ")");
 
 static int nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, int, 0);
