Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Jan 2011 21:30:51 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:48525 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491001Ab1ADU3I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Jan 2011 21:29:08 +0100
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id C913045C01D;
        Tue,  4 Jan 2011 21:29:03 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 60F2E1F0001;
        Tue,  4 Jan 2011 21:29:03 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Imre Kaloz <kaloz@openwrt.org>,
        "Luis R. Rodriguez" <lrodriguez@atheros.com>,
        Cliff Holden <Cliff.Holden@Atheros.com>,
        Kathy Giori <Kathy.Giori@Atheros.com>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH v5 04/16] MIPS: ath79: add initial support for the Atheros PB44 reference board
Date:   Tue,  4 Jan 2011 21:28:17 +0100
Message-Id: <1294172909-1309-5-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1294172909-1309-1-git-send-email-juhosg@openwrt.org>
References: <1294172909-1309-1-git-send-email-juhosg@openwrt.org>
X-VBMS: A108B3991A7 | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28828
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
Changes since RFC:
    - don't use 'default n' for the ATH79_MACH_PB44 Kconfig option

Changes since v1:
    - rebased against 2.6.37-rc7

Changes since v2: ---

Changes since v3:
    - rebased against 2.6.37-rc8

Changes since v4: ---

 arch/mips/ath79/Kconfig     |   11 ++++++++
 arch/mips/ath79/Makefile    |    5 ++++
 arch/mips/ath79/mach-pb44.c |   56 +++++++++++++++++++++++++++++++++++++++++++
 arch/mips/ath79/machtypes.h |    1 +
 4 files changed, 73 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/ath79/mach-pb44.c

diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
index 50b9334..fabb2b0 100644
--- a/arch/mips/ath79/Kconfig
+++ b/arch/mips/ath79/Kconfig
@@ -1,5 +1,16 @@
 if ATH79
 
+menu "Atheros AR71XX/AR724X/AR913X machine selection"
+
+config ATH79_MACH_PB44
+	bool "Atheros PB44 reference board"
+	select SOC_AR71XX
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  Atheros PB44 reference board.
+
+endmenu
+
 config SOC_AR71XX
 	def_bool n
 
diff --git a/arch/mips/ath79/Makefile b/arch/mips/ath79/Makefile
index e621d6c..c3093f7 100644
--- a/arch/mips/ath79/Makefile
+++ b/arch/mips/ath79/Makefile
@@ -16,3 +16,8 @@ obj-$(CONFIG_EARLY_PRINTK)		+= early_printk.o
 # Devices
 #
 obj-y					+= dev-common.o
+
+#
+# Machines
+#
+obj-$(CONFIG_ATH79_MACH_PB44)		+= mach-pb44.o
diff --git a/arch/mips/ath79/mach-pb44.c b/arch/mips/ath79/mach-pb44.c
new file mode 100644
index 0000000..ffc24d7
--- /dev/null
+++ b/arch/mips/ath79/mach-pb44.c
@@ -0,0 +1,56 @@
+/*
+ *  Atheros PB44 reference board support
+ *
+ *  Copyright (C) 2009-2010 Gabor Juhos <juhosg@openwrt.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/i2c.h>
+#include <linux/i2c-gpio.h>
+#include <linux/i2c/pcf857x.h>
+
+#include "machtypes.h"
+
+#define PB44_GPIO_I2C_SCL	0
+#define PB44_GPIO_I2C_SDA	1
+
+#define PB44_GPIO_EXP_BASE	16
+
+static struct i2c_gpio_platform_data pb44_i2c_gpio_data = {
+	.sda_pin        = PB44_GPIO_I2C_SDA,
+	.scl_pin        = PB44_GPIO_I2C_SCL,
+};
+
+static struct platform_device pb44_i2c_gpio_device = {
+	.name		= "i2c-gpio",
+	.id		= 0,
+	.dev = {
+		.platform_data	= &pb44_i2c_gpio_data,
+	}
+};
+
+static struct pcf857x_platform_data pb44_pcf857x_data = {
+	.gpio_base	= PB44_GPIO_EXP_BASE,
+};
+
+static struct i2c_board_info pb44_i2c_board_info[] __initdata = {
+	{
+		I2C_BOARD_INFO("pcf8575", 0x20),
+		.platform_data  = &pb44_pcf857x_data,
+	},
+};
+
+static void __init pb44_init(void)
+{
+	i2c_register_board_info(0, pb44_i2c_board_info,
+				ARRAY_SIZE(pb44_i2c_board_info));
+	platform_device_register(&pb44_i2c_gpio_device);
+}
+
+MIPS_MACHINE(ATH79_MACH_PB44, "PB44", "Atheros PB44 reference board",
+	     pb44_init);
diff --git a/arch/mips/ath79/machtypes.h b/arch/mips/ath79/machtypes.h
index fac0e26..a796fa3 100644
--- a/arch/mips/ath79/machtypes.h
+++ b/arch/mips/ath79/machtypes.h
@@ -16,6 +16,7 @@
 
 enum ath79_mach_type {
 	ATH79_MACH_GENERIC = 0,
+	ATH79_MACH_PB44,		/* Atheros PB44 reference board */
 };
 
 #endif /* _ATH79_MACHTYPE_H */
-- 
1.7.2.1
