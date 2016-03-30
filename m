Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2016 18:20:39 +0200 (CEST)
Received: from down.free-electrons.com ([37.187.137.238]:41813 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27025923AbcC3QPklYMFN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Mar 2016 18:15:40 +0200
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 3600F1854; Wed, 30 Mar 2016 18:15:32 +0200 (CEST)
Received: from localhost.localdomain (LMontsouris-657-1-184-87.w90-63.abo.wanadoo.fr [90.63.216.87])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 2125A114C;
        Wed, 30 Mar 2016 18:15:21 +0200 (CEST)
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
Subject: [PATCH v5 18/50] mtd: nand: implement the default mtd_ooblayout_ops
Date:   Wed, 30 Mar 2016 18:14:33 +0200
Message-Id: <1459354505-32551-19-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52761
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

Replace the default nand_ecclayout definitions for large and small page
devices with the equivalent mtd_ooblayout_ops.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/nand_base.c | 148 ++++++++++++++++++++++++++++---------------
 include/linux/mtd/nand.h     |   3 +
 2 files changed, 99 insertions(+), 52 deletions(-)

diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index 295af79..3d6985e 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -48,50 +48,6 @@
 #include <linux/mtd/partitions.h>
 #include <linux/of_mtd.h>
 
-/* Define default oob placement schemes for large and small page devices */
-static struct nand_ecclayout nand_oob_8 = {
-	.eccbytes = 3,
-	.eccpos = {0, 1, 2},
-	.oobfree = {
-		{.offset = 3,
-		 .length = 2},
-		{.offset = 6,
-		 .length = 2} }
-};
-
-static struct nand_ecclayout nand_oob_16 = {
-	.eccbytes = 6,
-	.eccpos = {0, 1, 2, 3, 6, 7},
-	.oobfree = {
-		{.offset = 8,
-		 . length = 8} }
-};
-
-static struct nand_ecclayout nand_oob_64 = {
-	.eccbytes = 24,
-	.eccpos = {
-		   40, 41, 42, 43, 44, 45, 46, 47,
-		   48, 49, 50, 51, 52, 53, 54, 55,
-		   56, 57, 58, 59, 60, 61, 62, 63},
-	.oobfree = {
-		{.offset = 2,
-		 .length = 38} }
-};
-
-static struct nand_ecclayout nand_oob_128 = {
-	.eccbytes = 48,
-	.eccpos = {
-		   80, 81, 82, 83, 84, 85, 86, 87,
-		   88, 89, 90, 91, 92, 93, 94, 95,
-		   96, 97, 98, 99, 100, 101, 102, 103,
-		   104, 105, 106, 107, 108, 109, 110, 111,
-		   112, 113, 114, 115, 116, 117, 118, 119,
-		   120, 121, 122, 123, 124, 125, 126, 127},
-	.oobfree = {
-		{.offset = 2,
-		 .length = 78} }
-};
-
 static int nand_get_device(struct mtd_info *mtd, int new_state);
 
 static int nand_do_write_oob(struct mtd_info *mtd, loff_t to,
@@ -103,6 +59,92 @@ static int nand_do_write_oob(struct mtd_info *mtd, loff_t to,
  */
 DEFINE_LED_TRIGGER(nand_led_trigger);
 
+/* Define default oob placement schemes for large and small page devices */
+static int nand_ooblayout_ecc_sp(struct mtd_info *mtd, int section,
+				 struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct nand_ecc_ctrl *ecc = &chip->ecc;
+
+	if (section > 1)
+		return -ERANGE;
+
+	if (!section) {
+		oobregion->offset = 0;
+		oobregion->length = 4;
+	} else {
+		oobregion->offset = 6;
+		oobregion->length = ecc->total - 4;
+	}
+
+	return 0;
+}
+
+static int nand_ooblayout_free_sp(struct mtd_info *mtd, int section,
+				  struct mtd_oob_region *oobregion)
+{
+	if (section > 1)
+		return -ERANGE;
+
+	if (mtd->oobsize == 16) {
+		if (section)
+			return -ERANGE;
+
+		oobregion->length = 8;
+		oobregion->offset = 8;
+	} else {
+		oobregion->length = 2;
+		if (!section)
+			oobregion->offset = 3;
+		else
+			oobregion->offset = 6;
+	}
+
+	return 0;
+}
+
+const struct mtd_ooblayout_ops nand_ooblayout_sp_ops = {
+	.ecc = nand_ooblayout_ecc_sp,
+	.free = nand_ooblayout_free_sp,
+};
+EXPORT_SYMBOL_GPL(nand_ooblayout_sp_ops);
+
+static int nand_ooblayout_ecc_lp(struct mtd_info *mtd, int section,
+				 struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct nand_ecc_ctrl *ecc = &chip->ecc;
+
+	if (section)
+		return -ERANGE;
+
+	oobregion->length = ecc->total;
+	oobregion->offset = mtd->oobsize - oobregion->length;
+
+	return 0;
+}
+
+static int nand_ooblayout_free_lp(struct mtd_info *mtd, int section,
+				  struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct nand_ecc_ctrl *ecc = &chip->ecc;
+
+	if (section)
+		return -ERANGE;
+
+	oobregion->length = mtd->oobsize - ecc->total - 2;
+	oobregion->offset = 2;
+
+	return 0;
+}
+
+const struct mtd_ooblayout_ops nand_ooblayout_lp_ops = {
+	.ecc = nand_ooblayout_ecc_lp,
+	.free = nand_ooblayout_free_lp,
+};
+EXPORT_SYMBOL_GPL(nand_ooblayout_lp_ops);
+
 static int check_offs_len(struct mtd_info *mtd,
 					loff_t ofs, uint64_t len)
 {
@@ -4120,21 +4162,24 @@ int nand_scan_tail(struct mtd_info *mtd)
 	chip->oob_poi = chip->buffers->databuf + mtd->writesize;
 
 	/*
+	 * Set the provided ECC layout. If ecc->layout is NULL, the MTD core
+	 * will just leave mtd->ooblayout to NULL, if it's not NULL, it will
+	 * set ->ooblayout to the default ecclayout wrapper.
+	 */
+	mtd_set_ecclayout(mtd, ecc->layout);
+
+	/*
 	 * If no default placement scheme is given, select an appropriate one.
 	 */
-	if (!ecc->layout && (ecc->mode != NAND_ECC_SOFT_BCH)) {
+	if (!mtd->ooblayout && (ecc->mode != NAND_ECC_SOFT_BCH)) {
 		switch (mtd->oobsize) {
 		case 8:
-			ecc->layout = &nand_oob_8;
-			break;
 		case 16:
-			ecc->layout = &nand_oob_16;
+			mtd_set_ooblayout(mtd, &nand_ooblayout_sp_ops);
 			break;
 		case 64:
-			ecc->layout = &nand_oob_64;
-			break;
 		case 128:
-			ecc->layout = &nand_oob_128;
+			mtd_set_ooblayout(mtd, &nand_ooblayout_lp_ops);
 			break;
 		default:
 			pr_warn("No oob scheme defined for oobsize %d\n",
@@ -4288,7 +4333,6 @@ int nand_scan_tail(struct mtd_info *mtd)
 		ecc->write_oob_raw = ecc->write_oob;
 
 	/* propagate ecc info to mtd_info */
-	mtd_set_ecclayout(mtd, ecc->layout);
 	mtd->ecc_strength = ecc->strength;
 	mtd->ecc_step_size = ecc->size;
 
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 1b673e1..a9796ba 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -748,6 +748,9 @@ struct nand_chip {
 	void *priv;
 };
 
+extern const struct mtd_ooblayout_ops nand_ooblayout_sp_ops;
+extern const struct mtd_ooblayout_ops nand_ooblayout_lp_ops;
+
 static inline void nand_set_flash_node(struct nand_chip *chip,
 				       struct device_node *np)
 {
-- 
2.5.0
