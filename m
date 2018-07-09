Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jul 2018 22:16:09 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:49427 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994672AbeGIUKThLwBt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 Jul 2018 22:10:19 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 623AE20913; Mon,  9 Jul 2018 22:10:14 +0200 (CEST)
Received: from localhost.localdomain (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id AF0A42091A;
        Mon,  9 Jul 2018 22:09:57 +0200 (CEST)
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
Subject: [PATCH v2 14/24] mtd: rawnand: fsmc: Use uintptr_t casts instead of unsigned ones
Date:   Mon,  9 Jul 2018 22:09:35 +0200
Message-Id: <20180709200945.30116-15-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180709200945.30116-1-boris.brezillon@bootlin.com>
References: <20180709200945.30116-1-boris.brezillon@bootlin.com>
Return-Path: <boris.brezillon@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64744
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

uintptr_t should be used when casting a pointer to an unsigned int so
that the code compiles without warnings even on 64-bit architectures.

This is needed if we want to allow selection of this driver when
COMPILE_TEST=y.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/fsmc_nand.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/fsmc_nand.c b/drivers/mtd/nand/raw/fsmc_nand.c
index d71c49f50e77..527bebc7e6c9 100644
--- a/drivers/mtd/nand/raw/fsmc_nand.c
+++ b/drivers/mtd/nand/raw/fsmc_nand.c
@@ -547,7 +547,7 @@ static void fsmc_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
 	struct fsmc_nand_data *host  = mtd_to_fsmc(mtd);
 	int i;
 
-	if (IS_ALIGNED((uint32_t)buf, sizeof(uint32_t)) &&
+	if (IS_ALIGNED((uintptr_t)buf, sizeof(uint32_t)) &&
 			IS_ALIGNED(len, sizeof(uint32_t))) {
 		uint32_t *p = (uint32_t *)buf;
 		len = len >> 2;
@@ -570,7 +570,7 @@ static void fsmc_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 	struct fsmc_nand_data *host  = mtd_to_fsmc(mtd);
 	int i;
 
-	if (IS_ALIGNED((uint32_t)buf, sizeof(uint32_t)) &&
+	if (IS_ALIGNED((uintptr_t)buf, sizeof(uint32_t)) &&
 			IS_ALIGNED(len, sizeof(uint32_t))) {
 		uint32_t *p = (uint32_t *)buf;
 		len = len >> 2;
-- 
2.14.1
