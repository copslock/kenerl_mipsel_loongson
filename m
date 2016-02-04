Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Feb 2016 11:07:40 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:37275 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27011229AbcBDKHWVD0eO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Feb 2016 11:07:22 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 451542AF; Thu,  4 Feb 2016 11:07:17 +0100 (CET)
Received: from localhost.localdomain (AToulouse-657-1-20-139.w83-193.abo.wanadoo.fr [83.193.84.139])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 78516246;
        Thu,  4 Feb 2016 11:07:16 +0100 (CET)
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
Subject: [PATCH v2 01/51] mtd: kill the ecclayout->oobavail field
Date:   Thu,  4 Feb 2016 11:06:24 +0100
Message-Id: <1454580434-32078-2-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1454580434-32078-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1454580434-32078-1-git-send-email-boris.brezillon@free-electrons.com>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51719
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

ecclayout->oobavail is just redundant with the mtd->oobavail field.
Moreover, it prevents static const definition of ecc layouts since the
NAND framework is calculating this value based on the ecclayout->oobfree
field.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/devices/docg3.c                   |  5 ++-
 drivers/mtd/mtdswap.c                         | 16 ++++-----
 drivers/mtd/nand/brcmnand/brcmnand.c          |  8 ++---
 drivers/mtd/nand/docg4.c                      |  1 -
 drivers/mtd/nand/hisi504_nand.c               |  1 -
 drivers/mtd/nand/nand_base.c                  | 12 +++----
 drivers/mtd/onenand/onenand_base.c            | 16 ++++-----
 drivers/mtd/tests/oobtest.c                   | 49 +++++++++++++--------------
 drivers/staging/mt29f_spinand/mt29f_spinand.c |  1 -
 fs/jffs2/wbuf.c                               |  6 ++--
 include/linux/mtd/mtd.h                       |  1 -
 11 files changed, 51 insertions(+), 65 deletions(-)

