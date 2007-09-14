Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2007 09:16:40 +0100 (BST)
Received: from mo31.po.2iij.NET ([210.128.50.54]:39201 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20021592AbXINIPi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 14 Sep 2007 09:15:38 +0100
Received: by mo.po.2iij.net (mo31) id l8E8FYan052234; Fri, 14 Sep 2007 17:15:34 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox301) id l8E8FX6j010275
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 14 Sep 2007 17:15:33 +0900
Message-Id: <200709140815.l8E8FX6j010275@po-mbox301.hop.2iij.net>
Date:	Fri, 14 Sep 2007 17:14:44 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][6/9][MIPS] add Cobalt Raq LED platform register
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16515
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Add Cobalt Raq LED platform register.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/Makefile mips/arch/mips/cobalt/Makefile
--- mips-orig/arch/mips/cobalt/Makefile	2007-08-24 19:30:37.053924000 +0900
+++ mips/arch/mips/cobalt/Makefile	2007-08-24 19:27:44.127116750 +0900
@@ -2,7 +2,7 @@
 # Makefile for the Cobalt micro systems family specific parts of the kernel
 #
 
-obj-y := buttons.o irq.o reset.o rtc.o serial.o setup.o
+obj-y := buttons.o irq.o led.o reset.o rtc.o serial.o setup.o
 
 obj-$(CONFIG_PCI)		+= pci.o
 obj-$(CONFIG_EARLY_PRINTK)	+= console.o
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/led.c mips/arch/mips/cobalt/led.c
--- mips-orig/arch/mips/cobalt/led.c	1970-01-01 09:00:00.000000000 +0900
+++ mips/arch/mips/cobalt/led.c	2007-08-24 19:28:13.988983000 +0900
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
--- mips-orig/arch/mips/cobalt/reset.c	2007-08-24 19:30:37.077925500 +0900
+++ mips/arch/mips/cobalt/reset.c	2007-08-24 19:28:12.304877750 +0900
@@ -8,17 +8,29 @@
  * Copyright (C) 1995, 1996, 1997 by Ralf Baechle
  * Copyright (C) 2001 by Liam Davies (ldavies@agile.tv)
  */
+#include <linux/init.h>
 #include <linux/irqflags.h>
 #include <linux/kernel.h>
+#include <linux/leds.h>
 
 #include <asm/processor.h>
 
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
 	local_irq_disable();
 	printk("You can switch the machine off now.\n");
+	led_trigger_event(power_off_led_trigger, LED_FULL);
 	while (1) {
 		if (cpu_wait)
 			cpu_wait();
