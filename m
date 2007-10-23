Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2007 17:56:13 +0100 (BST)
Received: from smtp1.int-evry.fr ([157.159.10.44]:26529 "EHLO
	smtp1.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S20031449AbXJWQ4F (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 Oct 2007 17:56:05 +0100
Received: from smtp-ext.int-evry.fr (smtp-ext.int-evry.fr [157.159.11.17])
	by smtp1.int-evry.fr (Postfix) with ESMTP id EF8428E80F0
	for <linux-mips@linux-mips.org>; Tue, 23 Oct 2007 18:55:55 +0200 (CEST)
Received: from ibook (unknown [77.192.17.88])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id A9C82D0E317
	for <linux-mips@linux-mips.org>; Tue, 23 Oct 2007 18:55:55 +0200 (CEST)
From:	Florian Fainelli <florian.fainelli@telecomint.eu>
Date:	Tue, 23 Oct 2007 18:55:55 +0200
Subject: [PATCH] [MTX1 try 2] Register platform devices
MIME-Version: 1.0
X-UID:	128
X-Length: 3832
To:	linux-mips@linux-mips.org
Content-Disposition: inline
Message-Id: <200710231855.55605.florian.fainelli@telecomint.eu>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
X-int-MailScanner-Information: Please contact the ISP for more information
X-int-MailScanner: Found to be clean
X-int-MailScanner-SpamCheck: 
X-int-MailScanner-From:	florian.fainelli@telecomint.eu
Return-Path: <florian.fainelli@telecomint.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17184
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@telecomint.eu
Precedence: bulk
X-list: linux-mips

This patch separates the platform devices registration
for the MTX-1 specific devices : GPIO leds and watchdog.

Changes from first try: Suppress whitespaces and make checkpatch happy

Signed-off-by: Florian Fainelli <florian.fainelli@telecomint.eu>
---
 arch/mips/au1000/mtx-1/Makefile   |    1 +
 arch/mips/au1000/mtx-1/platform.c |   82 
+++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/au1000/mtx-1/platform.c
---
diff --git a/arch/mips/au1000/mtx-1/Makefile b/arch/mips/au1000/mtx-1/Makefile
index 764bf9f..afa7007 100644
--- a/arch/mips/au1000/mtx-1/Makefile
+++ b/arch/mips/au1000/mtx-1/Makefile
@@ -8,3 +8,4 @@
 #
 
 lib-y := init.o board_setup.o irqmap.o
+obj-y := platform.o
diff --git a/arch/mips/au1000/mtx-1/platform.c 
b/arch/mips/au1000/mtx-1/platform.c
new file mode 100644
index 0000000..f7d84f6
--- /dev/null
+++ b/arch/mips/au1000/mtx-1/platform.c
@@ -0,0 +1,82 @@
+/*
+ * MTX-1 platform devices registration
+ *
+ * Copyright (C) 2007, Florian Fainelli <florian@openwrt.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <linux/autoconf.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/platform_device.h>
+#include <linux/leds.h>
+
+#include <asm/gpio.h>
+
+static struct resource mtx1_wdt_res[] = {
+	[0] = {
+		.start	= 15,
+		.end	= 15,
+		.name	= "mtx1-wdt-gpio",
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+static struct resource mtx1_sys_btn[] = {
+	[0] = {
+		.start	= 7,
+		.end	= 7,
+		.name	= "mtx1-sys-btn-gpio",
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+static struct platform_device mtx1_wdt = {
+	.name = "mtx1-wdt",
+	.id = 0,
+	.num_resources = ARRAY_SIZE(mtx1_wdt_res),
+	.resource = mtx1_wdt_res,
+};
+
+static struct gpio_led default_leds[] = {
+	{ .name	= "mtx1:green", .gpio = 211, },
+	{ .name = "mtx1:red", .gpio = 212, },
+};
+
+static struct gpio_led_platform_data mtx1_led_data = {
+	.num_leds = ARRAY_SIZE(default_leds),
+	.leds = default_leds,
+};
+
+static struct platform_device mtx1_gpio_leds = {
+	.name = "leds-gpio",
+	.id = -1,
+	.dev = {
+		.platform_data = &mtx1_led_data,
+	}
+};
+
+static struct __initdata platform_device * mtx1_devs[] = {
+	&mtx1_gpio_leds,
+	&mtx1_wdt
+};
+
+static int __init mtx1_register_devices(void)
+{
+	return platform_add_devices(mtx1_devs, ARRAY_SIZE(mtx1_devs));
+}
+
+arch_initcall(mtx1_register_devices);
-- 
Cordialement, Florian Fainelli
------------------------------
