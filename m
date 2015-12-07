Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Dec 2015 23:29:29 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:55730 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27013278AbbLGW1LgrwWg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Dec 2015 23:27:11 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 5B4711B0A; Mon,  7 Dec 2015 23:27:10 +0100 (CET)
Received: from localhost.localdomain (unknown [37.160.132.173])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 2F59B1B09;
        Mon,  7 Dec 2015 23:27:06 +0100 (CET)
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
        Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH 10/23] mtd: nand: simplify nand_bch_init() usage
Date:   Mon,  7 Dec 2015 23:26:05 +0100
Message-Id: <1449527178-5930-11-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50388
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

nand_bch_init() requires several arguments which could directly be deduced
from the mtd device. Get rid of those useless parameters.

nand_bch_init() is also requiring the caller to provide a proper eccbytes
value, while this value could be deduced from the ecc.size and
ecc.strength value. Fallback to eccbytes calculation when it is set to 0.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/nand_base.c |  6 ++----
 drivers/mtd/nand/nand_bch.c  | 27 +++++++++++++++++----------
 drivers/mtd/nand/omap2.c     | 28 ++++++++++++----------------
 include/linux/mtd/nand_bch.h |  8 ++------
 4 files changed, 33 insertions(+), 36 deletions(-)

diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index 1107f5c1..b99b442 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -4247,10 +4247,8 @@ int nand_scan_tail(struct mtd_info *mtd)
 		}
 
 		/* See nand_bch_init() for details. */
