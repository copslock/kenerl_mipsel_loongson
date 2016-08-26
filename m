Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2016 16:22:41 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:46841 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992478AbcHZOVBYzhVn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Aug 2016 16:21:01 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id E7EEE2720D208;
        Fri, 26 Aug 2016 15:20:40 +0100 (IST)
Received: from localhost (10.100.200.141) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 26 Aug
 2016 15:20:43 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>, <devicetree@vger.kernel.org>,
        Jacek Anaszewski <j.anaszewski@samsung.com>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 09/19] MIPS: SEAD3: Use register-bit-led driver via DT for LEDs
Date:   Fri, 26 Aug 2016 15:17:41 +0100
Message-ID: <20160826141751.13121-10-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160826141751.13121-1-paul.burton@imgtec.com>
References: <20160826141751.13121-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.141]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54772
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Probe a driver for the PLED & FLED LEDs found on the SEAD3 board using
the register-bit-led driver via device tree, rather than a custom driver
via platform code. Enable support for the register-bit-led driver & its
prerequisite syscon in sead3_defconfig.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

Changes in v2: None

 arch/mips/boot/dts/mti/sead3.dts     | 103 +++++++++++++++++++++++++++++++++++
 arch/mips/configs/sead3_defconfig    |   2 +
 arch/mips/mti-sead3/Makefile         |   1 -
 arch/mips/mti-sead3/sead3-platform.c |  91 -------------------------------
 4 files changed, 105 insertions(+), 92 deletions(-)
 delete mode 100644 arch/mips/mti-sead3/sead3-platform.c

diff --git a/arch/mips/boot/dts/mti/sead3.dts b/arch/mips/boot/dts/mti/sead3.dts
index 8844cc0..0159450 100644
--- a/arch/mips/boot/dts/mti/sead3.dts
+++ b/arch/mips/boot/dts/mti/sead3.dts
@@ -93,6 +93,109 @@
 		};
 	};
 
