Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Aug 2009 23:48:02 +0200 (CEST)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:52655 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492860AbZHGVqn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 7 Aug 2009 23:46:43 +0200
Received: by mail-ew0-f216.google.com with SMTP id 12so2282279ewy.0
        for <multiple recipients>; Fri, 07 Aug 2009 14:46:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:cc:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Ml0pZMlkBD3wDPvlY9oAP5vwSJqu7JH5DNwhBjZ2Xe8=;
        b=K64hQjPhmWCc4wC8HAukkIb0Gtbj5CxuQ4NmgMQZejD1zl8lWqOt6/+6I5DOKFYCon
         zuqzJosgC8AQ+lM8CAvuJHwvkBy2xoT/UvhjvbazNg3AcgA8ZFajxHNGEwQOOUCOjcLo
         uUpX8+CC0pHTRvf6bSLnnegGZk0viUTAFeWhI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:cc
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=TzbE6LrxLGd25icZNcr7R2+CvKi3HvY1I38go+A10z+z4vKDRZv0UZYMza/Ud282xy
         e2kave0xwfnfsKn8TCMWhiPTaYDoftXcfWsA9W3vltvxjgYQZ5UnlwDHIphoErPnDa3c
         rh6A/S0JUGWiF5MxokX6TkuDykXlQf4P7gIZg=
Received: by 10.210.53.1 with SMTP id b1mr35337eba.20.1249681603082;
        Fri, 07 Aug 2009 14:46:43 -0700 (PDT)
Received: from lenovo.mimichou.home (home.mimichou.net [82.67.132.19])
        by mx.google.com with ESMTPS id 28sm4249990eye.34.2009.08.07.14.46.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 Aug 2009 14:46:42 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Fri, 7 Aug 2009 23:46:40 +0200
Subject: [PATCH 3/8] bcm63xx: register GPIO-connected LEDs for known references designs
MIME-Version: 1.0
X-UID:	1180
X-Length: 6287
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Maxime Bizon <mbizon@freebox.fr>, linux-mips@linux-mips.org
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200908072346.41096.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23855
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch makes the board code register GPIO-connected LEDs for which
we know the mapping since they are reference designs.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index 668abdb..8bc4966 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -51,6 +51,36 @@ static struct board_info __initdata board_96348r = {
 		.has_phy		= 1,
 		.use_internal_phy	= 1,
 	},