-		ecc->bytes = DIV_ROUND_UP(
-				ecc->strength * fls(8 * ecc->size), 8);
-		ecc->priv = nand_bch_init(mtd, ecc->size, ecc->bytes,
-					       &ecc->layout);
+		ecc->bytes = 0;
+		ecc->priv = nand_bch_init(mtd);
 		if (!ecc->priv) {
 			pr_warn("BCH ECC initialization failed!\n");
 			BUG();
diff --git a/drivers/mtd/nand/nand_bch.c b/drivers/mtd/nand/nand_bch.c
index 3803e0b..3456c20 100644
--- a/drivers/mtd/nand/nand_bch.c
+++ b/drivers/mtd/nand/nand_bch.c
@@ -107,9 +107,6 @@ EXPORT_SYMBOL(nand_bch_correct_data);
 /**
  * nand_bch_init - [NAND Interface] Initialize NAND BCH error correction
  * @mtd:	MTD block structure
- * @eccsize:	ecc block size in bytes
- * @eccbytes:	ecc length in bytes
- * @ecclayout:	output default layout
  *
  * Returns:
  *  a pointer to a new NAND BCH control structure, or NULL upon failure
@@ -123,14 +120,21 @@ EXPORT_SYMBOL(nand_bch_correct_data);
  * @eccsize = 512  (thus, m=13 is the smallest integer such that 2^m-1 > 512*8)
  * @eccbytes = 7   (7 bytes are required to store m*t = 13*4 = 52 bits)
  */
-struct nand_bch_control *
-nand_bch_init(struct mtd_info *mtd, unsigned int eccsize, unsigned int eccbytes,
-	      struct nand_ecclayout **ecclayout)
+struct nand_bch_control *nand_bch_init(struct mtd_info *mtd)
 {
+	struct nand_chip *nand = mtd_to_nand(mtd);
 	unsigned int m, t, eccsteps, i;
-	struct nand_ecclayout *layout;
+	struct nand_ecclayout *layout = nand->ecc.layout;
 	struct nand_bch_control *nbc = NULL;
 	unsigned char *erased_page;
+	unsigned int eccsize = nand->ecc.size;
+	unsigned int eccbytes = nand->ecc.bytes;
+	unsigned int eccstrength = nand->ecc.strength;
+
+	if (!eccbytes && eccstrength) {
+		eccbytes = DIV_ROUND_UP(eccstrength * fls(8 * eccsize), 8);
+		nand->ecc.bytes = eccbytes;
+	}
 
 	if (!eccsize || !eccbytes) {
 		printk(KERN_WARNING "ecc parameters not supplied\n");
@@ -158,7 +162,7 @@ nand_bch_init(struct mtd_info *mtd, unsigned int eccsize, unsigned int eccbytes,
 	eccsteps = mtd->writesize/eccsize;
 
 	/* if no ecc placement scheme was provided, build one */
-	if (!*ecclayout) {
+	if (!layout) {
 
 		/* handle large page devices only */
 		if (mtd->oobsize < 64) {
@@ -184,7 +188,7 @@ nand_bch_init(struct mtd_info *mtd, unsigned int eccsize, unsigned int eccbytes,
 		layout->oobfree[0].offset = 2;
 		layout->oobfree[0].length = mtd->oobsize-2-layout->eccbytes;
 
-		*ecclayout = layout;
+		nand->ecc.layout = layout;
 	}
 
 	/* sanity checks */
@@ -192,7 +196,7 @@ nand_bch_init(struct mtd_info *mtd, unsigned int eccsize, unsigned int eccbytes,
 		printk(KERN_WARNING "eccsize %u is too large\n", eccsize);
 		goto fail;
 	}
-	if ((*ecclayout)->eccbytes != (eccsteps*eccbytes)) {
+	if (layout->eccbytes != (eccsteps*eccbytes)) {
 		printk(KERN_WARNING "invalid ecc layout\n");
 		goto fail;
 	}
@@ -216,6 +220,9 @@ nand_bch_init(struct mtd_info *mtd, unsigned int eccsize, unsigned int eccbytes,
 	for (i = 0; i < eccbytes; i++)
 		nbc->eccmask[i] ^= 0xff;
 
+	if (!eccstrength)
+		nand->ecc.strength = (eccbytes * 8) / fls(8 * eccsize);
+
 	return nbc;
 fail:
 	nand_bch_free(nbc);
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index e307576..a2f015d 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1820,13 +1820,19 @@ static int omap_nand_probe(struct platform_device *pdev)
 		goto return_error;
 	}
 
+	/*
+	 * Bail out earlier to let NAND_ECC_SOFT code create its own
+	 * ecclayout instead of using ours.
+	 */
+	if (info->ecc_opt == OMAP_ECC_HAM1_CODE_SW) {
+		nand_chip->ecc.mode = NAND_ECC_SOFT;
+		goto scan_tail;
+	}
+
 	/* populate MTD interface based on ECC scheme */
 	ecclayout		= &info->oobinfo;
+	nand_chip->ecc.layout	= ecclayout;
 	switch (info->ecc_opt) {
-	case OMAP_ECC_HAM1_CODE_SW:
-		nand_chip->ecc.mode = NAND_ECC_SOFT;
-		break;
-
 	case OMAP_ECC_HAM1_CODE_HW:
 		pr_info("nand: using OMAP_ECC_HAM1_CODE_HW\n");
 		nand_chip->ecc.mode             = NAND_ECC_HW;
@@ -1874,10 +1880,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 		ecclayout->oobfree->offset	= 1 +
 				ecclayout->eccpos[ecclayout->eccbytes - 1] + 1;
 		/* software bch library is used for locating errors */
-		nand_chip->ecc.priv		= nand_bch_init(mtd,
-							nand_chip->ecc.size,
-							nand_chip->ecc.bytes,
-							&ecclayout);
+		nand_chip->ecc.priv		= nand_bch_init(mtd);
 		if (!nand_chip->ecc.priv) {
 			dev_err(&info->pdev->dev, "unable to use BCH library\n");
 			err = -EINVAL;
@@ -1938,10 +1941,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 		ecclayout->oobfree->offset	= 1 +
 				ecclayout->eccpos[ecclayout->eccbytes - 1] + 1;
 		/* software bch library is used for locating errors */
-		nand_chip->ecc.priv		= nand_bch_init(mtd,
-							nand_chip->ecc.size,
-							nand_chip->ecc.bytes,
-							&ecclayout);
+		nand_chip->ecc.priv		= nand_bch_init(mtd);
 		if (!nand_chip->ecc.priv) {
 			dev_err(&info->pdev->dev, "unable to use BCH library\n");
 			err = -EINVAL;
@@ -2015,9 +2015,6 @@ static int omap_nand_probe(struct platform_device *pdev)
 		goto return_error;
 	}
 
-	if (info->ecc_opt == OMAP_ECC_HAM1_CODE_SW)
-		goto scan_tail;
-
 	/* all OOB bytes from oobfree->offset till end off OOB are free */
 	ecclayout->oobfree->length = mtd->oobsize - ecclayout->oobfree->offset;
 	/* check if NAND device's OOB is enough to store ECC signatures */
@@ -2028,7 +2025,6 @@ static int omap_nand_probe(struct platform_device *pdev)
 		err = -EINVAL;
 		goto return_error;
 	}
-	nand_chip->ecc.layout = ecclayout;
 
 scan_tail:
 	/* second phase scan */
diff --git a/include/linux/mtd/nand_bch.h b/include/linux/mtd/nand_bch.h
index 74acf53..04f2c8b 100644
--- a/include/linux/mtd/nand_bch.h
+++ b/include/linux/mtd/nand_bch.h
@@ -32,9 +32,7 @@ int nand_bch_correct_data(struct mtd_info *mtd, u_char *dat, u_char *read_ecc,
 /*
  * Initialize BCH encoder/decoder
  */
-struct nand_bch_control *
-nand_bch_init(struct mtd_info *mtd, unsigned int eccsize,
-	      unsigned int eccbytes, struct nand_ecclayout **ecclayout);
+struct nand_bch_control *nand_bch_init(struct mtd_info *mtd);
 /*
  * Release BCH encoder/decoder resources
  */
@@ -58,9 +56,7 @@ nand_bch_correct_data(struct mtd_info *mtd, unsigned char *buf,
 	return -1;
 }
 
-static inline struct nand_bch_control *
-nand_bch_init(struct mtd_info *mtd, unsigned int eccsize,
-	      unsigned int eccbytes, struct nand_ecclayout **ecclayout)
+static inline struct nand_bch_control *nand_bch_init(struct mtd_info *mtd)
 {
 	return NULL;
 }
-- 
2.1.4
