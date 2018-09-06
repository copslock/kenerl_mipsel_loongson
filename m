Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Sep 2018 14:10:17 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:43793 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994657AbeIFMGFqCd1e (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 6 Sep 2018 14:06:05 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CC58C22AED; Thu,  6 Sep 2018 14:06:00 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-30-219.w90-88.abo.wanadoo.fr [90.88.15.219])
        by mail.bootlin.com (Postfix) with ESMTPSA id C5B5122AA9;
        Thu,  6 Sep 2018 14:05:59 +0200 (CEST)
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
Subject: [PATCH v2 20/23] mtd: rawnand: Pass a nand_chip object to chip->setup_read_retry()
Date:   Thu,  6 Sep 2018 14:05:32 +0200
Message-Id: <20180906120535.21255-21-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180906120535.21255-1-boris.brezillon@bootlin.com>
References: <20180906120535.21255-1-boris.brezillon@bootlin.com>
Return-Path: <boris.brezillon@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66051
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
hooks to take a nand_chip object instead of an mtd_info one or
remove the mtd_info object when both are passed.

Let's tackle the chip->setup_read_retry() hook.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/nand_base.c   | 12 +++++-------
 drivers/mtd/nand/raw/nand_hynix.c  |  3 +--
 drivers/mtd/nand/raw/nand_micron.c |  3 +--
 include/linux/mtd/rawnand.h        |  2 +-
 4 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 0ae597ced5b4..a7575aa68c48 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -3475,17 +3475,15 @@ static uint8_t *nand_transfer_oob(struct mtd_info *mtd, uint8_t *oob,
 
 /**
  * nand_setup_read_retry - [INTERN] Set the READ RETRY mode
- * @mtd: MTD device structure
+ * @chip: NAND chip object
  * @retry_mode: the retry mode to use
  *
  * Some vendors supply a special command to shift the Vt threshold, to be used
  * when there are too many bitflips in a page (i.e., ECC error). After setting
  * a new threshold, the host should retry reading the page.
  */
-static int nand_setup_read_retry(struct mtd_info *mtd, int retry_mode)
+static int nand_setup_read_retry(struct nand_chip *chip, int retry_mode)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
-
 	pr_debug("setting READ RETRY mode %d\n", retry_mode);
 
 	if (retry_mode >= chip->read_retries)
@@ -3494,7 +3492,7 @@ static int nand_setup_read_retry(struct mtd_info *mtd, int retry_mode)
 	if (!chip->setup_read_retry)
 		return -EOPNOTSUPP;
 
-	return chip->setup_read_retry(mtd, retry_mode);
+	return chip->setup_read_retry(chip, retry_mode);
 }
 
 static void nand_wait_readrdy(struct nand_chip *chip)
@@ -3619,7 +3617,7 @@ static int nand_do_read_ops(struct mtd_info *mtd, loff_t from,
 			if (mtd->ecc_stats.failed - ecc_failures) {
 				if (retry_mode + 1 < chip->read_retries) {
 					retry_mode++;
-					ret = nand_setup_read_retry(mtd,
+					ret = nand_setup_read_retry(chip,
 							retry_mode);
 					if (ret < 0)
 						break;
@@ -3646,7 +3644,7 @@ static int nand_do_read_ops(struct mtd_info *mtd, loff_t from,
 
 		/* Reset to retry mode 0 */
 		if (retry_mode) {
-			ret = nand_setup_read_retry(mtd, 0);
+			ret = nand_setup_read_retry(chip, 0);
 			if (ret < 0)
 				break;
 			retry_mode = 0;
diff --git a/drivers/mtd/nand/raw/nand_hynix.c b/drivers/mtd/nand/raw/nand_hynix.c
index fa873e517131..bb1c4f8ce785 100644
--- a/drivers/mtd/nand/raw/nand_hynix.c
+++ b/drivers/mtd/nand/raw/nand_hynix.c
@@ -113,9 +113,8 @@ static int hynix_nand_reg_write_op(struct nand_chip *chip, u8 addr, u8 val)
 	return 0;
 }
 
-static int hynix_nand_setup_read_retry(struct mtd_info *mtd, int retry_mode)
+static int hynix_nand_setup_read_retry(struct nand_chip *chip, int retry_mode)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct hynix_nand *hynix = nand_get_manufacturer_data(chip);
 	const u8 *values;
 	int i, ret;
diff --git a/drivers/mtd/nand/raw/nand_micron.c b/drivers/mtd/nand/raw/nand_micron.c
index 2f26dbeb5428..1a5505ccbe54 100644
--- a/drivers/mtd/nand/raw/nand_micron.c
+++ b/drivers/mtd/nand/raw/nand_micron.c
@@ -74,9 +74,8 @@ struct micron_nand {
 	struct micron_on_die_ecc ecc;
 };
 
-static int micron_nand_setup_read_retry(struct mtd_info *mtd, int retry_mode)
+static int micron_nand_setup_read_retry(struct nand_chip *chip, int retry_mode)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	u8 feature[ONFI_SUBFEATURE_PARAM_LEN] = {retry_mode};
 
 	return nand_set_features(chip, ONFI_FEATURE_ADDR_READ_RETRY, feature);
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 7c639070c512..14ce2b078206 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1303,7 +1303,7 @@ struct nand_chip {
 			    uint8_t *subfeature_para);
 	int (*get_features)(struct nand_chip *chip, int feature_addr,
 			    uint8_t *subfeature_para);
-	int (*setup_read_retry)(struct mtd_info *mtd, int retry_mode);
+	int (*setup_read_retry)(struct nand_chip *chip, int retry_mode);
 	int (*setup_data_interface)(struct mtd_info *mtd, int chipnr,
 				    const struct nand_data_interface *conf);
 
-- 
2.14.1
