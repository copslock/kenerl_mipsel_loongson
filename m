Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2016 18:15:48 +0200 (CEST)
Received: from down.free-electrons.com ([37.187.137.238]:41563 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27025902AbcC3QP3Tnk5N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Mar 2016 18:15:29 +0200
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 37847182F; Wed, 30 Mar 2016 18:15:20 +0200 (CEST)
Received: from localhost.localdomain (LMontsouris-657-1-184-87.w90-63.abo.wanadoo.fr [90.63.216.87])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 51E94254;
        Wed, 30 Mar 2016 18:15:09 +0200 (CEST)
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
Subject: [PATCH v5 04/50] mtd: nand: atmel: use mtd_ooblayout_xxx() helpers where appropriate
Date:   Wed, 30 Mar 2016 18:14:19 +0200
Message-Id: <1459354505-32551-5-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52745
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
 drivers/mtd/nand/atmel_nand.c | 48 ++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 0b5da72..321d331 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -836,13 +836,16 @@ static void pmecc_correct_data(struct mtd_info *mtd, uint8_t *buf, uint8_t *ecc,
 			dev_dbg(host->dev, "Bit flip in data area, byte_pos: %d, bit_pos: %d, 0x%02x -> 0x%02x\n",
 				pos, bit_pos, err_byte, *(buf + byte_pos));
 		} else {
+			struct mtd_oob_region oobregion;
+
 			/* Bit flip in OOB area */
 			tmp = sector_num * nand_chip->ecc.bytes
 					+ (byte_pos - sector_size);
 			err_byte = ecc[tmp];
 			ecc[tmp] ^= (1 << bit_pos);
 
-			pos = tmp + nand_chip->ecc.layout->eccpos[0];
+			mtd_ooblayout_ecc(mtd, 0, &oobregion);
+			pos = tmp + oobregion.offset;
 			dev_dbg(host->dev, "Bit flip in OOB, oob_byte_pos: %d, bit_pos: %d, 0x%02x -> 0x%02x\n",
 				pos, bit_pos, err_byte, ecc[tmp]);
 		}
@@ -934,7 +937,6 @@ static int atmel_nand_pmecc_read_page(struct mtd_info *mtd,
 	struct atmel_nand_host *host = nand_get_controller_data(chip);
 	int eccsize = chip->ecc.size * chip->ecc.steps;
 	uint8_t *oob = chip->oob_poi;
-	uint32_t *eccpos = chip->ecc.layout->eccpos;
 	uint32_t stat;
 	unsigned long end_time;
 	int bitflips = 0;
@@ -956,7 +958,11 @@ static int atmel_nand_pmecc_read_page(struct mtd_info *mtd,
 
 	stat = pmecc_readl_relaxed(host->ecc, ISR);
 	if (stat != 0) {
-		bitflips = pmecc_correction(mtd, stat, buf, &oob[eccpos[0]]);
+		struct mtd_oob_region oobregion;
+
+		mtd_ooblayout_ecc(mtd, 0, &oobregion);
+		bitflips = pmecc_correction(mtd, stat, buf,
+					    &oob[oobregion.offset]);
 		if (bitflips < 0)
 			/* uncorrectable errors */
 			return 0;
@@ -970,8 +976,8 @@ static int atmel_nand_pmecc_write_page(struct mtd_info *mtd,
 		int page)
 {
 	struct atmel_nand_host *host = nand_get_controller_data(chip);
-	uint32_t *eccpos = chip->ecc.layout->eccpos;
-	int i, j;
+	struct mtd_oob_region oobregion = { };
+	int i, j, section = 0;
 	unsigned long end_time;
 
 	if (!host->nfc || !host->nfc->write_by_sram) {
@@ -990,11 +996,12 @@ static int atmel_nand_pmecc_write_page(struct mtd_info *mtd,
 
 	for (i = 0; i < chip->ecc.steps; i++) {
 		for (j = 0; j < chip->ecc.bytes; j++) {
-			int pos;
+			if (!oobregion.length)
+				mtd_ooblayout_ecc(mtd, section++, &oobregion);
 
-			pos = i * chip->ecc.bytes + j;
-			chip->oob_poi[eccpos[pos]] =
+			chip->oob_poi[oobregion.offset++] =
 				pmecc_readb_ecc_relaxed(host->ecc, i, j);
+			oobregion.length--;
 		}
 	}
 	chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
@@ -1008,6 +1015,7 @@ static void atmel_pmecc_core_init(struct mtd_info *mtd)
 	struct atmel_nand_host *host = nand_get_controller_data(nand_chip);
 	uint32_t val = 0;
 	struct nand_ecclayout *ecc_layout;
+	struct mtd_oob_region oobregion;
 
 	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_RST);
 	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DISABLE);
@@ -1059,9 +1067,10 @@ static void atmel_pmecc_core_init(struct mtd_info *mtd)
 
 	ecc_layout = nand_chip->ecc.layout;
 	pmecc_writel(host->ecc, SAREA, mtd->oobsize - 1);
-	pmecc_writel(host->ecc, SADDR, ecc_layout->eccpos[0]);
+	mtd_ooblayout_ecc(mtd, 0, &oobregion);
+	pmecc_writel(host->ecc, SADDR, oobregion.offset);
 	pmecc_writel(host->ecc, EADDR,
-			ecc_layout->eccpos[ecc_layout->eccbytes - 1]);
+		     oobregion.offset + ecc_layout->eccbytes - 1);
 	/* See datasheet about PMECC Clock Control Register */
 	pmecc_writel(host->ecc, CLK, 2);
 	pmecc_writel(host->ecc, IDR, 0xff);
@@ -1362,12 +1371,12 @@ static int atmel_nand_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 {
 	int eccsize = chip->ecc.size;
 	int eccbytes = chip->ecc.bytes;
-	uint32_t *eccpos = chip->ecc.layout->eccpos;
 	uint8_t *p = buf;
 	uint8_t *oob = chip->oob_poi;
 	uint8_t *ecc_pos;
 	int stat;
 	unsigned int max_bitflips = 0;
+	struct mtd_oob_region oobregion = {};
 
 	/*
 	 * Errata: ALE is incorrectly wired up to the ECC controller
@@ -1385,19 +1394,20 @@ static int atmel_nand_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 	chip->read_buf(mtd, p, eccsize);
 
 	/* move to ECC position if needed */
-	if (eccpos[0] != 0) {
-		/* This only works on large pages
-		 * because the ECC controller waits for
-		 * NAND_CMD_RNDOUTSTART after the
-		 * NAND_CMD_RNDOUT.
-		 * anyway, for small pages, the eccpos[0] == 0
+	mtd_ooblayout_ecc(mtd, 0, &oobregion);
+	if (oobregion.offset != 0) {
+		/*
+		 * This only works on large pages because the ECC controller
+		 * waits for NAND_CMD_RNDOUTSTART after the NAND_CMD_RNDOUT.
+		 * Anyway, for small pages, the first ECC byte is at offset
+		 * 0 in the OOB area.
 		 */
 		chip->cmdfunc(mtd, NAND_CMD_RNDOUT,
-				mtd->writesize + eccpos[0], -1);
+			      mtd->writesize + oobregion.offset, -1);
 	}
 
 	/* the ECC controller needs to read the ECC just after the data */
-	ecc_pos = oob + eccpos[0];
+	ecc_pos = oob + oobregion.offset;
 	chip->read_buf(mtd, ecc_pos, eccbytes);
 
 	/* check if there's an error */
-- 
2.5.0
