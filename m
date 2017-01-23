Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2017 20:50:34 +0100 (CET)
Received: from s15-gw102.mycloudmailbox.com ([207.126.101.39]:38676 "EHLO
        S15-GW102.mycloudmailbox.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992136AbdAWTu1RMDDN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Jan 2017 20:50:27 +0100
Received: from relay301.mycloudmailbox.com (unknown [207.126.101.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by S15-GW102.mycloudmailbox.com (Postfix) with ESMTPS id 3v6hk86mlQz2SX03;
        Mon, 23 Jan 2017 14:50:24 -0500 (EST)
Received: from S12-MBX11-14.S12.local (10.40.128.43) by S15-MBX102.S15.local
 (10.40.140.12) with Microsoft SMTP Server (TLS) id 15.1.466.34; Mon, 23 Jan
 2017 14:50:24 -0500
Received: from localhost.localdomain (10.40.130.245) by S12-MBX11-14.S12.local
 (10.40.128.43) with Microsoft SMTP Server (TLS) id 15.0.1236.3; Mon, 23 Jan
 2017 14:50:23 -0500
From:   Dan Haab <dhaab@luxul.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        <linux-mips@linux-mips.org>, Dan Haab <dhaab@luxul.com>
Subject: [PATCH] MIPS: BCM47XX: Add Luxul devices to the database
Date:   Mon, 23 Jan 2017 12:50:38 -0700
Message-ID: <1485201038-15834-1-git-send-email-dhaab@luxul.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.40.130.245]
X-ClientProxiedBy: S12-CAS101.S12.local (10.40.128.90) To
 S12-MBX11-14.S12.local (10.40.128.43)
X-RoutingAgent: Treated
X-CrossPremisesHeadersFilteredBySendConnector: S15-MBX102.S15.local
X-OrganizationHeadersPreserved: S15-MBX102.S15.local
Return-Path: <dhaab@luxul.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56472
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhaab@luxul.com
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

So far only Luxul XWR-1750 router was supported. This adds a set of
other Luxul devices based on BCM47XX. It's a standard support for LEDs
and buttons.

Signed-off-by: Dan Haab <dhaab@luxul.com>
---
 arch/mips/bcm47xx/board.c                          |    9 +++
 arch/mips/bcm47xx/buttons.c                        |   72 +++++++++++++++++
 arch/mips/bcm47xx/leds.c                           |   81 ++++++++++++++++++++
 arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h |    9 +++
 4 files changed, 171 insertions(+)

diff --git a/arch/mips/bcm47xx/board.c b/arch/mips/bcm47xx/board.c
index a88975a..8cbe60c 100644
--- a/arch/mips/bcm47xx/board.c
+++ b/arch/mips/bcm47xx/board.c
@@ -149,6 +149,15 @@ struct bcm47xx_board_type_list2 bcm47xx_board_list_boot_hw[] __initconst = {
 /* board_id */
 static const
 struct bcm47xx_board_type_list1 bcm47xx_board_list_board_id[] __initconst = {
+	{{BCM47XX_BOARD_LUXUL_ABR_4400_V1, "Luxul ABR-4400 V1"}, "luxul_abr4400_v1"},
+	{{BCM47XX_BOARD_LUXUL_XAP_310_V1, "Luxul XAP-310 V1"}, "luxul_xap310_v1"},
+	{{BCM47XX_BOARD_LUXUL_XAP_1210_V1, "Luxul XAP-1210 V1"}, "luxul_xap1210_v1"},
+	{{BCM47XX_BOARD_LUXUL_XAP_1230_V1, "Luxul XAP-1230 V1"}, "luxul_xap1230_v1"},
+	{{BCM47XX_BOARD_LUXUL_XAP_1240_V1, "Luxul XAP-1240 V1"}, "luxul_xap1240_v1"},
+	{{BCM47XX_BOARD_LUXUL_XAP_1500_V1, "Luxul XAP-1500 V1"}, "luxul_xap1500_v1"},
+	{{BCM47XX_BOARD_LUXUL_XBR_4400_V1, "Luxul XBR-4400 V1"}, "luxul_xbr4400_v1"},
+	{{BCM47XX_BOARD_LUXUL_XVW_P30_V1, "Luxul XVW-P30 V1"}, "luxul_xvwp30_v1"},
+	{{BCM47XX_BOARD_LUXUL_XWR_600_V1, "Luxul XWR-600 V1"}, "luxul_xwr600_v1"},
 	{{BCM47XX_BOARD_LUXUL_XWR_1750_V1, "Luxul XWR-1750 V1"}, "luxul_xwr1750_v1"},
 	{{BCM47XX_BOARD_NETGEAR_WGR614V8, "Netgear WGR614 V8"}, "U12H072T00_NETGEAR"},
 	{{BCM47XX_BOARD_NETGEAR_WGR614V9, "Netgear WGR614 V9"}, "U12H094T00_NETGEAR"},
diff --git a/arch/mips/bcm47xx/buttons.c b/arch/mips/bcm47xx/buttons.c
index 52caa75..7d58227 100644
--- a/arch/mips/bcm47xx/buttons.c
+++ b/arch/mips/bcm47xx/buttons.c
@@ -302,6 +302,51 @@
 /* Luxul */
 
 static const struct gpio_keys_button
+bcm47xx_buttons_luxul_abr_4400_v1[] = {
+	BCM47XX_GPIO_KEY(14, KEY_RESTART),
+};
+
+static const struct gpio_keys_button
+bcm47xx_buttons_luxul_xap_310_v1[] = {
+	BCM47XX_GPIO_KEY(20, KEY_RESTART),
+};
+
+static const struct gpio_keys_button
+bcm47xx_buttons_luxul_xap_1210_v1[] = {
+	BCM47XX_GPIO_KEY(8, KEY_RESTART),
+};
+
+static const struct gpio_keys_button
+bcm47xx_buttons_luxul_xap_1230_v1[] = {
+	BCM47XX_GPIO_KEY(8, KEY_RESTART),
+};
+
+static const struct gpio_keys_button
+bcm47xx_buttons_luxul_xap_1240_v1[] = {
+	BCM47XX_GPIO_KEY(8, KEY_RESTART),
+};
+
+static const struct gpio_keys_button
+bcm47xx_buttons_luxul_xap_1500_v1[] = {
+	BCM47XX_GPIO_KEY(14, KEY_RESTART),
+};
+
+static const struct gpio_keys_button
+bcm47xx_buttons_luxul_xbr_4400_v1[] = {
+	BCM47XX_GPIO_KEY(14, KEY_RESTART),
+};
+
+static const struct gpio_keys_button
+bcm47xx_buttons_luxul_xvw_p30_v1[] = {
+	BCM47XX_GPIO_KEY(20, KEY_RESTART),
+};
+
+static const struct gpio_keys_button
+bcm47xx_buttons_luxul_xwr_600_v1[] = {
+	BCM47XX_GPIO_KEY(8, KEY_RESTART),
+};
+
+static const struct gpio_keys_button
 bcm47xx_buttons_luxul_xwr_1750_v1[] = {
 	BCM47XX_GPIO_KEY(14, BTN_TASK),
 };
@@ -561,6 +606,33 @@ int __init bcm47xx_buttons_register(void)
 		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_wrtsl54gs);
 		break;
 
+	case BCM47XX_BOARD_LUXUL_ABR_4400_V1:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_luxul_abr_4400_v1);
+		break;
+	case BCM47XX_BOARD_LUXUL_XAP_310_V1:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_luxul_xap_310_v1);
+		break;
+	case BCM47XX_BOARD_LUXUL_XAP_1210_V1:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_luxul_xap_1210_v1);
+		break;
+	case BCM47XX_BOARD_LUXUL_XAP_1230_V1:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_luxul_xap_1230_v1);
+		break;
+	case BCM47XX_BOARD_LUXUL_XAP_1240_V1:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_luxul_xap_1240_v1);
+		break;
+	case BCM47XX_BOARD_LUXUL_XAP_1500_V1:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_luxul_xap_1500_v1);
+		break;
+	case BCM47XX_BOARD_LUXUL_XBR_4400_V1:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_luxul_xbr_4400_v1);
+		break;
+	case BCM47XX_BOARD_LUXUL_XVW_P30_V1:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_luxul_xvw_p30_v1);
+		break;
+	case BCM47XX_BOARD_LUXUL_XWR_600_V1:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_luxul_xwr_600_v1);
+		break;
 	case BCM47XX_BOARD_LUXUL_XWR_1750_V1:
 		err = bcm47xx_copy_bdata(bcm47xx_buttons_luxul_xwr_1750_v1);
 		break;
