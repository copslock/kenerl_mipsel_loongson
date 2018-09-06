Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Sep 2018 14:06:52 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:43448 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994644AbeIFMFwJ2TFe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 6 Sep 2018 14:05:52 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 949F420935; Thu,  6 Sep 2018 14:05:45 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-30-219.w90-88.abo.wanadoo.fr [90.88.15.219])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8407B208B9;
        Thu,  6 Sep 2018 14:05:44 +0200 (CEST)
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
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Lukasz Majewski <lukma@denx.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Alexander Clouter <alex@digriz.org.uk>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Han Xu <han.xu@nxp.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Xiaolei Li <xiaolei.li@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Wan ZongShun <mcuos.com@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>, Stefan Agner <stefan@agner.ch>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Subject: [PATCH v2 05/23] mtd: rawnand: Pass a nand_chip object to ecc->hwctl()
Date:   Thu,  6 Sep 2018 14:05:17 +0200
Message-Id: <20180906120535.21255-6-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180906120535.21255-1-boris.brezillon@bootlin.com>
References: <20180906120535.21255-1-boris.brezillon@bootlin.com>
Return-Path: <boris.brezillon@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66036
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

Let's make the raw NAND API consistent by patching all helpers and
hooks to take a nand_chip object instead of an mtd_info one.

Now is ecc->hwctl()'s turn.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/cs553x_nand.c  |  3 +--
 drivers/mtd/nand/raw/davinci_nand.c | 10 +++++-----
 drivers/mtd/nand/raw/diskonchip.c   |  6 ++----
 drivers/mtd/nand/raw/fsmc_nand.c    |  6 +++---
 drivers/mtd/nand/raw/jz4740_nand.c  |  4 ++--
 drivers/mtd/nand/raw/jz4780_nand.c  |  4 ++--
 drivers/mtd/nand/raw/lpc32xx_mlc.c  |  2 +-
 drivers/mtd/nand/raw/lpc32xx_slc.c  |  2 +-
 drivers/mtd/nand/raw/nand_base.c    | 14 +++++++-------
 drivers/mtd/nand/raw/ndfc.c         |  3 +--
 drivers/mtd/nand/raw/omap2.c        | 17 ++++++++---------
 drivers/mtd/nand/raw/r852.c         |  4 ++--
 drivers/mtd/nand/raw/s3c2410.c      | 15 +++++++++------
 drivers/mtd/nand/raw/sharpsl.c      |  4 ++--
 drivers/mtd/nand/raw/tmio_nand.c    |  4 ++--
 drivers/mtd/nand/raw/txx9ndfmc.c    |  4 ++--
 include/linux/mtd/rawnand.h         |  2 +-
 17 files changed, 51 insertions(+), 53 deletions(-)

diff --git a/drivers/mtd/nand/raw/cs553x_nand.c b/drivers/mtd/nand/raw/cs553x_nand.c
index d4be416bb2fa..508bcb3d134f 100644
--- a/drivers/mtd/nand/raw/cs553x_nand.c
+++ b/drivers/mtd/nand/raw/cs553x_nand.c
@@ -157,9 +157,8 @@ static int cs553x_device_ready(struct mtd_info *mtd)
 	return (foo & CS_NAND_STS_FLASH_RDY) && !(foo & CS_NAND_CTLR_BUSY);
 }
 
-static void cs_enable_hwecc(struct mtd_info *mtd, int mode)
+static void cs_enable_hwecc(struct nand_chip *this, int mode)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
 	void __iomem *mmio_base = this->IO_ADDR_R;
 
 	writeb(0x07, mmio_base + MM_NAND_ECC_CTL);
diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/davinci_nand.c
index 66d3d5966013..329de266c953 100644
--- a/drivers/mtd/nand/raw/davinci_nand.c
+++ b/drivers/mtd/nand/raw/davinci_nand.c
@@ -146,16 +146,16 @@ static inline uint32_t nand_davinci_readecc_1bit(struct mtd_info *mtd)
 			+ 4 * info->core_chipsel);
 }
 
