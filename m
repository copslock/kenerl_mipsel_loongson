Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Nov 2011 20:24:50 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:60320 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903731Ab1KOTYV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 15 Nov 2011 20:24:21 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 7FF0A2CEC4F;
        Tue, 15 Nov 2011 20:24:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kQPfGVqUhgxP; Tue, 15 Nov 2011 20:24:20 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id 31C8D3A7824;
        Tue, 15 Nov 2011 20:24:20 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 2/2] MIPS: AR7: add LEDs layout for the Actiontec GT701 router
Date:   Tue, 15 Nov 2011 20:23:44 +0100
Message-Id: <1321385024-32101-2-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1321385024-32101-1-git-send-email-florian@openwrt.org>
References: <1321385024-32101-1-git-send-email-florian@openwrt.org>
X-archive-position: 31612
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12716

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/ar7/platform.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
index 33ffecf..e5f6fca 100644
--- a/arch/mips/ar7/platform.c
+++ b/arch/mips/ar7/platform.c
@@ -462,6 +462,40 @@ static struct gpio_led fb_fon_leds[] = {
 	},
 };
 
+static struct gpio_led gt701_leds[] = {
+	{
+		.name			= "inet:green",
+		.gpio			= 13,
+		.active_low		= 1,
+	},
+	{
+		.name			= "usb",
+		.gpio			= 12,
+		.active_low		= 1,
+	},
+	{
+		.name			= "inet:red",
+		.gpio			= 9,
+		.active_low		= 1,
+	},
+	{
+		.name			= "power:red",
+		.gpio			= 7,
+		.active_low		= 1,
+	},
+	{
+		.name			= "power:green",
+		.gpio			= 8,
+		.active_low		= 1,
+		.default_trigger	= "default-on",
+	},
+        {
+                .name                   = "ethernet",
+                .gpio                   = 10,
+                .active_low             = 1,
+        },
+};
+
 static struct gpio_led_platform_data ar7_led_data;
 
 static struct platform_device ar7_gpio_leds = {
@@ -503,6 +537,9 @@ static void __init detect_leds(void)
 	} else if (strstr(prid, "CYWM") || strstr(prid, "CYWL")) {
 		ar7_led_data.num_leds = ARRAY_SIZE(titan_leds);
 		ar7_led_data.leds = titan_leds;
+	} else if (strstr(prid, "GT701")) {
+		ar7_led_data.num_leds = ARRAY_SIZE(gt701_leds);
+		ar7_led_data.leds = gt701_leds;
 	}
 }
 
-- 
1.7.5.4
