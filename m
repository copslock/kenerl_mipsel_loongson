Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jul 2014 01:05:56 +0200 (CEST)
Received: from test.hauke-m.de ([5.39.93.123]:37907 "EHLO test.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6815804AbaG1WMXitI3r (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Jul 2014 00:12:23 +0200
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by test.hauke-m.de (Postfix) with ESMTPSA id 97D8E2000B;
        Tue, 29 Jul 2014 00:12:14 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     zajec5@gmail.com, linux-mips@linux-mips.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] MIPS: BCM47XX: add Microsoft MN-700 and Asus WL500G
Date:   Tue, 29 Jul 2014 00:12:09 +0200
Message-Id: <1406585529-13154-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.9.1
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41727
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

This patch adds detection for the Microsoft MN-700 and the Asus WL500G
router. This is based on some old code from OpenWrt.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---

This is based on top of:
[3.17,1/2] MIPS: BCM47XX: Distinguish WRT54G series devices by boardtype
[3.17,2/2] MIPS: BCM47XX: Fix LEDs on WRT54GS V1.0
[PATCH] MIPS: BCM47XX: Devices database update for 3.17

Patchwork links for above patches:
https://patchwork.linux-mips.org/patch/7112/
https://patchwork.linux-mips.org/patch/7113/
https://patchwork.linux-mips.org/patch/7394/

 arch/mips/bcm47xx/board.c                          | 17 +++++++++++++++++
 arch/mips/bcm47xx/buttons.c                        | 19 +++++++++++++++++++
 arch/mips/bcm47xx/leds.c                           | 19 +++++++++++++++++++
 arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h |  3 +++
 4 files changed, 58 insertions(+)

diff --git a/arch/mips/bcm47xx/board.c b/arch/mips/bcm47xx/board.c
index 838fb32..b3ae068 100644
--- a/arch/mips/bcm47xx/board.c
+++ b/arch/mips/bcm47xx/board.c
@@ -81,6 +81,14 @@ struct bcm47xx_board_type_list1 bcm47xx_board_list_hardware_version[] __initcons
 	{ {0}, NULL},
 };
 
+/* hardware_version, boardnum */
+static const
+struct bcm47xx_board_type_list2 bcm47xx_board_list_hw_version_num[] __initconst = {
+	{{BCM47XX_BOARD_MICROSOFT_MN700, "Microsoft MN-700"}, "WL500-", "mn700"},
+	{{BCM47XX_BOARD_ASUS_WL500G, "Asus WL500G"}, "WL500-", "asusX"},
+	{ {0}, NULL},
+};
+
 /* productid */
 static const
 struct bcm47xx_board_type_list1 bcm47xx_board_list_productid[] __initconst = {
@@ -238,6 +246,15 @@ static __init const struct bcm47xx_board_type *bcm47xx_board_get_nvram(void)
 		}
 	}
 
+	if (bcm47xx_nvram_getenv("hardware_version", buf1, sizeof(buf1)) >= 0 &&
+	    bcm47xx_nvram_getenv("boardtype", buf2, sizeof(buf2)) >= 0) {
+		for (e2 = bcm47xx_board_list_boot_hw; e2->value1; e2++) {
+			if (!strstarts(buf1, e2->value1) &&
+			    !strcmp(buf2, e2->value2))
+				return &e2->board;
+		}
+	}
+
 	if (bcm47xx_nvram_getenv("productid", buf1, sizeof(buf1)) >= 0) {
 		for (e1 = bcm47xx_board_list_productid; e1->value1; e1++) {
 			if (!strcmp(buf1, e1->value1))
diff --git a/arch/mips/bcm47xx/buttons.c b/arch/mips/bcm47xx/buttons.c
index 80cfb82..913182b 100644
--- a/arch/mips/bcm47xx/buttons.c
+++ b/arch/mips/bcm47xx/buttons.c
@@ -56,6 +56,11 @@ bcm47xx_buttons_asus_wl330ge[] __initconst = {
 };
 
 static const struct gpio_keys_button
+bcm47xx_buttons_asus_wl500g[] __initconst = {
+	BCM47XX_GPIO_KEY(6, KEY_RESTART),
+};
+
+static const struct gpio_keys_button
 bcm47xx_buttons_asus_wl500gd[] __initconst = {
 	BCM47XX_GPIO_KEY(6, KEY_RESTART),
 };
@@ -288,6 +293,13 @@ bcm47xx_buttons_linksys_wrtsl54gs[] __initconst = {
 	BCM47XX_GPIO_KEY(6, KEY_RESTART),
 };
 
+/* Microsoft */
+
+static const struct gpio_keys_button
+bcm47xx_buttons_microsoft_nm700[] __initconst = {
+	BCM47XX_GPIO_KEY(7, KEY_RESTART),
+};
+
 /* Motorola */
 
 static const struct gpio_keys_button
@@ -401,6 +413,9 @@ int __init bcm47xx_buttons_register(void)
 	case BCM47XX_BOARD_ASUS_WL330GE:
 		err = bcm47xx_copy_bdata(bcm47xx_buttons_asus_wl330ge);
 		break;
+	case BCM47XX_BOARD_ASUS_WL500G:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_asus_wl500g);
+		break;
 	case BCM47XX_BOARD_ASUS_WL500GD:
 		err = bcm47xx_copy_bdata(bcm47xx_buttons_asus_wl500gd);
 		break;
@@ -525,6 +540,10 @@ int __init bcm47xx_buttons_register(void)
 		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_wrtsl54gs);
 		break;
 
