Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jun 2014 07:57:09 +0200 (CEST)
Received: from mail-wg0-f48.google.com ([74.125.82.48]:54649 "EHLO
        mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859941AbaFTF4xKaTOb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Jun 2014 07:56:53 +0200
Received: by mail-wg0-f48.google.com with SMTP id n12so3215642wgh.7
        for <multiple recipients>; Thu, 19 Jun 2014 22:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=9uwVFyS8fQydJw6UFKV8jENeFRwjOpNmw/4c1aO4Tr8=;
        b=EMYWACd4CCJrBKJ97WrNOlBVhb/l0Cu9UOC/QFKHbAbR+4DFRPMVuUoADrrClBAI4L
         c0rJtVPuI5Add/jgDUATpYQzmCp64I2ZitFu1LmpjRkGpKMd0ciAlA97l5LWC6A9Us8w
         VuKFjAServj1xdio4GLBNmH8pCb7glA3+OP6y2raH+bhYAE9+4oJh92ndHzuvHlr8yg6
         TwPhu59UmiYrm6HvzSkMRCGB7Zt+3ovIqLNa3jRHc0MAE+9sPiuInbtczwDHSC5JLReg
         bChyGj13P7tNiLlVEeXjtgntPi8YI+RU2FNjDn3evOQkfGBHJ7VN/Z/81o9Egh6MvVne
         0j8w==
X-Received: by 10.180.38.38 with SMTP id d6mr1436030wik.12.1403243807730;
        Thu, 19 Jun 2014 22:56:47 -0700 (PDT)
Received: from linux-tdhb.lan (static-91-227-21-4.devs.futuro.pl. [91.227.21.4])
        by mx.google.com with ESMTPSA id ge17sm1574298wic.0.2014.06.19.22.56.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jun 2014 22:56:47 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        Catalin Patulea <cat@vv.carleton.ca>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [3.17][PATCH 1/2] MIPS: BCM47XX: Distinguish WRT54G series devices by boardtype
Date:   Fri, 20 Jun 2014 07:56:39 +0200
Message-Id: <1403243800-7849-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40641
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

Catalin reported that GPIOs used by bcm47xx don't match layout of his
WRT54GS V1.0 board. It seems we need to distinguish these 54G* devices.

Reported-by: Catalin Patulea <cat@vv.carleton.ca>
Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 arch/mips/bcm47xx/board.c                          |  6 +++---
 arch/mips/bcm47xx/buttons.c                        | 10 ++++++----
 arch/mips/bcm47xx/leds.c                           | 10 ++++++----
 arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h |  4 +++-
 4 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/mips/bcm47xx/board.c b/arch/mips/bcm47xx/board.c
index 44ab1be..63359f4 100644
--- a/arch/mips/bcm47xx/board.c
+++ b/arch/mips/bcm47xx/board.c
@@ -180,9 +180,9 @@ struct bcm47xx_board_type_list3 bcm47xx_board_list_board[] __initconst = {
 	{{BCM47XX_BOARD_PHICOMM_M1, "Phicomm M1"}, "0x0590", "80", "0x1104"},
 	{{BCM47XX_BOARD_ZTE_H218N, "ZTE H218N"}, "0x053d", "1234", "0x1305"},
 	{{BCM47XX_BOARD_NETGEAR_WNR3500L, "Netgear WNR3500L"}, "0x04CF", "3500", "02"},
-	{{BCM47XX_BOARD_LINKSYS_WRT54G, "Linksys WRT54G/GS/GL"}, "0x0101", "42", "0x10"},
-	{{BCM47XX_BOARD_LINKSYS_WRT54G, "Linksys WRT54G/GS/GL"}, "0x0467", "42", "0x10"},
-	{{BCM47XX_BOARD_LINKSYS_WRT54G, "Linksys WRT54G/GS/GL"}, "0x0708", "42", "0x10"},
+	{{BCM47XX_BOARD_LINKSYS_WRT54G_TYPE_0101, "Linksys WRT54G/GS/GL"}, "0x0101", "42", "0x10"},
+	{{BCM47XX_BOARD_LINKSYS_WRT54G_TYPE_0467, "Linksys WRT54G/GS/GL"}, "0x0467", "42", "0x10"},
+	{{BCM47XX_BOARD_LINKSYS_WRT54G_TYPE_0708, "Linksys WRT54G/GS/GL"}, "0x0708", "42", "0x10"},
 	{ {0}, NULL},
 };
 
diff --git a/arch/mips/bcm47xx/buttons.c b/arch/mips/bcm47xx/buttons.c
index 49a1ce0..e9b3cab 100644
--- a/arch/mips/bcm47xx/buttons.c
+++ b/arch/mips/bcm47xx/buttons.c
@@ -265,7 +265,7 @@ bcm47xx_buttons_linksys_wrt54g3gv2[] __initconst = {
 };
 
 static const struct gpio_keys_button
-bcm47xx_buttons_linksys_wrt54gsv1[] __initconst = {
+bcm47xx_buttons_linksys_wrt54g_generic[] __initconst = {
 	BCM47XX_GPIO_KEY(4, KEY_WPS_BUTTON),
 	BCM47XX_GPIO_KEY(6, KEY_RESTART),
 };
@@ -501,12 +501,14 @@ int __init bcm47xx_buttons_register(void)
 	case BCM47XX_BOARD_LINKSYS_WRT310NV1:
 		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_wrt310nv1);
 		break;
-	case BCM47XX_BOARD_LINKSYS_WRT54G:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_wrt54gsv1);
-		break;
 	case BCM47XX_BOARD_LINKSYS_WRT54G3GV2:
 		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_wrt54g3gv2);
 		break;