diff --git a/drivers/mtd/devices/docg3.c b/drivers/mtd/devices/docg3.c
index c3a2695..e7b2e43 100644
--- a/drivers/mtd/devices/docg3.c
+++ b/drivers/mtd/devices/docg3.c
@@ -72,13 +72,11 @@ MODULE_PARM_DESC(reliable_mode, "Set the docg3 mode (0=normal MLC, 1=fast, "
  * @eccbytes: 8 bytes are used (1 for Hamming ECC, 7 for BCH ECC)
  * @eccpos: ecc positions (byte 7 is Hamming ECC, byte 8-14 are BCH ECC)
  * @oobfree: free pageinfo bytes (byte 0 until byte 6, byte 15
- * @oobavail: 8 available bytes remaining after ECC toll
  */
 static struct nand_ecclayout docg3_oobinfo = {
 	.eccbytes = 8,
 	.eccpos = {7, 8, 9, 10, 11, 12, 13, 14},
 	.oobfree = {{0, 7}, {15, 1} },
-	.oobavail = 8,
 };
 
 static inline u8 doc_readb(struct docg3 *docg3, u16 reg)
@@ -1438,7 +1436,7 @@ static int doc_write_oob(struct mtd_info *mtd, loff_t ofs,
 		oobdelta = mtd->oobsize;
 		break;
 	case MTD_OPS_AUTO_OOB:
-		oobdelta = mtd->ecclayout->oobavail;
+		oobdelta = mtd->oobavail;
 		break;
 	default:
 		return -EINVAL;
@@ -1860,6 +1858,7 @@ static int __init doc_set_driver_info(int chip_id, struct mtd_info *mtd)
 	mtd->_write_oob = doc_write_oob;
 	mtd->_block_isbad = doc_block_isbad;
 	mtd->ecclayout = &docg3_oobinfo;
+	mtd->oobavail = 8;
 	mtd->ecc_strength = DOC_ECC_BCH_T;
 
 	return 0;
diff --git a/drivers/mtd/mtdswap.c b/drivers/mtd/mtdswap.c
index fc8b3d1..d330eb1 100644
--- a/drivers/mtd/mtdswap.c
+++ b/drivers/mtd/mtdswap.c
@@ -346,7 +346,7 @@ static int mtdswap_read_markers(struct mtdswap_dev *d, struct swap_eb *eb)
 	if (mtd_can_have_bb(d->mtd) && mtd_block_isbad(d->mtd, offset))
 		return MTDSWAP_SCANNED_BAD;
 
-	ops.ooblen = 2 * d->mtd->ecclayout->oobavail;
+	ops.ooblen = 2 * d->mtd->oobavail;
 	ops.oobbuf = d->oob_buf;
 	ops.ooboffs = 0;
 	ops.datbuf = NULL;
@@ -359,7 +359,7 @@ static int mtdswap_read_markers(struct mtdswap_dev *d, struct swap_eb *eb)
 
 	data = (struct mtdswap_oobdata *)d->oob_buf;
 	data2 = (struct mtdswap_oobdata *)
-		(d->oob_buf + d->mtd->ecclayout->oobavail);
+		(d->oob_buf + d->mtd->oobavail);
 
 	if (le16_to_cpu(data->magic) == MTDSWAP_MAGIC_CLEAN) {
 		eb->erase_count = le32_to_cpu(data->count);
@@ -933,7 +933,7 @@ static unsigned int mtdswap_eblk_passes(struct mtdswap_dev *d,
 
 	ops.mode = MTD_OPS_AUTO_OOB;
 	ops.len = mtd->writesize;
-	ops.ooblen = mtd->ecclayout->oobavail;
+	ops.ooblen = mtd->oobavail;
 	ops.ooboffs = 0;
 	ops.datbuf = d->page_buf;
 	ops.oobbuf = d->oob_buf;
@@ -945,7 +945,7 @@ static unsigned int mtdswap_eblk_passes(struct mtdswap_dev *d,
 		for (i = 0; i < mtd_pages; i++) {
 			patt = mtdswap_test_patt(test + i);
 			memset(d->page_buf, patt, mtd->writesize);
-			memset(d->oob_buf, patt, mtd->ecclayout->oobavail);
+			memset(d->oob_buf, patt, mtd->oobavail);
 			ret = mtd_write_oob(mtd, pos, &ops);
 			if (ret)
 				goto error;
@@ -964,7 +964,7 @@ static unsigned int mtdswap_eblk_passes(struct mtdswap_dev *d,
 				if (p1[j] != patt)
 					goto error;
 
-			for (j = 0; j < mtd->ecclayout->oobavail; j++)
+			for (j = 0; j < mtd->oobavail; j++)
 				if (p2[j] != (unsigned char)patt)
 					goto error;
 
@@ -1387,7 +1387,7 @@ static int mtdswap_init(struct mtdswap_dev *d, unsigned int eblocks,
 	if (!d->page_buf)
 		goto page_buf_fail;
 
-	d->oob_buf = kmalloc(2 * mtd->ecclayout->oobavail, GFP_KERNEL);
+	d->oob_buf = kmalloc(2 * mtd->oobavail, GFP_KERNEL);
 	if (!d->oob_buf)
 		goto oob_buf_fail;
 
@@ -1454,10 +1454,10 @@ static void mtdswap_add_mtd(struct mtd_blktrans_ops *tr, struct mtd_info *mtd)
 		return;
 	}
 
-	if (!mtd->oobsize || oinfo->oobavail < MTDSWAP_OOBSIZE) {
+	if (!mtd->oobsize || mtd->oobavail < MTDSWAP_OOBSIZE) {
 		printk(KERN_ERR "%s: Not enough free bytes in OOB, "
 			"%d available, %zu needed.\n",
-			MTDSWAP_PREFIX, oinfo->oobavail, MTDSWAP_OOBSIZE);
+			MTDSWAP_PREFIX, mtd->oobavail, MTDSWAP_OOBSIZE);
 		return;
 	}
 
diff --git a/drivers/mtd/nand/brcmnand/brcmnand.c b/drivers/mtd/nand/brcmnand/brcmnand.c
index 844fc07..b86882b 100644
--- a/drivers/mtd/nand/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/brcmnand/brcmnand.c
@@ -796,7 +796,8 @@ static struct nand_ecclayout *brcmnand_create_layout(int ecc_level,
 				    idx2 >= MTD_MAX_OOBFREE_ENTRIES_LARGE - 1)
 				break;
 		}
-		goto out;
+
+		return layout;
 	}
 
 	/*
@@ -847,10 +848,7 @@ static struct nand_ecclayout *brcmnand_create_layout(int ecc_level,
 				idx2 >= MTD_MAX_OOBFREE_ENTRIES_LARGE - 1)
 			break;
 	}
-out:
-	/* Sum available OOB */
-	for (i = 0; i < MTD_MAX_OOBFREE_ENTRIES_LARGE; i++)
-		layout->oobavail += layout->oobfree[i].length;
+
 	return layout;
 }
 
diff --git a/drivers/mtd/nand/docg4.c b/drivers/mtd/nand/docg4.c
index df4165b..fb46fd7 100644
--- a/drivers/mtd/nand/docg4.c
+++ b/drivers/mtd/nand/docg4.c
@@ -225,7 +225,6 @@ struct docg4_priv {
 static struct nand_ecclayout docg4_oobinfo = {
 	.eccbytes = 9,
 	.eccpos = {7, 8, 9, 10, 11, 12, 13, 14, 15},
-	.oobavail = 5,
 	.oobfree = { {.offset = 2, .length = 5} }
 };
 
diff --git a/drivers/mtd/nand/hisi504_nand.c b/drivers/mtd/nand/hisi504_nand.c
index f8d37f3..96502b6 100644
--- a/drivers/mtd/nand/hisi504_nand.c
+++ b/drivers/mtd/nand/hisi504_nand.c
@@ -632,7 +632,6 @@ static void hisi_nfc_host_init(struct hinfc_host *host)
 }
 
 static struct nand_ecclayout nand_ecc_2K_16bits = {
-	.oobavail = 6,
 	.oobfree = { {2, 6} },
 };
 
diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index f2c8ff3..21c48ff 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -2076,7 +2076,7 @@ static int nand_do_read_oob(struct mtd_info *mtd, loff_t from,
 	stats = mtd->ecc_stats;
 
 	if (ops->mode == MTD_OPS_AUTO_OOB)
-		len = chip->ecc.layout->oobavail;
+		len = mtd->oobavail;
 	else
 		len = mtd->oobsize;
 
@@ -2767,7 +2767,7 @@ static int nand_do_write_oob(struct mtd_info *mtd, loff_t to,
 			 __func__, (unsigned int)to, (int)ops->ooblen);
 
 	if (ops->mode == MTD_OPS_AUTO_OOB)
-		len = chip->ecc.layout->oobavail;
+		len = mtd->oobavail;
 	else
 		len = mtd->oobsize;
 
@@ -4325,11 +4325,9 @@ int nand_scan_tail(struct mtd_info *mtd)
 	 * The number of bytes available for a client to place data into
 	 * the out of band area.
 	 */
-	ecc->layout->oobavail = 0;
-	for (i = 0; ecc->layout->oobfree[i].length
-			&& i < ARRAY_SIZE(ecc->layout->oobfree); i++)
-		ecc->layout->oobavail += ecc->layout->oobfree[i].length;
-	mtd->oobavail = ecc->layout->oobavail;
+	mtd->oobavail = 0;
+	for (i = 0; ecc->layout->oobfree[i].length; i++)
+		mtd->oobavail += ecc->layout->oobfree[i].length;
 
 	/* ECC sanity check: warn if it's too weak */
 	if (!nand_ecc_strength_good(mtd))
diff --git a/drivers/mtd/onenand/onenand_base.c b/drivers/mtd/onenand/onenand_base.c
index 43b3392..d70bbfd 100644
--- a/drivers/mtd/onenand/onenand_base.c
+++ b/drivers/mtd/onenand/onenand_base.c
@@ -1125,7 +1125,7 @@ static int onenand_mlc_read_ops_nolock(struct mtd_info *mtd, loff_t from,
 			(int)len);
 
 	if (ops->mode == MTD_OPS_AUTO_OOB)
-		oobsize = this->ecclayout->oobavail;
+		oobsize = mtd->oobavail;
 	else
 		oobsize = mtd->oobsize;
 
@@ -1230,7 +1230,7 @@ static int onenand_read_ops_nolock(struct mtd_info *mtd, loff_t from,
 			(int)len);
 
 	if (ops->mode == MTD_OPS_AUTO_OOB)
-		oobsize = this->ecclayout->oobavail;
+		oobsize = mtd->oobavail;
 	else
 		oobsize = mtd->oobsize;
 
@@ -1365,7 +1365,7 @@ static int onenand_read_oob_nolock(struct mtd_info *mtd, loff_t from,
 	ops->oobretlen = 0;
 
 	if (mode == MTD_OPS_AUTO_OOB)
-		oobsize = this->ecclayout->oobavail;
+		oobsize = mtd->oobavail;
 	else
 		oobsize = mtd->oobsize;
 
@@ -1887,7 +1887,7 @@ static int onenand_write_ops_nolock(struct mtd_info *mtd, loff_t to,
 		return 0;
 
 	if (ops->mode == MTD_OPS_AUTO_OOB)
-		oobsize = this->ecclayout->oobavail;
+		oobsize = mtd->oobavail;
 	else
 		oobsize = mtd->oobsize;
 
@@ -2063,7 +2063,7 @@ static int onenand_write_oob_nolock(struct mtd_info *mtd, loff_t to,
 	ops->oobretlen = 0;
 
 	if (mode == MTD_OPS_AUTO_OOB)
-		oobsize = this->ecclayout->oobavail;
+		oobsize = mtd->oobavail;
 	else
 		oobsize = mtd->oobsize;
 
@@ -4049,12 +4049,10 @@ int onenand_scan(struct mtd_info *mtd, int maxchips)
 	 * The number of bytes available for a client to place data into
 	 * the out of band area
 	 */
-	this->ecclayout->oobavail = 0;
+	mtd->oobavail = 0;
 	for (i = 0; i < MTD_MAX_OOBFREE_ENTRIES &&
 	    this->ecclayout->oobfree[i].length; i++)
-		this->ecclayout->oobavail +=
-			this->ecclayout->oobfree[i].length;
-	mtd->oobavail = this->ecclayout->oobavail;
+		mtd->oobavail += this->ecclayout->oobfree[i].length;
 
 	mtd->ecclayout = this->ecclayout;
 	mtd->ecc_strength = 1;
diff --git a/drivers/mtd/tests/oobtest.c b/drivers/mtd/tests/oobtest.c
index 3176212..1cb3f77 100644
--- a/drivers/mtd/tests/oobtest.c
+++ b/drivers/mtd/tests/oobtest.c
@@ -215,19 +215,19 @@ static int verify_eraseblock(int ebnum)
 			pr_info("ignoring error as within bitflip_limit\n");
 		}
 
-		if (use_offset != 0 || use_len < mtd->ecclayout->oobavail) {
+		if (use_offset != 0 || use_len < mtd->oobavail) {
 			int k;
 
 			ops.mode      = MTD_OPS_AUTO_OOB;
 			ops.len       = 0;
 			ops.retlen    = 0;
-			ops.ooblen    = mtd->ecclayout->oobavail;
+			ops.ooblen    = mtd->oobavail;
 			ops.oobretlen = 0;
 			ops.ooboffs   = 0;
 			ops.datbuf    = NULL;
 			ops.oobbuf    = readbuf;
 			err = mtd_read_oob(mtd, addr, &ops);
-			if (err || ops.oobretlen != mtd->ecclayout->oobavail) {
+			if (err || ops.oobretlen != mtd->oobavail) {
 				pr_err("error: readoob failed at %#llx\n",
 						(long long)addr);
 				errcnt += 1;
@@ -244,7 +244,7 @@ static int verify_eraseblock(int ebnum)
 			/* verify post-(use_offset + use_len) area for 0xff */
 			k = use_offset + use_len;
 			bitflips += memffshow(addr, k, readbuf + k,
-					      mtd->ecclayout->oobavail - k);
+					      mtd->oobavail - k);
 
 			if (bitflips > bitflip_limit) {
 				pr_err("error: verify failed at %#llx\n",
@@ -269,8 +269,8 @@ static int verify_eraseblock_in_one_go(int ebnum)
 	struct mtd_oob_ops ops;
 	int err = 0;
 	loff_t addr = (loff_t)ebnum * mtd->erasesize;
-	size_t len = mtd->ecclayout->oobavail * pgcnt;
-	size_t oobavail = mtd->ecclayout->oobavail;
+	size_t len = mtd->oobavail * pgcnt;
+	size_t oobavail = mtd->oobavail;
 	size_t bitflips;
 	int i;
 
@@ -394,8 +394,8 @@ static int __init mtd_oobtest_init(void)
 		goto out;
 
 	use_offset = 0;
-	use_len = mtd->ecclayout->oobavail;
-	use_len_max = mtd->ecclayout->oobavail;
+	use_len = mtd->oobavail;
+	use_len_max = mtd->oobavail;
 	vary_offset = 0;
 
 	/* First test: write all OOB, read it back and verify */
@@ -460,8 +460,8 @@ static int __init mtd_oobtest_init(void)
 
 	/* Write all eraseblocks */
 	use_offset = 0;
-	use_len = mtd->ecclayout->oobavail;
-	use_len_max = mtd->ecclayout->oobavail;
+	use_len = mtd->oobavail;
+	use_len_max = mtd->oobavail;
 	vary_offset = 1;
 	prandom_seed_state(&rnd_state, 5);
 
@@ -471,8 +471,8 @@ static int __init mtd_oobtest_init(void)
 
 	/* Check all eraseblocks */
 	use_offset = 0;
-	use_len = mtd->ecclayout->oobavail;
-	use_len_max = mtd->ecclayout->oobavail;
+	use_len = mtd->oobavail;
+	use_len_max = mtd->oobavail;
 	vary_offset = 1;
 	prandom_seed_state(&rnd_state, 5);
 	err = verify_all_eraseblocks();
@@ -480,8 +480,8 @@ static int __init mtd_oobtest_init(void)
 		goto out;
 
 	use_offset = 0;
-	use_len = mtd->ecclayout->oobavail;
-	use_len_max = mtd->ecclayout->oobavail;
+	use_len = mtd->oobavail;
+	use_len_max = mtd->oobavail;
 	vary_offset = 0;
 
 	/* Fourth test: try to write off end of device */
@@ -501,7 +501,7 @@ static int __init mtd_oobtest_init(void)
 	ops.retlen    = 0;
 	ops.ooblen    = 1;
 	ops.oobretlen = 0;
-	ops.ooboffs   = mtd->ecclayout->oobavail;
+	ops.ooboffs   = mtd->oobavail;
 	ops.datbuf    = NULL;
 	ops.oobbuf    = writebuf;
 	pr_info("attempting to start write past end of OOB\n");
@@ -521,7 +521,7 @@ static int __init mtd_oobtest_init(void)
 	ops.retlen    = 0;
 	ops.ooblen    = 1;
 	ops.oobretlen = 0;
-	ops.ooboffs   = mtd->ecclayout->oobavail;
+	ops.ooboffs   = mtd->oobavail;
 	ops.datbuf    = NULL;
 	ops.oobbuf    = readbuf;
 	pr_info("attempting to start read past end of OOB\n");
@@ -543,7 +543,7 @@ static int __init mtd_oobtest_init(void)
 		ops.mode      = MTD_OPS_AUTO_OOB;
 		ops.len       = 0;
 		ops.retlen    = 0;
-		ops.ooblen    = mtd->ecclayout->oobavail + 1;
+		ops.ooblen    = mtd->oobavail + 1;
 		ops.oobretlen = 0;
 		ops.ooboffs   = 0;
 		ops.datbuf    = NULL;
@@ -563,7 +563,7 @@ static int __init mtd_oobtest_init(void)
 		ops.mode      = MTD_OPS_AUTO_OOB;
 		ops.len       = 0;
 		ops.retlen    = 0;
-		ops.ooblen    = mtd->ecclayout->oobavail + 1;
+		ops.ooblen    = mtd->oobavail + 1;
 		ops.oobretlen = 0;
 		ops.ooboffs   = 0;
 		ops.datbuf    = NULL;
@@ -587,7 +587,7 @@ static int __init mtd_oobtest_init(void)
 		ops.mode      = MTD_OPS_AUTO_OOB;
 		ops.len       = 0;
 		ops.retlen    = 0;
-		ops.ooblen    = mtd->ecclayout->oobavail;
+		ops.ooblen    = mtd->oobavail;
 		ops.oobretlen = 0;
 		ops.ooboffs   = 1;
 		ops.datbuf    = NULL;
@@ -607,7 +607,7 @@ static int __init mtd_oobtest_init(void)
 		ops.mode      = MTD_OPS_AUTO_OOB;
 		ops.len       = 0;
 		ops.retlen    = 0;
-		ops.ooblen    = mtd->ecclayout->oobavail;
+		ops.ooblen    = mtd->oobavail;
 		ops.oobretlen = 0;
 		ops.ooboffs   = 1;
 		ops.datbuf    = NULL;
@@ -638,7 +638,7 @@ static int __init mtd_oobtest_init(void)
 	for (i = 0; i < ebcnt - 1; ++i) {
 		int cnt = 2;
 		int pg;
-		size_t sz = mtd->ecclayout->oobavail;
+		size_t sz = mtd->oobavail;
 		if (bbt[i] || bbt[i + 1])
 			continue;
 		addr = (loff_t)(i + 1) * mtd->erasesize - mtd->writesize;
@@ -673,13 +673,12 @@ static int __init mtd_oobtest_init(void)
 	for (i = 0; i < ebcnt - 1; ++i) {
 		if (bbt[i] || bbt[i + 1])
 			continue;
-		prandom_bytes_state(&rnd_state, writebuf,
-					mtd->ecclayout->oobavail * 2);
+		prandom_bytes_state(&rnd_state, writebuf, mtd->oobavail * 2);
 		addr = (loff_t)(i + 1) * mtd->erasesize - mtd->writesize;
 		ops.mode      = MTD_OPS_AUTO_OOB;
 		ops.len       = 0;
 		ops.retlen    = 0;
-		ops.ooblen    = mtd->ecclayout->oobavail * 2;
+		ops.ooblen    = mtd->oobavail * 2;
 		ops.oobretlen = 0;
 		ops.ooboffs   = 0;
 		ops.datbuf    = NULL;
@@ -688,7 +687,7 @@ static int __init mtd_oobtest_init(void)
 		if (err)
 			goto out;
 		if (memcmpshow(addr, readbuf, writebuf,
-			       mtd->ecclayout->oobavail * 2)) {
+			       mtd->oobavail * 2)) {
 			pr_err("error: verify failed at %#llx\n",
 			       (long long)addr);
 			errcnt += 1;
diff --git a/drivers/staging/mt29f_spinand/mt29f_spinand.c b/drivers/staging/mt29f_spinand/mt29f_spinand.c
index 197d112..6728376 100644
--- a/drivers/staging/mt29f_spinand/mt29f_spinand.c
+++ b/drivers/staging/mt29f_spinand/mt29f_spinand.c
@@ -49,7 +49,6 @@ static struct nand_ecclayout spinand_oob_64 = {
 		17, 18, 19, 20, 21, 22,
 		33, 34, 35, 36, 37, 38,
 		49, 50, 51, 52, 53, 54, },
-	.oobavail = 32,
 	.oobfree = {
 		{.offset = 8,
 			.length = 8},
diff --git a/fs/jffs2/wbuf.c b/fs/jffs2/wbuf.c
index 5a3da3f..b25d28a 100644
--- a/fs/jffs2/wbuf.c
+++ b/fs/jffs2/wbuf.c
@@ -1183,22 +1183,20 @@ void jffs2_dirty_trigger(struct jffs2_sb_info *c)
 
 int jffs2_nand_flash_setup(struct jffs2_sb_info *c)
 {
-	struct nand_ecclayout *oinfo = c->mtd->ecclayout;
-
 	if (!c->mtd->oobsize)
 		return 0;
 
 	/* Cleanmarker is out-of-band, so inline size zero */
 	c->cleanmarker_size = 0;
 
-	if (!oinfo || oinfo->oobavail == 0) {
+	if (c->mtd->oobavail == 0) {
 		pr_err("inconsistent device description\n");
 		return -EINVAL;
 	}
 
 	jffs2_dbg(1, "using OOB on NAND\n");
 
-	c->oobavail = oinfo->oobavail;
+	c->oobavail = c->mtd->oobavail;
 
 	/* Initialise write buffer */
 	init_rwsem(&c->wbuf_sem);
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index cc84923..9cf13c4 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -105,7 +105,6 @@ struct mtd_oob_ops {
 struct nand_ecclayout {
 	__u32 eccbytes;
 	__u32 eccpos[MTD_MAX_ECCPOS_ENTRIES_LARGE];
-	__u32 oobavail;
 	struct nand_oobfree oobfree[MTD_MAX_OOBFREE_ENTRIES_LARGE];
 };
 
-- 
2.1.4
