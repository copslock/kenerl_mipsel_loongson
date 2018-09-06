Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Sep 2018 00:40:29 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:35487 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994655AbeIFWjJCc2nL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 7 Sep 2018 00:39:09 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4E197208B5; Fri,  7 Sep 2018 00:39:09 +0200 (CEST)
Received: from localhost.localdomain (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id CA9602089C;
        Fri,  7 Sep 2018 00:39:07 +0200 (CEST)
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
Subject: [PATCH 10/19] mtd: rawnand: Move function prototypes after struct declarations
Date:   Fri,  7 Sep 2018 00:38:42 +0200
Message-Id: <20180906223851.6964-11-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180906223851.6964-1-boris.brezillon@bootlin.com>
References: <20180906223851.6964-1-boris.brezillon@bootlin.com>
Return-Path: <boris.brezillon@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66107
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

Move nand_scan[_with_ids]() and nand_wait_ready() at the end of the
file where all function prototype lies. This will also allow us to get
rid of the nand_flash_dev forward declaration.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 include/linux/mtd/rawnand.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 992d78d29674..15183b73fed2 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -27,18 +27,6 @@
 struct nand_chip;
 struct nand_flash_dev;
 
-/* Scan and identify a NAND device */
-int nand_scan_with_ids(struct nand_chip *chip, unsigned int max_chips,
-		       struct nand_flash_dev *ids);
-
-static inline int nand_scan(struct nand_chip *chip, unsigned int max_chips)
-{
-	return nand_scan_with_ids(chip, max_chips, NULL);
-}
-
-/* Internal helper for board drivers which need to override command function */
-void nand_wait_ready(struct nand_chip *chip);
-
 /* The maximum number of NAND chips in an array */
 #define NAND_MAX_CHIPS		8
 
@@ -1739,6 +1727,18 @@ int nand_read_data_op(struct nand_chip *chip, void *buf, unsigned int len,
 int nand_write_data_op(struct nand_chip *chip, const void *buf,
 		       unsigned int len, bool force_8bit);
 
+/* Scan and identify a NAND device */
+int nand_scan_with_ids(struct nand_chip *chip, unsigned int max_chips,
+		       struct nand_flash_dev *ids);
+
+static inline int nand_scan(struct nand_chip *chip, unsigned int max_chips)
+{
+	return nand_scan_with_ids(chip, max_chips, NULL);
+}
+
+/* Internal helper for board drivers which need to override command function */
+void nand_wait_ready(struct nand_chip *chip);
+
 /*
  * Free resources held by the NAND device, must be called on error after a
  * sucessful nand_scan().
-- 
2.14.1
