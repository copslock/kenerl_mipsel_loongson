Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Mar 2014 17:50:16 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:52777 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860900AbaCBQtoAlefc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Mar 2014 17:49:44 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id A750D7E25;
        Sun,  2 Mar 2014 17:49:43 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OtfAiyLmI94F; Sun,  2 Mar 2014 17:49:40 +0100 (CET)
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 4DA917E27;
        Sun,  2 Mar 2014 17:49:32 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, zajec5@gmail.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/4] MIPS: BCM47XX: add detection and GPIO config for Siemens SE505v2
Date:   Sun,  2 Mar 2014 17:49:28 +0100
Message-Id: <1393778969-21066-3-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1393778969-21066-1-git-send-email-hauke@hauke-m.de>
References: <1393778969-21066-1-git-send-email-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39395
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

This adds board detection for the Siemens SE505v2 and the led gpio
configuration. This board does not have any buttons.
This is based on OpenWrt broadcom-diag and Manuel Munz's nvram dump.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/board.c                          |   17 +++++++++++++++++
 arch/mips/bcm47xx/leds.c                           |   12 ++++++++++++
 arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h |    2 ++
 3 files changed, 31 insertions(+)

diff --git a/arch/mips/bcm47xx/board.c b/arch/mips/bcm47xx/board.c
index 1913fa2..1ddc643 100644
--- a/arch/mips/bcm47xx/board.c
+++ b/arch/mips/bcm47xx/board.c
@@ -182,6 +182,13 @@ struct bcm47xx_board_type_list3 bcm47xx_board_list_board[] __initconst = {
 	{ {0}, NULL},
 };
 
+/* boardtype, boardrev */
+static const
+struct bcm47xx_board_type_list2 bcm47xx_board_list_board_type_rev[] __initconst = {
+	{{BCM47XX_BOARD_SIEMENS_SE505V2, "Siemens SE505 V2"}, "0x0101", "0x10"},
+	{ {0}, NULL},
+};
+
 static const
 struct bcm47xx_board_type bcm47xx_board_unknown[] __initconst = {
 	{BCM47XX_BOARD_UNKNOWN, "Unknown Board"},
@@ -275,6 +282,16 @@ static __init const struct bcm47xx_board_type *bcm47xx_board_get_nvram(void)
 				return &e3->board;
 		}
 	}
+
+	if (bcm47xx_nvram_getenv("boardtype", buf1, sizeof(buf1)) >= 0 &&
+	    bcm47xx_nvram_getenv("boardrev", buf2, sizeof(buf2)) >= 0 &&
+    	    bcm47xx_nvram_getenv("boardnum", buf3, sizeof(buf3)) ==  -ENOENT) {
+		for (e2 = bcm47xx_board_list_board_type_rev; e2->value1; e2++) {
+			if (!strcmp(buf1, e2->value1) &&
+			    !strcmp(buf2, e2->value2))
+				return &e2->board;
+		}
+	}
 	return bcm47xx_board_unknown;
 }
 
diff --git a/arch/mips/bcm47xx/leds.c b/arch/mips/bcm47xx/leds.c
index d741175..8bacc37 100644
--- a/arch/mips/bcm47xx/leds.c
+++ b/arch/mips/bcm47xx/leds.c
@@ -383,6 +383,14 @@ bcm47xx_leds_netgear_wnr834bv2[] __initconst = {
 	BCM47XX_GPIO_LED(7, "unk", "connected", 0, LEDS_GPIO_DEFSTATE_OFF),
 };
 
+/* Siemens */
+static const struct gpio_led
+bcm47xx_leds_siemens_se505v2[] __initconst = {
+	BCM47XX_GPIO_LED(0, "unk", "dmz", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(3, "unk", "wlan", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(5, "unk", "power", 1, LEDS_GPIO_DEFSTATE_ON),
+};
+
 /* SimpleTech */
 
 static const struct gpio_led
@@ -562,6 +570,10 @@ void __init bcm47xx_leds_register(void)
 		bcm47xx_set_pdata(bcm47xx_leds_netgear_wnr834bv2);
 		break;
 
+	case BCM47XX_BOARD_SIEMENS_SE505V2:
+		bcm47xx_set_pdata(bcm47xx_leds_siemens_se505v2);
+		break;
+
 	case BCM47XX_BOARD_SIMPLETECH_SIMPLESHARE:
 		bcm47xx_set_pdata(bcm47xx_leds_simpletech_simpleshare);
 		break;
diff --git a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h b/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
index a564a9f..60d3742 100644
--- a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
+++ b/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
@@ -94,6 +94,8 @@ enum bcm47xx_board {
 
 	BCM47XX_BOARD_PHICOMM_M1,
 
+	BCM47XX_BOARD_SIEMENS_SE505V2,
+
 	BCM47XX_BOARD_SIMPLETECH_SIMPLESHARE,
 
 	BCM47XX_BOARD_ZTE_H218N,
-- 
1.7.10.4