-static void nand_davinci_hwctl_1bit(struct mtd_info *mtd, int mode)
+static void nand_davinci_hwctl_1bit(struct nand_chip *chip, int mode)
 {
 	struct davinci_nand_info *info;
 	uint32_t nandcfr;
 	unsigned long flags;
 
-	info = to_davinci_nand(mtd);
+	info = to_davinci_nand(nand_to_mtd(chip));
 
 	/* Reset ECC hardware */
-	nand_davinci_readecc_1bit(mtd);
+	nand_davinci_readecc_1bit(nand_to_mtd(chip));
 
 	spin_lock_irqsave(&davinci_nand_lock, flags);
 
@@ -231,9 +231,9 @@ static int nand_davinci_correct_1bit(struct mtd_info *mtd, u_char *dat,
  * OOB without recomputing ECC.
  */
 
-static void nand_davinci_hwctl_4bit(struct mtd_info *mtd, int mode)
+static void nand_davinci_hwctl_4bit(struct nand_chip *chip, int mode)
 {
-	struct davinci_nand_info *info = to_davinci_nand(mtd);
+	struct davinci_nand_info *info = to_davinci_nand(nand_to_mtd(chip));
 	unsigned long flags;
 	u32 val;
 
diff --git a/drivers/mtd/nand/raw/diskonchip.c b/drivers/mtd/nand/raw/diskonchip.c
index 43d1e08133ce..d007f0704654 100644
--- a/drivers/mtd/nand/raw/diskonchip.c
+++ b/drivers/mtd/nand/raw/diskonchip.c
@@ -797,9 +797,8 @@ static int doc200x_block_bad(struct mtd_info *mtd, loff_t ofs)
 	return 0;
 }
 
-static void doc200x_enable_hwecc(struct mtd_info *mtd, int mode)
+static void doc200x_enable_hwecc(struct nand_chip *this, int mode)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
 	struct doc_priv *doc = nand_get_controller_data(this);
 	void __iomem *docptr = doc->virtadr;
 
@@ -816,9 +815,8 @@ static void doc200x_enable_hwecc(struct mtd_info *mtd, int mode)
 	}
 }
 
-static void doc2001plus_enable_hwecc(struct mtd_info *mtd, int mode)
+static void doc2001plus_enable_hwecc(struct nand_chip *this, int mode)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
 	struct doc_priv *doc = nand_get_controller_data(this);
 	void __iomem *docptr = doc->virtadr;
 