+	case BCM47XX_BOARD_LINKSYS_WRT54G_TYPE_0101:
+	case BCM47XX_BOARD_LINKSYS_WRT54G_TYPE_0467:
+	case BCM47XX_BOARD_LINKSYS_WRT54G_TYPE_0708:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_wrt54g_generic);
+		break;
 	case BCM47XX_BOARD_LINKSYS_WRT610NV1:
 		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_wrt610nv1);
 		break;
diff --git a/arch/mips/bcm47xx/leds.c b/arch/mips/bcm47xx/leds.c
index adcb547..909e00f 100644
--- a/arch/mips/bcm47xx/leds.c
+++ b/arch/mips/bcm47xx/leds.c
@@ -292,7 +292,7 @@ bcm47xx_leds_linksys_wrt310nv1[] __initconst = {
 };
 
 static const struct gpio_led
-bcm47xx_leds_linksys_wrt54gsv1[] __initconst = {
+bcm47xx_leds_linksys_wrt54g_generic[] __initconst = {
 	BCM47XX_GPIO_LED(0, "unk", "dmz", 1, LEDS_GPIO_DEFSTATE_OFF),
 	BCM47XX_GPIO_LED(1, "unk", "power", 0, LEDS_GPIO_DEFSTATE_ON),
 	BCM47XX_GPIO_LED(5, "white", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
@@ -538,12 +538,14 @@ void __init bcm47xx_leds_register(void)
 	case BCM47XX_BOARD_LINKSYS_WRT310NV1:
 		bcm47xx_set_pdata(bcm47xx_leds_linksys_wrt310nv1);
 		break;
-	case BCM47XX_BOARD_LINKSYS_WRT54G:
-		bcm47xx_set_pdata(bcm47xx_leds_linksys_wrt54gsv1);
-		break;
 	case BCM47XX_BOARD_LINKSYS_WRT54G3GV2:
 		bcm47xx_set_pdata(bcm47xx_leds_linksys_wrt54g3gv2);
 		break;
+	case BCM47XX_BOARD_LINKSYS_WRT54G_TYPE_0101:
+	case BCM47XX_BOARD_LINKSYS_WRT54G_TYPE_0467:
+	case BCM47XX_BOARD_LINKSYS_WRT54G_TYPE_0708:
+		bcm47xx_set_pdata(bcm47xx_leds_linksys_wrt54g_generic);
+		break;
 	case BCM47XX_BOARD_LINKSYS_WRT610NV1:
 		bcm47xx_set_pdata(bcm47xx_leds_linksys_wrt610nv1);
 		break;
diff --git a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h b/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
index bba7399..bcae0e8 100644
--- a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
+++ b/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
@@ -70,7 +70,9 @@ enum bcm47xx_board {
 	BCM47XX_BOARD_LINKSYS_WRT310NV1,
 	BCM47XX_BOARD_LINKSYS_WRT310NV2,
 	BCM47XX_BOARD_LINKSYS_WRT54G3GV2,
-	BCM47XX_BOARD_LINKSYS_WRT54G,
+	BCM47XX_BOARD_LINKSYS_WRT54G_TYPE_0101,
+	BCM47XX_BOARD_LINKSYS_WRT54G_TYPE_0467,
+	BCM47XX_BOARD_LINKSYS_WRT54G_TYPE_0708,
 	BCM47XX_BOARD_LINKSYS_WRT610NV1,
 	BCM47XX_BOARD_LINKSYS_WRT610NV2,
 	BCM47XX_BOARD_LINKSYS_WRTSL54GS,
-- 
1.8.4.5
