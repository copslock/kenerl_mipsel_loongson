Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jan 2014 20:42:16 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:53489 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6825733AbaACTmM4LJ0Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Jan 2014 20:42:12 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id E10CB8F63;
        Fri,  3 Jan 2014 20:42:11 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zxghloOt4B4D; Fri,  3 Jan 2014 20:42:08 +0100 (CET)
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id A89B6857F;
        Fri,  3 Jan 2014 20:42:08 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, blogic@openwrt.org
Cc:     linux-mips@linux-mips.org, zajec5@gmail.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 1/3] MIPS: BCM47XX: fix detection for some boards
Date:   Fri,  3 Jan 2014 20:41:58 +0100
Message-Id: <1388778120-24880-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38862
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

When a nvram reset was performed from CFE, it sometimes does not
contain the productid value in nvram, but it still contains
hardware_version.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/board.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/mips/bcm47xx/board.c b/arch/mips/bcm47xx/board.c
index f3f6bfe..a456b04 100644
--- a/arch/mips/bcm47xx/board.c
+++ b/arch/mips/bcm47xx/board.c
@@ -56,6 +56,12 @@ struct bcm47xx_board_type_list1 bcm47xx_board_list_machine_name[] __initconst =
 /* hardware_version */
 static const
 struct bcm47xx_board_type_list1 bcm47xx_board_list_hardware_version[] __initconst = {
+	{{BCM47XX_BOARD_ASUS_RTN10U, "Asus RT-N10U"}, "RTN10U"},
+	{{BCM47XX_BOARD_ASUS_RTN12, "Asus RT-N12"}, "RT-N12"},
+	{{BCM47XX_BOARD_ASUS_RTN12B1, "Asus RT-N12B1"}, "RTN12B1"},
+	{{BCM47XX_BOARD_ASUS_RTN12C1, "Asus RT-N12C1"}, "RTN12C1"},
+	{{BCM47XX_BOARD_ASUS_RTN12D1, "Asus RT-N12D1"}, "RTN12D1"},
+	{{BCM47XX_BOARD_ASUS_RTN12HP, "Asus RT-N12HP"}, "RTN12HP"},
 	{{BCM47XX_BOARD_ASUS_RTN16, "Asus RT-N16"}, "RT-N16-"},
 	{{BCM47XX_BOARD_ASUS_WL320GE, "Asus WL320GE"}, "WL320G-"},
 	{{BCM47XX_BOARD_ASUS_WL330GE, "Asus WL330GE"}, "WL330GE-"},
@@ -75,12 +81,6 @@ struct bcm47xx_board_type_list1 bcm47xx_board_list_productid[] __initconst = {
 	{{BCM47XX_BOARD_ASUS_RTAC66U, "Asus RT-AC66U"}, "RT-AC66U"},
 	{{BCM47XX_BOARD_ASUS_RTN10, "Asus RT-N10"}, "RT-N10"},
 	{{BCM47XX_BOARD_ASUS_RTN10D, "Asus RT-N10D"}, "RT-N10D"},
-	{{BCM47XX_BOARD_ASUS_RTN10U, "Asus RT-N10U"}, "RT-N10U"},
-	{{BCM47XX_BOARD_ASUS_RTN12, "Asus RT-N12"}, "RT-N12"},
-	{{BCM47XX_BOARD_ASUS_RTN12B1, "Asus RT-N12B1"}, "RT-N12B1"},
-	{{BCM47XX_BOARD_ASUS_RTN12C1, "Asus RT-N12C1"}, "RT-N12C1"},
-	{{BCM47XX_BOARD_ASUS_RTN12D1, "Asus RT-N12D1"}, "RT-N12D1"},
-	{{BCM47XX_BOARD_ASUS_RTN12HP, "Asus RT-N12HP"}, "RT-N12HP"},
 	{{BCM47XX_BOARD_ASUS_RTN15U, "Asus RT-N15U"}, "RT-N15U"},
 	{{BCM47XX_BOARD_ASUS_RTN16, "Asus RT-N16"}, "RT-N16"},
 	{{BCM47XX_BOARD_ASUS_RTN53, "Asus RT-N53"}, "RT-N53"},
@@ -174,6 +174,7 @@ struct bcm47xx_board_type_list3 bcm47xx_board_list_board[] __initconst = {
 	{{BCM47XX_BOARD_HUAWEI_E970, "Huawei E970"}, "0x048e", "0x5347", "0x11"},
 	{{BCM47XX_BOARD_PHICOMM_M1, "Phicomm M1"}, "0x0590", "80", "0x1104"},
 	{{BCM47XX_BOARD_ZTE_H218N, "ZTE H218N"}, "0x053d", "1234", "0x1305"},
+	{{BCM47XX_BOARD_NETGEAR_WNR3500L, "Netgear WNR3500L"}, "0x04CF", "3500", "02"},
 	{ {0}, 0},
 };
 
-- 
1.7.10.4
