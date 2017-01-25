Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jan 2017 19:56:58 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:56422 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993944AbdAYSxK6VeNw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jan 2017 19:53:10 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Boris Brezillon <boris.brezillon@free-electrons.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        james.hogan@imgtec.com, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 08/14] MIPS: JZ4740: Qi LB60: Add pinctrl configuration for several drivers
Date:   Wed, 25 Jan 2017 19:52:01 +0100
Message-Id: <20170125185207.23902-9-paul@crapouillou.net>
In-Reply-To: <20170125185207.23902-1-paul@crapouillou.net>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170125185207.23902-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1485370360; bh=ymvTHelsI37K1jUbD9MSL5LH1S0kQeNesS/wRPAUuTQ=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=st4iV4NFmGS0mx3FJQmOZ3FNBcAk3Yl9Krkhw80IfBMjhCguY3rMIPClQn7Jp99sMKOGEvzm4UR7z/L8LpFyJw+Qjee5d3lbxxQWIY8VrxFles1+yy8YjXWT9XjXAKsxxD+6J2xs3Iyz6XZC3UMASX9bUzNcMZuk+cj2+/ZrhiY=
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56503
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
 arch/mips/boot/dts/ingenic/qi_lb60.dts | 13 +++++++++++
 arch/mips/jz4740/board-qi_lb60.c       | 42 ++++++++++++++++++++++++++--------
 2 files changed, 46 insertions(+), 9 deletions(-)

v2: Changed the devicetree bindings to match the new driver
v3: No changes

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
index a5bd94b95263..bf3dcc9ee9f8 100644
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
+			"10010000.jz4740-pinctrl", "nand", "nand"),
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
