Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Feb 2016 11:07:57 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:37292 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27011517AbcBDKHWx5UBO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Feb 2016 11:07:22 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id E82F72B4; Thu,  4 Feb 2016 11:07:17 +0100 (CET)
Received: from localhost.localdomain (AToulouse-657-1-20-139.w83-193.abo.wanadoo.fr [83.193.84.139])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 35D291F5;
        Thu,  4 Feb 2016 11:07:17 +0100 (CET)
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
Subject: [PATCH v2 02/51] mtd: create an mtd_oobavail() helper and make use of it
Date:   Thu,  4 Feb 2016 11:06:25 +0100
Message-Id: <1454580434-32078-3-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1454580434-32078-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1454580434-32078-1-git-send-email-boris.brezillon@free-electrons.com>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51720
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

Currently, all MTD drivers/sublayers exposing an OOB area are
doing the same kind of test to extract the available OOB size
based on the mtd_info and mtd_oob_ops structures.
Move this common logic into an inline function and make use of it.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Suggested-by: Priit Laes <plaes@plaes.org>
---
 drivers/mtd/mtdpart.c              |  5 +----
 drivers/mtd/nand/nand_base.c       | 16 ++++------------
 drivers/mtd/onenand/onenand_base.c | 19 +++----------------
 include/linux/mtd/mtd.h            |  5 +++++
 4 files changed, 13 insertions(+), 32 deletions(-)

diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index 10bf304..08de4b2 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -126,10 +126,7 @@ static int part_read_oob(struct mtd_info *mtd, loff_t from,
 	if (ops->oobbuf) {
 		size_t len, pages;
 
-		if (ops->mode == MTD_OPS_AUTO_OOB)
-			len = mtd->oobavail;
-		else
-			len = mtd->oobsize;
+		len = mtd_oobavail(mtd, ops);
 		pages = mtd_div_by_ws(mtd->size, mtd);
 		pages -= mtd_div_by_ws(from, mtd);
 		if (ops->ooboffs + ops->ooblen > pages * len)
diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index 21c48ff..7f21719 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -1723,8 +1723,7 @@ static int nand_do_read_ops(struct mtd_info *mtd, loff_t from,
 	int ret = 0;
 	uint32_t readlen = ops->len;
 	uint32_t oobreadlen = ops->ooblen;
-	uint32_t max_oobsize = ops->mode == MTD_OPS_AUTO_OOB ?
-		mtd->oobavail : mtd->oobsize;
+	uint32_t max_oobsize = mtd_oobavail(mtd, ops);
 
 	uint8_t *bufpoi, *oob, *buf;
 	int use_bufpoi;
@@ -2075,10 +2074,7 @@ static int nand_do_read_oob(struct mtd_info *mtd, loff_t from,
 
 	stats = mtd->ecc_stats;
 
-	if (ops->mode == MTD_OPS_AUTO_OOB)
-		len = mtd->oobavail;
-	else
-		len = mtd->oobsize;
+	len = mtd_oobavail(mtd, ops);
 
 	if (unlikely(ops->ooboffs >= len)) {
 		pr_debug("%s: attempt to start read outside oob\n",
@@ -2575,8 +2571,7 @@ static int nand_do_write_ops(struct mtd_info *mtd, loff_t to,
 	uint32_t writelen = ops->len;
 
 	uint32_t oobwritelen = ops->ooblen;
-	uint32_t oobmaxlen = ops->mode == MTD_OPS_AUTO_OOB ?
-				mtd->oobavail : mtd->oobsize;
+	uint32_t oobmaxlen = mtd_oobavail(mtd, ops);
 
 	uint8_t *oob = ops->oobbuf;
 	uint8_t *buf = ops->datbuf;
@@ -2766,10 +2761,7 @@ static int nand_do_write_oob(struct mtd_info *mtd, loff_t to,
 	pr_debug("%s: to = 0x%08x, len = %i\n",
 			 __func__, (unsigned int)to, (int)ops->ooblen);
 
-	if (ops->mode == MTD_OPS_AUTO_OOB)
-		len = mtd->oobavail;
-	else
-		len = mtd->oobsize;
+	len = mtd_oobavail(mtd, ops);
 
 	/* Do not allow write past end of page */
 	if ((ops->ooboffs + ops->ooblen) > len) {
diff --git a/drivers/mtd/onenand/onenand_base.c b/drivers/mtd/onenand/onenand_base.c
index d70bbfd..03a80de 100644
--- a/drivers/mtd/onenand/onenand_base.c
+++ b/drivers/mtd/onenand/onenand_base.c
@@ -1124,11 +1124,7 @@ static int onenand_mlc_read_ops_nolock(struct mtd_info *mtd, loff_t from,
 	pr_debug("%s: from = 0x%08x, len = %i\n", __func__, (unsigned int)from,
 			(int)len);
 
-	if (ops->mode == MTD_OPS_AUTO_OOB)
-		oobsize = mtd->oobavail;
-	else
-		oobsize = mtd->oobsize;
-
+	oobsize = mtd_oobavail(mtd, ops);
 	oobcolumn = from & (mtd->oobsize - 1);
 
 	/* Do not allow reads past end of device */
@@ -1229,11 +1225,7 @@ static int onenand_read_ops_nolock(struct mtd_info *mtd, loff_t from,
 	pr_debug("%s: from = 0x%08x, len = %i\n", __func__, (unsigned int)from,
 			(int)len);
 
-	if (ops->mode == MTD_OPS_AUTO_OOB)
-		oobsize = mtd->oobavail;
-	else
-		oobsize = mtd->oobsize;
-
+	oobsize = mtd_oobavail(mtd, ops);
 	oobcolumn = from & (mtd->oobsize - 1);
 
 	/* Do not allow reads past end of device */
@@ -1885,12 +1877,7 @@ static int onenand_write_ops_nolock(struct mtd_info *mtd, loff_t to,
 	/* Check zero length */
 	if (!len)
 		return 0;
-
-	if (ops->mode == MTD_OPS_AUTO_OOB)
-		oobsize = mtd->oobavail;
-	else
-		oobsize = mtd->oobsize;
-
+	oobsize = mtd_oobavail(mtd, ops);
 	oobcolumn = to & (mtd->oobsize - 1);
 
 	column = to & (mtd->writesize - 1);
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 9cf13c4..7712721 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -264,6 +264,11 @@ static inline struct device_node *mtd_get_of_node(struct mtd_info *mtd)
 	return mtd->dev.of_node;
 }
 
+static inline int mtd_oobavail(struct mtd_info *mtd, struct mtd_oob_ops *ops)
+{
+	return ops->mode == MTD_OPS_AUTO_OOB ? mtd->oobavail : mtd->oobsize;
+}
+
 int mtd_erase(struct mtd_info *mtd, struct erase_info *instr);
 int mtd_point(struct mtd_info *mtd, loff_t from, size_t len, size_t *retlen,
 	      void **virt, resource_size_t *phys);
-- 
2.1.4
