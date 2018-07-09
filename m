Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jul 2018 22:11:37 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:49390 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993973AbeGIUKPZJPjt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 Jul 2018 22:10:15 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E214B208FC; Mon,  9 Jul 2018 22:10:05 +0200 (CEST)
Received: from localhost.localdomain (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 805B9208FD;
        Mon,  9 Jul 2018 22:09:55 +0200 (CEST)
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-wireless@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 07/24] mtd: rawnand: davinci: Stop doing iomem pointer <-> u32 conversions
Date:   Mon,  9 Jul 2018 22:09:28 +0200
Message-Id: <20180709200945.30116-8-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180709200945.30116-1-boris.brezillon@bootlin.com>
References: <20180709200945.30116-1-boris.brezillon@bootlin.com>
Return-Path: <boris.brezillon@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64727
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

There is no point in doing this sort of conversion since pointers can
we can replace |= by += operations which are perfectly valid on
pointers.

This is done in preparation of COMPILE_TEST addition to the NAND_DAVINCI
Kconfig entry, since building for x86 generates a several warnings
because of inappropriate u32 <-> void * conversions (pointers are 64bits
large on x86_64).

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/davinci_nand.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/davinci_nand.c
index cd12e5abafde..9cd36a750965 100644
--- a/drivers/mtd/nand/raw/davinci_nand.c
+++ b/drivers/mtd/nand/raw/davinci_nand.c
@@ -60,8 +60,7 @@ struct davinci_nand_info {
 	void __iomem		*base;
 	void __iomem		*vaddr;
 
-	uint32_t		ioaddr;
-	uint32_t		current_cs;
+	void __iomem		*current_cs;
 
 	uint32_t		mask_chipsel;
 	uint32_t		mask_ale;
@@ -102,17 +101,17 @@ static void nand_davinci_hwcontrol(struct mtd_info *mtd, int cmd,
 				   unsigned int ctrl)
 {
 	struct davinci_nand_info	*info = to_davinci_nand(mtd);
-	uint32_t			addr = info->current_cs;
+	void __iomem			*addr = info->current_cs;
 	struct nand_chip		*nand = mtd_to_nand(mtd);
 
 	/* Did the control lines change? */
 	if (ctrl & NAND_CTRL_CHANGE) {
 		if ((ctrl & NAND_CTRL_CLE) == NAND_CTRL_CLE)
-			addr |= info->mask_cle;
+			addr += info->mask_cle;
 		else if ((ctrl & NAND_CTRL_ALE) == NAND_CTRL_ALE)
-			addr |= info->mask_ale;
+			addr += info->mask_ale;
 
-		nand->IO_ADDR_W = (void __iomem __force *)addr;
+		nand->IO_ADDR_W = addr;
 	}
 
 	if (cmd != NAND_CMD_NONE)
@@ -122,14 +121,14 @@ static void nand_davinci_hwcontrol(struct mtd_info *mtd, int cmd,
 static void nand_davinci_select_chip(struct mtd_info *mtd, int chip)
 {
 	struct davinci_nand_info	*info = to_davinci_nand(mtd);
-	uint32_t			addr = info->ioaddr;
+
+	info->current_cs = info->vaddr;
 
 	/* maybe kick in a second chipselect */
 	if (chip > 0)
-		addr |= info->mask_chipsel;
-	info->current_cs = addr;
+		info->current_cs += info->mask_chipsel;
 
-	info->chip.IO_ADDR_W = (void __iomem __force *)addr;
+	info->chip.IO_ADDR_W = info->current_cs;
 	info->chip.IO_ADDR_R = info->chip.IO_ADDR_W;
 }
 
@@ -680,9 +679,7 @@ static int nand_davinci_probe(struct platform_device *pdev)
 	info->chip.bbt_md	= pdata->bbt_md;
 	info->timing		= pdata->timing;
 
-	info->ioaddr		= (uint32_t __force) vaddr;
-
-	info->current_cs	= info->ioaddr;
+	info->current_cs	= info->vaddr;
 	info->core_chipsel	= pdata->core_chipsel;
 	info->mask_chipsel	= pdata->mask_chipsel;
 
-- 
2.14.1
