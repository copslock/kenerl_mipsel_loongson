Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2013 16:55:57 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:46417 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817537Ab3IROzy415u1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Sep 2013 16:55:54 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 492508F61;
        Wed, 18 Sep 2013 16:55:54 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id i7hbFgcrn7Bv; Wed, 18 Sep 2013 16:55:50 +0200 (CEST)
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 19391857F;
        Wed, 18 Sep 2013 16:55:50 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, geert@linux-m68k.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2] MIPS: BCM47XX: put board detention data into init section
Date:   Wed, 18 Sep 2013 16:55:46 +0200
Message-Id: <1379516146-24037-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37871
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

Place the data and code needed for board detection into the init
section. Now the kernel is able to free this space after booting.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---

v2: use strlcpy()

 arch/mips/bcm47xx/board.c                          |   63 ++++++++++++--------
 arch/mips/bcm47xx/setup.c                          |    1 +
 arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h |    3 +
 3 files changed, 42 insertions(+), 25 deletions(-)

diff --git a/arch/mips/bcm47xx/board.c b/arch/mips/bcm47xx/board.c
index 4af2f8c..f3f6bfe 100644
--- a/arch/mips/bcm47xx/board.c
+++ b/arch/mips/bcm47xx/board.c
@@ -26,27 +26,36 @@ struct bcm47xx_board_type_list3 {
 	const char *value3;
 };
 
+struct bcm47xx_board_store {
+	enum bcm47xx_board board;
+	char name[BCM47XX_BOARD_MAX_NAME];
+};
+
 /* model_name */
