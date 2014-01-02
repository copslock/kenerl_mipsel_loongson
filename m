Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jan 2014 19:25:52 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:47469 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6821116AbaABSZuLkj3d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jan 2014 19:25:50 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id A1A20857F;
        Thu,  2 Jan 2014 19:25:48 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fOheykdcJ1sc; Thu,  2 Jan 2014 19:25:44 +0100 (CET)
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 2D79C8F61;
        Thu,  2 Jan 2014 19:25:43 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, blogic@openwrt.org
Cc:     linux-mips@linux-mips.org, zajec5@gmail.com,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Cody P Schafer <devel@codyps.com>
Subject: [PATCH 1/4] MIPS: BCM47XX: add Belkin F7Dxxxx board detection
Date:   Thu,  2 Jan 2014 19:25:35 +0100
Message-Id: <1388687138-8107-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38841
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

It also appears that at least the F7D3302, F7D3301, F7D7301, and F7D7302
have a shared boardtype and boardrev, so use that as a fallback to a
"generic" F7Dxxxx board.

Signed-off-by: Cody P Schafer <devel@codyps.com>
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/board.c                          |   12 +++++++++---
 arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h |    5 +++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/mips/bcm47xx/board.c b/arch/mips/bcm47xx/board.c
index f3f6bfe..b790bb7 100644
--- a/arch/mips/bcm47xx/board.c
+++ b/arch/mips/bcm47xx/board.c
@@ -65,7 +65,12 @@ struct bcm47xx_board_type_list1 bcm47xx_board_list_hardware_version[] __initcons
 	{{BCM47XX_BOARD_ASUS_WL500W, "Asus WL500W"}, "WL500gW-"},
 	{{BCM47XX_BOARD_ASUS_WL520GC, "Asus WL520GC"}, "WL520GC-"},
 	{{BCM47XX_BOARD_ASUS_WL520GU, "Asus WL520GU"}, "WL520GU-"},
+	{{BCM47XX_BOARD_BELKIN_F7D3301, "Belkin F7D3301"}, "F7D3301"},
+	{{BCM47XX_BOARD_BELKIN_F7D3302, "Belkin F7D3302"}, "F7D3302"},
+	{{BCM47XX_BOARD_BELKIN_F7D3302, "Belkin F7D7302"}, "F7D7302 v1"},
 	{{BCM47XX_BOARD_BELKIN_F7D4301, "Belkin F7D4301"}, "F7D4301"},
+	{{BCM47XX_BOARD_BELKIN_F7D4302, "Belkin F7D4302"}, "F7D4302"},
+	{{BCM47XX_BOARD_BELKIN_F7D4401, "Belkin F7D4401"}, "F7D4401"},
 	{ {0}, 0},
 };
 
@@ -174,6 +179,7 @@ struct bcm47xx_board_type_list3 bcm47xx_board_list_board[] __initconst = {
 	{{BCM47XX_BOARD_HUAWEI_E970, "Huawei E970"}, "0x048e", "0x5347", "0x11"},
 	{{BCM47XX_BOARD_PHICOMM_M1, "Phicomm M1"}, "0x0590", "80", "0x1104"},
 	{{BCM47XX_BOARD_ZTE_H218N, "ZTE H218N"}, "0x053d", "1234", "0x1305"},
+	{{BCM47XX_BOARD_BELKIN_F7DXXXX, "Belkin F7Dxxxx"}, "0xa4cf", NULL, "0x1102"},
 	{ {0}, 0},
 };
 
@@ -264,9 +270,9 @@ static __init const struct bcm47xx_board_type *bcm47xx_board_get_nvram(void)
 	    bcm47xx_nvram_getenv("boardnum", buf2, sizeof(buf2)) >= 0 &&
 	    bcm47xx_nvram_getenv("boardrev", buf3, sizeof(buf3)) >= 0) {
 		for (e3 = bcm47xx_board_list_board; e3->value1; e3++) {
-			if (!strcmp(buf1, e3->value1) &&
-			    !strcmp(buf2, e3->value2) &&
-			    !strcmp(buf3, e3->value3))
+			if ((!e3->value1 || !strcmp(buf1, e3->value1)) &&
+			    (!e3->value2 || !strcmp(buf2, e3->value2)) &&
+			    (!e3->value3 || !strcmp(buf3, e3->value3)))
 				return &e3->board;
 		}
 	}
diff --git a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h b/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
index 00867dd..aa500f8 100644
--- a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
+++ b/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
@@ -27,7 +27,12 @@ enum bcm47xx_board {
 	BCM47XX_BOARD_ASUS_WL700GE,
 	BCM47XX_BOARD_ASUS_WLHDD,
 
+	BCM47XX_BOARD_BELKIN_F7DXXXX,
+	BCM47XX_BOARD_BELKIN_F7D3301,
+	BCM47XX_BOARD_BELKIN_F7D3302,
 	BCM47XX_BOARD_BELKIN_F7D4301,
+	BCM47XX_BOARD_BELKIN_F7D4302,
+	BCM47XX_BOARD_BELKIN_F7D4401,
 
 	BCM47XX_BOARD_BUFFALO_WBR2_G54,
 	BCM47XX_BOARD_BUFFALO_WHR2_A54G54,
-- 
1.7.10.4
