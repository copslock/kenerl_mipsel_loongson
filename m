Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Jun 2017 00:00:48 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:56601 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993914AbdFBWAfEKwIF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 3 Jun 2017 00:00:35 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id EB2ECB45844BE;
        Fri,  2 Jun 2017 23:00:22 +0100 (IST)
Received: from localhost (10.20.1.33) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 2 Jun 2017 23:00:27
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-leds@vger.kernel.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Ralf Baechle <ralf@linux-mips.org>,
        Richard Purdie <rpurdie@rpsys.net>, <linux-mips@linux-mips.org>
Subject: [PATCH] leds: Remove SEAD-3 driver
Date:   Fri, 2 Jun 2017 15:00:07 -0700
Message-ID: <20170602220007.6927-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58162
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

SEAD3 is using the generic syscon & regmap based register-bit-led
driver as of commit c764583f40b8 ("MIPS: SEAD3: Use register-bit-led
driver via DT for LEDs") merged in the v4.9 cycle. As such the custom
SEAD-3 LED driver is now unused, so remove it.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Richard Purdie <rpurdie@rpsys.net>
Cc: linux-leds@vger.kernel.org
Cc: linux-mips@linux-mips.org

---

 drivers/leds/Kconfig      | 10 ------
 drivers/leds/Makefile     |  1 -
 drivers/leds/leds-sead3.c | 78 -----------------------------------------------
 3 files changed, 89 deletions(-)
 delete mode 100644 drivers/leds/leds-sead3.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 6c2999872090..1e47b9182c33 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -590,16 +590,6 @@ config LEDS_KTD2692
 
 	  Say Y to enable this driver.
 
-config LEDS_SEAD3
-	tristate "LED support for the MIPS SEAD 3 board"
-	depends on LEDS_CLASS && MIPS_SEAD3
-	help
-	  Say Y here to include support for the FLED and PLED LEDs on SEAD3 eval
-	  boards.
-
-	  This driver can also be built as a module. If so the module
-	  will be called leds-sead3.
-
 config LEDS_IS31FL319X
 	tristate "LED Support for ISSI IS31FL319x I2C LED controller family"
 	depends on LEDS_CLASS && I2C && OF
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 45f133962ed8..8c056dd047e2 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -66,7 +66,6 @@ obj-$(CONFIG_LEDS_VERSATILE)		+= leds-versatile.o
 obj-$(CONFIG_LEDS_MENF21BMC)		+= leds-menf21bmc.o
 obj-$(CONFIG_LEDS_KTD2692)		+= leds-ktd2692.o
 obj-$(CONFIG_LEDS_POWERNV)		+= leds-powernv.o
-obj-$(CONFIG_LEDS_SEAD3)		+= leds-sead3.o
 obj-$(CONFIG_LEDS_IS31FL319X)		+= leds-is31fl319x.o
 obj-$(CONFIG_LEDS_IS31FL32XX)		+= leds-is31fl32xx.o
 obj-$(CONFIG_LEDS_PM8058)		+= leds-pm8058.o
diff --git a/drivers/leds/leds-sead3.c b/drivers/leds/leds-sead3.c
deleted file mode 100644
index eb97a3271bb3..000000000000
--- a/drivers/leds/leds-sead3.c
+++ /dev/null
@@ -1,78 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
- * Copyright (C) 2015 Imagination Technologies, Inc.
- */
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/leds.h>
-#include <linux/err.h>
-#include <linux/io.h>
-
-#include <asm/mips-boards/sead3-addr.h>
-
-static void sead3_pled_set(struct led_classdev *led_cdev,
-		enum led_brightness value)
-{
-	writel(value, (void __iomem *)SEAD3_CPLD_P_LED);
-}
-
-static void sead3_fled_set(struct led_classdev *led_cdev,
-		enum led_brightness value)
-{
-	writel(value, (void __iomem *)SEAD3_CPLD_F_LED);
-}
-
-static struct led_classdev sead3_pled = {
-	.name		= "sead3::pled",
-	.brightness_set = sead3_pled_set,
-	.flags		= LED_CORE_SUSPENDRESUME,
-};
-
-static struct led_classdev sead3_fled = {
-	.name		= "sead3::fled",
-	.brightness_set = sead3_fled_set,
-	.flags		= LED_CORE_SUSPENDRESUME,
-};
-
-static int sead3_led_probe(struct platform_device *pdev)
-{
-	int ret;
-
-	ret = led_classdev_register(&pdev->dev, &sead3_pled);
-	if (ret < 0)
-		return ret;
-
-	ret = led_classdev_register(&pdev->dev, &sead3_fled);
-	if (ret < 0)
-		led_classdev_unregister(&sead3_pled);
-
-	return ret;
-}
-
-static int sead3_led_remove(struct platform_device *pdev)
-{
-	led_classdev_unregister(&sead3_pled);
-	led_classdev_unregister(&sead3_fled);
-
-	return 0;
-}
-
-static struct platform_driver sead3_led_driver = {
-	.probe		= sead3_led_probe,
-	.remove		= sead3_led_remove,
-	.driver		= {
-		.name		= "sead3-led",
-	},
-};
-
-module_platform_driver(sead3_led_driver);
-
-MODULE_AUTHOR("Kristian Kielhofner <kris@krisk.org>");
-MODULE_DESCRIPTION("SEAD3 LED driver");
-MODULE_LICENSE("GPL");
-- 
2.13.0
