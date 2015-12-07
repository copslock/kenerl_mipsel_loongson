Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Dec 2015 23:33:38 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:56158 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27013339AbbLGW2EjuXdg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Dec 2015 23:28:04 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 401831B09; Mon,  7 Dec 2015 23:27:57 +0100 (CET)
Received: from localhost.localdomain (unknown [37.160.132.173])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 33FBC1783;
        Mon,  7 Dec 2015 23:27:47 +0100 (CET)
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
        Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH 23/23] mtd: kill the nand_ecclayout struct
Date:   Mon,  7 Dec 2015 23:26:18 +0100
Message-Id: <1449527178-5930-24-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50402
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

Now that all mtd drivers have moved to the mtd_ooblayout_ops model we can
safely remove the struct nand_ecclayout definition, and all the remaining
places where it was still used.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/mtdchar.c      | 12 ++++++------
 drivers/mtd/mtdcore.c      | 44 --------------------------------------------
 include/linux/mtd/mtd.h    | 20 --------------------
 include/uapi/mtd/mtd-abi.h |  2 +-
 4 files changed, 7 insertions(+), 71 deletions(-)

diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index c03b678..322e838 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -465,12 +465,12 @@ static int mtdchar_readoob(struct file *file, struct mtd_info *mtd,
 }
 
 /*
- * Copies (and truncates, if necessary) data from the larger struct,
- * nand_ecclayout, to the smaller, deprecated layout struct,
- * nand_ecclayout_user. This is necessary only to support the deprecated
- * API ioctl ECCGETLAYOUT while allowing all new functionality to use
- * nand_ecclayout flexibly (i.e. the struct may change size in new
- * releases without requiring major rewrites).
+ * Copies (and truncates, if necessary) OOB layout information to the
+ * deprecated layout struct, nand_ecclayout_user. This is necessary only to
+ * support the deprecated API ioctl ECCGETLAYOUT while allowing all new
+ * functionality to use mtd_ooblayout_ops flexibly (i.e. mtd_ooblayout_ops
+ * can describe any kind of OOB layout with almost zero overhead from a
+ * memory usage point of view).
  */
 static int shrink_ecclayout(struct mtd_info *mtd,
 			    struct nand_ecclayout_user *to)
diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index d87f3621..62f83b0 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -833,50 +833,6 @@ void __put_mtd_device(struct mtd_info *mtd)
 }
 EXPORT_SYMBOL_GPL(__put_mtd_device);
 
-static int nand_ecclayout_eccpos(struct mtd_info *mtd, int eccbyte)
-{
-	struct nand_ecclayout *layout = mtd->ecclayout;
-
-	if (!layout)
-		return -ENOTSUPP;
-
-	if (eccbyte >= layout->eccbytes)
-		return -ERANGE;
-
-	return layout->eccpos[eccbyte];
-}
-
-static int nand_ecclayout_oobfree(struct mtd_info *mtd, int section,
-				  struct nand_oobfree *oobfree)
-{
-	struct nand_ecclayout *layout = mtd->ecclayout;
-
-	if (!layout)
-		return -ENOTSUPP;
-
-	if (section >= MTD_MAX_OOBFREE_ENTRIES_LARGE)
-		return -ERANGE;
-
-	*oobfree = layout->oobfree[section];
-
-	return 0;
-}
-
-static const struct mtd_ooblayout_ops nand_ecclayout_ops = {
-	.eccpos = nand_ecclayout_eccpos,
-	.oobfree = nand_ecclayout_oobfree,
-};
-
-void mtd_set_ecclayout(struct mtd_info *mtd, struct nand_ecclayout *ecclayout)
-{
-	if (!mtd || !ecclayout)
-		return;
-
-	mtd->ecclayout = ecclayout;
-	mtd_set_ooblayout(mtd, &nand_ecclayout_ops);
-}
-EXPORT_SYMBOL_GPL(mtd_set_ecclayout);
-
 /*
  * Erase is an asynchronous operation.  Device drivers are supposed
  * to call instr->callback() whenever the operation completes, even
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 9c3699b..3a4bab7 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -96,21 +96,6 @@ struct mtd_oob_ops {
 
 #define MTD_MAX_OOBFREE_ENTRIES_LARGE	32
 #define MTD_MAX_ECCPOS_ENTRIES_LARGE	640
-/*
- * Internal ECC layout control structure. For historical reasons, there is a
- * similar, smaller struct nand_ecclayout_user (in mtd-abi.h) that is retained
- * for export to user-space via the ECCGETLAYOUT ioctl.
- * nand_ecclayout should be expandable in the future simply by the above macros.
- *
- * This structure is now deprecated, you should use struct nand_ecclayout_ops
- * to describe your OOB layout.
- */
-struct nand_ecclayout {
-	__u32 eccbytes;
-	__u32 eccpos[MTD_MAX_ECCPOS_ENTRIES_LARGE];
-	struct nand_oobfree oobfree[MTD_MAX_OOBFREE_ENTRIES_LARGE];
-};
-
 /**
  * struct mtd_ooblayout_ops - NAND OOB layout operations.
  *
@@ -183,9 +168,6 @@ struct mtd_info {
 	const char *name;
 	int index;
 
-	/* [Deprecated] ECC layout structure pointer - read only! */
-	struct nand_ecclayout *ecclayout;
-
 	/* OOB layout description */
 	const struct mtd_ooblayout_ops *ooblayout;
 
@@ -279,8 +261,6 @@ static inline void mtd_set_ooblayout(struct mtd_info *mtd,
 	mtd->ooblayout = ooblayout;
 }
 
-void mtd_set_ecclayout(struct mtd_info *mtd, struct nand_ecclayout *ecclayout);
-
 static inline int mtd_eccpos(struct mtd_info *mtd, int eccbyte)
 {
 	if (!mtd->ooblayout || !mtd->ooblayout->eccpos)
diff --git a/include/uapi/mtd/mtd-abi.h b/include/uapi/mtd/mtd-abi.h
index 763bb69..0ec1da2 100644
--- a/include/uapi/mtd/mtd-abi.h
+++ b/include/uapi/mtd/mtd-abi.h
@@ -228,7 +228,7 @@ struct nand_oobfree {
  * complete set of ECC information. The ioctl truncates the larger internal
  * structure to retain binary compatibility with the static declaration of the
  * ioctl. Note that the "MTD_MAX_..._ENTRIES" macros represent the max size of
- * the user struct, not the MAX size of the internal struct nand_ecclayout.
+ * the user struct, not the MAX size of the internal OOB layout representation.
  */
 struct nand_ecclayout_user {
 	__u32 eccbytes;
-- 
2.1.4
