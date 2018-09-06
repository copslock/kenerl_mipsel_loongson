Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Sep 2018 14:06:43 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:43407 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994641AbeIFMFu2z47e (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 6 Sep 2018 14:05:50 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8C525208BE; Thu,  6 Sep 2018 14:05:44 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-30-219.w90-88.abo.wanadoo.fr [90.88.15.219])
        by mail.bootlin.com (Postfix) with ESMTPSA id 844412079D;
        Thu,  6 Sep 2018 14:05:43 +0200 (CEST)
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
Subject: [PATCH v2 04/23] mtd: rawnand: Pass a nand_chip object to nand_wait_ready()
Date:   Thu,  6 Sep 2018 14:05:16 +0200
Message-Id: <20180906120535.21255-5-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180906120535.21255-1-boris.brezillon@bootlin.com>
References: <20180906120535.21255-1-boris.brezillon@bootlin.com>
Return-Path: <boris.brezillon@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66035
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

Let's make the raw NAND API consistent by patching all helpers to
take a nand_chip object instead of an mtd_info one.

Now is nand_wait_ready()'s turn.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c |  2 +-
 drivers/mtd/nand/raw/cafe_nand.c                 |  2 +-
 drivers/mtd/nand/raw/nand_base.c                 | 12 ++++++------
 include/linux/mtd/rawnand.h                      |  2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c b/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
index 9b62bc2d25a0..7022ffd271ad 100644
--- a/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
+++ b/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
@@ -232,7 +232,7 @@ static void bcm47xxnflash_ops_bcm4706_cmdfunc(struct mtd_info *mtd,
 		nand_chip->cmd_ctrl(mtd, command, NAND_CTRL_CLE);
 
 		ndelay(100);
-		nand_wait_ready(mtd);
+		nand_wait_ready(nand_chip);
 		break;
 	case NAND_CMD_READID:
 		ctlcode = NCTL_CSA | 0x01000000 | NCTL_CMD1W | NCTL_CMD0;
diff --git a/drivers/mtd/nand/raw/cafe_nand.c b/drivers/mtd/nand/raw/cafe_nand.c
index 3304594177c6..94e5f7a56084 100644
--- a/drivers/mtd/nand/raw/cafe_nand.c
+++ b/drivers/mtd/nand/raw/cafe_nand.c
@@ -313,7 +313,7 @@ static void cafe_nand_cmdfunc(struct mtd_info *mtd, unsigned command,
 		cafe_writel(cafe, cafe->ctl2, NAND_CTRL2);
 		return;
 	}
-	nand_wait_ready(mtd);
+	nand_wait_ready(chip);
 	cafe_writel(cafe, cafe->ctl2, NAND_CTRL2);
 }
 
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index f937efe145af..9d684f1d9e26 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -624,13 +624,13 @@ static void panic_nand_wait_ready(struct mtd_info *mtd, unsigned long timeo)
 
 /**
  * nand_wait_ready - [GENERIC] Wait for the ready pin after commands.
- * @mtd: MTD device structure
+ * @chip: NAND chip object
  *
  * Wait for the ready pin after a command, and warn if a timeout occurs.
  */
-void nand_wait_ready(struct mtd_info *mtd)
+void nand_wait_ready(struct nand_chip *chip)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	unsigned long timeo = 400;
 
 	if (in_interrupt() || oops_in_progress)
@@ -852,7 +852,7 @@ static void nand_command(struct mtd_info *mtd, unsigned int command,
 	 */
 	ndelay(100);
 
-	nand_wait_ready(mtd);
+	nand_wait_ready(chip);
 }
 
 static void nand_ccs_delay(struct nand_chip *chip)
@@ -1004,7 +1004,7 @@ static void nand_command_lp(struct mtd_info *mtd, unsigned int command,
 	 */
 	ndelay(100);
 
-	nand_wait_ready(mtd);
+	nand_wait_ready(chip);
 }
 
 /**
@@ -2251,7 +2251,7 @@ static int nand_wait_rdy_op(struct nand_chip *chip, unsigned int timeout_ms,
 	if (!chip->dev_ready)
 		udelay(chip->chip_delay);
 	else
-		nand_wait_ready(nand_to_mtd(chip));
+		nand_wait_ready(chip);
 
 	return 0;
 }
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index e9c59f0624ad..55014e42912a 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -37,7 +37,7 @@ static inline int nand_scan(struct nand_chip *chip, int max_chips)
 }
 
 /* Internal helper for board drivers which need to override command function */
-void nand_wait_ready(struct mtd_info *mtd);
+void nand_wait_ready(struct nand_chip *chip);
 
 /* The maximum number of NAND chips in an array */
 #define NAND_MAX_CHIPS		8
-- 
2.14.1
