Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jan 2014 20:43:35 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:53502 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6825752AbaACTmTt6zBe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Jan 2014 20:42:19 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 571E8857F;
        Fri,  3 Jan 2014 20:42:18 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id I9KtbFVVJoeY; Fri,  3 Jan 2014 20:42:15 +0100 (CET)
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 1A44D8F62;
        Fri,  3 Jan 2014 20:42:09 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, blogic@openwrt.org
Cc:     linux-mips@linux-mips.org, zajec5@gmail.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 3/3] MIPS: BCM47XX: fix sparse warnings in board.c
Date:   Fri,  3 Jan 2014 20:42:00 +0100
Message-Id: <1388778120-24880-3-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1388778120-24880-1-git-send-email-hauke@hauke-m.de>
References: <1388778120-24880-1-git-send-email-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38864
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

This fixes the following sparse warnings:
arch/mips/bcm47xx/board.c:39:16: warning: Using plain integer as NULL pointer
arch/mips/bcm47xx/board.c:46:16: warning: Using plain integer as NULL pointer
arch/mips/bcm47xx/board.c:53:16: warning: Using plain integer as NULL pointer
arch/mips/bcm47xx/board.c:78:16: warning: Using plain integer as NULL pointer
arch/mips/bcm47xx/board.c:99:16: warning: Using plain integer as NULL pointer
arch/mips/bcm47xx/board.c:109:16: warning: Using plain integer as NULL pointer
arch/mips/bcm47xx/board.c:124:16: warning: Using plain integer as NULL pointer
arch/mips/bcm47xx/board.c:155:16: warning: Using plain integer as NULL pointer
arch/mips/bcm47xx/board.c:177:16: warning: Using plain integer as NULL pointer
arch/mips/bcm47xx/board.c:189:16: warning: Using plain integer as NULL pointer

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/board.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/mips/bcm47xx/board.c b/arch/mips/bcm47xx/board.c
index 40a9ac2..6d612e2 100644
--- a/arch/mips/bcm47xx/board.c
+++ b/arch/mips/bcm47xx/board.c
@@ -36,21 +36,21 @@ static const
 struct bcm47xx_board_type_list1 bcm47xx_board_list_model_name[] __initconst = {
 	{{BCM47XX_BOARD_DLINK_DIR130, "D-Link DIR-130"}, "DIR-130"},
 	{{BCM47XX_BOARD_DLINK_DIR330, "D-Link DIR-330"}, "DIR-330"},
-	{ {0}, 0},
+	{ {0}, NULL},
 };
 
 /* model_no */
 static const
 struct bcm47xx_board_type_list1 bcm47xx_board_list_model_no[] __initconst = {
 	{{BCM47XX_BOARD_ASUS_WL700GE, "Asus WL700"}, "WL700"},
-	{ {0}, 0},
+	{ {0}, NULL},
 };
 
 /* machine_name */
 static const
 struct bcm47xx_board_type_list1 bcm47xx_board_list_machine_name[] __initconst = {
 	{{BCM47XX_BOARD_LINKSYS_WRTSL54GS, "Linksys WRTSL54GS"}, "WRTSL54GS"},
-	{ {0}, 0},
+	{ {0}, NULL},
 };
 
 /* hardware_version */
@@ -72,7 +72,7 @@ struct bcm47xx_board_type_list1 bcm47xx_board_list_hardware_version[] __initcons
 	{{BCM47XX_BOARD_ASUS_WL520GC, "Asus WL520GC"}, "WL520GC-"},
 	{{BCM47XX_BOARD_ASUS_WL520GU, "Asus WL520GU"}, "WL520GU-"},
 	{{BCM47XX_BOARD_BELKIN_F7D4301, "Belkin F7D4301"}, "F7D4301"},
-	{ {0}, 0},
+	{ {0}, NULL},
 };
 
 /* productid */
