Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Feb 2016 11:10:01 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:37393 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27011610AbcBDKH2Z8OEO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Feb 2016 11:07:28 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 6331E2E1; Thu,  4 Feb 2016 11:07:23 +0100 (CET)
Received: from localhost.localdomain (AToulouse-657-1-20-139.w83-193.abo.wanadoo.fr [83.193.84.139])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 518BB2D9;
        Thu,  4 Feb 2016 11:07:22 +0100 (CET)
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
Subject: [PATCH v2 09/51] mtd: nand: fsl_ifc: use mtd_ooblayout_xxx() helpers where appropriate
Date:   Thu,  4 Feb 2016 11:06:32 +0100
Message-Id: <1454580434-32078-10-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1454580434-32078-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1454580434-32078-1-git-send-email-boris.brezillon@free-electrons.com>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51727
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

The mtd_ooblayout_xxx() helper functions have been added to avoid direct
accesses to the ecclayout field, and thus ease for future reworks.
Use these helpers in all places where the oobfree[] and eccpos[] arrays
where directly accessed.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/fsl_ifc_nand.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/fsl_ifc_nand.c b/drivers/mtd/nand/fsl_ifc_nand.c
index 43f5a3a..2e970ac 100644
--- a/drivers/mtd/nand/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/fsl_ifc_nand.c
@@ -257,18 +257,22 @@ static int is_blank(struct mtd_info *mtd, unsigned int bufnum)
 	u8 __iomem *addr = priv->vbase + bufnum * (mtd->writesize * 2);
 	u32 __iomem *mainarea = (u32 __iomem *)addr;
 	u8 __iomem *oob = addr + mtd->writesize;
-	int i;
+	struct mtd_oob_region oobregion = { };
+	int i, section = 0;
 
 	for (i = 0; i < mtd->writesize / 4; i++) {
 		if (__raw_readl(&mainarea[i]) != 0xffffffff)
 			return 0;
 	}
 
-	for (i = 0; i < chip->ecc.layout->eccbytes; i++) {
-		int pos = chip->ecc.layout->eccpos[i];
+	mtd_ooblayout_ecc(mtd, section++, &oobregion);
+	while (oobregion.length) {
+		for (i = 0; i < oobregion.length; i++) {
+			if (__raw_readb(&oob[oobregion.offset + i]) != 0xff)
+				return 0;
+		}
 
-		if (__raw_readb(&oob[pos]) != 0xff)
-			return 0;
+		mtd_ooblayout_ecc(mtd, section++, &oobregion);
 	}
 
 	return 1;
-- 
2.1.4