diff --git a/drivers/mtd/nand/raw/fsmc_nand.c b/drivers/mtd/nand/raw/fsmc_nand.c
index 25d354e9448e..0291a43d9f6e 100644
--- a/drivers/mtd/nand/raw/fsmc_nand.c
+++ b/drivers/mtd/nand/raw/fsmc_nand.c
@@ -368,9 +368,9 @@ static int fsmc_setup_data_interface(struct mtd_info *mtd, int csline,
 /*
  * fsmc_enable_hwecc - Enables Hardware ECC through FSMC registers
  */
-static void fsmc_enable_hwecc(struct mtd_info *mtd, int mode)
+static void fsmc_enable_hwecc(struct nand_chip *chip, int mode)
 {
-	struct fsmc_nand_data *host = mtd_to_fsmc(mtd);
+	struct fsmc_nand_data *host = mtd_to_fsmc(nand_to_mtd(chip));
 
 	writel_relaxed(readl(host->regs_va + FSMC_PC) & ~FSMC_ECCPLEN_256,
 		       host->regs_va + FSMC_PC);
@@ -740,7 +740,7 @@ static int fsmc_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 
 	for (i = 0, s = 0; s < eccsteps; s++, i += eccbytes, p += eccsize) {
 		nand_read_page_op(chip, page, s * eccsize, NULL, 0);
-		chip->ecc.hwctl(mtd, NAND_ECC_READ);
+		chip->ecc.hwctl(chip, NAND_ECC_READ);
 		nand_read_data_op(chip, p, eccsize, false);
 
 		for (j = 0; j < eccbytes;) {
diff --git a/drivers/mtd/nand/raw/jz4740_nand.c b/drivers/mtd/nand/raw/jz4740_nand.c
index 27603d78b157..0bf5d7b7f185 100644
--- a/drivers/mtd/nand/raw/jz4740_nand.c
+++ b/drivers/mtd/nand/raw/jz4740_nand.c
@@ -134,9 +134,9 @@ static int jz_nand_dev_ready(struct mtd_info *mtd)
 	return gpiod_get_value_cansleep(nand->busy_gpio);
 }
 
-static void jz_nand_hwctl(struct mtd_info *mtd, int mode)
+static void jz_nand_hwctl(struct nand_chip *chip, int mode)
 {
-	struct jz_nand *nand = mtd_to_jz_nand(mtd);
+	struct jz_nand *nand = mtd_to_jz_nand(nand_to_mtd(chip));
 	uint32_t reg;
 
 	writel(0, nand->base + JZ_REG_NAND_IRQ_STAT);
diff --git a/drivers/mtd/nand/raw/jz4780_nand.c b/drivers/mtd/nand/raw/jz4780_nand.c
index 7d008aeae165..1604214ee4b8 100644
--- a/drivers/mtd/nand/raw/jz4780_nand.c
+++ b/drivers/mtd/nand/raw/jz4780_nand.c
@@ -116,9 +116,9 @@ static int jz4780_nand_dev_ready(struct mtd_info *mtd)
 	return !gpiod_get_value_cansleep(nand->busy_gpio);
 }
 
-static void jz4780_nand_ecc_hwctl(struct mtd_info *mtd, int mode)
+static void jz4780_nand_ecc_hwctl(struct nand_chip *chip, int mode)
 {
-	struct jz4780_nand_chip *nand = to_jz4780_nand_chip(mtd);
+	struct jz4780_nand_chip *nand = to_jz4780_nand_chip(nand_to_mtd(chip));
 
 	nand->reading = (mode == NAND_ECC_READ);
 }
diff --git a/drivers/mtd/nand/raw/lpc32xx_mlc.c b/drivers/mtd/nand/raw/lpc32xx_mlc.c
index d240b8ff40ca..84e421710297 100644
--- a/drivers/mtd/nand/raw/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_mlc.c
@@ -576,7 +576,7 @@ static int lpc32xx_write_oob(struct mtd_info *mtd, struct nand_chip *chip,
 }
 
 /* Prepares MLC for transfers with H/W ECC enabled: always enabled anyway */
-static void lpc32xx_ecc_enable(struct mtd_info *mtd, int mode)
+static void lpc32xx_ecc_enable(struct nand_chip *chip, int mode)
 {
 	/* Always enabled! */
 }
diff --git a/drivers/mtd/nand/raw/lpc32xx_slc.c b/drivers/mtd/nand/raw/lpc32xx_slc.c
index 607e4bdfae03..a6c635053bd5 100644
--- a/drivers/mtd/nand/raw/lpc32xx_slc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_slc.c
@@ -337,7 +337,7 @@ static void lpc32xx_wp_disable(struct lpc32xx_nand_host *host)
 /*
  * Prepares SLC for transfers with H/W ECC enabled
  */
-static void lpc32xx_nand_ecc_enable(struct mtd_info *mtd, int mode)
+static void lpc32xx_nand_ecc_enable(struct nand_chip *chip, int mode)
 {
 	/* Hardware ECC is enabled automatically in hardware as needed */
 }
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 9d684f1d9e26..fd0563fc4ad2 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -3272,7 +3272,7 @@ static int nand_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 		return ret;
 
 	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize) {
-		chip->ecc.hwctl(mtd, NAND_ECC_READ);
+		chip->ecc.hwctl(chip, NAND_ECC_READ);
 
 		ret = nand_read_data_op(chip, p, eccsize, false);
 		if (ret)
@@ -3358,7 +3358,7 @@ static int nand_read_page_hwecc_oob_first(struct mtd_info *mtd,
 	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize) {
 		int stat;
 
-		chip->ecc.hwctl(mtd, NAND_ECC_READ);
+		chip->ecc.hwctl(chip, NAND_ECC_READ);
 
 		ret = nand_read_data_op(chip, p, eccsize, false);
 		if (ret)
@@ -3415,7 +3415,7 @@ static int nand_read_page_syndrome(struct mtd_info *mtd, struct nand_chip *chip,
 	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize) {
 		int stat;
 
-		chip->ecc.hwctl(mtd, NAND_ECC_READ);
+		chip->ecc.hwctl(chip, NAND_ECC_READ);
 
 		ret = nand_read_data_op(chip, p, eccsize, false);
 		if (ret)
@@ -3430,7 +3430,7 @@ static int nand_read_page_syndrome(struct mtd_info *mtd, struct nand_chip *chip,
 			oob += chip->ecc.prepad;
 		}
 
-		chip->ecc.hwctl(mtd, NAND_ECC_READSYN);
+		chip->ecc.hwctl(chip, NAND_ECC_READSYN);
 
 		ret = nand_read_data_op(chip, oob, eccbytes, false);
 		if (ret)
@@ -4151,7 +4151,7 @@ static int nand_write_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 		return ret;
 
 	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize) {
-		chip->ecc.hwctl(mtd, NAND_ECC_WRITE);
+		chip->ecc.hwctl(chip, NAND_ECC_WRITE);
 
 		ret = nand_write_data_op(chip, p, eccsize, false);
 		if (ret)
@@ -4204,7 +4204,7 @@ static int nand_write_subpage_hwecc(struct mtd_info *mtd,
 
 	for (step = 0; step < ecc_steps; step++) {
 		/* configure controller for WRITE access */
-		chip->ecc.hwctl(mtd, NAND_ECC_WRITE);
+		chip->ecc.hwctl(chip, NAND_ECC_WRITE);
 
 		/* write data (untouched subpages already masked by 0xFF) */
 		ret = nand_write_data_op(chip, buf, ecc_size, false);
@@ -4272,7 +4272,7 @@ static int nand_write_page_syndrome(struct mtd_info *mtd,
 		return ret;
 
 	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize) {
-		chip->ecc.hwctl(mtd, NAND_ECC_WRITE);
+		chip->ecc.hwctl(chip, NAND_ECC_WRITE);
 
 		ret = nand_write_data_op(chip, p, eccsize, false);
 		if (ret)
diff --git a/drivers/mtd/nand/raw/ndfc.c b/drivers/mtd/nand/raw/ndfc.c
index ab24e9ca769b..f9648d87b2e7 100644
--- a/drivers/mtd/nand/raw/ndfc.c
+++ b/drivers/mtd/nand/raw/ndfc.c
@@ -81,10 +81,9 @@ static int ndfc_ready(struct mtd_info *mtd)
 	return in_be32(ndfc->ndfcbase + NDFC_STAT) & NDFC_STAT_IS_READY;
 }
 
-static void ndfc_enable_hwecc(struct mtd_info *mtd, int mode)
+static void ndfc_enable_hwecc(struct nand_chip *chip, int mode)
 {
 	uint32_t ccr;
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct ndfc_controller *ndfc = nand_get_controller_data(chip);
 
 	ccr = in_be32(ndfc->ndfcbase + NDFC_CCR);
diff --git a/drivers/mtd/nand/raw/omap2.c b/drivers/mtd/nand/raw/omap2.c
index b243f2ab3622..bba403b4e262 100644
--- a/drivers/mtd/nand/raw/omap2.c
+++ b/drivers/mtd/nand/raw/omap2.c
@@ -935,10 +935,9 @@ static int omap_calculate_ecc(struct mtd_info *mtd, const u_char *dat,
  * @mtd: MTD device structure
  * @mode: Read/Write mode
  */
-static void omap_enable_hwecc(struct mtd_info *mtd, int mode)
+static void omap_enable_hwecc(struct nand_chip *chip, int mode)
 {
-	struct omap_nand_info *info = mtd_to_omap(mtd);
-	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct omap_nand_info *info = mtd_to_omap(nand_to_mtd(chip));
 	unsigned int dev_width = (chip->options & NAND_BUSWIDTH_16) ? 1 : 0;
 	u32 val;
 
@@ -1030,13 +1029,13 @@ static int omap_dev_ready(struct mtd_info *mtd)
  * eccsize0 = 0  (no additional protected byte in spare area)
  * eccsize1 = 32 (skip 32 nibbles = 16 bytes per sector in spare area)
  */
-static void __maybe_unused omap_enable_hwecc_bch(struct mtd_info *mtd, int mode)
+static void __maybe_unused omap_enable_hwecc_bch(struct nand_chip *chip,
+						 int mode)
 {
 	unsigned int bch_type;
 	unsigned int dev_width, nsectors;
-	struct omap_nand_info *info = mtd_to_omap(mtd);
+	struct omap_nand_info *info = mtd_to_omap(nand_to_mtd(chip));
 	enum omap_ecc ecc_opt = info->ecc_opt;
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	u32 val, wr_mode;
 	unsigned int ecc_size1, ecc_size0;
 
@@ -1529,7 +1528,7 @@ static int omap_write_page_bch(struct mtd_info *mtd, struct nand_chip *chip,
 	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
 
 	/* Enable GPMC ecc engine */
-	chip->ecc.hwctl(mtd, NAND_ECC_WRITE);
+	chip->ecc.hwctl(chip, NAND_ECC_WRITE);
 
 	/* Write data */
 	chip->write_buf(mtd, buf, mtd->writesize);
@@ -1582,7 +1581,7 @@ static int omap_write_subpage_bch(struct mtd_info *mtd,
 	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
 
 	/* Enable GPMC ECC engine */
-	chip->ecc.hwctl(mtd, NAND_ECC_WRITE);
+	chip->ecc.hwctl(chip, NAND_ECC_WRITE);
 
 	/* Write data */
 	chip->write_buf(mtd, buf, mtd->writesize);
@@ -1641,7 +1640,7 @@ static int omap_read_page_bch(struct mtd_info *mtd, struct nand_chip *chip,
 	nand_read_page_op(chip, page, 0, NULL, 0);
 
 	/* Enable GPMC ecc engine */
-	chip->ecc.hwctl(mtd, NAND_ECC_READ);
+	chip->ecc.hwctl(chip, NAND_ECC_READ);
 
 	/* Read data */
 	chip->read_buf(mtd, buf, mtd->writesize);
diff --git a/drivers/mtd/nand/raw/r852.c b/drivers/mtd/nand/raw/r852.c
index bb74a0ac697e..b5e0cc611b14 100644
--- a/drivers/mtd/nand/raw/r852.c
+++ b/drivers/mtd/nand/raw/r852.c
@@ -401,9 +401,9 @@ static int r852_ready(struct mtd_info *mtd)
  * Set ECC engine mode
 */
 
-static void r852_ecc_hwctl(struct mtd_info *mtd, int mode)
+static void r852_ecc_hwctl(struct nand_chip *chip, int mode)
 {
-	struct r852_device *dev = r852_get_dev(mtd);
+	struct r852_device *dev = r852_get_dev(nand_to_mtd(chip));
 
 	if (dev->card_unstable)
 		return;
diff --git a/drivers/mtd/nand/raw/s3c2410.c b/drivers/mtd/nand/raw/s3c2410.c
index cf045813c160..ca2d006cc846 100644
--- a/drivers/mtd/nand/raw/s3c2410.c
+++ b/drivers/mtd/nand/raw/s3c2410.c
@@ -591,31 +591,34 @@ static int s3c2410_nand_correct_data(struct mtd_info *mtd, u_char *dat,
  * generator block to ECC the data as it passes through]
 */
 
-static void s3c2410_nand_enable_hwecc(struct mtd_info *mtd, int mode)
+static void s3c2410_nand_enable_hwecc(struct nand_chip *chip, int mode)
 {
-	struct s3c2410_nand_info *info = s3c2410_nand_mtd_toinfo(mtd);
+	struct s3c2410_nand_info *info;
 	unsigned long ctrl;
 
+	info = s3c2410_nand_mtd_toinfo(nand_to_mtd(chip));
 	ctrl = readl(info->regs + S3C2410_NFCONF);
 	ctrl |= S3C2410_NFCONF_INITECC;
 	writel(ctrl, info->regs + S3C2410_NFCONF);
 }
 
-static void s3c2412_nand_enable_hwecc(struct mtd_info *mtd, int mode)
+static void s3c2412_nand_enable_hwecc(struct nand_chip *chip, int mode)
 {
-	struct s3c2410_nand_info *info = s3c2410_nand_mtd_toinfo(mtd);
+	struct s3c2410_nand_info *info;
 	unsigned long ctrl;
 
+	info = s3c2410_nand_mtd_toinfo(nand_to_mtd(chip));
 	ctrl = readl(info->regs + S3C2440_NFCONT);
 	writel(ctrl | S3C2412_NFCONT_INIT_MAIN_ECC,
 	       info->regs + S3C2440_NFCONT);
 }
 
-static void s3c2440_nand_enable_hwecc(struct mtd_info *mtd, int mode)
+static void s3c2440_nand_enable_hwecc(struct nand_chip *chip, int mode)
 {
-	struct s3c2410_nand_info *info = s3c2410_nand_mtd_toinfo(mtd);
+	struct s3c2410_nand_info *info;
 	unsigned long ctrl;
 
+	info = s3c2410_nand_mtd_toinfo(nand_to_mtd(chip));
 	ctrl = readl(info->regs + S3C2440_NFCONT);
 	writel(ctrl | S3C2440_NFCONT_INITECC, info->regs + S3C2440_NFCONT);
 }
diff --git a/drivers/mtd/nand/raw/sharpsl.c b/drivers/mtd/nand/raw/sharpsl.c
index c8eb4654bb1c..37fdaad82f37 100644
--- a/drivers/mtd/nand/raw/sharpsl.c
+++ b/drivers/mtd/nand/raw/sharpsl.c
@@ -85,9 +85,9 @@ static int sharpsl_nand_dev_ready(struct mtd_info *mtd)
 	return !((readb(sharpsl->io + FLASHCTL) & FLRYBY) == 0);
 }
 
-static void sharpsl_nand_enable_hwecc(struct mtd_info *mtd, int mode)
+static void sharpsl_nand_enable_hwecc(struct nand_chip *chip, int mode)
 {
-	struct sharpsl_nand *sharpsl = mtd_to_sharpsl(mtd);
+	struct sharpsl_nand *sharpsl = mtd_to_sharpsl(nand_to_mtd(chip));
 	writeb(0, sharpsl->io + ECCCLRR);
 }
 
diff --git a/drivers/mtd/nand/raw/tmio_nand.c b/drivers/mtd/nand/raw/tmio_nand.c
index 39594910e6f0..2578216ff5c0 100644
--- a/drivers/mtd/nand/raw/tmio_nand.c
+++ b/drivers/mtd/nand/raw/tmio_nand.c
@@ -259,9 +259,9 @@ static void tmio_nand_read_buf(struct mtd_info *mtd, u_char *buf, int len)
 	tmio_ioread16_rep(tmio->fcr + FCR_DATA, buf, len >> 1);
 }
 
-static void tmio_nand_enable_hwecc(struct mtd_info *mtd, int mode)
+static void tmio_nand_enable_hwecc(struct nand_chip *chip, int mode)
 {
-	struct tmio_nand *tmio = mtd_to_tmio(mtd);
+	struct tmio_nand *tmio = mtd_to_tmio(nand_to_mtd(chip));
 
 	tmio_iowrite8(FCR_MODE_HWECC_RESET, tmio->fcr + FCR_MODE);
 	tmio_ioread8(tmio->fcr + FCR_DATA);	/* dummy read */
diff --git a/drivers/mtd/nand/raw/txx9ndfmc.c b/drivers/mtd/nand/raw/txx9ndfmc.c
index f722aae2b244..fea5bc684aa1 100644
--- a/drivers/mtd/nand/raw/txx9ndfmc.c
+++ b/drivers/mtd/nand/raw/txx9ndfmc.c
@@ -211,9 +211,9 @@ static int txx9ndfmc_correct_data(struct mtd_info *mtd, unsigned char *buf,
 	return corrected;
 }
 
-static void txx9ndfmc_enable_hwecc(struct mtd_info *mtd, int mode)
+static void txx9ndfmc_enable_hwecc(struct nand_chip *chip, int mode)
 {
-	struct platform_device *dev = mtd_to_platdev(mtd);
+	struct platform_device *dev = mtd_to_platdev(nand_to_mtd(chip));
 	u32 mcr = txx9ndfmc_read(dev, TXX9_NDFMCR);
 
 	mcr &= ~TXX9_NDFMCR_ECC_ALL;
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 55014e42912a..029fef900f33 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -647,7 +647,7 @@ struct nand_ecc_ctrl {
 	void *priv;
 	u8 *calc_buf;
 	u8 *code_buf;
-	void (*hwctl)(struct mtd_info *mtd, int mode);
+	void (*hwctl)(struct nand_chip *chip, int mode);
 	int (*calculate)(struct mtd_info *mtd, const uint8_t *dat,
 			uint8_t *ecc_code);
 	int (*correct)(struct mtd_info *mtd, uint8_t *dat, uint8_t *read_ecc,
-- 
2.14.1
