Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Aug 2018 18:14:36 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:54552 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994686AbeHQQJ4QTOiq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Aug 2018 18:09:56 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1220E215CB; Fri, 17 Aug 2018 18:09:48 +0200 (CEST)
Received: from localhost.localdomain (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id C1549215DC;
        Fri, 17 Aug 2018 18:09:46 +0200 (CEST)
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
Subject: [PATCH 19/23] mtd: rawnand: Pass a nand_chip object to chip->{get,set}_features()
Date:   Fri, 17 Aug 2018 18:09:18 +0200
Message-Id: <20180817160922.6224-20-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180817160922.6224-1-boris.brezillon@bootlin.com>
References: <20180817160922.6224-1-boris.brezillon@bootlin.com>
Return-Path: <boris.brezillon@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65628
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

Let's tackle the chip->{get,set}_features() hooks.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/mxc_nand.c  | 16 ++++++++--------
 drivers/mtd/nand/raw/nand_base.c | 21 ++++++---------------
 include/linux/mtd/rawnand.h      | 12 ++++++------
 3 files changed, 20 insertions(+), 29 deletions(-)

diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
index a03a33656cf4..ec150e19a368 100644
--- a/drivers/mtd/nand/raw/mxc_nand.c
+++ b/drivers/mtd/nand/raw/mxc_nand.c
@@ -1393,11 +1393,11 @@ static void mxc_nand_command(struct nand_chip *nand_chip, unsigned command,
 	}
 }
 
