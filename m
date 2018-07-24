Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jul 2018 01:23:39 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:33328 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994642AbeGXXUkueW0u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jul 2018 01:20:40 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Paul Cercueil <paul@crapouillou.net>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org,
        linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v5 17/21] MIPS: qi_lb60: Move PWM devices to devicetree
Date:   Wed, 25 Jul 2018 01:19:54 +0200
Message-Id: <20180724231958.20659-18-paul@crapouillou.net>
In-Reply-To: <20180724231958.20659-1-paul@crapouillou.net>
References: <20180724231958.20659-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1532474439; bh=YutvKB+w93jLUd3BwfFESYHHvQrYcj3b8D5UAcehw+I=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ccls00j9SHsqG+Xc1caHcf9kPkYWdu4RHBzP8dLiGt+trES16I+EjNzLk0N5HJwpNe+VA8Li0e8FmHyXWl4zsFC/lbJqninqiTyYm6QWw2LG9YR/qS2MkKUTqgoP7r+5D4Io105P2CqH2HeQFMINL0XKVZ6dWGLJOV2C52ftr2k=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65116
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

Probe the few drivers using PWMs from devicetree, now that we have a
devicetree node for the PWM driver.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/boot/dts/ingenic/qi_lb60.dts | 14 ++++++++++++++
 arch/mips/jz4740/board-qi_lb60.c       | 19 -------------------
 2 files changed, 14 insertions(+), 19 deletions(-)

 v5: New patch

diff --git a/arch/mips/boot/dts/ingenic/qi_lb60.dts b/arch/mips/boot/dts/ingenic/qi_lb60.dts
index 76aaf8982554..85529a142409 100644
--- a/arch/mips/boot/dts/ingenic/qi_lb60.dts
+++ b/arch/mips/boot/dts/ingenic/qi_lb60.dts
@@ -9,6 +9,14 @@
 	chosen {
 		stdout-path = &uart0;
 	};
+
+	beeper {
+		compatible = "pwm-beeper";
+		pwms = <&pwm 4 0 0>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pins_pwm4>;
+	};
 };
 
 &ext {
@@ -30,4 +38,10 @@
 		groups = "uart0-data";
 		bias-disable;
 	};
+
+	pins_pwm4: pwm4 {
+		function = "pwm4";
+		groups = "pwm4";
+		bias-disable;
+	};
 };
diff --git a/arch/mips/jz4740/board-qi_lb60.c b/arch/mips/jz4740/board-qi_lb60.c
index 60f0767507c6..2db32cb9ed47 100644
--- a/arch/mips/jz4740/board-qi_lb60.c
+++ b/arch/mips/jz4740/board-qi_lb60.c
@@ -27,7 +27,6 @@
 #include <linux/power_supply.h>
 #include <linux/power/jz4740-battery.h>
 #include <linux/power/gpio-charger.h>
-#include <linux/pwm.h>
 
 #include <asm/mach-jz4740/gpio.h>
 #include <asm/mach-jz4740/jz4740_fb.h>
@@ -391,17 +390,6 @@ static struct jz4740_mmc_platform_data qi_lb60_mmc_pdata = {
 	.power_active_low	= 1,
 };
 
-/* beeper */
-static struct pwm_lookup qi_lb60_pwm_lookup[] = {
-	PWM_LOOKUP("jz4740-pwm", 4, "pwm-beeper", NULL, 0,
-		   PWM_POLARITY_NORMAL),
-};
-
-static struct platform_device qi_lb60_pwm_beeper = {
-	.name = "pwm-beeper",
-	.id = -1,
-};
-
 /* charger */
 static char *qi_lb60_batteries[] = {
 	"battery",
@@ -450,10 +438,8 @@ static struct platform_device *jz_platform_devices[] __initdata = {
 	&jz4740_i2s_device,
 	&jz4740_codec_device,
 	&jz4740_adc_device,
-	&jz4740_pwm_device,
 	&jz4740_dma_device,
 	&qi_lb60_gpio_keys,
-	&qi_lb60_pwm_beeper,
 	&qi_lb60_charger_device,
 	&qi_lb60_audio_device,
 };
@@ -482,10 +468,6 @@ static struct pinctrl_map pin_map[] __initdata = {
 			"10010000.jz4740-pinctrl", "PD0", pin_cfg_bias_disable),
 	PIN_MAP_CONFIGS_PIN_DEFAULT("jz4740-mmc.0",
 			"10010000.jz4740-pinctrl", "PD2", pin_cfg_bias_disable),
-
-	/* PWM pin configuration */
-	PIN_MAP_MUX_GROUP_DEFAULT("jz4740-pwm",
-			"10010000.jz4740-pinctrl", "pwm4", "pwm4"),
 };
 
 
@@ -503,7 +485,6 @@ static int __init qi_lb60_init_platform_devices(void)
 	spi_register_board_info(qi_lb60_spi_board_info,
 				ARRAY_SIZE(qi_lb60_spi_board_info));
 
-	pwm_add_table(qi_lb60_pwm_lookup, ARRAY_SIZE(qi_lb60_pwm_lookup));
 	pinctrl_register_mappings(pin_map, ARRAY_SIZE(pin_map));
 
 	return platform_add_devices(jz_platform_devices,
-- 
2.11.0
