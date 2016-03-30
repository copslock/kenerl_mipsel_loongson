Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2016 18:28:30 +0200 (CEST)
Received: from down.free-electrons.com ([37.187.137.238]:42583 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27025948AbcC3QQqbID5N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Mar 2016 18:16:46 +0200
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id A18DD184C; Wed, 30 Mar 2016 18:16:40 +0200 (CEST)
Received: from localhost.localdomain (LMontsouris-657-1-184-87.w90-63.abo.wanadoo.fr [90.63.216.87])
        by mail.free-electrons.com (Postfix) with ESMTPSA id B92E81827;
        Wed, 30 Mar 2016 18:15:42 +0200 (CEST)
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
Subject: [PATCH v5 43/50] mtd: nand: sm_common: switch to mtd_ooblayout_ops
Date:   Wed, 30 Mar 2016 18:14:58 +0200
Message-Id: <1459354505-32551-44-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52787
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
 drivers/mtd/nand/sm_common.c | 93 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 77 insertions(+), 16 deletions(-)

diff --git a/drivers/mtd/nand/sm_common.c b/drivers/mtd/nand/sm_common.c
index c514740..5939dff 100644
--- a/drivers/mtd/nand/sm_common.c
+++ b/drivers/mtd/nand/sm_common.c
@@ -12,14 +12,47 @@
 #include <linux/sizes.h>
 #include "sm_common.h"
 
-static struct nand_ecclayout nand_oob_sm = {
-	.eccbytes = 6,
-	.eccpos = {8, 9, 10, 13, 14, 15},
-	.oobfree = {
-		{.offset = 0 , .length = 4}, /* reserved */
-		{.offset = 6 , .length = 2}, /* LBA1 */
-		{.offset = 11, .length = 2}  /* LBA2 */
+static int oob_sm_ooblayout_ecc(struct mtd_info *mtd, int section,
+				struct mtd_oob_region *oobregion)
+{
+	if (section > 1)
+		return -ERANGE;
+
+	oobregion->length = 3;
+	oobregion->offset = ((section + 1) * 8) - 3;
+
+	return 0;
+}
+
+static int oob_sm_ooblayout_free(struct mtd_info *mtd, int section,
+				 struct mtd_oob_region *oobregion)
+{
+	switch (section) {
+	case 0:
+		/* reserved */
+		oobregion->offset = 0;
+		oobregion->length = 4;
+		break;
+	case 1:
+		/* LBA1 */
+		oobregion->offset = 6;
+		oobregion->length = 2;
+		break;
+	case 2:
+		/* LBA2 */
+		oobregion->offset = 11;
+		oobregion->length = 2;
+		break;
+	default:
+		return -ERANGE;
 	}
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops oob_sm_ops = {
+	.ecc = oob_sm_ooblayout_ecc,
+	.free = oob_sm_ooblayout_free,
 };
 
 /* NOTE: This layout is is not compatabable with SmartMedia, */
@@ -28,15 +61,43 @@ static struct nand_ecclayout nand_oob_sm = {
 /* If you use smftl, it will bypass this and work correctly */
 /* If you not, then you break SmartMedia compliance anyway */
 
-static struct nand_ecclayout nand_oob_sm_small = {
-	.eccbytes = 3,
-	.eccpos = {0, 1, 2},
-	.oobfree = {
-		{.offset = 3 , .length = 2}, /* reserved */
-		{.offset = 6 , .length = 2}, /* LBA1 */
+static int oob_sm_small_ooblayout_ecc(struct mtd_info *mtd, int section,
+				      struct mtd_oob_region *oobregion)
+{
+	if (section)
+		return -ERANGE;
+
+	oobregion->length = 3;
+	oobregion->offset = 0;
+
+	return 0;
+}
+
+static int oob_sm_small_ooblayout_free(struct mtd_info *mtd, int section,
+				       struct mtd_oob_region *oobregion)
+{
+	switch (section) {
+	case 0:
+		/* reserved */
+		oobregion->offset = 3;
+		oobregion->length = 2;
+		break;
+	case 1:
+		/* LBA1 */
+		oobregion->offset = 6;
+		oobregion->length = 2;
+		break;
+	default:
+		return -ERANGE;
 	}
-};
 
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops oob_sm_small_ops = {
+	.ecc = oob_sm_small_ooblayout_ecc,
+	.free = oob_sm_small_ooblayout_free,
+};
 
 static int sm_block_markbad(struct mtd_info *mtd, loff_t ofs)
 {
@@ -121,9 +182,9 @@ int sm_register_device(struct mtd_info *mtd, int smartmedia)
 
 	/* ECC layout */
 	if (mtd->writesize == SM_SECTOR_SIZE)
-		chip->ecc.layout = &nand_oob_sm;
+		mtd_set_ooblayout(mtd, &oob_sm_ops);
 	else if (mtd->writesize == SM_SMALL_PAGE)
-		chip->ecc.layout = &nand_oob_sm_small;
+		mtd_set_ooblayout(mtd, &oob_sm_small_ops);
 	else
 		return -ENODEV;
 
-- 
2.5.0
