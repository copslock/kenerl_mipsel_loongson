Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Feb 2016 11:18:49 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:38064 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27011229AbcBDKINFI4-O (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Feb 2016 11:08:13 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id BB55E48A1; Thu,  4 Feb 2016 11:08:07 +0100 (CET)
Received: from localhost.localdomain (AToulouse-657-1-20-139.w83-193.abo.wanadoo.fr [83.193.84.139])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 105A344AA;
        Thu,  4 Feb 2016 11:07:44 +0100 (CET)
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
Subject: [PATCH v2 38/51] mtd: nand: jz4780: switch to mtd_ooblayout_ops
Date:   Thu,  4 Feb 2016 11:07:01 +0100
Message-Id: <1454580434-32078-39-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1454580434-32078-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1454580434-32078-1-git-send-email-boris.brezillon@free-electrons.com>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51756
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
 drivers/mtd/nand/jz4780_nand.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/nand/jz4780_nand.c b/drivers/mtd/nand/jz4780_nand.c
index e1c016c..b86a579 100644
--- a/drivers/mtd/nand/jz4780_nand.c
+++ b/drivers/mtd/nand/jz4780_nand.c
@@ -56,8 +56,6 @@ struct jz4780_nand_chip {
 	struct nand_chip chip;
 	struct list_head chip_list;
 
-	struct nand_ecclayout ecclayout;
-
 	struct gpio_desc *busy_gpio;
 	struct gpio_desc *wp_gpio;
 	unsigned int reading: 1;
@@ -165,8 +163,7 @@ static int jz4780_nand_init_ecc(struct jz4780_nand_chip *nand, struct device *de
 	struct nand_chip *chip = &nand->chip;
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct jz4780_nand_controller *nfc = to_jz4780_nand_controller(chip->controller);
-	struct nand_ecclayout *layout = &nand->ecclayout;
-	u32 start, i;
+	int eccbytes;
 
 	chip->ecc.bytes = fls((1 + 8) * chip->ecc.size)	*
 				(chip->ecc.strength / 8);
@@ -201,23 +198,17 @@ static int jz4780_nand_init_ecc(struct jz4780_nand_chip *nand, struct device *de
 		return 0;
 
 	/* Generate ECC layout. ECC codes are right aligned in the OOB area. */
-	layout->eccbytes = mtd->writesize / chip->ecc.size * chip->ecc.bytes;
+	eccbytes = mtd->writesize / chip->ecc.size * chip->ecc.bytes;
 
-	if (layout->eccbytes > mtd->oobsize - 2) {
+	if (eccbytes > mtd->oobsize - 2) {
 		dev_err(dev,
 			"invalid ECC config: required %d ECC bytes, but only %d are available",
-			layout->eccbytes, mtd->oobsize - 2);
+			eccbytes, mtd->oobsize - 2);
 		return -EINVAL;
 	}
 
-	start = mtd->oobsize - layout->eccbytes;
-	for (i = 0; i < layout->eccbytes; i++)
-		layout->eccpos[i] = start + i;
-
-	layout->oobfree[0].offset = 2;
-	layout->oobfree[0].length = mtd->oobsize - layout->eccbytes - 2;
+	mtd->ooblayout = &nand_ooblayout_lp_ops;
 
-	chip->ecc.layout = layout;
 	return 0;
 }
 
-- 
2.1.4
