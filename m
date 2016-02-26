Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Feb 2016 02:11:16 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:38259 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27014946AbcBZBJZTFJQb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Feb 2016 02:09:25 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 94A194CBB; Fri, 26 Feb 2016 02:09:19 +0100 (CET)
Received: from localhost.localdomain (unknown [208.66.31.210])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 1AFCC17C5;
        Fri, 26 Feb 2016 02:03:10 +0100 (CET)
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
        Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v3 45/52] mtd: nand: sh_flctl: switch to mtd_ooblayout_ops
Date:   Fri, 26 Feb 2016 01:57:53 +0100
Message-Id: <1456448280-27788-46-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1456448280-27788-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1456448280-27788-1-git-send-email-boris.brezillon@free-electrons.com>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52319
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
 drivers/mtd/nand/sh_flctl.c | 87 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 67 insertions(+), 20 deletions(-)

diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index 4814402..fa46610 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -43,26 +43,73 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/sh_flctl.h>
 
-static struct nand_ecclayout flctl_4secc_oob_16 = {
-	.eccbytes = 10,
-	.eccpos = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9},
-	.oobfree = {
-		{.offset = 12,
-		. length = 4} },
+static int flctl_4secc_ooblayout_sp_ecc(struct mtd_info *mtd, int section,
+					struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	if (section)
+		return -ERANGE;
+
+	oobregion->offset = 0;
+	oobregion->length = chip->ecc.bytes;
+
+	return 0;
+}
+
+static int flctl_4secc_ooblayout_sp_free(struct mtd_info *mtd, int section,
+					 struct mtd_oob_region *oobregion)
+{
+	if (section)
+		return -ERANGE;
+
+	oobregion->offset = 12;
+	oobregion->length = 4;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops flctl_4secc_oob_smallpage_ops = {
+	.ecc = flctl_4secc_ooblayout_sp_ecc,
+	.free = flctl_4secc_ooblayout_sp_free,
 };
 
-static struct nand_ecclayout flctl_4secc_oob_64 = {
-	.eccbytes = 4 * 10,
-	.eccpos = {
-		 6,  7,  8,  9, 10, 11, 12, 13, 14, 15,
-		22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
-		38, 39, 40, 41, 42, 43, 44, 45, 46, 47,
-		54, 55, 56, 57, 58, 59, 60, 61, 62, 63 },
-	.oobfree = {
-		{.offset =  2, .length = 4},
-		{.offset = 16, .length = 6},
-		{.offset = 32, .length = 6},
-		{.offset = 48, .length = 6} },
+static int flctl_4secc_ooblayout_lp_ecc(struct mtd_info *mtd, int section,
+					struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	if (section >= chip->ecc.steps)
+		return -ERANGE;
+
+	oobregion->offset = (section * 16) + 6;
+	oobregion->length = chip->ecc.bytes;
+
+	return 0;
+}
+
+static int flctl_4secc_ooblayout_lp_free(struct mtd_info *mtd, int section,
+					 struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	if (section >= chip->ecc.steps)
+		return -ERANGE;
+
+	oobregion->offset = section * 16;
+	oobregion->length = 6;
+
+	if (!section) {
+		oobregion->offset += 2;
+		oobregion->length -= 2;
+	}
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops flctl_4secc_oob_largepage_ops = {
+	.ecc = flctl_4secc_ooblayout_lp_ecc,
+	.free = flctl_4secc_ooblayout_lp_free,
 };
 
 static uint8_t scan_ff_pattern[] = { 0xff, 0xff };
@@ -987,10 +1034,10 @@ static int flctl_chip_init_tail(struct mtd_info *mtd)
 
 	if (flctl->hwecc) {
 		if (mtd->writesize == 512) {
-			chip->ecc.layout = &flctl_4secc_oob_16;
+			mtd_set_ooblayout(mtd, &flctl_4secc_oob_smallpage_ops);
 			chip->badblock_pattern = &flctl_4secc_smallpage;
 		} else {
-			chip->ecc.layout = &flctl_4secc_oob_64;
+			mtd_set_ooblayout(mtd, &flctl_4secc_oob_largepage_ops);
 			chip->badblock_pattern = &flctl_4secc_largepage;
 		}
 
-- 
2.1.4
