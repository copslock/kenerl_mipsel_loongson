Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Feb 2016 02:02:15 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:37234 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27014913AbcBZA7zMSROb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Feb 2016 01:59:55 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 2F976A2F; Fri, 26 Feb 2016 01:59:48 +0100 (CET)
Received: from localhost.localdomain (unknown [208.66.31.210])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 4138046C;
        Fri, 26 Feb 2016 01:59:40 +0100 (CET)
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
Subject: [PATCH v3 13/52] mtd: onenand: use mtd_ooblayout_xxx() helpers where appropriate
Date:   Fri, 26 Feb 2016 01:57:21 +0100
Message-Id: <1456448280-27788-14-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1456448280-27788-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1456448280-27788-1-git-send-email-boris.brezillon@free-electrons.com>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52287
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

The mtd_ooblayout_xxx() helper functions have been added to avoid direct
accesses to the ecclayout field, and thus ease for future reworks.
Use these helpers in all places where the oobfree[] and eccpos[] arrays
where directly accessed.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/onenand/onenand_base.c | 75 ++++++++------------------------------
 1 file changed, 15 insertions(+), 60 deletions(-)

diff --git a/drivers/mtd/onenand/onenand_base.c b/drivers/mtd/onenand/onenand_base.c
index af28bb3..20fdf8c 100644
--- a/drivers/mtd/onenand/onenand_base.c
+++ b/drivers/mtd/onenand/onenand_base.c
@@ -1024,34 +1024,15 @@ static int onenand_transfer_auto_oob(struct mtd_info *mtd, uint8_t *buf, int col
 				int thislen)
 {
 	struct onenand_chip *this = mtd->priv;
-	struct nand_oobfree *free;
-	int readcol = column;
-	int readend = column + thislen;
-	int lastgap = 0;
-	unsigned int i;
-	uint8_t *oob_buf = this->oob_buf;
-
-	free = this->ecclayout->oobfree;
-	for (i = 0; i < MTD_MAX_OOBFREE_ENTRIES && free->length; i++, free++) {
-		if (readcol >= lastgap)
-			readcol += free->offset - lastgap;
-		if (readend >= lastgap)
-			readend += free->offset - lastgap;
-		lastgap = free->offset + free->length;
-	}
-	this->read_bufferram(mtd, ONENAND_SPARERAM, oob_buf, 0, mtd->oobsize);
-	free = this->ecclayout->oobfree;
-	for (i = 0; i < MTD_MAX_OOBFREE_ENTRIES && free->length; i++, free++) {
-		int free_end = free->offset + free->length;
-		if (free->offset < readend && free_end > readcol) {
-			int st = max_t(int,free->offset,readcol);
-			int ed = min_t(int,free_end,readend);
-			int n = ed - st;
-			memcpy(buf, oob_buf + st, n);
-			buf += n;
-		} else if (column == 0)
-			break;
-	}
+	int ret;
+
+	this->read_bufferram(mtd, ONENAND_SPARERAM, this->oob_buf, 0,
+			     mtd->oobsize);
+	ret = mtd_ooblayout_get_databytes(mtd, buf, this->oob_buf,
+					  column, thislen);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -1808,34 +1789,7 @@ static int onenand_panic_write(struct mtd_info *mtd, loff_t to, size_t len,
 static int onenand_fill_auto_oob(struct mtd_info *mtd, u_char *oob_buf,
 				  const u_char *buf, int column, int thislen)
 {
-	struct onenand_chip *this = mtd->priv;
-	struct nand_oobfree *free;
-	int writecol = column;
-	int writeend = column + thislen;
-	int lastgap = 0;
-	unsigned int i;
-
-	free = this->ecclayout->oobfree;
-	for (i = 0; i < MTD_MAX_OOBFREE_ENTRIES && free->length; i++, free++) {
-		if (writecol >= lastgap)
-			writecol += free->offset - lastgap;
-		if (writeend >= lastgap)
-			writeend += free->offset - lastgap;
-		lastgap = free->offset + free->length;
-	}
-	free = this->ecclayout->oobfree;
-	for (i = 0; i < MTD_MAX_OOBFREE_ENTRIES && free->length; i++, free++) {
-		int free_end = free->offset + free->length;
-		if (free->offset < writeend && free_end > writecol) {
-			int st = max_t(int,free->offset,writecol);
-			int ed = min_t(int,free_end,writeend);
-			int n = ed - st;
-			memcpy(oob_buf + st, buf, n);
-			buf += n;
-		} else if (column == 0)
-			break;
-	}
-	return 0;
+	return mtd_ooblayout_set_databytes(mtd, buf, oob_buf, column, thislen);
 }
 
 /**
@@ -4037,10 +3991,11 @@ int onenand_scan(struct mtd_info *mtd, int maxchips)
 	 * The number of bytes available for a client to place data into
 	 * the out of band area
 	 */
-	mtd->oobavail = 0;
-	for (i = 0; i < MTD_MAX_OOBFREE_ENTRIES &&
-	    this->ecclayout->oobfree[i].length; i++)
-		mtd->oobavail += this->ecclayout->oobfree[i].length;
+	ret = mtd_ooblayout_count_freebytes(mtd);
+	if (ret < 0)
+		ret = 0;
+
+	mtd->oobavail = ret;
 
 	mtd->ecclayout = this->ecclayout;
 	mtd->ecc_strength = 1;
-- 
2.1.4
