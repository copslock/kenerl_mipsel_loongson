Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2014 02:11:08 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:50091 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010103AbaJXAK1Tkxez (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 24 Oct 2014 02:10:27 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s9O0AQgm012638;
        Fri, 24 Oct 2014 02:10:26 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s9O0APZn012637;
        Fri, 24 Oct 2014 02:10:25 +0200
Message-Id: <1ab02cb057a06c402549ef028e2f0d136fc58279.1414108953.git.ralf@linux-mips.org>
In-Reply-To: <20141023235416.GA7529@linux-mips.org>
References: <20141023235416.GA7529@linux-mips.org>
From:   Ralf Baechle <ralf@linux-mips.org>
Date:   Fri, 24 Oct 2014 01:50:46 +0200
Subject: [PATCH 3/3] LED/MIPS: Move SEAD3 LED driver to where it belongs.
To:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Bryan Wu <cooloney@gmail.com>,
        Richard Purdie <rpurdie@rpsys.net>, linux-leds@vger.kernel.org
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43547
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

Fixes the following randconfig problem

leds-sead3.c:(.text+0x7dc): undefined reference to `led_classdev_unregister'
leds-sead3.c:(.text+0x7e8): undefined reference to `led_classdev_unregister'

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
---
 arch/mips/mti-sead3/Makefile     |  2 +-
 arch/mips/mti-sead3/leds-sead3.c | 90 ----------------------------------------
 drivers/leds/Kconfig             |  9 ++++
 drivers/leds/Makefile            |  1 +
 drivers/leds/leds-sead3.c        | 90 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 101 insertions(+), 91 deletions(-)
 delete mode 100644 arch/mips/mti-sead3/leds-sead3.c
 create mode 100644 drivers/leds/leds-sead3.c

diff --git a/arch/mips/mti-sead3/Makefile b/arch/mips/mti-sead3/Makefile
index febf433..aa8a857 100644
--- a/arch/mips/mti-sead3/Makefile
+++ b/arch/mips/mti-sead3/Makefile
@@ -15,7 +15,7 @@ obj-y				:= sead3-lcd.o sead3-display.o sead3-init.o \
 
 obj-y				+= sead3-i2c-dev.o sead3-i2c.o \
 				   sead3-pic32-i2c-drv.o sead3-pic32-bus.o \
-				   leds-sead3.o sead3-leds.o
+				   sead3-leds.o
 
 obj-$(CONFIG_EARLY_PRINTK)	+= sead3-console.o
 obj-$(CONFIG_USB_EHCI_HCD)	+= sead3-ehci.o
diff --git a/arch/mips/mti-sead3/leds-sead3.c b/arch/mips/mti-sead3/leds-sead3.c
deleted file mode 100644
index e5632e6..0000000
--- a/arch/mips/mti-sead3/leds-sead3.c
+++ /dev/null
@@ -1,90 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
- */
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/leds.h>
-#include <linux/err.h>
-#include <linux/io.h>
-
-#define DRVNAME "sead3-led"
-
-static void sead3_pled_set(struct led_classdev *led_cdev,
-		enum led_brightness value)
-{
-	pr_debug("sead3_pled_set\n");
-	writel(value, (void __iomem *)0xBF000210);	/* FIXME */
-}
-
-static void sead3_fled_set(struct led_classdev *led_cdev,
-		enum led_brightness value)
-{
-	pr_debug("sead3_fled_set\n");
-	writel(value, (void __iomem *)0xBF000218);	/* FIXME */
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
-	return 0;
-}
-
-static struct platform_driver sead3_led_driver = {
-	.probe		= sead3_led_probe,
-	.remove		= sead3_led_remove,
-	.driver		= {
-		.name		= DRVNAME,
-		.owner		= THIS_MODULE,
-	},
-};
-
-static int __init sead3_led_init(void)
-{
-	return platform_driver_register(&sead3_led_driver);
-}
-
-static void __exit sead3_led_exit(void)
-{
-	platform_driver_unregister(&sead3_led_driver);
-}
-
-module_init(sead3_led_init);
-module_exit(sead3_led_exit);
-
-MODULE_AUTHOR("Kristian Kielhofner <kris@krisk.org>");
-MODULE_DESCRIPTION("SEAD3 LED driver");
-MODULE_LICENSE("GPL");
diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index a210338..b86aa85 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -477,6 +477,15 @@ config LEDS_MENF21BMC
 	  This driver can also be built as a module. If so the module
 	  will be called leds-menf21bmc.
 
+config LEDS_SEAD3
+	tristate "LED support for the MIPS SEAD 3 board"
+	depends on LEDS_CLASS && MIPS_SEAD3
+	help
+	  Say Y here to include support for the MEN 14F021P00 BMC LEDs.
+
+	  This driver can also be built as a module. If so the module
+	  will be called leds-sead3.
+
 comment "LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)"
 
 config LEDS_BLINKM
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index a2b1647..4f22241 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_LEDS_BLINKM)		+= leds-blinkm.o
 obj-$(CONFIG_LEDS_SYSCON)		+= leds-syscon.o
 obj-$(CONFIG_LEDS_VERSATILE)		+= leds-versatile.o
 obj-$(CONFIG_LEDS_MENF21BMC)		+= leds-menf21bmc.o