diff --git a/arch/mips/bcm47xx/leds.c b/arch/mips/bcm47xx/leds.c
index d20ae63..a35f1d5 100644
--- a/arch/mips/bcm47xx/leds.c
+++ b/arch/mips/bcm47xx/leds.c
@@ -373,6 +373,60 @@
 /* Luxul */
 
 static const struct gpio_led
+bcm47xx_leds_luxul_abr_4400_v1[] __initconst = {
+	BCM47XX_GPIO_LED(12, "green", "usb", 0, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED_TRIGGER(15, "green", "status", 0, "timer"),
+};
+
+static const struct gpio_led
+bcm47xx_leds_luxul_xap_310_v1[] __initconst = {
+	BCM47XX_GPIO_LED_TRIGGER(6, "green", "status", 1, "timer"),
+};
+
+static const struct gpio_led
+bcm47xx_leds_luxul_xap_1210_v1[] __initconst = {
+	BCM47XX_GPIO_LED_TRIGGER(6, "green", "status", 1, "timer"),
+};
+
+static const struct gpio_led
+bcm47xx_leds_luxul_xap_1230_v1[] __initconst = {
+	BCM47XX_GPIO_LED(3, "blue", "2ghz", 0, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(4, "green", "bridge", 0, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED_TRIGGER(6, "green", "status", 1, "timer"),
+};
+
+static const struct gpio_led
+bcm47xx_leds_luxul_xap_1240_v1[] __initconst = {
+	BCM47XX_GPIO_LED(3, "blue", "2ghz", 0, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(4, "green", "bridge", 0, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED_TRIGGER(6, "green", "status", 1, "timer"),
+};
+
+static const struct gpio_led
+bcm47xx_leds_luxul_xap_1500_v1[] __initconst = {
+	BCM47XX_GPIO_LED_TRIGGER(13, "green", "status", 1, "timer"),
+};
+
+static const struct gpio_led
+bcm47xx_leds_luxul_xbr_4400_v1[] __initconst = {
+	BCM47XX_GPIO_LED(12, "green", "usb", 0, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED_TRIGGER(15, "green", "status", 0, "timer"),
+};
+
+static const struct gpio_led
+bcm47xx_leds_luxul_xvw_p30_v1[] __initconst = {
+	BCM47XX_GPIO_LED_TRIGGER(0, "blue", "status", 1, "timer"),
+	BCM47XX_GPIO_LED(1, "green", "link", 1, LEDS_GPIO_DEFSTATE_OFF),
+};
+
+static const struct gpio_led
+bcm47xx_leds_luxul_xwr_600_v1[] __initconst = {
+	BCM47XX_GPIO_LED(3, "green", "wps", 0, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED_TRIGGER(6, "green", "status", 1, "timer"),
+	BCM47XX_GPIO_LED(9, "green", "usb", 0, LEDS_GPIO_DEFSTATE_OFF),
+};
+
+static const struct gpio_led
 bcm47xx_leds_luxul_xwr_1750_v1[] __initconst = {
 	BCM47XX_GPIO_LED(5, "green", "5ghz", 0, LEDS_GPIO_DEFSTATE_OFF),
 	BCM47XX_GPIO_LED(12, "green", "usb", 0, LEDS_GPIO_DEFSTATE_OFF),
@@ -633,6 +687,33 @@ void __init bcm47xx_leds_register(void)
 		bcm47xx_set_pdata(bcm47xx_leds_linksys_wrtsl54gs);
 		break;
 
+	case BCM47XX_BOARD_LUXUL_ABR_4400_V1:
+		bcm47xx_set_pdata(bcm47xx_leds_luxul_abr_4400_v1);
+		break;
+	case BCM47XX_BOARD_LUXUL_XAP_310_V1:
+		bcm47xx_set_pdata(bcm47xx_leds_luxul_xap_310_v1);
+		break;
+	case BCM47XX_BOARD_LUXUL_XAP_1210_V1:
+		bcm47xx_set_pdata(bcm47xx_leds_luxul_xap_1210_v1);
+		break;
+	case BCM47XX_BOARD_LUXUL_XAP_1230_V1:
+		bcm47xx_set_pdata(bcm47xx_leds_luxul_xap_1230_v1);
+		break;
+	case BCM47XX_BOARD_LUXUL_XAP_1240_V1:
+		bcm47xx_set_pdata(bcm47xx_leds_luxul_xap_1240_v1);
+		break;
+	case BCM47XX_BOARD_LUXUL_XAP_1500_V1:
+		bcm47xx_set_pdata(bcm47xx_leds_luxul_xap_1500_v1);
+		break;
+	case BCM47XX_BOARD_LUXUL_XBR_4400_V1:
+		bcm47xx_set_pdata(bcm47xx_leds_luxul_xbr_4400_v1);
+		break;
+	case BCM47XX_BOARD_LUXUL_XVW_P30_V1:
+		bcm47xx_set_pdata(bcm47xx_leds_luxul_xvw_p30_v1);
+		break;
+	case BCM47XX_BOARD_LUXUL_XWR_600_V1:
+		bcm47xx_set_pdata(bcm47xx_leds_luxul_xwr_600_v1);
+		break;
 	case BCM47XX_BOARD_LUXUL_XWR_1750_V1:
 		bcm47xx_set_pdata(bcm47xx_leds_luxul_xwr_1750_v1);
 		break;
diff --git a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h b/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
index 2afb840..ee3d4fe 100644
--- a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
+++ b/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
@@ -80,6 +80,15 @@ enum bcm47xx_board {
 	BCM47XX_BOARD_LINKSYS_WRT610NV2,
 	BCM47XX_BOARD_LINKSYS_WRTSL54GS,
 
+	BCM47XX_BOARD_LUXUL_ABR_4400_V1,
+	BCM47XX_BOARD_LUXUL_XAP_310_V1,
+	BCM47XX_BOARD_LUXUL_XAP_1210_V1,
+	BCM47XX_BOARD_LUXUL_XAP_1230_V1,
+	BCM47XX_BOARD_LUXUL_XAP_1240_V1,
+	BCM47XX_BOARD_LUXUL_XAP_1500_V1,
+	BCM47XX_BOARD_LUXUL_XBR_4400_V1,
+	BCM47XX_BOARD_LUXUL_XVW_P30_V1,
+	BCM47XX_BOARD_LUXUL_XWR_600_V1,
 	BCM47XX_BOARD_LUXUL_XWR_1750_V1,
 
 	BCM47XX_BOARD_MICROSOFT_MN700,
-- 
1.7.9.5
