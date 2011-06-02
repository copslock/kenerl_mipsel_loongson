Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2011 14:55:17 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:52142 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491848Ab1FBMya (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jun 2011 14:54:30 +0200
Received: by wyb28 with SMTP id 28so809168wyb.36
        for <linux-mips@linux-mips.org>; Thu, 02 Jun 2011 05:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:to:subject:date:user-agent
         :organization:cc:mime-version:content-type:content-transfer-encoding
         :message-id;
        bh=V2xZ54afUaD04skMrZs4hhZ/EGJQvdQmI4cmbCUvl2w=;
        b=rd5TPD/WiKdSHVIbfiiaDD47xFP2/YomBN1iCqCtYq5MLkHB6ob8qgVt2tneCMSm1B
         Re9KzZONWPg9yxAviJrPNkb2R9ZRQuVBOjBV7j9947H25VOJHb5Y8jW7Zvd1oqnzpfgV
         XAdcTwkFh0wAWGmCuj9ob4jajRgOZE//Y/Jhs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:organization:cc:mime-version
         :content-type:content-transfer-encoding:message-id;
        b=M6H523SDuxa9Wss8rHXL265cPs1daX0GfAb1UOQbZ9NymIJgf3Tx18fF32Q2qweYTr
         JPVA6NsLPiq80Ie/yA60ZBRUBDEU52zI+EsljUap5Wcvu5nUwUHAiBQGIIATcnMCcDS6
         AYV3ArxJ9Z5nJWYpxwflwOWUG1Zjx3VTTqr2I=
Received: by 10.216.236.28 with SMTP id v28mr2334034weq.12.1307019264212;
        Thu, 02 Jun 2011 05:54:24 -0700 (PDT)
Received: from bender.localnet (fbx.mimichou.net [82.236.225.16])
        by mx.google.com with ESMTPS id d7sm307005wek.45.2011.06.02.05.54.22
        (version=SSLv3 cipher=OTHER);
        Thu, 02 Jun 2011 05:54:23 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 3/3] WATCHDOG: mtx1-wdt: fix GPIO toggling
Date:   Thu, 2 Jun 2011 14:54:21 +0200
User-Agent: KMail/1.13.6 (Linux/2.6.38-9-generic; KDE/4.6.2; x86_64; ; )
Organization: OpenWrt
Cc:     stable@kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201106021454.21827.florian@openwrt.org>
X-archive-position: 30193
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 1732

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
diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
index 16086f8..9756da9 100644
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
+	gpio_direction_output(mtx1_wdt_device.gpio, mtx1_wdt_device.gstate);
 
 	if (mtx1_wdt_device.queue && ticks)
 		mod_timer(&mtx1_wdt_device.timer, jiffies + MTX1_WDT_INTERVAL);
-- 
1.7.4.1
