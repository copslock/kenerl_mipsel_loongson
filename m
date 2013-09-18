Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2013 13:30:32 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:44738 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6825760Ab3IRLaMeEt0z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Sep 2013 13:30:12 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 1A55B8F61;
        Wed, 18 Sep 2013 13:30:12 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id l6GZBLIQrjZh; Wed, 18 Sep 2013 13:30:01 +0200 (CEST)
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id A2D90857F;
        Wed, 18 Sep 2013 13:30:01 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/2] MIPS: BCM47XX: add board detection
Date:   Wed, 18 Sep 2013 13:29:57 +0200
Message-Id: <1379503798-9014-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37845
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

Detect on which board this code is running based on some nvram
settings. This is needed to start board specific workarounds and
configure the leds and buttons which are on different gpios on every board.

This patches add some boards we have seen, but there are many more.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/Makefile                         |    1 +
 arch/mips/bcm47xx/board.c                          |  296 ++++++++++++++++++++
 arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h |  107 +++++++
 3 files changed, 404 insertions(+)
 create mode 100644 arch/mips/bcm47xx/board.c
 create mode 100644 arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h

diff --git a/arch/mips/bcm47xx/Makefile b/arch/mips/bcm47xx/Makefile
index f3bf6d5..c52daf9 100644
--- a/arch/mips/bcm47xx/Makefile
+++ b/arch/mips/bcm47xx/Makefile
@@ -4,4 +4,5 @@
 #
 
 obj-y				+= irq.o nvram.o prom.o serial.o setup.o time.o sprom.o
+obj-y				+= board.o
 obj-$(CONFIG_BCM47XX_SSB)	+= wgt634u.o
