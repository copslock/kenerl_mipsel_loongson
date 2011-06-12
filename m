Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Jun 2011 18:57:11 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:37876 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491103Ab1FLQ4b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 12 Jun 2011 18:56:31 +0200
Received: by mail-ww0-f43.google.com with SMTP id 17so3489562wwb.24
        for <linux-mips@linux-mips.org>; Sun, 12 Jun 2011 09:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:to:subject:date:user-agent
         :organization:mime-version:content-type:content-transfer-encoding
         :message-id;
        bh=OfLG0fC184Bczs3rYYk0qhCU+x+er8m5j3eaAjPEUtA=;
        b=j5Ax1WYxnJNWex9CP6HVVPotU7iV4N3vEYKRX2cv3pQMj97tJ87XBD/1q/0Eal+D0v
         tZvzajhivgM0Ad4qTJdUPfw0cKmgHrCGPys2o5n7og6+kjEMBx6z+t9HO5Bk3x6c5Gt5
         ygqwsOEwXKQC7QbweeOa2iViOENBtMMS+WD8M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:organization:mime-version
         :content-type:content-transfer-encoding:message-id;
        b=SWkAwJgmC6n/UrSSe0wafKeVVJ1bBkJ8idoR+a1mDiWUNItaVX+k3r4k5XoapF5bWd
         dqKoHdkQfDpmPMu3NAcMLPIBA3LnXSBaPKKil/KPbJ/M0Cg1YyF+yUyImqvGHNdReSF1
         UbAKs7OrQDvpF6XkJBTd4ale6a8GitzNlPS/E=
Received: by 10.216.235.158 with SMTP id u30mr4050294weq.104.1307897791140;
        Sun, 12 Jun 2011 09:56:31 -0700 (PDT)
Received: from bender.localnet (fbx.mimichou.net [82.236.225.16])
        by mx.google.com with ESMTPS id n20sm2449064weq.15.2011.06.12.09.56.29
        (version=SSLv3 cipher=OTHER);
        Sun, 12 Jun 2011 09:56:30 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Jamie Iles <jamie@jamieiles.com>, stable@kernel.org
Subject: [PATCH 3/5 v2] WATCHDOG: mtx1-wdt: fix GPIO toggling
Date:   Sun, 12 Jun 2011 18:56:28 +0200
User-Agent: KMail/1.13.6 (Linux/2.6.38-9-generic; KDE/4.6.2; x86_64; ; )
Organization: OpenWrt
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201106121856.28934.florian@openwrt.org>
X-archive-position: 30350
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10184

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

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Changes since v1:
- use gpio_set_value() instead of gpio_direction_output(.., value)

Stable: [2.6.39+]

diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
index 9b63642..0e51dca 100644
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