@@ -87,7 +87,7 @@ struct bcm47xx_board_type_list1 bcm47xx_board_list_productid[] __initconst = {
 	{{BCM47XX_BOARD_ASUS_RTN66U, "Asus RT-N66U"}, "RT-N66U"},
 	{{BCM47XX_BOARD_ASUS_WL300G, "Asus WL300G"}, "WL300g"},
 	{{BCM47XX_BOARD_ASUS_WLHDD, "Asus WLHDD"}, "WLHDD"},
-	{ {0}, 0},
+	{ {0}, NULL},
 };
 
 /* ModelId */
@@ -97,7 +97,7 @@ struct bcm47xx_board_type_list1 bcm47xx_board_list_ModelId[] __initconst = {
 	{{BCM47XX_BOARD_MOTOROLA_WE800G, "Motorola WE800G"}, "WE800G"},
 	{{BCM47XX_BOARD_MOTOROLA_WR850GP, "Motorola WR850GP"}, "WR850GP"},
 	{{BCM47XX_BOARD_MOTOROLA_WR850GV2V3, "Motorola WR850G"}, "WR850G"},
-	{ {0}, 0},
+	{ {0}, NULL},
 };
 
 /* melco_id or buf1falo_id */
@@ -112,7 +112,7 @@ struct bcm47xx_board_type_list1 bcm47xx_board_list_melco_id[] __initconst = {
 	{{BCM47XX_BOARD_BUFFALO_WZR_G300N, "Buffalo WZR-G300N"}, "31120"},
 	{{BCM47XX_BOARD_BUFFALO_WZR_RS_G54, "Buffalo WZR-RS-G54"}, "30083"},
 	{{BCM47XX_BOARD_BUFFALO_WZR_RS_G54HP, "Buffalo WZR-RS-G54HP"}, "30103"},
-	{ {0}, 0},
+	{ {0}, NULL},
 };
 
 /* boot_hw_model, boot_hw_ver */
@@ -143,7 +143,7 @@ struct bcm47xx_board_type_list2 bcm47xx_board_list_boot_hw[] __initconst = {
 	{{BCM47XX_BOARD_LINKSYS_WRT54G3GV2, "Linksys WRT54G3GV2-VF"}, "WRT54G3GV2-VF", "1.0"},
 	{{BCM47XX_BOARD_LINKSYS_WRT610NV1, "Linksys WRT610N V1"}, "WRT610N", "1.0"},
 	{{BCM47XX_BOARD_LINKSYS_WRT610NV2, "Linksys WRT610N V2"}, "WRT610N", "2.0"},
-	{ {0}, 0},
+	{ {0}, NULL},
 };
 
 /* board_id */
@@ -165,7 +165,7 @@ struct bcm47xx_board_type_list1 bcm47xx_board_list_board_id[] __initconst = {
 	{{BCM47XX_BOARD_NETGEAR_WNR3500V2, "Netgear WNR3500 V2"}, "U12H127T00_NETGEAR"},
 	{{BCM47XX_BOARD_NETGEAR_WNR3500V2VC, "Netgear WNR3500 V2vc"}, "U12H127T70_NETGEAR"},
 	{{BCM47XX_BOARD_NETGEAR_WNR834BV2, "Netgear WNR834B V2"}, "U12H081T00_NETGEAR"},
-	{ {0}, 0},
+	{ {0}, NULL},
 };
 
 /* boardtype, boardnum, boardrev */
@@ -176,7 +176,7 @@ struct bcm47xx_board_type_list3 bcm47xx_board_list_board[] __initconst = {
 	{{BCM47XX_BOARD_ZTE_H218N, "ZTE H218N"}, "0x053d", "1234", "0x1305"},
 	{{BCM47XX_BOARD_NETGEAR_WNR3500L, "Netgear WNR3500L"}, "0x04CF", "3500", "02"},
 	{{BCM47XX_BOARD_LINKSYS_WRT54GSV1, "Linksys WRT54GS V1"}, "0x0101", "42", "0x10"},
-	{ {0}, 0},
+	{ {0}, NULL},
 };
 
 static const
-- 
1.7.10.4