+
+	.leds = {
+		{
+			.name		= "adsl-fail",
+			.gpio		= 2,
+			.active_low	= 1,
+		},
+		{
+			.name		= "ppp",
+			.gpio		= 3,
+			.active_low	= 1,
+		},
+		{
+			.name		= "ppp-fail",
+			.gpio		= 4,
+			.active_low	= 1,
+		},
+		{
+			.name		= "power",
+			.gpio		= 0,
+			.active_low	= 1,
+			.default_trigger = "default-on",
+
+		},
+		{
+			.name		= "stop",
+			.gpio		= 1,
+			.active_low	= 1,
+		},
+	},
 };
 
 static struct board_info __initdata board_96348gw_10 = {
@@ -81,6 +111,35 @@ static struct board_info __initdata board_96348gw_10 = {
 		.cs			= 2,
 		.ext_irq		= 2,
 	},
+
+	.leds = {
+		{
+			.name		= "adsl-fail",
+			.gpio		= 2,
+			.active_low	= 1,
+		},
+		{
+			.name		= "ppp",
+			.gpio		= 3,
+			.active_low	= 1,
+		},
+		{
+			.name		= "ppp-fail",
+			.gpio		= 4,
+			.active_low	= 1,
+		},
+		{
+			.name		= "power",
+			.gpio		= 0,
+			.active_low	= 1,
+			.default_trigger = "default-on",
+		},
+		{
+			.name		= "stop",
+			.gpio		= 1,
+			.active_low	= 1,
+		},
+	},
 };
 
 static struct board_info __initdata board_96348gw_11 = {
@@ -105,6 +164,35 @@ static struct board_info __initdata board_96348gw_11 = {
 	.has_ohci0 = 1,
 	.has_pccard = 1,
 	.has_ehci0 = 1,
+
+	.leds = {
+		{
+			.name		= "adsl-fail",
+			.gpio		= 2,
+			.active_low	= 1,
+		},
+		{
+			.name		= "ppp",
+			.gpio		= 3,
+			.active_low	= 1,
+		},
+		{
+			.name		= "ppp-fail",
+			.gpio		= 4,
+			.active_low	= 1,
+		},
+		{
+			.name		= "power",
+			.gpio		= 0,
+			.active_low	= 1,
+			.default_trigger = "default-on",
+		},
+		{
+			.name		= "stop",
+			.gpio		= 1,
+			.active_low	= 1,
+		},
+	},
 };
 
 static struct board_info __initdata board_96348gw = {
@@ -133,6 +221,35 @@ static struct board_info __initdata board_96348gw = {
 		.ext_irq		= 2,
 		.cs			= 2,
 	},
+
+	.leds = {
+		{
+			.name		= "adsl-fail",
+			.gpio		= 2,
+			.active_low	= 1,
+		},
+		{
+			.name		= "ppp",
+			.gpio		= 3,
+			.active_low	= 1,
+		},
+		{
+			.name		= "ppp-fail",
+			.gpio		= 4,
+			.active_low	= 1,
+		},
+		{
+			.name		= "power",
+			.gpio		= 0,
+			.active_low	= 1,
+			.default_trigger = "default-on",
+		},
+		{
+			.name		= "stop",
+			.gpio		= 1,
+			.active_low	= 1,
+		},
+	},
 };
 
 static struct board_info __initdata board_FAST2404 = {
@@ -225,6 +342,33 @@ static struct board_info __initdata board_96358vw = {
 	.has_ohci0 = 1,
 	.has_pccard = 1,
 	.has_ehci0 = 1,
+
+	.leds = {
+		{
+			.name		= "adsl-fail",
+			.gpio		= 15,
+			.active_low	= 1,
+		},
+		{
+			.name		= "ppp",
+			.gpio		= 22,
+			.active_low	= 1,
+		},
+		{
+			.name		= "ppp-fail",
+			.gpio		= 23,
+			.active_low	= 1,
+		},
+		{
+			.name		= "power",
+			.gpio		= 4,
+			.default_trigger = "default-on",
+		},
+		{
+			.name		= "stop",
+			.gpio		= 5,
+		},
+	},
 };
 
 static struct board_info __initdata board_96358vw2 = {
@@ -249,6 +393,29 @@ static struct board_info __initdata board_96358vw2 = {
 	.has_ohci0 = 1,
 	.has_pccard = 1,
 	.has_ehci0 = 1,
+
+	.leds = {
+		{
+			.name		= "adsl",
+			.gpio		= 22,
+			.active_low	= 1,
+		},
+		{
+			.name		= "ppp-fail",
+			.gpio		= 23,
+		},
+		{
+			.name		= "power",
+			.gpio		= 5,
+			.active_low	= 1,
+			.default_trigger = "default-on",
+		},
+		{
+			.name		= "stop",
+			.gpio		= 4,
+			.active_low	= 1,
+		},
+	},
 };
 
 static struct board_info __initdata board_AGPFS0 = {
@@ -505,6 +672,14 @@ static struct ssb_sprom bcm63xx_sprom = {
 };
 #endif
 
+static struct gpio_led_platform_data bcm63xx_led_data;
+
+static struct platform_device bcm63xx_gpio_leds = {
+	.name			= "leds-gpio",
+	.id			= 0,
+	.dev.platform_data	= &bcm63xx_led_data,
+};
+
 /*
  * third stage init callback, register all board devices.
  */
@@ -553,6 +728,11 @@ int __init board_register_devices(void)
 
 	platform_device_register(&mtd_dev);
 
+	bcm63xx_led_data.num_leds = ARRAY_SIZE(board.leds);
+	bcm63xx_led_data.leds = board.leds;
+
+	platform_device_register(&bcm63xx_gpio_leds);
+
 	return 0;
 }
 
diff --git a/arch/mips/include/asm/mach-bcm63xx/board_bcm963xx.h b/arch/mips/include/asm/mach-bcm63xx/board_bcm963xx.h
index 9fde025..6479090 100644
--- a/arch/mips/include/asm/mach-bcm63xx/board_bcm963xx.h
+++ b/arch/mips/include/asm/mach-bcm63xx/board_bcm963xx.h
@@ -2,6 +2,8 @@
 #define BOARD_BCM963XX_H_
 
 #include <linux/types.h>
+#include <linux/gpio.h>
+#include <linux/leds.h>
 #include <bcm63xx_dev_enet.h>
 #include <bcm63xx_dev_dsp.h>
 
@@ -50,6 +52,9 @@ struct board_info {
 
 	/* DSP config */
 	struct bcm63xx_dsp_platform_data dsp;
+
+	/* GPIO LEDs */
+	struct gpio_led leds[5];
 };
 
 #endif /* ! BOARD_BCM963XX_H_ */
