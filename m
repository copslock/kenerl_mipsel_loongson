Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jul 2018 14:25:23 +0200 (CEST)
Received: from nbd.name ([IPv6:2a01:4f8:221:3d45::2]:47154 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993577AbeGTMYDToSiZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 Jul 2018 14:24:03 +0200
From:   John Crispin <john@phrozen.org>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <john@phrozen.org>,
        linux-spi@vger.kernel.org
Subject: [PATCH V2 25/25] spi: ath79: drop pdata support
Date:   Fri, 20 Jul 2018 13:58:42 +0200
Message-Id: <20180720115842.8406-26-john@phrozen.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180720115842.8406-1-john@phrozen.org>
References: <20180720115842.8406-1-john@phrozen.org>
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64975
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

Cc: linux-spi@vger.kernel.org
Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: John Crispin <john@phrozen.org>
---
Hi Mark,
This patch must go upstream via the mips tree because of a build
dependency on the rest of the series.
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
