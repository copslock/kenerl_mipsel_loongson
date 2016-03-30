Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2016 18:16:02 +0200 (CEST)
Received: from down.free-electrons.com ([37.187.137.238]:41567 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27025904AbcC3QP3TzFUN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Mar 2016 18:15:29 +0200
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 779EF182A; Wed, 30 Mar 2016 18:15:18 +0200 (CEST)
Received: from localhost.localdomain (LMontsouris-657-1-184-87.w90-63.abo.wanadoo.fr [90.63.216.87])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 9B73521C;
        Wed, 30 Mar 2016 18:15:07 +0200 (CEST)
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
Subject: [PATCH v5 02/50] mtd: use mtd_ooblayout_xxx() helpers where appropriate
Date:   Wed, 30 Mar 2016 18:14:17 +0200
Message-Id: <1459354505-32551-3-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52746
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
 drivers/mtd/mtdchar.c | 107 +++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 88 insertions(+), 19 deletions(-)

diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index 6d19835..cd64ab7 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -472,28 +472,101 @@ static int mtdchar_readoob(struct file *file, struct mtd_info *mtd,
  * nand_ecclayout flexibly (i.e. the struct may change size in new
  * releases without requiring major rewrites).
  */
-static int shrink_ecclayout(const struct nand_ecclayout *from,
-		struct nand_ecclayout_user *to)
+static int shrink_ecclayout(struct mtd_info *mtd,
+			    struct nand_ecclayout_user *to)
 {
-	int i;
+	struct mtd_oob_region oobregion;
+	int i, section = 0, ret;
 
-	if (!from || !to)
+	if (!mtd || !to)
 		return -EINVAL;
 
 	memset(to, 0, sizeof(*to));
 
-	to->eccbytes = min((int)from->eccbytes, MTD_MAX_ECCPOS_ENTRIES);
-	for (i = 0; i < to->eccbytes; i++)
-		to->eccpos[i] = from->eccpos[i];
+	to->eccbytes = 0;
+	for (i = 0; i < MTD_MAX_ECCPOS_ENTRIES;) {
+		u32 eccpos;
+
+		ret = mtd_ooblayout_ecc(mtd, section, &oobregion);
+		if (ret < 0) {
+			if (ret != -ERANGE)
+				return ret;
+
+			break;
+		}
+
+		eccpos = oobregion.offset;
+		for (; i < MTD_MAX_ECCPOS_ENTRIES &&
+		       eccpos < oobregion.offset + oobregion.length; i++) {
+			to->eccpos[i] = eccpos++;
+			to->eccbytes++;
+		}
+	}
 
 	for (i = 0; i < MTD_MAX_OOBFREE_ENTRIES; i++) {
-		if (from->oobfree[i].length == 0 &&
-				from->oobfree[i].offset == 0)
+		ret = mtd_ooblayout_free(mtd, i, &oobregion);
+		if (ret < 0) {
+			if (ret != -ERANGE)
+				return ret;
+
+			break;
+		}
+
+		to->oobfree[i].offset = oobregion.offset;
+		to->oobfree[i].length = oobregion.length;
+		to->oobavail += to->oobfree[i].length;
+	}
+
+	return 0;
+}
+
+static int get_oobinfo(struct mtd_info *mtd, struct nand_oobinfo *to)
+{
+	struct mtd_oob_region oobregion;
+	int i, section = 0, ret;
+
+	if (!mtd || !to)
+		return -EINVAL;
+
+	memset(to, 0, sizeof(*to));
+
+	to->eccbytes = 0;
+	for (i = 0; i < ARRAY_SIZE(to->eccpos);) {
+		u32 eccpos;
+
+		ret = mtd_ooblayout_ecc(mtd, section, &oobregion);
+		if (ret < 0) {
+			if (ret != -ERANGE)
+				return ret;
+
 			break;
-		to->oobavail += from->oobfree[i].length;
-		to->oobfree[i] = from->oobfree[i];
+		}
+
+		if (oobregion.length + i > ARRAY_SIZE(to->eccpos))
+			return -EINVAL;
+
+		eccpos = oobregion.offset;
+		for (; eccpos < oobregion.offset + oobregion.length; i++) {
+			to->eccpos[i] = eccpos++;
+			to->eccbytes++;
+		}
 	}
 
+	for (i = 0; i < 8; i++) {
+		ret = mtd_ooblayout_free(mtd, i, &oobregion);
+		if (ret < 0) {
+			if (ret != -ERANGE)
+				return ret;
+
+			break;
+		}
+
+		to->oobfree[i][0] = oobregion.offset;
+		to->oobfree[i][1] = oobregion.length;
+	}
+
+	to->useecc = MTD_NANDECC_AUTOPLACE;
+
 	return 0;
 }
 
@@ -817,14 +890,10 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
 
 		if (!mtd->ecclayout)
 			return -EOPNOTSUPP;
-		if (mtd->ecclayout->eccbytes > ARRAY_SIZE(oi.eccpos))
-			return -EINVAL;
 
-		oi.useecc = MTD_NANDECC_AUTOPLACE;
-		memcpy(&oi.eccpos, mtd->ecclayout->eccpos, sizeof(oi.eccpos));
-		memcpy(&oi.oobfree, mtd->ecclayout->oobfree,
-		       sizeof(oi.oobfree));
-		oi.eccbytes = mtd->ecclayout->eccbytes;
+		ret = get_oobinfo(mtd, &oi);
+		if (ret)
+			return ret;
 
 		if (copy_to_user(argp, &oi, sizeof(struct nand_oobinfo)))
 			return -EFAULT;
@@ -920,7 +989,7 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
 		if (!usrlay)
 			return -ENOMEM;
 
-		shrink_ecclayout(mtd->ecclayout, usrlay);
+		shrink_ecclayout(mtd, usrlay);
 
 		if (copy_to_user(argp, usrlay, sizeof(*usrlay)))
 			ret = -EFAULT;
-- 
2.5.0
