Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Apr 2015 16:37:10 +0200 (CEST)
Received: from smtp5-g21.free.fr ([212.27.42.5]:39980 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006570AbbDSOhICrAFE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 19 Apr 2015 16:37:08 +0200
Received: from localhost.localdomain (unknown [78.54.30.204])
        (Authenticated sender: albeu)
        by smtp5-g21.free.fr (Postfix) with ESMTPA id 28A01D4807B;
        Sun, 19 Apr 2015 16:34:12 +0200 (CEST)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alban Bedel <albeu@free.fr>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Gabor Juhos <juhosg@openwrt.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/12] MIPS: ath79: Add OF support to the GPIO driver
Date:   Sun, 19 Apr 2015 16:36:48 +0200
Message-Id: <1429454210-22571-1-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1429448288-20742-1-git-send-email-albeu@free.fr>
References: <1429448288-20742-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46937
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

Replace the simple GPIO chip registration by a platform driver
and make ath79_gpio_init() just register the device.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
v2: * Added an 'ngpios' property instead of the many matches
    * Use a platform data struct to store the device config on
      non-DT boards. It make for a cleaner separation of the config
      and driver code.
---
 arch/mips/ath79/dev-common.c             | 51 +++++++++++++++++++++
 arch/mips/ath79/gpio.c                   | 79 +++++++++++++++++++++++---------
 include/linux/platform_data/gpio-ath79.h | 19 ++++++++
 3 files changed, 127 insertions(+), 22 deletions(-)
 create mode 100644 include/linux/platform_data/gpio-ath79.h

diff --git a/arch/mips/ath79/dev-common.c b/arch/mips/ath79/dev-common.c
index 516225d..9d0172a 100644
--- a/arch/mips/ath79/dev-common.c
+++ b/arch/mips/ath79/dev-common.c
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/platform_data/gpio-ath79.h>
 #include <linux/serial_8250.h>
 #include <linux/clk.h>
 #include <linux/err.h>
@@ -106,3 +107,53 @@ void __init ath79_register_wdt(void)
 
 	platform_device_register_simple("ath79-wdt", -1, &res, 1);
 }
