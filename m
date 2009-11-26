Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Nov 2009 19:42:53 +0100 (CET)
Received: from ey-out-1920.google.com ([74.125.78.144]:11300 "EHLO
        ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493766AbZKZSmt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Nov 2009 19:42:49 +0100
Received: by ey-out-1920.google.com with SMTP id 3so2289099eyh.0
        for <linux-mips@linux-mips.org>; Thu, 26 Nov 2009 10:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:organization:to:cc:content-type
         :content-transfer-encoding:message-id;
        bh=AWBNh2C8wBlxBuWhPvxEweGOTMO43BCtdW1i51rl7XU=;
        b=Jy7ofrHTiFFDDb9ve2E6eFzZx7jCJTg1pYnalQb/FcTV9pGWrMHAw+HmnAS//lAAxE
         AiEf5D6QiZZW1R9o5+1xYfEDtCCMbhffRZQX/tWI3OOjALneQ28mpuk0SWluP6SPy3fR
         V/wRwDqFyQgCe0BYUBJFG2abgLhtydnp7QTeo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:organization
         :to:cc:content-type:content-transfer-encoding:message-id;
        b=fZuuwZnFfj/2wnVVAQsV3Y39Bd3A6PdLBH9+f52wDevIFhH6p1hPN15qXJbCNCqo7u
         VZCzLoFt8eBCKnpaea0mTcgu4hmoZIQ7TzTRklmnj4RzNOt2MCfhVBlnllYnM0Jbj39F
         jNVG/WECKhJ/St6M5jk2pdZbO+p9t52qH8mz0=
Received: by 10.213.1.205 with SMTP id 13mr2518428ebg.50.1259260967123;
        Thu, 26 Nov 2009 10:42:47 -0800 (PST)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id 13sm474388ewy.5.2009.11.26.10.42.46
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 26 Nov 2009 10:42:46 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
Date:   Thu, 26 Nov 2009 19:41:02 +0100
Subject: [PATCH] leds: use default-on trigger for Cobalt Qube
MIME-Version: 1.0
X-UID:  147
X-Length: 1508
Organization: OpenWrt
To:     Richard Purdie <rpurdie@rpsys.net>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Martin Michlmayr <tbm@cyrius.com>,
        Sameer Verma <sverma@sfsu.edu>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200911261941.02431.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25160
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch changes the default trigger from "ide-disk"
to "default-on". Users updating from kernels not having this
LED driver will prefer having the same LED behavior as they
used to.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/drivers/leds/leds-cobalt-qube.c b/drivers/leds/leds-cobalt-qube.c
index 8816806..81b2014 100644
--- a/drivers/leds/leds-cobalt-qube.c
+++ b/drivers/leds/leds-cobalt-qube.c
@@ -31,7 +31,7 @@ static struct led_classdev qube_front_led = {
 	.name			= "qube::front",
 	.brightness		= LED_FULL,
 	.brightness_set		= qube_front_led_set,
-	.default_trigger	= "ide-disk",
+	.default_trigger	= "default-on",
 };
 
 static int __devinit cobalt_qube_led_probe(struct platform_device *pdev)
