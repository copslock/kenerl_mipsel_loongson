Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Mar 2014 17:50:35 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:52783 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6865308AbaCBQtuD3Don (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Mar 2014 17:49:50 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 991E47E25;
        Sun,  2 Mar 2014 17:49:49 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6XVyymV1YyFy; Sun,  2 Mar 2014 17:49:45 +0100 (CET)
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 87FF67E2C;
        Sun,  2 Mar 2014 17:49:32 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, zajec5@gmail.com,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Cody P Schafer <devel@codyps.com>
Subject: [PATCH 4/4] MIPS: BCM47XX: add Belkin F7Dxxxx board detection
Date:   Sun,  2 Mar 2014 17:49:29 +0100
Message-Id: <1393778969-21066-4-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1393778969-21066-1-git-send-email-hauke@hauke-m.de>
References: <1393778969-21066-1-git-send-email-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39396
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

From: Cody P Schafer <devel@codyps.com>

Add a few Belkin F7Dxxxx entries, with F7D4401 sourced from online
documentation and the "F7D7302" being observed. F7D3301, F7D3302, and
F7D4302 are reasonable guesses which are unlikely to cause
mis-detection.

Signed-off-by: Cody P Schafer <devel@codyps.com>
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/board.c                          |    4 ++++
 arch/mips/bcm47xx/buttons.c                        |    4 ++++
 arch/mips/bcm47xx/leds.c                           |    4 ++++
 arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h |    4 ++++
 4 files changed, 16 insertions(+)

diff --git a/arch/mips/bcm47xx/board.c b/arch/mips/bcm47xx/board.c
index 1ddc643..cb5ff13 100644
--- a/arch/mips/bcm47xx/board.c
+++ b/arch/mips/bcm47xx/board.c
@@ -72,7 +72,11 @@ struct bcm47xx_board_type_list1 bcm47xx_board_list_hardware_version[] __initcons
 	{{BCM47XX_BOARD_ASUS_WL500W, "Asus WL500W"}, "WL500gW-"},
 	{{BCM47XX_BOARD_ASUS_WL520GC, "Asus WL520GC"}, "WL520GC-"},
 	{{BCM47XX_BOARD_ASUS_WL520GU, "Asus WL520GU"}, "WL520GU-"},
+	{{BCM47XX_BOARD_BELKIN_F7D3301, "Belkin F7D3301"}, "F7D3301"},
+	{{BCM47XX_BOARD_BELKIN_F7D3302, "Belkin F7D3302"}, "F7D3302"},
 	{{BCM47XX_BOARD_BELKIN_F7D4301, "Belkin F7D4301"}, "F7D4301"},
+	{{BCM47XX_BOARD_BELKIN_F7D4302, "Belkin F7D4302"}, "F7D4302"},
+	{{BCM47XX_BOARD_BELKIN_F7D4401, "Belkin F7D4401"}, "F7D4401"},
 	{ {0}, NULL},
 };
 
diff --git a/arch/mips/bcm47xx/buttons.c b/arch/mips/bcm47xx/buttons.c
index f165887..49a1ce0 100644
--- a/arch/mips/bcm47xx/buttons.c
+++ b/arch/mips/bcm47xx/buttons.c
@@ -420,7 +420,11 @@ int __init bcm47xx_buttons_register(void)
 		err = bcm47xx_copy_bdata(bcm47xx_buttons_asus_wlhdd);
 		break;
 
+	case BCM47XX_BOARD_BELKIN_F7D3301:
+	case BCM47XX_BOARD_BELKIN_F7D3302:
 	case BCM47XX_BOARD_BELKIN_F7D4301:
+	case BCM47XX_BOARD_BELKIN_F7D4302:
+	case BCM47XX_BOARD_BELKIN_F7D4401:
 		err = bcm47xx_copy_bdata(bcm47xx_buttons_belkin_f7d4301);
 		break;
 
diff --git a/arch/mips/bcm47xx/leds.c b/arch/mips/bcm47xx/leds.c
index 8bacc37..adcb547 100644
--- a/arch/mips/bcm47xx/leds.c
+++ b/arch/mips/bcm47xx/leds.c
@@ -457,7 +457,11 @@ void __init bcm47xx_leds_register(void)
 		bcm47xx_set_pdata(bcm47xx_leds_asus_wlhdd);
 		break;
 
+	case BCM47XX_BOARD_BELKIN_F7D3301:
+	case BCM47XX_BOARD_BELKIN_F7D3302:
 	case BCM47XX_BOARD_BELKIN_F7D4301:
+	case BCM47XX_BOARD_BELKIN_F7D4302:
+	case BCM47XX_BOARD_BELKIN_F7D4401:
 		bcm47xx_set_pdata(bcm47xx_leds_belkin_f7d4301);
 		break;
 
diff --git a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h b/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
index 60d3742..bba7399 100644
--- a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
+++ b/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
@@ -27,7 +27,11 @@ enum bcm47xx_board {
 	BCM47XX_BOARD_ASUS_WL700GE,
 	BCM47XX_BOARD_ASUS_WLHDD,
 
+	BCM47XX_BOARD_BELKIN_F7D3301,
+	BCM47XX_BOARD_BELKIN_F7D3302,
 	BCM47XX_BOARD_BELKIN_F7D4301,
+	BCM47XX_BOARD_BELKIN_F7D4302,
+	BCM47XX_BOARD_BELKIN_F7D4401,
 
 	BCM47XX_BOARD_BUFFALO_WBR2_G54,
 	BCM47XX_BOARD_BUFFALO_WHR2_A54G54,
-- 
1.7.10.4
