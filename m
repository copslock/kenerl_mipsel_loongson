Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2016 18:24:06 +0200 (CEST)
Received: from down.free-electrons.com ([37.187.137.238]:42093 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27025908AbcC3QQDD8ftN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Mar 2016 18:16:03 +0200
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 3E9AA1CC3; Wed, 30 Mar 2016 18:15:57 +0200 (CEST)
Received: from localhost.localdomain (LMontsouris-657-1-184-87.w90-63.abo.wanadoo.fr [90.63.216.87])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 7AFA81845;
        Wed, 30 Mar 2016 18:15:29 +0200 (CEST)
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
Subject: [PATCH v5 28/50] mtd: nand: diskonchip: switch to mtd_ooblayout_ops
Date:   Wed, 30 Mar 2016 18:14:43 +0200
Message-Id: <1459354505-32551-29-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52772
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
 drivers/mtd/nand/diskonchip.c | 60 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 45 insertions(+), 15 deletions(-)

diff --git a/drivers/mtd/nand/diskonchip.c b/drivers/mtd/nand/diskonchip.c
index 547c100..a023ab9 100644
--- a/drivers/mtd/nand/diskonchip.c
+++ b/drivers/mtd/nand/diskonchip.c
@@ -950,20 +950,50 @@ static int doc200x_correct_data(struct mtd_info *mtd, u_char *dat,
 
 //u_char mydatabuf[528];
 
-/* The strange out-of-order .oobfree list below is a (possibly unneeded)
- * attempt to retain compatibility.  It used to read:
- * 	.oobfree = { {8, 8} }
- * Since that leaves two bytes unusable, it was changed.  But the following
- * scheme might affect existing jffs2 installs by moving the cleanmarker:
- * 	.oobfree = { {6, 10} }
- * jffs2 seems to handle the above gracefully, but the current scheme seems
- * safer.  The only problem with it is that any code that parses oobfree must
- * be able to handle out-of-order segments.
- */
-static struct nand_ecclayout doc200x_oobinfo = {
-	.eccbytes = 6,
-	.eccpos = {0, 1, 2, 3, 4, 5},
-	.oobfree = {{8, 8}, {6, 2}}
+static int doc200x_ooblayout_ecc(struct mtd_info *mtd, int section,
+				 struct mtd_oob_region *oobregion)
+{
+	if (section)
+		return -ERANGE;
+
+	oobregion->offset = 0;
+	oobregion->length = 6;
+
+	return 0;
+}
+
+static int doc200x_ooblayout_free(struct mtd_info *mtd, int section,
+				  struct mtd_oob_region *oobregion)
+{
+	if (section > 1)
+		return -ERANGE;
+
+	/*
+	 * The strange out-of-order free bytes definition is a (possibly
+	 * unneeded) attempt to retain compatibility.  It used to read:
+	 *	.oobfree = { {8, 8} }
+	 * Since that leaves two bytes unusable, it was changed.  But the
+	 * following scheme might affect existing jffs2 installs by moving the
+	 * cleanmarker:
+	 *	.oobfree = { {6, 10} }
+	 * jffs2 seems to handle the above gracefully, but the current scheme
+	 * seems safer. The only problem with it is that any code retrieving
+	 * free bytes position must be able to handle out-of-order segments.
+	 */
+	if (!section) {
+		oobregion->offset = 8;
+		oobregion->length = 8;
+	} else {
+		oobregion->offset = 6;
+		oobregion->length = 2;
+	}
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops doc200x_ooblayout_ops = {
+	.ecc = doc200x_ooblayout_ecc,
+	.free = doc200x_ooblayout_free,
 };
 
 /* Find the (I)NFTL Media Header, and optionally also the mirror media header.
@@ -1537,6 +1567,7 @@ static int __init doc_probe(unsigned long physadr)
 	nand->bbt_md		= nand->bbt_td + 1;
 
 	mtd->owner		= THIS_MODULE;
+	mtd_set_ooblayout(mtd, &doc200x_ooblayout_ops);
 
 	nand_set_controller_data(nand, doc);
 	nand->select_chip	= doc200x_select_chip;
@@ -1548,7 +1579,6 @@ static int __init doc_probe(unsigned long physadr)
 	nand->ecc.calculate	= doc200x_calculate_ecc;
 	nand->ecc.correct	= doc200x_correct_data;
 
-	nand->ecc.layout	= &doc200x_oobinfo;
 	nand->ecc.mode		= NAND_ECC_HW_SYNDROME;
 	nand->ecc.size		= 512;
 	nand->ecc.bytes		= 6;
-- 
2.5.0
