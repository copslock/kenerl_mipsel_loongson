Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Feb 2011 03:42:36 +0100 (CET)
Received: from smtp-out-214.synserver.de ([212.40.185.214]:1078 "EHLO
        smtp-out-214.synserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491996Ab1BHCmc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Feb 2011 03:42:32 +0100
Received: (qmail 13092 invoked by uid 0); 8 Feb 2011 02:42:27 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@laprican.de
X-SynServer-PPID: 12918
Received: from e177158163.adsl.alicedsl.de (HELO lars-laptop.nons.lan) [85.177.158.163]
  by 217.119.54.87 with SMTP; 8 Feb 2011 02:42:27 -0000
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] MIPS: JZ4740: qi_lb60: Add gpio-charger device
Date:   Tue,  8 Feb 2011 03:43:53 +0100
Message-Id: <1297133034-17586-1-git-send-email-lars@metafoo.de>
X-Mailer: git-send-email 1.7.2.3
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29133
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips

Register the gpio-charger device which reports whether device is currently
charging or not.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/jz4740/board-qi_lb60.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/mips/jz4740/board-qi_lb60.c b/arch/mips/jz4740/board-qi_lb60.c
index 3e33264..e3f21ba 100644
--- a/arch/mips/jz4740/board-qi_lb60.c
+++ b/arch/mips/jz4740/board-qi_lb60.c
@@ -23,6 +23,7 @@
 #include <linux/spi/spi_gpio.h>
 #include <linux/power_supply.h>
 #include <linux/power/jz4740-battery.h>
+#include <linux/power/gpio-charger.h>
 
 #include <asm/mach-jz4740/jz4740_fb.h>
 #include <asm/mach-jz4740/jz4740_mmc.h>
@@ -395,6 +396,28 @@ static struct platform_device qi_lb60_pwm_beeper = {
 	},
 };
 
+/* charger */
+static char *qi_lb60_batteries[] = {
+	"battery",
+};
+
+static struct gpio_charger_platform_data qi_lb60_charger_pdata = {
+	.name = "usb",
+	.type = POWER_SUPPLY_TYPE_USB,
+	.gpio = JZ_GPIO_PORTD(28),
+	.gpio_active_low = 1,
+	.supplied_to = qi_lb60_batteries,
+	.num_supplicants = ARRAY_SIZE(qi_lb60_batteries),
+};
+
+static struct platform_device qi_lb60_charger_device = {
+	.name = "gpio-charger",
+	.dev = {
+		.platform_data = &qi_lb60_charger_pdata,
+	},
+};
+
+
 static struct platform_device *jz_platform_devices[] __initdata = {
 	&jz4740_udc_device,
 	&jz4740_mmc_device,
@@ -409,6 +432,7 @@ static struct platform_device *jz_platform_devices[] __initdata = {
 	&jz4740_adc_device,
 	&qi_lb60_gpio_keys,
 	&qi_lb60_pwm_beeper,
+	&qi_lb60_charger_device,
 };
 
 static void __init board_gpio_setup(void)
-- 
1.7.2.3
