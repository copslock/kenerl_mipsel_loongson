Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Mar 2016 10:56:14 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:38527 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27006929AbcCGJstTr56S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Mar 2016 10:48:49 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 7B20B42; Mon,  7 Mar 2016 10:48:43 +0100 (CET)
Received: from localhost.localdomain (AToulouse-657-1-1129-172.w92-156.abo.wanadoo.fr [92.156.51.172])
        by mail.free-electrons.com (Postfix) with ESMTPSA id F0C101BD;
        Mon,  7 Mar 2016 10:48:13 +0100 (CET)
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
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Wenyou Yang <wenyou.yang@atmel.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com,
        Stefan Agner <stefan@agner.ch>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        punnaiah choudary kalluri <punnaia@xilinx.com>,
        Priit Laes <plaes@plaes.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-api@vger.kernel.org,
        Harvey Hunt <harvey.hunt@imgtec.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v4 29/52] mtd: nand: davinci: switch to mtd_ooblayout_ops
Date:   Mon,  7 Mar 2016 10:47:19 +0100
Message-Id: <1457344062-11633-30-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1457344062-11633-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1457344062-11633-1-git-send-email-boris.brezillon@free-electrons.com>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52516
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
 drivers/mtd/nand/davinci_nand.c | 118 +++++++++++++++-------------------------
 1 file changed, 44 insertions(+), 74 deletions(-)

diff --git a/drivers/mtd/nand/davinci_nand.c b/drivers/mtd/nand/davinci_nand.c
index 8cb821b..fe3fd29 100644
--- a/drivers/mtd/nand/davinci_nand.c
+++ b/drivers/mtd/nand/davinci_nand.c
@@ -54,7 +54,6 @@
  */
 struct davinci_nand_info {
 	struct nand_chip	chip;
-	struct nand_ecclayout	ecclayout;
 
 	struct device		*dev;
 	struct clk		*clk;
@@ -480,63 +479,46 @@ static int nand_davinci_dev_ready(struct mtd_info *mtd)
  * ten ECC bytes plus the manufacturer's bad block marker byte, and
  * and not overlapping the default BBT markers.
  */
-static struct nand_ecclayout hwecc4_small = {
-	.eccbytes = 10,
-	.eccpos = { 0, 1, 2, 3, 4,
-		/* offset 5 holds the badblock marker */
-		6, 7,
-		13, 14, 15, },
-	.oobfree = {
-		{.offset = 8, .length = 5, },
-		{.offset = 16, },
-	},
-};
+static int hwecc4_ooblayout_small_ecc(struct mtd_info *mtd, int section,
+				      struct mtd_oob_region *oobregion)
+{
+	if (section > 2)
+		return -ERANGE;
+
+	if (!section) {
+		oobregion->offset = 0;
+		oobregion->length = 5;
+	} else if (section == 1) {
+		oobregion->offset = 6;
+		oobregion->length = 2;
+	} else {
+		oobregion->offset = 13;
+		oobregion->length = 3;
+	}
 
-/* An ECC layout for using 4-bit ECC with large-page (2048bytes) flash,
- * storing ten ECC bytes plus the manufacturer's bad block marker byte,
- * and not overlapping the default BBT markers.
- */
-static struct nand_ecclayout hwecc4_2048 = {
-	.eccbytes = 40,
-	.eccpos = {
-		/* at the end of spare sector */
-		24, 25, 26, 27, 28, 29,	30, 31, 32, 33,
-		34, 35, 36, 37, 38, 39,	40, 41, 42, 43,
-		44, 45, 46, 47, 48, 49, 50, 51, 52, 53,
-		54, 55, 56, 57, 58, 59, 60, 61, 62, 63,
-		},
-	.oobfree = {
-		/* 2 bytes at offset 0 hold manufacturer badblock markers */
-		{.offset = 2, .length = 22, },
-		/* 5 bytes at offset 8 hold BBT markers */
-		/* 8 bytes at offset 16 hold JFFS2 clean markers */
-	},
-};
+	return 0;
+}
 
-/*
- * An ECC layout for using 4-bit ECC with large-page (4096bytes) flash,
- * storing ten ECC bytes plus the manufacturer's bad block marker byte,
- * and not overlapping the default BBT markers.
- */
-static struct nand_ecclayout hwecc4_4096 = {
-	.eccbytes = 80,
-	.eccpos = {
-		/* at the end of spare sector */
-		48, 49, 50, 51, 52, 53, 54, 55, 56, 57,
-		58, 59, 60, 61, 62, 63, 64, 65, 66, 67,
-		68, 69, 70, 71, 72, 73, 74, 75, 76, 77,
-		78, 79, 80, 81, 82, 83, 84, 85, 86, 87,
-		88, 89, 90, 91, 92, 93, 94, 95, 96, 97,
-		98, 99, 100, 101, 102, 103, 104, 105, 106, 107,
-		108, 109, 110, 111, 112, 113, 114, 115, 116, 117,
-		118, 119, 120, 121, 122, 123, 124, 125, 126, 127,
-	},
-	.oobfree = {
-		/* 2 bytes at offset 0 hold manufacturer badblock markers */
-		{.offset = 2, .length = 46, },
-		/* 5 bytes at offset 8 hold BBT markers */
-		/* 8 bytes at offset 16 hold JFFS2 clean markers */
-	},
+static int hwecc4_ooblayout_small_free(struct mtd_info *mtd, int section,
+				       struct mtd_oob_region *oobregion)
+{
+	if (section > 1)
+		return -ERANGE;
+
+	if (!section) {
+		oobregion->offset = 8;
+		oobregion->length = 5;
+	} else {
+		oobregion->offset = 16;
+		oobregion->length = mtd->oobsize - 16;
+	}
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops hwecc4_small_ooblayout_ops = {
+	.ecc = hwecc4_ooblayout_small_ecc,
+	.free = hwecc4_ooblayout_small_free,
 };
 
 #if defined(CONFIG_OF)
@@ -805,26 +787,14 @@ static int nand_davinci_probe(struct platform_device *pdev)
 		 * table marker fits in the free bytes.
 		 */
 		if (chunks == 1) {
-			info->ecclayout = hwecc4_small;
-			info->ecclayout.oobfree[1].length = mtd->oobsize - 16;
-			goto syndrome_done;
-		}
-		if (chunks == 4) {
-			info->ecclayout = hwecc4_2048;
+			mtd_set_ooblayout(mtd, &hwecc4_small_ooblayout_ops);
+		} else if (chunks == 4 || chunks == 8) {
+			mtd_set_ooblayout(mtd, &nand_ooblayout_lp_ops);
 			info->chip.ecc.mode = NAND_ECC_HW_OOB_FIRST;
-			goto syndrome_done;
-		}
-		if (chunks == 8) {
-			info->ecclayout = hwecc4_4096;
-			info->chip.ecc.mode = NAND_ECC_HW_OOB_FIRST;
-			goto syndrome_done;
+		} else {
+			ret = -EIO;
+			goto err;
 		}
-
-		ret = -EIO;
-		goto err;
-
-syndrome_done:
-		info->chip.ecc.layout = &info->ecclayout;
 	}
 
 	ret = nand_scan_tail(mtd);
-- 
2.1.4
