Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2016 18:21:19 +0200 (CEST)
Received: from down.free-electrons.com ([37.187.137.238]:41819 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27025925AbcC3QPmurGKN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Mar 2016 18:15:42 +0200
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 0E0A9185E; Wed, 30 Mar 2016 18:15:37 +0200 (CEST)
Received: from localhost.localdomain (LMontsouris-657-1-184-87.w90-63.abo.wanadoo.fr [90.63.216.87])
        by mail.free-electrons.com (Postfix) with ESMTPSA id E90BA1C;
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
Subject: [PATCH v5 19/50] mtd: nand: bch: switch to mtd_ooblayout_ops
Date:   Wed, 30 Mar 2016 18:14:34 +0200
Message-Id: <1459354505-32551-20-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52763
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

Replace the nand_ecclayout definition by the equivalent mtd_ooblayout_ops
definition.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/nand_bch.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/mtd/nand/nand_bch.c b/drivers/mtd/nand/nand_bch.c
index b3039de..e29e75f 100644
--- a/drivers/mtd/nand/nand_bch.c
+++ b/drivers/mtd/nand/nand_bch.c
@@ -32,13 +32,11 @@
 /**
  * struct nand_bch_control - private NAND BCH control structure
  * @bch:       BCH control structure
- * @ecclayout: private ecc layout for this BCH configuration
  * @errloc:    error location array
  * @eccmask:   XOR ecc mask, allows erased pages to be decoded as valid
  */
 struct nand_bch_control {
 	struct bch_control   *bch;
-	struct nand_ecclayout ecclayout;
 	unsigned int         *errloc;
 	unsigned char        *eccmask;
 };
@@ -124,7 +122,6 @@ struct nand_bch_control *nand_bch_init(struct mtd_info *mtd)
 {
 	struct nand_chip *nand = mtd_to_nand(mtd);
 	unsigned int m, t, eccsteps, i;
-	struct nand_ecclayout *layout = nand->ecc.layout;
 	struct nand_bch_control *nbc = NULL;
 	unsigned char *erased_page;
 	unsigned int eccsize = nand->ecc.size;
@@ -161,8 +158,17 @@ struct nand_bch_control *nand_bch_init(struct mtd_info *mtd)
 
 	eccsteps = mtd->writesize/eccsize;
 
+	/*
+	 * Rely on the default ecclayout to ooblayout wrapper provided by MTD
+	 * core if ecc.layout is not NULL.
+	 * FIXME: this should be removed when all callers have moved to the
+	 * mtd_ooblayout_ops approach.
+	 */
+	if (nand->ecc.layout)
+		mtd_set_ecclayout(mtd, nand->ecc.layout);
+
 	/* if no ecc placement scheme was provided, build one */
-	if (!layout) {
+	if (!mtd->ooblayout) {
 
 		/* handle large page devices only */
 		if (mtd->oobsize < 64) {
@@ -171,24 +177,7 @@ struct nand_bch_control *nand_bch_init(struct mtd_info *mtd)
 			goto fail;
 		}
 
-		layout = &nbc->ecclayout;
-		layout->eccbytes = eccsteps*eccbytes;
-
-		/* reserve 2 bytes for bad block marker */
-		if (layout->eccbytes+2 > mtd->oobsize) {
-			printk(KERN_WARNING "no suitable oob scheme available "
-			       "for oobsize %d eccbytes %u\n", mtd->oobsize,
-			       eccbytes);
-			goto fail;
-		}
-		/* put ecc bytes at oob tail */
-		for (i = 0; i < layout->eccbytes; i++)
-			layout->eccpos[i] = mtd->oobsize-layout->eccbytes+i;
-
-		layout->oobfree[0].offset = 2;
-		layout->oobfree[0].length = mtd->oobsize-2-layout->eccbytes;
-
-		nand->ecc.layout = layout;
+		mtd_set_ooblayout(mtd, &nand_ooblayout_lp_ops);
 	}
 
 	/* sanity checks */
-- 
2.5.0