-static const struct bcm47xx_board_type_list1 bcm47xx_board_list_model_name[] = {
+static const
+struct bcm47xx_board_type_list1 bcm47xx_board_list_model_name[] __initconst = {
 	{{BCM47XX_BOARD_DLINK_DIR130, "D-Link DIR-130"}, "DIR-130"},
 	{{BCM47XX_BOARD_DLINK_DIR330, "D-Link DIR-330"}, "DIR-330"},
 	{ {0}, 0},
 };
 
 /* model_no */
-static const struct bcm47xx_board_type_list1 bcm47xx_board_list_model_no[] = {
+static const
+struct bcm47xx_board_type_list1 bcm47xx_board_list_model_no[] __initconst = {
 	{{BCM47XX_BOARD_ASUS_WL700GE, "Asus WL700"}, "WL700"},
 	{ {0}, 0},
 };
 
 /* machine_name */
-static const struct bcm47xx_board_type_list1 bcm47xx_board_list_machine_name[] = {
+static const
+struct bcm47xx_board_type_list1 bcm47xx_board_list_machine_name[] __initconst = {
 	{{BCM47XX_BOARD_LINKSYS_WRTSL54GS, "Linksys WRTSL54GS"}, "WRTSL54GS"},
 	{ {0}, 0},
 };
 
 /* hardware_version */
-static const struct bcm47xx_board_type_list1 bcm47xx_board_list_hardware_version[] = {
+static const
+struct bcm47xx_board_type_list1 bcm47xx_board_list_hardware_version[] __initconst = {
 	{{BCM47XX_BOARD_ASUS_RTN16, "Asus RT-N16"}, "RT-N16-"},
 	{{BCM47XX_BOARD_ASUS_WL320GE, "Asus WL320GE"}, "WL320G-"},
 	{{BCM47XX_BOARD_ASUS_WL330GE, "Asus WL330GE"}, "WL330GE-"},
@@ -61,7 +70,8 @@ static const struct bcm47xx_board_type_list1 bcm47xx_board_list_hardware_version
 };
 
 /* productid */
-static const struct bcm47xx_board_type_list1 bcm47xx_board_list_productid[] = {
+static const
+struct bcm47xx_board_type_list1 bcm47xx_board_list_productid[] __initconst = {
 	{{BCM47XX_BOARD_ASUS_RTAC66U, "Asus RT-AC66U"}, "RT-AC66U"},
 	{{BCM47XX_BOARD_ASUS_RTN10, "Asus RT-N10"}, "RT-N10"},
 	{{BCM47XX_BOARD_ASUS_RTN10D, "Asus RT-N10D"}, "RT-N10D"},
@@ -81,7 +91,8 @@ static const struct bcm47xx_board_type_list1 bcm47xx_board_list_productid[] = {
 };
 
 /* ModelId */
-static const struct bcm47xx_board_type_list1 bcm47xx_board_list_ModelId[] = {
+static const
+struct bcm47xx_board_type_list1 bcm47xx_board_list_ModelId[] __initconst = {
 	{{BCM47XX_BOARD_DELL_TM2300, "Dell WX-5565"}, "WX-5565"},
 	{{BCM47XX_BOARD_MOTOROLA_WE800G, "Motorola WE800G"}, "WE800G"},
 	{{BCM47XX_BOARD_MOTOROLA_WR850GP, "Motorola WR850GP"}, "WR850GP"},
@@ -90,7 +101,8 @@ static const struct bcm47xx_board_type_list1 bcm47xx_board_list_ModelId[] = {
 };
 
 /* melco_id or buf1falo_id */
-static const struct bcm47xx_board_type_list1 bcm47xx_board_list_melco_id[] = {
+static const
+struct bcm47xx_board_type_list1 bcm47xx_board_list_melco_id[] __initconst = {
 	{{BCM47XX_BOARD_BUFFALO_WBR2_G54, "Buffalo WBR2-G54"}, "29bb0332"},
 	{{BCM47XX_BOARD_BUFFALO_WHR2_A54G54, "Buffalo WHR2-A54G54"}, "290441dd"},
 	{{BCM47XX_BOARD_BUFFALO_WHR_G125, "Buffalo WHR-G125"}, "32093"},
@@ -104,7 +116,8 @@ static const struct bcm47xx_board_type_list1 bcm47xx_board_list_melco_id[] = {
 };
 
 /* boot_hw_model, boot_hw_ver */
-static const struct bcm47xx_board_type_list2 bcm47xx_board_list_boot_hw[] = {
+static const
+struct bcm47xx_board_type_list2 bcm47xx_board_list_boot_hw[] __initconst = {
 	/* like WRT160N v3.0 */
 	{{BCM47XX_BOARD_CISCO_M10V1, "Cisco M10"}, "M10", "1.0"},
 	/* like WRT310N v2.0 */
@@ -134,7 +147,8 @@ static const struct bcm47xx_board_type_list2 bcm47xx_board_list_boot_hw[] = {
 };
 
 /* board_id */
-static const struct bcm47xx_board_type_list1 bcm47xx_board_list_board_id[] = {
+static const
+struct bcm47xx_board_type_list1 bcm47xx_board_list_board_id[] __initconst = {
 	{{BCM47XX_BOARD_NETGEAR_WGR614V8, "Netgear WGR614 V8"}, "U12H072T00_NETGEAR"},
 	{{BCM47XX_BOARD_NETGEAR_WGR614V9, "Netgear WGR614 V9"}, "U12H094T00_NETGEAR"},
 	{{BCM47XX_BOARD_NETGEAR_WNDR3300, "Netgear WNDR3300"}, "U12H093T00_NETGEAR"},
@@ -155,24 +169,22 @@ static const struct bcm47xx_board_type_list1 bcm47xx_board_list_board_id[] = {
 };
 
 /* boardtype, boardnum, boardrev */
-static const struct bcm47xx_board_type_list3 bcm47xx_board_list_board[] = {
+static const
+struct bcm47xx_board_type_list3 bcm47xx_board_list_board[] __initconst = {
 	{{BCM47XX_BOARD_HUAWEI_E970, "Huawei E970"}, "0x048e", "0x5347", "0x11"},
 	{{BCM47XX_BOARD_PHICOMM_M1, "Phicomm M1"}, "0x0590", "80", "0x1104"},
 	{{BCM47XX_BOARD_ZTE_H218N, "ZTE H218N"}, "0x053d", "1234", "0x1305"},
 	{ {0}, 0},
 };
 
-static const struct bcm47xx_board_type bcm47xx_board_unknown[] = {
+static const
+struct bcm47xx_board_type bcm47xx_board_unknown[] __initconst = {
 	{BCM47XX_BOARD_UNKNOWN, "Unknown Board"},
 };
 
-static const struct bcm47xx_board_type bcm47xx_board_no[] = {
-	{BCM47XX_BOARD_NO, "No Board"},
-};
-
-static const struct bcm47xx_board_type *bcm47xx_board = bcm47xx_board_no;
+static struct bcm47xx_board_store bcm47xx_board = {BCM47XX_BOARD_NO, "Unknown Board"};
 
-static const struct bcm47xx_board_type *bcm47xx_board_get_nvram(void)
+static __init const struct bcm47xx_board_type *bcm47xx_board_get_nvram(void)
 {
 	char buf1[30];
 	char buf2[30];
@@ -261,12 +273,13 @@ static const struct bcm47xx_board_type *bcm47xx_board_get_nvram(void)
 	return bcm47xx_board_unknown;
 }
 
-static void bcm47xx_board_detect(void)
+void __init bcm47xx_board_detect(void)
 {
 	int err;
 	char buf[10];
+	const struct bcm47xx_board_type *board_detected;
 
-	if (bcm47xx_board != bcm47xx_board_no)
+	if (bcm47xx_board.board != BCM47XX_BOARD_NO)
 		return;
 
 	/* check if the nvram is available */
@@ -277,20 +290,20 @@ static void bcm47xx_board_detect(void)
 		return;
 	}
 
-	bcm47xx_board = bcm47xx_board_get_nvram();
-	pr_debug("Found board: \"%s\"\n", bcm47xx_board->name);
+	board_detected = bcm47xx_board_get_nvram();
+	bcm47xx_board.board = board_detected->board;
+	strlcpy(bcm47xx_board.name, board_detected->name,
+		BCM47XX_BOARD_MAX_NAME);
 }
 
 enum bcm47xx_board bcm47xx_board_get(void)
 {
-	bcm47xx_board_detect();
-	return bcm47xx_board->board;
+	return bcm47xx_board.board;
 }
 EXPORT_SYMBOL(bcm47xx_board_get);
 
 const char *bcm47xx_board_get_name(void)
 {
-	bcm47xx_board_detect();
-	return bcm47xx_board->name;
+	return bcm47xx_board.name;
 }
 EXPORT_SYMBOL(bcm47xx_board_get_name);
diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index b2246cd..6d22761 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -221,6 +221,7 @@ void __init plat_mem_setup(void)
 	_machine_restart = bcm47xx_machine_restart;
 	_machine_halt = bcm47xx_machine_halt;
 	pm_power_off = bcm47xx_machine_halt;
+	bcm47xx_board_detect();
 }
 
 static int __init bcm47xx_register_bus_complete(void)
diff --git a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h b/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
index 9183721..00867dd 100644
--- a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
+++ b/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
@@ -101,6 +101,9 @@ enum bcm47xx_board {
 	BCM47XX_BOARD_NO,
 };
 
+#define BCM47XX_BOARD_MAX_NAME 30
+
+void bcm47xx_board_detect(void);
 enum bcm47xx_board bcm47xx_board_get(void);
 const char *bcm47xx_board_get_name(void);
 
-- 
1.7.10.4
