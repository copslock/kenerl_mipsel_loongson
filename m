Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Apr 2015 18:18:37 +0200 (CEST)
Received: from mail-wg0-f52.google.com ([74.125.82.52]:33303 "EHLO
        mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014963AbbDAQSVKJRS- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Apr 2015 18:18:21 +0200
Received: by wgoe14 with SMTP id e14so58777539wgo.0;
        Wed, 01 Apr 2015 09:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=zvi4W7O/nxCwnCFZaTicskTYsYyAhOXgBYNFzazq1Yc=;
        b=a13HacGOiWu5c9qpxL7ahV5BXoISO2Ux4OYvebHnbq309c0OARTycVmUrnOgqw+Z6S
         XNe483J4Y5EeLGcCdhxdDnHxquof5FZ/AAbw/pLWl05Fa4mT/nwz8pud11qALkB6oDZd
         2VdP0t+RTLQ8yEJPJvGbTCr7e9AhJdMOpU7IjkB54LPDLNc2oQcINXmcNFwtaEw+6FGd
         e/qklE50sAUS+2Kko0Pm7jt/tWQ1X/3+/74XsFHDF2EnEXRe33GXplrJYJ5a+0RDwRCm
         VrwQME+ctVB/KvaKokxGCgYvQMkrMgFZQS87cdupYlwEHwwaihss4Ng2258ZJyxgShyN
         w3tQ==
X-Received: by 10.194.92.169 with SMTP id cn9mr83621580wjb.61.1427905097026;
        Wed, 01 Apr 2015 09:18:17 -0700 (PDT)
Received: from linux-tdhb.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id fm10sm3830398wib.7.2015.04.01.09.18.15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2015 09:18:16 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH 2/2] MIPS: BCM47XX: Devices database update for 4.1 (or 4.2?)
Date:   Wed,  1 Apr 2015 18:18:02 +0200
Message-Id: <1427905082-29972-2-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
In-Reply-To: <1427905082-29972-1-git-send-email-zajec5@gmail.com>
References: <1427905082-29972-1-git-send-email-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46691
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
 arch/mips/bcm47xx/board.c                          |  4 ++++
 arch/mips/bcm47xx/buttons.c                        | 18 ++++++++++++++++++
 arch/mips/bcm47xx/leds.c                           | 10 ++++++++++
 arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h |  4 ++++
 4 files changed, 36 insertions(+)

