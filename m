Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Sep 2007 14:43:15 +0100 (BST)
Received: from hall.aurel32.net ([88.191.38.19]:2254 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20023088AbXIYNnM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 25 Sep 2007 14:43:12 +0100
Received: from aurel32 by hall.aurel32.net with local (Exim 4.63)
	(envelope-from <aurel32@hall.aurel32.net>)
	id 1IaAgt-0003oo-Iu; Tue, 25 Sep 2007 15:43:07 +0200
Date:	Tue, 25 Sep 2007 15:43:07 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	linux-mips@linux-mips.org
Cc:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 4/4][MIPS] GPIO LED driver for the WGT634U machine
Message-ID: <20070925134307.GE14227@hall.aurel32.net>
References: <20070925133847.GA14227@hall.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20070925133847.GA14227@hall.aurel32.net>
X-Mailer: Mutt 1.5.13 (2006-08-11)
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <aurel32@hall.aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16656
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

This patch replaces commit f2a399f458d1ba88291e9748b068d932a0993dce in
order to replace BCM947XX into BCM47XX.


    [MIPS] GPIO LED driver for the WGT634U machine
    
    Add LED support to the WGT634U machine.  It uses the new gpio-led
    driver and a platform driver for the pin definitions.
    
    Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

--- a/arch/mips/bcm47xx/Makefile
+++ b/arch/mips/bcm47xx/Makefile
@@ -3,4 +3,4 @@
 # under Linux.
 #
 
-obj-y := gpio.o irq.o prom.o serial.o setup.o time.o
+obj-y := gpio.o irq.o prom.o serial.o setup.o time.o wgt634u.o
--- /dev/null
+++ b/arch/mips/bcm47xx/wgt634u.c
@@ -0,0 +1,64 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2007 Aurelien Jarno <aurelien@aurel32.net>
+ */
+
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/leds.h>
+#include <linux/ssb/ssb.h>
+#include <asm/mach-bcm47xx/bcm47xx.h>
+
+/* GPIO definitions for the WGT634U */
+#define WGT634U_GPIO_LED	3
+#define WGT634U_GPIO_RESET	2
+#define WGT634U_GPIO_TP1	7
+#define WGT634U_GPIO_TP2	6
+#define WGT634U_GPIO_TP3	5
+#define WGT634U_GPIO_TP4	4
+#define WGT634U_GPIO_TP5	1
+
+static struct gpio_led wgt634u_leds[] = {
+	{
+		.name = "power",
+		.gpio = WGT634U_GPIO_LED,
+		.active_low = 1,
+		.default_trigger = "heartbeat",
+	},
+};
+
+static struct gpio_led_platform_data wgt634u_led_data = {
+	.num_leds =     ARRAY_SIZE(wgt634u_leds),
+	.leds =         wgt634u_leds,
+};
+
+static struct platform_device wgt634u_gpio_leds = {
+	.name =         "leds-gpio",
+	.id =           -1,
+	.dev = {
+		.platform_data = &wgt634u_led_data,
+	}
+};
+
+static int __init wgt634u_init(void)
+{
+	/* There is no easy way to detect that we are running on a WGT634U
+	 * machine. Use the MAC address as an heuristic. Netgear Inc. has
+	 * been allocated ranges 00:09:5b:xx:xx:xx and 00:0f:b5:xx:xx:xx.
+	 */
+
+	u8 *et0mac = ssb_bcm47xx.sprom.r1.et0mac;
+
+	if (et0mac[0] == 0x00 &&
+	    ((et0mac[1] == 0x09 && et0mac[2] == 0x5b) ||
+	     (et0mac[1] == 0x0f && et0mac[2] == 0xb5)))
+		return platform_device_register(&wgt634u_gpio_leds);
+	else
+		return -ENODEV;
+}
+
+module_init(wgt634u_init);
+

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
