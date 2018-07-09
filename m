Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jul 2018 22:11:03 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:49352 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993928AbeGIUKKMY5dt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 Jul 2018 22:10:10 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E485C208B3; Mon,  9 Jul 2018 22:10:04 +0200 (CEST)
Received: from localhost.localdomain (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8921E208C5;
        Mon,  9 Jul 2018 22:09:54 +0200 (CEST)
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
Subject: [PATCH v2 04/24] mtd: rawnand: s3c2410: Allow selection of this driver when COMPILE_TEST=y
Date:   Mon,  9 Jul 2018 22:09:25 +0200
Message-Id: <20180709200945.30116-5-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180709200945.30116-1-boris.brezillon@bootlin.com>
References: <20180709200945.30116-1-boris.brezillon@bootlin.com>
Return-Path: <boris.brezillon@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64725
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

It just makes NAND maintainers' life easier by allowing them to
compile-test this driver without having ARCH_S3C24XX or ARCH_S3C64XX
enabled.

We add a dependency on HAS_IOMEM to make sure the driver compiles
correctly, and a dependency on !IA64 because the {read,write}s{bwl}()
accessors are not defined for this architecture.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 1488ad0a0199..e01b3da726c0 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -119,7 +119,8 @@ config MTD_NAND_AU1550
 
 config MTD_NAND_S3C2410
 	tristate "NAND Flash support for Samsung S3C SoCs"
-	depends on ARCH_S3C24XX || ARCH_S3C64XX
+	depends on ARCH_S3C24XX || ARCH_S3C64XX || COMPILE_TEST
+	depends on HAS_IOMEM && !IA64
 	help
 	  This enables the NAND flash controller on the S3C24xx and S3C64xx
 	  SoCs
-- 
2.14.1