diff --git a/arch/mips/bcm47xx/board.c b/arch/mips/bcm47xx/board.c
index 3615f48..bd56415 100644
--- a/arch/mips/bcm47xx/board.c
+++ b/arch/mips/bcm47xx/board.c
@@ -151,9 +151,11 @@ static const
 struct bcm47xx_board_type_list1 bcm47xx_board_list_board_id[] __initconst = {
 	{{BCM47XX_BOARD_NETGEAR_WGR614V8, "Netgear WGR614 V8"}, "U12H072T00_NETGEAR"},
 	{{BCM47XX_BOARD_NETGEAR_WGR614V9, "Netgear WGR614 V9"}, "U12H094T00_NETGEAR"},
+	{{BCM47XX_BOARD_NETGEAR_WGR614_V10, "Netgear WGR614 V10"}, "U12H139T01_NETGEAR"},
 	{{BCM47XX_BOARD_NETGEAR_WNDR3300, "Netgear WNDR3300"}, "U12H093T00_NETGEAR"},
 	{{BCM47XX_BOARD_NETGEAR_WNDR3400V1, "Netgear WNDR3400 V1"}, "U12H155T00_NETGEAR"},
 	{{BCM47XX_BOARD_NETGEAR_WNDR3400V2, "Netgear WNDR3400 V2"}, "U12H187T00_NETGEAR"},
+	{{BCM47XX_BOARD_NETGEAR_WNDR3400_V3, "Netgear WNDR3400 V3"}, "U12H208T00_NETGEAR"},
 	{{BCM47XX_BOARD_NETGEAR_WNDR3400VCNA, "Netgear WNDR3400 Vcna"}, "U12H155T01_NETGEAR"},
 	{{BCM47XX_BOARD_NETGEAR_WNDR3700V3, "Netgear WNDR3700 V3"}, "U12H194T00_NETGEAR"},
 	{{BCM47XX_BOARD_NETGEAR_WNDR4000, "Netgear WNDR4000"}, "U12H181T00_NETGEAR"},
@@ -196,6 +198,8 @@ struct bcm47xx_board_type_list2 bcm47xx_board_list_board_type_rev[] __initconst
 static const
 struct bcm47xx_board_type_list2 bcm47xx_board_list_key_value[] __initconst = {
 	{{BCM47XX_BOARD_ASUS_WL700GE, "Asus WL700"}, "model_no", "WL700"},
+	{{BCM47XX_BOARD_LINKSYS_WRT300N_V1, "Linksys WRT300N V1"}, "router_name", "WRT300N"},
+	{{BCM47XX_BOARD_LINKSYS_WRT600N_V11, "Linksys WRT600N V1.1"}, "Model_Name", "WRT600N"},
 	{{BCM47XX_BOARD_LINKSYS_WRTSL54GS, "Linksys WRTSL54GS"}, "machine_name", "WRTSL54GS"},
 	{ {0}, NULL},
 };
diff --git a/arch/mips/bcm47xx/buttons.c b/arch/mips/bcm47xx/buttons.c
index 913182b..276276a 100644
--- a/arch/mips/bcm47xx/buttons.c
+++ b/arch/mips/bcm47xx/buttons.c
@@ -252,6 +252,12 @@ bcm47xx_buttons_linksys_wrt160nv3[] __initconst = {
 };
 
 static const struct gpio_keys_button
+bcm47xx_buttons_linksys_wrt300n_v1[] __initconst = {
+	BCM47XX_GPIO_KEY(4, KEY_WPS_BUTTON),
+	BCM47XX_GPIO_KEY(6, KEY_RESTART),
+};
+
+static const struct gpio_keys_button
 bcm47xx_buttons_linksys_wrt300nv11[] __initconst = {
 	BCM47XX_GPIO_KEY(4, KEY_UNKNOWN),
 	BCM47XX_GPIO_KEY(6, KEY_RESTART),
@@ -327,6 +333,12 @@ bcm47xx_buttons_netgear_wndr3400v1[] __initconst = {
 };
 
 static const struct gpio_keys_button
+bcm47xx_buttons_netgear_wndr3400_v3[] __initconst = {
+	BCM47XX_GPIO_KEY(12, KEY_RESTART),
+	BCM47XX_GPIO_KEY(23, KEY_WPS_BUTTON),
+};
+
+static const struct gpio_keys_button
 bcm47xx_buttons_netgear_wndr3700v3[] __initconst = {
 	BCM47XX_GPIO_KEY(2, KEY_RFKILL),
 	BCM47XX_GPIO_KEY(3, KEY_RESTART),
@@ -516,6 +528,9 @@ int __init bcm47xx_buttons_register(void)
 	case BCM47XX_BOARD_LINKSYS_WRT160NV3:
 		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_wrt160nv3);
 		break;
+	case BCM47XX_BOARD_LINKSYS_WRT300N_V1:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_wrt300n_v1);
+		break;
 	case BCM47XX_BOARD_LINKSYS_WRT300NV11:
 		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_wrt300nv11);
 		break;
@@ -557,6 +572,9 @@ int __init bcm47xx_buttons_register(void)
 	case BCM47XX_BOARD_NETGEAR_WNDR3400V1:
 		err = bcm47xx_copy_bdata(bcm47xx_buttons_netgear_wndr3400v1);
 		break;
+	case BCM47XX_BOARD_NETGEAR_WNDR3400_V3:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_netgear_wndr3400_v3);
+		break;
 	case BCM47XX_BOARD_NETGEAR_WNDR3700V3:
 		err = bcm47xx_copy_bdata(bcm47xx_buttons_netgear_wndr3700v3);
 		break;