-static int mxc_nand_set_features(struct mtd_info *mtd, struct nand_chip *chip,
-				 int addr, u8 *subfeature_param)
+static int mxc_nand_set_features(struct nand_chip *chip, int addr,
+				 u8 *subfeature_param)
 {
-	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct mxc_nand_host *host = nand_get_controller_data(nand_chip);
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct mxc_nand_host *host = nand_get_controller_data(chip);
 	int i;
 
 	host->buf_start = 0;
@@ -1413,11 +1413,11 @@ static int mxc_nand_set_features(struct mtd_info *mtd, struct nand_chip *chip,
 	return 0;
 }
 
-static int mxc_nand_get_features(struct mtd_info *mtd, struct nand_chip *chip,
-				 int addr, u8 *subfeature_param)
+static int mxc_nand_get_features(struct nand_chip *chip, int addr,
+				 u8 *subfeature_param)
 {
-	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct mxc_nand_host *host = nand_get_controller_data(nand_chip);
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct mxc_nand_host *host = nand_get_controller_data(chip);
 	int i;
 
 	host->devtype_data->send_cmd(host, NAND_CMD_GET_FEATURES, false);
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 26be436eb8f1..0ae597ced5b4 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -1163,12 +1163,10 @@ static bool nand_supports_set_features(struct nand_chip *chip, int addr)
 int nand_get_features(struct nand_chip *chip, int addr,
 		      u8 *subfeature_param)
 {
-	struct mtd_info *mtd = nand_to_mtd(chip);
-
 	if (!nand_supports_get_features(chip, addr))
 		return -ENOTSUPP;
 
-	return chip->get_features(mtd, chip, addr, subfeature_param);
+	return chip->get_features(chip, addr, subfeature_param);
 }
 EXPORT_SYMBOL_GPL(nand_get_features);
 
@@ -1184,12 +1182,10 @@ EXPORT_SYMBOL_GPL(nand_get_features);
 int nand_set_features(struct nand_chip *chip, int addr,
 		      u8 *subfeature_param)
 {
-	struct mtd_info *mtd = nand_to_mtd(chip);
-
 	if (!nand_supports_set_features(chip, addr))
 		return -ENOTSUPP;
 
-	return chip->set_features(mtd, chip, addr, subfeature_param);
+	return chip->set_features(chip, addr, subfeature_param);
 }
 EXPORT_SYMBOL_GPL(nand_set_features);
 
@@ -4846,13 +4842,11 @@ static int nand_max_bad_blocks(struct mtd_info *mtd, loff_t ofs, size_t len)
 
 /**
  * nand_default_set_features- [REPLACEABLE] set NAND chip features
- * @mtd: MTD device structure
  * @chip: nand chip info structure
  * @addr: feature address.
  * @subfeature_param: the subfeature parameters, a four bytes array.
  */
-static int nand_default_set_features(struct mtd_info *mtd,
-				     struct nand_chip *chip, int addr,
+static int nand_default_set_features(struct nand_chip *chip, int addr,
 				     uint8_t *subfeature_param)
 {
 	return nand_set_features_op(chip, addr, subfeature_param);
@@ -4860,13 +4854,11 @@ static int nand_default_set_features(struct mtd_info *mtd,
 
 /**
  * nand_default_get_features- [REPLACEABLE] get NAND chip features
- * @mtd: MTD device structure
  * @chip: nand chip info structure
  * @addr: feature address.
  * @subfeature_param: the subfeature parameters, a four bytes array.
  */
-static int nand_default_get_features(struct mtd_info *mtd,
-				     struct nand_chip *chip, int addr,
+static int nand_default_get_features(struct nand_chip *chip, int addr,
 				     uint8_t *subfeature_param)
 {
 	return nand_get_features_op(chip, addr, subfeature_param);
@@ -4874,7 +4866,6 @@ static int nand_default_get_features(struct mtd_info *mtd,
 
 /**
  * nand_get_set_features_notsupp - set/get features stub returning -ENOTSUPP
- * @mtd: MTD device structure
  * @chip: nand chip info structure
  * @addr: feature address.
  * @subfeature_param: the subfeature parameters, a four bytes array.
@@ -4882,8 +4873,8 @@ static int nand_default_get_features(struct mtd_info *mtd,
  * Should be used by NAND controller drivers that do not support the SET/GET
  * FEATURES operations.
  */
-int nand_get_set_features_notsupp(struct mtd_info *mtd, struct nand_chip *chip,
-				  int addr, u8 *subfeature_param)
+int nand_get_set_features_notsupp(struct nand_chip *chip, int addr,
+				  u8 *subfeature_param)
 {
 	return -ENOTSUPP;
 }
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 469008740e89..471ad78d27a5 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1299,10 +1299,10 @@ struct nand_chip {
 		       const struct nand_operation *op,
 		       bool check_only);
 	int (*erase)(struct nand_chip *chip, int page);
-	int (*set_features)(struct mtd_info *mtd, struct nand_chip *chip,
-			    int feature_addr, uint8_t *subfeature_para);
-	int (*get_features)(struct mtd_info *mtd, struct nand_chip *chip,
-			    int feature_addr, uint8_t *subfeature_para);
+	int (*set_features)(struct nand_chip *chip, int feature_addr,
+			    uint8_t *subfeature_para);
+	int (*get_features)(struct nand_chip *chip, int feature_addr,
+			    uint8_t *subfeature_para);
 	int (*setup_read_retry)(struct mtd_info *mtd, int retry_mode);
 	int (*setup_data_interface)(struct mtd_info *mtd, int chipnr,
 				    const struct nand_data_interface *conf);
@@ -1681,8 +1681,8 @@ int nand_read_oob_syndrome(struct nand_chip *chip, int page);
 int nand_get_features(struct nand_chip *chip, int addr, u8 *subfeature_param);
 int nand_set_features(struct nand_chip *chip, int addr, u8 *subfeature_param);
 /* Stub used by drivers that do not support GET/SET FEATURES operations */
-int nand_get_set_features_notsupp(struct mtd_info *mtd, struct nand_chip *chip,
-				  int addr, u8 *subfeature_param);
+int nand_get_set_features_notsupp(struct nand_chip *chip, int addr,
+				  u8 *subfeature_param);
 
 /* Default read_page_raw implementation */
 int nand_read_page_raw(struct nand_chip *chip, uint8_t *buf, int oob_required,
-- 
2.14.1
