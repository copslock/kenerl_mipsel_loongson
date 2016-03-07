Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Mar 2016 10:54:34 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:38372 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27012326AbcCGJsgHd5FS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Mar 2016 10:48:36 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 4EF0F288D; Mon,  7 Mar 2016 10:48:29 +0100 (CET)
Received: from localhost.localdomain (AToulouse-657-1-1129-172.w92-156.abo.wanadoo.fr [92.156.51.172])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 3DC5EB23;
        Mon,  7 Mar 2016 10:48:05 +0100 (CET)
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
        Harvey Hunt <harvey.hunt@imgtec.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v4 20/52] mtd: docg3: switch to mtd_ooblayout_ops
Date:   Mon,  7 Mar 2016 10:47:10 +0100
Message-Id: <1457344062-11633-21-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1457344062-11633-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1457344062-11633-1-git-send-email-boris.brezillon@free-electrons.com>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52510
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

Replace the nand_ecclayout definition by the equivalent mtd_ooblayout_ops
definition.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/mtd/devices/docg3.c | 46 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/devices/docg3.c b/drivers/mtd/devices/docg3.c
index 6b516e1..b833e6c 100644
--- a/drivers/mtd/devices/docg3.c
+++ b/drivers/mtd/devices/docg3.c
@@ -67,16 +67,40 @@ module_param(reliable_mode, uint, 0);
 MODULE_PARM_DESC(reliable_mode, "Set the docg3 mode (0=normal MLC, 1=fast, "
 		 "2=reliable) : MLC normal operations are in normal mode");
 
-/**
- * struct docg3_oobinfo - DiskOnChip G3 OOB layout
- * @eccbytes: 8 bytes are used (1 for Hamming ECC, 7 for BCH ECC)
- * @eccpos: ecc positions (byte 7 is Hamming ECC, byte 8-14 are BCH ECC)
- * @oobfree: free pageinfo bytes (byte 0 until byte 6, byte 15
- */
-static struct nand_ecclayout docg3_oobinfo = {
-	.eccbytes = 8,
-	.eccpos = {7, 8, 9, 10, 11, 12, 13, 14},
-	.oobfree = {{0, 7}, {15, 1} },
+static int docg3_ooblayout_ecc(struct mtd_info *mtd, int section,
+			       struct mtd_oob_region *oobregion)
+{
+	if (section)
+		return -ERANGE;
+
+	/* byte 7 is Hamming ECC, byte 8-14 are BCH ECC */
+	oobregion->offset = 7;
+	oobregion->length = 8;
+
+	return 0;
+}
+
+static int docg3_ooblayout_free(struct mtd_info *mtd, int section,
+				struct mtd_oob_region *oobregion)
+{
+	if (section > 1)
+		return -ERANGE;
+
+	/* free bytes: byte 0 until byte 6, byte 15 */
+	if (!section) {
+		oobregion->offset = 0;
+		oobregion->length = 7;
+	} else {
+		oobregion->offset = 15;
+		oobregion->length = 1;
+	}
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops nand_ooblayout_docg3_ops = {
+	.ecc = docg3_ooblayout_ecc,
+	.free = docg3_ooblayout_free,
 };
 
 static inline u8 doc_readb(struct docg3 *docg3, u16 reg)
@@ -1857,7 +1881,7 @@ static int __init doc_set_driver_info(int chip_id, struct mtd_info *mtd)
 	mtd->_read_oob = doc_read_oob;
 	mtd->_write_oob = doc_write_oob;
 	mtd->_block_isbad = doc_block_isbad;
-	mtd_set_ecclayout(mtd, &docg3_oobinfo);
+	mtd_set_ooblayout(mtd, &nand_ooblayout_docg3_ops);
 	mtd->oobavail = 8;
 	mtd->ecc_strength = DOC_ECC_BCH_T;
 
-- 
2.1.4
