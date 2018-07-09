Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jul 2018 22:11:17 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:49332 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993885AbeGIUKKKH8Lt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 Jul 2018 22:10:10 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 49F2A20875; Mon,  9 Jul 2018 22:10:04 +0200 (CEST)
Received: from localhost.localdomain (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id E7A6E20876;
        Mon,  9 Jul 2018 22:09:53 +0200 (CEST)
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
Subject: [PATCH v2 02/24] mtd: rawnand: atmel: Add an __iomem cast on gen_pool_dma_alloc() call
Date:   Mon,  9 Jul 2018 22:09:23 +0200
Message-Id: <20180709200945.30116-3-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180709200945.30116-1-boris.brezillon@bootlin.com>
References: <20180709200945.30116-1-boris.brezillon@bootlin.com>
Return-Path: <boris.brezillon@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64726
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

gen_pool_dma_alloc() return type is void *, while internally, the
memory region exposed by the sram driver has been mapped with
ioremap().

Add a void * to void __iomem * cast to make sparse happy.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/atmel/nand-controller.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index e8f7549d0354..30dae4c9d439 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -2219,9 +2219,9 @@ atmel_hsmc_nand_controller_init(struct atmel_hsmc_nand_controller *nc)
 		return -ENOMEM;
 	}
 
-	nc->sram.virt = gen_pool_dma_alloc(nc->sram.pool,
-					    ATMEL_NFC_SRAM_SIZE,
-					    &nc->sram.dma);
+	nc->sram.virt = (void __iomem *)gen_pool_dma_alloc(nc->sram.pool,
+							   ATMEL_NFC_SRAM_SIZE,
+							   &nc->sram.dma);
 	if (!nc->sram.virt) {
 		dev_err(nc->base.dev,
 			"Could not allocate memory from the NFC SRAM pool\n");
-- 
2.14.1
