Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Feb 2016 02:09:59 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:38103 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27014939AbcBZBIDbPV8b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Feb 2016 02:08:03 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id C71294CB2; Fri, 26 Feb 2016 02:07:57 +0100 (CET)
Received: from localhost.localdomain (unknown [208.66.31.210])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 53D1117BD;
        Fri, 26 Feb 2016 02:02:38 +0100 (CET)
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
Subject: [PATCH v3 40/52] mtd: nand: lpc32xx: switch to mtd_ooblayout_ops
Date:   Fri, 26 Feb 2016 01:57:48 +0100
Message-Id: <1456448280-27788-41-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1456448280-27788-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1456448280-27788-1-git-send-email-boris.brezillon@free-electrons.com>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52314
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
 drivers/mtd/nand/lpc32xx_mlc.c | 50 ++++++++++++++++++++++++++++--------------
 drivers/mtd/nand/lpc32xx_slc.c | 41 +++++++++++++++++++++++++++-------
 2 files changed, 66 insertions(+), 25 deletions(-)

diff --git a/drivers/mtd/nand/lpc32xx_mlc.c b/drivers/mtd/nand/lpc32xx_mlc.c
index d8c3e7a..f668282 100644
--- a/drivers/mtd/nand/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/lpc32xx_mlc.c
@@ -139,22 +139,37 @@ struct lpc32xx_nand_cfg_mlc {
 	unsigned num_parts;
 };
 
-static struct nand_ecclayout lpc32xx_nand_oob = {
-	.eccbytes = 40,
-	.eccpos = { 6,  7,  8,  9, 10, 11, 12, 13, 14, 15,
-		   22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
-		   38, 39, 40, 41, 42, 43, 44, 45, 46, 47,
-		   54, 55, 56, 57, 58, 59, 60, 61, 62, 63 },
-	.oobfree = {
-		{ .offset = 0,
-		  .length = 6, },
-		{ .offset = 16,
-		  .length = 6, },
-		{ .offset = 32,
-		  .length = 6, },
-		{ .offset = 48,
-		  .length = 6, },
-		},
+static int lpc32xx_ooblayout_ecc(struct mtd_info *mtd, int section,
+				 struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *nand_chip = mtd_to_nand(mtd);
+
+	if (section >= nand_chip->ecc.steps)
+		return -ERANGE;
+
+	oobregion->offset = ((section + 1) * 16) - nand_chip->ecc.bytes;
+	oobregion->length = nand_chip->ecc.bytes;
+
+	return 0;
+}
+
+static int lpc32xx_ooblayout_free(struct mtd_info *mtd, int section,
+				  struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *nand_chip = mtd_to_nand(mtd);
+
+	if (section >= nand_chip->ecc.steps)
+		return -ERANGE;
+
+	oobregion->offset = 16 * section;
+	oobregion->length = 16 - nand_chip->ecc.bytes;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops lpc32xx_ooblayout_ops = {
+	.ecc = lpc32xx_ooblayout_ecc,
+	.free = lpc32xx_ooblayout_free,
 };
 
 static struct nand_bbt_descr lpc32xx_nand_bbt = {
@@ -713,6 +728,7 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 	nand_chip->ecc.write_oob = lpc32xx_write_oob;
 	nand_chip->ecc.read_oob = lpc32xx_read_oob;
 	nand_chip->ecc.strength = 4;
+	nand_chip->ecc.bytes = 10;
 	nand_chip->waitfunc = lpc32xx_waitfunc;
 
 	nand_chip->options = NAND_NO_SUBPAGE_WRITE;
@@ -751,7 +767,7 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 
 	nand_chip->ecc.mode = NAND_ECC_HW;
 	nand_chip->ecc.size = 512;
-	nand_chip->ecc.layout = &lpc32xx_nand_oob;
+	mtd_set_ooblayout(mtd, &lpc32xx_ooblayout_ops);
 	host->mlcsubpages = mtd->writesize / 512;
 
 	/* initially clear interrupt status */
diff --git a/drivers/mtd/nand/lpc32xx_slc.c b/drivers/mtd/nand/lpc32xx_slc.c
index 10cf8e62..219dd67 100644
--- a/drivers/mtd/nand/lpc32xx_slc.c
+++ b/drivers/mtd/nand/lpc32xx_slc.c
@@ -146,13 +146,38 @@
  * NAND ECC Layout for small page NAND devices
  * Note: For large and huge page devices, the default layouts are used
  */
-static struct nand_ecclayout lpc32xx_nand_oob_16 = {
-	.eccbytes = 6,
-	.eccpos = {10, 11, 12, 13, 14, 15},
-	.oobfree = {
-		{ .offset = 0, .length = 4 },
-		{ .offset = 6, .length = 4 },
-	},
+static int lpc32xx_ooblayout_ecc(struct mtd_info *mtd, int section,
+				 struct mtd_oob_region *oobregion)
+{
+	if (section)
+		return -ERANGE;
+
+	oobregion->length = 6;
+	oobregion->offset = 10;
+
+	return 0;
+}
+
+static int lpc32xx_ooblayout_free(struct mtd_info *mtd, int section,
+				  struct mtd_oob_region *oobregion)
+{
+	if (section > 1)
+		return -ERANGE;
+
+	if (!section) {
+		oobregion->offset = 0;
+		oobregion->length = 4;
+	} else {
+		oobregion->offset = 6;
+		oobregion->length = 4;
+	}
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops lpc32xx_ooblayout_ops = {
+	.ecc = lpc32xx_ooblayout_ecc,
+	.free = lpc32xx_ooblayout_free,
 };
 
 static u8 bbt_pattern[] = {'B', 'b', 't', '0' };
@@ -886,7 +911,7 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 	 * custom BBT marker layout.
 	 */
 	if (mtd->writesize <= 512)
-		chip->ecc.layout = &lpc32xx_nand_oob_16;
+		mtd_set_ooblayout(mtd, &lpc32xx_ooblayout_ops);
 
 	/* These sizes remain the same regardless of page size */
 	chip->ecc.size = 256;
-- 
2.1.4
