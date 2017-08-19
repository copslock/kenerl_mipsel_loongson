Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Aug 2017 00:21:20 +0200 (CEST)
Received: from mx2.mailbox.org ([80.241.60.215]:33605 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994956AbdHSWT5C0-yi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 20 Aug 2017 00:19:57 +0200
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 70A284905C;
        Sun, 20 Aug 2017 00:19:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id 3-NxoDQMpmn4; Sun, 20 Aug 2017 00:19:50 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        robh@kernel.org, andy.shevchenko@gmail.com, p.zabel@pengutronix.de,
        kishon@ti.com, mark.rutland@arm.com,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v10 03/16] spi: spi-falcon: drop check of boot select
Date:   Sun, 20 Aug 2017 00:18:10 +0200
Message-Id: <20170819221823.13850-4-hauke@hauke-m.de>
In-Reply-To: <20170819221823.13850-1-hauke@hauke-m.de>
References: <20170819221823.13850-1-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59702
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

Do not check which flash type the SoC was booted from before
using this driver. Assume that the device tree is correct and use this
driver when it was added to device tree. This also removes a build
dependency to the SoC code.

All device trees I am aware of only have one correct flash device entry
in it. The device tree is anyway bundled with the kernel in all systems
using device tree I know of.

The boot mode can be specified with some pin straps and will select the
flash type the rom code will boot from. One SPI, NOR or NAND flash chip
can be connect to the EBU and used to load the first stage boot loader
from.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
---
 drivers/spi/spi-falcon.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/spi/spi-falcon.c b/drivers/spi/spi-falcon.c
index 286b2c81fc6b..f8638e82e5db 100644
--- a/drivers/spi/spi-falcon.c
+++ b/drivers/spi/spi-falcon.c
@@ -395,11 +395,6 @@ static int falcon_sflash_probe(struct platform_device *pdev)
 	struct spi_master *master;
 	int ret;
 
-	if (ltq_boot_select() != BS_SPI) {
-		dev_err(&pdev->dev, "invalid bootstrap options\n");
-		return -ENODEV;
-	}
-
 	master = spi_alloc_master(&pdev->dev, sizeof(*priv));
 	if (!master)
 		return -ENOMEM;
-- 
2.11.0
