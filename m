Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Sep 2007 15:13:59 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:51784 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022010AbXITOMy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 20 Sep 2007 15:12:54 +0100
Received: by mo.po.2iij.net (mo30) id l8KEBbfF024984; Thu, 20 Sep 2007 23:11:37 +0900 (JST)
Received: from localhost.localdomain (221.25.30.125.dy.iij4u.or.jp [125.30.25.221])
	by mbox.po.2iij.net (po-mbox300) id l8KEBWOq023086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 20 Sep 2007 23:11:33 +0900
Date:	Thu, 20 Sep 2007 23:05:13 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, Richard Purdie <rpurdie@rpsys.net>,
	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][3/6]led: add Cobalt Raq LEDs platform register
Message-Id: <20070920230513.1dbb1d6d.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20070920230322.6600dd83.yoichi_yuasa@tripeaks.co.jp>
References: <20070920230204.0ad15513.yoichi_yuasa@tripeaks.co.jp>
	<20070920230322.6600dd83.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16578
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips


Add Cobalt Raq LED platform register and power off trigger.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/Makefile mips/arch/mips/cobalt/Makefile
--- mips-orig/arch/mips/cobalt/Makefile	2007-09-20 10:17:53.325755750 +0900
+++ mips/arch/mips/cobalt/Makefile	2007-09-20 10:27:39.366381000 +0900
@@ -2,7 +2,7 @@
 # Makefile for the Cobalt micro systems family specific parts of the kernel
 #
 
-obj-y := buttons.o irq.o reset.o rtc.o serial.o setup.o
+obj-y := buttons.o irq.o led.o reset.o rtc.o serial.o setup.o
 
 obj-$(CONFIG_PCI)		+= pci.o
 obj-$(CONFIG_EARLY_PRINTK)	+= console.o
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/led.c mips/arch/mips/cobalt/led.c
--- mips-orig/arch/mips/cobalt/led.c	1970-01-01 09:00:00.000000000 +0900
+++ mips/arch/mips/cobalt/led.c	2007-09-20 10:27:39.370381250 +0900
@@ -0,0 +1,56 @@
+/*
+ *  Registration of Cobalt LED platform device.
+ *
+ *  Copyright (C) 2007  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/platform_device.h>
+
+static struct resource cobalt_led_resource __initdata = {
+	.start	= 0x1c000000,
+	.end	= 0x1c000000,
+	.flags	= IORESOURCE_MEM,
+};
+
+static __init int cobalt_led_add(void)
+{
+	struct platform_device *pdev;
+	int retval;
+
+	pdev = platform_device_alloc("Cobalt Raq LEDs", -1);
+
+	if (!pdev)
+		return -ENOMEM;
+
+	retval = platform_device_add_resources(pdev, &cobalt_led_resource, 1);
+	if (retval)
+		goto err_free_device;
+
+	retval = platform_device_add(pdev);
+	if (retval)
+		goto err_free_device;
+
+	return 0;
+
+err_free_device:
+	platform_device_put(pdev);
+
+	return retval;
+}
+device_initcall(cobalt_led_add);
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/reset.c mips/arch/mips/cobalt/reset.c
--- mips-orig/arch/mips/cobalt/reset.c	2007-09-20 10:17:53.349757250 +0900
+++ mips/arch/mips/cobalt/reset.c	2007-09-20 14:13:09.917504000 +0900
@@ -8,31 +8,37 @@
  * Copyright (C) 1995, 1996, 1997 by Ralf Baechle
  * Copyright (C) 2001 by Liam Davies (ldavies@agile.tv)
  */
+#include <linux/init.h>
 #include <linux/jiffies.h>
-
-#include <asm/io.h>
-#include <asm/reboot.h>
+#include <linux/leds.h>
 
 #include <cobalt.h>
 
+DEFINE_LED_TRIGGER(power_off_led_trigger);
+
+static int __init ledtrig_power_off_init(void)
+{
+	led_trigger_register_simple("power-off", &power_off_led_trigger);
+	return 0;
+}
+device_initcall(ledtrig_power_off_init);
+
 void cobalt_machine_halt(void)
 {
 	int state, last, diff;
 	unsigned long mark;
 
 	/*
-	 * turn off bar on Qube, flash power off LED on RaQ (0.5Hz)
+	 * turn on power off LED on RaQ
 	 *
 	 * restart if ENTER and SELECT are pressed
 	 */
 
 	last = COBALT_KEY_PORT;
 
-	for (state = 0;;) {
-
-		state ^= COBALT_LED_POWER_OFF;
-		COBALT_LED_PORT = state;
+	led_trigger_event(power_off_led_trigger, LED_FULL);
 
+	for (state = 0;;) {
 		diff = COBALT_KEY_PORT ^ last;
 		last ^= diff;
 
