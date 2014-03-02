Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Mar 2014 17:49:57 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:52772 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6831264AbaCBQtlDkKbj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Mar 2014 17:49:41 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id B744E7E25;
        Sun,  2 Mar 2014 17:49:40 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id J2hjbNH7EUEK; Sun,  2 Mar 2014 17:49:35 +0100 (CET)
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 263267E26;
        Sun,  2 Mar 2014 17:49:32 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, zajec5@gmail.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/4] MIPS: BCM47XX: add button and led configuration for some Linksys devices
Date:   Sun,  2 Mar 2014 17:49:27 +0100
Message-Id: <1393778969-21066-2-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1393778969-21066-1-git-send-email-hauke@hauke-m.de>
References: <1393778969-21066-1-git-send-email-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39394
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

This adds led and button GPIO configuration for Linksys wrt54g3gv2,
wrt54gsv1 and wrtsl54gs. This is based on OpenWrt broadcom-diag code.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/buttons.c |   27 +++++++++++++++++++++++++++
 arch/mips/bcm47xx/leds.c    |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/arch/mips/bcm47xx/buttons.c b/arch/mips/bcm47xx/buttons.c
index 872c62e..f165887 100644
--- a/arch/mips/bcm47xx/buttons.c
+++ b/arch/mips/bcm47xx/buttons.c
@@ -259,6 +259,18 @@ bcm47xx_buttons_linksys_wrt310nv1[] __initconst = {
 };
 
 static const struct gpio_keys_button
+bcm47xx_buttons_linksys_wrt54g3gv2[] __initconst = {
+	BCM47XX_GPIO_KEY(5, KEY_WIMAX),
+	BCM47XX_GPIO_KEY(6, KEY_RESTART),
+};
+
+static const struct gpio_keys_button
+bcm47xx_buttons_linksys_wrt54gsv1[] __initconst = {
+	BCM47XX_GPIO_KEY(4, KEY_WPS_BUTTON),
+	BCM47XX_GPIO_KEY(6, KEY_RESTART),
+};
+
+static const struct gpio_keys_button
 bcm47xx_buttons_linksys_wrt610nv1[] __initconst = {
 	BCM47XX_GPIO_KEY(6, KEY_RESTART),
 	BCM47XX_GPIO_KEY(8, KEY_WPS_BUTTON),
@@ -270,6 +282,12 @@ bcm47xx_buttons_linksys_wrt610nv2[] __initconst = {
 	BCM47XX_GPIO_KEY(6, KEY_RESTART),
 };
 
+static const struct gpio_keys_button
+bcm47xx_buttons_linksys_wrtsl54gs[] __initconst = {
+	BCM47XX_GPIO_KEY(4, KEY_WPS_BUTTON),
+	BCM47XX_GPIO_KEY(6, KEY_RESTART),
+};
+
 /* Motorola */
 
 static const struct gpio_keys_button
@@ -479,12 +497,21 @@ int __init bcm47xx_buttons_register(void)
 	case BCM47XX_BOARD_LINKSYS_WRT310NV1:
 		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_wrt310nv1);
 		break;
+	case BCM47XX_BOARD_LINKSYS_WRT54G:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_wrt54gsv1);
+		break;
+	case BCM47XX_BOARD_LINKSYS_WRT54G3GV2:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_wrt54g3gv2);
+		break;
 	case BCM47XX_BOARD_LINKSYS_WRT610NV1:
 		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_wrt610nv1);
 		break;
 	case BCM47XX_BOARD_LINKSYS_WRT610NV2:
 		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_wrt610nv2);
 		break;
+	case BCM47XX_BOARD_LINKSYS_WRTSL54GS:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_wrtsl54gs);
+		break;
 
 	case BCM47XX_BOARD_MOTOROLA_WE800G:
 		err = bcm47xx_copy_bdata(bcm47xx_buttons_motorola_we800g);
diff --git a/arch/mips/bcm47xx/leds.c b/arch/mips/bcm47xx/leds.c
index 647d155..d741175 100644
--- a/arch/mips/bcm47xx/leds.c
+++ b/arch/mips/bcm47xx/leds.c
@@ -292,6 +292,21 @@ bcm47xx_leds_linksys_wrt310nv1[] __initconst = {
 };
 
 static const struct gpio_led
+bcm47xx_leds_linksys_wrt54gsv1[] __initconst = {
+	BCM47XX_GPIO_LED(0, "unk", "dmz", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(1, "unk", "power", 0, LEDS_GPIO_DEFSTATE_ON),
+	BCM47XX_GPIO_LED(5, "white", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(7, "orange", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
+};
+
+static const struct gpio_led
+bcm47xx_leds_linksys_wrt54g3gv2[] __initconst = {
+	BCM47XX_GPIO_LED(1, "unk", "power", 0, LEDS_GPIO_DEFSTATE_ON),
+	BCM47XX_GPIO_LED(2, "green", "3g", 0, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(3, "blue", "3g", 0, LEDS_GPIO_DEFSTATE_OFF),
+};
+
+static const struct gpio_led
 bcm47xx_leds_linksys_wrt610nv1[] __initconst = {
 	BCM47XX_GPIO_LED(0, "unk", "usb",  1, LEDS_GPIO_DEFSTATE_OFF),
 	BCM47XX_GPIO_LED(1, "unk", "power",  0, LEDS_GPIO_DEFSTATE_OFF),
@@ -308,6 +323,15 @@ bcm47xx_leds_linksys_wrt610nv2[] __initconst = {
 	BCM47XX_GPIO_LED(7, "unk", "usb", 0, LEDS_GPIO_DEFSTATE_OFF),
 };
 
+static const struct gpio_led
+bcm47xx_leds_linksys_wrtsl54gs[] __initconst = {
+	BCM47XX_GPIO_LED(0, "unk", "wlan", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(1, "unk", "power", 0, LEDS_GPIO_DEFSTATE_ON),
+	BCM47XX_GPIO_LED(2, "white", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(3, "orange", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(7, "unk", "dmz", 1, LEDS_GPIO_DEFSTATE_OFF),
+};
+
 /* Motorola */
 
 static const struct gpio_led
@@ -502,12 +526,21 @@ void __init bcm47xx_leds_register(void)
 	case BCM47XX_BOARD_LINKSYS_WRT310NV1:
 		bcm47xx_set_pdata(bcm47xx_leds_linksys_wrt310nv1);
 		break;
+	case BCM47XX_BOARD_LINKSYS_WRT54G:
+		bcm47xx_set_pdata(bcm47xx_leds_linksys_wrt54gsv1);
+		break;
+	case BCM47XX_BOARD_LINKSYS_WRT54G3GV2:
+		bcm47xx_set_pdata(bcm47xx_leds_linksys_wrt54g3gv2);
+		break;
 	case BCM47XX_BOARD_LINKSYS_WRT610NV1:
 		bcm47xx_set_pdata(bcm47xx_leds_linksys_wrt610nv1);
 		break;
 	case BCM47XX_BOARD_LINKSYS_WRT610NV2:
 		bcm47xx_set_pdata(bcm47xx_leds_linksys_wrt610nv2);
 		break;
+	case BCM47XX_BOARD_LINKSYS_WRTSL54GS:
+		bcm47xx_set_pdata(bcm47xx_leds_linksys_wrtsl54gs);
+		break;
 
 	case BCM47XX_BOARD_MOTOROLA_WE800G:
 		bcm47xx_set_pdata(bcm47xx_leds_motorola_we800g);
-- 
1.7.10.4