+	case BCM47XX_BOARD_MICROSOFT_MN700:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_microsoft_nm700);
+		break;
+
 	case BCM47XX_BOARD_MOTOROLA_WE800G:
 		err = bcm47xx_copy_bdata(bcm47xx_buttons_motorola_we800g);
 		break;
diff --git a/arch/mips/bcm47xx/leds.c b/arch/mips/bcm47xx/leds.c
index 98d29eb..903a656 100644
--- a/arch/mips/bcm47xx/leds.c
+++ b/arch/mips/bcm47xx/leds.c
@@ -73,6 +73,11 @@ bcm47xx_leds_asus_wl330ge[] __initconst = {
 };
 
 static const struct gpio_led
+bcm47xx_leds_asus_wl500g[] __initconst = {
+	BCM47XX_GPIO_LED(0, "unk", "power", 1, LEDS_GPIO_DEFSTATE_ON),
+};
+
+static const struct gpio_led
 bcm47xx_leds_asus_wl500gd[] __initconst = {
 	BCM47XX_GPIO_LED(0, "unk", "power", 1, LEDS_GPIO_DEFSTATE_ON),
 };
@@ -358,6 +363,13 @@ bcm47xx_leds_linksys_wrtsl54gs[] __initconst = {
 	BCM47XX_GPIO_LED(7, "orange", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
 };
 
+/* Microsoft */
+
+static const struct gpio_led
+bcm47xx_leds_microsoft_nm700[] __initconst = {
+	BCM47XX_GPIO_LED(6, "unk", "power", 0, LEDS_GPIO_DEFSTATE_ON),
+};
+
 /* Motorola */
 
 static const struct gpio_led
@@ -470,6 +482,9 @@ void __init bcm47xx_leds_register(void)
 	case BCM47XX_BOARD_ASUS_WL330GE:
 		bcm47xx_set_pdata(bcm47xx_leds_asus_wl330ge);
 		break;
+	case BCM47XX_BOARD_ASUS_WL500G:
+		bcm47xx_set_pdata(bcm47xx_leds_asus_wl500g);
+		break;
 	case BCM47XX_BOARD_ASUS_WL500GD:
 		bcm47xx_set_pdata(bcm47xx_leds_asus_wl500gd);
 		break;
@@ -598,6 +613,10 @@ void __init bcm47xx_leds_register(void)
 		bcm47xx_set_pdata(bcm47xx_leds_linksys_wrtsl54gs);
 		break;
 
+	case BCM47XX_BOARD_MICROSOFT_MN700:
+		bcm47xx_set_pdata(bcm47xx_leds_microsoft_nm700);
+		break;
+
 	case BCM47XX_BOARD_MOTOROLA_WE800G:
 		bcm47xx_set_pdata(bcm47xx_leds_motorola_we800g);
 		break;
diff --git a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h b/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
index bcae0e8..1f5643b 100644
--- a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
+++ b/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
@@ -18,6 +18,7 @@ enum bcm47xx_board {
 	BCM47XX_BOARD_ASUS_WL300G,
 	BCM47XX_BOARD_ASUS_WL320GE,
 	BCM47XX_BOARD_ASUS_WL330GE,
+	BCM47XX_BOARD_ASUS_WL500G,
 	BCM47XX_BOARD_ASUS_WL500GD,
 	BCM47XX_BOARD_ASUS_WL500GPV1,
 	BCM47XX_BOARD_ASUS_WL500GPV2,
@@ -77,6 +78,8 @@ enum bcm47xx_board {
 	BCM47XX_BOARD_LINKSYS_WRT610NV2,
 	BCM47XX_BOARD_LINKSYS_WRTSL54GS,
 
+	BCM47XX_BOARD_MICROSOFT_MN700,
+
 	BCM47XX_BOARD_MOTOROLA_WE800G,
 	BCM47XX_BOARD_MOTOROLA_WR850GP,
 	BCM47XX_BOARD_MOTOROLA_WR850GV2V3,
-- 
1.9.1
