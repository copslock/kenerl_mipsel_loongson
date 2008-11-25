Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2008 08:32:12 +0000 (GMT)
Received: from mail.windriver.com ([147.11.1.11]:26325 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S23901478AbYKYIcB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 25 Nov 2008 08:32:01 +0000
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id mAP8VroU020053;
	Tue, 25 Nov 2008 00:31:53 -0800 (PST)
Received: from localhost.localdomain ([128.224.162.71]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 25 Nov 2008 00:31:52 -0800
From:	Tiejun Chen <tiejun.chen@windriver.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:	Tiejun Chen <tiejun.chen@windriver.com>
Subject: [PATCH v2] Support RTC on Malta
Date:	Tue, 25 Nov 2008 16:33:20 +0800
Message-Id: <1227602000-11618-1-git-send-email-tiejun.chen@windriver.com>
X-Mailer: git-send-email 1.5.5.1
X-OriginalArrivalTime: 25 Nov 2008 08:31:52.0711 (UTC) FILETIME=[44924970:01C94ED8]
Return-Path: <Tiejun.Chen@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21413
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiejun.chen@windriver.com
Precedence: bulk
X-list: linux-mips

To create platform device for RTC to call platform driver successfully.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
 arch/mips/configs/malta_defconfig    |    8 ++++-
 arch/mips/mti-malta/malta-platform.c |   47 +++++++++++++++++++++++++++++----
 2 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_defconfig
index 74daa0c..aec64d0 100644
--- a/arch/mips/configs/malta_defconfig
+++ b/arch/mips/configs/malta_defconfig
@@ -1126,7 +1126,6 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_IPMI_HANDLER is not set
 # CONFIG_WATCHDOG is not set
 CONFIG_HW_RANDOM=m
-CONFIG_RTC=y
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
 # CONFIG_DRM is not set
@@ -1199,7 +1198,12 @@ CONFIG_USB_ARCH_HAS_EHCI=y
 # CONFIG_MMC is not set
 # CONFIG_NEW_LEDS is not set
 # CONFIG_INFINIBAND is not set
-# CONFIG_RTC_CLASS is not set
+CONFIG_RTC_CLASS=y
+
+#
+# Platform RTC drivers
+#
+CONFIG_RTC_DRV_CMOS=y
 
 #
 # DMA Engine support
diff --git a/arch/mips/mti-malta/malta-platform.c b/arch/mips/mti-malta/malta-platform.c
index 83b9bab..039e6e6 100644
--- a/arch/mips/mti-malta/malta-platform.c
+++ b/arch/mips/mti-malta/malta-platform.c
@@ -6,7 +6,10 @@
  * Copyright (C) 2007 MIPS Technologies, Inc.
  *   written by Ralf Baechle (ralf@linux-mips.org)
  *
- * Probe driver for the Malta's UART ports:
+ * Copyright (C) 2008 Wind River Systems, Inc. 
+ *   updated by Tiejun Chen <tiejun.chen@windriver.com> 
+ *
+ * 1. Probe driver for the Malta's UART ports:
  *
  *   o 2 ports in the SMC SuperIO
  *   o 1 port in the CBUS UART, a discrete 16550 which normally is only used
@@ -14,10 +17,14 @@
  *
  * We don't use 8250_platform.c on Malta as it would result in the CBUS
  * UART becoming ttyS0.
+ *
+ * 2. Register RTC-CMOS platform device on Malta.
  */
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/serial_8250.h>
+#include <linux/mc146818rtc.h>
+#include <linux/platform_device.h>
 
 #define SMC_PORT(base, int)						\
 {									\
@@ -53,13 +60,41 @@ static struct platform_device uart8250_device = {
 	},
 };
 
-static int __init uart8250_init(void)
+static int __init malta_uart8250_init(void)
 {
 	return platform_device_register(&uart8250_device);
 }
 
-module_init(uart8250_init);
+struct resource malta_rtc_resource[] = {
+	{
+		.start	= RTC_PORT(0),			
+		.end	= RTC_PORT(7),
+		.flags	= IORESOURCE_IO,
+	}, {
+		.start	= RTC_IRQ,
+		.end	= RTC_IRQ,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+static int __init malta_rtc_init(void)
+{
+	struct platform_device *pd;
+	
+	pd = platform_device_register_simple("rtc_cmos", -1, malta_rtc_resource, 
+						ARRAY_SIZE(malta_rtc_resource));
+
+	if (IS_ERR(pd))
+		return PTR_ERR(pd);
+	
+	/* Try setting rtc as BCD mode to support
+	 * current alarm code if possible.
+	 */
+	if (!RTC_ALWAYS_BCD)
+		CMOS_WRITE(CMOS_READ(RTC_CONTROL) & ~RTC_DM_BINARY, RTC_CONTROL);
+
+	return 0;
+}
 
-MODULE_AUTHOR("Ralf Baechle <ralf@linux-mips.org>");
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("8250 UART probe driver for the Malta CBUS UART");
+device_initcall(malta_rtc_init);
+device_initcall(malta_uart8250_init);
-- 
1.5.5.1
