Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Aug 2018 18:13:44 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:54509 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994684AbeHQQJwzOO1q (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Aug 2018 18:09:52 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C86A0215E1; Fri, 17 Aug 2018 18:09:46 +0200 (CEST)
Received: from localhost.localdomain (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 93AE0215D6;
        Fri, 17 Aug 2018 18:09:45 +0200 (CEST)
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
Subject: [PATCH 18/23] mtd: rawnand: Pass a nand_chip object to chip->erase()
Date:   Fri, 17 Aug 2018 18:09:17 +0200
Message-Id: <20180817160922.6224-19-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180817160922.6224-1-boris.brezillon@bootlin.com>
References: <20180817160922.6224-1-boris.brezillon@bootlin.com>
Return-Path: <boris.brezillon@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65624
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

Let's tackle the chip->erase() hook.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/denali.c    | 4 ++--
 drivers/mtd/nand/raw/docg4.c     | 4 ++--
 drivers/mtd/nand/raw/nand_base.c | 7 +++----
 include/linux/mtd/rawnand.h      | 2 +-
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index 87ca07c8a1b6..fb7d778c3578 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -922,9 +922,9 @@ static int denali_waitfunc(struct nand_chip *chip)
 	return irq_status & INTR__INT_ACT ? 0 : NAND_STATUS_FAIL;
 }
 
-static int denali_erase(struct mtd_info *mtd, int page)
+static int denali_erase(struct nand_chip *chip, int page)
 {
-	struct denali_nand_info *denali = mtd_to_denali(mtd);
+	struct denali_nand_info *denali = mtd_to_denali(nand_to_mtd(chip));
 	uint32_t irq_status;
 
 	denali_reset_irq(denali);
diff --git a/drivers/mtd/nand/raw/docg4.c b/drivers/mtd/nand/raw/docg4.c
index 1a39e9701191..57e880575807 100644
--- a/drivers/mtd/nand/raw/docg4.c
+++ b/drivers/mtd/nand/raw/docg4.c
@@ -892,9 +892,9 @@ static int docg4_read_oob(struct nand_chip *nand, int page)
 	return 0;
 }
 
-static int docg4_erase_block(struct mtd_info *mtd, int page)
+static int docg4_erase_block(struct nand_chip *nand, int page)
 {
-	struct nand_chip *nand = mtd_to_nand(mtd);
+	struct mtd_info *mtd = nand_to_mtd(nand);
 	struct docg4_priv *doc = nand_get_controller_data(nand);
 	void __iomem *docptr = doc->virtadr;
 	uint16_t g4_page;
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 9be0f98c1244..26be436eb8f1 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -4623,14 +4623,13 @@ static int nand_write_oob(struct mtd_info *mtd, loff_t to,
 
 /**
  * single_erase - [GENERIC] NAND standard block erase command function
- * @mtd: MTD device structure
+ * @chip: NAND chip object
  * @page: the page address of the block which will be erased
  *
  * Standard erase command for NAND chips. Returns NAND status.
  */
-static int single_erase(struct mtd_info *mtd, int page)
+static int single_erase(struct nand_chip *chip, int page)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	unsigned int eraseblock;
 
 	/* Send commands to erase a block */
@@ -4715,7 +4714,7 @@ int nand_erase_nand(struct mtd_info *mtd, struct erase_info *instr,
 		    (page + pages_per_block))
 			chip->pagebuf = -1;
 
-		status = chip->erase(mtd, page & chip->pagemask);
+		status = chip->erase(chip, page & chip->pagemask);
 
 		/* See if block erase succeeded */
 		if (status) {
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 520c0932d15a..469008740e89 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1298,7 +1298,7 @@ struct nand_chip {
 	int (*exec_op)(struct nand_chip *chip,
 		       const struct nand_operation *op,
 		       bool check_only);
-	int (*erase)(struct mtd_info *mtd, int page);
+	int (*erase)(struct nand_chip *chip, int page);
 	int (*set_features)(struct mtd_info *mtd, struct nand_chip *chip,
 			    int feature_addr, uint8_t *subfeature_para);
 	int (*get_features)(struct mtd_info *mtd, struct nand_chip *chip,
-- 
2.14.1
