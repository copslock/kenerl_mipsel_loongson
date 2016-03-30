Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2016 18:15:30 +0200 (CEST)
Received: from down.free-electrons.com ([37.187.137.238]:41566 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27025895AbcC3QP3OnNFN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Mar 2016 18:15:29 +0200
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id A9E331818; Wed, 30 Mar 2016 18:15:17 +0200 (CEST)
Received: from localhost.localdomain (LMontsouris-657-1-184-87.w90-63.abo.wanadoo.fr [90.63.216.87])
        by mail.free-electrons.com (Postfix) with ESMTPSA id C62F3141;
        Wed, 30 Mar 2016 18:15:06 +0200 (CEST)
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
Subject: [PATCH v5 01/50] mtd: add mtd_ooblayout_xxx() helper functions
Date:   Wed, 30 Mar 2016 18:14:16 +0200
Message-Id: <1459354505-32551-2-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52744
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

In order to make the ecclayout definition completely dynamic we need to
rework the way the OOB layout are defined and iterated.

Create a few mtd_ooblayout_xxx() helpers to ease OOB bytes manipulation
and hide ecclayout internals to their users.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/mtdcore.c   | 400 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mtd/mtd.h |  33 ++++
 2 files changed, 433 insertions(+)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 3096251..9fc278a 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -997,6 +997,406 @@ int mtd_read_oob(struct mtd_info *mtd, loff_t from, struct mtd_oob_ops *ops)
 }
 EXPORT_SYMBOL_GPL(mtd_read_oob);
 
