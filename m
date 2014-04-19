Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Apr 2014 00:59:20 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:54646 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6821198AbaDSW7Q1bG4J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 20 Apr 2014 00:59:16 +0200
Date:   Sat, 19 Apr 2014 23:59:16 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Alessandro Zummo <a.zummo@towertech.it>
cc:     linux-mips@linux-mips.org, rtc-linux@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] DEC: Switch DECstation systems to rtc-cmos
In-Reply-To: <alpine.LFD.2.11.1404192224250.11598@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1404192338050.11598@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1404192224250.11598@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39870
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

This adds an RTC platform device for DECstation systems so that they can 
use the rtc-cmos driver for their RTC device.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
Ralf,

 This part requires the other change or it won't build at all, so it can't 
be pushed to the LMO tree by itself.  I'm not sure which route, either RTC 
or LMO, will be the best for upstreaming this patch pair, but surely the 
rtc-cmos part will have to be reviewed first.

  Maciej

linux-dec-rtc.patch
Index: linux-20140404-3maxp/arch/mips/dec/Makefile
===================================================================
--- linux-20140404-3maxp.orig/arch/mips/dec/Makefile
+++ linux-20140404-3maxp/arch/mips/dec/Makefile
@@ -3,7 +3,7 @@
 #
 
 obj-y		:= ecc-berr.o int-handler.o ioasic-irq.o kn01-berr.o \
-		   kn02-irq.o kn02xa-berr.o reset.o setup.o time.o
+		   kn02-irq.o kn02xa-berr.o platform.o reset.o setup.o time.o
 
 obj-$(CONFIG_TC)		+= tc.o
 obj-$(CONFIG_CPU_HAS_WB)	+= wbflush.o
Index: linux-20140404-3maxp/arch/mips/dec/platform.c
===================================================================
--- /dev/null
+++ linux-20140404-3maxp/arch/mips/dec/platform.c
@@ -0,0 +1,44 @@
+/*
+ *	DEC platform devices.
+ *
+ *	Copyright (c) 2014  Maciej W. Rozycki
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/mc146818rtc.h>
+#include <linux/platform_device.h>
+
+static struct resource dec_rtc_resources[] = {
+	{
+		.name = "rtc",
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+static struct cmos_rtc_board_info dec_rtc_info = {
+	.flags = CMOS_RTC_FLAGS_NOFREQ,
+	.address_space = 64,
+};
+
+static struct platform_device dec_rtc_device = {
+	.name = "rtc_cmos",
+	.id = PLATFORM_DEVID_NONE,
+	.dev.platform_data = &dec_rtc_info,
+	.resource = dec_rtc_resources,
+	.num_resources = ARRAY_SIZE(dec_rtc_resources),
+};
+
+static int __init dec_add_devices(void)
+{
+	dec_rtc_resources[0].start = RTC_PORT(0);
+	dec_rtc_resources[0].end = RTC_PORT(0) + dec_kn_slot_size - 1;
+	return platform_device_register(&dec_rtc_device);
+}
+
+device_initcall(dec_add_devices);