+	system-controller@1f000200 {
+		compatible = "mti,sead3-cpld", "syscon", "simple-mfd";
+		reg = <0x1f000200 0x300>;
+
+		led@10.0 {
+			compatible = "register-bit-led";
+			offset = <0x10>;
+			mask = <0x1>;
+			label = "pled0";
+		};
+		led@10.1 {
+			compatible = "register-bit-led";
+			offset = <0x10>;
+			mask = <0x2>;
+			label = "pled1";
+		};
+		led@10.2 {
+			compatible = "register-bit-led";
+			offset = <0x10>;
+			mask = <0x4>;
+			label = "pled2";
+		};
+		led@10.3 {
+			compatible = "register-bit-led";
+			offset = <0x10>;
+			mask = <0x8>;
+			label = "pled3";
+		};
+		led@10.4 {
+			compatible = "register-bit-led";
+			offset = <0x10>;
+			mask = <0x10>;
+			label = "pled4";
+		};
+		led@10.5 {
+			compatible = "register-bit-led";
+			offset = <0x10>;
+			mask = <0x20>;
+			label = "pled5";
+		};
+		led@10.6 {
+			compatible = "register-bit-led";
+			offset = <0x10>;
+			mask = <0x40>;
+			label = "pled6";
+		};
+		led@10.7 {
+			compatible = "register-bit-led";
+			offset = <0x10>;
+			mask = <0x80>;
+			label = "pled7";
+		};
+
+		led@18.0 {
+			compatible = "register-bit-led";
+			offset = <0x18>;
+			mask = <0x1>;
+			label = "fled0";
+		};
+		led@18.1 {
+			compatible = "register-bit-led";
+			offset = <0x18>;
+			mask = <0x2>;
+			label = "fled1";
+		};
+		led@18.2 {
+			compatible = "register-bit-led";
+			offset = <0x18>;
+			mask = <0x4>;
+			label = "fled2";
+		};
+		led@18.3 {
+			compatible = "register-bit-led";
+			offset = <0x18>;
+			mask = <0x8>;
+			label = "fled3";
+		};
+		led@18.4 {
+			compatible = "register-bit-led";
+			offset = <0x18>;
+			mask = <0x10>;
+			label = "fled4";
+		};
+		led@18.5 {
+			compatible = "register-bit-led";
+			offset = <0x18>;
+			mask = <0x20>;
+			label = "fled5";
+		};
+		led@18.6 {
+			compatible = "register-bit-led";
+			offset = <0x18>;
+			mask = <0x40>;
+			label = "fled6";
+		};
+		led@18.7 {
+			compatible = "register-bit-led";
+			offset = <0x18>;
+			mask = <0x80>;
+			label = "fled7";
+		};
+	};
+
 	/* UART connected to FTDI & miniUSB socket */
 	uart0: uart@1f000900 {
 		compatible = "ns16550a";
diff --git a/arch/mips/configs/sead3_defconfig b/arch/mips/configs/sead3_defconfig
index 23cce81..e1c6582 100644
--- a/arch/mips/configs/sead3_defconfig
+++ b/arch/mips/configs/sead3_defconfig
@@ -81,6 +81,7 @@ CONFIG_I2C_CHARDEV=y
 # CONFIG_I2C_HELPER_AUTO is not set
 CONFIG_SPI=y
 CONFIG_SENSORS_ADT7475=y
+CONFIG_MFD_SYSCON=y
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
 CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_BACKLIGHT_CLASS_DEVICE=y
@@ -95,6 +96,7 @@ CONFIG_MMC_DEBUG=y
 CONFIG_MMC_SPI=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_SYSCON=y
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_RTC_CLASS=y
diff --git a/arch/mips/mti-sead3/Makefile b/arch/mips/mti-sead3/Makefile
index a58b6d9..04ea002 100644
--- a/arch/mips/mti-sead3/Makefile
+++ b/arch/mips/mti-sead3/Makefile
@@ -13,7 +13,6 @@ obj-y += sead3-display.o
 obj-y += sead3-dtshim.o
 obj-y += sead3-init.o
 obj-y += sead3-int.o
-obj-y += sead3-platform.o
 obj-y += sead3-reset.o
 obj-y += sead3-setup.o
 obj-y += sead3-time.o
diff --git a/arch/mips/mti-sead3/sead3-platform.c b/arch/mips/mti-sead3/sead3-platform.c
deleted file mode 100644
index 5c1f42a..0000000
--- a/arch/mips/mti-sead3/sead3-platform.c
+++ /dev/null
@@ -1,91 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
- */
-#include <linux/dma-mapping.h>
-#include <linux/init.h>
-#include <linux/leds.h>
-#include <linux/platform_device.h>
-
-#define LEDFLAGS(bits, shift)		\
-	((bits << 8) | (shift << 8))
-
-#define LEDBITS(id, shift, bits)	\
-	.name = id #shift,		\
-	.flags = LEDFLAGS(bits, shift)
-
-static struct led_info led_data_info[] = {
-	{ LEDBITS("bit", 0, 1) },
-	{ LEDBITS("bit", 1, 1) },
-	{ LEDBITS("bit", 2, 1) },
-	{ LEDBITS("bit", 3, 1) },
-	{ LEDBITS("bit", 4, 1) },
-	{ LEDBITS("bit", 5, 1) },
-	{ LEDBITS("bit", 6, 1) },
-	{ LEDBITS("bit", 7, 1) },
-	{ LEDBITS("all", 0, 8) },
-};
-
-static struct led_platform_data led_data = {
-	.num_leds	= ARRAY_SIZE(led_data_info),
-	.leds		= led_data_info
-};
-
-static struct resource pled_resources[] = {
-	{
-		.start	= 0x1f000210,
-		.end	= 0x1f000217,
-		.flags	= IORESOURCE_MEM
-	}
-};
-
-static struct platform_device pled_device = {
-	.name			= "sead3::pled",
-	.id			= 0,
-	.dev			= {
-		.platform_data	= &led_data,
-	},
-	.num_resources		= ARRAY_SIZE(pled_resources),
-	.resource		= pled_resources
-};
-
-
-static struct resource fled_resources[] = {
-	{
-		.start			= 0x1f000218,
-		.end			= 0x1f00021f,
-		.flags			= IORESOURCE_MEM
-	}
-};
-
-static struct platform_device fled_device = {
-	.name			= "sead3::fled",
-	.id			= 0,
-	.dev			= {
-		.platform_data	= &led_data,
-	},
-	.num_resources		= ARRAY_SIZE(fled_resources),
-	.resource		= fled_resources
-};
-
-static struct platform_device sead3_led_device = {
-        .name   = "sead3-led",
-        .id     = -1,
-};
-
-static struct platform_device *sead3_platform_devices[] __initdata = {
-	&pled_device,
-	&fled_device,
-	&sead3_led_device,
-};
-
-static int __init sead3_platforms_device_init(void)
-{
-	return platform_add_devices(sead3_platform_devices,
-				    ARRAY_SIZE(sead3_platform_devices));
-}
-
-device_initcall(sead3_platforms_device_init);
-- 
2.9.3
