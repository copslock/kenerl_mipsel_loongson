Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Mar 2016 11:02:39 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:39175 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27013181AbcCGJwavktJS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Mar 2016 10:52:30 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id E13AE28DF; Mon,  7 Mar 2016 10:52:22 +0100 (CET)
Received: from localhost.localdomain (AToulouse-657-1-1129-172.w92-156.abo.wanadoo.fr [92.156.51.172])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 7774528AC;
        Mon,  7 Mar 2016 10:48:37 +0100 (CET)
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
Subject: [PATCH v4 52/52] mtd: kill the nand_ecclayout struct
Date:   Mon,  7 Mar 2016 10:47:42 +0100
Message-Id: <1457344062-11633-53-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1457344062-11633-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1457344062-11633-1-git-send-email-boris.brezillon@free-electrons.com>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52539
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

Now that all MTD drivers have moved to the mtd_ooblayout_ops model we can
safely remove the struct nand_ecclayout definition, and all the remaining
places where it was still used.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/mtdchar.c      |  12 ++---
 drivers/mtd/mtdcore.c      | 117 ---------------------------------------------
 include/linux/mtd/mtd.h    |  20 --------
 include/uapi/mtd/mtd-abi.h |   2 +-
 4 files changed, 7 insertions(+), 144 deletions(-)

diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index 3fad2c7..2a47a3f 100644
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
index bebca51..cbfa5ad 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -1357,123 +1357,6 @@ int mtd_ooblayout_count_eccbytes(struct mtd_info *mtd)
 }
 EXPORT_SYMBOL_GPL(mtd_ooblayout_count_eccbytes);
 
-/**
- * mtd_ecclayout_ecc - Default ooblayout_ecc iterator implementation
- * @mtd: MTD device structure
- * @section: ECC section. Depending on the layout you may have all the ECC
- *	     bytes stored in a single contiguous section, or one section
- *	     per ECC chunk (and sometime several sections for a single ECC
- *	     ECC chunk)
- * @oobecc: OOB region struct filled with the appropriate ECC position
- *	    information
- *
- * This function is just a wrapper around the mtd->ecclayout field and is
- * here to ease the transition to the mtd_ooblayout_ops approach.
- * All it does is convert the layout->eccpos information into proper oob
- * region definitions.
- *
- * Returns zero on success, a negative error code otherwise.
- */
-static int mtd_ecclayout_ecc(struct mtd_info *mtd, int section,
-			     struct mtd_oob_region *oobecc)
-{
-	int eccbyte = 0, cursection = 0, length = 0, eccpos = 0;
-
-	if (!mtd->ecclayout)
-		return -ENOTSUPP;
-
-	/*
-	 * This logic allows us to reuse the ->ecclayout information and
-	 * expose them as ECC regions (as done for the OOB free regions).
-	 *
-	 * TODO: this should be dropped as soon as we get rid of the
-	 * ->ecclayout field.
-	 */
-	for (eccbyte = 0; eccbyte < mtd->ecclayout->eccbytes; eccbyte++) {
-		eccpos = mtd->ecclayout->eccpos[eccbyte];
-
-		if (eccbyte < mtd->ecclayout->eccbytes - 1) {
-			int neccpos = mtd->ecclayout->eccpos[eccbyte + 1];
-
-			if (eccpos + 1 == neccpos) {
-				length++;
-				continue;
-			}
-		}
-
-		if (section == cursection)
-			break;
-
-		length = 0;
-		cursection++;
-	}
-
-	if (cursection != section || eccbyte >= mtd->ecclayout->eccbytes)
-		return -ERANGE;
-
-	oobecc->length = length + 1;
-	oobecc->offset = eccpos - length;
-
-	return 0;
-}
-
-/**
- * mtd_ecclayout_ecc - Default ooblayout_free iterator implementation
- * @mtd: MTD device structure
- * @section: Free section. Depending on the layout you may have all the free
- *	     bytes stored in a single contiguous section, or one section
- *	     per ECC chunk (and sometime several sections for a single ECC
- *	     ECC chunk)
- * @oobfree: OOB region struct filled with the appropriate free position
- *	     information
- *
- * This function is just a wrapper around the mtd->ecclayout field and is
- * here to ease the transition to the mtd_ooblayout_ops approach.
- * All it does is convert the layout->oobfree information into proper oob
- * region definitions.
- *
- * Returns zero on success, a negative error code otherwise.
- */
-static int mtd_ecclayout_free(struct mtd_info *mtd, int section,
-			      struct mtd_oob_region *oobfree)
-{
-	struct nand_ecclayout *layout = mtd->ecclayout;
-
-	if (!layout)
-		return -ENOTSUPP;
-
-	if (section >= MTD_MAX_OOBFREE_ENTRIES_LARGE ||
-	    !layout->oobfree[section].length)
-		return -ERANGE;
-
-	oobfree->offset = layout->oobfree[section].offset;
-	oobfree->length = layout->oobfree[section].length;
-
-	return 0;
-}
-
-static const struct mtd_ooblayout_ops mtd_ecclayout_wrapper_ops = {
-	.ecc = mtd_ecclayout_ecc,
-	.free = mtd_ecclayout_free,
-};
-
-/**
- * mtd_set_ecclayout - Attach an ecclayout to an MTD device
- * @mtd: MTD device structure
- * @ecclayout: The ecclayout to attach to the device
- *
- * Returns zero on success, a negative error code otherwise.
- */
-void mtd_set_ecclayout(struct mtd_info *mtd, struct nand_ecclayout *ecclayout)
-{
-	if (!mtd || !ecclayout)
-		return;
-
-	mtd->ecclayout = ecclayout;
-	mtd_set_ooblayout(mtd, &mtd_ecclayout_wrapper_ops);
-}
-EXPORT_SYMBOL_GPL(mtd_set_ecclayout);
-
 /*
  * Method to access the protection register area, present in some flash
  * devices. The user data is one time programmable but the factory data is read
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index a38fe9a..df8c116 100644
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
  * struct mtd_oob_region - oob region definition
  * @offset: region offset
@@ -200,9 +185,6 @@ struct mtd_info {
 	const char *name;
 	int index;
 
-	/* [Deprecated] ECC layout structure pointer - read only! */
-	struct nand_ecclayout *ecclayout;
-
 	/* OOB layout description */
 	const struct mtd_ooblayout_ops *ooblayout;
 
@@ -308,8 +290,6 @@ int mtd_ooblayout_set_databytes(struct mtd_info *mtd, const u8 *databuf,
 int mtd_ooblayout_count_freebytes(struct mtd_info *mtd);
 int mtd_ooblayout_count_eccbytes(struct mtd_info *mtd);
 
-void mtd_set_ecclayout(struct mtd_info *mtd, struct nand_ecclayout *ecclayout);
-
 static inline void mtd_set_ooblayout(struct mtd_info *mtd,
 				     const struct mtd_ooblayout_ops *ooblayout)
 {
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
