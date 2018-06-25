From: John Crispin <john@phrozen.org>
Date: Mon, 25 Jun 2018 19:18:23 +0200
Subject: [PATCH] spi: ath79: drop pdata support
Message-ID: <20180625171823.XXppOEhmpI1CAMn6a2GcOGWB3zmn9_AWWRSLWOS-QB8@z>

The target is being converted to pure OF. We can therefore drop all of the
platform data code from the driver.

Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../asm/mach-ath79/ath79_spi_platform.h       | 19 -------------------
 drivers/spi/spi-ath79.c                       |  8 --------
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
2.17.1
