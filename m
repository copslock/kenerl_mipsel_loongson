Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2016 18:21:54 +0200 (CEST)
Received: from down.free-electrons.com ([37.187.137.238]:41880 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27025927AbcC3QPnvoI0N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Mar 2016 18:15:43 +0200
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 095851861; Wed, 30 Mar 2016 18:15:37 +0200 (CEST)
Received: from localhost.localdomain (LMontsouris-657-1-184-87.w90-63.abo.wanadoo.fr [90.63.216.87])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 8E0451828;
        Wed, 30 Mar 2016 18:15:23 +0200 (CEST)
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
Subject: [PATCH v5 21/50] mtd: nand: jz4740: switch to mtd_ooblayout_ops
Date:   Wed, 30 Mar 2016 18:14:36 +0200
Message-Id: <1459354505-32551-22-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52765
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
 arch/mips/include/asm/mach-jz4740/jz4740_nand.h |  2 +-
 arch/mips/jz4740/board-qi_lb60.c                | 87 +++++++++++++++----------
 drivers/mtd/nand/jz4740_nand.c                  |  2 +-
 3 files changed, 53 insertions(+), 38 deletions(-)

diff --git a/arch/mips/include/asm/mach-jz4740/jz4740_nand.h b/arch/mips/include/asm/mach-jz4740/jz4740_nand.h
index 398733e..7f7b0fc 100644
--- a/arch/mips/include/asm/mach-jz4740/jz4740_nand.h
+++ b/arch/mips/include/asm/mach-jz4740/jz4740_nand.h
@@ -27,7 +27,7 @@ struct jz_nand_platform_data {
 
 	unsigned char banks[JZ_NAND_NUM_BANKS];
 
-	void (*ident_callback)(struct platform_device *, struct nand_chip *,
+	void (*ident_callback)(struct platform_device *, struct mtd_info *,
 				struct mtd_partition **, int *num_partitions);
 };
 
diff --git a/arch/mips/jz4740/board-qi_lb60.c b/arch/mips/jz4740/board-qi_lb60.c
index 934b15b..a1c1afb 100644
--- a/arch/mips/jz4740/board-qi_lb60.c
+++ b/arch/mips/jz4740/board-qi_lb60.c
@@ -50,20 +50,6 @@ static bool is_avt2;
 #define QI_LB60_GPIO_KEYIN8		JZ_GPIO_PORTD(26)
 
 /* NAND */
-static struct nand_ecclayout qi_lb60_ecclayout_1gb = {
-	.eccbytes = 36,
-	.eccpos = {
-		6,  7,	8,  9,	10, 11, 12, 13,
-		14, 15, 16, 17, 18, 19, 20, 21,
-		22, 23, 24, 25, 26, 27, 28, 29,
-		30, 31, 32, 33, 34, 35, 36, 37,
-		38, 39, 40, 41
-	},
-	.oobfree = {
-		{ .offset = 2, .length = 4 },
-		{ .offset = 42, .length = 22 }
-	},
-};
 
 /* Early prototypes of the QI LB60 had only 1GB of NAND.
  * In order to support these devices as well the partition and ecc layout is
@@ -86,25 +72,6 @@ static struct mtd_partition qi_lb60_partitions_1gb[] = {
 	},
 };
 
-static struct nand_ecclayout qi_lb60_ecclayout_2gb = {
-	.eccbytes = 72,
-	.eccpos = {
-		12, 13, 14, 15, 16, 17, 18, 19,
-		20, 21, 22, 23, 24, 25, 26, 27,
-		28, 29, 30, 31, 32, 33, 34, 35,
-		36, 37, 38, 39, 40, 41, 42, 43,
-		44, 45, 46, 47, 48, 49, 50, 51,
-		52, 53, 54, 55, 56, 57, 58, 59,
-		60, 61, 62, 63, 64, 65, 66, 67,
-		68, 69, 70, 71, 72, 73, 74, 75,
-		76, 77, 78, 79, 80, 81, 82, 83
-	},
-	.oobfree = {
-		{ .offset = 2, .length = 10 },
-		{ .offset = 84, .length = 44 },
-	},
-};
-
 static struct mtd_partition qi_lb60_partitions_2gb[] = {
 	{
 		.name = "NAND BOOT partition",
@@ -123,19 +90,67 @@ static struct mtd_partition qi_lb60_partitions_2gb[] = {
 	},
 };
 
+static int qi_lb60_ooblayout_ecc(struct mtd_info *mtd, int section,
+				 struct mtd_oob_region *oobregion)
+{
+	if (section)
+		return -ERANGE;
+
+	oobregion->length = 36;
+	oobregion->offset = 6;
+
+	if (mtd->oobsize == 128) {
+		oobregion->length *= 2;
+		oobregion->offset *= 2;
+	}
+
+	return 0;
+}
+
+static int qi_lb60_ooblayout_free(struct mtd_info *mtd, int section,
+				  struct mtd_oob_region *oobregion)
+{
+	int eccbytes = 36, eccoff = 6;
+
+	if (section > 1)
+		return -ERANGE;
+
+	if (mtd->oobsize == 128) {
+		eccbytes *= 2;
+		eccoff *= 2;
+	}
+
+	if (!section) {
+		oobregion->offset = 2;
+		oobregion->length = eccoff - 2;
+	} else {
+		oobregion->offset = eccoff + eccbytes;
+		oobregion->length = mtd->oobsize - oobregion->offset;
+	}
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops qi_lb60_ooblayout_ops = {
+	.ecc = qi_lb60_ooblayout_ecc,
+	.free = qi_lb60_ooblayout_free,
+};
+
 static void qi_lb60_nand_ident(struct platform_device *pdev,
-		struct nand_chip *chip, struct mtd_partition **partitions,
+		struct mtd_info *mtd, struct mtd_partition **partitions,
 		int *num_partitions)
 {
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
 	if (chip->page_shift == 12) {
-		chip->ecc.layout = &qi_lb60_ecclayout_2gb;
 		*partitions = qi_lb60_partitions_2gb;
 		*num_partitions = ARRAY_SIZE(qi_lb60_partitions_2gb);
 	} else {
-		chip->ecc.layout = &qi_lb60_ecclayout_1gb;
 		*partitions = qi_lb60_partitions_1gb;
 		*num_partitions = ARRAY_SIZE(qi_lb60_partitions_1gb);
 	}
+
+	mtd_set_ooblayout(mtd, &qi_lb60_ooblayout_ops);
 }
 
 static struct jz_nand_platform_data qi_lb60_nand_pdata = {
diff --git a/drivers/mtd/nand/jz4740_nand.c b/drivers/mtd/nand/jz4740_nand.c
index 673ceb2..df74408 100644
--- a/drivers/mtd/nand/jz4740_nand.c
+++ b/drivers/mtd/nand/jz4740_nand.c
@@ -476,7 +476,7 @@ static int jz_nand_probe(struct platform_device *pdev)
 	}
 
 	if (pdata && pdata->ident_callback) {
-		pdata->ident_callback(pdev, chip, &pdata->partitions,
+		pdata->ident_callback(pdev, mtd, &pdata->partitions,
 					&pdata->num_partitions);
 	}
 
-- 
2.5.0
