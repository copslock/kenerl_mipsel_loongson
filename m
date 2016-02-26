Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Feb 2016 02:08:59 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:38015 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27014937AbcBZBHV7A-ab (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Feb 2016 02:07:21 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 1F08B4CA4; Fri, 26 Feb 2016 02:07:15 +0100 (CET)
Received: from localhost.localdomain (unknown [208.66.31.210])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 0E8911114;
        Fri, 26 Feb 2016 02:02:18 +0100 (CET)
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
Subject: [PATCH v3 37/52] mtd: nand: gpmi: switch to mtd_ooblayout_ops
Date:   Fri, 26 Feb 2016 01:57:45 +0100
Message-Id: <1456448280-27788-38-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1456448280-27788-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1456448280-27788-1-git-send-email-boris.brezillon@free-electrons.com>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52310
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
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c | 52 ++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index 3a29b65..316b5ac 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -47,10 +47,44 @@ static struct nand_bbt_descr gpmi_bbt_descr = {
  * We may change the layout if we can get the ECC info from the datasheet,
  * else we will use all the (page + OOB).
  */
-static struct nand_ecclayout gpmi_hw_ecclayout = {
-	.eccbytes = 0,
-	.eccpos = { 0, },
-	.oobfree = { {.offset = 0, .length = 0} }
+static int gpmi_ooblayout_ecc(struct mtd_info *mtd, int section,
+			      struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct gpmi_nand_data *this = nand_get_controller_data(chip);
+	struct bch_geometry *geo = &this->bch_geometry;
+
+	if (section)
+		return -ERANGE;
+
+	oobregion->offset = 0;
+	oobregion->length = geo->page_size - mtd->writesize;
+
+	return 0;
+}
+
+static int gpmi_ooblayout_free(struct mtd_info *mtd, int section,
+			       struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct gpmi_nand_data *this = nand_get_controller_data(chip);
+	struct bch_geometry *geo = &this->bch_geometry;
+
+	if (section)
+		return -ERANGE;
+
+	/* The available oob size we have. */
+	if (geo->page_size < mtd->writesize + mtd->oobsize) {
+		oobregion->offset = geo->page_size - mtd->writesize;
+		oobregion->length = mtd->oobsize - oobregion->offset;
+	}
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops gpmi_ooblayout_ops = {
+	.ecc = gpmi_ooblayout_ecc,
+	.free = gpmi_ooblayout_free,
 };
 
 static const struct gpmi_devdata gpmi_devdata_imx23 = {
@@ -141,7 +175,6 @@ static int set_geometry_by_ecc_info(struct gpmi_nand_data *this)
 	struct bch_geometry *geo = &this->bch_geometry;
 	struct nand_chip *chip = &this->nand;
 	struct mtd_info *mtd = nand_to_mtd(chip);
-	struct nand_oobfree *of = gpmi_hw_ecclayout.oobfree;
 	unsigned int block_mark_bit_offset;
 
 	if (!(chip->ecc_strength_ds > 0 && chip->ecc_step_ds > 0))
@@ -229,12 +262,6 @@ static int set_geometry_by_ecc_info(struct gpmi_nand_data *this)
 	geo->page_size = mtd->writesize + geo->metadata_size +
 		(geo->gf_len * geo->ecc_strength * geo->ecc_chunk_count) / 8;
 
-	/* The available oob size we have. */
-	if (geo->page_size < mtd->writesize + mtd->oobsize) {
-		of->offset = geo->page_size - mtd->writesize;
-		of->length = mtd->oobsize - of->offset;
-	}
-
 	geo->payload_size = mtd->writesize;
 
 	geo->auxiliary_status_offset = ALIGN(geo->metadata_size, 4);
@@ -1841,6 +1868,7 @@ static void gpmi_nand_exit(struct gpmi_nand_data *this)
 static int gpmi_init_last(struct gpmi_nand_data *this)
 {
 	struct nand_chip *chip = &this->nand;
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	struct bch_geometry *bch_geo = &this->bch_geometry;
 	int ret;
@@ -1862,7 +1890,7 @@ static int gpmi_init_last(struct gpmi_nand_data *this)
 	ecc->mode	= NAND_ECC_HW;
 	ecc->size	= bch_geo->ecc_chunk_size;
 	ecc->strength	= bch_geo->ecc_strength;
-	ecc->layout	= &gpmi_hw_ecclayout;
+	mtd_set_ooblayout(mtd, &gpmi_ooblayout_ops);
 
 	/*
 	 * We only enable the subpage read when:
-- 
2.1.4