+
+static struct ath79_gpio_platform_data ath79_gpio_pdata;
+
+static struct resource ath79_gpio_resources[] = {
+	{
+		.flags = IORESOURCE_MEM,
+		.start = AR71XX_GPIO_BASE,
+		.end = AR71XX_GPIO_BASE + AR71XX_GPIO_SIZE - 1,
+	},
+	{
+		.start	= ATH79_MISC_IRQ(2),
+		.end	= ATH79_MISC_IRQ(2),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device ath79_gpio_device = {
+	.name		= "ath79-gpio",
+	.id		= -1,
+	.resource	= ath79_gpio_resources,
+	.num_resources	= ARRAY_SIZE(ath79_gpio_resources),
+	.dev = {
+		.platform_data	= &ath79_gpio_pdata
+	},
+};
+
+void __init ath79_gpio_init(void)
+{
+	if (soc_is_ar71xx()) {
+		ath79_gpio_pdata.ngpios = AR71XX_GPIO_COUNT;
+	} else if (soc_is_ar7240()) {
+		ath79_gpio_pdata.ngpios = AR7240_GPIO_COUNT;
+	} else if (soc_is_ar7241() || soc_is_ar7242()) {
+		ath79_gpio_pdata.ngpios = AR7241_GPIO_COUNT;
+	} else if (soc_is_ar913x()) {
+		ath79_gpio_pdata.ngpios = AR913X_GPIO_COUNT;
+	} else if (soc_is_ar933x()) {
+		ath79_gpio_pdata.ngpios = AR933X_GPIO_COUNT;
+	} else if (soc_is_ar934x()) {
+		ath79_gpio_pdata.ngpios = AR934X_GPIO_COUNT;
+		ath79_gpio_pdata.oe_inverted = 1;
+	} else if (soc_is_qca955x()) {
+		ath79_gpio_pdata.ngpios = QCA955X_GPIO_COUNT;
+		ath79_gpio_pdata.oe_inverted = 1;
+	} else {
+		BUG();
+	}
+
+	platform_device_register(&ath79_gpio_device);
+}
diff --git a/arch/mips/ath79/gpio.c b/arch/mips/ath79/gpio.c
index 8d025b0..f59ccb2 100644
--- a/arch/mips/ath79/gpio.c
+++ b/arch/mips/ath79/gpio.c
@@ -20,13 +20,15 @@
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/gpio.h>
+#include <linux/platform_data/gpio-ath79.h>
+#include <linux/of_device.h>
 
 #include <asm/mach-ath79/ar71xx_regs.h>
 #include <asm/mach-ath79/ath79.h>
 #include "common.h"
 
 static void __iomem *ath79_gpio_base;
-static unsigned long ath79_gpio_count;
+static u32 ath79_gpio_count;
 static DEFINE_SPINLOCK(ath79_gpio_lock);
 
 static void __ath79_gpio_set_value(unsigned gpio, int value)
@@ -178,39 +180,72 @@ void ath79_gpio_function_disable(u32 mask)
 	ath79_gpio_function_setup(0, mask);
 }
 
-void __init ath79_gpio_init(void)
+static const struct of_device_id ath79_gpio_of_match[] = {
+	{ .compatible = "qca,ar7100-gpio" },
+	{ .compatible = "qca,ar9340-gpio" },
+	{},
+};
+
+static int ath79_gpio_probe(struct platform_device *pdev)
 {
+	struct ath79_gpio_platform_data *pdata = pdev->dev.platform_data;
+	struct device_node *np = pdev->dev.of_node;
+	struct resource *res;
+	bool oe_inverted;
 	int err;
 
-	if (soc_is_ar71xx())
-		ath79_gpio_count = AR71XX_GPIO_COUNT;
-	else if (soc_is_ar7240())
-		ath79_gpio_count = AR7240_GPIO_COUNT;
-	else if (soc_is_ar7241() || soc_is_ar7242())
-		ath79_gpio_count = AR7241_GPIO_COUNT;
-	else if (soc_is_ar913x())
-		ath79_gpio_count = AR913X_GPIO_COUNT;
-	else if (soc_is_ar933x())
-		ath79_gpio_count = AR933X_GPIO_COUNT;
-	else if (soc_is_ar934x())
-		ath79_gpio_count = AR934X_GPIO_COUNT;
-	else if (soc_is_qca955x())
-		ath79_gpio_count = QCA955X_GPIO_COUNT;
-	else
-		BUG();
+	if (np) {
+		err = of_property_read_u32(np, "ngpios", &ath79_gpio_count);
+		if (err) {
+			dev_err(&pdev->dev, "ngpios property is not valid\n");
+			return err;
+		}
+		if (ath79_gpio_count >= 32) {
+			dev_err(&pdev->dev, "ngpios must be less than 32\n");
+			return -EINVAL;
+		}
+		oe_inverted = of_device_is_compatible(np, "qca,ar9340-gpio");
+	} else if (pdata) {
+		ath79_gpio_count = pdata->ngpios;
+		oe_inverted = pdata->oe_inverted;
+	} else {
+		dev_err(&pdev->dev, "No DT node or platform data found\n");
+		return -EINVAL;
+	}
 
-	ath79_gpio_base = ioremap_nocache(AR71XX_GPIO_BASE, AR71XX_GPIO_SIZE);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ath79_gpio_base = devm_ioremap_nocache(
+		&pdev->dev, res->start, resource_size(res));
+	if (!ath79_gpio_base)
+		return -ENOMEM;
+
+	ath79_gpio_chip.dev = &pdev->dev;
 	ath79_gpio_chip.ngpio = ath79_gpio_count;
-	if (soc_is_ar934x() || soc_is_qca955x()) {
+	if (oe_inverted) {
 		ath79_gpio_chip.direction_input = ar934x_gpio_direction_input;
 		ath79_gpio_chip.direction_output = ar934x_gpio_direction_output;
 	}
 
 	err = gpiochip_add(&ath79_gpio_chip);
-	if (err)
-		panic("cannot add AR71xx GPIO chip, error=%d", err);
+	if (err) {
+		dev_err(&pdev->dev,
+			"cannot add AR71xx GPIO chip, error=%d", err);
+		return err;
+	}
+
+	return 0;
 }
 
+static struct platform_driver ath79_gpio_driver = {
+	.driver = {
+		.name = "ath79-gpio",
+		.of_match_table	= ath79_gpio_of_match,
+	},
+	.probe = ath79_gpio_probe,
+};
+
+module_platform_driver(ath79_gpio_driver);
+
 int gpio_get_value(unsigned gpio)
 {
 	if (gpio < ath79_gpio_count)
diff --git a/include/linux/platform_data/gpio-ath79.h b/include/linux/platform_data/gpio-ath79.h
new file mode 100644
index 0000000..a9419c2
--- /dev/null
+++ b/include/linux/platform_data/gpio-ath79.h
@@ -0,0 +1,19 @@
+/*
+ *  Atheros AR7XXX/AR9XXX GPIO controller platfrom data
+ *
+ * Copyright (C) 2015 Alban Bedel <albeu@free.fr>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __LINUX_PLATFORM_DATA_GPIO_ATH79_H
+#define __LINUX_PLATFORM_DATA_GPIO_ATH79_H
+
+struct ath79_gpio_platform_data {
+	unsigned ngpios;
+	bool oe_inverted;
+};
+
+#endif
-- 
2.0.0
