Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2016 18:30:19 +0200 (CEST)
Received: from down.free-electrons.com ([37.187.137.238]:42725 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27014463AbcC3QQziZ3DN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Mar 2016 18:16:55 +0200
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id CBE191852; Wed, 30 Mar 2016 18:16:49 +0200 (CEST)
Received: from localhost.localdomain (LMontsouris-657-1-184-87.w90-63.abo.wanadoo.fr [90.63.216.87])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 054C3187D;
        Wed, 30 Mar 2016 18:15:47 +0200 (CEST)
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
Subject: [PATCH v5 48/50] staging: mt29f_spinand: switch to mtd_ooblayout_ops
Date:   Wed, 30 Mar 2016 18:15:03 +0200
Message-Id: <1459354505-32551-49-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52793
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
 drivers/staging/mt29f_spinand/mt29f_spinand.c | 48 +++++++++++++++++----------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/mt29f_spinand/mt29f_spinand.c b/drivers/staging/mt29f_spinand/mt29f_spinand.c
index 163f21a..f503699 100644
--- a/drivers/staging/mt29f_spinand/mt29f_spinand.c
+++ b/drivers/staging/mt29f_spinand/mt29f_spinand.c
@@ -42,23 +42,33 @@ static inline struct spinand_state *mtd_to_state(struct mtd_info *mtd)
 static int enable_hw_ecc;
 static int enable_read_hw_ecc;
 
-static struct nand_ecclayout spinand_oob_64 = {
-	.eccbytes = 24,
-	.eccpos = {
-		1, 2, 3, 4, 5, 6,
-		17, 18, 19, 20, 21, 22,
-		33, 34, 35, 36, 37, 38,
-		49, 50, 51, 52, 53, 54, },
-	.oobfree = {
-		{.offset = 8,
-			.length = 8},
-		{.offset = 24,
-			.length = 8},
-		{.offset = 40,
-			.length = 8},
-		{.offset = 56,
-			.length = 8},
-	}
+static int spinand_ooblayout_64_ecc(struct mtd_info *mtd, int section,
+				    struct mtd_oob_region *oobregion)
+{
+	if (section > 3)
+		return -ERANGE;
+
+	oobregion->offset = (section * 16) + 1;
+	oobregion->length = 6;
+
+	return 0;
+}
+
+static int spinand_ooblayout_64_free(struct mtd_info *mtd, int section,
+				     struct mtd_oob_region *oobregion)
+{
+	if (section > 3)
+		return -ERANGE;
+
+	oobregion->offset = (section * 16) + 8;
+	oobregion->length = 8;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops spinand_oob_64_ops = {
+	.ecc = spinand_ooblayout_64_ecc,
+	.free = spinand_ooblayout_64_free,
 };
 #endif
 
@@ -886,7 +896,6 @@ static int spinand_probe(struct spi_device *spi_nand)
 
 	chip->ecc.strength = 1;
 	chip->ecc.total	= chip->ecc.steps * chip->ecc.bytes;
-	chip->ecc.layout = &spinand_oob_64;
 	chip->ecc.read_page = spinand_read_page_hwecc;
 	chip->ecc.write_page = spinand_write_page_hwecc;
 #else
@@ -912,6 +921,9 @@ static int spinand_probe(struct spi_device *spi_nand)
 
 	mtd->dev.parent = &spi_nand->dev;
 	mtd->oobsize = 64;
+#ifdef CONFIG_MTD_SPINAND_ONDIEECC
+	mtd_set_ooblayout(mtd, &spinand_oob_64_ops);
+#endif
 
 	if (nand_scan(mtd, 1))
 		return -ENXIO;
-- 
2.5.0
