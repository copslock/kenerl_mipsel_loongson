Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2016 18:22:45 +0200 (CEST)
Received: from down.free-electrons.com ([37.187.137.238]:41938 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27025909AbcC3QPrZ--vN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Mar 2016 18:15:47 +0200
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 6D09E183A; Wed, 30 Mar 2016 18:15:40 +0200 (CEST)
Received: from localhost.localdomain (LMontsouris-657-1-184-87.w90-63.abo.wanadoo.fr [90.63.216.87])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 3337B183A;
        Wed, 30 Mar 2016 18:15:25 +0200 (CEST)
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
Subject: [PATCH v5 23/50] mtd: nand: bf5xx: switch to mtd_ooblayout_ops
Date:   Wed, 30 Mar 2016 18:14:38 +0200
Message-Id: <1459354505-32551-24-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52768
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
2.5.0
