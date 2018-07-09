Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jul 2018 22:15:50 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:49420 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994659AbeGIUKTYMNXt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 Jul 2018 22:10:19 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2730A2090B; Mon,  9 Jul 2018 22:10:14 +0200 (CEST)
Received: from localhost.localdomain (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 63DF720913;
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
Subject: [PATCH v2 13/24] mtd: rawnand: fscm: Avoid collision on PC def when compiling for MIPS
Date:   Mon,  9 Jul 2018 22:09:34 +0200
Message-Id: <20180709200945.30116-14-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180709200945.30116-1-boris.brezillon@bootlin.com>
References: <20180709200945.30116-1-boris.brezillon@bootlin.com>
Return-Path: <boris.brezillon@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64743
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

We want to allow this driver to be selected when COMPILE_TEST=y, this
means the driver can be compiled for any arch, including MIPS. When
compiling this driver for MIPS, we end up with a collision on the 'PC'
macro definition (also defined in arch/mips/include/asm/ptrace.h).

Prefix the fsmc one with FSMC_ to avoid this problem.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/fsmc_nand.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/nand/raw/fsmc_nand.c b/drivers/mtd/nand/raw/fsmc_nand.c
index f4a5a317d4ae..d71c49f50e77 100644
--- a/drivers/mtd/nand/raw/fsmc_nand.c
+++ b/drivers/mtd/nand/raw/fsmc_nand.c
@@ -62,7 +62,7 @@
 						reg)
 
 /* fsmc controller registers for NAND flash */
-#define PC			0x00
+#define FSMC_PC			0x00
 	/* pc register definitions */
 	#define FSMC_RESET		(1 << 0)
 	#define FSMC_WAITON		(1 << 1)
@@ -273,12 +273,13 @@ static void fsmc_nand_setup(struct fsmc_nand_data *host,
 	tset = (tims->tset & FSMC_TSET_MASK) << FSMC_TSET_SHIFT;
 
 	if (host->nand.options & NAND_BUSWIDTH_16)
-		writel_relaxed(value | FSMC_DEVWID_16, host->regs_va + PC);
+		writel_relaxed(value | FSMC_DEVWID_16,
+			       host->regs_va + FSMC_PC);
 	else
-		writel_relaxed(value | FSMC_DEVWID_8, host->regs_va + PC);
+		writel_relaxed(value | FSMC_DEVWID_8, host->regs_va + FSMC_PC);
 
-	writel_relaxed(readl(host->regs_va + PC) | tclr | tar,
-		       host->regs_va + PC);
+	writel_relaxed(readl(host->regs_va + FSMC_PC) | tclr | tar,
+		       host->regs_va + FSMC_PC);
 	writel_relaxed(thiz | thold | twait | tset, host->regs_va + COMM);
 	writel_relaxed(thiz | thold | twait | tset, host->regs_va + ATTRIB);
 }
@@ -371,12 +372,12 @@ static void fsmc_enable_hwecc(struct mtd_info *mtd, int mode)
 {
 	struct fsmc_nand_data *host = mtd_to_fsmc(mtd);
 
-	writel_relaxed(readl(host->regs_va + PC) & ~FSMC_ECCPLEN_256,
-		       host->regs_va + PC);
-	writel_relaxed(readl(host->regs_va + PC) & ~FSMC_ECCEN,
-		       host->regs_va + PC);
-	writel_relaxed(readl(host->regs_va + PC) | FSMC_ECCEN,
-		       host->regs_va + PC);
+	writel_relaxed(readl(host->regs_va + FSMC_PC) & ~FSMC_ECCPLEN_256,
+		       host->regs_va + FSMC_PC);
+	writel_relaxed(readl(host->regs_va + FSMC_PC) & ~FSMC_ECCEN,
+		       host->regs_va + FSMC_PC);
+	writel_relaxed(readl(host->regs_va + FSMC_PC) | FSMC_ECCEN,
+		       host->regs_va + FSMC_PC);
 }
 
 /*
@@ -618,11 +619,11 @@ static void fsmc_select_chip(struct mtd_info *mtd, int chipnr)
 	if (chipnr > 0)
 		return;
 
-	pc = readl(host->regs_va + PC);
+	pc = readl(host->regs_va + FSMC_PC);
 	if (chipnr < 0)
-		writel_relaxed(pc & ~FSMC_ENABLE, host->regs_va + PC);
+		writel_relaxed(pc & ~FSMC_ENABLE, host->regs_va + FSMC_PC);
 	else
-		writel_relaxed(pc | FSMC_ENABLE, host->regs_va + PC);
+		writel_relaxed(pc | FSMC_ENABLE, host->regs_va + FSMC_PC);
 
 	/* nCE line must be asserted before starting any operation */
 	mb();
-- 
2.14.1
