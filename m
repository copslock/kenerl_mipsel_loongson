Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2016 18:27:38 +0200 (CEST)
Received: from down.free-electrons.com ([37.187.137.238]:42486 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27025946AbcC3QQkCZYHN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Mar 2016 18:16:40 +0200
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 3CCD41847; Wed, 30 Mar 2016 18:16:34 +0200 (CEST)
Received: from localhost.localdomain (LMontsouris-657-1-184-87.w90-63.abo.wanadoo.fr [90.63.216.87])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 3A56A183B;
        Wed, 30 Mar 2016 18:15:40 +0200 (CEST)
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
Subject: [PATCH v5 40/50] mtd: nand: pxa3xx: switch to mtd_ooblayout_ops
Date:   Wed, 30 Mar 2016 18:14:55 +0200
Message-Id: <1459354505-32551-41-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52784
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
 drivers/mtd/nand/pxa3xx_nand.c | 104 +++++++++++++++++++++++++----------------
 1 file changed, 64 insertions(+), 40 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index d650885..ce2e2d9 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -324,6 +324,62 @@ static struct pxa3xx_nand_flash builtin_flash_types[] = {
 	{ 0xba20, 16, 16, &timing[3] },
 };
 
+static int pxa3xx_ooblayout_ecc(struct mtd_info *mtd, int section,
+				struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct pxa3xx_nand_host *host = nand_get_controller_data(chip);
+	struct pxa3xx_nand_info *info = host->info_data;
+	int nchunks = mtd->writesize / info->chunk_size;
+
+	if (section >= nchunks)
+		return -ERANGE;
+
+	oobregion->offset = ((info->ecc_size + info->spare_size) * section) +
+			    info->spare_size;
+	oobregion->length = info->ecc_size;
+
+	return 0;
+}
+
+static int pxa3xx_ooblayout_free(struct mtd_info *mtd, int section,
+				 struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct pxa3xx_nand_host *host = nand_get_controller_data(chip);
+	struct pxa3xx_nand_info *info = host->info_data;
+	int nchunks = mtd->writesize / info->chunk_size;
+
+	if (section >= nchunks)
+		return -ERANGE;
+
+	if (!info->spare_size)
+		return 0;
+
+	oobregion->offset = section * (info->ecc_size + info->spare_size);
+	oobregion->length = info->spare_size;
+	if (!section) {
+		/*
+		 * Bootrom looks in bytes 0 & 5 for bad blocks for the
+		 * 4KB page / 4bit BCH combination.
+		 */
+		if (mtd->writesize == 4096 && info->chunk_size == 2048) {
+			oobregion->offset += 6;
+			oobregion->length -= 6;
+		} else {
+			oobregion->offset += 2;
+			oobregion->length -= 2;
+		}
+	}
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops pxa3xx_ooblayout_ops = {
+	.ecc = pxa3xx_ooblayout_ecc,
+	.free = pxa3xx_ooblayout_free,
+};
+
 static u8 bbt_pattern[] = {'M', 'V', 'B', 'b', 't', '0' };
 static u8 bbt_mirror_pattern[] = {'1', 't', 'b', 'B', 'V', 'M' };
 
@@ -347,41 +403,6 @@ static struct nand_bbt_descr bbt_mirror_descr = {
 	.pattern = bbt_mirror_pattern
 };
 
-static struct nand_ecclayout ecc_layout_2KB_bch4bit = {
-	.eccbytes = 32,
-	.eccpos = {
-		32, 33, 34, 35, 36, 37, 38, 39,
-		40, 41, 42, 43, 44, 45, 46, 47,
-		48, 49, 50, 51, 52, 53, 54, 55,
-		56, 57, 58, 59, 60, 61, 62, 63},
-	.oobfree = { {2, 30} }
-};
-
-static struct nand_ecclayout ecc_layout_4KB_bch4bit = {
-	.eccbytes = 64,
-	.eccpos = {
-		32,  33,  34,  35,  36,  37,  38,  39,
-		40,  41,  42,  43,  44,  45,  46,  47,
-		48,  49,  50,  51,  52,  53,  54,  55,
-		56,  57,  58,  59,  60,  61,  62,  63,
-		96,  97,  98,  99,  100, 101, 102, 103,
-		104, 105, 106, 107, 108, 109, 110, 111,
-		112, 113, 114, 115, 116, 117, 118, 119,
-		120, 121, 122, 123, 124, 125, 126, 127},
-	/* Bootrom looks in bytes 0 & 5 for bad blocks */
-	.oobfree = { {6, 26}, { 64, 32} }
-};
-
-static struct nand_ecclayout ecc_layout_4KB_bch8bit = {
-	.eccbytes = 128,
-	.eccpos = {
-		32,  33,  34,  35,  36,  37,  38,  39,
-		40,  41,  42,  43,  44,  45,  46,  47,
-		48,  49,  50,  51,  52,  53,  54,  55,
-		56,  57,  58,  59,  60,  61,  62,  63},
-	.oobfree = { }
-};
-
 #define NDTR0_tCH(c)	(min((c), 7) << 19)
 #define NDTR0_tCS(c)	(min((c), 7) << 16)
 #define NDTR0_tWH(c)	(min((c), 7) << 11)
@@ -1546,9 +1567,12 @@ static void pxa3xx_nand_free_buff(struct pxa3xx_nand_info *info)
 }
 
 static int pxa_ecc_init(struct pxa3xx_nand_info *info,
-			struct nand_ecc_ctrl *ecc,
+			struct mtd_info *mtd,
 			int strength, int ecc_stepsize, int page_size)
 {
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct nand_ecc_ctrl *ecc = &chip->ecc;
+
 	if (strength == 1 && ecc_stepsize == 512 && page_size == 2048) {
 		info->nfullchunks = 1;
 		info->ntotalchunks = 1;
@@ -1582,7 +1606,7 @@ static int pxa_ecc_init(struct pxa3xx_nand_info *info,
 		info->ecc_size = 32;
 		ecc->mode = NAND_ECC_HW;
 		ecc->size = info->chunk_size;
-		ecc->layout = &ecc_layout_2KB_bch4bit;
+		mtd_set_ooblayout(mtd, &pxa3xx_ooblayout_ops);
 		ecc->strength = 16;
 
 	} else if (strength == 4 && ecc_stepsize == 512 && page_size == 4096) {
@@ -1594,7 +1618,7 @@ static int pxa_ecc_init(struct pxa3xx_nand_info *info,
 		info->ecc_size = 32;
 		ecc->mode = NAND_ECC_HW;
 		ecc->size = info->chunk_size;
-		ecc->layout = &ecc_layout_4KB_bch4bit;
+		mtd_set_ooblayout(mtd, &pxa3xx_ooblayout_ops);
 		ecc->strength = 16;
 
 	/*
@@ -1612,7 +1636,7 @@ static int pxa_ecc_init(struct pxa3xx_nand_info *info,
 		info->ecc_size = 32;
 		ecc->mode = NAND_ECC_HW;
 		ecc->size = info->chunk_size;
-		ecc->layout = &ecc_layout_4KB_bch8bit;
+		mtd_set_ooblayout(mtd, &pxa3xx_ooblayout_ops);
 		ecc->strength = 16;
 	} else {
 		dev_err(&info->pdev->dev,
@@ -1703,7 +1727,7 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)
 		ecc_step = 512;
 	}
 
-	ret = pxa_ecc_init(info, &chip->ecc, ecc_strength,
+	ret = pxa_ecc_init(info, mtd, ecc_strength,
 			   ecc_step, mtd->writesize);
 	if (ret)
 		return ret;
-- 
2.5.0
