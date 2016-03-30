Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2016 18:28:49 +0200 (CEST)
Received: from down.free-electrons.com ([37.187.137.238]:42602 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27025951AbcC3QQquMs5N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Mar 2016 18:16:46 +0200
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 0FC7E184D; Wed, 30 Mar 2016 18:16:40 +0200 (CEST)
Received: from localhost.localdomain (LMontsouris-657-1-184-87.w90-63.abo.wanadoo.fr [90.63.216.87])
        by mail.free-electrons.com (Postfix) with ESMTPSA id A2913181D;
        Wed, 30 Mar 2016 18:15:43 +0200 (CEST)
From:   Boris Brezillon <boris.brezillon@free-electrons.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>
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
        Archit Taneja <architt@codeaurora.org>,
        Han Xu <b45815@freescale.com>,
        Huang Shijie <shijie.huang@arm.com>
Subject: [PATCH v5 44/50] mtd: nand: sunxi: switch to mtd_ooblayout_ops
Date:   Wed, 30 Mar 2016 18:14:59 +0200
Message-Id: <1459354505-32551-45-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52788
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
 drivers/mtd/nand/sunxi_nand.c | 114 +++++++++++++++++++-----------------------
 1 file changed, 52 insertions(+), 62 deletions(-)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index 1c03eee..4b9d984 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -212,12 +212,9 @@ struct sunxi_nand_chip_sel {
  * sunxi HW ECC infos: stores information related to HW ECC support
  *
  * @mode:	the sunxi ECC mode field deduced from ECC requirements
- * @layout:	the OOB layout depending on the ECC requirements and the
- *		selected ECC mode
  */
 struct sunxi_nand_hw_ecc {
 	int mode;
-	struct nand_ecclayout layout;
 };
 
 /*
@@ -1257,6 +1254,57 @@ static int sunxi_nand_chip_init_timings(struct sunxi_nand_chip *chip,
 	return sunxi_nand_chip_set_timings(chip, timings);
 }
 
+static int sunxi_nand_ooblayout_ecc(struct mtd_info *mtd, int section,
+				    struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *nand = mtd_to_nand(mtd);
+	struct nand_ecc_ctrl *ecc = &nand->ecc;
+
+	if (section >= ecc->steps)
+		return -ERANGE;
+
+	oobregion->offset = section * (ecc->bytes + 4) + 4;
+	oobregion->length = ecc->bytes;
+
+	return 0;
+}
+
+static int sunxi_nand_ooblayout_free(struct mtd_info *mtd, int section,
+				     struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *nand = mtd_to_nand(mtd);
+	struct nand_ecc_ctrl *ecc = &nand->ecc;
+
+	if (section > ecc->steps)
+		return -ERANGE;
+
+	/*
+	 * The first 2 bytes are used for BB markers, hence we
+	 * only have 2 bytes available in the first user data
+	 * section.
+	 */
+	if (!section && ecc->mode == NAND_ECC_HW) {
+		oobregion->offset = 2;
+		oobregion->length = 2;
+
+		return 0;
+	}
+
+	oobregion->offset = section * (ecc->bytes + 4);
+
+	if (section < ecc->steps)
+		oobregion->length = 4;
+	else
+		oobregion->offset = mtd->oobsize - oobregion->offset;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops sunxi_nand_ooblayout_ops = {
+	.ecc = sunxi_nand_ooblayout_ecc,
+	.free = sunxi_nand_ooblayout_free,
+};
+
 static int sunxi_nand_hw_common_ecc_ctrl_init(struct mtd_info *mtd,
 					      struct nand_ecc_ctrl *ecc,
 					      struct device_node *np)
@@ -1266,7 +1314,6 @@ static int sunxi_nand_hw_common_ecc_ctrl_init(struct mtd_info *mtd,
 	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
 	struct sunxi_nfc *nfc = to_sunxi_nfc(sunxi_nand->nand.controller);
 	struct sunxi_nand_hw_ecc *data;
-	struct nand_ecclayout *layout;
 	int nsectors;
 	int ret;
 	int i;
@@ -1295,7 +1342,6 @@ static int sunxi_nand_hw_common_ecc_ctrl_init(struct mtd_info *mtd,
 	/* HW ECC always work with even numbers of ECC bytes */
 	ecc->bytes = ALIGN(ecc->bytes, 2);
 
-	layout = &data->layout;
 	nsectors = mtd->writesize / ecc->size;
 
 	if (mtd->oobsize < ((ecc->bytes + 4) * nsectors)) {
@@ -1303,9 +1349,7 @@ static int sunxi_nand_hw_common_ecc_ctrl_init(struct mtd_info *mtd,
 		goto err;
 	}
 
-	layout->eccbytes = (ecc->bytes * nsectors);
-
-	ecc->layout = layout;
+	mtd_set_ooblayout(mtd, &sunxi_nand_ooblayout_ops);
 	ecc->priv = data;
 
 	return 0;
@@ -1325,9 +1369,6 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct mtd_info *mtd,
 				       struct nand_ecc_ctrl *ecc,
 				       struct device_node *np)
 {
-	struct nand_ecclayout *layout;
-	int nsectors;
-	int i, j;
 	int ret;
 
 	ret = sunxi_nand_hw_common_ecc_ctrl_init(mtd, ecc, np);
@@ -1336,40 +1377,6 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct mtd_info *mtd,
 
 	ecc->read_page = sunxi_nfc_hw_ecc_read_page;
 	ecc->write_page = sunxi_nfc_hw_ecc_write_page;
-	layout = ecc->layout;
-	nsectors = mtd->writesize / ecc->size;
-
-	for (i = 0; i < nsectors; i++) {
-		if (i) {
-			layout->oobfree[i].offset =
-				layout->oobfree[i - 1].offset +
-				layout->oobfree[i - 1].length +
-				ecc->bytes;
-			layout->oobfree[i].length = 4;
-		} else {
-			/*
-			 * The first 2 bytes are used for BB markers, hence we
-			 * only have 2 bytes available in the first user data
-			 * section.
-			 */
-			layout->oobfree[i].length = 2;
-			layout->oobfree[i].offset = 2;
-		}
-
-		for (j = 0; j < ecc->bytes; j++)
-			layout->eccpos[(ecc->bytes * i) + j] =
-					layout->oobfree[i].offset +
-					layout->oobfree[i].length + j;
-	}
-
-	if (mtd->oobsize > (ecc->bytes + 4) * nsectors) {
-		layout->oobfree[nsectors].offset =
-				layout->oobfree[nsectors - 1].offset +
-				layout->oobfree[nsectors - 1].length +
-				ecc->bytes;
-		layout->oobfree[nsectors].length = mtd->oobsize -
-				((ecc->bytes + 4) * nsectors);
-	}
 
 	return 0;
 }
@@ -1378,9 +1385,6 @@ static int sunxi_nand_hw_syndrome_ecc_ctrl_init(struct mtd_info *mtd,
 						struct nand_ecc_ctrl *ecc,
 						struct device_node *np)
 {
-	struct nand_ecclayout *layout;
-	int nsectors;
-	int i;
 	int ret;
 
 	ret = sunxi_nand_hw_common_ecc_ctrl_init(mtd, ecc, np);
@@ -1391,15 +1395,6 @@ static int sunxi_nand_hw_syndrome_ecc_ctrl_init(struct mtd_info *mtd,
 	ecc->read_page = sunxi_nfc_hw_syndrome_ecc_read_page;
 	ecc->write_page = sunxi_nfc_hw_syndrome_ecc_write_page;
 
-	layout = ecc->layout;
-	nsectors = mtd->writesize / ecc->size;
-
-	for (i = 0; i < (ecc->bytes * nsectors); i++)
-		layout->eccpos[i] = i;
-
-	layout->oobfree[0].length = mtd->oobsize - i;
-	layout->oobfree[0].offset = i;
-
 	return 0;
 }
 
@@ -1411,7 +1406,6 @@ static void sunxi_nand_ecc_cleanup(struct nand_ecc_ctrl *ecc)
 		sunxi_nand_hw_common_ecc_ctrl_cleanup(ecc);
 		break;
 	case NAND_ECC_NONE:
-		kfree(ecc->layout);
 	default:
 		break;
 	}
@@ -1445,10 +1439,6 @@ static int sunxi_nand_ecc_init(struct mtd_info *mtd, struct nand_ecc_ctrl *ecc,
 			return ret;
 		break;
 	case NAND_ECC_NONE:
-		ecc->layout = kzalloc(sizeof(*ecc->layout), GFP_KERNEL);
-		if (!ecc->layout)
-			return -ENOMEM;
-		ecc->layout->oobfree[0].length = mtd->oobsize;
 	case NAND_ECC_SOFT:
 		break;
 	default:
-- 
2.5.0
