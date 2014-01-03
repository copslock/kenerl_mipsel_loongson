Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jan 2014 09:37:56 +0100 (CET)
Received: from mail-ee0-f44.google.com ([74.125.83.44]:55841 "EHLO
        mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825707AbaACIhwqmGzV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Jan 2014 09:37:52 +0100
Received: by mail-ee0-f44.google.com with SMTP id b57so6581458eek.17
        for <multiple recipients>; Fri, 03 Jan 2014 00:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=3zDBwEAJzxopqAS3S8YMLtN9NeuSRD11uTSCwln6ufs=;
        b=uzo+0saQycQsPHQeR3h/qqjLZSEmnTiCyD1XpDW7ySH6CGyJCOiEoEutkXwubItugj
         G1lNDvIVcfbZKxhHTA0oXFYDdRvXuzdyjtFSO37ZOYxkCyJD+aljxHQVxD4mVanMXayu
         aFcFYASQEyYTHD33MqmtMqqf2mmo8fJcWILdKikwbO5QoDTQ7MP0FLmYBWreSx0yv5ae
         0qbcoDvmStZ5OLyLSOeCqKs74kw/dIfr+0OlnlJnAmxsVr0cppi7VXdS3psfZD3PkceS
         cs0pszl3+Jk5OzaZt1ao/vFvalKobXiA+4W3CJa8++okVPbPOjJ4s0WVDT07Qxwx3DQq
         /rfA==
X-Received: by 10.15.95.72 with SMTP id bc48mr20165322eeb.49.1388738267408;
        Fri, 03 Jan 2014 00:37:47 -0800 (PST)
Received: from linux-samsung700g7a.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id e43sm142995712eep.7.2014.01.03.00.37.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jan 2014 00:37:46 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH] MIPS: BCM47XX: Convert WNDR4500 to new syntax
Date:   Fri,  3 Jan 2014 09:37:42 +0100
Message-Id: <1388738262-22569-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.7.10.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38859
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


Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 arch/mips/bcm47xx/buttons.c |   22 ++++--------------
 arch/mips/bcm47xx/leds.c    |   53 ++++++++-----------------------------------
 2 files changed, 14 insertions(+), 61 deletions(-)

diff --git a/arch/mips/bcm47xx/buttons.c b/arch/mips/bcm47xx/buttons.c
index 13f8e41..51815ba 100644
--- a/arch/mips/bcm47xx/buttons.c
+++ b/arch/mips/bcm47xx/buttons.c
@@ -305,22 +305,10 @@ bcm47xx_buttons_netgear_wndr3700v3[] __initconst = {
 };
 
 static const struct gpio_keys_button
-bcm47xx_buttons_netgear_wndr4500_v1[] __initconst = {
-	{
-		.code		= KEY_WPS_BUTTON,
-		.gpio		= 4,
-		.active_low	= 1,
-	},
-	{
-		.code		= KEY_RFKILL,
-		.gpio		= 5,
-		.active_low	= 1,
-	},
-	{
-		.code		= KEY_RESTART,
-		.gpio		= 6,
-		.active_low	= 1,
-	},
+bcm47xx_buttons_netgear_wndr4500v1[] __initconst = {
+	BCM47XX_GPIO_KEY(4, KEY_WPS_BUTTON),
+	BCM47XX_GPIO_KEY(5, KEY_RFKILL),
+	BCM47XX_GPIO_KEY(6, KEY_RESTART),
 };
 
 static const struct gpio_keys_button
@@ -523,7 +511,7 @@ int __init bcm47xx_buttons_register(void)
 		err = bcm47xx_copy_bdata(bcm47xx_buttons_netgear_wndr3700v3);
 		break;
 	case BCM47XX_BOARD_NETGEAR_WNDR4500V1:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_netgear_wndr4500_v1);
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_netgear_wndr4500v1);
 		break;
 	case BCM47XX_BOARD_NETGEAR_WNR834BV2:
 		err = bcm47xx_copy_bdata(bcm47xx_buttons_netgear_wnr834bv2);
diff --git a/arch/mips/bcm47xx/leds.c b/arch/mips/bcm47xx/leds.c
index 28d281c..647d155 100644
--- a/arch/mips/bcm47xx/leds.c
+++ b/arch/mips/bcm47xx/leds.c
@@ -342,49 +342,14 @@ bcm47xx_leds_netgear_wndr3400v1[] __initconst = {
 };
 
 static const struct gpio_led
-bcm47xx_leds_netgear_wndr4500_v1_leds[] __initconst = {
-	{
-		.name		= "bcm47xx:green:wps",
-		.gpio		= 1,
-		.active_low	= 1,
-		.default_state	= LEDS_GPIO_DEFSTATE_KEEP,
-	},
-	{
-		.name		= "bcm47xx:green:power",
-		.gpio		= 2,
-		.active_low	= 1,
-		.default_state	= LEDS_GPIO_DEFSTATE_KEEP,
-	},
-	{
-		.name		= "bcm47xx:orange:power",
-		.gpio		= 3,
-		.active_low	= 1,
-		.default_state	= LEDS_GPIO_DEFSTATE_KEEP,
-	},
-	{
-		.name		= "bcm47xx:green:usb1",
-		.gpio		= 8,
-		.active_low	= 1,
-		.default_state	= LEDS_GPIO_DEFSTATE_KEEP,
-	},
-	{
-		.name		= "bcm47xx:green:2ghz",
-		.gpio		= 9,
-		.active_low	= 1,
-		.default_state	= LEDS_GPIO_DEFSTATE_KEEP,
-	},
-	{
-		.name		= "bcm47xx:blue:5ghz",
-		.gpio		= 11,
-		.active_low	= 1,
-		.default_state	= LEDS_GPIO_DEFSTATE_KEEP,
-	},
-	{
-		.name		= "bcm47xx:green:usb2",
-		.gpio		= 14,
-		.active_low	= 1,
-		.default_state	= LEDS_GPIO_DEFSTATE_KEEP,
-	},
+bcm47xx_leds_netgear_wndr4500v1[] __initconst = {
+	BCM47XX_GPIO_LED(1, "green", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(2, "green", "power", 1, LEDS_GPIO_DEFSTATE_ON),
+	BCM47XX_GPIO_LED(3, "amber", "power", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(8, "green", "usb1", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(9, "green", "2ghz", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(11, "blue", "5ghz", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(14, "green", "usb2", 1, LEDS_GPIO_DEFSTATE_OFF),
 };
 
 static const struct gpio_led
@@ -558,7 +523,7 @@ void __init bcm47xx_leds_register(void)
 		bcm47xx_set_pdata(bcm47xx_leds_netgear_wndr3400v1);
 		break;
 	case BCM47XX_BOARD_NETGEAR_WNDR4500V1:
-		bcm47xx_set_pdata(bcm47xx_leds_netgear_wndr4500_v1_leds);
+		bcm47xx_set_pdata(bcm47xx_leds_netgear_wndr4500v1);
 		break;
 	case BCM47XX_BOARD_NETGEAR_WNR834BV2:
 		bcm47xx_set_pdata(bcm47xx_leds_netgear_wnr834bv2);
-- 
1.7.10.4
