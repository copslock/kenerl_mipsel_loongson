Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Apr 2016 20:59:20 +0200 (CEST)
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:58543 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026877AbcDRS7SU04Xg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Apr 2016 20:59:18 +0200
Received: from mfilter17-d.gandi.net (mfilter17-d.gandi.net [217.70.178.145])
        by relay6-d.mail.gandi.net (Postfix) with ESMTP id 13FE6FB883;
        Mon, 18 Apr 2016 20:59:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter17-d.gandi.net
Received: from relay6-d.mail.gandi.net ([IPv6:::ffff:217.70.183.198])
        by mfilter17-d.gandi.net (mfilter17-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id WHR8YgzEXUtD; Mon, 18 Apr 2016 20:59:16 +0200 (CEST)
X-Originating-IP: 88.159.34.112
Received: from starbug-2.treewalker.org (unknown [88.159.34.112])
        (Authenticated sender: relay@treewalker.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id DC96CFB8A3;
        Mon, 18 Apr 2016 20:59:15 +0200 (CEST)
Received: from hyperion.trinair2002 (hyperion.trinair2002 [192.168.0.43])
        by starbug-2.treewalker.org (Postfix) with ESMTP id 668924319F;
        Mon, 18 Apr 2016 20:59:15 +0200 (CEST)
From:   Maarten ter Huurne <maarten@treewalker.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Maarten ter Huurne <maarten@treewalker.org>
Subject: [PATCH 1/3] MIPS: JZ4740: Qi LB60: Remove support for AVT2 variant
Date:   Mon, 18 Apr 2016 20:58:51 +0200
Message-Id: <1461005933-24876-1-git-send-email-maarten@treewalker.org>
X-Mailer: git-send-email 2.6.6
Return-Path: <maarten@treewalker.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53068
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maarten@treewalker.org
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

AVT2 was a prototype board of which about 5 were made, none of which
are in use anymore.

Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
---
 arch/mips/jz4740/board-qi_lb60.c | 52 ++--------------------------------------
 1 file changed, 2 insertions(+), 50 deletions(-)

diff --git a/arch/mips/jz4740/board-qi_lb60.c b/arch/mips/jz4740/board-qi_lb60.c
index 934b15b..4e3f9b7a 100644
--- a/arch/mips/jz4740/board-qi_lb60.c
+++ b/arch/mips/jz4740/board-qi_lb60.c
@@ -39,8 +39,6 @@
 
 #include "clock.h"
 
-static bool is_avt2;
-
 /* GPIOs */
 #define QI_LB60_GPIO_SD_CD		JZ_GPIO_PORTD(0)
 #define QI_LB60_GPIO_SD_VCC_EN_N	JZ_GPIO_PORTD(2)
@@ -367,43 +365,12 @@ static struct jz4740_mmc_platform_data qi_lb60_mmc_pdata = {
 	.power_active_low	= 1,
 };
 
-/* OHCI */
-static struct regulator_consumer_supply avt2_usb_regulator_consumer =
-	REGULATOR_SUPPLY("vbus", "jz4740-ohci");
-
-static struct regulator_init_data avt2_usb_regulator_init_data = {
-	.num_consumer_supplies = 1,
-	.consumer_supplies = &avt2_usb_regulator_consumer,
-	.constraints = {
-		.name = "USB power",
-		.min_uV = 5000000,
-		.max_uV = 5000000,
-		.valid_modes_mask = REGULATOR_MODE_NORMAL,
-		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
-	},
-};
-
-static struct fixed_voltage_config avt2_usb_regulator_data = {
-	.supply_name = "USB power",
-	.microvolts = 5000000,
-	.gpio = JZ_GPIO_PORTB(17),
-	.init_data = &avt2_usb_regulator_init_data,
-};
-
-static struct platform_device avt2_usb_regulator_device = {
-	.name = "reg-fixed-voltage",
-	.id = -1,
-	.dev = {
-		.platform_data = &avt2_usb_regulator_data,
-	}
-};
-
+/* beeper */
 static struct pwm_lookup qi_lb60_pwm_lookup[] = {
 	PWM_LOOKUP("jz4740-pwm", 4, "pwm-beeper", NULL, 0,
 		   PWM_POLARITY_NORMAL),
 };
 
-/* beeper */
 static struct platform_device qi_lb60_pwm_beeper = {
 	.name = "pwm-beeper",
 	.id = -1,
@@ -487,11 +454,6 @@ static int __init qi_lb60_init_platform_devices(void)
 	spi_register_board_info(qi_lb60_spi_board_info,
 				ARRAY_SIZE(qi_lb60_spi_board_info));
 
-	if (is_avt2) {
-		platform_device_register(&avt2_usb_regulator_device);
-		platform_device_register(&jz4740_usb_ohci_device);
-	}
-
 	pwm_add_table(qi_lb60_pwm_lookup, ARRAY_SIZE(qi_lb60_pwm_lookup));
 
 	return platform_add_devices(jz_platform_devices,
@@ -499,19 +461,9 @@ static int __init qi_lb60_init_platform_devices(void)
 
 }
 
-static __init int board_avt2(char *str)
-{
-	qi_lb60_mmc_pdata.card_detect_active_low = 1;
-	is_avt2 = true;
-
-	return 1;
-}
-__setup("avt2", board_avt2);
-
 static int __init qi_lb60_board_setup(void)
 {
-	printk(KERN_INFO "Qi Hardware JZ4740 QI %s setup\n",
-		is_avt2 ? "AVT2" : "LB60");
+	printk(KERN_INFO "Qi Hardware JZ4740 QI LB60 setup\n");
 
 	board_gpio_setup();
 
-- 
2.6.6
