Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 May 2017 18:58:33 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:47228 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994788AbdELQyEbLFER (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 May 2017 18:54:04 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Maarten ter Huurne <maarten@treewalker.org>,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v6 08/14] MIPS: JZ4740: Qi LB60: Add pinctrl configuration for several drivers
Date:   Fri, 12 May 2017 18:53:01 +0200
Message-Id: <20170512165307.31369-8-paul@crapouillou.net>
In-Reply-To: <20170512165307.31369-1-paul@crapouillou.net>
References: <20170428200824.10906-2-paul@crapouillou.net>
 <20170512165307.31369-1-paul@crapouillou.net>
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57887
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
 arch/mips/boot/dts/ingenic/qi_lb60.dts | 13 +++++++++
 arch/mips/jz4740/board-qi_lb60.c       | 48 +++++++++++++++++++++++++---------
 2 files changed, 49 insertions(+), 12 deletions(-)

 v2: Changed the devicetree bindings to match the new driver
 v3: No changes
 v4: No changes
 v5: No changes
 v6: Rename GPIO bank names in lookup tables to match new names and fix nand group name

diff --git a/arch/mips/boot/dts/ingenic/qi_lb60.dts b/arch/mips/boot/dts/ingenic/qi_lb60.dts
index be1a7d3a3e1b..b715ee2ac2ee 100644
--- a/arch/mips/boot/dts/ingenic/qi_lb60.dts
+++ b/arch/mips/boot/dts/ingenic/qi_lb60.dts
@@ -17,3 +17,16 @@
 &rtc_dev {
 	system-power-controller;
 };
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pins_uart0>;
+};
+
+&pinctrl {
+	pins_uart0: uart0 {
+		function = "uart0";
+		groups = "uart0-data";
+		bias-disable;
+	};
+};
diff --git a/arch/mips/jz4740/board-qi_lb60.c b/arch/mips/jz4740/board-qi_lb60.c
index a5bd94b95263..ef40c3718f0b 100644
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
@@ -159,7 +161,7 @@ static struct jz_nand_platform_data qi_lb60_nand_pdata = {
 static struct gpiod_lookup_table qi_lb60_nand_gpio_table = {
 	.dev_id = "jz4740-nand.0",
 	.table = {
-		GPIO_LOOKUP("Bank C", 30, "busy", 0),
+		GPIO_LOOKUP("GPIOC", 30, "busy", 0),
 		{ },
 	},
 };
@@ -421,8 +423,8 @@ static struct platform_device qi_lb60_audio_device = {
 static struct gpiod_lookup_table qi_lb60_audio_gpio_table = {
 	.dev_id = "qi-lb60-audio",
 	.table = {
-		GPIO_LOOKUP("Bank B", 29, "snd", 0),
-		GPIO_LOOKUP("Bank D", 4, "amp", 0),
+		GPIO_LOOKUP("GPIOB", 29, "snd", 0),
+		GPIO_LOOKUP("GPIOD", 4, "amp", 0),
 		{ },
 	},
 };
@@ -447,13 +449,36 @@ static struct platform_device *jz_platform_devices[] __initdata = {
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
+			"10010000.jz4740-pinctrl", "nand", "nand-cs1"),
+
+	/* fbdev pin configuration */
+	PIN_MAP_MUX_GROUP("jz4740-fb", PINCTRL_STATE_DEFAULT,
+			"10010000.jz4740-pinctrl", "lcd", "lcd-8bit"),
+	PIN_MAP_MUX_GROUP("jz4740-fb", PINCTRL_STATE_SLEEP,
+			"10010000.jz4740-pinctrl", "lcd", "lcd-no-pins"),
+
+	/* MMC pin configuration */
+	PIN_MAP_MUX_GROUP_DEFAULT("jz4740-mmc.0",
+			"10010000.jz4740-pinctrl", "mmc", "mmc-1bit"),
+	PIN_MAP_MUX_GROUP_DEFAULT("jz4740-mmc.0",
+			"10010000.jz4740-pinctrl", "mmc", "mmc-4bit"),
+	PIN_MAP_CONFIGS_PIN_DEFAULT("jz4740-mmc.0",
+			"10010000.jz4740-pinctrl", "PD0", pin_cfg_bias_disable),
+	PIN_MAP_CONFIGS_PIN_DEFAULT("jz4740-mmc.0",
+			"10010000.jz4740-pinctrl", "PD2", pin_cfg_bias_disable),
+
+	/* PWM pin configuration */
+	PIN_MAP_MUX_GROUP_DEFAULT("jz4740-pwm",
+			"10010000.jz4740-pinctrl", "pwm4", "pwm4"),
+};
+
 
 static int __init qi_lb60_init_platform_devices(void)
 {
@@ -469,6 +494,7 @@ static int __init qi_lb60_init_platform_devices(void)
 				ARRAY_SIZE(qi_lb60_spi_board_info));
 
 	pwm_add_table(qi_lb60_pwm_lookup, ARRAY_SIZE(qi_lb60_pwm_lookup));
+	pinctrl_register_mappings(pin_map, ARRAY_SIZE(pin_map));
 
 	return platform_add_devices(jz_platform_devices,
 					ARRAY_SIZE(jz_platform_devices));
@@ -479,8 +505,6 @@ static int __init qi_lb60_board_setup(void)
 {
 	printk(KERN_INFO "Qi Hardware JZ4740 QI LB60 setup\n");
 
-	board_gpio_setup();
-
 	if (qi_lb60_init_platform_devices())
 		panic("Failed to initialize platform devices");
 
-- 
2.11.0
