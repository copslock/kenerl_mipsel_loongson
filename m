Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jun 2018 19:19:13 +0200 (CEST)
Received: from nbd.name ([IPv6:2a01:4f8:221:3d45::2]:58088 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992966AbeFYRSbX4Zjw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Jun 2018 19:18:31 +0200
From:   John Crispin <john@phrozen.org>
To:     Mark Brown <broonie@kernel.org>, James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <john@phrozen.org>,
        linux-spi@vger.kernel.org
Subject: [PATCH] spi: ath79: drop pdata support
Date:   Mon, 25 Jun 2018 19:18:23 +0200
Message-Id: <20180625171823.4782-1-john@phrozen.org>
X-Mailer: git-send-email 2.11.0
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64438
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

The target is being converted to pure OF. We can therefore drop all of the
platform data code from the driver.

Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
Signed-off-by: John Crispin <john@phrozen.org>
---
Hi Mark,
Once Acked, this patch should ideally go upstream via the mips tree to
avoid merge order conflicts with the series converting the target to OF.
	John

 arch/mips/include/asm/mach-ath79/ath79_spi_platform.h | 19 -------------------
 drivers/spi/spi-ath79.c                               |  8 --------
 2 files changed, 27 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-ath79/ath79_spi_platform.h

diff --git a/arch/mips/include/asm/mach-ath79/ath79_spi_platform.h b/arch/mips/include/asm/mach-ath79/ath79_spi_platform.h
deleted file mode 100644
index aa71216edf99..000000000000
--- a/arch/mips/include/asm/mach-ath79/ath79_spi_platform.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- *  Platform data definition for Atheros AR71XX/AR724X/AR913X SPI controller
- *
- *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- */
-
-#ifndef _ATH79_SPI_PLATFORM_H
-#define _ATH79_SPI_PLATFORM_H
-
-struct ath79_spi_platform_data {
-	unsigned	bus_num;
-	unsigned	num_chipselect;
-};
-
-#endif /* _ATH79_SPI_PLATFORM_H */
diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index 0719bd484891..6eb7255558df 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -26,7 +26,6 @@
 #include <linux/err.h>
 
 #include <asm/mach-ath79/ar71xx_regs.h>
-#include <asm/mach-ath79/ath79_spi_platform.h>
 
 #define DRV_NAME	"ath79-spi"
 
@@ -208,7 +207,6 @@ static int ath79_spi_probe(struct platform_device *pdev)
 {
 	struct spi_master *master;
 	struct ath79_spi *sp;
-	struct ath79_spi_platform_data *pdata;
 	struct resource	*r;
 	unsigned long rate;
 	int ret;
@@ -223,15 +221,9 @@ static int ath79_spi_probe(struct platform_device *pdev)
 	master->dev.of_node = pdev->dev.of_node;
 	platform_set_drvdata(pdev, sp);
 
-	pdata = dev_get_platdata(&pdev->dev);
-
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
 	master->setup = ath79_spi_setup;
 	master->cleanup = ath79_spi_cleanup;
-	if (pdata) {
-		master->bus_num = pdata->bus_num;
-		master->num_chipselect = pdata->num_chipselect;
-	}
 
 	sp->bitbang.master = master;
 	sp->bitbang.chipselect = ath79_spi_chipselect;
-- 
2.11.0
