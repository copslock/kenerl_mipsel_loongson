Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Jan 2008 18:03:56 +0000 (GMT)
Received: from mx1.minet.net ([157.159.40.25]:31981 "EHLO mx1.minet.net")
	by ftp.linux-mips.org with ESMTP id S28574423AbYAGSDs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 7 Jan 2008 18:03:48 +0000
Received: from localhost (unknown [192.168.1.97])
	by mx1.minet.net (Postfix) with ESMTP id 4B0C45CD24
	for <linux-mips@linux-mips.org>; Mon,  7 Jan 2008 19:03:44 +0100 (CET)
X-Virus-Scanned: by amavisd-new using ClamAV at minet.net
Received: from smtp.minet.net (imap.minet.net [192.168.1.27])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.minet.net (Postfix) with ESMTP id 3FDFA5CD1E
	for <linux-mips@linux-mips.org>; Mon,  7 Jan 2008 19:03:27 +0100 (CET)
Received: from ibook.lan (fbx.tmplab.org [82.228.39.231])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: florian)
	by smtp.minet.net (Postfix) with ESMTP id 456F343BC
	for <linux-mips@linux-mips.org>; Mon,  7 Jan 2008 08:21:23 +0100 (CET)
From:	Florian Fainelli <florian.fainelli@telecomint.eu>
Date:	Mon, 7 Jan 2008 19:00:46 +0100
Subject: [PATCH] Add GPIO system button to MTX-1
MIME-Version: 1.0
X-UID:	154
X-Length: 2554
To:	linux-mips@linux-mips.org
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200801071900.46831.florian.fainelli@telecomint.eu>
Return-Path: <florian.fainelli@telecomint.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17948
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@telecomint.eu
Precedence: bulk
X-list: linux-mips

This patch adds support for the GPIO connected system button on the MTX-1 boards. Default configuration is updated accordingly.

Signed-off-by: Florian Fainelli <florian.fainelli@telecomint.eu>
---
diff --git a/arch/mips/au1000/mtx-1/platform.c b/arch/mips/au1000/mtx-1/platform.c
index 49c0fb4..ce8637b 100644
--- a/arch/mips/au1000/mtx-1/platform.c
+++ b/arch/mips/au1000/mtx-1/platform.c
@@ -22,9 +22,32 @@
 #include <linux/types.h>
 #include <linux/platform_device.h>
 #include <linux/leds.h>
+#include <linux/gpio_keys.h>
+#include <linux/input.h>
 
 #include <asm/gpio.h>
 
+static struct gpio_keys_button mtx1_gpio_button[] = {
+	{
+		.gpio = 207,
+		.code = BTN_0,
+		.desc = "System button",
+	}
+};
+
+static struct gpio_keys_platform_data mtx1_buttons_data = {
+	.buttons = mtx1_gpio_button,
+	.nbuttons = ARRAY_SIZE(mtx1_gpio_button),
+};
+
+static struct platform_device mtx1_button = {
+	.name = "gpio-keys",
+	.id = -1,
+	.dev = {
+		.platform_data = &mtx1_buttons_data,
+	}
+};
+
 static struct resource mtx1_wdt_res[] = {
 	[0] = {
 		.start	= 15,
@@ -66,11 +89,13 @@ static struct platform_device mtx1_gpio_leds = {
 
 static struct __initdata platform_device * mtx1_devs[] = {
 	&mtx1_gpio_leds,
-	&mtx1_wdt
+	&mtx1_wdt,
+	&mtx1_button
 };
 
 static int __init mtx1_register_devices(void)
 {
+	gpio_direction_input(207);
 	return platform_add_devices(mtx1_devs, ARRAY_SIZE(mtx1_devs));
 }
 
diff --git a/arch/mips/configs/mtx1_defconfig b/arch/mips/configs/mtx1_defconfig
index b536d7c..c20b560 100644
--- a/arch/mips/configs/mtx1_defconfig
+++ b/arch/mips/configs/mtx1_defconfig
@@ -1617,6 +1617,7 @@ CONFIG_INPUT_EVBUG=m
 #
 CONFIG_INPUT_KEYBOARD=y
 CONFIG_KEYBOARD_ATKBD=y
+CONFIG_KEYBOARD_GPIO=y
 CONFIG_KEYBOARD_SUNKBD=m
 CONFIG_KEYBOARD_LKKBD=m
 CONFIG_KEYBOARD_XTKBD=m
