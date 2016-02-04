Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Feb 2016 11:17:57 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:38006 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27012507AbcBDKIJX2AKO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Feb 2016 11:08:09 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 575E8439C; Thu,  4 Feb 2016 11:08:04 +0100 (CET)
Received: from localhost.localdomain (AToulouse-657-1-20-139.w83-193.abo.wanadoo.fr [83.193.84.139])
        by mail.free-electrons.com (Postfix) with ESMTPSA id EB8B7475;
        Thu,  4 Feb 2016 11:07:41 +0100 (CET)
From:   Boris Brezillon <boris.brezillon@free-electrons.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-mtd@lists.infradead.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Josh Wu <josh.wu@atmel.com>,
        Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com,
        Stefan Agner <stefan@agner.ch>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        punnaiah choudary kalluri <punnaia@xilinx.com>,
        Priit Laes <plaes@plaes.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v2 35/51] mtd: nand: fsmc: switch to mtd_ooblayout_ops
Date:   Thu,  4 Feb 2016 11:06:58 +0100
Message-Id: <1454580434-32078-36-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1454580434-32078-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1454580434-32078-1-git-send-email-boris.brezillon@free-electrons.com>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51753
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: boris.brezillon@free-electrons.com
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

Implementing the mtd_ooblayout_ops interface is the new way of exposing
ECC/OOB layout to MTD users.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/fsmc_nand.c | 300 ++++++++++++-------------------------------
 1 file changed, 84 insertions(+), 216 deletions(-)

diff --git a/drivers/mtd/nand/fsmc_nand.c b/drivers/mtd/nand/fsmc_nand.c
index 1bdcd4f..d989acf 100644
--- a/drivers/mtd/nand/fsmc_nand.c
+++ b/drivers/mtd/nand/fsmc_nand.c
@@ -39,212 +39,6 @@
 #include <linux/amba/bus.h>
 #include <mtd/mtd-abi.h>
 
