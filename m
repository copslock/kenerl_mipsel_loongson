Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2016 18:24:25 +0200 (CEST)
Received: from down.free-electrons.com ([37.187.137.238]:42136 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27025936AbcC3QQFlUX8N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Mar 2016 18:16:05 +0200
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id CF5CE1CC4; Wed, 30 Mar 2016 18:15:59 +0200 (CEST)
Received: from localhost.localdomain (LMontsouris-657-1-184-87.w90-63.abo.wanadoo.fr [90.63.216.87])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 4EFB9184A;
        Wed, 30 Mar 2016 18:15:30 +0200 (CEST)
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
Subject: [PATCH v5 29/50] mtd: nand: docg4: switch to mtd_ooblayout_ops
Date:   Wed, 30 Mar 2016 18:14:44 +0200
Message-Id: <1459354505-32551-30-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52773
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
 drivers/mtd/nand/docg4.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/docg4.c b/drivers/mtd/nand/docg4.c
index d86a60e..4731699 100644
--- a/drivers/mtd/nand/docg4.c
+++ b/drivers/mtd/nand/docg4.c
@@ -222,10 +222,33 @@ struct docg4_priv {
  * Bytes 8 - 14 are hw-generated ecc covering entire page + oob bytes 0 - 14.
  * Byte 15 (the last) is used by the driver as a "page written" flag.
  */
-static struct nand_ecclayout docg4_oobinfo = {
-	.eccbytes = 9,
-	.eccpos = {7, 8, 9, 10, 11, 12, 13, 14, 15},
-	.oobfree = { {.offset = 2, .length = 5} }
+static int docg4_ooblayout_ecc(struct mtd_info *mtd, int section,
+			       struct mtd_oob_region *oobregion)
+{
+	if (section)
+		return -ERANGE;
+
+	oobregion->offset = 7;
+	oobregion->length = 9;
+
+	return 0;
+}
+
+static int docg4_ooblayout_free(struct mtd_info *mtd, int section,
+				struct mtd_oob_region *oobregion)
+{
+	if (section)
+		return -ERANGE;
+
+	oobregion->offset = 2;
+	oobregion->length = 5;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops docg4_ooblayout_ops = {
+	.ecc = docg4_ooblayout_ecc,
+	.free = docg4_ooblayout_free,
 };
 
 /*
@@ -1209,6 +1232,7 @@ static void __init init_mtd_structs(struct mtd_info *mtd)
 	mtd->writesize = DOCG4_PAGE_SIZE;
 	mtd->erasesize = DOCG4_BLOCK_SIZE;
 	mtd->oobsize = DOCG4_OOB_SIZE;
+	mtd_set_ooblayout(mtd, &docg4_ooblayout_ops);
 	nand->chipsize = DOCG4_CHIP_SIZE;
 	nand->chip_shift = DOCG4_CHIP_SHIFT;
 	nand->bbt_erase_shift = nand->phys_erase_shift = DOCG4_ERASE_SHIFT;
@@ -1217,7 +1241,6 @@ static void __init init_mtd_structs(struct mtd_info *mtd)
 	nand->pagemask = 0x3ffff;
 	nand->badblockpos = NAND_LARGE_BADBLOCK_POS;
 	nand->badblockbits = 8;
-	nand->ecc.layout = &docg4_oobinfo;
 	nand->ecc.mode = NAND_ECC_HW_SYNDROME;
 	nand->ecc.size = DOCG4_PAGE_SIZE;
 	nand->ecc.prepad = 8;
-- 
2.5.0
