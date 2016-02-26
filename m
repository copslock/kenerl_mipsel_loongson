Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Feb 2016 02:08:29 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:37938 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27014935AbcBZBGxGUvKb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Feb 2016 02:06:53 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 5FD29222B; Fri, 26 Feb 2016 02:06:47 +0100 (CET)
Received: from localhost.localdomain (unknown [208.66.31.210])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 633C32252;
        Fri, 26 Feb 2016 02:01:58 +0100 (CET)
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
Subject: [PATCH v3 34/52] mtd: nand: fsl_ifc: switch to mtd_ooblayout_ops
Date:   Fri, 26 Feb 2016 01:57:42 +0100
Message-Id: <1456448280-27788-35-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1456448280-27788-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1456448280-27788-1-git-send-email-boris.brezillon@free-electrons.com>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52308
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
 drivers/mtd/nand/fsl_ifc_nand.c | 231 ++++++++++++----------------------------
 1 file changed, 67 insertions(+), 164 deletions(-)

diff --git a/drivers/mtd/nand/fsl_ifc_nand.c b/drivers/mtd/nand/fsl_ifc_nand.c
index 2e970ac..83331df 100644
--- a/drivers/mtd/nand/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/fsl_ifc_nand.c
@@ -67,136 +67,6 @@ struct fsl_ifc_nand_ctrl {
 
 static struct fsl_ifc_nand_ctrl *ifc_nand_ctrl;
 
-/* 512-byte page with 4-bit ECC, 8-bit */
-static struct nand_ecclayout oob_512_8bit_ecc4 = {
-	.eccbytes = 8,
-	.eccpos = {8, 9, 10, 11, 12, 13, 14, 15},
-	.oobfree = { {0, 5}, {6, 2} },
-};
-
-/* 512-byte page with 4-bit ECC, 16-bit */
-static struct nand_ecclayout oob_512_16bit_ecc4 = {
-	.eccbytes = 8,
-	.eccpos = {8, 9, 10, 11, 12, 13, 14, 15},
-	.oobfree = { {2, 6}, },
-};
-
-/* 2048-byte page size with 4-bit ECC */
-static struct nand_ecclayout oob_2048_ecc4 = {
-	.eccbytes = 32,
-	.eccpos = {
-		8, 9, 10, 11, 12, 13, 14, 15,
-		16, 17, 18, 19, 20, 21, 22, 23,
-		24, 25, 26, 27, 28, 29, 30, 31,
-		32, 33, 34, 35, 36, 37, 38, 39,
-	},
-	.oobfree = { {2, 6}, {40, 24} },
-};
-
-/* 4096-byte page size with 4-bit ECC */
-static struct nand_ecclayout oob_4096_ecc4 = {
-	.eccbytes = 64,
-	.eccpos = {
-		8, 9, 10, 11, 12, 13, 14, 15,
-		16, 17, 18, 19, 20, 21, 22, 23,
-		24, 25, 26, 27, 28, 29, 30, 31,
-		32, 33, 34, 35, 36, 37, 38, 39,
-		40, 41, 42, 43, 44, 45, 46, 47,
-		48, 49, 50, 51, 52, 53, 54, 55,
-		56, 57, 58, 59, 60, 61, 62, 63,
-		64, 65, 66, 67, 68, 69, 70, 71,
-	},
-	.oobfree = { {2, 6}, {72, 56} },
-};
-
-/* 4096-byte page size with 8-bit ECC -- requires 218-byte OOB */
-static struct nand_ecclayout oob_4096_ecc8 = {
-	.eccbytes = 128,
-	.eccpos = {
-		8, 9, 10, 11, 12, 13, 14, 15,
-		16, 17, 18, 19, 20, 21, 22, 23,
-		24, 25, 26, 27, 28, 29, 30, 31,
-		32, 33, 34, 35, 36, 37, 38, 39,
-		40, 41, 42, 43, 44, 45, 46, 47,
-		48, 49, 50, 51, 52, 53, 54, 55,
-		56, 57, 58, 59, 60, 61, 62, 63,
-		64, 65, 66, 67, 68, 69, 70, 71,
-		72, 73, 74, 75, 76, 77, 78, 79,
-		80, 81, 82, 83, 84, 85, 86, 87,
-		88, 89, 90, 91, 92, 93, 94, 95,
-		96, 97, 98, 99, 100, 101, 102, 103,
-		104, 105, 106, 107, 108, 109, 110, 111,
-		112, 113, 114, 115, 116, 117, 118, 119,
-		120, 121, 122, 123, 124, 125, 126, 127,
-		128, 129, 130, 131, 132, 133, 134, 135,
-	},
-	.oobfree = { {2, 6}, {136, 82} },
-};
-
-/* 8192-byte page size with 4-bit ECC */
-static struct nand_ecclayout oob_8192_ecc4 = {
-	.eccbytes = 128,
-	.eccpos = {
-		8, 9, 10, 11, 12, 13, 14, 15,
-		16, 17, 18, 19, 20, 21, 22, 23,
-		24, 25, 26, 27, 28, 29, 30, 31,
-		32, 33, 34, 35, 36, 37, 38, 39,
-		40, 41, 42, 43, 44, 45, 46, 47,
-		48, 49, 50, 51, 52, 53, 54, 55,
-		56, 57, 58, 59, 60, 61, 62, 63,
-		64, 65, 66, 67, 68, 69, 70, 71,
-		72, 73, 74, 75, 76, 77, 78, 79,
-		80, 81, 82, 83, 84, 85, 86, 87,
-		88, 89, 90, 91, 92, 93, 94, 95,
-		96, 97, 98, 99, 100, 101, 102, 103,
-		104, 105, 106, 107, 108, 109, 110, 111,
-		112, 113, 114, 115, 116, 117, 118, 119,
-		120, 121, 122, 123, 124, 125, 126, 127,
-		128, 129, 130, 131, 132, 133, 134, 135,
-	},
-	.oobfree = { {2, 6}, {136, 208} },
-};
-
-/* 8192-byte page size with 8-bit ECC -- requires 218-byte OOB */
-static struct nand_ecclayout oob_8192_ecc8 = {
-	.eccbytes = 256,
-	.eccpos = {
-		8, 9, 10, 11, 12, 13, 14, 15,
-		16, 17, 18, 19, 20, 21, 22, 23,
-		24, 25, 26, 27, 28, 29, 30, 31,
-		32, 33, 34, 35, 36, 37, 38, 39,
-		40, 41, 42, 43, 44, 45, 46, 47,
-		48, 49, 50, 51, 52, 53, 54, 55,
-		56, 57, 58, 59, 60, 61, 62, 63,
-		64, 65, 66, 67, 68, 69, 70, 71,
-		72, 73, 74, 75, 76, 77, 78, 79,
-		80, 81, 82, 83, 84, 85, 86, 87,
-		88, 89, 90, 91, 92, 93, 94, 95,
-		96, 97, 98, 99, 100, 101, 102, 103,
-		104, 105, 106, 107, 108, 109, 110, 111,
-		112, 113, 114, 115, 116, 117, 118, 119,
-		120, 121, 122, 123, 124, 125, 126, 127,
-		128, 129, 130, 131, 132, 133, 134, 135,
-		136, 137, 138, 139, 140, 141, 142, 143,
-		144, 145, 146, 147, 148, 149, 150, 151,
-		152, 153, 154, 155, 156, 157, 158, 159,
-		160, 161, 162, 163, 164, 165, 166, 167,
-		168, 169, 170, 171, 172, 173, 174, 175,
-		176, 177, 178, 179, 180, 181, 182, 183,
-		184, 185, 186, 187, 188, 189, 190, 191,
-		192, 193, 194, 195, 196, 197, 198, 199,
-		200, 201, 202, 203, 204, 205, 206, 207,
-		208, 209, 210, 211, 212, 213, 214, 215,
-		216, 217, 218, 219, 220, 221, 222, 223,
-		224, 225, 226, 227, 228, 229, 230, 231,
-		232, 233, 234, 235, 236, 237, 238, 239,
-		240, 241, 242, 243, 244, 245, 246, 247,
-		248, 249, 250, 251, 252, 253, 254, 255,
-		256, 257, 258, 259, 260, 261, 262, 263,
-	},
-	.oobfree = { {2, 6}, {264, 80} },
-};
-
 /*
  * Generic flash bbt descriptors
  */
@@ -223,6 +93,58 @@ static struct nand_bbt_descr bbt_mirror_descr = {
 	.pattern = mirror_pattern,
 };
 
+static int fsl_ifc_ooblayout_ecc(struct mtd_info *mtd, int section,
+				 struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	if (section)
+		return -ERANGE;
+
+	oobregion->offset = 8;
+	oobregion->length = chip->ecc.bytes * chip->ecc.steps;
+
+	return 0;
+}
+
+static int fsl_ifc_ooblayout_free(struct mtd_info *mtd, int section,
+				  struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	int eccbytes = chip->ecc.bytes * chip->ecc.steps;
+
+	if (section > 1)
+		return -ERANGE;
+
+	if (mtd->writesize == 512 &&
+	    !(chip->options & NAND_BUSWIDTH_16)) {
+		if (!section) {
+			oobregion->offset = 0;
+			oobregion->length = 5;
+		} else {
+			oobregion->offset = 6;
+			oobregion->length = 2;
+		}
+
+		return 0;
+	}
+
+	if (!section) {
+		oobregion->offset = 2;
+		oobregion->length = 6;
+	} else {
+		oobregion->offset = eccbytes + 8;
+		oobregion->length = mtd->oobsize - oobregion->offset;
+	}
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops fsl_ifc_ooblayout_ops = {
+	.ecc = fsl_ifc_ooblayout_ecc,
+	.free = fsl_ifc_ooblayout_free,
+};
+
 /*
  * Set up the IFC hardware block and page address fields, and the ifc nand
  * structure addr field to point to the correct IFC buffer in memory
@@ -812,8 +734,8 @@ static int fsl_ifc_chip_init_tail(struct mtd_info *mtd)
 							chip->ecc.bytes);
 	dev_dbg(priv->dev, "%s: nand->ecc.total = %d\n", __func__,
 							chip->ecc.total);
-	dev_dbg(priv->dev, "%s: nand->ecc.layout = %p\n", __func__,
-							chip->ecc.layout);
+	dev_dbg(priv->dev, "%s: mtd->ooblayout = %p\n", __func__,
+							mtd->ooblayout);
 	dev_dbg(priv->dev, "%s: mtd->flags = %08x\n", __func__, mtd->flags);
 	dev_dbg(priv->dev, "%s: mtd->size = %lld\n", __func__, mtd->size);
 	dev_dbg(priv->dev, "%s: mtd->erasesize = %d\n", __func__,
@@ -881,7 +803,6 @@ static int fsl_ifc_chip_init(struct fsl_ifc_mtd *priv)
 	struct fsl_ifc_regs __iomem *ifc = ctrl->regs;
 	struct nand_chip *chip = &priv->chip;
 	struct mtd_info *mtd = nand_to_mtd(&priv->chip);
-	struct nand_ecclayout *layout;
 	u32 csor;
 
 	/* Fill in fsl_ifc_mtd structure */
@@ -925,18 +846,9 @@ static int fsl_ifc_chip_init(struct fsl_ifc_mtd *priv)
 
 	csor = ifc_in32(&ifc->csor_cs[priv->bank].csor);
 
-	/* Hardware generates ECC per 512 Bytes */
-	chip->ecc.size = 512;
-	chip->ecc.bytes = 8;
-	chip->ecc.strength = 4;
-
 	switch (csor & CSOR_NAND_PGS_MASK) {
 	case CSOR_NAND_PGS_512:
-		if (chip->options & NAND_BUSWIDTH_16) {
-			layout = &oob_512_16bit_ecc4;
-		} else {
-			layout = &oob_512_8bit_ecc4;
-
+		if (!(chip->options & NAND_BUSWIDTH_16)) {
 			/* Avoid conflict with bad block marker */
 			bbt_main_descr.offs = 0;
 			bbt_mirror_descr.offs = 0;
@@ -946,35 +858,16 @@ static int fsl_ifc_chip_init(struct fsl_ifc_mtd *priv)
 		break;
 
 	case CSOR_NAND_PGS_2K:
-		layout = &oob_2048_ecc4;
 		priv->bufnum_mask = 3;
 		break;
 
 	case CSOR_NAND_PGS_4K:
-		if ((csor & CSOR_NAND_ECC_MODE_MASK) ==
-		    CSOR_NAND_ECC_MODE_4) {
-			layout = &oob_4096_ecc4;
-		} else {
-			layout = &oob_4096_ecc8;
-			chip->ecc.bytes = 16;
-			chip->ecc.strength = 8;
-		}
-
 		priv->bufnum_mask = 1;
 		break;
 
 	case CSOR_NAND_PGS_8K:
-		if ((csor & CSOR_NAND_ECC_MODE_MASK) ==
-		    CSOR_NAND_ECC_MODE_4) {
-			layout = &oob_8192_ecc4;
-		} else {
-			layout = &oob_8192_ecc8;
-			chip->ecc.bytes = 16;
-			chip->ecc.strength = 8;
-		}
-
 		priv->bufnum_mask = 0;
-	break;
+		break;
 
 	default:
 		dev_err(priv->dev, "bad csor %#x: bad page size\n", csor);
@@ -984,7 +877,17 @@ static int fsl_ifc_chip_init(struct fsl_ifc_mtd *priv)
 	/* Must also set CSOR_NAND_ECC_ENC_EN if DEC_EN set */
 	if (csor & CSOR_NAND_ECC_DEC_EN) {
 		chip->ecc.mode = NAND_ECC_HW;
-		chip->ecc.layout = layout;
+		mtd_set_ooblayout(mtd, &fsl_ifc_ooblayout_ops);
+
+		/* Hardware generates ECC per 512 Bytes */
+		chip->ecc.size = 512;
+		if ((csor & CSOR_NAND_ECC_MODE_MASK) == CSOR_NAND_ECC_MODE_4) {
+			chip->ecc.bytes = 8;
+			chip->ecc.strength = 4;
+		} else {
+			chip->ecc.bytes = 16;
+			chip->ecc.strength = 8;
+		}
 	} else {
 		chip->ecc.mode = NAND_ECC_SOFT;
 	}
-- 
2.1.4
