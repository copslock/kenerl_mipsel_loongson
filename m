Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Dec 2015 23:28:03 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:55620 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27013269AbbLGW1Cdl3Cg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Dec 2015 23:27:02 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 3CABC223; Mon,  7 Dec 2015 23:26:56 +0100 (CET)
Received: from localhost.localdomain (unknown [37.160.132.173])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 9A9691B07;
        Mon,  7 Dec 2015 23:26:50 +0100 (CET)
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
        Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH 04/23] mtd: nand: s3c2410: kill the ->ecc_layout field
Date:   Mon,  7 Dec 2015 23:25:59 +0100
Message-Id: <1449527178-5930-5-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50383
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

The s3c2410 is allowing board data to overload the default ECC layout
defined inside the driver, but this feature is not used by board
specific definitions.
Kill this field so that we can easily move to a model where ecclayout
are dynamically allocated by the NAND controller driver.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/plat-samsung/devs.c                   | 9 ---------
 drivers/mtd/nand/s3c2410.c                     | 3 ---
 include/linux/platform_data/mtd-nand-s3c2410.h | 1 -
 3 files changed, 13 deletions(-)

diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index 8207462..a903ee8 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -710,15 +710,6 @@ static int __init s3c_nand_copy_set(struct s3c2410_nand_set *set)
 			return -ENOMEM;
 	}
 
-	if (set->ecc_layout) {
-		ptr = kmemdup(set->ecc_layout,
-			      sizeof(struct nand_ecclayout), GFP_KERNEL);
-		set->ecc_layout = ptr;
-
-		if (!ptr)
-			return -ENOMEM;
-	}
-
 	return 0;
 }
 
diff --git a/drivers/mtd/nand/s3c2410.c b/drivers/mtd/nand/s3c2410.c
index 05105ca..b569200 100644
--- a/drivers/mtd/nand/s3c2410.c
+++ b/drivers/mtd/nand/s3c2410.c
@@ -860,9 +860,6 @@ static void s3c2410_nand_init_chip(struct s3c2410_nand_info *info,
 	chip->ecc.mode	    = NAND_ECC_SOFT;
 #endif
 
-	if (set->ecc_layout != NULL)
-		chip->ecc.layout = set->ecc_layout;
-
 	if (set->disable_ecc)
 		chip->ecc.mode	= NAND_ECC_NONE;
 
diff --git a/include/linux/platform_data/mtd-nand-s3c2410.h b/include/linux/platform_data/mtd-nand-s3c2410.h
index 36bb921..c55e42ee 100644
--- a/include/linux/platform_data/mtd-nand-s3c2410.h
+++ b/include/linux/platform_data/mtd-nand-s3c2410.h
@@ -40,7 +40,6 @@ struct s3c2410_nand_set {
 	char			*name;
 	int			*nr_map;
 	struct mtd_partition	*partitions;
-	struct nand_ecclayout	*ecc_layout;
 };
 
 struct s3c2410_platform_nand {
-- 
2.1.4
