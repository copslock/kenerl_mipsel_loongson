Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Sep 2018 00:42:58 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:35919 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994660AbeIFWjkYUkJL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 7 Sep 2018 00:39:40 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E01BD208A1; Fri,  7 Sep 2018 00:39:29 +0200 (CEST)
Received: from localhost.localdomain (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 11C20208D6;
        Fri,  7 Sep 2018 00:39:19 +0200 (CEST)
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Ryan Mallon <rmallon@gmail.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        Alexander Clouter <alex@digriz.org.uk>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Subject: [PATCH 18/19] mtd: rawnand: Move ONFI code to nand_onfi.c
Date:   Fri,  7 Sep 2018 00:38:50 +0200
Message-Id: <20180906223851.6964-19-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180906223851.6964-1-boris.brezillon@bootlin.com>
References: <20180906223851.6964-1-boris.brezillon@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <boris.brezillon@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66119
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: boris.brezillon@bootlin.com
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

This moves ONFI related code to nand_onfi.c and ONFI related
struct/macros to include/linux/mtd/onfi.h.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/Makefile    |   1 +
 drivers/mtd/nand/raw/internals.h |   7 +
 drivers/mtd/nand/raw/nand_base.c | 296 +------------------------------------
 drivers/mtd/nand/raw/nand_onfi.c | 305 +++++++++++++++++++++++++++++++++++++++
 include/linux/mtd/onfi.h         | 178 +++++++++++++++++++++++
 include/linux/mtd/rawnand.h      | 164 +--------------------
 6 files changed, 496 insertions(+), 455 deletions(-)
 create mode 100644 drivers/mtd/nand/raw/nand_onfi.c
 create mode 100644 include/linux/mtd/onfi.h

diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index 78f67de2e60b..cc9f50f3ad1b 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -58,6 +58,7 @@ obj-$(CONFIG_MTD_NAND_MTK)		+= mtk_ecc.o mtk_nand.o
 obj-$(CONFIG_MTD_NAND_TEGRA)		+= tegra_nand.o
 
 nand-objs := nand_base.o nand_legacy.o nand_bbt.o nand_timings.o nand_ids.o
+nand-objs += nand_onfi.o
 nand-objs += nand_amd.o
 nand-objs += nand_hynix.o
 nand-objs += nand_macronix.o
diff --git a/drivers/mtd/nand/raw/internals.h b/drivers/mtd/nand/raw/internals.h
index 289a4b8f7974..1ce720a8d756 100644
--- a/drivers/mtd/nand/raw/internals.h
+++ b/drivers/mtd/nand/raw/internals.h
@@ -88,8 +88,11 @@ int nand_read_page_raw_notsupp(struct nand_chip *chip, u8 *buf,
 int nand_write_page_raw_notsupp(struct nand_chip *chip, const u8 *buf,
 				int oob_required, int page);
 int nand_exit_status_op(struct nand_chip *chip);
+int nand_read_param_page_op(struct nand_chip *chip, u8 page, void *buf,
+			    unsigned int len);
 void nand_decode_ext_id(struct nand_chip *chip);
 void panic_nand_wait(struct nand_chip *chip, unsigned long timeo);
+void sanitize_string(uint8_t *s, size_t len);
 
 /* BBT functions */
 int nand_markbad_bbt(struct nand_chip *chip, loff_t offs);
@@ -101,4 +104,8 @@ void nand_legacy_set_defaults(struct nand_chip *chip);
 void nand_legacy_adjust_cmdfunc(struct nand_chip *chip);
 int nand_legacy_check_hooks(struct nand_chip *chip);
 
+/* ONFI functions */
+u16 onfi_crc16(u16 crc, u8 const *p, size_t len);
+int nand_onfi_detect(struct nand_chip *chip);
+
 #endif /* __LINUX_RAWNAND_INTERNALS */
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 4ef00cefd5da..812e8bd6ad82 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -986,8 +986,8 @@ EXPORT_SYMBOL_GPL(nand_read_page_op);
  *
  * Returns 0 on success, a negative error code otherwise.
  */
-static int nand_read_param_page_op(struct nand_chip *chip, u8 page, void *buf,
-				   unsigned int len)
+int nand_read_param_page_op(struct nand_chip *chip, u8 page, void *buf,
+			    unsigned int len)
 {
 	unsigned int i;
 	u8 *p = buf;
@@ -4370,7 +4370,7 @@ static void nand_set_defaults(struct nand_chip *chip)
 }
 
 /* Sanitize ONFI strings so we can safely print them */
-static void sanitize_string(uint8_t *s, size_t len)
+void sanitize_string(uint8_t *s, size_t len)
 {
 	ssize_t i;
 
@@ -4387,294 +4387,6 @@ static void sanitize_string(uint8_t *s, size_t len)
 	strim(s);
 }
 
-static u16 onfi_crc16(u16 crc, u8 const *p, size_t len)
-{
-	int i;
-	while (len--) {
-		crc ^= *p++ << 8;
-		for (i = 0; i < 8; i++)
-			crc = (crc << 1) ^ ((crc & 0x8000) ? 0x8005 : 0);
-	}
-
-	return crc;
-}
-
-/* Parse the Extended Parameter Page. */
-static int nand_flash_detect_ext_param_page(struct nand_chip *chip,
-					    struct nand_onfi_params *p)
-{
-	struct onfi_ext_param_page *ep;
-	struct onfi_ext_section *s;
-	struct onfi_ext_ecc_info *ecc;
-	uint8_t *cursor;
-	int ret;
-	int len;
-	int i;
-
-	len = le16_to_cpu(p->ext_param_page_length) * 16;
-	ep = kmalloc(len, GFP_KERNEL);
-	if (!ep)
-		return -ENOMEM;
-
-	/* Send our own NAND_CMD_PARAM. */
-	ret = nand_read_param_page_op(chip, 0, NULL, 0);
-	if (ret)
-		goto ext_out;
-
-	/* Use the Change Read Column command to skip the ONFI param pages. */
-	ret = nand_change_read_column_op(chip,
-					 sizeof(*p) * p->num_of_param_pages,
-					 ep, len, true);
-	if (ret)
-		goto ext_out;
-
-	ret = -EINVAL;
-	if ((onfi_crc16(ONFI_CRC_BASE, ((uint8_t *)ep) + 2, len - 2)
-		!= le16_to_cpu(ep->crc))) {
-		pr_debug("fail in the CRC.\n");
-		goto ext_out;
-	}
-
-	/*
-	 * Check the signature.
-	 * Do not strictly follow the ONFI spec, maybe changed in future.
-	 */
-	if (strncmp(ep->sig, "EPPS", 4)) {
-		pr_debug("The signature is invalid.\n");
-		goto ext_out;
-	}
-
-	/* find the ECC section. */
-	cursor = (uint8_t *)(ep + 1);
-	for (i = 0; i < ONFI_EXT_SECTION_MAX; i++) {
-		s = ep->sections + i;
-		if (s->type == ONFI_SECTION_TYPE_2)
-			break;
-		cursor += s->length * 16;
-	}
-	if (i == ONFI_EXT_SECTION_MAX) {
-		pr_debug("We can not find the ECC section.\n");
-		goto ext_out;
-	}
-
-	/* get the info we want. */
-	ecc = (struct onfi_ext_ecc_info *)cursor;
-
-	if (!ecc->codeword_size) {
-		pr_debug("Invalid codeword size\n");
-		goto ext_out;
-	}
-
-	chip->ecc_strength_ds = ecc->ecc_bits;
-	chip->ecc_step_ds = 1 << ecc->codeword_size;
-	ret = 0;
-
-ext_out:
-	kfree(ep);
-	return ret;
-}
-
-/*
- * Recover data with bit-wise majority
- */
-static void nand_bit_wise_majority(const void **srcbufs,
-				   unsigned int nsrcbufs,
-				   void *dstbuf,
-				   unsigned int bufsize)
-{
-	int i, j, k;
-
-	for (i = 0; i < bufsize; i++) {
-		u8 val = 0;
-
-		for (j = 0; j < 8; j++) {
-			unsigned int cnt = 0;
-
-			for (k = 0; k < nsrcbufs; k++) {
-				const u8 *srcbuf = srcbufs[k];
-
-				if (srcbuf[i] & BIT(j))
-					cnt++;
-			}
-
-			if (cnt > nsrcbufs / 2)
-				val |= BIT(j);
-		}
-
-		((u8 *)dstbuf)[i] = val;
-	}
-}
-
-/*
- * Check if the NAND chip is ONFI compliant, returns 1 if it is, 0 otherwise.
- */
-static int nand_flash_detect_onfi(struct nand_chip *chip)
-{
-	struct mtd_info *mtd = nand_to_mtd(chip);
-	struct nand_onfi_params *p;
-	struct onfi_params *onfi;
-	int onfi_version = 0;
-	char id[4];
-	int i, ret, val;
-
-	/* Try ONFI for unknown chip or LP */
-	ret = nand_readid_op(chip, 0x20, id, sizeof(id));
-	if (ret || strncmp(id, "ONFI", 4))
-		return 0;
-
-	/* ONFI chip: allocate a buffer to hold its parameter page */
-	p = kzalloc((sizeof(*p) * 3), GFP_KERNEL);
-	if (!p)
-		return -ENOMEM;
-
-	ret = nand_read_param_page_op(chip, 0, NULL, 0);
-	if (ret) {
-		ret = 0;
-		goto free_onfi_param_page;
-	}
-
-	for (i = 0; i < 3; i++) {
-		ret = nand_read_data_op(chip, &p[i], sizeof(*p), true);
-		if (ret) {
-			ret = 0;
-			goto free_onfi_param_page;
-		}
-
-		if (onfi_crc16(ONFI_CRC_BASE, (u8 *)&p[i], 254) ==
-				le16_to_cpu(p->crc)) {
-			if (i)
-				memcpy(p, &p[i], sizeof(*p));
-			break;
-		}
-	}
-
-	if (i == 3) {
-		const void *srcbufs[3] = {p, p + 1, p + 2};
-
-		pr_warn("Could not find a valid ONFI parameter page, trying bit-wise majority to recover it\n");
-		nand_bit_wise_majority(srcbufs, ARRAY_SIZE(srcbufs), p,
-				       sizeof(*p));
-
-		if (onfi_crc16(ONFI_CRC_BASE, (u8 *)p, 254) !=
-				le16_to_cpu(p->crc)) {
-			pr_err("ONFI parameter recovery failed, aborting\n");
-			goto free_onfi_param_page;
-		}
-	}
-
-	if (chip->manufacturer.desc && chip->manufacturer.desc->ops &&
-	    chip->manufacturer.desc->ops->fixup_onfi_param_page)
-		chip->manufacturer.desc->ops->fixup_onfi_param_page(chip, p);
-
-	/* Check version */
-	val = le16_to_cpu(p->revision);
-	if (val & ONFI_VERSION_2_3)
-		onfi_version = 23;
-	else if (val & ONFI_VERSION_2_2)
-		onfi_version = 22;
-	else if (val & ONFI_VERSION_2_1)
-		onfi_version = 21;
-	else if (val & ONFI_VERSION_2_0)
-		onfi_version = 20;
-	else if (val & ONFI_VERSION_1_0)
-		onfi_version = 10;
-
-	if (!onfi_version) {
-		pr_info("unsupported ONFI version: %d\n", val);
-		goto free_onfi_param_page;
-	}
-
-	sanitize_string(p->manufacturer, sizeof(p->manufacturer));
-	sanitize_string(p->model, sizeof(p->model));
-	chip->parameters.model = kstrdup(p->model, GFP_KERNEL);
-	if (!chip->parameters.model) {
-		ret = -ENOMEM;
-		goto free_onfi_param_page;
-	}
-
-	mtd->writesize = le32_to_cpu(p->byte_per_page);
-
-	/*
-	 * pages_per_block and blocks_per_lun may not be a power-of-2 size
-	 * (don't ask me who thought of this...). MTD assumes that these
-	 * dimensions will be power-of-2, so just truncate the remaining area.
-	 */
-	mtd->erasesize = 1 << (fls(le32_to_cpu(p->pages_per_block)) - 1);
-	mtd->erasesize *= mtd->writesize;
-
-	mtd->oobsize = le16_to_cpu(p->spare_bytes_per_page);
-
-	/* See erasesize comment */
-	chip->chipsize = 1 << (fls(le32_to_cpu(p->blocks_per_lun)) - 1);
-	chip->chipsize *= (uint64_t)mtd->erasesize * p->lun_count;
-	chip->bits_per_cell = p->bits_per_cell;
-
-	chip->max_bb_per_die = le16_to_cpu(p->bb_per_lun);
-	chip->blocks_per_die = le32_to_cpu(p->blocks_per_lun);
-
-	if (le16_to_cpu(p->features) & ONFI_FEATURE_16_BIT_BUS)
-		chip->options |= NAND_BUSWIDTH_16;
-
-	if (p->ecc_bits != 0xff) {
-		chip->ecc_strength_ds = p->ecc_bits;
-		chip->ecc_step_ds = 512;
-	} else if (onfi_version >= 21 &&
-		(le16_to_cpu(p->features) & ONFI_FEATURE_EXT_PARAM_PAGE)) {
-
-		/*
-		 * The nand_flash_detect_ext_param_page() uses the
-		 * Change Read Column command which maybe not supported
-		 * by the chip->legacy.cmdfunc. So try to update the
-		 * chip->legacy.cmdfunc now. We do not replace user supplied
-		 * command function.
-		 */
-		nand_legacy_adjust_cmdfunc(chip);
-
-		/* The Extended Parameter Page is supported since ONFI 2.1. */
-		if (nand_flash_detect_ext_param_page(chip, p))
-			pr_warn("Failed to detect ONFI extended param page\n");
-	} else {
-		pr_warn("Could not retrieve ONFI ECC requirements\n");
-	}
-
-	/* Save some parameters from the parameter page for future use */
-	if (le16_to_cpu(p->opt_cmd) & ONFI_OPT_CMD_SET_GET_FEATURES) {
-		chip->parameters.supports_set_get_features = true;
-		bitmap_set(chip->parameters.get_feature_list,
-			   ONFI_FEATURE_ADDR_TIMING_MODE, 1);
-		bitmap_set(chip->parameters.set_feature_list,
-			   ONFI_FEATURE_ADDR_TIMING_MODE, 1);
-	}
-
-	onfi = kzalloc(sizeof(*onfi), GFP_KERNEL);
-	if (!onfi) {
-		ret = -ENOMEM;
-		goto free_model;
-	}
-
-	onfi->version = onfi_version;
-	onfi->tPROG = le16_to_cpu(p->t_prog);
-	onfi->tBERS = le16_to_cpu(p->t_bers);
-	onfi->tR = le16_to_cpu(p->t_r);
-	onfi->tCCS = le16_to_cpu(p->t_ccs);
-	onfi->async_timing_mode = le16_to_cpu(p->async_timing_mode);
-	onfi->vendor_revision = le16_to_cpu(p->vendor_revision);
-	memcpy(onfi->vendor, p->vendor, sizeof(p->vendor));
-	chip->parameters.onfi = onfi;
-
-	/* Identification done, free the full ONFI parameter page and exit */
-	kfree(p);
-
-	return 1;
-
-free_model:
-	kfree(chip->parameters.model);
-free_onfi_param_page:
-	kfree(p);
-
-	return ret;
-}
-
 /*
  * Check if the NAND chip is JEDEC compliant, returns 1 if it is, 0 otherwise.
  */
@@ -5076,7 +4788,7 @@ static int nand_detect(struct nand_chip *chip, struct nand_flash_dev *type)
 
 	if (!type->name || !type->pagesize) {
 		/* Check if the chip is ONFI compliant */
-		ret = nand_flash_detect_onfi(chip);
+		ret = nand_onfi_detect(chip);
 		if (ret < 0)
 			return ret;
 		else if (ret)
diff --git a/drivers/mtd/nand/raw/nand_onfi.c b/drivers/mtd/nand/raw/nand_onfi.c
new file mode 100644
index 000000000000..d8184cf591ad
--- /dev/null
+++ b/drivers/mtd/nand/raw/nand_onfi.c
@@ -0,0 +1,305 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 2000 Steven J. Hill (sjhill@realitydiluted.com)
+ *		  2002-2006 Thomas Gleixner (tglx@linutronix.de)
+ *
+ *  Credits:
+ *	David Woodhouse for adding multichip support
+ *
+ *	Aleph One Ltd. and Toby Churchill Ltd. for supporting the
+ *	rework for 2K page size chips
+ *
+ * This file contains all ONFI helpers.
+ */
+
+#include <linux/slab.h>
+
+#include "internals.h"
+
+u16 onfi_crc16(u16 crc, u8 const *p, size_t len)
+{
+	int i;
+	while (len--) {
+		crc ^= *p++ << 8;
+		for (i = 0; i < 8; i++)
+			crc = (crc << 1) ^ ((crc & 0x8000) ? 0x8005 : 0);
+	}
+
+	return crc;
+}
+
+/* Parse the Extended Parameter Page. */
+static int nand_flash_detect_ext_param_page(struct nand_chip *chip,
+					    struct nand_onfi_params *p)
+{
+	struct onfi_ext_param_page *ep;
+	struct onfi_ext_section *s;
+	struct onfi_ext_ecc_info *ecc;
+	uint8_t *cursor;
+	int ret;
+	int len;
+	int i;
+
+	len = le16_to_cpu(p->ext_param_page_length) * 16;
+	ep = kmalloc(len, GFP_KERNEL);
+	if (!ep)
+		return -ENOMEM;
+
+	/* Send our own NAND_CMD_PARAM. */
+	ret = nand_read_param_page_op(chip, 0, NULL, 0);
+	if (ret)
+		goto ext_out;
+
+	/* Use the Change Read Column command to skip the ONFI param pages. */
+	ret = nand_change_read_column_op(chip,
+					 sizeof(*p) * p->num_of_param_pages,
+					 ep, len, true);
+	if (ret)
+		goto ext_out;
+
+	ret = -EINVAL;
+	if ((onfi_crc16(ONFI_CRC_BASE, ((uint8_t *)ep) + 2, len - 2)
+		!= le16_to_cpu(ep->crc))) {
+		pr_debug("fail in the CRC.\n");
+		goto ext_out;
+	}
+
+	/*
+	 * Check the signature.
+	 * Do not strictly follow the ONFI spec, maybe changed in future.
+	 */
+	if (strncmp(ep->sig, "EPPS", 4)) {
+		pr_debug("The signature is invalid.\n");
+		goto ext_out;
+	}
+
+	/* find the ECC section. */
+	cursor = (uint8_t *)(ep + 1);
+	for (i = 0; i < ONFI_EXT_SECTION_MAX; i++) {
+		s = ep->sections + i;
+		if (s->type == ONFI_SECTION_TYPE_2)
+			break;
+		cursor += s->length * 16;
+	}
+	if (i == ONFI_EXT_SECTION_MAX) {
+		pr_debug("We can not find the ECC section.\n");
+		goto ext_out;
+	}
+
+	/* get the info we want. */
+	ecc = (struct onfi_ext_ecc_info *)cursor;
+
+	if (!ecc->codeword_size) {
+		pr_debug("Invalid codeword size\n");
+		goto ext_out;
+	}
+
+	chip->ecc_strength_ds = ecc->ecc_bits;
+	chip->ecc_step_ds = 1 << ecc->codeword_size;
+	ret = 0;
+
+ext_out:
+	kfree(ep);
+	return ret;
+}
+
+/*
+ * Recover data with bit-wise majority
+ */
+static void nand_bit_wise_majority(const void **srcbufs,
+				   unsigned int nsrcbufs,
+				   void *dstbuf,
+				   unsigned int bufsize)
+{
+	int i, j, k;
+
+	for (i = 0; i < bufsize; i++) {
+		u8 val = 0;
+
+		for (j = 0; j < 8; j++) {
+			unsigned int cnt = 0;
+
+			for (k = 0; k < nsrcbufs; k++) {
+				const u8 *srcbuf = srcbufs[k];
+
+				if (srcbuf[i] & BIT(j))
+					cnt++;
+			}
+
+			if (cnt > nsrcbufs / 2)
+				val |= BIT(j);
+		}
+
+		((u8 *)dstbuf)[i] = val;
+	}
+}
+
+/*
+ * Check if the NAND chip is ONFI compliant, returns 1 if it is, 0 otherwise.
+ */
+int nand_onfi_detect(struct nand_chip *chip)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct nand_onfi_params *p;
+	struct onfi_params *onfi;
+	int onfi_version = 0;
+	char id[4];
+	int i, ret, val;
+
+	/* Try ONFI for unknown chip or LP */
+	ret = nand_readid_op(chip, 0x20, id, sizeof(id));
+	if (ret || strncmp(id, "ONFI", 4))
+		return 0;
+
+	/* ONFI chip: allocate a buffer to hold its parameter page */
+	p = kzalloc((sizeof(*p) * 3), GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	ret = nand_read_param_page_op(chip, 0, NULL, 0);
+	if (ret) {
+		ret = 0;
+		goto free_onfi_param_page;
+	}
+
+	for (i = 0; i < 3; i++) {
+		ret = nand_read_data_op(chip, &p[i], sizeof(*p), true);
+		if (ret) {
+			ret = 0;
+			goto free_onfi_param_page;
+		}
+
+		if (onfi_crc16(ONFI_CRC_BASE, (u8 *)&p[i], 254) ==
+				le16_to_cpu(p->crc)) {
+			if (i)
+				memcpy(p, &p[i], sizeof(*p));
+			break;
+		}
+	}
+
+	if (i == 3) {
+		const void *srcbufs[3] = {p, p + 1, p + 2};
+
+		pr_warn("Could not find a valid ONFI parameter page, trying bit-wise majority to recover it\n");
+		nand_bit_wise_majority(srcbufs, ARRAY_SIZE(srcbufs), p,
+				       sizeof(*p));
+
+		if (onfi_crc16(ONFI_CRC_BASE, (u8 *)p, 254) !=
+				le16_to_cpu(p->crc)) {
+			pr_err("ONFI parameter recovery failed, aborting\n");
+			goto free_onfi_param_page;
+		}
+	}
+
+	if (chip->manufacturer.desc && chip->manufacturer.desc->ops &&
+	    chip->manufacturer.desc->ops->fixup_onfi_param_page)
+		chip->manufacturer.desc->ops->fixup_onfi_param_page(chip, p);
+
+	/* Check version */
+	val = le16_to_cpu(p->revision);
+	if (val & ONFI_VERSION_2_3)
+		onfi_version = 23;
+	else if (val & ONFI_VERSION_2_2)
+		onfi_version = 22;
+	else if (val & ONFI_VERSION_2_1)
+		onfi_version = 21;
+	else if (val & ONFI_VERSION_2_0)
+		onfi_version = 20;
+	else if (val & ONFI_VERSION_1_0)
+		onfi_version = 10;
+
+	if (!onfi_version) {
+		pr_info("unsupported ONFI version: %d\n", val);
+		goto free_onfi_param_page;
+	}
+
+	sanitize_string(p->manufacturer, sizeof(p->manufacturer));
+	sanitize_string(p->model, sizeof(p->model));
+	chip->parameters.model = kstrdup(p->model, GFP_KERNEL);
+	if (!chip->parameters.model) {
+		ret = -ENOMEM;
+		goto free_onfi_param_page;
+	}
+
+	mtd->writesize = le32_to_cpu(p->byte_per_page);
+
+	/*
+	 * pages_per_block and blocks_per_lun may not be a power-of-2 size
+	 * (don't ask me who thought of this...). MTD assumes that these
+	 * dimensions will be power-of-2, so just truncate the remaining area.
+	 */
+	mtd->erasesize = 1 << (fls(le32_to_cpu(p->pages_per_block)) - 1);
+	mtd->erasesize *= mtd->writesize;
+
+	mtd->oobsize = le16_to_cpu(p->spare_bytes_per_page);
+
+	/* See erasesize comment */
+	chip->chipsize = 1 << (fls(le32_to_cpu(p->blocks_per_lun)) - 1);
+	chip->chipsize *= (uint64_t)mtd->erasesize * p->lun_count;
+	chip->bits_per_cell = p->bits_per_cell;
+
+	chip->max_bb_per_die = le16_to_cpu(p->bb_per_lun);
+	chip->blocks_per_die = le32_to_cpu(p->blocks_per_lun);
+
+	if (le16_to_cpu(p->features) & ONFI_FEATURE_16_BIT_BUS)
+		chip->options |= NAND_BUSWIDTH_16;
+
+	if (p->ecc_bits != 0xff) {
+		chip->ecc_strength_ds = p->ecc_bits;
+		chip->ecc_step_ds = 512;
+	} else if (onfi_version >= 21 &&
+		(le16_to_cpu(p->features) & ONFI_FEATURE_EXT_PARAM_PAGE)) {
+
+		/*
+		 * The nand_flash_detect_ext_param_page() uses the
+		 * Change Read Column command which maybe not supported
+		 * by the chip->legacy.cmdfunc. So try to update the
+		 * chip->legacy.cmdfunc now. We do not replace user supplied
+		 * command function.
+		 */
+		nand_legacy_adjust_cmdfunc(chip);
+
+		/* The Extended Parameter Page is supported since ONFI 2.1. */
+		if (nand_flash_detect_ext_param_page(chip, p))
+			pr_warn("Failed to detect ONFI extended param page\n");
+	} else {
+		pr_warn("Could not retrieve ONFI ECC requirements\n");
+	}
+
+	/* Save some parameters from the parameter page for future use */
+	if (le16_to_cpu(p->opt_cmd) & ONFI_OPT_CMD_SET_GET_FEATURES) {
+		chip->parameters.supports_set_get_features = true;
+		bitmap_set(chip->parameters.get_feature_list,
+			   ONFI_FEATURE_ADDR_TIMING_MODE, 1);
+		bitmap_set(chip->parameters.set_feature_list,
+			   ONFI_FEATURE_ADDR_TIMING_MODE, 1);
+	}
+
+	onfi = kzalloc(sizeof(*onfi), GFP_KERNEL);
+	if (!onfi) {
+		ret = -ENOMEM;
+		goto free_model;
+	}
+
+	onfi->version = onfi_version;
+	onfi->tPROG = le16_to_cpu(p->t_prog);
+	onfi->tBERS = le16_to_cpu(p->t_bers);
+	onfi->tR = le16_to_cpu(p->t_r);
+	onfi->tCCS = le16_to_cpu(p->t_ccs);
+	onfi->async_timing_mode = le16_to_cpu(p->async_timing_mode);
+	onfi->vendor_revision = le16_to_cpu(p->vendor_revision);
+	memcpy(onfi->vendor, p->vendor, sizeof(p->vendor));
+	chip->parameters.onfi = onfi;
+
+	/* Identification done, free the full ONFI parameter page and exit */
+	kfree(p);
+
+	return 1;
+
+free_model:
+	kfree(chip->parameters.model);
+free_onfi_param_page:
+	kfree(p);
+
+	return ret;
+}
diff --git a/include/linux/mtd/onfi.h b/include/linux/mtd/onfi.h
new file mode 100644
index 000000000000..339ac798568e
--- /dev/null
+++ b/include/linux/mtd/onfi.h
@@ -0,0 +1,178 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright © 2000-2010 David Woodhouse <dwmw2@infradead.org>
+ *			 Steven J. Hill <sjhill@realitydiluted.com>
+ *			 Thomas Gleixner <tglx@linutronix.de>
+ *
+ * Contains all ONFI related definitions
+ */
+
+#ifndef __LINUX_MTD_ONFI_H
+#define __LINUX_MTD_ONFI_H
+
+#include <linux/types.h>
+
+/* ONFI version bits */
+#define ONFI_VERSION_1_0		BIT(1)
+#define ONFI_VERSION_2_0		BIT(2)
+#define ONFI_VERSION_2_1		BIT(3)
+#define ONFI_VERSION_2_2		BIT(4)
+#define ONFI_VERSION_2_3		BIT(5)
+#define ONFI_VERSION_3_0		BIT(6)
+#define ONFI_VERSION_3_1		BIT(7)
+#define ONFI_VERSION_3_2		BIT(8)
+#define ONFI_VERSION_4_0		BIT(9)
+
+/* ONFI features */
+#define ONFI_FEATURE_16_BIT_BUS		(1 << 0)
+#define ONFI_FEATURE_EXT_PARAM_PAGE	(1 << 7)
+
+/* ONFI timing mode, used in both asynchronous and synchronous mode */
+#define ONFI_TIMING_MODE_0		(1 << 0)
+#define ONFI_TIMING_MODE_1		(1 << 1)
+#define ONFI_TIMING_MODE_2		(1 << 2)
+#define ONFI_TIMING_MODE_3		(1 << 3)
+#define ONFI_TIMING_MODE_4		(1 << 4)
+#define ONFI_TIMING_MODE_5		(1 << 5)
+#define ONFI_TIMING_MODE_UNKNOWN	(1 << 6)
+
+/* ONFI feature number/address */
+#define ONFI_FEATURE_NUMBER		256
+#define ONFI_FEATURE_ADDR_TIMING_MODE	0x1
+
+/* Vendor-specific feature address (Micron) */
+#define ONFI_FEATURE_ADDR_READ_RETRY	0x89
+#define ONFI_FEATURE_ON_DIE_ECC		0x90
+#define   ONFI_FEATURE_ON_DIE_ECC_EN	BIT(3)
+
+/* ONFI subfeature parameters length */
+#define ONFI_SUBFEATURE_PARAM_LEN	4
+
+/* ONFI optional commands SET/GET FEATURES supported? */
+#define ONFI_OPT_CMD_SET_GET_FEATURES	(1 << 2)
+
+struct nand_onfi_params {
+	/* rev info and features block */
+	/* 'O' 'N' 'F' 'I'  */
+	u8 sig[4];
+	__le16 revision;
+	__le16 features;
+	__le16 opt_cmd;
+	u8 reserved0[2];
+	__le16 ext_param_page_length; /* since ONFI 2.1 */
+	u8 num_of_param_pages;        /* since ONFI 2.1 */
+	u8 reserved1[17];
+
+	/* manufacturer information block */
+	char manufacturer[12];
+	char model[20];
+	u8 jedec_id;
+	__le16 date_code;
+	u8 reserved2[13];
+
+	/* memory organization block */
+	__le32 byte_per_page;
+	__le16 spare_bytes_per_page;
+	__le32 data_bytes_per_ppage;
+	__le16 spare_bytes_per_ppage;
+	__le32 pages_per_block;
+	__le32 blocks_per_lun;
+	u8 lun_count;
+	u8 addr_cycles;
+	u8 bits_per_cell;
+	__le16 bb_per_lun;
+	__le16 block_endurance;
+	u8 guaranteed_good_blocks;
+	__le16 guaranteed_block_endurance;
+	u8 programs_per_page;
+	u8 ppage_attr;
+	u8 ecc_bits;
+	u8 interleaved_bits;
+	u8 interleaved_ops;
+	u8 reserved3[13];
+
+	/* electrical parameter block */
+	u8 io_pin_capacitance_max;
+	__le16 async_timing_mode;
+	__le16 program_cache_timing_mode;
+	__le16 t_prog;
+	__le16 t_bers;
+	__le16 t_r;
+	__le16 t_ccs;
+	__le16 src_sync_timing_mode;
+	u8 src_ssync_features;
+	__le16 clk_pin_capacitance_typ;
+	__le16 io_pin_capacitance_typ;
+	__le16 input_pin_capacitance_typ;
+	u8 input_pin_capacitance_max;
+	u8 driver_strength_support;
+	__le16 t_int_r;
+	__le16 t_adl;
+	u8 reserved4[8];
+
+	/* vendor */
+	__le16 vendor_revision;
+	u8 vendor[88];
+
+	__le16 crc;
+} __packed;
+
+#define ONFI_CRC_BASE	0x4F4E
+
+/* Extended ECC information Block Definition (since ONFI 2.1) */
+struct onfi_ext_ecc_info {
+	u8 ecc_bits;
+	u8 codeword_size;
+	__le16 bb_per_lun;
+	__le16 block_endurance;
+	u8 reserved[2];
+} __packed;
+
+#define ONFI_SECTION_TYPE_0	0	/* Unused section. */
+#define ONFI_SECTION_TYPE_1	1	/* for additional sections. */
+#define ONFI_SECTION_TYPE_2	2	/* for ECC information. */
+struct onfi_ext_section {
+	u8 type;
+	u8 length;
+} __packed;
+
+#define ONFI_EXT_SECTION_MAX 8
+
+/* Extended Parameter Page Definition (since ONFI 2.1) */
+struct onfi_ext_param_page {
+	__le16 crc;
+	u8 sig[4];             /* 'E' 'P' 'P' 'S' */
+	u8 reserved0[10];
+	struct onfi_ext_section sections[ONFI_EXT_SECTION_MAX];
+
+	/*
+	 * The actual size of the Extended Parameter Page is in
+	 * @ext_param_page_length of nand_onfi_params{}.
+	 * The following are the variable length sections.
+	 * So we do not add any fields below. Please see the ONFI spec.
+	 */
+} __packed;
+
+/**
+ * struct onfi_params - ONFI specific parameters that will be reused
+ * @version: ONFI version (BCD encoded), 0 if ONFI is not supported
+ * @tPROG: Page program time
+ * @tBERS: Block erase time
+ * @tR: Page read time
+ * @tCCS: Change column setup time
+ * @async_timing_mode: Supported asynchronous timing mode
+ * @vendor_revision: Vendor specific revision number
+ * @vendor: Vendor specific data
+ */
+struct onfi_params {
+	int version;
+	u16 tPROG;
+	u16 tBERS;
+	u16 tR;
+	u16 tCCS;
+	u16 async_timing_mode;
+	u16 vendor_revision;
+	u8 vendor[88];
+};
+
+#endif /* __LINUX_MTD_ONFI_H */
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index fbe7686cfc59..f4fc0cce7c55 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -21,6 +21,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/flashchip.h>
 #include <linux/mtd/bbm.h>
+#include <linux/mtd/onfi.h>
 #include <linux/of.h>
 #include <linux/types.h>
 
@@ -204,147 +205,6 @@ enum nand_ecc_algo {
 #define NAND_CI_CELLTYPE_MSK	0x0C
 #define NAND_CI_CELLTYPE_SHIFT	2
 
-/* ONFI version bits */
-#define ONFI_VERSION_1_0		BIT(1)
-#define ONFI_VERSION_2_0		BIT(2)
-#define ONFI_VERSION_2_1		BIT(3)
-#define ONFI_VERSION_2_2		BIT(4)
-#define ONFI_VERSION_2_3		BIT(5)
-#define ONFI_VERSION_3_0		BIT(6)
-#define ONFI_VERSION_3_1		BIT(7)
-#define ONFI_VERSION_3_2		BIT(8)
-#define ONFI_VERSION_4_0		BIT(9)
-
-/* ONFI features */
-#define ONFI_FEATURE_16_BIT_BUS		(1 << 0)
-#define ONFI_FEATURE_EXT_PARAM_PAGE	(1 << 7)
-
-/* ONFI timing mode, used in both asynchronous and synchronous mode */
-#define ONFI_TIMING_MODE_0		(1 << 0)
-#define ONFI_TIMING_MODE_1		(1 << 1)
-#define ONFI_TIMING_MODE_2		(1 << 2)
-#define ONFI_TIMING_MODE_3		(1 << 3)
-#define ONFI_TIMING_MODE_4		(1 << 4)
-#define ONFI_TIMING_MODE_5		(1 << 5)
-#define ONFI_TIMING_MODE_UNKNOWN	(1 << 6)
-
-/* ONFI feature number/address */
-#define ONFI_FEATURE_NUMBER		256
-#define ONFI_FEATURE_ADDR_TIMING_MODE	0x1
-
-/* Vendor-specific feature address (Micron) */
-#define ONFI_FEATURE_ADDR_READ_RETRY	0x89
-#define ONFI_FEATURE_ON_DIE_ECC		0x90
-#define   ONFI_FEATURE_ON_DIE_ECC_EN	BIT(3)
-
-/* ONFI subfeature parameters length */
-#define ONFI_SUBFEATURE_PARAM_LEN	4
-
-/* ONFI optional commands SET/GET FEATURES supported? */
-#define ONFI_OPT_CMD_SET_GET_FEATURES	(1 << 2)
-
-struct nand_onfi_params {
-	/* rev info and features block */
-	/* 'O' 'N' 'F' 'I'  */
-	u8 sig[4];
-	__le16 revision;
-	__le16 features;
-	__le16 opt_cmd;
-	u8 reserved0[2];
-	__le16 ext_param_page_length; /* since ONFI 2.1 */
-	u8 num_of_param_pages;        /* since ONFI 2.1 */
-	u8 reserved1[17];
-
-	/* manufacturer information block */
-	char manufacturer[12];
-	char model[20];
-	u8 jedec_id;
-	__le16 date_code;
-	u8 reserved2[13];
-
-	/* memory organization block */
-	__le32 byte_per_page;
-	__le16 spare_bytes_per_page;
-	__le32 data_bytes_per_ppage;
-	__le16 spare_bytes_per_ppage;
-	__le32 pages_per_block;
-	__le32 blocks_per_lun;
-	u8 lun_count;
-	u8 addr_cycles;
-	u8 bits_per_cell;
-	__le16 bb_per_lun;
-	__le16 block_endurance;
-	u8 guaranteed_good_blocks;
-	__le16 guaranteed_block_endurance;
-	u8 programs_per_page;
-	u8 ppage_attr;
-	u8 ecc_bits;
-	u8 interleaved_bits;
-	u8 interleaved_ops;
-	u8 reserved3[13];
-
-	/* electrical parameter block */
-	u8 io_pin_capacitance_max;
-	__le16 async_timing_mode;
-	__le16 program_cache_timing_mode;
-	__le16 t_prog;
-	__le16 t_bers;
-	__le16 t_r;
-	__le16 t_ccs;
-	__le16 src_sync_timing_mode;
-	u8 src_ssync_features;
-	__le16 clk_pin_capacitance_typ;
-	__le16 io_pin_capacitance_typ;
-	__le16 input_pin_capacitance_typ;
-	u8 input_pin_capacitance_max;
-	u8 driver_strength_support;
-	__le16 t_int_r;
-	__le16 t_adl;
-	u8 reserved4[8];
-
-	/* vendor */
-	__le16 vendor_revision;
-	u8 vendor[88];
-
-	__le16 crc;
-} __packed;
-
-#define ONFI_CRC_BASE	0x4F4E
-
-/* Extended ECC information Block Definition (since ONFI 2.1) */
-struct onfi_ext_ecc_info {
-	u8 ecc_bits;
-	u8 codeword_size;
-	__le16 bb_per_lun;
-	__le16 block_endurance;
-	u8 reserved[2];
-} __packed;
-
-#define ONFI_SECTION_TYPE_0	0	/* Unused section. */
-#define ONFI_SECTION_TYPE_1	1	/* for additional sections. */
-#define ONFI_SECTION_TYPE_2	2	/* for ECC information. */
-struct onfi_ext_section {
-	u8 type;
-	u8 length;
-} __packed;
-
-#define ONFI_EXT_SECTION_MAX 8
-
-/* Extended Parameter Page Definition (since ONFI 2.1) */
-struct onfi_ext_param_page {
-	__le16 crc;
-	u8 sig[4];             /* 'E' 'P' 'P' 'S' */
-	u8 reserved0[10];
-	struct onfi_ext_section sections[ONFI_EXT_SECTION_MAX];
-
-	/*
-	 * The actual size of the Extended Parameter Page is in
-	 * @ext_param_page_length of nand_onfi_params{}.
-	 * The following are the variable length sections.
-	 * So we do not add any fields below. Please see the ONFI spec.
-	 */
-} __packed;
-
 struct jedec_ecc_info {
 	u8 ecc_bits;
 	u8 codeword_size;
@@ -423,28 +283,6 @@ struct nand_jedec_params {
 	__le16 crc;
 } __packed;
 
-/**
- * struct onfi_params - ONFI specific parameters that will be reused
- * @version: ONFI version (BCD encoded), 0 if ONFI is not supported
- * @tPROG: Page program time
- * @tBERS: Block erase time
- * @tR: Page read time
- * @tCCS: Change column setup time
- * @async_timing_mode: Supported asynchronous timing mode
- * @vendor_revision: Vendor specific revision number
- * @vendor: Vendor specific data
- */
-struct onfi_params {
-	int version;
-	u16 tPROG;
-	u16 tBERS;
-	u16 tR;
-	u16 tCCS;
-	u16 async_timing_mode;
-	u16 vendor_revision;
-	u8 vendor[88];
-};
-
 /**
  * struct nand_parameters - NAND generic parameters from the parameter page
  * @model: Model name
-- 
2.14.1
