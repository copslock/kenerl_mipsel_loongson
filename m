Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Feb 2016 11:20:26 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:38189 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27012610AbcBDKI1OI6OO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Feb 2016 11:08:27 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 9D74B4937; Thu,  4 Feb 2016 11:08:17 +0100 (CET)
Received: from localhost.localdomain (AToulouse-657-1-20-139.w83-193.abo.wanadoo.fr [83.193.84.139])
        by mail.free-electrons.com (Postfix) with ESMTPSA id A55D54564;
        Thu,  4 Feb 2016 11:07:47 +0100 (CET)
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
        Josh Wu <josh.wu@atmel.com>,
        Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com,
        Stefan Agner <stefan@agner.ch>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        punnaiah choudary kalluri <punnaia@xilinx.com>,
        Priit Laes <plaes@plaes.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v2 43/51] mtd: nand: s3c2410: switch to mtd_ooblayout_ops
Date:   Thu,  4 Feb 2016 11:07:06 +0100
Message-Id: <1454580434-32078-44-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1454580434-32078-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1454580434-32078-1-git-send-email-boris.brezillon@free-electrons.com>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51761
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

Implementing the mtd_ooblayout_ops interface is the new way of exposing
ECC/OOB layout to MTD users.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/s3c2410.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/s3c2410.c b/drivers/mtd/nand/s3c2410.c
index 9c9397b..efa339b 100644
--- a/drivers/mtd/nand/s3c2410.c
+++ b/drivers/mtd/nand/s3c2410.c
@@ -84,11 +84,33 @@
 
 /* new oob placement block for use with hardware ecc generation
  */
+static int s3c2410_ooblayout_ecc(struct mtd_info *mtd, int section,
+				 struct mtd_oov_region *oobregion)
+{
+	if (section)
+		return -ERANGE;
+
+	oobregion->offset = 0;
+	oobregion->length = 3;
+
+	return 0;
+}
+
+static int s3c2410_ooblayout_free(struct mtd_info *mtd, int section,
+				  struct mtd_oov_region *oobregion)
+{
+	if (section)
+		return -ERANGE;
+
+	oobregion->offset = 8;
+	oobregion->length = 8;
+
+	return 0;
+}
 
-static struct nand_ecclayout nand_hw_eccoob = {
-	.eccbytes = 3,
-	.eccpos = {0, 1, 2},
-	.oobfree = {{8, 8}}
+const struct mtd_ooblayout_ops s3c2410_ooblayout_ops = {
+	.eccpos = s3c2410_eccpos,
+	.oobfree = s3c2410_oobfree,
 };
 
 /* controller and mtd information */
@@ -919,7 +941,7 @@ static void s3c2410_nand_update_chip(struct s3c2410_nand_info *info,
 	} else {
 		chip->ecc.size	    = 512;
 		chip->ecc.bytes	    = 3;
-		chip->ecc.layout    = &nand_hw_eccoob;
+		mtd_set_ooblayout(nand_to_mtd(chip), &s3c2410_ooblayout_ops);
 	}
 }
 
-- 
2.1.4
