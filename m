Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Feb 2016 02:04:09 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:37442 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27014916AbcBZBBbpIKpb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Feb 2016 02:01:31 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 114341FD6; Fri, 26 Feb 2016 02:01:26 +0100 (CET)
Received: from localhost.localdomain (unknown [208.66.31.210])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 973334B1;
        Fri, 26 Feb 2016 02:00:16 +0100 (CET)
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
Subject: [PATCH v3 19/52] mtd: create an mtd_ooblayout_ops struct to ease ECC layout definition
Date:   Fri, 26 Feb 2016 01:57:27 +0100
Message-Id: <1456448280-27788-20-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1456448280-27788-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1456448280-27788-1-git-send-email-boris.brezillon@free-electrons.com>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52293
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

ECC layout definitions are currently exposed using the nand_ecclayout
struct which embeds oobfree and eccpos arrays with predefined size.
This approach was acceptable when NAND chips were providing relatively
small OOB regions, but MLC and TLC now provide OOB regions of several
hundreds of bytes, which implies a non negligible overhead for everybody
even those who only need to support legacy NANDs.

Create an mtd_ooblayout_ops interface providing the same functionality
(expose the ECC and oobfree layout) without the need for this huge
structure.

The mtd->ecclayout is now deprecated and should be replaced by the
equivalent mtd_ooblayout_ops. In the meantime we provide a wrapper around
the ->ecclayout field to ease migration to this new model.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/mtdchar.c   |   4 +-
 drivers/mtd/mtdconcat.c |   2 +-
 drivers/mtd/mtdcore.c   | 165 +++++++++++++++++++++++++++++++++++-------------
 drivers/mtd/mtdpart.c   |  23 ++++++-
 include/linux/mtd/mtd.h |  32 ++++++++--
 5 files changed, 174 insertions(+), 52 deletions(-)

diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index cd64ab7..3fad2c7 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -888,7 +888,7 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
 	{
 		struct nand_oobinfo oi;
 
-		if (!mtd->ecclayout)
+		if (!mtd->ooblayout)
 			return -EOPNOTSUPP;
 
 		ret = get_oobinfo(mtd, &oi);
@@ -982,7 +982,7 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
 	{
 		struct nand_ecclayout_user *usrlay;
 
-		if (!mtd->ecclayout)
+		if (!mtd->ooblayout)
 			return -EOPNOTSUPP;
 
 		usrlay = kmalloc(sizeof(*usrlay), GFP_KERNEL);
diff --git a/drivers/mtd/mtdconcat.c b/drivers/mtd/mtdconcat.c
index 481565e..d573606 100644
--- a/drivers/mtd/mtdconcat.c
+++ b/drivers/mtd/mtdconcat.c
@@ -777,7 +777,7 @@ struct mtd_info *mtd_concat_create(struct mtd_info *subdev[],	/* subdevices to c
 
 	}
 
-	mtd_set_ecclayout(&concat->mtd, subdev[0]->ecclayout);
+	mtd_set_ooblayout(&concat->mtd, subdev[0]->ooblayout);
 
 	concat->num_subdev = num_devs;
 	concat->mtd.name = name;
diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index ab3a7b6..3b1dc09 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -1016,49 +1016,15 @@ EXPORT_SYMBOL_GPL(mtd_read_oob);
 int mtd_ooblayout_ecc(struct mtd_info *mtd, int section,
 		      struct mtd_oob_region *oobecc)
 {
-	int eccbyte = 0, cursection = 0, length = 0, eccpos = 0;
-
 	memset(oobecc, 0, sizeof(*oobecc));
 
 	if (!mtd || section < 0)
 		return -EINVAL;
 
-	if (!mtd->ecclayout)
+	if (!mtd->ooblayout || !mtd->ooblayout->ecc)
 		return -ENOTSUPP;
 
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
+	return mtd->ooblayout->ecc(mtd, section, oobecc);
 }
 EXPORT_SYMBOL_GPL(mtd_ooblayout_ecc);
 
@@ -1087,16 +1053,10 @@ int mtd_ooblayout_free(struct mtd_info *mtd, int section,
 	if (!mtd || section < 0)
 		return -EINVAL;
 
-	if (!mtd->ecclayout)
+	if (!mtd->ooblayout || !mtd->ooblayout->free)
 		return -ENOTSUPP;
 
-	if (section >= MTD_MAX_OOBFREE_ENTRIES_LARGE)
-		return -ERANGE;
-
-	oobfree->offset = mtd->ecclayout->oobfree[section].offset;
-	oobfree->length = mtd->ecclayout->oobfree[section].length;
-
-	return 0;
+	return mtd->ooblayout->free(mtd, section, oobfree);
 }
 EXPORT_SYMBOL_GPL(mtd_ooblayout_free);
 
@@ -1395,6 +1355,123 @@ int mtd_ooblayout_count_eccbytes(struct mtd_info *mtd)
 }
 EXPORT_SYMBOL_GPL(mtd_ooblayout_count_eccbytes);
 
+/**
+ * mtd_ecclayout_ecc - Default ooblayout_ecc iterator implementation
+ * @mtd: MTD device structure
+ * @section: ECC section. Depending on the layout you may have all the ECC
+ *	     bytes stored in a single contiguous section, or one section
+ *	     per ECC chunk (and sometime several sections for a single ECC
+ *	     ECC chunk)
+ * @oobecc: OOB region struct filled with the appropriate ECC position
+ *	    information
+ *
+ * This function is just a wrapper around the mtd->ecclayout field and is
+ * here to ease the transition to the mtd_ooblayout_ops approach.
+ * All it does is convert the layout->eccpos information into proper oob
+ * region definitions.
+ *
+ * Returns zero on success, a negative error code otherwise.
+ */
+static int mtd_ecclayout_ecc(struct mtd_info *mtd, int section,
+			     struct mtd_oob_region *oobecc)
+{
+	int eccbyte = 0, cursection = 0, length = 0, eccpos = 0;
+
+	if (!mtd->ecclayout)
+		return -ENOTSUPP;
+
+	/*
+	 * This logic allows us to reuse the ->ecclayout information and
+	 * expose them as ECC regions (as done for the OOB free regions).
+	 *
+	 * TODO: this should be dropped as soon as we get rid of the
+	 * ->ecclayout field.
+	 */
+	for (eccbyte = 0; eccbyte < mtd->ecclayout->eccbytes; eccbyte++) {
+		eccpos = mtd->ecclayout->eccpos[eccbyte];
+
+		if (eccbyte < mtd->ecclayout->eccbytes - 1) {
+			int neccpos = mtd->ecclayout->eccpos[eccbyte + 1];
+
+			if (eccpos + 1 == neccpos) {
+				length++;
+				continue;
+			}
+		}
+
+		if (section == cursection)
+			break;
+
+		length = 0;
+		cursection++;
+	}
+
+	if (cursection != section || eccbyte >= mtd->ecclayout->eccbytes)
+		return -ERANGE;
+
+	oobecc->length = length + 1;
+	oobecc->offset = eccpos - length;
+
+	return 0;
+}
+
+/**
+ * mtd_ecclayout_ecc - Default ooblayout_free iterator implementation
+ * @mtd: MTD device structure
+ * @section: Free section. Depending on the layout you may have all the free
+ *	     bytes stored in a single contiguous section, or one section
+ *	     per ECC chunk (and sometime several sections for a single ECC
+ *	     ECC chunk)
+ * @oobfree: OOB region struct filled with the appropriate free position
+ *	     information
+ *
+ * This function is just a wrapper around the mtd->ecclayout field and is
+ * here to ease the transition to the mtd_ooblayout_ops approach.
+ * All it does is convert the layout->oobfree information into proper oob
+ * region definitions.
+ *
+ * Returns zero on success, a negative error code otherwise.
+ */
+static int mtd_ecclayout_free(struct mtd_info *mtd, int section,
+			      struct mtd_oob_region *oobfree)
+{
+	struct nand_ecclayout *layout = mtd->ecclayout;
+
+	if (!layout)
+		return -ENOTSUPP;
+
+	if (section >= MTD_MAX_OOBFREE_ENTRIES_LARGE ||
+	    !layout->oobfree[section].length)
+		return -ERANGE;
+
+	oobfree->offset = layout->oobfree[section].offset;
+	oobfree->length = layout->oobfree[section].length;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops mtd_ecclayout_wrapper_ops = {
+	.ecc = mtd_ecclayout_ecc,
+	.free = mtd_ecclayout_free,
+};
+
+/**
+ * mtd_set_ecclayout - Attach an ecclayout to an MTD device
+ * @mtd: MTD device structure
+ * @ecclayout: The ecclayout to attach to the device
+ *
+ * Returns zero on success, a negative error code otherwise.
+ */
+void mtd_set_ecclayout(struct mtd_info *mtd, struct nand_ecclayout *ecclayout)
+{
+	if (!mtd || !ecclayout)
+		return;
+
+	mtd->ecclayout = ecclayout;
+	mtd_set_ooblayout(mtd, &mtd_ecclayout_wrapper_ops);
+}
+EXPORT_SYMBOL_GPL(mtd_set_ecclayout);
+
 /*
  * Method to access the protection register area, present in some flash
  * devices. The user data is one time programmable but the factory data is read
diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index f53d9d7..1f13e32 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -317,6 +317,27 @@ static int part_block_markbad(struct mtd_info *mtd, loff_t ofs)
 	return res;
 }
 
+static int part_ooblayout_ecc(struct mtd_info *mtd, int section,
+			      struct mtd_oob_region *oobregion)
+{
+	struct mtd_part *part = mtd_to_part(mtd);
+
+	return mtd_ooblayout_ecc(part->master, section, oobregion);
+}
+
+static int part_ooblayout_free(struct mtd_info *mtd, int section,
+			       struct mtd_oob_region *oobregion)
+{
+	struct mtd_part *part = mtd_to_part(mtd);
+
+	return mtd_ooblayout_free(part->master, section, oobregion);
+}
+
+static const struct mtd_ooblayout_ops part_ooblayout_ops = {
+	.ecc = part_ooblayout_ecc,
+	.free = part_ooblayout_free,
+};
+
 static inline void free_partition(struct mtd_part *p)
 {
 	kfree(p->mtd.name);
@@ -533,7 +554,7 @@ static struct mtd_part *allocate_partition(struct mtd_info *master,
 			part->name);
 	}
 
-	mtd_set_ecclayout(&slave->mtd, master->ecclayout);
+	mtd_set_ooblayout(&slave->mtd, &part_ooblayout_ops);
 	slave->mtd.ecc_step_size = master->ecc_step_size;
 	slave->mtd.ecc_strength = master->ecc_strength;
 	slave->mtd.bitflip_threshold = master->bitflip_threshold;
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 6250dd8..a38fe9a 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -101,6 +101,9 @@ struct mtd_oob_ops {
  * similar, smaller struct nand_ecclayout_user (in mtd-abi.h) that is retained
  * for export to user-space via the ECCGETLAYOUT ioctl.
  * nand_ecclayout should be expandable in the future simply by the above macros.
+ *
+ * This structure is now deprecated, you should use struct nand_ecclayout_ops
+ * to describe your OOB layout.
  */
 struct nand_ecclayout {
 	__u32 eccbytes;
@@ -123,6 +126,22 @@ struct mtd_oob_region {
 	u32 length;
 };
 
+/*
+ * struct mtd_ooblayout_ops - NAND OOB layout operations
+ * @ecc: function returning an ECC region in the OOB area.
+ *	 Should return -ERANGE if %section exceeds the total number of
+ *	 ECC sections.
+ * @free: function returning a free region in the OOB area.
+ *	  Should return -ERANGE if %section exceeds the total number of
+ *	  free sections.
+ */
+struct mtd_ooblayout_ops {
+	int (*ecc)(struct mtd_info *mtd, int section,
+		   struct mtd_oob_region *oobecc);
+	int (*free)(struct mtd_info *mtd, int section,
+		    struct mtd_oob_region *oobfree);
+};
+
 struct module;	/* only needed for owner field in mtd_info */
 
 struct mtd_info {
@@ -181,9 +200,12 @@ struct mtd_info {
 	const char *name;
 	int index;
 
-	/* ECC layout structure pointer - read only! */
+	/* [Deprecated] ECC layout structure pointer - read only! */
 	struct nand_ecclayout *ecclayout;
 
+	/* OOB layout description */
+	const struct mtd_ooblayout_ops *ooblayout;
+
 	/* the ecc step size. */
 	unsigned int ecc_step_size;
 
@@ -286,10 +308,12 @@ int mtd_ooblayout_set_databytes(struct mtd_info *mtd, const u8 *databuf,
 int mtd_ooblayout_count_freebytes(struct mtd_info *mtd);
 int mtd_ooblayout_count_eccbytes(struct mtd_info *mtd);
 
-static inline void mtd_set_ecclayout(struct mtd_info *mtd,
-				     struct nand_ecclayout *ecclayout)
+void mtd_set_ecclayout(struct mtd_info *mtd, struct nand_ecclayout *ecclayout);
+
+static inline void mtd_set_ooblayout(struct mtd_info *mtd,
+				     const struct mtd_ooblayout_ops *ooblayout)
 {
-	mtd->ecclayout = ecclayout;
+	mtd->ooblayout = ooblayout;
 }
 
 static inline void mtd_set_of_node(struct mtd_info *mtd,
-- 
2.1.4
