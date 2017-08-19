From: Hauke Mehrtens <hauke@hauke-m.de>
Date: Sun, 20 Aug 2017 00:18:10 +0200
Subject: [PATCH] spi: spi-falcon: drop check of boot select
Message-ID: <20170819221810.xBPiRFikXQh_3HGP_0MtPYk4GJeyVyO4CMpypBOjtyw@z>

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
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.14.1
