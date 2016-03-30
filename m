Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2016 18:21:34 +0200 (CEST)
Received: from down.free-electrons.com ([37.187.137.238]:41842 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27025926AbcC3QPm5liaN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Mar 2016 18:15:42 +0200
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 18655185D; Wed, 30 Mar 2016 18:15:37 +0200 (CEST)
Received: from localhost.localdomain (LMontsouris-657-1-184-87.w90-63.abo.wanadoo.fr [90.63.216.87])
        by mail.free-electrons.com (Postfix) with ESMTPSA id BCA461812;
        Wed, 30 Mar 2016 18:15:22 +0200 (CEST)
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
Subject: [PATCH v5 20/50] mtd: nand: sharpsl: switch to mtd_ooblayout_ops
Date:   Wed, 30 Mar 2016 18:14:35 +0200
Message-Id: <1459354505-32551-21-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52764
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
 arch/arm/mach-pxa/spitz.c   | 55 ++++++++++++++++++++++++++++++++++++---------
 drivers/mtd/nand/sharpsl.c  |  2 +-
 include/linux/mtd/sharpsl.h |  2 +-
 3 files changed, 47 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index d9578bc..bd7cd8b 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -763,14 +763,49 @@ static struct nand_bbt_descr spitz_nand_bbt = {
 	.pattern	= scan_ff_pattern
 };
 
-static struct nand_ecclayout akita_oobinfo = {
-	.oobfree	= { {0x08, 0x09} },
-	.eccbytes	= 24,
-	.eccpos		= {
-			0x05, 0x01, 0x02, 0x03, 0x06, 0x07, 0x15, 0x11,
-			0x12, 0x13, 0x16, 0x17, 0x25, 0x21, 0x22, 0x23,
-			0x26, 0x27, 0x35, 0x31, 0x32, 0x33, 0x36, 0x37,
-	},
+static int akita_ooblayout_ecc(struct mtd_info *mtd, int section,
+			       struct mtd_oob_region *oobregion)
+{
+	if (section > 12)
+		return -ERANGE;
+
+	switch (section % 3) {
+	case 0:
+		oobregion->offset = 5;
+		oobregion->length = 1;
+		break;
+
+	case 1:
+		oobregion->offset = 1;
+		oobregion->length = 3;
+		break;
+
+	case 2:
+		oobregion->offset = 6;
+		oobregion->length = 2;
+		break;
+	}
+
+	oobregion->offset += (section / 3) * 0x10;
+
+	return 0;
+}
+
+static int akita_ooblayout_free(struct mtd_info *mtd, int section,
+				struct mtd_oob_region *oobregion)
+{
+	if (section)
+		return -ERANGE;
+
+	oobregion->offset = 8;
+	oobregion->length = 9;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops akita_ooblayout_ops = {
+	.ecc = akita_ooblayout_ecc,
+	.free = akita_ooblayout_free,
 };
 
 static struct sharpsl_nand_platform_data spitz_nand_pdata = {
@@ -804,11 +839,11 @@ static void __init spitz_nand_init(void)
 	} else if (machine_is_akita()) {
 		spitz_nand_partitions[1].size = 58 * 1024 * 1024;
 		spitz_nand_bbt.len = 1;
-		spitz_nand_pdata.ecc_layout = &akita_oobinfo;
+		spitz_nand_pdata.ecc_layout = &akita_ooblayout_ops;
 	} else if (machine_is_borzoi()) {
 		spitz_nand_partitions[1].size = 32 * 1024 * 1024;
 		spitz_nand_bbt.len = 1;
-		spitz_nand_pdata.ecc_layout = &akita_oobinfo;
+		spitz_nand_pdata.ecc_layout = &akita_ooblayout_ops;
 	}
 
 	platform_device_register(&spitz_nand_device);
diff --git a/drivers/mtd/nand/sharpsl.c b/drivers/mtd/nand/sharpsl.c
index b7d1b55..064ca17 100644
--- a/drivers/mtd/nand/sharpsl.c
+++ b/drivers/mtd/nand/sharpsl.c
@@ -148,6 +148,7 @@ static int sharpsl_nand_probe(struct platform_device *pdev)
 	/* Link the private data with the MTD structure */
 	mtd = nand_to_mtd(this);
 	mtd->dev.parent = &pdev->dev;
+	mtd_set_ooblayout(mtd, data->ecc_layout);
 
 	platform_set_drvdata(pdev, sharpsl);
 
@@ -170,7 +171,6 @@ static int sharpsl_nand_probe(struct platform_device *pdev)
 	this->ecc.bytes = 3;
 	this->ecc.strength = 1;
 	this->badblock_pattern = data->badblock_pattern;
-	this->ecc.layout = data->ecc_layout;
 	this->ecc.hwctl = sharpsl_nand_enable_hwecc;
 	this->ecc.calculate = sharpsl_nand_calculate_ecc;
 	this->ecc.correct = nand_correct_data;
diff --git a/include/linux/mtd/sharpsl.h b/include/linux/mtd/sharpsl.h
index 25f4d2a..65e91d0 100644
--- a/include/linux/mtd/sharpsl.h
+++ b/include/linux/mtd/sharpsl.h
@@ -14,7 +14,7 @@
 
 struct sharpsl_nand_platform_data {
 	struct nand_bbt_descr	*badblock_pattern;
-	struct nand_ecclayout	*ecc_layout;
+	const struct mtd_ooblayout_ops *ecc_layout;
 	struct mtd_partition	*partitions;
 	unsigned int		nr_partitions;
 };
-- 
2.5.0
