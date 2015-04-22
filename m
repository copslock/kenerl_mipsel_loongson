Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Apr 2015 21:59:17 +0200 (CEST)
Received: from mail-ig0-f173.google.com ([209.85.213.173]:34109 "EHLO
        mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010625AbbDVT7QPvX7z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Apr 2015 21:59:16 +0200
Received: by iget9 with SMTP id t9so2057863ige.1;
        Wed, 22 Apr 2015 12:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=gKwIqsy4xin6ASyquWduYZDF9QVtLLUFGBQun20QUyk=;
        b=dyHLvCvV/35nh6N3ENodGd0qGMMApsPmLUTLxqR+RDVFQ/U1eycL19NubxMjOzPN4X
         w2cRAI9RiY37rXVB7L7IowMn5E+kcDK97WF6ymAK6MihfHgPGorPNZr8pdvg61gsaSWG
         WV+GGvHVhwBsv41zvRYAY+gYTLFXAVc0VoPpjpbt/ACi1bpFkXJMmlvEmw/18x6oJKLQ
         3WfLwfqcTnh2PlEC7Waz90lAHuQmlug0krOlgrpVOX0pAts8bHOGeOjAv3fpWI3e/FG6
         euVT3ODQ10o4dIM+Q/EvZxhOKlsPrpz0Me8TGXHF6pPGQ7o8OYJGuJakdQsjuYoaQRLX
         gjIw==
X-Received: by 10.43.59.80 with SMTP id wn16mr7559222icb.40.1429732752033;
        Wed, 22 Apr 2015 12:59:12 -0700 (PDT)
Received: from localhost.localdomain (173-10-26-10-BusName-utah.ut.hfc.comcastbusiness.net. [173.10.26.10])
        by mx.google.com with ESMTPSA id l1sm3754762ioe.32.2015.04.22.12.59.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 22 Apr 2015 12:59:01 -0700 (PDT)
From:   Dan Haab <riproute@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        "Rafa. Mi.ecki" <zajec5@gmail.com>, Dan Haab <dhaab@luxul.com>
Subject: [PATCH] MIPS: BCM47XX: Support Luxul XWR-1750 board
Date:   Wed, 22 Apr 2015 13:58:33 -0600
Message-Id: <1429732713-9366-1-git-send-email-riproute@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Return-Path: <riproute@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47010
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: riproute@gmail.com
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

From: Dan Haab <dhaab@luxul.com>

Signed-off-by: Dan Haab <dhaab@luxul.com>
---
 arch/mips/bcm47xx/board.c                          |  1 +
 arch/mips/bcm47xx/buttons.c                        | 11 +++++++++++
 arch/mips/bcm47xx/leds.c                           | 14 ++++++++++++++
 arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h |  2 ++
 4 files changed, 28 insertions(+)

diff --git a/arch/mips/bcm47xx/board.c b/arch/mips/bcm47xx/board.c
index bd56415..a88975a 100644
--- a/arch/mips/bcm47xx/board.c
+++ b/arch/mips/bcm47xx/board.c
@@ -149,6 +149,7 @@ struct bcm47xx_board_type_list2 bcm47xx_board_list_boot_hw[] __initconst = {
 /* board_id */
 static const
 struct bcm47xx_board_type_list1 bcm47xx_board_list_board_id[] __initconst = {
+	{{BCM47XX_BOARD_LUXUL_XWR_1750_V1, "Luxul XWR-1750 V1"}, "luxul_xwr1750_v1"},
 	{{BCM47XX_BOARD_NETGEAR_WGR614V8, "Netgear WGR614 V8"}, "U12H072T00_NETGEAR"},
 	{{BCM47XX_BOARD_NETGEAR_WGR614V9, "Netgear WGR614 V9"}, "U12H094T00_NETGEAR"},
 	{{BCM47XX_BOARD_NETGEAR_WGR614_V10, "Netgear WGR614 V10"}, "U12H139T01_NETGEAR"},
diff --git a/arch/mips/bcm47xx/buttons.c b/arch/mips/bcm47xx/buttons.c
index 276276a..08a4abf 100644
--- a/arch/mips/bcm47xx/buttons.c
+++ b/arch/mips/bcm47xx/buttons.c
@@ -299,6 +299,13 @@ bcm47xx_buttons_linksys_wrtsl54gs[] __initconst = {
 	BCM47XX_GPIO_KEY(6, KEY_RESTART),
 };
 
+/* Luxul */
+
+static const struct gpio_keys_button
+bcm47xx_buttons_luxul_xwr_1750_v1[] = {
+	BCM47XX_GPIO_KEY(14, BTN_TASK),
+};
+
 /* Microsoft */
 
 static const struct gpio_keys_button
@@ -555,6 +562,10 @@ int __init bcm47xx_buttons_register(void)
 		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_wrtsl54gs);
 		break;
 
+	case BCM47XX_BOARD_LUXUL_XWR_1750_V1:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_luxul_xwr_1750_v1);
+		break;
+
 	case BCM47XX_BOARD_MICROSOFT_MN700:
 		err = bcm47xx_copy_bdata(bcm47xx_buttons_microsoft_nm700);
 		break;
diff --git a/arch/mips/bcm47xx/leds.c b/arch/mips/bcm47xx/leds.c
index 0e4ade3..d20ae63 100644
--- a/arch/mips/bcm47xx/leds.c
+++ b/arch/mips/bcm47xx/leds.c
@@ -370,6 +370,16 @@ bcm47xx_leds_linksys_wrtsl54gs[] __initconst = {
 	BCM47XX_GPIO_LED(7, "orange", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
 };
 
+/* Luxul */
+
+static const struct gpio_led
+bcm47xx_leds_luxul_xwr_1750_v1[] __initconst = {
+	BCM47XX_GPIO_LED(5, "green", "5ghz", 0, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(12, "green", "usb", 0, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED_TRIGGER(13, "green", "status", 0, "timer"),
+	BCM47XX_GPIO_LED(15, "green", "wps", 0, LEDS_GPIO_DEFSTATE_OFF),
+};
+
 /* Microsoft */
 
 static const struct gpio_led
@@ -623,6 +633,10 @@ void __init bcm47xx_leds_register(void)
 		bcm47xx_set_pdata(bcm47xx_leds_linksys_wrtsl54gs);
 		break;
 
+	case BCM47XX_BOARD_LUXUL_XWR_1750_V1:
+		bcm47xx_set_pdata(bcm47xx_leds_luxul_xwr_1750_v1);
+		break;
+
 	case BCM47XX_BOARD_MICROSOFT_MN700:
 		bcm47xx_set_pdata(bcm47xx_leds_microsoft_nm700);
 		break;
diff --git a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h b/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
index c41d1dc..2afb840 100644
--- a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
+++ b/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
@@ -80,6 +80,8 @@ enum bcm47xx_board {
 	BCM47XX_BOARD_LINKSYS_WRT610NV2,
 	BCM47XX_BOARD_LINKSYS_WRTSL54GS,
 
+	BCM47XX_BOARD_LUXUL_XWR_1750_V1,
+
 	BCM47XX_BOARD_MICROSOFT_MN700,
 
 	BCM47XX_BOARD_MOTOROLA_WE800G,
-- 
1.8.4.5
