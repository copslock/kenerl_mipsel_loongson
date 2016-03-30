Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2016 18:23:51 +0200 (CEST)
Received: from down.free-electrons.com ([37.187.137.238]:42049 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27025935AbcC3QPzb5lqN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Mar 2016 18:15:55 +0200
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id B7DF51CBD; Wed, 30 Mar 2016 18:15:49 +0200 (CEST)
Received: from localhost.localdomain (LMontsouris-657-1-184-87.w90-63.abo.wanadoo.fr [90.63.216.87])
        by mail.free-electrons.com (Postfix) with ESMTPSA id A59C0141;
        Wed, 30 Mar 2016 18:15:28 +0200 (CEST)
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
Subject: [PATCH v5 27/50] mtd: nand: denali: switch to mtd_ooblayout_ops
Date:   Wed, 30 Mar 2016 18:14:42 +0200
Message-Id: <1459354505-32551-28-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52771
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
 drivers/mtd/nand/denali.c | 50 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/drivers/mtd/nand/denali.c b/drivers/mtd/nand/denali.c
index 30bf5f6..0476ae8 100644
--- a/drivers/mtd/nand/denali.c
+++ b/drivers/mtd/nand/denali.c
@@ -1374,13 +1374,41 @@ static void denali_hw_init(struct denali_nand_info *denali)
  * correction
  */
 #define ECC_8BITS	14
-static struct nand_ecclayout nand_8bit_oob = {
-	.eccbytes = 14,
-};
-
 #define ECC_15BITS	26
-static struct nand_ecclayout nand_15bit_oob = {
-	.eccbytes = 26,
+
+static int denali_ooblayout_ecc(struct mtd_info *mtd, int section,
+				struct mtd_oob_region *oobregion)
+{
+	struct denali_nand_info *denali = mtd_to_denali(mtd);
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	if (section)
+		return -ERANGE;
+
+	oobregion->offset = denali->bbtskipbytes;
+	oobregion->length = chip->ecc.total;
+
+	return 0;
+}
+
+static int denali_ooblayout_free(struct mtd_info *mtd, int section,
+				 struct mtd_oob_region *oobregion)
+{
+	struct denali_nand_info *denali = mtd_to_denali(mtd);
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	if (section)
+		return -ERANGE;
+
+	oobregion->offset = chip->ecc.total + denali->bbtskipbytes;
+	oobregion->length = mtd->oobsize - oobregion->offset;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops denali_ooblayout_ops = {
+	.ecc = denali_ooblayout_ecc,
+	.free = denali_ooblayout_free,
 };
 
 static uint8_t bbt_pattern[] = {'B', 'b', 't', '0' };
@@ -1561,7 +1589,6 @@ int denali_init(struct denali_nand_info *denali)
 			ECC_SECTOR_SIZE)))) {
 		/* if MLC OOB size is large enough, use 15bit ECC*/
 		denali->nand.ecc.strength = 15;
-		denali->nand.ecc.layout = &nand_15bit_oob;
 		denali->nand.ecc.bytes = ECC_15BITS;
 		iowrite32(15, denali->flash_reg + ECC_CORRECTION);
 	} else if (mtd->oobsize < (denali->bbtskipbytes +
@@ -1571,20 +1598,13 @@ int denali_init(struct denali_nand_info *denali)
 		goto failed_req_irq;
 	} else {
 		denali->nand.ecc.strength = 8;
-		denali->nand.ecc.layout = &nand_8bit_oob;
 		denali->nand.ecc.bytes = ECC_8BITS;
 		iowrite32(8, denali->flash_reg + ECC_CORRECTION);
 	}
 
+	mtd_set_ooblayout(mtd, &denali_ooblayout_ops);
 	denali->nand.ecc.bytes *= denali->devnum;
 	denali->nand.ecc.strength *= denali->devnum;
-	denali->nand.ecc.layout->eccbytes *=
-		mtd->writesize / ECC_SECTOR_SIZE;
-	denali->nand.ecc.layout->oobfree[0].offset =
-		denali->bbtskipbytes + denali->nand.ecc.layout->eccbytes;
-	denali->nand.ecc.layout->oobfree[0].length =
-		mtd->oobsize - denali->nand.ecc.layout->eccbytes -
-		denali->bbtskipbytes;
 
 	/*
 	 * Let driver know the total blocks number and how many blocks
-- 
2.5.0
