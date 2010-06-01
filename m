Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jun 2010 08:31:39 +0200 (CEST)
Received: from mx1.moondrake.net ([212.85.150.166]:45806 "EHLO
        mx1.mandriva.com" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S1492537Ab0FBGbb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Jun 2010 08:31:31 +0200
Received: by mx1.mandriva.com (Postfix, from userid 501)
        id 4119B274015; Wed,  2 Jun 2010 08:31:11 +0200 (CEST)
Received: from office-abk.mandriva.com (unknown [195.7.104.248])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.mandriva.com (Postfix) with ESMTP id 1ACFF274012;
        Wed,  2 Jun 2010 08:31:08 +0200 (CEST)
Received: from anduin.mandriva.com (fw2.mandriva.com [192.168.2.3])
        by office-abk.mandriva.com (Postfix) with ESMTP id F247F8499D;
        Wed,  2 Jun 2010 08:50:20 +0200 (CEST)
Received: by anduin.mandriva.com (Postfix, from userid 500)
        id D2FE4FF855; Wed,  2 Jun 2010 08:31:17 +0200 (CEST)
Message-Id: <20100601224232.291773884@n5.mandriva.com>
User-Agent: quilt/0.48-1
Date:   Wed, 02 Jun 2010 00:39:54 +0200
From:   apatard@mandriva.com
To:     linux-mips@linux-mips.org
Cc:     aba@not.so.argh.org
Subject: [patch 1/1] Loongson: define rtc device on mc146818 compatible systems
References: <20100601223953.165137063@n5.mandriva.com>
Content-Disposition: inline; filename=lm2e_rtc.patch
X-archive-position: 26983
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: apatard@mandriva.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 1040

This patch declare the rtc device present on systems with clock compatible with
the mc146818 and handled by rtc-cmos. I've introduced a new Kconfig entry because
there are some systems without rtc-cmos compatible clock.

Signed-off-by: Arnaud Patard <apatard@mandriva.com>

---
 arch/mips/loongson/Kconfig         |    8 	8 +	0 -	0 !
 arch/mips/loongson/common/Makefile |    1 	1 +	0 -	0 !
 arch/mips/loongson/common/rtc.c    |   43 	43 +	0 -	0 !
 3 files changed, 52 insertions(+)

Index: linux-2.6/arch/mips/loongson/common/Makefile
===================================================================
--- linux-2.6.orig/arch/mips/loongson/common/Makefile
+++ linux-2.6/arch/mips/loongson/common/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_GENERIC_GPIO) += gpio.o
 obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
 obj-$(CONFIG_SERIAL_8250) += serial.o
 obj-$(CONFIG_LOONGSON_UART_BASE) += uart_base.o
+obj-$(CONFIG_LOONGSON_MC146818) += rtc.o
 
 #
 # Enable CS5536 Virtual Support Module(VSM) to virtulize the PCI configure
Index: linux-2.6/arch/mips/loongson/common/rtc.c
===================================================================
--- /dev/null
+++ linux-2.6/arch/mips/loongson/common/rtc.c
@@ -0,0 +1,43 @@
+/*
+ *  Lemote Fuloong platform support
+ *
+ *  Copyright(c) 2010 Arnaud Patard <apatard@mandriva.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/mc146818rtc.h>
+
+struct resource loongson_rtc_resources[] = {
+	{
+		.start	= RTC_PORT(0),
+		.end	= RTC_PORT(1),
+		.flags	= IORESOURCE_IO,
+	}, {
+		.start	= RTC_IRQ,
+		.end	= RTC_IRQ,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+static struct platform_device loongson_rtc_device = {
+	.name		= "rtc_cmos",
+	.id		= -1,
+	.resource	= loongson_rtc_resources,
+	.num_resources	= ARRAY_SIZE(loongson_rtc_resources),
+};
+
+
+static int __init loongson_rtc_platform_init(void)
+{
+	platform_device_register(&loongson_rtc_device);
+	return 0;
+}
+
+device_initcall(loongson_rtc_platform_init);
Index: linux-2.6/arch/mips/loongson/Kconfig
===================================================================
--- linux-2.6.orig/arch/mips/loongson/Kconfig
+++ linux-2.6/arch/mips/loongson/Kconfig
@@ -23,6 +23,7 @@ config LEMOTE_FULOONG2E
 	select GENERIC_HARDIRQS_NO__DO_IRQ
 	select GENERIC_ISA_DMA_SUPPORT_BROKEN
 	select CPU_HAS_WB
+	select LOONGSON_MC146818
 	help
 	  Lemote Fuloong(2e) mini-PC board based on the Chinese Loongson-2E CPU and
 	  an FPGA northbridge
@@ -51,6 +52,7 @@ config LEMOTE_MACH2F
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select SYS_SUPPORTS_HIGHMEM
 	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select LOONGSON_MC146818
 	help
 	  Lemote Loongson 2F family machines utilize the 2F revision of
 	  Loongson processor and the AMD CS5536 south bridge.
@@ -83,3 +85,9 @@ config LOONGSON_UART_BASE
 	bool
 	default y
 	depends on EARLY_PRINTK || SERIAL_8250
+
+config LOONGSON_MC146818
+	bool
+	default n
+
+
