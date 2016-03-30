Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2016 18:17:21 +0200 (CEST)
Received: from down.free-electrons.com ([37.187.137.238]:41723 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27025911AbcC3QPecyn0N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Mar 2016 18:15:34 +0200
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 893411822; Wed, 30 Mar 2016 18:15:23 +0200 (CEST)
Received: from localhost.localdomain (LMontsouris-657-1-184-87.w90-63.abo.wanadoo.fr [90.63.216.87])
        by mail.free-electrons.com (Postfix) with ESMTPSA id A4B821822;
        Wed, 30 Mar 2016 18:15:12 +0200 (CEST)
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
Subject: [PATCH v5 08/50] mtd: nand: omap2: use mtd_ooblayout_xxx() helpers where appropriate
Date:   Wed, 30 Mar 2016 18:14:23 +0200
Message-Id: <1459354505-32551-9-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52750
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
 drivers/mtd/nand/omap2.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 0749ca1..4ebf16b 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1495,9 +1495,8 @@ static int omap_elm_correct_data(struct mtd_info *mtd, u_char *data,
 static int omap_write_page_bch(struct mtd_info *mtd, struct nand_chip *chip,
 			       const uint8_t *buf, int oob_required, int page)
 {
-	int i;
+	int ret;
 	uint8_t *ecc_calc = chip->buffers->ecccalc;
-	uint32_t *eccpos = chip->ecc.layout->eccpos;
 
 	/* Enable GPMC ecc engine */
 	chip->ecc.hwctl(mtd, NAND_ECC_WRITE);
@@ -1508,8 +1507,10 @@ static int omap_write_page_bch(struct mtd_info *mtd, struct nand_chip *chip,
 	/* Update ecc vector from GPMC result registers */
 	chip->ecc.calculate(mtd, buf, &ecc_calc[0]);
 
-	for (i = 0; i < chip->ecc.total; i++)
-		chip->oob_poi[eccpos[i]] = ecc_calc[i];
+	ret = mtd_ooblayout_set_eccbytes(mtd, ecc_calc, chip->oob_poi, 0,
+					 chip->ecc.total);
+	if (ret)
+		return ret;
 
 	/* Write ecc vector to OOB area */
 	chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
@@ -1536,10 +1537,7 @@ static int omap_read_page_bch(struct mtd_info *mtd, struct nand_chip *chip,
 {
 	uint8_t *ecc_calc = chip->buffers->ecccalc;
 	uint8_t *ecc_code = chip->buffers->ecccode;
-	uint32_t *eccpos = chip->ecc.layout->eccpos;
-	uint8_t *oob = &chip->oob_poi[eccpos[0]];
-	uint32_t oob_pos = mtd->writesize + chip->ecc.layout->eccpos[0];
-	int stat;
+	int stat, ret;
 	unsigned int max_bitflips = 0;
 
 	/* Enable GPMC ecc engine */
@@ -1549,13 +1547,16 @@ static int omap_read_page_bch(struct mtd_info *mtd, struct nand_chip *chip,
 	chip->read_buf(mtd, buf, mtd->writesize);
 
 	/* Read oob bytes */
-	chip->cmdfunc(mtd, NAND_CMD_RNDOUT, oob_pos, -1);
-	chip->read_buf(mtd, oob, chip->ecc.total);
+	chip->cmdfunc(mtd, NAND_CMD_RNDOUT, mtd->writesize, -1);
+	chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
 
 	/* Calculate ecc bytes */
 	chip->ecc.calculate(mtd, buf, ecc_calc);
 
-	memcpy(ecc_code, &chip->oob_poi[eccpos[0]], chip->ecc.total);
+	ret = mtd_ooblayout_get_eccbytes(mtd, ecc_code, chip->oob_poi, 0,
+					 chip->ecc.total);
+	if (ret)
+		return ret;
 
 	stat = chip->ecc.correct(mtd, buf, ecc_code, ecc_calc);
 
-- 
2.5.0