diff --git a/arch/mips/bcm47xx/board.c b/arch/mips/bcm47xx/board.c
new file mode 100644
index 0000000..4af2f8c
--- /dev/null
+++ b/arch/mips/bcm47xx/board.c
@@ -0,0 +1,296 @@
+#include <linux/export.h>
+#include <linux/string.h>
+#include <bcm47xx_board.h>
+#include <bcm47xx_nvram.h>
+
+struct bcm47xx_board_type {
+	const enum bcm47xx_board board;
+	const char *name;
+};
+
+struct bcm47xx_board_type_list1 {
+	struct bcm47xx_board_type board;
+	const char *value1;
+};
+
+struct bcm47xx_board_type_list2 {
+	struct bcm47xx_board_type board;
+	const char *value1;
+	const char *value2;
+};
+
+struct bcm47xx_board_type_list3 {
+	struct bcm47xx_board_type board;
+	const char *value1;
+	const char *value2;
+	const char *value3;
+};
+
+/* model_name */
+static const struct bcm47xx_board_type_list1 bcm47xx_board_list_model_name[] = {
+	{{BCM47XX_BOARD_DLINK_DIR130, "D-Link DIR-130"}, "DIR-130"},
+	{{BCM47XX_BOARD_DLINK_DIR330, "D-Link DIR-330"}, "DIR-330"},
+	{ {0}, 0},
+};
+
+/* model_no */
+static const struct bcm47xx_board_type_list1 bcm47xx_board_list_model_no[] = {
+	{{BCM47XX_BOARD_ASUS_WL700GE, "Asus WL700"}, "WL700"},
+	{ {0}, 0},
+};
+
+/* machine_name */
+static const struct bcm47xx_board_type_list1 bcm47xx_board_list_machine_name[] = {
+	{{BCM47XX_BOARD_LINKSYS_WRTSL54GS, "Linksys WRTSL54GS"}, "WRTSL54GS"},
+	{ {0}, 0},
+};
+
+/* hardware_version */
+static const struct bcm47xx_board_type_list1 bcm47xx_board_list_hardware_version[] = {
+	{{BCM47XX_BOARD_ASUS_RTN16, "Asus RT-N16"}, "RT-N16-"},
+	{{BCM47XX_BOARD_ASUS_WL320GE, "Asus WL320GE"}, "WL320G-"},
+	{{BCM47XX_BOARD_ASUS_WL330GE, "Asus WL330GE"}, "WL330GE-"},
+	{{BCM47XX_BOARD_ASUS_WL500GD, "Asus WL500GD"}, "WL500gd-"},
+	{{BCM47XX_BOARD_ASUS_WL500GPV1, "Asus WL500GP V1"}, "WL500gp-"},
+	{{BCM47XX_BOARD_ASUS_WL500GPV2, "Asus WL500GP V2"}, "WL500GPV2-"},
+	{{BCM47XX_BOARD_ASUS_WL500W, "Asus WL500W"}, "WL500gW-"},
+	{{BCM47XX_BOARD_ASUS_WL520GC, "Asus WL520GC"}, "WL520GC-"},
+	{{BCM47XX_BOARD_ASUS_WL520GU, "Asus WL520GU"}, "WL520GU-"},
+	{{BCM47XX_BOARD_BELKIN_F7D4301, "Belkin F7D4301"}, "F7D4301"},
+	{ {0}, 0},
+};
+
+/* productid */
+static const struct bcm47xx_board_type_list1 bcm47xx_board_list_productid[] = {
+	{{BCM47XX_BOARD_ASUS_RTAC66U, "Asus RT-AC66U"}, "RT-AC66U"},
+	{{BCM47XX_BOARD_ASUS_RTN10, "Asus RT-N10"}, "RT-N10"},
+	{{BCM47XX_BOARD_ASUS_RTN10D, "Asus RT-N10D"}, "RT-N10D"},
+	{{BCM47XX_BOARD_ASUS_RTN10U, "Asus RT-N10U"}, "RT-N10U"},
+	{{BCM47XX_BOARD_ASUS_RTN12, "Asus RT-N12"}, "RT-N12"},
+	{{BCM47XX_BOARD_ASUS_RTN12B1, "Asus RT-N12B1"}, "RT-N12B1"},
+	{{BCM47XX_BOARD_ASUS_RTN12C1, "Asus RT-N12C1"}, "RT-N12C1"},
+	{{BCM47XX_BOARD_ASUS_RTN12D1, "Asus RT-N12D1"}, "RT-N12D1"},
+	{{BCM47XX_BOARD_ASUS_RTN12HP, "Asus RT-N12HP"}, "RT-N12HP"},
+	{{BCM47XX_BOARD_ASUS_RTN15U, "Asus RT-N15U"}, "RT-N15U"},
+	{{BCM47XX_BOARD_ASUS_RTN16, "Asus RT-N16"}, "RT-N16"},
+	{{BCM47XX_BOARD_ASUS_RTN53, "Asus RT-N53"}, "RT-N53"},
+	{{BCM47XX_BOARD_ASUS_RTN66U, "Asus RT-N66U"}, "RT-N66U"},
+	{{BCM47XX_BOARD_ASUS_WL300G, "Asus WL300G"}, "WL300g"},
+	{{BCM47XX_BOARD_ASUS_WLHDD, "Asus WLHDD"}, "WLHDD"},
+	{ {0}, 0},
+};
+
+/* ModelId */
+static const struct bcm47xx_board_type_list1 bcm47xx_board_list_ModelId[] = {
+	{{BCM47XX_BOARD_DELL_TM2300, "Dell WX-5565"}, "WX-5565"},
+	{{BCM47XX_BOARD_MOTOROLA_WE800G, "Motorola WE800G"}, "WE800G"},
+	{{BCM47XX_BOARD_MOTOROLA_WR850GP, "Motorola WR850GP"}, "WR850GP"},
+	{{BCM47XX_BOARD_MOTOROLA_WR850GV2V3, "Motorola WR850G"}, "WR850G"},
+	{ {0}, 0},
+};
+
+/* melco_id or buf1falo_id */
+static const struct bcm47xx_board_type_list1 bcm47xx_board_list_melco_id[] = {
+	{{BCM47XX_BOARD_BUFFALO_WBR2_G54, "Buffalo WBR2-G54"}, "29bb0332"},
+	{{BCM47XX_BOARD_BUFFALO_WHR2_A54G54, "Buffalo WHR2-A54G54"}, "290441dd"},
+	{{BCM47XX_BOARD_BUFFALO_WHR_G125, "Buffalo WHR-G125"}, "32093"},
+	{{BCM47XX_BOARD_BUFFALO_WHR_G54S, "Buffalo WHR-G54S"}, "30182"},
+	{{BCM47XX_BOARD_BUFFALO_WHR_HP_G54, "Buffalo WHR-HP-G54"}, "30189"},
+	{{BCM47XX_BOARD_BUFFALO_WLA2_G54L, "Buffalo WLA2-G54L"}, "29129"},
+	{{BCM47XX_BOARD_BUFFALO_WZR_G300N, "Buffalo WZR-G300N"}, "31120"},
+	{{BCM47XX_BOARD_BUFFALO_WZR_RS_G54, "Buffalo WZR-RS-G54"}, "30083"},
+	{{BCM47XX_BOARD_BUFFALO_WZR_RS_G54HP, "Buffalo WZR-RS-G54HP"}, "30103"},
+	{ {0}, 0},
+};
+
+/* boot_hw_model, boot_hw_ver */
+static const struct bcm47xx_board_type_list2 bcm47xx_board_list_boot_hw[] = {
+	/* like WRT160N v3.0 */
+	{{BCM47XX_BOARD_CISCO_M10V1, "Cisco M10"}, "M10", "1.0"},
+	/* like WRT310N v2.0 */
+	{{BCM47XX_BOARD_CISCO_M20V1, "Cisco M20"}, "M20", "1.0"},
+	{{BCM47XX_BOARD_LINKSYS_E900V1, "Linksys E900 V1"}, "E900", "1.0"},
+	/* like WRT160N v3.0 */
+	{{BCM47XX_BOARD_LINKSYS_E1000V1, "Linksys E1000 V1"}, "E100", "1.0"},
+	{{BCM47XX_BOARD_LINKSYS_E1000V2, "Linksys E1000 V2"}, "E1000", "2.0"},
+	{{BCM47XX_BOARD_LINKSYS_E1000V21, "Linksys E1000 V2.1"}, "E1000", "2.1"},
+	{{BCM47XX_BOARD_LINKSYS_E1200V2, "Linksys E1200 V2"}, "E1200", "2.0"},
+	{{BCM47XX_BOARD_LINKSYS_E2000V1, "Linksys E2000 V1"}, "Linksys E2000", "1.0"},
+	/* like WRT610N v2.0 */
+	{{BCM47XX_BOARD_LINKSYS_E3000V1, "Linksys E3000 V1"}, "E300", "1.0"},
+	{{BCM47XX_BOARD_LINKSYS_E3200V1, "Linksys E3200 V1"}, "E3200", "1.0"},
+	{{BCM47XX_BOARD_LINKSYS_E4200V1, "Linksys E4200 V1"}, "E4200", "1.0"},
+	{{BCM47XX_BOARD_LINKSYS_WRT150NV11, "Linksys WRT150N V1.1"}, "WRT150N", "1.1"},
+	{{BCM47XX_BOARD_LINKSYS_WRT150NV1, "Linksys WRT150N V1"}, "WRT150N", "1"},
+	{{BCM47XX_BOARD_LINKSYS_WRT160NV1, "Linksys WRT160N V1"}, "WRT160N", "1.0"},
+	{{BCM47XX_BOARD_LINKSYS_WRT160NV3, "Linksys WRT160N V3"}, "WRT160N", "3.0"},
+	{{BCM47XX_BOARD_LINKSYS_WRT300NV11, "Linksys WRT300N V1.1"}, "WRT300N", "1.1"},
+	{{BCM47XX_BOARD_LINKSYS_WRT310NV1, "Linksys WRT310N V1"}, "WRT310N", "1.0"},
+	{{BCM47XX_BOARD_LINKSYS_WRT310NV2, "Linksys WRT310N V2"}, "WRT310N", "2.0"},
+	{{BCM47XX_BOARD_LINKSYS_WRT54G3GV2, "Linksys WRT54G3GV2-VF"}, "WRT54G3GV2-VF", "1.0"},
+	{{BCM47XX_BOARD_LINKSYS_WRT610NV1, "Linksys WRT610N V1"}, "WRT610N", "1.0"},
+	{{BCM47XX_BOARD_LINKSYS_WRT610NV2, "Linksys WRT610N V2"}, "WRT610N", "2.0"},
+	{ {0}, 0},
+};
+
+/* board_id */
+static const struct bcm47xx_board_type_list1 bcm47xx_board_list_board_id[] = {
+	{{BCM47XX_BOARD_NETGEAR_WGR614V8, "Netgear WGR614 V8"}, "U12H072T00_NETGEAR"},
+	{{BCM47XX_BOARD_NETGEAR_WGR614V9, "Netgear WGR614 V9"}, "U12H094T00_NETGEAR"},
+	{{BCM47XX_BOARD_NETGEAR_WNDR3300, "Netgear WNDR3300"}, "U12H093T00_NETGEAR"},
+	{{BCM47XX_BOARD_NETGEAR_WNDR3400V1, "Netgear WNDR3400 V1"}, "U12H155T00_NETGEAR"},
+	{{BCM47XX_BOARD_NETGEAR_WNDR3400V2, "Netgear WNDR3400 V2"}, "U12H187T00_NETGEAR"},
+	{{BCM47XX_BOARD_NETGEAR_WNDR3400VCNA, "Netgear WNDR3400 Vcna"}, "U12H155T01_NETGEAR"},
+	{{BCM47XX_BOARD_NETGEAR_WNDR3700V3, "Netgear WNDR3700 V3"}, "U12H194T00_NETGEAR"},
+	{{BCM47XX_BOARD_NETGEAR_WNDR4000, "Netgear WNDR4000"}, "U12H181T00_NETGEAR"},
+	{{BCM47XX_BOARD_NETGEAR_WNDR4500V1, "Netgear WNDR4500 V1"}, "U12H189T00_NETGEAR"},
+	{{BCM47XX_BOARD_NETGEAR_WNDR4500V2, "Netgear WNDR4500 V2"}, "U12H224T00_NETGEAR"},
+	{{BCM47XX_BOARD_NETGEAR_WNR2000, "Netgear WNR2000"}, "U12H114T00_NETGEAR"},
+	{{BCM47XX_BOARD_NETGEAR_WNR3500L, "Netgear WNR3500L"}, "U12H136T99_NETGEAR"},
+	{{BCM47XX_BOARD_NETGEAR_WNR3500U, "Netgear WNR3500U"}, "U12H136T00_NETGEAR"},
+	{{BCM47XX_BOARD_NETGEAR_WNR3500V2, "Netgear WNR3500 V2"}, "U12H127T00_NETGEAR"},
+	{{BCM47XX_BOARD_NETGEAR_WNR3500V2VC, "Netgear WNR3500 V2vc"}, "U12H127T70_NETGEAR"},
+	{{BCM47XX_BOARD_NETGEAR_WNR834BV2, "Netgear WNR834B V2"}, "U12H081T00_NETGEAR"},
+	{ {0}, 0},
+};
+
+/* boardtype, boardnum, boardrev */
+static const struct bcm47xx_board_type_list3 bcm47xx_board_list_board[] = {
+	{{BCM47XX_BOARD_HUAWEI_E970, "Huawei E970"}, "0x048e", "0x5347", "0x11"},
+	{{BCM47XX_BOARD_PHICOMM_M1, "Phicomm M1"}, "0x0590", "80", "0x1104"},
+	{{BCM47XX_BOARD_ZTE_H218N, "ZTE H218N"}, "0x053d", "1234", "0x1305"},
+	{ {0}, 0},
+};
+
+static const struct bcm47xx_board_type bcm47xx_board_unknown[] = {
+	{BCM47XX_BOARD_UNKNOWN, "Unknown Board"},
+};
+
+static const struct bcm47xx_board_type bcm47xx_board_no[] = {
+	{BCM47XX_BOARD_NO, "No Board"},
+};
+
+static const struct bcm47xx_board_type *bcm47xx_board = bcm47xx_board_no;
+
+static const struct bcm47xx_board_type *bcm47xx_board_get_nvram(void)
+{
+	char buf1[30];
+	char buf2[30];
+	char buf3[30];
+	const struct bcm47xx_board_type_list1 *e1;
+	const struct bcm47xx_board_type_list2 *e2;
+	const struct bcm47xx_board_type_list3 *e3;
+
+	if (bcm47xx_nvram_getenv("model_name", buf1, sizeof(buf1)) >= 0) {
+		for (e1 = bcm47xx_board_list_model_name; e1->value1; e1++) {
+			if (!strcmp(buf1, e1->value1))
+				return &e1->board;
+		}
+	}
+
+	if (bcm47xx_nvram_getenv("model_no", buf1, sizeof(buf1)) >= 0) {
+		for (e1 = bcm47xx_board_list_model_no; e1->value1; e1++) {
+			if (strstarts(buf1, e1->value1))
+				return &e1->board;
+		}
+	}
+
+	if (bcm47xx_nvram_getenv("machine_name", buf1, sizeof(buf1)) >= 0) {
+		for (e1 = bcm47xx_board_list_machine_name; e1->value1; e1++) {
+			if (strstarts(buf1, e1->value1))
+				return &e1->board;
+		}
+	}
+
+	if (bcm47xx_nvram_getenv("hardware_version", buf1, sizeof(buf1)) >= 0) {
+		for (e1 = bcm47xx_board_list_hardware_version; e1->value1; e1++) {
+			if (strstarts(buf1, e1->value1))
+				return &e1->board;
+		}
+	}
+
+	if (bcm47xx_nvram_getenv("productid", buf1, sizeof(buf1)) >= 0) {
+		for (e1 = bcm47xx_board_list_productid; e1->value1; e1++) {
+			if (!strcmp(buf1, e1->value1))
+				return &e1->board;
+		}
+	}
+
+	if (bcm47xx_nvram_getenv("ModelId", buf1, sizeof(buf1)) >= 0) {
+		for (e1 = bcm47xx_board_list_ModelId; e1->value1; e1++) {
+			if (!strcmp(buf1, e1->value1))
+				return &e1->board;
+		}
+	}
+
+	if (bcm47xx_nvram_getenv("melco_id", buf1, sizeof(buf1)) >= 0 ||
+	    bcm47xx_nvram_getenv("buf1falo_id", buf1, sizeof(buf1)) >= 0) {
+		/* buffalo hardware, check id for specific hardware matches */
+		for (e1 = bcm47xx_board_list_melco_id; e1->value1; e1++) {
+			if (!strcmp(buf1, e1->value1))
+				return &e1->board;
+		}
+	}
+
+	if (bcm47xx_nvram_getenv("boot_hw_model", buf1, sizeof(buf1)) >= 0 &&
+	    bcm47xx_nvram_getenv("boot_hw_ver", buf2, sizeof(buf2)) >= 0) {
+		for (e2 = bcm47xx_board_list_boot_hw; e2->value1; e2++) {
+			if (!strcmp(buf1, e2->value1) &&
+			    !strcmp(buf2, e2->value2))
+				return &e2->board;
+		}
+	}
+
+	if (bcm47xx_nvram_getenv("board_id", buf1, sizeof(buf1)) >= 0) {
+		for (e1 = bcm47xx_board_list_board_id; e1->value1; e1++) {
+			if (!strcmp(buf1, e1->value1))
+				return &e1->board;
+		}
+	}
+
+	if (bcm47xx_nvram_getenv("boardtype", buf1, sizeof(buf1)) >= 0 &&
+	    bcm47xx_nvram_getenv("boardnum", buf2, sizeof(buf2)) >= 0 &&
+	    bcm47xx_nvram_getenv("boardrev", buf3, sizeof(buf3)) >= 0) {
+		for (e3 = bcm47xx_board_list_board; e3->value1; e3++) {
+			if (!strcmp(buf1, e3->value1) &&
+			    !strcmp(buf2, e3->value2) &&
+			    !strcmp(buf3, e3->value3))
+				return &e3->board;
+		}
+	}
+	return bcm47xx_board_unknown;
+}
+
+static void bcm47xx_board_detect(void)
+{
+	int err;
+	char buf[10];
+
+	if (bcm47xx_board != bcm47xx_board_no)
+		return;
+
+	/* check if the nvram is available */
+	err = bcm47xx_nvram_getenv("boardtype", buf, sizeof(buf));
+
+	/* init of nvram failed, probably too early now */
+	if (err == -ENXIO) {
+		return;
+	}
+
+	bcm47xx_board = bcm47xx_board_get_nvram();
+	pr_debug("Found board: \"%s\"\n", bcm47xx_board->name);
+}
+
+enum bcm47xx_board bcm47xx_board_get(void)
+{
+	bcm47xx_board_detect();
+	return bcm47xx_board->board;
+}
+EXPORT_SYMBOL(bcm47xx_board_get);
+
+const char *bcm47xx_board_get_name(void)
+{
+	bcm47xx_board_detect();
+	return bcm47xx_board->name;
+}
+EXPORT_SYMBOL(bcm47xx_board_get_name);
diff --git a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h b/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
new file mode 100644
index 0000000..9183721
--- /dev/null
+++ b/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
@@ -0,0 +1,107 @@
+#ifndef __BCM47XX_BOARD_H
+#define __BCM47XX_BOARD_H
+
+enum bcm47xx_board {
+	BCM47XX_BOARD_ASUS_RTAC66U,
+	BCM47XX_BOARD_ASUS_RTN10,
+	BCM47XX_BOARD_ASUS_RTN10D,
+	BCM47XX_BOARD_ASUS_RTN10U,
+	BCM47XX_BOARD_ASUS_RTN12,
+	BCM47XX_BOARD_ASUS_RTN12B1,
+	BCM47XX_BOARD_ASUS_RTN12C1,
+	BCM47XX_BOARD_ASUS_RTN12D1,
+	BCM47XX_BOARD_ASUS_RTN12HP,
+	BCM47XX_BOARD_ASUS_RTN15U,
+	BCM47XX_BOARD_ASUS_RTN16,
+	BCM47XX_BOARD_ASUS_RTN53,
+	BCM47XX_BOARD_ASUS_RTN66U,
+	BCM47XX_BOARD_ASUS_WL300G,
+	BCM47XX_BOARD_ASUS_WL320GE,
+	BCM47XX_BOARD_ASUS_WL330GE,
+	BCM47XX_BOARD_ASUS_WL500GD,
+	BCM47XX_BOARD_ASUS_WL500GPV1,
+	BCM47XX_BOARD_ASUS_WL500GPV2,
+	BCM47XX_BOARD_ASUS_WL500W,
+	BCM47XX_BOARD_ASUS_WL520GC,
+	BCM47XX_BOARD_ASUS_WL520GU,
+	BCM47XX_BOARD_ASUS_WL700GE,
+	BCM47XX_BOARD_ASUS_WLHDD,
+
+	BCM47XX_BOARD_BELKIN_F7D4301,
+
+	BCM47XX_BOARD_BUFFALO_WBR2_G54,
+	BCM47XX_BOARD_BUFFALO_WHR2_A54G54,
+	BCM47XX_BOARD_BUFFALO_WHR_G125,
+	BCM47XX_BOARD_BUFFALO_WHR_G54S,
+	BCM47XX_BOARD_BUFFALO_WHR_HP_G54,
+	BCM47XX_BOARD_BUFFALO_WLA2_G54L,
+	BCM47XX_BOARD_BUFFALO_WZR_G300N,
+	BCM47XX_BOARD_BUFFALO_WZR_RS_G54,
+	BCM47XX_BOARD_BUFFALO_WZR_RS_G54HP,
+
+	BCM47XX_BOARD_CISCO_M10V1,
+	BCM47XX_BOARD_CISCO_M20V1,
+
+	BCM47XX_BOARD_DELL_TM2300,
+
+	BCM47XX_BOARD_DLINK_DIR130,
+	BCM47XX_BOARD_DLINK_DIR330,
+
+	BCM47XX_BOARD_HUAWEI_E970,
+
+	BCM47XX_BOARD_LINKSYS_E900V1,
+	BCM47XX_BOARD_LINKSYS_E1000V1,
+	BCM47XX_BOARD_LINKSYS_E1000V2,
+	BCM47XX_BOARD_LINKSYS_E1000V21,
+	BCM47XX_BOARD_LINKSYS_E1200V2,
+	BCM47XX_BOARD_LINKSYS_E2000V1,
+	BCM47XX_BOARD_LINKSYS_E3000V1,
+	BCM47XX_BOARD_LINKSYS_E3200V1,
+	BCM47XX_BOARD_LINKSYS_E4200V1,
+	BCM47XX_BOARD_LINKSYS_WRT150NV1,
+	BCM47XX_BOARD_LINKSYS_WRT150NV11,
+	BCM47XX_BOARD_LINKSYS_WRT160NV1,
+	BCM47XX_BOARD_LINKSYS_WRT160NV3,
+	BCM47XX_BOARD_LINKSYS_WRT300NV11,
+	BCM47XX_BOARD_LINKSYS_WRT310NV1,
+	BCM47XX_BOARD_LINKSYS_WRT310NV2,
+	BCM47XX_BOARD_LINKSYS_WRT54G3GV2,
+	BCM47XX_BOARD_LINKSYS_WRT610NV1,
+	BCM47XX_BOARD_LINKSYS_WRT610NV2,
+	BCM47XX_BOARD_LINKSYS_WRTSL54GS,
+
+	BCM47XX_BOARD_MOTOROLA_WE800G,
+	BCM47XX_BOARD_MOTOROLA_WR850GP,
+	BCM47XX_BOARD_MOTOROLA_WR850GV2V3,
+
+	BCM47XX_BOARD_NETGEAR_WGR614V8,
+	BCM47XX_BOARD_NETGEAR_WGR614V9,
+	BCM47XX_BOARD_NETGEAR_WNDR3300,
+	BCM47XX_BOARD_NETGEAR_WNDR3400V1,
+	BCM47XX_BOARD_NETGEAR_WNDR3400V2,
+	BCM47XX_BOARD_NETGEAR_WNDR3400VCNA,
+	BCM47XX_BOARD_NETGEAR_WNDR3700V3,
+	BCM47XX_BOARD_NETGEAR_WNDR4000,
+	BCM47XX_BOARD_NETGEAR_WNDR4500V1,
+	BCM47XX_BOARD_NETGEAR_WNDR4500V2,
+	BCM47XX_BOARD_NETGEAR_WNR2000,
+	BCM47XX_BOARD_NETGEAR_WNR3500L,
+	BCM47XX_BOARD_NETGEAR_WNR3500U,
+	BCM47XX_BOARD_NETGEAR_WNR3500V2,
+	BCM47XX_BOARD_NETGEAR_WNR3500V2VC,
+	BCM47XX_BOARD_NETGEAR_WNR834BV2,
+
+	BCM47XX_BOARD_PHICOMM_M1,
+
+	BCM47XX_BOARD_SIMPLETECH_SIMPLESHARE,
+
+	BCM47XX_BOARD_ZTE_H218N,
+
+	BCM47XX_BOARD_UNKNOWN,
+	BCM47XX_BOARD_NO,
+};
+
+enum bcm47xx_board bcm47xx_board_get(void);
+const char *bcm47xx_board_get_name(void);
+
+#endif /* __BCM47XX_BOARD_H */
-- 
1.7.10.4
