Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Feb 2016 11:17:20 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:37779 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27012573AbcBDKICsWe8O (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Feb 2016 11:08:02 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id D106D4215; Thu,  4 Feb 2016 11:08:02 +0100 (CET)
Received: from localhost.localdomain (AToulouse-657-1-20-139.w83-193.abo.wanadoo.fr [83.193.84.139])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 791A1439D;
        Thu,  4 Feb 2016 11:07:40 +0100 (CET)
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
Subject: [PATCH v2 33/51] mtd: nand: fsl_elbc: switch to mtd_ooblayout_ops
Date:   Thu,  4 Feb 2016 11:06:56 +0100
Message-Id: <1454580434-32078-34-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1454580434-32078-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1454580434-32078-1-git-send-email-boris.brezillon@free-electrons.com>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51751
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
 drivers/mtd/nand/fsl_elbc_nand.c | 83 +++++++++++++++++++++++-----------------
 1 file changed, 47 insertions(+), 36 deletions(-)

diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc_nand.c
index 059d5f7..487eae0 100644
--- a/drivers/mtd/nand/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/fsl_elbc_nand.c
@@ -79,32 +79,53 @@ struct fsl_elbc_fcm_ctrl {
 
 /* These map to the positions used by the FCM hardware ECC generator */
 
-/* Small Page FLASH with FMR[ECCM] = 0 */
-static struct nand_ecclayout fsl_elbc_oob_sp_eccm0 = {
-	.eccbytes = 3,
-	.eccpos = {6, 7, 8},
-	.oobfree = { {0, 5}, {9, 7} },
-};
+static int fsl_elbc_ooblayout_ecc(struct mtd_info *mtd, int section,
+				  struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct fsl_elbc_mtd *priv = nand_get_controller_data(chip);
 
-/* Small Page FLASH with FMR[ECCM] = 1 */
-static struct nand_ecclayout fsl_elbc_oob_sp_eccm1 = {
-	.eccbytes = 3,
-	.eccpos = {8, 9, 10},
-	.oobfree = { {0, 5}, {6, 2}, {11, 5} },
-};
+	if (section >= chip->ecc.steps)
+		return -ERANGE;
 
-/* Large Page FLASH with FMR[ECCM] = 0 */
-static struct nand_ecclayout fsl_elbc_oob_lp_eccm0 = {
-	.eccbytes = 12,
-	.eccpos = {6, 7, 8, 22, 23, 24, 38, 39, 40, 54, 55, 56},
-	.oobfree = { {1, 5}, {9, 13}, {25, 13}, {41, 13}, {57, 7} },
-};
+	oobregion->offset = (16 * section) + 6;
+	if (priv->fmr & FMR_ECCM)
+		oobregion->offset += 2;
 
-/* Large Page FLASH with FMR[ECCM] = 1 */
-static struct nand_ecclayout fsl_elbc_oob_lp_eccm1 = {
-	.eccbytes = 12,
-	.eccpos = {8, 9, 10, 24, 25, 26, 40, 41, 42, 56, 57, 58},
-	.oobfree = { {1, 7}, {11, 13}, {27, 13}, {43, 13}, {59, 5} },
+	oobregion->length = chip->ecc.bytes;
+
+	return 0;
+}
+
+static int fsl_elbc_ooblayout_free(struct mtd_info *mtd, int section,
+				   struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct fsl_elbc_mtd *priv = nand_get_controller_data(chip);
+
+	if (section > chip->ecc.steps)
+		return -ERANGE;
+
+	if (!section) {
+		oobregion->offset = 0;
+		if (mtd->writesize > 512)
+			oobregion->offset++;
+		oobregion->length = (priv->fmr & FMR_ECCM) ? 7 : 5;
+	} else {
+		oobregion->offset = (16 * section) -
+				    ((priv->fmr & FMR_ECCM) ? 5 : 7);
+		if (section < chip->ecc.steps)
+			oobregion->length = 13;
+		else
+			oobregion->length = mtd->oobsize - oobregion->offset;
+	}
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops fsl_elbc_ooblayout_ops = {
+	.ecc = fsl_elbc_ooblayout_ecc,
+	.free = fsl_elbc_ooblayout_free,
 };
 
 /*
@@ -657,8 +678,8 @@ static int fsl_elbc_chip_init_tail(struct mtd_info *mtd)
 	        chip->ecc.bytes);
 	dev_dbg(priv->dev, "fsl_elbc_init: nand->ecc.total = %d\n",
 	        chip->ecc.total);
-	dev_dbg(priv->dev, "fsl_elbc_init: nand->ecc.layout = %p\n",
-	        chip->ecc.layout);
+	dev_dbg(priv->dev, "fsl_elbc_init: mtd->ooblayout = %p\n",
+		mtd->ooblayout);
 	dev_dbg(priv->dev, "fsl_elbc_init: mtd->flags = %08x\n", mtd->flags);
 	dev_dbg(priv->dev, "fsl_elbc_init: mtd->size = %lld\n", mtd->size);
 	dev_dbg(priv->dev, "fsl_elbc_init: mtd->erasesize = %d\n",
@@ -675,14 +696,6 @@ static int fsl_elbc_chip_init_tail(struct mtd_info *mtd)
 	} else if (mtd->writesize == 2048) {
 		priv->page_size = 1;
 		setbits32(&lbc->bank[priv->bank].or, OR_FCM_PGS);
-		/* adjust ecc setup if needed */
-		if ((in_be32(&lbc->bank[priv->bank].br) & BR_DECC) ==
-		    BR_DECC_CHK_GEN) {
-			chip->ecc.size = 512;
-			chip->ecc.layout = (priv->fmr & FMR_ECCM) ?
-			                   &fsl_elbc_oob_lp_eccm1 :
-			                   &fsl_elbc_oob_lp_eccm0;
-		}
 	} else {
 		dev_err(priv->dev,
 		        "fsl_elbc_init: page size %d is not supported\n",
@@ -780,9 +793,7 @@ static int fsl_elbc_chip_init(struct fsl_elbc_mtd *priv)
 	if ((in_be32(&lbc->bank[priv->bank].br) & BR_DECC) ==
 	    BR_DECC_CHK_GEN) {
 		chip->ecc.mode = NAND_ECC_HW;
-		/* put in small page settings and adjust later if needed */
-		chip->ecc.layout = (priv->fmr & FMR_ECCM) ?
-				&fsl_elbc_oob_sp_eccm1 : &fsl_elbc_oob_sp_eccm0;
+		mtd_set_ooblayout(mtd, &fsl_elbc_ooblayout_ops);
 		chip->ecc.size = 512;
 		chip->ecc.bytes = 3;
 		chip->ecc.strength = 1;
-- 
2.1.4
