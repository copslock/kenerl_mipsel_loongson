Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jul 2018 11:48:34 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:59611 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994667AbeGEJpvgfMmY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 5 Jul 2018 11:45:51 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 25FAF208B3; Thu,  5 Jul 2018 11:45:45 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-39-106.w90-88.abo.wanadoo.fr [90.88.158.106])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6A885208C4;
        Thu,  5 Jul 2018 11:45:26 +0200 (CEST)
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
        linux-wireless@vger.kernel.org
Subject: [PATCH 09/27] mtd: rawnand: brcmnand: Allow selection of this driver when COMPILE_TEST=y
Date:   Thu,  5 Jul 2018 11:45:04 +0200
Message-Id: <20180705094522.12138-10-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180705094522.12138-1-boris.brezillon@bootlin.com>
References: <20180705094522.12138-1-boris.brezillon@bootlin.com>
Return-Path: <boris.brezillon@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64661
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
compile-test this driver without having ARM, ARM64 or MIPS enabled.

We also need to add a dependency on HAS_IOMEM to make sure the driver
compiles correctly.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index d396bb69d515..b1934b415067 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -356,7 +356,8 @@ config MTD_NAND_GPMI_NAND
 
 config MTD_NAND_BRCMNAND
 	tristate "Broadcom STB NAND controller"
-	depends on ARM || ARM64 || MIPS
+	depends on ARM || ARM64 || MIPS || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  Enables the Broadcom NAND controller driver. The controller was
 	  originally designed for Set-Top Box but is used on various BCM7xxx,
-- 
2.14.1