-static struct nand_ecclayout fsmc_ecc1_128_layout = {
-	.eccbytes = 24,
-	.eccpos = {2, 3, 4, 18, 19, 20, 34, 35, 36, 50, 51, 52,
-		66, 67, 68, 82, 83, 84, 98, 99, 100, 114, 115, 116},
-	.oobfree = {
-		{.offset = 8, .length = 8},
-		{.offset = 24, .length = 8},
-		{.offset = 40, .length = 8},
-		{.offset = 56, .length = 8},
-		{.offset = 72, .length = 8},
-		{.offset = 88, .length = 8},
-		{.offset = 104, .length = 8},
-		{.offset = 120, .length = 8}
-	}
-};
-
-static struct nand_ecclayout fsmc_ecc1_64_layout = {
-	.eccbytes = 12,
-	.eccpos = {2, 3, 4, 18, 19, 20, 34, 35, 36, 50, 51, 52},
-	.oobfree = {
-		{.offset = 8, .length = 8},
-		{.offset = 24, .length = 8},
-		{.offset = 40, .length = 8},
-		{.offset = 56, .length = 8},
-	}
-};
-
-static struct nand_ecclayout fsmc_ecc1_16_layout = {
-	.eccbytes = 3,
-	.eccpos = {2, 3, 4},
-	.oobfree = {
-		{.offset = 8, .length = 8},
-	}
-};
-
-/*
- * ECC4 layout for NAND of pagesize 8192 bytes & OOBsize 256 bytes. 13*16 bytes
- * of OB size is reserved for ECC, Byte no. 0 & 1 reserved for bad block and 46
- * bytes are free for use.
- */
-static struct nand_ecclayout fsmc_ecc4_256_layout = {
-	.eccbytes = 208,
-	.eccpos = {  2,   3,   4,   5,   6,   7,   8,
-		9,  10,  11,  12,  13,  14,
-		18,  19,  20,  21,  22,  23,  24,
-		25,  26,  27,  28,  29,  30,
-		34,  35,  36,  37,  38,  39,  40,
-		41,  42,  43,  44,  45,  46,
-		50,  51,  52,  53,  54,  55,  56,
-		57,  58,  59,  60,  61,  62,
-		66,  67,  68,  69,  70,  71,  72,
-		73,  74,  75,  76,  77,  78,
-		82,  83,  84,  85,  86,  87,  88,
-		89,  90,  91,  92,  93,  94,
-		98,  99, 100, 101, 102, 103, 104,
-		105, 106, 107, 108, 109, 110,
-		114, 115, 116, 117, 118, 119, 120,
-		121, 122, 123, 124, 125, 126,
-		130, 131, 132, 133, 134, 135, 136,
-		137, 138, 139, 140, 141, 142,
-		146, 147, 148, 149, 150, 151, 152,
-		153, 154, 155, 156, 157, 158,
-		162, 163, 164, 165, 166, 167, 168,
-		169, 170, 171, 172, 173, 174,
-		178, 179, 180, 181, 182, 183, 184,
-		185, 186, 187, 188, 189, 190,
-		194, 195, 196, 197, 198, 199, 200,
-		201, 202, 203, 204, 205, 206,
-		210, 211, 212, 213, 214, 215, 216,
-		217, 218, 219, 220, 221, 222,
-		226, 227, 228, 229, 230, 231, 232,
-		233, 234, 235, 236, 237, 238,
-		242, 243, 244, 245, 246, 247, 248,
-		249, 250, 251, 252, 253, 254
-	},
-	.oobfree = {
-		{.offset = 15, .length = 3},
-		{.offset = 31, .length = 3},
-		{.offset = 47, .length = 3},
-		{.offset = 63, .length = 3},
-		{.offset = 79, .length = 3},
-		{.offset = 95, .length = 3},
-		{.offset = 111, .length = 3},
-		{.offset = 127, .length = 3},
-		{.offset = 143, .length = 3},
-		{.offset = 159, .length = 3},
-		{.offset = 175, .length = 3},
-		{.offset = 191, .length = 3},
-		{.offset = 207, .length = 3},
-		{.offset = 223, .length = 3},
-		{.offset = 239, .length = 3},
-		{.offset = 255, .length = 1}
-	}
-};
-
-/*
- * ECC4 layout for NAND of pagesize 4096 bytes & OOBsize 224 bytes. 13*8 bytes
- * of OOB size is reserved for ECC, Byte no. 0 & 1 reserved for bad block & 118
- * bytes are free for use.
- */
-static struct nand_ecclayout fsmc_ecc4_224_layout = {
-	.eccbytes = 104,
-	.eccpos = {  2,   3,   4,   5,   6,   7,   8,
-		9,  10,  11,  12,  13,  14,
-		18,  19,  20,  21,  22,  23,  24,
-		25,  26,  27,  28,  29,  30,
-		34,  35,  36,  37,  38,  39,  40,
-		41,  42,  43,  44,  45,  46,
-		50,  51,  52,  53,  54,  55,  56,
-		57,  58,  59,  60,  61,  62,
-		66,  67,  68,  69,  70,  71,  72,
-		73,  74,  75,  76,  77,  78,
-		82,  83,  84,  85,  86,  87,  88,
-		89,  90,  91,  92,  93,  94,
-		98,  99, 100, 101, 102, 103, 104,
-		105, 106, 107, 108, 109, 110,
-		114, 115, 116, 117, 118, 119, 120,
-		121, 122, 123, 124, 125, 126
-	},
-	.oobfree = {
-		{.offset = 15, .length = 3},
-		{.offset = 31, .length = 3},
-		{.offset = 47, .length = 3},
-		{.offset = 63, .length = 3},
-		{.offset = 79, .length = 3},
-		{.offset = 95, .length = 3},
-		{.offset = 111, .length = 3},
-		{.offset = 127, .length = 97}
-	}
-};
-
-/*
- * ECC4 layout for NAND of pagesize 4096 bytes & OOBsize 128 bytes. 13*8 bytes
- * of OOB size is reserved for ECC, Byte no. 0 & 1 reserved for bad block & 22
- * bytes are free for use.
- */
-static struct nand_ecclayout fsmc_ecc4_128_layout = {
-	.eccbytes = 104,
-	.eccpos = {  2,   3,   4,   5,   6,   7,   8,
-		9,  10,  11,  12,  13,  14,
-		18,  19,  20,  21,  22,  23,  24,
-		25,  26,  27,  28,  29,  30,
-		34,  35,  36,  37,  38,  39,  40,
-		41,  42,  43,  44,  45,  46,
-		50,  51,  52,  53,  54,  55,  56,
-		57,  58,  59,  60,  61,  62,
-		66,  67,  68,  69,  70,  71,  72,
-		73,  74,  75,  76,  77,  78,
-		82,  83,  84,  85,  86,  87,  88,
-		89,  90,  91,  92,  93,  94,
-		98,  99, 100, 101, 102, 103, 104,
-		105, 106, 107, 108, 109, 110,
-		114, 115, 116, 117, 118, 119, 120,
-		121, 122, 123, 124, 125, 126
-	},
-	.oobfree = {
-		{.offset = 15, .length = 3},
-		{.offset = 31, .length = 3},
-		{.offset = 47, .length = 3},
-		{.offset = 63, .length = 3},
-		{.offset = 79, .length = 3},
-		{.offset = 95, .length = 3},
-		{.offset = 111, .length = 3},
-		{.offset = 127, .length = 1}
-	}
-};
-
-/*
- * ECC4 layout for NAND of pagesize 2048 bytes & OOBsize 64 bytes. 13*4 bytes of
- * OOB size is reserved for ECC, Byte no. 0 & 1 reserved for bad block and 10
- * bytes are free for use.
- */
-static struct nand_ecclayout fsmc_ecc4_64_layout = {
-	.eccbytes = 52,
-	.eccpos = {  2,   3,   4,   5,   6,   7,   8,
-		9,  10,  11,  12,  13,  14,
-		18,  19,  20,  21,  22,  23,  24,
-		25,  26,  27,  28,  29,  30,
-		34,  35,  36,  37,  38,  39,  40,
-		41,  42,  43,  44,  45,  46,
-		50,  51,  52,  53,  54,  55,  56,
-		57,  58,  59,  60,  61,  62,
-	},
-	.oobfree = {
-		{.offset = 15, .length = 3},
-		{.offset = 31, .length = 3},
-		{.offset = 47, .length = 3},
-		{.offset = 63, .length = 1},
-	}
-};
-
-/*
- * ECC4 layout for NAND of pagesize 512 bytes & OOBsize 16 bytes. 13 bytes of
- * OOB size is reserved for ECC, Byte no. 4 & 5 reserved for bad block and One
- * byte is free for use.
- */
-static struct nand_ecclayout fsmc_ecc4_16_layout = {
-	.eccbytes = 13,
-	.eccpos = { 0,  1,  2,  3,  6,  7, 8,
-		9, 10, 11, 12, 13, 14
-	},
-	.oobfree = {
-		{.offset = 15, .length = 1},
-	}
-};
-
 /*
  * ECC placement definitions in oobfree type format.
  * There are 13 bytes of ecc for every 512 byte block and it has to be read
@@ -274,6 +68,86 @@ static struct fsmc_eccplace fsmc_ecc4_sp_place = {
 	}
 };
 
+static int fsmc_ecc1_ooblayout_ecc(struct mtd_info *mtd, int section,
+				   struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	int eccbytes = chip->ecc.bytes * chip->ecc.steps;
+
+	if (section >= chip->ecc.steps)
+		return -ERANGE;
+
+	oobregion->offset = (section * 16) + 2;
+	oobregion->length = 3;
+
+	return 0;
+}
+
+static int fsmc_ecc1_ooblayout_free(struct mtd_info *mtd, int section,
+				    struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	if (section >= chip->ecc.steps)
+		return -ERANGE;
+
+	oobfree->offset = (section * 16) + 8;
+
+	if (section < chip->ecc.steps - 1)
+		oobfree->length = 8;
+	else
+		oobfree->length = mtd->oobsize - oobfree->offset;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops fsmc_ecc1_ooblayout_ops = {
+	.ecc = fsmc_ecc1_ooblayout_ecc,
+	.free = fsmc_ecc1_ooblayout_free,
+};
+
+static int fsmc_ecc4_ooblayout_ecc(struct mtd_info *mtd, int section,
+				   struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	int eccbytes = chip->ecc.bytes * chip->ecc.steps;
+
+	if (section >= chip->ecc.steps)
+		return -ERANGE;
+
+	oobfree->length = chip->ecc.bytes;
+
+	if (!section && mtd->writesize <= 512)
+		oobfree->offset = 0;
+	else
+		oobfree->offset = (section * 16) + 2;
+
+	return 0;
+}
+
+static int fsmc_ecc4_ooblayout_free(struct mtd_info *mtd, int section,
+				    struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	if (section >= chip->ecc.steps)
+		return -ERANGE;
+
+	oobfree->offset = (section * 16) + 15;
+
+	if (section < chip->ecc.steps - 1)
+		oobfree->length = 3;
+	else
+		oobfree->length = mtd->oobsize - oobfree->offset;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops fsmc_ecc4_ooblayout_ops = {
+	.ecc = fsmc_ecc4_ooblayout_ecc,
+	.free = fsmc_ecc4_ooblayout_free,
+};
+
 /**
  * struct fsmc_nand_data - structure for FSMC NAND device state
  *
@@ -1084,23 +958,18 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 	if (AMBA_REV_BITS(host->pid) >= 8) {
 		switch (mtd->oobsize) {
 		case 16:
-			nand->ecc.layout = &fsmc_ecc4_16_layout;
 			host->ecc_place = &fsmc_ecc4_sp_place;
 			break;
 		case 64:
-			nand->ecc.layout = &fsmc_ecc4_64_layout;
 			host->ecc_place = &fsmc_ecc4_lp_place;
 			break;
 		case 128:
-			nand->ecc.layout = &fsmc_ecc4_128_layout;
 			host->ecc_place = &fsmc_ecc4_lp_place;
 			break;
 		case 224:
-			nand->ecc.layout = &fsmc_ecc4_224_layout;
 			host->ecc_place = &fsmc_ecc4_lp_place;
 			break;
 		case 256:
-			nand->ecc.layout = &fsmc_ecc4_256_layout;
 			host->ecc_place = &fsmc_ecc4_lp_place;
 			break;
 		default:
@@ -1109,6 +978,8 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 			ret = -EINVAL;
 			goto err_probe;
 		}
+
+		mtd_set_ooblayout(mtd, &fsmc_ecc4_ooblayout_ops);
 	} else {
 		switch (nand->ecc.mode) {
 		case NAND_ECC_HW:
@@ -1135,13 +1006,10 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 		if (nand->ecc.mode != NAND_ECC_SOFT_BCH) {
 			switch (mtd->oobsize) {
 			case 16:
-				nand->ecc.layout = &fsmc_ecc1_16_layout;
-				break;
 			case 64:
-				nand->ecc.layout = &fsmc_ecc1_64_layout;
-				break;
 			case 128:
-				nand->ecc.layout = &fsmc_ecc1_128_layout;
+				mtd_set_ooblayout(mtd,
+						  &fsmc_ecc1_ooblayout_ops);
 				break;
 			default:
 				dev_warn(&pdev->dev,
-- 
2.1.4
