Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Feb 2016 02:12:17 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:38364 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27014948AbcBZBKUke14b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Feb 2016 02:10:20 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id BC9704CC7; Fri, 26 Feb 2016 02:10:14 +0100 (CET)
Received: from localhost.localdomain (unknown [208.66.31.210])
        by mail.free-electrons.com (Postfix) with ESMTPSA id B93B24C73;
        Fri, 26 Feb 2016 02:03:38 +0100 (CET)
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
        Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v3 49/52] mtd: onenand: switch to mtd_ooblayout_ops
Date:   Fri, 26 Feb 2016 01:57:57 +0100
Message-Id: <1456448280-27788-50-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1456448280-27788-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1456448280-27788-1-git-send-email-boris.brezillon@free-electrons.com>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52323
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
ECC/OOB layout to MTD users. Modify the onenand drivers to switch to this
approach.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/onenand/onenand_base.c | 162 ++++++++++++++++++++++---------------
 include/linux/mtd/onenand.h        |   2 -
 2 files changed, 97 insertions(+), 67 deletions(-)

diff --git a/drivers/mtd/onenand/onenand_base.c b/drivers/mtd/onenand/onenand_base.c
index d0fa505..a4b029a 100644
--- a/drivers/mtd/onenand/onenand_base.c
+++ b/drivers/mtd/onenand/onenand_base.c
@@ -68,21 +68,33 @@ MODULE_PARM_DESC(otp,	"Corresponding behaviour of OneNAND in OTP"
  * flexonenand_oob_128 - oob info for Flex-Onenand with 4KB page
  * For now, we expose only 64 out of 80 ecc bytes
  */
-static struct nand_ecclayout flexonenand_oob_128 = {
-	.eccbytes	= 64,
-	.eccpos		= {
-		6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
-		22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
-		38, 39, 40, 41, 42, 43, 44, 45, 46, 47,
-		54, 55, 56, 57, 58, 59, 60, 61, 62, 63,
-		70, 71, 72, 73, 74, 75, 76, 77, 78, 79,
-		86, 87, 88, 89, 90, 91, 92, 93, 94, 95,
-		102, 103, 104, 105
-		},
-	.oobfree	= {
-		{2, 4}, {18, 4}, {34, 4}, {50, 4},
-		{66, 4}, {82, 4}, {98, 4}, {114, 4}
-	}
+static int flexonenand_ooblayout_ecc(struct mtd_info *mtd, int section,
+				     struct mtd_oob_region *oobregion)
+{
+	if (section > 7)
+		return -ERANGE;
+
+	oobregion->offset = (section * 16) + 6;
+	oobregion->length = 10;
+
+	return 0;
+}
+
+static int flexonenand_ooblayout_free(struct mtd_info *mtd, int section,
+				      struct mtd_oob_region *oobregion)
+{
+	if (section > 7)
+		return -ERANGE;
+
+	oobregion->offset = (section * 16) + 2;
+	oobregion->length = 4;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops flexonenand_ooblayout_ops = {
+	.ecc = flexonenand_ooblayout_ecc,
+	.free = flexonenand_ooblayout_free,
 };
 
 /*
@@ -91,56 +103,77 @@ static struct nand_ecclayout flexonenand_oob_128 = {
  * Based on specification:
  * 4Gb M-die OneNAND Flash (KFM4G16Q4M, KFN8G16Q4M). Rev. 1.3, Apr. 2010
  *
- * For eccpos we expose only 64 bytes out of 72 (see struct nand_ecclayout)
- *
- * oobfree uses the spare area fields marked as
- * "Managed by internal ECC logic for Logical Sector Number area"
- */
-static struct nand_ecclayout onenand_oob_128 = {
-	.eccbytes	= 64,
-	.eccpos		= {
-		7, 8, 9, 10, 11, 12, 13, 14, 15,
-		23, 24, 25, 26, 27, 28, 29, 30, 31,
-		39, 40, 41, 42, 43, 44, 45, 46, 47,
-		55, 56, 57, 58, 59, 60, 61, 62, 63,
-		71, 72, 73, 74, 75, 76, 77, 78, 79,
-		87, 88, 89, 90, 91, 92, 93, 94, 95,
-		103, 104, 105, 106, 107, 108, 109, 110, 111,
-		119
-	},
-	.oobfree	= {
-		{2, 3}, {18, 3}, {34, 3}, {50, 3},
-		{66, 3}, {82, 3}, {98, 3}, {114, 3}
-	}
+ */
+static int onenand_ooblayout_128_ecc(struct mtd_info *mtd, int section,
+				     struct mtd_oob_region *oobregion)
+{
+	if (section > 7)
+		return -ERANGE;
+
+	oobregion->offset = (section * 16) + 7;
+	oobregion->length = 9;
+
+	return 0;
+}
+
+static int onenand_ooblayout_128_free(struct mtd_info *mtd, int section,
+				      struct mtd_oob_region *oobregion)
+{
+	if (section >= 8)
+		return -ERANGE;
+
+	/*
+	 * free bytes are using the spare area fields marked as
+	 * "Managed by internal ECC logic for Logical Sector Number area"
+	 */
+	oobregion->offset = (section * 16) + 2;
+	oobregion->length = 3;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops onenand_oob_128_ooblayout_ops = {
+	.ecc = onenand_ooblayout_128_ecc,
+	.free = onenand_ooblayout_128_free,
 };
 
 /**
- * onenand_oob_64 - oob info for large (2KB) page
+ * onenand_oob_32_64 - oob info for large (2KB) page
  */
-static struct nand_ecclayout onenand_oob_64 = {
-	.eccbytes	= 20,
-	.eccpos		= {
-		8, 9, 10, 11, 12,
-		24, 25, 26, 27, 28,
-		40, 41, 42, 43, 44,
-		56, 57, 58, 59, 60,
-		},
-	.oobfree	= {
-		{2, 3}, {14, 2}, {18, 3}, {30, 2},
-		{34, 3}, {46, 2}, {50, 3}, {62, 2}
+static int onenand_ooblayout_32_64_ecc(struct mtd_info *mtd, int section,
+				       struct mtd_oob_region *oobregion)
+{
+	if (section > 3)
+		return -ERANGE;
+
+	oobregion->offset = (section * 16) + 8;
+	oobregion->length = 5;
+
+	return 0;
+}
+
+static int onenand_ooblayout_32_64_free(struct mtd_info *mtd, int section,
+					struct mtd_oob_region *oobregion)
+{
+	int sections = (mtd->oobsize / 32) * 2;
+
+	if (section >= sections)
+		return -ERANGE;
+
+	if (section & 1) {
+		oobregion->offset = ((section - 1) * 16) + 14;
+		oobregion->length = 2;
+	} else  {
+		oobregion->offset = (section * 16) + 2;
+		oobregion->length = 3;
 	}
-};
 
-/**
- * onenand_oob_32 - oob info for middle (1KB) page
- */
-static struct nand_ecclayout onenand_oob_32 = {
-	.eccbytes	= 10,
-	.eccpos		= {
-		8, 9, 10, 11, 12,
-		24, 25, 26, 27, 28,
-		},
-	.oobfree	= { {2, 3}, {14, 2}, {18, 3}, {30, 2} }
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops onenand_oob_32_64_ooblayout_ops = {
+	.ecc = onenand_ooblayout_32_64_ecc,
+	.free = onenand_ooblayout_32_64_free,
 };
 
 static const unsigned char ffchars[] = {
@@ -3957,22 +3990,22 @@ int onenand_scan(struct mtd_info *mtd, int maxchips)
 	switch (mtd->oobsize) {
 	case 128:
 		if (FLEXONENAND(this)) {
-			this->ecclayout = &flexonenand_oob_128;
+			mtd_set_ooblayout(mtd, &flexonenand_ooblayout_ops);
 			mtd->subpage_sft = 0;
 		} else {
-			this->ecclayout = &onenand_oob_128;
+			mtd_set_ooblayout(mtd, &onenand_oob_128_ooblayout_ops);
 			mtd->subpage_sft = 2;
 		}
 		if (ONENAND_IS_NOP_1(this))
 			mtd->subpage_sft = 0;
 		break;
 	case 64:
-		this->ecclayout = &onenand_oob_64;
+		mtd_set_ooblayout(mtd, &onenand_oob_32_64_ooblayout_ops);
 		mtd->subpage_sft = 2;
 		break;
 
 	case 32:
-		this->ecclayout = &onenand_oob_32;
+		mtd_set_ooblayout(mtd, &onenand_oob_32_64_ooblayout_ops);
 		mtd->subpage_sft = 1;
 		break;
 
@@ -3981,7 +4014,7 @@ int onenand_scan(struct mtd_info *mtd, int maxchips)
 			__func__, mtd->oobsize);
 		mtd->subpage_sft = 0;
 		/* To prevent kernel oops */
-		this->ecclayout = &onenand_oob_32;
+		mtd_set_ooblayout(mtd, &onenand_oob_32_64_ooblayout_ops);
 		break;
 	}
 
@@ -3997,7 +4030,6 @@ int onenand_scan(struct mtd_info *mtd, int maxchips)
 
 	mtd->oobavail = ret;
 
-	mtd_set_ecclayout(mtd, this->ecclayout);
 	mtd->ecc_strength = 1;
 
 	/* Fill in remaining MTD driver data */
diff --git a/include/linux/mtd/onenand.h b/include/linux/mtd/onenand.h
index 4596503..0aaa98b 100644
--- a/include/linux/mtd/onenand.h
+++ b/include/linux/mtd/onenand.h
@@ -80,7 +80,6 @@ struct onenand_bufferram {
  * @page_buf:		[INTERN] page main data buffer
  * @oob_buf:		[INTERN] page oob data buffer
  * @subpagesize:	[INTERN] holds the subpagesize
- * @ecclayout:		[REPLACEABLE] the default ecc placement scheme
  * @bbm:		[REPLACEABLE] pointer to Bad Block Management
  * @priv:		[OPTIONAL] pointer to private chip date
  */
@@ -134,7 +133,6 @@ struct onenand_chip {
 #endif
 
 	int			subpagesize;
-	struct nand_ecclayout	*ecclayout;
 
 	void			*bbm;
 
-- 
2.1.4
