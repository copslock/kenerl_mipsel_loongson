Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Dec 2015 23:28:37 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:55658 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27013235AbbLGW1ESn9rg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Dec 2015 23:27:04 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 12C401A8A; Mon,  7 Dec 2015 23:26:58 +0100 (CET)
Received: from localhost.localdomain (unknown [37.160.132.173])
        by mail.free-electrons.com (Postfix) with ESMTPSA id A933B1B0A;
        Mon,  7 Dec 2015 23:26:55 +0100 (CET)
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
Subject: [PATCH 06/23] mtd: nand: kill unused ->ecclayout field in platform_nand_chip struct
Date:   Mon,  7 Dec 2015 23:26:01 +0100
Message-Id: <1449527178-5930-7-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50385
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

This field is not set in any board file and can thus be dropped.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/plat_nand.c | 1 -
 include/linux/mtd/nand.h     | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/mtd/nand/plat_nand.c b/drivers/mtd/nand/plat_nand.c
index 06ac6c6..71aaa09 100644
--- a/drivers/mtd/nand/plat_nand.c
+++ b/drivers/mtd/nand/plat_nand.c
@@ -74,7 +74,6 @@ static int plat_nand_probe(struct platform_device *pdev)
 	data->chip.bbt_options |= pdata->chip.bbt_options;
 
 	data->chip.ecc.hwctl = pdata->ctrl.hwcontrol;
-	data->chip.ecc.layout = pdata->chip.ecclayout;
 	data->chip.ecc.mode = NAND_ECC_SOFT;
 
 	platform_set_drvdata(pdev, data);
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index fad634e..cbedcb0 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -866,7 +866,6 @@ extern int nand_do_read(struct mtd_info *mtd, loff_t from, size_t len,
  * @chip_delay:		R/B delay value in us
  * @options:		Option flags, e.g. 16bit buswidth
  * @bbt_options:	BBT option flags, e.g. NAND_BBT_USE_FLASH
- * @ecclayout:		ECC layout info structure
  * @part_probe_types:	NULL-terminated array of probe types
  */
 struct platform_nand_chip {
@@ -874,7 +873,6 @@ struct platform_nand_chip {
 	int chip_offset;
 	int nr_partitions;
 	struct mtd_partition *partitions;
-	struct nand_ecclayout *ecclayout;
 	int chip_delay;
 	unsigned int options;
 	unsigned int bbt_options;
-- 
2.1.4
