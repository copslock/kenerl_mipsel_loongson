Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Apr 2015 16:28:04 +0200 (CEST)
Received: from smtp2-g21.free.fr ([212.27.42.2]:56643 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010531AbbDQO1kTUW1r (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Apr 2015 16:27:40 +0200
Received: from localhost.localdomain (unknown [85.177.206.240])
        (Authenticated sender: albeu)
        by smtp2-g21.free.fr (Postfix) with ESMTPA id CA9954B021E;
        Fri, 17 Apr 2015 16:24:45 +0200 (CEST)
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
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/14] MIPS: ath79: Add OF support to the GPIO driver
Date:   Fri, 17 Apr 2015 16:24:26 +0200
Message-Id: <1429280669-2986-12-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1429280669-2986-1-git-send-email-albeu@free.fr>
References: <1429280669-2986-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46896
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
 arch/mips/ath79/dev-common.c | 13 ++++++++
 arch/mips/ath79/gpio.c       | 73 +++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 81 insertions(+), 5 deletions(-)

diff --git a/arch/mips/ath79/dev-common.c b/arch/mips/ath79/dev-common.c
index 516225d..4f397cb 100644
--- a/arch/mips/ath79/dev-common.c
+++ b/arch/mips/ath79/dev-common.c
@@ -106,3 +106,16 @@ void __init ath79_register_wdt(void)
 
 	platform_device_register_simple("ath79-wdt", -1, &res, 1);
 }
+
+void __init ath79_gpio_init(void)
+{
+	struct resource res;
+
+	memset(&res, 0, sizeof(res));
+
+	res.flags = IORESOURCE_MEM;
+	res.start = AR71XX_GPIO_BASE;
+	res.end = res.start + AR71XX_GPIO_SIZE - 1;
+
+	platform_device_register_simple("ath79-gpio", -1, &res, 1);
+}
diff --git a/arch/mips/ath79/gpio.c b/arch/mips/ath79/gpio.c
index 8d025b0..ce1a61d 100644
--- a/arch/mips/ath79/gpio.c
+++ b/arch/mips/ath79/gpio.c
@@ -20,6 +20,7 @@
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/gpio.h>
+#include <linux/of_device.h>
 
 #include <asm/mach-ath79/ar71xx_regs.h>
 #include <asm/mach-ath79/ath79.h>
@@ -178,11 +179,52 @@ void ath79_gpio_function_disable(u32 mask)
 	ath79_gpio_function_setup(0, mask);
 }
 
-void __init ath79_gpio_init(void)
+static const struct of_device_id ath79_gpio_of_match[] = {
+	{
+		.compatible = "qca,ar7100-gpio",
+		.data = (void *)AR71XX_GPIO_COUNT,
+	},
+	{
+		.compatible = "qca,ar7240-gpio",
+		.data = (void *)AR7240_GPIO_COUNT,
+	},
+	{
+		.compatible = "qca,ar7241-gpio",
+		.data = (void *)AR7241_GPIO_COUNT,
+	},
+	{
+		.compatible = "qca,ar9130-gpio",
+		.data = (void *)AR913X_GPIO_COUNT,
+	},
+	{
+		.compatible = "qca,ar9330-gpio",
+		.data = (void *)AR933X_GPIO_COUNT,
+	},
+	{
+		.compatible = "qca,ar9340-gpio",
+		.data = (void *)AR934X_GPIO_COUNT,
+	},
+	{
+		.compatible = "qca,qca9550-gpio",
+		.data = (void *)QCA955X_GPIO_COUNT,
+	},
+	{},
+};
+
+static int ath79_gpio_probe(struct platform_device *pdev)
 {
+	struct resource *res;
 	int err;
 
-	if (soc_is_ar71xx())
+	if (pdev->dev.of_node) {
+		const struct of_device_id *of_id =
+			of_match_device(ath79_gpio_of_match, &pdev->dev);
+		if (!of_id) {
+			dev_err(&pdev->dev, "Error: No device match found\n");
+			return -ENODEV;
+		}
+		ath79_gpio_count = (unsigned long)of_id->data;
+	} else if (soc_is_ar71xx())
 		ath79_gpio_count = AR71XX_GPIO_COUNT;
 	else if (soc_is_ar7240())
 		ath79_gpio_count = AR7240_GPIO_COUNT;
@@ -199,7 +241,13 @@ void __init ath79_gpio_init(void)
 	else
 		BUG();
 
-	ath79_gpio_base = ioremap_nocache(AR71XX_GPIO_BASE, AR71XX_GPIO_SIZE);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ath79_gpio_base = devm_ioremap_nocache(
+		&pdev->dev, res->start, resource_size(res));
+	if (!ath79_gpio_base)
+		return -ENOMEM;
+
+	ath79_gpio_chip.dev = &pdev->dev;
 	ath79_gpio_chip.ngpio = ath79_gpio_count;
 	if (soc_is_ar934x() || soc_is_qca955x()) {
 		ath79_gpio_chip.direction_input = ar934x_gpio_direction_input;
@@ -207,10 +255,25 @@ void __init ath79_gpio_init(void)
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
-- 
2.0.0
