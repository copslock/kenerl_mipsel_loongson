Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jul 2018 22:13:55 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:49389 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993997AbeGIUKPYMNXt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 Jul 2018 22:10:15 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 34C6A208FD; Mon,  9 Jul 2018 22:10:06 +0200 (CEST)
Received: from localhost.localdomain (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id CB69520012;
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
Subject: [PATCH v2 08/24] mtd: rawnand: davinci: Use uintptr_t casts instead of unsigned ones
Date:   Mon,  9 Jul 2018 22:09:29 +0200
Message-Id: <20180709200945.30116-9-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180709200945.30116-1-boris.brezillon@bootlin.com>
References: <20180709200945.30116-1-boris.brezillon@bootlin.com>
Return-Path: <boris.brezillon@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64736
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

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/davinci_nand.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/davinci_nand.c
index 9cd36a750965..e79ed0f60ade 100644
--- a/drivers/mtd/nand/raw/davinci_nand.c
+++ b/drivers/mtd/nand/raw/davinci_nand.c
@@ -318,7 +318,7 @@ static int nand_davinci_correct_4bit(struct mtd_info *mtd,
 	/* Unpack ten bytes into eight 10 bit values.  We know we're
 	 * little-endian, and use type punning for less shifting/masking.
 	 */
-	if (WARN_ON(0x01 & (unsigned) ecc_code))
+	if (WARN_ON(0x01 & (uintptr_t)ecc_code))
 		return -EINVAL;
 	ecc16 = (unsigned short *)ecc_code;
 
@@ -440,9 +440,9 @@ static void nand_davinci_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
 
-	if ((0x03 & ((unsigned)buf)) == 0 && (0x03 & len) == 0)
+	if ((0x03 & ((uintptr_t)buf)) == 0 && (0x03 & len) == 0)
 		ioread32_rep(chip->IO_ADDR_R, buf, len >> 2);
-	else if ((0x01 & ((unsigned)buf)) == 0 && (0x01 & len) == 0)
+	else if ((0x01 & ((uintptr_t)buf)) == 0 && (0x01 & len) == 0)
 		ioread16_rep(chip->IO_ADDR_R, buf, len >> 1);
 	else
 		ioread8_rep(chip->IO_ADDR_R, buf, len);
@@ -453,9 +453,9 @@ static void nand_davinci_write_buf(struct mtd_info *mtd,
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
 
-	if ((0x03 & ((unsigned)buf)) == 0 && (0x03 & len) == 0)
+	if ((0x03 & ((uintptr_t)buf)) == 0 && (0x03 & len) == 0)
 		iowrite32_rep(chip->IO_ADDR_R, buf, len >> 2);
-	else if ((0x01 & ((unsigned)buf)) == 0 && (0x01 & len) == 0)
+	else if ((0x01 & ((uintptr_t)buf)) == 0 && (0x01 & len) == 0)
 		iowrite16_rep(chip->IO_ADDR_R, buf, len >> 1);
 	else
 		iowrite8_rep(chip->IO_ADDR_R, buf, len);
-- 
2.14.1
