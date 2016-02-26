Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Feb 2016 02:09:14 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:37998 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27014936AbcBZBHV65XMb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Feb 2016 02:07:21 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 651354CA3; Fri, 26 Feb 2016 02:07:13 +0100 (CET)
Received: from localhost.localdomain (unknown [208.66.31.210])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 8302EB1D;
        Fri, 26 Feb 2016 02:02:12 +0100 (CET)
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
Subject: [PATCH v3 36/52] mtd: nand: fsmc: get rid of the fsmc_nand_eccplace struct
Date:   Fri, 26 Feb 2016 01:57:44 +0100
Message-Id: <1456448280-27788-37-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1456448280-27788-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1456448280-27788-1-git-send-email-boris.brezillon@free-electrons.com>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52311
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

Now that mtd_ooblayout_ecc() returns the ECC byte position using the
OOB free method, we can get rid of the fsmc_nand_eccplace struct.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/fsmc_nand.c | 60 +++++++++++---------------------------------
 include/linux/mtd/fsmc.h     | 18 -------------
 2 files changed, 15 insertions(+), 63 deletions(-)

diff --git a/drivers/mtd/nand/fsmc_nand.c b/drivers/mtd/nand/fsmc_nand.c
index 275a98c..1372040 100644
--- a/drivers/mtd/nand/fsmc_nand.c
+++ b/drivers/mtd/nand/fsmc_nand.c
@@ -39,35 +39,6 @@
 #include <linux/amba/bus.h>
 #include <mtd/mtd-abi.h>
 
-/*
- * ECC placement definitions in oobfree type format.
- * There are 13 bytes of ecc for every 512 byte block and it has to be read
- * consecutively and immediately after the 512 byte data block for hardware to
- * generate the error bit offsets in 512 byte data.
- * Managing the ecc bytes in the following way makes it easier for software to
- * read ecc bytes consecutive to data bytes. This way is similar to
- * oobfree structure maintained already in generic nand driver
- */
-static struct fsmc_eccplace fsmc_ecc4_lp_place = {
-	.eccplace = {
-		{.offset = 2, .length = 13},
-		{.offset = 18, .length = 13},
-		{.offset = 34, .length = 13},
-		{.offset = 50, .length = 13},
-		{.offset = 66, .length = 13},
-		{.offset = 82, .length = 13},
-		{.offset = 98, .length = 13},
-		{.offset = 114, .length = 13}
-	}
-};
-
-static struct fsmc_eccplace fsmc_ecc4_sp_place = {
-	.eccplace = {
-		{.offset = 0, .length = 4},
-		{.offset = 6, .length = 9}
-	}
-};
-
 static int fsmc_ecc1_ooblayout_ecc(struct mtd_info *mtd, int section,
 				   struct mtd_oob_region *oobregion)
 {
@@ -105,6 +76,12 @@ static const struct mtd_ooblayout_ops fsmc_ecc1_ooblayout_ops = {
 	.free = fsmc_ecc1_ooblayout_free,
 };
 
+/*
+ * ECC placement definitions in oobfree type format.
+ * There are 13 bytes of ecc for every 512 byte block and it has to be read
+ * consecutively and immediately after the 512 byte data block for hardware to
+ * generate the error bit offsets in 512 byte data.
+ */
 static int fsmc_ecc4_ooblayout_ecc(struct mtd_info *mtd, int section,
 				   struct mtd_oob_region *oobregion)
 {
@@ -155,7 +132,6 @@ static const struct mtd_ooblayout_ops fsmc_ecc4_ooblayout_ops = {
  * @partitions:		Partition info for a NAND Flash.
  * @nr_partitions:	Total number of partition of a NAND flash.
  *
- * @ecc_place:		ECC placing locations in oobfree type format.
  * @bank:		Bank number for probed device.
  * @clk:		Clock structure for FSMC.
  *
@@ -175,7 +151,6 @@ struct fsmc_nand_data {
 	struct mtd_partition	*partitions;
 	unsigned int		nr_partitions;
 
-	struct fsmc_eccplace	*ecc_place;
 	unsigned int		bank;
 	struct device		*dev;
 	enum access_mode	mode;
@@ -582,8 +557,6 @@ static void fsmc_write_buf_dma(struct mtd_info *mtd, const uint8_t *buf,
 static int fsmc_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 				 uint8_t *buf, int oob_required, int page)
 {
-	struct fsmc_nand_data *host = mtd_to_fsmc(mtd);
-	struct fsmc_eccplace *ecc_place = host->ecc_place;
 	int i, j, s, stat, eccsize = chip->ecc.size;
 	int eccbytes = chip->ecc.bytes;
 	int eccsteps = chip->ecc.steps;
@@ -606,9 +579,15 @@ static int fsmc_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 		chip->read_buf(mtd, p, eccsize);
 
 		for (j = 0; j < eccbytes;) {
-			off = ecc_place->eccplace[group].offset;
-			len = ecc_place->eccplace[group].length;
-			group++;
+			struct mtd_oob_region oobregion;
+			int ret;
+
+			ret = mtd_ooblayout_ecc(mtd, group++, &oobregion);
+			if (ret)
+				return ret;
+
+			off = oobregion.offset;
+			len = oobregion.length;
 
 			/*
 			 * length is intentionally kept a higher multiple of 2
@@ -956,19 +935,10 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 	if (AMBA_REV_BITS(host->pid) >= 8) {
 		switch (mtd->oobsize) {
 		case 16:
-			host->ecc_place = &fsmc_ecc4_sp_place;
-			break;
 		case 64:
-			host->ecc_place = &fsmc_ecc4_lp_place;
-			break;
 		case 128:
-			host->ecc_place = &fsmc_ecc4_lp_place;
-			break;
 		case 224:
-			host->ecc_place = &fsmc_ecc4_lp_place;
-			break;
 		case 256:
-			host->ecc_place = &fsmc_ecc4_lp_place;
 			break;
 		default:
 			dev_warn(&pdev->dev, "No oob scheme defined for oobsize %d\n",
diff --git a/include/linux/mtd/fsmc.h b/include/linux/mtd/fsmc.h
index c8be32e..ad3c348 100644
--- a/include/linux/mtd/fsmc.h
+++ b/include/linux/mtd/fsmc.h
@@ -103,24 +103,6 @@
 
 #define FSMC_BUSY_WAIT_TIMEOUT	(1 * HZ)
 
-/*
- * There are 13 bytes of ecc for every 512 byte block in FSMC version 8
- * and it has to be read consecutively and immediately after the 512
- * byte data block for hardware to generate the error bit offsets
- * Managing the ecc bytes in the following way is easier. This way is
- * similar to oobfree structure maintained already in u-boot nand driver
- */
-#define MAX_ECCPLACE_ENTRIES	32
-
-struct fsmc_nand_eccplace {
-	uint8_t offset;
-	uint8_t length;
-};
-
-struct fsmc_eccplace {
-	struct fsmc_nand_eccplace eccplace[MAX_ECCPLACE_ENTRIES];
-};
-
 struct fsmc_nand_timings {
 	uint8_t tclr;
 	uint8_t tar;
-- 
2.1.4
