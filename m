Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Feb 2016 11:21:03 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:38218 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27011517AbcBDKIbdR1XO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Feb 2016 11:08:31 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 7D0AA44F4; Thu,  4 Feb 2016 11:08:23 +0100 (CET)
Received: from localhost.localdomain (AToulouse-657-1-20-139.w83-193.abo.wanadoo.fr [83.193.84.139])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 4CBC04566;
        Thu,  4 Feb 2016 11:07:49 +0100 (CET)
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
        Josh Wu <josh.wu@atmel.com>,
        Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com,
        Stefan Agner <stefan@agner.ch>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        punnaiah choudary kalluri <punnaia@xilinx.com>,
        Priit Laes <plaes@plaes.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v2 45/51] mtd: nand: sm_common: switch to mtd_ooblayout_ops
Date:   Thu,  4 Feb 2016 11:07:08 +0100
Message-Id: <1454580434-32078-46-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1454580434-32078-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1454580434-32078-1-git-send-email-boris.brezillon@free-electrons.com>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51763
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
index c514740..355ca12 100644
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
+const struct mtd_ooblayout_ops oob_sm_ops = {
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
+const struct mtd_ooblayout_ops oob_sm_small_ops = {
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
2.1.4
