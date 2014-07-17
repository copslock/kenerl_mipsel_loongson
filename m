Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jul 2014 23:24:49 +0200 (CEST)
Received: from mail-wi0-f178.google.com ([209.85.212.178]:50566 "EHLO
        mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861334AbaGQVYptZTse (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jul 2014 23:24:45 +0200
Received: by mail-wi0-f178.google.com with SMTP id hi2so3529424wib.5
        for <multiple recipients>; Thu, 17 Jul 2014 14:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=ktN6FhbQHgrtUCXUxZI5HiRwudjow8mOwlrLVKQLvF8=;
        b=crPlXuqT55bslCpO/tmE9eiKJu3rP7s9e2pjePP8ksYF+1LgLMxq4gonlCkJog8qBw
         FukmWM8890815wWwtRq3Wnay0w7tVFdO7rExBV5ZBFgbL7cx2S40Yc9WNYkyYfxV2XGV
         NQJWDIBQO+8YI8j85g3uq+xRmXgz5/Z/3BLhVG/PbopvJjPUV8G0igCtCFNZf56N3N7u
         7Uh+VlyLxy3R/JAnx8UN/sZOYtN6PLq1OPLE1iMs+Regm7/ExyFky/bIZzVHRfVFg2UC
         Vc1NGiXOC97JC6jCSegXd2MGQTQesZEJWQqIcPDOyPwz3LNKFroJGyg7dkRpRT94NHoE
         KPcg==
X-Received: by 10.194.222.197 with SMTP id qo5mr102190wjc.78.1405632280130;
        Thu, 17 Jul 2014 14:24:40 -0700 (PDT)
Received: from linux-tdhb.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id i3sm2360468wic.15.2014.07.17.14.24.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jul 2014 14:24:38 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH] MIPS: BCM47XX: Devices database update for 3.17
Date:   Thu, 17 Jul 2014 23:24:30 +0200
Message-Id: <1405632270-17867-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41296
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

Detect more devices and register leds & buttons for them.

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
This is based on top of:
[3.17,1/2] MIPS: BCM47XX: Distinguish WRT54G series devices by boardtype
[3.17,2/2] MIPS: BCM47XX: Fix LEDs on WRT54GS V1.0

Patchwork links for above patches:
https://patchwork.linux-mips.org/patch/7112/
https://patchwork.linux-mips.org/patch/7113/

It doesn't apply cleanly otherwise!
---
 arch/mips/bcm47xx/board.c   |  3 ++-
 arch/mips/bcm47xx/buttons.c |  9 ++++++++
 arch/mips/bcm47xx/leds.c    | 53 +++++++++++++++++++++++++++++++++++++--------
 3 files changed, 55 insertions(+), 10 deletions(-)

diff --git a/arch/mips/bcm47xx/board.c b/arch/mips/bcm47xx/board.c
index 63359f4..838fb32 100644
--- a/arch/mips/bcm47xx/board.c
+++ b/arch/mips/bcm47xx/board.c
@@ -58,6 +58,7 @@ struct bcm47xx_board_type_list1 bcm47xx_board_list_machine_name[] __initconst =
 static const
 struct bcm47xx_board_type_list1 bcm47xx_board_list_hardware_version[] __initconst = {
 	{{BCM47XX_BOARD_ASUS_RTN10U, "Asus RT-N10U"}, "RTN10U"},
+	{{BCM47XX_BOARD_ASUS_RTN10D, "Asus RT-N10D"}, "RTN10D"},
 	{{BCM47XX_BOARD_ASUS_RTN12, "Asus RT-N12"}, "RT-N12"},
 	{{BCM47XX_BOARD_ASUS_RTN12B1, "Asus RT-N12B1"}, "RTN12B1"},
 	{{BCM47XX_BOARD_ASUS_RTN12C1, "Asus RT-N12C1"}, "RTN12C1"},
@@ -98,7 +99,7 @@ struct bcm47xx_board_type_list1 bcm47xx_board_list_productid[] __initconst = {
 /* ModelId */
 static const
 struct bcm47xx_board_type_list1 bcm47xx_board_list_ModelId[] __initconst = {
-	{{BCM47XX_BOARD_DELL_TM2300, "Dell WX-5565"}, "WX-5565"},
+	{{BCM47XX_BOARD_DELL_TM2300, "Dell TrueMobile 2300"}, "WX-5565"},
 	{{BCM47XX_BOARD_MOTOROLA_WE800G, "Motorola WE800G"}, "WE800G"},
 	{{BCM47XX_BOARD_MOTOROLA_WR850GP, "Motorola WR850GP"}, "WR850GP"},
 	{{BCM47XX_BOARD_MOTOROLA_WR850GV2V3, "Motorola WR850G"}, "WR850G"},
diff --git a/arch/mips/bcm47xx/buttons.c b/arch/mips/bcm47xx/buttons.c
index e9b3cab..80cfb82 100644
--- a/arch/mips/bcm47xx/buttons.c
+++ b/arch/mips/bcm47xx/buttons.c
@@ -329,6 +329,12 @@ bcm47xx_buttons_netgear_wndr4500v1[] __initconst = {
 };
 
 static const struct gpio_keys_button
+bcm47xx_buttons_netgear_wnr3500lv1[] __initconst = {
+	BCM47XX_GPIO_KEY(4, KEY_RESTART),
+	BCM47XX_GPIO_KEY(6, KEY_WPS_BUTTON),
+};
+
+static const struct gpio_keys_button
 bcm47xx_buttons_netgear_wnr834bv2[] __initconst = {
 	BCM47XX_GPIO_KEY(6, KEY_RESTART),
 };
@@ -538,6 +544,9 @@ int __init bcm47xx_buttons_register(void)
 	case BCM47XX_BOARD_NETGEAR_WNDR4500V1:
 		err = bcm47xx_copy_bdata(bcm47xx_buttons_netgear_wndr4500v1);
 		break;
+	case BCM47XX_BOARD_NETGEAR_WNR3500L:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_netgear_wnr3500lv1);
+		break;
 	case BCM47XX_BOARD_NETGEAR_WNR834BV2:
 		err = bcm47xx_copy_bdata(bcm47xx_buttons_netgear_wnr834bv2);
 		break;
diff --git a/arch/mips/bcm47xx/leds.c b/arch/mips/bcm47xx/leds.c
index 23324e3..98d29eb 100644
--- a/arch/mips/bcm47xx/leds.c
+++ b/arch/mips/bcm47xx/leds.c
@@ -35,6 +35,15 @@ bcm47xx_leds_asus_rtn12[] __initconst = {
 };
 
 static const struct gpio_led
+bcm47xx_leds_asus_rtn15u[] __initconst = {
+	/* TODO: Add "wlan" LED */
+	BCM47XX_GPIO_LED(3, "blue", "wan", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(4, "blue", "lan", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(6, "blue", "power", 1, LEDS_GPIO_DEFSTATE_ON),
+	BCM47XX_GPIO_LED(9, "blue", "usb", 0, LEDS_GPIO_DEFSTATE_OFF),
+};
+
+static const struct gpio_led
 bcm47xx_leds_asus_rtn16[] __initconst = {
 	BCM47XX_GPIO_LED(1, "blue", "power", 1, LEDS_GPIO_DEFSTATE_ON),
 	BCM47XX_GPIO_LED(7, "blue", "wlan", 0, LEDS_GPIO_DEFSTATE_OFF),
@@ -42,8 +51,8 @@ bcm47xx_leds_asus_rtn16[] __initconst = {
 
 static const struct gpio_led
 bcm47xx_leds_asus_rtn66u[] __initconst = {
-	BCM47XX_GPIO_LED(12, "unk", "power", 1, LEDS_GPIO_DEFSTATE_ON),
-	BCM47XX_GPIO_LED(15, "unk", "usb", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(12, "blue", "power", 1, LEDS_GPIO_DEFSTATE_ON),
+	BCM47XX_GPIO_LED(15, "blue", "usb", 1, LEDS_GPIO_DEFSTATE_OFF),
 };
 
 static const struct gpio_led
@@ -216,8 +225,8 @@ bcm47xx_leds_linksys_e1000v1[] __initconst = {
 
 static const struct gpio_led
 bcm47xx_leds_linksys_e1000v21[] __initconst = {
-	BCM47XX_GPIO_LED(5, "unk", "wlan", 0, LEDS_GPIO_DEFSTATE_OFF),
-	BCM47XX_GPIO_LED(6, "unk", "power", 1, LEDS_GPIO_DEFSTATE_ON),
+	BCM47XX_GPIO_LED(5, "blue", "wlan", 0, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(6, "blue", "power", 1, LEDS_GPIO_DEFSTATE_ON),
 	BCM47XX_GPIO_LED(7, "amber", "wps", 0, LEDS_GPIO_DEFSTATE_OFF),
 	BCM47XX_GPIO_LED(8, "blue", "wps", 0, LEDS_GPIO_DEFSTATE_OFF),
 };
@@ -314,6 +323,16 @@ bcm47xx_leds_linksys_wrt54g_type_0101[] __initconst = {
 	BCM47XX_GPIO_LED(7, "green", "dmz", 1, LEDS_GPIO_DEFSTATE_OFF),
 };
 
+/* Verified on: WRT54GL V1.1 */
+static const struct gpio_led
+bcm47xx_leds_linksys_wrt54g_type_0467[] __initconst = {
+	BCM47XX_GPIO_LED(0, "green", "wlan", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(1, "green", "power", 0, LEDS_GPIO_DEFSTATE_ON),
+	BCM47XX_GPIO_LED(2, "white", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(3, "orange", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(7, "green", "dmz", 1, LEDS_GPIO_DEFSTATE_OFF),
+};
+
 static const struct gpio_led
 bcm47xx_leds_linksys_wrt610nv1[] __initconst = {
 	BCM47XX_GPIO_LED(0, "unk", "usb",  1, LEDS_GPIO_DEFSTATE_OFF),
@@ -333,11 +352,10 @@ bcm47xx_leds_linksys_wrt610nv2[] __initconst = {
 
 static const struct gpio_led
 bcm47xx_leds_linksys_wrtsl54gs[] __initconst = {
-	BCM47XX_GPIO_LED(0, "unk", "wlan", 1, LEDS_GPIO_DEFSTATE_OFF),
-	BCM47XX_GPIO_LED(1, "unk", "power", 0, LEDS_GPIO_DEFSTATE_ON),
-	BCM47XX_GPIO_LED(2, "white", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
-	BCM47XX_GPIO_LED(3, "orange", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
-	BCM47XX_GPIO_LED(7, "unk", "dmz", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(0, "green", "dmz", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(1, "green", "power", 0, LEDS_GPIO_DEFSTATE_ON),
+	BCM47XX_GPIO_LED(5, "white", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(7, "orange", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
 };
 
 /* Motorola */
@@ -385,6 +403,15 @@ bcm47xx_leds_netgear_wndr4500v1[] __initconst = {
 };
 
 static const struct gpio_led
+bcm47xx_leds_netgear_wnr3500lv1[] __initconst = {
+	BCM47XX_GPIO_LED(0, "blue", "wlan", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(1, "green", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(2, "green", "wan", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(3, "green", "power", 0, LEDS_GPIO_DEFSTATE_ON),
+	BCM47XX_GPIO_LED(7, "amber", "power", 0, LEDS_GPIO_DEFSTATE_OFF),
+};
+
+static const struct gpio_led
 bcm47xx_leds_netgear_wnr834bv2[] __initconst = {
 	BCM47XX_GPIO_LED(2, "green", "power", 0, LEDS_GPIO_DEFSTATE_ON),
 	BCM47XX_GPIO_LED(3, "amber", "power", 0, LEDS_GPIO_DEFSTATE_OFF),
@@ -425,6 +452,9 @@ void __init bcm47xx_leds_register(void)
 	case BCM47XX_BOARD_ASUS_RTN12:
 		bcm47xx_set_pdata(bcm47xx_leds_asus_rtn12);
 		break;
+	case BCM47XX_BOARD_ASUS_RTN15U:
+		bcm47xx_set_pdata(bcm47xx_leds_asus_rtn15u);
+		break;
 	case BCM47XX_BOARD_ASUS_RTN16:
 		bcm47xx_set_pdata(bcm47xx_leds_asus_rtn16);
 		break;
@@ -553,6 +583,8 @@ void __init bcm47xx_leds_register(void)
 		bcm47xx_set_pdata(bcm47xx_leds_linksys_wrt54g_type_0101);
 		break;
 	case BCM47XX_BOARD_LINKSYS_WRT54G_TYPE_0467:
+		bcm47xx_set_pdata(bcm47xx_leds_linksys_wrt54g_type_0467);
+		break;
 	case BCM47XX_BOARD_LINKSYS_WRT54G_TYPE_0708:
 		bcm47xx_set_pdata(bcm47xx_leds_linksys_wrt54g_generic);
 		break;
@@ -582,6 +614,9 @@ void __init bcm47xx_leds_register(void)
 	case BCM47XX_BOARD_NETGEAR_WNDR4500V1:
 		bcm47xx_set_pdata(bcm47xx_leds_netgear_wndr4500v1);
 		break;
+	case BCM47XX_BOARD_NETGEAR_WNR3500L:
+		bcm47xx_set_pdata(bcm47xx_leds_netgear_wnr3500lv1);
+		break;
 	case BCM47XX_BOARD_NETGEAR_WNR834BV2:
 		bcm47xx_set_pdata(bcm47xx_leds_netgear_wnr834bv2);
 		break;
-- 
1.8.4.5
