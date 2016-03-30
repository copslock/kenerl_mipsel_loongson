Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2016 18:29:42 +0200 (CEST)
Received: from down.free-electrons.com ([37.187.137.238]:42639 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27025947AbcC3QQuHGrON (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Mar 2016 18:16:50 +0200
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 4E19B185A; Wed, 30 Mar 2016 18:16:44 +0200 (CEST)
Received: from localhost.localdomain (LMontsouris-657-1-184-87.w90-63.abo.wanadoo.fr [90.63.216.87])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 73AF91BBD;
        Wed, 30 Mar 2016 18:15:44 +0200 (CEST)
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
Subject: [PATCH v5 45/50] mtd: nand: vf610: switch to mtd_ooblayout_ops
Date:   Wed, 30 Mar 2016 18:15:00 +0200
Message-Id: <1459354505-32551-46-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52791
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
 drivers/mtd/nand/vf610_nfc.c | 34 ++++------------------------------
 1 file changed, 4 insertions(+), 30 deletions(-)

diff --git a/drivers/mtd/nand/vf610_nfc.c b/drivers/mtd/nand/vf610_nfc.c
index 293feb1..da34de1 100644
--- a/drivers/mtd/nand/vf610_nfc.c
+++ b/drivers/mtd/nand/vf610_nfc.c
@@ -175,34 +175,6 @@ static inline struct vf610_nfc *mtd_to_nfc(struct mtd_info *mtd)
 	return container_of(mtd_to_nand(mtd), struct vf610_nfc, chip);
 }
 
-static struct nand_ecclayout vf610_nfc_ecc45 = {
-	.eccbytes = 45,
-	.eccpos = {19, 20, 21, 22, 23,
-		   24, 25, 26, 27, 28, 29, 30, 31,
-		   32, 33, 34, 35, 36, 37, 38, 39,
-		   40, 41, 42, 43, 44, 45, 46, 47,
-		   48, 49, 50, 51, 52, 53, 54, 55,
-		   56, 57, 58, 59, 60, 61, 62, 63},
-	.oobfree = {
-		{.offset = 2,
-		 .length = 17} }
-};
-
-static struct nand_ecclayout vf610_nfc_ecc60 = {
-	.eccbytes = 60,
-	.eccpos = { 4,  5,  6,  7,  8,  9, 10, 11,
-		   12, 13, 14, 15, 16, 17, 18, 19,
-		   20, 21, 22, 23, 24, 25, 26, 27,
-		   28, 29, 30, 31, 32, 33, 34, 35,
-		   36, 37, 38, 39, 40, 41, 42, 43,
-		   44, 45, 46, 47, 48, 49, 50, 51,
-		   52, 53, 54, 55, 56, 57, 58, 59,
-		   60, 61, 62, 63 },
-	.oobfree = {
-		{.offset = 2,
-		 .length = 2} }
-};
-
 static inline u32 vf610_nfc_read(struct vf610_nfc *nfc, uint reg)
 {
 	return readl(nfc->regs + reg);
@@ -781,14 +753,16 @@ static int vf610_nfc_probe(struct platform_device *pdev)
 		if (mtd->oobsize > 64)
 			mtd->oobsize = 64;
 
+		/*
+		 * mtd->ecclayout is not specified here because we're using the
+		 * default large page ECC layout defined in NAND core.
+		 */
 		if (chip->ecc.strength == 32) {
 			nfc->ecc_mode = ECC_60_BYTE;
 			chip->ecc.bytes = 60;
-			chip->ecc.layout = &vf610_nfc_ecc60;
 		} else if (chip->ecc.strength == 24) {
 			nfc->ecc_mode = ECC_45_BYTE;
 			chip->ecc.bytes = 45;
-			chip->ecc.layout = &vf610_nfc_ecc45;
 		} else {
 			dev_err(nfc->dev, "Unsupported ECC strength\n");
 			err = -ENXIO;
-- 
2.5.0
