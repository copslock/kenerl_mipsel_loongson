Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Feb 2016 11:17:03 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:37814 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27012572AbcBDKIClrHVO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Feb 2016 11:08:02 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id BA1A84778; Thu,  4 Feb 2016 11:07:57 +0100 (CET)
Received: from localhost.localdomain (AToulouse-657-1-20-139.w83-193.abo.wanadoo.fr [83.193.84.139])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 537F8420D;
        Thu,  4 Feb 2016 11:07:35 +0100 (CET)
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
Subject: [PATCH v2 26/51] mtd: nand: bf5xx: switch to mtd_ooblayout_ops
Date:   Thu,  4 Feb 2016 11:06:49 +0100
Message-Id: <1454580434-32078-27-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1454580434-32078-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1454580434-32078-1-git-send-email-boris.brezillon@free-electrons.com>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51750
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
 drivers/mtd/nand/bf5xx_nand.c | 51 ++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/drivers/mtd/nand/bf5xx_nand.c b/drivers/mtd/nand/bf5xx_nand.c
index 7f6b30e..b38f414 100644
--- a/drivers/mtd/nand/bf5xx_nand.c
+++ b/drivers/mtd/nand/bf5xx_nand.c
@@ -109,28 +109,33 @@ static const unsigned short bfin_nfc_pin_req[] =
 	 0};
 
 #ifdef CONFIG_MTD_NAND_BF5XX_BOOTROM_ECC
-static struct nand_ecclayout bootrom_ecclayout = {
-	.eccbytes = 24,
-	.eccpos = {
-		0x8 * 0, 0x8 * 0 + 1, 0x8 * 0 + 2,
-		0x8 * 1, 0x8 * 1 + 1, 0x8 * 1 + 2,
-		0x8 * 2, 0x8 * 2 + 1, 0x8 * 2 + 2,
-		0x8 * 3, 0x8 * 3 + 1, 0x8 * 3 + 2,
-		0x8 * 4, 0x8 * 4 + 1, 0x8 * 4 + 2,
-		0x8 * 5, 0x8 * 5 + 1, 0x8 * 5 + 2,
-		0x8 * 6, 0x8 * 6 + 1, 0x8 * 6 + 2,
-		0x8 * 7, 0x8 * 7 + 1, 0x8 * 7 + 2
-	},
-	.oobfree = {
-		{ 0x8 * 0 + 3, 5 },
-		{ 0x8 * 1 + 3, 5 },
-		{ 0x8 * 2 + 3, 5 },
-		{ 0x8 * 3 + 3, 5 },
-		{ 0x8 * 4 + 3, 5 },
-		{ 0x8 * 5 + 3, 5 },
-		{ 0x8 * 6 + 3, 5 },
-		{ 0x8 * 7 + 3, 5 },
-	}
+static int bootrom_ooblayout_ecc(struct mtd_info *mtd, int section,
+				 struct mtd_oob_region *oobregion)
+{
+	if (section > 7)
+		return -ERANGE;
+
+	oobregion->offset = section * 8;
+	oobregion->length = 3;
+
+	return 0;
+}
+
+static int bootrom_ooblayout_free(struct mtd_info *mtd, int section,
+				  struct mtd_oob_region *oobregion)
+{
+	if (section > 7)
+		return -ERANGE;
+
+	oobregion->offset = (section * 8) + 3;
+	oobregion->length = 5;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops bootrom_ooblayout_ops = {
+	.ecc = bootrom_ooblayout_ecc,
+	.free = bootrom_ooblayout_free,
 };
 #endif
 
@@ -800,7 +805,7 @@ static int bf5xx_nand_probe(struct platform_device *pdev)
 	/* setup hardware ECC data struct */
 	if (hardware_ecc) {
 #ifdef CONFIG_MTD_NAND_BF5XX_BOOTROM_ECC
-		chip->ecc.layout = &bootrom_ecclayout;
+		mtd_set_ooblayout(mtd, &bootrom_ooblayout_ops);
 #endif
 		chip->read_buf      = bf5xx_nand_dma_read_buf;
 		chip->write_buf     = bf5xx_nand_dma_write_buf;
-- 
2.1.4