diff --git a/arch/mips/bcm47xx/leds.c b/arch/mips/bcm47xx/leds.c
index 903a656..0e4ade3 100644
--- a/arch/mips/bcm47xx/leds.c
+++ b/arch/mips/bcm47xx/leds.c
@@ -292,6 +292,13 @@ bcm47xx_leds_linksys_wrt160nv3[] __initconst = {
 };
 
 static const struct gpio_led
+bcm47xx_leds_linksys_wrt300n_v1[] __initconst = {
+	BCM47XX_GPIO_LED(1, "green", "power", 0, LEDS_GPIO_DEFSTATE_ON),
+	BCM47XX_GPIO_LED(3, "amber", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(5, "green", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
+};
+
+static const struct gpio_led
 bcm47xx_leds_linksys_wrt300nv11[] __initconst = {
 	BCM47XX_GPIO_LED(1, "unk", "power", 0, LEDS_GPIO_DEFSTATE_ON),
 	BCM47XX_GPIO_LED(3, "amber", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
@@ -585,6 +592,9 @@ void __init bcm47xx_leds_register(void)
 	case BCM47XX_BOARD_LINKSYS_WRT160NV3:
 		bcm47xx_set_pdata(bcm47xx_leds_linksys_wrt160nv3);
 		break;
+	case BCM47XX_BOARD_LINKSYS_WRT300N_V1:
+		bcm47xx_set_pdata(bcm47xx_leds_linksys_wrt300n_v1);
+		break;
 	case BCM47XX_BOARD_LINKSYS_WRT300NV11:
 		bcm47xx_set_pdata(bcm47xx_leds_linksys_wrt300nv11);
 		break;
diff --git a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h b/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
index 1f5643b..c41d1dc 100644
--- a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
+++ b/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
@@ -67,6 +67,7 @@ enum bcm47xx_board {
 	BCM47XX_BOARD_LINKSYS_WRT150NV11,
 	BCM47XX_BOARD_LINKSYS_WRT160NV1,
 	BCM47XX_BOARD_LINKSYS_WRT160NV3,
+	BCM47XX_BOARD_LINKSYS_WRT300N_V1,
 	BCM47XX_BOARD_LINKSYS_WRT300NV11,
 	BCM47XX_BOARD_LINKSYS_WRT310NV1,
 	BCM47XX_BOARD_LINKSYS_WRT310NV2,
@@ -74,6 +75,7 @@ enum bcm47xx_board {
 	BCM47XX_BOARD_LINKSYS_WRT54G_TYPE_0101,
 	BCM47XX_BOARD_LINKSYS_WRT54G_TYPE_0467,
 	BCM47XX_BOARD_LINKSYS_WRT54G_TYPE_0708,
+	BCM47XX_BOARD_LINKSYS_WRT600N_V11,
 	BCM47XX_BOARD_LINKSYS_WRT610NV1,
 	BCM47XX_BOARD_LINKSYS_WRT610NV2,
 	BCM47XX_BOARD_LINKSYS_WRTSL54GS,
@@ -86,9 +88,11 @@ enum bcm47xx_board {
 
 	BCM47XX_BOARD_NETGEAR_WGR614V8,
 	BCM47XX_BOARD_NETGEAR_WGR614V9,
+	BCM47XX_BOARD_NETGEAR_WGR614_V10,
 	BCM47XX_BOARD_NETGEAR_WNDR3300,
 	BCM47XX_BOARD_NETGEAR_WNDR3400V1,
 	BCM47XX_BOARD_NETGEAR_WNDR3400V2,
+	BCM47XX_BOARD_NETGEAR_WNDR3400_V3,
 	BCM47XX_BOARD_NETGEAR_WNDR3400VCNA,
 	BCM47XX_BOARD_NETGEAR_WNDR3700V3,
 	BCM47XX_BOARD_NETGEAR_WNDR4000,
-- 
1.8.4.5
