Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2016 18:16:37 +0200 (CEST)
Received: from down.free-electrons.com ([37.187.137.238]:41565 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27025906AbcC3QP3TzFUN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Mar 2016 18:15:29 +0200
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 6219D182D; Wed, 30 Mar 2016 18:15:19 +0200 (CEST)
Received: from localhost.localdomain (LMontsouris-657-1-184-87.w90-63.abo.wanadoo.fr [90.63.216.87])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 6B19222A;
        Wed, 30 Mar 2016 18:15:08 +0200 (CEST)
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
Subject: [PATCH v5 03/50] mtd: nand: core: use mtd_ooblayout_xxx() helpers where appropriate
Date:   Wed, 30 Mar 2016 18:14:18 +0200
Message-Id: <1459354505-32551-4-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52748
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

The mtd_ooblayout_xxx() helper functions have been added to avoid direct
accesses to the ecclayout field, and thus ease for future reworks.
Use these helpers in all places where the oobfree[] and eccpos[] arrays
where directly accessed.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/nand_base.c | 201 +++++++++++++++++++------------------------
 drivers/mtd/nand/nand_bch.c  |   3 +-
 2 files changed, 91 insertions(+), 113 deletions(-)

diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index c3733a1..36a58a0 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -1292,13 +1292,12 @@ static int nand_read_page_raw_syndrome(struct mtd_info *mtd,
 static int nand_read_page_swecc(struct mtd_info *mtd, struct nand_chip *chip,
 				uint8_t *buf, int oob_required, int page)
 {
-	int i, eccsize = chip->ecc.size;
+	int i, eccsize = chip->ecc.size, ret;
 	int eccbytes = chip->ecc.bytes;
 	int eccsteps = chip->ecc.steps;
 	uint8_t *p = buf;
 	uint8_t *ecc_calc = chip->buffers->ecccalc;
 	uint8_t *ecc_code = chip->buffers->ecccode;
-	uint32_t *eccpos = chip->ecc.layout->eccpos;
 	unsigned int max_bitflips = 0;
 
 	chip->ecc.read_page_raw(mtd, chip, buf, 1, page);
@@ -1306,8 +1305,10 @@ static int nand_read_page_swecc(struct mtd_info *mtd, struct nand_chip *chip,
 	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize)
 		chip->ecc.calculate(mtd, p, &ecc_calc[i]);
 
-	for (i = 0; i < chip->ecc.total; i++)
-		ecc_code[i] = chip->oob_poi[eccpos[i]];
+	ret = mtd_ooblayout_get_eccbytes(mtd, ecc_code, chip->oob_poi, 0,
+					 chip->ecc.total);
+	if (ret)
+		return ret;
 
 	eccsteps = chip->ecc.steps;
 	p = buf;
@@ -1339,14 +1340,14 @@ static int nand_read_subpage(struct mtd_info *mtd, struct nand_chip *chip,
 			uint32_t data_offs, uint32_t readlen, uint8_t *bufpoi,
 			int page)
 {
-	int start_step, end_step, num_steps;
-	uint32_t *eccpos = chip->ecc.layout->eccpos;
+	int start_step, end_step, num_steps, ret;
 	uint8_t *p;
 	int data_col_addr, i, gaps = 0;
 	int datafrag_len, eccfrag_len, aligned_len, aligned_pos;
 	int busw = (chip->options & NAND_BUSWIDTH_16) ? 2 : 1;
-	int index;
+	int index, section = 0;
 	unsigned int max_bitflips = 0;
+	struct mtd_oob_region oobregion = { };
 
 	/* Column address within the page aligned to ECC size (256bytes) */
 	start_step = data_offs / chip->ecc.size;
@@ -1374,12 +1375,13 @@ static int nand_read_subpage(struct mtd_info *mtd, struct nand_chip *chip,
 	 * The performance is faster if we position offsets according to
 	 * ecc.pos. Let's make sure that there are no gaps in ECC positions.
 	 */
-	for (i = 0; i < eccfrag_len - 1; i++) {
-		if (eccpos[i + index] + 1 != eccpos[i + index + 1]) {
-			gaps = 1;
-			break;
-		}
-	}
+	ret = mtd_ooblayout_find_eccregion(mtd, index, &section, &oobregion);
+	if (ret)
+		return ret;
+
+	if (oobregion.length < eccfrag_len)
+		gaps = 1;
+
 	if (gaps) {
 		chip->cmdfunc(mtd, NAND_CMD_RNDOUT, mtd->writesize, -1);
 		chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
@@ -1388,20 +1390,23 @@ static int nand_read_subpage(struct mtd_info *mtd, struct nand_chip *chip,
 		 * Send the command to read the particular ECC bytes take care
 		 * about buswidth alignment in read_buf.
 		 */
-		aligned_pos = eccpos[index] & ~(busw - 1);
+		aligned_pos = oobregion.offset & ~(busw - 1);
 		aligned_len = eccfrag_len;
-		if (eccpos[index] & (busw - 1))
+		if (oobregion.offset & (busw - 1))
 			aligned_len++;
-		if (eccpos[index + (num_steps * chip->ecc.bytes)] & (busw - 1))
+		if ((oobregion.offset + (num_steps * chip->ecc.bytes)) &
+		    (busw - 1))
 			aligned_len++;
 
 		chip->cmdfunc(mtd, NAND_CMD_RNDOUT,
-					mtd->writesize + aligned_pos, -1);
+			      mtd->writesize + aligned_pos, -1);
 		chip->read_buf(mtd, &chip->oob_poi[aligned_pos], aligned_len);
 	}
 
-	for (i = 0; i < eccfrag_len; i++)
-		chip->buffers->ecccode[i] = chip->oob_poi[eccpos[i + index]];
+	ret = mtd_ooblayout_get_eccbytes(mtd, chip->buffers->ecccode,
+					 chip->oob_poi, index, eccfrag_len);
+	if (ret)
+		return ret;
 
 	p = bufpoi + data_col_addr;
 	for (i = 0; i < eccfrag_len ; i += chip->ecc.bytes, p += chip->ecc.size) {
@@ -1442,13 +1447,12 @@ static int nand_read_subpage(struct mtd_info *mtd, struct nand_chip *chip,
 static int nand_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 				uint8_t *buf, int oob_required, int page)
 {
-	int i, eccsize = chip->ecc.size;
+	int i, eccsize = chip->ecc.size, ret;
 	int eccbytes = chip->ecc.bytes;
 	int eccsteps = chip->ecc.steps;
 	uint8_t *p = buf;
 	uint8_t *ecc_calc = chip->buffers->ecccalc;
 	uint8_t *ecc_code = chip->buffers->ecccode;
-	uint32_t *eccpos = chip->ecc.layout->eccpos;
 	unsigned int max_bitflips = 0;
 
 	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize) {
@@ -1458,8 +1462,10 @@ static int nand_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 	}
 	chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
 
-	for (i = 0; i < chip->ecc.total; i++)
-		ecc_code[i] = chip->oob_poi[eccpos[i]];
+	ret = mtd_ooblayout_get_eccbytes(mtd, ecc_code, chip->oob_poi, 0,
+					 chip->ecc.total);
+	if (ret)
+		return ret;
 
 	eccsteps = chip->ecc.steps;
 	p = buf;
@@ -1504,12 +1510,11 @@ static int nand_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 static int nand_read_page_hwecc_oob_first(struct mtd_info *mtd,
 	struct nand_chip *chip, uint8_t *buf, int oob_required, int page)
 {
-	int i, eccsize = chip->ecc.size;
+	int i, eccsize = chip->ecc.size, ret;
 	int eccbytes = chip->ecc.bytes;
 	int eccsteps = chip->ecc.steps;
 	uint8_t *p = buf;
 	uint8_t *ecc_code = chip->buffers->ecccode;
-	uint32_t *eccpos = chip->ecc.layout->eccpos;
 	uint8_t *ecc_calc = chip->buffers->ecccalc;
 	unsigned int max_bitflips = 0;
 
@@ -1518,8 +1523,10 @@ static int nand_read_page_hwecc_oob_first(struct mtd_info *mtd,
 	chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
 	chip->cmdfunc(mtd, NAND_CMD_READ0, 0, page);
 
-	for (i = 0; i < chip->ecc.total; i++)
-		ecc_code[i] = chip->oob_poi[eccpos[i]];
+	ret = mtd_ooblayout_get_eccbytes(mtd, ecc_code, chip->oob_poi, 0,
+					 chip->ecc.total);
+	if (ret)
+		return ret;
 
 	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize) {
 		int stat;
@@ -1620,14 +1627,17 @@ static int nand_read_page_syndrome(struct mtd_info *mtd, struct nand_chip *chip,
 
 /**
  * nand_transfer_oob - [INTERN] Transfer oob to client buffer
- * @chip: nand chip structure
+ * @mtd: mtd info structure
  * @oob: oob destination address
  * @ops: oob ops structure
  * @len: size of oob to transfer
  */
-static uint8_t *nand_transfer_oob(struct nand_chip *chip, uint8_t *oob,
+static uint8_t *nand_transfer_oob(struct mtd_info *mtd, uint8_t *oob,
 				  struct mtd_oob_ops *ops, size_t len)
 {
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	int ret;
+
 	switch (ops->mode) {
 
 	case MTD_OPS_PLACE_OOB:
@@ -1635,31 +1645,12 @@ static uint8_t *nand_transfer_oob(struct nand_chip *chip, uint8_t *oob,
 		memcpy(oob, chip->oob_poi + ops->ooboffs, len);
 		return oob + len;
 
-	case MTD_OPS_AUTO_OOB: {
-		struct nand_oobfree *free = chip->ecc.layout->oobfree;
-		uint32_t boffs = 0, roffs = ops->ooboffs;
-		size_t bytes = 0;
-
-		for (; free->length && len; free++, len -= bytes) {
-			/* Read request not from offset 0? */
-			if (unlikely(roffs)) {
-				if (roffs >= free->length) {
-					roffs -= free->length;
-					continue;
-				}
-				boffs = free->offset + roffs;
-				bytes = min_t(size_t, len,
-					      (free->length - roffs));
-				roffs = 0;
-			} else {
-				bytes = min_t(size_t, len, free->length);
-				boffs = free->offset;
-			}
-			memcpy(oob, chip->oob_poi + boffs, bytes);
-			oob += bytes;
-		}
-		return oob;
-	}
+	case MTD_OPS_AUTO_OOB:
+		ret = mtd_ooblayout_get_databytes(mtd, oob, chip->oob_poi,
+						  ops->ooboffs, len);
+		BUG_ON(ret);
+		return oob + len;
+
 	default:
 		BUG();
 	}
@@ -1793,7 +1784,7 @@ read_retry:
 				int toread = min(oobreadlen, max_oobsize);
 
 				if (toread) {
-					oob = nand_transfer_oob(chip,
+					oob = nand_transfer_oob(mtd,
 						oob, ops, toread);
 					oobreadlen -= toread;
 				}
@@ -2091,7 +2082,7 @@ static int nand_do_read_oob(struct mtd_info *mtd, loff_t from,
 			break;
 
 		len = min(len, readlen);
-		buf = nand_transfer_oob(chip, buf, ops, len);
+		buf = nand_transfer_oob(mtd, buf, ops, len);
 
 		if (chip->options & NAND_NEED_READRDY) {
 			/* Apply delay or wait for ready/busy pin */
@@ -2250,19 +2241,20 @@ static int nand_write_page_swecc(struct mtd_info *mtd, struct nand_chip *chip,
 				 const uint8_t *buf, int oob_required,
 				 int page)
 {
-	int i, eccsize = chip->ecc.size;
+	int i, eccsize = chip->ecc.size, ret;
 	int eccbytes = chip->ecc.bytes;
 	int eccsteps = chip->ecc.steps;
 	uint8_t *ecc_calc = chip->buffers->ecccalc;
 	const uint8_t *p = buf;
-	uint32_t *eccpos = chip->ecc.layout->eccpos;
 
 	/* Software ECC calculation */
 	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize)
 		chip->ecc.calculate(mtd, p, &ecc_calc[i]);
 
-	for (i = 0; i < chip->ecc.total; i++)
-		chip->oob_poi[eccpos[i]] = ecc_calc[i];
+	ret = mtd_ooblayout_set_eccbytes(mtd, ecc_calc, chip->oob_poi, 0,
+					 chip->ecc.total);
+	if (ret)
+		return ret;
 
 	return chip->ecc.write_page_raw(mtd, chip, buf, 1, page);
 }
@@ -2279,12 +2271,11 @@ static int nand_write_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 				  const uint8_t *buf, int oob_required,
 				  int page)
 {
-	int i, eccsize = chip->ecc.size;
+	int i, eccsize = chip->ecc.size, ret;
 	int eccbytes = chip->ecc.bytes;
 	int eccsteps = chip->ecc.steps;
 	uint8_t *ecc_calc = chip->buffers->ecccalc;
 	const uint8_t *p = buf;
-	uint32_t *eccpos = chip->ecc.layout->eccpos;
 
 	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize) {
 		chip->ecc.hwctl(mtd, NAND_ECC_WRITE);
@@ -2292,8 +2283,10 @@ static int nand_write_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 		chip->ecc.calculate(mtd, p, &ecc_calc[i]);
 	}
 
-	for (i = 0; i < chip->ecc.total; i++)
-		chip->oob_poi[eccpos[i]] = ecc_calc[i];
+	ret = mtd_ooblayout_set_eccbytes(mtd, ecc_calc, chip->oob_poi, 0,
+					 chip->ecc.total);
+	if (ret)
+		return ret;
 
 	chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
 
@@ -2321,11 +2314,10 @@ static int nand_write_subpage_hwecc(struct mtd_info *mtd,
 	int ecc_size      = chip->ecc.size;
 	int ecc_bytes     = chip->ecc.bytes;
 	int ecc_steps     = chip->ecc.steps;
-	uint32_t *eccpos  = chip->ecc.layout->eccpos;
 	uint32_t start_step = offset / ecc_size;
 	uint32_t end_step   = (offset + data_len - 1) / ecc_size;
 	int oob_bytes       = mtd->oobsize / ecc_steps;
-	int step, i;
+	int step, ret;
 
 	for (step = 0; step < ecc_steps; step++) {
 		/* configure controller for WRITE access */
@@ -2353,8 +2345,10 @@ static int nand_write_subpage_hwecc(struct mtd_info *mtd,
 	/* copy calculated ECC for whole page to chip->buffer->oob */
 	/* this include masked-value(0xFF) for unwritten subpages */
 	ecc_calc = chip->buffers->ecccalc;
-	for (i = 0; i < chip->ecc.total; i++)
-		chip->oob_poi[eccpos[i]] = ecc_calc[i];
+	ret = mtd_ooblayout_set_eccbytes(mtd, ecc_calc, chip->oob_poi, 0,
+					 chip->ecc.total);
+	if (ret)
+		return ret;
 
 	/* write OOB buffer to NAND device */
 	chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
@@ -2491,6 +2485,7 @@ static uint8_t *nand_fill_oob(struct mtd_info *mtd, uint8_t *oob, size_t len,
 			      struct mtd_oob_ops *ops)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
+	int ret;
 
 	/*
 	 * Initialise to all 0xFF, to avoid the possibility of left over OOB
@@ -2505,31 +2500,12 @@ static uint8_t *nand_fill_oob(struct mtd_info *mtd, uint8_t *oob, size_t len,
 		memcpy(chip->oob_poi + ops->ooboffs, oob, len);
 		return oob + len;
 
-	case MTD_OPS_AUTO_OOB: {
-		struct nand_oobfree *free = chip->ecc.layout->oobfree;
-		uint32_t boffs = 0, woffs = ops->ooboffs;
-		size_t bytes = 0;
-
-		for (; free->length && len; free++, len -= bytes) {
-			/* Write request not from offset 0? */
-			if (unlikely(woffs)) {
-				if (woffs >= free->length) {
-					woffs -= free->length;
-					continue;
-				}
-				boffs = free->offset + woffs;
-				bytes = min_t(size_t, len,
-					      (free->length - woffs));
-				woffs = 0;
-			} else {
-				bytes = min_t(size_t, len, free->length);
-				boffs = free->offset;
-			}
-			memcpy(chip->oob_poi + boffs, oob, bytes);
-			oob += bytes;
-		}
-		return oob;
-	}
+	case MTD_OPS_AUTO_OOB:
+		ret = mtd_ooblayout_set_databytes(mtd, oob, chip->oob_poi,
+						  ops->ooboffs, len);
+		BUG_ON(ret);
+		return oob + len;
+
 	default:
 		BUG();
 	}
@@ -4116,10 +4092,10 @@ static bool nand_ecc_strength_good(struct mtd_info *mtd)
  */
 int nand_scan_tail(struct mtd_info *mtd)
 {
-	int i;
 	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	struct nand_buffers *nbuf;
+	int ret;
 
 	/* New bad blocks should be marked in OOB, flash-based BBT, or both */
 	BUG_ON((chip->bbt_options & NAND_BBT_NO_OOB_BBM) &&
@@ -4311,20 +4287,10 @@ int nand_scan_tail(struct mtd_info *mtd)
 	if (!ecc->write_oob_raw)
 		ecc->write_oob_raw = ecc->write_oob;
 
-	/*
-	 * The number of bytes available for a client to place data into
-	 * the out of band area.
-	 */
-	mtd->oobavail = 0;
-	if (ecc->layout) {
-		for (i = 0; ecc->layout->oobfree[i].length; i++)
-			mtd->oobavail += ecc->layout->oobfree[i].length;
-	}
-
-	/* ECC sanity check: warn if it's too weak */
-	if (!nand_ecc_strength_good(mtd))
-		pr_warn("WARNING: %s: the ECC used on your system is too weak compared to the one required by the NAND chip\n",
-			mtd->name);
+	/* propagate ecc info to mtd_info */
+	mtd->ecclayout = ecc->layout;
+	mtd->ecc_strength = ecc->strength;
+	mtd->ecc_step_size = ecc->size;
 
 	/*
 	 * Set the number of read / write steps for one page depending on ECC
@@ -4337,6 +4303,21 @@ int nand_scan_tail(struct mtd_info *mtd)
 	}
 	ecc->total = ecc->steps * ecc->bytes;
 
+	/*
+	 * The number of bytes available for a client to place data into
+	 * the out of band area.
+	 */
+	ret = mtd_ooblayout_count_freebytes(mtd);
+	if (ret < 0)
+		ret = 0;
+
+	mtd->oobavail = ret;
+
+	/* ECC sanity check: warn if it's too weak */
+	if (!nand_ecc_strength_good(mtd))
+		pr_warn("WARNING: %s: the ECC used on your system is too weak compared to the one required by the NAND chip\n",
+			mtd->name);
+
 	/* Allow subpage writes up to ecc.steps. Not possible for MLC flash */
 	if (!(chip->options & NAND_NO_SUBPAGE_WRITE) && nand_is_slc(chip)) {
 		switch (ecc->steps) {
@@ -4393,10 +4374,6 @@ int nand_scan_tail(struct mtd_info *mtd)
 	mtd->_block_markbad = nand_block_markbad;
 	mtd->writebufsize = mtd->writesize;
 
-	/* propagate ecc info to mtd_info */
-	mtd->ecclayout = ecc->layout;
-	mtd->ecc_strength = ecc->strength;
-	mtd->ecc_step_size = ecc->size;
 	/*
 	 * Initialize bitflip_threshold to its default prior scan_bbt() call.
 	 * scan_bbt() might invoke mtd_read(), thus bitflip_threshold must be
diff --git a/drivers/mtd/nand/nand_bch.c b/drivers/mtd/nand/nand_bch.c
index b585bae..b3039de 100644
--- a/drivers/mtd/nand/nand_bch.c
+++ b/drivers/mtd/nand/nand_bch.c
@@ -196,7 +196,8 @@ struct nand_bch_control *nand_bch_init(struct mtd_info *mtd)
 		printk(KERN_WARNING "eccsize %u is too large\n", eccsize);
 		goto fail;
 	}
-	if (layout->eccbytes != (eccsteps*eccbytes)) {
+
+	if (mtd_ooblayout_count_eccbytes(mtd) != (eccsteps*eccbytes)) {
 		printk(KERN_WARNING "invalid ecc layout\n");
 		goto fail;
 	}
-- 
2.5.0
