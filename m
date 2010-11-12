Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Nov 2010 22:56:38 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:57011 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492168Ab0KLVv7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Nov 2010 22:51:59 +0100
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id F3C5A41C009;
        Fri, 12 Nov 2010 22:51:50 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 50EA1270002;
        Fri, 12 Nov 2010 22:51:50 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, "Luis R. Rodriguez" <mcgrof@gmail.com>,
        Cliff Holden <Cliff.Holden@Atheros.com>,
        Imre Kaloz <kaloz@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [RFC 08/18] MIPS: ath79: add common watchdog device
Date:   Fri, 12 Nov 2010 22:51:14 +0100
Message-Id: <1289598684-30624-9-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1289598684-30624-1-git-send-email-juhosg@openwrt.org>
References: <1289598684-30624-1-git-send-email-juhosg@openwrt.org>
X-VBMS: A1228985E73 | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28377
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips

All supported SoCs have a built-in hardware watchdog driver. This patch
registers a platform_device for that to make it usable.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
---
 arch/mips/ath79/Kconfig   |    3 +++
 arch/mips/ath79/Makefile  |    1 +
 arch/mips/ath79/dev-wdt.c |   30 ++++++++++++++++++++++++++++++
 arch/mips/ath79/dev-wdt.h |   17 +++++++++++++++++
 arch/mips/ath79/setup.c   |    2 ++
 5 files changed, 53 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/ath79/dev-wdt.c
 create mode 100644 arch/mips/ath79/dev-wdt.h

diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
index 2bd35ef..79bb528 100644
--- a/arch/mips/ath79/Kconfig
+++ b/arch/mips/ath79/Kconfig
@@ -28,4 +28,7 @@ config ATH79_DEV_LEDS_GPIO
 config ATH79_DEV_UART
 	def_bool y
 
+config ATH79_DEV_WDT
+	def_bool y
+
 endif
diff --git a/arch/mips/ath79/Makefile b/arch/mips/ath79/Makefile
index a231967..1b01868 100644
--- a/arch/mips/ath79/Makefile
+++ b/arch/mips/ath79/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_EARLY_PRINTK)		+= early_printk.o
 
 obj-$(CONFIG_ATH79_DEV_LEDS_GPIO)	+= dev-leds-gpio.o
 obj-$(CONFIG_ATH79_DEV_UART)		+= dev-uart.o
+obj-$(CONFIG_ATH79_DEV_WDT)		+= dev-wdt.o
 
 #
 # Machines
diff --git a/arch/mips/ath79/dev-wdt.c b/arch/mips/ath79/dev-wdt.c
new file mode 100644
index 0000000..ba6b8bd
--- /dev/null
+++ b/arch/mips/ath79/dev-wdt.c
@@ -0,0 +1,30 @@
+/*
+ *  Atheros AR71XX/AR724X/AR913X watchdog device
+ *
+ *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
+ *
+ *  Parts of this file are based on Atheros' 2.6.15 BSP
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+
+#include <asm/mach-ath79/ar71xx_regs.h>
+#include "common.h"
+#include "dev-wdt.h"
+
+static struct platform_device ath79_wdt_device = {
+	.name		= "ath79-wdt",
+	.id		= -1,
+};
+
+void __init ath79_register_wdt(void)
+{
+	platform_device_register(&ath79_wdt_device);
+}
diff --git a/arch/mips/ath79/dev-wdt.h b/arch/mips/ath79/dev-wdt.h
new file mode 100644
index 0000000..2546415
--- /dev/null
+++ b/arch/mips/ath79/dev-wdt.h
@@ -0,0 +1,17 @@
+/*
+ *  Atheros AR71XX/AR724X/AR913X watchdog device
+ *
+ *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ */
+
+#ifndef _ATH_DEV_WDT_H
+#define _ATH_DEV_WDT_H
+
+void ath79_register_wdt(void) __init;
+
+#endif
diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
index b36f9f2..693a9e6 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -24,6 +24,7 @@
 #include <asm/mach-ath79/ar71xx_regs.h>
 #include "common.h"
 #include "dev-uart.h"
+#include "dev-wdt.h"
 #include "machtypes.h"
 
 #define ATH79_SYS_TYPE_LEN	64
@@ -259,6 +260,7 @@ static int __init ath79_setup(void)
 {
 	ath79_gpio_init();
 	ath79_register_uart();
+	ath79_register_wdt();
 
 	mips_machine_setup();
 
-- 
1.7.2.1
