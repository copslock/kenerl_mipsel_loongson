Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2011 19:11:48 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:34981 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491142Ab1FORLb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jun 2011 19:11:31 +0200
Received: by wyb28 with SMTP id 28so566566wyb.36
        for <linux-mips@linux-mips.org>; Wed, 15 Jun 2011 10:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:organization:to:subject:date
         :user-agent:cc:mime-version:content-type:content-transfer-encoding
         :message-id;
        bh=PbBoCBzliKfe5R6JYGb1nXvpJHawhVxb0mEBclW8h4I=;
        b=ko7IQZOCTdQ+H3VvhJYR+Y/RPtji6+q066z4M0EWG/q2nSRnk4JTRlUvAWdgqhfKXR
         kGCgfqUfbYEnDghRwgwgST2n/iYipQSbRxtLGAMBh5Iyuzst2LVdKI1XRE98vzeWeoNh
         9sr62K0bW57asczmXXS5gORzCUtPMdDjvG8RI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:message-id;
        b=jZ8hnpyyzn7cBAFoKW1ZeKXfop+1/IlmnqteqbiQjIu7VmzMHQUNi7pAUNd3JdBrSU
         dd9hSBs67SqzEehp147hNV4UhDQHaB7YD/M9yT7S4+ecjubrS/D8lIycAMHAJX03573z
         XxQznJwypJSjjA7dRp4nosG1uvXBrSxJIoM7M=
Received: by 10.227.175.12 with SMTP id v12mr851748wbz.110.1308157885662;
        Wed, 15 Jun 2011 10:11:25 -0700 (PDT)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id fm14sm504272wbb.41.2011.06.15.10.11.24
        (version=SSLv3 cipher=OTHER);
        Wed, 15 Jun 2011 10:11:24 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 3/5 v3] WATCHDOG: mtx1-wdt: fix GPIO toggling
Date:   Wed, 15 Jun 2011 19:15:41 +0200
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-server; KDE/4.6.2; x86_64; ; )
Cc:     linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Jamie Iles <jamie@jamieiles.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201106151915.42044.florian@openwrt.org>
X-archive-position: 30419
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12530

Commit e391be76 (MIPS: Alchemy: Clean up GPIO registers and accessors)
changed the way the GPIO was toggled. Prior to this patch, we would
always actively drive the GPIO output to either 0 or 1, this patch
drove the GPIO active to 0, and put the GPIO in tristate to drive it
to 1, unfortunately this does not work, revert back to active driving.

Using a signed variable (gstate) to hold the gpio state and using a bit-
wise operation on it also resulted in toggling value from 1 to -2 since
the variable is signed. This value was then passed on to gpio_direction_
output, which always perform a if (value) ... to set the value to the
gpio, so we were always writing a 1 to this GPIO instead of 1 -> 0 -> 1 ...

CC: stable@kernel.org
Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Changes since v1:
- use gpio_set_value() instead of gpio_direction_output(.., value)

Changes since v2:
- fixed stable@kernel.org address

diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
index b93926e..4b0134e 100644
--- a/drivers/watchdog/mtx-1_wdt.c
+++ b/drivers/watchdog/mtx-1_wdt.c
@@ -66,7 +66,7 @@ static struct {
 	int default_ticks;
 	unsigned long inuse;
 	unsigned gpio;
-	int gstate;
+	unsigned int gstate;
 } mtx1_wdt_device;
 
 static void mtx1_wdt_trigger(unsigned long unused)
@@ -78,11 +78,8 @@ static void mtx1_wdt_trigger(unsigned long unused)
 		ticks--;
 
 	/* toggle wdt gpio */
-	mtx1_wdt_device.gstate = ~mtx1_wdt_device.gstate;
-	if (mtx1_wdt_device.gstate)
-		gpio_direction_output(mtx1_wdt_device.gpio, 1);
-	else
-		gpio_direction_input(mtx1_wdt_device.gpio);
+	mtx1_wdt_device.gstate = !mtx1_wdt_device.gstate;
+	gpio_set_value(mtx1_wdt_device.gpio, mtx1_wdt_device.gstate);
 
 	if (mtx1_wdt_device.queue && ticks)
 		mod_timer(&mtx1_wdt_device.timer, jiffies + MTX1_WDT_INTERVAL);
@@ -105,7 +102,7 @@ static void mtx1_wdt_start(void)
 	if (!mtx1_wdt_device.queue) {
 		mtx1_wdt_device.queue = 1;
 		mtx1_wdt_device.gstate = 1;
-		gpio_direction_output(mtx1_wdt_device.gpio, 1);
+		gpio_set_value(mtx1_wdt_device.gpio, 1);
 		mod_timer(&mtx1_wdt_device.timer, jiffies + MTX1_WDT_INTERVAL);
 	}
 	mtx1_wdt_device.running++;
@@ -120,7 +117,7 @@ static int mtx1_wdt_stop(void)
 	if (mtx1_wdt_device.queue) {
 		mtx1_wdt_device.queue = 0;
 		mtx1_wdt_device.gstate = 0;
-		gpio_direction_output(mtx1_wdt_device.gpio, 0);
+		gpio_set_value(mtx1_wdt_device.gpio, 0);
 	}
 	ticks = mtx1_wdt_device.default_ticks;
 	spin_unlock_irqrestore(&mtx1_wdt_device.lock, flags);
-- 
1.7.4.1
