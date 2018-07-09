Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jul 2018 22:15:15 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:49408 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994572AbeGIUKTDkIyt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 Jul 2018 22:10:19 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CC5332097A; Mon,  9 Jul 2018 22:10:13 +0200 (CEST)
Received: from localhost.localdomain (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 73D0D20904;
        Mon,  9 Jul 2018 22:09:56 +0200 (CEST)
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
Subject: [PATCH v2 10/24] mtd: rawnand: sunxi: Add an U suffix to NFC_PAGE_OP definition
Date:   Mon,  9 Jul 2018 22:09:31 +0200
Message-Id: <20180709200945.30116-11-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180709200945.30116-1-boris.brezillon@bootlin.com>
References: <20180709200945.30116-1-boris.brezillon@bootlin.com>
Return-Path: <boris.brezillon@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64741
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

Fixes the "warning: large integer implicitly truncated to unsigned type
[-Woverflow]" warning when compiled for x86.

This is needed in order to allow compiling this driver when
COMPILE_TEST=y.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index d831a141a196..99043c3a4fa7 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -127,7 +127,7 @@
 #define NFC_CMD_TYPE_MSK	GENMASK(31, 30)
 #define NFC_NORMAL_OP		(0 << 30)
 #define NFC_ECC_OP		(1 << 30)
-#define NFC_PAGE_OP		(2 << 30)
+#define NFC_PAGE_OP		(2U << 30)
 
 /* define bit use in NFC_RCMD_SET */
 #define NFC_READ_CMD_MSK	GENMASK(7, 0)
-- 
2.14.1
