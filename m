Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jan 2017 00:16:22 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:60010 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993893AbdAQXPJZ599A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Jan 2017 00:15:09 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Burton <paul.burton@imgtec.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        james.hogan@imgtec.com, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 07/13] MIPS: JZ4740: Qi LB60: Add pinctrl configuration for several drivers
Date:   Wed, 18 Jan 2017 00:14:15 +0100
Message-Id: <20170117231421.16310-8-paul@crapouillou.net>
In-Reply-To: <20170117231421.16310-1-paul@crapouillou.net>
References: <20170117231421.16310-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1484694908; bh=0Ferh2QgJlGvm1zeWHl+MjJWkz+vq4tMQ06Jnerrnjs=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=soFqxN5+9apVBoDrJkW9G4EFqrA/Z6VUYtnHgdtEO9e4kLP66X4Ung78qW8i44VXw5CcXQMdFNbnApUElj32LPzKObPqbmiNC3HxM7v/ospYScKFkHVskarjypzbKQjpv4huBbxkmNk1JuXN85D/GO34gwea2XF6IXeKQlFWOXo=
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56373
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

We set the pin configuration for the jz4740-nand, jz4740-mmc,
jz4740-fb, jz4740-pwm and jz4740-uart drivers.

This will permit those drivers to be cleaned out of the custom GPIO code
that they currently use.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/boot/dts/ingenic/qi_lb60.dts |  5 ++++
 arch/mips/jz4740/board-qi_lb60.c       | 47 +++++++++++++++++++++++++++-------
 2 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/qi_lb60.dts b/arch/mips/boot/dts/ingenic/qi_lb60.dts
index be1a7d3a3e1b..7b98c4f57b1c 100644
--- a/arch/mips/boot/dts/ingenic/qi_lb60.dts
+++ b/arch/mips/boot/dts/ingenic/qi_lb60.dts
@@ -17,3 +17,8 @@
 &rtc_dev {
 	system-power-controller;
 };
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pins_uart0_data>;
+};
diff --git a/arch/mips/jz4740/board-qi_lb60.c b/arch/mips/jz4740/board-qi_lb60.c
index a5bd94b95263..c6ee50a44cb3 100644
--- a/arch/mips/jz4740/board-qi_lb60.c
+++ b/arch/mips/jz4740/board-qi_lb60.c
@@ -22,6 +22,8 @@
 #include <linux/input/matrix_keypad.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_gpio.h>
+#include <linux/pinctrl/machine.h>
+#include <linux/pinctrl/pinconf-generic.h>
 #include <linux/power_supply.h>
 #include <linux/power/jz4740-battery.h>
 #include <linux/power/gpio-charger.h>
@@ -447,13 +449,41 @@ static struct platform_device *jz_platform_devices[] __initdata = {
 	&qi_lb60_audio_device,
 };
 
-static void __init board_gpio_setup(void)
-{
-	/* We only need to enable/disable pullup here for pins used in generic
-	 * drivers. Everything else is done by the drivers themselves. */
-	jz_gpio_disable_pullup(QI_LB60_GPIO_SD_VCC_EN_N);
-	jz_gpio_disable_pullup(QI_LB60_GPIO_SD_CD);
-}
+static unsigned long pin_cfg_bias_disable[] = {
+	    PIN_CONFIG_BIAS_DISABLE,
+};
+
+static struct pinctrl_map pin_map[] __initdata = {
+	/* NAND pin configuration */
+	PIN_MAP_MUX_GROUP_DEFAULT("jz4740-nand",
+			"10010000.jz4740-pinctrl",
+			"pinfunc-nand", "pins-nand"),
+
+	/* fbdev pin configuration */
+	PIN_MAP_MUX_GROUP("jz4740-fb", PINCTRL_STATE_DEFAULT,
+			"10010000.jz4740-pinctrl",
+			"pinfunc-lcd", "pins-lcd-8bit"),
+	PIN_MAP_MUX_GROUP("jz4740-fb", PINCTRL_STATE_SLEEP,
+			"10010000.jz4740-pinctrl",
+			"pinfunc-lcd", "pins-lcd-no-pins"),
+
+	/* MMC pin configuration */
+	PIN_MAP_MUX_GROUP_DEFAULT("jz4740-mmc.0",
+			"10010000.jz4740-pinctrl",
+			"pinfunc-msc", "pins-msc-4bit"),
+	PIN_MAP_CONFIGS_PIN_DEFAULT("jz4740-mmc.0",
+			"10010000.jz4740-pinctrl",
+			"PD0", pin_cfg_bias_disable),
+	PIN_MAP_CONFIGS_PIN_DEFAULT("jz4740-mmc.0",
+			"10010000.jz4740-pinctrl",
+			"PD2", pin_cfg_bias_disable),
+
+	/* PWM pin configuration */
+	PIN_MAP_MUX_GROUP_DEFAULT("jz4740-pwm",
+			"10010000.jz4740-pinctrl",
+			"pinfunc-pwm4", "pins-pwm4"),
+};
+
 
 static int __init qi_lb60_init_platform_devices(void)
 {
@@ -469,6 +499,7 @@ static int __init qi_lb60_init_platform_devices(void)
 				ARRAY_SIZE(qi_lb60_spi_board_info));
 
 	pwm_add_table(qi_lb60_pwm_lookup, ARRAY_SIZE(qi_lb60_pwm_lookup));
+	pinctrl_register_mappings(pin_map, ARRAY_SIZE(pin_map));
 
 	return platform_add_devices(jz_platform_devices,
 					ARRAY_SIZE(jz_platform_devices));
@@ -479,8 +510,6 @@ static int __init qi_lb60_board_setup(void)
 {
 	printk(KERN_INFO "Qi Hardware JZ4740 QI LB60 setup\n");
 
-	board_gpio_setup();
-
 	if (qi_lb60_init_platform_devices())
 		panic("Failed to initialize platform devices");
 
-- 
2.11.0