+/**
+ * mtd_ooblayout_ecc - Get the OOB region definition of a specific ECC section
+ * @mtd: MTD device structure
+ * @section: ECC section. Depending on the layout you may have all the ECC
+ *	     bytes stored in a single contiguous section, or one section
+ *	     per ECC chunk (and sometime several sections for a single ECC
+ *	     ECC chunk)
+ * @oobecc: OOB region struct filled with the appropriate ECC position
+ *	    information
+ *
+ * This functions return ECC section information in the OOB area. I you want
+ * to get all the ECC bytes information, then you should call
+ * mtd_ooblayout_ecc(mtd, section++, oobecc) until it returns -ERANGE.
+ *
+ * Returns zero on success, a negative error code otherwise.
+ */
+int mtd_ooblayout_ecc(struct mtd_info *mtd, int section,
+		      struct mtd_oob_region *oobecc)
+{
+	int eccbyte = 0, cursection = 0, length = 0, eccpos = 0;
+
+	memset(oobecc, 0, sizeof(*oobecc));
+
+	if (!mtd || section < 0)
+		return -EINVAL;
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
+EXPORT_SYMBOL_GPL(mtd_ooblayout_ecc);
+
+/**
+ * mtd_ooblayout_free - Get the OOB region definition of a specific free
+ *			section
+ * @mtd: MTD device structure
+ * @section: Free section you are interested in. Depending on the layout
+ *	     you may have all the free bytes stored in a single contiguous
+ *	     section, or one section per ECC chunk plus an extra section
+ *	     for the remaining bytes (or other funky layout).
+ * @oobfree: OOB region struct filled with the appropriate free position
+ *	     information
+ *
+ * This functions return free bytes position in the OOB area. I you want
+ * to get all the free bytes information, then you should call
+ * mtd_ooblayout_free(mtd, section++, oobfree) until it returns -ERANGE.
+ *
+ * Returns zero on success, a negative error code otherwise.
+ */
+int mtd_ooblayout_free(struct mtd_info *mtd, int section,
+		       struct mtd_oob_region *oobfree)
+{
+	memset(oobfree, 0, sizeof(*oobfree));
+
+	if (!mtd || section < 0)
+		return -EINVAL;
+
+	if (!mtd->ecclayout)
+		return -ENOTSUPP;
+
+	if (section >= MTD_MAX_OOBFREE_ENTRIES_LARGE)
+		return -ERANGE;
+
+	oobfree->offset = mtd->ecclayout->oobfree[section].offset;
+	oobfree->length = mtd->ecclayout->oobfree[section].length;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mtd_ooblayout_free);
+
+/**
+ * mtd_ooblayout_find_region - Find the region attached to a specific byte
+ * @mtd: mtd info structure
+ * @byte: the byte we are searching for
+ * @sectionp: pointer where the section id will be stored
+ * @oobregion: used to retrieve the ECC position
+ * @iter: iterator function. Should be either mtd_ooblayout_free or
+ *	  mtd_ooblayout_ecc depending on the region type you're searching for
+ *
+ * This functions returns the section id and oobregion information of a
+ * specific byte. For example, say you want to know where the 4th ECC byte is
+ * stored, you'll use:
+ *
+ * mtd_ooblayout_find_region(mtd, 3, &section, &oobregion, mtd_ooblayout_ecc);
+ *
+ * Returns zero on success, a negative error code otherwise.
+ */
+static int mtd_ooblayout_find_region(struct mtd_info *mtd, int byte,
+				int *sectionp, struct mtd_oob_region *oobregion,
+				int (*iter)(struct mtd_info *,
+					    int section,
+					    struct mtd_oob_region *oobregion))
+{
+	int pos = 0, ret, section = 0;
+
+	memset(oobregion, 0, sizeof(*oobregion));
+
+	while (1) {
+		ret = iter(mtd, section, oobregion);
+		if (ret)
+			return ret;
+
+		if (pos + oobregion->length > byte)
+			break;
+
+		pos += oobregion->length;
+		section++;
+	}
+
+	/*
+	 * Adjust region info to make it start at the beginning at the
+	 * 'start' ECC byte.
+	 */
+	oobregion->offset += byte - pos;
+	oobregion->length -= byte - pos;
+	*sectionp = section;
+
+	return 0;
+}
+
+/**
+ * mtd_ooblayout_find_eccregion - Find the ECC region attached to a specific
+ *				  ECC byte
+ * @mtd: mtd info structure
+ * @eccbyte: the byte we are searching for
+ * @sectionp: pointer where the section id will be stored
+ * @oobregion: OOB region information
+ *
+ * Works like mtd_ooblayout_find_region() except it searches for a specific ECC
+ * byte.
+ *
+ * Returns zero on success, a negative error code otherwise.
+ */
+int mtd_ooblayout_find_eccregion(struct mtd_info *mtd, int eccbyte,
+				 int *section,
+				 struct mtd_oob_region *oobregion)
+{
+	return mtd_ooblayout_find_region(mtd, eccbyte, section, oobregion,
+					 mtd_ooblayout_ecc);
+}
+EXPORT_SYMBOL_GPL(mtd_ooblayout_find_eccregion);
+
+/**
+ * mtd_ooblayout_get_bytes - Extract OOB bytes from the oob buffer
+ * @mtd: mtd info structure
+ * @buf: destination buffer to store OOB bytes
+ * @oobbuf: OOB buffer
+ * @start: first byte to retrieve
+ * @nbytes: number of bytes to retrieve
+ * @iter: section iterator
+ *
+ * Extract bytes attached to a specific category (ECC or free)
+ * from the OOB buffer and copy them into buf.
+ *
+ * Returns zero on success, a negative error code otherwise.
+ */
+static int mtd_ooblayout_get_bytes(struct mtd_info *mtd, u8 *buf,
+				const u8 *oobbuf, int start, int nbytes,
+				int (*iter)(struct mtd_info *,
+					    int section,
+					    struct mtd_oob_region *oobregion))
+{
+	struct mtd_oob_region oobregion = { };
+	int section = 0, ret;
+
+	ret = mtd_ooblayout_find_region(mtd, start, &section,
+					&oobregion, iter);
+
+	while (!ret) {
+		int cnt;
+
+		cnt = oobregion.length > nbytes ? nbytes : oobregion.length;
+		memcpy(buf, oobbuf + oobregion.offset, cnt);
+		buf += cnt;
+		nbytes -= cnt;
+
+		if (!nbytes)
+			break;
+
+		ret = iter(mtd, ++section, &oobregion);
+	}
+
+	return ret;
+}
+
+/**
+ * mtd_ooblayout_set_bytes - put OOB bytes into the oob buffer
+ * @mtd: mtd info structure
+ * @buf: source buffer to get OOB bytes from
+ * @oobbuf: OOB buffer
+ * @start: first OOB byte to set
+ * @nbytes: number of OOB bytes to set
+ * @iter: section iterator
+ *
+ * Fill the OOB buffer with data provided in buf. The category (ECC or free)
+ * is selected by passing the appropriate iterator.
+ *
+ * Returns zero on success, a negative error code otherwise.
+ */
+static int mtd_ooblayout_set_bytes(struct mtd_info *mtd, const u8 *buf,
+				u8 *oobbuf, int start, int nbytes,
+				int (*iter)(struct mtd_info *,
+					    int section,
+					    struct mtd_oob_region *oobregion))
+{
+	struct mtd_oob_region oobregion = { };
+	int section = 0, ret;
+
+	ret = mtd_ooblayout_find_region(mtd, start, &section,
+					&oobregion, iter);
+
+	while (!ret) {
+		int cnt;
+
+		cnt = oobregion.length > nbytes ? nbytes : oobregion.length;
+		memcpy(oobbuf + oobregion.offset, buf, cnt);
+		buf += cnt;
+		nbytes -= cnt;
+
+		if (!nbytes)
+			break;
+
+		ret = iter(mtd, ++section, &oobregion);
+	}
+
+	return ret;
+}
+
+/**
+ * mtd_ooblayout_count_bytes - count the number of bytes in a OOB category
+ * @mtd: mtd info structure
+ * @iter: category iterator
+ *
+ * Count the number of bytes in a given category.
+ *
+ * Returns a positive value on success, a negative error code otherwise.
+ */
+static int mtd_ooblayout_count_bytes(struct mtd_info *mtd,
+				int (*iter)(struct mtd_info *,
+					    int section,
+					    struct mtd_oob_region *oobregion))
+{
+	struct mtd_oob_region oobregion = { };
+	int section = 0, ret, nbytes = 0;
+
+	while (1) {
+		ret = iter(mtd, section++, &oobregion);
+		if (ret) {
+			if (ret == -ERANGE)
+				ret = nbytes;
+			break;
+		}
+
+		nbytes += oobregion.length;
+	}
+
+	return ret;
+}
+
+/**
+ * mtd_ooblayout_get_eccbytes - extract ECC bytes from the oob buffer
+ * @mtd: mtd info structure
+ * @eccbuf: destination buffer to store ECC bytes
+ * @oobbuf: OOB buffer
+ * @start: first ECC byte to retrieve
+ * @nbytes: number of ECC bytes to retrieve
+ *
+ * Works like mtd_ooblayout_get_bytes(), except it acts on ECC bytes.
+ *
+ * Returns zero on success, a negative error code otherwise.
+ */
+int mtd_ooblayout_get_eccbytes(struct mtd_info *mtd, u8 *eccbuf,
+			       const u8 *oobbuf, int start, int nbytes)
+{
+	return mtd_ooblayout_get_bytes(mtd, eccbuf, oobbuf, start, nbytes,
+				       mtd_ooblayout_ecc);
+}
+EXPORT_SYMBOL_GPL(mtd_ooblayout_get_eccbytes);
+
+/**
+ * mtd_ooblayout_set_eccbytes - set ECC bytes into the oob buffer
+ * @mtd: mtd info structure
+ * @eccbuf: source buffer to get ECC bytes from
+ * @oobbuf: OOB buffer
+ * @start: first ECC byte to set
+ * @nbytes: number of ECC bytes to set
+ *
+ * Works like mtd_ooblayout_set_bytes(), except it acts on ECC bytes.
+ *
+ * Returns zero on success, a negative error code otherwise.
+ */
+int mtd_ooblayout_set_eccbytes(struct mtd_info *mtd, const u8 *eccbuf,
+			       u8 *oobbuf, int start, int nbytes)
+{
+	return mtd_ooblayout_set_bytes(mtd, eccbuf, oobbuf, start, nbytes,
+				       mtd_ooblayout_ecc);
+}
+EXPORT_SYMBOL_GPL(mtd_ooblayout_set_eccbytes);
+
+/**
+ * mtd_ooblayout_get_databytes - extract data bytes from the oob buffer
+ * @mtd: mtd info structure
+ * @databuf: destination buffer to store ECC bytes
+ * @oobbuf: OOB buffer
+ * @start: first ECC byte to retrieve
+ * @nbytes: number of ECC bytes to retrieve
+ *
+ * Works like mtd_ooblayout_get_bytes(), except it acts on free bytes.
+ *
+ * Returns zero on success, a negative error code otherwise.
+ */
+int mtd_ooblayout_get_databytes(struct mtd_info *mtd, u8 *databuf,
+				const u8 *oobbuf, int start, int nbytes)
+{
+	return mtd_ooblayout_get_bytes(mtd, databuf, oobbuf, start, nbytes,
+				       mtd_ooblayout_free);
+}
+EXPORT_SYMBOL_GPL(mtd_ooblayout_get_databytes);
+
+/**
+ * mtd_ooblayout_get_eccbytes - set data bytes into the oob buffer
+ * @mtd: mtd info structure
+ * @eccbuf: source buffer to get data bytes from
+ * @oobbuf: OOB buffer
+ * @start: first ECC byte to set
+ * @nbytes: number of ECC bytes to set
+ *
+ * Works like mtd_ooblayout_get_bytes(), except it acts on free bytes.
+ *
+ * Returns zero on success, a negative error code otherwise.
+ */
+int mtd_ooblayout_set_databytes(struct mtd_info *mtd, const u8 *databuf,
+				u8 *oobbuf, int start, int nbytes)
+{
+	return mtd_ooblayout_set_bytes(mtd, databuf, oobbuf, start, nbytes,
+				       mtd_ooblayout_free);
+}
+EXPORT_SYMBOL_GPL(mtd_ooblayout_set_databytes);
+
+/**
+ * mtd_ooblayout_count_freebytes - count the number of free bytes in OOB
+ * @mtd: mtd info structure
+ *
+ * Works like mtd_ooblayout_count_bytes(), except it count free bytes.
+ *
+ * Returns zero on success, a negative error code otherwise.
+ */
+int mtd_ooblayout_count_freebytes(struct mtd_info *mtd)
+{
+	return mtd_ooblayout_count_bytes(mtd, mtd_ooblayout_free);
+}
+EXPORT_SYMBOL_GPL(mtd_ooblayout_count_freebytes);
+
+/**
+ * mtd_ooblayout_count_freebytes - count the number of ECC bytes in OOB
+ * @mtd: mtd info structure
+ *
+ * Works like mtd_ooblayout_count_bytes(), except it count ECC bytes.
+ *
+ * Returns zero on success, a negative error code otherwise.
+ */
+int mtd_ooblayout_count_eccbytes(struct mtd_info *mtd)
+{
+	return mtd_ooblayout_count_bytes(mtd, mtd_ooblayout_ecc);
+}
+EXPORT_SYMBOL_GPL(mtd_ooblayout_count_eccbytes);
+
 /*
  * Method to access the protection register area, present in some flash
  * devices. The user data is one time programmable but the factory data is read
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 7712721..b141f26 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -108,6 +108,21 @@ struct nand_ecclayout {
 	struct nand_oobfree oobfree[MTD_MAX_OOBFREE_ENTRIES_LARGE];
 };
 
+/**
+ * struct mtd_oob_region - oob region definition
+ * @offset: region offset
+ * @length: region length
+ *
+ * This structure describes a region of the OOB area, and is used
+ * to retrieve ECC or free bytes sections.
+ * Each section is defined by an offset within the OOB area and a
+ * length.
+ */
+struct mtd_oob_region {
+	u32 offset;
+	u32 length;
+};
+
 struct module;	/* only needed for owner field in mtd_info */
 
 struct mtd_info {
@@ -253,6 +268,24 @@ struct mtd_info {
 	int usecount;
 };
 
+int mtd_ooblayout_ecc(struct mtd_info *mtd, int section,
+		      struct mtd_oob_region *oobecc);
+int mtd_ooblayout_find_eccregion(struct mtd_info *mtd, int eccbyte,
+				 int *section,
+				 struct mtd_oob_region *oobregion);
+int mtd_ooblayout_get_eccbytes(struct mtd_info *mtd, u8 *eccbuf,
+			       const u8 *oobbuf, int start, int nbytes);
+int mtd_ooblayout_set_eccbytes(struct mtd_info *mtd, const u8 *eccbuf,
+			       u8 *oobbuf, int start, int nbytes);
+int mtd_ooblayout_free(struct mtd_info *mtd, int section,
+		       struct mtd_oob_region *oobfree);
+int mtd_ooblayout_get_databytes(struct mtd_info *mtd, u8 *databuf,
+				const u8 *oobbuf, int start, int nbytes);
+int mtd_ooblayout_set_databytes(struct mtd_info *mtd, const u8 *databuf,
+				u8 *oobbuf, int start, int nbytes);
+int mtd_ooblayout_count_freebytes(struct mtd_info *mtd);
+int mtd_ooblayout_count_eccbytes(struct mtd_info *mtd);
+
 static inline void mtd_set_of_node(struct mtd_info *mtd,
 				   struct device_node *np)
 {
-- 
2.5.0
