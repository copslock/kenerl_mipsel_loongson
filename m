Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Feb 2016 11:14:47 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:37797 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27012552AbcBDKH6OrDkO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Feb 2016 11:07:58 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 4F4E8474B; Thu,  4 Feb 2016 11:07:53 +0100 (CET)
Received: from localhost.localdomain (AToulouse-657-1-20-139.w83-193.abo.wanadoo.fr [83.193.84.139])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 9FCDB4209;
        Thu,  4 Feb 2016 11:07:34 +0100 (CET)
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
Subject: [PATCH v2 25/51] mtd: nand: atmel: switch to mtd_ooblayout_ops
Date:   Thu,  4 Feb 2016 11:06:48 +0100
Message-Id: <1454580434-32078-26-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1454580434-32078-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1454580434-32078-1-git-send-email-boris.brezillon@free-electrons.com>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51743
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
 drivers/mtd/nand/atmel_nand.c | 84 ++++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 46 deletions(-)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 9dde308..dddb219 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -67,30 +67,44 @@ struct atmel_nand_caps {
 	bool pmecc_correct_erase_page;
 };
 
-/* oob layout for large page size
+/*
+ * oob layout for large page size
  * bad block info is on bytes 0 and 1
  * the bytes have to be consecutives to avoid
  * several NAND_CMD_RNDOUT during read
- */
-static struct nand_ecclayout atmel_oobinfo_large = {
-	.eccbytes = 4,
-	.eccpos = {60, 61, 62, 63},
-	.oobfree = {
-		{2, 58}
-	},
-};
-
-/* oob layout for small page size
+ *
+ * oob layout for small page size
  * bad block info is on bytes 4 and 5
  * the bytes have to be consecutives to avoid
  * several NAND_CMD_RNDOUT during read
  */
-static struct nand_ecclayout atmel_oobinfo_small = {
-	.eccbytes = 4,
-	.eccpos = {0, 1, 2, 3},
-	.oobfree = {
-		{6, 10}
-	},
+static int atmel_ooblayout_ecc_sp(struct mtd_info *mtd, int section,
+				  struct mtd_oob_region *oobregion)
+{
+	if (section)
+		return -ERANGE;
+
+	oobregion->length = 4;
+	oobregion->offset = 0;
+
+	return 0;
+}
+
+static int atmel_ooblayout_free_sp(struct mtd_info *mtd, int section,
+				   struct mtd_oob_region *oobregion)
+{
+	if (section)
+		return -ERANGE;
+
+	oobregion->offset = 6;
+	oobregion->length = mtd->oobsize - oobregion->offset;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops atmel_ooblayout_sp_ops = {
+	.ecc = atmel_ooblayout_ecc_sp,
+	.free = atmel_ooblayout_free_sp,
 };
 
 struct atmel_nfc {
@@ -156,8 +170,6 @@ struct atmel_nand_host {
 	int			*pmecc_delta;
 };
 
-static struct nand_ecclayout atmel_pmecc_oobinfo;
-
 /*
  * Enable NAND.
  */
@@ -475,22 +487,6 @@ static int pmecc_get_ecc_bytes(int cap, int sector_size)
 	return (m * cap + 7) / 8;
 }
 
-static void pmecc_config_ecc_layout(struct nand_ecclayout *layout,
-				    int oobsize, int ecc_len)
-{
-	int i;
-
-	layout->eccbytes = ecc_len;
-
-	/* ECC will occupy the last ecc_len bytes continuously */
-	for (i = 0; i < ecc_len; i++)
-		layout->eccpos[i] = oobsize - ecc_len + i;
-
-	layout->oobfree[0].offset = PMECC_OOB_RESERVED_BYTES;
-	layout->oobfree[0].length =
-		oobsize - ecc_len - layout->oobfree[0].offset;
-}
-
 static void __iomem *pmecc_get_alpha_to(struct atmel_nand_host *host)
 {
 	int table_size;
@@ -1002,8 +998,8 @@ static void atmel_pmecc_core_init(struct mtd_info *mtd)
 {
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
 	struct atmel_nand_host *host = nand_get_controller_data(nand_chip);
+	int eccbytes = mtd_ooblayout_count_eccbytes(mtd);
 	uint32_t val = 0;
-	struct nand_ecclayout *ecc_layout;
 	struct mtd_oob_region oobregion;
 
 	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_RST);
@@ -1051,12 +1047,11 @@ static void atmel_pmecc_core_init(struct mtd_info *mtd)
 		| PMECC_CFG_AUTO_DISABLE);
 	pmecc_writel(host->ecc, CFG, val);
 
-	ecc_layout = nand_chip->ecc.layout;
 	pmecc_writel(host->ecc, SAREA, mtd->oobsize - 1);
 	mtd_ooblayout_ecc(mtd, 0, &oobregion);
 	pmecc_writel(host->ecc, SADDR, oobregion.offset);
 	pmecc_writel(host->ecc, EADDR,
-		     oobregion.offset + ecc_layout->eccbytes - 1);
+		     oobregion.offset + eccbytes - 1);
 	/* See datasheet about PMECC Clock Control Register */
 	pmecc_writel(host->ecc, CLK, 2);
 	pmecc_writel(host->ecc, IDR, 0xff);
@@ -1271,11 +1266,8 @@ static int atmel_pmecc_nand_init_params(struct platform_device *pdev,
 			err_no = -EINVAL;
 			goto err;
 		}
-		pmecc_config_ecc_layout(&atmel_pmecc_oobinfo,
-					mtd->oobsize,
-					nand_chip->ecc.total);
 
-		nand_chip->ecc.layout = &atmel_pmecc_oobinfo;
+		mtd_set_ooblayout(mtd, &nand_ooblayout_lp_ops);
 		break;
 	default:
 		dev_warn(host->dev,
@@ -1617,19 +1609,19 @@ static int atmel_hw_nand_init_params(struct platform_device *pdev,
 	/* set ECC page size and oob layout */
 	switch (mtd->writesize) {
 	case 512:
-		nand_chip->ecc.layout = &atmel_oobinfo_small;
+		mtd_set_ooblayout(mtd, &atmel_ooblayout_sp_ops);
 		ecc_writel(host->ecc, MR, ATMEL_ECC_PAGESIZE_528);
 		break;
 	case 1024:
-		nand_chip->ecc.layout = &atmel_oobinfo_large;
+		mtd_set_ooblayout(mtd, &nand_ooblayout_lp_ops);
 		ecc_writel(host->ecc, MR, ATMEL_ECC_PAGESIZE_1056);
 		break;
 	case 2048:
-		nand_chip->ecc.layout = &atmel_oobinfo_large;
+		mtd_set_ooblayout(mtd, &nand_ooblayout_lp_ops);
 		ecc_writel(host->ecc, MR, ATMEL_ECC_PAGESIZE_2112);
 		break;
 	case 4096:
-		nand_chip->ecc.layout = &atmel_oobinfo_large;
+		mtd_set_ooblayout(mtd, &nand_ooblayout_lp_ops);
 		ecc_writel(host->ecc, MR, ATMEL_ECC_PAGESIZE_4224);
 		break;
 	default:
-- 
2.1.4