+obj-$(CONFIG_LEDS_SEAD3)		+= leds-sead3.o
 
 # LED SPI Drivers
 obj-$(CONFIG_LEDS_DAC124S085)		+= leds-dac124s085.o
diff --git a/drivers/leds/leds-sead3.c b/drivers/leds/leds-sead3.c
new file mode 100644
index 0000000..0cf79f5
--- /dev/null
+++ b/drivers/leds/leds-sead3.c
@@ -0,0 +1,90 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/leds.h>
+#include <linux/err.h>
+#include <linux/io.h>
+
+static void sead3_pled_set(struct led_classdev *led_cdev,
+		enum led_brightness value)
+{
+	pr_debug("sead3_pled_set\n");
+	writel(value, (void __iomem *)0xBF000210);	/* FIXME */
+}
+
+static void sead3_fled_set(struct led_classdev *led_cdev,
+		enum led_brightness value)
+{
+	pr_debug("sead3_fled_set\n");
+	writel(value, (void __iomem *)0xBF000218);	/* FIXME */
+}
+
+static struct led_classdev sead3_pled = {
+	.name		= "sead3::pled",
+	.brightness_set = sead3_pled_set,
+	.flags		= LED_CORE_SUSPENDRESUME,
+};
+
+static struct led_classdev sead3_fled = {
+	.name		= "sead3::fled",
+	.brightness_set = sead3_fled_set,
+	.flags		= LED_CORE_SUSPENDRESUME,
+};
+
+static int sead3_led_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	ret = led_classdev_register(&pdev->dev, &sead3_pled);
+	if (ret < 0)
+		return ret;
+
+	ret = led_classdev_register(&pdev->dev, &sead3_fled);
+	if (ret < 0)
+		led_classdev_unregister(&sead3_pled);
+
+	return ret;
+}
+
+static int sead3_led_remove(struct platform_device *pdev)
+{
+	led_classdev_unregister(&sead3_pled);
+	led_classdev_unregister(&sead3_fled);
+
+	return 0;
+}
+
+static struct platform_driver sead3_led_driver = {
+	.probe		= sead3_led_probe,
+	.remove		= sead3_led_remove,
+	.driver		= {
+		.name		= "sead3-led",
+		.owner		= THIS_MODULE,
+	},
+};
+
+static int __init sead3_led_init(void)
+{
+	return platform_driver_register(&sead3_led_driver);
+}
+
+static void __exit sead3_led_exit(void)
+{
+	platform_driver_unregister(&sead3_led_driver);
+}
+
+module_init(sead3_led_init);
+module_exit(sead3_led_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("SEAD3 LED driver");
+MODULE_AUTHOR("Kristian Kielhofner <kris@krisk.org>");
+MODULE_ALIAS("platform:sead3-led");
-- 
1.9.3
